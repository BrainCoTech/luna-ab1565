/* Copyright Statement:
 *
 * (C) 2017  Airoha Technology Corp. All rights reserved.
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

#include "config.h"
#include "dsp_task.h"
#include "dsp_interface.h"
#include "dsp_memory.h"
#include "transform.h"
#include "audio_config.h"
#include "stream_audio.h"
#include "stream.h"
#include "ddchst.h"
#include "dsp_feature_interface.h"
#include "dsp_update_para.h"



/******************************************************************************
 * Function Declaration
 ******************************************************************************/
VOID                DSP_DCHS_Task(VOID);
VOID                DDCHST_DefaultEntry(VOID);
VOID                DDCHST_TestEntry(VOID);
VOID                DDCHST_StartEntry(VOID);
VOID                DDCHST_ProcessEntry(VOID);
VOID                DDCHSPT_DeInitEntry(VOID);
#if DspIpcEnable
VOID                DDCHST_CmdHdlr(DSP_CMD_PTR_t DspCmdPtr);
#endif
VOID                DDCHST_Init(VOID);
VOID                DDCHST_DeInit(VOID *para);
STATIC INLINE VOID  DDCHST_Process(VOID);
VOID                DDCHST_StreamingInit(VOID);
BOOL                DDCHST_ChkCallbackStatus(VOID);
BOOL                DDCHST_ChkCallbackStatusDisable(VOID);
VOID                DDCHST_SuspendRequest(VOID *para);



/******************************************************************************
 * External Function Prototypes
 ******************************************************************************/


/******************************************************************************
 * Type Definitions
 ******************************************************************************/
#if  DspIpcEnable
typedef VOID (*DDCHST_CMD_HDLR)(DSP_CMD_PTR_t DspCmdPtr);
#endif
typedef VOID (*DDCHST_ENTRY)(VOID);


/******************************************************************************
 * Constants
 ******************************************************************************/
#define NO_OF_DCHS_TASK_HANDLER (sizeof(DspDCHSTaskHdlr)/sizeof(DspDCHSTaskHdlr[0]))

#ifdef AIR_MULTI_MIC_STREAM_ENABLE
#define NO_OF_DCHS_STREAM         4
#else
#define NO_OF_DCHS_STREAM         1
#endif

#if  DspIpcEnable
DDCHST_CMD_HDLR CODE DspDCHSTaskHdlr[] = {
    NULL,
};
#endif
/******************************************************************************
 * Variables
 ******************************************************************************/
STATIC DDCHST_ENTRY DDCHST_Entry;

DSP_STREAMING_PARA DCHSStreaming[NO_OF_DCHS_STREAM];


/**
 * DSP_DCHS_Task
 *
 * Main Process for DSP DCHS task application
 *
 */
VOID DSP_DCHS_Task(VOID)
{
#if  DspIpcEnable
    DSP_CMD_PTR_t DspCmdPtr;
#endif
    /* Do Initialization */
    DDCHST_Init();

    //DAVT_3wire();
    while (1) {
#if  DspIpcEnable
        if ((DspCmdPtr = osTaskGetIPCMsg()) != NULL) {
            DDCHST_CmdHdlr(DspCmdPtr);
        }
#endif
        DDCHST_Entry();

        DDCHST_SuspendRequest(NULL);

        portYIELD();
    }
}

/**
 * DDCHST_DefaultEntry
 *
 * Default Entry for DDCHST
 *
 */
VOID DDCHST_DefaultEntry(VOID)
{
    if (!DDCHST_ChkCallbackStatusDisable()) {
        DDCHST_Entry = DDCHST_ProcessEntry;
    }
}


/**
 * DDCHST_TestEntry
 *
 * Test Entry for DDCHST
 *
 */
VOID DDCHST_TestEntry(VOID)
{
    return;
}

/**
 * DDCHST_StartEntry
 *
 * Start Entry for DDCHST
 *
 */
VOID DDCHST_StartEntry(VOID)
{
    DDCHST_Process();
    if (DDCHST_ChkCallbackStatus()) {
        DDCHST_Entry = DDCHST_ProcessEntry;
    }

}


/**
 * DDCHST_ProcessEntry
 *
 * Active Entry for DDCHST background process
 *
 *
 */
VOID DDCHST_ProcessEntry(VOID)
{
#if 0
    if (DDCHST_ChkCallbackStatusDisable()) {
        DDCHST_Entry = DDCHST_DeInitEntry;
    } else
#endif
        DDCHST_Process();
}

/**
 * DDCHST_DeInitEntry
 *
 * Initialization Entry for DDCHST
 *
 */
VOID DDCHST_DeInitEntry(VOID)
{
    PL_CRITICAL(DDCHST_DeInit, NULL);
}

#if  DspIpcEnable

/**
 * DDCHST_CmdHdlr
 *
 * DDCHST Command Handler handles all Commands towards DDCHST task.
 *
 */
VOID DDCHST_CmdHdlr(DSP_CMD_PTR_t DspCmdPtr)
{
    DSP_CMD_MSG_t DspMsg = DspCmdPtr->DspMsg;
    switch (DspMsg) {
        case DSP_MSG_START_LINE:
            DDCHST_Entry = DDCHST_TestEntry;
            break;
        case DSP_UPDATE_PARAMETER:
            DSP_UpdateStreamingPara(&DspCmdPtr->DspCmdPara.UpdatePara);
            break;
        default:
            break;
    }

    OSMEM_Put(DspCmdPtr);
}
#endif
/**
 * DDCHST_Init
 *
 * Initialization for DSP_DCHS_Task
 *
 */
