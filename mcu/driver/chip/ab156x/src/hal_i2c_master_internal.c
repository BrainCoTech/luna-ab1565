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

#include "hal_platform.h"
#include "hal.h"
#include "hal_i2c_master_internal.h"

#if defined(HAL_I2C_MASTER_MODULE_ENABLED)
#include "hal_i2c_master.h"
#include "hal_pdma_internal.h"
#include "hal_sleep_manager.h"
#include "hal_sleep_manager_platform.h"
#include "hal_clock_internal.h"


#define     I2C_REG_FMT(x)              (x)


/***********************************************************************************************
 * Private Variable Declarations
***********************************************************************************************/

static volatile  I2C_REGISTER_T  *const   s_i2c_master_reg_airo[HAL_I2C_MASTER_MAX] = { (I2C_REGISTER_T *) I2C_REG_FMT(I2C_0_BASE), (I2C_REGISTER_T *) I2C_REG_FMT(I2C_1_BASE),
                                                                                              (I2C_REGISTER_T *) I2C_REG_FMT(I2C_2_BASE), (I2C_REGISTER_T *) I2C_REG_FMT(I2C_AO_BASE)
                                                                                            };
static const  hal_clock_cg_id                   s_i2c_clk_pdn_table[HAL_I2C_MASTER_MAX]   = {HAL_CLOCK_CG_I2C0, HAL_CLOCK_CG_I2C1, HAL_CLOCK_CG_I2C2, HAL_CLOCK_CG_I2C_AO};
static const  hal_nvic_irq_t                    s_i2c_nvic_irq_num[HAL_I2C_MASTER_MAX]    = {I2C0_IRQn, I2C1_IRQn, I2C2_IRQn, I2C_AO_IRQn};
#ifdef HAL_SLEEP_MANAGER_ENABLED
static volatile const sleep_management_lock_request_t    s_i2c_sleep_handle[HAL_I2C_MASTER_MAX] = {SLEEP_LOCK_I2C0, SLEEP_LOCK_I2C1, SLEEP_LOCK_I2C2, SLEEP_LOCK_INVALID_ID};
#endif
static volatile const pdma_channel_t                     s_i2c_pdma_chnl[HAL_I2C_MASTER_MAX][2] = { {PDMA_I2C0_TX, PDMA_I2C0_RX},
                                                                                                    {PDMA_I2C1_TX, PDMA_I2C1_RX},
                                                                                                    {PDMA_I2C2_TX, PDMA_I2C2_RX},
                                                                                                    {        0xFF,         0xFF},
                                                                                                };


/***********************************************************************************************
 * Private Function For Old Hardware
***********************************************************************************************/


hal_i2c_status_t i2c_config_speed(hal_i2c_port_t i2c_port, uint32_t frequency_hz)
{
    uint32_t    frequency = 0;
    uint8_t    step_cnt_div;
    uint8_t    sample_cnt_div;
    uint32_t    temp;



    /* set clock div to 0 */
    s_i2c_master_reg_airo[i2c_port]->CLOCK_DIV = 0;
    if (frequency_hz <= 50000) {
        s_i2c_master_reg_airo[i2c_port]->CLOCK_DIV = 1;
    }
    frequency = frequency_hz;
    /***********************************************************
    * Note: according to datasheet
    *  speed = source_clock/(clock_div+1)/(2*(step_cnt_div+1)*(sample_cnt_div+1))
    ************************************************************/
    /* Fast Mode Speed */
    for (sample_cnt_div = 1; sample_cnt_div <= 8; sample_cnt_div++) {
        temp = (frequency * 2 * sample_cnt_div);
        step_cnt_div = (I2C_SOURCE_CLOCK_RATE_26M + temp - 1) / temp;  /* cast the <1 part */

        if (step_cnt_div <= 64) {
            break;
        }
    }
    sample_cnt_div--;
    step_cnt_div--;
    /* write timing register */
    s_i2c_master_reg_airo[i2c_port]->TIMING_UNION.TIMING_CELLS.SAMPLE_CNT_DIV = sample_cnt_div;
    s_i2c_master_reg_airo[i2c_port]->TIMING_UNION.TIMING_CELLS.STEP_CNT_DIV = step_cnt_div;
    return HAL_I2C_STATUS_OK;
}


