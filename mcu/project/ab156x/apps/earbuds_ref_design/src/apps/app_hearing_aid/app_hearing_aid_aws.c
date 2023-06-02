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

#include "app_hearing_aid_aws.h"
#include "app_hearing_aid_utils.h"
#include "app_hearing_aid_config.h"
#include "app_hearing_aid_activity.h"
#include "nvkey.h"
#include "nvkey_id_list.h"
#include "apps_debug.h"
#include "FreeRTOS.h"
#include "bt_device_manager.h"
#include "bt_connection_manager.h"
#include "apps_aws_sync_event.h"
#include "apps_events_event_group.h"
#include "app_hear_through_race_cmd_handler.h"
#include "ui_shell_manager.h"
#include "apps_events_interaction_event.h"
#include "bt_system.h"
#include "hal_platform.h"
#include "hal_gpt.h"
#ifdef MTK_AWS_MCE_ENABLE
#include "bt_aws_mce_srv.h"
#endif /* MTK_AWS_MCE_ENABLE */

#if (defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)) && defined(MTK_AWS_MCE_ENABLE)

#define APP_HA_AWS_TAG        "[HearingAid][AWS]"

#define APP_HA_AWS_COMMAND_LENGTH           sizeof(uint8_t)

typedef struct {
    uint8_t             op_code;
    uint8_t             from_which_role;
    bool                need_sync_operate;
    bt_clock_t          target_clock;
    uint32_t            delay_ms;
    uint16_t            op_data_len;
    uint8_t             op_data[0];
} __attribute__((packed)) app_hearing_aid_aws_operate_command_t;

typedef struct {
    uint8_t             notify_role;
    uint32_t            notify_code;
    uint16_t            notify_data_len;
    uint8_t             notify_data[0];
} __attribute__((packed)) app_hearing_aid_aws_notification_t;

typedef struct {
    bool                is_vp_streaming;
    uint8_t             *configuration_parameter;
    uint32_t            configuration_parameter_len;
} app_hearing_aid_aws_configuration_sync_info_t;

app_hearing_aid_aws_configuration_sync_info_t app_ha_aws_config = {
    .is_vp_streaming = false,
    .configuration_parameter = NULL,
    .configuration_parameter_len = 0,
};

#if 0
// Move to hearing aid activity to handle
bool g_feedback_detection_from_aws = false;

static void app_hearing_aid_aws_send_race_cmd_response(uint8_t *request, uint32_t request_len, uint8_t *response, uint16_t response_len)
{
    if ((request == NULL) || (request_len == 0)) {
        return;
    }

    /**
     * @brief Handle aws cmd execute response from partner side.
     */

    uint32_t send_len = request_len + response_len + APP_HA_AWS_COMMAND_LENGTH;
    uint8_t *send_buf = (uint8_t *)pvPortMalloc(send_len);
    uint32_t index = 0;

    if (send_buf == NULL) {
        APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_send_race_cmd_response] failed to allocate buffer", 0);
        return;
    }

    memset(send_buf, 0, send_len);

    send_buf[0] = request_len;
    index += APP_HA_AWS_COMMAND_LENGTH;

    memcpy(send_buf + index, request, request_len);
    index += request_len;

    if ((response != NULL) && (response_len > 0)) {
        memcpy(send_buf + index, response, response_len);
        index += response_len;
    }

    bt_status_t status = apps_aws_sync_event_send_extra(EVENT_GROUP_UI_SHELL_HEARING_AID,
                                                        APP_HEARING_AID_EVENT_ID_AWS_RACE_CMD_RESPONSE,
                                                        send_buf,
                                                        send_len);

    vPortFree(send_buf);
    send_buf = NULL;

    if (BT_STATUS_SUCCESS != status) {
        APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_send_race_cmd_response] Send to GET response to agent failed", 0);
    }
}
#endif /* 0 */

/**
 * @brief Partner side handle the received nvkey configuration from agent side.
 *
 * @param data
 * @param data_len
 */
static void app_hearing_aid_aws_handle_agent_configuration_sync(uint8_t *data, uint32_t data_len)
{
    if ((data == NULL) || (data_len == 0)) {
        return;
    }

    if (bt_device_manager_aws_local_info_get_role() != BT_AWS_MCE_ROLE_PARTNER) {
        return;
    }

#if 0
    /**
     * @brief Handle the nvkey sync from agent side.
     */
    nvkey_status_t status = nvkey_write_data(NVID_DSP_ALG_HA_CUS_SETTING, data, data_len);
    APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_agent_configuration_sync] Write nvkey result : %d, length : %d",
                     2,
                     status,
                     data_len);

    if (status == NVKEY_STATUS_OK) {
        app_hearing_aid_utils_reload_configuration();
    }
