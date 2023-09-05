#include "app_local_music.h"

#include <stdbool.h>

#include "FreeRTOS.h"
#include "FreeRTOSConfig.h"
#include "app_bt/app_bt_msg_helper.h"
#include "apps_debug.h"
#include "morpheus.h"
#include "portmacro.h"
#include "semphr.h"
#include "syslog.h"
#include "task.h"

log_create_module(LOCAL_MUSIC, PRINT_LEVEL_INFO);

#include "FreeRTOS.h"
#include "audio_log.h"
#include "audio_src_srv.h"
#include "filesystem.h"
#include "local_audio_control.h"
#include "main_controller.h"
#include "music_solution.h"
#include "stdlib.h"
#include "task.h"
#include "bsp_external_flash_config.h"
#include "bsp_flash.h"
#include "music_file_receiver.h"

static local_music_player_t m_player;
xSemaphoreHandle local_music_finished_sem;
xSemaphoreHandle local_music_start_sem;
xSemaphoreHandle m_mutex;

static void local_stream_open(void *private_data) {
    local_music_player_t *player = (local_music_player_t *)private_data;
    local_stream_if_t *stream = &player->stream_if;

    player->file_size = m_player.p_solution->files[m_player.index].music_size;

    stream->state = LOCAL_STREAM_STATE_GOOD;
    stream->offset = 0U;

    LOG_MSGID_I(LOCAL_MUSIC, "open file, file size %d\r\n", 1,
                player->file_size);
}

static void local_stream_close(void *private_data) {
    local_music_player_t *player = (local_music_player_t *)private_data;
    local_stream_if_t *stream = &player->stream_if;

    stream->state = LOCAL_STREAM_STATE_UNAVAILABLE;

    stream->offset = 0U;
}

static uint32_t local_stream_read(void *private_data, uint8_t *buffer,
                                  uint32_t size) {
    local_music_player_t *player = (local_music_player_t *)private_data;
    local_stream_if_t *stream = &player->stream_if;

    recv_file_t *cur_file = &player->p_solution->files[m_player.index];

    bsp_flash_status_t status =  bsp_flash_read(
                            cur_file->music_file_addr + stream->offset,
                            buffer, size);
    if (status != BSP_FLASH_STATUS_OK) {
        return 0;
    }

    stream->offset += size;
    if (stream->offset >= player->file_size) {
        stream->state = LOCAL_STREAM_STATE_EOF;
        LOG_MSGID_I(LOCAL_MUSIC, "read file, eof", 0);
    }

    return size;
}
#define MINIMUM(a,b)            ((a) < (b) ? (a) : (b))
static uint32_t local_stream_seek(void *private_data, uint32_t offset) {
    local_music_player_t *player = (local_music_player_t *)private_data;
    local_stream_if_t *stream = &player->stream_if;
    recv_file_t *cur_file = &player->p_solution->files[player->index];

    if (stream->state == LOCAL_STREAM_STATE_BAD) {
        return stream->offset;
    }

    stream->offset = MINIMUM(offset, cur_file->music_offset);

    if (stream->offset == cur_file->music_offset) {
        stream->state = LOCAL_STREAM_STATE_EOF;
    }

    if ((stream->offset < cur_file->music_offset) &&
        (stream->state == LOCAL_STREAM_STATE_EOF)) {
        stream->state = LOCAL_STREAM_STATE_GOOD;
    }

    return 0;
}

void app_local_music_init() {
    local_stream_if_t *stream = &m_player.stream_if;
    /* Clear stream state. */
    stream->state = LOCAL_STREAM_STATE_UNAVAILABLE;
    /* Reset read offset. */
    stream->offset = 0U;
    /* Not used in raw stream. */
    stream->private_data = &m_player;

    stream->open = local_stream_open;
    stream->close = local_stream_close;
    stream->read = local_stream_read;
    stream->seek = local_stream_seek;

    m_player.lfs = fs_get_lfs();

    local_music_finished_sem = xSemaphoreCreateBinary();
    local_music_start_sem = xSemaphoreCreateBinary();
    m_mutex = xSemaphoreCreateMutex();

    m_player.music_ids_nums = 0;
    m_player.audio_state = LOCAL_AUDIO_STATE_READY;
}

