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

#include "hal_audio.h"

#ifdef HAL_AUDIO_MODULE_ENABLED

#include <string.h>
#include "hal_nvic.h"
#include "hal_audio_afe_control.h"
#include "hal_audio_afe_define.h"
#include "hal_gpt.h"
#include "hal_gpio.h"
#include "hal_log.h"
#include "assert.h"
#include "memory_attribute.h"
#include "dtm.h"
#include "hal_audio_driver.h"
#include "hal_resource_assignment.h"

afe_t afe;
extern hal_audio_interconn_selection_t stream_audio_convert_control_to_interconn(hal_audio_control_t audio_control, hal_audio_path_port_parameter_t port_parameter, uint32_t connection_sequence, bool is_input);
extern uint32_t afe_calculate_digital_gain_index(int32_t digital_gain_in_01unit_db, uint32_t digital_0db_register_value);
int32_t afe_audio_get_input_digital_gain(afe_input_digital_gain_t index)
{
    return afe.stream_in.digital_gain_index[index];
}

/*********************************************************************
*                         Sidetone filter                            *
*********************************************************************/
/*
Use Sidetone gain
0. set STF coefficient to table if needed
1. set interconnection (O10, O11) and call: afe_set_sidetone_input_path, afe_set_sidetone_output_path
2. set sidetone gain value: afe_set_sidetone_volume
4. enable sidtone: afe_set_sidetone_filter
*/

#define SIDETONE_AFE_0DB_REGISTER_VALUE 32767 //(2^15-1)

static void afe_set_sidetone_gain(int32_t gain)
{
    uint32_t temp_stf_gain = afe_calculate_digital_gain_index(gain, SIDETONE_AFE_0DB_REGISTER_VALUE);
    //log_hal_msgid_info("DSP sidetone negative gain %x, reg value:%x\r\n",2, gain, temp_stf_gain);
    AFE_SET_REG(AFE_SIDETONE_GAIN, (uint16_t)temp_stf_gain, 0xffff);
}

/*0dB:0 6dB:1  12dB:2  18dB:3  24dB:4*/
static void afe_set_sidetone_positve_gain(int32_t gain_01unit_db)
{
    uint32_t pos_gain = (uint32_t)(gain_01unit_db / 600);
    if (pos_gain > 4) {
        pos_gain = 4;
    }
    //log_hal_msgid_info("DSP sidetone pos gain %x, reg value:%x\r\n",2, gain_01unit_db, pos_gain);
    AFE_SET_REG(AFE_SIDETONE_GAIN, pos_gain << 16, 0x7 << 16);
}

void afe_set_sidetone_volume(int32_t gain)
{
    //call afe_set_sidetone_gain & afe_set_sidetone_positve_gain to adjust sidetone vol.
    //sidetone gain = gain + positive gain
    int32_t positve_gain, negative_gain;
    log_hal_msgid_info("DSP sidetone set volume %d\r\n", 1, gain);

    if (gain > 0) {
        positve_gain = gain + 599; // carry
        negative_gain = (gain % 600)
                        ? (gain % 600) - 600
                        : 0 ;
    } else {
        positve_gain = 0;
        negative_gain = gain;
    }

    afe_set_sidetone_positve_gain(positve_gain);
    afe_set_sidetone_gain(negative_gain);
}

void afe_set_sidetone_enable_flag(BOOL is_enable, int32_t gain)
{
    afe.sidetone.sidetone_gain = gain;
    afe.sidetone.start_flag = is_enable;
}

bool afe_get_sidetone_enable_flag(VOID)
{
    return afe.sidetone.start_flag;
}

int32_t afe_get_sidetone_gain(VOID)
{
    return afe.sidetone.sidetone_gain;
}

bool afe_get_sidetone_input_channel(void)
{
    return afe.sidetone.channel_flag;
}

