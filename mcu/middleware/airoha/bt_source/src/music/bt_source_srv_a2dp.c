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

 
#include "bt_source_srv_a2dp.h"
#include "bt_source_srv_device_manager.h"
#include "bt_source_srv_music_psd_manager.h"

log_create_module(a2dp_srv, PRINT_LEVEL_INFO);
static const bt_codec_sbc_t sbc_cap[1] = {
    {
        25,  // min_bit_pool
        75,  // max_bit_pool
        0xf, // block_len: all
        0xf, // subband_num: all
        0x3, // both snr/loudness
        0x1, // sample_rate: all
        0xf  // channel_mode: all
    }
};

static bt_a2dp_codec_capability_t g_bt_source_srv_a2dp_codec_list;
static void bt_source_srv_a2dp_start_play(bt_source_srv_music_device_t * device);
static void bt_source_srv_a2dp_initial_avrcp_timer(uint32_t timer_id, uint32_t data);
static bt_status_t bt_source_srv_a2dp_start_stream(bt_source_srv_music_device_t *device);
static bt_status_t bt_source_srv_a2dp_suspend_stream(bt_source_srv_music_device_t *device, bt_source_srv_music_psd_user_event_t event);
static bt_status_t bt_source_srv_music_psd_callback(bt_source_srv_music_psd_user_event_t event_id,void * device,void * parameter);


static void BT_A2DP_SOURCE_MAKE_SBC_CODEC(bt_a2dp_codec_capability_t *codec,
                            bt_a2dp_role_t role,
                            uint8_t min_bit_pool, uint8_t max_bit_pool,
                            uint8_t block_length, uint8_t subband_num,
                            uint8_t alloc_method, uint8_t sample_rate,
                            uint8_t channel_mode)
{
    do {
        codec->type = BT_A2DP_CODEC_SBC;
        codec->sep_type = role;
        codec->length = sizeof(bt_a2dp_sbc_codec_t);
        codec->codec.sbc.channel_mode = (channel_mode & 0x0F);
        codec->codec.sbc.sample_freq = (sample_rate & 0x0F);
        codec->codec.sbc.alloc_method = (alloc_method & 0x03);
        codec->codec.sbc.subbands = (subband_num & 0x03);
        codec->codec.sbc.block_len = (block_length & 0x0F);
        codec->codec.sbc.min_bitpool = (min_bit_pool & 0xFF);
        codec->codec.sbc.max_bitpool = (max_bit_pool & 0xFF);
        codec->delay_report = 0;
        codec->sec_type = 0;
    } while (0);
}

void bt_source_srv_a2dp_init(void)
{
        bt_source_srv_music_cntx_init();
#ifdef MTK_BT_CM_SUPPORT
        bt_cm_profile_service_register(BT_CM_PROFILE_SERVICE_A2DP_SOURCE, bt_source_srv_a2dp_connect_handler);
#endif
        bt_source_srv_music_psd_init();
        bt_callback_manager_register_callback(bt_callback_type_a2dp_get_init_params,
                                             0,
                                             (void *)bt_source_srv_a2dp_get_init_params);

}

bt_status_t bt_source_srv_a2dp_get_init_params(bt_a2dp_init_params_t *param)
{
    int32_t ret = BT_STATUS_FAIL;
    LOG_MSGID_I(source_srv,"[A2DP_SOURCE]get_init_params", 0);

    if (param) {

        /* fill init params */
        param->codec_number = 1;
        BT_A2DP_SOURCE_MAKE_SBC_CODEC(&g_bt_source_srv_a2dp_codec_list, BT_A2DP_SOURCE,
                               sbc_cap[0].min_bit_pool, sbc_cap[0].max_bit_pool,
                               sbc_cap[0].block_length, sbc_cap[0].subband_num,
                               sbc_cap[0].alloc_method, sbc_cap[0].sample_rate,
                               sbc_cap[0].channel_mode);
        param->codec_list = &g_bt_source_srv_a2dp_codec_list;
        param->sink_feature = 0x00;
        param->source_feature = 0x0F;
        //param->sink_delay = 1500;

        ret = BT_STATUS_SUCCESS;
    }
    return ret;
}

