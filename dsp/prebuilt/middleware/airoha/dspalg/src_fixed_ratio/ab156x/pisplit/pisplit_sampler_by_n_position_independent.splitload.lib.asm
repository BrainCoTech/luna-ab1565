
Build/lib/pisplit_sampler_by_n_position_independent.splitload.lib:     file format elf32-xtensa-le


Disassembly of section .text:

00000000 <_init-0x68>:
   0:	000000b4 000003ec 0000071c 00000000     ................
  10:	000006e0 00000000 00000704 000007b8     ................
  20:	00000740 00000108 0000075f 00000110     @......._.......
  30:	00000778 0000038c 00000797 000003bc     x...............
  40:	00000730 22061501 00000410 00000424     0......"....$...
  50:	aaaaaaab 55555556 00000138 00000258     ....VUUU8...X...
  60:	000006e8 00000080                       ........

00000068 <_init>:
  68:	008136        	entry	a1, 64
  6b:	ffe581        	l32r	a8, 0 (b4 <frame_dummy>)
  6e:	f03d           	nop.n
  70:	0008e0        	callx8	a8
  73:	ffe481        	l32r	a8, 4 (3ec <__do_global_ctors_aux>)
  76:	f03d           	nop.n
  78:	0008e0        	callx8	a8
  7b:	f01d           	retw.n

0000007d <_init+0x15>:
  7d:	000000                                        ...

00000080 <__do_global_dtors_aux>:
  80:	004136        	entry	a1, 32
  83:	ffe121        	l32r	a2, 8 (71c <__do_global_dtors_aux.completed>)
  86:	000232        	l8ui	a3, a2, 0
  89:	23ec           	bnez.n	a3, af <__do_global_dtors_aux+0x2f>

0000008b <__do_global_dtors_aux+0xb>:
  8b:	1248           	l32i.n	a4, a2, 4
  8d:	0438           	l32i.n	a3, a4, 0
  8f:	444b           	addi.n	a4, a4, 4
  91:	738c           	beqz.n	a3, 9c <__do_global_dtors_aux+0x1c>
  93:	1249           	s32i.n	a4, a2, 4
  95:	0003e0        	callx8	a3
  98:	fffbc6        	j	8b <__do_global_dtors_aux+0xb>

0000009b <__do_global_dtors_aux+0x1b>:
	...

0000009c <__do_global_dtors_aux+0x1c>:
  9c:	ffdc31        	l32r	a3, c (0 <_text_start>)
  9f:	ffdca1        	l32r	a10, 10 (6e0 <__FRAME_END__>)
  a2:	438c           	beqz.n	a3, aa <__do_global_dtors_aux+0x2a>
  a4:	ffda81        	l32r	a8, c (0 <_text_start>)
  a7:	0008e0        	callx8	a8
  aa:	130c           	movi.n	a3, 1
  ac:	004232        	s8i	a3, a2, 0
  af:	f01d           	retw.n

000000b1 <__do_global_dtors_aux+0x31>:
  b1:	000000                                        ...

000000b4 <frame_dummy>:
  b4:	004136        	entry	a1, 32
  b7:	ffd721        	l32r	a2, 14 (0 <_text_start>)
  ba:	ffd5a1        	l32r	a10, 10 (6e0 <__FRAME_END__>)
  bd:	ffd6b1        	l32r	a11, 18 (704 <frame_dummy.object>)
  c0:	428c           	beqz.n	a2, c8 <frame_dummy+0x14>
  c2:	ffd481        	l32r	a8, 14 (0 <_text_start>)
  c5:	0008e0        	callx8	a8

000000c8 <frame_dummy+0x14>:
  c8:	f01d           	retw.n

000000ca <frame_dummy+0x16>:
	...

