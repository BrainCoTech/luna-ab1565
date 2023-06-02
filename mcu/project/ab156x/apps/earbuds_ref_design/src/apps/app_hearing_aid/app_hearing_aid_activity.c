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

#include "app_hearing_aid_activity.h"
#include "app_hear_through_race_cmd_handler.h"
#include "app_hearing_aid_utils.h"
#include "app_hearing_aid_config.h"
#include "app_hearing_aid_storage.h"
#include "apps_events_event_group.h"
#include "apps_config_event_list.h"
#include "apps_debug.h"
#include "bt_aws_mce.h"
#include "bt_device_manager.h"
#include "bt_device_manager_power.h"
#include "bt_connection_manager.h"
#include "apps_aws_sync_event.h"
#include "stdlib.h"
#include "race_cmd.h"
#include "race_event.h"
#include "ui_shell_manager.h"
#include "voice_prompt_api.h"
#include "voice_prompt_aws.h"
#include "bt_callback_manager.h"
#include "bt_gap.h"
#include "apps_config_vp_index_list.h"
#include "app_hearing_aid_key_handler.h"
#include "apps_events_interaction_event.h"
#include "apps_events_bt_event.h"
#include "app_hear_through_storage.h"
#ifdef MTK_AWS_MCE_ENABLE
#include "app_hearing_aid_aws.h"
#endif /* MTK_AWS_MCE_ENABLE */
#ifdef MTK_IN_EAR_FEATURE_ENABLE
#include "app_in_ear_utils.h"
#endif /* MTK_IN_EAR_FEATURE_ENABLE */
#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
#include "battery_management.h"
#include "apps_events_battery_event.h"
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */
#ifdef AIR_SMART_CHARGER_ENABLE
#include "app_smcharger.h"
#endif /* AIR_SMART_CHARGER_ENABLE */
#include "app_hear_through_activity.h"

#if defined(AIR_HEARING_AID_ENABLE) || defined(AIR_HEARTHROUGH_PSAP_ENABLE)

#include "audio_psap_control.h"

#define APP_HA_ACTIVITY_TAG        "[HearingAid][ACTIVITY]"


#define APP_HA_RSSI_READ_TIMEOUT                    (5 * 1000) // 1s
#define APP_HA_CONTROL_HEARING_AID_BY_A2DP_TIMEOUT  (3 * 1000) // 3s
#define APP_HA_REQUEST_POWER_OFF_DELAY              (300) // 500ms

/**
 * @brief When power on device, start to play power on VP after HA open framework about the
 * following delay.
 */
#define APP_HA_POWER_ON_VP_DELAY_TIME               50 // 50ms

/*==============================================================================*/
/*                      INTERNAL FUNCTION DECLARATION                           */
/*==============================================================================*/
static void app_hearing_aid_activity_initialization();
static void app_hearing_aid_activity_de_initialization();
// static void app_hearing_aid_activity_handle_race_cmd(void *data, size_t data_len);
static bt_status_t app_hearing_aid_activity_send_rssi_reading_event();
static void app_hearing_aid_activity_remove_ha_event();
static bool app_hearing_aid_activity_proc_app_interaction(uint32_t event_id,
                                                          void *extra_data,
                                                          size_t data_len);
static void app_hearing_aid_activity_handle_get_race_cmd(uint8_t *race_data, uint16_t race_data_len, uint8_t *get_response, uint16_t *get_response_len);
static bool app_hearing_aid_activity_handle_set_race_cmd(uint8_t *race_data, uint16_t race_data_len);

extern uint32_t sub_chip_version_get();

static const uint8_t app_hearing_aid_mode_vp_index_list[] = {
    VP_INDEX_HEARING_AID_MODE_1,
    VP_INDEX_HEARING_AID_MODE_2,
    VP_INDEX_HEARING_AID_MODE_3,
    VP_INDEX_HEARING_AID_MODE_4,
    VP_INDEX_HEARING_AID_MODE_5,
    VP_INDEX_HEARING_AID_MODE_6,
    VP_INDEX_HEARING_AID_MODE_7,
    VP_INDEX_HEARING_AID_MODE_8,
};

typedef struct {
    bool                    inited;
    bool                    power_on_ha_executed;
    bool                    vp_streaming;
    bool                    is_open_fwk_done;
    bool                    is_opening_fwk;
    bool                    is_powering_off;
    bool                    drc_enable;
    int8_t                  partner_rssi;
    uint8_t                 ha_open_caused_by_which_reason;
#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
    bool                    is_charger_in;
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */
#ifdef MTK_IN_EAR_FEATURE_ENABLE
    bool                    is_in_ear;
#endif /* MTK_IN_EAR_FEATURE_ENABLE */
} app_hearing_aid_activity_context_t;

app_hearing_aid_activity_context_t  app_ha_activity_context;

bool app_feedback_detection_directly = false;

bool app_hearing_aid_activity_is_out_case()
{
#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
    return (app_ha_activity_context.is_charger_in == true) ? false : true;
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */
    return false;
}

void app_hearing_aid_activity_play_vp(uint8_t vp_index, bool need_sync)
{
#ifdef MTK_AWS_MCE_ENABLE
    bt_aws_mce_role_t aws_role = bt_device_manager_aws_local_info_get_role();
    bool is_aws_connected = app_hearing_aid_aws_is_connected();

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_play_vp] aws_connected : %d, aws_role : 0x%02x, vp_index : %d, need_sync : %d",
                     4,
                     is_aws_connected,
                     aws_role,
                     vp_index,
                     need_sync);
#else
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_play_vp] vp_index : %d, need_sync : %d",
                     2,
                     vp_index,
                     need_sync);
#endif /* MTK_AWS_MCE_ENABLE */

    voice_prompt_param_t vp = {0};
    vp.vp_index = vp_index;
    if (need_sync == true) {
#ifdef MTK_AWS_MCE_ENABLE
        if (is_aws_connected == false) {
            vp.control = VOICE_PROMPT_CONTROL_MASK_NONE;
        } else {
            if (aws_role == BT_AWS_MCE_ROLE_AGENT) {
                vp.control = VOICE_PROMPT_CONTROL_MASK_SYNC;
            } else {
                vp.control = VOICE_PROMPT_CONTROL_MASK_NONE;
            }
        }
#else
        vp.control = VOICE_PROMPT_CONTROL_MASK_NONE;
#endif /* MTK_AWS_MCE_ENABLE */
    } else {
        vp.control = VOICE_PROMPT_CONTROL_MASK_NONE;
    }
    vp.delay_time = VOICE_PROMPT_SYNC_DELAY_MIN;

#ifdef MTK_AWS_MCE_ENABLE
    if ((need_sync == true) && (aws_role == BT_AWS_MCE_ROLE_PARTNER) && (is_aws_connected == true)) {
        app_hearing_aid_aws_sync_vp_play_t play = {0};
        play.vp_index = vp_index;
        app_hearing_aid_aws_send_operate_command(APP_HEARING_AID_OP_COMMAND_PLAY_SYNC_VP,
                                                    (uint8_t *)&play,
                                                    sizeof(app_hearing_aid_aws_sync_vp_play_t),
                                                    false,
                                                    false,
                                                    0);
    } else {
#endif /* MTK_AWS_MCE_ENABLE */
        voice_prompt_play(&vp, NULL);
#ifdef MTK_AWS_MCE_ENABLE
    }
#endif /* MTK_AWS_MCE_ENABLE */
}

void app_hearing_aid_activity_play_mode_index_vp(uint8_t index, bool need_sync)
{
    app_hearing_aid_activity_play_vp(app_hearing_aid_mode_vp_index_list[index], need_sync);
}

void app_hearing_aid_activity_play_ha_on_vp(bool enable, bool need_mode_vp, bool need_sync_play)
{

    uint8_t mode_index = 0;
    bool module_result = false;
    bool need_mode_vp_switch = app_hear_through_storage_get_ha_mode_on_vp_switch();

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_play_ha_on_vp] enable : %d, need_mode_vp : %d, need_mode_vp_switch : %d, need_sync_play : %d",
                        4,
                        enable,
                        need_mode_vp,
                        need_mode_vp_switch,
                        need_sync_play);

    if ((need_mode_vp == true) && (need_mode_vp_switch == true)) {
        module_result = app_hearing_aid_utils_get_mode_index_simple(&mode_index);
    }

#ifdef MTK_AWS_MCE_ENABLE
    bt_aws_mce_role_t aws_role = bt_device_manager_aws_local_info_get_role();
    bool is_aws_connected = app_hearing_aid_aws_is_connected();

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_play_ha_on_vp] role : 0x%02x, is_aws_connected : %d",
                        2,
                        aws_role,
                        is_aws_connected);

    // app_hearing_aid_activity_play_vp(VP_INDEX_DOORBELL, need_sync_play);
    // if (module_result == true) {
    //     app_hearing_aid_activity_play_mode_index_vp(mode_index, need_sync_play);
    // }

    if ((is_aws_connected == true) && (need_sync_play == true)) {
        if (aws_role == BT_AWS_MCE_ROLE_AGENT) {
            app_hearing_aid_activity_play_vp(VP_INDEX_DOORBELL, true);
            if (module_result == true) {
                app_hearing_aid_activity_play_mode_index_vp(mode_index, true);
            }
        }
    } else {
        app_hearing_aid_activity_play_vp(VP_INDEX_DOORBELL, false);
        if (module_result == true) {
            app_hearing_aid_activity_play_mode_index_vp(mode_index, false);
        }
    }
#else
    app_hearing_aid_activity_play_vp(VP_INDEX_DOORBELL, false);
    if (module_result == true) {
        app_hearing_aid_activity_play_mode_index_vp(mode_index, false);
    }
#endif /* MTK_AWS_MCE_ENABLE */
}

void app_hearing_aid_activity_pre_proc_operate_ha(uint8_t which, bool on, bool need_aws_sync)
{
    bool boot_up_switch_ha = true;
    bool internal_is_origin_on = app_hearing_aid_utils_is_ha_running();
    bool is_out_case = app_hearing_aid_activity_is_out_case();
    bool internal_mix_table_to_enable = false;
    bool internal_drc_to_enable = false;
    bool internal_need_execute = true;
    bool trigger_from_key = false;
    int8_t config_rssi = app_hear_through_storage_get_ha_rssi_threshold();

#ifdef MTK_AWS_MCE_ENABLE
    bool is_aws_connected = app_hearing_aid_aws_is_connected();
    bt_aws_mce_role_t aws_role = bt_device_manager_aws_local_info_get_role();
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_pre_proc_operate_ha] enter, aws_connected : %d, aws_role : 0x%02x",
                     2,
                     is_aws_connected,
                     aws_role);