#endif

    APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_agent_configuration_sync] is_vp_streaming : %d, agent configuration length : %d",
                     2,
                     app_ha_aws_config.is_vp_streaming,
                     data_len);

    if (app_ha_aws_config.is_vp_streaming == true) {
        /**
         * @brief If VP is streaming, Do not reload configuration directly
         * When VP play finished, then reload configuration.
         */
        if (app_ha_aws_config.configuration_parameter != NULL) {
            vPortFree(app_ha_aws_config.configuration_parameter);
            app_ha_aws_config.configuration_parameter = NULL;
        }

        app_ha_aws_config.configuration_parameter_len = data_len;

        app_ha_aws_config.configuration_parameter = (uint8_t *)pvPortMalloc(sizeof(uint8_t) * data_len);
        if (app_ha_aws_config.configuration_parameter == NULL) {
            APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_agent_configuration_sync] Failed to allocate buffer for agent configuration : %d",
                             1,
                             data_len);
            return;
        }

        memset(app_ha_aws_config.configuration_parameter, 0, sizeof(uint8_t) * data_len);
        app_ha_aws_config.configuration_parameter_len = data_len;
        memcpy(app_ha_aws_config.configuration_parameter, data, data_len);
    } else {
        audio_psap_control_set_runtime_sync_parameter(data_len, data);
        app_hearing_aid_utils_reload_configuration();
    }
}

#if 0
// Move to hearing aid activity to handle
static void app_hearing_aid_aws_handle_race_cmd_request(uint8_t *data, uint32_t data_len)
{
    /**
     * @brief Handle the race cmd from agent side.
     */

    if (data == NULL || data_len == 0) {
        return;
    }

    bt_aws_mce_role_t current_role = bt_device_manager_aws_local_info_get_role();
    app_hear_through_request_t *request = (app_hear_through_request_t *)data;
    uint8_t execute_where = APP_HEARING_AID_EXECUTE_NONE;

    uint8_t get_response[APP_HEARING_AID_RESPONSE_MAX_LEN] = {0};
    uint16_t get_response_len = 0;
    bool set_result = false;

    execute_where = app_hearing_aid_config_get_where_to_execute(request->op_code, request->op_type);
    if (execute_where == APP_HEARING_AID_EXECUTE_NONE) {
        return;
    }

    if (current_role != BT_AWS_MCE_ROLE_PARTNER) {
        return;
    }

    if (request->op_code == APP_HEAR_THROUGH_CMD_OP_CODE_GET) {
        app_hearing_aid_utils_handle_get_race_cmd(request, get_response, &get_response_len);

        if (request->op_type == APP_HEARING_AID_CONFIG_TYPE_FEEDBACK_DETECTION) {
            audio_psap_device_role_t role = app_hearing_aid_utils_get_role();
            uint8_t channel = request->op_parameter[0];
            bool l_enable = channel >> 0;
            bool r_enable = channel >> 1;

            APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_race_cmd_request] FEEDBACK_DETECTION, channel : 0x%02x, role : %d, l_enable : %d, r_enable : %d",
                             4,
                             channel,
                             role,
                             l_enable,
                             r_enable);

            if (((role == AUDIO_PSAP_DEVICE_ROLE_LEFT) && (l_enable == true))
                || ((role == AUDIO_PSAP_DEVICE_ROLE_RIGHT) && (r_enable == true))) {
                g_feedback_detection_from_aws = true;
            }
        }

        APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_race_cmd_request] GET type : %s, get length : %d",
                         2, app_hearing_aid_type_string[request->op_type], get_response_len);

        app_hearing_aid_aws_send_race_cmd_response(data, data_len, get_response, get_response_len);
    } else if (request->op_code == APP_HEAR_THROUGH_CMD_OP_CODE_SET) {
        app_hearing_aid_utils_handle_set_race_cmd(request, &set_result);

        APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_race_cmd_request] SET type : %s, set result : %d",
                         2, app_hearing_aid_type_string[request->op_type], set_result);

        app_hearing_aid_aws_send_race_cmd_response(data, data_len, (uint8_t *)&set_result, sizeof(bool));
    }
}


static void app_hearing_aid_aws_send_get_response(uint16_t type, uint8_t *local_response, uint16_t local_response_len,
                                                  uint8_t *remote_response, uint16_t remote_response_len)
{
    APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_send_get_response] type : %s, local length : 0x%x - %d, remote length : 0x%x - %d",
                     5,
                     app_hearing_aid_type_string[type],
                     local_response,
                     local_response_len,
                     remote_response,
                     remote_response_len);

    uint8_t response[APP_HEARING_AID_RESPONSE_MAX_LEN] = {0};
    uint16_t response_len = 0;

    app_hearing_aid_utils_handle_get_combine_response(type,
                                                      local_response, local_response_len,
                                                      remote_response, remote_response_len,
                                                      response, &response_len);

    APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_send_get_response] response length : %d",
                     1,
                     response_len);

    if (response_len == 0) {
        app_hear_through_race_cmd_send_get_response(type, NULL, 0);
        return;
    }

    app_hear_through_race_cmd_send_get_response(type, response, response_len);

}
#endif /* 0 */

