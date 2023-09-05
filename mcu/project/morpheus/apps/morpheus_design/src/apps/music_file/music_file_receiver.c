#include "music_file_receiver.h"

#include <stdbool.h>
#include <stdint.h>

#include "FreeRTOS.h"
#include "app_bt/app_bt_msg_helper.h"
#include "bsp_external_flash_config.h"
#include "bsp_flash.h"
#include "filesystem.h"
#include "main_controller.h"
#include "morpheus.h"
#include "music_file.h"
#include "music_solution.h"
#include "nvdm.h"
#include "nvdm_id_list.h"
#include "semphr.h"
#include "stdlib.h"
#include "string.h"
#include "syslog.h"
#include "timers.h"

log_create_module(MUSIC_RECV, PRINT_LEVEL_INFO);

#define RECV_DATA_QUEUE_SIZE 32
typedef enum {
    FILE_RECV_STATE_IDLE = 0,  // 空闲，等待更新文件
    FILE_RECV_STATE_STARTED,  // 收到接收新文件消息，更新ready_recv_files
    FILE_RECV_STATE_DOWNLOADING,  // 接收中
    FILE_RECV_STATE_PAUSED,       // 接收中
    FILE_RECV_STATE_FINISHED,     // 同步完成
} file_reciever_state_t;

/* 固定4个方案，方案对应的音乐文件可以没有
   方案ID对应音乐ID, 方案ID就是ID数组中的下标

   60MB Nor Flash 内存，等分成6份10MB区域， 默认有4个区域存储了大约5MB的歌曲。
   方案ID和音乐对应数据结构：
   方案id 对应 音乐文件ID，文件大小，6等分区域物理地址和当前保存多少字节了。
   typedef struct {
        uint32_t solution_id;
        uint32_t music_id;
        uint32_t music_file_addr;
        uint32_t music_size;
        uint32_t music_offset;
   } recv_file_t;

   typedef struct {
        recv_file_t files[4]; // 如果值是0，表示没有传输文件
   } solution_t;

   如何找到SWAP区域： 遍历 solution 中的地址

   IDLE  -- 队列  支持连续传输和清除传输  多个recv_file_t msgq
   开始           查找新区域，
   请求数据
   写入(固定位置)+保存断点(littlefs)
   更新方案       更新 solution_t
   暂停传输       FW 端暂停传输：开始播放本地音乐；恢复： 本地方案结束

   音乐播放：读取内存中的 solution_t , 开始播放
   刚更新完新文件，点击本地方案，这个时候需要播放新歌
   单例模型，获取指针

状态：
    IDLE          等待开始
    START         比对信息,断点；查找新区域，写入
    DOWNLOADING   请求数据
    PAUSEED       暂停传输
    FINISHED      更新方案

如何继续断点续传
场景1
APP 获取同步状态
FW  返回同步状态
APP 根据同步状态，发起方案设置
FW  重新获取断点以后的数据
场景2  TBD
FW  满足条件后，自动获取数据



   音乐播放接口从方案信息中获取音乐ID,
如果对应方案没有音乐ID,则播放“需要同步音乐” */

typedef struct {
    uint32_t addr;
    uint32_t size;
} partition_t;

static partition_t music_partitions[] = {
    {.addr = SPI_SERIAL_FLASH_ADDRESS + 0x400000, .size = 0xA00000},
    {.addr = SPI_SERIAL_FLASH_ADDRESS + 0xE00000, .size = 0xA00000},
    {.addr = SPI_SERIAL_FLASH_ADDRESS + 0x1800000, .size = 0xA00000},
    {.addr = SPI_SERIAL_FLASH_ADDRESS + 0x2200000, .size = 0xA00000},
    {.addr = SPI_SERIAL_FLASH_ADDRESS + 0x2C00000, .size = 0xA00000},
    {.addr = SPI_SERIAL_FLASH_ADDRESS + 0x3600000, .size = 0xA00000},
};

#define BLOCK_SIZE (64 * 1024)
typedef struct {
    xQueueHandle new_file_queue;
    xQueueHandle new_data_queue;
    file_reciever_state_t cur_state;
    recv_file_t *cur_recv_file;
    recv_file_t *sync_status;
    music_sulotion_t *p_solution;
    uint8_t event;
} file_reciever_t;

