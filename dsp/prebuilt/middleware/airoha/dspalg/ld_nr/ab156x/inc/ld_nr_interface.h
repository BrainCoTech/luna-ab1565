/* Copyright Statement:
 *
 * (C) 2021  Airoha Technology Corp. All rights reserved.
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

#ifndef _LD_NR_INTERFACE_H_
#define _LD_NR_INTERFACE_H_

#if defined(AIR_LD_NR_ENABLE)

/* Includes ------------------------------------------------------------------*/
#include "dsp_utilities.h"
#include "dsp_buffer.h"
#include "dsp_feature_interface.h"
#include "dsp_callback.h"
#include "dsp_sdk.h"
#include <stdint.h>
#include "dsp_para_ld_nr_nvkey_struct.h"

/* Public define -------------------------------------------------------------*/
#define LD_NR_PORT_MAX            2

/* Public typedef ------------------------------------------------------------*/
typedef enum {
    LD_NR_STATUS_ERROR = 0,
    LD_NR_STATUS_OK = 1
} ld_nr_status_t;

typedef enum {
    LD_NR_PORT_STATUS_DEINIT = 0,
    LD_NR_PORT_STATUS_INIT = 1,
    LD_NR_PORT_STATUS_RUNNING = 2
} ld_nr_port_status_t;

typedef struct {
    uint16_t channel_num;
    uint16_t frame_size;
    stream_resolution_t resolution;
    uint32_t sample_rate;
    void *nvkey_para;
    bool background_process_enable;
    uint8_t background_process_fr_num;
} ld_nr_config_t;

typedef struct {
    void *work_mem;
    void *nvkey_para;
} ld_nr_channel_parameter_t;

typedef struct {
    bool enable;
    ld_nr_port_status_t status;
    void *owner;
    DSP_STREAMING_PARA_PTR stream;
    uint16_t channel_num;
    uint16_t frame_size;
    stream_resolution_t resolution;
    uint32_t sample_rate;
    ld_nr_channel_parameter_t *channel_para;
    bool background_process_enable;
    bool background_process_ready;
    uint8_t background_process_fr_num;
    uint8_t background_process_fr_acc;
} ld_nr_port_t;

typedef VOID (*LD_NR_BG_ENTRY)(VOID);

/* Public macro --------------------------------------------------------------*/
/* Public variables ----------------------------------------------------------*/
extern LD_NR_BG_ENTRY ld_nr_bg_entry;
/* Public functions ----------------------------------------------------------*/
extern ld_nr_port_t *stream_function_ld_nr_get_port(void *owner);
extern ld_nr_status_t stream_function_ld_nr_init(ld_nr_port_t *port, ld_nr_config_t *config);
extern ld_nr_status_t stream_function_ld_nr_deinit(ld_nr_port_t *port);
extern bool stream_function_ld_nr_initialize(void *para);
extern bool stream_function_ld_nr_process(void *para);

#ifndef AIR_LD_NR_USE_PIC
extern int LD_NR_SVN_version(void);
extern int LD_NR_get_memsize(void);
extern void LD_NR_fir_init(void *st_t, void *p_LD_Nvkey, int16_t mode);
extern int LD_NR_fir_proc1(void *st_t, int16_t *indat, int16_t *out);
extern int LD_NR_fir_proc2(void *st_t);
#endif /* AIR_LD_NR_USE_PIC */

#endif /* AIR_LD_NR_ENABLE */
#endif /* _LD_NR_INTERFACE_H_ */
