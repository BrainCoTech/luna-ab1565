/* Copyright Statement:
 *
 * (C) 2017  Airoha Technology Corp. All rights reserved.
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
#include "hal_audio.h"

/*
  In this file, we implement the APIs listed in audio.h.
  If we need to communicate with DSP, it will call APIs provided by hal_audio_dsp_controller.c.
*/


#if defined(HAL_AUDIO_MODULE_ENABLED)

//==== Include header files ====
#include <assert.h>
#include "hal_log.h"
#include "hal_ccni.h"
#include "hal_gpio.h"
#include "memory_attribute.h"
#include "hal_audio_cm4_dsp_message.h"
#include "hal_audio_message_struct.h"
#include "hal_audio_internal.h"
#include "hal_audio_internal_nvkey_struct.h"
//#include "hal_clock_platform.h"
#include "hal_hw_semaphore.h"
#include "hal_resource_assignment.h"
#include "hal_audio_message_struct_common.h"
#ifdef HAL_DVFS_MODULE_ENABLED
#include "hal_dvfs.h"
#include "hal_dvfs_internal.h"
#endif
#include "hal_clock.h"
#if defined(HAL_AUDIO_SUPPORT_APLL)
extern ATTR_TEXT_IN_TCM hal_clock_status_t clock_mux_sel(clock_mux_sel_id mux_id, uint32_t mux_sel);
static int16_t aud_apll_1_cntr;
static int16_t aud_apll_2_cntr;
static hal_audio_mclk_status_t mclk_status[4]; // 4 is number of I2S interfaces.
extern void ami_hal_audio_status_set_running_flag(audio_scenario_type_t type, mcu2dsp_open_param_t *param, bool is_running);
#endif

#ifdef HAL_AUDIO_ANC_ENABLE
extern void hal_anc_get_input_device(hal_audio_device_t *in_device1, hal_audio_device_t *in_device2, hal_audio_device_t *in_device3, hal_audio_device_t *in_device4, hal_audio_device_t *in_device5, hal_audio_interface_t *in_interface1, hal_audio_interface_t *in_interface2, hal_audio_interface_t *in_interface3, hal_audio_interface_t *in_interface4, hal_audio_interface_t *in_interface5);
#endif

//==== Static variables ====
uint16_t g_stream_in_sample_rate = 16000;
uint16_t g_stream_in_code_type   = AUDIO_DSP_CODEC_TYPE_PCM;//modify for opus
uint16_t g_wwe_mode = 0;
encoder_bitrate_t g_bit_rate = ENCODER_BITRATE_32KBPS;

#ifdef AIR_AUDIO_DETACHABLE_MIC_ENABLE
volatile voice_mic_type_t current_voice_mic_type = VOICE_MIC_TYPE_FIXED;
voice_mic_type_t hal_audio_query_voice_mic_type(void) {
    return current_voice_mic_type;
}
#endif

audio_common_t audio_common;
HAL_AUDIO_DVFS_CLK_SELECT_t audio_nvdm_dvfs_config;
#ifdef HAL_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
au_afe_multi_input_instance_param_t audio_multi_instance_ctrl = {
    false,  //is_modified
    0,      //audio_device
    0,      //audio_device1
    0,      //audio_device2
    0,      //audio_device3
    0,      //audio_interface
    0,      //audio_interface1
    0,      //audio_interface2
    0,      //audio_interface3
};
#endif
#ifdef HAL_AUDIO_SUPPORT_MULTIPLE_STREAM_OUT
#define NVKEY_INDEX1 0xC0
#define NVKEY_INDEX2 0x30
#define NVKEY_INDEX3 0x0C
#define NVKEY_INDEX4 0x03
HAL_AUDIO_CHANNEL_SELECT_t audio_Channel_Select;
HAL_DSP_PARA_AU_AFE_CTRL_t audio_nvdm_HW_config;

const audio_version_t SW_version = SDK_V1p4; /*Need Change by Owner.*/
volatile audio_version_t nvdm_version = SDK_NONE;
#endif
#define HAL_AUDIO_MAX_OUTPUT_SAMPLING_FREQUENCY 192000
#define HAL_AUDIO_SAMPLING_RATE_MAX HAL_AUDIO_SAMPLING_RATE_192KHZ
//static int default_audio_device_out     = HAL_AUDIO_DEVICE_DAC_DUAL;
//static int default_audio_device_in      = HAL_AUDIO_DEVICE_MAIN_MIC_L;
const uint32_t supported_SR_audio_adc_in = (1 << HAL_AUDIO_SAMPLING_RATE_16KHZ) |
                                           (1 << HAL_AUDIO_SAMPLING_RATE_48KHZ);

const uint32_t supported_SR_audio_dac_out = (1 << HAL_AUDIO_SAMPLING_RATE_16KHZ) |
                                            (1 << HAL_AUDIO_SAMPLING_RATE_44_1KHZ) |
                                            (1 << HAL_AUDIO_SAMPLING_RATE_48KHZ) |
                                            (1 << HAL_AUDIO_SAMPLING_RATE_96KHZ) |
                                            (1 << HAL_AUDIO_SAMPLING_RATE_192KHZ);
const uint32_t supported_SR_audio_i2s_inout = ~0;
//==== Public API ====
hal_audio_status_t hal_audio_init(void)
{
    if (audio_common.init) {
        return HAL_AUDIO_STATUS_OK;
    }

    hal_audio_dsp_controller_init();

#if defined(HAL_AUDIO_SUPPORT_APLL)
    aud_apll_1_cntr = 0;
    aud_apll_2_cntr = 0;
    memset((void *)&mclk_status, 0, 4 * sizeof(hal_audio_mclk_status_t));
#endif

    audio_common.init = true;

    return HAL_AUDIO_STATUS_OK;
}

hal_audio_status_t hal_audio_deinit(void)
{
    if (audio_common.init) {
    #ifdef HAL_AUDIO_DSP_SHUTDOWN_SPECIAL_CONTROL_ENABLE
        hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_DUMMY_DSP_SHUTDOWN, 0, 0, true);
    #endif
        hal_audio_dsp_controller_deinit();
    }

    audio_common.init = false;

    return HAL_AUDIO_STATUS_OK;
}

/**
  * @ Register callback to copy the content of stream out
  * @ callback : callback function
  * @ user_data : user data (for exampple, handle)
  * @ Retval: HAL_AUDIO_STATUS_OK if operation is successful, others if operation is invalid
  */
hal_audio_status_t hal_audio_register_copied_stream_out_callback(hal_audio_stream_copy_callback_t callback, void *user_data)
{
    //KH: ToDo
    return HAL_AUDIO_STATUS_OK;
}

/**
  * @ Updates the audio output frequency
  * @ sample_rate : audio frequency used to play the audio stream
  * @ This API should be called before hal_audio_start_stream_out() to adjust the audio frequency
  * @ Retval: HAL_AUDIO_STATUS_OK if operation is successful, others if sample rate is invalid
  */
hal_audio_status_t hal_audio_set_stream_out_sampling_rate(hal_audio_sampling_rate_t sampling_rate)
{
	if (sampling_rate <= HAL_AUDIO_SAMPLING_RATE_192KHZ) {
		audio_common.stream_out[0].stream_sampling_rate = sampling_rate;
		return HAL_AUDIO_STATUS_OK;
	} else {
	    return HAL_AUDIO_STATUS_INVALID_PARAMETER;
	}
}

/**
  * @ Updates the audio output channel number
  * @ channel_number : audio channel mode to play the audio stream
  * @ This API should be called before hal_audio_start_stream_out() to adjust the output channel number
  * @ Retval: HAL_AUDIO_STATUS_OK if operation success, others if channel number is invalid
  */
hal_audio_status_t hal_audio_set_stream_out_channel_number(hal_audio_channel_number_t channel_number)
{
    hal_audio_channel_number_t *ptr = &audio_common.stream_out[0].stream_channel;
	if (channel_number == HAL_AUDIO_MONO) {
		*ptr = HAL_AUDIO_MONO;
	} else if (channel_number <= HAL_AUDIO_STEREO_BOTH_L_R_SWAP) {
		*ptr = HAL_AUDIO_STEREO;
	} else {
		return HAL_AUDIO_STATUS_INVALID_PARAMETER;
	}
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_SET_OUTPUT_DEVICE_CHANNEL, 0, channel_number, false);
    return HAL_AUDIO_STATUS_OK;
}

/**
  * @ Updates the audio output channel mode
  * @ channel_mode : audio channel mode to play the audio stream
  * @ This API should be called before hal_audio_start_stream_out() to adjust the output channel mode
  * @ Retval: HAL_AUDIO_STATUS_OK if operation is successful, others if channel mode is invalid
  */
hal_audio_status_t hal_audio_set_stream_out_channel_mode(hal_audio_channel_number_t channel_mode)
{
    audio_common.stream_out[0].stream_channel_mode = channel_mode;
    return HAL_AUDIO_STATUS_OK;
}

/**
  * @ Start the playback of audio stream
  */
hal_audio_status_t hal_audio_start_stream_out(hal_audio_active_type_t active_type)
{
    //ToDo: limit the scope -- treat it as local playback
    //audio_dsp_playback_info_t temp_param;
    void *p_param_share;
    bool is_running;

    audio_message_type_t msg_type = AUDIO_MESSAGE_TYPE_PLAYBACK;
    //n9_dsp_share_info_t *p_share_buf_info;

    is_running = hal_audio_status_query_running_flag(AUDIO_SCENARIO_TYPE_PLAYBACK);

    // Open playback
    mcu2dsp_open_param_t *open_param;
    open_param = (mcu2dsp_open_param_t *)pvPortMalloc(sizeof(mcu2dsp_open_param_t));
    audio_dsp_playback_info_t *ptr = &(open_param->stream_in_param.playback);

    memset(open_param,0,sizeof(open_param));

    // Collect parameters
    open_param->param.stream_in  = STREAM_IN_PLAYBACK;
    open_param->param.stream_out = STREAM_OUT_AFE;

    ptr->bit_type = HAL_AUDIO_BITS_PER_SAMPLING_16;
    ptr->sampling_rate = audio_common.stream_out[0].stream_sampling_rate;
    ptr->channel_number = audio_common.stream_out[0].stream_channel;
    ptr->codec_type = 0;  //KH: should use AUDIO_DSP_CODEC_TYPE_PCM
    ptr->p_share_info = (n9_dsp_share_info_t *)hal_audio_query_share_info(msg_type);

    hal_audio_reset_share_info( ptr->p_share_info );
    hal_audio_get_stream_out_setting_config(AU_DSP_AUDIO, &(open_param->stream_out_param));
    au_afe_open_param_t *afe_ptr = &(open_param->stream_out_param.afe);
    afe_ptr->memory          = HAL_AUDIO_MEM1;
    afe_ptr->format          = HAL_AUDIO_PCM_FORMAT_S16_LE;
    afe_ptr->stream_out_sampling_rate   = 16000;
    afe_ptr->sampling_rate   = 16000;
    afe_ptr->irq_period      = 10;
    afe_ptr->frame_size      = 256;
    afe_ptr->frame_number    = 2;
    afe_ptr->hw_gain         = false;
    p_param_share = hal_audio_dsp_controller_put_paramter(open_param, sizeof(mcu2dsp_open_param_t), msg_type);
    if (is_running) {
        // Reentry: don't allow multiple playback
        //log_hal_msgid_info("Re-entry\r\n", 0);
    } else {
        hal_audio_status_set_running_flag(AUDIO_SCENARIO_TYPE_PLAYBACK, open_param, true);
    }
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_PLAYBACK_OPEN, AUDIO_DSP_CODEC_TYPE_PCM, (uint32_t)p_param_share, true);
    vPortFree(open_param);

    // Start playback
    mcu2dsp_start_param_t *start_param;
    start_param = (mcu2dsp_start_param_t *)pvPortMalloc(sizeof(mcu2dsp_start_param_t));
    // Collect parameters
    start_param->param.stream_in     = STREAM_IN_PLAYBACK;
    start_param->param.stream_out    = STREAM_OUT_AFE;

    start_param->stream_out_param.afe.aws_flag   =  false;

    p_param_share = hal_audio_dsp_controller_put_paramter(start_param, sizeof(mcu2dsp_start_param_t), msg_type);
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_PLAYBACK_START, 0, (uint32_t)p_param_share, true);
    vPortFree(start_param);

    return HAL_AUDIO_STATUS_OK;
}

/**
  * @ Stop the playback of audio stream
  */
void hal_audio_stop_stream_out(void)
{
    //ToDo: limit the scope -- treat it as local playback
    n9_dsp_share_info_t *p_share_buf_info;

    // Stop playback
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_PLAYBACK_STOP, 0, 0, true);
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_PLAYBACK_CLOSE, 0, 0, true);

    hal_audio_status_set_running_flag(AUDIO_SCENARIO_TYPE_PLAYBACK, NULL, false);

    // Clear buffer
    p_share_buf_info = (n9_dsp_share_info_t *)hal_audio_query_share_info(AUDIO_MESSAGE_TYPE_PLAYBACK);
    hal_audio_reset_share_info(p_share_buf_info);
}

/**
 * @brief setting analog offset output gain
 *
 * @return hal_audio_status_t
 */
#ifdef AIR_AUDIO_LR_OUT_ANALOG_GAIN_OFFSET_ENABLE
extern bool audio_get_analog_gain_out_offset_in_db(uint16_t *L_offset_gain,uint16_t *R_offset_gain);
static hal_audio_status_t hal_audio_set_analog_offset_gain(void)
{
    uint16_t L_offset_gain = 0,R_offset_gain = 0;
    uint32_t data32 = 0;

    audio_get_analog_gain_out_offset_in_db(&L_offset_gain,&R_offset_gain);
    data32 = (R_offset_gain << 16) | (L_offset_gain & 0xFFFF);
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_SET_OUTPUT_DEVICE_VOLUME, 16, data32, false);

    return HAL_AUDIO_STATUS_OK;
}
#endif

/**
  * @ Updates the audio output volume
  * @ digital_volume_index: digital gain index
  * @ analog_volume_index : analog gain index
  */
hal_audio_status_t hal_audio_set_stream_out_volume(hal_audio_hw_stream_out_index_t hw_gain_index, uint32_t digital_volume_index, uint32_t analog_volume_index)
{
    uint32_t data32;
    if (hw_gain_index > HAL_AUDIO_STREAM_OUT3) {
        log_hal_msgid_error("hal_audio_set_stream_out_volume hw_gain index error %d", 1, hw_gain_index);
        return HAL_AUDIO_STATUS_INVALID_PARAMETER;
    }
#if defined(HAL_AUDIO_SUPPORT_MULTIPLE_MICROPHONE)
    audio_common.stream_out[hw_gain_index].digital_gain_index[INPUT_DIGITAL_GAIN_FOR_DEVICE_0] = digital_volume_index;
    audio_common.stream_out[hw_gain_index].analog_gain_index[INPUT_ANALOG_GAIN_FOR_MIC_L] = analog_volume_index;
#else
    audio_common.stream_out[hw_gain_index].digital_gain_index = digital_volume_index;
    audio_common.stream_out[hw_gain_index].analog_gain_index = analog_volume_index;
#endif
    data32 = (analog_volume_index<<16) | (digital_volume_index & 0xFFFF);
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_SET_OUTPUT_DEVICE_VOLUME, hw_gain_index, data32, false);
    return HAL_AUDIO_STATUS_OK;
}
/**
  * @ Updates the audio output DL2 volume
  * @ digital_volume_index: digital gain index
  * @ analog_volume_index : analog gain index
  */
