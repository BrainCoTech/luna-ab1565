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

#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "nvkey.h"
#include "hal.h"
#include "nvkey_id_list.h"
#include "syslog.h"
#include "hal_pmu_cali_2565.h"
#include "hal_pmu_internal_2565.h"
#include "hal_pmu_charger_2565.h"
#include "assert.h"
#include "hal_flash_disk_internal.h"


#define UNUSED(x)  ((void)(x))
//#define AIR_PMU_DUMP_ENABLE

bat_cfg_t bat_cfg;
volt_dac_t otp_dac;
curr_val_t otp_curr;
cc_curr_t cc_curr;
vichg_adc_t otp_vichg;
uint8_t pmu_otp_dump;
uint8_t pmu_kflag;
uint16_t vbat_sel = 0;

const uint16_t bat_table[] = {
    4050,
    4100,
    4150,
    4200,
    4250,
    4300,
    4350,
    4400,
    4450,
    4500,
};

/************* transfer function *************/
int32_t pmu_range(int32_t val, int32_t min, int32_t max)
{
    int32_t ret = 0;

    if (val < min)
        ret = min;
    else if (val > max)
        ret = max;
    else
        ret = val;

    return ret;
}

int32_t pmu_round(int32_t val1, int32_t val2)
{
    int32_t ret = 0, tmp = 0;

    if (val2) {
        tmp = (val1 * 10) / val2;
        if (val1 > 0) {
            tmp += 5;
        } else {
            tmp -= 5;
        }

        ret = tmp / 10;
        //log_hal_msgid_info("[PMU_CAL]round, val1[%d], val2[%d], tmp[%d], result[%d]", 4, val1, val2, tmp, result);
    } else {
        log_hal_msgid_error("[PMU_CAL]round denominator=0 fail", 0);
        assert(0);
    }

    return ret;
}

uint16_t pmu_lerp(uint16_t volt1, uint16_t adc1, uint16_t volt2, uint16_t adc2, uint16_t volt_val)
{
    int16_t adc_val = 0;
    int16_t volt_diff = 0;
    int16_t adc_diff = 0;

    if (volt1 > volt2) {
        volt_diff = volt1 - volt2;
        adc_diff = adc1 - adc2;
    } else {
        volt_diff = volt2 - volt1;
        adc_diff = adc2 - adc1;
    }

    if (volt_val > volt2) {
        adc_val = adc2 + pmu_round((adc_diff * (volt_val - volt2)), volt_diff);
    } else if (volt_val < volt2) {
        adc_val = adc2 - pmu_round((adc_diff * (volt2 - volt_val)), volt_diff);
    } else {
        adc_val = adc2;
    }
    //log_hal_msgid_info("[PMU_CAL]lerp V1[%d] A1[%d] V2[%d] A2[%d] VC[%d] AC[%d]", 6, volt1, adc1, volt2,adc2, volt_val, adc_val);

    return adc_val;
}

uint8_t pmu_vdig_bg_lerp(uint16_t volt1, uint8_t sel1, uint16_t volt2, uint8_t sel2, uint16_t volt_val)
{
    int8_t sel_val1 = 0;
    uint8_t sel_val2 = 0;

    if (sel1 > sel2) {
        sel_val1 = sel1 + pmu_round(((sel1 - sel2 - 32) * (volt_val - volt1)), (volt1 - volt2));
    } else {
        sel_val1 = sel1 + pmu_round(((sel1 + 32 - sel2) * (volt_val - volt1)), (volt1 - volt2));
    }

    if (sel_val1 < 0) {
        sel_val2 = sel_val1 + 32;
    } else if (sel_val1 > 31) {
        sel_val2 = sel_val1 - 32;
    } else {
        sel_val2 = sel_val1;
    }

    //log_hal_msgid_info("[PMU_CAL]vdig_bg_lerp, V1[%d] S1[%d] V2[%d] S2[%d] VC[%d] sel_val1[%d], sel_val2[%d]", 7, volt1, sel1, volt2, sel2, volt_val, sel_val1, sel_val2);

    return sel_val2;
}

pmu_status_t pmu_get_nvkey(uint16_t id, uint8_t *ptr, uint32_t size)
{
    uint32_t len = 0;
    nvkey_status_t status = nvkey_data_item_length(id, &len);
    if ((status != NVKEY_STATUS_OK) || (len != size))
    {
        log_hal_msgid_error("[PMU_CAL]get_nvkey fail, id[0x%X], status[%d], len[%d], size[%d]", 4,
                            id, status, len, size);
        assert(0);
        return PMU_STATUS_ERROR;
    }
    status = nvkey_read_data(id, ptr, &len);
    if(status != NVKEY_STATUS_OK)
    {
        log_hal_msgid_error("[PMU_CAL]get_nvkey fail, id[0x%X], status[%d]", 2, id, status);
        assert(0);
        return PMU_STATUS_ERROR;
    }
    return PMU_STATUS_SUCCESS;
}

pmu_status_t pmu_set_nvkey(uint16_t id, uint8_t *ptr, uint32_t size)
{
    uint32_t len = 0;
    nvkey_status_t status = nvkey_data_item_length(id, &len);
    if ((status != NVKEY_STATUS_OK) || (len != size)) {
        log_hal_msgid_error("[PMU_CAL]set_nvkey fail, id[0x%X], status[%d], len[%d], size[%d]", 4,
                            id, status, len, size);
        assert(0);
        return PMU_STATUS_ERROR;
    }

    status = nvkey_write_data(id, ptr, len);
    if (status != NVKEY_STATUS_OK) {
        log_hal_msgid_error("[PMU_CAL]set_nvkey fail, id[0x%X], status[%d]", 2, id, status);
        assert(0);
        return PMU_STATUS_ERROR;
    }
    return PMU_STATUS_SUCCESS;
}

pmu_status_t pmu_get_otp(uint16_t addr, uint8_t *ptr, uint32_t size)
{
    hal_flash_status_t status = hal_flash_otp_read(addr, ptr, size);
    if (status != HAL_FLASH_STATUS_OK) {
        log_hal_msgid_error("[PMU_CAL]get_otp fail, otp_addr[%d], status[%d], size[%d]", 3, (addr - 256), status, size);
        assert(0);
        return PMU_STATUS_ERROR;
    }
    if ((addr < OTP_ADIE_VER_ADDR) && (addr != OTP_OCP_ADDR) && (ptr[0] != OTP_OK)) {
        log_hal_msgid_error("[PMU_CAL]get_otp fail, otp_addr[%d], kflag[%d]", 2, (addr - 256), ptr[0]);
        assert(0);
        return PMU_STATUS_ERROR;
    }
    return PMU_STATUS_SUCCESS;
}

