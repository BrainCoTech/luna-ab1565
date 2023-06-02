/* Copyright Statement:
 *
 * (C) 2022  Airoha Technology Corp. All rights reserved.
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

#if defined(AIR_SWIFT_PAIR_ENABLE) && defined(AIR_CUST_PAIR_ENABLE)

#include "app_cust_pair_idle_activity.h"

#include "app_swift_cust_pair.h"
#include "cust_pair.h"

#include "app_bt_state_service.h"
#include "apps_events_battery_event.h"
#include "apps_events_bt_event.h"
#include "apps_events_event_group.h"
#include "apps_events_interaction_event.h"
#include "apps_debug.h"

#include "bt_app_common.h"
#include "battery_management.h"
#include "battery_management_core.h"
#include "bt_connection_manager.h"
#include "bt_connection_manager_internal.h"
#include "bt_customer_config.h"
#include "bt_device_manager.h"
#include "bt_gap_le.h"
#include "bt_app_common.h"
#include "multi_ble_adv_manager.h"
#include "ui_shell_manager.h"

#if defined(MTK_AWS_MCE_ENABLE) && defined(SUPPORT_ROLE_HANDOVER_SERVICE)
#include "app_rho_idle_activity.h"
#endif
#ifdef AIR_BT_FAST_PAIR_ENABLE
#include "app_fast_pair.h"
#endif
#ifdef AIR_LE_AUDIO_ENABLE
#include "app_lea_service_adv_mgr.h"
#endif



/**================================================================================*/
/**                              Definition & Structure                            */
/**================================================================================*/
#define LOG_TAG                             "[CUST_PAIR][APP]"

extern bt_status_t bt_app_common_set_pairing_distribute_ctkd(bt_gap_le_srv_link_t link_type, bool is_ctkd_support);

#define APP_CUST_PAIR_OTHER_ADV_TIMEOUT          (6 * 1000)
#define APP_CUST_PAIR_ADV_TIMEOUT                (2 * 60 * 1000)

#define APP_CUST_PAIR_ADV_EXT_MODE_TIMEOUT       2200
#define APP_CUST_PAIR_ADV_STD_MODE_TIMEOUT       1500
#define APP_CUST_PAIR_ADV_3RD_MODE_TIMEOUT       1500

typedef struct {
    cust_pair_adv_mode                           adv_mode;
} app_cust_pair_context_t;

static app_cust_pair_context_t              app_cust_pair_ctx = {0};



/**================================================================================*/
/**                                Internal Function                               */
/**================================================================================*/
bool cust_pair_update_ctkd(bool ctkd_support)
{
    APPS_LOG_MSGID_I(LOG_TAG" update_ctkd, ctkd_support=%d", 1, ctkd_support);
    bt_status_t bt_status = bt_app_common_set_pairing_distribute_ctkd(BT_GAP_LE_SRV_LINK_TYPE_CUST_PAIR, ctkd_support);
    return (bt_status == BT_STATUS_SUCCESS);
}

bool cust_pair_check_le_link(const uint8_t *le_local_addr)
{
    bool ret = FALSE;
    bt_bd_addr_t adv_addr = {0};
    if (multi_ble_adv_manager_get_random_addr_and_adv_handle(MULTI_ADV_INSTANCE_SWIFT_PAIR, &adv_addr, NULL)) {
        ret = (memcmp(&adv_addr, le_local_addr, BT_BD_ADDR_LEN) == 0);
        APPS_LOG_MSGID_I(LOG_TAG" check_ble_link, STD ret=%d adv_addr=%02X:%02X:%02X:%02X:%02X:%02X",
                         7, ret, adv_addr[5], adv_addr[4], adv_addr[3], adv_addr[2], adv_addr[1], adv_addr[0]);
    }
    return ret;
}

