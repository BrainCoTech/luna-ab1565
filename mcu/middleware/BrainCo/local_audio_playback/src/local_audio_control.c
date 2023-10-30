/*
 * Copyright (c) 2022 BrainCo Inc.
 *
 * All right reserved.
 */

#include <errno.h>

#include "bt_sink_srv_ami.h"
#include "audio_src_srv.h"
#include "audio_log.h"

#include "local_stream_interface.h"
#include "local_audio_source.h"
#include "local_audio_control_internal.h"
#include "local_audio_control.h"

/* Use A2DP volume config. */
extern uint8_t AUD_A2DP_VOL_OUT_MAX;
extern uint8_t AUD_A2DP_VOL_OUT_DEFAULT;

static local_audio_context_t s_local_audio_ctx;

local_audio_context_t *local_audio_get_ctx(void)
{
    return &s_local_audio_ctx;
}

void local_audio_ami_callback(bt_sink_srv_am_id_t aud_id, bt_sink_srv_am_cb_msg_class_t msg_id, 
                                     bt_sink_srv_am_cb_sub_msg_t sub_msg, void *param)
{
    local_audio_context_t *ctx = local_audio_get_ctx();
    local_audio_source_t *src = local_audio_get_src();

    audio_src_srv_report("[LOCAL_AUDIO] ctrl callback: msg: %d, sub: %d/r/n", 2, msg_id, sub_msg);

    if ((msg_id == AUD_SELF_CMD_REQ) &&
        (sub_msg == AUD_CMD_COMPLETE)) {
        if (ctx->state == LOCAL_AUDIO_STATE_PREPARE_PLAY) {
            audio_src_srv_update_state(src->audio_hdl, AUDIO_SRC_SRV_EVT_PLAYING);

            local_audio_update_state(ctx, LOCAL_AUDIO_STATE_PLAYING);
            src->audio_hdl->priority = AUDIO_SRC_SRV_PRIORITY_LOW;
        } else if (ctx->state == LOCAL_AUDIO_STATE_PREPARE_PAUSE) {
            audio_src_srv_update_state(src->audio_hdl, AUDIO_SRC_SRV_EVT_READY);

            local_audio_update_state(ctx, LOCAL_AUDIO_STATE_PAUSE);
        } else if (ctx->state == LOCAL_AUDIO_STATE_SUSPEND) {
            audio_src_srv_update_state(src->audio_hdl, AUDIO_SRC_SRV_EVT_PLAYING);

            local_audio_update_state(ctx, LOCAL_AUDIO_STATE_PLAYING);
        } else if ((ctx->state == LOCAL_AUDIO_STATE_PREPARE_STOP) ||
                   (ctx->state == LOCAL_AUDIO_STATE_ERROR)        ||
                   (ctx->state == LOCAL_AUDIO_STATE_FINISH)) {
            audio_src_srv_update_state(src->audio_hdl, AUDIO_SRC_SRV_EVT_READY);

            /* Reset the stream. */
            local_audio_source_reset_stream();

            local_audio_update_state(ctx, LOCAL_AUDIO_STATE_READY);
        } else {

            audio_src_srv_report("[LOCAL_AUDIO] ctrl callback: err state %d\r\n", 1, ctx->state);
        }
    } else {
        audio_src_srv_report("[LOCAL_AUDIO] ctrl callback: unknown msg(%d), sub(%d) ignored", 2, msg_id, sub_msg);
    }
}

int audio_local_audio_control_init(local_audio_user_callback_t user_cb, void *user_data)
{
    local_audio_context_t *ctx = local_audio_get_ctx();
    local_audio_source_t *src = local_audio_get_src();

    if (ctx->state != LOCAL_AUDIO_STATE_UNAVAILABLE) {
        return 0;
    }

    local_audio_source_init();

    memset(ctx, 0, sizeof(local_audio_context_t));

    ctx->volume = AUD_A2DP_VOL_OUT_DEFAULT;
    ctx->mute = false;
    ctx->user_cb = user_cb;
    ctx->user_data = user_data;

    ctx->aid = bt_sink_srv_ami_audio_open(AUD_MIDDLE, local_audio_ami_callback);
    if (AUD_ID_INVALID == ctx->aid) {
        audio_src_srv_report("[LOCAL_AUDIO_CONTROL] ami audio open failed\r\n", 0);
        return -1;
    }

    audio_src_srv_update_state(src->audio_hdl, AUDIO_SRC_SRV_EVT_READY);

    hal_audio_set_dvfs_control(HAL_AUDIO_DVFS_MAX_SPEED, HAL_AUDIO_DVFS_LOCK);

    ctx->state = LOCAL_AUDIO_STATE_READY;

    return 0;
}

