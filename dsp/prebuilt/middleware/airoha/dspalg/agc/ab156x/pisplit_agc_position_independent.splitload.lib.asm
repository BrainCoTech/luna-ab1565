
Build/lib/pisplit_agc_position_independent.splitload.lib:     file format elf32-xtensa-le


Disassembly of section .text:

00000000 <_init-0x54>:
   0:	000000a0 000005ac 000008ac 00000000     ................
  10:	0000087c 00000000 00000894 00000904     |...............
  20:	000008cc 000000e8 000008e2 00000140     ............@...
  30:	000008f4 00000580 000008c0 000005e4     ................
  40:	000005d0 000000f0 00000314 00000884     ................
  50:	0000006c                                l...

00000054 <_init>:
  54:	008136        	entry	a1, 64
  57:	ffea81        	l32r	a8, 0 (a0 <frame_dummy>)
  5a:	f03d           	nop.n
  5c:	0008e0        	callx8	a8
  5f:	ffe981        	l32r	a8, 4 (5ac <__do_global_ctors_aux>)
  62:	f03d           	nop.n
  64:	0008e0        	callx8	a8
  67:	f01d           	retw.n

00000069 <_init+0x15>:
  69:	000000                                        ...

0000006c <__do_global_dtors_aux>:
  6c:	004136        	entry	a1, 32
  6f:	ffe621        	l32r	a2, 8 (8ac <__do_global_dtors_aux.completed>)
  72:	000232        	l8ui	a3, a2, 0
  75:	23ec           	bnez.n	a3, 9b <__do_global_dtors_aux+0x2f>

00000077 <__do_global_dtors_aux+0xb>:
  77:	1248           	l32i.n	a4, a2, 4
  79:	0438           	l32i.n	a3, a4, 0
  7b:	444b           	addi.n	a4, a4, 4
  7d:	738c           	beqz.n	a3, 88 <__do_global_dtors_aux+0x1c>
  7f:	1249           	s32i.n	a4, a2, 4
  81:	0003e0        	callx8	a3
  84:	fffbc6        	j	77 <__do_global_dtors_aux+0xb>

00000087 <__do_global_dtors_aux+0x1b>:
	...

00000088 <__do_global_dtors_aux+0x1c>:
  88:	ffe131        	l32r	a3, c (0 <_text_start>)
  8b:	ffe1a1        	l32r	a10, 10 (87c <__FRAME_END__>)
  8e:	438c           	beqz.n	a3, 96 <__do_global_dtors_aux+0x2a>
  90:	ffdf81        	l32r	a8, c (0 <_text_start>)
  93:	0008e0        	callx8	a8
  96:	130c           	movi.n	a3, 1
  98:	004232        	s8i	a3, a2, 0
  9b:	f01d           	retw.n

0000009d <__do_global_dtors_aux+0x31>:
  9d:	000000                                        ...

000000a0 <frame_dummy>:
  a0:	004136        	entry	a1, 32
  a3:	ffdc21        	l32r	a2, 14 (0 <_text_start>)
  a6:	ffdaa1        	l32r	a10, 10 (87c <__FRAME_END__>)
  a9:	ffdbb1        	l32r	a11, 18 (894 <frame_dummy.object>)
  ac:	428c           	beqz.n	a2, b4 <frame_dummy+0x14>
  ae:	ffd981        	l32r	a8, 14 (0 <_text_start>)
  b1:	0008e0        	callx8	a8

000000b4 <frame_dummy+0x14>:
  b4:	f01d           	retw.n

000000b6 <frame_dummy+0x16>:
	...

000000b8 <_start>:
  b8:	004136        	entry	a1, 32
  bb:	ffd831        	l32r	a3, 1c (904 <printf_ptr>)
  be:	0228           	l32i.n	a2, a2, 0
  c0:	ffd8a1        	l32r	a10, 20 (8cc <export_parameter_array+0xc>)
  c3:	ffd8b1        	l32r	a11, 24 (e8 <get_agc_memsize>)
  c6:	0329           	s32i.n	a2, a3, 0
  c8:	0002e0        	callx8	a2
  cb:	0328           	l32i.n	a2, a3, 0
  cd:	ffd6a1        	l32r	a10, 28 (8e2 <export_parameter_array+0x22>)
  d0:	ffd7b1        	l32r	a11, 2c (140 <AGC_VO_Init>)
  d3:	0002e0        	callx8	a2
  d6:	0328           	l32i.n	a2, a3, 0
  d8:	ffd6a1        	l32r	a10, 30 (8f4 <export_parameter_array+0x34>)
  db:	ffd6b1        	l32r	a11, 34 (580 <AGC_Proc>)
  de:	0002e0        	callx8	a2
  e1:	ffd521        	l32r	a2, 38 (8c0 <export_parameter_array>)
  e4:	f01d           	retw.n

000000e6 <_start+0x2e>:
	...