000000cc <_start>:
  cc:	004136        	entry	a1, 32
  cf:	ffd331        	l32r	a3, 1c (7b8 <printf_ptr>)
  d2:	0228           	l32i.n	a2, a2, 0
  d4:	ffd3a1        	l32r	a10, 20 (740 <export_parameter_array+0x10>)
  d7:	ffd3b1        	l32r	a11, 24 (108 <get_sampler_by_n_version>)
  da:	0329           	s32i.n	a2, a3, 0
  dc:	0002e0        	callx8	a2
  df:	0328           	l32i.n	a2, a3, 0
  e1:	ffd1a1        	l32r	a10, 28 (75f <export_parameter_array+0x2f>)
  e4:	ffd2b1        	l32r	a11, 2c (110 <updn_sampling_Init>)
  e7:	0002e0        	callx8	a2
  ea:	0328           	l32i.n	a2, a3, 0
  ec:	ffd1a1        	l32r	a10, 30 (778 <export_parameter_array+0x48>)
  ef:	ffd1b1        	l32r	a11, 34 (38c <updn_sampling_16bit_Proc>)
  f2:	0002e0        	callx8	a2
  f5:	0328           	l32i.n	a2, a3, 0
  f7:	ffd0a1        	l32r	a10, 38 (797 <export_parameter_array+0x67>)
  fa:	ffd0b1        	l32r	a11, 3c (3bc <updn_sampling_32bit_Proc>)
  fd:	0002e0        	callx8	a2
 100:	ffd021        	l32r	a2, 40 (730 <export_parameter_array>)
 103:	f01d           	retw.n

00000105 <_start+0x39>:
 105:	000000                                        ...

00000108 <get_sampler_by_n_version>:
 108:	004136        	entry	a1, 32
 10b:	ffce21        	l32r	a2, 44 (22061501 <_end+0x22060d45>)
 10e:	f01d           	retw.n

00000110 <updn_sampling_Init>:
 110:	004136        	entry	a1, 32
 113:	ffcd41        	l32r	a4, 48 (410 <xt_hifi5_sampler_by_n_memset>)
 116:	40c2a2        	addi	a10, a2, 64
 119:	0b0c           	movi.n	a11, 0
 11b:	4c0c           	movi.n	a12, 4
 11d:	0004e0        	callx8	a4
 120:	48c2a2        	addi	a10, a2, 72
 123:	0b0c           	movi.n	a11, 0
 125:	cc0c           	movi.n	a12, 12
 127:	0004e0        	callx8	a4
 12a:	ffc841        	l32r	a4, 4c (424 <xt_hifi5_sampler_by_n_memcpy>)
 12d:	0c2c           	movi.n	a12, 32
 12f:	02ad           	mov.n	a10, a2
 131:	03bd           	mov.n	a11, a3
 133:	0004e0        	callx8	a4
 136:	f01d           	retw.n

00000138 <updn_sampling_by2_Proc_V2>:
 138:	00a136        	entry	a1, 80
 13b:	0bb766        	bnei	a7, 16, 14a <updn_sampling_by2_Proc_V2+0x12>
 13e:	fec332        	addi	a3, a3, -2
 141:	fec442        	addi	a4, a4, -2
 144:	000206        	j	150 <updn_sampling_by2_Proc_V2+0x18>

00000147 <updn_sampling_by2_Proc_V2+0xf>:
 147:	000000                                        ...

