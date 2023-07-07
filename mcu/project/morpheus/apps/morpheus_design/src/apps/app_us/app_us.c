#include "app_us.h"

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

log_create_module(APP_US, PRINT_LEVEL_INFO);

static packet_unpacker_t us_unpacker;

static QueueHandle_t us_tx_queue;
static QueueHandle_t us_rx_queue;

#define US_TX_QUEUE_SIZE 64
#define US_RX_QUEUE_SIZE 64

#define QUEUE_SEND_TIMEOUT 40

#define US_RX_UNPACKER_BUF_SIZE (4096 + 128)

#define UNPACKER_TIMER_NAME "unpacker"
#define UNPACKER_TIMER_ID 3
#define UNPACKER_TIMER_INTERVAL (10000)
TimerHandle_t m_unpacker_timer = NULL;

static void unpacker_cb_function(TimerHandle_t xTimer) {
    LOG_MSGID_I(APP_US, "timeout, reset unpacker", 0);
    packet_unpacker_reset(&us_unpacker);
    if (m_unpacker_timer) {
        xTimerStop(m_unpacker_timer, 0);
    }
}

static void packet_unpacker_handler_us(int32_t src_id, int32_t dst_id,
                                       uint8_t *data, uint16_t size) {
    const packet_t *packet = (packet_t *)data;
    uint8_array_t msg;
    if (dst_id < BLUETOOTH_ID) {
        LOG_MSGID_I(APP_US, "message dst error", 0);
    } else if (dst_id == BLUETOOTH_ID) {
        LOG_MSGID_I(APP_US, "decode message from app", 0);
        app_bt_msg_decode(packet->payload, packet->header.payload_length);
    } else {
        LOG_MSGID_I(APP_US, "forward app message to main", 0);
        msg.size = size;
        msg.data = pvPortMalloc(size);
        if (msg.data) {
            memcpy(msg.data, data, size);
            app_uart_enqueue(&msg);
        }
    }
}

void app_us_tx_task() {
    uint8_array_t tx;
    int32_t m_mtu;

    uint32_t size = 0;
    uint32_t pos = 0;
    uint32_t retry_count = 0;

    us_tx_queue = xQueueCreate(US_TX_QUEUE_SIZE, sizeof(uint8_array_t));

    while (1) {
        if (us_tx_queue) {
            if (xQueueReceive(us_tx_queue, &tx, portMAX_DELAY) == pdTRUE) {
                size = 0;
                pos = 0;
                retry_count = 0;
                m_mtu = ble_us_get_mtu() - 3;
                LOG_MSGID_I(APP_US, "mtu %d", 1, m_mtu);

                if ((tx.data != NULL) && (tx.size != 0)) {
                    do {
                        if (m_mtu == 0) break;

                        size = (tx.size <= m_mtu) ? tx.size : m_mtu;

                        if (ble_us_send_data(tx.data + pos, size) == 0) {
                            pos += size;
                            tx.size -= size;
                            retry_count = 0;
                        } else {
                            vTaskDelay(pdMS_TO_TICKS(1));
                            if (retry_count++ > 10) break;
                        }
                    } while (tx.size > 0);

                    vPortFree(tx.data);
                }
            } else {
                LOG_MSGID_I(APP_US, "recieve from app_us failed", 0);
            }
        } else {
            us_tx_queue = xQueueCreate(US_TX_QUEUE_SIZE, sizeof(uint8_array_t));
            vTaskDelay(100);
        }
    }

    vQueueDelete(us_tx_queue);
}

int32_t us_us_receive_data_cb(const uint8_t *data, uint16_t size) {
    uint8_array_t msg;
    msg.data = pvPortMalloc(size);
    msg.size = size;
    LOG_MSGID_I(APP_US, "received %d data", 1, size);
    if (msg.data == NULL) {
        LOG_MSGID_E(APP_US, "malloc failed", 0);
        return -1;
    }
    memcpy(msg.data, data, size);
    if (us_rx_queue) {
        xQueueSend(us_rx_queue, &msg, pdMS_TO_TICKS(QUEUE_SEND_TIMEOUT));
    }
    return 0;
}

