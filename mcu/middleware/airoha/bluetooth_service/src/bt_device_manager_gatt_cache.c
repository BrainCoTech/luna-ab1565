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

#include "FreeRTOS.h"
#ifdef MTK_NVDM_ENABLE
#include "nvkey.h"
#include "nvkey_id_list.h"
#endif /* MTK_NVDM_ENABLE */
#include "bt_gap.h"
#include "bt_gap_le.h"
#include "bt_device_manager.h"
#include "bt_callback_manager.h"
#include "bt_device_manager_config.h"
#include "bt_device_manager_internal.h"
#include "bt_device_manager_db.h"
#ifdef MTK_AWS_MCE_ENABLE
#include "bt_aws_mce_report.h"
#endif
#include "bt_iot_device_white_list.h"
#include "bt_timer_external.h"
#include "bt_device_manager_link_record.h"
#include "bt_utils.h"
#include "bt_device_manager_nvkey_struct.h"
#include "bt_device_manager_gatt_cache.h"

#define BT_DM_GATT_CACHE_MAX_UPDATE_NUM         (0x02)

typedef struct{
    uint16_t   start_handle;
    uint16_t   end_handle;
    uint8_t    include_count;
    uint8_t    charc_count;
    uint8_t    sequence;
    uint16_t   service_size;
    uint8_t    reserved[5];
}PACKED bt_device_manager_gatt_cache_service_header_t;

typedef struct{
    uint8_t    charc_count;
    uint8_t    mult_instance_count;
}PACKED bt_device_manager_gatt_cache_include_service_header_t;

typedef struct{
    uint16_t    handle;
    uint16_t    value_handle;
    uint8_t     property;
    uint8_t     desc_count;
}PACKED bt_device_manager_gatt_cache_charc_header_t;

typedef struct{
    uint16_t    handle;
}PACKED bt_device_manager_gatt_cache_desc_header_t;

typedef struct {
    bt_bd_addr_t   peer_addr;
    uint16_t    total_length;
    uint8_t     service_num;
    uint8_t     reserved[10];
} bt_device_manager_gatt_cache_device_hearder_t;

typedef struct {
    bt_bd_addr_t    peer_addr;
    uint8_t         seq_num;
} bt_device_manager_gatt_cache_key_info_t;

typedef struct{
    uint8_t                                         data[BT_DM_GATT_CACHE_MAX_SIZE];   /* more services */
    bt_device_manager_gatt_cache_key_info_t         key_info[BT_DM_GATT_CACHE_MAX_RECORD_NUM];  /* each nvkey store some common info */
} bt_device_manager_gatt_cache_t;

typedef struct {
    bt_bd_addr_t    peer_addr;
    uint8_t         seq_num;
    bool            update;
} bt_device_manager_gatt_cache_update_info_t;

#define BT_GATT_CACHE_FIND_FIRSET_NUM          (0)
#define BT_GATT_CACHE_FIND_SECOND_NUM          (1)
#define BT_GATT_CACHE_FIND_THIRD_NUM           (2)
#define BT_GATT_CACHE_FIND_FOURTH_NUM          (3)
typedef uint8_t bt_gatt_cache_find_num_t;

static uint8_t g_bt_dm_gatt_cache_sequence[BT_DM_GATT_CACHE_MAX_RECORD_NUM];
static bt_device_manager_gatt_cache_t g_bt_dm_gatt_cache_list_cnt;
static bt_device_manager_gatt_cache_update_info_t g_bt_dm_update_info[BT_DM_GATT_CACHE_MAX_UPDATE_NUM];
static uint32_t second_cache_addr = 0;

/* Fill the uuid struct and offset the address*/
static uint8_t *bt_device_manager_gatt_fill_uuid(uint8_t *start_buffer, ble_uuid_t *uuid)
{
    bt_device_manager_db_mutex_take();
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache fill,type = %x", 1, uuid->type);
    if (BLE_UUID_TYPE_128BIT == uuid->type || BLE_UUID_TYPE_32BIT == uuid->type || BLE_UUID_TYPE_16BIT == uuid->type) {
        *(start_buffer ++) = uuid->type;
        if (BLE_UUID_TYPE_128BIT == uuid->type) {
            memcpy(start_buffer, &(uuid->uuid.uuid), 16);
                    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache fill uuid = %x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x", 16, uuid->uuid.uuid[0],uuid->uuid.uuid[1],uuid->uuid.uuid[2],uuid->uuid.uuid[3],
                                                                                                          uuid->uuid.uuid[4],uuid->uuid.uuid[5],uuid->uuid.uuid[6],uuid->uuid.uuid[7],
                                                                                                          uuid->uuid.uuid[8],uuid->uuid.uuid[9],uuid->uuid.uuid[10],uuid->uuid.uuid[11],
                                                                                                          uuid->uuid.uuid[12],uuid->uuid.uuid[13],uuid->uuid.uuid[14],uuid->uuid.uuid[15]);
            start_buffer += 16;
        } else if (BLE_UUID_TYPE_32BIT == uuid->type) {
            memcpy(start_buffer, &(uuid->uuid.uuid32), 4);
            bt_dmgr_report_id("[BT_DM][GATT][I]Gatt cache fill uuid2 %x", 1, uuid->uuid.uuid32);
            start_buffer += 4;
        } else if (BLE_UUID_TYPE_16BIT == uuid->type) {
            memcpy(start_buffer, &(uuid->uuid.uuid16), 2);
            bt_dmgr_report_id("[BT_DM][GATT][I]Gatt cache fill uuid1 %x", 1, uuid->uuid.uuid16);
            start_buffer += 2;
        }
    } else {
        bt_dmgr_report_id("[BT_DM][GATT][E] error uuid type %d", 1, uuid->type);
    }
    bt_device_manager_db_mutex_give();
    return start_buffer;
}

