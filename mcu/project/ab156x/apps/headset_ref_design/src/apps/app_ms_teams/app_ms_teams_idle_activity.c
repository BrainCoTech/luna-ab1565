
/* Copyright Statement:
 *
 * (C) 2019  Airoha Technology Corp. All rights reserved.
 *
 * This software/firmware and related documentation ("Airoha Software") are
 * protected under relevant copyright laws. The information contained herein
 * is confidential and proprietary to Airoha Technology Corp. ("Airoha") and/or its licensors.
 * Without the prior written permission of Airoha and/or its licensors,
 * any reproduction, modification, use or disclosure of Airoha Software,
 * and information contained herein, in whole or in part, shall be strictly prohibited.
 * You may only use, reproduce, modify, or distribute (as applicable) Airoha Software
 * if you have agreed to and been bound by the applicable license agreement with
 * Airoha ("License Agreement") and been granted explicit permission to do so within
 * the License Agreement ("Permitted User").  If you are not a Permitted User,
 * please cease any access or use of Airoha Software immediately.
 * BY OPENING THIS FILE, RECEIVER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
 * THAT AIROHA SOFTWARE RECEIVED FROM AIROHA AND/OR ITS REPRESENTATIVES
 * ARE PROVIDED TO RECEIVER ON AN "AS-IS" BASIS ONLY. AIROHA EXPRESSLY DISCLAIMS ANY AND ALL
 * WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
 * NEITHER DOES AIROHA PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
 * SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
 * SUPPLIED WITH AIROHA SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO SUCH
 * THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY ACKNOWLEDGES
 * THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES
 * CONTAINED IN AIROHA SOFTWARE. AIROHA SHALL ALSO NOT BE RESPONSIBLE FOR ANY AIROHA
 * SOFTWARE RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
 * STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND AIROHA'S ENTIRE AND
 * CUMULATIVE LIABILITY WITH RESPECT TO AIROHA SOFTWARE RELEASED HEREUNDER WILL BE,
 * AT AIROHA'S OPTION, TO REVISE OR REPLACE AIROHA SOFTWARE AT ISSUE,
 * OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY RECEIVER TO
 * AIROHA FOR SUCH AIROHA SOFTWARE AT ISSUE.
 */

/**
 * File: app_ms_teams_activity.c
 *
 * Description:
 * This file is ms_teams idle activity. This activity is used for teams status management
 *
 */


#ifdef AIR_MS_TEAMS_ENABLE
#ifdef AIR_USB_HID_CALL_CTRL_ENABLE
#include "usb_hid_srv.h"
#endif
#include "app_ms_teams_idle_activity.h"
#include "app_ms_teams_activity.h"
#include "app_ms_teams_utils.h"
#include "bt_connection_manager.h"
#include "app_bt_state_service.h"
#include "apps_config_vp_index_list.h"
#include "voice_prompt_api.h"
#ifdef AIR_LE_AUDIO_ENABLE
#include "bt_sink_srv_le.h"
#include "app_le_audio.h"
#endif
#include "stdlib.h"
#include "task.h"
#ifdef AIR_HEADSET_ENABLE
#include "apps_events_usb_event.h"
#endif
#include "apps_events_battery_event.h"

#ifdef MTK_IN_EAR_FEATURE_ENABLE
#include "app_in_ear_utils.h"
#endif

#define MS_TEAMS_NOTIFY_EV_ALIVE_TIME (5 * 60 *1000)

#define TAG "[MS TEAMS] idle_activity "

#define APP_TEAMS_CONNECT_TYPE_DONGLE 1
#define APP_TEAMS_CONNECT_TYPE_USB    2
static uint8_t s_teams_connect_type = APP_TEAMS_CONNECT_TYPE_DONGLE;

static bool s_teams_connected = false;
/* TODO: udpate this flag under the case of HFP + Teams. */
static bool s_hfp_connected = false;
#ifdef AIR_HEADSET_ENABLE
static uint32_t s_usb_connected_time = 0;
#else
static bool s_aws_connected = false;
#endif
static ms_teams_notif_sub_event_t s_last_notify_ev = MS_TEAMS_NOTIF_EVENT_NONE;
/* 0 is not call state. */
#ifndef AIR_USB_HID_CALL_CTRL_ENABLE
#define USB_HID_SRV_EVENT_CALL_MAX 0xFF
#endif
static uint32_t s_last_hid_call_state_event = USB_HID_SRV_EVENT_CALL_MAX;

