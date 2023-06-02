
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
 * File: app_le_audio_conn_mgr.c
 *
 * Description: This file provides API for LE Audio connection manage.
 *
 */

#if defined(AIR_LE_AUDIO_ENABLE) || defined(AIR_BLE_ULTRA_LOW_LATENCY_ENABLE)

#include "app_lea_service_conn_mgr.h"

#include "app_lea_service.h"
#include "app_lea_service_adv_mgr.h"
#include "app_lea_service_event.h"

#ifdef AIR_LE_AUDIO_ENABLE
#include "app_le_audio_aird_client.h"
#endif

#include "apps_debug.h"
#include "apps_events_bt_event.h"
#include "apps_events_event_group.h"
#include "apps_events_interaction_event.h"

#ifdef MTK_AWS_MCE_ENABLE
#include "bt_aws_mce_srv.h"
#include "apps_aws_sync_event.h"
#endif

#include "bt_aws_mce_srv.h"
#include "bt_customer_config.h"
#include "bt_device_manager.h"
#include "bt_device_manager_le.h"
#include "bt_gattc_discovery.h"
#include "bt_gap_le.h"
#include "bt_sink_srv_le.h"

#include "multi_ble_adv_manager.h"
#include "nvkey.h"
#include "nvkey_id_list.h"
#include "ui_shell_manager.h"
#ifdef AIR_MULTI_POINT_ENABLE
#include "app_bt_emp_service.h"
#endif
#ifdef AIR_BT_TAKEOVER_ENABLE
#include "app_bt_takeover_service.h"
#endif



#define LOG_TAG             "[LEA][CONN]"

#define APP_LEA_NORMAL_CONN_INTERVAL                       (0x0030) // 0x30, 60ms=48*1.25

typedef struct {
    bt_handle_t                 conn_handle;
    app_lea_conn_type_t         conn_type;
    uint8_t                     peer_random_addr[BT_BD_ADDR_LEN];
    uint8_t                     peer_type;
    uint8_t                     peer_id_addr[BT_BD_ADDR_LEN];
#ifdef AIR_LE_AUDIO_ENABLE
    uint16_t                    conn_interval;
    uint16_t                    conn_latency;
    uint16_t                    supervision_timeout;
#endif
} PACKED app_lea_conn_info_t;

static app_lea_conn_info_t                 app_lea_conn_info_list[APP_LEA_MAX_CONN_NUM];

#define APP_LEA_BOND_INFO_LENGTH           (sizeof(app_lea_bond_info_t) * APP_LEA_MAX_BOND_NUM)
static app_lea_bond_info_t                 app_lea_bond_info_list[APP_LEA_MAX_BOND_NUM];

static app_lea_conn_mgr_connection_cb_t    app_lea_connection_cb = NULL;



/**================================================================================*/
/**                                   Internal API                                 */
/**================================================================================*/
static void app_lea_conn_mgr_save_bond_info(void);

#define APP_LEA_IS_EMPTY_ADDR(X, EMPTY)        (memcmp((X), (EMPTY), BT_BD_ADDR_LEN) == 0)

static uint8_t app_lea_conn_mgr_get_link_count(void)
{
    uint8_t conn_num = 0;
    for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
        if (app_lea_conn_info_list[i].conn_handle != BT_HANDLE_INVALID) {
            conn_num++;
        }
    }
    return conn_num;
}

static void app_lea_conn_mgr_clear_conn_info(void)
{
    APPS_LOG_MSGID_I(LOG_TAG" clear_conn_info", 0);
    memset(&app_lea_conn_info_list[0], 0, APP_LEA_MAX_CONN_NUM * sizeof(app_lea_conn_info_t));
    for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
        app_lea_conn_info_list[i].conn_handle = BT_HANDLE_INVALID;
    }
}

static void app_lea_conn_mgr_print_bond_info(bool now)
{
    for (int i = 0; i < APP_LEA_MAX_BOND_NUM; i++) {
        const uint8_t *addr = app_lea_bond_info_list[i].bond_addr;
        if (now) {
            APPS_LOG_MSGID_I(LOG_TAG" update_bond_info, [now][%d] used=%d addr_type=%d bond_addr=%02X:%02X:%02X:%02X:%02X:XX",
                             8, i, app_lea_bond_info_list[i].used, app_lea_bond_info_list[i].addr_type,
                             addr[5], addr[4], addr[3], addr[2], addr[1]);
        } else {
            APPS_LOG_MSGID_I(LOG_TAG" update_bond_info, [before][%d] used=%d addr_type=%d bond_addr=%02X:%02X:%02X:%02X:%02X:XX",
                             8, i, app_lea_bond_info_list[i].used, app_lea_bond_info_list[i].addr_type,
                             addr[5], addr[4], addr[3], addr[2], addr[1]);
        }
    }
}

static bool app_lea_conn_mgr_update_bond_info(uint8_t addr_type, uint8_t *bd_addr, uint8_t conn_type)
{
    bool duplicate = FALSE;
    uint8_t empty_addr[BT_BD_ADDR_LEN] = {0};

    if (APP_LEA_IS_EMPTY_ADDR(bd_addr, empty_addr) || addr_type > BT_ADDR_RANDOM_IDENTITY) {
        APPS_LOG_MSGID_I(LOG_TAG" update_bond_info, error addr/type", 0);
        return FALSE;
    }

    app_lea_conn_mgr_print_bond_info(FALSE);
    for (int i = 0; i < APP_LEA_MAX_BOND_NUM; i++) {
        const uint8_t *addr = app_lea_bond_info_list[i].bond_addr;
        if (memcmp(addr, bd_addr, BT_BD_ADDR_LEN) == 0) {
            duplicate = TRUE;
            break;
        }
    }

    if (duplicate) {
        APPS_LOG_MSGID_I(LOG_TAG" update_bond_info, duplicate addr", 0);
        return FALSE;
    }

    for (int i = (APP_LEA_MAX_BOND_NUM - 1 - 1); i >= 0; i--) {
        if (app_lea_bond_info_list[i].used) {
            memcpy(&app_lea_bond_info_list[i + 1], &app_lea_bond_info_list[i], sizeof(app_lea_bond_info_t));
        }
    }
    app_lea_bond_info_list[0].used = TRUE;
    app_lea_bond_info_list[0].conn_type = conn_type;
    app_lea_bond_info_list[0].addr_type = addr_type;
    memcpy(app_lea_bond_info_list[0].bond_addr, bd_addr, BT_BD_ADDR_LEN);

    app_lea_conn_mgr_print_bond_info(TRUE);
    app_lea_conn_mgr_save_bond_info();

    return TRUE;
}

static void app_lea_conn_mgr_save_bond_info(void)
{
    nvkey_status_t status = nvkey_write_data(NVID_APP_LE_AUDIO_CONN_FLAG,
                                             (const uint8_t *)&app_lea_bond_info_list[0],
                                             APP_LEA_BOND_INFO_LENGTH);
    APPS_LOG_MSGID_I(LOG_TAG" save_bond_info, status=%d", 1, status);
}

static void app_lea_conn_mgr_restore_bond_info(void)
{
    uint32_t size = APP_LEA_BOND_INFO_LENGTH;
    nvkey_status_t status = nvkey_read_data(NVID_APP_LE_AUDIO_CONN_FLAG,
                                            (uint8_t *)&app_lea_bond_info_list[0],
                                            &size);
    APPS_LOG_MSGID_I(LOG_TAG" restore_bond_info, read status=%d", 1, status);
    if (status == NVKEY_STATUS_OK) {
        app_lea_conn_mgr_print_bond_info(TRUE);
    } else if (status == NVKEY_STATUS_ITEM_NOT_FOUND) {
        memset(&app_lea_bond_info_list[0], 0, APP_LEA_BOND_INFO_LENGTH);
        nvkey_write_data(NVID_APP_LE_AUDIO_CONN_FLAG,
                         (const uint8_t *)&app_lea_bond_info_list[0],
                         APP_LEA_BOND_INFO_LENGTH);
    } else {
        memset(&app_lea_bond_info_list[0], 0, APP_LEA_BOND_INFO_LENGTH);
    }
}

#if defined(AIR_LE_AUDIO_DUALMODE_ENABLE) && defined(MTK_AWS_MCE_ENABLE)
static void app_lea_conn_check_dual_mode_device(void)
{
    bt_aws_mce_role_t role = bt_connection_manager_device_local_info_get_aws_role();
    bt_aws_mce_srv_link_type_t aws_link_type = bt_aws_mce_srv_get_link_type();
    uint8_t addr_list[BT_BD_ADDR_LEN * APP_LEA_MAX_CONN_NUM] = {0};
    uint8_t num = 0;

    for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
        if (app_lea_conn_info_list[i].conn_handle != BT_HANDLE_INVALID
            && app_lea_conn_info_list[i].peer_type != BT_ADDR_RANDOM
            && app_lea_conn_info_list[i].conn_type == APP_LEA_CONN_TYPE_LE_AUDIO) {
            uint8_t *addr = app_lea_conn_info_list[i].peer_id_addr;
            bool is_edr_bonded = bt_device_manager_is_paired(addr);

            if (is_edr_bonded) {
                APPS_LOG_MSGID_I(LOG_TAG" check_dual_mode_device, [%02X] i=%d addr=%02X:%02X:%02X:%02X:%02X:%02X",
                                 8, role, i, addr[5], addr[4], addr[3], addr[2], addr[1], addr[0]);
                memcpy((addr_list + i * BT_BD_ADDR_LEN), addr, BT_BD_ADDR_LEN);
                num++;
            }
        }
    }

    if (num > 0 && aws_link_type != BT_AWS_MCE_SRV_LINK_NONE) {
        bt_status_t bt_status = apps_aws_sync_event_send_extra(EVENT_GROUP_UI_SHELL_LE_AUDIO,
                                                               EVENT_ID_LEA_SYNC_BOND_DUAL_MODE_DEVICE,
                                                               addr_list, BT_BD_ADDR_LEN * APP_LEA_MAX_CONN_NUM);
        APPS_LOG_MSGID_I(LOG_TAG" check_dual_mode_device, [%02X] send num=%d bt_status=0x%08X",
                         3, role, num, bt_status);
    }
}

static void app_lea_conn_handle_dual_mode_device(uint8_t *addr_list)
{
    bt_aws_mce_role_t role = bt_connection_manager_device_local_info_get_aws_role();
    uint8_t empty_addr[BT_BD_ADDR_LEN] = {0};
    bool exist_diff = FALSE;

    for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
        uint8_t *dual_mode_device_addr = addr_list + i * BT_BD_ADDR_LEN;
        if (APP_LEA_IS_EMPTY_ADDR(dual_mode_device_addr, empty_addr)) {
            continue;
        }

        bool exist_bond_addr = FALSE;
        for (int j = 0; j < APP_LEA_MAX_BOND_NUM; j++) {
            uint8_t *bond_addr = app_lea_bond_info_list[j].bond_addr;
            if (memcmp(dual_mode_device_addr, bond_addr, BT_BD_ADDR_LEN) == 0) {
                exist_bond_addr = TRUE;
                break;
            }
        }

        if (exist_bond_addr) {
            continue;
        } else {
            exist_diff = TRUE;
            APPS_LOG_MSGID_W(LOG_TAG" handle_dual_mode_device, [%02X] addr=%02X:%02X:%02X:%02X:%02X:%02X",
                             7, role, dual_mode_device_addr[5], dual_mode_device_addr[4], dual_mode_device_addr[3],
                             dual_mode_device_addr[2], dual_mode_device_addr[1], dual_mode_device_addr[0]);
            break;
        }
    }

    if (exist_diff) {
        uint8_t adv_mode = app_lea_adv_mgr_get_adv_mode();
        APPS_LOG_MSGID_W(LOG_TAG" handle_dual_mode_device, [%02X] adv_mode=%d", 2, role, adv_mode);
        if (adv_mode != APP_LEA_ADV_MODE_GENERAL) {
            app_lea_service_start_advertising(APP_LEA_ADV_MODE_GENERAL, FALSE, APP_LE_AUDIO_DUAL_MODE_GENERAL_ADV_TIME);
        }
    }
}
#endif



/**================================================================================*/
/**                                 APP Event Handler                              */
/**================================================================================*/
static void app_lea_conn_mgr_bt_cm_event_group(uint32_t event_id, void *extra_data, size_t data_len)
{
#if defined(AIR_LE_AUDIO_DUALMODE_ENABLE) && defined(MTK_AWS_MCE_ENABLE)
    switch (event_id) {
        case BT_CM_EVENT_REMOTE_INFO_UPDATE: {
            bt_cm_remote_info_update_ind_t *remote_update = (bt_cm_remote_info_update_ind_t *)extra_data;
            if (NULL == remote_update) {
                break;
            }

            if (!(BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & remote_update->pre_connected_service) &&
                (BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & remote_update->connected_service)) {
                app_lea_conn_check_dual_mode_device();
            }
            break;
        }
    }
#endif
}

