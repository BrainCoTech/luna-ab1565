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
#include "music_file_receiver.h"

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
#define EVENT_WAIT_PROC_TIME 500 /*ms*/
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


void a2dp_play_handler(void) {
    online_music_event_t event;
    event.event = ONLINE_AVRCP_STATUS_PLAY;
    event.ticks = xTaskGetTickCount();
    xQueueSend(event_queue, &event, 100/portTICK_PERIOD_MS);
}

void a2dp_pause_handler(void) {
    online_music_event_t event;
    event.event = ONLINE_AVRCP_STATUS_PAUSE;
    event.ticks = xTaskGetTickCount();
    xQueueSend(event_queue, &event, 100/portTICK_PERIOD_MS);
}

void music_event_set(uint32_t event) {
    online_music_event_t new_event;
    new_event.event = event;
    new_event.ticks = xTaskGetTickCount();
    xQueueSend(event_queue, &new_event, 100/portTICK_PERIOD_MS);
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
        }

        if (cur_event.event == ONLINE_AVRCP_STATUS_PLAY) {
            LOG_MSGID_I(MUSIC_CONTR, "avrcp state: play", 0);
            cur_event.event = 0;
            a2dp_playing_flag_set(true);

            if (main_controller_get_music_mode() == AUDIO_CONFIG__MODE__A2DP_MODE) {
                main_controller_set_state(SYS_CONFIG__STATE__A2DP_PLAYING);
                send_track_id_to_main(0, true);
            }

            music_sync_event_set(MUSIC_SYNC_RESUME);
        } else if (cur_event.event == ONLINE_AVRCP_STATUS_PAUSE) {
            LOG_MSGID_I(MUSIC_CONTR, "avrcp state: pause", 0);
            cur_event.event = 0;
            a2dp_playing_flag_set(false);

            if (main_controller_get_music_mode() == AUDIO_CONFIG__MODE__A2DP_MODE) {
                main_controller_set_state(SYS_CONFIG__STATE__A2DP_PAUSE);
                send_track_id_to_main(0, false);
            }
        } else {
            cur_event.event = 0;
        }

    }
}