int audio_local_audio_control_deinit(void)
{
    local_audio_context_t *ctx = local_audio_get_ctx();
    local_audio_source_t *src = local_audio_get_src();

    if (ctx->state == LOCAL_AUDIO_STATE_UNAVAILABLE) {
        return 0;
    }
    if (ctx->state != LOCAL_AUDIO_STATE_READY) {
        return -EBUSY;
    }

    audio_src_srv_update_state(src->audio_hdl, AUDIO_SRC_SRV_EVT_UNAVAILABLE);

    local_audio_source_deinit();

    if (AUD_EXECUTION_FAIL == bt_sink_srv_ami_audio_close(ctx->aid)) {
        return -1;
    }

    hal_audio_set_dvfs_control(HAL_AUDIO_DVFS_MAX_SPEED, HAL_AUDIO_DVFS_UNLOCK);

    local_audio_update_state(ctx, LOCAL_AUDIO_STATE_UNAVAILABLE);

    return 0;
}

int audio_local_audio_control_play(local_stream_if_t *stream)
{
    local_audio_context_t *ctx = local_audio_get_ctx();
    local_audio_source_t *src = local_audio_get_src();
    int err;

    if (ctx->state != LOCAL_AUDIO_STATE_READY &&
        ctx->state != LOCAL_AUDIO_STATE_SUSPEND) {
        return -EINVAL;
    }
    src->audio_hdl->priority = AUDIO_SRC_SRV_PRIORITY_MIDDLE;
    err = local_audio_source_set_stream(stream);
    if (err < 0) {
        return err;
    }
    local_audio_update_state(ctx, LOCAL_AUDIO_STATE_PREPARE_PLAY);

    audio_src_srv_update_state(src->audio_hdl, AUDIO_SRC_SRV_EVT_PREPARE_PLAY);
    return 0;
}

int audio_local_audio_control_stop(void)
{
    local_audio_context_t *ctx = local_audio_get_ctx();
    local_audio_source_t *src = local_audio_get_src();

    if ((ctx->state != LOCAL_AUDIO_STATE_PLAYING) &&
        (ctx->state != LOCAL_AUDIO_STATE_PAUSE) &&
        (ctx->state != LOCAL_AUDIO_STATE_SUSPEND)) {
        return -EINVAL;
    }

    if (ctx->state == LOCAL_AUDIO_STATE_SUSPEND) {
        local_audio_update_state(ctx, LOCAL_AUDIO_STATE_READY);
        audio_src_srv_del_waiting_list(src->audio_hdl);
    } else {
        local_audio_update_state(ctx, LOCAL_AUDIO_STATE_PREPARE_STOP);
        audio_src_srv_update_state(src->audio_hdl, AUDIO_SRC_SRV_EVT_PREPARE_STOP);
    }  

    return 0;
}

int audio_local_audio_control_pause(void)
{
    local_audio_context_t *ctx = local_audio_get_ctx();
    local_audio_source_t *src = local_audio_get_src();

    if (ctx->state == LOCAL_AUDIO_STATE_SUSPEND) {
        audio_src_srv_del_waiting_list(src->audio_hdl);

        local_audio_update_state(ctx, LOCAL_AUDIO_STATE_READY);
        return 0;
    }

    if (ctx->state != LOCAL_AUDIO_STATE_PLAYING) {
        return -EINVAL;
    }

    local_audio_update_state(ctx, LOCAL_AUDIO_STATE_PREPARE_PAUSE);

    audio_src_srv_update_state(src->audio_hdl, AUDIO_SRC_SRV_EVT_PREPARE_STOP);    

    return 0;
}

int audio_local_audio_control_resume(void)
{
    local_audio_context_t *ctx = local_audio_get_ctx();
    local_audio_source_t *src = local_audio_get_src();

    if (ctx->state != LOCAL_AUDIO_STATE_PAUSE) {
        return -EINVAL;
    }

    audio_src_srv_update_state(src->audio_hdl, AUDIO_SRC_SRV_EVT_PREPARE_PLAY);

    local_audio_update_state(ctx, LOCAL_AUDIO_STATE_PREPARE_PLAY);

    return 0;
}

void audio_local_audio_control_set_volume(uint32_t volume)
{
    local_audio_context_t *ctx = local_audio_get_ctx();


    if (ctx->volume == volume) {
        return;
    }

    ctx->volume = volume;

    audio_src_srv_report("[LOCAL_AUDIO_CONTROL] volume %d\r\n", 1, volume);

    if (ctx->state == LOCAL_AUDIO_STATE_PLAYING) {
        bt_sink_srv_ami_audio_set_volume(ctx->aid, volume, STREAM_OUT);
    }

    return;
}

void audio_local_audio_control_set_mute(bool mute)
{
    local_audio_context_t *ctx = local_audio_get_ctx();

    if (ctx->mute == mute) {
        return;
    }

    ctx->mute = mute;

    if (ctx->state == LOCAL_AUDIO_STATE_PLAYING) {
        bt_sink_srv_ami_audio_set_mute(ctx->aid, mute, STREAM_OUT);
    }

    return;
}