0000014a <updn_sampling_by2_Proc_V2+0x12>:
 14a:	fcc382        	addi	a8, a3, -4
 14d:	fcc492        	addi	a9, a4, -4
 150:	0a0c           	movi.n	a10, 0
 152:	62ba60        	saltu	a11, a10, a6
 155:	401b00        	ssl	a11
 158:	a1c500        	sll	a12, a5
 15b:	11fc00        	slli	a15, a12, 16
 15e:	021fe6        	bgei	a15, 1, 164 <updn_sampling_by2_Proc_V2+0x2c>
 161:	003946        	j	24a <updn_sampling_by2_Proc_V2+0x112>
 164:	fcc2d2        	addi	a13, a2, -4
 167:	448d14        	ae_lp16x2f.iu	aep0, a13, 4
 16a:	449d14        	ae_lp16x2f.iu	aep1, a13, 4
 16d:	44ad14        	ae_lp16x2f.iu	aep2, a13, 4
 170:	44bd14        	ae_lp16x2f.iu	aep3, a13, 4
 173:	44cd14        	ae_lp16x2f.iu	aep4, a13, 4
 176:	44dd14        	ae_lp16x2f.iu	aep5, a13, 4
 179:	44ed14        	ae_lp16x2f.iu	aep6, a13, 4
 17c:	3e0c           	movi.n	a14, 3
 17e:	2b0c           	movi.n	a11, 2
 180:	8cfd           	ae_sext16	a15, a12
 182:	93be60        	movnez	a11, a14, a6
 185:	44fd14        	ae_lp16x2f.iu	aep7, a13, 4
 188:	e60b           	addi.n	a14, a6, -1
 18a:	40c222        	addi	a2, a2, 64
 18d:	567124        	ae_sp24x2s.i	aep7, a1, 16
 190:	1c0c           	movi.n	a12, 1
 192:	62dae0        	saltu	a13, a10, a14
 195:	b18f76        	loop	a15, 24a <updn_sampling_by2_Proc_V2+0x112>
 198:	fe24bd220f 	{ ae_lq32f.i	aeq1, a2, 0; ae_zeroq56	aeq2 }
 19d:	ff20fd021f 	{ ae_lq32f.i	aeq0, a2, 4; ae_zerop48	aep7 }
 1a2:	0eb766        	bnei	a7, 16, 1b4 <updn_sampling_by2_Proc_V2+0x7c>
 1a5:	021666        	bnei	a6, 1, 1ab <updn_sampling_by2_Proc_V2+0x73>
 1a8:	02ea07        	bbsi	a10, 0, 1ae <updn_sampling_by2_Proc_V2+0x76>
 1ab:	40f314        	ae_lp16f.iu	aep7, a3, 2
 1ae:	0a8784        	ae_cvtq48p24s.l	aeq2, aep7
 1b1:	000206        	j	1bd <updn_sampling_by2_Proc_V2+0x85>

