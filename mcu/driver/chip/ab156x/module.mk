include $(SOURCE_DIR)/driver/chip/$(IC_CONFIG)/src/GCC/module.mk

include $(SOURCE_DIR)/driver/board/$(BOARD_CONFIG)/hw_resource_assignment/module.mk

ifneq ($(wildcard $(strip $(SOURCE_DIR))/driver/chip/$(IC_CONFIG)/src_core/),)
include $(SOURCE_DIR)/driver/chip/$(IC_CONFIG)/src_core/GCC/module.mk
else
LIBS += $(SOURCE_DIR)/prebuilt/driver/chip/$(IC_CONFIG)/lib/libhal_core_CM4_GCC.a
endif

ifneq ($(wildcard $(strip $(SOURCE_DIR))/driver/chip/$(IC_CONFIG)/src_protected/),)
include $(SOURCE_DIR)/driver/chip/$(IC_CONFIG)/src_protected/GCC/module.mk
else
LIBS += $(SOURCE_DIR)/prebuilt/driver/chip/$(IC_CONFIG)/lib/libhal_protected_CM4_GCC.a
endif


CFLAGS  += -I$(SOURCE_DIR)/prebuilt/middleware/airoha/nvdm/$(IC_CONFIG)/inc
CFLAGS  += -I$(SOURCE_DIR)/middleware/airoha/nvdm/inc