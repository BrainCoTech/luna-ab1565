/**
 * @file crc16.h
 * @author gaoxiang (gaoxiang89ly@gmail.com)
 * @brief refference  https://www.modbustools.com/modbus_crc16.html
 * @version 0.1
 * @date 2021-10-29
 *
 * @copyright Copyright (c) 2021  BrainCo Inc.
 *
 */

#ifndef CRC16_H
#define CRC16_H
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief
 *
 * @param data
 * @param len
 * @return uint16_t
 */
uint16_t calc_crc16_long_table(uint8_t *data, uint16_t len);

/**
 * @brief
 *
 * @param data
 * @param len
 * @return uint16_t
 */
uint16_t calc_crc16_short_table(uint8_t *data, uint16_t len);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif
