/* Copyright Statement:
 *
 * (C) 2005-2016  MediaTek Inc. All rights reserved.
 *
 * This software/firmware and related documentation ("MediaTek Software") are
 * protected under relevant copyright laws. The information contained herein
 * is confidential and proprietary to MediaTek Inc. ("MediaTek") and/or its licensors.
 * Without the prior written permission of MediaTek and/or its licensors,
 * any reproduction, modification, use or disclosure of MediaTek Software,
 * and information contained herein, in whole or in part, shall be strictly prohibited.
 * You may only use, reproduce, modify, or distribute (as applicable) MediaTek Software
 * if you have agreed to and been bound by the applicable license agreement with
 * MediaTek ("License Agreement") and been granted explicit permission to do so within
 * the License Agreement ("Permitted User").  If you are not a Permitted User,
 * please cease any access or use of MediaTek Software immediately.
 * BY OPENING THIS FILE, RECEIVER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
 * THAT MEDIATEK SOFTWARE RECEIVED FROM MEDIATEK AND/OR ITS REPRESENTATIVES
 * ARE PROVIDED TO RECEIVER ON AN "AS-IS" BASIS ONLY. MEDIATEK EXPRESSLY DISCLAIMS ANY AND ALL
 * WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
 * NEITHER DOES MEDIATEK PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
 * SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
 * SUPPLIED WITH MEDIATEK SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO SUCH
 * THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY ACKNOWLEDGES
 * THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES
 * CONTAINED IN MEDIATEK SOFTWARE. MEDIATEK SHALL ALSO NOT BE RESPONSIBLE FOR ANY MEDIATEK
 * SOFTWARE RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
 * STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND
 * CUMULATIVE LIABILITY WITH RESPECT TO MEDIATEK SOFTWARE RELEASED HEREUNDER WILL BE,
 * AT MEDIATEK'S OPTION, TO REVISE OR REPLACE MEDIATEK SOFTWARE AT ISSUE,
 * OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY RECEIVER TO
 * MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
 */

#ifndef __HAL_MD5_H__
#define __HAL_MD5_H__
#include "hal_platform.h"

#ifdef HAL_MD5_MODULE_ENABLED

#ifdef HAL_MD5_USE_PHYSICAL_MEMORY_ADDRESS
/**
 * @addtogroup HAL
 * @{
 * @addtogroup MD5
 * @{
 * This section introduces the MD5 driver APIs including terms and acronyms,
 * supported features, software architecture, details on how to use this driver. MD5 function groups, enums, structures and functions.
 *
 * @section HAL_MD5_Terms_Chapter Terms and acronyms
 *
 * |Terms                   |Details                                                                 |
 * |------------------------------|------------------------------------------------------------------------|
 * |\b MD5                        | Message-Digest Algorithm. For more information, please refer to <a href="https://zh.wikipedia.org/wiki/MD5">introduction to the MD5 in Wikipedia </a>.|
 *
 * @section HAL_MD5_Features_Chapter Supported features
 *
 * @section HAL_MD5_Driver_Usage_Chapter How to use this driver
 *
 *  To use the MD5 driver, the caller should allocate a buffer in physical memory region, e.g. TCM, SYSRAM and PSRAM.
 *  - Step 1. Call #hal_md5_init to() initialize the module.
 *  - Step 2. Call #hal_md5_append() to encrypt.
 *  - Step 3. Call #hal_md5_end() to get data.
 *  - sample code:
 *    @code
 *       ATTR_RWDATA_IN_NONCACHED_SYSRAM_4BYTE_ALIGN uint8_t *data = "abcdefghijklmnopqrstwxyz1234567";
 *       ATTR_RWDATA_IN_NONCACHED_SYSRAM_4BYTE_ALIGN uint8_t digest[HAL_MD5_DIGEST_SIZE] = {0};
 *       hal_md5_context_t context = {0};
 *       hal_md5_init(&context);
 *       hal_md5_append(&context, data, strlen(data));
 *       hal_md5_end(&context, digest);
 *    @endcode
 *
 *
 *
 */
