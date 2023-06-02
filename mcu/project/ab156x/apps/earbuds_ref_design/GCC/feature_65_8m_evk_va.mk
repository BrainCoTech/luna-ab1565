# Copyright Statement:
#
# (C) 2021  Airoha Technology Corp. All rights reserved.
#
# This software/firmware and related documentation ("Airoha Software") are
# protected under relevant copyright laws. The information contained herein
# is confidential and proprietary to Airoha Technology Corp. ("Airoha") and/or its licensors.
# Without the prior written permission of Airoha and/or its licensors,
# any reproduction, modification, use or disclosure of Airoha Software,
# and information contained herein, in whole or in part, shall be strictly prohibited.
# You may only use, reproduce, modify, or distribute (as applicable) Airoha Software
# if you have agreed to and been bound by the applicable license agreement with
# Airoha ("License Agreement") and been granted explicit permission to do so within
# the License Agreement ("Permitted User").  If you are not a Permitted User,
# please cease any access or use of Airoha Software immediately.
# BY OPENING THIS FILE, RECEIVER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
# THAT AIROHA SOFTWARE RECEIVED FROM AIROHA AND/OR ITS REPRESENTATIVES
# ARE PROVIDED TO RECEIVER ON AN "AS-IS" BASIS ONLY. AIROHA EXPRESSLY DISCLAIMS ANY AND ALL
# WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
# NEITHER DOES AIROHA PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
# SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
# SUPPLIED WITH AIROHA SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO SUCH
# THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY ACKNOWLEDGES
# THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES
# CONTAINED IN AIROHA SOFTWARE. AIROHA SHALL ALSO NOT BE RESPONSIBLE FOR ANY AIROHA
# SOFTWARE RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
# STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND AIROHA'S ENTIRE AND
# CUMULATIVE LIABILITY WITH RESPECT TO AIROHA SOFTWARE RELEASED HEREUNDER WILL BE,
# AT AIROHA'S OPTION, TO REVISE OR REPLACE AIROHA SOFTWARE AT ISSUE,
# OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY RECEIVER TO
# AIROHA FOR SUCH AIROHA SOFTWARE AT ISSUE.
#

IC_CONFIG                             = ab156x
BOARD_CONFIG                          = ab156x_evb
IC_TYPE                               = ab1565
BOARD_TYPE                            = ab1565_8m_evk
BL_FEATURE                            = feature_65_evb.mk


##############################################
#           Custom feature option            #
##############################################

## part1: configure y/n

###### Audio/Voice effects ######

# This option is to enable/disable Audio PLC.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_AUDIO_PLC_ENABLE = n

# This option is to enable PEQ feature.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_PEQ_ENABLE = y

# This option is to enable/disable fit detection
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
# Dependency: AIR_ANC_ENABLE must be enabled when this option is set to y.
AIR_ANC_FIT_DETECTION_ENABLE = n

# This option is used to enable/disable wind noise detection adaptive ANC.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
# Dependency: AIR_ANC_ENABLE must be enabled when this option is set to y.
AIR_ANC_WIND_NOISE_DETECTION_ENABLE = y

# This option is used to enable/disable Environment Detection adaptive ANC.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
# Dependency: AIR_ANC_ENABLE must be enabled when this option is set to y.
AIR_ANC_ENVIRONMENT_DETECTION_ENABLE = y

# This option is used to enable/disable User triggered adaptive ANC.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
# Dependency: AIR_ANC_ENABLE and AIR_AUDIO_TRANSMITTER_ENABLE must be enabled when this option is set to y.
AIR_USER_TRIGGER_FF_ENABLE = n

# This option is used to enable/disable User Unaware adaptive ANC.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
# Dependency: AIR_ANC_ENABLE must be enabled when this option is set to y.
AIR_ANC_USER_UNAWARE_ENABLE = n

# This is the option of audio transmitter. Users who use audio transmitter need to open this option.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_AUDIO_TRANSMITTER_ENABLE = y

# This option is uesd for enhanced gain setting.
AIR_AUDIO_GAIN_SETTING_ENHANCE_ENABLE = y

# This option is used to enable/disable the AT CMD trigging voice prompt.
AIR_AUDIO_AT_CMD_PROMPT_SOUND_ENABLE = n

# This option is used to enable/disable amp dc compensation.
AIR_AMP_DC_COMPENSATION_ENABLE = y

