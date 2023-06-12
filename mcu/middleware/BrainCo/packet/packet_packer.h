/**
 * @file packet_packer.h
 * @author gaoxiang (gaoxiang89ly@gmail.com)
 * @brief
 * @version 0.1
 * @date 2021-11-01
 *
 * @copyright Copyright (c) 2021  BrainCo Inc.
 *
 */

#ifndef PACKET_PACKET_PACKER_H_
#define PACKET_PACKET_PACKER_H_
#include "packet/packet.h"

typedef struct {
    uint32_t packet_size; /* sizeof(packet_header_t) + payload_len + 2(crc16)*/
    packet_t *packet;
    uint8_t *crc16;
} __attribute__((packed)) packet_packer_t;

#ifdef __cplusplus
extern "C" {
#endif
/**
 * @brief
 *
 * @param payload_len
 * @return packet_packer_t*
 */
int packet_packer_alloc(packet_packer_t *packer, uint16_t payload_len);

/**
 * @brief
 *
 * @param packer
 */
void packet_packer_free(packet_packer_t *packer);

#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif // PACKET_PACKET_PACKER_H_
