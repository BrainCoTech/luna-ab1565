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
#include "hal_pmu_cali_2565.h"

#include "hal_usb.h"
#include "hal_usb_internal.h"
#include "hal_sleep_manager_platform.h"
#include "hal_sleep_manager_internal.h"
#include "nvkey_id_list.h"
#include "assert.h"
#include <stdio.h>
#include <string.h>

#define UNUSED(x)  ((void)(x))
#define EOC_EN         (1<<12)
#define CHGFLO_B_DEB   (1<<13)
#define CHG_PLUG_DEB   (1<<11)
#define CHGFLO_B_E2    (1<<1)
#define CHG_PLUG_E2    (1<<0)
#define CHG_DBG_CHK     1

#define CHG_INT_NONE         (0)
#define CHG_INT_IN           (1<<0)
#define CHG_INT_OUT          (1<<1)
#define CHG_INT_COMPL        (1<<2)
#define CHG_INT_RECHG        (1<<3)

#define CHG_GAUGE_EN    0

#define NTC_R2_ACC           10000
#define AUXADC_ANA_CON0      0xA2070400

#define NTC_SLT_1V4          1400
#define NTC_SLT_MIN_RES      9700
#define NTC_SLT_MAX_RES      10300

#define hal_ntc_sfr_write(addr, data)    ((*(volatile uint32_t *)(addr)) = (uint16_t)(data))
#define hal_ntc_sfr_read(addr)           (*(volatile uint32_t *)(addr))

#define VBAT_RSEL            1
#define W1T_TIMEOUT_US       10000

#define SAFETY_TIMER_TIMEOUT 4

uint8_t pmu_charger_type; /*DATA : restore charger type*/
pmu_chg_info_t pmu_chg_info;
chg_adc_cfg_t pmu_chg_adc;
uint32_t chg_safety_timer;

uint8_t chg_int_flag = 0;
uint8_t safety_timer_flag = 0;
uint8_t pmu_off_flag = 0;
uint8_t pmu_1wire_2pins_exist = 0;

pmu_chg_rsel_t chg_rsel;

jeita_cfg_t pmu_chg_jeita_warm, pmu_chg_jeita_cool;
chg_dac_cfg_t pmu_chg_dac;
cv_stop_curr_cfg_t pmu_chg_cv_stop_curr;

pmu_ntc_cfg1_t ntc_cfg1;
pmu_ntc_cfg2_t ntc_cfg2;
pmu_ntc_temp_t ntc_temp;
pmu_ntc_res_t ntc_res;
pmu_ntc_r2_t ntc_r2;
pmu_ntc_ratio_t ntc_ratio;
uint8_t g_ntc_state = PMU_NTC_NORM;

extern int32_t pmu_round(int32_t val1, int32_t val2);
extern void captouch_set_vbus_flag(bool is_chgin);
extern bat_cfg_t bat_cfg;

/*==========[Basic function]==========*/
#if (CHG_DBG_CHK)
uint32_t chg_chk_timer;
void pmu_chg_timer_cb(void *user_data)
{
    UNUSED(user_data);
    pmu_auxadc_get_channel_value(PMU_AUX_VCHG);
    log_hal_msgid_info("[PMU_CHG]chg_timer_cb, rg_320[0x%X], rg_322[0x%X], rg_606[0x%X], rg_608[0x%X], rg_60A[0x%X]", 5,
    pmu_get_register_value_lp(0x320, 0xFFFF, 0), pmu_get_register_value_lp(0x322, 0xFFFF, 0), pmu_get_register_value_lp(0x606, 0xFFFF, 0),
    pmu_get_register_value_lp(0x608, 0xFFFF, 0), pmu_get_register_value_lp(0x60A, 0xFFFF, 0));
    pmu_bat_3v3_proc();

    hal_gpt_sw_start_timer_ms(chg_chk_timer, 5000,
                              (hal_gpt_callback_t)pmu_chg_timer_cb, NULL);
}
#endif

void pmu_chg_init(void)
{
    //log_hal_msgid_info("[PMU_CHG]chg_init", 0);
    pmu_set_register_value_lp(FULL_BAT_THRESHOLD1_ADDR, FULL_BAT_THRESHOLD1_MASK, FULL_BAT_THRESHOLD1_SHIFT, 0x3FF);
    pmu_set_register_value_lp(FULL_BAT_THRESHOLD2_ADDR, FULL_BAT_THRESHOLD2_MASK, FULL_BAT_THRESHOLD2_SHIFT, 0x3FF);
    pmu_set_register_value_lp(BYP_CV_CHK_VBAT_ADDR, BYP_CV_CHK_VBAT_MASK, BYP_CV_CHK_VBAT_SHIFT, 0x1);
    pmu_set_register_value_lp(CHG_COMPLETE_CHK_NUM_ADDR, CHG_COMPLETE_CHK_NUM_MASK, CHG_COMPLETE_CHK_NUM_SHIFT, 0x9);

    pmu_chg_deb_time(CHG_OUT_DEB_0MS, CHG_IN_DEB_40MS);

    hal_gpt_status_t gpt_status = hal_gpt_sw_get_timer(&chg_safety_timer);
    if (gpt_status != HAL_GPT_STATUS_OK) {
        log_hal_msgid_error("[PMU_CHG]chg_init, chg_safety_timer fail, gpt_status[%d]", 1, gpt_status);
    }
    pmu_chg_pfm_ctl();

#if (CHG_DBG_CHK)
    gpt_status = hal_gpt_sw_get_timer(&chg_chk_timer);
    if (gpt_status == HAL_GPT_STATUS_OK) {
        hal_gpt_sw_start_timer_ms(chg_chk_timer, 5000,
                                  (hal_gpt_callback_t)pmu_chg_timer_cb, NULL);
    } else {
        log_hal_msgid_error("[PMU_CHG]chg_init, chg_chk_timer fail, gpt_status[%d]", 1, gpt_status);
    }
#endif
}

/*==========[charger]==========*/
uint8_t pmu_enable_charger_lp(uint8_t en)
{
    uint8_t value = en;
#ifdef AIR_PMU_DISABLE_CHARGER
    log_hal_msgid_info("[PMU_CHG]enable_charger, bypass for dongle", 0);
#else
    if (en) {
        bool chg_exist = pmu_get_chr_detect_value_lp();
        if ((g_ntc_state <= PMU_NTC_COOL) && (!safety_timer_flag) && (chg_exist) && (!pmu_off_flag)) {
            pmu_set_register_value_lp(CHG_FORCE_OFF_ADDR, CHG_FORCE_OFF_MASK, CHG_FORCE_OFF_SHIFT, 0);
        } else {
            log_hal_msgid_error("[PMU_CHG]enable_charger, bypass, ntc_state[%d], safety_timer_flag[%d], chg_exist[%d], pmu_off_flag[%d]", 4,
                                  g_ntc_state, safety_timer_flag, chg_exist, pmu_off_flag);
            return 0;
        }
    } else {
        pmu_set_register_value_lp(CHG_FORCE_OFF_ADDR, CHG_FORCE_OFF_MASK, CHG_FORCE_OFF_SHIFT, 1);
    }
    log_hal_msgid_info("[PMU_CHG]enable_charger, en[%d]", 1, en);
#endif
    return value;
}

pmu_operate_status_t pmu_chg_deb_time(pmu_chg_deb_time_t out_deb_time, pmu_chg_deb_time_t in_deb_time)
{
    uint16_t reg_320, deb_time;

    deb_time = (out_deb_time << 10) + (in_deb_time << 8);
    reg_320 = pmu_get_register_value_lp(CHARGER_CON1, 0xFFFF, 0);
    reg_320 &= 0x10AA;
    reg_320 |= deb_time;
    pmu_force_set_register_value_lp(CHARGER_CON1, reg_320);

    return PMU_OK;
}

bool pmu_get_chr_detect_value_lp(void)
{
    uint16_t rg_chg, result = 0;
    uint16_t rg_320 = pmu_get_register_value_lp(CHARGER_CON1, 0xFFFF, 0);

    if ((adie_version == PMU_ECO3) || (adie_version == PMU_NO_FTK))
    {
        rg_chg = pmu_get_register_value_lp(PMU_TEST5, 0xFFFF, 0);
        if (rg_320 & EOC_EN)
            result = rg_chg & CHGFLO_B_DEB;
        else
            result = rg_chg & CHG_PLUG_DEB;
    }
    else
    {
        rg_chg = pmu_get_register_value_lp(PMU_TEST2, 0xFFFF, 0);
        if (rg_320 & EOC_EN)
            result = rg_chg & CHGFLO_B_E2;
        else
            result = rg_chg & CHG_PLUG_E2;
    }

    if (result)
        return TRUE;
    else
        return FALSE;
}
#ifndef AIR_PMU_DISABLE_CHARGER
uint16_t pmu_get_charger_state_lp(void)
{
    return pmu_get_register_value_lp(CHG_STATE_ADDR, CHG_STATE_MASK, CHG_STATE_SHIFT);
}

bool pmu_chg_is_compl(void)
{
    if (pmu_get_charger_state_lp() == CHG_COMPL)
        return TRUE;
    else
        return FALSE;
}

void pmu_chg_safety_timer_cb(void *user_data)
{
    UNUSED(user_data);
    log_hal_msgid_info("[PMU_CHG]safety_timer_cb", 0);
    safety_timer_flag = 1;
    pmu_enable_charger_lp(PMU_OFF);
}

