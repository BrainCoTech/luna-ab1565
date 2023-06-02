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

#if defined(AIR_BT_AUDIO_DONGLE_ENABLE)

/* Includes ------------------------------------------------------------------*/
#include "scenario_bt_audio.h"
#include "audio_transmitter_playback_port.h"
#include "usbaudio_drv.h"
#include "bt_sink_srv_ami.h"
#include "hal_audio_message_struct_common.h"
#include "hal_dvfs_internal.h"
#include "scenario_dongle_common.h"

/* Private define ------------------------------------------------------------*/
#define AUDIO_BT_MSBC_SHARE_BUF_FRAME_SIZE             (60U)
#define AUDIO_BT_CVSD_SHARE_BUF_FRAME_SIZE             (120U)
#define AUDIO_BT_HFP_SHARE_BUF_PARTTERN_TOTAL_SIZE     (480U)
/* Private typedef -----------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
extern audio_dongle_usb_handle_t audio_dongle_usb_rx_handle[AUDIO_DONGLE_USB_RX_PORT_TOTAL];
extern audio_dongle_usb_handle_t audio_dongle_usb_tx_handle[AUDIO_DONGLE_USB_TX_PORT_TOTAL];

/* Public variables ----------------------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
#ifdef AIR_BT_AUDIO_DONGLE_USB_ENABLE
static void bt_audio_dongle_open_stream_in_usb(audio_transmitter_config_t *config, mcu2dsp_open_param_t *open_param)
{
    uint32_t payload_size = 0;
    uint8_t usb_rx_port = 0;
    audio_dongle_usb_info_t *source_param = &(config->scenario_config.bt_audio_dongle_config.dl_info.source.usb_in);
    audio_dongle_usb_info_t *usb_in  = &(open_param->stream_in_param.data_dl.scenario_param.bt_audio_dongle_param.dl_info.source.usb_in);
    /* configure stream source */
    /* get usb frame size */
    payload_size = audio_dongle_get_usb_audio_frame_size(&(source_param->codec_type), &(source_param->codec_param));
    if (payload_size == 0) {
        TRANSMITTER_LOG_E("[BT Audio][DL][ERROR]Error usb frame size %d\r\n", 1, payload_size);
        AUDIO_ASSERT(0);
    }
    if ((config->scenario_sub_id == AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_0) ||
        (config->scenario_sub_id == AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_0)) {
        usb_rx_port = 0;
    } else if ((config->scenario_sub_id == AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_1) ||
               (config->scenario_sub_id == AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_1)) {
        usb_rx_port = 1;
    } else {
        AUDIO_ASSERT(0 && "[BT Audio][DL] Error sub id");
    }
    /* prepare usb-in paramters to USB Audio callback */
    audio_dongle_usb_rx_handle[usb_rx_port].frame_size                   = payload_size;
    audio_dongle_usb_rx_handle[usb_rx_port].frame_interval               = source_param->codec_param.pcm.frame_interval;
    audio_dongle_usb_rx_handle[usb_rx_port].usb_type                     = source_param->codec_type;
    audio_dongle_usb_rx_handle[usb_rx_port].usb_param.pcm.sample_rate    = source_param->codec_param.pcm.sample_rate;
    audio_dongle_usb_rx_handle[usb_rx_port].usb_param.pcm.channel_mode   = source_param->codec_param.pcm.channel_mode;
    audio_dongle_usb_rx_handle[usb_rx_port].usb_param.pcm.format         = source_param->codec_param.pcm.format;
    audio_dongle_usb_rx_handle[usb_rx_port].stream_is_started            = 1;
    audio_dongle_usb_rx_handle[usb_rx_port].dongle_stream_status         |= (1 << config->scenario_sub_id);
    audio_dongle_usb_rx_handle[usb_rx_port].p_dsp_info                   = hal_audio_query_audio_transmitter_share_info(AUDIO_TRANSMITTER_SHARE_INFO_INDEX_ULL_AUDIO_V2_DONGLE_DSP_RECEIVE_FROM_MCU_0 + usb_rx_port);
    open_param->stream_in_param.data_dl.p_share_info                     = hal_audio_query_audio_transmitter_share_info(AUDIO_TRANSMITTER_SHARE_INFO_INDEX_ULL_AUDIO_V2_DONGLE_DSP_RECEIVE_FROM_MCU_0 + usb_rx_port);
    /* prepare usb-in parameters to dsp */
    open_param->param.stream_in                                          = STREAM_IN_AUDIO_TRANSMITTER;
    open_param->stream_in_param.data_dl.scenario_type                    = config->scenario_type;
    open_param->stream_in_param.data_dl.scenario_sub_id                  = config->scenario_sub_id;
    open_param->stream_in_param.data_dl.data_notification_frequency      = 0;
    open_param->stream_in_param.data_dl.max_payload_size                 = payload_size;
    open_param->stream_in_param.data_dl.p_share_info->read_offset        = 0;
    open_param->stream_in_param.data_dl.p_share_info->write_offset       = 0;
    open_param->stream_in_param.data_dl.p_share_info->bBufferIsFull      = false;

    // init source info from config parameter
    memcpy(&(open_param->stream_in_param.data_dl.scenario_param.bt_audio_dongle_param.dl_info.source),
           &(config->scenario_config.bt_audio_dongle_config.dl_info.source), sizeof(bt_audio_dongle_dl_source_info_t));

    audio_transmitter_modify_share_info_by_block(open_param->stream_in_param.data_dl.p_share_info, payload_size);
    /* prepare default gain settings */
    // scenario_param->bt_audio_dongle_param.gain_default_L = -12000; // -120.00dB -> mute
    // scenario_param->bt_audio_dongle_param.gain_default_R = -12000; // -120.00dB -> mute

    /* stream common setting init */
    usb_in->channel_num    = source_param->codec_param.pcm.channel_mode;
    usb_in->sample_rate    = source_param->codec_param.pcm.sample_rate;
    usb_in->frame_interval = source_param->codec_param.pcm.frame_interval; // us
    usb_in->frame_samples  = usb_in->sample_rate * usb_in->frame_interval / 1000 / 1000;
    usb_in->frame_size     = usb_in->frame_samples * usb_in->channel_num * audio_dongle_get_usb_format_bytes(source_param->codec_param.pcm.format);
    usb_in->sample_format  = source_param->codec_param.pcm.format;
    TRANSMITTER_LOG_I("[BT Audio][DL] USB setting: sub_id[%d], codec %u, fs %u, ch %u, format %u, irq %u, pay_load %u, sharebuffer 0x%x, size %d, 0x%x, frame samples %d, frame size %d, format %d\r\n", 13,
                        config->scenario_sub_id,
                        source_param->codec_type,
                        source_param->codec_param.pcm.sample_rate,
                        source_param->codec_param.pcm.channel_mode,
                        source_param->codec_param.pcm.format,
                        source_param->codec_param.pcm.frame_interval,
                        payload_size,
                        open_param->stream_in_param.data_dl.p_share_info,
                        open_param->stream_in_param.data_dl.p_share_info->length,
                        open_param->stream_in_param.data_dl.p_share_info->start_addr,
                        usb_in->frame_samples,
                        usb_in->frame_size,
                        usb_in->sample_format
                        );
}