#if 0
// Move to hearing aid activity to handle
/**
 * @brief Agent side to handle the AWS race cmd response.
 *
 * @param data Response data
 * @param data_len Response data length
 */
static void app_hearing_aid_aws_handle_race_cmd_response(uint8_t *data, uint32_t data_len)
{
    if ((data == NULL) || (data_len == 0)) {
        return;
    }

    bt_aws_mce_role_t current_role = bt_device_manager_aws_local_info_get_role();
    uint8_t cmd_len = data[0];
    uint32_t remote_response_len = data_len - APP_HA_AWS_COMMAND_LENGTH - cmd_len;
    uint8_t *remote_response = data + APP_HA_AWS_COMMAND_LENGTH + cmd_len;
    bool local_set_result = false;
    uint8_t local_get_response[APP_HEARING_AID_RESPONSE_MAX_LEN] = {0};
    uint16_t local_get_response_len = 0;

    app_hear_through_request_t *response = (app_hear_through_request_t *)(data + APP_HA_AWS_COMMAND_LENGTH);

    APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_race_cmd_response] code : %s, type : %s, total_len : %d, cmd_len : %d, response_len : %d",
                     5,
                     app_hearing_aid_command_string[response->op_code],
                     app_hearing_aid_type_string[response->op_type],
                     data_len,
                     cmd_len,
                     remote_response_len);

    if (current_role != BT_AWS_MCE_ROLE_AGENT) {
        return;
    }

    if (remote_response_len == 0) {
        if (response->op_code == APP_HEAR_THROUGH_CMD_OP_CODE_GET) {
            app_hear_through_race_cmd_send_get_response(response->op_type, NULL, 0);
        } else if (response->op_code == APP_HEAR_THROUGH_CMD_OP_CODE_SET) {
            app_hear_through_race_cmd_send_set_response(response->op_type, false);
        }
        return;
    }

    if (response->op_code == APP_HEAR_THROUGH_CMD_OP_CODE_GET) {
        app_hearing_aid_utils_handle_get_race_cmd(response, local_get_response, &local_get_response_len);

        app_hearing_aid_aws_send_get_response(response->op_type,
                                              local_get_response,
                                              local_get_response_len,
                                              remote_response,
                                              remote_response_len);
    } else if (response->op_code == APP_HEAR_THROUGH_CMD_OP_CODE_SET) {
        bool remote_result = remote_response[0];
        APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_race_cmd_response] remote result : %d", 1, remote_result);
        if (remote_result == false) {
            app_hear_through_race_cmd_send_set_response(response->op_type, false);
        } else {
            app_hearing_aid_utils_handle_set_race_cmd(response, &local_set_result);
            app_hear_through_race_cmd_send_set_response(response->op_type, local_set_result);
        }
    }
}
#endif /* 0 */

#if 0
// Move to hearing aid activity to handle
static void app_hearing_aid_aws_handle_control_ha(app_hearing_aid_aws_operate_command_t *command)
{
    if (command->op_data_len == sizeof(app_hearing_aid_aws_sync_operate_ha_t)) {

        app_hearing_aid_aws_sync_operate_ha_t *operate_ha = (app_hearing_aid_aws_sync_operate_ha_t *)(command->op_data);

        app_hearing_aid_activity_operate_ha(operate_ha->from_key,
                                            operate_ha->which,
                                            operate_ha->mix_table_need_execute,
                                            operate_ha->is_origin_on,
                                            operate_ha->mix_table_to_enable,
                                            operate_ha->drc_to_enable);

#if 0
        bool enable = command->op_data[0];
        // app_hearing_aid_utils_control_ha(enable);
        bool open_fwk_done = app_hearing_aid_activity_is_open_fwk_done();
        bool opening_fwk = app_hearing_aid_activity_is_fwk_opening();
        bool is_running = app_hearing_aid_utils_is_ha_running();

        APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_control_ha] enable : %d, is_running : %d, open_fwk_done : %d, opening_fwk : %d",
                         4,
                         enable,
                         is_running,
                         open_fwk_done,
                         opening_fwk);

        if (is_running != enable) {
            if (enable == true) {
                if ((open_fwk_done == false) && (opening_fwk == false)) {
                    app_hearing_aid_activity_open_hearing_aid_fwk();
                }
            } else {
                // app_hearing_aid_activity_disable_hearing_aid();
                app_hearing_aid_utils_control_ha(false);
            }
        }
