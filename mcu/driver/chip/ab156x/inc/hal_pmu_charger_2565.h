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


#ifndef __HAL_PMU_CHARGER_H__
#define __HAL_PMU_CHARGER_H__
#ifdef HAL_PMU_MODULE_ENABLED


#ifndef PACKED
#define PACKED  __attribute__((packed))
#endif

#define PMU_CHARGER_PFM_ENABLE

#define NTC_DATA_SIZE               80

#define EFUSE_NTC_R2_ADDR           0xA20A0408
#define EFUSE_NTC_RAGPIO_ADDR       0xA20A0404
#define EFUSE_NTC_DEF_R2            11693
#define EFUSE_NTC_DEF_RAGPIO        719


typedef enum {
    PMU_NTC_NORM,
    PMU_NTC_WARM,
    PMU_NTC_COOL,
    PMU_NTC_HOT,
    PMU_NTC_COLD,
    PMU_NTC_PWR_OFF,
} pmu_ntc_state_t;
/*******************************************************************/

#define DIGITAL_THERMAL_FUNCTION 1
#define HW_JEITA_HOT_STAGE 0xF
#define HW_JEITA_WARM_STAGE 0xE
#define HW_JEITA_NORMAL_STAGE 0xC
#define HW_JEITA_COOL_STAGE 0x8
#define HW_JEITA_COLD_STAGE 0
#define HW_JEITA_ERRIR_STATE 0x4

#define NTC_CHARGER_CON2_TRICKLE        1
#define NTC_CHARGER_CON2_CC1            2
#define NTC_CHARGER_CON2_CC2            3
#define NTC_CHARGER_CON2_CV             5
#define NTC_CHARGER_CON2_COMPL          6
#define NTC_CHARGER_CON2_RECHG          7

enum JEITA_CHARGER_STATUS
{
    JEITA_DISABLE_CHARGER = 0,
    JEITA_ENABLE_CHARGER = 1,
    JEITA_NORMAL_TO_WARM = 2,
    JEITA_NORMAL_TO_COOL = 3,
    JEITA_WARM_TO_NORMAL = 4,
    JEITA_COOL_TO_NORMAL = 5
};

typedef struct
{
    uint8_t enable_warm : 1;             //JEITA WARM
    uint8_t enable_cold : 1;             //JEITA COOL
    uint8_t enable_force_chg_off : 1;    //Any state to cold/hot
    uint8_t enable_limit_current : 1;    //Normal to Cool/Warm
    uint8_t disable_force_chg_off : 1;   //Cold Hot to any state
    uint8_t disable_limit_current : 1;   //Cool/Warm to Normal
    uint8_t power_off : 1;
    uint8_t reserved1 : 1;
}NTC_OP;

/*
 *  BC1.2 address */

#define PMU_REG_BASE_AB155X (0xA2070000)

// PMU Group
#define PMU2_ANA_CON0   (PMU_REG_BASE_AB155X+0x0500)
#define PMU2_ANA_CON1   (PMU_REG_BASE_AB155X+0x0504)
#define PMU2_ELR_0      (PMU_REG_BASE_AB155X+0x0508)
#define PMU2_ANA_RO     (PMU_REG_BASE_AB155X+0x0510)

//Control RG

#define PMU_BC12_IBIAS_EN_V12_ADDR                  PMU2_ANA_CON0
#define PMU_BC12_IBIAS_EN_V12_MASK                  0x1
#define PMU_BC12_IBIAS_EN_V12_SHIFT                 0

#define PMU_BC12_CMP_EN_V12_ADDR                    PMU2_ANA_CON0
#define PMU_BC12_CMP_EN_V12_MASK                    0x3
#define PMU_BC12_CMP_EN_V12_SHIFT                   1

#define PMU_BC12_DCD_EN_V12_ADDR                          PMU2_ANA_CON0
#define PMU_BC12_DCD_EN_V12_MASK                          0x1
#define PMU_BC12_DCD_EN_V12_SHIFT                         3

#define PMU_BC12_IPDC_EN_V12_ADDR                          PMU2_ANA_CON0
#define PMU_BC12_IPDC_EN_V12_MASK                          0x3
#define PMU_BC12_IPDC_EN_V12_SHIFT                         4

#define PMU_BC12_IPD_EN_V12_ADDR                          PMU2_ANA_CON0
#define PMU_BC12_IPD_EN_V12_MASK                          0x3
#define PMU_BC12_IPD_EN_V12_SHIFT                         6

#define PMU_BC12_IPD_HALF_EN_V12_ADDR                       PMU2_ANA_CON0
#define PMU_BC12_IPD_HALF_EN_V12_MASK                       0x1
#define PMU_BC12_IPD_HALF_EN_V12_SHIFT                      8

#define PMU_BC12_IPU_EN_V12_ADDR                          PMU2_ANA_CON0
#define PMU_BC12_IPU_EN_V12_MASK                          0x3
#define PMU_BC12_IPU_EN_V12_SHIFT                         9

#define PMU_BC12_VREF_VTH_EN_V12_ADDR                       PMU2_ANA_CON0
#define PMU_BC12_VREF_VTH_EN_V12_MASK                       0x3
#define PMU_BC12_VREF_VTH_EN_V12_SHIFT                      11

#define PMU_BC12_SRC_EN_V12_ADDR                          PMU2_ANA_CON0
#define PMU_BC12_SRC_EN_V12_MASK                          0x3
#define PMU_BC12_SRC_EN_V12_SHIFT                         13

