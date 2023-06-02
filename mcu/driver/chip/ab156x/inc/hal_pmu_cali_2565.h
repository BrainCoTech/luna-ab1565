/* Copyright Statement:
 *
 * (C) 2018  Airoha Technology Corp. All rights reserved.
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
#ifndef __HAL_PMU_CAL_LP_H__
#define __HAL_PMU_CAL_LP_H__
#ifdef HAL_PMU_MODULE_ENABLED

#include "hal_pmu_nvkey_struct.h"


#define NO_CAL    0
#define OTP_OK    1
#define CAL_DONE  3

#define OTP_BASE_ADDR                 (0x0100)
#define OTP_VBAT_ADDR                 (OTP_BASE_ADDR + 0)
#define OTP_BUCK_MV_ADDR              (OTP_BASE_ADDR + 13)
#define OTP_BUCK_MV_FREQ_ADDR         (OTP_BASE_ADDR + 20)
#define OTP_BUCK_MV_RET_ADDR          (OTP_BASE_ADDR + 25)
#define OTP_BUCK_LV_ADDR              (OTP_BASE_ADDR + 32)
#define OTP_BUCK_LV_FREQ_ADDR         (OTP_BASE_ADDR + 39)
#define OTP_LDO_VDIG18_ADDR           (OTP_BASE_ADDR + 44)
#define OTP_LDO_VRF_REG_ADDR          (OTP_BASE_ADDR + 51)
#define OTP_LDO_VRF_RET_ADDR          (OTP_BASE_ADDR + 58)
#define OTP_LDO_VDD33_REG_ADDR        (OTP_BASE_ADDR + 65)
#define OTP_LDO_VDD33_RET_ADDR        (OTP_BASE_ADDR + 72)
#define OTP_HPBG_ADDR                 (OTP_BASE_ADDR + 79)
#define OTP_LPBG_ADDR                 (OTP_BASE_ADDR + 86)
#define OTP_CHG_DAC_ADDR              (OTP_BASE_ADDR + 93)
#define OTP_VSYS_LDO_ADDR             (OTP_BASE_ADDR + 100)
#define OTP_OCP_ADDR                  (OTP_BASE_ADDR + 107)
#define OTP_CHG_4V2_CURR_ADDR         (OTP_BASE_ADDR + 110)
#define OTP_CHG_4V35_CURR_ADDR        (OTP_BASE_ADDR + 124)
#define OTP_VICHG_ADC_VAL_ADDR        (OTP_BASE_ADDR + 138)
#define OTP_ADIE_VER_ADDR             (OTP_BASE_ADDR + 145)
#define OTP_ADIE_KGD_ADDR             (OTP_BASE_ADDR + 147)


/************  global stur  **************/
typedef struct
{
    uint16_t volt1;
    uint16_t adc1;
    uint16_t volt2;
    uint16_t adc2;
    uint8_t volt_sel;
    uint8_t two_step_en;
}bat_cfg_t;

typedef struct
{
    VOLT_DAC dac_4v35;
    VOLT_DAC dac_4v2;
}volt_dac_t;

typedef struct
{
    CURR_VAL bat_4v35[2];
    CURR_VAL bat_4v2[2];
}curr_val_t;

typedef struct
{
    uint16_t cc1_curr;
    uint16_t cc2_curr;
}cc_curr_t;

typedef struct
{
    uint16_t adc_4v35;
    uint16_t adc_4v2;
    uint16_t adc_4v05;
    uint16_t cv_stop_curr_perc;
}vichg_adc_t;

/****************************** OTP stru ******************************/
typedef struct
{
    uint8_t kflag;
    VOLT_ADC data[3];
}PACKED otp_vbat_t;

typedef struct
{
    uint8_t kflag;
    VOLT_SEL data[2];
}PACKED otp_buck_ldo_vref_t;

typedef struct
{
    uint8_t kflag;
    uint16_t freq;
    uint8_t freq_trim;
    uint8_t freqk_trim;
}PACKED otp_buck_freq_t;

typedef struct
{
    uint8_t kflag;
    uint16_t dac_4v35;
    uint16_t dac_4v2;
    uint16_t dac_4v05;
}PACKED otp_chg_dac_t;