static void app_lea_conn_mgr_bt_dm_event_group(uint32_t event_id, void *extra_data, size_t data_len)
{
    bt_device_manager_power_event_t evt;
    bt_device_manager_power_status_t status;
    bt_event_get_bt_dm_event_and_status(event_id, &evt, &status);
    switch (evt) {
        case BT_DEVICE_MANAGER_POWER_EVT_ACTIVE_COMPLETE: {
            if (BT_DEVICE_MANAGER_POWER_STATUS_SUCCESS == status) {
                //APPS_LOG_MSGID_I(LOG_TAG" BT_DM Power ON", 0);
                app_lea_conn_mgr_clear_conn_info();
            }
            break;
        }

        case BT_DEVICE_MANAGER_POWER_EVT_STANDBY_COMPLETE: {
            if (BT_DEVICE_MANAGER_POWER_RESET_TYPE_NORMAL == status) {
                //APPS_LOG_MSGID_I(LOG_TAG" BT_DM POWER OFF", 0);
                app_lea_conn_mgr_clear_conn_info();
                app_lea_conn_mgr_save_bond_info();
            }
            break;
        }
    }
}

static void app_lea_conn_mgr_interaction_event_group(uint32_t event_id, void *extra_data, size_t data_len)
{
#ifdef AIR_BT_TAKEOVER_ENABLE
    if (event_id == APPS_EVENTS_INTERACTION_LE_TAKEOVER_ADDR) {
        uint8_t *le_addr = app_bt_takeover_get_disconnect_le_addr();
        if (le_addr != NULL && app_lea_conn_mgr_is_connected(le_addr)) {
            // After takeover service reject new_lea_addr connection, headset should disconnect the LEA.
            APPS_LOG_MSGID_I(LOG_TAG" interaction LE_TAKEOVER_ADDR, disconnect lea_addr for takeover", 0);
            app_lea_service_disconnect(FALSE, APP_LE_AUDIO_DISCONNECT_MODE_DISCONNECT, le_addr,
                                       BT_HCI_STATUS_REMOTE_TERMINATED_CONNECTION_DUE_TO_LOW_RESOURCES);
            app_bt_takeover_clear_disconnect_le_addr();
        } else {
            APPS_LOG_MSGID_E(LOG_TAG" interaction LE_TAKEOVER_ADDR, error lea_addr for takeover", 0);
        }
    }
#endif
}

#ifdef MTK_AWS_MCE_ENABLE
static void app_lea_conn_mgr_proc_aws_data(void *extra_data, size_t data_len)
{
    uint32_t aws_event_group;
    uint32_t aws_event_id;
    void *p_extra_data = NULL;
    uint32_t extra_data_len = 0;
    bt_aws_mce_report_info_t *aws_data_ind = (bt_aws_mce_report_info_t *)extra_data;
    if (aws_data_ind == NULL || aws_data_ind->module_id != BT_AWS_MCE_REPORT_MODULE_APP_ACTION) {
        return;
    }

    apps_aws_sync_event_decode_extra(aws_data_ind, &aws_event_group, &aws_event_id,
                                     &p_extra_data, &extra_data_len);
    if (aws_event_group == EVENT_GROUP_UI_SHELL_LE_AUDIO) {
        if (aws_event_id == EVENT_ID_LEA_SYNC_BOND_INFO) {
#if 0
            app_lea_bond_info_t *bond_info_list = (app_lea_bond_info_t *)p_extra_data;
            uint8_t adv_mode = app_lea_adv_mgr_get_adv_mode();
            bool add_flag = FALSE;
            bool is_exist_same_addr = FALSE;

            uint8_t empty_addr[BT_BD_ADDR_LEN] = {0};
            for (int i = 0; i < APP_LEA_MAX_BOND_NUM; i++) {
                const uint8_t *peer_addr = bond_info_list[i].bond_addr;
                if (bond_info_list[i].used && !APP_LEA_IS_EMPTY_ADDR(peer_addr, empty_addr)) {
                    for (int j = 0; j < APP_LEA_MAX_BOND_NUM; j++) {
                        const uint8_t *own_addr = app_lea_bond_info_list[j].bond_addr;
                        if (memcmp(peer_addr, own_addr, BT_BD_ADDR_LEN) == 0) {
                            is_exist_same_addr = TRUE;
                            break;
                        }
                    }

                    if (!is_exist_same_addr) {
                        APPS_LOG_MSGID_I(LOG_TAG" SYNC_BOND_INFO, add peer_addr=%d %02X:%02X:%02X:%02X:%02X:%02X conn_type=%d",
                                         8, bond_info_list[i].addr_type, peer_addr[5], peer_addr[4], peer_addr[3],
                                         peer_addr[2], peer_addr[1], peer_addr[0], bond_info_list[i].conn_type);
                        app_lea_conn_mgr_update_bond_info(bond_info_list[i].addr_type,
                                                          bond_info_list[i].bond_addr,
                                                          bond_info_list[i].conn_type);
                        add_flag = TRUE;
                    }
                }
            }

            if (add_flag && (adv_mode == APP_LEA_ADV_MODE_NONE || adv_mode == APP_LEA_ADV_MODE_TARGET_ALL)) {
                app_lea_service_start_advertising(APP_LEA_ADV_MODE_TARGET_ALL, FALSE, 0);
            }
#endif
        } else if (aws_event_id == EVENT_ID_LEA_SYNC_BOND_DUAL_MODE_DEVICE) {
#ifdef AIR_LE_AUDIO_DUALMODE_ENABLE
            uint8_t *addr_list = (uint8_t *)p_extra_data;
            app_lea_conn_handle_dual_mode_device(addr_list);
#endif
        }
    }
}
#endif

