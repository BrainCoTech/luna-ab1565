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

#include "hal_gpio.h"

#ifdef HAL_GPIO_MODULE_ENABLED
#include "hal_gpio_internal.h"
#include "hal_log.h"


const hal_gpio_cfg_reg_t gpio_cfg_table[] = {
    //   DRV_REG shift   IES_REG   shift PD_REG      PU_REG    shift PUPD_REG    R0_REG      R1_REG     shift    RDSEL_RG  shift SMT_REG     SR_REG    shift
    {   0X00, 0 , 0X40, 0 , 0X70, 0XA0, 0 ,   0XFF, 0XFF, 0XFF, 0XFF,   0XE0, 0 , 0X120, 0X140, 0 , },  // HAL_GPIO_0
    {   0X00, 2 , 0X40, 1 , 0X70, 0XA0, 1 ,   0XFF, 0XFF, 0XFF, 0XFF,   0XE0, 2 , 0X120, 0X140, 1 , },  // HAL_GPIO_1
    {   0X00, 4 , 0X40, 2 , 0X70, 0XA0, 2 ,   0XFF, 0XFF, 0XFF, 0XFF,   0XE0, 4 , 0X120, 0X140, 2 , },  // HAL_GPIO_2
    {   0X00, 6 , 0X40, 3 , 0X70, 0XA0, 3 ,   0XFF, 0XFF, 0XFF, 0XFF,   0XE0, 6 , 0X120, 0X140, 3 , },  // HAL_GPIO_3
    {   0X00, 8 , 0X40, 4 , 0X70, 0XA0, 4 ,   0XFF, 0XFF, 0XFF, 0XFF,   0XE0, 8 , 0X120, 0X140, 4 , },  // HAL_GPIO_4
    {   0X00, 10, 0X40, 5 , 0X70, 0XA0, 5 ,   0XFF, 0XFF, 0XFF, 0XFF,   0XE0, 10, 0X120, 0X140, 5 , },  // HAL_GPIO_5
    {   0X00, 12, 0X40, 6 , 0X70, 0XA0, 6 ,   0XFF, 0XFF, 0XFF, 0XFF,   0XE0, 12, 0X120, 0X140, 6 , },  // HAL_GPIO_6
    {   0X00, 14, 0X40, 7 , 0X70, 0XA0, 7 ,   0XFF, 0XFF, 0XFF, 0XFF,   0XE0, 14, 0X120, 0X140, 7 , },  // HAL_GPIO_7
    {   0X00, 16, 0X40, 8 , 0X70, 0XA0, 8 ,   0XFF, 0XFF, 0XFF, 0XFF,   0XE0, 16, 0X120, 0X140, 8 , },  // HAL_GPIO_8
    {   0X00, 18, 0X40, 9 , 0X70, 0XA0, 9 ,   0XFF, 0XFF, 0XFF, 0XFF,   0XE0, 18, 0X120, 0X140, 9 , },  // HAL_GPIO_9
    {   0X00, 20, 0X40, 10, 0X70, 0XA0, 10,   0XFF, 0XFF, 0XFF, 0XFF,   0XE0, 20, 0X120, 0X140, 10, },  // HAL_GPIO_10
    {   0X00, 22, 0X40, 11, 0X70, 0XA0, 11,   0XFF, 0XFF, 0XFF, 0XFF,   0XE0, 22, 0X120, 0X140, 11, },  // HAL_GPIO_11
    {   0X00, 24, 0X40, 12, 0X70, 0XA0, 12,   0XFF, 0XFF, 0XFF, 0XFF,   0XE0, 24, 0X120, 0X140, 12, },  // HAL_GPIO_12
    {   0X00, 26, 0X40, 13, 0XFF, 0XFF, 0XFF, 0X90, 0XC0, 0XD0,   0 ,   0XE0, 26, 0X120, 0X140, 13, },  // HAL_GPIO_13
    {   0X00, 28, 0X40, 14, 0XFF, 0XFF, 0XFF, 0X90, 0XC0, 0XD0,   1 ,   0XE0, 28, 0X120, 0X140, 14, },  // HAL_GPIO_14
    {   0X00, 30, 0X40, 15, 0XFF, 0XFF, 0XFF, 0X90, 0XC0, 0XD0,   2 ,   0XE0, 30, 0X120, 0X140, 15, },  // HAL_GPIO_15
    {   0X10, 0 , 0X40, 16, 0XFF, 0XFF, 0XFF, 0X90, 0XC0, 0XD0,   3 ,   0XF0, 0 , 0X120, 0X140, 16, },  // HAL_GPIO_16
    {   0X10, 2 , 0X40, 17, 0XFF, 0XFF, 0XFF, 0X90, 0XC0, 0XD0,   4 ,   0XF0, 2 , 0X120, 0X140, 17, },  // HAL_GPIO_17
    {   0X10, 4 , 0X40, 18, 0XFF, 0XFF, 0XFF, 0X90, 0XC0, 0XD0,   5 ,   0XF0, 4 , 0X120, 0X140, 18, },  // HAL_GPIO_18
    {   0X10, 6 , 0X40, 19, 0XFF, 0XFF, 0XFF, 0X90, 0XC0, 0XD0,   6 ,   0XF0, 6 , 0X120, 0X140, 19, },  // HAL_GPIO_19
    {   0X10, 8 , 0X40, 20, 0X70, 0XA0, 13,   0XFF, 0XFF, 0XFF, 0XFF,   0XF0, 8 , 0X120, 0X140, 20, },  // HAL_GPIO_20
    {   0X10, 10, 0X40, 21, 0X70, 0XA0, 14,   0XFF, 0XFF, 0XFF, 0XFF,   0XF0, 10, 0X120, 0X140, 21, },  // HAL_GPIO_21
    {   0X10, 12, 0X40, 22, 0X70, 0XA0, 15,   0XFF, 0XFF, 0XFF, 0XFF,   0XF0, 12, 0X120, 0X140, 22, },  // HAL_GPIO_22
    {   0X10, 14, 0X40, 23, 0X70, 0XA0, 16,   0XFF, 0XFF, 0XFF, 0XFF,   0XF0, 14, 0X120, 0X140, 23, },  // HAL_GPIO_23
    {   0X10, 16, 0X40, 24, 0X70, 0XA0, 17,   0XFF, 0XFF, 0XFF, 0XFF,   0XF0, 16, 0X120, 0X140, 24, },  // HAL_GPIO_24
    {   0X10, 18, 0X40, 25, 0X70, 0XA0, 18,   0XFF, 0XFF, 0XFF, 0XFF,   0XF0, 18, 0X120, 0X140, 25, },  // HAL_GPIO_25
    {   0X10, 20, 0X40, 26, 0X70, 0XA0, 19,   0XFF, 0XFF, 0XFF, 0XFF,   0XF0, 20, 0X120, 0X140, 26, },  // HAL_GPIO_26
    {   0X10, 22, 0X40, 27, 0X70, 0XA0, 20,   0XFF, 0XFF, 0XFF, 0XFF,   0XF0, 22, 0X120, 0X140, 27, },  // HAL_GPIO_27
    {   0X10, 24, 0X40, 28, 0X70, 0XA0, 21,   0XFF, 0XFF, 0XFF, 0XFF,   0XF0, 24, 0X120, 0X140, 28, },  // HAL_GPIO_28
    {   0X10, 26, 0X40, 29, 0X70, 0XA0, 22,   0XFF, 0XFF, 0XFF, 0XFF,   0XF0, 26, 0X120, 0X140, 29, },  // HAL_GPIO_29
    {   0X10, 28, 0X40, 30, 0X70, 0XA0, 23,   0XFF, 0XFF, 0XFF, 0XFF,   0XF0, 28, 0X120, 0X140, 30, },  // HAL_GPIO_30
    {   0X10, 30, 0X40, 31, 0X70, 0XA0, 24,   0XFF, 0XFF, 0XFF, 0XFF,   0XF0, 30, 0X120, 0X140, 31, },  // HAL_GPIO_31
    {   0X20, 0 , 0X60, 0 , 0X70, 0XA0, 25,   0XFF, 0XFF, 0XFF, 0XFF,   0X100, 0 , 0X130, 0X150, 0 , },  // HAL_GPIO_32
    {   0X20, 2 , 0X60, 1 , 0X70, 0XA0, 26,   0XFF, 0XFF, 0XFF, 0XFF,   0X100, 2 , 0X130, 0X150, 1 , },  // HAL_GPIO_33
    {   0X20, 4 , 0X60, 2 , 0X70, 0XA0, 27,   0XFF, 0XFF, 0XFF, 0XFF,   0X100, 4 , 0X130, 0X150, 2 , },  // HAL_GPIO_34
    {   0X20, 6 , 0X60, 3 , 0X70, 0XA0, 28,   0XFF, 0XFF, 0XFF, 0XFF,   0X100, 6 , 0X130, 0X150, 3 , },  // HAL_GPIO_35
    {   0X20, 8 , 0X60, 4 , 0X70, 0XA0, 29,   0XFF, 0XFF, 0XFF, 0XFF,   0X100, 8 , 0X130, 0X150, 4 , },  // HAL_GPIO_36
    {   0X20, 10, 0X60, 5 , 0XFF, 0XFF, 0XFF, 0X90, 0XC0, 0XD0, 7,      0X100, 10, 0X130, 0X150, 5 , },  // HAL_GPIO_37
    {   0X20, 12, 0X60, 6 , 0XFF, 0XFF, 0XFF, 0X90, 0XC0, 0XD0, 8,      0X100, 12, 0X130, 0X150, 6 , },  // HAL_GPIO_38
    {   0X20, 14, 0X60, 7 , 0X70, 0XA0, 30,   0XFF, 0XFF, 0XFF, 0XFF,   0X100, 14, 0X130, 0X150, 7 , },  // HAL_GPIO_39
};