VOID DDCHST_Init(VOID)
{
    DSPMEM_Init(DDCHS_TASK_ID);
    DDCHST_Entry = DDCHST_DefaultEntry;
    DSP_Callback_StreamingInit(&DCHSStreaming[0], NO_OF_DCHS_STREAM, DDCHS_TASK_ID);
}

/**
 * DDCHST_DeInit
 *
 * De-Initialization for DCHST
 *
 */
VOID DDCHST_DeInit(VOID *para)
{
    UNUSED(para);
    DSPMEM_Flush(DDCHS_TASK_ID);
    DSP_Callback_StreamingInit(&DCHSStreaming[0], NO_OF_DCHS_STREAM, DDCHS_TASK_ID);
    DDCHST_Entry = DDCHST_DefaultEntry;
}


/**
 * DDCHST_Process
 *
 * DDCHST background process
 *
 *
 */
STATIC INLINE VOID DDCHST_Process(VOID)
{
    U8 i;
    uint32_t start_time, end_time;
    for (i = 0 ; i < NO_OF_DCHS_STREAM ; i++) {
        hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &start_time);
        if (DCHSStreaming[i].streamingStatus == STREAMING_END) {
            StreamCloseAll(DCHSStreaming[i].source->transform, InstantCloseMode);
        } else {
            DSP_Callback_Processing(&DCHSStreaming[i]);
        }
        hal_gpt_get_free_run_count(HAL_GPT_CLOCK_SOURCE_1M, &end_time);
        if ((uint32_t)(end_time - start_time) > DDCHS_TASK_MAX_RUNTIME) {
            DSP_MW_LOG_W("[DDCHS_TASK] task process time:%d us", 1, (uint32_t)(end_time - start_time));
        }
    }
}


/**
 * DDCHST_StreamingConfig
 *
 * Configuration for DSP_DCHS_Task streaming
 *
 */
TaskHandle_t  DDCHST_StreamingConfig(DSP_CALLBACK_STREAM_CONFIG_PTR stream_config_ptr)
{
    DSP_MW_LOG_I("enter DDCHST_StreamingConfig", 0);
    stream_config_ptr->stream_ptr = (DSP_STREAMING_PARA_PTR)&DCHSStreaming[0];
    stream_config_ptr->stream_number = NO_OF_DCHS_STREAM;
    stream_config_ptr->task = DDCHS_TASK_ID;
    return DSP_Callback_StreamConfig(stream_config_ptr);
}

/**
 * DDCHST_Callback_Get
 *
 * Get DSP_DCHS_Task callback ptr
 *
 */
DSP_CALLBACK_PTR DDCHST_Callback_Get(SOURCE source, SINK sink)
{
    U8 i;
    for (i = 0 ; i < NO_OF_DCHS_STREAM ; i++) {
        if ((DCHSStreaming[i].streamingStatus != STREAMING_DISABLE) &&
            (DCHSStreaming[i].source == source) &&
            (DCHSStreaming[i].sink == sink)) {
            return &DCHSStreaming[i].callback;
        }
    }
    return NULL;
}

/**
 * DDCHST_ChkCallbackStatus
 *
 * Whether all DSP_DCHS_Task callback status SUSPEND/DISABLE
 *
 */
ATTR_TEXT_IN_RAM_FOR_MASK_IRQ BOOL DDCHST_ChkCallbackStatus(VOID)
{
    U8 i;
    for (i = 0 ; i < NO_OF_DCHS_STREAM ; i++) {
        if (((DCHSStreaming[i].callback.Status != CALLBACK_SUSPEND) &&
             (DCHSStreaming[i].callback.Status != CALLBACK_DISABLE) &&
             (DCHSStreaming[i].callback.Status != CALLBACK_WAITEND)) ||
            (DCHSStreaming[i].streamingStatus == STREAMING_END)) {
            return FALSE;
        }
    }
    return TRUE;
}

/**
 * DDCHST_ChkCallbackStatusDisable
 *
 * Whether all DSP_DCHS_Task callback status DISABLE
 *
 */
BOOL DDCHST_ChkCallbackStatusDisable(VOID)
{
    U8 i;
    for (i = 0 ; i < NO_OF_DCHS_STREAM ; i++) {
        if (DCHSStreaming[i].callback.Status != CALLBACK_DISABLE) {
            return FALSE;
        }
    }
    return TRUE;
}

/**
 * DDCHST_SuspendRequest
 *
 * DDCHST Suspend Request depend on callback status
 *
 */
ATTR_TEXT_IN_RAM_FOR_MASK_IRQ VOID DDCHST_SuspendRequest(VOID *para)
{
    UNUSED(para);
    U32 mask;
    hal_nvic_save_and_set_interrupt_mask(&mask);
    if ((DDCHST_Entry != DDCHST_StartEntry) && (DDCHST_Entry != DDCHST_DeInitEntry) &&
        DDCHST_ChkCallbackStatus()) {
        hal_nvic_restore_interrupt_mask(mask);
        vTaskSuspend(DDCHS_TASK_ID);
        return;
    }
    hal_nvic_restore_interrupt_mask(mask);
}


