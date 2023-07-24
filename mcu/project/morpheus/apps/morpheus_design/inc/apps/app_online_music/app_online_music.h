#ifndef APP_ONLINE_MUSIC_H_
#define APP_ONLINE_MUSIC_H_
#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include <stdint.h>

typedef enum {
    AUDIO_ACTION_NONE = 0,
    AUDIO_ACTION_APP_PLAY,        // key try to play or pause audio
    AUDIO_ACTION_APP_PAUSE,       // key try to play or pause audio
    AUDIO_ACTION_KEY_PLAY_PAUSE,  // key try to play or pause audio
    AUDIO_ACTION_KEY_FORWARD,     // key try to play or pause audio
    AUDIO_ACTION_SW_RESUME,       // 405 try to resume audio
    AUDIO_ACTION_SW_PAUSE,        // 405 try to pause audio
    AUDIO_ACTION_SW_STOP,         // 405 try to stop audio,  优先级最高
    AUDIO_ACTION_KEY_LOCAL_MODEL,
} play_action_t;

typedef enum {
    AUDIO_PLAY_STATE_STOP = 0,
    AUDIO_PLAY_STATE_A2DP_PLAY,
    AUDIO_PLAY_STATE_A2DP_PAUSE,
    AUDIO_PLAY_STATE_LOCAL_PLAY,
    AUDIO_PLAY_STATE_LOCAL_PAUSE,
} audio_play_state_t;

bool get_music_type(void);

void set_music_type(bool app_music);

void send_track_id_to_main(uint32_t id, bool playing);

void main_controller_audio_sm_reset(void);

void a2dp_check_start(void);

void a2dp_check_stop(void);

bool a2dp_checking(void);

void a2dp_playing_flag_set(bool flag);

bool a2dp_playing_flag_get(void);

void a2dp_play_handler(void);

void a2dp_pause_handler(void);

#ifdef __cplusplus
}
#endif
#endif /* APP_ONLINE_MUSIC_H_ */
