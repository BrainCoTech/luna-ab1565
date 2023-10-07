#include "app_online_music.h"

#include "FreeRTOS.h"
#include "apps_config_event_list.h"
#include "apps_config_state_list.h"
#include "apps_config_vp_index_list.h"
#include "apps_config_vp_manager.h"
#include "apps_events_event_group.h"
#include "apps_events_interaction_event.h"
#include "bt_customer_config.h"
#include "bt_sink_srv_a2dp.h"
#include "main_controller.h"
#include "semphr.h"
#include "stdbool.h"
#include "timers.h"

#define A2DP_CHECK_TIMER_NAME "a2dp_check"
#define A2DP_CHECK_TIMER_ID 4
#define A2DP_CHECK_TIMER_INTERVAL (2000)
TimerHandle_t m_a2dp_check_timer = NULL;

#define MUSIC_TYPE_TIMER_NAME "music_type"
#define MUSIC_TYPE_TIMER_ID 5
#define MUSIC_TYPE_TIMER_INTERVAL (2000)
TimerHandle_t m_music_type_timer = NULL;

xSemaphoreHandle audio_config_sem;

static audio_play_state_t play_state = AUDIO_PLAY_STATE_STOP;
static bool a2dp_is_playing;
static bool lead_off_paused;
static bool m_is_app_music;
static bool user_pause_music;
static uint32_t last_music_id;

#define EVENT_QUEUE_SIZE 20
static QueueHandle_t event_queue;
#define EVENT_WAIT_PROC_TIME 1000 /*ms*/
static xSemaphoreHandle event_wait_proc_sem;

static void a2dp_check_cb_function(TimerHandle_t xTimer);

void app_online_music_var_init(void) {
    user_pause_music = false;
    m_is_app_music = false;
    m_is_app_music = false;
    a2dp_is_playing = false;
    play_state = AUDIO_PLAY_STATE_STOP;

    audio_config_sem = xSemaphoreCreateMutex();

    m_a2dp_check_timer = xTimerCreate(
        A2DP_CHECK_TIMER_NAME, A2DP_CHECK_TIMER_INTERVAL / portTICK_PERIOD_MS,
        pdTRUE, A2DP_CHECK_TIMER_ID, a2dp_check_cb_function);
}

void send_track_id_to_main(uint32_t id, bool playing) {
    BtMain msg = BT_MAIN__INIT;
    MusicRecord record = MUSIC_RECORD__INIT;

    msg.msg_id = 333;
    msg.music_record = &record;

    if (last_music_id != 0)
        if (!playing && id == 0) return;
    record.id = id;
    record.timestamp = get_time_unix_timestamp();
    record.playing = playing;

    send_msg_to_main_controller(&msg);
    last_music_id = id;
    LOG_MSGID_I(MUSIC_CONTR, "app2bt: music id: %u, playing state: %d", 2, id,
                playing);
}

void a2dp_check_start(void) {
    LOG_MSGID_I(MAIN_CONTR, "start check a2dp", 0);
    xTimerStart(m_a2dp_check_timer, 0);
}

void a2dp_check_stop(void) { xTimerStop(m_a2dp_check_timer, 0); }

void a2dp_playing_flag_set(bool flag) { a2dp_is_playing = flag; }

bool a2dp_playing_flag_get(void) { return a2dp_is_playing; }

bool get_music_type(void) { return m_is_app_music; }

void set_music_type(bool app_music) { m_is_app_music = app_music; }

void main_controller_audio_sm_reset(void) {
    a2dp_is_playing = false;
    play_state = AUDIO_PLAY_STATE_STOP;
    LOG_MSGID_I(MUSIC_CONTR, "reset music controller", 0);
}

#define ENUM_TO_STR(e) (#e)
static char *action_str[] = {
    ENUM_TO_STR(AUDIO_ACTION_NONE),
    ENUM_TO_STR(AUDIO_ACTION_APP_PLAY),
    ENUM_TO_STR(AUDIO_ACTION_APP_PAUSE),
    ENUM_TO_STR(AUDIO_ACTION_KEY_PLAY_PAUSE),
    ENUM_TO_STR(AUDIO_ACTION_KEY_FORWARD),
    ENUM_TO_STR(AUDIO_ACTION_SW_RESUME),
    ENUM_TO_STR(AUDIO_ACTION_SW_PAUSE),
    ENUM_TO_STR(AUDIO_ACTION_SW_STOP),
};

static char *state_str[] = {
    ENUM_TO_STR(AUDIO_PLAY_STATE_STOP),
    ENUM_TO_STR(AUDIO_PLAY_STATE_A2DP_PLAY),
    ENUM_TO_STR(AUDIO_PLAY_STATE_A2DP_PAUSE),
    ENUM_TO_STR(AUDIO_PLAY_STATE_LOCAL_PLAY),
    ENUM_TO_STR(AUDIO_PLAY_STATE_LOCAL_PAUSE),
};

