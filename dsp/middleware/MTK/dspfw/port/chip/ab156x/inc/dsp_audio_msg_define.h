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

#ifndef _DSP_AUDIOMSGDEFINE_H_
#define _DSP_AUDIOMSGDEFINE_H_

//--------------------------------------------
// CM4 to DSP message base address
//--------------------------------------------
#define MSG_MCU2DSP_COMMON_BASE         0x0000
#define MSG_MCU2DSP_BT_AUDIO_UL_BASE    0x0100  //ToDo
#define MSG_MCU2DSP_BT_AUDIO_DL_BASE    0x0200
#define MSG_MCU2DSP_BT_VOICE_UL_BASE    0x0300
#define MSG_MCU2DSP_BT_VOICE_DL_BASE    0x0400
#define MSG_MCU2DSP_PLAYBACK_BASE       0x0500
#define MSG_MCU2DSP_RECORD_BASE         0x0600  //ToDo
#define MSG_MCU2DSP_PROMPT_BASE         0x0700
#define MSG_MCU2DSP_PROMPT_DUMMY_SOURCE_BASE 0x0780
#define MSG_MCU2DSP_LINEIN_PLAYBACK_BASE    0x0800  //ToDo
#ifdef AIR_BT_CODEC_BLE_ENABLED
#define MSG_MCU2DSP_BLE_AUDIO_UL_BASE       0x0900
#define MSG_MCU2DSP_BLE_AUDIO_DL_BASE       0x0A00
#endif
#define MSG_MCU2DSP_AUDIO_BASE          0x0B00
#define MSG_MCU2DSP_AUDIO_TRANSMITTER_BASE  0x0C00
#define MSG_DSP_NULL_REPORT             0xffff
#define MSG_MCU2DSP_INIT_BASE   MSG_MCU2DSP_COMMON_BASE

//--------------------------------------------
// DSP to CM4 message base address (ACK)
//--------------------------------------------
#define MSG_DSP2MCU_TEST0_BASE         0x0000
#define MSG_DSP2MCU_TEST1_BASE         0x0C00

