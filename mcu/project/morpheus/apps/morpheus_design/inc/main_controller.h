#ifndef MAIN_CONTROLLER_H_
#define MAIN_CONTROLLER_H_
#ifdef __cplusplus
extern "C" {
#endif
#include <stdint.h>

#include "morpheus.h"
#include "morpheus_utils.h"
#include "proto_msg/app_bt/app_bt_msg_helper.h"
#include "proto_msg/main_bt/main_bt_msg_helper.h"

void main_controller_gpio_init(void);

void main_controller_power_set(int status, int reason);

void main_controller_set_state(uint32_t state);

void main_controller_powerkey_map(int status);

void send_track_id_to_main(uint32_t id, bool playing);


void send_main_msg_to_app(MainApp *msg);

void send_music_file_recv_finished(uint32_t solution_id, uint32_t music_id);

void send_solution_music_ids(uint32_t *ids, uint32_t size);

void main_controller_set_music_mode(AudioConfig__Mode mode);

void main_controller_led_set(int red, int green, int blue);

#ifdef __cplusplus
}
#endif
#endif /* MAIN_CONTROLLER_H_ */