/************* dump function *************/
void pmu_dump_otp_lp(void)
{
#if defined AIR_PMU_DUMP_ENABLE
    uint16_t addr;

    otp_vbat_t otp_0;
    addr = OTP_VBAT_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_0, sizeof(otp_0));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], volt0[%d], adc0[%d], volt1[%d], adc1[%d], volt2[%d], adc2[%d]", 8,
                       (addr - 256), otp_0.kflag, otp_0.data[0].volt, otp_0.data[0].adc,
                       otp_0.data[1].volt, otp_0.data[1].adc, otp_0.data[2].volt, otp_0.data[2].adc);

    otp_buck_ldo_vref_t otp_13;
    addr = OTP_BUCK_MV_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_13, sizeof(otp_13));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], volt0[%d], sel0[%d], volt1[%d], sel1[%d]", 6,
                       (addr - 256), otp_13.kflag, otp_13.data[0].volt, otp_13.data[0].sel, otp_13.data[1].volt, otp_13.data[1].sel);

    otp_buck_freq_t otp_20;
    addr = OTP_BUCK_MV_FREQ_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_20, sizeof(otp_20));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], freq[%d], freq_trim[%d], freqk_trim[%d]", 5,
                       (addr - 256), otp_20.kflag, otp_20.freq, otp_20.freq_trim, otp_20.freqk_trim);

    otp_buck_ldo_vref_t otp_25;
    addr = OTP_BUCK_MV_RET_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_25, sizeof(otp_25));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], volt0[%d], adc0[%d], volt1[%d], adc1[%d]", 6,
                       (addr - 256), otp_25.kflag, otp_25.data[0].volt, otp_25.data[0].sel, otp_25.data[1].volt, otp_25.data[1].sel);

    otp_buck_ldo_vref_t otp_32;
    addr = OTP_BUCK_LV_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_32, sizeof(otp_32));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], volt0[%d], adc0[%d], volt1[%d], adc1[%d]", 6,
                       (addr - 256), otp_32.kflag, otp_32.data[0].volt, otp_32.data[0].sel, otp_32.data[1].volt, otp_32.data[1].sel);

    otp_buck_freq_t otp_39;
    addr = OTP_BUCK_LV_FREQ_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_39, sizeof(otp_39));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], freq[%d], freq_trim[%d], freqk_trim[%d]", 5,
                       (addr - 256), otp_39.kflag, otp_39.freq, otp_39.freq_trim, otp_39.freqk_trim);


    otp_buck_ldo_vref_t otp_44;
    addr = OTP_LDO_VDIG18_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_44, sizeof(otp_44));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], volt0[%d], adc0[%d], volt1[%d], adc1[%d]", 6,
                       (addr - 256), otp_44.kflag, otp_44.data[0].volt, otp_44.data[0].sel, otp_44.data[1].volt, otp_44.data[1].sel);


    otp_buck_ldo_vref_t otp_51;
    addr = OTP_LDO_VRF_REG_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_51, sizeof(otp_51));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], volt0[%d], adc0[%d], volt1[%d], adc1[%d]", 6,
                       (addr - 256), otp_51.kflag, otp_51.data[0].volt, otp_51.data[0].sel, otp_51.data[1].volt, otp_51.data[1].sel);

    otp_buck_ldo_vref_t otp_58;
    addr = OTP_LDO_VRF_RET_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_58, sizeof(otp_58));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], volt0[%d], adc0[%d], volt1[%d], adc1[%d]", 6,
                       (addr - 256), otp_58.kflag, otp_58.data[0].volt, otp_58.data[0].sel, otp_58.data[1].volt, otp_58.data[1].sel);

    otp_buck_ldo_vref_t otp_65;
    addr = OTP_LDO_VDD33_REG_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_65, sizeof(otp_65));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], volt0[%d], adc0[%d], volt1[%d], adc1[%d]", 6,
                       (addr - 256), otp_65.kflag, otp_65.data[0].volt, otp_65.data[0].sel, otp_65.data[1].volt, otp_65.data[1].sel);

    otp_buck_ldo_vref_t otp_72;
    addr = OTP_LDO_VDD33_RET_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_72, sizeof(otp_72));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], volt0[%d], adc0[%d], volt1[%d], adc1[%d]", 6,
                       (addr - 256), otp_72.kflag, otp_72.data[0].volt, otp_72.data[0].sel, otp_72.data[1].volt, otp_72.data[1].sel);

    otp_buck_ldo_vref_t otp_79;
    addr = OTP_HPBG_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_79, sizeof(otp_79));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], volt0[%d], adc0[%d], volt1[%d], adc1[%d]", 6,
                       (addr - 256), otp_79.kflag, otp_79.data[0].volt, otp_79.data[0].sel, otp_79.data[1].volt, otp_79.data[1].sel);

    otp_buck_ldo_vref_t otp_86;
    addr = OTP_LPBG_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_86, sizeof(otp_86));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], volt0[%d], adc0[%d], volt1[%d], adc1[%d]", 6,
                       (addr - 256), otp_86.kflag, otp_86.data[0].volt, otp_86.data[0].sel, otp_86.data[1].volt, otp_86.data[1].sel);

    otp_buck_ldo_vref_t otp_93;
    addr = OTP_CHG_DAC_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_93, sizeof(otp_93));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], volt0[%d], adc0[%d], volt1[%d], adc1[%d]", 6,
                       (addr - 256), otp_93.kflag, otp_93.data[0].volt, otp_93.data[0].sel, otp_93.data[1].volt, otp_93.data[1].sel);

    otp_buck_ldo_vref_t otp_100;
    addr = OTP_VSYS_LDO_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_100, sizeof(otp_100));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], volt0[%d], adc0[%d], volt1[%d], adc1[%d]", 6,
                       (addr - 256), otp_100.kflag, otp_100.data[0].volt, otp_100.data[0].sel, otp_100.data[1].volt, otp_100.data[1].sel);

    otp_ocp_t otp_107;
    addr = OTP_OCP_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_107, sizeof(otp_107));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], load_switch_ocp_trim[%d], vsys_ldo_ocp_trim[%d]", 4,
                       (addr - 256), otp_107.kflag, otp_107.load_switch_ocp_trim, otp_107.vsys_ldo_ocp_trim);

    otp_chg_curr_t otp_110;
    addr = OTP_CHG_4V2_CURR_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_110, sizeof(otp_110));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], curr0[%d], val0[%d], curr1[%d], val1[%d], curr2[%d], val2[%d], curr3[%d], val3[%d]", 10,
                       (addr - 256), otp_110.kflag, otp_110.data[0].curr, otp_110.data[0].val, otp_110.data[1].curr, otp_110.data[1].val,
                       otp_110.data[2].curr, otp_110.data[2].val, otp_110.data[3].curr, otp_110.data[3].val);

    otp_chg_curr_t otp_124;
    addr = OTP_CHG_4V35_CURR_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_124, sizeof(otp_124));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], curr0[%d], val0[%d], curr1[%d], val1[%d], curr2[%d], val2[%d], curr3[%d], val3[%d]", 10,
                       (addr - 256), otp_124.kflag, otp_124.data[0].curr, otp_124.data[0].val, otp_124.data[1].curr, otp_124.data[1].val,
                       otp_124.data[2].curr, otp_124.data[2].val, otp_124.data[3].curr, otp_124.data[3].val);

    otp_vichg_adc_t otp_138;
    addr = OTP_VICHG_ADC_VAL_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_138, sizeof(otp_138));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kflag[%d], adc_4v35[%d], adc_4v2[%d], adc_4v05[%d]", 5,
                       (addr - 256), otp_138.kflag, otp_138.adc_4v35, otp_138.adc_4v2, otp_138.adc_4v05);

    uint8_t otp_145;
    addr = OTP_ADIE_VER_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_145, sizeof(otp_145));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], adie_ver[%d]", 2, (addr - 256), otp_145);

    uint8_t otp_147;
    addr = OTP_ADIE_KGD_ADDR;
    pmu_get_otp(addr, (uint8_t *)&otp_147, sizeof(otp_147));
    log_hal_msgid_info("[PMU_CAL]otp_dump, addr[%d], kgd_ver[%d]", 2, (addr - 256), otp_147);
#endif
}

