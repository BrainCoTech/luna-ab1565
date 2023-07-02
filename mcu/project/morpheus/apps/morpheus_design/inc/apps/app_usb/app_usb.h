#ifndef APP_USB_H_
#define APP_USB_H_
#ifdef __cplusplus
extern "C" {
#endif

#include "morpheus.h"

void app_usb_init(void);

void app_usb_rx_task(void);

void app_usb_tx_task(void);

void app_usb_enqueue(uint8_array_t *msg);

#ifdef __cplusplus
}
#endif
#endif /* APP_USB_H_ */
