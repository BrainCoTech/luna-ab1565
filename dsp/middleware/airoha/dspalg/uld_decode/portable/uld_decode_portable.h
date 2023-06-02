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

#ifndef  __ULD_DECODE_PORTABLE_H__
#define  __ULD_DECODE_PORTABLE_H__

#include <stdint.h>
#include <stdbool.h>

#define C_200K_DEC_BS_NUM   25
#define C_152K_DEC_BS_NUM   19

typedef enum {
    ULD_DEC_OK = 0,                           /*!< No error occurred */
    ULD_DEC_SAMPLERATE_ERROR,                 /*!< Invalid sample rate */
    ULD_DEC_NUM_BYTES_ERROR,                  /*!< invalid number bytes */
    ULD_DEC_DECODE_ERROR,                     /*!< Frame failed to decode and was concealed */
    ULD_DEC_FRAMEMS_ERROR,                    /*!< Invalid frame size */
    ULD_DEC_MEM_NO_ENOUGH                     /*!< mem size no enough */
} ULD_Dec_ErrCode;

#ifdef AIR_AUDIO_ULD_DECODE_USE_PIC_ENABLE

typedef int (*p_ULD_Dec_Get_Version)(void);
typedef int (*p_ULD_Dec_Get_MemSize)(int version);  // version = 0 means the current version.
typedef ULD_Dec_ErrCode (*p_ULD_Dec_Init)(void *st_, int samplerate, short framesz, short num_bytes, int frame_loss_cnt, int version);
typedef ULD_Dec_ErrCode (*p_ULD_Dec_Prcs)(void *st_, char *bytes, int *pcm_o, short packet_loss);
typedef ULD_Dec_ErrCode (*p_ULD_Dec_Gain)(void *st_, int alpha);

/* Referrence to the APIs of ULD library after preloader load done */
extern void *g_uld_decode_export_parameters[];

#define ULD_Dec_Get_Version ((p_ULD_Dec_Get_Version)g_uld_decode_export_parameters[0])
#define ULD_Dec_Get_MemSize ((p_ULD_Dec_Get_MemSize)g_uld_decode_export_parameters[1])
#define ULD_Dec_Init ((p_ULD_Dec_Init)g_uld_decode_export_parameters[2])
#define ULD_Dec_Prcs ((p_ULD_Dec_Prcs)g_uld_decode_export_parameters[3])
#define ULD_Dec_Gain ((p_ULD_Dec_Gain)g_uld_decode_export_parameters[4])

#else

int ULD_Dec_Get_Version(void);
int ULD_Dec_Get_MemSize(int version);   // version = 0 means the current version.
ULD_Dec_ErrCode ULD_Dec_Init(void *st_, int samplerate, short framesz, short num_bytes, int frame_loss_cnt, int version);
ULD_Dec_ErrCode ULD_Dec_Prcs(void *st_, char *bytes, int *pcm_o, short packet_loss);
ULD_Dec_ErrCode ULD_Dec_Gain(void *st_, int alpha);

#endif

#endif