typedef struct {
    uint32_t id;
    uint32_t size;
    uint32_t offset;
    uint8_t *data;
} recv_data_t;

static file_reciever_t m_reciever;

static int request_file_data(uint32_t id, uint32_t offset);

static int request_file_data(uint32_t id, uint32_t offset) {
    BtApp msg = BT_APP__INIT;
    GetMusicData get_music_data = GET_MUSIC_DATA__INIT;

    get_music_data.id = id;
    get_music_data.offset = offset;
    msg.get_music_data = &get_music_data;

    send_msg_to_app(&msg);
    return 0;
}

void receive_file_append_data(uint32_t id, void *data, uint32_t size,
                              uint32_t offset) {
    recv_data_t recv_data;

    if (size == 0) {
        return;
    }

    uint32_t heap_size = xPortGetFreeHeapSize();
    if (heap_size < 5120) vTaskDelay(50);
    recv_data.size = size;
    recv_data.id = id;
    recv_data.offset = offset;
    recv_data.data = pvPortMalloc(size);
    if (recv_data.data) {
        memcpy(recv_data.data, data, size);
        if (xQueueSend(m_reciever.new_data_queue, &recv_data, 30) != pdTRUE) {
            LOG_MSGID_I(MUSIC_RECV, "append failed", 0);
            vPortFree(recv_data.data);
        }
    } else {
        LOG_MSGID_I(MUSIC_RECV, "alloc failed", 0);
    }
}

void send_sync_progress_to_app(uint32_t msgid) {
    BtApp msg = BT_APP__INIT;
    msg.msg_id = msgid;

    if (m_reciever.cur_recv_file->music_size >
        m_reciever.cur_recv_file->music_offset) {
        msg.n_music_sync_progress = 1;
    } else {
        msg.n_music_sync_progress = 0;
    }

    MusicSyncProgress **sync_process;
    if (msg.n_music_sync_progress > 0) {
        sync_process = pvPortMalloc(sizeof(MusicSyncProgress *) *
                                    msg.n_music_sync_progress);
        msg.music_sync_progress = sync_process;
        if (sync_process == NULL)
            LOG_MSGID_I(MUSIC_RECV, "sycn progress ** alloc failed", 0);
        for (int i = 0; i < msg.n_music_sync_progress; i++) {
            sync_process[i] = pvPortMalloc(sizeof(MusicSyncProgress));
            music_sync_progress__init(sync_process[i]);
            sync_process[i]->id = m_reciever.cur_recv_file->music_id;
            sync_process[i]->offset = m_reciever.cur_recv_file->music_offset;
            sync_process[i]->finished = false;

            LOG_MSGID_I(MUSIC_RECV, "sycn progress. size %u, offset %u", 2,
                        m_reciever.cur_recv_file->music_size,
                        sync_process[i]->offset);
        }
    }

    send_msg_to_app(&msg);

    if (msg.n_music_sync_progress > 0) {
        vPortFree(sync_process);
        for (int i = 0; i < msg.n_music_sync_progress; i++)
            vPortFree(sync_process[i]);
    }
}

int find_free_partition() {
    int i, j, flag;

    for (i = 0; i < 6; i++) {
        flag = 0;
        for (j = 0; j < 4; j++) {
            if (music_partitions[i].addr ==
                m_reciever.p_solution->files[j].music_file_addr) {
                flag = 1;
                break;
            }
        }

        if (flag == 0) {
            return i;
        }
    }

    return -1;
}