//--------------------------------------------
// Detailed message from CM4 to DSP
//--------------------------------------------
typedef enum {
    // MSG_MCU2DSP_COMMON_BASE           0x0000
    MSG_MCU2DSP_COMMON_SET_MEMORY = MSG_MCU2DSP_INIT_BASE,
    MSG_MCU2DSP_COMMON_SET_SYSRAM,
    MSG_MCU2DSP_COMMON_STREAM_DEINIT,
    MSG_MCU2DSP_COMMON_UPDATE_AUDIO_NVDM_STATUS_TEMP,

    MSG_MCU2DSP_COMMON_SET_INPUT_DEVICE = MSG_MCU2DSP_INIT_BASE + 0x10,
    MSG_MCU2DSP_COMMON_MUTE_INPUT_DEVICE,
    MSG_MCU2DSP_COMMON_SET_INPUT_DEVICE_VOLUME,
    MSG_MCU2DSP_COMMON_SET_INPUT_DEVICE_CHANNEL,

    MSG_MCU2DSP_COMMON_SET_OUTPUT_DEVICE = MSG_MCU2DSP_INIT_BASE + 0x20,
    MSG_MCU2DSP_COMMON_MUTE_OUTPUT_DEVICE,
    MSG_MCU2DSP_COMMON_SET_OUTPUT_DEVICE_VOLUME,
    MSG_MCU2DSP_COMMON_SET_OUTPUT_DEVICE_CHANNEL,
    MSG_MCU2DSP_COMMON_SET_OUTPUT_VOLUME_PARAMETERS,
    MSG_MCU2DSP_COMMON_SW_GAIN_EN,
    MSG_MCU2DSP_COMMON_SET_DRIVER_PARAM,
    MSG_MCU2DSP_COMMON_POWER_OFF_DAC_IMMEDIATELY,

    MSG_MCU2DSP_COMMON_SPEECH_SET_MODE = MSG_MCU2DSP_INIT_BASE + 0x30,
    MSG_MCU2DSP_COMMON_SPEECH_SET_ENHANCEMENT_PARAMTER,
    MSG_MCU2DSP_COMMON_SPEECH_ENHANCEMENT_START,
    MSG_MCU2DSP_COMMON_SPEECH_ENHANCEMENT_STOP,

    MSG_MCU2DSP_COMMON_SIDETONE_START = MSG_MCU2DSP_INIT_BASE + 0x40,
    MSG_MCU2DSP_COMMON_SIDETONE_STOP,
    MSG_MCU2DSP_COMMON_SIDETONE_SET_VOLUME,
    MSG_MCU2DSP_COMMON_ANC_START,
    MSG_MCU2DSP_COMMON_ANC_STOP,
    MSG_MCU2DSP_COMMON_ANC_SET_VOLUME,
    MSG_MCU2DSP_COMMON_ANC_SET_PARAM,
    MSG_MCU2DSP_COMMON_ANC_START_DONE_TEMP,
    MSG_MCU2DSP_COMMON_DC_COMPENSATION_START,
    MSG_MCU2DSP_COMMON_DC_COMPENSATION_STOP,
    MSG_MCU2DSP_COMMON_CHANGE_DSP_SETTING,
    MSG_MCU2DSP_COMMON_CHANGE_DSP_CHANEL,
    MSG_MCU2DSP_COMMON_DUMMY_DSP_SHUTDOWN,
    MSG_MCU2DSP_COMMON_ALC_SWITCH,
    MSG_MCU2DSP_COMMON_AUDIO_LOOPBACK_TEST,

    MSG_MCU2DSP_COMMON_REQ_GET_REALTIME_REF_GAIN= MSG_MCU2DSP_COMMON_BASE + 0x50,
    MSG_MCU2DSP_COMMON_AEC_NR_SET_PARAM,
    MSG_MCU2DSP_COMMON_PEQ_SET_PARAM,
    MSG_MCU2DSP_COMMON_DEQ_SET_PARAM,
    MSG_MCU2DSP_COMMON_SET_ALGORITHM_PARAM,
    MSG_MCU2DSP_COMMON_AUDIO_ANC_ADAPTIVE_GET,
    MSG_MCU2DSP_COMMON_AUDIO_ANC_ADAPTIVE_SET,
    MSG_MCU2DSP_COMMON_REQ_GET_REALTIME_LIB_VERSION,

    MSG_MCU2DSP_COMMON_AUDIO_DUMP_MASK= MSG_MCU2DSP_COMMON_BASE + 0x70,
    MSG_MCU2DSP_COMMON_AIRDUMP_EN,
    MSG_MCU2DSP_COMMON_AEC_NR_EN,
#ifdef ENABLE_HWSRC_CLKSKEW
    MSG_MCU2DSP_COMMON_CLKSKEW_MODE_SEL,
#endif
#ifdef MTK_SLT_AUDIO_HW
    MSG_MCU2DSP_COMMON_AUDIO_SLT,
#endif
    MSG_MCU2DSP_COMMON_AUDIO_ANC_SWITCH_ACK,
    MSG_MCU2DSP_COMMON_AUDIO_ANC_ADAPTIVE_ACK,

    // For Audio Sync
    MSG_MCU2DSP_AUDIO_SYNC_REQUEST = MSG_MCU2DSP_COMMON_BASE + 0x80,
    // MSG_MCU2DSP_BT_AUDIO_UL_BASE    0x0100

    // MSG_MCU2DSP_BT_AUDIO_DL_BASE    0x0200
    MSG_MCU2DSP_BT_AUDIO_DL_OPEN = MSG_MCU2DSP_BT_AUDIO_DL_BASE,
    MSG_MCU2DSP_BT_AUDIO_DL_CLOSE,
    MSG_MCU2DSP_BT_AUDIO_DL_START,
    MSG_MCU2DSP_BT_AUDIO_DL_STOP,
    MSG_MCU2DSP_BT_AUDIO_DL_CONFIG,
    MSG_MCU2DSP_BT_AUDIO_DL_SET_VOLUME,
    MSG_MCU2DSP_BT_AUDIO_DL_ERROR_TEMP,
    MSG_MCU2DSP_BT_AUDIO_DL_TIME_REPORT_TEMP,
    MSG_MCU2DSP_BT_AUDIO_DL_SUSPEND,
    MSG_MCU2DSP_BT_AUDIO_DL_RESUME,
    MSG_MCU2DSP_BT_AUDIO_DL_LTCS_DATA_REPORT_TEMP,
    MSG_MCU2DSP_BT_AUDIO_DL_REINIT_REQUEST_TEMP,
    MSG_MCU2DSP_BT_AUDIO_DL_RST_LOSTNUM_REPORT,
    MSG_MCU2DSP_BT_AUDIO_PLC_CONTROL_TEMP,
    MSG_MCU2DSP_BT_AUDIO_DL_PLAY_EN_FROM_BTCON,
    MSG_MCU2DSP_HWGAIN_SET_FADE_TIME_GAIN,
    MSG_MCU2DSP_BT_AUDIO_CLK_SKEW_DEBUG_CONTROL_TEMP,

    // MSG_MCU2DSP_BT_VOICE_UL_BASE    0x0300
    MSG_MCU2DSP_BT_VOICE_UL_OPEN = MSG_MCU2DSP_BT_VOICE_UL_BASE,
    MSG_MCU2DSP_BT_VOICE_UL_CLOSE,
    MSG_MCU2DSP_BT_VOICE_UL_START,
    MSG_MCU2DSP_BT_VOICE_UL_STOP,
    MSG_MCU2DSP_BT_VOICE_UL_CONFIG,
    MSG_MCU2DSP_BT_VOICE_UL_SET_VOLUME,
    MSG_MCU2DSP_BT_VOICE_UL_ERROR_TEMP,
    MSG_MCU2DSP_BT_VOICE_UL_PLAY_EN,
    MSG_MCU2DSP_BT_VOICE_UL_SUSPEND,
    MSG_MCU2DSP_BT_VOICE_UL_RESUME,

    // MSG_MCU2DSP_BT_VOICE_DL_BASE    0x0400
    MSG_MCU2DSP_BT_VOICE_DL_OPEN = MSG_MCU2DSP_BT_VOICE_DL_BASE,
    MSG_MCU2DSP_BT_VOICE_DL_CLOSE,
    MSG_MCU2DSP_BT_VOICE_DL_START,
    MSG_MCU2DSP_BT_VOICE_DL_STOP,
    MSG_MCU2DSP_BT_VOICE_DL_CONFIG,
    MSG_MCU2DSP_BT_VOICE_DL_SET_VOLUME,
    MSG_MCU2DSP_BT_VOICE_DL_GET_REF_GAIN,
    MSG_MCU2DSP_BT_VOICE_DL_SUSPEND,
    MSG_MCU2DSP_BT_VOICE_DL_RESUME,
    MSG_MCU2DSP_BT_VOICE_DL_AVC_PARA_SEND,

    // MSG_MCU2DSP_PLAYBACK_BASE       0x0500
    MSG_MCU2DSP_PLAYBACK_OPEN = MSG_MCU2DSP_PLAYBACK_BASE,
    MSG_MCU2DSP_PLAYBACK_CLOSE,
    MSG_MCU2DSP_PLAYBACK_START,
    MSG_MCU2DSP_PLAYBACK_STOP,
    MSG_MCU2DSP_PLAYBACK_CONFIG,
    MSG_MCU2DSP_PLAYBACK_SET_VOLUME,
    MSG_MCU2DSP_PLAYBACK_TEMP2,
    MSG_MCU2DSP_PLAYBACK_DATA_REQUEST_ACK,
    MSG_MCU2DSP_PLAYBACK_SUSPEND,
    MSG_MCU2DSP_PLAYBACK_RESUME,

    // MSG_MCU2DSP_RECORD_BASE         0x0600
    MSG_MCU2DSP_RECORD_OPEN = MSG_MCU2DSP_RECORD_BASE,
    MSG_MCU2DSP_RECORD_CLOSE,
    MSG_MCU2DSP_RECORD_START,
    MSG_MCU2DSP_RECORD_STOP,
    MSG_MCU2DSP_RECORD_CONFIG,
    MSG_MCU2DSP_RECORD_SET_VOLUME,
    MSG_MCU2DSP_RECORD_DATA_NOTIFY_ACK,
    MSG_MCU2DSP_RECORD_ERROR_TEMP,
    MSG_MCU2DSP_RECORD_SUSPEND,
    MSG_MCU2DSP_RECORD_RESUME,
    MSG_MCU2DSP_RECORD_LC_SET_PARAM = MSG_MCU2DSP_RECORD_BASE + 0x20,

    // MSG_MCU2DSP_PROMPT_BASE         0x0700
    MSG_MCU2DSP_PROMPT_OPEN = MSG_MCU2DSP_PROMPT_BASE,
    MSG_MCU2DSP_PROMPT_CLOSE,
    MSG_MCU2DSP_PROMPT_START,
    MSG_MCU2DSP_PROMPT_STOP,
    MSG_MCU2DSP_PROMPT_CONFIG,
    MSG_MCU2DSP_PROMPT_SET_VOLUME,
    MSG_MCU2DSP_PROMPT_TEMP2,
    MSG_MCU2DSP_PROMPT_DATA_REQUEST_ACK,
    MSG_MCU2DSP_PROMPT_AWS_SYNC_TRIGGER,
    MSG_MCU2DSP_PROMPT_DUMMY_SOURCE_OPEN = MSG_MCU2DSP_PROMPT_DUMMY_SOURCE_BASE,
    MSG_MCU2DSP_PROMPT_DUMMY_SOURCE_CLOSE,
    MSG_MCU2DSP_PROMPT_DUMMY_SOURCE_START,
    MSG_MCU2DSP_PROMPT_DUMMY_SOURCE_STOP,
    MSG_MCU2DSP_PROMPT_DUMMY_SOURCE_CHANGE_FEATURE,

    // MSG_MCU2DSP_LINEIN_PLAYBACK_BASE         0x0800
    MSG_MCU2DSP_LINEIN_PLAYBACK_OPEN = MSG_MCU2DSP_LINEIN_PLAYBACK_BASE,
    MSG_MCU2DSP_LINEIN_PLAYBACK_CLOSE,
    MSG_MCU2DSP_LINEIN_PLAYBACK_START,
    MSG_MCU2DSP_LINEIN_PLAYBACK_STOP,
    MSG_MCU2DSP_LINEIN_PLAYBACK_SUSPEND,
    MSG_MCU2DSP_LINEIN_PLAYBACK_RESUME,
    MSG_MCU2DSP_TRULY_LINEIN_PLAYBACK_OPEN,
    MSG_MCU2DSP_TRULY_LINEIN_PLAYBACK_CLOSE,

#ifdef AIR_BT_CODEC_BLE_ENABLED
    // MSG_MCU2DSP_BLE_AUDIO_UL_BASE    0x0900
    MSG_MCU2DSP_BLE_AUDIO_UL_OPEN = MSG_MCU2DSP_BLE_AUDIO_UL_BASE,
    MSG_MCU2DSP_BLE_AUDIO_UL_CLOSE,
    MSG_MCU2DSP_BLE_AUDIO_UL_START,
    MSG_MCU2DSP_BLE_AUDIO_UL_STOP,
    MSG_MCU2DSP_BLE_AUDIO_UL_CONFIG,
    MSG_MCU2DSP_BLE_AUDIO_UL_SET_VOLUME,
    MSG_MCU2DSP_BLE_AUDIO_UL_ERROR_TEMP,
    MSG_MCU2DSP_BLE_AUDIO_UL_PLAY_EN,
    MSG_MCU2DSP_BLE_AUDIO_UL_SUSPEND,
    MSG_MCU2DSP_BLE_AUDIO_UL_RESUME,
    MSG_MCU2DSP_BLE_AUDIO_UL_BUFFER_INFO,
    MSG_MCU2DSP_BLE_AUDIO_UL_PLAYBACK_DATA_INFO,

    // MSG_MCU2DSP_BLE_AUDIO_DL_BASE    0x0A00
    MSG_MCU2DSP_BLE_AUDIO_DL_OPEN = MSG_MCU2DSP_BLE_AUDIO_DL_BASE,
    MSG_MCU2DSP_BLE_AUDIO_DL_CLOSE,
    MSG_MCU2DSP_BLE_AUDIO_DL_START,
    MSG_MCU2DSP_BLE_AUDIO_DL_STOP,
    MSG_MCU2DSP_BLE_AUDIO_DL_CONFIG,
    MSG_MCU2DSP_BLE_AUDIO_DL_SET_VOLUME,
    MSG_MCU2DSP_BLE_AUDIO_DL_ERROR_TEMP,
    MSG_MCU2DSP_BLE_AUDIO_DL_SUSPEND,
    MSG_MCU2DSP_BLE_AUDIO_DL_RESUME,
    MSG_MCU2DSP_BLE_AUDIO_DL_BUFFER_INFO,
    MSG_MCU2DSP_BLE_AUDIO_INIT_PLAY_INFO,
#endif

    //MSG_MCU2DSP_AUDIO_BASE
    MSG_MCU2DSP_AUDIO_AMP = MSG_MCU2DSP_AUDIO_BASE,
    MSG_MCU2DSP_AUDIO_AMP_FORCE_CLOSE,

    // MSG_MCU2DSP_AUDIO_TRANSMIITER_BASE    0x0C00
    MSG_MCU2DSP_AUDIO_TRANSMITTER_OPEN = MSG_MCU2DSP_AUDIO_TRANSMITTER_BASE,
    MSG_MCU2DSP_AUDIO_TRANSMITTER_CLOSE,
    MSG_MCU2DSP_AUDIO_TRANSMITTER_START,
    MSG_MCU2DSP_AUDIO_TRANSMITTER_STOP,
    MSG_MCU2DSP_AUDIO_TRANSMITTER_CONFIG,
    MSG_MCU2DSP_AUDIO_TRANSMITTER_SUSPEND,
    MSG_MCU2DSP_AUDIO_TRANSMITTER_RESUME,
	MSG_MCU2DSP_GAME_HEADSET_UL_IRQ_EN,

#ifdef MTK_SENSOR_SOURCE_ENABLE
    MSG_MCU2DSP_GSENSOR_DETECT_READ_RG,
    MSG_MCU2DSP_GSENSOR_DETECT_WRITE_RG,
#endif

} MCU2DSP_AUDIO_MSG;

