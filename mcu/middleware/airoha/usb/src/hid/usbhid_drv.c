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

#ifdef AIR_USB_HID_ENABLE

/* C library */
#include <assert.h>
#include <string.h>
#include <stdint.h>

/* USB Middleware includes */
#include "usb.h"
#include "usb_resource.h"
#include "usbhid_drv.h"

/* Kernel includes */
#ifdef MTK_MUX_ENABLE
#include "mux.h"
#include "mux_port_device.h"
#include "syslog_port.h"
#endif

/* Hal includes */
#include "hal_gpt.h"
#include "hal_pmu.h"
#include "hal_usb.h"

/* Other includes */
#include "memory_attribute.h"

/* Syslog create module for usbhid_drv.c */
#include "usb_dbg.h"
log_create_module_variant(USBHID, DEBUG_LOG_ON, PRINT_LEVEL_INFO);

UsbHid_Struct g_UsbHid;

/*****************************************************************************
 * Function Declarations
 *****************************************************************************/
void check_hid_report(const uint8_t *pHidReport, uint32_t size);

/*****************************************************************************
 * Static Function Declarations
 *****************************************************************************/
static int32_t usb_hid_dscr_interface_serialize(void *dscr, void *out, uint32_t ava_size);
static int32_t usb_hid_dscr_hid_serialize(void *dscr, void *out, uint32_t ava_size);
static int32_t usb_hid_dscr_endpoint_serialize(void *dscr, void *out, uint32_t ava_size);
static uint8_t usb_hid_find_port_by_report(usb_hid_report_dscr_type_t report_type);
static uint8_t usb_hid_find_port_by_ep_in(uint8_t ep_id) __unused;
static uint32_t usb_hid_convert_ms_to_timer_count(uint32_t ms);

/*****************************************************************************
 * Global variables for MUX
 *****************************************************************************/
ATTR_RWDATA_IN_NONCACHED_RAM_4BYTE_ALIGN uint8_t usb_rx[USB_HID_REPORT_MAX_LEN] = {0};
ATTR_RWDATA_IN_NONCACHED_RAM_4BYTE_ALIGN uint8_t usb_tx[USB_HID_REPORT_MAX_LEN] = {0};

mux_usb_hid_callback g_mux_usb_hid_callback = NULL;
uint8_t usb_report_id = 0;
uint8_t usb_report_type = 0;
uint32_t usb_report_length = 0;

/*****************************************************************************
 * Global variables
 *****************************************************************************/
uint8_t hid_report_dscr[USB_HID_REPOTR_DSCR_MAX_SIZE];
uint16_t hid_report_dscr_length = 0;

UsbHid_Struct g_UsbHids[USB_HID_MAX_DEVICE_NUM];

/*****************************************************************************
 * Static variables
 *****************************************************************************/
static usb_hid_resource_t s_hid_resource[USB_HID_MAX_DEVICE_NUM];

/*****************************************************************************
 * HID descriptor
 *****************************************************************************/
static const usb_hid_dscr_interface_t hid_if_template_dscr = {
    .bLength            = 0, /* Set in serialization */
    .bDescriptorType    = USB_DESC_TYPE_INTERFACE,
    .bInterfaceNumber   = 0x00, /* USB_Hid_CommIf_Create set this parameter */
    .bAlternateSetting  = 0x00, /* USB_Hid_CommIf_Create set this parameter */
    .bNumEndpoints      = 0x00, /* USB_Hid_CommIf_Create set this parameter */
    .bInterfaceClass    = USB_IF_CLASS_HID,
    .bInterfaceSubClass = USB_HID_SUBCLASS_CODE_NONE,
    .bInterfaceProtocol = USB_HID_PROTOCOL_CODE_NONE,
    .iInterface         = 0x00, /* USB_Hid_CommIf_Create set this parameter */
};

static const usb_hid_dscr_hid_t hid_template_dscr = {
    .bLength         = 0, /* Set in serialization */
    .bDescriptorType = USB_HID_DESC_TYPE_HID,
    .bcdHID          = USB_HID_BCD_110,
    .bCountryCode    = USB_HID_CONTRY_NONE,
    .bNumDescriptors = 1,
    .cont_dscrs      = {
        {
            .bDescriptorType   = 0x22,
            .wDescriptorLength = 0, /* USB_Hid_CommIf_Create set this parameter */
        }
    }
};

static const usb_hid_dscr_endpoint_t hid_ep_template_dscr = {
    .bLength          = 0, /* Set in serialization */
    .bDescriptorType  = USB_DESC_TYPE_ENDPOINT,
    .bEndpointAddress = 0, /* USB_Hid_CommIf_Create set this parameter */
    .bmAttributes     = USB_EP_INTR,
    .wMaxPacketSize   = USB_HID_EP_MAX_SIZE,
    .bInterval        = 0, /* USB_Hid_CommIf_Create set this parameter */
};

/*****************************************************************************
 * HID Report descriptor
 *****************************************************************************/
/**
 * Airoha In/Out report for Race, FOTA and HID logging via mux module
 *
 * Report ID 0x06(Out) as MUX_USB_HID_2 RX
 * Report ID 0x07(In)  as MUX_USB_HID_2 TX
 */
const uint8_t report_mux_dscr[] = {
    /* Airoha In/Out Report */
    0x06, 0x13, 0xFF, // Usage Page (Vendor-defined ,0xFF13)
    0x09, 0x01,       // Usage      (Vendor-defined ,0x0001)
    0xA1, 0x01,       // Collection (Application)
    0x15, 0x00,       // Logical minimum (0)
    0x26, 0xFF, 0x00, // Logical maximum (255)
    // Output Report
    0x85, USB_HID_AIR_OUT_REPORT_ID, // Report Id (6)
    0x09, 0x00,       // Usage  (Vendor-defined ,0x0000)
    0x75, 0x08,       // Report Size  (8)
    0x95, 0x3D,       // Report Count (61)
    0x91, 0x02,       // Output (Data,Value,Absolute,Bit Field)
    // Input Report
    0x85, USB_HID_AIR_IN_REPORT_ID, // Report Id (7)
    0x09, 0x00,       // Usage  (Vendor-defined ,0x0000)
    0x75, 0x08,       // Report Size  (8)
    0x95, 0x3D,       // Report Count (61)
    0x81, 0x02,       // Input    (Data,Value,Absolute,Bit Field)
    0xC0,             // End Collection
};

/**
 * report for Audio Control
 */
const uint8_t report_ac_dscr[] = {
#ifdef AIR_USB_AUDIO_ENABLE
    /* Audio Control */
    0x05, 0x0C,  // Usage Page (Consumer)
    0x09, 0x01,  // Usage      (Consumer Control)
    0xA1, 0x01,  // Collection (Application)
    // Input Report
    0x85, USB_HID_AUDIO_REPORT_ID, // Report Id (12)
    0x15, 0x00,  // Logical minimum (0)
    0x25, 0x01,  // Logical maximum (1)
    0x09, 0xE9,  // Usage (Volume Increment)
    0x09, 0xEA,  // Usage (Volume Decrement)
    0x09, 0xE2,  // Usage (Mute)
    0x09, 0xCD,  // Usage (Play/Pause)
    0x09, 0xB5,  // Usage (Scan Next Track)
    0x09, 0xB6,  // Usage (Scan Previous Track)
    0x75, 0x01,  // Report Size  (1)
    0x95, 0x06,  // Repo    rt Count (6)
    0x81, 0x02,  // Input (Data,Value,Absolute,Bit Field)
    0x09, 0x00,  // Usage (Unassigned)
    0x95, 0x02,  // Report Count (2)
    0x81, 0x02,  // Input (Data,Value,Absolute,Bit Field)
    0xC0,        // End Collection
#endif
};

/**
 * report for Microsoft Teams
 */
const uint8_t report_teams_dscr[] = {
#ifdef AIR_MS_TEAMS_ENABLE
    0x06, 0x99, 0xFF,  // Usage Page (Vendor-defined 0xFF99)
    0x09, 0x01,        // Usage (Vendor-defined 0x0001)
    0xA1, 0x01,        // Collection (Application)
    // Feature Report
    0x85, USB_HID_TEAMS_FEATURE_REPORT_ID, // Report Id (154)
    0x15, 0x00,        // Logical minimum (0)
    0x26, 0xFF, 0x00,  // Logical maximum (255)
    0x95, 0x3F,        // Report Count (63)
    0x75, 0x08,        // Report Size  (8)
    0x09, 0x03,        // Usage   (Vendor-defined 0x0003)
    0xB1, 0x02,        // Feature (Data,Value,Absolute,Non-volatile,Buffered Bytes)
    // Input Report
    0x85, USB_HID_TEAMS_IN_REPORT_ID, // Report Id (155)
    0x15, 0x00,        // Logical minimum (0)
    0x25, 0x01,        // Logical maximum (1)
    0x95, 0x01,        // Report Count (1)
    0x75, 0x01,        // Report Size  (1)
    0x09, 0x04,        // Usage (Vendor-defined 0x0004)
    0x81, 0x06,        // Input (Data,Value,Relative,Bit Field)
    0x75, 0x01,        // Report Size  (1)
    0x95, 0x07,        // Report Count (7)
    0x81, 0x01,        // Input (Constant,Array,Absolute,Bit Field)
    0xC0,              // End Collection
#endif
};

const uint8_t report_telephony_dscr[] = {
#ifdef USB_HID_TELEPHONY_CALL_CONTROL_ENABLE
    /* Telephony */
    0x05, 0x0B,        // Usage Page (Telephony)
    0x09, 0x05,        // Usage (Headset)
    0xA1, 0x01,        // Collection (Application)
    0x15, 0x00,        // Logical minimum (0)
    0x25, 0x01,        // Logical maximum (1)
    0x75, 0x01,        // Report Size (1)
    0x85, USB_HID_TEL_CALL_CTL_REPORT_ID, // Report Id (5)
    // Input
    0x09, 0x20,        // Usage (Hook Switch)
    0x95, 0x01,        // Report Count (1)
    0x81, 0x22,        // Input (Data,Value,Absolute,Bit Field)
    0x09, 0x2F,        // Usage (Phone Mute)
    0x95, 0x01,        // Report Count (1)
    0x81, 0x06,        // Input (Data,Value,Relative,Bit Field)
    0x09, 0x24,        // Usage (Redial)
    0x09, 0x21,        // Usage (Flash)
    0x09, 0x97,        // Usage (Line Busy Tone)
    0x09, 0x2A,        // Usage (Line)
    0x09, 0x50,        // Usage (Speed Dial)
    0x95, 0x05,        // Report Count (5)
    0x81, 0x06,        // Input (Data,Value,Relative,Bit Field)
    0x09, 0x07,        // Usage (Programmable Button)
    0x05, 0x09,        // Usage Page (Button)
    0x09, 0x01,        // Usage (Button 1)
    0x75, 0x01,        // Report Size (1)
    0x95, 0x01,        // Report Count (1)
    0x81, 0x02,        // Input (Data,Value,Absolute,Bit Field)
    // Output
    0x05, 0x08,        // Usage Page (LEDs)
    0x85, USB_HID_TEL_CALL_CTL_REPORT_ID, // Report Id (5)
    0x09, 0x17,        // Usage (Off-Hook)
    0x09, 0x09,        // Usage (Mute)
    0x09, 0x18,        // Usage (Ring)
    0x09, 0x20,        // Usage (Hold)
    0x09, 0x21,        // Usage (Microphone)
    0x09, 0x2A,        // Usage (Line)
    0x95, 0x06,        // Report Count (6)
    0x91, 0x22,        // Output (Data,Value,Absolute,Non-volatile,Bit Field)
    0x95, 0x02,        // Report Count (2)
    0x91, 0x01,        // Output (Constant,Array,Absolute,Non-volatile,Bit Field)
    0xC0,              // End Collection
#endif
};

/**
 * report for keyboard
 */