static bool app_ms_teams_idle_teams_ev_proc(struct _ui_shell_activity *self, uint32_t ev, uint8_t *data, uint32_t data_len);

#include "atci.h"
#ifdef MS_TEAMS_TEST
extern void ms_teams_conn_test(uint32_t test_type, uint32_t package_type);

static atci_status_t app_ms_teams_atci_handler(atci_parse_cmd_param_t *parse_cmd)
{
    atci_response_t response = {{0}, 0};
    char *param = NULL;
    uint32_t p1 = 0, p2 = 0;

    param = parse_cmd->string_ptr + parse_cmd->name_len + 1;
    param = strtok(param, ",");

    p1 = atoi(param);
    param = strtok(NULL, ",");
    p2 = atoi(param);
    APPS_LOG_MSGID_I(TAG"at commnd: %d,%d", 2, p1, p2);
    ms_teams_conn_test(p1, p2);

    response.response_len = strlen((char *)response.response_buf);
    atci_send_response(&response);
    return ATCI_STATUS_OK;
}

static atci_cmd_hdlr_item_t app_ms_teams_atci_cmd_debug[] = {
    {
        .command_head = "AT+TEAMD_TEST",
        .command_hdlr = app_ms_teams_atci_handler,
        .hash_value1 = 0,
        .hash_value2 = 0,
    },
};

static void app_ms_teams_test_init()
{
    atci_register_handler(app_ms_teams_atci_cmd_debug, sizeof(app_ms_teams_atci_cmd_debug) / sizeof(atci_cmd_hdlr_item_t));
}
#endif

static atci_status_t app_ms_teams_common_atci_handler(atci_parse_cmd_param_t *parse_cmd)
{
    atci_response_t response = {{0}, 0};
    char *param = NULL;
    uint32_t p1 = 0, p2 = 0;

    param = parse_cmd->string_ptr + parse_cmd->name_len + 1;
    param = strtok(param, ",");

    p1 = atoi(param);
    param = strtok(NULL, ",");
    p2 = atoi(param);
    APPS_LOG_MSGID_I(TAG"common at commnd: %d,%d", 2, p1, p2);
    if (p1 == 0) {
        app_ms_teams_idle_teams_ev_proc(NULL, p2, NULL, 0);
    } else if (p1 == 1) {
        if (p2 == 1) {
            ms_teams_telemetry_report_uint8_value(MS_TEAMS_TELEMETRY_MUTE_LOCK, 0x1, true);
        } else if (p2 == 2) {
            ms_teams_telemetry_report_uint8_value(MS_TEAMS_TELEMETRY_MUTE_LOCK, 0x0, true);
        } else if (p2 == 3) {
            ms_teams_telemetry_report_uint8_value(MS_TEAMS_TELEMETRY_HEADSET_WORN, 0x1, true);
        } else if (p2 == 4) {
            ms_teams_telemetry_report_uint8_value(MS_TEAMS_TELEMETRY_HEADSET_WORN, 0x0, true);
        } else if (p2 == 5) {
            ms_teams_telemetry_report_uint32_value(MS_TEAMS_TELEMETRY_LOCAL_CONFERENCE_CNT, 0x1, true);
        } else if (p2 == 6) {
            ms_teams_telemetry_report_uint16_value(MS_TEAMS_TELEMETRY_BTN_PRESS_INFO, (0x2F << 8) | 0x01, true);
            ms_teams_telemetry_report_uint16_value(MS_TEAMS_TELEMETRY_BTN_PRESS_INFO, (0x2F << 8) | 0x00, true);
        }
    }

    response.response_len = strlen((char *)response.response_buf);
    atci_send_response(&response);
    return ATCI_STATUS_OK;
}

static atci_cmd_hdlr_item_t app_ms_teams_common_atci_cmdg[] = {
    {
        .command_head = "AT+TEAMS",
        .command_hdlr = app_ms_teams_common_atci_handler,
        .hash_value1 = 0,
        .hash_value2 = 0,
    },
};

static void app_ms_teams_common_atci_init()
{
    atci_register_handler(app_ms_teams_common_atci_cmdg, sizeof(app_ms_teams_common_atci_cmdg) / sizeof(atci_cmd_hdlr_item_t));
}


