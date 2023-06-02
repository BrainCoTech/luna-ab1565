/* Copyright Statement:
 *
 * (C) 2020  Airoha Technology Corp. All rights reserved.
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
 * File: app_bt_state_service.c
 *
 * Description: This file provides many utility function to control BT switch and visibility.
 *
 */

#include "app_bt_takeover_service.h"

#include "apps_debug.h"
#include "apps_events_interaction_event.h"
#include "apps_events_event_group.h"
#include "app_music_utils.h"
#if defined(AIR_LE_AUDIO_ENABLE) || defined(AIR_BLE_ULTRA_LOW_LATENCY_ENABLE)
#include "app_lea_service.h"
#include "app_lea_service_conn_mgr.h"
#endif
#ifdef AIR_BLE_ULTRA_LOW_LATENCY_ENABLE
#include "app_ull_idle_activity.h"
#endif

#include "bt_connection_manager.h"
#include "bt_device_manager.h"
#include "bt_device_manager_link_record.h"
#include "bt_sink_srv.h"
#ifdef AIR_BT_SINK_SRV_STATE_MANAGER_ENABLE
#include "bt_sink_srv_state_manager.h"
#endif

#ifdef MTK_AWS_MCE_ENABLE
#include "apps_aws_sync_event.h"
#include "app_rho_idle_activity.h"
#include "bt_aws_mce_srv.h"
#endif
#ifdef AIR_MULTI_POINT_ENABLE
#include "app_bt_emp_service.h"
#endif

#include "FreeRTOS.h"
#include "ui_shell_manager.h"



/**================================================================================*/
/**                              Definition & Structure                            */
/**================================================================================*/
#define LOG_TAG     "[APP_TAKEOVER]"

#define APP_BT_TAKEOVER_PRIORITY_NONE           0
#define APP_BT_TAKEOVER_PRIORITY_LOW            1
#define APP_BT_TAKEOVER_PRIORITY_MID            2
#define APP_BT_TAKEOVER_PRIORITY_HIGH           3
typedef uint8_t app_bt_takeover_priority_t;     // Takeover lowest priority device

static app_bt_takeover_service_allow_func_t app_bt_takeover_user[APP_BT_TAKEOVER_ID_MAX] = {0};

static bt_device_manager_link_record_item_t app_bt_takeover_disconnect_item = {0};

static bt_bd_addr_t                         app_bt_takeover_last_device = {0};



/**================================================================================*/
/**                                 Internal Function                              */
/**================================================================================*/
#ifdef AIR_BT_TAKEOVER_ENABLE
static void app_bt_takeover_service_disconnect_edr(const uint8_t *addr)
{
    bt_cm_connect_t disconn_param = {0};
    disconn_param.profile = BT_CM_PROFILE_SERVICE_MASK_ALL;
    memcpy(&(disconn_param.address), addr, sizeof(bt_bd_addr_t));
    bt_status_t bt_status = bt_cm_disconnect(&disconn_param);

    APPS_LOG_MSGID_I(LOG_TAG" disconnect_edr, addr=%02X:%02X:%02X:%02X:%02X:%02X bt_status=0x%08X",
                     7, addr[5], addr[4], addr[3], addr[2], addr[1], addr[0], bt_status);
}
#endif

static bool app_bt_takeover_service_bt_sink_allow_cb(const bt_bd_addr_t remote_addr)
{
    bool ret = TRUE;
    bt_sink_srv_device_state_t state = {{0}, 0, 0, 0};
    if (bt_sink_srv_get_device_state((const bt_bd_addr_t *)remote_addr, &state, 1) == 1) {
        if (state.music_state == BT_SINK_SRV_STATE_STREAMING
            || state.call_state > BT_SINK_SRV_STATE_STREAMING
            || state.sco_state == BT_SINK_SRV_SCO_CONNECTION_STATE_CONNECTED) {
            const uint8_t *addr = (const uint8_t *)remote_addr;
            APPS_LOG_MSGID_I(LOG_TAG" bt_sink_allow_cb, disallow addr=%02X:%02X:%02X:%02X:%02X:XX music=%04X call=%04X eSCO=%d",
                             8, addr[5], addr[4], addr[3], addr[2], addr[1],
                             state.music_state, state.call_state, state.sco_state);
            ret = FALSE;
        }
    }

#ifdef AIR_BLE_ULTRA_LOW_LATENCY_ENABLE
    if (ret && app_lea_conn_mgr_is_ull_link(remote_addr)) {
        const uint8_t *addr = (const uint8_t *)remote_addr;
        bool ull_streaming = app_ull_is_streaming();
        APPS_LOG_MSGID_I(LOG_TAG" bt_sink_allow_cb, disallow addr=%02X:%02X:%02X:%02X:%02X:%02X ull_streaming=%d",
                         7, addr[5], addr[4], addr[3], addr[2], addr[1], addr[0], ull_streaming);
        ret = (!ull_streaming);
    }
#endif

    return ret;
}

