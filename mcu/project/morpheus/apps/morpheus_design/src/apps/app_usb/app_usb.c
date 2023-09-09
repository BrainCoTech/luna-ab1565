#include "app_usb.h"

#include "FreeRTOS.h"
#include "app_uart.h"
#include "apps_debug.h"
#include "apps_events_event_group.h"
#include "apps_events_key_event.h"
#include "bt_device_manager.h"
#include "fota_util.h"
#include "main_controller.h"
#include "morpheus.h"
#include "mux.h"
#include "nvkey.h"
#include "nvkey_id_list.h"
#include "packet/packet.h"
#include "packet/packet_packer.h"
#include "packet/packet_unpacker.h"
#include "proto_msg/app_bt/app_bt_msg_helper.h"
#include "queue.h"
#include "race_cmd.h"
#include "race_util.h"
#include "stream_buffer.h"
#include "syslog.h"
#include "task.h"
#include "timers.h"
#include "ui_shell_manager.h"

log_create_module(app_usb, PRINT_LEVEL_INFO);

// 数据头2个字节05 5A,数据长度2个字节最小为02 00,
// 真实数据最小2个字节因为命令由2个字节组成可以不带额外数据(所以整个数据最小6个字节)
#define USB_CMD_KEY_ID_EVENT 0x1101
// #define USB_CMD_KEY_ENTERDUT	0x0300
// #define USB_CMD_KEY_POWEROFF	0x0018
// #define USB_CMD_KEY_FACTORY	0x0095

#define USB_CMD_GET_VERSION 0x1C07
#define USB_CMD_GET_BATTERY 0x0CD6
#define USB_CMD_GET_ADDRESS 0x0CD5
#define USB_CMD_GET_SN 0x0A00
#define USB_CMD_SET_SN 0x0A01
#define CUSTOMER_SN_LEN 0x11
#define USB_CMD_LED_SET 0x0101
#define USB_CMD_FLASH1_GET 0x0102
#define USB_CMD_FLASH2_GET 0x0103
#define USB_CMD_IR_GET 0x0104
#define USB_CMD_RTC_SET 0x0105
#define USB_CMD_RTC_GET 0x0106
#define USB_CMD_MAX30001_GET 0x0107
#define USB_CMD_MAX30001_SET 0x0108
#define USB_CMD_BAT_VOL_GET 0x0109
#define USB_CMD_BAT_NTC_GET 0x010A
#define USB_CMD_CES_SET 0x010B
#define USB_CMD_HW_VER_GET 0x010C
#define USB_CMD_MCU_FW_VER_GET 0x010D
#define USB_CMD_CES_FW_VER_GET 0x010E

#define USB_MUX_PORT_RX_BUF_SIZE 512
#define USB_MUX_PORT_TX_BUF_SIZE 512
#define USB_RX_BUF_SIZE (2048 + 1024)

static mux_port_t m_usb_port = MUX_USB_COM_1;
static mux_handle_t m_usb_handle;
static StreamBufferHandle_t m_rx_stream;
static QueueHandle_t m_tx_queue;
static packet_unpacker_t unpacker;

void usb_mux_event_callback(mux_handle_t handle, mux_event_t event,
                            uint32_t data_len, void *user_data) {
    switch (event) {
        case MUX_EVENT_READY_TO_READ: {
            LOG_MSGID_I(app_usb, "MUX_EVENT_READY_TO_READ", 1);
        } break;
        case MUX_EVENT_READY_TO_WRITE: {
            LOG_MSGID_I(app_usb, "MUX_EVENT_READY_TO_WRITE", 1);
        } break;
        case MUX_EVENT_CONNECTION: {
            LOG_MSGID_I(app_usb, "MUX_EVENT_CONNECTION", 1);
        } break;
        case MUX_EVENT_DISCONNECTION: {
            LOG_MSGID_I(app_usb, "MUX_EVENT_DISCONNECTION", 1);
        } break;
        case MUX_EVENT_WAKEUP_FROM_SLEEP: {
            LOG_MSGID_I(app_usb, "MUX_EVENT_WAKEUP_FROM_SLEEP", 1);
        } break;
        case MUX_EVENT_TRANSMISSION_DONE: {
            LOG_MSGID_I(app_usb, "MUX_EVENT_TRANSMISSION_DONE", 1);
        } break;
        default:
            break;
    }
}

