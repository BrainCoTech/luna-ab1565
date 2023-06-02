 /* Copyright Statement:
 *
 * (C) 2022  Airoha Technology Corp. All rights reserved.
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

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdbool.h>
#include <stdarg.h>
#include <assert.h>
#include "mux.h"
#include "mux_port.h"
#include "mux_port_device.h"

#include "mux_ll_uart.h"
#include "mux_ll_uart_wakeup.h"

#include "hal_resource_assignment.h"
#include "hal_pdma_internal.h"
#include "hal_uart_internal.h"
/* TODO: this should be fixed. */
// #define MUX_LL_UART_ALWAYS_LOCK_BT_SLEEP_ENABLE
#if !defined(AIR_DCHS_MODE_MASTER_ENABLE) && !defined(AIR_DCHS_MODE_SLAVE_ENABLE)
#error "Master or Slave must be defined!!"
#endif
#ifdef HAL_SLEEP_MANAGER_ENABLED
#include "hal_sleep_manager.h"
#include "hal_sleep_manager_internal.h"
#endif/*HAL_SLEEP_MANAGER_ENABLED*/

typedef struct {
    uint8_t head;
    uint8_t type;
    uint16_t length;
    uint16_t id;
} mux_ll_uart_latch_header_t;

typedef struct {
    uint16_t id;
    uint16_t tag;
    uint32_t native_clock;
    uint32_t native_phase;
    uint32_t dl_src_clock_offset;
    uint32_t dl_src_phase_offset;
    uint32_t valid;
} mux_ll_uart_latch_info_t;


typedef struct {
    mux_ll_header_t header;
    uint16_t id;
#ifdef MUX_LL_UART_CRC_CHECK_ENABLE
    uint16_t crc;
#endif
} __attribute__((packed)) mux_uart_latch_req_t;

typedef struct {
    mux_ll_header_t header;
    mux_ll_uart_latch_info_t info;
#ifdef MUX_LL_UART_CRC_CHECK_ENABLE
    uint16_t crc;
#endif
} __attribute__((packed)) mux_uart_latch_content_t;

mux_handle_t uart_latch_handle;

void mux_ll_uart_latch_callback(uint16_t id, uint8_t *buff, uint32_t len);
bool mux_ll_uart_latch_send_cmd_data(uint8_t *buf, uint32_t len);

bool mux_ll_uart_send_latch_req(uint16_t id, uint16_t tag);
bool mux_ll_uart_send_latch_info(mux_ll_uart_latch_info_t *latch_info);


void mux_ll_uart_latch_mode_callback_default(void* args)
{
    mux_ll_uart_latch_info_t *latch_info = (mux_ll_uart_latch_info_t*)args;
    RB_LOG_I("[uart latch] cmdid=0x%x tag=0x%x valid=0x%x native_phase=0x%x(%d) native_clock=0x%x(%d) clock_offset=0x%x(%d)", 9,\
    latch_info->id, latch_info->tag, latch_info->valid, latch_info->native_phase,latch_info->native_phase, latch_info->native_clock, latch_info->native_clock,\
    latch_info->dl_src_clock_offset, latch_info->dl_src_clock_offset);
}

#define DCHS_ID1_S2M_LATCH_REQ         0x1000
#define DCHS_ID2_M2S_LATCH_RSP         0x1001
#define DCHS_ID3_S2M_LATCH_ACTION      0x1002
#define DCHS_ID4_M2S_LATCH_INFO        0x1003
#define DCHS_ID5_S2M_LATCH_INFO        0x1004


#define __ABS(x) ((x) < 0 ? -(x) : x)

extern void DCHS_pka_lock_bt_sleep(void (*lock_sleep_done_callback)(void* user_data), void* user_data);
extern void DCHS_pka_unlock_bt_sleep(void);
extern void DCHS_bt_pka_get_uart_latch_info(mux_ll_uart_latch_info_t *);

extern void DCHS_bt_pka_set_audio_clk_offset(bool, mux_ll_uart_latch_info_t *, uint32_t* clock_offset, uint32_t* phase_offset, uint32_t latch_counter);

