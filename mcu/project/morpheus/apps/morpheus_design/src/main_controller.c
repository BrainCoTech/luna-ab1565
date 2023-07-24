#include "main_controller.h"
#include "app_local_music.h"
#include "app_online_music.h"
#include "apps_config_event_list.h"
#include "apps_config_state_list.h"
#include "apps_config_vp_index_list.h"
#include "apps_config_vp_manager.h"
#include "apps_events_event_group.h"
#include "apps_events_interaction_event.h"
#include "bt_customer_config.h"
#include "bt_sink_srv_a2dp.h"
#include "hal.h"
#include "morpheus.h"
#include "morpheus_utils.h"
#include "music_solution.h"
#include "proto_msg/app_bt/app_bt_msg_helper.h"
#include "proto_msg/main_bt/main_bt_msg_helper.h"
#include "syslog.h"
#include "ui_shell_manager.h"

log_create_module(MAIN_CONTR, PRINT_LEVEL_INFO);
log_create_module(MUSIC_CONTR, PRINT_LEVEL_INFO);

#define MAIN_POWEN_EN_PIN HAL_GPIO_9
#define POWERKEY_PIN HAL_GPIO_10
#define CLK_32K_EN_PIN HAL_GPIO_8

void main_controller_gpio_init(void) {
    hal_gpio_init(CLK_32K_EN_PIN);
    hal_pinmux_set_function(CLK_32K_EN_PIN, 0);
    hal_gpio_set_direction(CLK_32K_EN_PIN, HAL_GPIO_DIRECTION_OUTPUT);
    hal_gpio_set_output(CLK_32K_EN_PIN, HAL_GPIO_DATA_HIGH);

    vTaskDelay(100);
    hal_gpio_init(MAIN_POWEN_EN_PIN);
    hal_pinmux_set_function(MAIN_POWEN_EN_PIN, 0);
    hal_gpio_set_direction(MAIN_POWEN_EN_PIN, HAL_GPIO_DIRECTION_OUTPUT);
    hal_gpio_set_output(MAIN_POWEN_EN_PIN, HAL_GPIO_DATA_LOW);
    vTaskDelay(10);

    hal_gpio_init(POWERKEY_PIN);
    hal_pinmux_set_function(POWERKEY_PIN, 0);
    hal_gpio_set_direction(POWERKEY_PIN, HAL_GPIO_DIRECTION_OUTPUT);
    hal_gpio_set_output(POWERKEY_PIN, HAL_GPIO_DATA_LOW);
}

void main_controller_power_set(int status, int reason) {
    LOG_MSGID_I(MAIN_CONTR, "power on/off:%d, reason %d", 2, status, reason);

    hal_gpio_set_output(MAIN_POWEN_EN_PIN, status);

    battery_set_enable_charger(1);
    if (status) {
        app_uart_init();
    }
}

void main_controller_powerkey_map(int status) {
    LOG_MSGID_I(MAIN_CONTR, "power key %d", 1, status);

    // hal_gpio_set_output(POWERKEY_PIN, status);
}

/******************************************************
 * 长按2s关机，长按6秒进入配对
 * 开始关机，不处理MCU发过来的关机。进入配对模式结束关机流程
 ******************************************************/
static bool before_goto_power_off;
static bool bt_connected;
static bool ble_connected;

void main_controller_set_state(uint32_t state) {
    if (state == SYS_CONFIG__STATE__BLE_DISCONNECTED) {
        ble_connected = false;
    }

    if (state == SYS_CONFIG__STATE__BLE_CONNECTED) {
        ble_connected = true;
    }

    if (state == SYS_CONFIG__STATE__BT_CONNECTED) {
        bt_connected = true;
    }
    if (state == SYS_CONFIG__STATE__BT_DISCONNECTED) {
        bt_connected = false;
    }
    if (state == SYS_CONFIG__STATE__POWER_OFF) {
        before_goto_power_off = true;
    }
    if (state == SYS_CONFIG__STATE__PAIR) {
    }

    BtMain msg = BT_MAIN__INIT;
    msg.msg_id = 100;
    SysConfig sys_cfg = SYS_CONFIG__INIT;
    msg.sys_cfg = &sys_cfg;
    sys_cfg.state = state;
    LOG_MSGID_I(MAIN_CONTR, "send state to maincontroller %d", 1, state);
    send_msg_to_main_controller(&msg);
}

void main_controller_set_time(uint64_t time) {
    BtMain msg = BT_MAIN__INIT;
    msg.msg_id = 101;
    SysConfig sys_cfg = SYS_CONFIG__INIT;
    msg.sys_cfg = &sys_cfg;
    msg.sys_cfg->sync_time = time;
    send_msg_to_main_controller(&msg);
}