static void a2dp_check_cb_function(TimerHandle_t xTimer) {
    if (a2dp_playing_flag_get()) {
        LOG_MSGID_I(MAIN_CONTR, "a2dp is playing, pause local music", 0);
    } else {
        LOG_MSGID_I(MAIN_CONTR, "a2dp is not playing, continue local music", 0);
        main_controller_audio_sm_reset();
    }
    if (m_a2dp_check_timer) {
        xTimerStop(m_a2dp_check_timer, 0);
    }
}

void main_controller_audio_config(play_action_t action) {
    uint32_t mutex_time = 2000;
    if (action == AUDIO_ACTION_SW_PAUSE) {
        mutex_time = 5000;
    }

    if (xSemaphoreTake(audio_config_sem, pdMS_TO_TICKS(mutex_time)) == pdFAIL) {
        LOG_MSGID_I(MUSIC_CONTR, "audio_config take sem error", 0);
        return;
    }

    if (!main_controller_bt_status() && action == AUDIO_ACTION_KEY_PLAY_PAUSE) {
        LOG_MSGID_I(MUSIC_CONTR, "audio_config not bt connect error", 0);
        xSemaphoreGive(audio_config_sem);
        return;
    }

    LOG_MSGID_I(MUSIC_CONTR, "play_state %d, action %d", 2, play_state, action);
    switch (play_state) {
        case AUDIO_PLAY_STATE_STOP:
            if (action == AUDIO_ACTION_APP_PLAY)
                play_state = AUDIO_PLAY_STATE_A2DP_PLAY;
            lead_off_paused = false;
            if (action == AUDIO_ACTION_KEY_PLAY_PAUSE) {
                bt_sink_srv_send_action(BT_SINK_SRV_ACTION_PLAY, NULL);
                a2dp_check_start();

                play_state = AUDIO_PLAY_STATE_A2DP_PLAY;
                lead_off_paused = false;
            }
            if (action == AUDIO_ACTION_SW_STOP) {
                // bt_sink_srv_send_action(BT_SINK_SRV_ACTION_PAUSE, NULL);

                play_state = AUDIO_PLAY_STATE_STOP;
            }

            if (action == AUDIO_ACTION_KEY_FORWARD) {
                a2dp_check_stop();
                bt_sink_srv_send_action(BT_SINK_SRV_ACTION_NEXT_TRACK, NULL);
                play_state = AUDIO_PLAY_STATE_A2DP_PLAY;
            }
            break;

        case AUDIO_PLAY_STATE_A2DP_PLAY:
            if (action == AUDIO_ACTION_SW_PAUSE) {
                LOG_MSGID_I(MUSIC_CONTR, "sw_pause: send avrcp pause", 0);

                bt_sink_srv_send_action(BT_SINK_SRV_ACTION_PAUSE, NULL);

                play_state = AUDIO_PLAY_STATE_A2DP_PAUSE;
                lead_off_paused = true;
                a2dp_check_stop();
            } else if ((action == AUDIO_ACTION_KEY_PLAY_PAUSE) ||
                       (action == AUDIO_ACTION_SW_STOP)) {
                a2dp_check_stop();
                LOG_MSGID_I(MUSIC_CONTR, "key/sw_stop: send avrcp pause", 0);

                bt_sink_srv_send_action(BT_SINK_SRV_ACTION_PAUSE, NULL);

                play_state = AUDIO_PLAY_STATE_STOP;
                lead_off_paused = false;
            }

            if ((action == AUDIO_ACTION_APP_PAUSE)) {
                a2dp_check_stop();
                play_state = AUDIO_PLAY_STATE_A2DP_PAUSE;
                lead_off_paused = false;
            }
            if (action == AUDIO_ACTION_KEY_FORWARD) {
                a2dp_check_stop();
                bt_sink_srv_send_action(BT_SINK_SRV_ACTION_NEXT_TRACK, NULL);
                play_state = AUDIO_PLAY_STATE_A2DP_PLAY;
            }

            break;

        case AUDIO_PLAY_STATE_A2DP_PAUSE:
            if (action == AUDIO_ACTION_SW_RESUME) {
                LOG_MSGID_I(MUSIC_CONTR, "sw resume: send avrcp play", 0);

                bt_sink_srv_send_action(BT_SINK_SRV_ACTION_PLAY, NULL);

                bt_sink_srv_send_action(BT_SINK_SRV_ACTION_PLAY, NULL);
                play_state = AUDIO_PLAY_STATE_A2DP_PLAY;
                lead_off_paused = false;
            } else if (action == AUDIO_ACTION_SW_STOP) {
                bt_sink_srv_send_action(BT_SINK_SRV_ACTION_PAUSE, NULL);

                play_state = AUDIO_PLAY_STATE_STOP;
            } else if (action == AUDIO_ACTION_KEY_PLAY_PAUSE) {
                LOG_MSGID_I(MUSIC_CONTR, "key: send avrcp play", 0);

                bt_sink_srv_send_action(BT_SINK_SRV_ACTION_PLAY, NULL);

                play_state = AUDIO_PLAY_STATE_A2DP_PLAY;
                lead_off_paused = false;
            }
            if (action == AUDIO_ACTION_KEY_FORWARD) {
                a2dp_check_stop();
                bt_sink_srv_send_action(BT_SINK_SRV_ACTION_NEXT_TRACK, NULL);
                play_state = AUDIO_PLAY_STATE_A2DP_PLAY;
            }
            break;

        case AUDIO_PLAY_STATE_LOCAL_PLAY:

            break;

        case AUDIO_PLAY_STATE_LOCAL_PAUSE:
            break;

        default:
            break;
    }
    LOG_I(MUSIC_CONTR, "new state %s, reason/action %s", state_str[play_state],
          action_str[action]);
    xSemaphoreGive(audio_config_sem);
}