static void bt_audio_dongle_open_stream_out_usb(audio_transmitter_config_t *config, mcu2dsp_open_param_t *open_param)
{
    uint32_t payload_size = 0;
    uint8_t usb_tx_port = 0;
    audio_dongle_usb_info_t *sink_param = &(config->scenario_config.bt_audio_dongle_config.ul_info.sink.usb_out);
    audio_dongle_usb_info_t *usb_out    = &(open_param->stream_out_param.data_ul.scenario_param.bt_audio_dongle_param.ul_info.sink.usb_out);
    /* configure stream source */
    /* get usb frame size */
    payload_size = audio_dongle_get_usb_audio_frame_size(&(sink_param->codec_type), &(sink_param->codec_param));
    if (payload_size == 0) {
        TRANSMITTER_LOG_E("[BT Audio][UL][ERROR]Error usb frame size %d\r\n", 1, payload_size);
        AUDIO_ASSERT(0);
    }
    if (config->scenario_sub_id == AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_0) {
        usb_tx_port = 0;
    } else if (config->scenario_sub_id == AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_1) {
        usb_tx_port = 1;
    } else {
        AUDIO_ASSERT(0 && "[BT Audio][UL] Error sub id");
    }
    /* prepare usb-in paramters to USB Audio callback */
    audio_dongle_usb_tx_handle[usb_tx_port].frame_size                   = payload_size;
    audio_dongle_usb_tx_handle[usb_tx_port].frame_interval               = sink_param->codec_param.pcm.frame_interval;
    audio_dongle_usb_tx_handle[usb_tx_port].usb_type                     = sink_param->codec_type;
    audio_dongle_usb_tx_handle[usb_tx_port].usb_param.pcm.sample_rate    = sink_param->codec_param.pcm.sample_rate;
    audio_dongle_usb_tx_handle[usb_tx_port].usb_param.pcm.channel_mode   = sink_param->codec_param.pcm.channel_mode;
    audio_dongle_usb_tx_handle[usb_tx_port].usb_param.pcm.format         = sink_param->codec_param.pcm.format;
    // TODO:dual usb card support ?
    audio_dongle_usb_tx_handle[usb_tx_port].p_dsp_info                   = hal_audio_query_audio_transmitter_share_info(AUDIO_TRANSMITTER_SHARE_INFO_INDEX_ULL_AUDIO_V2_DONGLE_DSP_SEND_TO_MCU_0);
    open_param->stream_out_param.data_ul.p_share_info                    = audio_dongle_usb_tx_handle[usb_tx_port].p_dsp_info;
    /* prepare usb-in parameters to dsp */
    open_param->param.stream_out                                     = STREAM_OUT_AUDIO_TRANSMITTER;
    open_param->stream_out_param.data_ul.scenario_type               = config->scenario_type;
    open_param->stream_out_param.data_ul.scenario_sub_id             = config->scenario_sub_id;
    open_param->stream_out_param.data_ul.data_notification_frequency = 0;
    open_param->stream_out_param.data_ul.max_payload_size            = payload_size;
    open_param->stream_out_param.data_ul.p_share_info->read_offset   = 0;
    open_param->stream_out_param.data_ul.p_share_info->write_offset  = 0;
    open_param->stream_out_param.data_ul.p_share_info->bBufferIsFull = false;

    // init source info from config parameter
    memcpy(&(open_param->stream_out_param.data_ul.scenario_param.bt_audio_dongle_param.ul_info.sink),
           &(config->scenario_config.bt_audio_dongle_config.ul_info.sink), sizeof(bt_audio_dongle_ul_sink_info_t));

    audio_transmitter_modify_share_info_by_block(open_param->stream_out_param.data_ul.p_share_info, payload_size);
    /* stream common setting init */
    usb_out->channel_num    = sink_param->codec_param.pcm.channel_mode;
    usb_out->sample_rate    = sink_param->codec_param.pcm.sample_rate;
    usb_out->frame_interval = sink_param->codec_param.pcm.frame_interval; // us
    usb_out->frame_samples  = usb_out->sample_rate * usb_out->frame_interval / 1000 / 1000;
    usb_out->frame_size     = usb_out->frame_samples * usb_out->channel_num * audio_dongle_get_usb_format_bytes(sink_param->codec_param.pcm.format);
    usb_out->sample_format  = sink_param->codec_param.pcm.format;
    TRANSMITTER_LOG_I("[BT Audio][UL] USB setting: sub_id[%d], codec %u, fs %u, ch %u, format %u, irq %u, pay_load %u, sharebuffer 0x%x, size %d, 0x%x\r\n", 10,
                        config->scenario_sub_id,
                        sink_param->codec_type,
                        sink_param->codec_param.pcm.sample_rate,
                        sink_param->codec_param.pcm.channel_mode,
                        sink_param->codec_param.pcm.format,
                        sink_param->codec_param.pcm.frame_interval,
                        payload_size,
                        open_param->stream_out_param.data_ul.p_share_info,
                        open_param->stream_out_param.data_ul.p_share_info->length,
                        open_param->stream_out_param.data_ul.p_share_info->start_addr
                        );
}
#endif /* AIR_BT_AUDIO_DONGLE_USB_ENABLE */

