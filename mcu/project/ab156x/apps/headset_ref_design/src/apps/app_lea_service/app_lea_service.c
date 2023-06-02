/* Copyright Statement:
 *
 * (C) 2017  Airoha Technology Corp. All rights reserved.
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

#if defined(AIR_LE_AUDIO_ENABLE) || defined(AIR_BLE_ULTRA_LOW_LATENCY_ENABLE)

#include "app_lea_service.h"

#include "app_lea_service_adv_mgr.h"
#include "app_lea_service_conn_mgr.h"
#include "app_lea_service_event.h"
#include "app_lea_service_sync_info.h"

#ifdef AIR_LE_AUDIO_ENABLE
#include "app_le_audio.h"
#include "app_le_audio_aird_client.h"
#include "bt_gap_le_audio.h"
#include "bt_le_audio_sink.h"
#endif

#include "bt_type.h"
#include "bt_gap_le.h"

#include "bt_sink_srv.h"
#include "bt_sink_srv_le.h"

#ifdef MTK_AWS_MCE_ENABLE
#include "bt_aws_mce_report.h"
#include "bt_aws_mce_srv.h"
#include "apps_aws_sync_event.h"
#endif
#include "apps_debug.h"

#include "multi_ble_adv_manager.h"
#include "app_bt_state_service.h"
#include "apps_events_event_group.h"
#include "apps_events_interaction_event.h"
#include "apps_events_bt_event.h"
#include "apps_config_features_dynamic_setting.h"
#include "bt_callback_manager.h"
#include "bt_connection_manager.h"
#include "bt_connection_manager_internal.h"
#include "bt_customer_config.h"
#include "bt_device_manager.h"
#include "bt_init.h"
#include "ui_shell_manager.h"
#include "bt_aws_mce_role_recovery.h"
#include "bt_gattc.h"

#ifdef AIR_SMART_CHARGER_ENABLE
#include "app_smcharger.h"
#endif
#ifdef AIR_BLE_ULTRA_LOW_LATENCY_ENABLE
#include "bt_ull_service.h"
#endif
#if defined(AIR_USB_AUDIO_IN_ENABLE) && defined(AIR_WIRELESS_MIC_ENABLE)
#include "app_usb_audio_idle_activity.h"
#endif

/**************************************************************************************************
 * Define
**************************************************************************************************/
#define LOG_TAG     "[LEA][SRV]"

#ifdef MTK_AWS_MCE_ENABLE
typedef struct {
    bool            need_reuse;
    uint8_t         mode;
    uint8_t         addr[BT_BD_ADDR_LEN];
    uint8_t         reason;
} app_bt_lea_disconnect_param_t;

static app_bt_lea_disconnect_param_t           app_bt_lea_disconnect_param = {0};
#endif

/**************************************************************************************************
 * Enum
**************************************************************************************************/
#ifndef MTK_AWS_MCE_ENABLE  // Headset project
typedef enum {
    APP_LE_AUDIO_WIRED_LINE_IN = 0,
    APP_LE_AUDIO_WIRED_USB_IN,
} app_le_audio_wired_type_t;

#define APP_LE_AUDIO_WIRED_MASK(wired_type)    (0x01U << (wired_type))

static uint8_t app_le_audio_wired_state = 0x00;
#endif

/**************************************************************************************************
 * Variable
**************************************************************************************************/

/**************************************************************************************************
 * Prototype
**************************************************************************************************/

/**************************************************************************************************
 * Static Functions
**************************************************************************************************/
#ifdef MTK_AWS_MCE_ENABLE
static bool app_le_audio_sync_lea_disconnect_peer(uint8_t mode, const uint8_t *addr, uint8_t reason)
{
    app_bt_lea_disconnect_param.need_reuse = FALSE;
    app_bt_lea_disconnect_param.mode = mode;
    if (addr != NULL) {
        memcpy(app_bt_lea_disconnect_param.addr, addr, BT_BD_ADDR_LEN);
    }
    app_bt_lea_disconnect_param.reason = reason;

    bt_aws_mce_role_t role = bt_connection_manager_device_local_info_get_aws_role();
    if (bt_aws_mce_srv_get_link_type() != BT_AWS_MCE_SRV_LINK_NONE) {
        bt_status_t bt_status = apps_aws_sync_event_send_extra(EVENT_GROUP_UI_SHELL_LE_AUDIO,
                                                               EVENT_ID_LE_AUDIO_SYNC_DISCONNECT_PARAM,
                                                               &app_bt_lea_disconnect_param,
                                                               sizeof(app_bt_lea_disconnect_param_t));
        APPS_LOG_MSGID_I(LOG_TAG" sync_lea_disconnect_peer, [%02X] mode=%d bt_status=0x%08X",
                         3, role, mode, bt_status);
        return (bt_status == BT_STATUS_SUCCESS);
    } else {
        APPS_LOG_MSGID_E(LOG_TAG" sync_lea_disconnect_peer, [%02X] AWS Disconnected", 1, role);
        app_bt_lea_disconnect_param.need_reuse = TRUE;
        return FALSE;
    }
}

