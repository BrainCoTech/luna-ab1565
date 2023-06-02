
Build/lib/pisplit_msbc_enc_position_independent.splitload.lib:     file format elf32-xtensa-le


Disassembly of section .text:

00000000 <_init-0x7c>:
   0:	000000c8 00000d40 0000106c 00000000     ....@...l.......
  10:	00001030 00000000 00001054 00000ba4     0.......T.......
  20:	0000052c 000014d0 00001090 000010a7     ,...............
  30:	000004c0 000010bd 000010d8 00000478     ............x...
  40:	00001080 000010f0 00000360 008f0001     ........`.......
  50:	0001fffc 000012b0 0000c801 000014b0     ................
  60:	00000168 00000bd8 000005ec 0000032c     h...........,...
  70:	00001230 00001038 00000094              0...8.......

0000007c <_init>:
  7c:	008136        	entry	a1, 64
  7f:	ffe081        	l32r	a8, 0 (c8 <frame_dummy>)
  82:	f03d           	nop.n
  84:	0008e0        	callx8	a8
  87:	ffdf81        	l32r	a8, 4 (d40 <__do_global_ctors_aux>)
  8a:	f03d           	nop.n
  8c:	0008e0        	callx8	a8
  8f:	f01d           	retw.n

00000091 <_init+0x15>:
  91:	000000                                        ...

00000094 <__do_global_dtors_aux>:
  94:	004136        	entry	a1, 32
  97:	ffdc21        	l32r	a2, 8 (106c <__do_global_dtors_aux.completed>)
  9a:	000232        	l8ui	a3, a2, 0
  9d:	23ec           	bnez.n	a3, c3 <__do_global_dtors_aux+0x2f>

0000009f <__do_global_dtors_aux+0xb>:
  9f:	1248           	l32i.n	a4, a2, 4
  a1:	0438           	l32i.n	a3, a4, 0
  a3:	444b           	addi.n	a4, a4, 4
  a5:	738c           	beqz.n	a3, b0 <__do_global_dtors_aux+0x1c>
  a7:	1249           	s32i.n	a4, a2, 4
  a9:	0003e0        	callx8	a3
  ac:	fffbc6        	j	9f <__do_global_dtors_aux+0xb>

000000af <__do_global_dtors_aux+0x1b>:
	...

000000b0 <__do_global_dtors_aux+0x1c>:
  b0:	ffd731        	l32r	a3, c (0 <_text_start>)
  b3:	ffd7a1        	l32r	a10, 10 (1030 <__FRAME_END__>)
  b6:	438c           	beqz.n	a3, be <__do_global_dtors_aux+0x2a>
  b8:	ffd581        	l32r	a8, c (0 <_text_start>)
  bb:	0008e0        	callx8	a8
  be:	130c           	movi.n	a3, 1
  c0:	004232        	s8i	a3, a2, 0
  c3:	f01d           	retw.n

000000c5 <__do_global_dtors_aux+0x31>:
  c5:	000000                                        ...

000000c8 <frame_dummy>:
  c8:	004136        	entry	a1, 32
  cb:	ffd221        	l32r	a2, 14 (0 <_text_start>)
  ce:	ffd0a1        	l32r	a10, 10 (1030 <__FRAME_END__>)
  d1:	ffd1b1        	l32r	a11, 18 (1054 <frame_dummy.object>)
  d4:	428c           	beqz.n	a2, dc <frame_dummy+0x14>
  d6:	ffcf81        	l32r	a8, 14 (0 <_text_start>)
  d9:	0008e0        	callx8	a8

000000dc <frame_dummy+0x14>:
  dc:	f01d           	retw.n

000000de <frame_dummy+0x16>:
	...

000000e0 <SBC_GSENC_INIT>:
  e0:	004136        	entry	a1, 32
  e3:	ffce51        	l32r	a5, 1c (ba4 <SBC_Encoder_Init>)
  e6:	20a440        	or	a10, a4, a4
  e9:	0005e0        	callx8	a5
  ec:	1e0c           	movi.n	a14, 1
  ee:	04d442        	addmi	a4, a4, 0x400
  f1:	051c           	movi.n	a5, 16
  f3:	1f3c           	movi.n	a15, 49
  f5:	9033e0        	addx2	a3, a3, a14
  f8:	236452        	s32i	a5, a4, 140
  fb:	256422        	s32i	a2, a4, 148
  fe:	2a64f2        	s32i	a15, a4, 168
 101:	316432        	s32i	a3, a4, 196
 104:	f01d           	retw.n

00000106 <SBC_GSENC_INIT+0x26>:
	...

00000108 <mSBC_GSENC_Process>:
 108:	004136        	entry	a1, 32
 10b:	04d452        	addmi	a5, a4, 0x400
 10e:	ffc471        	l32r	a7, 20 (52c <mSBC_Encoder_Process>)
 111:	312562        	l32i	a6, a5, 196
 114:	02ad           	mov.n	a10, a2
 116:	03bd           	mov.n	a11, a3
 118:	04cd           	mov.n	a12, a4
 11a:	0007e0        	callx8	a7
 11d:	2b2522        	l32i	a2, a5, 172
 120:	316562        	s32i	a6, a5, 196
 123:	f01d           	retw.n

00000125 <mSBC_GSENC_Process+0x1d>:
 125:	000000                                        ...

00000128 <_start>:
 128:	004136        	entry	a1, 32
 12b:	ffbe31        	l32r	a3, 24 (14d0 <printf_ptr>)
 12e:	0228           	l32i.n	a2, a2, 0
 130:	ffbea1        	l32r	a10, 28 (1090 <export_parameter_array+0x10>)
 133:	ffbab1        	l32r	a11, 1c (ba4 <SBC_Encoder_Init>)
 136:	006322        	s32i	a2, a3, 0
 139:	0002e0        	callx8	a2
 13c:	002322        	l32i	a2, a3, 0
 13f:	ffbba1        	l32r	a10, 2c (10a7 <export_parameter_array+0x27>)
 142:	ffbbb1        	l32r	a11, 30 (4c0 <mSBC_SW_SN_init>)
 145:	0002e0        	callx8	a2
 148:	002322        	l32i	a2, a3, 0
 14b:	ffbaa1        	l32r	a10, 34 (10bd <export_parameter_array+0x3d>)
 14e:	ffb4b1        	l32r	a11, 20 (52c <mSBC_Encoder_Process>)
 151:	0002e0        	callx8	a2
 154:	002322        	l32i	a2, a3, 0
 157:	ffb8a1        	l32r	a10, 38 (10d8 <export_parameter_array+0x58>)
 15a:	ffb8b1        	l32r	a11, 3c (478 <mSBC_SW_SN>)
 15d:	0002e0        	callx8	a2
 160:	ffb821        	l32r	a2, 40 (1080 <export_parameter_array>)
 163:	f01d           	retw.n

00000165 <_start+0x3d>:
 165:	000000                                        ...

00000168 <SbcAnalysisFilter8>:
 168:	00c136        	entry	a1, 96
 16b:	04d232        	addmi	a3, a2, 0x400
 16e:	029d           	mov.n	a9, a2
 170:	232322        	l32i	a2, a3, 140
 173:	2c23c2        	l32i	a12, a3, 176
 176:	9139           	s32i.n	a3, a1, 36
 178:	11f200        	slli	a15, a2, 16
 17b:	8cdd           	ae_sext16	a13, a12
 17d:	021fe6        	bgei	a15, 1, 183 <SbcAnalysisFilter8+0x1b>
 180:	006786        	j	322 <SbcAnalysisFilter8+0x1ba>
 183:	ffb061        	l32r	a6, 44 (10f0 <gas32CoeffFor8SBs>)
 186:	04d932        	addmi	a3, a9, 0x400
 189:	fca142        	movi	a4, 0x1fc
 18c:	e0a152        	movi	a5, 0x1e0
 18f:	80a2f2        	movi	a15, 0x280
 192:	40c9a2        	addi	a10, a9, 64
 195:	282382        	l32i	a8, a3, 160
 198:	822d           	ae_sext16	a2, a2
 19a:	b9fa           	add.n	a11, a9, a15
 19c:	494a           	add.n	a4, a9, a4
 19e:	595a           	add.n	a5, a9, a5
 1a0:	fcc662        	addi	a6, a6, -4
 1a3:	faeb           	addi.n	a15, a10, 14
 1a5:	e129           	s32i.n	a2, a1, 56
 1a7:	11ec00        	slli	a14, a12, 16
 1aa:	070c           	movi.n	a7, 0
 1ac:	b149           	s32i.n	a4, a1, 44
 1ae:	a159           	s32i.n	a5, a1, 40
 1b0:	d169           	s32i.n	a6, a1, 52
 1b2:	c1f9           	s32i.n	a15, a1, 48
 1b4:	4199           	s32i.n	a9, a1, 16
 1b6:	0007c6        	j	1d9 <SbcAnalysisFilter8+0x71>

000001b9 <SbcAnalysisFilter8+0x51>:
 1b9:	000000                                        ...

000001bc <SbcAnalysisFilter8+0x54>:
 1bc:	8178           	l32i.n	a7, a1, 32
 1be:	71b8           	l32i.n	a11, a1, 28
 1c0:	6188           	l32i.n	a8, a1, 24
 1c2:	51a8           	l32i.n	a10, a1, 20
 1c4:	e128           	l32i.n	a2, a1, 56
 1c6:	771b           	addi.n	a7, a7, 1
 1c8:	20cbb2        	addi	a11, a11, 32
 1cb:	11ec00        	slli	a14, a12, 16
 1ce:	8cdd           	ae_sext16	a13, a12
 1d0:	10c882        	addi	a8, a8, 16
 1d3:	022727        	blt	a7, a2, 1d9 <SbcAnalysisFilter8+0x71>
 1d6:	005206        	j	322 <SbcAnalysisFilter8+0x1ba>
 1d9:	90a022        	movi	a2, 144
 1dc:	c148           	l32i.n	a4, a1, 48
 1de:	c052d0        	sub	a5, a2, a13
 1e1:	8179           	s32i.n	a7, a1, 32
 1e3:	031c           	movi.n	a3, 16
 1e5:	857d           	ae_sext16	a7, a5
 1e7:	630b           	addi.n	a6, a3, -1
 1e9:	903740        	addx2	a3, a7, a4
 1ec:	28fd           	ae_l16si.n	a15, a8, 0
 1ee:	63fd           	ae_s16i.n	a15, a3, 0
 1f0:	fec342        	addi	a4, a3, -2
 1f3:	382d           	ae_l16si.n	a2, a8, 2
 1f5:	642d           	ae_s16i.n	a2, a4, 0
 1f7:	fcc3f2        	addi	a15, a3, -4
 1fa:	029842        	l16si	a4, a8, 4
 1fd:	6f4d           	ae_s16i.n	a4, a15, 0
 1ff:	fac372        	addi	a7, a3, -6
 202:	039842        	l16si	a4, a8, 6
 205:	674d           	ae_s16i.n	a4, a7, 0
 207:	f8c3f2        	addi	a15, a3, -8
 20a:	049842        	l16si	a4, a8, 8
 20d:	6f4d           	ae_s16i.n	a4, a15, 0
 20f:	f6c372        	addi	a7, a3, -10
 212:	059842        	l16si	a4, a8, 10
 215:	674d           	ae_s16i.n	a4, a7, 0
 217:	f4c3f2        	addi	a15, a3, -12
 21a:	069842        	l16si	a4, a8, 12
 21d:	6f4d           	ae_s16i.n	a4, a15, 0
 21f:	d148           	l32i.n	a4, a1, 52
 221:	f2c332        	addi	a3, a3, -14
 224:	079822        	l16si	a2, a8, 14
 227:	632d           	ae_s16i.n	a2, a3, 0
 229:	853d           	ae_sext16	a3, a5
 22b:	9023a0        	addx2	a2, a3, a10
 22e:	601414        	ae_lq32f.iu	aeq0, a4, 4
 231:	20c272        	addi	a7, a2, 32
 234:	400204        	ae_lp16f.i	aep0, a2, 0
 237:	f8e03d341f 	{ ae_lq32f.iu	aeq1, a4, 4; ae_mulrfq32sp24s.l	aeq0, aeq0, aep0 }
 23c:	20c7f2        	addi	a15, a7, 32
 23f:	404704        	ae_lp16f.i	aep4, a7, 0
 242:	d4f1bd541f 	{ ae_lq32f.iu	aeq2, a4, 4; ae_mularfq32sp24s.l	aeq0, aeq1, aep4 }
 247:	20cf72        	addi	a7, a15, 32
 24a:	405f04        	ae_lp16f.i	aep5, a15, 0
 24d:	d6f4bd741f 	{ ae_lq32f.iu	aeq3, a4, 4; ae_mularfq32sp24s.l	aeq0, aeq2, aep5 }
 252:	406704        	ae_lp16f.i	aep6, a7, 0
 255:	d6f98207fe 	{ addi	a15, a7, 32; ae_mularfq32sp24s.l	aeq0, aeq3, aep6 }
 25a:	605414        	ae_lq32f.iu	aeq1, a4, 4
 25d:	407f04        	ae_lp16f.i	aep7, a15, 0
 260:	d4fd93399f 	{ or	a3, a9, a9; ae_mularfq32sp24s.l	aeq0, aeq1, aep7 }
 265:	551b           	addi.n	a5, a5, 1
 267:	0a2d           	mov.n	a2, a10
 269:	458676        	loop	a6, 2b2 <SbcAnalysisFilter8+0x14a>
 26c:	856d           	ae_sext16	a6, a5
 26e:	350074        	ae_sraiq56	aeq0, aeq0, 1
 271:	907620        	addx2	a7, a6, a2
 274:	368604        	ae_trunca32q48	a6, aeq0
 277:	0369           	s32i.n	a6, a3, 0
 279:	334b           	addi.n	a3, a3, 4
 27b:	20c762        	addi	a6, a7, 32
 27e:	601414        	ae_lq32f.iu	aeq0, a4, 4
 281:	400704        	ae_lp16f.i	aep0, a7, 0
 284:	f8e002067e 	{ addi	a7, a6, 32; ae_mulrfq32sp24s.l	aeq0, aeq0, aep0 }
 289:	605414        	ae_lq32f.iu	aeq1, a4, 4
 28c:	400604        	ae_lp16f.i	aep0, a6, 0
 28f:	d4e182076e 	{ addi	a6, a7, 32; ae_mularfq32sp24s.l	aeq0, aeq1, aep0 }
 294:	605414        	ae_lq32f.iu	aeq1, a4, 4
 297:	400704        	ae_lp16f.i	aep0, a7, 0
 29a:	d4e182067e 	{ addi	a7, a6, 32; ae_mularfq32sp24s.l	aeq0, aeq1, aep0 }
 29f:	400604        	ae_lp16f.i	aep0, a6, 0
 2a2:	605414        	ae_lq32f.iu	aeq1, a4, 4
 2a5:	d4e1bd341f 	{ ae_lq32f.iu	aeq1, a4, 4; ae_mularfq32sp24s.l	aeq0, aeq1, aep0 }
 2aa:	400704        	ae_lp16f.i	aep0, a7, 0
 2ad:	d4e180155e 	{ addi	a5, a5, 1; ae_mularfq32sp24s.l	aeq0, aeq1, aep0 }

000002b2 <SbcAnalysisFilter8+0x14a>:
 2b2:	5129           	s32i.n	a2, a1, 20
 2b4:	350074        	ae_sraiq56	aeq0, aeq0, 1
 2b7:	ff6421        	l32r	a2, 48 (360 <SBC_FastIDCT8>)
 2ba:	f1c9           	s32i.n	a12, a1, 60
 2bc:	368c04        	ae_trunca32q48	a12, aeq0
 2bf:	09ad           	mov.n	a10, a9
 2c1:	6189           	s32i.n	a8, a1, 24
 2c3:	03c9           	s32i.n	a12, a3, 0
 2c5:	0e6d           	mov.n	a6, a14
 2c7:	207dd0        	or	a7, a13, a13
 2ca:	0761b2        	s32i	a11, a1, 28
 2cd:	0002e0        	callx8	a2
 2d0:	ff5f21        	l32r	a2, 4c (8f0001 <_end+0x8eeae1>)
 2d3:	c78b           	addi.n	a12, a7, 8
 2d5:	4198           	l32i.n	a9, a1, 16
 2d7:	02a627        	bge	a6, a2, 2dd <SbcAnalysisFilter8+0x175>
 2da:	ffb786        	j	1bc <SbcAnalysisFilter8+0x54>
 2dd:	f128           	l32i.n	a2, a1, 60
 2df:	ff5c31        	l32r	a3, 50 (1fffc <_end+0x1eadc>)
 2e2:	a148           	l32i.n	a4, a1, 40
 2e4:	1122f0        	slli	a2, a2, 1
 2e7:	102230        	and	a2, a2, a3
 2ea:	b138           	l32i.n	a3, a1, 44
 2ec:	9f0c           	movi.n	a15, 9
 2ee:	c02420        	sub	a2, a4, a2
 2f1:	1e8f76        	loop	a15, 313 <SbcAnalysisFilter8+0x1ab>
 2f4:	3248           	l32i.n	a4, a2, 12
 2f6:	0349           	s32i.n	a4, a3, 0
 2f8:	f4c342        	addi	a4, a3, -12
 2fb:	f8c352        	addi	a5, a3, -8
 2fe:	fcc362        	addi	a6, a3, -4
 301:	f0c332        	addi	a3, a3, -16
 304:	2278           	l32i.n	a7, a2, 8
 306:	0679           	s32i.n	a7, a6, 0
 308:	1268           	l32i.n	a6, a2, 4
 30a:	0569           	s32i.n	a6, a5, 0
 30c:	0258           	l32i.n	a5, a2, 0
 30e:	f0c222        	addi	a2, a2, -16
 311:	0459           	s32i.n	a5, a4, 0
 313:	4198           	l32i.n	a9, a1, 16
 315:	71b8           	l32i.n	a11, a1, 28
 317:	6188           	l32i.n	a8, a1, 24
 319:	51a8           	l32i.n	a10, a1, 20
 31b:	8178           	l32i.n	a7, a1, 32
 31d:	0c0c           	movi.n	a12, 0
 31f:	ffa846        	j	1c4 <SbcAnalysisFilter8+0x5c>

00000322 <SbcAnalysisFilter8+0x1ba>:
 322:	9128           	l32i.n	a2, a1, 36
 324:	2c62d2        	s32i	a13, a2, 176
 327:	f01d           	retw.n

00000329 <SbcAnalysisFilter8+0x1c1>:
 329:	000000                                        ...

0000032c <SbcAnalysisInit>:
 32c:	004136        	entry	a1, 32
 32f:	70a052        	movi	a5, 112
 332:	024d           	mov.n	a4, a2
 334:	415350        	srli	a5, a5, 3
 337:	00a022        	movi	a2, 0
 33a:	40c432        	addi	a3, a4, 64
 33d:	129576        	loopnez	a5, 353 <SbcAnalysisInit+0x27>
 340:	0329           	s32i.n	a2, a3, 0
 342:	7329           	s32i.n	a2, a3, 28
 344:	6329           	s32i.n	a2, a3, 24
 346:	5329           	s32i.n	a2, a3, 20
 348:	1329           	s32i.n	a2, a3, 4
 34a:	4329           	s32i.n	a2, a3, 16
 34c:	3329           	s32i.n	a2, a3, 12
 34e:	2329           	s32i.n	a2, a3, 8
 350:	20c332        	addi	a3, a3, 32

00000353 <SbcAnalysisInit+0x27>:
 353:	04d422        	addmi	a2, a4, 0x400
 356:	030c           	movi.n	a3, 0
 358:	2c6232        	s32i	a3, a2, 176
 35b:	f01d           	retw.n

0000035d <SbcAnalysisInit+0x31>:
 35d:	000000                                        ...

00000360 <SBC_FastIDCT8>:
 360:	004136        	entry	a1, 32
 363:	ff3c41        	l32r	a4, 54 (12b0 <NEWgas16AnalDCTcoeff8>)
 366:	860c           	movi.n	a6, 8
 368:	fcc222        	addi	a2, a2, -4
 36b:	f8c452        	addi	a5, a4, -8
 36e:	548514        	ae_lp24x2.iu	aep0, a5, 8
 371:	c84030951f 	{ ae_lp24x2.iu	aep1, a5, 8; ae_sllip24	aep0, aep0, 8 }
 376:	cb4430d51f 	{ ae_lp24x2.iu	aep5, a5, 8; ae_sllip24	aep6, aep1, 8 }
 37b:	f60b           	addi.n	a15, a6, -1
 37d:	026d           	mov.n	a6, a2
 37f:	ca547d161f 	{ ae_lq32f.iu	aeq0, a6, 4; ae_sllip24	aep5, aep5, 8 }
 384:	f82030f51f 	{ ae_lp24x2.iu	aep7, a5, 8; ae_mulq32sp16s.h	aeq0, aeq0, aep0 }
 389:	ca5c3d361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_sllip24	aep4, aep7, 8 }
 38e:	f4e3b0951f 	{ ae_lp24x2.iu	aep1, a5, 8; ae_mulaq32sp16s.l	aeq0, aeq1, aep0 }
 393:	c94470a51f 	{ ae_lp24x2.iu	aep2, a5, 8; ae_sllip24	aep3, aep1, 8 }
 398:	c9483d761f 	{ ae_lq32f.iu	aeq3, a6, 4; ae_sllip24	aep2, aep2, 8 }
 39d:	f67bb0f51f 	{ ae_lp24x2.iu	aep7, a5, 8; ae_mulaq32sp16s.h	aeq0, aeq3, aep6 }
 3a2:	c85c70851f 	{ ae_lp24x2.iu	aep0, a5, 8; ae_sllip24	aep1, aep7, 8 }
 3a7:	828f76        	loop	a15, 42d <SBC_FastIDCT8+0xcd>
 3aa:	c84030f51f 	{ ae_lp24x2.iu	aep7, a5, 8; ae_sllip24	aep0, aep0, 8 }
 3af:	cb5c7d361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_sllip24	aep7, aep7, 8 }
 3b4:	f4fbbd361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_mulaq32sp16s.l	aeq0, aeq1, aep6 }
 3b9:	f477bd361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_mulaq32sp16s.h	aeq0, aeq1, aep5 }
 3be:	f4f7bd361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_mulaq32sp16s.l	aeq0, aeq1, aep5 }
 3c3:	f473bd361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_mulaq32sp16s.h	aeq0, aeq1, aep4 }
 3c8:	f4f3bd361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_mulaq32sp16s.l	aeq0, aeq1, aep4 }
 3cd:	f46fbd361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_mulaq32sp16s.h	aeq0, aeq1, aep3 }
 3d2:	f4efb0b51f 	{ ae_lp24x2.iu	aep3, a5, 8; ae_mulaq32sp16s.l	aeq0, aeq1, aep3 }
 3d7:	cb4c3d361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_sllip24	aep6, aep3, 8 }
 3dc:	f46bbd361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_mulaq32sp16s.h	aeq0, aeq1, aep2 }
 3e1:	f4ebbd361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_mulaq32sp16s.l	aeq0, aeq1, aep2 }
 3e6:	f467bd361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_mulaq32sp16s.h	aeq0, aeq1, aep1 }
 3eb:	f4e7bd361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_mulaq32sp16s.l	aeq0, aeq1, aep1 }
 3f0:	f463bd361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_mulaq32sp16s.h	aeq0, aeq1, aep0 }
 3f5:	f4e3b0851f 	{ ae_lp24x2.iu	aep0, a5, 8; ae_mulaq32sp16s.l	aeq0, aeq1, aep0 }
 3fa:	ca4053622f 	{ or	a6, a2, a2; ae_sllip24	aep5, aep0, 8 }
 3ff:	368404        	ae_trunca32q48	a4, aeq0
 402:	0349           	s32i.n	a4, a3, 0
 404:	601614        	ae_lq32f.iu	aeq0, a6, 4
 407:	f83c3d361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_mulq32sp16s.h	aeq0, aeq0, aep7 }
 40c:	f4ffb0851f 	{ ae_lp24x2.iu	aep0, a5, 8; ae_mulaq32sp16s.l	aeq0, aeq1, aep7 }
 411:	ca403d361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_sllip24	aep4, aep0, 8 }
 416:	f47b80433e 	{ addi	a3, a3, 4; ae_mulaq32sp16s.h	aeq0, aeq1, aep6 }
 41b:	548514        	ae_lp24x2.iu	aep0, a5, 8
 41e:	c94070851f 	{ ae_lp24x2.iu	aep0, a5, 8; ae_sllip24	aep3, aep0, 8 }
 423:	c94030851f 	{ ae_lp24x2.iu	aep0, a5, 8; ae_sllip24	aep2, aep0, 8 }
 428:	c84070851f 	{ ae_lp24x2.iu	aep0, a5, 8; ae_sllip24	aep1, aep0, 8 }

0000042d <SBC_FastIDCT8+0xcd>:
 42d:	c8403d361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_sllip24	aep0, aep0, 8 }
 432:	f4fbbd561f 	{ ae_lq32f.iu	aeq2, a6, 4; ae_mulaq32sp16s.l	aeq0, aeq1, aep6 }
 437:	f676bd761f 	{ ae_lq32f.iu	aeq3, a6, 4; ae_mulaq32sp16s.h	aeq0, aeq2, aep5 }
 43c:	f6f7bd561f 	{ ae_lq32f.iu	aeq2, a6, 4; ae_mulaq32sp16s.l	aeq0, aeq3, aep5 }
 441:	f672bd761f 	{ ae_lq32f.iu	aeq3, a6, 4; ae_mulaq32sp16s.h	aeq0, aeq2, aep4 }
 446:	f6f3bd561f 	{ ae_lq32f.iu	aeq2, a6, 4; ae_mulaq32sp16s.l	aeq0, aeq3, aep4 }
 44b:	f66ebd761f 	{ ae_lq32f.iu	aeq3, a6, 4; ae_mulaq32sp16s.h	aeq0, aeq2, aep3 }
 450:	f6efbd561f 	{ ae_lq32f.iu	aeq2, a6, 4; ae_mulaq32sp16s.l	aeq0, aeq3, aep3 }
 455:	f66abd761f 	{ ae_lq32f.iu	aeq3, a6, 4; ae_mulaq32sp16s.h	aeq0, aeq2, aep2 }
 45a:	f6ebbd561f 	{ ae_lq32f.iu	aeq2, a6, 4; ae_mulaq32sp16s.l	aeq0, aeq3, aep2 }
 45f:	f666bd761f 	{ ae_lq32f.iu	aeq3, a6, 4; ae_mulaq32sp16s.h	aeq0, aeq2, aep1 }
 464:	f6e7bd561f 	{ ae_lq32f.iu	aeq2, a6, 4; ae_mulaq32sp16s.l	aeq0, aeq3, aep1 }
 469:	f662bd761f 	{ ae_lq32f.iu	aeq3, a6, 4; ae_mulaq32sp16s.h	aeq0, aeq2, aep0 }
 46e:	0301d4        	ae_mulaq32sp16s.l	aeq0, aeq3, aep0
 471:	368204        	ae_trunca32q48	a2, aeq0
 474:	0329           	s32i.n	a2, a3, 0
 476:	f01d           	retw.n

00000478 <mSBC_SW_SN>:
 478:	004136        	entry	a1, 32
 47b:	434d           	ae_l16ui.n	a4, a3, 0
 47d:	f57c           	movi.n	a5, -1
 47f:	f45050        	extui	a5, a5, 0, 16
 482:	641b           	addi.n	a6, a4, 1
 484:	fdc442        	addi	a4, a4, -3
 487:	934640        	movnez	a4, a6, a4
 48a:	634d           	ae_s16i.n	a4, a3, 0
 48c:	110547        	bnone	a5, a4, 4a1 <mSBC_SW_SN+0x29>
 48f:	943d           	ae_zext16	a3, a4
 491:	172326        	beqi	a3, 2, 4ac <mSBC_SW_SN+0x34>
 494:	1c1366        	bnei	a3, 1, 4b4 <mSBC_SW_SN+0x3c>
 497:	39a632        	movi	a3, 0x639
 49a:	b03330        	addx8	a3, a3, a3
 49d:	623d           	ae_s16i.n	a3, a2, 0
 49f:	f01d           	retw.n

000004a1 <mSBC_SW_SN+0x29>:
 4a1:	aba232        	movi	a3, 0x2ab
 4a4:	903330        	addx2	a3, a3, a3
 4a7:	623d           	ae_s16i.n	a3, a2, 0
 4a9:	f01d           	retw.n

000004ab <mSBC_SW_SN+0x33>:
	...

000004ac <mSBC_SW_SN+0x34>:
 4ac:	feeb31        	l32r	a3, 58 (c801 <_end+0xb2e1>)
 4af:	623d           	ae_s16i.n	a3, a2, 0
 4b1:	f01d           	retw.n

000004b3 <mSBC_SW_SN+0x3b>:
	...

000004b4 <mSBC_SW_SN+0x3c>:
 4b4:	01a832        	movi	a3, 0xfffff801
 4b7:	f43030        	extui	a3, a3, 0, 16
 4ba:	623d           	ae_s16i.n	a3, a2, 0
 4bc:	f01d           	retw.n

000004be <mSBC_SW_SN+0x46>:
	...

000004c0 <mSBC_SW_SN_init>:
 4c0:	004136        	entry	a1, 32
 4c3:	030c           	movi.n	a3, 0
 4c5:	623d           	ae_s16i.n	a3, a2, 0
 4c7:	f01d           	retw.n

000004c9 <mSBC_SW_SN_init+0x9>:
 4c9:	000000                                        ...

000004cc <mybit_pack>:
 4cc:	004136        	entry	a1, 32
 4cf:	0258           	l32i.n	a5, a2, 0
 4d1:	061c           	movi.n	a6, 16
 4d3:	021272        	l16ui	a7, a2, 4
 4d6:	c06650        	sub	a6, a6, a5
 4d9:	10a467        	bge	a4, a6, 4ed <mybit_pack+0x21>
 4dc:	021262        	l16ui	a6, a2, 4
 4df:	401400        	ssl	a4
 4e2:	454a           	add.n	a4, a5, a4
 4e4:	a1f600        	sll	a15, a6
 4e7:	203f30        	or	a3, a15, a3
 4ea:	000d86        	j	524 <mybit_pack+0x58>

000004ed <mybit_pack+0x21>:
 4ed:	c04460        	sub	a4, a4, a6
 4f0:	935d           	ae_zext16	a5, a3
 4f2:	400400        	ssr	a4
 4f5:	915050        	srl	a5, a5
 4f8:	401600        	ssl	a6
 4fb:	a17700        	sll	a7, a7
 4fe:	205750        	or	a5, a7, a5
 501:	32d8           	l32i.n	a13, a2, 12
 503:	fed6e1        	l32r	a14, 5c (14b0 <MASK_bitp>)
 506:	747850        	extui	a7, a5, 8, 8
 509:	8af570        	depbits	a7, a5, 8, 16
 50c:	025252        	s16i	a5, a2, 4
 50f:	6d7d           	ae_s16i.n	a7, a13, 0
 511:	9054e0        	addx2	a5, a4, a14
 514:	22f8           	l32i.n	a15, a2, 8
 516:	255d           	ae_l16si.n	a5, a5, 0
 518:	6d2b           	addi.n	a6, a13, 2
 51a:	7f1b           	addi.n	a7, a15, 1
 51c:	103530        	and	a3, a5, a3
 51f:	3269           	s32i.n	a6, a2, 12
 521:	026272        	s32i	a7, a2, 8
 524:	025232        	s16i	a3, a2, 4
 527:	0249           	s32i.n	a4, a2, 0
 529:	f01d           	retw.n

0000052b <mybit_pack+0x5f>:
	...

0000052c <mSBC_Encoder_Process>:
 52c:	004136        	entry	a1, 32
 52f:	04d452        	addmi	a5, a4, 0x400
 532:	286522        	s32i	a2, a5, 160
 535:	feca21        	l32r	a2, 60 (168 <SbcAnalysisFilter8>)
 538:	070c           	movi.n	a7, 0
 53a:	232562        	l32i	a6, a5, 140
 53d:	04ad           	mov.n	a10, a4
 53f:	296532        	s32i	a3, a5, 164
 542:	2f6572        	s32i	a7, a5, 188
 545:	5c5572        	s16i	a7, a5, 184
 548:	2d6572        	s32i	a7, a5, 180
 54b:	0002e0        	callx8	a2
 54e:	190c           	movi.n	a9, 1
 550:	1a0c           	movi.n	a10, 1
 552:	40a222        	movi	a2, 0x240
 555:	880c           	movi.n	a8, 8
 557:	019990        	slli	a9, a9, 23
 55a:	11aa10        	slli	a10, a10, 15
 55d:	fb0c           	movi.n	a11, 15
 55f:	04dd           	mov.n	a13, a4
 561:	c42a           	add.n	a12, a4, a2
 563:	0003c6        	j	576 <mSBC_Encoder_Process+0x4a>

00000566 <mSBC_Encoder_Process+0x3a>:
 566:	220b           	addi.n	a2, a2, -1
 568:	3c4b           	addi.n	a3, a12, 4
 56a:	880b           	addi.n	a8, a8, -1
 56c:	0c29           	s32i.n	a2, a12, 0
 56e:	737270        	maxu	a7, a2, a7
 571:	03cd           	mov.n	a12, a3
 573:	051816        	beqz	a8, 5c8 <mSBC_Encoder_Process+0x9c>
 576:	040c           	movi.n	a4, 0
 578:	020c           	movi.n	a2, 0
 57a:	3416a6        	blti	a6, 1, 5b2 <mSBC_Encoder_Process+0x86>
 57d:	40cc22        	addi	a2, a12, 64
 580:	040c           	movi.n	a4, 0
 582:	415160        	srli	a5, a6, 1
 585:	0b6607        	bbci	a6, 0, 594 <mSBC_Encoder_Process+0x68>
 588:	002232        	l32i	a3, a2, 0
 58b:	20c222        	addi	a2, a2, 32
 58e:	603130        	abs	a3, a3
 591:	534430        	max	a4, a4, a3
 594:	459c           	beqz.n	a5, 5ac <mSBC_Encoder_Process+0x80>
 596:	129576        	loopnez	a5, 5ac <mSBC_Encoder_Process+0x80>
 599:	0238           	l32i.n	a3, a2, 0
 59b:	8258           	l32i.n	a5, a2, 32
 59d:	40c222        	addi	a2, a2, 64
 5a0:	603130        	abs	a3, a3
 5a3:	605150        	abs	a5, a5
 5a6:	533430        	max	a3, a4, a3
 5a9:	534350        	max	a4, a3, a5

000005ac <mSBC_Encoder_Process+0x80>:
 5ac:	722940        	salt	a2, a9, a4
 5af:	b02220        	addx8	a2, a2, a2
 5b2:	0f8076        	loop	a0, 5c5 <mSBC_Encoder_Process+0x99>
 5b5:	401200        	ssl	a2
 5b8:	a15a00        	sll	a5, a10
 5bb:	023d           	mov.n	a3, a2
 5bd:	221b           	addi.n	a2, a2, 1
 5bf:	a3a547        	bge	a5, a4, 566 <mSBC_Encoder_Process+0x3a>
 5c2:	a0b3b7        	bgeu	a3, a11, 566 <mSBC_Encoder_Process+0x3a>

000005c5 <mSBC_Encoder_Process+0x99>:
 5c5:	fffa46        	j	5b2 <mSBC_Encoder_Process+0x86>

000005c8 <mSBC_Encoder_Process+0x9c>:
 5c8:	fea721        	l32r	a2, 64 (bd8 <sbc_enc_bit_alloc_mono>)
 5cb:	04dd32        	addmi	a3, a13, 0x400
 5ce:	0dad           	mov.n	a10, a13
 5d0:	0d4d           	mov.n	a4, a13
 5d2:	276372        	s32i	a7, a3, 156
 5d5:	0002e0        	callx8	a2
 5d8:	fea421        	l32r	a2, 68 (5ec <EncPacking>)
 5db:	04ad           	mov.n	a10, a4
 5dd:	0002e0        	callx8	a2
 5e0:	040c           	movi.n	a4, 0
 5e2:	2b2322        	l32i	a2, a3, 172
 5e5:	316342        	s32i	a4, a3, 196
 5e8:	f01d           	retw.n

000005ea <mSBC_Encoder_Process+0xbe>:
	...

000005ec <EncPacking>:
 5ec:	008136        	entry	a1, 64
 5ef:	04d232        	addmi	a3, a2, 0x400
 5f2:	02fd           	mov.n	a15, a2
 5f4:	312322        	l32i	a2, a3, 196
 5f7:	2923e2        	l32i	a14, a3, 164
 5fa:	2223c2        	l32i	a12, a3, 136
 5fd:	3063e2        	s32i	a14, a3, 192
 600:	5129           	s32i.n	a2, a1, 20
 602:	e2ac           	beqz.n	a2, 634 <EncPacking+0x48>
 604:	0e7d           	mov.n	a7, a14
 606:	023226        	beqi	a2, 3, 60c <EncPacking+0x20>
 609:	00b746        	j	8ea <EncPacking+0x2fe>
 60c:	2d2342        	l32i	a4, a3, 180
 60f:	fe9381        	l32r	a8, 5c (14b0 <MASK_bitp>)
 612:	04df92        	addmi	a9, a15, 0x400
 615:	0284a6        	blti	a4, 8, 61b <EncPacking+0x2f>
 618:	003b06        	j	708 <EncPacking+0x11c>
 61b:	04df62        	addmi	a6, a15, 0x400
 61e:	5c9622        	l16si	a2, a6, 184
 621:	9ca072        	movi	a7, 156
 624:	548b           	addi.n	a5, a4, 8
 626:	112280        	slli	a2, a2, 8
 629:	227a           	add.n	a2, a2, a7
 62b:	0e7d           	mov.n	a7, a14
 62d:	5c5622        	s16i	a2, a6, 184
 630:	004506        	j	748 <EncPacking+0x15c>

00000633 <EncPacking+0x47>:
	...

00000634 <EncPacking+0x48>:
 634:	2d2342        	l32i	a4, a3, 180
 637:	04df82        	addmi	a8, a15, 0x400
 63a:	021c           	movi.n	a2, 16
 63c:	0284a6        	blti	a4, 8, 642 <EncPacking+0x56>
 63f:	0049c6        	j	76a <EncPacking+0x17e>
 642:	04df22        	addmi	a2, a15, 0x400
 645:	5c9262        	l16si	a6, a2, 184
 648:	ada072        	movi	a7, 173
 64b:	548b           	addi.n	a5, a4, 8
 64d:	11d680        	slli	a13, a6, 8
 650:	4d7a           	add.n	a4, a13, a7
 652:	0e7d           	mov.n	a7, a14
 654:	5c5242        	s16i	a4, a2, 184
 657:	2d6352        	s32i	a5, a3, 180
 65a:	0285e6        	bgei	a5, 8, 660 <EncPacking+0x74>
 65d:	0054c6        	j	7b4 <EncPacking+0x1c8>
 660:	021c           	movi.n	a2, 16
 662:	c02250        	sub	a2, a2, a5
 665:	944d           	ae_zext16	a4, a4
 667:	401200        	ssl	a2
 66a:	ffa082        	movi	a8, 255
 66d:	a12400        	sll	a2, a4
 670:	04df62        	addmi	a6, a15, 0x400
 673:	2f2692        	l32i	a9, a6, 188
 676:	118800        	slli	a8, a8, 16
 679:	114280        	slli	a4, a2, 8
 67c:	108480        	and	a8, a4, a8
 67f:	8b7280        	depbits	a8, a2, 24, 8
 682:	b91b           	addi.n	a11, a9, 1
 684:	d72b           	addi.n	a13, a7, 2
 686:	312080        	srai	a2, a8, 16
 689:	040c           	movi.n	a4, 0
 68b:	672d           	ae_s16i.n	a2, a7, 0
 68d:	f8c552        	addi	a5, a5, -8
 690:	0d7d           	mov.n	a7, a13
 692:	2f66b2        	s32i	a11, a6, 188
 695:	3063d2        	s32i	a13, a3, 192
 698:	5c5642        	s16i	a4, a6, 184
 69b:	2d6352        	s32i	a5, a3, 180
 69e:	0285e6        	bgei	a5, 8, 6a4 <EncPacking+0xb8>
 6a1:	0048c6        	j	7c8 <EncPacking+0x1dc>
 6a4:	021c           	movi.n	a2, 16
 6a6:	c02250        	sub	a2, a2, a5
 6a9:	944d           	ae_zext16	a4, a4
 6ab:	401200        	ssl	a2
 6ae:	ffa082        	movi	a8, 255
 6b1:	a12400        	sll	a2, a4
 6b4:	04df62        	addmi	a6, a15, 0x400
 6b7:	2f2692        	l32i	a9, a6, 188
 6ba:	118800        	slli	a8, a8, 16
 6bd:	114280        	slli	a4, a2, 8
 6c0:	108480        	and	a8, a4, a8
 6c3:	8b7280        	depbits	a8, a2, 24, 8
 6c6:	a91b           	addi.n	a10, a9, 1
 6c8:	b72b           	addi.n	a11, a7, 2
 6ca:	318080        	srai	a8, a8, 16
 6cd:	0d0c           	movi.n	a13, 0
 6cf:	678d           	ae_s16i.n	a8, a7, 0
 6d1:	f8c542        	addi	a4, a5, -8
 6d4:	0b7d           	mov.n	a7, a11
 6d6:	2f66a2        	s32i	a10, a6, 188
 6d9:	3063b2        	s32i	a11, a3, 192
 6dc:	5c56d2        	s16i	a13, a6, 184
 6df:	2d6342        	s32i	a4, a3, 180
 6e2:	0284e6        	bgei	a4, 8, 6e8 <EncPacking+0xfc>
 6e5:	003c86        	j	7db <EncPacking+0x1ef>
 6e8:	04df22        	addmi	a2, a15, 0x400
 6eb:	2f22b2        	l32i	a11, a2, 188
 6ee:	572b           	addi.n	a5, a7, 2
 6f0:	060c           	movi.n	a6, 0
 6f2:	db1b           	addi.n	a13, a11, 1
 6f4:	676d           	ae_s16i.n	a6, a7, 0
 6f6:	f8c442        	addi	a4, a4, -8
 6f9:	057d           	mov.n	a7, a5
 6fb:	306352        	s32i	a5, a3, 192
 6fe:	5c5262        	s16i	a6, a2, 184
 701:	2f62d2        	s32i	a13, a2, 188
 704:	003746        	j	7e5 <EncPacking+0x1f9>

00000707 <EncPacking+0x11b>:
	...

00000708 <EncPacking+0x11c>:
 708:	021c           	movi.n	a2, 16
 70a:	f8c452        	addi	a5, a4, -8
 70d:	5c19d2        	l16ui	a13, a9, 184
 710:	9ca062        	movi	a6, 156
 713:	400500        	ssr	a5
 716:	c02240        	sub	a2, a2, a4
 719:	91a060        	srl	a10, a6
 71c:	401200        	ssl	a2
 71f:	a12d00        	sll	a2, a13
 722:	2022a0        	or	a2, a2, a10
 725:	74a820        	extui	a10, a2, 8, 8
 728:	8af2a0        	depbits	a10, a2, 8, 16
 72b:	5c5922        	s16i	a2, a9, 184
 72e:	2f29b2        	l32i	a11, a9, 188
 731:	6ead           	ae_s16i.n	a10, a14, 0
 733:	90d580        	addx2	a13, a5, a8
 736:	4d4d           	ae_l16ui.n	a4, a13, 0
 738:	2b1b           	addi.n	a2, a11, 1
 73a:	7e2b           	addi.n	a7, a14, 2
 73c:	2f6922        	s32i	a2, a9, 188
 73f:	102460        	and	a2, a4, a6
 742:	306372        	s32i	a7, a3, 192
 745:	5c5922        	s16i	a2, a9, 184
 748:	04df42        	addmi	a4, a15, 0x400
 74b:	2a2442        	l32i	a4, a4, 168
 74e:	926d           	ae_zext16	a6, a2
 750:	2d6352        	s32i	a5, a3, 180
 753:	0285a6        	blti	a5, 8, 759 <EncPacking+0x16d>
 756:	002446        	j	7eb <EncPacking+0x1ff>
 759:	112680        	slli	a2, a6, 8
 75c:	04dfa2        	addmi	a10, a15, 0x400
 75f:	202240        	or	a2, a2, a4
 762:	958b           	addi.n	a9, a5, 8
 764:	5c5a22        	s16i	a2, a10, 184
 767:	003046        	j	82c <EncPacking+0x240>

0000076a <EncPacking+0x17e>:
 76a:	f8c452        	addi	a5, a4, -8
 76d:	5c18d2        	l16ui	a13, a8, 184
 770:	ada062        	movi	a6, 173
 773:	400500        	ssr	a5
 776:	c02240        	sub	a2, a2, a4
 779:	919060        	srl	a9, a6
 77c:	401200        	ssl	a2
 77f:	a12d00        	sll	a2, a13
 782:	202290        	or	a2, a2, a9
 785:	fe35b1        	l32r	a11, 5c (14b0 <MASK_bitp>)
 788:	74a820        	extui	a10, a2, 8, 8
 78b:	8af2a0        	depbits	a10, a2, 8, 16
 78e:	5c5822        	s16i	a2, a8, 184
 791:	2f28d2        	l32i	a13, a8, 188
 794:	6ead           	ae_s16i.n	a10, a14, 0
 796:	9025b0        	addx2	a2, a5, a11
 799:	422d           	ae_l16ui.n	a2, a2, 0
 79b:	4d1b           	addi.n	a4, a13, 1
 79d:	7e2b           	addi.n	a7, a14, 2
 79f:	2f6842        	s32i	a4, a8, 188
 7a2:	104260        	and	a4, a2, a6
 7a5:	306372        	s32i	a7, a3, 192
 7a8:	5c5842        	s16i	a4, a8, 184
 7ab:	2d6352        	s32i	a5, a3, 180
 7ae:	0285a6        	blti	a5, 8, 7b4 <EncPacking+0x1c8>
 7b1:	ffaac6        	j	660 <EncPacking+0x74>
 7b4:	04df22        	addmi	a2, a15, 0x400
 7b7:	114480        	slli	a4, a4, 8
 7ba:	558b           	addi.n	a5, a5, 8
 7bc:	5c5242        	s16i	a4, a2, 184
 7bf:	2d6352        	s32i	a5, a3, 180
 7c2:	0285a6        	blti	a5, 8, 7c8 <EncPacking+0x1dc>
 7c5:	ffb6c6        	j	6a4 <EncPacking+0xb8>
 7c8:	04df22        	addmi	a2, a15, 0x400
 7cb:	060c           	movi.n	a6, 0
 7cd:	458b           	addi.n	a4, a5, 8
 7cf:	5c5262        	s16i	a6, a2, 184
 7d2:	2d6342        	s32i	a4, a3, 180
 7d5:	0284a6        	blti	a4, 8, 7db <EncPacking+0x1ef>
 7d8:	ffc306        	j	6e8 <EncPacking+0xfc>
 7db:	04df22        	addmi	a2, a15, 0x400
 7de:	050c           	movi.n	a5, 0
 7e0:	448b           	addi.n	a4, a4, 8
 7e2:	5c5252        	s16i	a5, a2, 184
 7e5:	2d6342        	s32i	a4, a3, 180
 7e8:	003f86        	j	8ea <EncPacking+0x2fe>

000007eb <EncPacking+0x1ff>:
 7eb:	021c           	movi.n	a2, 16
 7ed:	f8c592        	addi	a9, a5, -8
 7f0:	c02250        	sub	a2, a2, a5
 7f3:	94ad           	ae_zext16	a10, a4
 7f5:	400900        	ssr	a9
 7f8:	91a0a0        	srl	a10, a10
 7fb:	401200        	ssl	a2
 7fe:	a12600        	sll	a2, a6
 801:	2022a0        	or	a2, a2, a10
 804:	74d820        	extui	a13, a2, 8, 8
 807:	04df52        	addmi	a5, a15, 0x400
 80a:	8af2d0        	depbits	a13, a2, 8, 16
 80d:	5c5522        	s16i	a2, a5, 184
 810:	2f25a2        	l32i	a10, a5, 188
 813:	67dd           	ae_s16i.n	a13, a7, 0
 815:	90d980        	addx2	a13, a9, a8
 818:	2d6d           	ae_l16si.n	a6, a13, 0
 81a:	2a1b           	addi.n	a2, a10, 1
 81c:	b72b           	addi.n	a11, a7, 2
 81e:	2f6522        	s32i	a2, a5, 188
 821:	102640        	and	a2, a6, a4
 824:	0b7d           	mov.n	a7, a11
 826:	3063b2        	s32i	a11, a3, 192
 829:	5c5522        	s16i	a2, a5, 184
 82c:	04df42        	addmi	a4, a15, 0x400
 82f:	252442        	l32i	a4, a4, 148
 832:	926d           	ae_zext16	a6, a2
 834:	2d6392        	s32i	a9, a3, 180
 837:	5789e6        	bgei	a9, 8, 892 <EncPacking+0x2a6>
 83a:	116680        	slli	a6, a6, 8
 83d:	04df22        	addmi	a2, a15, 0x400
 840:	204640        	or	a4, a6, a4
 843:	598b           	addi.n	a5, a9, 8
 845:	5c5242        	s16i	a4, a2, 184
 848:	2d6352        	s32i	a5, a3, 180
 84b:	0285e6        	bgei	a5, 8, 851 <EncPacking+0x265>
 84e:	002286        	j	8dc <EncPacking+0x2f0>
 851:	021c           	movi.n	a2, 16
 853:	c02250        	sub	a2, a2, a5
 856:	944d           	ae_zext16	a4, a4
 858:	401200        	ssl	a2
 85b:	a12400        	sll	a2, a4
 85e:	04df82        	addmi	a8, a15, 0x400
 861:	ffa092        	movi	a9, 255
 864:	f8c562        	addi	a6, a5, -8
 867:	115900        	slli	a5, a9, 16
 86a:	114280        	slli	a4, a2, 8
 86d:	2f28a2        	l32i	a10, a8, 188
 870:	104450        	and	a4, a4, a5
 873:	8b7240        	depbits	a4, a2, 24, 8
 876:	2d6362        	s32i	a6, a3, 180
 879:	b72b           	addi.n	a11, a7, 2
 87b:	6a1b           	addi.n	a6, a10, 1
 87d:	312040        	srai	a2, a4, 16
 880:	0d0c           	movi.n	a13, 0
 882:	672d           	ae_s16i.n	a2, a7, 0
 884:	0b7d           	mov.n	a7, a11
 886:	2f6862        	s32i	a6, a8, 188
 889:	3063b2        	s32i	a11, a3, 192
 88c:	5c58d2        	s16i	a13, a8, 184
 88f:	0015c6        	j	8ea <EncPacking+0x2fe>

00000892 <EncPacking+0x2a6>:
 892:	021c           	movi.n	a2, 16
 894:	f8c952        	addi	a5, a9, -8
 897:	c02290        	sub	a2, a2, a9
 89a:	94ad           	ae_zext16	a10, a4
 89c:	400500        	ssr	a5
 89f:	91a0a0        	srl	a10, a10
 8a2:	401200        	ssl	a2
 8a5:	a16600        	sll	a6, a6
 8a8:	2066a0        	or	a6, a6, a10
 8ab:	74a860        	extui	a10, a6, 8, 8
 8ae:	04df92        	addmi	a9, a15, 0x400
 8b1:	8af6a0        	depbits	a10, a6, 8, 16
 8b4:	5c5962        	s16i	a6, a9, 184
 8b7:	908580        	addx2	a8, a5, a8
 8ba:	67ad           	ae_s16i.n	a10, a7, 0
 8bc:	b72b           	addi.n	a11, a7, 2
 8be:	2f29d2        	l32i	a13, a9, 188
 8c1:	287d           	ae_l16si.n	a7, a8, 0
 8c3:	3063b2        	s32i	a11, a3, 192
 8c6:	6d1b           	addi.n	a6, a13, 1
 8c8:	104740        	and	a4, a7, a4
 8cb:	0b7d           	mov.n	a7, a11
 8cd:	2f6962        	s32i	a6, a9, 188
 8d0:	5c5942        	s16i	a4, a9, 184
 8d3:	2d6352        	s32i	a5, a3, 180
 8d6:	0285a6        	blti	a5, 8, 8dc <EncPacking+0x2f0>
 8d9:	ffdd06        	j	851 <EncPacking+0x265>
 8dc:	558b           	addi.n	a5, a5, 8
 8de:	04df22        	addmi	a2, a15, 0x400
 8e1:	114480        	slli	a4, a4, 8
 8e4:	5c5242        	s16i	a4, a2, 184
 8e7:	2d6352        	s32i	a5, a3, 180
 8ea:	40a222        	movi	a2, 0x240
 8ed:	2f2a           	add.n	a2, a15, a2
 8ef:	4129           	s32i.n	a2, a1, 16
 8f1:	21c9           	s32i.n	a12, a1, 8
 8f3:	021ce6        	bgei	a12, 1, 8f9 <EncPacking+0x30d>
 8f6:	002086        	j	97c <EncPacking+0x390>
 8f9:	2128           	l32i.n	a2, a1, 8
 8fb:	fdd8a1        	l32r	a10, 5c (14b0 <MASK_bitp>)
 8fe:	41c8           	l32i.n	a12, a1, 16
 900:	04df82        	addmi	a8, a15, 0x400
 903:	0b0c           	movi.n	a11, 0
 905:	091c           	movi.n	a9, 16
 907:	040c           	movi.n	a4, 0
 909:	6f8276        	loop	a2, 97c <EncPacking+0x390>
 90c:	0c28           	l32i.n	a2, a12, 0
 90e:	3450b0        	extui	a5, a11, 0, 4
 911:	1155c0        	slli	a5, a5, 4
 914:	20b250        	or	a11, a2, a5
 917:	120c           	movi.n	a2, 1
 919:	5b1466        	bnei	a4, 1, 978 <EncPacking+0x38c>
 91c:	2d2352        	l32i	a5, a3, 180
 91f:	7440b0        	extui	a4, a11, 0, 8
 922:	0f85e6        	bgei	a5, 8, 935 <EncPacking+0x349>
 925:	5c9822        	l16si	a2, a8, 184
 928:	658b           	addi.n	a6, a5, 8
 92a:	112280        	slli	a2, a2, 8
 92d:	224a           	add.n	a2, a2, a4
 92f:	5c5822        	s16i	a2, a8, 184
 932:	000f46        	j	973 <EncPacking+0x387>

00000935 <EncPacking+0x349>:
 935:	f8c562        	addi	a6, a5, -8
 938:	c02950        	sub	a2, a9, a5
 93b:	5c1852        	l16ui	a5, a8, 184
 93e:	400600        	ssr	a6
 941:	91d040        	srl	a13, a4
 944:	401200        	ssl	a2
 947:	a15500        	sll	a5, a5
 94a:	2055d0        	or	a5, a5, a13
 94d:	74d850        	extui	a13, a5, 8, 8
 950:	8af5d0        	depbits	a13, a5, 8, 16
 953:	5c5852        	s16i	a5, a8, 184
 956:	67dd           	ae_s16i.n	a13, a7, 0
 958:	90d6a0        	addx2	a13, a6, a10
 95b:	272b           	addi.n	a2, a7, 2
 95d:	2f2852        	l32i	a5, a8, 188
 960:	4d7d           	ae_l16ui.n	a7, a13, 0
 962:	306322        	s32i	a2, a3, 192
 965:	551b           	addi.n	a5, a5, 1
 967:	10d740        	and	a13, a7, a4
 96a:	207220        	or	a7, a2, a2
 96d:	2f6852        	s32i	a5, a8, 188
 970:	5c58d2        	s16i	a13, a8, 184
 973:	020c           	movi.n	a2, 0
 975:	2d6362        	s32i	a6, a3, 180
 978:	cc4b           	addi.n	a12, a12, 4
 97a:	024d           	mov.n	a4, a2

0000097c <EncPacking+0x390>:
 97c:	04df22        	addmi	a2, a15, 0x400
 97f:	232252        	l32i	a5, a2, 140
 982:	61e9           	s32i.n	a14, a1, 24
 984:	31f9           	s32i.n	a15, a1, 12
 986:	0215e6        	bgei	a5, 1, 98c <EncPacking+0x3a0>
 989:	0030c6        	j	a50 <EncPacking+0x464>
 98c:	3148           	l32i.n	a4, a1, 12
 98e:	fdb3e1        	l32r	a14, 5c (14b0 <MASK_bitp>)
 991:	fc7c           	movi.n	a12, -1
 993:	80a222        	movi	a2, 0x280
 996:	04d4a2        	addmi	a10, a4, 0x400
 999:	0b1c           	movi.n	a11, 16
 99b:	f4c0c0        	extui	a12, a12, 0, 16
 99e:	1d0c           	movi.n	a13, 1
 9a0:	f42a           	add.n	a15, a4, a2

000009a2 <EncPacking+0x3b6>:
 9a2:	2128           	l32i.n	a2, a1, 8
 9a4:	550b           	addi.n	a5, a5, -1
 9a6:	7159           	s32i.n	a5, a1, 28
 9a8:	0212e6        	bgei	a2, 1, 9ae <EncPacking+0x3c2>
 9ab:	002646        	j	a48 <EncPacking+0x45c>
 9ae:	2128           	l32i.n	a2, a1, 8
 9b0:	4188           	l32i.n	a8, a1, 16
 9b2:	928276        	loop	a2, a48 <EncPacking+0x45c>
 9b5:	8848           	l32i.n	a4, a8, 32
 9b7:	089416        	beqz	a4, a44 <EncPacking+0x458>
 9ba:	0858           	l32i.n	a5, a8, 0
 9bc:	c02b40        	sub	a2, a11, a4
 9bf:	400200        	ssr	a2
 9c2:	0f68           	l32i.n	a6, a15, 0
 9c4:	95fb           	addi.n	a9, a5, 15
 9c6:	9120c0        	srl	a2, a12
 9c9:	401900        	ssl	a9
 9cc:	a19d00        	sll	a9, a13
 9cf:	112210        	slli	a2, a2, 15
 9d2:	696a           	add.n	a6, a9, a6
 9d4:	400500        	ssr	a5
 9d7:	b29620        	mulsh	a9, a6, a2
 9da:	826620        	mull	a6, a6, a2
 9dd:	2d2352        	l32i	a5, a3, 180
 9e0:	056f60        	extui	a6, a6, 31, 1
 9e3:	906960        	addx2	a6, a9, a6
 9e6:	c02b50        	sub	a2, a11, a5
 9e9:	b16060        	sra	a6, a6
 9ec:	15a427        	bge	a4, a2, a05 <EncPacking+0x419>
 9ef:	5c1a22        	l16ui	a2, a10, 184
 9f2:	401400        	ssl	a4
 9f5:	454a           	add.n	a4, a5, a4
 9f7:	a12200        	sll	a2, a2
 9fa:	202260        	or	a2, a2, a6
 9fd:	5c5a22        	s16i	a2, a10, 184
 a00:	000f46        	j	a41 <EncPacking+0x455>

00000a03 <EncPacking+0x417>:
	...

00000a05 <EncPacking+0x419>:
 a05:	c04420        	sub	a4, a4, a2
 a08:	5c1a92        	l16ui	a9, a10, 184
 a0b:	965d           	ae_zext16	a5, a6
 a0d:	400400        	ssr	a4
 a10:	915050        	srl	a5, a5
 a13:	401200        	ssl	a2
 a16:	a19900        	sll	a9, a9
 a19:	205950        	or	a5, a9, a5
 a1c:	749850        	extui	a9, a5, 8, 8
 a1f:	8af590        	depbits	a9, a5, 8, 16
 a22:	5c5a52        	s16i	a5, a10, 184
 a25:	679d           	ae_s16i.n	a9, a7, 0
 a27:	9094e0        	addx2	a9, a4, a14
 a2a:	272b           	addi.n	a2, a7, 2
 a2c:	2f2a52        	l32i	a5, a10, 188
 a2f:	297d           	ae_l16si.n	a7, a9, 0
 a31:	306322        	s32i	a2, a3, 192
 a34:	551b           	addi.n	a5, a5, 1
 a36:	109760        	and	a9, a7, a6
 a39:	027d           	mov.n	a7, a2
 a3b:	2f6a52        	s32i	a5, a10, 188
 a3e:	5c5a92        	s16i	a9, a10, 184
 a41:	2d6342        	s32i	a4, a3, 180
 a44:	884b           	addi.n	a8, a8, 4
 a46:	ff4b           	addi.n	a15, a15, 4

00000a48 <EncPacking+0x45c>:
 a48:	7158           	l32i.n	a5, a1, 28
 a4a:	0215a6        	blti	a5, 1, a50 <EncPacking+0x464>
 a4d:	ffd446        	j	9a2 <EncPacking+0x3b6>

00000a50 <EncPacking+0x464>:
 a50:	31a8           	l32i.n	a10, a1, 12
 a52:	2d2362        	l32i	a6, a3, 180
 a55:	021c           	movi.n	a2, 16
 a57:	04da52        	addmi	a5, a10, 0x400
 a5a:	2f2592        	l32i	a9, a5, 188
 a5d:	04da42        	addmi	a4, a10, 0x400
 a60:	04daa2        	addmi	a10, a10, 0x400
 a63:	1189f0        	slli	a8, a9, 1
 a66:	2b6582        	s32i	a8, a5, 172
 a69:	56bc           	beqz.n	a6, aa2 <EncPacking+0x4b6>
 a6b:	5c1ae2        	l16ui	a14, a10, 184
 a6e:	c02260        	sub	a2, a2, a6
 a71:	401200        	ssl	a2
 a74:	ffa0b2        	movi	a11, 255
 a77:	a12e00        	sll	a2, a14
 a7a:	881b           	addi.n	a8, a8, 1
 a7c:	11bb00        	slli	a11, a11, 16
 a7f:	11f280        	slli	a15, a2, 8
 a82:	2b6482        	s32i	a8, a4, 172
 a85:	104fb0        	and	a4, a15, a11
 a88:	8b7240        	depbits	a4, a2, 24, 8
 a8b:	991b           	addi.n	a9, a9, 1
 a8d:	c72b           	addi.n	a12, a7, 2
 a8f:	0d0c           	movi.n	a13, 0
 a91:	312040        	srai	a2, a4, 16
 a94:	672d           	ae_s16i.n	a2, a7, 0
 a96:	2f6592        	s32i	a9, a5, 188
 a99:	3063c2        	s32i	a12, a3, 192
 a9c:	2d63d2        	s32i	a13, a3, 180
 a9f:	5c5ad2        	s16i	a13, a10, 184
 aa2:	2148           	l32i.n	a4, a1, 8
 aa4:	61f8           	l32i.n	a15, a1, 24
 aa6:	c27c           	movi.n	a2, -4
 aa8:	fa0c           	movi.n	a10, 15
 aaa:	02a427        	bge	a4, a2, ab0 <EncPacking+0x4c4>
 aad:	003646        	j	b8a <EncPacking+0x59e>
 ab0:	214140        	srai	a4, a4, 1
 ab3:	4f2d           	ae_l16ui.n	a2, a15, 0
 ab5:	150c           	movi.n	a5, 1
 ab7:	443b           	addi.n	a4, a4, 3
 ab9:	534450        	max	a4, a4, a5
 abc:	fa0c           	movi.n	a10, 15
 abe:	070c           	movi.n	a7, 0
 ac0:	a63c           	movi.n	a6, 58
 ac2:	0f9d           	mov.n	a9, a15
 ac4:	415820        	srli	a5, a2, 8
 ac7:	bf8476        	loop	a4, b8a <EncPacking+0x59e>
 aca:	074d           	mov.n	a4, a7
 acc:	771b           	addi.n	a7, a7, 1
 ace:	022466        	bnei	a4, 2, ad4 <EncPacking+0x4e8>
 ad1:	002b46        	j	b82 <EncPacking+0x596>
 ad4:	74b050        	extui	a11, a5, 0, 8
 ad7:	044050        	extui	a4, a5, 0, 1
 ada:	305ab0        	xor	a5, a10, a11
 add:	44c0a0        	extui	a12, a10, 0, 5
 ae0:	11acf0        	slli	a10, a12, 1
 ae3:	04c750        	extui	a12, a5, 7, 1
 ae6:	f0ecc0        	subx8	a14, a12, a12
 ae9:	04d550        	extui	a13, a5, 5, 1
 aec:	045650        	extui	a5, a5, 6, 1
 aef:	a0cec0        	addx4	a12, a14, a12
 af2:	f0edd0        	subx8	a14, a13, a13
 af5:	d15560        	mul16s	a5, a5, a6
 af8:	a0ded0        	addx4	a13, a14, a13
 afb:	30aca0        	xor	a10, a12, a10
 afe:	3055d0        	xor	a5, a5, a13
 b01:	11dae0        	slli	a13, a10, 2
 b04:	04e4b0        	extui	a14, a11, 4, 1
 b07:	41a5a0        	srli	a10, a10, 5
 b0a:	305d50        	xor	a5, a13, a5
 b0d:	30aea0        	xor	a10, a14, a10
 b10:	f0eaa0        	subx8	a14, a10, a10
 b13:	645050        	extui	a5, a5, 0, 7
 b16:	a0aea0        	addx4	a10, a14, a10
 b19:	1155f0        	slli	a5, a5, 1
 b1c:	305a50        	xor	a5, a10, a5
 b1f:	41c3b0        	srli	a12, a11, 3
 b22:	41a750        	srli	a10, a5, 7
 b25:	30aca0        	xor	a10, a12, a10
 b28:	44e050        	extui	a14, a5, 0, 5
 b2b:	41d2b0        	srli	a13, a11, 2
 b2e:	41c650        	srli	a12, a5, 6
 b31:	41b1b0        	srli	a11, a11, 1
 b34:	415550        	srli	a5, a5, 5
 b37:	30cdc0        	xor	a12, a13, a12
 b3a:	305b50        	xor	a5, a11, a5
 b3d:	04a0a0        	extui	a10, a10, 0, 1
 b40:	04d0c0        	extui	a13, a12, 0, 1
 b43:	f0caa0        	subx8	a12, a10, a10
 b46:	045050        	extui	a5, a5, 0, 1
 b49:	d1bd60        	mul16s	a11, a13, a6
 b4c:	f0d550        	subx8	a13, a5, a5
 b4f:	11eef0        	slli	a14, a14, 1
 b52:	a0aca0        	addx4	a10, a12, a10
 b55:	a05d50        	addx4	a5, a13, a5
 b58:	30aae0        	xor	a10, a10, a14
 b5b:	11eae0        	slli	a14, a10, 2
 b5e:	305b50        	xor	a5, a11, a5
 b61:	41a5a0        	srli	a10, a10, 5
 b64:	305e50        	xor	a5, a14, a5
 b67:	304a40        	xor	a4, a10, a4
 b6a:	f0a440        	subx8	a10, a4, a4
 b6d:	645050        	extui	a5, a5, 0, 7
 b70:	a04a40        	addx4	a4, a10, a4
 b73:	1155f0        	slli	a5, a5, 1
 b76:	30a450        	xor	a10, a4, a5
 b79:	05e707        	bbsi	a7, 0, b82 <EncPacking+0x596>
 b7c:	415820        	srli	a5, a2, 8
 b7f:	000146        	j	b88 <EncPacking+0x59c>

00000b82 <EncPacking+0x596>:
 b82:	592d           	ae_l16ui.n	a2, a9, 2
 b84:	992b           	addi.n	a9, a9, 2
 b86:	025d           	mov.n	a5, a2
 b88:	f03d           	nop.n

00000b8a <EncPacking+0x59e>:
 b8a:	5128           	l32i.n	a2, a1, 20
 b8c:	013226        	beqi	a2, 3, b91 <EncPacking+0x5a5>
 b8f:	82cc           	bnez.n	a2, b9b <EncPacking+0x5af>

00000b91 <EncPacking+0x5a5>:
 b91:	3f2d           	ae_l16si.n	a2, a15, 2
 b93:	114a80        	slli	a4, a10, 8
 b96:	202240        	or	a2, a2, a4
 b99:	7f2d           	ae_s16i.n	a2, a15, 2
 b9b:	9028f0        	addx2	a2, a8, a15
 b9e:	296322        	s32i	a2, a3, 164
 ba1:	f01d           	retw.n

00000ba3 <EncPacking+0x5b7>:
	...

00000ba4 <SBC_Encoder_Init>:
 ba4:	004136        	entry	a1, 32
 ba7:	030c           	movi.n	a3, 0
 ba9:	04d252        	addmi	a5, a2, 0x400
 bac:	206532        	s32i	a3, a5, 128
 baf:	216532        	s32i	a3, a5, 132
 bb2:	246532        	s32i	a3, a5, 144
 bb5:	fd2d31        	l32r	a3, 6c (32c <SbcAnalysisInit>)
 bb8:	840c           	movi.n	a4, 8
 bba:	fd0c           	movi.n	a13, 15
 bbc:	ae1c           	movi.n	a14, 26
 bbe:	1f2c           	movi.n	a15, 33
 bc0:	02ad           	mov.n	a10, a2
 bc2:	226542        	s32i	a4, a5, 136
 bc5:	2365d2        	s32i	a13, a5, 140
 bc8:	2565e2        	s32i	a14, a5, 148
 bcb:	2a65f2        	s32i	a15, a5, 168
 bce:	0003e0        	callx8	a3
 bd1:	f01d           	retw.n

00000bd3 <SBC_Encoder_Init+0x2f>:
 bd3:	00000000                                 .....

00000bd8 <sbc_enc_bit_alloc_mono>:
 bd8:	004136        	entry	a1, 32
 bdb:	04d2f2        	addmi	a15, a2, 0x400
 bde:	222fc2        	l32i	a12, a15, 136
 be1:	02bd           	mov.n	a11, a2
 be3:	02d2d2        	addmi	a13, a2, 0x200
 be6:	7e1ca6        	blti	a12, 1, c68 <sbc_enc_bit_alloc_mono+0x90>
 be9:	04db22        	addmi	a2, a11, 0x400
 bec:	202222        	l32i	a2, a2, 128
 bef:	fd2031        	l32r	a3, 70 (1230 <sbc_enc_as16Offset8>)
 bf2:	1142b0        	slli	a4, a2, 5
 bf5:	334a           	add.n	a3, a3, a4
 bf7:	00a022        	movi	a2, 0
 bfa:	204dd0        	or	a4, a13, a13
 bfd:	1d8c76        	loop	a12, c1e <sbc_enc_bit_alloc_mono+0x46>
 c00:	102452        	l32i	a5, a4, 64
 c03:	f58c           	beqz.n	a5, c16 <sbc_enc_bit_alloc_mono+0x3e>
 c05:	0368           	l32i.n	a6, a3, 0
 c07:	c05560        	sub	a5, a5, a6
 c0a:	726250        	salt	a6, a2, a5
 c0d:	400600        	ssr	a6
 c10:	915050        	srl	a5, a5
 c13:	000046        	j	c18 <sbc_enc_bit_alloc_mono+0x40>

00000c16 <sbc_enc_bit_alloc_mono+0x3e>:
 c16:	b57c           	movi.n	a5, -5
 c18:	0459           	s32i.n	a5, a4, 0
 c1a:	444b           	addi.n	a4, a4, 4
 c1c:	334b           	addi.n	a3, a3, 4

00000c1e <sbc_enc_bit_alloc_mono+0x46>:
 c1e:	2450c0        	extui	a5, a12, 0, 3
 c21:	040c           	movi.n	a4, 0
 c23:	203dd0        	or	a3, a13, a13
 c26:	4123c0        	srli	a2, a12, 3
 c29:	069576        	loopnez	a5, c33 <sbc_enc_bit_alloc_mono+0x5b>
 c2c:	0358           	l32i.n	a5, a3, 0
 c2e:	334b           	addi.n	a3, a3, 4
 c30:	534540        	max	a4, a5, a4
 c33:	c2ac           	beqz.n	a2, c63 <sbc_enc_bit_alloc_mono+0x8b>
 c35:	2a9276        	loopnez	a2, c63 <sbc_enc_bit_alloc_mono+0x8b>
 c38:	0368           	l32i.n	a6, a3, 0
 c3a:	7328           	l32i.n	a2, a3, 28
 c3c:	6358           	l32i.n	a5, a3, 24
 c3e:	534640        	max	a4, a6, a4
 c41:	5368           	l32i.n	a6, a3, 20
 c43:	4378           	l32i.n	a7, a3, 16
 c45:	3388           	l32i.n	a8, a3, 12
 c47:	13a8           	l32i.n	a10, a3, 4
 c49:	2398           	l32i.n	a9, a3, 8
 c4b:	20c332        	addi	a3, a3, 32
 c4e:	534a40        	max	a4, a10, a4
 c51:	534940        	max	a4, a9, a4
 c54:	534840        	max	a4, a8, a4
 c57:	534740        	max	a4, a7, a4
 c5a:	534640        	max	a4, a6, a4
 c5d:	534540        	max	a4, a5, a4
 c60:	534240        	max	a4, a2, a4

00000c63 <sbc_enc_bit_alloc_mono+0x8b>:
 c63:	241b           	addi.n	a2, a4, 1
 c65:	000046        	j	c6a <sbc_enc_bit_alloc_mono+0x92>

00000c68 <sbc_enc_bit_alloc_mono+0x90>:
 c68:	120c           	movi.n	a2, 1
 c6a:	04db42        	addmi	a4, a11, 0x400
 c6d:	252442        	l32i	a4, a4, 148
 c70:	603020        	neg	a3, a2
 c73:	060c           	movi.n	a6, 0
 c75:	e50c           	movi.n	a5, 14
 c77:	000846        	j	c9c <sbc_enc_bit_alloc_mono+0xc4>

00000c7a <sbc_enc_bit_alloc_mono+0xa2>:
 c7a:	060c           	movi.n	a6, 0
 c7c:	0d2d           	mov.n	a2, a13
 c7e:	128c76        	loop	a12, c94 <sbc_enc_bit_alloc_mono+0xbc>
 c81:	0278           	l32i.n	a7, a2, 0
 c83:	737a           	add.n	a7, a3, a7
 c85:	093577        	bltu	a5, a7, c92 <sbc_enc_bit_alloc_mono+0xba>
 c88:	478c           	beqz.n	a7, c90 <sbc_enc_bit_alloc_mono+0xb8>
 c8a:	661b           	addi.n	a6, a6, 1
 c8c:	000086        	j	c92 <sbc_enc_bit_alloc_mono+0xba>

00000c8f <sbc_enc_bit_alloc_mono+0xb7>:
	...

00000c90 <sbc_enc_bit_alloc_mono+0xb8>:
 c90:	662b           	addi.n	a6, a6, 2
 c92:	224b           	addi.n	a2, a2, 4

00000c94 <sbc_enc_bit_alloc_mono+0xbc>:
 c94:	c02460        	sub	a2, a4, a6
 c97:	331b           	addi.n	a3, a3, 1
 c99:	0b12a6        	blti	a2, 1, ca8 <sbc_enc_bit_alloc_mono+0xd0>

00000c9c <sbc_enc_bit_alloc_mono+0xc4>:
 c9c:	c04460        	sub	a4, a4, a6
 c9f:	060c           	movi.n	a6, 0
 ca1:	d51ce6        	bgei	a12, 1, c7a <sbc_enc_bit_alloc_mono+0xa2>
 ca4:	fffb06        	j	c94 <sbc_enc_bit_alloc_mono+0xbc>

00000ca7 <sbc_enc_bit_alloc_mono+0xcf>:
	...

00000ca8 <sbc_enc_bit_alloc_mono+0xd0>:
 ca8:	021ce6        	bgei	a12, 1, cae <sbc_enc_bit_alloc_mono+0xd6>
 cab:	002386        	j	d3d <sbc_enc_bit_alloc_mono+0x165>
 cae:	f67c           	movi.n	a6, -1
 cb0:	307360        	xor	a7, a3, a6
 cb3:	605030        	neg	a5, a3
 cb6:	835740        	moveqz	a5, a7, a4
 cb9:	60a2f2        	movi	a15, 0x260
 cbc:	932440        	movnez	a2, a4, a4
 cbf:	3bfa           	add.n	a3, a11, a15
 cc1:	061c           	movi.n	a6, 16
 cc3:	0d4d           	mov.n	a4, a13
 cc5:	752b           	addi.n	a7, a5, 2
 cc7:	168c76        	loop	a12, ce1 <sbc_enc_bit_alloc_mono+0x109>
 cca:	0498           	l32i.n	a9, a4, 0
 ccc:	080c           	movi.n	a8, 0
 cce:	0a2977        	blt	a9, a7, cdc <sbc_enc_bit_alloc_mono+0x104>
 cd1:	c09950        	sub	a9, a9, a5
 cd4:	898d           	ae_sext16	a8, a9
 cd6:	729960        	salt	a9, a9, a6
 cd9:	838690        	moveqz	a8, a6, a9
 cdc:	186482        	s32i	a8, a4, 96
 cdf:	444b           	addi.n	a4, a4, 4

00000ce1 <sbc_enc_bit_alloc_mono+0x109>:
 ce1:	3812a6        	blti	a2, 1, d1d <sbc_enc_bit_alloc_mono+0x145>
 ce4:	451b           	addi.n	a4, a5, 1
 ce6:	050c           	movi.n	a5, 0
 ce8:	d60c           	movi.n	a6, 13
 cea:	2a8076        	loop	a0, d18 <sbc_enc_bit_alloc_mono+0x140>
 ced:	182d72        	l32i	a7, a13, 96
 cf0:	fec782        	addi	a8, a7, -2
 cf3:	063687        	bltu	a6, a8, cfd <sbc_enc_bit_alloc_mono+0x125>
 cf6:	871b           	addi.n	a8, a7, 1
 cf8:	f77c           	movi.n	a7, -1
 cfa:	0002c6        	j	d09 <sbc_enc_bit_alloc_mono+0x131>

00000cfd <sbc_enc_bit_alloc_mono+0x125>:
 cfd:	0d22a6        	blti	a2, 2, d0e <sbc_enc_bit_alloc_mono+0x136>
 d00:	0d78           	l32i.n	a7, a13, 0
 d02:	280c           	movi.n	a8, 2
 d04:	069747        	bne	a7, a4, d0e <sbc_enc_bit_alloc_mono+0x136>
 d07:	e77c           	movi.n	a7, -2
 d09:	227a           	add.n	a2, a2, a7
 d0b:	186d82        	s32i	a8, a13, 96
 d0e:	551b           	addi.n	a5, a5, 1
 d10:	09a5c7        	bge	a5, a12, d1d <sbc_enc_bit_alloc_mono+0x145>
 d13:	dd4b           	addi.n	a13, a13, 4
 d15:	0412a6        	blti	a2, 1, d1d <sbc_enc_bit_alloc_mono+0x145>

00000d18 <sbc_enc_bit_alloc_mono+0x140>:
 d18:	fff386        	j	cea <sbc_enc_bit_alloc_mono+0x112>

00000d1b <sbc_enc_bit_alloc_mono+0x143>:
	...

00000d1d <sbc_enc_bit_alloc_mono+0x145>:
 d1d:	1c12a6        	blti	a2, 1, d3d <sbc_enc_bit_alloc_mono+0x165>
 d20:	040c           	movi.n	a4, 0
 d22:	148076        	loop	a0, d3a <sbc_enc_bit_alloc_mono+0x162>
 d25:	0358           	l32i.n	a5, a3, 0
 d27:	05b5e6        	bgei	a5, 16, d30 <sbc_enc_bit_alloc_mono+0x158>
 d2a:	551b           	addi.n	a5, a5, 1
 d2c:	220b           	addi.n	a2, a2, -1
 d2e:	0359           	s32i.n	a5, a3, 0
 d30:	441b           	addi.n	a4, a4, 1
 d32:	07a4c7        	bge	a4, a12, d3d <sbc_enc_bit_alloc_mono+0x165>
 d35:	334b           	addi.n	a3, a3, 4
 d37:	0212a6        	blti	a2, 1, d3d <sbc_enc_bit_alloc_mono+0x165>

00000d3a <sbc_enc_bit_alloc_mono+0x162>:
 d3a:	fff906        	j	d22 <sbc_enc_bit_alloc_mono+0x14a>

00000d3d <sbc_enc_bit_alloc_mono+0x165>:
 d3d:	f01d           	retw.n

00000d3f <sbc_enc_bit_alloc_mono+0x167>:
	...

00000d40 <__do_global_ctors_aux>:
 d40:	004136        	entry	a1, 32
 d43:	fccc31        	l32r	a3, 74 (1038 <__CTOR_END__>)
 d46:	fcc322        	addi	a2, a3, -4
 d49:	0228           	l32i.n	a2, a2, 0
 d4b:	f8c332        	addi	a3, a3, -8
 d4e:	0a0226        	beqi	a2, -1, d5c <__do_global_ctors_aux+0x1c>

00000d51 <__do_global_ctors_aux+0x11>:
 d51:	0002e0        	callx8	a2
 d54:	0328           	l32i.n	a2, a3, 0
 d56:	fcc332        	addi	a3, a3, -4
 d59:	f40266        	bnei	a2, -1, d51 <__do_global_ctors_aux+0x11>
 d5c:	f01d           	retw.n

00000d5e <__do_global_ctors_aux+0x1e>:
	...

00000d60 <_fini>:
 d60:	008136        	entry	a1, 64
 d63:	fcc581        	l32r	a8, 78 (94 <__do_global_dtors_aux>)
 d66:	f03d           	nop.n
 d68:	0008e0        	callx8	a8

00000d6b <_fini+0xb>:
 d6b:	f01d           	retw.n