#ifdef AIR_SIDETONE_ENABLE
void sidetone_tone_stop_entry(void)
{
    DTM_enqueue(DTM_EVENT_ID_SIDETONE_STOP, 0, false);
    //DSP_MW_LOG_I("sidetone_tone_stop_entry", 0);
}
void sidetone_in_device_para(hal_audio_device_parameter_t *device_handle_in, afe_sidetone_param_t *param)
{
    hal_audio_device_parameter_common_t *in_common_ptr = &device_handle_in->common;
    hal_audio_device_parameter_analog_mic_t *in_analog_mic_ptr = &device_handle_in->analog_mic;
    hal_audio_device_parameter_digital_mic_t *in_digital_mic_ptr = &device_handle_in->digital_mic;
    hal_audio_device_parameter_linein_t *in_linein_ptr = &device_handle_in->linein;
    hal_audio_device_parameter_i2s_master_t *in_i2s_master_ptr = &device_handle_in->i2s_master;
    hal_audio_device_parameter_i2s_slave_t *in_i2s_slave_ptr = &device_handle_in->i2s_slave;
    hal_audio_device_parameter_sidetone_t *in_sidetone_ptr = &device_handle_in->sidetone;

    hal_audio_i2s_word_length_t word_length = HAL_AUDIO_I2S_WORD_LENGTH_16BIT;
    if ((in_common_ptr->audio_device)&HAL_AUDIO_CONTROL_DEVICE_ANALOG_MIC_DUAL) {
        in_analog_mic_ptr->mic_interface = (hal_audio_interface_t)param->in_interface;
        in_analog_mic_ptr->bias_voltage[0] = (param->in_misc_parms) & 0xF;
        in_analog_mic_ptr->bias_voltage[1] = ((param->in_misc_parms) >> 4) & 0xF;
        in_analog_mic_ptr->bias_voltage[2] = ((param->in_misc_parms) >> 8) & 0xF;
        in_analog_mic_ptr->bias_voltage[3] = ((param->in_misc_parms) >> 12) & 0xF;
        in_analog_mic_ptr->bias_voltage[4] = ((param->in_misc_parms) >> 16) & 0xF;
        in_analog_mic_ptr->bias_select = (param->in_misc_parms) >> 20;//micbias_para_convert(param->in_misc_parms);//param.in_misc_parms.MicbiasSourceType;//HAL_AUDIO_BIAS_SELECT_ALL;
        in_analog_mic_ptr->iir_filter = HAL_AUDIO_UL_IIR_5HZ_AT_48KHZ;
        in_analog_mic_ptr->with_external_bias = false;
        in_analog_mic_ptr->with_bias_lowpower = false;
        in_analog_mic_ptr->bias1_2_with_LDO0 = false;
        in_analog_mic_ptr->adc_parameter.adc_mode = HAL_AUDIO_ANALOG_INPUT_ACC10K;
        in_analog_mic_ptr->adc_parameter.performance = AFE_PEROFRMANCE_NORMAL_MODE;
        //DSP_MW_LOG_I("sidetone dev 0x%x,if 0x%x,bis_v 0x%x,bis_sel 0x%x,iir 0x%x,ext 0x%x,bis_Low 0x%x,1_2_LDO 0x%x,adc_md 0x%x,pfm 0x%x", 10,
                     //in_common_ptr->audio_device, in_analog_mic_ptr->mic_interface, in_analog_mic_ptr->bias_voltage,
                     //in_analog_mic_ptr->bias_select, in_analog_mic_ptr->iir_filter, in_analog_mic_ptr->with_external_bias ,
                     //in_analog_mic_ptr->with_bias_lowpower, in_analog_mic_ptr->bias1_2_with_LDO0, in_analog_mic_ptr->adc_parameter.adc_mode,
                     //in_analog_mic_ptr->adc_parameter.performance);
    } else if ((in_common_ptr->audio_device)&HAL_AUDIO_CONTROL_DEVICE_LINE_IN_DUAL) {
        in_linein_ptr->bias_voltage[0] = (param->in_misc_parms) & 0xF;
        in_linein_ptr->bias_voltage[1] = ((param->in_misc_parms) >> 4) & 0xF;
        in_linein_ptr->bias_voltage[2] = ((param->in_misc_parms) >> 8) & 0xF;
        in_linein_ptr->bias_voltage[3] = ((param->in_misc_parms) >> 12) & 0xF;
        in_linein_ptr->bias_voltage[4] = ((param->in_misc_parms) >> 16) & 0xF;
        in_linein_ptr->bias_select = (param->in_misc_parms) >> 20;//micbias_para_convert(param->in_misc_parms.MicbiasSourceType);//HAL_AUDIO_BIAS_SELECT_ALL;
        in_linein_ptr->iir_filter = HAL_AUDIO_UL_IIR_DISABLE;
        in_linein_ptr->adc_parameter.adc_mode = HAL_AUDIO_ANALOG_INPUT_ACC10K;
        in_linein_ptr->adc_parameter.performance = AFE_PEROFRMANCE_NORMAL_MODE;
    } else if ((in_common_ptr->audio_device)&HAL_AUDIO_CONTROL_DEVICE_DIGITAL_MIC_DUAL) {
        in_digital_mic_ptr->mic_interface = (hal_audio_interface_t)param->in_interface;
        in_digital_mic_ptr->dmic_selection = HAL_AUDIO_DMIC_GPIO_DMIC0;
        in_digital_mic_ptr->adc_parameter.performance = AFE_PEROFRMANCE_NORMAL_MODE;
        in_digital_mic_ptr->bias_voltage[0] = (param->in_misc_parms) & 0xF;
        in_digital_mic_ptr->bias_voltage[1] = ((param->in_misc_parms) >> 4) & 0xF;
        in_digital_mic_ptr->bias_voltage[2] = ((param->in_misc_parms) >> 8) & 0xF;
        in_digital_mic_ptr->bias_voltage[3] = ((param->in_misc_parms) >> 12) & 0xF;
        in_digital_mic_ptr->bias_voltage[4] = ((param->in_misc_parms) >> 16) & 0xF;
        in_digital_mic_ptr->bias_select = (param->in_misc_parms) >> 20;//micbias_para_convert(param->in_misc_parms.MicbiasSourceType);//HAL_AUDIO_BIAS_SELECT_ALL;
        in_digital_mic_ptr->iir_filter = HAL_AUDIO_UL_IIR_DISABLE;
        in_digital_mic_ptr->with_external_bias = false;
        in_digital_mic_ptr->with_bias_lowpower = false;
        in_digital_mic_ptr->bias1_2_with_LDO0 = false;
        //DSP_MW_LOG_I("DIGITAL_MIC in_interface %d,dmic_selection %d, bias_voltage %d", 3, in_digital_mic_ptr->mic_interface, in_digital_mic_ptr->dmic_selection, in_digital_mic_ptr->bias_voltage[0]);

    } else if ((in_common_ptr->audio_device)&HAL_AUDIO_CONTROL_DEVICE_VAD) {

    } else if ((in_common_ptr->audio_device == HAL_AUDIO_CONTROL_DEVICE_I2S_MASTER) || (in_common_ptr->audio_device == HAL_AUDIO_CONTROL_DEVICE_I2S_MASTER_L) || (in_common_ptr->audio_device == HAL_AUDIO_CONTROL_DEVICE_I2S_MASTER_R)) {
        in_i2s_master_ptr->i2s_interface = (hal_audio_interface_t)param->in_interface;
        in_i2s_master_ptr->i2s_format = HAL_AUDIO_I2S_I2S;
        in_i2s_master_ptr->word_length = word_length;
        in_i2s_master_ptr->mclk_divider = 2;
        in_i2s_master_ptr->with_mclk = false;
        in_i2s_master_ptr->is_low_jitter = false;
        in_i2s_master_ptr->is_recombinant = false;
    } else if ((in_common_ptr->audio_device)&HAL_AUDIO_CONTROL_DEVICE_I2S_SLAVE) {
        in_i2s_slave_ptr->i2s_interface = (hal_audio_interface_t)param->in_interface;
        in_i2s_slave_ptr->i2s_format = HAL_AUDIO_I2S_I2S;
        in_i2s_slave_ptr->word_length = word_length;
        in_i2s_slave_ptr->is_vdma_mode = false;
    } else if ((in_common_ptr->audio_device)&HAL_AUDIO_CONTROL_DEVICE_SIDETONE) {
        hal_audio_path_port_parameter_t input_port_parameters;
        input_port_parameters.device_interface = (hal_audio_interface_t)param->in_interface;
        //DSP_MW_LOG_I("in device_interface %d in_device %d,out device_interface %d out_device %d\r\n", 4, input_port_parameters.device_interface, param->in_device, output_port_parameters.device_interface, param->out_device);
        in_sidetone_ptr->input_device = param->in_device;
        in_sidetone_ptr->input_interface = (hal_audio_interface_t)param->in_interface;
        in_sidetone_ptr->output_device = param->out_device;
        in_sidetone_ptr->output_interface =  (hal_audio_interface_t)param->out_interface;
        in_sidetone_ptr->input_interconn_select = stream_audio_convert_control_to_interconn(param->in_device, input_port_parameters, 0, true);
        in_sidetone_ptr->sidetone_gain = param->gain;
#if defined(BASE_STEREO_HIGH_G3_TYPE_77)
        in_sidetone_ptr->p_sidetone_FIR_coef = (uint16_t *)hal_memview_cm4_to_dsp0((U32)param->FIR_nvdm_param);
#else
        in_sidetone_ptr->p_sidetone_filter_param  = (uint16_t *)hal_memview_cm4_to_dsp0((U32)param->FIR_nvdm_param);
#endif
        //DSP_MW_LOG_I("[M DEBUG][sidetone_in_device_para] 0x%x %x %d",3,&param->FIR_nvdm_param,param->FIR_nvdm_param,*(param->FIR_nvdm_param));
        in_sidetone_ptr->is_sidetone_gain_register_value = false;
#ifdef ENABLE_SIDETONE_RAMP_TIMER
        in_sidetone_ptr->with_gain_ramp = true;
#else
        in_sidetone_ptr->with_gain_ramp = false;
#endif
        in_sidetone_ptr->sidetone_stop_done_entry = sidetone_tone_stop_entry;
        //DSP_MW_LOG_I("sidetone with_gain_ramp %d,entry 0x%x sidetone_gain %d\r\n", 3, in_sidetone_ptr->with_gain_ramp, in_sidetone_ptr->sidetone_stop_done_entry, in_sidetone_ptr->sidetone_gain);

    }
}
void afe_set_sidetone_enable(bool enable, afe_sidetone_param_t *param, afe_sidetone_param_extension_t *extension_param, bool sidetone_rampdown_done_flag)
{
    hal_audio_device_parameter_t *device_handle_in = &extension_param->device_handle_in;//modify for ab1568
    hal_audio_device_parameter_t *device_handle_out = &extension_param->device_handle_out; //modify for ab1568
    hal_audio_device_parameter_t *device_handle_in_side_tone = &extension_param->device_handle_in_side_tone; //modify for ab1568
    hal_audio_device_parameter_dac_t *out_dac_ptr = &device_handle_out->dac;
    hal_audio_device_parameter_i2s_master_t *out_i2s_master_ptr = &device_handle_out->i2s_master;
    hal_audio_device_parameter_i2s_slave_t *out_i2s_slave_ptr = &device_handle_out->i2s_slave;
    hal_audio_device_parameter_spdif_t *out_spdif_ptr = &device_handle_out->spdif;
    hal_audio_device_parameter_common_t *out_common_ptr = &device_handle_out->common;
    hal_audio_device_parameter_sidetone_t *in_sidetone_ptr = &device_handle_in_side_tone->sidetone;
    hal_audio_device_parameter_common_t *in_common_ptr = &device_handle_in->common;

    if (enable) {
        //in_common_ptr->rate = param->sample_rate;
        if(!in_common_ptr->rate){
            in_common_ptr->rate = 16000;
        }
        in_common_ptr->audio_device = param->in_device;
        sidetone_in_device_para(device_handle_in, param);

        //MIC
        hal_audio_set_device(device_handle_in, in_common_ptr->audio_device, HAL_AUDIO_CONTROL_ON);
        //Sidetone
        in_sidetone_ptr->rate = param->sample_rate;
        in_sidetone_ptr->audio_device = HAL_AUDIO_CONTROL_DEVICE_SIDETONE;
        sidetone_in_device_para(device_handle_in_side_tone, param);
        hal_audio_set_device(device_handle_in_side_tone, in_sidetone_ptr->audio_device, HAL_AUDIO_CONTROL_ON);
        //output device
        out_common_ptr->audio_device = param->out_device;
        out_common_ptr->rate = param->sample_rate;
        if ((out_common_ptr->audio_device) & HAL_AUDIO_CONTROL_DEVICE_INTERNAL_DAC_DUAL) {
            out_dac_ptr->dac_mode = afe.stream_out.dac_mode;
            out_dac_ptr->dc_compensation_value = afe.stream_out.dc_compensation_value;
            out_dac_ptr->with_high_performance = false;
            out_dac_ptr->with_phase_inverse = false;
            out_dac_ptr->with_force_change_rate = false;
        } else if ((out_common_ptr->audio_device == HAL_AUDIO_CONTROL_DEVICE_I2S_MASTER) || (out_common_ptr->audio_device == HAL_AUDIO_CONTROL_DEVICE_I2S_MASTER_L) || (out_common_ptr->audio_device == HAL_AUDIO_CONTROL_DEVICE_I2S_MASTER_R)) {
            out_i2s_master_ptr->i2s_interface = (hal_audio_interface_t)param->out_interface;//HAL_AUDIO_INTERFACE_1;
            out_i2s_master_ptr->i2s_format = HAL_AUDIO_I2S_I2S;
            out_i2s_master_ptr->word_length = HAL_AUDIO_I2S_WORD_LENGTH_16BIT;
            out_i2s_master_ptr->mclk_divider = 2;
            out_i2s_master_ptr->with_mclk = false;
            out_i2s_master_ptr->is_low_jitter = false;
            out_i2s_master_ptr->is_recombinant = false;
        } else if ((out_common_ptr->audio_device) & HAL_AUDIO_CONTROL_DEVICE_I2S_SLAVE) {
            out_i2s_slave_ptr->i2s_interface = (hal_audio_interface_t)param->out_interface;//HAL_AUDIO_INTERFACE_1;
            out_i2s_slave_ptr->i2s_format = HAL_AUDIO_I2S_I2S;
            out_i2s_slave_ptr->word_length = HAL_AUDIO_I2S_WORD_LENGTH_16BIT;
            out_i2s_slave_ptr->is_vdma_mode = false;
        } else if ((out_common_ptr->audio_device) & HAL_AUDIO_CONTROL_DEVICE_SPDIF) {
            out_spdif_ptr->i2s_setting.i2s_interface = (hal_audio_interface_t)param->out_interface;//HAL_AUDIO_INTERFACE_1;
            out_spdif_ptr->i2s_setting.i2s_format = HAL_AUDIO_I2S_I2S;
            out_spdif_ptr->i2s_setting.word_length = HAL_AUDIO_I2S_WORD_LENGTH_16BIT;
            out_spdif_ptr->i2s_setting.mclk_divider = 2;
            out_spdif_ptr->i2s_setting.with_mclk = false;
            out_spdif_ptr->i2s_setting.is_low_jitter = false;
            out_spdif_ptr->i2s_setting.is_recombinant = false;
        }
        DSP_MW_LOG_I("[SIDETONE] MIC set done %d rate %d Sidetone set done %d, rate=%d device_handle_out %d out_device %d, rate %d", 7, in_common_ptr->audio_device, in_common_ptr->rate,
                in_sidetone_ptr->audio_device, in_sidetone_ptr->rate, out_common_ptr->audio_device, param->out_device, out_common_ptr->rate);
        hal_audio_set_device(device_handle_out, out_common_ptr->audio_device, HAL_AUDIO_CONTROL_ON);
    } else {
        if (sidetone_rampdown_done_flag == true) {
            hal_audio_set_device(device_handle_in, in_common_ptr->audio_device, HAL_AUDIO_CONTROL_OFF);
            hal_audio_set_device(device_handle_out, out_common_ptr->audio_device, HAL_AUDIO_CONTROL_OFF);
        } else {
            hal_audio_set_device(device_handle_in_side_tone, in_sidetone_ptr->audio_device, HAL_AUDIO_CONTROL_OFF);
        }
    }
}
#endif

