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

void power_off_1565(void);

void send_main_msg_to_app(MainApp *msg);

void send_music_file_recv_finished(uint32_t solution_id, uint32_t music_id);

void send_solution_music_ids(uint32_t *ids, uint32_t size);

void main_controller_set_music_mode(AudioConfig__Mode mode);

AudioConfig__Mode main_controller_get_music_mode(void);

void set_volume_to_local(uint32_t volume);

uint32_t get_volume_from_local(void);

#define CUSTOMER_SN_LEN 0x11

char *sn_get(void);

void sn_set(char *sn);

int nvdm_read_battery_level(void);

void nvdm_write_battery_level(int level);

void store_battery_level_to_nvdm(void);

#ifdef __cplusplus
}
#endif
#endif /* MAIN_CONTROLLER_H_ */