bt_status_t bt_source_srv_a2dp_connect_handler(bt_cm_profile_service_handle_t type, void *data)
{
    bt_status_t ret = BT_STATUS_FAIL;
    uint32_t hd = 0;
    bt_source_srv_music_device_t *dev;

    bt_bd_addr_t *dev_addr = (bt_bd_addr_t *)data;
    LOG_MSGID_I(source_srv,"[A2DP_SOURCE]conn_handler,action:0x%x", 1, type);
    switch (type) {
        case BT_CM_PROFILE_SERVICE_HANDLE_CONNECT: {
            ret = bt_a2dp_connect(&hd, (const bt_bd_addr_t *)dev_addr, BT_A2DP_SOURCE);
            LOG_MSGID_I(source_srv,"[A2DP_SOURCE]action_handler, ret:0x%x, addr[0]: 0x%x, addr[1]: %x", 3, ret, (*dev_addr[0]),(*dev_addr[1]));
            if (BT_STATUS_SUCCESS == ret) {
                dev = bt_source_srv_music_get_device(BT_SRV_MUSIC_DEVICE_ADDR_A2DP, (void *)dev_addr);
                if (dev) {
                    bt_source_srv_report_id("[A2DP_SOURCE]action_handler,dev is exst dev:0x%x", 1, dev);
                    dev->a2dp_hd = hd;
                    dev->a2dp_state = BT_SOURCE_SRV_STATE_CONNECTING;
                    dev->con_direct = BT_SOURCE_SRV_A2DP_ACTIVE_CONNECTION_FLAG;
                    bt_utils_memcpy(&(dev->dev_addr), dev_addr, sizeof(bt_bd_addr_t));
                } else {
                    dev = bt_source_srv_music_get_device(BT_SRV_MUSIC_DEVICE_UNUSED, NULL);
                    if (dev) {
                        LOG_MSGID_I(source_srv,"[A2DP_SOURCE]action_handler,  dev:0x%x, handle: %x", 1, dev, hd);
                        dev->a2dp_hd = hd;
                        //dev->a2dp_role = BT_A2DP_SOURCE;
                        dev->a2dp_state = BT_SOURCE_SRV_STATE_CONNECTING;
                        bt_utils_memcpy(&(dev->dev_addr), dev_addr, sizeof(bt_bd_addr_t));
                        /* normal case */
                    }
                }
                dev->audio_dev = bt_source_srv_music_psd_alloc_device(dev_addr, bt_source_srv_music_psd_callback);
                LOG_MSGID_I(source_srv,"[A2DP_SOURCE]conn_handler,action:0x%x", 1, dev->audio_dev);
            }
            break;
        }
        case BT_CM_PROFILE_SERVICE_HANDLE_DISCONNECT: {
            dev = bt_source_srv_music_get_device(BT_SRV_MUSIC_DEVICE_ADDR_A2DP, (void *)dev_addr);
            if (dev == NULL) {
                break;
            }
            if (dev && (dev->a2dp_state > BT_SOURCE_SRV_STATE_CONNECTING)) {
                ret = bt_a2dp_disconnect(dev->a2dp_hd);
                if (ret == BT_STATUS_SUCCESS) {
                    dev->a2dp_state = BT_SOURCE_SRV_STATE_DISCONNECTING; 
                }
            } else {
                ret = BT_STATUS_FAIL;
            }
            LOG_MSGID_I(source_srv,"[A2DP_SOURCE]action DISCONNECT dev:%x, state:%x, ret:%x ", 3, dev, dev->a2dp_state, ret);
            break;
        }
    }
    return ret;
}

static void bt_source_srv_a2dp_start_play(bt_source_srv_music_device_t * device)
{
    bt_source_srv_music_pseduo_dev_t *psd_dev = (bt_source_srv_music_pseduo_dev_t *) device->audio_dev;
    bt_source_srv_music_psd_update_port(psd_dev, BT_SOURCE_SRV_PORT_CHAT_SPEAKER);
    bt_source_srv_music_psd_event_notify(psd_dev, BT_SOURCE_SRV_MUSIC_PSD_EVENT_MUSIC_START, NULL);
}

