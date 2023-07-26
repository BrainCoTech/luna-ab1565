#ifndef BLE_BAS_APP_H_
#define BLE_BAS_APP_H_
#ifdef __cplusplus
extern "C" {
#endif

#include "ble_bas.h"

void ble_bas_app_init(void);

void ble_bas_app_level_set(uint8_t bat_level);

#ifdef __cplusplus
}
#endif
#endif /* BLE_BAS_APP_H_ */