# This option is used to enable/disable SBC encoder.
AIR_SBC_ENCODER_ENABLE = y

# This option is used to support stereo MP3 voice prompt.
AIR_MP3_STEREO_SUPPORT_ENABLE = y

# This option is used to enable/disable HWSRC CLK SKEW.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_HWSRC_CLKSKEW_ENABLE = y

# This option is used to enable/disable HWSRC RX TRACKING.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_HWSRC_RX_TRACKING_ENABLE = n

# This option is used to enable/disable HWSRC TX TRACKING.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_HWSRC_TX_TRACKING_ENABLE = n


###### Scenario ######

# This option is used to enable record. It must be enabled when using voice assistant.
AIR_RECORD_ENABLE = y

# This option is used to enable/disable HFP scenario
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_BT_HFP_ENABLE = y

# This option is used to enable/disable BT sink state manager.
AIR_BT_SINK_SRV_STATE_MANAGER_ENABLE = y

######  Codec ######

# This option is used to enable vendor codec.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_BT_A2DP_VENDOR_ENABLE = n

# This option is used to enable LHDC codec.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_BT_A2DP_LHDC_ENABLE = n

# This option is to enable Codec Manager.
AIR_AUDIO_CODEC_MANAGER_ENABLE = y

# This option is used to add opus encode support.
AIR_OPUS_ENCODER_ENABLE = y

######  Voice assistant/VAD ######

# This option is used to enable AMA feature.
AIR_AMA_ENABLE = y

# This option is used to enable AMA HOT word feature.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
# Dependency: AIR_AMA_ENABLE must be enabled when this option is set to y.
AIR_AMA_HOTWORD_ENABLE = y

# This option is used to enable AMA IAP2 .
# Dependency: AIR_AMA_ENABLE must be enabled when this option is set to y.
AIR_AMA_IAP2_APP_RELAY_ENABLE = y

# This option is used to enable AMA control sidetone.
# Dependency: AIR_AMA_ENABLE must be enabled when this option is set to y.
AIR_AMA_SIDETONE_ENABLE = y

# This option is used to enable AMA WWE during calling feature
# Dependency: AIR_AMA_ENABLE and AIR_AMA_HOTWORD_ENABLE must be enabled when this option is set to y.
AIR_AMA_HOTWORD_DURING_CALL_ENABLE = n

# This option is used to enable AMA ADV before EDR connected feature
# Dependency: AIR_AMA_ENABLE must be enabled when this option is set to y.
AIR_AMA_ADV_ENABLE_BEFORE_EDR_CONNECT_ENABLE = n

# This option is used to enable GSound.
# Dependency: AIR_RECORD_ENABLE and AIR_SBC_ENCODER_ENABLE must be enabled when this option is set to y.
AIR_GSOUND_ENABLE = y

# This option is used to enable GSound Hotword.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
# Dependency: AIR_GSOUND_ENABLE must be enabled when this option is set to y.
AIR_GSOUND_HOTWORD_ENABLE = y

# This option is used to enable multi va support competition.
AIR_MULTI_VA_SUPPORT_COMPETITION_ENABLE = y

# This option is used to enable Xiaowei.
# Dependency: AIR_RECORD_ENABLE and AIR_OPUS_ENCODER_ENABLE must be enabled when this option is set to y.
AIR_XIAOWEI_ENABLE = n

######  BT/MCSync ######

# This option is used to enable/disable BT related AT command.
AIR_BT_AT_COMMAND_ENABLE = y

# This option is used to enable some speaker-specific functions
AIR_BT_SPEAKER_ENABLE = n

# This option is used to enable multi link at the same time.
AIR_MULTI_POINT_ENABLE = y

# This option is to enable/disable MUX BT HID feature.
# Dependency:AIR_BT_HID_ENABLE must be enable when this option is set to y.
AIR_MUX_BT_HID_ENABLE = n

# This option is to enable/disable BT HID feature.
AIR_BT_HID_ENABLE = n

# This option is to set whether earbuds can join another set of earbuds to listen common music.
AIR_MCSYNC_SHARE_ENABLE = y

# This option is to enable/disable LE Audio.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_LE_AUDIO_ENABLE = n

# This option is used to support LE Audio broadcast.
# Dependency: AIR_LE_AUDIO_ENABLE must be enabled when this option is set to y.
AIR_LE_AUDIO_BIS_ENABLE = n

