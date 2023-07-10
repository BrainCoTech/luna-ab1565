#include "app_usb.h"

#include "FreeRTOS.h"
#include "apps_debug.h"
#include "main_controller.h"
#include "morpheus.h"
#include "mux.h"
#include "packet/packet.h"
#include "packet/packet_packer.h"
#include "packet/packet_unpacker.h"
#include "proto_msg/app_bt/app_bt_msg_helper.h"
#include "queue.h"
#include "stream_buffer.h"
#include "syslog.h"
#include "task.h"
#include "timers.h"
#include "app_uart.h"

log_create_module(app_usb, PRINT_LEVEL_INFO);

#define USB_MUX_PORT_RX_BUF_SIZE 512
#define USB_MUX_PORT_TX_BUF_SIZE 512
#define USB_RX_BUF_SIZE (2048+1024)

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


void app_usb_enqueue(uint8_array_t *msg)
{
    if (m_tx_queue) {
        xQueueSend(m_tx_queue, msg, pdMS_TO_TICKS(20));
    } else {
        if (msg->data) vPortFree(msg->data);
        LOG_MSGID_I(app_usb, "usb_tx_queue is null", 0);
    }    
}