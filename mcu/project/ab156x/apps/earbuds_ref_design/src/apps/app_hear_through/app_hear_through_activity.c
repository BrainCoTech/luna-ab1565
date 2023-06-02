/* Copyright Statement:
 *
 * (C) 2023  Airoha Technology Corp. All rights reserved.
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

#include "app_hear_through_activity.h"
#include "app_hear_through_race_cmd_handler.h"
#include "app_hear_through_adv.h"
#include "apps_config_event_list.h"
#include "apps_events_event_group.h"
#include "app_hear_through_storage.h"
#include "apps_aws_sync_event.h"
#include "bt_connection_manager.h"
#include "bt_device_manager.h"
#include "bt_device_manager_power.h"
#include "apps_events_bt_event.h"
#include "ui_shell_manager.h"
#include "apps_debug.h"
#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
#include "audio_psap_control.h"
#endif
#ifdef AIR_HEARTHROUGH_VIVID_PT_ENABLE
#include "audio_vivid_pt_api.h"
#endif
#include "race_cmd.h"
#include "race_event.h"
#include "stddef.h"
#include "bt_system.h"
#include "hal_platform.h"
#include "hal_gpt.h"
#include "apps_events_interaction_event.h"
#ifdef MTK_AWS_MCE_ENABLE
#include "bt_aws_mce_srv.h"
#endif /* MTK_AWS_MCE_ENABLE */
#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
#include "app_hearing_aid_activity.h"
#include "app_hearing_aid_utils.h"
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */
#ifdef MTK_ANC_ENABLE
#include "app_anc_service.h"
#include "anc_control_api.h"
#endif /* MTK_ANC_ENABLE */

#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
#include "battery_management.h"
#include "apps_events_battery_event.h"
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */
#ifdef AIR_SMART_CHARGER_ENABLE
#include "app_smcharger.h"
#endif /* AIR_SMART_CHARGER_ENABLE */

#ifdef AIR_HEARTHROUGH_MAIN_ENABLE

#define APP_HEAR_THROUGH_ACT_TAG        "[HearThrough][Activity]"

#define APP_HEAR_THROUGH_SYNC_EVENT_DEFAULT_TIMEOUT     500

#define APP_HEAR_THROUGH_MODE_LENGTH                    5
#define APP_HEAR_THROUGH_OP_PARAMETER_INDEX             3

#define APP_HEARING_AID_CONFIG_TYPE_MAXIMUM             0x1000
#define APP_HEAR_THROUGH_CONFIG_TYPE_MAXIMUM            0x2000

#define APP_HEAR_THROUGH_CONFIG_TYPE_SWITCH             0x1001
#define APP_HEAR_THROUGH_CONFIG_TYPE_MODE               0x1002

#define APP_VIVID_PT_CONFIG_TYPE_AFC_SWITCH             0x2001
#define APP_VIVID_PT_CONFIG_TYPE_LDNR_SWITCH            0x2002

#define APP_HEAR_THROUGH_AWS_EVENT_ID_SYNC_REQUEST      0x3001
#define APP_HEAR_THROUGH_AWS_EVENT_ID_SYNC              0x3002

#define APP_HEAR_THROUGH_SYNC_EVENT_ID_AMBIENT_CONTROL_SWITCH      0x4001

#define APP_HEAR_THROUGH_MODE_SWITCH_INDEX_OFF          0x00
#define APP_HEAR_THROUGH_MODE_SWITCH_INDEX_HEAR_THROUGH 0x01
#define APP_HEAR_THROUGH_MODE_SWITCH_INDEX_ANC          0x02

typedef struct {
#ifdef MTK_RACE_EVENT_ID_ENABLE
    int32_t                             race_register_id;
#endif /* MTK_RACE_EVENT_ID_ENABLE */
#ifdef MTK_ANC_ENABLE
#if 0
    uint8_t                             info_anc_enabled;
    audio_anc_control_filter_id_t       info_anc_filter_id;
    audio_anc_control_type_t            info_anc_type;
    int16_t                             info_anc_runtime_gain;
    uint8_t                             info_anc_support_hybrid;
    audio_anc_control_misc_t            info_anc_control_misc;
#endif
    uint32_t                            old_anc_target_type;
#endif /* MTK_ANC_ENABLE */
    bool                                is_hear_through_enabled;
    bool                                is_powering_off;
    bool                                trigger_from_key;
    bool                                init_done;
    bool                                need_operate_anc;
    uint8_t                             mode_index;
#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
    bool                                is_charger_in;
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */
} app_hear_through_context_t;

static app_hear_through_context_t app_hear_through_ctx;


#ifdef MTK_AWS_MCE_ENABLE
typedef struct {
    bt_clock_t          target_clock;
    uint32_t            delay_ms;
    uint16_t            op_data_len;
    uint8_t             op_data[0];
} __attribute__((packed)) app_hear_through_aws_operate_command_t;

typedef struct {
    uint8_t             mode_index;
} __attribute__((packed)) app_hear_through_sync_ambient_control_switch_t;

typedef struct {
    bool                from_key;
    uint8_t             hear_through_switch;
    uint8_t             hear_through_mode;
    uint8_t             ambient_control_index;
} __attribute__((packed)) app_hear_through_sync_configuration_t;

#endif /* MTK_AWS_MCE_ENABLE */

static bool app_hear_through_switch_on_off(bool need_store, bool enable);
static bool app_hear_through_switch_mode(uint8_t mode);
static bool app_hear_through_is_aws_connected();
static bool app_hear_through_activity_is_out_case();

#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
static bool app_hear_through_proc_hearing_aid_event(int32_t event_id, void *extra_data, size_t data_len);
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */

#ifdef MTK_AWS_MCE_ENABLE
static bool app_hear_through_is_aws_connected()
{
    bt_aws_mce_srv_link_type_t link_type = bt_aws_mce_srv_get_link_type();
    if (link_type == BT_AWS_MCE_SRV_LINK_NONE) {
        return false;
    }
    return true;
}

static void app_hear_through_sync_event_handler_locally(uint32_t event_id,
                                                        uint8_t *buf,
                                                        uint16_t buf_len,
                                                        bt_clock_t *target_clock,
                                                        uint32_t delay_ms)
{
    uint32_t target_gpt = 0;
    uint32_t cur_gpt = 0;

    bt_status_t bt_clk_to_gpt_result = BT_STATUS_SUCCESS;

    if ((target_clock->nclk != 0) || (target_clock->nclk_intra != 0)) {
        bt_sink_srv_convert_bt_clock_2_gpt_count((const bt_clock_t *)target_clock, &target_gpt);
        hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &cur_gpt);
    }

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_sync_event_handler_locally] event_id : 0x%04x, buf_len : %d, target_bt_clock : %d, %d, delay_ms : %d",
                        5,
                        event_id,
                        buf_len,
                        target_clock->nclk,
                        target_clock->nclk_intra,
                        delay_ms);

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_sync_event_handler_locally] target_gpt : %d, cur_gpt : %d",
                        2,
                        target_gpt,
                        cur_gpt);

    if (bt_clk_to_gpt_result != BT_STATUS_SUCCESS) {
        APPS_LOG_MSGID_E(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_sync_event_handler_locally] Failed to calculate bt clock to GPT count with result : 0x%04x",
                            1,
                            bt_clk_to_gpt_result);
        target_gpt = 0;
    }

    if (target_gpt != 0 && (target_gpt < cur_gpt || (target_gpt - cur_gpt) > delay_ms * 1000)) {
        APPS_LOG_MSGID_W(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_sync_event_handler_locally] Reset target gpt to be 0", 0);
        target_gpt = 0;
    }

    uint32_t actual_delay_ms = 0;
    if (target_gpt != 0) {
        actual_delay_ms = (target_gpt - cur_gpt) / 1000;
    }

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_sync_event_handler_locally] actual_delay_ms : %d",
                        1,
                        actual_delay_ms);

    uint8_t *send_buf = NULL;
    if ((buf_len != 0) && (buf != NULL)) {
        send_buf = (uint8_t *)pvPortMalloc(buf_len);
        if (send_buf == NULL) {
            APPS_LOG_MSGID_E(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_sync_event_handler_locally] Failed to allocate buffer for ui shell event", 0);
            return;
        }
        memcpy(send_buf, buf, buf_len);
    }

    ui_shell_send_event(false,
                        EVENT_PRIORITY_HIGHEST,
                        EVENT_GROUP_UI_SHELL_HEAR_THROUGH,
                        event_id,
                        send_buf,
                        buf_len,
                        NULL,
                        actual_delay_ms);
}

