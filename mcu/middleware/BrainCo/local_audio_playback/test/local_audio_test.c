/*
 * Copyright (c) 2022 BrainCo Inc.
 *
 * All right reserved.
 */

#include "FreeRTOS.h"
#include "task.h"

#include "audio_src_srv.h"
#include "audio_log.h"

#include "local_stream_raw.h"

#include "local_audio_control.h"

void local_audio_user_callback(local_audio_state_t state, void *user_data)
{
	audio_src_srv_report("[LOCAL_AUDIO] test: %d\r\n", 1, state);

	if (state == LOCAL_AUDIO_STATE_FINISH) {
		audio_src_srv_report("[LOCAL_AUDIO] test: playing\r\n", 0);
	}

	if (state == LOCAL_AUDIO_STATE_READY) {
		audio_src_srv_report("[LOCAL_AUDIO] test: test pass\r\n", 0);
	}
}

void local_audio_test(void *arg)
{
	struct local_stream_interface *stream;
	int ret = 0;

	audio_src_srv_report("[LOCAL_AUDIO] test", 0);

	vTaskDelay(5000 / portTICK_RATE_MS);

	stream = local_stream_raw_init();
	if (stream == NULL) {
		audio_src_srv_report("[LOCAL_AUDIO] test: stream fail\r\n", 0);
		goto error;
	}

	ret = audio_local_audio_control_init(local_audio_user_callback, NULL);
	if (ret < 0) {
		audio_src_srv_report("[LOCAL_AUDIO] test: audio init fail/r/n", 0);
		goto error;
	}

	/* ========== TEST PLAY ============== */

	vTaskDelay(5000 / portTICK_RATE_MS);

	ret = audio_local_audio_control_play(stream);
	if (ret < 0) {
		audio_src_srv_report("[LOCAL_AUDIO] test: play test fail\r\n", 0);
		goto error;
	}

	/* ========== TEST STOP ============== */

	vTaskDelay(5000 / portTICK_RATE_MS);

	ret = audio_local_audio_control_play(stream);
	if (ret < 0) {
		audio_src_srv_report("[LOCAL_AUDIO] test: stop test A fail\r\n", 0);
		goto error;
	}

	/* Delay 1 second for playback, also can check the callback state to LOCAL_AUDIO_STATE_PLAYING. */
	vTaskDelay(1000 / portTICK_RATE_MS);

	ret = audio_local_audio_control_stop();
	if (ret < 0) {
		audio_src_srv_report("[LOCAL_AUDIO] test: stop test B fail\r\n", 0);
		goto error;
	}

	/* ========== TEST PAUSE ============== */

	vTaskDelay(5000 / portTICK_RATE_MS);

	ret = audio_local_audio_control_play(stream);
	if (ret < 0) {
		audio_src_srv_report("[LOCAL_AUDIO] test: pause test A fail\r\n", 0);
		goto error;
	}

	/* Delay 1 second for playback, also can check the callback state to LOCAL_AUDIO_STATE_PLAYING. */
	vTaskDelay(1000 / portTICK_RATE_MS);

	ret = audio_local_audio_control_pause();
	if (ret < 0) {
		audio_src_srv_report("[LOCAL_AUDIO] test: pause test B fail\r\n", 0);
		goto error;
	}

	/* Delay 1 second for pause, also can check the callback state to LOCAL_AUDIO_STATE_PAUSE. */
	vTaskDelay(1000 / portTICK_RATE_MS);

	ret = audio_local_audio_control_resume();
	if (ret < 0) {
		audio_src_srv_report("[LOCAL_AUDIO] test: pause test C fail\r\n", 0);
		goto error;
	}

	audio_src_srv_report("[LOCAL_AUDIO] CONGRATULATIONS, ALL TEST PASSED!/r/n", 0);

error:
	while (1) {
		vTaskDelay(1000 / portTICK_RATE_MS);
	}
}
