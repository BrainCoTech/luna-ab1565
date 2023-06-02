/* Copyright Statement:
 *
 * (C) 2023  Airoha Technology Corp. All rights reserved.
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

#include <string.h>
#include <xtensa/tie/xt_hifi2.h>
#include <xtensa/hal.h>
#include "assert.h"
#include <math.h>

#include "xt_library_loader.h"
#include "preloader_pisplit.h"
#include "vendor_2_dec_portable.h"

#include "FreeRTOS.h"
#include "semphr.h"
#include "dsp_feature_interface.h"

static void vendor_2_default_function_parameter(void);

static SemaphoreHandle_t g_vendor_2_load_lib_xSemaphore = NULL;
static bool g_vendor_2_lib_loaded_flag = false;
static preloader_pisplit_handle_t g_vendor_2_pisplit_library_handle = NULL;

void *g_vendor_2_decoder_export_parameters[6] = {
    vendor_2_default_function_parameter,
    vendor_2_default_function_parameter,
    vendor_2_default_function_parameter,
    vendor_2_default_function_parameter,
    vendor_2_default_function_parameter,
    vendor_2_default_function_parameter
};
#if PIC_LOGPRINT
void *g_vendor_2_decoder_import_parameters[4] = {
    printf,
    memcpy,
    floor,
    _Sinx
};
#else
void *g_vendor_2_decoder_import_parameters[4] = {
    fake_printf,
    memcpy,
    floor,
    _Sinx,
};
#endif

static void vendor_2_default_function_parameter(void)
{
    DSP_MW_LOG_E("[vendor_2] decoder library not load or had been unload!!!", 0);
    assert(0);
}

static void vendor_2_load_library_callback(preloader_pisplit_handle_t handle)
{
    BaseType_t xHigherPriorityTaskWoken = pdFALSE;
    uint32_t *p_export_parameters;

    p_export_parameters = preloader_pisplit_get_export_parameter(handle, g_vendor_2_decoder_import_parameters);
    if (p_export_parameters == NULL) {
        DSP_MW_LOG_E("[vendor_2] preloader_pisplit_get_export_parameter() fail", 0);
        assert(0);
    }

    g_vendor_2_decoder_export_parameters[0] = (void *)p_export_parameters[0];
    g_vendor_2_decoder_export_parameters[1] = (void *)p_export_parameters[1];
    g_vendor_2_decoder_export_parameters[2] = (void *)p_export_parameters[2];
    g_vendor_2_decoder_export_parameters[3] = (void *)p_export_parameters[3];
    g_vendor_2_decoder_export_parameters[4] = (void *)p_export_parameters[4];
    g_vendor_2_decoder_export_parameters[5] = (void *)p_export_parameters[5];

    xSemaphoreGiveFromISR(g_vendor_2_load_lib_xSemaphore, &xHigherPriorityTaskWoken);
}

uint32_t vendor_2_library_load(void *code_address, void *data_address, uint32_t *dram_pic_usage)
{
    preloader_pisplit_error_handling_t error_handling;
    UNUSED(code_address);
    UNUSED(data_address);
    UNUSED(dram_pic_usage);

    DSP_MW_LOG_I("[vendor_2] vend_2_library_load() begin", 0);

    if (g_vendor_2_lib_loaded_flag != false) {
        assert(0);
    }

    if (g_vendor_2_load_lib_xSemaphore == NULL) {
        g_vendor_2_load_lib_xSemaphore = xSemaphoreCreateBinary();
        assert(g_vendor_2_load_lib_xSemaphore != NULL);
    }
    error_handling = preloader_pisplit_get_handle(&g_vendor_2_pisplit_library_handle, &pisplit_vendor_2_dec, vendor_2_load_library_callback);
    if (error_handling != PRELOADER_PISPLIT_XTLIB_NO_ERR) {
        DSP_MW_LOG_E("[vendor_2] preloader_pisplit_get_handle() fail %d", 1, error_handling);
        assert(0);
    }
    error_handling = preloader_pisplit_load(g_vendor_2_pisplit_library_handle, PRELOADER_I_HIGH_PERFORMANCE, PRELOADER_D_HIGH_PERFORMANCE);
    if (error_handling != PRELOADER_PISPLIT_XTLIB_NO_ERR) {
        DSP_MW_LOG_E("[vendor_2] preloader_pisplit_load() fail %d", 1, error_handling);
        assert(0);
    }
    if (xSemaphoreTake( g_vendor_2_load_lib_xSemaphore, portMAX_DELAY) != pdTRUE) {
        assert(0);
    }

    vSemaphoreDelete(g_vendor_2_load_lib_xSemaphore);
    g_vendor_2_load_lib_xSemaphore = NULL;

    g_vendor_2_lib_loaded_flag = true;

    DSP_MW_LOG_I("[vendor_2] vend_2_library_load() end", 0);

    return 0;
}

uint32_t vendor_2_library_unload(void)
{
    preloader_pisplit_error_handling_t error_handling;

    DSP_MW_LOG_I("[vendor_2] vend_2_library_unload() begin", 0);

    if (g_vendor_2_lib_loaded_flag != true) {
        assert(0);
    }

    error_handling = preloader_pisplit_unload(g_vendor_2_pisplit_library_handle);
    if (PRELOADER_PISPLIT_XTLIB_NO_ERR != error_handling) {
        DSP_MW_LOG_E("[vendor_2] preloader_pisplit_unload() fail %d", 1, error_handling);
        assert(0);
    }
    error_handling = preloader_pisplit_release_handle(g_vendor_2_pisplit_library_handle);
    if (PRELOADER_PISPLIT_XTLIB_NO_ERR != error_handling) {
        DSP_MW_LOG_E("[vendor_2] preloader_pisplit_release_handle() fail %d", 1, error_handling);
        assert(0);
    }
    g_vendor_2_decoder_export_parameters[0] = vendor_2_default_function_parameter;
    g_vendor_2_decoder_export_parameters[1] = vendor_2_default_function_parameter;
    g_vendor_2_decoder_export_parameters[2] = vendor_2_default_function_parameter;
    g_vendor_2_decoder_export_parameters[3] = vendor_2_default_function_parameter;
    g_vendor_2_decoder_export_parameters[4] = vendor_2_default_function_parameter;
    g_vendor_2_decoder_export_parameters[5] = vendor_2_default_function_parameter;
    g_vendor_2_pisplit_library_handle = NULL;

    g_vendor_2_lib_loaded_flag = false;

    DSP_MW_LOG_I("[vendor_2] vend_2_library_unload() end", 0);

    return 0;
}