static void bt_audio_dongle_open_stream_out_bt(audio_transmitter_config_t *config, mcu2dsp_open_param_t *open_param)
{
    uint32_t i = 0;
    uint32_t payload_size = 0;
    uint8_t  format_bytes = 0; // audio_dongle_get_format_bytes(sink_info->bt_out.sample_format)
    bt_audio_dongle_dl_sink_info_t *sink_info = &(open_param->stream_out_param.bt_common.scenario_param.bt_audio_dongle_param.dl_info.sink);
    /* configure stream sink */
    /* prepare bt-out parameters to dsp */
    if ((config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.link_num == 0) ||
        (config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.link_num > BT_AUDIO_DATA_CHANNEL_NUMBER)) {
        TRANSMITTER_LOG_E("[BT Audio][DL][ERROR]Error dl link num %d\r\n", 1, config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.link_num);
        AUDIO_ASSERT(0);
    }
    open_param->param.stream_out                            = STREAM_OUT_BT_COMMON;
    open_param->stream_out_param.bt_common.scenario_type    = config->scenario_type;
    open_param->stream_out_param.bt_common.scenario_sub_id  = config->scenario_sub_id;
    open_param->stream_out_param.bt_common.share_info_type  = SHARE_BUFFER_INFO_TYPE;
    open_param->stream_out_param.bt_common.p_share_info     = hal_audio_query_audio_transmitter_share_info(AUDIO_TRANSMITTER_SHARE_INFO_INDEX_ULL_AUDIO_V2_DONGLE_BT_SEND_TO_AIR_0); // Not used
    open_param->stream_out_param.bt_common.data_notification_frequency = 0;
    // init sink info from config parameter
    memcpy(sink_info, &(config->scenario_config.bt_audio_dongle_config.dl_info.sink), sizeof(bt_audio_dongle_dl_sink_info_t));

    // BT Classic dongle only support 16bit.
    sink_info->bt_out.sample_format = HAL_AUDIO_PCM_FORMAT_S16_LE;
    format_bytes = audio_dongle_get_format_bytes(sink_info->bt_out.sample_format);
    /* change frame interval to align bt clk:0.3125ms : gTriggerDspEncodeIntervalInClkTick = ((gTriggerDspEncodeIntervalInClkTick*10000)/3125) + 1 */
    sink_info->bt_out.frame_interval = ((sink_info->bt_out.frame_interval * 10 / 3125) + 1) * 3125 / 10;
    open_param->stream_out_param.bt_common.max_payload_size = 0;
    // check parameters
    for (i = 0; i < config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.link_num; i++) {
        if (config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].enable) {
            payload_size = audio_dongle_get_codec_frame_size(&(config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_type),
                                                            &(config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_param));
            if (payload_size == 0) {
                TRANSMITTER_LOG_E("[BT Audio][DL][ERROR]Error codec frame size %d\r\n", 1, payload_size);
                AUDIO_ASSERT(0);
            }
            if (open_param->stream_out_param.bt_common.max_payload_size < (payload_size)) {
                open_param->stream_out_param.bt_common.max_payload_size = payload_size;
            }
            sink_info->bt_out.codec_type = config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_type;
            if (config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_type == AUDIO_DSP_CODEC_TYPE_MSBC) {
                //sink_info->bt_out.sample_rate    = sink_info->bt_out.bt_info[i].codec_param.msbc.sample_rate; //TODO
                sink_info->bt_out.channel_num    = 1; //sink_info->bt_out.bt_info[i].codec_param.msbc.channel_mode == 0 ? 1 : 2;
                // sink_info->bt_out.frame_samples  = sink_info->bt_out.frame_interval * sink_info->bt_out.sample_rate / 1000 / 1000; // 15ms 16bit
                sink_info->bt_out.frame_samples  = 7500 * sink_info->bt_out.sample_rate / 1000 / 1000; // 7.5ms 16bit
                sink_info->bt_out.frame_size     = sink_info->bt_out.frame_samples * format_bytes;
                hal_audio_set_hfp_avm_info(sink_info->bt_out.bt_info[i].share_info, AUDIO_BT_HFP_SHARE_BUF_PARTTERN_TOTAL_SIZE, AUDIO_BT_MSBC_SHARE_BUF_FRAME_SIZE);
                TRANSMITTER_LOG_I("[BT Audio][DL] BT link msbc setting ch%u: %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, 0x%x, 0x%x\r\n", 13,
                                    i + 1,
                                    config->scenario_sub_id,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_type,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_param.msbc.min_bit_pool,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_param.msbc.max_bit_pool,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_param.msbc.block_length,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_param.msbc.subband_num,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_param.msbc.alloc_method,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_param.msbc.sample_rate,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_param.msbc.channel_mode,
                                    payload_size,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].share_info,
                                    ((n9_dsp_share_info_t *)(config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].share_info))->start_addr);
            } else if (config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_type == AUDIO_DSP_CODEC_TYPE_SBC) {
                uint32_t sub_band = sink_info->bt_out.bt_info[i].codec_param.sbc_enc.subband_num == 0 ? 4 : 8;
                uint32_t blocks   = (sink_info->bt_out.bt_info[i].codec_param.sbc_enc.block_length + 1) * 4;
                //sink_info->bt_out.sample_rate    = sink_info->bt_out.bt_info[i].codec_param.sbc_enc.sample_rate; //TODO
                sink_info->bt_out.channel_num    = 1; //sink_info->bt_out.bt_info[i].codec_param.sbc_enc.channel_mode == 0 ? 1 : 2;
                sink_info->bt_out.frame_samples  = sub_band * blocks; // 15ms 16bit
                sink_info->bt_out.frame_size     = sink_info->bt_out.frame_samples * format_bytes;
                // config forwarder buffer and share buffer for eSCO
                TRANSMITTER_LOG_I("[BT Audio][DL] BT link sbc setting ch%u: %u, %u, %u, %u, %u, %u, %u, 0x%x, %u, 0x%x, 0x%x\r\n", 12,
                                    i + 1,
                                    config->scenario_sub_id,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_type,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_param.sbc_enc.bit_pool,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_param.sbc_enc.block_length,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_param.sbc_enc.subband_num,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_param.sbc_enc.alloc_method,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_param.sbc_enc.sample_rate,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_param.sbc_enc.channel_mode,
                                    payload_size,
                                    config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].share_info,
                                    ((n9_dsp_share_info_t *)(config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].share_info))->start_addr);
            } else if (config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_type == AUDIO_DSP_CODEC_TYPE_CVSD) {
                // sink_info->bt_out.frame_samples  = sink_info->bt_out.sample_rate * sink_info->bt_out.frame_interval / 1000 / 1000; // 15ms 16bit
                sink_info->bt_out.frame_samples  = 7500 * sink_info->bt_out.sample_rate / 1000 / 1000; // 7.5ms 16bit
                sink_info->bt_out.frame_size     = sink_info->bt_out.frame_samples * format_bytes;
                sink_info->bt_out.channel_num    = 1;
                hal_audio_set_hfp_avm_info(sink_info->bt_out.bt_info[i].share_info, AUDIO_BT_HFP_SHARE_BUF_PARTTERN_TOTAL_SIZE, AUDIO_BT_CVSD_SHARE_BUF_FRAME_SIZE);
            } else {
                TRANSMITTER_LOG_I("[BT Audio][DL] codec type error %d", 1, config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].codec_type);
            }
            if (((((n9_dsp_share_info_t *)(sink_info->bt_out.bt_info[i].share_info))->sub_info.block_info.block_size) != ((payload_size + sizeof(BT_AUDIO_HEADER) + 3)/4*4)) &&
                ((((n9_dsp_share_info_t *)(sink_info->bt_out.bt_info[i].share_info))->sub_info.block_info.block_size) != payload_size)) {
                /* eSCO data is handled by Forwarder HW, so there is no header in it */
                TRANSMITTER_LOG_E("[BT Audio][DL][ERROR]Error packet size %d, %d\r\n", 2, payload_size + sizeof(BT_AUDIO_HEADER), (((n9_dsp_share_info_t *)(config->scenario_config.bt_audio_dongle_config.dl_info.sink.bt_out.bt_info[i].share_info))->sub_info.block_info.block_size));
                AUDIO_ASSERT(0);
            }
            TRANSMITTER_LOG_I("[BT Audio][DL] BT sink share buffer info 0x%x size %d addr 0x%x wo %d ro %d block size %d block number %d", 7,
                (n9_dsp_share_info_t *)(sink_info->bt_out.bt_info[i].share_info),
                ((n9_dsp_share_info_t *)(sink_info->bt_out.bt_info[i].share_info))->length,
                ((n9_dsp_share_info_t *)(sink_info->bt_out.bt_info[i].share_info))->start_addr,
                ((n9_dsp_share_info_t *)(sink_info->bt_out.bt_info[i].share_info))->write_offset,
                ((n9_dsp_share_info_t *)(sink_info->bt_out.bt_info[i].share_info))->read_offset,
                ((n9_dsp_share_info_t *)(sink_info->bt_out.bt_info[i].share_info))->sub_info.block_info.block_size,
                ((n9_dsp_share_info_t *)(sink_info->bt_out.bt_info[i].share_info))->sub_info.block_info.block_num
                );
        } else {
            open_param->stream_out_param.bt_common.scenario_param.bt_audio_dongle_param.dl_info.sink.bt_out.bt_info[i].share_info = NULL;
        }
    }

    TRANSMITTER_LOG_I("[BT Audio][DL] BT out: sub id [%d] codec %d, fs %d, ch %d, format %d, frame samples %d, frame size %d, frame interval %d bit_rate %d link_num %d", 10,
        open_param->stream_out_param.bt_common.scenario_sub_id,
        sink_info->bt_out.codec_type,
        sink_info->bt_out.sample_rate,
        sink_info->bt_out.channel_num,
        sink_info->bt_out.sample_format,
        sink_info->bt_out.frame_samples,
        sink_info->bt_out.frame_size,
        sink_info->bt_out.frame_interval,
        sink_info->bt_out.bit_rate,
        sink_info->bt_out.link_num
        );
}