#endif

#if (APP_LE_AUDIO_ADV_CONN_MODE == APP_LE_AUDIO_MODE_DEFAULT)
#ifdef MTK_AWS_MCE_ENABLE
static bool app_le_audio_sync_visible_connect_addr(const uint8_t *addr)
{
    if (addr == NULL || bt_aws_mce_srv_get_link_type() == BT_AWS_MCE_SRV_LINK_NONE) {
        return FALSE;
    }

    bt_status_t bt_status = apps_aws_sync_event_send_extra(EVENT_GROUP_UI_SHELL_LE_AUDIO,
                                                           EVENT_ID_LE_AUDIO_SYNC_CONNECT_ADDR,
                                                           addr, BT_BD_ADDR_LEN);
    if (bt_status != BT_STATUS_SUCCESS) {
        APPS_LOG_MSGID_E(LOG_TAG" sync_visible_connect_addr, error AWS sync connect addr 0x%08X", 1, bt_status);
    }
    return (bt_status == BT_STATUS_SUCCESS);
}
#endif

static void app_le_audio_cancel_discoverable_mode(const uint8_t *addr)
{
#ifdef MTK_AWS_MCE_ENABLE
    bt_aws_mce_srv_link_type_t aws_state = bt_aws_mce_srv_get_link_type();
    bool visible = app_bt_service_is_visible();
    if (aws_state == BT_AWS_MCE_SRV_LINK_NONE) {
        // Agent exit discoverable mode / partner ignore if AWS disconnected
        app_bt_state_service_cancel_discoverable_mode();
    } else if (visible) {
        // Agent sync new connected LEA addr to partner
        // Partner check the connection state of new connected addr from agent
        app_le_audio_sync_visible_connect_addr(addr);
    }
#else
    app_bt_state_service_cancel_discoverable_mode();
#endif
}

#endif

static bool app_le_audio_proc_bt_cm_group(struct _ui_shell_activity *self,
                                          uint32_t event_id,
                                          void *extra_data,
                                          size_t data_len)
{
    switch (event_id) {
        case BT_CM_EVENT_REMOTE_INFO_UPDATE: {
            bt_cm_remote_info_update_ind_t *remote_update = (bt_cm_remote_info_update_ind_t *)extra_data;
            if (NULL == remote_update) {
                break;
            }
#ifdef MTK_AWS_MCE_ENABLE
            if (!(BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & remote_update->pre_connected_service) &&
                (BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & remote_update->connected_service)) {
                if (app_bt_lea_disconnect_param.need_reuse) {
                    app_bt_lea_disconnect_param.need_reuse = FALSE;
                    apps_aws_sync_event_send_extra(EVENT_GROUP_UI_SHELL_LE_AUDIO,
                                                   EVENT_ID_LE_AUDIO_SYNC_DISCONNECT_PARAM,
                                                   &app_bt_lea_disconnect_param,
                                                   sizeof(app_bt_lea_disconnect_param_t));
                }

#ifdef AIR_LE_AUDIO_BOTH_SYNC_INFO
                app_lea_sync_info_send();
#endif
            }
#endif
            break;
        }
    }
    return FALSE;
}

