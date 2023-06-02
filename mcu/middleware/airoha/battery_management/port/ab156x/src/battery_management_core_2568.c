/* Copyright Statement:
 *
 * (C) 2019  Airoha Technology Corp. All rights reserved.
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

#include "battery_management_core.h"

#include "task.h"
#include "task_def.h"
#include "hal_flash.h"
#include "hal_nvic_internal.h"
#include "hal_sleep_manager_internal.h"
#include "hal_pmu.h"
#ifdef HAL_USB_MODULE_ENABLED
#include "hal_usb.h"
#include "hal_usb_internal.h"
#endif
#ifndef MTK_BATTERY_MANAGEMENT_STATIC_INIT_ENABLE
#endif

#ifdef MTK_NVDM_ENABLE
#include "nvkey.h"
#include "nvkey_id_list.h"
#endif


uint8_t gauge_cardinal_number;                /*Data : For gauge calculation*/
uint8_t battery_align_flag = 0;               /*flag : Avoid VBUS shaking, ensure the Irq data is consistent this time */
uint8_t battery_init_setting_flag = 0;        /*flag : Check battery init setting is finish or not*/
static uint32_t battery_callback_index = 0;   /*Data : Restore register callback function number */
uint8_t battery_VA18_flag = 0;                /*flag : Request VA18 flag*/
TimerHandle_t xbm_chr_detec_t;                /*Timer : When PMIC irq"CHRDET" is Triggered, this timer will receive from pmic irq regiseter callbcck for processing*/
TimerHandle_t xbm_jeita_timer;                /*Timer : When With NTC and HW-JEITA is enable ,This timer will check JEITA status*/
TimerHandle_t xbm_eoc_timer;                  /*Timer : 1st enter the EOC will implement , to ensure that EOC verification can be performed without battery*/
TimerHandle_t xbm_option_setting_timer;       /*Timer : EOC setting will used, divided into multiple segments increase system resource allocation */
TimerHandle_t xbm_chrdet_calibration_timer;   /*Timer : Avoid unexpected problems caused by irq shake*/
TimerHandle_t xbm_chager_detect_timer;        /*Timer : one shot for charger detect*/

const char *bm_charger_type[10] = { "", "SDP", "CDP", "DCP", "SS", "IPAD2_IPAD4", "IPHONE_5V_1A", "NON-STD", "DP/DM_Floating", "UNABLE_TO_IDENTIFY"};    /*Data : For output log */
const char *bm_charger_state[8] = { "CHARGER OFF", "PRECC", "CC", "EXTENSION", "EOC", "THERMAL", "VBAT_OVP", "SAFETY TIMER"};                            /*Data : For output log */
int charger_current[10] = {pmu_fastcc_chrcur_100mA,pmu_fastcc_chrcur_200mA, pmu_fastcc_chrcur_300mA, pmu_fastcc_chrcur_400mA, pmu_fastcc_chrcur_500mA,
                          pmu_fastcc_chrcur_20mA,pmu_fastcc_chrcur_40mA,pmu_fastcc_chrcur_50mA,pmu_fastcc_chrcur_60mA,pmu_fastcc_chrcur_80mA};  /*Index : When NVDM feature enable ,get charger current index  */
int pre_charger_current[8] = {pmu_fastcc_chrcur_5mA, pmu_fastcc_chrcur_50mA, pmu_fastcc_chrcur_100mA, pmu_fastcc_chrcur_200mA,
                              pmu_fastcc_chrcur_10mA,pmu_fastcc_chrcur_20mA,pmu_fastcc_chrcur_30mA,pmu_fastcc_chrcur_40mA};   /*Index : When NVDM feature enable ,get pre-charger current index  */
int iterm_ith[4] = {pmu_iterm_chrcur_5mA, pmu_iterm_chrcur_10mA, pmu_iterm_chrcur_20mA, pmu_iterm_chrcur_50mA};   /*Index : When NVDM feature enable ,set iterm ith for eoc  */
int iterm_irq[5] = {pmu_iterm_chrcur_10mA, pmu_iterm_chrcur_20mA, pmu_iterm_chrcur_30mA, pmu_iterm_chrcur_40mA, pmu_iterm_chrcur_50mA};   /*Index : When NVDM feature enable ,set iterm irq  */

int battery_basic_checkpoint[BATTERY_BASIC_CHECKPOINT_TBL_NUM] ={3443, 3513, 3579, 3617, 3667, 3748, 3853, 3954, 4062}; /*Index : For linear gauge*/
int battery_precc_voltage[PRECC_VOLTAGE_TBL_NUM] ={2400, 2550, 2700, 2850, 3000, 3150, 3300, 3450};       /*Index : For Precc voltage index*/
int battery_jeita_percentage[BATTERY_JEITA_PERCENTAGE_TBL_NUM] = {20, 0, 0, 0, 40, 60, 80, 100 }; /*Index and Value output: Jeita percentage*/
int battery_icl_value[BATTERY_ICL_VALUE_TBL_NUM] = {10, 90, 200, 300, 400, 500, 600, 700, 800, 900, 1000}; /*Index and Value output: ICL*/
int bm_cc_cur[BM_CC_CUR_TBL_NUM] = {
        0.5,1  ,1.5,2  ,2.5,3  ,3.5,4  ,4.5,5  ,10 ,15 ,20 ,25 ,30 ,35 ,40 ,45 ,
        50 ,55 ,60 ,65 ,70 ,75 ,80 ,90 ,100,110,120,130,140,150,160,170,180,190,
        200,210,220,230,240,250,260,270,280,290,300,310,320,330,340,350,360,370,
        380,390,400,410,420,430,440,450,460,470,480,490,500
}; /*Index and Value output: Charger current*/
int bm_iterm_current[BM_ITERM_CURRENT_TBL_NUM] = {
        0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7 ,7.5,8 ,9 ,10,11,12,13,14,15,16,
        17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,36,38,40,42,44,46,48,50
}; /*Index and Value output: Iterm value*/

battery_basic_data bm_cust;                                                                      /*Data : restore battery basic data*/
battery_managerment_control_info_t bm_ctrl_info;                                                 /*Data : restore battery info*/
static bmt_callback_context_t bmt_callback[BATTERY_MANAGER_CALLBACK_FUNCTION_NUMBER];            /*Data : callback function*/
const battery_managerment_control_info_t *bm_ctrl_info_p;                                        /*Data : used for battery monitor callback function */
TaskHandle_t battery_regular_task_t = NULL;                                                      /*Task : create regular task for eco option 3 and gauge*/
TaskHandle_t battery_lineat_task_t = NULL;
log_create_module(battery_management, PRINT_LEVEL_INFO);                                         /*Syslog create*/
extern hal_nvic_status_t hal_nvic_save_and_set_interrupt_mask_special(uint32_t *mask);           /*API : mask irq api*/
extern hal_nvic_status_t hal_nvic_restore_interrupt_mask_special(uint32_t mask);                 /*API : unmask irq api*/
extern uint8_t executing_status;                                                                 /*flag : JEITA current state*/
#ifdef BATTERY_DECREASE_RESISTANCE
int battery_resistance_offset[BATTERY_BASIC_CHECKPOINT_TBL_NUM] ={950,  850,  787,  775,  769,  825,  875,  863, 850};          /*Index : For linear gauge : resistance value*/
uint32_t remove_ir_soc =0;                                                                       /*Data : For linear gauge smooth soc calculation*/
uint32_t remove_ir_vbat =0;                                                                      /*Data : For linear gauge smooth soc calculation*/
extern int cc_value[67];                                                                        /*Data : For linear gauge smooth soc calculation*/
#else
int battery_resistance_offset[BATTERY_BASIC_CHECKPOINT_TBL_NUM] ={0,  0,  0,  0,  0,  0,  0,  0, 0};          /*Index : For linear gauge : resistance value*/
#endif

//LOG_MSGID_I(module, message, arg_cnt, ##__VA_ARGS__)
#define bm_dbg_print_I(module, message, arg_cnt, ...)     
//LOG_MSGID_W(module, message, arg_cnt, ##__VA_ARGS__)
#define bm_dbg_print_W(module, message, arg_cnt, ...)     
/*==========[Battery management API]=========*/