void usb_mux_rx_callback(mux_handle_t *handle, mux_buffer_t buffers[],
                         uint32_t buffers_counter, uint32_t *consume_len,
                         uint32_t *package_len, void *user_data) {
    /* *consume_len and *package_len are the parameters out. */
    *package_len = 0;
    *consume_len = 0;
    BaseType_t xHigherPriorityTaskWoken = pdFALSE;

    LOG_MSGID_I(app_usb, "usb mux buffers counter (%d), buffer size %d", 2,
                buffers_counter, buffers[0].buf_size);

    for (uint32_t i = 0; i < buffers_counter; i++) {
        xStreamBufferSendFromISR(m_rx_stream, buffers[i].p_buf,
                                 buffers[i].buf_size,
                                 &xHigherPriorityTaskWoken);
        *consume_len += buffers[i].buf_size;
    }

    if (xHigherPriorityTaskWoken != pdFALSE) {
        /* 通知FreeRTOS在ISR退出时进行任务调度，以便运行优先级更高的就绪任务 */
        portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
    }
}

void app_usb_init(void) {
    mux_status_t status;

    mux_port_setting_t port_setting = {
        .rx_buffer_size = USB_MUX_PORT_RX_BUF_SIZE,
        .tx_buffer_size = USB_MUX_PORT_TX_BUF_SIZE};

    mux_protocol_t protocol = {.tx_protocol_callback = NULL,
                               .rx_protocol_callback = usb_mux_rx_callback,
                               .user_data = NULL};

    m_tx_queue = xQueueCreate(128, sizeof(uint8_array_t));
    m_rx_stream = xStreamBufferCreate(USB_RX_BUF_SIZE, sizeof(char));

    m_usb_port = MUX_USB_COM_1;
    status = mux_init(m_usb_port, &port_setting, &protocol);
    if (status != MUX_STATUS_OK) {
        LOG_MSGID_I(app_usb, "usb mux init failed(%d)", 2, status);
        return;
    }

    status = mux_open(m_usb_port, "app_usb", &m_usb_handle,
                      usb_mux_event_callback, NULL);
    if (status != MUX_STATUS_OK) {
        LOG_MSGID_I(app_usb, "usb mux open failed(%d)", 2, status);
        return;
    }

    LOG_MSGID_I(app_usb, "usb mux open success", 1);
}

static void packet_unpacker_handler(int32_t src_id, int32_t dst_id,
                                    uint8_t *data, uint16_t size) {
    const packet_t *packet = (packet_t *)data;
    uint8_array_t msg;
    if (dst_id < BLUETOOTH_ID) {
        LOG_MSGID_I(app_usb, "message dst error", 0);
    } else if (dst_id == BLUETOOTH_ID) {
        LOG_MSGID_I(app_usb, "decode message from app", 0);
        app_bt_msg_decode(packet->payload, packet->header.payload_length);
    } else {
        LOG_MSGID_I(app_usb, "forward app message to main", 0);
        msg.size = size;
        msg.data = pvPortMalloc(size);
        if (msg.data) {
            memcpy(msg.data, data, size);
            app_uart_enqueue(&msg);
        }
    }
}

static void usb_race_key_app_event_send(uint16_t param) {
    ui_shell_status_t status = 0;

    APPS_LOG_MSGID_I("...usb_race_key_app_event_send :%x", 1, param);

    uint16_t *p_key_action = (uint16_t *)pvPortMalloc(sizeof(uint16_t));

    if (p_key_action) {
        *p_key_action = param;
        /* The extra_data of the event is key action. */
        status = ui_shell_send_event(
            false, EVENT_PRIORITY_MIDDLE, EVENT_GROUP_UI_SHELL_KEY,
            INVALID_KEY_EVENT_ID, p_key_action, sizeof(uint16_t), NULL, 0);

        if (UI_SHELL_STATUS_OK != status) {
            vPortFree(p_key_action);
        }
    }
}

