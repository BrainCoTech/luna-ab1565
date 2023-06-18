#include "music_file_receiver.h"

#include <stdbool.h>
#include <stdint.h>

#include "FreeRTOS.h"
#include "timers.h"
#include "app_bt/app_bt_msg_helper.h"
#include "morpheus.h"
#include "music_file.h"
#include "music_solution.h"
#include "nvdm.h"
#include "nvdm_id_list.h"
#include "semphr.h"
#include "stdlib.h"
#include "string.h"
#include "syslog.h"
#include "main_controller.h"
#include "filesystem.h"

log_create_module(MUSIC_RECV, PRINT_LEVEL_INFO);

#define READY_RECV_FILE_NUMS MAX_MUSIC_FILE_NUMS
#define RECV_DATA_QUEUE_SIZE 32
typedef enum {
    FILE_RECV_STATE_IDLE = 0,  // 空闲，等待更新文件
    FILE_RECV_STATE_START,  // 收到接收新文件消息，更新ready_recv_files
    FILE_RECV_STATE_CANCEL,    // 取消当前任务
    FILE_RECV_STATE_RUNNING,   // 接收中
    FILE_RECV_STATE_FINISHED,  // 同步完成
} file_reciever_state_t;

typedef struct {
    uint32_t new_nums;
    recv_file_t new_files[MAX_MUSIC_FILE_NUMS];
    uint32_t cur_nums;
    recv_file_t cur_files[MAX_MUSIC_FILE_NUMS];
    uint32_t cur_index;
    file_reciever_state_t cur_state;
    bool sync;
} file_reciever_t;

typedef struct {
    uint32_t fd;
    uint32_t size;
    uint8_t *data;
    bool append;
} recv_data_t;


static file_reciever_t m_reciever;
static recv_file_t *m_receiving_file;
static music_sulotion_t *p_solution;
static music_files_t m_files;

static bool read_dir_busy;
static bool xfer_start;

SemaphoreHandle_t recv_file_finished_sem;
QueueHandle_t recv_data_queue;

#define XFER_TIMER_NAME        "xfer"
#define XFER_TIMER_ID          0
#define XFER_TIMER_INTERVAL    (10 * 1000)
#define XFER_RETRY_TIMEOUT     6 // XFER_RETRY_TIMEOUT * XFER_TIMER_INTERVAL = 60s
#define USE_QUEUE 1

TimerHandle_t m_timer = NULL; /* The pointer of the m_timer instance. */

lfs_file_t file;

static int request_file_data(uint32_t id, uint32_t offset);
static int retry_req_data_count = 0;
static void timer_cb_function(TimerHandle_t xTimer)
{
    LOG_MSGID_I(MUSIC_RECV, "receive data timeout", 0);
    retry_req_data_count++;
    request_file_data(m_receiving_file->fd, m_receiving_file->offset);
    if (retry_req_data_count > XFER_RETRY_TIMEOUT) {
        xSemaphoreGive(recv_file_finished_sem);
        if (m_timer) {
            xTimerStop(m_timer, 0);
        }
        retry_req_data_count = 0;
    }
}

static int request_file_data(uint32_t id, uint32_t offset) {
    BtApp msg = BT_APP__INIT;
    GetMusicData get_music_data = GET_MUSIC_DATA__INIT;
    get_music_data.id = id;
    get_music_data.offset = offset;
    msg.get_music_data = &get_music_data;

    send_msg_to_app(&msg);
    return 0;
}

int sulotion_file_index_get(uint32_t fd, music_sulotion_t *solution) {
    for (int i = 0; i < solution->nums; i++) {
        if (fd == solution->files[i].fd) {
            return i;
        }
    }
    return -1;
}

void receive_file_start(recv_file_t *recv_file) {
    m_receiving_file = recv_file;
    LOG_MSGID_I(MUSIC_RECV, "start recv fd %u, offset %u ", 2,
                m_receiving_file->fd, m_receiving_file->offset);
    request_file_data(m_receiving_file->fd, m_receiving_file->offset);

    if (m_timer) {
        xTimerStop(m_timer, 0);
        xTimerStart(m_timer, 0);
    }
}

void receive_file_wait_finished(void) {
#if (USE_QUEUE)
    recv_data_t recv_data;  
    int ret = 0;
    while(1) {
        if (xQueueReceive(recv_data_queue, &recv_data, 300) == pdTRUE)
        {
            ret = music_file_file_size(recv_data.fd);
            if (ret < m_receiving_file->size){
                ret = music_file_write(recv_data.fd, recv_data.data, recv_data.size, recv_data.append);
                if (ret != recv_data.size)
                    LOG_MSGID_I(MUSIC_RECV, "write file error: %d", 1, ret);
            } else {
                LOG_MSGID_I(MUSIC_RECV, "write file error, bigger than size, file size %d", 1, ret);
            }
            vPortFree(recv_data.data);
        }
        if (xSemaphoreTake(recv_file_finished_sem, 20) == pdTRUE) {
            break;
        }
    }
#else
    xSemaphoreTake(recv_file_finished_sem, portMAX_DELAY);
#endif

}


