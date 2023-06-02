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

#ifdef AIR_SWIFT_PAIR_ENABLE

#include "app_swift_pair_idle_activity.h"

#include "app_swift_cust_pair.h"

#include "apps_events_bt_event.h"
#include "apps_debug.h"
#include "apps_events_event_group.h"

#include "bt_app_common.h"
#include "bt_callback_manager.h"
#include "bt_connection_manager.h"
#include "bt_connection_manager_internal.h"
#include "bt_customer_config.h"
#include "bt_device_manager.h"
#include "bt_device_manager_le.h"
#include "bt_hci.h"
#include "bt_gap.h"
#include "bt_gap_le.h"
#include "bt_gatt.h"
#include "bt_gatts.h"
#include "bt_system.h"
#include "multi_ble_adv_manager.h"
#include "ui_shell_manager.h"



/**================================================================================*/
/**                              Definition & Structure                            */
/**================================================================================*/
#define LOG_TAG                             "[SWIFT_PAIR]"

#define APP_SWIFT_PAIR_QUICK_MIN_ADV_INTERVAL         (0x0030)              // 30ms
#define APP_SWIFT_PAIR_QUICK_MAX_ADV_INTERVAL         (0x00A0)              // 100ms
#define APP_SWIFT_PAIR_NORMAL_MIN_ADV_INTERVAL        (0x00A0)              // 100ms
#define APP_SWIFT_PAIR_NORMAL_MAX_ADV_INTERVAL        (0x01E0)              // 300ms

#define APP_SWIFT_PAIR_QUICK_TIMEOUT                  (30 * 1000)
#define APP_SWIFT_PAIR_TIMEOUT                        (2 * 60 * 1000)       // 2min

#define BLE_AD_TYPE_COMPLETE_LOCAL_NAME               0x09

typedef struct {
    bool            is_quick_adv;
#ifdef APP_SWIFT_PAIR_LE_EDR_SECURE_MODE
    uint16_t        conn_handle;
#endif
} app_swift_pair_context_t;

static app_swift_pair_context_t             app_swift_pair_ctx = {0};



/**================================================================================*/
/**                                Internal Function                               */
/**================================================================================*/
#ifdef APP_SWIFT_PAIR_LE_EDR_SECURE_MODE
static bt_status_t app_swift_pair_srv_common_event_handler(bt_msg_type_t msg, bt_status_t status, void *buf)
{
    switch (msg) {
        case BT_GAP_LE_CONNECT_IND: {
            bt_gap_le_connection_ind_t *conn_ind = (bt_gap_le_connection_ind_t *)buf;
            if (conn_ind == NULL || BT_HANDLE_INVALID == conn_ind->connection_handle) {
                break;
            }

            uint16_t conn_handle = conn_ind->connection_handle;
            uint8_t *local_addr = (uint8_t *)conn_ind->local_addr.addr;
            bt_addr_type_t peer_addr_type = conn_ind->peer_addr.type;
            uint8_t *peer_addr = (uint8_t *)conn_ind->peer_addr.addr;

            //uint8_t *edr_addr = (uint8_t *)bt_device_manager_get_local_address();
            //bool is_edr_addr = (memcmp(local_addr, edr_addr, BT_BD_ADDR_LEN) == 0);
            bt_bd_addr_t adv_addr = {0};
            bool is_swift_addr = FALSE;
            if (multi_ble_adv_manager_get_random_addr_and_adv_handle(MULTI_ADV_INSTANCE_SWIFT_PAIR, &adv_addr, NULL)) {
                is_swift_addr = (memcmp(&adv_addr, local_addr, BT_BD_ADDR_LEN) == 0);
            }

            if (/*!is_edr_addr && */!is_swift_addr) {
                APPS_LOG_MSGID_E(LOG_TAG" LE_CONNECT_IND, not swift_pair conn_handle=0x%04X local_addr=%02X:%02X:%02X:%02X:%02X:%02X",
                                 7, conn_handle, local_addr[5], local_addr[4], local_addr[3],
                                 local_addr[2], local_addr[1], local_addr[0]);
                break;
            }

            APPS_LOG_MSGID_I(LOG_TAG" LE_CONNECT_IND, conn_handle=0x%04X peer_addr=%02X:%02X:%02X:%02X:%02X:%02X addr_type=%d",
                             8, conn_handle, peer_addr[5], peer_addr[4], peer_addr[3],
                             peer_addr[2], peer_addr[1], peer_addr[0], peer_addr_type);

            if (app_swift_pair_ctx.conn_handle != BT_HANDLE_INVALID
                && app_swift_pair_ctx.conn_handle != conn_handle) {
                APPS_LOG_MSGID_E(LOG_TAG" LE_CONNECT_IND, only support one swift_pair ongoing", 0);
                break;
            }

            app_swift_pair_ctx.conn_handle = conn_handle;
            break;
        }

        case BT_GAP_LE_DISCONNECT_IND: {
            bt_hci_evt_disconnect_complete_t *disconn_ind = (bt_hci_evt_disconnect_complete_t *)buf;
            if (disconn_ind == NULL || disconn_ind->connection_handle == BT_HANDLE_INVALID) {
                break;
            }

            uint16_t conn_handle = disconn_ind->connection_handle;
            APPS_LOG_MSGID_I(LOG_TAG" BT_GAP_LE_DISCONNECT_IND, swift_handle=0x%04X conn_handle=0x%04X",
                             2, app_swift_pair_ctx.conn_handle, conn_handle);
            if (app_swift_pair_ctx.conn_handle == conn_handle) {
                app_swift_pair_ctx.conn_handle = BT_HANDLE_INVALID;
            }
            break;
        }

        case BT_POWER_OFF_CNF: {
            APPS_LOG_MSGID_I(LOG_TAG" BT_POWER_OFF_CNF", 0);
            app_swift_pair_ctx.conn_handle = BT_HANDLE_INVALID;
            break;
        }

        default:
            break;
    }

    return BT_STATUS_SUCCESS;
}
#endif