000001b4 <updn_sampling_by2_Proc_V2+0x7c>:
 1b4:	021666        	bnei	a6, 1, 1ba <updn_sampling_by2_Proc_V2+0x82>
 1b7:	02ea07        	bbsi	a10, 0, 1bd <updn_sampling_by2_Proc_V2+0x85>
 1ba:	609814        	ae_lq32f.iu	aeq2, a8, 4
 1bd:	35a0b4        	ae_sraiq56	aeq2, aeq2, 2
 1c0:	0b08f9921f 	{ ae_sq32f.i	aeq1, a2, 4; ae_mulzaafq32sp16s.hh	aeq3, aeq2, aep2, aeq1, aep0 }
 1c5:	f503fd222f 	{ ae_lq32f.i	aeq1, a2, 8; ae_mulafq32sp16s.h	aeq3, aeq1, aep0 }
 1ca:	f582f9a20f 	{ ae_sq32f.i	aeq2, a2, 0; ae_mulafq32sp16s.l	aeq3, aeq0, aep0 }
 1cf:	f507fd023f 	{ ae_lq32f.i	aeq0, a2, 12; ae_mulafq32sp16s.h	aeq3, aeq1, aep1 }
 1d4:	f507f0712f 	{ ae_lp24x2.i	aep7, a1, 16; ae_mulafq32sp16s.h	aeq3, aeq1, aep1 }
 1d9:	f586f9923f 	{ ae_sq32f.i	aeq1, a2, 12; ae_mulafq32sp16s.l	aeq3, aeq0, aep1 }
 1de:	04e0a0        	extui	a14, a10, 0, 1
 1e1:	06f834        	ae_roundsq32sym	aeq3, aeq3
 1e4:	0f69ba315f 	{ ae_sq56s.i	aeq3, a1, 40; ae_mulzaafq32sp16s.lh	aeq2, aeq3, aep2, aeq1, aep3 }
 1e9:	f50fbd624f 	{ ae_lq32f.i	aeq3, a2, 16; ae_mulafq32sp16s.h	aeq2, aeq1, aep3 }
 1ee:	f58ebd025f 	{ ae_lq32f.i	aeq0, a2, 20; ae_mulafq32sp16s.l	aeq2, aeq0, aep3 }
 1f3:	f713ba014f 	{ ae_sq56s.i	aeq0, a1, 32; ae_mulafq32sp16s.h	aeq2, aeq3, aep4 }
 1f8:	f713b9b25f 	{ ae_sq32f.i	aeq3, a2, 20; ae_mulafq32sp16s.h	aeq2, aeq3, aep4 }
 1fd:	03c014        	ae_mulafq32sp16s.l	aeq2, aeq0, aep4
 200:	62eec0        	saltu	a14, a14, a12
 203:	fc547dc14f 	{ ae_lq56.i	aeq2, a1, 32; ae_roundsq32sym	aeq0, aeq2 }
 208:	08befa013f 	{ ae_sq56s.i	aeq0, a1, 24; ae_mulzaafq32sp16s.hh	aeq1, aeq0, aep7, aeq3, aep5 }
 20d:	f617fd026f 	{ ae_lq32f.i	aeq0, a2, 24; ae_mulafq32sp16s.h	aeq1, aeq3, aep5 }
 212:	f696fd427f 	{ ae_lq32f.i	aeq2, a2, 28; ae_mulafq32sp16s.l	aeq1, aeq2, aep5 }
 217:	f41afde15f 	{ ae_lq56.i	aeq3, a1, 40; ae_mulafq32sp16s.h	aeq1, aeq0, aep6 }
 21c:	f41af9b22f 	{ ae_sq32f.i	aeq3, a2, 8; ae_mulafq32sp16s.h	aeq1, aeq0, aep6 }
 221:	f69afdc13f 	{ ae_lq56.i	aeq2, a1, 24; ae_mulafq32sp16s.l	aeq1, aeq2, aep6 }
 226:	10eed0        	and	a14, a14, a13
 229:	ff4c79827f 	{ ae_sq32f.i	aeq0, a2, 28; ae_roundsq32sym	aeq3, aeq1 }
 22e:	622244        	ae_sq32f.i	aeq2, a2, 16
 231:	623264        	ae_sq32f.i	aeq3, a2, 24
 234:	0edc           	bnez.n	a14, 248 <updn_sampling_by2_Proc_V2+0x110>
 236:	341b34        	ae_sllasq56s	aeq0, aeq1, a11
 239:	08b766        	bnei	a7, 16, 245 <updn_sampling_by2_Proc_V2+0x10d>
 23c:	1b8e74        	ae_roundsp16q48sym	aep7, aeq0
 23f:	42f414        	ae_sp16f.l.iu	aep7, a4, 2
 242:	000086        	j	248 <updn_sampling_by2_Proc_V2+0x110>

00000245 <updn_sampling_by2_Proc_V2+0x10d>:
 245:	624914        	ae_sq32f.iu	aeq0, a9, 4
 248:	aa1b           	addi.n	a10, a10, 1

0000024a <updn_sampling_by2_Proc_V2+0x112>:
 24a:	1125f0        	slli	a2, a5, 1
 24d:	413150        	srli	a3, a5, 1
 250:	933260        	movnez	a3, a2, a6
 253:	832d           	ae_sext16	a2, a3
 255:	f01d           	retw.n

00000257 <updn_sampling_by2_Proc_V2+0x11f>:
	...

00000258 <updn_sampling_by3_Proc>:
 258:	00a136        	entry	a1, 80
 25b:	0ab766        	bnei	a7, 16, 269 <updn_sampling_by3_Proc+0x11>
 25e:	fec332        	addi	a3, a3, -2
 261:	fec442        	addi	a4, a4, -2
 264:	0001c6        	j	26f <updn_sampling_by3_Proc+0x17>

00000267 <updn_sampling_by3_Proc+0xf>:
	...