void receive_file_append_data(uint32_t fd, void *data, uint32_t size,
                              uint32_t offset, bool done) {
    if (m_receiving_file == NULL) return;
    recv_data_t recv_data;

    if (m_timer) {
        xTimerStop(m_timer, 0);
        xTimerStart(m_timer, 0);
    }
    
    // 先确保数据是准确的
    if ((m_receiving_file->fd == fd) && (m_receiving_file->offset == offset)) {
        bool append = (offset > 0);

#if (USE_QUEUE)
        uint32_t  heap_size = xPortGetFreeHeapSize();
        // LOG_MSGID_I(MUSIC_RECV, "try to alloc, heap size %d", 1, heap_size);
        if (heap_size < 20480)
            vTaskDelay(50);
        if (heap_size < 10240)
            vTaskDelay(200);    
        recv_data.size = size;
        recv_data.fd = fd;
        recv_data.append = (offset > 0) ? true : false;
        recv_data.data = pvPortMalloc(size);
        if (recv_data.data) {
            memcpy(recv_data.data, data, size);
            if (xQueueSend(recv_data_queue, &recv_data, 30) != pdTRUE) {
                LOG_MSGID_I(MUSIC_RECV, "append failed", 0);
                vPortFree(recv_data.data);
            } else {
                m_receiving_file->offset += size;
            }
        }else{
             LOG_MSGID_I(MUSIC_RECV, "alloc failed", 0);
        }        
#else
#if (NOT_CLOSE)
        if (offset == 0)
            file_open(fd, true, &file);
        
        file_write(&file, data, size);
#endif
        music_file_write(fd, data, size, append);
        m_receiving_file->offset += size;
#endif
        

        if (done) {
#if (NOT_CLOSE)            
            file_close(fd, &file);
#endif            
            LOG_MSGID_I(MUSIC_RECV, "music transfer done. size: %d ", 1,
                        m_receiving_file->offset);
            xSemaphoreGive(recv_file_finished_sem);
            return;
        }
    
        request_file_data(m_receiving_file->fd, m_receiving_file->offset); 
    }
}

void send_sync_progress_to_app(uint32_t msgid) {
    BtApp msg = BT_APP__INIT;
    msg.msg_id = msgid;

    int count = 0;
    while (read_dir_busy) {
        vTaskDelay(5);
        count++;
        if (count > 400)
            break;
    }
    msg.n_music_sync_progress = p_solution->nums;
    LOG_MSGID_I(MUSIC_RECV, "sulotion. nums: %d", 1, p_solution->nums);
    MusicSyncProgress **sync_process;
    if (msg.n_music_sync_progress > 0) {
        sync_process = pvPortMalloc(sizeof(MusicSyncProgress *) * p_solution->nums);
        msg.music_sync_progress = sync_process;
        if (sync_process == NULL)
            LOG_MSGID_I(MUSIC_RECV, "sycn progress ** alloc failed", 0);
        for (int i = 0; i < p_solution->nums; i++) {
            sync_process[i] = pvPortMalloc(sizeof(MusicSyncProgress));
            music_sync_progress__init(sync_process[i]);
            sync_process[i]->id = p_solution->files[i].fd;
            sync_process[i]->offset = p_solution->files[i].offset;
            sync_process[i]->finished = (sync_process[i]->offset == p_solution->files[i].size) ? true : false;
            LOG_MSGID_I(MUSIC_RECV, "sycn progress. offset %u, size %u, finished %d", 3, sync_process[i]->offset, p_solution->files[i].size, sync_process[i]->finished);   
            LOG_MSGID_I(MUSIC_RECV, "sycn progress. stack size %u", 1, uxTaskGetStackHighWaterMark(NULL)); 
        }
    }

    send_msg_to_app(&msg);

    if (msg.n_music_sync_progress > 0) {
        vPortFree(sync_process);
        for (int i = 0; i < p_solution->nums; i++) vPortFree(sync_process[i]);
    }
}


