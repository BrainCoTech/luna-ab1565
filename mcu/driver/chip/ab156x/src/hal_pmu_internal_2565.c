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
#include "hal_flash_disk_internal.h"

#include "hal_i2c_master_internal.h"
#include "hal_sleep_manager_platform.h"
#include "hal_sleep_manager_internal.h"
#include "hal_sleep_manager.h"
#include "nvkey_id_list.h"
#include "hal_nvic_internal.h"
#include "syslog.h"
#include "assert.h"
#include "hal_core_status.h"

#define UNUSED(x)  ((void)(x))
#define SRAM_RF_DELSEL            *((volatile uint32_t*) (0xA2010500))  /* RG   : Setting for sram*/
#define SRAM_HDE_DELSEL           *((volatile uint32_t*) (0xA2010504))  /* RG   : Setting for sram*/
#define SRAM_UHDE_DELSEL          *((volatile uint32_t*) (0xA2010508))  /* RG   : Setting for sram*/

#define PD_REG (0xa20c0060)
#define PU_REG (0xa20c0080)

int old_index=0;                                                        /* DATA : restore old vcore voltage index */
int pmu_switch_case = 0;                                                /* DATA : pmu lock vcore case */
uint8_t pmu_basic_index=0;                                              /* DATA : project init basic vocre index */
uint8_t pmu_lock_status=0;                                              /* DATA : lock status*/
volatile int pmu_i2c_init_sta = 0;                                      /* FLAG : init setting flag */
uint32_t pmu_rst_lpsd_config = 0xD;
uint8_t adie_version = 0xFF;
uint8_t adie_kgd = 0xFF;
uint8_t ic_version = IC_NONE;
uint16_t power_on_reason = 0;
uint8_t pmu_power_off_reason = 0;
uint8_t pmu_power_on_flag = 0, pmu_power_off_flag = 0;
uint8_t pmu_adc_flag = 0;
uint8_t pmu_pwrkey_cnt = 0;
bool pmu_pwrkey_ignore_rise = false;
pmu_function_t pmu_function_table_lp[PMU_INT_MAX_LP];                /* DATA : restore callback function */
static unsigned char Vcore_Resource_Ctrl[8];                             /* resource control : use in pmu_lock_vcore for resource control */
pmu_dynamic_debug_t pmu_dynamic_debug = { .val = 0 }; /* default all disabled */

extern uint32_t sub_chip_version_get(void);

#ifdef AIR_PMU_RTC_PATCH_ENABLE//for ECPM-77
extern hal_rtc_status_t hal_rtc_set_time_period_notify(hal_rtc_time_notification_period_t period);
#endif

/*==========[PMIC RG]==========*/
void pmu_d2d_pmic_int_np()
{
    (*((volatile uint32_t*)(PD_REG + 8))) = 1 << 24;//D2D_PMIC_INT
    (*((volatile uint32_t*)(PU_REG + 8))) = 1 << 24;//D2D_PMIC_INT
}

uint32_t pmu_d2d_i2c_read(unsigned char *ptr_send, unsigned char *ptr_read, int type)
{
    hal_i2c_send_to_receive_config_t config;
    unsigned char retry_cnt = 0, result_read;
    if (type == 1) {
        *(ptr_send) = *(ptr_send) | 0x40;
        config.receive_length = 1;
    } else {
        config.receive_length = 2;
    }
    config.slave_address = PMIC_SLAVE_ADDR;
    config.send_data = ptr_send;
    config.send_length = 2;
    config.receive_buffer = ptr_read;
    do {
        result_read = hal_i2c_master_send_to_receive_polling(HAL_I2C_MASTER_AO, &config);
        retry_cnt++;
        if (retry_cnt == 59) {
            log_hal_msgid_error("[PMU_BASIC]d2d_i2c_read fail", 0);
            assert(0);
        }
    } while ((result_read != 0) && (retry_cnt <= 60));
    return (retry_cnt);
}

pmu_operate_status_t pmu_i2c_dummy(void)
{
    unsigned char send_buffer[4], receive_buffer[2];
    //uint32_t value;
    //pmic_i2c_init();
    send_buffer[1] = 0x60A & 0x00FF; //D2D 2Byte
    send_buffer[0] = ((0x60A >> 8) & 0x00FF) & 0x0F;
    pmu_d2d_i2c_read(send_buffer, receive_buffer, 2);
    //value = (receive_buffer[1] << 8) + receive_buffer[0];
    //return ((value >> shift) & mask);

    return PMU_OK;
}

pmu_operate_status_t pmu_i2c_push_pull(void)
{
    unsigned char send_buffer[4];
    uint32_t data;
    unsigned char retry_cnt = 0, result_read;

    data = 0x00;//receive_buffer[1];
    data = (data << 8) | 0x07;//receive_buffer[0];
    data &= (~(I2C_DRV_SEL_MASK << I2C_DRV_SEL_SHIFT));
    data = data | (0x1 << I2C_DRV_SEL_SHIFT);

    send_buffer[0] = ((I2C_DRV_SEL_ADDR >> 8) & 0x00FF) | 0x00;
    send_buffer[1] = (I2C_DRV_SEL_ADDR) & 0x00FF;
    send_buffer[2] = (data & 0xFF);
    send_buffer[3] = ((data >> 8) & 0xFF);
    /*log_hal_msgid_info("[PMU_BASIC]i2c_push_pull, send_buffer3[0x%x], send_buffer2[0x%x], send_buffer1[0x%x], send_buffer0[0x%x]",
        4, send_buffer[3], send_buffer[2], send_buffer[1], send_buffer[0]);*/

    do {
        result_read = hal_i2c_master_send_polling(HAL_I2C_MASTER_AO, PMIC_SLAVE_ADDR, send_buffer, 4);
        retry_cnt++;
    } while ((result_read != 0) && (retry_cnt <= 60));

    if (result_read != 0) {
        log_hal_msgid_error("[PMU_BASIC]i2c_push_pull fail", 0);
        assert(0);
    }
    return PMU_OK;
}