void pmu_dump_nvkey_lp(void)
{
#if defined (AIR_PMU_DUMP_ENABLE)
    uint16_t id = 0;

    chg_cfg_t nv_00;
    id = NVID_CAL_CHG_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_00, sizeof(nv_00));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], otp_dump[%d], bat_volt_sel[%d], two_step_en[%d], kflag[%d]",
                       5, id, nv_00.otp_dump, nv_00.bat_volt_sel, nv_00.two_step_en, nv_00.kflag);

    chg_adc_cfg_t nv_01;
    id = NVID_CAL_CHG_ADC_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_01, sizeof(nv_01));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], cc1_volt[%d], cc1_adc[%d], cc2_volt[%d], cc2_adc[%d], "
                       "cv_volt[%d], cv_adc[%d], rechg_volt[%d], rechg_adc[%d]",
                       9, id, nv_01.cc1_thrd_volt, nv_01.cc1_thrd_adc, nv_01.cc2_thrd_volt, nv_01.cc2_thrd_adc,
                       nv_01.cv_thrd_volt, nv_01.cv_thrd_adc, nv_01.rechg_volt, nv_01.rechg_adc);

    chg_dac_cfg_t nv_02;
    id = NVID_CAL_INT_CHG_DAC_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_02, sizeof(nv_02));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], tri_curr_dac[%d], cc1_curr_dac[%d], cc2_curr_dac[%d], cv_dac[%d]",
                       5, id, nv_02.tri_curr_dac, nv_02.cc1_curr_dac, nv_02.cc2_curr_dac, nv_02.cv_dac);

    chg_tri_curr_cfg_t nv_03;
    id = NVID_CAL_INT_CHG_TRI_CURR_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_03, sizeof(nv_03));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], cal_cnt[%d], sel[%d], curr[%d], sel[%d]",
                       5, id, nv_03.cal_cnt, nv_03.sel, nv_03.data[0].curr, nv_03.data[0].sel);

    chg_cc_curr_cfg_t nv_04;
    id = NVID_CAL_INT_CHG_CC1_CURR_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_04, sizeof(nv_04));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], cal_cnt[%d], sel[%d], curr[%d], sel[%d]",
                       5, id, nv_04.cal_cnt, nv_04.sel, nv_04.data[0].curr, nv_04.data[0].sel);

    chg_cc_curr_cfg_t nv_05;
    id = NVID_CAL_INT_CHG_CC2_CURR_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_05, sizeof(nv_05));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], cal_cnt[%d], sel[%d], curr[%d], sel[%d]",
                       5, id, nv_05.cal_cnt, nv_05.sel, nv_05.data[0].curr, nv_05.data[0].sel);

    cv_stop_curr_cfg_t nv_06;
    id = NVID_CAL_CV_STOP_CURR_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_06, sizeof(nv_06));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], cal_cnt[%d], sel[%d], perc[%d], adc[%d]",
                       5, id, nv_06.cal_cnt, nv_06.sel, nv_06.cv_stop_curr[0].perc, nv_06.cv_stop_curr[0].adc);

    sys_ldo_t nv_07;
    id = NVID_CAL_SYS_LDO;
    pmu_get_nvkey(id, (uint8_t *)&nv_07, sizeof(nv_07));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], sysldo_output_volt[%d], chg_ldo_sel[%d]",
                       3, id, nv_07.sysldo_output_volt, nv_07.chg_ldo_sel);

    ocp_t nv_08;
    id = NVID_CAL_OCP;
    pmu_get_nvkey(id, (uint8_t *)&nv_08, sizeof(nv_08));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], sw_oc_lmt[%d], i_lim_trim[%d]",
                       3, id, nv_08.sw_oc_lmt, nv_08.i_lim_trim);

    jeita_t nv_09;
    id = NVID_CAL_JEITA;
    pmu_get_nvkey(id, (uint8_t *)&nv_09, sizeof(nv_09));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], cool_state_curr_perc[%d], cool_state_dac_dec[%d], warm_state_curr_perc[%d], warm_state_dac_dec[%d]",
                       5, id, nv_09.cool_state_curr_perc, nv_09.cool_state_dac_dec, nv_09.warm_state_curr_perc, nv_09.warm_state_dac_dec);

    jeita_cfg_t nv_0A;
    id = NVID_CAL_JEITA_WARM;
    pmu_get_nvkey(id, (uint8_t *)&nv_0A, sizeof(nv_0A));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], cc2_volt[%d], cc2_adc[%d], cv_volt[%d], cv_adc[%d], "
                       "rechg_volt[%d], rechg_adc[%d]",
                       7, id, nv_0A.cc2_thrd_volt, nv_0A.cc2_thrd_adc, nv_0A.cv_thrd_volt, nv_0A.cv_thrd_adc, nv_0A.rechg_volt, nv_0A.rechg_adc);
    log_hal_msgid_info("                  cc1_dac[%d], cc2_dac[%d], cv_dac[%d], cc1_curr[%d], cc1_rsel[%d], "
                       "cc2_curr[%d], cc2_rsel[%d], cv_stop_curr[%d]",
                       8, nv_0A.cc1_curr_dac, nv_0A.cc2_curr_dac, nv_0A.cv_dac, nv_0A.cc1_curr, nv_0A.cc1_rsel,
                       nv_0A.cc2_curr, nv_0A.cc2_rsel, nv_0A.cv_stop_curr_adc);

    jeita_cfg_t nv_0B;
    id = NVID_CAL_JEITA_COOL;
    pmu_get_nvkey(id, (uint8_t *)&nv_0B, sizeof(nv_0B));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], cc2_volt[%d], cc2_adc[%d], cv_volt[%d], cv_adc[%d], "
                       "rechg_volt[%d], rechg_adc[%d]",
                       7, id, nv_0B.cc2_thrd_volt, nv_0B.cc2_thrd_adc, nv_0B.cv_thrd_volt, nv_0B.cv_thrd_adc, nv_0B.rechg_volt, nv_0B.rechg_adc);
    log_hal_msgid_info("                  cc1_dac[%d], cc2_dac[%d], cv_dac[%d], cc1_curr[%d], cc1_rsel[%d], "
                       "cc2_curr[%d], cc2_rsel[%d], cv_stop_curr[%d]",
                       8, nv_0B.cc1_curr_dac, nv_0B.cc2_curr_dac, nv_0B.cv_dac, nv_0B.cc1_curr, nv_0B.cc1_rsel,
                       nv_0B.cc2_curr, nv_0B.cc2_rsel, nv_0B.cv_stop_curr_adc);


    buck_ldo_cfg_t nv_30;
    id = NVID_CAL_BUCK_MV_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_30, sizeof(nv_30));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], volt0[%d], sel0[%d], volt1[%d], sel1[%d], cal_cnt[%d], sel[%d], volt[%d], sel[%d]",
                       10, id, nv_30.kflag, nv_30.otp[0].volt, nv_30.otp[0].sel, nv_30.otp[1].volt, nv_30.otp[1].sel,
                       nv_30.cal_cnt, nv_30.sel, nv_30.data[0].volt, nv_30.data[0].sel);

    buck_ldo_cfg_t nv_31;
    id = NVID_CAL_BUCK_MV_STB_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_31, sizeof(nv_31));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], volt0[%d], sel0[%d], volt1[%d], sel1[%d], cal_cnt[%d], sel[%d], volt[%d], sel[%d]",
                       10, id, nv_31.kflag, nv_31.otp[0].volt, nv_31.otp[0].sel, nv_31.otp[1].volt, nv_31.otp[1].sel,
                       nv_31.cal_cnt, nv_31.sel, nv_31.data[0].volt, nv_31.data[0].sel);

    buck_freq_65_t nv_12;
    id = NVID_CAL_BUCK_MV_FREQ;
    pmu_get_nvkey(id, (uint8_t *)&nv_12, sizeof(nv_12));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], buck_freq[%d], osc_freqk[%d]",
                       4, id, nv_12.kflag, nv_12.buck_freq, nv_12.osc_freqk);

    buck_ldo_cfg_t nv_32;
    id = NVID_CAL_BUCK_LV_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_32, sizeof(nv_32));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], volt0[%d], sel0[%d], volt1[%d], sel1[%d], cal_cnt[%d], sel[%d], volt[%d], sel[%d]",
                       10, id, nv_32.kflag, nv_32.otp[0].volt, nv_32.otp[0].sel, nv_32.otp[1].volt, nv_32.otp[1].sel,
                       nv_32.cal_cnt, nv_32.sel, nv_32.data[0].volt, nv_32.data[0].sel);

    buck_ldo_cfg_t nv_33;
    id = NVID_CAL_BUCK_LV_LPM;
    pmu_get_nvkey(id, (uint8_t *)&nv_33, sizeof(nv_33));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], volt0[%d], sel0[%d], volt1[%d], sel1[%d], cal_cnt[%d], sel[%d], volt[%d], sel[%d]",
                       10, id, nv_33.kflag, nv_33.otp[0].volt, nv_33.otp[0].sel, nv_33.otp[1].volt, nv_33.otp[1].sel,
                       nv_33.cal_cnt, nv_33.sel, nv_33.data[0].volt, nv_33.data[0].sel);

    buck_freq_65_t nv_15;
    id = NVID_CAL_BUCK_LV_FREQ;
    pmu_get_nvkey(id, (uint8_t *)&nv_15, sizeof(nv_15));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], buck_freq[%d], osc_freqk[%d]",
                       4, id, nv_12.kflag, nv_12.buck_freq, nv_12.osc_freqk);

    buck_ldo_cfg_t nv_16;
    id = NVID_CAL_LDO_VDD33_REG_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_16, sizeof(nv_16));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], volt0[%d], sel0[%d], volt1[%d], sel1[%d], cal_cnt[%d], sel[%d], volt[%d], sel[%d]",
                       10, id, nv_16.kflag, nv_16.otp[0].volt, nv_16.otp[0].sel, nv_16.otp[1].volt, nv_16.otp[1].sel,
                       nv_16.cal_cnt, nv_16.sel, nv_16.data[0].volt, nv_16.data[0].sel);

    buck_ldo_cfg_t nv_17;
    id = NVID_CAL_LDO_VDD33_REG_RET_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_17, sizeof(nv_17));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], volt0[%d], sel0[%d], volt1[%d], sel1[%d], cal_cnt[%d], sel[%d], volt[%d], sel[%d]",
                       10, id, nv_17.kflag, nv_17.otp[0].volt, nv_17.otp[0].sel, nv_17.otp[1].volt, nv_17.otp[1].sel,
                       nv_17.cal_cnt, nv_17.sel, nv_17.data[0].volt, nv_17.data[0].sel);

    buck_ldo_cfg_t nv_18;
    id = NVID_CAL_LDO_VDD33_RET_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_18, sizeof(nv_18));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], volt0[%d], sel0[%d], volt1[%d], sel1[%d], cal_cnt[%d], sel[%d], volt[%d], sel[%d]",
                       10, id, nv_18.kflag, nv_18.otp[0].volt, nv_18.otp[0].sel, nv_18.otp[1].volt, nv_18.otp[1].sel,
                       nv_18.cal_cnt, nv_18.sel, nv_18.data[0].volt, nv_18.data[0].sel);

    buck_ldo_cfg_t nv_19;
    id = NVID_CAL_LDO_VRF_REG_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_19, sizeof(nv_19));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], volt0[%d], sel0[%d], volt1[%d], sel1[%d], cal_cnt[%d], sel[%d], volt[%d], sel[%d]",
                       10, id, nv_19.kflag, nv_19.otp[0].volt, nv_19.otp[0].sel, nv_19.otp[1].volt, nv_19.otp[1].sel,
                       nv_19.cal_cnt, nv_19.sel, nv_19.data[0].volt, nv_19.data[0].sel);

    buck_ldo_cfg_t nv_1A;
    id = NVID_CAL_LDO_VRF_REG_RET_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_1A, sizeof(nv_1A));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], volt0[%d], sel0[%d], volt1[%d], sel1[%d], cal_cnt[%d], sel[%d], volt[%d], sel[%d]",
                       10, id, nv_1A.kflag, nv_1A.otp[0].volt, nv_1A.otp[0].sel, nv_1A.otp[1].volt, nv_1A.otp[1].sel,
                       nv_1A.cal_cnt, nv_1A.sel, nv_1A.data[0].volt, nv_1A.data[0].sel);

    buck_ldo_cfg_t nv_1B;
    id = NVID_CAL_LDO_VRF_RET_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_1B, sizeof(nv_1B));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], volt0[%d], sel0[%d], volt1[%d], sel1[%d], cal_cnt[%d], sel[%d], volt[%d], sel[%d]",
                       10, id, nv_1B.kflag, nv_1B.otp[0].volt, nv_1B.otp[0].sel, nv_1B.otp[1].volt, nv_1B.otp[1].sel,
                       nv_1B.cal_cnt, nv_1B.sel, nv_1B.data[0].volt, nv_1B.data[0].sel);

    buck_ldo_cfg_t nv_1C;
    id = NVID_CAL_VDIG18_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_1C, sizeof(nv_1C));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], volt0[%d], sel0[%d], volt1[%d], sel1[%d], cal_cnt[%d], sel[%d], volt[%d], sel[%d]",
                       10, id, nv_1C.kflag, nv_1C.otp[0].volt, nv_1C.otp[0].sel, nv_1C.otp[1].volt, nv_1C.otp[1].sel,
                       nv_1C.cal_cnt, nv_1C.sel, nv_1C.data[0].volt, nv_1C.data[0].sel);

    bg_cfg_t nv_1D;
    id = NVID_CAL_HPBG_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_1D, sizeof(nv_1D));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], volt0[%d], sel0[%d], "
                       "volt1[%d], sel1[%d], cal_cnt[%d], sel[%d], volt[%d], sel[%d]",
                       10, id, nv_1D.kflag, nv_1D.otp[0].volt, nv_1D.otp[0].sel, nv_1D.otp[1].volt, nv_1D.otp[1].sel,
                       nv_1D.cal_cnt, nv_1D.sel, nv_1D.data[0].volt, nv_1D.data[0].sel);

    bg_cfg_t nv_1E;
    id = NVID_CAL_LPBG_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_1E, sizeof(nv_1E));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], volt0[%d], sel0[%d], "
                       "volt1[%d], sel1[%d], cal_cnt[%d], sel[%d], volt[%d], sel[%d]",
                       10, id, nv_1E.kflag, nv_1E.otp[0].volt, nv_1E.otp[0].sel, nv_1E.otp[1].volt, nv_1E.otp[1].sel,
                       nv_1E.cal_cnt, nv_1E.sel, nv_1E.data[0].volt, nv_1E.data[0].sel);

    vbat_adc_cal_t nv_20;
    id = NVID_CAL_VBAT_ADC_CAL_TABLE;
    pmu_get_nvkey(id, (uint8_t *)&nv_20, sizeof(nv_20));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], cal_cnt[%d], volt1[%d], adc1[%d]",
                       5, id, nv_20.kflag, nv_20.cal_cnt, nv_20.data[0].volt, nv_20.data[0].adc);

    vbat_volt_cfg_t nv_21;
    id = NVID_CAL_VBAT_VOLT_CFG;
    pmu_get_nvkey(id, (uint8_t *)&nv_21, sizeof(nv_21));
    log_hal_msgid_info("[PMU_CAL]nv_dump, id[0x%X], kflag[%d], init_bat_volt[%d], init_bat_adc[%d], sd_bat_volt[%d], sd_bat_adc[%d]",
                       6, id, nv_21.kflag, nv_21.init_bat.volt, nv_21.init_bat.adc, nv_21.sd_bat.volt, nv_21.sd_bat.adc);
    log_hal_msgid_info("                  volt0[%d], adc1[%d], volt1[%d], adc1[%d], volt2[%d], adc2[%d], "
                       "volt3[%d], adc3[%d], volt4[%d], adc4[%d]",
                       10,
                       nv_21.data[0].volt, nv_21.data[0].adc,
                       nv_21.data[1].volt, nv_21.data[1].adc,
                       nv_21.data[2].volt, nv_21.data[2].adc,
                       nv_21.data[3].volt, nv_21.data[3].adc,
                       nv_21.data[4].volt, nv_21.data[4].adc
                      );
    log_hal_msgid_info("                  volt5[%d], adc5[%d], volt6[%d], adc6[%d], volt7[%d], adc7[%d], "
                       "volt8[%d], adc8[%d], volt9[%d], adc9[%d], ",
                       10,
                       nv_21.data[5].volt, nv_21.data[5].adc,
                       nv_21.data[6].volt, nv_21.data[6].adc,
                       nv_21.data[7].volt, nv_21.data[7].adc,
                       nv_21.data[8].volt, nv_21.data[8].adc,
                       nv_21.data[9].volt, nv_21.data[9].adc);
