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

#include "bt_source_srv_common.h"
#include "bt_source_srv_utils.h"
#ifdef AIR_SOURCE_SRV_HFP_ENABLE
#include "bt_source_srv_call.h"
#endif
#ifdef AIR_SOURCE_SRV_MUSIC_ENABLE
#include "bt_source_srv_avrcp.h"
#include "bt_source_srv_music_pseduo_dev.h"
#endif

#include "audio_src_srv.h"

#define BT_SOURCE_SRV_COMMON_PORT_MAX                          BT_SOURCE_SRV_PORT_I2S_IN

#define BT_SOURCE_SRV_COMMON_ACTION_MASK                      0x000000FF

#define BT_SOURCE_SRV_COMMON_AUDIO_PORT_UPDATE_PORT            0x0001
#define BT_SOURCE_SRV_COMMON_AUDIO_PORT_RESET_PORT             0x0002
#define BT_SOURCE_SRV_COMMON_AUDIO_PORT_UPDATE_SAMPLE_RATE     0x0003
#define BT_SOURCE_SRV_COMMON_AUDIO_PORT_UPDATE_SAMPLE_SIZE     0x0004
#define BT_SOURCE_SRV_COMMON_AUDIO_PORT_UPDATE_SAMPLE_CHANNEL  0x0005
typedef uint16_t bt_source_srv_common_audio_port_update_t;

typedef bt_status_t (*bt_source_srv_common_action_handler_t)(void *parameter, uint32_t length);

static bt_source_srv_common_audio_port_context_t g_common_port_context[BT_SOURCE_SRV_COMMON_PORT_MAX] = {0};

/* common action handle */
static bt_status_t bt_source_srv_common_handle_audio_port(void *parameter, uint32_t length);
static bt_status_t bt_source_srv_common_handle_audio_sample_rate(void *parameter, uint32_t length);
static bt_status_t bt_source_srv_common_handle_audio_sample_size(void *parameter, uint32_t length);
static bt_status_t bt_source_srv_common_handle_audio_sample_channel(void *parameter, uint32_t length);
static bt_status_t bt_source_srv_common_handle_mute(void *parameter, uint32_t length);
static bt_status_t bt_source_srv_common_handle_unmute(void *parameter, uint32_t length);
static bt_status_t bt_source_srv_common_handle_volume_up(void *parameter, uint32_t length);
static bt_status_t bt_source_srv_common_handle_volume_down(void *parameter, uint32_t length);
static bt_status_t bt_source_srv_common_handle_volume_change(void *parameter, uint32_t length);

static const bt_source_srv_common_action_handler_t g_handle_common_action_table[] = {
    NULL,
    bt_source_srv_common_handle_audio_port,
    bt_source_srv_common_handle_audio_sample_rate,
    bt_source_srv_common_handle_audio_sample_size,
    bt_source_srv_common_handle_audio_sample_channel,
    bt_source_srv_common_handle_mute,
    bt_source_srv_common_handle_unmute,
    bt_source_srv_common_handle_volume_up,
    bt_source_srv_common_handle_volume_down,
    bt_source_srv_common_handle_volume_change
};

#ifdef AIR_SOURCE_SRV_HFP_ENABLE
static bt_source_srv_t bt_source_srv_common_get_playing_device(void)
{
    audio_src_srv_resource_manager_handle_t *audio_src = audio_src_srv_resource_manager_get_current_running_handle(AUDIO_SRC_SRV_RESOURCE_TYPE_BT_SOURCE);
    if ((audio_src != NULL) && (bt_source_srv_memcmp(audio_src->handle_name, AUDIO_SRC_SRV_RESOURCE_TYPE_BT_SOURCE_USER_HFP, \
                                strlen(AUDIO_SRC_SRV_RESOURCE_TYPE_BT_SOURCE_USER_HFP)) == 0)) {
        return BT_SOURCE_SRV_TYPE_HFP;
    }
    return BT_SOURCE_SRV_TYPE_NONE;
}
#endif

