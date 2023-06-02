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

/* Includes ------------------------------------------------------------------*/
#include "sbc_encoder_interface.h"
#include "sbc_encoder_portable.h"
#include "dsp_sdk.h"
#include "dsp_dump.h"
#include "preloader_pisplit.h"
#include "scenario_dongle_common.h"
#include "dsp_callback.h"
#include "dsp_memory.h"
#include "hal_gpt.h"
/* Private define ------------------------------------------------------------*/
#define SBC_ENCODER_DEBUG_LOG_ENABLE                     (0)
/* Private typedef -----------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
sbc_enc_handle_t *sbc_enc_handle = NULL;
static sbc_enc_param_config_t sbc_enc_config = {0};
/* Public variables ----------------------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
log_create_module(sbc_enc_log, PRINT_LEVEL_INFO);
/* Public functions ----------------------------------------------------------*/
extern uint32_t bt_audio_dongle_dl_get_stream_in_max_size_each_channel(SOURCE source, SINK sink);
extern uint32_t bt_audio_dongle_dl_get_stream_out_max_size_each_channel(SOURCE source, SINK sink);

void stream_codec_encoder_sbc_init(sbc_enc_param_config_t *config)
{
    if (sbc_enc_config.init) {
        SBC_ENC_LOG_W("sbc enc library config is already done", 0);
    } else {
        memcpy(&sbc_enc_config, config, sizeof(sbc_enc_param_config_t));
    }
}

void stream_codec_encoder_sbc_deinit(void)
{
    sbc_enc_handle->user_cnt --;
    if (sbc_enc_handle->user_cnt == 0) {
        if (sbc_enc_handle->param.channel_mode != SBC_ENCODER_MONO) {
            free(sbc_enc_handle->input_working_buffer);
            free(sbc_enc_handle->output_working_buffer);
            sbc_enc_handle->input_working_buffer = NULL;
            sbc_enc_handle->output_working_buffer = NULL;
        }
        free(sbc_enc_handle);
        sbc_enc_handle = NULL;
        memset(&sbc_enc_config, 0, sizeof(sbc_enc_param_config_t));
    }
}

void stream_codec_encoder_sbc_check_init(void)
{
    if ((!sbc_enc_handle) || (sbc_enc_handle->user_cnt == 0)) {
        /* Config parameters */
        if (!sbc_enc_config.init) {
            assert(0 && "Error: sbc enc lib has no get config func");
        }
        uint32_t sbc_enc_buffer_size = sbc_enc_get_buffer_size();
        sbc_enc_handle = (sbc_enc_handle_t *)malloc(DSP_MEM_SBC_ECN_SIZE + sbc_enc_buffer_size);
        memset(sbc_enc_handle, 0, sizeof(sbc_enc_handle_t));
        SBC_ENC_LOG_I("sbc enc library config successfully", 0);

        memcpy(&(sbc_enc_handle->param), &(sbc_enc_config), sizeof(sbc_encoder_initial_parameter_t));
        sbc_enc_handle->bit_pool.bitpool_value     = sbc_enc_config.bit_pool.bitpool_value;
        sbc_enc_handle->working_buffer_size        = sbc_enc_buffer_size;
        sbc_enc_handle->input_working_buffer_size  = sbc_enc_config.input_working_buffer_size;
        sbc_enc_handle->output_working_buffer_size = sbc_enc_config.output_working_buffer_size;
    } else {
        SBC_ENC_LOG_W("sbc enc library config already", 0);
    }

    sbc_enc_handle->user_cnt ++;
}

bool stream_codec_encoder_sbc_initialize(void *para)
{
    UNUSED(para);
    // DSP_STREAMING_PARA_PTR stream_ptr = DSP_STREAMING_GET_FROM_PRAR(para);
    // malloc for sbc handle
    stream_codec_encoder_sbc_check_init();

    if (sbc_enc_handle->handle) {
        SBC_ENC_LOG_W("sbc enc library is already init", 0);
    } else {
        int32_t  result   = 0;
        uint32_t in_size  = sbc_enc_handle->input_working_buffer_size;
        uint32_t out_size = sbc_enc_handle->output_working_buffer_size;
        result = sbc_encoder_init(&(sbc_enc_handle->handle), &(sbc_enc_handle->ScratchMemory[0]), &(sbc_enc_handle->param));
        if (result < 0) {
            SBC_ENC_LOG_E("sbc enc library is init fail, error %d", 1, result);
            assert(0);
        }
        if (sbc_enc_handle->param.channel_mode == SBC_ENCODER_MONO) {
            sbc_enc_handle->input_working_buffer_size = in_size;
            sbc_enc_handle->output_working_buffer_size = out_size;
        } else {
            sbc_enc_handle->input_working_buffer_size = in_size * 2; // dual channel
            sbc_enc_handle->input_working_buffer = (uint8_t *)malloc(sbc_enc_handle->input_working_buffer_size);
            if (!sbc_enc_handle->input_working_buffer) {
                assert(0 && "sbc enc malloc input working buffer fail");
            }
            sbc_enc_handle->output_working_buffer_size = out_size; // sbc is always one channel
            sbc_enc_handle->output_working_buffer = (uint8_t *)malloc(sbc_enc_handle->output_working_buffer_size);
            if (!sbc_enc_handle->output_working_buffer) {
                assert(0 && "sbc enc malloc output working buffer fail");
            }
        }
        SBC_ENC_LOG_I("sbc enc library init success: handle[0x%x] sample_rate %d block %d s_band number %d mode %d method %d bit pool %d in_ptr 0x%x out_ptr 0x%x in_size %d out_size %d working_buffer size %d", 12,
            sbc_enc_handle->handle,
            sbc_enc_handle->param.sampling_rate,
            sbc_enc_handle->param.block_number,
            sbc_enc_handle->param.subband_number,
            sbc_enc_handle->param.channel_mode,
            sbc_enc_handle->param.allocation_method,
            sbc_enc_handle->bit_pool.bitpool_value,
            sbc_enc_handle->input_working_buffer,
            sbc_enc_handle->output_working_buffer,
            sbc_enc_handle->input_working_buffer_size,
            sbc_enc_handle->output_working_buffer_size,
            sbc_enc_handle->working_buffer_size
            );
    }
    return FALSE;
}