bt_status_t bt_source_srv_a2dp_action_handler(uint32_t action, void* param, uint32_t length)
{
    uint32_t handle = BT_SOURCE_SRV_INVAILD_HANDLE;
    bt_status_t ret = BT_STATUS_FAIL;
    bt_source_srv_music_device_t *dev = NULL;
    bt_source_srv_music_action_t *srv_action = NULL;
    uint8_t play_status = BT_AVRCP_EVENT_MEDIA_PAUSED;

    LOG_MSGID_I(source_srv,"[A2DP_SOURCE]action_handler,action:0x%x",1, action);

    switch(action) {
        case BT_SOURCE_SRV_ACTION_START_STREAM:
        case BT_SOURCE_SRV_ACTION_SUSPEND_STREAM: {
            srv_action = (bt_source_srv_music_action_t *)param;
            LOG_MSGID_I(source_srv,"[A2DP_SOURCE]action_handler,srv_action:0x%x",1, srv_action);
            if (srv_action) {
                dev = bt_source_srv_music_get_device(BT_SRV_MUSIC_DEVICE_ADDR_A2DP, srv_action->peer_address.addr);
                if (dev) {
                    LOG_MSGID_I(source_srv,"[A2DP_SOURCE]action_handler,srv_action:0x%x,substate:%x", 2, action,dev->sub_state);
                    if (BT_SOURCE_SRV_ACTION_START_STREAM == action) {
                        ret = bt_source_srv_a2dp_start_stream(dev);
                        if (ret == BT_STATUS_SUCCESS) {
                            play_status = BT_AVRCP_EVENT_MEDIA_PLAYING;
                        }
                    } else {
                        ret = bt_source_srv_a2dp_suspend_stream(dev, BT_SOURCE_SRV_MUSIC_PSD_USER_EVENT_SUSPEND);
                    }
                }
            }
            break;
        }
        case BT_SOURCE_SRV_ACTION_START_STREAM_RESPONSE:
        case BT_SOURCE_SRV_ACTION_SUSPEND_STREAM_RESPONSE:
        {
            srv_action = (bt_source_srv_music_action_t *)param;
            if (srv_action && length) {
                uint32_t *is_accept = (uint32_t *)(srv_action->data);
                if (is_accept) {
                    dev = bt_source_srv_music_get_device(BT_SRV_MUSIC_DEVICE_ADDR_A2DP, srv_action->peer_address.addr);
                    if (dev) {
                        handle = dev->a2dp_hd;
                        if (BT_SOURCE_SRV_ACTION_START_STREAM_RESPONSE == action) {
                            ret = bt_a2dp_start_streaming_response(handle, (*is_accept));
                            dev->sub_state = BT_SOURCE_SRV_STATE_IDLE;
                            dev->a2dp_state = BT_SOURCE_SRV_STATE_STREAMING;
                            bt_source_srv_a2dp_start_play(dev);
                            if (ret == BT_STATUS_SUCCESS) {
                                play_status = BT_AVRCP_EVENT_MEDIA_PLAYING;
                            }
                        } else {
                            ret = bt_a2dp_suspend_streaming_response(handle, (*is_accept));
                        }
                    }
                }
                LOG_MSGID_I(source_srv,"[A2DP_SOURCE]action_handler,is_accept: 0x%x, handle:0x%x", 2, (*is_accept), handle);
            }
            break;
        }
#if 0
        case BT_SOURCE_SRV_ACTION_PAUSE:
        {
            ret = BT_STATUS_SUCCESS;
            play_status = BT_AVRCP_EVENT_MEDIA_PAUSED;
            break;
        }
#endif
        default:
            break;
    }

    LOG_MSGID_I(source_srv,"[A2DP_SOURCE]action_handler,ret:0x%x, play_status:%x", 2, ret, play_status);
    if (ret == BT_STATUS_SUCCESS) {
        bt_source_srv_notify_avrcp_event_change(&dev->dev_addr, BT_AVRCP_EVENT_PLAYBACK_STATUS_CHANGED, &play_status);
    }
    return BT_STATUS_SUCCESS;
}

