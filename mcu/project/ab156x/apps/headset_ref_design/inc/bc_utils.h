#ifndef UTILS_H_
#define UTILS_H_
#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

typedef struct {
    uint8_t *data;
    uint32_t size;
} uint8_array_t;

#ifdef __cplusplus
}
#endif
#endif /* UTILS_H_ */