static void app_hear_through_send_sync_event(bool need_sync_operate, uint32_t event_id, uint8_t *buf, uint16_t buf_len, uint32_t delay_ms)
{
    bt_clock_t target_bt_clk = {0};

    uint32_t op_cmd_len = sizeof(app_hear_through_aws_operate_command_t) + buf_len;
    app_hear_through_aws_operate_command_t *op_cmd = (app_hear_through_aws_operate_command_t *)pvPortMalloc(op_cmd_len);

    if (op_cmd == NULL) {
        APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_send_sync_event] Failed to allocate buffer to send sync event, 0x%02x, buf_len : %d",
                            2,
                            event_id,
                            buf_len);

        app_hear_through_sync_event_handler_locally(event_id,
                                                    buf,
                                                    buf_len,
                                                    NULL,
                                                    0);
        return;
    }

    bool need_bt_clock = true;

    if (need_sync_operate == true) {
        bt_status_t get_bt_clock_result = bt_sink_srv_bt_clock_addition(&target_bt_clk, 0, delay_ms * 1000);
        if (get_bt_clock_result != BT_STATUS_SUCCESS) {
            APPS_LOG_MSGID_E(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_send_sync_event] Get bt clock failed : 0x%04x", 1, get_bt_clock_result);
            need_bt_clock = false;
            memset((void *)(&(op_cmd->target_clock)), 0, sizeof(bt_clock_t));
        } else {
            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_send_sync_event] target_bt_clk : %d, %d", 2, target_bt_clk.nclk, target_bt_clk.nclk_intra);
            memcpy((void *)(&(op_cmd->target_clock)), (void *)(&target_bt_clk), sizeof(bt_clock_t));
        }
    } else {
        memset((void *)(&(op_cmd->target_clock)), 0, sizeof(bt_clock_t));
    }

    op_cmd->op_data_len = buf_len;
    op_cmd->delay_ms = delay_ms;

    if (buf_len > 0 && buf != NULL) {
        memcpy(op_cmd->op_data, buf, buf_len);
    }

    bt_status_t status = apps_aws_sync_event_send_extra(EVENT_GROUP_UI_SHELL_HEAR_THROUGH,
                                                        event_id,
                                                        op_cmd,
                                                        op_cmd_len);

    vPortFree(op_cmd);
    op_cmd = NULL;

    if (status != BT_STATUS_SUCCESS) {
        APPS_LOG_MSGID_E(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_send_sync_event] Failed to send to partner, code : 0x%02x, buf_len : %d, result : 0x%04x",
                         3, event_id, buf_len, status);
        need_bt_clock = false;
    }

    if (need_sync_operate == true) {
        app_hear_through_sync_event_handler_locally(event_id,
                                                    buf,
                                                    buf_len,
                                                    ((need_bt_clock == true) ? &target_bt_clk : NULL),
                                                    delay_ms);
    }
}
#endif /* MTK_AWS_MCE_ENABLE */

static void app_hear_through_update_ambient_control_mode()
{
    app_hear_through_ctx.need_operate_anc = false;
    if (app_hear_through_storage_get_hear_through_switch() == true) {
        app_hear_through_ctx.need_operate_anc = true;
        app_hear_through_ctx.mode_index = APP_HEAR_THROUGH_MODE_SWITCH_INDEX_HEAR_THROUGH;
    } else {
        bool is_anc_enabled = app_anc_service_is_anc_enabled();
        if (is_anc_enabled == true) {
            app_hear_through_ctx.mode_index = APP_HEAR_THROUGH_MODE_SWITCH_INDEX_ANC;
        } else {
            app_hear_through_ctx.mode_index = APP_HEAR_THROUGH_MODE_SWITCH_INDEX_OFF;
        }
    }
    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_update_ambient_control_mode] ambient control mode_index : %d", 1, app_hear_through_ctx.mode_index);
}

static void app_hear_through_notify_switch_state_change(bool on)
{
#ifdef MTK_AWS_MCE_ENABLE
    bt_aws_mce_role_t role = bt_device_manager_aws_local_info_get_role();

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_notify_switch_state_change] enable : %d, role : 0x%02x",
                        2,
                        on,
                        role);

    if (role == BT_AWS_MCE_ROLE_AGENT) {
        app_hear_through_race_cmd_send_notification(APP_HEAR_THROUGH_CONFIG_TYPE_SWITCH,
                                                (uint8_t *)&on,
                                                sizeof(uint8_t));
    }
#else
    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_notify_switch_state_change] switch_on : %d",
                        1,
                        on);

    app_hear_through_race_cmd_send_notification(APP_HEAR_THROUGH_CONFIG_TYPE_SWITCH,
                                                (uint8_t *)&on,
                                                sizeof(uint8_t));
#endif /* MTK_AWS_MCE_ENABLE */
}

static bool app_hear_through_activity_handle_switch_set_cmd(void *extra_data, uint32_t data_len)
{
    bool ret_value = false;
    bool is_out_case = app_hear_through_activity_is_out_case();
    uint8_t *parameter = (uint8_t *)extra_data;
    app_hear_through_mode_t running_mode = app_hear_through_storage_get_hear_through_mode();

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_handle_switch_set_cmd] out_case : %d, running_mode : %d, trigger_from : %d, switch change to : %d",
                     4,
                     is_out_case,
                     running_mode,
                     app_hear_through_ctx.trigger_from_key,
                     parameter[0]);

#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
    if (running_mode == APP_HEAR_THROUGH_MODE_HA_PSAP) {
        app_hearing_aid_activity_set_user_switch(false, parameter[0]);
    }
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */

    if (is_out_case == false) {
        app_hear_through_storage_set_hear_through_switch(parameter[0]);
        return true;
    }

    app_hear_through_ctx.trigger_from_key = false;
    ret_value = app_hear_through_switch_on_off(true, parameter[0]);

    app_hear_through_update_ambient_control_mode();

    return ret_value;
}

static bool app_hear_through_activity_handle_mode_set_cmd(void *extra_data, uint32_t data_len)
{
    bool ret_value = false;
    bool is_out_case = app_hear_through_activity_is_out_case();
    uint8_t *parameter = (uint8_t *)extra_data;
    bool switch_state = app_hear_through_storage_get_hear_through_switch();

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_handle_mode_set_cmd] out_case : %d, switch_state : %d, mode_to_be : %d",
                        3,
                        is_out_case,
                        switch_state,
                        parameter[0]);

#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
    if (parameter[0] == APP_HEAR_THROUGH_MODE_HA_PSAP) {
        app_hearing_aid_activity_set_user_switch(false, switch_state);
    } else {
        app_hearing_aid_activity_set_user_switch(false, false);
    }
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */

    if (is_out_case == false) {
        app_hear_through_storage_set_hear_through_mode(parameter[0]);
        return true;
    }

    ret_value = app_hear_through_switch_mode(parameter[0]);

    return ret_value;
}

static bool app_hear_through_activity_handle_afc_set_cmd(void *extra_data, uint32_t data_len)
{
    bool ret_value = false;
    uint8_t *parameter = (uint8_t *)extra_data;

    audio_vivid_pt_status_t afc_switch_result = audio_vivid_passthru_afc_set_switch(parameter[0]);
    if (afc_switch_result == AUDIO_VIVID_PT_STATUS_SUCCESS) {
        ret_value = true;
    }

    return ret_value;
}

static bool app_hear_through_activity_handle_ldnr_set_cmd(void *extra_data, uint32_t data_len)
{
    bool ret_value = false;
    uint8_t *parameter = (uint8_t *)extra_data;

    audio_vivid_pt_status_t nr_switch_result = audio_vivid_passthru_nr_set_switch(parameter[0]);
    if (nr_switch_result == AUDIO_VIVID_PT_STATUS_SUCCESS) {
        ret_value = true;
    }

    return ret_value;
}

static bool app_hear_through_activity_handle_set_cmd(uint16_t config_type, void *extra_data, uint32_t data_len)
{
    bool ret_value = false;

    if (config_type == APP_HEAR_THROUGH_CONFIG_TYPE_SWITCH) {
        ret_value = app_hear_through_activity_handle_switch_set_cmd(extra_data, data_len);
    } else if (config_type == APP_HEAR_THROUGH_CONFIG_TYPE_MODE) {
        ret_value = app_hear_through_activity_handle_mode_set_cmd(extra_data, data_len);
    } else if (config_type == APP_VIVID_PT_CONFIG_TYPE_AFC_SWITCH) {
        ret_value = app_hear_through_activity_handle_afc_set_cmd(extra_data, data_len);
    } else if (config_type == APP_VIVID_PT_CONFIG_TYPE_LDNR_SWITCH) {
        ret_value = app_hear_through_activity_handle_ldnr_set_cmd(extra_data, data_len);
    }

    return ret_value;
}