static bool wait_factory_cmd_resp;
static bool factory_cmd_busy;
static uint8_t resp_str[64];
static AtCommandResp wait_cmd_resp = {
    .cmd = AT__CMD__UNUSED,
    .status = 0,
    .value1 = 0,
    .value2 = resp_str,
};

void main_bt_at_cmd_resp(uint32_t msg_id, AtCommandResp *resp) {
    if (resp->cmd == wait_cmd_resp.cmd) {
        wait_factory_cmd_resp = false;
        wait_cmd_resp.status = resp->status;
        wait_cmd_resp.value1 = resp->value1;
        strcpy(wait_cmd_resp.value2, resp->value2);
    }
}

int send_factory_cmd_to_main(AtCommand *cmd) {
    int ret = 0;
    BtMain msg = BT_MAIN__INIT;
    static uint32_t msg_id = 0;
    int count = 0;

    msg.msg_id = msg_id++;
    msg.at_cmd = cmd;

    /* 保存当前的命令 */
    wait_cmd_resp.cmd = cmd->cmd;

    if (factory_cmd_busy) {
        return -1;
    }
    factory_cmd_busy = true;

    send_msg_to_main_controller(&msg);
    wait_factory_cmd_resp = true;
    while (wait_factory_cmd_resp || count++ < 100) {
        vTaskDelay(100);
    }

    if (wait_factory_cmd_resp) {
    } else {
        return -2;
    }

    return 0;
}