const uint8_t report_keyboard_dscr[] = {
#ifdef USB_HID_KEYBOARD_ENABLE
    0x05, 0x01,        // Usage Page (Generic Desktop Controls)
    0x09, 0x06,        // Usage         (Keyboard)
    0xA1, 0x01,        // Collection (Application)
    0x85, 0x0A,        // Report Id (10)
    0x05, 0x07,        // Usage Page (Key)
    0x19, 0xe0,        // Usage minimum (0xE0)
    0x29, 0xe7,        // Usage minimum (0xE0)
    0x15, 0x00,        // Logical minimum (0)
    0x25, 0x01,        // Logical maximum (1)
    0x75, 0x01,        // Report Size  (1)
    0x95, 0x08,        // Report Count (8)
    0x81, 0x02,        // Input (Data,Value,Absolute,Bit Field)
    0x95, 0x01,        // Report Count (1)
    0x75, 0x08,        // Report Size  (8)
    0x81, 0x01,        // Input (Constant,Array,Absolute,Bit Field)
    0x95, 0x03,        // Report Count (3)
    0x75, 0x01,        // Report Size  (1)
    0x05, 0x08,        // Usage Page (LED)
    0x19, 0x01,        // Usage minimum (0x01)
    0x29, 0x03,        // Usage minimum (0x03)
    0x91, 0x02,        // Output (Data,Value,Absolute,Bit Field)
    0x95, 0x05,        // Report Count (5)
    0x75, 0x01,        // Report Size  (1)
    0x91, 0x01,        // Output (Constant,Array,Absolute,Bit Field)
    0x95, 0x06,        // Report Count (6)
    0x75, 0x08,        // Report Size  (8)
    0x15, 0x00,        // Logical minimum (0)
    0x25, 0x68,        // Logical maximum (104)
    0x05, 0x07,        // Usage Page (Key)
    0x19, 0x00,        // Usage minimum (0x00)
    0x29, 0x68,        // Usage minimum (104)
    0x81, 0x00,        // Input (Data,Array,Absolute,Bit Field)
    0xC0,              // End Collection
#endif
};

const uint8_t report_gyrometer_dscr[] = {
#ifdef USB_HID_CUSTOM_GYROMETER
    // Magic value: "#AndroidHeadTracker#1.0"
    0x05, 0x20,        // HID_USAGE_PAGE_SENSOR
    0x09, 0xE1,        // HID_USAGE_SENSOR_TYPE_OTHER_CUSTOM
    0xA1, 0x01,        // Collection (Application)
    0x85, 0x0E,        // Report Id (14)
    0x0A, 0x08, 0x03,  // HID_USAGE_SENSOR_PROPERTY_SENSOR_DESCRIPTION
    0x15, 0x00,        // Logical minimum (0)
    0x25, 0xFF,        // Logical maximum (255)
    0x75, 0x08,        // Report Size  (8)
    0x95, 0x17,        // Report Count (23)
    0xB1, 0x03,        // Feature (Const_Var_Abs)
    // UUID
    0x0A, 0x02, 0x03,  // HID_USAGE_SENSOR_PROPERTY_PERSISTENT_UNIQUE_ID
    0x15, 0x00,        // Logical minimum (0)
    0x25, 0xFF,        // Logical maximum (255)
    0x75, 0x08,        // Report Size  (8)
    0x95, 0x10,        // Report Count (16)
    0xB1, 0x03,        // Feature (Const_Var_Abs)

    //Feature report 1 (read/write).
    0x85, 0x01,        // Report Id (1)
    // 1-bit on/off reporting state
    0x0A, 0x16, 0x03,  // HID_USAGE_SENSOR_PROPERTY_REPORTING_STATE
    0x15, 0x00,        // Logical minimum (0)
    0x25, 0x01,        // Logical maximum (1)
    0x75, 0x01,        // Report Size  (1)
    0x95, 0x01,        // Report Count (1)
    0xA1, 0x02,        // Collection (Logical)
    0x0A, 0x40, 0x08,  // HID_USAGE_SENSOR_PROPERTY_REPORTING_STATE_NO_EVENTS
    0x0A, 0x41, 0x08,  // HID_USAGE_SENSOR_PROPERTY_REPORTING_STATE_ALL_EVENTS
    0xB1, 0x00,        // Feature (DATA_ARR_ABS)
    0xC0,              // End Collection
    // 1-bit on/off power state
    0x0A, 0x19, 0x03,  // HID_USAGE_SENSOR_PROPERTY_POWER_STATE
    0x15, 0x00,        // Logical minimum (0)
    0x25, 0x01,        // Logical maximum (1)
    0x75, 0x01,        // Report Size  (1)
    0x95, 0x01,        // Report Count (1)
    0xA1, 0x02,        // Collection (Logical)
    0x0A, 0x55, 0x08,  // HID_USAGE_SENSOR_PROPERTY_POWER_STATE_D4_POWER_OFF
    0x0A, 0x51, 0x08,  // ID_USAGE_SENSOR_PROPERTY_POWER_STATE_D0_FULL_POWER
    0xB1, 0x00,        // Feature (DATA_ARR_ABS)
    0xC0,              // End Collection
    // 6-bit reporting interval, with values [0x00..0x3F] corresponding to [10ms..100ms]
    0x0A, 0x0E, 0x03,  // HID_USAGE_SENSOR_PROPERTY_REPORT_INTERVAL
    0x15, 0x00,        // Logical minimum (0)
    0x25, 0x3F,        // Logical maximum (63)
    0x35, 0x0A,        // Physical minimum (10)
    0x45, 0x64,        // Physical maximum (100)
    0x75, 0x06,        // Report Size  (6)
    0x95, 0x01,        // Report Count (1)
    0x66, 0x01, 0x10,  // HID_USAGE_SENSOR_UNITS_SECOND
    0x55, 0x0D,        // HID_UNIT_EXPONENT 10^-3
    0xB1, 0x02,        // Feature (DATA_VAR_ABS)
    // Orientation as rotation vector (scaled to [-pi..pi] rad)
    0x85, USB_HID_GYROSCOPE_DATA_IN_REPORT_ID, // Report Id (3)
    0x0A, 0x44, 0x05,  // HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_1
    0x16, 0x01, 0x80,  // Logical minimum (-32767)
    0x26, 0xFF, 0x7F,  // Logical minimum (32767)
    0x37, 0x60, 0x4F,  // Physical minimum_32 (-314159265)
          0x46, 0xED,
    0x47, 0xA1, 0xB0,  // Physical minimum_32 (314159265)
          0xB9, 0x12,
    0x55, 0x08,        // HID_UNIT_EXPONENT 10^-8
    0x75, 0x10,        // Report Size  (16)
    0x95, 0x03,        // Report Count (3)
    0x81, 0x02,        // Input (Data,Value,Absolute,Bit Field)
    // Angular velocity as rotation vector (scaled to [-32..32] rad/sec)
    0x0A, 0x45, 0x05,  // HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_2
    0x16, 0x01, 0x80,  // Logical minimum (-32767)
    0x26, 0xFF, 0x7F,  // Logical minimum (32767)
    0x35, 0xE0,        // Physical minimum (-32)
    0x45, 0x20,        // Physical maximum (32)
    0x55, 0x00,        // HID_UNIT_EXPONENT 10^0
    0x75, 0x10,        // Report Size  (16)
    0x95, 0x03,        // Report Count (3)
    0x81, 0x02,        // Input (Data,Value,Absolute,Bit Field)
    // Reference frame reset counter
    0x0A, 0x46, 0x05,  // HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_3
    0x15, 0x00,        // Logical minimum (0)
    0x25, 0xFF,        // Logical maximum (255)
    0x35, 0x00,        // Physical minimum (0)
    0x45, 0x00,        // Physical maximum (0)
    0x55, 0x00,        // HID_UNIT_EXPONENT 10^0
    0x75, 0x08,        // Report Size  (8)
    0x95, 0x01,        // Report Count (1)
    0x81, 0x02,        // Input (Data,Value,Absolute,Bit Field)
    0xC0,              // End Collection
#endif
};

const uint8_t report_sensor_dscr[] = {
#if 0
    0x05, 0x20,        // HID_USAGE_PAGE_SENSOR
    0x09, 0x01,        // HID_USAGE_SENSOR_TYPE_COLLECTION
    0xA1, 0x01,        // Collection (Application)
    0x85, 0x0E,        // Report Id (14)
    // 1-bit on/off reporting state
    0x0A, 0x16, 0x03,  // HID_USAGE_SENSOR_PROPERTY_REPORTING_STATE
    0x15, 0x00,        // Logical minimum (0)
    0x25, 0x01,        // Logical maximum (1)
    0x75, 0x01,        // Report Size  (1)
    0x95, 0x01,        // Report Count (1)
    0xA1, 0x02,        // Collection (Logical)
    0x0A, 0x40, 0x08,  // HID_USAGE_SENSOR_PROPERTY_REPORTING_STATE_NO_EVENTS
    0x0A, 0x41, 0x08,  // HID_USAGE_SENSOR_PROPERTY_REPORTING_STATE_ALL_EVENTS
    0xB1, 0x00,        // Feature (DATA_ARR_ABS)
    0xC0,              // End Collection
    // 1-bit on/off power state
    0x0A, 0x19, 0x03,  // HID_USAGE_SENSOR_PROPERTY_POWER_STATE
    0x15, 0x00,        // Logical minimum (0)
    0x25, 0x01,        // Logical maximum (1)
    0x75, 0x01,        // Report Size  (1)
    0x95, 0x01,        // Report Count (1)
    0xA1, 0x02,        // Collection (Logical)
    0x0A, 0x55, 0x08,  // HID_USAGE_SENSOR_PROPERTY_POWER_STATE_D4_POWER_OFF
    0x0A, 0x51, 0x08,  // ID_USAGE_SENSOR_PROPERTY_POWER_STATE_D0_FULL_POWER
    0xB1, 0x00,        // Feature (DATA_ARR_ABS)
    0xC0,              // End Collection
    // 6-bit reporting interval, with values [0x00..0x3F] corresponding to [10ms..100ms]
    0x0A, 0x0E, 0x03,  // HID_USAGE_SENSOR_PROPERTY_REPORT_INTERVAL
    0x15, 0x00,        // Logical minimum (0)
    0x25, 0x3F,        // Logical maximum (63)
    0x35, 0x0A,        // Physical minimum (10)
    0x45, 0x64,        // Physical maximum (100)
    0x75, 0x06,        // Report Size  (6)
    0x95, 0x01,        // Report Count (1)
    0x66, 0x01, 0x10,  // HID_USAGE_SENSOR_UNITS_SECOND
    0x55, 0x0D,        // HID_UNIT_EXPONENT 10^-3
    0xB1, 0x02,        // Feature (DATA_VAR_ABS)

    // Orientation as rotation vector (scaled to [-pi..pi] rad)
    0x85, 0x03,        // Report Id (3)
    0x0A, 0x44, 0x05,  // HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_1
    0x16, 0x01, 0x80,  // Logical minimum (-32767)
    0x26, 0xFF, 0x7F,  // Logical minimum (32767)
    0x37, 0x60, 0x4F,  // Physical minimum_32 (-314159265)
          0x46, 0xED,
    0x47, 0xA1, 0xB0,  // Physical minimum_32 (314159265)
          0xB9, 0x12,
    0x55, 0x08,        // HID_UNIT_EXPONENT 10^-8
    0x75, 0x10,        // Report Size  (16)
    0x95, 0x03,        // Report Count (3)
    0x81, 0x02,        // Input (Data,Value,Absolute,Bit Field)
    // Angular velocity as rotation vector (scaled to [-32..32] rad/sec)
    0x0A, 0x45, 0x05,  // HID_USAGE_SENSOR_DATA_CUSTOM_VALUE_2
    0x16, 0x01, 0x80,  // Logical minimum (-32767)
    0x26, 0xFF, 0x7F,  // Logical minimum (32767)
    0x35, 0xE0,        // Physical minimum (-32)
    0x45, 0x20,        // Physical maximum (32)
    0x55, 0x00,        // HID_UNIT_EXPONENT 10^0
    0x75, 0x10,        // Report Size  (16)
    0x95, 0x03,        // Report Count (3)
    0x81, 0x02,        // Input (Data,Value,Absolute,Bit Field)
    0xC0,              // End Collection
#endif
};

/**
 * report for Microsoft CFU
 */
