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
 
#include <string.h>
#include "dsp_feature_interface.h"
#include "dsp_utilities.h"
#include "dsp_buffer.h"
#include "dsp_dump.h"
#include "dsp_callback.h"
#include "source_inter.h"
#include "vendor_2_dec_interface.h"
#include "ch_select_interface.h"

#ifdef MTK_BT_A2DP_VENDOR_2_USE_PIC
#include "vendor_2_dec_portable.h"
#endif

//#define AIROHA_MEASURE_DECODE_TIME
DSP_ALIGN8 LHDCV5DEC_HAD_PTR LHDCV5DEC_INSTANCE;

static int32_t vendor_2_decoder_convert_16bits_to_32bits (uint8_t *out, int16_t *in, uint32_t samples)
{
	int32_t *pout = (int32_t*)out;

    for (uint32_t i = 0; i < samples; i++) {
      *pout = ((int32_t)in[i] << 16); pout++;
    }

    return samples * sizeof(int32_t);
}

static int32_t vendor_2_decoder_convert_24bits_to_32bits (uint8_t *out, int32_t *in, uint32_t samples)
{
	int32_t *pout = (int32_t*)out;

    for (uint32_t i = 0; i < samples; i++) {
      *pout = (in[i] << 8); pout++;
    }

    return samples * sizeof(int32_t);
}

bool vendor_2_decoder_initialize (void *para)
{
    DSP_STREAMING_PARA_PTR stream_ptr;
    stream_ptr = DSP_STREAMING_GET_FROM_PRAR(para);
	U32  resolution = stream_ptr->source->param.n9_a2dp.codec_info.codec_cap.codec.vend.resolution;
	U32  sample_rate = stream_codec_get_input_samplingrate(para);
	U32 ret;
	U32 mem_req_bytes;
    
	LHDCV5DEC_INSTANCE = (LHDCV5DEC_HAD*)stream_codec_get_workingbuffer(para);

	switch (sample_rate)
	{
		case FS_RATE_44_1K:
			LHDCV5DEC_INSTANCE->sample_rate_val = 44100;
			break;
		case FS_RATE_48K:
			LHDCV5DEC_INSTANCE->sample_rate_val = 48000;
			break;
		case FS_RATE_96K:
			LHDCV5DEC_INSTANCE->sample_rate_val = 96000;
			break;
		case FS_RATE_192K:
			LHDCV5DEC_INSTANCE->sample_rate_val = 192000;
			break;
		default:
			DSP_MW_LOG_E("[vendor_2] sample_rate %d not support", 1, sample_rate);
			break;
	}

	switch (resolution)
	{
		case 1:
			LHDCV5DEC_INSTANCE->resolution_val = 32;
			break;
		case 2:
			LHDCV5DEC_INSTANCE->resolution_val = 24;
			break;
		case 4:
			LHDCV5DEC_INSTANCE->resolution_val = 16;
			break;
		default:
			DSP_MW_LOG_E("[vendor_2] resolution %d not support", 1, resolution);
			break;
	}
	uint32_t loss_enable = 1;

	ret = lhdcv5_util_dec_get_mem_req(VERSION_5, LHDCV5DEC_INSTANCE->sample_rate_val, LHDCV5_AUDIO_FMT_OUT_DAT, loss_enable, &mem_req_bytes);
	if (ret != LHDCV5_UTIL_DEC_SUCCESS)
		DSP_MW_LOG_E("[vendor_2] get memory information error ret %d", 1, ret);
	else
		DSP_MW_LOG_I("[vendor_2] mem_req_bytes (%d)", 1, mem_req_bytes);

    if(mem_req_bytes>DSP_LHDC_HEAP_SIZE){
        DSP_MW_LOG_I("[vendor_2] Not enought memory", 0);
        AUDIO_ASSERT(0);;
    }
	DSP_MW_LOG_I("[vendor_2] sr:%d, br:%d", 2, LHDCV5DEC_INSTANCE->sample_rate_val, LHDCV5DEC_INSTANCE->resolution_val);
	ret = lhdcv5_util_init_decoder((U32 *)LHDCV5DEC_INSTANCE->ptr, LHDCV5DEC_INSTANCE->resolution_val, LHDCV5DEC_INSTANCE->sample_rate_val, LHDCV5_AUDIO_FMT_OUT_DAT, LHDCV5_FRAME_DURATION_5MS, loss_enable, VERSION_5);

	if (ret != LHDCV5_UTIL_DEC_SUCCESS) DSP_MW_LOG_E("[vendor_2] init error ret %d", 1, ret);

    return FALSE;
}