#endif /* MTK_AWS_MCE_ENABLE */
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_pre_proc_operate_ha] enter, which : 0x%02x, on : %d, need_aws_sync : %d, key_triggered : %d",
                     4,
                     which,
                     on,
                     need_aws_sync,
                     trigger_from_key);
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_pre_proc_operate_ha] enter, power_on_executed : %d, powering_off : %d, boot_up_to_enable_ha : %d, out_case : %d, RSSI (%d - %d)",
                     6,
                     app_ha_activity_context.power_on_ha_executed,
                     app_ha_activity_context.is_powering_off,
                     boot_up_switch_ha,
                     is_out_case,
                     app_ha_activity_context.partner_rssi,
                     config_rssi);

    if (app_ha_activity_context.is_powering_off == true) {
        return;
    }

    if (is_out_case == false) {
        return;
    }

    if ((app_ha_activity_context.power_on_ha_executed == false)
        && (which != APP_HEARING_AID_CHANGE_CAUSE_POWER_ON)) {
        return;
    }

    if ((which == APP_HEARING_AID_CHANGE_CAUSE_POWER_ON) && (boot_up_switch_ha == false)) {
        app_hearing_aid_utils_set_user_switch(false);
        return;
    }

    if (which == APP_HEARING_AID_CHANGE_CAUSE_BUTTON) {
        trigger_from_key = true;
    }

    {
        app_hearing_aid_state_table_t table;
        memset(&table, 0, sizeof(app_hearing_aid_state_table_t));

        bt_sink_srv_state_t sink_srv_state = bt_sink_srv_get_state();

        if (sink_srv_state == BT_SINK_SRV_STATE_STREAMING) {
            table.a2dp_streaming = true;
        }

        if (sink_srv_state >= BT_SINK_SRV_STATE_INCOMING) {
            table.sco_streaming = true;
        }

        table.vp_streaming = app_ha_activity_context.vp_streaming;

#ifdef MTK_AWS_MCE_ENABLE
        if (is_aws_connected == false) {
            if (config_rssi != 0) {
                table.less_than_threshold = true;
            }
        } else {
            if (config_rssi == 0) {
                table.less_than_threshold = false;
            } else {
                if ((app_ha_activity_context.partner_rssi == 0)
                    || ((app_ha_activity_context.partner_rssi < config_rssi) && (config_rssi != 0))) {
                    table.less_than_threshold = true;
                }
            }
        }
#else
        if (config_rssi != 0) {
            table.less_than_threshold = true;
        } else {
            table.less_than_threshold = false;
        }
#endif

#ifdef MTK_IN_EAR_FEATURE_ENABLE
        if (app_ha_activity_context.is_in_ear == true) {
            table.in_ear = true;
        }
#endif /* MTK_IN_EAR_FEATURE_ENABLE */

        internal_mix_table_to_enable = app_hearing_aid_utils_mix_table_to_enable(&table, which, &internal_need_execute);

        internal_drc_to_enable = app_hearing_aid_utils_is_drc_enable(table.a2dp_streaming, table.sco_streaming, table.vp_streaming);

        APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_pre_proc_operate_ha] Origin_enable : %d, mix_table_to_enable : %d, drc_to_enable : %d, need_execute : %d, open_fwk_done : %d, is_opening : %d",
                         6,
                         internal_is_origin_on,
                         internal_mix_table_to_enable,
                         internal_drc_to_enable,
                         internal_need_execute,
                         app_ha_activity_context.is_open_fwk_done,
                         app_ha_activity_context.is_opening_fwk);

        // if ((internal_need_execute == false) || (internal_is_origin_on == internal_mix_table_to_enable)) {
        //     return;
        // }
    }

#ifdef MTK_AWS_MCE_ENABLE
    /**
     * @brief Fix issue that do not sync operate HA if trigger from VP.
     */
    if ((need_aws_sync == true) && (is_aws_connected == true) && (which != APP_HEARING_AID_CHANGE_CAUSE_VP)) {
        app_hearing_aid_aws_sync_operate_ha_t operate_ha = {
            .which = which,
            .from_key = trigger_from_key,
            .mix_table_need_execute = internal_need_execute,
            .is_origin_on = internal_is_origin_on,
            .mix_table_to_enable = internal_mix_table_to_enable,
            .drc_to_enable = internal_drc_to_enable,
        };

        app_hearing_aid_aws_send_operate_command(APP_HEARING_AID_OP_COMMAND_CONTROL_HA,
                                                    (uint8_t *)&operate_ha,
                                                    sizeof(app_hearing_aid_aws_sync_operate_ha_t),
                                                    true,
                                                    true,
                                                    APP_HEARING_AID_SYNC_EVENT_DEFAULT_TIMEOUT);
    } else {
#endif /* MTK_AWS_MCE_ENABLE */
        bool operate_ha_result = app_hearing_aid_activity_operate_ha(trigger_from_key,
                                                                        which,
                                                                        internal_need_execute,
                                                                        internal_is_origin_on,
                                                                        internal_mix_table_to_enable,
                                                                        internal_drc_to_enable);

        if (operate_ha_result == false) {
            APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_pre_proc_operate_ha] Operate HA failed", 0);
            return;
        }
#ifdef MTK_AWS_MCE_ENABLE
    }
#endif /* MTK_AWS_MCE_ENABLE */
}

bool app_hearing_aid_activity_process_race_cmd(void *race_data, size_t race_data_len)
{
    if (app_ha_activity_context.inited == false) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_process_race_cmd] Not inited", 0);
        return false;
    }

    // app_hearing_aid_activity_handle_race_cmd(race_data, race_data_len);
    if ((race_data == NULL) || (race_data_len == 0)) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_process_race_cmd] Data error (0x%04x, %d)", 2, race_data, race_data_len);
        return false;
    }

    uint8_t execute_where = APP_HEARING_AID_EXECUTE_NONE;
    bool need_sync_execute = false;

    app_hear_through_request_t *request = (app_hear_through_request_t *)race_data;

    if ((request->op_code != APP_HEAR_THROUGH_CMD_OP_CODE_SET)
        && (request->op_code != APP_HEAR_THROUGH_CMD_OP_CODE_GET)) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_process_race_cmd] Unknown code : %d",
                         1,
                         request->op_code);
        return false;
    }

    execute_where = app_hearing_aid_config_get_where_to_execute(request->op_code, request->op_type);
    need_sync_execute = app_hearing_aid_config_get_need_execute_set_cmd_sync(request->op_type);

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_process_race_cmd] handle code : %s, type : %s, where : %s, need_sync_execute : %d",
                        4,
                        app_hearing_aid_command_string[request->op_code],
                        app_hearing_aid_type_string[request->op_type],
                        app_hearing_aid_execute_where_string[execute_where],
                        need_sync_execute);

#ifdef MTK_AWS_MCE_ENABLE
    if ((app_hearing_aid_aws_is_connected() == true) && (execute_where == APP_HEARING_AID_EXECUTE_ON_BOTH)) {

        uint32_t delay_ms = 0;

        if (need_sync_execute == true) {
            delay_ms = APP_HEARING_AID_SYNC_EVENT_DEFAULT_TIMEOUT;
        } else {
            delay_ms = 0;
        }

        app_hearing_aid_aws_send_operate_command(APP_HEARING_AID_OP_COMMAND_RACE_CMD_REQUEST,
                                                    race_data,
                                                    race_data_len,
                                                    need_sync_execute,
                                                    true,
                                                    delay_ms);
    } else {
#endif /* MTK_AWS_MCE_ENABLE */

    if (request->op_code == APP_HEAR_THROUGH_CMD_OP_CODE_GET) {
        uint8_t get_response[APP_HEARING_AID_RESPONSE_MAX_LEN] = {0};
        uint16_t get_response_len = 0;

        if (request->op_type == APP_HEARING_AID_CONFIG_TYPE_FEEDBACK_DETECTION) {
            app_feedback_detection_directly = true;
        }

        app_hearing_aid_activity_handle_get_race_cmd(race_data, race_data_len, get_response, &get_response_len);
        app_hear_through_race_cmd_send_get_response(request->op_type, get_response, get_response_len);
    } else {
        bool set_result = app_hearing_aid_activity_handle_set_race_cmd(race_data, race_data_len);
        app_hear_through_race_cmd_send_set_response(request->op_type, set_result);
    }

#ifdef MTK_AWS_MCE_ENABLE
    }
#endif /* MTK_AWS_MCE_ENABLE */
    return true;
}

bool app_hearing_aid_activity_open_hearing_aid_fwk()
{
    if (app_ha_activity_context.inited == false) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_open_hearing_aid_fwk] Not inited", 0);
        return false;
    }

    if (app_ha_activity_context.is_open_fwk_done == true) {
        APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_open_hearing_aid_fwk] Framework already opened", 0);
        return true;
    } else {
        if (app_ha_activity_context.is_opening_fwk == true) {
            APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_open_hearing_aid_fwk] Framework is opening", 0);
            return true;
        }
    }

    bool fwk_result = app_hearing_aid_utils_control_fwk(true);
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_open_hearing_aid_fwk] Enable framework result : %d",
                        1,
                        fwk_result);

    if (fwk_result == false) {
        return false;
    }

    app_ha_activity_context.is_open_fwk_done = false;
    app_ha_activity_context.is_opening_fwk = true;
    return true;
}

void app_hearing_aid_activity_set_open_fwk_done(bool result)
{
    if (app_ha_activity_context.inited == false) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_set_open_fwk_done] Not inited", 0);
        return;
    }

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_set_open_fwk_done] Result : %d",
                     1,
                     result);

    if (result == true) {
        app_ha_activity_context.is_open_fwk_done = true;
        app_ha_activity_context.is_opening_fwk = false;

        app_hearing_aid_activity_send_rssi_reading_event();
    } else {
        app_ha_activity_context.is_open_fwk_done = false;
        app_ha_activity_context.is_opening_fwk = false;
    }
}

bool app_hearing_aid_activity_is_open_fwk_done()
{
    return app_ha_activity_context.is_open_fwk_done;
}

bool app_hearing_aid_activity_is_fwk_opening()
{
    return app_ha_activity_context.is_opening_fwk;
}

bool app_hearing_aid_activity_enable_hearing_aid(bool from_key)
{
    if (app_ha_activity_context.inited == false) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_enable_hearing_aid] Not inited", 0);
        return false;
    }

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_enable_hearing_aid] from_key : %d, FWK open done : %d, power_on_ha_executed : %d, stored_open_caused_by_which : 0x%02x",
                        4,
                        from_key,
                        app_ha_activity_context.is_open_fwk_done,
                        app_ha_activity_context.power_on_ha_executed,
                        app_ha_activity_context.ha_open_caused_by_which_reason);

    if (app_ha_activity_context.is_open_fwk_done == false) {
        return false;
    }

    if (app_ha_activity_context.power_on_ha_executed == false) {
        app_hearing_aid_activity_pre_proc_operate_ha(APP_HEARING_AID_CHANGE_CAUSE_POWER_ON, true, false);
        app_ha_activity_context.power_on_ha_executed = true;
    } else {
        if (from_key == true) {
            app_hearing_aid_activity_pre_proc_operate_ha(APP_HEARING_AID_CHANGE_CAUSE_BUTTON, true, false);
        } else {
            if (app_ha_activity_context.ha_open_caused_by_which_reason != 0x00) {
                app_hearing_aid_activity_pre_proc_operate_ha(app_ha_activity_context.ha_open_caused_by_which_reason, true, false);
                app_ha_activity_context.ha_open_caused_by_which_reason = 0x00;
            } else {
                app_hearing_aid_activity_pre_proc_operate_ha(APP_HEARING_AID_CHANGE_CAUSE_RACE_CMD, true, false);
            }
        }
    }

    return true;
}

