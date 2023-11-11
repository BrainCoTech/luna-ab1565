#include "at_shell.h"

#include <stdint.h>
#include <string.h>
#include <stdbool.h>

typedef struct {
	char buf[AT_CMD_MAX_LEN];
	uint8_t size;
	at_cmd_t *cmds;
	size_t cmds_nums;
} at_parser_t;

static at_parser_t m_at_parser;
static at_cmd_print_func_t m_print;

static int subfix_size[AT_CMD_NUMS] = {
	2,  /* =? */
	1,  /* ? */
	1,  /* = */
	0,  /* */
};

/**
 * @brief Search the command in the command list
 * Must be called after the header is found
*/
static at_cmd_t *at_cmd_search(at_cmd_type_t *type)
{
	int16_t i;
	int16_t cmd_len;
	char *at_str = m_at_parser.buf;
	int16_t len_str = m_at_parser.size;

	if (m_at_parser.size < AT_CMD_MIN_LEN ||
		m_at_parser.size > AT_CMD_MAX_LEN) {
		return NULL;
	}

	if (m_at_parser.cmds == NULL) {
		return NULL;
	}

	for (i = 0; i < len_str; i++) {
		if (at_str[i] == '?') {
			*type = AT_CMD_QUERY;
			break;
		}
		if (at_str[i] == '=') {
			*type = AT_CMD_SET;
			/* data ends with '/r/n', it will not overflow */
			if (at_str[i + 1] == '?') {
				*type = AT_CMD_TEST;
			}
			break;
		}
		if (at_str[i] == '\r') {
			*type = AT_CMD_EXE;
			break;
		}
	}
	cmd_len = i;

	for (i = 0; i < m_at_parser.cmds_nums; i++) {
		if (cmd_len != strlen(m_at_parser.cmds[i].name)) {
			continue;
		}
		if (memcmp(m_at_parser.buf, m_at_parser.cmds[i].name, cmd_len) == 0) {
			return &m_at_parser.cmds[i];
		}
	}

	return NULL;
}

void at_cmd_print(const char *data, size_t len)
{
	if (m_print) {
		m_print((const uint8_t *)data, len);
	} else {
		for (int i = 0; i < len; i++)
			printf("%c", data[i]);
	}
}

static bool at_cmd_find_header(void)
{
    char *data = m_at_parser.buf;

    if (m_at_parser.size < 2) {
        return false;
    }

    if (memcmp(data, "AT", 2) != 0) {
        memmove(data, data + 2, m_at_parser.size - 2);
		/* Adjust the size after moving the buffer */
        m_at_parser.size -= 2;
        return false;
    }

    if (m_at_parser.size < 4 || memcmp(data + m_at_parser.size - 2, "\r\n", 2) != 0) {
        return false;
    }

    return true;
}

void at_cmd_init(at_cmd_print_func_t print)
{
	m_print = print;
	m_at_parser.size = 0;
	m_at_parser.cmds = at_cmds;
	m_at_parser.cmds_nums = at_cmds_size;
}

inline int subfix_size_get(at_cmd_type_t type)
{
	return subfix_size[type];
}

void at_cmd_process_internal(void)
{
	at_cmd_t *cmd;
	at_cmd_type_t cmd_type = AT_CMD_SET;

	if (at_cmd_find_header()) {
		m_at_parser.buf[m_at_parser.size] = 0;
		cmd = at_cmd_search(&cmd_type);
		if (cmd) {
			if (cmd->handler[cmd_type]) {
				/* change /r  to  0, can use strlen in handler */
				m_at_parser.buf[m_at_parser.size - 2] = 0;
				cmd->handler[cmd_type](m_at_parser.buf + strlen(cmd->name) + subfix_size_get(cmd_type));
			} else {
				at_cmd_print(AT_CMD_RESP_CMD_TYPE_INVALID, strlen(AT_CMD_RESP_CMD_TYPE_INVALID));
				at_cmd_print(AT_CMD_NEXTLINE, strlen(AT_CMD_NEXTLINE));
			}
		} else {
			at_cmd_print(AT_CMD_RESP_CMD_INVALID, strlen(AT_CMD_RESP_CMD_INVALID));
			at_cmd_print(AT_CMD_NEXTLINE, strlen(AT_CMD_NEXTLINE));
		}
		m_at_parser.size = 0;
	}
}

void at_cmd_enqueue_data(uint8_t data)
{
	if (m_at_parser.size + 1 >= AT_CMD_MAX_LEN) {
		m_at_parser.size = 0;
	}

	m_at_parser.buf[m_at_parser.size] = data;
	m_at_parser.size ++;
}

void at_cmd_process(uint8_t data)
{
	at_cmd_enqueue_data(data);

	at_cmd_process_internal();
}