static void app_hear_through_activity_handle_get_cmd(uint16_t config_type)
{
    uint8_t state = 0;
    audio_vivid_pt_status_t status = AUDIO_VIVID_PT_STATUS_SUCCESS;
    uint8_t response[APP_HEAR_THROUGH_MODE_LENGTH] = {0};
    uint8_t response_len = 0;
    bool ret_result = false;

    if (config_type == APP_HEAR_THROUGH_CONFIG_TYPE_SWITCH) {
        state = app_hear_through_storage_get_hear_through_switch();
    } else if (config_type == APP_VIVID_PT_CONFIG_TYPE_AFC_SWITCH) {
        status = audio_vivid_passthru_afc_get_switch((bool*)&state);
    } else if (config_type == APP_VIVID_PT_CONFIG_TYPE_LDNR_SWITCH) {
        status = audio_vivid_passthru_nr_get_switch((bool*)&state);
    } else if (config_type == APP_HEAR_THROUGH_CONFIG_TYPE_MODE) {
        state = app_hear_through_storage_get_hear_through_mode();
    } else {
        return;
    }

    response[0] = state;
    if (status == AUDIO_VIVID_PT_STATUS_SUCCESS) {
        ret_result = true;
    }
    if (config_type != APP_HEAR_THROUGH_CONFIG_TYPE_MODE) {
        response_len = 1;
    } else {
        response_len = APP_HEAR_THROUGH_MODE_LENGTH;
    }

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_handle_get_cmd] Get configure type : 0x%04x, result : %d, response_len : %d",
                     3,
                     config_type,
                     ret_result,
                     response_len);

    if (ret_result == true) {
        app_hear_through_race_cmd_send_get_response(config_type, response, response_len);
    } else {
        app_hear_through_race_cmd_send_get_response(config_type, NULL, 0);
    }
}

static const uint32_t APP_HEAR_THROUGH_PT_TYPE_MAPPING_TABLE[] = {
    AUDIO_ANC_CONTROL_TYPE_HYBRID,
    AUDIO_ANC_CONTROL_TYPE_FF,
    AUDIO_ANC_CONTROL_TYPE_FB,
    AUDIO_ANC_CONTROL_TYPE_DUMMY,
    AUDIO_ANC_CONTROL_TYPE_DUMMY,
};

#define APP_HEAR_THROUGH_PT_MAPPING_TABLE_LENGTH        (sizeof(APP_HEAR_THROUGH_PT_TYPE_MAPPING_TABLE) / sizeof(uint32_t))

static void app_hear_through_init_anc()
{
#if 0
#ifdef MTK_ANC_ENABLE
    audio_anc_control_get_status(&app_hear_through_ctx.info_anc_enabled,
                                 &app_hear_through_ctx.info_anc_filter_id,
                                 &app_hear_through_ctx.info_anc_type,
                                 &app_hear_through_ctx.info_anc_runtime_gain,
                                 &app_hear_through_ctx.info_anc_support_hybrid,
                                 &app_hear_through_ctx.info_anc_control_misc);

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_init_anc] enabled : %d, filer_id : %d, type : %d, runtime_gain : %d, support_hybrid : %d, misc : %d",
                     6,
                     app_hear_through_ctx.info_anc_enabled,
                     app_hear_through_ctx.info_anc_filter_id,
                     app_hear_through_ctx.info_anc_type,
                     app_hear_through_ctx.info_anc_runtime_gain,
                     app_hear_through_ctx.info_anc_support_hybrid,
                     app_hear_through_ctx.info_anc_control_misc);
#endif /* MTK_ANC_ENABLE */
#endif /* 0 */
}

static void app_hear_through_handle_anc()
{
#ifdef MTK_ANC_ENABLE

    app_hear_through_mode_t running_mode = app_hear_through_storage_get_hear_through_mode();

    uint8_t anc_mode_with_vivid_pt = app_hear_through_storage_get_anc_mode_with_vivid_pt();
    uint8_t anc_mode_with_ha = app_hear_through_storage_get_anc_mode_with_ha_psap();

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_handle_anc] running_mode : %d, hear_through_enabled : %d, v_pt_mode : %d, ha_pt_mode : %d, MAPPING_TABLE_LEN : %d, powering_off : %d",
                        6,
                        running_mode,
                        app_hear_through_ctx.is_hear_through_enabled,
                        anc_mode_with_vivid_pt,
                        anc_mode_with_ha,
                        APP_HEAR_THROUGH_PT_MAPPING_TABLE_LENGTH,
                        app_hear_through_ctx.is_powering_off);

    if (app_hear_through_ctx.is_powering_off == true) {
        app_hear_through_ctx.old_anc_target_type = AUDIO_ANC_CONTROL_TYPE_DUMMY;
        return;
    }

    if (app_hear_through_ctx.need_operate_anc == false) {
        APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_handle_anc] No need to operate ANC", 0);
        return;
    }

    if (app_hear_through_ctx.is_hear_through_enabled == true) {
        uint32_t target_anc_type = AUDIO_ANC_CONTROL_TYPE_DUMMY;

        if (running_mode == APP_HEAR_THROUGH_MODE_HA_PSAP) {
#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
            if (anc_mode_with_ha < APP_HEAR_THROUGH_PT_MAPPING_TABLE_LENGTH) {
                if (app_hearing_aid_activity_is_hearing_aid_on() == true) {
                    target_anc_type = APP_HEAR_THROUGH_PT_TYPE_MAPPING_TABLE[anc_mode_with_ha];
                }
            }
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */
        } else if (running_mode == APP_HEAR_THROUGH_MODE_VIVID_PT) {
            if (anc_mode_with_vivid_pt < APP_HEAR_THROUGH_PT_MAPPING_TABLE_LENGTH) {
                target_anc_type = APP_HEAR_THROUGH_PT_TYPE_MAPPING_TABLE[anc_mode_with_vivid_pt];
            }
        }

        APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_handle_anc] old_target_anc_type : %d, target_anc_type : %d",
                            2,
                            app_hear_through_ctx.old_anc_target_type,
                            target_anc_type);

        if (target_anc_type == AUDIO_ANC_CONTROL_TYPE_DUMMY) {
            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_handle_anc] disable ANC", 0);
            app_anc_service_disable();
            app_hear_through_ctx.old_anc_target_type = AUDIO_ANC_CONTROL_TYPE_DUMMY;
            return;
        }

        if (app_hear_through_ctx.old_anc_target_type == target_anc_type) {
            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_handle_anc] target ANC type is not changed, IGNORE", 0);
            return;
        }

        app_hear_through_ctx.old_anc_target_type = target_anc_type;
        audio_anc_control_filter_id_t filter_id = 0x00;
        int16_t gain = 0x00;

        bool get_value_result = app_anc_service_get_hear_through_anc_parameter(&filter_id, &gain);
        if (get_value_result == false) {
            APPS_LOG_MSGID_E(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_handle_anc] Failed to get ANC parameter", 0);
            return;
        }

        app_anc_service_enable(filter_id,
                                target_anc_type,
                                gain,
                                NULL);

#if 0
        app_anc_service_enable(app_hear_through_ctx.info_anc_filter_id,
                               target_anc_type,
                               app_hear_through_ctx.info_anc_runtime_gain,
                               &app_hear_through_ctx.info_anc_control_misc);
#endif /* 0 */
    } else {

        if (app_hear_through_ctx.need_operate_anc == true) {
            app_anc_service_reset_hear_through_anc(false);
        }

        app_hear_through_ctx.old_anc_target_type = AUDIO_ANC_CONTROL_TYPE_DUMMY;

#if 0
        APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_handle_anc] anc_enabled : %d",
                         1,
                         app_hear_through_ctx.info_anc_enabled);

        if (app_hear_through_ctx.info_anc_enabled == true) {
            app_anc_service_enable(app_hear_through_ctx.info_anc_filter_id,
                                   app_hear_through_ctx.info_anc_type,
                                   app_hear_through_ctx.info_anc_runtime_gain,
                                   &app_hear_through_ctx.info_anc_control_misc);
        } else {
            app_anc_service_disable();
        }
#endif
    }
#endif
}