void pmu_chg_safety_timer_start(uint32_t timeout_hr)
{
    //log_hal_msgid_info("pmu_chg_safety_timer_start", 0);

    uint32_t timeout_ms = timeout_hr * 3600000;

    hal_gpt_sw_start_timer_ms(chg_safety_timer, timeout_ms,
        (hal_gpt_callback_t)pmu_chg_safety_timer_cb, NULL);
}

void pmu_chg_safety_timer_stop(void)
{
    //log_hal_msgid_info("pmu_chg_safety_timer_stop", 0);

    hal_gpt_sw_stop_timer_ms(chg_safety_timer);
}

void pmu_chg_in_hdlr(void)
{
    if (chg_int_flag & CHG_INT_IN)
    {
#ifdef HAL_CAPTOUCH_MODULE_ENABLED
        captouch_set_vbus_flag(true);
#endif
        log_hal_msgid_info("[PMU_CHG]chg_in, intr_flag[%x]", 1, chg_int_flag);

        if (pmu_function_table_lp[RG_INT_CHG_IN].pmu_callback)
            pmu_function_table_lp[RG_INT_CHG_IN].pmu_callback();

        pmu_enable_charger_lp(PMU_ON);
        pmu_chg_safety_timer_start(SAFETY_TIMER_TIMEOUT);
        pmu_chg_pfm_ctl();

        chg_int_flag &= (uint8_t)(~CHG_INT_IN);
    }

    if (chg_int_flag & CHG_INT_COMPL) {
        pmu_chg_compl_hdlr();
    } else if (chg_int_flag & CHG_INT_RECHG) {
        pmu_chg_rechg_hdlr();
    } else if (chg_int_flag & CHG_INT_OUT) {
        pmu_chg_out_hdlr();
    } else if (chg_int_flag) {
        //log_hal_msgid_error("[PMU_CHG]chg_in fail, flag[0x%X]", 1, chg_int_flag);
        assert(0);
    }
}

void pmu_chg_out_hdlr(void)
{
    uint32_t xLinkRegAddr = (uint32_t)__builtin_return_address(0);
    if (chg_int_flag & CHG_INT_OUT)
    {
#ifdef HAL_CAPTOUCH_MODULE_ENABLED
        captouch_set_vbus_flag(false);
#endif
        log_hal_msgid_info("[PMU_CHG]chg_out, flag[0x%X], caller:[0x%X]", 2, chg_int_flag, xLinkRegAddr);

        xLinkRegAddr += 1;


        if (pmu_function_table_lp[RG_INT_CHG_OUT].pmu_callback)
            pmu_function_table_lp[RG_INT_CHG_OUT].pmu_callback();

        pmu_enable_charger_lp(PMU_OFF);
        pmu_chg_safety_timer_stop();
        if (!pmu_1wire_2pins_exist) {
            pmu_chg_pfm_ctl();
        }
        if(pmu_off_flag) {
            log_hal_msgid_error("[PMU_CHG]chg_out, auxadc_hang, enter off_mode", 0);
            pmu_power_off_sequence(PMU_PWROFF);
        }

        chg_int_flag &= (uint8_t)(~CHG_INT_OUT);
    }

    if (chg_int_flag & CHG_INT_IN) {
        pmu_chg_in_hdlr();
    } else if (chg_int_flag) {
        //log_hal_msgid_error("[PMU_CHG]chg_out fail, flag[0x%X]", 1, chg_int_flag);
        assert(0);
    }
}

void pmu_chg_compl_hdlr(void)
{
    if (chg_int_flag & CHG_INT_COMPL)
    {
        log_hal_msgid_info("[PMU_CHG]chg_compl, intr_flag[%x]", 1, chg_int_flag);

        if (pmu_function_table_lp[RG_INT_CHG_COMPL].pmu_callback)
            pmu_function_table_lp[RG_INT_CHG_COMPL].pmu_callback();

        pmu_chg_safety_timer_stop();
    }

    chg_int_flag &= (uint8_t)(~CHG_INT_COMPL);

    if (chg_int_flag == CHG_INT_NONE)
        chg_int_flag = 0;
    else if (chg_int_flag & CHG_INT_RECHG)
        pmu_chg_rechg_hdlr();
    else if (chg_int_flag & CHG_INT_OUT)
        pmu_chg_out_hdlr();
    else
        assert(0);
}

void pmu_chg_rechg_hdlr(void)
{
    if (chg_int_flag & CHG_INT_RECHG)
    {
        log_hal_msgid_info("[PMU_CHG]chg_rechg, intr_flag[%x]", 1, chg_int_flag);

        if (pmu_function_table_lp[RG_INT_CHG_RECHG].pmu_callback)
            pmu_function_table_lp[RG_INT_CHG_RECHG].pmu_callback();

        pmu_chg_safety_timer_start(SAFETY_TIMER_TIMEOUT);
    }

    chg_int_flag &= (uint8_t)(~CHG_INT_RECHG);

    if (chg_int_flag == CHG_INT_NONE)
        chg_int_flag = 0;
    else if (chg_int_flag & CHG_INT_COMPL)
        pmu_chg_compl_hdlr();
    else if (chg_int_flag & CHG_INT_OUT)
        pmu_chg_out_hdlr();
    else
        assert(0);
}

void pmu_chg_hdlr(uint16_t chg_flag)
{
    if (chg_flag & (1 << CHG_IN_INT_FLAG))
    {
        chg_int_flag |= CHG_INT_IN;
    }
    if (chg_flag & (1 << CHG_OUT_INT_FLAG))
    {
        chg_int_flag |= CHG_INT_OUT;
    }
    if (chg_flag & (1 << CHG_COMPLETE_INT_FLAG))
    {
        chg_int_flag |= CHG_INT_COMPL;
    }
    if (chg_flag & (1 << CHG_RECHG_INT_FLAG))
    {
        chg_int_flag |= CHG_INT_RECHG;
    }
    //log_hal_msgid_info("[PMU_CHG]chg_handler, intr_flag[%x]", 1, chg_int_flag);

    if(pmu_get_chr_detect_value_lp())
    {
        if (chg_int_flag & CHG_INT_IN)
            pmu_chg_out_hdlr();
        else
            pmu_chg_compl_hdlr();
    }
    else
    {
        pmu_chg_in_hdlr();
    }
}

void pmu_chg_pfm_ctl(void)
{
#ifdef PMU_CHARGER_PFM_ENABLE
    uint16_t rg_10c = pmu_get_register_value_lp(0x10C, 0xFFFF, 0);
    bool chg_exist = pmu_get_chr_detect_value_lp();
    if (chg_exist) {
        rg_10c &= 0xFDFD;
    } else {
        rg_10c &= 0xFFFD;
        rg_10c |= 0x200;
    }
    pmu_force_set_register_value_lp(0x10C, rg_10c);
    log_hal_msgid_info("[PMU_CHG]pfm_ctl, chg_exist[%d], rg_10c[0x%X]", 2,
                       chg_exist, pmu_get_register_value(0x10C, 0xFFFF, 0));
#else
    log_hal_msgid_warning("[PMU_CHG]pfm_ctl, not support", 0);
#endif
}

void pmu_chg_rsel_ctl(pmu_chg_cc_state_t state)
{
    uint16_t cc1_rsel = 0, cc2_rsel = 0, cv_rsel = 0, chg_state = 0;
    uint32_t ts = 0, te = 0, addr = 0;

    cc1_rsel = chg_rsel.cc1[state];
    pmu_set_register_value_lp(CC1_RCHG_SEL_ADDR, CC1_RCHG_SEL_MASK, CC1_RCHG_SEL_SHIFT, cc1_rsel);
    cv_rsel = cc1_rsel;

    if (pmu_get_register_value_lp(CC2_EN_ADDR, CC2_EN_MASK, CC2_EN_SHIFT)) {
        cc2_rsel = chg_rsel.cc2[state];
        pmu_set_register_value_lp(CC2_RCHG_SEL_ADDR, CC2_RCHG_SEL_MASK, CC2_RCHG_SEL_SHIFT, cc2_rsel);
        cv_rsel = cc2_rsel;
    }
    pmu_set_register_value_lp(CV_RCHG_SEL_ADDR, CV_RCHG_SEL_MASK, CV_RCHG_SEL_SHIFT, cv_rsel);

    chg_state = pmu_get_register_value_lp(CHG_STATE_ADDR, CHG_STATE_MASK, CHG_STATE_SHIFT);

    if (chg_state == CHG_CC1) {
        addr = CC1_RCHG_SEL_UPDATE_ADDR;
    }
    else if (chg_state == CHG_CC2) {
        addr = CC2_RCHG_SEL_UPDATE_ADDR;
    }
    else if (chg_state == CHG_CV) {
        addr = CV_RCHG_SEL_UPDATE_ADDR;
    }
    if (addr)
    {
        pmu_set_register_value_lp(addr, 0x1, 15, 1);

        hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &ts);
        while (1) {
            if (!pmu_get_register_value_lp(addr, 0x1, 15)) {
                break;
            } else {
                hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &te);
                if (te - ts > W1T_TIMEOUT_US) {
                    log_hal_msgid_error("[PMU_CHG]rsel_ctl fail, timeout[10ms]", 0);
                    break;
                }
            }
        }
    }
    log_hal_msgid_info("[PMU_CHG]rsel_ctl, state[%d], cc1_rsel[0x%X], cc2_rsel[0x%X], cv_rsel[0x%X], chg_state[%d], rg_60A[0x%X]", 6,
                       state, cc1_rsel, cc2_rsel, cv_rsel, chg_state, pmu_get_register_value_lp(0x60A, 0xFFFF, 0));
    chg_rsel.state = state;
}