void pmic_i2c_init(void)
{
    uint32_t mask_pri;
    hal_nvic_save_and_set_interrupt_mask_special(&mask_pri);
    if (pmu_i2c_init_sta == 1) {
        hal_nvic_restore_interrupt_mask_special(mask_pri);
        return;
    }
    int status;
    hal_i2c_config_t config;
    config.frequency = HAL_I2C_FREQUENCY_400K;
    status = hal_i2c_master_init(HAL_I2C_MASTER_AO, &config);
    if (status != HAL_I2C_STATUS_OK) {
        assert(0);
    }
    pmu_i2c_init_sta = 1;
    pmu_i2c_dummy();
    pmu_set_register_value(IO_CFG2, 0x7, 4, 0x5); //clk
    pmu_set_register_value(IO_CFG2, 0x7, 0, 0x5); //data

    pmu_i2c_push_pull();
    hal_gpt_delay_us(200);
    hal_i2c_master_set_io_config(HAL_I2C_MASTER_AO, HAL_I2C_IO_PUSH_PULL);
    i2c_config_speed(HAL_I2C_MASTER_AO, 2000000);
    hal_nvic_restore_interrupt_mask_special(mask_pri);
}

void pmic_i2c_deinit(void) {
    /*log_hal_msgid_error("[PMU_BASIC]pmic_i2c_deinit not support", 0);
    uint32_t mask_pri;
    hal_nvic_save_and_set_interrupt_mask(&mask_pri);
    hal_i2c_master_deinit(HAL_I2C_MASTER_AO);
    pmu_i2c_init_sta = 0;
    hal_nvic_restore_interrupt_mask(mask_pri);*/
}

uint32_t pmu_get_register_value_lp(uint32_t address, uint32_t mask, uint32_t shift)
{
    unsigned char send_buffer[4], receive_buffer[2];
    uint32_t value;
    pmic_i2c_init();
    send_buffer[1] = address & 0x00FF;
    send_buffer[0] = ((address >> 8) & 0x00FF) & 0x0F;
    pmu_d2d_i2c_read(send_buffer, receive_buffer, 2);
    value = (receive_buffer[1] << 8) + receive_buffer[0];

    /*if ((address == ADC_CON3) && (value & 0xF81E))
        log_hal_msgid_error("auxadc get, rg_406[0x%X]", 1, value);
    else if ((value & 0xF000) == 0x8000)
        log_hal_msgid_warning("auxadc get, addr[0x%X], value[0x%X]", 2, address, value);*/

    return ((value >> shift) & mask);
}

pmu_operate_status_t pmu_set_register_value_lp(uint32_t address, uint32_t mask, uint32_t shift, uint32_t value)
{
    unsigned char send_buffer[4], receive_buffer[2];
    uint32_t data;
    unsigned char retry_cnt = 0, result_read;

    pmic_i2c_init();
    send_buffer[1] = address & 0x00FF;
    send_buffer[0] = ((address >> 8) & 0x00FF) & 0x0F;
    pmu_d2d_i2c_read(send_buffer, receive_buffer, 2);

    data = receive_buffer[1];
    data = (data << 8) | receive_buffer[0];

    /*if ((address == ADC_CON3) && (data & 0xF81E))
    {
        log_hal_msgid_error("auxadc set, rg_406[0x%X]", 1, data);
    }
    else if ((data & 0xF000) == 0x8000)
    {
        log_hal_msgid_warning("auxadc set, addr[0x%X], value[0x%X]", 2, address, data);
    }*/

    data &= (~(mask << shift));
    if (address == CHARGER_CON1)
        data &= 0x1FAA;
    data = data | (value << shift);

    send_buffer[0] = ((address >> 8) & 0x00FF) | 0x00;
    send_buffer[1] = (address) & 0x00FF;
    send_buffer[2] = (data & 0xFF);
    send_buffer[3] = ((data >> 8) & 0xFF);

    do {
        result_read = hal_i2c_master_send_polling(HAL_I2C_MASTER_AO, PMIC_SLAVE_ADDR, send_buffer, 4);
        retry_cnt++;
    } while ((result_read != 0) && (retry_cnt <= 60));

    if (result_read != 0)
    {
        //log_hal_msgid_error("[PMU_BASIC]set_register_value fail, addr[0x%X], val[0x%X]", 2, address, value);
        assert(0);
    }

    return PMU_OK;
}

pmu_operate_status_t pmu_force_set_register_value_lp(uint32_t address, uint32_t value)
{
    unsigned char send_buffer[4];
    unsigned char retry_cnt = 0, result_read;

    pmic_i2c_init();
    send_buffer[0] = ((address >> 8) & 0x00FF) | 0x00;
    send_buffer[1] = (address) & 0x00FF;
    send_buffer[2] = (value & 0xFF);
    send_buffer[3] = ((value >> 8) & 0xFF);

    do {
        result_read = hal_i2c_master_send_polling(HAL_I2C_MASTER_AO, PMIC_SLAVE_ADDR, send_buffer, 4);
        retry_cnt++;
    }while ((result_read != 0) && (retry_cnt <= 60));

    if (result_read != 0)
    {
        //log_hal_msgid_error("[PMU_BASIC]force_set_register_value fail, addr[0x%X], val[0x%X]", 2, address, value);
        assert(0);
    }

    return PMU_OK;
}

void pmu_set_register_value_ddie(uint32_t address, short int mask, short int shift, short int value) {
    uint32_t mask_buffer,target_value;
    mask_buffer = (~(mask << shift));
    target_value = *((volatile uint32_t *)(address));
    target_value &= mask_buffer;
    target_value |= (value << shift);
    *((volatile uint32_t *)(address)) = target_value;
}

uint32_t pmu_get_register_value_ddie(uint32_t address, short int mask, short int shift) {
    uint32_t change_value, mask_buffer;
    mask_buffer = (mask << shift);
    change_value = *((volatile uint32_t *)(address));
    change_value &=mask_buffer;
    change_value = (change_value>> shift);
    return change_value;
}

void pmu_csr_write(int *data_ptr,int wdata)
{
    int *i;
    i=data_ptr;
    *i=wdata;
}

int pmu_csr_read(int *data_ptr)
{
    int *i;
    i=data_ptr;
    return *i;
}

/*==========[Get PMIC hw informantion]==========*/
void pmu_get_adie_version(void)
{
    hal_flash_init();
    hal_flash_otp_read(OTP_ADIE_VER_ADDR, (uint8_t *)&adie_version, 1);
    hal_flash_otp_read(OTP_ADIE_KGD_ADDR, (uint8_t *)&adie_kgd, 1);

    log_hal_msgid_info("[PMU_BASIC]get_adie_version[0x%X], adie_kgd[0x%X], ic_version[0x%X]", 3,
        adie_version, adie_kgd, pmu_get_ic_version());
}

