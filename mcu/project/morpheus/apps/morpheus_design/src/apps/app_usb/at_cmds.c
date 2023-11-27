#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include "at_shell.h"
#include "main_bt/main_bt_msg_helper.h"
#include "morpheus.h"

#define PARAMS_NUM_0 (0)
#define PARAMS_NUM_1 (1 << 1)
#define PARAMS_NUM_2 (1 << 2)
#define PARAMS_STR (1 << 3)

#define RESP_NUM_0 (0)
#define RESP_NUM_1 (1 << 1)
#define RESP_NUM_2 (1 << 2)
#define RESP_STR (1 << 3)

#define AT_RESP_BUF_SIZE (16)
#define POLL_TIME  (100)
#define WAIT_TIME  (5000)
#define WAIT_TIME_FOR_KEY  (10000)

static bool wait_factory_cmd_resp;
static bool factory_cmd_busy;
static char resp_str[64];
static AtCommandResp wait_cmd_resp = {
    .cmd = AT__CMD__UNUSED,
    .status = 0,
    .value1 = 0,
    .value2 = 0,
    .str_value = resp_str,
};

void main_bt_at_cmd_resp(uint32_t msg_id, AtCommandResp *resp) {
    if (resp->cmd != wait_cmd_resp.cmd) {
        return;
    }

    wait_factory_cmd_resp = false;
    wait_cmd_resp.status = resp->status;
    wait_cmd_resp.value1 = resp->value1;
    wait_cmd_resp.value2 = resp->value2;
    wait_cmd_resp.str_value = resp_str;
    memset(resp_str, 0, sizeof(resp_str));
    if (resp->str_value != NULL) {
        strncpy(resp_str, resp->str_value, strlen(resp->str_value));
        printf("app_usb, wait_cmd_resp.str_value %s, strlen: %d, %d",
               wait_cmd_resp.str_value, strlen(resp->str_value),
               strlen(resp_str));
    }

    LOG_MSGID_I(app_usb, "at_cmd_resp: cmd %d, status %d, value1 %u, value2 %u",
                4, wait_cmd_resp.cmd, wait_cmd_resp.status,
                wait_cmd_resp.value1, wait_cmd_resp.value2);
}

int send_factory_cmd_to_main(AtCommand *cmd, AtCommandResp **resp) {
    int ret = 0;
    BtMain msg = BT_MAIN__INIT;
    static uint32_t msg_id = 0;
    int count = 0;
    int count_threshold = 0;

    msg.msg_id = msg_id++;
    msg.at_cmd = cmd;

    /* 保存当前的命令 */
    wait_cmd_resp.cmd = cmd->cmd;
    *resp = &wait_cmd_resp;

    if (factory_cmd_busy) {
        return -EBUSY;
    }
    factory_cmd_busy = true;

    send_msg_to_main_controller(&msg);
    wait_factory_cmd_resp = true;

    if (cmd->cmd == AT__CMD__BUTTON_GET) {
        count_threshold = WAIT_TIME_FOR_KEY / POLL_TIME;
    } else {
        count_threshold = WAIT_TIME / POLL_TIME;
    }
    while (wait_factory_cmd_resp && count++ < count_threshold) {
        vTaskDelay(100);
    }

    factory_cmd_busy = false;

    if (wait_factory_cmd_resp) {
        LOG_MSGID_I(app_usb, "at cmd to main timeout", 0);
        return -ETIME;
    }

    return 0;
}