#ifdef MTK_AWS_MCE_ENABLE
static bool app_bt_takeover_service_proc_aws_data(void *extra_data, size_t data_len)
{
    bool ret = FALSE;

    bt_aws_mce_report_info_t *aws_data_ind = (bt_aws_mce_report_info_t *)extra_data;
    if (aws_data_ind->module_id == BT_AWS_MCE_REPORT_MODULE_APP_ACTION) {
        uint32_t event_group;
        uint32_t event_id;
        void *p_extra_data = NULL;
        uint32_t extra_data_len = 0;

        apps_aws_sync_event_decode_extra(aws_data_ind, &event_group, &event_id, &p_extra_data, &extra_data_len);

        if (event_group == EVENT_GROUP_UI_SHELL_APP_INTERACTION && event_id == APPS_EVENTS_INTERACTION_LE_TAKEOVER_ADDR) {
            if (p_extra_data && (extra_data_len == (sizeof(bt_device_manager_link_record_item_t)))) {
                bt_device_manager_link_record_item_t *item = (bt_device_manager_link_record_item_t *)p_extra_data;
                APPS_LOG_MSGID_I(LOG_TAG" proc_aws_data, addr=%02X:%02X:%02X:%02X:%02X:%02X type=%d",
                                 7, item->remote_addr[5], item->remote_addr[4], item->remote_addr[3],
                                 item->remote_addr[2], item->remote_addr[1], item->remote_addr[0], item->link_type);

                memcpy(&app_bt_takeover_disconnect_item, item, sizeof(bt_device_manager_link_record_item_t));
                bt_device_manager_link_record_item_t *data = (bt_device_manager_link_record_item_t *)pvPortMalloc(sizeof(bt_device_manager_link_record_item_t));
                if (data == NULL) {
                    //APPS_LOG_MSGID_E(LOG_TAG" proc_aws_data, disconnect_item malloc fail", 0);
                    return ret;
                }
                memcpy(data, p_extra_data, sizeof(bt_device_manager_link_record_item_t));
                ui_shell_send_event(FALSE, EVENT_PRIORITY_HIGH,
                                    EVENT_GROUP_UI_SHELL_APP_INTERACTION, APPS_EVENTS_INTERACTION_LE_TAKEOVER_ADDR,
                                    data, sizeof(bt_device_manager_link_record_item_t), NULL, 0);
            }
            ret = TRUE;
        }
    }
    return ret;
}
#endif