static void bt_audio_dongle_open_stream_in_bt(audio_transmitter_config_t *config, mcu2dsp_open_param_t *open_param)
{
    uint32_t i              = 0;
    uint32_t payload_size   = 0;
    uint32_t process_frames = 0;
    uint8_t  format_bytes   = 0; // audio_dongle_get_format_bytes(bt_in->sample_format);
    /* configure stream sink */
    /* prepare bt-out parameters to dsp */
    bt_audio_dongle_bt_in_info_t *bt_in = &(open_param->stream_in_param.bt_common.scenario_param.bt_audio_dongle_param.ul_info.source.bt_in);
    if ((config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.link_num == 0) ||
        (config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.link_num > BT_AUDIO_DATA_CHANNEL_NUMBER)) {
        TRANSMITTER_LOG_E("[BT Audio][UL][ERROR]Error dl link num %d\r\n", 1, config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.link_num);
        AUDIO_ASSERT(0);
    }
    open_param->param.stream_in                            = STREAM_IN_BT_COMMON;
    open_param->stream_in_param.bt_common.scenario_type    = config->scenario_type;
    open_param->stream_in_param.bt_common.scenario_sub_id  = config->scenario_sub_id;
    open_param->stream_in_param.bt_common.share_info_type  = SHARE_BUFFER_INFO_TYPE;
    open_param->stream_in_param.bt_common.p_share_info     = hal_audio_query_audio_transmitter_share_info(AUDIO_TRANSMITTER_SHARE_INFO_INDEX_ULL_AUDIO_V2_DONGLE_BT_RECEIVE_FROM_AIR_0); // not used
    open_param->stream_in_param.bt_common.data_notification_frequency = 0;

    // init source info from config parameter
    memcpy(&(open_param->stream_in_param.bt_common.scenario_param.bt_audio_dongle_param.ul_info.source),
           &(config->scenario_config.bt_audio_dongle_config.ul_info.source), sizeof(bt_audio_dongle_ul_source_info_t));

    /* bt in common setting init */
    // BT Classic dongle only support 16bit.
    bt_in->sample_format = HAL_AUDIO_PCM_FORMAT_S16_LE;
    format_bytes   = audio_dongle_get_format_bytes(bt_in->sample_format);
    process_frames = bt_in->frame_interval / 7500;
    open_param->stream_in_param.bt_common.max_payload_size = 0;
    for (i = 0; i < config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.link_num; i++) {
        if (config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].enable) {
            bt_in->codec_type = config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].codec_type;
            payload_size = process_frames * audio_dongle_get_codec_frame_size(  &(config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].codec_type),
                                                            &(config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].codec_param));
            if (payload_size == 0) {
                TRANSMITTER_LOG_E("[BT Audio][UL][ERROR]Error codec frame size %d\r\n", 1, payload_size);
                AUDIO_ASSERT(0);
            }
            if (open_param->stream_in_param.bt_common.max_payload_size < (payload_size)) {
                open_param->stream_in_param.bt_common.max_payload_size = payload_size;
            }
            if (config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].codec_type == AUDIO_DSP_CODEC_TYPE_MSBC) {
                bt_in->channel_num  = 1;
                bt_in->sample_rate  = 16000;
                hal_audio_set_hfp_avm_info(bt_in->bt_info[i].share_info, AUDIO_BT_HFP_SHARE_BUF_PARTTERN_TOTAL_SIZE, AUDIO_BT_MSBC_SHARE_BUF_FRAME_SIZE);
                TRANSMITTER_LOG_I("[BT Audio][UL] BT link msbc setting ch%u: %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, 0x%x, 0x%x\r\n", 13,
                                    i+1,
                                    config->scenario_sub_id,
                                    config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].codec_type,
                                    config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].codec_param.msbc.min_bit_pool,
                                    config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].codec_param.msbc.max_bit_pool,
                                    config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].codec_param.msbc.block_length,
                                    config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].codec_param.msbc.subband_num,
                                    config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].codec_param.msbc.alloc_method,
                                    config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].codec_param.msbc.sample_rate,
                                    config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].codec_param.msbc.channel_mode,
                                    payload_size,
                                    config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].share_info,
                                    ((n9_dsp_share_info_t *)(config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].share_info))->start_addr);
            } else if (config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].codec_type == AUDIO_DSP_CODEC_TYPE_CVSD) {
                bt_in->channel_num   = 1;
                bt_in->sample_rate   = 8000;
                hal_audio_set_hfp_avm_info(bt_in->bt_info[i].share_info, AUDIO_BT_HFP_SHARE_BUF_PARTTERN_TOTAL_SIZE, AUDIO_BT_CVSD_SHARE_BUF_FRAME_SIZE);
            } else {
                TRANSMITTER_LOG_I("[BT Audio][DL] codec type error %d", 1, config->scenario_config.bt_audio_dongle_config.ul_info.source.bt_in.bt_info[i].codec_type);
                AUDIO_ASSERT(0);
            }
            if ((((n9_dsp_share_info_t *)(bt_in->bt_info[i].share_info))->sub_info.block_info.block_size) != ((payload_size + 3)/4*4)) {
                TRANSMITTER_LOG_E("[BT Audio][UL][ERROR]Error packet size %d, %d\r\n", 2, payload_size, (((n9_dsp_share_info_t *)(bt_in->bt_info[i].share_info))->sub_info.block_info.block_size));
                // AUDIO_ASSERT(0);
            }
            TRANSMITTER_LOG_I("[BT Audio][UL] BT source share buffer info 0x%x size %d addr 0x%x wo %d ro %d block size %d block number %d", 7,
                (n9_dsp_share_info_t *)(bt_in->bt_info[i].share_info),
                ((n9_dsp_share_info_t *)(bt_in->bt_info[i].share_info))->length,
                ((n9_dsp_share_info_t *)(bt_in->bt_info[i].share_info))->start_addr,
                ((n9_dsp_share_info_t *)(bt_in->bt_info[i].share_info))->write_offset,
                ((n9_dsp_share_info_t *)(bt_in->bt_info[i].share_info))->read_offset,
                ((n9_dsp_share_info_t *)(bt_in->bt_info[i].share_info))->sub_info.block_info.block_size,
                ((n9_dsp_share_info_t *)(bt_in->bt_info[i].share_info))->sub_info.block_info.block_num
                );
        } else {
            open_param->stream_in_param.bt_common.scenario_param.bt_audio_dongle_param.ul_info.source.bt_in.bt_info[i].share_info = NULL;
        }
    }
    bt_in->frame_samples = bt_in->frame_interval * bt_in->sample_rate / 1000 / 1000;
    bt_in->frame_size    = bt_in->frame_samples * format_bytes;
    /* prepare default gain settings */
    // open_param->stream_in_param.bt_common.scenario_param.bt_audio_dongle_param.gain_default_L = -12000; // -120.00dB
    // open_param->stream_in_param.bt_common.scenario_param.bt_audio_dongle_param.gain_default_R = -12000; // -120.00dB
    /* config nvdm: plc / rx nr / drc */
    DSP_FEATURE_TYPE_LIST AudioFeatureList_bt_source_hfp_ul[2] = {FUNC_END, FUNC_END};
