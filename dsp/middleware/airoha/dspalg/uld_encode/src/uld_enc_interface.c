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

#if defined(AIR_AUDIO_ULD_ENCODE_ENABLE)

/* Includes ------------------------------------------------------------------*/
#include "dsp_feature_interface.h"
#include "dsp_audio_process.h"
#include "uld_enc_interface.h"
#include "uld_encode_portable.h"
#include "dsp_dump.h"
#include "bt_types.h"
#include "assert.h"
#include "sink_inter.h"
#include "source_inter.h"
#include "memory_attribute.h"
#include "preloader_pisplit.h"

static void *g_uld_enc_lib_working_buffer;

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
            DSP_MW_LOG_E("[uld][enc] sample rate is not supported!", 0);
            AUDIO_ASSERT(FALSE);
            return fs;
    }
}

bool stream_codec_encoder_uld_initialize(void *para)
{
    ULD_Enc_ErrCode uld_ret;
    stream_samplerate_t uld_sample_rate_enum;
    uint32_t uld_sample_cnt, uld_sample_rate;
    int32_t uld_version;

    uld_version = ULD_Enc_Get_Version();

    g_uld_enc_lib_working_buffer = preloader_pisplit_malloc_memory(PRELOADER_D_HIGH_PERFORMANCE, ULD_Enc_Get_MemSize(uld_version));
    AUDIO_ASSERT(g_uld_enc_lib_working_buffer != NULL);

    uld_sample_rate_enum = (stream_samplerate_t)stream_function_get_samplingrate(para);
    uld_sample_rate = uld_fs_converter(uld_sample_rate_enum);
    uld_sample_cnt = uld_sample_rate / 1000;
    uld_ret = ULD_Enc_Init(g_uld_enc_lib_working_buffer, uld_sample_rate, uld_sample_cnt, C_200K_ENC_BS_NUM, uld_version);
    AUDIO_ASSERT(uld_ret == ULD_ENC_OK);

    DSP_MW_LOG_I("[uld][enc] init done, %d, %d, %d, 0x%8x", 4, uld_sample_rate, uld_sample_cnt, C_200K_ENC_BS_NUM, uld_version);
    
    return false;
}

bool stream_codec_encoder_uld_process(void *para)
{
    uint8_t *in_buf1;
    uint8_t out_buf1[C_200K_ENC_BS_NUM + 4]; /* align to 4 byte */
    ULD_Enc_ErrCode uld_ret;

    in_buf1 = (uint8_t *)stream_function_get_1st_inout_buffer(para);

#ifdef AIR_AUDIO_DUMP_ENABLE
    LOG_AUDIO_DUMP((uint8_t *)(in_buf1), stream_codec_get_input_size(para), ULD_ENCODE_IN);
#endif

    uld_ret = ULD_Enc_Prcs(g_uld_enc_lib_working_buffer, (int32_t *)in_buf1, (char *)out_buf1);
    AUDIO_ASSERT(uld_ret == ULD_ENC_OK);

#ifdef AIR_AUDIO_DUMP_ENABLE
    LOG_AUDIO_DUMP((uint8_t *)(out_buf1), stream_codec_get_output_size(para), ULD_ENCODE_OUT);
#endif

    memcpy(in_buf1, (const void *)out_buf1, C_200K_ENC_BS_NUM);

    stream_codec_modify_output_size(para, C_200K_ENC_BS_NUM);

    return false;
}

#endif

