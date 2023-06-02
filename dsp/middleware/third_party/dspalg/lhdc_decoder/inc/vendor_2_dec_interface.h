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
#ifndef __VENDOR_2_DEC_INTERFACE_H__
#define __VENDOR_2_DEC_INTERFACE_H__

#define DSP_LHDC_HEAP_SIZE        51836

#define LHDCV5_MAX_SAMPLE_PER_FRAME   960
#define LHDCV5_MAX_CHANNEL_NUM   2
#define LHDCV5_MAX_BYTES_PER_SAMPLE 4

typedef struct LHDCV5DEC_HANDLE
{
    uint32_t resolution_val;
    uint32_t sample_rate_val;
    uint32_t temp;
    uint8_t outbuf[LHDCV5_MAX_SAMPLE_PER_FRAME*LHDCV5_MAX_CHANNEL_NUM*LHDCV5_MAX_BYTES_PER_SAMPLE];
    uint8_t ptr[DSP_LHDC_HEAP_SIZE];
}LHDCV5DEC_HAD, *LHDCV5DEC_HAD_PTR;


#define DSP_LHDC_DECODER_MEMSIZE (sizeof(LHDCV5DEC_HAD))

#define LHDCV5_FRAME_DURATION_5MS            50

bool vendor_2_decoder_initialize (void *para);
bool vendor_2_decoder_process (void *para);


// Define for LHDC stream type.
typedef enum {
    LHDC_STRM_TYPE_COMBINE,
    LHDC_STRM_TYPE_SPLIT
}LHDC_STRM_TYPE;

typedef enum {
  VERSION_5 = 550
}lhdc_ver_t;

typedef enum {
  LHDCV2_BLOCK_SIZE = 512,
  LHDCV3_BLOCK_SIZE = 256,
}lhdc_block_size_t;

typedef struct _lhdc_frame_Info
{
    uint32_t frame_len;
    uint32_t isSplit;
    uint32_t isLeft;

} lhdc_frame_Info_t;

typedef enum {
    LHDC_OUTPUT_STEREO = 0,
    LHDC_OUTPUT_LEFT_CAHNNEL,
    LHDC_OUTPUT_RIGHT_CAHNNEL,
} lhdc_channel_t;

//audio_fmt
#define LHDCV5_AUDIO_FMT_OUT_PCM            0   //2 channel input, 2 channel output (interleaved)
#define LHDCV5_AUDIO_FMT_OUT_PCM_16BIT      1   //2 channel input, 2 channel output (interleaved)
#define LHDCV5_AUDIO_FMT_INOUT_ONE_CHANNEL  2   //1 channel input, 1 channel output (not interleaved)
#define LHDCV5_AUDIO_FMT_OUT_DAT            3   //2 channel input, 2 channel output (not interleaved)

//Return
#define LHDCV5_UTIL_DEC_SUCCESS 0
#define LHDCV5_UTIL_DEC_ERROR_NO_INIT -1
#define LHDCV5_UTIL_DEC_ERROR_PARAM -2
#define LHDCV5_UTIL_DEC_ERROR -3
#define LHDCV5_UTIL_DEC_ERROR_WRONG_DEC -10

int32_t lhdcv5_util_init_decoder(uint32_t *ptr, uint32_t bitPerSample, uint32_t sampleRate, uint32_t audioFormat, uint32_t frm_duration, uint32_t lossless_enable, lhdc_ver_t version);

int32_t lhdcv5_util_dec_process(uint32_t *ptr, uint8_t * pOutBuf, uint8_t * pInput, uint32_t InLen, uint32_t *OutLen);

int32_t lhdcv5_util_dec_get_sample_size (uint32_t *ptr);

int32_t lhdcv5_util_dec_fetch_frame_info(uint32_t *ptr, uint8_t *frameData, uint32_t frameDataLen, lhdc_frame_Info_t *frameInfo);

int32_t lhdcv5_util_dec_channel_selsect(uint32_t *ptr, lhdc_channel_t channel_type);

int32_t lhdcv5_util_dec_get_mem_req(lhdc_ver_t version, uint32_t sampleRate, uint32_t audioFormat, uint32_t lossless_enable, uint32_t *mem_req_bytes);

#endif
