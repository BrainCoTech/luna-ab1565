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

#ifndef __MUX_LL_UART_CONFIG_H__
#define __MUX_LL_UART_CONFIG_H__
#include <stdint.h>
#include "hal_core_status.h"

#define MUX_LL_UART_RDWR_PTR_CHECK_ENABLE   /**< Only for debug */
#define MUX_LL_UART_SEQ_ENABLE              /**< To enable sequence number in every packet header. */
#define MUX_LL_UART_HEADER_CHECK_ENABLE     /**< To enable header check. */
// #define MUX_LL_UART_CRC_CHECK_ENABLE        /**< To enable data CRC check. */
#define MUX_LL_UART_TIMESTAMP_ENABLE        /**< To enable timestamp in every packet header. This is used to debug. */

/* MUX_LL_UART_ATTR_PACKAGE_TYPE_NORMAL and MUX_LL_UART_ATTR_PACKAGE_TYPE_DECODE are exclusive. */
#define MUX_LL_UART_ATTR_PACKAGE_TYPE_NORMAL (1 << 0) /**< Send full user data when this flag is set. */
#define MUX_LL_UART_ATTR_PACKAGE_TYPE_DECODE (1 << 1) /**< Choose 3 bytes in one word user data to send \
                                                           when this flag is set. */

#define MUX_LL_UART_ATTR_USER_RX_POLLING     (1 << 2) /**< User need to query FIFO when this flag is set, or, \
                                                           user callback is called when user data arrived. */
#define MUX_LL_UART_ATTR_USER_TRX_PROTOCOL   (1 << 3) /**< TX/RX protocol is used when this flag is set. */

typedef enum {
    MUX_LL_UART_PRIORITY_ABOVE_HIGH = 0, /* Reserved for internal use. */
    MUX_LL_UART_PRIORITY_HIGH       = 1,
    MUX_LL_UART_PRIORITY_MIDDLE     = 2,
    MUX_LL_UART_PRIORITY_LOW        = 3,
    MUX_LL_UART_PRIORITY_MAX        = 4,
} mux_ll_uart_priority_t;

typedef struct {
    const char *name;
    hal_core_id_t scid;
    hal_core_id_t dcid;
    mux_ll_uart_priority_t tx_priority;

    uint32_t tx_buf_len;
    uint32_t rx_buf_len;
    uint8_t *tx_buf_addr;
    uint8_t *rx_buf_addr;

    uint32_t tx_pkt_len;
    uint8_t flags;

} mux_ll_uart_user_configure_t;

#ifdef AIR_LL_MUX_WAKEUP_ENABLE
#define MAX_MUX_LL_USER_WAKEUP_COUNT 1
#else
#define MAX_MUX_LL_USER_WAKEUP_COUNT 0
#endif
#define MAX_MUX_LL_INTERNAL_USER_COUNT      (2 + MAX_MUX_LL_USER_WAKEUP_COUNT)

#define MAX_MUX_LL_USER_COUNT               (6 + MAX_MUX_LL_INTERNAL_USER_COUNT)

extern mux_ll_uart_user_configure_t g_mux_ll_uart_user_configure_table[MAX_MUX_LL_USER_COUNT];

#endif //__MUX_LL_UART_CONFIG_H__