//--------------------------------------------
// Detailed message from N9 to DSP
//--------------------------------------------
typedef enum {
    MSG_N92DSP_CLOCK_LEADS  = 0x3001,
    MSG_N92DSP_CLOCK_LAGS,
    MSG_N92DSP_DL_IRQ,
    MSG_N92DSP_UL_IRQ,
    MSG_N92DSP_MIC_IRQ,
} N92DSP_AUDIO_MSG;

//--------------------------------------------
// Detailed message from DSP to CM4
//--------------------------------------------
typedef enum {
    // MSG_MCU2DSP_COMMON_BASE           0x0000
    MSG_DSP2MCU_COMMON_SET_MEMORY_ACK = 0x0000,
    MSG_DSP2MCU_COMMON_SET_SYSRAM_ACK,
    MSG_DSP2MCU_COMMON_STREAM_DEINIT_ACK,
    MSG_DSP2MCU_COMMON_UPDATE_AUDIO_NVDM_STATUS,

    MSG_DSP2MCU_COMMON_ANC_START_DONE = 0x0047,
    MSG_DSP2MCU_COMMON_AUDIO_ANC_SWITCH = MSG_MCU2DSP_COMMON_AUDIO_ANC_SWITCH_ACK,
    MSG_DSP2MCU_COMMON_AUDIO_ANC_ADAPTIVE = MSG_MCU2DSP_COMMON_AUDIO_ANC_ADAPTIVE_ACK,
    MSG_DSP2MCU_COMMON_AUDIO_LOOPBACK_TEST_ACK = 0x004E,

    // For Audio Sync
    MSG_DSP2MCU_AUDIO_SYNC_DONE = 0x0081,

    // MSG_MCU2DSP_BT_AUDIO_DL_BASE    0x0200
    MSG_DSP2MCU_BT_AUDIO_DL_OPEN_ACK = 0x0200,
    MSG_DSP2MCU_BT_AUDIO_DL_CLOSE_ACK,
    MSG_DSP2MCU_BT_AUDIO_DL_START_ACK,
    MSG_DSP2MCU_BT_AUDIO_DL_STOP_ACK,
    MSG_DSP2MCU_BT_AUDIO_DL_CONFIG_ACK,
    MSG_DSP2MCU_BT_AUDIO_DL_SET_VOLUME_ACK,
    MSG_DSP2MCU_BT_AUDIO_DL_ERROR_TEMP_ACK,
    MSG_DSP2MCU_BT_AUDIO_DL_TIME_REPORT,
    MSG_DSP2MCU_BT_AUDIO_DL_SUSPEND_ACK,
    MSG_DSP2MCU_BT_AUDIO_DL_RESUME_ACK,
    MSG_DSP2MCU_BT_AUDIO_DL_LTCS_DATA_REPORT,
    MSG_DSP2MCU_BT_AUDIO_DL_REINIT_REQUEST,
    MSG_DSP2MCU_BT_AUDIO_DL_ALC_REQUEST,

    // MSG_DSP2MCU_BT_VOICE_UL_BASE    0x0300
    MSG_DSP2MCU_BT_VOICE_UL_OPEN_ACK = 0x0300,
    MSG_DSP2MCU_BT_VOICE_UL_CLOSE_ACK,
    MSG_DSP2MCU_BT_VOICE_UL_START_ACK,
    MSG_DSP2MCU_BT_VOICE_UL_STOP_ACK,
    MSG_DSP2MCU_BT_VOICE_UL_CONFIG_ACK,
    MSG_DSP2MCU_BT_VOICE_UL_SET_VOLUME_ACK,
    MSG_DSP2MCU_BT_VOICE_UL_ERROR_TEMP,
    MSG_DSP2MCU_BT_VOICE_UL_PLAY_EN_ACK,
    MSG_DSP2MCU_BT_VOICE_UL_SUSPEND_ACK,
    MSG_DSP2MCU_BT_VOICE_UL_RESUME_ACK,
    MSG_DSP2MCU_AVC_PARA_SEND,


    // MSG_DSP2MCU_BT_VOICE_DL_BASE    0x0400
    MSG_DSP2MCU_BT_VOICE_DL_OPEN_ACK = 0x0400,
    MSG_DSP2MCU_BT_VOICE_DL_CLOSE_ACK,
    MSG_DSP2MCU_BT_VOICE_DL_START_ACK,
    MSG_DSP2MCU_BT_VOICE_DL_STOP_ACK,
    MSG_DSP2MCU_BT_VOICE_DL_CONFIG_ACK,
    MSG_DSP2MCU_BT_VOICE_DL_SET_VOLUME_ACK,
    MSG_DSP2MCU_BT_VOICE_DL_ERROR_TEMP,
    MSG_DSP2MCU_BT_VOICE_DL_SUSPEND_ACK,
    MSG_DSP2MCU_BT_VOICE_DL_RESUME_ACK,


    MSG_DSP2MCU_PLAYBACK_OPEN_ACK = 0x0500,
    MSG_DSP2MCU_PLAYBACK_CLOSE_ACK,
    MSG_DSP2MCU_PLAYBACK_START_ACK,
    MSG_DSP2MCU_PLAYBACK_STOP_ACK,
    MSG_DSP2MCU_PLAYBACK_CONFIG_ACK,
    MSG_DSP2MCU_PLAYBACK_SET_VOLUME_ACK,
    MSG_DSP2MCU_PLAYBACK_TEMP,
    MSG_DSP2MCU_PLAYBACK_DATA_REQUEST,

    // MSG_MCU2DSP_RECORD_BASE         0x0600
    MSG_DSP2MCU_RECORD_OPEN_ACK = 0x0600,
    MSG_DSP2MCU_RECORD_CLOSE_ACK,
    MSG_DSP2MCU_RECORD_START_ACK,
    MSG_DSP2MCU_RECORD_STOP_ACK,
    MSG_DSP2MCU_RECORD_CONFIG_ACK,
    MSG_DSP2MCU_RECORD_SET_VOLUME_ACK,
    MSG_DSP2MCU_RECORD_DATA_NOTIFY,
    MSG_DSP2MCU_RECORD_ERROR_TEMP_ACK,
    MSG_DSP2MCU_RECORD_SUSPEND_ACK,
    MSG_DSP2MCU_RECORD_RESUME_ACK,
    MSG_DSP2MCU_RECORD_WWE_VERSION,
    MSG_DSP2MCU_RECORD_WWD_NOTIFY,
    MSG_DSP2MCU_RECORD_DATA_ABORT_NOTIFY,
    MSG_DSP2MCU_RECORD_LC_SET_PARAM_ACK = 0x0600 + 0x20,
    MSG_DSP2MCU_RECORD_LC_WZ_REPORT,

    // MSG_DSP2MCU_PROMPT_BASE         0x8700
    MSG_DSP2MCU_PROMPT_OPEN_ACK =  0x0700,
    MSG_DSP2MCU_PROMPT_CLOSE_ACK,
    MSG_DSP2MCU_PROMPT_START_ACK,
    MSG_DSP2MCU_PROMPT_STOP_ACK,
    MSG_DSP2MCU_PROMPT_CONFIG_ACK,
    MSG_DSP2MCU_PROMPT_SET_VOLUME_ACK,
    MSG_DSP2MCU_PROMPT_TEMP,
    MSG_DSP2MCU_PROMPT_DATA_REQUEST,
    MSG_DSP2MCU_PROMPT_DUMMY_SOURCE_OPEN_ACK = 0x0780,
    MSG_DSP2MCU_PROMPT_DUMMY_SOURCE_CLOSE_ACK,
    MSG_DSP2MCU_PROMPT_DUMMY_SOURCE_START_ACK,
    MSG_DSP2MCU_PROMPT_DUMMY_SOURCE_STOP_ACK,

    // MSG_DSP2MCU_LINEIN_PLAYBACK_BASE         0x8800
    MSG_DSP2MCU_LINEIN_PLAYBACK_OPEN_ACK = 0x0800,
    MSG_DSP2MCU_LINEIN_PLAYBACK_CLOSE_ACK,
    MSG_DSP2MCU_LINEIN_PLAYBACK_START_ACK,
    MSG_DSP2MCU_LINEIN_PLAYBACK_STOP_ACK,
    MSG_DSP2MCU_LINEIN_PLAYBACK_SUSPEND_ACK,
    MSG_DSP2MCU_LINEIN_PLAYBACK_RESUME_ACK,
    MSG_DSP2MCU_TRULY_LINEIN_PLAYBACK_OPEN_ACK,
    MSG_DSP2MCU_TRULY_LINEIN_PLAYBACK_CLOSE_ACK,

    // MSG_MCU2DSP_AUDIO_TRANSMITTER_BASE         0x8C00
    MSG_DSP2MCU_AUDIO_TRANSMITTER_OPEN_ACK = 0x0C00,
    MSG_DSP2MCU_AUDIO_TRANSMITTER_CLOSE_ACK,
    MSG_DSP2MCU_AUDIO_TRANSMITTER_START_ACK,
    MSG_DSP2MCU_AUDIO_TRANSMITTER_STOP_ACK,
    MSG_DSP2MCU_AUDIO_TRANSMITTER_CONFIG_ACK,
    MSG_DSP2MCU_AUDIO_TRANSMITTER_SUSPEND_ACK,
    MSG_DSP2MCU_AUDIO_TRANSMITTER_RESUME_ACK,
    MSG_DSP2MCU_AUDIO_TRANSMITTER_DATA_NOTIFY,
    MSG_DSP2MCU_AUDIO_TRANSMITTER_DATA_DIRECT,

    // MSG_DSP2MCU_AUDIO_BASE         0x8B00
    MSG_DSP2MCU_AUDIO_AMP           = 0x0B00,
    MSG_DSP2MCU_BT_AUDIO_DL_SILENCE_DETECTION_FEEDBACK,
} DSP2MCU_AUDIO_MSG;

