/**
 * @file packet.c
 * @author gaoxiang (gaoxiang89ly@gmail.com)
 * @brief
 * @version 0.1
 * @date 2021-10-29
 *
 * @copyright Copyright (c) 2021  BrainCo Inc.
 *
 */

#include "packet/packet_unpacker.h"

#include <errno.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "crc/crc16.h"

#ifndef FREERTOS
#define FREERTOS 1
#endif

/**
 * Choose logger.
 * define ZEPHYRRTOS when used in zephyr rtos.
 * define FREERTOS & AB1565 when used in Bluetooth MCU.
 * otherwise, use printf
 */
#ifdef ZEPHYRRTOS
#include <zephyr.h>
#include <logging/log.h>
LOG_MODULE_REGISTER(unpacker, LOG_LEVEL_INF);
#elif defined(FREERTOS)
#ifdef AB1565 // morpheus bluetooth mcu, ab1565
#include "apps_debug.h"
log_create_module(unpacker, PRINT_LEVEL_INFO);
#endif
#else
// clang-format off
#define LOG_DBG(...) do{printf(__VA_ARGS__); printf("\n");}while(0)
#define LOG_INF(...) do{printf(__VA_ARGS__); printf("\n");}while(0)
#define LOG_ERR(...) do{printf(__VA_ARGS__); printf("\n");}while(0)
// clang-format on
#endif

/**
 * Choose memory allocator.
 * define ZEPHYRRTOS & no define USE_HEAP_ALLOCATOR, use k_malloc.
 * define ZEPHYRRTOS & define USE_HEAP_ALLOCATOR, use customize heap allocate api.
 * 
 * edit CMakeList.txt   add_definitions(-DZEPHYRRTOS)
 * */
#ifdef ZEPHYRRTOS
#ifdef USE_HEAP_ALLOCATOR
#include <heap_allocator.h>
#define malloc(size) heap_alloc(size)
#define free(ptr)    heap_free(ptr)
#else
#define malloc(size) k_malloc(size)
#define free(ptr)    k_free(ptr)
#endif /* USE_HEAP_ALLOCATOR */
/* ZEPHYRRTOS */
#elif defined(FREERTOS)
#include "FreeRTOS.h"
#include "task.h"
#define malloc(size) pvPortMalloc(size)
#define free(ptr)    vPortFree(ptr)
#endif /* FREERTOS */

static int is_packet_header(const packet_header_t *header);

static void unpacker_remove_ahead_bytes(packet_unpacker_t *unpacker,
					uint16_t bytes_size);

int packet_unpacker_init(packet_unpacker_t *packet_unpacker,
			     uint16_t buf_size, uint8_t role_id)
{
	if (buf_size <= sizeof(packet_header_t)) {
		// LOG_ERR("buf_size is too small");
		return -EINVAL;
	}

	packet_unpacker->buf = malloc(buf_size);
	if (packet_unpacker->buf == NULL) {
		// LOG_ERR("alloc memory failed");
		return -ENOMEM;
	}
	packet_unpacker->buf_size = buf_size;
	packet_unpacker->role_id = role_id;
	packet_unpacker->p_header = (packet_header_t *)packet_unpacker->buf;
	packet_unpacker->state = FIND_HEADER;
	packet_unpacker->handler = NULL;
	packet_unpacker->search_pos = 0;
	packet_unpacker->write_pos = 0;
	packet_unpacker->max_len = 5120;
	packet_unpacker->timeout = 3000;	
	return 0;
}

int packet_unpacker_init_static(packet_unpacker_t *packet_unpacker, uint8_t *buf,
			     uint16_t buf_size, uint8_t role_id)
{
	if (buf_size <= sizeof(packet_header_t) || buf == NULL) {
		// LOG_ERR("invalid buffer (%p), size (%d)", buf, buf_size);
		return -EINVAL;
	}

	packet_unpacker->buf = buf;
	packet_unpacker->buf_size = buf_size;
	packet_unpacker->role_id = role_id;
	packet_unpacker->p_header = (packet_header_t *)packet_unpacker->buf;
	packet_unpacker->state = FIND_HEADER;
	packet_unpacker->handler = NULL;
	packet_unpacker->search_pos = 0;
	packet_unpacker->write_pos = 0;
	packet_unpacker->max_len = 5120;
	packet_unpacker->timeout = 3000;
	return 0;
}

int packet_unpacker_reset(packet_unpacker_t *packet_unpacker)
{
	packet_unpacker->write_pos = 0;
	packet_unpacker->search_pos = 0;
	packet_unpacker->state = FIND_HEADER;
	return 0;
}