static bool app_ms_teams_ev_notify_handler(ms_teams_notif_sub_event_t ev, uint8_t *data, uint32_t data_len)
{
    APPS_LOG_MSGID_I(TAG"teams notify event=0x%x.", 1, ev);
    uint32_t shell_event = 0;
    switch (ev) {
        case MS_TEAMS_NOTIF_EVENT_NONE:
            ui_shell_remove_event(EVENT_GROUP_UI_SHELL_APP_INTERACTION, APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN);
            ui_shell_send_event(false, EVENT_PRIORITY_HIGHEST, EVENT_GROUP_UI_SHELL_APP_INTERACTION,
                                APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN, NULL, 0,
                                NULL, 0);
            s_last_notify_ev = MS_TEAMS_NOTIF_EVENT_NONE;
            break;
        case MS_TEAMS_NOTIF_EVENT_MISSED_CALL:
        case MS_TEAMS_NOTIF_EVENT_UPCOMING_SCHEDULED_MEETING:
        case MS_TEAMS_NOTIF_EVENT_UNCHECKE_VOICE_MAIL: {
            voice_prompt_param_t vp = {0};
            vp.vp_index = VP_INDEX_SUCCESSED;
            voice_prompt_play(&vp, NULL);

            s_last_notify_ev = ev;
            /* Clear the notify state */
            shell_event = ((MS_TEAMS_EVENT_NOTIFY << 16) & 0xFFFF0000) | 0xFFFF;
            ui_shell_remove_event(EVENT_GROUP_UI_SHELL_MS_TEAMS, shell_event);
            ui_shell_send_event(true, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_MS_TEAMS,
                                shell_event,
                                NULL, 0, NULL, MS_TEAMS_NOTIFY_EV_ALIVE_TIME);
            /* Use the incoming call's led UI to indicate these event. */
#ifdef AIR_USB_HID_CALL_CTRL_ENABLE
            if (s_last_hid_call_state_event == USB_HID_SRV_EVENT_CALL_END || s_last_hid_call_state_event == USB_HID_SRV_EVENT_CALL_MAX)
#else
            if (s_last_hid_call_state_event == USB_HID_SRV_EVENT_CALL_MAX)
#endif
            {
                APPS_LOG_MSGID_I(TAG"not in call state, update led to notification event.", 0);
                apps_config_set_background_led_pattern(LED_INDEX_INCOMING_CALL, true, APPS_CONFIG_LED_AWS_SYNC_PRIO_MIDDLE);
            }
            ui_shell_remove_event(EVENT_GROUP_UI_SHELL_APP_INTERACTION, APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN);
            ui_shell_send_event(false, EVENT_PRIORITY_HIGHEST, EVENT_GROUP_UI_SHELL_APP_INTERACTION,
                                APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN, NULL, 0,
                                NULL, MS_TEAMS_NOTIFY_EV_ALIVE_TIME);
            break;
            default:
                ui_shell_remove_event(EVENT_GROUP_UI_SHELL_APP_INTERACTION, APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN);
                ui_shell_send_event(false, EVENT_PRIORITY_HIGHEST, EVENT_GROUP_UI_SHELL_APP_INTERACTION,
                                    APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN, NULL, 0,
                                    NULL, 0);
                s_last_notify_ev = MS_TEAMS_NOTIF_EVENT_NONE;
                break;
            }
    }

    return true;
}

static bool app_ms_teams_idle_teams_ev_proc(struct _ui_shell_activity *self, uint32_t ev, uint8_t *data, uint32_t data_len)
{
    ms_teams_event_t event = ((ev >> 16) & 0xFFFF);

    APPS_LOG_MSGID_I(TAG"teams event proc, 0x%x, 0x%x.", 2, ev, event);
    switch (event) {
        case MS_TEAMS_CONNECTED:
            s_teams_connected = true;
            s_teams_connect_type = APP_TEAMS_CONNECT_TYPE_USB;
            ui_shell_send_event(false, EVENT_PRIORITY_HIGHEST, EVENT_GROUP_UI_SHELL_APP_INTERACTION,
                                APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN, NULL, 0,
                                NULL, 0);
            // apps_dongle_sync_event_send(EVENT_GROUP_UI_SHELL_MS_TEAMS, ev); /* do not update state to other side on headset/earbuds */
            break;
        case MS_TEAMS_DISCONNECTED:
            s_teams_connected = false;
            //apps_dongle_sync_event_send(EVENT_GROUP_UI_SHELL_MS_TEAMS, ev); /* Do not update state to other side on headset/earbuds */
            break;
        case MS_TEAMS_EVENT_LOCALE:
            break;
        case MS_TEAMS_EVENT_NOTIFY: {
#ifdef MTK_AWS_MCE_ENABLE
            bt_aws_mce_role_t role;
            bt_status_t ret = BT_STATUS_SUCCESS;
            role = bt_device_manager_aws_local_info_get_role();
            if (role == BT_AWS_MCE_ROLE_PARTNER) {
                /* If rho switched and the "None" notification not sent, the new Agent will use this event to keep a timer to update the state. */
                ret = apps_aws_sync_event_send_extra(EVENT_GROUP_UI_SHELL_MS_TEAMS, ev, data, data_len);
                APPS_LOG_MSGID_I(TAG"partner notify event to agent ret=%d.", 1, ret);
                return true;
            }
#endif
            app_ms_teams_ev_notify_handler((ms_teams_notif_sub_event_t)(ev & 0xFFFF), data, data_len);
            //apps_dongle_sync_event_send(EVENT_GROUP_UI_SHELL_MS_TEAMS, ev); /* Do not send status to other side on headset/earbuds. */
            break;
        }
        case MS_TEAMS_EVENT_CALL_STATE: {
            break;
        }
        default:
            break;
    }

    return true;
}