void afe_set_loopback_enable(bool enable, afe_loopback_param_p param)
{
    uint32_t i;

    hal_audio_device_parameter_t *device_handle_in = &param->device_handle_in;//modify for ab1568
    hal_audio_device_parameter_t *device_handle_out = &param->device_handle_out; //modify for ab1568
    hal_audio_path_parameter_t *path_handle = &param->path_handle;;
    hal_audio_device_parameter_common_t *in_common_ptr = &device_handle_in->common;
    hal_audio_device_parameter_analog_mic_t *in_analog_mic_ptr = &device_handle_in->analog_mic;
    hal_audio_device_parameter_digital_mic_t *in_digital_mic_ptr = &device_handle_in->digital_mic;
    hal_audio_device_parameter_linein_t *in_linein_ptr = &device_handle_in->linein;
    hal_audio_device_parameter_i2s_master_t *in_i2s_master_ptr = &device_handle_in->i2s_master;
    hal_audio_device_parameter_i2s_slave_t *in_i2s_slave_ptr = &device_handle_in->i2s_slave;
    hal_audio_device_parameter_vad_t *in_vad_ptr = &device_handle_in->vad;
    hal_audio_device_parameter_dac_t *out_dac_ptr = &device_handle_out->dac;
    hal_audio_device_parameter_i2s_master_t *out_i2s_master_ptr = &device_handle_out->i2s_master;
    hal_audio_device_parameter_i2s_slave_t *out_i2s_slave_ptr = &device_handle_out->i2s_slave;
    hal_audio_device_parameter_spdif_t *out_spdif_ptr = &device_handle_out->spdif;
    hal_audio_device_parameter_common_t *out_common_ptr = &device_handle_out->common;

    if (enable) {
        //path
        path_handle->connection_selection = HAL_AUDIO_INTERCONN_CH01CH02_to_CH01CH02;//pAudPara->stream_channel;
        // path_handle->connection_number = param->stream_channel;
        path_handle->connection_number = 2;


        hal_audio_path_port_parameter_t input_port_parameters, output_port_parameters;
        input_port_parameters.device_interface = (hal_audio_interface_t)param->in_interface;
        output_port_parameters.device_interface = (hal_audio_interface_t)param->out_interface;
        //DSP_MW_LOG_I("in device_interface %d in_device %d,out device_interface %d out_device %d\r\n", 4, input_port_parameters.device_interface, param->in_device, output_port_parameters.device_interface, param->out_device);
        for (i = 0 ; i < path_handle->connection_number ; i++) {
            path_handle->input.interconn_sequence[i]  = stream_audio_convert_control_to_interconn(param->in_device, input_port_parameters, i, true);
            path_handle->output.interconn_sequence[i] = stream_audio_convert_control_to_interconn(param->out_device, output_port_parameters, i, false);
            path_handle->with_updown_sampler[i] = false;
            path_handle->audio_input_rate[i] = param->sample_rate;//afe_get_audio_device_samplerate(pAudPara->audio_device, pAudPara->audio_interface);
            path_handle->audio_output_rate[i] = param->sample_rate;//afe_get_audio_device_samplerate(pAudPara->audio_device, pAudPara->audio_interface);
        }
        path_handle->with_hw_gain = param->with_hw_gain ;

#ifdef  AIR_AUDIO_HW_LOOPBACK_ENABLE
        if ((param->in_device) & (HAL_AUDIO_CONTROL_DEVICE_ANALOG_MIC_DUAL | HAL_AUDIO_CONTROL_DEVICE_ANALOG_MIC_L | HAL_AUDIO_CONTROL_DEVICE_ANALOG_MIC_R | \
                                  HAL_AUDIO_CONTROL_DEVICE_DIGITAL_MIC_DUAL | HAL_AUDIO_CONTROL_DEVICE_DIGITAL_MIC_L | HAL_AUDIO_CONTROL_DEVICE_DIGITAL_MIC_R)) {
            path_handle->connection_number = 1;
            path_handle->with_updown_sampler[0] = true;
            path_handle->audio_input_rate[0] = 16000;
            path_handle->audio_output_rate[0] = 48000;
        }
#endif
        //for hal_audio_set_device
        if ((param->in_device) & (HAL_AUDIO_CONTROL_DEVICE_ANALOG_MIC_DUAL | HAL_AUDIO_CONTROL_DEVICE_ANALOG_MIC_L | HAL_AUDIO_CONTROL_DEVICE_ANALOG_MIC_R | \
                                  HAL_AUDIO_CONTROL_DEVICE_LINE_IN_DUAL | HAL_AUDIO_CONTROL_DEVICE_DIGITAL_MIC_DUAL | HAL_AUDIO_CONTROL_DEVICE_ANC | \
                                  HAL_AUDIO_CONTROL_DEVICE_I2S_MASTER | HAL_AUDIO_CONTROL_DEVICE_I2S_MASTER_L | HAL_AUDIO_CONTROL_DEVICE_I2S_MASTER_R | \
                                  HAL_AUDIO_CONTROL_DEVICE_DIGITAL_MIC_DUAL | HAL_AUDIO_CONTROL_DEVICE_DIGITAL_MIC_L | HAL_AUDIO_CONTROL_DEVICE_DIGITAL_MIC_R)) {
            in_common_ptr->rate = param->sample_rate;
            //DSP_MW_LOG_I("set device common.rate %d,source rate %d", 2, in_common_ptr->rate, param->sample_rate);
        }
        in_common_ptr->audio_device = param->in_device;
        if ((param->in_device) & (HAL_AUDIO_CONTROL_DEVICE_ANALOG_MIC_DUAL | HAL_AUDIO_CONTROL_DEVICE_ANALOG_MIC_L | HAL_AUDIO_CONTROL_DEVICE_ANALOG_MIC_R | \
                                  HAL_AUDIO_CONTROL_DEVICE_DIGITAL_MIC_DUAL | HAL_AUDIO_CONTROL_DEVICE_DIGITAL_MIC_L | HAL_AUDIO_CONTROL_DEVICE_DIGITAL_MIC_R)) {
            in_analog_mic_ptr->rate = param->sample_rate;//AUDIO_SOURCE_DEFAULT_ANALOG_VOICE_RATE;
            in_analog_mic_ptr->with_external_bias = false;
            in_analog_mic_ptr->with_bias_lowpower = false;
            in_analog_mic_ptr->bias1_2_with_LDO0 = false;
            //DSP_MW_LOG_I("ANALOG_MIC in_interface %d,adc_mode %d,performance %d", 3, in_analog_mic_ptr->mic_interface, in_analog_mic_ptr->adc_parameter.adc_mode, in_analog_mic_ptr->in_analog_mic_ptr->in_analog_mic_ptr->in_analog_mic_ptr->adc_parameter.performance);
        } else if ((param->in_device)&HAL_AUDIO_CONTROL_DEVICE_LINE_IN_DUAL) {
            in_linein_ptr->rate =  param->sample_rate;//AUDIO_SOURCE_DEFAULT_ANALOG_AUDIO_RATE;
        } else if ((param->in_device)&HAL_AUDIO_CONTROL_DEVICE_DIGITAL_MIC_DUAL) {
            in_digital_mic_ptr->rate = param->sample_rate;//AUDIO_SOURCE_DEFAULT_ANALOG_VOICE_RATE;
            in_digital_mic_ptr->with_external_bias = false;
            in_digital_mic_ptr->with_bias_lowpower = false;
            in_digital_mic_ptr->bias1_2_with_LDO0 = false;
            //DSP_MW_LOG_I("DIGITAL_MIC in_interface %d,dmic_selection %d, bias_voltage %d", 3, in_digital_mic_ptr->mic_interface, in_digital_mic_ptr->dmic_selection, in_digital_mic_ptr->bias_voltage[0]);
            //printf("DIGITAL_MIC in_interface %d,dmic_selection %d, bias_voltage %d",in_digital_mic_ptr->mic_interface,in_digital_mic_ptr->dmic_selection,in_digital_mic_ptr->bias_voltage);
        } else if ((param->in_device)&HAL_AUDIO_CONTROL_DEVICE_VAD) {
            in_vad_ptr->rate = param->sample_rate;;
        } else if ((param->in_device == HAL_AUDIO_CONTROL_DEVICE_I2S_MASTER) || (param->in_device == HAL_AUDIO_CONTROL_DEVICE_I2S_MASTER_L) || (param->in_device == HAL_AUDIO_CONTROL_DEVICE_I2S_MASTER_R)) {
            in_i2s_master_ptr->rate = param->sample_rate;//48000;
            in_i2s_master_ptr->i2s_format = HAL_AUDIO_I2S_I2S;
            in_i2s_master_ptr->word_length = HAL_AUDIO_I2S_WORD_LENGTH_32BIT;
            in_i2s_master_ptr->mclk_divider = 2;
            in_i2s_master_ptr->with_mclk = false;
            in_i2s_master_ptr->i2s_interface = input_port_parameters.device_interface;
            if (param->in_misc_parms.I2sClkSourceType == I2S_CLK_SOURCE_APLL) {
                in_i2s_master_ptr->is_low_jitter = true;
            } else {
                in_i2s_master_ptr->is_low_jitter = false;
            }
            in_i2s_master_ptr->is_recombinant = false;
        } else if (param->in_device == HAL_AUDIO_CONTROL_DEVICE_I2S_SLAVE) {
            in_i2s_slave_ptr->rate = param->sample_rate;//48000;
            in_i2s_slave_ptr->i2s_interface = input_port_parameters.device_interface;
            in_i2s_slave_ptr->i2s_format = HAL_AUDIO_I2S_I2S;
            in_i2s_slave_ptr->word_length = HAL_AUDIO_I2S_WORD_LENGTH_32BIT;
            in_i2s_slave_ptr->is_vdma_mode = false;
        }

        out_common_ptr->audio_device = param->out_device;
        if (param->out_device & HAL_AUDIO_CONTROL_DEVICE_INTERNAL_DAC_DUAL) {
            out_dac_ptr->rate = param->sample_rate;
            out_dac_ptr->dac_mode = afe.stream_out.dac_mode;
//#ifdef ANALOG_OUTPUT_CLASSD_ENABLE
//        out_dac_ptr->dac_mode= HAL_AUDIO_ANALOG_OUTPUT_CLASSD;
//#else
//        out_dac_ptr->dac_mode= HAL_AUDIO_ANALOG_OUTPUT_CLASSAB;
//#endif
            out_dac_ptr->dc_compensation_value = afe.stream_out.dc_compensation_value;
#ifdef  LINE_IN_PURE_FOR_AMIC_CLASS_G_HQA
            out_dac_ptr->with_high_performance = param->device_handle_out.dac.with_high_performance;
            //DSP_MW_LOG_I("DAC with_high_performance %d dc_compensation_value 0x%x dac_mode 0x%x", 3, out_dac_ptr->with_high_performance, out_dac_ptr->dc_compensation_value, out_dac_ptr->dac_mode);
#else
            out_dac_ptr->with_high_performance = false;
#endif
            out_dac_ptr->with_force_change_rate = false;
        } else if ((param->out_device == HAL_AUDIO_CONTROL_DEVICE_I2S_MASTER) || (param->out_device == HAL_AUDIO_CONTROL_DEVICE_I2S_MASTER_L) || (param->out_device == HAL_AUDIO_CONTROL_DEVICE_I2S_MASTER_R)) {
            out_i2s_master_ptr->rate = param->sample_rate;
#ifdef  LINE_IN_PURE_FOR_AMIC_CLASS_G_HQA
            out_i2s_master_ptr->i2s_interface = (hal_audio_interface_t)param->out_interface;
#else
            out_i2s_master_ptr->i2s_interface = (hal_audio_interface_t)param->out_interface;
#endif
            out_i2s_master_ptr->i2s_format = HAL_AUDIO_I2S_I2S;
            out_i2s_master_ptr->word_length = HAL_AUDIO_I2S_WORD_LENGTH_32BIT;
            out_i2s_master_ptr->mclk_divider = 2;
            out_i2s_master_ptr->with_mclk = false;
            if (param->out_misc_parms.I2sClkSourceType == I2S_CLK_SOURCE_APLL) {
                out_i2s_master_ptr->is_low_jitter = true;
            } else {
                out_i2s_master_ptr->is_low_jitter = false;
            }
            out_i2s_master_ptr->is_recombinant = false;
        } else if (param->in_device == HAL_AUDIO_CONTROL_DEVICE_I2S_SLAVE) {
            out_i2s_slave_ptr->rate = param->sample_rate;
            out_i2s_slave_ptr->i2s_interface = output_port_parameters.device_interface;
            out_i2s_slave_ptr->i2s_format = HAL_AUDIO_I2S_I2S;
            out_i2s_slave_ptr->word_length = HAL_AUDIO_I2S_WORD_LENGTH_32BIT;
            out_i2s_slave_ptr->is_vdma_mode = false;
        } else if (param->out_device & HAL_AUDIO_CONTROL_DEVICE_SPDIF) {
            out_spdif_ptr->i2s_setting.rate = param->sample_rate;
            out_spdif_ptr->i2s_setting.i2s_interface = HAL_AUDIO_INTERFACE_1;
            out_spdif_ptr->i2s_setting.i2s_format = HAL_AUDIO_I2S_I2S;
            out_spdif_ptr->i2s_setting.word_length = HAL_AUDIO_I2S_WORD_LENGTH_32BIT;
            out_spdif_ptr->i2s_setting.mclk_divider = 2;
            out_spdif_ptr->i2s_setting.with_mclk = false;
            if (param->out_misc_parms.I2sClkSourceType == I2S_CLK_SOURCE_APLL) {
                out_spdif_ptr->i2s_setting.is_low_jitter = true;
            } else {
                out_spdif_ptr->i2s_setting.is_low_jitter = false;
            }
            out_spdif_ptr->i2s_setting.is_recombinant = false;
            out_spdif_ptr->i2s_setting.is_rx_swap = false;
            out_spdif_ptr->i2s_setting.is_tx_swap = false;
            out_spdif_ptr->i2s_setting.is_internal_loopback = false;
        }
    }
    if (enable) {
        hal_audio_set_path(path_handle, HAL_AUDIO_CONTROL_ON);
        hal_audio_set_device(device_handle_in, param->in_device, HAL_AUDIO_CONTROL_ON);
        hal_audio_set_device(device_handle_out, param->out_device, HAL_AUDIO_CONTROL_ON);

    } else {
#ifdef  LINE_IN_PURE_FOR_AMIC_CLASS_G_HQA
        //DSP_MW_LOG_I("dac mode %d\r\n", 1, out_dac_ptr->dac_mode);
#endif
        hal_audio_set_path(path_handle, HAL_AUDIO_CONTROL_OFF);
        hal_audio_set_device(device_handle_in, param->in_device, HAL_AUDIO_CONTROL_OFF);
        hal_audio_set_device(device_handle_out, param->out_device, HAL_AUDIO_CONTROL_OFF);
    }
}

#endif /*HAL_AUDIO_MODULE_ENABLED*/