void app_us_rx_task() {
    uint8_array_t rx;

    us_rx_queue = xQueueCreate(US_RX_QUEUE_SIZE, sizeof(uint8_array_t));

    ble_us_init(us_us_receive_data_cb);
    packet_unpacker_init(&us_unpacker, US_RX_UNPACKER_BUF_SIZE, 1);
    packet_unpacker_register_handler(&us_unpacker, packet_unpacker_handler_us);

    m_unpacker_timer = xTimerCreate(
        UNPACKER_TIMER_NAME, UNPACKER_TIMER_INTERVAL / portTICK_PERIOD_MS,
        pdTRUE, UNPACKER_TIMER_ID, unpacker_cb_function);

    while (1) {
        if (us_rx_queue != NULL) {
            if (xQueueReceive(us_rx_queue, &rx, 100) == pdTRUE) {
                packet_unpacker_enqueue(&us_unpacker, rx.data, rx.size);
                packet_unpacker_process(&us_unpacker);
                vPortFree(rx.data);
            }

            if (!app_us_notification_enable())
                packet_unpacker_reset(&us_unpacker);

        } else {
            LOG_MSGID_I(APP_US, "us service rx task deleted", 0);
            vTaskDelete(NULL);
        }
    }

    vQueueDelete(us_rx_queue);
}

bool app_us_notification_enable(void) { return ble_us_notification_enable(); }

void app_us_enqueue(uint8_array_t *msg) {
    if (us_tx_queue && app_us_notification_enable()) {
        xQueueSend(us_tx_queue, msg, pdMS_TO_TICKS(20));
    } else {
        if (msg->data) vPortFree(msg->data);
    }
}

void send_msg_to_app(BtApp *msg) {
    packet_packer_t packer;
    uint8_array_t send_to_queue;
    uint8_array_t send_to_usb_queue;

    if (bt_app_msg_encode(&packer, msg) == 0) {
        send_to_queue.size = packer.packet_size;
        send_to_queue.data = pvPortMalloc(send_to_queue.size);
        if (send_to_queue.data) {
            memcpy(send_to_queue.data, packer.packet, send_to_queue.size);
            app_us_enqueue(&send_to_queue);
        }

        send_to_usb_queue.size = packer.packet_size;
        send_to_usb_queue.data = pvPortMalloc(send_to_usb_queue.size);
        if (send_to_usb_queue.data) {
            memcpy(send_to_usb_queue.data, packer.packet,
                   send_to_usb_queue.size);
            app_usb_enqueue(&send_to_usb_queue);
        }
        packet_packer_free(&packer);
    }
}
int app_bt_config(uint32_t msg_id, AppBt *msg) {
    BtApp send_msg = BT_APP__INIT;

    send_msg.msg_id = msg_id;

    if (msg->sync_time > 0) {
    }

    if (msg->power_off) {
        ui_shell_send_event(
            true, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_KEY,
            (0x18 & 0xFF) | ((0x52 & 0xFF) << 8), NULL, 0, NULL, 0);
    }

    if (msg->clear_pair_info) {
        /* entry pairing mode, unpair all device */
        ui_shell_send_event(true, EVENT_PRIORITY_HIGH, EVENT_GROUP_UI_SHELL_KEY,
                            (KEY_POWER_OFF & 0xFF) | ((0x52 & 0xFF) << 8), NULL,
                            0, NULL, 0);
    }

    if (msg->music_sync_progress) {
        LOG_MSGID_I(APP_US, "music_sync_progress", 0);
#ifdef BRC_LOCAL_MUSIC_ENABLE
        send_sync_progress_to_app(msg_id);
#endif
    }

    if (msg->music_info) {
        // set_music_type(msg->music_info->focus || msg->music_info->playing);
    }

    send_msg_to_app(&send_msg);

    return 0;
}