#ifndef AIR_AIRDUMP_ENABLE
    AudioFeatureList_bt_source_hfp_ul[0] = FUNC_RX_NR;
#else
    AudioFeatureList_bt_source_hfp_ul[0] = FUNC_PLC;
#endif
    audio_nvdm_reset_sysram();
    sysram_status_t status = audio_nvdm_set_feature(2, AudioFeatureList_bt_source_hfp_ul);
    if (status != NVDM_STATUS_NAT_OK) {
        TRANSMITTER_LOG_E("[BT Audio][UL] failed to set parameters to share memory - err(%d)\r\n", 1, status);
        AUDIO_ASSERT(0);
    }
    TRANSMITTER_LOG_I("[BT Audio][UL] BT in: sub id [%d] codec %d, fs %d, ch %d, format %d, frame samples %d, frame size %d, frame interval %d bit_rate %d link_num %d", 10,
        open_param->stream_in_param.bt_common.scenario_sub_id,
        bt_in->codec_type,
        bt_in->sample_rate,
        bt_in->channel_num,
        bt_in->sample_format,
        bt_in->frame_samples,
        bt_in->frame_size,
        bt_in->frame_interval,
        bt_in->bit_rate,
        bt_in->link_num
        );
}
/****************************************************************************************************************************************************/
/*                                                      AFE IN COMMON                                                                               */
/****************************************************************************************************************************************************/
#if defined(AIR_BT_AUDIO_DONGLE_I2S_IN_ENABLE) || defined(AIR_BT_AUDIO_DONGLE_LINE_IN_ENABLE)
static void bt_audio_dongle_open_stream_in_afe(audio_transmitter_config_t *config, mcu2dsp_open_param_t *open_param)
{
    audio_dongle_set_stream_in_afe(config, open_param);
    TRANSMITTER_LOG_I("[BT Audio][DL] afe setting: sub_id[%d], device %u, interface %u, format %u, hwsrc input rate %d, hwsrc output rate %d, frame size %d, frame number %d\r\n", 8,
        config->scenario_sub_id,
        open_param->stream_in_param.afe.audio_device,
        open_param->stream_in_param.afe.audio_interface,
        open_param->stream_in_param.afe.format,
        open_param->stream_in_param.afe.sampling_rate,
        open_param->stream_in_param.afe.stream_out_sampling_rate,
        open_param->stream_in_param.afe.frame_size,
        open_param->stream_in_param.afe.frame_number
        );
}
#endif /* afe in */
/* Public functions ----------------------------------------------------------*/

