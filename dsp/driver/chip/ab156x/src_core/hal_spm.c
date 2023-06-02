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

#include "hal_spm.h"

#ifdef HAL_SLEEP_MANAGER_ENABLED

#include <stdio.h>
#include <string.h>
#include "memory_attribute.h"
#include "hal_platform.h"
#include "hal_log.h"

log_create_module(SPM, PRINT_LEVEL_INFO);
#define SPM_LOG_I(fmt,cnt,arg...)          LOG_I(SPM,fmt,cnt,##arg)
#define SPM_LOG_W(fmt,cnt,arg...)          LOG_W(SPM,fmt,cnt,##arg)
#define SPM_LOG_E(fmt,cnt,arg...)          LOG_E(SPM,fmt,cnt,##arg)
#define SPM_MSGID_I(fmt,cnt,arg...)        LOG_MSGID_I(SPM,fmt,cnt,##arg)
#define SPM_MSGID_W(fmt,cnt,arg...)        LOG_MSGID_W(SPM,fmt,cnt,##arg)
#define SPM_MSGID_E(fmt,cnt,arg...)        LOG_MSGID_E(SPM,fmt,cnt,##arg)

static int hw_latency_time_32k;

void spm_irq_handler()
{
    SPM_SET_DSP0_SW_STATE(0xF);
    *SPM_PCM_SW_INT_CLEAR_DSP = 1;
}

int spm_init(void)
{
    int result = 0;
    hal_nvic_register_isr_handler(SPM_IRQn, spm_irq_handler);
    hal_nvic_enable_irq(SPM_IRQn);

    hw_latency_time_32k = spm_latency_time_checking(); //SPM Latency Time
    //hw_latency_time_ms = (uint32_t)((((float)hw_latency_time_32k) * (1/32.768))) + 1;

    return(result);
}

int spm_latency_time_checking(void)
{
    int latency_time_32k;
    //float hw_buffer_time = 1; //ms
    float hw_buffer_time_32k = 0;
    //float hw_buffer_time_freq = 32.768;

    uint32_t xo_en_delay, osc_en_delay, pmu_en_delay, en_delay_max;

    uint32_t latency_time_check;
    uint32_t latency_time_error = 0xFFFFFFFF;

    osc_en_delay = ((*SPM_SEQUENCER_32K_REG_3 >> 0) & 0xFF);
    pmu_en_delay = ((*SPM_SEQUENCER_32K_REG_3 >> 8) & 0xFF);
    xo_en_delay = ((*SPM_SEQUENCER_32K_REG_3 >> 16) & 0xFF);
    en_delay_max = osc_en_delay;

    if(pmu_en_delay >= en_delay_max){
        en_delay_max = pmu_en_delay;
    }else if(xo_en_delay >= en_delay_max){
        en_delay_max = xo_en_delay;
    }

    //hw_buffer_time_32k = (hw_buffer_time / (1 / (hw_buffer_time_freq)));

    latency_time_check = (*SPM_SEQUENCER_32K_REG_1 + *SPM_SEQUENCER_32K_REG_2 + en_delay_max + *SPM_SEQUENCER_32K_REG_4);
    latency_time_32k = ((int)latency_time_check + (int)hw_buffer_time_32k);

    /* latency_time_check overflow check */
    if(latency_time_check < *SPM_SEQUENCER_32K_REG_1 || latency_time_check < *SPM_SEQUENCER_32K_REG_2 || latency_time_check < en_delay_max || latency_time_check < *SPM_SEQUENCER_32K_REG_4){
        SPM_MSGID_E("spm_latency_time_checking is error!!!", 0);

        return(latency_time_error);
    }

    SPM_MSGID_I("[SLP] SPM_SEQUENCER_32K_REG is 0x%08x, 0x%08x, 0x%08x, 0x%08x, latency_time_32k is %d", 5, 
                *SPM_SEQUENCER_32K_REG_1,
                *SPM_SEQUENCER_32K_REG_2,
                *SPM_SEQUENCER_32K_REG_3,
                *SPM_SEQUENCER_32K_REG_4,
                latency_time_32k
               );

    return(latency_time_32k);
}

void spm_mask_wakeup_source(uint32_t wakeup_source)
{
    if (wakeup_source == HAL_SLEEP_MANAGER_WAKEUP_SOURCE_ALL) {
        *SPM_DSP_WAKEUP_SOURCE_MASK = 0xFF;
    } else {
        *SPM_DSP_WAKEUP_SOURCE_MASK |= (1 << wakeup_source);
    }
}

void spm_unmask_wakeup_source(uint32_t wakeup_source)
{
    if (wakeup_source == HAL_SLEEP_MANAGER_WAKEUP_SOURCE_ALL) {
        *SPM_DSP_WAKEUP_SOURCE_MASK = 0x00;
    } else {
        *SPM_DSP_WAKEUP_SOURCE_MASK &= ~(1 << wakeup_source);
    }
}