#endif
    }
}

static void app_hearing_aid_aws_handle_switch_bf(app_hearing_aid_aws_operate_command_t *command)
{
    if (command->op_data_len == sizeof(app_hearing_aid_aws_index_change_t)) {
        app_hearing_aid_aws_index_change_t *change = (app_hearing_aid_aws_index_change_t *)(command->op_data);
        bool enable = change->index;
        app_hearing_aid_utils_beam_forming_switch_toggle(enable);
    }
}

static void app_hearing_aid_aws_handle_switch_aea(app_hearing_aid_aws_operate_command_t *command)
{
    if (command->op_data_len == sizeof(app_hearing_aid_aws_index_change_t)) {
        app_hearing_aid_aws_index_change_t *change = (app_hearing_aid_aws_index_change_t *)(command->op_data);
        bool enable = change->index;
        app_hearing_aid_utils_aea_switch_toggle(enable);
    }
}

static void app_hearing_aid_aws_handle_switch_master_mic_channel(app_hearing_aid_aws_operate_command_t *command)
{
    if (command->op_data_len == sizeof(uint8_t)) {
        uint8_t channel = command->op_data[0];
        app_hearing_aid_utils_master_mic_channel_switch_toggle(channel);
    }
}

static void app_hearing_aid_aws_handle_switch_tuning_mode(app_hearing_aid_aws_operate_command_t *command)
{
    app_hearing_aid_utils_hearing_tuning_mode_toggle(true);
}

static void app_hearing_aid_aws_handle_change_level(app_hearing_aid_aws_operate_command_t *command)
{
    if (command->op_data_len == sizeof(app_hearing_aid_aws_lr_index_change_t)) {
        app_hearing_aid_aws_lr_index_change_t *change = (app_hearing_aid_aws_lr_index_change_t *)command->op_data;
        app_hearing_aid_utils_adjust_level(change->l_index, change->r_index);
    }
}

static void app_hearing_aid_aws_handle_change_volume(app_hearing_aid_aws_operate_command_t *command)
{
    if (command->op_data_len == sizeof(app_hearing_aid_aws_lr_index_change_t)) {
        app_hearing_aid_aws_lr_index_change_t *change = (app_hearing_aid_aws_lr_index_change_t *)command->op_data;
        app_hearing_aid_utils_adjust_volume(change->l_index, change->r_index);
    }
}

static void app_hearing_aid_aws_handle_change_mode(app_hearing_aid_aws_operate_command_t *command)
{
    if (command->op_data_len == sizeof(app_hearing_aid_aws_index_change_t)) {
        app_hearing_aid_aws_index_change_t *change = (app_hearing_aid_aws_index_change_t *)(command->op_data);
        uint8_t target_mode = change->index;

        bool result = app_hearing_aid_utils_adjust_mode(target_mode);
        APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_change_mode] Set target mode : %d, result : %d",
                         2,
                         target_mode,
                         result);
    }
}

static void app_hearing_aid_aws_handle_modify_mode_index_req(app_hearing_aid_aws_operate_command_t *command)
{
    if (command->op_data_len == sizeof(uint8_t)) {
        uint8_t target_mode = command->op_data[0];
        bool result = app_hearing_aid_utils_set_mode_index(&target_mode);
        APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_modify_mode_index_req] Set target mode : %d, result : %d",
                         2,
                         target_mode,
                         result);
    }
}

static void app_hearing_aid_aws_handle_user_switch(app_hearing_aid_aws_operate_command_t *command)
{
    if (command->op_data_len == sizeof(uint8_t)) {
        bool enable = command->op_data[0];
        APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_user_switch] command switch : %d",
                            1,
                            enable);
        app_hearing_aid_utils_set_user_switch(enable);

        app_hearing_aid_activity_pre_proc_operate_ha(APP_HEARING_AID_CHANGE_CAUSE_REMOTE_USER_SWITCH, enable, false);
    }
}


static void app_hearing_aid_aws_handle_sync_vp_play(app_hearing_aid_aws_operate_command_t *command)
{
    if (command->op_data_len == sizeof(app_hearing_aid_aws_sync_vp_play_t)) {
        app_hearing_aid_aws_sync_vp_play_t *sync_vp_play = (app_hearing_aid_aws_sync_vp_play_t *)command->op_data;
        uint8_t vp_index = sync_vp_play->vp_index;

        APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_sync_vp_play] sync_vp_to_play : %d",
                         1,
                         vp_index);

        app_hearing_aid_activity_play_vp(vp_index, true);
    }
}