00000269 <updn_sampling_by3_Proc+0x11>:
 269:	fcc382        	addi	a8, a3, -4
 26c:	fcc492        	addi	a9, a4, -4
 26f:	90a550        	addx2	a10, a5, a5
 272:	05cd           	mov.n	a12, a5
 274:	93ca60        	movnez	a12, a10, a6
 277:	11bc00        	slli	a11, a12, 16
 27a:	021be6        	bgei	a11, 1, 280 <updn_sampling_by3_Proc+0x28>
 27d:	003e46        	j	37a <updn_sampling_by3_Proc+0x122>
 280:	1cc2e2        	addi	a14, a2, 28
 283:	448e14        	ae_lp16x2f.iu	aep0, a14, 4
 286:	449e14        	ae_lp16x2f.iu	aep1, a14, 4
 289:	44ae14        	ae_lp16x2f.iu	aep2, a14, 4
 28c:	44be14        	ae_lp16x2f.iu	aep3, a14, 4
 28f:	44ce14        	ae_lp16x2f.iu	aep4, a14, 4
 292:	44de14        	ae_lp16x2f.iu	aep5, a14, 4
 295:	3d0c           	movi.n	a13, 3
 297:	2b0c           	movi.n	a11, 2
 299:	44ee14        	ae_lp16x2f.iu	aep6, a14, 4
 29c:	93bd60        	movnez	a11, a13, a6
 29f:	ff6cd1        	l32r	a13, 50 (aaaaaaab <_end+0xaaaaa2ef>)
 2a2:	44fe14        	ae_lp16x2f.iu	aep7, a14, 4
 2a5:	8cfd           	ae_sext16	a15, a12
 2a7:	40c222        	addi	a2, a2, 64
 2aa:	0c0c           	movi.n	a12, 0
 2ac:	0e0c           	movi.n	a14, 0
 2ae:	567134        	ae_sp24x2s.i	aep7, a1, 24
 2b1:	c58f76        	loop	a15, 37a <updn_sampling_by3_Proc+0x122>
 2b4:	a2fed0        	muluh	a15, a14, a13
 2b7:	fe24bd221f 	{ ae_lq32f.i	aeq1, a2, 4; ae_zeroq56	aeq2 }
 2bc:	41f1f0        	srli	a15, a15, 1
 2bf:	ff20d1ffff 	{ addx2	a15, a15, a15; ae_zerop48	aep7 }
 2c4:	600204        	ae_lq32f.i	aeq0, a2, 0
 2c7:	fcfa           	add.n	a15, a12, a15
 2c9:	631124        	ae_sq56s.i	aeq1, a1, 16
 2cc:	0db766        	bnei	a7, 16, 2dd <updn_sampling_by3_Proc+0x85>
 2cf:	011666        	bnei	a6, 1, 2d4 <updn_sampling_by3_Proc+0x7c>
 2d2:	1fcc           	bnez.n	a15, 2d7 <updn_sampling_by3_Proc+0x7f>
 2d4:	40f314        	ae_lp16f.iu	aep7, a3, 2
 2d7:	0a8784        	ae_cvtq48p24s.l	aeq2, aep7
 2da:	0001c6        	j	2e5 <updn_sampling_by3_Proc+0x8d>