bool user_disconnect_a2dp;
bool is_user_disconnect_a2dp()
{
    return user_disconnect_a2dp;
}

void user_disconnect_a2dp_set(bool flag)
{
    user_disconnect_a2dp = flag;
}

void disconnect_a2dp(void) {
    bt_bd_addr_t *p_bd_addr = bt_device_manager_remote_get_dev_by_seq_num(1);
    if (p_bd_addr) {
        bt_cm_connect_t dis_conn;
        dis_conn.profile =
            BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_A2DP_SINK) |
            BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_A2DP_SOURCE);
        memcpy(dis_conn.address, *p_bd_addr, sizeof(bt_bd_addr_t));
        bt_cm_disconnect(&dis_conn);
    }
    user_disconnect_a2dp = true;
}

void connect_a2dp(void) {
    LOG_MSGID_I(MUSIC_CONTR, "try reconnect", 0);
    bt_cm_connect_t conn_cntx;
    bt_bd_addr_t *address_p = bt_cm_get_last_connected_device();
    if (address_p == NULL) {
        return;
    }
    conn_cntx.profile = BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_A2DP_SINK);
    bt_cm_memcpy(&conn_cntx.address, address_p, sizeof(bt_bd_addr_t));
    bt_cm_connect(&conn_cntx);
}


void a2dp_play_handler(void) {
    online_music_event_t event;
    event.event = ONLINE_AVRCP_STATUS_PLAY;
    xQueueSend(event_queue, &event, 100/portTICK_PERIOD_MS);
}

void a2dp_pause_handler(void) {
    online_music_event_t event;
    event.event = ONLINE_AVRCP_STATUS_PAUSE;
    xQueueSend(event_queue, &event, 100/portTICK_PERIOD_MS);
}

void app_online_music_task(void) {
    online_music_event_t new_event;
    online_music_event_t cur_event;
    uint32_t count = 0;

    event_queue = xQueueCreate(EVENT_QUEUE_SIZE, sizeof(online_music_event_t));
    event_wait_proc_sem = xSemaphoreCreateBinary();

    while (1) {
        if (event_queue == NULL) {
            vTaskDelay(100);
            event_queue = xQueueCreate(EVENT_QUEUE_SIZE, sizeof(online_music_event_t));
            continue;
        }

        if (xQueueReceive(event_queue, &new_event, EVENT_WAIT_PROC_TIME / portTICK_PERIOD_MS) == pdTRUE) {
            cur_event = new_event;
            continue;
        }

#if (0)
        if (user_disconnect_a2dp) {
            if (count++ > 5000/EVENT_WAIT_PROC_TIME) {
                count = 0;
                connect_a2dp();
                user_disconnect_a2dp = false;
            }
        } else {
            count = 0;
        }
#endif

        if (cur_event.event == ONLINE_AVRCP_STATUS_PLAY) {
            LOG_MSGID_I(MUSIC_CONTR, "avrcp state: play", 0);
            cur_event.event = 0;

            main_controller_set_music_mode(AUDIO_CONFIG__MODE__A2DP_MODE);

            a2dp_playing_flag_set(true);
            // if (!get_music_type()) {
            //     send_track_id_to_main(0, true);
            // }
            // main_controller_audio_config(AUDIO_ACTION_APP_PLAY);

            // main_controller_set_state(SYS_CONFIG__STATE__A2DP_PLAYING);
        }

        if (cur_event.event == ONLINE_AVRCP_STATUS_PAUSE) {
            LOG_MSGID_I(MUSIC_CONTR, "avrcp state: pause", 0);
            cur_event.event = 0;

            a2dp_playing_flag_set(false);
            // if (!get_music_type()) {
            //     send_track_id_to_main(0, false);
            // }
            // main_controller_audio_sm_reset();

            // main_controller_set_state(SYS_CONFIG__STATE__A2DP_PAUSE);
        }

    }
}