uint32_t pmu_get_ic_version(void)
{
    if (ic_version == IC_NONE)
    {
        ic_version = sub_chip_version_get();
    }
    return ic_version;
}

uint8_t pmu_get_power_on_reason_lp(void) {
    if (pmu_power_on_flag == 0)
    {
        uint16_t reg_006 = pmu_get_register_value_lp(PMU_CON3, 0xFFFF, 0);
        uint16_t reg = reg_006 & 0x7FA;

        if (reg & (1 << PMU_REGEN_PON_FLAG))
        {
            power_on_reason |= PMU_KEY;
            power_on_reason |= BOOT_MODE;
            log_hal_msgid_info("[PMU_BASIC]power_on_reason, REGEN_PON", 0);
        }
        if (reg & (1 << PMU_RTC_ALARM_FLAG))
        {
            power_on_reason |= PMU_RTCA;
            log_hal_msgid_info("[PMU_BASIC]power_on_reason, RTC_ALARM", 0);
        }
        if (reg & (1 << PMU_CHG_PON_FLAG))
        {
            power_on_reason |= PMU_CHRIN;
            power_on_reason |= BOOT_MODE;
            log_hal_msgid_info("[PMU_BASIC]power_on_reason, CHG_PON", 0);
        }
        if (reg & (1 << PMU_CHG_ALARM_FLAG))
        {
            power_on_reason |= PMU_CHRIN;
            log_hal_msgid_info("[PMU_BASIC]power_on_reason, CHG_ALARM", 0);
        }
        if (reg & (1 << PMU_REGEN_ALARM_FLAG))
        {
            power_on_reason |= PMU_KEY;
            log_hal_msgid_info("[PMU_BASIC]power_on_reason, REGEN_ALARM", 0);
        }
        pmu_force_set_register_value_lp(PMU_CON3, reg);
        pmu_power_on_flag = 1;

        if ((adie_version == PMU_ECO3) || (adie_version == PMU_NO_FTK))
            pmu_set_register_value_lp(OFF2IDLE_FLAG_ADDR, OFF2IDLE_FLAG_MASK, OFF2IDLE_FLAG_SHIFT, 0x1);

        //log_hal_msgid_info("pmu_get_power_on_reason, reg_006[0x%X], reason[0x%X]", 2, reg_006, pmu_power_on_reason.value);
    }
    return power_on_reason;
}

uint8_t pmu_get_power_off_reason_lp(void) {
    if (pmu_power_off_flag == 0)
    {
        uint16_t reg_006 = pmu_get_register_value_lp(PMU_CON3, 0xFFFF, 0);
        uint16_t reg = reg_006 & 0xF83A;

        if (reg & (1 << PMU_RTC_MODE_FLAG))
        {
            pmu_power_off_reason = 1;
            log_hal_msgid_info("[PMU_BASIC]power_off_reason, RTC_MODE", 0);
        }
        if (reg & (1 << PMU_CAP_LPSD_FLAG))
        {
            pmu_power_off_reason = 14;
            log_hal_msgid_info("[PMU_BASIC]power_off_reason, CAP_LPSD", 0);
        }
        if (reg & (1 << PMU_REGEN_LPSD_FLAG))
        {
            pmu_power_off_reason = 10;
            log_hal_msgid_info("[PMU_BASIC]power_off_reason, REGEN_LPSD", 0);
        }
        if (reg & (1 << PMU_SYS_RST_FLAG))
        {
            pmu_power_off_reason = 13;
            log_hal_msgid_info("[PMU_BASIC]power_off_reason, SYS_RST", 0);
        }
        if (reg & (1 << PMU_WD_RST_FLAG))
        {
            pmu_power_off_reason = 8;
            log_hal_msgid_info("[PMU_BASIC]power_off_reason, WD_RST", 0);
        }
        if (pmu_power_off_reason == 0)
        {
            log_hal_msgid_info("[PMU_BASIC]power_off_reason, OFF_MODE", 0);
        }
        pmu_force_set_register_value_lp(PMU_CON3, reg);
        pmu_power_off_flag = 1;

        //log_hal_msgid_info("pmu_get_power_off_reason, reg_006[0x%X], reason[%d]", 2, reg_006, pmu_power_off_reason);
    }

    return pmu_power_off_reason;
}

/*when boot up,press power key need more than the specific time*/
void pmu_press_pk_time(void) {
    uint8_t pk_sta;
    uint32_t pmu_gpt_start, pmu_get_press_time, pmu_get_duration_time = 0;
    hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &pmu_gpt_start);
    while (1) {
        pk_sta = pmu_get_register_value_lp(AD_REGEN_DEB_ADDR, AD_REGEN_DEB_MASK, AD_REGEN_DEB_SHIFT);
        if (pk_sta == 1) {
            hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &pmu_get_press_time);
            hal_gpt_get_duration_count(pmu_gpt_start, pmu_get_press_time, &pmu_get_duration_time);
        } else {
            pmu_get_press_time = 0;
            log_hal_msgid_error("[PMU_BASIC]ON[%x]OFF[%x]DT[%d]PT[%d]",4,pmu_get_power_on_reason_lp(),pmu_get_power_off_reason_lp(),pmu_get_duration_time,PMU_PRESS_PK_TIME);
            log_hal_msgid_error("[PMU_BASIC]Boot up fail , press pk need more than the specific time %d or PMIC OP", 1,PMU_PRESS_PK_TIME);
            pmu_adc_flag = 1;
            hal_gpt_delay_ms(1);
            hal_rtc_init();
            hal_rtc_enter_rtc_mode();
        }
        if (pmu_get_duration_time > PMU_PRESS_PK_TIME) {
            log_hal_msgid_info("[PMU_BASIC]pmu_press_pk_time, ok", 0);
            break;
        }
    }
}