static void bt_device_manager_gatt_fill_service_uuid(uint8_t *start_buffer, ble_uuid_t *uuid)
{
    bt_device_manager_db_mutex_take();
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache fill,type = %x", 1, uuid->type);
    ble_uuid_t *p_start_buffer = ( ble_uuid_t *)start_buffer;
    if (BLE_UUID_TYPE_128BIT == uuid->type || BLE_UUID_TYPE_32BIT == uuid->type || BLE_UUID_TYPE_16BIT == uuid->type) {
        p_start_buffer->type = uuid->type;
        if (BLE_UUID_TYPE_128BIT == uuid->type) {
            memcpy(&p_start_buffer->uuid.uuid, &(uuid->uuid.uuid), 16);
                    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache fill uuid = %x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x", 16, uuid->uuid.uuid[0],uuid->uuid.uuid[1],uuid->uuid.uuid[2],uuid->uuid.uuid[3],
                                                                                                          uuid->uuid.uuid[4],uuid->uuid.uuid[5],uuid->uuid.uuid[6],uuid->uuid.uuid[7],
                                                                                                          uuid->uuid.uuid[8],uuid->uuid.uuid[9],uuid->uuid.uuid[10],uuid->uuid.uuid[11],
                                                                                                          uuid->uuid.uuid[12],uuid->uuid.uuid[13],uuid->uuid.uuid[14],uuid->uuid.uuid[15]);
        } else if (BLE_UUID_TYPE_32BIT == uuid->type) {
            memcpy(&p_start_buffer->uuid.uuid32, &(uuid->uuid.uuid32), 4);
            bt_dmgr_report_id("[BT_DM][GATT][I]Gatt cache fill uuid2 %x", 1, uuid->uuid.uuid32);
        } else if (BLE_UUID_TYPE_16BIT == uuid->type) {
            memcpy(&p_start_buffer->uuid.uuid16, &(uuid->uuid.uuid16), 2);
            bt_dmgr_report_id("[BT_DM][GATT][I]Gatt cache fill uuid1 %x", 1, uuid->uuid.uuid16);
        }
    } else {
        bt_dmgr_report_id("[BT_DM][GATT][E] error uuid type %d", 1, uuid->type);
    }
    bt_device_manager_db_mutex_give();
}


/* Extract the uuid strcut and offset address */
static uint8_t *bt_device_manager_gatt_extract_uuid(uint8_t *start_buffer, ble_uuid_t *uuid)
{
    bt_device_manager_db_mutex_take();
    ble_uuid_type_t type = *start_buffer;
    uuid->type = type;
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache extract,type = %x", 1, uuid->type);
    if (BLE_UUID_TYPE_128BIT == type || BLE_UUID_TYPE_32BIT == type || BLE_UUID_TYPE_16BIT == type) {
        start_buffer++;
        if (BLE_UUID_TYPE_128BIT == type) {
            memcpy(&(uuid->uuid.uuid), start_buffer, 16);
            bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache extract uuid = %x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x", 16, uuid->uuid.uuid[0],uuid->uuid.uuid[1],uuid->uuid.uuid[2],uuid->uuid.uuid[3],
                                                                                                          uuid->uuid.uuid[4],uuid->uuid.uuid[5],uuid->uuid.uuid[6],uuid->uuid.uuid[7],
                                                                                                          uuid->uuid.uuid[8],uuid->uuid.uuid[9],uuid->uuid.uuid[10],uuid->uuid.uuid[11],
                                                                                                          uuid->uuid.uuid[12],uuid->uuid.uuid[13],uuid->uuid.uuid[14],uuid->uuid.uuid[15]);
            start_buffer += 16;
        } else if (BLE_UUID_TYPE_32BIT == type) {
            memcpy(&(uuid->uuid.uuid32), start_buffer, 4);
            bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache extract uuid %x", 1, uuid->uuid.uuid32);
            start_buffer += 4;
        } else if (BLE_UUID_TYPE_16BIT == type) {
            memcpy(&(uuid->uuid.uuid16), start_buffer, 2);
            bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache extract uuid %x", 1, uuid->uuid.uuid16);
            start_buffer += 2;
        }
    } else {
        bt_dmgr_report_id("[BT_DM][GATT][E] error uuid type %d", 1, type);
    }
    bt_device_manager_db_mutex_give();
    return start_buffer;
}