hal_audio_status_t hal_audio_set_stream_out_dl2_volume(uint32_t digital_volume_index, uint32_t analog_volume_index)
{
    uint32_t data32;
#if defined(HAL_AUDIO_SUPPORT_MULTIPLE_MICROPHONE)
    audio_common.stream_out[1].digital_gain_index[INPUT_DIGITAL_GAIN_FOR_DEVICE_0] = digital_volume_index;
    audio_common.stream_out[1].analog_gain_index[INPUT_ANALOG_GAIN_FOR_MIC_L] = analog_volume_index;
#else
    audio_common.stream_out[1].digital_gain_index = digital_volume_index;
    audio_common.stream_out[1].analog_gain_index = analog_volume_index;
#endif
    #ifdef AIR_AUDIO_LR_OUT_ANALOG_GAIN_OFFSET_ENABLE
        hal_audio_set_analog_offset_gain();
    #endif
    data32 = (analog_volume_index<<16) | (digital_volume_index & 0xFFFF);
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_SET_OUTPUT_DEVICE_VOLUME, 1, data32, false);

    return HAL_AUDIO_STATUS_OK;
}

/**
  * @ Updates the audio output DL3 volume
  * @ digital_volume_index: digital gain index
  * @ analog_volume_index : analog gain index
  */
hal_audio_status_t hal_audio_set_stream_out_dl3_volume(uint32_t digital_volume_index, uint32_t analog_volume_index)
{
    uint32_t data32;
#if defined(HAL_AUDIO_SUPPORT_MULTIPLE_MICROPHONE)
    audio_common.stream_out[1].digital_gain_index[INPUT_DIGITAL_GAIN_FOR_DEVICE_0] = digital_volume_index;
    audio_common.stream_out[1].analog_gain_index[INPUT_ANALOG_GAIN_FOR_MIC_L] = analog_volume_index;
#else
    audio_common.stream_out[2].digital_gain_index = digital_volume_index;
    audio_common.stream_out[2].analog_gain_index = analog_volume_index;
#endif
    #ifdef AIR_AUDIO_LR_OUT_ANALOG_GAIN_OFFSET_ENABLE
        hal_audio_set_analog_offset_gain();
    #endif
    data32 = (analog_volume_index<<16) | (digital_volume_index & 0xFFFF);
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_SET_OUTPUT_DEVICE_VOLUME, 2, data32, false);

    return HAL_AUDIO_STATUS_OK;
}

#if defined(HAL_AUDIO_SUPPORT_MULTIPLE_STREAM_OUT)
/**
  * @ Mute stream ouput path
  * @ mute: true -> set mute / false -> set unmute
  * @ hw_gain_index: HAL_AUDIO_STREAM_OUT1-> indicate hw gain1 / HAL_AUDIO_STREAM_OUT2-> indicate hw gain2 / HAL_AUDIO_STREAM_OUT_ALL-> indicate hw gain1 and hw gain2
  */
void hal_audio_mute_stream_out(bool mute, hal_audio_hw_stream_out_index_t hw_gain_index)
{
    uint32_t data32;
    if (hw_gain_index > HAL_AUDIO_STREAM_OUT3) {
        return;
    }
    audio_common.stream_out[hw_gain_index].mute = mute;
    data32 = (hw_gain_index<<16) | (mute & 0xFFFF);
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_MUTE_OUTPUT_DEVICE, 0, data32, false);
}
#else
/**
  * @ Mute stream ouput path
  * @ mute: true -> set mute / false -> set unmute
  */
void hal_audio_mute_stream_out(bool mute)
{
    audio_common.stream_out[0].mute = mute;

    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_MUTE_OUTPUT_DEVICE, 0, mute, false);
}
#endif

/**
  * @ Control the audio output device
  * @ device: output device
  */
hal_audio_status_t hal_audio_set_stream_out_device(hal_audio_device_t device)
{
    audio_common.stream_out[0].audio_device = device;

    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_SET_OUTPUT_DEVICE, 0, device, false);

    return HAL_AUDIO_STATUS_OK;
}

/**
  * @ Write data into audio output stream for playback.
  * @ buffer: Pointer to the buffer
  * @ size : number of audio data [in bytes]
  * @ Retval HAL_AUDIO_STATUS_OK if operation is successful, others if failed.
  */
hal_audio_status_t hal_audio_write_stream_out(const void *buffer, uint32_t size)
{
    //ToDo: limit the scope -- treat it as local playback
    hal_audio_status_t result;

    result = hal_audio_write_stream_out_by_type(AUDIO_MESSAGE_TYPE_PLAYBACK, buffer, size);

    return result;
}

/**
  * @ Query the free space of output stream.
  * @ sample_count : number of free space [in bytes]
  * @ Retval HAL_AUDIO_STATUS_OK if operation is successful, others if failed
  */
hal_audio_status_t hal_audio_get_stream_out_sample_count(uint32_t *sample_count)
{
    //ToDo: limit the scope -- treat it as local playback
    n9_dsp_share_info_t *p_info = hal_audio_query_playback_share_info();

    *sample_count = hal_audio_buf_mgm_get_free_byte_count(p_info);

    return HAL_AUDIO_STATUS_OK;
}

/**
  * @ Register the callback of stream out.
  * @ callback : callback function
  * @ user_data : pointer of user data
  * @ Retval HAL_AUDIO_STATUS_OK if operation is successful, others if failed
  */
hal_audio_status_t hal_audio_register_stream_out_callback(hal_audio_stream_out_callback_t callback, void *user_data)
{
    //ToDo: limit the scope -- treat it as local playback

    hal_audio_service_hook_callback(AUDIO_MESSAGE_TYPE_PLAYBACK, callback, user_data);

    return HAL_AUDIO_STATUS_OK;
}

/**
  * @ Updates the audio input frequency
  * @ sample_rate : audio frequency used to record the audio stream
  * @ This API should be called before hal_audio_start_stream_in() to adjust the audio frequency
  * @ Retval: HAL_AUDIO_STATUS_OK if operation is successful, others if sample rate is invalid
  */
hal_audio_status_t hal_audio_set_stream_in_sampling_rate(hal_audio_sampling_rate_t sampling_rate)
{
    //ToDo: extend the sampling rate from 8k/16kHz to 8k~48kHz
    audio_common.stream_in.stream_sampling_rate = sampling_rate;
    return HAL_AUDIO_STATUS_OK;
}

/**
  * @ Updates the audio input channel number
  * @ channel_number : audio channel mode to record the audio stream
  * @ This API should be called before hal_audio_start_stream_in() to adjust the input channel number
  * @ Retval: HAL_AUDIO_STATUS_OK if operation is successful, others if channel number is invalid
  */
hal_audio_status_t hal_audio_set_stream_in_channel_number(hal_audio_channel_number_t channel_number)
{
    if (channel_number <= HAL_AUDIO_STEREO) {
        audio_common.stream_in.stream_channel = channel_number;
        hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_SET_INPUT_DEVICE_CHANNEL, 0, channel_number, false);
        return HAL_AUDIO_STATUS_OK;
    } else {
        return HAL_AUDIO_STATUS_INVALID_PARAMETER;
    }
}

#if defined(HAL_AUDIO_SUPPORT_MULTIPLE_MICROPHONE)
/**
  * @ Updates the audio input volume for multiple microphones.
  * @ volume_index0: input gain index 0
  * @ volume_index1: input gain index 1
  * @ gain_select  : select which pair of gain to be setting
  */
hal_audio_status_t hal_audio_set_stream_in_volume_for_multiple_microphone(uint32_t volume_index0, uint32_t volume_index1, hal_audio_input_gain_select_t gain_select)
{
    uint32_t data32;

    if (gain_select == HAL_AUDIO_INPUT_GAIN_SELECTION_D0_A0) {
        audio_common.stream_in.digital_gain_index[INPUT_DIGITAL_GAIN_FOR_DEVICE_0] = volume_index0;
        audio_common.stream_in.analog_gain_index[INPUT_ANALOG_GAIN_FOR_MIC_L] = volume_index1;
    } else if (gain_select == HAL_AUDIO_INPUT_GAIN_SELECTION_D0_D1) {
        audio_common.stream_in.digital_gain_index[INPUT_DIGITAL_GAIN_FOR_DEVICE_0] = volume_index0;
        audio_common.stream_in.digital_gain_index[INPUT_DIGITAL_GAIN_FOR_DEVICE_1] = volume_index1;
    } else if (gain_select == HAL_AUDIO_INPUT_GAIN_SELECTION_D2_D3) {
        audio_common.stream_in.digital_gain_index[INPUT_DIGITAL_GAIN_FOR_DEVICE_2] = volume_index0;
        audio_common.stream_in.digital_gain_index[INPUT_DIGITAL_GAIN_FOR_DEVICE_3] = volume_index1;
    } else if (gain_select == HAL_AUDIO_INPUT_GAIN_SELECTION_D14) {
        audio_common.stream_in.digital_gain_index[INPUT_DIGITAL_GAIN_FOR_ECHO_PATH] = volume_index0;
    } else if (gain_select == HAL_AUDIO_INPUT_GAIN_SELECTION_A0_A1) {
        audio_common.stream_in.analog_gain_index[INPUT_ANALOG_GAIN_FOR_MIC_L] = volume_index0;
        audio_common.stream_in.analog_gain_index[INPUT_ANALOG_GAIN_FOR_MIC_R] = volume_index1;
    }

    data32 = (volume_index1 <<16) | (volume_index0 & 0xFFFF);
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_SET_INPUT_DEVICE_VOLUME, gain_select, data32, false);

    return HAL_AUDIO_STATUS_OK;
}

/**
  * @ Updates the audio input volume
  * @ digital_volume_index: digital gain index
  * @ analog_volume_index : analog gain index
  */
hal_audio_status_t hal_audio_set_stream_in_volume(uint32_t digital_volume_index, uint32_t analog_volume_index)

{
    uint32_t data32;
    uint32_t i;

    for (i = 0; i < INPUT_DIGITAL_GAIN_NUM; i++) {
        audio_common.stream_in.digital_gain_index[i] = digital_volume_index;
    }
    audio_common.stream_in.analog_gain_index[INPUT_ANALOG_GAIN_FOR_MIC_L] = analog_volume_index;
    audio_common.stream_in.analog_gain_index[INPUT_ANALOG_GAIN_FOR_MIC_R] = analog_volume_index;

    data32 = (analog_volume_index<<16) | (digital_volume_index & 0xFFFF);
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_SET_INPUT_DEVICE_VOLUME, 0, data32, false);

    return HAL_AUDIO_STATUS_OK;
}

#else
/**
  * @ Updates the audio input volume
  * @ digital_volume_index: digital gain index
  * @ analog_volume_index : analog gain index
  */
hal_audio_status_t hal_audio_set_stream_in_volume(uint32_t digital_volume_index, uint32_t analog_volume_index)

{
    uint32_t data32;

    audio_common.stream_in.digital_gain_index = digital_volume_index;
    audio_common.stream_in.analog_gain_index = analog_volume_index;

    data32 = (analog_volume_index<<16) | (digital_volume_index & 0xFFFF);
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_SET_INPUT_DEVICE_VOLUME, 0, data32, false);

    return HAL_AUDIO_STATUS_OK;
}

#endif

/**
  * @ Mute stream in path
  * @ mute: true -> set mute / false -> set unmute
  */
void hal_audio_mute_stream_in(bool mute)
{
    audio_common.stream_in.mute = mute;

    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_MUTE_INPUT_DEVICE, 0, mute, false);
}

/**
  * @ Mute stream in path by scenario type
  * @ mute: true -> set mute / false -> set unmute
  */
void hal_audio_mute_stream_in_by_scenario(hal_audio_stream_in_scenario_t type, bool mute)
{
    uint16_t data16;

    audio_common.stream_in.mute = mute;

    data16 = type << 8 | 0x8000; /* Mark highest bit for the valid of scenario type */
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_MUTE_INPUT_DEVICE, data16, mute, false);
}

/**
  * @ Control the audio input device
  * @ device: input device
  */
hal_audio_status_t hal_audio_set_stream_in_device(hal_audio_device_t device)
{
    audio_common.stream_in.audio_device = device;

    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_SET_INPUT_DEVICE, 0, device, false);

    return HAL_AUDIO_STATUS_OK;
}

/**
 * @ Query the size of needed memory to be allocated for internal use in audio driver
 * @ memory_size : the amount of memory required by the audio driver for an internal use (in bytes).
 * @ Retval HAL_AUDIO_STATUS_OK if operation is successful, others if failed.
 */
hal_audio_status_t hal_audio_get_memory_size(uint32_t *memory_size)
{
    //ToDo: assume that we don't ennd extra memory
    *memory_size = 0;

    return HAL_AUDIO_STATUS_OK;
}

/**
 * @ Hand over allocated memory to audio driver
 * @ memory : the pointer to an allocated memory. It should be 4 bytes aligned.
 * @ Retval HAL_AUDIO_STATUS_OK if operation is successful, others if failed.
 */
hal_audio_status_t hal_audio_set_memory(void *memory)
{
    audio_common.allocated_memory = memory;

    return HAL_AUDIO_STATUS_OK;
}

/**
 * @ Get audio clock.
 * @ sample_count : a pointer to the accumulated audio sample count.
 * @ Retval HAL_AUDIO_STATUS_OK if operation is successful, others if failed.
 */
hal_audio_status_t hal_audio_get_audio_clock(uint32_t *sample_count)
{
    //ToDo: currently, use fake function.
    *sample_count = 0;

    return HAL_AUDIO_STATUS_OK;
}

#ifdef HAL_AUDIO_SUPPORT_MULTIPLE_STREAM_OUT
const uint32_t sampleing_rate[] = {8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000, 88200, 96000, 176400, 192000};
uint32_t hal_audio_sampling_rate_enum_to_value(hal_audio_sampling_rate_t hal_audio_sampling_rate_enum)
{
    if (hal_audio_sampling_rate_enum <= HAL_AUDIO_SAMPLING_RATE_192KHZ) {
        return sampleing_rate[hal_audio_sampling_rate_enum];
    } else {
        return sampleing_rate[0];
    }
}

hal_audio_sampling_rate_t hal_audio_sampling_rate_value_to_enum(uint32_t sample_rate)
{
    hal_audio_sampling_rate_t i;

    for (i = HAL_AUDIO_SAMPLING_RATE_8KHZ; i < HAL_AUDIO_SAMPLING_RATE_192KHZ; i++) {
        if (sampleing_rate[i] == sample_rate) {
            return i;
        }
    }
    return HAL_AUDIO_SAMPLING_RATE_44_1KHZ;
}

int32_t hal_audio_get_device_out_supported_frequency(hal_audio_device_t audio_out_device,hal_audio_sampling_rate_t freq)
{
    int32_t device_supported_frequency = -1;
    int32_t i = freq;
    uint32_t support_SR = supported_SR_audio_dac_out;

    if ((audio_out_device == HAL_AUDIO_DEVICE_DAC_L) || (audio_out_device == HAL_AUDIO_DEVICE_DAC_R) || (audio_out_device == HAL_AUDIO_DEVICE_DAC_DUAL)) {
        support_SR = supported_SR_audio_dac_out;
    } else if ((audio_out_device == HAL_AUDIO_DEVICE_I2S_MASTER) || (audio_out_device == HAL_AUDIO_DEVICE_I2S_SLAVE)) {
        support_SR = supported_SR_audio_i2s_inout;
    }

    while(i <= HAL_AUDIO_SAMPLING_RATE_MAX){
        if(((support_SR >> i) & 0x01)  == 0x01){
            device_supported_frequency = i;
            break;
        }
        i++;
    }

    if(device_supported_frequency == -1){
        device_supported_frequency = HAL_AUDIO_SAMPLING_RATE_192KHZ;
    }

    return device_supported_frequency;
}


static hal_audio_device_t hal_audio_convert_linein_config(uint8_t Mic_NVkey)
{
    hal_audio_device_t device = HAL_AUDIO_DEVICE_LINEINPLAYBACK_DUAL;

    if (Mic_NVkey == 0x01) {
            device = HAL_AUDIO_DEVICE_I2S_MASTER;
    } else if(Mic_NVkey == 0x02) {
            device = HAL_AUDIO_DEVICE_I2S_SLAVE;
    } else {
            device = HAL_AUDIO_DEVICE_LINEINPLAYBACK_DUAL;
    }
    return device;
}

