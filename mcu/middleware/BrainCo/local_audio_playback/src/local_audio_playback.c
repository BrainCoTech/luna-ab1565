/*
 * Copyright (c) 2022 BrainCo Inc.
 *
 * All right reserved.
 */

#include <errno.h>	

#include "hal_audio_message_struct.h"
#include "hal_audio_internal.h"
#include "hal_audio_cm4_dsp_message.h"

#include "mp3_codec.h"
#include "mp3_codec_internal.h"
#include "audio_src_srv.h"
#include "audio_log.h"

#include "local_audio_control_internal.h"
#include "local_audio_source.h"
#include "local_audio_playback.h"

typedef enum {
	LOCAL_AUDIO_PLAYBACK_STATE_IDLE = 0,
	LOCAL_AUDIO_PLAYBACK_STATE_OPEN,
	LOCAL_AUDIO_PLAYBACK_STATE_START,
	LOCAL_AUDIO_PLAYBACK_STATE_STOP,
} local_audio_playback_state_t;

static local_audio_playback_state_t g_playback_state = LOCAL_AUDIO_PLAYBACK_STATE_IDLE;

extern void mp3_codec_event_send_from_isr(mp3_codec_queue_event_id_t id, void *parameter);

static void local_audio_playback_isr_handler(hal_audio_event_t event, void *data);

static int local_audio_playback_open(void)
{
	audio_message_type_t msg_type = AUDIO_MESSAGE_TYPE_PLAYBACK;
	mcu2dsp_audio_msg_t open_msg = MSG_MCU2DSP_PLAYBACK_OPEN;
	void *p_param_share;
	bool is_running;

	is_running = hal_audio_status_query_running_flag(AUDIO_MESSAGE_TYPE_PLAYBACK);
	if (is_running) {
		audio_src_srv_report("[LOCAL_AUDIO] play open, audio busy\r\n", 0);
		return -EBUSY;
	} else {
		hal_audio_status_set_running_flag(AUDIO_MESSAGE_TYPE_PLAYBACK, true);
	}

	mcu2dsp_open_param_t open_param;
	memset(&open_param, 0, sizeof(open_param));

	open_param.param.stream_in  = STREAM_IN_PLAYBACK;
	open_param.param.stream_out = STREAM_OUT_AFE;

	open_param.stream_in_param.playback.bit_type = HAL_AUDIO_BITS_PER_SAMPLING_16;
	open_param.stream_in_param.playback.sampling_rate = HAL_AUDIO_SAMPLING_RATE_48KHZ;
	open_param.stream_in_param.playback.channel_number = HAL_AUDIO_STEREO;
	open_param.stream_in_param.playback.codec_type = 0;  //KH: should use AUDIO_DSP_CODEC_TYPE_PCM
	open_param.stream_in_param.playback.p_share_info = (n9_dsp_share_info_t *)hal_audio_query_share_info(msg_type);
	hal_audio_reset_share_info(open_param.stream_in_param.playback.p_share_info);
	open_param.stream_in_param.playback.p_share_info->length = SHARE_BUFFER_BT_AUDIO_DL_SIZE;
	memset((void *)open_param.stream_in_param.playback.p_share_info->start_addr, 0, open_param.stream_in_param.playback.p_share_info->length);
	open_param.stream_in_param.playback.p_share_info->bBufferIsFull = true;

	open_param.stream_out_param.afe.audio_device    = HAL_AUDIO_DEVICE_DAC_DUAL;
	open_param.stream_out_param.afe.stream_channel  = HAL_AUDIO_DIRECT;
	open_param.stream_out_param.afe.memory          = HAL_AUDIO_MEM1;
	open_param.stream_out_param.afe.format          = AFE_PCM_FORMAT_S16_LE;
	open_param.stream_out_param.afe.sampling_rate   = 48000;
	open_param.stream_out_param.afe.irq_period      = 10;
	open_param.stream_out_param.afe.frame_size      = 512;
	open_param.stream_out_param.afe.frame_number    = 4;
	open_param.stream_out_param.afe.hw_gain         = true;
	hal_audio_get_stream_out_setting_config(AU_DSP_AUDIO, &open_param.stream_out_param);
	open_param.stream_out_param.afe.audio_interface = HAL_AUDIO_INTERFACE_1;
	p_param_share = hal_audio_dsp_controller_put_paramter(&open_param, sizeof(mcu2dsp_open_param_t), msg_type);

	ami_hal_audio_status_set_running_flag(AUDIO_MESSAGE_TYPE_PLAYBACK, true);
	hal_audio_dsp_dl_clkmux_control(AUDIO_MESSAGE_TYPE_PLAYBACK, open_param.stream_out_param.afe.audio_device, open_param.stream_out_param.afe.sampling_rate, TRUE);
	hal_audio_dsp_controller_send_message(open_msg, AUDIO_DSP_CODEC_TYPE_PCM, (uint32_t)p_param_share, true);
	hal_audio_register_stream_out_callback(local_audio_playback_isr_handler, NULL);

	g_playback_state = LOCAL_AUDIO_PLAYBACK_STATE_OPEN;

	return 0;
}