void update_solution_offset_from_files(music_sulotion_t *sulotion, music_files_t *files)
{
    bool should_delete = true;
    read_dir_busy = true;
    music_file_files_get(files);
    for (int i = 0; i < files->nums; i++) {
        LOG_MSGID_I(MUSIC_RECV, "music file in nor flash, file [%u], size %u",
                    3, files->files[i].fd, files->files[i].size);
    }

    for (int i = 0; i < files->nums; i++) {
        should_delete = true;
        for (int n = 0; n < p_solution->nums; n++) {
            if (files->files[i].fd == p_solution->files[n].fd) {
                should_delete = false;
                p_solution->files[n].offset = files->files[i].size;
                LOG_MSGID_I(MUSIC_RECV, "solution file %u, file size %u, index %d", 3, p_solution->files[n].size, n);
            }
        }
        if (should_delete) {
            LOG_MSGID_I(MUSIC_RECV, "delete file %u", 1, files->files[i].fd);
            music_file_delete(files->files[i].fd);
        }
    }
    solution_write_to_nvdm(p_solution);
    read_dir_busy = false;
}

void file_receiver_task(void) {
#if (USE_QUEUE)
    recv_data_queue = xQueueCreate(RECV_DATA_QUEUE_SIZE, sizeof(recv_data_t));
#endif
    recv_file_finished_sem = xSemaphoreCreateBinary();


    m_timer = xTimerCreate(XFER_TIMER_NAME, XFER_TIMER_INTERVAL / portTICK_PERIOD_MS, pdTRUE, XFER_TIMER_ID, timer_cb_function);

    recv_file_t receiving_file;

    bool resume_sync = true;
    bool should_delete;
    
    const recv_file_t *cur_files = m_reciever.cur_files;
    const recv_file_t *new_files = m_reciever.new_files;
    recv_file_t *cur_file;
    

    music_file_init();    
    nvdm_status_t status = solution_read_from_nvdm(&p_solution);
    if (status == NVDM_STATUS_ITEM_NOT_FOUND) {
        music_file_files_get(&m_files);
        LOG_MSGID_I(MUSIC_RECV, "solution file not found, file nums %d", 1, m_files.nums);
        for (int i = 0; i < m_files.nums; i++) {
            p_solution->files[i].fd = m_files.files[i].fd;
            p_solution->files[i].offset = m_files.files[i].size;
            p_solution->files[i].size = m_files.files[i].size;              
                LOG_MSGID_I(MUSIC_RECV, "solution file not found, file size %u, index %d", 3, p_solution->files[i].size, i);
        }
        p_solution->nums = m_files.nums;
        solution_write_to_nvdm(p_solution);
    }
    if (status == NVDM_STATUS_OK) {
        update_solution_offset_from_files(p_solution, &m_files);
    }

    music_sulotion_t old_solution;
    

    while (1) {
        switch (m_reciever.cur_state) {
            case FILE_RECV_STATE_IDLE:
                if (m_reciever.new_nums) {
                    m_reciever.cur_state = FILE_RECV_STATE_START;
                    /* should stop play local music when transfer music file */
                    app_local_music_pause();
                    xfer_start = true;
                    main_controller_set_state(SYS_CONFIG__STATE__OTA_STARTED);
                } else {
                    if (xfer_start) {
                        if (m_timer) {
                            xTimerStop(m_timer, 0);
                        } 
                        main_controller_set_state(SYS_CONFIG__STATE__OTA_FINISHED);
                    }
                    xfer_start = false;
                    vTaskDelay(2000);
                }
                break;

            case FILE_RECV_STATE_START:
                LOG_MSGID_I(MUSIC_RECV, "FILE_RECV_STATE_START", 0);
                read_dir_busy = true;
                /* update solution from new configuration */
                memcpy(&old_solution, p_solution, sizeof(music_sulotion_t));
                p_solution->nums = m_reciever.new_nums;
                for (int i = 0; i < m_reciever.new_nums; i++) {
                    p_solution->files[i].fd = new_files[i].fd;
                    p_solution->files[i].size = new_files[i].size;
                    int id = sulotion_file_index_get(new_files[i].fd, &old_solution);
                    if (id >= 0)
                        p_solution->files[i].offset = old_solution.files[id].offset;
                    else
                        p_solution->files[i].offset = 0;

                    LOG_MSGID_I(MUSIC_RECV, "file %u,size %u", 2,
                        p_solution->files[i].fd,
                        p_solution->files[i].size);                    
                }
                read_dir_busy = false;
                /* update solution from files */
                update_solution_offset_from_files(p_solution, &m_files);

                memcpy(cur_files, new_files, sizeof(m_reciever.cur_files));
                m_reciever.cur_nums = m_reciever.new_nums;
                m_reciever.cur_index = 0;
                m_reciever.new_nums = 0;
                m_reciever.sync = true;
                memset(new_files, 0, sizeof(m_reciever.new_files));
                m_reciever.cur_state = FILE_RECV_STATE_RUNNING;
                break;

            case FILE_RECV_STATE_RUNNING:
                while ((m_reciever.cur_index < m_reciever.cur_nums) && m_reciever.sync) {
                    if (m_reciever.new_nums) {
                        break;
                    }
                    cur_file = &cur_files[m_reciever.cur_index];
                    LOG_MSGID_I(MUSIC_RECV, "index %d, fd %u", 3,
                                m_reciever.cur_index, cur_file->fd);
                    
                    int file_size = music_file_file_size(cur_file->fd);

                    cur_file->offset = (file_size < 0) ? 0 : file_size;
                    LOG_MSGID_I(MUSIC_RECV, "cur fd %u, size %u, offset %u ", 3,
                                cur_file->fd, cur_file->size, cur_file->offset);
                    if (cur_file->offset > cur_file->size) {
                        music_file_delete(cur_file->fd);
                        cur_file->offset = 0;
                        receive_file_start(cur_file);
                        receive_file_wait_finished();
                    } else if (cur_file->offset < cur_file->size) {
                        receive_file_start(cur_file);
                        receive_file_wait_finished();
                    }

                    read_dir_busy = true;
                    if (m_reciever.new_nums == 0) {
                        int id = sulotion_file_index_get(cur_file->fd, p_solution);
                        if (id >= 0) {
                            p_solution->files[id].offset = cur_file->offset;
                        }

                        solution_write_to_nvdm(p_solution);

                        m_reciever.cur_index++;
                        LOG_MSGID_I(MUSIC_RECV, "one_finished nums %d index %d",
                                    2, m_reciever.cur_nums,
                                    m_reciever.cur_index);
                    }
                    read_dir_busy = false;
                }
                m_reciever.cur_state = FILE_RECV_STATE_IDLE;
                break;

            case FILE_RECV_STATE_CANCEL:
                break;

            case FILE_RECV_STATE_FINISHED:
                LOG_MSGID_I(MUSIC_RECV, "FILE_RECV_STATE_IDLE", 0);
                m_reciever.cur_state = FILE_RECV_STATE_IDLE;
                break;
            default:
                break;
        }
    }

    if (!main_controller_ble_status()) resume_sync = true;
}