void bt_audio_dongle_open_playback(audio_transmitter_config_t *config, mcu2dsp_open_param_t *open_param)
{
    switch (config->scenario_sub_id) {
#ifdef AIR_BT_AUDIO_DONGLE_USB_ENABLE
        /* DL HFP Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_1:
            /* config dl source: usb in */
            bt_audio_dongle_open_stream_in_usb(config, open_param);
            /* config dl sink  : bt out */
            bt_audio_dongle_open_stream_out_bt(config, open_param);
            break;
        /* HFP UL Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_1:
            /* config ul source: bt in */
            bt_audio_dongle_open_stream_in_bt(config, open_param);
            /* config ul sink  : usb out */
            bt_audio_dongle_open_stream_out_usb(config, open_param);
            break;
#endif
#if defined(AIR_BT_AUDIO_DONGLE_I2S_IN_ENABLE) || defined(AIR_BT_AUDIO_DONGLE_LINE_IN_ENABLE)
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_2:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_2:
            /* config dl sink  : usb out */
            bt_audio_dongle_open_stream_out_bt(config, open_param);
            /* config dl source: bt in */
            bt_audio_dongle_open_stream_in_afe(config, open_param);
            break;
#endif
        default:
            break;
    }
}

void bt_audio_dongle_start_playback(audio_transmitter_config_t *config, mcu2dsp_start_param_t *start_param)
{
    switch (config->scenario_sub_id) {
#ifdef AIR_BT_AUDIO_DONGLE_USB_ENABLE
        /* DL HFP Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_1:
            start_param->param.stream_in  = STREAM_IN_AUDIO_TRANSMITTER;
            start_param->param.stream_out = STREAM_OUT_BT_COMMON;
            break;
        /* HFP UL Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_1:
            start_param->param.stream_in  = STREAM_IN_BT_COMMON;
            start_param->param.stream_out = STREAM_OUT_AUDIO_TRANSMITTER;
            break;
#endif
#if defined(AIR_BT_AUDIO_DONGLE_I2S_IN_ENABLE) || defined(AIR_BT_AUDIO_DONGLE_LINE_IN_ENABLE)
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_2:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_2:
            audio_dongle_set_start_avm_config(config, start_param);
            break;
#endif
        default:
            break;
    }
}

audio_transmitter_status_t bt_audio_dongle_set_runtime_config_playback(audio_transmitter_config_t *config, audio_transmitter_runtime_config_type_t runtime_config_type, audio_transmitter_runtime_config_t *runtime_config, mcu2dsp_audio_transmitter_runtime_config_param_t *runtime_config_param)
{
    audio_transmitter_status_t ret = AUDIO_TRANSMITTER_STATUS_FAIL;
    // uint32_t operation = runtime_config_type;
    // vol_gain_t gain;
    // uint8_t mix_ratio = 0;
    // int32_t vol_gain;
    // int32_t vol_level;
    switch (config->scenario_sub_id) {
#ifdef AIR_BT_AUDIO_DONGLE_USB_ENABLE
        /* DL HFP Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_1:

            break;
        /* HFP UL Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_1:

            break;
#endif
#if defined(AIR_BT_AUDIO_DONGLE_I2S_IN_ENABLE) || defined(AIR_BT_AUDIO_DONGLE_LINE_IN_ENABLE)
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_2:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_2:
            break;
#endif
        default:
            break;
    }
    return ret;
}

audio_transmitter_status_t bt_audio_dongle_get_runtime_config(uint8_t scenario_type, uint8_t scenario_sub_id, audio_transmitter_runtime_config_type_t runtime_config_type, audio_transmitter_runtime_config_t *runtime_config)
{
    audio_transmitter_status_t ret = AUDIO_TRANSMITTER_STATUS_FAIL;
    switch (scenario_sub_id) {
#ifdef AIR_BT_AUDIO_DONGLE_USB_ENABLE
        /* DL HFP Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_1:

            break;
        /* HFP UL Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_1:

            break;
#endif
#if defined(AIR_BT_AUDIO_DONGLE_I2S_IN_ENABLE) || defined(AIR_BT_AUDIO_DONGLE_LINE_IN_ENABLE)
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_2:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_2:
            break;
#endif
        default:
            break;
    }
    return ret;
}

void bt_audio_dongle_state_started_handler(uint8_t scenario_sub_id)
{
    switch (scenario_sub_id) {
#ifdef AIR_BT_AUDIO_DONGLE_USB_ENABLE
        /* DL HFP Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_0:
            #if defined(AIR_USB_AUDIO_1_SPK_ENABLE)
                #if AIR_AUDIO_DONGLE_DEBUG_LANTENCY
                audio_dongle_usb_rx_handle[0].latency_debug_enable = 0;
                audio_dongle_usb_rx_handle[0].latency_debug_gpio_pin = HAL_GPIO_13;
                #endif /* AIR_AUDIO_DONGLE_DEBUG_LANTENCY */
                USB_Audio_Register_Rx_Callback(0, audio_dongle_usb0_rx_cb);
                TRANSMITTER_LOG_I("[BT Audio] Register audio_dongle_usb0_rx_cb", 0);
            #else
                AUDIO_ASSERT(0 && "[BT Audio] please enable AIR_USB_AUDIO_1_SPK_ENABLE");
            #endif
            break;
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_1:
            #if defined(AIR_USB_AUDIO_2_SPK_ENABLE)
                #if AIR_AUDIO_DONGLE_DEBUG_LANTENCY
                audio_dongle_usb_rx_handle[1].latency_debug_enable = 0;
                audio_dongle_usb_rx_handle[1].latency_debug_gpio_pin = HAL_GPIO_13;
                #endif /* AIR_AUDIO_DONGLE_DEBUG_LANTENCY */
                USB_Audio_Register_Rx_Callback(1, audio_dongle_usb1_rx_cb);
                TRANSMITTER_LOG_I("[BT Audio] Register audio_dongle_usb1_rx_cb", 0);
            #else
                AUDIO_ASSERT(0 && "[BT Audio] please enable AIR_USB_AUDIO_2_SPK_ENABLE");
            #endif
            break;
        /* HFP UL Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_1:
            #if defined(AIR_USB_AUDIO_1_SPK_ENABLE)
                #if AIR_AUDIO_DONGLE_DEBUG_LANTENCY
                audio_dongle_usb_tx_handle[0].latency_debug_enable = 0;
                audio_dongle_usb_tx_handle[0].latency_debug_gpio_pin = HAL_GPIO_13;
                #endif /* AIR_AUDIO_DONGLE_DEBUG_LANTENCY */
                USB_Audio_Register_Tx_Callback(0, audio_dongle_usb0_tx_cb);
                TRANSMITTER_LOG_I("[BT Audio] Register audio_dongle_usb0_tx_cb", 0);
            #else
                AUDIO_ASSERT(0 && "[BT Audio] please enable AIR_USB_AUDIO_1_SPK_ENABLE");
            #endif
            break;
#endif
#if defined(AIR_BT_AUDIO_DONGLE_I2S_IN_ENABLE) || defined(AIR_BT_AUDIO_DONGLE_LINE_IN_ENABLE)
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_2:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_2:
            break;
#endif
        default:
            break;
    }
}