/*==========[Basic function]==========*/
void pmu_init_lp() {
    pmu_d2d_pmic_int_np();
    pmu_get_adie_version();
    pmu_get_power_off_reason_lp();
    pmu_get_power_on_reason_lp();

if ((pmu_get_power_on_reason_lp() & 0x11) && (pmu_get_power_off_reason_lp() != 8) && ((pmu_get_power_on_reason_lp() & 0xC) == 0))
    pmu_press_pk_time();

#ifdef AIR_PMU_RTC_PATCH_ENABLE//for ECPM-77
    pmu_force_set_register_value_lp(0x006, ((pmu_get_register_value_lp(0x006, 0xFFFF, 0) & 0xFFFA) | 0xA)); //enable regen key intr
    hal_rtc_init();
    if (hal_rtc_set_time_period_notify(HAL_RTC_TIME_NOTIFICATION_EVERY_SECOND) != HAL_RTC_STATUS_OK) {
        //log_hal_msgid_error("[PMU_BASIC]rtc_patch, rtc_tick_alarm set fail", 0);
        assert(0);
    }
    log_hal_msgid_info("[PMU_BASIC]rtc_patch enable", 0);
#else
    hal_rtc_init();
    if (hal_rtc_set_time_notification_period(HAL_RTC_TIME_NOTIFICATION_NONE) != HAL_RTC_STATUS_OK) {
        log_hal_msgid_error("[PMU_BASIC]rtc_patch, rtc_tick_alarm stop fail", 0);
        assert(0);
    }
#endif

    pmu_set_register_value_lp(0x004, 0x7, 9, 0x6); //uvsd vcore, vio, ocp
    pmu_set_register_value_lp(0x004, 0xF, 5, 0xF); //rst, lpsd(nvkey)
    pmu_set_register_value_lp(0x00E, BGR_TRIM_ENB_MASK, 8, 0x0);
    pmu_set_register_value_lp(0x010, 0xFF, 8, 0x0); //buck vio, vcore en
    pmu_set_register_value_lp(0x016, SRCLK_EN_IC_MASK, 12, 0x0);
    pmu_set_register_value_lp(0x01E, RESERVE_MASK, 0, 0x0);
    pmu_set_register_value_lp(0x328, SW_OCP_ENB_MASK, 7, 0x0);

    if (adie_version == PMU_ECO3 || adie_version == PMU_NO_FTK)
    {
        pmu_set_register_value_lp(0x020, OC_PROT_DEB_TIME_MASK, 4, 0x1F);
        pmu_set_register_value_lp(0x020, 0x3, 0, 0x3); //off port en chgflo b, chg plug
        pmu_set_register_value_lp(0x100, BUCK_DISQ_RSEL_LV_MASK, 0, 0x1);
        pmu_set_register_value_lp(0x106, BUCK_DISQ_RSEL_MV_MASK, 0, 0x1);
    }
    else
    {
        pmu_set_register_value_lp(0x10E, BUCK_DISQ_LV_OFF_E2_MASK, 6, 0x1);
        pmu_set_register_value_lp(0x110, BUCK_DISQ_MV_OFF_E2_MASK, 6, 0x1);
    }
#ifndef AIR_PMU_DISABLE_CHARGER
    pmu_eoc_ctrl(PMU_OFF);
    if (pmu_get_chr_detect_value_lp()) {
        pmu_uart_psw_cl(PMU_OFF);
        pmu_enable_charger_lp(PMU_ON);
    } else {
        pmu_uart_psw_cl(PMU_ON);
    }
    pmu_uart_psw(PMU_ON);
#endif
    pmu_vio18_pull_up(PMU_OFF);

    log_hal_msgid_info("[PMU_BASIC]pmu_init_65, rg_002[0x%X], rg_004[0x%X], rg_006[0x%X], rg_00E[0x%X], rg_01E[0x%X], rg_320[0x%X], rg_322[0x%X]", 7,
        pmu_get_register_value_lp(0x002, 0xFFFF, 0), pmu_get_register_value_lp(0x004, 0xFFFF, 0),
        pmu_get_register_value_lp(0x006, 0xFFFF, 0), pmu_get_register_value_lp(0x00E, 0xFFFF, 0),
        pmu_get_register_value_lp(0x01E, 0xFFFF, 0), pmu_get_register_value_lp(0x320, 0xFFFF, 0), pmu_get_register_value_lp(0x322, 0xFFFF, 0));

    pmu_eint_init();
    pmu_auxadc_init();

#ifdef HAL_SLEEP_MANAGER_ENABLED
    sleep_management_register_suspend_callback(SLEEP_BACKUP_RESTORE_PMU, (sleep_management_suspend_callback_t)hal_pmu_sleep_backup, NULL);
    sleep_management_register_resume_callback(SLEEP_BACKUP_RESTORE_PMU, (sleep_management_suspend_callback_t)hal_pmu_sleep_resume, NULL);
#endif
    //pmu_assert_exception_dump();
}

void pmu_config_lp(void)
{
    pmu_cal_init();
    pmu_set_init();
#ifndef AIR_PMU_DISABLE_CHARGER
    pmu_chg_init();
    pmu_bat_init();
#ifdef HAL_ADC_MODULE_ENABLED
    pmu_ntc_init();
#endif
#endif
}

