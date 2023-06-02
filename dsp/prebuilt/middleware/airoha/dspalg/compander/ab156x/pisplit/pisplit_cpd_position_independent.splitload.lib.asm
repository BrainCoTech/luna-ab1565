
Build/lib/pisplit_cpd_position_independent.splitload.lib:     file format elf32-xtensa-le


Disassembly of section .text:

00000000 <_init-0x10c>:
       0:	00000158 00001930 0000212c 00000000     X...0...,!......
      10:	000020f8 00000000 00002114 00002334     . .......!..4#..
      20:	00002178 000016d4 0000218e 000016ec     x!.......!......
      30:	000021a4 00000400 000021bc 00000be0     .!.......!......
      40:	000021d4 000007a4 000021ec 000012c0     .!.......!......
      50:	00002204 000017d0 00002213 00001888     ."......."......
      60:	00002222 00000bc0 00002246 00000bd0     ""......F"......
      70:	00002268 000012a0 00002287 00000218     h"......."......
      80:	00002299 000017b0 000022b4 000017c0     ."......."......
      90:	00002140 22102801 000022d0 00000288     @!...(."."......
      a0:	00001bdc 00001bc8 0000173c 00001774     ........<...t...
      b0:	7fff0000 00000390 00000538 0000086c     ........8...l...
      c0:	000016f8 000009c8 00000b1c 00000ad4     ................
      d0:	00000ce0 00000d34 00000dcc 00000ebc     ....4...........
      e0:	00000220 03d70a3d 66666667 00001a24      ...=...gfff$...
      f0:	00001b5c 00001034 000010bc 000011b8     \...4...........
     100:	00000344 00002100 00000124              D....!..$...

0000010c <_init>:
     10c:	008136        	entry	a1, 64
     10f:	ffbc81        	l32r	a8, 0 (158 <frame_dummy>)
     112:	f03d           	nop.n
     114:	0008e0        	callx8	a8
     117:	ffbb81        	l32r	a8, 4 (1930 <__do_global_ctors_aux>)
     11a:	f03d           	nop.n
     11c:	0008e0        	callx8	a8
     11f:	f01d           	retw.n

00000121 <_init+0x15>:
     121:	000000                                        ...

00000124 <__do_global_dtors_aux>:
     124:	004136        	entry	a1, 32
     127:	ffb821        	l32r	a2, 8 (212c <__do_global_dtors_aux.completed>)
     12a:	000232        	l8ui	a3, a2, 0
     12d:	23ec           	bnez.n	a3, 153 <__do_global_dtors_aux+0x2f>

0000012f <__do_global_dtors_aux+0xb>:
     12f:	1248           	l32i.n	a4, a2, 4
     131:	0438           	l32i.n	a3, a4, 0
     133:	444b           	addi.n	a4, a4, 4
     135:	738c           	beqz.n	a3, 140 <__do_global_dtors_aux+0x1c>
     137:	1249           	s32i.n	a4, a2, 4
     139:	0003e0        	callx8	a3
     13c:	fffbc6        	j	12f <__do_global_dtors_aux+0xb>

0000013f <__do_global_dtors_aux+0x1b>:
	...

00000140 <__do_global_dtors_aux+0x1c>:
     140:	ffb331        	l32r	a3, c (0 <_text_start>)
     143:	ffb3a1        	l32r	a10, 10 (20f8 <__FRAME_END__>)
     146:	438c           	beqz.n	a3, 14e <__do_global_dtors_aux+0x2a>
     148:	ffb181        	l32r	a8, c (0 <_text_start>)
     14b:	0008e0        	callx8	a8
     14e:	130c           	movi.n	a3, 1
     150:	004232        	s8i	a3, a2, 0
     153:	f01d           	retw.n

00000155 <__do_global_dtors_aux+0x31>:
     155:	000000                                        ...

00000158 <frame_dummy>:
     158:	004136        	entry	a1, 32
     15b:	ffae21        	l32r	a2, 14 (0 <_text_start>)
     15e:	ffaca1        	l32r	a10, 10 (20f8 <__FRAME_END__>)
     161:	ffadb1        	l32r	a11, 18 (2114 <frame_dummy.object>)
     164:	428c           	beqz.n	a2, 16c <frame_dummy+0x14>
     166:	ffab81        	l32r	a8, 14 (0 <_text_start>)
     169:	0008e0        	callx8	a8

0000016c <frame_dummy+0x14>:
     16c:	f01d           	retw.n

0000016e <frame_dummy+0x16>:
	...

00000170 <_start>:
     170:	004136        	entry	a1, 32
     173:	ffaa31        	l32r	a3, 1c (2334 <printf_ptr>)
     176:	0228           	l32i.n	a2, a2, 0
     178:	ffaaa1        	l32r	a10, 20 (2178 <export_parameter_array+0x38>)
     17b:	ffaab1        	l32r	a11, 24 (16d4 <get_CPD_memsize>)
     17e:	0329           	s32i.n	a2, a3, 0
     180:	0002e0        	callx8	a2
     183:	0328           	l32i.n	a2, a3, 0
     185:	ffa8a1        	l32r	a10, 28 (218e <export_parameter_array+0x4e>)
     188:	ffa9b1        	l32r	a11, 2c (16ec <get_INS_memsize>)
     18b:	0002e0        	callx8	a2
     18e:	0328           	l32i.n	a2, a3, 0
     190:	ffa8a1        	l32r	a10, 30 (21a4 <export_parameter_array+0x64>)
     193:	ffa8b1        	l32r	a11, 34 (400 <compander_VO_init>)
     196:	0002e0        	callx8	a2
     199:	0328           	l32i.n	a2, a3, 0
     19b:	ffa7a1        	l32r	a10, 38 (21bc <export_parameter_array+0x7c>)
     19e:	ffa7b1        	l32r	a11, 3c (be0 <compander_AU_init>)
     1a1:	0002e0        	callx8	a2
     1a4:	0328           	l32i.n	a2, a3, 0
     1a6:	ffa6a1        	l32r	a10, 40 (21d4 <export_parameter_array+0x94>)
     1a9:	ffa6b1        	l32r	a11, 44 (7a4 <compander_VO_proc>)
     1ac:	0002e0        	callx8	a2
     1af:	0328           	l32i.n	a2, a3, 0
     1b1:	ffa5a1        	l32r	a10, 48 (21ec <export_parameter_array+0xac>)
     1b4:	ffa6b1        	l32r	a11, 4c (12c0 <compander_AU_proc>)
     1b7:	0002e0        	callx8	a2
     1ba:	0328           	l32i.n	a2, a3, 0
     1bc:	ffa5a1        	l32r	a10, 50 (2204 <export_parameter_array+0xc4>)
     1bf:	ffa5b1        	l32r	a11, 54 (17d0 <INS_Init>)
     1c2:	0002e0        	callx8	a2
     1c5:	0328           	l32i.n	a2, a3, 0
     1c7:	ffa4a1        	l32r	a10, 58 (2213 <export_parameter_array+0xd3>)
     1ca:	ffa4b1        	l32r	a11, 5c (1888 <INS_Prcs>)
     1cd:	0002e0        	callx8	a2
     1d0:	0328           	l32i.n	a2, a3, 0
     1d2:	ffa3a1        	l32r	a10, 60 (2222 <export_parameter_array+0xe2>)
     1d5:	ffa3b1        	l32r	a11, 64 (bc0 <compander_AU_SetFrame120_init>)
     1d8:	0002e0        	callx8	a2
     1db:	0328           	l32i.n	a2, a3, 0
     1dd:	ffa2a1        	l32r	a10, 68 (2246 <export_parameter_array+0x106>)
     1e0:	ffa3b1        	l32r	a11, 6c (bd0 <compander_AU_SetFrame8_init>)
     1e3:	0002e0        	callx8	a2
     1e6:	0328           	l32i.n	a2, a3, 0
     1e8:	ffa2a1        	l32r	a10, 70 (2268 <export_parameter_array+0x128>)
     1eb:	ffa2b1        	l32r	a11, 74 (12a0 <compander_AU_SetINS_proc>)
     1ee:	0002e0        	callx8	a2
     1f1:	0328           	l32i.n	a2, a3, 0
     1f3:	ffa1a1        	l32r	a10, 78 (2287 <export_parameter_array+0x147>)
     1f6:	ffa1b1        	l32r	a11, 7c (218 <SVN_version>)
     1f9:	0002e0        	callx8	a2
     1fc:	0328           	l32i.n	a2, a3, 0
     1fe:	ffa0a1        	l32r	a10, 80 (2299 <export_parameter_array+0x159>)
     201:	ffa0b1        	l32r	a11, 84 (17b0 <INS_SetFrame120_Init>)
     204:	0002e0        	callx8	a2
     207:	0328           	l32i.n	a2, a3, 0
     209:	ff9fa1        	l32r	a10, 88 (22b4 <export_parameter_array+0x174>)
     20c:	ffa0b1        	l32r	a11, 8c (17c0 <INS_SetFrame8_Init>)
     20f:	0002e0        	callx8	a2
     212:	ff9f21        	l32r	a2, 90 (2140 <export_parameter_array>)
     215:	f01d           	retw.n

00000217 <_start+0xa7>:
	...

00000218 <SVN_version>:
     218:	004136        	entry	a1, 32
     21b:	ff9e21        	l32r	a2, 94 (22102801 <_end+0x221004c9>)
     21e:	f01d           	retw.n

00000220 <HIFI_sqrt_cpd>:
     220:	004136        	entry	a1, 32
     223:	0348           	l32i.n	a4, a3, 0
     225:	5614a6        	blti	a4, 1, 27f <HIFI_sqrt_cpd+0x5f>
     228:	0268           	l32i.n	a6, a2, 0
     22a:	40e450        	nsa	a5, a4
     22d:	401500        	ssl	a5
     230:	c05650        	sub	a5, a6, a5
     233:	046050        	extui	a6, a5, 0, 1
     236:	a1a400        	sll	a10, a4
     239:	400600        	ssr	a6
     23c:	b140a0        	sra	a4, a10
     23f:	658940        	extui	a8, a4, 25, 7
     242:	ff95b1        	l32r	a11, 98 (22d0 <TABLE_SQRT>)
     245:	070c           	movi.n	a7, 0
     247:	f0c882        	addi	a8, a8, -16
     24a:	537870        	max	a7, a8, a7
     24d:	9077b0        	addx2	a7, a7, a11
     250:	478d           	ae_l16ui.n	a8, a7, 0
     252:	377d           	ae_l16si.n	a7, a7, 2
     254:	414940        	srli	a4, a4, 9
     257:	11d800        	slli	a13, a8, 16
     25a:	c0c780        	sub	a12, a7, a8
     25d:	300444        	ae_cvtp24a16x2.ll	aep0, a4, a4
     260:	114c00        	slli	a4, a12, 16
     263:	360d34        	ae_cvtq48a32s	aeq0, a13
     266:	364434        	ae_cvtq48a32s	aeq1, a4
     269:	d4e110e65f 	{ add	a14, a6, a5; ae_mulaq32sp16u.l	aeq0, aeq1, aep0 }
     26e:	2141e0        	srai	a4, a14, 1
     271:	f86394024f 	{ s32i.n	a4, a2, 0; ae_roundsp16q48asym	aep0, aeq0 }
     276:	360f24        	ae_trunca16p24s.l	a15, aep0
     279:	114f00        	slli	a4, a15, 16
     27c:	0000c6        	j	283 <HIFI_sqrt_cpd+0x63>

0000027f <HIFI_sqrt_cpd+0x5f>:
     27f:	040c           	movi.n	a4, 0
     281:	0249           	s32i.n	a4, a2, 0
     283:	0349           	s32i.n	a4, a3, 0
     285:	f01d           	retw.n

00000287 <HIFI_sqrt_cpd+0x67>:
	...

00000288 <Xdiv>:
     288:	004136        	entry	a1, 32
     28b:	0258           	l32i.n	a5, a2, 0
     28d:	0348           	l32i.n	a4, a3, 0
     28f:	ffa062        	movi	a6, 255
     292:	e5ac           	beqz.n	a5, 2c4 <Xdiv+0x3c>
     294:	64bc           	beqz.n	a4, 2ce <Xdiv+0x46>
     296:	600204        	ae_lq32f.i	aeq0, a2, 0
     299:	604304        	ae_lq32f.i	aeq1, a3, 0
     29c:	364204        	ae_nsaq56s	a2, aeq0
     29f:	365304        	ae_nsaq56s	a3, aeq1
     2a2:	432230        	min	a2, a2, a3
     2a5:	e9c232        	addi	a3, a2, -23
     2a8:	fc24fe934f 	{ ae_slaasq56s	aeq1, aeq1, a3; nop }
     2ad:	369304        	ae_trunca32q48	a3, aeq1
     2b0:	f8c222        	addi	a2, a2, -8
     2b3:	f39c           	beqz.n	a3, 2d6 <Xdiv+0x4e>
     2b5:	fc24fe820f 	{ ae_slaasq56s	aeq0, aeq0, a2; nop }
     2ba:	368204        	ae_trunca32q48	a2, aeq0
     2bd:	d22230        	quos	a2, a2, a3
     2c0:	a22d           	ae_clamps16	a2, a2
     2c2:	f01d           	retw.n

000002c4 <Xdiv+0x3c>:
     2c4:	7fd622        	addmi	a2, a6, 0x7f00
     2c7:	030c           	movi.n	a3, 0
     2c9:	932340        	movnez	a2, a3, a4
     2cc:	f01d           	retw.n

000002ce <Xdiv+0x46>:
     2ce:	ffa022        	movi	a2, 255
     2d1:	7fd222        	addmi	a2, a2, 0x7f00
     2d4:	f01d           	retw.n

000002d6 <Xdiv+0x4e>:
     2d6:	f01d           	retw.n

000002d8 <linear_interp>:
     2d8:	006136        	entry	a1, 48
     2db:	c0f340        	sub	a15, a3, a4
     2de:	065122        	s16i	a2, a1, 12
     2e1:	400164        	ae_lp16f.i	aep0, a1, 12
     2e4:	364f34        	ae_cvtq48a32s	aeq1, a15
     2e7:	d4e37ec43f 	{ ae_cvtq48a32s	aeq0, a4; ae_mulfq32sp16s.l	aeq1, aeq1, aep0 }
     2ec:	355094        	ae_slliq56	aeq1, aeq1, 2
     2ef:	060904        	ae_addsq56s	aeq0, aeq0, aeq1
     2f2:	060934        	ae_roundsq32asym	aeq0, aeq0
     2f5:	368204        	ae_trunca32q48	a2, aeq0
     2f8:	f01d           	retw.n

000002fa <linear_interp+0x22>:
	...

000002fc <INS_coef_init>:
     2fc:	004136        	entry	a1, 32
     2ff:	930c           	movi.n	a3, 9
     301:	540c           	movi.n	a4, 5
     303:	350c           	movi.n	a5, 3
     305:	113350        	slli	a3, a3, 11
     308:	114450        	slli	a4, a4, 11
     30b:	dd7c           	movi.n	a13, -3
     30d:	015550        	slli	a5, a5, 27
     310:	300434        	ae_cvtp24a16x2.ll	aep0, a4, a3
     313:	013d50        	slli	a3, a13, 27
     316:	1cc2e2        	addi	a14, a2, 28
     319:	360534        	ae_cvtq48a32s	aeq0, a5
     31c:	fd046c1e0f 	{ ae_lp16f.i	aep1, a14, 0; ae_movq56	aeq1, aeq0 }
     321:	ec223ec3bf 	{ ae_cvtq48a32s	aeq2, a3; ae_mulsfs32p16s.hh	aeq0, aep0, aep1 }
     326:	e521008eff 	{ movi	a15, 142; ae_mulafs32p16s.lh	aeq2, aep0, aep1 }
     32b:	0009a4        	ae_mulsfs32p16s.lh	aeq1, aep0, aep1
     32e:	fa63fae0df 	{ ae_sllisq56s	aeq3, aeq2, 1; ae_roundsp16q48asym	aep5, aeq0 }
     333:	fb6ba3df2f 	{ ae_sp16f.l.xu	aep5, a15, a2; ae_roundsp16q48asym	aep6, aeq1 }
     338:	fb7bf26f2f 	{ ae_sp16f.l.i	aep6, a15, 4; ae_roundsp16q48asym	aep7, aeq3 }
     33d:	427f14        	ae_sp16f.l.i	aep7, a15, 2
     340:	f01d           	retw.n

00000342 <INS_coef_init+0x46>:
	...

00000344 <AU_INS_coef_init>:
     344:	004136        	entry	a1, 32
     347:	930c           	movi.n	a3, 9
     349:	540c           	movi.n	a4, 5
     34b:	84a052        	movi	a5, 132
     34e:	113350        	slli	a3, a3, 11
     351:	114450        	slli	a4, a4, 11
     354:	3d0c           	movi.n	a13, 3
     356:	de7c           	movi.n	a14, -3
     358:	300434        	ae_cvtp24a16x2.ll	aep0, a4, a3
     35b:	602254        	ae_lq32f.x	aeq0, a2, a5
     35e:	013d50        	slli	a3, a13, 27
     361:	014e50        	slli	a4, a14, 27
     364:	364334        	ae_cvtq48a32s	aeq1, a3
     367:	fe0c7a840f 	{ ae_slliq56	aeq0, aeq0, 16; ae_movq56	aeq2, aeq1 }
     36c:	f840fec4ff 	{ ae_cvtq48a32s	aeq3, a4; ae_mulsfq32sp24s.h	aeq1, aeq0, aep0 }
     371:	f5c2c090ff 	{ movi	a15, 144; ae_mulafq32sp24s.l	aeq3, aeq0, aep0 }
     376:	088124        	ae_mulsfq32sp24s.l	aeq2, aeq0, aep0
     379:	fd2c7af0df 	{ ae_sllisq56s	aeq3, aeq3, 1; ae_roundsq32asym	aeq1, aeq1 }
     37e:	fe34789f2f 	{ ae_sq32f.xu	aeq1, a15, a2; ae_roundsq32asym	aeq2, aeq2 }
     383:	ff3c79af2f 	{ ae_sq32f.i	aeq2, a15, 8; ae_roundsq32asym	aeq3, aeq3 }
     388:	623f14        	ae_sq32f.i	aeq3, a15, 4
     38b:	f01d           	retw.n

0000038d <AU_INS_coef_init+0x49>:
     38d:	000000                                        ...

00000390 <INS_inter_gain>:
     390:	006136        	entry	a1, 48
     393:	0d9232        	l16si	a3, a2, 26
     396:	ff4141        	l32r	a4, 9c (288 <Xdiv>)
     399:	4cc2b2        	addi	a11, a2, 76
     39c:	113300        	slli	a3, a3, 16
     39f:	2139           	s32i.n	a3, a1, 8
     3a1:	318b           	addi.n	a3, a1, 8
     3a3:	03ad           	mov.n	a10, a3
     3a5:	0004e0        	callx8	a4
     3a8:	479252        	l16si	a5, a2, 142
     3ab:	116a00        	slli	a6, a10, 16
     3ae:	b1cb           	addi.n	a11, a1, 12
     3b0:	115500        	slli	a5, a5, 16
     3b3:	03ad           	mov.n	a10, a3
     3b5:	3169           	s32i.n	a6, a1, 12
     3b7:	2159           	s32i.n	a5, a1, 8
     3b9:	0004e0        	callx8	a4
     3bc:	4992f2        	l16si	a15, a2, 146
     3bf:	489232        	l16si	a3, a2, 144
     3c2:	114a00        	slli	a4, a10, 16
     3c5:	112f00        	slli	a2, a15, 16
     3c8:	b22620        	mulsh	a2, a6, a2
     3cb:	113300        	slli	a3, a3, 16
     3ce:	1122f0        	slli	a2, a2, 1
     3d1:	360434        	ae_cvtq48a32s	aeq0, a4
     3d4:	364334        	ae_cvtq48a32s	aeq1, a3
     3d7:	f8667ec2ff 	{ ae_cvtq48a32s	aeq3, a2; ae_addsq56s	aeq0, aeq0, aeq1 }
     3dc:	060b04        	ae_addsq56s	aeq0, aeq0, aeq3
     3df:	360094        	ae_sllisq56s	aeq0, aeq0, 2
     3e2:	1b8f04        	ae_roundsp16q48asym	aep0, aeq0
     3e5:	0082d4        	ae_cvta32p24.h	a2, aep0
     3e8:	f01d           	retw.n

000003ea <INS_inter_gain+0x5a>:
	...

000003ec <compander_VO_PARA_init>:
     3ec:	004136        	entry	a1, 32
     3ef:	b24b           	addi.n	a11, a2, 4
     3f1:	ff2b21        	l32r	a2, a0 (1bdc <xt_memcpy>)
     3f4:	0c1c           	movi.n	a12, 16
     3f6:	03ad           	mov.n	a10, a3
     3f8:	0002e0        	callx8	a2
     3fb:	f01d           	retw.n

000003fd <compander_VO_PARA_init+0x11>:
     3fd:	000000                                        ...

00000400 <compander_VO_init>:
     400:	006136        	entry	a1, 48
     403:	38a152        	movi	a5, 0x138
     406:	a25a           	add.n	a10, a2, a5
     408:	ff2651        	l32r	a5, a0 (1bdc <xt_memcpy>)
     40b:	22c3b2        	addi	a11, a3, 34
     40e:	4c0c           	movi.n	a12, 4
     410:	0005e0        	callx8	a5
     413:	ff2461        	l32r	a6, a4 (1bc8 <xt_memset>)
     416:	0b0c           	movi.n	a11, 0
     418:	9ca0c2        	movi	a12, 156
     41b:	02ad           	mov.n	a10, a2
     41d:	0006e0        	callx8	a6
     420:	b34b           	addi.n	a11, a3, 4
     422:	0c1c           	movi.n	a12, 16
     424:	02ad           	mov.n	a10, a2
     426:	0005e0        	callx8	a5
     429:	cda052        	movi	a5, 205
     42c:	0cd552        	addmi	a5, a5, 0xc00
     42f:	461c           	movi.n	a6, 20
     431:	a70c           	movi.n	a7, 10
     433:	0b44a6        	blti	a4, 4, 442 <compander_VO_init+0x42>
     436:	1364e6        	bgei	a4, 6, 44d <compander_VO_init+0x4d>
     439:	314426        	beqi	a4, 4, 46e <compander_VO_init+0x6e>
     43c:	275426        	beqi	a4, 5, 467 <compander_VO_init+0x67>
     43f:	000cc6        	j	476 <compander_VO_init+0x76>

00000442 <compander_VO_init+0x42>:
     442:	84ac           	beqz.n	a4, 46e <compander_VO_init+0x6e>
     444:	1f1426        	beqi	a4, 1, 467 <compander_VO_init+0x67>
     447:	122426        	beqi	a4, 2, 45d <compander_VO_init+0x5d>
     44a:	000a06        	j	476 <compander_VO_init+0x76>

0000044d <compander_VO_init+0x4d>:
     44d:	0c6426        	beqi	a4, 6, 45d <compander_VO_init+0x5d>
     450:	471c           	movi.n	a7, 20
     452:	209477        	bne	a4, a7, 476 <compander_VO_init+0x76>
     455:	66a652        	movi	a5, 0x666
     458:	862c           	movi.n	a6, 40
     45a:	000406        	j	46e <compander_VO_init+0x6e>

0000045d <compander_VO_init+0x5d>:
     45d:	33a352        	movi	a5, 0x333
     460:	065c           	movi.n	a6, 80
     462:	872c           	movi.n	a7, 40
     464:	000186        	j	46e <compander_VO_init+0x6e>

00000467 <compander_VO_init+0x67>:
     467:	66a652        	movi	a5, 0x666
     46a:	862c           	movi.n	a6, 40
     46c:	471c           	movi.n	a7, 20
     46e:	185272        	s16i	a7, a2, 48
     471:	f269           	s32i.n	a6, a2, 60
     473:	195252        	s16i	a5, a2, 50
     476:	32c8           	l32i.n	a12, a2, 12
     478:	12a8           	l32i.n	a10, a2, 4
     47a:	042ca7        	blt	a12, a10, 482 <compander_VO_init+0x82>
     47d:	22b8           	l32i.n	a11, a2, 8
     47f:	07aba7        	bge	a11, a10, 48a <compander_VO_init+0x8a>
     482:	32a9           	s32i.n	a10, a2, 12
     484:	22a9           	s32i.n	a10, a2, 8
     486:	0acd           	mov.n	a12, a10
     488:	0abd           	mov.n	a11, a10
     48a:	ff0751        	l32r	a5, a8 (173c <calc_slope_1>)
     48d:	0005e0        	callx8	a5
     490:	1278           	l32i.n	a7, a2, 4
     492:	5268           	l32i.n	a6, a2, 20
     494:	0651a2        	s16i	a10, a1, 12
     497:	400164        	ae_lp16f.i	aep0, a1, 12
     49a:	c06670        	sub	a6, a6, a7
     49d:	360634        	ae_cvtq48a32s	aeq0, a6
     4a0:	d4e23ec77f 	{ ae_cvtq48a32s	aeq1, a7; ae_mulfq32sp16s.l	aeq0, aeq0, aep0 }
     4a5:	42b8           	l32i.n	a11, a2, 16
     4a7:	350094        	ae_slliq56	aeq0, aeq0, 2
     4aa:	f86a7022ce 	{ l32i	a12, a2, 8; ae_addsq56s	aeq0, aeq1, aeq0 }
     4af:	fc2440056f 	{ movi	a6, 5; ae_roundsq32asym	aeq0, aeq0 }
     4b4:	4252a2        	s16i	a10, a2, 132
     4b7:	368a04        	ae_trunca32q48	a10, aeq0
     4ba:	fefc51        	l32r	a5, ac (1774 <calc_slope_2>)
     4bd:	0005e0        	callx8	a5
     4c0:	950c           	movi.n	a5, 9
     4c2:	115550        	slli	a5, a5, 11
     4c5:	116650        	slli	a6, a6, 11
     4c8:	300654        	ae_cvtp24a16x2.ll	aep0, a6, a5
     4cb:	160c           	movi.n	a6, 1
     4cd:	015630        	slli	a5, a6, 29
     4d0:	3b0c           	movi.n	a11, 3
     4d2:	dc7c           	movi.n	a12, -3
     4d4:	1cc282        	addi	a8, a2, 28
     4d7:	016b50        	slli	a6, a11, 27
     4da:	126252        	s32i	a5, a2, 72
     4dd:	015c50        	slli	a5, a12, 27
     4e0:	368634        	ae_cvtq48a32s	aeq2, a6
     4e3:	fc146c180f 	{ ae_lp16f.i	aep1, a8, 0; ae_movq56	aeq0, aeq2 }
     4e8:	ed223ec57f 	{ ae_cvtq48a32s	aeq1, a5; ae_mulsfs32p16s.hh	aeq2, aep0, aep1 }
     4ed:	e42140989f 	{ movi	a9, 152; ae_mulafs32p16s.lh	aeq1, aep0, aep1 }
     4f2:	ec23008edf 	{ movi	a13, 142; ae_mulsfs32p16s.lh	aeq0, aep0, aep1 }
     4f7:	f973bad05f 	{ ae_sllisq56s	aeq1, aeq1, 1; ae_roundsp16q48asym	aep2, aeq2 }
     4fc:	f86380007f 	{ movi	a7, 0; ae_roundsp16q48asym	aep0, aeq0 }
     501:	105242        	s16i	a4, a2, 32
     504:	429a           	add.n	a4, a2, a9
     506:	fb6be3ad2f 	{ ae_sp16f.l.xu	aep2, a13, a2; ae_roundsp16q48asym	aep7, aeq1 }
     50b:	1e0c           	movi.n	a14, 1
     50d:	166272        	s32i	a7, a2, 88
     510:	136272        	s32i	a7, a2, 76
     513:	b279           	s32i.n	a7, a2, 44
     515:	4352a2        	s16i	a10, a2, 134
     518:	d249           	s32i.n	a4, a2, 52
     51a:	e249           	s32i.n	a4, a2, 56
     51c:	420d24        	ae_sp16f.l.i	aep0, a13, 4
     51f:	427d14        	ae_sp16f.l.i	aep7, a13, 2
     522:	015ea0        	slli	a5, a14, 22
     525:	eca1f2        	movi	a15, 0x1ec
     528:	000332        	l8ui	a3, a3, 0
     52b:	a259           	s32i.n	a5, a2, 40
     52d:	1352f2        	s16i	a15, a2, 38
     530:	125232        	s16i	a3, a2, 36
     533:	f01d           	retw.n

00000535 <compander_VO_init+0x135>:
     535:	000000                                        ...

00000538 <cpd_block_proc>:
     538:	008136        	entry	a1, 64
     53b:	fc24a1824e 	{ l16si	a4, a2, 48; ae_zeroq56	aeq0 }
     540:	fc208fe37e 	{ addi	a7, a3, -2; ae_zerop48	aep0 }
     545:	32c2b2        	addi	a11, a2, 50
     548:	1514a6        	blti	a4, 1, 561 <cpd_block_proc+0x29>
     54b:	945d           	ae_zext16	a5, a4
     54d:	401b04        	ae_lp16f.i	aep1, a11, 0
     550:	074d           	mov.n	a4, a7
     552:	0b8576        	loop	a5, 561 <cpd_block_proc+0x29>
     555:	40a414        	ae_lp16f.iu	aep2, a4, 2
     558:	079a24        	ae_abssp24s	aep2, aep2
     55b:	011204        	ae_mulafp24s.hh	aeq0, aep1, aep2
     55e:	070a04        	ae_maxp24s	aep0, aep0, aep2

00000561 <cpd_block_proc+0x29>:
     561:	fc2442824e 	{ addi	a4, a2, 40; ae_roundsq32asym	aeq0, aeq0 }
     566:	604404        	ae_lq32f.i	aeq1, a4, 0
     569:	d4e344c25e 	{ addi	a5, a2, 76; ae_mulfq32sp16s.l	aeq1, aeq1, aep0 }
     56e:	608504        	ae_lq32f.i	aeq2, a5, 0
     571:	fd2c7052fe 	{ l32i	a15, a2, 20; ae_roundsq32asym	aeq1, aeq1 }
     576:	f8c2b9914f 	{ ae_sq32f.i	aeq1, a1, 16; ae_subsq56s	aeq0, aeq0, aeq2 }
     57b:	3500f4        	ae_sraiq56	aeq0, aeq0, 3
     57e:	fc2470414e 	{ l32i	a4, a1, 16; ae_roundsq32asym	aeq0, aeq0 }
     583:	062804        	ae_addsq56s	aeq0, aeq2, aeq0
     586:	620504        	ae_sq32f.i	aeq0, a5, 0
     589:	01af47        	bge	a15, a4, 58e <cpd_block_proc+0x56>
     58c:	5249           	s32i.n	a4, a2, 20

0000058e <cpd_block_proc+0x56>:
     58e:	161252        	l16ui	a5, a2, 44
     591:	0c1262        	l16ui	a6, a2, 24
     594:	1e2292        	l32i	a9, a2, 120
     597:	162282        	l32i	a8, a2, 88
     59a:	2a9567        	bne	a5, a6, 5c8 <cpd_block_proc+0x90>
     59d:	172282        	l32i	a8, a2, 92
     5a0:	160c           	movi.n	a6, 1
     5a2:	165262        	s16i	a6, a2, 44
     5a5:	536840        	max	a6, a8, a4
     5a8:	790c           	movi.n	a9, 7
     5aa:	5cc252        	addi	a5, a2, 92
     5ad:	3169           	s32i.n	a6, a1, 12
     5af:	088976        	loop	a9, 5bb <cpd_block_proc+0x83>
     5b2:	1588           	l32i.n	a8, a5, 4
     5b4:	0589           	s32i.n	a8, a5, 0
     5b6:	554b           	addi.n	a5, a5, 4
     5b8:	536680        	max	a6, a6, a8

000005bb <cpd_block_proc+0x83>:
     5bb:	166262        	s32i	a6, a2, 88
     5be:	0549           	s32i.n	a4, a5, 0
     5c0:	162242        	l32i	a4, a2, 88
     5c3:	3169           	s32i.n	a6, a1, 12
     5c5:	000406        	j	5d9 <cpd_block_proc+0xa1>

000005c8 <cpd_block_proc+0x90>:
     5c8:	551b           	addi.n	a5, a5, 1
     5ca:	53f940        	max	a15, a9, a4
     5cd:	534840        	max	a4, a8, a4
     5d0:	165252        	s16i	a5, a2, 44
     5d3:	1e62f2        	s32i	a15, a2, 120
     5d6:	166242        	s32i	a4, a2, 88
     5d9:	1258           	l32i.n	a5, a2, 4
     5db:	1222d2        	l32i	a13, a2, 72
     5de:	132262        	l32i	a6, a2, 76
     5e1:	4ca547        	bge	a5, a4, 631 <cpd_block_proc+0xf9>
     5e4:	421262        	l16ui	a6, a2, 132
     5e7:	c04450        	sub	a4, a4, a5
     5ea:	045162        	s16i	a6, a1, 8
     5ed:	360434        	ae_cvtq48a32s	aeq0, a4
     5f0:	400144        	ae_lp16f.i	aep0, a1, 8
     5f3:	d4e27ec53f 	{ ae_cvtq48a32s	aeq0, a5; ae_mulfq32sp16s.l	aeq1, aeq0, aep0 }
     5f8:	22c8           	l32i.n	a12, a2, 8
     5fa:	355094        	ae_slliq56	aeq1, aeq1, 2
     5fd:	f96645829e 	{ addi	a9, a2, 88; ae_addsq56s	aeq1, aeq0, aeq1 }
     602:	fd2c70528e 	{ l32i	a8, a2, 20; ae_roundsq32asym	aeq1, aeq1 }
     607:	369404        	ae_trunca32q48	a4, aeq1
     60a:	2149           	s32i.n	a4, a1, 8
     60c:	c05850        	sub	a5, a8, a5
     60f:	58a4c7        	bge	a4, a12, 66b <cpd_block_proc+0x133>
     612:	214240        	srai	a4, a4, 2
     615:	2149           	s32i.n	a4, a1, 8
     617:	fea141        	l32r	a4, 9c (288 <Xdiv>)
     61a:	0b5d           	mov.n	a5, a11
     61c:	a18b           	addi.n	a10, a1, 8
     61e:	09bd           	mov.n	a11, a9
     620:	0d6d           	mov.n	a6, a13
     622:	0004e0        	callx8	a4
     625:	05bd           	mov.n	a11, a5
     627:	06dd           	mov.n	a13, a6
     629:	064d           	mov.n	a4, a6
     62b:	115a00        	slli	a5, a10, 16
     62e:	002ec6        	j	6ed <cpd_block_proc+0x1b5>

00000631 <cpd_block_proc+0xf9>:
     631:	1ac252        	addi	a5, a2, 26
     634:	400504        	ae_lp16f.i	aep0, a5, 0
     637:	c802c4824e 	{ addi	a4, a2, 72; ae_sllisp24s	aep1, aep0, 1 }
     63c:	d80520055e 	{ l16si	a5, a5, 0; ae_addsp24s	aep0, aep1, aep0 }
     641:	0008d4        	ae_cvta32p24.l	a8, aep0
     644:	3189           	s32i.n	a8, a1, 12
     646:	fe9aa1        	l32r	a10, b0 (7fff0000 <_end+0x7ffedcc8>)
     649:	022687        	blt	a6, a8, 64f <cpd_block_proc+0x117>
     64c:	002a06        	j	6f8 <cpd_block_proc+0x1c0>
     64f:	115500        	slli	a5, a5, 16
     652:	022567        	blt	a5, a6, 658 <cpd_block_proc+0x120>
     655:	002c46        	j	70a <cpd_block_proc+0x1d2>
     658:	fe9781        	l32r	a8, b4 (390 <INS_inter_gain>)
     65b:	02ad           	mov.n	a10, a2
     65d:	0b6d           	mov.n	a6, a11
     65f:	0d5d           	mov.n	a5, a13
     661:	0008e0        	callx8	a8
     664:	05dd           	mov.n	a13, a5
     666:	06bd           	mov.n	a11, a6
     668:	002906        	j	710 <cpd_block_proc+0x1d8>

0000066b <cpd_block_proc+0x133>:
     66b:	025162        	s16i	a6, a1, 4
     66e:	364534        	ae_cvtq48a32s	aeq1, a5
     671:	400124        	ae_lp16f.i	aep0, a1, 4
     674:	d4e340416e 	{ addi	a6, a1, 4; ae_mulfq32sp16s.l	aeq1, aeq1, aep0 }
     679:	71b9           	s32i.n	a11, a1, 28
     67b:	42b8           	l32i.n	a11, a2, 16
     67d:	355094        	ae_slliq56	aeq1, aeq1, 2
     680:	f8665461df 	{ s32i.n	a13, a1, 24; ae_addsq56s	aeq0, aeq0, aeq1 }
     685:	fc2454519f 	{ s32i.n	a9, a1, 20; ae_roundsq32asym	aeq0, aeq0 }
     68a:	368a04        	ae_trunca32q48	a10, aeq0
     68d:	fe8751        	l32r	a5, ac (1774 <calc_slope_2>)
     690:	0005e0        	callx8	a5
     693:	2258           	l32i.n	a5, a2, 8
     695:	0251a2        	s16i	a10, a1, 4
     698:	400604        	ae_lp16f.i	aep0, a6, 0
     69b:	c0e450        	sub	a14, a4, a5
     69e:	360e34        	ae_cvtq48a32s	aeq0, a14
     6a1:	d4e23ec57f 	{ ae_cvtq48a32s	aeq1, a5; ae_mulfq32sp16s.l	aeq0, aeq0, aep0 }
     6a6:	215250        	srai	a5, a5, 2
     6a9:	350094        	ae_slliq56	aeq0, aeq0, 2
     6ac:	f86a54115f 	{ s32i.n	a5, a1, 4; ae_addsq56s	aeq0, aeq1, aeq0 }
     6b1:	fc2440c15e 	{ addi	a5, a1, 12; ae_roundsq32asym	aeq0, aeq0 }
     6b6:	fe7961        	l32r	a6, 9c (288 <Xdiv>)
     6b9:	4352a2        	s16i	a10, a2, 134
     6bc:	368f04        	ae_trunca32q48	a15, aeq0
     6bf:	a14b           	addi.n	a10, a1, 4
     6c1:	05bd           	mov.n	a11, a5
     6c3:	31f9           	s32i.n	a15, a1, 12
     6c5:	0006e0        	callx8	a6
     6c8:	51b8           	l32i.n	a11, a1, 20
     6ca:	069d           	mov.n	a9, a6
     6cc:	214240        	srai	a4, a4, 2
     6cf:	0a6d           	mov.n	a6, a10
     6d1:	11a9           	s32i.n	a10, a1, 4
     6d3:	05ad           	mov.n	a10, a5
     6d5:	3149           	s32i.n	a4, a1, 12
     6d7:	0009e0        	callx8	a9
     6da:	864d           	ae_sext16	a4, a6
     6dc:	8a5d           	ae_sext16	a5, a10
     6de:	d15540        	mul16s	a5, a5, a4
     6e1:	61d8           	l32i.n	a13, a1, 24
     6e3:	71b8           	l32i.n	a11, a1, 28
     6e5:	122242        	l32i	a4, a2, 72
     6e8:	1155d0        	slli	a5, a5, 3
     6eb:	31a9           	s32i.n	a10, a1, 12
     6ed:	3159           	s32i.n	a5, a1, 12
     6ef:	08a457        	bge	a4, a5, 6fb <cpd_block_proc+0x1c3>
     6f2:	400204        	ae_lp16f.i	aep0, a2, 0
     6f5:	000146        	j	6fe <cpd_block_proc+0x1c6>

000006f8 <cpd_block_proc+0x1c0>:
     6f8:	000506        	j	710 <cpd_block_proc+0x1d8>

000006fb <cpd_block_proc+0x1c3>:
     6fb:	400214        	ae_lp16f.i	aep0, a2, 2
     6fe:	c05540        	sub	a5, a5, a4
     701:	360434        	ae_cvtq48a32s	aeq0, a4
     704:	364534        	ae_cvtq48a32s	aeq1, a5
     707:	000646        	j	724 <cpd_block_proc+0x1ec>

0000070a <cpd_block_proc+0x1d2>:
     70a:	0e9252        	l16si	a5, a2, 28
     70d:	11a500        	slli	a10, a5, 16
     710:	2152a0        	srai	a5, a10, 2
     713:	1ec2f2        	addi	a15, a2, 30
     716:	600404        	ae_lq32f.i	aeq0, a4, 0
     719:	364534        	ae_cvtq48a32s	aeq1, a5
     71c:	f94a9431af 	{ s32i.n	a10, a1, 12; ae_subsq56s	aeq1, aeq1, aeq0 }
     721:	400f04        	ae_lp16f.i	aep0, a15, 0
     724:	f483b0d26e 	{ l32i	a6, a2, 52; ae_mulafq32sp16s.l	aeq0, aeq1, aep0 }
     729:	f288           	l32i.n	a8, a2, 60
     72b:	d248           	l32i.n	a4, a2, 52
     72d:	f3f640        	wur.ae_cbegin0	a4
     730:	fc2451686f 	{ addx2	a6, a8, a6; ae_roundsq32asym	aeq0, aeq0 }
     735:	f3f760        	wur.ae_cend0	a6
     738:	e248           	l32i.n	a4, a2, 56
     73a:	1892f2        	l16si	a15, a2, 48
     73d:	368904        	ae_trunca32q48	a9, aeq0
     740:	3159           	s32i.n	a5, a1, 12
     742:	a2e8           	l32i.n	a14, a2, 40
     744:	260c           	movi.n	a6, 2
     746:	126292        	s32i	a9, a2, 72
     749:	045d           	mov.n	a5, a4
     74b:	378ee4        	ae_truncp24a32x2	aep0, a14, a14
     74e:	fc24d9156f 	{ ae_lp16f.c	aep1, a5, a6; nop }
     753:	362fa6        	blti	a15, 2, 78d <cpd_block_proc+0x255>
     756:	364d34        	ae_cvtq48a32s	aeq1, a13
     759:	fa46ac2b0f 	{ ae_lp16f.i	aep2, a11, 0; ae_subsq56s	aeq2, aeq0, aeq1 }
     75e:	d7ea00018f 	{ movi	a8, 1; ae_mulfq32sp16s.l	aeq2, aeq2, aep2 }
     763:	06a934        	ae_roundsq32asym	aeq2, aeq2
     766:	f9ea60039e 	{ l16si	a9, a3, 0; ae_addsq56s	aeq1, aeq1, aeq2 }
     76b:	d5e740188e 	{ addi	a8, a8, 1; ae_mulfq32sp16s.l	aeq3, aeq1, aep1 }
     770:	649d           	ae_s16i.n	a9, a4, 0
     772:	fb8140233e 	{ addi	a3, a3, 2; ae_mulfq32sp24s.l	aeq3, aeq3, aep0 }
     777:	442b           	addi.n	a4, a4, 2
     779:	35f194        	ae_slliq56	aeq3, aeq3, 6
     77c:	1bbf74        	ae_roundsp16q48asym	aep7, aeq3
     77f:	42f714        	ae_sp16f.l.iu	aep7, a7, 2
     782:	189292        	l16si	a9, a2, 48
     785:	fc24d9156f 	{ ae_lp16f.c	aep1, a5, a6; nop }
     78a:	d82897        	blt	a8, a9, 766 <cpd_block_proc+0x22e>
     78d:	d4e620033e 	{ l16si	a3, a3, 0; ae_mulfq32sp16s.l	aeq0, aeq0, aep1 }
     792:	643d           	ae_s16i.n	a3, a4, 0
     794:	080524        	ae_mulfq32sp24s.l	aeq0, aeq0, aep0
     797:	350194        	ae_slliq56	aeq0, aeq0, 6
     79a:	1b8f74        	ae_roundsp16q48asym	aep7, aeq0
     79d:	42f714        	ae_sp16f.l.iu	aep7, a7, 2
     7a0:	e259           	s32i.n	a5, a2, 56
     7a2:	f01d           	retw.n

000007a4 <compander_VO_proc>:
     7a4:	008136        	entry	a1, 64
     7a7:	121272        	l16ui	a7, a2, 36
     7aa:	065152        	s16i	a5, a1, 12
     7ad:	401164        	ae_lp16f.i	aep1, a1, 12
     7b0:	0ae716        	beqz	a7, 862 <compander_VO_proc+0xbe>
     7b3:	101272        	l16ui	a7, a2, 32
     7b6:	9c9282        	l16si	a8, a2, 0x138
     7b9:	0f5282        	s16i	a8, a2, 30
     7bc:	fcc792        	addi	a9, a7, -4
     7bf:	2339b6        	bltui	a9, 3, 7e6 <compander_VO_proc+0x42>
     7c2:	4437f6        	bgeui	a7, 3, 80a <compander_VO_proc+0x66>
     7c5:	365d           	ae_l16si.n	a5, a6, 2
     7c7:	070c           	movi.n	a7, 0
     7c9:	26ed           	ae_l16si.n	a14, a6, 0
     7cb:	3aa182        	movi	a8, 0x13a
     7ce:	725750        	salt	a5, a7, a5
     7d1:	3ca1f2        	movi	a15, 0x13c
     7d4:	93f850        	movnez	a15, a8, a5
     7d7:	52fa           	add.n	a5, a2, a15
     7d9:	255d           	ae_l16si.n	a5, a5, 0
     7db:	116e00        	slli	a6, a14, 16
     7de:	7169           	s32i.n	a6, a1, 28
     7e0:	0f5252        	s16i	a5, a2, 30
     7e3:	000f46        	j	824 <compander_VO_proc+0x80>

000007e6 <compander_VO_proc+0x42>:
     7e6:	400624        	ae_lp16f.i	aep0, a6, 4
     7e9:	9f12f2        	l16ui	a15, a2, 0x13e
     7ec:	e8208002ef 	{ movi	a14, 2; ae_mulfp24s.hh	aeq0, aep0, aep1 }
     7f1:	3ea152        	movi	a5, 0x13e
     7f4:	340e34        	ae_sllasq56s	aeq0, aeq0, a14
     7f7:	9f8c           	beqz.n	a15, 804 <compander_VO_proc+0x60>
     7f9:	f86799925f 	{ ae_lp16f.x	aep1, a2, a5; ae_roundsp24q48asym	aep0, aeq0 }
     7fe:	010144        	ae_mulfp24s.hh	aeq0, aep0, aep1
     801:	0005c6        	j	81c <compander_VO_proc+0x78>

00000804 <compander_VO_proc+0x60>:
     804:	1cc152        	addi	a5, a1, 28
     807:	000586        	j	821 <compander_VO_proc+0x7d>

0000080a <compander_VO_proc+0x66>:
     80a:	9f1262        	l16ui	a6, a2, 0x13e
     80d:	3ea172        	movi	a7, 0x13e
     810:	401164        	ae_lp16f.i	aep1, a1, 12
     813:	04d616        	beqz	a6, 864 <compander_VO_proc+0xc0>
     816:	410274        	ae_lp16f.x	aep0, a2, a7
     819:	011044        	ae_mulfp24s.hh	aeq0, aep1, aep0
     81c:	fc2441c15e 	{ addi	a5, a1, 28; ae_roundsq32asym	aeq0, aeq0 }
     821:	620504        	ae_sq32f.i	aeq0, a5, 0
     824:	189262        	l16si	a6, a2, 48
     827:	7178           	l32i.n	a7, a1, 28
     829:	360734        	ae_cvtq48a32s	aeq0, a7
     82c:	d24460        	quos	a4, a4, a6
     82f:	2f14a6        	blti	a4, 1, 862 <compander_VO_proc+0xbe>
     832:	fe2171        	l32r	a7, b8 (538 <cpd_block_proc>)
     835:	28c252        	addi	a5, a2, 40
     838:	1166f0        	slli	a6, a6, 1
     83b:	630124        	ae_sq56s.i	aeq0, a1, 16
     83e:	600504        	ae_lq32f.i	aeq0, a5, 0
     841:	614124        	ae_lq56.i	aeq1, a1, 16
     844:	f94aac05ff 	{ ae_lp16f.i	aep0, a5, -2; ae_subsq56s	aeq1, aeq1, aeq0 }
     849:	f48393a22f 	{ or	a10, a2, a2; ae_mulafq32sp16s.l	aeq0, aeq1, aep0 }
     84e:	03bd           	mov.n	a11, a3
     850:	fc244ff44e 	{ addi	a4, a4, -1; ae_roundsq32asym	aeq0, aeq0 }
     855:	368804        	ae_trunca32q48	a8, aeq0
     858:	a289           	s32i.n	a8, a2, 40
     85a:	0007e0        	callx8	a7
     85d:	336a           	add.n	a3, a3, a6
     85f:	fdb456        	bnez	a4, 83e <compander_VO_proc+0x9a>
     862:	f01d           	retw.n

00000864 <compander_VO_proc+0xc0>:
     864:	115500        	slli	a5, a5, 16
     867:	7159           	s32i.n	a5, a1, 28
     869:	ffedc6        	j	824 <compander_VO_proc+0x80>

0000086c <compander_AU_PARA_init>:
     86c:	004136        	entry	a1, 32
     86f:	fe0c71        	l32r	a7, a0 (1bdc <xt_memcpy>)
     872:	4f2426        	beqi	a4, 2, 8c5 <compander_AU_PARA_init+0x59>
     875:	021466        	bnei	a4, 1, 87b <compander_AU_PARA_init+0xf>
     878:	0021c6        	j	903 <compander_AU_PARA_init+0x97>
     87b:	0f0456        	bnez	a4, 96f <compander_AU_PARA_init+0x103>
     87e:	34c242        	addi	a4, a2, 52
     881:	3cc2b2        	addi	a11, a2, 60
     884:	93b450        	movnez	a11, a4, a5
     887:	4c0c           	movi.n	a12, 4
     889:	03ad           	mov.n	a10, a3
     88b:	0007e0        	callx8	a7
     88e:	a38b           	addi.n	a10, a3, 8
     890:	44c2b2        	addi	a11, a2, 68
     893:	9c0c           	movi.n	a12, 9
     895:	0007e0        	callx8	a7
     898:	028626        	beqi	a6, 8, 89e <compander_AU_PARA_init+0x32>
     89b:	003406        	j	96f <compander_AU_PARA_init+0x103>
     89e:	2348           	l32i.n	a4, a3, 8
     8a0:	43d8           	l32i.n	a13, a3, 16
     8a2:	3358           	l32i.n	a5, a3, 12
     8a4:	448b           	addi.n	a4, a4, 8
     8a6:	53e8           	l32i.n	a14, a3, 20
     8a8:	214440        	srai	a4, a4, 4
     8ab:	2349           	s32i.n	a4, a3, 8
     8ad:	4d8b           	addi.n	a4, a13, 8
     8af:	558b           	addi.n	a5, a5, 8
     8b1:	214440        	srai	a4, a4, 4
     8b4:	fe8b           	addi.n	a15, a14, 8
     8b6:	215450        	srai	a5, a5, 4
     8b9:	4349           	s32i.n	a4, a3, 16
     8bb:	2144f0        	srai	a4, a15, 4
     8be:	3359           	s32i.n	a5, a3, 12
     8c0:	5349           	s32i.n	a4, a3, 20
     8c2:	002a46        	j	96f <compander_AU_PARA_init+0x103>

000008c5 <compander_AU_PARA_init+0x59>:
     8c5:	645c           	movi.n	a4, 86
     8c7:	a85c           	movi.n	a8, 90
     8c9:	938450        	movnez	a8, a4, a5
     8cc:	828a           	add.n	a8, a2, a8
     8ce:	895c           	movi.n	a9, 88
     8d0:	cd5c           	movi.n	a13, 92
     8d2:	5e3c           	movi.n	a14, 53
     8d4:	93d950        	movnez	a13, a9, a5
     8d7:	115ea0        	slli	a5, a14, 6
     8da:	0dd3f2        	addmi	a15, a3, 0xd00
     8dd:	288d           	ae_l16si.n	a8, a8, 0
     8df:	535a           	add.n	a5, a3, a5
     8e1:	205f82        	s16i	a8, a15, 64
     8e4:	42da           	add.n	a4, a2, a13
     8e6:	244d           	ae_l16si.n	a4, a4, 0
     8e8:	5ec2b2        	addi	a11, a2, 94
     8eb:	a58b           	addi.n	a10, a5, 8
     8ed:	4c0c           	movi.n	a12, 4
     8ef:	235f42        	s16i	a4, a15, 70
     8f2:	0007e0        	callx8	a7
     8f5:	18c5a2        	addi	a10, a5, 24
     8f8:	32c2b2        	addi	a11, a2, 50
     8fb:	1c0c           	movi.n	a12, 1
     8fd:	0007e0        	callx8	a7
     900:	001ac6        	j	96f <compander_AU_PARA_init+0x103>

00000903 <compander_AU_PARA_init+0x97>:
     903:	a0a642        	movi	a4, 0x6a0
     906:	071526        	beqi	a5, 1, 911 <compander_AU_PARA_init+0xa5>
     909:	b5cc           	bnez.n	a5, 918 <compander_AU_PARA_init+0xac>
     90b:	12c2b2        	addi	a11, a2, 18
     90e:	000046        	j	913 <compander_AU_PARA_init+0xa7>

00000911 <compander_AU_PARA_init+0xa5>:
     911:	b2ab           	addi.n	a11, a2, 10
     913:	a34a           	add.n	a10, a3, a4
     915:	0003c6        	j	928 <compander_AU_PARA_init+0xbc>

00000918 <compander_AU_PARA_init+0xac>:
     918:	a34a           	add.n	a10, a3, a4
     91a:	052566        	bnei	a5, 2, 923 <compander_AU_PARA_init+0xb7>
     91d:	1ac2b2        	addi	a11, a2, 26
     920:	000106        	j	928 <compander_AU_PARA_init+0xbc>

00000923 <compander_AU_PARA_init+0xb7>:
     923:	c0a142        	movi	a4, 0x1c0
     926:	b24a           	add.n	a11, a2, a4
     928:	4c0c           	movi.n	a12, 4
     92a:	0007e0        	callx8	a7
     92d:	a8a642        	movi	a4, 0x6a8
     930:	22c2b2        	addi	a11, a2, 34
     933:	a34a           	add.n	a10, a3, a4
     935:	9c0c           	movi.n	a12, 9
     937:	0007e0        	callx8	a7
     93a:	318666        	bnei	a6, 8, 96f <compander_AU_PARA_init+0x103>
     93d:	06d342        	addmi	a4, a3, 0x600
     940:	2a2482        	l32i	a8, a4, 168
     943:	2c24c2        	l32i	a12, a4, 176
     946:	2b2492        	l32i	a9, a4, 172
     949:	888b           	addi.n	a8, a8, 8
     94b:	2d24e2        	l32i	a14, a4, 180
     94e:	06d352        	addmi	a5, a3, 0x600
     951:	218480        	srai	a8, a8, 4
     954:	2a6482        	s32i	a8, a4, 168
     957:	4c8b           	addi.n	a4, a12, 8
     959:	d98b           	addi.n	a13, a9, 8
     95b:	214440        	srai	a4, a4, 4
     95e:	fe8b           	addi.n	a15, a14, 8
     960:	2184d0        	srai	a8, a13, 4
     963:	2c6542        	s32i	a4, a5, 176
     966:	2144f0        	srai	a4, a15, 4
     969:	2b6582        	s32i	a8, a5, 172
     96c:	2d6542        	s32i	a4, a5, 180
     96f:	80a042        	movi	a4, 128
     972:	c8a152        	movi	a5, 0x1c8
     975:	a34a           	add.n	a10, a3, a4
     977:	b25a           	add.n	a11, a2, a5
     979:	5c0c           	movi.n	a12, 5
     97b:	0007e0        	callx8	a7
     97e:	20a742        	movi	a4, 0x720
     981:	66c222        	addi	a2, a2, 102
     984:	a34a           	add.n	a10, a3, a4
     986:	5c0c           	movi.n	a12, 5
     988:	02bd           	mov.n	a11, a2
     98a:	0007e0        	callx8	a7
     98d:	743c           	movi.n	a4, 55
     98f:	1144a0        	slli	a4, a4, 6
     992:	a34a           	add.n	a10, a3, a4
     994:	5c0c           	movi.n	a12, 5
     996:	02bd           	mov.n	a11, a2
     998:	0007e0        	callx8	a7
     99b:	258666        	bnei	a6, 8, 9c4 <compander_AU_PARA_init+0x158>
     99e:	44c322        	addi	a2, a3, 68
     9a1:	f258           	l32i.n	a5, a2, 60
     9a3:	07d342        	addmi	a4, a3, 0x700
     9a6:	0dd3d2        	addmi	a13, a3, 0xd00
     9a9:	8468           	l32i.n	a6, a4, 32
     9ab:	302d72        	l32i	a7, a13, 192
     9ae:	558b           	addi.n	a5, a5, 8
     9b0:	215450        	srai	a5, a5, 4
     9b3:	e68b           	addi.n	a14, a6, 8
     9b5:	f78b           	addi.n	a15, a7, 8
     9b7:	f259           	s32i.n	a5, a2, 60
     9b9:	2124e0        	srai	a2, a14, 4
     9bc:	2154f0        	srai	a5, a15, 4
     9bf:	8429           	s32i.n	a2, a4, 32
     9c1:	306d52        	s32i	a5, a13, 192
     9c4:	f01d           	retw.n

000009c6 <compander_AU_PARA_init+0x15a>:
	...

000009c8 <compander_AU_Sub_init>:
     9c8:	006136        	entry	a1, 48
     9cb:	fdb681        	l32r	a8, a4 (1bc8 <xt_memset>)
     9ce:	0b0c           	movi.n	a11, 0
     9d0:	50a3c2        	movi	a12, 0x350
     9d3:	04ad           	mov.n	a10, a4
     9d5:	0008e0        	callx8	a8
     9d8:	fdb981        	l32r	a8, bc (86c <compander_AU_PARA_init>)
     9db:	02ad           	mov.n	a10, a2
     9dd:	03bd           	mov.n	a11, a3
     9df:	05cd           	mov.n	a12, a5
     9e1:	06dd           	mov.n	a13, a6
     9e3:	07ed           	mov.n	a14, a7
     9e5:	0008e0        	callx8	a8
     9e8:	13d322        	addmi	a2, a3, 0x1300
     9eb:	7412a2        	l16ui	a10, a2, 232
     9ee:	00a422        	movi	a2, 0x400
     9f1:	084c           	movi.n	a8, 64
     9f3:	138a66        	bnei	a10, 8, a0a <compander_AU_Sub_init+0x42>
     9f6:	120c           	movi.n	a2, 1
     9f8:	190c           	movi.n	a9, 1
     9fa:	112240        	slli	a2, a2, 12
     9fd:	115422        	s16i	a2, a4, 34
     a00:	081c           	movi.n	a8, 16
     a02:	119950        	slli	a9, a9, 11
     a05:	820c           	movi.n	a2, 8
     a07:	000746        	j	a28 <compander_AU_Sub_init+0x60>

00000a0a <compander_AU_Sub_init+0x42>:
     a0a:	129a66        	bnei	a10, 10, a20 <compander_AU_Sub_init+0x58>
     a0d:	cda022        	movi	a2, 205
     a10:	0cd222        	addmi	a2, a2, 0xc00
     a13:	115422        	s16i	a2, a4, 34
     a16:	481c           	movi.n	a8, 20
     a18:	66a692        	movi	a9, 0x666
     a1b:	a20c           	movi.n	a2, 10
     a1d:	0001c6        	j	a28 <compander_AU_Sub_init+0x60>

00000a20 <compander_AU_Sub_init+0x58>:
     a20:	115422        	s16i	a2, a4, 34
     a23:	00a292        	movi	a9, 0x200
     a26:	022c           	movi.n	a2, 32
     a28:	1c0c           	movi.n	a12, 1
     a2a:	1f0c           	movi.n	a15, 1
     a2c:	105422        	s16i	a2, a4, 32
     a2f:	f8c7d2        	addi	a13, a7, -8
     a32:	01cc50        	slli	a12, a12, 27
     a35:	012f90        	slli	a2, a15, 23
     a38:	3179           	s32i.n	a7, a1, 12
     a3a:	0f2566        	bnei	a5, 2, a4d <compander_AU_Sub_init+0x85>
     a3d:	1a0c           	movi.n	a10, 1
     a3f:	01aa20        	slli	a10, a10, 30
     a42:	0d7d           	mov.n	a7, a13
     a44:	0c3d           	mov.n	a3, a12
     a46:	b489           	s32i.n	a8, a4, 44
     a48:	a4a9           	s32i.n	a10, a4, 40
     a4a:	000c46        	j	a7f <compander_AU_Sub_init+0xb7>

00000a4d <compander_AU_Sub_init+0x85>:
     a4d:	068a66        	bnei	a10, 8, a57 <compander_AU_Sub_init+0x8f>
     a50:	8a1c           	movi.n	a10, 24
     a52:	0b3c           	movi.n	a11, 48
     a54:	0003c6        	j	a67 <compander_AU_Sub_init+0x9f>

00000a57 <compander_AU_Sub_init+0x8f>:
     a57:	069a66        	bnei	a10, 10, a61 <compander_AU_Sub_init+0x99>
     a5a:	ea1c           	movi.n	a10, 30
     a5c:	cb3c           	movi.n	a11, 60
     a5e:	000146        	j	a67 <compander_AU_Sub_init+0x9f>

00000a61 <compander_AU_Sub_init+0x99>:
     a61:	60a0a2        	movi	a10, 96
     a64:	c0a0b2        	movi	a11, 192
     a67:	b4a9           	s32i.n	a10, a4, 44
     a69:	02ad           	mov.n	a10, a2
     a6b:	93acd0        	movnez	a10, a12, a13
     a6e:	0c3d           	mov.n	a3, a12
     a70:	0d7d           	mov.n	a7, a13
     a72:	a4a9           	s32i.n	a10, a4, 40
     a74:	0726a6        	blti	a6, 2, a7f <compander_AU_Sub_init+0xb7>
     a77:	b4b9           	s32i.n	a11, a4, 44
     a79:	105482        	s16i	a8, a4, 32
     a7c:	115492        	s16i	a9, a4, 34
     a7f:	54b8           	l32i.n	a11, a4, 20
     a81:	24c8           	l32i.n	a12, a4, 8
     a83:	fd8f61        	l32r	a6, c0 (16f8 <calc_slope>)
     a86:	0006e0        	callx8	a6
     a89:	a0a0c2        	movi	a12, 160
     a8c:	fd7c           	movi.n	a13, -1
     a8e:	932370        	movnez	a2, a3, a7
     a91:	060c           	movi.n	a6, 0
     a93:	34ca           	add.n	a3, a4, a12
     a95:	0d5452        	s16i	a5, a4, 26
     a98:	4151d0        	srli	a5, a13, 1
     a9b:	31e8           	l32i.n	a14, a1, 12
     a9d:	1f0c           	movi.n	a15, 1
     a9f:	3f54e2        	s16i	a14, a4, 126
     aa2:	136462        	s32i	a6, a4, 76
     aa5:	126462        	s32i	a6, a4, 72
     aa8:	74f9           	s32i.n	a15, a4, 28
     aaa:	f429           	s32i.n	a2, a4, 60
     aac:	3c54a2        	s16i	a10, a4, 120
     aaf:	c439           	s32i.n	a3, a4, 48
     ab1:	d439           	s32i.n	a3, a4, 52
     ab3:	106452        	s32i	a5, a4, 64
     ab6:	f01d           	retw.n

00000ab8 <DBB_PARA_init>:
     ab8:	004136        	entry	a1, 32
     abb:	fd7941        	l32r	a4, a0 (1bdc <xt_memcpy>)
     abe:	70c2b2        	addi	a11, a2, 112
     ac1:	4c0c           	movi.n	a12, 4
     ac3:	03ad           	mov.n	a10, a3
     ac5:	0004e0        	callx8	a4
     ac8:	a38b           	addi.n	a10, a3, 8
     aca:	7cc2b2        	addi	a11, a2, 124
     acd:	2c0c           	movi.n	a12, 2
     acf:	0004e0        	callx8	a4
     ad2:	f01d           	retw.n

00000ad4 <DBB_init>:
     ad4:	004136        	entry	a1, 32
     ad7:	fd7341        	l32r	a4, a4 (1bc8 <xt_memset>)
     ada:	0b0c           	movi.n	a11, 0
     adc:	ac0c           	movi.n	a12, 10
     ade:	03ad           	mov.n	a10, a3
     ae0:	0004e0        	callx8	a4
     ae3:	fd6f41        	l32r	a4, a0 (1bdc <xt_memcpy>)
     ae6:	70c2b2        	addi	a11, a2, 112
     ae9:	4c0c           	movi.n	a12, 4
     aeb:	03ad           	mov.n	a10, a3
     aed:	0004e0        	callx8	a4
     af0:	a38b           	addi.n	a10, a3, 8
     af2:	7cc2b2        	addi	a11, a2, 124
     af5:	2c0c           	movi.n	a12, 2
     af7:	0004e0        	callx8	a4
     afa:	0328           	l32i.n	a2, a3, 0
     afc:	140c           	movi.n	a4, 1
     afe:	150c           	movi.n	a5, 1
     b00:	015520        	slli	a5, a5, 30
     b03:	014450        	slli	a4, a4, 27
     b06:	ff7c           	movi.n	a15, -1
     b08:	4349           	s32i.n	a4, a3, 16
     b0a:	725250        	salt	a5, a2, a5
     b0d:	4141f0        	srli	a4, a15, 1
     b10:	1122f0        	slli	a2, a2, 1
     b13:	934250        	movnez	a4, a2, a5
     b16:	3349           	s32i.n	a4, a3, 12
     b18:	f01d           	retw.n

00000b1a <DBB_init+0x46>:
	...

00000b1c <AU_GBL_init>:
     b1c:	004136        	entry	a1, 32
     b1f:	fd6051        	l32r	a5, a0 (1bdc <xt_memcpy>)
     b22:	2c0c           	movi.n	a12, 2
     b24:	03ad           	mov.n	a10, a3
     b26:	02bd           	mov.n	a11, a2
     b28:	0005e0        	callx8	a5
     b2b:	000362        	l8ui	a6, a3, 0
     b2e:	10a272        	movi	a7, 0x210
     b31:	636d           	ae_s16i.n	a6, a3, 0
     b33:	fd5c61        	l32r	a6, a4 (1bc8 <xt_memset>)
     b36:	a37a           	add.n	a10, a3, a7
     b38:	0b0c           	movi.n	a11, 0
     b3a:	0c1c           	movi.n	a12, 16
     b3c:	0006e0        	callx8	a6
     b3f:	30a272        	movi	a7, 0x230
     b42:	a37a           	add.n	a10, a3, a7
     b44:	0b0c           	movi.n	a11, 0
     b46:	0c2c           	movi.n	a12, 32
     b48:	0006e0        	callx8	a6
     b4b:	a34b           	addi.n	a10, a3, 4
     b4d:	78c2b2        	addi	a11, a2, 120
     b50:	2c0c           	movi.n	a12, 2
     b52:	0005e0        	callx8	a5
     b55:	1e2262        	l32i	a6, a2, 120
     b58:	70a282        	movi	a8, 0x270
     b5b:	80a072        	movi	a7, 128
     b5e:	101626        	beqi	a6, 1, b72 <AU_GBL_init+0x56>
     b61:	b6ec           	bnez.n	a6, b90 <AU_GBL_init+0x74>
     b63:	a38a           	add.n	a10, a3, a8
     b65:	b27a           	add.n	a11, a2, a7
     b67:	8c2c           	movi.n	a12, 40
     b69:	0005e0        	callx8	a5
     b6c:	d0a062        	movi	a6, 208
     b6f:	000446        	j	b84 <AU_GBL_init+0x68>

00000b72 <AU_GBL_init+0x56>:
     b72:	70a262        	movi	a6, 0x270
     b75:	20a172        	movi	a7, 0x120
     b78:	a36a           	add.n	a10, a3, a6
     b7a:	b27a           	add.n	a11, a2, a7
     b7c:	8c2c           	movi.n	a12, 40
     b7e:	0005e0        	callx8	a5
     b81:	70a162        	movi	a6, 0x170
     b84:	c0a2f2        	movi	a15, 0x2c0
     b87:	b26a           	add.n	a11, a2, a6
     b89:	a3fa           	add.n	a10, a3, a15
     b8b:	8c2c           	movi.n	a12, 40
     b8d:	0005e0        	callx8	a5
     b90:	041322        	l16ui	a2, a3, 8
     b93:	160c           	movi.n	a6, 1
     b95:	170c           	movi.n	a7, 1
     b97:	052c           	movi.n	a5, 32
     b99:	f6c2e2        	addi	a14, a2, -10
     b9c:	f8c442        	addi	a4, a4, -8
     b9f:	0166a0        	slli	a6, a6, 22
     ba2:	0177e0        	slli	a7, a7, 18
     ba5:	f8c2f2        	addi	a15, a2, -8
     ba8:	8352e0        	moveqz	a5, a2, a14
     bab:	eca182        	movi	a8, 0x1ec
     bae:	937640        	movnez	a7, a6, a4
     bb1:	8352f0        	moveqz	a5, a2, a15
     bb4:	055382        	s16i	a8, a3, 10
     bb7:	3379           	s32i.n	a7, a3, 12
     bb9:	045352        	s16i	a5, a3, 8
     bbc:	f01d           	retw.n

00000bbe <AU_GBL_init+0xa2>:
	...

00000bc0 <compander_AU_SetFrame120_init>:
     bc0:	004136        	entry	a1, 32
     bc3:	a30c           	movi.n	a3, 10
     bc5:	13d222        	addmi	a2, a2, 0x1300
     bc8:	745232        	s16i	a3, a2, 232
     bcb:	f01d           	retw.n

00000bcd <compander_AU_SetFrame120_init+0xd>:
     bcd:	000000                                        ...

00000bd0 <compander_AU_SetFrame8_init>:
     bd0:	004136        	entry	a1, 32
     bd3:	830c           	movi.n	a3, 8
     bd5:	13d222        	addmi	a2, a2, 0x1300
     bd8:	745232        	s16i	a3, a2, 232
     bdb:	f01d           	retw.n

00000bdd <compander_AU_SetFrame8_init+0xd>:
     bdd:	000000                                        ...

00000be0 <compander_AU_init>:
     be0:	00a136        	entry	a1, 80
     be3:	583c           	movi.n	a8, 53
     be5:	9fa092        	movi	a9, 159
     be8:	6fa1a2        	movi	a10, 0x16f
     beb:	1188a0        	slli	a8, a8, 6
     bee:	1199b0        	slli	a9, a9, 5
     bf1:	11aac0        	slli	a10, a10, 4
     bf4:	f2aa           	add.n	a15, a2, a10
     bf6:	056d           	mov.n	a6, a5
     bf8:	a0a6c2        	movi	a12, 0x6a0
     bfb:	d28a           	add.n	a13, a2, a8
     bfd:	e29a           	add.n	a14, a2, a9
     bff:	fd3151        	l32r	a5, c4 (9c8 <compander_AU_Sub_init>)
     c02:	72ca           	add.n	a7, a2, a12
     c04:	91d9           	s32i.n	a13, a1, 36
     c06:	a1e9           	s32i.n	a14, a1, 40
     c08:	b1f9           	s32i.n	a15, a1, 44
     c0a:	0d0c           	movi.n	a13, 0
     c0c:	03ad           	mov.n	a10, a3
     c0e:	02bd           	mov.n	a11, a2
     c10:	02cd           	mov.n	a12, a2
     c12:	06ed           	mov.n	a14, a6
     c14:	04fd           	mov.n	a15, a4
     c16:	0005e0        	callx8	a5
     c19:	1d0c           	movi.n	a13, 1
     c1b:	03ad           	mov.n	a10, a3
     c1d:	02bd           	mov.n	a11, a2
     c1f:	07cd           	mov.n	a12, a7
     c21:	06ed           	mov.n	a14, a6
     c23:	04fd           	mov.n	a15, a4
     c25:	0005e0        	callx8	a5
     c28:	91c8           	l32i.n	a12, a1, 36
     c2a:	2d0c           	movi.n	a13, 2
     c2c:	03ad           	mov.n	a10, a3
     c2e:	02bd           	mov.n	a11, a2
     c30:	06ed           	mov.n	a14, a6
     c32:	04fd           	mov.n	a15, a4
     c34:	0005e0        	callx8	a5
     c37:	fd2451        	l32r	a5, c8 (b1c <AU_GBL_init>)
     c3a:	a1b8           	l32i.n	a11, a1, 40
     c3c:	03ad           	mov.n	a10, a3
     c3e:	04cd           	mov.n	a12, a4
     c40:	0005e0        	callx8	a5
     c43:	fd2241        	l32r	a4, cc (ad4 <DBB_init>)
     c46:	b1b8           	l32i.n	a11, a1, 44
     c48:	03ad           	mov.n	a10, a3
     c4a:	0004e0        	callx8	a4
     c4d:	350c           	movi.n	a5, 3
     c4f:	940c           	movi.n	a4, 9
     c51:	84a032        	movi	a3, 132
     c54:	015550        	slli	a5, a5, 27
     c57:	580c           	movi.n	a8, 5
     c59:	606234        	ae_lq32f.x	aeq1, a2, a3
     c5c:	114450        	slli	a4, a4, 11
     c5f:	113850        	slli	a3, a8, 11
     c62:	36c534        	ae_cvtq48a32s	aeq3, a5
     c65:	fd1c7a940f 	{ ae_slliq56	aeq0, aeq1, 16; ae_movq56	aeq1, aeq3 }
     c6a:	300344        	ae_cvtp24a16x2.ll	aep0, a3, a4
     c6d:	f840cffd9f 	{ movi	a9, -3; ae_mulsfq32sp24s.h	aeq1, aeq0, aep0 }
     c72:	015950        	slli	a5, a9, 27
     c75:	fd2c7ec5bf 	{ ae_cvtq48a32s	aeq2, a5; ae_roundsq32asym	aeq1, aeq1 }
     c7a:	f5c2ba213f 	{ ae_sq56s.i	aeq2, a1, 24; ae_mulafq32sp24s.l	aeq2, aeq0, aep0 }
     c7f:	fd1c7a112f 	{ ae_sq56s.i	aeq1, a1, 16; ae_movq56	aeq1, aeq3 }
     c84:	f8c0c090af 	{ movi	a10, 144; ae_mulsfq32sp24s.l	aeq1, aeq0, aep0 }
     c89:	610124        	ae_lq56.i	aeq0, a1, 16
     c8c:	fd2c7ae09f 	{ ae_sllisq56s	aeq2, aeq2, 1; ae_roundsq32asym	aeq1, aeq1 }
     c91:	fc34788a2f 	{ ae_sq32f.xu	aeq0, a10, a2; ae_roundsq32asym	aeq0, aeq2 }
     c96:	fd1c799a2f 	{ ae_sq32f.i	aeq1, a10, 8; ae_movq56	aeq1, aeq3 }
     c9b:	24a7c2        	movi	a12, 0x724
     c9e:	620a14        	ae_sq32f.i	aeq0, a10, 4
     ca1:	6022c4        	ae_lq32f.x	aeq0, a2, a12
     ca4:	350414        	ae_slliq56	aeq0, aeq0, 16
     ca7:	f940fdc13f 	{ ae_lq56.i	aeq2, a1, 24; ae_mulsfq32sp24s.h	aeq3, aeq0, aep0 }
     cac:	f5c28730df 	{ movi	a13, 0x730; ae_mulafq32sp24s.l	aeq2, aeq0, aep0 }
     cb1:	080924        	ae_mulsfq32sp24s.l	aeq1, aeq0, aep0
     cb4:	ff3c7ae09f 	{ ae_sllisq56s	aeq2, aeq2, 1; ae_roundsq32asym	aeq3, aeq3 }
     cb9:	fd2c78bd2f 	{ ae_sq32f.xu	aeq3, a13, a2; ae_roundsq32asym	aeq1, aeq1 }
     cbe:	ff34799d2f 	{ ae_sq32f.i	aeq1, a13, 8; ae_roundsq32asym	aeq3, aeq2 }
     cc3:	07d2e2        	addmi	a14, a2, 0x700
     cc6:	623d14        	ae_sq32f.i	aeq3, a13, 4
     cc9:	0dd2b2        	addmi	a11, a2, 0xd00
     ccc:	0d28           	l32i.n	a2, a13, 0
     cce:	def8           	l32i.n	a15, a14, 52
     cd0:	ee58           	l32i.n	a5, a14, 56
     cd2:	346b22        	s32i	a2, a11, 208
     cd5:	356bf2        	s32i	a15, a11, 212
     cd8:	366b52        	s32i	a5, a11, 216
     cdb:	f01d           	retw.n

00000cdd <compander_AU_init+0xfd>:
     cdd:	000000                                        ...

00000ce0 <F_CPD_Ins_Gain>:
     ce0:	006136        	entry	a1, 48
     ce3:	8ca032        	movi	a3, 140
     ce6:	202242        	l32i	a4, a2, 128
     ce9:	b23a           	add.n	a11, a2, a3
     ceb:	2149           	s32i.n	a4, a1, 8
     ced:	318b           	addi.n	a3, a1, 8
     cef:	fceb41        	l32r	a4, 9c (288 <Xdiv>)
     cf2:	03ad           	mov.n	a10, a3
     cf4:	0004e0        	callx8	a4
     cf7:	242252        	l32i	a5, a2, 144
     cfa:	2159           	s32i.n	a5, a1, 8
     cfc:	115a00        	slli	a5, a10, 16
     cff:	b1cb           	addi.n	a11, a1, 12
     d01:	03ad           	mov.n	a10, a3
     d03:	3159           	s32i.n	a5, a1, 12
     d05:	0004e0        	callx8	a4
     d08:	2622e2        	l32i	a14, a2, 152
     d0b:	252242        	l32i	a4, a2, 148
     d0e:	11fa00        	slli	a15, a10, 16
     d11:	b225e0        	mulsh	a2, a5, a14
     d14:	360434        	ae_cvtq48a32s	aeq0, a4
     d17:	1122f0        	slli	a2, a2, 1
     d1a:	364f34        	ae_cvtq48a32s	aeq1, a15
     d1d:	f86a7ec2ff 	{ ae_cvtq48a32s	aeq3, a2; ae_addsq56s	aeq0, aeq1, aeq0 }
     d22:	f8e654212f 	{ s32i.n	a2, a1, 8; ae_addsq56s	aeq0, aeq0, aeq3 }
     d27:	360094        	ae_sllisq56s	aeq0, aeq0, 2
     d2a:	060934        	ae_roundsq32asym	aeq0, aeq0
     d2d:	620304        	ae_sq32f.i	aeq0, a3, 0
     d30:	2128           	l32i.n	a2, a1, 8
     d32:	f01d           	retw.n

00000d34 <F_CPD_Mag_In>:
     d34:	008136        	entry	a1, 64
     d37:	fd24a1027e 	{ l16si	a7, a2, 32; ae_zeroq56	aeq1 }
     d3c:	fe0c42228e 	{ addi	a8, a2, 34; ae_movq56	aeq2, aeq1 }
     d41:	400804        	ae_lp16f.i	aep0, a8, 0
     d44:	1317a6        	blti	a7, 1, d5b <F_CPD_Mag_In+0x27>
     d47:	fcc332        	addi	a3, a3, -4
     d4a:	60d314        	ae_lq32f.iu	aeq3, a3, 4
     d4d:	0a8776        	loop	a7, d5b <F_CPD_Mag_In+0x27>
     d50:	fc84bd731f 	{ ae_lq32f.iu	aeq3, a3, 4; ae_absq56	aeq0, aeq3 }
     d55:	080b24        	ae_mulafq32sp24s.l	aeq1, aeq0, aep0
     d58:	0182c4        	ae_maxq56s	aeq2, aeq2, aeq0

00000d5b <F_CPD_Mag_In+0x27>:
     d5b:	fc248fc43e 	{ addi	a3, a4, -4; ae_zeroq56	aeq0 }
     d60:	212566        	bnei	a5, 2, d85 <F_CPD_Mag_In+0x51>
     d63:	1e17a6        	blti	a7, 1, d85 <F_CPD_Mag_In+0x51>
     d66:	60d314        	ae_lq32f.iu	aeq3, a3, 4
     d69:	188776        	loop	a7, d85 <F_CPD_Mag_In+0x51>
     d6c:	06db64        	ae_absq56	aeq3, aeq3
     d6f:	633124        	ae_sq56s.i	aeq3, a1, 16
     d72:	60d314        	ae_lq32f.iu	aeq3, a3, 4
     d75:	633134        	ae_sq56s.i	aeq3, a1, 24
     d78:	61c124        	ae_lq56.i	aeq3, a1, 16
     d7b:	fafb3de12f 	{ ae_lq56.i	aeq3, a1, 16; ae_maxq56s	aeq2, aeq2, aeq3 }
     d80:	f6c3bde13f 	{ ae_lq56.i	aeq3, a1, 24; ae_mulafq32sp24s.l	aeq0, aeq3, aep0 }
     d85:	fe80cfff3f 	{ movi	a3, -1; ae_satq48s	aeq2, aeq2 }
     d8a:	301666        	bnei	a6, 1, dbe <F_CPD_Mag_In+0x8a>
     d8d:	fd2c40003f 	{ movi	a3, 0; ae_roundsq32asym	aeq1, aeq1 }
     d92:	fc2440014f 	{ movi	a4, 1; ae_roundsq32asym	aeq0, aeq0 }
     d97:	098104        	ae_ltq56s	b0, aeq1, aeq0
     d9a:	d33400        	movt	a3, a4, b0
     d9d:	138c           	beqz.n	a3, da2 <F_CPD_Mag_In+0x6e>
     d9f:	064b34        	ae_movq56	aeq1, aeq0

00000da2 <F_CPD_Mag_In+0x6e>:
     da2:	8ca032        	movi	a3, 140
     da5:	1f0c           	movi.n	a15, 1
     da7:	602234        	ae_lq32f.x	aeq0, a2, a3
     daa:	113f40        	slli	a3, a15, 12
     dad:	f94a98833f 	{ ae_cvtp24a16x2.ll	aep0, a3, a3; ae_subsq56s	aeq1, aeq1, aeq0 }
     db2:	030054        	ae_mulafq32sp16s.l	aeq0, aeq1, aep0
     db5:	060934        	ae_roundsq32asym	aeq0, aeq0
     db8:	368304        	ae_trunca32q48	a3, aeq0
     dbb:	000086        	j	dc1 <F_CPD_Mag_In+0x8d>

00000dbe <F_CPD_Mag_In+0x8a>:
     dbe:	413130        	srli	a3, a3, 1
     dc1:	236232        	s32i	a3, a2, 140
     dc4:	36a204        	ae_trunca32q48	a2, aeq2
     dc7:	f01d           	retw.n

00000dc9 <F_CPD_Mag_In+0x95>:
     dc9:	000000                                        ...

00000dcc <F_CPD_Max_In_Buf>:
     dcc:	006136        	entry	a1, 48
     dcf:	a248           	l32i.n	a4, a2, 40
     dd1:	150c           	movi.n	a5, 1
     dd3:	04a437        	bge	a4, a3, ddb <F_CPD_Max_In_Buf+0xf>
     dd6:	a239           	s32i.n	a3, a2, 40
     dd8:	0f5252        	s16i	a5, a2, 30

00000ddb <F_CPD_Max_In_Buf+0xf>:
     ddb:	0e1242        	l16ui	a4, a2, 28
     dde:	0c1252        	l16ui	a5, a2, 24
     de1:	122262        	l32i	a6, a2, 72
     de4:	1322f2        	l32i	a15, a2, 76
     de7:	589457        	bne	a4, a5, e43 <F_CPD_Max_In_Buf+0x77>
     dea:	142252        	l32i	a5, a2, 80
     ded:	122262        	l32i	a6, a2, 72
     df0:	140c           	movi.n	a4, 1
     df2:	0e5242        	s16i	a4, a2, 28
     df5:	534560        	max	a4, a5, a6
     df8:	770c           	movi.n	a7, 7
     dfa:	50c252        	addi	a5, a2, 80
     dfd:	3149           	s32i.n	a4, a1, 12
     dff:	088776        	loop	a7, e0b <F_CPD_Max_In_Buf+0x3f>
     e02:	1568           	l32i.n	a6, a5, 4
     e04:	0569           	s32i.n	a6, a5, 0
     e06:	554b           	addi.n	a5, a5, 4
     e08:	534460        	max	a4, a4, a6

00000e0b <F_CPD_Max_In_Buf+0x3f>:
     e0b:	0f9272        	l16si	a7, a2, 30
     e0e:	122262        	l32i	a6, a2, 72
     e11:	136242        	s32i	a4, a2, 76
     e14:	0569           	s32i.n	a6, a5, 0
     e16:	3149           	s32i.n	a4, a1, 12
     e18:	126232        	s32i	a3, a2, 72
     e1b:	3517a6        	blti	a7, 1, e54 <F_CPD_Max_In_Buf+0x88>
     e1e:	a2a8           	l32i.n	a10, a2, 40
     e20:	52b8           	l32i.n	a11, a2, 20
     e22:	22c8           	l32i.n	a12, a2, 8
     e24:	fca731        	l32r	a3, c0 (16f8 <calc_slope>)
     e27:	0003e0        	callx8	a3
     e2a:	ffa032        	movi	a3, 255
     e2d:	7fd332        	addmi	a3, a3, 0x7f00
     e30:	80daf2        	addmi	a15, a10, 0xffff8000
     e33:	933af0        	movnez	a3, a10, a15
     e36:	040c           	movi.n	a4, 0
     e38:	0f5242        	s16i	a4, a2, 30
     e3b:	3139           	s32i.n	a3, a1, 12
     e3d:	3c5232        	s16i	a3, a2, 120
     e40:	000406        	j	e54 <F_CPD_Max_In_Buf+0x88>

00000e43 <F_CPD_Max_In_Buf+0x77>:
     e43:	441b           	addi.n	a4, a4, 1
     e45:	533630        	max	a3, a6, a3
     e48:	126232        	s32i	a3, a2, 72
     e4b:	5333f0        	max	a3, a3, a15
     e4e:	0e5242        	s16i	a4, a2, 28
     e51:	136232        	s32i	a3, a2, 76
     e54:	132242        	l32i	a4, a2, 76
     e57:	2238           	l32i.n	a3, a2, 8
     e59:	202262        	l32i	a6, a2, 128
     e5c:	232272        	l32i	a7, a2, 140
     e5f:	29a347        	bge	a3, a4, e8c <F_CPD_Max_In_Buf+0xc0>
     e62:	78c252        	addi	a5, a2, 120
     e65:	c04430        	sub	a4, a4, a3
     e68:	360334        	ae_cvtq48a32s	aeq0, a3
     e6b:	400504        	ae_lp16f.i	aep0, a5, 0
     e6e:	364434        	ae_cvtq48a32s	aeq1, a4
     e71:	f4838082ae 	{ addi	a10, a2, 8; ae_mulafq32sp16s.l	aeq0, aeq1, aep0 }
     e76:	fc8921        	l32r	a2, 9c (288 <Xdiv>)
     e79:	fc2440c1be 	{ addi	a11, a1, 12; ae_roundsq32asym	aeq0, aeq0 }
     e7e:	368f04        	ae_trunca32q48	a15, aeq0
     e81:	31f9           	s32i.n	a15, a1, 12
     e83:	0002e0        	callx8	a2
     e86:	112a00        	slli	a2, a10, 16
     e89:	000a06        	j	eb5 <F_CPD_Max_In_Buf+0xe9>

00000e8c <F_CPD_Max_In_Buf+0xc0>:
     e8c:	905660        	addx2	a5, a6, a6
     e8f:	063d           	mov.n	a3, a6
     e91:	074d           	mov.n	a4, a7
     e93:	10a757        	bge	a7, a5, ea7 <F_CPD_Max_In_Buf+0xdb>
     e96:	15a347        	bge	a3, a4, eaf <F_CPD_Max_In_Buf+0xe3>
     e99:	fc8d31        	l32r	a3, d0 (ce0 <F_CPD_Ins_Gain>)
     e9c:	02ad           	mov.n	a10, a2
     e9e:	0003e0        	callx8	a3
     ea1:	0a2d           	mov.n	a2, a10
     ea3:	31a9           	s32i.n	a10, a1, 12
     ea5:	f01d           	retw.n

00000ea7 <F_CPD_Max_In_Buf+0xdb>:
     ea7:	f27c           	movi.n	a2, -1
     ea9:	412120        	srli	a2, a2, 1
     eac:	000146        	j	eb5 <F_CPD_Max_In_Buf+0xe9>

00000eaf <F_CPD_Max_In_Buf+0xe3>:
     eaf:	429222        	l16si	a2, a2, 132
     eb2:	112200        	slli	a2, a2, 16
     eb5:	3129           	s32i.n	a2, a1, 12
     eb7:	f01d           	retw.n

00000eb9 <F_CPD_Max_In_Buf+0xed>:
     eb9:	000000                                        ...

00000ebc <F_CPD_Intp_Out>:
     ebc:	006136        	entry	a1, 48
     ebf:	c2f8           	l32i.n	a15, a2, 48
     ec1:	065172        	s16i	a7, a1, 12
     ec4:	400164        	ae_lp16f.i	aep0, a1, 12
     ec7:	3cc282        	addi	a8, a2, 60
     eca:	f3f6f0        	wur.ae_cbegin0	a15
     ecd:	1022f2        	l32i	a15, a2, 64
     ed0:	600804        	ae_lq32f.i	aeq0, a8, 0
     ed3:	f8427d28ff 	{ ae_lq32f.i	aeq1, a8, -4; ae_truncp24q48x2	aep1, aeq0, aeq0 }
     ed8:	1a0c           	movi.n	a10, 1
     eda:	fb4e0fe68e 	{ addi	a8, a6, -2; ae_truncp24q48x2	aep6, aeq1, aeq1 }
     edf:	6278a0        	saltu	a7, a8, a10
     ee2:	401700        	ssl	a7
     ee5:	b278           	l32i.n	a7, a2, 44
     ee7:	c055f0        	sub	a5, a5, a15
     eea:	368f34        	ae_cvtq48a32s	aeq2, a15
     eed:	3f12f2        	l16ui	a15, a2, 126
     ef0:	fa843ec5ff 	{ ae_cvtq48a32s	aeq3, a5; ae_mulfq32sp24s.l	aeq0, aeq2, aep1 }
     ef5:	f783b0c2ae 	{ l32i	a10, a2, 48; ae_mulafq32sp16s.l	aeq2, aeq3, aep0 }
     efa:	a17700        	sll	a7, a7
     efd:	fe3470d19e 	{ l32i	a9, a1, 52; ae_roundsq32asym	aeq2, aeq2 }
     f02:	a077a0        	addx4	a7, a7, a10
     f05:	8f8d           	ae_sext16	a8, a15
     f07:	fa184222ae 	{ addi	a10, a2, 34; ae_mulfq32sp24s.h	aeq1, aeq2, aep6 }
     f0c:	f3f770        	wur.ae_cend0	a7
     f0f:	784b           	addi.n	a7, a8, 4
     f11:	d288           	l32i.n	a8, a2, 52
     f13:	4d0c           	movi.n	a13, 4
     f15:	0b1c           	movi.n	a11, 16
     f17:	8c0c           	movi.n	a12, 8
     f19:	c1e8           	l32i.n	a14, a1, 48
     f1b:	f92acf8f5e 	{ addi	a5, a15, -8; ae_subq56	aeq1, aeq1, aeq0 }
     f20:	36af04        	ae_trunca32q48	a15, aeq2
     f23:	407a04        	ae_lp16f.i	aep7, a10, 0
     f26:	93cb90        	movnez	a12, a11, a9
     f29:	837d90        	moveqz	a7, a13, a9
     f2c:	109292        	l16si	a9, a2, 32
     f2f:	837c50        	moveqz	a7, a12, a5
     f32:	1062f2        	s32i	a15, a2, 64
     f35:	085d           	mov.n	a5, a8
     f37:	d47f7bc5df 	{ ae_lq32f.c	aeq2, a5, a13; ae_mulfq32sp16s.h	aeq1, aeq1, aep7 }
     f3c:	04fe16        	beqz	a14, f8f <F_CPD_Intp_Out+0xd3>
     f3f:	022626        	beqi	a6, 2, f45 <F_CPD_Intp_Out+0x89>
     f42:	002346        	j	fd3 <F_CPD_Intp_Out+0x117>
     f45:	0219e6        	bgei	a9, 1, f4b <F_CPD_Intp_Out+0x8f>
     f48:	002c46        	j	ffd <F_CPD_Intp_Out+0x141>
     f4b:	460c           	movi.n	a6, 4
     f4d:	3b8976        	loop	a9, f8c <F_CPD_Intp_Out+0xd0>
     f50:	f86630039e 	{ l32i	a9, a3, 0; ae_addq56	aeq0, aeq0, aeq1 }
     f55:	f86794089f 	{ s32i.n	a9, a8, 0; ae_roundsp24q48asym	aep0, aeq0 }
     f5a:	0885a4        	ae_mulfq32sp24s.l	aeq2, aeq2, aep0
     f5d:	34a794        	ae_sllaq56	aeq2, aeq2, a7
     f60:	068a24        	ae_negq56	aeq2, aeq2
     f63:	06a934        	ae_roundsq32asym	aeq2, aeq2
     f66:	622304        	ae_sq32f.i	aeq2, a3, 0
     f69:	fc24fbc56f 	{ ae_lq32f.c	aeq2, a5, a6; nop }
     f6e:	fb8030049e 	{ l32i	a9, a4, 0; ae_mulfq32sp24s.l	aeq2, aeq2, aep0 }
     f73:	1899           	s32i.n	a9, a8, 4
     f75:	34a794        	ae_sllaq56	aeq2, aeq2, a7
     f78:	fe9080433e 	{ addi	a3, a3, 4; ae_negq56	aeq2, aeq2 }
     f7d:	fe3440888e 	{ addi	a8, a8, 8; ae_roundsq32asym	aeq2, aeq2 }
     f82:	622404        	ae_sq32f.i	aeq2, a4, 0
     f85:	444b           	addi.n	a4, a4, 4
     f87:	fc24fbc56f 	{ ae_lq32f.c	aeq2, a5, a6; nop }

00000f8c <F_CPD_Intp_Out+0xd0>:
     f8c:	001b46        	j	ffd <F_CPD_Intp_Out+0x141>

00000f8f <F_CPD_Intp_Out+0xd3>:
     f8f:	752666        	bnei	a6, 2, 1008 <F_CPD_Intp_Out+0x14c>
     f92:	6719a6        	blti	a9, 1, ffd <F_CPD_Intp_Out+0x141>
     f95:	460c           	movi.n	a6, 4
     f97:	358976        	loop	a9, fd0 <F_CPD_Intp_Out+0x114>
     f9a:	f86630039e 	{ l32i	a9, a3, 0; ae_addq56	aeq0, aeq0, aeq1 }
     f9f:	f86794089f 	{ s32i.n	a9, a8, 0; ae_roundsp24q48asym	aep0, aeq0 }
     fa4:	0885a4        	ae_mulfq32sp24s.l	aeq2, aeq2, aep0
     fa7:	34a794        	ae_sllaq56	aeq2, aeq2, a7
     faa:	06a934        	ae_roundsq32asym	aeq2, aeq2
     fad:	622304        	ae_sq32f.i	aeq2, a3, 0
     fb0:	fc24fbc56f 	{ ae_lq32f.c	aeq2, a5, a6; nop }
     fb5:	fb8030049e 	{ l32i	a9, a4, 0; ae_mulfq32sp24s.l	aeq2, aeq2, aep0 }
     fba:	1899           	s32i.n	a9, a8, 4
     fbc:	34a794        	ae_sllaq56	aeq2, aeq2, a7
     fbf:	fe3440433e 	{ addi	a3, a3, 4; ae_roundsq32asym	aeq2, aeq2 }
     fc4:	622404        	ae_sq32f.i	aeq2, a4, 0
     fc7:	888b           	addi.n	a8, a8, 8
     fc9:	444b           	addi.n	a4, a4, 4
     fcb:	fc24fbc56f 	{ ae_lq32f.c	aeq2, a5, a6; nop }

00000fd0 <F_CPD_Intp_Out+0x114>:
     fd0:	000a46        	j	ffd <F_CPD_Intp_Out+0x141>

00000fd3 <F_CPD_Intp_Out+0x117>:
     fd3:	2619a6        	blti	a9, 1, ffd <F_CPD_Intp_Out+0x141>
     fd6:	440c           	movi.n	a4, 4
     fd8:	218976        	loop	a9, ffd <F_CPD_Intp_Out+0x141>
     fdb:	f86630036e 	{ l32i	a6, a3, 0; ae_addq56	aeq0, aeq0, aeq1 }
     fe0:	f86794086f 	{ s32i.n	a6, a8, 0; ae_roundsp24q48asym	aep0, aeq0 }
     fe5:	fb8000488e 	{ addi	a8, a8, 4; ae_mulfq32sp24s.l	aeq2, aeq2, aep0 }
     fea:	34a794        	ae_sllaq56	aeq2, aeq2, a7
     fed:	068a24        	ae_negq56	aeq2, aeq2
     ff0:	06a934        	ae_roundsq32asym	aeq2, aeq2
     ff3:	622304        	ae_sq32f.i	aeq2, a3, 0
     ff6:	334b           	addi.n	a3, a3, 4
     ff8:	fc24fbc54f 	{ ae_lq32f.c	aeq2, a5, a4; nop }

00000ffd <F_CPD_Intp_Out+0x141>:
     ffd:	c37c           	movi.n	a3, -4
     fff:	fc24fb853f 	{ ae_lq32f.c	aeq0, a5, a3; nop }
    1004:	d259           	s32i.n	a5, a2, 52
    1006:	f01d           	retw.n

00001008 <F_CPD_Intp_Out+0x14c>:
    1008:	f119a6        	blti	a9, 1, ffd <F_CPD_Intp_Out+0x141>
    100b:	440c           	movi.n	a4, 4
    100d:	1e8976        	loop	a9, 102f <F_CPD_Intp_Out+0x173>
    1010:	f86630036e 	{ l32i	a6, a3, 0; ae_addq56	aeq0, aeq0, aeq1 }
    1015:	f86794086f 	{ s32i.n	a6, a8, 0; ae_roundsp24q48asym	aep0, aeq0 }
    101a:	fb8000488e 	{ addi	a8, a8, 4; ae_mulfq32sp24s.l	aeq2, aeq2, aep0 }
    101f:	34a794        	ae_sllaq56	aeq2, aeq2, a7
    1022:	06a934        	ae_roundsq32asym	aeq2, aeq2
    1025:	622304        	ae_sq32f.i	aeq2, a3, 0
    1028:	334b           	addi.n	a3, a3, 4
    102a:	fc24fbc54f 	{ ae_lq32f.c	aeq2, a5, a4; nop }

0000102f <F_CPD_Intp_Out+0x173>:
    102f:	fff286        	j	ffd <F_CPD_Intp_Out+0x141>

00001032 <F_CPD_Intp_Out+0x176>:
	...

00001034 <multiband_cpd_module>:
    1034:	006136        	entry	a1, 48
    1037:	fc2781        	l32r	a8, d4 (d34 <F_CPD_Mag_In>)
    103a:	3179           	s32i.n	a7, a1, 12
    103c:	c178           	l32i.n	a7, a1, 48
    103e:	02ad           	mov.n	a10, a2
    1040:	03bd           	mov.n	a11, a3
    1042:	04cd           	mov.n	a12, a4
    1044:	05dd           	mov.n	a13, a5
    1046:	06ed           	mov.n	a14, a6
    1048:	0008e0        	callx8	a8
    104b:	e268           	l32i.n	a6, a2, 56
    104d:	378664        	ae_truncp24a32x2	aep0, a6, a6
    1050:	360a34        	ae_cvtq48a32s	aeq0, a10
    1053:	f88013a22f 	{ or	a10, a2, a2; ae_mulfq32sp24s.l	aeq0, aeq0, aep0 }
    1058:	3f12f2        	l16ui	a15, a2, 126
    105b:	340f34        	ae_sllasq56s	aeq0, aeq0, a15
    105e:	060934        	ae_roundsq32asym	aeq0, aeq0
    1061:	368b04        	ae_trunca32q48	a11, aeq0
    1064:	fc1d61        	l32r	a6, d8 (dcc <F_CPD_Max_In_Buf>)
    1067:	0006e0        	callx8	a6
    106a:	132262        	l32i	a6, a2, 76
    106d:	2288           	l32i.n	a8, a2, 8
    106f:	0add           	mov.n	a13, a10
    1071:	3298           	l32i.n	a9, a2, 12
    1073:	04a867        	bge	a8, a6, 107b <multiband_cpd_module+0x47>
    1076:	626b           	addi.n	a6, a2, 6
    1078:	0004c6        	j	108f <multiband_cpd_module+0x5b>

0000107b <multiband_cpd_module+0x47>:
    107b:	4288           	l32i.n	a8, a2, 16
    107d:	04a967        	bge	a9, a6, 1085 <multiband_cpd_module+0x51>
    1080:	026d           	mov.n	a6, a2
    1082:	000246        	j	108f <multiband_cpd_module+0x5b>

00001085 <multiband_cpd_module+0x51>:
    1085:	04a867        	bge	a8, a6, 108d <multiband_cpd_module+0x59>
    1088:	622b           	addi.n	a6, a2, 2
    108a:	000046        	j	108f <multiband_cpd_module+0x5b>

0000108d <multiband_cpd_module+0x59>:
    108d:	624b           	addi.n	a6, a2, 4
    108f:	202292        	l32i	a9, a2, 128
    1092:	232282        	l32i	a8, a2, 140
    1095:	88a0a2        	movi	a10, 136
    1098:	909990        	addx2	a9, a9, a9
    109b:	728890        	salt	a8, a8, a9
    109e:	a2aa           	add.n	a10, a2, a10
    10a0:	83a680        	moveqz	a10, a6, a8
    10a3:	2afd           	ae_l16si.n	a15, a10, 0
    10a5:	fc0d61        	l32r	a6, dc (ebc <F_CPD_Intp_Out>)
    10a8:	02ad           	mov.n	a10, a2
    10aa:	03bd           	mov.n	a11, a3
    10ac:	04cd           	mov.n	a12, a4
    10ae:	05ed           	mov.n	a14, a5
    10b0:	3198           	l32i.n	a9, a1, 12
    10b2:	1179           	s32i.n	a7, a1, 4
    10b4:	0199           	s32i.n	a9, a1, 0
    10b6:	0006e0        	callx8	a6
    10b9:	f01d           	retw.n

000010bb <multiband_cpd_module+0x87>:
	...

000010bc <multiband_cpd_module_2nd_stage>:
    10bc:	004136        	entry	a1, 32
    10bf:	fc0571        	l32r	a7, d4 (d34 <F_CPD_Mag_In>)
    10c2:	02ad           	mov.n	a10, a2
    10c4:	03bd           	mov.n	a11, a3
    10c6:	04cd           	mov.n	a12, a4
    10c8:	05dd           	mov.n	a13, a5
    10ca:	06ed           	mov.n	a14, a6
    10cc:	0007e0        	callx8	a7
    10cf:	360a34        	ae_cvtq48a32s	aeq0, a10
    10d2:	3f1262        	l16ui	a6, a2, 126
    10d5:	340634        	ae_sllasq56s	aeq0, aeq0, a6
    10d8:	fc2453a22f 	{ or	a10, a2, a2; ae_roundsq32asym	aeq0, aeq0 }
    10dd:	368b04        	ae_trunca32q48	a11, aeq0
    10e0:	fbfe61        	l32r	a6, d8 (dcc <F_CPD_Max_In_Buf>)
    10e3:	0006e0        	callx8	a6
    10e6:	202282        	l32i	a8, a2, 128
    10e9:	102262        	l32i	a6, a2, 64
    10ec:	232272        	l32i	a7, a2, 140
    10ef:	360634        	ae_cvtq48a32s	aeq0, a6
    10f2:	908880        	addx2	a8, a8, a8
    10f5:	08a6a7        	bge	a6, a10, 1101 <multiband_cpd_module_2nd_stage+0x45>
    10f8:	082787        	blt	a7, a8, 1104 <multiband_cpd_module_2nd_stage+0x48>
    10fb:	027d           	mov.n	a7, a2
    10fd:	000346        	j	110e <multiband_cpd_module_2nd_stage+0x52>

00001100 <multiband_cpd_module_2nd_stage+0x44>:
	...

00001101 <multiband_cpd_module_2nd_stage+0x45>:
    1101:	07a787        	bge	a7, a8, 110c <multiband_cpd_module_2nd_stage+0x50>
    1104:	88a072        	movi	a7, 136
    1107:	727a           	add.n	a7, a2, a7
    1109:	000046        	j	110e <multiband_cpd_module_2nd_stage+0x52>

0000110c <multiband_cpd_module_2nd_stage+0x50>:
    110c:	726b           	addi.n	a7, a2, 6
    110e:	477d           	ae_l16ui.n	a7, a7, 0
    1110:	fe044fe59e 	{ addi	a9, a5, -2; ae_movq56	aeq2, aeq0 }
    1115:	1c0c           	movi.n	a12, 1
    1117:	b2d8           	l32i.n	a13, a2, 44
    1119:	300774        	ae_cvtp24a16x2.ll	aep0, a7, a7
    111c:	6279c0        	saltu	a7, a9, a12
    111f:	c2e8           	l32i.n	a14, a2, 48
    1121:	401700        	ssl	a7
    1124:	c06a60        	sub	a6, a10, a6
    1127:	364634        	ae_cvtq48a32s	aeq1, a6
    112a:	a17d00        	sll	a7, a13
    112d:	f583b0c28e 	{ l32i	a8, a2, 48; ae_mulafq32sp16s.l	aeq2, aeq1, aep0 }
    1132:	a077e0        	addx4	a7, a7, a14
    1135:	f3f680        	wur.ae_cbegin0	a8
    1138:	d288           	l32i.n	a8, a2, 52
    113a:	f3f770        	wur.ae_cend0	a7
    113d:	fd3461029e 	{ l16si	a9, a2, 32; ae_roundsq32asym	aeq1, aeq2 }
    1142:	369f04        	ae_trunca32q48	a15, aeq1
    1145:	460c           	movi.n	a6, 4
    1147:	1062f2        	s32i	a15, a2, 64
    114a:	087d           	mov.n	a7, a8
    114c:	fb2afbc76f 	{ ae_lq32f.c	aeq2, a7, a6; ae_subq56	aeq3, aeq1, aeq0 }
    1151:	5719a6        	blti	a9, 1, 11ac <multiband_cpd_module_2nd_stage+0xf0>
    1154:	22c2a2        	addi	a10, a2, 34
    1157:	400a04        	ae_lp16f.i	aep0, a10, 0
    115a:	030ac4        	ae_mulfq32sp16s.h	aeq1, aeq3, aep0
    115d:	4b8976        	loop	a9, 11ac <multiband_cpd_module_2nd_stage+0xf0>
    1160:	3f1292        	l16ui	a9, a2, 126
    1163:	f8663003fe 	{ l32i	a15, a3, 0; ae_addq56	aeq0, aeq0, aeq1 }
    1168:	f8679408ff 	{ s32i.n	a15, a8, 0; ae_roundsp24q48asym	aep0, aeq0 }
    116d:	fb8000199e 	{ addi	a9, a9, 1; ae_mulfq32sp24s.l	aeq2, aeq2, aep0 }
    1172:	34a934        	ae_sllasq56s	aeq2, aeq2, a9
    1175:	fe344088ee 	{ addi	a14, a8, 8; ae_roundsq32asym	aeq2, aeq2 }
    117a:	622304        	ae_sq32f.i	aeq2, a3, 0
    117d:	222566        	bnei	a5, 2, 11a3 <multiband_cpd_module_2nd_stage+0xe7>
    1180:	3f1292        	l16ui	a9, a2, 126
    1183:	fc24fbc76f 	{ ae_lq32f.c	aeq2, a7, a6; nop }
    1188:	fb803004ae 	{ l32i	a10, a4, 0; ae_mulfq32sp24s.l	aeq2, aeq2, aep0 }
    118d:	991b           	addi.n	a9, a9, 1
    118f:	34a934        	ae_sllasq56s	aeq2, aeq2, a9
    1192:	fe344044fe 	{ addi	a15, a4, 4; ae_roundsq32asym	aeq2, aeq2 }
    1197:	18a9           	s32i.n	a10, a8, 4
    1199:	622404        	ae_sq32f.i	aeq2, a4, 0
    119c:	0e8d           	mov.n	a8, a14
    119e:	0f4d           	mov.n	a4, a15
    11a0:	000046        	j	11a5 <multiband_cpd_module_2nd_stage+0xe9>

000011a3 <multiband_cpd_module_2nd_stage+0xe7>:
    11a3:	884b           	addi.n	a8, a8, 4
    11a5:	334b           	addi.n	a3, a3, 4
    11a7:	fc24fbc76f 	{ ae_lq32f.c	aeq2, a7, a6; nop }

000011ac <multiband_cpd_module_2nd_stage+0xf0>:
    11ac:	c37c           	movi.n	a3, -4
    11ae:	fc24fb873f 	{ ae_lq32f.c	aeq0, a7, a3; nop }
    11b3:	d279           	s32i.n	a7, a2, 52
    11b5:	f01d           	retw.n

000011b7 <multiband_cpd_module_2nd_stage+0xfb>:
	...

000011b8 <DBB_module>:
    11b8:	006136        	entry	a1, 48
    11bb:	378344        	ae_truncp24a32x2	aep0, a3, a4
    11be:	ea0180c1ae 	{ addi	a10, a1, 12; ae_mulfp24s.ll	aeq0, aep0, aep0 }
    11c3:	e4008081be 	{ addi	a11, a1, 8; ae_mulafs56p24s.hh	aeq0, aep0, aep0 }
    11c8:	fbc651        	l32r	a5, e0 (220 <HIFI_sqrt_cpd>)
    11cb:	fc247f0eaf 	{ ae_nsaq56s	a14, aeq0; ae_roundsq32asym	aeq0, aeq0 }
    11d0:	f8ce32        	addi	a3, a14, -8
    11d3:	340334        	ae_sllasq56s	aeq0, aeq0, a3
    11d6:	1b8f74        	ae_roundsp16q48asym	aep7, aeq0
    11d9:	603030        	neg	a3, a3
    11dc:	007fd4        	ae_cvta32p24.l	a15, aep7
    11df:	3139           	s32i.n	a3, a1, 12
    11e1:	21f9           	s32i.n	a15, a1, 8
    11e3:	0005e0        	callx8	a5
    11e6:	3138           	l32i.n	a3, a1, 12
    11e8:	2148           	l32i.n	a4, a1, 8
    11ea:	2278           	l32i.n	a7, a2, 8
    11ec:	606030        	neg	a6, a3
    11ef:	400600        	ssr	a6
    11f2:	b18040        	sra	a8, a4
    11f5:	401300        	ssl	a3
    11f8:	a16400        	sll	a6, a4
    11fb:	a36830        	movltz	a6, a8, a3
    11fe:	3238           	l32i.n	a3, a2, 12
    1200:	fbb941        	l32r	a4, e4 (3d70a3d <_end+0x3d6e705>)
    1203:	18a767        	bge	a7, a6, 121f <DBB_module+0x67>
    1206:	c06630        	sub	a6, a6, a3
    1209:	360334        	ae_cvtq48a32s	aeq0, a3
    120c:	378444        	ae_truncp24a32x2	aep0, a4, a4
    120f:	364634        	ae_cvtq48a32s	aeq1, a6
    1212:	d4e194216f 	{ s32i.n	a6, a1, 8; ae_mularfq32sp24s.l	aeq0, aeq1, aep0 }
    1217:	060934        	ae_roundsq32asym	aeq0, aeq0
    121a:	368304        	ae_trunca32q48	a3, aeq0
    121d:	3239           	s32i.n	a3, a2, 12

0000121f <DBB_module+0x67>:
    121f:	0268           	l32i.n	a6, a2, 0
    1221:	170c           	movi.n	a7, 1
    1223:	b2cb           	addi.n	a11, a2, 12
    1225:	52a367        	bge	a3, a6, 127b <DBB_module+0xc3>
    1228:	216860        	srai	a6, a6, 8
    122b:	52a637        	bge	a6, a3, 1281 <DBB_module+0xc9>
    122e:	2169           	s32i.n	a6, a1, 8
    1230:	318b           	addi.n	a3, a1, 8
    1232:	fb9a61        	l32r	a6, 9c (288 <Xdiv>)
    1235:	03ad           	mov.n	a10, a3
    1237:	0006e0        	callx8	a6
    123a:	116a00        	slli	a6, a10, 16
    123d:	360634        	ae_cvtq48a32s	aeq0, a6
    1240:	364604        	ae_nsaq56s	a6, aeq0
    1243:	a1cb           	addi.n	a10, a1, 12
    1245:	03bd           	mov.n	a11, a3
    1247:	f8c662        	addi	a6, a6, -8
    124a:	340634        	ae_sllasq56s	aeq0, aeq0, a6
    124d:	1b8f04        	ae_roundsp16q48asym	aep0, aeq0
    1250:	606060        	neg	a6, a6
    1253:	000fd4        	ae_cvta32p24.l	a15, aep0
    1256:	3169           	s32i.n	a6, a1, 12
    1258:	21f9           	s32i.n	a15, a1, 8
    125a:	0005e0        	callx8	a5
    125d:	3138           	l32i.n	a3, a1, 12
    125f:	2158           	l32i.n	a5, a1, 8
    1261:	1268           	l32i.n	a6, a2, 4
    1263:	607030        	neg	a7, a3
    1266:	400700        	ssr	a7
    1269:	b17050        	sra	a7, a5
    126c:	401300        	ssl	a3
    126f:	a15500        	sll	a5, a5
    1272:	a35730        	movltz	a5, a7, a3
    1275:	433650        	min	a3, a6, a5
    1278:	0001c6        	j	1283 <DBB_module+0xcb>

0000127b <DBB_module+0xc3>:
    127b:	013750        	slli	a3, a7, 27
    127e:	000046        	j	1283 <DBB_module+0xcb>

00001281 <DBB_module+0xc9>:
    1281:	1238           	l32i.n	a3, a2, 4
    1283:	4258           	l32i.n	a5, a2, 16
    1285:	378444        	ae_truncp24a32x2	aep0, a4, a4
    1288:	f8e2bec53f 	{ ae_cvtq48a32s	aeq0, a5; ae_roundsp16asym	aep0, aep0 }
    128d:	c03350        	sub	a3, a3, a5
    1290:	364334        	ae_cvtq48a32s	aeq1, a3
    1293:	080354        	ae_mularfq32sp24s.l	aeq0, aeq1, aep0
    1296:	060934        	ae_roundsq32asym	aeq0, aeq0
    1299:	368f04        	ae_trunca32q48	a15, aeq0
    129c:	42f9           	s32i.n	a15, a2, 16
    129e:	f01d           	retw.n

000012a0 <compander_AU_SetINS_proc>:
    12a0:	004136        	entry	a1, 32
    12a3:	13d222        	addmi	a2, a2, 0x1300
    12a6:	711242        	l16ui	a4, a2, 226
    12a9:	d67c           	movi.n	a6, -3
    12ab:	250c           	movi.n	a5, 2
    12ad:	f46060        	extui	a6, a6, 0, 16
    12b0:	205450        	or	a5, a4, a5
    12b3:	104460        	and	a4, a4, a6
    12b6:	934530        	movnez	a4, a5, a3
    12b9:	715242        	s16i	a4, a2, 226
    12bc:	f01d           	retw.n

000012be <compander_AU_SetINS_proc+0x1e>:
	...

000012c0 <compander_AU_proc>:
    12c0:	018136        	entry	a1, 192
    12c3:	13d282        	addmi	a8, a2, 0x1300
    12c6:	701882        	l16ui	a8, a8, 224
    12c9:	a179           	s32i.n	a7, a1, 40
    12cb:	07d2a2        	addmi	a10, a2, 0x700
    12ce:	e8ac           	beqz.n	a8, 1300 <compander_AU_proc+0x40>
    12d0:	13d282        	addmi	a8, a2, 0x1300
    12d3:	0f1ae2        	l16ui	a14, a10, 30
    12d6:	7418d2        	l16ui	a13, a8, 232
    12d9:	7118a2        	l16ui	a10, a8, 226
    12dc:	b68b           	addi.n	a11, a6, 8
    12de:	1092c2        	l16si	a12, a2, 32
    12e1:	e1c9           	s32i.n	a12, a1, 56
    12e3:	2184b0        	srai	a8, a11, 4
    12e6:	a0a692        	movi	a9, 0x6a0
    12e9:	f8ceb2        	addi	a11, a14, -8
    12ec:	13d2c2        	addmi	a12, a2, 0x1300
    12ef:	4a8d66        	bnei	a13, 8, 133d <compander_AU_proc+0x7d>
    12f2:	392cc2        	l32i	a12, a12, 228
    12f5:	1d0c           	movi.n	a13, 1
    12f7:	72cdc0        	salt	a12, a13, a12
    12fa:	cc3b           	addi.n	a12, a12, 3
    12fc:	001706        	j	135c <compander_AU_proc+0x9c>

000012ff <compander_AU_proc+0x3f>:
	...

00001300 <compander_AU_proc+0x40>:
    1300:	339c           	beqz.n	a3, 1317 <compander_AU_proc+0x57>
    1302:	1115a6        	blti	a5, 1, 1317 <compander_AU_proc+0x57>
    1305:	0e8576        	loop	a5, 1317 <compander_AU_proc+0x57>
    1308:	3f1262        	l16ui	a6, a2, 126
    130b:	0378           	l32i.n	a7, a3, 0
    130d:	401600        	ssl	a6
    1310:	a16700        	sll	a6, a7
    1313:	0369           	s32i.n	a6, a3, 0
    1315:	334b           	addi.n	a3, a3, 4

00001317 <compander_AU_proc+0x57>:
    1317:	a138           	l32i.n	a3, a1, 40
    1319:	3b4416        	beqz	a4, 16d1 <compander_AU_proc+0x411>
    131c:	022326        	beqi	a3, 2, 1322 <compander_AU_proc+0x62>
    131f:	00eb86        	j	16d1 <compander_AU_proc+0x411>
    1322:	0215e6        	bgei	a5, 1, 1328 <compander_AU_proc+0x68>
    1325:	00ea06        	j	16d1 <compander_AU_proc+0x411>
    1328:	0e8576        	loop	a5, 133a <compander_AU_proc+0x7a>
    132b:	3f1232        	l16ui	a3, a2, 126
    132e:	0458           	l32i.n	a5, a4, 0
    1330:	401300        	ssl	a3
    1333:	a13500        	sll	a3, a5
    1336:	0439           	s32i.n	a3, a4, 0
    1338:	444b           	addi.n	a4, a4, 4

0000133a <compander_AU_proc+0x7a>:
    133a:	00e4c6        	j	16d1 <compander_AU_proc+0x411>

0000133d <compander_AU_proc+0x7d>:
    133d:	392cc2        	l32i	a12, a12, 228
    1340:	119d66        	bnei	a13, 10, 1355 <compander_AU_proc+0x95>
    1343:	1e2ca6        	blti	a12, 2, 1365 <compander_AU_proc+0xa5>
    1346:	fb68c1        	l32r	a12, e8 (66666667 <_end+0x6666432f>)
    1349:	b255c0        	mulsh	a5, a5, a12
    134c:	05cf50        	extui	a12, a5, 31, 1
    134f:	215350        	srai	a5, a5, 3
    1352:	0006c6        	j	1371 <compander_AU_proc+0xb1>

00001355 <compander_AU_proc+0x95>:
    1355:	1d0c           	movi.n	a13, 1
    1357:	72cdc0        	salt	a12, a13, a12
    135a:	cc5b           	addi.n	a12, a12, 5
    135c:	400c00        	ssr	a12
    135f:	b15050        	sra	a5, a5
    1362:	000346        	j	1373 <compander_AU_proc+0xb3>

00001365 <compander_AU_proc+0xa5>:
    1365:	fb60c1        	l32r	a12, e8 (66666667 <_end+0x6666432f>)
    1368:	b255c0        	mulsh	a5, a5, a12
    136b:	05cf50        	extui	a12, a5, 31, 1
    136e:	215250        	srai	a5, a5, 2
    1371:	55ca           	add.n	a5, a5, a12
    1373:	929a           	add.n	a9, a2, a9
    1375:	04e1a0        	extui	a14, a10, 1, 1
    1378:	04f2a0        	extui	a15, a10, 2, 1
    137b:	9386b0        	movnez	a8, a6, a11
    137e:	b129           	s32i.n	a2, a1, 44
    1380:	1e6192        	s32i	a9, a1, 120
    1383:	1d61e2        	s32i	a14, a1, 116
    1386:	1c61f2        	s32i	a15, a1, 112
    1389:	71ea07        	bbsi	a10, 0, 13fe <compander_AU_proc+0x13e>
    138c:	0215e6        	bgei	a5, 1, 1392 <compander_AU_proc+0xd2>
    138f:	00cf86        	j	16d1 <compander_AU_proc+0x411>
    1392:	b168           	l32i.n	a6, a1, 44
    1394:	e1f8           	l32i.n	a15, a1, 56
    1396:	360834        	ae_cvtq48a32s	aeq0, a8
    1399:	13d6e2        	addmi	a14, a6, 0x1300
    139c:	072d           	mov.n	a2, a7
    139e:	c1e9           	s32i.n	a14, a1, 48
    13a0:	630114        	ae_sq56s.i	aeq0, a1, 8
    13a3:	06d662        	addmi	a6, a6, 0x600
    13a6:	117fe0        	slli	a7, a15, 2
    13a9:	b188           	l32i.n	a8, a1, 44
    13ab:	fba492        	movi	a9, 0x4fb
    13ae:	1199e0        	slli	a9, a9, 2
    13b1:	eaa0d2        	movi	a13, 234
    13b4:	602894        	ae_lq32f.x	aeq0, a8, a9
    13b7:	614114        	ae_lq56.i	aeq1, a1, 8
    13ba:	13dd92        	addmi	a9, a13, 0x1300
    13bd:	f94a99889f 	{ ae_lp16f.x	aep0, a8, a9; ae_subsq56s	aeq1, aeq1, aeq0 }
    13c2:	f483b0c1fe 	{ l32i	a15, a1, 48; ae_mulafq32sp16s.l	aeq0, aeq1, aep0 }
    13c7:	1e21a2        	l32i	a10, a1, 120
    13ca:	fc2453b33f 	{ or	a11, a3, a3; ae_roundsq32asym	aeq0, aeq0 }
    13cf:	368e04        	ae_trunca32q48	a14, aeq0
    13d2:	3b6fe2        	s32i	a14, a15, 236
    13d5:	3666e2        	s32i	a14, a6, 216
    13d8:	1d21e2        	l32i	a14, a1, 116
    13db:	1c21f2        	l32i	a15, a1, 112
    13de:	fb4581        	l32r	a8, f4 (1034 <multiband_cpd_module>)
    13e1:	190c           	movi.n	a9, 1
    13e3:	04cd           	mov.n	a12, a4
    13e5:	02dd           	mov.n	a13, a2
    13e7:	0199           	s32i.n	a9, a1, 0
    13e9:	0008e0        	callx8	a8
    13ec:	362682        	l32i	a8, a6, 216
    13ef:	550b           	addi.n	a5, a5, -1
    13f1:	447a           	add.n	a4, a4, a7
    13f3:	337a           	add.n	a3, a3, a7
    13f5:	376682        	s32i	a8, a6, 220
    13f8:	fad556        	bnez	a5, 13a9 <compander_AU_proc+0xe9>
    13fb:	00b486        	j	16d1 <compander_AU_proc+0x411>

000013fe <compander_AU_proc+0x13e>:
    13fe:	0215e6        	bgei	a5, 1, 1404 <compander_AU_proc+0x144>
    1401:	00b306        	j	16d1 <compander_AU_proc+0x411>
    1404:	160c           	movi.n	a6, 1
    1406:	116620        	slli	a6, a6, 14
    1409:	300664        	ae_cvtp24a16x2.ll	aep0, a6, a6
    140c:	e168           	l32i.n	a6, a1, 56
    140e:	360834        	ae_cvtq48a32s	aeq0, a8
    1411:	090c           	movi.n	a9, 0
    1413:	fec7a2        	addi	a10, a7, -2
    1416:	180c           	movi.n	a8, 1
    1418:	729960        	salt	a9, a9, a6
    141b:	628a80        	saltu	a8, a10, a8
    141e:	21a9           	s32i.n	a10, a1, 8
    1420:	b1a0a2        	movi	a10, 177
    1423:	108890        	and	a8, a8, a9
    1426:	119ab0        	slli	a9, a10, 5
    1429:	b1a8           	l32i.n	a10, a1, 44
    142b:	523c           	movi.n	a2, 53
    142d:	1122a0        	slli	a2, a2, 6
    1430:	1b6182        	s32i	a8, a1, 108
    1433:	2a2a           	add.n	a2, a10, a2
    1435:	6fa182        	movi	a8, 0x16f
    1438:	256122        	s32i	a2, a1, 148
    143b:	1128c0        	slli	a2, a8, 4
    143e:	2a2a           	add.n	a2, a10, a2
    1440:	3fa182        	movi	a8, 0x13f
    1443:	246122        	s32i	a2, a1, 144
    1446:	1128c0        	slli	a2, a8, 4
    1449:	4fa182        	movi	a8, 0x14f
    144c:	1188c0        	slli	a8, a8, 4
    144f:	61a1f2        	movi	a15, 0x161
    1452:	8a8a           	add.n	a8, a10, a8
    1454:	5fa1e2        	movi	a14, 0x15f
    1457:	11ffc0        	slli	a15, a15, 4
    145a:	63a1c2        	movi	a12, 0x163
    145d:	d189           	s32i.n	a8, a1, 52
    145f:	b5a082        	movi	a8, 181
    1462:	11eec0        	slli	a14, a14, 4
    1465:	65a1d2        	movi	a13, 0x165
    1468:	1188b0        	slli	a8, a8, 5
    146b:	fafa           	add.n	a15, a10, a15
    146d:	11ccc0        	slli	a12, a12, 4
    1470:	8a8a           	add.n	a8, a10, a8
    1472:	eaea           	add.n	a14, a10, a14
    1474:	2261f2        	s32i	a15, a1, 136
    1477:	faca           	add.n	a15, a10, a12
    1479:	11ddc0        	slli	a13, a13, 4
    147c:	c1a2c2        	movi	a12, 0x2c1
    147f:	106182        	s32i	a8, a1, 64
    1482:	118cd0        	slli	a8, a12, 3
    1485:	2361e2        	s32i	a14, a1, 140
    1488:	eada           	add.n	a14, a10, a13
    148a:	f1e9           	s32i.n	a14, a1, 60
    148c:	8a8a           	add.n	a8, a10, a8
    148e:	3ba5e2        	movi	a14, 0x53b
    1491:	bfa2b2        	movi	a11, 0x2bf
    1494:	9a9a           	add.n	a9, a10, a9
    1496:	126182        	s32i	a8, a1, 72
    1499:	118ee0        	slli	a8, a14, 2
    149c:	9d5c           	movi.n	a13, 89
    149e:	11bbd0        	slli	a11, a11, 3
    14a1:	136192        	s32i	a9, a1, 76
    14a4:	119da0        	slli	a9, a13, 6
    14a7:	8a8a           	add.n	a8, a10, a8
    14a9:	fba4c2        	movi	a12, 0x4fb
    14ac:	2161f2        	s32i	a15, a1, 132
    14af:	11f6f0        	slli	a15, a6, 1
    14b2:	baba           	add.n	a11, a10, a11
    14b4:	9a9a           	add.n	a9, a10, a9
    14b6:	176182        	s32i	a8, a1, 92
    14b9:	118ce0        	slli	a8, a12, 2
    14bc:	2a2a           	add.n	a2, a10, a2
    14be:	1461b2        	s32i	a11, a1, 80
    14c1:	116192        	s32i	a9, a1, 68
    14c4:	1561f2        	s32i	a15, a1, 84
    14c7:	13da92        	addmi	a9, a10, 0x1300
    14ca:	16dab2        	addmi	a11, a10, 0x1600
    14cd:	06dad2        	addmi	a13, a10, 0x600
    14d0:	17dae2        	addmi	a14, a10, 0x1700
    14d3:	1166e0        	slli	a6, a6, 2
    14d6:	fa8a           	add.n	a15, a10, a8
    14d8:	630134        	ae_sq56s.i	aeq0, a1, 24
    14db:	560124        	ae_sp24x2s.i	aep0, a1, 16
    14de:	196192        	s32i	a9, a1, 100
    14e1:	2061b2        	s32i	a11, a1, 128
    14e4:	1861d2        	s32i	a13, a1, 96
    14e7:	c1e9           	s32i.n	a14, a1, 48
    14e9:	1f6162        	s32i	a6, a1, 124
    14ec:	1661f2        	s32i	a15, a1, 88
    14ef:	1a6122        	s32i	a2, a1, 104
    14f2:	1521c2        	l32i	a12, a1, 84
    14f5:	faea61        	l32r	a6, a0 (1bdc <xt_memcpy>)
    14f8:	02ad           	mov.n	a10, a2
    14fa:	03bd           	mov.n	a11, a3
    14fc:	0006e0        	callx8	a6
    14ff:	0c2766        	bnei	a7, 2, 150f <compander_AU_proc+0x24f>
    1502:	d1a8           	l32i.n	a10, a1, 52
    1504:	1521c2        	l32i	a12, a1, 84
    1507:	fae661        	l32r	a6, a0 (1bdc <xt_memcpy>)
    150a:	04bd           	mov.n	a11, a4
    150c:	0006e0        	callx8	a6
    150f:	192162        	l32i	a6, a1, 100
    1512:	e178           	l32i.n	a7, a1, 56
    1514:	1021b2        	l32i	a11, a1, 64
    1517:	2321c2        	l32i	a12, a1, 140
    151a:	2221d2        	l32i	a13, a1, 136
    151d:	faf381        	l32r	a8, ec (1a24 <HIFI_d1IB_v2_in32_c24_4th>)
    1520:	03ad           	mov.n	a10, a3
    1522:	07ed           	mov.n	a14, a7
    1524:	0008e0        	callx8	a8
    1527:	02ad           	mov.n	a10, a2
    1529:	f1b8           	l32i.n	a11, a1, 60
    152b:	2021c2        	l32i	a12, a1, 128
    152e:	2121d2        	l32i	a13, a1, 132
    1531:	faef21        	l32r	a2, f0 (1b5c <HIFI_d1IB_v2_in32_c24_3rd>)
    1534:	07ed           	mov.n	a14, a7
    1536:	0002e0        	callx8	a2
    1539:	a1d8           	l32i.n	a13, a1, 40
    153b:	b128           	l32i.n	a2, a1, 44
    153d:	1021b2        	l32i	a11, a1, 64
    1540:	232d66        	bnei	a13, 2, 1567 <compander_AU_proc+0x2a7>
    1543:	1421c2        	l32i	a12, a1, 80
    1546:	1321d2        	l32i	a13, a1, 76
    1549:	fae861        	l32r	a6, ec (1a24 <HIFI_d1IB_v2_in32_c24_4th>)
    154c:	04ad           	mov.n	a10, a4
    154e:	07ed           	mov.n	a14, a7
    1550:	0006e0        	callx8	a6
    1553:	d1a8           	l32i.n	a10, a1, 52
    1555:	f1b8           	l32i.n	a11, a1, 60
    1557:	1221c2        	l32i	a12, a1, 72
    155a:	1121d2        	l32i	a13, a1, 68
    155d:	fae461        	l32r	a6, f0 (1b5c <HIFI_d1IB_v2_in32_c24_3rd>)
    1560:	07ed           	mov.n	a14, a7
    1562:	0006e0        	callx8	a6
    1565:	a1d8           	l32i.n	a13, a1, 40
    1567:	fcc362        	addi	a6, a3, -4
    156a:	540124        	ae_lp24x2.i	aep0, a1, 16
    156d:	1917a6        	blti	a7, 1, 158a <compander_AU_proc+0x2ca>
    1570:	162182        	l32i	a8, a1, 88
    1573:	069d           	mov.n	a9, a6
    1575:	118776        	loop	a7, 158a <compander_AU_proc+0x2ca>
    1578:	601814        	ae_lq32f.iu	aeq0, a8, 4
    157b:	605914        	ae_lq32f.iu	aeq1, a9, 4
    157e:	b58044        	ae_mulzasfq32sp16s.hh	aeq2, aeq1, aep0, aeq0, aep0
    1581:	b10044        	ae_mulzaafq32sp16s.hh	aeq0, aeq1, aep0, aeq0, aep0
    1584:	622904        	ae_sq32f.i	aeq2, a9, 0
    1587:	620804        	ae_sq32f.i	aeq0, a8, 0

0000158a <compander_AU_proc+0x2ca>:
    158a:	1b21f2        	l32i	a15, a1, 108
    158d:	276152        	s32i	a5, a1, 156
    1590:	172192        	l32i	a9, a1, 92
    1593:	6f9c           	beqz.n	a15, 15ad <compander_AU_proc+0x2ed>
    1595:	fcc482        	addi	a8, a4, -4
    1598:	118776        	loop	a7, 15ad <compander_AU_proc+0x2ed>
    159b:	601914        	ae_lq32f.iu	aeq0, a9, 4
    159e:	605814        	ae_lq32f.iu	aeq1, a8, 4
    15a1:	b58044        	ae_mulzasfq32sp16s.hh	aeq2, aeq1, aep0, aeq0, aep0
    15a4:	b10044        	ae_mulzaafq32sp16s.hh	aeq0, aeq1, aep0, aeq0, aep0
    15a7:	622804        	ae_sq32f.i	aeq2, a8, 0
    15aa:	620904        	ae_sq32f.i	aeq0, a9, 0
    15ad:	fba452        	movi	a5, 0x4fb
    15b0:	1155e0        	slli	a5, a5, 2
    15b3:	eaa082        	movi	a8, 234
    15b6:	602254        	ae_lq32f.x	aeq0, a2, a5
    15b9:	614134        	ae_lq56.i	aeq1, a1, 24
    15bc:	13d852        	addmi	a5, a8, 0x1300
    15bf:	f94a99825f 	{ ae_lp16f.x	aep0, a2, a5; ae_subsq56s	aeq1, aeq1, aeq0 }
    15c4:	f48393c44f 	{ or	a12, a4, a4; ae_mulafq32sp16s.l	aeq0, aeq1, aep0 }
    15c9:	192172        	l32i	a7, a1, 100
    15cc:	fc2471814e 	{ l32i	a4, a1, 96; ae_roundsq32asym	aeq0, aeq0 }
    15d1:	1d2122        	l32i	a2, a1, 116
    15d4:	1c2152        	l32i	a5, a1, 112
    15d7:	368804        	ae_trunca32q48	a8, aeq0
    15da:	3b6782        	s32i	a8, a7, 236
    15dd:	366482        	s32i	a8, a4, 216
    15e0:	1e21a2        	l32i	a10, a1, 120
    15e3:	fac481        	l32r	a8, f4 (1034 <multiband_cpd_module>)
    15e6:	090c           	movi.n	a9, 0
    15e8:	03bd           	mov.n	a11, a3
    15ea:	02ed           	mov.n	a14, a2
    15ec:	05fd           	mov.n	a15, a5
    15ee:	2661c2        	s32i	a12, a1, 152
    15f1:	0199           	s32i.n	a9, a1, 0
    15f3:	0008e0        	callx8	a8
    15f6:	c1e8           	l32i.n	a14, a1, 48
    15f8:	3b2782        	l32i	a8, a7, 236
    15fb:	378884        	ae_truncp24a32x2	aep0, a8, a8
    15fe:	600e04        	ae_lq32f.i	aeq0, a14, 0
    1601:	f88030b19e 	{ l32i	a9, a1, 44; ae_mulfq32sp24s.l	aeq0, aeq0, aep0 }
    1606:	3624f2        	l32i	a15, a4, 216
    1609:	360114        	ae_sllisq56s	aeq0, aeq0, 4
    160c:	fc2470b1ae 	{ l32i	a10, a1, 44; ae_roundsq32asym	aeq0, aeq0 }
    1611:	3764f2        	s32i	a15, a4, 220
    1614:	368704        	ae_trunca32q48	a7, aeq0
    1617:	1a21b2        	l32i	a11, a1, 104
    161a:	d1c8           	l32i.n	a12, a1, 52
    161c:	a1d8           	l32i.n	a13, a1, 40
    161e:	fab541        	l32r	a4, f4 (1034 <multiband_cpd_module>)
    1621:	e979           	s32i.n	a7, a9, 56
    1623:	02ed           	mov.n	a14, a2
    1625:	090c           	movi.n	a9, 0
    1627:	e178           	l32i.n	a7, a1, 56
    1629:	b128           	l32i.n	a2, a1, 44
    162b:	05fd           	mov.n	a15, a5
    162d:	0199           	s32i.n	a9, a1, 0
    162f:	0004e0        	callx8	a4
    1632:	0e2282        	l32i	a8, a2, 56
    1635:	540124        	ae_lp24x2.i	aep0, a1, 16
    1638:	0f6282        	s32i	a8, a2, 60
    163b:	1417a6        	blti	a7, 1, 1653 <compander_AU_proc+0x393>
    163e:	162182        	l32i	a8, a1, 88
    1641:	0e8776        	loop	a7, 1653 <compander_AU_proc+0x393>
    1644:	601614        	ae_lq32f.iu	aeq0, a6, 4
    1647:	605814        	ae_lq32f.iu	aeq1, a8, 4
    164a:	b10014        	ae_mulzaafq32sp16s.hh	aeq0, aeq0, aep0, aeq1, aep0
    164d:	060934        	ae_roundsq32asym	aeq0, aeq0
    1650:	620604        	ae_sq32f.i	aeq0, a6, 0
    1653:	1b2162        	l32i	a6, a1, 108
    1656:	272152        	l32i	a5, a1, 156
    1659:	262142        	l32i	a4, a1, 152
    165c:	869c           	beqz.n	a6, 1678 <compander_AU_proc+0x3b8>
    165e:	172182        	l32i	a8, a1, 92
    1661:	fcc462        	addi	a6, a4, -4
    1664:	f03d           	nop.n
    1666:	0e8776        	loop	a7, 1678 <compander_AU_proc+0x3b8>
    1669:	601614        	ae_lq32f.iu	aeq0, a6, 4
    166c:	605814        	ae_lq32f.iu	aeq1, a8, 4
    166f:	b10014        	ae_mulzaafq32sp16s.hh	aeq0, aeq0, aep0, aeq1, aep0
    1672:	060934        	ae_roundsq32asym	aeq0, aeq0
    1675:	620604        	ae_sq32f.i	aeq0, a6, 0
    1678:	2521a2        	l32i	a10, a1, 148
    167b:	a1d8           	l32i.n	a13, a1, 40
    167d:	fa9e61        	l32r	a6, f8 (10bc <multiband_cpd_module_2nd_stage>)
    1680:	0e0c           	movi.n	a14, 0
    1682:	03bd           	mov.n	a11, a3
    1684:	04cd           	mov.n	a12, a4
    1686:	0006e0        	callx8	a6
    1689:	c168           	l32i.n	a6, a1, 48
    168b:	1322c2        	l32i	a12, a2, 76
    168e:	1f0c           	movi.n	a15, 1
    1690:	0668           	l32i.n	a6, a6, 0
    1692:	012f50        	slli	a2, a15, 27
    1695:	c1b8           	l32i.n	a11, a1, 48
    1697:	101627        	beq	a6, a2, 16ab <compander_AU_proc+0x3eb>
    169a:	fa8021        	l32r	a2, 9c (288 <Xdiv>)
    169d:	2164c0        	srai	a6, a12, 4
    16a0:	24c1a2        	addi	a10, a1, 36
    16a3:	9169           	s32i.n	a6, a1, 36
    16a5:	0002e0        	callx8	a2
    16a8:	11ca00        	slli	a12, a10, 16

000016ab <compander_AU_proc+0x3eb>:
    16ab:	182122        	l32i	a2, a1, 96
    16ae:	2421a2        	l32i	a10, a1, 144
    16b1:	a06740        	addx4	a6, a7, a4
    16b4:	3b22b2        	l32i	a11, a2, 236
    16b7:	fa9121        	l32r	a2, fc (11b8 <DBB_module>)
    16ba:	0002e0        	callx8	a2
    16bd:	1f2122        	l32i	a2, a1, 124
    16c0:	21f8           	l32i.n	a15, a1, 8
    16c2:	a178           	l32i.n	a7, a1, 40
    16c4:	332a           	add.n	a3, a3, a2
    16c6:	1a2122        	l32i	a2, a1, 104
    16c9:	550b           	addi.n	a5, a5, -1
    16cb:	8346f0        	moveqz	a4, a6, a15
    16ce:	e20556        	bnez	a5, 14f2 <compander_AU_proc+0x232>
    16d1:	f01d           	retw.n

000016d3 <compander_AU_proc+0x413>:
	...

000016d4 <get_CPD_memsize>:
    16d4:	004136        	entry	a1, 32
    16d7:	023d           	mov.n	a3, a2
    16d9:	21a342        	movi	a4, 0x321
    16dc:	1144d0        	slli	a4, a4, 3
    16df:	40a122        	movi	a2, 0x140
    16e2:	330b           	addi.n	a3, a3, -1
    16e4:	932430        	movnez	a2, a4, a3
    16e7:	f01d           	retw.n

000016e9 <get_CPD_memsize+0x15>:
    16e9:	000000                                        ...

000016ec <get_INS_memsize>:
    16ec:	004136        	entry	a1, 32
    16ef:	15a122        	movi	a2, 0x115
    16f2:	1122d0        	slli	a2, a2, 3
    16f5:	f01d           	retw.n

000016f7 <get_INS_memsize+0xb>:
	...

000016f8 <calc_slope>:
    16f8:	006136        	entry	a1, 48
    16fb:	215920        	srai	a5, a2, 9
    16fe:	252a           	add.n	a2, a5, a2
    1700:	c05230        	sub	a5, a2, a3
    1703:	3129           	s32i.n	a2, a1, 12
    1705:	2159           	s32i.n	a5, a1, 8
    1707:	2d15a6        	blti	a5, 1, 1738 <calc_slope+0x40>
    170a:	c02240        	sub	a2, a2, a4
    170d:	364234        	ae_cvtq48a32s	aeq1, a2
    1710:	378434        	ae_truncp24a32x2	aep0, a4, a3
    1713:	f8e17ec53f 	{ ae_cvtq48a32s	aeq0, a5; ae_mulrfq32sp24s.l	aeq1, aeq1, aep0 }
    1718:	f86000c1ae 	{ addi	a10, a1, 12; ae_mulrfq32sp24s.h	aeq0, aeq0, aep0 }
    171d:	ff2c4081be 	{ addi	a11, a1, 8; ae_roundsq32asym	aeq3, aeq1 }
    1722:	fc247f3fef 	{ ae_trunca32q48	a15, aeq3; ae_roundsq32asym	aeq0, aeq0 }
    1727:	fa5d21        	l32r	a2, 9c (288 <Xdiv>)
    172a:	368e04        	ae_trunca32q48	a14, aeq0
    172d:	31e9           	s32i.n	a14, a1, 12
    172f:	21f9           	s32i.n	a15, a1, 8
    1731:	0002e0        	callx8	a2
    1734:	0a2d           	mov.n	a2, a10
    1736:	f01d           	retw.n

00001738 <calc_slope+0x40>:
    1738:	120c           	movi.n	a2, 1
    173a:	f01d           	retw.n

0000173c <calc_slope_1>:
    173c:	006136        	entry	a1, 48
    173f:	c0e420        	sub	a14, a4, a2
    1742:	215940        	srai	a5, a4, 9
    1745:	c02320        	sub	a2, a3, a2
    1748:	fe5a           	add.n	a15, a14, a5
    174a:	2129           	s32i.n	a2, a1, 8
    174c:	31f9           	s32i.n	a15, a1, 12
    174e:	151fa6        	blti	a15, 1, 1767 <calc_slope_1+0x2b>
    1751:	1612a6        	blti	a2, 1, 176b <calc_slope_1+0x2f>
    1754:	412220        	srli	a2, a2, 2
    1757:	2129           	s32i.n	a2, a1, 8
    1759:	fa5021        	l32r	a2, 9c (288 <Xdiv>)
    175c:	a18b           	addi.n	a10, a1, 8
    175e:	b1cb           	addi.n	a11, a1, 12
    1760:	0002e0        	callx8	a2
    1763:	0a2d           	mov.n	a2, a10
    1765:	f01d           	retw.n

00001767 <calc_slope_1+0x2b>:
    1767:	120c           	movi.n	a2, 1
    1769:	f01d           	retw.n

0000176b <calc_slope_1+0x2f>:
    176b:	120c           	movi.n	a2, 1
    176d:	112230        	slli	a2, a2, 13
    1770:	f01d           	retw.n

00001772 <calc_slope_1+0x36>:
	...

00001774 <calc_slope_2>:
    1774:	006136        	entry	a1, 48
    1777:	215920        	srai	a5, a2, 9
    177a:	252a           	add.n	a2, a5, a2
    177c:	c0d230        	sub	a13, a2, a3
    177f:	378434        	ae_truncp24a32x2	aep0, a4, a3
    1782:	360d34        	ae_cvtq48a32s	aeq0, a13
    1785:	f86015224f 	{ sub	a2, a2, a4; ae_mulrfq32sp24s.h	aeq0, aeq0, aep0 }
    178a:	364234        	ae_cvtq48a32s	aeq1, a2
    178d:	fc2440c1ae 	{ addi	a10, a1, 12; ae_roundsq32asym	aeq0, aeq0 }
    1792:	f8e17f0eef 	{ ae_trunca32q48	a14, aeq0; ae_mulrfq32sp24s.l	aeq1, aeq1, aep0 }
    1797:	b18b           	addi.n	a11, a1, 8
    1799:	065934        	ae_roundsq32asym	aeq1, aeq1
    179c:	2122e0        	srai	a2, a14, 2
    179f:	3129           	s32i.n	a2, a1, 12
    17a1:	fa3e21        	l32r	a2, 9c (288 <Xdiv>)
    17a4:	369f04        	ae_trunca32q48	a15, aeq1
    17a7:	21f9           	s32i.n	a15, a1, 8
    17a9:	0002e0        	callx8	a2
    17ac:	0a2d           	mov.n	a2, a10
    17ae:	f01d           	retw.n

000017b0 <INS_SetFrame120_Init>:
    17b0:	004136        	entry	a1, 32
    17b3:	a30c           	movi.n	a3, 10
    17b5:	08d222        	addmi	a2, a2, 0x800
    17b8:	535232        	s16i	a3, a2, 166
    17bb:	f01d           	retw.n

000017bd <INS_SetFrame120_Init+0xd>:
    17bd:	000000                                        ...

000017c0 <INS_SetFrame8_Init>:
    17c0:	004136        	entry	a1, 32
    17c3:	830c           	movi.n	a3, 8
    17c5:	08d222        	addmi	a2, a2, 0x800
    17c8:	535232        	s16i	a3, a2, 166
    17cb:	f01d           	retw.n

000017cd <INS_SetFrame8_Init+0xd>:
    17cd:	000000                                        ...

000017d0 <INS_Init>:
    17d0:	004136        	entry	a1, 32
    17d3:	020362        	l8ui	a6, a3, 2
    17d6:	030372        	l8ui	a7, a3, 3
    17d9:	0403e2        	l8ui	a14, a3, 4
    17dc:	0503f2        	l8ui	a15, a3, 5
    17df:	000342        	l8ui	a4, a3, 0
    17e2:	08d252        	addmi	a5, a2, 0x800
    17e5:	505542        	s16i	a4, a5, 160
    17e8:	8a7760        	depbits	a6, a7, 8, 8
    17eb:	fa2e41        	l32r	a4, a4 (1bc8 <xt_memset>)
    17ee:	515562        	s16i	a6, a5, 162
    17f1:	8a7fe0        	depbits	a14, a15, 8, 8
    17f4:	0b0c           	movi.n	a11, 0
    17f6:	50a3c2        	movi	a12, 0x350
    17f9:	02ad           	mov.n	a10, a2
    17fb:	5255e2        	s16i	a14, a5, 164
    17fe:	0004e0        	callx8	a4
    1801:	0a0372        	l8ui	a7, a3, 10
    1804:	0b0382        	l8ui	a8, a3, 11
    1807:	080342        	l8ui	a4, a3, 8
    180a:	090362        	l8ui	a6, a3, 9
    180d:	0603e2        	l8ui	a14, a3, 6
    1810:	070392        	l8ui	a9, a3, 7
    1813:	8a7870        	depbits	a7, a8, 8, 8
    1816:	531532        	l16ui	a3, a5, 166
    1819:	8a7640        	depbits	a4, a6, 8, 8
    181c:	11f700        	slli	a15, a7, 16
    181f:	8a79e0        	depbits	a14, a9, 8, 8
    1822:	4f4a           	add.n	a4, a15, a4
    1824:	4252e2        	s16i	a14, a2, 132
    1827:	206242        	s32i	a4, a2, 128
    182a:	0e8366        	bnei	a3, 8, 183c <INS_Init+0x6c>
    182d:	140c           	movi.n	a4, 1
    182f:	114440        	slli	a4, a4, 12
    1832:	115242        	s16i	a4, a2, 34
    1835:	831c           	movi.n	a3, 24
    1837:	840c           	movi.n	a4, 8
    1839:	000746        	j	185a <INS_Init+0x8a>

0000183c <INS_Init+0x6c>:
    183c:	0f9366        	bnei	a3, 10, 184f <INS_Init+0x7f>
    183f:	cda042        	movi	a4, 205
    1842:	0cd442        	addmi	a4, a4, 0xc00
    1845:	115242        	s16i	a4, a2, 34
    1848:	e31c           	movi.n	a3, 30
    184a:	a40c           	movi.n	a4, 10
    184c:	000286        	j	185a <INS_Init+0x8a>

0000184f <INS_Init+0x7f>:
    184f:	00a442        	movi	a4, 0x400
    1852:	115242        	s16i	a4, a2, 34
    1855:	60a032        	movi	a3, 96
    1858:	042c           	movi.n	a4, 32
    185a:	a0a0c2        	movi	a12, 160
    185d:	b239           	s32i.n	a3, a2, 44
    185f:	32ca           	add.n	a3, a2, a12
    1861:	1f0c           	movi.n	a15, 1
    1863:	c239           	s32i.n	a3, a2, 48
    1865:	d239           	s32i.n	a3, a2, 52
    1867:	013f50        	slli	a3, a15, 27
    186a:	fe7c           	movi.n	a14, -1
    186c:	f239           	s32i.n	a3, a2, 60
    186e:	e239           	s32i.n	a3, a2, 56
    1870:	fa2431        	l32r	a3, 100 (344 <AU_INS_coef_init>)
    1873:	105242        	s16i	a4, a2, 32
    1876:	4d0c           	movi.n	a13, 4
    1878:	4141e0        	srli	a4, a14, 1
    187b:	02ad           	mov.n	a10, a2
    187d:	3f52d2        	s16i	a13, a2, 126
    1880:	106242        	s32i	a4, a2, 64
    1883:	0003e0        	callx8	a3
    1886:	f01d           	retw.n

00001888 <INS_Prcs>:
    1888:	006136        	entry	a1, 48
    188b:	08d272        	addmi	a7, a2, 0x800
    188e:	a00772        	l8ui	a7, a7, 160
    1891:	08d282        	addmi	a8, a2, 0x800
    1894:	02e707        	bbsi	a7, 0, 189a <INS_Prcs+0x12>
    1897:	0024c6        	j	192e <INS_Prcs+0xa6>
    189a:	531882        	l16ui	a8, a8, 166
    189d:	109272        	l16si	a7, a2, 32
    18a0:	079826        	beqi	a8, 10, 18ab <INS_Prcs+0x23>
    18a3:	0f8866        	bnei	a8, 8, 18b6 <INS_Prcs+0x2e>
    18a6:	880c           	movi.n	a8, 8
    18a8:	000046        	j	18ad <INS_Prcs+0x25>

000018ab <INS_Prcs+0x23>:
    18ab:	a80c           	movi.n	a8, 10
    18ad:	d25580        	quos	a5, a5, a8
    18b0:	0815e6        	bgei	a5, 1, 18bc <INS_Prcs+0x34>
    18b3:	001dc6        	j	192e <INS_Prcs+0xa6>

000018b6 <INS_Prcs+0x2e>:
    18b6:	215550        	srai	a5, a5, 5
    18b9:	7115a6        	blti	a5, 1, 192e <INS_Prcs+0xa6>
    18bc:	1177e0        	slli	a7, a7, 2
    18bf:	000e86        	j	18fd <INS_Prcs+0x75>

000018c2 <INS_Prcs+0x3a>:
    18c2:	429282        	l16si	a8, a2, 132
    18c5:	11d800        	slli	a13, a8, 16
    18c8:	102282        	l32i	a8, a2, 64
    18cb:	29a292        	movi	a9, 0x229
    18ce:	51a4a2        	movi	a10, 0x451
    18d1:	7288d0        	salt	a8, a8, a13
    18d4:	1199e0        	slli	a9, a9, 2
    18d7:	11aaf0        	slli	a10, a10, 1
    18da:	939a80        	movnez	a9, a10, a8
    18dd:	829a           	add.n	a8, a2, a9
    18df:	28fd           	ae_l16si.n	a15, a8, 0
    18e1:	f9fe81        	l32r	a8, dc (ebc <F_CPD_Intp_Out>)
    18e4:	090c           	movi.n	a9, 0
    18e6:	02ad           	mov.n	a10, a2
    18e8:	03bd           	mov.n	a11, a3
    18ea:	04cd           	mov.n	a12, a4
    18ec:	06ed           	mov.n	a14, a6
    18ee:	1199           	s32i.n	a9, a1, 4
    18f0:	0199           	s32i.n	a9, a1, 0
    18f2:	0008e0        	callx8	a8
    18f5:	550b           	addi.n	a5, a5, -1
    18f7:	337a           	add.n	a3, a3, a7
    18f9:	447a           	add.n	a4, a4, a7
    18fb:	f5ac           	beqz.n	a5, 192e <INS_Prcs+0xa6>
    18fd:	f9f581        	l32r	a8, d4 (d34 <F_CPD_Mag_In>)
    1900:	1e0c           	movi.n	a14, 1
    1902:	02ad           	mov.n	a10, a2
    1904:	03bd           	mov.n	a11, a3
    1906:	04cd           	mov.n	a12, a4
    1908:	06dd           	mov.n	a13, a6
    190a:	0008e0        	callx8	a8
    190d:	202282        	l32i	a8, a2, 128
    1910:	232292        	l32i	a9, a2, 140
    1913:	fd7c           	movi.n	a13, -1
    1915:	90a880        	addx2	a10, a8, a8
    1918:	41d1d0        	srli	a13, a13, 1
    191b:	a9a9a7        	bge	a9, a10, 18c8 <INS_Prcs+0x40>
    191e:	a0a897        	bge	a8, a9, 18c2 <INS_Prcs+0x3a>
    1921:	f9eb81        	l32r	a8, d0 (ce0 <F_CPD_Ins_Gain>)
    1924:	02ad           	mov.n	a10, a2
    1926:	0008e0        	callx8	a8
    1929:	0add           	mov.n	a13, a10
    192b:	ffe646        	j	18c8 <INS_Prcs+0x40>

0000192e <INS_Prcs+0xa6>:
    192e:	f01d           	retw.n

00001930 <__do_global_ctors_aux>:
    1930:	004136        	entry	a1, 32
    1933:	f9f431        	l32r	a3, 104 (2100 <__CTOR_END__>)
    1936:	fcc322        	addi	a2, a3, -4
    1939:	0228           	l32i.n	a2, a2, 0
    193b:	f8c332        	addi	a3, a3, -8
    193e:	0a0226        	beqi	a2, -1, 194c <__do_global_ctors_aux+0x1c>

00001941 <__do_global_ctors_aux+0x11>:
    1941:	0002e0        	callx8	a2
    1944:	0328           	l32i.n	a2, a3, 0
    1946:	fcc332        	addi	a3, a3, -4
    1949:	f40266        	bnei	a2, -1, 1941 <__do_global_ctors_aux+0x11>
    194c:	f01d           	retw.n

0000194e <__do_global_ctors_aux+0x1e>:
	...

00001950 <HIFI_d1IB_v2_in32_c16_4th>:
    1950:	008136        	entry	a1, 64
    1953:	6d16a6        	blti	a6, 1, 19c4 <HIFI_d1IB_v2_in32_c16_4th+0x74>
    1956:	fcc222        	addi	a2, a2, -4
    1959:	440304        	ae_lp16x2f.i	aep0, a3, 0
    195c:	441314        	ae_lp16x2f.i	aep1, a3, 4
    195f:	442324        	ae_lp16x2f.i	aep2, a3, 8
    1962:	443334        	ae_lp16x2f.i	aep3, a3, 12
    1965:	444344        	ae_lp16x2f.i	aep4, a3, 16
    1968:	445354        	ae_lp16x2f.i	aep5, a3, 20
    196b:	023d           	mov.n	a3, a2
    196d:	538676        	loop	a6, 19c4 <HIFI_d1IB_v2_in32_c16_4th+0x74>
    1970:	601314        	ae_lq32f.iu	aeq0, a3, 4
    1973:	608404        	ae_lq32f.i	aeq2, a4, 0
    1976:	08067d641f 	{ ae_lq32f.i	aeq3, a4, 4; ae_mulzaafq32sp16s.hh	aeq1, aeq0, aep1, aeq2, aep0 }
    197b:	f602f9840f 	{ ae_sq32f.i	aeq0, a4, 0; ae_mulafq32sp16s.h	aeq1, aeq2, aep0 }
    1980:	f683f9a41f 	{ ae_sq32f.i	aeq2, a4, 4; ae_mulafq32sp16s.l	aeq1, aeq3, aep0 }
    1985:	600504        	ae_lq32f.i	aeq0, a5, 0
    1988:	f40afd651f 	{ ae_lq32f.i	aeq3, a5, 4; ae_mulafq32sp16s.h	aeq1, aeq0, aep2 }
    198d:	f40af9851f 	{ ae_sq32f.i	aeq0, a5, 4; ae_mulafq32sp16s.h	aeq1, aeq0, aep2 }
    1992:	0328d4        	ae_mulafq32sp16s.l	aeq1, aeq3, aep2
    1995:	065834        	ae_roundsq32sym	aeq1, aeq1
    1998:	09713a112f 	{ ae_sq56s.i	aeq1, a1, 16; ae_mulzaafq32sp16s.hh	aeq2, aeq1, aep4, aeq0, aep3 }
    199d:	f50ebd253f 	{ ae_lq32f.i	aeq1, a5, 12; ae_mulafq32sp16s.h	aeq2, aeq0, aep3 }
    19a2:	f78fbd652f 	{ ae_lq32f.i	aeq3, a5, 8; ae_mulafq32sp16s.l	aeq2, aeq3, aep3 }
    19a7:	f717ba113f 	{ ae_sq56s.i	aeq1, a1, 24; ae_mulafq32sp16s.h	aeq2, aeq3, aep5 }
    19ac:	f717bda13f 	{ ae_lq56.i	aeq1, a1, 24; ae_mulafq32sp16s.h	aeq2, aeq3, aep5 }
    19b1:	f597b9b53f 	{ ae_sq32f.i	aeq3, a5, 12; ae_mulafq32sp16s.l	aeq2, aeq1, aep5 }
    19b6:	614124        	ae_lq56.i	aeq1, a1, 16
    19b9:	ff5479950f 	{ ae_sq32f.i	aeq1, a5, 0; ae_roundsq32sym	aeq3, aeq2 }
    19be:	623524        	ae_sq32f.i	aeq3, a5, 8
    19c1:	627214        	ae_sq32f.iu	aeq3, a2, 4

000019c4 <HIFI_d1IB_v2_in32_c16_4th+0x74>:
    19c4:	f01d           	retw.n

000019c6 <HIFI_d1IB_v2_in32_c16_4th+0x76>:
	...

000019c8 <HIFI_d1IB_v2_in24_c24_4th>:
    19c8:	004136        	entry	a1, 32
    19cb:	5116a6        	blti	a6, 1, 1a20 <HIFI_d1IB_v2_in24_c24_4th+0x58>
    19ce:	fcc222        	addi	a2, a2, -4
    19d1:	027d           	mov.n	a7, a2
    19d3:	f03d           	nop.n
    19d5:	478676        	loop	a6, 1a20 <HIFI_d1IB_v2_in24_c24_4th+0x58>
    19d8:	4c8714        	ae_lp24.iu	aep0, a7, 4
    19db:	5c2404        	ae_lp24x2f.i	aep2, a4, 0
    19de:	dc4130130f 	{ ae_lp24x2.i	aep1, a3, 0; ae_selp24.hh	aep0, aep0, aep2 }
    19e3:	f02ab0331f 	{ ae_lp24x2.i	aep3, a3, 8; ae_mulzaafp24s.hh.ll	aeq0, aep2, aep1 }
    19e8:	e26030432f 	{ ae_lp24x2.i	aep4, a3, 16; ae_mulaafp24s.hh.ll	aeq0, aep0, aep3 }
    19ed:	5c5504        	ae_lp24x2f.i	aep5, a5, 0
    19f0:	e29436040f 	{ ae_sp24x2f.i	aep0, a4, 0; ae_mulaafp24s.hh.ll	aeq0, aep5, aep4 }
    19f5:	e29630033f 	{ ae_lp24x2.i	aep0, a3, 24; ae_mulafp24s.hh	aeq0, aep5, aep4 }
    19fa:	f116f0634f 	{ ae_lp24x2.i	aep6, a3, 32; ae_mulzaafp24s.hh.ll	aeq3, aep5, aep0 }
    19ff:	1b8c74        	ae_roundsp24q48sym	aep7, aeq0
    1a02:	debd30535f 	{ ae_lp24x2.i	aep5, a3, 40; ae_selp24.hh	aep4, aep7, aep5 }
    1a07:	e3d06f651f 	{ ae_lp24x2f.i	aep6, a5, 8; ae_mulaafp24s.hh.ll	aeq3, aep4, aep6 }
    1a0c:	e3b876450f 	{ ae_sp24x2f.i	aep4, a5, 0; ae_mulaafp24s.hh.ll	aeq3, aep6, aep5 }
    1a11:	01ed04        	ae_mulafp24s.hh	aeq3, aep6, aep5
    1a14:	1bbc24        	ae_roundsp24q48sym	aep2, aeq3
    1a17:	1aaef4        	ae_selp24.hh	aep7, aep2, aep6
    1a1a:	5e7514        	ae_sp24x2f.i	aep7, a5, 8
    1a1d:	4ea214        	ae_sp24s.l.iu	aep2, a2, 4

00001a20 <HIFI_d1IB_v2_in24_c24_4th+0x58>:
    1a20:	f01d           	retw.n

00001a22 <HIFI_d1IB_v2_in24_c24_4th+0x5a>:
	...

00001a24 <HIFI_d1IB_v2_in32_c24_4th>:
    1a24:	006136        	entry	a1, 48
    1a27:	6c16a6        	blti	a6, 1, 1a97 <HIFI_d1IB_v2_in32_c24_4th+0x73>
    1a2a:	fcc222        	addi	a2, a2, -4
    1a2d:	540304        	ae_lp24x2.i	aep0, a3, 0
    1a30:	541314        	ae_lp24x2.i	aep1, a3, 8
    1a33:	542324        	ae_lp24x2.i	aep2, a3, 16
    1a36:	207220        	or	a7, a2, a2
    1a39:	5a8676        	loop	a6, 1a97 <HIFI_d1IB_v2_in32_c24_4th+0x73>
    1a3c:	601714        	ae_lq32f.iu	aeq0, a7, 4
    1a3f:	f8047d440f 	{ ae_lq32f.i	aeq2, a4, 0; ae_mulfq32sp24s.h	aeq1, aeq0, aep1 }
    1a44:	f642fd641f 	{ ae_lq32f.i	aeq3, a4, 4; ae_mulafq32sp24s.h	aeq1, aeq2, aep0 }
    1a49:	f642f9840f 	{ ae_sq32f.i	aeq0, a4, 0; ae_mulafq32sp24s.h	aeq1, aeq2, aep0 }
    1a4e:	f6c3f9a41f 	{ ae_sq32f.i	aeq2, a4, 4; ae_mulafq32sp24s.l	aeq1, aeq3, aep0 }
    1a53:	600504        	ae_lq32f.i	aeq0, a5, 0
    1a56:	f44afd651f 	{ ae_lq32f.i	aeq3, a5, 4; ae_mulafq32sp24s.h	aeq1, aeq0, aep2 }
    1a5b:	f44af0334f 	{ ae_lp24x2.i	aep3, a3, 32; ae_mulafq32sp24s.h	aeq1, aeq0, aep2 }
    1a60:	f6cbf0733f 	{ ae_lp24x2.i	aep7, a3, 24; ae_mulafq32sp24s.l	aeq1, aeq3, aep2 }
    1a65:	544354        	ae_lp24x2.i	aep4, a3, 40
    1a68:	fd4c79851f 	{ ae_sq32f.i	aeq0, a5, 4; ae_roundsq32sym	aeq1, aeq1 }
    1a6d:	f90d3a111f 	{ ae_sq56s.i	aeq1, a1, 8; ae_mulfq32sp24s.h	aeq2, aeq1, aep3 }
    1a72:	f55ebd253f 	{ ae_lq32f.i	aeq1, a5, 12; ae_mulafq32sp24s.h	aeq2, aeq0, aep7 }
    1a77:	08f224        	ae_mulafq32sp24s.h	aeq2, aeq0, aep7
    1a7a:	f7dfbd652f 	{ ae_lq32f.i	aeq3, a5, 8; ae_mulafq32sp24s.l	aeq2, aeq3, aep7 }
    1a7f:	f753b9b53f 	{ ae_sq32f.i	aeq3, a5, 12; ae_mulafq32sp24s.h	aeq2, aeq3, aep4 }
    1a84:	08c2e4        	ae_mulafq32sp24s.h	aeq2, aeq3, aep4
    1a87:	f5d3bda11f 	{ ae_lq56.i	aeq1, a1, 8; ae_mulafq32sp24s.l	aeq2, aeq1, aep4 }
    1a8c:	ff5479950f 	{ ae_sq32f.i	aeq1, a5, 0; ae_roundsq32sym	aeq3, aeq2 }
    1a91:	623524        	ae_sq32f.i	aeq3, a5, 8
    1a94:	627214        	ae_sq32f.iu	aeq3, a2, 4

00001a97 <HIFI_d1IB_v2_in32_c24_4th+0x73>:
    1a97:	f01d           	retw.n

00001a99 <HIFI_d1IB_v2_in32_c24_4th+0x75>:
    1a99:	00000000                                 .......

00001aa0 <HIFI_d1IB_v2_in32_c16_3rd>:
    1aa0:	004136        	entry	a1, 32
    1aa3:	5916a6        	blti	a6, 1, 1b00 <HIFI_d1IB_v2_in32_c16_3rd+0x60>
    1aa6:	fcc222        	addi	a2, a2, -4
    1aa9:	440304        	ae_lp16x2f.i	aep0, a3, 0
    1aac:	441314        	ae_lp16x2f.i	aep1, a3, 4
    1aaf:	442324        	ae_lp16x2f.i	aep2, a3, 8
    1ab2:	443334        	ae_lp16x2f.i	aep3, a3, 12
    1ab5:	444344        	ae_lp16x2f.i	aep4, a3, 16
    1ab8:	023d           	mov.n	a3, a2
    1aba:	428676        	loop	a6, 1b00 <HIFI_d1IB_v2_in32_c16_3rd+0x60>
    1abd:	601314        	ae_lq32f.iu	aeq0, a3, 4
    1ac0:	608404        	ae_lq32f.i	aeq2, a4, 0
    1ac3:	08067d641f 	{ ae_lq32f.i	aeq3, a4, 4; ae_mulzaafq32sp16s.hh	aeq1, aeq0, aep1, aeq2, aep0 }
    1ac8:	f602f9840f 	{ ae_sq32f.i	aeq0, a4, 0; ae_mulafq32sp16s.h	aeq1, aeq2, aep0 }
    1acd:	f683f9a41f 	{ ae_sq32f.i	aeq2, a4, 4; ae_mulafq32sp16s.l	aeq1, aeq3, aep0 }
    1ad2:	600504        	ae_lq32f.i	aeq0, a5, 0
    1ad5:	f40afd651f 	{ ae_lq32f.i	aeq3, a5, 4; ae_mulafq32sp16s.h	aeq1, aeq0, aep2 }
    1ada:	f40af9851f 	{ ae_sq32f.i	aeq0, a5, 4; ae_mulafq32sp16s.h	aeq1, aeq0, aep2 }
    1adf:	f68bfd652f 	{ ae_lq32f.i	aeq3, a5, 8; ae_mulafq32sp16s.l	aeq1, aeq3, aep2 }
    1ae4:	fd4c79b53f 	{ ae_sq32f.i	aeq3, a5, 12; ae_roundsq32sym	aeq1, aeq1 }
    1ae9:	098d39950f 	{ ae_sq32f.i	aeq1, a5, 0; ae_mulzaafq32sp16s.hh	aeq2, aeq1, aep3, aeq0, aep4 }
    1aee:	03c004        	ae_mulafq32sp16s.h	aeq2, aeq0, aep4
    1af1:	03c0d4        	ae_mulafq32sp16s.l	aeq2, aeq3, aep4
    1af4:	03c0d4        	ae_mulafq32sp16s.l	aeq2, aeq3, aep4
    1af7:	06e834        	ae_roundsq32sym	aeq3, aeq2
    1afa:	623524        	ae_sq32f.i	aeq3, a5, 8
    1afd:	627214        	ae_sq32f.iu	aeq3, a2, 4

00001b00 <HIFI_d1IB_v2_in32_c16_3rd+0x60>:
    1b00:	f01d           	retw.n

00001b02 <HIFI_d1IB_v2_in32_c16_3rd+0x62>:
	...

00001b04 <HIFI_d1IB_v2_in24_c24_3rd>:
    1b04:	004136        	entry	a1, 32
    1b07:	4d16a6        	blti	a6, 1, 1b58 <HIFI_d1IB_v2_in24_c24_3rd+0x54>
    1b0a:	fcc222        	addi	a2, a2, -4
    1b0d:	027d           	mov.n	a7, a2
    1b0f:	458676        	loop	a6, 1b58 <HIFI_d1IB_v2_in24_c24_3rd+0x54>
    1b12:	540304        	ae_lp24x2.i	aep0, a3, 0
    1b15:	5c1404        	ae_lp24x2f.i	aep1, a4, 0
    1b18:	f006b1a71f 	{ ae_lp24.iu	aep2, a7, 4; ae_mulzaafp24s.hh.ll	aeq0, aep1, aep0 }
    1b1d:	dc2970631f 	{ ae_lp24x2.i	aep6, a3, 8; ae_selp24.hh	aep1, aep2, aep1 }
    1b22:	e2c430732f 	{ ae_lp24x2.i	aep7, a3, 16; ae_mulaafp24s.hh.ll	aeq0, aep1, aep6 }
    1b27:	5c3504        	ae_lp24x2f.i	aep3, a5, 0
    1b2a:	e2ec36140f 	{ ae_sp24x2f.i	aep1, a4, 0; ae_mulaafp24s.hh.ll	aeq0, aep3, aep7 }
    1b2f:	e2ee30533f 	{ ae_lp24x2.i	aep5, a3, 24; ae_mulafp24s.hh	aeq0, aep3, aep7 }
    1b34:	fae7af651f 	{ ae_lp24x2f.i	aep6, a5, 8; ae_roundsp24q48sym	aep4, aeq0 }
    1b39:	1acb84        	ae_selp24.hh	aep0, aep4, aep3
    1b3c:	f1a2f6050f 	{ ae_sp24x2f.i	aep0, a5, 0; ae_mulzaafp24s.hh.ll	aeq3, aep0, aep5 }
    1b41:	e3a3f0734f 	{ ae_lp24x2.i	aep7, a3, 32; ae_mulafp24s.ll	aeq3, aep0, aep5 }
    1b46:	01ef14        	ae_mulafp24s.hl	aeq3, aep6, aep7
    1b49:	01ef14        	ae_mulafp24s.hl	aeq3, aep6, aep7
    1b4c:	1bbc04        	ae_roundsp24q48sym	aep0, aeq3
    1b4f:	1a8e94        	ae_selp24.hh	aep1, aep0, aep6
    1b52:	5e1514        	ae_sp24x2f.i	aep1, a5, 8
    1b55:	4e8214        	ae_sp24s.l.iu	aep0, a2, 4

00001b58 <HIFI_d1IB_v2_in24_c24_3rd+0x54>:
    1b58:	f01d           	retw.n

00001b5a <HIFI_d1IB_v2_in24_c24_3rd+0x56>:
	...

00001b5c <HIFI_d1IB_v2_in32_c24_3rd>:
    1b5c:	004136        	entry	a1, 32
    1b5f:	5e16a6        	blti	a6, 1, 1bc1 <HIFI_d1IB_v2_in32_c24_3rd+0x65>
    1b62:	fcc222        	addi	a2, a2, -4
    1b65:	540304        	ae_lp24x2.i	aep0, a3, 0
    1b68:	541314        	ae_lp24x2.i	aep1, a3, 8
    1b6b:	542324        	ae_lp24x2.i	aep2, a3, 16
    1b6e:	207220        	or	a7, a2, a2
    1b71:	4c8676        	loop	a6, 1bc1 <HIFI_d1IB_v2_in32_c24_3rd+0x65>
    1b74:	601714        	ae_lq32f.iu	aeq0, a7, 4
    1b77:	f8047d440f 	{ ae_lq32f.i	aeq2, a4, 0; ae_mulfq32sp24s.h	aeq1, aeq0, aep1 }
    1b7c:	f642fd641f 	{ ae_lq32f.i	aeq3, a4, 4; ae_mulafq32sp24s.h	aeq1, aeq2, aep0 }
    1b81:	f642f9840f 	{ ae_sq32f.i	aeq0, a4, 0; ae_mulafq32sp24s.h	aeq1, aeq2, aep0 }
    1b86:	f6c3f9a41f 	{ ae_sq32f.i	aeq2, a4, 4; ae_mulafq32sp24s.l	aeq1, aeq3, aep0 }
    1b8b:	600504        	ae_lq32f.i	aeq0, a5, 0
    1b8e:	f44afd651f 	{ ae_lq32f.i	aeq3, a5, 4; ae_mulafq32sp24s.h	aeq1, aeq0, aep2 }
    1b93:	f44af0333f 	{ ae_lp24x2.i	aep3, a3, 24; ae_mulafq32sp24s.h	aeq1, aeq0, aep2 }
    1b98:	f6cbf0734f 	{ ae_lp24x2.i	aep7, a3, 32; ae_mulafq32sp24s.l	aeq1, aeq3, aep2 }
    1b9d:	60c524        	ae_lq32f.i	aeq3, a5, 8
    1ba0:	fd4c79b53f 	{ ae_sq32f.i	aeq3, a5, 12; ae_roundsq32sym	aeq1, aeq1 }
    1ba5:	f90d39851f 	{ ae_sq32f.i	aeq0, a5, 4; ae_mulfq32sp24s.h	aeq2, aeq1, aep3 }
    1baa:	f55eb9950f 	{ ae_sq32f.i	aeq1, a5, 0; ae_mulafq32sp24s.h	aeq2, aeq0, aep7 }
    1baf:	08f224        	ae_mulafq32sp24s.h	aeq2, aeq0, aep7
    1bb2:	08f3e4        	ae_mulafq32sp24s.l	aeq2, aeq3, aep7
    1bb5:	08f3e4        	ae_mulafq32sp24s.l	aeq2, aeq3, aep7
    1bb8:	06e834        	ae_roundsq32sym	aeq3, aeq2
    1bbb:	623524        	ae_sq32f.i	aeq3, a5, 8
    1bbe:	627214        	ae_sq32f.iu	aeq3, a2, 4

00001bc1 <HIFI_d1IB_v2_in32_c24_3rd+0x65>:
    1bc1:	f01d           	retw.n

00001bc3 <HIFI_d1IB_v2_in32_c24_3rd+0x67>:
    1bc3:	00000000                                 .....

00001bc8 <xt_memset>:
    1bc8:	004136        	entry	a1, 32
    1bcb:	928c           	beqz.n	a2, 1bd8 <xt_memset+0x10>
    1bcd:	748c           	beqz.n	a4, 1bd8 <xt_memset+0x10>
    1bcf:	025d           	mov.n	a5, a2
    1bd1:	038476        	loop	a4, 1bd8 <xt_memset+0x10>
    1bd4:	653d           	ae_s16i.n	a3, a5, 0
    1bd6:	552b           	addi.n	a5, a5, 2

00001bd8 <xt_memset+0x10>:
    1bd8:	f01d           	retw.n

00001bda <xt_memset+0x12>:
	...

00001bdc <xt_memcpy>:
    1bdc:	004136        	entry	a1, 32
    1bdf:	025d           	mov.n	a5, a2
    1be1:	020c           	movi.n	a2, 0
    1be3:	b5bc           	beqz.n	a5, 1c22 <xt_memcpy+0x46>
    1be5:	93bc           	beqz.n	a3, 1c22 <xt_memcpy+0x46>
    1be7:	24b357        	bgeu	a3, a5, 1c0f <xt_memcpy+0x33>
    1bea:	902430        	addx2	a2, a4, a3
    1bed:	1eb527        	bgeu	a5, a2, 1c0f <xt_memcpy+0x33>
    1bf0:	052d           	mov.n	a2, a5
    1bf2:	c4ac           	beqz.n	a4, 1c22 <xt_memcpy+0x46>
    1bf4:	240b           	addi.n	a2, a4, -1
    1bf6:	1122f0        	slli	a2, a2, 1
    1bf9:	332a           	add.n	a3, a3, a2
    1bfb:	652a           	add.n	a6, a5, a2
    1bfd:	0b8476        	loop	a4, 1c0c <xt_memcpy+0x30>
    1c00:	232d           	ae_l16si.n	a2, a3, 0
    1c02:	662d           	ae_s16i.n	a2, a6, 0
    1c04:	fec332        	addi	a3, a3, -2
    1c07:	052d           	mov.n	a2, a5
    1c09:	fec662        	addi	a6, a6, -2

00001c0c <xt_memcpy+0x30>:
    1c0c:	000486        	j	1c22 <xt_memcpy+0x46>

00001c0f <xt_memcpy+0x33>:
    1c0f:	052d           	mov.n	a2, a5
    1c11:	d48c           	beqz.n	a4, 1c22 <xt_memcpy+0x46>
    1c13:	056d           	mov.n	a6, a5
    1c15:	098476        	loop	a4, 1c22 <xt_memcpy+0x46>
    1c18:	232d           	ae_l16si.n	a2, a3, 0
    1c1a:	662d           	ae_s16i.n	a2, a6, 0
    1c1c:	332b           	addi.n	a3, a3, 2
    1c1e:	052d           	mov.n	a2, a5
    1c20:	662b           	addi.n	a6, a6, 2

00001c22 <xt_memcpy+0x46>:
    1c22:	f01d           	retw.n

00001c24 <_fini>:
    1c24:	008136        	entry	a1, 64
    1c27:	f93881        	l32r	a8, 108 (124 <__do_global_dtors_aux>)
    1c2a:	f03d           	nop.n
    1c2c:	0008e0        	callx8	a8

00001c2f <_fini+0xb>:
    1c2f:	f01d           	retw.n
