###################################################
# BT source module.mk
###################################################
BT_SOURCE_SRV_SRC = middleware/airoha/bt_source/src

C_FILES  += $(BT_SOURCE_SRV_SRC)/bt_source_srv_utils.c \
            $(BT_SOURCE_SRV_SRC)/bt_source_srv.c \
            $(BT_SOURCE_SRV_SRC)/bt_source_srv_at_cmd.c \
            $(BT_SOURCE_SRV_SRC)/bt_source_srv_common.c \

ifeq ($(AIR_SOURCE_SRV_HFP_ENABLE), y)
BT_SOURCE_SRV_CALL_SRC = middleware/airoha/bt_source/src/call
C_FILES  += $(BT_SOURCE_SRV_CALL_SRC)/bt_source_srv_hfp.c \
            $(BT_SOURCE_SRV_CALL_SRC)/bt_source_srv_call.c \
            $(BT_SOURCE_SRV_CALL_SRC)/bt_source_srv_hfp_call_manager.c \
            $(BT_SOURCE_SRV_CALL_SRC)/bt_source_srv_call_audio.c \
            $(BT_SOURCE_SRV_CALL_SRC)/bt_source_srv_call_pseduo_dev.c \
            $(BT_SOURCE_SRV_CALL_SRC)/bt_source_srv_call_psd_manager.c \

CFLAGS += -DAIR_SOURCE_SRV_HFP_ENABLE

CFLAGS  += -I$(SOURCE_DIR)/middleware/airoha/bt_source/inc/call
endif

CFLAGS  += -I$(SOURCE_DIR)/middleware/airoha/bt_source/inc

ifeq ($(AIR_SOURCE_SRV_MUSIC_ENABLE), y)
CFLAGS += -DAIR_SOURCE_SRV_MUSIC_ENABLE
BT_SOURCE_SRV_MUSIC_SRC = middleware/airoha/bt_source/src/music
C_FILES  += $(BT_SOURCE_SRV_MUSIC_SRC)/bt_source_srv_a2dp.c \
            $(BT_SOURCE_SRV_MUSIC_SRC)/bt_source_srv_avrcp.c \
            $(BT_SOURCE_SRV_MUSIC_SRC)/bt_source_srv_device_manager.c \
            $(BT_SOURCE_SRV_MUSIC_SRC)/bt_source_srv_music_psd_manager.c \
            $(BT_SOURCE_SRV_MUSIC_SRC)/bt_source_srv_music_audio.c \
			$(BT_SOURCE_SRV_MUSIC_SRC)/bt_source_srv_music_pseduo_dev.c \

CFLAGS  += -I$(SOURCE_DIR)/middleware/airoha/bt_source/inc/music
endif
