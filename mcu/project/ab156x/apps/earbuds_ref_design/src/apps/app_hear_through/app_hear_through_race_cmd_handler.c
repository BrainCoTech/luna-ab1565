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


#include "app_hear_through_race_cmd_handler.h"
#include "app_hear_through_activity.h"
#include "apps_events_event_group.h"
#include "apps_aws_sync_event.h"
#include "race_cmd.h"
#include "race_xport.h"
#include "apps_debug.h"
#include "assert.h"
#include "ui_shell_manager.h"

#ifdef AIR_HEARTHROUGH_MAIN_ENABLE

#define APP_HEAR_THROUGH_RACE_CMD_HANDLER_TAG        "[HearThrough][RACE_CMD_HANDLER]"

typedef struct {
    uint8_t status;
    uint8_t code;
    uint16_t type;
    uint8_t payload[0];
} __attribute__((packed)) hear_through_response_t;

#define HEAR_THROUGH_COMMAND_LEN         (sizeof(hear_through_response_t))
#define APP_HEAR_THROUGH_RACE_ID_LEN     (sizeof(uint16_t))

typedef struct {
    uint8_t             channel_id;
} app_hear_through_race_cmd_context_t;

app_hear_through_race_cmd_context_t   app_hear_through_race_cmd_context;

void app_hear_through_send_command(uint8_t race_type, hear_through_response_t *cmd, uint8_t *data, uint16_t data_len)
{
    uint16_t cmd_len = HEAR_THROUGH_COMMAND_LEN + data_len;

    void *response_packet = RACE_ClaimPacket(race_type,
                                             RACE_ID_APP_HEAR_THROUGH_CONFIG,
                                             cmd_len,
                                             app_hear_through_race_cmd_context.channel_id);

    if (response_packet == NULL) {
        APPS_LOG_MSGID_E(APP_HEAR_THROUGH_RACE_CMD_HANDLER_TAG"[app_hear_through_send_command] failed to allocate response packet", 0);
        return;
    }

    hear_through_response_t *response = (hear_through_response_t *)response_packet;
    memcpy(response, cmd, HEAR_THROUGH_COMMAND_LEN);

    if ((data != NULL) && (data_len != 0)) {
        memcpy(response->payload, data, data_len);
    }

    race_flush_packet(response_packet, app_hear_through_race_cmd_context.channel_id);
}

void app_hear_through_race_cmd_send_get_response(uint16_t config_type, uint8_t *data, uint16_t data_len)
{
#if 0
    if ((data == NULL) || (data_len == 0)) {
        APPS_LOG_MSGID_E(APP_HEAR_THROUGH_RACE_CMD_HANDLER_TAG"[app_hear_through_race_cmd_send_get_response] - [ERROR] type : 0x%04x, result : 0x%x, result_len : %d",
                         3,
                         config_type,
                         data,
                         data_len);
        return;
    }
#endif
    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_RACE_CMD_HANDLER_TAG"[app_hear_through_race_cmd_send_get_response] type : 0x%04x, data : 0x%x, result_len : %d",
                     3,
                     config_type,
                     data,
                     data_len);

    hear_through_response_t cmd = {0};

    cmd.status = RACE_ERRCODE_FAIL;
    cmd.code = APP_HEAR_THROUGH_CMD_OP_CODE_GET;
    cmd.type = config_type;
    if (data_len > 0) {
        cmd.status = RACE_ERRCODE_SUCCESS;
    }

    app_hear_through_send_command(RACE_TYPE_RESPONSE, &cmd, data, data_len);
}

void app_hear_through_race_cmd_send_set_response(uint16_t config_type, bool success)
{

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_RACE_CMD_HANDLER_TAG"[app_hear_through_race_cmd_send_set_response] type : 0x%04x, execute result : %d",
                     2,
                     config_type,
                     success);

    hear_through_response_t cmd = {0};

    cmd.status = (success == true) ? RACE_ERRCODE_SUCCESS : RACE_ERRCODE_FAIL;
    cmd.code = APP_HEAR_THROUGH_CMD_OP_CODE_SET;
    cmd.type = config_type;

    app_hear_through_send_command(RACE_TYPE_RESPONSE, &cmd, NULL, 0);
}

void app_hear_through_race_cmd_send_notification(uint16_t config_type, uint8_t *data, uint16_t data_len)
{

    if ((data == NULL) || (data_len == 0)) {
        APPS_LOG_MSGID_E(APP_HEAR_THROUGH_RACE_CMD_HANDLER_TAG"[app_hear_through_race_cmd_send_notification] - [ERROR] [Notify] type : 0x%04x, data : 0x%x, data_len : %d",
                         3,
                         config_type,
                         data,
                         data_len);
        return;
    }

    APPS_LOG_MSGID_I(APP_HEAR_THROUGH_RACE_CMD_HANDLER_TAG"[app_hear_through_race_cmd_send_notification] - [Notify] type : 0x%04x, data : 0x%x, data_len : %d",
                     3,
                     config_type,
                     data,
                     data_len);

    typedef struct {
        uint16_t type;
        uint8_t payload[0];
    } __attribute__((packed)) hear_through_notification_t;

    uint16_t notify_len = sizeof(hear_through_notification_t) + data_len;

    void *response_packet = RACE_ClaimPacket(RACE_TYPE_NOTIFICATION,
                                             RACE_ID_APP_HEAR_THROUGH_CONFIG,
                                             notify_len,
                                             app_hear_through_race_cmd_context.channel_id);

    if (response_packet == NULL) {
        APPS_LOG_MSGID_E(APP_HEAR_THROUGH_RACE_CMD_HANDLER_TAG"[app_hear_through_race_cmd_send_notification] failed to allocate response packet", 0);
        return;
    }

    hear_through_notification_t *notify = (hear_through_notification_t *)response_packet;
    notify->type = config_type;
    memcpy(notify->payload, data, data_len);

    race_flush_packet(response_packet, app_hear_through_race_cmd_context.channel_id);
}

#define APP_RACE_CMD_HEADER_LENGTH       6

void *app_hear_through_race_cmd_handler(ptr_race_pkt_t p_race_package, uint16_t length, uint8_t channel_id)
{
    if (p_race_package->hdr.id != RACE_ID_APP_HEAR_THROUGH_CONFIG) {
        APPS_LOG_MSGID_E(APP_HEAR_THROUGH_RACE_CMD_HANDLER_TAG"[app_hear_through_race_cmd_handler] NOT Hear Through event, 0x%x", 1, p_race_package->hdr.id);
        return NULL;
    }

    app_hear_through_race_cmd_context.channel_id = channel_id;

    void *event_param = pvPortMalloc(length - APP_HEAR_THROUGH_RACE_ID_LEN);

    if (event_param != NULL) {
        memcpy(event_param, p_race_package->payload, (length - APP_HEAR_THROUGH_RACE_ID_LEN));

        ui_shell_send_event(false,
                            EVENT_PRIORITY_MIDDLE,
                            EVENT_GROUP_UI_SHELL_HEAR_THROUGH,
                            APP_HEAR_THROUGH_EVENT_ID_RACE_CMD,
                            event_param,
                            (length - APP_HEAR_THROUGH_RACE_ID_LEN),
                            NULL,
                            0);
    } else {
        APPS_LOG_MSGID_E(APP_HEAR_THROUGH_RACE_CMD_HANDLER_TAG"[app_hear_through_race_cmd_handler] Failed to allocate buffer", 0);
    }

    return NULL;
}


#endif /* AIR_HEARTHROUGH_MAIN_ENABLE */