void file_receiver_task(void) {
    recv_file_t new_recv_file;
    recv_file_t *cur_file;
    recv_data_t new_data;

    m_reciever.new_file_queue = xQueueCreate(6, sizeof(recv_file_t));
    m_reciever.new_data_queue = xQueueCreate(6, sizeof(recv_data_t));
    music_solution_read(&m_reciever.p_solution);
    music_file_sync_status_get(&m_reciever.cur_recv_file);
    cur_file = m_reciever.cur_recv_file;

    while (1) {
        switch (m_reciever.cur_state) {
            case FILE_RECV_STATE_IDLE:
                if (xQueueReceive(m_reciever.new_file_queue, &new_recv_file,
                                  1000 / portTICK_PERIOD_MS) == pdTRUE) {
                    m_reciever.cur_state = FILE_RECV_STATE_STARTED;
                    m_reciever.event = 0;
                }
                break;

            case FILE_RECV_STATE_STARTED:
                LOG_MSGID_I(MUSIC_RECV, "FILE_RECV_STATE_STARTED", 0);
                bool file_existed = false;
                // 获取当前断点，比对信息，更新接收文件信息
                music_solution_read(&m_reciever.p_solution);
                music_file_sync_status_get(&cur_file);
                if (m_reciever.cur_recv_file->music_id ==
                        new_recv_file.music_id &&
                    m_reciever.cur_recv_file->music_size ==
                        new_recv_file.music_size) {
                    cur_file->solution_id = new_recv_file.solution_id;

                } else {
                    cur_file->solution_id = new_recv_file.solution_id;
                    cur_file->music_id = new_recv_file.music_id;
                    cur_file->music_size = new_recv_file.music_size;
                    cur_file->music_offset = 0;
                }

                for (int i = 0; i < MUSIC_SOLUTION_NUMS; i++) {
                    if (new_recv_file.music_id == m_reciever.p_solution->files[i].music_id &&
                        new_recv_file.music_size == m_reciever.p_solution->files[i].music_size &&
                        m_reciever.p_solution->files[i].music_offset == m_reciever.p_solution->files[i].music_size) {
                        cur_file->solution_id = new_recv_file.solution_id;
                        cur_file->music_id = m_reciever.p_solution->files[i].music_id;
                        cur_file->music_size = m_reciever.p_solution->files[i].music_size;
                        cur_file->music_offset = m_reciever.p_solution->files[i].music_offset;
                        cur_file->music_file_addr = m_reciever.p_solution->files[i].music_file_addr;
                        file_existed = true;
                        break;
                    }
                }
                if (file_existed) {
                    // 再次申请下数据，让APP知道已经传输完成了
                    m_reciever.cur_state = FILE_RECV_STATE_DOWNLOADING;
                    break;
                }
                // 如何需要从头开始传输， 查找Flash address 并且擦除
                if (cur_file->music_offset == 0) {
                    int free_partition_idx = find_free_partition();
                    LOG_MSGID_I(MUSIC_RECV, "free_partition_idx %d", 1,
                                free_partition_idx);

                    if (free_partition_idx < 0) {
                        m_reciever.cur_state = FILE_RECV_STATE_IDLE;
                        break;
                    }
                    int n = music_partitions[free_partition_idx].size / BLOCK_SIZE;
                    for (int i = 0; i < n; i++) {
                        bsp_flash_erase(music_partitions[free_partition_idx].addr + i * BLOCK_SIZE ,
                                        BSP_FLASH_BLOCK_64K);
                    }
                    cur_file->music_file_addr = music_partitions[free_partition_idx].addr;
                }

                m_reciever.cur_state = FILE_RECV_STATE_DOWNLOADING;
                break;

            case FILE_RECV_STATE_DOWNLOADING:
                request_file_data(cur_file->music_id, cur_file->music_offset);
                if (xQueueReceive(m_reciever.new_data_queue, &new_data,
                                  5000 / portTICK_PERIOD_MS) == pdTRUE) {
                    if ((cur_file->music_id == new_data.id) &&
                        (cur_file->music_offset == new_data.offset)) {

                        bsp_flash_write(
                            cur_file->music_file_addr + cur_file->music_offset,
                            new_data.data, new_data.size);
                    

                        cur_file->music_offset += new_data.size;
                        /* 保存断点 */
                        music_file_sync_status_set(cur_file);
                    }

                    vPortFree(new_data.data);
                } else {
                }

                if (m_reciever.event == MUSIC_SYNC_STOP) {
                    m_reciever.cur_state = FILE_RECV_STATE_FINISHED;
                    break;
                }

                if (m_reciever.event == MUSIC_SYNC_PAUSE) {
                    m_reciever.cur_state = FILE_RECV_STATE_PAUSED;
                    break;
                }

                if (cur_file->music_offset == cur_file->music_size) {
                    LOG_MSGID_I(MUSIC_RECV, "music transfer done", 0);
                    music_file_sync_status_set(cur_file);
                    m_reciever.cur_state = FILE_RECV_STATE_FINISHED;
                }
                break;

            case FILE_RECV_STATE_PAUSED:
                if (m_reciever.event == MUSIC_SYNC_RESUME) {
                    m_reciever.cur_state = FILE_RECV_STATE_DOWNLOADING;
                }
                vTaskDelay(1000);
                break;

            case FILE_RECV_STATE_FINISHED:
                LOG_MSGID_I(MUSIC_RECV, "FILE_RECV_STATE_FINISHED", 0);
                memcpy(&m_reciever.p_solution->files[cur_file->solution_id - 1],
                       cur_file, sizeof(recv_file_t));
                music_solution_write(m_reciever.p_solution);
                if (cur_file->music_size == cur_file->music_offset) {
                    uint32_t music_ids[MUSIC_SOLUTION_NUMS];
                    for (int i = 0; i < MUSIC_SOLUTION_NUMS; i ++) {
                        music_ids[i] = m_reciever.p_solution->files[i].music_id;
                    }
                    send_solution_music_ids(music_ids, MUSIC_SOLUTION_NUMS);
                    send_music_file_recv_finished(cur_file->solution_id, cur_file->music_id);
                }
                m_reciever.cur_state = FILE_RECV_STATE_IDLE;
                break;

            default:
                break;
        }
    }
}