static void bt_source_srv_common_audio_port_reset(bt_source_srv_common_audio_port_context_t *port_context)
{
    bt_source_srv_memset(port_context, 0, sizeof(bt_source_srv_common_audio_port_context_t));
    /* default sample rate */
    port_context->sample_rate = 48000;
}

static bt_source_srv_common_audio_port_context_t *bt_source_srv_common_audio_get_port_context(bt_source_srv_port_t port)
{
    uint32_t i = 0;
    for (i = 0; i < BT_SOURCE_SRV_COMMON_PORT_MAX; i++) {
        if (g_common_port_context[i].port == port) {
            return &g_common_port_context[i];
        }
    }

    for (i = 0; i < BT_SOURCE_SRV_COMMON_PORT_MAX; i++) {
        if (g_common_port_context[i].port == BT_SOURCE_SRV_PORT_NONE) {
            return &g_common_port_context[i];
        }
    }

    LOG_MSGID_E(source_srv, "[SOURCE][COMMON] get audio port fail by port = %02x", 1, port);
    return NULL;
}

bt_status_t bt_source_srv_common_init(void)
{
    uint32_t i = 0;
    for (i = 0; i < BT_SOURCE_SRV_COMMON_PORT_MAX; i++) {
        bt_source_srv_common_audio_port_reset(&g_common_port_context[i]);
    }
    return BT_STATUS_SUCCESS;
}

bool bt_source_srv_common_audio_port_is_valid(bt_source_srv_port_t port)
{
    bt_source_srv_common_audio_port_context_t *port_context = NULL;
    for (uint32_t i = 0; i < BT_SOURCE_SRV_COMMON_PORT_MAX; i++) {
        if (g_common_port_context[i].port == port) {
            port_context = &g_common_port_context[i];
            break;
        }
    }

    if (port_context == NULL) {
        LOG_MSGID_W(source_srv, "[SOURCE][COMMON] audio port = %02x is invalid not find", 1, port);
        return false;
    }

    if ((port_context->sample_rate == 0) || (port_context->sample_channel == 0) ||
            (port_context->sample_size == 0)) {
        LOG_MSGID_W(source_srv, "[SOURCE][COMMON] audio port = %02x is invalid", 1, port_context->port);
        return false;
    }
    return true;
}

bt_status_t bt_source_srv_common_audio_find_port_context(bt_source_srv_port_t port, bt_source_srv_common_audio_port_context_t *context)
{
    uint32_t i = 0;
    for (i = 0; i < BT_SOURCE_SRV_COMMON_PORT_MAX; i++) {
        if (g_common_port_context[i].port == port) {
            bt_source_srv_memcpy(context, &g_common_port_context[i], sizeof(bt_source_srv_common_audio_port_context_t));
            return BT_STATUS_SUCCESS;
        }
    }

    LOG_MSGID_E(source_srv, "[SOURCE][COMMON] find audio port fail by port = %02x", 1, port);
    return BT_STATUS_FAIL;
}