static bt_status_t bt_source_srv_a2dp_handle_connect_cnf(bt_a2dp_connect_cnf_t *conn_cnf)
{
    bt_source_srv_music_device_t *dev;
    bt_source_srv_a2dp_report_id("connect_cnf", 0);
    dev = bt_source_srv_music_get_device(BT_SRV_MUSIC_DEVICE_A2DP_HD, (void *)(&(conn_cnf->handle)));
    LOG_MSGID_I(source_srv,"[A2DP_SOURCE]connect_cnf:dev = 0x%x, handle = 0x%x", 2, dev, conn_cnf->handle);
    if (dev == NULL) {
        configASSERT(0);
    }
    if (conn_cnf->status == BT_STATUS_SUCCESS) {
        if (BT_SOURCE_SRV_STATE_CONNECTING == dev->a2dp_state) {
            LOG_MSGID_I(source_srv,"[A2DP_SOURCE]connect_cnf:dev_addr[0] = 0x%x, dev_addr[1] = 0x%x", 2,  dev->dev_addr[0], dev->dev_addr[1]);
            bt_timer_ext_start(BT_SOURCE_SRV_AVRCP_CONNECTION_TIMER_ID, (uint32_t)dev,
                               BT_SOURCE_SRV_AVRCP_CONNECTION_TIMER_DUR, bt_source_srv_a2dp_initial_avrcp_timer);
        }
        dev->a2dp_state = BT_SOURCE_SRV_STATE_READY;
        bt_utils_memcpy(&(dev->capabilty), conn_cnf->codec_cap, sizeof(bt_a2dp_codec_capability_t));
#ifdef MTK_BT_CM_SUPPORT
        bt_cm_profile_service_status_notify(BT_CM_PROFILE_SERVICE_A2DP_SOURCE, dev->dev_addr, BT_CM_PROFILE_SERVICE_STATE_CONNECTED, conn_cnf->status);
#endif
        dev->max_mtu = bt_a2dp_get_mtu_size(conn_cnf->handle);
        LOG_MSGID_I(source_srv,"[A2DP_SOURCE]connect_cnf:max_mtu = 0x%x, handle = 0x%x", 2, dev->max_mtu, conn_cnf->handle);

        if (dev->audio_dev) {
            bt_source_srv_music_psd_state_machine(dev->audio_dev, BT_SOURCE_SRV_MUSIC_PSD_EVENT_LINK_CONNECTED, NULL);
        }
    } else {
        bt_source_srv_music_psd_state_machine(dev->audio_dev, BT_SOURCE_SRV_MUSIC_PSD_EVENT_LINK_DISCONNECTED, NULL);
        bt_source_srv_music_clean_a2dp_conn_info(dev);
    }
    return BT_STATUS_SUCCESS;
}

static bt_status_t bt_source_srv_a2dp_handle_connect_ind_handler(bt_a2dp_connect_ind_t *conn_ind)
{
    bt_status_t ret = BT_STATUS_FAIL;
    bt_source_srv_music_device_t *dev;
    dev = bt_source_srv_music_get_device(BT_SRV_MUSIC_DEVICE_A2DP_HD, (void *)(&(conn_ind->handle)));
    LOG_MSGID_I(source_srv,"[A2DP_SOURCE]connect_ind_handler: dev = 0x%x, handle = 0x%x", 2, dev, conn_ind->handle);
    if (dev) {
        if (dev->a2dp_state == BT_SOURCE_SRV_STATE_READY) {
            ret = bt_a2dp_connect_response(conn_ind->handle, false);
            configASSERT(0);
        } else {
            ret = bt_a2dp_connect_response(conn_ind->handle, true);
            dev->a2dp_state = BT_SOURCE_SRV_STATE_READY;
        }
        LOG_MSGID_I(source_srv,"[A2DP_SOURCE]connect is in exist : %x, ret = %x", 2, dev->a2dp_state, ret);
    } else {
        dev = bt_source_srv_music_get_device(BT_SRV_MUSIC_DEVICE_UNUSED, NULL);
        if (dev) {
            ret = bt_a2dp_connect_response(conn_ind->handle, true);
            dev->a2dp_state = BT_SOURCE_SRV_STATE_READY;
            dev->a2dp_hd = conn_ind->handle;
            bt_utils_memcpy(&(dev->dev_addr), conn_ind->address, sizeof(bt_bd_addr_t));
            dev->audio_dev = bt_source_srv_music_psd_alloc_device(&(dev->dev_addr), bt_source_srv_music_psd_callback);

            LOG_MSGID_I(source_srv,"connect_ind_handler: ret = 0x%x, handle:0x%x, audio_dev :0x%x", 2, ret, dev->a2dp_hd, dev->audio_dev);
        }
    }
    return ret;
}

