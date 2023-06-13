#include "filesystem.h"

#include <errno.h>
#include <string.h>

#include "bsp_flash.h"
#include "lfs.h"
#include "syslog.h"

static lfs_t lfs;
static bool initialized;

#define SECTOR_SIZE 4096
#define SECTOR_NUMS 16384
#define PAGE_SIZE 1024

log_create_module(LFS, PRINT_LEVEL_INFO);

static int lfs_port_read(const struct lfs_config *c, lfs_block_t block,
                         lfs_off_t off, void *buffer, lfs_size_t size) {
    int ret = 0;

    ret = bsp_flash_read(block * c->block_size + off + SPI_SERIAL_FLASH_ADDRESS,
                         buffer, size);

    return ret;
}

static int lfs_port_write(const struct lfs_config *c, lfs_block_t block,
                          lfs_off_t off, const void *buffer, lfs_size_t size) {
    int ret = 0;

    ret = bsp_flash_write(
        block * c->block_size + off + SPI_SERIAL_FLASH_ADDRESS, buffer, size);

    if (ret < 0) {
        ret = LFS_ERR_CORRUPT;
        LOG_MSGID_I(LFS, "lfs_port_write, error %d\r\n", 1, ret);
    }

    return ret;
}

static int lfs_port_erase(const struct lfs_config *c, lfs_block_t block) {
    int ret = 0;

    ret = bsp_flash_erase(block * c->block_size + SPI_SERIAL_FLASH_ADDRESS,
                          BSP_FLASH_BLOCK_4K);
    if (ret < 0) {
        ret = LFS_ERR_CORRUPT;
        LOG_MSGID_I(LFS, "lfs_port_erase, error %d\r\n", 1, ret);
    }
    return ret;
}

static int lsf_port_sync(const struct lfs_config *c) { return 0; }

const struct lfs_config cfg = {
    .read = lfs_port_read,
    .prog = lfs_port_write,
    .erase = lfs_port_erase,
    .sync = lsf_port_sync,
    .read_size = PAGE_SIZE,
    .prog_size = PAGE_SIZE,
    .block_size = SECTOR_SIZE,
    .block_count = SECTOR_NUMS,
    .block_cycles = 100,
    .cache_size = PAGE_SIZE,
    .lookahead_size = PAGE_SIZE,
};

int fs_init(void) {
    int err = 0;

    bsp_flash_init();

    err = lfs_mount(&lfs, &cfg);
    if (err) {
        LOG_MSGID_I(LFS, "lfs_mount fail, error %d\r\n", 1, err);

        lfs_format(&lfs, &cfg);
        err = lfs_mount(&lfs, &cfg);
        if (err) {
            LOG_MSGID_I(LFS, "initialized fail, error %d\r\n", 1, err);
            return -ENODEV;
        }
    }

    initialized = true;
    LOG_MSGID_I(LFS, "initialized success\r\n", 0);

    return 0;
}

int fs_uninit(void) {
    if (initialized) {
        lfs_unmount(&lfs);
    }
    return 0;
}

lfs_t *fs_get_lfs(void) {
    if (initialized) {
        return &lfs;
    } else {
        return NULL;
    }
}

typedef struct {
    lfs_size_t block_size;
    lfs_size_t block_count;
    lfs_size_t block_use;
    lfs_size_t block_free;
} lfs_block_state_t;

static int traverse_df_cb(void *p, lfs_block_t block) {
    *(lfs_size_t *)p += 1;
    return 0;
}

int lfs_block_state(lfs_t *lfs, lfs_block_state_t *state) {
    int err;
    uint32_t allocatedblock = 0;

    memset(state, 0, sizeof(lfs_block_state_t));

    err = lfs_fs_traverse(lfs, traverse_df_cb, &allocatedblock);

    if (err < 0) {
        return err;
    }

    state->block_size = lfs->cfg->block_size;
    state->block_count = lfs->cfg->block_count;
    state->block_use = allocatedblock;
    state->block_free = lfs->cfg->block_count - allocatedblock;

    return 0;
}

int fs_get_size(void) {
    lfs_block_state_t state;

    lfs_block_state(&lfs, &state);
    LOG_MSGID_I(LFS, "Flash use_block=%u free_block=%u  free_byte = %u \r\n", 3,
                state.block_use, state.block_free,
                state.block_size * state.block_free);

    return 0;
}

int fs_format(void) {
    int err = 0;

    if (initialized) {
        lfs_unmount(&lfs);
    }

    err = lfs_format(&lfs, &cfg);
    if (err) {
        LOG_MSGID_I(LFS, "lfs_format fail, error %d\r\n", 1, err);
    }
    LOG_MSGID_I(LFS, "lfs_format\r\n", 0);

    err = lfs_mount(&lfs, &cfg);

    return err;
}
