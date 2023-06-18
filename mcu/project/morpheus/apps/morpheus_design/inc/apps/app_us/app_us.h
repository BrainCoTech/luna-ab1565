#ifndef APP_US_H_
#define APP_US_H_
#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include "morpheus.h"
#include "app_bt/app_bt_msg_helper.h"

void app_us_tx_task();

void app_us_rx_task();

bool app_us_notification_enable(void);

void app_us_enqueue(uint8_array_t *msg);

void send_msg_to_app(BtApp *msg);

#ifdef __cplusplus
}
#endif
#endif /* APP_US_H_ */