void dchs_bt_sleep_lock_done_callback(void* user_data);

#define DCHS_LOCK_BT_SLEEP()       do {\
    RB_LOG_I("[uart latch] lock sleep", 0);\
    uint32_t start_count = mux_get_tick_count();\
    uint32_t elapse_count;\
    DCHS_pka_lock_bt_sleep(dchs_bt_sleep_lock_done_callback, NULL);\
    elapse_count = mux_get_tick_elapse(start_count);\
    if (elapse_count > 1000) {\
        RB_LOG_W("[uart latch] lock sleep cost %uus", 1, elapse_count);\
    }\
} while (0)

#ifdef MUX_LL_UART_ALWAYS_LOCK_BT_SLEEP_ENABLE
#define DCHS_UNLOCK_BT_SLEEP()
#else
#define DCHS_UNLOCK_BT_SLEEP()     do {\
    DCHS_pka_unlock_bt_sleep();\
    RB_LOG_I("[uart latch] unlock sleep", 0);\
} while (0)
#endif

bool dchs_uart_latch_enable = false;
#define DCHS_LATCH_MODE_ENABLE()    do {dchs_uart_latch_enable = true;} while (0)
#define DCHS_LATCH_MODE_DISABLE()   do {dchs_uart_latch_enable = false;} while (0)
#define DCHS_LATCH_MODE_CHECK_ENABLE() (dchs_uart_latch_enable == true)

uint32_t g_uart_latch_tx_lock_start_count = 0;
uint32_t g_uart_latch_tx_lock_max_duration = 0;
uint32_t g_uart_latch_tx_lock_duration = 0;

uint32_t g_uart_latch_start_count = 0;
uint32_t g_uart_latch_duration_count = 0;
uint32_t g_uart_latch_lock_sleep_duration = 0;

uint32_t g_latch_phase_clock_diff = 0;
uint32_t g_latch_phase_clock_diff_for_deviation_check = 0;
bool g_latch_phase_clock_diff_flag = false;
uint32_t g_latch_phase_clock_diff_flag_workaround = 0;

bool g_uart_last_latch_done = true;
#ifdef AIR_DCHS_MODE_SLAVE_ENABLE
uint32_t g_uart_latch_counter = 0;
#endif

typedef void (*mux_ll_uart_latch_timer_callback_t)(void*);

typedef struct {
    mux_ll_uart_latch_timer_callback_t callback;
    void *user_data;
    uint32_t timer_handle;
    uint32_t timeout;
    bool is_one_shot;
    uint8_t counter;
} mux_ll_uart_latch_timer_t;

void mux_ll_uart_latch_period_tx_callback(void * user_data);

static mux_ll_uart_latch_timer_t g_latch_timer = {.timeout = 0xFFFFFFFF};

static ATTR_TEXT_IN_FAST_MEM void dchs_uart_latch_timer_callback(void * user_data)
{
    if (!g_latch_timer.callback) {
        assert(0);
    }

    g_latch_timer.callback(g_latch_timer.user_data);

    if (!g_latch_timer.is_one_shot) {
        hal_gpt_sw_start_timer_ms(g_latch_timer.timer_handle, g_latch_timer.timeout, dchs_uart_latch_timer_callback, user_data);
    }
}

static void mux_ll_latch_timer_start_internal(bool is_one_shot, uint32_t timeout, mux_ll_uart_latch_timer_callback_t callback, void *user_data)
{
    if (g_latch_timer.counter == 0) {
        hal_gpt_sw_get_timer(&g_latch_timer.timer_handle);
    }

    g_latch_timer.is_one_shot = is_one_shot;
    if (timeout < g_latch_timer.timeout)
        g_latch_timer.timeout = timeout;
    g_latch_timer.counter++;
    g_latch_timer.callback = callback;
    g_latch_timer.user_data = user_data;
    hal_gpt_sw_start_timer_ms(g_latch_timer.timer_handle, 0, dchs_uart_latch_timer_callback, (void*)&g_latch_timer);
}

