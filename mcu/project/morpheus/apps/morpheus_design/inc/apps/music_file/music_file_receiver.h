#ifndef MUSIC_FILE_RECEIVER_H_
#define MUSIC_FILE_RECEIVER_H_
#ifdef __cplusplus
extern "C" {
#endif

#include "stdbool.h"

void file_receiver_task(void);

void send_sync_progress_to_app();

bool music_file_receiver_is_xfer(void);

void music_pause_sync(void);

#ifdef __cplusplus
}
#endif
#endif /* MUSIC_FILE_RECEIVER_H_ */