void bt_audio_dongle_state_idle_handler(uint8_t scenario_sub_id)
{
    switch (scenario_sub_id) {
#ifdef AIR_BT_AUDIO_DONGLE_USB_ENABLE
        /* DL HFP Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_0:
            #if defined(AIR_USB_AUDIO_1_SPK_ENABLE)
                #if AIR_AUDIO_DONGLE_DEBUG_LANTENCY
                audio_dongle_usb_rx_handle[0].latency_debug_enable = 0;
                #endif /* AIR_AUDIO_DONGLE_DEBUG_LANTENCY */
                USB_Audio_Register_Rx_Callback(0, NULL);
                TRANSMITTER_LOG_I("[BT Audio] UN-Register audio_dongle_usb0_rx_cb", 0);
            #else
                AUDIO_ASSERT(0 && "[BT Audio] please enable AIR_USB_AUDIO_1_SPK_ENABLE");
            #endif
            break;
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_1:
            #if defined(AIR_USB_AUDIO_2_SPK_ENABLE)
                #if AIR_AUDIO_DONGLE_DEBUG_LANTENCY
                audio_dongle_usb_rx_handle[1].latency_debug_enable = 0;
                #endif /* AIR_AUDIO_DONGLE_DEBUG_LANTENCY */
                USB_Audio_Register_Rx_Callback(1, NULL);
                TRANSMITTER_LOG_I("[BT Audio] UN-Register audio_dongle_usb1_rx_cb", 0);
            #else
                AUDIO_ASSERT(0 && "[BT Audio] please enable AIR_USB_AUDIO_2_SPK_ENABLE");
            #endif
            break;
        /* HFP UL Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_1:
            #if defined(AIR_USB_AUDIO_1_SPK_ENABLE)
                #if AIR_AUDIO_DONGLE_DEBUG_LANTENCY
                audio_dongle_usb_tx_handle[0].latency_debug_enable = 0;
                #endif /* AIR_AUDIO_DONGLE_DEBUG_LANTENCY */
                USB_Audio_Register_Tx_Callback(0, NULL);
                TRANSMITTER_LOG_I("[BT Audio] UN-Register audio_dongle_usb0_tx_cb", 0);
            #else
                AUDIO_ASSERT(0 && "[BT Audio] please enable AIR_USB_AUDIO_1_SPK_ENABLE");
            #endif
            break;
#endif
#if defined(AIR_BT_AUDIO_DONGLE_I2S_IN_ENABLE) || defined(AIR_BT_AUDIO_DONGLE_LINE_IN_ENABLE)
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_2:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_2:
            break;
#endif
        default:
            break;
    }
}