bool usb_race_app_event_respond(uint8_t *p_buf, uint32_t buf_size) {
    bool cmdFlag = true;
    uint32_t send_done_data_len = 0;
    uint8_t databuf[48];
    mux_buffer_t mux_buff;

    // 数据头2个字节05 5A,数据长度2个字节最小为02 00,
    // 真实数据最小2个字节因为命令由2个字节组成可以不带额外数据(所以整个数据最小6个字节)
    if ((p_buf != NULL) && ((buf_size >= 6) && ((4 + p_buf[2]) == buf_size)) &&
        (0x05 == p_buf[0]) && (0x5A == p_buf[1])) {
        uint16_t cmd = (p_buf[5] << 8) + p_buf[4];

        LOG_MSGID_I(app_usb, "...app usb data for production test %x", cmd);

        memset((void *)databuf, 0x0, 48);
        memcpy(databuf, p_buf, buf_size);

        if ((USB_CMD_KEY_ID_EVENT == cmd) && (buf_size == 8)) {
            databuf[1] = 0x5B;
            databuf[2] = 0x03;

            usb_race_key_app_event_send((uint16_t)((p_buf[7] << 8) + p_buf[6]));
        } else if ((USB_CMD_GET_VERSION == cmd) && (buf_size == 7)) {
            databuf[1] = 0x5D;
            databuf[7] = 0x00;

            {
                int32_t ret = RACE_ERRCODE_FAIL;
                uint8_t version_len = 0;
                uint8_t version[FOTA_VERSION_MAX_SIZE] = {0};

                ret = fota_version_get(version, FOTA_VERSION_MAX_SIZE,
                                       FOTA_VERSION_TYPE_STORED);

                if (FOTA_ERRCODE_SUCCESS == ret) {
                    version_len = strlen((const char *)version);

                    databuf[8] = version_len;
                    databuf[2] = version_len + 5;

                    if (version_len) {
                        memcpy(&databuf[9], version, version_len);
                    }
                }
            }
        } else if ((USB_CMD_GET_BATTERY == cmd) && (buf_size == 7)) {
            uint8_t battery_level = race_get_battery_level();

            databuf[1] = 0x5D;
            databuf[2] = 0x05;
            databuf[8] = battery_level;
        } else if ((USB_CMD_GET_ADDRESS == cmd) && (buf_size == 7)) {
            bt_bd_addr_t *addr = bt_device_manager_get_local_address();
            databuf[1] = 0x5B;
            databuf[2] = 0x04;

            if (NULL != addr) {
                databuf[2] += BT_BD_ADDR_LEN;
                memcpy(&databuf[8], addr, BT_BD_ADDR_LEN);
            }
        } else if ((USB_CMD_GET_SN == cmd) && (buf_size == 10) &&
                   (p_buf[6] == 0x00) && (p_buf[7] == 0xFC)) {
            uint32_t size = CUSTOMER_SN_LEN;

            databuf[1] = 0x5B;
            databuf[2] = 0x04 + CUSTOMER_SN_LEN;
            databuf[6] = CUSTOMER_SN_LEN;
            databuf[7] = 0x00;

            nvkey_read_data(NVKEYID_CUSTOMER_PRODUCT_INFO_SN, &databuf[8],
                            &size);
        } else if ((USB_CMD_SET_SN == cmd) &&
                   (buf_size == (4 + 4 + CUSTOMER_SN_LEN)) &&
                   (p_buf[6] == 0x00) && (p_buf[7] == 0xFC)) {
            databuf[1] = 0x5B;
            databuf[2] = 0x03;

            if (NVKEY_STATUS_OK ==
                nvkey_write_data(NVKEYID_CUSTOMER_PRODUCT_INFO_SN, &databuf[8],
                                 CUSTOMER_SN_LEN)) {
                databuf[6] = 0x00;
            } else {
                databuf[6] = 0x01;
            }
        } else if ((USB_CMD_LED_SET == cmd) && (buf_size == (4 + 4)) &&
                   (p_buf[6] < 0x03) && (p_buf[7] <= 1)) {
            databuf[1] = 0x5B;
            databuf[2] = 0x03;

            AtCommand cmd = AT_COMMAND__INIT;
            int err = 0;
            cmd.cmd = (p_buf[7] == 1) ? AT__CMD__LED_ON : AT__CMD__LED_OFF;
            cmd.params1 = p_buf[6];
            cmd.params2 = p_buf[7];
            err = send_factory_cmd_to_main(&cmd);
            if (err < 0) {
                databuf[6] = 0x01;
            } else {
                databuf[6] = 0x00;
            }
        } else if ((USB_CMD_FLASH1_GET == cmd) && (buf_size == 7) &&
                   (p_buf[6] == 0)) {
            databuf[1] = 0x5B;
            databuf[2] = 0x03;

            AtCommand cmd = AT_COMMAND__INIT;
            int err = 0;
            cmd.cmd = AT__CMD__FLASH1_STATUS_GET;
            err = send_factory_cmd_to_main(&cmd);
            if (err < 0) {
                databuf[6] = 0x01;
            } else {
                databuf[6] = 0x00;
            }
        } else if ((USB_CMD_FLASH2_GET == cmd) && (buf_size == 7) &&
                   (p_buf[6] == 0)) {
            databuf[1] = 0x5B;
            databuf[2] = 0x03;

            AtCommand cmd = AT_COMMAND__INIT;
            int err = 0;
            cmd.cmd = AT__CMD__FLASH2_STATUS_GET;
            err = send_factory_cmd_to_main(&cmd);
            if (err < 0) {
                databuf[6] = 0x01;
            } else {
                databuf[6] = 0x00;
            }
        } else if ((USB_CMD_IR_GET == cmd) && (buf_size == 7) &&
                   (p_buf[6] == 0)) {
            databuf[1] = 0x5B;
            databuf[2] = 0x03;

            AtCommand cmd = AT_COMMAND__INIT;
            int err = 0;
            cmd.cmd = AT__CMD__IR_VALUE_GET;
            err = send_factory_cmd_to_main(&cmd);
            if (err < 0) {
                databuf[6] = 0x01;
            } else {
                databuf[6] = 0x00;
            }
        } else if ((USB_CMD_RTC_SET == cmd) && (buf_size == 7) &&
                   (p_buf[6] == 0)) {
            databuf[1] = 0x5B;
            databuf[2] = 0x03;

            databuf[6] = 0x00;
        } else if ((USB_CMD_RTC_GET == cmd) && (buf_size == 7) &&
                   (p_buf[6] == 0)) {
            databuf[1] = 0x5B;
            databuf[2] = 0x03;

            databuf[6] = 0x00;
        } else if ((USB_CMD_MAX30001_GET == cmd) && (buf_size == 7) &&
                   (p_buf[6] == 0)) {
            databuf[1] = 0x5B;
            databuf[2] = 0x03;

            databuf[6] = 0x00;
        } else if ((USB_CMD_BAT_VOL_GET == cmd) && (buf_size == 7) &&
                   (p_buf[6] == 0)) {
            databuf[1] = 0x5B;
            databuf[2] = 0x03;

            databuf[6] = 0x00;
        } else if ((USB_CMD_BAT_NTC_GET == cmd) && (buf_size == 7) &&
                   (p_buf[6] == 0)) {
            databuf[1] = 0x5B;
            databuf[2] = 0x03;

            databuf[6] = 0x00;
        } else if ((USB_CMD_CES_SET == cmd) && (buf_size == 7) &&
                   (p_buf[6] == 0)) {
            databuf[1] = 0x5B;
            databuf[2] = 0x03;

            databuf[6] = 0x00;
        } else if ((USB_CMD_HW_VER_GET == cmd) && (buf_size == 7) &&
                   (p_buf[6] == 0)) {
            databuf[1] = 0x5B;
            databuf[2] = 0x03;

            databuf[6] = 0x00;
        } else if ((USB_CMD_MCU_FW_VER_GET == cmd) && (buf_size == 7) &&
                   (p_buf[6] == 0)) {
            databuf[1] = 0x5B;
            databuf[2] = 0x03;

            databuf[6] = 0x00;
        } else if ((USB_CMD_CES_FW_VER_GET == cmd) && (buf_size == 7) &&
                   (p_buf[6] == 0)) {
            databuf[1] = 0x5B;
            databuf[2] = 0x03;

            databuf[6] = 0x00;
        } else {
            cmdFlag = false;
        }

        mux_buff.p_buf = databuf;
        mux_buff.buf_size = databuf[2] + 4;

        mux_tx(m_usb_handle, &mux_buff, 1, &send_done_data_len);
    } else {
        cmdFlag = false;
    }

    return cmdFlag;
}