int32_t battery_management_get_battery_property_internal(battery_property_t property)
{
    int32_t property_value;
    switch (property)
    {
        case BATTERY_PROPERTY_CAPACITY:
            property_value = battery_get_gauge_percent();
            break;
        case BATTERY_PROPERTY_CAPACITY_LEVEL :
            property_value = battery_get_gauge_percent_level();
            break;
        case BATTERY_PROPERTY_CHARGER_EXIST:
            if (battery_align_flag == 1) {
                property_value = bm_ctrl_info.isChargerExist;
            } else {
                property_value = pmu_get_chr_detect_value();
            }
            break;
        case BATTERY_PROPERTY_CHARGER_TYPE:
            property_value = bm_ctrl_info.chargerType;
            break;
        case BATTERY_PROPERTY_TEMPERATURE:
            property_value = battery_auxadc_voltage_to_tempature(pmu_auxadc_get_channel_value(PMU_AUX_CHR_THM));
            break;
        case BATTERY_PROPERTY_VOLTAGE:
            property_value = get_smooth_vbat();
            break;
        case BATTERY_PROPERTY_VOLTAGE_IN_PERCENT:
            property_value = battery_get_gauge_percent();
            break;
        case BATTERY_PROPERTY_PMIC_TEMPERATURE:
            property_value = battery_get_pmic_temp();
            break;
        case BATTERY_PROPERTY_CHARGER_STATE:
            property_value = pmu_get_charger_state();
            break;
        default:
            property_value = BATTERY_INVALID_VALUE;
            break;
    }
    bm_dbg_print_I(battery_management, "property_value : %d %d\r\n", 2,property,property_value);
    return property_value;
}

void battery_switch_charger_option(int option){
    bm_ctrl_info.feature.charger_option = option;
}

void battery_enable_charger(battery_managerment_operate_t oper){
    battery_set_enable_charger(oper);
}

battery_basic_data battery_management_get_basic_data(){
    return bm_cust;
}

/*==========[Battery Management Callback Function]==========*/
void battery_core_pmu_charger_state_change_callback(void) {
    uint32_t newState = pmu_get_charger_state();
    switch (newState)
    {
        case CHARGER_STATE_CHR_OFF:
            LOG_W(MPLOG,"CHR OFF State\r\n");/*Log output by BT*/
            if (bm_ctrl_info.feature.charger_option == 3 && ((bm_ctrl_info.chargerType != SDP_CHARGER) && (bm_ctrl_info.chargerType != CDP_CHARGER))) {
            battery_unlock_sleep();
            bm_dbg_print_I(battery_management, "PMU sleep handle %d\n", 1,sleep_management_check_handle_status(SLEEP_LOCK_BATTERY_MANAGEMENT));
            }
            break;

        case CHARGER_STATE_EOC:
            LOG_W(MPLOG,"EOC State  %d \r\n",bm_ctrl_info.feature.charger_option);/*Log output by BT*/
            if (bm_ctrl_info.feature.charger_option != 1 && (bm_ctrl_info.charger_eoc_state == 0 && EOC_CHECK_ON)) {
                LOG_MSGID_I(battery_management,"First times enter EOC state, start timer",0);
                xTimerStartFromISR(xbm_eoc_timer, 0);
                break;
            }
            if (bm_ctrl_info.feature.charger_option == 1) {
                LOG_MSGID_I(battery_management, "option 1, Charger state will be waiting for recharge or other events.\r\n", 0);
            } else if (bm_ctrl_info.feature.charger_option == 2) {
                pmu_select_eco_option_operating(pmu_eoc_option2, option2_init);
            } else if (bm_ctrl_info.feature.charger_option == 3) {
                pmu_select_eco_option_operating(pmu_eoc_option3, option3_init);
                battery_unlock_sleep();
            } else if (bm_ctrl_info.feature.charger_option == 4) {
                pmu_select_eco_option_operating(pmu_eoc_option4, option4_init);
            } else {
                bm_dbg_print_I(battery_management, "Check Option\r\n", 0);
            }
            LOG_MSGID_I(battery_management, "Battery sleep handle %d\n", 1,sleep_management_check_handle_status(SLEEP_LOCK_BATTERY_MANAGEMENT));
            xTimerStartFromISR(xbm_option_setting_timer, 0);
            bm_ctrl_info.feature.charger_init = 1;
            bm_ctrl_info.gauge_calibration = 5;
            break;

        case CHARGER_STATE_SAFETY_TIMER_TIMEOUT:
            LOG_MSGID_I(battery_management, "Safety Timeout State\r\n", 0);
            break;

        case CHARGER_STATE_FASTCC:
            LOG_W(MPLOG,"FASTCC State\r\n");/*Log output by BT*/
            break;
        case CHARGER_STATE_THR:
          LOG_MSGID_I(battery_management, "THR State\r\n", 0);
            break;
        case CHARGER_STATE_VBAT_OVP:
            LOG_MSGID_I(battery_management, "Vbat OVP State\r\n", 0);
            battery_basic_ovp_debug();
            break;
        case CHARGER_STATE_PRECC:
            LOG_MSGID_I(battery_management, "Precc State\r\n", 0);
            break;
        case CHARGER_STATE_EXTENSION:
            bm_dbg_print_I(battery_management, "Extension State\r\n", 0);
            break;
        default:
            break;
    }
    bm_ctrl_info.chargerState = newState;
    battery_notification(BATTERY_MANAGEMENT_EVENT_CHARGER_STATE_UPDATE,pmu_get_chr_detect_value(),newState);
}