static void app_hearing_aid_aws_handle_power_off_request(app_hearing_aid_aws_operate_command_t *command)
{
    APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_power_off_request] Received power off request", 0);

    app_hearing_aid_activity_set_powering_off();

    ui_shell_send_event(false,
                        EVENT_PRIORITY_HIGHEST,
                        EVENT_GROUP_UI_SHELL_APP_INTERACTION,
                        APPS_EVENTS_INTERACTION_REQUEST_POWER_OFF,
                        NULL,
                        0,
                        NULL,
                        0);
}
#endif /* 0 */

static void app_hearing_aid_aws_handle_sync_cmd_locally(uint8_t from_which_role,
                                                        uint8_t code,
                                                        uint8_t *buf,
                                                        uint16_t buf_len,
                                                        bt_clock_t *target_clock,
                                                        uint32_t delay_ms)
{
    uint32_t target_gpt = 0;
    uint32_t cur_gpt = 0;

    bt_status_t bt_clk_to_gpt_result = BT_STATUS_SUCCESS;

    APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_sync_cmd_locally] from_which_role : 0x%02x, code : 0x%02x, buf_len : %d, delay_ms : %d",
                        4,
                        from_which_role,
                        code,
                        buf_len,
                        delay_ms);

    if (target_clock != NULL) {
        if ((target_clock->nclk != 0) || (target_clock->nclk_intra != 0)) {
            bt_sink_srv_convert_bt_clock_2_gpt_count((const bt_clock_t *)target_clock, &target_gpt);
            hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &cur_gpt);
        }
        APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_sync_cmd_locally] target clock : %d, %d, target_gpt : %d, cur_gpt : %d",
                            4,
                            target_clock->nclk,
                            target_clock->nclk_intra,
                            cur_gpt,
                            target_gpt);
    }

    if (bt_clk_to_gpt_result != BT_STATUS_SUCCESS) {
        APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_sync_cmd_locally] Failed to calculate bt clock to GPT count with result : 0x%04x",
                            1,
                            bt_clk_to_gpt_result);
        target_gpt = 0;
    }

    if (target_gpt != 0 && (target_gpt < cur_gpt || (target_gpt - cur_gpt) > delay_ms * 1000)) {
        APPS_LOG_MSGID_W(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_sync_cmd_locally] Reset target gpt to be 0", 0);
        target_gpt = 0;
    }

    uint32_t actual_delay_ms = 0;
    if (target_gpt != 0) {
        actual_delay_ms = (target_gpt - cur_gpt) / 1000;
    }

    APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_sync_cmd_locally] actual_delay_ms : %d",
                        1,
                        actual_delay_ms);

    /**
     * @brief Append the role at the 1st byte to identify the command from agent or partner.
     */
    uint8_t *send_buf = NULL;
    uint16_t send_buf_len = 1;
    if ((buf != NULL) && (buf_len != 0)) {
        send_buf_len += buf_len;
    }
    send_buf = (uint8_t *)pvPortMalloc(send_buf_len);
    if (send_buf == NULL) {
        APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_sync_cmd_locally] Failed to allocate buffer for ui shell event", 0);
        return;
    }
    if ((buf != NULL) && (buf_len != 0)) {
        memcpy(send_buf + 1, buf, buf_len);
    }
    send_buf[0] = from_which_role;

    ui_shell_send_event(false,
                        EVENT_PRIORITY_HIGHEST,
                        EVENT_GROUP_UI_SHELL_HEARING_AID,
                        (APP_HEARING_AID_EVENT_SYNC_BASE + code),
                        send_buf,
                        send_buf_len,
                        NULL,
                        actual_delay_ms);
}


typedef void (*aws_operate_handler)(app_hearing_aid_aws_operate_command_t *command);

const aws_operate_handler aws_handler_list[] = {
    NULL,                                                       // 0x00
    NULL, // app_hearing_aid_aws_handle_control_ha,                      // 0x01
    NULL, // app_hearing_aid_aws_handle_switch_bf,                       // 0x02
    NULL, // app_hearing_aid_aws_handle_switch_aea,                      // 0x03
    NULL, // app_hearing_aid_aws_handle_switch_master_mic_channel,       // 0x04
    NULL, // app_hearing_aid_aws_handle_switch_tuning_mode,              // 0x05
    NULL, // app_hearing_aid_aws_handle_change_level,                    // 0x06
    NULL, // app_hearing_aid_aws_handle_change_volume,                   // 0x07
    NULL, // app_hearing_aid_aws_handle_change_mode,                     // 0x08
    NULL, // app_hearing_aid_aws_handle_modify_mode_index_req,           // 0x09
    NULL, // app_hearing_aid_aws_handle_user_switch,                     // 0x0A
    NULL, // app_hearing_aid_aws_handle_sync_vp_play,                    // 0x0B
    NULL, // app_hearing_aid_aws_handle_power_off_request,               // 0x0C
    NULL,                                                       // 0x0D
    NULL,                                                       // 0x0E
};

