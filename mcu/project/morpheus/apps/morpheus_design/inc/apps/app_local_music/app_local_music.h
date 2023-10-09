#ifndef APP_LOCAL_MUSIC_H_
#define APP_LOCAL_MUSIC_H_
#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include <stdint.h>
#include <string.h>

#include "FreeRTOS.h"
#include "lfs.h"
#include "local_audio_control.h"
#include "local_stream_interface.h"
#include "music_file.h"
#include "music_solution.h"
typedef enum {
    PLAY_IDLE = 0,
    PLAY_START,
    PLAY_PLAYING,
    PLAY_NEXT,
    PLAY_REPEAT,
    PLAY_NEW_ID,
    PLAY_PAUSE,
    PLAY_STOP,
} player_state_t;

typedef enum {
    ACTION_IDLE = 0,
    ACTION_STOP,
    ACTION_PAUSE,
    ACTION_PLAY,
    ACTION_FORWARD,
    ACTION_REPEAT,
    ACTION_NEW_ID,
} player_action_t;

typedef struct {
    local_stream_if_t stream_if;
    player_state_t state;
    local_audio_state_t audio_state;
    lfs_t *lfs;
    lfs_file_t file;
    char path[PATH_MAX_LEN];
    uint32_t file_size;
    uint32_t id;
    uint32_t index;
    uint32_t music_ids_list[10];
    uint32_t music_ids_nums;
    bool ready;
    player_action_t last_action;
    player_action_t action;
    music_sulotion_t *p_solution;

    uint32_t volume;
} local_music_player_t;

void app_local_music_init();

void app_local_music_play();

void app_local_music_pause();

void app_local_music_play_pause();

void app_local_music_stop();

void app_local_music_play_next();

void app_local_music_task(void);

bool app_local_music_is_playing();

void app_local_play_idx(uint32_t idx);

void app_local_music_volume_up();

void app_local_music_volume_down();

void app_local_music_volume_set(uint8_t volume);

uint8_t app_local_music_volume_get(void);

#ifdef __cplusplus
}
#endif
#endif /* APP_LOCAL_MUSIC_H_ */