void cust_pair_start_le_conn_timer(bool start, uint16_t conn_handle, uint32_t timeout)
{
    APPS_LOG_MSGID_I(LOG_TAG" start_le_conn_timer, start=%d conn_handle=0x%04X timeout=%d",
                     3, start, conn_handle, timeout);
    if (start) {
        ui_shell_remove_event(EVENT_GROUP_UI_SHELL_SWIFT_PAIR,
                              APP_SWIFT_PAIR_EVENT_CUST_CONN_TIMER_BASE + conn_handle);
        ui_shell_send_event(FALSE, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_SWIFT_PAIR,
                            APP_SWIFT_PAIR_EVENT_CUST_CONN_TIMER_BASE + conn_handle,
                            NULL, 0, NULL, timeout);
    } else {
        ui_shell_remove_event(EVENT_GROUP_UI_SHELL_SWIFT_PAIR,
                              APP_SWIFT_PAIR_EVENT_CUST_CONN_TIMER_BASE + conn_handle);
    }
}

static uint32_t app_cust_pair_get_adv_info(multi_ble_adv_info_t *adv_info)
{
    if (adv_info == NULL) {
        APPS_LOG_MSGID_E(LOG_TAG" get_adv_info, null adv_info", 0);
        return 0;
    }

    if (adv_info->adv_param != NULL) {
        bt_app_common_generate_default_adv_data(adv_info->adv_param, NULL, NULL, NULL, 0);
    }

    cust_pair_get_adv_info(app_cust_pair_ctx.adv_mode, adv_info->adv_param, adv_info->adv_data, adv_info->scan_rsp);
    return 0;
}

static void app_cust_pair_switch_adv_type(void)
{
    uint8_t old_adv_mode = app_cust_pair_ctx.adv_mode;
    if (old_adv_mode == CUST_PAIR_ADV_MODE_EXT) {
        app_cust_pair_ctx.adv_mode = CUST_PAIR_ADV_MODE_STD;
    } else if (old_adv_mode == CUST_PAIR_ADV_MODE_STD) {
        app_cust_pair_ctx.adv_mode = CUST_PAIR_ADV_MODE_3RD;
    } else if (old_adv_mode == CUST_PAIR_ADV_MODE_3RD) {
        app_cust_pair_ctx.adv_mode = CUST_PAIR_ADV_MODE_EXT;
    }

    multi_ble_adv_manager_remove_ble_adv(MULTI_ADV_INSTANCE_SWIFT_PAIR, app_cust_pair_get_adv_info);
    multi_ble_adv_manager_add_ble_adv(MULTI_ADV_INSTANCE_SWIFT_PAIR, app_cust_pair_get_adv_info, 1);
    multi_ble_adv_manager_notify_ble_adv_data_changed(MULTI_ADV_INSTANCE_SWIFT_PAIR);
    APPS_LOG_MSGID_I(LOG_TAG" switch_adv_type, ext_adv=%d->%d", 2, old_adv_mode, app_cust_pair_ctx.adv_mode);

    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_SWIFT_PAIR, APP_SWIFT_PAIR_EVENT_CUST_SWITCH_TYPE);
    if (app_cust_pair_ctx.adv_mode == CUST_PAIR_ADV_MODE_EXT) {
        ui_shell_send_event(FALSE, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_SWIFT_PAIR,
                            APP_SWIFT_PAIR_EVENT_CUST_SWITCH_TYPE, NULL, 0, NULL, APP_CUST_PAIR_ADV_EXT_MODE_TIMEOUT);
    } else {
        ui_shell_send_event(FALSE, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_SWIFT_PAIR,
                            APP_SWIFT_PAIR_EVENT_CUST_SWITCH_TYPE, NULL, 0, NULL, APP_CUST_PAIR_ADV_STD_MODE_TIMEOUT);
    }
}

static bool app_cust_pair_start_adv(void)
{
    app_cust_pair_ctx.adv_mode = CUST_PAIR_ADV_MODE_EXT;

    multi_ble_adv_manager_remove_ble_adv(MULTI_ADV_INSTANCE_SWIFT_PAIR, app_cust_pair_get_adv_info);
    multi_ble_adv_manager_add_ble_adv(MULTI_ADV_INSTANCE_SWIFT_PAIR, app_cust_pair_get_adv_info, 1);
    multi_ble_adv_manager_notify_ble_adv_data_changed(MULTI_ADV_INSTANCE_SWIFT_PAIR);

    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_SWIFT_PAIR, APP_SWIFT_PAIR_EVENT_CUST_SWITCH_TYPE);
    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_SWIFT_PAIR, APP_SWIFT_PAIR_EVENT_CUST_ADV_TIMEOUT);
    ui_shell_send_event(FALSE, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_SWIFT_PAIR,
                        APP_SWIFT_PAIR_EVENT_CUST_SWITCH_TYPE, NULL, 0, NULL, APP_CUST_PAIR_ADV_EXT_MODE_TIMEOUT);
    ui_shell_send_event(FALSE, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_SWIFT_PAIR,
                        APP_SWIFT_PAIR_EVENT_CUST_ADV_TIMEOUT, NULL, 0, NULL, APP_CUST_PAIR_ADV_TIMEOUT);

    APPS_LOG_MSGID_I(LOG_TAG" start_adv, adv_mode=%d time=%d/%d/%d",
                     4, app_cust_pair_ctx.adv_mode, APP_CUST_PAIR_ADV_EXT_MODE_TIMEOUT,
                     APP_CUST_PAIR_ADV_STD_MODE_TIMEOUT, APP_CUST_PAIR_ADV_3RD_MODE_TIMEOUT);
    return TRUE;
}