void mux_ll_latch_timer_start(bool is_one_shot, uint32_t timeout)
{
    LOG_MSGID_I(common, "[uart latch] s0 [mux_ll_latch_timer_start] %u:%u", 2, is_one_shot, timeout);
    mux_ll_latch_timer_start_internal(is_one_shot, timeout, mux_ll_uart_latch_period_tx_callback, NULL);
}

void mux_ll_latch_timer_stop(void)
{
    if (g_latch_timer.counter && (--g_latch_timer.counter == 0)) {
        hal_gpt_sw_stop_timer_ms(g_latch_timer.timer_handle);
        hal_gpt_sw_free_timer(g_latch_timer.timer_handle);
    }
    LOG_MSGID_I(common, "[uart latch] [mux_ll_latch_timer_stop] counter=%u", 1, g_latch_timer.counter);
    g_latch_phase_clock_diff_for_deviation_check = 0;
    g_latch_phase_clock_diff_flag = false;
#ifdef AIR_DCHS_MODE_SLAVE_ENABLE
    g_uart_latch_counter = 0;
#endif
}

/* This is used to start uart latch request */
ATTR_TEXT_IN_FAST_MEM void mux_ll_uart_latch_period_tx_callback(void * user_data)
{
    if (g_uart_last_latch_done) {
        g_uart_last_latch_done = false;
        RB_LOG_I("[uart latch] s1 [latch_timer_cb] vd_len:%u", 1, mux_ringbuffer_data_length(&g_port_config.txbuf));
        g_uart_latch_start_count = mux_get_tick_count();

        DCHS_LOCK_BT_SLEEP();

        DCHS_LATCH_MODE_ENABLE();
    } else {
        RB_LOG_W("[uart latch] s1 [latch_timer_cb] last latch have not done", 0);
    }
}

#ifdef AIR_DCHS_MODE_SLAVE_ENABLE
uint32_t uart_latch_monitor_timer_handle = 0xFFFFFFFF;
bool uart_latch_monitor_first_timer = true;
static ATTR_TEXT_IN_FAST_MEM void dchs_uart_latch_monitor_timer_callback(void * user_data)
{
    hal_gpt_status_t gpt_status;
    RB_LOG_W("[uart latch] s2: lock uart tx too long: %u", 1, (uint32_t)uart_latch_monitor_first_timer);

    if (uart_latch_monitor_first_timer == true) {
        uart_latch_monitor_first_timer = false;
        gpt_status = hal_gpt_sw_start_timer_ms(uart_latch_monitor_timer_handle, 50, dchs_uart_latch_monitor_timer_callback, NULL);
        if (HAL_GPT_STATUS_OK != gpt_status) {
            RB_LOG_E("[uart latch] s2: start monitor timer fail, gpt_status=%d", 1, gpt_status);
        }
    } else {
        uart_latch_monitor_first_timer = true;
        if (DCHS_IS_UART_TX_LOCKED()) {
            DCHS_UNLOCK_UART_TX();
            DCHS_LATCH_MODE_DISABLE();
            g_uart_last_latch_done = true;
            RB_LOG_W("[uart latch] s2: last latch req maybe fail, unlock uart tx", 0);
            return;
        }
    }
}

extern void DCHS_bt_pka_enter_uart_tx_latch_mode(void);

#define DCHS_ENTER_UART_TX_LATCH_MODE() DCHS_bt_pka_enter_uart_tx_latch_mode()

#elif defined(AIR_DCHS_MODE_MASTER_ENABLE)
extern void DCHS_bt_pka_enter_uart_rx_latch_mode(void);
#define DCHS_ENTER_UART_RX_LATCH_MODE()    DCHS_bt_pka_enter_uart_rx_latch_mode()
#else
#error "ERROR DEVICE!!!"
#endif

