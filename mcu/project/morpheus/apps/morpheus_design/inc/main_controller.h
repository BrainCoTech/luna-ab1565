#ifndef MAIN_CONTROLLER_H_
#define MAIN_CONTROLLER_H_
#ifdef __cplusplus
extern "C" {
#endif
#include <stdint.h>

void main_controller_gpio_init(void);

void main_controller_power_set(int status, int reason);

void main_controller_set_state(uint32_t state);

void main_controller_powerkey_map(int status);

#ifdef __cplusplus
}
#endif
#endif /* MAIN_CONTROLLER_H_ */