typedef struct
{
    uint8_t kflag;
    uint8_t load_switch_ocp_trim;
    uint8_t vsys_ldo_ocp_trim;
}PACKED otp_ocp_t;

typedef struct
{
    uint8_t kflag;
    CURR_VAL data[4];
}PACKED otp_chg_curr_t;

typedef struct
{
    uint8_t kflag;
    uint16_t adc_4v35;
    uint16_t adc_4v2;
    uint16_t adc_4v05;
}PACKED otp_vichg_adc_t;

#if 0
/*********************    member_stur    *****************************/
typedef struct
{
    uint16_t volt;
    uint16_t adc;
}PACKED VOLT_ADC;

typedef struct
{
    uint16_t volt;
    uint16_t dac;
}PACKED VOLT_DAC;

typedef struct
{
    uint16_t volt;
    uint8_t sel;
}PACKED VOLT_SEL;

typedef struct
{
    uint16_t volt;
    uint8_t sel;
    uint16_t rsv;
}PACKED VOLT_SEL_RSV;

typedef struct
{
    uint16_t curr;
    uint16_t sel;
}PACKED CURR_SEL;

typedef struct
{
    uint16_t perc;
    uint16_t adc;
}PACKED PERC_ADC;

typedef struct
{
    uint16_t curr;
    uint8_t val;
}PACKED CURR_VAL;

/*********************    nvkey_stur    *****************************/
//0x2000
typedef struct
{
    uint8_t otp_dump;
    uint8_t bat_volt_sel;
    uint8_t two_step_en;
    uint8_t kflag;
}chg_cfg_t;

//0x2001
typedef struct
{
    uint16_t cc1_thrd_volt;
    uint16_t cc1_thrd_adc;
    uint16_t rsv1;
    uint16_t rsv2;
    uint16_t cc2_thrd_volt;
    uint16_t cc2_thrd_adc;
    uint16_t rsv3;
    uint16_t rsv4;
    uint16_t cv_thrd_volt;
    uint16_t cv_thrd_adc;
    uint16_t rsv5;
    uint16_t rsv6;
    uint16_t full_bat_volt;
    uint16_t rsv8;
    uint16_t rsv9;
    uint16_t rsv10;
    uint16_t rechg_volt;
    uint16_t rechg_adc;
    uint16_t rsv11;
    uint16_t rsv12;
    uint16_t rsv13;
    uint16_t rsv14;
    uint16_t rsv15;
    uint16_t rsv16;
}chg_adc_cfg_t;

//0x2002
typedef struct
{
    uint16_t tri_curr_dac;
    uint16_t rsv1;
    uint16_t cc1_curr_dac;
    uint16_t rsv2;
    uint16_t cc2_curr_dac;
    uint16_t rsv3;
    uint16_t cv_dac;
    uint16_t rsv4;
}chg_dac_cfg_t;

//0x2003
typedef struct
{
    uint8_t cal_cnt;
    uint8_t sel;
    CURR_SEL data[10];
}chg_tri_curr_cfg_t;

//0x2004, 0x2005
typedef struct
{
    uint8_t cal_cnt;
    uint8_t sel;
    CURR_SEL data[10];
}chg_cc_curr_cfg_t;

//0x2006
typedef struct
{
    uint8_t cal_cnt;
    uint8_t sel;
    PERC_ADC cv_stop_curr[2];
    uint8_t chg_pre_compl_int_en;
    uint8_t pre_compl_cal_cnt;
    uint8_t pre_compl_sel;
    PERC_ADC pre_compl_curr[2];
}cv_stop_curr_cfg_t;

//0x2007
typedef struct
{
    uint16_t sysldo_output_volt;
    uint16_t chg_ldo_sel;
}sys_ldo_t;

//0x2008
typedef struct
{
    uint16_t sw_oc_lmt;
    uint16_t i_lim_trim;
}ocp_t;

//0x2009
typedef struct
{
    uint16_t cool_state_curr_perc;
    uint16_t cool_state_dac_dec;
    uint16_t warm_state_curr_perc;
    uint16_t warm_state_dac_dec;
}jeita_t;