uint32_t pmu_chg_vchg_to_volt(uint32_t adc)
{
    uint32_t vchg = (adc * 10580 + 500)/1000;

    //log_hal_msgid_info("pmu_chg_vchg_to_volt, vchg[%d]mV", 1, vchg);
    return vchg;
}

#ifdef HAL_ADC_MODULE_ENABLED
/*---------------------report temp----------------------*/
void pmu_ntc_enable_adc(void)
{
    hal_pinmux_set_function(HAL_GPIO_12, HAL_GPIO_12_AUXADC0);
    hal_ntc_sfr_write(AUXADC_ANA_CON0, 0x0800);
    hal_adc_init();
}

void pmu_ntc_disable_adc(void)
{
    hal_ntc_sfr_write(AUXADC_ANA_CON0, 0x0000);
    hal_adc_deinit();
}

void pmu_ntc_get_temp_adc(uint32_t *temp_adc)
{
    hal_adc_status_t status = HAL_ADC_STATUS_OK;
    uint32_t data = 0, val = 0, ret = 0;

    for (uint8_t i = 0; i < ntc_cfg1.avg_cnt; i++) {
        status = hal_adc_get_average_data(HAL_ADC_CHANNEL_0, HAL_ADC_AVERAGE_256, &data);
        if (status) {
            log_hal_msgid_error("[PMU_JEITA]ntc_get_temp_adc fail, status[%d]", 1, status);
            assert(0);
        }
        val += data;
    }
    val = pmu_round(val, ntc_cfg1.avg_cnt);
    hal_adc_get_calibraton_data(val, &ret);
    //log_hal_msgid_info("[PMU_JEITA]ntc_get_temp_adc, val[%d], temp_adc[%d]", 2, val, ret);

    *temp_adc = ret;
}

void pmu_ntc_adc_to_ratio(uint32_t temp_adc, uint32_t *ratio)
{
    *ratio = (temp_adc * 1000) / 4095;
    //log_hal_msgid_info("[PMU_JEITA]ntc_adc_to_ratio, temp_adc[%d], ratio[%d]", 2, temp_adc, *ratio);
}

void pmu_ntc_ratio_to_temp(int ratio, int *temp)
{
    int idx = 0;
    int max = 0, min = 0;
    int cnt = ntc_temp.cnt;

    if (ratio >= ntc_ratio.data[0]) {
        idx = 0;
    }
    else if (ratio <= ntc_ratio.data[cnt - 1]) {
        idx = cnt - 1;
    }
    else {
        for (int i = 0; i < cnt; i++) {
            if (i == (cnt - 1)) {
                idx = cnt - 1;
                break;
            }
            max = ntc_ratio.data[i];
            min = ntc_ratio.data[i+1];
            if ((ratio > min) && (ratio <= max)) {
                if ((ratio - min) >= (max - ratio)) {
                    idx = i;
                }
                else {
                    idx = i + 1;
                }
                break;
            }
        }
    }
    *temp = ntc_temp.data[idx];

    //log_hal_msgid_info("[PMU_JEITA]ntc_ratio_to_temp, ratio[%d], max[%d], min[%d], idx[%d], temp[%d]", 5,
        //ratio, max, min, idx, ntc_temp.data[idx]);
}

int pmu_ntc_get_temp(void)
{
    int temp = 0;
    uint32_t temp_adc = 0, ratio = 0;

    pmu_ntc_enable_adc();
    pmu_ntc_get_temp_adc(&temp_adc);
    pmu_ntc_disable_adc();
    pmu_ntc_adc_to_ratio(temp_adc, &ratio);
    pmu_ntc_ratio_to_temp(ratio, &temp);

    return temp;
}

void pmu_ntc_update_state(int *ret_temp, pmu_ntc_state_t *curr_state)
{
    if ((!ntc_cfg1.enable) || (!ntc_cfg1.k_flag)) {
        log_hal_msgid_error("[PMU_JEITA]ntc_update_state fail, invalid config", 0);
        g_ntc_state = PMU_NTC_NORM;
        return;
    }

    uint8_t ntc_state = PMU_NTC_PWR_OFF;
    int temp = pmu_ntc_get_temp();

    if ((temp >= ntc_cfg2.burning) || (temp <= ntc_cfg2.frozen)) {
        ntc_state = PMU_NTC_PWR_OFF;
        log_hal_msgid_info("[PMU_JEITA]ntc_update_state, state[pwr_off], temp[%d]", 1, temp);
    } else if (temp >= ntc_cfg2.hot) {
        ntc_state = PMU_NTC_HOT;
        log_hal_msgid_info("[PMU_JEITA]ntc_update_state, state[hot], temp[%d]", 1, temp);
    } else if (temp <= ntc_cfg2.cold) {
        ntc_state = PMU_NTC_COLD;
        log_hal_msgid_info("[PMU_JEITA]ntc_update_state, state[cold], temp[%d]", 1, temp);
    } else if ((temp > ntc_cfg2.cold) && (temp <= ntc_cfg2.cool)) {
        ntc_state = PMU_NTC_COOL;
        log_hal_msgid_info("[PMU_JEITA]ntc_update_state, state[cool], temp[%d]", 1, temp);
    } else if ((temp >= ntc_cfg2.warm) && (temp < ntc_cfg2.hot)) {
        ntc_state = PMU_NTC_WARM;
        log_hal_msgid_info("[PMU_JEITA]ntc_update_state, state[warm], temp[%d]", 1, temp);
    } else if ((temp > ntc_cfg2.cool) && (temp < ntc_cfg2.warm)) {
        ntc_state = PMU_NTC_NORM;
        log_hal_msgid_info("[PMU_JEITA]ntc_update_state, state[norm], temp[%d]", 1, temp);
    } else {
        log_hal_msgid_error("[PMU_JEITA]ntc_update_state fail, state[err], temp[%d]", 1, temp);
        assert(0);
    }
#ifndef AIR_PMU_DISABLE_CHARGER
    if ((ntc_state != g_ntc_state) || (ntc_state == PMU_NTC_PWR_OFF)) {
        //log_hal_msgid_info("[PMU_JEITA]ntc_update_state done, old_state[%d], new_state[%d]", 2, g_ntc_state, ntc_state);
        g_ntc_state = ntc_state;
        pmu_ntc_cfg(ntc_state);
    }
#endif
    *ret_temp = temp;
    *curr_state = ntc_state;
}

/*---------------------NTC trim----------------------*/
void pmu_ntc_get_nvkey_t25_idx(uint8_t *idx)
{
    if (idx == NULL) {
        //log_hal_msgid_error("[PMU_JEITA]ntc_get_nvkey_t25_idx, idx null ptr", 0);
        assert(0);
    }

    uint8_t ptr = 0;
    while (ptr < NTC_DATA_SIZE) {
        if (ntc_temp.data[ptr] == 25) {
            *idx = ptr;
            break;
        } else {
            ptr++;
        }
    }
    //log_hal_msgid_info("[PMU_JEITA]ntc_get_nvkey_t25_idx, idx[%d]", 1, ptr);
}

void pmu_ntc_get_efuse_ragpio(uint16_t *ret)
{
    uint32_t efuse = *(volatile uint32_t *)(EFUSE_NTC_RAGPIO_ADDR);
    uint16_t ragpio = ((efuse >> 19) & 0x1FFF);

    if (ntc_cfg1.dump)
        log_hal_msgid_info("[PMU_JEITA]ntc_get_efuse_ragpio, efuse[0x%X], ragpio[%d], offset_err[%d], gain_err[%d]", 4, efuse, ragpio, ((efuse >> 10) & 0x1FF), (efuse & 0x3FF));

    if (ragpio) {
        *ret = ragpio;
    } else {
        *ret = EFUSE_NTC_DEF_RAGPIO;
        //log_hal_msgid_error("[PMU_JEITA]ntc_get_efuse_ragpio fail, no data", 0);
        assert(0);
    }
}

void pmu_ntc_get_efuse_r2(uint16_t *ret)
{
    uint32_t efuse = *(volatile uint32_t *)(EFUSE_NTC_R2_ADDR);
    //uint16_t ldo14 = ((efuse >> 16) & 0x7FF);
    uint16_t r2 = (efuse & 0xFFFF);

    if (ntc_cfg1.dump)
        log_hal_msgid_info("[PMU_JEITA]ntc_get_efuse_r2, efuse[0x%X], r2[%d]", 2, efuse, r2);

    if (r2) {
        *ret = r2;
    } else {
        *ret = EFUSE_NTC_DEF_R2;
        //log_hal_msgid_error("[PMU_JEITA]ntc_get_efuse_r2 fail, no data", 0);
        assert(0);
    }
}

void pmu_ntc_set_nvkey_r2(void)
{
    uint32_t last_r2, ret_r2;
    uint16_t r2 = 0;
    uint8_t idx = 0;

    pmu_ntc_get_nvkey_t25_idx(&idx);
    pmu_ntc_get_efuse_r2(&r2);
    ntc_r2.data[idx] = r2;
    last_r2 = r2 * NTC_R2_ACC;

    for(int lindex = (idx - 1); lindex >= 0; lindex--) {
        last_r2 = last_r2 * 0.999808;
        ret_r2 = pmu_round(last_r2, NTC_R2_ACC);
        ntc_r2.data[lindex] = ret_r2;
        //log_hal_msgid_warning("[PMU_JEITA]ntc_set_nvkey_r2, idx[%d], last_r2[%d], ret_r2[%d]", 3, lindex, last_r2, ret_r2);
    }

    last_r2 = r2 * NTC_R2_ACC;

    for(int rindex = (idx + 1); rindex < NTC_DATA_SIZE; rindex++) {
        last_r2 = last_r2 * 1.000192;
        ret_r2 = pmu_round(last_r2, NTC_R2_ACC);
        ntc_r2.data[rindex] = ret_r2;
        //log_hal_msgid_warning("[PMU_JEITA]ntc_set_nvkey_r2, idx[%d], last_r2[%d], ret_r2[%d]", 3, rindex, last_r2, ret_r2);
    }

    pmu_set_nvkey(NVID_NTC_R2_TABLE, (uint8_t *)&ntc_r2, sizeof(ntc_r2));
}

