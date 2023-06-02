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

#include "offline_dump.h"
#include "offline_dump_port.h"
#include "memory_map.h"
#include "syslog.h"

#include "hal_rtc.h"
#include "hal_gpt.h"
#include "hal_flash.h"
#include "hal_core_status.h"

#ifdef MTK_LAYOUT_PARTITION_ENABLE
#include "layout_partition.h"
#endif

/* OFFLINE DUMP region share with FOTA */
#ifndef FOTA_RESERVED_BASE
#define FOTA_RESERVED_BASE 0x0822b000
#endif

/* min must be a leap year */
#define BASE_RTC_MIN_YEAR       2020
#define BASE_RTC_MAX_YEAR       2147

/* global variable RTC valid flag */
static bool g_offline_dump_rtc_valid_flag = false; 

log_create_module(offline_dump, PRINT_LEVEL_INFO);

#if !defined(MTK_DEBUG_LEVEL_NONE)
ATTR_LOG_STRING_LIB offline_dump_001[] = LOG_INFO_PREFIX(offline_dump) "Offline dump type[%d] address[0x%08x] region_size[0x%x] cell_size[%d] cell_count[%d] cell_valid_size[%d]";
ATTR_LOG_STRING_LIB offline_dump_002[] = LOG_INFO_PREFIX(offline_dump) "Offline dump check region:%d region_integrity fail.";
#else
ATTR_LOG_STRING_LIB offline_dump_001[] = "";
ATTR_LOG_STRING_LIB offline_dump_002[] = "";
#endif

#if !defined(MTK_DEBUG_LEVEL_NONE)

void offline_dump_log_port_info(const char *message, ...)
{
    va_list ap;

    va_start(ap, message);
    vprint_module_log(&LOG_CONTROL_BLOCK_SYMBOL(offline_dump), __FUNCTION__, __LINE__, PRINT_LEVEL_INFO, message, ap);
    va_end(ap);
}

void offline_dump_log_port_warning(const char *message, ...)
{
    va_list ap;

    va_start(ap, message);
    vprint_module_log(&LOG_CONTROL_BLOCK_SYMBOL(offline_dump), __FUNCTION__, __LINE__, PRINT_LEVEL_WARNING, message, ap);
    va_end(ap);
}

void offline_dump_log_port_error(const char *message, ...)
{
    va_list ap;

    va_start(ap, message);
    vprint_module_log(&LOG_CONTROL_BLOCK_SYMBOL(offline_dump), __FUNCTION__, __LINE__, PRINT_LEVEL_ERROR, message, ap);
    va_end(ap);
}

void offline_dump_log_port_msgid_info(const char *message, uint32_t arg_cnt, ...)
{
    va_list ap;

    va_start(ap, arg_cnt);
    log_print_msgid(&LOG_CONTROL_BLOCK_SYMBOL(offline_dump), PRINT_LEVEL_INFO, message, arg_cnt, ap);
    va_end(ap);
}

void offline_dump_log_port_msgid_warning(const char *message, uint32_t arg_cnt, ...)
{
    va_list ap;

    va_start(ap, arg_cnt);
    log_print_msgid(&LOG_CONTROL_BLOCK_SYMBOL(offline_dump), PRINT_LEVEL_WARNING, message, arg_cnt, ap);
    va_end(ap);
}

void offline_dump_log_port_msgid_error(const char *message, uint32_t arg_cnt, ...)
{
    va_list ap;

    va_start(ap, arg_cnt);
    log_print_msgid(&LOG_CONTROL_BLOCK_SYMBOL(offline_dump), PRINT_LEVEL_ERROR, message, arg_cnt, ap);
    va_end(ap);
}
#else
void offline_dump_log_port_info(const char *message, ...) {}
void offline_dump_log_port_warning(const char *message, ...) {}
void offline_dump_log_port_error(const char *message, ...) {}
void offline_dump_log_port_msgid_info(const char *message, uint32_t arg_cnt, ...) {}
void offline_dump_log_port_msgid_warning(const char *message, uint32_t arg_cnt, ...) {}
void offline_dump_log_port_msgid_error(const char *message, uint32_t arg_cnt, ...) {}
#endif

uint32_t offline_dump_query_FOTA_address(void)
{
    return FOTA_RESERVED_BASE;
}

uint32_t offline_dump_query_FOTA_reserve(void)
{
    return FOTA_RESERVED_LENGTH;
}