#endif
}

/****************SLT function****************/
void pmu_slt_vcore_cfg(uint16_t volt)//pmu_slt_vcore_cfg
{
    buck_ldo_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_BUCK_LV_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        log_hal_msgid_error("[PMU_SLT]vcore_cfg fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }

    uint8_t sel = pmu_lerp(nvkey.otp[0].volt, nvkey.otp[0].sel, nvkey.otp[1].volt, nvkey.otp[1].sel, volt);
    sel = pmu_range(sel, 0, 255);
    pmu_set_register_value_lp(BUCK_VSEL_LV_ADDR, BUCK_VSEL_LV_MASK, BUCK_VSEL_LV_SHIFT, sel);
    //log_hal_msgid_info("[PMU_SLT]vcore_cfg, VCORE[0.%dV]", 1, volt);
}

/*******************pmu_set_init********************/
void pmu_set_chg_cfg(void)
{
    chg_cfg_t nvkey;
    uint16_t id = NVID_CAL_CHG_CFG;
    if (pmu_get_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    otp_vbat_t otp;
    if (pmu_get_otp(OTP_VBAT_ADDR, (uint8_t *)&otp, sizeof(otp)) != PMU_STATUS_SUCCESS) {
        return;
    }

    bat_cfg.two_step_en = nvkey.two_step_en;
    bat_cfg.volt_sel = nvkey.bat_volt_sel;

    vbat_sel = bat_table[bat_cfg.volt_sel];

    if (vbat_sel > 4200) {
        bat_cfg.volt1 = otp.data[0].volt;//4.35V
        bat_cfg.adc1 = otp.data[0].adc;
    } else {
        bat_cfg.volt1 = otp.data[1].volt;//4.2V
        bat_cfg.adc1 = otp.data[1].adc;
    }

    bat_cfg.volt2 = otp.data[2].volt;//3.0v
    bat_cfg.adc2 = otp.data[2].adc;
}
#ifndef AIR_PMU_DISABLE_CHARGER
void pmu_set_chg_adc_cfg(void)
{
    chg_adc_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_CHG_ADC_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    pmu_set_register_value_lp(CC1_THRESHOLD_ADDR, CC1_THRESHOLD_MASK, CC1_THRESHOLD_SHIFT, nvkey.cc1_thrd_adc);
    pmu_set_register_value_lp(CC2_THRESHOLD_ADDR, CC2_THRESHOLD_MASK, CC2_THRESHOLD_SHIFT, nvkey.cc2_thrd_adc);
    pmu_set_register_value_lp(CV_THRESHOLD_ADDR, CV_THRESHOLD_MASK, CV_THRESHOLD_SHIFT, nvkey.cv_thrd_adc);
    pmu_set_register_value_lp(RECHARGE_THRESHOLD_ADDR, RECHARGE_THRESHOLD_MASK, RECHARGE_THRESHOLD_SHIFT, nvkey.rechg_adc);


    pmu_set_register_value_lp(CHG_COMPLETE_CHK_NUM2_ADDR, CHG_COMPLETE_CHK_NUM2_MASK, CHG_COMPLETE_CHK_NUM2_SHIFT, 0xF);
}

void pmu_set_chg_dac_cfg(void)
{
    chg_dac_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_INT_CHG_DAC_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    pmu_set_register_value_lp(TRICKLE_DAC_VALUE_ADDR, TRICKLE_DAC_VALUE_MASK, TRICKLE_DAC_VALUE_SHIFT, nvkey.tri_curr_dac);
    pmu_set_register_value_lp(TRICKLE_DAC_OUT_UPDATE_ADDR, TRICKLE_DAC_OUT_UPDATE_MASK, TRICKLE_DAC_OUT_UPDATE_SHIFT, 1);

    pmu_set_register_value_lp(CC1_DAC_VALUE_ADDR, CC1_DAC_VALUE_MASK, CC1_DAC_VALUE_SHIFT, nvkey.cc1_curr_dac);
    pmu_set_register_value_lp(CC1_DAC_OUT_UPDATE_ADDR, CC1_DAC_OUT_UPDATE_MASK, CC1_DAC_OUT_UPDATE_SHIFT, 1);

    pmu_set_register_value_lp(CC2_DAC_VALUE_ADDR, CC2_DAC_VALUE_MASK, CC2_DAC_VALUE_SHIFT, nvkey.cc2_curr_dac);
    pmu_set_register_value_lp(CC2_DAC_OUT_UPDATE_ADDR, CC2_DAC_OUT_UPDATE_MASK, CC2_DAC_OUT_UPDATE_SHIFT, 1);

    pmu_set_register_value_lp(CV_DAC_VALUE_ADDR, CV_DAC_VALUE_MASK, CV_DAC_VALUE_SHIFT, nvkey.cv_dac);
    pmu_set_register_value_lp(CV_DAC_OUT_UPDATE_ADDR, CV_DAC_OUT_UPDATE_MASK, CV_DAC_OUT_UPDATE_SHIFT, 1);
}

void pmu_set_chg_tri_curr_cfg(void)
{
    chg_tri_curr_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_INT_CHG_TRI_CURR_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    pmu_set_register_value_lp(TRICKLE_RCHG_SEL_ADDR, TRICKLE_RCHG_SEL_MASK, TRICKLE_RCHG_SEL_SHIFT, nvkey.data[nvkey.sel - 1].sel);
    pmu_set_register_value_lp(TRICKLE_RCHG_SEL_UPDATE_ADDR, TRICKLE_RCHG_SEL_UPDATE_MASK, TRICKLE_RCHG_SEL_UPDATE_SHIFT, 1);
}

void pmu_set_chg_cc1_curr_cfg(void)
{
    chg_cc_curr_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_INT_CHG_CC1_CURR_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    chg_rsel.cc1[PMU_RSEL_NORM] = nvkey.data[nvkey.sel - 1].sel;
    pmu_chg_rsel_ctl(PMU_RSEL_NORM);
}

void pmu_set_chg_cc2_curr_cfg(void)
{
    chg_cc_curr_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_INT_CHG_CC2_CURR_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    chg_rsel.cc2[PMU_RSEL_NORM] = nvkey.data[nvkey.sel - 1].sel;

    if (bat_cfg.two_step_en) {
        pmu_set_register_value_lp(CC2_EN_ADDR, CC2_EN_MASK, CC2_EN_SHIFT, 1);
    }

    pmu_chg_rsel_ctl(PMU_RSEL_NORM);
}

void pmu_set_chg_cv_stop_curr_adc(void)
{
    cv_stop_curr_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_CV_STOP_CURR_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    pmu_set_register_value_lp(CV_STOP_CURRENT_ADDR, CV_STOP_CURRENT_MASK, CV_STOP_CURRENT_SHIFT, nvkey.cv_stop_curr[nvkey.sel - 1].adc);
}
#endif

void pmu_set_sys_ldo(void)
{
    sys_ldo_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_SYS_LDO, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    uint16_t ret = 0;
    uint16_t ldo_sel = nvkey.chg_ldo_sel;
    uint16_t vbat = bat_table[bat_cfg.volt_sel];

    if (vbat >= 4300) {
        ret = ldo_sel + 1;
    } else {
        if (ldo_sel) {
            ret = ldo_sel - 1;
        } else {
            ret = 0;
        }
    }
    ret = pmu_range(ret, 0, 7);
    pmu_set_register_value_lp(CHG_LDO_SEL_ADDR, CHG_LDO_SEL_MASK, CHG_LDO_SEL_SHIFT, ret);

    log_hal_msgid_info("[PMU_CAL]set_sys_ldo, vbat[%d], ldo_sel[%d], ret[%d], rg_324[0x%X]", 4,
                       vbat, ldo_sel, ret, pmu_get_register_value(0x324, 0xFFFF, 0));
}

void pmu_set_ocp(void)
{
    ocp_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_OCP, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    pmu_set_register_value_lp(SW_OC_LMT_ADDR, SW_OC_LMT_MASK, SW_OC_LMT_SHIFT, nvkey.sw_oc_lmt);
    pmu_set_register_value_lp(I_LIM_TRIM_ADDR, I_LIM_TRIM_MASK, I_LIM_TRIM_SHIFT, nvkey.i_lim_trim);
}

/*******************BUCK********************/
void pmu_set_buck_mv(void)
{
    buck_ldo_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_BUCK_MV_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        //log_hal_msgid_error("[PMU_CAL]set_buck_mv fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }
    pmu_set_register_value_lp(BUCK_VSEL_MV_ADDR, BUCK_VSEL_MV_MASK, BUCK_VSEL_MV_SHIFT, nvkey.data[nvkey.sel - 1].sel);
}

void pmu_set_buck_mv_stb(void)
{
    buck_ldo_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_BUCK_MV_STB_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        //log_hal_msgid_error("[PMU_CAL]set_buck_mv_stb fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }
    pmu_set_register_value_lp(MV_STB_SEL_ADDR, MV_STB_SEL_MASK, MV_STB_SEL_SHIFT, nvkey.data[nvkey.sel - 1].sel);
}

void pmu_set_buck_mv_freq(void)
{
    buck_freq_65_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_BUCK_MV_FREQ, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        //log_hal_msgid_error("[PMU_CAL]set_buck_mv_freq fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }
    pmu_set_register_value_lp(BUCK_FREQ_MV_ADDR, BUCK_FREQ_MV_MASK, BUCK_FREQ_MV_SHIFT, nvkey.buck_freq);
    pmu_set_register_value_lp(OSC_FREQK_MV_ADDR, OSC_FREQK_MV_MASK, OSC_FREQK_MV_SHIFT, nvkey.osc_freqk);
}

void pmu_set_buck_lv(void)
{
    buck_ldo_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_BUCK_LV_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        //log_hal_msgid_error("[PMU_CAL]set_buck_lv fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }
    pmu_set_register_value_lp(BUCK_VSEL_LV_ADDR, BUCK_VSEL_LV_MASK, BUCK_VSEL_LV_SHIFT, nvkey.data[nvkey.sel - 1].sel);

#ifdef AIR_PMU_DISABLE_CHARGER
    pmu_set_register_value_lp(BUCK_LVOUTSEL_LV_NORM_ADDR, BUCK_LVOUTSEL_LV_NORM_MASK, BUCK_LVOUTSEL_LV_NORM_SHIFT, 0x0);
    log_hal_msgid_info("[PMU_CAL]set_buck_lv, vcore 0.9V", 0);
#endif
}

void pmu_set_buck_lv_lpm(void)
{
    buck_ldo_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_BUCK_LV_LPM, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        //log_hal_msgid_error("[PMU_CAL]set_buck_lv_lpm fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }
    pmu_set_register_value_lp(BUCK_VSEL_LV_ADDR, BUCK_VSEL_LV_MASK, BUCK_VSEL_LV_SHIFT, nvkey.data[nvkey.sel - 1].sel);
}

void pmu_set_buck_lv_freq(void)
{
    buck_freq_65_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_BUCK_LV_FREQ, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        //log_hal_msgid_error("[PMU_CAL]set_buck_mv_freq fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }
    pmu_set_register_value_lp(BUCK_FREQ_LV_ADDR, BUCK_FREQ_LV_MASK, BUCK_FREQ_LV_SHIFT, nvkey.buck_freq);
    pmu_set_register_value_lp(OSC_FREQK_LV_ADDR, OSC_FREQK_LV_MASK, OSC_FREQK_LV_SHIFT, nvkey.osc_freqk);
}

/*******************LDO********************/
void pmu_set_ldo_vdd33_reg(void)
{
    buck_ldo_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_LDO_VDD33_REG_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        //log_hal_msgid_error("[PMU_CAL]set_ldo_vdd33_reg fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }
    pmu_set_register_value_lp(REGHV_SEL_NM_ADDR, REGHV_SEL_NM_MASK, REGHV_SEL_NM_SHIFT, nvkey.data[nvkey.sel - 1].sel);
}

void pmu_set_ldo_vdd33_reg_ret(void)
{
    buck_ldo_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_LDO_VDD33_REG_RET_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        //log_hal_msgid_error("[PMU_CAL]set_ldo_vdd33_reg_ret fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }
    pmu_set_register_value_lp(REGHV_SEL_RET_ADDR, REGHV_SEL_RET_MASK, REGHV_SEL_RET_SHIFT, nvkey.data[nvkey.sel - 1].sel);
}

void pmu_set_ldo_vdd33_ret(void)
{
    buck_ldo_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_LDO_VDD33_RET_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        //log_hal_msgid_error("[PMU_CAL]set_ldo_vdd33_ret fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }
    pmu_set_register_value_lp(HVSTBSEL_ADDR, HVSTBSEL_MASK, HVSTBSEL_SHIFT, nvkey.data[nvkey.sel - 1].sel);
}

void pmu_set_ldo_vrf_reg(void)
{
    buck_ldo_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_LDO_VRF_REG_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        //log_hal_msgid_error("[PMU_CAL]set_ldo_vrf_reg fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }
    pmu_set_register_value_lp(REGLV2_SEL_NM_ADDR, REGLV2_SEL_NM_MASK, REGLV2_SEL_NM_SHIFT, nvkey.data[nvkey.sel - 1].sel);
}

void pmu_set_ldo_vrf_reg_ret(void)
{
    buck_ldo_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_LDO_VRF_REG_RET_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        //log_hal_msgid_error("[PMU_CAL]set_ldo_vrf_reg_ret fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }
    pmu_set_register_value_lp(REGLV2_SEL_RET_ADDR, REGLV2_SEL_RET_MASK, REGLV2_SEL_RET_SHIFT, nvkey.data[nvkey.sel - 1].sel);
}

void pmu_set_ldo_vrf_ret(void)
{
    buck_ldo_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_LDO_VRF_RET_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        //log_hal_msgid_error("[PMU_CAL]set_ldo_vrf_ret fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }
    pmu_set_register_value_lp(LV3_STB_REGSEL_ADDR, LV3_STB_REGSEL_MASK, LV3_STB_REGSEL_SHIFT, nvkey.data[nvkey.sel - 1].sel);
}

void pmu_set_ldo_vdig18(void)
{
    buck_ldo_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_VDIG18_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        //log_hal_msgid_error("[PMU_CAL]set_ldo_vdig18 fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }
    pmu_set_register_value_lp(VDIG18_SEL_ADDR, VDIG18_SEL_MASK, VDIG18_SEL_SHIFT, nvkey.data[nvkey.sel - 1].sel);
}

/*******************VRF********************/
void pmu_set_hpbg(void)
{
    bg_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_HPBG_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        //log_hal_msgid_error("[PMU_CAL]set_hpbg fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }
    pmu_set_register_value_lp(BGR_TRIM_ADDR, BGR_TRIM_MASK, BGR_TRIM_SHIFT, nvkey.data[nvkey.sel - 1].sel);
    hal_gpt_delay_ms(30);
    pmu_set_register_value_lp(0x00E, FAST_BUFFER_ENB_MASK, 2, 0x1);
}

void pmu_set_lpbg(void)
{
    bg_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_LPBG_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != CAL_DONE) {
        //log_hal_msgid_error("[PMU_CAL]set_lpbg fail, kflag[%d]", 1, nvkey.kflag);
        return;
    }
    pmu_set_register_value_lp(BGR_TRIM_ADDR, BGR_TRIM_MASK, BGR_TRIM_SHIFT, nvkey.data[nvkey.sel - 1].sel);
}

/*******************pmu_cal_init********************/
#ifndef AIR_PMU_DISABLE_CHARGER
void pmu_cal_vbat_adc(void)
{
    vbat_adc_cal_t nvkey;
    uint16_t id = NVID_CAL_VBAT_ADC_CAL_TABLE;
    if (pmu_get_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    otp_vbat_t otp;
    if (pmu_get_otp(OTP_VBAT_ADDR, (uint8_t *)&otp, sizeof(otp)) != PMU_STATUS_SUCCESS) {
        return;
    }
    vbat_sel = bat_table[bat_cfg.volt_sel];

    if (vbat_sel > 4200) {
        bat_cfg.volt1 = otp.data[0].volt;//4.35V
        bat_cfg.adc1 = otp.data[0].adc;
    } else {
        bat_cfg.volt1 = otp.data[1].volt;//4.2V
        bat_cfg.adc1 = otp.data[1].adc;
    }

    bat_cfg.volt2 = otp.data[2].volt;//3.0v
    bat_cfg.adc2 = otp.data[2].adc;

    for(uint8_t i = 0; i < nvkey.cal_cnt; i++)
    {
        nvkey.data[i].adc = pmu_lerp(bat_cfg.volt1, bat_cfg.adc1, bat_cfg.volt2, bat_cfg.adc2, nvkey.data[i].volt);
        nvkey.data[i].adc = pmu_range(nvkey.data[i].adc, 0, 1023);
    }
    nvkey.kflag = CAL_DONE;

    pmu_set_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey));
}

