/**
 * @file app_bt_msg_helper.h
 * @author gaoxiang (gaoxiang89ly@gmail.com)
 * @brief
 * @version 0.1
 * @date 2021-11-12
 *
 * @copyright Copyright (c) 2021  BrainCo Inc.
 *
 */

#ifndef APP_BT_MSG_HANDLER_H
#define APP_BT_MSG_HANDLER_H
#ifdef __cplusplus
extern "C" {
#endif
#include "app_bt/app_to_bt.pb-c.h"
#include "app_bt/bt_to_app.pb-c.h"
#include "crc/crc16.h"
#include "packet/packet_packer.h"

/**
 * @brief
 *
 * @param packet
 * @param msg
 * @return int
 */
int bt_app_msg_encode(packet_packer_t *packer, BtApp *msg);

/**
 * @brief
 *
 * @param packet
 * @param msg
 * @return int
 */
int app_bt_msg_encode(packet_packer_t *packer, AppBt *msg);

/**
 * @brief
 *
 * @param buf
 * @param size
 * @return int
 */
int app_bt_msg_decode(const uint8_t *buf, uint16_t size);

/**
 * @brief
 *
 * @param buf
 * @param size
 * @return int
 */
int bt_app_msg_decode(const uint8_t *buf, uint16_t size);


/**
 * @brief application configure paraments to bluetooth chip
 *
 * @param time      utc time
 * @param power_off power off device
 * @return int
 */
int app_bt_msg_decoded_config_handler(uint32_t msg_id, uint64_t time,
                                      protobuf_c_boolean power_off);

void app_bt_msg_decoded_board_config_handler(uint32_t msg_id, BoardConfig *board_cfg);


/**
 * @brief
 *
 * @param msg_id
 * @param music_cfg
 */
void music_config_handler(uint32_t msg_id, MusicSync *music_sync);

/**
 * @brief
 *
 * @param msg_id
 * @param music_data
 */
void music_data_handler(uint32_t msg_id, MusicData *music_data);

void music_solution_handler(uint32_t msg_id, MusicSolution *music_solution);

#ifdef __cplusplus
}
#endif

#endif  // APP_BT_MSG_HANDLER_H