bt_status_t bt_source_srv_common_audio_port_update(bt_source_srv_common_audio_port_context_t *context, bt_source_srv_common_audio_port_update_t type)
{
    bt_source_srv_common_audio_port_context_t *audio_port_context = NULL;
    bt_source_srv_common_port_action_t common_port_action = BT_SOURCE_SRV_COMMON_PORT_ACTION_NONE;
    bool is_port_parameter_update = false;
    bool is_previous_port_valid = false;

    audio_port_context = bt_source_srv_common_audio_get_port_context(context->port);
    if (audio_port_context == NULL) {
        return BT_STATUS_FAIL;
    }
    LOG_MSGID_I(source_srv, "[SOURCE][COMMON] update type = %02x, audio port = %02x", 2, type, context->port);

    if (bt_source_srv_common_audio_port_is_valid(context->port)) {
        is_previous_port_valid = true;
    }

    switch (type) {
        case BT_SOURCE_SRV_COMMON_AUDIO_PORT_RESET_PORT: {
            bt_source_srv_common_audio_port_reset(audio_port_context);
            common_port_action = BT_SOURCE_SRV_CALL_PORT_ACTION_CLOSE;
        }
        break;
        case BT_SOURCE_SRV_COMMON_AUDIO_PORT_UPDATE_SAMPLE_RATE: {
            if (audio_port_context->sample_rate != context->sample_rate) {
                is_port_parameter_update = true;
            }
            audio_port_context->sample_rate = context->sample_rate;
        }
        break;
        case BT_SOURCE_SRV_COMMON_AUDIO_PORT_UPDATE_SAMPLE_SIZE: {
            if (audio_port_context->sample_rate != context->sample_rate) {
                is_port_parameter_update = true;
            }
            audio_port_context->sample_size = context->sample_size;
        }
        break;
        case BT_SOURCE_SRV_COMMON_AUDIO_PORT_UPDATE_SAMPLE_CHANNEL: {
            if (audio_port_context->sample_rate != context->sample_rate) {
                is_port_parameter_update = true;
            }
            audio_port_context->sample_channel = context->sample_channel;
        }
        break;
        default:
            break;
    }

    if (type != BT_SOURCE_SRV_COMMON_AUDIO_PORT_RESET_PORT) {
        audio_port_context->port = context->port;
    }

    if (is_port_parameter_update && (bt_source_srv_common_audio_port_is_valid(context->port))) {
        common_port_action = is_previous_port_valid ? BT_SOURCE_SRV_COMMON_PORT_ACTION_UPDATE : BT_SOURCE_SRV_COMMON_PORT_ACTION_OPEN;
    }

    LOG_MSGID_I(source_srv, "[SOURCE][COMMON] audio port update sample rate = %02x, sample size = %02x, sample channel = %02x, common_port_action = %d", 4,
                audio_port_context->sample_rate, audio_port_context->sample_size, audio_port_context->sample_channel, common_port_action);

    if (common_port_action != BT_SOURCE_SRV_COMMON_PORT_ACTION_NONE) {
        /* port open complete and parameter update */
#ifdef AIR_SOURCE_SRV_HFP_ENABLE
        bt_source_srv_call_audio_port_update(context->port, common_port_action);
#endif
#ifdef AIR_SOURCE_SRV_MUSIC_ENABLE
        bt_source_srv_music_audio_port_update(context->port);
#endif
    }

    return BT_STATUS_SUCCESS;
}

static bt_status_t bt_source_srv_common_handle_audio_port(void *parameter, uint32_t length)
{
    bt_source_srv_audio_port_t *audio_port = (bt_source_srv_audio_port_t *)parameter;

    bt_source_srv_common_audio_port_context_t context = {
        .port = audio_port->port,
    };

    if (audio_port->state == BT_SOURCE_SRV_AUDIO_PORT_STATE_DISABLE) {
        return bt_source_srv_common_audio_port_update(&context, BT_SOURCE_SRV_COMMON_AUDIO_PORT_RESET_PORT);
    }
    return bt_source_srv_common_audio_port_update(&context, BT_SOURCE_SRV_COMMON_AUDIO_PORT_UPDATE_PORT);
}

static bt_status_t bt_source_srv_common_handle_audio_sample_rate(void *parameter, uint32_t length)
{
    bt_source_srv_audio_sample_rate_t *audio_sample_rate = (bt_source_srv_audio_sample_rate_t *)parameter;

    bt_source_srv_common_audio_port_context_t context = {
        .port = audio_sample_rate->port,
        .sample_rate = audio_sample_rate->sample_rate
    };
    return bt_source_srv_common_audio_port_update(&context, BT_SOURCE_SRV_COMMON_AUDIO_PORT_UPDATE_SAMPLE_RATE);
}

