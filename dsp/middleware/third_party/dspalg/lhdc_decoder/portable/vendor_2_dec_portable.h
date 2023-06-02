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

#ifndef  __VENDOR_2_DEC_PORTABLE_H__
#define  __VENDOR_2_DEC_PORTABLE_H__

#ifdef MTK_BT_A2DP_VENDOR_2_USE_PIC

#include "vendor_2_dec_interface.h"

typedef int32_t (*lhdcv5_util_init_decoder_t)(uint32_t *ptr, uint32_t bitPerSample, uint32_t sampleRate, uint32_t audioFormat, uint32_t frm_duration, uint32_t lossless_enable, lhdc_ver_t version);

typedef int32_t (*lhdcv5_util_dec_process_t)(uint32_t *ptr, uint8_t * pOutBuf, uint8_t * pInput, uint32_t InLen, uint32_t *OutLen);

typedef int32_t (*lhdcv5_util_dec_get_sample_size_t) (uint32_t *ptr);

typedef int32_t (*lhdcv5_util_dec_fetch_frame_info_t)(uint32_t *ptr, uint8_t *frameData, uint32_t frameDataLen, lhdc_frame_Info_t *frameInfo);

typedef int32_t (*lhdcv5_util_dec_channel_selsect_t)(uint32_t *ptr, lhdc_channel_t channel_type);

typedef int32_t (*lhdcv5_util_dec_get_mem_req_t)(lhdc_ver_t version, uint32_t sampleRate, uint32_t audioFormat, uint32_t lossless_enable, uint32_t *mem_req_bytes);

/* Referrence to the APIs of LDAC library after preloader load done */
extern void *g_vendor_2_decoder_export_parameters[];

#define lhdcv5_util_init_decoder ((lhdcv5_util_init_decoder_t)g_vendor_2_decoder_export_parameters[0])
#define lhdcv5_util_dec_process ((lhdcv5_util_dec_process_t)g_vendor_2_decoder_export_parameters[1])
#define lhdcv5_util_dec_get_sample_size ((lhdcv5_util_dec_get_sample_size_t)g_vendor_2_decoder_export_parameters[2])
#define lhdcv5_util_dec_fetch_frame_info ((lhdcv5_util_dec_fetch_frame_info_t)g_vendor_2_decoder_export_parameters[3])
#define lhdcv5_util_dec_channel_selsect ((lhdcv5_util_dec_channel_selsect_t)g_vendor_2_decoder_export_parameters[4])
#define lhdcv5_util_dec_get_mem_req ((lhdcv5_util_dec_get_mem_req_t)g_vendor_2_decoder_export_parameters[5])
#endif

#endif

