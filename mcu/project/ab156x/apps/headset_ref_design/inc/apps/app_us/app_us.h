#ifndef APP_US_H_
#define APP_US_H_
#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>

void app_us_tx_task();

void app_us_rx_task();

bool app_us_notification_enable(void);

#ifdef __cplusplus
}
#endif
#endif /* APP_US_H_ */