void at_cmd_excute(char *str, int params_flag, ATCMD cmd, int resp_flag) {
    int err = 0;
    AtCommand cmd_msg = AT_COMMAND__INIT;
    AtCommandResp *resp = NULL;
    char at_resp_buf[AT_RESP_BUF_SIZE];

    memset(at_resp_buf, 0, sizeof(at_resp_buf));
    cmd_msg.cmd = cmd;

    if (params_flag == PARAMS_NUM_1) {
        sscanf(str, "%d", &cmd_msg.params1);
    } else if (params_flag == PARAMS_NUM_2) {
        sscanf(str, "%d,%d", &cmd_msg.params1, &cmd_msg.params2);
    } else if (params_flag == PARAMS_STR) {
        cmd_msg.str_value = str;
    }

    err = send_factory_cmd_to_main(&cmd_msg, &resp);
	if (err == -ETIME) {
        LOG_MSGID_E(app_usb, "at cmd to main, timeout", 0);
		at_cmd_print(AT_CMD_RESP_ERROR, strlen(AT_CMD_RESP_ERROR));
		goto err;
	}

	if (err == -EBUSY) {
        LOG_MSGID_E(app_usb, "at cmd to main, busy", 0);
		at_cmd_print(AT_CMD_RESP_ERROR, strlen(AT_CMD_RESP_ERROR));
		goto err;
	}

    if (err < 0 || resp == NULL) {
		at_cmd_print(AT_CMD_RESP_ERROR, strlen(AT_CMD_RESP_ERROR));
        goto err;
    }

    if (resp->status < 0) {
        LOG_MSGID_E(app_usb, "at cmd to main, error", 0);
		at_cmd_print(AT_CMD_RESP_ERROR, strlen(AT_CMD_RESP_ERROR));
        goto err;
    }

    if (resp_flag == PARAMS_NUM_1) {
        snprintf(at_resp_buf, AT_RESP_BUF_SIZE, "%d\r\n", resp->value1);
        at_cmd_print(at_resp_buf, strlen(at_resp_buf));
    } else if (resp_flag == PARAMS_NUM_2) {
        snprintf(at_resp_buf, AT_RESP_BUF_SIZE, "%d,%d\r\n", resp->value1,
                 resp->value2);
        at_cmd_print(at_resp_buf, strlen(at_resp_buf));
    } else if (resp_flag == PARAMS_STR) {
        at_cmd_print(resp->str_value, strlen(resp->str_value));
        at_cmd_print(AT_CMD_NEXTLINE, strlen(AT_CMD_NEXTLINE));
    }

    at_cmd_print(AT_CMD_RESP_OK, strlen(AT_CMD_RESP_OK));
    at_cmd_print(AT_CMD_NEXTLINE, strlen(AT_CMD_NEXTLINE));

    return;

err:
    at_cmd_print(AT_CMD_NEXTLINE, strlen(AT_CMD_NEXTLINE));
}

void at_query_gd_ver(void *ctx) {
    at_cmd_excute(ctx, PARAMS_NUM_0, AT__CMD__MCU_FW_VER_GET, RESP_STR);
}

void at_query_ab_ver(void *ctx) {
    at_cmd_print(FW_VERSION, strlen(FW_VERSION));
	at_cmd_print(AT_CMD_NEXTLINE, strlen(AT_CMD_NEXTLINE));
	at_cmd_print(AT_CMD_RESP_OK, strlen(AT_CMD_RESP_OK));
    at_cmd_print(AT_CMD_NEXTLINE, strlen(AT_CMD_NEXTLINE));
}

void at_query_sn(void *ctx) {
    at_cmd_excute(ctx, PARAMS_NUM_0, AT__CMD__MCU_SN_GET, RESP_STR);
}

void at_set_sn(void *ctx) {
    at_cmd_excute(ctx, PARAMS_STR, AT__CMD__MCU_SN_SET, RESP_NUM_0);
}

void at_set_led(void *ctx) {
    at_cmd_excute(ctx, PARAMS_NUM_2, AT__CMD__LED_SET, RESP_NUM_0);
}

void at_query_bat_vol_raw(void *ctx) {
    at_cmd_excute(ctx, PARAMS_NUM_0, AT__CMD__MCU_BAT_VOL_RAW_GET, RESP_NUM_1);
}

void at_set_bat_vol_cal(void *ctx) {
    at_cmd_excute(ctx, PARAMS_NUM_1, AT__CMD__MCU_BAT_VOL_CAL, RESP_NUM_0);
}

void at_query_bat_vol(void *ctx) {
    at_cmd_excute(ctx, PARAMS_NUM_0, AT__CMD__MCU_BAT_VOL_GET, RESP_NUM_1);
}

void at_query_bat_temp(void *ctx) {
    at_cmd_excute(ctx, PARAMS_NUM_0, AT__CMD__MCU_BAT_TEMP_GET, RESP_NUM_1);
}

void at_set_relay(void *ctx) {
    at_cmd_excute(ctx, PARAMS_NUM_1, AT__CMD__RELAY, RESP_NUM_0);
}

void at_test_ces_gear(void *ctx) {
    at_cmd_excute(ctx, PARAMS_NUM_0, AT__CMD__CES_GEAR_TEST, RESP_NUM_2);
}

void at_set_ces_gear(void *ctx) {
    at_cmd_excute(ctx, PARAMS_NUM_1, AT__CMD__CES_GEAR_SET, RESP_NUM_0);
}