000000e8 <get_agc_memsize>:
  e8:	004136        	entry	a1, 32
  eb:	28a122        	movi	a2, 0x128
  ee:	f01d           	retw.n

000000f0 <AGC_Xdiv>:
  f0:	004136        	entry	a1, 32
  f3:	0258           	l32i.n	a5, a2, 0
  f5:	0348           	l32i.n	a4, a3, 0
  f7:	ffa062        	movi	a6, 255
  fa:	e5ac           	beqz.n	a5, 12c <AGC_Xdiv+0x3c>
  fc:	64bc           	beqz.n	a4, 136 <AGC_Xdiv+0x46>
  fe:	600204        	ae_lq32f.i	aeq0, a2, 0
 101:	604304        	ae_lq32f.i	aeq1, a3, 0
 104:	364204        	ae_nsaq56s	a2, aeq0
 107:	365304        	ae_nsaq56s	a3, aeq1
 10a:	432230        	min	a2, a2, a3
 10d:	e9c232        	addi	a3, a2, -23
 110:	fc24fe934f 	{ ae_slaasq56s	aeq1, aeq1, a3; nop }
 115:	369304        	ae_trunca32q48	a3, aeq1
 118:	f8c222        	addi	a2, a2, -8
 11b:	f39c           	beqz.n	a3, 13e <AGC_Xdiv+0x4e>
 11d:	fc24fe820f 	{ ae_slaasq56s	aeq0, aeq0, a2; nop }
 122:	368204        	ae_trunca32q48	a2, aeq0
 125:	d22230        	quos	a2, a2, a3
 128:	a22d           	ae_clamps16	a2, a2
 12a:	f01d           	retw.n

0000012c <AGC_Xdiv+0x3c>:
 12c:	7fd622        	addmi	a2, a6, 0x7f00
 12f:	030c           	movi.n	a3, 0
 131:	932340        	movnez	a2, a3, a4
 134:	f01d           	retw.n

00000136 <AGC_Xdiv+0x46>:
 136:	ffa022        	movi	a2, 255
 139:	7fd222        	addmi	a2, a2, 0x7f00
 13c:	f01d           	retw.n

0000013e <AGC_Xdiv+0x4e>:
 13e:	f01d           	retw.n