hal_audio_interface_t hal_audio_convert_linein_interface(uint8_t Mic_NVkey,bool is_input_device)
{
    hal_audio_interface_t audio_interface = HAL_AUDIO_INTERFACE_1;
    uint8_t I2S_NVkey = HAL_AUDIO_INTERFACE_NONE;

    if (Mic_NVkey == 0x01) {
        I2S_NVkey = (is_input_device == true) ? audio_nvdm_HW_config.audio_scenario.Audio_Linein_Input_I2S_Interface : audio_nvdm_HW_config.audio_scenario.Audio_Linein_Output_I2S_Interface;
        if (I2S_NVkey <= 0x02) {
            audio_interface = (hal_audio_interface_t)(0x01 << I2S_NVkey);
        }
    }
    return audio_interface;
}

hal_audio_device_t hal_audio_convert_mic_config(uint8_t Mic_NVkey){
    hal_audio_device_t device = HAL_AUDIO_DEVICE_NONE;
    if ((Mic_NVkey == 0x00) || (Mic_NVkey == 0x02) || (Mic_NVkey == 0x04)) {
        device = HAL_AUDIO_DEVICE_MAIN_MIC_L;
    } else if ((Mic_NVkey == 0x01) || (Mic_NVkey == 0x03) || (Mic_NVkey == 0x05)) {
        device = HAL_AUDIO_DEVICE_MAIN_MIC_R;
    } else if ((Mic_NVkey == 0x08) || (Mic_NVkey == 0x0A) || (Mic_NVkey == 0x0C)) {
        device = HAL_AUDIO_DEVICE_DIGITAL_MIC_L;
    } else if ((Mic_NVkey == 0x09) || (Mic_NVkey == 0x0B) || (Mic_NVkey == 0x0D)) {
        device = HAL_AUDIO_DEVICE_DIGITAL_MIC_R;
    } else if ((Mic_NVkey == 0x10) || (Mic_NVkey == 0x30) || (Mic_NVkey == 0x50)) {
        device = HAL_AUDIO_DEVICE_I2S_MASTER_L;
    } else if ((Mic_NVkey == 0x20) || (Mic_NVkey == 0x40) || (Mic_NVkey == 0x60)) {
        device = HAL_AUDIO_DEVICE_I2S_MASTER_R;
    } else if ((Mic_NVkey == 0x80) || (Mic_NVkey == 0x90) || (Mic_NVkey == 0xA0) ||
              (Mic_NVkey == 0xB0) || (Mic_NVkey == 0xC0) || (Mic_NVkey == 0xD0)) {
        device = HAL_AUDIO_DEVICE_I2S_SLAVE;
    }
    return device;
}

static hal_audio_interface_t hal_audio_convert_mic_interface(uint8_t Mic_NVkey)
{
    hal_audio_interface_t audio_interface = HAL_AUDIO_INTERFACE_NONE;
    if ((Mic_NVkey == 0x00) ||
        (Mic_NVkey == 0x01) ||
        (Mic_NVkey == 0x08) ||
        (Mic_NVkey == 0x09) ||
        (Mic_NVkey == 0x10) ||
        (Mic_NVkey == 0x20) ||
        (Mic_NVkey == 0x80) ||
        (Mic_NVkey == 0x90)) {
        audio_interface = HAL_AUDIO_INTERFACE_1;
    } else if ((Mic_NVkey == 0x02) ||
               (Mic_NVkey == 0x03) ||
               (Mic_NVkey == 0x0A) ||
               (Mic_NVkey == 0x0B) ||
               (Mic_NVkey == 0x30) ||
               (Mic_NVkey == 0x40) ||
               (Mic_NVkey == 0xA0) ||
               (Mic_NVkey == 0xB0)) {
        audio_interface = HAL_AUDIO_INTERFACE_2;
    } else if ((Mic_NVkey == 0x04) ||
               (Mic_NVkey == 0x05) ||
               (Mic_NVkey == 0x0C) ||
               (Mic_NVkey == 0x0D) ||
               (Mic_NVkey == 0x50) ||
               (Mic_NVkey == 0x60) ||
               (Mic_NVkey == 0xC0) ||
               (Mic_NVkey == 0xD0)) {
        audio_interface = HAL_AUDIO_INTERFACE_3;
    }
    return audio_interface;
}

#ifdef HAL_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
void hal_audio_multi_instance_confg (mcu2dsp_open_stream_in_param_t *stream_in_open_param)
{
    if (audio_multi_instance_ctrl.is_modified)
    {
        au_afe_open_param_t *ptr = &stream_in_open_param->afe;
        ptr->audio_device      = audio_multi_instance_ctrl.audio_device;
        ptr->audio_device1     = audio_multi_instance_ctrl.audio_device1;
        ptr->audio_device2     = audio_multi_instance_ctrl.audio_device2;
        ptr->audio_device3     = audio_multi_instance_ctrl.audio_device3;
        ptr->audio_interface   = audio_multi_instance_ctrl.audio_interface;
        ptr->audio_interface1  = audio_multi_instance_ctrl.audio_interface1;
        ptr->audio_interface2  = audio_multi_instance_ctrl.audio_interface2;
        ptr->audio_interface3  = audio_multi_instance_ctrl.audio_interface3;

        log_hal_msgid_info("[HAL_AUDIO] Open Para is modified from ATC, Dev0:%d, Dev1:%d, Dev2:%d, Dev3:%d",
                            8,
                            ptr->audio_device,
                            ptr->audio_device1,
                            ptr->audio_device2,
                            ptr->audio_device3,
                            ptr->audio_interface,
                            ptr->audio_interface1,
                            ptr->audio_interface2,
                            ptr->audio_interface3);

        if (audio_multi_instance_ctrl.echo_path_enabled) {
            ptr->memory |= HAL_AUDIO_MEM3;
            //log_hal_msgid_info("[HAL_AUDIO] Echo path is enabled from ATC", 0);
        } else {
            ptr->memory &= (~HAL_AUDIO_MEM3);
            //log_hal_msgid_info("[HAL_AUDIO] Echo path is disabled from ATC", 0);
        }
		log_hal_msgid_info("[HAL_AUDIO] Echo path is disabled from ATC, %d", 1, audio_multi_instance_ctrl.echo_path_enabled);
    }
}
#endif

hal_audio_status_t hal_audio_translate_mic_config(hal_audio_mic_config_t *mic_config, mcu2dsp_open_stream_in_param_t *stream_in_open_param)
{
    au_afe_open_param_t *ptr = &stream_in_open_param->afe;
#ifdef MTK_AUDIO_HW_IO_CONFIG_ENHANCE
    uint32_t i;
    for (i = 0; i < 8; i++) {
        ptr->amic_type[i] = mic_config->amic_type[i];
        ptr->dmic_selection[i] = mic_config->dmic_selection[i];
        ptr->ul_adc_mode[i] = mic_config->ul_adc_mode[i];
    }
    for (i = 0; i < 5; i++) {
        ptr->bias_voltage[i] = mic_config->bias_voltage[i];
    }
    for (i = 0; i < 3; i++) {
        ptr->iir_filter[i] = mic_config->iir_filter[i];
    }
    ptr->bias_select = mic_config->bias_select;
    ptr->with_external_bias = mic_config->with_external_bias;
    ptr->with_bias_lowpower = mic_config->with_bias_lowpower;
    ptr->bias1_2_with_LDO0 = mic_config->bias1_2_with_LDO0;
#endif

    ptr->adc_mode = mic_config->adc_mode;
    ptr->performance = mic_config->performance;

#ifdef MTK_AUDIO_HW_IO_CONFIG_ENHANCE
    for (i = 0; i < 8; i++) {
        log_hal_msgid_info("stream_in_open_param->afe %d amic_type = %d, dmic_selection = %d, ul_adc_mode = %d", 4, i, ptr->ul_adc_mode[i], ptr->dmic_selection[i], ptr->ul_adc_mode[i]);
    }
    for (i = 0; i < 5; i++) {
        log_hal_msgid_info("stream_in_open_param->afe.bias_voltage[%d] = %d", 2, i, ptr->bias_voltage[i]);
    }
    for (i = 0; i < 3; i++) {
        log_hal_msgid_info("stream_in_open_param->afe.iir_filter[%d] = %d", 2, i, ptr->iir_filter[i]);
    }
    log_hal_msgid_info("stream_in_open_param->afe.bias_select = %d, .with_external_bias = %d, .with_bias_lowpower = %d, .bias1_2_with_LDO0 = %d", 4, 
                        ptr->bias_select, ptr->with_external_bias, ptr->with_bias_lowpower, ptr->bias1_2_with_LDO0);
#endif
    log_hal_msgid_info("stream_in_open_param->afe.adc_mode = %d, .performance = %d", 2, ptr->adc_mode, ptr->performance);
    //----I2S param setting
    if (ptr->audio_device == HAL_AUDIO_DEVICE_I2S_MASTER) {
        if (ptr->audio_interface == HAL_AUDIO_INTERFACE_1){
            ptr->i2s_format = audio_nvdm_HW_config.I2SM_config.I2S_Master_Format[0];
            ptr->i2s_word_length = audio_nvdm_HW_config.I2SM_config.I2S_Master_Word_length[0];
        } else if (ptr->audio_interface == HAL_AUDIO_INTERFACE_2){
            ptr->i2s_format = audio_nvdm_HW_config.I2SM_config.I2S_Master_Format[1];
            ptr->i2s_word_length = audio_nvdm_HW_config.I2SM_config.I2S_Master_Word_length[1];
        } else if (ptr->audio_interface == HAL_AUDIO_INTERFACE_3){
            ptr->i2s_format = audio_nvdm_HW_config.I2SM_config.I2S_Master_Format[2];
            ptr->i2s_word_length = audio_nvdm_HW_config.I2SM_config.I2S_Master_Word_length[2];
        } else if (ptr->audio_interface == HAL_AUDIO_INTERFACE_4){
            ptr->i2s_format = audio_nvdm_HW_config.I2SM_config.I2S_Master_Format[3];
            ptr->i2s_word_length = audio_nvdm_HW_config.I2SM_config.I2S_Master_Word_length[3];
        }
    }else if (ptr->audio_device == HAL_AUDIO_DEVICE_I2S_SLAVE) {
        ptr->i2s_format = audio_nvdm_HW_config.I2SS_config.I2S_Slave_Format;
        ptr->i2S_Slave_TDM = audio_nvdm_HW_config.I2SS_config.I2S_Slave_TDM;
        ptr->i2s_word_length = audio_nvdm_HW_config.I2SS_config.I2S_Slave_Word_length;
    }

    return HAL_AUDIO_STATUS_OK;
}

hal_audio_status_t hal_audio_get_mic_config(audio_scenario_sel_t Audio_or_Voice, hal_audio_mic_config_t *mic_config)
{
    uint32_t i;
    mcu2dsp_open_stream_in_param_t stream_in_open_param;
    au_afe_open_param_t *ptr = &stream_in_open_param.afe;

    memset(&stream_in_open_param,0,sizeof(stream_in_open_param));

    hal_audio_get_stream_in_setting_config(Audio_or_Voice, &stream_in_open_param);

#ifdef MTK_AUDIO_HW_IO_CONFIG_ENHANCE
    for (i = 0; i < 8; i++) {
        mic_config->amic_type[i] = ptr->amic_type[i];
        mic_config->dmic_selection[i] = ptr->dmic_selection[i];
        mic_config->ul_adc_mode[i] = ptr->ul_adc_mode[i];
    }
    for (i = 0; i < 5; i++) {
        mic_config->bias_voltage[i] = ptr->bias_voltage[i];
    }
    for (i = 0; i < 3; i++) {
        mic_config->iir_filter[i] = ptr->iir_filter[i];
    }
    mic_config->bias_select = ptr->bias_select;
    mic_config->with_external_bias = ptr->with_external_bias;
    mic_config->with_bias_lowpower = ptr->with_bias_lowpower;
    mic_config->bias1_2_with_LDO0 = ptr->bias1_2_with_LDO0;
#endif
    mic_config->adc_mode = ptr->adc_mode;
    mic_config->performance = ptr->performance;

#ifdef MTK_AUDIO_HW_IO_CONFIG_ENHANCE
    for (i = 0; i < 8; i++) {
        log_hal_msgid_info("mic_config->afe %d amic_type = %d, dmic_selection = %d, ul_adc_mode = %d", 4, i, ptr->ul_adc_mode[i], ptr->dmic_selection[i], ptr->ul_adc_mode[i]);
    }
    for (i = 0; i < 5; i++) {
        log_hal_msgid_info("mic_config->bias_voltage[%d] = %d", 2, i, mic_config->bias_voltage[i]);
    }
    for (i = 0; i < 3; i++) {
        log_hal_msgid_info("mic_config->iir_filter[%d] = %d", 2, i, mic_config->iir_filter[i]);
    }
    log_hal_msgid_info("mic_config->afe.bias_select = %d, .with_external_bias = %d, .with_bias_lowpower = %d, .bias1_2_with_LDO0 = %d", 4,
                        ptr->bias_select, ptr->with_external_bias, ptr->with_bias_lowpower, ptr->bias1_2_with_LDO0);
#endif
    log_hal_msgid_info("mic_config->adc_mode = %d, mic_config->performance = %d", 2, mic_config->adc_mode, mic_config->performance);
    return HAL_AUDIO_STATUS_OK;
}