typedef enum {
    MSG_DSP2LOCAL_AUDIO_PROCESS     = 0x0F00,
} DSP2LOCAL_AUDIO_MSG;

typedef enum {
    MSG2_DSP2CN4_REINIT_BUF_ABNORMAL =  1,
    MSG2_DSP2CN4_REINIT_AFE_ABNORMAL =  2,
} DSP_REINIT_CAUSE;



typedef enum {
    AUDIO_TRANSMITTER_A2DP_SOURCE,
    AUDIO_TRANSMITTER_GSENSOR,
    AUDIO_TRANSMITTER_MULTI_MIC_STREAM,
    AUDIO_TRANSMITTER_GAMING_MODE,
    AUDIO_TRANSMITTER_ANC_MONITOR_STREAM,
    AUDIO_TRANSMITTER_TEST,
    AUDIO_TRANSMITTER_TDM,
    AUDIO_TRANSMITTER_WIRED_AUDIO,
    AUDIO_TRANSMITTER_ADVANCED_PASSTHROUGH,
    AUDIO_TRANSMITTER_BLE_AUDIO_DONGLE,
    AUDIO_TRANSMITTER_AUDIO_HW_LOOPBACK,
    AUDIO_TRANSMITTER_SCENARIO_TYPE_MAX
} audio_transmitter_scenario_t;