00000140 <AGC_VO_Init>:
 140:	00a136        	entry	a1, 80
 143:	ffbe61        	l32r	a6, 3c (5e4 <xt_memcpy>)
 146:	6c2c           	movi.n	a12, 38
 148:	02ad           	mov.n	a10, a2
 14a:	03bd           	mov.n	a11, a3
 14c:	50c252        	addi	a5, a2, 80
 14f:	0006e0        	callx8	a6
 152:	ffbb31        	l32r	a3, 40 (5d0 <xt_memset>)
 155:	0b0c           	movi.n	a11, 0
 157:	6ca0c2        	movi	a12, 108
 15a:	05ad           	mov.n	a10, a5
 15c:	0003e0        	callx8	a3
 15f:	080282        	l8ui	a8, a2, 8
 162:	0902c2        	l8ui	a12, a2, 9
 165:	0b0232        	l8ui	a3, a2, 11
 168:	0f0252        	l8ui	a5, a2, 15
 16b:	5139           	s32i.n	a3, a1, 20
 16d:	3159           	s32i.n	a5, a1, 12
 16f:	b5a152        	movi	a5, 0x1b5
 172:	8a7c80        	depbits	a8, a12, 8, 8
 175:	b189           	s32i.n	a8, a1, 44
 177:	0a0292        	l8ui	a9, a2, 10
 17a:	5188           	l32i.n	a8, a1, 20
 17c:	440b           	addi.n	a4, a4, -1
 17e:	a05550        	addx4	a5, a5, a5
 181:	44a472        	movi	a7, 0x444
 184:	937540        	movnez	a7, a5, a4
 187:	0d02f2        	l8ui	a15, a2, 13
 18a:	a179           	s32i.n	a7, a1, 40
 18c:	1002d2        	l8ui	a13, a2, 16
 18f:	110272        	l8ui	a7, a2, 17
 192:	8a7890        	depbits	a9, a8, 8, 8
 195:	41f9           	s32i.n	a15, a1, 16
 197:	0e02b2        	l8ui	a11, a2, 14
 19a:	31c8           	l32i.n	a12, a1, 12
 19c:	fe0c           	movi.n	a14, 15
 19e:	ef1c           	movi.n	a15, 30
 1a0:	93fe40        	movnez	a15, a14, a4
 1a3:	9199           	s32i.n	a9, a1, 36
 1a5:	0c02a2        	l8ui	a10, a2, 12
 1a8:	4198           	l32i.n	a9, a1, 16
 1aa:	8a77d0        	depbits	a13, a7, 8, 8
 1ad:	9252f2        	s16i	a15, a2, 0x124
 1b0:	140232        	l8ui	a3, a2, 20
 1b3:	1502f2        	l8ui	a15, a2, 21
 1b6:	8a7cb0        	depbits	a11, a12, 8, 8
 1b9:	000262        	l8ui	a6, a2, 0
 1bc:	31d9           	s32i.n	a13, a1, 12
 1be:	1802c2        	l8ui	a12, a2, 24
 1c1:	1902d2        	l8ui	a13, a2, 25
 1c4:	8a79a0        	depbits	a10, a9, 8, 8
 1c7:	285262        	s16i	a6, a2, 80
 1ca:	1202e2        	l8ui	a14, a2, 18
 1cd:	130262        	l8ui	a6, a2, 19
 1d0:	8a7f30        	depbits	a3, a15, 8, 8
 1d3:	41a9           	s32i.n	a10, a1, 16
 1d5:	160242        	l8ui	a4, a2, 22
 1d8:	1702a2        	l8ui	a10, a2, 23
 1db:	8a7dc0        	depbits	a12, a13, 8, 8
 1de:	81b9           	s32i.n	a11, a1, 32
 1e0:	5139           	s32i.n	a3, a1, 20
 1e2:	200272        	l8ui	a7, a2, 32
 1e5:	2102b2        	l8ui	a11, a2, 33
 1e8:	2202d2        	l8ui	a13, a2, 34
 1eb:	230232        	l8ui	a3, a2, 35
 1ee:	8a76e0        	depbits	a14, a6, 8, 8
 1f1:	1a0262        	l8ui	a6, a2, 26
 1f4:	1b0282        	l8ui	a8, a2, 27
 1f7:	1c0252        	l8ui	a5, a2, 28
 1fa:	1d0292        	l8ui	a9, a2, 29
 1fd:	8a7a40        	depbits	a4, a10, 8, 8
 200:	1e02f2        	l8ui	a15, a2, 30
 203:	1f02a2        	l8ui	a10, a2, 31
 206:	8a73d0        	depbits	a13, a3, 8, 8
 209:	8a7b70        	depbits	a7, a11, 8, 8
 20c:	2602b2        	l8ui	a11, a2, 38
 20f:	270232        	l8ui	a3, a2, 39
 212:	8a7860        	depbits	a6, a8, 8, 8
 215:	8a7950        	depbits	a5, a9, 8, 8
 218:	240282        	l8ui	a8, a2, 36
 21b:	250292        	l8ui	a9, a2, 37
 21e:	8a7af0        	depbits	a15, a10, 8, 8
 221:	2902a2        	l8ui	a10, a2, 41
 224:	8a73b0        	depbits	a11, a3, 8, 8
 227:	61a9           	s32i.n	a10, a1, 24
 229:	2b0232        	l8ui	a3, a2, 43
 22c:	8a7980        	depbits	a8, a9, 8, 8
 22f:	7139           	s32i.n	a3, a1, 28
 231:	280292        	l8ui	a9, a2, 40
 234:	6138           	l32i.n	a3, a1, 24
 236:	2a02a2        	l8ui	a10, a2, 42
 239:	335262        	s16i	a6, a2, 102
 23c:	8a7390        	depbits	a9, a3, 8, 8
 23f:	7138           	l32i.n	a3, a1, 28
 241:	3252c2        	s16i	a12, a2, 100
 244:	315242        	s16i	a4, a2, 98
 247:	8a73a0        	depbits	a10, a3, 8, 8
 24a:	a138           	l32i.n	a3, a1, 40
 24c:	935232        	s16i	a3, a2, 0x126
 24f:	020232        	l8ui	a3, a2, 2
 252:	11ff00        	slli	a15, a15, 16
 255:	5f5a           	add.n	a5, a15, a5
 257:	046130        	extui	a6, a3, 1, 1
 25a:	3c5262        	s16i	a6, a2, 120
 25d:	04c030        	extui	a12, a3, 0, 1
 260:	9168           	l32i.n	a6, a1, 36
 262:	3d52c2        	s16i	a12, a2, 122
 265:	b1c8           	l32i.n	a12, a1, 44
 267:	114600        	slli	a4, a6, 16
 26a:	11dd00        	slli	a13, a13, 16
 26d:	44ca           	add.n	a4, a4, a12
 26f:	81c8           	l32i.n	a12, a1, 32
 271:	11bb00        	slli	a11, a11, 16
 274:	11aa00        	slli	a10, a10, 16
 277:	116c00        	slli	a6, a12, 16
 27a:	41c8           	l32i.n	a12, a1, 16
 27c:	1a6252        	s32i	a5, a2, 104
 27f:	5158           	l32i.n	a5, a1, 20
 281:	66ca           	add.n	a6, a6, a12
 283:	11ce00        	slli	a12, a14, 16
 286:	31e8           	l32i.n	a14, a1, 12
 288:	7d7a           	add.n	a7, a13, a7
 28a:	8b8a           	add.n	a8, a11, a8
 28c:	ccea           	add.n	a12, a12, a14
 28e:	9a9a           	add.n	a9, a10, a9
 290:	1f0c           	movi.n	a15, 1
 292:	156242        	s32i	a4, a2, 84
 295:	166262        	s32i	a6, a2, 88
 298:	1762c2        	s32i	a12, a2, 92
 29b:	305252        	s16i	a5, a2, 96
 29e:	1b6272        	s32i	a7, a2, 108
 2a1:	1c6282        	s32i	a8, a2, 112
 2a4:	1d6292        	s32i	a9, a2, 116
 2a7:	1ed3f7        	bbs	a3, a15, 2c9 <AGC_VO_Init+0x189>
 2aa:	050232        	l8ui	a3, a2, 5
 2ad:	040252        	l8ui	a5, a2, 4
 2b0:	840c           	movi.n	a4, 8
 2b2:	233300        	sext	a3, a3, 7
 2b5:	113380        	slli	a3, a3, 8
 2b8:	0a7530        	depbits	a3, a5, 0, 8
 2bb:	1f1c           	movi.n	a15, 17
 2bd:	3e5242        	s16i	a4, a2, 124
 2c0:	295232        	s16i	a3, a2, 82
 2c3:	12a3f7        	bge	a3, a15, 2d9 <AGC_VO_Init+0x199>
 2c6:	000446        	j	2db <AGC_VO_Init+0x19b>

