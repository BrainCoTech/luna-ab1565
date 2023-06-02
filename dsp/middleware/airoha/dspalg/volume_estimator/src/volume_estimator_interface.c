/* Copyright Statement:
 *
 * (C) 2021  Airoha Technology Corp. All rights reserved.
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

#if defined(AIR_VOLUME_ESTIMATOR_ENABLE)

/* Includes ------------------------------------------------------------------*/
#include "dsp_feature_interface.h"
#include "dsp_audio_process.h"
#include "volume_estimator_interface.h"
#include "volume_estimator_portable.h"
#include "dsp_dump.h"
#include "memory_attribute.h"
#include "preloader_pisplit.h"

/* Private define ------------------------------------------------------------*/
/* Private typedef -----------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
static volume_estimator_port_t volume_estimator_port[VOLUME_ESTIMATOR_PORT_MAX];

/* Public variables ----------------------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
static int32_t volume_estimator_covert_sample_rate_to_mode(uint32_t sample_rate)
{
    int32_t mode = 0;

    switch (sample_rate)
    {
        case 16000:
            mode = 0;
            break;

        case 32000:
            mode = 1;
            break;

        case 48000:
            mode = 2;
            break;

        case 96000:
            mode = 3;
            break;

        case 192000:
            mode = 4;
            break;

        default:
            AUDIO_ASSERT(0);
            break;
    }

    return mode;
}

/* Public functions ----------------------------------------------------------*/
ATTR_TEXT_IN_RAM_FOR_MASK_IRQ volume_estimator_port_t *volume_estimator_get_port(void *owner)
{
    int32_t i;
    volume_estimator_port_t *port = NULL;
    uint32_t saved_mask;

    /* Find out a port for this owner */
    hal_nvic_save_and_set_interrupt_mask(&saved_mask);
    for (i = VOLUME_ESTIMATOR_PORT_MAX - 1; i >= 0; i--) {
        /* Check if there is unused port */
        if (volume_estimator_port[i].owner == NULL) {
            port = &volume_estimator_port[i];
            continue;
        }

        /* Check if this owner has already owned a afc */
        if (volume_estimator_port[i].owner == owner) {
            port = &volume_estimator_port[i];
            break;
        }
    }
    hal_nvic_restore_interrupt_mask(saved_mask);

    if (port == NULL) {
        AUDIO_ASSERT(0 && "[VOL] Port not enough!");
        return port;
    }

    port->owner = owner;

    return port;
}

volume_estimator_status_t volume_estimator_init(volume_estimator_port_t *port, volume_estimator_config_t *config)
{
    /* check port */
    if (port == NULL) {
        AUDIO_ASSERT(0 && "[VOL] Port is NULL!");
        return VOLUME_ESTIMATOR_STATUS_ERROR;
    }

    /* check status */
    if (port->status != VOLUME_ESTIMATOR_PORT_STATUS_DEINIT) {
        DSP_MW_LOG_E("[VOL] status is error, %d!", 1, port->status);
        AUDIO_ASSERT(0);
        return VOLUME_ESTIMATOR_STATUS_ERROR;
    }

    /* config setting */
    port->channel_num   = config->channel_num;
    if (config->resolution != RESOLUTION_32BIT) {
        DSP_MW_LOG_E("[VOL] resolution is not supported, %d!", 1, config->resolution);
        AUDIO_ASSERT(0);
        return VOLUME_ESTIMATOR_STATUS_ERROR;
    }
    port->resolution    = config->resolution;
    if (config->mode >= VOLUME_ESTIMATOR_MODE_MAX) {
        DSP_MW_LOG_E("[VOL] mode is not supported, %d!", 1, config->mode);
        AUDIO_ASSERT(0);
        return VOLUME_ESTIMATOR_STATUS_ERROR;
    }
    port->mode          = config->mode;
    port->sample_rate   = config->sample_rate;
    if (config->frame_size != (config->sample_rate/1000*sizeof(int32_t)*5/2))
    {
        DSP_MW_LOG_E("[VOL] frame size is not supported, %d, %d!", 2, config->frame_size, config->sample_rate);
        AUDIO_ASSERT(0);
        return VOLUME_ESTIMATOR_STATUS_ERROR;
    }
    port->frame_size    = config->frame_size;
    if (config->nvkey_para == NULL) {
        AUDIO_ASSERT(0 && "[VOL] nvkey para is NULL!");
        return VOLUME_ESTIMATOR_STATUS_ERROR;
    }
    port->nvkey_para    = config->nvkey_para;
    port->status        = VOLUME_ESTIMATOR_PORT_STATUS_INIT;

    return VOLUME_ESTIMATOR_STATUS_OK;
}