#if (APP_LE_AUDIO_ADV_CONN_MODE == APP_LE_AUDIO_MODE_DEFAULT)
static bool app_le_audio_proc_bt_sink_event_group(struct _ui_shell_activity *self,
                                                  uint32_t event_id, void *extra_data, size_t data_len)
{
    switch (event_id) {
#ifdef AIR_LE_AUDIO_ENABLE
        case LE_SINK_SRV_EVENT_REMOTE_INFO_UPDATE: {
            bt_le_sink_srv_event_remote_info_update_t *ind = (bt_le_sink_srv_event_remote_info_update_t *)extra_data;
            if (ind == NULL) {
                break;
            }

            if (ind->pre_state == BT_BLE_LINK_DISCONNECTED && ind->state == BT_BLE_LINK_CONNECTED) {
                uint8_t *addr = app_lea_conn_mgr_get_unify_addr(ind->address.addr);
                app_le_audio_cancel_discoverable_mode(addr);
            }
            break;
        }
#endif
        default:
            break;
    }
    return FALSE;
}

static bool app_le_audio_proc_bt_ull2_event_group(struct _ui_shell_activity *self,
                                                  uint32_t event_id, void *extra_data, size_t data_len)
{
    switch (event_id) {
#ifdef AIR_BLE_ULTRA_LOW_LATENCY_ENABLE
        case BT_ULL_EVENT_LE_CONNECTED: {
            bt_handle_t handle = app_lea_conn_mgr_get_dongle_handle(APP_LEA_CONN_TYPE_LE_ULL);
            uint8_t *addr = app_lea_conn_mgr_get_addr_by_handle(handle);
            if (handle != BT_HANDLE_INVALID && addr != NULL) {
                app_le_audio_cancel_discoverable_mode(addr);
            }
            break;
        }
#endif
        default:
            break;
    }
    return FALSE;
}

#endif

static bool app_le_audio_proc_bt_group(struct _ui_shell_activity *self,
                                       uint32_t event_id,
                                       void *extra_data,
                                       size_t data_len)
{
    apps_bt_event_data_t *bt_event_data = (apps_bt_event_data_t *)extra_data;
    if (bt_event_data == NULL) {
        //APPS_LOG_MSGID_E(LOG_TAG" BT event, bt_event_data is NULL", 0);
        return FALSE;
    }
    switch (event_id) {
        case BT_POWER_ON_CNF: {
            /* Restart LE_Audio ADV if ever_connected */
            if (app_lea_conn_mgr_is_ever_connected()) {
#if (APP_LE_AUDIO_ADV_CONN_MODE == APP_LE_AUDIO_MODE_DEFAULT) && !defined(APP_CONN_MGR_RECONNECT_CONTROL)
                bt_aws_mce_role_t role = bt_connection_manager_device_local_info_get_aws_role();
                uint32_t connecting_num = bt_cm_get_connecting_devices(~BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS), NULL, 0);
                APPS_LOG_MSGID_I(LOG_TAG" BT_POWER_ON_CNF, [%02X] (DEFAULT) restart LEA ADV due to ever_connected %d",
                                 2, role, connecting_num);
                if (role == BT_AWS_MCE_ROLE_NONE && connecting_num > 0) {
                    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_LE_AUDIO, EVENT_ID_LE_AUDIO_DELAY_RESTART_ADV);
                    ui_shell_send_event(FALSE, EVENT_PRIORITY_HIGH,
                                        EVENT_GROUP_UI_SHELL_LE_AUDIO, EVENT_ID_LE_AUDIO_DELAY_RESTART_ADV,
                                        NULL, 0, NULL, 2000);
                } else {
                    app_lea_service_start_advertising(APP_LEA_ADV_MODE_TARGET_ALL, FALSE, 0);
                }
#elif (APP_LE_AUDIO_ADV_CONN_MODE == APP_LE_AUDIO_MODE_DONGLE_ONE)
                app_lea_bond_info_t *bond_info = app_lea_conn_mgr_get_bond_info();
                uint8_t empty_addr[BT_BD_ADDR_LEN] = {0};
                if (bond_info != NULL && bond_info[0].used
                    && memcmp(bond_info->bond_addr, empty_addr, BT_BD_ADDR_LEN) != 0) {
                    app_lea_adv_mgr_update_target_addr(APP_LEA_TARGET_SET_UNIQUE_ADDR, bond_info[0].addr_type, bond_info->bond_addr);
                    app_lea_service_start_advertising(APP_LEA_ADV_MODE_DIRECT, FALSE, APP_LE_AUDIO_DONGLE_ONE_ADV_TIME);
                    APPS_LOG_MSGID_I(LOG_TAG" BT_POWER_ON_CNF, (DONGLE_ONE) restart LEA ADV when ever_connected", 0);
                } else {
                    APPS_LOG_MSGID_E(LOG_TAG" BT_POWER_ON_CNF, (DONGLE_ONE) restart LEA ADV fail - ever_connected but bond_info error", 0);
                }
#endif
            } else {
#if (APP_LE_AUDIO_ADV_CONN_MODE == APP_LE_AUDIO_MODE_DONGLE_ONE)
                app_lea_service_start_advertising(APP_LEA_ADV_MODE_GENERAL, FALSE, APP_LE_AUDIO_DONGLE_ONE_ADV_TIME);
                APPS_LOG_MSGID_I(LOG_TAG" BT_POWER_ON_CNF, (DONGLE_ONE) start general adv", 0);
#else
                APPS_LOG_MSGID_I(LOG_TAG" BT_POWER_ON_CNF, no ever_connected", 0);
#endif
            }
            break;
        }
    }
    return FALSE;
}