const uint8_t report_cfu_dscr[] = {
#ifdef AIR_CFU_ENABLE
    /* CFU */
    0x06, 0x33, 0xFF,  // Usage Page (Vendor-defined 0xFF33)
    0x09, 0x05,        // Usage (Vendor-defined 0x0005)
    0xA1, 0x01,        // Collection (Application)
    0x15, 0x00,        // Logical minimum (0)
    0x26, 0xFF, 0x00,  // Logical maximum (255)
    // In Report
    0x85, USB_HID_CFU_DUMMY_IN_REPORT_ID, // Report Id (32)
    0x09, 0x52,        // Usage (Vendor-defined 0x0052, DUMMY_INPUT_USAGE)
    0x75, 0x08,        // Report Size  (8)
    0x95, 0x01,        // Report Count (1)
    0x81, 0x02,        // Input (Data,Array,Absolute,Bit Field)
    // In Report
    0x85, USB_HID_CFU_CONTENT_IN_REPORT_ID, // Report Id (34)
    0x09, 0x29,        // Usage (Vendor-defined 0x0029, CONTENT_RESPONSE_INPUT_USAGE)
    0x75, 0x20,        // Report Size  (32)
    0x95, 0x04,        // Report Count (4)
    0x81, 0x02,        // Input (Data,Array,Absolute,Bit Field)
    // In Report
    0x85, USB_HID_CFU_OFFER_IN_REPORT_ID, // Report Id (37)
    0x09, 0x1D,        // Usage (Vendor-defined 0x001D, OFFER_RESPONSE_INPUT_USAGE)
    0x75, 0x20,        // Report Size  (32)
    0x95, 0x04,        // Report Count (4)
    0x81, 0x02,        // Input (Data,Array,Absolute,Bit Field)
    // Output Report
    0x85, USB_HID_CFU_CONTENT_OUT_REPORT_ID, // Report Id (32)
    0x09, 0x31,        // Usage (Vendor-defined 0x0031, CONTENT_OUTPUT_USAGE)
    0x75, 0x08,        // Report Size  (8)
    0x95, 0x3C,        // Report Count (60)
    0x92, 0x02, 0x01,  // Output (Data,Array,Absolute,Buffered Bytes)
    // Output Report
    0x85, USB_HID_CFU_OFFER_OUT_REPORT_ID, // Report Id (37)
    0x09, 0x21,        // Usage (Vendor-defined 0x0021, OFFER_OUTPUT_USAGE)
    0x75, 0x20,        // Report Size  (32)
    0x95, 0x04,        // Report Count (4)
    0x92, 0x02, 0x01,  // Output (Data,Array,Absolute,Buffered Bytes)
    // Feature Report
    0x85, USB_HID_CFU_VERSION_FEATURE_REPORT_ID, // Report Id (32)
    0x09, 0x42,        // Usage (Vendor-defined 0x0042, VERSIONS_FEATURE_USAGE)
    0x75, 0x08,        // Report Size  (8)
    0x95, 0x3C,        // Report Count (60)
    0xB2, 0x02, 0x01,  // Feature(Data,Array,Absolute,Buffered Bytes)
    0xC0               // End Collection
#endif
};

/**
 * report for customer example
 */
const uint8_t report_customer_dscr[] = {
#if 0
    /* Customer */
    0x06, 0x14, 0xFF, // Usage Page (Vendor-defined ,0xFF14)
    0x09, 0x01,       // Usage      (Vendor-defined ,0x0001)
    0xA1, 0x01,       // Collection (Application)
    0x15, 0x00,       // Logical minimum (0)
    0x26, 0xFF, 0x00, // Logical maximum (255)
    /* ----- Add more HID report ,begin -----*/
    // Feature Report
    0x85, 0x14,       // Report Id (20)
    0x09, 0x00,       // Usage  (Vendor-defined ,0x0000)
    0x75, 0x08,       // Report Size  (8)
    0x95, 0x05,       // Report Count (5)
    0xB2, 0x02, 0x01, // Feature  (Data,Value,Absolute,Buffered Bytes)
    /* ----- Add more HID report ,end -----*/
    0xC0              // End Collection
#endif
};

/**
 * NOTE: This array should order by dscr_type
 */
static usb_hid_report_dscr_hdlr_t usb_hid_report_dscrs[USB_REPORT_DSCR_TYPE_NUM] = {
    {USB_REPORT_DSCR_TYPE_MUX,       "MUX",         report_mux_dscr,       sizeof(report_mux_dscr),       false},
    {USB_REPORT_DSCR_TYPE_AC,        "AC",          report_ac_dscr,        sizeof(report_ac_dscr),        false},
    {USB_REPORT_DSCR_TYPE_TEAMS,     "TEAMS",       report_teams_dscr,     sizeof(report_teams_dscr),     false},
    {USB_REPORT_DSCR_TYPE_TELEPHONY, "TETELEPHONY", report_telephony_dscr, sizeof(report_telephony_dscr), false},
    {USB_REPORT_DSCR_TYPE_KEYBOARD,  "KEYBOARD",    report_keyboard_dscr,  sizeof(report_keyboard_dscr),  false},
    {USB_REPORT_DSCR_TYPE_GYROMETER, "GYROMETER",   report_gyrometer_dscr, sizeof(report_gyrometer_dscr), false},
    {USB_REPORT_DSCR_TYPE_SENSOR,    "SENSOR",      report_sensor_dscr,    sizeof(report_sensor_dscr),    false},
    {USB_REPORT_DSCR_TYPE_CFU,       "CFU",         report_cfu_dscr,       sizeof(report_cfu_dscr),       false},
    {USB_REPORT_DSCR_TYPE_CUSTOMER,  "CUSTOMER",    report_customer_dscr,  sizeof(report_customer_dscr),  false},
};

/*****************************************************************************
 * Config Functions
 *****************************************************************************/
void usb_hid_device_enable(uint8_t portmask)
{
    for(uint8_t i = 0; i < USB_HID_MAX_DEVICE_NUM; i++) {
        if(portmask & (1 << i)) {
            g_UsbHids[i].enable = true;
            portmask &= ~(1 << i);
        } else {
            g_UsbHids[i].enable = false;
            }
        }

    if(portmask) {
        LOG_MSGID_E(USBHID, "usb_hid_device_enable these bits[0x%02X] are not supported. MAX_DEV_NUM[%d].",
                    2, portmask, USB_HID_MAX_DEVICE_NUM);
        assert(0 && "Bit shift in portmask exceeds USB_HID_MAX_DEVICE_NUM.");
    }
}

void usb_hid_report_enable(uint8_t port, usb_hid_report_dscr_type_t* list, uint8_t len)
{
    usb_hid_report_dscr_type_t dscr_type;

    if (port >= USB_HID_MAX_DEVICE_NUM) {
        assert(0 && "Port number exceeds USB_HID_MAX_DEVICE_NUM.");
        return;
    }

    /* Check dscr_type list */
    for (uint16_t i = 0; i < len; i++) {
        dscr_type = list[i];
        if (dscr_type >= USB_REPORT_DSCR_TYPE_NUM) {
            LOG_MSGID_E(USBHID, "usb_hid_report_enable dscr_type[%d] is not supported. USB_HID_MAX_DEVICE_NUM[%d].",
                        2, list[i], USB_REPORT_DSCR_TYPE_NUM);
            assert(0 && "dscr_type exceeds USB_HID_MAX_DEVICE_NUM.");
        }
    }

    /* Disable all reports */
    for (uint16_t i = 0; i < USB_REPORT_DSCR_TYPE_NUM; i++) {
        g_UsbHids[port].report_en_list[i] = false;
        }

    /* Enable reports in list */
    for (uint16_t i = 0; i < len; i++) {
        dscr_type = list[i];
        g_UsbHids[port].report_en_list[dscr_type] = true;
    }
}

static void usb_hid_print_reports(void)
{
    usb_hid_report_dscr_hdlr_t *hdlr __unused;

    for (uint8_t i = 0; i < USB_REPORT_DSCR_TYPE_NUM; i++) {
        hdlr = &(usb_hid_report_dscrs[i]);
        LOG_I(USBHID, "usb_hid_print_reports USB_REPORT_DSCR_TYPE_%-11s type:[%02d] len:[%02d] port:[%d] is %s.",
              hdlr->name, hdlr->type, hdlr->length, hdlr->hid_port, hdlr->enable ? "enable":"disable");
    }
}

static uint8_t usb_hid_find_port_by_report(usb_hid_report_dscr_type_t report_type)
{
    if(report_type >= USB_REPORT_DSCR_TYPE_NUM) {
        assert(0 && "usb_hid_find_port_by_report report_type >= USB_REPORT_DSCR_TYPE_NUM");
        return USB_HID_MAX_DEVICE_NUM;
    } else if(usb_hid_report_dscrs[report_type].enable == false) {
        return USB_HID_MAX_DEVICE_NUM;
    } else {
        return usb_hid_report_dscrs[report_type].hid_port;
    }
}

static uint8_t usb_hid_find_port_by_ep_in(uint8_t ep_id)
{
    uint8_t port;
    for (port = 0; port < USB_HID_MAX_DEVICE_NUM; port++) {
        if(g_UsbHids[port].enable && g_UsbHids[port].data_ep_in_id == ep_id) {
            break;
        }
    }
    return port;
}

/*****************************************************************************
 * HID Functions
 *****************************************************************************/
static uint32_t usb_hid_convert_ms_to_timer_count(uint32_t ms)
{
    /* current use 32k timer */
    return ((uint32_t)(ms * 32 + (7 * ms) / 10 + (6 * ms) / 100 + (8 * ms) / 1000));
    /* 1M clock */
    /* return ms * 1000; */
}

static uint8_t usb_hid_ep_tx(uint8_t port, uint8_t* data_buf, uint16_t data_len)
{
    uint8_t ep_tx_id;

    if (port >= USB_HID_MAX_DEVICE_NUM) {
        return USB_HID_PORT_INVIALD;
    }

    if (g_UsbHids[port].enable == false) {
        return USB_HID_PORT_DISABLE;
    }

    if (data_len == 0) {
        return USB_HID_TX_LEN_IS_ZERO;
    }

    if (data_len > g_UsbHids[port].ep_dscr->wMaxPacketSize) {
        return USB_HID_TX_LEN_TOO_LARGE;
    }

    ep_tx_id = g_UsbHids[port].data_ep_in_id;

    if (!hal_usb_is_endpoint_tx_empty(ep_tx_id)) {
        return USB_HID_TX_IS_BUSY;
    }

    /* Send data by endpoint*/
    hal_usb_write_endpoint_fifo(ep_tx_id, data_len, data_buf);
    hal_usb_set_endpoint_tx_ready_toggle(ep_tx_id);

    return USB_HID_STATUS_OK;
}

uint8_t usb_hid_tx_non_blocking(uint8_t port, uint8_t* data_buf, uint16_t data_len)
{
    uint8_t ret;
    ret = usb_hid_ep_tx(port, data_buf, data_len);

    if (ret != USB_HID_STATUS_OK) {
        LOG_MSGID_E(USBHID, "usb_hid_tx_non_blocking failed. status[%d].", 1, ret);
        }

#if 0
    uint8_t ep_tx_id = g_UsbHids[port].data_ep_in_id;
    LOG_HEXDUMP_I(USBHID, "EP_%02d IN len:%2d", data_buf, data_len, ep_tx_id, data_len);
#endif

    return ret;
}

uint8_t usb_hid_tx_blocking(uint8_t port, uint8_t* data_buf, uint16_t data_len, uint16_t timeout)
{
    uint8_t ep_tx_id;
    uint32_t stime; /* start time */
    uint32_t ctime; /* current time */
    uint32_t wtime; /* waiting time */
    uint32_t timeout_count;
    bool is_timeout      = false;
    USB_HID_Status_t ret = USB_HID_STATUS_OK;

    ret = usb_hid_ep_tx(port, data_buf, data_len);
    if (ret != USB_HID_STATUS_OK) {
        LOG_MSGID_E(USBHID, "usb_hid_tx_blocking failed. status[%d].", 1, ret);
        return ret;
    }

    ep_tx_id      = g_UsbHids[port].data_ep_in_id;
    timeout_count = usb_hid_convert_ms_to_timer_count(timeout);

    /* Wait for TX fifo empty */
    hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_32K, &stime);
    while ((is_timeout == false) && (!hal_usb_is_endpoint_tx_empty(ep_tx_id))) {
        hal_wdt_feed(HAL_WDT_FEED_MAGIC);

        hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_32K, &ctime);
        hal_gpt_get_duration_count(stime, ctime, &wtime);
        if (wtime >= timeout_count) {
            LOG_MSGID_E(USBHID, "usb_hid_tx_blocking send data timeout! status[%d].", 1, ret);
            is_timeout = true;
            memset(usb_rx, 0, USB_HID_REPORT_MAX_LEN);
            ret = USB_HID_SEND_DATA_ERROR;
    }
    }

    LOG_HEXDUMP_I(USBHID, "usb_hid_tx_blocking EP_%02d IN len:%2d", data_buf, data_len, ep_tx_id, data_len);

    return ret;
}