000002c9 <AGC_VO_Init+0x189>:
 2c9:	034c           	movi.n	a3, 64
 2cb:	840c           	movi.n	a4, 8
 2cd:	315252        	s16i	a5, a2, 98
 2d0:	325252        	s16i	a5, a2, 100
 2d3:	295232        	s16i	a3, a2, 82
 2d6:	3e5242        	s16i	a4, a2, 124
 2d9:	041c           	movi.n	a4, 16
 2db:	052c           	movi.n	a5, 32
 2dd:	0c3c           	movi.n	a12, 48
 2df:	861c           	movi.n	a6, 24
 2e1:	727530        	salt	a7, a5, a3
 2e4:	836470        	moveqz	a6, a4, a7
 2e7:	1d0c           	movi.n	a13, 1
 2e9:	72ec30        	salt	a14, a12, a3
 2ec:	1f0c           	movi.n	a15, 1
 2ee:	017d50        	slli	a7, a13, 27
 2f1:	114f00        	slli	a4, a15, 16
 2f4:	9365e0        	movnez	a6, a5, a14
 2f7:	446272        	s32i	a7, a2, 0x110
 2fa:	456272        	s32i	a7, a2, 0x114
 2fd:	436272        	s32i	a7, a2, 0x10c
 300:	466272        	s32i	a7, a2, 0x118
 303:	476272        	s32i	a7, a2, 0x11c
 306:	216272        	s32i	a7, a2, 132
 309:	486242        	s32i	a4, a2, 0x120
 30c:	3e5262        	s16i	a6, a2, 124
 30f:	f01d           	retw.n

00000311 <AGC_VO_Init+0x1d1>:
 311:	000000                                        ...

00000314 <agc_block_proc>:
 314:	006136        	entry	a1, 48
 317:	181252        	l16ui	a5, a2, 48
 31a:	b5cc           	bnez.n	a5, 329 <agc_block_proc+0x15>
 31c:	948c           	beqz.n	a4, 329 <agc_block_proc+0x15>
 31e:	140c           	movi.n	a4, 1
 320:	185242        	s16i	a4, a2, 48
 323:	175242        	s16i	a4, a2, 46
 326:	000686        	j	344 <agc_block_proc+0x30>

00000329 <agc_block_proc+0x15>:
 329:	050c           	movi.n	a5, 0
 32b:	34cc           	bnez.n	a4, 332 <agc_block_proc+0x1e>
 32d:	199242        	l16si	a4, a2, 50
 330:	541b           	addi.n	a5, a4, 1
 332:	0b9242        	l16si	a4, a2, 22
 335:	856d           	ae_sext16	a6, a5
 337:	195252        	s16i	a5, a2, 50
 33a:	06a467        	bge	a4, a6, 344 <agc_block_proc+0x30>
 33d:	040c           	movi.n	a4, 0
 33f:	175242        	s16i	a4, a2, 46
 342:	c249           	s32i.n	a4, a2, 48
 344:	151242        	l16ui	a4, a2, 42
 347:	fec332        	addi	a3, a3, -2
 34a:	171252        	l16ui	a5, a2, 46
 34d:	448c           	beqz.n	a4, 355 <agc_block_proc+0x41>
 34f:	6a1242        	l16ui	a4, a2, 212
 352:	0fa516        	beqz	a5, 450 <agc_block_proc+0x13c>
 355:	6a1262        	l16ui	a6, a2, 212
 358:	fc2480d65f 	{ movi	a5, 214; ae_zeroq56	aeq0 }
 35d:	07c804        	ae_zerop48	aep0
 360:	864d           	ae_sext16	a4, a6
 362:	1314a6        	blti	a4, 1, 379 <agc_block_proc+0x65>
 365:	411254        	ae_lp16f.x	aep1, a2, a5
 368:	035d           	mov.n	a5, a3
 36a:	0b8676        	loop	a6, 379 <agc_block_proc+0x65>
 36d:	40a514        	ae_lp16f.iu	aep2, a5, 2
 370:	079a24        	ae_abssp24s	aep2, aep2
 373:	011204        	ae_mulafp24s.hh	aeq0, aep1, aep2
 376:	070a04        	ae_maxp24s	aep0, aep0, aep2

