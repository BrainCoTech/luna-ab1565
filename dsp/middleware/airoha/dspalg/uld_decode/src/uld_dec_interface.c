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

#if defined(AIR_AUDIO_ULD_DECODE_ENABLE)

/* Includes ------------------------------------------------------------------*/
#include "dsp_feature_interface.h"
#include "dsp_audio_process.h"
#include "uld_dec_interface.h"
#include "uld_decode_portable.h"
#include "dsp_dump.h"
#include "bt_types.h"
#include "assert.h"
#include "sink_inter.h"
#include "source_inter.h"
#include "memory_attribute.h"
#include "preloader_pisplit.h"

#define MAX_ULD_DEC_CHANNEL_NUMBER 4
#define MAX_ULD_DEC_PLC_DROP_NUMBER 50

static void *g_uld_dec_lib_working_buffer[MAX_ULD_DEC_CHANNEL_NUMBER];
static uld_dec_port_para_t g_uld_dec_port_para;
static uint32_t g_uld_dec_usr_cnt;
static bool g_uld_dec_init_is_needed;

static uint32_t uld_fs_converter(stream_samplerate_t fs)
{
    switch (fs) {
        case FS_RATE_44_1K:
            return 44100;

        case FS_RATE_8K:
        case FS_RATE_16K:
        case FS_RATE_24K:
        case FS_RATE_25K:
        case FS_RATE_32K:
        case FS_RATE_48K:
        case FS_RATE_50K:
        case FS_RATE_96K:
            return fs * 1000;

        default:
            DSP_MW_LOG_E("[uld][dec] sample rate is not supported!", 0);
            AUDIO_ASSERT(FALSE);
            return fs;
    }
}

uld_dec_status_t stream_codec_decoder_uld_init(void *user, uld_dec_port_config_t *config)
{
    uint32_t saved_mask;

    AUDIO_ASSERT((user != NULL) && (config != NULL) && (config->in_channel_num <= MAX_ULD_DEC_CHANNEL_NUMBER));

    hal_nvic_save_and_set_interrupt_mask(&saved_mask);

    if (g_uld_dec_usr_cnt == 0) {
        g_uld_dec_init_is_needed = true;
    }

    if (g_uld_dec_usr_cnt++ != 0) {
        hal_nvic_restore_interrupt_mask(saved_mask);
        return ULD_DEC_STATUS_OK;
    }

    /* update status */
    g_uld_dec_port_para.status = ULD_DEC_PORT_STATUS_INIT;
    /* config codec informations */
    g_uld_dec_port_para.bit_rate    = config->bit_rate;
    g_uld_dec_port_para.in_channel_num = config->in_channel_num;

    g_uld_dec_port_para.user = NULL;

    hal_nvic_restore_interrupt_mask(saved_mask);

    return ULD_DEC_STATUS_OK;
}

uld_dec_status_t stream_codec_decoder_uld_deinit(void *user)
{
    uint32_t saved_mask;

    AUDIO_ASSERT(user != NULL);

    hal_nvic_save_and_set_interrupt_mask(&saved_mask);

    if (g_uld_dec_usr_cnt-- > 1) {
        hal_nvic_restore_interrupt_mask(saved_mask);
        return ULD_DEC_STATUS_OK;
    }

    /* reset codec informations */
    g_uld_dec_port_para.bit_rate = 0;
    g_uld_dec_port_para.in_channel_num = 0;
    g_uld_dec_port_para.user = NULL;
    g_uld_dec_port_para.status = ULD_DEC_PORT_STATUS_DEINIT;

    hal_nvic_restore_interrupt_mask(saved_mask);

    return ULD_DEC_STATUS_OK;
}