void gpio_get_state(hal_gpio_pin_t gpio_pin, gpio_state_t *gpio_state)
{

    uint32_t mode;
    uint32_t dir;
    uint32_t din;
    uint32_t dout;
    uint32_t pu;
    uint32_t pd;
    uint32_t pupd;
    uint32_t r0;
    uint32_t r1;

    gpio_pull_type_t pull_type;
    uint32_t temp;
    uint32_t shift;
    uint32_t reg_index;
    uint32_t bit_index;
    hal_gpio_driving_current_t driving_value;

    //const char *direct[2] = {"input", "output"};
    //const char *pull_state[10] = {"disable_pull", "PU_R", "PD_R", "PU_R0","PD_R0", "PU_R0_R1", "PD_R0_R1", "PUPD_Error","PU_R1","PD_R1"};


    reg_index = gpio_pin / 8;
    bit_index = (gpio_pin % 8) * 4;
    mode = (gpio_base->GPIO_MODE.RW[reg_index] >> (bit_index) & 0xf);

    reg_index = gpio_pin / 32;
    bit_index = gpio_pin % 32;
    dir  = (gpio_base->GPIO_DIR.RW[reg_index] >> (bit_index) & 0x1);
    din  = (gpio_base->GPIO_DIN.R[reg_index] >> (bit_index) & 0x1);
    dout = (gpio_base->GPIO_DOUT.RW[reg_index] >> (bit_index) & 0x1);

    pu = 0xf;
    pd = 0xf;
    pupd = 0xf;
    r0   = 0xf;
    r1   = 0xf;

    shift = 0xff;
    pull_type = GPIO_PUPD_ERR;

    if (gpio_cfg_table[gpio_pin].pupd_shift != 0xff) {
        shift = gpio_cfg_table[gpio_pin].pupd_shift;
        pu = (GPIO_REG32(IO_CFG_0_BASE + (gpio_cfg_table[gpio_pin].pu_reg & 0XFF)) >> shift) & 0x01;
        pd = (GPIO_REG32(IO_CFG_0_BASE + (gpio_cfg_table[gpio_pin].pd_reg & 0XFF)) >> shift) & 0x01;

        temp = (pu << 4) + pd;

        //log_hal_msgid_info("pu=%d pd=%d, temp=%.3x\r\n", 3, pu,pd,temp);

        if (temp == 0x00) {
            pull_type = GPIO_NO_PULL;
        } else if (temp == 0x10) {
            pull_type = GPIO_PU_R;
        } else if (temp == 0x01) {
            pull_type = GPIO_PD_R;
        } else if (temp == 0xff) {
            pull_type = GPIO_PUPD_ERR;
            log_hal_msgid_info("error pu = %x, pd= %x\r\n", 2, pu, pd);
        }
    } else if (gpio_cfg_table[gpio_pin].pupd_r0_r1_shift != 0xff) {
        shift = gpio_cfg_table[gpio_pin].pupd_r0_r1_shift;
        pupd = (GPIO_REG32(IO_CFG_0_BASE + (gpio_cfg_table[gpio_pin].pupd_reg & 0XFF)) >> shift) & 0x01;
        r0 = (GPIO_REG32(IO_CFG_0_BASE + (gpio_cfg_table[gpio_pin].r0_reg & 0XFF)) >> shift) & 0x01;
        r1 = (GPIO_REG32(IO_CFG_0_BASE + (gpio_cfg_table[gpio_pin].r1_reg & 0XFF)) >> shift) & 0x01;

        temp = (pupd << 8) + (r0 << 4) + r1;
        //log_hal_msgid_info("pupd=%d r0=%d, r1=%d, temp=%.3x\r\n", 4, pupd,r0,r1,temp);

        if (temp == 0x010) {
            pull_type = GPIO_PU_R0;
        } else if (temp == 0x001) {
            pull_type = GPIO_PU_R1;
        } else if (temp == 0x110) {
            pull_type = GPIO_PD_R0;
        } else if (temp == 0x101) {
            pull_type = GPIO_PD_R1;
        } else if (temp == 0x011) {
            pull_type = GPIO_PU_R0_R1;
        } else if (temp == 0x111) {
            pull_type = GPIO_PD_R0_R1;
        } else if ((temp == 0x100) || (temp == 0x000)) {
            pull_type = GPIO_NO_PULL;
        } else if (temp == 0xfff) {
            pull_type = GPIO_PUPD_ERR;
            log_hal_msgid_info("error pupd-r0-r1 = %x\r\n", 1, temp);
        }

    }


    hal_gpio_get_driving_current((hal_gpio_pin_t)gpio_pin, &driving_value);

    gpio_state->mode = mode;
    gpio_state->dir  = dir;
    gpio_state->din  = din;
    gpio_state->dout = dout;
    gpio_state->pull_type = pull_type;
    gpio_state->current_type = (uint8_t)driving_value;

    //log_hal_msgid_info("GPIO%d, mode=%d, dir=%d, din=%d, dout=%d, pull_type=%d\r\n", 6, gpio_pin, mode, dir, din, dout, pull_type);
}

#endif