000002dd <updn_sampling_by3_Proc+0x85>:
 2dd:	011666        	bnei	a6, 1, 2e2 <updn_sampling_by3_Proc+0x8a>
 2e0:	1fcc           	bnez.n	a15, 2e5 <updn_sampling_by3_Proc+0x8d>
 2e2:	609814        	ae_lq32f.iu	aeq2, a8, 4
 2e5:	35e0b4        	ae_sraiq56	aeq3, aeq2, 2
 2e8:	0a0979821f 	{ ae_sq32f.i	aeq0, a2, 4; ae_mulzaafq32sp16s.hh	aeq1, aeq3, aep2, aeq0, aep0 }
 2ed:	f402fd812f 	{ ae_lq56.i	aeq0, a1, 16; ae_mulafq32sp16s.h	aeq1, aeq0, aep0 }
 2f2:	f482fd422f 	{ ae_lq32f.i	aeq2, a2, 8; ae_mulafq32sp16s.l	aeq1, aeq0, aep0 }
 2f7:	f606f9b20f 	{ ae_sq32f.i	aeq3, a2, 0; ae_mulafq32sp16s.h	aeq1, aeq2, aep1 }
 2fc:	f606fd623f 	{ ae_lq32f.i	aeq3, a2, 12; ae_mulafq32sp16s.h	aeq1, aeq2, aep1 }
 301:	f687fd024f 	{ ae_lq32f.i	aeq0, a2, 16; ae_mulafq32sp16s.l	aeq1, aeq3, aep1 }
 306:	547134        	ae_lp24x2.i	aep7, a1, 24
 309:	fd4c79a23f 	{ ae_sq32f.i	aeq2, a2, 12; ae_roundsq32sym	aeq1, aeq1 }
 30e:	0c6b7a112f 	{ ae_sq56s.i	aeq1, a1, 16; ae_mulzaafq32sp16s.lh	aeq1, aeq1, aep2, aeq2, aep3 }
 313:	033884        	ae_mulafq32sp16s.h	aeq1, aeq2, aep3
 316:	f68ffd625f 	{ ae_lq32f.i	aeq3, a2, 20; ae_mulafq32sp16s.l	aeq1, aeq3, aep3 }
 31b:	f412fa315f 	{ ae_sq56s.i	aeq3, a1, 40; ae_mulafq32sp16s.h	aeq1, aeq0, aep4 }
 320:	f412fdc15f 	{ ae_lq56.i	aeq2, a1, 40; ae_mulafq32sp16s.h	aeq1, aeq0, aep4 }
 325:	f693fd626f 	{ ae_lq32f.i	aeq3, a2, 24; ae_mulafq32sp16s.l	aeq1, aeq3, aep4 }
 32a:	fd4c79825f 	{ ae_sq32f.i	aeq0, a2, 20; ae_roundsq32sym	aeq1, aeq1 }
 32f:	08bd7a114f 	{ ae_sq56s.i	aeq1, a1, 32; ae_mulzaafq32sp16s.hh	aeq1, aeq1, aep7, aeq0, aep5 }
 334:	035804        	ae_mulafq32sp16s.h	aeq1, aeq0, aep5
 337:	f696fd427f 	{ ae_lq32f.i	aeq2, a2, 28; ae_mulafq32sp16s.l	aeq1, aeq2, aep5 }
 33c:	f61bf9b27f 	{ ae_sq32f.i	aeq3, a2, 28; ae_mulafq32sp16s.h	aeq1, aeq3, aep6 }
 341:	f61bfde12f 	{ ae_lq56.i	aeq3, a1, 16; ae_mulafq32sp16s.h	aeq1, aeq3, aep6 }
 346:	f69af9b22f 	{ ae_sq32f.i	aeq3, a2, 8; ae_mulafq32sp16s.l	aeq1, aeq2, aep6 }
 34b:	618144        	ae_lq56.i	aeq2, a1, 32
 34e:	ff4c79a24f 	{ ae_sq32f.i	aeq2, a2, 16; ae_roundsq32sym	aeq3, aeq1 }
 353:	623264        	ae_sq32f.i	aeq3, a2, 24
 356:	081666        	bnei	a6, 1, 362 <updn_sampling_by3_Proc+0x10a>
 359:	351074        	ae_sraiq56	aeq0, aeq1, 1
 35c:	0158c4        	ae_addq56	aeq1, aeq1, aeq0
 35f:	000046        	j	364 <updn_sampling_by3_Proc+0x10c>

00000362 <updn_sampling_by3_Proc+0x10a>:
 362:	0fdc           	bnez.n	a15, 376 <updn_sampling_by3_Proc+0x11e>
 364:	341b34        	ae_sllasq56s	aeq0, aeq1, a11
 367:	08b766        	bnei	a7, 16, 373 <updn_sampling_by3_Proc+0x11b>
 36a:	1b8e74        	ae_roundsp16q48sym	aep7, aeq0
 36d:	42f414        	ae_sp16f.l.iu	aep7, a4, 2
 370:	000086        	j	376 <updn_sampling_by3_Proc+0x11e>

00000373 <updn_sampling_by3_Proc+0x11b>:
 373:	624914        	ae_sq32f.iu	aeq0, a9, 4
 376:	ee1b           	addi.n	a14, a14, 1
 378:	cc0b           	addi.n	a12, a12, -1

