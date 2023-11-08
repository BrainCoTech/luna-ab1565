#ifndef MAIN_BT_MSG_HELPER_H
#define MAIN_BT_MSG_HELPER_H

#include "crc/crc16.h"
#include "main_bt/bt_to_main.pb-c.h"
#include "main_bt/main_to_bt.pb-c.h"
#include "packet/packet_packer.h"

int bt_main_msg_decode(const uint8_t *buf, uint16_t size);
int main_bt_msg_decode(const uint8_t *buf, uint16_t size);
int main_bt_msg_encode(packet_packer_t *packer, MainBt *msg);
int bt_main_msg_encode(packet_packer_t *packer, BtMain *msg);

void audio_config(uint32_t msg_id, AudioConfig *cfg);
void prompt_config(uint32_t msg_id, PromptConfig *cfg);
void volume_config(uint32_t msg_id, VolumeConfig *cfg);
void main_bt_config(MainBt *msg);
void main_bt_board_config(uint32_t msg_id, BoardConfig *cfg);
void main_bt_music_file_info(uint32_t msg_id, MusicFileInfo *cfg);
void main_bt_at_cmd_resp(uint32_t msg_id, AtCommandResp *resp);

void sys_config(uint32_t msg_id, SysConfig *cfg);

void play_mode_config(uint32_t msg_id, PlayModeConfig *cfg);

#endif  // MAIN_BT_MSG_HELPER_H