/**
 * @file PACKET.h
 * @author gaoxiang (gaoxiang89ly@gmail.com)
 * @brief
 * @version 0.1
 * @date 2021-10-29
 *
 * @copyright Copyright (c) 2021  BrainCo Inc.
 *
 */

#ifndef PACKET_PACKET_H_
#define PACKET_PACKET_H_
#include <stdint.h>

#define PACKET_HEADER_MAGIC_NUMS "BRNC"
#define PACKET_HEADER_MAGIC_SIZE 4

#ifndef APP_ID
#define APP_ID             0
#define BLUETOOTH_ID       1
#define MAIN_CONTROLLER_ID 2
#define CES_ID             3
#endif

#define PROJECT_ID 7 /* morpheus */
#define HEADER_VERSION 2

#define PACKET_LONG_HEADER 1
typedef struct {
    uint8_t magic_num[4];
    uint8_t header_version;
    uint8_t project_id;
    uint8_t payload_version;
    uint16_t payload_length;
#if (PACKET_LONG_HEADER)
    uint8_t src_id;
    uint8_t dst_id;
    uint8_t flag;
#endif
} __attribute__((packed)) packet_header_t;

typedef struct {
    packet_header_t header;
    /* do not use pointer, only need call once alloc and free */
    uint8_t payload[1];
} packet_t;

#endif // PACKET_PACKET_H_
