#ifndef MUSIC_FILE_RECEIVER_H_
#define MUSIC_FILE_RECEIVER_H_
#ifdef __cplusplus
extern "C" {
#endif

#include "stdbool.h"

typedef enum {
    MUSIC_SYNC_PAUSE = 1,
    MUSIC_SYNC_RESUME = 2,
    MUSIC_SYNC_STOP = 3,
} music_file_sync_event_t;

void file_receiver_task(void);

void send_sync_progress_to_app();

bool music_file_receiver_is_xfer(void);

void music_pause_sync(void);

void music_sync_event_set(music_file_sync_event_t event);

#ifdef __cplusplus
}
#endif
#endif /* MUSIC_FILE_RECEIVER_H_ */
