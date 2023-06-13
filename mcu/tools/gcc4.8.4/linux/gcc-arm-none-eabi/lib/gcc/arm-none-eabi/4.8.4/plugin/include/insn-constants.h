/* Generated automatically by the program `genconstants'
   from the machine description file `md'.  */

#ifndef GCC_INSN_CONSTANTS_H
#define GCC_INSN_CONSTANTS_H

#define CMP_CMP 0
#define DOM_CC_NX_OR_Y 1
#define DOM_CC_X_OR_Y 2
#define CC_REGNUM 100
#define WCGR3 46
#define SP_REGNUM 13
#define R1_REGNUM 1
#define PC_REGNUM 15
#define WCGR0 43
#define VFPCC_REGNUM 101
#define CMP_CMN 2
#define NUM_OF_COND_CMP 4
#define WCGR2 45
#define R0_REGNUM 0
#define WCGR1 44
#define CMN_CMP 1
#define LR_REGNUM 14
#define DOM_CC_X_AND_Y 0
#define CMN_CMN 3
#define IP_REGNUM 12
#define LAST_ARM_REGNUM 15

enum unspec {
  UNSPEC_PUSH_MULT = 0,
  UNSPEC_PIC_SYM = 1,
  UNSPEC_PIC_BASE = 2,
  UNSPEC_PRLG_STK = 3,
  UNSPEC_REGISTER_USE = 4,
  UNSPEC_CHECK_ARCH = 5,
  UNSPEC_WSHUFH = 6,
  UNSPEC_WACC = 7,
  UNSPEC_TMOVMSK = 8,
  UNSPEC_WSAD = 9,
  UNSPEC_WSADZ = 10,
  UNSPEC_WMACS = 11,
  UNSPEC_WMACU = 12,
  UNSPEC_WMACSZ = 13,
  UNSPEC_WMACUZ = 14,
  UNSPEC_CLRDI = 15,
  UNSPEC_WALIGNI = 16,
  UNSPEC_TLS = 17,
  UNSPEC_PIC_LABEL = 18,
  UNSPEC_PIC_OFFSET = 19,
  UNSPEC_GOTSYM_OFF = 20,
  UNSPEC_THUMB1_CASESI = 21,
  UNSPEC_RBIT = 22,
  UNSPEC_SYMBOL_OFFSET = 23,
  UNSPEC_MEMORY_BARRIER = 24,
  UNSPEC_UNALIGNED_LOAD = 25,
  UNSPEC_UNALIGNED_STORE = 26,
  UNSPEC_PIC_UNIFIED = 27,
  UNSPEC_LL = 28,
  UNSPEC_VRINTZ = 29,
  UNSPEC_VRINTP = 30,
  UNSPEC_VRINTM = 31,
  UNSPEC_VRINTR = 32,
  UNSPEC_VRINTX = 33,
  UNSPEC_VRINTA = 34,
  UNSPEC_WADDC = 35,
  UNSPEC_WABS = 36,
  UNSPEC_WQMULWMR = 37,
  UNSPEC_WQMULMR = 38,
  UNSPEC_WQMULWM = 39,
  UNSPEC_WQMULM = 40,
  UNSPEC_WQMIAxyn = 41,
  UNSPEC_WQMIAxy = 42,
  UNSPEC_TANDC = 43,
  UNSPEC_TORC = 44,
  UNSPEC_TORVSC = 45,
  UNSPEC_TEXTRC = 46,
  UNSPEC_ASHIFT_SIGNED = 47,
  UNSPEC_ASHIFT_UNSIGNED = 48,
  UNSPEC_LOAD_COUNT = 49,
  UNSPEC_VABD = 50,
  UNSPEC_VABDL = 51,
  UNSPEC_VADD = 52,
  UNSPEC_VADDHN = 53,
  UNSPEC_VADDL = 54,
  UNSPEC_VADDW = 55,
  UNSPEC_VBSL = 56,
  UNSPEC_VCAGE = 57,
  UNSPEC_VCAGT = 58,
  UNSPEC_VCEQ = 59,
  UNSPEC_VCGE = 60,
  UNSPEC_VCGEU = 61,
  UNSPEC_VCGT = 62,
  UNSPEC_VCGTU = 63,
  UNSPEC_VCLS = 64,
  UNSPEC_VCONCAT = 65,
  UNSPEC_VCVT = 66,
  UNSPEC_VCVT_N = 67,
  UNSPEC_VEXT = 68,
  UNSPEC_VHADD = 69,
  UNSPEC_VHSUB = 70,
  UNSPEC_VLD1 = 71,
  UNSPEC_VLD1_LANE = 72,
  UNSPEC_VLD2 = 73,
  UNSPEC_VLD2_DUP = 74,
  UNSPEC_VLD2_LANE = 75,
  UNSPEC_VLD3 = 76,
  UNSPEC_VLD3A = 77,
  UNSPEC_VLD3B = 78,
  UNSPEC_VLD3_DUP = 79,
  UNSPEC_VLD3_LANE = 80,
  UNSPEC_VLD4 = 81,
  UNSPEC_VLD4A = 82,
  UNSPEC_VLD4B = 83,
  UNSPEC_VLD4_DUP = 84,
  UNSPEC_VLD4_LANE = 85,
  UNSPEC_VMAX = 86,
  UNSPEC_VMIN = 87,
  UNSPEC_VMLA = 88,
  UNSPEC_VMLAL = 89,
  UNSPEC_VMLA_LANE = 90,
  UNSPEC_VMLAL_LANE = 91,
  UNSPEC_VMLS = 92,
  UNSPEC_VMLSL = 93,
  UNSPEC_VMLS_LANE = 94,
  UNSPEC_VMLSL_LANE = 95,
  UNSPEC_VMOVL = 96,
  UNSPEC_VMOVN = 97,
  UNSPEC_VMUL = 98,
  UNSPEC_VMULL = 99,
  UNSPEC_VMUL_LANE = 100,
  UNSPEC_VMULL_LANE = 101,
  UNSPEC_VPADAL = 102,
  UNSPEC_VPADD = 103,
  UNSPEC_VPADDL = 104,
  UNSPEC_VPMAX = 105,
  UNSPEC_VPMIN = 106,
  UNSPEC_VPSMAX = 107,
  UNSPEC_VPSMIN = 108,
  UNSPEC_VPUMAX = 109,
  UNSPEC_VPUMIN = 110,
  UNSPEC_VQABS = 111,
  UNSPEC_VQADD = 112,
  UNSPEC_VQDMLAL = 113,
  UNSPEC_VQDMLAL_LANE = 114,
  UNSPEC_VQDMLSL = 115,
  UNSPEC_VQDMLSL_LANE = 116,
  UNSPEC_VQDMULH = 117,
  UNSPEC_VQDMULH_LANE = 118,
  UNSPEC_VQDMULL = 119,
  UNSPEC_VQDMULL_LANE = 120,
  UNSPEC_VQMOVN = 121,
  UNSPEC_VQMOVUN = 122,
  UNSPEC_VQNEG = 123,
  UNSPEC_VQSHL = 124,
  UNSPEC_VQSHL_N = 125,
  UNSPEC_VQSHLU_N = 126,
  UNSPEC_VQSHRN_N = 127,
  UNSPEC_VQSHRUN_N = 128,
  UNSPEC_VQSUB = 129,
  UNSPEC_VRECPE = 130,
  UNSPEC_VRECPS = 131,
  UNSPEC_VREV16 = 132,
  UNSPEC_VREV32 = 133,
  UNSPEC_VREV64 = 134,
  UNSPEC_VRSQRTE = 135,
  UNSPEC_VRSQRTS = 136,
  UNSPEC_VSHL = 137,
  UNSPEC_VSHLL_N = 138,
  UNSPEC_VSHL_N = 139,
  UNSPEC_VSHR_N = 140,
  UNSPEC_VSHRN_N = 141,
  UNSPEC_VSLI = 142,
  UNSPEC_VSRA_N = 143,
  UNSPEC_VSRI = 144,
  UNSPEC_VST1 = 145,
  UNSPEC_VST1_LANE = 146,
  UNSPEC_VST2 = 147,
  UNSPEC_VST2_LANE = 148,
  UNSPEC_VST3 = 149,
  UNSPEC_VST3A = 150,
  UNSPEC_VST3B = 151,
  UNSPEC_VST3_LANE = 152,
  UNSPEC_VST4 = 153,
  UNSPEC_VST4A = 154,
  UNSPEC_VST4B = 155,
  UNSPEC_VST4_LANE = 156,
  UNSPEC_VSTRUCTDUMMY = 157,
  UNSPEC_VSUB = 158,
  UNSPEC_VSUBHN = 159,
  UNSPEC_VSUBL = 160,
  UNSPEC_VSUBW = 161,
  UNSPEC_VTBL = 162,
  UNSPEC_VTBX = 163,
  UNSPEC_VTRN1 = 164,
  UNSPEC_VTRN2 = 165,
  UNSPEC_VTST = 166,
  UNSPEC_VUZP1 = 167,
  UNSPEC_VUZP2 = 168,
  UNSPEC_VZIP1 = 169,
  UNSPEC_VZIP2 = 170,
  UNSPEC_MISALIGNED_ACCESS = 171,
  UNSPEC_VCLE = 172,
  UNSPEC_VCLT = 173,
  UNSPEC_NVRINTZ = 174,
  UNSPEC_NVRINTP = 175,
  UNSPEC_NVRINTM = 176,
  UNSPEC_NVRINTX = 177,
  UNSPEC_NVRINTA = 178,
  UNSPEC_NVRINTN = 179
};
#define NUM_UNSPEC_VALUES 180
extern const char *const unspec_strings[];