static bt_status_t bt_source_srv_common_handle_audio_sample_size(void *parameter, uint32_t length)
{
    bt_source_srv_audio_sample_size_t *audio_sample_size = (bt_source_srv_audio_sample_size_t *)parameter;

    bt_source_srv_common_audio_port_context_t context = {
        .port = audio_sample_size->port,
        .sample_size = audio_sample_size->sample_size
    };
    return bt_source_srv_common_audio_port_update(&context, BT_SOURCE_SRV_COMMON_AUDIO_PORT_UPDATE_SAMPLE_SIZE);
}

static bt_status_t bt_source_srv_common_handle_audio_sample_channel(void *parameter, uint32_t length)
{
    bt_source_srv_audio_sample_channel_t *audio_sample_channel = (bt_source_srv_audio_sample_channel_t *)parameter;

    bt_source_srv_common_audio_port_context_t context = {
        .port = audio_sample_channel->port,
        .sample_channel = audio_sample_channel->channel
    };
    return bt_source_srv_common_audio_port_update(&context, BT_SOURCE_SRV_COMMON_AUDIO_PORT_UPDATE_SAMPLE_CHANNEL);
}

static bt_status_t bt_source_srv_common_handle_mute(void *parameter, uint32_t length)
{
    bt_status_t status = BT_STATUS_FAIL;
#ifdef AIR_SOURCE_SRV_HFP_ENABLE
    if (bt_source_srv_common_get_playing_device() == BT_SOURCE_SRV_TYPE_HFP) {
        status = bt_source_srv_call_send_action(BT_SOURCE_SRV_ACTION_MUTE, parameter, length);
        return status;
    }
#endif
    return status;
}

static bt_status_t bt_source_srv_common_handle_unmute(void *parameter, uint32_t length)
{
    bt_status_t status = BT_STATUS_FAIL;
#ifdef AIR_SOURCE_SRV_HFP_ENABLE
    if (bt_source_srv_common_get_playing_device() == BT_SOURCE_SRV_TYPE_HFP) {
        status = bt_source_srv_call_send_action(BT_SOURCE_SRV_ACTION_UNMUTE, parameter, length);
        return status;
    }
#endif
    return status;
}

static bt_status_t bt_source_srv_common_handle_volume_up(void *parameter, uint32_t length)
{
    bt_status_t status = BT_STATUS_FAIL;
#ifdef AIR_SOURCE_SRV_HFP_ENABLE
    if (bt_source_srv_common_get_playing_device() == BT_SOURCE_SRV_TYPE_HFP) {
        status = bt_source_srv_call_send_action(BT_SOURCE_SRV_ACTION_VOLUME_UP, parameter, length);
        return status;
    }
#endif
    return status;
}

static bt_status_t bt_source_srv_common_handle_volume_down(void *parameter, uint32_t length)
{
    bt_status_t status = BT_STATUS_FAIL;
#ifdef AIR_SOURCE_SRV_HFP_ENABLE
    if (bt_source_srv_common_get_playing_device() == BT_SOURCE_SRV_TYPE_HFP) {
        status = bt_source_srv_call_send_action(BT_SOURCE_SRV_ACTION_VOLUME_DOWN, parameter, length);
        return status;
    }
#endif
    return status;
}

static bt_status_t bt_source_srv_common_handle_volume_change(void *parameter, uint32_t length)
{
    bt_status_t status = BT_STATUS_FAIL;
#ifdef AIR_SOURCE_SRV_HFP_ENABLE
    status = bt_source_srv_call_send_action(BT_SOURCE_SRV_ACTION_VOLUME_CHANGE, parameter, length);
#endif
#ifdef AIR_SOURCE_SRV_MUSIC_ENABLE
    status = bt_source_srv_avrcp_common_action_handler(BT_SOURCE_SRV_ACTION_VOLUME_CHANGE, parameter, length);
#endif
    return status;
}


bt_status_t bt_source_srv_common_send_action(bt_source_srv_action_t action, void *parameter, uint32_t length)
{
    uint8_t action_index = (uint8_t)(action & BT_SOURCE_SRV_COMMON_ACTION_MASK);
    return g_handle_common_action_table[action_index](parameter, length);
}

