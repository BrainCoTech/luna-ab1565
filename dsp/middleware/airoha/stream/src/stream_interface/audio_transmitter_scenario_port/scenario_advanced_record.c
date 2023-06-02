/* Copyright Statement:
 *
 * (C) 2022  Airoha Technology Corp. All rights reserved.
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
#include "scenario_advanced_record.h"
#ifdef AIR_SOFTWARE_DRC_ENABLE
#include "compander_interface_sw.h"
#endif

#ifdef AIR_LD_NR_ENABLE
void *p_advanced_record_ld_nr_key;
#endif

ATTR_TEXT_IN_IRAM static void ShareBufferCopy_D_32bit_to_I_24bit_2ch(uint32_t* src_buf1, uint32_t* src_buf2, uint8_t* dest_buf1, uint32_t samples)
{
    uint32_t data1;
    uint32_t data2;
    uint32_t i;

    for (i = 0; i < samples; i++) {
        data1 = src_buf1[i];
        data2 = src_buf2[i];
        *(dest_buf1+i*6+0) = (uint8_t)((data1>> 8)&0xff);
        *(dest_buf1+i*6+1) = (uint8_t)((data1>>16)&0xff);
        *(dest_buf1+i*6+2) = (uint8_t)((data1>>24)&0xff);
        *(dest_buf1+i*6+3) = (uint8_t)((data2>> 8)&0xff);
        *(dest_buf1+i*6+4) = (uint8_t)((data2>>16)&0xff);
        *(dest_buf1+i*6+5) = (uint8_t)((data2>>24)&0xff);
    }
}
ATTR_TEXT_IN_IRAM static void ShareBufferCopy_D_16bit_to_I_24bit_1ch(uint16_t* src_buf1, uint8_t* dest_buf1, uint32_t samples)
{
    uint32_t data32;
    uint32_t i, j;

    j = 0;
    for (i = 0; i < samples; i++) {
        if ((i % 4) == 0) {
            data32 = src_buf1[i] << 8; // 0x00XXXX00
            *(uint32_t *)(dest_buf1 + j * 12) = data32;
        } else if ((i % 4) == 1) {
            data32 = src_buf1[i]; //0x0000XXXX
            *(uint32_t *)(dest_buf1 + j * 12 + 4) = data32;
        } else if ((i % 4) == 2) {
            data32 = (src_buf1[i] & 0x00ff) << 24; // 0xXX000000
            *(uint32_t *)(dest_buf1 + j * 12 + 4) |= data32;
            data32 = (src_buf1[i] & 0xff00) >> 8;
            *(uint32_t *)(dest_buf1 + j * 12 + 8) = data32;
        } else {
            data32 = src_buf1[i] << 16; // 0xXXXX0000
            *(uint32_t *)(dest_buf1 + j * 12 + 8) |= data32;
            j++;
        }
    }
}

ATTR_TEXT_IN_IRAM static void ShareBufferCopy_D_32bit_to_D_24bit_1ch(uint32_t* src_buf, uint8_t* dest_buf1, uint32_t samples)
{
    uint32_t data;
    uint32_t i;

    for (i = 0; i < samples; i++)
    {
        data = src_buf[i];
        *(dest_buf1+i*3+0) = (uint8_t)((data>> 8)&0xff);
        *(dest_buf1+i*3+1) = (uint8_t)((data>>16)&0xff);
        *(dest_buf1+i*3+2) = (uint8_t)((data>>24)&0xff);
    }
}

ATTR_TEXT_IN_IRAM static void ShareBufferCopy_D_16bit_to_I_24bit_2ch(uint16_t* src_buf1, uint16_t* src_buf2, uint8_t* dest_buf1, uint32_t samples)
{
    uint32_t data32;
    uint16_t data16;
    uint32_t i;

    for (i = 0; i < samples; i++)
    {
        if ((i%2) == 0)
        {
            data32 = (src_buf1[i]<<8); // 0x00XXXX00
            data16 = src_buf2[i]; //0xXXXX
            *(uint32_t *)(dest_buf1 + i*6) = data32;
            *(uint16_t *)(dest_buf1 + i*6 + 4) = data16;
        }
        else
        {
            data16 = (src_buf1[i]&0x00ff)<<8; //0xXX00
            data32 = (src_buf2[i]<<16) | ((src_buf1[i]&0xff00)>>8); // 0xXXXX00XX
            *(uint16_t *)(dest_buf1 + i*6) = data16;
            *(uint32_t *)(dest_buf1 + i*6 + 2) = data32;
        }
    }
}

void advanced_record_init(SOURCE source, SINK sink, mcu2dsp_open_param_p open_param)
{
    UNUSED(source);
    if (sink->param.data_ul.scenario_sub_id == AUDIO_TRANSMITTER_ADVANCED_RECORD_N_MIC) {
        stream_resolution_t resolution;
        extern CONNECTION_IF advanced_record_n_mic_if;
        if(open_param->stream_in_param.afe.format <= HAL_AUDIO_PCM_FORMAT_U16_BE) {
            stream_feature_configure_resolution((stream_feature_list_ptr_t)advanced_record_n_mic_if.pfeature_table, RESOLUTION_16BIT, CONFIG_DECODER);
            resolution = RESOLUTION_16BIT;
        }
        else{
            stream_feature_configure_resolution((stream_feature_list_ptr_t)advanced_record_n_mic_if.pfeature_table, RESOLUTION_32BIT, CONFIG_DECODER);
            resolution = RESOLUTION_32BIT;
        }
#ifdef AIR_LD_NR_ENABLE
        ld_nr_port_t *ld_nr_port;
        ld_nr_config_t ld_nr_config;
        ld_nr_port = stream_function_ld_nr_get_port(source);
        ld_nr_config.channel_num = source->param.audio.channel_num;
        ld_nr_config.frame_size  = 240 * ((resolution == RESOLUTION_16BIT)? 2:4);
        ld_nr_config.resolution  = resolution;
        ld_nr_config.sample_rate = source->param.audio.rate;

        if (p_advanced_record_ld_nr_key == NULL) {
            //PSAP_LOG_E(g_PSAP_msg_id_string_12, "hearing-aid LD_NR NVKEY NULL", 0);
            configASSERT(0);
        }

        ld_nr_config.nvkey_para = p_advanced_record_ld_nr_key;
        ld_nr_config.background_process_enable = true;
        ld_nr_config.background_process_fr_num = 2;
        stream_function_ld_nr_init(ld_nr_port, &ld_nr_config);
        DSP_MW_LOG_I("[LD_NR]p_wireless_mic_ld_nr_key 0x%x channel_num=%d, resolution:%d", 3, p_advanced_record_ld_nr_key, source->param.audio.channel_num, resolution);
#endif /* AIR_LD_NR_ENABLE */
#ifdef AIR_SOFTWARE_DRC_ENABLE
    /* sw drc init */
    sw_compander_config_t drc_config;
    drc_config.mode = SW_COMPANDER_AUDIO_MODE;
    drc_config.channel_num = source->param.audio.channel_num;
    drc_config.sample_rate = source->param.audio.rate;
    drc_config.frame_base = 8;
    drc_config.recovery_gain = 4; /* 0dB */
    drc_config.vol_default_gain = 0x08000000; /* 0dB */
    drc_config.default_nvkey_mem = NULL;
    drc_config.default_nvkey_id = NVKEY_DSP_PARA_ADVANCED_RECORD_AU_CPD;
    sw_compander_port_t *drc_port = stream_function_sw_compander_get_port(source);
    stream_function_sw_compander_init(drc_port, &drc_config);
    DSP_MW_LOG_I("[advanced_record_n_mic]sw drc 0x%x info, %d, %d, %d, %d, 0x%x, 0x%x, 0x%x\r\n", 11,
                drc_port,
                drc_config.mode,
                drc_config.channel_num,
                drc_config.sample_rate,
                drc_config.frame_base,
                drc_config.recovery_gain,
                drc_config.vol_default_gain,
                drc_config.default_nvkey_id);
