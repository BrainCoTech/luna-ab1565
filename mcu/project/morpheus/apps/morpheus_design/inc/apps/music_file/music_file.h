#ifndef MUSIC_FILE_H_
#define MUSIC_FILE_H_
#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include <stdint.h>
#include "filesystem.h"

typedef struct {
    uint32_t fd;
    uint32_t size;
} file_info_t;

#define MAX_FILE_NUMS 20
#define MUSIC_DIR_PATH "/"
#define PATH_MAX_LEN 20

typedef struct {
    file_info_t files[MAX_FILE_NUMS];
    uint32_t nums;
} music_files_t;

void music_file_init(void);

int music_file_write(uint32_t fd, const void *data, uint32_t size, bool append);

void music_file_files_get(music_files_t *files);

int music_file_file_size(uint32_t fd);

void music_file_delete(uint32_t fd);

int file_open(uint32_t fd, bool new, lfs_file_t *file);
int file_write(lfs_file_t *file, const void *data, uint32_t size);
int file_close(uint32_t fd, lfs_file_t *file);

#ifdef __cplusplus
}
#endif
#endif /* MUSIC_FILE_H_ */