static int local_audio_playback_start(void)
{
	mcu2dsp_start_param_t start_param;
	audio_message_type_t msg_type = AUDIO_MESSAGE_TYPE_PLAYBACK;
	mcu2dsp_audio_msg_t start_msg = MSG_MCU2DSP_PLAYBACK_START;

	start_param.param.stream_in     = STREAM_IN_PLAYBACK;
	start_param.param.stream_out    = STREAM_OUT_AFE;
	start_param.stream_out_param.afe.aws_flag   =  false;
	void *p_param_share = hal_audio_dsp_controller_put_paramter(&start_param, sizeof(mcu2dsp_start_param_t), msg_type);
	hal_audio_dsp_controller_send_message(start_msg, 0, (uint32_t)p_param_share, true);

	g_playback_state = LOCAL_AUDIO_PLAYBACK_STATE_START;

	return 0;
}

static int local_audio_playback_stop(void)
{
	audio_message_type_t msg_type = AUDIO_MESSAGE_TYPE_PLAYBACK;
	mcu2dsp_audio_msg_t stop_msg = MSG_MCU2DSP_PLAYBACK_STOP;

	hal_audio_dsp_controller_send_message(stop_msg, AUDIO_DSP_CODEC_TYPE_PCM, 0, true);
	hal_audio_service_unhook_callback(msg_type);
 
 	g_playback_state = LOCAL_AUDIO_PLAYBACK_STATE_STOP;

	return 0;
}

static int local_audio_playback_close(void)
{
	mcu2dsp_audio_msg_t close_msg = MSG_MCU2DSP_PLAYBACK_CLOSE;

	hal_audio_dsp_controller_send_message(close_msg, AUDIO_DSP_CODEC_TYPE_PCM, 0, true);
	hal_audio_dsp_dl_clkmux_control(AUDIO_MESSAGE_TYPE_PLAYBACK, 0, 0, false);
	if (hal_audio_status_query_running_flag(AUDIO_MESSAGE_TYPE_PLAYBACK)) {
		ami_hal_audio_status_set_running_flag(AUDIO_MESSAGE_TYPE_PLAYBACK, false);
	}

	g_playback_state = LOCAL_AUDIO_PLAYBACK_STATE_IDLE;

	return 0;
}

static void local_audio_playback_data_request_handle(void)
{
	local_audio_source_t *src = local_audio_get_src();
	audio_message_type_t msg_type = AUDIO_MESSAGE_TYPE_PLAYBACK;
	n9_dsp_share_info_t *p_info = (n9_dsp_share_info_t *)hal_audio_query_share_info(msg_type);
	uint32_t hal_buff_size, out_pcm_buff_size,  out_pcm_size;
	uint8_t *out_pcm_buff = NULL;
	
	for (uint32_t i = 0U; i < 2; i++) {
		hal_buff_size = hal_audio_buf_mgm_get_free_byte_count(p_info);

		ring_buffer_get_read_information(src->stream_out_pcm_buff, &out_pcm_buff, &out_pcm_buff_size);

		if (out_pcm_buff_size > 0) {
			out_pcm_size = MINIMUM(hal_buff_size, out_pcm_buff_size);
		
			hal_audio_write_stream_out_by_type(msg_type, out_pcm_buff, out_pcm_size);
			
			ring_buffer_read_done(src->stream_out_pcm_buff, out_pcm_size);

			if ((hal_buff_size - out_pcm_buff_size) == 0) {
				break;
			}
		} else {
			hal_audio_write_stream_out_by_type(msg_type, out_pcm_buff, 0);
		}
	}

	mp3_codec_event_send_from_isr(MP3_CODEC_QUEUE_EVENT_DECODE, src->mp3_hdl);
}

void local_audio_playback_isr_handler(hal_audio_event_t event, void *data)
{
	local_audio_context_t *ctx = local_audio_get_ctx();
	local_audio_source_t *src = local_audio_get_src();

	audio_src_srv_report("[LOCAL_AUDIO] play isr, event (%d) /r/n", 1, event);

	switch (event) {
	case HAL_AUDIO_EVENT_DATA_REQUEST:
		local_audio_playback_data_request_handle();
		break;
	case HAL_AUDIO_EVENT_END:
		/**
		 * @brief DSP wants to end the playback. 
		 *   Nomally there have some un-recoverable error happened.
		 */
		local_audio_update_state(ctx, LOCAL_AUDIO_STATE_ERROR);
        audio_src_srv_update_state(src->audio_hdl, AUDIO_SRC_SRV_EVT_PREPARE_STOP);
		break;
	}
}

int audio_local_audio_playback_open(void)
{
	if (g_playback_state != LOCAL_AUDIO_PLAYBACK_STATE_IDLE) {
		return -EINVAL;
	}
	return local_audio_playback_open();
}

int audio_local_audio_playback_start(void)
{
	if (g_playback_state != LOCAL_AUDIO_PLAYBACK_STATE_OPEN) {
		return -EINVAL;
	}
	return local_audio_playback_start();
}

int audio_local_audio_playback_stop(void)
{
	if (g_playback_state != LOCAL_AUDIO_PLAYBACK_STATE_START) {
		return -EINVAL;
	}
	return local_audio_playback_stop();
}

int audio_local_audio_playback_close(void)
{
	if (g_playback_state != LOCAL_AUDIO_PLAYBACK_STATE_STOP) {
		return -EINVAL;
	}
	
	return local_audio_playback_close();
}