bool stream_codec_decoder_uld_initialize(void *para)
{
    uint32_t i, saved_mask;
    ULD_Dec_ErrCode uld_ret;
    stream_samplerate_t uld_sample_rate_enum;
    uint32_t uld_sample_cnt, uld_sample_rate;
    int32_t uld_version;

    hal_nvic_save_and_set_interrupt_mask(&saved_mask);
    if (g_uld_dec_init_is_needed == false) {
        hal_nvic_restore_interrupt_mask(saved_mask);
        DSP_MW_LOG_I("[uld][dec] bypass init", 0);
        return false;
    }
    g_uld_dec_init_is_needed = false;

    g_uld_dec_port_para.status = ULD_DEC_PORT_STATUS_RUNNING;
    hal_nvic_restore_interrupt_mask(saved_mask);

    uld_version = ULD_Dec_Get_Version();

    for (i = 0; i < g_uld_dec_port_para.in_channel_num; i++) {
        g_uld_dec_lib_working_buffer[i] = preloader_pisplit_malloc_memory(PRELOADER_D_HIGH_PERFORMANCE, ULD_Dec_Get_MemSize(uld_version));
        AUDIO_ASSERT(g_uld_dec_lib_working_buffer[i] != NULL);
    }

    uld_sample_rate_enum = (stream_samplerate_t)stream_codec_get_input_samplingrate(para);
    uld_sample_rate = uld_fs_converter(uld_sample_rate_enum);
    uld_sample_cnt = uld_sample_rate / 1000;
    for (i = 0; i < g_uld_dec_port_para.in_channel_num; i++) {
        uld_ret = ULD_Dec_Init(g_uld_dec_lib_working_buffer[i], uld_sample_rate, uld_sample_cnt, C_200K_DEC_BS_NUM, MAX_ULD_DEC_PLC_DROP_NUMBER, uld_version);
        AUDIO_ASSERT(uld_ret == ULD_DEC_OK);
    }

    DSP_MW_LOG_I("[uld][dec] init done, %d, %d, %d, %d, 0x%8x", 5, uld_sample_rate, uld_sample_cnt, C_200K_DEC_BS_NUM, MAX_ULD_DEC_PLC_DROP_NUMBER, uld_version);

    return false;
}

ATTR_TEXT_IN_IRAM bool stream_codec_decoder_uld_process(void *para)
{
    uint8_t *in_buf, *out_buf;
    uint32_t i, out_frame_size;
    ULD_Dec_ErrCode uld_ret;
    stream_samplerate_t uld_sample_rate_enum;
    uint32_t uld_sample_cnt, uld_sample_rate;
    stream_resolution_t resolution;
    uld_dec_frame_status_t frame_status;
    bool uld_packet_loss_flag;

    /* in buffer is not same as out buffer */
    in_buf = (uint8_t *)stream_codec_get_1st_input_buffer(para);

    frame_status = *(uld_dec_frame_status_t *)in_buf;
    if (frame_status == ULD_DEC_FRAME_STATUS_BYPASS_DECODER) {
        //DSP_MW_LOG_I("[uld][dec] bypass decoder", 0);
        out_frame_size = 0;
    } else {
        for (i = 0; i < g_uld_dec_port_para.in_channel_num; i++) {
            in_buf = (uint8_t *)stream_codec_get_input_buffer(para, i + 1);
            frame_status = *(uld_dec_frame_status_t *)in_buf;
            in_buf += sizeof(uld_dec_frame_status_t);
            out_buf = (uint8_t *)stream_codec_get_output_buffer(para, i + 1);
            if (frame_status == ULD_DEC_FRAME_STATUS_PLC) {
                //DSP_MW_LOG_I("[uld][dec] channel %d do PLC process", 1, i + 1);
                memset(in_buf, 0, C_200K_DEC_BS_NUM);
                uld_packet_loss_flag = true;
            } else {
                uld_packet_loss_flag = false;
            }
            uld_ret = ULD_Dec_Prcs(g_uld_dec_lib_working_buffer[i], (char *)in_buf, (int32_t *)out_buf, (int16_t)uld_packet_loss_flag);
            AUDIO_ASSERT(uld_ret == ULD_DEC_OK);
        }
        uld_sample_rate_enum = (stream_samplerate_t)stream_codec_get_input_samplingrate(para);
        uld_sample_rate = uld_fs_converter(uld_sample_rate_enum);
        uld_sample_cnt = uld_sample_rate / 1000;
        resolution = stream_codec_get_input_resolution(para);
        if (resolution == RESOLUTION_16BIT) {
            out_frame_size = uld_sample_cnt * sizeof(uint16_t);
        } else {
            out_frame_size = uld_sample_cnt * sizeof(uint32_t);
        }
    }

    stream_codec_modify_output_size(para, out_frame_size);
    stream_codec_modify_output_samplingrate(para, stream_codec_get_input_samplingrate(para));
    stream_codec_modify_resolution(para, stream_codec_get_input_resolution(para));

    return false;
}

#endif