void local_music_callback(local_audio_state_t state, void *user_data) {
    LOG_MSGID_I(LOCAL_MUSIC, "LOCAL_AUDIO_STATE %d", 1, state);

    switch (state) {
        case LOCAL_AUDIO_STATE_READY:
            break;

        case LOCAL_AUDIO_STATE_PLAYING:
            break;

        case LOCAL_AUDIO_STATE_PAUSE:
            break;

        case LOCAL_AUDIO_STATE_SUSPEND:
            // m_player.action = ACTION_STOP;
            break;

        case LOCAL_AUDIO_STATE_FINISH:
        case LOCAL_AUDIO_STATE_ERROR:
            m_player.action = ACTION_REPEAT;
            break;
        default:
            break;
    }
    m_player.audio_state = state;
}

int wait_for_ready(local_audio_state_t state, uint32_t timeout) {
    uint32_t i = 0;
    uint8_t duration = 50;
    while (m_player.audio_state != state) {
        i++;
        if (i * duration < timeout) {
            vTaskDelay(duration);
        } else {
            /* timeout */
            return -1;
        }
    }
    return 0;
}

void app_local_music_lock() {
    if (m_mutex != NULL) {
        xSemaphoreTake(m_mutex, portMAX_DELAY);
    }
}

void app_local_music_unlock() {
    if (m_mutex != NULL) {
        xSemaphoreGive(m_mutex);
    }
}

void app_local_music_pause() {
    app_local_music_lock();

    m_player.action = ACTION_PAUSE;
    app_local_music_unlock();
}

void app_local_music_stop() {
    app_local_music_lock();

    m_player.action = ACTION_STOP;
    app_local_music_unlock();
}

void app_local_music_play() {
    app_local_music_lock();
    if (m_player.action != ACTION_NEW_ID) {
        m_player.action = ACTION_PLAY;
        if (m_player.state == PLAY_IDLE) {
            xSemaphoreGive(local_music_start_sem);
        }
    }
    app_local_music_unlock();
}

void app_local_music_play_pause() {
    app_local_music_lock();

    if (m_player.state == PLAY_IDLE) {
        m_player.action = ACTION_PLAY;
        xSemaphoreGive(local_music_start_sem);
    } else if (m_player.state == PLAY_PLAYING) {
        if (m_player.action == ACTION_PLAY) {
            m_player.action = ACTION_PAUSE;
        }
    } else if (m_player.state == PLAY_PAUSE) {
        if (m_player.action == ACTION_PAUSE) {
            m_player.action = ACTION_PLAY;
        }
    }

    app_local_music_unlock();
}

void app_local_music_play_next() {
    app_local_music_lock();

    if (m_player.state == PLAY_IDLE) {
        m_player.action = ACTION_PLAY;
    } else {
        m_player.action = ACTION_FORWARD;
    }
    xSemaphoreGive(local_music_start_sem);
    app_local_music_unlock();
}

static void app_local_music_update_id_from_flash(void) {
    m_player.p_solution = music_solution_get();

    m_player.music_ids_nums = MUSIC_SOLUTION_NUMS;
    for (int i = 0; i < MUSIC_SOLUTION_NUMS; i++) {
        m_player.music_ids_list[i] = m_player.p_solution->files[i].music_id;        
    }
}