/**================================================================================*/
/**                                BT Callback Function                            */
/**================================================================================*/
void bt_device_manager_link_record_takeover_callback(const bt_device_manager_link_record_item_t *item)
{
    bt_aws_mce_role_t role = bt_connection_manager_device_local_info_get_aws_role();
    const bt_device_manager_link_record_t *link_record = bt_device_manager_link_record_get_connected_link();

    if (item == NULL || link_record == NULL || role == BT_AWS_MCE_ROLE_PARTNER || link_record->connected_num < 2) {
        APPS_LOG_MSGID_E(LOG_TAG" takeover_callback, [%02X] error item=0x%08X link_record=0x%08X",
                         3, role, item, link_record);
        return;
    }

    uint8_t conn_num = link_record->connected_num;
    uint8_t *new_addr = (uint8_t *)item->remote_addr;
    APPS_LOG_MSGID_I(LOG_TAG" takeover_callback, connected_num=%d new link_type=%d addr=%02X:%02X:%02X:%02X:%02X:XX %d",
                     8, conn_num, item->link_type, new_addr[5], new_addr[4], new_addr[3],
                     new_addr[2], new_addr[1], item->remote_bd_type);

#ifdef AIR_BT_TAKEOVER_ENABLE
    bt_device_manager_link_record_item_t link_list[BT_DEVICE_MANAGER_LINK_RECORD_MAXIMUM] ;
    bt_device_manager_link_record_item_t *link_select = NULL;
    bt_bd_addr_t zero_addr = {0};
#ifdef AIR_BT_SINK_SRV_STATE_MANAGER_ENABLE
    bt_sink_srv_state_manager_played_device_t *last_played_device = NULL;
#endif
    uint8_t conn_index = 0;
    uint8_t allow_num = link_record->connected_num - 1;
    memcpy(&link_list, &(link_record->connected_device), sizeof(link_list));

    /* Check whether user callback allow. Start from index 1, index 0 is the incoming one. */
    for (conn_index = 1; conn_index < link_record->connected_num; conn_index++) {
        APPS_LOG_MSGID_I(LOG_TAG" takeover_callback, index=%d addr=%02X:%02X:%02X:%02X:%02X:XX link_type=%d addr_type=%d",
                         8, conn_index,
                         link_list[conn_index].remote_addr[5], link_list[conn_index].remote_addr[4], link_list[conn_index].remote_addr[3],
                         link_list[conn_index].remote_addr[2], link_list[conn_index].remote_addr[1],
                         link_list[conn_index].link_type, link_list[conn_index].remote_bd_type);

        if (memcmp(&(link_list[conn_index].remote_addr), new_addr, sizeof(bt_bd_addr_t)) == 0) {
            APPS_LOG_MSGID_W(LOG_TAG" takeover_callback, same address for mode switch - do nothing", 0);
            return;
        }

        for (int user_index = 0; user_index < APP_BT_TAKEOVER_ID_MAX; user_index++) {
            app_bt_takeover_service_allow_func_t user_func = app_bt_takeover_user[user_index];
            if (user_func && !user_func(link_list[conn_index].remote_addr)) {
                APPS_LOG_MSGID_I(LOG_TAG" takeover_callback, disallow user_id=%d", 1, user_index);
                memset(link_list[conn_index].remote_addr, 0, sizeof(bt_bd_addr_t));
                allow_num--;
                break;
            }
        }
    }

    if (allow_num == 0) {
        APPS_LOG_MSGID_I(LOG_TAG" takeover_callback, all disallow - disconnect new_incoming_addr", 0);
        link_select = (bt_device_manager_link_record_item_t *)item;
    }
#ifdef AIR_MULTI_POINT_ENABLE
    else if (!app_bt_emp_is_enable()) {
        APPS_LOG_MSGID_I(LOG_TAG" takeover_callback, EMP off - disconnect the connected one", 0);
        link_select = &(link_list[1]);
    }
#endif
    else {
#ifdef AIR_BT_SINK_SRV_STATE_MANAGER_ENABLE
        /* Begin to check the last service address. */
        bt_sink_srv_state_manager_played_device_t played_list[3];
        uint32_t srv_num = bt_sink_srv_state_manager_get_played_device_list(played_list, 3);
        if (srv_num != 0) {
            APPS_LOG_MSGID_I(LOG_TAG" takeover_callback, last_played=%02X:%02X:%02X:%02X:%02X:%02X type=%d mask=%02X", 8,
                             played_list[0].address[5], played_list[0].address[4], played_list[0].address[3],
                             played_list[0].address[2], played_list[0].address[1], played_list[0].address[0],
                             played_list[0].type, played_list[0].mask);
            last_played_device = &(played_list[0]);
        }
#endif

        /* Begin to check from the last connected but ignore the incoming(index 0). */
        conn_index = 1;
        do {
#if defined(AIR_BT_SINK_SRV_STATE_MANAGER_ENABLE) && defined(AIR_BT_TAKEOVER_FIRST_DEVICE)
            if (allow_num == 2 && conn_num == 3 && last_played_device == NULL
                && memcmp(&(link_list[2].remote_addr), zero_addr, sizeof(bt_bd_addr_t)) != 0) {
                link_select = &(link_list[2]);
                APPS_LOG_MSGID_W(LOG_TAG" takeover_callback, select first sp_addr (no last_played_device)", 0);
                break;
            }
#endif

#if 0
            // When 1st/2nd are same remote device and both idle, takeover EDR link
            if (conn_num == 3 && allow_num == 2
                && memcmp(&(link_list[2].remote_addr), zero_addr, sizeof(bt_bd_addr_t)) != 0
                && memcmp(&(link_list[2].remote_addr), &(link_list[1].remote_addr), sizeof(bt_bd_addr_t)) == 0) {
                if (link_list[2].link_type == BT_DEVICE_MANAGER_LINK_TYPE_EDR) {
                    link_select = &(link_list[2]);
                    APPS_LOG_MSGID_I(LOG_TAG" takeover_callback, select first device when same remote device and both idle", 0);
                    break;
                } else if (link_list[1].link_type == BT_DEVICE_MANAGER_LINK_TYPE_EDR) {
                    link_select = &(link_list[1]);
                    APPS_LOG_MSGID_I(LOG_TAG" takeover_callback, select second device when same remote device and both idle", 0);
                    break;
                }
            }
#endif

            if (memcmp(&(link_list[conn_index].remote_addr), zero_addr, sizeof(bt_bd_addr_t)) != 0) {
                /* This device allow takeover. */
#ifdef AIR_BT_SINK_SRV_STATE_MANAGER_ENABLE
                if (allow_num == 1 || last_played_device == NULL) {
                    /* Need to disconnect no-profile and first connected EDR Link. */
                    if (last_played_device == NULL && conn_num == 3 && link_list[2].link_type == BT_DEVICE_MANAGER_LINK_TYPE_EDR) {
                        if (memcmp(&(link_list[2].remote_addr), zero_addr, sizeof(bt_bd_addr_t)) != 0
                            && bt_cm_get_connected_profile_services(link_list[2].remote_addr) == 0) {
                            link_select = &(link_list[2]);
                            APPS_LOG_MSGID_W(LOG_TAG" takeover_callback, select sp_addr (no-profile, first_connected)", 0);
                            break;
                        }
                    }

                    /* Only this allow, or no last played address, select current item.*/
                    APPS_LOG_MSGID_I(LOG_TAG" takeover_callback, (allow_num==%d or last_played_device=0x%08X) select conn_index=%d type=%d",
                                     4, allow_num, last_played_device, conn_index, link_list[conn_index].link_type);
                    link_select = &(link_list[conn_index]);
                    break;
                } else if (memcmp(&(link_list[conn_index].remote_addr), last_played_device->address, sizeof(bt_bd_addr_t)) != 0) {
                    /* When more than 1 devices is allowed, the last_sink_srv device cannot be takeover. Select the 1st of others. */
                    APPS_LOG_MSGID_I(LOG_TAG" takeover_callback, select conn_index=%d type=%d",
                                     2, conn_index, link_list[conn_index].link_type);
                    link_select = &(link_list[conn_index]);
                    break;
                }
#else
                link_select = &(link_list[conn_index]);
                break;
#endif
            }

            if (conn_index == BT_DEVICE_MANAGER_LINK_RECORD_MAXIMUM - 1) {
                /* The last one goes here, means something wrong.*/
                APPS_LOG_MSGID_E(LOG_TAG" takeover_callback, error link_list end", 0);
                return;
            } else {
                /* Go to check the next one. */
                conn_index++;
            }
        } while (1);
    }

    if (link_select == NULL
        || (link_select->link_type != BT_DEVICE_MANAGER_LINK_TYPE_EDR && link_select->link_type != BT_DEVICE_MANAGER_LINK_TYPE_LE)) {
        APPS_LOG_MSGID_E(LOG_TAG" takeover_callback, error link_select", 0);
        return;
    }

    /* Do disconnect the incoming connection. */
    if (link_select->link_type == BT_DEVICE_MANAGER_LINK_TYPE_EDR) {
        memcpy(app_bt_takeover_last_device, (const uint8_t *)link_select->remote_addr, BT_BD_ADDR_LEN);
        app_bt_takeover_service_disconnect_edr((const uint8_t *)link_select->remote_addr);
    } else if (link_select->link_type == BT_DEVICE_MANAGER_LINK_TYPE_LE) {
        memcpy(app_bt_takeover_last_device, (const uint8_t *)link_select->remote_addr, BT_BD_ADDR_LEN);
#if defined(AIR_LE_AUDIO_ENABLE) || defined(AIR_BLE_ULTRA_LOW_LATENCY_ENABLE)
        if (link_select == item) {
            APPS_LOG_MSGID_W(LOG_TAG" takeover_callback, disconnect new_incoming LE", 0);
            memcpy(&app_bt_takeover_disconnect_item, link_select, sizeof(bt_device_manager_link_record_item_t));
            bt_device_manager_link_record_item_t *data = (bt_device_manager_link_record_item_t *)pvPortMalloc(sizeof(bt_device_manager_link_record_item_t));
            if (data == NULL) {
                APPS_LOG_MSGID_E(LOG_TAG" takeover_callback, disconnect_item malloc fail", 0);
                return;
            }
            memcpy(data, link_select, sizeof(bt_device_manager_link_record_item_t));
            ui_shell_send_event(FALSE, EVENT_PRIORITY_HIGH,
                                EVENT_GROUP_UI_SHELL_APP_INTERACTION, APPS_EVENTS_INTERACTION_LE_TAKEOVER_ADDR,
                                data, sizeof(bt_device_manager_link_record_item_t), NULL, 0);
#ifdef MTK_AWS_MCE_ENABLE
            apps_aws_sync_event_send_extra(EVENT_GROUP_UI_SHELL_APP_INTERACTION, APPS_EVENTS_INTERACTION_LE_TAKEOVER_ADDR,
                                           link_select, sizeof(bt_device_manager_link_record_item_t));
#endif
        } else {
            app_lea_service_disconnect(TRUE, APP_LE_AUDIO_DISCONNECT_MODE_DISCONNECT,
                                       (const uint8_t *)link_select->remote_addr,
                                       BT_HCI_STATUS_REMOTE_TERMINATED_CONNECTION_DUE_TO_LOW_RESOURCES);
        }
#endif
    }
#else
    // No AIR_BT_TAKEOVER_ENABLE
    APPS_LOG_MSGID_E(LOG_TAG" takeover_callback, No AIR_BT_TAKEOVER_ENABLE", 0);
#endif
}