/* Fill the character and descriptor */
static uint8_t *bt_device_manager_gatt_cache_fill_charc_desc(uint8_t *start_buffer,uint8_t char_num, bt_gattc_discovery_characteristic_t* charateristics){
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache fill charc&desc", 0);
    bt_device_manager_gatt_cache_charc_header_t *charc_header;
    bt_device_manager_gatt_cache_desc_header_t *desc_header;
    bt_device_manager_db_mutex_take();
    for(uint8_t i = 0; i < char_num; i++, charateristics++){
        /* Fill charateristics. */
        charc_header = (bt_device_manager_gatt_cache_charc_header_t*) bt_device_manager_gatt_fill_uuid(start_buffer, &(charateristics->char_uuid));
        charc_header->handle = charateristics->handle;
        charc_header->value_handle = charateristics->value_handle;
        charc_header->property = charateristics->property;
        charc_header->desc_count = charateristics->descr_count_found;
        bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache fill handle = %x, value = %x,property = %x, desc_count =%x", 4,charc_header->handle, charc_header->value_handle, charc_header->property, charc_header->desc_count);
        bt_gattc_discovery_descriptor_t *temp_desc_ctx = (bt_gattc_discovery_descriptor_t *)(charateristics->descriptor);
        desc_header = (bt_device_manager_gatt_cache_desc_header_t *)((uint8_t *)charc_header + sizeof(bt_device_manager_gatt_cache_charc_header_t));
        if(charateristics->descr_count_found == 0){
            start_buffer = (uint8_t *)desc_header;
        } else {
            for(uint8_t j = 0; j < charateristics->descr_count_found; j++, temp_desc_ctx++){
                /* Fill descriptor. */
                desc_header = (bt_device_manager_gatt_cache_desc_header_t *)bt_device_manager_gatt_fill_uuid((uint8_t *)desc_header, &(temp_desc_ctx->descriptor_uuid));
                desc_header->handle = temp_desc_ctx->handle;
                bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache fill charc&desc,esc_ctx->handle =%x", 1, desc_header->handle);
                desc_header = (bt_device_manager_gatt_cache_desc_header_t *)((uint8_t *)desc_header + sizeof(uint16_t));
                start_buffer = (uint8_t *)desc_header;
            }
        }
    }
    bt_device_manager_db_mutex_give();
    return start_buffer;
}

/* Extract the character and descriptor */
static uint8_t *bt_device_manager_gatt_cache_extract_charc_desc(uint8_t *start_buffer, uint8_t char_num, bt_gattc_discovery_characteristic_t* charateristics){
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache extract charc&desc char_num =%x", 1, char_num);
    bt_device_manager_gatt_cache_charc_header_t *charc_header;
    bt_device_manager_gatt_cache_desc_header_t *desc_header;
    ble_uuid_t  char_uuid;
    ble_uuid_t  desc_uuid;
    bt_device_manager_db_mutex_take();
    for(uint8_t i = 0; i < char_num; i++, charateristics++){
        charc_header = (bt_device_manager_gatt_cache_charc_header_t *)bt_device_manager_gatt_extract_uuid(start_buffer, &char_uuid);
        bt_device_manager_gatt_fill_service_uuid((uint8_t *)&(charateristics->char_uuid), &char_uuid);
        charateristics->handle = charc_header->handle;
        charateristics->value_handle = charc_header->value_handle;
        charateristics->property = charc_header->property;
        charateristics->descr_count_found = charc_header->desc_count;
        bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache extract handle = %x, value = %x,property = %x, desc_count =%x", 4, charc_header->handle, charc_header->value_handle, charc_header->property, charc_header->desc_count);
        bt_gattc_discovery_descriptor_t *temp_desc_ctx = (bt_gattc_discovery_descriptor_t *)(charateristics->descriptor);
        desc_header = (bt_device_manager_gatt_cache_desc_header_t *)((uint8_t* )charc_header + sizeof(bt_device_manager_gatt_cache_charc_header_t));
        if(charc_header->desc_count == 0){
            start_buffer = (uint8_t *)desc_header;
        }
        for(uint8_t j = 0; j < charc_header->desc_count; j++){
            desc_header = (bt_device_manager_gatt_cache_desc_header_t *)bt_device_manager_gatt_extract_uuid((uint8_t *)desc_header, &desc_uuid);
            bt_device_manager_gatt_fill_service_uuid((uint8_t *)&(temp_desc_ctx->descriptor_uuid), &desc_uuid);
            temp_desc_ctx->handle = desc_header->handle;
            bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache extract charc&desc,esc_ctx->handle =%x", 1, desc_header->handle);
            desc_header = (bt_device_manager_gatt_cache_desc_header_t *)((uint8_t *)desc_header + sizeof(uint16_t));
            start_buffer = (uint8_t *)desc_header;
        }
    }
    bt_device_manager_db_mutex_give();
    return start_buffer;
}

/* Find addr in the  g_bt_dm_gatt_cache_list_cnt'key_info */
static bt_gatt_cache_find_num_t bt_device_manager_gatt_cache_find_addr(const bt_bd_addr_t *addr){
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find addr", 0);
    uint8_t i;
    bt_device_manager_db_mutex_take();
    for(i = 0; i < BT_DM_GATT_CACHE_MAX_RECORD_NUM; i++){
        bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find addr = %x,%x,%x,%x,%x,%x", 6, g_bt_dm_gatt_cache_list_cnt.key_info[i].peer_addr[5],
                                                                                          g_bt_dm_gatt_cache_list_cnt.key_info[i].peer_addr[4],
                                                                                          g_bt_dm_gatt_cache_list_cnt.key_info[i].peer_addr[3],
                                                                                          g_bt_dm_gatt_cache_list_cnt.key_info[i].peer_addr[2],
                                                                                          g_bt_dm_gatt_cache_list_cnt.key_info[i].peer_addr[1],
                                                                                          g_bt_dm_gatt_cache_list_cnt.key_info[i].peer_addr[0]);
        if(memcmp(g_bt_dm_gatt_cache_list_cnt.key_info[i].peer_addr, addr, sizeof(bt_bd_addr_t))){
            continue;
        } else{
            bt_device_manager_db_mutex_give();
            return i;
        }
    }
    bt_device_manager_db_mutex_give();
    return i;
}

