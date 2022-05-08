
LOCAL_AUDIO_SRC = middleware/BrainCo/local_audio_playback

C_FILES += ${LOCAL_AUDIO_SRC}/src/local_audio_control.c
C_FILES += ${LOCAL_AUDIO_SRC}/src/local_audio_source.c
C_FILES += ${LOCAL_AUDIO_SRC}/src/local_audio_playback.c

ifeq ($(BRC_LOCAL_AUDIO_TEST_ENABLE), y)
C_FILES += ${LOCAL_AUDIO_SRC}/test/local_audio_test.c
C_FILES += ${LOCAL_AUDIO_SRC}/test/local_stream_raw.c

CFLAGS += -I$(SOURCE_DIR)/middleware/BrainCo/local_audio_playback/test
CFLAGS += -DBRC_LOCAL_AUDIO_TEST_ENABLE
endif

CFLAGS += -I$(SOURCE_DIR)/middleware/BrainCo/local_audio_playback/inc