#if defined(MTK_AWS_MCE_ENABLE) && defined(SUPPORT_ROLE_HANDOVER_SERVICE)
static void app_bt_takeover_trigger(void)
{
#ifdef AIR_BT_TAKEOVER_ENABLE
    const bt_device_manager_link_record_t *link_record = bt_device_manager_link_record_get_connected_link();

#ifdef AIR_MULTI_POINT_ENABLE
    bool is_support_emp = app_bt_emp_is_enable();
#else
    bool is_support_emp = FALSE;
#endif

    if (link_record == NULL) {
        APPS_LOG_MSGID_E(LOG_TAG" trigger, null link_record", 0);
    } else if ((is_support_emp && link_record->connected_num >= 3)
               || (!is_support_emp && link_record->connected_num >= 2)) {
        APPS_LOG_MSGID_I(LOG_TAG" trigger, emp=%d connected_num=%d", 2, is_support_emp, link_record->connected_num);
        bt_device_manager_link_record_takeover_callback(&link_record->connected_device[0]);
    }
#endif
}
#endif



/**================================================================================*/
/**                                     Public API                                 */
/**================================================================================*/
bool app_bt_takeover_service_user_register(app_bt_takeover_user_id_t user_id, app_bt_takeover_service_allow_func_t func)
{
    bool ret = FALSE;
    if (user_id < APP_BT_TAKEOVER_ID_MAX) {
        app_bt_takeover_user[user_id] = func;
        ret = TRUE;
    }
    APPS_LOG_MSGID_I(LOG_TAG" register, user_id=%d ret=%d", 2, user_id, ret);
    return ret;
}