bool app_hearing_aid_activity_disable_hearing_aid(bool need_vp)
{
    if (app_ha_activity_context.inited == false) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_disable_hearing_aid] Not inited", 0);
        return false;
    }

    if (app_ha_activity_context.is_open_fwk_done == true) {
        bool disable_ha_result = app_hearing_aid_utils_control_ha(false);

        bool fwk_result = app_hearing_aid_utils_control_fwk(false);
        APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_disable_hearing_aid] disable_ha_result : %d, close framework result : %d, need_vp : %d",
                            3,
                            disable_ha_result,
                            fwk_result,
                            need_vp);
    } else {
        APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_disable_hearing_aid] Hearing Aid Already closed", 0);
    }


    // if (fwk_result == false) {
    //     return false;
    // }

    // app_ha_activity_context.is_open_fwk_done = false;
    // app_ha_activity_context.is_opening_fwk = false;

    // ui_shell_send_event(false,
    //                     EVENT_PRIORITY_MIDDLE,
    //                     EVENT_GROUP_UI_SHELL_HEARING_AID,
    //                     APP_HEARING_AID_EVENT_ID_HA_OFF,
    //                     NULL,
    //                     0,
    //                     NULL,
    //                     0);

    app_hearing_aid_activity_remove_ha_event();

    /**
     * @brief Play VP to notify HA is off.
     */
    if ((need_vp == true) && (app_ha_activity_context.is_powering_off == false)) {
        app_hearing_aid_activity_play_ha_on_vp(false, false, true);
    }

    return true;
}

bool app_hearing_aid_activity_is_hearing_aid_on()
{
    return app_hearing_aid_utils_is_ha_running();
}

bool app_hearing_aid_activity_set_user_switch(bool need_sync, bool enable)
{
    if (app_ha_activity_context.inited == false) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_set_user_switch] Not inited", 0);
        return false;
    }

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_set_user_switch] need_sync : %d, enable : %d",
                        2,
                        need_sync,
                        enable);

    app_hearing_aid_utils_set_user_switch(enable);

#ifdef MTK_AWS_MCE_ENABLE
    bool is_aws_connected = app_hearing_aid_aws_is_connected();
    if ((is_aws_connected == true) && (need_sync == true)) {
        app_hearing_aid_aws_send_operate_command(APP_HEARING_AID_OP_COMMAND_SET_USER_SWITCH,
                                                 (uint8_t *)(&enable),
                                                 sizeof(bool),
                                                 false,
                                                 false,
                                                 0);
    }
#endif /* MTK_AWS_MCE_ENABLE */
    return true;
}

bool app_hearing_aid_activity_operate_ha(bool trigger_from_key, uint8_t which, bool mix_table_need_execute, bool is_origin_on, bool mix_table_to_enable, bool drc_to_enable)
{
    if (app_ha_activity_context.inited == false) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_operate_ha] Not inited", 0);
        return false;
    }

    if (app_hearing_aid_activity_is_out_case() == false) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_operate_ha] Current is NOT out case", 0);
        return false;
    }

    bool user_switch_on = app_hearing_aid_utils_is_ha_user_switch_on();
    if (user_switch_on == false) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_operate_ha] current user switch is off state", 0);
        return false;
    }

    bool need_notify = false;
    bool notify_result = false;
    bool need_vp = false;
    // bool is_opening = app_ha_activity_context.is_opening_fwk;

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_operate_ha] which : 0x%02x, need_execute : %d, is_origin_on : %d, mix_table_to_enable : %d, drc_to_enable : %d",
                     5,
                     which,
                     mix_table_need_execute,
                     is_origin_on,
                     mix_table_to_enable,
                     drc_to_enable);

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_operate_ha] fwk_done : %d, opening_fwk : %d, old_drc_enable : %d, is_key_triggered : %d",
                     4,
                     app_ha_activity_context.is_open_fwk_done,
                     app_ha_activity_context.is_opening_fwk,
                     app_ha_activity_context.drc_enable,
                     trigger_from_key);

    if (((mix_table_to_enable == true) && (mix_table_need_execute == true))
        || (drc_to_enable == true)) {

        if (app_ha_activity_context.is_open_fwk_done == false) {
            if (app_ha_activity_context.is_opening_fwk == false) {
                app_hearing_aid_activity_open_hearing_aid_fwk();
                app_ha_activity_context.ha_open_caused_by_which_reason = which;
            }
        } else {
            if (mix_table_need_execute == true) {
                bool result = app_hearing_aid_utils_control_ha(mix_table_to_enable);

                if (result == false) {
                    APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_operate_ha] Failed to control HA (%d)", 1, mix_table_to_enable);

                    app_hearing_aid_utils_control_fwk(false);
                    return false;
                }

                need_notify = true;

                if (mix_table_to_enable == true) {
                    notify_result = true;
                } else {
                    notify_result = false;
                }

                need_vp = true;
            }
        }
    }

    /**
     * @brief Fix issue
     * If is opening FWK, but later is ready to disable, need disable FWk.
     */
    if ((mix_table_to_enable == false) && (mix_table_need_execute == true) && (drc_to_enable == false)) {

        app_hearing_aid_activity_disable_hearing_aid(false);

        need_notify = true;
        need_vp = true;
        notify_result = false;
    }

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_operate_ha] need_vp : %d, need_notify : %d, notify_result : %d",
                        3,
                        need_vp,
                        need_notify,
                        notify_result);

    if (need_vp == true) {
        if ((which == APP_HEARING_AID_CHANGE_CAUSE_BUTTON)
                || (which == APP_HEARING_AID_CHANGE_CAUSE_POWER_ON)
                || (which == APP_HEARING_AID_CHANGE_CAUSE_RACE_CMD)
                || (which == APP_HEARING_AID_CHANGE_CAUSE_MIX_TABLE)
                || (trigger_from_key == true)) {

            bool notify_ha_enable = false;

            if ((is_origin_on == 0) && (mix_table_to_enable == 1)) {
                notify_ha_enable = true;
                if (which == APP_HEARING_AID_CHANGE_CAUSE_POWER_ON) {
                    app_hearing_aid_activity_play_ha_on_vp(notify_result, true, false);
                } else {
                    app_hearing_aid_activity_play_ha_on_vp(notify_result, false, true);
                }
            }

            if ((is_origin_on == 1) && (mix_table_to_enable == 0)) {
                notify_ha_enable = true;
                app_hearing_aid_activity_play_ha_on_vp(false, false, true);
            }

            if (notify_ha_enable == true) {
                app_hear_through_race_cmd_send_notification(APP_HEARING_AID_CONFIG_TYPE_HA_SWITCH,
                                                            (uint8_t *)(&notify_result),
                                                            sizeof(bool));
            }
        }
    }

    if (need_notify == true) {
        if (notify_result == true) {
            ui_shell_send_event(false,
                                EVENT_PRIORITY_MIDDLE,
                                EVENT_GROUP_UI_SHELL_HEARING_AID,
                                APP_HEARING_AID_EVENT_ID_HA_ON,
                                NULL,
                                0,
                                NULL,
                                0);
        } else {
            ui_shell_send_event(false,
                                EVENT_PRIORITY_MIDDLE,
                                EVENT_GROUP_UI_SHELL_HEARING_AID,
                                APP_HEARING_AID_EVENT_ID_HA_OFF,
                                NULL,
                                0,
                                NULL,
                                0);
        }
    }

    return true;
}

#ifdef MTK_AWS_MCE_ENABLE
void app_hearing_aid_activity_set_powering_off()
{
    app_ha_activity_context.is_powering_off = true;
}
#endif /* MTK_AWS_MCE_ENABLE */

#ifdef MTK_AWS_MCE_ENABLE
static bt_status_t app_hearing_aid_activity_gap_event_handler(bt_msg_type_t msg, bt_status_t status, void *buff)
{
    if ((status == BT_STATUS_SUCCESS) && (msg == BT_GAP_READ_RAW_RSSI_CNF)) {
        bt_gap_read_rssi_cnf_t *rssi_cnf = (bt_gap_read_rssi_cnf_t *)buff;

        if (app_ha_activity_context.partner_rssi == rssi_cnf->rssi) {
            APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_gap_event_handler] RSSI not changed (%d), ignore",
                             1,
                             app_ha_activity_context.partner_rssi);
            return BT_STATUS_SUCCESS;
        }

        app_ha_activity_context.partner_rssi = rssi_cnf->rssi;

        int8_t config_rssi = app_hear_through_storage_get_ha_rssi_threshold();
        if (config_rssi == 0x00) {
            return BT_STATUS_SUCCESS;
        }

        bool on = false;
        bool result = app_hearing_aid_utils_is_rssi_mix_switch_on(&on);
        uint32_t power_off_timeout = app_hear_through_storage_get_ha_rssi_power_off_timeout();

        APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_gap_event_handler] rssi switch : %d, on : %d, config_rssi : %d, partner_rssi : %d, power_off_timeout : %d",
                         5,
                         result,
                         on,
                         config_rssi,
                         app_ha_activity_context.partner_rssi,
                         power_off_timeout);

        if (result == false || on == false) {
            return BT_STATUS_SUCCESS;
        }

        app_hearing_aid_activity_pre_proc_operate_ha(APP_HEARING_AID_CHANGE_CAUSE_RSSI, false, true);

        if (power_off_timeout > 0) {
            if (app_ha_activity_context.partner_rssi > config_rssi) {
                ui_shell_send_event(false,
                                    EVENT_PRIORITY_MIDDLE,
                                    EVENT_GROUP_UI_SHELL_HEARING_AID,
                                    APP_HEARING_AID_EVENT_ID_RSSI_POWER_OFF,
                                    NULL,
                                    0,
                                    NULL,
                                    power_off_timeout);
            } else {
                ui_shell_remove_event(EVENT_GROUP_UI_SHELL_HEARING_AID, APP_HEARING_AID_EVENT_ID_RSSI_POWER_OFF);
            }
        }
    }
    return status;
}

static bt_status_t app_hearing_aid_activity_send_rssi_reading_event()
{
    int8_t config_rssi = app_hear_through_storage_get_ha_rssi_threshold();
    bool is_aws_connected = app_hearing_aid_aws_is_connected();
    if ((bt_device_manager_aws_local_info_get_role() == BT_AWS_MCE_ROLE_AGENT)
            && (config_rssi != 0)
            && (is_aws_connected == true)) {
        ui_shell_remove_event(EVENT_GROUP_UI_SHELL_HEARING_AID, APP_HEARING_AID_EVENT_ID_RSSI_READ);
        ui_shell_send_event(false,
                            EVENT_PRIORITY_MIDDLE,
                            EVENT_GROUP_UI_SHELL_HEARING_AID,
                            APP_HEARING_AID_EVENT_ID_RSSI_READ,
                            NULL,
                            0,
                            NULL,
                            APP_HA_RSSI_READ_TIMEOUT);
    }
    return BT_STATUS_SUCCESS;
}
#endif /* MTK_AWS_MCE_ENABLE */

