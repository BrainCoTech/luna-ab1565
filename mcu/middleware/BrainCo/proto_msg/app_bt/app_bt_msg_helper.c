/**
 * @file app_bt_msg_helper.c
 * @author gaoxiang (gaoxiang89ly@gmail.com)
 * @brief
 * @version 0.1
 * @date 2021-11-12
 *
 * @copyright Copyright (c) 2021  BrainCo Inc.
 *
 */

#include "app_bt_msg_helper.h"

#include <errno.h>
#include <stdio.h>


#if defined(HAL_DVFS_MODULE_ENABLED)
#include "hal_dvfs.h"
#define PB_MSG_CPU_FREQ (104000)
#endif

#define FREERTOS 1
#ifdef ZEPHYR
#include <logging/log.h>
#include <zephyr.h>

LOG_MODULE_REGISTER(app_main, LOG_LEVEL_DBG);

#define malloc(size) k_malloc(size)
#define free(ptr)    k_free(ptr)
#else
#ifdef FREERTOS
#include "FreeRTOS.h"
#include "task.h"
#define malloc(size) pvPortMalloc(size)
#define free(ptr)    vPortFree(ptr)
#endif
#define LOG_DBG(...) printf(__VA_ARGS__);printf("\n")
#define LOG_INF(...) printf(__VA_ARGS__);printf("\n")
#define LOG_ERR(...) printf(__VA_ARGS__);printf("\n")
#endif

int app_bt_msg_encode(packet_packer_t *packer, AppBt *msg) {
    uint16_t payload_len = app_bt__get_packed_size(msg);
    LOG_DBG("payload size %d, header size %ld", payload_len,
            sizeof(packet_header_t));
    if (payload_len == 0) {
        LOG_DBG("message size is zero");
        return -ENOMEM;
    }

    packet_packer_alloc(packer, payload_len);
    if (packer->packet == NULL) {
        LOG_INF("packet alloc failed, %d", payload_len);
        return -ENOMEM;
    }

    /* fill header */
    packet_header_t *header = &packer->packet->header;
    header->header_version = HEADER_VERSION;
    header->project_id = PROJECT_ID;
    header->payload_version = 1;
    header->dst_id = BLUETOOTH_ID;
    header->src_id = APP_ID;

    /* fill payload */
    app_bt__pack(msg, packer->packet->payload);

    /* fill crc16 */
    uint16_t crc16 = calc_crc16_long_table((uint8_t *)packer->packet,
                                           packer->packet_size - 2);
    packer->crc16[1] = 0xff & (crc16 >> 8);
    packer->crc16[0] = 0xff & (crc16 >> 0);

    return 0;
}

int bt_app_msg_encode(packet_packer_t *packer, BtApp *msg) {
    uint16_t payload_len = bt_app__get_packed_size(msg);
    LOG_DBG("bt app encode, payload size %d, header size %ld ", payload_len,
            sizeof(packet_header_t));
    if (payload_len == 0) {
        LOG_DBG("message size is zero");
        return -ENOMEM;
    }

    packet_packer_alloc(packer, payload_len);
    if (packer->packet == NULL) {
        LOG_INF("packet alloc failed, %d", payload_len);
        return -ENOMEM;
    }

    /* fill header */
    packet_header_t *header = &packer->packet->header;
    header->header_version = HEADER_VERSION;
    header->project_id = PROJECT_ID;
    header->payload_version = 1;
    header->dst_id = APP_ID;
    header->src_id = BLUETOOTH_ID;

    /* fill payload */
    bt_app__pack(msg, packer->packet->payload);

    /* fill crc */
    uint16_t crc16 = calc_crc16_long_table((uint8_t *)packer->packet,
                                           packer->packet_size - 2);
    packer->crc16[1] = 0xff & (crc16 >> 8);
    packer->crc16[0] = 0xff & (crc16 >> 0);
    return 0;
}

int app_bt_msg_decode(const uint8_t *buf, uint16_t size) {
    AppBt *msg;
    msg = app_bt__unpack(NULL, size, buf);
    if (msg) {
        if (msg->board_cfg) {
            bt_board_config(msg->msg_id, msg->board_cfg);
        }
        if (msg->music_sync) {
            music_config_handler(msg->msg_id, msg->music_sync);
        }
        if (msg->music_data) {
            music_data_handler(msg->msg_id, msg->music_data);
        }
        if (msg->music_solution) {
            music_solution_handler(msg->msg_id, msg->music_solution);
        }
        
        app_bt_config(msg->msg_id, msg);
    
        app_bt__free_unpacked(msg, NULL);
    }

    return 0;
}

int bt_app_msg_decode(const uint8_t *buf, uint16_t size) {
    BtApp *msg;
    msg = bt_app__unpack(NULL, size, buf);
    if (msg) {
        if (msg->board_cfg_resp) {
        }
       bt_app__free_unpacked(msg, NULL);
    }
    return 0;
}

__attribute__((weak)) int app_bt_config(uint32_t msg_id, AppBt *msg) {
    LOG_ERR("app_bt_config  is a weak function");
    return 0;
}

__attribute__((weak)) void bt_board_config(uint32_t msg_id,
                                           BoardConfig *board_cfg) {
    LOG_ERR("bt_board_config  is a weak function");
    return;
}

__attribute__((weak)) void music_config_handler(uint32_t msg_id,
                                                MusicSync *music_sync) {
    LOG_ERR("music_config_handler  is a weak function");
    return;
}

__attribute__((weak)) void music_data_handler(uint32_t msg_id,
                                              MusicData *music_data) {
    LOG_ERR("music_data_handler  is a weak function");
    return;
}

__attribute__((weak)) void music_solution_handler(uint32_t msg_id,
                                              MusicSolution *music_solution) {
    LOG_ERR("music_data_handler  is a weak function");
    return;
}