#ifndef APP_SPP_H_
#define APP_SPP_H_
#ifdef __cplusplus
extern "C" {
#endif

#include "morpheus_utils.h"

void app_spp_rx_task();

void app_spp_enqueue(uint8_array_t *msg);

#ifdef __cplusplus
}
#endif
#endif /* APP_SPP_H_ */