void pmu_ntc_set_nvkey_ratio(void)
{
    uint16_t ragpio = 0;
    uint32_t temp = 0;

    pmu_ntc_get_efuse_ragpio(&ragpio);

    for (int i = 0; i < NTC_DATA_SIZE; i++) {
        temp = ((1000 * (ntc_res.data[i] + ragpio)) / (ntc_res.data[i] + ragpio + ntc_r2.data[i]));//todo
        ntc_ratio.data[i] = temp;
        //log_hal_msgid_warning("[PMU_JEITA]ntc_set_nvkey_ratio, i[%d], res[%d], r2[%d], temp[%d]", 4,
            //i, ntc_res.data[i], ntc_r2.data[i], temp);
    }

    pmu_set_nvkey(NVID_NTC_RARIO_TABLE, (uint8_t *)&ntc_ratio, sizeof(ntc_ratio));
}

void pmu_ntc_cal_done(void)
{
    ntc_cfg1.k_flag = 1;
    pmu_set_nvkey(NVID_NTC_CFG1, (uint8_t *)&ntc_cfg1, sizeof(ntc_cfg1));
    log_hal_msgid_info("[PMU_JEITA]ntc_cal_done", 0);
}

void pmu_ntc_dump_data(void)
{
    if (!ntc_cfg1.dump) {
        //log_hal_msgid_error("[PMU_JEITA]ntc_dump_data, dump disable", 0);
        return;
    }

    for(uint8_t i = 0; i < NTC_DATA_SIZE; i++) {
        hal_gpt_delay_ms(1);
        log_hal_msgid_warning("[PMU_JEITA]ntc_dump_data, idx[%d], ntc_temp[%d], ntc_res[%d], r2[%d], ratio[%d]", 5,
                              i, ntc_temp.data[i], ntc_res.data[i], ntc_r2.data[i], ntc_ratio.data[i]);
    }
}

uint8_t pmu_ntc_get_enable_status(void)
{
    return ntc_cfg1.enable;
}

uint8_t pmu_ntc_get_interval(void)
{
    return ntc_cfg1.interval;
}

void pmu_ntc_nvkey_init(void)
{
    chg_cc_curr_cfg_t pmu_chg_cc1, pmu_chg_cc2;

    pmu_get_nvkey(NVID_CAL_JEITA_WARM, (uint8_t *)&pmu_chg_jeita_warm, sizeof(pmu_chg_jeita_warm));
    pmu_get_nvkey(NVID_CAL_JEITA_COOL, (uint8_t *)&pmu_chg_jeita_cool, sizeof(pmu_chg_jeita_cool));
    pmu_get_nvkey(NVID_CAL_INT_CHG_DAC_CFG, (uint8_t *)&pmu_chg_dac, sizeof(pmu_chg_dac));
    pmu_get_nvkey(NVID_CAL_INT_CHG_CC1_CURR_CFG, (uint8_t *)&pmu_chg_cc1, sizeof(pmu_chg_cc1));
    pmu_get_nvkey(NVID_CAL_INT_CHG_CC2_CURR_CFG, (uint8_t *)&pmu_chg_cc2, sizeof(pmu_chg_cc2));
    pmu_get_nvkey(NVID_CAL_CHG_ADC_CFG, (uint8_t *)&pmu_chg_adc, sizeof(pmu_chg_adc));
    pmu_get_nvkey(NVID_CAL_CV_STOP_CURR_CFG, (uint8_t *)&pmu_chg_cv_stop_curr, sizeof(pmu_chg_cv_stop_curr));

    chg_rsel.cc1[PMU_RSEL_NORM] = pmu_chg_cc1.data[pmu_chg_cc1.sel - 1].sel;
    chg_rsel.cc1[PMU_RSEL_WARM] = pmu_chg_jeita_warm.cc1_rsel;
    chg_rsel.cc1[PMU_RSEL_COOL] = pmu_chg_jeita_cool.cc1_rsel;
    chg_rsel.cc1[PMU_RSEL_VBAT] = VBAT_RSEL;
    chg_rsel.cc2[PMU_RSEL_NORM] = pmu_chg_cc2.data[pmu_chg_cc2.sel - 1].sel;
    chg_rsel.cc2[PMU_RSEL_WARM] = pmu_chg_jeita_warm.cc2_rsel;
    chg_rsel.cc2[PMU_RSEL_COOL] = pmu_chg_jeita_cool.cc2_rsel;
    chg_rsel.cc2[PMU_RSEL_VBAT] = VBAT_RSEL;

    pmu_chg_info.cc1_thrd_volt = pmu_chg_adc.cc1_thrd_volt;
    pmu_chg_info.cc1_curr = pmu_chg_cc1.data[pmu_chg_cc1.sel - 1].curr;
    pmu_chg_info.cc2_thrd_volt = pmu_chg_adc.cc2_thrd_volt;
    pmu_chg_info.cc2_curr = pmu_chg_cc2.data[pmu_chg_cc2.sel - 1].curr;

    log_hal_msgid_info("[PMU_JEITA]ntc_nvkey_init, cc1_norm[0x%X], cc1_warm[0x%X], cc1_cool[0x%X], cc2_norm[0x%X], cc2_warm[0x%X], cc2_cool[0x%X]", 6,
                       chg_rsel.cc1[PMU_RSEL_NORM], chg_rsel.cc1[PMU_RSEL_WARM], chg_rsel.cc1[PMU_RSEL_COOL],
                       chg_rsel.cc2[PMU_RSEL_NORM], chg_rsel.cc2[PMU_RSEL_WARM], chg_rsel.cc2[PMU_RSEL_COOL]);

    pmu_get_nvkey(NVID_NTC_CFG1, (uint8_t *)&ntc_cfg1, sizeof(ntc_cfg1));
    pmu_get_nvkey(NVID_NTC_CFG2, (uint8_t *)&ntc_cfg2, sizeof(ntc_cfg2));
    pmu_get_nvkey(NVID_NTC_TEMP_TABLE, (uint8_t *)&ntc_temp, sizeof(ntc_temp));
    pmu_get_nvkey(NVID_NTC_RES_TABLE, (uint8_t *)&ntc_res, sizeof(ntc_res));
    pmu_get_nvkey(NVID_NTC_R2_TABLE, (uint8_t *)&ntc_r2, sizeof(ntc_r2));
    pmu_get_nvkey(NVID_NTC_RARIO_TABLE, (uint8_t *)&ntc_ratio, sizeof(ntc_ratio));

    log_hal_msgid_info("[PMU_JEITA]ntc_nvkey_init, enable[%d], k_flag[%d], dump[%d], avg_cnt[%d], interval[%d], hot[%d], warm[%d], cool[%d], cold[%d], burning[%d], frozen[%d]", 11,
                       ntc_cfg1.enable, ntc_cfg1.k_flag, ntc_cfg1.dump, ntc_cfg1.avg_cnt, ntc_cfg1.interval,
                       ntc_cfg2.hot, ntc_cfg2.warm, ntc_cfg2.cool, ntc_cfg2.cold, ntc_cfg2.burning, ntc_cfg2.frozen);
}

void pmu_ntc_cal_init(void)
{
    if (!ntc_cfg1.enable) {
        //log_hal_msgid_error("[PMU_JEITA]ntc_cal_init, ntc disable", 0);
        return;
    }

    if (!ntc_cfg1.k_flag) {
        pmu_ntc_set_nvkey_r2();
        pmu_ntc_set_nvkey_ratio();
        pmu_ntc_cal_done();
        pmu_ntc_dump_data();
    } else {
        log_hal_msgid_warning("[PMU_JEITA]ntc_cal_init, exist", 0);
    }
}

void pmu_ntc_set_init(void)
{
    int temp = 0;
    pmu_ntc_state_t ntc_state = PMU_NTC_NORM;

    pmu_ntc_update_state(&temp, &ntc_state);
}