hal_audio_status_t hal_audio_get_stream_in_setting_config(audio_scenario_sel_t Audio_or_Voice, mcu2dsp_open_stream_in_param_t *stream_in_open_param)
{
    bool Extended_Mic_Config_Flag = false;
    hal_audio_channel_selection_t *MemInterface = &stream_in_open_param->afe.stream_channel;
    hal_gpio_status_t status = HAL_GPIO_STATUS_OK;
    hal_gpio_data_t channel_gpio_data = HAL_GPIO_DATA_LOW;
    uint8_t channel_temp = 0;
    uint32_t i = 0;
    au_afe_open_param_t *ptr = &stream_in_open_param->afe;
    ptr->with_upwdown_sampler = false;
    ptr->audio_path_input_rate = 0;
    ptr->audio_path_output_rate = 0;
    hal_audio_device_t *audio_device = NULL;
    hal_audio_interface_t *audio_interface = NULL;
    HAL_DSP_PARA_AU_AFE_VOICE_SCENARIO_t *ptr_voice_scenario = &audio_nvdm_HW_config.voice_scenario;

    /*Audio HW I/O Configure setting*/
#ifdef AIR_AUDIO_DETACHABLE_MIC_ENABLE
    if ((hal_audio_query_voice_mic_type() == VOICE_MIC_TYPE_DETACHABLE) && (Audio_or_Voice != AU_DSP_AUDIO) && (Audio_or_Voice != AU_DSP_ANC) && (Audio_or_Voice != AU_DSP_LINEIN)) {
        HAL_DSP_PARA_AU_AFE_DETACH_MIC_SCENARIO_t *ptr_detach_mic = &audio_nvdm_HW_config.detach_mic_scenario;
        ptr->audio_device  = hal_audio_convert_mic_config(ptr_detach_mic->Detach_MIC_Select);
        ptr->audio_interface = hal_audio_convert_mic_interface(ptr_detach_mic->Detach_MIC_Select);
		ptr->audio_device1  = hal_audio_convert_mic_config(ptr_detach_mic->Detach_MIC_Select2);
        ptr->audio_interface1 = hal_audio_convert_mic_interface(ptr_detach_mic->Detach_MIC_Select2);
        //----AMIC MIC bias enable
        ptr->bias_select = ptr_detach_mic->Detach_MIC_Bias_Enable;
        ptr->misc_parms |= (uint32_t)(ptr_detach_mic->Detach_MIC_Bias_Enable) << 20;
        //----performance mode
        if (ptr_detach_mic->Detach_MIC_Analog_ADC_Performance_Sel <= 0x04){
             ptr->performance = ptr_detach_mic->Detach_MIC_Analog_ADC_Performance_Sel;
        } else {
            log_hal_msgid_error("[AUDIO][HAL] stream in ADC performance config error",0);
            return HAL_AUDIO_STATUS_ERROR;
        }
        #ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
            ptr->audio_device2 = 0;
            ptr->audio_device3 = 0;
            ptr->audio_device4 = 0;
            ptr->audio_device5 = 0;
            ptr->audio_interface2 = 0;
            ptr->audio_interface3 = 0;
            ptr->audio_interface4 = 0;
            ptr->audio_interface5 = 0;
        #endif
    }else
#endif
    {
        /*scenario AFE config part*/
        if(Audio_or_Voice == AU_DSP_VOICE){ //0:Audio, 1:Voice
            switch(ptr_voice_scenario->Voice_Input_Path) {
                case 0x04: //Multi-mic
                    Extended_Mic_Config_Flag = true;
                    break;
                case 0x02: //I2S_Master_In
                    ptr->audio_device = HAL_AUDIO_DEVICE_I2S_MASTER;
                    ptr->audio_interface = 1 << (ptr_voice_scenario->Voice_Input_I2S_Interface);
                    #ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
                        ptr->audio_device1 = HAL_AUDIO_DEVICE_I2S_MASTER;
                        ptr->audio_interface1 = 1 << (ptr_voice_scenario->Voice_Input_I2S_Interface);
                    #endif
                    break;
                case 0x03: //I2S_Slave_In
                    ptr->audio_device = HAL_AUDIO_DEVICE_I2S_SLAVE;
                    ptr->audio_interface = 1 << (ptr_voice_scenario->Voice_Input_I2S_Interface);
                    #ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
                        ptr->audio_device1 = HAL_AUDIO_DEVICE_I2S_SLAVE;
                        ptr->audio_interface1 = 1 << (ptr_voice_scenario->Voice_Input_I2S_Interface);
                    #endif
                    break;
                case 0x01: //Digital Mic
                    if (ptr_voice_scenario->Voice_Input_DMIC_channel == 0x02) {
                        ptr->audio_device = HAL_AUDIO_DEVICE_DIGITAL_MIC_DUAL;
                    } else if (ptr_voice_scenario->Voice_Input_DMIC_channel == 0x01){
                        ptr->audio_device = HAL_AUDIO_DEVICE_DIGITAL_MIC_R;
                    } else if (ptr_voice_scenario->Voice_Input_DMIC_channel == 0x00){
                        ptr->audio_device= HAL_AUDIO_DEVICE_DIGITAL_MIC_L;
                    }
                    break;
                case 0x00: //Analog Mic
                    if (ptr_voice_scenario->Voice_Input_AMIC_channel == 0x02) {
                        ptr->audio_device = HAL_AUDIO_DEVICE_MAIN_MIC_DUAL;
                    } else if (ptr_voice_scenario->Voice_Input_AMIC_channel == 0x01){
                        ptr->audio_device = HAL_AUDIO_DEVICE_MAIN_MIC_R;
                    } else if (ptr_voice_scenario->Voice_Input_AMIC_channel == 0x00){
                        ptr->audio_device = HAL_AUDIO_DEVICE_MAIN_MIC_L;
                    }
                    break;
                default:
                    ptr->audio_device = HAL_AUDIO_DEVICE_MAIN_MIC_L;
                    break;
            }
            if(Extended_Mic_Config_Flag){ //TODO YB
                ptr->audio_device  = hal_audio_convert_mic_config(ptr_voice_scenario->Voice_Multiple_Mic_Main_Input_Select);
                ptr->audio_device1 = hal_audio_convert_mic_config(ptr_voice_scenario->Voice_Multiple_Mic_Ref1_Input_Select);
                ptr->audio_device2 = hal_audio_convert_mic_config(ptr_voice_scenario->Voice_Multiple_Mic_Ref2_Input_Select);
                ptr->audio_device3 = hal_audio_convert_mic_config(ptr_voice_scenario->Voice_Multiple_Mic_Ref3_Input_Select);
                ptr->audio_device4 = hal_audio_convert_mic_config(ptr_voice_scenario->Voice_Multiple_Mic_Ref4_Input_Select);
                ptr->audio_device5 = hal_audio_convert_mic_config(ptr_voice_scenario->Voice_Multiple_Mic_Ref5_Input_Select);
                ptr->audio_interface = hal_audio_convert_mic_interface(ptr_voice_scenario->Voice_Multiple_Mic_Main_Input_Select);
                #ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
                    ptr->audio_interface1 = hal_audio_convert_mic_interface(ptr_voice_scenario->Voice_Multiple_Mic_Ref1_Input_Select);
                    ptr->audio_interface2 = hal_audio_convert_mic_interface(ptr_voice_scenario->Voice_Multiple_Mic_Ref2_Input_Select);
                    ptr->audio_interface3 = hal_audio_convert_mic_interface(ptr_voice_scenario->Voice_Multiple_Mic_Ref3_Input_Select);
                    ptr->audio_interface4 = hal_audio_convert_mic_interface(ptr_voice_scenario->Voice_Multiple_Mic_Ref4_Input_Select);
                    ptr->audio_interface5 = hal_audio_convert_mic_interface(ptr_voice_scenario->Voice_Multiple_Mic_Ref5_Input_Select);
                #endif
            } else {
                /*config the interface via 1 AMIC or 1 DMIC setting*/
                if (ptr_voice_scenario->Voice_Input_Path == 0x00) {
                    /*Amic*/
                    ptr->audio_interface = hal_audio_convert_mic_interface(ptr_voice_scenario->Voice_Analog_MIC_Sel);
                }else if (ptr_voice_scenario->Voice_Input_Path == 0x01){
                    /*Dmic*/
                    ptr->audio_interface = hal_audio_convert_mic_interface(ptr_voice_scenario->Voice_Digital_MIC_Sel);
                }
                /*when multi mic feature option is open,should reset the open param to support 1 mic setting*/
                #ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
                    if ((ptr_voice_scenario->Voice_Input_Path != 0x02) && (ptr_voice_scenario->Voice_Input_Path != 0x03)) {
                        ptr->audio_device1 = 0;
                        ptr->audio_interface1 = 0;
                    }
                    ptr->audio_device2 = 0;
                    ptr->audio_device3 = 0;
                    ptr->audio_device4 = 0;
                    ptr->audio_device5 = 0;
                    ptr->audio_interface2 = 0;
                    ptr->audio_interface3 = 0;
                    ptr->audio_interface4 = 0;
                    ptr->audio_interface5 = 0;
                #endif
            }
            //----AMIC MIC bias enable
            ptr->bias_select = ptr_voice_scenario->Voice_MIC_Bias_Enable;
            ptr->misc_parms |= (uint32_t)(ptr_voice_scenario->Voice_MIC_Bias_Enable) << 20;
            //----performance mode
            if (ptr_voice_scenario->Voice_Analog_ADC_Performance_Sel <= 0x04) {
                ptr->performance = ptr_voice_scenario->Voice_Analog_ADC_Performance_Sel;
            } else {
                log_hal_msgid_error("[AUDIO][HAL] stream in ADC performance config error",0);
                return HAL_AUDIO_STATUS_ERROR;
            }
        } else if(Audio_or_Voice == AU_DSP_LINEIN){
            //----config the audio device && interface
            HAL_DSP_PARA_AU_AFE_AUDIO_SCENARIO_t *ptr_audio_scenario = &audio_nvdm_HW_config.audio_scenario;
            ptr->audio_device  = hal_audio_convert_linein_config(ptr_audio_scenario->Audio_Linein_Input_Path);
            ptr->audio_interface = hal_audio_convert_linein_interface(ptr_audio_scenario->Audio_Linein_Input_Path,true);
            #ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
                ptr->audio_device1 = ptr->audio_device;
                ptr->audio_interface1 = ptr->audio_interface;
            #endif
            //----LINE IN bias enable
            ptr->bias_select = ptr_audio_scenario->Audio_LineIn_Bias_Enable;
            ptr->misc_parms |= (uint32_t)(ptr_audio_scenario->Audio_LineIn_Bias_Enable) << 20;
            //----performance mode
            if (ptr_audio_scenario->Audio_Analog_LineIn_Performance_Sel <= 0x04) {
                ptr->performance = ptr_audio_scenario->Audio_Analog_LineIn_Performance_Sel;
            } else {
                log_hal_msgid_error("[AUDIO][HAL] stream in ADC performance config error",0);
                return HAL_AUDIO_STATUS_ERROR;
            }
        } else if (Audio_or_Voice == AU_DSP_ANC) {
        #ifdef HAL_AUDIO_ANC_ENABLE
            #ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
            hal_anc_get_input_device(&(ptr->audio_device), &(ptr->audio_device1), &(ptr->audio_device2), &(ptr->audio_device3), &(ptr->audio_device4),
                                     &(ptr->audio_interface), &(ptr->audio_interface1), &(ptr->audio_interface2), &(ptr->audio_interface3), &(ptr->audio_interface4));
            #else
            hal_anc_get_input_device(&(ptr->audio_device), &(ptr->audio_device1), &(ptr->audio_device2), &(ptr->audio_device3), &(ptr->audio_device4),
                                     &(ptr->audio_interface), NULL, NULL, NULL, NULL);
            #endif
        #else
            ptr->audio_interface  = HAL_AUDIO_INTERFACE_1;
            #ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
            ptr->audio_interface1 = HAL_AUDIO_INTERFACE_2;
            ptr->audio_interface2 = HAL_AUDIO_INTERFACE_3;
            ptr->audio_interface3 = HAL_AUDIO_INTERFACE_4;
            #endif
        #endif
            HAL_DSP_PARA_AU_AFE_ANC_SCENARIO_t *ptr_anc_scenario = &audio_nvdm_HW_config.anc_scenario;
            //----AMIC MIC bias enable
            ptr->bias_select = ptr_anc_scenario->ANC_MIC_Bias_Enable;
            ptr->misc_parms |= (uint32_t)(ptr_anc_scenario->ANC_MIC_Bias_Enable) << 20;
            //----performance mode
            if (ptr_anc_scenario->ANC_MIC_Analog_ADC_Performance_Sel <= 0x04) {
                ptr->performance = ptr_anc_scenario->ANC_MIC_Analog_ADC_Performance_Sel;
            } else {
                log_hal_msgid_error("[AUDIO][HAL] stream in ADC performance config error",0);
                return HAL_AUDIO_STATUS_ERROR;
            }
        } else if (Audio_or_Voice == AU_DSP_RECORD) {
            HAL_DSP_PARA_AU_AFE_RECORD_SCENARIO_t *ptr_record_scenario = &audio_nvdm_HW_config.record_scenario;

            ptr->audio_device = hal_audio_convert_mic_config(ptr_record_scenario->Record_Main_Input_Select);
            ptr->audio_device1 = hal_audio_convert_mic_config(ptr_record_scenario->Record_Ref_Input_Select);
            //reserve record param for default val
            ptr->audio_device2 = hal_audio_convert_mic_config(ptr_record_scenario->Record_Ref2_Input_Select);
            ptr->audio_device3 = hal_audio_convert_mic_config(ptr_record_scenario->Record_Ref3_Input_Select);
            ptr->audio_device4 = hal_audio_convert_mic_config(ptr_record_scenario->Record_Ref4_Input_Select);
            ptr->audio_device5 = hal_audio_convert_mic_config(ptr_record_scenario->Record_Ref5_Input_Select);

            ptr->audio_interface = hal_audio_convert_mic_interface(ptr_record_scenario->Record_Main_Input_Select);
            #ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
                ptr->audio_interface1 = hal_audio_convert_mic_interface(ptr_record_scenario->Record_Ref_Input_Select);
                //reserve record param for default val
                ptr->audio_interface2 = hal_audio_convert_mic_interface(ptr_record_scenario->Record_Ref2_Input_Select);
                ptr->audio_interface3 = hal_audio_convert_mic_interface(ptr_record_scenario->Record_Ref3_Input_Select);
                ptr->audio_interface4 = hal_audio_convert_mic_interface(ptr_record_scenario->Record_Ref4_Input_Select);
                ptr->audio_interface5 = hal_audio_convert_mic_interface(ptr_record_scenario->Record_Ref5_Input_Select);
            #endif
            //----AMIC MIC bias enable
            ptr->bias_select = ptr_record_scenario->Record_MIC_Bias_Enable;
            //----performance mode
            if (ptr_record_scenario->Record_Analog_ADC_Performance_Sel <= 0x04) {
                ptr->performance = ptr_record_scenario->Record_Analog_ADC_Performance_Sel;
            } else {
                log_hal_msgid_error("[AUDIO][HAL] stream in ADC performance config error",0);
                return HAL_AUDIO_STATUS_ERROR;
            }
        }else if ((Audio_or_Voice == AU_DSP_VAD_PHASE0) || (Audio_or_Voice == AU_DSP_VAD_PHASE1)) {
            HAL_DSP_PARA_AU_AFE_VAD_SCENARIO_t *ptr_VAD_scenario = &audio_nvdm_HW_config.VAD_scenario;
            if (Audio_or_Voice == AU_DSP_VAD_PHASE0) {
                ptr->audio_device  = hal_audio_convert_mic_config(ptr_VAD_scenario->VAD_phase0_Main_Input_Select);
                ptr->audio_interface = hal_audio_convert_mic_interface(ptr_VAD_scenario->VAD_phase0_Main_Input_Select);
                #ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
                    ptr->audio_device1 = hal_audio_convert_mic_config(ptr_VAD_scenario->VAD_phase0_Ref_Input_Select);
                    ptr->audio_interface1 = hal_audio_convert_mic_interface(ptr_VAD_scenario->VAD_phase0_Ref_Input_Select);
                #endif
            }else {
                ptr->audio_device  = hal_audio_convert_mic_config(ptr_VAD_scenario->VAD_phase1_Main_Input_Select);
                ptr->audio_interface = hal_audio_convert_mic_interface(ptr_VAD_scenario->VAD_phase1_Main_Input_Select);
                #ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
                    ptr->audio_device1 = hal_audio_convert_mic_config(ptr_VAD_scenario->VAD_phase1_Ref_Input_Select);
                    ptr->audio_interface1 = hal_audio_convert_mic_interface(ptr_VAD_scenario->VAD_phase1_Ref_Input_Select);
                    ptr->audio_device2 = hal_audio_convert_mic_config(ptr_VAD_scenario->VAD_phase1_Ref2_Input_Select);
                    ptr->audio_interface2 = hal_audio_convert_mic_interface(ptr_VAD_scenario->VAD_phase1_Ref2_Input_Select);
                    ptr->audio_device3 = hal_audio_convert_mic_config(ptr_VAD_scenario->VAD_phase1_Ref3_Input_Select);
                    ptr->audio_interface3 = hal_audio_convert_mic_interface(ptr_VAD_scenario->VAD_phase1_Ref3_Input_Select);
                    ptr->audio_device4 = hal_audio_convert_mic_config(ptr_VAD_scenario->VAD_phase1_Ref4_Input_Select);
                    ptr->audio_interface4 = hal_audio_convert_mic_interface(ptr_VAD_scenario->VAD_phase1_Ref4_Input_Select);
                    ptr->audio_device5 = hal_audio_convert_mic_config(ptr_VAD_scenario->VAD_phase1_Ref5_Input_Select);
                    ptr->audio_interface5 = hal_audio_convert_mic_interface(ptr_VAD_scenario->VAD_phase1_Ref5_Input_Select);
                #endif
            }
            //----AMIC MIC bias enable
            ptr->bias_select = ptr_VAD_scenario->VAD_MIC_Bias_Enable;
            //----performance mode
            if (ptr_VAD_scenario->VAD_Analog_ADC_Performance_Sel <= 0x04) {
                ptr->performance = ptr_VAD_scenario->VAD_Analog_ADC_Performance_Sel;
            } else {
                log_hal_msgid_error("[AUDIO][HAL] stream in ADC performance config error",0);
                return HAL_AUDIO_STATUS_ERROR;
            }
        }else {
            log_hal_msgid_error("[AUDIO][HAL] hal_audio_get_stream_in_setting_config scenario_sel error.", 0);
            return HAL_AUDIO_STATUS_ERROR;
        }
    }
    /*common AFE config part*/
    /*check if multi device have config I2S device*/
    audio_device = &(ptr->audio_device);
    audio_interface = &(ptr->audio_interface);
    /*max 8 device support on platform*/
    HAL_DSP_PARA_AU_AFE_I2SM_CONFIG_t *ptr_I2SM_config = &audio_nvdm_HW_config.I2SM_config;
    for (uint32_t i = 0; i < 8; i++) { //TODO YB, why while loop
        if (*audio_device & (HAL_AUDIO_DEVICE_I2S_MASTER | HAL_AUDIO_DEVICE_I2S_MASTER_L | HAL_AUDIO_DEVICE_I2S_MASTER_R)) {
            ptr->with_upwdown_sampler = true;
            /*config I2S HW settings*/
            uint32_t index = 0;
            if (*audio_interface & HAL_AUDIO_INTERFACE_1) {
                index = 0;
            } else if (*audio_interface & HAL_AUDIO_INTERFACE_2) {
                index = 1;
            }  else if (*audio_interface & HAL_AUDIO_INTERFACE_3) {
                index = 2;
            } else if (*audio_interface & HAL_AUDIO_INTERFACE_4) {
                index = 3;
            }
            ptr->is_low_jitter[index] = ptr_I2SM_config->I2S_Master_Low_jitter[index];
            ptr->i2s_master_format[index] = ptr_I2SM_config->I2S_Master_Format[index];
            ptr->i2s_master_word_length[index] = ptr_I2SM_config->I2S_Master_Word_length[index];
            ptr->audio_path_input_rate = ptr->i2s_master_sampling_rate[index];
            if (ptr_voice_scenario->Voice_I2S_Master_Sampling_Rate[index] == 0x01) {
                ptr->i2s_master_sampling_rate[index] = 48000;
            } else if (ptr_voice_scenario->Voice_I2S_Master_Sampling_Rate[0] == 0x02) {
                ptr->i2s_master_sampling_rate[index] = 96000;
            } else if (ptr_voice_scenario->Voice_I2S_Master_Sampling_Rate[0] == 0x03) {
                ptr->i2s_master_sampling_rate[index] = 32000;
            } else {
                ptr->i2s_master_sampling_rate[index] = 0;
            }
            //break;
        } else if (*audio_device == HAL_AUDIO_DEVICE_I2S_SLAVE) {
            /*config I2S HW settings*/
            ptr->i2s_format = audio_nvdm_HW_config.I2SS_config.I2S_Slave_Format;
            ptr->i2S_Slave_TDM = audio_nvdm_HW_config.I2SS_config.I2S_Slave_TDM;
            ptr->i2s_word_length = audio_nvdm_HW_config.I2SS_config.I2S_Slave_Word_length;
            log_hal_msgid_info("[stream in] have config I2S slave device in", 0);
            //break;
        }
        audio_device++;
        audio_interface++;
    }
    //----AMIC ACC DCC Setting
    for (i = 0; i < 6; i++) {
        ptr->ul_adc_mode[i] = audio_nvdm_HW_config.adc_dac_config.ADDA_Analog_MIC_Mode[i];
    }
    //----AMIC MIC bias voltage
    for (i = 0; i < 5; i++) {
        ptr->bias_voltage[i] = audio_nvdm_HW_config.adc_dac_config.ADDA_Voice_Bias_Level[i];
        ptr->misc_parms |= (uint32_t)(audio_nvdm_HW_config.adc_dac_config.ADDA_Voice_Bias_Level[i]) << (4 * i);
    }
    //---iir_filter
    if (Audio_or_Voice != AU_DSP_AUDIO) {
        memset(ptr->iir_filter, audio_nvdm_HW_config.adc_dac_config.ADDA_Voice_IIR_Filter, sizeof(ptr->iir_filter));
    } else {
        memset(ptr->iir_filter, audio_nvdm_HW_config.adc_dac_config.ADDA_Audio_IIR_Filter, sizeof(ptr->iir_filter));
    }
    /*use mic scenario common config*/
    if (Audio_or_Voice != AU_DSP_AUDIO) {
        /*amic 0 DCC config*/
        for (i = 0; i < 6; i++) {
            if (ptr->ul_adc_mode[i] == 0x02) {
                if (audio_nvdm_HW_config.adc_dac_config.ADDA_Analog_MIC_VIN_PUD[i] <= 0x02) {
                    ptr->amic_type[i] = audio_nvdm_HW_config.adc_dac_config.ADDA_Analog_MIC_VIN_PUD[i];
                } else {
                    log_hal_msgid_error("[AUDIO][HAL] stream in VIN %d mode config error",1, i);
                    return HAL_AUDIO_STATUS_ERROR;
                }
            }
        }
        //---with_external_bias
        ptr->with_external_bias = 0;
        //---bias lowpower enable
        ptr->with_bias_lowpower = 0;
        //---bias1_2_with_LDO0
        if (audio_nvdm_HW_config.adc_dac_config.ADDA_Voice_Bias012_share_LDO) {
            ptr->bias1_2_with_LDO0 = true;
        }else {
            ptr->bias1_2_with_LDO0 = false;
        }
        //---dmic_selection
        for (i = 0; i < 6; i++) {
            ptr->dmic_selection[i] = audio_nvdm_HW_config.dmic_config.DMIC_Digital_MIC_Pin_Sel[i/2];
        }
        /*enable mic bias 3 select if dmic select analog dmic 3*/
        for (uint8_t i = 0;i < 6;i++) {
            if (ptr->dmic_selection[i] == 0x05) {
                ptr->bias_select |= HAL_AUDIO_BIAS_SELECT_BIAS3;
                break;
            }
        }
        //---DMIC clock
        memset(ptr->dmic_clock_rate,0x00,sizeof(ptr->dmic_clock_rate));
    }
    /*Audio Channel selection setting*/
    if(audio_Channel_Select.modeForAudioChannel){
        //----HW_mode
        status = hal_gpio_get_input((hal_gpio_pin_t)audio_Channel_Select.hwAudioChannel.gpioIndex, &channel_gpio_data);
        if (status == HAL_GPIO_STATUS_OK) {
            if (channel_gpio_data == HAL_GPIO_DATA_HIGH) {
                channel_temp = (audio_Channel_Select.hwAudioChannel.audioChannelGPIOH & (NVKEY_INDEX1|NVKEY_INDEX2)) >> 4;
            } else {
                channel_temp = (audio_Channel_Select.hwAudioChannel.audioChannelGPIOL & (NVKEY_INDEX1|NVKEY_INDEX2)) >> 4;
            }
        } else {
            channel_temp = AU_DSP_CH_LR; //default.
            log_hal_msgid_info("Get Stream in channel setting false with HW_mode.", 0);
        }
    } else {
        channel_temp = (audio_Channel_Select.audioChannel & (NVKEY_INDEX1|NVKEY_INDEX2)) >> 4;
    }
    const hal_audio_channel_selection_t audio_channel_sel_interface[] = {HAL_AUDIO_DIRECT, /*AU_DSP_CH_LR*/
                                                                         HAL_AUDIO_BOTH_L, /*AU_DSP_CH_L*/
                                                                         HAL_AUDIO_BOTH_R, /*AU_DSP_CH_R*/
                                                                         HAL_AUDIO_SWAP_L_R, /*AU_DSP_CH_SWAP*/
                                                                         HAL_AUDIO_MIX_L_R, /*AU_DSP_CH_MIX*/
                                                                         HAL_AUDIO_MIX_SHIFT_L_R/*AU_DSP_CH_MIX_SHIFT*/
                                                                         };
    if (channel_temp <= HAL_AUDIO_MIX_SHIFT_L_R) {
        *MemInterface = audio_channel_sel_interface[channel_temp];
    } else {
        *MemInterface = HAL_AUDIO_DIRECT;
    }
#ifdef HAL_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
    hal_audio_multi_instance_confg(stream_in_open_param);
#endif
    //For debug
    #ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
        log_hal_msgid_info("[stream in] audio_device = %d,audio_device1 = %d,audio_device2 = %d,audio_device3 = %d,audio_device4 = %d,audio_device5 = %d",6,
                        ptr->audio_device,
                        ptr->audio_device1,
                        ptr->audio_device2,
                        ptr->audio_device3,
                        ptr->audio_device4,
                        ptr->audio_device5);
        log_hal_msgid_info("[stream in] audio_interface = %d,audio_interface1 = %d,audio_interface2 = %d,audio_interface3 = %d,audio_interface4 = %d,audio_interface5 = %d",6,
                        ptr->audio_interface,
                        ptr->audio_interface1,
                        ptr->audio_interface2,
                        ptr->audio_interface3,
                        ptr->audio_interface4,
                        ptr->audio_interface5);
    #else
        log_hal_msgid_info("[stream in] audio_device = %d, audio_interface = %d", 2, ptr->audio_device, ptr->audio_interface);
    #endif

    log_hal_msgid_info("[stream in] bias0_1_2_with_LDO0 = %d, bias_select = %d, performance = %d, Audio_or_Voice = %d", 4, ptr->bias1_2_with_LDO0, ptr->bias_select, ptr->performance, Audio_or_Voice);
    for (i = 0;i < 5;i++) {
        log_hal_msgid_info("[stream in] bias_voltage[%d] = %d",2,i,ptr->bias_voltage[i]);
    }
    for (i = 0;i < 6;i++) {
        log_hal_msgid_info("[stream in] bias_voltage[%d] = %d",2,i,ptr->ul_adc_mode[i]);
    }

    return HAL_AUDIO_STATUS_OK;
}