void app_hearing_aid_activity_ha_utils_notify_handler(uint8_t role, uint32_t type, uint8_t *notify_data, uint16_t notify_data_len)
{
    uint16_t notify_event = (type >> 16) & 0x0000FFFF;
    uint16_t which_msg = type & 0x0000FFFF;

#ifdef MTK_AWS_MCE_ENABLE
    bt_aws_mce_role_t aws_role = bt_device_manager_aws_local_info_get_role();
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_ha_utils_notify_handler] Aws Role : 0x%02x, role : %d, event : 0x%04x, msg : %s, data : 0x%x, data_len : %d",
                     6,
                     aws_role,
                     role,
                     notify_event,
                     app_hearing_aid_type_string[which_msg],
                     notify_data,
                     notify_data_len);

#else
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_ha_utils_notify_handler] Role : %d, event : 0x%04x, msg : %s, data : 0x%x, data_len : %d",
                     5,
                     role,
                     notify_event,
                     app_hearing_aid_type_string[which_msg],
                     notify_data,
                     notify_data_len);
#endif /* MTK_AWS_MCE_ENABLE */

    switch (notify_event) {
        case APP_HEARING_AID_UTILS_NOTIFY_EVENT_NOTIFICATION: {
#ifdef MTK_AWS_MCE_ENABLE
            if (app_hearing_aid_aws_is_connected() == false) {
                app_hear_through_race_cmd_send_notification(which_msg, notify_data, notify_data_len);
            } else {
                if (aws_role == BT_AWS_MCE_ROLE_AGENT) {
                    uint8_t combine_notify_data[APP_HEARING_AID_NOTIFY_MAX_LEN] = {0};
                    uint16_t combine_notify_data_len = 0;
                    bool ret_value = app_hearing_aid_utils_handle_notify(role,
                                                                         which_msg,
                                                                         notify_data,
                                                                         notify_data_len,
                                                                         combine_notify_data,
                                                                         &combine_notify_data_len);

                    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_ha_utils_notify_handler] Notify result : %d, length : %d",
                                     2,
                                     ret_value,
                                     combine_notify_data_len);

                    if ((ret_value == true) && (combine_notify_data_len > 0)) {
                        app_hear_through_race_cmd_send_notification(which_msg, combine_notify_data, combine_notify_data_len);
                    }
                } else if (aws_role == BT_AWS_MCE_ROLE_PARTNER) {
                    if (which_msg == APP_HEARING_AID_CONFIG_TYPE_FEEDBACK_DETECTION) {
#if 0
                        bool is_fbd_detection_from_aws = app_hearing_aid_aws_is_feedback_detection_from_aws();
                        /**
                         * @brief Fix issue that if FBD from partner side directly, need notify to related port.
                         */
                        app_hearing_aid_aws_reset_feedback_detection_from_aws();
                        if (is_fbd_detection_from_aws == false) {
                            app_hear_through_race_cmd_send_notification(which_msg, notify_data, notify_data_len);
                            return;
                        }
#endif /* 0 */
                        if (app_feedback_detection_directly == true) {
                            app_hear_through_race_cmd_send_notification(which_msg, notify_data, notify_data_len);
                            return;
                        }
                        app_feedback_detection_directly = false;
                    }
                    if (app_hearing_aid_config_get_notify_sync(which_msg) == true) {
                        app_hearing_aid_aws_send_notification(role,
                                                              type,
                                                              notify_data,
                                                              notify_data_len);
                    }
                }
            }
#else
            app_hear_through_race_cmd_send_notification(which_msg, notify_data, notify_data_len);
#endif /* MTK_AWS_MCE_ENABLE */
        }
        break;

        case APP_HEARING_AID_UTILS_NOTIFY_TO_CONTROL_HA: {
            bool need_aws_sync = false;
            ui_shell_send_event(false,
                                EVENT_PRIORITY_MIDDLE,
                                EVENT_GROUP_UI_SHELL_HEARING_AID,
                                APP_HEARING_AID_EVENT_ID_REQUEST_TO_CONTROL_HA,
                                (void *)need_aws_sync,
                                0,
                                NULL,
                                0);
        }
        break;

        case APP_HEARING_AID_UTILS_NOTIFY_TO_UPDATE_MODE_INDEX: {
            uint8_t *mode_index = (uint8_t *)pvPortMalloc(sizeof(uint8_t) * notify_data_len);
            if (mode_index == NULL) {
                APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_ha_utils_notify_handler] Failed to allocate buffer for mode index", 0);
                return;
            }

            memset(mode_index, 0, sizeof(uint8_t) * notify_data_len);
            memcpy(mode_index, notify_data, notify_data_len);

            ui_shell_send_event(false,
                                EVENT_PRIORITY_MIDDLE,
                                EVENT_GROUP_UI_SHELL_HEARING_AID,
                                APP_HEARING_AID_EVENT_ID_MODIFY_MODE_INDEX,
                                mode_index,
                                notify_data_len,
                                NULL,
                                0);
        }
        break;

        case APP_HEARING_AID_UTILS_NOTIFY_TO_PLAY_AEA_OFF_VP: {
            ui_shell_send_event(false,
                                EVENT_PRIORITY_MIDDLE,
                                EVENT_GROUP_UI_SHELL_HEARING_AID,
                                APP_HEARING_AID_EVENT_ID_AEA_OFF_VP,
                                NULL,
                                0,
                                NULL,
                                0);
        }
        break;

        case APP_HEARING_AID_UTILS_NOTIFY_IN_EAR_DETECTION_SWITCH_CHANGE: {
#ifdef MTK_IN_EAR_FEATURE_ENABLE
            bool is_on = app_in_ear_get_own_state();
            app_hearing_aid_activity_proc_app_interaction(APPS_EVENTS_INTERACTION_UPDATE_IN_EAR_STA_EFFECT,
                                                            (void *)(&is_on),
                                                            sizeof(bool));
#endif /* MTK_IN_EAR_FEATURE_ENABLE */
        }
        break;
    }
}

/*===================================================================================*/
/*                     HA INTERNAL FUNCTION IMPLEMENTATION                           */
/*===================================================================================*/
static bool app_hearing_aid_activity_handle_set_race_cmd(uint8_t *race_data, uint16_t race_data_len)
{
    bool set_result = false;
    app_hear_through_request_t *request = (app_hear_through_request_t *)race_data;

    if (request->op_code != APP_HEAR_THROUGH_CMD_OP_CODE_SET) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_set_race_cmd] Operate code is not SET : 0x%02x",
                            1,
                            request->op_code);
        return false;
    }

    app_hearing_aid_utils_handle_set_race_cmd(request, &set_result);

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_set_race_cmd] SET type : 0x%04x (%s), set result : %d",
                         3,
                         request->op_type,
                         app_hearing_aid_type_string[request->op_type],
                         set_result);

    return set_result;
}

static void app_hearing_aid_activity_handle_get_race_cmd(uint8_t *race_data, uint16_t race_data_len, uint8_t *get_response, uint16_t *get_response_len)
{
    app_hear_through_request_t *request = (app_hear_through_request_t *)race_data;

    if (request->op_code != APP_HEAR_THROUGH_CMD_OP_CODE_GET) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_get_race_cmd] Operate code is not GET : 0x%02x",
                            1,
                            request->op_code);
        return;
    }

    app_hearing_aid_utils_handle_get_race_cmd(request, get_response, get_response_len);

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_race_cmd] GET type : 0x%04x, get length : %d",
                     2,
                     request->op_type,
                     get_response_len);
}

static void app_hearing_aid_activity_remove_ha_event()
{
    /**
     * @brief remove hearing AID event.
     */
    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_HEARING_AID, APP_HEARING_AID_EVENT_ID_REQUEST_TO_CONTROL_HA);
    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_HEARING_AID, APP_HEARING_AID_EVENT_ID_VP_STREAMING_BEGIN);
    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_HEARING_AID, APP_HEARING_AID_EVENT_ID_VP_STREAMING_END);
    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_HEARING_AID, APP_HEARING_AID_EVENT_ID_RSSI_READ);
    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_HEARING_AID, APP_HEARING_AID_EVENT_ID_AEA_OFF_VP);
    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_HEARING_AID, APP_HEARING_AID_EVENT_ID_RSSI_POWER_OFF);
}

static void app_hearing_aid_activity_initialization()
{
    if (app_ha_activity_context.inited == true) {
        APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_initialization] Already inited", 0);
        return;
    }

#ifdef AIR_HEARING_AID_ENABLE
    /**
     * @brief Read the chip information.
     * TODO maybe need modify the judgement point.
     */
    uint32_t chip_info = sub_chip_version_get();
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_initialization] chip_info : 0x%02x", 1, chip_info);
    if ((chip_info != 0x0A) && (chip_info != 0x0D)) {
        assert(false && "Not supported chip");
    }
#endif /* AIR_HEARING_AID_ENABLE */

    memset(&app_ha_activity_context, 0, sizeof(app_hearing_aid_activity_context_t));
    app_ha_activity_context.inited = true;

#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
    app_ha_activity_context.is_charger_in = true;//!is_out_case;
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */

    app_hearing_aid_storage_load();

    app_hearing_aid_utils_init(app_hearing_aid_activity_ha_utils_notify_handler);

#ifdef MTK_AWS_MCE_ENABLE
    bt_status_t status = bt_callback_manager_register_callback(bt_callback_type_app_event,
                                                               MODULE_MASK_GAP,
                                                               (void *)app_hearing_aid_activity_gap_event_handler);

    if (status != BT_STATUS_SUCCESS) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_initialization] Failed to register RSSI GAP callback : 0x%x",
                         1,
                         status);
    }
#endif /* MTK_AWS_MCE_ENABLE */
}

static void app_hearing_aid_activity_de_initialization()
{
    if (app_ha_activity_context.inited == false) {
        return;
    }

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_de_initialization] Enter", 0);

    if (app_ha_activity_context.is_open_fwk_done == true) {
        app_hearing_aid_activity_disable_hearing_aid(false);
    }

    app_hearing_aid_utils_deinit();

#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
    bool is_charger_in = app_ha_activity_context.is_charger_in;
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */

    memset(&app_ha_activity_context, 0, sizeof(app_hearing_aid_activity_context_t));

#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
    app_ha_activity_context.is_charger_in = is_charger_in;
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */

    ui_shell_remove_event(EVENT_GROUP_UI_SHELL_HEARING_AID, APP_HEARING_AID_EVENT_ID_INIT_TO_PLAY_POWER_ON_VP);
    app_hearing_aid_activity_remove_ha_event();
}