hal_i2c_status_t i2c_config_io(hal_i2c_port_t i2c_port, bool is_opendrain)
{
    if (is_opendrain) {
        s_i2c_master_reg_airo[i2c_port]->IO_CONFIG = 0x3;
        s_i2c_master_reg_airo[i2c_port]->CONTROL2_UNION.CONTROL2_CELLS.CLK_EXT_EN = 1;
    } else {
        s_i2c_master_reg_airo[i2c_port]->IO_CONFIG = 0x0;
        s_i2c_master_reg_airo[i2c_port]->CONTROL2_UNION.CONTROL2_CELLS.CLK_EXT_EN = 0;
    }
    return HAL_I2C_STATUS_OK;
}



ATTR_TEXT_IN_TCM hal_i2c_status_t i2c_config_transfer(hal_i2c_port_t i2c_port, i2c_transfer_config_t *config)
{
    uint32_t v_ctrl = 0;

    /* enable detect ack */
    s_i2c_master_reg_airo[i2c_port]->CONTROL2_UNION.CONTROL2_CELLS.ACKERR_DET_EN = 1;
    s_i2c_master_reg_airo[i2c_port]->CONTROL_UNION.CONTROL = 0;
    switch (config->trans_type) {
        case I2C_TRANSFER_TYPE_TX: {
            s_i2c_master_reg_airo[i2c_port]->TRANSAC_LEN      = config->send_pack_size;
            s_i2c_master_reg_airo[i2c_port]->TRANSFER_LEN     = config->send_size;
          s_i2c_master_reg_airo[i2c_port]->TRANSFER_LEN_AUX = 0;
            s_i2c_master_reg_airo[i2c_port]->SLAVE_ADDR       = (config->slv_addr << 1) & 0xFF;
        }
        break;
        case I2C_TRANSFER_TYPE_RX: {
            s_i2c_master_reg_airo[i2c_port]->TRANSAC_LEN      = config->recv_pack_size;
            s_i2c_master_reg_airo[i2c_port]->TRANSFER_LEN     = config->recv_size;
           s_i2c_master_reg_airo[i2c_port]->TRANSFER_LEN_AUX = 0;
           //  s_i2c_master_reg_airo[i2c_port]->TRANSFER_LEN_AUX = 1;
            s_i2c_master_reg_airo[i2c_port]->SLAVE_ADDR       = ((config->slv_addr << 1) | 0x1) & 0xFF;
        }
        break;
        case I2C_TRANSFER_TYPE_TX_RX: {
            s_i2c_master_reg_airo[i2c_port]->TRANSAC_LEN      = 2;
            s_i2c_master_reg_airo[i2c_port]->TRANSFER_LEN     = config->send_size;
            s_i2c_master_reg_airo[i2c_port]->TRANSFER_LEN_AUX = config->recv_size;
            s_i2c_master_reg_airo[i2c_port]->SLAVE_ADDR       = (config->slv_addr << 1) & 0xFF;

            /* bit24:transact_len_chg, bit16:dir_chg, bit 0:rs_stop */
            v_ctrl = (1 << 24) | (1 << 16) | 0x1;
        }
        break;
        default:
            break;
    }
    if (config->trans_mode == I2C_TRANSFER_MODE_DMA) {
        v_ctrl |= (1 << 8);
    }
    s_i2c_master_reg_airo[i2c_port]->CONTROL_UNION.CONTROL = v_ctrl;
    return HAL_I2C_STATUS_OK;
}



ATTR_TEXT_IN_TCM hal_i2c_status_t  i2c_config_fifo(uint32_t i2c_port, uint8_t op_code, uint8_t *buff, uint32_t buff_sz)
{
    int i = 0;
    hal_i2c_status_t         return_status = HAL_I2C_STATUS_OK;
    /* if op != I3C_FIFO_CLEAR, need check the buffer and size*/
    if (op_code != I2C_FIFO_OP_CLR && (buff == NULL || buff_sz == 0)) {
        return_status = HAL_I2C_STATUS_INVALID_PARAMETER;
        return return_status;
    }

    switch (op_code) {
        case I2C_FIFO_OP_WR: {
            for (i = 0; i < buff_sz; i++) {
                s_i2c_master_reg_airo[i2c_port]->DATA_PORT = buff[i];
            }
        }
        break;
        case I2C_FIFO_OP_RD: {
            for (i = 0; i < buff_sz; i++) {
                buff[i] = s_i2c_master_reg_airo[i2c_port]->DATA_PORT;

            }
        }
        break;
        case I2C_FIFO_OP_CLR: {
            s_i2c_master_reg_airo[i2c_port]->FIFO_ADDR_CLR = 0x1;
        }
        break;
        default:
            return_status = HAL_I2C_STATUS_INVALID_PARAMETER;
            break;
    }

    return return_status;
}