void pmu_power_off_sequence_lp(pmu_power_stage_t stage) {
    switch(stage) {
        case PMU_PWROFF:
            pmu_auxadc_get_channel_value(PMU_AUX_VCHG);
            log_hal_msgid_info("[PMU_BASIC]power_off_sequence OFF, rg_002[0x%X], rg_01E[0x%X], rg_320[0x%X], rg_322[0x%X], rg_606[0x%X], rg_608[0x%X], rg_60A[0x%X]", 7,
                pmu_get_register_value_lp(0x002, 0xFFFF, 0), pmu_get_register_value_lp(0x01E, 0xFFFF, 0),
                pmu_get_register_value_lp(0x320, 0xFFFF, 0), pmu_get_register_value_lp(0x322, 0xFFFF, 0), pmu_get_register_value_lp(0x606, 0xFFFF, 0),
                pmu_get_register_value_lp(0x608, 0xFFFF, 0), pmu_get_register_value_lp(0x60A, 0xFFFF, 0));

            pmu_set_register_value_lp(PMU_CON2, PWR_OFF_MASK, PWR_OFF_SHIFT, 0x1);
            break;
        case PMU_RTC:
            pmu_set_register_value_lp(0x328, SW_OCP_ENB_MASK, 7, 0x1);

            if (adie_version == PMU_ECO3 || adie_version == PMU_NO_FTK)
                pmu_set_register_value_lp(0x00E, BGR_TRIM_ENB_MASK, 8, 0x1);
            else
                pmu_set_register_value_lp(0x00E, BGR_TRIM_ENB_MASK, 8, 0x0);

            pmu_set_register_value_lp(0x01E, 0x1, 5, 0x1); //chg_sys lpm mode
            if (pmu_get_chr_detect_value_lp())
                pmu_set_register_value_lp(0x01E, 0x1, 6, 0x1); //bat_sys force sw off
            else
                pmu_set_register_value_lp(0x01E, 0x1, 6, 0x0);

#ifndef AIR_PMU_DISABLE_CHARGER
            pmu_enable_charger_lp(PMU_OFF);
            uint32_t vbat = 0;
            if (!pmu_adc_flag) {
                vbat = pmu_auxadc_get_channel_value(PMU_AUX_VBAT);
            }
            if (vbat > 3200) {
                pmu_eoc_ctrl(PMU_ON);
                pmu_uart_psw(PMU_OFF);
                pmu_uart_psw_cl(PMU_OFF);
            } else {
                pmu_eoc_ctrl(PMU_OFF);
                pmu_uart_psw(PMU_ON);
                pmu_uart_psw_cl(PMU_ON);
            }
#endif
            pmu_clear_interrupt(0);
#ifdef AIR_PMU_RTC_PATCH_ENABLE//for ECPM-77
            pmu_force_set_register_value_lp(0x006, (pmu_get_register_value_lp(0x006, 0xFFFF, 0) & 0xFFF5));//disable regen key intr
            if (hal_rtc_set_time_period_notify(HAL_RTC_TIME_NOTIFICATION_NONE) != HAL_RTC_STATUS_OK) {
                //log_hal_msgid_error("[PMU_BASIC]rtc_patch, rtc_tick_alarm stop fail", 0);
                assert(0);
            }
#endif
            log_hal_msgid_info("[PMU_BASIC]power_off_sequence RTC, rg_002[0x%X], rg_004[0x%X], rg_006[0x%X], rg_00E[0x%X], rg_01E[0x%X], rg_320[0x%X], rg_322[0x%X], rg_606[0x%X], rg_608[0x%X], rg_60A[0x%X]", 10,
                pmu_get_register_value_lp(0x002, 0xFFFF, 0), pmu_get_register_value_lp(0x004, 0xFFFF, 0), pmu_get_register_value_lp(0x006, 0xFFFF, 0),
                pmu_get_register_value_lp(0x00E, 0xFFFF, 0), pmu_get_register_value_lp(0x01E, 0xFFFF, 0), pmu_get_register_value_lp(0x320, 0xFFFF, 0),
                pmu_get_register_value_lp(0x322, 0xFFFF, 0), pmu_get_register_value_lp(0x606, 0xFFFF, 0), pmu_get_register_value_lp(0x608, 0xFFFF, 0), pmu_get_register_value_lp(0x60A, 0xFFFF, 0));

            pmu_set_register_value_lp(PMU_CON2, RTC_MODE_MASK, RTC_MODE_SHIFT, 0x1);
            break;
        case PMU_SLEEP:
            if (adie_version == PMU_ECO1 || adie_version == PMU_ECO2)
            {
                pmu_set_register_value_lp(PMU_CON2, 0xF, 5, 0);//disable lpsd,rst
            }
            pmu_set_register_value_lp(0x00E, BGR_TRIM_ENB_MASK, 8, 0x0);
            break;
        case PMU_NORMAL:
            break;
        case PMU_DVS:
            break;
        default:
            break;
    }
}

void hal_pmu_sleep_backup(void) {
    pmu_power_off_sequence_lp(PMU_SLEEP);
    //pmic_i2c_deinit();
}

void hal_pmu_sleep_resume(void) {
    if (adie_version == PMU_ECO1 || adie_version == PMU_ECO2)
        pmu_set_register_value_lp(PMU_CON2, 0xF, 5, pmu_rst_lpsd_config);
}

/*==========[PMIC irq]==========*/
void pmu_eint_init(void)
{
    //log_hal_msgid_info("[PMU_BASIC]eint_init", 0);
    hal_eint_config_t config;
    config.trigger_mode = HAL_EINT_LEVEL_LOW;//HAL_EINT_EDGE_FALLING;
    config.debounce_time = 0;
    hal_eint_init(HAL_EINT_PMU, &config);    /*set EINT trigger mode and debounce time.*/
    hal_eint_register_callback(HAL_EINT_PMU, pmu_eint_handler, NULL);  /*register a user callback.*/
    hal_eint_unmask(HAL_EINT_PMU);
}