/**
 * @brief Process the system event.
 *
 * @param event_id
 * @param extra_data
 * @param data_len
 * @return true
 * @return false
 */
static bool app_hearing_aid_activity_proc_sys_event(uint32_t event_id,
                                                    void *extra_data,
                                                    size_t data_len)
{
    if (event_id == EVENT_ID_SHELL_SYSTEM_ON_CREATE) {
        APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_sys_event] Activity Create", 0);

        app_hearing_aid_activity_initialization();

#if 0
        bool need_execute = true;
        if (is_out_case == false) {
            need_execute = false;
        }

        if (need_execute == true) {
            app_hearing_aid_activity_initialization();
        }
#endif
    } else if (event_id == EVENT_ID_SHELL_SYSTEM_ON_DESTROY) {
        APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_sys_event] Activity Destroy", 0);
        app_hearing_aid_activity_de_initialization();
    }

    return true;
}

/**
 * @brief Process the key event
 *
 * @param event_id
 * @param extra_data
 * @param data_len
 * @return true
 * @return false
 */
static bool app_hearing_aid_activity_proc_key_event(uint32_t event_id,
                                                    void *extra_data,
                                                    size_t data_len)
{
    uint16_t key_id = *(uint16_t *)extra_data;

    if ((key_id < KEY_HEARING_AID_BEGIN) || (key_id > KEY_HEARING_AID_END)) {
        return false;
    }

    bool user_switch = app_hearing_aid_utils_is_ha_user_switch_on();
    if ((user_switch == false) || (app_ha_activity_context.inited == false)) {
#if APP_HEARING_AID_DEBUG_ENABLE
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_key_event] Not ready to process key event, %d - %d",
                            2,
                            app_ha_activity_context.inited,
                            user_switch);
#endif /* APP_HEARING_AID_DEBUG_ENABLE */
        return false;
    }

    /**
     * @brief Handle the key event locally.
     */
    return app_hearing_aid_key_handler_processing(key_id);
}

/**
 * @brief Process BT Sink Service event
 * Check A2DP/SCO streaming or not to determine need start HA or not.
 *
 * @param event_id
 * @param extra_data
 * @param data_len
 * @return true
 * @return false
 */
static bool app_hearing_aid_activity_proc_bt_sink_event(uint32_t event_id,
                                                        void *extra_data,
                                                        size_t data_len)
{
    bool user_switch = app_hearing_aid_utils_is_ha_user_switch_on();
    if ((user_switch == false) || (app_ha_activity_context.inited == false)) {
#if APP_HEARING_AID_DEBUG_ENABLE
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_bt_sink_event] Not ready to process bt sink event, %d - %d, event_id : 0x%04x",
                            3,
                            app_ha_activity_context.inited,
                            user_switch,
                            event_id);
#endif /* APP_HEARING_AID_DEBUG_ENABLE */
        return false;
    }

    if (event_id == BT_SINK_SRV_EVENT_STATE_CHANGE) {
        bt_sink_srv_event_param_t *event = (bt_sink_srv_event_param_t *)extra_data;
        if (event != NULL) {
            APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_bt_sink_event] current state : 0x%04x, pre state : 0x%04x",
                             2,
                             event->state_change.current,
                             event->state_change.previous);
            bool a2dp_changed = false;
            bool sco_changed = false;

            if ((event->state_change.current >= BT_SINK_SRV_STATE_INCOMING)
                && (event->state_change.previous < BT_SINK_SRV_STATE_INCOMING)) {
                audio_psap_control_senario_notification(LLF_SCENARIO_CHANGE_UL_CALL, true);
            }
            if ((event->state_change.current < BT_SINK_SRV_STATE_INCOMING)
                && (event->state_change.previous >= BT_SINK_SRV_STATE_INCOMING)) {
                audio_psap_control_senario_notification(LLF_SCENARIO_CHANGE_UL_CALL, false);
            }

            if (((event->state_change.current >= BT_SINK_SRV_STATE_INCOMING) && (event->state_change.previous < BT_SINK_SRV_STATE_INCOMING))
                || ((event->state_change.current < BT_SINK_SRV_STATE_INCOMING) && (event->state_change.previous >= BT_SINK_SRV_STATE_INCOMING))) {
                sco_changed = true;
            }

            if (((event->state_change.current == BT_SINK_SRV_STATE_STREAMING) && (event->state_change.previous != BT_SINK_SRV_STATE_STREAMING))
                || ((event->state_change.current != BT_SINK_SRV_STATE_STREAMING) && (event->state_change.previous == BT_SINK_SRV_STATE_STREAMING))) {
                a2dp_changed = true;
            }

#ifndef MTK_AWS_MCE_ENABLE
            APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_bt_sink_event] a2dp_changed : %d, sco_changed : %d",
                             2,
                             a2dp_changed,
                             sco_changed);
#else
            bt_aws_mce_role_t aws_role = bt_device_manager_aws_local_info_get_role();
            APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_bt_sink_event] aws_role : 0x%02x, a2dp_changed : %d, sco_changed : %d",
                             3,
                             aws_role,
                             a2dp_changed,
                             sco_changed);
#endif /* MTK_AWS_MCE_ENABLE */

#ifdef MTK_AWS_MCE_ENABLE
            if (aws_role == BT_AWS_MCE_ROLE_AGENT) {
#endif /* MTK_AWS_MCE_ENABLE */
                if (a2dp_changed == true) {
                    if ((event->state_change.current == BT_SINK_SRV_STATE_STREAMING) && (event->state_change.previous != BT_SINK_SRV_STATE_STREAMING)) {
                        bool need_aws_sync = true;
                        ui_shell_send_event(false,
                                            EVENT_PRIORITY_MIDDLE,
                                            EVENT_GROUP_UI_SHELL_HEARING_AID,
                                            APP_HEARING_AID_EVENT_ID_REQUEST_TO_CONTROL_HA,
                                            (void *)need_aws_sync,
                                            0,
                                            NULL,
                                            APP_HA_CONTROL_HEARING_AID_BY_A2DP_TIMEOUT);
                    } else {
                        app_hearing_aid_activity_pre_proc_operate_ha(APP_HEARING_AID_CHANGE_CAUSE_A2DP, false, true);
                    }
                    return false;
                }
                if (sco_changed == true) {
                    app_hearing_aid_activity_pre_proc_operate_ha(APP_HEARING_AID_CHANGE_CAUSE_SCO, false, true);
                    return false;
                }
#ifdef MTK_AWS_MCE_ENABLE
            }
#endif /* MTK_AWS_MCE_ENABLE */
        }
    }
    return false;
}

/**
 * @brief
 *
 * @param event_id
 * @param extra_data
 * @param data_len
 * @return true
 * @return false
 */
static bool app_hearing_aid_activity_proc_app_interaction(uint32_t event_id,
                                                          void *extra_data,
                                                          size_t data_len)
{
    bool user_switch = app_hearing_aid_utils_is_ha_user_switch_on();
    if ((user_switch == false) || (app_ha_activity_context.inited == false)) {
#if APP_HEARING_AID_DEBUG_ENABLE
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_app_interaction] Not ready to process app interaction event, %d - %d, event_id : 0x%04x",
                            3,
                            app_ha_activity_context.inited,
                            user_switch,
                            event_id);
#endif /* APP_HEARING_AID_DEBUG_ENABLE */
        return false;
    }

#ifdef MTK_IN_EAR_FEATURE_ENABLE
    if (event_id == APPS_EVENTS_INTERACTION_UPDATE_IN_EAR_STA_EFFECT) {
        bool on = app_hearing_aid_storage_get_in_ear_detection_switch();
        uint32_t timeout = app_hear_through_storage_get_ha_in_ear_det_turn_on_delay_time();
        bool is_in_ear = ((uint8_t *)extra_data)[0];

        APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_app_interaction] in_ear_detection_switch : %d, is_in_ear : %d -> %d, timeout : %d",
                            4,
                            on,
                            app_ha_activity_context.is_in_ear,
                            is_in_ear,
                            timeout);

        app_ha_activity_context.is_in_ear = is_in_ear;

        if (on == false) {
            app_hearing_aid_activity_pre_proc_operate_ha(APP_HEARING_AID_CHANGE_CAUSE_RACE_CMD, true, false);
            return false;
        }

        if (is_in_ear == true) {
            bool need_aws_sync = false;

            if (timeout > 0) {
                ui_shell_send_event(false,
                                    EVENT_PRIORITY_MIDDLE,
                                    EVENT_GROUP_UI_SHELL_HEARING_AID,
                                    APP_HEARING_AID_EVENT_ID_REQUEST_TO_CONTROL_HA,
                                    (void *)need_aws_sync,
                                    0,
                                    NULL,
                                    timeout);
            } else {
                app_hearing_aid_activity_pre_proc_operate_ha(APP_HEARING_AID_CHANGE_CAUSE_IN_EAR, true, false);
            }
        } else {
            app_hearing_aid_activity_disable_hearing_aid(false);
        }
    }
#endif /* MTK_IN_EAR_FEATURE_ENABLE */

#ifdef MTK_AWS_MCE_ENABLE
    if ((event_id == APPS_EVENTS_INTERACTION_RHO_END)
        || (event_id == APPS_EVENTS_INTERACTION_PARTNER_SWITCH_TO_AGENT)) {
        if (bt_device_manager_aws_local_info_get_role() == BT_AWS_MCE_ROLE_AGENT) {
            app_hearing_aid_activity_send_rssi_reading_event();
        } else if (bt_device_manager_aws_local_info_get_role() == BT_AWS_MCE_ROLE_PARTNER) {
            ui_shell_remove_event(EVENT_GROUP_UI_SHELL_HEARING_AID, APP_HEARING_AID_EVENT_ID_RSSI_READ);
        }
    }
#endif /* MTK_AWS_MCE_ENABLE */

    return false;
}

/*===================================================================================*/
/*                          HA EVENT HANDLING                                        */
/*===================================================================================*/
/**
 * @brief Handle the race command from SmartPhone.
 * If the AWS disconnected, execute the command locally and response directly.
 * If AWS connected, current is agent role, and need execute the command on both side
 * will send the race command to the partner side to execute.
 *
 * @param data Race command data pointer
 * @param data_len The race command data length
 */
#if 0
static void app_hearing_aid_activity_handle_race_cmd(void *data, size_t data_len)
{
    /**
     * @brief Agent handle race command from tool.
     */
    uint8_t execute_where = APP_HEARING_AID_EXECUTE_NONE;
    uint8_t get_response[APP_HEARING_AID_RESPONSE_MAX_LEN] = {0};
    uint16_t get_response_len = 0;
    app_hear_through_request_t *request = (app_hear_through_request_t *)data;
    bool set_result = false;

    if ((request->op_code != APP_HEAR_THROUGH_CMD_OP_CODE_SET)
        && (request->op_code != APP_HEAR_THROUGH_CMD_OP_CODE_GET)) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_race_cmd] Unknown code : %d",
                         1, request->op_code);
        return;
    }

    execute_where = app_hearing_aid_config_get_where_to_execute(request->op_code, request->op_type);

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_race_cmd] handle code : %s, type : %s, where : %s",
                     3,
                     app_hearing_aid_command_string[request->op_code],
                     app_hearing_aid_type_string[request->op_type],
                     app_hearing_aid_execute_where_string[execute_where]);

    if (execute_where == APP_HEARING_AID_EXECUTE_NONE) {
        return;
    }