static void app_swift_pair_get_adv_data(bt_gap_le_set_ext_advertising_data_t *data)
{
    if (data == NULL) {
        //APPS_LOG_MSGID_E(LOG_TAG" get_adv_data, NULL data", 0);
        return;
    }

    uint8_t *addr = (uint8_t *)bt_device_manager_get_local_address();
    if (addr == NULL) {
        //APPS_LOG_MSGID_E(LOG_TAG" get_adv_data, NULL local addr", 0);
        return;
    }

#ifdef APP_SWIFT_PAIR_LE_EDR_SECURE_MODE
#define APP_SWIFT_PAIR_MAX_PARAM_LEN        10
#define APP_SWIFT_PAIR_MAX_NAME_LEN         (BT_HCI_LE_ADVERTISING_DATA_LENGTH_MAXIMUM - APP_SWIFT_PAIR_MAX_PARAM_LEN)

    uint8_t data_context[BT_HCI_LE_ADVERTISING_DATA_LENGTH_MAXIMUM] = {17,                   // Len
                                                                       0xFF, 0x06, 0x00,     // Company <0x0006> Micorsoft
                                                                       0x03, 0x02,           // Type: Swift Pair Beacon
                                                                       0x80,                 // RSSI
                                                                       0x18, 0x04, 0x20,     // Cod[3] http://bluetooth-pentest.narod.ru/software/bluetooth_class_of_device-service_generator.html
                                                                       'A',                  // Display Name
                                                                      };

    const bt_gap_config_t *cust_config = bt_customer_config_get_gap_config();
    if (cust_config != NULL) {
        uint8_t name_length = strlen(cust_config->device_name);
        if (name_length > APP_SWIFT_PAIR_MAX_NAME_LEN) {
            //APPS_LOG_MSGID_E(LOG_TAG" get_adv_data, name length %d > %d", 1, name_length, APP_SWIFT_PAIR_MAX_NAME_LEN);
            name_length = APP_SWIFT_PAIR_MAX_NAME_LEN;
        }
        memcpy(&data_context[APP_SWIFT_PAIR_MAX_PARAM_LEN], cust_config->device_name, name_length);
        data_context[0] = APP_SWIFT_PAIR_MAX_PARAM_LEN - 1 + name_length;
    }

    data->data_length = data_context[0] + 1;
    data->fragment_preference = 0x00;

    memcpy(data->data, data_context, data->data_length);

    APPS_LOG_MSGID_I(LOG_TAG" get_adv_data [LEA/EDR], addr=%02X:%02X:%02X:%02X:%02X:%02X len=%d", 7,
                     addr[5], addr[4], addr[3], addr[2], addr[1], addr[0], data->data_length);

#else
#define APP_SWIFT_PAIR_MAX_PARAM_LEN        16
#define APP_SWIFT_PAIR_MAX_NAME_LEN         (BT_HCI_LE_ADVERTISING_DATA_LENGTH_MAXIMUM - APP_SWIFT_PAIR_MAX_PARAM_LEN)

    const bt_gap_config_t *cust_config = bt_customer_config_get_gap_config();
    uint8_t data_context[31] = { 23,                                    // Len
                                 0xFF, 0x06, 0x00,                      // Company <0x0006> Micorsoft
                                 0x03, 0x01,                            // Type: Swift Pair Beacon
                                 0x80,                                  // RSSI
                                 0x33, 0x33, 0x33, 0xFF, 0xFF, 0xFF,    // BD Addr
                                 0x18, 0x04, 0x20,                      // Cod[3] http://bluetooth-pentest.narod.ru/software/bluetooth_class_of_device-service_generator.html
                                 'A', 'I', 'R', 'O', 'H', 'A', 'B', 'T',// Display Name
                                 0
                               };
    // BT Addr, little endian.
    memcpy(&data_context[7], addr, BT_BD_ADDR_LEN);

    if (cust_config != NULL) {
        uint8_t name_length = strlen(cust_config->device_name);
        if (name_length > APP_SWIFT_PAIR_MAX_NAME_LEN) {
            //APPS_LOG_MSGID_E(LOG_TAG" get_adv_data, name length %d > %d", 1, name_length, APP_SWIFT_PAIR_MAX_NAME_LEN);
            name_length = APP_SWIFT_PAIR_MAX_NAME_LEN;
        }
        memcpy(&data_context[APP_SWIFT_PAIR_MAX_PARAM_LEN], cust_config->device_name, name_length);
        data_context[0] = APP_SWIFT_PAIR_MAX_PARAM_LEN - 1 + name_length;
    }

    data->data_length = data_context[0] + 1;
    data->fragment_preference = 0x00;

    memcpy(data->data, data_context, data->data_length);

    APPS_LOG_MSGID_I(LOG_TAG" get_adv_data [EDR only], addr=%02X:%02X:%02X:%02X:%02X:%02X len=%d", 7,
                     addr[5], addr[4], addr[3], addr[2], addr[1], addr[0], data->data_length);
#endif
}