void main_bt_music_file_info(uint32_t msg_id, MusicFileInfo *file_info) {
    /* APP会给BT发消息，会调用music_file_sync_handler */
#if (0)
    recv_file_t new_recv_file;

    LOG_MSGID_I(MUSIC_RECV, "main_bt_music_file_info", 0);
    /* 先停止接收，再开始新接收 */
    m_reciever.event = MUSIC_SYNC_STOP;

    new_recv_file.solution_id = file_info->solution_id;
    new_recv_file.music_id = file_info->music_id;
    new_recv_file.music_size = file_info->music_size;
    new_recv_file.music_offset = 0;

    xQueueSend(m_reciever.new_file_queue, &new_recv_file,
               100 / portTICK_PERIOD_MS);
#endif
}

void music_config_handler(uint32_t msg_id, MusicSync *music_sync) {
    recv_file_t new_recv_file;

    LOG_MSGID_I(MUSIC_RECV, "music_config_handler, nums %d", 1,
                music_sync->n_music_ids);
    /* 先停止接收，再开始新接收 */
    m_reciever.event = MUSIC_SYNC_STOP;
    xQueueReset(m_reciever.new_file_queue);

    for (int i = 0; i < music_sync->n_music_ids; i++) {
        new_recv_file.solution_id = i + 1;
        new_recv_file.solution_id = music_sync->music_ids[i];

        new_recv_file.music_id = music_sync->music_ids[i];
        new_recv_file.music_size = music_sync->music_file_size[i];
        new_recv_file.music_offset = 0;

        xQueueSend(m_reciever.new_file_queue, &new_recv_file,
                   100 / portTICK_PERIOD_MS);
    }
}

void music_file_sync_handler(uint32_t msg_id, MusicFileInfo *file_info) {
    recv_file_t new_recv_file;

    LOG_MSGID_I(MUSIC_RECV, "main_bt_music_file_info", 0);
    /* 先停止接收，再开始新接收 */
    m_reciever.event = MUSIC_SYNC_STOP;
    xQueueReset(m_reciever.new_file_queue);

    new_recv_file.solution_id = file_info->solution_id;
    new_recv_file.music_id = file_info->music_id;
    new_recv_file.music_size = file_info->music_size;
    new_recv_file.music_offset = 0;

    xQueueSend(m_reciever.new_file_queue, &new_recv_file,
               100 / portTICK_PERIOD_MS);
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
    uint32_t tick = xTaskGetTickCount();
    static old_tick = 0;
    calculate_data_rate(music_data->data.len);

    receive_file_append_data(music_data->id, music_data->data.data,
                             music_data->data.len, music_data->offset);

    uint32_t ts = xTaskGetTickCount();
    LOG_MSGID_I(MUSIC_RECV, "interval: music data handler %d, two handler %d",
                2, ts - tick, ts - old_tick);

    old_tick = ts;
}

void music_pause_sync(void) {}

void music_sync_event_set(music_file_sync_event_t event)
{
    m_reciever.event = event;
    if (event == MUSIC_SYNC_PAUSE) {
        while(m_reciever.cur_state == FILE_RECV_STATE_DOWNLOADING) {
            vTaskDelay(100);
        }
    }
}