bool vendor_2_decoder_process (void *para)
{
	U32 ret;//,i,*temp_buf;
    U8* InBuf = stream_codec_get_1st_input_buffer(para);
    U8* OutBufL = stream_codec_get_1st_output_buffer(para);
    U8* OutBufR = stream_codec_get_2nd_output_buffer(para);
	U16 InLength = stream_codec_get_input_size(para);
	lhdc_frame_Info_t h_info;
#ifdef AIROHA_MEASURE_DECODE_TIME	
	U32 gpt_timer,gpt_timer2;
#endif	
	U32 OutLen;

	U32 outlen_per_ch = 0;
	U32 output_size = 0;

#ifdef AIR_AUDIO_DUMP_ENABLE
        LOG_AUDIO_DUMP((U8 *)InBuf, (U32)InLength, AUDIO_CODEC_IN);
        LOG_AUDIO_DUMP((U8 *)&InLength, (U32)2, AUDIO_CODEC_IN_LENGTH);
#endif

	CH_SEL_MODE ch = Ch_Select_Get_Param(CH_SEL_A2DP);
	lhdc_channel_t channel = LHDC_OUTPUT_LEFT_CAHNNEL;
	switch(ch){
		case CH_SEL_STEREO:
			//channel = LHDC_OUTPUT_STEREO;
			channel = LHDC_OUTPUT_LEFT_CAHNNEL;
			break;
		case CH_SEL_MONO:
			//channel = LHDC_OUTPUT_STEREO;
			channel = LHDC_OUTPUT_LEFT_CAHNNEL;
			break;
		case CH_SEL_BOTH_L:
			channel = LHDC_OUTPUT_LEFT_CAHNNEL;
			break;
		case CH_SEL_BOTH_R:
			channel = LHDC_OUTPUT_RIGHT_CAHNNEL;
			break;
		default:
			channel = LHDC_OUTPUT_LEFT_CAHNNEL;
			break;
	}

	ret = lhdcv5_util_dec_channel_selsect((U32 *)LHDCV5DEC_INSTANCE->ptr, channel);
	if (ret != LHDCV5_UTIL_DEC_SUCCESS){
		DSP_MW_LOG_E("[vendor_2] channel select error ret %d", 1, ret);
    }

#ifdef AIR_AUDIO_DUMP_ENABLE
    LOG_AUDIO_DUMP(InBuf, (InLength + 1) & (~1), AUDIO_CODEC_IN);
    LOG_AUDIO_DUMP((U8*)&InLength, (U32)2, AUDIO_CODEC_IN_LENGTH);
#endif
	ret = lhdcv5_util_dec_fetch_frame_info((U32 *)LHDCV5DEC_INSTANCE->ptr, InBuf, InLength, &h_info);
	if (ret != LHDCV5_UTIL_DEC_SUCCESS){
		DSP_MW_LOG_E("[vendor_2] fetch frame error ret %d", 1, ret);
    }
   
    //DSP_MW_LOG_I("[vendor_2] frame size: %d", 1, InLength);
    
	if (InLength != h_info.frame_len)
	{
		DSP_MW_LOG_E("[vendor_2] InLength != h_info.frame_len\n", 0);
	}

#ifdef AIROHA_MEASURE_DECODE_TIME
	hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &gpt_timer);