static void app_swift_pair_get_adv_param(bt_hci_le_set_ext_advertising_parameters_t *adv_param)
{
    if (adv_param == NULL) {
        //APPS_LOG_MSGID_E(LOG_TAG" get_adv_param, NULL adv_param", 0);
        return;
    }

    bt_app_common_generate_default_adv_data(adv_param, NULL, NULL, NULL, 0);

    APPS_LOG_MSGID_I(LOG_TAG" get_adv_param, is_quick_adv=%d", 1, app_swift_pair_ctx.is_quick_adv);
    if (app_swift_pair_ctx.is_quick_adv) {
        adv_param->primary_advertising_interval_min = APP_SWIFT_PAIR_QUICK_MIN_ADV_INTERVAL;
        adv_param->primary_advertising_interval_max = APP_SWIFT_PAIR_QUICK_MAX_ADV_INTERVAL;
    } else {
        adv_param->primary_advertising_interval_min = APP_SWIFT_PAIR_NORMAL_MIN_ADV_INTERVAL;
        adv_param->primary_advertising_interval_max = APP_SWIFT_PAIR_NORMAL_MAX_ADV_INTERVAL;
    }

#ifdef APP_SWIFT_PAIR_LE_EDR_SECURE_MODE
    adv_param->own_address_type = BT_ADDR_RANDOM; // BT_ADDR_PUBLIC
#else
    adv_param->own_address_type = BT_ADDR_RANDOM;
#endif
    memset(&(adv_param->peer_address), 0, sizeof(bt_addr_t));
}