static void bt_source_srv_a2dp_handle_disconnct_handler(uint32_t handle)
{
    bt_source_srv_music_device_t *dev = bt_source_srv_music_get_device(BT_SRV_MUSIC_DEVICE_A2DP_HD, (void*)(&handle));
    LOG_MSGID_I(source_srv,"[A2DP_SOURCE]discon_ind_handler: dev = 0x%x, handle = 0x%x", 2, dev, handle);
    if (dev) {
#ifdef MTK_BT_CM_SUPPORT
        bt_cm_profile_service_status_notify(BT_CM_PROFILE_SERVICE_A2DP_SOURCE, dev->dev_addr, BT_CM_PROFILE_SERVICE_STATE_DISCONNECTED, BT_STATUS_SUCCESS);
#endif
        bt_source_srv_music_psd_state_machine(dev->audio_dev, BT_SOURCE_SRV_MUSIC_PSD_EVENT_LINK_DISCONNECTED, NULL);
        LOG_MSGID_I(source_srv,"[A2DP_SOURCE]discon_ind_handler: state = 0x%x", 1, dev->a2dp_state);

        if (dev->a2dp_state == BT_SOURCE_SRV_STATE_DISCONNECTING) {
            bt_source_srv_avrcp_disconnect(&dev->dev_addr);
        }
        bt_source_srv_music_clean_a2dp_conn_info(dev);
    }
}

static void bt_source_srv_a2dp_handle_streaming_cnf(uint32_t handle, bt_status_t status, bt_srv_music_operation_t op)
{

    bt_source_srv_music_stream_operation_cnf_t cnf;
    //uint8_t play_status = BT_AVRCP_EVENT_MEDIA_PAUSED;
    bt_source_srv_music_device_t *dev = bt_source_srv_music_get_device(BT_SRV_MUSIC_DEVICE_A2DP_HD, (void *)(&handle));
    LOG_MSGID_I(source_srv,"[A2DP_SOURCE]handle_streaming_cnf: dev = 0x%x, handle: %x,status : 0x%x, operation: %x", 4, dev, handle, status, op);

    if (dev) {

        bt_utils_memcpy(cnf.peer_address.addr, &dev->dev_addr,sizeof(bt_bd_addr_t));
        cnf.status = status;
        cnf.operation = op;
        bt_source_srv_event_callback(BT_SOURCE_SRV_EVENT_MUSIC_STREAM_OPERATION_CNF, &cnf, sizeof(bt_source_srv_music_stream_operation_cnf_t));
        if (BT_STATUS_SUCCESS == status) {
            if (BT_SOURCE_SRV_ACTION_START_STREAM == op) {
                //play_status = BT_AVRCP_EVENT_MEDIA_PLAYING;
                LOG_MSGID_I(source_srv,"[A2DP_SOURCE]handle_streaming_cnf: dev = 0x%x, sub_state: 0x%x", 2, dev->audio_dev, dev->sub_state);
                 dev->a2dp_state = BT_SOURCE_SRV_STATE_STREAMING;
                 dev->sub_state = BT_SOURCE_SRV_STATE_READY;
                 bt_source_srv_a2dp_start_play(dev);

            } else {
                dev->a2dp_state = BT_SOURCE_SRV_STATE_READY;
                dev->sub_state = BT_SOURCE_SRV_STATE_READY;
            }
            //bt_source_srv_notify_avrcp_event_change(&dev->dev_addr, BT_AVRCP_EVENT_PLAYBACK_STATUS_CHANGED, &play_status);
        }
    }
}

