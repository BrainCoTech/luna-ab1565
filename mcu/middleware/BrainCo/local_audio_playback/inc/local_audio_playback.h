/*
 * Copyright (c) 2022 BrainCo Inc.
 *
 * All right reserved.
 */

#ifndef __LOCAL_AUDIO_PLAYBACK_H__
#define __LOCAL_AUDIO_PLAYBACK_H__

#include "local_stream_interface.h"

#ifdef __cplusplus
extern "C" {
#endif

int audio_local_audio_playback_open(void);
int audio_local_audio_playback_start(void);
int audio_local_audio_playback_stop(void);
int audio_local_audio_playback_close(void);

#ifdef __cplusplus
}
#endif

#endif /* __LOCAL_AUDIO_PLAYBACK_H__ */