void battery_charger_setting(TimerHandle_t pxTimer) {
    uint32_t mask_pri;
    switch (bm_ctrl_info.charger_step)
    {
        case BM_CHARGER_IN_CHECK_POWER:
            if (!sleep_management_check_handle_status(SLEEP_LOCK_BATTERY_MANAGEMENT)) {
                hal_sleep_manager_lock_sleep(SLEEP_LOCK_BATTERY_MANAGEMENT);
            }
            battery_check_charger_power();
            battery_set_charger_step_timer(BM_CHARGER_IN_CHECK_POWER, BM_CHARGER_IN_JEITA_INIT);
            break;
        case BM_CHARGER_IN_JEITA_INIT:
#ifndef BATTERY_NTC_LESS
            battery_core_hw_jeita_init();
            pmu_set_hw_jeita_enable(PMU_ON);
#else
            pmu_set_hw_jeita_enable(PMU_OFF);
#endif
            battery_set_charger_step_timer(BM_CHARGER_IN_JEITA_INIT, BM_CHARGER_IN_JEITA_WC);
            break;
        case BM_CHARGER_IN_JEITA_WC:
#ifdef DISABLE_WARM_COOL
            pmu_control_enable_interrupt(RG_INT_JEITA_WARM,PMU_OFF);
            pmu_control_enable_interrupt(RG_INT_JEITA_COOL,PMU_OFF);
            pmu_set_register_value(PMU_LCHR_DIG_CON0, PMU_RG_DISWARMCOOL_MASK, PMU_RG_DISWARMCOOL_SHIFT, 1);
#else
            pmu_set_register_value(PMU_LCHR_DIG_CON0, PMU_RG_DISWARMCOOL_MASK, PMU_RG_DISWARMCOOL_SHIFT, 0);
#endif
            battery_jetia_create_check_timer();
            battery_set_charger_step_timer(BM_CHARGER_IN_JEITA_WC, BM_CHARGER_IN_USB);
            break;

        case BM_CHARGER_IN_USB:
#ifdef HAL_USB_MODULE_ENABLED
            hal_usb_phy_preinit();
#endif
            battery_set_charger_step_timer(BM_CHARGER_IN_USB, BM_CHARGER_IN_PLUGIN_INIT);
            break;
        case BM_CHARGER_IN_PLUGIN_INIT:
            pmu_set_icl_curent_level(ICL_ITH_90mA);
            battery_charger_plugin_initial_setting();
            pmu_disable_vsys_discharge(0);
            battery_set_charger_step_timer(BM_CHARGER_IN_PLUGIN_INIT, BM_CHARGER_IN_BC12);
            break;
        case BM_CHARGER_IN_BC12:
#ifdef BATTERY_FEATURE_BC1P2
#ifdef AIR_WIRELESS_MIC_ENABLE
            pmu_set_charger_current_limit(NON_STD_CHARGER);
#else
            bm_ctrl_info.chargerType = pmu_get_bc12_charger_type();
            pmu_set_charger_current_limit(bm_ctrl_info.chargerType);
#endif
#else
            pmu_set_charger_current_limit(NON_STD_CHARGER);
#endif
            battery_set_charger_step_timer(BM_CHARGER_IN_BC12, BM_CHARGER_IN_ENABLE);
            break;
        case BM_CHARGER_IN_ENABLE:
            pmu_charger_init(bm_cust.precc_cur,bm_cust.cv_termination); /*EOC option 3 will enter sleep , CO-domain will be reset*/
            battery_set_charger_step();
            hal_nvic_save_and_set_interrupt_mask_special(&mask_pri);
            battery_set_enable_charger(BATTERY_OPERATE_ON);
            hal_nvic_restore_interrupt_mask_special(mask_pri);
            battery_set_charger_step_timer(BM_CHARGER_IN_ENABLE, BM_CHARGER_IN_GAUGE_CALI);

            break;
        case BM_CHARGER_IN_GAUGE_CALI:
            battery_switch_calibration_state(BATTERY_OPERATE_ON);
            battery_set_charger_step_timer(BM_CHARGER_IN_GAUGE_CALI, BM_CHARGER_NOTIFICATION);
            break;

        case BM_CHARGER_OUT_CHECK_POWER:
            pmu_disable_vsys_discharge(0x2);
            bm_ctrl_info.feature.charger_init = 0;
            battery_set_charger_step_timer(BM_CHARGER_OUT_CHECK_POWER, BM_CHARGER_OUT_JEITA_OFF);
            break;

        case BM_CHARGER_OUT_JEITA_OFF:
#ifndef BATTERY_NTC_LESS
            pmu_set_hw_jeita_enable(PMU_OFF);
            xTimerStopFromISR(xbm_jeita_timer, 0);
#endif
            battery_set_charger_step_timer(BM_CHARGER_OUT_JEITA_OFF, BM_CHARGER_OUT_EOC_EXIT);
            break;

        case BM_CHARGER_OUT_EOC_EXIT:
            battery_set_enable_charger(BATTERY_OPERATE_OFF);
            if (bm_ctrl_info.feature.charger_option == 1) {
            } else if (bm_ctrl_info.feature.charger_option == 2) {
                pmu_select_eco_option_operating(pmu_eoc_option2, option2_exit);
            } else if (bm_ctrl_info.feature.charger_option == 3) {
                pmu_select_eco_option_operating(pmu_eoc_option2, option3_exit);
            } else {
            }
            battery_set_charger_step_timer(BM_CHARGER_OUT_EOC_EXIT, BM_CHARGER_OUT_GAUGE_CALI);
            break;

        case BM_CHARGER_OUT_GAUGE_CALI:
            battery_switch_calibration_state(BATTERY_OPERATE_OFF);
            battery_unlock_sleep();
            battery_reguest_va18(BATTERY_OPERATE_OFF);
            bm_dbg_print_I(battery_management, "PMU sleep handle %d\n", 1,sleep_management_check_handle_status(SLEEP_LOCK_BATTERY_MANAGEMENT));
            pmu_enable_power(PMU_LDO_VA18, PMU_OFF);
            battery_set_charger_step_timer(BM_CHARGER_OUT_GAUGE_CALI, BM_CHARGER_NOTIFICATION);
            break;

        case BM_CHARGER_NOTIFICATION:
#ifdef CHARGER_CALIBRATION
            xTimerStartFromISR(xbm_chrdet_calibration_timer, 0);
#endif
            bm_ctrl_info.charger_step = BM_CHARGER_DONE;
            xTimerStopFromISR(xbm_chr_detec_t, 0);
            if (battery_init_setting_flag == 0) {
                pmu_charger_check_faston(); /*for BAT_OVP when FAST_ON*/
            }
            /*Avoid plug in/out too fast and causing charger Confused. */
            if ((bm_ctrl_info.feature.charger_option >= 3) && (pmu_get_charger_state() == CHARGER_STATE_CHR_OFF)
                    && (sleep_management_check_handle_status(SLEEP_LOCK_BATTERY_MANAGEMENT) >= 1) && (bm_ctrl_info.isChargerExist == BATTERY_OPERATE_ON)) {
                battery_unlock_sleep();
            }
            LOG_MSGID_I(battery_management, "[BM_CHRD]PMU sleep handle %d, [%d]notification update, bat capacity %d, vbat volt %d(mV)\n", 4
                        ,sleep_management_check_handle_status(SLEEP_LOCK_BATTERY_MANAGEMENT)
                        ,bm_ctrl_info.charger_step
                        ,(int)battery_management_get_battery_property(BATTERY_PROPERTY_CAPACITY)
                        ,battery_management_get_battery_property(BATTERY_PROPERTY_VOLTAGE));
            battery_notification(BATTERY_MANAGEMENT_EVENT_CHARGER_EXIST_UPDATE, pmu_get_chr_detect_value(), pmu_get_charger_state());
            battery_core_pmu_charger_state_change_callback();
            battery_align_flag = 0;
            break;
    }
}

void battery_charger_detect_callback(void) {
    uint32_t mask_pri;
    pmu_enable_power(PMU_LDO_VA18, PMU_ON);
    hal_nvic_save_and_set_interrupt_mask_special(&mask_pri);
#ifdef BATTERY_AVOID_SHAKING
    battery_align_flag =1;
#endif
    bm_ctrl_info.isChargerExist = pmu_get_chr_detect_value();
    if (bm_ctrl_info.isChargerExist) {
        executing_status=-1;
        bm_ctrl_info.charger_step = BM_CHARGER_IN_CHECK_POWER;
        if (xTimerStartFromISR(xbm_chr_detec_t, 0) != pdPASS) {
            bm_dbg_print_I(battery_management, "xbm_chr_detec_t xTimerStart fail\n", 0);
        }
        hal_nvic_restore_interrupt_mask_special(mask_pri);
        if (HAL_NVIC_QUERY_EXCEPTION_NUMBER > HAL_NVIC_NOT_EXCEPTION ) {
            xTaskResumeFromISR(battery_regular_task_t);
        }
    } else {
        executing_status=-1;
        battery_reguest_va18(BATTERY_OPERATE_OFF);
        xTimerStopFromISR(xbm_chr_detec_t, 0);
        bm_ctrl_info.charger_step = BM_CHARGER_OUT_CHECK_POWER;
        if (xTimerStartFromISR(xbm_chr_detec_t, 0) != pdPASS) {
            bm_dbg_print_I(battery_management, "xbm_chr_detec_t xTimerStart fail\n", 0);
        }
        hal_nvic_restore_interrupt_mask_special(mask_pri);
    }
}

void battery_monitor(battery_management_event_t event, const void *data)
{
    bm_ctrl_info_p = data;
    if (event == BATTERY_MANAGEMENT_EVENT_CHARGER_EXIST_UPDATE) {
        LOG_MSGID_I(battery_management,"[BM]EVENT:CHARGER EXIST UPDATE:%d] [Charger Exist:%x][Chr_Ste:%d] ",3,event,bm_ctrl_info_p->isChargerExist,bm_ctrl_info_p->chargerState);
    }
    if (event == BATTERY_MANAGEMENT_EVENT_CHARGER_STATE_UPDATE) {
        LOG_MSGID_I(battery_management,"[BM]EVENT:CHARGER STATE UPDATE:%d] [Charger Exist:%x][Chr_Ste:%d] ",3,event,bm_ctrl_info_p->isChargerExist,bm_ctrl_info_p->chargerState);
    }
    if (event == BATTERY_MANAGEMENT_EVENT_CHARGER_ITERM) {
        LOG_MSGID_I(battery_management,"[BM]EVENT:CHARGER ITERM:%d index:%d] ",2,event,bm_cust.cv_termination);
    }
    if (event == BATTERY_MANAGEMENT_EVENT_CHARGER_ITERM_CURRENT) {
        LOG_MSGID_I(battery_management,"[BM]EVENT:CHARGER ITERM CURRENT:%d index:%d] ",2,event,bm_cust.iterm_irq);
    }
}