#if SPM_FPGA_DVT
void spm_dvt_dsp_basic_configuration()
{
    uint32_t i, err_cnt = 0;

    //1.SPM_DSP_WAKEUP_SOURCE_MASK
    for (i = 0; i < 0x3FFF + 1; i++) {
        *SPM_DSP_WAKEUP_SOURCE_MASK = i;
        if (*SPM_DSP_WAKEUP_SOURCE_MASK != i) {
            err_cnt++;
        }
    }
    if (err_cnt == 0) {

    } else {
        log_hal_msgid_error("SPM_DSP_WAKEUP_SOURCE_MASK : RW Fail %d!!!!!!!!\r\n", 1, err_cnt);
    }

    //2.SPM_DSP1_WAKEUP_SOURCE_MASK
    err_cnt = 0;
    for (i = 0; i < 0x3FFF + 1; i++) {
        *SPM_DSP1_WAKEUP_SOURCE_MASK = i;
        if (*SPM_DSP1_WAKEUP_SOURCE_MASK != i) {
            err_cnt++;
        }
    }
    if (err_cnt == 0) {

    } else {
        log_hal_msgid_error("SPM_DSP1_WAKEUP_SOURCE_MASK : RW Fail %d!!!!!!!!\r\n", 1, err_cnt);
    }

    //3.SPM_CM4_WAKEUP_SOURCE_MASK
    err_cnt = 0;
    for (i = 0; i < 0x3FFF + 1; i++) {
        *SPM_CM4_WAKEUP_SOURCE_MASK = i;
        if (*SPM_CM4_WAKEUP_SOURCE_MASK != i) {
            err_cnt++;
        }
    }
    if (err_cnt == 0) {

    } else {
        log_hal_msgid_error("SPM_CM4_WAKEUP_SOURCE_MASK : RW Fail %d!!!!!!!!\r\n", 1, err_cnt);
    }

    //4.SPM_AUDIO_I2S_WAKEUP_SOURCE_MASK
    err_cnt = 0;
    for (i = 0; i < 0x7; i++) {
        *SPM_AUDIO_I2S_WAKEUP_SOURCE_MASK = i;
        if (*SPM_AUDIO_I2S_WAKEUP_SOURCE_MASK != i) {
            err_cnt++;
        }
    }
    if (err_cnt == 0) {

    } else {
        log_hal_msgid_error("SPM_AUDIO_I2S_WAKEUP_SOURCE_MASK : RW Fail %d!!!!!!!!\r\n", 1, err_cnt);
    }

    //5.DSP0_DEEP_SLEEP
    err_cnt = 0;
    *DSP0_DEEP_SLEEP = 1;
    if (*DSP0_DEEP_SLEEP != 1) {
        err_cnt++;
    }
    *DSP0_DEEP_SLEEP = 0;
    if (*DSP0_DEEP_SLEEP != 0) {
        err_cnt++;
    }
    if (err_cnt == 0) {

    } else {
        log_hal_msgid_error("DSP0_DEEP_SLEEP : RW Fail %d!!!!!!!!\r\n", 1, err_cnt);
    }

    //6.DSP1_DEEP_SLEEP
    err_cnt = 0;
    *DSP1_DEEP_SLEEP = 1;
    if (*DSP1_DEEP_SLEEP != 1) {
        err_cnt++;
    }
    *DSP1_DEEP_SLEEP = 0;
    if (*DSP1_DEEP_SLEEP != 0) {
        err_cnt++;
    }
    if (err_cnt == 0) {

    } else {
        log_hal_msgid_error("DSP1_DEEP_SLEEP : RW Fail %d!!!!!!!!\r\n", 1, err_cnt);
    }

    //7.SPM_DSP0_DRAM_CONTROL_0
    err_cnt = 0;
    *SPM_DSP0_DRAM_CONTROL_0 = 1;
    if (*SPM_DSP0_DRAM_CONTROL_0 != 1) {
        err_cnt++;
    }
    *SPM_DSP0_DRAM_CONTROL_0 = 0;
    if (*SPM_DSP0_DRAM_CONTROL_0 != 0) {
        err_cnt++;
    }
    if (err_cnt == 0) {

    } else {
        log_hal_msgid_error("SPM_DSP0_DRAM_CONTROL_0 : RW Fail %d!!!!!!!!\r\n", 1, err_cnt);
    }

    //8.SPM_DSP0_IRAM_CONTROL_0
    err_cnt = 0;
    *SPM_DSP0_IRAM_CONTROL_0 = 1;
    if (*SPM_DSP0_IRAM_CONTROL_0 != 1) {
        err_cnt++;
    }
    *SPM_DSP0_IRAM_CONTROL_0 = 0;
    if (*SPM_DSP0_IRAM_CONTROL_0 != 0) {
        err_cnt++;
    }
    if (err_cnt == 0) {

    } else {
        log_hal_msgid_error("SPM_DSP0_IRAM_CONTROL_0 : RW Fail %d!!!!!!!!\r\n", 1, err_cnt);
    }

    //9.SPM_DSP1_DRAM_CONTROL_0
    err_cnt = 0;
    *SPM_DSP1_DRAM_CONTROL_0 = 1;
    if (*SPM_DSP1_DRAM_CONTROL_0 != 1) {
        err_cnt++;
    }
    *SPM_DSP1_DRAM_CONTROL_0 = 0;
    if (*SPM_DSP1_DRAM_CONTROL_0 != 0) {
        err_cnt++;
    }
    if (err_cnt == 0) {

    } else {
        log_hal_msgid_error("SPM_DSP1_DRAM_CONTROL_0 : RW Fail %d!!!!!!!!\r\n", 1, err_cnt);
    }

    //10.SPM_DSP1_IRAM_CONTROL_0
    err_cnt = 0;
    *SPM_DSP1_IRAM_CONTROL_0 = 1;
    if (*SPM_DSP1_IRAM_CONTROL_0 != 1) {
        err_cnt++;
    }
    *SPM_DSP1_IRAM_CONTROL_0 = 0;
    if (*SPM_DSP1_IRAM_CONTROL_0 != 0) {
        err_cnt++;
    }
    if (err_cnt == 0) {

    } else {
        log_hal_msgid_error("SPM_DSP1_IRAM_CONTROL_0 : RW Fail %d!!!!!!!!\r\n", 1, err_cnt);
    }
}
#endif

#endif