static void app_swift_pair_get_scan_rsp(bt_gap_le_set_ext_scan_response_data_t *scan_rsp)
{
    if (scan_rsp == NULL) {
        //APPS_LOG_MSGID_E(LOG_TAG" get_scan_rsp, NULL scan_rsp", 0);
        return;
    }

    const bt_gap_config_t *cust_config = bt_customer_config_get_gap_config();
    if (cust_config == NULL || cust_config->device_name == NULL || strlen(cust_config->device_name) == 0) {
        //APPS_LOG_MSGID_E(LOG_TAG" get_scan_rsp, NULL cust_config or name", 0);
        return;
    }

    uint8_t rsp[BT_HCI_LE_ADVERTISING_DATA_LENGTH_MAXIMUM] = {0, BLE_AD_TYPE_COMPLETE_LOCAL_NAME, 0};

    const char *name = cust_config->device_name;
    uint8_t max_name_len = strlen(cust_config->device_name);
    max_name_len = (max_name_len >= (BT_HCI_LE_ADVERTISING_DATA_LENGTH_MAXIMUM - 2) ? (BT_HCI_LE_ADVERTISING_DATA_LENGTH_MAXIMUM - 2) : max_name_len);
    memcpy(rsp + 2, name, max_name_len);
    rsp[0] = max_name_len + 1;

    scan_rsp->data_length = max_name_len + 2;
    scan_rsp->fragment_preference = 0x00;

    memcpy(scan_rsp->data, rsp, scan_rsp->data_length);
}

static uint32_t app_swift_pair_adv_info(multi_ble_adv_info_t *adv_info)
{
    if (adv_info == NULL) {
        return 0;
    }

    if (adv_info->adv_param != NULL) {
        app_swift_pair_get_adv_param(adv_info->adv_param);
    }
    if (adv_info->adv_data != NULL) {
        app_swift_pair_get_adv_data(adv_info->adv_data);
    }
    if (adv_info->scan_rsp != NULL) {
        app_swift_pair_get_scan_rsp(adv_info->scan_rsp);
    }
    return 0;
}

static bool app_swift_pair_update_adv(void)
{
    APPS_LOG_MSGID_I(LOG_TAG" update_adv, is_quick_adv=%d", 1, app_swift_pair_ctx.is_quick_adv);

    multi_ble_adv_manager_remove_ble_adv(MULTI_ADV_INSTANCE_SWIFT_PAIR, app_swift_pair_adv_info);
    multi_ble_adv_manager_add_ble_adv(MULTI_ADV_INSTANCE_SWIFT_PAIR, app_swift_pair_adv_info, 1);
    multi_ble_adv_manager_notify_ble_adv_data_changed(MULTI_ADV_INSTANCE_SWIFT_PAIR);

    return TRUE;
}

static bool app_swift_pair_start_adv(void)
{
    app_swift_pair_ctx.is_quick_adv = TRUE;
    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_SWIFT_PAIR, APP_SWIFT_PAIR_EVENT_SWIFT_QUICK_TIMEOUT);
    ui_shell_send_event(FALSE, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_SWIFT_PAIR,
                        APP_SWIFT_PAIR_EVENT_SWIFT_QUICK_TIMEOUT, NULL, 0, NULL, APP_SWIFT_PAIR_QUICK_TIMEOUT);

    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_SWIFT_PAIR, APP_SWIFT_PAIR_EVENT_SWIFT_ADV_TIMEOUT);
    ui_shell_send_event(FALSE, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_SWIFT_PAIR,
                        APP_SWIFT_PAIR_EVENT_SWIFT_ADV_TIMEOUT, NULL, 0, NULL, APP_SWIFT_PAIR_TIMEOUT);

    multi_ble_adv_manager_remove_ble_adv(MULTI_ADV_INSTANCE_SWIFT_PAIR, app_swift_pair_adv_info);
    multi_ble_adv_manager_add_ble_adv(MULTI_ADV_INSTANCE_SWIFT_PAIR, app_swift_pair_adv_info, 1);
    multi_ble_adv_manager_notify_ble_adv_data_changed(MULTI_ADV_INSTANCE_SWIFT_PAIR);

    APPS_LOG_MSGID_I(LOG_TAG" start_adv", 0);
    return TRUE;
}

static bool app_swift_pair_stop_adv(void)
{
    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_SWIFT_PAIR, APP_SWIFT_PAIR_EVENT_SWIFT_QUICK_TIMEOUT);
    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_SWIFT_PAIR, APP_SWIFT_PAIR_EVENT_SWIFT_ADV_TIMEOUT);

    multi_ble_adv_manager_remove_ble_adv(MULTI_ADV_INSTANCE_SWIFT_PAIR, app_swift_pair_adv_info);
    multi_ble_adv_manager_notify_ble_adv_data_changed(MULTI_ADV_INSTANCE_SWIFT_PAIR);

    app_swift_pair_ctx.is_quick_adv = FALSE;

    APPS_LOG_MSGID_I(LOG_TAG" stop_adv", 0);
    return TRUE;
}