void pmu_ntc_init(void)
{
    pmu_ntc_nvkey_init();
    pmu_ntc_cal_init();
    pmu_ntc_set_init();
}
//************** jeita ******************
#ifndef AIR_PMU_DISABLE_CHARGER
void pmu_ntc_set_dac(pmu_ntc_state_t state)
{
    uint16_t cc1_dac, cc2_dac, cv_dac = 0, chg_state = 0;
    uint32_t ts = 0, te = 0, addr = 0;

    if (state == PMU_NTC_COOL) {
        cc1_dac = pmu_chg_jeita_cool.cc1_curr_dac;
        cc2_dac = pmu_chg_jeita_cool.cc2_curr_dac;
    } else if (state == PMU_NTC_WARM) {
        cc1_dac = pmu_chg_jeita_warm.cc1_curr_dac;
        cc2_dac = pmu_chg_jeita_warm.cc2_curr_dac;
    } else {
        cc1_dac = pmu_chg_dac.cc1_curr_dac;
        cc2_dac = pmu_chg_dac.cc2_curr_dac;
    }

    pmu_set_register_value_lp(CC1_DAC_VALUE_ADDR, CC1_DAC_VALUE_MASK, CC1_DAC_VALUE_SHIFT, cc1_dac);

    if (pmu_get_register_value_lp(CC2_EN_ADDR, CC2_EN_MASK, CC2_EN_SHIFT)) {
        pmu_set_register_value_lp(CC2_DAC_VALUE_ADDR, CC2_DAC_VALUE_MASK, CC2_DAC_VALUE_SHIFT, cc2_dac);
        cv_dac = cc2_dac;
    }
    else {
        cv_dac = cc1_dac;
    }
    pmu_set_register_value_lp(CV_DAC_VALUE_ADDR, CV_DAC_VALUE_MASK, CV_DAC_VALUE_SHIFT, cv_dac);

    chg_state = pmu_get_register_value_lp(CHG_STATE_ADDR, CHG_STATE_MASK, CHG_STATE_SHIFT);

    if (chg_state == CHG_CC1) {
        addr = CC1_DAC_OUT_UPDATE_ADDR;
    }
    else if (chg_state == CHG_CC2) {
        addr = CC2_DAC_OUT_UPDATE_ADDR;
    }
    else if (chg_state == CHG_CV) {
        addr = CV_DAC_OUT_UPDATE_ADDR;
    }

    if (addr) {
        pmu_set_register_value_lp(addr, 0x1, 15, 1);
        hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &ts);
        while (1) {
            if (!pmu_get_register_value_lp(addr, 0x1, 15)) {
                break;
            } else {
                hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &te);
                if (te - ts > W1T_TIMEOUT_US) {
                    log_hal_msgid_error("[PMU_JEITA]ntc_set_dac fail, timeout[%dus]", 1, (te - ts));
                    //assert(0);
                    break;
                }
            }
        }
    }
    log_hal_msgid_info("[PMU_JEITA]ntc_set_dac, state[%d], cc1_dac[0x%X], cc2_dac[0x%X], cv_dac[0x%X], chg_state[%d], rg_60A[0x%X]", 6,
        state, cc1_dac, cc2_dac, cv_dac, chg_state, pmu_get_register_value_lp(0x60A, 0xFFFF, 0));
}

void pmu_ntc_set_rsel(pmu_ntc_state_t state)
{
    if (state == PMU_NTC_COOL) {
        pmu_chg_rsel_ctl(PMU_RSEL_COOL);
    } else if (state == PMU_NTC_WARM) {
        pmu_chg_rsel_ctl(PMU_RSEL_WARM);
    } else {
        pmu_chg_rsel_ctl(PMU_RSEL_NORM);
    }

    //log_hal_msgid_info("[PMU_JEITA]ntc_set_rsel, state[%d]", 1, state);
}

void pmu_ntc_set_thrd(pmu_ntc_state_t state)
{
    uint16_t cc1_thrd = 0, cc2_thrd = 0, cv_thrd = 0, cv_stop_curr = 0, rechg_thrd = 0, chg_state = 0, rg_322;

    chg_state = pmu_get_register_value_lp(CHG_STATE_ADDR, CHG_STATE_MASK, CHG_STATE_SHIFT);

    rg_322 = pmu_get_register_value_lp(0x322, 0xFFFF, 0);
    rg_322 &= 0xFF03;
    if(chg_state == CHG_TRICKLE) {
        rg_322 |= (1<<2);
    }else if(chg_state == CHG_CC1) {
        rg_322 |= (1<<3);
    }else if(chg_state == CHG_CC2) {
        rg_322 |= (1<<4);
    }else if(chg_state == CHG_CV) {
        rg_322 |= (1<<5);
    }else if(chg_state == CHG_COMPL) {
        rg_322 |= (1<<6);
    }else if(chg_state == CHG_RECHG) {
        rg_322 |= (1<<7);
    }
    pmu_force_set_register_value_lp(0x322, rg_322);

    cc1_thrd = pmu_chg_adc.cc1_thrd_adc;

    if (state == PMU_NTC_COOL) {
        cc2_thrd = pmu_chg_jeita_cool.cc2_thrd_adc;
        cv_thrd = pmu_chg_jeita_cool.cv_thrd_adc;
        cv_stop_curr = pmu_chg_jeita_cool.cv_stop_curr_adc;
        rechg_thrd = pmu_chg_jeita_cool.rechg_adc;
    } else if (state == PMU_NTC_WARM) {
        cc2_thrd = pmu_chg_jeita_warm.cc2_thrd_adc;
        cv_thrd = pmu_chg_jeita_warm.cv_thrd_adc;
        cv_stop_curr = pmu_chg_jeita_warm.cv_stop_curr_adc;
        rechg_thrd = pmu_chg_jeita_warm.rechg_adc;
    } else {
        cc2_thrd = pmu_chg_adc.cc2_thrd_adc;
        cv_thrd = pmu_chg_adc.cv_thrd_adc;
        cv_stop_curr = pmu_chg_cv_stop_curr.cv_stop_curr[pmu_chg_cv_stop_curr.cal_cnt - 1].adc;
        rechg_thrd = pmu_chg_adc.rechg_adc;
    }

    pmu_set_register_value_lp(CC1_THRESHOLD_ADDR, CC1_THRESHOLD_MASK, CC1_THRESHOLD_SHIFT, cc1_thrd);
    pmu_set_register_value_lp(CC2_THRESHOLD_ADDR, CC2_THRESHOLD_MASK, CC2_THRESHOLD_SHIFT, cc2_thrd);
    pmu_set_register_value_lp(CV_THRESHOLD_ADDR, CV_THRESHOLD_MASK, CV_THRESHOLD_SHIFT, cv_thrd);
    pmu_set_register_value_lp(CV_STOP_CURRENT_ADDR, CV_STOP_CURRENT_MASK, CV_STOP_CURRENT_SHIFT, cv_stop_curr);
    pmu_set_register_value_lp(RECHARGE_THRESHOLD_ADDR, RECHARGE_THRESHOLD_MASK, RECHARGE_THRESHOLD_SHIFT, rechg_thrd);

    rg_322 &= 0xFF03;
    pmu_force_set_register_value_lp(0x322, rg_322);

    log_hal_msgid_info("[PMU_JEITA]ntc_set_thrd, state[%d], cc1_thrd[0x%X], cc2_thrd[0x%X], cv_thrd[0x%X], cv_stop_curr[0x%X], rechg_thrd[0x%X], chg_state[%d]", 7,
                       state, cc1_thrd, cc2_thrd, cv_thrd, cv_stop_curr, rechg_thrd, chg_state);
}

void pmu_ntc_cfg(pmu_ntc_state_t state)
{
    log_hal_msgid_info("[PMU_JEITA]ntc_cfg, state[%d]", 1, state);

    if (state == PMU_NTC_PWR_OFF) {
        pmu_enable_charger_lp(PMU_OFF);
        if (!pmu_get_chr_detect_value_lp()) {
            hal_rtc_enter_rtc_mode();
        }
    } else if ((state == PMU_NTC_HOT) || (state == PMU_NTC_COLD)) {
        pmu_enable_charger_lp(PMU_OFF);
    } else {
        pmu_ntc_set_rsel(state);
        pmu_ntc_set_dac(state);
        pmu_ntc_set_thrd(state);
        if (pmu_get_chr_detect_value_lp()) {
            pmu_enable_charger_lp(PMU_ON);
        }
    }
}
#endif
void pmu_ntc_get_efuse_slt(uint16_t *ragpio ,uint16_t *offset_err, uint16_t *gain_err)
{
    uint32_t efuse = *(volatile uint32_t *)(EFUSE_NTC_RAGPIO_ADDR);

    *ragpio = (uint16_t)((efuse >> 19) & 0x1FFF);
    *offset_err = (uint16_t)((efuse >> 10) & 0x1FF);
    *gain_err = (uint16_t)(efuse & 0x3FF);
}

bool pmu_ntc_slt(void)
{
    bool ret = false;
    uint32_t temp_adc;
    uint16_t r2, ragpio, offset_err, gain_err;
    double oe_adc, ge_adc, vadc, ntc_i, ntc_v, ntc_r;

    pmu_ntc_get_efuse_r2(&r2);
    pmu_ntc_get_efuse_slt(&ragpio, &offset_err, &gain_err);
    log_hal_msgid_info("[PMU_JEITA]ntc_slt, r2[%d], ragpio[%d], offset_err[%d], gain_err[%d]", 4,
                       r2, ragpio, offset_err, gain_err);

    pmu_ntc_enable_adc();
    pmu_ntc_get_temp_adc(&temp_adc);
    pmu_ntc_disable_adc();

    oe_adc = (double)(offset_err - 128)/(double)4096;
    ge_adc = (double)(gain_err - 256)/(double)4096;
    vadc = (double)((double)temp_adc / (double)4096 - oe_adc) * (double)NTC_SLT_1V4 / (double)(1 + ge_adc);
    ntc_i = (double)(NTC_SLT_1V4 - vadc) / (double)r2;
    ntc_v = vadc - ntc_i * (double)ragpio;
    ntc_r = ntc_v / ntc_i;

    printf("[PMU_JEITA]ntc_slt, oe_adc[%f], ge_adc[%f], vadc[%f], ntc_i[%f], ntc_v[%f], ntc_r[%f]", oe_adc, ge_adc, vadc, ntc_i, ntc_v, ntc_r);

    if((ntc_r > NTC_SLT_MIN_RES) && (ntc_r < NTC_SLT_MAX_RES))
        ret = true;
    else
        ret = false;

    log_hal_msgid_info("[PMU_JEITA]ntc_slt, ret[%d]", 1, ret);

    return ret;
}
#endif
#endif