static bool app_cust_pair_stop_adv(void)
{
    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_SWIFT_PAIR, APP_SWIFT_PAIR_EVENT_CUST_SWITCH_TYPE);
    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_SWIFT_PAIR, APP_SWIFT_PAIR_EVENT_CUST_ADV_TIMEOUT);

    multi_ble_adv_manager_remove_ble_adv(MULTI_ADV_INSTANCE_SWIFT_PAIR, app_cust_pair_get_adv_info);
    multi_ble_adv_manager_notify_ble_adv_data_changed(MULTI_ADV_INSTANCE_SWIFT_PAIR);
    APPS_LOG_MSGID_I(LOG_TAG" stop_adv", 0);
    return TRUE;
}

static bool app_cust_pair_proc_ui_shell_group(ui_shell_activity_t *self, uint32_t event_id, void *extra_data, size_t data_len)
{
    switch (event_id) {
        case EVENT_ID_SHELL_SYSTEM_ON_CREATE: {
            const bt_gap_config_t *cust_config = bt_customer_config_get_gap_config();
            const char *bt_name = cust_config->device_name;
            uint8_t battery = (uint8_t)battery_management_get_battery_property(BATTERY_PROPERTY_CAPACITY);
#if defined(AIR_DUAL_CHIP_MIXING_MODE_ROLE_MASTER_ENABLE) || defined(AIR_DCHS_MODE_MASTER_ENABLE)
            battery = apps_events_get_optimal_battery();
#endif

            multi_ble_adv_manager_set_le_connection_max_count(MULTI_ADV_INSTANCE_SWIFT_PAIR, CUST_PAIR_MAX_CONN_NUM);
            cust_pair_init(bt_name, battery);
            break;
        }
        default:
            break;
    }
    return TRUE;
}

static bool app_cust_pair_proc_battery_group(ui_shell_activity_t *self, uint32_t event_id, void *extra_data, size_t data_len)
{
    switch (event_id) {
        case APPS_EVENTS_BATTERY_PERCENT_CHANGE: {
            uint8_t battery = (uint8_t)(int32_t)extra_data;
            //APPS_LOG_MSGID_I(LOG_TAG" battery event, [%02X] battery=%d", 2, role, battery);
            cust_pair_update_battery(battery);
            break;
        }
        default:
            break;
    }
    return FALSE;
}