void app_local_music_task(void) {
    int ret = 0;

    app_local_music_init();
    m_player.volume = LOCAL_DEFAULT_VOLUME;
    app_local_music_update_id_from_flash();

    while (1) {
        switch (m_player.state) {
            case PLAY_IDLE:
                LOG_MSGID_I(LOCAL_MUSIC, "wait music play", 0);
                xSemaphoreTake(local_music_start_sem, portMAX_DELAY);

                music_sync_event_set(MUSIC_SYNC_PAUSE);
                app_local_music_lock();
                app_local_music_update_id_from_flash();
                app_local_music_unlock();
                LOG_MSGID_I(LOCAL_MUSIC, "update ids %d", 1,
                            m_player.music_ids_nums);
                if (m_player.music_ids_nums > 0) {
                    m_player.state = PLAY_START;
                }
                break;

            case PLAY_START:
                app_local_music_lock();
                m_player.id = m_player.music_ids_list[m_player.index];
                app_local_music_unlock();

                LOG_MSGID_I(LOCAL_MUSIC, "play music id: %u, index %u", 2,
                            m_player.id, m_player.index);

                if (m_player.p_solution->files[m_player.index].music_id == 0 ||
                    m_player.p_solution->files[m_player.index].music_size == 0 ||
                    m_player.p_solution->files[m_player.index].music_offset == 0 ||
                    m_player.p_solution->files[m_player.index].music_file_addr == 0  ) {
                    LOG_MSGID_I(LOCAL_MUSIC, "play error, no resouce", 1);
                    m_player.state = PLAY_IDLE;
                    break;
                }
                music_sync_event_set(MUSIC_SYNC_PAUSE);
                /* 开始播放 */
                audio_local_audio_control_init(local_music_callback, NULL);
                ret = audio_local_audio_control_play(&m_player.stream_if);

                if (ret < 0) {
                    LOG_MSGID_I(LOCAL_MUSIC, "play error: %d", 1, ret);
                    m_player.state = PLAY_IDLE;
                    break;
                }
                ret = wait_for_ready(LOCAL_AUDIO_STATE_PLAYING, 1000);

                if (ret < 0) {
                    LOG_MSGID_I(LOCAL_MUSIC, "play timeout: %d", 1,
                                m_player.audio_state);
                    m_player.state = PLAY_START;
                    break;
                }

                /* 调节音量 */
                audio_local_audio_control_set_volume(m_player.volume);
                LOG_MSGID_I(LOCAL_MUSIC, "play start --> playing", 0);
                m_player.state = PLAY_PLAYING;
                m_player.last_action = ACTION_IDLE;
                break;

            case PLAY_PLAYING:
                /* 轮询action是否需要更新，进行相应的动作 */
                vTaskDelay(100);
                music_sync_event_set(MUSIC_SYNC_PAUSE);
                app_local_music_lock();
                if (m_player.last_action != m_player.action) {
                    if (m_player.action == ACTION_PAUSE) {
                        audio_local_audio_control_pause();
                        m_player.state = PLAY_PAUSE;
                        m_player.last_action = m_player.action;
                    } else if (m_player.action == ACTION_STOP) {
                        audio_local_audio_control_stop();
                        m_player.last_action = m_player.action;
                        m_player.state = PLAY_STOP;
                    } else if (m_player.action == ACTION_FORWARD) {
                        audio_local_audio_control_stop();
                        m_player.action = ACTION_PLAY;
                        m_player.last_action = m_player.action;
                        m_player.state = PLAY_NEXT;
                    } else if (m_player.action == ACTION_REPEAT) {
                        audio_local_audio_control_stop();
                        m_player.action = ACTION_PLAY;
                        m_player.last_action = m_player.action;
                        m_player.state = PLAY_REPEAT;
                    } else if (m_player.action == ACTION_NEW_ID) {
                        audio_local_audio_control_stop();
                        m_player.action = ACTION_PLAY;
                        m_player.last_action = m_player.action;
                        m_player.state = PLAY_NEW_ID;
                    }
                }
                app_local_music_unlock();

                break;

            case PLAY_PAUSE:
                if (wait_for_ready(LOCAL_AUDIO_STATE_PAUSE, 1000) < 0) {
                    LOG_MSGID_I(LOCAL_MUSIC, "PLAY_PAUSE error, audio state %d",
                                1, m_player.audio_state);
                }
                vTaskDelay(100);
                music_sync_event_set(MUSIC_SYNC_RESUME);
                app_local_music_lock();
                if (m_player.last_action != m_player.action) {
                    if (m_player.action == ACTION_PLAY) {
                        audio_local_audio_control_resume();
                        audio_local_audio_control_set_volume(m_player.volume);
                        m_player.last_action = m_player.action;
                        m_player.state = PLAY_PLAYING;
                    } else if (m_player.action == ACTION_STOP) {
                        /* 先恢复音乐，让停止音乐生效 */
                        audio_local_audio_control_set_volume(0);
                        audio_local_audio_control_resume();
                        wait_for_ready(LOCAL_AUDIO_STATE_PLAYING, 1000);
                        audio_local_audio_control_stop();                        
                        m_player.last_action = m_player.action;
                        m_player.state = PLAY_STOP;
                    } else if (m_player.action == ACTION_FORWARD) {
                        /* 先恢复音乐，让停止音乐生效 */
                        audio_local_audio_control_set_volume(0);
                        audio_local_audio_control_resume();
                        wait_for_ready(LOCAL_AUDIO_STATE_PLAYING, 1000);
                        audio_local_audio_control_stop();
                        m_player.action = ACTION_PLAY;
                        m_player.last_action = m_player.action;
                        m_player.state = PLAY_NEXT;
                    } else if (m_player.action == ACTION_NEW_ID) {
                        if (m_player.audio_state != LOCAL_AUDIO_STATE_READY) {
                            /* 先恢复音乐，让停止音乐生效 */
                            audio_local_audio_control_set_volume(0);
                            audio_local_audio_control_resume();
                            wait_for_ready(LOCAL_AUDIO_STATE_PLAYING, 1000);
                            if (m_player.audio_state == LOCAL_AUDIO_STATE_PLAYING)
                                audio_local_audio_control_stop();
                            m_player.action = ACTION_PLAY;
                            m_player.last_action = m_player.action;
                            m_player.state = PLAY_NEW_ID;
                        } else {
                            audio_local_audio_control_deinit();
                            m_player.state = PLAY_START;
                        }
                    }
                }

                app_local_music_unlock();
                break;

            case PLAY_NEXT:
                if (++m_player.index >= m_player.music_ids_nums) {
                    m_player.index = 0;
                }
                /* goto PLAY_REPEAT */

            case PLAY_NEW_ID:
                /* not need change id, goto PLAY_REPEAT */

            case PLAY_REPEAT:
                if (wait_for_ready(LOCAL_AUDIO_STATE_READY, 1000) < 0) {
                    LOG_MSGID_I(LOCAL_MUSIC, "PLAY_NEXT error, audio state %d",
                                1, m_player.audio_state);
                }
                audio_local_audio_control_deinit();
                m_player.state = PLAY_START;
                break;

            case PLAY_STOP:
                LOG_MSGID_I(LOCAL_MUSIC, "stop music, audio state %d", 1,
                            m_player.audio_state);
                wait_for_ready(LOCAL_AUDIO_STATE_READY, 5000);
                audio_local_audio_control_deinit();
                m_player.state = PLAY_IDLE;
                break;

            default:
                break;
        }
    }
}

