/* Copyright Statement:
 *
 * (C) 2023  Airoha Technology Corp. All rights reserved.
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
#include <stdio.h>
#include <string.h>
#include "syslog.h"
#include "vendor_2_dec_parser_interface.h"

void bt_a2dp_sink_vendor_audio_payload_parser(uint8_t* paylaod_buffer_ptr, uint16_t payload_size, uint8_t* frame_number, uint16_t* frame_offset)
{
    uint16_t* ptr_frame_offset = frame_offset;
    uint32_t offset = 0;
    uint32_t idx = 0,frame_num;
    lhdc_frame_Info_t h_info;
    int32_t ret;

    // Get frame number from packet header
    frame_num = ((*paylaod_buffer_ptr & 0x3C) >> 2);

    // Skip packet header
    paylaod_buffer_ptr +=2;
    offset +=2;

    for (idx = 0; idx < frame_num; idx++)
    {
        ret = lhdcv5_util_dec_fetch_frame_info(paylaod_buffer_ptr, payload_size, &h_info);
        if (ret != 0)
        {
            LHDC_LOG_E("[vendor_playload_parser] Fetch Frame info FAIL (%d)\n", 1, ret);
            break;
        }
        *ptr_frame_offset = offset;

        // Next
        ptr_frame_offset++;
        offset += h_info.frame_len;
        paylaod_buffer_ptr +=  h_info.frame_len;
    }
    // the end of the last frame
    *ptr_frame_offset = offset;

    *frame_number = frame_num;

    return;
}

uint32_t bt_a2dp_sink_vendor_frame_size_parser(uint8_t* frame_buffer_ptr)
{
    uint32_t frame_size =0;
    lhdc_frame_Info_t h_info;
    int32_t ret;

    ret = lhdcv5_util_dec_fetch_frame_info(frame_buffer_ptr, 42, &h_info);
    if (ret != 0)
    {
        LHDC_LOG_E("[vendor_frame_size_parser] Fetch Frame info FAIL (%d) \n", 1, ret);
        return 0;
    }
    frame_size = h_info.frame_len;

    return frame_size;
}

 