i2c_irq_status_t    i2c_get_irq_status(uint32_t i2c_port)
{
    uint32_t                 register_value;
    i2c_irq_status_t         return_status = I2C_IRQ_STAT_UNKNOWN_ERROR;

    register_value = s_i2c_master_reg_airo[i2c_port]->INTR_STAT;
    if (0 != (register_value & (0x1 << 8))) {
        return_status = I2C_IRQ_STAT_ACK_ERROR;
    } else if (0 != (register_value & (0x1 << 16))) {
        return_status = I2C_IRQ_STAT_NACK_ERROR;
    } else if (0x1 == register_value) {
        return_status = I2C_IRQ_STAT_SUCCESS;
    }
    return return_status;
}


ATTR_TEXT_IN_TCM int i2c_op_ioctl(uint8_t i2c_port, uint8_t op_code, uint8_t args)
{
    int result = 0;
    switch (op_code) {
        case I2C_IOCTRL_GET_BUSY_STAT: {
                result = s_i2c_master_reg_airo[i2c_port]->START & 0x1;
        }
        break;
        case I2C_IOCTRL_CLR_IRQ_STAT: {
                s_i2c_master_reg_airo[i2c_port]->INTR_STAT = 0x010101;
        }
        break;
        case I2C_IOCTRL_START: {
                s_i2c_master_reg_airo[i2c_port]->START = 0x1;
        }
        break;
        case I2C_IOCTRL_GET_IRQ_STAT: {
                result = s_i2c_master_reg_airo[i2c_port]->INTR_STAT;
        }
        break;
#ifdef HAL_SLEEP_MANAGER_ENABLED
        case I2C_IOCTRL_LOCK_SLEEP: {
            static bool  sleep_st = false;
            hal_sleep_manager_status_t status;

            if (s_i2c_sleep_handle[i2c_port] != SLEEP_LOCK_INVALID_ID) {
                if (args != 0 && sleep_st == false) {
                    status = hal_sleep_manager_lock_sleep(s_i2c_sleep_handle[i2c_port]);
                    if (status == HAL_SLEEP_MANAGER_OK) {
                        sleep_st = true;
                    } else {
                    }
                } else if (args == 0 && sleep_st == true) {
                    status = hal_sleep_manager_unlock_sleep(s_i2c_sleep_handle[i2c_port]);
                    if (status == HAL_SLEEP_MANAGER_OK) {
                        sleep_st = false;
                    } else {
                    }
                }
            }
        } break;
#endif
#ifdef HAL_CLOCK_MODULE_ENABLED
        case I2C_IOCTRL_ENABLE_CLOCK: {
            if (args) {
                hal_clock_enable(s_i2c_clk_pdn_table[i2c_port]);
            } else {
                hal_clock_disable(s_i2c_clk_pdn_table[i2c_port]);
            }
        }
        break;
#endif
        case I2C_IOCTRL_GET_SLV_ADDR:{
                result = ((s_i2c_master_reg_airo[i2c_port]->SLAVE_ADDR) >> 1) & 0xFF;
        }
        break;
        case I2C_IOCTRL_SET_INTR_MASK:{
                s_i2c_master_reg_airo[i2c_port]->INTR_MASK = args;
        }
        break;
    }
    return result;
}



