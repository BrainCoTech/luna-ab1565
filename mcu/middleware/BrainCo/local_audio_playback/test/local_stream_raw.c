/*
 * Copyright (c) 2022 BrainCo Inc.
 *
 * All right reserved.
 */

#include "local_stream_interface.h"
#include "hal_audio_internal.h"

#include "mp3_sine_440hz_3s_c2.h"

static local_stream_if_t local_stream_raw;

static void local_stream_raw_open(void *private_data)
{
    local_stream_if_t *stream = (local_stream_if_t *) private_data;

    stream->state = LOCAL_STREAM_STATE_GOOD;
    stream->offset = 0U;
}

static void local_stream_raw_close(void *private_data)
{
    local_stream_if_t *stream = (local_stream_if_t *) private_data;

    /* Clear all flags. */
    stream->state = LOCAL_STREAM_STATE_UNAVAILABLE;
    /* Reset read offset. */
    stream->offset = 0U; 
}

static uint32_t local_stream_raw_read(void *private_data, uint8_t *buffer, uint32_t size)
{
    local_stream_if_t *stream = (local_stream_if_t *) private_data;
    uint32_t read = size;

    if (stream->state != LOCAL_STREAM_STATE_GOOD) {
        return 0U;
    }

    if ((stream->offset + size) > sizeof(mp3_sine_440hz_array)) {
        read = sizeof(mp3_sine_440hz_array) - stream->offset;
    }

    for (uint32_t i = 0U; i < read; i++) {
        buffer[i] = mp3_sine_440hz_array[stream->offset + i];
    }

    stream->offset += read;
    if (stream->offset == sizeof(mp3_sine_440hz_array)) {
        stream->state = LOCAL_STREAM_STATE_EOF;
    }

    return read;
}

static uint32_t local_stream_raw_seek(void *private_data, uint32_t offset)
{
    local_stream_if_t *stream = (local_stream_if_t *) private_data;

    /* For BAD stream, do not apply the new offset. */
    if (stream->state == LOCAL_STREAM_STATE_BAD) {
        return stream->offset;
    }

    stream->offset = MINIMUM(offset, sizeof(mp3_sine_440hz_array));

    /* Set EOF if offset to end. */
    if (stream->offset == sizeof(mp3_sine_440hz_array)) {
        stream->state = LOCAL_STREAM_STATE_EOF;
    }

    /* Clear EOF if seek backward. */
    if ((stream->offset < sizeof(mp3_sine_440hz_array)) &&
        (stream->state == LOCAL_STREAM_STATE_EOF)) {
        stream->state = LOCAL_STREAM_STATE_GOOD;
    }

    return stream->offset;
}

local_stream_if_t *local_stream_raw_init(void)
{
    local_stream_if_t *stream = &local_stream_raw;

    /* Clear stream state. */
    stream->state = LOCAL_STREAM_STATE_UNAVAILABLE;
    /* Reset read offset. */
    stream->offset = 0U;
    /* Not used in raw stream. */
    stream->private_data = stream;

    stream->open = local_stream_raw_open;
    stream->close = local_stream_raw_close;
    stream->read = local_stream_raw_read;
    stream->seek = local_stream_raw_seek;

    return stream;
}