static uint8_t rx_buf[USB_RX_BUF_SIZE / 2];
static uint8_t unpacker_buf[USB_RX_BUF_SIZE];
void app_usb_rx_task(void) {
    uint8_array_t tx_data;
    uint32_t tx_done_data_len;
    mux_status_t status;
    uint32_t bytes_read;

    packet_unpacker_init_static(&unpacker, unpacker_buf, USB_RX_BUF_SIZE, 1);

    packet_unpacker_register_handler(&unpacker, packet_unpacker_handler);

    while (true) {
        if (m_rx_stream == NULL) {
            vTaskDelay(100);
            m_rx_stream = xStreamBufferCreate(USB_RX_BUF_SIZE, sizeof(char));
            continue;
        }
        bytes_read = xStreamBufferReceive(m_rx_stream, rx_buf,
                                          USB_RX_BUF_SIZE / 2, portMAX_DELAY);

        if (usb_race_app_event_respond(rx_buf, bytes_read)) {
            continue;
        }

        packet_unpacker_enqueue(&unpacker, rx_buf, bytes_read);
        packet_unpacker_process(&unpacker);
    }
}

void app_usb_tx_task(void) {
    uint8_array_t tx_data;
    uint32_t tx_done_data_len;
    mux_status_t status;

    while (true) {
        if (m_tx_queue == NULL) {
            vTaskDelay(100);
            m_tx_queue = xQueueCreate(128, sizeof(uint8_array_t));
            continue;
        }
        if (xQueueReceive(m_tx_queue, &tx_data, 100 / portTICK_PERIOD_MS) ==
            pdTRUE) {
            mux_buffer_t mux_buff;
            mux_buff.p_buf = tx_data.data;
            mux_buff.buf_size = tx_data.size;

            if (tx_data.data == NULL) {
                continue;
            }

            status = mux_tx(m_usb_handle, &mux_buff, 1, &tx_done_data_len);
            if ((status != MUX_STATUS_OK) ||
                (tx_done_data_len != tx_data.size)) {
                LOG_MSGID_I(app_usb, "send %d bytes failed", 2,
                            tx_done_data_len);
            }

            vPortFree(tx_data.data);
        }
    }
}

void app_usb_enqueue(uint8_array_t *msg) {
    if (m_tx_queue) {
        xQueueSend(m_tx_queue, msg, pdMS_TO_TICKS(20));
    } else {
        if (msg->data) vPortFree(msg->data);
        LOG_MSGID_I(app_usb, "usb_tx_queue is null", 0);
    }
}