#ifdef MTK_AWS_MCE_ENABLE

    bt_aws_mce_role_t current_role = bt_device_manager_aws_local_info_get_role();
    if (app_hearing_aid_aws_is_connected() == true) {
        if ((execute_where == APP_HEARING_AID_EXECUTE_ON_BOTH) && (current_role == BT_AWS_MCE_ROLE_AGENT)) {
            if (app_hearing_aid_aws_send_race_request((uint8_t *)data, data_len) == true) {
                return;
            }
        }
    }
#endif /* MTK_AWS_MCE_ENABLE */

    if (request->op_code == APP_HEAR_THROUGH_CMD_OP_CODE_GET) {
        app_hearing_aid_utils_handle_get_race_cmd(request, get_response, &get_response_len);

        APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_race_cmd] GET type : 0x%04x, get length : %d",
                         2, request->op_type, get_response_len);

        app_hear_through_race_cmd_send_get_response(request->op_type, get_response, get_response_len);
    } else {
        app_hearing_aid_utils_handle_set_race_cmd(request, &set_result);

        APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_race_cmd] SET type : 0x%04x, set result : %d",
                         2, request->op_type, set_result);

        app_hear_through_race_cmd_send_set_response(request->op_type, set_result);
    }
}
#endif /* 0 */

static void app_hearing_aid_activity_handle_request_to_control_ha(void *data, size_t data_len)
{
    bool need_aws_sync = (bool)data;

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_request_to_control_ha] Request to control HA, need_aws_sync : %d",
                        1,
                        need_aws_sync);

    app_hearing_aid_activity_pre_proc_operate_ha(APP_HEARING_AID_CHANGE_CAUSE_REQUEST, false, need_aws_sync);
}

static void app_hearing_aid_activity_handle_vp_streaming_state_change(bool streaming)
{
    bool user_switch_on = app_hearing_aid_utils_is_ha_user_switch_on();

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_vp_streaming_state_change] VP streaming : %d", 1, streaming);
    app_ha_activity_context.vp_streaming = streaming;

    if ((app_ha_activity_context.inited == false) || (user_switch_on == false)) {
#if APP_HEARING_AID_DEBUG_ENABLE
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_vp_streaming_state_change] Not ready to process VP state change event, inited : %d, user_switch : %d",
                            2,
                            app_ha_activity_context.inited,
                            user_switch_on);
#endif /* APP_HEARING_AID_DEBUG_ENABLE */
        return;
    }

#ifdef MTK_AWS_MCE_ENABLE
    app_hearing_aid_aws_set_vp_streaming_state(streaming);
#endif /* MTK_AWS_MCE_ENABLE */

#if 0
    bool on = app_hearing_aid_storage_get_vp_mix_switch();
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_vp_streaming_state_change] VP mix switch on : %d",
                        1,
                        on);

#ifdef MTK_AWS_MCE_ENABLE
    // if ((bt_device_manager_aws_local_info_get_role() == BT_AWS_MCE_ROLE_AGENT)
    //         || (app_hearing_aid_aws_is_connected() == false)) {
#endif /* MTK_AWS_MCE_ENABLE */
        app_hearing_aid_activity_pre_proc_operate_ha(APP_HEARING_AID_CHANGE_CAUSE_VP, false, true);
#ifdef MTK_AWS_MCE_ENABLE
    // }
#endif /* MTK_AWS_MCE_ENABLE */
#endif /* 0 */
}

static void app_hearing_aid_activity_handle_vp_streaming_begin(void *data, size_t data_len)
{
    app_hearing_aid_activity_handle_vp_streaming_state_change(true);
}

static void app_hearing_aid_activity_handle_vp_streaming_end(void *data, size_t data_len)
{
    app_hearing_aid_activity_handle_vp_streaming_state_change(false);
}

static void app_hearing_aid_activity_handle_rssi_reading(void *data, size_t data_len)
{
#ifdef MTK_AWS_MCE_ENABLE
    bool user_switch = app_hearing_aid_utils_is_ha_user_switch_on();
    if ((user_switch == false) || (app_ha_activity_context.inited == false)) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_rssi_reading] Not ready to process RSSI event, %d - %d",
                            2,
                            app_ha_activity_context.inited,
                            user_switch);
        return;
    }

    if (app_hearing_aid_aws_is_connected() == false) {
        APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_rssi_reading] AWS disconnected state, NO need to handle RSSI event", 0);
        return;
    }

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_rssi_reading] Start to read RSSI", 0);

    bt_bd_addr_t *local_addr = bt_device_manager_aws_local_info_get_local_address();//bt_device_manager_aws_local_info_get_peer_address();
    bt_bd_addr_t gap_addr = {0};
    memcpy(&gap_addr, local_addr, BT_BD_ADDR_LEN);
    bt_gap_connection_handle_t handle = bt_cm_get_gap_handle(gap_addr);
    bt_status_t status = bt_gap_read_raw_rssi(handle);
    if (status != BT_STATUS_SUCCESS) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_rssi_reading] Failed to get RAW RSSI, 0x%04x",
                         1,
                         status);
    }

    app_hearing_aid_activity_send_rssi_reading_event();
#endif /* MTK_AWS_MCE_ENABLE */
}

static void app_hearing_aid_activity_handle_mode_index_modification_req(void *data, size_t data_len)
{
    if ((data == NULL) || (data_len != sizeof(uint8_t))) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_mode_index_modification_req] Data error, 0x%04x, %d",
                         2,
                         data,
                         data_len);
        return;
    }

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_mode_index_modification_req] Modify mode index to : %d",
                     1,
                     ((uint8_t *)data)[0]);

    bool ret = false;

#ifdef MTK_AWS_MCE_ENABLE
    bool is_aws_connected = app_hearing_aid_aws_is_connected();
    if (is_aws_connected == true) {
        ret = app_hearing_aid_aws_send_operate_command(APP_HEARING_AID_OP_COMMAND_MODIFY_MODE_INDEX_REQ,
                                                        (uint8_t *)data,
                                                        data_len,
                                                        true,
                                                        true,
                                                        APP_HEARING_AID_SYNC_EVENT_DEFAULT_TIMEOUT);
    } else {
#endif /* MTK_AWS_MCE_ENABLE */
        ret = app_hearing_aid_utils_set_mode_index((uint8_t *)data);
#ifdef MTK_AWS_MCE_ENABLE
    }
#endif /* MTK_AWS_MCE_ENABLE */

    if (ret == true) {
        app_hear_through_race_cmd_send_notification(APP_HEARING_AID_CONFIG_TYPE_MODE_INDEX, data, data_len);
    }
}

static void app_hearing_aid_activity_handle_aea_off_vp(void *data, size_t data_len)
{
    bool user_switch = app_hearing_aid_utils_is_ha_user_switch_on();
    if ((user_switch == false) || (app_ha_activity_context.inited == false)) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_aea_off_vp] Not ready to process AEA OFF VP event, %d - %d",
                            2,
                            app_ha_activity_context.inited,
                            user_switch);
        return;
    }

    app_hearing_aid_activity_play_vp(VP_INDEX_DOORBELL, true);
}

#if 0
static void app_hearing_aid_activity_handle_init_to_control_ha(void *data, size_t data_len)
{
    app_hearing_aid_activity_pre_proc_operate_ha(APP_HEARING_AID_CHANGE_CAUSE_POWER_ON, false);
    app_ha_activity_context.power_on_ha_executed = true;
}
#endif

static void app_hearing_aid_activity_handle_init_to_play_power_on_vp(void *data, size_t data_len)
{
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_init_to_play_power_on_vp] Start to play power on VP", 0);
    voice_prompt_play_vp_power_on();
}

static void app_hearing_aid_activity_handle_rssi_power_off(void *data, size_t data_len)
{
    bool user_switch = app_hearing_aid_utils_is_ha_user_switch_on();
    if ((user_switch == false) || (app_ha_activity_context.inited == false)) {
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_rssi_power_off] Not ready to process RSS power off event, %d - %d",
                            2,
                            app_ha_activity_context.inited,
                            user_switch);
        return;
    }

    int8_t config_rssi = app_hear_through_storage_get_ha_rssi_threshold();

    if (config_rssi == 0x00) {
        return;
    }

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_handle_rssi_power_off] Handle RSSI power off, config_rssi : %d, partner_rssi : %d",
                     2,
                     config_rssi,
                     app_ha_activity_context.partner_rssi);

    if (app_ha_activity_context.partner_rssi > config_rssi) {

        app_ha_activity_context.is_powering_off = true;
        voice_prompt_play_vp_power_off(VOICE_PROMPT_CONTROL_MASK_SYNC);

#ifdef MTK_AWS_MCE_ENABLE
        app_hearing_aid_aws_send_operate_command(APP_HEARING_AID_OP_COMMAND_REQUEST_POWER_OFF,
                                                    NULL,
                                                    0,
                                                    false,
                                                    false,
                                                    0);
#endif /* MTK_AWS_MCE_ENABLE */

        ui_shell_send_event(false,
                            EVENT_PRIORITY_HIGHEST,
                            EVENT_GROUP_UI_SHELL_APP_INTERACTION,
                            APPS_EVENTS_INTERACTION_REQUEST_POWER_OFF,
                            NULL,
                            0,
                            NULL,
                            APP_HA_REQUEST_POWER_OFF_DELAY);
    }
}

/*===================================================================================*/
/*                              HANDLE SYNC EVENT                                    */
/*===================================================================================*/
#ifdef MTK_AWS_MCE_ENABLE
static void app_hearing_aid_activity_sync_handle_control_ha(uint8_t from_which_role, uint8_t current_role, void *data, size_t data_len)
{
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_sync_handle_control_ha][SYNC] Handle HA control, from where : 0x%02x, current_role : 0x%02x",
                        2,
                        from_which_role,
                        current_role);

    app_hearing_aid_aws_sync_operate_ha_t *operate_ha = (app_hearing_aid_aws_sync_operate_ha_t *)data;

    app_hearing_aid_activity_operate_ha(operate_ha->from_key,
                                        operate_ha->which,
                                        operate_ha->mix_table_need_execute,
                                        operate_ha->is_origin_on,
                                        operate_ha->mix_table_to_enable,
                                        operate_ha->drc_to_enable);
}

static void app_hearing_aid_activity_sync_handle_bf_switch(uint8_t from_which_role, uint8_t current_role, void *data, size_t data_len)
{
    bool enable = ((uint8_t *)data)[0];
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_sync_handle_bf_switch][SYNC] Handle BF switch, from where : 0x%02x, current_role : 0x%02x, enable : %d",
                        3,
                        from_which_role,
                        current_role,
                        enable);

    app_hearing_aid_key_handler_bf_mode_switch(enable, ((current_role == BT_AWS_MCE_ROLE_AGENT) ? true : false));
}