static void app_lea_conn_mgr_bt_event_group(uint32_t event_id, void *extra_data, size_t data_len)
{
    apps_bt_event_data_t *bt_event_data = (apps_bt_event_data_t *)extra_data;
    if (bt_event_data == NULL) {
        //APPS_LOG_MSGID_E(LOG_TAG" BT event, bt_event_data is NULL", 0);
        return;
    }

    switch (event_id) {
        case BT_GAP_LE_CONNECT_IND: {
            bt_gap_le_connection_ind_t *conn_ind = (bt_gap_le_connection_ind_t *)bt_event_data->buffer;
            if (conn_ind == NULL || BT_HANDLE_INVALID == conn_ind->connection_handle) {
                break;
            }

            uint8_t *local_addr = (uint8_t *)conn_ind->local_addr.addr;
#ifdef AIR_LE_AUDIO_DUALMODE_ENABLE
#ifdef MTK_AWS_MCE_ENABLE
            uint8_t *edr_addr = (uint8_t *)bt_device_manager_aws_local_info_get_fixed_address();
#else
            uint8_t *edr_addr = (uint8_t *)bt_device_manager_get_local_address();
#endif
            bool is_public = (memcmp(local_addr, edr_addr, BT_BD_ADDR_LEN) == 0);
            if (!is_public) {
                APPS_LOG_MSGID_I(LOG_TAG" BT_LE_CONNECT_IND, not public addr", 0);
                break;
            }
#else
            bt_bd_addr_t adv_addr = {0};
            if (multi_ble_adv_manager_get_random_addr_and_adv_handle(MULTI_ADV_INSTANCE_NOT_RHO, &adv_addr, NULL)
                && memcmp(&adv_addr, local_addr, BT_BD_ADDR_LEN) == 0) {
                // le audio link
            } else {
                APPS_LOG_MSGID_I(LOG_TAG" BT_LE_CONNECT_IND, not le audio link", 0);
                break;
            }
#endif
            bt_handle_t conn_handle = conn_ind->connection_handle;
            uint8_t *addr = (uint8_t *)conn_ind->peer_addr.addr;
            bt_addr_type_t peer_type = conn_ind->peer_addr.type;

            int index = -1;
            for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
                if (app_lea_conn_info_list[i].conn_handle == BT_HANDLE_INVALID) {
                    APPS_LOG_MSGID_I(LOG_TAG" BT_LE_CONNECT_IND, lea_conn_info[%d] handle=0x%04X peer_addr=%02X:%02X:%02X:%02X:%02X:XX peer_type=%d",
                                     8, i, conn_handle, addr[5], addr[4], addr[3], addr[2], addr[1], peer_type);
                    app_lea_conn_info_list[i].conn_handle = conn_handle;
                    if (peer_type == BT_ADDR_RANDOM) {
                        memcpy(app_lea_conn_info_list[i].peer_random_addr, addr, BT_BD_ADDR_LEN);
                        memset(app_lea_conn_info_list[i].peer_id_addr, 0, BT_BD_ADDR_LEN);
                        app_lea_conn_info_list[i].peer_type = BT_ADDR_RANDOM;
                    } else {
                        memset(app_lea_conn_info_list[i].peer_random_addr, 0, BT_BD_ADDR_LEN);
                        memcpy(app_lea_conn_info_list[i].peer_id_addr, addr, BT_BD_ADDR_LEN);
                        app_lea_conn_info_list[i].peer_type = peer_type;
                    }
#if defined(AIR_LE_AUDIO_ENABLE) && defined(AIR_BLE_ULTRA_LOW_LATENCY_ENABLE)
                    bool ull2_link = bt_gap_le_check_remote_features(conn_handle, BT_GAP_LE_ULL2_0);
                    extern bool app_lea_adv_add_ull_data;
                    if (ull2_link && app_lea_adv_add_ull_data) {
                        app_lea_conn_info_list[i].conn_type = APP_LEA_CONN_TYPE_LE_ULL;
                    } else {
                        app_lea_conn_info_list[i].conn_type = APP_LEA_CONN_TYPE_LE_AUDIO;
                    }
                    APPS_LOG_MSGID_I(LOG_TAG" BT_LE_CONNECT_IND, ull2_link=%d adv_ull=%d lea_conn_type=%d",
                                     3, ull2_link, app_lea_adv_add_ull_data, app_lea_conn_info_list[i].conn_type);
#elif defined(AIR_LE_AUDIO_ENABLE) && !defined(AIR_BLE_ULTRA_LOW_LATENCY_ENABLE)
                    app_lea_conn_info_list[i].conn_type = APP_LEA_CONN_TYPE_LE_AUDIO;
#elif !defined(AIR_LE_AUDIO_ENABLE) && defined(AIR_BLE_ULTRA_LOW_LATENCY_ENABLE)
                    app_lea_conn_info_list[i].conn_type = APP_LEA_CONN_TYPE_LE_ULL;
#endif
#ifdef AIR_LE_AUDIO_ENABLE
                    app_lea_conn_info_list[i].conn_interval = conn_ind->conn_interval;
                    app_lea_conn_info_list[i].conn_latency = conn_ind->conn_latency;
                    app_lea_conn_info_list[i].supervision_timeout = conn_ind->supervision_timeout;
#endif
                    index = i;

                    if (app_lea_connection_cb != NULL) {
                        app_lea_connection_cb(APP_LEA_CONN_CB_TYPE_CONNECTED, index, peer_type, addr, 0x00);
                    }
                    break;
                }
            }
            if (index == -1) {
                APPS_LOG_MSGID_E(LOG_TAG" BT_LE_CONNECT_IND, lea_conn_info full", 0);
            }
            break;
        }

        case BT_GAP_LE_DISCONNECT_IND: {
            bt_hci_evt_disconnect_complete_t *disconn_ind = (bt_hci_evt_disconnect_complete_t *)bt_event_data->buffer;
            if (disconn_ind == NULL || BT_HANDLE_INVALID == disconn_ind->connection_handle) {
                break;
            }

            bt_handle_t conn_handle = disconn_ind->connection_handle;
            APPS_LOG_MSGID_I(LOG_TAG" BT_LE_DISCONNECT_IND, lea_conn_info handle=0x%04X", 1, conn_handle);
            int index = -1;
            for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
                if (app_lea_conn_info_list[i].conn_handle == conn_handle) {
                    APPS_LOG_MSGID_I(LOG_TAG" BT_LE_DISCONNECT_IND, lea_conn_info[%d] handle=0x%04X reason=0x%02X",
                                     3, i, conn_handle, disconn_ind->reason);
                    uint8_t peer_type = app_lea_conn_info_list[i].peer_type;
                    uint8_t peer_addr[BT_BD_ADDR_LEN] = {0};
                    if (peer_type == BT_ADDR_RANDOM) {
                        memcpy(peer_addr, app_lea_conn_info_list[i].peer_random_addr, BT_BD_ADDR_LEN);
                    } else {
                        memcpy(peer_addr, app_lea_conn_info_list[i].peer_id_addr, BT_BD_ADDR_LEN);
                    }
                    memset(&app_lea_conn_info_list[i], 0, sizeof(app_lea_conn_info_t));
                    app_lea_conn_info_list[i].conn_handle = BT_HANDLE_INVALID;

                    if (app_lea_connection_cb != NULL) {
                        app_lea_connection_cb(APP_LEA_CONN_CB_TYPE_DISCONNECTED, i, peer_type, peer_addr, disconn_ind->reason);
                    }
                    index = i;
                    break;
                }
            }
            if (index == -1) {
                APPS_LOG_MSGID_I(LOG_TAG" BT_LE_DISCONNECT_IND, no match item", 0);
            }
            break;
        }

        case BT_GAP_LE_BONDING_COMPLETE_IND: {
            bt_gap_le_bonding_complete_ind_t *ind = (bt_gap_le_bonding_complete_ind_t *)bt_event_data->buffer;
            if (ind == NULL || BT_HANDLE_INVALID == ind->handle) {
                break;
            } else if (bt_event_data->status != BT_STATUS_SUCCESS) {
                APPS_LOG_MSGID_E(LOG_TAG" BT_BONDING_COMPLETE_IND, error status=0x%08X", 1, bt_event_data->status);
                break;
            }

            bt_handle_t conn_handle = ind->handle;
            APPS_LOG_MSGID_I(LOG_TAG" BT_BONDING_COMPLETE_IND, handle=0x%04X", 1, conn_handle);
            for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
                if (app_lea_conn_info_list[i].conn_handle == conn_handle) {
                    uint8_t *addr = app_lea_conn_info_list[i].peer_random_addr;
                    APPS_LOG_MSGID_I(LOG_TAG" BT_BONDING_COMPLETE_IND, lea_conn_info[%d] handle=0x%04X peer_type=%d conn_type=%d",
                                     4, i, conn_handle, app_lea_conn_info_list[i].peer_type, app_lea_conn_info_list[i].conn_type);

                    bt_device_manager_le_bonded_info_t *bonded_info = bt_device_manager_le_get_bonding_info_by_addr_ext((bt_bd_addr_t *)addr);
                    if (bonded_info != NULL) {
                        uint8_t type = (uint8_t)bonded_info->info.identity_addr.address.type;
                        uint8_t *bd_addr = (uint8_t *)bonded_info->info.identity_addr.address.addr;
                        APPS_LOG_MSGID_I(LOG_TAG" BT_BONDING_COMPLETE_IND, lea_conn_info[%d] type=%d bd_addr=%02X:%02X:%02X:%02X:%02X:%02X",
                                         8, i, type, bd_addr[5], bd_addr[4], bd_addr[3], bd_addr[2], bd_addr[1], bd_addr[0]);

                        uint8_t empty_addr[BT_BD_ADDR_LEN] = {0};
                        if (type == 0xFF || APP_LEA_IS_EMPTY_ADDR(bd_addr, empty_addr)) {
                            // Not RPA addr, cannot get IDA
                            bd_addr = app_lea_conn_info_list[i].peer_random_addr;
                            type = app_lea_conn_info_list[i].peer_type;
                            memset(app_lea_conn_info_list[i].peer_id_addr, 0, BT_BD_ADDR_LEN);
                            APPS_LOG_MSGID_I(LOG_TAG" BT_BONDING_COMPLETE_IND, NON-RPA use type=%d addr=%02X:%02X:%02X:%02X:%02X:%02X",
                                             7, type, bd_addr[5], bd_addr[4], bd_addr[3], bd_addr[2], bd_addr[1], bd_addr[0]);
                        } else {
                            memcpy(app_lea_conn_info_list[i].peer_id_addr, bd_addr, BT_BD_ADDR_LEN);
                            app_lea_conn_info_list[i].peer_type = type;
                        }

                        app_lea_conn_mgr_update_bond_info(type, bd_addr, app_lea_conn_info_list[i].conn_type);
                    } else if (app_lea_conn_info_list[i].peer_type == BT_ADDR_PUBLIC
                               || app_lea_conn_info_list[i].peer_type == BT_ADDR_PUBLIC_IDENTITY) {
                        app_lea_conn_mgr_update_bond_info(app_lea_conn_info_list[i].peer_type,
                                                          app_lea_conn_info_list[i].peer_id_addr,
                                                          app_lea_conn_info_list[i].conn_type);
                    }

                    if (app_lea_conn_info_list[i].peer_type == BT_ADDR_PUBLIC
                        || app_lea_conn_info_list[i].peer_type == BT_ADDR_PUBLIC_IDENTITY) {
                        app_lea_connection_cb(APP_LEA_CONN_CB_TYPE_BONDED, i,
                                              app_lea_conn_info_list[i].peer_type, app_lea_conn_info_list[i].peer_id_addr, 0);
                    } else if (app_lea_conn_info_list[i].peer_type == BT_ADDR_RANDOM) {
                        app_lea_connection_cb(APP_LEA_CONN_CB_TYPE_BONDED, i,
                                              BT_ADDR_RANDOM, app_lea_conn_info_list[i].peer_random_addr, 0);
                    }

                    // After takeover service reject new_lea_addr connection, peer headset should reject it when the new_lea_addr connected.
#ifdef AIR_LE_AUDIO_ENABLE
                    bool need_discovery = TRUE;
#endif
#ifdef AIR_BT_TAKEOVER_ENABLE
                    uint8_t *le_addr = app_bt_takeover_get_disconnect_le_addr();
                    if (le_addr != NULL) {
                        if (memcmp(le_addr, app_lea_conn_info_list[i].peer_random_addr, BT_BD_ADDR_LEN) == 0
                            || memcmp(le_addr, app_lea_conn_info_list[i].peer_id_addr, BT_BD_ADDR_LEN) == 0) {
                            APPS_LOG_MSGID_W(LOG_TAG" BT_BONDING_COMPLETE_IND, disconnect lea_addr for takeover", 0);
                            app_lea_service_disconnect(FALSE, APP_LE_AUDIO_DISCONNECT_MODE_DISCONNECT, le_addr,
                                                       BT_HCI_STATUS_REMOTE_TERMINATED_CONNECTION_DUE_TO_LOW_RESOURCES);
                            app_bt_takeover_clear_disconnect_le_addr();
#ifdef AIR_LE_AUDIO_ENABLE
                            need_discovery = FALSE;
#endif
                        }
                    }
#endif

#ifdef AIR_LE_AUDIO_ENABLE
                    if (app_lea_conn_info_list[i].conn_type == APP_LEA_CONN_TYPE_LE_AUDIO) {
                        extern bool bt_le_audio_sink_load_cccd(bt_handle_t handle);
                        bt_le_audio_sink_load_cccd(conn_handle);
                    }

                    if (app_lea_conn_info_list[i].conn_type == APP_LEA_CONN_TYPE_LE_AUDIO && need_discovery) {
                        bt_status_t bt_status = bt_gattc_discovery_start(BT_GATTC_DISCOVERY_USER_LE_AUDIO,
                                                                         conn_handle, FALSE);
                        if (bt_status != BT_STATUS_SUCCESS) {
                            APPS_LOG_MSGID_E(LOG_TAG" BT_BONDING_COMPLETE_IND, discovery error status=0x%08X",
                                             1, bt_status);
                        }
                    }
#endif

#if defined(AIR_LE_AUDIO_DUALMODE_ENABLE) && defined(MTK_AWS_MCE_ENABLE)
                    app_lea_conn_check_dual_mode_device();
#endif
                    break;
                }
            }
            break;
        }

