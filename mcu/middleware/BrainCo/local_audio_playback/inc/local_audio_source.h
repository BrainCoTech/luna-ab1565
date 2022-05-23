/*
 * Copyright (c) 2022 BrainCo Inc.
 *
 * All right reserved.
 */

#ifndef __LOCAL_AUDIO_SOURCE_H__
#define __LOCAL_AUDIO_SOURCE_H__

#include "local_stream_interface.h"
#include "audio_src_srv.h"
#include "mp3_codec.h"
#include "mp3_codec_internal.h"

#ifdef __cplusplus
extern "C" {
#endif

#define MP3_FRAME_HEADER_SIZE       4U
#define MINIMUM_MP3_FRAME_SIZE      24U
#define MAXIMUM_MP3_FRAME_SIZE      1441U

#define IS_MP3_HEAD(head)  \
    (!( \
        (((head & 0xfff00000) != 0xfff00000) && \
            ((head & 0xfff80000) != 0xffe00000)) || \
        (((head>>17)&0x3) == 0x0) || \
        (((head>>12)&0xf) == 0xf) || \
        (((head>>12)&0xf) == 0x0) || \
        (((head>>10)&0x3) == 0x3) \
    ))

typedef struct {
    local_stream_if_t *stream;
	mp3_codec_media_handle_t *mp3_hdl;
    uint8_t mp3_cache[MAXIMUM_MP3_FRAME_SIZE];
    uint32_t mp3_cache_cur;
    uint32_t mp3_cache_end;
    uint32_t mp3_cache_total;
    ring_buffer_information_t *stream_out_pcm_buff;
    audio_src_srv_handle_t *audio_hdl;
} local_audio_source_t;

int local_audio_source_init(void);
int local_audio_source_deinit(void);
int local_audio_source_set_stream(local_stream_if_t *stream);
int local_audio_source_reset_stream(void);

local_audio_source_t *local_audio_get_src(void);

#ifdef __cplusplus
}
#endif

#endif /* __LOCAL_AUDIO_SOURCE_H__ */