#define PMU_BC12_IPU_TEST_EN_V12_ADDR                       PMU2_ANA_CON1
#define PMU_BC12_IPU_TEST_EN_V12_MASK                       0x1
#define PMU_BC12_IPU_TEST_EN_V12_SHIFT                      0

#define PMU_BC12_CS_TRIM_V12_ADDR                          PMU2_ELR_0
#define PMU_BC12_CS_TRIM_V12_MASK                          0x3F
#define PMU_BC12_CS_TRIM_V12_SHIFT                         0

#define PMU_AQ_QI_BC12_CMP_OUT_V12_ADDR                       PMU2_ANA_RO
#define PMU_AQ_QI_BC12_CMP_OUT_V12_MASK                       0x1
#define PMU_AQ_QI_BC12_CMP_OUT_V12_SHIFT                      0


/**************2565*****************/
typedef enum {
    CHG_IDLE,
    CHG_TRICKLE,
    CHG_CC1,
    CHG_CC2,
    CHG_CV_INIT,
    CHG_CV,
    CHG_COMPL,
    CHG_RECHG,
} pmu_chg_state_t;

typedef enum {
    CHG_OUT_DEB_0MS,
    CHG_OUT_DEB_10MS,
    CHG_OUT_DEB_20MS,
    CHG_OUT_DEB_40MS,
    CHG_IN_DEB_0MS = 0,
    CHG_IN_DEB_16MS,
    CHG_IN_DEB_40MS,
    CHG_IN_DEB_128MS,
} pmu_chg_deb_time_t;

typedef enum {
    CHG_IN_INT_FLAG,
    CHG_IN_INT_EN,
    CHG_OUT_INT_FLAG,
    CHG_OUT_INT_EN,
    CHG_COMPLETE_INT_FLAG,
    CHG_COMPLETE_INT_EN,
    CHG_RECHG_INT_FLAG,
    CHG_RECHG_INT_EN,
} pmu_chg_int_mask_t;

typedef enum {
    PMU_RSEL_NORM,
    PMU_RSEL_WARM,
    PMU_RSEL_COOL,
    PMU_RSEL_VBAT,
    PMU_RSEL_MAX,
} pmu_chg_cc_state_t;

typedef struct
{
    uint16_t state;
    uint16_t cc1[PMU_RSEL_MAX];
    uint16_t cc2[PMU_RSEL_MAX];
} pmu_chg_rsel_t;

typedef struct
{
    uint16_t cc1_thrd_volt;
    uint16_t cc1_curr;
    uint16_t cc2_thrd_volt;
    uint16_t cc2_curr;
    uint16_t full_bat_volt;
    uint16_t rechg_volt;
    uint16_t cv_stop_curr_adc;
}pmu_chg_info_t;


extern pmu_chg_rsel_t chg_rsel;
extern uint8_t pmu_1wire_2pins_exist;

/*******************  charger  ****************/
void pmu_chg_init(void);
uint8_t pmu_enable_charger_lp(uint8_t en);
bool pmu_get_chr_detect_value_lp(void);
bool pmu_chg_is_compl(void);
uint16_t pmu_get_charger_state_lp(void);

/*******************  charger intr  ****************/
bool pmu_charger_callback_init(void);
void pmu_chg_in_hdlr(void);
void pmu_chg_out_hdlr(void);
void pmu_chg_compl_hdlr(void);
void pmu_chg_rechg_hdlr(void);
void pmu_chg_hdlr(uint16_t chg_flag);
pmu_operate_status_t pmu_chg_deb_time(pmu_chg_deb_time_t out_deb_time, pmu_chg_deb_time_t in_deb_time);

/*******************  battery  ****************/
void pmu_bat_init(void);
uint8_t pmu_bat_adc_to_perc(uint32_t adcval);
uint16_t pmu_bat_adc_to_k_perc(uint32_t adc);
uint8_t pmu_bat_volt_to_perc(uint32_t volt);
uint32_t pmu_bat_volt_to_adc(uint32_t volt);
uint32_t pmu_bat_adc_to_volt(uint32_t adcval);
void pmu_bat_3v3_proc(void);
uint16_t pmu_bat_get_pure_volt(void);
uint32_t pmu_chg_vchg_to_volt(uint32_t adc);

/*******************  1wire  ****************/
void pmu_vio18_pull_up(pmu_power_operate_t en);
void pmu_uart_psw_cl(pmu_power_operate_t en);
void pmu_uart_psw(pmu_power_operate_t en);
void pmu_uart_psw_sequence(void);
void pmu_vchg_dischg_path(pmu_power_operate_t en);
void pmu_eoc_ctrl (pmu_power_operate_t oper);

/*******************  NTC  ****************/
void pmu_ntc_update_state(int *ret_temp, pmu_ntc_state_t *curr_state);
uint8_t pmu_ntc_get_enable_status(void);
uint8_t pmu_ntc_get_interval(void) ;
void pmu_ntc_init(void);
void pmu_ntc_cfg(pmu_ntc_state_t state);
bool pmu_ntc_slt(void);

void pmu_chg_rsel_ctl(pmu_chg_cc_state_t state);

/*******************  pfm  ****************/
void pmu_chg_pfm_ctl(void);

/*******************  BC12  ****************/
uint8_t pmu_get_bc12_charger_type_lp(void);
void pmu_bc12_init(void);


#endif /* HAL_PMU_MODULE_ENABLED */
#endif