void bt_board_config(uint32_t msg_id, BoardConfig *board_cfg) {
    BtApp msg = BT_APP__INIT;
    BoardConfigResp board_resp = BOARD_CONFIG_RESP__INIT;
    msg.msg_id = msg_id;

    bool dut_config = false;
    uint32_t dut_size = sizeof(bool);

    bt_bd_addr_t *local_addr;
    local_addr = bt_device_manager_get_local_address();
    bt_bd_addr_t *remote_addr = bt_device_manager_remote_get_dev_by_seq_num(1);
    char addr_str[13] = {0};
    char remote_addr_str[13] = {0};
    memset(addr_str, 0, 13);
    memset(remote_addr_str, 0, 13);
    snprintf((char *)addr_str, sizeof(addr_str), "%.2X%.2X%.2X%.2X%.2X%.2X",
             (*local_addr)[5], (*local_addr)[4], (*local_addr)[3],
             (*local_addr)[2], (*local_addr)[1], (*local_addr)[0]);
    if (remote_addr != NULL) {
        snprintf((char *)remote_addr_str, sizeof(remote_addr_str),
                 "%.2X%.2X%.2X%.2X%.2X%.2X", (*remote_addr)[5],
                 (*remote_addr)[4], (*remote_addr)[3], (*remote_addr)[2],
                 (*remote_addr)[1], (*remote_addr)[0]);
    }
    if (board_cfg->get_info) {
        msg.board_cfg_resp = &board_resp;
        board_resp.fw_version = FW_VERSION;
        board_resp.model = MODEL;
        // board_resp.build_time = _BUILD_TIME_;
        board_resp.commit_hash = remote_addr_str;
        board_resp.boot_count = 0;
        board_resp.device_name = "Easleep";
        board_resp.mac_addr.data = addr_str;
        board_resp.mac_addr.len = 12;
    }

    if (board_cfg->model) {
        /* set model*/
    }

    if (board_cfg->sn) {
        /* set model*/
    }

    if (board_cfg->mac_addr.len == 12) {
        bt_bd_addr_t addr;
        bt_addr_from_str(board_cfg->mac_addr.data, &addr);
        bt_connection_manager_device_local_info_store_local_address(&addr);
        bt_device_manager_db_flush_all(BT_DEVICE_MANAGER_DB_FLUSH_BLOCK);
    } else if (board_cfg->mac_addr.len == 6) {
        bt_bd_addr_t addr;
        for (int i = 0, j = 5; i < 6; i++) {
            addr[j--] = board_cfg->mac_addr.data[i];
        }
        bt_connection_manager_device_local_info_store_local_address(&addr);
        LOG_MSGID_I(APP_US, "set address %x%x%x%x%x%x", 6, addr[0], addr[1],
                    addr[2], addr[3], addr[4], addr[5]);
        bt_device_manager_db_flush_all(BT_DEVICE_MANAGER_DB_FLUSH_BLOCK);
    }

    if (board_cfg->device_name) {
        /* set device name */
    }

    if (board_cfg->ship_mode) {
        dut_config = false;
        nvkey_write_data(NVKEYID_BT_DUT_ENABLE, (uint8_t *)(&dut_config),
                         dut_size);
        // 设置标志
        ship_mode_flag_set(1);
        ui_shell_send_event(true, EVENT_PRIORITY_HIGH, EVENT_GROUP_UI_SHELL_KEY,
                            (KEY_DISCOVERABLE & 0xFF) | ((0x52 & 0xFF) << 8),
                            NULL, 0, NULL, 0);
    }

    send_msg_to_app(&msg);
}

int send_power_off_flag_to_app(void) {
    BtApp msg = BT_APP__INIT;
    msg.msg_id = 66;
    msg.power_off = true;

    send_msg_to_app(&msg);

    return 0;
}
