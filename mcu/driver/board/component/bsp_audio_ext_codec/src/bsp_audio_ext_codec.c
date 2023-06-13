/* Copyright Statement:
 *
 * (C) 2020  Airoha Technology Corp. All rights reserved.
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
#include "bsp_audio_ext_codec.h"
#include "DA7212.h"

bsp_audio_ext_codec_status_t bsp_audio_ext_codec_adc_init(bsp_audio_ext_codec_type_t codec_type)
{
    //TODO
    return BSP_AUDIO_EXT_CODEC_STA_OK;
}

bsp_audio_ext_codec_status_t bsp_audio_ext_codec_adc_deinit(bsp_audio_ext_codec_type_t codec_type)
{
    //TODO
    return BSP_AUDIO_EXT_CODEC_STA_OK;
}
bsp_audio_ext_codec_status_t bsp_audio_ext_codec_adc_enable(bsp_audio_ext_codec_type_t codec_type)
{
    //TODO
    return BSP_AUDIO_EXT_CODEC_STA_OK;
}

bsp_audio_ext_codec_status_t bsp_audio_ext_codec_adc_disable(bsp_audio_ext_codec_type_t codec_type)
{
    //TODO
    return BSP_AUDIO_EXT_CODEC_STA_OK;
}

bsp_audio_ext_codec_status_t bsp_audio_ext_codec_dac_init(bsp_audio_ext_codec_type_t codec_type, bsp_audio_ext_codec_config_t *codec_config)
{
    switch (codec_type) {
        case BSP_AUDIO_EXT_CODEC_TYPE_DA7212:
            DA7212_dac_init();
            break;
        default:
            log_hal_msgid_info("[BSP_AUDIO_EX_CODEC] codec type error", 0);
            break;
    }
    return BSP_AUDIO_EXT_CODEC_STA_OK;
}

bsp_audio_ext_codec_status_t bsp_audio_ext_codec_dac_deinit(bsp_audio_ext_codec_type_t codec_type)
{
    switch (codec_type) {
        case BSP_AUDIO_EXT_CODEC_TYPE_DA7212:
            DA7212_dac_deinit();
            break;
        default:
            log_hal_msgid_info("[BSP_AUDIO_EX_CODEC] codec type error", 0);
            break;
    }
    return BSP_AUDIO_EXT_CODEC_STA_OK;
}

bsp_audio_ext_codec_status_t bsp_audio_ext_codec_dac_enable(bsp_audio_ext_codec_type_t codec_type)
{
    switch (codec_type) {
        case BSP_AUDIO_EXT_CODEC_TYPE_DA7212:
            DA7212_dac_enable();
            break;
        default:
            log_hal_msgid_info("[BSP_AUDIO_EX_CODEC] codec type error", 0);
            break;
    }
    return BSP_AUDIO_EXT_CODEC_STA_OK;
}

bsp_audio_ext_codec_status_t bsp_audio_ext_codec_dac_disable(bsp_audio_ext_codec_type_t codec_type)
{
    switch (codec_type) {
        case BSP_AUDIO_EXT_CODEC_TYPE_DA7212:
            DA7212_dac_disable();
            break;
        default:
            log_hal_msgid_info("[BSP_AUDIO_EX_CODEC] codec type error", 0);
            break;
    }
    return BSP_AUDIO_EXT_CODEC_STA_OK;
}

/*internal test function*/

