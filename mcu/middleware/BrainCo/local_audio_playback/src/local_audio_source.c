/*
 * Copyright (c) 2022 BrainCo Inc.
 *
 * All right reserved.
 */

#include "errno.h"

#include "bt_sink_srv_ami.h"
#include "audio_src_srv.h"
#include "audio_log.h"

#include "local_audio_control_internal.h"
#include "local_audio_source.h"

#define ID3V2_ID            "ID3"
#define ID3V2_HEADER_SIZE   10

static int local_audio_source_mp3_write(void);
static int local_audio_source_mp3_skip_id3v2(void);
static void local_audio_source_mp3_callback(mp3_codec_media_handle_t *mp3_codec_handle, mp3_codec_event_t event);

static void local_audio_source_play(audio_src_srv_handle_t *handle);
static void local_audio_source_stop(audio_src_srv_handle_t *handle);
static void local_audio_source_suspend(audio_src_srv_handle_t *handle, audio_src_srv_handle_t *int_hd);
static void local_audio_source_reject(audio_src_srv_handle_t *handle);
static void local_audio_source_exception(audio_src_srv_handle_t *handle, int32_t event, void *param);

static uint32_t MP3_MPEG1_AUDIO_FRAME_BIT_RATE[] = { 
    0U,
    32000U,
    40000U,
    48000U,
    56000U,
    64000U,
    80000U,
    96000U,
    112000U,
    128000U,
    160000U,
    192000U,
    224000U,
    256000U,
    320000U,
    0U,
};

static local_audio_source_t s_local_audio_source;

local_audio_source_t *local_audio_get_src(void)
{
	return &s_local_audio_source;
}

int local_audio_source_init(void)
{
    local_audio_source_t *src = local_audio_get_src();
    audio_src_srv_handle_t *audio_hdl = NULL;
    mp3_codec_media_handle_t *mp3_hdl = NULL;

    memset(src, 0, sizeof(local_audio_source_t));

    mp3_hdl = mp3_codec_open(local_audio_source_mp3_callback);
    if (mp3_hdl == NULL) {
        audio_src_srv_report("[LOCAL_AUDIO] src init, fail: mp3_hdl\r\n", 0);
        return -ENODEV;
    }

    mp3_codec_set_memory2(mp3_hdl);

    audio_hdl = audio_src_srv_construct_handle(AUDIO_SRC_SRV_PSEUDO_DEVICE_LOCAL);
    if (audio_hdl == NULL) {
        audio_src_srv_report("[LOCAL_AUDIO] src init, fail: audio_hdl\r\n", 0);
        mp3_codec_close(mp3_hdl);
        return -ENODEV;
    }

    audio_hdl->type = AUDIO_SRC_SRV_PSEUDO_DEVICE_LOCAL;
    /* Audio manager use this to judge multi sources playback behavior. */
    audio_hdl->priority = AUDIO_SRC_SRV_PRIORITY_LOW;
    audio_hdl->dev_id = 0;
    audio_hdl->play = local_audio_source_play;
    audio_hdl->stop = local_audio_source_stop;
    audio_hdl->suspend = local_audio_source_suspend;
    audio_hdl->reject = local_audio_source_reject;
    audio_hdl->exception_handle = local_audio_source_exception;

    src->mp3_hdl = mp3_hdl;
    src->audio_hdl = audio_hdl;

    src->mp3_cache_cur = 0U;
    src->mp3_cache_end = 0U;
    src->mp3_cache_total = 0U;

    /* For easier get pcm samples from mp3_codec. */ 
    src->stream_out_pcm_buff = &(mp3_handle_ptr_to_internal_ptr(mp3_hdl)->stream_out_pcm_buff);

    return 0;
}

int local_audio_source_deinit(void)
{
    local_audio_source_t *src = local_audio_get_src();

    if (src->stream) {
        local_audio_source_reset_stream();
    }

    if (src->mp3_hdl) {
        mp3_codec_close(src->mp3_hdl);
        src->mp3_hdl = NULL;
    }

    if (src->audio_hdl) {
        audio_src_srv_destruct_handle(src->audio_hdl);
        src->audio_hdl = NULL;
    }

    return 0;
}

int local_audio_source_set_stream(local_stream_if_t *stream)
{
    local_audio_source_t *src = local_audio_get_src();
    int err;

    stream->open(stream->private_data);
    if (stream->state == LOCAL_STREAM_STATE_BAD) {
        return -EIO;
    }
    src->stream = stream;

    err = local_audio_source_mp3_skip_id3v2();
    if (err < 0) {
        src->stream->close(stream->private_data);
        src->stream = NULL;
        return -EIO;
    }

    /* First time push data to mp3_codec. */
    err = local_audio_source_mp3_write();
    if (err < 0) {
        src->stream->close(stream->private_data);
        src->stream = NULL;
        return err;
    }

    return 0;
}