#ifdef AIR_LE_AUDIO_ENABLE
        case BT_GAP_LE_CIS_ESTABLISHED_IND: {
            for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
                if (app_lea_conn_info_list[i].conn_handle != BT_HANDLE_INVALID
                    && app_lea_conn_info_list[i].conn_interval < APP_LEA_NORMAL_CONN_INTERVAL) {
                    bt_hci_cmd_le_connection_update_t param = {0};
                    param.connection_handle =  app_lea_conn_info_list[i].conn_handle;
                    param.conn_interval_min = APP_LEA_NORMAL_CONN_INTERVAL;
                    param.conn_interval_max = APP_LEA_NORMAL_CONN_INTERVAL;
                    param.conn_latency = app_lea_conn_info_list[i].conn_latency;
                    param.supervision_timeout = app_lea_conn_info_list[i].supervision_timeout;
                    bt_status_t bt_status = bt_gap_le_update_connection_parameter(&param);
                    APPS_LOG_MSGID_I(LOG_TAG" LEA update connection interval, handle=0x%04X conn_interval=0x%04X->0x%04X bt_status=0x%08X",
                                     4, app_lea_conn_info_list[i].conn_handle, app_lea_conn_info_list[i].conn_interval,
                                     APP_LEA_NORMAL_CONN_INTERVAL, bt_status);
                    if (bt_status == BT_STATUS_SUCCESS) {
                        app_lea_conn_info_list[i].conn_interval = APP_LEA_NORMAL_CONN_INTERVAL;
                    }
                    // No need to break, update all LEA low connection interval when CIS establish
                }
            }
            break;
        }

        case BT_GAP_LE_CONNECTION_UPDATE_IND: {
            bt_gap_le_connection_update_ind_t *ind = (bt_gap_le_connection_update_ind_t *)bt_event_data->buffer;
            if (ind == NULL || BT_HANDLE_INVALID == ind->conn_handle) {
                break;
            } else if (bt_event_data->status != BT_STATUS_SUCCESS) {
                APPS_LOG_MSGID_E(LOG_TAG" BT_GAP_LE_CONNECTION_UPDATE_IND, error status=0x%08X", 1, bt_event_data->status);
                break;
            }

            for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
                if (app_lea_conn_info_list[i].conn_handle == ind->conn_handle) {
                    app_lea_conn_info_list[i].conn_interval = ind->conn_interval;
                    app_lea_conn_info_list[i].conn_latency = ind->conn_latency;
                    app_lea_conn_info_list[i].supervision_timeout = ind->supervision_timeout;
                    APPS_LOG_MSGID_I(LOG_TAG" BT_GAP_LE_CONNECTION_UPDATE_IND, handle=0x%04X conn_interval=0x%04X",
                                     2, ind->conn_handle, ind->conn_interval);
                    break;
                }
            }
            break;
        }