#endif
    }
}

void advanced_record_deinit(SOURCE source, SINK sink)
{
    UNUSED(source);
    if (sink->param.data_ul.scenario_sub_id == AUDIO_TRANSMITTER_ADVANCED_RECORD_N_MIC) {
#ifdef AIR_LD_NR_ENABLE
        ld_nr_port_t *ld_nr_port;
        ld_nr_port = stream_function_ld_nr_get_port(source);
        stream_function_ld_nr_deinit(ld_nr_port);
        preloader_pisplit_free_memory(p_advanced_record_ld_nr_key);
        p_advanced_record_ld_nr_key = NULL;
#endif /* AIR_LD_NR_ENABLE */
#ifdef AIR_SOFTWARE_DRC_ENABLE
        sw_compander_port_t *drc_port;
        drc_port = stream_function_sw_compander_get_port(source);
        stream_function_sw_compander_deinit(drc_port);
#endif
    }
}

uint32_t advanced_record_n_mic_sink_copy_payload(SINK sink, uint8_t *src_buf, uint8_t *dst_buf, uint32_t length)
{
    audio_codec_pcm_t *codec_pcm;
    uint32_t channel_mode, actual_Sample;
    hal_audio_format_t source_format, sink_format;

    UNUSED(length);

    sink_format = sink->param.data_ul.scenario_param.advanced_record_param.codec_param.pcm.format;
    source_format = sink->transform->source->param.audio.format;
    channel_mode = sink->param.data_ul.scenario_param.advanced_record_param.codec_param.pcm.channel_mode;

    codec_pcm = &(sink->param.data_ul.scenario_param.advanced_record_param.codec_param.pcm);
    actual_Sample = (codec_pcm->sample_rate * codec_pcm->frame_interval) / (1000 * 1000);
    if (channel_mode == 1) {
        if(source_format == HAL_AUDIO_PCM_FORMAT_S16_LE) {
            if (sink_format == HAL_AUDIO_PCM_FORMAT_S24_LE) {
                ShareBufferCopy_D_16bit_to_I_24bit_1ch((uint16_t *)src_buf, (uint8_t *)dst_buf, actual_Sample);
                length = actual_Sample * 3;
            } else if (sink_format == HAL_AUDIO_PCM_FORMAT_S16_LE) {
                memcpy(dst_buf, src_buf, actual_Sample * sizeof(uint16_t));
            }
        } else if(source_format >= HAL_AUDIO_PCM_FORMAT_S24_LE) {
            if (sink_format == HAL_AUDIO_PCM_FORMAT_S24_LE) {
                ShareBufferCopy_D_32bit_to_D_24bit_1ch((uint32_t *)src_buf, (uint8_t *)dst_buf, actual_Sample);
                length = actual_Sample * 3;
            } else if (sink_format == HAL_AUDIO_PCM_FORMAT_S16_LE) {
                AUDIO_ASSERT(0); //not support yet
            }
        }
    } else if (channel_mode == 2) {
        DSP_STREAMING_PARA_PTR stream = DSP_Streaming_Get(sink->transform->source, sink);
        VOID *src_buf1, *src_buf2;
        src_buf1 = stream->callback.EntryPara.out_ptr[0];
        if (sink->transform->source->param.audio.channel_num == 1) {
            src_buf2 = stream->callback.EntryPara.out_ptr[0];
        }
        else if(sink->transform->source->param.audio.channel_num == 2) {
            if(stream->callback.EntryPara.out_ptr[1] == NULL)
                src_buf2 = stream->callback.EntryPara.out_ptr[0];
            else
                src_buf2 = stream->callback.EntryPara.out_ptr[1];
        }
        if(source_format == HAL_AUDIO_PCM_FORMAT_S16_LE) {
            if (sink_format == HAL_AUDIO_PCM_FORMAT_S24_LE) {
                ShareBufferCopy_D_16bit_to_I_24bit_2ch((uint16_t *)src_buf1, (uint16_t *)src_buf2, (uint8_t *)dst_buf, actual_Sample);
                length = actual_Sample * 3 * 2;
            } else if (sink_format == HAL_AUDIO_PCM_FORMAT_S16_LE) {
                DSP_D2I_BufferCopy_16bit((uint16_t *)dst_buf, (uint16_t *)src_buf1, (uint16_t *)src_buf2, actual_Sample);
                length = length * 2;
            }
        } else if(source_format >= HAL_AUDIO_PCM_FORMAT_S24_LE) {
            if (sink_format == HAL_AUDIO_PCM_FORMAT_S24_LE) {
                ShareBufferCopy_D_32bit_to_I_24bit_2ch((uint32_t *)src_buf1, (uint32_t *)src_buf2, (uint8_t *)dst_buf, length / sizeof(uint32_t));
                length = actual_Sample * 3 * 2;
            } else if (sink_format == HAL_AUDIO_PCM_FORMAT_S16_LE) {
                AUDIO_ASSERT(0); //not support yet
            }
        }
    } else {
        AUDIO_ASSERT(0); //not support yet
    }

    // if(source_format == HAL_AUDIO_PCM_FORMAT_S16_LE) {
    //     LOG_AUDIO_DUMP(src_buf, actual_Sample * sizeof(uint16_t), WIRED_AUDIO_USB_OUT_O_1);
    // } else if(source_format >= HAL_AUDIO_PCM_FORMAT_S24_LE) {
    //     LOG_AUDIO_DUMP(src_buf, actual_Sample * sizeof(uint32_t), WIRED_AUDIO_USB_OUT_O_1);
    // }
    // //LOG_AUDIO_DUMP(dst_buf, length, WIRED_AUDIO_USB_OUT_O_2);

    return length;
}