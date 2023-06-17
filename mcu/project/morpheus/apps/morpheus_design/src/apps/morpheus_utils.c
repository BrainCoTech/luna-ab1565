#include "morpheus_utils.h"

#include <time.h>

#include "bt_customer_config.h"
#include "bt_sink_srv_a2dp.h"

#include "errno.h"
#include "hal.h"
#include "nvdm_id_list.h"
#include "nvkey.h"
#include "nvkey_id_list.h"
#include "race_cmd_hostaudio.h"
#include "syslog.h"

#define NVDM_USE_RTC "RTC"
#define BASE_YEAR 2000

#define NVDM_SHIP_MODE "SHIP_MODE"

log_create_module(UTIL, PRINT_LEVEL_INFO);

void set_rtc_time_to_local(void) {
    uint64_t t = get_time_unix_timestamp();
    nvdm_write_data_item(NVDM_INTERNAL_USE_GROUP, NVDM_USE_RTC,
                         NVDM_DATA_ITEM_TYPE_RAW_DATA, &t, sizeof(t));
}

uint64_t get_time_unix_timestamp(void) {
    time_t timestamp = 0;
    struct tm tm;
    hal_rtc_time_t hal_time;

    hal_rtc_get_time(&hal_time);
    memset(&tm, 0, sizeof(tm));

    tm.tm_year = hal_time.rtc_year + BASE_YEAR - 1900;
    tm.tm_mon = hal_time.rtc_mon - 1;
    tm.tm_mday = hal_time.rtc_day;
    tm.tm_hour = hal_time.rtc_hour;
    tm.tm_min = hal_time.rtc_min;
    tm.tm_sec = hal_time.rtc_sec;

    timestamp = mktime(&tm) - 8 * 60 * 60;
    return timestamp;
}

void set_time_unix_timestamp(uint64_t unix_timestamp) {
    /* add time zone 8 hours*/
    unix_timestamp += 8 * 60 * 60;
    struct tm *time = localtime(&unix_timestamp);
    /* calculate unix time */
    time->tm_year += 1900;
    time->tm_mon += 1;
    LOG_MSGID_I(UTIL, "rtc time %d %d %d %d %d %d", 6, time->tm_year,
                time->tm_mon, time->tm_mday, time->tm_hour, time->tm_min,
                time->tm_sec);

    hal_rtc_time_t rtc_time;

    // The user has to define the base year and the RTC year is defined
    // as an offset. For example, define the base year as 2000 and assign 15
    // to the RTC year to represent the year of 2015.
    rtc_time.rtc_year = time->tm_year - BASE_YEAR;
    rtc_time.rtc_mon = time->tm_mon;
    rtc_time.rtc_day = time->tm_mday;
    rtc_time.rtc_hour = time->tm_hour;
    rtc_time.rtc_min = time->tm_min;
    rtc_time.rtc_sec = time->tm_sec;

    // Set the RTC current time.
    if (HAL_RTC_STATUS_OK != hal_rtc_set_time(&rtc_time)) {
        LOG_MSGID_I(UTIL, "set rtc time failed", 0);
    }
}

void update_rtc_time_from_local(void) {
    uint64_t nvdm_timestamp;
    uint64_t timestamp = get_time_unix_timestamp();
    int size = sizeof(uint64_t);
    bt_status_t status = nvdm_read_data_item(
        NVDM_INTERNAL_USE_GROUP, NVDM_USE_RTC, &nvdm_timestamp, &size);
    if (status != NVDM_STATUS_OK) {
        LOG_MSGID_I(UTIL, "read user rtc failed, status %d", 1, status);
    } else {
        LOG_MSGID_I(UTIL, "read user rtc success, ts %lu", 1, nvdm_timestamp);
        if (nvdm_timestamp > 3600)
            if (timestamp < nvdm_timestamp - 3600)
                set_time_unix_timestamp(nvdm_timestamp);
    }
}

void ship_mode_flag_set(uint32_t flag) {
    nvdm_write_data_item(NVDM_INTERNAL_USE_GROUP, NVDM_SHIP_MODE,
                         NVDM_DATA_ITEM_TYPE_RAW_DATA, &flag, sizeof(flag));
    LOG_MSGID_I(MAIN_CONTR, "set ship mode flag to nvdm %u", 1, flag);
}

bool ship_mode_flag_get(void) {
    uint32_t flag = 0;
    uint32_t size = sizeof(flag);
    bt_status_t status = nvdm_read_data_item(NVDM_INTERNAL_USE_GROUP,
                                             NVDM_SHIP_MODE, &flag, &size);
    if (BT_STATUS_SUCCESS == status && flag) {
        return true;
    }
    return false;
}

int char2hex(char c, uint8_t *x) {
    if (c >= '0' && c <= '9') {
        *x = c - '0';
    } else if (c >= 'a' && c <= 'f') {
        *x = c - 'a' + 10;
    } else if (c >= 'A' && c <= 'F') {
        *x = c - 'A' + 10;
    } else {
        return -EINVAL;
    }

    return 0;
}

int bt_addr_from_str(const char *str, bt_bd_addr_t *addr) {
    int i, j;
    uint8_t tmp;
    uint8_t bt_addr[6];

    if (strlen(str) != 12U) {
        return -EINVAL;
    }

    for (i = 5; i >= 0; i--) {
        if (char2hex(str[2 * i], &tmp) < 0) {
            return -EINVAL;
        }
        bt_addr[i] = tmp << 4;

        if (char2hex(str[2 * i + 1], &tmp) < 0) {
            return -EINVAL;
        }
        bt_addr[i] += tmp;
    }

    memcpy(addr, bt_addr, 6);


    return 0;
}