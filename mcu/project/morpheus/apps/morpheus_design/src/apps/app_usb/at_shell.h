/**
 * @file at_shell.h
 * @brief This header file contains the definition and implementation of AT commands.
 */

#ifndef __AT_SHELL_H__
#define __AT_SHELL_H__

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/**
 * @def AT_CMD_MAX_LEN 
 * @brief The maximum length that an AT command line is allowed to have.
 */
#define AT_CMD_MAX_LEN 128

/**
 * @def AT_CMD_MIN_LEN 
 * @brief The minimum length that an AT command line is allowed to have. 
 */
#define AT_CMD_MIN_LEN 6 /* AT+X\r\n */

/**
 * @def AT_CMDTIME_OUT 
 * @brief The timeout value for any AT command, in seconds.
 */
#define AT_CMDTIME_OUT 10

#define AT_CMD_RESP_OK                  "OK"
#define AT_CMD_RESP_ERROR               "ERROR"
#define AT_CMD_RESP_CMD_TYPE_INVALID    "ERROR_CMD_TYPE_INVALID"
#define AT_CMD_RESP_CMD_INVALID         "ERROR_CMD_INVALID"
#define AT_CMD_RESP_PARAM_INVALID       "ERROR_PARAM_INVALID"
#define AT_CMD_NEXTLINE                 "\r\n"


/**
 * @enum at_cmd_type_t
 * @brief Enum that defines the different types of AT commands.
 */
typedef enum {
    AT_CMD_TEST = 0, ///< Test AT command
    AT_CMD_QUERY, ///< Query AT command
    AT_CMD_SET, ///< Set AT command
    AT_CMD_EXE, ///< Execute AT command
    AT_CMD_NUMS, ///< Number of AT commands
} at_cmd_type_t;

/**
 * @struct at_cmd_t
 * @brief Structure that defines an AT command.
 */
typedef struct {
    char *name; ///< The name of the AT command
    void (*handler[AT_CMD_NUMS])(void *context); ///< Array of function pointers for handling AT commands
} at_cmd_t;

/**
 * @var at_cmds[]
 * @brief User must define 'at_cmds'. This is an array of AT command structures 
used to define the available AT commands for the application.
 */
extern at_cmd_t at_cmds[];

// This macro declares the number of commands available in the 'at_cmds' array.
#define AT_CMDS_NUMS(cmds)	   cmds##_nums
#define AT_CMDS_NUMS_DEF(cmds)	   size_t cmds##_nums = sizeof(cmds) / sizeof(cmds[0]);
#define AT_CMDS_NUMS_DECLARE(cmds) extern size_t cmds##_nums;
AT_CMDS_NUMS_DECLARE(at_cmds)

/**
 * @typedef at_cmd_print_func_t
 * @brief This typedef defines a function pointer which is used to print AT command.
*/
typedef int (*at_cmd_print_func_t)(const uint8_t *data, size_t len);

/**
 * @fn void at_cmd_init(at_cmd_print_func_t print_func)
 * @brief Initialize the AT command module.
 * @param print_func Function pointer for the command print function.
 */
void at_cmd_init(at_cmd_print_func_t print_func);

/**
 * @fn void at_cmd_enqueue_data(uint8_t data)
 * @brief Adds data to the at command queue and Executes processing on the queued at commands
 * @param data The data to add to the queue.
 */
void at_cmd_process(uint8_t data);

/**
 * @fn void at_cmd_print(const char *data, size_t len)
 * @brief Sends data to the AT client.
 * @param data The data to send.
 * @param len The length of the data to send.
 */
void at_cmd_print(const char *data, size_t len);

#endif