00000379 <agc_block_proc+0x65>:
 379:	fc2443825e 	{ addi	a5, a2, 56; ae_roundsq32asym	aeq0, aeq0 }
 37e:	ff0c3d250f 	{ ae_lq32f.i	aeq1, a5, 0; ae_cvtq48p24s.l	aeq3, aep0 }
 383:	f846b0827e 	{ l32i	a7, a2, 32; ae_subsq56s	aeq0, aeq0, aeq1 }
 388:	3500f4        	ae_sraiq56	aeq0, aeq0, 3
 38b:	fc2479b13f 	{ ae_sq32f.i	aeq3, a1, 12; ae_roundsq32asym	aeq0, aeq0 }
 390:	f86a61629e 	{ l16si	a9, a2, 44; ae_addsq56s	aeq0, aeq1, aeq0 }
 395:	620504        	ae_sq32f.i	aeq0, a5, 0
 398:	e258           	l32i.n	a5, a2, 56
 39a:	691282        	l16ui	a8, a2, 210
 39d:	526d           	ae_l16ui.n	a6, a2, 2
 39f:	1ea577        	bge	a5, a7, 3c1 <agc_block_proc+0xad>
 3a2:	141262        	l16ui	a6, a2, 40
 3a5:	9278           	l32i.n	a7, a2, 36
 3a7:	17e656        	bnez	a6, 529 <agc_block_proc+0x215>
 3aa:	022577        	blt	a5, a7, 3b0 <agc_block_proc+0x9c>
 3ad:	005e06        	j	529 <agc_block_proc+0x215>
 3b0:	150c           	movi.n	a5, 1
 3b2:	015550        	slli	a5, a5, 27
 3b5:	2f6252        	s32i	a5, a2, 188
 3b8:	336252        	s32i	a5, a2, 204
 3bb:	326252        	s32i	a5, a2, 200
 3be:	0059c6        	j	529 <agc_block_proc+0x215>

000003c1 <agc_block_proc+0xad>:
 3c1:	085d           	mov.n	a5, a8
 3c3:	021867        	beq	a8, a6, 3c9 <agc_block_proc+0xb5>
 3c6:	002246        	j	453 <agc_block_proc+0x13f>
 3c9:	169252        	l16si	a5, a2, 44
 3cc:	f278           	l32i.n	a7, a2, 60
 3ce:	160c           	movi.n	a6, 1
 3d0:	695262        	s16i	a6, a2, 210
 3d3:	fa7c           	movi.n	a10, -1
 3d5:	fd7c           	movi.n	a13, -1
 3d7:	f67c           	movi.n	a6, -1
 3d9:	4125a6        	blti	a5, 2, 41e <agc_block_proc+0x10a>
 3dc:	a50b           	addi.n	a10, a5, -1
 3de:	40c282        	addi	a8, a2, 64
 3e1:	f67c           	movi.n	a6, -1
 3e3:	f97c           	movi.n	a9, -1
 3e5:	fb7c           	movi.n	a11, -1
 3e7:	07cd           	mov.n	a12, a7
 3e9:	318a76        	loop	a10, 41e <agc_block_proc+0x10a>
 3ec:	08e8           	l32i.n	a14, a8, 0
 3ee:	0cad           	mov.n	a10, a12
 3f0:	0bdd           	mov.n	a13, a11
 3f2:	0e7d           	mov.n	a7, a14
 3f4:	1c2ce7        	blt	a12, a14, 414 <agc_block_proc+0x100>
 3f7:	0c7d           	mov.n	a7, a12
 3f9:	0ead           	mov.n	a10, a14
 3fb:	0bdd           	mov.n	a13, a11
 3fd:	132be7        	blt	a11, a14, 414 <agc_block_proc+0x100>
 400:	0c7d           	mov.n	a7, a12
 402:	0bad           	mov.n	a10, a11
 404:	0edd           	mov.n	a13, a14
 406:	0a29e7        	blt	a9, a14, 414 <agc_block_proc+0x100>
 409:	536e60        	max	a6, a14, a6
 40c:	09dd           	mov.n	a13, a9
 40e:	0c7d           	mov.n	a7, a12
 410:	0bad           	mov.n	a10, a11
 412:	069d           	mov.n	a9, a6
 414:	096d           	mov.n	a6, a9
 416:	884b           	addi.n	a8, a8, 4
 418:	0d9d           	mov.n	a9, a13
 41a:	0abd           	mov.n	a11, a10
 41c:	07cd           	mov.n	a12, a7

