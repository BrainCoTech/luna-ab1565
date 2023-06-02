/* Copyright Statement:
 *
 * (C) 2018  Airoha Technology Corp. All rights reserved.
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

#ifndef __DSP_DRV_AFE_CONTROL_H__
#define __DSP_DRV_AFE_CONTROL_H__

#include "hal_audio.h"
#include "types.h"

#ifdef HAL_AUDIO_MODULE_ENABLED

#include "air_chip.h"
#include "hal_nvic.h"
#include "hal_audio_afe_define.h"
#include "hal_audio_control.h"//moidfy for ab1568

typedef struct {
    hal_audio_device_t               in_device;
    hal_audio_interface_t            in_interface;
    uint32_t                         in_misc_parms;
    hal_audio_device_t               out_device;
    hal_audio_interface_t            out_interface;
    uint32_t                         out_misc_parms;
    hal_audio_channel_selection_t    in_channel;    /*HW out channel default R+L*/
    uint32_t                         gain;
    uint32_t                         sample_rate;
    uint16_t                         *FIR_nvdm_param;
    hal_audio_analog_mdoe_t          adc_mode;
    uint16_t                         on_delay_time;
} afe_sidetone_param_t, *afe_sidetone_param_p;

typedef struct {
    hal_audio_device_parameter_t     device_handle_in;//modify for ab1568
    hal_audio_device_parameter_t     device_handle_in_side_tone;//modify for ab1568
    hal_audio_device_parameter_t     device_handle_out;//modify for ab1568
} afe_sidetone_param_extension_t, *afe_sidetone_param_extension_p;

uint32_t word_size_align(uint32_t in_size);
int32_t afe_audio_get_input_digital_gain(afe_input_digital_gain_t index);

uint32_t afe_get_bt_sync_monitor(audio_digital_block_t mem_block);
uint32_t afe_get_bt_sync_monitor_state(audio_digital_block_t mem_block);
audio_digital_block_t afe_get_digital_block_by_audio_device (hal_audio_device_t device, hal_audio_interface_t audio_interface, bool is_input);

/*sidetone*/
bool afe_set_sidetone_filter(bool enable);
void afe_set_sidetone_output_path(afe_sidetone_path_t path, bool enable);
void afe_set_sidetone_volume(int32_t gain);
void afe_set_sidetone_enable(bool enable, afe_sidetone_param_t *param, afe_sidetone_param_extension_t *extension_param, bool sidetone_rampdown_done_flag);
void afe_set_sidetone_enable_flag(BOOL is_enable, int32_t gain);
EXTERN bool afe_get_sidetone_enable_flag(VOID);
EXTERN int32_t afe_get_sidetone_gain(VOID);
bool afe_get_sidetone_input_channel(void);

/*Loopback*/
void afe_set_loopback_enable(bool enable, afe_loopback_param_p param);
bool afe_get_asrc_irq_is_enabled(afe_mem_asrc_id_t asrc_id, uint32_t interrupt);
hal_audio_src_tracking_clock_t afe_set_asrc_tracking_clock(hal_audio_interface_t audio_interface);
void afe_set_asrc_enable(bool enable, afe_mem_asrc_id_t asrc_id, afe_src_configuration_p asrc_config);
#ifdef ENABLE_HWSRC_CLKSKEW
void afe_set_asrc_compensating_sample(afe_mem_asrc_id_t asrc_id, uint32_t output_buffer_rate, S32 cp_point);
#endif

#endif //#ifdef HAL_AUDIO_MODULE_ENABLED
#endif /* __DSP_DRV_AFE_CONTROL_H__ */
