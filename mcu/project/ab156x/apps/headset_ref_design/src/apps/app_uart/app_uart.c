#include "app_uart.h"

#include <string.h>

#include "FreeRTOS.h"
#include "apps_debug.h"
#include "bt_type.h"
#include "hal_uart.h"
#include "queue.h"
#include "semphr.h"
#include "stream_buffer.h"
#include "task.h"

#define LOG_TAG "app_uart"

#define APP_UART_RX_FIFO_ALERT_SIZE (50)
#define APP_UART_RX_FIFO_THRESHOLD_SIZE (256)
#define APP_UART_TX_FIFO_THRESHOLD_SIZE (51)
#define APP_UART_RX_FIFO_BUFFER_SIZE (4096 + 2048)
#define APP_UART_TX_FIFO_BUFFER_SIZE (2048)

hal_uart_port_t m_app_uart_port = HAL_UART_1;

/* clang-format off */
ATTR_ZIDATA_IN_NONCACHED_RAM_4BYTE_ALIGN static uint8_t rx_vfifo_buffer[APP_UART_RX_FIFO_BUFFER_SIZE];
ATTR_ZIDATA_IN_NONCACHED_RAM_4BYTE_ALIGN static uint8_t tx_vfifo_buffer[APP_UART_TX_FIFO_BUFFER_SIZE];
static uint8_t rx_buf[APP_UART_RX_FIFO_BUFFER_SIZE];
/* clang-format on */

static xQueueHandle tx_queue;
static xSemaphoreHandle rx_sem, tx_sem;

static void uart_callback(hal_uart_callback_event_t status, void *user_data) {
    BaseType_t xHigherPriorityTaskWoken = pdFALSE;
    switch (status) {
        case HAL_UART_EVENT_READY_TO_READ:
            xSemaphoreGiveFromISR(rx_sem, &xHigherPriorityTaskWoken);
            portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
            break;

        case HAL_UART_EVENT_READY_TO_WRITE:
            xSemaphoreGiveFromISR(tx_sem, &xHigherPriorityTaskWoken);
            portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
            break;

        default:
            break;
    }
}

void app_uart_init(void) {
    hal_uart_status_t status = HAL_UART_STATUS_OK;
    hal_uart_config_t uart_config;
    hal_uart_dma_config_t dma_config;

    rx_sem = xSemaphoreCreateBinary();
    tx_sem = xSemaphoreCreateBinary();

    uart_config.baudrate = HAL_UART_BAUDRATE_115200;
    uart_config.parity = HAL_UART_PARITY_NONE;
    uart_config.stop_bit = HAL_UART_STOP_BIT_1;
    uart_config.word_length = HAL_UART_WORD_LENGTH_8;

    status = hal_uart_init(m_app_uart_port, &uart_config);
    if (status != HAL_UART_STATUS_OK) {
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

    status = hal_uart_set_dma(m_app_uart_port, &dma_config);
    if (status != HAL_UART_STATUS_OK) {
        APPS_LOG_MSGID_I(LOG_TAG ", set dma fail", 0);
        return;
    }

    status = hal_uart_register_callback(m_app_uart_port, uart_callback, NULL);
    if (status != HAL_UART_STATUS_OK) {
        APPS_LOG_MSGID_I(LOG_TAG ", register callback fail", 0);
        return;
    }
}

void app_uart_tx_task() {
    uint8_array_t tx_msg;

    app_uart_init();

    APPS_LOG_MSGID_I(LOG_TAG ", tx task initialized", 0);

    while (1) {
        if (!tx_queue) {
            APPS_LOG_MSGID_I(LOG_TAG ", tx task deleted", 0);
            vTaskDelete(NULL);
        }

        if (xQueueReceive(tx_queue, &tx_msg, pdMS_TO_TICKS(200)) == pdTRUE) {
            if (tx_msg.data != NULL) {
                hal_uart_send_dma(m_app_uart_port, tx_msg.data, tx_msg.size);
                if (tx_sem) {
                    xSemaphoreTake(tx_sem, pdMS_TO_TICKS(50));
                }

                vPortFree(tx_msg.data);
            }
        }
    }

    APPS_LOG_MSGID_I(LOG_TAG ", tx task delected", 0);
}

void app_uart_rx_task() {
    uint32_t rx_size = APP_UART_RX_FIFO_BUFFER_SIZE;
    uint32_t bytes = 0;

    APPS_LOG_MSGID_I(LOG_TAG ", rx task initialized", 0);

    while (1) {
        if (rx_sem) {
            if (pdTRUE == xSemaphoreTake(rx_sem, pdMS_TO_TICKS(20))) {
                bytes = hal_uart_receive_dma(m_app_uart_port, rx_buf, rx_size);
                if (bytes > 0) {
                    APPS_LOG_MSGID_I(LOG_TAG ", recieve %d bytes", 1, bytes);
                }
            }
        } else {
            APPS_LOG_MSGID_I(LOG_TAG ", rx task deleted", 0);
        }
    }
}