void at_test_ces_mode(void *ctx) {
    at_cmd_excute(ctx, PARAMS_NUM_0, AT__CMD__CES_MODE_TEST, RESP_NUM_2);
}

void at_set_ces_mode(void *ctx) {
    at_cmd_excute(ctx, PARAMS_NUM_1, AT__CMD__CES_MODE_SET, RESP_NUM_0);
}

void at_set_key(void *ctx) {
    at_cmd_excute(ctx, PARAMS_NUM_2, AT__CMD__BUTTON_GET, RESP_NUM_0);
}

void at_query_ir(void *ctx) {
    at_cmd_excute(ctx, PARAMS_NUM_0, AT__CMD__IR_VALUE_GET, RESP_NUM_1);
}

void at_query_sys_flash(void *ctx) {
    at_cmd_excute(ctx, PARAMS_NUM_0, AT__CMD__FLASH1_STATUS_GET, RESP_NUM_0);
}

#include "filesystem.h"
void at_query_music_flash(void *ctx) {
    if (fs_get_lfs() == NULL) {
        at_cmd_print(AT_CMD_RESP_ERROR, strlen(AT_CMD_RESP_ERROR));
    } else {
        at_cmd_print(AT_CMD_RESP_OK, strlen(AT_CMD_RESP_OK));
    }
    at_cmd_print(AT_CMD_NEXTLINE, strlen(AT_CMD_NEXTLINE));
}

#include "app_local_music.h"
void at_set_music(void *ctx) {
    char *str = (char *)ctx;
    int ctrl = 0;
    int status = 0;

    sscanf(str, "%d", &ctrl);
    if (ctrl == 0) {
        app_local_music_pause();
    } else {
        status = app_local_play_idx(0);
    }
    if (status < 0) {
        at_cmd_print(AT_CMD_RESP_ERROR, strlen(AT_CMD_RESP_ERROR));
    } else {
        at_cmd_print(AT_CMD_RESP_OK, strlen(AT_CMD_RESP_OK));
    }
    at_cmd_print(AT_CMD_NEXTLINE, strlen(AT_CMD_NEXTLINE));
}

void at_set_factory_reset(void *ctx) {
    int status = 0;

    if (status < 0) {
        at_cmd_print(AT_CMD_RESP_ERROR, strlen(AT_CMD_RESP_ERROR));
    } else {
        at_cmd_print(AT_CMD_RESP_OK, strlen(AT_CMD_RESP_OK));
    }
    at_cmd_print(AT_CMD_NEXTLINE, strlen(AT_CMD_NEXTLINE));
}

at_cmd_t at_cmds[] = {
    //+++++++name+++++++++++++query_fun+++++++++++++++setup_fun+++++++++++++++++++++++++++execmd_fun++++
    {"AT+GD_VER", {NULL, at_query_gd_ver, NULL, NULL}},
    {"AT+AB_VER", {NULL, at_query_ab_ver, NULL, NULL}},
    {"AT+SN", {NULL, at_query_sn, at_set_sn, NULL}},
    {"AT+RGB_LED", {NULL, NULL, at_set_led, NULL}},
    {"AT+BAT_VOL_RAW", {NULL, at_query_bat_vol_raw, NULL, NULL}},
    {"AT+BAT_VOL_CAL", {NULL, NULL, at_set_bat_vol_cal, NULL}},
    {"AT+BAT_VOL", {NULL, at_query_bat_vol, NULL, NULL}},
    {"AT+BAT_TEMP", {NULL, at_query_bat_temp, NULL, NULL}},
    {"AT+RELAY", {NULL, NULL, at_set_relay, NULL}},
    {"AT+CES_GEAR", {at_test_ces_gear, NULL, at_set_ces_gear, NULL}},
    {"AT+CES_MODE", {at_test_ces_mode, NULL, at_set_ces_mode, NULL}},
    {"AT+KEY", {NULL, NULL, at_set_key, NULL}},
    {"AT+IR", {NULL, at_query_ir, NULL, NULL}},
    {"AT+SYS_FLASH", {NULL, at_query_sys_flash, NULL, NULL}},
    {"AT+MUSIC_FLASH", {NULL, at_query_music_flash, NULL, NULL}},
    {"AT+MUSIC", {NULL, NULL, at_set_music, NULL}},
    {"AT+FACTORY_RESET", {NULL, NULL, at_set_factory_reset, NULL}},
};

/* Defines the size of the 'at_cmds' array */
size_t at_cmds_size = sizeof(at_cmds) / sizeof(at_cmds[0]);