#endif
	ret = lhdcv5_util_dec_process((U32 *)LHDCV5DEC_INSTANCE->ptr, LHDCV5DEC_INSTANCE->outbuf, InBuf, h_info.frame_len, &OutLen);
	if (ret != LHDCV5_UTIL_DEC_SUCCESS){
		DSP_MW_LOG_E("[vendor_2] decode error ret %d", 1, ret);
    }

	outlen_per_ch = OutLen/LHDCV5_MAX_CHANNEL_NUM;

	// Convert to 32bit output
	if (LHDCV5DEC_INSTANCE->resolution_val == 16)
	{
		if ((channel == LHDC_OUTPUT_STEREO) || (channel == LHDC_OUTPUT_LEFT_CAHNNEL)){
			output_size =  vendor_2_decoder_convert_16bits_to_32bits (OutBufL, (int16_t *)LHDCV5DEC_INSTANCE->outbuf, lhdcv5_util_dec_get_sample_size((U32 *)LHDCV5DEC_INSTANCE->ptr));
            output_size =  vendor_2_decoder_convert_16bits_to_32bits (OutBufR, (int16_t *)LHDCV5DEC_INSTANCE->outbuf, lhdcv5_util_dec_get_sample_size((U32 *)LHDCV5DEC_INSTANCE->ptr));
		}
        if ((channel == LHDC_OUTPUT_STEREO) || (channel == LHDC_OUTPUT_RIGHT_CAHNNEL))
			output_size =  vendor_2_decoder_convert_16bits_to_32bits (OutBufR, (int16_t *)(LHDCV5DEC_INSTANCE->outbuf + outlen_per_ch), lhdcv5_util_dec_get_sample_size((U32 *)LHDCV5DEC_INSTANCE->ptr));
	} else if (LHDCV5DEC_INSTANCE->resolution_val == 24){
		if ((channel == LHDC_OUTPUT_STEREO) || (channel == LHDC_OUTPUT_LEFT_CAHNNEL)){
			output_size =  vendor_2_decoder_convert_24bits_to_32bits (OutBufL, (int32_t *)LHDCV5DEC_INSTANCE->outbuf, lhdcv5_util_dec_get_sample_size((U32 *)LHDCV5DEC_INSTANCE->ptr));
            output_size =  vendor_2_decoder_convert_24bits_to_32bits (OutBufR, (int32_t *)LHDCV5DEC_INSTANCE->outbuf, lhdcv5_util_dec_get_sample_size((U32 *)LHDCV5DEC_INSTANCE->ptr));
		}
        if ((channel == LHDC_OUTPUT_STEREO) || (channel == LHDC_OUTPUT_RIGHT_CAHNNEL)){
			output_size =  vendor_2_decoder_convert_24bits_to_32bits (OutBufR, (int32_t *)(LHDCV5DEC_INSTANCE->outbuf + outlen_per_ch), lhdcv5_util_dec_get_sample_size((U32 *)LHDCV5DEC_INSTANCE->ptr));
        }
	}else{
		if ((channel == LHDC_OUTPUT_STEREO) || (channel == LHDC_OUTPUT_LEFT_CAHNNEL))
			memcpy(OutBufL, LHDCV5DEC_INSTANCE->outbuf, outlen_per_ch);
		if ((channel == LHDC_OUTPUT_STEREO) || (channel == LHDC_OUTPUT_RIGHT_CAHNNEL))
			memcpy(OutBufR, LHDCV5DEC_INSTANCE->outbuf + outlen_per_ch, outlen_per_ch);

		output_size = outlen_per_ch;
	}

#ifdef AIROHA_MEASURE_DECODE_TIME
	hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &gpt_timer2);
	DSP_MW_LOG_I("[vendor_2] Decode processing time = %d\r\n", 1, gpt_timer2 - gpt_timer);
#endif

	stream_codec_modify_resolution(para, RESOLUTION_32BIT);
	stream_codec_modify_output_samplingrate(para, stream_codec_get_input_samplingrate(para));
	stream_codec_modify_output_size(para, output_size);

#ifdef AIR_AUDIO_DUMP_ENABLE
	LOG_AUDIO_DUMP((U8*)stream_codec_get_1st_output_buffer(para),
					output_size,
					AUDIO_SOURCE_IN_L);

	LOG_AUDIO_DUMP((U8*)stream_codec_get_2nd_output_buffer(para),
					output_size,
					AUDIO_SOURCE_IN_R);
#endif

    return FALSE;
}