# This option is used to support dual mode of classic/LE Audio.
# Dependency: AIR_LE_AUDIO_ENABLE must be enabled when this option is set to y.
AIR_LE_AUDIO_DUAL_MODE_ENABLE = n

# This option is to enable LE Audio dongle scenario.
# Dependency: AIR_LE_AUDIO_ENABLE must be enabled when this option is set to y.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_LE_AUDIO_DONGLE_ENABLE = n

# This option is to enable/disable BLE OTP(Object Transfer Profile).
AIR_LE_OTP_ENABLE = n

# This option is used to enable the feature that iap2 data is transmitted through MUX
AIR_IAP2_VIA_MUX_ENABLE = y

# This option is used to enable teams.
# Dependency: AIR_USB_AUDIO_HID_ENABLE must be enabled when this option is set to y.
AIR_MS_TEAMS_ENABLE = n

# This option is used to enable/disable LC3PLUS codec support. It should be disable by default.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_AUDIO_LC3PLUS_CODEC_ENABLE = n

# This option is used to enable/disable ULD codec support. It should be disable by default.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_AUDIO_ULD_CODEC_ENABLE = n

# This option is used to enable/disable vendor codec support. It should be disable by default.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_AUDIO_VEND_CODEC_ENABLE = n

# This option is used to enable/disable silence detection feature. It should be disable by default.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_AUDIO_SILENCE_DETECTION_ENABLE = n

# This option is used to enable ull2.0.
AIR_BLE_ULTRA_LOW_LATENCY_ENABLE = n

######  System ######

# This option is used to enable fast pair.
AIR_BT_FAST_PAIR_ENABLE = y

# This option is used to enable fast pair SASS.
# Dependency: AIR_BT_FAST_PAIR_ENABLE must be enabled when this option is set to y.
AIR_BT_FAST_PAIR_SASS_ENABLE = y

# This option is used to enable fast pair spot.
# Dependency: AIR_BT_FAST_PAIR_ENABLE must be enabled when this option is set to y.
AIR_SPOT_ENABLE = n

# This option is used to enable FOTA basic function.
AIR_FOTA_ENABLE = y

# This option is to enable FOTA via race cmd.
# Dependency: AIR_FOTA_ENABLE, AIR_RACE_CMD_ENABLE and AIR_RACE_DUAL_CMD_ENABLE (if it is an earbuds project) must be enabled when this option is set to y.
AIR_FOTA_VIA_RACE_CMD_ENABLE = y

# This option is to enable smart charger case.
AIR_SMART_CHARGER_ENABLE = n

# This option is to enable smart charger 1wire function.
AIR_1WIRE_ENABLE = n

# This option is to switch early log print from uart1.
AIR_UART1_EARLY_LOG_ENABLE = n

# This option is used to enable wearing detection.
AIR_WEARING_DETECTION_ENABLE = n

# This option is used to enable component firmware update module.
# Dependency: AIR_USB_AUDIO_HID_ENABLE, AIR_LE_AUDIO_ENABLE, AIR_RACE_CMD_ENABLE, AIR_FOTA_ENABLE must enable, and AIR_USB_AUDIO_VERSION cannot be none.
AIR_CFU_ENABLE = n

# This option is to enable MS XBOX GIP feature.
# Dependency: AIR_BT_ULTRA_LOW_LATENCY_ENABLE must be enabled when this option is set to y.
AIR_MS_GIP_ENABLE = n

# This option is used to support RACE CMD trigger Find me.
# Dependency: AIR_RACE_CMD_ENABLE must be enabled when this option is set to y.
AIR_RACE_FIND_ME_ENABLE = y

# This option is used to enable race cmd.
AIR_RACE_CMD_ENABLE = y

# This option is used to enable 3rd party BLE advertising
AIR_TILE_ENABLE = n

# This option is to enable minidump feature.
AIR_MINIDUMP_ENABLE = n

# This option is to enable audio dump for CM4 side debug use.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_AUDIO_DUMP_ENABLE = y

# This option is to support air dump for ecnr.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_AIRDUMP_ENABLE = n

# This option is to enable and disable CPU utilization function.
AIR_OS_CPU_UTILIZATION_ENABLE = y

# This option is used to enable the feature that disabling BT if device is charging.
AIR_APPS_DISABLE_BT_WHEN_CHARGING_ENABLE = y

# This option is used to enable/disable the power saving in APP.
AIR_APPS_POWER_SAVE_ENABLE = y

