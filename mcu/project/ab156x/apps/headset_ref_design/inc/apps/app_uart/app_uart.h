#ifndef APP_UART_H_
#define APP_UART_H_
#ifdef __cplusplus
extern "C" {
#endif

#include "bc_utils.h"

#define APP_UART_TX_NAME "app_uart_tx"
#define APP_UART_TX_STACKSIZE 1024
#define APP_UART_TX_PRIORITY 4

#define APP_UART_RX_NAME "app_uart_rx"
#define APP_UART_RX_STACKSIZE 1024
#define APP_UART_RX_PRIORITY 4

void app_uart_init(void);

void app_uart_tx_task();

void app_uart_tx_enqueue(uint8_array_t *msg);

void app_uart_rx_task();

#ifdef __cplusplus
}
#endif
#endif /* APP_UART_H_ */