USB_HID_Status_t USB_HID_VolumeUp(uint8_t step)
{
    uint8_t i = 0;
    USB_HID_Status_t ret = USB_HID_STATUS_OK;

    uint8_t port = usb_hid_find_port_by_report(USB_REPORT_DSCR_TYPE_AC);
    LOG_MSGID_I(USBHID, "USB_HID_VolumeUp hid_port:%d step:%d", 2, port, step);

    if(port == USB_HID_MAX_DEVICE_NUM) {
        return USB_HID_TX_REPORT_IS_NOT_ENABLE;
    }

    uint8_t  set_data[2] = {USB_HID_AUDIO_REPORT_ID, USB_HID_VOLUME_UP};
    uint8_t  reset_data[2] = {USB_HID_AUDIO_REPORT_ID, USB_HID_NONE};

    for(i = 0; i < step; i++) {
        ret = usb_hid_tx_blocking(port, &set_data[0], sizeof(set_data), 1000);
        ret = usb_hid_tx_blocking(port, &reset_data[0], sizeof(reset_data), 1000);
        /* Wait for 50ms and not make volume change of Switch */
        hal_gpt_delay_ms(50);
    }

    return ret;
};

USB_HID_Status_t USB_HID_VolumeDown(uint8_t step)
{
    uint8_t i = 0;
    USB_HID_Status_t ret = USB_HID_STATUS_OK;

    uint8_t port = usb_hid_find_port_by_report(USB_REPORT_DSCR_TYPE_AC);
    LOG_MSGID_I(USBHID, "USB_HID_VolumeDown hid_port:%d step:%d", 2, port, step);

    if(port == USB_HID_MAX_DEVICE_NUM) {
        return USB_HID_TX_REPORT_IS_NOT_ENABLE;
    }

    uint8_t  set_data[2] = {USB_HID_AUDIO_REPORT_ID, USB_HID_VOLUME_DOWN};
    uint8_t  reset_data[2] = {USB_HID_AUDIO_REPORT_ID, USB_HID_NONE};

    for(i = 0; i < step; i++) {
        ret = usb_hid_tx_blocking(port, &set_data[0], sizeof(set_data), 1000);
        ret = usb_hid_tx_blocking(port, &reset_data[0], sizeof(reset_data), 1000);
        /* Wait for 50ms and not make volume change of Switch */
        hal_gpt_delay_ms(50);
    }

    return ret;
}

USB_HID_Status_t USB_HID_VolumeMute()
{
    USB_HID_Status_t ret = USB_HID_STATUS_OK;

    uint8_t port = usb_hid_find_port_by_report(USB_REPORT_DSCR_TYPE_AC);
    LOG_MSGID_I(USBHID, "USB_HID_VolumeMute hid_port:%d", 1, port);

    if(port == USB_HID_MAX_DEVICE_NUM) {
        return USB_HID_TX_REPORT_IS_NOT_ENABLE;
    }

    uint8_t  set_data[2] = {USB_HID_AUDIO_REPORT_ID, USB_HID_VOLUME_MUTE};
    uint8_t  reset_data[2] = {USB_HID_AUDIO_REPORT_ID, USB_HID_NONE};

    ret = usb_hid_tx_blocking(port, &set_data[0], sizeof(set_data), 1000);
    ret = usb_hid_tx_blocking(port, &reset_data[0], sizeof(reset_data), 1000);

    return ret;
};

USB_HID_Status_t USB_HID_PlayPause()
{
    USB_HID_Status_t ret = USB_HID_STATUS_OK;

    uint8_t port = usb_hid_find_port_by_report(USB_REPORT_DSCR_TYPE_AC);
    LOG_MSGID_I(USBHID, "USB_HID_PlayPause hid_port:%d", 1, port);

    if(port == USB_HID_MAX_DEVICE_NUM) {
        return USB_HID_TX_REPORT_IS_NOT_ENABLE;
    }

    uint8_t  set_data[2] = {USB_HID_AUDIO_REPORT_ID, USB_HID_PLAY_PAUSE};
    uint8_t  reset_data[2] = {USB_HID_AUDIO_REPORT_ID, USB_HID_NONE};

    ret = usb_hid_tx_blocking(port, &set_data[0], sizeof(set_data), 1000);
    ret = usb_hid_tx_blocking(port, &reset_data[0], sizeof(reset_data), 1000);

    return ret;
};

USB_HID_Status_t USB_HID_PlayPause2RejectCall()
{
    USB_HID_Status_t ret = USB_HID_STATUS_OK;

    uint8_t port = usb_hid_find_port_by_report(USB_REPORT_DSCR_TYPE_AC);
    LOG_MSGID_I(USBHID, "USB_HID_PlayPause2RejectCall hid_port:%d", 1, port);

    if(port == USB_HID_MAX_DEVICE_NUM) {
        return USB_HID_TX_REPORT_IS_NOT_ENABLE;
    }

    uint8_t  set_data[2] = {USB_HID_AUDIO_REPORT_ID, USB_HID_PLAY_PAUSE};
    uint8_t  reset_data[2] = {USB_HID_AUDIO_REPORT_ID, USB_HID_NONE};

    ret = usb_hid_tx_blocking(port, &set_data[0], sizeof(set_data), 1000);

    /* Reject phone call by pulling high about 2 sec */
    hal_gpt_delay_ms(2000);

    ret = usb_hid_tx_blocking(port, &reset_data[0], sizeof(reset_data), 1000);

    return ret;
};

USB_HID_Status_t USB_HID_ScanNextTrack()
{
    USB_HID_Status_t ret = USB_HID_STATUS_OK;

    uint8_t port = usb_hid_find_port_by_report(USB_REPORT_DSCR_TYPE_AC);
    LOG_MSGID_I(USBHID, "USB_HID_ScanNextTrack hid_port:%d", 1, port);

    if(port == USB_HID_MAX_DEVICE_NUM) {
        return USB_HID_TX_REPORT_IS_NOT_ENABLE;
    }

    uint8_t  set_data[2] = {USB_HID_AUDIO_REPORT_ID, USB_HID_SCAN_NEXT_TRACK};
    uint8_t  reset_data[2] = {USB_HID_AUDIO_REPORT_ID, USB_HID_NONE};

    ret = usb_hid_tx_blocking(port, &set_data[0], sizeof(set_data), 1000);
    ret = usb_hid_tx_blocking(port, &reset_data[0], sizeof(reset_data), 1000);

    return ret;
};

USB_HID_Status_t USB_HID_ScanPreviousTrack()
{
    USB_HID_Status_t ret = USB_HID_STATUS_OK;

    uint8_t port = usb_hid_find_port_by_report(USB_REPORT_DSCR_TYPE_AC);
    LOG_MSGID_I(USBHID, "USB_HID_ScanPreviousTrack hid_port:%d", 1, port);

    if(port == USB_HID_MAX_DEVICE_NUM) {
        return USB_HID_TX_REPORT_IS_NOT_ENABLE;
    }

    uint8_t  set_data[2] = {USB_HID_AUDIO_REPORT_ID, USB_HID_SCAN_PREVIOUS_TRACK};
    uint8_t  reset_data[2] = {USB_HID_AUDIO_REPORT_ID, USB_HID_NONE};

    ret = usb_hid_tx_blocking(port, &set_data[0], sizeof(set_data), 1000);
    ret = usb_hid_tx_blocking(port, &reset_data[0], sizeof(reset_data), 1000);

    return ret;
}

USB_HID_Status_t USB_HID_Win_Key_Func(USB_HID_WINDOWS_KEY_MODIFIER_FUNC_t key)
{
    USB_HID_Status_t ret = USB_HID_STATUS_OK;

    uint8_t port = usb_hid_find_port_by_report(USB_REPORT_DSCR_TYPE_KEYBOARD);
    LOG_MSGID_I(USBHID, "USB_HID_Win_Key_Func hid_port:%d, key:%d", 2, port, key);

    if(port == USB_HID_MAX_DEVICE_NUM) {
        return USB_HID_TX_REPORT_IS_NOT_ENABLE;
    }


    uint8_t  win_key_data[9] = {0x0A, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
    uint8_t  win_key_modifier_data[9] = {0x0A, 0x08, 0x00, key, 0x00, 0x00, 0x00, 0x00, 0x00};
    uint8_t  reset_data[9] = {0x0A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};

    if(key == USB_HID_KEYBOARD_KEY_WIN_KEY_ONLY)
    {
        ret = usb_hid_tx_blocking(port, &win_key_data[0], sizeof(win_key_data), 1000);
        hal_gpt_delay_ms(150);
        ret = usb_hid_tx_blocking(port, &reset_data[0], sizeof(reset_data), 1000);
    }
    else
    {
        ret = usb_hid_tx_blocking(port, &win_key_data[0], sizeof(win_key_data), 1000);
        hal_gpt_delay_ms(260);
        ret = usb_hid_tx_blocking(port, &win_key_modifier_data[0], sizeof(win_key_modifier_data), 1000);
        hal_gpt_delay_ms(100);
        ret = usb_hid_tx_blocking(port, &win_key_data[0], sizeof(win_key_data), 1000);
        hal_gpt_delay_ms(100);
        ret = usb_hid_tx_blocking(port, &reset_data[0], sizeof(reset_data), 1000);
    }

    return ret;
}

USB_HID_Status_t USB_HID_Gyroscope_Send_Rotate_Data_and_Reset(int16_t rx, int16_t  ry, int16_t  rz, int16_t vx, int16_t  vy, int16_t  vz, uint8_t frame_count)
{
    USB_HID_Status_t ret = USB_HID_STATUS_OK;

    uint8_t port = usb_hid_find_port_by_report(USB_REPORT_DSCR_TYPE_GYROMETER);
    LOG_MSGID_I(USBHID, "USB_HID_Gyroscope_Send_Rotate_Data_and_Reset hid_port:%d", 1, port);
    LOG_MSGID_I(USBHID, "USB_HID_Gyroscope_Send_Rotate_Data_and_Reset Angle rx = %x, ry = %x, rz = %x", 3, rx, ry, rz);
    LOG_MSGID_I(USBHID, "USB_HID_Gyroscope_Send_Rotate_Data_and_Reset Speed vx = %x, vx = %x, vx = %x", 3, vx, vy, vz);

    if(port == USB_HID_MAX_DEVICE_NUM) {
        return USB_HID_TX_REPORT_IS_NOT_ENABLE;
    }

    uint8_t  set_data[14] = {USB_HID_GYROSCOPE_DATA_IN_REPORT_ID, (rx & 0xFF), ((rx & 0xFF00)>>8), (ry & 0xFF), ((ry & 0xFF00)>>8), (rz & 0xFF), ((rz & 0xFF00)>>8), (vx & 0xFF), ((vx & 0xFF00)>>8), (vy & 0xFF), ((vy & 0xFF00)>>8), (vz & 0xFF), ((vz & 0xFF00)>>8), frame_count};
    LOG_MSGID_I(USBHID, "USB_HID_Gyroscope_Send_Rotate_Data_and_Reset check rotate angle data [1]=%x, [2]=%x, [3]=%x, [4]=%x, [5]=%x, [6]=%x", 6, set_data[1], set_data[2], set_data[3], set_data[4], set_data[5], set_data[6]);
    LOG_MSGID_I(USBHID, "USB_HID_Gyroscope_Send_Rotate_Data_and_Reset check rotate speed data [7]=%x, [8]=%x, [9]=%x, [10]=%x, [11]=%x, [12]=%x", 6, set_data[7], set_data[8], set_data[9], set_data[10], set_data[11], set_data[12]);

    ret = usb_hid_tx_blocking(port, &set_data[0], sizeof(set_data), 1000);

    return ret;
}

/*****************************************************************************
 * USB HID Handler
 *****************************************************************************/
static usb_hid_handler_t usb_hid_rx_handlers[USB_HID_HANDLER_MAX_NUM] = {
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL},
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL},
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL},
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL},
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL},
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL},
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL},
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL}
};