void battery_core_pmu_rechg_callback(void) {
    bm_dbg_print_I(battery_management, "Recharge Interrupt Callback function\r\n", 0);
    hal_sleep_manager_lock_sleep(SLEEP_LOCK_BATTERY_MANAGEMENT);
    if (bm_ctrl_info.feature.charger_option == 1) {
        LOG_MSGID_I(battery_management, "Option 1 recharger be trigged", 0);
    } else if (bm_ctrl_info.feature.charger_option == 2) {
        pmu_select_eco_option_operating(pmu_eoc_option2, option2_recharger);
    } else if (bm_ctrl_info.feature.charger_option == 3) {
        pmu_charger_init(bm_cust.precc_cur,bm_cust.cv_termination);
        pmu_select_eco_option_operating(pmu_eoc_option3, option3_recharger);
    } else {
        bm_dbg_print_I(battery_management, "recharger in empty option", 0);
    }

}

void  battery_eoc_timer_callback(TimerHandle_t pxTimer) {
    LOG_MSGID_I(battery_management,"First times enter EOC state, stop timer",0);
    bm_ctrl_info.charger_eoc_state = 1;
    battery_core_pmu_charger_state_change_callback();
}

void battery_core_pmu_thm_over110_callback(void) {
    bm_dbg_print_I(battery_management, "THM_OVER 110 Trigger, Set ICL 500mA\r\n", 0);
    pmu_set_icl_curent_level(ICL_ITH_500mA);
}

void battery_one_shot_detect_callback(TimerHandle_t pxTimer) {
    LOG_MSGID_I(battery_management, "battery_one_shot_detect_callback\r\n", 0);
    battery_notification(BATTERY_MANAGEMENT_EVENT_CHARGER_EXIST_UPDATE, pmu_get_chr_detect_value(), pmu_get_charger_state());
    battery_notification(BATTERY_MANAGEMENT_EVENT_BATTERY_UPDATE, pmu_get_chr_detect_value(), pmu_get_charger_state());
}

/*==========[Battery Management init]==========*/
bmt_function_t battery_func = {
    battery_management_init_internal,
    battery_management_get_battery_property_internal,
    battery_management_register_callback_internal,
    NULL
};

void battery_timer_init(void) {
    xTaskCreate(battery_charger_task, "charger_task", 384, NULL, TASK_PRIORITY_NORMAL, &battery_regular_task_t);
#ifdef BATTERY_LINEAR_GAUGE
    xTaskCreate(battery_linear_gauge_task, "Linear_task", 384, NULL, TASK_PRIORITY_NORMAL, &battery_lineat_task_t);
#endif
    xbm_option_setting_timer = xTimerCreate("xbm_option_setting_timer", (100 * TIMEOUT_PERIOD_1MS), pdFALSE, NULL, battery_eoc_option_setting);
    xbm_chr_detec_t = xTimerCreate("charger_regular_timer", 10*TIMEOUT_PERIOD_1MS, pdFALSE, NULL, battery_charger_setting);
#ifndef BATTERY_NTC_LESS
    xbm_jeita_timer = xTimerCreate("jeita_Timer", (HW_JEITA_CHECK_INTERVAL_TIME * TIMEOUT_PERIOD_1S), pdTRUE, NULL, battery_jetia_timer_callback);
#endif
#ifdef CHARGER_CALIBRATION
    xbm_chrdet_calibration_timer = xTimerCreate("charger_detect_Timer", (CALIBRATION_TIME * portTICK_PERIOD_MS), pdFALSE, NULL, battery_detect_calibration_timer_callback);
#endif
    xbm_eoc_timer = xTimerCreate("charger_eoc_timer", (BATTERY_EOC_CHECK_TIME * TIMEOUT_PERIOD_1S), pdFALSE, NULL, battery_eoc_timer_callback);
    xbm_chager_detect_timer = xTimerCreate("charger_detect", (1 * TIMEOUT_PERIOD_1S), pdFALSE, NULL, battery_one_shot_detect_callback);
    xTimerStart(xbm_chager_detect_timer, 0);
}

void battery_parameter_init(void){
    pmu_set_icl_curent_level(ICL_ITH_90mA);
    bm_dbg_print_I(battery_management, "Change ICL Ith to 90mA\r\n", 0);
#ifndef BATTERY_NTC_LESS
    if ( BATTERY_MANAGER_JEITA_ENABLE == FEATURE_ON) {
        bm_dbg_print_I(battery_management, "(Charger on)HW JEITA Init\r\n", 0);
        bm_ctrl_info.feature.feature_jeita = 1;
        battery_core_hw_jeita_init();
    } else {
        bm_ctrl_info.feature.feature_jeita = 0;
    }
#else
    bm_ctrl_info.feature.feature_jeita = 0;
    bm_ctrl_info.jeita_state = HW_JEITA_NORMAL_STAGE;
#endif
    bm_ctrl_info.feature.charger_option  = BATTERY_MANAGER_DEFAULT_CHARGER_OPTION;
    if (BATTERY_MESSAGE_QUEUE_TASK == FEATURE_ON) {
        bm_ctrl_info.feature.message_task = 1;
    } else {
        bm_ctrl_info.feature.message_task = 0;
    }
    battery_set_extend_charger_time(EXTEND_TIME);
    battery_set_calibration_time();
    if (pmu_auxadc_get_channel_value(PMU_AUX_BATSNS) > (bm_cust.full_bat - bm_cust.full_bat_offset)&&pmu_get_charger_state()==0x2) {
        battery_set_enable_charger(BATTERY_OPERATE_OFF);
        bm_ctrl_info.gauge_calibration = ((pmu_auxadc_get_channel_value(PMU_AUX_BATSNS) - (bm_cust.full_bat - bm_cust.full_bat_offset)) / 10) + 1;
        battery_set_enable_charger(BATTERY_OPERATE_ON);
    }else if (pmu_auxadc_get_channel_value(PMU_AUX_BATSNS) > (bm_cust.full_bat - bm_cust.full_bat_offset)){
        bm_ctrl_info.gauge_calibration = ((pmu_auxadc_get_channel_value(PMU_AUX_BATSNS) - (bm_cust.full_bat - bm_cust.full_bat_offset)) / 10);
    }else{
        bm_ctrl_info.gauge_calibration = 0;
    }
    pmu_select_precc_voltage_hp(bm_cust.s0_voltage_index);//set precc voltage
    pmu_set_safety_timer_hp(PMU_PRECC, bm_cust.preecc_timer);
    pmu_set_safety_timer_hp(PMU_FASTCC, bm_cust.fastcc_timer);
    pmu_set_extend_charger_time_hp(bm_cust.extern_timer);
    bm_ctrl_info.charger_step = BM_CHARGER_IN_CHECK_POWER;
    pmu_set_iterm_current_irq(bm_cust.iterm_irq);
}