#ifdef MTK_AWS_MCE_ENABLE
static bool app_le_audio_proc_aws_data_group(struct _ui_shell_activity *self,
                                             uint32_t event_id,
                                             void *extra_data,
                                             size_t data_len)
{
    uint32_t aws_event_group;
    uint32_t aws_event_id;
    void *p_extra_data = NULL;
    uint32_t extra_data_len = 0;
    bt_aws_mce_report_info_t *aws_data_ind = (bt_aws_mce_report_info_t *)extra_data;
    bt_aws_mce_role_t role = bt_connection_manager_device_local_info_get_aws_role();

    if (!aws_data_ind || aws_data_ind->module_id != BT_AWS_MCE_REPORT_MODULE_APP_ACTION) {
        return FALSE;
    }

    apps_aws_sync_event_decode_extra(aws_data_ind, &aws_event_group, &aws_event_id,
                                     &p_extra_data, &extra_data_len);
    if (aws_event_group == EVENT_GROUP_UI_SHELL_LE_AUDIO) {
        switch (aws_event_id) {
            case EVENT_ID_LE_AUDIO_SYNC_DISCONNECT_PARAM: {
                app_bt_lea_disconnect_param_t *param = (app_bt_lea_disconnect_param_t *)p_extra_data;
                APPS_LOG_MSGID_I(LOG_TAG" AWS_DATA, [%02X] SYNC_DISCONNECT_PARAM mode=%d", 2, role, param->mode);
                app_lea_service_disconnect(FALSE, param->mode, param->addr, param->reason);
                break;
            }

            case EVENT_ID_LE_AUDIO_SYNC_INFO: {
                app_lea_sync_info_t *info = (app_lea_sync_info_t *)p_extra_data;
                app_lea_sync_info_handle(info);
                break;
            }

#if (APP_LE_AUDIO_ADV_CONN_MODE == APP_LE_AUDIO_MODE_DEFAULT)
            case EVENT_ID_LE_AUDIO_SYNC_CONNECT_ADDR: {
                const uint8_t *addr = (uint8_t *)p_extra_data;
                bool connected = app_lea_conn_mgr_is_connected(addr);
                APPS_LOG_MSGID_I(LOG_TAG" AWS_DATA, [%02X] SYNC_CONNECT_ADDR connected=%d addr=%02X:%02X:%02X:%02X:%02X:%02X",
                                 8, role, connected, addr[5], addr[4], addr[3], addr[2], addr[1], addr[0]);
                if (role == BT_AWS_MCE_ROLE_AGENT && connected) {
                    app_bt_state_service_cancel_discoverable_mode();
                } else if (role == BT_AWS_MCE_ROLE_PARTNER && connected) {
                    app_le_audio_sync_visible_connect_addr(addr);
                }
                break;
            }
#endif
        }
    }
    return FALSE;
}
#endif