uint8_t hal_audio_get_stream_in_channel_num(audio_scenario_sel_t Audio_or_Voice)
{
    mcu2dsp_open_stream_in_param_t stream_in_open_param;
    uint8_t num=0;
    hal_audio_get_stream_in_setting_config(Audio_or_Voice, &stream_in_open_param);
    if ((stream_in_open_param.afe.audio_device!=0)&&(stream_in_open_param.afe.audio_interface!=0))
    {
        num++;
    }
    if ((stream_in_open_param.afe.audio_device1!=0)&&(stream_in_open_param.afe.audio_interface1!=0))
    {
        num++;
    }
    if ((stream_in_open_param.afe.audio_device2!=0)&&(stream_in_open_param.afe.audio_interface2!=0))
    {
        num++;
    }
    if ((stream_in_open_param.afe.audio_device3!=0)&&(stream_in_open_param.afe.audio_interface3!=0))
    {
        num++;
    }
    if ((stream_in_open_param.afe.audio_device4!=0)&&(stream_in_open_param.afe.audio_interface4!=0))
    {
        num++;
    }
    if ((stream_in_open_param.afe.audio_device5!=0)&&(stream_in_open_param.afe.audio_interface5!=0))
    {
        num++;
    }
    log_hal_msgid_info("[stream in] get channel num = %d", 1, num);
    return num;
}