#endif
    }
}



/**================================================================================*/
/**                                     Public API                                 */
/**================================================================================*/
void app_lea_conn_mgr_register_connection_cb(app_lea_conn_mgr_connection_cb_t cb)
{
    app_lea_connection_cb = cb;
}

bool app_lea_conn_mgr_is_ever_connected(void)
{
    bool ret = FALSE;
    for (int i = 0; i < APP_LEA_MAX_BOND_NUM; i++) {
        if (app_lea_bond_info_list[i].used) {
            ret = TRUE;
            break;
        }
    }
    return ret;
}

bool app_lea_conn_mgr_is_connected(const uint8_t *addr)
{
    bool ret = FALSE;
    for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
        if (app_lea_conn_info_list[i].conn_handle != BT_HANDLE_INVALID
            && (memcmp(app_lea_conn_info_list[i].peer_random_addr, addr, BT_BD_ADDR_LEN) == 0
                || memcmp(app_lea_conn_info_list[i].peer_id_addr, addr, BT_BD_ADDR_LEN) == 0)) {
            ret = TRUE;
            break;
        }
    }
    return ret;
}

bt_handle_t app_lea_conn_mgr_get_handle(uint8_t index)
{
    return (index < APP_LEA_MAX_CONN_NUM ? app_lea_conn_info_list[index].conn_handle : BT_HANDLE_INVALID);
}

bt_handle_t app_lea_conn_mgr_get_dongle_handle(app_lea_conn_type_t type)
{
    bt_handle_t handle = BT_HANDLE_INVALID;
    for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
        if (app_lea_conn_info_list[i].conn_handle != BT_HANDLE_INVALID
            && app_lea_conn_info_list[i].conn_type == type) {
#ifdef AIR_LE_AUDIO_ENABLE
            if (type == APP_LEA_CONN_TYPE_LE_AUDIO
                && app_le_audio_aird_client_is_support(app_lea_conn_info_list[i].conn_handle)) {
                handle = app_lea_conn_info_list[i].conn_handle;
                break;
            }
#endif
#ifdef AIR_BLE_ULTRA_LOW_LATENCY_ENABLE
            if (type == APP_LEA_CONN_TYPE_LE_ULL) {
                handle = app_lea_conn_info_list[i].conn_handle;
                break;
            }
#endif
        }
    }
    return handle;
}

bt_handle_t app_lea_conn_mgr_get_handle_by_addr(const uint8_t *addr)
{
    for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
        if ((memcmp(addr, app_lea_conn_info_list[i].peer_random_addr, BT_BD_ADDR_LEN) == 0) ||
            (memcmp(addr, app_lea_conn_info_list[i].peer_id_addr, BT_BD_ADDR_LEN) == 0)) {
            return app_lea_conn_info_list[i].conn_handle;
        }
    }
    return BT_HANDLE_INVALID;
}

bool app_lea_conn_mgr_is_ull_link(const uint8_t *addr)
{
    bool ret = FALSE;
#ifdef AIR_BLE_ULTRA_LOW_LATENCY_ENABLE
    for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
        if ((memcmp(addr, app_lea_conn_info_list[i].peer_random_addr, BT_BD_ADDR_LEN) == 0) ||
            (memcmp(addr, app_lea_conn_info_list[i].peer_id_addr, BT_BD_ADDR_LEN) == 0)) {
            ret = (app_lea_conn_info_list[i].conn_type == APP_LEA_CONN_TYPE_LE_ULL);
            break;
        }
    }
#endif
    return ret;
}

uint8_t app_lea_conn_mgr_get_conn_type(bt_handle_t handle)
{
    uint8_t conn_type = APP_LEA_CONN_TYPE_NONE;
    for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
        if (app_lea_conn_info_list[i].conn_handle == handle) {
            conn_type = app_lea_conn_info_list[i].conn_type;
        }
    }
    return conn_type;
}

uint8_t *app_lea_conn_mgr_get_addr_by_handle(bt_handle_t handle)
{
    uint8_t *addr = NULL;
    for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
        if (app_lea_conn_info_list[i].conn_handle == handle && handle != BT_HANDLE_INVALID) {
            if (app_lea_conn_info_list[i].peer_type == BT_ADDR_RANDOM) {
                addr = app_lea_conn_info_list[i].peer_random_addr;
            } else {
                addr = app_lea_conn_info_list[i].peer_id_addr;
            }
            break;
        }
    }
    return addr;
}