void bt_audio_dongle_state_starting_handler(uint8_t scenario_sub_id)
{
    TRANSMITTER_LOG_I("[BT Audio][sub id %d] state start", 1, scenario_sub_id);
    #if defined(AIR_BTA_IC_PREMIUM_G2)
    hal_dvfs_lock_control(HAL_DVFS_HIGH_SPEED_208M, HAL_DVFS_LOCK);
    #else
    hal_dvfs_lock_control(HAL_DVFS_OPP_HIGH, HAL_DVFS_LOCK);
    #endif
    switch (scenario_sub_id) {
#ifdef AIR_BT_AUDIO_DONGLE_USB_ENABLE
        /* DL HFP Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_0:
            audio_dongle_usb_rx_handle[0].stream_is_started = 1;
            audio_dongle_usb_rx_handle[0].dongle_stream_status |= (1 << scenario_sub_id);
            break;
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_1:
            audio_dongle_usb_rx_handle[1].stream_is_started = 1;
            audio_dongle_usb_rx_handle[1].dongle_stream_status |= (1 << scenario_sub_id);
            break;
        /* HFP UL Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_1:
            audio_dongle_usb_tx_handle[0].stream_is_started = 1;
            audio_dongle_usb_tx_handle[0].dongle_stream_status |= (1 << scenario_sub_id);
            break;
#endif
#if defined(AIR_BT_AUDIO_DONGLE_I2S_IN_ENABLE) || defined(AIR_BT_AUDIO_DONGLE_LINE_IN_ENABLE)
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_2:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_2:
            break;
#endif
        default:
            break;
    }
}

void bt_audio_dongle_state_stopping_handler(uint8_t scenario_sub_id)
{
    TRANSMITTER_LOG_I("[BT Audio][sub id %d] state stop", 1, scenario_sub_id);
    #if defined(AIR_BTA_IC_PREMIUM_G2)
    hal_dvfs_lock_control(HAL_DVFS_HIGH_SPEED_208M, HAL_DVFS_UNLOCK);
    #else
    hal_dvfs_lock_control(HAL_DVFS_OPP_HIGH, HAL_DVFS_UNLOCK);
    #endif
    switch (scenario_sub_id) {
#ifdef AIR_BT_AUDIO_DONGLE_USB_ENABLE
        /* DL HFP Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_0:
            audio_dongle_usb_rx_handle[0].stream_is_started = 0;
            audio_dongle_usb_rx_handle[0].dongle_stream_status &= ~(1 << scenario_sub_id);
            if (audio_dongle_usb_rx_handle[0].dongle_stream_status == 0) {
                memset(&audio_dongle_usb_rx_handle[0], 0, sizeof(audio_dongle_usb_handle_t));
            }
            break;
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_1:
            audio_dongle_usb_rx_handle[1].stream_is_started = 0;
            audio_dongle_usb_rx_handle[1].dongle_stream_status &= ~(1 << scenario_sub_id);
            if (audio_dongle_usb_rx_handle[1].dongle_stream_status == 0) {
                memset(&audio_dongle_usb_rx_handle[1], 0, sizeof(audio_dongle_usb_handle_t));
            }
            break;
        /* HFP UL Path */
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_1:
            audio_dongle_usb_tx_handle[0].stream_is_started = 0;
            audio_dongle_usb_tx_handle[0].dongle_stream_status &= ~(1 << scenario_sub_id);
            if (audio_dongle_usb_tx_handle[0].dongle_stream_status == 0) {
                memset(&audio_dongle_usb_tx_handle[0], 0, sizeof(audio_dongle_usb_handle_t));
            }
            break;
#endif
#if defined(AIR_BT_AUDIO_DONGLE_I2S_IN_ENABLE) || defined(AIR_BT_AUDIO_DONGLE_LINE_IN_ENABLE)
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_AFE_IN_2:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_0:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_1:
        case AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_AFE_IN_2:
            break;
#endif
        default:
            break;
    }
}

#ifdef AIR_BT_AUDIO_DONGLE_USB_ENABLE
audio_transmitter_status_t bt_audio_dongle_read_data_from_usb(uint32_t scenario_sub_id, uint8_t *data, uint32_t *length)
{
    uint8_t usb_rx_port = 0;
    if ((scenario_sub_id == AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_0) ||
        (scenario_sub_id == AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_0)) {
        usb_rx_port = 0;
    } else if ((scenario_sub_id == AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_HFP_USB_IN_1) ||
               (scenario_sub_id == AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_DL_A2DP_USB_IN_1)) {
        usb_rx_port = 1;
    } else {
        AUDIO_ASSERT(0 && "[BT Audio][DL] Error sub id");
    }
    if (audio_dongle_read_data_from_usb(usb_rx_port, data, length) == false) {
        return AUDIO_TRANSMITTER_STATUS_FAIL;
    }
    return AUDIO_TRANSMITTER_STATUS_SUCCESS;
}

audio_transmitter_status_t bt_audio_dongle_write_data_to_usb(uint32_t scenario_sub_id, uint8_t *data, uint32_t *length)
{
    uint8_t usb_tx_port = 0;
    if (scenario_sub_id == AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_0) {
        usb_tx_port = 0;
    } else if (scenario_sub_id == AUDIO_TRANSMITTER_BT_AUDIO_DONGLE_UL_HFP_USB_OUT_1) {
        usb_tx_port = 1;
    } else {
        AUDIO_ASSERT(0 && "[BT Audio][UL] Error sub id");
    }
    if (audio_dongle_write_data_to_usb(usb_tx_port, data, length) == false) {
        return AUDIO_TRANSMITTER_STATUS_FAIL;
    }
    return AUDIO_TRANSMITTER_STATUS_SUCCESS;
}
#endif /* AIR_BT_AUDIO_DONGLE_USB_ENABLE */
#endif /* AIR_BT_AUDIO_DONGLE_ENABLE */
