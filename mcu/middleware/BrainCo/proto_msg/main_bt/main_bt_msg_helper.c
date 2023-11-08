
#include "main_bt_msg_helper.h"

#include <errno.h>
#include <stdbool.h>
#include <stdio.h>

#define FREERTOS 1

#ifdef ZEPHYR
#include <logging/log.h>
#include <zephyr.h>

LOG_MODULE_REGISTER(main_bt, LOG_LEVEL_DBG);

#define malloc(size) k_malloc(size)
#define free(ptr) k_free(ptr)
#else
#ifdef FREERTOS
#include "FreeRTOS.h"
#include "task.h"
#define malloc(size) pvPortMalloc(size)
#define free(ptr) vPortFree(ptr)
#endif
#define LOG_DBG(...)     \
    printf(__VA_ARGS__); \
    printf("\n")
#define LOG_INF(...)     \
    printf(__VA_ARGS__); \
    printf("\n")
#define LOG_ERR(...)     \
    printf(__VA_ARGS__); \
    printf("\n")
#endif

#include "syslog.h"

log_create_module(main_bt, PRINT_LEVEL_INFO);

int main_bt_msg_encode(packet_packer_t *packer, MainBt *msg) {
    uint16_t payload_len = main_bt__get_packed_size(msg);

    if (packet_packer_alloc(packer, payload_len) < 0) return -ENOMEM;
    /* fill header */
    packet_header_t *header = &packer->packet->header;
    header->header_version = HEADER_VERSION;
    header->project_id = PROJECT_ID;
    header->payload_version = 1;
    header->dst_id = BLUETOOTH_ID;
    header->src_id = MAIN_CONTROLLER_ID;

    /* fill payload */
    main_bt__pack(msg, packer->packet->payload);

    /* fill crc16 */
    uint16_t crc16 = calc_crc16_long_table((uint8_t *)packer->packet,
                                           packer->packet_size - 2);
    packer->crc16[1] = 0xff & (crc16 >> 8);
    packer->crc16[0] = 0xff & (crc16 >> 0);
    return 0;
}

int bt_main_msg_decode(const uint8_t *buf, uint16_t size) {
    BtMain *msg;
    msg = bt_main__unpack(NULL, size, buf);

    if (msg) {
        sys_config(msg->msg_id, msg->sys_cfg);

        bt_main__free_unpacked(msg, NULL);
    }

    return 0;
}

int bt_main_msg_encode(packet_packer_t *packer, BtMain *msg) {
    uint16_t payload_len = bt_main__get_packed_size(msg);

    if (packet_packer_alloc(packer, payload_len) < 0) return -ENOMEM;

    /* fill header */
    packet_header_t *header = &packer->packet->header;
    header->header_version = HEADER_VERSION;
    header->project_id = PROJECT_ID;
    header->payload_version = 1;
    header->dst_id = MAIN_CONTROLLER_ID;
    header->src_id = BLUETOOTH_ID;

    /* fill payload */
    bt_main__pack(msg, packer->packet->payload);

    /* fill crc16 */
    uint16_t crc16 = calc_crc16_long_table((uint8_t *)packer->packet,
                                           packer->packet_size - 2);
    packer->crc16[1] = 0xff & (crc16 >> 8);
    packer->crc16[0] = 0xff & (crc16 >> 0);
    return 0;
}

int main_bt_msg_decode(const uint8_t *buf, uint16_t size) {
    MainBt *msg;
    msg = main_bt__unpack(NULL, size, buf);
    if (msg) {
        if (msg->audio_cfg) {
            audio_config(msg->msg_id, msg->audio_cfg);
        }
        if (msg->prompt_cfg) {
            prompt_config(msg->msg_id, msg->prompt_cfg);
        }
        if (msg->volume_cfg) {
            volume_config(msg->msg_id, msg->volume_cfg);
        }

        main_bt_config(msg);
        if (msg->sys_cfg_resp) {
            /* check time */
        }

        if (msg->board_cfg) {
             main_bt_board_config(msg->msg_id, msg->board_cfg);
        }

        if (msg->play_mode_cfg) {
            play_mode_config(msg->msg_id, msg->play_mode_cfg);
        }

        if (msg->music_file) {
            main_bt_music_file_info(msg->msg_id, msg->music_file);
        }

        if (msg->at_cmd_resp) {
            main_bt_at_cmd_resp(msg->msg_id, msg->at_cmd_resp);
        }
        
        main_bt__free_unpacked(msg, NULL);
    }

    return 0;
}

__attribute__((weak)) void audio_config(uint32_t msg_id, AudioConfig *cfg) {
    // LOG_ERR("audio_config  is a weak function");
}
__attribute__((weak)) void prompt_config(uint32_t msg_id, PromptConfig *cfg) {
    // LOG_ERR("prompt_config  is a weak function");
}
__attribute__((weak)) void volume_config(uint32_t msg_id, VolumeConfig *cfg) {
    // LOG_ERR("volume_config  is a weak function");
}

__attribute__((weak)) void sys_config(uint32_t msg_id, SysConfig *cfg) {
    // LOG_ERR("sys_config  is a weak function");
}
__attribute__((weak)) void main_bt_config(MainBt *msg) {}


__attribute__((weak)) void main_bt_board_config(uint32_t msg_id, BoardConfig *cfg) {
    // LOG_ERR("audio_config  is a weak function");
}                                                   


__attribute__((weak)) void play_mode_config(uint32_t msg_id, PlayModeConfig *cfg) {
    // LOG_ERR("audio_config  is a weak function");
}  

__attribute__((weak)) void main_bt_music_file_info(uint32_t msg_id, MusicFileInfo *cfg) {
    // LOG_ERR("audio_config  is a weak function");
}  

__attribute__((weak)) void main_bt_at_cmd_resp(uint32_t msg_id, AtCommandResp *resp) {
    // LOG_ERR("audio_config  is a weak function");
}  