static bool bt_device_manager_gatt_cache_find_uuid(uint8_t *start_buffer, ble_uuid_t *uuid){
    bool result = false;
    bt_device_manager_db_mutex_take();
    start_buffer ++;
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find,type = %x", 1, uuid->type);
    if(uuid->type == BLE_UUID_TYPE_128BIT){
        result = !memcmp(start_buffer, &(uuid->uuid.uuid), 16);
        bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find uuid = %x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x", 16, uuid->uuid.uuid[0],uuid->uuid.uuid[1],uuid->uuid.uuid[2],uuid->uuid.uuid[3],
                                                                                                          uuid->uuid.uuid[4],uuid->uuid.uuid[5],uuid->uuid.uuid[6],uuid->uuid.uuid[7],
                                                                                                          uuid->uuid.uuid[8],uuid->uuid.uuid[9],uuid->uuid.uuid[10],uuid->uuid.uuid[11],
                                                                                                          uuid->uuid.uuid[12],uuid->uuid.uuid[13],uuid->uuid.uuid[14],uuid->uuid.uuid[15]);
        start_buffer += 16;
    } else if(uuid->type == BLE_UUID_TYPE_32BIT){
        result = !memcmp(start_buffer, &(uuid->uuid.uuid32), 4);
        bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find uuid = %x", 1, uuid->uuid.uuid32);
        start_buffer += 4;
    } else if(uuid->type == BLE_UUID_TYPE_16BIT){
        result = !memcmp(start_buffer, &(uuid->uuid.uuid16), 2);
        bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find uuid = %x", 1, uuid->uuid.uuid16);
        start_buffer += 2;
    }
    bt_device_manager_db_mutex_give();
    return result;
}

/* Init gatt_cache nvkey/sqeunence and read them in global variable */
void bt_device_manager_gatt_cache_init(void){
    uint8_t newest = 0;
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache init", 0);
    bt_device_manager_db_storage_t remote_storage = {
        .auto_gen = true,
        .storage_type = BT_DEVICE_MANAGER_DB_STORAGE_TYPE_NVKEY,
    };
    bt_device_manager_db_mutex_take();
    memset(&g_bt_dm_gatt_cache_list_cnt, 0, sizeof(g_bt_dm_gatt_cache_list_cnt));
    memset(&g_bt_dm_gatt_cache_sequence, 0, sizeof(g_bt_dm_gatt_cache_sequence));
    remote_storage.nvkey_id = NVID_BT_HOST_DM_GATT_CACHE_SEQUENCE;
    bt_device_manager_db_init(BT_DEVICE_MANAGER_DB_TYPE_GATT_SEQUENCE_INFO, &remote_storage, &g_bt_dm_gatt_cache_sequence, sizeof(g_bt_dm_gatt_cache_sequence));
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache init,sequence = %02x,%02x,%02x,%02x", 4, g_bt_dm_gatt_cache_sequence[0], g_bt_dm_gatt_cache_sequence[1], g_bt_dm_gatt_cache_sequence[2], g_bt_dm_gatt_cache_sequence[3]);
    for (uint8_t index = 0; index < BT_DM_GATT_CACHE_MAX_RECORD_NUM; index++) {
        remote_storage.nvkey_id = NVID_BT_HOST_DM_GATT_CACHE_01 + index;
        if(g_bt_dm_gatt_cache_sequence[index] == 1){ /* newest device */
            newest = index;
        }
        bt_device_manager_db_init(BT_DEVICE_MANAGER_DB_TYPE_GATT_CACHE + index, &remote_storage, &g_bt_dm_gatt_cache_list_cnt, BT_DM_GATT_CACHE_MAX_SIZE);
        memcpy(g_bt_dm_gatt_cache_list_cnt.key_info[index].peer_addr, &g_bt_dm_gatt_cache_list_cnt, sizeof(bt_bd_addr_t));
        bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache init addr = %x,%x,%x,%x,%x,%x", 6, g_bt_dm_gatt_cache_list_cnt.key_info[index].peer_addr[5],
                                                   g_bt_dm_gatt_cache_list_cnt.key_info[index].peer_addr[4],
                                                   g_bt_dm_gatt_cache_list_cnt.key_info[index].peer_addr[3],
                                                   g_bt_dm_gatt_cache_list_cnt.key_info[index].peer_addr[2],
                                                   g_bt_dm_gatt_cache_list_cnt.key_info[index].peer_addr[1],
                                                   g_bt_dm_gatt_cache_list_cnt.key_info[index].peer_addr[0]);
    }
    remote_storage.nvkey_id = NVID_BT_HOST_DM_GATT_CACHE_01 + newest;
    bt_device_manager_db_init(BT_DEVICE_MANAGER_DB_TYPE_GATT_CACHE + newest, &remote_storage, &g_bt_dm_gatt_cache_list_cnt, BT_DM_GATT_CACHE_MAX_SIZE);
    bt_device_manager_db_mutex_give();
}