/*==========[BC 1.2 behavior]==========*/

void pmu_bc12_init(void) {
    pmu_set_register_value_ddie(PMU_BC12_IBIAS_EN_V12_ADDR, PMU_BC12_IBIAS_EN_V12_MASK, PMU_BC12_IBIAS_EN_V12_SHIFT, 0x1);
    hal_gpt_delay_ms(10);
    pmu_set_register_value_ddie(PMU_BC12_SRC_EN_V12_ADDR, PMU_BC12_SRC_EN_V12_MASK, PMU_BC12_SRC_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_VREF_VTH_EN_V12_ADDR, PMU_BC12_VREF_VTH_EN_V12_MASK, PMU_BC12_VREF_VTH_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_CMP_EN_V12_ADDR, PMU_BC12_CMP_EN_V12_MASK, PMU_BC12_CMP_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_IPU_EN_V12_ADDR, PMU_BC12_IPU_EN_V12_MASK, PMU_BC12_IPU_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_IPD_EN_V12_ADDR, PMU_BC12_IPD_EN_V12_MASK, PMU_BC12_IPD_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_IPD_HALF_EN_V12_ADDR, PMU_BC12_IPD_HALF_EN_V12_MASK, PMU_BC12_IPD_HALF_EN_V12_SHIFT, 0);
}

void pmu_bc12_end(void) {
    pmu_set_register_value_ddie(PMU_BC12_IBIAS_EN_V12_ADDR, PMU_BC12_IBIAS_EN_V12_MASK, PMU_BC12_IBIAS_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_SRC_EN_V12_ADDR, PMU_BC12_SRC_EN_V12_MASK, PMU_BC12_SRC_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_VREF_VTH_EN_V12_ADDR, PMU_BC12_VREF_VTH_EN_V12_MASK, PMU_BC12_VREF_VTH_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_CMP_EN_V12_ADDR, PMU_BC12_CMP_EN_V12_MASK, PMU_BC12_CMP_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_IPU_EN_V12_ADDR, PMU_BC12_IPU_EN_V12_MASK, PMU_BC12_IPU_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_IPD_EN_V12_ADDR, PMU_BC12_IPD_EN_V12_MASK, PMU_BC12_IPD_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_IPD_HALF_EN_V12_ADDR, PMU_BC12_IPD_HALF_EN_V12_MASK, PMU_BC12_IPD_HALF_EN_V12_SHIFT, 0);
}

uint8_t pmu_bc12_dcd(void) {
    uint8_t value = 0xFF;
    pmu_set_register_value_ddie(PMU_BC12_SRC_EN_V12_ADDR, PMU_BC12_SRC_EN_V12_MASK, PMU_BC12_SRC_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_VREF_VTH_EN_V12_ADDR, PMU_BC12_VREF_VTH_EN_V12_MASK, PMU_BC12_VREF_VTH_EN_V12_SHIFT, 1);
    pmu_set_register_value_ddie(PMU_BC12_CMP_EN_V12_ADDR, PMU_BC12_CMP_EN_V12_MASK, PMU_BC12_CMP_EN_V12_SHIFT, 2);
    pmu_set_register_value_ddie(PMU_BC12_IPU_EN_V12_ADDR, PMU_BC12_IPU_EN_V12_MASK, PMU_BC12_IPU_EN_V12_SHIFT, 2);
    pmu_set_register_value_ddie(PMU_BC12_IPD_EN_V12_ADDR, PMU_BC12_IPD_EN_V12_MASK, PMU_BC12_IPD_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_DCD_EN_V12_ADDR, PMU_BC12_DCD_EN_V12_MASK, PMU_BC12_DCD_EN_V12_SHIFT, 1);
    pmu_set_register_value_ddie(PMU_BC12_IPD_HALF_EN_V12_ADDR, PMU_BC12_IPD_HALF_EN_V12_MASK, PMU_BC12_IPD_HALF_EN_V12_SHIFT, 0);
    hal_gpt_delay_ms(10);
    value = pmu_get_register_value_ddie(PMU_AQ_QI_BC12_CMP_OUT_V12_ADDR, PMU_AQ_QI_BC12_CMP_OUT_V12_MASK, PMU_AQ_QI_BC12_CMP_OUT_V12_SHIFT);;
    hal_gpt_delay_ms(10);
    return value;
}

uint8_t pmu_bc12_primary_detction(void) {
    uint8_t compareResult = 0xFF;
    pmu_set_register_value_ddie(PMU_BC12_SRC_EN_V12_ADDR, PMU_BC12_SRC_EN_V12_MASK, PMU_BC12_SRC_EN_V12_SHIFT, 2);
    pmu_set_register_value_ddie(PMU_BC12_VREF_VTH_EN_V12_ADDR, PMU_BC12_VREF_VTH_EN_V12_MASK, PMU_BC12_VREF_VTH_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_CMP_EN_V12_ADDR, PMU_BC12_CMP_EN_V12_MASK, PMU_BC12_CMP_EN_V12_SHIFT, 1);
    pmu_set_register_value_ddie(PMU_BC12_IPU_EN_V12_ADDR, PMU_BC12_IPU_EN_V12_MASK, PMU_BC12_IPU_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_IPD_EN_V12_ADDR, PMU_BC12_IPD_EN_V12_MASK, PMU_BC12_IPD_EN_V12_SHIFT, 1);
    pmu_set_register_value_ddie(PMU_BC12_IPD_HALF_EN_V12_ADDR, PMU_BC12_IPD_HALF_EN_V12_MASK, PMU_BC12_IPD_HALF_EN_V12_SHIFT, 0);
    hal_gpt_delay_ms(40);
    compareResult = pmu_get_register_value_ddie(PMU_AQ_QI_BC12_CMP_OUT_V12_ADDR, PMU_AQ_QI_BC12_CMP_OUT_V12_MASK, PMU_AQ_QI_BC12_CMP_OUT_V12_SHIFT);
    hal_gpt_delay_ms(20);
    return compareResult;
}

uint8_t pmu_bc12_secondary_detection(void) {
    uint8_t compareResult = 0xFF;
    pmu_set_register_value_ddie(PMU_BC12_SRC_EN_V12_ADDR, PMU_BC12_SRC_EN_V12_MASK, PMU_BC12_SRC_EN_V12_SHIFT, 1);
    pmu_set_register_value_ddie(PMU_BC12_VREF_VTH_EN_V12_ADDR, PMU_BC12_VREF_VTH_EN_V12_MASK, PMU_BC12_VREF_VTH_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_CMP_EN_V12_ADDR, PMU_BC12_CMP_EN_V12_MASK, PMU_BC12_CMP_EN_V12_SHIFT, 2);
    pmu_set_register_value_ddie(PMU_BC12_IPU_EN_V12_ADDR, PMU_BC12_IPU_EN_V12_MASK, PMU_BC12_IPU_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_IPD_EN_V12_ADDR, PMU_BC12_IPD_EN_V12_MASK, PMU_BC12_IPD_EN_V12_SHIFT, 2);
    pmu_set_register_value_ddie(PMU_BC12_IPD_HALF_EN_V12_ADDR, PMU_BC12_IPD_HALF_EN_V12_MASK, PMU_BC12_IPD_HALF_EN_V12_SHIFT, 0);
    hal_gpt_delay_ms(40);
    compareResult = pmu_get_register_value_ddie(PMU_AQ_QI_BC12_CMP_OUT_V12_ADDR, PMU_AQ_QI_BC12_CMP_OUT_V12_MASK, PMU_AQ_QI_BC12_CMP_OUT_V12_SHIFT);
    hal_gpt_delay_ms(20);
    return compareResult;
}

uint8_t pmu_bc12_check_DCP(void) {
    uint8_t compareResult = 0xFF;
    pmu_set_register_value_ddie(PMU_BC12_SRC_EN_V12_ADDR, PMU_BC12_SRC_EN_V12_MASK, PMU_BC12_SRC_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_VREF_VTH_EN_V12_ADDR, PMU_BC12_VREF_VTH_EN_V12_MASK, PMU_BC12_VREF_VTH_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_CMP_EN_V12_ADDR, PMU_BC12_CMP_EN_V12_MASK, PMU_BC12_CMP_EN_V12_SHIFT, 1);
    pmu_set_register_value_ddie(PMU_BC12_IPU_EN_V12_ADDR, PMU_BC12_IPU_EN_V12_MASK, PMU_BC12_IPU_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_IPD_EN_V12_ADDR, PMU_BC12_IPD_EN_V12_MASK, PMU_BC12_IPD_EN_V12_SHIFT, 2);
    pmu_set_register_value_ddie(PMU_BC12_IPD_HALF_EN_V12_ADDR, PMU_BC12_IPD_HALF_EN_V12_MASK, PMU_BC12_IPD_HALF_EN_V12_SHIFT, 0);
    hal_gpt_delay_ms(10);
    pmu_set_register_value_ddie(PMU_BC12_IPD_EN_V12_ADDR, PMU_BC12_IPD_EN_V12_MASK, PMU_BC12_IPD_EN_V12_SHIFT, 0);
    hal_gpt_delay_us(200);
    compareResult = pmu_get_register_value_ddie(PMU_AQ_QI_BC12_CMP_OUT_V12_ADDR, PMU_AQ_QI_BC12_CMP_OUT_V12_MASK, PMU_AQ_QI_BC12_CMP_OUT_V12_SHIFT);
    return compareResult;
}