static usb_hid_handler_t usb_hid_tx_handlers[USB_HID_HANDLER_MAX_NUM] = {
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL},
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL},
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL},
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL},
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL},
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL},
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL},
    {USB_HID_HANDLER_INIT_REPORT_ID, 0, NULL}
};

USB_HID_HANDLER_t usb_hid_handler_init()
{
    LOG_MSGID_I(USBHID, "usb_hid_handler_init", 0);

    uint32_t index = 0;

    for (index = 0; index < USB_HID_HANDLER_MAX_NUM; index++) {
        usb_hid_rx_handlers[index].report_id = USB_HID_HANDLER_INIT_REPORT_ID;
        usb_hid_rx_handlers[index].report_length = 0;
        usb_hid_rx_handlers[index].handler_callback = NULL;

        usb_hid_tx_handlers[index].report_id = USB_HID_HANDLER_INIT_REPORT_ID;
        usb_hid_tx_handlers[index].report_length = 0;
        usb_hid_tx_handlers[index].handler_callback = NULL;
    }

    return USB_HID_HANDLER_STATUS_OK;
}

USB_HID_HANDLER_t usb_hid_handler_rx_register(uint8_t report_id, uint8_t report_length, usb_hid_handler_callback callback)
{
    uint32_t index = 0;

    for (index = 0; index < USB_HID_HANDLER_MAX_NUM; index++) {
        if (usb_hid_rx_handlers[index].report_id == USB_HID_HANDLER_INIT_REPORT_ID) {
            usb_hid_rx_handlers[index].report_id = report_id;
            usb_hid_rx_handlers[index].report_length = report_length;
            usb_hid_rx_handlers[index].handler_callback = (void *)callback;
            LOG_MSGID_I(USBHID, "usb_hid_handler_rx_register success to register index[%d] report_id[0x%02X] report_length[%d] callback[0x%08X]", 4,
                        index, usb_hid_rx_handlers[index].report_id, usb_hid_rx_handlers[index].report_length, usb_hid_rx_handlers[index].handler_callback);
            return USB_HID_HANDLER_STATUS_OK;
        } else if (usb_hid_rx_handlers[index].report_id == report_id) {
            LOG_MSGID_I(USBHID, "usb_hid_handler_rx_register already registered index[%d] report_id[0x%02X] report_length[%d] callback[0x%08X]", 4,
                        index, usb_hid_rx_handlers[index].report_id, usb_hid_rx_handlers[index].report_length, usb_hid_rx_handlers[index].handler_callback);
            return USB_HID_HANDLER_IS_NOT_READY;
        }
    }

    LOG_MSGID_E(USBHID, "usb_hid_handler_rx_register callback pool is full!!", 0);
    return USB_HID_HANDLER_STATUS_FAIL;
}

USB_HID_HANDLER_t usb_hid_handler_tx_register(uint8_t report_id, uint8_t report_length, usb_hid_handler_callback callback)
{
    uint32_t index = 0;

    for (index = 0; index < USB_HID_HANDLER_MAX_NUM; index++) {
        if (usb_hid_tx_handlers[index].report_id == USB_HID_HANDLER_INIT_REPORT_ID) {
            usb_hid_tx_handlers[index].report_id = report_id;
            usb_hid_tx_handlers[index].report_length = report_length;
            usb_hid_tx_handlers[index].handler_callback = (void *)callback;
            LOG_MSGID_I(USBHID, "usb_hid_handler_tx_register success to register index[%d] report_id[0x%02X] report_length[%d] callback[0x%08X]", 4,
                        index, usb_hid_tx_handlers[index].report_id, usb_hid_tx_handlers[index].report_length, usb_hid_tx_handlers[index].handler_callback);
            return USB_HID_HANDLER_STATUS_OK;
        } else if (usb_hid_tx_handlers[index].report_id == report_id) {
            LOG_MSGID_I(USBHID, "usb_hid_handler_tx_register already registered index[%d] report_id[0x%02X] report_length[%d] callback[0x%08X]", 4,
                        index, usb_hid_tx_handlers[index].report_id, usb_hid_tx_handlers[index].report_length, usb_hid_tx_handlers[index].handler_callback);
            return USB_HID_HANDLER_IS_NOT_READY;
        }
    }

    LOG_MSGID_E(USBHID, "usb_hid_handler_tx_register callback pool is full!!", 0);
    return USB_HID_HANDLER_STATUS_FAIL;
}

USB_HID_HANDLER_t usb_hid_rx_handler_unregister(uint8_t report_id)
{
    uint32_t index = 0;

    for (index = 0; index < USB_HID_HANDLER_MAX_NUM; index++) {
        if (usb_hid_rx_handlers[index].report_id == report_id) {
            usb_hid_rx_handlers[index].report_id = USB_HID_HANDLER_INIT_REPORT_ID;
            usb_hid_rx_handlers[index].report_length = 0;
            usb_hid_rx_handlers[index].handler_callback = NULL;
            LOG_MSGID_I(USBHID, "usb_hid_rx_handler_unregister success to unregister index[%d] report_id[0x%02X] report_length[%d] callback[0x%08X]", 4,
                        index, usb_hid_rx_handlers[index].report_id, usb_hid_rx_handlers[index].report_length, usb_hid_rx_handlers[index].handler_callback);
            return USB_HID_HANDLER_STATUS_OK;
        }
    }

    LOG_MSGID_E(USBHID, "usb_hid_rx_handler_unregister fail to unregister report_id[0x%02X] handler", 1, report_id);
    return USB_HID_HANDLER_STATUS_FAIL;
}

USB_HID_HANDLER_t usb_hid_tx_handler_unregister(uint8_t report_id)
{
    uint32_t index = 0;

    for (index = 0; index < USB_HID_HANDLER_MAX_NUM; index++) {
        if (usb_hid_tx_handlers[index].report_id == report_id) {
            usb_hid_tx_handlers[index].report_id = USB_HID_HANDLER_INIT_REPORT_ID;
            usb_hid_tx_handlers[index].report_length = 0;
            usb_hid_tx_handlers[index].handler_callback = NULL;
            LOG_MSGID_I(USBHID, "usb_hid_tx_handler_unregister success to unregister index[%d] report_id[0x%02X] report_length[%d] callback[0x%08X]", 4,
                        index, usb_hid_tx_handlers[index].report_id, usb_hid_tx_handlers[index].report_length, usb_hid_tx_handlers[index].handler_callback);
            return USB_HID_HANDLER_STATUS_OK;
        }
    }

    LOG_MSGID_E(USBHID, "usb_hid_tx_handler_unregister fail to unregister report_id[0x%02X] handler ", 1, report_id);
    return USB_HID_HANDLER_STATUS_FAIL;
}

/*****************************************************************************
 * USB MUX Port Select
 *****************************************************************************/
uint8_t USB_MUX_Port_Select(uint8_t report_id)
{
    /* Airoha In/Out Report*/
    if (report_id == USB_HID_AIR_OUT_REPORT_ID ||
        report_id == USB_HID_AIR_IN_REPORT_ID) {
        USB_DBG_I(USB_DBG_HID_MUX, "USB_MUX_Port_Select usb_mux_port[%x] report_id[%x]", 2, USB_MUX_PORT2, report_id);
        return USB_MUX_PORT2;
    }

    /* CFU */
    if (report_id == USB_HID_CFU_DUMMY_IN_REPORT_ID    ||
        report_id == USB_HID_CFU_CONTENT_IN_REPORT_ID  ||
        report_id == USB_HID_CFU_OFFER_IN_REPORT_ID    ||
        report_id == USB_HID_CFU_CONTENT_OUT_REPORT_ID ||
        report_id == USB_HID_CFU_OFFER_OUT_REPORT_ID   ||
        report_id == USB_HID_CFU_VERSION_FEATURE_REPORT_ID) {
        USB_DBG_I(USB_DBG_HID_MUX, "USB_MUX_Port_Select usb_mux_port[%x] report_id[%x]", 2, USB_MUX_PORT1, report_id);
        return USB_MUX_PORT1;
    }

    LOG_MSGID_E(USBHID, "USB_MUX_Port_Select Fail!", 0);
    return USB_MUX_PORT_UNUSE;
}

void USB_HID_Ep0_ReadData(void)
{
    bool ret;

    /* Check EP0 data is enough */
    ret = USB_Check_EP0_DataLen(0, usb_report_length);

    if(ret == false){
        gUsbDevice.ep0_state = USB_EP0_RX_STATUS;
        hal_usb_update_endpoint_0_state(HAL_USB_EP0_DRV_STATE_READ_END, false, true);

        if(g_mux_usb_hid_callback) {
        g_mux_usb_hid_callback(USB_MUX_PORT1, HID_EVENT_DROP_RX_DATA, NULL);
        g_mux_usb_hid_callback(USB_MUX_PORT2, HID_EVENT_DROP_RX_DATA, NULL);
        }

        LOG_MSGID_E(USBHID, "USB_HID_Ep0_ReadData check EP0 length fail", 0);
        return;
    }

    /* Get data of set report by EP0 */
    hal_usb_read_endpoint_fifo(0, usb_report_length, &usb_rx);

    USB_DBG_I(USB_DBG_HID_READDATA, "USB_HID_Ep0_ReadData %02X %02X %02X %02X %02X %02X %02X %02X", 8,
                usb_rx[0], usb_rx[1], usb_rx[2], usb_rx[3], usb_rx[4], usb_rx[5], usb_rx[6], usb_rx[7]);

#ifdef FREERTOS_ENABLE
    /* Send set report cmd to USB queue */
    USB_Send_Message(USB_HID_SET_REPORT, NULL);
#else
    USB_HID_Ep0_DispatchData();
#endif /* FREERTOS_ENABLE */

    return;
}

void USB_HID_Ep0_DispatchData(void)
{
    bool stall = false;
    uint8_t index, usb_mux_port = USB_MUX_PORT_UNUSE;

    USB_DBG_I(USB_DBG_HID_SET_REPORT, "USB_HID_Ep0_DispatchData", 0);
    LOG_MSGID_I(USBHID, "   Set Report %02X %02X %02X %02X %02X %02X %02X %02X"           , 8, usb_rx[0], usb_rx[1], usb_rx[2], usb_rx[3], usb_rx[4], usb_rx[5], usb_rx[6], usb_rx[7]);
    USB_DBG_I(USB_DBG_HID_SET_REPORT, "Set Report %02X %02X %02X %02X %02X %02X %02X %02X", 8, usb_rx[8], usb_rx[9], usb_rx[10], usb_rx[11], usb_rx[12], usb_rx[13], usb_rx[14], usb_rx[15]);
    USB_DBG_I(USB_DBG_HID_SET_REPORT, "Set Report %02X %02X %02X %02X %02X %02X %02X %02X", 8, usb_rx[16], usb_rx[17], usb_rx[18], usb_rx[19], usb_rx[20], usb_rx[21], usb_rx[22], usb_rx[23]);
    USB_DBG_I(USB_DBG_HID_SET_REPORT, "Set Report %02X %02X %02X %02X %02X %02X %02X %02X", 8, usb_rx[24], usb_rx[25], usb_rx[26], usb_rx[27], usb_rx[28], usb_rx[29], usb_rx[30], usb_rx[31]);
    USB_DBG_I(USB_DBG_HID_SET_REPORT, "Set Report %02X %02X %02X %02X %02X %02X %02X %02X", 8, usb_rx[32], usb_rx[33], usb_rx[34], usb_rx[35], usb_rx[36], usb_rx[37], usb_rx[38], usb_rx[39]);
    USB_DBG_I(USB_DBG_HID_SET_REPORT, "Set Report %02X %02X %02X %02X %02X %02X %02X %02X", 8, usb_rx[40], usb_rx[41], usb_rx[42], usb_rx[43], usb_rx[44], usb_rx[45], usb_rx[46], usb_rx[47]);
    USB_DBG_I(USB_DBG_HID_SET_REPORT, "Set Report %02X %02X %02X %02X %02X %02X %02X %02X", 8, usb_rx[48], usb_rx[49], usb_rx[50], usb_rx[51], usb_rx[52], usb_rx[53], usb_rx[54], usb_rx[55]);
    USB_DBG_I(USB_DBG_HID_SET_REPORT, "Set Report %02X %02X %02X %02X %02X %02X"          , 6, usb_rx[56], usb_rx[57], usb_rx[58], usb_rx[59], usb_rx[60], usb_rx[61]);

    /* HID handler dispatch the part of report */
    for (index = 0; index < USB_HID_HANDLER_MAX_NUM; index++) {
        /* According to report ID and send data to module*/
        if (usb_hid_rx_handlers[index].report_id == usb_rx[USB_HID_AIR_REPORT_ID_INDEX]) {
            USB_DBG_I(USB_DBG_HID_MUX, "Report id:0x%X is matched in HID RX handler table", 1, usb_rx[USB_HID_AIR_REPORT_ID_INDEX]);
            if(usb_hid_rx_handlers[index].handler_callback)
                usb_hid_rx_handlers[index].handler_callback(&usb_rx[USB_HID_AIR_REPORT_ID_INDEX], usb_hid_rx_handlers[index].report_length);
            break;
        }
    }

    /* HID report callback */
    if (index == USB_HID_HANDLER_MAX_NUM) {
        /* Depen on report ID to send data to Race or CFU */
        usb_mux_port = USB_MUX_Port_Select(usb_rx[USB_HID_AIR_REPORT_ID_INDEX]);

        if (usb_mux_port != USB_MUX_PORT_UNUSE) {
            if(g_mux_usb_hid_callback) {
                g_mux_usb_hid_callback(usb_mux_port, HID_EVENT_READY_TO_READ, NULL);
            } else {
                LOG_MSGID_E(USBHID, "USB_HID_Ep0_DispatchData g_mux_usb_hid_callback is NULL", 0);
            }
        }
    }

    /* No HID report was found in handler and callback*/
    if ((index == USB_HID_HANDLER_MAX_NUM) && (usb_mux_port == USB_MUX_PORT_UNUSE) ){
        LOG_MSGID_E(USBHID, "USB_HID_Ep0_DispatchData report ID:0x%02X was not found in handler and mux callback", 1, usb_report_id);
    }

    gUsbDevice.ep0_state = USB_EP0_RX_STATUS;
    hal_usb_update_endpoint_0_state(HAL_USB_EP0_DRV_STATE_READ_END, stall, true);

    return;
}