ATTR_LOG_STRING_LIB app_hearing_aid_aws_code_string[][APP_HEARING_AID_CHAR_LOG_MAX_LEN] = {
    "NONE",                             // 0x00
    "CONTROL_HA",                       // 0x01
    "SWITCH_BF",                        // 0x02
    "SWITCH_AEA_CONFIGURE",             // 0x03
    "SWITCH_MASTER_MIC_CHANNEL",        // 0x04
    "SWITCH_TUNING_MODE",               // 0x05
    "CHANGE_LEVEL",                     // 0x06
    "CHANGE_VOLUME",                    // 0x07
    "CHANGE_MODE",                      // 0x08
    "MODIFY_MODE_REQ",                  // 0x09
    "SET_USER_SWITCH",                  // 0x0A
    "SYNC_VP_PLAY",                     // 0x0B
    "REQUEST_POWER_OFF",                // 0x0C
    "RACE_CMD_REQUEST",                 // 0x0D
    "RACE_CMD_RESPONSE"                 // 0x0E
};

static void app_hearing_aid_aws_handle_operate(uint8_t *data, uint32_t data_len)
{
    if ((data == NULL) || (data_len < sizeof(app_hearing_aid_aws_operate_command_t))) {
        return;
    }

    app_hearing_aid_aws_operate_command_t *command = (app_hearing_aid_aws_operate_command_t *)data;

    APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_operate] Op command : 0x%02x (%s), data : 0x%x, data_len : %d",
                        4,
                        command->op_code,
                        app_hearing_aid_aws_code_string[command->op_code],
                        command->op_data,
                        command->op_data_len);

    APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_operate] need_sync_operate : %d, target_bt_clk : %d - %d, delay_ms : %d",
                        4,
                        command->need_sync_operate,
                        command->target_clock.nclk,
                        command->target_clock.nclk_intra,
                        command->delay_ms);

    // if (command->need_sync_operate == true) {
        app_hearing_aid_aws_handle_sync_cmd_locally(command->from_which_role,
                                                    command->op_code,
                                                    command->op_data,
                                                    command->op_data_len,
                                                    &(command->target_clock),
                                                    command->delay_ms);
    // } else {
        // if (aws_handler_list[command->op_code] != NULL) {
        //     aws_handler_list[command->op_code](command);
        // }
    // }
}

extern void app_hearing_aid_activity_ha_utils_notify_handler(uint8_t role, uint32_t type, uint8_t *notify_data, uint16_t notify_data_len);

static void app_hearing_aid_aws_handle_notification(uint8_t *data, uint32_t data_len)
{
    APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_handle_notification] data : 0x%x, data_len : %d",
                     2,
                     data,
                     data_len);
    if ((data == NULL) || (data_len < sizeof(app_hearing_aid_aws_notification_t))) {
        return;
    }

    app_hearing_aid_aws_notification_t *notification = (app_hearing_aid_aws_notification_t *)data;
    app_hearing_aid_activity_ha_utils_notify_handler(notification->notify_role,
                                                     notification->notify_code,
                                                     notification->notify_data,
                                                     notification->notify_data_len);
}



/**
 * @brief The AWS data handler
 *
 */
typedef void (*hearing_aid_aws_data_handler)(uint8_t *data, uint32_t data_len);

/**
 * @brief The AWS data handler table.
 *
 */
static const hearing_aid_aws_data_handler aws_data_handler_list[] = {
    app_hearing_aid_aws_handle_agent_configuration_sync,
    NULL, // app_hearing_aid_aws_handle_race_cmd_request,
    NULL, // app_hearing_aid_aws_handle_race_cmd_response,
    app_hearing_aid_aws_handle_operate,
    app_hearing_aid_aws_handle_notification,
};

void app_hearing_aid_aws_process_data(uint32_t aws_id, uint8_t *aws_data, uint32_t aws_data_len)
{
    if (aws_data == NULL || aws_data_len == 0) {
        return;
    }

    uint8_t handler_index = aws_id - APP_HEARING_AID_EVENT_ID_AWS_BEGIN;
    if (aws_data_handler_list[handler_index] != NULL) {
        aws_data_handler_list[handler_index](aws_data, aws_data_len);
    }
}

/**
 * @brief Agent side send the stored nvkey configuration to the partner side.
 *
 */