#ifdef MTK_MULTI_MIC_STREAM_ENABLE
typedef enum {
    AUDIO_TRANSMITTER_MULTI_MIC_STREAM_FUNCTION_A = 0,
    AUDIO_TRANSMITTER_MULTI_MIC_STREAM_FUNCTION_B,
    AUDIO_TRANSMITTER_MULTI_MIC_STREAM_FUNCTION_C,
    AUDIO_TRANSMITTER_MULTI_MIC_STREAM_FUNCTION_F,
    AUDIO_TRANSMITTER_MULTI_MIC_STREAM_SUB_ID_MAX
} audio_transmitter_scenario_sub_id_multimic_t;
#endif

#ifdef MTK_SENSOR_SOURCE_ENABLE
typedef enum {
    AUDIO_TRANSMITTER_GSENSOR_FUNCTION_D = 0,
    AUDIO_TRANSMITTER_GSENSOR_FUNCTION_F,
    AUDIO_TRANSMITTER_GSENSOR_FUNCTION_G,
    AUDIO_TRANSMITTER_GSENSOR_SUB_ID_MAX
} audio_transmitter_scenario_sub_id_gsensor_t;
#endif

typedef enum {
    AUDIO_TRANSMITTER_TEST_AUDIO_LOOPBACK = 0,
    AUDIO_TRANSMITTER_TEST_SUB_ID_MAX
} audio_transmitter_scenario_sub_id_test_t;