# This option is used to enable/disable key driver.
AIR_AIRO_KEY_ENABLE = y

# This option is used to enable/disable eint key module.
AIR_EINT_KEY_ENABLE = y

# This option is used to enable/disable secure boot module.
# NOTICE:
#   - This option can only be enabled if the secure-boot-addon-repo exists.
#   - secure-boot-addon-repo path: mcu\prebuilt\middleware\airoha\secure_boot
#   - If this option enabled without secure boot addon repo, the code will build fail.
AIR_SECURITY_SECURE_BOOT_ENABLE = n

# This option is to enable/disable Microsoft Swift Pair.
AIR_SWIFT_PAIR_ENABLE = n

# This option is to enable/disable Spotify Tap feature
AIR_SPOTIFY_TAP_ENABLE = n

# This option is used to enable/disable SWB.
# It must be turned on/off for both DSP and MCU, otherwise, it will not work.
AIR_BT_BLE_UL_SWB_ENABLE = n

# This option is used to enable/disable google spatial audio head tracker. It should be disable by default.
# Dependency: AIR_BT_HID_ENABLE or AIR_USB_HID_ENABLE must be enable when this option is set to y.
AIR_GOOGLE_SPATIAL_AUDIO_ENABLE = n

## part2: need to set specified value

###### Voice assistant/VAD ######

# This option is to configure key trigger mode of AMA.
# Usage: NONE, PTT, TTT
#     NONE : The button trigger mode is disabled
#     TTT : Tap-To-Talk trigger mode.
#     PTT : Push-To-Talk trigger mode.
# Dependency: AIR_AMA_ENABLE must be enabled when this option is not set to NONE.
AIR_AMA_BUTTON_TRIGGER_MODE = TTT

######  System ######

# Using specific linker script during linking process.
AIR_MCU_LINKER_SCRIPT_FILE = ab156x_flash_8m.ld


# This option is to configure mbedTLS features.
AIR_MBEDTLS_CONFIG_FILE = config-vendor-fota-race-cmd.h

# This option is to configure system log debug level.
# Usage: none, error, warning, info, debug
#              empty   : All debug logs are compiled.
#              error   : Only error logs are compiled.
#              warning : Only warning and error logs are compiled.
#              info    : Only info, warning, and error logs are compiled.
#              debug   : All debug logs are compiled.
#              none    : All debugs are disabled.
AIR_DEBUG_LEVEL = info

######  Audio ######

# This option is to choose the default type of Active Noise Cancellation (ANC). Default setting is ANC_STATIC.
# It must be set to the same value for both DSP and MCU, otherwise, it will not work.
# Usage: none, ANC_STATIC, ANC_FULL_ADAPTIVE
#                   none              : Non-support Active Noise Cancellation.
#                   ANC_STATIC        : Default support type of Active Noise Cancellation will be static ANC.
#                   ANC_FULL_ADAPTIVE : Default support type of Active Noise Cancellation will be full adaptive ANC. No support for headset project. No support for AB156x project.
AIR_ANC_ENABLE_TYPE   = ANC_STATIC

# This option is to choose the default type of Passthru. Default setting is PASSTHRU_HYBRID.
# It must be set to the same value for both DSP and MCU, otherwise, it will not work.
# Usage: none, PASSTHRU_FF, PASSTHRU_HYBRID, PASSTHRU_ADAPTIVE, PASSTHRU_VIVID, PASSTHRU_PSAP, PASSTHRU_HEARING_AID
#                        none                 : Non-support Passthru.
#                        PASSTHRU_FF          : Default support type of Passthru will be feedforward Passthru.
#                        PASSTHRU_HYBRID      : Default support type of Passthru will be hybrid Passthru.
#                        PASSTHRU_ADAPTIVE    : Default support type of Passthru will be adaptive Passthru. No support for headset project. No support for AB156x project.
#                        PASSTHRU_VIVID       : Default support type of Passthru will be vivid Passthru.
#                        PASSTHRU_PSAP        : Default support type of Passthru will be PSAP Passthru.
#                        PASSTHRU_HEARING_AID : Default support type of Passthru will be Hearing Aid.
AIR_PASSTHRU_ENABLE_TYPE  = PASSTHRU_HYBRID

