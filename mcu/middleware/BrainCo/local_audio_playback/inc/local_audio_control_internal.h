/*
 * Copyright (c) 2022 BrainCo Inc.
 *
 * All right reserved.
 */

#ifndef __LOCAL_AUDIO_CONTROL_INTERNAL__H__
#define __LOCAL_AUDIO_CONTROL_INTERNAL__H__

#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <hal_platform.h>
#include "hal_audio.h"
#include "bt_sink_srv_ami.h"

#include "local_audio_control.h"
#include "local_audio_source.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    bt_sink_srv_am_id_t  aid;
    local_audio_state_t state;
    bt_sink_srv_am_audio_capability_t codec_cap;
    uint32_t volume;
    bool mute;
    local_audio_user_callback_t user_cb;
    void *user_data;
} local_audio_context_t;

local_audio_context_t *local_audio_get_ctx(void);

static inline void local_audio_update_state(local_audio_context_t *ctx, local_audio_state_t state)
{
    ctx->state = state;

    /* Reset the stream when enter READY state. */
    if (LOCAL_AUDIO_STATE_READY == state) {
        local_audio_source_reset_stream();
    }

    ctx->user_cb(state, ctx->user_data);
}

#ifdef __cplusplus
}
#endif

#endif  /*__LOCAL_AUDIO_CONTROL_INTERNAL__H__*/