#if defined(MTK_GAMING_MODE_HEADSET) || defined(AIR_GAMING_MODE_DONGLE_ENABLE)
typedef enum {
    AUDIO_TRANSMITTER_GAMING_MODE_VOICE_HEADSET = 0,
    AUDIO_TRANSMITTER_GAMING_MODE_VOICE_DONGLE_USB_OUT,
    AUDIO_TRANSMITTER_GAMING_MODE_MUSIC_DONGLE_USB_IN_0,
    AUDIO_TRANSMITTER_GAMING_MODE_MUSIC_DONGLE_USB_IN_1,
    AUDIO_TRANSMITTER_GAMING_MODE_VOICE_DONGLE_LINE_OUT,
    AUDIO_TRANSMITTER_GAMING_MODE_MUSIC_DONGLE_LINE_IN,
    AUDIO_TRANSMITTER_GAMING_MODE_SUB_ID_MAX
} audio_transmitter_scenario_sub_id_gamingmode_t;
#endif

#if defined(AIR_WIRED_AUDIO_ENABLE)
typedef enum {
    AUDIO_TRANSMITTER_WIRED_AUDIO_USB_OUT = 0,
    AUDIO_TRANSMITTER_WIRED_AUDIO_USB_IN_0 = 1,
    AUDIO_TRANSMITTER_WIRED_AUDIO_USB_IN_1 = 2,
    AUDIO_TRANSMITTER_WIRED_AUDIO_LINE_OUT = 3,
    AUDIO_TRANSMITTER_WIRED_AUDIO_LINE_IN = 4,
    AUDIO_TRANSMITTER_WIRED_AUDIO_DUAL_CHIP_LINE_IN_MASTER = 5,//I2S2->VUL3->DL3->DAC
    AUDIO_TRANSMITTER_WIRED_AUDIO_DUAL_CHIP_LINE_IN_SLAVE = 6,//I2S0->VUL3->DL3->DAC
    AUDIO_TRANSMITTER_WIRED_AUDIO_DUAL_CHIP_LINE_OUT_MASTER = 7,//ADC->VUL1->DL4->I2S0
    AUDIO_TRANSMITTER_WIRED_AUDIO_SUB_ID_MAX
} audio_transmitter_scenario_sub_id_wiredaudio_t;
#endif

