#ifndef __BLE_US_H__
#define __BLE_US_H__

#include "bt_gap_le.h"
#include "bt_gatt.h"
#include "bt_gatts.h"
#include "bt_platform.h"
#include "bt_system.h"
#include "bt_type.h"

BT_EXTERN_C_BEGIN

#define BLE_US_SERVICE_UUID \
        {                                                                     \
            0x02, 0x00, 0x13, 0xac, 0x42, 0x02, 0x63, 0xbf, 0x07, 0xae, 0x01, \
                0x00, 0x0c, 0xa2, 0xe5, 0x4d                                  \
        }

#define US_SERVICE_UUID                                                       \
    {                                                                         \
        BLE_US_SERVICE_UUID                                                   \
    }

#define US_RX_CHAR_UUID                                                     \
    {                                                                         \
        {                                                                     \
            0x02, 0x00, 0x13, 0xac, 0x42, 0x02, 0x63, 0xbf, 0x07, 0xae, 0x02, \
                0x00, 0x0c, 0xa2, 0xe5, 0x4d                                  \
        }                                                                     \
    }

#define US_TX_CHAR_UUID                                                     \
    {                                                                         \
        {                                                                     \
            0x02, 0x00, 0x13, 0xac, 0x42, 0x02, 0x63, 0xbf, 0x07, 0xae, 0x03, \
                0x00, 0x0c, 0xa2, 0xe5, 0x4d                                  \
        }                                                                     \
    }


extern const bt_gatts_service_t ble_us_service;

typedef int32_t (*ble_us_recv_data_cb_t)(const uint8_t *data, uint16_t size);

int32_t ble_us_init(ble_us_recv_data_cb_t cb);

int32_t ble_us_send_data(const uint8_t *data, uint16_t size);

uint32_t ble_us_get_mtu(void);

int32_t ble_us_update_connection_interval(void);

bool ble_us_notification_enable(void);

bt_status_t ble_us_update_phy(void);

BT_EXTERN_C_END
/**
 * @}
 * @}
 */

#endif /*__BLE_US_H__*/
