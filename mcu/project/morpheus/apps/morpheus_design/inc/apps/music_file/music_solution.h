#ifndef MUSIC_SOLUTION_H_
#define MUSIC_SOLUTION_H_
#ifdef __cplusplus
extern "C" {
#endif

#include "stdint.h"
#include "main_bt/main_bt_msg_helper.h"
#include "nvdm.h"
#include "nvdm_id_list.h"

#define MAX_MUSIC_FILE_NUMS 6

typedef struct {
    uint32_t fd;
    uint32_t offset;
    uint32_t size;
} recv_file_t;

typedef struct {
    recv_file_t files[MAX_MUSIC_FILE_NUMS];
    uint32_t nums;
    MusicPlayMode mode;
    uint32_t single_id;
} music_sulotion_t;

nvdm_status_t solution_read_from_nvdm(music_sulotion_t **sulotion);

nvdm_status_t solution_write_to_nvdm(const music_sulotion_t *sulotion);

#ifdef __cplusplus
}
#endif
#endif /* MUSIC_SOLUTION_H_ */
