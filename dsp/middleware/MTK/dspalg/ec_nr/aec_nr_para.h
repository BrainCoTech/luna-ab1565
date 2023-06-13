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
#ifndef AEC_NR_PARA_H
#define AEC_NR_PARA_H

#include "dsp_utilities.h"
#include "dsp_para_cpd.h"

typedef struct
{
	// - AEC/NR/AVC
	U16 AEC_NR_EN;		//b0: EC/NR switch, b1-2: 0(1-MIC), 1(1-MIC PD), 2(2-MIC), b3: 0(headset),1(speaker), b4:dereverb 0(disable),1(enable)
	U16 AEC_CNG_GAIN_M;
	U16 AEC_ref_pow_min;		//Q25
	U16 AEC_ECHO_TAIL_LENGTH;
	U16 AEC_EC_RESIST;
	U16 AEC_MU_FAC;
	U16 AEC_MU_MIN;
	U16 AEC_NORM_CAP1;
	U16 AEC_NORM_CAP2;
	U16 AEC_PF_MIN;
	S32 AEC_block_percent;
	U16 AEC_DT_boost;
	U16 AEC_PF_order;
	U16 AEC_DT_ratio_thrd;
	U16 AEC_norm_tap;
	U16 AEC_DT_length;
	U16 MULT_AFTER_EC;
	U16 VOICE_TX_GAIN;
	S16 CH1_REF_GAIN;
	S16 CH2_REF_GAIN;
	S16 CH3_REF_GAIN;
	S16 CH4_REF_GAIN;
	S16 CH1_REF2_GAIN;
	S16 CH2_REF2_GAIN;
	S16 CH3_REF2_GAIN;
	S16 CH4_REF2_GAIN;

//AVC
	U16 AVC_ALPHA;
	U16 AVC_THRD;
	U16 AVC_VOL_MAX;
	U16 DSP_EC_SW;

	//WB_NR_TX
    U16 WB_NR_TX_POW_MIN_BUF_PERIOD;
    U16 WB_NR_TX_NOISE_GAIN_LIMITER;
    U16 WB_NR_TX_VAD_THRD1;
    U16 WB_NR_TX_VAD_THRD_BANDS[5];
    U16 WB_NR_TX_OVER_SUPPRESS_FAC;
    U16 WB_NR_TX_SPEECH_RETAIN_FAC;
    U16 WB_NR_TX_NOISE_LAMDA;
    U16 WB_NR_TX_NOISE_FLOOR_MIN;
    U16 WB_NR_FAST_ALPHA;
    U16 WB_NR_SLOW_ALPHA;
    U16 WB_NR_NOISE_UPDATE_FAST;
    U16 WB_NR_NOISE_UPDATE_SLOW;
    U16 WB_NR_NOISE_UPDATE_ULTRASLOW;
    U16 WB_NR_TX_EMPH_COEF[2];
    //NR_RX
    U16 NB_NR_RX_POW_MIN_BUF_PERIOD;
    U16 NB_NR_RX_NOISE_GAIN_LIMITER;
    U16 NB_NR_RX_VAD_THRD1;
    U16 NB_NR_RX_VAD_THRD_BANDS[4];
    U16 NB_NR_RX_OVER_SUPPRESS_FAC;
    U16 NB_NR_RX_SPEECH_RETAIN_FAC;
    U16 NB_NR_RX_NOISE_LAMDA;
    U16 NB_NR_RX_NOISE_FLOOR_MIN;
    U16 NB_NR_RX_EMPH_COEF[2];
	//WB_NR_RX
	U16 WB_NR_RX_POW_MIN_BUF_PERIOD;
    U16 WB_NR_RX_NOISE_GAIN_LIMITER;
    U16 WB_NR_RX_VAD_THRD1;
	U16 WB_NR_RX_VAD_THRD_BANDS[5];
	U16 WB_NR_RX_OVER_SUPPRESS_FAC;
	U16 WB_NR_RX_SPEECH_RETAIN_FAC;
	U16 WB_NR_RX_NOISE_LAMDA;
	U16 WB_NR_RX_NOISE_FLOOR_MIN;
	U16 WB_NR_RX_EMPH_COEF[2];

//PITCH DETECT
	U16 PD_NR_TX_OPT;
	U16 PD_PEAK_BUF_SIZE;
	U16 PD_PITCH_VAD_THRD;
	U16 PD_PITCH_FAC;
	U16 PD_PEAK_RATIO_FAC;
	U16 PD_TRANSIENT_THRD;
	U16 PD_TRANSIENT_AUG;
	U16 PD_PITCH_AUG;
  U16 PD_TRANSIENT_THRD2;
	U16 PD_RESERVE2;
//2-MIC
	U16 M2_MICDIST;
    U16 M2_WIND_THRD;
    U16 M2_WIND_TRANS;
    U16 M2_WIND_BLOCK;
    U16 M2_FILTER_GRD;
    U16 M2_DISTANCE_FAC;
    U16 M2_VAD_THRD_1;
    U16 M2_VAD_THRD_2;
    U16 M2_VAD_THRD_3;
    U16 M2_VAD_THRD_4;
    U16 M2_VAD_THRD_12;
    U16 M2_VAD_THRD_22;
    U16 M2_VAD_THRD_32;
    U16 M2_VAD_THRD_42;
    U16 M2_VAD_THRD_13;
    U16 M2_VAD_THRD_23;
    U16 M2_VAD_THRD_33;
    U16 M2_VAD_THRD_43;
    U16 M2_NORM_FAC1;
    U16 M2_PHASE_COMB;
    U16 M2_PHASE_GAIN;
    U16 M2_NE_DURATION;

    U16 M2_BEAM1_NORM_LIMIT;
    U16 M2_OVER_SUPPRESS_FAC2;
    S16 M2_BAND1_ALPHA;
    S16 M2_BAND2_ALPHA;
    S16 M2_BAND3_ALPHA;
    S16 M2_BANDH_ALPHA;

//1-mic wind mitigation
  S16 OFF_PITCH_ALPHA;
  S16 WIND_DETECT_THRD;
  S16 PD_WIND_FREQ_RANGE;
  S16 PD_WIND_LOW_ATTEN;
  S16 PD_NONSTATIONARY_ALPHA_1;
  S16 PD_NONSTATIONARY_ALPHA_2;

//2-mic wind mitigation
  S16 M2_PD_HIGH_ATTEN_GOAL;
  S32 M2_PD_SEVERE_NOISE_THRD;
  S16 NR_HIGH_ATTEN_DIVIDE;

//EQ
 	U16 EQ_COF[256];

//VOICE_TX_HP_COEF
	S32 VOICE_TX_HP_COEF[11];

//Voice RX HP
	S32 VOICE_RX_HP_COEF[11];

//HW FFT BUFFER
	S32 *hw_fft_buf;

} PACKED AECNR_PARA_STRU;