#ifdef AIR_SMART_CHARGER_ENABLE
static bool app_le_audio_proc_smcharger_group(struct _ui_shell_activity *self,
                                              uint32_t event_id,
                                              void *extra_data,
                                              size_t data_len)
{
    switch (event_id) {
        case SMCHARGER_EVENT_NOTIFY_ACTION: {
#if (APP_LE_AUDIO_ADV_CONN_MODE == APP_LE_AUDIO_MODE_DONGLE_ONE)
            app_smcharger_public_event_para_t *event_para = (app_smcharger_public_event_para_t *)extra_data;
            if (event_para->action != SMCHARGER_OPEN_LID_ACTION) {
                break;
            } else if (bt_cm_power_get_state() != BT_CM_POWER_STATE_ON) {
                // Ignore OPEN_LID_ACTION, start ADV in BT_POWER_ON_CNF
                APPS_LOG_MSGID_I(LOG_TAG" OPEN_LID_ACTION, BT not ON", 0);
                break;
            }

            if (app_lea_conn_mgr_is_ever_connected()) {
                app_lea_bond_info_t *bond_info = app_lea_conn_mgr_get_bond_info();
                uint8_t empty_addr[BT_BD_ADDR_LEN] = {0};
                if (bond_info != NULL && bond_info[0].used
                    && memcmp(bond_info->bond_addr, empty_addr, BT_BD_ADDR_LEN) != 0) {
                    app_lea_adv_mgr_update_target_addr(APP_LEA_TARGET_SET_UNIQUE_ADDR, bond_info[0].addr_type, bond_info->bond_addr);
                    app_lea_service_start_advertising(APP_LEA_ADV_MODE_DIRECT, FALSE, APP_LE_AUDIO_DONGLE_ONE_ADV_TIME);
                    APPS_LOG_MSGID_I(LOG_TAG" OPEN_LID_ACTION, (DONGLE_ONE) restart LEA ADV when ever_connected", 0);
                } else {
                    APPS_LOG_MSGID_E(LOG_TAG" OPEN_LID_ACTION, (DONGLE_ONE) restart LEA ADV fail - ever_connected but bond_info error", 0);
                }
            } else {
                app_lea_service_start_advertising(APP_LEA_ADV_MODE_GENERAL, FALSE, APP_LE_AUDIO_DONGLE_ONE_ADV_TIME);
                APPS_LOG_MSGID_I(LOG_TAG" OPEN_LID_ACTION, (DONGLE_ONE) start general adv", 0);
            }
#endif
            break;
        }
        default:
            break;
    }
    return FALSE;
}
#endif

static bool app_le_audio_proc_lea_group(struct _ui_shell_activity *self,
                                        uint32_t event_id,
                                        void *extra_data,
                                        size_t data_len)
{
    switch (event_id) {
        case EVENT_ID_LE_AUDIO_DELAY_RESTART_ADV: {
#ifndef APP_CONN_MGR_RECONNECT_CONTROL
            APPS_LOG_MSGID_I(LOG_TAG" lea_group, DELAY_RESTART_ADV", 0);
            app_lea_service_start_advertising(APP_LEA_ADV_MODE_TARGET_ALL, FALSE, 0);
#endif
            break;
        }
        default:
            break;
    }
    return TRUE;
}

