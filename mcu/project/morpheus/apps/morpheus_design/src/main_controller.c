#include "main_controller.h"

#include <time.h>

#include "apps_config_led_index_list.h"
#include "apps_config_led_manager.h"
#include "apps_config_vp_index_list.h"
#include "apps_config_vp_manager.h"
#include "apps_events_event_group.h"
#include "apps_events_interaction_event.h"
#include "bt_sink_srv_a2dp.h"
#include "hal.h"
#include "syslog.h"
#include "ui_shell_manager.h"

#define BASE_YEAR 2000

log_create_module(MAIN_CONTR, PRINT_LEVEL_INFO);

#define MAIN_POWEN_EN_PIN HAL_GPIO_9
#define POWERKEY_PIN HAL_GPIO_8

void main_controller_gpio_init(void) {
    hal_gpio_init(MAIN_POWEN_EN_PIN);
    hal_pinmux_set_function(MAIN_POWEN_EN_PIN, 0);
    hal_gpio_set_direction(MAIN_POWEN_EN_PIN, HAL_GPIO_DIRECTION_OUTPUT);
    hal_gpio_set_output(MAIN_POWEN_EN_PIN, HAL_GPIO_DATA_LOW);

    hal_gpio_init(POWERKEY_PIN);
    hal_pinmux_set_function(POWERKEY_PIN, 0);
    hal_gpio_set_direction(POWERKEY_PIN, HAL_GPIO_DIRECTION_OUTPUT);
    hal_gpio_set_output(POWERKEY_PIN, HAL_GPIO_DATA_LOW);
}

void main_controller_power_set(int status, int reason) {
    if (status) {
        LOG_MSGID_I(MAIN_CONTR, "power on reason %d", 1, reason);
    }

    hal_gpio_set_output(MAIN_POWEN_EN_PIN, status);

    battery_set_enable_charger(0);
}

void main_controller_powerkey_map(int status) {
    LOG_MSGID_I(MAIN_CONTR, "power key %d", 1, status);

    hal_gpio_set_output(POWERKEY_PIN, status);
}