static bool _proc_ui_shell_group(struct _ui_shell_activity *self, uint32_t event_id, void *extra_data, size_t data_len)
{
    if (event_id == EVENT_ID_SHELL_SYSTEM_ON_CREATE) {
        app_ms_teams_init();
#ifdef MS_TEAMS_TEST
        app_ms_teams_test_init();
#endif
        app_ms_teams_common_atci_init();
        /* Connection timeout, set LED off. */
        ui_shell_send_event(false, EVENT_PRIORITY_HIGHEST, EVENT_GROUP_UI_SHELL_APP_INTERACTION,
                            APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN, NULL, 0,
                            NULL, 10 * 1000);
    }
    return true;
}

static bool _proc_key_action(apps_config_key_action_t action, uint32_t event_id, void *extra_data, size_t data_len)
{
    static bool is_teams_btn_down = false;
    bool ret = false;
    if (action == KEY_MS_TEAMS_BTN_LONG_PRESS || action == KEY_MS_TEAMS_BTN_INVOKE || action == KEY_MS_TEAMS_BTN_RELEASE) {
        if (!s_teams_connected && s_teams_connect_type == APP_TEAMS_CONNECT_TYPE_USB) {
            APPS_LOG_MSGID_I(TAG"TEAMS not connected, btn invoke will not work.", 0);
            apps_config_set_foreground_led_pattern(LED_INDEX_TEAMS_INVOKE_FAIL, 15, APPS_CONFIG_LED_AWS_SYNC_PRIO_HIGH);
            return false;
        }
    }

    switch (action) {
        case KEY_REDIAL_LAST_CALL: {
            ms_teams_send_action(MS_TEAMS_ACTION_CALL_DIAL_OUT, NULL, 0);
            ret = true;
        }
        break;
        case KEY_MS_TEAMS_BTN_LONG_PRESS: {
            if (s_teams_connect_type == APP_TEAMS_CONNECT_TYPE_USB) {
                ms_teams_btn_press_type_t type = MS_TEAMS_BTN_PRESS_TYPE_LONG_PRESS;
                ms_teams_send_action(MS_TEAMS_ACTION_TEAMS_BTN_INVOKE, &type, sizeof(ms_teams_btn_press_type_t));
                type = MS_TEAMS_BTN_PRESS_TYPE_NONE;
                ms_teams_send_action(MS_TEAMS_ACTION_TEAMS_BTN_RELEASE, &type, sizeof(ms_teams_btn_press_type_t));
            } else {
                apps_dongle_sync_event_send_extra(EVENT_GROUP_UI_SHELL_KEY, event_id, extra_data, data_len);
            }
            ret = true;
            break;
        }
        case KEY_MS_TEAMS_BTN_INVOKE: {
            is_teams_btn_down = true;
            if (s_teams_connect_type != APP_TEAMS_CONNECT_TYPE_USB) {
                apps_dongle_sync_event_send_extra(EVENT_GROUP_UI_SHELL_KEY, event_id, extra_data, data_len);
            } else {
                ms_teams_btn_press_type_t type = MS_TEAMS_BTN_PRESS_TYPE_SHORT_PRESS;
                ms_teams_send_action(MS_TEAMS_ACTION_TEAMS_BTN_INVOKE, &type, sizeof(ms_teams_btn_press_type_t));
            }
            ret = true;
            /* No break here, should call release after invoke called. */
        }
        case KEY_MS_TEAMS_BTN_RELEASE: {
            if (!is_teams_btn_down) {
                break;
            }
            is_teams_btn_down = false;
            if (s_teams_connect_type != APP_TEAMS_CONNECT_TYPE_USB) {
                apps_dongle_sync_event_send_extra(EVENT_GROUP_UI_SHELL_KEY, event_id, (void *)&action, sizeof(apps_config_key_action_t));
            } else {
                ms_teams_btn_press_type_t type = MS_TEAMS_BTN_PRESS_TYPE_NONE;
                ms_teams_send_action(MS_TEAMS_ACTION_TEAMS_BTN_RELEASE, &type, sizeof(ms_teams_btn_press_type_t));
            }
            ret = true;
            break;
        }
        default:
            break;
    }

    return ret;
}

