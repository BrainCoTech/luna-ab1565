#ifndef MORPHEUS_UTIL_H_
#define MORPHEUS_UTIL_H_
#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include <stdint.h>
#include "bt_type.h"

typedef struct {
    uint32_t size;
    uint8_t *data;
} uint8_array_t;

uint64_t get_time_unix_timestamp();

void set_time_unix_timestamp(uint64_t unix_timestamp);

void update_rtc_time_from_local(void);

bool ship_mode_flag_get(void);

void ship_mode_flag_set(uint32_t flag);

int bt_addr_from_str(const char *str, bt_bd_addr_t *addr);

#ifdef __cplusplus
}
#endif
#endif /* MORPHEUS_UTIL_H_ */
