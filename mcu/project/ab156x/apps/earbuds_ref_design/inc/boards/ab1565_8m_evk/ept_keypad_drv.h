/*
 * Generated by Airoha Easy PinMux Tool Version 2.9.6 for AB1565. Copyright Airoha Inc. (C) 2015.
 * 2022-12-14 20:13:52:0823
 * Do Not Modify the File.
 */

/*****************************************************************************
*
* Filename:
* ---------
*    ***.*
*
* Project:
* --------
*
* Description:
* ------------
*
* Author:
* -------
*
*============================================================================
****************************************************************************/

#ifndef  _EPT_KEYPAD_DRV_H
#define  _EPT_KEYPAD_DRV_H


#define  __EPT_CAPTOUCH_KEY__

#if defined(__EPT_CAPTOUCH_KEY__)
#define KEYPAD_MAPPING \
DEVICE_KEY_A, \
DEVICE_KEY_B, \
DEVICE_KEY_NONE, \
DEVICE_KEY_NONE 
#endif

#define POWERKEY_POSITION DEVICE_KEY_POWER

#define DRV_KBD_CAPTOUCH_SEL 0x3


#endif /* _EPT_KEYPAD_DRV_H */