uint32_t    i2c_speed_enum_to_dec(hal_i2c_frequency_t freq)
{
    uint32_t    freq_dec = 0;
    switch (freq) {
        case HAL_I2C_FREQUENCY_50K:
            freq_dec = 50000;
            break;
        case HAL_I2C_FREQUENCY_100K:
            freq_dec = 100000;
            break;
        case HAL_I2C_FREQUENCY_200K:
            freq_dec = 200000;
            break;
        case HAL_I2C_FREQUENCY_300K:
            freq_dec = 300000;
            break;
        case HAL_I2C_FREQUENCY_400K:
            freq_dec = 400000;
            break;
        case HAL_I2C_FREQUENCY_1M:
            freq_dec = 1000000;
            break;
#ifdef HAL_I2C_MASTER_FEATURE_HIGH_SPEED
        case HAL_I2C_FREQUENCY_2M:
            freq_dec = 2000000;
            break;
        case HAL_I2C_FREQUENCY_2M5:
            freq_dec = 2500000;
            break;
        case HAL_I2C_FREQUENCY_2M8:
            freq_dec = 2800000;
            break;
        case HAL_I2C_FREQUENCY_3M:
            freq_dec = 3000000;
            break;
#endif
        default:
            freq_dec = 400000;
            break;
    }
    log_hal_i2c_info("[hal][i2c] set frequency to %dHz\r\n", 1, freq_dec);
    return freq_dec;
}

int    i2c_wait_idle_with_timeout(uint32_t i2c_port, uint32_t timeout_us)
{
#define     I2C_WAIT_IDLE_TIME_UNIT     100 //0.1ms

    uint32_t  tick_pre = 0, tick_cur = 0, tick_dur = 0, count = 0, max_ms = 0;
    uint32_t  save_mask;
    int       result = 0;
    volatile uint32_t *ptemp = NULL;

    max_ms = timeout_us / I2C_WAIT_IDLE_TIME_UNIT;
    ptemp = &(s_i2c_master_reg_airo[i2c_port]->START);
    hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &tick_pre);
    while (1) {
        hal_nvic_save_and_set_interrupt_mask(&save_mask);
        if (((*ptemp) & 0x1) == 0) {
            result = 0;
            break;
        }
        hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &tick_cur);
        hal_gpt_get_duration_count(tick_pre, tick_cur, &tick_dur);
        if (tick_dur > I2C_WAIT_IDLE_TIME_UNIT) {
            hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &tick_pre);
            count++;
        }
        if (count > max_ms) {
            result = -1;
            break;
        }
        hal_nvic_restore_interrupt_mask(save_mask);
    }
    hal_nvic_restore_interrupt_mask(save_mask);
    return result;
}



int     i2c_get_port_by_nvic_id(hal_nvic_irq_t irq_num)
{
    int i = 0;
    for (i = 0; i < HAL_I2C_MASTER_MAX; i++) {
        if (irq_num == s_i2c_nvic_irq_num[i]) {
            return i;
        }
    }
    return -1;
}


int     i2c_config_irq(hal_i2c_port_t  i2c_port, hal_nvic_isr_t callback)
{
#ifdef I2C_NVIC_ENABLED
    hal_nvic_register_isr_handler(s_i2c_nvic_irq_num[i2c_port], callback);
    hal_nvic_enable_irq(s_i2c_nvic_irq_num[i2c_port]);
#endif
    return 0;
}

void    i2c_sleep_register_backup(hal_i2c_port_t  i2c_port, uint32_t *buff, uint32_t size)
{
    if (size < 4) {
        return;
    }
    buff[0] = s_i2c_master_reg_airo[i2c_port]->CLOCK_DIV;
    buff[1] = s_i2c_master_reg_airo[i2c_port]->TIMING_UNION.TIMING;
    buff[2] = s_i2c_master_reg_airo[i2c_port]->IO_CONFIG;
    buff[3] = s_i2c_master_reg_airo[i2c_port]->CONTROL2_UNION.CONTROL2;
}

void    i2c_sleep_register_restore(hal_i2c_port_t  i2c_port, uint32_t *buff, uint32_t size)
{
    if (size < 4) {
        return;
    }
    s_i2c_master_reg_airo[i2c_port]->CLOCK_DIV               = buff[0];
    s_i2c_master_reg_airo[i2c_port]->TIMING_UNION.TIMING     = buff[1];
    s_i2c_master_reg_airo[i2c_port]->IO_CONFIG               = buff[2];
    s_i2c_master_reg_airo[i2c_port]->CONTROL2_UNION.CONTROL2 = buff[3];
}