uint8_t pmu_bc12_check_dp(void) {
    uint8_t compareResult = 0xFF;
    pmu_set_register_value_ddie(PMU_BC12_SRC_EN_V12_ADDR, PMU_BC12_SRC_EN_V12_MASK, PMU_BC12_SRC_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_VREF_VTH_EN_V12_ADDR, PMU_BC12_VREF_VTH_EN_V12_MASK, PMU_BC12_VREF_VTH_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_CMP_EN_V12_ADDR, PMU_BC12_CMP_EN_V12_MASK, PMU_BC12_CMP_EN_V12_SHIFT, 2);
    pmu_set_register_value_ddie(PMU_BC12_IPU_EN_V12_ADDR, PMU_BC12_IPU_EN_V12_MASK, PMU_BC12_IPU_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_IPD_EN_V12_ADDR, PMU_BC12_IPD_EN_V12_MASK, PMU_BC12_IPD_EN_V12_SHIFT, 2);
    pmu_set_register_value_ddie(PMU_BC12_IPD_HALF_EN_V12_ADDR, PMU_BC12_IPD_HALF_EN_V12_MASK, PMU_BC12_IPD_HALF_EN_V12_SHIFT, 0);
    hal_gpt_delay_ms(10);
    compareResult = pmu_get_register_value_ddie(PMU_AQ_QI_BC12_CMP_OUT_V12_ADDR, PMU_AQ_QI_BC12_CMP_OUT_V12_MASK, PMU_AQ_QI_BC12_CMP_OUT_V12_SHIFT);
    hal_gpt_delay_ms(10);
    return compareResult;
}

uint8_t pmu_bc12_check_dm(void) {
    uint8_t compareResult = 0xFF;
    pmu_set_register_value_ddie(PMU_BC12_SRC_EN_V12_ADDR, PMU_BC12_SRC_EN_V12_MASK, PMU_BC12_SRC_EN_V12_SHIFT, 0);
   // pmu_bc12_set_vref_vth_en_v12(0);
    pmu_set_register_value_ddie(PMU_BC12_CMP_EN_V12_ADDR, PMU_BC12_CMP_EN_V12_MASK, PMU_BC12_CMP_EN_V12_SHIFT, 1);
    pmu_set_register_value_ddie(PMU_BC12_IPU_EN_V12_ADDR, PMU_BC12_IPU_EN_V12_MASK, PMU_BC12_IPU_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_IPD_EN_V12_ADDR, PMU_BC12_IPD_EN_V12_MASK, PMU_BC12_IPD_EN_V12_SHIFT, 1);
    pmu_set_register_value_ddie(PMU_BC12_IPD_HALF_EN_V12_ADDR, PMU_BC12_IPD_HALF_EN_V12_MASK, PMU_BC12_IPD_HALF_EN_V12_SHIFT, 0);
    hal_gpt_delay_ms(10);
    compareResult = pmu_get_register_value_ddie(PMU_AQ_QI_BC12_CMP_OUT_V12_ADDR, PMU_AQ_QI_BC12_CMP_OUT_V12_MASK, PMU_AQ_QI_BC12_CMP_OUT_V12_SHIFT);
    hal_gpt_delay_ms(10);
    return compareResult;
}

uint8_t pmu_bc12_check_floating(void) {
    uint8_t compareResult = 0xFF;
    pmu_set_register_value_ddie(PMU_BC12_SRC_EN_V12_ADDR, PMU_BC12_SRC_EN_V12_MASK, PMU_BC12_SRC_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_VREF_VTH_EN_V12_ADDR, PMU_BC12_VREF_VTH_EN_V12_MASK, PMU_BC12_VREF_VTH_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_CMP_EN_V12_ADDR, PMU_BC12_CMP_EN_V12_MASK, PMU_BC12_CMP_EN_V12_SHIFT, 1);
    pmu_set_register_value_ddie(PMU_BC12_IPU_EN_V12_ADDR, PMU_BC12_IPU_EN_V12_MASK, PMU_BC12_IPU_EN_V12_SHIFT, 0);
    pmu_set_register_value_ddie(PMU_BC12_IPD_EN_V12_ADDR, PMU_BC12_IPD_EN_V12_MASK, PMU_BC12_IPD_EN_V12_SHIFT, 1);
    pmu_set_register_value_ddie(PMU_BC12_IPD_HALF_EN_V12_ADDR, PMU_BC12_IPD_HALF_EN_V12_MASK, PMU_BC12_IPD_HALF_EN_V12_SHIFT, 1);
    hal_gpt_delay_ms(10);
    compareResult = pmu_get_register_value_ddie(PMU_AQ_QI_BC12_CMP_OUT_V12_ADDR, PMU_AQ_QI_BC12_CMP_OUT_V12_MASK, PMU_AQ_QI_BC12_CMP_OUT_V12_SHIFT);
    hal_gpt_delay_ms(10);
    return compareResult;
}

uint8_t pmu_get_bc12_charger_type_lp(void) {
    pmu_bc12_init();
    if (pmu_bc12_dcd() == 0) {                       //SDP/CDP/DCP/S charger
        if (pmu_bc12_primary_detction() == 0) {      //SDP
            pmu_bc12_end();
            log_hal_msgid_info("[PMU_BC12]SDP Charger\r\n", 0);
            pmu_charger_type=SDP_CHARGER;
            return SDP_CHARGER;
        } else {                                                    //CDP/DCP/S charger
            if(pmu_bc12_secondary_detection()==0){   //CDP
                pmu_bc12_end();
                log_hal_msgid_info("[PMU_BC12]CDP Charger\r\n", 0);
                pmu_charger_type=CDP_CHARGER;
                return CDP_CHARGER;
            }else{
                 if(pmu_bc12_check_DCP()==0){          //DCP
                     pmu_bc12_end();
                     log_hal_msgid_info("[PMU_BC12]DCP Charger\r\n", 0);
                     pmu_charger_type=DCP_CHARGER;
                     return DCP_CHARGER;
                 }else{                                             //S charger
                     pmu_bc12_end();
                     log_hal_msgid_info("[PMU_BC12]SS Charger\r\n", 0);
                     pmu_charger_type=SS_TABLET_CHARGER;
                     return SS_TABLET_CHARGER;
                 }
            }
        }
    } else {                                                        //apple /non-standard/ DP&DM floating charger
        uint8_t dp_out, dm_out;
        dp_out = pmu_bc12_check_dp();
        dm_out = pmu_bc12_check_dm();
        if((dp_out==0)&&(dm_out==0)){
            if(pmu_bc12_check_floating()==0){                 //DP&DM floating charger
                pmu_bc12_end();
                log_hal_msgid_info("[PMU_BC12]DP&DM Floating\r\n", 0);
                pmu_charger_type=DP_DM_FLOATING;
                return DP_DM_FLOATING;
            }else{                                                      //non-standard charger
                pmu_bc12_end();
                log_hal_msgid_info("[PMU_BC12]NON-STD charger\r\n", 0);
                pmu_charger_type=NON_STD_CHARGER;
                return NON_STD_CHARGER;
            }
        }else if((dp_out==0)&&(dm_out==1)){                          //apple 5V 1A charger
                pmu_bc12_end();
                log_hal_msgid_info("[PMU_BC12]IPHONE_5V_1A Charger\r\n", 0);
                pmu_charger_type=IPHONE_5V_1A_CHARGER;
                return IPHONE_5V_1A_CHARGER;
        }else{                                                      //apple ipad2/ipad4 charger
            pmu_bc12_end();
                log_hal_msgid_info("[PMU_BC12]IPAD2_IPAD4 Charger\r\n", 0);
                pmu_charger_type=IPAD2_IPAD4_CHARGER;
            return IPAD2_IPAD4_CHARGER;
        }
    }
}

/*==========[battery]==========*/
#define MMI_IPHONE_BATTERY_LEVELS 9

vbat_volt_cfg_t pmu_vbat_volt;

void pmu_bat_init(void)
{
    pmu_get_nvkey(NVID_CAL_VBAT_VOLT_CFG, (uint8_t *)&pmu_vbat_volt, sizeof(pmu_vbat_volt));

    pmu_chg_info.full_bat_volt = pmu_vbat_volt.data[9].volt;
    pmu_chg_info.rechg_volt = pmu_chg_adc.rechg_volt;

    log_hal_msgid_info("[PMU_CHG]bat_init, init_volt[%d], sd_volt[%d], full_volt[%d], rechg_volt[%d]", 4,
                       pmu_vbat_volt.init_bat.volt, pmu_vbat_volt.sd_bat.volt, pmu_chg_info.full_bat_volt, pmu_chg_info.rechg_volt);
    /*log_hal_msgid_info("[PMU_CHG]bat_init, 0%[%d], 10%[%d], 20%[%d], 30%[%d], 40%[%d], 50%[%d], 60%[%d], 70%[%d], 80%[%d], 90%[%d], 100%[%d]", 11,
                       pmu_vbat_volt.sd_bat.volt, pmu_vbat_volt.data[0].volt, pmu_vbat_volt.data[1].volt, pmu_vbat_volt.data[2].volt,
                       pmu_vbat_volt.data[3].volt, pmu_vbat_volt.data[4].volt, pmu_vbat_volt.data[5].volt, pmu_vbat_volt.data[6].volt,
                       pmu_vbat_volt.data[7].volt, pmu_vbat_volt.data[8].volt, pmu_vbat_volt.data[9].volt);*/
}
#ifndef AIR_PMU_DISABLE_CHARGER
static uint32_t pmu_bat_volt_to_perc_internal(uint32_t voltval, int fullscale_value)
{
    uint8_t i;
    uint16_t lowBd, highBd;
    uint32_t mul = fullscale_value / 10;
    uint32_t result = 0;

    for( i = 0; i < MMI_IPHONE_BATTERY_LEVELS; i++)
    {
        if(voltval < pmu_vbat_volt.data[i].volt)
            break;
    }

    if(i == 0)
    {
        lowBd = pmu_vbat_volt.sd_bat.volt;
        highBd = pmu_vbat_volt.data[0].volt;

        if(voltval < lowBd)
        {
            return 0;
        }
    }
    else if(i == MMI_IPHONE_BATTERY_LEVELS)
    {
        lowBd = pmu_vbat_volt.data[MMI_IPHONE_BATTERY_LEVELS-1].volt;
        highBd = pmu_vbat_volt.data[MMI_IPHONE_BATTERY_LEVELS].volt;

        if(voltval >= highBd)
        {
            //log_hal_msgid_info("[PMU_BAT]volt_to_perc_internal, i=%d, voltval = %d, highBd = %d", 3, i, voltval, highBd);
            return fullscale_value;
        }
    }
    else
    {
        lowBd = pmu_vbat_volt.data[i-1].volt;
        highBd = pmu_vbat_volt.data[i].volt;
    }

    result = (uint32_t)(pmu_round((mul * (voltval - lowBd)), (highBd - lowBd)) + (i*mul));

    //log_hal_msgid_info("pmu_bat_adc_to_perc_internal i=%d adcval=%d lowBd=%d highBd=%d result = %d, adcval = %d", 6, i, adcval, lowBd, highBd, result, adcval);

    return result;
}