static void app_hearing_aid_activity_sync_handle_aea_switch(uint8_t from_which_role, uint8_t current_role, void *data, size_t data_len)
{
    bool enable = ((uint8_t *)data)[0];
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_sync_handle_aea_switch][SYNC] Handle AEA switch, from where : 0x%02x, current_role : 0x%02x, enable : %d",
                        3,
                        from_which_role,
                        current_role,
                        enable);

    app_hearing_aid_key_handler_aea_switch(enable, ((current_role == BT_AWS_MCE_ROLE_AGENT) ? true : false));
}

static void app_hearing_aid_activity_sync_handle_master_channel_switch(uint8_t from_which_role, uint8_t current_role, void *data, size_t data_len)
{
    uint8_t channel = ((uint8_t *)data)[0];
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_sync_handle_master_channel_switch][SYNC] Handle Mater MIC channel switch, from where : 0x%02x, current_role : 0x%02x, channel : %d",
                        3,
                        from_which_role,
                        current_role,
                        channel);
    app_hearing_aid_utils_master_mic_channel_switch_toggle(channel);
}

static void app_hearing_aid_activity_sync_handle_tunning_mode_switch(uint8_t from_which_role, uint8_t current_role, void *data, size_t data_len)
{
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_sync_handle_tunning_mode_switch][SYNC] Handle tunning mode switch, from_where : 0x%02x, current_role : 0x%02x",
                        2,
                        from_which_role,
                        current_role);

    if (current_role == from_which_role) {
        app_hearing_aid_utils_hearing_tuning_mode_toggle(false);
    } else {
        app_hearing_aid_utils_hearing_tuning_mode_toggle(true);
    }
}

static void app_hearing_aid_activity_sync_handle_change_level(uint8_t from_which_role, uint8_t current_role, void *data, size_t data_len)
{
    app_hearing_aid_aws_lr_index_change_t *change = (app_hearing_aid_aws_lr_index_change_t *)data;
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_sync_handle_change_level][SYNC] Handle level change, from where : 0x%02x, current_role : 0x%02x, l_index : %d, r_index : %d",
                        4,
                        from_which_role,
                        current_role,
                        change->l_index,
                        change->r_index);

    app_hearing_aid_key_handler_adjust_level(change->l_index, change->r_index, ((current_role == BT_AWS_MCE_ROLE_AGENT) ? true : false));
}

static void app_hearing_aid_activity_sync_handle_change_volume(uint8_t from_which_role, uint8_t current_role, void *data, size_t data_len)
{
    app_hearing_aid_aws_lr_index_with_direction_change_t *change = (app_hearing_aid_aws_lr_index_with_direction_change_t *)data;
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_sync_handle_change_volume][SYNC] Handle volume change, from where : 0x%02x, current_role : 0x%02x, l_index : %d, r_index : %d, up : %d",
                        5,
                        from_which_role,
                        current_role,
                        change->l_index,
                        change->r_index,
                        change->up);

    app_hearing_aid_key_handler_adjust_volume(change->l_index, change->r_index, change->up, ((current_role == BT_AWS_MCE_ROLE_AGENT) ? true : false));
}

static void app_hearing_aid_activity_sync_handle_change_mode(uint8_t from_which_role, uint8_t current_role, void *data, size_t data_len)
{
    uint8_t target_mode = ((uint8_t *)data)[0];
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_sync_handle_change_mode][SYNC] Handle mode change, from where : 0x%02x, current_role : 0x%02x, target_mode : %d",
                        3,
                        from_which_role,
                        current_role,
                        target_mode);

    app_hearing_aid_key_handler_adjust_mode(target_mode, ((current_role == BT_AWS_MCE_ROLE_AGENT) ? true : false));
}

static void app_hearing_aid_activity_sync_handle_change_mode_index(uint8_t from_which_role, uint8_t current_role, void *data, size_t data_len)
{
    uint8_t target_mode = ((uint8_t *)data)[0];
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_sync_handle_change_mode_index][SYNC] Handle mode index change, from where : 0x%02x, current_role : 0x%02x, target_mode : %d",
                        3,
                        from_which_role,
                        current_role,
                        target_mode);
    app_hearing_aid_utils_set_mode_index(&target_mode);
}

static void app_hearing_aid_activity_sync_handle_set_user_switch(uint8_t from_which_role, uint8_t current_role, void *data, size_t data_len)
{
    bool enable = ((uint8_t *)data)[0];
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_sync_handle_set_user_switch][SYNC] Handle user switch, from where : 0x%02x, current_role : 0x%02x, enable : %d",
                        3,
                        from_which_role,
                        current_role,
                        enable);

    app_hearing_aid_utils_set_user_switch(enable);

    // app_hearing_aid_activity_pre_proc_operate_ha(APP_HEARING_AID_CHANGE_CAUSE_REMOTE_USER_SWITCH, enable, false);
}

static void app_hearing_aid_activity_sync_handle_sync_vp_play(uint8_t from_which_role, uint8_t current_role, void *data, size_t data_len)
{
    app_hearing_aid_aws_sync_vp_play_t *sync_vp_play = (app_hearing_aid_aws_sync_vp_play_t *)data;

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_sync_handle_sync_vp_play][SYNC] Handle VP play, from where : 0x%02x, current_role : 0x%02x, vp_index : %d",
                        3,
                        from_which_role,
                        current_role,
                        sync_vp_play->vp_index);

    app_hearing_aid_activity_play_vp(sync_vp_play->vp_index, true);
}

static void app_hearing_aid_activity_sync_handle_power_off_request(uint8_t from_which_role, uint8_t current_role, void *data, size_t data_len)
{
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_sync_handle_power_off_request][SYNC] Handle power off request, from where : 0x%02x, current_role : 0x%02x",
                        2,
                        from_which_role,
                        current_role);

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

static void app_hearing_aid_activity_sync_handle_race_cmd_request(uint8_t from_which_role, uint8_t current_role, void *data, size_t data_len)
{
    app_hear_through_request_t *request = (app_hear_through_request_t *)data;

    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_sync_handle_race_cmd_request][SYNC] Handle race cmd, from_where : 0x%02x, current_role : 0x%02x, code : 0x%02x, type : 0x%04x",
                        4,
                        from_which_role,
                        current_role,
                        request->op_code,
                        request->op_type);

    if (request->op_code == APP_HEAR_THROUGH_CMD_OP_CODE_GET) {
        uint8_t get_response[APP_HEARING_AID_RESPONSE_MAX_LEN] = {0};
        uint16_t get_response_len = 0;

        if (request->op_type == APP_HEARING_AID_CONFIG_TYPE_FEEDBACK_DETECTION) {
            if (from_which_role == BT_AWS_MCE_ROLE_PARTNER) {
                app_feedback_detection_directly = true;
            }
        } else {
            app_hearing_aid_activity_handle_get_race_cmd(data, data_len, get_response, &get_response_len);

            if (from_which_role == bt_device_manager_aws_local_info_get_role()) {
                app_hear_through_race_cmd_send_get_response(request->op_type, get_response, get_response_len);
            }
        }
    } else {
        bool result = app_hearing_aid_activity_handle_set_race_cmd(data, data_len);

        if (from_which_role == bt_device_manager_aws_local_info_get_role()) {
            app_hear_through_race_cmd_send_set_response(request->op_type, result);
        }
    }
}
#endif /* MTK_AWS_MCE_ENABLE */

typedef void (*ha_event_handler)(void *data, size_t data_len);

static ha_event_handler app_hearing_aid_ha_event_handler[] = {
    NULL,                                                           // 0x00
    NULL,// app_hearing_aid_activity_handle_race_connected,         // 0x01
    NULL,// app_hearing_aid_activity_handle_race_disconnected,      // 0x02
    NULL,// app_hearing_aid_activity_handle_advertising_timeout,    // 0x03
    app_hearing_aid_activity_handle_request_to_control_ha,          // 0x04
    app_hearing_aid_activity_handle_vp_streaming_begin,             // 0x05
    app_hearing_aid_activity_handle_vp_streaming_end,               // 0x06
    app_hearing_aid_activity_handle_rssi_reading,                   // 0x07
    app_hearing_aid_activity_handle_mode_index_modification_req,    // 0x08
    app_hearing_aid_activity_handle_aea_off_vp,                     // 0x09
    NULL, // app_hearing_aid_activity_handle_init_to_control_ha,    // 0x0A
    app_hearing_aid_activity_handle_init_to_play_power_on_vp,       // 0x0B
    app_hearing_aid_activity_handle_rssi_power_off,                 // 0x0C
};

#ifdef MTK_AWS_MCE_ENABLE
typedef void (*ha_sync_event_handler)(uint8_t from_which_role, uint8_t current_role, void *data, size_t data_len);

static ha_sync_event_handler app_hearing_aid_sync_event_handler[] = {
    NULL,                                                           // 0x00
    app_hearing_aid_activity_sync_handle_control_ha,                // 0x01
    app_hearing_aid_activity_sync_handle_bf_switch,                 // 0x02
    app_hearing_aid_activity_sync_handle_aea_switch,                // 0x03
    app_hearing_aid_activity_sync_handle_master_channel_switch,     // 0x04
    app_hearing_aid_activity_sync_handle_tunning_mode_switch,       // 0x05
    app_hearing_aid_activity_sync_handle_change_level,              // 0x06
    app_hearing_aid_activity_sync_handle_change_volume,             // 0x07
    app_hearing_aid_activity_sync_handle_change_mode,               // 0x08
    app_hearing_aid_activity_sync_handle_change_mode_index,         // 0x09
    app_hearing_aid_activity_sync_handle_set_user_switch,           // 0x0A
    app_hearing_aid_activity_sync_handle_sync_vp_play,              // 0x0B
    app_hearing_aid_activity_sync_handle_power_off_request,         // 0x0C
    app_hearing_aid_activity_sync_handle_race_cmd_request,          // 0x0D
    NULL,                                                           // 0x0E
};
#endif /* MTK_AWS_MCE_ENABLE */

/**
 * @brief Process HA event (internal)
 *
 * @param event_id
 * @param extra_data
 * @param data_len
 * @return true
 * @return false
 */
static bool app_hearing_aid_activity_proc_ha_event(uint32_t event_id, void *extra_data, size_t data_len)
{
    APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_ha_event] event id : 0x%04x",
                     1,
                     event_id);

    if (event_id < sizeof(app_hearing_aid_ha_event_handler)) {
        if (app_hearing_aid_ha_event_handler[event_id] != NULL) {
            app_hearing_aid_ha_event_handler[event_id](extra_data, data_len);
        }
    }