volume_estimator_status_t volume_estimator_deinit(volume_estimator_port_t *port)
{
    /* check port */
    if (port == NULL) {
        DSP_MW_LOG_E("[VOL] Port is NULL!", 0);
        return VOLUME_ESTIMATOR_STATUS_ERROR;
    }

    /* check status */
    if ((port->status != VOLUME_ESTIMATOR_PORT_STATUS_INIT) && (port->status != VOLUME_ESTIMATOR_PORT_STATUS_RUNNING)) {
        DSP_MW_LOG_E("[VOL] status is error, %d!", 1, port->status);
        return VOLUME_ESTIMATOR_STATUS_ERROR;
    }

    /* config setting */
    port->status        = VOLUME_ESTIMATOR_PORT_STATUS_DEINIT;
    port->channel_num   = 0;
    port->frame_size    = 0;
    port->resolution    = 0;
    port->mode          = 0;
    port->sample_rate   = 0;
    port->nvkey_para    = NULL;

    /* free working memory */
    if (port->handle) {
        preloader_pisplit_free_memory(port->handle);
    }
    port->handle = NULL;
    port->owner = NULL;

    return VOLUME_ESTIMATOR_STATUS_OK;
}

volume_estimator_status_t volume_estimator_process(volume_estimator_port_t *port, void *data_buf, uint32_t data_size, int32_t *out_db)
{
    int mem_size;
    int out_data;
    uint32_t i;
    void *handle;

    /* check parameters */
    if ((port == NULL) || (data_buf == NULL)) {
        DSP_MW_LOG_E("[VOL] Port or data is NULL!", 0);
        return VOLUME_ESTIMATOR_STATUS_ERROR;
    }
    if (data_size != port->frame_size*port->channel_num) {
        DSP_MW_LOG_E("[VOL] data size is not right, %d, %d!", 2, port->frame_size*port->channel_num, data_size);
        return VOLUME_ESTIMATOR_STATUS_ERROR;
    }

    if (port->status == VOLUME_ESTIMATOR_PORT_STATUS_INIT) {
        /* get working memory */
        mem_size = get_chat_vol_memsize();
        port->handle = preloader_pisplit_malloc_memory(PRELOADER_D_HIGH_PERFORMANCE, port->channel_num*mem_size);
        if (port->handle == NULL) {
            AUDIO_ASSERT(0);
        }
        port->mem_size = mem_size;

        /* feature init */
        for (i = 0; i < port->channel_num; i++)
        {
            handle = (void *)((uint8_t *)(port->handle) + i*port->mem_size);
            chat_vol_init(handle, port->nvkey_para, volume_estimator_covert_sample_rate_to_mode(port->sample_rate), 1);
            DSP_MW_LOG_I("[VOL] vol init done, 0x%x, %d!", 2, handle, volume_estimator_covert_sample_rate_to_mode(port->sample_rate));
        }

        port->status = VOLUME_ESTIMATOR_PORT_STATUS_RUNNING;
    }

    for (i = 0; i < port->channel_num; i++)
    {
        /* get handle */
        handle = (void *)((uint8_t *)(port->handle) + i*port->mem_size);

        /* process data */
        switch (port->mode) {
            case VOLUME_ESTIMATOR_CHAT_NORMAL_MODE:
                out_data = chat_vol_prcs((int32_t *)((uint32_t)data_buf+port->frame_size*i), handle);
                out_db[i] = out_data * 100 / 256;
                break;

            case VOLUME_ESTIMATOR_CHAT_INSTANT_MODE:
                out_data = chat_vol_prcs_instant((int32_t *)((uint32_t)data_buf+port->frame_size*i), handle);
                out_db[i] = out_data * 100 / 256;
                break;

            default:
                AUDIO_ASSERT(0);
                break;
        }
    }

    return VOLUME_ESTIMATOR_STATUS_OK;
}

#endif /* AIR_VOLUME_ESTIMATOR_ENABLE */
