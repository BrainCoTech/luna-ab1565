#include "ble_us.h"

#include <stdint.h>

#include "syslog.h"

log_create_module(BLE_US, PRINT_LEVEL_INFO);

const bt_uuid_t US_RX_CHAR_UUID128 = {{0x02, 0x00, 0x13, 0xac, 0x42, 0x02, 0x63,
                                       0xbf, 0x02, 0xae, 0x02, 0x00, 0x0c, 0xa2,
                                       0xe5, 0x4d}};

const bt_uuid_t US_TX_CHAR_UUID128 = {{0x02, 0x00, 0x13, 0xac, 0x42, 0x02, 0x63,
                                       0xbf, 0x02, 0xae, 0x03, 0x00, 0x0c, 0xa2,
                                       0xe5, 0x4d}};

/**< Attribute Vlaue Hanlde of RX Characteristic. */
#define US_RX_CHAR_VALUE_HANDLE (0x0093)
/**< Attribute Vlaue Hanlde of RX Characteristic. */
#define US_TX_CHAR_VALUE_HANDLE (0x0095)

#define BLE_US_CCCD_NOTIFICATION (0x0001)

static uint16_t m_conn_handle;

static ble_us_recv_data_cb_t m_recv_data_cb;

static uint16_t m_notify_enabled;

/************************************************
 *   Utilities
 *************************************************/
static uint32_t ble_us_tx_char_cccd_callback(const uint8_t rw, uint16_t handle,
                                             void *data, uint16_t size,
                                             uint16_t offset);

static uint32_t ble_us_rx_write_char_callback(const uint8_t rw, uint16_t handle,
                                              void *data, uint16_t size,
                                              uint16_t offset);

BT_GATTS_NEW_PRIMARY_SERVICE_128(ble_us_primary_service, US_SERVICE_UUID);

BT_GATTS_NEW_CHARC_128(ble_us_rx_char,
                       BT_GATT_CHARC_PROP_WRITE_WITHOUT_RSP |
                           BT_GATT_CHARC_PROP_WRITE,
                       US_RX_CHAR_VALUE_HANDLE, US_RX_CHAR_UUID);

BT_GATTS_NEW_CHARC_VALUE_CALLBACK(ble_us_rx_char_value, US_RX_CHAR_UUID128,
                                  BT_GATTS_REC_PERM_WRITABLE,
                                  ble_us_rx_write_char_callback);

BT_GATTS_NEW_CHARC_128(ble_us_tx_char, BT_GATT_CHARC_PROP_NOTIFY,
                       US_TX_CHAR_VALUE_HANDLE, US_TX_CHAR_UUID);

BT_GATTS_NEW_CHARC_VALUE_UINT8(ble_us_tx_char_value, US_TX_CHAR_UUID128,
                               BT_GATTS_REC_PERM_READABLE, 0);

BT_GATTS_NEW_CLIENT_CHARC_CONFIG(ble_us_tx_client_config,
                                 BT_GATTS_REC_PERM_READABLE |
                                     BT_GATTS_REC_PERM_WRITABLE,
                                 ble_us_tx_char_cccd_callback);

static const bt_gatts_service_rec_t *ble_us_service_rec[] = {
    (const bt_gatts_service_rec_t *)&ble_us_primary_service,
    (const bt_gatts_service_rec_t *)&ble_us_rx_char,
    (const bt_gatts_service_rec_t *)&ble_us_rx_char_value,
    (const bt_gatts_service_rec_t *)&ble_us_tx_char,
    (const bt_gatts_service_rec_t *)&ble_us_tx_char_value,
    (const bt_gatts_service_rec_t *)&ble_us_tx_client_config,
};

const bt_gatts_service_t ble_us_service = {.starting_handle = 0x0091,
                                           .ending_handle = 0x0096,
                                           .required_encryption_key_size = 0,
                                           .records = ble_us_service_rec};

static uint32_t ble_us_tx_char_cccd_callback(const uint8_t rw, uint16_t handle,
                                             void *data, uint16_t size,
                                             uint16_t offset) {
    LOG_MSGID_I(BLE_US, "cccd write/read %d bytes, type %d", 2, size, rw);

    if (handle <= 0) {
        return 0;
    }

    m_conn_handle = handle;

    if (rw == BT_GATTS_CALLBACK_WRITE) {
        if (size != sizeof(uint16_t)) {
            return 0;
        }
        m_notify_enabled = *(uint16_t *)data;
    } else if (rw == BT_GATTS_CALLBACK_READ) {
        if (size != 0) {
            uint16_t *buf = (uint16_t *)data;
            *buf = m_notify_enabled;
        }
    }
    return sizeof(uint16_t);
}

static uint32_t ble_us_rx_write_char_callback(const uint8_t rw, uint16_t handle,
                                              void *data, uint16_t size,
                                              uint16_t offset) {
    int32_t ret = 0;
    LOG_MSGID_I(BLE_US, "conn handler %u recieve %d data, offset %d", 3, handle,
                size, offset);
    m_conn_handle = handle;

    if (rw == BT_GATTS_CALLBACK_WRITE) {
        if (m_recv_data_cb) {
            ret = m_recv_data_cb(data, size);
        }
        return size;
    }

    return 0;
}

int32_t ble_us_init(ble_us_recv_data_cb_t cb) {
    m_conn_handle = BT_HANDLE_INVALID;
    m_recv_data_cb = cb;
    return BT_STATUS_SUCCESS;
}

int32_t ble_us_send_data(const uint8_t *data, uint16_t size) {
    uint8_t buf[512];
    int ret = 0;
    bt_gattc_charc_value_notification_indication_t *us_noti;
    us_noti = (bt_gattc_charc_value_notification_indication_t *)buf;

    if (m_conn_handle != BT_HANDLE_INVALID) {
        us_noti->att_req.opcode = BT_ATT_OPCODE_HANDLE_VALUE_NOTIFICATION;
        us_noti->att_req.handle = US_TX_CHAR_VALUE_HANDLE;
        memcpy((void *)(us_noti->att_req.attribute_value), data, size);

        /* 1 byte opcode + 2 bytes handle + 1 byte data[1] */
        us_noti->attribute_value_length = 3 + size;
        ret = bt_gatts_send_charc_value_notification_indication(m_conn_handle,
                                                                us_noti);
    }
    LOG_MSGID_I(BLE_US, "conn_handler %u. send %d bytes to ble, ret %d", 3,
                m_conn_handle, size, ret);
    return 0;
}

bool ble_us_is_notified(void) {
    return (m_notify_enabled == BLE_US_CCCD_NOTIFICATION);
}

int ble_us_get_mtu(void) { return 23; }