// Attention: this ip can't support processing mono data channel by channel.
ATTR_TEXT_IN_IRAM_LEVEL_2 bool stream_codec_encoder_sbc_process(void *para)
{
    uint32_t channel_number = stream_function_get_channel_number(para);
    if (stream_codec_get_resolution(para) == RESOLUTION_32BIT) {
        assert(0 && "sbc enc lib doesn't support 32bit format");
    }
    if (sbc_enc_handle->param.channel_mode == SBC_ENCODER_MONO) {
        sbc_enc_handle->input_working_buffer = stream_codec_get_input_buffer(para, 1);
        sbc_enc_handle->output_working_buffer = stream_codec_get_output_buffer(para, 1);
    } else {
        uint8_t *input_buffer_l  = stream_codec_get_input_buffer(para, 1);
        //uint8_t *output_buffer_l = stream_codec_get_output_buffer(para, 1);
        uint8_t *input_buffer_r  = stream_codec_get_input_buffer(para, 2);
        //uint8_t *output_buffer_r = stream_codec_get_output_buffer(para, 2);
        // LLL + RRR -> LRLRLR
        if (channel_number == 1) {
            // LLL -> LL LL LL
            input_buffer_r  = input_buffer_l;
        }
        ShareBufferCopy_D_16bit_to_I_16bit_2ch((uint16_t *)input_buffer_l, (uint16_t *)input_buffer_r, (uint16_t *)sbc_enc_handle->input_working_buffer,
            sbc_enc_handle->input_working_buffer_size >> 2);
    }
    int32_t result = 0;
    // DUMP Codec Input Buffer
#ifdef AIR_AUDIO_DUMP_ENABLE
    LOG_AUDIO_DUMP(sbc_enc_handle->input_working_buffer, sbc_enc_handle->input_working_buffer_size, AUDIO_BT_SRC_DONGLE_DL_ENC_IN);
#endif
#if SBC_ENCODER_DEBUG_LOG_ENABLE
    uint32_t count1, count2, count3;
    hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &count1);
    SBC_ENC_LOG_I("sbc enc process enter, handle 0x%x input_buffer 0x%x in_size %d output_buffer 0x%x out_size %d bit_pool %d", 6,
        sbc_enc_handle->handle,
        sbc_enc_handle->input_working_buffer,
        sbc_enc_handle->input_working_buffer_size,
        sbc_enc_handle->output_working_buffer,
        sbc_enc_handle->output_working_buffer_size,
        sbc_enc_handle->bit_pool
        );
#endif
    result = sbc_encoder_process(
        sbc_enc_handle->handle,
        (int16_t *)sbc_enc_handle->input_working_buffer,
        &(sbc_enc_handle->input_working_buffer_size),
        sbc_enc_handle->output_working_buffer,
        &(sbc_enc_handle->output_working_buffer_size),
        &(sbc_enc_handle->bit_pool)
        );
    if (result < 0) {
        SBC_ENC_LOG_E("sbc enc process fail, error %d frame %d", 2, result, sbc_enc_handle->frame_cnt + 1);
        assert(0);
    } else {
#if SBC_ENCODER_DEBUG_LOG_ENABLE
        hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &count2);
        hal_gpt_get_duration_count(count1, count2, &count3);
        SBC_ENC_LOG_I("sbc enc process exit, handle 0x%x input_buffer 0x%x in_size %d output_buffer 0x%x out_size %d bit_pool %d time %d", 7,
            sbc_enc_handle->handle,
            sbc_enc_handle->input_working_buffer,
            sbc_enc_handle->input_working_buffer_size,
            sbc_enc_handle->output_working_buffer,
            sbc_enc_handle->output_working_buffer_size,
            sbc_enc_handle->bit_pool,
            count3
            );
#endif
    }
    sbc_enc_handle->frame_cnt ++;
    // DUMP Codec Output Buffer
#ifdef AIR_AUDIO_DUMP_ENABLE
    LOG_AUDIO_DUMP(sbc_enc_handle->output_working_buffer, sbc_enc_handle->output_working_buffer_size, AUDIO_BT_SRC_DONGLE_DL_ENC_OUT);
#endif
    if (channel_number == 2) {
        // LRLRLR -> LLL + RRR
        // ShareBufferCopy_I_16bit_to_D_16bit_2ch(sbc_enc_handle->output_working_buffer, )
        memcpy(stream_codec_get_output_buffer(para, 1), sbc_enc_handle->output_working_buffer, sbc_enc_handle->output_working_buffer_size);
    }
    // change next params for next feature: resolution, output size, input size, channel number etc.
    stream_codec_modify_output_size(para, sbc_enc_handle->output_working_buffer_size);
    return FALSE;
}
