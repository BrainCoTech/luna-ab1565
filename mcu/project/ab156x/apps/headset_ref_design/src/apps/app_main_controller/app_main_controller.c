#include "app_main_controller.h"

#include "hal.h"
#include "syslog.h"

log_create_module(MAIN_CONTR, PRINT_LEVEL_INFO);

#define MAIN_POWEN_EN_PIN HAL_GPIO_9
#define POWERKEY_PIN HAL_GPIO_8

void app_main_controller_power_on(void) {
    hal_gpio_init(MAIN_POWEN_EN_PIN);
    hal_pinmux_set_function(MAIN_POWEN_EN_PIN, 0);
    hal_gpio_set_direction(MAIN_POWEN_EN_PIN, HAL_GPIO_DIRECTION_OUTPUT);
    hal_gpio_set_output(MAIN_POWEN_EN_PIN, HAL_GPIO_DATA_HIGH);

    hal_gpio_init(POWERKEY_PIN);
    hal_pinmux_set_function(POWERKEY_PIN, 0);
    hal_gpio_set_direction(POWERKEY_PIN, HAL_GPIO_DIRECTION_OUTPUT);
    hal_gpio_set_output(POWERKEY_PIN, HAL_GPIO_DATA_HIGH);
}

void app_main_controller_power_off(void) {
    hal_gpio_set_output(MAIN_POWEN_EN_PIN, HAL_GPIO_DATA_LOW);
    hal_gpio_set_output(POWERKEY_PIN, HAL_GPIO_DATA_LOW);
}