int local_audio_source_reset_stream(void)
{
    local_audio_context_t *ctx = local_audio_get_ctx();
    local_audio_source_t *src = local_audio_get_src();

    if (src->stream == NULL) {
        return 0;
    }
    
    if (ctx->state != LOCAL_AUDIO_STATE_READY) {
        return -EINVAL;
    }

    src->mp3_hdl->reset_share_buffer(src->mp3_hdl);

    src->stream_out_pcm_buff->read_pointer = 0;
    src->stream_out_pcm_buff->write_pointer = 0;

    if (src->stream && src->stream->state != LOCAL_STREAM_STATE_UNAVAILABLE) {
        src->stream->close(src->stream->private_data);
    }
    src->stream = NULL;

    src->mp3_cache_cur = 0U;
    src->mp3_cache_end = 0U;
    src->mp3_cache_total = 0U;

    return 0;
}

static int local_audio_source_mp3_frame_fetch(local_audio_source_t *src)
{
    local_stream_if_t *stream = src->stream;
    uint32_t temp_mp3_header;
    uint32_t bitrate, padding_bit;
    uint32_t frame_len, read_len;

    if (src->mp3_cache_end != 0U) {
        return 0;
    }

    stream->read(stream->private_data, src->mp3_cache, MP3_FRAME_HEADER_SIZE);
    if (stream->state == LOCAL_STREAM_STATE_BAD) {
        return -EIO;
    }
    if (stream->state == LOCAL_STREAM_STATE_EOF) {
        /* Reach the end of local stream. */
        return 1;
    }

    temp_mp3_header  = (src->mp3_cache[0] << 24);
    temp_mp3_header |= (src->mp3_cache[1] << 16);
    temp_mp3_header |= (src->mp3_cache[2] << 8);
    temp_mp3_header |= (src->mp3_cache[3]);

    if (!IS_MP3_HEAD(temp_mp3_header)) {
        /* Not a valid mp3 header, treat as EOF. */
        return 1;
    }

    /* Local audio only support MPEG-1, layer-3, 48KHz, stereo. */
    if ((((temp_mp3_header>>19)&0x3) != 0x3) ||
        (((temp_mp3_header>>17)&0x3) != 0x1) ||
        (((temp_mp3_header>>10)&0x3) != 0x1) ||
        (((temp_mp3_header>> 6)&0x3) == 0x3)) {
        return -ENOTSUP;
    }

    bitrate = MP3_MPEG1_AUDIO_FRAME_BIT_RATE[((temp_mp3_header >> 12) & 0xF)];
    padding_bit = (temp_mp3_header >> 9) & 0x1;

    frame_len = ((144 * bitrate) / 48000) + padding_bit;

    read_len = stream->read(stream->private_data,
                            (src->mp3_cache + MP3_FRAME_HEADER_SIZE), 
                            frame_len - MP3_FRAME_HEADER_SIZE);
    if ((stream->state == LOCAL_STREAM_STATE_BAD) ||
        (read_len < (frame_len - MP3_FRAME_HEADER_SIZE))) {
        return -EIO;
    }

    src->mp3_cache_cur = 0U;
    src->mp3_cache_end = frame_len;

    return 0;
}

static int local_audio_source_mp3_write(void)
{
    local_audio_source_t *src = local_audio_get_src();
	uint32_t buffer_size, write_len;
	uint8_t *buffer;
    int err;

    do {
        err = local_audio_source_mp3_frame_fetch(src);
        if (err != 0) {
            return err;
        }

        src->mp3_hdl->get_write_buffer(src->mp3_hdl, &buffer, &buffer_size);
        if (buffer_size == 0) {
            break;
        }

        write_len = MINIMUM(buffer_size, (src->mp3_cache_end - src->mp3_cache_cur));

        memcpy(buffer, (src->mp3_cache + src->mp3_cache_cur), write_len);

        src->mp3_cache_cur += write_len;
        /* Reset mp3_cache, if copy cache to mp3_codec is complete. */
        if (src->mp3_cache_cur == src->mp3_cache_end) {
            src->mp3_cache_cur = 0U;
            src->mp3_cache_end = 0U;
            src->mp3_cache_total++;
        }

        src->mp3_hdl->write_data_done(src->mp3_hdl, write_len);

    } while ((buffer_size - write_len) > MINIMUM_MP3_FRAME_SIZE);

    /* Trigger mp3_codec decode process. */
    src->mp3_hdl->finish_write_data(src->mp3_hdl);

	return 0;
}

