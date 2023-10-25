#ifndef MUSIC_SOLUTION_H_
#define MUSIC_SOLUTION_H_
#ifdef __cplusplus
extern "C" {
#endif

#include "stdint.h"

#define MUSIC_SOLUTION_NUMS 4

typedef struct {
    uint32_t solution_id;
    uint32_t music_id;
    uint32_t music_file_addr;
    uint32_t music_size;
    uint32_t music_offset;
} recv_file_t;

typedef struct {
    // 如果值是0，表示没有传输文件
    recv_file_t files[MUSIC_SOLUTION_NUMS];
    uint32_t nums;
} music_sulotion_t;

int music_solution_read(music_sulotion_t **sulotion);

int music_solution_write(const music_sulotion_t *sulotion);

int music_file_sync_status_get(recv_file_t **file);

int music_file_sync_status_set(const recv_file_t *file);

int music_file_is_exist(void);

#ifdef __cplusplus
}
#endif
#endif /* MUSIC_SOLUTION_H_ */