ATTR_TEXT_IN_TCM void dchs_uart_latch_cmd_callback(mux_handle_t handle, mux_event_t event, uint32_t data_len, void *user_data)
{
    mux_buffer_t buffer;
    mux_status_t mux_status;
    uint32_t read_done_size = 0;
    uint8_t user_rx_fifo[32];

    buffer.p_buf = user_rx_fifo;
    buffer.buf_size = sizeof(user_rx_fifo);

    switch (event) {
    case MUX_EVENT_READY_TO_READ:
        mux_status = mux_rx(handle, &buffer, &read_done_size);
        if (mux_status != MUX_STATUS_OK) {
            RB_LOG_E("[uart wakeup] [cmd_callback] mux_rx fail:%d", 1, mux_status);
            assert(0);
        } else {
            if (read_done_size != 0) {
                mux_ll_uart_latch_callback(*(uint16_t*)buffer.p_buf, buffer.p_buf, buffer.buf_size);
            } else {
                RB_LOG_E("[uart wakeup] [cmd_callback] mux_rx read_done_size = 0", 0);
            }
        }
        break;
    case MUX_EVENT_READY_TO_WRITE:
        RB_LOG_I("[uart latch] [cmd_callback] MUX_EVENT_READY_TO_WRITE", 0);
        break;
    default:
        RB_LOG_I("[uart latch] [cmd_callback] event %d no task", 1, event);
    }
}

void mux_ll_uart_latch_init(void)
{
    mux_status_t status;

    status = mux_open(MUX_LL_UART_PORT, "LATCH", &uart_latch_handle, dchs_uart_latch_cmd_callback, NULL);
    if(MUX_STATUS_OK != status) {
        assert(0 && "[uart latch] mux_open fail");
    } else {
        RB_LOG_I("[uart latch] mux_open ok handle=0x%x", 1, uart_latch_handle);
    }

#ifdef MUX_LL_UART_ALWAYS_LOCK_BT_SLEEP_ENABLE
    DCHS_LOCK_BT_SLEEP();
#endif

#ifdef AIR_DCHS_MODE_SLAVE_ENABLE
    hal_gpt_sw_get_timer(&uart_latch_monitor_timer_handle);
    /* The first latch action should not start too early, in case of the another chip has not been bootup. */
    // mux_ll_latch_timer_start(true, 500);
#endif
}

ATTR_TEXT_IN_FAST_MEM bool mux_ll_uart_latch_send_cmd_data(uint8_t *buf, uint32_t len)
{
    // RB_LOG_I("[uart latch] [mux_ll_uart_latch_send_cmd_data] uart_latch_handle=0x%x", 1, uart_latch_handle);

    mux_buffer_t buffer = {buf, len};
    mux_status_t status;
    uint32_t send_done_len = 0;
    status = mux_tx(uart_latch_handle, &buffer, 1, &send_done_len);
    if (status != MUX_STATUS_OK) {
        assert(0 && "mux_tx fail");
    }
    if (len != send_done_len) {
        RB_LOG_I("[uart latch] [mux_ll_uart_latch_send_cmd_data] tx buffer full", 0);
    }
    // mux_hexdump_ll(uart_latch_handle, __func__, true, true);
    return true;
}

ATTR_TEXT_IN_FAST_MEM bool mux_ll_uart_send_latch_req(uint16_t id, uint16_t tag)
{
    uint16_t buf[2] = {id, tag};

    return mux_ll_uart_latch_send_cmd_data((uint8_t*)&buf[0], sizeof(buf));
}

ATTR_TEXT_IN_FAST_MEM bool mux_ll_uart_send_latch_info(mux_ll_uart_latch_info_t *latch_info)
{
    return mux_ll_uart_latch_send_cmd_data((uint8_t*)latch_info, sizeof(mux_ll_uart_latch_info_t));
}

#ifdef AIR_DCHS_MODE_MASTER_ENABLE
mux_ll_uart_latch_info_t latch_info_to_slave_bkp = {0};
mux_ll_uart_latch_info_t latch_info_to_slave;
#endif
#ifdef AIR_DCHS_MODE_SLAVE_ENABLE
mux_ll_uart_latch_info_t latch_info_to_master_bkp = {0};
mux_ll_uart_latch_info_t latch_info_to_master;
#endif