0000041e <agc_block_proc+0x10a>:
 41e:	2182a0        	srai	a8, a10, 2
 421:	2192d0        	srai	a9, a13, 2
 424:	21f260        	srai	a15, a6, 2
 427:	889a           	add.n	a8, a8, a9
 429:	217270        	srai	a7, a7, 2
 42c:	88fa           	add.n	a8, a8, a15
 42e:	778a           	add.n	a7, a7, a8
 430:	650b           	addi.n	a6, a5, -1
 432:	d279           	s32i.n	a7, a2, 52
 434:	0e25a6        	blti	a5, 2, 446 <agc_block_proc+0x132>
 437:	40c252        	addi	a5, a2, 64
 43a:	088676        	loop	a6, 446 <agc_block_proc+0x132>
 43d:	0578           	l32i.n	a7, a5, 0
 43f:	fcc582        	addi	a8, a5, -4
 442:	554b           	addi.n	a5, a5, 4
 444:	0879           	s32i.n	a7, a8, 0
 446:	3158           	l32i.n	a5, a1, 12
 448:	a06620        	addx4	a6, a6, a2
 44b:	f659           	s32i.n	a5, a6, 60
 44d:	0004c6        	j	464 <agc_block_proc+0x150>

00000450 <agc_block_proc+0x13c>:
 450:	003546        	j	529 <agc_block_proc+0x215>

00000453 <agc_block_proc+0x13f>:
 453:	751b           	addi.n	a7, a5, 1
 455:	3158           	l32i.n	a5, a1, 12
 457:	a06920        	addx4	a6, a9, a2
 45a:	e688           	l32i.n	a8, a6, 56
 45c:	695272        	s16i	a7, a2, 210
 45f:	01a857        	bge	a8, a5, 464 <agc_block_proc+0x150>
 462:	e659           	s32i.n	a5, a6, 56
 464:	302252        	l32i	a5, a2, 192
 467:	316252        	s32i	a5, a2, 196
 46a:	fef651        	l32r	a5, 44 (f0 <AGC_Xdiv>)
 46d:	a24b           	addi.n	a10, a2, 4
 46f:	34c2b2        	addi	a11, a2, 52
 472:	0005e0        	callx8	a5
 475:	332252        	l32i	a5, a2, 204
 478:	117a00        	slli	a7, a10, 16
 47b:	360534        	ae_cvtq48a32s	aeq0, a5
 47e:	c06750        	sub	a6, a7, a5
 481:	1916a6        	blti	a6, 1, 49e <agc_block_proc+0x18a>
 484:	14c252        	addi	a5, a2, 20
 487:	364634        	ae_cvtq48a32s	aeq1, a6
 48a:	400504        	ae_lp16f.i	aep0, a5, 0
 48d:	f483b022fe 	{ l32i	a15, a2, 8; ae_mulafq32sp16s.l	aeq0, aeq1, aep0 }
 492:	060934        	ae_roundsq32asym	aeq0, aeq0
 495:	368804        	ae_trunca32q48	a8, aeq0
 498:	4358f0        	min	a5, a8, a15
 49b:	000586        	j	4b5 <agc_block_proc+0x1a1>

0000049e <agc_block_proc+0x18a>:
 49e:	12c252        	addi	a5, a2, 18
 4a1:	364634        	ae_cvtq48a32s	aeq1, a6
 4a4:	400504        	ae_lp16f.i	aep0, a5, 0
 4a7:	f483b032fe 	{ l32i	a15, a2, 12; ae_mulafq32sp16s.l	aeq0, aeq1, aep0 }
 4ac:	060934        	ae_roundsq32asym	aeq0, aeq0
 4af:	368804        	ae_trunca32q48	a8, aeq0
 4b2:	5358f0        	max	a5, a8, a15
 4b5:	141282        	l16ui	a8, a2, 40
 4b8:	336252        	s32i	a5, a2, 204
 4bb:	322292        	l32i	a9, a2, 200
 4be:	5e1826        	beqi	a8, 1, 520 <agc_block_proc+0x20c>
 4c1:	360934        	ae_cvtq48a32s	aeq0, a9
 4c4:	c08790        	sub	a8, a7, a9
 4c7:	1618a6        	blti	a8, 1, 4e1 <agc_block_proc+0x1cd>
 4ca:	500264        	ae_lp24f.i	aep0, a2, 24
 4cd:	f88030227e 	{ l32i	a7, a2, 8; ae_mulfq32sp24s.l	aeq0, aeq0, aep0 }
 4d2:	350054        	ae_slliq56	aeq0, aeq0, 1
 4d5:	060934        	ae_roundsq32asym	aeq0, aeq0
 4d8:	368904        	ae_trunca32q48	a9, aeq0
 4db:	437970        	min	a7, a9, a7
 4de:	0004c6        	j	4f5 <agc_block_proc+0x1e1>