/* 
    1. The year starts from 1900 and needs to +1900 to convert to the actual year.
    2. Month range 0-11, +1 to convert whisky month.
    3. Week range 0-6, +1 to convert to actual week. 
*/
bool offline_dump_set_rtc_time_unix(time_t timestamp)
{
    hal_rtc_status_t rtc_status;
    hal_rtc_time_t time;
    struct tm *unix_time;

    /* Call system function conversion time */
    unix_time = localtime(&timestamp);

    /* time correction */
    unix_time->tm_year += 1900;
    unix_time->tm_mon += 1;

    if ((unix_time->tm_year < BASE_RTC_MIN_YEAR) || (unix_time->tm_year > BASE_RTC_MAX_YEAR)) {
        return false;
    }

    time.rtc_year = unix_time->tm_year - BASE_RTC_MIN_YEAR;
    time.rtc_mon = unix_time->tm_mon;
    time.rtc_day = unix_time->tm_mday;
    time.rtc_hour = unix_time->tm_hour;
    time.rtc_min = unix_time->tm_min;
    time.rtc_sec = unix_time->tm_sec;
    time.rtc_week = unix_time->tm_wday;
    time.rtc_milli_sec = 0x0;

    if (g_offline_dump_rtc_valid_flag == false) {
        rtc_status = hal_rtc_set_time(&time);
        if (rtc_status != HAL_RTC_STATUS_OK) {
            return false;
        }
        g_offline_dump_rtc_valid_flag = true;
    }

    return true;
}

bool offline_dump_query_rtc_time(offline_dump_rtc_t *time)
{
    hal_rtc_status_t rtc_status;
    hal_rtc_time_t rtc_time;

    if (time == NULL) {
        return false;
    }

    if (g_offline_dump_rtc_valid_flag == false) {
        return false;
    }

    rtc_status = hal_rtc_get_time(&rtc_time);
    if (rtc_status != HAL_RTC_STATUS_OK) {
        return false;
    }

    time->year = rtc_time.rtc_year;
    time->mon  = rtc_time.rtc_mon;
    time->day  = rtc_time.rtc_day;
    time->hour = rtc_time.rtc_hour;
    time->min  = rtc_time.rtc_min;
    time->sec  = rtc_time.rtc_sec;
    time->milli_sec = ((uint32_t)rtc_time.rtc_milli_sec * 1000) / 32768;

    return true;
}

uint32_t offline_dump_query_current_timestamp(void)
{
    uint32_t count = 0;
    uint64_t count64 = 0;

    hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_32K, &count);
    count64 = ((uint64_t)count) * 1000 / 32768;

    return (uint32_t)count64;
}

/* serial flash information */
#ifdef HAL_FLASH_MODULE_ENABLED
const uint8_t PORT_FLASH_BLOCK_SIZE_4K  = HAL_FLASH_BLOCK_4K;
const uint8_t PORT_FLASH_BLOCK_SIZE_32K = HAL_FLASH_BLOCK_32K;
const uint8_t PORT_FLASH_BLOCK_SIZE_64K = HAL_FLASH_BLOCK_64K;
int32_t PORT_FLASH_READ(uint32_t address, uint8_t *buffer, uint32_t length)
{
    return hal_flash_read(address, buffer, length);
}

int32_t PORT_FLASH_WRITE(uint32_t address, const uint8_t *data, uint32_t length)
{
    return hal_flash_write(address, data, length);
}

int32_t PORT_FLASH_ERASE(uint32_t address, uint8_t block_size)
{
    return hal_flash_erase(address, block_size);
}
#else
const uint8_t PORT_FLASH_BLOCK_SIZE_4K  = 0;
const uint8_t PORT_FLASH_BLOCK_SIZE_32K = 0;
const uint8_t PORT_FLASH_BLOCK_SIZE_64K = 0;
int32_t PORT_FLASH_READ(uint32_t address, uint8_t *buffer, uint32_t length)
{
    return 0;
}
int32_t PORT_FLASH_WRITE(uint32_t address, const uint8_t *data, uint32_t length)
{
    return 0;
}
int32_t PORT_FLASH_ERASE(uint32_t address, uint8_t block_size)
{
    return 0;
}
#endif

bool offlined_dump_core_is_exception(void)
{
    if (hal_core_status_read(HAL_CORE_MCU) == HAL_CORE_EXCEPTION) {
        return true;
    }

    return false;
}

