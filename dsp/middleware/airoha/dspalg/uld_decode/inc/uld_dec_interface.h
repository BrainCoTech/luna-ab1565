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

#ifndef __ULD_DEC_INTERFACE_H__
#define __ULD_DEC_INTERFACE_H__

#if defined(AIR_AUDIO_ULD_DECODE_ENABLE)

/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include <stdbool.h>

/* Public define -------------------------------------------------------------*/
#define ULD_DEC_USER_COUNT       1

/* Public typedef ------------------------------------------------------------*/
typedef enum {
    ULD_DEC_PORT_STATUS_DEINIT = 0,
    ULD_DEC_PORT_STATUS_INIT = 1,
    ULD_DEC_PORT_STATUS_RUNNING = 2
} uld_dec_port_status_t;

typedef struct {
    uint32_t bit_rate;
    uint32_t in_channel_num;
} uld_dec_port_config_t;

typedef struct {
    uld_dec_port_status_t status;
    uint32_t bit_rate;
    uint32_t in_channel_num;
    void *user;
} uld_dec_port_para_t;

typedef enum {
    ULD_DEC_FRAME_STATUS_NORMAL = 0,
    ULD_DEC_FRAME_STATUS_PLC = 1,
    ULD_DEC_FRAME_STATUS_BYPASS_DECODER = 2
} uld_dec_frame_status_t;

typedef enum {
    ULD_DEC_STATUS_ERROR = 0,
    ULD_DEC_STATUS_OK = 1
} uld_dec_status_t;

/* Public macro --------------------------------------------------------------*/
/* Public variables ----------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/
extern uld_dec_status_t stream_codec_decoder_uld_init(void *user, uld_dec_port_config_t *config);
extern uld_dec_status_t stream_codec_decoder_uld_deinit(void *user);
extern bool stream_codec_decoder_uld_initialize(void *para);
extern bool stream_codec_decoder_uld_process(void *para);

#endif /* AIR_AUDIO_ULD_DECODE_ENABLE */

#endif /* __ULD_DEC_INTERFACE_H__ */