static bool app_hear_through_switch_on_off(bool need_store, bool enable)
{
    bool ret_value = false;

    app_hear_through_mode_t running_mode = app_hear_through_storage_get_hear_through_mode();
    bool ht_switch = app_hear_through_storage_get_hear_through_switch();
    bool is_out_case = app_hear_through_activity_is_out_case();

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_switch_on_off] enable : %d, running_mode : %d, ht_switch : %d, out_case : %d, trigger_from_key : %d, powering_off : %d",
                        6,
                        enable,
                        running_mode,
                        ht_switch,
                        is_out_case,
                        app_hear_through_ctx.trigger_from_key,
                        app_hear_through_ctx.is_powering_off);

    if ((is_out_case == false) && (enable == true)) {
        return false;
    }

    app_anc_service_set_hear_through_enabled(enable);

    // if (ht_switch == enable) {
    //     return true;
    // }

    if (need_store == true) {
        app_hear_through_storage_set_hear_through_switch(enable);
    }

    if (app_hear_through_ctx.trigger_from_key == true) {
        if (ht_switch != enable) {
            app_hear_through_notify_switch_state_change(enable);
        }
    }

    if (app_hear_through_ctx.is_powering_off == true) {
        return false;
    }

    if (running_mode == APP_HEAR_THROUGH_MODE_VIVID_PT) {
        audio_vivid_pt_status_t vivid_pt_result = AUDIO_VIVID_PT_STATUS_SUCCESS;
        if (enable == true) {
            vivid_pt_result = audio_vivid_pt_open();
        } else {
            vivid_pt_result = audio_vivid_pt_close();
        }
        ret_value = (vivid_pt_result == AUDIO_VIVID_PT_STATUS_SUCCESS) ? true : false;

#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
        app_hearing_aid_activity_set_open_fwk_done(false);
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */

    } else if (running_mode == APP_HEAR_THROUGH_MODE_HA_PSAP) {
#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
        if (enable == true) {
            ret_value = app_hearing_aid_activity_open_hearing_aid_fwk();
        } else {
            ret_value = app_hearing_aid_activity_disable_hearing_aid(app_hear_through_ctx.trigger_from_key);
        }
#else
        assert(false && "Not enable AIR_HEARING_AID_ENABLE feature option");
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */
    }

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_switch_on_off] result : %d",
                        1,
                        ret_value);

    return ret_value;
}

static bool app_hear_through_switch_mode(uint8_t mode)
{
    app_hear_through_mode_t running_mode = app_hear_through_storage_get_hear_through_mode();
    bool ht_switch = app_hear_through_storage_get_hear_through_switch();

    bool is_out_case = app_hear_through_activity_is_out_case();

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_switch_mode] mode : %d, running_mode : %d, ht_switch : %d, out_case : %d, powering_off : %d",
                        5,
                        mode,
                        running_mode,
                        ht_switch,
                        is_out_case,
                        app_hear_through_ctx.is_powering_off);

    if ((is_out_case == false) && (ht_switch == true)) {
        return false;
    }

    if ((mode != APP_HEAR_THROUGH_MODE_VIVID_PT)
        && (mode != APP_HEAR_THROUGH_MODE_HA_PSAP)) {
        return false;
    }

    if ((running_mode != APP_HEAR_THROUGH_MODE_HA_PSAP)
        && (running_mode != APP_HEAR_THROUGH_MODE_VIVID_PT)) {
        return false;
    }

    if (running_mode == mode) {
        return true;
    }

    app_hear_through_storage_set_hear_through_mode(mode);

    if (app_hear_through_ctx.is_powering_off == true) {
        return false;
    }

    audio_vivid_pt_status_t vivid_pt_result = AUDIO_VIVID_PT_STATUS_SUCCESS;
#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
    bool ha_result = false;
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */

    if (ht_switch == true) {
        app_hear_through_ctx.old_anc_target_type = AUDIO_ANC_CONTROL_TYPE_DUMMY;

        if (mode == APP_HEAR_THROUGH_MODE_HA_PSAP) {
#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
            ha_result = app_hearing_aid_activity_open_hearing_aid_fwk();
            if (ha_result == false) {
                APPS_LOG_MSGID_E(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_switch_mode] enable HA failed", 0);
                return false;
            }
#else
            assert(false && "Not enable AIR_HEARING_AID_ENABLE feature option");
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */
        } else {
            vivid_pt_result = audio_vivid_pt_open();
            if (vivid_pt_result != AUDIO_VIVID_PT_STATUS_SUCCESS) {
                APPS_LOG_MSGID_E(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_switch_mode] open vivid_pt failed, %d",
                                 1,
                                 vivid_pt_result);
                return false;
            }

#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
            app_hearing_aid_activity_set_open_fwk_done(false);
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */
        }
    }

    return true;
}

static void app_hear_through_activity_handle_ambient_control_switch()
{
    app_hear_through_ctx.need_operate_anc = false;

#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
    app_hearing_aid_activity_set_user_switch(false, false);
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */

    switch (app_hear_through_ctx.mode_index) {
        case APP_HEAR_THROUGH_MODE_SWITCH_INDEX_OFF: {
            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_handle_ambient_control_switch] OFF", 0);
            app_hear_through_ctx.trigger_from_key = false;
            app_hear_through_switch_on_off(true, false);
            app_anc_service_disable();
        }
        break;
        case APP_HEAR_THROUGH_MODE_SWITCH_INDEX_HEAR_THROUGH: {
            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_handle_ambient_control_switch] Enable Hear Through", 0);
            app_hear_through_ctx.trigger_from_key = true;

#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
            uint8_t hear_through_mode = app_hear_through_storage_get_hear_through_mode();
            if (hear_through_mode == APP_HEAR_THROUGH_MODE_HA_PSAP) {
                app_hearing_aid_activity_set_user_switch(false, true);
            }
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */

            app_hear_through_ctx.need_operate_anc = true;
            app_hear_through_switch_on_off(true, true);
        }
        break;
        case APP_HEAR_THROUGH_MODE_SWITCH_INDEX_ANC: {
            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_handle_ambient_control_switch] Enable ANC", 0);

            app_hear_through_ctx.trigger_from_key = true;

            app_hear_through_switch_on_off(true, false);
            app_anc_service_reset_hear_through_anc(true);

            app_hear_through_ctx.old_anc_target_type = AUDIO_ANC_CONTROL_TYPE_DUMMY;
        }
        break;
        default:
        return;
    }
}

static void app_hear_through_activity_handle_ht_enable(bool enable)
{
    uint32_t turn_on_hear_through_timeout = app_hear_through_storage_get_hear_through_turn_on_after_boot_up_timeout();
    bool turn_on_hear_through = app_hear_through_storage_get_hear_through_switch();

    app_hear_through_ctx.is_powering_off = false;

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_handle_ht_enable] enable : %d, ht_turn_on_config : %d, timeout : %d",
                     3,
                     enable,
                     turn_on_hear_through,
                     turn_on_hear_through_timeout);

    if (enable == true) {
        if (turn_on_hear_through == true) {
            ui_shell_send_event(false,
                                EVENT_PRIORITY_MIDDLE,
                                EVENT_GROUP_UI_SHELL_HEAR_THROUGH,
                                APP_HEAR_THROUGH_EVENT_ID_POWER_ON_TO_OPERATE_HT,
                                NULL,
                                0,
                                NULL,
                                turn_on_hear_through_timeout);
        }
    } else {
        app_hear_through_switch_on_off(false, false);
    }
}

#ifdef MTK_AWS_MCE_ENABLE
static void app_hear_through_send_configuration(bool need_sync_operate, bool is_key_event, bool switch_status, uint8_t mode)
{
    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_send_configuration] send CONFIGURATION_SYNC event, need_sync_operate : %d, is_key_event : %d, switch_status : %d, running_mode : %d, ambient_control_mode : %d",
                        5,
                        need_sync_operate,
                        is_key_event,
                        switch_status,
                        mode,
                        app_hear_through_ctx.mode_index);

    app_hear_through_sync_configuration_t configuration;

    configuration.from_key = is_key_event;
    configuration.hear_through_switch = switch_status;
    configuration.hear_through_mode = mode;
    configuration.ambient_control_index = app_hear_through_ctx.mode_index;

    app_hear_through_send_sync_event(need_sync_operate,
                                        APP_HEAR_THROUGH_AWS_EVENT_ID_SYNC,
                                        (uint8_t *)&configuration,
                                        sizeof(app_hear_through_sync_configuration_t),
                                        APP_HEAR_THROUGH_SYNC_EVENT_DEFAULT_TIMEOUT);
}
#endif /* MTK_AWS_MCE_ENABLE */

/**
 * @brief Handle hear through advertising timeout to stop advertising.
 *
 * @param data
 * @param data_len
 */
static void app_hear_through_activity_handle_advertising_timeout()
{
    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_handle_advertising_timeout] Advertising timeout, stop advertising", 0);
#ifdef MTK_AWS_MCE_ENABLE
    if (bt_device_manager_aws_local_info_get_role() == BT_AWS_MCE_ROLE_AGENT) {
#endif /* MTK_AWS_MCE_ENABLE */
        app_hear_through_adv_stop();
#ifdef MTK_AWS_MCE_ENABLE
    }
