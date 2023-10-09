#include "app_uart.h"

#include <string.h>

#include "FreeRTOS.h"
#include "app_us.h"
#include "apps_debug.h"
#include "bt_type.h"
#include "hal_uart.h"
#include "hal_pinmux_define.h"
#include "main_bt/bt_to_main.pb-c.h"
#include "main_bt/main_bt_msg_helper.h"
#include "main_bt/main_to_bt.pb-c.h"
#include "morpheus.h"
#include "packet/packet.h"
#include "packet/packet_packer.h"
#include "packet/packet_unpacker.h"
#include "queue.h"
#include "semphr.h"
#include "task.h"

log_create_module(APP_UART, PRINT_LEVEL_INFO);
#define LOG_TAG "app_uart"

static bool m_uart_is_initialized;

hal_uart_port_t m_app_uart_port = HAL_UART_2;
#define APP_UART_RX_FIFO_ALERT_SIZE (50)
#define APP_UART_RX_FIFO_THRESHOLD_SIZE (256)
#define APP_UART_TX_FIFO_THRESHOLD_SIZE (51)
#define APP_UART_RX_FIFO_BUFFER_SIZE (1024)
#define APP_UART_TX_FIFO_BUFFER_SIZE (2048)

#define UNPACKER_BUF_SIZE (4096 + 128)
static uint8_t unpacker_buf[UNPACKER_BUF_SIZE];
static uint8_t rx_buf[APP_UART_RX_FIFO_BUFFER_SIZE];

/* clang-format off */
ATTR_ZIDATA_IN_NONCACHED_RAM_4BYTE_ALIGN static uint8_t rx_vfifo_buffer[APP_UART_RX_FIFO_BUFFER_SIZE];
ATTR_ZIDATA_IN_NONCACHED_RAM_4BYTE_ALIGN static uint8_t tx_vfifo_buffer[APP_UART_TX_FIFO_BUFFER_SIZE];
/* clang-format on */

#define UART_TX_QUEUE_SIZE 100

static xQueueHandle uart_tx_queue;
static xSemaphoreHandle uart_rx_sem, uart_tx_sem;

static packet_unpacker_t unpacker;

static void packet_unpacker_handler(int32_t src_id, int32_t dst_id,
                                    uint8_t *data, uint16_t size) {
    const packet_t *packet = (packet_t *)data;
    uint8_array_t msg;
    uint8_array_t usb_msg;

    switch (dst_id) {
        case APP_ID:
            LOG_MSGID_I(APP_UART, "forward message to app", 0);
            msg.size = size;
            msg.data = pvPortMalloc(size);
            if (msg.data) {
                memcpy(msg.data, data, size);
                app_us_enqueue(&msg);
            }
            if (size < 512) {
                usb_msg.size = size;
                usb_msg.data = pvPortMalloc(size);
                if (usb_msg.data) {
                    memcpy(usb_msg.data, data, size);
                    app_usb_enqueue(&usb_msg);
                }
            }
            
            break;

        case BLUETOOTH_ID:
            LOG_MSGID_I(APP_UART, "decode message from main", 0);
            main_bt_msg_decode(packet->payload, packet->header.payload_length);
            break;

        default:
            LOG_MSGID_I(APP_UART, "message dst error", 0);
            break;
    }
}

static void user_uart_callback(hal_uart_callback_event_t status,
                               void *user_data) {
    BaseType_t xHigherPriorityTaskWoken = pdFALSE;
    switch (status) {
        case HAL_UART_EVENT_READY_TO_READ:
            xSemaphoreGiveFromISR(uart_rx_sem, &xHigherPriorityTaskWoken);
            portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
            break;
        case HAL_UART_EVENT_READY_TO_WRITE:
            xSemaphoreGiveFromISR(uart_tx_sem, &xHigherPriorityTaskWoken);
            portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
            break;

        default:
            break;
    }
}


void uart_pinmux_init(void)
{
    hal_gpio_init(HAL_GPIO_7);
    hal_pinmux_set_function(HAL_GPIO_7, HAL_GPIO_7_UART2_TXD);
    hal_gpio_init(HAL_GPIO_3);
    hal_pinmux_set_function(HAL_GPIO_3, HAL_GPIO_3_UART2_RXD);
}

void app_uart_init(void) {
    if (m_uart_is_initialized) {
        return;
    }

    uart_pinmux_init();

    uart_rx_sem = xSemaphoreCreateBinary();
    uart_tx_sem = xSemaphoreCreateBinary();
    uart_tx_queue = xQueueCreate(UART_TX_QUEUE_SIZE, sizeof(uint8_array_t));

    hal_uart_config_t uart_config;
    hal_uart_dma_config_t dma_config;

    uart_config.baudrate = HAL_UART_BAUDRATE_115200;
    uart_config.parity = HAL_UART_PARITY_NONE;
    uart_config.stop_bit = HAL_UART_STOP_BIT_1;
    uart_config.word_length = HAL_UART_WORD_LENGTH_8;


    if (HAL_UART_STATUS_OK != hal_uart_init(m_app_uart_port, &uart_config)) {
        APPS_LOG_MSGID_I(LOG_TAG ", open port fail", 0);
        return;
    }

    APPS_LOG_MSGID_I(LOG_TAG ", open port success", 0);
    dma_config.receive_vfifo_alert_size = APP_UART_RX_FIFO_ALERT_SIZE;
    dma_config.receive_vfifo_buffer = rx_vfifo_buffer;
    dma_config.receive_vfifo_buffer_size = APP_UART_RX_FIFO_BUFFER_SIZE;
    dma_config.receive_vfifo_threshold_size = APP_UART_RX_FIFO_THRESHOLD_SIZE;
    dma_config.send_vfifo_buffer = tx_vfifo_buffer;
    dma_config.send_vfifo_buffer_size = APP_UART_TX_FIFO_BUFFER_SIZE;
    dma_config.send_vfifo_threshold_size = APP_UART_TX_FIFO_THRESHOLD_SIZE;

    hal_uart_set_dma(m_app_uart_port, &dma_config);

    hal_uart_register_callback(m_app_uart_port, user_uart_callback, NULL);

    m_uart_is_initialized = true;
}