void app_hearing_aid_aws_sync_agent_configuration_to_partner()
{
    /**
     * @brief Send the agent nvkey configuration to partner side.
     */

    if (app_hearing_aid_aws_is_connected() == false) {
        APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_sync_agent_configuration_to_partner] AWS not connected", 0);
        return;
    }

    if (bt_device_manager_aws_local_info_get_role() != BT_AWS_MCE_ROLE_AGENT) {
        APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_sync_agent_configuration_to_partner] Current is not agent role", 0);
        return;
    }

    uint16_t sync_buf_len = 0;
    uint8_t *sync_buf = audio_psap_control_get_runtime_sync_parameter(&sync_buf_len);

    if (sync_buf == NULL || sync_buf_len == 0) {
        APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_sync_agent_configuration_to_partner] get runtime sync parameter error, %d - %d",
                         2,
                         sync_buf,
                         sync_buf_len);
        return;
    }

    bt_status_t status = apps_aws_sync_event_send_extra(EVENT_GROUP_UI_SHELL_HEARING_AID,
                                                        APP_HEARING_AID_EVENT_ID_AWS_SYNC_NVKEY,
                                                        sync_buf,
                                                        sync_buf_len);

    vPortFree(sync_buf);
    sync_buf = NULL;

    if (BT_STATUS_SUCCESS != status) {
        APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_sync_agent_configuration_to_partner] Send to partner failed", 0);
    }
}

bool app_hearing_aid_aws_send_operate_command(uint8_t code,
                                                uint8_t *buf,
                                                uint16_t buf_len,
                                                bool need_sync_operate,
                                                bool need_execute_locally,
                                                uint32_t delay_ms)
{
    if (app_hearing_aid_aws_is_connected() == false) {
        APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_send_operate_command] AWS not connected", 0);
        return false;
    }

    bt_clock_t target_bt_clk = {0};
    bool need_bt_clk_to_start = true;
    bt_aws_mce_role_t aws_role = bt_device_manager_aws_local_info_get_role();
    uint32_t command_len = sizeof(app_hearing_aid_aws_operate_command_t) + buf_len;
    app_hearing_aid_aws_operate_command_t *op_command = (app_hearing_aid_aws_operate_command_t *)pvPortMalloc(command_len);

    if (op_command == NULL) {
        APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_send_operate_command] Failed to allocate operate command buffer", 0);
        if (need_execute_locally == true) {
            app_hearing_aid_aws_handle_sync_cmd_locally(aws_role,
                                                        code,
                                                        buf,
                                                        buf_len,
                                                        &target_bt_clk,
                                                        delay_ms);
        }
        return false;
    }

    APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_send_operate_command] role : 0x%02x, code : 0x%04x, buf_len : %d, need_sync_operate : %d, need_execute_locally : %d, delay_ms : %d",
                        6,
                        aws_role,
                        code,
                        buf_len,
                        need_sync_operate,
                        need_execute_locally,
                        delay_ms);

    if (need_sync_operate == true) {
        bt_status_t get_bt_clock_result = bt_sink_srv_bt_clock_addition(&target_bt_clk, 0, delay_ms * 1000);
        if (get_bt_clock_result != BT_STATUS_SUCCESS) {
            APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_send_operate_command] Get bt clock failed : 0x%04x", 1, get_bt_clock_result);
            need_bt_clk_to_start = false;
            op_command->need_sync_operate = false;
            op_command->target_clock.nclk = 0;
            op_command->target_clock.nclk_intra = 0;
        } else {
            op_command->need_sync_operate = true;
            APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_send_operate_command] target_bt_clk : %d, %d", 2, target_bt_clk.nclk, target_bt_clk.nclk_intra);
            memcpy((void *)(&(op_command->target_clock)), (void *)(&target_bt_clk), sizeof(bt_clock_t));
        }
    } else {
        op_command->need_sync_operate = false;
        op_command->target_clock.nclk = 0;
        op_command->target_clock.nclk_intra = 0;
    }

    op_command->from_which_role = aws_role;
    op_command->op_code = code;
    op_command->op_data_len = buf_len;
    op_command->delay_ms = delay_ms;

    if ((buf_len > 0) && (buf != NULL)) {
        memcpy(op_command->op_data, buf, buf_len);
    }

    bt_status_t status = apps_aws_sync_event_send_extra(EVENT_GROUP_UI_SHELL_HEARING_AID,
                                                        APP_HEARING_AID_EVENT_ID_AWS_OPERATE,
                                                        op_command,
                                                        command_len);

    vPortFree(op_command);
    op_command = NULL;

    if (status != BT_STATUS_SUCCESS) {
        APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_send_operate_command] Failed to send to partner, code : 0x%02x, buf_len : %d, result : 0x%04x",
                         3, code, buf_len, status);
        need_bt_clk_to_start = false;
    }

    // if (need_sync_operate == true) {
    if (need_execute_locally == true) {
        app_hearing_aid_aws_handle_sync_cmd_locally(aws_role,
                                                    code,
                                                    buf,
                                                    buf_len,
                                                    ((need_bt_clk_to_start == true) ? &target_bt_clk : NULL),
                                                    delay_ms);
    }
    // }

    return true;
}

