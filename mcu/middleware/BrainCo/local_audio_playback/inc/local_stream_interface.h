/*
 * Copyright (c) 2022 BrainCo Inc.
 *
 * All right reserved.
 */

#ifndef __LOCAL_STREAM_INTERFACE_H__
#define __LOCAL_STREAM_INTERFACE_H__

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    LOCAL_STREAM_STATE_UNAVAILABLE = 0,
    LOCAL_STREAM_STATE_GOOD,
    LOCAL_STREAM_STATE_EOF,
    LOCAL_STREAM_STATE_BAD,	
} local_stream_state_t;

typedef struct local_stream_interface {
    local_stream_state_t state;
    uint32_t offset;
    void *private_data;
    void (*open)(void *private_data);
    void (*close)(void *private_data);
	/**
	 * @return
	 * LOCAL_STREAM_STATE_GOOD read success,
	 * LOCAL_STREAM_STATE_EOF  read to end,
	 * LOCAL_STREAM_STATE_BAD  read failed, stream can not be used anymore.
	 */
    uint32_t (*read)(void *private_data, uint8_t *buffer, uint32_t size);
	/**
	 * @return 
	 * LOCAL_STREAM_STATE_GOOD seek success, 
	 * LOCAL_STREAM_STATE_EOF  seek to end.
	 */
    uint32_t (*seek)(void *private_data, uint32_t offset);
} local_stream_if_t;

#ifdef __cplusplus
}
#endif

#endif /* __LOCAL_STREAM_INTERFACE_H__ */