static bool app_swift_pair_proc_ui_shell_group(ui_shell_activity_t *self, uint32_t event_id, void *extra_data, size_t data_len)
{
    switch (event_id) {
        case EVENT_ID_SHELL_SYSTEM_ON_CREATE: {
            app_swift_pair_ctx.is_quick_adv = FALSE;

#ifdef APP_SWIFT_PAIR_LE_EDR_SECURE_MODE
            bt_callback_manager_register_callback(bt_callback_type_app_event,
                                                  MODULE_MASK_SYSTEM | MODULE_MASK_GAP | MODULE_MASK_GATT | MODULE_MASK_MM,
                                                  (void *)app_swift_pair_srv_common_event_handler);
            app_swift_pair_ctx.conn_handle = BT_HANDLE_INVALID;
#endif
            break;
        }
        default:
            break;
    }
    return TRUE;
}

static bool app_swift_pair_proc_swift_pair_group(ui_shell_activity_t *self, uint32_t event_id, void *extra_data, size_t data_len)
{
    switch (event_id) {
        case APP_SWIFT_PAIR_EVENT_RESTART_ADV: {
            //APPS_LOG_MSGID_I(LOG_TAG" swift_pair event, restart_adv", 0);
            app_swift_pair_update_adv();
            break;
        }

        case APP_SWIFT_PAIR_EVENT_SWIFT_ADV_TIMEOUT: {
            //APPS_LOG_MSGID_I(LOG_TAG" swift_pair event, adv timeout", 0);
            //app_swift_pair_stop_adv();
            break;
        }

        case APP_SWIFT_PAIR_EVENT_SWIFT_QUICK_TIMEOUT: {
            //APPS_LOG_MSGID_I(LOG_TAG" swift_pair event, quick_adv timeout", 0);
            app_swift_pair_ctx.is_quick_adv = FALSE;
            app_swift_pair_update_adv();
            break;
        }

        default:
            break;
    }
    return TRUE;
}

static bool app_swift_pair_proc_bt_cm_group(ui_shell_activity_t *self, uint32_t event_id, void *extra_data, size_t data_len)
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
                if (remote_update->pre_acl_state != BT_CM_ACL_LINK_ENCRYPTED
                    && remote_update->acl_state == BT_CM_ACL_LINK_ENCRYPTED
                    && phone_related) {
                    APPS_LOG_MSGID_I(LOG_TAG" BT_CM event, Remote connected", 0);
                    app_swift_pair_stop_adv();
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
                app_swift_pair_start_adv();
            } else {
                app_swift_pair_stop_adv();
            }
            break;
        }
        default:
            break;
    }
    return FALSE;
}



/**================================================================================*/
/**                                     Public API                                 */
/**================================================================================*/
void app_swift_pair_restart_adv(void)
{
    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_SWIFT_PAIR, APP_SWIFT_PAIR_EVENT_SWIFT_ADV_TIMEOUT);

    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_SWIFT_PAIR, APP_SWIFT_PAIR_EVENT_RESTART_ADV);
    ui_shell_send_event(FALSE, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_SWIFT_PAIR,
                        APP_SWIFT_PAIR_EVENT_RESTART_ADV, NULL, 0, NULL, 0);
    APPS_LOG_MSGID_I(LOG_TAG" restart_adv", 0);
}

uint16_t app_swift_pair_get_conn_handle(void)
{
#ifdef APP_SWIFT_PAIR_LE_EDR_SECURE_MODE
    return app_swift_pair_ctx.conn_handle;
#else
    return BT_HANDLE_INVALID;
#endif
}

bool app_swift_pair_idle_activity_proc(struct _ui_shell_activity *self,
                                       uint32_t event_group,
                                       uint32_t event_id,
                                       void *extra_data,
                                       size_t data_len)
{
    bool ret = FALSE;
    switch (event_group) {
        case EVENT_GROUP_UI_SHELL_SYSTEM: {
            ret = app_swift_pair_proc_ui_shell_group(self, event_id, extra_data, data_len);
            break;
        }
        case EVENT_GROUP_UI_SHELL_SWIFT_PAIR: {
            ret = app_swift_pair_proc_swift_pair_group(self, event_id, extra_data, data_len);
            break;
        }
        case EVENT_GROUP_UI_SHELL_BT_CONN_MANAGER: {
            ret = app_swift_pair_proc_bt_cm_group(self, event_id, extra_data, data_len);
            break;
        }
        default:
            break;
    }
    return ret;
}

#endif
