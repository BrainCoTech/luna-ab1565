###################################################
# Sources
###################################################

BLE_US_SOURCE = middleware/BrainCo/ble_us/src

CFLAGS += -DBC_BLE_US_ENABLE

C_FILES  += $(BLE_US_SOURCE)/ble_us.c

###################################################
# include path
###################################################
CFLAGS  += -I$(SOURCE_DIR)/middleware/BrainCo/ble_us/inc
CFLAGS += -I$(SOURCE_DIR)/middleware/MTK/bt_callback_manager/inc
CFLAGS += -I$(SOURCE_DIR)/middleware/MTK/bluetooth/inc