0000037a <updn_sampling_by3_Proc+0x122>:
 37a:	ff3621        	l32r	a2, 54 (55555556 <_end+0x55554d9a>)
 37d:	b22520        	mulsh	a2, a5, a2
 380:	053f20        	extui	a3, a2, 31, 1
 383:	223a           	add.n	a2, a2, a3
 385:	932a60        	movnez	a2, a10, a6
 388:	822d           	ae_sext16	a2, a2
 38a:	f01d           	retw.n

0000038c <updn_sampling_16bit_Proc>:
 38c:	004136        	entry	a1, 32
 38f:	0a3426        	beqi	a4, 3, 39d <updn_sampling_16bit_Proc+0x11>
 392:	1c2466        	bnei	a4, 2, 3b2 <updn_sampling_16bit_Proc+0x26>
 395:	83ed           	ae_sext16	a14, a3
 397:	ff3031        	l32r	a3, 58 (138 <updn_sampling_by2_Proc_V2>)
 39a:	000106        	j	3a2 <updn_sampling_16bit_Proc+0x16>

0000039d <updn_sampling_16bit_Proc+0x11>:
 39d:	83ed           	ae_sext16	a14, a3
 39f:	ff2f31        	l32r	a3, 5c (258 <updn_sampling_by3_Proc>)
 3a2:	0f1c           	movi.n	a15, 16
 3a4:	02ad           	mov.n	a10, a2
 3a6:	05bd           	mov.n	a11, a5
 3a8:	06cd           	mov.n	a12, a6
 3aa:	07dd           	mov.n	a13, a7
 3ac:	0003e0        	callx8	a3
 3af:	000106        	j	3b7 <updn_sampling_16bit_Proc+0x2b>

000003b2 <updn_sampling_16bit_Proc+0x26>:
 3b2:	fa7c           	movi.n	a10, -1
 3b4:	f4a0a0        	extui	a10, a10, 0, 16
 3b7:	8a2d           	ae_sext16	a2, a10
 3b9:	f01d           	retw.n

000003bb <updn_sampling_16bit_Proc+0x2f>:
	...

000003bc <updn_sampling_32bit_Proc>:
 3bc:	004136        	entry	a1, 32
 3bf:	0a3426        	beqi	a4, 3, 3cd <updn_sampling_32bit_Proc+0x11>
 3c2:	1c2466        	bnei	a4, 2, 3e2 <updn_sampling_32bit_Proc+0x26>
 3c5:	83ed           	ae_sext16	a14, a3
 3c7:	ff2431        	l32r	a3, 58 (138 <updn_sampling_by2_Proc_V2>)
 3ca:	000106        	j	3d2 <updn_sampling_32bit_Proc+0x16>

000003cd <updn_sampling_32bit_Proc+0x11>:
 3cd:	83ed           	ae_sext16	a14, a3
 3cf:	ff2331        	l32r	a3, 5c (258 <updn_sampling_by3_Proc>)
 3d2:	0f2c           	movi.n	a15, 32
 3d4:	02ad           	mov.n	a10, a2
 3d6:	05bd           	mov.n	a11, a5
 3d8:	06cd           	mov.n	a12, a6
 3da:	07dd           	mov.n	a13, a7
 3dc:	0003e0        	callx8	a3
 3df:	000106        	j	3e7 <updn_sampling_32bit_Proc+0x2b>

000003e2 <updn_sampling_32bit_Proc+0x26>:
 3e2:	fa7c           	movi.n	a10, -1
 3e4:	f4a0a0        	extui	a10, a10, 0, 16
 3e7:	8a2d           	ae_sext16	a2, a10
 3e9:	f01d           	retw.n

000003eb <updn_sampling_32bit_Proc+0x2f>:
	...

000003ec <__do_global_ctors_aux>:
 3ec:	004136        	entry	a1, 32
 3ef:	ff1c31        	l32r	a3, 60 (6e8 <__CTOR_END__>)
 3f2:	fcc322        	addi	a2, a3, -4
 3f5:	0228           	l32i.n	a2, a2, 0
 3f7:	f8c332        	addi	a3, a3, -8
 3fa:	0a0226        	beqi	a2, -1, 408 <__do_global_ctors_aux+0x1c>

