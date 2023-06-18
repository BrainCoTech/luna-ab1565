#ifndef APP_UART_H_
#define APP_UART_H_
#ifdef __cplusplus
extern "C" {
#endif

#include "morpheus.h"
#include "main_bt/main_bt_msg_helper.h"

void app_uart_init(void);

void app_uart_tx_task();

void app_uart_rx_task();

void app_uart_enqueue(uint8_array_t *msg);

void send_msg_to_main_controller(BtMain *msg);

#ifdef __cplusplus
}
#endif
#endif /* APP_UART_H_ */