bool app_hearing_aid_aws_send_notification(uint8_t role, uint32_t code, uint8_t *notify_data, uint16_t notify_data_len)
{
    if (app_hearing_aid_aws_is_connected() == false) {
        return false;
    }

    uint32_t allocate_len = sizeof(app_hearing_aid_aws_notification_t) + notify_data_len;
    app_hearing_aid_aws_notification_t *notification = (app_hearing_aid_aws_notification_t *)pvPortMalloc(allocate_len);
    if (notification == NULL) {
        APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_send_notification] [ERROR] Failed to allocate notification buffer", 0);
        return true;
    }
    memset(notification, 0, allocate_len);
    notification->notify_role = role;
    notification->notify_code = code;
    notification->notify_data_len = notify_data_len;
    if ((notify_data_len > 0) && (notify_data != NULL)) {
        memcpy(notification->notify_data, notify_data, notify_data_len);
    }
    bt_status_t status = apps_aws_sync_event_send_extra(EVENT_GROUP_UI_SHELL_HEARING_AID,
                                                        APP_HEARING_AID_EVENT_ID_AWS_NOTIFICATION,
                                                        (void *)notification,
                                                        allocate_len);

    vPortFree(notification);
    notification = NULL;

    if (status != BT_STATUS_SUCCESS) {
        APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_send_notification] [ERROR] Failed to send notification to agent", 0);
        return false;
    }

    return true;
}

#if 0
/* Move the race cmd to the operate handling flow */
bool app_hearing_aid_aws_send_race_request(uint8_t *request, uint32_t request_len)
{
    if (request == NULL || request_len == 0) {
        return false;
    }

    if (app_hearing_aid_aws_is_connected() == false) {
        return false;
    }

    bt_status_t status = apps_aws_sync_event_send_extra(EVENT_GROUP_UI_SHELL_HEARING_AID,
                                                        APP_HEARING_AID_EVENT_ID_AWS_RACE_CMD_REQUEST,
                                                        request,
                                                        request_len);
    if (BT_STATUS_SUCCESS != status) {
        APPS_LOG_MSGID_E(APP_HA_AWS_TAG"[app_hearing_aid_aws_send_race_request] Send to partner failed", 0);
        return false;
    }

    return true;
}
#endif /* 0 */

bool app_hearing_aid_aws_is_connected()
{
    bt_aws_mce_srv_link_type_t link_type = bt_aws_mce_srv_get_link_type();
    if (link_type == BT_AWS_MCE_SRV_LINK_NONE) {
        return false;
    }
    return true;
}

bool app_hearing_aid_aws_set_vp_streaming_state(bool streaming)
{
    /**
     * @brief Fix issue
     * When partner power to reconnect to agent, agent sync the configuration to partner side.
     * partner side will deinitialize and initialize to make the configuration to be enabled, so
     * this will make power-on VP be cut, cannot hear all of the power-on VP.
     *
     */
    if (app_ha_aws_config.is_vp_streaming != streaming) {
        app_ha_aws_config.is_vp_streaming = streaming;

        APPS_LOG_MSGID_I(APP_HA_AWS_TAG"[app_hearing_aid_aws_set_vp_streaming_state] role : 0x%02x, parameter_len : %d, parameter : 0x%x, streaming : %d",
                         4,
                         bt_device_manager_aws_local_info_get_role(),
                         app_ha_aws_config.configuration_parameter_len,
                         app_ha_aws_config.configuration_parameter,
                         streaming);

        if ((app_ha_aws_config.is_vp_streaming == false)
            && (app_ha_aws_config.configuration_parameter_len > 0)
            && (app_ha_aws_config.configuration_parameter != NULL)
            && (bt_device_manager_aws_local_info_get_role() == BT_AWS_MCE_ROLE_PARTNER)) {
            audio_psap_control_set_runtime_sync_parameter(app_ha_aws_config.configuration_parameter_len, app_ha_aws_config.configuration_parameter);
            app_hearing_aid_utils_reload_configuration();

            vPortFree(app_ha_aws_config.configuration_parameter);
            app_ha_aws_config.configuration_parameter = NULL;

            app_ha_aws_config.configuration_parameter_len = 0;
        }
    }

    return true;
}

#if 0
// Move to hearing aid activity to handle
bool app_hearing_aid_aws_is_feedback_detection_from_aws()
{
    return g_feedback_detection_from_aws;
}

void app_hearing_aid_aws_reset_feedback_detection_from_aws()
{
    g_feedback_detection_from_aws = false;
}
#endif /* 0 */

#endif /* (AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE) && MTK_AWS_MCE_ENABLE */