ATTR_TEXT_IN_TCM int i2c_pdma_init(uint32_t i2c_port, i2c_transfer_config_t *config)
{
    pdma_config_t           i2c_dma_config;
    pdma_status_t           dma_statue;
    bool    tx_enable = 0, rx_enable = 0;

    i2c_dma_config.burst_mode = false;
    i2c_dma_config.size       = PDMA_BYTE;
    switch (config->trans_type) {
        case I2C_TRANSFER_TYPE_TX_RX:
            tx_enable = true;
            rx_enable = true;
            break;
        case I2C_TRANSFER_TYPE_TX:
            tx_enable = true;
            rx_enable = false;
            break;
        case I2C_TRANSFER_TYPE_RX:
            tx_enable = false;
            rx_enable = true;
            break;
        default:
            log_hal_i2c_info("[hal][i2c%d] pdma init fail: trans_type err(%d)\r\n", 2, i2c_port, config->trans_type);
            break;
    }
    if (tx_enable) {

        /* config tx pdma */
        dma_statue = pdma_init(s_i2c_pdma_chnl[i2c_port][0]);
        if (dma_statue != PDMA_OK) {
            log_hal_i2c_error("[hal][i2c%d] pdma_init fail (%d)\r\n", 2, i2c_port, dma_statue);
            return -1;
        }
        i2c_dma_config.count        = config->send_size * config->send_pack_size;
        i2c_dma_config.master_type  = PDMA_TX;
        dma_statue = pdma_configure(s_i2c_pdma_chnl[i2c_port][0], &i2c_dma_config);
        if (dma_statue != PDMA_OK) {
            log_hal_i2c_error("[hal][i2c%d] pdma_configure fail (%d)\r\n", 2, i2c_port, dma_statue);
            return -2;
        }
        dma_statue = pdma_start_interrupt(s_i2c_pdma_chnl[i2c_port][0], (uint32_t)config->send_buff);
        if (dma_statue != PDMA_OK) {
            log_hal_i2c_error("[hal][i2c%d] pdma_start_interrupt fail (%d)\r\n", 2, i2c_port, dma_statue);
            return -3;
        }
    }
    if (rx_enable) {
        dma_statue = pdma_init(s_i2c_pdma_chnl[i2c_port][1]);
        if (dma_statue != PDMA_OK) {
            log_hal_i2c_error("[hal][i2c%d] pdma_init fail (%d)\r\n", 2, i2c_port, dma_statue);
            return -1;
        }
        i2c_dma_config.master_type  = PDMA_RX;
        i2c_dma_config.count        = config->recv_size * config->recv_pack_size;
        dma_statue = pdma_configure(s_i2c_pdma_chnl[i2c_port][1], &i2c_dma_config);
        if (dma_statue != PDMA_OK) {
            log_hal_i2c_error("[hal][i2c%d] pdma_configure fail (%d)\r\n", 2, i2c_port, dma_statue);
            return -2;
        }
        dma_statue = pdma_start_interrupt(s_i2c_pdma_chnl[i2c_port][1], (uint32_t)config->recv_buff);
        if (dma_statue != PDMA_OK) {
            log_hal_i2c_error("[hal][i2c%d] pdma_start_interrupt fail (%d)\r\n", 2, i2c_port, dma_statue);
            return -3;
        }
    }
    return 0;
}

ATTR_TEXT_IN_TCM int    i2c_pdma_deinit(uint32_t i2c_port)
{
    pdma_channel_t          rx_dma_ch, tx_dma_ch;

    tx_dma_ch = s_i2c_pdma_chnl[i2c_port][0];
    rx_dma_ch = s_i2c_pdma_chnl[i2c_port][1];
    pdma_stop(tx_dma_ch);
    pdma_deinit(tx_dma_ch);
    pdma_stop(rx_dma_ch);
    pdma_deinit(rx_dma_ch);

    return PDMA_OK;
}

void  i2c_pdma_wait_rx_idle(uint32_t i2c_port, uint32_t timeout_us)
{
    pdma_channel_t          rx_dma_ch, tx_dma_ch;
    pdma_running_status_t   tx_running, rx_running;
    uint32_t  tick_pre, tick_cur, tick_dur;

    tx_dma_ch = s_i2c_pdma_chnl[i2c_port][0];
    rx_dma_ch = s_i2c_pdma_chnl[i2c_port][1];
    hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &tick_pre);
    while (1) {
        pdma_get_running_status(rx_dma_ch, &rx_running);
        pdma_get_running_status(tx_dma_ch, &tx_running);
        if (rx_running == PDMA_IDLE && tx_running == PDMA_IDLE) {
            break;
        }
        hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &tick_cur);
        hal_gpt_get_duration_count(tick_pre, tick_cur, &tick_dur);
        if (tick_dur > timeout_us) {
            break;
        }
    }
}