battery_management_status_t battery_management_init_internal(void) {
    LOG_MSGID_I(battery_management,"Battery Management V3.27.0",0);

    if(pmu_get_power_on_reason()==0x8){
       pmu_select_eco_option_operating(pmu_eoc_option4, option4_exit);
    }

#ifndef MTK_BATTERY_MANAGEMENT_STATIC_INIT_ENABLE
    battery_init_date_form_nvdm();
#else
    battery_init_basic_data();
#endif
    battery_set_charger_step();
    battery_timer_init();
    battery_parameter_init();
    battery_gauge_init();
    battery_message_task_init();
    pmu_charger_init(bm_cust.precc_cur,bm_cust.cv_termination);
    battery_core_hw_jeita_init_threshold();
#ifdef BATTERY_CUSTOMER_SETTING
    battery_manager_customer_setting();
#endif
    battery_management_interrupt_register();
    LOG_MSGID_I(battery_management,"VBat [%d][%d]",2,battery_get_gauge_percent(),pmu_auxadc_get_channel_value(PMU_AUX_BATSNS));
    battery_init_check_charger_exist();
    /*When no charging, battery voltage is lower than initial battery or shutdown battery ,it will enter rtc mode*/
#ifdef BATTERY_CHECK_BATTERY_VOLTAGE
    uint32_t temp_vbat =battery_management_get_battery_property(BATTERY_PROPERTY_VOLTAGE);
    if((pmu_get_usb_input_status()!=true) &&
       (bm_cust.initial_bat  > temp_vbat ||
       bm_cust.shutdown_bat > temp_vbat)){
        LOG_MSGID_I(battery_management, "Battery voltage low [%d]\r\n", 1,battery_management_get_battery_property(BATTERY_PROPERTY_VOLTAGE));
        hal_rtc_enter_rtc_mode();
    }
#endif
    battery_init_setting_flag =1;
    battery_unlock_sleep();
#ifdef BATTERY_DECREASE_RESISTANCE
    remove_ir_vbat = ((bm_cust.full_bat - bm_cust.full_bat_offset)-(cc_value[bm_cust.s2_chr_cur]*bm_cust.resist_offset[8]/1000));
    remove_ir_soc = battery_core_gauge_function(remove_ir_vbat)-BATTERY_REMOVE_IR_SOC_MARGIN;
    LOG_MSGID_I(battery_management, "remove_ir_vbat[%d]remove_ir_soc[%d]\r\n", 2,remove_ir_vbat,remove_ir_soc);
#endif
    bm_dbg_print_I(battery_management, "Battery Management init done",0);
    return BATTERY_MANAGEMENT_STATUS_OK;
}
void battery_message_task_init(void){
    bm_ctrl_info.message.task_handle = NULL;
    bm_ctrl_info.message.event = BMT_EVENT_INIT;
    bm_ctrl_info.message.bmt_queue_handle = xQueueCreate(1,sizeof(bm_ctrl_info.message.event));
}
void battery_iterm_callback(void){
    bm_dbg_print_I(battery_management,"battery iterm callback",0);
    battery_notification(BATTERY_MANAGEMENT_EVENT_CHARGER_ITERM, pmu_get_chr_detect_value(), pmu_get_charger_state());
}
void battery_iterm_current_callback(void){
    bm_dbg_print_I(battery_management,"battery iterm current callback",0);
    battery_notification(BATTERY_MANAGEMENT_EVENT_CHARGER_ITERM_CURRENT, pmu_get_chr_detect_value(), pmu_get_charger_state());
}
void battery_management_interrupt_register(void) {
    pmu_register_callback(RG_INT_CHRDET, battery_charger_detect_callback, NULL);
    pmu_register_callback(RG_INT_ChgStatInt, battery_core_pmu_charger_state_change_callback, NULL);
    pmu_register_callback(RG_INT_VBAT_RECHG, battery_core_pmu_rechg_callback, NULL);
    pmu_register_callback(RG_INT_THM_OVER110, battery_core_pmu_thm_over110_callback, NULL);
    pmu_register_callback(RG_INT_ICHR_ITERM, battery_iterm_callback, NULL);
    pmu_register_callback(RG_INT_ICHR_CHG_CUR, battery_iterm_current_callback, NULL);
    if (battery_management_register_callback(battery_monitor) != BATTERY_MANAGEMENT_STATUS_OK) {
        bm_dbg_print_I(battery_management, "Cannot register battery callback",0);
    }
}

void battery_init_check_charger_exist(void) {
    bm_ctrl_info.isChargerExist = pmu_get_chr_detect_value();
    bm_ctrl_info.chargerState = pmu_get_charger_state();
    if (bm_ctrl_info.isChargerExist) {
        battery_charger_detect_callback();
        battery_core_pmu_charger_state_change_callback();
        battery_clear_charger_irq();
    }else{
        battery_notification(BATTERY_MANAGEMENT_EVENT_CHARGER_EXIST_UPDATE, pmu_get_chr_detect_value(), pmu_get_charger_state());
        battery_notification(BATTERY_MANAGEMENT_EVENT_BATTERY_UPDATE, pmu_get_chr_detect_value(), pmu_get_charger_state());
    }
}



/*==========[Other : Basic internal function]==========*/

