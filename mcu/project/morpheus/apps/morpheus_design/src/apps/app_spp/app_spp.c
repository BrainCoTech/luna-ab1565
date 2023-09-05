#include "app_spp.h"

#include "FreeRTOS.h"
#include "app_uart.h"
#include "apps_config_event_list.h"
#include "apps_config_state_list.h"
#include "apps_debug.h"
#include "apps_events_event_group.h"
#include "ble_us.h"
#include "bt_app_common.h"
#include "bt_device_manager.h"
#include "bt_sink_srv.h"
#include "hal_rtc.h"
#include "main_controller.h"
#include "morpheus.h"
#include "nvkey.h"
#include "nvkey_id_list.h"
#include "packet/packet.h"
#include "packet/packet_packer.h"
#include "packet/packet_unpacker.h"
#include "proto_msg/app_bt/app_bt_msg_helper.h"
#include "queue.h"
#include "syslog.h"
#include "task.h"
#include "timers.h"
#include "ui_shell_manager.h"

log_create_module(APP_SPP, PRINT_LEVEL_INFO);

static packet_unpacker_t spp_unpacker;

static QueueHandle_t spp_rx_queue;

#define SPP_RX_QUEUE_SIZE 32
#define SPP_RX_UNPACKER_BUF_SIZE (4096 + 128)


static void packet_unpacker_handler(int32_t src_id, int32_t dst_id,
                                       uint8_t *data, uint16_t size) {
    const packet_t *packet = (packet_t *)data;
    uint8_array_t msg;
    if (dst_id < BLUETOOTH_ID) {
        LOG_MSGID_I(APP_SPP, "message dst error", 0);
    } else if (dst_id == BLUETOOTH_ID) {
        LOG_MSGID_I(APP_SPP, "decode message from app", 0);
        app_bt_msg_decode(packet->payload, packet->header.payload_length);
    } else {
        LOG_MSGID_I(APP_SPP, "forward app message to main", 0);
        msg.size = size;
        msg.data = pvPortMalloc(size);
        if (msg.data) {
            memcpy(msg.data, data, size);
            app_uart_enqueue(&msg);
        }
    }
}


void app_spp_rx_task() {
    uint8_array_t rx;

    spp_rx_queue = xQueueCreate(SPP_RX_QUEUE_SIZE, sizeof(uint8_array_t));

    packet_unpacker_init(&spp_unpacker, SPP_RX_UNPACKER_BUF_SIZE, 1);
    packet_unpacker_register_handler(&spp_unpacker, packet_unpacker_handler);


    while (1) {
        if (spp_rx_queue == NULL) {
            vTaskDelay(100);
            spp_rx_queue = xQueueCreate(SPP_RX_QUEUE_SIZE, sizeof(uint8_array_t));
            continue;
        }
        
        if (xQueueReceive(spp_rx_queue, &rx, 100) == pdTRUE) {
            packet_unpacker_enqueue(&spp_unpacker, rx.data, rx.size);
            packet_unpacker_process(&spp_unpacker);
            vPortFree(rx.data);
        }
    }

    vQueueDelete(spp_rx_queue);
}


void app_spp_enqueue(uint8_array_t *msg) {
    if (spp_rx_queue) {
        LOG_HEXDUMP_I(APP_SPP, "rx data", msg->data, msg->size);
        xQueueSend(spp_rx_queue, msg, pdMS_TO_TICKS(20));
    } else {
        if (msg->data) vPortFree(msg->data);
    }
}