void hal_i2c_master_dump(hal_i2c_port_t i2c_port)
{
    volatile I2C_REGISTER_T *i2c_reg = s_i2c_master_reg_airo[i2c_port];

    i2c_reg = i2c_reg;

    log_hal_i2c_warning("===================== I2C%d Dump(%x) =====================\r\n", 2, i2c_port, i2c_reg);
    log_hal_i2c_warning("START:%x, CONTROL:%x, CONTROL2:%x, IO_CNF:%x\r\n", 4,
                         i2c_reg->START,
                         i2c_reg->CONTROL_UNION.CONTROL,
                         i2c_reg->CONTROL2_UNION.CONTROL2,
                         i2c_reg->IO_CONFIG
                        );
    log_hal_i2c_warning("TIMING:%x, DELAY_LEN:%x, HS:%x, CLOCK_DIV:%x\r\n", 4,
                         i2c_reg->TIMING_UNION.TIMING,
                         i2c_reg->DELAY_LEN,
                         i2c_reg->HS_UNION.HS,
                         i2c_reg->CLOCK_DIV
                        );

    log_hal_i2c_warning("TRANSF_LEN:%x, TRANSF_LEN_AUX:%x, TRANSAC_LEN:%x\r\n", 3,
                         i2c_reg->TRANSFER_LEN,
                         i2c_reg->TRANSFER_LEN_AUX,
                         i2c_reg->TRANSAC_LEN
                        );

     log_hal_i2c_warning("INTR_STA:%x, FIFO_STAT:%x, DEBUG_STA:%x, DEBUG_CTRL:%x\r\n", 4,
                         i2c_reg->INTR_STAT,
                         i2c_reg->FIFO_STAT_UNION.FIFO_STAT,
                         i2c_reg->DEBUGSTAT,
                         i2c_reg->DEBUGCTRL
                        );
     log_hal_i2c_warning("SLV_ADDR:%x, INTR_MASK:%x, ACK_ERR:%x, PD_CG:%x, AO_CG:%x\r\n", 5,
                         i2c_reg->SLAVE_ADDR,
                         i2c_reg->INTR_MASK,
                         i2c_reg->ACKERR_FLAG_UNION.ACKERR_FLAG,
                         *((volatile uint32_t *)0xA2030B00),
                         *((volatile uint32_t *)0xA2030B30)
                        );
}

#endif /* #if defined(HAL_I2C_MASTER_MODULE_ENABLED) */

//////////////////////////////////////////////////////////////////////////////////////////////////

void    queue_init(airo_queue_t  *pfifo)
{
    memset(pfifo, 0, sizeof(airo_queue_t));
}

ATTR_TEXT_IN_TCM int     queue_push(airo_queue_t  *pfifo, int  data)
{
    uint8_t  temp = 0;

    if (pfifo == NULL) {
        return I2C_FIFO_STATUS_ERROR_INVALID_PARA;
    }
    temp = (pfifo->tail + 1) % MAX_FIFO_SIZE;
    if (temp == pfifo->head) {
        return I2C_FIFO_STATUS_ERROR_FULL;
    }
    pfifo->data[pfifo->tail] = data;
    pfifo->tail = temp;
    return temp;
}

ATTR_TEXT_IN_TCM int     queue_pop(airo_queue_t  *pfifo,  int *data)
{
    uint8_t temp = 0;

    if (pfifo == NULL) {
        return I2C_FIFO_STATUS_ERROR_INVALID_PARA;
    }
    if (pfifo->head == pfifo->tail) {
        return I2C_FIFO_STATUS_ERROR_EMPTY;
    }
    temp  = (pfifo->head + 1) % MAX_FIFO_SIZE;
    if (data != NULL) {
        *data  = pfifo->data[pfifo->head];
    }
    pfifo->head = temp;
    return temp;
}

int queue_top(airo_queue_t  *pfifo,  int *data)
{
    if (pfifo == NULL) {
        return I2C_FIFO_STATUS_ERROR_INVALID_PARA;
    }
    if (pfifo->head == pfifo->tail) {
        return I2C_FIFO_STATUS_ERROR_EMPTY;
    }
    *data = pfifo->data[pfifo->head];
    return pfifo->head;
}