enum unspecv {
  VUNSPEC_BLOCKAGE = 0,
  VUNSPEC_EPILOGUE = 1,
  VUNSPEC_THUMB1_INTERWORK = 2,
  VUNSPEC_ALIGN = 3,
  VUNSPEC_POOL_END = 4,
  VUNSPEC_POOL_1 = 5,
  VUNSPEC_POOL_2 = 6,
  VUNSPEC_POOL_4 = 7,
  VUNSPEC_POOL_8 = 8,
  VUNSPEC_POOL_16 = 9,
  VUNSPEC_TMRC = 10,
  VUNSPEC_TMCR = 11,
  VUNSPEC_ALIGN8 = 12,
  VUNSPEC_WCMP_EQ = 13,
  VUNSPEC_WCMP_GTU = 14,
  VUNSPEC_WCMP_GT = 15,
  VUNSPEC_EH_RETURN = 16,
  VUNSPEC_ATOMIC_CAS = 17,
  VUNSPEC_ATOMIC_XCHG = 18,
  VUNSPEC_ATOMIC_OP = 19,
  VUNSPEC_LL = 20,
  VUNSPEC_SC = 21
};
#define NUM_UNSPECV_VALUES 22
extern const char *const unspecv_strings[];

#endif /* GCC_INSN_CONSTANTS_H */