hal_audio_status_t hal_audio_get_stream_out_setting_config(audio_scenario_sel_t Audio_or_Voice, mcu2dsp_open_stream_out_param_t *stream_out_open_param)
{
    hal_audio_channel_selection_t *MemInterface = &stream_out_open_param->afe.stream_channel;
    uint32_t i = 0;
    uint8_t i2s_master_sampling_rate_nvkey, i2s_master_interface;
    HAL_DSP_PARA_AU_AFE_VOICE_SCENARIO_t *ptr_voice_scenario = &audio_nvdm_HW_config.voice_scenario;
    HAL_DSP_PARA_AU_AFE_AUDIO_SCENARIO_t *ptr_audio_scenario = &audio_nvdm_HW_config.audio_scenario;
    HAL_DSP_PARA_AU_AFE_I2SM_CONFIG_t *ptr_I2SM_config = &audio_nvdm_HW_config.I2SM_config;
    au_afe_open_param_t *ptr = &stream_out_open_param->afe;

    /*Audio HW I/O Configure setting */
    if(Audio_or_Voice == AU_DSP_VOICE){ //0:Audio, 1:Voice
        if (ptr_voice_scenario->Voice_Output_Path < 0x03) { /*0: ----Analog_SPK_Out_L, 1 ----HAL_AUDIO_DEVICE_DAC_R, 2 ----HAL_AUDIO_DEVICE_DAC_DUAL*/
            ptr->audio_device = (ptr_voice_scenario->Voice_Output_Path + 1) << 8;
        } else if (ptr_voice_scenario->Voice_Output_Path < 0x05) {  /*3: ----HAL_AUDIO_DEVICE_I2S_MASTER, 4 ----HAL_AUDIO_DEVICE_I2S_SLAVE, */
            ptr->audio_interface = 1 << (ptr_voice_scenario->Voice_Output_I2S_Interface);
            ptr->audio_device = (ptr_voice_scenario->Voice_Output_Path - 0x03 + 1) << 12;
        } else {
            log_hal_msgid_info("Get Voice Stream out Device error. Defualt", 0);
            ptr->audio_device = HAL_AUDIO_DEVICE_DAC_DUAL;
        }
        //---with_external_bias
        ptr->with_external_bias = 0;
        //---bias lowpower enable
        ptr->with_bias_lowpower = 0;
        //---bias1_2_with_LDO0
        if (audio_nvdm_HW_config.adc_dac_config.ADDA_Voice_Bias012_share_LDO) {
            ptr->bias1_2_with_LDO0 = true;
        }else {
            ptr->bias1_2_with_LDO0 = false;
        }
        //---dmic_selection
        for (i = 0; i < 3; i++) {
            ptr->dmic_selection[i] = audio_nvdm_HW_config.dmic_config.DMIC_Digital_MIC_Pin_Sel[i];
        }
        //---iir_filter
        memset(ptr->iir_filter,audio_nvdm_HW_config.adc_dac_config.ADDA_Voice_IIR_Filter,sizeof(ptr->iir_filter));
    } else if(Audio_or_Voice == AU_DSP_AUDIO) {
        if (ptr_audio_scenario->Audio_A2DP_Output_Path < 0x03) { /*0: ----Analog_SPK_Out_L, 1 ----HAL_AUDIO_DEVICE_DAC_R, 2 ----HAL_AUDIO_DEVICE_DAC_DUAL*/
            ptr->audio_device = (ptr_audio_scenario->Audio_A2DP_Output_Path + 1) << 8;
        } else if (ptr_audio_scenario->Audio_A2DP_Output_Path < 0x05) {  /*3: ----HAL_AUDIO_DEVICE_I2S_MASTER, 4 ----HAL_AUDIO_DEVICE_I2S_SLAVE, */
            ptr->audio_interface = 1 << (ptr_audio_scenario->Audio_A2DP_Output_I2S_Interface);
            ptr->audio_device = (ptr_audio_scenario->Audio_A2DP_Output_Path - 0x03 + 1) << 12;
        } else {
            log_hal_msgid_info("Get Audio Stream out Device error. Defualt", 0);
            ptr->audio_device = HAL_AUDIO_DEVICE_DAC_DUAL;
        }
    } else if (Audio_or_Voice == AU_DSP_LINEIN) {
        if (ptr_audio_scenario->Audio_Linein_Output_Path < 0x03) { /*0: ----Analog_SPK_Out_L, 1 ----HAL_AUDIO_DEVICE_DAC_R, 2 ----HAL_AUDIO_DEVICE_DAC_DUAL*/
            ptr->audio_device = (ptr_audio_scenario->Audio_Linein_Output_Path + 1) << 8;
        } else if (ptr_audio_scenario->Audio_Linein_Output_Path < 0x05) {  /*3: ----HAL_AUDIO_DEVICE_I2S_MASTER, 4 ----HAL_AUDIO_DEVICE_I2S_SLAVE, */
            ptr->audio_interface = hal_audio_convert_linein_interface(0x01,false);
            ptr->audio_device = (ptr_audio_scenario->Audio_Linein_Output_Path - 0x03 + 1) << 12;
        } else {
            log_hal_msgid_info("Get Audio Stream out Device error. Defualt", 0);
            ptr->audio_device = HAL_AUDIO_DEVICE_DAC_DUAL;
        }
    } else if(Audio_or_Voice == AU_DSP_ANC) {
        if (ptr_voice_scenario->Voice_Output_Path < 0x03) { /*0: ----Analog_SPK_Out_L, 1 ----HAL_AUDIO_DEVICE_DAC_R, 2 ----HAL_AUDIO_DEVICE_DAC_DUAL*/
            ptr->audio_device = (ptr_voice_scenario->Voice_Output_Path + 1) << 8;
        } else if (ptr_voice_scenario->Voice_Output_Path == 0x03) {  /*3: ----HAL_AUDIO_DEVICE_I2S_MASTER, */
            ptr->audio_interface = 1<<(ptr_voice_scenario->Voice_Output_I2S_Interface);
            ptr->audio_device = HAL_AUDIO_DEVICE_DAC_DUAL;
        } else {
            log_hal_msgid_info("Get Audio Stream out Device error. Defualt", 0);
            ptr->audio_device = HAL_AUDIO_DEVICE_DAC_DUAL;
        }
    } else if (Audio_or_Voice == AU_DSP_SIDETONE) {
        if (ptr_voice_scenario->Voice_Output_Path < 0x03) { /*0: ----Analog_SPK_Out_L, 1 ----HAL_AUDIO_DEVICE_DAC_R, 2 ----HAL_AUDIO_DEVICE_DAC_DUAL*/
            ptr->audio_device = (ptr_voice_scenario->Voice_Output_Path + 1) << 8;
        } else if (ptr_voice_scenario->Voice_Output_Path < 0x05) {  /*3: ----HAL_AUDIO_DEVICE_I2S_MASTER, 4 ----HAL_AUDIO_DEVICE_I2S_SLAVE, */
#ifdef HAL_CHANGE_SIDETONE_OUTPUT_I2S_INTERFACE_USE_A2DP
            /* The sidetone use A2DP path */
            ptr->audio_interface = 1 << (ptr_audio_scenario->Audio_Output_I2S_Interface);
#else
            /* The sidetone use HFP path */
            ptr->audio_interface = 1 << (ptr_voice_scenario->Voice_Output_I2S_Interface);
#endif
            ptr->audio_device = (ptr_voice_scenario->Voice_Output_Path - 0x03 + 1) << 12;
        } else {
            log_hal_msgid_info("Get Audio Stream out Device error. Defualt", 0);
            ptr->audio_device = HAL_AUDIO_DEVICE_DAC_DUAL;
        }

        //---with_external_bias
        ptr->with_external_bias = 0;
        //---bias lowpower enable
        ptr->with_bias_lowpower = 0;
        //---bias1_2_with_LDO0
        if (audio_nvdm_HW_config.adc_dac_config.ADDA_Voice_Bias012_share_LDO) {
            ptr->bias1_2_with_LDO0 = true;
        } else {
            ptr->bias1_2_with_LDO0 = false;
        }
        //---dmic_selection
        for (i = 0; i < 3; i++) {
            ptr->dmic_selection[i] = audio_nvdm_HW_config.dmic_config.DMIC_Digital_MIC_Pin_Sel[i];
        }
        //---iir_filter
        memset(ptr->iir_filter, audio_nvdm_HW_config.adc_dac_config.ADDA_Voice_IIR_Filter, sizeof(ptr->iir_filter));
    }

    /*I2S COMMON PARA*/
    if (ptr->audio_device & (HAL_AUDIO_DEVICE_I2S_MASTER | HAL_AUDIO_DEVICE_I2S_MASTER_L | HAL_AUDIO_DEVICE_I2S_MASTER_R)) {
        /*config I2S HW settings*/
        if (ptr->audio_interface == HAL_AUDIO_INTERFACE_1) {
            i2s_master_interface = 0;
        } else if (ptr->audio_interface == HAL_AUDIO_INTERFACE_2) {
            i2s_master_interface = 1;
        } else if (ptr->audio_interface == HAL_AUDIO_INTERFACE_3) {
            i2s_master_interface = 2;
        } else {
            i2s_master_interface = 3;
        }
        if ((Audio_or_Voice == AU_DSP_AUDIO)||(Audio_or_Voice == AU_DSP_LINEIN)) {
            i2s_master_sampling_rate_nvkey = ptr_audio_scenario->Audio_I2S_Master_Sampling_Rate[i2s_master_interface];
        } else {
            i2s_master_sampling_rate_nvkey = ptr_voice_scenario->Voice_I2S_Master_Sampling_Rate[i2s_master_interface];
        }
        const uint32_t i2s_sampling_rate[] = {0, 48000, 96000, 32000};
        if (i2s_master_sampling_rate_nvkey <= 0x03) {
            ptr->i2s_master_sampling_rate[i2s_master_interface] = i2s_sampling_rate[i2s_master_sampling_rate_nvkey];
        } else {
            ptr->i2s_master_sampling_rate[i2s_master_interface] = 0;
        }
        ptr->is_low_jitter[i2s_master_interface] = ptr_I2SM_config->I2S_Master_Low_jitter[i2s_master_interface];
        ptr->i2s_master_format[i2s_master_interface] = ptr_I2SM_config->I2S_Master_Format[i2s_master_interface];
        ptr->i2s_master_word_length[i2s_master_interface] = ptr_I2SM_config->I2S_Master_Word_length[i2s_master_interface];
    } else if (ptr->audio_device == HAL_AUDIO_DEVICE_I2S_SLAVE) {
        /*config I2S HW settings*/
        ptr->i2s_format = audio_nvdm_HW_config.I2SS_config.I2S_Slave_Format;
        ptr->i2S_Slave_TDM = audio_nvdm_HW_config.I2SS_config.I2S_Slave_TDM;
        ptr->i2s_word_length = audio_nvdm_HW_config.I2SS_config.I2S_Slave_Word_length;
        //break;
    }

    /*DAC AFE PARA*/
    if (audio_nvdm_HW_config.adc_dac_config.ADDA_DAC_Class_AB_G_Performance_Sel == 0x01) {
        ptr->performance = 0x01;
        log_hal_msgid_info("DL DAC change to HP mode", 0);
    } else {
        ptr->performance = 0x00;
    }
    if (audio_nvdm_HW_config.adc_dac_config.ADDA_DAC_Mode_Sel <= 0x02) {
        ptr->dl_dac_mode = audio_nvdm_HW_config.adc_dac_config.ADDA_DAC_Mode_Sel; /*0x00:  HAL_AUDIO_ANALOG_OUTPUT_CLASSG,  0x01: HAL_AUDIO_ANALOG_OUTPUT_CLASSAB, 0x02: HAL_AUDIO_ANALOG_OUTPUT_CLASSD*/
    } else {
        ptr->dl_dac_mode = HAL_AUDIO_ANALOG_OUTPUT_CLASSAB;
    }

    //Change to DSP SW Channel select
    *MemInterface = HAL_AUDIO_DIRECT;

    //For debug
    log_hal_msgid_info("[stream out] Audio_or_Voice = %d, audio_device = %d, audio_interface = %d, tream_channel = %d, bias0_1_2_with_LDO0 = %d", 
                        5, Audio_or_Voice, ptr->audio_device, ptr->audio_interface, ptr->stream_channel, ptr->bias1_2_with_LDO0);

    return HAL_AUDIO_STATUS_OK;
}
#endif

#if defined(HAL_DVFS_MODULE_ENABLED) && defined(HAL_DVFS_416M_SOURCE)
void hal_audio_set_dvfs_clk(audio_scenario_sel_t Audio_or_Voice, dvfs_frequency_t *dvfs_clk)
{
    if(Audio_or_Voice == AU_DSP_VOICE) //0:Audio, 1:Voice
    {
        if (audio_nvdm_dvfs_config.HFP_DVFS_CLK < HAL_DVFS_MAX_SPEED) {
            *dvfs_clk = audio_nvdm_dvfs_config.HFP_DVFS_CLK;
        } else {
            *dvfs_clk = HAL_DVFS_HALF_SPEED_52M_W_LDSP;
        }
    }
}
#endif

void hal_audio_set_dvfs_control(hal_audio_dvfs_speed_t DVFS_SPEED, hal_audio_dvfs_lock_parameter_t DVFS_lock)
{
#ifdef HAL_DVFS_MODULE_ENABLED
    hal_dvfs_lock_control(DVFS_SPEED ,DVFS_lock );
#else
    //log_hal_msgid_info("[Hal]dvfs module not enable.", 0);
#endif
}

#if defined(HAL_AUDIO_SUPPORT_DEBUG_DUMP)
/**
  * @ Dump audio debug register
  */
void hal_audio_debug_dump(void)
{
    if (hal_audio_status_query_running_flag_value() == false) {
        log_hal_msgid_info("Not do audio debug dump, dsp_controller.running == 0", 0);
        return;
    }
}
#endif

#if defined(HAL_AUDIO_SUPPORT_APLL)

#define AFE_WRITE8(addr, val)   *((volatile uint8_t *)(addr)) = val
#define AFE_READ(addr)          *((volatile uint32_t *)(addr))
#define AFE_WRITE(addr, val)    *((volatile uint32_t *)(addr)) = val
#define AFE_SET_REG(addr, val, msk)  AFE_WRITE((addr), ((AFE_READ(addr) & (~(msk))) | ((val) & (msk))))
#define ReadREG(_addr)          (*(volatile uint32_t *)(_addr))

afe_apll_source_t afe_get_apll_by_samplerate(uint32_t samplerate)
{
    if (samplerate == 176400 || samplerate == 88200 || samplerate == 44100 || samplerate == 22050 || samplerate == 11025) {
        return AFE_APLL1;
    }
    else {
        return AFE_APLL2;
    }
}

hal_audio_status_t hal_audio_apll_enable(bool enable, uint32_t samplerate)
{
    //uint32_t mask;
    //hal_nvic_save_and_set_interrupt_mask(&mask);
    hal_audio_status_t result = HAL_AUDIO_STATUS_OK;

    if (true == enable) {
        switch (afe_get_apll_by_samplerate(samplerate)) {
            case AFE_APLL1:
                aud_apll_1_cntr++;
                if (aud_apll_1_cntr == 1) {
                    log_hal_msgid_info("[APLL] TurnOnAPLL1, FS:%d, APLL1_CNT:%d", 2, samplerate, aud_apll_1_cntr);
                    clock_mux_sel(CLK_AUD_INTERFACE1_SEL,2);
                    hal_clock_enable(HAL_CLOCK_CG_AUD_INTF1);//modify for ab1568
                } else {
                    log_hal_msgid_info("[APLL] TurnOnAPLL1 again, FS:%d, APLL1_CNT:%d", 2, samplerate, aud_apll_1_cntr);
                }
                break;
            case AFE_APLL2:
                aud_apll_2_cntr++;
                if (aud_apll_2_cntr == 1) {
                    log_hal_msgid_info("[APLL] TurnOnAPLL2, FS:%d, APLL2_CNT:%d", 2, samplerate, aud_apll_2_cntr);
                    //clock_mux_sel(CLK_AUD_INTERFACE0_SEL,3);// 3 : APLL2_CK,    24.576 / 22.579 MHz
                    //hal_clock_enable(HAL_CLOCK_CG_AUD_INTF0);//modify for ab1568
                    clock_mux_sel(CLK_AUD_INTERFACE0_SEL,3);// 3 : APLL2_CK,    24.576 / 22.579 MHz
                    hal_clock_enable(HAL_CLOCK_CG_AUD_INTF0);//modify for ab1568

                    // Step 2 Enable APLL - Setting APLL tuner - use APLL2 :
                    //AFE_SET_REG(0xA2050138, 0x0F1FAA4C);
                    //AFE_SET_REG(0xA2050130, 0x00000100);
                    //AFE_SET_REG(0xA2050134, 0x00000001);
                    //APLL2 48k base
                    //AFE_SET_REG(AFE_APLL1_TUNER_CFG, 0x435);
                } else {
                    log_hal_msgid_info("[APLL] TurnOnAPLL2 again, FS:%d, APLL2_CNT:%d", 2, samplerate, aud_apll_2_cntr);
                }
                break;
            default:
                result = HAL_AUDIO_STATUS_INVALID_PARAMETER;
                break;
        }
    } else {
        switch (afe_get_apll_by_samplerate(samplerate)) {
            case AFE_APLL1:
                aud_apll_1_cntr--;
                if (aud_apll_1_cntr == 0) {
                    log_hal_msgid_info("[APLL] TurnOffAPLL1, FS:%d, APLL1_CNT:%d", 2, samplerate, aud_apll_1_cntr);
                    hal_clock_disable(HAL_CLOCK_CG_AUD_INTF1);//modify for ab1568
                } else if (aud_apll_1_cntr < 0) {
                    log_hal_msgid_info("[APLL] Error, Already TurnOffAPLL1, FS:%d, APLL1_CNT:0", 1, samplerate);
                    aud_apll_1_cntr = 0;
                    result = HAL_AUDIO_STATUS_ERROR;
                } else {
                    log_hal_msgid_info("[APLL] TurnOffAPLL1 again, FS:%d, APLL1_CNT:%d", 2, samplerate, aud_apll_1_cntr);
                }
                break;
            case AFE_APLL2:
                aud_apll_2_cntr--;
                if (aud_apll_2_cntr == 0) {
                    log_hal_msgid_info("[APLL] TurnOffAPLL2, FS:%d, APLL2_CNT:%d", 2, samplerate, aud_apll_2_cntr);
                    hal_clock_disable(HAL_CLOCK_CG_AUD_INTF0);//modify for ab1568
                } else if (aud_apll_2_cntr < 0) {
                    log_hal_msgid_info("[APLL] Error, Already TurnOffAPLL2, FS:%d, APLL2_CNT:0", 1, samplerate);
                    aud_apll_2_cntr = 0;
                    result = HAL_AUDIO_STATUS_ERROR;
                } else {
                    log_hal_msgid_info("[APLL] TurnOffAPLL2 again, FS:%d, APLL2_CNT:%d", 2, samplerate, aud_apll_2_cntr);
                }
                break;
            default:
                result = HAL_AUDIO_STATUS_INVALID_PARAMETER;
                break;
        }
    }
    //hal_nvic_restore_interrupt_mask(mask);
    return result;
}

hal_audio_status_t hal_audio_query_apll_status(void) {
    log_hal_msgid_info("[APLL] aud_apll_1_cntr=%d, aud_apll_2_cntr=%d", 2, aud_apll_1_cntr, aud_apll_2_cntr);
    return HAL_AUDIO_STATUS_OK;
}