void app_local_play_idx(uint32_t idx) {
    app_local_music_lock();
    if (m_player.music_ids_nums <= idx) {
        LOG_MSGID_I(LOCAL_MUSIC, "no music resource", 0);
        idx = 0;
    }
    m_player.index = idx;
    if (m_player.state == PLAY_IDLE) {
        LOG_MSGID_I(LOCAL_MUSIC, "app_local_play_idx play", 0);
        m_player.action = ACTION_PLAY;
    } else {
        LOG_MSGID_I(LOCAL_MUSIC, "app_local_play_idx new id, state %d", 2, m_player.state);
        m_player.action = ACTION_NEW_ID;
    }
    xSemaphoreGive(local_music_start_sem);
    app_local_music_unlock();
}

void app_local_music_volume_up() {
    if (m_player.volume >= 15) {
    } else {
        if (m_player.volume == 0) {
            audio_local_audio_control_set_mute(false);
        }
        m_player.volume++;
        audio_local_audio_control_set_volume(m_player.volume);
    }
}

void app_local_music_volume_down() {
    if (m_player.volume == 0) {
    } else {
        m_player.volume--;
        audio_local_audio_control_set_volume(m_player.volume);
    }

    if (m_player.volume == 0) {
        audio_local_audio_control_set_mute(true);
    }
}