static void USB_HID_Ep0_SendData(void)
{
    uint8_t index, usb_mux_port;

    /* TEAMS */
    if (usb_report_id == USB_HID_TEAMS_FEATURE_REPORT_ID) {
        memset(usb_tx, 0, sizeof(usb_tx));
    }
    usb_tx[USB_HID_AIR_REPORT_ID_INDEX] = usb_report_id ;

    /* HID handler dispatch the part of report */
    for (index = 0; index < USB_HID_HANDLER_MAX_NUM; index++) {
        /* According to report ID and send data to module */
        if (usb_hid_tx_handlers[index].report_id == usb_report_id) {
            USB_DBG_I(USB_DBG_HID_MUX, "USB_HID_Ep0_SendData report_id:0x%02X is matched in HID TX handler table", 1, usb_report_id);
            usb_hid_tx_handlers[index].handler_callback(&usb_tx[USB_HID_AIR_REPORT_ID_INDEX], usb_hid_tx_handlers[index].report_length);
            break;
        }
    }

    /* HID report callback */
    if (index == USB_HID_HANDLER_MAX_NUM) {
        /* Depend on report ID to receive data from Race or CFU */
        usb_mux_port = USB_MUX_Port_Select(usb_report_id);

        if (usb_mux_port != USB_MUX_PORT_UNUSE) {
            if(g_mux_usb_hid_callback) {
                g_mux_usb_hid_callback(usb_mux_port, HID_EVENT_READY_TO_WRITE, NULL);
            } else {
                LOG_MSGID_E(USBHID, "USB_HID_Ep0_DispatchData g_mux_usb_hid_callback is NULL", 0);
            }
        }
    }

    /* No HID report was found in handler and callback*/
    if ((index == USB_HID_HANDLER_MAX_NUM) && (usb_mux_port == USB_MUX_PORT_UNUSE) ){
        LOG_MSGID_E(USBHID, "USB_HID_Ep0_SendData report ID:0x%X was not found in handler and callback", 1, usb_report_id);
    }

    /* Get Report log */
    if((usb_report_id != USB_HID_AIR_IN_REPORT_ID) || (usb_tx[USB_HID_AIR_REPORT_LEN_INDEX]!=0)){
        /* Get Report of can't be enabled in HID logging which would cause lot of USB log in each normal log */
        mux_port_t log_port = syslog_port_query_running_port();

        if((log_port >= MUX_UART_BEGIN) && (log_port <= MUX_UART_END)) {
            LOG_MSGID_I(USBHID,          "     Get Report %02X %02X %02X %02X %02X %02X %02X %02X", 8, usb_tx[0], usb_tx[1], usb_tx[2], usb_tx[3], usb_tx[4], usb_tx[5], usb_tx[6], usb_tx[7]);
        USB_DBG_I(USB_DBG_HID_GET_REPORT, "Get Report %02X %02X %02X %02X %02X %02X %02X %02X", 8, usb_tx[8], usb_tx[9], usb_tx[10], usb_tx[11], usb_tx[12], usb_tx[13], usb_tx[14], usb_tx[15]);
        USB_DBG_I(USB_DBG_HID_GET_REPORT, "Get Report %02X %02X %02X %02X %02X %02X %02X %02X", 8, usb_tx[16], usb_tx[17], usb_tx[18], usb_tx[19], usb_tx[20], usb_tx[21], usb_tx[22], usb_tx[23]);
        USB_DBG_I(USB_DBG_HID_GET_REPORT, "Get Report %02X %02X %02X %02X %02X %02X %02X %02X", 8, usb_tx[24], usb_tx[25], usb_tx[26], usb_tx[27], usb_tx[28], usb_tx[29], usb_tx[30], usb_tx[31]);
        USB_DBG_I(USB_DBG_HID_GET_REPORT, "Get Report %02X %02X %02X %02X %02X %02X %02X %02X", 8, usb_tx[32], usb_tx[33], usb_tx[34], usb_tx[35], usb_tx[36], usb_tx[37], usb_tx[38], usb_tx[39]);
        USB_DBG_I(USB_DBG_HID_GET_REPORT, "Get Report %02X %02X %02X %02X %02X %02X %02X %02X", 8, usb_tx[40], usb_tx[41], usb_tx[42], usb_tx[43], usb_tx[44], usb_tx[45], usb_tx[46], usb_tx[47]);
        USB_DBG_I(USB_DBG_HID_GET_REPORT, "Get Report %02X %02X %02X %02X %02X %02X %02X %02X", 8, usb_tx[48], usb_tx[49], usb_tx[50], usb_tx[51], usb_tx[52], usb_tx[53], usb_tx[54], usb_tx[55]);
        USB_DBG_I(USB_DBG_HID_GET_REPORT, "Get Report %02X %02X %02X %02X %02X %02X"          , 6, usb_tx[56], usb_tx[57], usb_tx[58], usb_tx[59], usb_tx[60], usb_tx[61]);
    }
    }

}

static UsbHid_Struct* usb_hid_find_dev_by_if(uint8_t if_id)
{
    UsbHid_Struct *usbhid = NULL;

    for (uint8_t i = 0; i < USB_HID_MAX_DEVICE_NUM; i++) {
        if (g_UsbHids[i].enable && g_UsbHids[i].data_interface_id == if_id) {
            usbhid = &g_UsbHids[i];
            break;
        }
    }
    return usbhid;
}


/* Parse class specific request */
static void USB_HID_Ep0_Command(Usb_Ep0_Status *pep0state, Usb_Command *pcmd)
{
    bool  bError = false;
    uint8_t if_id = pcmd->wIndex;
    uint8_t wValueL = gUsbDevice.cmd.wValue & 0x00FF;
    uint8_t wValueH = (gUsbDevice.cmd.wValue & 0xFF00) >> 8;
    UsbHid_Struct *usbhid __unused = usb_hid_find_dev_by_if(if_id);

    switch (pcmd->bRequest) {
        case USB_HID_BREQUEST_SET_IDLE:
            /**
             * 7.2.4 Set_Idle Request
             *  - bmRequestType 00100001
             *  - wValue        Duration and Report ID
             *  - wIndex        Interface
             *  - wLength       0 (zero)
             *  - Data Not      applicable
             */
#ifdef USB_HID_SUPPORT_IDLE_RATE
            usbhid->idle_val[wValueL] = wValueH;
#else
            bError = true;
#endif
            break;
        case USB_HID_BREQUEST_GET_IDLE:
            /**
             * 7.2.3 Get_Idle Request
             *  - bmRequestType 10100001
             *  - bRequest      GET_IDLE
             *  - wValue        0 (zero) and Report ID
             *  - wIndex        Interface
             *  - wLength       1 (one)
             *  - Data Idle     rate
             */
#ifdef USB_HID_SUPPORT_IDLE_RATE
            USB_Generate_EP0Data(&gUsbDevice.ep0info, &gUsbDevice.cmd, &usbhid->idle_val[wValueL], 1);
#else
            bError = true;
#endif
            break;
        case USB_HID_BREQUEST_SET_REPORT:
            /**
             * 7.2.2 Set_Report Request
             * bmRequestType 00100001
             * bRequest      SET_REPORT
             * wValue        Report Type and Report ID
             * wIndex        Interface
             * wLength       Report Length
             * Data          Report
             */
            usb_report_id     = wValueL;
            usb_report_type   = wValueH;
            usb_report_length = (pcmd->wLength);

            /* 1. USB interrupt for cmd 2. Wait for USB interrupt of data */
            gUsbDevice.ep0_rx_handler = (usb_ep0_rx_ptr)USB_HID_Ep0_ReadData;
            gUsbDevice.ep0_state = USB_EP0_RX;
            break;
        case USB_HID_BREQUEST_GET_REPORT:
            /**
             * 7.2.1 Get_Report Request
             * bmRequestType 10100001
             * bRequest      GET_REPORT
             * wValue        Report Type and Report ID
             * wIndex        Interface
             * wLength       Report Length
             * Data          Report
             */
            /* Get the target Report ID from low byte of wValue */
            usb_report_id     = wValueL;
            usb_report_type   = wValueH;
            usb_report_length = (pcmd->wLength);

            USB_HID_Ep0_SendData();

            USB_Generate_EP0Data(&gUsbDevice.ep0info, &gUsbDevice.cmd, &usb_tx, usb_report_length);
            break;
        default:
            bError = true;
            break;
    }
    /* Stall command if an error occured */
    USB_EP0_Command_Hdlr(bError);
}

/* When PC return ACK, handle HID intr pipe state machine */
static void USB_HID_IntrIn_Hdr(void)
{
};

static void USB_HID_IntrIn_Reset(void)
{
};

/******************************************************************************
 * USB HID Descriptor Serialize functions
 *****************************************************************************/
static int32_t usb_hid_dscr_interface_serialize(void *dscr, void *out, uint32_t ava_size)
{
    usb_hid_dscr_interface_t *p;
    uint8_t len;

    p = (usb_hid_dscr_interface_t *)dscr;
    len = sizeof(usb_hid_dscr_interface_t);
    p->bLength = len;

    if (ava_size < len) {
        assert(0);
        return 0;
    }

    for (int i = 0; i < len; i++) {
        ((uint8_t *)out)[i] = ((uint8_t *)dscr)[i];
    }

    return len;
}

static int32_t usb_hid_dscr_hid_serialize(void *dscr, void *out, uint32_t ava_size)
{
    usb_hid_dscr_hid_t *p;
    uint8_t len;

    p = (usb_hid_dscr_hid_t *)dscr;
    len = sizeof(usb_hid_dscr_hid_t);
    len -= (USB_DSCR_HID_MAX_CONT_DSCRS - p->bNumDescriptors) * sizeof(usb_hid_cont_dscr_t);
    p->bLength = len;

    if (ava_size < len) {
        assert(0);
        return 0;
    }

    for (int i = 0; i < len; i++) {
        ((uint8_t *)out)[i] = ((uint8_t *)dscr)[i];
    }

    return len;
}

