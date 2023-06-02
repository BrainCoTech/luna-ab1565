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
#ifndef _NVKEY_DSPALG_H_
#define _NVKEY_DSPALG_H_

#include "types.h"
#include "nvkey_id_list.h"

typedef enum {
    NVKEY_DSP_PARA_RESERVED         = NVID_DSP_ALG_RESERVED_PARA,
    NVKEY_DSP_PARA_RESERVED_1       = NVID_DSP_ALG_RESERVED_PARA_1,
    NVKEY_DSP_PARA_VO_CPD_BASE      = NVID_DSP_ALG_CPD_WB_TX_VO,
    NVKEY_DSP_PARA_SWB_TX_VO_CPD     = NVID_DSP_ALG_CPD_SWB_TX_VO,
    NVKEY_DSP_PARA_WB_TX_VO_CPD     = NVID_DSP_ALG_CPD_WB_TX_VO,
    NVKEY_DSP_PARA_NB_TX_VO_CPD     = NVID_DSP_ALG_CPD_NB_TX_VO,
    NVKEY_DSP_PARA_SWB_RX_VO_CPD     = NVID_DSP_ALG_CPD_SWB_RX_VO,
    NVKEY_DSP_PARA_WB_RX_VO_CPD     = NVID_DSP_ALG_CPD_WB_RX_VO,
    NVKEY_DSP_PARA_NB_RX_VO_CPD     = NVID_DSP_ALG_CPD_NB_RX_VO,
    NVKEY_DSP_PARA_VP_CPD           = 0xE580,  //maybe no use
    NVKEY_DSP_PARA_A2DP_AU_CPD      = NVID_DSP_ALG_CPD_A2DP_AU,  //0xE106 -> 0xE441
    NVKEY_DSP_PARA_LINE_AU_CPD      = NVID_DSP_ALG_CPD_LINE_AU,  //0xE107 -> 0xE500
    NVKEY_DSP_PARA_MIC_AU_CPD       = NVID_DSP_ALG_CPD_MIC_AU,  //0xE501
    NVKEY_DSP_PARA_ADVANCED_RECORD_AU_CPD      = NVID_DSP_ALG_CPD_ADVANCED_RECORD_AU,  //0xE502
    NVKEY_DSP_PARA_MIX_AU_CPD       = NVID_DSP_ALG_CPD_MIX_AU,  //0xE503
    NVKEY_DSP_PARA_POSITIVE_GAIN    = NVID_DSP_ALG_POSITIVE_GAIN,  //0xE109 -> 0xE4C0
    NVKEY_DSP_PARA_INS              = NVID_DSP_ALG_INS,            //0xE110 -> 0xE4C1
    NVKEY_DSP_PARA_POSITIVE_GAIN_2ND = NVID_DSP_ALG_POSITIVE_GAIN_2ND,
    NVKEY_DSP_PARA_VC               = 0xE130,  //maybe no use
    NVKEY_DSP_PARA_PLC              = NVID_DSP_ALG_PLC,
    NVKEY_DSP_PARA_AEC_NR           = NVID_DSP_ALG_AEC_NR,
    NVKEY_DSP_PARA_AEC_NR_SWB       = NVID_DSP_ALG_AEC_NR_SWB,
    NVKEY_DSP_PARA_AEC              = NVID_DSP_ALG_AEC,
    NVKEY_DSP_PARA_NR               = NVID_DSP_ALG_NR,
    NVKEY_DSP_PARA_INEAR            = NVID_DSP_ALG_INEAR,
    NVKEY_DSP_PARA_WB_RX_EQ         = NVID_DSP_ALG_EQ_WB_RX,
    NVKEY_DSP_PARA_WB_TX_EQ         = NVID_DSP_ALG_EQ_WB_TX,
    NVKEY_DSP_PARA_NB_RX_EQ         = NVID_DSP_ALG_EQ_NB_RX,
    NVKEY_DSP_PARA_NB_TX_EQ         = NVID_DSP_ALG_EQ_NB_TX,
    NVKEY_DSP_PARA_WB_RX_EQ_2ND     = NVID_DSP_ALG_EQ_WB_RX_2ND,
    NVKEY_DSP_PARA_NB_RX_EQ_2ND     = NVID_DSP_ALG_EQ_NB_RX_2ND,
    NVKEY_DSP_PARA_INEAR_EQ         = NVID_DSP_ALG_EQ_INEAR,
    NVKEY_DSP_PARA_AST_EQ           = NVID_DSP_ALG_EQ_AST,
    NVKEY_DSP_PARA_WB_TX_FIR_EQ     = NVID_DSP_ALG_EQ_WB_TX_FIR,
    NVKEY_DSP_PARA_NB_TX_FIR_EQ     = NVID_DSP_ALG_EQ_NB_TX_FIR,
    NVKEY_DSP_PARA_SWB_RX_EQ        = NVID_DSP_ALG_EQ_SWB_RX,
    NVKEY_DSP_PARA_SWB_TX_EQ        = NVID_DSP_ALG_EQ_SWB_TX,
    NVKEY_DSP_PARA_SWB_RX_EQ_2ND    = NVID_DSP_ALG_EQ_SWB_RX_2ND,
    NVKEY_DSP_PARA_WB_TX_PRE_EQ       = NVID_DSP_ALG_EQ_WB_TX_PRE,
    NVKEY_DSP_PARA_LEAKAGE_COMPENSATION    = NVID_DSP_ALG_ANC_LKGE_COMP,  //0xE18E -> 0xE700
    NVKEY_DSP_PARA_ADAPTIVE_FF_SZ_COEF     = 0xE18F,  //New edit, Need add intto nvkey maintain
    NVKEY_DSP_PARA_VOICE_WB_RX_AGC  = NVID_DSP_ALG_AGC_WB_RX,
    NVKEY_DSP_PARA_VOICE_NB_RX_AGC  = NVID_DSP_ALG_AGC_NB_RX,
    NVKEY_DSP_PARA_VOICE_TX_AGC     = NVID_DSP_ALG_AGC_TX,
    NVKEY_DSP_PARA_AEC_NR_BOOMIC = NVID_DSP_ALG_AEC_NR_BOOMIC,
    NVKEY_DSP_PARA_AEC_BOOMIC = NVID_DSP_ALG_AEC_BOOMIC,
    NVKEY_DSP_PARA_NR_BOOMIC = NVID_DSP_ALG_NR_BOOMIC,
    NVKEY_DSP_PARA_INEAR_BOOMIC = NVID_DSP_ALG_INEAR_BOOMIC,
    NVKEY_DSP_PARA_AEC_NR_SWB_BOOMIC = NVID_DSP_ALG_AEC_NR_SWB_BOOMIC,
    NVKEY_DSP_PARA_NB_TX_EQ_BOOMIC = NVID_DSP_ALG_EQ_NB_TX_BOOMIC,
    NVKEY_DSP_PARA_WB_TX_EQ_BOOMIC = NVID_DSP_ALG_EQ_WB_TX_BOOMIC,
    NVKEY_DSP_PARA_SWB_TX_EQ_BOOMIC = NVID_DSP_ALG_EQ_SWB_TX_BOOMIC,
    NVKEY_DSP_PARA_VOICE_SWB_RX_AGC  = NVID_DSP_ALG_AGC_SWB_RX,
    NVKEY_DSP_PARA_NB_TX_VO_CPD_BOOMIC = NVID_DSP_ALG_CPD_NB_TX_VO_BOOMIC,
    NVKEY_DSP_PARA_WB_TX_VO_CPD_BOOMIC = NVID_DSP_ALG_CPD_WB_TX_VO_BOOMIC,
    NVKEY_DSP_PARA_SWB_TX_VO_CPD_BOOMIC = NVID_DSP_ALG_CPD_SWB_TX_VO_BOOMIC,
    NVKEY_DSP_PARA_NB_TX_FIR_EQ_BOOMIC = NVID_DSP_ALG_EQ_NB_TX_FIR_BOOMIC,
    NVKEY_DSP_PARA_WB_TX_FIR_EQ_BOOMIC = NVID_DSP_ALG_EQ_WB_TX_FIR_BOOMIC,
    NVKEY_DSP_PARA_SWB_TX_FIR_EQ_BOOMIC = NVID_DSP_ALG_EQ_SWB_TX_FIR_BOOMIC,
    NVKEY_DSP_PARA_ADAPTIVE_FF             = NVID_DSP_ALG_ANC_ADAPTIVE_FF,  //New edit, Need add intto nvkey maintain
    NVKEY_DSP_PARA_ADAPTIVE_FF_KEEP_FILTER = NVID_DSP_ALG_ANC_ADAPTIVE_FF_KEEP_FILTER,  //New edit, Need add intto nvkey maintain
    NVKEY_DSP_PARA_ADAPTIVE_ANC_SETTING    = NVID_DSP_ALG_ANC_ADAPTIVE_SETTING,  //New edit, Need add intto nvkey maintain
/*ANC V2*/
    NVKEY_DSP_PARA_ANC_L_FILTER_1   = NVID_DSP_ALG_ANC_L_FILTER_1,
    NVKEY_DSP_PARA_ANC_R_FILTER_1   = NVID_DSP_ALG_ANC_R_FILTER_1,
    NVKEY_DSP_PARA_ANC_L_FILTER_2   = NVID_DSP_ALG_ANC_L_FILTER_2,
    NVKEY_DSP_PARA_ANC_R_FILTER_2   = NVID_DSP_ALG_ANC_R_FILTER_2,
    NVKEY_DSP_PARA_ANC_L_FILTER_3   = NVID_DSP_ALG_ANC_L_FILTER_3,
    NVKEY_DSP_PARA_ANC_R_FILTER_3   = NVID_DSP_ALG_ANC_R_FILTER_3,
    NVKEY_DSP_PARA_ANC_L_FILTER_4   = NVID_DSP_ALG_ANC_L_FILTER_4,
    NVKEY_DSP_PARA_ANC_R_FILTER_4   = NVID_DSP_ALG_ANC_R_FILTER_4,

    NVKEY_DSP_PARA_ANC_PATH_SETTING = NVID_DSP_ALG_ANC_PATH_SETTING,

    NVKEY_DSP_PARA_PASSTHRU_L_FILTER_1   = NVID_DSP_ALG_PT_L_FILTER_1,
    NVKEY_DSP_PARA_PASSTHRU_R_FILTER_1   = NVID_DSP_ALG_PT_R_FILTER_1,
    NVKEY_DSP_PARA_PASSTHRU_L_FILTER_2   = NVID_DSP_ALG_PT_L_FILTER_2,
    NVKEY_DSP_PARA_PASSTHRU_R_FILTER_2   = NVID_DSP_ALG_PT_R_FILTER_2,
    NVKEY_DSP_PARA_PASSTHRU_L_FILTER_3   = NVID_DSP_ALG_PT_L_FILTER_3,
    NVKEY_DSP_PARA_PASSTHRU_R_FILTER_3   = NVID_DSP_ALG_PT_R_FILTER_3,
    NVKEY_DSP_PARA_PT_HYBRID_L_FILTER_1  = NVID_DSP_ALG_PT_HYBRID_L_FILTER_1,
    NVKEY_DSP_PARA_PT_HYBRID_R_FILTER_1  = NVID_DSP_ALG_PT_HYBRID_R_FILTER_1,
    NVKEY_DSP_PARA_PT_HYBRID_L_FILTER_2  = NVID_DSP_ALG_PT_HYBRID_L_FILTER_2,
    NVKEY_DSP_PARA_PT_HYBRID_R_FILTER_2  = NVID_DSP_ALG_PT_HYBRID_R_FILTER_2,
    NVKEY_DSP_PARA_PT_HYBRID_L_FILTER_3  = NVID_DSP_ALG_PT_HYBRID_L_FILTER_3,
    NVKEY_DSP_PARA_PT_HYBRID_R_FILTER_3  = NVID_DSP_ALG_PT_HYBRID_R_FILTER_3,
    NVKEY_DSP_PARA_ANC_CURRENT_STATUS    = NVID_DSP_ALG_ANC_CUR_STATUS,
    NVKEY_DSP_PARA_ANC_SETTING           = NVID_DSP_ALG_ANC_SETTING,
    NVKEY_DSP_PARA_PASSTHRU_SETTING      = NVID_DSP_ALG_PT_SETTING,
    NVKEY_DSP_PARA_ANC_POWER_DETECT      = NVID_DSP_ALG_ANC_PWR_DET,
    NVKEY_DSP_PARA_PASSTHRU_POWER_DETECT = NVID_DSP_ALG_PT_PWR_DET,
    NVKEY_DSP_PARA_ANC_CALIBRATE_GAIN    = NVID_DSP_ALG_ANC_CAL_GAIN,
    NVKEY_DSP_PARA_ANC_DEFAULT_STATUS    = NVID_DSP_ALG_ANC_DEF_STATUS,
    NVKEY_DSP_PARA_PT_HYBRID_SETTING     = NVID_DSP_ALG_PT_HYBRID_SETTING,

    NVKEY_DSP_PARA_ANC_SETTING_CUSTOMIZED_1  = NVID_DSP_ALG_ANC_SETTING_CUSTOMIZED_1,  //New edit, Need add intto nvkey maintain
    NVKEY_DSP_PARA_ANC_SETTING_CUSTOMIZED_2  = NVID_DSP_ALG_ANC_SETTING_CUSTOMIZED_2,  //New edit, Need add intto nvkey maintain
    NVKEY_DSP_PARA_ANC_SETTING_CUSTOMIZED_3  = NVID_DSP_ALG_ANC_SETTING_CUSTOMIZED_3,  //New edit, Need add intto nvkey maintain

    NVKEY_DSP_PARA_ANC_MULTI_FEATURE     = NVID_DSP_ALG_ANC_MULTI_FEATURE,
    NVKEY_DSP_PARA_ANC_SPECI_SW_FL       = NVID_DSP_ALG_ANC_SPECI_SW_FL,

    NVKEY_DSP_PARA_ADVANCED_PASSTHROUGH_PRE_PEQ_1 = NVID_DSP_ALG_PSAP_PRE_PEQ_1,
    NVKEY_DSP_PARA_ADVANCED_PASSTHROUGH_PRE_PEQ_2 = NVID_DSP_ALG_PSAP_PRE_PEQ_2,
    NVKEY_DSP_PARA_ADVANCED_PASSTHROUGH_PRE_PEQ_3 = NVID_DSP_ALG_PSAP_PRE_PEQ_3,
    NVKEY_DSP_PARA_ADVANCED_PASSTHROUGH_PRE_PEQ_4 = NVID_DSP_ALG_PSAP_PRE_PEQ_4,
    NVKEY_DSP_PARA_ADVANCED_PASSTHROUGH_PRE_PEQ_TABLE = NVID_DSP_ALG_PSAP_PRE_PEQ_TABLE,

    NVKEY_DSP_PARA_WIND_DETECT                    = NVID_DSP_ALG_ANC_WIND_DET,
    NVKEY_DSP_PARA_USER_UNAWARE                   = NVID_DSP_ALG_ANC_USR_UNAWARE,
    NVKEY_DSP_PARA_ENVIRONMENT_DETECTION          = NVID_DSP_ALG_ANC_ENVIRONMENT_DETECTION,
    NVKEY_DSP_PARA_WIND_DETECT_PT                 = NVID_DSP_ALG_ANC_WIND_DET_PT,
    NVKEY_DSP_PARA_WIND_DETECT_SIDETONE           = NVID_DSP_ALG_ANC_WIND_DET_SIDETONE,
    NVKEY_DSP_PARA_ENVIRONMENT_DETECTION_PT       = NVID_DSP_ALG_ANC_ENVIRONMENT_DETECTION_PT,
    NVKEY_DSP_PARA_ENVIRONMENT_DETECTION_SIDETONE = NVID_DSP_ALG_ANC_ENVIRONMENT_DETECTION_SIDETONE,
    /*================*/

    NVKEY_DSP_PARA_PEQ_MISC_PARA    = NVID_DSP_ALG_PEQ_MISC_PARA,  //0xF232 -> 0xE400
    NVKEY_DSP_PARA_PEQ              = NVID_DSP_ALG_PEQ_PATH_TB,    //0xF233 -> 0xE401
    NVKEY_DSP_PARA_PEQ_PATH_0       = NVID_DSP_ALG_PEQ_GP_TB_1,    //0xF234 -> 0xE402
    NVKEY_DSP_PARA_PEQ_PATH_1       = NVID_DSP_ALG_PEQ_GP_TB_2,    //0xF235 -> 0xE403
    NVKEY_DSP_PARA_PEQ_PATH_2       = NVID_DSP_ALG_PEQ_GP_TB_3,    //0xF236 -> 0xE404
    NVKEY_DSP_PARA_PEQ_PATH_3       = NVID_DSP_ALG_PEQ_GP_TB_4,    //0xF237 -> 0xE405
    NVKEY_DSP_PARA_PEQ_PATH_4       = NVID_DSP_ALG_PEQ_GP_TB_5,    //0xF238 -> 0xE406
    NVKEY_DSP_PARA_PEQ_PATH_5       = NVID_DSP_ALG_PEQ_GP_TB_6,    //0xF239 -> 0xE407
    NVKEY_DSP_PARA_AEQ_PATH         = NVID_DSP_ALG_AEQ_GP_TB,      //0xE408
    NVKEY_DSP_PARA_MIC_PEQ_PATH     = NVID_DSP_ALG_MIC_PEQ_GP_TB,  //0xE442
    NVKEY_DSP_PARA_ADVANCED_RECORD_PEQ_PATH     = NVID_DSP_ALG_ADVANCED_RECORD_PEQ_GP_TB,//0xE443
    NVKEY_DSP_PARA_PEQ_COEF_01      = NVID_DSP_ALG_PEQ_COF_1,      //0xF260 -> 0xE410
    NVKEY_DSP_PARA_PEQ_COEF_26      = NVID_DSP_ALG_PEQ_COF_26,     //0xF279 -> 0xE429
    NVKEY_DSP_PARA_PEQ_COEF_29      = NVID_DSP_ALG_PEQ_COF_29,     //0xF27C -> 0xE42C
    NVKEY_DSP_PARA_PEQ_COEF_32      = NVID_DSP_ALG_PEQ_COF_32,     //0xF27F -> 0xE42F
    NVKEY_DSP_PARA_AEQ_COEF_1      = NVID_DSP_ALG_AEQ_COF_1,     //0xE430
    NVKEY_DSP_PARA_AEQ_COEF_7      = NVID_DSP_ALG_AEQ_COF_7,     //0xE436
    NVKEY_DSP_PARA_AEQ_PARA         = NVID_DSP_ALG_AEQ_PARA,     //0xE437
    NVKEY_DSP_PARA_AEQ_SZ_1         = NVID_DSP_ALG_AEQ_PARA_SZ_1,     //0xE438
    NVKEY_DSP_PARA_AEQ_SZ_2         = NVID_DSP_ALG_AEQ_PARA_SZ_2,     //0xE439
    NVKEY_DSP_PARA_AEQ_SZ_3         = NVID_DSP_ALG_AEQ_PARA_SZ_3,     //0xE43A
    NVKEY_DSP_PARA_AEQ_SZ_4         = NVID_DSP_ALG_AEQ_PARA_SZ_4,     //0xE43B
    NVKEY_DSP_PARA_AEQ_SZ_5         = NVID_DSP_ALG_AEQ_PARA_SZ_5,     //0xE43C
    NVKEY_DSP_PARA_AEQ_SZ_6         = NVID_DSP_ALG_AEQ_PARA_SZ_6,     //0xE43D
    NVKEY_DSP_PARA_AEQ_SZ_7         = NVID_DSP_ALG_AEQ_PARA_SZ_7,     //0xE43E

    NVKEY_PEQ_UI_DATA_01            = 0xEF00,  //Need check
    NVKEY_PEQ_UI_DATA_04            = 0xEF03,  //Need check
    NVKEY_DSP_PARA_VAD_COMMON       = NVID_DSP_ALG_VAD_CMN_PARA,   //0xE172 -> 0xE680
    NVKEY_DSP_PARA_VAD_1MIC_V_MODE  = NVID_DSP_ALG_VAD_1MIC_V,     //0xE175 -> 0xE690
    NVKEY_DSP_PARA_VAD_1MIC_C_MODE  = NVID_DSP_ALG_VAD_1MIC_C,     //0xE176 -> 0xE691
    NVKEY_DSP_PARA_VAD_2MIC_V_MODE  = NVID_DSP_ALG_VAD_2MIC_V,     //0xE177 -> 0xE692
    NVKEY_DSP_PARA_VAD_2MIC_C_MODE  = NVID_DSP_ALG_VAD_2MIC_C,     //0xE178 -> 0xE693

    NVKEY_DSP_PARA_AFC              = NVID_DSP_ALG_AFC,            //0xF504 -> 0xE3A0
    NVKEY_DSP_PARA_LD_NR_MISC       = NVID_DSP_ALG_LD_NR_MISC,     //0xF505 -> 0xE3A1
    NVKEY_DSP_PARA_LD_NR_PARAMETER1 = NVID_DSP_ALG_LD_NR_PARA1,    //0xF506 -> 0xE3A2
    NVKEY_DSP_PARA_LD_NR_PARAMETER2 = NVID_DSP_ALG_LD_NR_PARA2,    //0xF507 -> 0xE3A3
    NVKEY_DSP_PARA_AT_AGC           = NVID_DSP_ALG_AT_AGC,         //0xF508 -> 0xE3A4
    NVKEY_DSP_PARA_AT_AGC_DRC       = NVID_DSP_ALG_AT_AGC_DRC,     //0xF509 -> 0xE3A5
    NVKEY_DSP_PARA_ADVANCED_PASSTHROUGH_MISC = NVID_DSP_ALG_PSAP_MISC,
    NVKEY_DSP_PARA_ADVANCED_PASSTHROUGH_SPEACIL_PEQ = 0xF50B,
    NVKEY_DSP_PARA_GAME_CHAT_VOLUME_SMART_BALANCE = NVID_DSP_ALG_GC_VOL_SMART_BAL,
    NVKEY_DSP_PARA_SILENCE_DETECTION = 0xF50D,
    NVKEY_DSP_PARA_SILENCE_DETECTION2 = NVID_DSP_ALG_SIL_DET2,

    NVKEY_DSP_PARA_MIC1_LD_NR_MISC       = NVID_DSP_ALG_MIC1_LD_NR_MISC,
    NVKEY_DSP_PARA_MIC1_LD_NR_PARAMETER1 = NVID_DSP_ALG_MIC1_LD_NR_PARA1,
    NVKEY_DSP_PARA_MIC1_LD_NR_PARAMETER2 = NVID_DSP_ALG_MIC1_LD_NR_PARA2,
    NVKEY_DSP_PARA_MIC2_LD_NR_MISC       = NVID_DSP_ALG_MIC2_LD_NR_MISC,
    NVKEY_DSP_PARA_MIC2_LD_NR_PARAMETER1 = NVID_DSP_ALG_MIC2_LD_NR_PARA1,
    NVKEY_DSP_PARA_MIC2_LD_NR_PARAMETER2 = NVID_DSP_ALG_MIC2_LD_NR_PARA2,

    NVKEY_DSP_PARA_MIC_EQ_COEF_1 = NVID_DSP_ALG_MIC_EQ_COF_1,
    NVKEY_DSP_PARA_MIC_EQ_COEF_5 = NVID_DSP_ALG_MIC_EQ_COF_5,
} DSP_ALG_NVKEY_e;

#endif /* _NVKEY_DSPALG_H_ */