hal_audio_status_t hal_audio_mclk_enable(bool enable, afe_mclk_out_pin_t mclkoutpin, afe_apll_source_t apll, uint8_t divider)
{
    if (mclkoutpin != AFE_MCLK_PIN_FROM_I2S0 && mclkoutpin != AFE_MCLK_PIN_FROM_I2S1 && mclkoutpin != AFE_MCLK_PIN_FROM_I2S2 && mclkoutpin != AFE_MCLK_PIN_FROM_I2S3) {
        log_hal_msgid_info("[MCLK] not support mclkoutpin=%d", 1, mclkoutpin);
        return HAL_AUDIO_STATUS_INVALID_PARAMETER;
    }
    if (apll != AFE_APLL1 && apll != AFE_APLL2) {
        log_hal_msgid_info("[MCLK] not support apll=%d", 1, apll);
        return HAL_AUDIO_STATUS_INVALID_PARAMETER;
    }
    if (divider > 127) {
        log_hal_msgid_info("[MCLK] not support divider=%d", 1, divider);
        return HAL_AUDIO_STATUS_INVALID_PARAMETER;
    }
    mcu2dsp_open_param_t open_param;
    memset(&open_param, 0, sizeof(mcu2dsp_open_param_t));
    if (apll == AFE_APLL2) {
        open_param.stream_out_param.afe.sampling_rate = 48000;
    } else {
        open_param.stream_out_param.afe.sampling_rate = 44100;
    }

    if (enable) {
        if (mclk_status[mclkoutpin].status == MCLK_DISABLE) {
            ami_hal_audio_status_set_running_flag(AUDIO_SCENARIO_TYPE_MCLK, &open_param, true);
            uint32_t clock_divider_reg;
            uint32_t clock_divider_shift;
            bool toggled_bit = 0;
            if ((mclkoutpin == AFE_MCLK_PIN_FROM_I2S0) || (mclkoutpin == AFE_MCLK_PIN_FROM_I2S1)) {
                clock_divider_reg = 0xA2020308;
            } else {
                clock_divider_reg = 0xA202030C;
            }
            if ((mclkoutpin == AFE_MCLK_PIN_FROM_I2S0) || (mclkoutpin == AFE_MCLK_PIN_FROM_I2S2)) {
                clock_divider_shift = 0;
            } else {
                clock_divider_shift = 16;
            }
            switch (apll) {
                case AFE_APLL1:
                    //hal_audio_apll_enable(true, 44100);
                    clock_mux_sel(CLK_MCLK_SEL,0);
                    AFE_SET_REG (0xA2020304, 0, 0x3<<(8*mclkoutpin));                   // I2S0/1/2/3 clock_source from APLL1
                    mclk_status[mclkoutpin].apll = AFE_APLL1;
                    break;
                case AFE_APLL2:
                default:
                    //hal_audio_apll_enable(true, 48000);
                    clock_mux_sel(CLK_MCLK_SEL,1);
                    AFE_SET_REG (0xA2020304, 0x1<<(8*mclkoutpin), 0x3<<(8*mclkoutpin)); // I2S0/1/2/3 clock_source from APLL2
                    mclk_status[mclkoutpin].apll = AFE_APLL2;
                    break;
            }
            // Setting audio clock divider   //Toggled to apply apll_ck_div bit-8 or bit-24
            //MCLK = clock_source/(1+n), n = [6:0], clock_source : AFE_I2S_SETTING_MCLK_SOURCE, n : AFE_I2S_SETTING_MCLK_DIVIDER)
            toggled_bit = (ReadREG(clock_divider_reg)&(0x00000100<<clock_divider_shift))>>8;
            if (toggled_bit == true) {
                AFE_SET_REG (clock_divider_reg, divider<<clock_divider_shift, 0x17f<<clock_divider_shift);
            } else {
                AFE_SET_REG (clock_divider_reg, (divider | 0x00000100)<<clock_divider_shift, 0x17f<<clock_divider_shift);
            }

            //Power on apll12_div0/1/2/3 divider
            AFE_SET_REG(0xA2020300, 0<<(8*mclkoutpin), 1<<(8*mclkoutpin));
            mclk_status[mclkoutpin].mclk_cntr++;
            mclk_status[mclkoutpin].divider = divider;
            mclk_status[mclkoutpin].status = MCLK_ENABLE;
            log_hal_msgid_info("[MCLK] TurnOnMCLK[%d], apll%d with divider%d, MCLK_CNT=%d", 4, mclkoutpin, apll, divider, mclk_status[mclkoutpin].mclk_cntr);
            return HAL_AUDIO_STATUS_OK;
        } else {
            if ((mclk_status[mclkoutpin].apll == apll) && (mclk_status[mclkoutpin].divider == divider)) {
                mclk_status[mclkoutpin].mclk_cntr++;
                log_hal_msgid_info("[MCLK] TurnOnMCLK[%d], apll%d with divider%d again, MCLK_CNT=%d", 4, mclkoutpin, apll, divider, mclk_status[mclkoutpin].mclk_cntr);
                return HAL_AUDIO_STATUS_OK;
            } else {
                log_hal_msgid_info("[MCLK] Error, Already TurnOnMCLK[%d] apll%d with divider%d, Request apll%d with divider%d is invalid", 5, mclkoutpin, mclk_status[mclkoutpin].apll, mclk_status[mclkoutpin].divider, apll, divider);
                return HAL_AUDIO_STATUS_ERROR;
            }
        }
    } else {
        if (mclk_status[mclkoutpin].status == MCLK_ENABLE) {
            if ((mclk_status[mclkoutpin].apll == apll) && (mclk_status[mclkoutpin].divider == divider)) {
                mclk_status[mclkoutpin].mclk_cntr--;

                if (mclk_status[mclkoutpin].mclk_cntr == 0) {
                    AFE_SET_REG(0xA2020300, 1<<(8*mclkoutpin), 1<<(8*mclkoutpin));
                    if(mclk_status[mclkoutpin].apll == AFE_APLL1) {
                        //hal_audio_apll_enable(false, 44100);
                    } else {
                        //hal_audio_apll_enable(false, 48000);
                    }
                    mclk_status[mclkoutpin].status = MCLK_DISABLE;
                    mclk_status[mclkoutpin].mclk_cntr = 0;
                    mclk_status[mclkoutpin].apll = AFE_APLL_NONE;
                    mclk_status[mclkoutpin].divider = 0;
                    log_hal_msgid_info("[MCLK] TurnOffMCLK[%d], apll%d with divider%d, MCLK_CNT=%d", 4, mclkoutpin, apll, divider, mclk_status[mclkoutpin].mclk_cntr);
                    if (mclk_status[AFE_MCLK_PIN_FROM_I2S0].mclk_cntr == 0 && mclk_status[AFE_MCLK_PIN_FROM_I2S1].mclk_cntr == 0 && mclk_status[AFE_MCLK_PIN_FROM_I2S2].mclk_cntr == 0 && mclk_status[AFE_MCLK_PIN_FROM_I2S3].mclk_cntr == 0) {
                        ami_hal_audio_status_set_running_flag(AUDIO_SCENARIO_TYPE_MCLK, &open_param, false);
                    }
                    return HAL_AUDIO_STATUS_OK;
                } else if (mclk_status[mclkoutpin].mclk_cntr < 0) {
                    log_hal_msgid_info("[MCLK] Error, Already TurnOffMCLK[%d], apll%d with divider%d, MCLK_CNT=%d", 4, mclkoutpin, apll, divider, mclk_status[mclkoutpin].mclk_cntr);
                    mclk_status[mclkoutpin].mclk_cntr = 0;
                    return HAL_AUDIO_STATUS_ERROR;
                } else {
                    log_hal_msgid_info("[MCLK] TurnOffMCLK[%d], apll%d with divider%d again, MCLK_CNT=%d", 4, mclkoutpin, apll, divider, mclk_status[mclkoutpin].mclk_cntr);
                    return HAL_AUDIO_STATUS_OK;
                }
            } else {
                log_hal_msgid_info("[MCLK] Error, Already TurnOnMCLK[%d] apll%d with divider%d, Request TurnOffMCLK apll%d with divider%d is invalid", 5, mclkoutpin, mclk_status[mclkoutpin].apll, mclk_status[mclkoutpin].divider, apll, divider);
                return HAL_AUDIO_STATUS_ERROR;
            }
        } else {
            log_hal_msgid_info("[MCLK] Already TurnOffMCLK[%d]", 1, mclkoutpin);
            return HAL_AUDIO_STATUS_ERROR;
        }
    }
}

hal_audio_status_t hal_audio_query_mclk_status(void) {
    uint8_t i = 0;
    for (i=0; i<4; i++) {
        log_hal_msgid_info("[MCLK] mclk_status[%d].status=%d, .mclk_cntr=%d, .apll=%d, .divider=%d", 5, i, mclk_status[i].status,
			                                                           mclk_status[i].mclk_cntr, mclk_status[i].apll, mclk_status[i].divider);
    }
    return HAL_AUDIO_STATUS_OK;
}
#endif

#ifdef HAL_AUDIO_ANC_ENABLE
extern void ami_hal_audio_status_set_running_flag(audio_scenario_type_t type, mcu2dsp_open_param_t *param, bool is_running);
extern bool ami_hal_audio_status_query_running_flag(audio_scenario_type_t type);
uint32_t hal_audio_get_anc_talk_mic_settings(void)
{
    uint32_t talk_mic = 6; //None-type
    mcu2dsp_open_stream_in_param_t in_param;
    memset(&in_param, 0, sizeof(mcu2dsp_open_stream_in_param_t));
    hal_audio_get_stream_in_setting_config(AU_DSP_VOICE, &in_param);
    switch (in_param.afe.audio_device) {
        case HAL_AUDIO_DEVICE_MAIN_MIC_L: {
            if (in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_1) {
                talk_mic = 0;
            } else if (in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_2) {
                talk_mic = 2;
            } else if (in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_3) {
                talk_mic = 4;
            }
            break;
        }
        case HAL_AUDIO_DEVICE_MAIN_MIC_R: {
            if (in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_1) {
                talk_mic = 1;
            } else if (in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_2) {
                talk_mic = 3;
            } else if (in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_3) {
                talk_mic = 5;
            }
            break;
        }
        case HAL_AUDIO_DEVICE_DIGITAL_MIC_L: {
            if (in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_1) {
                talk_mic = 8;
            } else if (in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_2) {
                talk_mic = 10;
            } else if (in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_3) {
                talk_mic = 12;
            }
            break;
        }
        case HAL_AUDIO_DEVICE_DIGITAL_MIC_R: {
            if (in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_1) {
                talk_mic = 9;
            } else if (in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_2) {
                talk_mic = 11;
            } else if (in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_3) {
                talk_mic = 13;
            }
            break;
        }
        default:
            break;
    }
    log_hal_msgid_info("[ANC_GET] Call(0x%x)(0x%x), mic_type(%d)", 3, in_param.afe.audio_device, in_param.afe.audio_interface, talk_mic);
    return talk_mic;
}

hal_audio_status_t hal_audio_notify_anc_afe_settings(bool isEnable)
{
    if (isEnable) {
        void *p_param_share;
        mcu2dsp_open_param_t adda_param;
        memset(&adda_param, 0, sizeof(mcu2dsp_open_param_t));
        hal_audio_get_stream_in_setting_config(AU_DSP_ANC, &adda_param.stream_in_param);
        hal_audio_get_stream_out_setting_config(AU_DSP_ANC, &adda_param.stream_out_param);
        adda_param.stream_in_param.afe.sampling_rate  = 16000;
#ifdef AIR_FIXED_DL_SAMPLING_RATE_TO_96KHZ
        adda_param.stream_out_param.afe.sampling_rate = HAL_AUDIO_FIXED_AFE_96K_SAMPLE_RATE;
#else
        adda_param.stream_out_param.afe.sampling_rate = HAL_AUDIO_FIXED_AFE_48K_SAMPLE_RATE;
#endif

        //Set running flag
        if (!ami_hal_audio_status_query_running_flag(AUDIO_SCENARIO_TYPE_ANC)) {
            ami_hal_audio_status_set_running_flag(AUDIO_SCENARIO_TYPE_ANC, &adda_param, true);
            hal_clock_enable(HAL_CLOCK_CG_AUD_ANC);
        }
        p_param_share = hal_audio_dsp_controller_put_paramter(&adda_param, sizeof(mcu2dsp_open_param_t), AUDIO_MESSAGE_TYPE_ANC);

        //hal_audio_dsp_dl_clkmux_control(AUDIO_MESSAGE_TYPE_ANC, adda_param.stream_out_param.afe.audio_device, adda_param.stream_out_param.afe.sampling_rate, TRUE);
        hal_audio_dsp_controller_send_message(MSG_MCU2DSP_COMMON_ANC_SET_PARAM, (unsigned short)(4 << 12), (uint32_t)p_param_share, true);
    }
    return HAL_AUDIO_STATUS_OK;
}
#endif