static int32_t usb_hid_dscr_endpoint_serialize(void *dscr, void *out, uint32_t ava_size)
{
    usb_hid_dscr_endpoint_t *p;
    uint8_t len;

    p = (usb_hid_dscr_endpoint_t *)dscr;
    len = sizeof(usb_hid_dscr_endpoint_t);
    p->bLength = len;

    if (ava_size < len) {
        assert(0);
        return 0;
    }

    for (int i = 0; i < len; i++) {
        ((uint8_t *)out)[i] = ((uint8_t *)dscr)[i];
    }

    return len;
}

/******************************************************************************
 * USB HID Interface initialization functions
 *****************************************************************************/
static void usb_hid_report_gen(uint8_t port)
{
    UsbHid_Struct *usbhid = &g_UsbHids[port];
    usb_hid_report_dscr_hdlr_t *hdlr;
    void *ptr = usbhid->report_dscr;
    uint32_t len = 0;

    /* Check total length of dscrs */
    for (uint8_t i = 0; i < USB_REPORT_DSCR_TYPE_NUM; i++) {
        if (usbhid->report_en_list[i] == true) {
            hdlr = &(usb_hid_report_dscrs[i]);
            if (hdlr->enable) {
                LOG_MSGID_E(USBHID, "usb_hid_report_gen report descript type[%d] is already used by port[%d]", 2,
                            hdlr->enable, hdlr->hid_port);
                // temp work around for test, need to patch
                // assert(0 && "Report is already used by another port.");
            }
            len += hdlr->length;
        }
    }

    if(len > USB_HID_REPOTR_DSCR_MAX_SIZE) {
        LOG_MSGID_E(USBHID, "usb_hid_report_gen USB_HID_REPOTR_DSCR_MAX_SIZE[%d] is less than total length[%d]", 2,
                    USB_HID_REPOTR_DSCR_MAX_SIZE, len);
        assert(0 && "usb_hid_report_gen USB_HID_REPOTR_DSCR_MAX_SIZE < real report length");
    }

    /* Copy dscr to hid_report_dscr */
    for (uint8_t i = 0; i < USB_REPORT_DSCR_TYPE_NUM; i++) {
        if (usbhid->report_en_list[i] == true) {
            LOG_MSGID_I(USBHID, "usb_hid_report_gen report_en_list type:[%d] is enable", 1, i);
            hdlr = &(usb_hid_report_dscrs[i]);
            hdlr->enable = true;
            hdlr->hid_port = port;
            ptr = memcpy(ptr, hdlr->dscr, hdlr->length);
        }
    }
    LOG_MSGID_I(USBHID, "usb_hid_report_gen report_dscr_length[%d]", 1, len);
    usbhid->report_dscr_length = len;
}

void USB_HID_If_Create(void *ifname, uint8_t port)
{
    uint8_t ep_id;
    uint8_t if_id;
    uint8_t *dscr_out;
    size_t len = 0;
    UsbHid_Struct *usbhid = NULL;

    if (port >= USB_HID_MAX_DEVICE_NUM) {
        assert(0 && "USB_HID_If_Create the port num exceeds USB_HID_MAX_DEVICE_NUM");
        return;
    }

    if (g_UsbHids[port].enable == false) {
        assert(0 && "USB_HID_If_Create the port is disable");
        return;
    }

    usbhid = &g_UsbHids[port];

    /* Assign reource ptr from s_hid_resource */
    usbhid->report_dscr = s_hid_resource[port].report_dscr;
    usbhid->if_dscr     = &s_hid_resource[port].if_dscr;
    usbhid->hid_dscr    = &s_hid_resource[port].hid_dscr;
    usbhid->ep_dscr     = &s_hid_resource[port].ep_dscr;

#ifdef USB_HID_SUPPORT_IDLE_RATE
    /* Set and Clear idle value */
    usbhid->idle_val    = s_hid_resource[port].idle_val;
    memset(usbhid->idle_val, 0, 255);
#endif

    /* Generate hid report decriptor */
    usb_hid_report_gen(port);
    usb_hid_print_reports();

    /* Get resource number and register to gUsbDevice */
    usbhid->comm_if_info = USB_Get_Interface_Number(&if_id);
    usbhid->comm_ep_intr_info = USB_Get_Intr_Tx_Ep(&ep_id);
    usbhid->data_interface_id = if_id;
    usbhid->data_ep_in_id = ep_id;

    /* Record interface name */
    usbhid->comm_if_info->interface_name_ptr = (char *)ifname;

    /* Copy default dscr setting */
    memcpy(usbhid->if_dscr,  &hid_if_template_dscr, sizeof(usb_hid_dscr_interface_t));
    memcpy(usbhid->hid_dscr, &hid_template_dscr,    sizeof(usb_hid_dscr_hid_t)      );
    memcpy(usbhid->ep_dscr,  &hid_ep_template_dscr, sizeof(usb_hid_dscr_endpoint_t) );

    /* Set if_dscr */
    usbhid->if_dscr->bInterfaceNumber = if_id;
    usbhid->if_dscr->bAlternateSetting = 0;
    usbhid->if_dscr->bNumEndpoints = 1;
    usbhid->if_dscr->iInterface = USB_String_Get_Id_By_Usage(USB_STRING_USAGE_HID);

    /* Set hid_dscr */
    usbhid->hid_dscr->cont_dscrs[0].wDescriptorLength = usbhid->report_dscr_length;

    /* Set ep_dscr */
    usbhid->ep_dscr->bEndpointAddress = (USB_EP_DIR_IN | ep_id);    /*InPipe*/

    /* Related endpoint info and class specific command handler */
    usbhid->comm_if_info->ep_info[0] = usbhid->comm_ep_intr_info;
    usbhid->comm_if_info->if_class_specific_hdlr = USB_HID_Ep0_Command;

    /* generate hid interface and store length */
    dscr_out = usbhid->comm_if_info->ifdscr.classif;
    len = 0;
    len += usb_hid_dscr_interface_serialize(usbhid->if_dscr, dscr_out + len, USB_MAX_IFDSC_LENGTH - len);
    len += usb_hid_dscr_hid_serialize(usbhid->hid_dscr, dscr_out + len, USB_MAX_IFDSC_LENGTH - len);
    usbhid->comm_if_info->ifdscr_size = len;

    /* generate hid endpoint and store length */
    dscr_out = usbhid->comm_ep_intr_info->epdesc.classep;
    len = 0;
    len += usb_hid_dscr_endpoint_serialize(usbhid->ep_dscr, dscr_out + len, USB_MAX_CLASS_EPDESC_LENGTH - len);
    usbhid->comm_ep_intr_info->epdscr_size = len;

    hal_usb_register_driver_callback(HAL_USB_DRV_HDLR_EP_TX, ep_id, USB_HID_IntrIn_Hdr);
    usbhid->comm_ep_intr_info->ep_reset = USB_HID_IntrIn_Reset;

    /* Endpoint descriptor */
    usbhid->comm_ep_intr_info->ep_status.epin_status.byEP = ep_id;
    usbhid->comm_ep_intr_info->ep_status.epin_status.nBytesLeft = USB_EP_NODATA;

    check_hid_report(usbhid->report_dscr, usbhid->report_dscr_length);

    /* Create IAD descriptor, if need it. e.g. (Audio + HID + CDC) */
    if (gUsbDevice.use_iad == true) {
        usbhid->iad_desc      = USB_Get_IAD_Number();
        Usb_IAD_Dscr *iad_desc = usbhid->iad_desc;

        iad_desc->bLength           = USB_IAD_LENGTH;
        iad_desc->bDescriptorType   = USB_INTERFACE_ASSOCIATION;
        iad_desc->bFirstInterface   = if_id;
        iad_desc->bInterfaceCount   = 1;
        iad_desc->bFunctionClass    = USB_IF_CLASS_HID;
        iad_desc->bFunctionSubClass = USB_HID_SUBCLASS_CODE_NONE;
        iad_desc->bFunctionProtocol = USB_HID_PROTOCOL_CODE_NONE;
        iad_desc->iFunction         = 0x00;
    }
}

void USB_HID_If_Reset(uint8_t port)
{
    UsbHid_Struct *usbhid = NULL;

    if (port >= USB_HID_MAX_DEVICE_NUM) {
        assert(0 && "USB_HID_If_Reset the port num exceeds USB_HID_MAX_DEVICE_NUM");
        return;
    }

    usbhid = &g_UsbHids[port];

    usbhid->intrpipe = &usbhid->comm_ep_intr_info->ep_status.epin_status;

    if (hal_usb_is_high_speed() == true) {
        usbhid->comm_ep_intr_info->epdesc.stdep.bInterval = 6; /* (2^(6-1))*0.125us=4ms*/
    } else {
        usbhid->comm_ep_intr_info->epdesc.stdep.bInterval = 4; /* (2^(4-1))*1ms=4ms*/
    }
}

void USB_HID_If_Enable(uint8_t port)
{
    UsbHid_Struct *usbhid = NULL;

    if (port >= USB_HID_MAX_DEVICE_NUM) {
        assert(0 && "USB_HID_If_Enable the port num exceeds USB_HID_MAX_DEVICE_NUM");
        return;
    }

    usbhid = &g_UsbHids[port];

    /* Non-DMA */
    hal_usb_enable_tx_endpoint(usbhid->intrpipe->byEP, HAL_USB_EP_TRANSFER_INTR, HAL_USB_EP_USE_NO_DMA, true);
}

void USB_HID_If_Speed_Reset(bool b_other_speed, uint8_t port)
{
    if (port >= USB_HID_MAX_DEVICE_NUM) {
        assert(0 && "USB_HID_If_Speed_Reset the port num exceeds USB_HID_MAX_DEVICE_NUM");
        return;
    }
}

void USB_HID0_If_Create(void* ifname) { USB_HID_If_Create(ifname, 0); }
void USB_HID1_If_Create(void* ifname) { USB_HID_If_Create(ifname, 1); }
void USB_HID2_If_Create(void* ifname) { USB_HID_If_Create(ifname, 2); }
void USB_HID3_If_Create(void* ifname) { USB_HID_If_Create(ifname, 3); }
void USB_HID4_If_Create(void* ifname) { USB_HID_If_Create(ifname, 4); }
void USB_HID5_If_Create(void* ifname) { USB_HID_If_Create(ifname, 5); }
void USB_HID6_If_Create(void* ifname) { USB_HID_If_Create(ifname, 6); }
void USB_HID7_If_Create(void* ifname) { USB_HID_If_Create(ifname, 7); }

void USB_HID0_If_Reset(void) { USB_HID_If_Reset(0); }
void USB_HID1_If_Reset(void) { USB_HID_If_Reset(1); }
void USB_HID2_If_Reset(void) { USB_HID_If_Reset(2); }
void USB_HID3_If_Reset(void) { USB_HID_If_Reset(3); }
void USB_HID4_If_Reset(void) { USB_HID_If_Reset(4); }
void USB_HID5_If_Reset(void) { USB_HID_If_Reset(5); }
void USB_HID6_If_Reset(void) { USB_HID_If_Reset(6); }
void USB_HID7_If_Reset(void) { USB_HID_If_Reset(7); }

void USB_HID0_If_Enable(void) { USB_HID_If_Enable(0); }
void USB_HID1_If_Enable(void) { USB_HID_If_Enable(1); }
void USB_HID2_If_Enable(void) { USB_HID_If_Enable(2); }
void USB_HID3_If_Enable(void) { USB_HID_If_Enable(3); }
void USB_HID4_If_Enable(void) { USB_HID_If_Enable(4); }
void USB_HID5_If_Enable(void) { USB_HID_If_Enable(5); }
void USB_HID6_If_Enable(void) { USB_HID_If_Enable(6); }
void USB_HID7_If_Enable(void) { USB_HID_If_Enable(7); }

void USB_HID0_If_Speed_Reset(bool bset) { USB_HID_If_Speed_Reset(bset, 0); }
void USB_HID1_If_Speed_Reset(bool bset) { USB_HID_If_Speed_Reset(bset, 1); }
void USB_HID2_If_Speed_Reset(bool bset) { USB_HID_If_Speed_Reset(bset, 2); }
void USB_HID3_If_Speed_Reset(bool bset) { USB_HID_If_Speed_Reset(bset, 3); }
void USB_HID4_If_Speed_Reset(bool bset) { USB_HID_If_Speed_Reset(bset, 4); }
void USB_HID5_If_Speed_Reset(bool bset) { USB_HID_If_Speed_Reset(bset, 5); }
void USB_HID6_If_Speed_Reset(bool bset) { USB_HID_If_Speed_Reset(bset, 6); }
void USB_HID7_If_Speed_Reset(bool bset) { USB_HID_If_Speed_Reset(bset, 7); }