ATTR_TEXT_IN_FAST_MEM void mux_ll_uart_latch_callback(uint16_t id, uint8_t *buff, uint32_t len)
{
    mux_ll_uart_latch_info_t latch_info;
    uint32_t clock_duration;
    int32_t start_count;
    int32_t end_count;
    uint32_t clock_offset = 0;
    uint32_t phase_offset = 0;

#ifdef AIR_DCHS_MODE_SLAVE_ENABLE
    mux_ll_uart_latch_info_t *latch_info_from_master;
    hal_gpt_status_t gpt_status;
#endif

#ifdef AIR_DCHS_MODE_MASTER_ENABLE
    mux_ll_uart_latch_info_t *latch_info_from_slave;
#endif
    memcpy(&latch_info, buff, len);

    switch(id) {
#ifdef AIR_DCHS_MODE_MASTER_ENABLE
    case DCHS_ID1_S2M_LATCH_REQ   :
        g_uart_latch_start_count = mux_get_tick_count();
        RB_LOG_I("[uart latch] m1<-s2", 0);
        DCHS_LOCK_BT_SLEEP();

        break;
    case DCHS_ID3_S2M_LATCH_ACTION:
        //master has already been lathched when slave receive this cb

        DCHS_bt_pka_get_uart_latch_info(&latch_info_to_slave);
        DCHS_UNLOCK_BT_SLEEP();
        latch_info_to_slave.id = DCHS_ID4_M2S_LATCH_INFO;
        RB_LOG_I("[uart latch] m3<-s3: native_phase=%d native_clock=%d", 2, latch_info_to_slave.native_phase, latch_info_to_slave.native_clock);
        mux_ll_uart_send_latch_info(&latch_info_to_slave);
        if ((latch_info_to_slave_bkp.native_clock == latch_info_to_slave.native_clock) && (latch_info_to_slave_bkp.native_phase == latch_info_to_slave.native_phase)) {
            assert(0 && "[uart latch] latch fail");
        }
        memcpy(&latch_info_to_slave_bkp, &latch_info_to_slave, sizeof(mux_ll_uart_latch_info_t));
        break;
    case DCHS_ID5_S2M_LATCH_INFO  :
        g_uart_latch_duration_count = mux_get_tick_elapse(g_uart_latch_start_count);

        latch_info_from_slave = &latch_info;
        DCHS_bt_pka_set_audio_clk_offset(TRUE, latch_info_from_slave, &clock_offset, &phase_offset, 0);
        start_count = NATIVE_CLK_PHASE_2_US(latch_info_from_slave->native_clock, latch_info_from_slave->native_phase);
        end_count = NATIVE_CLK_PHASE_2_US(latch_info_to_slave.native_clock, latch_info_to_slave.native_phase);

        clock_duration = DCHS_bt_get_native_clock_us_duration(start_count, end_count);

        LOG_MSGID_I(common, "[uart latch] m4<-s4: latch_cost:%4dus, mst_clock:%7d, mst_phase:%4d, slv_clk:%7d, slv_phase:%4d, slv_S:%dus, mst_E:%dus, clk_offset:%dus, co_diff:%dus", 9, \
            g_uart_latch_duration_count, latch_info_to_slave.native_clock, latch_info_to_slave.native_phase, latch_info_from_slave->native_clock, latch_info_from_slave->native_phase, start_count, end_count, (int)(clock_duration), (int)(clock_duration - g_latch_phase_clock_diff));


        g_latch_phase_clock_diff = (int32_t)clock_duration;
        mux_ll_uart_latch_mode_callback_default(latch_info_from_slave); //call user callback, user get #1 #2 latch info //JB,  args's format

        break;
#endif
#ifdef AIR_DCHS_MODE_SLAVE_ENABLE
    case DCHS_ID2_M2S_LATCH_RSP   :
        //when master receive this callback, it means slave have already entered latch mode
        g_uart_latch_tx_lock_duration = mux_get_tick_elapse(g_uart_latch_tx_lock_start_count);
        if (DCHS_LATCH_MODE_CHECK_ENABLE()) {
            DCHS_ENTER_UART_TX_LATCH_MODE();
            DCHS_UNLOCK_UART_TX();
            gpt_status = hal_gpt_sw_stop_timer_ms(uart_latch_monitor_timer_handle);
            if (HAL_GPT_STATUS_OK != gpt_status) {
                RB_LOG_E("[uart latch] s3: stop timer fail, gpt_status=%d", 1, gpt_status);
            }
            uart_latch_monitor_first_timer = true;
            if (g_uart_latch_tx_lock_duration > 3000) {
                RB_LOG_E("[uart latch] s3: lock uart tx cost too much time: %uus", 1, g_uart_latch_tx_lock_duration);
            }
            g_uart_latch_tx_lock_max_duration = RB_MAX(g_uart_latch_tx_lock_duration, g_uart_latch_tx_lock_max_duration);
            RB_LOG_I("[uart latch] s3<-m2: tx lock duration=%d, max=%d", 2, g_uart_latch_tx_lock_duration, g_uart_latch_tx_lock_max_duration);

            mux_ll_uart_send_latch_req(DCHS_ID3_S2M_LATCH_ACTION, 0x3); //send a latch cmd to let slave know that master has already entered latch mode
        } else {
            RB_LOG_E("[uart latch] s3: response cost %uus, latch cancel", 1, g_uart_latch_tx_lock_duration);
        }

        break;
    case DCHS_ID4_M2S_LATCH_INFO  :
        g_uart_latch_duration_count = mux_get_tick_elapse(g_uart_latch_start_count);

        latch_info_from_master = &latch_info;

        DCHS_bt_pka_get_uart_latch_info(&latch_info_to_master);
        g_uart_latch_counter++;
        DCHS_bt_pka_set_audio_clk_offset(FALSE, latch_info_from_master, &clock_offset, &phase_offset, g_uart_latch_counter);
        latch_info_to_master.id = DCHS_ID5_S2M_LATCH_INFO;
        mux_ll_uart_send_latch_info(&latch_info_to_master);
        start_count = NATIVE_CLK_PHASE_2_US(latch_info_from_master->native_clock, latch_info_from_master->native_phase);
        end_count = NATIVE_CLK_PHASE_2_US(latch_info_to_master.native_clock, latch_info_to_master.native_phase);

        clock_duration = DCHS_bt_get_native_clock_us_duration(start_count, end_count);
        LOG_MSGID_I(common, "[uart latch] s4<-m3: latch_cost:%4dus, tx_lock:%4u lock_max:%4u, latch_counter:%u clock_offset:%dus, co_diff:%dus, mst_clk:%7d, mst_phase:%4d, slv_clock:%7d, slv_phase:%4d, mst_S:%dus, slv_E:%dus", 12, \
            g_uart_latch_duration_count, g_uart_latch_tx_lock_duration, g_uart_latch_tx_lock_max_duration, g_uart_latch_counter, (int)(clock_duration), (int)(clock_duration - g_latch_phase_clock_diff), latch_info_from_master->native_clock, \
            latch_info_from_master->native_phase, latch_info_to_master.native_clock, latch_info_to_master.native_phase, start_count, end_count);

        if (g_latch_phase_clock_diff_for_deviation_check != 0) {
            /* 26M 200ppm  1s offset 200us. BT lock sync every 100ms ，BT native clock offset must not be beyond 20us. Go easy on the restrictions, we set 100us. */
            if (__ABS((int)(clock_duration - g_latch_phase_clock_diff_for_deviation_check)) > 100) {
                if (g_latch_phase_clock_diff_flag && (g_latch_phase_clock_diff_flag_workaround <= 1)) {
                    //assert(0 && "[uart latch] co_diff out of range");
                    RB_LOG_E("[uart latch] co_diff out of range 1", 0);
                    g_latch_phase_clock_diff_flag_workaround++;

                } else if (g_latch_phase_clock_diff_flag && (g_latch_phase_clock_diff_flag_workaround==2)) {
                    assert(0 && "[uart latch] co_diff out of range");
                } else {
                    RB_LOG_E("[uart latch] co_diff out of range 2", 0);
                }
                g_latch_phase_clock_diff_flag = true;
            } else {
                g_latch_phase_clock_diff_flag_workaround = 0;
            }
        }
        g_latch_phase_clock_diff = (int32_t)clock_duration;
        g_latch_phase_clock_diff_for_deviation_check = g_latch_phase_clock_diff;

        DCHS_UNLOCK_BT_SLEEP();

        mux_ll_uart_latch_mode_callback_default(latch_info_from_master);
        if ((latch_info_to_master_bkp.native_clock == latch_info_to_master.native_clock) && (latch_info_to_master_bkp.native_phase == latch_info_to_master.native_phase)) {
            assert(0 && "[uart latch] latch fail");
        }
        memcpy(&latch_info_to_master_bkp, &latch_info_to_master, sizeof(mux_ll_uart_latch_info_t));
        g_uart_last_latch_done = true;
        break;
#endif
    default:
        RB_LOG_E("[uart latch] Error id:0x%x!!", 1, latch_info.id);
        break;
    }
}