void pmu_eint_handler(void *parameter)
{
    UNUSED(parameter);
    uint16_t chg_reg, pwrkey_reg, auxadc_reg, chg_mask, pwrkey_mask, auxadc_mask, chg_flag, pwrkey_flag, tmp;
    uint32_t time0 = 0;
    uint32_t time1 = 0;

    hal_eint_mask(HAL_EINT_PMU);
    chg_reg = pmu_get_register_value_lp(CHARGER_CON1, 0xFFFF, 0);
    pwrkey_reg = pmu_get_register_value_lp(PMU_CON3, 0xFFFF, 0);
    auxadc_reg = pmu_get_register_value_lp(ADC_CON3, 0xFFFF, 0);

    chg_mask = chg_reg & 0x55;
    pwrkey_mask = pwrkey_reg & 0x5;
    auxadc_mask = auxadc_reg & 0xA;
    chg_flag = chg_mask;
    pwrkey_flag = pwrkey_mask;

    log_hal_msgid_info("[PMU_BASIC]pmu_eint, rg_320[0x%X], rg_006[0x%X], rg_406[0x%X], chg[0x%X], pwrkey[0x%X], auxadc[0x%X]", 6,
                       chg_reg, pwrkey_reg, auxadc_reg, chg_mask, pwrkey_mask, auxadc_mask);
#if 0
#ifdef PMU_WO_MPLOG
    log_hal_msgid_info("[PMU_BASIC]pmu_eint, rg_320[0x%X], rg_006[0x%X], rg_406[0x%X], chg[0x%X], pwrkey[0x%X], auxadc[0x%X]", 6,
    chg_reg, pwrkey_reg, auxadc_reg, chg_mask, pwrkey_mask, auxadc_mask);
#else
    LOG_MSGID_W(MPLOG,"[PMU_BASIC]pmu_eint, rg_320[0x%X], rg_006[0x%X], rg_406[0x%X], chg[0x%X], pwrkey[0x%X], auxadc[0x%X]", 6,
    chg_reg, pwrkey_reg, auxadc_reg, chg_mask, pwrkey_mask, auxadc_mask);
#endif
#endif
    if (chg_mask)
    {
        pmu_force_set_register_value_lp(CHARGER_CON1, chg_reg);
        /*tmp = chg_reg & 0x1F00;
        pmu_force_set_register_value_lp(CHARGER_CON1, tmp);
        tmp = chg_reg & 0x1F55;
        pmu_force_set_register_value_lp(CHARGER_CON1, tmp);
        hal_gpt_delay_us(250);
        tmp = chg_reg & 0x1FAA;
        pmu_force_set_register_value_lp(CHARGER_CON1, tmp);*/
    }
    if (pwrkey_mask)
    {
        pmu_force_set_register_value_lp(PMU_CON3, pwrkey_reg);
    }
    if (auxadc_mask)
    {
        tmp = auxadc_reg & 0x7EA;
        pmu_force_set_register_value_lp(ADC_CON3, tmp);
    }

    hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &time0);
    while (1)
    {
        hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &time1);

        if (chg_mask)
        {
            chg_reg = pmu_get_register_value_lp(CHARGER_CON1, 0xFFFF, 0);
            chg_mask &= chg_reg;
        }
        if (pwrkey_mask)
        {
            pwrkey_reg = pmu_get_register_value_lp(PMU_CON3, 0xFFFF, 0);
            pwrkey_mask &= pwrkey_reg;
        }
        if (((chg_mask == 0) && (pwrkey_mask == 0)) || ((time1 - time0) > 1000))
            break;
    }

    if (((time1 - time0) > 1000) && (chg_mask || pwrkey_mask))
    {
        log_hal_msgid_error("[PMU_BASIC]pmu_eint fail, w1c_time:[%dus], reg_320[0x%x], reg_006[0x%x], chg_mask[0x%x], pwrkey_mask[0x%x], chg_is_plug[%d]", 6,
            (time1 - time0), chg_reg, pwrkey_reg, chg_mask, pwrkey_mask, pmu_get_chr_detect_value_lp());
        //assert(0);
    }

    if (chg_flag)
    {
#ifndef AIR_PMU_DISABLE_CHARGER
        pmu_chg_hdlr(chg_flag);
#endif
    }
    if (pwrkey_flag)
    {
        pmu_pwrkey_handler(pwrkey_flag);
    }
    hal_eint_unmask(HAL_EINT_PMU);
}

void pmu_pwrkey_handler(uint16_t pwrkey_flag)
{
    //log_hal_msgid_info("[PMU_BASIC]pwrkey_handler, pwrkey_flag[0x%X]", 1, pwrkey_flag);
    if ((pmu_function_table_lp[RG_INT_PWRKEY_RISE].pmu_callback == NULL) ||
        (pmu_function_table_lp[RG_INT_PWRKEY_FALL].pmu_callback == NULL)) {
        return;
    }

    if (pmu_pwrkey_cnt < 2) {
        pmu_pwrkey_cnt += 1;
        log_hal_msgid_info("[PMU_BASIC]pwrkey_handler, pmu_pwrkey_cnt[%d]", 1, pmu_pwrkey_cnt);
        if ((pmu_pwrkey_cnt == 1) && (pwrkey_flag == 0x5) && pmu_get_pwrkey_state_lp()) {
            pmu_function_table_lp[RG_INT_PWRKEY_RISE].pmu_callback();
            pmu_pwrkey_ignore_rise = true;
            return;
        } else if ((pmu_pwrkey_cnt == 2) && (pwrkey_flag == 0x1) && pmu_pwrkey_ignore_rise) {
            log_hal_msgid_error("[PMU_BASIC]pwrkey_handler, ignore press", 0);
            return;
        }
    }

    if (pwrkey_flag & (1 << PMU_PWRKEY_IRQ_RISE_FLAG)) {
        pmu_function_table_lp[RG_INT_PWRKEY_RISE].pmu_callback();
    }
    if (pwrkey_flag & (1 << PMU_PWRKEY_IRQ_FALL_FLAG)) {
        pmu_function_table_lp[RG_INT_PWRKEY_FALL].pmu_callback();
    }
}

pmu_status_t pmu_register_callback_lp(pmu_interrupt_index_lp_t pmu_int_ch, pmu_callback_t callback, void *user_data)
{
    if(pmu_int_ch >= PMU_INT_MAX_LP || callback == NULL)
    {
        //log_hal_msgid_error("[PMU_BASIC]register_callback fail, pmu_int_ch[%d]", 1, pmu_int_ch);
        return PMU_STATUS_INVALID_PARAMETER;
    }
#ifdef AIR_PMU_DISABLE_CHARGER
    if ((pmu_int_ch >= RG_INT_CHG_IN) && (pmu_int_ch <= RG_INT_CHG_RECHG))
    {
        //log_hal_msgid_error("[PMU_BASIC]register_callback, bypass for dongle", 0);
        //assert(0);
    }
#endif

    pmu_function_table_lp[pmu_int_ch].init_status = PMU_INIT;
    pmu_function_table_lp[pmu_int_ch].pmu_callback = callback;
    pmu_function_table_lp[pmu_int_ch].user_data = user_data;
    pmu_function_table_lp[pmu_int_ch].isMask = false;

    //log_hal_msgid_info("pmu_register_callback_lp, pmu_int_ch[%d]", 1, pmu_int_ch);

    return PMU_STATUS_SUCCESS;
}