000004e1 <agc_block_proc+0x1cd>:
 4e1:	500274        	ae_lp24f.i	aep0, a2, 28
 4e4:	f88030327e 	{ l32i	a7, a2, 12; ae_mulfq32sp24s.l	aeq0, aeq0, aep0 }
 4e9:	350054        	ae_slliq56	aeq0, aeq0, 1
 4ec:	060934        	ae_roundsq32asym	aeq0, aeq0
 4ef:	368904        	ae_trunca32q48	a9, aeq0
 4f2:	537970        	max	a7, a9, a7
 4f5:	609160        	abs	a9, a6
 4f8:	689262        	l16si	a6, a2, 208
 4fb:	608180        	abs	a8, a8
 4fe:	326272        	s32i	a7, a2, 200
 501:	07a987        	bge	a9, a8, 50c <agc_block_proc+0x1f8>
 504:	180c           	movi.n	a8, 1
 506:	0cb6a6        	blti	a6, 16, 516 <agc_block_proc+0x202>
 509:	0004c6        	j	520 <agc_block_proc+0x20c>

0000050c <agc_block_proc+0x1f8>:
 50c:	187c           	movi.n	a8, -15
 50e:	142687        	blt	a6, a8, 526 <agc_block_proc+0x212>
 511:	f87c           	movi.n	a8, -1
 513:	f48080        	extui	a8, a8, 0, 16
 516:	668a           	add.n	a6, a6, a8
 518:	868d           	ae_sext16	a8, a6
 51a:	685262        	s16i	a6, a2, 208
 51d:	0518a6        	blti	a8, 1, 526 <agc_block_proc+0x212>
 520:	2f6252        	s32i	a5, a2, 188
 523:	000086        	j	529 <agc_block_proc+0x215>

00000526 <agc_block_proc+0x212>:
 526:	2f6272        	s32i	a7, a2, 188
 529:	c0a052        	movi	a5, 192
 52c:	2f22d2        	l32i	a13, a2, 188
 52f:	10c2e2        	addi	a14, a2, 16
 532:	602254        	ae_lq32f.x	aeq0, a2, a5
 535:	364d34        	ae_cvtq48a32s	aeq1, a13
 538:	f94aac0e0f 	{ ae_lp16f.i	aep0, a14, 0; ae_subsq56s	aeq1, aeq1, aeq0 }
 53d:	f483b3126e 	{ l32i	a6, a2, 196; ae_mulafq32sp16s.l	aeq0, aeq1, aep0 }
 542:	844d           	ae_sext16	a4, a4
 544:	fd247ec63f 	{ ae_cvtq48a32s	aeq0, a6; ae_roundsq32asym	aeq1, aeq0 }
 549:	369f04        	ae_trunca32q48	a15, aeq1
 54c:	3062f2        	s32i	a15, a2, 192
 54f:	2a14a6        	blti	a4, 1, 57d <agc_block_proc+0x269>
 552:	f94a80d6ff 	{ movi	a15, 214; ae_subsq56s	aeq1, aeq1, aeq0 }
 557:	4102f4        	ae_lp16f.x	aep0, a2, a15
 55a:	d4e36c831f 	{ ae_lp16f.iu	aep0, a3, 2; ae_mulfq32sp16s.l	aeq1, aeq1, aep0 }
 55f:	040c           	movi.n	a4, 0
 561:	065934        	ae_roundsq32asym	aeq1, aeq1
 564:	f86626a25e 	{ l16si	a5, a2, 212; ae_addq56	aeq0, aeq0, aeq1 }
 569:	d5e200144e 	{ addi	a4, a4, 1; ae_mulfq32sp16s.l	aeq2, aeq0, aep0 }
 56e:	35a114        	ae_slliq56	aeq2, aeq2, 4
 571:	1baf74        	ae_roundsp16q48asym	aep7, aeq2
 574:	427304        	ae_sp16f.l.i	aep7, a3, 0
 577:	408314        	ae_lp16f.iu	aep0, a3, 2
 57a:	e62457        	blt	a4, a5, 564 <agc_block_proc+0x250>
 57d:	f01d           	retw.n

0000057f <agc_block_proc+0x26b>:
	...

00000580 <AGC_Proc>:
 580:	004136        	entry	a1, 32
 583:	281262        	l16ui	a6, a2, 80
 586:	feb071        	l32r	a7, 48 (314 <agc_block_proc>)
 589:	d69c           	beqz.n	a6, 5aa <AGC_Proc+0x2a>
 58b:	929262        	l16si	a6, a2, 0x124
 58e:	50c222        	addi	a2, a2, 80
 591:	d25560        	quos	a5, a5, a6
 594:	1215a6        	blti	a5, 1, 5aa <AGC_Proc+0x2a>
 597:	1166f0        	slli	a6, a6, 1