const usb_create_if_func_ptr usb_hid_if_create_funcs[8] = {
    USB_HID0_If_Create,
    USB_HID1_If_Create,
    USB_HID2_If_Create,
    USB_HID3_If_Create,
    USB_HID4_If_Create,
    USB_HID5_If_Create,
    USB_HID6_If_Create,
    USB_HID7_If_Create,
};

const usb_void_func usb_hid_if_init_funcs[8] = {
    USB_HID0_If_Reset,
    USB_HID1_If_Reset,
    USB_HID2_If_Reset,
    USB_HID3_If_Reset,
    USB_HID4_If_Reset,
    USB_HID5_If_Reset,
    USB_HID6_If_Reset,
    USB_HID7_If_Reset,
};

const usb_void_func usb_hid_if_enable_funcs[8] = {
    USB_HID0_If_Enable,
    USB_HID1_If_Enable,
    USB_HID2_If_Enable,
    USB_HID3_If_Enable,
    USB_HID4_If_Enable,
    USB_HID5_If_Enable,
    USB_HID6_If_Enable,
    USB_HID7_If_Enable,
};

const usb_speed_if_func_ptr usb_hid_if_speed_funcs[8] = {
    USB_HID0_If_Speed_Reset,
    USB_HID1_If_Speed_Reset,
    USB_HID2_If_Speed_Reset,
    USB_HID3_If_Speed_Reset,
    USB_HID4_If_Speed_Reset,
    USB_HID5_If_Speed_Reset,
    USB_HID6_If_Speed_Reset,
    USB_HID7_If_Speed_Reset,
};

const usb_void_func usb_hid_if_resume_funcs[8] = {
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
};

bool usb_hid_get_descriptor(Usb_Ep0_Status *pep0state, Usb_Command *pcmd)
{
    uint8_t if_id = pcmd->wIndex;
    UsbHid_Struct *usbhid = NULL;
    bool bError = false;

    LOG_MSGID_I(USBHID, "usb_hid_get_descriptor if_id[0x%02X] dscr[0x%02X]", 2, if_id, (pcmd->wValue>>8));
    for (uint8_t i = 0; i < USB_HID_MAX_DEVICE_NUM; i++) {
        if (g_UsbHids[i].enable && g_UsbHids[i].data_interface_id == if_id) {
            usbhid = &g_UsbHids[i];
            break;
        }
    }

    if (usbhid == NULL) {
        assert(0 && "usb_hid_get_descriptor usbhid is null");
        return true;
    }

    switch (pcmd->wValue & USB_CMD_DESCMASK) {
        case USB_CMD_HID_DESC:
            USB_Generate_EP0Data(pep0state, pcmd, usbhid->hid_dscr, usbhid->hid_dscr->bLength);
            break;
        case USB_CMD_HID_REPORT:
            USB_Generate_EP0Data(pep0state, pcmd, usbhid->report_dscr, usbhid->report_dscr_length);
            break;
        case USB_CMD_HID_PHYSICAL:
            bError = true;
            break;
    }
    return bError;
}

void USB_HID_Speed_Reset(bool b_other_speed)
{
}

void USB_Init_Hid_Status(void)
{
    LOG_MSGID_I(USBHID, "USB_Init_Hid_Status", 0);
}

void USB_Release_Hid_Status(void)
{
    LOG_MSGID_I(USBHID, "USB_Release_Hid_Status", 0);
}

// from SPEC Device Class Definition for Human Interface Devices (HID) Version 1.11
//  ReportID 0b1000 01 nn
//  Input    0b1000 00 nn
//  Output   0b1001 00 nn
//  Feature  0b1011 00 nn
#define TAG_ReportID 0b10000100 // binary format
#define TAG_Input    0b10000000 // binary format
#define TAG_Output   0b10010000 // binary format
#define TAG_Feature  0b10110000 // binary format
typedef uint16_t Report_Info_t; // (report_id<<8) | report_type
typedef void (*DUMP_HID_REPORT_FUNC)(void* pUserdata, Report_Info_t Report_ID);
void dump_hid_report(const uint8_t *pHidReport, uint32_t remaining_size, DUMP_HID_REPORT_FUNC func,void* pUserdata)
{
    uint32_t Report_ID = 0;

    uint32_t Report_ID_New_Input = 0;
    uint32_t Report_ID_New_Output = 0;
    uint32_t Report_ID_New_Feature = 0;

    while(remaining_size)
    {
        uint8_t itemformat = *pHidReport;
        uint8_t datasize;

        ++pHidReport;
        --remaining_size;
        if(itemformat==0xFE) {
            // long tag

            datasize = (*pHidReport);
            pHidReport += 2;
            if( remaining_size >= 2 ) {
                remaining_size -= 2;
            } else {
                LOG_MSGID_I(USBHID, "dump_hid_report: parser error %d, %d %d", 3,__LINE__, remaining_size, datasize);
                return;
            }

        } else {
            // short tag
            datasize = itemformat & 0x3; // 0 1 2 4
            if (datasize == 3) {
                ++datasize; // force to 4
            }
            uint8_t bTag = itemformat & 0xFC;

            if(bTag==TAG_ReportID) {
                uint8_t i;
                Report_ID = 0;
                for(i=0;i<datasize;++i) {
                    Report_ID |= *(pHidReport+i) << (8*i);
                }

                Report_ID_New_Input = 1;
                Report_ID_New_Output = 1;
                Report_ID_New_Feature = 1;

            } else if(bTag==TAG_Input) {

                if(Report_ID) {
                    if(Report_ID_New_Input) {
                        if(func) {
                            func(pUserdata, (Report_ID << 8) | TAG_Input);
                        } else {
                            LOG_MSGID_I(USBHID, "dump_hid_report: Report ID(0x%x) input", 1, Report_ID);
                        }
                        Report_ID_New_Input = 0;
                    }
                }

            } else if(bTag==TAG_Output) {

                if(Report_ID) {
                    if(Report_ID_New_Output) {
                        if(func) {
                            func(pUserdata, (Report_ID << 8) | TAG_Output);
                        } else {
                            LOG_MSGID_I(USBHID, "dump_hid_report: Report ID(0x%x) output", 1, Report_ID);
                        }
                        Report_ID_New_Output = 0;
                    }
                }

            } else if(bTag==TAG_Feature) {

                if(Report_ID) {
                    if(Report_ID_New_Feature) {
                        if(func) {
                            func(pUserdata, (Report_ID << 8) | TAG_Feature);
                        } else {
                            LOG_MSGID_I(USBHID, "dump_hid_report: Report ID(0x%x) feature", 1, Report_ID);
                        }
                        Report_ID_New_Feature = 0;
                    }
                }

            } else {
                // do nothing
            }

        }

        if(remaining_size>=datasize) {
             remaining_size -= datasize;
             pHidReport += datasize;
        } else {
             LOG_MSGID_I(USBHID, "dump_hid_report: parser error %d, %d %d", 3,__LINE__, remaining_size, datasize);
             return;
        }
    }
}

typedef struct {
    uint8_t        size;
    uint8_t        used;
    Report_Info_t *p_table;
} check_hid_report_t;

static uint8_t _check_hid_report_info_duplicated(Report_Info_t Report_Info1, Report_Info_t Report_Info2)
{
#if 1
    // for airoha usb fw implementation
    uint8_t id1 = Report_Info1 >> 8;
    uint8_t type1 = (uint8_t)Report_Info1;

    uint8_t id2 = Report_Info2 >> 8;
    uint8_t type2 = (uint8_t)Report_Info2;

    if(id1!=id2){
        return 0;
    } else {
        // id is the same
        if(type1==TAG_Input && type2==TAG_Output) {
            return 0;
        } else if(type2==TAG_Input && type1==TAG_Output) {
            return 0;
        } else {
            return 1;
        }
    }
#else
    // follow usb hid spec
    if(Report_Info1!=Report_Info2) {
        return 0;
    } else {
        return 1;
    }
#endif
}

static void _check_hid_report_helper(void* pUserdata, Report_Info_t Report_Info)
{
    uint8_t id = Report_Info >> 8;
    uint8_t type = (uint8_t)Report_Info;

    check_hid_report_t* pRecord = (check_hid_report_t*)pUserdata;
    uint8_t i;
    for(i=0;i<pRecord->used;++i) {

        if( _check_hid_report_info_duplicated(pRecord->p_table[i], Report_Info) ) {

            if(type==TAG_Input) {
                // input
                LOG_MSGID_E(USBHID, "check_hid_report: Warn!   input Report ID(0x%02X) is duplicated(overlapped) ", 1,id);
            } else if(type==TAG_Output) {
                // output
                LOG_MSGID_E(USBHID, "check_hid_report: Warn!  output Report ID(0x%02X) is duplicated(overlapped) ", 1,id);
            } else if(type==TAG_Feature){
                // feature
                LOG_MSGID_E(USBHID, "check_hid_report: Warn! feature Report ID(0x%02X) is duplicated(overlapped) ", 1,id);
            } else {
                // ??
                LOG_MSGID_E(USBHID, "check_hid_report: Warn! ?????   Report ID(0x%02X) is duplicated(overlapped) ", 1,id);
            }

            return;
        }
    }

    if(i<pRecord->size) {
        pRecord->p_table[i] = Report_Info;
        ++pRecord->used;

        if(type==TAG_Input) {
            // input
            LOG_MSGID_I(USBHID, "check_hid_report: found   input Report ID(0x%02X)", 1, id);
        } else if(type==TAG_Output) {
            // output
            LOG_MSGID_I(USBHID, "check_hid_report: found  output Report ID(0x%02X)", 1, id);
        } else if(type==TAG_Feature){
            // feature
            LOG_MSGID_I(USBHID, "check_hid_report: found feature Report ID(0x%02X)", 1, id);
        } else {
            // ??
            LOG_MSGID_I(USBHID, "check_hid_report: found ?????   Report ID(0x%02X)", 1, id);
        }

    } else {

        if(type==TAG_Input) {
            // input
            LOG_MSGID_E(USBHID, "check_hid_report: no room to record input Report ID(0x%02X)", 1, id);
        } else if(type==TAG_Output) {
            // output
            LOG_MSGID_E(USBHID, "check_hid_report: no room to record output Report ID(0x%02X)", 1, id);
        } else if(type==TAG_Feature){
            // feature
            LOG_MSGID_E(USBHID, "check_hid_report: no room to record feature Report ID(0x%02X)", 1, id);
        } else {
            // ??
            LOG_MSGID_E(USBHID, "check_hid_report: no room to record ?????   Report ID(0x%02X)", 1, id);
        }
    }
}

#define USB_HID_CHK_MAXREPORTSIZE 64
void check_hid_report(const uint8_t *pHidReport, uint32_t size)
{
    check_hid_report_t report;
    Report_Info_t buffer[USB_HID_CHK_MAXREPORTSIZE];
    report.size = USB_HID_CHK_MAXREPORTSIZE;
    report.used = 0;
    report.p_table = buffer;

    LOG_MSGID_I(USBHID, "check_hid_report: begin length(%d)", 1, size);

        dump_hid_report(pHidReport, size, _check_hid_report_helper,(void*) &report);

    LOG_MSGID_I(USBHID, "check_hid_report: end", 0);
}


/******************************************************************************
 * Old SDK functions for compatibility
 *****************************************************************************/
void usb_hid_set_dscr_enable(usb_hid_report_dscr_type_t* list, uint8_t len)
{
    /**
     * In old SDK, onlt support one hid device and default on.
     * So there is not port parameter in function parameters.
     * Enable HID device 0 and enable the reports.
     */
    usb_hid_device_enable(USB_HID_DEV_PORT_0_MASK);
    usb_hid_report_enable(USB_HID_DEV_PORT_0, list, len);
}

USB_HID_Status_t USB_HID_TX_SendData(uint8_t *data_buf, uint8_t data_len)
{
    /* This api is replaced by usb_hid_tx_blocking */
    return usb_hid_tx_blocking(USB_HID_DEV_PORT_0, data_buf, data_len, 1000);
}

#endif /* AIR_USB_HID_ENABLE */