int packet_unpacker_enqueue(packet_unpacker_t *unpacker,
				const uint8_t *data, uint16_t size)
{
	if (unpacker->write_pos + size > unpacker->buf_size) {
		// LOG_DBG("data will overflow, buf size %d, size %d  len %d\n",
		// 	unpacker->buf_size, size, unpacker->write_pos);
		return -ENOMEM;
	}

	memcpy(unpacker->buf + unpacker->write_pos, data, size);
	unpacker->write_pos += size;
	return 0;
}

static void unpacker_remove_ahead_bytes(packet_unpacker_t *unpacker,
					uint16_t nbytes)
{
	unpacker->write_pos = (unpacker->write_pos > nbytes) ?
				      (unpacker->write_pos - nbytes) :
					    0;
	memmove(unpacker->buf, unpacker->buf + nbytes, unpacker->write_pos);
	unpacker->search_pos = 0;
	unpacker->state = FIND_HEADER;
	return;
}

static bool unpacker_timeout(packet_unpacker_t *unpacker)
{
	uint32_t cur_ts = xTaskGetTickCount();

	if (cur_ts - unpacker->found_header_ts > unpacker->timeout) {
		return true;
	} else {
		return false;
	}
}

void packet_unpacker_process(packet_unpacker_t *unpacker)
{
	while (unpacker->write_pos > unpacker->search_pos) {
		unpacker->search_pos++;
		const packet_header_t *header = unpacker->p_header;
		switch (unpacker->state) {
		case FIND_HEADER:
			if (unpacker->write_pos >= sizeof(packet_header_t)) {
				/* find magic number */
				if (memcmp(unpacker->buf,
					   PACKET_HEADER_MAGIC_NUMS,
					   PACKET_HEADER_MAGIC_SIZE) == 0) {
					/* find packet header */
					if (is_packet_header(header) && unpacker->search_pos == 1) {
						unpacker->state = FIND_PAYLOAD;
						unpacker->found_header_ts = xTaskGetTickCount();
					} else {
						/* remove found magic numbers */
						unpacker_remove_ahead_bytes(
							unpacker,
							PACKET_HEADER_MAGIC_SIZE);
					}
				} else {
					/* remove first byte */
					unpacker_remove_ahead_bytes(unpacker,
								    1);
				}
			}
			break;

		case FIND_PAYLOAD: {
			/* header + payload + crc16 */
			size_t packet_size = sizeof(packet_header_t) +
					     header->payload_length + 2;
			if (unpacker->write_pos >= packet_size) {
				uint16_t calc_crc = calc_crc16_long_table(
					unpacker->buf, packet_size - 2);

				uint16_t crc16 =
					unpacker->buf[packet_size - 2] +
					(((uint16_t)unpacker
						  ->buf[packet_size - 1])
					 << 8);
				// LOG_DBG("calc crc %x , buf crc %x\n", calc_crc,
				// 	crc16);
				if (calc_crc == crc16) {
					unpacker->state = FIND_SUCCESS;
				} else {
					/* remove found header */
					unpacker_remove_ahead_bytes(
						unpacker,
						sizeof(packet_header_t));
				}
			} else if (packet_size > unpacker->max_len ||
					   unpacker_timeout(unpacker)) {
				unpacker_remove_ahead_bytes(unpacker,
											sizeof(packet_header_t));
			}
		} break;

		case FIND_SUCCESS: {
			uint8_t src_id = 0xff;
			uint8_t dst_id = 0xff;
#if (PACKET_LONG_HEADER)
			src_id = header->src_id;
			dst_id = header->dst_id;
#endif
			uint16_t packet_len = header->payload_length +
					      sizeof(packet_header_t) + 2;
			if (unpacker->handler != NULL) {
				unpacker->handler(src_id, dst_id, unpacker->buf,
						  packet_len);
			}
			/* remove found packet */
			unpacker_remove_ahead_bytes(unpacker, packet_len);
			// LOG_DBG("found a packet. buf len %d, pos %d\n",
			// 	unpacker->write_pos, unpacker->search_pos);
		} break;

		default:
			break;
		}
	}
}

static int is_packet_header(const packet_header_t *header)
{
	/* TODO need finished it */
	return true;
}

void packet_unpacker_register_handler(packet_unpacker_t *packet_unpacker,
				      packet_unpacker_handler_t handler)
{
	packet_unpacker->handler = handler;
	return;
}

void packet_unpacker_timeout_set(packet_unpacker_t *packet_unpacker, uint32_t ms)
{
	packet_unpacker->timeout = ms;
}

void packet_unpacker_max_len_set(packet_unpacker_t *packet_unpacker, uint32_t len)
{
	packet_unpacker->max_len = len;
}