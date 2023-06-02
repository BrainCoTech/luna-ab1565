/* Copyright Statement:
 *
 * (C) 2021  Airoha Technology Corp. All rights reserved.
 *
 * This software/firmware and related documentation ("Airoha Software") are
 * protected under relevant copyright laws. The information contained herein
 * is confidential and proprietary to Airoha Technology Corp. ("Airoha") and/or its licensors.
 * Without the prior written permission of Airoha and/or its licensors,
 * any reproduction, modification, use or disclosure of Airoha Software,
 * and information contained herein, in whole or in part, shall be strictly prohibited.
 * You may only use, reproduce, modify, or distribute (as applicable) Airoha Software
 * if you have agreed to and been bound by the applicable license agreement with
 * Airoha ("License Agreement") and been granted explicit permission to do so within
 * the License Agreement ("Permitted User").  If you are not a Permitted User,
 * please cease any access or use of Airoha Software immediately.
 * BY OPENING THIS FILE, RECEIVER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
 * THAT AIROHA SOFTWARE RECEIVED FROM AIROHA AND/OR ITS REPRESENTATIVES
 * ARE PROVIDED TO RECEIVER ON AN "AS-IS" BASIS ONLY. AIROHA EXPRESSLY DISCLAIMS ANY AND ALL
 * WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
 * NEITHER DOES AIROHA PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
 * SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
 * SUPPLIED WITH AIROHA SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO SUCH
 * THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY ACKNOWLEDGES
 * THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES
 * CONTAINED IN AIROHA SOFTWARE. AIROHA SHALL ALSO NOT BE RESPONSIBLE FOR ANY AIROHA
 * SOFTWARE RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
 * STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND AIROHA'S ENTIRE AND
 * CUMULATIVE LIABILITY WITH RESPECT TO AIROHA SOFTWARE RELEASED HEREUNDER WILL BE,
 * AT AIROHA'S OPTION, TO REVISE OR REPLACE AIROHA SOFTWARE AT ISSUE,
 * OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY RECEIVER TO
 * AIROHA FOR SUCH AIROHA SOFTWARE AT ISSUE.
 */

#ifndef _LD_NR_PORTABLE_H_
#define _LD_NR_PORTABLE_H_

#if defined(AIR_LD_NR_ENABLE) && defined(AIR_LD_NR_USE_PIC)

extern void *ld_nr_export_parameters[];

/* Includes ------------------------------------------------------------------*/
#include "types.h"

/* Public define -------------------------------------------------------------*/
/* Public typedef ------------------------------------------------------------*/
typedef int (*LD_NR_SVN_version_t)(void);
typedef int (*LD_NR_get_memsize_t)(void);
typedef void (*LD_NR_fir_init_t)(void *st_t, void *p_LD_Nvkey, int16_t mode);
typedef int (*LD_NR_fir_proc1_t)(void *st_t, int16_t *indat, int16_t *out);
typedef int (*LD_NR_fir_proc2_t)(void *st_t);

#define LD_NR_get_memsize ((LD_NR_get_memsize_t)ld_nr_export_parameters[0])
#define LD_NR_fir_init ((LD_NR_fir_init_t)ld_nr_export_parameters[1])
#define LD_NR_fir_proc1 ((LD_NR_fir_proc1_t)ld_nr_export_parameters[2])
#define LD_NR_fir_proc2 ((LD_NR_fir_proc2_t)ld_nr_export_parameters[3])
#define LD_NR_SVN_version ((LD_NR_SVN_version_t)ld_nr_export_parameters[4])

/* Public macro --------------------------------------------------------------*/
/* Public variables ----------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/

uint32_t ld_nr_library_load();
uint32_t ld_nr_library_unload();


#endif /* AIR_LD_NR_ENABLE */

#endif /* _LD_NR_PORTABLE_H_ */