000003fd <__do_global_ctors_aux+0x11>:
 3fd:	0002e0        	callx8	a2
 400:	0328           	l32i.n	a2, a3, 0
 402:	fcc332        	addi	a3, a3, -4
 405:	f40266        	bnei	a2, -1, 3fd <__do_global_ctors_aux+0x11>
 408:	f01d           	retw.n

0000040a <__do_global_ctors_aux+0x1e>:
 40a:	00000000                                 ......

00000410 <xt_hifi5_sampler_by_n_memset>:
 410:	004136        	entry	a1, 32
 413:	928c           	beqz.n	a2, 420 <xt_hifi5_sampler_by_n_memset+0x10>
 415:	748c           	beqz.n	a4, 420 <xt_hifi5_sampler_by_n_memset+0x10>
 417:	025d           	mov.n	a5, a2
 419:	038476        	loop	a4, 420 <xt_hifi5_sampler_by_n_memset+0x10>
 41c:	653d           	ae_s16i.n	a3, a5, 0
 41e:	552b           	addi.n	a5, a5, 2

00000420 <xt_hifi5_sampler_by_n_memset+0x10>:
 420:	f01d           	retw.n

00000422 <xt_hifi5_sampler_by_n_memset+0x12>:
	...

00000424 <xt_hifi5_sampler_by_n_memcpy>:
 424:	004136        	entry	a1, 32
 427:	025d           	mov.n	a5, a2
 429:	020c           	movi.n	a2, 0
 42b:	b5bc           	beqz.n	a5, 46a <xt_hifi5_sampler_by_n_memcpy+0x46>
 42d:	93bc           	beqz.n	a3, 46a <xt_hifi5_sampler_by_n_memcpy+0x46>
 42f:	24b357        	bgeu	a3, a5, 457 <xt_hifi5_sampler_by_n_memcpy+0x33>
 432:	902430        	addx2	a2, a4, a3
 435:	1eb527        	bgeu	a5, a2, 457 <xt_hifi5_sampler_by_n_memcpy+0x33>
 438:	052d           	mov.n	a2, a5
 43a:	c4ac           	beqz.n	a4, 46a <xt_hifi5_sampler_by_n_memcpy+0x46>
 43c:	240b           	addi.n	a2, a4, -1
 43e:	1122f0        	slli	a2, a2, 1
 441:	332a           	add.n	a3, a3, a2
 443:	652a           	add.n	a6, a5, a2
 445:	0b8476        	loop	a4, 454 <xt_hifi5_sampler_by_n_memcpy+0x30>
 448:	232d           	ae_l16si.n	a2, a3, 0
 44a:	662d           	ae_s16i.n	a2, a6, 0
 44c:	fec332        	addi	a3, a3, -2
 44f:	052d           	mov.n	a2, a5
 451:	fec662        	addi	a6, a6, -2

00000454 <xt_hifi5_sampler_by_n_memcpy+0x30>:
 454:	000486        	j	46a <xt_hifi5_sampler_by_n_memcpy+0x46>

00000457 <xt_hifi5_sampler_by_n_memcpy+0x33>:
 457:	052d           	mov.n	a2, a5
 459:	d48c           	beqz.n	a4, 46a <xt_hifi5_sampler_by_n_memcpy+0x46>
 45b:	056d           	mov.n	a6, a5
 45d:	098476        	loop	a4, 46a <xt_hifi5_sampler_by_n_memcpy+0x46>
 460:	232d           	ae_l16si.n	a2, a3, 0
 462:	662d           	ae_s16i.n	a2, a6, 0
 464:	332b           	addi.n	a3, a3, 2
 466:	052d           	mov.n	a2, a5
 468:	662b           	addi.n	a6, a6, 2

0000046a <xt_hifi5_sampler_by_n_memcpy+0x46>:
 46a:	f01d           	retw.n

0000046c <_fini>:
 46c:	008136        	entry	a1, 64
 46f:	fefd81        	l32r	a8, 64 (80 <__do_global_dtors_aux>)
 472:	f03d           	nop.n
 474:	0008e0        	callx8	a8

00000477 <_fini+0xb>:
 477:	f01d           	retw.n
