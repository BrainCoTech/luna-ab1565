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

#ifndef __APP_LEA_SERVICE_CONFIG_H__
#define __APP_LEA_SERVICE_CONFIG_H__

/**
 * File: app_lea_service_config.h
 *
 * Description: This file defines the configure option for LE Audio.
 *
 */
#include <stdbool.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif



// Always advertising when ADV timeout = 0
#define APP_LE_AUDIO_ADV_TIME                   (2 * 60 * 1000)
// Only EDR->LEA General ADV time for MTK Phone
#define APP_LE_AUDIO_SWITCH_LEA_ADV_TIME        (20 * 1000)
// Only EDR->LEA General ADV time on non-connected device for dual_mode
#define APP_LE_AUDIO_DUAL_MODE_GENERAL_ADV_TIME (10 * 1000)

#define APP_LE_AUDIO_MODE_DEFAULT               0
#define APP_LE_AUDIO_MODE_DONGLE_ONE            1

/*
 * The LE Audio Connection & advertising type.
 * Common Rule
 *     Stop ADV when LEA Link or total_conn_num full;
 *
 * 0: default (APP_LE_AUDIO_MODE_DEFAULT)
 *    No direct ADV
 *    MAX_LEA_LINK (EMP ON - 2, OFF - 1)
 *    Start infinite general ADV when ONE EDR or ONE LEA or LEA disconnect or BT reboot (ever LEA connected)
 *    Start 2min general ADV when EDR visible
 * 1: Dongle multi-device case (APP_LE_AUDIO_MODE_DONGLE_ONE)
 *    Support Direct ADV
 *    MAX LEA Link == 1
 *    Start infinite direct ADV when open LID or LEA disconnect or BT reboot
 */
#if defined(AIR_LE_AUDIO_ENABLE) && defined(AIR_LE_AUDIO_QUICK_RECONN_ENABLE)
#define APP_LE_AUDIO_ADV_CONN_MODE              APP_LE_AUDIO_MODE_DONGLE_ONE
#else
#define APP_LE_AUDIO_ADV_CONN_MODE              APP_LE_AUDIO_MODE_DEFAULT
#endif

#if (APP_LE_AUDIO_ADV_CONN_MODE == APP_LE_AUDIO_MODE_DEFAULT)
#define AIR_LE_AUDIO_WHITELIST_ADV
#ifdef MTK_AWS_MCE_ENABLE
#define AIR_LE_AUDIO_BOTH_SYNC_INFO
#endif
#ifdef AIR_BT_TAKEOVER_ENABLE
#define APP_LE_AUDIO_MAX_LINK_NUM               (2 + 1)       // +1 for takeover
#else
#define APP_LE_AUDIO_MAX_LINK_NUM               2
#endif

#elif (APP_LE_AUDIO_ADV_CONN_MODE == APP_LE_AUDIO_MODE_DONGLE_ONE)
#define AIR_LE_AUDIO_DIRECT_ADV
#define APP_LE_AUDIO_MAX_LINK_NUM               1
#ifdef AIR_LE_AUDIO_HEADSET_ENABLE
#define APP_LE_AUDIO_DONGLE_ONE_ADV_TIME        0       // Headset need to start ADV all the time (No SmartCharger)
#else
#define APP_LE_AUDIO_DONGLE_ONE_ADV_TIME        (2 * 60 * 1000)
#endif
#endif

#define APP_LEA_ADV_NAME_PREFIX                 "LEA-"

#if !defined(AIR_LE_AUDIO_ENABLE) && defined(AIR_BLE_ULTRA_LOW_LATENCY_ENABLE)
#define AIR_LEA_ULL2_KEY_TRIGGET_GENERAL_ADV
#endif

#define APP_LEA_MAX_BOND_NUM                    8

typedef enum {
    APP_LEA_ADV_MODE_NONE,
    APP_LEA_ADV_MODE_GENERAL,                   /* General ADV with ADV data payload. */
    APP_LEA_ADV_MODE_TARGET,                    /* General ADV with ADV data payload & 1~2 whitelist. Only for Power on reconnect. */
    APP_LEA_ADV_MODE_TARGET_ALL,                /* General ADV with ADV data payload & all bonded addr whitelist. */
    APP_LEA_ADV_MODE_DIRECT,                    /* Only for APP_LE_AUDIO_MODE_DONGLE_ONE. */
    APP_LEA_ADV_MODE_MIX,                       /* Reserved for future. */
} app_lea_adv_mgr_mode_t;

#define APP_LE_AUDIO_ADV_INTERVAL_MIN   0x0004              /* 2.5 ms */
#define APP_LE_AUDIO_ADV_INTERVAL_MAX   0x0008              /* 5 ms */
#define APP_LE_AUDIO_ADV_INTERVAL_MIN_S 0x0020              /* 20 ms */
#define APP_LE_AUDIO_ADV_INTERVAL_MAX_S 0x0030              /* 30 ms */
#define APP_LE_AUDIO_ADV_INTERVAL_MIN_L 0x00A0              /* 100 ms */
#define APP_LE_AUDIO_ADV_INTERVAL_MAX_L 0x00A0              /* 100 ms */

#ifdef __cplusplus
}
#endif

#endif /* __APP_LEA_SERVICE_CONFIG_H__ */