uint8_t pmu_bat_volt_to_perc(uint32_t volt)
{
    return pmu_bat_volt_to_perc_internal(volt, 100);
}

uint16_t pmu_bat_volt_to_k_perc(uint32_t volt)
{
    return pmu_bat_volt_to_perc_internal(volt, 1000);
}

uint32_t pmu_bat_volt_to_adc(uint32_t volt)
{
    uint32_t adc = pmu_lerp(bat_cfg.volt1, bat_cfg.adc1, bat_cfg.volt2, bat_cfg.adc2, volt);

    //log_hal_msgid_info("[PMU_BAT]volt_to_adc, volt[%d], adc[%d]", 2, volt, adc);

    return adc;
}

uint32_t pmu_bat_adc_to_volt(uint32_t adc)
{
    uint32_t volt = pmu_lerp(bat_cfg.adc1, bat_cfg.volt1, bat_cfg.adc2, bat_cfg.volt2, adc);

    //log_hal_msgid_info("[PMU_BAT]adc_to_volt, adc[%d], volt[%d]", 2, adc, volt);

    return volt;
}

void pmu_bat_3v3_proc(void)
{
    uint32_t bat_volt = pmu_auxadc_get_channel_value(PMU_AUX_VBAT);

    if(bat_volt > 3300)
    {
        if ((adie_version == PMU_ECO3) || (adie_version == PMU_NO_FTK))
            pmu_set_register_value_lp(VLDO33_CLAMP_EN_ADDR, VLDO33_CLAMP_EN_MASK, VLDO33_CLAMP_EN_SHIFT, 0);
        else
            pmu_set_register_value_lp(VLDO33_CLAMP_EN_E2_ADDR, VLDO33_CLAMP_EN_E2_MASK, VLDO33_CLAMP_EN_E2_SHIFT, 0);
    }
    else
    {
        if ((adie_version == PMU_ECO3) || (adie_version == PMU_NO_FTK))
            pmu_set_register_value_lp(VLDO33_CLAMP_EN_ADDR, VLDO33_CLAMP_EN_MASK, VLDO33_CLAMP_EN_SHIFT, 1);
        else
            pmu_set_register_value_lp(VLDO33_CLAMP_EN_E2_ADDR, VLDO33_CLAMP_EN_E2_MASK, VLDO33_CLAMP_EN_E2_SHIFT, 1);
    }

    //log_hal_msgid_info("[PMU_BAT]bat_3v3_proc, bat_volt[%d], rg_202[0x%X]", 2, bat_volt, pmu_get_register_value_lp(0x202, 0xFFFF, 0));
}

uint16_t pmu_bat_get_pure_volt(void)
{
    uint16_t bat = 0;

#if (CHG_GAUGE_EN)
    uint32_t chg_sta = pmu_get_charger_state_lp();

    if ((chg_sta == CHG_CC1) || (chg_sta == CHG_CC2) || (chg_sta == CHG_CV))
    {
        pmu_chg_rsel_ctl(PMU_RSEL_VBAT);
        hal_gpt_delay_ms(50);
        bat = pmu_auxadc_get_channel_value(PMU_AUX_VBAT);

        if (chg_rsel.state == PMU_RSEL_VBAT)
        {
            if (g_ntc_state == PMU_NTC_WARM)
                pmu_chg_rsel_ctl(PMU_RSEL_WARM);
            else if (g_ntc_state == PMU_NTC_COOL)
                pmu_chg_rsel_ctl(PMU_RSEL_COOL);
            else
                pmu_chg_rsel_ctl(PMU_RSEL_NORM);
        }
    }
    else
    {
        bat = pmu_auxadc_get_channel_value(PMU_AUX_VBAT);
    }
#else
    bat = pmu_auxadc_get_channel_value(PMU_AUX_VBAT);
#endif
    //log_hal_msgid_info("[PMU_BAT]get_pure_volt, rsel_sta[%d], bat[%dmv]", 2, chg_rsel.state, bat);

    return bat;
}
#endif

/************** 1wire ***************/
void pmu_vio18_pull_up(pmu_power_operate_t en)
{
    if (en)
        pmu_set_register_value_lp(0x002, UART_LVSH_FORCEDIS_MASK, 3, 0);
    else
        pmu_set_register_value_lp(0x002, UART_LVSH_FORCEDIS_MASK, 3, 1);
}

void pmu_uart_psw_cl(pmu_power_operate_t en)
{
    pmu_set_register_value_lp(0x002, UART_PSWMAIN_CL_ENB_MASK, 2, en);
}

void pmu_uart_psw(pmu_power_operate_t en)
{
    if (en)
        pmu_set_register_value_lp(0x002, UART_PSWMAIN_ENB_MASK, 0, 0);
    else
        pmu_set_register_value_lp(0x002, UART_PSWMAIN_ENB_MASK, 0, 1);
}

void pmu_uart_psw_sequence(void)
{
    pmu_uart_psw_cl(PMU_ON);
    pmu_uart_psw(PMU_ON);
    hal_gpt_delay_us(100);
    pmu_uart_psw_cl(PMU_OFF);
}

void pmu_vchg_dischg_path(pmu_power_operate_t en)
{
    pmu_set_register_value_lp(0x32A, VCHG_5V_ADJ_1V8_MASK, 11, en);
}

void pmu_eoc_ctrl (pmu_power_operate_t oper)
{
#ifndef AIR_PMU_DISABLE_CHARGER
    uint16_t err_sta = 0;
    uint32_t ts = 0, te = 0;

    hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &ts);
    while(1) {
        if (pmu_get_register_value(0x418, 0xFFFF, 0) == 0) {
            break;
        } else {
            hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &te);
            if (te - ts > 10000) {
                err_sta |= 1;
                break;
            }
        }
    }
    if (err_sta) {
        log_hal_msgid_error("[PMU_CHG]eoc_ctrl, err_sta[%d], time[%dus], rg_000[0x%X], rg_418[0x%X]", 4, err_sta, (te - ts),
                           pmu_get_register_value(0x000, 0xFFFF, 0), pmu_get_register_value(0x418, 0xFFFF, 0));
    }

    uint16_t rg_320, rg_deb;
    bool vchg1, vchg2;

    vchg1 = pmu_get_chr_detect_value_lp();

    rg_320 = pmu_get_register_value_lp(CHARGER_CON1, 0xFFFF, 0);

    rg_deb = rg_320 & 0xF00;
    rg_320 &= 0x1F00;
    pmu_force_set_register_value_lp(CHARGER_CON1, rg_320);

    rg_320 &= 0x1000;
    pmu_force_set_register_value_lp(CHARGER_CON1, rg_320);

    rg_320 = (oper << 12);
    pmu_force_set_register_value_lp(CHARGER_CON1, rg_320);
    hal_gpt_delay_us(250);

    rg_320 |= rg_deb;
    pmu_force_set_register_value_lp(CHARGER_CON1, rg_320);

    rg_320 |= 0xAA;
    pmu_force_set_register_value_lp(CHARGER_CON1, rg_320);

    vchg2 = pmu_get_chr_detect_value_lp();

    if (vchg1 != vchg2)
    {
        if (vchg2)
        {
            log_hal_msgid_info("[PMU_CHG]eoc_ctrl, pmu_eint, chg_in", 0);
            chg_int_flag |= CHG_INT_IN;
            pmu_chg_in_hdlr();

        }
        else
        {
            log_hal_msgid_info("[PMU_CHG]eoc_ctrl, pmu_eint, chg_out", 0);
            chg_int_flag |= CHG_INT_OUT;
            pmu_chg_out_hdlr();
        }
    }

    log_hal_msgid_info("[PMU_CHG]eoc_ctrl, oper[%d], rg_320[0x%X], rg_322[0x%X], reg_60A[0x%X], vchg1[%d], vchg2[%d]", 6,
    oper, rg_320, pmu_get_register_value_lp(0x322, 0xFFFF, 0), pmu_get_register_value_lp(0x60A, 0xFFFF, 0), vchg1, vchg2);
#else
    log_hal_msgid_error("[PMU_CHG]eoc_ctrl not support", 0);
#endif
}
#endif /* HAL_PMU_MODULE_ENABLED */