# This option is to choose the uplink rate. Default setting is none.
# It must be set to the same value for both DSP and MCU, otherwise, it will not work.
# Usage: none, 48k
#                none : uplink rate will be handled by scenario itself.
#                48k  : uplink rate will be fixed in 48k Hz.
AIR_UPLINK_RATE   = none

# This option is to fix the uplink DMA resolution. Default setting is none.
# It must be set to the same value for both DSP and MCU, otherwise, it will not work.
# Usage: none, 32bit
#                      none : uplink resolution will be handled by scenario itself.
#                      32bit: uplink resolution will be fixed at 32-bit.
AIR_UPLINK_RESOLUTION   = none

# This option is to choose the downlink rate. Default setting is none.
# It must be set to the same value for both DSP and MCU, otherwise, it will not work.
# Usage: none, 48k, 96k
#                  none  : downlink rate will be handled by scenario itself.
#                  48k   : downlink rate will be fixed in 48k Hz.
#                  96k   : downlink rate will be fixed in 96k Hz.
AIR_DOWNLINK_RATE = none

# This option is to choose the type of ECNR. Default setting is none.
# It must be set to the same value for both DSP and MCU, otherwise, it will not work.
# Usage: none, ECNR_1_OR_2_MIC, ECNR_1MIC_INEAR, ECNR_2MIC_INEAR, 3RD_PARTY_AI_NR, 3RD_PARTY_AI_NR_OFFLOAD, 3RD_PARTY_AI_NR_OFFLOAD_POST_EC, 3RD_PARTY_AI_NR_PRO_BROADSIDE_SEPARATE_MODE, 3RD_PARTY_AI_NR_SEPARATE_MODE_EC, 3RD_PARTY_AI_NR_INEAR, 3RD_PARTY_AI_NR_SHORT_BOOM_OO, 3RD_PARTY_AI_NR_PRO_DISTRACTOR, 3RD_PARTY_AI_NR_PRO_TWS_OO, 3RD_PARTY_CUSTOMIZED, LD_NR
#                  none             : disable ECNR
#                  ECNR_1_OR_2_MIC  : Inhouse ECNR to support 1 or 2 MIC.
#                  ECNR_1MIC_INEAR  : Inhouse ECNR to support 1 + 1 MIC.
#                  ECNR_2MIC_INEAR  : Inhouse ECNR to support 1 + 2 MIC.
#                  3RD_PARTY_AI_NR  : 3rd party AINR to support 1/2 MIC.
#                  3RD_PARTY_AI_NR_OFFLOAD  : 3rd party AINR to support 1 MIC with offload.
#                  3RD_PARTY_AI_NR_OFFLOAD_POST_EC  : 3rd party AINR to support 1 MIC with offload(dongle).
#                  3RD_PARTY_AI_NR_PRO_BROADSIDE_SEPARATE_MODE  : 3rd party AINR to support 1 MIC with separate EC/NR_PostEC.
#                  3RD_PARTY_AI_NR_SEPARATE_MODE_EC  : 3rd party AINR to support 1 MIC with separate EC only.
#                  3RD_PARTY_AI_NR_INEAR : 3rd party AINR to support 1/2 + 1 MIC.
#                  3RD_PARTY_AI_NR_SHORT_BOOM_OO : 3rd party AINR to support short boom mic for open office.
#                  3RD_PARTY_AI_NR_PRO_DISTRACTOR : 3rd party AINR to support pro distractor.
#                  3RD_PARTY_AI_NR_PRO_TWS_OO : 3rd party AINR to support pro tws for open office.
#                  3RD_PARTY_CUSTOMIZED : Customized NR.
#                  LD_NR : Inhouse LDNR(Low Delay NR)to support 1/2 MIC.
AIR_ECNR_CONFIG_TYPE = none

######  Audio peripheral ######

# This option is to configure voice prompt decoder codec type.
# Usage: none, mp3, wav, opus, all
#             all  : Support all decoder codec types, mp3/pcm/wav/opus.
#             mp3  : Support MP3 voice prompt files, default selection.
#             wav  : Support WAV voice prompt files, a-law/u-law/ms-adpcm/ima-adpcm/pure pcm.
#             opus : Support OPUS voice prompt files, 1 channel, 48 KHz, 20 ms frame size and CELT elementary stream.
#             none : Unused codec. It can still be used to play pure pcm.
AIR_PROMPT_CODEC_TYPE = mp3

# This option is to define product category.
AIR_PRODUCT_CATEGORY = AB1565_Earbuds

