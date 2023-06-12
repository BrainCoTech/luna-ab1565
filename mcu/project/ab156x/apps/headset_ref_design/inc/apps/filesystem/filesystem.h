#ifndef FS_API_H_
#define FS_API_H_
#ifdef __cplusplus
extern "C" {
#endif
#include "lfs.h"
#include "lfs_util.h"

int fs_init(void);

int fs_uninit(void);

lfs_t* fs_get_lfs(void);

int fs_get_size(void);

int fs_format(void);

#ifdef __cplusplus
}
#endif
#endif /* FS_API_H_ */
