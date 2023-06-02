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


#include "hal.h"
#ifdef HAL_PMU_MODULE_ENABLED
#include "hal_pmu_ab2565_platform.h"
#include "hal_pmu_auxadc_2565.h"
#include "hal_pmu_charger_2565.h"
#include "hal_pmu_internal_2565.h"
#include "hal_hw_semaphore.h"

#include "assert.h"
#include <string.h>

#define AUXADC_RDY1_TO_US    10000
#define AUXADC_BUSY_TO_US    200
#define AUXADC_RDY2_TO_US    10000
#define HW_SEMAPHORE_PMU     11
#define AUXADC_CHK_CNT_THRD  20

extern uint8_t pmu_off_flag;

uint16_t vbat_val = 0, vbat_cnt = 0, vchg_val = 0, vchg_cnt = 0, adc_sta = 0;

void pmu_auxadc_init(void) {
    pmu_set_register_value_lp(ADC_AVG0_ADDR, ADC_AVG0_MASK, ADC_AVG0_SHIFT, 0x3);
    pmu_set_register_value_lp(ADC_CH_EN_ADDR, ADC_CH_EN_MASK, ADC_CH_EN_SHIFT, 0x6);//enable vbat, vchg
    pmu_set_register_value_lp(ADC_ONE_SHOT_START_ADDR, ADC_ONE_SHOT_START_MASK, ADC_ONE_SHOT_START_SHIFT, 1);//set ready bit
}

uint32_t pmu_auxadc_get_channel_value(pmu_adc_channel_t Channel)
{
    uint16_t adc_val = 0, err_sta = 0, rg_418 = 0, total_cnt = 0;
    uint32_t ts = 0, t1 = 0, t2 = 0;

#ifdef HAL_HW_SEMAPHORE_MODULE_ENABLED
    if(hal_hw_semaphore_take(HW_SEMAPHORE_PMU)==HAL_HW_SEMAPHORE_STATUS_OK){
#endif
        hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &ts);
        while(1) {
            if (pmu_get_register_value_lp(ADC_RDY_STS0_ADDR, ADC_RDY_STS0_MASK, ADC_RDY_STS0_SHIFT)) {
                break;
            } else {
                hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &t2);
                if (t2 - ts > AUXADC_RDY1_TO_US) {
                    err_sta |= 1;
                    break;
                }
            }
        }
        pmu_set_register_value_lp(ADC_ONE_SHOT_START_ADDR, ADC_ONE_SHOT_START_MASK, ADC_ONE_SHOT_START_SHIFT, 1);

        hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &t1);
        while(1) {
            if (pmu_get_register_value_lp(ADC_RDY_STS0_ADDR, ADC_RDY_STS0_MASK, ADC_RDY_STS0_SHIFT)) {
                hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &t2);
                if (t2 - t1 > AUXADC_BUSY_TO_US) {
                    err_sta |= 2;
                    break;
                }
            } else {
                break;
            }
        }

        hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &t1);
        while(1) {
            if (pmu_get_register_value_lp(ADC_RDY_STS0_ADDR, ADC_RDY_STS0_MASK, ADC_RDY_STS0_SHIFT)) {
                break;
            } else {
                hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &t2);
                if (t2 - t1 > AUXADC_RDY2_TO_US) {
                    err_sta |= 4;
                    break;
                }
            }
        }
        rg_418 = pmu_get_register_value_lp(0x418, 0xFFFF, 0);
#ifdef HAL_HW_SEMAPHORE_MODULE_ENABLED
        if(HAL_HW_SEMAPHORE_STATUS_OK !=hal_hw_semaphore_give(HW_SEMAPHORE_PMU)) {
                log_hal_msgid_error("[PMU_ADC]HW Semaphore give failed", 0);
        }
    }
#endif
    hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &t2);
    switch(Channel) {
        case PMU_AUX_VBAT:
#ifndef AIR_PMU_DISABLE_CHARGER
            adc_val = pmu_bat_adc_to_volt(pmu_get_register_value_lp(ADC_VALUE1_ADDR, ADC_VALUE1_MASK, ADC_VALUE1_SHIFT));
#endif
            log_hal_msgid_info("[PMU_ADC]vbat[%d], err_sta[0x%X], time[%dus], rg_418[0x%X]", 4,
                               adc_val, err_sta, (t2 - ts), rg_418);
            break;

        case PMU_AUX_VCHG:
#ifndef AIR_PMU_DISABLE_CHARGER
            adc_val = pmu_chg_vchg_to_volt(pmu_get_register_value_lp(ADC_VALUE2_ADDR, ADC_VALUE2_MASK, ADC_VALUE2_SHIFT));
#endif
            log_hal_msgid_info("[PMU_ADC]vchg[%d], err_sta[0x%X], time[%dus], rg_418[0x%X]", 4,
                               adc_val, err_sta, (t2 - ts), rg_418);
            break;

        default:
            break;
    }

    if (adc_sta != rg_418) {
        vbat_cnt = 0;
        vchg_cnt = 0;
    }
    adc_sta = rg_418;

    if (Channel == PMU_AUX_VBAT) {
        if ((adc_val == vbat_val) && (err_sta) && (rg_418)) {
            vbat_cnt++;
        } else {
            vbat_cnt = 0;
            vchg_cnt = 0;
        }
        vbat_val = adc_val;
    }
    else if (Channel == PMU_AUX_VCHG) {
        if ((adc_val == vchg_val) && (err_sta) && (rg_418)) {
            vchg_cnt++;
        } else {
            vbat_cnt = 0;
            vchg_cnt = 0;
        }
        vchg_val = adc_val;
    }

    total_cnt = vbat_cnt + vchg_cnt;
    /*if (total_cnt)
    {
        log_hal_msgid_info("[PMU_ADC]chk, err_sta[%d], rg_418[0x%X], vbat_val[%d], vchg_val[%d], vbat_cnt[%d], vchg_cnt[%d]", 6,
                    err_sta, rg_418, vbat_val, vchg_val, vbat_cnt, vchg_cnt);
    }*/
    if (total_cnt > AUXADC_CHK_CNT_THRD)
    {
        log_hal_msgid_error("[PMU_ADC]auxadc fail", 0);
        vbat_cnt = 0;
        vchg_cnt = 0;
        pmu_off_flag = 1;
        pmu_enable_charger_lp(PMU_OFF);
    }

    return adc_val;
}
#endif