static uint8_t bt_device_manager_gatt_cache_check_update_addr(const bt_bd_addr_t *peer_addr){
    uint8_t i;
    for(i = 0; i< BT_DM_GATT_CACHE_MAX_UPDATE_NUM; i++){
        if(memcmp(peer_addr, &g_bt_dm_update_info[i].peer_addr, sizeof(bt_bd_addr_t)) == 0){
            break;
        } else{
            g_bt_dm_update_info[i].seq_num = i + 1;
            g_bt_dm_update_info[i].update = true;
            memcpy(&g_bt_dm_update_info[i].peer_addr, peer_addr, sizeof(bt_bd_addr_t));
            break;
        }
    }
    return i;
}

bt_gatt_cache_status_t bt_device_manager_gatt_cache_update(const bt_bd_addr_t *addr, const bt_gattc_discovery_service_t *service){
    uint8_t item;
    uint8_t seq_num;
    if (NULL == addr || NULL == service) {
        bt_dmgr_report_id("[BT_DM][GATT][I] addr or service is NULL", 0);
        return BT_GATT_CACHE_STATUS_ERROR;
    }
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache update.service.uuid  = %04x", 1, service->service_uuid.uuid.uuid16);
    bt_dmgr_report_id("[BT_DM][GATT][E] Gatt cache update, addr= %x,%x,%x,%x,%x,%x", 6,
                                                   (*addr)[5], (*addr)[4], (*addr)[3], (*addr)[2], (*addr)[1], (*addr)[0]);
    bt_device_manager_db_mutex_take();
    /* check peer_addr update or not */
    seq_num = bt_device_manager_gatt_cache_check_update_addr(addr);
    bt_device_manager_gatt_cache_device_hearder_t *dev_header = (bt_device_manager_gatt_cache_device_hearder_t *)(&g_bt_dm_gatt_cache_list_cnt);
    /* Fill device header. */
    if(seq_num == 0){
        if(g_bt_dm_update_info[0].update == true){
            bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache update first, seq_num =%x", 1, seq_num);
            item = bt_device_manager_gatt_cache_find_addr(addr);
            if(item == BT_DM_GATT_CACHE_MAX_RECORD_NUM){
                bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache update memset 0", 0);
                memset(&g_bt_dm_gatt_cache_list_cnt, 0, BT_DM_GATT_CACHE_MAX_SIZE);
            } else {
                bt_device_manager_db_storage_t remote_storage = {
                    .auto_gen = true,
                    .storage_type = BT_DEVICE_MANAGER_DB_STORAGE_TYPE_NVKEY,
                    .nvkey_id = NVID_BT_HOST_DM_GATT_CACHE_01
                };
                bt_device_manager_db_init(BT_DEVICE_MANAGER_DB_TYPE_GATT_CACHE + item, &remote_storage, &g_bt_dm_gatt_cache_list_cnt, BT_DM_GATT_CACHE_MAX_SIZE);
            }
            memcpy(dev_header->peer_addr, addr, sizeof(bt_bd_addr_t));
            dev_header->total_length = sizeof(bt_device_manager_gatt_cache_device_hearder_t);
            g_bt_dm_update_info[0].update = false;
        }
    } else if(seq_num == 1){
        if(g_bt_dm_update_info[1].update == true){
            bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache update first seq_num =%x", 1, seq_num);
            bt_device_manager_gatt_cache_t *second_cache = (bt_device_manager_gatt_cache_t *)pvPortMalloc(sizeof(bt_device_manager_gatt_cache_t));
            second_cache_addr = (uint32_t)second_cache;
            memset(second_cache, 0, sizeof(bt_device_manager_gatt_cache_t));
            g_bt_dm_update_info[1].update = false;
        }
        dev_header = (bt_device_manager_gatt_cache_device_hearder_t *)second_cache_addr;
    } else if(seq_num == BT_DM_GATT_CACHE_MAX_UPDATE_NUM){
        bt_device_manager_db_mutex_give();
        bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache update device  > 2", 0);
        return BT_GATT_CACHE_STATUS_ERROR;
    }
    uint8_t service_num = ++ (dev_header->service_num);
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache update:service_num = %x, length = %x", 2, service_num, dev_header->total_length);
    /* Fill service header. */
    bt_device_manager_gatt_cache_service_header_t *service_header;
    service_header = (bt_device_manager_gatt_cache_service_header_t *)((uint8_t *)dev_header + dev_header->total_length);
    uint8_t *start_service_header = (uint8_t *)service_header;
    service_header = (bt_device_manager_gatt_cache_service_header_t *)bt_device_manager_gatt_fill_uuid((uint8_t *)service_header, (ble_uuid_t *)(&service->service_uuid));
    service_header->start_handle = service->start_handle;
    service_header->end_handle = service->end_handle;
    service_header->include_count = service->included_srv_count_found;
    service_header->charc_count = service->char_count_found;
    service_header->sequence = service_num;
    /* Fill service's char context. */
    bt_device_manager_gatt_cache_charc_header_t *charc_header;
    bt_gattc_discovery_characteristic_t *temp_char_ctx = (bt_gattc_discovery_characteristic_t *)service->charateristics;
    charc_header = (bt_device_manager_gatt_cache_charc_header_t *)((uint8_t *)service_header + sizeof(bt_device_manager_gatt_cache_service_header_t));
    charc_header = (bt_device_manager_gatt_cache_charc_header_t *)bt_device_manager_gatt_cache_fill_charc_desc((uint8_t *)charc_header, service->char_count_found, temp_char_ctx);
    /* Fill include_service context. */
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache update:included_srv_count_found = %x", 1, service->included_srv_count_found);
    if(service->included_srv_count_found == 0){
          service_header->service_size = ((uint8_t *)charc_header - start_service_header);
          dev_header->total_length += service_header->service_size;
    } else {
          bt_device_manager_gatt_cache_include_service_header_t *include_service_header = NULL;
          bt_device_manager_gatt_cache_charc_header_t *include_service_charc_header = NULL;
          bt_gattc_discovery_included_service_t *temp_include_ser_ctx = (bt_gattc_discovery_included_service_t *)service->included_service;
          for(uint8_t x = 0; x < service->included_srv_count_found; x++){
              bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache update:Fill include_service context", 0);
              include_service_header = (bt_device_manager_gatt_cache_include_service_header_t *)bt_device_manager_gatt_fill_uuid((uint8_t *)charc_header, &(temp_include_ser_ctx[x].service_uuid));
              include_service_header->charc_count = temp_include_ser_ctx[x].char_count_found;
              include_service_header->mult_instance_count = temp_include_ser_ctx[x].multi_instance_count;
              /* Fill include_service char & desc. */
              include_service_charc_header = (bt_device_manager_gatt_cache_charc_header_t *)((uint8_t *)include_service_header + sizeof(bt_device_manager_gatt_cache_include_service_header_t));
              bt_gattc_discovery_characteristic_t *temp_include_char_ctx = (bt_gattc_discovery_characteristic_t *)(temp_include_ser_ctx[x].charateristics);
              include_service_charc_header = (bt_device_manager_gatt_cache_charc_header_t *)bt_device_manager_gatt_cache_fill_charc_desc((uint8_t *)include_service_charc_header, temp_include_ser_ctx[x].char_count_found, temp_include_char_ctx);
          }
          /* Caculate service_size & update total_length */
          service_header->service_size = ((uint8_t *)include_service_charc_header - start_service_header);
          dev_header->total_length += service_header->service_size;
    }
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache update, length = %02x, num = %02x", 2, dev_header->total_length, dev_header->service_num);
    if(dev_header->total_length > BT_DM_GATT_CACHE_MAX_SIZE){
        /* clear all*/
        memset(&g_bt_dm_gatt_cache_list_cnt, 0, sizeof(g_bt_dm_gatt_cache_list_cnt));
        bt_device_manager_db_mutex_give();
        bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache update length error", 0);
        return BT_GATT_CACHE_STATUS_ERROR;
    }
    bt_device_manager_db_mutex_give();
    return BT_GATT_CACHE_STATUS_SUCCESS;
}