static bool app_cust_pair_proc_bt_cm_group(ui_shell_activity_t *self, uint32_t event_id, void *extra_data, size_t data_len)
{
    switch (event_id) {
        case BT_CM_EVENT_REMOTE_INFO_UPDATE: {
            /* Stop Swift pair ADV when connected. */
            bt_cm_remote_info_update_ind_t *remote_update = (bt_cm_remote_info_update_ind_t *)extra_data;
            if (NULL == remote_update) {
                //APPS_LOG_MSGID_E(LOG_TAG" BT_CM event, null remote_update", 0);
                break;
            }

            bt_aws_mce_role_t role = bt_connection_manager_device_local_info_get_aws_role();
            bt_bd_addr_t *local_addr = bt_device_manager_get_local_address();
            bool phone_related = (memcmp(remote_update->address, local_addr, sizeof(bt_bd_addr_t)) != 0);

            if (BT_AWS_MCE_ROLE_AGENT == role || BT_AWS_MCE_ROLE_NONE == role || BT_AWS_MCE_ROLE_FOLLOWER_1 == role) {
                if (remote_update->pre_acl_state != BT_CM_ACL_LINK_CONNECTED
                    && remote_update->acl_state == BT_CM_ACL_LINK_CONNECTED
                    && phone_related) {
                    APPS_LOG_MSGID_I(LOG_TAG" BT_CM event, Remote connected -> stop ADV", 0);
                    app_cust_pair_stop_adv();
                }
            }
            break;
        }

        case BT_CM_EVENT_VISIBILITY_STATE_UPDATE: {
            bt_cm_visibility_state_update_ind_t *visible_update = (bt_cm_visibility_state_update_ind_t *)extra_data;
            if (NULL == visible_update) {
                break;
            }

            bool visible = visible_update->visibility_state;
            APPS_LOG_MSGID_I(LOG_TAG" BT_CM event, visibility_state=%d", 1, visible);

            if (visible) {
                app_cust_pair_start_adv();
            } else {
                app_cust_pair_stop_adv();
            }
            break;
        }
        default:
            break;
    }
    return FALSE;
}

static bool app_cust_pair_proc_interaction_group(ui_shell_activity_t *self, uint32_t event_id, void *extra_data, size_t data_len)
{
    bool ret = false;
    switch (event_id) {
#if defined(MTK_AWS_MCE_ENABLE) && defined(SUPPORT_ROLE_HANDOVER_SERVICE)
        case APPS_EVENTS_INTERACTION_RHO_END: {
            app_rho_result_t rho_result = (app_rho_result_t)extra_data;
            APPS_LOG_MSGID_I(LOG_TAG" interaction event, RHO (Agent->Partner) - %d", 1, rho_result);
            if (APP_RHO_RESULT_SUCCESS == rho_result) {
                cust_pair_role_switch(FALSE);
            }
            break;
        }
        /* The old Partner will switch to new Agent if RHO successfully. */
        case APPS_EVENTS_INTERACTION_PARTNER_SWITCH_TO_AGENT: {
            app_rho_result_t rho_result = (app_rho_result_t)extra_data;
            APPS_LOG_MSGID_I(LOG_TAG" interaction event, RHO (Partner->Agent) - %d", 1, rho_result);
            if (APP_RHO_RESULT_SUCCESS == rho_result) {
                cust_pair_role_switch(TRUE);
            }
            break;
        }
#endif
    }
    return ret;
}

static bool app_cust_pair_proc_swift_pair_group(ui_shell_activity_t *self, uint32_t event_id, void *extra_data, size_t data_len)
{
    switch (event_id) {
        case APP_SWIFT_PAIR_EVENT_RESTART_ADV: {
            bool is_visible = app_bt_service_is_visible();
            APPS_LOG_MSGID_I(LOG_TAG" cust_pair event, restart_adv visible=%d", 1, is_visible);
            if (is_visible) {
                app_cust_pair_start_adv();
            }
            break;
        }

        case APP_SWIFT_PAIR_EVENT_CUST_SWITCH_TYPE: {
            //APPS_LOG_MSGID_I(LOG_TAG" cust_pair event, switch_adv_type", 0);
            app_cust_pair_switch_adv_type();
            break;
        }

        case APP_SWIFT_PAIR_EVENT_CUST_ADV_TIMEOUT: {
            APPS_LOG_MSGID_I(LOG_TAG" cust_pair event, timeout", 0);
            app_cust_pair_stop_adv();
            break;
        }

        case APP_SWIFT_PAIR_EVENT_CUST_ADV_STOP: {
            app_cust_pair_stop_adv();
            break;
        }

        case APP_SWIFT_PAIR_EVENT_CUST_GFP_ADV_RESTORE: {
#ifdef AIR_BT_FAST_PAIR_ENABLE
            app_fast_pair_enable_advertising(TRUE);
#endif
            break;
        }

        case APP_SWIFT_PAIR_EVENT_CUST_LEA_ADV_ADJUST: {
#ifdef AIR_LE_AUDIO_ENABLE
            app_lea_adv_mgr_update_adv_interval(APP_LE_AUDIO_ADV_INTERVAL_MIN_S, APP_LE_AUDIO_ADV_INTERVAL_MAX_S);
#endif
            break;
        }

        default:
            break;
    }

    if (event_id > APP_SWIFT_PAIR_EVENT_CUST_CONN_TIMER_BASE) {
        uint16_t conn_handle = event_id - APP_SWIFT_PAIR_EVENT_CUST_CONN_TIMER_BASE;
        APPS_LOG_MSGID_W(LOG_TAG" cust_pair event, LE_CONN_TIMEOUT conn_handle=0x%04X", 1, conn_handle);
        cust_pair_disconnect(conn_handle);
    }

    return TRUE;
}



