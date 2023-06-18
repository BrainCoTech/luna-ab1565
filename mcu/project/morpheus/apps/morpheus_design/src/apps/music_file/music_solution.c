#include "music_solution.h"

#include <stdint.h>

#include "syslog.h"

log_create_module(SOLUTION, PRINT_LEVEL_INFO);

#define SYNC_INFO_SETTING "sync_info"

music_sulotion_t m_music_solution;

nvdm_status_t solution_read_from_nvdm(music_sulotion_t **sulotion) {
    uint32_t size = sizeof(music_sulotion_t);
    nvdm_status_t status = nvdm_read_data_item(NVDM_INTERNAL_USE_GROUP, SYNC_INFO_SETTING,
                        (uint8_t *)&m_music_solution, &size);
    if (status < NVDM_STATUS_OK)
        m_music_solution.nums = 0;

    for (int i = 0; i < m_music_solution.nums; i++) {
        LOG_MSGID_I(SOLUTION, "solution nvdm, file [%u], size %u, offset %u", 3,
                    m_music_solution.files[i].fd,
                    m_music_solution.files[i].size,
                    m_music_solution.files[i].offset);
    }
    *sulotion = &m_music_solution;
    return status;
}

nvdm_status_t solution_write_to_nvdm(const music_sulotion_t *sulotion) {
    nvdm_status_t status = NVDM_STATUS_OK;
    uint32_t size = sizeof(music_sulotion_t);
    status = nvdm_write_data_item(NVDM_INTERNAL_USE_GROUP, SYNC_INFO_SETTING,
                         NVDM_DATA_ITEM_TYPE_RAW_DATA,
                         (uint8_t *)&m_music_solution, size);
    for (int i = 0; i < m_music_solution.nums; i++) {
        LOG_MSGID_I(SOLUTION, "solution nvdm, file [%u], size %u, offset %u", 3,
                    m_music_solution.files[i].fd,
                    m_music_solution.files[i].size,
                    m_music_solution.files[i].offset);
    }
    return status;
}