#ifdef LINE_IN_PURE_FOR_AMIC_CLASS_G_HQA
static linein_playback_state_hqa_t linein_status;
linein_result_hqa_t audio_pure_linein_playback_open_HQA(hal_audio_sampling_rate_t linein_sample_rate, hal_audio_device_t in_audio_device, hal_audio_interface_t device_in_interface_HQA, hal_audio_analog_mdoe_t adc_mode_HQA, hal_audio_performance_mode_t mic_performance_HQA, hal_audio_device_t out_audio_device, hal_audio_performance_mode_t dac_performance_HQA)
{
    if (audio_nvdm_HW_config.adc_dac_config.ADDA_DAC_Mode_Sel == 0x0) {
        if (dac_performance_HQA == AFE_PEROFRMANCE_LOW_POWER_MODE) {
            audio_nvdm_HW_config.adc_dac_config.ADDA_DAC_Mode_Sel = 0x3;
        }
    }

    log_hal_msgid_info("enter pure_linein_playback_open_HQA, sample_rate=%d, in_audio_device=0x%x, out_audio_device=0x%x\n", 3, hal_audio_sampling_rate_enum_to_value(linein_sample_rate), in_audio_device, out_audio_device);
    if (linein_status != LINEIN_STATE_HQA_IDLE) {
        log_hal_msgid_info("cannot open because state(%d)\n", 1, linein_status);
        return LINEIN_EXECUTION_HQA_FAIL;
    }

    if (linein_sample_rate != HAL_AUDIO_SAMPLING_RATE_16KHZ && linein_sample_rate != HAL_AUDIO_SAMPLING_RATE_48KHZ && linein_sample_rate != HAL_AUDIO_SAMPLING_RATE_96KHZ && linein_sample_rate != HAL_AUDIO_SAMPLING_RATE_192KHZ) {
        log_hal_msgid_info("not support sample rate=%d\n", 1, hal_audio_sampling_rate_enum_to_value(linein_sample_rate));
        return LINEIN_EXECUTION_HQA_FAIL;
    }
    if (in_audio_device != HAL_AUDIO_DEVICE_I2S_MASTER && in_audio_device != HAL_AUDIO_DEVICE_I2S_SLAVE && in_audio_device != HAL_AUDIO_DEVICE_SPDIF && ((in_audio_device & HAL_AUDIO_DEVICE_MAIN_MIC_DUAL) == false)
        && ((in_audio_device & HAL_AUDIO_DEVICE_LINEINPLAYBACK_DUAL) == false) && ((in_audio_device & HAL_AUDIO_DEVICE_DIGITAL_MIC_DUAL) == false)) {
        log_hal_msgid_info("not support in device=%d\n", 1, in_audio_device);
        return LINEIN_EXECUTION_HQA_FAIL;
    }

    if (out_audio_device != HAL_AUDIO_DEVICE_I2S_MASTER && out_audio_device != HAL_AUDIO_DEVICE_I2S_SLAVE && out_audio_device != HAL_AUDIO_DEVICE_SPDIF && ((out_audio_device & HAL_AUDIO_DEVICE_DAC_DUAL) == false)) {
        log_hal_msgid_info("not support out device=%d\n", 1, out_audio_device);
        return LINEIN_EXECUTION_HQA_FAIL;
    }

    mcu2dsp_open_param_t *open_param = NULL;
    open_param = (mcu2dsp_open_param_t *)pvPortMalloc(sizeof(mcu2dsp_open_param_t));
    if (open_param == NULL) {
        return LINEIN_EXECUTION_HQA_FAIL;
    }
    memset(open_param, 0, sizeof(mcu2dsp_open_param_t));
    void *p_param_share;

    open_param->param.stream_in = STREAM_IN_AFE;
    open_param->param.stream_out = STREAM_OUT_AFE;
    open_param->audio_scenario_type = AUDIO_SCENARIO_TYPE_LINE_IN;

    open_param->stream_in_param.afe.audio_interface = device_in_interface_HQA;

#ifdef MTK_AUDIO_HW_IO_CONFIG_ENHANCE
    open_param->stream_in_param.afe.performance = mic_performance_HQA;
    open_param->stream_in_param.afe.bias_voltage[0] = HAL_AUDIO_BIAS_VOLTAGE_2_40V;
    open_param->stream_in_param.afe.bias_voltage[1] = HAL_AUDIO_BIAS_VOLTAGE_2_40V;
    open_param->stream_in_param.afe.bias_voltage[2] = HAL_AUDIO_BIAS_VOLTAGE_2_40V;
    open_param->stream_in_param.afe.bias_voltage[3] = HAL_AUDIO_BIAS_VOLTAGE_2_40V;
    open_param->stream_in_param.afe.bias_voltage[4] = HAL_AUDIO_BIAS_VOLTAGE_2_40V;
    open_param->stream_in_param.afe.bias_select = audio_nvdm_HW_config.voice_scenario.Voice_MIC_Bias_Enable;
    open_param->stream_in_param.afe.iir_filter[0] = HAL_AUDIO_UL_IIR_DISABLE;
#ifdef AIR_BTA_IC_PREMIUM_G2
    if ((adc_mode_HQA == HAL_AUDIO_ANALOG_INPUT_ACC10K)) {
#else //AIR_BTA_IC_PREMIUM_G3
    if ((adc_mode_HQA == HAL_AUDIO_ANALOG_INPUT_ACC10K) || (adc_mode_HQA == HAL_AUDIO_ANALOG_INPUT_ACC10K_SINGLE)) {
#endif
        open_param->stream_in_param.afe.adc_mode = HAL_AUDIO_ANALOG_INPUT_ACC10K;
#ifdef AIR_BTA_IC_PREMIUM_G2
    } else if ((adc_mode_HQA == HAL_AUDIO_ANALOG_INPUT_ACC20K)) {
#else //AIR_BTA_IC_PREMIUM_G3
    } else if ((adc_mode_HQA == HAL_AUDIO_ANALOG_INPUT_ACC20K) || (adc_mode_HQA == HAL_AUDIO_ANALOG_INPUT_ACC20K_SINGLE)) {
#endif
        open_param->stream_in_param.afe.adc_mode = HAL_AUDIO_ANALOG_INPUT_ACC20K;
    }
#ifndef AIR_BTA_IC_PREMIUM_G2 //AIR_BTA_IC_PREMIUM_G3
    if ((adc_mode_HQA == HAL_AUDIO_ANALOG_INPUT_ACC10K) || (adc_mode_HQA == HAL_AUDIO_ANALOG_INPUT_ACC20K)) {
        open_param->stream_in_param.afe.adc_type = HAL_AUDIO_ANALOG_TYPE_DIFF;
    } else if ((adc_mode_HQA == HAL_AUDIO_ANALOG_INPUT_ACC10K_SINGLE) || (adc_mode_HQA == HAL_AUDIO_ANALOG_INPUT_ACC20K_SINGLE)) {
        open_param->stream_in_param.afe.adc_type = HAL_AUDIO_ANALOG_TYPE_SINGLE;
    }
#endif
    open_param->stream_in_param.afe.dmic_selection[0] = HAL_AUDIO_DMIC_GPIO_DMIC0;
    if ((in_audio_device == HAL_AUDIO_DEVICE_DIGITAL_MIC_DUAL)) {
        if ((int)adc_mode_HQA == (int)HAL_AUDIO_DMIC_GPIO_DMIC0) {
            open_param->stream_in_param.afe.dmic_selection[0] = HAL_AUDIO_DMIC_GPIO_DMIC0;
        } else if ((int)adc_mode_HQA == (int)HAL_AUDIO_DMIC_GPIO_DMIC1) {
            open_param->stream_in_param.afe.dmic_selection[0] = HAL_AUDIO_DMIC_GPIO_DMIC1;
        } else if ((int)adc_mode_HQA == (int)HAL_AUDIO_DMIC_ANA_DMIC0) {
            open_param->stream_in_param.afe.dmic_selection[0] = HAL_AUDIO_DMIC_ANA_DMIC0;
        } else if ((int)adc_mode_HQA == (int)HAL_AUDIO_DMIC_ANA_DMIC1) {
            open_param->stream_in_param.afe.dmic_selection[0] = HAL_AUDIO_DMIC_ANA_DMIC1;
        } else if ((int)adc_mode_HQA == (int)HAL_AUDIO_DMIC_ANA_DMIC2) {
            open_param->stream_in_param.afe.dmic_selection[0] = HAL_AUDIO_DMIC_ANA_DMIC2;
        } else if ((int)adc_mode_HQA == (int)HAL_AUDIO_DMIC_ANA_DMIC3) {
            open_param->stream_in_param.afe.dmic_selection[0] = HAL_AUDIO_DMIC_ANA_DMIC3;
        }
        log_hal_msgid_info("[Dmic_HQA] adc_mode/DMIC_pin %d, dmic_selection %d", 2, adc_mode_HQA, open_param->stream_in_param.afe.dmic_selection[0]);
    }
#endif

    open_param->stream_in_param.afe.audio_device = in_audio_device;
    open_param->stream_in_param.afe.sampling_rate = hal_audio_sampling_rate_enum_to_value(linein_sample_rate);
    if (open_param->stream_in_param.afe.audio_device == HAL_AUDIO_DEVICE_I2S_MASTER) {
        open_param->stream_in_param.afe.misc_parms      = I2S_CLK_SOURCE_DCXO;
        if (linein_sample_rate > HAL_AUDIO_SAMPLING_RATE_48KHZ) {
            open_param->stream_in_param.afe.misc_parms  = I2S_CLK_SOURCE_APLL;
        }
    } else {
        if (in_audio_device & HAL_AUDIO_DEVICE_LINEINPLAYBACK_DUAL) {
            open_param->stream_in_param.afe.misc_parms      = MICBIAS_SOURCE_ALL | MICBIAS3V_OUTVOLTAGE_2p4v;
        } else {
            open_param->stream_in_param.afe.misc_parms      = MICBIAS_SOURCE_ALL | MICBIAS3V_OUTVOLTAGE_1p85v;
        }
    }

    open_param->stream_out_param.afe.audio_device = out_audio_device;
    //open_param->stream_out_param.afe.audio_interface = HAL_AUDIO_INTERFACE_1;
    open_param->stream_out_param.afe.audio_interface = device_in_interface_HQA;
    open_param->stream_out_param.afe.stream_channel = HAL_AUDIO_DIRECT;
    //LINEIN_PLAYBACK_LOG_I("[Factory Test] Loopback headset setting ", 0);

    open_param->stream_out_param.afe.format = HAL_AUDIO_PCM_FORMAT_S32_LE;
    open_param->stream_out_param.afe.stream_out_sampling_rate = hal_audio_sampling_rate_enum_to_value(linein_sample_rate);
#if defined (FIXED_SAMPLING_RATE_TO_48KHZ)
    open_param->stream_out_param.afe.sampling_rate   = HAL_AUDIO_FIXED_AFE_48K_SAMPLE_RATE;
#elif defined (AIR_FIXED_DL_SAMPLING_RATE_TO_96KHZ)
    open_param->stream_out_param.afe.sampling_rate   = HAL_AUDIO_FIXED_AFE_96K_SAMPLE_RATE;
#else
    open_param->stream_out_param.afe.sampling_rate   = hal_audio_sampling_rate_enum_to_value(linein_sample_rate);
#endif
    open_param->stream_in_param.afe.sampling_rate = open_param->stream_out_param.afe.sampling_rate;
    open_param->stream_out_param.afe.hw_gain = true;
    if (open_param->stream_in_param.afe.audio_device & HAL_AUDIO_DEVICE_I2S_MASTER) {
        if (open_param->stream_in_param.afe.audio_interface & HAL_AUDIO_INTERFACE_1) {
            open_param->stream_in_param.afe.i2s_master_sampling_rate[0] = open_param->stream_in_param.afe.sampling_rate;
        } else if (open_param->stream_in_param.afe.audio_interface & HAL_AUDIO_INTERFACE_2) {
            open_param->stream_in_param.afe.i2s_master_sampling_rate[1] = open_param->stream_in_param.afe.sampling_rate;
        } else if (open_param->stream_in_param.afe.audio_interface & HAL_AUDIO_INTERFACE_3) {
            open_param->stream_in_param.afe.i2s_master_sampling_rate[2] = open_param->stream_in_param.afe.sampling_rate;
        } else if (open_param->stream_in_param.afe.audio_interface & HAL_AUDIO_INTERFACE_4) {
            open_param->stream_in_param.afe.i2s_master_sampling_rate[3] = open_param->stream_in_param.afe.sampling_rate;
        }
    }
    if (open_param->stream_out_param.afe.audio_device & HAL_AUDIO_DEVICE_I2S_MASTER) {
        open_param->stream_out_param.afe.misc_parms      = I2S_CLK_SOURCE_DCXO;
        if (linein_sample_rate > HAL_AUDIO_SAMPLING_RATE_48KHZ) {
            open_param->stream_out_param.afe.misc_parms  = I2S_CLK_SOURCE_APLL;
        }
        if (open_param->stream_out_param.afe.audio_interface & HAL_AUDIO_INTERFACE_1) {
            open_param->stream_out_param.afe.i2s_master_sampling_rate[0] = open_param->stream_out_param.afe.sampling_rate;
        } else if (open_param->stream_out_param.afe.audio_interface & HAL_AUDIO_INTERFACE_2) {
            open_param->stream_out_param.afe.i2s_master_sampling_rate[1] = open_param->stream_out_param.afe.sampling_rate;
        } else if (open_param->stream_out_param.afe.audio_interface & HAL_AUDIO_INTERFACE_3) {
            open_param->stream_out_param.afe.i2s_master_sampling_rate[2] = open_param->stream_out_param.afe.sampling_rate;
        } else if (open_param->stream_out_param.afe.audio_interface & HAL_AUDIO_INTERFACE_4) {
            open_param->stream_out_param.afe.i2s_master_sampling_rate[3] = open_param->stream_out_param.afe.sampling_rate;
        }
    } else {
        open_param->stream_out_param.afe.misc_parms      = DOWNLINK_PERFORMANCE_NORMAL;
    }

    open_param->stream_out_param.afe.performance = dac_performance_HQA;

#if 0
    if ((in_audio_device & HAL_AUDIO_DEVICE_I2S_MASTER) || (out_audio_device & HAL_AUDIO_DEVICE_I2S_MASTER)) {
        if (open_param->stream_in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_1) {
            hal_gpio_init(2);
            hal_pinmux_set_function(2, 3);
            hal_gpio_init(3);
            hal_pinmux_set_function(3, 3);
            hal_gpio_init(4);
            hal_pinmux_set_function(4, 3);
            hal_gpio_init(6);
            hal_pinmux_set_function(6, 3);
            hal_gpio_init(5);
            hal_pinmux_set_function(5, 3); //O:I2S_MST0_MCLK
            //hal_audio_mclk_enable(true, AFE_MCLK_PIN_FROM_I2S0, AFE_APLL2, 0);//enable mclk
            LINEIN_PLAYBACK_LOG_I("I2S0 GPIO Set done\r\n", 0);
        } else if (open_param->stream_in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_2) {
            hal_gpio_init(16);
            hal_pinmux_set_function(16, 3);
            hal_gpio_init(26);
            hal_pinmux_set_function(26, 3);
            hal_gpio_init(17);
            hal_pinmux_set_function(17, 3);
            hal_gpio_init(18);
            hal_pinmux_set_function(18, 3);
            hal_gpio_init(15);
            hal_pinmux_set_function(15, 3); //O:I2S_MST1_MCLK
            //hal_audio_mclk_enable(true, AFE_MCLK_PIN_FROM_I2S1, AFE_APLL2, 0);//enable mclk
            LINEIN_PLAYBACK_LOG_I("I2S1 GPIO Set done\r\n", 0);
        } else if (open_param->stream_in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_3) {
            hal_gpio_init(29);
            hal_pinmux_set_function(29, 1);
            hal_gpio_init(32);
            hal_pinmux_set_function(32, 1);
            hal_gpio_init(33);
            hal_pinmux_set_function(33, 1);
            hal_gpio_init(37);
            hal_pinmux_set_function(37, 1);
            hal_gpio_init(31);
            hal_pinmux_set_function(31, 1); //O:I2S_MST2_MCLK
            //hal_audio_mclk_enable(true, AFE_MCLK_PIN_FROM_I2S2, AFE_APLL2, 0);//enable mclk
            LINEIN_PLAYBACK_LOG_I("I2S2 GPIO Set done\r\n", 0);
        } else if (open_param->stream_in_param.afe.audio_interface == HAL_AUDIO_INTERFACE_4) {
            hal_gpio_init(38);
            hal_pinmux_set_function(38, 1);
            hal_gpio_init(39);
            hal_pinmux_set_function(39, 1);
            hal_gpio_init(40);
            hal_pinmux_set_function(40, 1);
            hal_gpio_init(43);
            hal_pinmux_set_function(43, 1);
            hal_gpio_init(41);
            hal_pinmux_set_function(41, 1); //O:I2S_MST3_MCLK
            //hal_audio_mclk_enable(true, AFE_MCLK_PIN_FROM_I2S3, AFE_APLL2, 0);//enable mclk
            LINEIN_PLAYBACK_LOG_I("I2S3 GPIO Set done\r\n", 0);
        }
    }

    if (in_audio_device & HAL_AUDIO_DEVICE_DIGITAL_MIC_DUAL) {
        if ((uint32_t)adc_mode_HQA == (uint32_t)HAL_AUDIO_DMIC_GPIO_DMIC0) {
            //2822
            //GPIO2 AuxFunc.3 DMIC0_CLK
            //GPIO3 AuxFunc.3 DMIC0_DAT
            hal_gpio_init(2);
            hal_pinmux_set_function(2, 3);
            hal_gpio_init(3);
            hal_pinmux_set_function(3, 3);
            LINEIN_PLAYBACK_LOG_I("DMIC0 GPIO Set done dmic sel %d\r\n", 1, adc_mode_HQA);
        } else if ((uint32_t)adc_mode_HQA == (uint32_t)HAL_AUDIO_DMIC_GPIO_DMIC1) {
            //2822
            //GPIO4 AuxFunc.3 DMIC0_CLK
            //GPIO5 AuxFunc.3 DMIC0_DAT
            hal_gpio_init(4);
            hal_pinmux_set_function(4, 3);
            hal_gpio_init(5);
            hal_pinmux_set_function(5, 3);
            LINEIN_PLAYBACK_LOG_I("DMIC1 GPIO Set done dmic sel %d\r\n", 1, adc_mode_HQA);
        }
    }
#endif

#if defined(MTK_EXTERNAL_DSP_NEED_SUPPORT)
    ami_set_afe_param(STREAM_OUT, linein_sample_rate, true);
#endif
    p_param_share = hal_audio_dsp_controller_put_paramter(open_param, sizeof(mcu2dsp_open_param_t), AUDIO_MESSAGE_TYPE_LINEIN);
    ami_hal_audio_status_set_running_flag(AUDIO_SCENARIO_TYPE_LINE_IN, open_param, true);
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_TRULY_LINEIN_PLAYBACK_OPEN, 0, (uint32_t)p_param_share, true);
    vPortFree(open_param);

    linein_status = LINEIN_STATE_HQA_PLAY;
    return LINEIN_EXECUTION_HQA_SUCCESS;
}

linein_result_hqa_t audio_pure_linein_playback_close_HQA()
{
    log_hal_msgid_info("enter pure_linein_playback_close\n", 0);
    if (linein_status != LINEIN_STATE_HQA_PLAY) {
        log_hal_msgid_info("cannot close because state(%d)\n", 1, linein_status);
        return LINEIN_EXECUTION_HQA_FAIL;
    }
    hal_audio_dsp_controller_send_message(MSG_MCU2DSP_TRULY_LINEIN_PLAYBACK_CLOSE, 0, 0, true);
    linein_status = LINEIN_STATE_HQA_IDLE;
    ami_hal_audio_status_set_running_flag(AUDIO_SCENARIO_TYPE_LINE_IN, NULL, false);
    return LINEIN_EXECUTION_HQA_SUCCESS;
}
#endif

#endif /* defined(HAL_AUDIO_MODULE_ENABLED) */
