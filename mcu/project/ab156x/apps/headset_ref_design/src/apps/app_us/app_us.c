#include "app_us.h"

#include "FreeRTOS.h"
#include "apps_debug.h"
#include "bc_utils.h"
#include "ble_us.h"
#include "queue.h"

log_create_module(APP_US, PRINT_LEVEL_INFO);

static QueueHandle_t us_tx_queue, us_rx_queue;

#define QUEUE_SEND_TIMEOUT 40

void app_us_tx_task() {
    uint8_array_t tx;
    int32_t m_mtu;

    uint32_t size = 0;
    uint32_t pos = 0;
    uint32_t retry_count = 0;

    while (1) {
        if (us_tx_queue) {
            vTaskDelete(NULL);
            break;
        }

        if (xQueueReceive(us_tx_queue, &tx, portMAX_DELAY) == pdTRUE) {
            size = 0;
            pos = 0;
            retry_count = 0;
            m_mtu = ble_us_get_mtu() - 3;
            LOG_MSGID_I(APP_US, "send msg to app", 0);
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
        }
    }
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
    if (us_rx_queue)
        xQueueSend(us_rx_queue, &msg, pdMS_TO_TICKS(QUEUE_SEND_TIMEOUT));
    return 0;
}

void app_us_rx_task() {
    uint8_array_t rx;

    ble_us_init(us_us_receive_data_cb);

    while (1) {
        if (us_rx_queue != NULL) {
            if (xQueueReceive(us_rx_queue, &rx, 100) == pdTRUE) {
                vPortFree(rx.data);
            }
        } else {
            LOG_MSGID_I(APP_US, "us service rx task deleted", 0);
            vTaskDelete(NULL);
        }
    }
}

bool app_us_notification_enable(void) { return ble_us_is_notified(); }