0000059a <AGC_Proc+0x1a>:
 59a:	02ad           	mov.n	a10, a2
 59c:	03bd           	mov.n	a11, a3
 59e:	04cd           	mov.n	a12, a4
 5a0:	0007e0        	callx8	a7
 5a3:	550b           	addi.n	a5, a5, -1
 5a5:	336a           	add.n	a3, a3, a6
 5a7:	fef556        	bnez	a5, 59a <AGC_Proc+0x1a>
 5aa:	f01d           	retw.n

000005ac <__do_global_ctors_aux>:
 5ac:	004136        	entry	a1, 32
 5af:	fea731        	l32r	a3, 4c (884 <__CTOR_END__>)
 5b2:	fcc322        	addi	a2, a3, -4
 5b5:	0228           	l32i.n	a2, a2, 0
 5b7:	f8c332        	addi	a3, a3, -8
 5ba:	0a0226        	beqi	a2, -1, 5c8 <__do_global_ctors_aux+0x1c>

000005bd <__do_global_ctors_aux+0x11>:
 5bd:	0002e0        	callx8	a2
 5c0:	0328           	l32i.n	a2, a3, 0
 5c2:	fcc332        	addi	a3, a3, -4
 5c5:	f40266        	bnei	a2, -1, 5bd <__do_global_ctors_aux+0x11>
 5c8:	f01d           	retw.n

000005ca <__do_global_ctors_aux+0x1e>:
 5ca:	00000000                                 ......

000005d0 <xt_memset>:
 5d0:	004136        	entry	a1, 32
 5d3:	928c           	beqz.n	a2, 5e0 <xt_memset+0x10>
 5d5:	748c           	beqz.n	a4, 5e0 <xt_memset+0x10>
 5d7:	025d           	mov.n	a5, a2
 5d9:	038476        	loop	a4, 5e0 <xt_memset+0x10>
 5dc:	653d           	ae_s16i.n	a3, a5, 0
 5de:	552b           	addi.n	a5, a5, 2

000005e0 <xt_memset+0x10>:
 5e0:	f01d           	retw.n

000005e2 <xt_memset+0x12>:
	...

000005e4 <xt_memcpy>:
 5e4:	004136        	entry	a1, 32
 5e7:	025d           	mov.n	a5, a2
 5e9:	020c           	movi.n	a2, 0
 5eb:	b5bc           	beqz.n	a5, 62a <xt_memcpy+0x46>
 5ed:	93bc           	beqz.n	a3, 62a <xt_memcpy+0x46>
 5ef:	24b357        	bgeu	a3, a5, 617 <xt_memcpy+0x33>
 5f2:	902430        	addx2	a2, a4, a3
 5f5:	1eb527        	bgeu	a5, a2, 617 <xt_memcpy+0x33>
 5f8:	052d           	mov.n	a2, a5
 5fa:	c4ac           	beqz.n	a4, 62a <xt_memcpy+0x46>
 5fc:	240b           	addi.n	a2, a4, -1
 5fe:	1122f0        	slli	a2, a2, 1
 601:	332a           	add.n	a3, a3, a2
 603:	652a           	add.n	a6, a5, a2
 605:	0b8476        	loop	a4, 614 <xt_memcpy+0x30>
 608:	232d           	ae_l16si.n	a2, a3, 0
 60a:	662d           	ae_s16i.n	a2, a6, 0
 60c:	fec332        	addi	a3, a3, -2
 60f:	052d           	mov.n	a2, a5
 611:	fec662        	addi	a6, a6, -2

00000614 <xt_memcpy+0x30>:
 614:	000486        	j	62a <xt_memcpy+0x46>

00000617 <xt_memcpy+0x33>:
 617:	052d           	mov.n	a2, a5
 619:	d48c           	beqz.n	a4, 62a <xt_memcpy+0x46>
 61b:	056d           	mov.n	a6, a5
 61d:	098476        	loop	a4, 62a <xt_memcpy+0x46>
 620:	232d           	ae_l16si.n	a2, a3, 0
 622:	662d           	ae_s16i.n	a2, a6, 0
 624:	332b           	addi.n	a3, a3, 2
 626:	052d           	mov.n	a2, a5
 628:	662b           	addi.n	a6, a6, 2

0000062a <xt_memcpy+0x46>:
 62a:	f01d           	retw.n

0000062c <_fini>:
 62c:	008136        	entry	a1, 64
 62f:	fe8881        	l32r	a8, 50 (6c <__do_global_dtors_aux>)
 632:	f03d           	nop.n
 634:	0008e0        	callx8	a8

00000637 <_fini+0xb>:
 637:	f01d           	retw.n