battery_management_status_t battery_init_date_form_nvdm(){
    LOG_MSGID_I(battery_management, "[BM_BASIC]Get battery basic value form NVDM ", 0);
    int i = 0;
    nvkey_status_t status = 0;
    uint32_t leng;
    uint8_t buffer_c[152];
    uint8_t buffer_b[128];
    uint8_t buffer_e[18];
    uint8_t buffer_g[18];
    int checkpoint = 14;
    //int temp_inde = 0;
    leng = sizeof(buffer_b);
    status = nvkey_read_data(NVID_CAL_BAT_MGMT_BASIC, (uint8_t*) (buffer_b), &leng);
    if (status != NVKEY_STATUS_OK) {
        bm_dbg_print_I(battery_management, "[BM_BASIC]NVID_CAL_BAT_MGMT_BASIC data error", 0);
        battery_init_basic_data();
        return BATTERY_MANAGEMENT_STATUS_ERROR;
    }
    leng = sizeof(buffer_c);
    status = nvkey_read_data(NVID_CAL_BAT_MGMT_CHR, (uint8_t*) (buffer_c), &leng);
    if (status != NVKEY_STATUS_OK) {
        LOG_MSGID_I(battery_management, "[BM_BASIC]NVID_CAL_BAT_MGMT_CHR data error", 0);
        battery_init_basic_data();
        return BATTERY_MANAGEMENT_STATUS_ERROR;
    }

    leng = sizeof(buffer_e);
    status = nvkey_read_data(NVID_CAL_CHG_CTL_CFG, (uint8_t*) (buffer_e), &leng);
    if (status != NVKEY_STATUS_OK) {
        LOG_MSGID_I(battery_management, "[BM_BASIC]NVID_CAL_CHG_CTL_CFG data error", 0);
        battery_init_basic_data();
        return BATTERY_MANAGEMENT_STATUS_ERROR;
    }

    leng = sizeof(buffer_g);
    status = nvkey_read_data(NVID_CAL_GENERAL_CFG, (uint8_t*) (buffer_g), &leng);
    if (status != NVKEY_STATUS_OK) {
        bm_dbg_print_I(battery_management, "[BM_BASIC]NVID_CAL_GENERAL_CFG data error", 0);
        battery_init_basic_data();
        return BATTERY_MANAGEMENT_STATUS_ERROR;
    }

    bm_dbg_print_I(battery_management, "Get battery basic value form NVDM ", 0);
    bm_cust.initial_bat = (buffer_c[2] << 8) + buffer_c[1];
    bm_cust.shutdown_bat = (buffer_c[10] << 8) + buffer_c[9];
    LOG_MSGID_I(battery_management, "[BM_BASIC]initial_bat[%dmV]shutdown_bat[%dmV]", 2, bm_cust.initial_bat, bm_cust.shutdown_bat);

    bm_cust.full_bat = (buffer_b[25] << 8) + buffer_b[24];
    bm_cust.recharger_voltage = (buffer_b[33] << 8) + buffer_b[32];
    bm_cust.full_bat_offset = (buffer_b[37] << 8) + buffer_b[36];
    //temp_inde = (buffer_c[70] << 8) + buffer_c[69];
    bm_cust.recharger_threshold = battery_get_recharger_index(bm_cust.full_bat_offset);
    LOG_MSGID_I(battery_management, "[BM_BASIC]Full_Vbat[%dmV]recharger_voltage[%dmV]index[%d]full_bat_offset[%dmV]", 4, bm_cust.full_bat, bm_cust.recharger_voltage, bm_cust.recharger_threshold, bm_cust.full_bat_offset);

    bm_cust.precc_cur_value = ((buffer_b[41] << 8) + buffer_b[40]) / 10;
    bm_cust.precc_cur = battery_get_charger_index(bm_cust.precc_cur_value);
    LOG_MSGID_I(battery_management, "[BM_BASIC]Precc_cur[%dmA]index[%d]", 2, bm_cust.precc_cur_value, bm_cust.precc_cur);


    bm_cust.feature_2cc = (buffer_b[79] << 8) + buffer_b[78];
    bm_cust.feature_bc12 = (buffer_e[1] << 8) + buffer_e[0];
    bm_cust.icl = (buffer_e[3] << 8) + buffer_e[2];
    bm_cust.icl_value = battery_icl_value[bm_cust.icl];

    bm_cust.feature_jeita = (buffer_e[5] << 8) + buffer_e[4];
    bm_cust.feature_warm_cool = (buffer_e[7] << 8) + buffer_e[6];
    bm_cust.feature_preecc_timer = (buffer_e[9] << 8) + buffer_e[8];
    bm_cust.preecc_timer = (buffer_e[11] << 8) + buffer_e[10];
    bm_cust.feature_fastcc_timer = (buffer_e[13] << 8) + buffer_e[12];
    bm_cust.fastcc_timer = (buffer_e[15] << 8) + buffer_e[14];
    bm_cust.extern_timer = (buffer_e[17] << 8) + buffer_e[16];

    LOG_MSGID_I(battery_management, "[BM_BASIC]Feature List", 0);
    LOG_MSGID_I(battery_management, "[BM_BASIC]2CC[%d]2CV[%d]Feature Preecc_timer[%d]Feature Fastcc_timer[%d]", 4, bm_cust.feature_2cc, bm_cust.feature_2cv, bm_cust.feature_preecc_timer, bm_cust.feature_fastcc_timer);
    LOG_MSGID_I(battery_management, "[BM_BASIC]fastcc_timer[%d]extern_timer[%d]", 2, bm_cust.fastcc_timer, bm_cust.extern_timer);
    LOG_MSGID_I(battery_management, "[BM_BASIC]BC1.2[%d]Jeita[%d]Warm_Cool[%d]", 3, bm_cust.feature_bc12, bm_cust.feature_jeita, bm_cust.feature_warm_cool);
    LOG_MSGID_I(battery_management, "[BM_BASIC]icl[%d]icl_value[%d]", 2, bm_cust.icl, bm_cust.icl_value);

    bm_cust.cool_cc_value = (buffer_b[53] << 8) + buffer_b[52];
    bm_cust.cool_cc = battery_get_jeita_percentage(bm_cust.cool_cc_value);
    bm_cust.cool_cv = (buffer_b[55] << 8) + buffer_b[54];
    bm_cust.warm_cc_value = (buffer_b[57] << 8) + buffer_b[56];
    bm_cust.warm_cc = battery_get_jeita_percentage(bm_cust.warm_cc_value);
    bm_cust.warm_cv = (buffer_b[59] << 8) + buffer_b[58];
    bm_cust.jeita.cold = (buffer_c[54] << 8) + buffer_c[53];
    bm_cust.jeita.cool = (buffer_c[58] << 8) + buffer_c[57];
    bm_cust.jeita.warm = (buffer_c[62] << 8) + buffer_c[61];
    bm_cust.jeita.hot = (buffer_c[66] << 8) + buffer_c[65];
    LOG_MSGID_I(battery_management, "[BM_BASIC]cool_cc[%d%]cool_index[%d]cool_cv[%dmV]", 3, bm_cust.cool_cc_value, bm_cust.cool_cc, bm_cust.cool_cv);
    LOG_MSGID_I(battery_management, "[BM_BASIC]warm_cc[%d%]warm_index[%d]warm_cv[%dmV]", 3, bm_cust.warm_cc_value, bm_cust.warm_cc, bm_cust.warm_cv);
    LOG_MSGID_I(battery_management, "[BM_BASIC]cold[%d]cool[%d]warm[%d]hot[%d]", 4, bm_cust.jeita.cold, bm_cust.jeita.cool, bm_cust.jeita.warm, bm_cust.jeita.hot);

    bm_cust.s0_voltage = (buffer_b[63] << 8) + buffer_b[62];
    bm_cust.s0_voltage_index = battery_get_precc_index(bm_cust.s0_voltage);
    bm_cust.s0_chr_cur_value = ((buffer_b[65] << 8) + buffer_b[64]) / 10;
    bm_cust.s0_chr_cur = battery_get_charger_index(bm_cust.s0_chr_cur_value);
    LOG_MSGID_I(battery_management, "[BM_BASIC]s0_voltage[%dmV]index[%d]s0_cur[%dmA]index[%d]", 4, bm_cust.s0_voltage, bm_cust.s0_voltage_index, bm_cust.s0_chr_cur_value, bm_cust.s0_chr_cur);

    if (bm_cust.feature_2cc == BATTERY_OPERATE_ON) {
        LOG_MSGID_I(battery_management, "[BM_BASIC]2CC feature on", 0);
        bm_cust.s1_voltage = (buffer_b[45] << 8) + buffer_b[44];
        bm_cust.s1_chr_cur_value = ((buffer_b[47] << 8) + buffer_b[46]) / 10;
        bm_cust.s1_chr_cur = battery_get_charger_index(bm_cust.s1_chr_cur_value);
        LOG_MSGID_I(battery_management, "[BM_BASIC]s1_voltage[%dmV]s1_cur[%dmA]index[%d]", 3, bm_cust.s1_voltage, bm_cust.s1_chr_cur_value, bm_cust.s1_chr_cur);

        bm_cust.s2_voltage = (buffer_b[49] << 8) + buffer_b[48];
        bm_cust.s2_chr_cur_value = ((buffer_b[51] << 8) + buffer_b[50]) / 10;
        bm_cust.s2_chr_cur = battery_get_charger_index(bm_cust.s2_chr_cur_value);
        LOG_MSGID_I(battery_management, "[BM_BASIC]s2_voltage[%dmV]s2_cur[%dmA]index[%d]", 3, bm_cust.s2_voltage, bm_cust.s2_chr_cur_value, bm_cust.s2_chr_cur);
    } else {
        LOG_MSGID_I(battery_management, "[BM_BASIC]2CC feature off", 0);
    }
    bm_cust.cv_termination_value = ((buffer_b[43] << 8) + buffer_b[42]) / 10;
    bm_cust.cv_termination = battery_get_iterm_index(bm_cust.cv_termination_value);
    LOG_MSGID_I(battery_management, "[BM_BASIC]iterm[%dmA]index[%d]", 2, bm_cust.cv_termination_value, bm_cust.cv_termination);
    bm_cust.iterm_irq_value = ((buffer_b[61] << 8) + buffer_b[60]) / 10;
    bm_cust.iterm_irq = battery_get_iterm_index(bm_cust.iterm_irq_value);
    pmu_select_cv_voltage_hp(battery_get_full_battery_index(bm_cust.full_bat)); //set VCV_VTH
    pmu_set_iterm_current_irq(bm_cust.iterm_irq);
    LOG_MSGID_I(battery_management, "[BM_BASIC]iterm irq[%dmA]index[%d]", 2, bm_cust.iterm_irq_value, bm_cust.iterm_irq);

    for (i = 0; i < BATTERY_BASIC_CHECKPOINT_TBL_NUM; i++) {
        bm_cust.check_point[i] = (buffer_c[checkpoint] << 8) + buffer_c[checkpoint - 1];
        LOG_MSGID_I(battery_management, "[BM_BASIC]Check Point[%d][%dmV]  ", 2, i, bm_cust.check_point[i]);
        checkpoint += 4;
    }
    LOG_MSGID_I(battery_management," iterm_irq [%d] iterm ith [%d] "
                                    "precc_cur [%d]" "s0_v[%d]s0_c[%d]s1_v[%d]s1_c[%d]s2_c[%d]s2_c[%d]"
                                    "cool_cc[%d]cool_cv[%d]warm_cc[%d]warm_cv[%d]",13
                                    ,bm_cust.iterm_irq,bm_cust.cv_termination, bm_cust.precc_cur
                                    ,bm_cust.s0_voltage_index,bm_cust.s0_chr_cur,bm_cust.s1_voltage,bm_cust.s1_chr_cur,bm_cust.s2_voltage,bm_cust.s2_chr_cur
                                    ,bm_cust.cool_cc,bm_cust.cool_cv,bm_cust.warm_cc,bm_cust.warm_cv);
    LOG_MSGID_I(battery_management,"initial_bat[%d]shutdown_bat[%d]full_bat[%d]full_bat_offset[%d]recharger_voltage[%d]"
                                    "cold[%d]cool[%d]warm[%d]hot[%d]recharger_threshold[%d]",10
                                    ,bm_cust.initial_bat,bm_cust.shutdown_bat,bm_cust.full_bat,bm_cust.full_bat_offset,bm_cust.recharger_voltage
                                    ,bm_cust.jeita.cold,bm_cust.jeita.cool,bm_cust.jeita.warm,bm_cust.jeita.hot,bm_cust.recharger_threshold);
    return BATTERY_MANAGEMENT_STATUS_OK;
}