static void bt_source_srv_a2dp_handle_streaming_ind_handler(uint32_t handle, bt_srv_music_operation_t op)
{
    bt_source_srv_music_stream_operation_ind_t ind;

    bt_source_srv_music_device_t *dev = bt_source_srv_music_get_device(BT_SRV_MUSIC_DEVICE_A2DP_HD, &handle);
    LOG_MSGID_I(source_srv, "[A2DP_SOURCE]handle_streaming_ind: dev = 0x%x, handle: %x, op = %x", 3, dev, handle, op);

    if (dev) {
        bt_utils_memcpy(ind.peer_address.addr, &dev->dev_addr,sizeof(bt_bd_addr_t));
        ind.operation = op;
        if (BT_SOURCE_SRV_ACTION_START_STREAM == op) {
            dev->sub_state = BT_SOURCE_SRV_STATE_PREPAR_STREAMING;
        } else {
            dev->sub_state = BT_SOURCE_SRV_STATE_PREPARE_SUSPEND;
        }
        LOG_MSGID_I(source_srv,"[A2DP_SOURCE]handle_streaming_ind: dev = 0x%x, sub_state: 0x%x", 2, dev->audio_dev, dev->sub_state);
       bt_source_srv_event_callback(BT_SOURCE_SRV_EVENT_MUSIC_STREAM_OPERAION_IND, &ind, sizeof(bt_source_srv_music_stream_operation_ind_t));
       //bt_source_srv_set_music_enable(&dev->dev_addr, true);
    }
}

static bt_status_t bt_source_srv_a2dp_start_stream(bt_source_srv_music_device_t *device)
{
    bt_status_t ret = BT_STATUS_FAIL;
    if (device == NULL) {
        return ret;
    }
    
    if (device->sub_state == BT_SOURCE_SRV_STATE_WAIT_STREAMING_RESPONSE) {
        return ret;
    }
    ret = bt_a2dp_start_streaming(device->a2dp_hd);
    LOG_MSGID_I(source_srv,"[A2DP_SOURCE]action_handler,start:0x%x, handle: %x", 2, ret, device->a2dp_hd);
    if (BT_STATUS_SUCCESS == ret) {
        device->sub_state = BT_SOURCE_SRV_STATE_WAIT_STREAMING_RESPONSE;
    }
    return ret;
}

static bt_status_t bt_source_srv_a2dp_suspend_stream(bt_source_srv_music_device_t *device, bt_source_srv_music_psd_user_event_t event)
{
    bt_status_t ret = BT_STATUS_FAIL;
    uint32_t handle = device->a2dp_hd;
    LOG_MSGID_I(source_srv,"[A2DP_SOURCE]suspend_stream,state:%x, sub_sate: %x, event:%x", 3, device->a2dp_state, device->sub_state, event);

    if (device->a2dp_state == BT_SOURCE_SRV_STATE_STREAMING) {
        if (device->sub_state == BT_SOURCE_SRV_STATE_PREPARE_SUSPEND) {
            return ret;
        }
        ret = bt_a2dp_suspend_streaming(handle);

        if (event == BT_SOURCE_SRV_MUSIC_PSD_USER_EVENT_SUSPEND && BT_STATUS_SUCCESS == ret) {
            device->sub_state = BT_SOURCE_SRV_STATE_PREPARE_SUSPEND;
            bt_source_srv_music_psd_state_machine(device->audio_dev, BT_SOURCE_SRV_MUSIC_PSD_EVENT_SUSPEND_REQ, NULL);
        }
    }
    LOG_MSGID_I(source_srv,"[A2DP_SOURCE]suspend_stream,ret:%x,handle:0x%0x ", 2, ret, handle);

    return ret;
}