static bool _proc_key_event(struct _ui_shell_activity *self, uint32_t event_id, void *extra_data, size_t data_len)
{
    bool ret = false;
    apps_config_key_action_t action;
    uint8_t key_id;
    airo_key_event_t key_event;

    /* Only KEY_REDIAL_LAST_CALL will handle in idle state, if HFP profile connected, redial through HFP */
    if (!s_teams_connected || s_hfp_connected) {
        ;
    }

    app_event_key_event_decode(&key_id, &key_event, event_id);
    if (extra_data) {
        action = *(uint16_t *)extra_data;
    } else {
        return false;
    }

#ifdef MTK_AWS_MCE_ENABLE
    bt_aws_mce_role_t role;
    role = bt_device_manager_aws_local_info_get_role();
    if (role == BT_AWS_MCE_ROLE_PARTNER) {
#ifdef AIR_LE_AUDIO_ENABLE
        if (app_le_audio_is_connected() && !s_aws_connected) {
            APPS_LOG_MSGID_I(TAG"partner will process key event during le audio connect but aws not.", 0);
        } else {
            if (action == KEY_REDIAL_LAST_CALL || action == KEY_MS_TEAMS_BTN_INVOKE || action == KEY_MS_TEAMS_BTN_RELEASE) {
                ret = apps_aws_sync_event_send(EVENT_GROUP_UI_SHELL_KEY, action);
                APPS_LOG_MSGID_I(TAG"partner sync key action=%d to agent ret=%d.", 2, action, ret);
                return true;
            }
        }
#else
        if (action == KEY_REDIAL_LAST_CALL || action == KEY_MS_TEAMS_BTN_INVOKE || action == KEY_MS_TEAMS_BTN_RELEASE) {
            ret = apps_aws_sync_event_send(EVENT_GROUP_UI_SHELL_KEY, action);
            APPS_LOG_MSGID_I(TAG"partner sync key action=%d to agent ret=%d.", 2, action, ret);
            return true;
        }
#endif
    }
#endif
    ret = _proc_key_action(action, event_id, extra_data, data_len);
    return ret;
}

static bool _proc_bt_cm_event(struct _ui_shell_activity *self, uint32_t event_id, void *extra_data, size_t data_len)
{
#ifdef MTK_AWS_MCE_ENABLE
    bt_cm_remote_info_update_ind_t *info = (bt_cm_remote_info_update_ind_t *)extra_data;
    if ((BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & info->pre_connected_service)
        && !(BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & info->connected_service)) {
        s_aws_connected = false;
    } else if (!(BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & info->pre_connected_service)
               && (BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & info->connected_service)) {
        s_aws_connected = true;
    }
#endif
    return false;
}

#ifdef MTK_AWS_MCE_ENABLE
static bool _proc_aws_data(struct _ui_shell_activity *self, uint32_t event_id, void *extra_data, size_t data_len)
{
    bool ret = false;
    bt_aws_mce_report_info_t *aws_data_ind = (bt_aws_mce_report_info_t *)extra_data;

    if (aws_data_ind->module_id == BT_AWS_MCE_REPORT_MODULE_APP_ACTION) {
        uint32_t event_group;
        uint32_t action;
        void *p_extra_data = NULL;
        uint32_t extra_data_len = 0;

        apps_aws_sync_event_decode_extra(aws_data_ind, &event_group, &action,
                                         &p_extra_data, &extra_data_len);

        if (event_group == EVENT_GROUP_UI_SHELL_KEY) {
            apps_config_key_action_t key_action = (apps_config_key_action_t)action;
            APPS_LOG_MSGID_I(TAG"receive partner key action: %d.", 1, key_action);
            ret = _proc_key_action(action, event_id, &key_action, sizeof(apps_config_key_action_t));
        } else if (event_group == EVENT_GROUP_UI_SHELL_MS_TEAMS) {
            app_ms_teams_idle_teams_ev_proc(self, action, p_extra_data, extra_data_len);
        }
    }

    /* TODO: handle the teams event come from Agent. */
    return ret;
}
#endif

