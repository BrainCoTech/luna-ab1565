#include "ble_bas_app.h"

static uint8_t m_battery_level;

void ble_bas_app_init(void) {
    m_battery_level = 101;
}

/* ble_bas.c 有个弱函数 */
uint8_t ble_bas_read_callback(ble_bas_event_t event, bt_handle_t conn_handle)
{
    return m_battery_level;
}