static AudioConfig__Mode m_music_mode;
void main_controller_set_music_mode(AudioConfig__Mode mode) {
    LOG_I(MUSIC_CONTR, "set music mode: %d", mode);

    if (m_music_mode != mode) {
        if (mode == AUDIO_CONFIG__MODE__A2DP_MODE) {
            LOG_I(MUSIC_CONTR, "set music mode: %d, pause local music", mode);
            app_local_music_pause();
            wait_for_ready(LOCAL_AUDIO_STATE_PAUSE, 3000);
            m_music_mode = mode;
        }
        if (mode == AUDIO_CONFIG__MODE__LOCAL_MODE) {
            LOG_I(MUSIC_CONTR, "set music mode: %d, pause a2dp music", mode);
            bt_sink_srv_send_action(BT_SINK_SRV_ACTION_PAUSE, NULL);
            
            while(a2dp_playing_flag_get()) {
                vTaskDelay(100);
            }
            m_music_mode = mode;
        }        
    }
}

void audio_config(uint32_t msg_id, AudioConfig *cfg) {
    LOG_MSGID_I(MUSIC_CONTR, "main2bt cmd: %d, mode %d, id %d", 3, cfg->cmd,
                cfg->mode, cfg->audio_id);

    uint8_t status = 0;

    switch (cfg->cmd) {
        case AUDIO_CONFIG__CMD__PLAY:
            if (m_music_mode == AUDIO_CONFIG__MODE__LOCAL_MODE) {
                app_local_music_play();
            } 
            
            if (m_music_mode == AUDIO_CONFIG__MODE__A2DP_MODE) {
                main_controller_audio_config(AUDIO_ACTION_SW_RESUME);
            }
            break;

        case AUDIO_CONFIG__CMD__PAUSE:
            if (m_music_mode == AUDIO_CONFIG__MODE__LOCAL_MODE) {
                app_local_music_pause();
            } 
            
            if (m_music_mode == AUDIO_CONFIG__MODE__A2DP_MODE) {
                main_controller_audio_config(AUDIO_ACTION_SW_PAUSE);
            }
            break;

        case AUDIO_CONFIG__CMD__STOP:
            if (m_music_mode == AUDIO_CONFIG__MODE__LOCAL_MODE) {
                app_local_music_pause();
            } 
            
            if (m_music_mode == AUDIO_CONFIG__MODE__A2DP_MODE) {
                main_controller_audio_config(AUDIO_ACTION_SW_STOP);
            }
            break;

        case AUDIO_CONFIG__CMD__LOCAL_PALY:
            break;

        case AUDIO_CONFIG__CMD__LOCAL_PAUSE:
            break;

        default:
            break;
    }

    switch (cfg->mode) {
        case AUDIO_CONFIG__MODE__A2DP_MODE:
            main_controller_set_music_mode(AUDIO_CONFIG__MODE__A2DP_MODE);
            break;

        case AUDIO_CONFIG__MODE__LOCAL_MODE:
            main_controller_set_music_mode(AUDIO_CONFIG__MODE__LOCAL_MODE);
            break;

        default:
            break;
    }

    if (cfg->audio_id) {
        if (cfg->audio_id > 4) {
            app_local_music_pause();
        } else {
            app_local_play_idx(cfg->audio_id - 1);
        }
    }

    BtMain msg = BT_MAIN__INIT;
    AudioConfigResp audio_resp = AUDIO_CONFIG_RESP__INIT;
    msg.msg_id = msg_id;
    msg.audio_cfg_resp = &audio_resp;
    audio_resp.resp = AUDIO_CONFIG_RESP__RESP__SUCC;
    send_msg_to_main_controller(&msg);
}

void app_vp_play_callback(uint32_t idx, vp_err_code err) {
    if (err == VP_ERR_CODE_SUCCESS) {
        LOG_MSGID_I(MAIN_CONTR, "prompt id %d, success", 1, idx);
        BtMain msg = BT_MAIN__INIT;
        PromptConfigResp prompt_resp = PROMPT_CONFIG_RESP__INIT;

        msg.msg_id = 777;
        prompt_resp.vp_id = idx;
        prompt_resp.resp = PROMPT_CONFIG_RESP__RESP__FINISHED;
        send_msg_to_main_controller(&msg);
    }
}

void prompt_config(uint32_t msg_id, PromptConfig *cfg) {
    LOG_MSGID_I(MAIN_CONTR, "prompt id %d", 1, cfg->vp_id);

    if (cfg->vp_id > 0) {
        apps_config_set_vp(cfg->vp_id, false, 0, VOICE_PROMPT_PRIO_MEDIUM,
                           cfg->preemption, app_vp_play_callback);
    }

    BtMain msg = BT_MAIN__INIT;
    PromptConfigResp prompt_resp = PROMPT_CONFIG_RESP__INIT;

    msg.msg_id = msg_id;
    prompt_resp.vp_id = cfg->vp_id;
    send_msg_to_main_controller(&msg);
}