static int local_audio_source_mp3_skip_id3v2(void)
{
    local_audio_source_t *src = local_audio_get_src();
    local_stream_if_t *stream = src->stream;
    uint8_t id3v2_buf[ID3V2_HEADER_SIZE];
    uint32_t id3v2_size;

    stream->read(stream->private_data, id3v2_buf, ID3V2_HEADER_SIZE);
    if (stream->state != LOCAL_STREAM_STATE_GOOD) {
        return -EIO;
    }

    if ((id3v2_buf[0] != ID3V2_ID[0]) &&
        (id3v2_buf[1] != ID3V2_ID[1]) &&
        (id3v2_buf[2] != ID3V2_ID[2])) {
        /* No ID3v2 tag exist, recover the stream. */
        stream->seek(stream->private_data, 0U);
        return 0;
    }

    /* ref: https://id3.org/id3v2.3.0 */
    id3v2_size = ((id3v2_buf[6] & 0x7f) << 21) | ((id3v2_buf[7] & 0x7f) << 14) | ((id3v2_buf[8] & 0x7f) <<  7) | (id3v2_buf[9] & 0x7f);
    id3v2_size += ID3V2_HEADER_SIZE;

    stream->seek(stream->private_data, id3v2_size);
    if (stream->state == LOCAL_STREAM_STATE_EOF) {
        return -EIO;
    }

    return 0;
}

void local_audio_source_mp3_callback(mp3_codec_media_handle_t *mp3_codec_handle, mp3_codec_event_t event)
{
    local_audio_context_t *ctx = local_audio_get_ctx();
    local_audio_source_t *src = local_audio_get_src();
    int err;

	if (MP3_CODEC_MEDIA_REQUEST == event) {
        err = local_audio_source_mp3_write();
        if (err < 0) {
            local_audio_update_state(ctx, LOCAL_AUDIO_STATE_ERROR);
            audio_src_srv_update_state(src->audio_hdl, AUDIO_SRC_SRV_EVT_PREPARE_STOP);
        }
        /* Reach the end of the stream, stop automatically. */
        if (err == 1) {
            local_audio_update_state(ctx, LOCAL_AUDIO_STATE_FINISH);
            audio_src_srv_update_state(src->audio_hdl, AUDIO_SRC_SRV_EVT_PREPARE_STOP);
        }
    }
}

void local_audio_source_play(audio_src_srv_handle_t *handle)
{
    local_audio_context_t *ctx = local_audio_get_ctx();

    ctx->codec_cap.type = LOCAL_AUDIO;
    ctx->codec_cap.audio_stream_in.audio_device = HAL_AUDIO_DEVICE_LOCAL_DUAL;
    ctx->codec_cap.audio_stream_in.audio_volume = AUD_VOL_IN_LEVEL0;
    ctx->codec_cap.audio_stream_out.audio_device = HAL_AUDIO_DEVICE_DAC_DUAL;
    ctx->codec_cap.audio_stream_out.audio_volume = ctx->volume;
    ctx->codec_cap.audio_stream_out.audio_mute = ctx->mute;
    
    if (AUD_EXECUTION_SUCCESS != bt_sink_srv_ami_audio_play(ctx->aid, &ctx->codec_cap)) {
        audio_src_srv_report("[LOCAL_AUDIO] src play, fail\r\n", 0);
    }
}

void local_audio_source_stop(audio_src_srv_handle_t *handle)
{
    local_audio_context_t *ctx = local_audio_get_ctx();

    if (AUD_EXECUTION_SUCCESS != bt_sink_srv_ami_audio_stop(ctx->aid)) {
        audio_src_srv_report("[LOCAL_AUDIO] src stop, fail\r\n", 0);
    }
}

void local_audio_source_suspend(audio_src_srv_handle_t *handle, audio_src_srv_handle_t *int_hd)
{
    local_audio_context_t *ctx = local_audio_get_ctx();

    if (AUD_EXECUTION_SUCCESS != bt_sink_srv_ami_audio_stop(ctx->aid)) {
        audio_src_srv_report("[LOCAL_AUDIO] src suspend, fail\r\n", 0);
    }

    audio_src_srv_update_state(handle, AUDIO_SRC_SRV_EVT_READY);

    audio_src_srv_add_waiting_list(handle);

    vTaskDelay(100 / portTICK_PERIOD_MS);

    local_audio_update_state(ctx, LOCAL_AUDIO_STATE_SUSPEND);
}

void local_audio_source_reject(audio_src_srv_handle_t *handle)
{
    local_audio_context_t *ctx = local_audio_get_ctx();

    audio_src_srv_add_waiting_list(handle);

    local_audio_update_state(ctx, LOCAL_AUDIO_STATE_SUSPEND);
}

void local_audio_source_exception(audio_src_srv_handle_t *handle, int32_t event, void *param)
{
    /* NOP */
}