pmu_status_t pmu_deregister_callback_lp(pmu_interrupt_index_lp_t pmu_int_ch)
{
    if(pmu_int_ch >= PMU_INT_MAX_LP)
    {
        return PMU_STATUS_INVALID_PARAMETER;
    }
#ifdef AIR_PMU_DISABLE_CHARGER
    if ((pmu_int_ch >= RG_INT_CHG_IN) && (pmu_int_ch <= RG_INT_CHG_RECHG))
    {
        //log_hal_msgid_error("[PMU_BASIC]deregister_callback, bypass for dongle", 0);
        //assert(0);
    }
#endif

    pmu_function_table_lp[pmu_int_ch].init_status = PMU_NOT_INIT;
    pmu_function_table_lp[pmu_int_ch].pmu_callback = NULL;
    pmu_function_table_lp[pmu_int_ch].user_data = NULL;
    pmu_function_table_lp[pmu_int_ch].isMask= true;

    //log_hal_msgid_info("pmu_deregister_callback_lp, pmu_int_ch[%d]", 1, pmu_int_ch);

    return PMU_STATUS_SUCCESS;
}

/*==========[Power key & Cap touch]==========*/
void pmu_latch_power_key_for_bootloader_lp(void)
{
    pmu_set_register_value_lp(PMU_CON2, 0xF, 5, 0xF);
}

pmu_operate_status_t pmu_lpsd_rst_enable(pmu_lpsd_rst_sel_t sel, pmu_power_operate_t oper)
{
    if ((sel < CAP_LPSD) || (sel > WD_RST))
    {
        return PMU_ERROR;
    }
    uint32_t rg_004 = pmu_get_register_value_lp(PMU_CON2, 0xFFFF, 0);
    uint32_t val = rg_004 & 0x7FFC;

    if (oper == PMU_ON)
    {
        pmu_rst_lpsd_config |= (1 << sel);
        val |= (1 << (sel + 5));
    }
    else
    {
        pmu_rst_lpsd_config &= (uint32_t)(~(1 << sel));
        val &= (uint32_t)(~(1 << (sel + 5)));
    }
    pmu_force_set_register_value_lp(PMU_CON2, val);

    if(hal_core_status_read(HAL_CORE_MCU) != HAL_CORE_EXCEPTION)
        log_hal_msgid_info("[PMU_BASIC]lpsd_rst_enable, rg_004[0x%X], val[0x%X], pmu_rst_lpsd_config[0x%X]", 3, rg_004, val, pmu_rst_lpsd_config);

    return PMU_OK;
}

pmu_operate_status_t pmu_pwrkey_enable_lp(pmu_power_operate_t oper) {
    return pmu_lpsd_rst_enable(REGEN_LPSD, oper);
}

pmu_operate_status_t pmu_pwrkey_duration_time(pmu_lpsd_time_t tmr) {
    UNUSED(tmr);
    //log_hal_msgid_warning("[PMU_BASIC]pwrkey_duration_time not support", 0);
    return PMU_INVALID;
    //return pmu_set_register_value_ab2568(PMU_RSTCFG3, PMU_RG_PWRKEY_RST_TD_MASK, PMU_RG_PWRKEY_RST_TD_SHIFT, tmr);
}

bool pmu_get_pwrkey_state_lp(void)
{
    uint32_t state;

    if ((adie_version == PMU_ECO3) || (adie_version == PMU_NO_FTK))
        state = pmu_get_register_value_lp(AD_REGEN_DEB_ADDR, AD_REGEN_DEB_MASK, AD_REGEN_DEB_SHIFT);
    else
        state = pmu_get_register_value_lp(AD_REGEN_E2_ADDR, AD_REGEN_E2_MASK, AD_REGEN_E2_SHIFT);

    //log_hal_msgid_info("[PMU_BASIC]get_pwrkey_state, is_press[%d]", 1, state);

    if (state)
        return TRUE;
    else
        return FALSE;
}

/*Internal use for force LPSD*/
void pmu_enable_lpsd_lp(void){
    pmu_pwrkey_enable_lp(PMU_ON);
    pmu_lpsd_rst_enable(CAP_LPSD, PMU_ON);
}

pmu_operate_status_t pmu_pwrkey_normal_key_init_lp(pmu_pwrkey_config_t *config)
{
    pmu_status_t status = PMU_STATUS_ERROR;
    status = pmu_register_callback_lp(RG_INT_PWRKEY_RISE, config->callback1,config->user_data1);
    if (status != PMU_STATUS_SUCCESS) {
        return PMU_ERROR;
    }

    status = pmu_register_callback_lp(RG_INT_PWRKEY_FALL,config->callback2,config->user_data2);
    if (status != PMU_STATUS_SUCCESS) {
        return PMU_ERROR;
    }
#ifdef AIR_PMU_RTC_PATCH_ENABLE
    uint16_t rg_006 = pmu_get_register_value_lp(0x006, 0xFFFF, 0);
    if (((rg_006 & 0x1) == 0) && (pmu_get_pwrkey_state_lp() || (pmu_get_power_on_reason_lp() & 0x11))) {
        log_hal_msgid_error("[PMU_BASIC]pwrkey_normal_key_init, add rise, rg_006[0x%X]", 1, rg_006);
        pmu_function_table_lp[RG_INT_PWRKEY_RISE].pmu_callback();
        if((rg_006 & 0x4)){
            pmu_function_table_lp[RG_INT_PWRKEY_FALL].pmu_callback();
            pmu_force_set_register_value_lp(0x006, pmu_get_register_value_lp(0x006, 0xFFFF, 0)); //clean pwrkey intr
            hal_gpt_delay_us(100); //avoid 2 W1T
        }
    }
#endif
    return PMU_OK;
}

uint8_t pmu_get_usb_input_status_lp(void) // For usb driver get usb put in status
{
    return (uint8_t)pmu_get_chr_detect_value_lp();
}

/*==========[Buck/Ldo voltage]==========*/
pmu_operate_status_t pmu_select_vcore_voltage_lp(pmu_power_stage_t mode, pmu_power_vcore_voltage_t vol) {
    if ((mode > PMU_DVS) | (mode < PMU_SLEEP) | (vol > PMIC_VCORE_0P9_V) | (vol < PMIC_VCORE_0P5_V)) {
        log_hal_msgid_error("[PMU_BASIC]vcore_voltage error input", 0);
        return PMU_ERROR;
    }
    if ((mode !=PMU_DVS) && (pmu_lock_status > 0)) {
        log_hal_msgid_error("[PMU_BASIC]vcore in locked ", 0);
        return PMU_ERROR;
    }
    switch (vol)
    {
        case PMIC_VCORE_0P8_V:
            pmu_set_register_value_lp(BUCK_LVOUTSEL_LV_NORM_ADDR, BUCK_LVOUTSEL_LV_NORM_MASK, BUCK_LVOUTSEL_LV_NORM_SHIFT, 0x1);
            break;
        case PMIC_VCORE_0P9_V:
            pmu_set_register_value_lp(BUCK_LVOUTSEL_LV_NORM_ADDR, BUCK_LVOUTSEL_LV_NORM_MASK, BUCK_LVOUTSEL_LV_NORM_SHIFT, 0x0);
            break;
        default:
            break;
    }

    return PMU_OK;
}