bt_gatt_cache_status_t bt_device_manager_gatt_cache_store(const bt_bd_addr_t *addr){
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache store", 0);
    bt_device_manager_db_mutex_take();
    uint8_t i, j, k, seq_num;
    uint8_t item = bt_device_manager_gatt_cache_find_addr(addr);
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache store item = %02x", 1, item);
    seq_num = bt_device_manager_gatt_cache_check_update_addr(addr);
    if(seq_num != BT_DM_GATT_CACHE_MAX_UPDATE_NUM){
        g_bt_dm_update_info[seq_num].update = true;
        if(seq_num == 1){
            vPortFree((void *)second_cache_addr);
        }
    }
    if(item != BT_DM_GATT_CACHE_MAX_RECORD_NUM){  /* nvkey has stored this addr */
        //update sequence
        for(i = 0; i < BT_DM_GATT_CACHE_MAX_RECORD_NUM; i++){
            if((i != item) && (g_bt_dm_gatt_cache_sequence[i] < g_bt_dm_gatt_cache_sequence[item]) && g_bt_dm_gatt_cache_sequence[i]){
                g_bt_dm_gatt_cache_sequence[i] ++;
            }
        }
        g_bt_dm_gatt_cache_sequence[item] = 1;
        bt_device_manager_db_update(BT_DEVICE_MANAGER_DB_TYPE_GATT_CACHE + item);
        bt_device_manager_db_flush(BT_DEVICE_MANAGER_DB_TYPE_GATT_CACHE + item, BT_DEVICE_MANAGER_DB_FLUSH_NON_BLOCK);
    } else{
    /* update sequence */
        for(k = 0; k < BT_DM_GATT_CACHE_MAX_RECORD_NUM; k++){
            if(!(g_bt_dm_gatt_cache_sequence[k]) || (g_bt_dm_gatt_cache_sequence[k] == BT_DM_GATT_CACHE_MAX_RECORD_NUM)){
                g_bt_dm_gatt_cache_sequence[k] = 1;
                for(j = 0; j < BT_DM_GATT_CACHE_MAX_RECORD_NUM; j++){
                    if((k != j) && g_bt_dm_gatt_cache_sequence[j]){
                        g_bt_dm_gatt_cache_sequence[j] ++;
                    }
                }
                break;
            }
        }
        if(k == BT_DM_GATT_CACHE_MAX_RECORD_NUM){
            k = k - 1;
        }
        g_bt_dm_gatt_cache_list_cnt.key_info[k].seq_num = k;
        memcpy(g_bt_dm_gatt_cache_list_cnt.key_info[k].peer_addr, addr, sizeof(bt_bd_addr_t));
        bt_device_manager_db_update(BT_DEVICE_MANAGER_DB_TYPE_GATT_CACHE + k);
        bt_device_manager_db_flush(BT_DEVICE_MANAGER_DB_TYPE_GATT_CACHE + k, BT_DEVICE_MANAGER_DB_FLUSH_NON_BLOCK);
        memcpy(g_bt_dm_gatt_cache_list_cnt.key_info[k].peer_addr, &g_bt_dm_gatt_cache_list_cnt, sizeof(bt_bd_addr_t));
        bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache store GATT_CACHE OK", 0);
    }
    bt_device_manager_db_mutex_give();
    bt_device_manager_db_update(BT_DEVICE_MANAGER_DB_TYPE_GATT_SEQUENCE_INFO);
    bt_device_manager_db_flush(BT_DEVICE_MANAGER_DB_TYPE_GATT_SEQUENCE_INFO, BT_DEVICE_MANAGER_DB_FLUSH_NON_BLOCK);
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache store SEQUNCE OK", 0);
    return BT_GATT_CACHE_STATUS_SUCCESS;
}

