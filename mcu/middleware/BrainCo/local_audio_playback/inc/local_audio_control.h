/*
 * Copyright (c) 2022 BrainCo Inc.
 *
 * All right reserved.
 */

#ifndef __LOCAL_AUDIO_CONTROL_H__
#define __LOCAL_AUDIO_CONTROL_H__

#include "local_stream_interface.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    LOCAL_AUDIO_STATE_ERROR = -1,
    LOCAL_AUDIO_STATE_UNAVAILABLE = 0,
    LOCAL_AUDIO_STATE_READY,
    LOCAL_AUDIO_STATE_PREPARE_PLAY,
    LOCAL_AUDIO_STATE_PLAYING,
    LOCAL_AUDIO_STATE_PREPARE_STOP,
    LOCAL_AUDIO_STATE_PREPARE_PAUSE,
    LOCAL_AUDIO_STATE_PAUSE,
    LOCAL_AUDIO_STATE_SUSPEND,
    LOCAL_AUDIO_STATE_FINISH,
} local_audio_state_t ;


/* Local audio state update callback function. */
typedef void (*local_audio_user_callback_t)(local_audio_state_t state, void *user_data);

int audio_local_audio_control_init(local_audio_user_callback_t user_cb, void *user_data);

int audio_local_audio_control_deinit(void);

/**
 * @brief local audio play api.
 * 
 * @param stream local stream interface pointer
 * @return int 0 for success, negative if failed.
 * 
 * @note
 *   1. This api only allowed at @ready state.
 *   2. When there have terminated event, like finish, error, resource will be release automatically,
 *   there no need to call @stop api again.
 *   3. Since playback managed by audio_manager, there have a delay to start the playback.
 *   User can monitor the callback event to check it.
 *   4. Since there also have other audio sources, local audio may enter @suspend state which is
 *   similar to pause. User can not call @resume api to recover it, but @stop api is allowed.
 *   
 */
int audio_local_audio_control_play(local_stream_if_t *stream);

/**
 * @brief local audio stop api.
 * 
 * @return int 0 for success, negative if failed.
 * 
 * @note
 *   1. This api only allowed at @playing, @pause and @suspend state.
 *   2. Since playback managed by audio_manager, there have a delay to stop the playback.
 *   User can monitor the callback event to check it.
 */
int audio_local_audio_control_stop(void);

/**
 * @brief local audio pause api.
 * 
 * @return int 0 for success, negative if failed.
 * 
 * @note
 *   1. This api only allowed at @playing state.
 *   2. Since playback managed by audio_manager, there have a delay to pause the playback.
 *   User can monitor the callback event to check it.
 */
int audio_local_audio_control_pause(void);

/**
 * @brief local audio resume api.
 * 
 * @return int 0 for success, negative if failed.
 * 
 * @note
 *   1. This api only allowed at @pause state.
 *   2. Since playback managed by audio_manager, there have a delay to resume the playback.
 *   User can monitor the callback event to check it.
 */
int audio_local_audio_control_resume(void);

/**
 * @brief local audio set volume api.
 * 
 * @param volume new value.
 * 
 * @note
 *   Volume api same as A2DP.
 */
void audio_local_audio_control_set_volume(uint32_t volume);

/**
 * @brief local audio set mute api.
 * 
 * @param mute new value.
 */
void audio_local_audio_control_set_mute(bool mute);

#ifdef __cplusplus
}
#endif

#endif /* __LOCAL_AUDIO_CONTROL_H__ */