bool app_bt_takeover_service_user_deregister(app_bt_takeover_user_id_t user_id)
{
    bool ret = FALSE;
    if (user_id < APP_BT_TAKEOVER_ID_MAX) {
        app_bt_takeover_user[user_id] = NULL;
        ret = TRUE;
    }
    APPS_LOG_MSGID_I(LOG_TAG" deregister, user_id=%d ret=%d", 2, user_id, ret);
    return ret;
}

void app_bt_takeover_service_init()
{
    app_bt_takeover_service_user_register(APP_BT_TAKEOVER_ID_BTSINK, app_bt_takeover_service_bt_sink_allow_cb);
}

bt_bd_addr_t *app_bt_takeover_service_get_last_takeover_device(void)
{
    return &app_bt_takeover_last_device;
}

void app_bt_takeover_service_disconnect_one(void)
{
    bt_aws_mce_role_t role = bt_connection_manager_device_local_info_get_aws_role();
    const bt_device_manager_link_record_t *link_record = bt_device_manager_link_record_get_connected_link();
    app_bt_takeover_priority_t priority_list[BT_DEVICE_MANAGER_LINK_RECORD_MAXIMUM] = {0};

    if (role == BT_AWS_MCE_ROLE_PARTNER || link_record == NULL || link_record->connected_num < 2) {
        APPS_LOG_MSGID_E(LOG_TAG" disconnect_one, [%02X] error link_record=0x%08X",
                         2, role, link_record);
        return;
    }

    uint8_t conn_num = link_record->connected_num;
    bt_device_manager_link_record_item_t *link_list = (bt_device_manager_link_record_item_t *)&link_record->connected_device[0];

    // Set first connected device as low priority
    priority_list[conn_num - 1] = APP_BT_TAKEOVER_PRIORITY_LOW;

    // Set last_played device as middle priority
#ifdef AIR_BT_SINK_SRV_STATE_MANAGER_ENABLE
    bt_sink_srv_state_manager_played_device_t *last_played_device = NULL;
    bt_sink_srv_state_manager_played_device_t played_list[3];
    uint32_t srv_num = bt_sink_srv_state_manager_get_played_device_list(played_list, 3);
    if (srv_num != 0) {
        APPS_LOG_MSGID_I(LOG_TAG" disconnect_one, last_played=%02X:%02X:%02X:%02X:%02X:%02X type=%d mask=%02X", 8,
                         played_list[0].address[5], played_list[0].address[4], played_list[0].address[3],
                         played_list[0].address[2], played_list[0].address[1], played_list[0].address[0],
                         played_list[0].type, played_list[0].mask);
        last_played_device = &(played_list[0]);
    }
#endif

    for (int i = 0; i < conn_num; i++) {
        uint8_t *addr = (uint8_t *)link_list[i].remote_addr;
        APPS_LOG_MSGID_I(LOG_TAG" disconnect_one, [%d] addr=%02X:%02X:%02X:%02X:%02X:XX link_type=%d addr_type=%d",
                         8, i, addr[5], addr[4], addr[3], addr[2], addr[1],
                         link_list[i].link_type, link_list[i].remote_bd_type);

#ifdef AIR_BT_SINK_SRV_STATE_MANAGER_ENABLE
        if (last_played_device != NULL && memcmp(addr, last_played_device->address, sizeof(bt_bd_addr_t)) == 0) {
            priority_list[i] = APP_BT_TAKEOVER_PRIORITY_MID;
            APPS_LOG_MSGID_I(LOG_TAG" disconnect_one, [%d] set MID for last_played_device", 1, i);
        }
#endif

        for (int user_index = 0; user_index < APP_BT_TAKEOVER_ID_MAX; user_index++) {
            app_bt_takeover_service_allow_func_t user_func = app_bt_takeover_user[user_index];
            if (user_func && !user_func(link_list[i].remote_addr)) {
                APPS_LOG_MSGID_I(LOG_TAG" disconnect_one, [%d] disallow user_id=%d -> set HIGH", 2, i, user_index);
                priority_list[i] = APP_BT_TAKEOVER_PRIORITY_HIGH;
                break;
            }
        }
    }

    // Print priority list
    for (int i = 0; i < conn_num; i++) {
        APPS_LOG_MSGID_I(LOG_TAG" disconnect_one, [%d] priority=%d", 2, i, priority_list[i]);
    }

    // Select lowest none/low/mid priority to disconnect
    uint8_t disconnect_index = 0;
    app_bt_takeover_priority_t lowest_priority = priority_list[0];
    for (int i = 1; i < conn_num; i++) {
        if (priority_list[i] < lowest_priority) {
            disconnect_index = i;
            lowest_priority = priority_list[i];
        }
    }

    if (priority_list[disconnect_index] != APP_BT_TAKEOVER_PRIORITY_HIGH) {
        uint8_t *addr = (uint8_t *)link_list[disconnect_index].remote_addr;
        uint8_t link_type = link_list[disconnect_index].link_type;
        APPS_LOG_MSGID_I(LOG_TAG" disconnect_one, select [%d] priority=%d addr=%02X:%02X:%02X:%02X:%02X:XX link_type=%d",
                         8, disconnect_index, priority_list[disconnect_index],
                         addr[5], addr[4], addr[3], addr[2], addr[1], link_type);

        if (link_type == BT_DEVICE_MANAGER_LINK_TYPE_EDR) {
            memcpy(app_bt_takeover_last_device, addr, BT_BD_ADDR_LEN);
            app_bt_takeover_service_disconnect_edr(addr);
        } else if (link_type == BT_DEVICE_MANAGER_LINK_TYPE_LE) {
#if defined(AIR_LE_AUDIO_ENABLE) || defined(AIR_BLE_ULTRA_LOW_LATENCY_ENABLE)
            memcpy(app_bt_takeover_last_device, addr, BT_BD_ADDR_LEN);
            app_lea_service_disconnect(TRUE, APP_LE_AUDIO_DISCONNECT_MODE_DISCONNECT, addr,
                                       BT_HCI_STATUS_REMOTE_TERMINATED_CONNECTION_DUE_TO_LOW_RESOURCES);
#endif
        }
    }
}

