###################################################
# Sources
###################################################

PACKET_SOURCE = middleware/BrainCo

C_FILES  += $(PACKET_SOURCE)/packet/packet_packer.c
C_FILES  += $(PACKET_SOURCE)/packet/packet_unpacker.c
C_FILES  += $(PACKET_SOURCE)/crc/crc16.c
C_FILES  += $(PACKET_SOURCE)/proto_msg/app_bt/app_bt_msg_helper.c
C_FILES  += $(PACKET_SOURCE)/proto_msg/main_bt/main_bt_msg_helper.c
C_FILES  += ${PACKET_SOURCE}/morpheus_protobuf/Third_Party/protobuf-c/protobuf-c/protobuf-c.c
C_FILES  += ${PACKET_SOURCE}/morpheus_protobuf/generated/protobuf-c/app_bt/bt_to_app.pb-c.c
C_FILES  += ${PACKET_SOURCE}/morpheus_protobuf/generated/protobuf-c/app_bt/app_to_bt.pb-c.c
C_FILES  += ${PACKET_SOURCE}/morpheus_protobuf/generated/protobuf-c/app_main/main_to_app.pb-c.c
C_FILES  += ${PACKET_SOURCE}/morpheus_protobuf/generated/protobuf-c/main_bt/main_to_bt.pb-c.c
C_FILES  += ${PACKET_SOURCE}/morpheus_protobuf/generated/protobuf-c/main_bt/bt_to_main.pb-c.c
C_FILES  += ${PACKET_SOURCE}/morpheus_protobuf/generated/protobuf-c/morpheus_common.pb-c.c

C_FILES  += $(PACKET_SOURCE)/littlefs/lfs.c
C_FILES  += $(PACKET_SOURCE)/littlefs/lfs_util.c

###################################################
# include path
###################################################
CFLAGS  += -I$(SOURCE_DIR)/middleware/BrainCo
CFLAGS  += -I$(SOURCE_DIR)/middleware/BrainCo/proto_msg
CFLAGS  += -I$(SOURCE_DIR)/middleware/BrainCo/morpheus_protobuf/generated/protobuf-c/
CFLAGS  += -I$(SOURCE_DIR)/middleware/BrainCo/morpheus_protobuf/Third_Party/protobuf-c
CFLAGS  += -DFREERTOS

CFLAGS  += -I$(SOURCE_DIR)/middleware/BrainCo/littlefs