battery_management_status_t battery_init_basic_data() {
    int i = 0;
    bm_dbg_print_I(battery_management, "Get battery default value from customer file",0);
    bm_cust.initial_bat = INITIAL_BAT;
    bm_cust.shutdown_bat = SW_SHUT_DOWN;
    bm_cust.full_bat = FULL_BATTERY;
    bm_cust.full_bat_offset = BATTERY_CAPACITY_OFFSET;
    bm_cust.recharger_voltage = EOC_RECHARGER_VOLTAGE;
    bm_cust.precc_cur = BATTERY_PRECC_CURRENT;
    bm_cust.cv_termination = BATTERY_ITERM_ITH;
    bm_cust.s0_voltage_index = BATTERY_S0_VOLTAGE;
    bm_cust.s0_chr_cur = BATTERY_S0_CHR_CUR;
    bm_cust.s1_voltage = BATTERY_S1_VOLTAGE;
    bm_cust.s1_chr_cur = BATTERY_S1_CHR_CUR;
    bm_cust.s2_voltage = BATTERY_S2_VOLTAGE;
    bm_cust.s2_chr_cur = BATTERY_S2_CHR_CUR;
    for (i = 0; i < BATTERY_BASIC_CHECKPOINT_TBL_NUM; i++) {
        bm_cust.check_point[i] = battery_basic_checkpoint[i];
        bm_cust.resist_offset[i] = battery_resistance_offset[i];
        LOG_MSGID_I(battery_management,"Check Point[%d][%d][%d] \r\n",3,i,bm_cust.check_point[i],bm_cust.resist_offset[i]);
    }
    bm_cust.jeita.cold = HW_JEITA_COLD_THRESHOLD;
    bm_cust.jeita.cool = HW_JEITA_COOL_THRESHOLD;
    bm_cust.jeita.warm = HW_JEITA_WARM_THRESHOLD;
    bm_cust.jeita.hot  = HW_JEITA_HOT_THRESHOLD;
    bm_cust.cool_cc = BATTERY_COOL_CC;
    bm_cust.cool_cv = BATTERY_COOL_CV;
    bm_cust.warm_cc = BATTERY_WARM_CC;
    bm_cust.warm_cv = BATTERY_WARM_CV;
    bm_cust.iterm_irq = BATTERY_ITERM_CURRENT_IRQ;
    pmu_select_cv_voltage(battery_get_full_battery_index(FULL_BATTERY)); //set VCV_VTH
    bm_cust.recharger_threshold = RECHARGER_VOLTAGE;
    LOG_MSGID_I(battery_management," iterm_irq [%d] iterm ith [%d] "
                                    "precc_cur [%d]" "s0_v[%d]s0_c[%d]s1_v[%d]s1_c[%d]s2_c[%d]s2_c[%d]"
                                    "cool_cc[%d]cool_cv[%d]warm_cc[%d]warm_cv[%d]",13
                                    ,bm_cust.iterm_irq,bm_cust.cv_termination, bm_cust.precc_cur
                                    ,bm_cust.s0_voltage_index,bm_cust.s0_chr_cur,bm_cust.s1_voltage,bm_cust.s1_chr_cur,bm_cust.s2_voltage,bm_cust.s2_chr_cur
                                    ,bm_cust.cool_cc,bm_cust.cool_cv,bm_cust.warm_cc,bm_cust.warm_cv);
    LOG_MSGID_I(battery_management,"initial_bat[%d]shutdown_bat[%d]full_bat[%d]full_bat_offset[%d]recharger_voltage[%d]"
                                    "cold[%d]cool[%d]warm[%d]hot[%d]recharger_threshold[%d]",10
                                    ,bm_cust.initial_bat,bm_cust.shutdown_bat,bm_cust.full_bat,bm_cust.full_bat_offset,bm_cust.recharger_voltage
                                    ,bm_cust.jeita.cold,bm_cust.jeita.cool,bm_cust.jeita.warm,bm_cust.jeita.hot,bm_cust.recharger_threshold);
    return BATTERY_MANAGEMENT_STATUS_OK;
}

void battery_notification(battery_management_event_t event,uint32_t chr_exist,uint32_t state) {
    int i = 0;
    LOG_MSGID_I(battery_management, "[BM_Notification : %d][Chr_exist:%d][Chr_state:%d][PMU_AUX_VBUS:%d]\r\n",4,event,(int)chr_exist,(int)state,pmu_auxadc_get_channel_value(PMU_AUX_VBUS));/*Log output by BT*/
    for (i = 0; i < battery_callback_index; i++) {
         if ((bmt_callback[i].callback_init == true) && (bmt_callback[i].func != NULL)) {
             bmt_callback[i].func(event, &bm_ctrl_info);
         }
    }
}

uint8_t battery_get_full_battery_index(uint16_t vabt) {
    int i = 0, index = 3; //Battery default value
    int battery_full_bat_voltage[BATTERY_FULLBAT_INDEX_MAX] = { 4050, 4100, 4150, 4200, 4250, 4300, 4350, 4400, 4450, 4500, 4550, 4600 };
    for (i = 0; i < BATTERY_FULLBAT_INDEX_MAX; i++) {
        if (vabt == battery_full_bat_voltage[i]) {
            index = i;
        }
    }
    return index;
}

uint8_t battery_get_recharger_index(uint16_t vol) {
    int i = 0, index = 1; //recharger default value
    int battery_recharger_threshold[BATTERY_RECHARGER_INDEX_MAX] = { 50, 100, 150, 200 };
    for (i = 0; i < BATTERY_RECHARGER_INDEX_MAX; i++) {
        if (vol == battery_recharger_threshold[i]) {
            index = i;
        }
    }
    return index;
}

void battery_charger_plugin_initial_setting(void) {
    pmu_enable_recharger(BATTERY_OPERATE_ON);
    pmu_set_rechg_voltage(bm_cust.recharger_threshold);//Setting recharger voltage
}

battery_management_status_t battery_management_register_callback_internal(battery_management_callback_t callback)
{
    bmt_callback[battery_callback_index].func = callback;
    bmt_callback[battery_callback_index].callback_init = true;
    battery_callback_index++;
    return BATTERY_MANAGEMENT_STATUS_OK;
}

void battery_eoc_option_setting(TimerHandle_t pxTimer) {
    if(bm_ctrl_info.feature.charger_option!=1){
        pmu_select_eco_option_operating(bm_ctrl_info.feature.charger_option,option_setting);
    }
}

void battery_unlock_sleep(void) {
    uint8_t bm_lock=0;
    do {
        bm_lock = sleep_management_check_handle_status(SLEEP_LOCK_BATTERY_MANAGEMENT);
        if (sleep_management_check_handle_status(SLEEP_LOCK_BATTERY_MANAGEMENT) >= 1) {
            hal_sleep_manager_unlock_sleep(SLEEP_LOCK_BATTERY_MANAGEMENT);
        }
    } while (bm_lock >= 1);
    LOG_MSGID_I(battery_management, "battery unlock sleep: %d\n", 1,sleep_management_check_handle_status(SLEEP_LOCK_BATTERY_MANAGEMENT));
}