uint8_t *app_lea_conn_mgr_get_unify_addr(const uint8_t *addr)
{
    uint8_t *unify_addr = NULL;
    for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
        if (memcmp(app_lea_conn_info_list[i].peer_random_addr, addr, BT_BD_ADDR_LEN) == 0
            || memcmp(app_lea_conn_info_list[i].peer_id_addr, addr, BT_BD_ADDR_LEN) == 0) {
            if (app_lea_conn_info_list[i].peer_type == BT_ADDR_RANDOM) {
                unify_addr = app_lea_conn_info_list[i].peer_random_addr;
            } else {
                unify_addr = app_lea_conn_info_list[i].peer_id_addr;
            }
            break;
        }
    }
    return unify_addr;
}

uint8_t app_lea_conn_mgr_get_index(bt_handle_t handle)
{
    int i = 0;
    for (i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
        if (app_lea_conn_info_list[i].conn_handle == handle && handle != BT_HANDLE_INVALID) {
            break;
        }
    }
    return i;
}

uint8_t app_lea_conn_mgr_get_conn_num(void)
{
    return app_lea_conn_mgr_get_link_count();
}

void app_lea_conn_mgr_get_conn_info(uint8_t *num, bt_addr_t *bdaddr)
{
    if (num == NULL || bdaddr == NULL) {
        APPS_LOG_MSGID_E(LOG_TAG" get_conn_info, error num=0x%08X bdaddr=0x%08X", 2, num, bdaddr);
        return;
    }

    uint8_t empty_addr[BT_BD_ADDR_LEN] = {0};
    int conn_num = app_lea_conn_mgr_get_conn_num();
    if (conn_num == 0) {
        APPS_LOG_MSGID_I(LOG_TAG" get_conn_info, num=0", 0);
        return;
    }

    int index = 0;
    for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
        if (app_lea_conn_info_list[i].conn_handle != BT_HANDLE_INVALID) {
            uint8_t peer_type = app_lea_conn_info_list[i].peer_type;
            const uint8_t *peer_addr = NULL;
            if (peer_type == BT_ADDR_RANDOM) {
                peer_addr = app_lea_conn_info_list[i].peer_random_addr;
            } else {
                peer_addr = app_lea_conn_info_list[i].peer_id_addr;
            }

            if (!APP_LEA_IS_EMPTY_ADDR(peer_addr, empty_addr)) {
                bdaddr[index].type = peer_type;
                memcpy(bdaddr[index].addr, peer_addr, BT_BD_ADDR_LEN);
                index++;
                *num = index;

                APPS_LOG_MSGID_I(LOG_TAG" get_conn_info, lea_num=%d addr_type=%d %02X:%02X:%02X:%02X:%02X:%02X",
                                 8, *num, peer_type,
                                 peer_addr[5], peer_addr[4], peer_addr[3], peer_addr[2], peer_addr[1], peer_addr[0]);
                if (index == APP_LEA_MAX_CONN_NUM) {
                    break;
                }
            }
        }
    }
}

uint8_t app_lea_conn_mgr_get_support_max_conn_num(void)
{
#if (APP_LE_AUDIO_ADV_CONN_MODE == APP_LE_AUDIO_MODE_DONGLE_ONE)
    return 1;
#elif !defined(AIR_LE_AUDIO_ENABLE) && defined(AIR_BLE_ULTRA_LOW_LATENCY_ENABLE)
    return 1;
#else
    bool support_emp = FALSE;
#ifdef AIR_MULTI_POINT_ENABLE
    support_emp = app_bt_emp_is_enable();
#endif

    if (support_emp) {
        return APP_LEA_MAX_CONN_NUM;
    } else {
#ifdef AIR_BT_TAKEOVER_ENABLE
        return 1 + 1;
#else
        return 1;
#endif
    }
#endif
}

app_lea_bond_info_t *app_lea_conn_mgr_get_bond_info(void)
{
    return &app_lea_bond_info_list[0];
}

uint8_t app_lea_conn_mgr_get_bond_num(void)
{
    uint8_t bond_num = 0;
    uint8_t empty_addr[BT_BD_ADDR_LEN] = {0};
    for (int i = 0; i < APP_LEA_MAX_BOND_NUM; i++) {
        const uint8_t *addr = app_lea_bond_info_list[i].bond_addr;
        if (app_lea_bond_info_list[i].used && !APP_LEA_IS_EMPTY_ADDR(addr, empty_addr)) {
            bond_num++;
        }
    }
    return bond_num;
}

void app_lea_conn_mgr_reset_bond_info(void)
{
    APPS_LOG_MSGID_I(LOG_TAG" reset_bond_info", 0);
    memset(&app_lea_bond_info_list[0], 0, APP_LEA_BOND_INFO_LENGTH);
    app_lea_conn_mgr_save_bond_info();
}

bool app_lea_conn_mgr_add_bond_info(uint8_t addr_type, uint8_t *addr, uint8_t conn_type)
{
    APPS_LOG_MSGID_W(LOG_TAG" add_bond_info, addr=%d-%02X:%02X:%02X:%02X:%02X:%02X conn_type=%d",
                     8, addr_type, addr[5], addr[4], addr[3], addr[2], addr[1], addr[0], conn_type);
    return app_lea_conn_mgr_update_bond_info(addr_type, addr, conn_type);
}

bool app_lea_conn_mgr_sync_bond_info(void)
{
    bool success = FALSE;
#ifdef MTK_AWS_MCE_ENABLE
    bt_aws_mce_srv_link_type_t aws_link_type = bt_aws_mce_srv_get_link_type();
    bt_status_t bt_status = 0xFFFFFFFF;
    if (aws_link_type != BT_AWS_MCE_SRV_LINK_NONE) {
        bt_status = apps_aws_sync_event_send_extra(EVENT_GROUP_UI_SHELL_LE_AUDIO,
                                                   EVENT_ID_LEA_SYNC_BOND_INFO,
                                                   &app_lea_bond_info_list[0],
                                                   APP_LEA_MAX_BOND_NUM * sizeof(app_lea_bond_info_t));
        success = (bt_status == BT_STATUS_SUCCESS);
    }

    if (!success) {
        APPS_LOG_MSGID_E(LOG_TAG" sync_bond_info, error aws_link_type=%d bt_status=0x%08X",
                         2, aws_link_type, bt_status);
    }
#endif
    return success;
}

bool app_lea_conn_mgr_is_le_bond(const uint8_t *addr)
{
    bt_device_manager_le_bonded_info_t *bonded_info = bt_device_manager_le_get_bonding_info_by_addr_ext((bt_bd_addr_t *)addr);
    return (bonded_info != NULL);
}