bt_gatt_cache_status_t bt_device_manager_gatt_cache_delete(const bt_bd_addr_t *addr){
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache delete", 0);
    uint8_t item = bt_device_manager_gatt_cache_find_addr(addr);
    bt_device_manager_db_mutex_take();
    if (item != BT_DM_GATT_CACHE_MAX_RECORD_NUM){ /* nvkey has stored this addr */
        for(uint8_t i = 0; i < BT_DM_GATT_CACHE_MAX_RECORD_NUM; i++ ){
            if(g_bt_dm_gatt_cache_sequence[i] > g_bt_dm_gatt_cache_sequence[item]){
                g_bt_dm_gatt_cache_sequence[i] --;
            }
        }
        g_bt_dm_gatt_cache_sequence[item] = 0;
        g_bt_dm_gatt_cache_list_cnt.key_info[item].seq_num = 0;
        memset(g_bt_dm_gatt_cache_list_cnt.key_info[item].peer_addr, 0, sizeof(bt_bd_addr_t));
        memset(&g_bt_dm_gatt_cache_list_cnt, 0, sizeof(g_bt_dm_gatt_cache_list_cnt));
    } else{
        bt_device_manager_db_mutex_give();
        return BT_GATT_CACHE_STATUS_NOT_FIND_ADDR;
    }
    bt_device_manager_db_mutex_give();
    bt_device_manager_db_update(BT_DEVICE_MANAGER_DB_TYPE_GATT_SEQUENCE_INFO);
    bt_device_manager_db_flush(BT_DEVICE_MANAGER_DB_TYPE_GATT_SEQUENCE_INFO, BT_DEVICE_MANAGER_DB_FLUSH_NON_BLOCK);
    bt_device_manager_db_update(BT_DEVICE_MANAGER_DB_TYPE_GATT_CACHE + item);
    bt_device_manager_db_flush(BT_DEVICE_MANAGER_DB_TYPE_GATT_CACHE + item, BT_DEVICE_MANAGER_DB_FLUSH_NON_BLOCK);
    return BT_GATT_CACHE_STATUS_SUCCESS;
}

