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

static local_music_player_t m_player;
xSemaphoreHandle local_music_finished_sem;
xSemaphoreHandle local_music_start_sem;
xSemaphoreHandle m_mutex;

static void local_stream_open(void *private_data) {
    local_music_player_t *player = (local_music_player_t *)private_data;
    local_stream_if_t *stream = &player->stream_if;

    lfs_t *lfs = player->lfs;
    lfs_file_t *file = &player->file;
    char *path = player->path;

    int ret = lfs_file_open(lfs, file, path, LFS_O_RDONLY);

    player->file_size = lfs_file_size(lfs, file);

    stream->state = LOCAL_STREAM_STATE_GOOD;
    stream->offset = 0U;

    LOG_MSGID_I(LOCAL_MUSIC, "open file, file size %d\r\n", 1,
                player->file_size);
}

static void local_stream_close(void *private_data) {
    local_music_player_t *player = (local_music_player_t *)private_data;
    local_stream_if_t *stream = &player->stream_if;

    lfs_t *lfs = player->lfs;
    lfs_file_t *file = &player->file;

    stream->state = LOCAL_STREAM_STATE_UNAVAILABLE;

    stream->offset = 0U;

    lfs_file_close(lfs, file);
}

static uint32_t local_stream_read(void *private_data, uint8_t *buffer,
                                  uint32_t size) {
    local_music_player_t *player = (local_music_player_t *)private_data;
    local_stream_if_t *stream = &player->stream_if;

    lfs_t *lfs = player->lfs;
    lfs_file_t *file = &player->file;

    int read = 0;
    uint32_t file_size = 0;

    if (stream->state != LOCAL_STREAM_STATE_GOOD) {
        return 0U;
    }

    read = lfs_file_read(lfs, file, buffer, size);
    if (read < 0) return 0;
    stream->offset += read;
    if (stream->offset >= player->file_size) {
        stream->state = LOCAL_STREAM_STATE_EOF;
        LOG_MSGID_I(LOCAL_MUSIC, "read file, eof", 0);
    }

    return read;
}

static uint32_t local_stream_seek(void *private_data, uint32_t offset) {
    local_music_player_t *player = (local_music_player_t *)private_data;
    local_stream_if_t *stream = &player->stream_if;

    lfs_t *lfs = player->lfs;
    lfs_file_t *file = &player->file;

    lfs_file_seek(lfs, file, offset, LFS_SEEK_SET);
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

void app_local_music_play() {
    app_local_music_lock();
    m_player.action = ACTION_PLAY;
    if (m_player.state == PLAY_IDLE) {
        xSemaphoreGive(local_music_start_sem);
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
    music_sulotion_t *p_solution;
    music_files_t m_music_files;

    music_file_files_get(&m_music_files);
    solution_read_from_nvdm(&p_solution);

    m_player.music_ids_nums = 0;
    for (int i = 0; i < p_solution->nums; i++) {
        for (int n = 0; n < m_music_files.nums; n++)
            if (p_solution->files[i].fd == m_music_files.files[n].fd &&
                m_music_files.files[n].size > 10240) {
                m_player.music_ids_list[i] = m_music_files.files[n].fd;
                m_player.music_ids_nums++;
            }
    }
}

void app_local_music_task(void) {
    int ret = 0;

    app_local_music_init();
    m_player.volume = LOCAL_DEFAULT_VOLUME;

    while (1) {
        switch (m_player.state) {
            case PLAY_IDLE:
                LOG_MSGID_I(LOCAL_MUSIC, "wait music play", 0);
                xSemaphoreTake(local_music_start_sem, portMAX_DELAY);

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
                snprintf(m_player.path, PATH_MAX_LEN, "%u", m_player.id);
                app_local_music_unlock();

                LOG_MSGID_I(LOCAL_MUSIC, "play music id: %u, index %u", 2,
                            m_player.id, m_player.index);

                /* 开始播放 */
                audio_local_audio_control_init(local_music_callback, NULL);
                ret = audio_local_audio_control_play(&m_player.stream_if);

                if (ret < 0) {
                    LOG_MSGID_I(LOCAL_MUSIC, "play error: %d", 1, ret);
                    m_player.state = PLAY_IDLE;
                    break;
                }
                ret = wait_for_ready(LOCAL_AUDIO_STATE_PLAYING, 5000);

                if (ret < 0) {
                    LOG_MSGID_I(LOCAL_MUSIC, "play timeout: %d", 1,
                                m_player.audio_state);
                    m_player.state = PLAY_IDLE;
                    break;
                }

                /* 调节音量 */
                audio_local_audio_control_set_volume(m_player.volume);
                LOG_MSGID_I(LOCAL_MUSIC, "play start --> playing", 0);
                m_player.state = PLAY_PLAYING;
                break;

            case PLAY_PLAYING:
                /* 轮询action是否需要更新，进行相应的动作 */
                vTaskDelay(100);
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
                if (wait_for_ready(LOCAL_AUDIO_STATE_PAUSE, 5000) < 0) {
                    LOG_MSGID_I(LOCAL_MUSIC, "PLAY_PAUSE error, audio state %d",
                                1, m_player.audio_state);
                }
                vTaskDelay(100);
                app_local_music_lock();
                if (m_player.last_action != m_player.action) {
                    if (m_player.action == ACTION_PLAY) {
                        audio_local_audio_control_resume();
                        audio_local_audio_control_set_volume(m_player.volume);
                        m_player.last_action = m_player.action;
                        m_player.state = PLAY_PLAYING;
                    } else if (m_player.action == ACTION_STOP) {
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
                        /* 先恢复音乐，让停止音乐生效 */
                        audio_local_audio_control_set_volume(0);
                        audio_local_audio_control_resume();
                        wait_for_ready(LOCAL_AUDIO_STATE_PLAYING, 1000);
                        audio_local_audio_control_stop();
                        m_player.action = ACTION_PLAY;
                        m_player.last_action = m_player.action;
                        m_player.state = PLAY_NEW_ID;
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
                if (wait_for_ready(LOCAL_AUDIO_STATE_READY, 5000) < 0) {
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
        m_player.action = ACTION_PLAY;
    } else {
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