#if defined(AIR_ADVANCED_PASSTHROUGH_ENABLE)
typedef enum {
    AUDIO_TRANSMITTER_ADVANCED_PASSTHROUGH_HEARING_AID = 0,
    AUDIO_TRANSMITTER_ADVANCED_PASSTHROUGH_SUB_ID_MAX
} audio_transmitter_scenario_sub_id_advanced_passthrough_t;
#endif /* AIR_ADVANCED_PASSTHROUGH_ENABLE */

#if defined(AIR_BLE_AUDIO_DONGLE_ENABLE)
typedef enum {
    AUDIO_TRANSMITTER_BLE_AUDIO_DONGLE_VOICE_USB_OUT = 0,
    AUDIO_TRANSMITTER_BLE_AUDIO_DONGLE_MUSIC_USB_IN_0,
    AUDIO_TRANSMITTER_BLE_AUDIO_DONGLE_MUSIC_USB_IN_1,
    AUDIO_TRANSMITTER_BLE_AUDIO_DONGLE_VOICE_LINE_OUT,
    AUDIO_TRANSMITTER_BLE_AUDIO_DONGLE_MUSIC_LINE_IN,
    AUDIO_TRANSMITTER_BLE_AUDIO_DONGLE_SUB_ID_MAX
} audio_transmitter_scenario_sub_id_bleaudiodongle_t;
#endif /* AIR_BLE_AUDIO_DONGLE_ENABLE */

#ifdef  AIR_AUDIO_HW_LOOPBACK_ENABLE
typedef enum {
    AUDIO_TRANSMITTER_AUDIO_HW_LOOPBACK_I2S0_TO_DAC = 0,
    AUDIO_TRANSMITTER_AUDIO_HW_LOOPBACK_ADC_TO_I2S0,
    AUDIO_TRANSMITTER_AUDIO_HW_LOOPBACK_LINEIN_TO_I2S2,
    AUDIO_TRANSMITTER_AUDIO_HW_LOOPBACK_SUB_ID_MAX
} audio_transmitter_scenario_sub_id_audio_hw_loopback_t;
#endif /* AIR_AUDIO_HW_LOOPBACK_ENABLE */
typedef enum {
    AUDIO_ANC_CONTROL_EXTEND_RAMP_TYPE_WIND_NOISE = 0,               /**< The wind detect type to set anc extend ramp gain control.   */
    AUDIO_ANC_CONTROL_EXTEND_RAMP_TYPE_HOWLING_CONTROL,              /**< No use for now.   */
    AUDIO_ANC_CONTROL_EXTEND_RAMP_TYPE_USER_UNAWARE,                 /**< The user unaware type to set anc extend ramp gain control.   */
    AUDIO_ANC_CONTROL_EXTEND_RAMP_TYPE_ENVIRONMENT_DETECTION,        /**< The noise gate type to set anc extend ramp gain control.   */
    AUDIO_ANC_CONTROL_EXTEND_RAMP_TYPE_NUM,
    AUDIO_ANC_CONTROL_EXTEND_RAMP_TYPE_MAX          = 0xFF,
} audio_anc_control_extend_ramp_gain_type_t;


