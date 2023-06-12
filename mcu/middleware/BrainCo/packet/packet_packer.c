/**
 * @file packet_packer.c
 * @author gaoxiang (gaoxiang89ly@gmail.com)
 * @brief
 * @version 0.1
 * @date 2021-11-11
 *
 * @copyright Copyright (c) 2021  BrainCo Inc.
 *
 */

#include "packet/packet_packer.h"

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include "crc/crc16.h"

#ifndef FREERTOS
#define FREERTOS 1
#endif
#ifdef ZEPHYR
#include <logging/log.h>
#include <zephyr.h>

LOG_MODULE_REGISTER(packer, LOG_LEVEL_INF);

#define malloc(size) k_malloc(size)
#define free(ptr)    k_free(ptr)
#else
#ifdef FREERTOS
#include "FreeRTOS.h"
#include "task.h"
#define malloc(size) pvPortMalloc(size)
#define free(ptr)    vPortFree(ptr)

#include "apps_debug.h"

log_create_module(packer, PRINT_LEVEL_INFO);
#endif
#define LOG_DBG(...) printf(__VA_ARGS__)
#endif

int packet_packer_alloc(packet_packer_t *packer, uint16_t payload_len) {
    packer->packet_size = sizeof(packet_t) + payload_len + 2 - 1;

    packer->packet = (packet_t *)malloc(packer->packet_size);
    if (packer->packet == NULL) {
        LOG_MSGID_I(packer, "packer allocate failed", 0);
        return -ENOMEM;
    }
    uint8_t *buf = (uint8_t *)packer->packet;
    /* assign crc16 pointer */
    packer->crc16 = &buf[packer->packet_size - 2];
    memcpy(packer->packet->header.magic_num, PACKET_HEADER_MAGIC_NUMS,
           PACKET_HEADER_MAGIC_SIZE);
    packer->packet->header.payload_length = payload_len;
    LOG_MSGID_I(packer, "packer  success", 0);

    // LOG_DBG("packet size %d, packet pointer %p\n", packer->packet_size, packer->packet);
    return 0;
}

void packet_packer_free(packet_packer_t *packer) {
    // LOG_DBG("free %p\n", packer);
    free(packer->packet);
    return;
}
