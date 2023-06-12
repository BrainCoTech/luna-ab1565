/**
 * @file packet.h
 * @author gaoxiang (gaoxiang89ly@gmail.com)
 * @brief
 * @version 0.1
 * @date 2021-10-28
 *
 * @copyright Copyright (c) 2021  BrainCo Inc.
 *
 */

#ifndef PACKET_PACKET_UNPACKER_H_
#define PACKET_PACKET_UNPACKER_H_

#include "packet/packet.h"

typedef enum {
	FIND_HEADER = 0,
	FIND_PAYLOAD,
	FIND_SUCCESS,
} packet_unpacker_statemachine_t;

typedef void (*packet_unpacker_handler_t)(int32_t src_id, int32_t dst_id, uint8_t *data,
					  uint16_t size);

typedef struct {
	uint8_t *buf;	     /* local buffer, store the data to be unpacked */
	uint16_t buf_size;   /* size of local buffer */
	uint16_t write_pos;  /* position of writing/len */
	uint16_t search_pos; /* position of searching byte */
	uint8_t role_id;     /* role id or board id */
	uint16_t timeout;
	uint16_t max_len;
	uint32_t found_header_ts;

	packet_unpacker_statemachine_t state;

	packet_header_t *p_header; /* pointer of buf[0], a helper */

	packet_unpacker_handler_t handler;
} __attribute__((packed)) packet_unpacker_t;

#ifdef __cplusplus
extern "C" {
#endif

int packet_unpacker_init(packet_unpacker_t *packet_unpacker, uint16_t buf_size,
			     uint8_t role_id);

int packet_unpacker_init_static(packet_unpacker_t *packet_unpacker, uint8_t *buf,
			     uint16_t buf_size, uint8_t role_id);
				 
int packet_unpacker_reset(packet_unpacker_t *packet_unpacker);

int packet_unpacker_enqueue(packet_unpacker_t *packet_unpacker, const uint8_t *data,
				uint16_t size);

void packet_unpacker_process(packet_unpacker_t *packet_unpacker);

void packet_unpacker_register_handler(packet_unpacker_t *packet_unpacker,
				      packet_unpacker_handler_t handler);

#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif // PACKET_PACKET_UNPACKER_H_