bool app_lea_conn_mgr_get_ida(const uint8_t *random_addr, uint8_t *type, uint8_t *id_addr)
{
    bool ret = FALSE;
    if (type == NULL || id_addr == NULL) {
        APPS_LOG_MSGID_E(LOG_TAG" get_ida, error type=0x%08X id_addr=0x%08X", 2, type, id_addr);
        return ret;
    }

    bt_device_manager_le_bonded_info_t *bonded_info = bt_device_manager_le_get_bonding_info_by_addr_ext((bt_bd_addr_t *)random_addr);
    if (bonded_info != NULL) {
        *type = (uint8_t)bonded_info->info.identity_addr.address.type;
        uint8_t *bd_addr = (uint8_t *)bonded_info->info.identity_addr.address.addr;
        memcpy(id_addr, bd_addr, BT_BD_ADDR_LEN);
        ret = TRUE;
    }

    return ret;
}

void app_lea_conn_mgr_disconnect(const uint8_t *addr, uint8_t reason)
{
    if (addr != NULL) {
        APPS_LOG_MSGID_I(LOG_TAG" disconnect, addr=%02X:%02X:%02X:%02X:%02X:%02X reason=0x%02X",
                         7, addr[5], addr[4], addr[3], addr[2], addr[1], addr[0], reason);
        uint8_t empty_addr[BT_BD_ADDR_LEN] = {0};
        if (APP_LEA_IS_EMPTY_ADDR(addr, empty_addr)) {
            //APPS_LOG_MSGID_E(LOG_TAG" disconnect, empty addr", 0);
            return;
        }

        for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
            if (memcmp(addr, app_lea_conn_info_list[i].peer_id_addr, BT_BD_ADDR_LEN) == 0
                || memcmp(addr, app_lea_conn_info_list[i].peer_random_addr, BT_BD_ADDR_LEN) == 0) {
                app_lea_conn_mgr_disconnect_by_handle(app_lea_conn_info_list[i].conn_handle,
                                                      reason);
                break;
            }
        }
    } else {
        APPS_LOG_MSGID_I(LOG_TAG" disconnect all, reason=0x%02X", 1, reason);
        for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
            if (BT_HANDLE_INVALID != app_lea_conn_info_list[i].conn_handle) {
                app_lea_conn_mgr_disconnect_by_handle(app_lea_conn_info_list[i].conn_handle,
                                                      reason);
            }
        }
    }
}

bool app_lea_conn_mgr_disconnect_by_handle(bt_handle_t handle,
                                           bt_hci_disconnect_reason_t reason)
{
    bt_hci_cmd_disconnect_t disconnect_para;
    disconnect_para.connection_handle = handle;
    disconnect_para.reason = reason;

    bt_status_t bt_status = bt_gap_le_disconnect(&disconnect_para);
    APPS_LOG_MSGID_I(LOG_TAG" disconnect_by_handle, handle=0x%04X reason=0x%02X bt_status=0x%08X",
                     3, handle, reason, bt_status);
    return (bt_status == BT_STATUS_SUCCESS);
}

void app_lea_conn_mgr_disconnect_dongle(void)
{
    uint8_t disconnect_num = 0;
    for (int i = 0; i < APP_LEA_MAX_CONN_NUM; i++) {
        if (BT_HANDLE_INVALID != app_lea_conn_info_list[i].conn_handle) {
            bool is_dongle = FALSE;
#ifdef AIR_LE_AUDIO_ENABLE
            if (app_le_audio_aird_client_is_support(app_lea_conn_info_list[i].conn_handle)) {
                is_dongle = TRUE;
            }
#endif
#ifdef AIR_BLE_ULTRA_LOW_LATENCY_ENABLE
            if (app_lea_conn_info_list[i].conn_type == APP_LEA_CONN_TYPE_LE_ULL) {
                is_dongle = TRUE;
            }
#endif
            if (is_dongle) {
                // Use BT_LOCAL_HOST for Headset wired_audio & LE Audio.
                // Dongle will reconnect headset successfully when remove wired_audio and headset restart ADV
                // Use low_resource, the dongle cannot reconnect Headset again.
                app_lea_conn_mgr_disconnect_by_handle(app_lea_conn_info_list[i].conn_handle,
                                                      BT_HCI_STATUS_CONNECTION_TERMINATED_BY_LOCAL_HOST);
                disconnect_num++;
            }
        }
    }
    APPS_LOG_MSGID_I(LOG_TAG" disconnect_dongle, num=%d", 1, disconnect_num);
}

void app_lea_conn_mgr_enable_multi_conn(bool enable)
{
#ifdef AIR_LE_AUDIO_MULTIPOINT_ENABLE
    if (enable) {
        multi_ble_adv_manager_set_le_connection_max_count(MULTI_ADV_INSTANCE_NOT_RHO, APP_LEA_MAX_CONN_NUM);
    } else {
        multi_ble_adv_manager_set_le_connection_max_count(MULTI_ADV_INSTANCE_NOT_RHO, 1);
    }
#elif !defined(AIR_LE_AUDIO_ENABLE) && defined(AIR_BLE_ULTRA_LOW_LATENCY_ENABLE)
    if (enable) {
        APPS_LOG_MSGID_E(LOG_TAG" enable_multi_conn, only support ULL2", 0);
    }
    multi_ble_adv_manager_set_le_connection_max_count(MULTI_ADV_INSTANCE_NOT_RHO, 1);
#else
    if (enable) {
        APPS_LOG_MSGID_E(LOG_TAG" enable_multi_conn, cannot support multi point feature", 0);
    }
    multi_ble_adv_manager_set_le_connection_max_count(MULTI_ADV_INSTANCE_NOT_RHO, 1);
#endif
    APPS_LOG_MSGID_I(LOG_TAG" enable_multi_conn, enable=%d", 1, enable);
}

void app_lea_conn_mgr_init(void)
{
    app_lea_conn_mgr_clear_conn_info();
    app_lea_conn_mgr_restore_bond_info();
}

void app_lea_conn_mgr_proc_ui_shell_event(uint32_t event_group,
                                          uint32_t event_id,
                                          void *extra_data,
                                          size_t data_len)
{
    switch (event_group) {
        case EVENT_GROUP_UI_SHELL_BT_CONN_MANAGER: {
            app_lea_conn_mgr_bt_cm_event_group(event_id, extra_data, data_len);
            break;
        }
        case EVENT_GROUP_UI_SHELL_BT_DEVICE_MANAGER:
            app_lea_conn_mgr_bt_dm_event_group(event_id, extra_data, data_len);
            break;
        case EVENT_GROUP_UI_SHELL_APP_INTERACTION:
            app_lea_conn_mgr_interaction_event_group(event_id, extra_data, data_len);
            break;
#ifdef MTK_AWS_MCE_ENABLE
        case EVENT_GROUP_UI_SHELL_AWS_DATA:
            app_lea_conn_mgr_proc_aws_data(extra_data, data_len);
            break;
#endif
        case EVENT_GROUP_UI_SHELL_BT:
            app_lea_conn_mgr_bt_event_group(event_id, extra_data, data_len);
            break;
    }
}

#endif /* AIR_LE_AUDIO_ENABLE */