uint8_t *app_bt_takeover_get_disconnect_le_addr()
{
    bt_bd_addr_t zero_addr = {0};
    if (app_bt_takeover_disconnect_item.link_type != BT_DEVICE_MANAGER_LINK_TYPE_LE
        || memcmp(&(app_bt_takeover_disconnect_item.remote_addr), zero_addr, sizeof(bt_bd_addr_t)) == 0) {
        return NULL;
    }
    uint8_t *addr = (uint8_t *)(app_bt_takeover_disconnect_item.remote_addr);
    APPS_LOG_MSGID_I(LOG_TAG" get_disconnect_le_addr, addr=%02X:%02X:%02X:%02X:%02X:%02X",
                     6, addr[5], addr[4], addr[3], addr[2], addr[1], addr[0]);
    return addr;
}

void app_bt_takeover_clear_disconnect_le_addr()
{
    APPS_LOG_MSGID_I(LOG_TAG" clear_disconnect_le_addr", 0);
    memset(&app_bt_takeover_disconnect_item, 0, sizeof(bt_device_manager_link_record_item_t));
}

void app_bt_takeover_proc_ui_shell_event(uint32_t event_group, uint32_t event_id, void *extra_data, size_t data_len)
{
#ifdef MTK_AWS_MCE_ENABLE
    if (event_group == EVENT_GROUP_UI_SHELL_AWS_DATA) {
        app_bt_takeover_service_proc_aws_data(extra_data, data_len);
    }
#ifdef SUPPORT_ROLE_HANDOVER_SERVICE
    if (event_group == EVENT_GROUP_UI_SHELL_APP_INTERACTION
        && event_id == APPS_EVENTS_INTERACTION_PARTNER_SWITCH_TO_AGENT) {
        app_rho_result_t rho_result = (app_rho_result_t)extra_data;
        //APPS_LOG_MSGID_I(LOG_TAG" [new Agent] RHO done - %d", 1, rho_result);
        if (APP_RHO_RESULT_SUCCESS == rho_result) {
            app_bt_takeover_trigger();
        }
    }
#endif
#endif
}