static void app_le_audio_connection_callback(uint8_t conn_cb_type, int index,
                                             uint8_t addr_type, const uint8_t *addr,
                                             bt_hci_disconnect_reason_t reason)
{
    bt_aws_mce_role_t role = bt_connection_manager_device_local_info_get_aws_role();
    bool visible = app_bt_service_is_visible();
    APPS_LOG_MSGID_I(LOG_TAG" connection_callback, [%02X] conn_cb_type=%d index=%d addr_type=%d reason=0x%02X visible=%d",
                     6, role, conn_cb_type, index, addr_type, reason, visible);

#if defined(AIR_LE_AUDIO_ENABLE) && defined(AIR_INFORM_CONNECTION_STATUS_ENABLE)
    if (conn_cb_type == APP_LEA_CONN_CB_TYPE_CONNECTED) {
        app_le_audio_aird_client_infom_connection_status(TRUE);
    } else if (conn_cb_type == APP_LEA_CONN_CB_TYPE_DISCONNECTED) {
        app_le_audio_aird_client_infom_connection_status(FALSE);
    }
#endif

    if (conn_cb_type == APP_LEA_CONN_CB_TYPE_CONNECTED) {
        uint8_t cur_conn_num = app_lea_conn_mgr_get_conn_num();
        uint8_t support_max_conn_num = app_lea_conn_mgr_get_support_max_conn_num();
        if (cur_conn_num == support_max_conn_num) {
            APPS_LOG_MSGID_I(LOG_TAG" connection_callback, [%02X] stop ADV when LEA MAX LINK %d",
                             2, role, support_max_conn_num);
            app_lea_service_stop_advertising(FALSE);
        }

#if defined(AIR_USB_AUDIO_IN_ENABLE) && defined(AIR_WIRELESS_MIC_ENABLE)
        if (app_usb_audio_usb_plug_in()) {
            app_lea_conn_mgr_disconnect_dongle();
        }
#endif
    } else if (conn_cb_type == APP_LEA_CONN_CB_TYPE_DISCONNECTED) {
#if (APP_LE_AUDIO_ADV_CONN_MODE == APP_LE_AUDIO_MODE_DEFAULT)
        app_lea_service_start_advertising(APP_LEA_ADV_MODE_TARGET_ALL, FALSE, 0);
#elif (APP_LE_AUDIO_ADV_CONN_MODE == APP_LE_AUDIO_MODE_DONGLE_ONE)
        if (reason != BT_HCI_STATUS_CONNECTION_TERMINATED_BY_LOCAL_HOST
            && reason != BT_HCI_STATUS_LIMIT_REACHED) {
            app_lea_adv_mgr_update_target_addr(APP_LEA_TARGET_SET_UNIQUE_ADDR, addr_type, addr);
            app_lea_service_start_advertising(APP_LEA_ADV_MODE_DIRECT, FALSE, 0);
        }
#endif
#ifdef AIR_LE_AUDIO_ENABLE
        app_le_audio_aird_client_reset_info(index);
#endif
    } else if (conn_cb_type == APP_LEA_CONN_CB_TYPE_BONDED) {
#ifdef MTK_AWS_MCE_ENABLE
        if (app_bt_lea_disconnect_param.need_reuse
            && memcmp(app_bt_lea_disconnect_param.addr, addr, BT_BD_ADDR_LEN) == 0) {
            app_bt_lea_disconnect_param.need_reuse = FALSE;
            APPS_LOG_MSGID_W(LOG_TAG" LE audio bonded, clear disconnect_param", 0);
        }
#endif
    }
}



/**************************************************************************************************
 * Public function
**************************************************************************************************/
#ifndef MTK_AWS_MCE_ENABLE  // Headset project
bool app_le_audio_is_wired_audio(void)
{
    bool ret = FALSE;
    if ((app_le_audio_wired_state & APP_LE_AUDIO_WIRED_MASK(APP_LE_AUDIO_WIRED_LINE_IN))
        || (app_le_audio_wired_state & APP_LE_AUDIO_WIRED_MASK(APP_LE_AUDIO_WIRED_USB_IN))) {
        ret = TRUE;
    }
#if defined(AIR_USB_AUDIO_IN_ENABLE) && defined(AIR_WIRELESS_MIC_ENABLE)
    if (app_usb_audio_usb_plug_in()) {
        ret = true;
    }
#endif
    return ret;
}