#ifdef MTK_AWS_MCE_ENABLE
    if (event_id >=APP_HEARING_AID_EVENT_SYNC_BASE) {
        uint8_t from_where = ((uint8_t *)extra_data)[0];
        bt_aws_mce_role_t cur_role = bt_device_manager_aws_local_info_get_role();
        if (app_hearing_aid_sync_event_handler[event_id - APP_HEARING_AID_EVENT_SYNC_BASE] != NULL) {
            app_hearing_aid_sync_event_handler[event_id - APP_HEARING_AID_EVENT_SYNC_BASE](from_where, cur_role, extra_data + 1, data_len - 1);
        }
    }
#endif /* MTK_AWS_MCE_ENABLE */

    return true;
}

/**
 * @brief Process connection manager event.
 * Handle AWS connected or disconnected.
 * When AWS connected, agent need sync the stored nvkey to the partner side.
 *
 * @param event_id
 * @param extra_data
 * @param data_len
 * @return true
 * @return false
 */
static bool app_hearing_aid_activity_proc_cm_event(uint32_t event_id,
                                                   void *extra_data,
                                                   size_t data_len)
{
    bool user_switch = app_hearing_aid_utils_is_ha_user_switch_on();
    if ((user_switch == false) || (app_ha_activity_context.inited == false)) {
#if APP_HEARING_AID_DEBUG_ENABLE
        APPS_LOG_MSGID_E(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_cm_event] Not ready to process CM event, %d - %d, event_id : 0x%04x",
                            3,
                            app_ha_activity_context.inited,
                            user_switch,
                            event_id);
#endif /* APP_HEARING_AID_DEBUG_ENABLE */
        return false;
    }

    if (event_id == BT_CM_EVENT_REMOTE_INFO_UPDATE) {

        bt_cm_remote_info_update_ind_t *remote_update = (bt_cm_remote_info_update_ind_t *)extra_data;

        if (remote_update->pre_connected_service == remote_update->connected_service) {
            return false;
        }

#ifdef MTK_AWS_MCE_ENABLE
        bt_aws_mce_role_t device_aws_role = bt_device_manager_aws_local_info_get_role();
        if (!(BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & remote_update->pre_connected_service)
            && (BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & remote_update->connected_service)) {
            // AWS connected handler
            APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_cm_event] AWS Connected, Role : 0x%02x", 1, device_aws_role);

            if (device_aws_role == BT_AWS_MCE_ROLE_AGENT) {
                app_hearing_aid_aws_sync_agent_configuration_to_partner();

                app_hearing_aid_activity_send_rssi_reading_event();
            }

        } else if (!(BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & remote_update->connected_service)
                   && (BT_CM_PROFILE_SERVICE_MASK(BT_CM_PROFILE_SERVICE_AWS) & remote_update->pre_connected_service)) {
            // AWS disconnected handler
            APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_cm_event] AWS Disconnected", 0);

            ui_shell_remove_event(EVENT_GROUP_UI_SHELL_HEARING_AID, APP_HEARING_AID_EVENT_ID_RSSI_READ);
        }
#endif /* MTK_AWS_MCE_ENABLE */
    }

    return false;
}

static bool app_hearing_aid_activity_proc_dm_event(uint32_t event_id,
                                                   void *extra_data,
                                                   size_t data_len)
{
    bt_device_manager_power_event_t evt;
    bt_device_manager_power_status_t status;
    bt_event_get_bt_dm_event_and_status(event_id, &evt, &status);

    if ((status == BT_DEVICE_MANAGER_POWER_STATUS_SUCCESS) && (evt == BT_DEVICE_MANAGER_POWER_EVT_STANDBY_COMPLETE)) {
        APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_dm_event] BT Powering off", 0);

        app_ha_activity_context.is_powering_off = true;

        app_hearing_aid_activity_disable_hearing_aid(false);
        app_hearing_aid_utils_save_user_settings();
        app_hearing_aid_storage_save_configuration();
    }

    return false;
}


#ifdef MTK_AWS_MCE_ENABLE
/**
 * @brief Process the AWS data.
 *
 * @param event_id
 * @param extra_data
 * @param data_len
 * @return true
 * @return false
 */
static bool app_hearing_aid_activity_proc_aws_data(uint32_t event_id,
                                                   void *extra_data,
                                                   size_t data_len)
{
    bt_aws_mce_report_info_t *aws_data_ind = (bt_aws_mce_report_info_t *)extra_data;

    uint32_t extra_event_group;
    uint32_t extra_event_id;

    void *aws_extra_data = NULL;
    uint32_t aws_extra_data_len = 0;

    apps_aws_sync_event_decode_extra(aws_data_ind, &extra_event_group, &extra_event_id, &aws_extra_data, &aws_extra_data_len);

    if (extra_event_group == EVENT_GROUP_UI_SHELL_HEARING_AID) {
        app_hearing_aid_aws_process_data(extra_event_id, (uint8_t *)aws_extra_data, aws_extra_data_len);
        return true;
    } else if (extra_event_group == EVENT_GROUP_UI_SHELL_KEY) {
        return app_hearing_aid_key_handler_processing(extra_event_id);
    }

    return false;
}
#endif /* MTK_AWS_MCE_ENABLE */

#if 0
static bool app_hearing_aid_activity_proc_smart_charger_case_event(uint32_t event_id,
                                                                   void *extra_data,
                                                                   size_t data_len)
{
    if (event_id == SMCHARGER_EVENT_NOTIFY_ACTION) {
        app_smcharger_public_event_para_t *para = (app_smcharger_public_event_para_t *)extra_data;
        if (para->action == SMCHARGER_CHARGER_OUT_ACTION) {
            APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_smart_charger_case_event][SmartCharger] Charger out, Turn on hear through", 0);
            app_hearing_aid_activity_initialization();
        }
        if (para->action == SMCHARGER_CHARGER_IN_ACTION) {
            APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_smart_charger_case_event][SmartCharger] Charger in, Turn on hear through", 0);
            app_hearing_aid_activity_de_initialization();
        }
    }
    return false;
}
#endif /* 0 */

#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
static bool app_hearing_aid_activity_proc_battery_event(uint32_t event_id,
                                                        void *extra_data,
                                                        size_t data_len)
{
    if (event_id == APPS_EVENTS_BATTERY_CHARGER_EXIST_CHANGE) {
        bool charger_in = (bool)extra_data;
        APPS_LOG_MSGID_I(APP_HA_ACTIVITY_TAG"[app_hearing_aid_activity_proc_battery_event], charger_exist change %d->%d, inited : %d",
                         3,
                         app_ha_activity_context.is_charger_in,
                         charger_in,
                         app_ha_activity_context.inited);

        if ((app_ha_activity_context.is_charger_in == false) && (charger_in == true)) {
            app_ha_activity_context.is_charger_in = true;
            ui_shell_remove_event(EVENT_GROUP_UI_SHELL_HEARING_AID, APP_HEARING_AID_EVENT_ID_INIT_TO_PLAY_POWER_ON_VP);

            // if (app_ha_activity_context.inited == true) {
            //     app_hearing_aid_activity_de_initialization();
            // }
        }
        if ((app_ha_activity_context.is_charger_in == true) && (charger_in == false)) {
            app_ha_activity_context.is_charger_in = false;
            app_ha_activity_context.power_on_ha_executed = false;
            // if (app_ha_activity_context.inited == false) {
            //     app_hearing_aid_activity_initialization();
            // }

#ifdef MTK_IN_EAR_FEATURE_ENABLE
            app_ha_activity_context.is_in_ear = app_in_ear_get_own_state();
#endif /* MTK_IN_EAR_FEATURE_ENABLE */
            /**
             * @brief When out of case, play power on VP with some delay to avoid HA initialization.
             */
            ui_shell_send_event(false,
                                EVENT_PRIORITY_MIDDLE,
                                EVENT_GROUP_UI_SHELL_HEARING_AID,
                                APP_HEARING_AID_EVENT_ID_INIT_TO_PLAY_POWER_ON_VP,
                                NULL,
                                0,
                                NULL,
                                APP_HA_POWER_ON_VP_DELAY_TIME);
        }
    }
    return false;
}
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */

typedef struct {
    uint32_t            event_group;
    bool (*handler)(uint32_t event_id, void *extra_data, size_t data_len);
} app_ha_activity_event_handler_t;

const app_ha_activity_event_handler_t app_ha_activity_event_handler[] = {
    {
        .event_group = EVENT_GROUP_UI_SHELL_SYSTEM,
        .handler = app_hearing_aid_activity_proc_sys_event,
    },
#ifdef MTK_AWS_MCE_ENABLE
    {
        .event_group = EVENT_GROUP_UI_SHELL_AWS_DATA,
        .handler = app_hearing_aid_activity_proc_aws_data,
    },
#endif /* MTK_AWS_MCE_ENABLE */
    {
        .event_group = EVENT_GROUP_UI_SHELL_HEARING_AID,
        .handler = app_hearing_aid_activity_proc_ha_event,
    },
    {
        .event_group = EVENT_GROUP_UI_SHELL_BT_CONN_MANAGER,
        .handler = app_hearing_aid_activity_proc_cm_event,
    },
    {
        .event_group = EVENT_GROUP_UI_SHELL_BT_DEVICE_MANAGER,
        .handler = app_hearing_aid_activity_proc_dm_event,
    },
    {
        .event_group = EVENT_GROUP_UI_SHELL_KEY,
        .handler = app_hearing_aid_activity_proc_key_event,
    },
    {
        .event_group = EVENT_GROUP_UI_SHELL_BT_SINK,
        .handler = app_hearing_aid_activity_proc_bt_sink_event,
    },
    {
        .event_group = EVENT_GROUP_UI_SHELL_APP_INTERACTION,
        .handler = app_hearing_aid_activity_proc_app_interaction,
    },
#if 0
    {
        .event_group = EVENT_GROUP_UI_SHELL_CHARGER_CASE,
        .handler = app_hearing_aid_activity_proc_smart_charger_case_event,
    },
#endif /* 0 */
#ifdef MTK_BATTERY_MANAGEMENT_ENABLE
    {
        .event_group = EVENT_GROUP_UI_SHELL_BATTERY,
        .handler = app_hearing_aid_activity_proc_battery_event,
    },
#endif /* MTK_BATTERY_MANAGEMENT_ENABLE */
};

#define app_ha_activity_event_handler_COUNT      (sizeof(app_ha_activity_event_handler) / sizeof(app_ha_activity_event_handler_t))

bool app_hearing_aid_activity_proc(ui_shell_activity_t *self,
                                   uint32_t event_group,
                                   uint32_t event_id,
                                   void *extra_data,
                                   size_t data_len)
{
    uint8_t event_handler_index = 0;

    for (event_handler_index = 0; event_handler_index < app_ha_activity_event_handler_COUNT; event_handler_index++) {
        if ((app_ha_activity_event_handler[event_handler_index].event_group == event_group)
            && (app_ha_activity_event_handler[event_handler_index].handler != NULL)) {
            return app_ha_activity_event_handler[event_handler_index].handler(event_id, extra_data, data_len);
        }
    }
    return false;
}


#endif /* AIR_HEARING_AID_ENABLE || AIR_HEARTHROUGH_PSAP_ENABLE */