void volume_config(uint32_t msg_id, VolumeConfig *cfg) {
    LOG_MSGID_I(MAIN_CONTR, "volume type %d, value %d", 2, cfg->type,
                cfg->volume);

    if (cfg->type == VOLUME_CONFIG__TYPE__UPDATE) {
        if (cfg->volume > 0) {
            bt_sink_srv_send_action(BT_SINK_SRV_ACTION_VOLUME_UP, NULL);
            app_local_music_volume_up();
        } else {
            while (cfg->volume++ != 0) {
                bt_sink_srv_send_action(BT_SINK_SRV_ACTION_VOLUME_DOWN, NULL);
                app_local_music_volume_down();
            }
        }
    } else {
    }

    BtMain msg = BT_MAIN__INIT;
    VolumeConfigResp volume_resp = VOLUME_CONFIG_RESP__INIT;

    msg.msg_id = msg_id;
    send_msg_to_main_controller(&msg);
}

void main_bt_config(MainBt *msg) {
    if (msg->power_off) {
        if (before_goto_power_off) {
            before_goto_power_off = false;
            return;
        }
        LOG_MSGID_I(MAIN_CONTR, "set power off", 0);
        send_power_off_flag_to_app();
        vTaskDelay(1000);
        ui_shell_send_event(
            true, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_KEY,
            (KEY_POWER_OFF & 0xFF) | ((0x52 & 0xFF) << 8), NULL, 0, NULL, 0);
        return;
    }

    /* anc toggle */
    if (msg->anc) {
        ui_shell_send_event(
            true, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_KEY,
            (KEY_ANC & 0xFF) | ((0x52 & 0xFF) << 8), NULL, 0, NULL, 0);
        return;
    }

    if (msg->get_timestamp) {
        uint64_t ts = get_time_unix_timestamp();
        main_controller_set_time(ts);
    }

    if (msg->power_off || msg->get_timestamp) {
        BtMain msg1 = BT_MAIN__INIT;
        msg1.msg_id = msg->msg_id;
        send_msg_to_main_controller(&msg1);
    }

    if (msg->entry_pair_mode) {
        ui_shell_send_event(true, EVENT_PRIORITY_HIGH, EVENT_GROUP_UI_SHELL_KEY,
                            (KEY_DISCOVERABLE & 0xFF) | ((0x52 & 0xFF) << 8),
                            NULL, 0, NULL, 0);
    }

    if (msg->exit_pair_mode) {
        if (!ship_mode_flag_get()) {
            // TODO 没有取消事件
            app_bt_state_service_set_bt_visible(false, false, 0);
        }
    }

    /* MCU 固定发送电池电量的msg id为99 */
    if (msg->msg_id == 99) {
        LOG_MSGID_I(MAIN_CONTR, "battery_level %d", 1, msg->battery_level);
    }
}

bool main_controller_ble_status(void) { return ble_connected; }

bool main_controller_bt_status(void) { return bt_connected; }

void send_solution_music_ids(uint32_t *ids, uint32_t size) {
    BtMain msg = BT_MAIN__INIT;

    msg.msg_id = 444;

    if (size == 0 || size > MUSIC_SOLUTION_NUMS) {
        return;
    }

    msg.n_music_id = size;
    msg.music_id = pvPortMalloc(size * sizeof(uint32_t));
    if (msg.music_id == NULL) {
        return;
    }

    for (int i = 0; i < size; i++) {
        msg.music_id[i] = ids[i];
    }

    send_msg_to_main_controller(&msg);
    LOG_MSGID_I(MAIN_CONTR, "send music_ids to main", 0);

    vPortFree(msg.music_id);
}

void send_main_msg_to_app(MainApp *msg) {
    packet_packer_t packer;
    uint8_array_t send_to_queue;
    uint8_array_t send_to_usb_queue;

    if (main_app_msg_encode(&packer, msg) == 0) {
        send_to_queue.size = packer.packet_size;
        send_to_queue.data = pvPortMalloc(send_to_queue.size);
        if (send_to_queue.data) {
            memcpy(send_to_queue.data, packer.packet, send_to_queue.size);
            app_us_enqueue(&send_to_queue);
        }

        send_to_usb_queue.size = packer.packet_size;
        send_to_usb_queue.data = pvPortMalloc(send_to_usb_queue.size);
        if (send_to_usb_queue.data) {
            memcpy(send_to_usb_queue.data, packer.packet,
                   send_to_usb_queue.size);
            app_usb_enqueue(&send_to_usb_queue);
        }
        packet_packer_free(&packer);
    }
}

void send_music_file_recv_finished(uint32_t solution_id, uint32_t music_id) {
    MainApp msg = MAIN_APP__INIT;
    DeviceSolutionResp solution_resp = DEVICE_SOLUTION_RESP__INIT;

    msg.msg_id = 150;
    msg.device_solution_resp = &solution_resp;

    solution_resp.solution_id = solution_id;
    solution_resp.music_id = music_id;

    send_main_msg_to_app(&msg);
}