bt_status_t bt_source_srv_a2dp_audio_port_update(bt_source_srv_port_t audio_port)
{
    LOG_MSGID_W(source_srv, "[A2DP_SOURCE] bt_source_srv_a2dp_audio_port_update, audio_port:%x", 1, audio_port);

    bt_source_srv_music_device_t *context = bt_source_srv_music_get_device(BT_SRV_MUSIC_DEVICE_HIGHLIGHT,NULL);
    if (context == NULL) {
        LOG_MSGID_W(source_srv, "[A2DP_SOURCE] audio port update highlight is NULL", 0);
        return BT_STATUS_FAIL;
    }

    if (audio_port == BT_SOURCE_SRV_PORT_MIC || audio_port == BT_SOURCE_SRV_PORT_GAMING_SPEAKER) {
        return BT_STATUS_FAIL;
    }
    bt_source_srv_music_psd_audio_replay_req_t audio_replay_req = {
        .type = BT_SOURCE_SRV_MUSIC_PSD_AUDIO_REPLAY_DL,
    };

    /* ingonre device is not playing case */
    bt_source_srv_music_psd_update_port(context->audio_dev, audio_port);

    if (bt_source_srv_music_psd_is_playing(context->audio_dev)) {

        bt_source_srv_music_psd_event_notify(context->audio_dev, BT_SOURCE_SRV_MUSIC_PSD_EVENT_MUSIC_REPLAY, &audio_replay_req);
    } else {
        bt_source_srv_music_psd_event_notify(context->audio_dev, BT_SOURCE_SRV_MUSIC_PSD_EVENT_MUSIC_START, &audio_replay_req);
    }
    return BT_STATUS_SUCCESS;
}

static void bt_source_srv_a2dp_initial_avrcp_timer(uint32_t timer_id, uint32_t data)
{
    bt_source_srv_music_device_t *dev = (bt_source_srv_music_device_t *)data;
    LOG_MSGID_W(source_srv,"[sink][a2dp]a2dp_initial_avrcp_timer:avrcp_hd:0x%x, avrcp_state: 0x%x", 2, dev->avrcp_hd, dev->avrcp_state);
    if (dev->avrcp_hd == BT_SOURCE_SRV_INVAILD_HANDLE &&
        (dev->avrcp_state < BT_SOURCE_SRV_STATE_CONNECTING)) {
        bt_source_srv_avrcp_connect(&(dev->dev_addr));
    }
}

static bt_status_t bt_source_srv_music_psd_callback(bt_source_srv_music_psd_user_event_t event_id,void * device,void * parameter)
{
    bt_status_t ret = BT_STATUS_FAIL;
    bt_source_srv_music_device_t *context = bt_source_srv_music_get_device(BT_SRV_MUSIC_DEVICE_AUDIO_RESOURCE_DEVICE, device);
    LOG_MSGID_I(source_srv,"[A2DP_SOURCE]music_psd_callback:device: 0x%x, event:0x%x",2, device, event_id);

    if (context == NULL) {
        return ret;
    }
    switch (event_id){
        case BT_SOURCE_SRV_MUSIC_PSD_USER_EVENT_RESUME:{
            LOG_MSGID_I(source_srv,"[A2DP_SOURCE]music_psd_callback:resume,0x%x, 0x%x",2, context, context->a2dp_state);
            if (context->a2dp_state != BT_SOURCE_SRV_STATE_DISCONNECTING) {
                bt_source_srv_a2dp_start_stream(context);
            }
            break;
        }
            
        case BT_SOURCE_SRV_MUSIC_PSD_USER_EVENT_REJECT: {
            LOG_MSGID_I(source_srv,"[A2DP_SOURCE]music_psd_callback:context: 0x%x, 0x%x",2, context, context->sub_state);
           bt_source_srv_a2dp_suspend_stream(context, BT_SOURCE_SRV_MUSIC_PSD_USER_EVENT_REJECT);

           break;
        }
        case BT_SOURCE_SRV_MUSIC_PSD_USER_EVENT_SUSPEND:{
             /*only need stop audio tranismiter*/
             bt_source_srv_music_psd_event_notify(context->audio_dev, BT_SOURCE_SRV_MUSIC_PSD_EVENT_SUSPEND_REQ, NULL);
             bt_source_srv_a2dp_suspend_stream(context,BT_SOURCE_SRV_MUSIC_PSD_USER_EVENT_SUSPEND);
             break;
         }
        case BT_SOURCE_SRV_MUSIC_PSD_USER_EVENT_DEINIT: {

            bt_source_srv_music_psd_free_device(context->audio_dev);

            break;
        }
    }
        return BT_STATUS_SUCCESS;
}

