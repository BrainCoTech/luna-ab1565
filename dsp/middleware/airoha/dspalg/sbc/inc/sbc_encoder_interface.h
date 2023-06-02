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

#ifndef _SBC_ENCODER_INTERFACE_H_
#define _SBC_ENCODER_INTERFACE_H_

/* Includes ------------------------------------------------------------------*/
#include "sbc_encoder.h"
#include "sbc_encoder_interface.h"
#include "types.h"
#include "dsp_feature_interface.h"

/* Public define -------------------------------------------------------------*/
#define SBC_ENC_USE_MSGID_SEND_LOG
#ifdef SBC_ENC_USE_MSGID_SEND_LOG
#define SBC_ENC_LOG_E(_message, arg_cnt, ...)  LOG_MSGID_E(sbc_enc_log,_message, arg_cnt, ##__VA_ARGS__)
#define SBC_ENC_LOG_W(_message, arg_cnt, ...)  LOG_MSGID_W(sbc_enc_log,_message, arg_cnt, ##__VA_ARGS__)
#define SBC_ENC_LOG_I(_message, arg_cnt, ...)  LOG_MSGID_I(sbc_enc_log,_message, arg_cnt, ##__VA_ARGS__)
#define SBC_ENC_LOG_D(_message, arg_cnt, ...)  LOG_MSGID_D(sbc_enc_log,_message, arg_cnt, ##__VA_ARGS__)
#else
#define SBC_ENC_LOG_E(_message, arg_cnt, ...)  LOG_E(sbc_enc_log,_message, ##__VA_ARGS__)
#define SBC_ENC_LOG_W(_message, arg_cnt, ...)  LOG_W(sbc_enc_log,_message, ##__VA_ARGS__)
#define SBC_ENC_LOG_I(_message, arg_cnt, ...)  LOG_I(sbc_enc_log,_message, ##__VA_ARGS__)
#define SBC_ENC_LOG_D(_message, arg_cnt, ...)  LOG_D(sbc_enc_log,_message, ##__VA_ARGS__)
#endif

/* Public typedef ------------------------------------------------------------*/
typedef struct {
    void *handle;
    sbc_encoder_initial_parameter_t param;
    sbc_encoder_runtime_parameter_t bit_pool;
    uint32_t working_buffer_size;
    uint16_t frame_cnt;
    uint16_t user_cnt;
    uint32_t input_working_buffer_size;
    uint32_t output_working_buffer_size;
    uint8_t  *input_working_buffer;
    uint8_t  *output_working_buffer;
    uint8_t  ScratchMemory[0];
} sbc_enc_handle_t;

typedef struct {
    sbc_encoder_initial_parameter_t param;
    sbc_encoder_runtime_parameter_t bit_pool;
    uint32_t input_working_buffer_size;
    uint32_t output_working_buffer_size;
    bool init;
} sbc_enc_param_config_t;
/* Public macro --------------------------------------------------------------*/
#define DSP_MEM_SBC_ECN_SIZE        (sizeof(sbc_enc_handle_t))
/* Public variables ----------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/
void stream_codec_encoder_sbc_init(sbc_enc_param_config_t *config);
void stream_codec_encoder_sbc_deinit(void);

bool stream_codec_encoder_sbc_initialize(void *para);
bool stream_codec_encoder_sbc_process(void *para);

#endif /* _SBC_ENCODER_INTERFACE_H_ */