#else
/**
 * @addtogroup HAL
 * @{
 * @addtogroup MD5
 * @{
 * This section introduces the MD5 driver APIs including terms and acronyms,
 * supported features, software architecture, details on how to use this driver. MD5 function groups, enums, structures and functions.
 *
 * @section HAL_MD5_Terms_Chapter Terms and acronyms
 *
 * |Terms                   |Details                                                                 |
 * |------------------------------|------------------------------------------------------------------------|
 * |\b MD5                        | Message-Digest Algorithm. For more information, please refer to <a href="https://zh.wikipedia.org/wiki/MD5">introduction to the MD5 in Wikipedia </a>.|
 *
 * @section HAL_MD5_Features_Chapter Supported features
 *
 * @section HAL_MD5_Driver_Usage_Chapter How to use this driver
 *
 *  - Step 1. Call #hal_md5_init to() initialize the module.
 *  - Step 2. Call #hal_md5_append() to encrypt.
 *  - Step 3. Call #hal_md5_end() to get data.
 *  - sample code:
 *    @code
 *       uint8_t *data = "abcdefghijklmnopqrstwxyz1234567";
 *       uint8_t digest[HAL_MD5_DIGEST_SIZE] = {0};
 *       hal_md5_context_t context = {0};
 *       hal_md5_init(&context);
 *       hal_md5_append(&context, data, strlen(data));
 *       hal_md5_end(&context, digest);
 *    @endcode
 *
 *
 *
 */
#endif


#include "hal_define.h"

#ifdef __cplusplus
extern "C" {
#endif

/** @defgroup hal_md5_define Define
  * @{
  */

#define HAL_MD5_BLOCK_SIZE    (64) /**< 512 bits = 64 bytes */
#define HAL_MD5_DIGEST_SIZE   (16) /**< 128 bits = 16 bytes */

/**
  * @}
  */


/** @defgroup hal_md5_enum Enum
  * @{
  */

/** @brief This enum defines the HAL interface return value.
  */
typedef enum {
    HAL_MD5_STATUS_BUSY  = -100,    /**< crypto hw is busy. */ 
    HAL_MD5_STATUS_ERROR = -1,      /**< An error occurred. */
    HAL_MD5_STATUS_OK = 0           /**< No error occurred. */
} hal_md5_status_t;

/**
  * @}
  */


/** @defgroup hal_md5_struct Struct
  * @{
  */

/** @brief MD5 context */
typedef struct {
    uint32_t hash_value[4];    /**< Hash value. */
    uint64_t message_length;   /**< Total size. */
    uint8_t  *block;           /**< A pointer to the start of the buffer. */
    uint8_t  buffer[HAL_MD5_BLOCK_SIZE];   /**< Data buffer. */
    uint32_t block_length;     /**< Block length for each operation. */
} hal_md5_context_t;

/**
  * @}
  */




/**
 * @brief     This function initializes the MD5 engine.
 * @param[in]  context is the parameter of this API, see #hal_md5_context_t.
 * @return  #HAL_MD5_STATUS_OK, if the operation completed successfully.
 * @sa     #hal_md5_init
 * @par    Example
 * Sample code, please refer to @ref HAL_MD5_Driver_Usage_Chapter.
 *
 */
hal_md5_status_t hal_md5_init(hal_md5_context_t *context);

/**
 * @brief     This function appends data for MD5 operation.
 * @param[in]  context is the parameter of this API, see #hal_md5_context_t.
 * @param[in]  message is the source data buffer.
 * @param[in]  length is the length of the parameter message.
 * @return  #HAL_MD5_STATUS_OK, if the operation completed successfully.
 * @par    Example
 * Sample code, please refer to @ref HAL_MD5_Driver_Usage_Chapter.
 *
 */
hal_md5_status_t hal_md5_append(hal_md5_context_t *context, uint8_t *message, uint32_t length);

/**
 * @brief     This function finishes the MD5 operation and receives the MD5 result.
 * @param[in]  context is the parameter of this API, see #hal_md5_context_t.
 * @param[out]  digest_message is the MD5 result.
 * @return  #HAL_MD5_STATUS_OK, if the operation completed successfully.
 * @par    Example
 * Sample code, please refer to @ref HAL_MD5_Driver_Usage_Chapter.
 *
 */
hal_md5_status_t hal_md5_end(hal_md5_context_t *context, uint8_t digest_message[HAL_MD5_DIGEST_SIZE]);


#ifdef __cplusplus
}
#endif

/**
* @}
* @}
*/
#endif /*HAL_MD5_MODULE_ENABLED*/

#endif /* __HAL_MD5_H__ */