void music_config_handler(uint32_t msg_id, MusicSync *music_sync) {
    LOG_MSGID_I(MUSIC_RECV, "music_config_handler %d", 1,
                music_sync->n_music_ids);

    if (music_sync->n_music_ids) {
        m_reciever.new_nums = music_sync->n_music_ids;
        for (int i = 0; i < music_sync->n_music_ids; i++) {
            m_reciever.new_files[i].fd = music_sync->music_ids[i];
            m_reciever.new_files[i].size = music_sync->music_file_size[i];
            m_reciever.new_files[i].offset = 0;
            LOG_MSGID_I(MUSIC_RECV, "new solution: fd %u, size %u, offset %u ", 3,
                                m_reciever.new_files[i].fd, m_reciever.new_files[i].size, m_reciever.new_files[i].offset);
        }

        ble_us_update_connection_interval();
        if (m_reciever.cur_state == FILE_RECV_STATE_RUNNING) {
            xQueueReset(recv_data_queue);
            xSemaphoreGive(recv_file_finished_sem);
        }  
    }
}

#define DATA_RATE_CAL_DURATION 20

static void calculate_data_rate(uint32_t len) {
    static uint32_t old_ts;
    uint32_t new_ts;
    static uint32_t count = 0;
    uint32_t data_rate = 0;

    if (count == 0) old_ts = xTaskGetTickCount();

    count++;
    if (count == DATA_RATE_CAL_DURATION) {
        count = 0;
        new_ts = xTaskGetTickCount();
        data_rate = DATA_RATE_CAL_DURATION * len * 1000 / (new_ts - old_ts);
        LOG_MSGID_I(MUSIC_RECV, "data rate %d. data len %d", 2, data_rate, len);
    }
}

void music_data_handler(uint32_t msg_id, MusicData *music_data) {
    if(!m_reciever.sync)
        return;
    uint32_t tick = xTaskGetTickCount();
    static old_tick = 0;
    calculate_data_rate(music_data->data.len);

    receive_file_append_data(music_data->id, music_data->data.data,
                             music_data->data.len, music_data->offset,
                             music_data->done);
    
    ble_us_update_connection_interval();                            
    uint32_t ts = xTaskGetTickCount();
    LOG_MSGID_I(MUSIC_RECV, "musig data handler speed time %d, two handler %d", 2, ts - tick, ts - old_tick);   

    old_tick = ts;                          
}

void music_solution_handler(uint32_t msg_id, MusicSolution *music_solution)
{
    p_solution->mode = music_solution->play_mode;
    p_solution->single_id = music_solution->music_single_loop_id;
}

bool music_file_receiver_is_xfer(void) {
    return xfer_start;
}

void music_pause_sync(void)
{
    if (m_reciever.cur_state == FILE_RECV_STATE_RUNNING) {
        xSemaphoreGive(recv_file_finished_sem);
        m_reciever.sync = false;
    }     

}