
#include "music_file.h"

#include <errno.h>

#include "filesystem.h"
#include "syslog.h"

static lfs_t *lfs;

static bool initialized;

unsigned int atoui(const char *str) {
    unsigned int result = 0;
    char *tmp = str;
    int offset = 0;
    while (*tmp) {
        offset = *tmp - '0';
        if (offset < 0 || offset > 10) {
            return 0;
        }

        result = result * 10 + offset;
        tmp++;
    }

    return result;
}

void music_file_init(void) {
    lfs_dir_t dir;

    lfs = fs_get_lfs();
}

static void fill_path(char *path, uint32_t fd) {
    snprintf(path, PATH_MAX_LEN, "%s%u", MUSIC_DIR_PATH, fd);
}

int file_open(uint32_t fd, bool new, lfs_file_t *file) {
    int ret;

    char path[PATH_MAX_LEN];

    if (lfs == NULL) {
        return -ENODEV;
    }

    fill_path(path, fd);

    ret = lfs_file_open(lfs, file, path, LFS_O_CREAT | LFS_O_RDWR);
    if (ret < 0) return ret;
    if (new) ret = lfs_file_rewind(lfs, file);

    return ret;
}

int file_close(uint32_t fd, lfs_file_t *file) {
    int ret;

    char path[PATH_MAX_LEN];

    if (lfs == NULL) {
        return -ENODEV;
    }

    fill_path(path, fd);
    ret = lfs_file_close(lfs, file);

    return ret;
}
int file_write(lfs_file_t *file, const void *data, uint32_t size) {
    lfs_file_seek(lfs, file, 0, LFS_SEEK_END);
    int ret = lfs_file_write(lfs, file, data, size);
    if (ret < 0) {
        LOG_MSGID_I(LFS, "write bytes failed %d", 1, ret);
    }
    return ret;
}

int music_file_write(uint32_t fd, const void *data, uint32_t size,
                     bool append) {
    int ret;
    lfs_file_t file;
    char path[PATH_MAX_LEN];

    if (lfs == NULL) {
        return -ENODEV;
    }

    if (data == NULL || size == 0) {
        return -EINVAL;
    }

    fill_path(path, fd);

    if (append) {
        ret = lfs_file_open(lfs, &file, path,
                            LFS_O_CREAT | LFS_O_RDWR | LFS_O_APPEND);
    } else {
        ret = lfs_file_open(lfs, &file, path, LFS_O_CREAT | LFS_O_RDWR);
        if (ret < 0) return ret;
        ret = lfs_file_rewind(lfs, &file);
    }

    if (ret < 0) {
        LOG_MSGID_I(LFS, "open file failed %d", 1, ret);
        return ret;
    }

    ret = lfs_file_write(lfs, &file, data, size);
    if (ret < 0) {
        LOG_MSGID_I(LFS, "write bytes failed %d", 1, ret);
    }

    lfs_file_close(lfs, &file);

    return ret;
}

void music_file_files_get(music_files_t *files) {
    int ret = 0;
    lfs_dir_t dir;

    if (files == NULL) return;

    files->nums = 0;

    ret = lfs_dir_open(lfs, &dir, MUSIC_DIR_PATH);
    if (ret < 0) {
        LOG_MSGID_I(LFS, "dir open failed", 0);
        return;
    }
    LOG_MSGID_I(LFS, "ls files", 0);
    int index = 0;
    struct lfs_info info;
    while (true) {
        ret = lfs_dir_read(lfs, &dir, &info);

        /* error */
        if (ret < 0) {
            return;
        }

        /* end */
        if (ret == 0) {
            break;
        }

        /* file */
        if (info.type == LFS_TYPE_REG) {
            files->files[files->nums].fd = atoui(info.name);
            files->files[files->nums].size = info.size;
            LOG_MSGID_I(LFS, "music id %u in flash, file size %d", 2,
                        files->files[files->nums].fd, info.size);
            files->nums++;
        }

        if (files->nums >= MAX_FILE_NUMS) break;
    }

    lfs_dir_close(lfs, &dir);
}

int music_file_file_size(uint32_t fd) {
    int ret = 0;
    lfs_file_t file;
    vTaskDelay(5);
    char path[PATH_MAX_LEN];
    fill_path(path, fd);
    uint32_t retry = 0;
    do {
        ret = lfs_file_open(lfs, &file, path, LFS_O_RDONLY);
        if (ret == 0) {
            break;
        }

        /* no file exist */
        if (ret == LFS_ERR_NOENT) {
            LOG_MSGID_I(LFS, "get file size: no file exist", 0);
            // return 0;
        }

        if (ret == LFS_ERR_CORRUPT) {
            LOG_MSGID_I(LFS, "get file size: maybe other user opened this file",
                        0);
        }
        vTaskDelay(1);
        if (retry++ >= 3) return 0;

        LOG_MSGID_I(LFS, "get file size: open file failed. fd: %u, ret %d", 2,
                    fd, ret);
    } while (ret != 0);

    ret = lfs_file_size(lfs, &file);
    lfs_file_close(lfs, &file);
    LOG_MSGID_I(LFS, "get  file size %d", 1, ret);
    return (ret > 0) ? ret : 0;
}

void music_file_delete(uint32_t fd) {
    char path[PATH_MAX_LEN];

    if (lfs == NULL) {
        return -ENODEV;
    }

    fill_path(path, fd);

    lfs_remove(lfs, path);
}