/**
 * @brief The activity event handler
 *
 * @param self
 * @param event_group
 * @param event_id
 * @param extra_data
 * @param data_len
 */
bool app_ms_teams_idle_activity_proc(struct _ui_shell_activity *self,
                                     uint32_t event_group,
                                     uint32_t event_id,
                                     void *extra_data,
                                     size_t data_len)
{

    bool ret = false;

    switch (event_group) {
        case EVENT_GROUP_UI_SHELL_SYSTEM:
            /* UI Shell internal events, please refer to doc/Airoha_IoT_SDK_UI_Framework_Developers_Guide.pdf. */
            ret = _proc_ui_shell_group(self, event_id, extra_data, data_len);
            break;

        case EVENT_GROUP_UI_SHELL_KEY:
            /* key event. */
            ret = _proc_key_event(self, event_id, extra_data, data_len);
            break;

        case EVENT_GROUP_UI_SHELL_BT_CONN_MANAGER:
            /* The event come from bt connection manager, indicates the power state of BT. */
            ret = _proc_bt_cm_event(self, event_id, extra_data, data_len);
            break;
#ifdef AIR_USB_ENABLE
        case EVENT_GROUP_UI_SHELL_USB_AUDIO: {
            if (event_id == APPS_EVENTS_USB_CONFIG_DONE) {
                ui_shell_send_event(false, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_APP_INTERACTION,
                                    APPS_EVENTS_INTERACTION_TEAMS_DELAY_TO_RECONNECT,
                                    NULL, 0, NULL, 3000);
            }
            break;
        }
#endif
        case EVENT_GROUP_UI_SHELL_MS_TEAMS:
            ret = app_ms_teams_idle_teams_ev_proc(self, event_id, extra_data, data_len);
            break;

#ifdef MTK_AWS_MCE_ENABLE
        case EVENT_GROUP_UI_SHELL_AWS_DATA:
            /* The event come from partner. */
            ret = _proc_aws_data(self, event_id, extra_data, data_len);
            break;
#endif
        case EVENT_GROUP_UI_SHELL_BATTERY: {
            if (event_id == APPS_EVENTS_BATTERY_PERCENT_CHANGE) {
                int32_t battery = (int32_t)extra_data;
                apps_dongle_sync_event_send_extra(EVENT_GROUP_UI_SHELL_BATTERY, APPS_EVENTS_BATTERY_PERCENT_CHANGE,
                                                  &battery, sizeof(int32_t));
            }
            break;
        }
        case EVENT_GROUP_UI_SHELL_DONGLE_DATA: {
            apps_dongle_event_sync_info_t *pkg = (apps_dongle_event_sync_info_t *)extra_data;
            /* EVENT_GROUP_UI_SHELL_MS_TEAMS is 30 and it must be same on dongle and earbuds!!! */
            if (pkg->event_group == EVENT_GROUP_UI_SHELL_MS_TEAMS) {
                ms_teams_event_t teams_event_type = ((pkg->event_id >> 16) & 0xFFFF);
                APPS_LOG_MSGID_I(TAG"dongle teams event received, ev=%d.", 1, pkg->event_id);
                switch (teams_event_type) {
                    /* The Teams application handshake with dongle done. */
                    case MS_TEAMS_CONNECTED: {
                        s_teams_connect_type = APP_TEAMS_CONNECT_TYPE_DONGLE;
                        /* Sync the fw version and SN and model id to dongle */
                        const uint8_t *fw = (const uint8_t *)"v1.1.0";
                        const uint8_t *model_id = (const uint8_t *)"headset";
                        const uint8_t *sn = (const uint8_t *)"SN202002150001";
                        uint32_t len1 = strnlen((const char *)fw, 16);
                        uint32_t len2 = strnlen((const char *)model_id, 16);
                        uint32_t len3 = strnlen((const char *)sn, 16);
                        uint32_t sync_len = len1 + len2 + len3 + 3;
                        uint8_t *sync_info = pvPortMalloc(sync_len);
                        if (sync_info == NULL) {
                            break;
                        }
                        memset(sync_info, 0, sync_len);
                        memcpy(sync_info, fw, len1);
                        memcpy(&sync_info[len1 + 1], model_id, len2);
                        memcpy(&sync_info[len1 + len2 + 2], sn, len3);
                        apps_dongle_sync_event_send_extra(EVENT_GROUP_UI_SHELL_MS_TEAMS, (0x06 << 16) & 0xFFFF0000,
                                                          sync_info, sync_len);
                        vPortFree(sync_info);
                        break;
                    }
                    case MS_TEAMS_EVENT_NOTIFY: {
                        app_ms_teams_idle_teams_ev_proc(self, pkg->event_id, pkg->data, pkg->extra_data_len);
                        break;
                    }
                }
            }
        }
#ifdef AIR_HEADSET_ENABLE
        case EVENT_GROUP_UI_SHELL_APP_INTERACTION: {
            if (event_id == APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN) {
                /* Call state has high priority. */
#ifdef AIR_USB_HID_CALL_CTRL_ENABLE
                if (s_last_hid_call_state_event != USB_HID_SRV_EVENT_CALL_END && s_last_hid_call_state_event != USB_HID_SRV_EVENT_CALL_MAX) {
                    APPS_LOG_MSGID_I(TAG"APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN received, call state=%d.", 1, s_last_hid_call_state_event);
                    switch (s_last_hid_call_state_event) {
                        case USB_HID_SRV_EVENT_CALL_ACTIVATE:
                        case USB_HID_SRV_EVENT_CALL_UNHOLD:
                            apps_config_set_background_led_pattern(LED_INDEX_CALL_ACTIVE, false, APPS_CONFIG_LED_AWS_SYNC_PRIO_MIDDLE);
                            break;
                        case USB_HID_SRV_EVENT_CALL_INCOMING:
                            apps_config_set_background_led_pattern(LED_INDEX_INCOMING_CALL, false, APPS_CONFIG_LED_AWS_SYNC_PRIO_MIDDLE);
                            break;
                        case USB_HID_SRV_EVENT_CALL_HOLD:
                        case USB_HID_SRV_EVENT_CALL_REMOTE_HOLD:
                            apps_config_set_background_led_pattern(LED_INDEX_HOLD_CALL, false, APPS_CONFIG_LED_AWS_SYNC_PRIO_MIDDLE);
                            break;
                    }
                    ret = true;
                }
#else
                if (s_last_hid_call_state_event != USB_HID_SRV_EVENT_CALL_MAX) {
                    APPS_LOG_MSGID_I(TAG"APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN received, call state=%d.", 1, s_last_hid_call_state_event);
                }
#endif
                else if (s_last_notify_ev != MS_TEAMS_NOTIF_EVENT_NONE) {
                    if (s_last_notify_ev == MS_TEAMS_NOTIF_EVENT_UPCOMING_SCHEDULED_MEETING) {
                        /* todo */
                    }
                    APPS_LOG_MSGID_I(TAG"APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN received, but notify sta still is %d.", 1, s_last_notify_ev);
                    /* Use the incoming call's led UI to indicate these event. */
                    apps_config_set_background_led_pattern(LED_INDEX_INCOMING_CALL, true, APPS_CONFIG_LED_AWS_SYNC_PRIO_MIDDLE);
                    ret = true;
                } else {
#ifdef AIR_USB_HID_CALL_CTRL_ENABLE
                    if (s_teams_connected) {
                        APPS_LOG_MSGID_I(TAG"APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN received, set state to teams idle.", 0);
                        apps_config_set_background_led_pattern(LED_INDEX_TEAMS_CONNECTED, true, APPS_CONFIG_LED_AWS_SYNC_PRIO_MIDDLE);
                    } else {
                        uint32_t time = 0;
                        time = xTaskGetTickCount() / portTICK_PERIOD_MS / 1000;
                        if ((time - s_usb_connected_time) >= 10) {
                            APPS_LOG_MSGID_I(TAG"APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN received, set state to idle.", 0);
                            apps_config_set_background_led_pattern(LED_INDEX_IDLE, true, APPS_CONFIG_LED_AWS_SYNC_PRIO_MIDDLE);
                        } else {
                            APPS_LOG_MSGID_I(TAG"APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN received, set state to connectable.", 0);
                            apps_config_set_background_led_pattern(LED_INDEX_TEAMS_NOT_CONNECTED, true, APPS_CONFIG_LED_AWS_SYNC_PRIO_MIDDLE);
                        }
                    }
                    /* Teams will take over the basic LED control. */
                    ret = true;
#else
                    APPS_LOG_MSGID_I(TAG"AIR_USB_HID_CALL_CTRL_ENABLE not enabled.", 0);
#endif
                }
            } else if (event_id == APPS_EVENTS_INTERACTION_USB_PLUG_STATE) {
                bool plug_in = (bool)extra_data;
                APPS_LOG_MSGID_I(TAG"APPS_EVENTS_INTERACTION_USB_PLUG_STATE received, usb state=%d.", 1, plug_in);
                if (!plug_in) {
                    s_teams_connected = false;
                    s_teams_connect_type = APP_TEAMS_CONNECT_TYPE_DONGLE;
                    s_last_notify_ev = MS_TEAMS_NOTIF_EVENT_NONE;
                    /* usb plug out, set LED off. */
                    ui_shell_send_event(false, EVENT_PRIORITY_HIGHEST, EVENT_GROUP_UI_SHELL_APP_INTERACTION,
                                        APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN, NULL, 0,
                                        NULL, 0);
                } else {
                    /* set to usb type even if teams not connected due to le-audio will be disconnected when usb plug in. */
                    s_teams_connect_type = APP_TEAMS_CONNECT_TYPE_USB;
                    s_usb_connected_time = xTaskGetTickCount() / portTICK_PERIOD_MS / 1000;
                    /* usb plug in, set LED to connection state. */
                    ui_shell_send_event(false, EVENT_PRIORITY_HIGHEST, EVENT_GROUP_UI_SHELL_APP_INTERACTION,
                                        APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN, NULL, 0,
                                        NULL, 0);
                    /* Connection timeout, set LED off. */
                    ui_shell_send_event(false, EVENT_PRIORITY_HIGHEST, EVENT_GROUP_UI_SHELL_APP_INTERACTION,
                                        APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN, NULL, 0,
                                        NULL, 10 * 1000);
                }
            }
#ifdef MTK_IN_EAR_FEATURE_ENABLE
            else if (event_id == APPS_EVENTS_INTERACTION_IN_EAR_UPDATE_STA) {
                app_in_ear_sta_info_t *sta_info = (app_in_ear_sta_info_t *)extra_data;
                APPS_LOG_MSGID_I(TAG"client in ear updated:%d.", 1, sta_info->current);
                if (sta_info->current == APP_IN_EAR_STA_BOTH_OUT) {
                    ms_teams_telemetry_report_uint8_value(MS_TEAMS_TELEMETRY_HEADSET_WORN, 0x0, true);
                } else {
                    ms_teams_telemetry_report_uint8_value(MS_TEAMS_TELEMETRY_HEADSET_WORN, 0x1, true);
                }
            }
#endif
            else if (event_id == APPS_EVENTS_INTERACTION_TEAMS_DELAY_TO_RECONNECT && !s_teams_connected) {
                extern uint32_t ms_teams_porting_usb_tx(uint8_t *buf, uint32_t len);
                uint8_t send_data[] = {0x9B, 0x01};
                ms_teams_porting_usb_tx(send_data, 2);
                send_data[1] = 0x0;
                ms_teams_porting_usb_tx(send_data, 2);
            }
            break;
        }
#ifdef AIR_USB_HID_CALL_CTRL_ENABLE
        case EVENT_GROUP_UI_SHELL_USB_HID_CALL: {
            switch (event_id) {
                case USB_HID_SRV_EVENT_CALL_UNHOLD:
                    if (s_last_hid_call_state_event == USB_HID_SRV_EVENT_CALL_END) {
                        break;
                    }
                case USB_HID_SRV_EVENT_CALL_INCOMING:
                case USB_HID_SRV_EVENT_CALL_ACTIVATE:
                case USB_HID_SRV_EVENT_CALL_END:
                case USB_HID_SRV_EVENT_CALL_HOLD:
                    if (s_last_hid_call_state_event == USB_HID_SRV_EVENT_CALL_ACTIVATE && event_id == USB_HID_SRV_EVENT_CALL_INCOMING) {
                        APPS_LOG_MSGID_I(TAG"do not update state in second incoming call.", 0);
                        break;
                    }
                    s_last_hid_call_state_event = event_id;
                    ui_shell_send_event(false, EVENT_PRIORITY_HIGHEST, EVENT_GROUP_UI_SHELL_APP_INTERACTION,
                                        APPS_EVENTS_INTERACTION_UPDATE_LED_BG_PATTERN, NULL, 0,
                                        NULL, 0);
                    APPS_LOG_MSGID_I(TAG"s_last_hid_call_state_event updated to %d.", 1, event_id);
                    break;
            }
            break;
        }
#endif
#endif
    }
    return ret;
}

#endif /* AIR_MS_TEAMS_ENABLE */