void pmu_cal_vbat_volt(void)
{
    vbat_volt_cfg_t nvkey;
    uint16_t id = NVID_CAL_VBAT_VOLT_CFG;
    if (pmu_get_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    nvkey.init_bat.adc = pmu_lerp(bat_cfg.volt1, bat_cfg.adc1, bat_cfg.volt2, bat_cfg.adc2, nvkey.init_bat.volt);
    nvkey.sd_bat.adc   = pmu_lerp(bat_cfg.volt1, bat_cfg.adc1, bat_cfg.volt2, bat_cfg.adc2, nvkey.sd_bat.volt);

    for (uint8_t i = 0; i < 18; i++) {
        if (nvkey.data[i].volt == 0) {
            if (i < 10) {
                assert(0);
            }
            continue;
        }
        nvkey.data[i].adc = pmu_lerp(bat_cfg.volt1, bat_cfg.adc1, bat_cfg.volt2, bat_cfg.adc2, nvkey.data[i].volt);
        nvkey.data[i].adc = pmu_range(nvkey.data[i].adc, 0, 1023);
    }
    nvkey.kflag = CAL_DONE;

    pmu_set_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey));
}


void pmu_cal_chg_adc(void)
{
    chg_adc_cfg_t nvkey;
    uint16_t id = NVID_CAL_CHG_ADC_CFG;
    if (pmu_get_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    nvkey.cc1_thrd_adc = pmu_lerp(bat_cfg.volt1, bat_cfg.adc1, bat_cfg.volt2, bat_cfg.adc2, nvkey.cc1_thrd_volt);
    nvkey.cc2_thrd_adc = pmu_lerp(bat_cfg.volt1, bat_cfg.adc1, bat_cfg.volt2, bat_cfg.adc2, nvkey.cc2_thrd_volt);
    nvkey.cv_thrd_adc  = pmu_lerp(bat_cfg.volt1, bat_cfg.adc1, bat_cfg.volt2, bat_cfg.adc2, nvkey.cv_thrd_volt);
    nvkey.rechg_adc    = pmu_lerp(bat_cfg.volt1, bat_cfg.adc1, bat_cfg.volt2, bat_cfg.adc2, nvkey.rechg_volt);

    nvkey.cc1_thrd_adc = pmu_range(nvkey.cc1_thrd_adc, 0, 1023);
    nvkey.cc2_thrd_adc = pmu_range(nvkey.cc2_thrd_adc, 0, 1023);
    nvkey.cv_thrd_adc  = pmu_range(nvkey.cv_thrd_adc,  0, 1023);
    nvkey.rechg_adc    = pmu_range(nvkey.rechg_adc,    0, 1023);

    pmu_set_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey));
}
#endif
void pmu_cal_chg_cfg(void)
{
    chg_cfg_t nvkey;
    if (pmu_get_nvkey(NVID_CAL_CHG_CFG, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    bat_cfg.volt_sel = nvkey.bat_volt_sel;
    bat_cfg.two_step_en = nvkey.two_step_en;
    pmu_kflag = nvkey.kflag;
    pmu_otp_dump = nvkey.otp_dump;
}

//buck, ldo cfg
void pmu_cal_buck_ldo_cfg(uint16_t nvkey_id, uint16_t otp_id)
{
    buck_ldo_cfg_t nvkey;
    if (pmu_get_nvkey(nvkey_id, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    otp_buck_ldo_vref_t otp;
    if (pmu_get_otp(otp_id, (uint8_t *)&otp, sizeof(otp)) != PMU_STATUS_SUCCESS) {
        return;
    }

    nvkey.otp[0].volt = otp.data[0].volt;
    nvkey.otp[0].sel  = otp.data[0].sel;
    nvkey.otp[1].volt = otp.data[1].volt;
    nvkey.otp[1].sel  = otp.data[1].sel;

    int32_t thrd = 0;
    if ((nvkey_id == NVID_CAL_BUCK_MV_CFG) || (nvkey_id == NVID_CAL_BUCK_LV_CFG) || (nvkey_id == NVID_CAL_BUCK_LV_LPM)) {
        thrd = 255;
    } else if ((nvkey_id == NVID_CAL_BUCK_MV_STB_CFG) || (nvkey_id == NVID_CAL_LDO_VRF_RET_CFG) || (nvkey_id == NVID_CAL_VDIG18_CFG)) {
        thrd = 31;
    } else if ((nvkey_id == NVID_CAL_LDO_VDD33_REG_CFG) || (nvkey_id == NVID_CAL_LDO_VDD33_REG_RET_CFG)) {
        thrd = 127;
    } else if ((nvkey_id == NVID_CAL_LDO_VDD33_RET_CFG) || (nvkey_id == NVID_CAL_LDO_VRF_REG_CFG) || (nvkey_id == NVID_CAL_LDO_VRF_REG_RET_CFG)) {
        thrd = 63;
    }

    for (uint8_t i = 0; i < nvkey.cal_cnt; i++) {
        if (nvkey_id == NVID_CAL_VDIG18_CFG) {
            nvkey.data[i].sel = pmu_vdig_bg_lerp(nvkey.otp[0].volt, nvkey.otp[0].sel, nvkey.otp[1].volt, nvkey.otp[1].sel, nvkey.data[i].volt);
        } else {
        nvkey.data[i].sel = pmu_lerp(nvkey.otp[0].volt, nvkey.otp[0].sel, nvkey.otp[1].volt, nvkey.otp[1].sel, nvkey.data[i].volt);
        }
        nvkey.data[i].sel = pmu_range(nvkey.data[i].sel, 0, thrd);
    }
    nvkey.kflag = CAL_DONE;

    pmu_set_nvkey(nvkey_id, (uint8_t *)&nvkey, sizeof(nvkey));
}

void pmu_cal_buck_mv(void)
{
    pmu_cal_buck_ldo_cfg(NVID_CAL_BUCK_MV_CFG, OTP_BUCK_MV_ADDR);
}

void pmu_cal_buck_mv_ret(void)
{
    pmu_cal_buck_ldo_cfg(NVID_CAL_BUCK_MV_STB_CFG, OTP_BUCK_MV_RET_ADDR);
}

void pmu_cal_buck_lv(void)
{
    pmu_cal_buck_ldo_cfg(NVID_CAL_BUCK_LV_CFG, OTP_BUCK_LV_ADDR);
}

void pmu_cal_buck_lv_lpm(void)
{
    pmu_cal_buck_ldo_cfg(NVID_CAL_BUCK_LV_LPM, OTP_BUCK_LV_ADDR);
}

void pmu_cal_ldo_vdd33_reg(void)
{
    pmu_cal_buck_ldo_cfg(NVID_CAL_LDO_VDD33_REG_CFG, OTP_LDO_VDD33_REG_ADDR);
}

void pmu_cal_ldo_vdd33_reg_ret(void)
{
    pmu_cal_buck_ldo_cfg(NVID_CAL_LDO_VDD33_REG_RET_CFG, OTP_LDO_VDD33_REG_ADDR);
}

void pmu_cal_ldo_vdd33_ret(void)
{
    pmu_cal_buck_ldo_cfg(NVID_CAL_LDO_VDD33_RET_CFG, OTP_LDO_VDD33_RET_ADDR);
}

void pmu_cal_ldo_vrf_reg(void)
{
    pmu_cal_buck_ldo_cfg(NVID_CAL_LDO_VRF_REG_CFG, OTP_LDO_VRF_REG_ADDR);
}

void pmu_cal_ldo_vrf_reg_ret(void)
{
    pmu_cal_buck_ldo_cfg(NVID_CAL_LDO_VRF_REG_RET_CFG, OTP_LDO_VRF_REG_ADDR);
}

void pmu_cal_ldo_vrf_ret(void)
{
    pmu_cal_buck_ldo_cfg(NVID_CAL_LDO_VRF_RET_CFG, OTP_LDO_VRF_RET_ADDR);
}

void pmu_cal_ldo_vdig18(void)
{
    pmu_cal_buck_ldo_cfg(NVID_CAL_VDIG18_CFG, OTP_LDO_VDIG18_ADDR);
}

//buck freq
void pmu_cal_buck_freq(uint16_t nvkey_id, uint16_t otp_id)
{
    buck_freq_65_t nvkey;
    if (pmu_get_nvkey(nvkey_id, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    otp_buck_freq_t otp;
    if (pmu_get_otp(otp_id, (uint8_t *)&otp, sizeof(otp)) != PMU_STATUS_SUCCESS) {
        return;
    }

    nvkey.buck_freq = otp.freq_trim;
    nvkey.osc_freqk = otp.freqk_trim;
    nvkey.kflag = CAL_DONE;

    pmu_set_nvkey(nvkey_id, (uint8_t *)&nvkey, sizeof(nvkey));
}

void pmu_cal_buck_mv_freq(void)
{
    pmu_cal_buck_freq(NVID_CAL_BUCK_MV_FREQ, OTP_BUCK_MV_FREQ_ADDR);
}

void pmu_cal_buck_lv_freq(void)
{
    pmu_cal_buck_freq(NVID_CAL_BUCK_LV_FREQ, OTP_BUCK_LV_FREQ_ADDR);
}

//bg cfg
void pmu_cal_bg_cfg(uint16_t nvkey_id, uint16_t otp_id)
{
    bg_cfg_t nvkey;
    if (pmu_get_nvkey(nvkey_id, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    otp_buck_ldo_vref_t otp;
    if (pmu_get_otp(otp_id, (uint8_t *)&otp, sizeof(otp)) != PMU_STATUS_SUCCESS) {
        return;
    }

    nvkey.otp[0].volt = otp.data[0].volt;
    nvkey.otp[0].sel  = otp.data[0].sel;
    nvkey.otp[1].volt = otp.data[1].volt;
    nvkey.otp[1].sel  = otp.data[1].sel;

    for(uint8_t i = 0; i < nvkey.cal_cnt; i++) {
        if ((nvkey.otp[0].sel >= 16 && nvkey.otp[1].sel >= 16) || (nvkey.otp[0].sel < 16 && nvkey.otp[1].sel < 16))
        {
            assert(0);
        }
        else
        {
            nvkey.data[i].sel = pmu_vdig_bg_lerp(nvkey.otp[0].volt, nvkey.otp[0].sel, nvkey.otp[1].volt, nvkey.otp[1].sel, nvkey.data[i].volt);
            nvkey.data[i].sel = pmu_range(nvkey.data[i].sel, 0, 31);
        }
    }
    nvkey.kflag = CAL_DONE;

    pmu_set_nvkey(nvkey_id, (uint8_t *)&nvkey, sizeof(nvkey));
}

void pmu_cal_hpbg(void)
{
    pmu_cal_bg_cfg(NVID_CAL_HPBG_CFG, OTP_HPBG_ADDR);
}

void pmu_cal_lpbg(void)
{
    pmu_cal_bg_cfg(NVID_CAL_LPBG_CFG, OTP_LPBG_ADDR);
}
#ifndef AIR_PMU_DISABLE_CHARGER
void pmu_cal_chg_dac(void)
{
    chg_dac_cfg_t nvkey;
    uint16_t id = NVID_CAL_INT_CHG_DAC_CFG;
    if (pmu_get_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    otp_chg_dac_t otp;
    if (pmu_get_otp(OTP_CHG_DAC_ADDR, (uint8_t *)&otp, sizeof(otp)) != PMU_STATUS_SUCCESS) {
        return;
    }

    otp_dac.dac_4v35.volt = 4350;
    otp_dac.dac_4v35.dac = otp.dac_4v35;
    otp_dac.dac_4v2.volt = 4200;
    otp_dac.dac_4v2.dac = otp.dac_4v2;

    uint16_t chg_dac = pmu_lerp(otp_dac.dac_4v35.volt, otp_dac.dac_4v35.dac, otp_dac.dac_4v2.volt, otp_dac.dac_4v2.dac, vbat_sel);
    chg_dac = pmu_range(chg_dac, 0, 1023);

    nvkey.tri_curr_dac = chg_dac;
    nvkey.cc1_curr_dac = chg_dac;
    nvkey.cc2_curr_dac = chg_dac;
    nvkey.cv_dac = chg_dac;

    pmu_set_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey));
}
#endif
void pmu_cal_sys_ldo(void)
{
    sys_ldo_t nvkey;
    uint16_t id = NVID_CAL_SYS_LDO;
    if (pmu_get_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    otp_buck_ldo_vref_t otp;
    if (pmu_get_otp(OTP_VSYS_LDO_ADDR, (uint8_t *)&otp, sizeof(otp)) != PMU_STATUS_SUCCESS) {
        return;
    }

    nvkey.chg_ldo_sel = pmu_lerp(otp.data[0].volt, otp.data[0].sel, otp.data[1].volt, otp.data[1].sel, nvkey.sysldo_output_volt);
    nvkey.chg_ldo_sel = pmu_range(nvkey.chg_ldo_sel, 0, 7);

    pmu_set_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey));
}

void pmu_cal_ocp(void)
{
    ocp_t nvkey;
    uint16_t id = NVID_CAL_OCP;
    if (pmu_get_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    otp_ocp_t otp;
    if (pmu_get_otp(OTP_OCP_ADDR, (uint8_t *)&otp, sizeof(otp)) != PMU_STATUS_SUCCESS) {
        return;
    }

    nvkey.sw_oc_lmt = otp.load_switch_ocp_trim;
    nvkey.i_lim_trim = otp.vsys_ldo_ocp_trim;

    pmu_set_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey));
}
#ifndef AIR_PMU_DISABLE_CHARGER
void pmu_cal_chg_tri_curr(void)
{
    uint16_t rsel_4v35 = 0, rsel_4v2 = 0;

    chg_tri_curr_cfg_t nvkey;
    uint16_t id = NVID_CAL_INT_CHG_TRI_CURR_CFG;
    if (pmu_get_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    for (uint8_t i = 0; i < nvkey.cal_cnt; i++) {
        rsel_4v35 = pmu_lerp(otp_curr.bat_4v35[0].curr, otp_curr.bat_4v35[0].val, otp_curr.bat_4v35[1].curr, otp_curr.bat_4v35[1].val, nvkey.data[i].curr);
        rsel_4v2 = pmu_lerp(otp_curr.bat_4v2[0].curr, otp_curr.bat_4v2[0].val, otp_curr.bat_4v2[1].curr, otp_curr.bat_4v2[1].val, nvkey.data[i].curr);

        nvkey.data[i].sel = pmu_lerp(otp_dac.dac_4v35.volt, rsel_4v35, otp_dac.dac_4v2.volt, rsel_4v2, vbat_sel);
        nvkey.data[i].sel = pmu_range(nvkey.data[i].sel, 0, 1023);
    }

    pmu_set_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey));
}

void pmu_cal_chg_curr_cfg(uint16_t nvkey_id)
{
    uint16_t rsel_4v35 = 0, rsel_4v2 = 0;

    chg_cc_curr_cfg_t nvkey;
    if (pmu_get_nvkey(nvkey_id, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    for (uint8_t i = 0; i < nvkey.cal_cnt; i++) {
        rsel_4v35 = pmu_lerp(otp_curr.bat_4v35[0].curr, otp_curr.bat_4v35[0].val, otp_curr.bat_4v35[1].curr, otp_curr.bat_4v35[1].val, nvkey.data[i].curr);
        rsel_4v2 = pmu_lerp(otp_curr.bat_4v2[0].curr, otp_curr.bat_4v2[0].val, otp_curr.bat_4v2[1].curr, otp_curr.bat_4v2[1].val, nvkey.data[i].curr);

        nvkey.data[i].sel = pmu_lerp(otp_dac.dac_4v35.volt, rsel_4v35, otp_dac.dac_4v2.volt, rsel_4v2, vbat_sel);
        nvkey.data[i].sel = pmu_range(nvkey.data[i].sel, 0, 1023);
    }
    if (nvkey_id == NVID_CAL_INT_CHG_CC1_CURR_CFG) {
    cc_curr.cc1_curr = nvkey.data[nvkey.sel - 1].curr;
    } else {
        cc_curr.cc2_curr = nvkey.data[nvkey.sel - 1].curr;
    }

    pmu_set_nvkey(nvkey_id, (uint8_t *)&nvkey, sizeof(nvkey));
}

void pmu_cal_chg_cc1_curr(void)
{
    pmu_cal_chg_curr_cfg(NVID_CAL_INT_CHG_CC1_CURR_CFG);
}

void pmu_cal_chg_cc2_curr(void)
{
    pmu_cal_chg_curr_cfg(NVID_CAL_INT_CHG_CC2_CURR_CFG);
}

void pmu_cal_cv_stop_curr(void)
{
    cv_stop_curr_cfg_t nvkey;
    uint16_t id = NVID_CAL_CV_STOP_CURR_CFG;
    if (pmu_get_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    otp_vichg_adc_t otp;
    if (pmu_get_otp(OTP_VICHG_ADC_VAL_ADDR, (uint8_t *)&otp, sizeof(otp)) != PMU_STATUS_SUCCESS) {
        return;
    }

    otp_vichg.adc_4v35 = otp.adc_4v35;
    otp_vichg.adc_4v2 = otp.adc_4v2;
    otp_vichg.adc_4v05 = otp.adc_4v05;
    otp_vichg.cv_stop_curr_perc = nvkey.cv_stop_curr[nvkey.sel - 1].perc;

    uint16_t adc = pmu_lerp(4350, otp_vichg.adc_4v35, 4200, otp_vichg.adc_4v2, vbat_sel);
    for (uint8_t i = 0; i < nvkey.cal_cnt; i++) {
        nvkey.cv_stop_curr[i].adc = pmu_round((nvkey.cv_stop_curr[i].perc * adc), 100);
    }

    pmu_set_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey));
}

void pmu_cal_chg_curr_otp(void)
{
    otp_chg_curr_t otp_4v35;
    pmu_get_otp(OTP_CHG_4V35_CURR_ADDR, (uint8_t *)&otp_4v35, sizeof(otp_4v35));

    otp_chg_curr_t otp_4v2;
    pmu_get_otp(OTP_CHG_4V2_CURR_ADDR, (uint8_t *)&otp_4v2, sizeof(otp_4v2));

    otp_curr.bat_4v35[0].curr = otp_4v35.data[0].curr;
    otp_curr.bat_4v35[0].val  = otp_4v35.data[0].val;
    otp_curr.bat_4v35[1].curr = otp_4v35.data[1].curr;
    otp_curr.bat_4v35[1].val  = otp_4v35.data[1].val;
    otp_curr.bat_4v2[0].curr  = otp_4v2.data[0].curr;
    otp_curr.bat_4v2[0].val   = otp_4v2.data[0].val;
    otp_curr.bat_4v2[1].curr  = otp_4v2.data[1].curr;
    otp_curr.bat_4v2[1].val   = otp_4v2.data[1].val;
}

void pmu_cal_chg_jeita_cfg(uint16_t nvkey_id)
{
    uint16_t sel_volt, curr_dac, cc1_rsel_4v35, cc1_rsel_4v2, cc2_rsel_4v35, cc2_rsel_4v2, dac_dec, curr_perc;

    chg_adc_cfg_t chg_adc;
    if (pmu_get_nvkey(NVID_CAL_CHG_ADC_CFG, (uint8_t *)&chg_adc, sizeof(chg_adc)) != PMU_STATUS_SUCCESS) {
        return;
    }

    jeita_t jeita;
    if (pmu_get_nvkey(NVID_CAL_JEITA, (uint8_t *)&jeita, sizeof(jeita)) != PMU_STATUS_SUCCESS) {
        return;
    }

    jeita_cfg_t nvkey;
    if (pmu_get_nvkey(nvkey_id, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey_id == NVID_CAL_JEITA_WARM) {
        dac_dec = jeita.warm_state_dac_dec;
        curr_perc = jeita.warm_state_curr_perc;
    } else {
        dac_dec = jeita.cool_state_dac_dec;
        curr_perc = jeita.cool_state_curr_perc;
    }

    nvkey.cc2_thrd_volt = chg_adc.cc2_thrd_volt;
    nvkey.cv_thrd_volt  = chg_adc.cv_thrd_volt - dac_dec;
    nvkey.rechg_volt    = chg_adc.rechg_volt - dac_dec;

    nvkey.cc2_thrd_adc  = pmu_lerp(bat_cfg.volt1, bat_cfg.adc1, bat_cfg.volt2, bat_cfg.adc2, nvkey.cc2_thrd_volt);
    nvkey.cv_thrd_adc   = pmu_lerp(bat_cfg.volt1, bat_cfg.adc1, bat_cfg.volt2, bat_cfg.adc2, nvkey.cv_thrd_volt);
    nvkey.rechg_adc     = pmu_lerp(bat_cfg.volt1, bat_cfg.adc1, bat_cfg.volt2, bat_cfg.adc2, nvkey.rechg_volt);

    nvkey.cc2_thrd_adc  = pmu_range(nvkey.cc2_thrd_adc, 0, 1023);
    nvkey.cv_thrd_adc   = pmu_range(nvkey.cv_thrd_adc,  0, 1023);
    nvkey.rechg_adc     = pmu_range(nvkey.rechg_adc,    0, 1023);

    sel_volt = vbat_sel - dac_dec;
    curr_dac = pmu_lerp(otp_dac.dac_4v35.volt, otp_dac.dac_4v35.dac, otp_dac.dac_4v2.volt, otp_dac.dac_4v2.dac, sel_volt);
    curr_dac = pmu_range(curr_dac, 0, 1023);

    nvkey.cc1_curr_dac  = curr_dac;
    nvkey.cc2_curr_dac  = curr_dac;
    nvkey.cv_dac        = curr_dac;

    nvkey.cc1_curr = pmu_round((cc_curr.cc1_curr * curr_perc), 100);
    nvkey.cc2_curr = pmu_round((cc_curr.cc2_curr * curr_perc), 100);

    cc1_rsel_4v2  = pmu_lerp(otp_curr.bat_4v2[0].curr, otp_curr.bat_4v2[0].val, otp_curr.bat_4v2[1].curr, otp_curr.bat_4v2[1].val, nvkey.cc1_curr);
    cc1_rsel_4v35 = pmu_lerp(otp_curr.bat_4v35[0].curr, otp_curr.bat_4v35[0].val, otp_curr.bat_4v35[1].curr, otp_curr.bat_4v35[1].val, nvkey.cc1_curr);
    nvkey.cc1_rsel = pmu_lerp(otp_dac.dac_4v35.volt, cc1_rsel_4v35, otp_dac.dac_4v2.volt, cc1_rsel_4v2, sel_volt);

    cc1_rsel_4v2   = pmu_range(cc1_rsel_4v2,   0, 1023);
    cc1_rsel_4v35  = pmu_range(cc1_rsel_4v35,  0, 1023);
    nvkey.cc1_rsel = pmu_range(nvkey.cc1_rsel, 0, 1023);

    cc2_rsel_4v2  = pmu_lerp(otp_curr.bat_4v2[0].curr, otp_curr.bat_4v2[0].val, otp_curr.bat_4v2[1].curr, otp_curr.bat_4v2[1].val, nvkey.cc2_curr);
    cc2_rsel_4v35 = pmu_lerp(otp_curr.bat_4v35[0].curr, otp_curr.bat_4v35[0].val, otp_curr.bat_4v35[1].curr, otp_curr.bat_4v35[1].val, nvkey.cc2_curr);
    nvkey.cc2_rsel = pmu_lerp(otp_dac.dac_4v35.volt, cc2_rsel_4v35, otp_dac.dac_4v2.volt, cc2_rsel_4v2, sel_volt);

    cc2_rsel_4v2   = pmu_range(cc2_rsel_4v2,   0, 1023);
    cc2_rsel_4v35  = pmu_range(cc2_rsel_4v35,  0, 1023);
    nvkey.cc2_rsel = pmu_range(nvkey.cc2_rsel, 0, 1023);

    uint16_t adc = pmu_lerp(otp_dac.dac_4v35.volt, otp_vichg.adc_4v35, otp_dac.dac_4v2.volt, otp_vichg.adc_4v2, sel_volt);
    adc = pmu_range(adc, 0, 1023);
    nvkey.cv_stop_curr_adc = pmu_round(adc * otp_vichg.cv_stop_curr_perc, 100);

    pmu_set_nvkey(nvkey_id, (uint8_t *)&nvkey, sizeof(nvkey));
}

void pmu_cal_chg_jeita_warm(void)
{
    pmu_cal_chg_jeita_cfg(NVID_CAL_JEITA_WARM);
}

void pmu_cal_chg_jeita_cool(void)
{
    pmu_cal_chg_jeita_cfg(NVID_CAL_JEITA_COOL);
}
#endif
void pmu_cal_done(void)
{
    chg_cfg_t nvkey;
    uint16_t id = NVID_CAL_CHG_CFG;
    if (pmu_get_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey)) != PMU_STATUS_SUCCESS) {
        return;
    }

    if (nvkey.kflag != NO_CAL) {
        log_hal_msgid_error("[PMU_CAL]cal_done fail, id[0x%X], kflag[%d]", 2, id, nvkey.kflag);
        return;
    }
    pmu_kflag = CAL_DONE;
    nvkey.kflag = pmu_kflag;

    pmu_set_nvkey(id, (uint8_t *)&nvkey, sizeof(nvkey));
}

void pmu_cal_init(void)
{
    pmu_cal_chg_cfg();
    log_hal_msgid_info("[PMU_CAL]cal_init, otp_dump[%d], kflag[%d]", 2, pmu_otp_dump, pmu_kflag);

    if (pmu_kflag == NO_CAL) {
    } else if (pmu_kflag == CAL_DONE) {
        log_hal_msgid_info("[PMU_CAL]cal_init, exist", 0);
        return;
    } else {
        log_hal_msgid_error("[PMU_CAL]cal_init fail, kflag[%d]", 1, pmu_kflag);
        assert(0);
    }

    if (pmu_otp_dump == 0x01) {
        pmu_dump_otp_lp();
    }

#ifndef AIR_PMU_DISABLE_CHARGER
    pmu_cal_vbat_adc();
    pmu_cal_vbat_volt();
    pmu_cal_chg_adc();
#endif

    pmu_cal_buck_mv();
    pmu_cal_buck_mv_ret();
    pmu_cal_buck_mv_freq();
    pmu_cal_buck_lv();
    pmu_cal_buck_lv_lpm();
    pmu_cal_buck_lv_freq();

    pmu_cal_ldo_vdd33_reg();
    pmu_cal_ldo_vdd33_reg_ret();
    pmu_cal_ldo_vdd33_ret();
    pmu_cal_ldo_vrf_reg();
    pmu_cal_ldo_vrf_reg_ret();
    pmu_cal_ldo_vrf_ret();
    pmu_cal_ldo_vdig18();

    pmu_cal_hpbg();
    pmu_cal_lpbg();

#ifndef AIR_PMU_DISABLE_CHARGER
    pmu_cal_chg_dac();
    pmu_cal_chg_curr_otp();
    pmu_cal_chg_tri_curr();
    pmu_cal_chg_cc1_curr();
    pmu_cal_chg_cc2_curr();
    pmu_cal_cv_stop_curr();
#endif
    pmu_cal_sys_ldo();
    pmu_cal_ocp();

#ifndef AIR_PMU_DISABLE_CHARGER
    pmu_cal_chg_jeita_warm();
    pmu_cal_chg_jeita_cool();
#endif

    pmu_cal_done();

    //log_hal_msgid_info("[PMU_CAL]cal_init, done", 0);

    if (pmu_otp_dump == 0x01) {
        pmu_dump_nvkey_lp();
    }
}

void pmu_set_init(void)
{
    if (pmu_kflag != CAL_DONE) {
        log_hal_msgid_error("[PMU_CAL]set_init fail, kflag[%d]", 1, pmu_kflag);
        assert(0);
    }
    pmu_set_chg_cfg();

#ifndef AIR_PMU_DISABLE_CHARGER
    pmu_set_chg_adc_cfg();
    pmu_set_chg_dac_cfg();
    pmu_set_chg_tri_curr_cfg();
    pmu_set_chg_cc1_curr_cfg();
    pmu_set_chg_cc2_curr_cfg();
    pmu_set_chg_cv_stop_curr_adc();
#else
    log_hal_msgid_warning("[PMU_CAL]set_init, bypass for dongle", 0);
#endif
    pmu_set_sys_ldo();
    //pmu_set_ocp();

    pmu_set_buck_mv();
    pmu_set_buck_mv_stb();
    pmu_set_buck_mv_freq();
    pmu_set_buck_lv();
    pmu_set_buck_lv_lpm();
    pmu_set_buck_lv_freq();

    pmu_set_ldo_vdd33_reg();
    pmu_set_ldo_vdd33_reg_ret();
    pmu_set_ldo_vdd33_ret();
    pmu_set_ldo_vrf_reg();
    pmu_set_ldo_vrf_reg_ret();
    pmu_set_ldo_vrf_ret();
    pmu_set_ldo_vdig18();

    pmu_set_hpbg();
    //pmu_set_lpbg();

    //log_hal_msgid_info("[PMU_CAL]set_init, done", 0);
}