bt_status_t bt_source_srv_a2dp_common_callback(bt_msg_type_t msg, bt_status_t status, void *buffer)
{
    bt_status_t ret = 0;
    LOG_MSGID_I(source_srv,"[A2DP_SOURCE]a2dp_common_callback:msg: 0x%x, 0x%x", 2, msg, status);

    switch(msg)
    {
        case BT_A2DP_CONNECT_CNF: {
            bt_a2dp_connect_cnf_t *conn_cnf = (bt_a2dp_connect_cnf_t *)buffer;
            if (conn_cnf) {
                ret = bt_source_srv_a2dp_handle_connect_cnf(conn_cnf);
            }
            break;
        }
        case BT_A2DP_CONNECT_IND: {
            bt_a2dp_connect_ind_t *conn_ind = (bt_a2dp_connect_ind_t *)buffer;
            if (conn_ind) {
                ret = bt_source_srv_a2dp_handle_connect_ind_handler(conn_ind);
            }
            break;
        }
        case BT_A2DP_START_STREAMING_IND: {
            bt_a2dp_start_streaming_ind_t *start_ind = (bt_a2dp_start_streaming_ind_t *)buffer;
            if (start_ind) {

                bt_source_srv_a2dp_handle_streaming_ind_handler(start_ind->handle, BT_SOURCE_SRV_ACTION_START_STREAM);
            }
            break;
        }
        case BT_A2DP_SUSPEND_STREAMING_IND: {
            bt_a2dp_suspend_streaming_ind_t *suspend_ind = (bt_a2dp_suspend_streaming_ind_t *)buffer;
            if (suspend_ind) {
                bt_source_srv_a2dp_handle_streaming_ind_handler(suspend_ind->handle, BT_SOURCE_SRV_ACTION_SUSPEND_STREAM);
            }
            break;
        }
        case BT_A2DP_START_STREAMING_CNF: {
            bt_a2dp_start_streaming_cnf_t *start_cnf = (bt_a2dp_start_streaming_cnf_t *)buffer;
            
            if (start_cnf) {
                bt_source_srv_a2dp_handle_streaming_cnf(start_cnf->handle, start_cnf->status, BT_SOURCE_SRV_ACTION_START_STREAM);
            }
            break;
        }
        case BT_A2DP_SUSPEND_STREAMING_CNF: {
            bt_a2dp_suspend_streaming_cnf_t *suspend_cnf = (bt_a2dp_suspend_streaming_cnf_t *)buffer;
            if (suspend_cnf) {
                bt_source_srv_a2dp_handle_streaming_cnf(suspend_cnf->handle, suspend_cnf->status, BT_SOURCE_SRV_ACTION_SUSPEND_STREAM);
            }
            break;
        }
        case BT_A2DP_DISCONNECT_IND: {
            bt_a2dp_disconnect_ind_t *dis_ind = (bt_a2dp_disconnect_ind_t *)buffer;
            if (dis_ind) {
                bt_source_srv_a2dp_handle_disconnct_handler(dis_ind->handle);
            }
            break;
        }
        case BT_A2DP_DISCONNECT_CNF: {
            bt_a2dp_disconnect_cnf_t *dis_cnf = (bt_a2dp_disconnect_cnf_t *)buffer;
            if (dis_cnf && dis_cnf->status == BT_STATUS_SUCCESS) {
                bt_source_srv_a2dp_handle_disconnct_handler(dis_cnf->handle);
            }
            break;
        }
    }
    return ret;
}