static bool app_le_audio_proc_interaction_group(ui_shell_activity_t *self,
                                                uint32_t event_id,
                                                void *extra_data,
                                                size_t data_len)
{
    switch (event_id) {
#ifdef APPS_LINE_IN_SUPPORT
        case APPS_EVENTS_INTERACTION_LINE_IN_PLUG_STATE: {
            bool plug_in = (bool)extra_data;
            bool local_line_in_state = (app_le_audio_wired_state & APP_LE_AUDIO_WIRED_MASK(APP_LE_AUDIO_WIRED_LINE_IN));
            APPS_LOG_MSGID_I(LOG_TAG" interaction event, line_in=%d->%d", 2, local_line_in_state, plug_in);
            if (plug_in != local_line_in_state) {
                if (plug_in) {
                    app_le_audio_wired_state |= APP_LE_AUDIO_WIRED_MASK(APP_LE_AUDIO_WIRED_LINE_IN);
                    app_lea_service_stop_advertising(FALSE);
                    app_lea_conn_mgr_disconnect_dongle();
                } else {
                    app_le_audio_wired_state &= ~APP_LE_AUDIO_WIRED_MASK(APP_LE_AUDIO_WIRED_LINE_IN);
                    if (app_le_audio_wired_state == 0) {
                        app_lea_service_start_advertising(APP_LEA_ADV_MODE_TARGET_ALL, FALSE, 0);
                    }
                }
            }
            break;
        }
#endif
#ifdef APPS_USB_AUDIO_SUPPORT
        case APPS_EVENTS_INTERACTION_USB_PLUG_STATE: {
            bool plug_in = (bool)extra_data;
            bool local_usb_in_state = (app_le_audio_wired_state & APP_LE_AUDIO_WIRED_MASK(APP_LE_AUDIO_WIRED_USB_IN));
            APPS_LOG_MSGID_I(LOG_TAG" interaction event, usb_in=%d->%d", 2, local_usb_in_state, plug_in);
#if 0
            bool is_vbus_plug = is_vusb_ready();
            APPS_LOG_MSGID_I(LOG_TAG" interaction event, USB_PLUG-is_vbus_plug=%d", 1, is_vbus_plug);
            if (is_vbus_plug && !plug_in) {
                break;
            }
#endif
            if (plug_in != local_usb_in_state) {
                if (plug_in) {
                    app_le_audio_wired_state |= APP_LE_AUDIO_WIRED_MASK(APP_LE_AUDIO_WIRED_USB_IN);
                    app_lea_service_stop_advertising(FALSE);
                    app_lea_conn_mgr_disconnect_dongle();
                } else {
                    app_le_audio_wired_state &= ~APP_LE_AUDIO_WIRED_MASK(APP_LE_AUDIO_WIRED_USB_IN);
                    if (app_le_audio_wired_state == 0) {
                        app_lea_service_start_advertising(APP_LEA_ADV_MODE_TARGET_ALL, FALSE, 0);
                    }
                }
            }
            break;
        }
#endif
        default:
            break;
    }

    return FALSE;
}
#endif

void app_lea_service_disconnect(bool sync,
                                app_le_audio_disconnect_mode_t mode,
                                const uint8_t *addr,
                                bt_hci_disconnect_reason_t reason)
{
    bt_handle_t conn_handle = BT_HANDLE_INVALID;

    if (addr != NULL) {
        APPS_LOG_MSGID_I(LOG_TAG" disconnect, sync=%d mode=%d addr=%02X:%02X:%02X:%02X:%02X:XX reason=0x%02X ",
                         8, sync, mode, addr[5], addr[4], addr[3], addr[2], addr[1], reason);
    } else if (mode != APP_LE_AUDIO_DISCONNECT_MODE_DISCONNECT_ULL) {
        APPS_LOG_MSGID_I(LOG_TAG" disconnect, sync=%d mode=%d addr=NULL reason=0x%02X", 3, sync, mode, reason);
        mode = APP_LE_AUDIO_DISCONNECT_MODE_ALL;
    }

#ifdef MTK_AWS_MCE_ENABLE
    if (sync) {
        app_le_audio_sync_lea_disconnect_peer(mode, addr, reason);
    }
#endif

    if (mode == APP_LE_AUDIO_DISCONNECT_MODE_ALL) {
        for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
            conn_handle = app_lea_conn_mgr_get_handle(i);
            if (BT_HANDLE_INVALID != conn_handle) {
                app_lea_conn_mgr_disconnect_by_handle(conn_handle, reason);
            }
        }
    } else if (mode == APP_LE_AUDIO_DISCONNECT_MODE_DISCONNECT) {
        conn_handle = app_lea_conn_mgr_get_handle_by_addr(addr);
        if (conn_handle != BT_HANDLE_INVALID) {
            app_lea_conn_mgr_disconnect_by_handle(conn_handle, reason);
        } else {
            APPS_LOG_MSGID_E(LOG_TAG" disconnect, invalid conn_handle", 0);
        }
    } else if (mode == APP_LE_AUDIO_DISCONNECT_MODE_DISCONNECT_ULL) {
        conn_handle = app_lea_conn_mgr_get_dongle_handle(APP_LEA_CONN_TYPE_LE_ULL);
        if (conn_handle != BT_HANDLE_INVALID) {
            app_lea_conn_mgr_disconnect_by_handle(conn_handle, reason);
        } else {
            APPS_LOG_MSGID_E(LOG_TAG" disconnect, invalid ULL2 conn_handle", 0);
        }
    } else if (mode == APP_LE_AUDIO_DISCONNECT_MODE_KEEP) {
        bt_handle_t keep_conn_handle = app_lea_conn_mgr_get_handle_by_addr(addr);
        APPS_LOG_MSGID_I(LOG_TAG" disconnect, want keep conn_handle=0x%08X", 1, keep_conn_handle);
        for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
            conn_handle = app_lea_conn_mgr_get_handle(i);
            if (BT_HANDLE_INVALID != conn_handle && conn_handle != keep_conn_handle) {
                app_lea_conn_mgr_disconnect_by_handle(conn_handle, reason);
            }
        }
    }
}