typedef struct
{
  U16 RX_EQ_COF[64];
	U16 RX_EQ_GAIN_LEVEL[16];
  U16 TX_EQ_COF[64];
	U16 TX_EQ_GAIN_LEVEL[16];
} NR_EQ_STRU;

typedef struct
{
	U16 AEC_EC_RESIST;
	U16 AEC_PF_MIN;
	U16 AEC_DT_ratio_thrd;
	U16 AEC_DT_length;
	U16 WB_NR_TX_POW_MIN_BUF_PERIOD;
  U16 WB_NR_TX_NOISE_GAIN_LIMITER;
  U16 NR_RX_POW_MIN_BUF_PERIOD;
  U16 NR_RX_NOISE_GAIN_LIMITER;
  U16 WB_NR_RX_POW_MIN_BUF_PERIOD;
  U16 WB_NR_RX_NOISE_GAIN_LIMITER;
  U16 PD_TRANSIENT_THRD;
	U16 PD_TRANSIENT_AUG;
	U16 PD_TRANSIENT_THRD2;
	U16 M2_WIND_THRD;
	U16 M2_WIND_BLOCK;
	U16 M2_DISTANCE_FAC;
  U16 M2_VAD_THRD_1;
  U16 M2_VAD_THRD_2;
  U16 M2_VAD_THRD_3;
  U16 M2_VAD_THRD_4;
} ECNR_CUSTOM_STRU;

#if 0
typedef struct {
	S16 TX_GAIN;
	S16 CPD_VAD;
	S16 avc_vol;
}ECNR_OUT;
#endif

extern AECNR_PARA_STRU *aec_nr_para;

void TX_ECNR_PARA_init(int NB_mode);
void RX_ECNR_PARA_init(int NB_mode);

#ifndef MTK_BT_A2DP_ECNR_USE_PIC
int get_aec_nr_memsize(void);
void Voice_WB_TX_Init(int NB_mode, S16 *bufin, void *p_ecnr_mem_ext, void *p_ecnr_NvKey, void *p_txeq_NvKey);
void NB_RX_NR_init(void *p_ecnr_mem_ext, void *p_ecnr_NvKey, void *p_rxeq_NvKey);
void WB_RX_NR_init(void *p_ecnr_mem_ext, void *p_ecnr_NvKey, void *p_rxeq_NvKey);
#ifdef MTK_INEAR_ENHANCEMENT
void Voice_WB_TX_Inear_Prcs(S16* MIC1, S16* MIC2, S16* REF, S16* NR, ECNR_OUT* PAR, S16 *g_f_wind);
#elif defined(MTK_DUALMIC_INEAR)
void Voice_WB_TX_Inear_Prcs_V2(S16 *MIC1, S16 *MIC2, S16 *MICB, S16 *REF, S16 *NR, ECNR_OUT *PAR);
#else
void Voice_WB_TX_Prcs(S16* MIC1, S16* MIC2, S16* REF, S16* NR, ECNR_OUT* PAR);
#endif
void Voice_NB_RX_Prcs(S16* NR);
void Voice_WB_RX_Prcs(S16* NR);
void EC_REF_GAIN_READBACK(S16 *gain);
void EC_PreLim_Coef_READBACK(S16 *coef);
int TWO_MIC_WB_Write_FLASH(S16 *bufou);
void EQ_update(void *p_ecnr_mem_ext, void *p_rxeq_NvKey);
#endif

#ifdef AIR_ECNR_POST_PART_ENABLE
int get_post_ec_memsize(void);
void EXT_POST_EC_Init(void *pec_handle, void *p_ecnr_NvKey);
void EXT_POST_EC_PRCS(void *pec_handle, S16* NR_out, S16 *out, U8 PEC_GAIN, ECNR_OUT *PAR);
#endif

#endif
