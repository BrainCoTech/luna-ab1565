#include "music_solution.h"

#include <filesystem.h>
#include <stdint.h>

#include "syslog.h"

log_create_module(SOLUTION, PRINT_LEVEL_INFO);

#define SOLUTION_PATH "/music_solution"
#define SYNC_STATUS_PATH "/sync_status"

static music_sulotion_t m_music_solution;
static recv_file_t m_sync_status;

int music_solution_read(music_sulotion_t **sulotion) {
    int ret = 0;

    ret = fs_read(SOLUTION_PATH, &m_music_solution, sizeof(music_sulotion_t));


    for (int i = 0; i < MUSIC_SOLUTION_NUMS; i++) {
        LOG_MSGID_I(SOLUTION,
                    "read solution %u, file [%u], size %u, addr %x, offset %u",
                    5, m_music_solution.files[i].solution_id,
                    m_music_solution.files[i].music_id,
                    m_music_solution.files[i].music_size,
                    m_music_solution.files[i].music_file_addr,
                    m_music_solution.files[i].music_offset);
    }

    *sulotion = &m_music_solution;

    return ret;
}

int music_file_is_exist(void)
{
    int ret = 0;
    int num = 0;

    music_sulotion_t *sulotion = NULL;
    music_solution_read(&sulotion);

    if (sulotion != NULL) {
        for (int i = 0; i < MUSIC_SOLUTION_NUMS; i++) {
            if (m_music_solution.files[i].music_offset == m_music_solution.files[i].music_size &&
                m_music_solution.files[i].music_size != 0) {
                num++;
            }
        }
    }

    if (num == MUSIC_SOLUTION_NUMS) {
        ret = 1;
    }

    return ret;
}

music_sulotion_t *music_solution_get() { return &m_music_solution; }

int music_solution_write(const music_sulotion_t *sulotion) {
    int ret = 0;


    for (int i = 0; i < MUSIC_SOLUTION_NUMS; i++) {
        LOG_MSGID_I(SOLUTION,
                    "write solution %u, file [%u], size %u, addr %x, offset %u",
                    5, m_music_solution.files[i].solution_id,
                    m_music_solution.files[i].music_id,
                    m_music_solution.files[i].music_size,
                    m_music_solution.files[i].music_file_addr,
                    m_music_solution.files[i].music_offset);
    }

    ret = fs_write(SOLUTION_PATH, &m_music_solution, sizeof(music_sulotion_t),
                   false);

    return ret;
}

int music_file_sync_status_get(recv_file_t **file) {
    int ret = 0;

    ret = fs_read(SYNC_STATUS_PATH, &m_sync_status, sizeof(recv_file_t));


    LOG_MSGID_I(SOLUTION,
                "get sync status %u, file [%u], size %u, addr %x, offset %u", 5,
                m_sync_status.solution_id, m_sync_status.music_id,
                m_sync_status.music_size, m_sync_status.music_file_addr,
                m_sync_status.music_offset);

    *file = &m_sync_status;
    return ret;
}

int music_file_sync_status_set(const recv_file_t *file) {
    int ret = 0;

    memcpy(&m_sync_status, file, sizeof(recv_file_t));


    ret = fs_write(SYNC_STATUS_PATH, &m_sync_status, sizeof(recv_file_t), false);

    return ret;
}