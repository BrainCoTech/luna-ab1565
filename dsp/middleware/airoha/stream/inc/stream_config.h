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

#ifndef _STREAM_CONFIG_H_
#define _STREAM_CONFIG_H_

/*!
 *@file   stream_config.h
 *@brief  defines the config of stream system
 *
 @verbatim
 @endverbatim
 */


#include "types.h"
#include "hal_platform.h"
/**
 * @brief stream config type
 */
typedef enum {
    /*!< mute enable : 1(TRUE) enable ,0(FALSE) disble  */
    AUDIO_SOURCE_MUTE_ENABLE =      0x0200,
    AUDIO_SOURCE_DOWNSAMP_RATE =    0x0201,
    AUDIO_SOURCE_FRAME_SIZE =       0x0202,
    AUDIO_SOURCE_FRAME_NUMBER =     0x0203,
    AUDIO_SOURCE_CIC_FILTER =       0x0204,
    AUDIO_SOURCE_SRC_ENABLE =       0x0205,
    AUDIO_SOURCE_SRC_DISABLE =      0x0206,
    AUDIO_SOURCE_CH_SELECT =        0x0207,
    AUDIO_SOURCE_RESOLUTION =       0x0208,

    AUDIO_SOURCE_IRQ_RATE           =   0x0220,
    AUDIO_SOURCE_IRQ_COUNT          =   0x0221,
    AUDIO_SOURCE_MEMIF_SRAM_MODE    =   0x0222,
    AUDIO_SOURCE_MEMIF_HD_TYPE      =   0x0223,
    AUDIO_SOURCE_MEMIF_ALIGN_TYPE   =   0x0224,
    AUDIO_SOURCE_ALLOCA_SRAM_SIZE   =   0x0225,
    AUDIO_SOURCE_DATA_FORMAT        =   0x0226,
    AUDIO_SOURCE_IRQ_PERIOD         =   0x0227,
    AUDIO_SOURCE_DEVICE             =   0x0228,
    AUDIO_SOURCE_CHANNEL            =   0x0229,
    AUDIO_SOURCE_MEMORY             =   0x022A,
    AUDIO_SOURCE_INTERFACE          =   0x022B,
    AUDIO_SOURCE_HW_GAIN            =   0x022C,
    AUDIO_SOURCE_ECHO_REFERENCE     =   0x022D,
    AUDIO_SOURCE_MISC_PARMS         =   0x022E,

#ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
    AUDIO_SOURCE_DEVICE1            =   0x0230,
    AUDIO_SOURCE_DEVICE2            =   0x0231,
    AUDIO_SOURCE_DEVICE3            =   0x0232,
    AUDIO_SOURCE_INTERFACE1         =   0x0233,
    AUDIO_SOURCE_INTERFACE2         =   0x0234,
    AUDIO_SOURCE_INTERFACE3         =   0x0235,
#ifdef MTK_AUDIO_HW_IO_CONFIG_ENHANCE
    AUDIO_SOURCE_DEVICE4            =   0x0236,
    AUDIO_SOURCE_DEVICE5            =   0x0237,
    AUDIO_SOURCE_DEVICE6            =   0x0238,
    AUDIO_SOURCE_DEVICE7            =   0x0239,
    AUDIO_SOURCE_INTERFACE4         =   0x023A,
    AUDIO_SOURCE_INTERFACE5         =   0x023B,
    AUDIO_SOURCE_INTERFACE6         =   0x023C,
    AUDIO_SOURCE_INTERFACE7         =   0x023D,
#endif
#endif
    AUDIO_SOURCE_SCENARIO_TYPE      =   0x023E,

    AUDIO_SINK_IRQ_RATE             =   0x0250,
    AUDIO_SINK_IRQ_COUNT            =   0x0251,
    AUDIO_SINK_MEMIF_SRAM_MODE      =   0x0252,
    AUDIO_SINK_MEMIF_HD_TYPE        =   0x0253,
    AUDIO_SINK_MEMIF_ALIGN_TYPE     =   0x0254,
    AUDIO_SINK_ALLOCA_SRAM_SIZE     =   0x0255,
    AUDIO_SINK_DATA_FORMAT          =   0x0256,
    AUDIO_SINK_IRQ_PERIOD           =   0x0257,
    AUDIO_SINK_DEVICE               =   0x0258,
    AUDIO_SINK_CHANNEL              =   0x0259,
    AUDIO_SINK_MEMORY               =   0x025A,
    AUDIO_SINK_INTERFACE            =   0x025B,
    AUDIO_SINK_HW_GAIN              =   0x025C,
    AUDIO_SINK_ECHO_REFERENCE       =   0x025D,
    AUDIO_SINK_MISC_PARMS           =   0x025E,
    AUDIO_SRC_RATE                  =   0x025F,
    AUDIO_SINK_SW_CHANNELS          =   0x0260,
//#ifdef HAL_AUDIO_ENABLE_PATH_MEM_DEVICE
    AUDIO_SINK_ADC_MODE             =   0x0261,
//#endif
    AUDIO_SINK_SCENARIO_TYPE        =   0x0262,
    AUDIO_SINK_DEVICE1              =   0x0263,
    AUDIO_SINK_INTERFACE1           =   0x0264,
    AUDIO_OPERATION_MODE            =   0x0270,
#ifdef MTK_AUDIO_HW_IO_CONFIG_ENHANCE
    AUDIO_SINK_I2S_FORMAT                   =   0x0271,
    AUDIO_SINK_I2S_SLAVE_TDM                =   0x0272,
    AUDIO_SINK_I2S_WORD_LENGTH              =   0x0273,
    AUDIO_SINK_I2S_MASTER_FORMAT            =   0x0274,
    AUDIO_SINK_I2S_MASTER_FORMAT1           =   0x0275,
    AUDIO_SINK_I2S_MASTER_FORMAT2           =   0x0276,
    AUDIO_SINK_I2S_MASTER_FORMAT3           =   0x0277,
    AUDIO_SINK_I2S_MASTER_WORD_LENGTH       =   0x0278,
    AUDIO_SINK_I2S_MASTER_WORD_LENGTH1      =   0x0279,
    AUDIO_SINK_I2S_MASTER_WORD_LENGTH2      =   0x027A,
    AUDIO_SINK_I2S_MASTER_WORD_LENGTH3      =   0x027B,
    AUDIO_SINK_I2S_MASTER_SAMPLING_RATE     =   0x027C,
    AUDIO_SINK_I2S_MASTER_SAMPLING_RATE1    =   0x027D,
    AUDIO_SINK_I2S_MASTER_SAMPLING_RATE2    =   0x027E,
    AUDIO_SINK_I2S_MASTER_SAMPLING_RATE3    =   0x027F,
    AUDIO_SINK_I2S_MASTER_LOW_JITTER        =   0x0280,
    AUDIO_SINK_I2S_MASTER_LOW_JITTER1       =   0x0281,
    AUDIO_SINK_I2S_MASTER_LOW_JITTER2       =   0x0282,
    AUDIO_SINK_I2S_MASTER_LOW_JITTER3       =   0x0283,

    AUDIO_SINK_DAC_PERFORMANCE      =   0x02A0,
#endif
    AUDIO_SINK_MUTE_ENABLE =        0x02A1,
    AUDIO_SINK_UPSAMPLE_RATE =      0x02A2,
    AUDIO_SINK_FRAME_SIZE =         0x02A3,
    AUDIO_SINK_FRAME_NUMBER =       0x02A4,
    AUDIO_VP_SINK_FRAME_SIZE =      0x02A5,
    AUDIO_VP_SINK_FRAME_NUMBER =    0x02A6,
    AUDIO_SINK_CIC_FILTER =         0x02A7,
    AUDIO_SINK_SIDE_TONE_ENABLE =   0x02A8,
    AUDIO_SINK_SIDE_TONE_DISABLE =  0x02A9,
    AUDIO_SINK_LR_SWITCH_ENABLE =   0x02AA,
    AUDIO_SINK_SRC_ENABLE =         0x02AB,
    AUDIO_SINK_SRC_DISABLE =        0x02AC,
    AUDIO_SINK_CH_SELECT =          0x02AD,
    AUDIO_SINK_FORCE_START =        0x02AE,
    AUDIO_SINK_RESOLUTION   =       0x02AF,
    AUDIO_SINK_SRCIN_SAMPLE_RATE =  0X02B0,
    AUDIO_SINK_SRCIN_RESOLUTION =   0x02B1,
    AUDIO_SINK_PAUSE =               0x02B2,
    AUDIO_SINK_RESUME =               0x02B3,
    AUDIO_SINK_SET_HANDLE =         0x02B4,
#ifdef ENABLE_HWSRC_CLKSKEW
    AUDIO_SINK_CLKSKEW_MODE =         0x2B5,
#endif
#ifdef MTK_AUDIO_HW_IO_CONFIG_ENHANCE
    AUDIO_SOURCE_ADC_MODE  =         0x02B6,
    AUDIO_SOURCE_ADC_MODE1 =         0x02B7,
    AUDIO_SOURCE_ADC_MODE2 =         0x02B8,
    AUDIO_SOURCE_ADC_MODE3 =         0x02B9,
    AUDIO_SOURCE_ADC_MODE4 =         0x02BA,
    AUDIO_SOURCE_ADC_MODE5 =         0x02BB,
    AUDIO_SOURCE_ADC_MODE6 =         0x02BC,
    AUDIO_SOURCE_ADC_MODE7 =         0x02BD,
    AUDIO_SOURCE_BIAS_VOLTAGE =       0x02BE,
#ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
    AUDIO_SOURCE_BIAS_VOLTAGE1 =      0x02BF,
    AUDIO_SOURCE_BIAS_VOLTAGE2 =      0x02C0,
    AUDIO_SOURCE_BIAS_VOLTAGE3 =      0x02C1,
    AUDIO_SOURCE_BIAS_VOLTAGE4 =      0x02C2,
    AUDIO_SOURCE_BIAS_VOLTAGE5 =      0x02C3,
#endif
    AUDIO_SOURCE_DMIC_SELECT  =      0x02C4,
#ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
    AUDIO_SOURCE_DMIC_SELECT1 =      0x02C5,
    AUDIO_SOURCE_DMIC_SELECT2 =      0x02C6,
    AUDIO_SOURCE_DMIC_SELECT3 =      0x02C7,
    AUDIO_SOURCE_DMIC_SELECT4 =      0x02C8,
    AUDIO_SOURCE_DMIC_SELECT5 =      0x02C9,
    AUDIO_SOURCE_DMIC_SELECT6 =      0x02CA,
    AUDIO_SOURCE_DMIC_SELECT7 =      0x02CB,
#endif
    AUDIO_SOURCE_UL_IIR =            0x02CC,
#ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
    AUDIO_SOURCE_UL_IIR1 =           0x02CD,
    AUDIO_SOURCE_UL_IIR2 =           0x02CE,
#endif
    AUDIO_SOURCE_BIAS_SELECT =       0x02CF,
    AUDIO_SOURCE_WITH_EXTERNAL_BIAS = 0x02D0,
    AUDIO_SOURCE_WITH_BIAS_LOWPOWER = 0x02D1,
    AUDIO_SOURCE_BIAS1_BIAS2_WITH_LDO0 = 0x02D2,
    AUDIO_SOURCE_UL_PERFORMANCE =      0x02D3,
    AUDIO_SOURCE_I2S_FORMAT                     =   0x02D4,
    AUDIO_SOURCE_I2S_SLAVE_TDM                  =   0x02D5,
    AUDIO_SOURCE_I2S_WORD_LENGTH                =   0x02D6,
    AUDIO_SOURCE_I2S_MASTER_FORMAT              =   0x02D7,
    AUDIO_SOURCE_I2S_MASTER_FORMAT1             =   0x02D8,
    AUDIO_SOURCE_I2S_MASTER_FORMAT2             =   0x02D9,
    AUDIO_SOURCE_I2S_MASTER_FORMAT3             =   0x02DA,
    AUDIO_SOURCE_I2S_MASTER_WORD_LENGTH         =   0x02DB,
    AUDIO_SOURCE_I2S_MASTER_WORD_LENGTH1        =   0x02DC,
    AUDIO_SOURCE_I2S_MASTER_WORD_LENGTH2        =   0x02DD,
    AUDIO_SOURCE_I2S_MASTER_WORD_LENGTH3        =   0x02DE,
    AUDIO_SOURCE_I2S_MASTER_SAMPLING_RATE       =   0x02DF,
    AUDIO_SOURCE_I2S_MASTER_SAMPLING_RATE1      =   0x02E0,
    AUDIO_SOURCE_I2S_MASTER_SAMPLING_RATE2      =   0x02E1,
    AUDIO_SOURCE_I2S_MASTER_SAMPLING_RATE3      =   0x02E2,
    AUDIO_SOURCE_I2S_MASTER_LOW_JITTER          =   0x02E3,
    AUDIO_SOURCE_I2S_MASTER_LOW_JITTER1         =   0x02E4,
    AUDIO_SOURCE_I2S_MASTER_LOW_JITTER2         =   0x02E5,
    AUDIO_SOURCE_I2S_MASTER_LOW_JITTER3         =   0x02E6,

#endif
#ifdef MTK_AUDIO_HW_IO_CONFIG_ENHANCE
    AUDIO_SOURCE_DMIC_CLOCK =            0x02F0,
#ifdef AIR_AUDIO_SUPPORT_MULTIPLE_MICROPHONE
    AUDIO_SOURCE_DMIC_CLOCK1 =           0x02F1,
    AUDIO_SOURCE_DMIC_CLOCK2 =           0x02F2,
#endif
#endif
#ifdef AIR_HFP_DNN_PATH_ENABLE
    AUDIO_SOURCE_DNN_PATH_ENABLE      =   0x0343,
    AUDIO_SINK_DNN_PATH_ENABLE        =   0x0344,
#endif
    VIRTUAL_SINK_SET_HANDLE =       0X0350,
    VIRTUAL_SINK_BUF_SIZE =         0X0351,


    SCO_SINK_MUTE_ENABLE =          0x0380,
    SCO_SINK_PKT_SIZE =             0x0381,

    SCO_SINK_PKT_NUMBER =           0x0382,


    SCO_SOURCE_PKT_INFO_LENGTH =    0x0300,
    SCO_SOURCE_PKT_SIZE =           0x0301,
    SCO_SOURCE_PKT_NUMBER =         0x0302,
    SCO_SOURCE_WO_ADVANCE =         0x0303,
    MEMORY_SOURCE_MAX_DATA_READ =   0x0400,
    MEMORY_SOURCE_SET_HANDLE =      0x0401,
    MEMORY_SOURCE_UPDATE_MEM_ADDR = 0x0402, // Source Memory length will be set to zero to prevent Unexpected data read.
    MEMORY_SOURCE_UPDATE_MEM_LEN =    0x0403,
    MEMORY_SOURCE_FORCE_DATA_PUT =  0x0404,

    MEMORY_SINK_SET_WRITE_OFFSET =  0x0410,
    MEMORY_SINK_FORCE_DATA_FILL =   0x0411,
    MEMORY_SINK_SET_COMPARE_OFFSET = 0x0412,
    MEMORY_SINK_DATA_COMPARE   =    0x0413,



    FILE_SET_FILE_HANDLE_POINTER, // Set the address of the opened file's handle.
    FILE_CLEAR_BUFFER, // Clear internal memory buffer for preloading data from SD/eMMC.
    FILE_FINISHED_READ_HANDLER, // Specify the message handler which will receive read finished message.
    FILE_EOF, // Check whether the file is read complete or not.

    AUDIO_SOURCE_UPDOWN_SAMPLER_ENABLE,
    AUDIO_SOURCE_PATH_INPUT_RATE,
    AUDIO_SOURCE_PATH_OUTPUT_RATE,
    AUDIO_SINK_UPDOWN_SAMPLER_ENABLE,
    AUDIO_SINK_PATH_INPUT_RATE,
    AUDIO_SINK_PATH_OUTPUT_RATE,
} stream_config_type;


#endif  /* __APP_STREAM_IF_H__ */