void battery_set_charger_step(void) {
    uint32_t temp_batsns = 0;
    temp_batsns = pmu_auxadc_get_channel_value(PMU_AUX_BATSNS);
    if (bm_cust.feature_2cc == BATTERY_OPERATE_ON) {
        if (temp_batsns > bm_cust.s2_voltage) {
            LOG_MSGID_I(battery_management,"Battery voltage detect step charger S2 %d",1,bm_cust.s2_voltage);
            pmu_set_charger_current(bm_cust.s2_chr_cur);
        }
        if ((temp_batsns >= bm_cust.s1_voltage) && (temp_batsns <= bm_cust.s2_voltage)) {
            LOG_MSGID_I(battery_management,"Battery voltage detect charger S1 %d",1,bm_cust.s1_voltage);
            pmu_set_charger_current(bm_cust.s1_chr_cur);
        }
        if ((temp_batsns >= battery_precc_voltage[bm_cust.s0_voltage_index]) && (temp_batsns <= bm_cust.s1_voltage)) {
            LOG_MSGID_I(battery_management,"Battery voltage detect charger S0 %d",1,battery_precc_voltage[bm_cust.s0_voltage_index]);
            pmu_set_charger_current(bm_cust.s0_chr_cur);
        }
        if(temp_batsns <= battery_precc_voltage[bm_cust.s0_voltage_index]){
            pmu_set_charger_current(bm_cust.s0_chr_cur);
        }
        pmu_select_precc_voltage(bm_cust.s0_voltage_index); /*Note : batsns <S0 means  PRECC*/
    }else{
        pmu_set_charger_current(bm_cust.s0_chr_cur);
    }

}

void battery_set_charger_step_timer(uint8_t cur,uint8_t next){
    bm_ctrl_info.charger_step =next;
    LOG_MSGID_I(battery_management, "BM_CHARGER_STEP[%d]->[%d]",2,cur,bm_ctrl_info.charger_step);
    xTimerStopFromISR(xbm_chr_detec_t, 0);
    if (xTimerStartFromISR(xbm_chr_detec_t, 0) != pdPASS) {
        LOG_MSGID_I(battery_management, "xbm_chr_detec_t xTimerStart fail\n", 0);
    }
}

void battery_charger_task(void * pvParameters) {
    const TickType_t xDelay = (CHARGER_REGULAR_TIME * TIMEOUT_PERIOD_1S) / portTICK_PERIOD_MS;
    while (1) {
        vTaskDelay( xDelay );
        bm_dbg_print_I(battery_management, "BM regular timer check\r\n", 0);
        if (bm_ctrl_info.feature.message_task == FEATURE_ON) {
            battery_notification(BATTERY_MANAGEMENT_EVENT_BATTERY_UPDATE, pmu_get_chr_detect_value(), pmu_get_charger_state());
            bm_ctrl_info.message.event = BMT_EVENT_10_TIMEOUT;
            xQueueSendFromISR(bm_ctrl_info.message.bmt_queue_handle, &bm_ctrl_info.message.event, 0/portTICK_PERIOD_MS);
        }
        if (bm_ctrl_info.isChargerExist == true) {
            //EOC in option3,check battery behavior and recharger
            if (bm_ctrl_info.feature.charger_option == 3 && pmu_get_charger_state() == CHARGER_STATE_CHR_OFF) {
                pmu_select_eco_option_operating(pmu_eoc_option3, option3_checking);
            }
        }
        if (pmu_auxadc_get_channel_value(PMU_AUX_BATSNS) > (bm_cust.full_bat - bm_cust.full_bat_offset)) {
            battery_calibration_gauge_tolerance();
        }
        battery_set_charger_step();
        LOG_W(MPLOG,"[BM_TASK]Bat temp=%d(Celsius), capacity=%d(%%), chg status=%d, bat volt=%d(mV), bat state=%s, vbus=%d(mV)\n"
                    ,(int)battery_management_get_battery_property(BATTERY_PROPERTY_TEMPERATURE)
                    ,(int)battery_management_get_battery_property(BATTERY_PROPERTY_CAPACITY)
                    ,(int)battery_management_get_battery_property(BATTERY_PROPERTY_CHARGER_EXIST)
                    ,(int) battery_management_get_battery_property(BATTERY_PROPERTY_VOLTAGE)
                    , bm_charger_state[battery_management_get_battery_property(BATTERY_PROPERTY_CHARGER_STATE)]
                    ,pmu_auxadc_get_channel_value(PMU_AUX_VBUS));/*Log output by BT*/
    }
}

/*==========[Other : Additional features]==========*/
void battery_basic_ovp_debug(void){
    uint32_t rg_730=0;
    uint32_t rg_748=0;
    uint32_t rg_74a=0;
    uint32_t rg_74c=0;
    rg_730 = pmu_get_register_value(0x730,0xffff,0);
    rg_748 = pmu_get_register_value(0x748,0xffff,0);
    rg_74a = pmu_get_register_value(0x74a,0xffff,0);
    rg_74c = pmu_get_register_value(0x74c,0xffff,0);
    LOG_MSGID_I(battery_management, "[0x730:%x][0x748:%x][0x74a:%x][0x74c:%x]", 4,rg_730,rg_748,rg_74a,rg_74c);
    if(rg_74a&0x1){
        LOG_MSGID_I(battery_management, "OVP : VBUSDPM", 0);
    }else if(rg_74a&0x2){
        LOG_MSGID_I(battery_management, "OVP : VSYSDPM", 0);
    }else if(rg_74a&0x800){
        LOG_MSGID_I(battery_management, "OVP : BATTERY OVER VOLTAGE ", 0);
    }else{
        LOG_MSGID_I(battery_management, "OVP : CHECK FASTON ", 0);
    }
}
#ifdef CHARGER_CALIBRATION
/*This API is for fixing human actions or environment exceptions in the charger plug-in/plug-out*/
void battery_detect_calibration_timer_callback(TimerHandle_t pxTimer){
    uint32_t mask_pri;
    hal_nvic_save_and_set_interrupt_mask_special(&mask_pri);
    if ((bm_ctrl_info.isChargerExist != pmu_get_chr_detect_value())) {
        LOG_MSGID_I(battery_management, "ERROR!!!!, Plug-in/out interval need 500ms\r\n", 0);
        battery_charger_detect_callback();
        pmu_clear_interrupt(PMU_INT_MAX);
    }
    hal_nvic_restore_interrupt_mask_special(mask_pri);

}
#endif
uint32_t battery_management_set_register_value(unsigned short int address, unsigned short int mask, unsigned short int shift, unsigned short int value){
    pmu_set_register_value(address, mask, shift, value);
    return pmu_get_register_value(address, mask,shift);
}
uint32_t battery_management_get_register_value(unsigned short int address, unsigned short int mask, unsigned short int shift){
    return pmu_get_register_value(address, mask,shift);
}
uint8_t battery_get_charger_index(int value)
{
    int index = 0;
    int i = 0;
    for (i = 0; i < BM_CC_CUR_TBL_NUM; i++) {
        if (value == bm_cc_cur[i]) {
            index = i;
            return index;
        }
    }
    return -1;
}
uint8_t battery_get_iterm_index(int value)
{
    int index = 0;
    int i = 0;
    for (i = 0; i < BM_ITERM_CURRENT_TBL_NUM; i++) {
        if (value == bm_iterm_current[i]) {
            index = i;
            return index;
        }
    }
    return -1;
}
uint8_t battery_get_jeita_percentage(uint8_t value)
{
    int index = 0;
    int i = 0;
    for (i = 0; i < BATTERY_JEITA_PERCENTAGE_TBL_NUM; i++) {
        if (value == battery_jeita_percentage[i]) {
            index = i;
            return index;
        }
    }
    return -1;
}
uint8_t battery_get_icl_value(uint8_t value)
{
    int index = 0;
    int i = 0;
    for (i = 0; i < BATTERY_ICL_VALUE_TBL_NUM; i++) {
        if (value == battery_icl_value[i]) {
            index = i;
        }
    }
    return index;
}
uint8_t battery_get_precc_index(uint32_t value)
{
    int index = 0;
    int i = 0;
    for (i = 0; i < PRECC_VOLTAGE_TBL_NUM; i++) {
        if (value == battery_precc_voltage[i]) {
            index = i;
        }
    }
    return index;
}
#ifdef BATTERY_CUSTOMER_SETTING
battery_customer_setting_t bm_customer_setting[] = {
        { 0, 0 },
        { 0, 0 }
};
void battery_manager_customer_setting() {
    int custom_setting, i;
    custom_setting = sizeof(bm_customer_setting) / sizeof(bm_customer_setting[0]);
    for (i = 0; i < custom_setting; i++) {
        pmu_set_register_value_2byte_mt6388(bm_customer_setting[i].addr, 0xFFFF, 0, bm_customer_setting[i].value);
    }
}
#endif
