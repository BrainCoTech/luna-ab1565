-include $(SOURCE_DIR)/middleware/airoha/ble_ancs/module.mk
CFLAGS 	+= -I$(SOURCE_DIR)/prebuilt/middleware/airoha/ble_ancs/$(IC_CONFIG)/inc
LIBS += $(SOURCE_DIR)/prebuilt/middleware/airoha/ble_ancs/$(IC_CONFIG)/lib/libble_ancs.a