#ifdef AIR_DCHS_MODE_SLAVE_ENABLE
ATTR_TEXT_IN_FAST_MEM void mux_ll_uart_start_latch_req(void)
{
    hal_gpt_status_t gpt_status;

    g_uart_latch_lock_sleep_duration = mux_get_tick_elapse(g_uart_latch_start_count);
    g_uart_latch_tx_lock_start_count = mux_get_tick_count();

    RB_LOG_I("[uart latch] s2: lock_sleep_duration=%d", 1, g_uart_latch_lock_sleep_duration);

    gpt_status = hal_gpt_sw_start_timer_ms(uart_latch_monitor_timer_handle, 5, dchs_uart_latch_monitor_timer_callback, NULL);
    DCHS_LOCK_UART_TX_CLR_REQ();
    mux_ll_uart_send_latch_req(DCHS_ID1_S2M_LATCH_REQ, 0x1);//send latch req cmd to slave, let slave enter latch mode
    if (HAL_GPT_STATUS_OK != gpt_status) {
        RB_LOG_E("[uart latch] s2: start timer fail, gpt_status=%d", 1, gpt_status);
    }
}
#endif

ATTR_TEXT_IN_FAST_MEM void dchs_bt_sleep_lock_done_callback(void* user_data)
{
    (void)user_data;
    RB_LOG_I("[uart latch] lock sleep done", 0);

#ifdef MUX_LL_UART_ALWAYS_LOCK_BT_SLEEP_ENABLE
    static bool lock_sleep_done_flag = false;
    if (lock_sleep_done_flag) {
#endif
#ifdef AIR_DCHS_MODE_SLAVE_ENABLE
        uint32_t mask;

        // in case of DSP trigger ccni to send data to uart fifo.
        hal_nvic_save_and_set_interrupt_mask(&mask);
        if (!DCHS_IS_UART_TX_BUFFER_EMPTY()) {
            DCHS_LOCK_UART_TX_SET_REQ();
            hal_nvic_restore_interrupt_mask(mask);
            LOG_MSGID_W(common, "[uart latch] lock uart tx req", 0);
        } else {
            // DCHS_LOCK_UART_TX();
            RB_SET_FLAG(&g_port_config.txbuf, MUX_RB_FLAG_TX_BLOCKING);\
            hal_nvic_restore_interrupt_mask(mask);
            LOG_MSGID_I(common, "[uart latch] lock uart tx", 0);

            mux_ll_uart_start_latch_req();
        }
#else
        g_uart_latch_lock_sleep_duration = mux_get_tick_elapse(g_uart_latch_start_count);

        RB_LOG_I("[uart latch] m2: lock_sleep_duration=%d", 1, g_uart_latch_lock_sleep_duration);

        DCHS_ENTER_UART_RX_LATCH_MODE();
        mux_ll_uart_send_latch_req(DCHS_ID2_M2S_LATCH_RSP, 0x2); //send latch rsp, let master know that slave has already entered latch mode
#endif
#ifdef MUX_LL_UART_ALWAYS_LOCK_BT_SLEEP_ENABLE
    } else {
        lock_sleep_done_flag = true;
        RB_LOG_I("[uart latch] first: lock_sleep_duration=%d", 1, mux_get_tick_elapse(g_uart_latch_start_count));
    }
#endif
}