#endif /* MTK_AWS_MCE_ENABLE */
}

/**
 * @brief Handle the RACE connected with SmartPhone.
 * If connected, need stop the ADV.
 *
 * @param data
 * @param data_len
 */
static void app_hear_through_activity_handle_race_connected()
{
    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_handle_race_connected] Race connected, stop advertising", 0);
#ifdef MTK_AWS_MCE_ENABLE
    if (bt_device_manager_aws_local_info_get_role() == BT_AWS_MCE_ROLE_AGENT) {
#endif /* MTK_AWS_MCE_ENABLE */
        app_hear_through_adv_stop();
#ifdef MTK_AWS_MCE_ENABLE
    }
#endif /* MTK_AWS_MCE_ENABLE */
}

/**
 * @brief Handle the RACE disconnected with SmartPhone.
 * If disconnected, need start the ADV.
 *
 * @param data
 * @param data_len
 */
static void app_hear_through_activity_handle_race_disconnected()
{
    bool is_out_case = app_hear_through_activity_is_out_case();
    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_handle_race_disconnected] Race disconnected, start advertising, out_case : %d",
                     1,
                     is_out_case);
#ifdef MTK_AWS_MCE_ENABLE
    if (bt_device_manager_aws_local_info_get_role() == BT_AWS_MCE_ROLE_AGENT) {
#endif /* MTK_AWS_MCE_ENABLE */
        if (is_out_case == true) {
            app_hear_through_adv_start();
        }
#ifdef MTK_AWS_MCE_ENABLE
    }
#endif /* MTK_AWS_MCE_ENABLE */
}

#ifdef MTK_RACE_CMD_ENABLE
#ifdef MTK_RACE_EVENT_ID_ENABLE
static RACE_ERRCODE app_hear_through_activity_race_event_handler(int32_t id, race_event_type_enum event_type, void *param, void *user_data)
#else
static RACE_ERRCODE app_hear_through_activity_race_event_handler(race_event_type_enum event_type, void *param, void *user_data)
#endif /* MTK_RACE_EVENT_ID_ENABLE */
{
#ifdef MTK_RACE_EVENT_ID_ENABLE
    if (id == app_hear_through_ctx.race_register_id) {
#endif /* MTK_RACE_EVENT_ID_ENABLE */
        switch (event_type) {
            case RACE_EVENT_TYPE_CONN_BLE_CONNECT:
            case RACE_EVENT_TYPE_CONN_BLE_1_CONNECT:
            case RACE_EVENT_TYPE_CONN_BLE_2_CONNECT:
            case RACE_EVENT_TYPE_CONN_SPP_CONNECT:
            case RACE_EVENT_TYPE_CONN_IAP2_CONNECT: {
                ui_shell_send_event(false,
                                    EVENT_PRIORITY_MIDDLE,
                                    EVENT_GROUP_UI_SHELL_HEAR_THROUGH,
                                    APP_HEAR_THROUGH_EVENT_ID_RACE_CONNECTED,
                                    NULL,
                                    0,
                                    NULL,
                                    0);
            }
            break;

            case RACE_EVENT_TYPE_CONN_BLE_DISCONNECT:
            case RACE_EVENT_TYPE_CONN_BLE_1_DISCONNECT:
            case RACE_EVENT_TYPE_CONN_BLE_2_DISCONNECT:
            case RACE_EVENT_TYPE_CONN_SPP_DISCONNECT:
            case RACE_EVENT_TYPE_CONN_IAP2_DISCONNECT: {
                ui_shell_send_event(false,
                                    EVENT_PRIORITY_MIDDLE,
                                    EVENT_GROUP_UI_SHELL_HEAR_THROUGH,
                                    APP_HEAR_THROUGH_EVENT_ID_RACE_DISCONNECTED,
                                    NULL,
                                    0,
                                    NULL,
                                    0);
            }
            break;
        }
#ifdef MTK_RACE_EVENT_ID_ENABLE
    }
#endif /* MTK_RACE_EVENT_ID_ENABLE */
    return RACE_ERRCODE_SUCCESS;
}

void app_hear_through_activity_init_race_handler()
{
    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_init_race_handler] Init race event handler", 0);
#ifdef MTK_RACE_EVENT_ID_ENABLE
    race_event_register(&(app_hear_through_ctx.race_register_id), app_hear_through_activity_race_event_handler, NULL);
#else
    race_event_register(app_hear_through_activity_race_event_handler, NULL);
#endif /* MTK_RACE_EVENT_ID_ENABLE */
}
#endif /* MTK_RACE_CMD_ENABLE */

static void app_hear_through_control_callback(llf_type_t type, llf_control_event_t event, llf_status_t result)
{
    if (app_hear_through_ctx.init_done == false) {
        APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_control_callback] Not init_done", 0);
        return;
    }

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_control_callback] event : %d, type : %d, result : %d, is_hear_through_enabled : %d, trigger_from_key : %d",
                        5,
                        event,
                        type,
                        result,
                        app_hear_through_ctx.is_hear_through_enabled,
                        app_hear_through_ctx.trigger_from_key);

    if (app_hear_through_ctx.is_powering_off == true) {
        APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_control_callback] powering off, ignore: %d", 0);
        return;
    }

    if ((result == LLF_STATUS_SUCCESS)
        && ((event == LLF_CONTROL_EVENT_ON) || (event == LLF_CONTROL_EVENT_OFF))) {

#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
        if (type ==  LLF_TYPE_HEARING_AID) {
            if (event ==  LLF_CONTROL_EVENT_ON) {
                app_hearing_aid_activity_set_open_fwk_done(true);
                app_hearing_aid_activity_enable_hearing_aid(app_hear_through_ctx.trigger_from_key);

                app_hear_through_ctx.trigger_from_key = false;
            }
            if (event == LLF_CONTROL_EVENT_OFF) {
                app_hearing_aid_activity_set_open_fwk_done(false);

                app_hear_through_proc_hearing_aid_event(APP_HEARING_AID_EVENT_ID_HA_OFF, NULL, 0);
            }
            return;
        }
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */

        if ((app_hear_through_ctx.is_hear_through_enabled == false)
            && (event == LLF_CONTROL_EVENT_ON)
            && (type == LLF_TYPE_VIVID_PT)) {
            app_hear_through_init_anc();
        }

        if (type == LLF_TYPE_VIVID_PT) {
            app_hear_through_ctx.is_hear_through_enabled = ((event == LLF_CONTROL_EVENT_ON) ? true : false);

            app_hear_through_handle_anc();
        }
    }

    if (result == LLF_STATUS_FAIL) {
#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
        if ((type == LLF_TYPE_HEARING_AID) && (event == LLF_CONTROL_EVENT_ON)) {
            app_hearing_aid_activity_set_open_fwk_done(false);
        }
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */
    }
}

static void app_hear_through_activity_initialization()
{
    if (app_hear_through_ctx.init_done == false) {
        APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_initialization] Enter", 0);

        memset(&app_hear_through_ctx, 0, sizeof(app_hear_through_context_t));

        app_hear_through_ctx.trigger_from_key = true;

        app_hear_through_storage_load_const_configuration();
        app_hear_through_storage_load_user_configuration();

        llf_control_register_callback((llf_control_callback_t)app_hear_through_control_callback,
                                                LLF_CONTROL_EVENT_ON | LLF_CONTROL_EVENT_OFF,
                                                LLF_MAX_CALLBACK_LEVEL_ALL);

#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
        app_hear_through_ctx.is_charger_in = true; //!is_out_case;
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */

#ifdef MTK_RACE_CMD_ENABLE
        app_hear_through_activity_init_race_handler();
#endif /* MTK_RACE_CMD_ENABLE */

        app_hear_through_adv_init();

        app_hear_through_ctx.init_done = true;
        app_hear_through_ctx.old_anc_target_type = AUDIO_ANC_CONTROL_TYPE_DUMMY;

        app_hear_through_update_ambient_control_mode();

#ifdef MTK_AWS_MCE_ENABLE
        if (app_hear_through_is_aws_connected() == true) {
            bt_aws_mce_role_t aws_role = bt_device_manager_aws_local_info_get_role();
            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_initialization] Role : 0x%02x", 1, aws_role);
            if (aws_role == BT_AWS_MCE_ROLE_AGENT) {
                app_hear_through_mode_t hear_through_mode = app_hear_through_storage_get_hear_through_mode();
                bool hear_through_switch = app_hear_through_storage_get_hear_through_switch();

                app_hear_through_send_configuration(false, false, hear_through_switch, hear_through_mode);
            } else if (aws_role == BT_AWS_MCE_ROLE_PARTNER) {
                app_hear_through_send_sync_event(false,
                                                    APP_HEAR_THROUGH_AWS_EVENT_ID_SYNC_REQUEST,
                                                    NULL,
                                                    0,
                                                    0);
            }
        }