pmu_power_vcore_voltage_t pmu_get_vcore_voltage_lp(void) {
    uint32_t temp = pmu_get_register_value_lp(BUCK_LVOUTSEL_LV_NORM_ADDR, BUCK_LVOUTSEL_LV_NORM_MASK, BUCK_LVOUTSEL_LV_NORM_SHIFT);
    if (temp == 0)
        return PMIC_VCORE_0P9_V;
    else
        return PMIC_VCORE_0P8_V;
}

/*For DVFS select vsram voltage*/
void pmu_ddie_sram_setting(uint8_t ste) {
    if (ste >= 6) {
        //sram 0.9V
        SRAM_RF_DELSEL = 0x0000010B; //SRAM_RF_DELSEL
        SRAM_HDE_DELSEL = 0x00000102; //SRAM_HDE_DELSEL
        SRAM_UHDE_DELSEL = 0x00030102; //SRAM_UHDE_DELSEL
    } else {
        SRAM_RF_DELSEL = 0x00000304; //SRAM_RF_DELSEL
        SRAM_HDE_DELSEL = 0x00000304; //SRAM_HDE_DELSEL
        SRAM_UHDE_DELSEL = 0x00050303; //SRAM_UHDE_DELSEL
    }
}

pmu_power_vcore_voltage_t pmu_lock_vcore_lp(pmu_power_stage_t mode,pmu_power_vcore_voltage_t vol,pmu_lock_parameter_t lock) {
    if(pmu_dynamic_debug.b.vcore){
        log_hal_msgid_info("[PMU_PWR]lock vol %d, lock %d[0:lock 1:unlock]\r\n",2, vol, lock);
    }
    int i = 0;
    int temp = 0;
    int vol_index = 0;

    uint32_t mask_pri;
    if(vol>=PMIC_VCORE_FAIL_V) {
        return PMIC_VCORE_FAIL_V;
    }
    if(mode == PMU_SLEEP) {
    } else {
        hal_nvic_save_and_set_interrupt_mask_special(&mask_pri);
        if (lock == PMU_LOCK) {
            Vcore_Resource_Ctrl[vol]++;
        } else {
            if (Vcore_Resource_Ctrl[vol] != 0) {
                Vcore_Resource_Ctrl[vol]--;
            }
        }
        /*Find Highest Vcore Voltage*/
        for (vol_index = PMIC_VCORE_0P9_V; vol_index > PMIC_VCORE_0P5_V; vol_index--) {
            if (Vcore_Resource_Ctrl[vol_index] != 0) {
                break;
            }
        }
        for (i = PMIC_VCORE_0P5_V; i <= PMIC_VCORE_0P9_V; i++) {
            temp += Vcore_Resource_Ctrl[i];
        }
        if(temp > 25){
            //log_hal_msgid_error("[PMU_BASIC]lock_vcore fail, PMU Lock /unlock isn't match more ten times",0);
            assert(0);
        }
        pmu_lock_status = temp;
        /*if not module lock ,return default setting*/
        if (temp == 0) {
            pmu_switch_case = 3;
            pmu_select_vcore_voltage_lp(PMU_DVS, pmu_basic_index);
            hal_nvic_restore_interrupt_mask_special(mask_pri);
        } else {
            if (old_index < vol_index) {
                pmu_switch_case = 2;
                pmu_select_vcore_voltage_lp(PMU_DVS, vol_index);
                pmu_ddie_sram_setting(vol_index);
            } else if(old_index > vol_index) {
                pmu_switch_case = 1;
                pmu_ddie_sram_setting(vol_index);
                pmu_select_vcore_voltage_lp(PMU_DVS, vol_index);
            } else {
                pmu_switch_case = 0;
            }
            old_index = vol_index;
            hal_nvic_restore_interrupt_mask_special(mask_pri);
        }
    }
    if(pmu_dynamic_debug.b.vcore){
        //log_hal_msgid_info("[PMU_BASIC]SRAM RF[0x%x] HDE[0x%x] UHDE[0x%x]",3, SRAM_RF_DELSEL,SRAM_HDE_DELSEL,SRAM_UHDE_DELSEL);
        log_hal_msgid_info("[PMU_PWR]vcore lock %d, lock state %d, switch_case %d\r\n",3,pmu_get_vcore_voltage_lp(),temp,pmu_switch_case);
    }
    return vol_index;
}

void pmu_get_lock_status_lp(int sta){
    log_hal_msgid_info("[PMU_PWR]current lock vol = %d  sta :%d[0:Before lock 1:Afeter lock]",2, pmu_get_vcore_voltage_lp(), sta);
    log_hal_msgid_info("[PMU_PWR]SRAM RF[0x%x] HDE[0x%x] UHDE[0x%x]",3, SRAM_RF_DELSEL,SRAM_HDE_DELSEL,SRAM_UHDE_DELSEL);
    log_hal_msgid_info("[PMU_PWR]lock state : %d pmu_switch_case = %d[2:up;1:;down;0:ignore]",2,pmu_lock_status,pmu_switch_case);
}
void pmu_set_vaud18_voltage_lp(pmu_power_vaud18_voltage_t oper){
    //log_hal_msgid_info("[PMU_BASIC]Buck doesn't needed change",0);
}
/*==========[Unused]==========*/
pmu_status_t pmu_clear_interrupt(pmu_interrupt_index_t int_channel) {
    UNUSED(int_channel);
    pmu_force_set_register_value_lp(0x006, pmu_get_register_value_lp(0x006, 0xFFFF, 0)); //clean pwrkey intr
    pmu_force_set_register_value_lp(0x320, pmu_get_register_value_lp(0x320, 0xFFFF, 0)); //clean chg intr
    return PMU_STATUS_SUCCESS;
}

#endif /* HAL_PMU_MODULE_ENABLED */