/**================================================================================*/
/**                                     Public API                                 */
/**================================================================================*/
bool cust_pair_notify_event(uint8_t event)
{
    if (event == CUST_PAIR_EVENT_LE_PAIRING_START) {
        APPS_LOG_MSGID_I(LOG_TAG" notify_event, LE_PAIRING_START", 0);
        app_cust_pair_stop_adv();
#ifdef AIR_BT_FAST_PAIR_ENABLE
        app_fast_pair_enable_advertising(FALSE);
#endif
#ifdef AIR_LE_AUDIO_ENABLE
        app_lea_adv_mgr_update_adv_interval(APP_LE_AUDIO_ADV_INTERVAL_MIN_L, APP_LE_AUDIO_ADV_INTERVAL_MAX_L);
#endif
    } else if (event == CUST_PAIR_EVENT_LE_DISCONNECTED
               || event == CUST_PAIR_EVENT_LE_BONDED) {
        bool is_visible = app_bt_service_is_visible();
        APPS_LOG_MSGID_I(LOG_TAG" notify_event, LE_DISCONNECTED/LE_BONDED visible=%d", 1, is_visible);
#ifdef AIR_BT_FAST_PAIR_ENABLE
        if (event == CUST_PAIR_EVENT_LE_BONDED) {
            ui_shell_remove_event(EVENT_GROUP_UI_SHELL_SWIFT_PAIR, APP_SWIFT_PAIR_EVENT_CUST_GFP_ADV_RESTORE);
            ui_shell_send_event(FALSE, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_SWIFT_PAIR,
                                APP_SWIFT_PAIR_EVENT_CUST_GFP_ADV_RESTORE,
                                NULL, 0, NULL, APP_CUST_PAIR_OTHER_ADV_TIMEOUT);
        }
#endif
#ifdef AIR_LE_AUDIO_ENABLE
        if (event == CUST_PAIR_EVENT_LE_DISCONNECTED) {
            ui_shell_remove_event(EVENT_GROUP_UI_SHELL_SWIFT_PAIR, APP_SWIFT_PAIR_EVENT_CUST_LEA_ADV_ADJUST);
            ui_shell_send_event(FALSE, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_SWIFT_PAIR,
                                APP_SWIFT_PAIR_EVENT_CUST_LEA_ADV_ADJUST,
                                NULL, 0, NULL, APP_CUST_PAIR_OTHER_ADV_TIMEOUT);
        }
#endif
    }
    return TRUE;
}

bool app_cust_pair_idle_activity_proc(struct _ui_shell_activity *self,
                                      uint32_t event_group,
                                      uint32_t event_id,
                                      void *extra_data,
                                      size_t data_len)
{
    bool ret = FALSE;
    switch (event_group) {
        case EVENT_GROUP_UI_SHELL_SYSTEM: {
            ret = app_cust_pair_proc_ui_shell_group(self, event_id, extra_data, data_len);
            break;
        }
        case EVENT_GROUP_UI_SHELL_BATTERY: {
            ret = app_cust_pair_proc_battery_group(self, event_id, extra_data, data_len);
            break;
        }
        case EVENT_GROUP_UI_SHELL_BT_CONN_MANAGER: {
            ret = app_cust_pair_proc_bt_cm_group(self, event_id, extra_data, data_len);
            break;
        }
        case EVENT_GROUP_UI_SHELL_APP_INTERACTION:
            ret = app_cust_pair_proc_interaction_group(self, event_id, extra_data, data_len);
            break;
        case EVENT_GROUP_UI_SHELL_SWIFT_PAIR: {
            ret = app_cust_pair_proc_swift_pair_group(self, event_id, extra_data, data_len);
            break;
        }

        default:
            break;
    }
    return ret;
}

#endif
