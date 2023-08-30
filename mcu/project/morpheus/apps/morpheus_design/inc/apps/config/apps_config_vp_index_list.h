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

/**
 * File: apps_config_vp_index_list.h
 *
 * Description: This file defines the VP index list. Add index here for customized VP implementation.
 *
 * Note: See doc/AB1565_AB1568_Earbuds_Reference_Design_User_Guide.pdf for more detail.
 *
 */

#ifndef __APPS_CONFIG_APPS_CONFIG_VP_INDEX_LIST_H__
#define __APPS_CONFIG_APPS_CONFIG_VP_INDEX_LIST_H__

enum {
    VP_INDEX_POWER_ON = 0,
    VP_INDEX_POWER_OFF,
    VP_INDEX_PAIRING,
    VP_INDEX_CONNECTED,
    VP_INDEX_DEVICE_DISCONNECTED,
    VP_INDEX_PAIRING_TIMEOUT,
    VP_INDEX_PLEASE_WEAR_DEVICE,
    VP_INDEX_WELCOME,
    VP_INDEX_CES_ON,
    VP_INDEX_CES_OFF,
    VP_INDEX_CES_FINISHED,
    VP_INDEX_CES_GEAR1,
    VP_INDEX_CES_GEAR2,
    VP_INDEX_CES_GEAR3,
    VP_INDEX_CES_GEAR4,
    VP_INDEX_CES_GEAR5,
    VP_INDEX_CES_GEAR6,
    VP_INDEX_CES_GEAR7,
    VP_INDEX_CES_GEAR8,
    VP_INDEX_CES_GEAR9,
    VP_INDEX_CES_GEAR10,
    VP_INDEX_CES_GEAR11,
    VP_INDEX_CES_GEAR12,
    VP_INDEX_MODE1,
    VP_INDEX_MODE2,
    VP_INDEX_MODE3,
    VP_INDEX_MODE4,
    VP_INDEX_MUTE,
    VP_INDEX_MUSIC_ON,
    VP_INDEX_MUSIC_OFF,
    VP_INDEX_CHARGING,
    VP_INDEX_LOW_BATTERY,
};

#endif /* __APPS_CONFIG_APPS_CONFIG_VP_INDEX_LIST_H__ */