bool app_lea_service_activity_proc(struct _ui_shell_activity *self, uint32_t event_group, uint32_t event_id, void *extra_data, size_t data_len)
{
    bool ret = FALSE;
    switch (event_group) {
        case EVENT_GROUP_UI_SHELL_BT_CONN_MANAGER: {
            ret = app_le_audio_proc_bt_cm_group(self, event_id, extra_data, data_len);
            break;
        }
        case EVENT_GROUP_UI_SHELL_BT: {
            ret = app_le_audio_proc_bt_group(self, event_id, extra_data, data_len);
            break;
        }
#if (APP_LE_AUDIO_ADV_CONN_MODE == APP_LE_AUDIO_MODE_DEFAULT)
        case EVENT_GROUP_UI_SHELL_BT_SINK: {
            ret = app_le_audio_proc_bt_sink_event_group(self, event_id, extra_data, data_len);
            break;
        }
        case EVENT_GROUP_BT_ULTRA_LOW_LATENCY: {
            ret = app_le_audio_proc_bt_ull2_event_group(self, event_id, extra_data, data_len);
            break;
        }
#endif
#ifdef MTK_AWS_MCE_ENABLE
        case EVENT_GROUP_UI_SHELL_AWS_DATA:
            ret = app_le_audio_proc_aws_data_group(self, event_id, extra_data, data_len);
            break;
#endif
#ifdef AIR_SMART_CHARGER_ENABLE
        case EVENT_GROUP_UI_SHELL_CHARGER_CASE:
            ret = app_le_audio_proc_smcharger_group(self, event_id, extra_data, data_len);
            break;
#endif
        case EVENT_GROUP_UI_SHELL_LE_AUDIO: {
            ret = app_le_audio_proc_lea_group(self, event_id, extra_data, data_len);
            break;
        }
#ifndef MTK_AWS_MCE_ENABLE  // Headset project
        case EVENT_GROUP_UI_SHELL_APP_INTERACTION: {
            ret = app_le_audio_proc_interaction_group(self, event_id, extra_data, data_len);
            break;
        }
#endif
        default:
            break;
    }

    app_lea_conn_mgr_proc_ui_shell_event(event_group, event_id, extra_data, data_len);
    app_lea_adv_mgr_proc_ui_shell_event(event_group, event_id, extra_data, data_len);
#ifdef AIR_LE_AUDIO_ENABLE
    app_le_audio_idle_activity_proc(self, event_group, event_id, extra_data, data_len);
#endif
    return ret;
}

void app_lea_service_enable_multi_conn(bool enable)
{
    app_lea_conn_mgr_enable_multi_conn(enable);
}

void app_lea_service_start_advertising(uint8_t mode, bool sync, uint32_t timeout)
{
    app_lea_adv_mgr_start_advertising(mode, sync, timeout);
}

void app_lea_service_stop_advertising(bool sync)
{
    app_lea_adv_mgr_stop_advertising(sync);
}

bool app_lea_service_control_adv_data(uint8_t adv_type, bool enable)
{
    return app_lea_adv_mgr_control_adv_data(adv_type, enable);
}

void app_lea_service_init(void)
{
    APPS_LOG_MSGID_I(LOG_TAG" app_lea_service_init", 0);
#if defined(AIR_MULTI_POINT_ENABLE)
    // config in app_bt_emp_service
#else
    app_lea_conn_mgr_enable_multi_conn(FALSE);
#endif

    app_lea_adv_mgr_init();
    app_lea_conn_mgr_init();
    app_lea_conn_mgr_register_connection_cb(app_le_audio_connection_callback);

#ifdef AIR_LE_AUDIO_ENABLE
    app_le_audio_init();
#endif
}

#endif  /* AIR_LE_AUDIO_ENABLE || AIR_BLE_ULTRA_LOW_LATENCY_ENABLE */