//0x200A, 0x200B
typedef struct
{
    uint16_t cc2_thrd_volt;
    uint16_t cc2_thrd_adc;
    uint16_t cv_thrd_volt;
    uint16_t cv_thrd_adc;
    uint16_t rsv1;
    uint16_t rsv2;
    uint16_t rechg_volt;
    uint16_t rechg_adc;
    uint16_t rsv3;
    uint16_t rsv4;
    uint16_t cc1_curr_dac;
    uint16_t cc2_curr_dac;
    uint16_t cv_dac;
    uint16_t cc1_curr;
    uint16_t cc1_rsel;
    uint16_t cc2_curr;
    uint16_t cc2_rsel;
    uint16_t cv_stop_curr_adc;
    uint16_t pre_compl_curr_adc;
}jeita_cfg_t;

//0x2012, 0x2015
typedef struct
{
    uint8_t kflag;
    uint8_t buck_freq;
    uint8_t osc_freqk;
}PACKED buck_freq_t;

//0x2016-0x201C, 0x2030-0x2033
typedef struct
{
    uint8_t kflag;
    VOLT_SEL otp[2];
    uint8_t cal_cnt;
    uint8_t sel;
    VOLT_SEL_RSV data[8];
}PACKED buck_ldo_cfg_t;

//0x201D, 0x201E
typedef struct
{
    uint8_t kflag;
    VOLT_SEL otp[2];
    uint8_t cal_cnt;
    uint8_t sel;
    VOLT_SEL_RSV data[2];
}PACKED bg_cfg_t;

//0x2020
typedef struct
{
    uint8_t kflag;
    uint8_t cal_cnt;
    VOLT_ADC data[10];
}PACKED vbat_adc_cal_t;

//0x2021
typedef struct
{
    uint8_t kflag;
    VOLT_ADC init_bat;
    VOLT_ADC rsv1;
    VOLT_ADC sd_bat;
    VOLT_ADC data[18];
}PACKED vbat_volt_cfg_t;
#endif

/******************************************To be remove****************************************/
//0x2045
typedef struct xo24m_crystal_trim
{
    uint8_t crtstal_trim_spec;
    uint16_t cap_val;
}PACKED XO24M_CRYSTAL_TRIM;

//0x2046
typedef struct x32kcrystal_trim
{
    uint8_t crtstal_trim_spec;
    uint8_t cap_val;
}PACKED XO32k_CRYSTAL_TRIM;

//0x2047
typedef struct gc_offset_config
{
    uint8_t kflag;
    int8_t GC_Offset;
}PACKED GC_OFFSET_CONFIG;

/******************************************To be remove****************************************/
typedef struct otp_aio_config
{
    uint8_t kflag;
    uint8_t Gpio_sel;
    uint8_t Count;
    VOLT_ADC data[5];
}PACKED OTP_AIO_CONFIG;

typedef struct otp_temp_adc_config
{
    uint8_t kflag;
    uint8_t Offset_of_Adc_Table;
    uint8_t rsv;
}PACKED OTP_TEMP_ADC_CONFIG;

typedef struct otp_gc_offset_config
{
    uint8_t kflag;
    int8_t GC_Offset;
}PACKED OTP_GC_OFFSET_CONFIG;

/******************************************extern API****************************************/
uint16_t pmu_lerp(uint16_t volt1, uint16_t adc1, uint16_t volt2, uint16_t adc2, uint16_t volt_val);
void pmu_cal_init(void);
void pmu_set_init(void);
void pmu_dump_otp_lp(void);
void pmu_dump_nvkey_lp(void);
pmu_status_t pmu_get_nvkey(uint16_t id, uint8_t* ptr, uint32_t size);
pmu_status_t pmu_set_nvkey(uint16_t id, uint8_t *ptr, uint32_t size);
pmu_status_t pmu_get_otp(uint16_t addr, uint8_t* ptr, uint32_t size);

#endif  /* HAL_PMU_MODULE_ENABLED */
#endif  /* __HAL_PMU_CAL_LP_H__ */