#endif /* MTK_AWS_MCE_ENABLE */
    }
}

static void app_hear_through_activity_de_initialization()
{
    if (app_hear_through_ctx.init_done == true) {

        APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_de_initialization] Enter", 0);

        llf_control_register_callback(NULL,
                                        LLF_CONTROL_EVENT_ON | LLF_CONTROL_EVENT_OFF,
                                        LLF_MAX_CALLBACK_LEVEL_ALL);
#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
        bool is_charger_in = app_hear_through_ctx.is_charger_in;
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */

        memset(&app_hear_through_ctx, 0, sizeof(app_hear_through_context_t));

        app_hear_through_ctx.old_anc_target_type = AUDIO_ANC_CONTROL_TYPE_DUMMY;

#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
        app_hear_through_ctx.is_charger_in = is_charger_in;
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */
    }
}

bool app_hear_through_proc_ui_shell_system_event(int32_t event_id, void *extra_data, size_t data_len)
{
    if (event_id == EVENT_ID_SHELL_SYSTEM_ON_CREATE) {

        // bool is_out_case = app_hear_through_activity_is_out_case();
        // APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_ui_shell_system_event] Activity create, out_case : %d",
        //                     1,
        //                     is_out_case);

        app_hear_through_activity_initialization();
    }

    if (event_id == EVENT_ID_SHELL_SYSTEM_ON_DESTROY) {
        APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_ui_shell_system_event] Activity Destroy", 0);

        app_hear_through_activity_de_initialization();
    }
    return true;
}

/**
 * @brief Process connection manager event.
 * If a2dp connected, need start Hear through advertising.
 *
 * @param event_id
 * @param extra_data
 * @param data_len
 * @return true
 * @return false
 */
static bool app_hear_through_activity_proc_cm_event(uint32_t event_id,
                                                    void *extra_data,
                                                    size_t data_len)
{
    if (event_id == BT_CM_EVENT_REMOTE_INFO_UPDATE) {
        bt_cm_remote_info_update_ind_t *remote_update = (bt_cm_remote_info_update_ind_t *)extra_data;

        if (remote_update->pre_connected_service == remote_update->connected_service) {
            return false;
        }

        if (!(BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_A2DP_SINK) & remote_update->pre_connected_service)
            && (BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_A2DP_SINK) & remote_update->connected_service)) {
            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_proc_cm_event] A2DP connected", 0);
            app_hear_through_adv_set_connected_remote_address(&(remote_update->address));
            app_hear_through_adv_start();
        }

#ifdef MTK_AWS_MCE_ENABLE

        if (app_hear_through_ctx.init_done == false) {
            APPS_LOG_MSGID_E(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_cm_event] Hear through not init done", 0);
            return false;
        }

        bt_aws_mce_role_t device_aws_role = bt_device_manager_aws_local_info_get_role();
        if (!(BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & remote_update->pre_connected_service)
            && (BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & remote_update->connected_service)) {
            // AWS connected handler
            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_cm_event] AWS Connected, Role : 0x%02x", 1, device_aws_role);

            if (device_aws_role == BT_AWS_MCE_ROLE_AGENT) {
                app_hear_through_mode_t hear_through_mode = app_hear_through_storage_get_hear_through_mode();
                bool hear_through_switch = app_hear_through_storage_get_hear_through_switch();

                app_hear_through_send_configuration(false, false, hear_through_switch, hear_through_mode);
            }
        } else if (!(BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & remote_update->connected_service)
                   && (BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & remote_update->pre_connected_service)) {
            // AWS disconnected handler
            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_cm_event] AWS Disconnected", 0);
        }
#endif /* MTK_AWS_MCE_ENABLE */
    }
    return false;
}

static void app_hear_through_activity_proc_race_cmd(void *extra_data, size_t data_len)
{
    if ((extra_data == NULL) || (data_len == 0)) {
        APPS_LOG_MSGID_E(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_proc_race_cmd] extra data is NULL", 0);
        return;
    }

    app_hear_through_request_t *request = (app_hear_through_request_t *)extra_data;

    /**
     * @brief Handle Hearing Aid RACE CMD
     */
    if (request->op_type < APP_HEARING_AID_CONFIG_TYPE_MAXIMUM) {
#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
        app_hearing_aid_activity_process_race_cmd(extra_data, data_len);
#else
        APPS_LOG_MSGID_E(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_proc_race_cmd] Not enable AIR_HEARING_AID_ENABLE feature option", 0);
        if (request->op_code == APP_HEAR_THROUGH_CMD_OP_CODE_GET) {
            app_hear_through_race_cmd_send_get_response(request->op_type, NULL, 0);
        } else {
            app_hear_through_race_cmd_send_set_response(request->op_type, false);
        }
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */
        return;
    }

    /**
     * @brief Handle Hear Through RACE CMD
     */
    if (request->op_code == APP_HEAR_THROUGH_CMD_OP_CODE_SET) {
        bool ret_value = false;
#ifdef MTK_AWS_MCE_ENABLE
        if (app_hear_through_is_aws_connected() == true) {
            app_hear_through_send_sync_event(true,
                                                request->op_type,
                                                request->op_parameter,
                                                data_len - APP_HEAR_THROUGH_OP_PARAMETER_INDEX,
                                                APP_HEAR_THROUGH_SYNC_EVENT_DEFAULT_TIMEOUT);
            ret_value = true;
        } else {
#endif /* MTK_AWS_MCE_ENABLE */
            ret_value = app_hear_through_activity_handle_set_cmd(request->op_type,
                                                                    request->op_parameter,
                                                                    data_len - APP_HEAR_THROUGH_OP_PARAMETER_INDEX);
#ifdef MTK_AWS_MCE_ENABLE
        }
#endif /* MTK_AWS_MCE_ENABLE */

        APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_proc_race_cmd] Set configure type : 0x%04x, result : %d",
                            2,
                            request->op_type,
                            ret_value);

        app_hear_through_race_cmd_send_set_response(request->op_type, ret_value);

    } else if (request->op_code == APP_HEAR_THROUGH_CMD_OP_CODE_GET) {
        app_hear_through_activity_handle_get_cmd(request->op_type);
    }
}

bool app_hear_through_proc_hear_through_event(int32_t event_id, void *extra_data, size_t data_len)
{
    bool is_out_case = app_hear_through_activity_is_out_case();

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_hear_through_event] event : 0x%04x, out_case : %d",
                        2,
                        event_id,
                        is_out_case);

    switch (event_id) {
        case APP_HEAR_THROUGH_CONFIG_TYPE_SWITCH: {
            app_hear_through_activity_handle_switch_set_cmd(extra_data, data_len);
        }
        break;

        case APP_HEAR_THROUGH_CONFIG_TYPE_MODE: {
            app_hear_through_activity_handle_mode_set_cmd(extra_data, data_len);
        }
        break;

        case APP_VIVID_PT_CONFIG_TYPE_AFC_SWITCH: {
            app_hear_through_activity_handle_afc_set_cmd(extra_data, data_len);
        }
        break;

        case APP_VIVID_PT_CONFIG_TYPE_LDNR_SWITCH: {
            app_hear_through_activity_handle_ldnr_set_cmd(extra_data, data_len);
        }
        break;

        case APP_HEAR_THROUGH_EVENT_ID_RACE_CMD: {
            app_hear_through_activity_proc_race_cmd(extra_data, data_len);
        }
        break;

        case APP_HEAR_THROUGH_AWS_EVENT_ID_SYNC: {
            app_hear_through_sync_configuration_t *configuration = (app_hear_through_sync_configuration_t *)extra_data;

            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_hear_through_event] CONFIGURATION_SYNC event, is_key_event : %d, hear_through_switch : %d, hear_through_mode : %d, ambient_control_index : %d",
                                4,
                                configuration->from_key,
                                configuration->hear_through_switch,
                                configuration->hear_through_mode,
                                configuration->ambient_control_index);

            app_hear_through_ctx.mode_index = configuration->ambient_control_index;

            if ((configuration->hear_through_mode == APP_HEAR_THROUGH_MODE_VIVID_PT)
                || (configuration->hear_through_mode == APP_HEAR_THROUGH_MODE_HA_PSAP)) {

#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
                if (configuration->hear_through_mode == APP_HEAR_THROUGH_MODE_HA_PSAP) {
                    app_hearing_aid_activity_set_user_switch(false, configuration->hear_through_switch);
                } else {
                    app_hearing_aid_activity_set_user_switch(false, false);
                }
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */

                app_hear_through_ctx.trigger_from_key = configuration->from_key;

                app_hear_through_storage_set_hear_through_mode(configuration->hear_through_mode);

                if (is_out_case == true) {
                    app_hear_through_switch_on_off(true, configuration->hear_through_switch);
                }
            }
        }
        break;

        case APP_HEAR_THROUGH_EVENT_ID_POWER_ON_TO_OPERATE_HT: {

            app_hear_through_mode_t hear_through_mode = app_hear_through_storage_get_hear_through_mode();
            bool hear_through_switch = app_hear_through_storage_get_hear_through_switch();

            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_hear_through_event] mode : %d, ht_switch : %d",
                                2,
                                hear_through_mode,
                                hear_through_switch);