void app_uart_tx_task() {
    uint8_array_t tx_data;

    // app_uart_init();

    APPS_LOG_MSGID_I(LOG_TAG ", app_uart_tx_task ok", 0);
    while (1) {
        if (!m_uart_is_initialized) {
            vTaskDelay(100);
            continue;
        }

        if (uart_tx_queue == NULL) {
            vTaskDelay(100);
            uart_tx_queue = xQueueCreate(UART_TX_QUEUE_SIZE, sizeof(uint8_array_t));
            continue;
        }

        if (xQueueReceive(uart_tx_queue, &tx_data, pdMS_TO_TICKS(200)) == pdTRUE) {
            if (tx_data.data != NULL && tx_data.size != 0) {
                hal_uart_send_dma(m_app_uart_port, tx_data.data, tx_data.size);
                if (uart_tx_sem)
                    xSemaphoreTake(uart_tx_sem, pdMS_TO_TICKS(50));
                vPortFree(tx_data.data);
            }
        }

    }
    APPS_LOG_MSGID_I(LOG_TAG ", tx task deleted", 0);
    vTaskDelete(NULL);
}

void app_uart_rx_task() {
    int ret = 0;
    uint32_t rx_size = APP_UART_RX_FIFO_BUFFER_SIZE;
    uint32_t bytes = 0;

    packet_unpacker_init_static(&unpacker, unpacker_buf, UNPACKER_BUF_SIZE, 1);
    packet_unpacker_register_handler(&unpacker, packet_unpacker_handler);

    if (ret < 0) {
        APPS_LOG_MSGID_E(LOG_TAG ", unpacker init failed", 0);
        return;
    }
    APPS_LOG_MSGID_I(LOG_TAG ", app_uart_rx_task ok", 0);
    while (1) {
        if (!m_uart_is_initialized) {
            vTaskDelay(100);
            continue;
        }

        if (uart_rx_sem == NULL) {
            uart_rx_sem = xSemaphoreCreateBinary();
            vTaskDelay(100);
            continue;
        }

        if (pdTRUE == xSemaphoreTake(uart_rx_sem, pdMS_TO_TICKS(20))) {
            bytes = hal_uart_receive_dma(m_app_uart_port, rx_buf, rx_size);
            if (bytes > 0) {
                APPS_LOG_MSGID_I(LOG_TAG ",recieve %d bytes", 1, bytes);
                packet_unpacker_enqueue(&unpacker, rx_buf, bytes);
                packet_unpacker_process(&unpacker);
            }
        }
    }
    APPS_LOG_MSGID_I(LOG_TAG ", rx task deleted", 0);
}

void main_bt_board_config(uint32_t msg_id, BoardConfig *board_cfg) {
    BtMain msg = BT_MAIN__INIT;
    BoardConfigResp board_resp = BOARD_CONFIG_RESP__INIT;
    msg.msg_id = msg_id;

    bt_bd_addr_t *local_addr;
    local_addr = bt_device_manager_get_local_address();
    char addr_str[13] = {0};
    memset(addr_str, 0, 13);
    snprintf((char *)addr_str, sizeof(addr_str), "%.2X%.2X%.2X%.2X%.2X%.2X",
             (*local_addr)[5], (*local_addr)[4], (*local_addr)[3],
             (*local_addr)[2], (*local_addr)[1], (*local_addr)[0]);

    if (board_cfg->get_info) {
        msg.board_cfg_resp = &board_resp;
        board_resp.fw_version = FW_VERSION;
        board_resp.model = MODEL;
        board_resp.build_time = __DATE__;
        board_resp.boot_count = 0;
        board_resp.device_name = "Easleep";
        board_resp.mac_addr.data = addr_str;
        board_resp.mac_addr.len = 12;
        board_resp.sn = sn_get();
    }
    send_msg_to_main_controller(&msg);
}

void app_uart_enqueue(uint8_array_t *msg) {
    if (uart_tx_queue) {
        xQueueSend(uart_tx_queue, msg, pdMS_TO_TICKS(20));
    } else {
        APPS_LOG_MSGID_I(LOG_TAG ", uart_tx_queue is null", 0);
    }
}

void send_msg_to_main_controller(BtMain *msg) {
    packet_packer_t packer;
    uint8_array_t msg_body;

    if (bt_main_msg_encode(&packer, msg) == 0) {
        msg_body.size = packer.packet_size;
        msg_body.data = pvPortMalloc(msg_body.size);
        if (msg_body.data) {
            memcpy(msg_body.data, packer.packet, msg_body.size);
            app_uart_enqueue(&msg_body);
        }
        packet_packer_free(&packer);
    }
}