bt_gatt_cache_status_t bt_device_manager_gatt_cache_find(const bt_bd_addr_t *addr, const ble_uuid_t *uuid, bt_gattc_discovery_service_t *service, uint8_t *seq_addr){
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find.service.uuid = %x, type=%x, seq = %x", 3, uuid->uuid.uuid16, uuid->type, *seq_addr);
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find addr = %x,%x,%x,%x,%x,%x", 6, (*addr)[5], (*addr)[4], (*addr)[3], (*addr)[2], (*addr)[1], (*addr)[0]);
    bool read_flag = false;
    bt_device_manager_db_mutex_take();
    uint8_t i;
    uint8_t seq = *seq_addr;
    bt_device_manager_gatt_cache_device_hearder_t *device_header;
    bt_device_manager_gatt_cache_service_header_t *service_header;
    bt_device_manager_gatt_cache_charc_header_t *charc_header;
    uint8_t *temp_service_header;
    /* Find addr */
    uint8_t item = bt_device_manager_gatt_cache_find_addr(addr);
    if (item == BT_DM_GATT_CACHE_MAX_RECORD_NUM){ /* nvkey has not stored this addr */
        bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache has not this addr", 0);
        bt_device_manager_db_mutex_give();
        return BT_GATT_CACHE_STATUS_NOT_FIND_ADDR;
    }
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find this addr", 0);
    bt_device_manager_db_storage_t remote_storage = {
            .auto_gen = true,
            .storage_type = BT_DEVICE_MANAGER_DB_STORAGE_TYPE_NVKEY,
            .nvkey_id = NVID_BT_HOST_DM_GATT_CACHE_01
    };
    memset(&g_bt_dm_gatt_cache_list_cnt, 0, BT_DM_GATT_CACHE_MAX_SIZE);
    remote_storage.nvkey_id = NVID_BT_HOST_DM_GATT_CACHE_01 + item;
    bt_device_manager_db_init(BT_DEVICE_MANAGER_DB_TYPE_GATT_CACHE + item, &remote_storage, &g_bt_dm_gatt_cache_list_cnt, BT_DM_GATT_CACHE_MAX_SIZE);
    device_header = (bt_device_manager_gatt_cache_device_hearder_t *)(&g_bt_dm_gatt_cache_list_cnt);
    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find:service_num = %x, length = %x", 2, device_header->service_num, device_header->total_length);
    if(seq > device_header->service_num){
        bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find error seq", 0);
        bt_device_manager_db_mutex_give();
        return BT_GATT_CACHE_STATUS_ERROR;
    }
    /* Find uuid */
    service_header = (bt_device_manager_gatt_cache_service_header_t *)((uint8_t *)device_header + sizeof(bt_device_manager_gatt_cache_device_hearder_t));
    temp_service_header = (uint8_t *)service_header;
    for(; seq < device_header->service_num; seq++){
        service_header = (bt_device_manager_gatt_cache_service_header_t *)temp_service_header;
        bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find seq %d", 1, seq);
        if(bt_device_manager_gatt_cache_find_uuid((uint8_t *)service_header, (ble_uuid_t *)uuid)){
            if(read_flag == true){
                bt_device_manager_db_mutex_give();
                bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find BT_GATT_CACHE_STATUS_NOT_COMPLETE", 0);
                return BT_GATT_CACHE_STATUS_NOT_COMPLETE;
            } else{
            /* extract stored service to service */
                service_header = (bt_device_manager_gatt_cache_service_header_t *)bt_device_manager_gatt_extract_uuid((uint8_t *)service_header, (ble_uuid_t *)uuid);
                bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find charc_count =%x,include_count =%x", 2,service_header->charc_count,service_header->include_count);
                if(service_header->charc_count < service->char_count_found){
                    bt_device_manager_db_mutex_give();
                    return BT_GATT_CACHE_STATUS_ERROR;
                }
                charc_header = (bt_device_manager_gatt_cache_charc_header_t *)((uint8_t *)service_header + sizeof(bt_device_manager_gatt_cache_service_header_t));
                bt_device_manager_gatt_fill_service_uuid((uint8_t *)(&(service->service_uuid)), (ble_uuid_t *)uuid);
                service->start_handle = service_header->start_handle;
                service->end_handle = service_header->end_handle;
                service->included_srv_count_found = service_header->include_count;
                service->char_count_found = service_header->charc_count;
                /* extract char */
                bt_device_manager_gatt_cache_include_service_header_t *include_service_header = (bt_device_manager_gatt_cache_include_service_header_t *)bt_device_manager_gatt_cache_extract_charc_desc((uint8_t *)charc_header, service_header->charc_count, service->charateristics);
                /* extract include_service */
                bt_device_manager_gatt_cache_charc_header_t *include_service_charc_header;
                bt_gattc_discovery_included_service_t *temp_include_ser_ctx = (bt_gattc_discovery_included_service_t *)service->included_service;
                bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find included_srv_count_found =%x", 1, service->included_srv_count_found);
                for(i = 0; i < service->included_srv_count_found; i++){
                    ble_uuid_t include_service_uuid;
                    bt_gattc_discovery_characteristic_t *temp_include_char_ctx = (bt_gattc_discovery_characteristic_t *)(temp_include_ser_ctx[i].charateristics);
                    include_service_header = (bt_device_manager_gatt_cache_include_service_header_t *)bt_device_manager_gatt_extract_uuid((uint8_t *)include_service_header, &include_service_uuid);
                    bt_device_manager_gatt_fill_uuid((uint8_t *)(&(temp_include_ser_ctx[i].service_uuid)), &include_service_uuid);
                    temp_include_ser_ctx[i].multi_instance_count = include_service_header->mult_instance_count;
                    temp_include_ser_ctx[i].char_count_found = include_service_header->charc_count;
                    include_service_charc_header = (bt_device_manager_gatt_cache_charc_header_t *)((uint8_t *)include_service_header + sizeof(bt_device_manager_gatt_cache_include_service_header_t));
                    include_service_charc_header = (bt_device_manager_gatt_cache_charc_header_t *)bt_device_manager_gatt_cache_extract_charc_desc((uint8_t *)include_service_charc_header, temp_include_ser_ctx[i].char_count_found, temp_include_char_ctx);
                }
                temp_service_header += service_header->service_size;
                read_flag = true;
            }
        } else{
            if((seq + 1) == device_header->service_num){
                bt_device_manager_db_mutex_give();
                if(read_flag == true){
                    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find done", 0);
                    break;
                } else{
                    bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache not find uuid", 0);
                    bt_device_manager_db_mutex_give();
                    return BT_GATT_CACHE_STATUS_NOT_FIND_UUID;
                }
            } else{
                ble_uuid_t temp_uuid;
                service_header = (bt_device_manager_gatt_cache_service_header_t *)bt_device_manager_gatt_extract_uuid((uint8_t *)service_header, &temp_uuid);
                bt_dmgr_report_id("[BT_DM][GATT][I] Gatt cache find next service", 0);
                temp_service_header += service_header->service_size;
            }
        }
    }
    bt_device_manager_db_mutex_give();
    return BT_GATT_CACHE_STATUS_SUCCESS;
}

