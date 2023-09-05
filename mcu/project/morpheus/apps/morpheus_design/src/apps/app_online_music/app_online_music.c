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
                bt_sink_srv_send_action(BT_SINK_SRV_ACTION_PAUSE, NULL);

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

void a2dp_play_handler(void) {
    LOG_MSGID_I(MUSIC_CONTR, "avrcp state: play", 0);

    main_controller_set_music_mode(AUDIO_CONFIG__MODE__A2DP_MODE);
    a2dp_playing_flag_set(true);

    if (!get_music_type()) {
        send_track_id_to_main(0, true);
    }
    
    main_controller_audio_config(AUDIO_ACTION_KEY_PLAY_PAUSE);
    main_controller_set_state(SYS_CONFIG__STATE__A2DP_PLAYING);
}

void a2dp_pause_handler(void) {
    LOG_MSGID_I(MUSIC_CONTR, "avrcp state: pause", 0);

    a2dp_playing_flag_set(false);

    if (!get_music_type()) {
        send_track_id_to_main(0, false);
    }

    if (lead_off_paused) {
        lead_off_paused = false;
        LOG_MSGID_I(MUSIC_CONTR, "avrcp state: lead off pause", 0);
    } else {
        main_controller_audio_sm_reset();
        main_controller_audio_config(AUDIO_ACTION_APP_PAUSE);
        LOG_MSGID_I(MUSIC_CONTR, "avrcp state: key/app pause", 0);
    }

    main_controller_set_state(SYS_CONFIG__STATE__A2DP_PAUSE);
}