typedef enum {
    AUDIO_ANC_CONTROL_EXTEND_GAIN_NORMAL = 0,   // FF + FB
    AUDIO_ANC_CONTROL_EXTEND_GAIN_FF,           // FF only
    AUDIO_ANC_CONTROL_EXTEND_GAIN_FB,           // FB only
} audio_anc_control_extend_ramp_gain_mode_t;

typedef struct audio_extend_gain_control_s {
    uint8_t gain_type;      // enum: audio_anc_control_extend_ramp_gain_type_t
    uint8_t misc;           // misc parameters for different gain type
    int16_t gain[2];
} audio_extend_gain_control_t, *audio_extend_gain_control_ptr_t;

typedef enum {
    AUDIO_ADAPTIVE_ANC_TYPE_USER_UNAWARE = 0,    /**< The user unaware type to set status >**/
    AUDIO_ADAPTIVE_ANC_TYPE_NUM,
    AUDIO_ADAPTIVE_ANC_TYPE_MAX          = 0xFFFF,
} audio_adaptive_anc_type_t;

typedef enum {
    /* User Unaware */
    AUDIO_ANC_MONITOR_STREAM_CONTROL = 0,
    AUDIO_ANC_MONITOR_SET_USER_UNAWARE_STAT  = 1,
    AUDIO_ANC_MONITOR_SET_USER_UNAWARE_ENABLE,
    AUDIO_ANC_MONITOR_SET_USER_UNAWARE_MAX,

    /* Noise Gate */
    AUDIO_ANC_MONITOR_SET_ENVIRONMENT_DETECTION_SUSPEND,
    AUDIO_ANC_MONITOR_SET_ENVIRONMENT_DETECTION_MAX,

    AUDIO_ANC_MONITOR_SET_MAX = 0xFFFF,
} audio_anc_monitor_set_info_t;

typedef enum {
    /* User Unaware */
    AUDIO_ANC_MONITOR_GET_USER_UNAWARE_GAIN_INFO = 1,
    AUDIO_ANC_MONITOR_GET_USER_UNAWARE_ENABLE_STAT,
    AUDIO_ANC_MONITOR_GET_USER_UNAWARE_MAX,

    /* Noise Gate */
    AUDIO_ANC_MONITOR_GET_ENVIRONMENT_DETECTION_STATIONARY_NOISE,
    AUDIO_ANC_MONITOR_GET_ENVIRONMENT_DETECTION_MAX,

    AUDIO_ANC_MONITOR_GET_MAX = 0xFFFF,
} audio_anc_monitor_get_info_t;

typedef enum {
    AUDIO_DRIVER_SET_HOLD_AMP_GPIO  = 1,

    AUDIO_DRIVER_SET_NUMBER,

} audio_driver_set_info_t;


typedef struct audio_adaptive_anc_report_s {
    uint16_t adaptive_type;    //enum: audio_adaptive_anc_type_t
    int16_t data[2];
} audio_adaptive_anc_report_t, *audio_adaptive_anc_report_ptr_t;

typedef union {
#ifdef MTK_MULTI_MIC_STREAM_ENABLE
    audio_transmitter_scenario_sub_id_multimic_t multimic_id;
#endif
#ifdef MTK_SENSOR_SOURCE_ENABLE
    audio_transmitter_scenario_sub_id_gsensor_t gsensor_id;
#endif
#if defined(MTK_GAMING_MODE_HEADSET) || defined(AIR_GAMING_MODE_DONGLE_ENABLE)
    audio_transmitter_scenario_sub_id_gamingmode_t gamingmode_id;
#endif
#if defined(AIR_WIRED_AUDIO_ENABLE)
    audio_transmitter_scenario_sub_id_wiredaudio_t wiredaudio_id;
#endif
    audio_transmitter_scenario_sub_id_test_t test_id;
#if defined(AIR_ADVANCED_PASSTHROUGH_ENABLE)
    audio_transmitter_scenario_sub_id_advanced_passthrough_t advanced_passthrough_id;
#endif /* AIR_ADVANCED_PASSTHROUGH_ENABLE */
#if defined(AIR_BLE_AUDIO_DONGLE_ENABLE)
    audio_transmitter_scenario_sub_id_bleaudiodongle_t ble_audio_dongle_id;
#endif /* AIR_BLE_AUDIO_DONGLE_ENABLE */
#if defined(AIR_AUDIO_HW_LOOPBACK_ENABLE)
    audio_transmitter_scenario_sub_id_audio_hw_loopback_t audio_hw_loopback_id;
#endif /* AIR_AUDIO_HW_LOOPBACK_ENABLE */
    uint32_t scenario_id;
} audio_transmitter_scenario_sub_id_t;



typedef enum {
    AUDIO_STRAM_DEINIT_ALL = 0,
    AUDIO_STRAM_DEINIT_VOICE_AEC,
    AUDIO_STRAM_DEINIT_ANC_MONITOR,
} audio_stream_deinit_id_t;

//--------------------------------------------
// Detailed message from DSP to N9
//--------------------------------------------
typedef enum {
    MSG_DSP2N9_UL_START = 0X3002,
} DSP2N9_AUDIO_MSG;

#endif //_DSP_AUDIOMSGDEFINE_H_