#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
            bool sync = false;
            bool enable = false;

#ifdef MTK_AWS_MCE_ENABLE
            if (bt_device_manager_aws_local_info_get_role() == BT_AWS_MCE_ROLE_AGENT) {
                sync = true;
            }
#endif /* MTK_AWS_MCE_ENABLE */

            if (hear_through_mode == APP_HEAR_THROUGH_MODE_HA_PSAP) {
                enable = hear_through_switch;
            } else {
                enable = false;
            }

            app_hearing_aid_activity_set_user_switch(sync, enable);
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */

            app_hear_through_switch_on_off(false, hear_through_switch);
        }
        break;

        case APP_HEAR_THROUGH_EVENT_ID_BLE_ADV_TIMEOUT: {
            app_hear_through_activity_handle_advertising_timeout();
        }
        break;

        case APP_HEAR_THROUGH_EVENT_ID_RACE_CONNECTED: {
            app_hear_through_activity_handle_race_connected();
        }
        break;

        case APP_HEAR_THROUGH_EVENT_ID_RACE_DISCONNECTED: {
            app_hear_through_activity_handle_race_disconnected();
        }
        break;

        case APP_HEAR_THROUGH_SYNC_EVENT_ID_AMBIENT_CONTROL_SWITCH: {
            app_hear_through_sync_ambient_control_switch_t *control_switch = (app_hear_through_sync_ambient_control_switch_t *)extra_data;
            app_hear_through_ctx.mode_index = control_switch->mode_index;

            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_hear_through_event] ambient control, mode_index : %d",
                                1,
                                app_hear_through_ctx.mode_index);

            app_hear_through_activity_handle_ambient_control_switch();
        }
        break;
    }
    return true;
}

static bool app_hear_through_activity_proc_dm_event(uint32_t event_id,
                                                    void *extra_data,
                                                    size_t data_len)
{
    bt_device_manager_power_event_t evt;
    bt_device_manager_power_status_t status;
    bt_event_get_bt_dm_event_and_status(event_id, &evt, &status);

    if ((status == BT_DEVICE_MANAGER_POWER_STATUS_SUCCESS) && (evt == BT_DEVICE_MANAGER_POWER_EVT_STANDBY_COMPLETE)) {

        app_hear_through_ctx.is_powering_off = true;

#if 0
        audio_anc_control_result_t anc_result = audio_anc_control_set_status_into_flash(
                                                    app_hear_through_ctx.info_anc_enabled,
                                                    app_hear_through_ctx.info_anc_filter_id,
                                                    app_hear_through_ctx.info_anc_type,
                                                    app_hear_through_ctx.info_anc_runtime_gain,
                                                    NULL);

        bool suspend_result = app_anc_service_suspend();

        APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_proc_dm_event] BT Powering off, save ANC data, anc_enabled : %d, save_result : %d, suspend_result : %d",
                            3,
                            app_hear_through_ctx.info_anc_enabled,
                            anc_result,
                            suspend_result);
#endif

        // app_hear_through_activity_de_initialization();
        app_hear_through_storage_save_user_configuration();
    }

    return false;
}

#ifdef MTK_AWS_MCE_ENABLE
bool app_hear_through_proc_aws_data_event(int32_t event_id, void *extra_data, size_t data_len)
{
    bt_aws_mce_report_info_t *aws_data_ind = (bt_aws_mce_report_info_t *)extra_data;

    uint32_t extra_event_group;
    uint32_t extra_event_id;

    void *aws_extra_data = NULL;
    uint32_t aws_extra_data_len = 0;

    apps_aws_sync_event_decode_extra(aws_data_ind, &extra_event_group, &extra_event_id, &aws_extra_data, &aws_extra_data_len);

    if (extra_event_group != EVENT_GROUP_UI_SHELL_HEAR_THROUGH) {
        return false;
    }

    if (app_hear_through_ctx.init_done == false) {
        APPS_LOG_MSGID_E(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_aws_data_event] Hear through not init done", 0);
        return true;
    }

    if ((aws_extra_data == NULL) || (aws_extra_data_len == 0)) {
        APPS_LOG_MSGID_E(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_aws_data_event] event_group : 0x%04x, event_id : 0x%04x, extra_data : 0x%04x, extra_data_len : %d",
                         4,
                         extra_event_group,
                         extra_event_id,
                         aws_extra_data,
                         aws_extra_data_len);
        return true;
    }

    bt_aws_mce_role_t role = bt_device_manager_aws_local_info_get_role();

    uint8_t *parameter = (uint8_t *)aws_extra_data;

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_aws_data_event] aws event ID : 0x%04x, role : 0x%04x, parameter0 : %d",
                     3,
                     extra_event_id,
                     role,
                     parameter[0]);

    app_hear_through_aws_operate_command_t *op_cmd = (app_hear_through_aws_operate_command_t *)aws_extra_data;
    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_aws_data_event] bt clock : %d, %d",
                     3,
                     op_cmd->target_clock.nclk,
                     op_cmd->target_clock.nclk_intra,
                     parameter[0]);

    if (role == BT_AWS_MCE_ROLE_PARTNER) {
        if ((extra_event_id == APP_HEAR_THROUGH_CONFIG_TYPE_SWITCH)
            || (extra_event_id == APP_HEAR_THROUGH_CONFIG_TYPE_MODE)
            || (extra_event_id == APP_VIVID_PT_CONFIG_TYPE_AFC_SWITCH)
            || (extra_event_id == APP_VIVID_PT_CONFIG_TYPE_LDNR_SWITCH)) {
            app_hear_through_sync_event_handler_locally(extra_event_id,
                                                        op_cmd->op_data,
                                                        op_cmd->op_data_len,
                                                        &(op_cmd->target_clock),
                                                        op_cmd->delay_ms);
        }
    }

    if ((extra_event_id == APP_HEAR_THROUGH_AWS_EVENT_ID_SYNC)
            || (extra_event_id == APP_HEAR_THROUGH_SYNC_EVENT_ID_AMBIENT_CONTROL_SWITCH)) {
        app_hear_through_sync_event_handler_locally(extra_event_id,
                                                    op_cmd->op_data,
                                                    op_cmd->op_data_len,
                                                    &(op_cmd->target_clock),
                                                    op_cmd->delay_ms);
    }

    if ((extra_event_id == APP_HEAR_THROUGH_AWS_EVENT_ID_SYNC_REQUEST) && (role == BT_AWS_MCE_ROLE_AGENT)) {
        app_hear_through_mode_t hear_through_mode = app_hear_through_storage_get_hear_through_mode();
        bool hear_through_switch = app_hear_through_storage_get_hear_through_switch();

        app_hear_through_send_configuration(false, false, hear_through_switch, hear_through_mode);
    }
    return true;
}
#endif /* MTK_AWS_MCE_ENABLE */

#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
bool app_hear_through_proc_hearing_aid_event(int32_t event_id, void *extra_data, size_t data_len)
{
    if ((event_id == APP_HEARING_AID_EVENT_ID_HA_ON)
        || (event_id == APP_HEARING_AID_EVENT_ID_HA_OFF)) {

        if ((app_hear_through_ctx.is_hear_through_enabled == false)
            && (event_id == APP_HEARING_AID_EVENT_ID_HA_ON)) {
            app_hear_through_init_anc();
            app_hear_through_ctx.is_hear_through_enabled = true;
        }
        if ((app_hear_through_ctx.is_hear_through_enabled == true)
            && (event_id == APP_HEARING_AID_EVENT_ID_HA_OFF)) {
            app_hear_through_ctx.is_hear_through_enabled = false;
        }

        app_hear_through_handle_anc();
    }

    return false;
}
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */

#if 0
bool app_hear_through_proc_smart_charger_case_event(int32_t event_id, void *extra_data, size_t data_len)
{
    if (event_id == SMCHARGER_EVENT_NOTIFY_ACTION) {
        app_smcharger_public_event_para_t *para = (app_smcharger_public_event_para_t *)extra_data;
        if (para->action == SMCHARGER_CHARGER_OUT_ACTION) {
            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_smart_charger_case_event][SmartCharger] Charger out, Turn on hear through", 0);
            app_hear_through_activity_handle_ht_enable(true);
        }
        if (para->action == SMCHARGER_CHARGER_IN_ACTION) {
            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_smart_charger_case_event][SmartCharger] Charger in, Turn on hear through", 0);
            app_hear_through_activity_handle_ht_enable(false);
        }
    }
    return false;
}
#endif /* 0 */

#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
bool app_hear_through_proc_battery_event(int32_t event_id, void *extra_data, size_t data_len)
{
    if (event_id == APPS_EVENTS_BATTERY_CHARGER_EXIST_CHANGE) {
        bool charger_in = (bool)extra_data;
        APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_battery_event], charger_exist change %d->%d, hear_through_enabled : %d",
                         3,
                         app_hear_through_ctx.is_charger_in,
                         charger_in,
                         app_hear_through_ctx.is_hear_through_enabled);

        if ((app_hear_through_ctx.is_charger_in == false) && (charger_in == true)) {
            app_hear_through_ctx.is_charger_in = true;
            app_hear_through_ctx.old_anc_target_type = AUDIO_ANC_CONTROL_TYPE_DUMMY;

            app_hear_through_activity_handle_ht_enable(false);

            // app_hear_through_activity_de_initialization();

            // app_anc_service_suspend();
        }
        if ((app_hear_through_ctx.is_charger_in == true) && (charger_in == false)) {
            app_hear_through_ctx.is_charger_in = false;
            app_hear_through_ctx.trigger_from_key = true;
            app_hear_through_ctx.old_anc_target_type = AUDIO_ANC_CONTROL_TYPE_DUMMY;

            app_hear_through_update_ambient_control_mode();

            // app_hear_through_activity_initialization();

            app_anc_service_resume();

            if (app_hear_through_storage_get_hear_through_switch() == true) {
                app_hear_through_activity_handle_ht_enable(true);
            }
        }
    }
    return false;
}
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */

static bool app_hear_through_proc_key_event(uint32_t event_id,
                                            void *extra_data,
                                            size_t data_len,
                                            bool from_aws)
{
    uint16_t key_action = *(uint16_t *)extra_data;

    if (key_action == KEY_HEAR_THROUGH_TOGGLE) {

        if (app_hear_through_ctx.init_done == false) {
            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_key_event] Not init done", 0);
            return false;
        }

        if (app_hear_through_ctx.mode_index != APP_HEAR_THROUGH_MODE_SWITCH_INDEX_HEAR_THROUGH) {
            APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_key_event] Not Hear through mode", 0);
            return false;
        }

        bool send_switch = false;
        app_hear_through_mode_t hear_through_mode = app_hear_through_storage_get_hear_through_mode();
        bool hear_through_switch = app_hear_through_storage_get_hear_through_switch();

        APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_proc_key_event] running_mode : %d, hear_through_switch : %d, trigger_from_key : %d",
                            3,
                            hear_through_mode,
                            hear_through_switch,
                            app_hear_through_ctx.trigger_from_key);

        app_hear_through_ctx.trigger_from_key = true;

        if (hear_through_switch == true) {
            send_switch = false;
        } else {
            send_switch = true;
        }

#ifdef MTK_AWS_MCE_ENABLE
        if (app_hear_through_is_aws_connected() == true) {
            /**
             * @brief Fix issue that when disable HT, update HA user switch directly
             * to make sure VP will not impact the HA status.
             * For enable case, need execute the HT at the same time in future to make
             * sure the L and R work at the same time.
             */
#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
            if ((hear_through_mode == APP_HEAR_THROUGH_MODE_HA_PSAP) && (send_switch == false)) {
                app_hearing_aid_activity_set_user_switch(false, false);
            }
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */
            app_hear_through_send_configuration(true, true, send_switch, hear_through_mode);
        } else {
#endif /* MTK_AWS_MCE_ENABLE */

#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
        if (hear_through_mode == APP_HEAR_THROUGH_MODE_HA_PSAP) {
            app_hearing_aid_activity_set_user_switch(false, send_switch);
        }
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */

            app_hear_through_switch_on_off(true, send_switch);
#ifdef MTK_AWS_MCE_ENABLE
        }
#endif /* MTK_AWS_MCE_ENABLE */

        return true;
    }
    return false;
}

bool app_hear_through_activity_proc(ui_shell_activity_t *self,
                                    uint32_t event_group,
                                    uint32_t event_id,
                                    void *extra_data,
                                    size_t data_len)
{
    switch (event_group) {
        case EVENT_GROUP_UI_SHELL_SYSTEM: {
            return app_hear_through_proc_ui_shell_system_event(event_id, extra_data, data_len);
        }
        break;

        case EVENT_GROUP_UI_SHELL_HEAR_THROUGH: {
            return app_hear_through_proc_hear_through_event(event_id, extra_data, data_len);
        }
        break;

        case EVENT_GROUP_UI_SHELL_BT_CONN_MANAGER: {
            return app_hear_through_activity_proc_cm_event(event_id, extra_data, data_len);
        }
        break;

#ifdef MTK_AWS_MCE_ENABLE
        case EVENT_GROUP_UI_SHELL_AWS_DATA: {
            return app_hear_through_proc_aws_data_event(event_id, extra_data, data_len);
        }
        break;
#endif /* MTK_AWS_MCE_ENABLE */

#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)
        case EVENT_GROUP_UI_SHELL_HEARING_AID: {
            return app_hear_through_proc_hearing_aid_event(event_id, extra_data, data_len);
        }
        break;
#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */

#if 0
        case EVENT_GROUP_UI_SHELL_CHARGER_CASE: {
            app_hear_through_proc_smart_charger_case_event(event_id, extra_data, data_len);
        }
        break;
#endif /* 0 */

#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
        case EVENT_GROUP_UI_SHELL_BATTERY: {
            app_hear_through_proc_battery_event(event_id, extra_data, data_len);
        }
        break;
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */

        case EVENT_GROUP_UI_SHELL_BT_DEVICE_MANAGER: {
            app_hear_through_activity_proc_dm_event(event_id, extra_data, data_len);
        }
        break;

        case EVENT_GROUP_UI_SHELL_KEY:{
            return app_hear_through_proc_key_event(event_id, extra_data, data_len, false);
        }
        break;
    }

    return false;
}

static bool app_hear_through_activity_is_out_case()
{
#if 0
    app_smcharger_in_out_t in_out = app_smcharger_is_charging();
    // APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_is_out_case][SmartCharger] Charging : %d", 1, in_out);
    if (in_out != APP_SMCHARGER_OUT) {
        return false;
    }
#endif /* 0 */
#if 0
#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
    int32_t charging = battery_management_get_battery_property(BATTERY_PROPERTY_CHARGER_EXIST);
    // APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_is_out_case][Non-SmartCharger] Charging : %d", 1, charging);
    if (charging != 0) {
        return false;
    }
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */
    return true;
#endif /* 0 */
#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
    return (app_hear_through_ctx.is_charger_in == true) ? false : true;
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */
    return false;
}

void app_hear_through_activity_switch_ambient_control()
{
    uint8_t old_mode_index = app_hear_through_ctx.mode_index;
    app_hear_through_ctx.mode_index ++;
    if (app_hear_through_ctx.mode_index == 3) {
        app_hear_through_ctx.mode_index = 0;
    }

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_ACT_TAG"[app_hear_through_activity_switch_ambient_control] mode_index change %d -> %d",
                        2,
                        old_mode_index,
                        app_hear_through_ctx.mode_index);

#ifdef MTK_AWS_MCE_ENABLE
    if (app_hear_through_is_aws_connected() == true) {
        app_hear_through_sync_ambient_control_switch_t mode_switch;
        mode_switch.mode_index = app_hear_through_ctx.mode_index;

        app_hear_through_send_sync_event(true,
                                            APP_HEAR_THROUGH_SYNC_EVENT_ID_AMBIENT_CONTROL_SWITCH,
                                            (uint8_t *)&mode_switch,
                                            sizeof(app_hear_through_sync_ambient_control_switch_t),
                                            APP_HEAR_THROUGH_SYNC_EVENT_DEFAULT_TIMEOUT);
    } else {
#endif /* MTK_AWS_MCE_ENABLE */
        app_hear_through_activity_handle_ambient_control_switch();
#ifdef MTK_AWS_MCE_ENABLE
    }
#endif /* MTK_AWS_MCE_ENABLE */
}

#endif /* AIR_HEARTHROUGH_MAIN_ENABLE */
