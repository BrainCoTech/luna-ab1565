
Build/lib/pisplit_sbc_enc_position_independent.splitload.lib:     file format elf32-xtensa-le


Disassembly of section .text:

00000000 <_init-0x70>:
       0:	000000bc 00001184 0000148c 00000000     ................
      10:	00001458 00000000 00001474 00001650     X.......t...P...
      20:	000014ac 00000fd8 000014ce 00000fe0     ................
      30:	000014e5 000010b0 000014a0 00001580     ................
      40:	00001500 00001540 0000086c 000008e8     ....@...l.......
      50:	00001620 000007e0 00000108 00000118      ...............
      60:	00000154 0000048c 00001460 00000088     T.......`.......

00000070 <_init>:
      70:	008136        	entry	a1, 64
      73:	ffe381        	l32r	a8, 0 (bc <frame_dummy>)
      76:	f03d           	nop.n
      78:	0008e0        	callx8	a8
      7b:	ffe281        	l32r	a8, 4 (1184 <__do_global_ctors_aux>)
      7e:	f03d           	nop.n
      80:	0008e0        	callx8	a8
      83:	f01d           	retw.n

00000085 <_init+0x15>:
      85:	000000                                        ...

00000088 <__do_global_dtors_aux>:
      88:	004136        	entry	a1, 32
      8b:	ffdf21        	l32r	a2, 8 (148c <__do_global_dtors_aux.completed>)
      8e:	000232        	l8ui	a3, a2, 0
      91:	23ec           	bnez.n	a3, b7 <__do_global_dtors_aux+0x2f>

00000093 <__do_global_dtors_aux+0xb>:
      93:	1248           	l32i.n	a4, a2, 4
      95:	0438           	l32i.n	a3, a4, 0
      97:	444b           	addi.n	a4, a4, 4
      99:	738c           	beqz.n	a3, a4 <__do_global_dtors_aux+0x1c>
      9b:	1249           	s32i.n	a4, a2, 4
      9d:	0003e0        	callx8	a3
      a0:	fffbc6        	j	93 <__do_global_dtors_aux+0xb>

000000a3 <__do_global_dtors_aux+0x1b>:
	...

000000a4 <__do_global_dtors_aux+0x1c>:
      a4:	ffda31        	l32r	a3, c (0 <_text_start>)
      a7:	ffdaa1        	l32r	a10, 10 (1458 <__FRAME_END__>)
      aa:	438c           	beqz.n	a3, b2 <__do_global_dtors_aux+0x2a>
      ac:	ffd881        	l32r	a8, c (0 <_text_start>)
      af:	0008e0        	callx8	a8
      b2:	130c           	movi.n	a3, 1
      b4:	004232        	s8i	a3, a2, 0
      b7:	f01d           	retw.n

000000b9 <__do_global_dtors_aux+0x31>:
      b9:	000000                                        ...

000000bc <frame_dummy>:
      bc:	004136        	entry	a1, 32
      bf:	ffd521        	l32r	a2, 14 (0 <_text_start>)
      c2:	ffd3a1        	l32r	a10, 10 (1458 <__FRAME_END__>)
      c5:	ffd4b1        	l32r	a11, 18 (1474 <frame_dummy.object>)
      c8:	428c           	beqz.n	a2, d0 <frame_dummy+0x14>
      ca:	ffd281        	l32r	a8, 14 (0 <_text_start>)
      cd:	0008e0        	callx8	a8

000000d0 <frame_dummy+0x14>:
      d0:	f01d           	retw.n

000000d2 <frame_dummy+0x16>:
	...

000000d4 <_start>:
      d4:	004136        	entry	a1, 32
      d7:	ffd131        	l32r	a3, 1c (1650 <printf_ptr>)
      da:	0228           	l32i.n	a2, a2, 0
      dc:	ffd1a1        	l32r	a10, 20 (14ac <export_parameter_array+0xc>)
      df:	ffd1b1        	l32r	a11, 24 (fd8 <sbc_encoder_get_buffer_size>)
      e2:	006322        	s32i	a2, a3, 0
      e5:	0002e0        	callx8	a2
      e8:	002322        	l32i	a2, a3, 0
      eb:	ffcfa1        	l32r	a10, 28 (14ce <export_parameter_array+0x2e>)
      ee:	ffcfb1        	l32r	a11, 2c (fe0 <sbc_encoder_init>)
      f1:	0002e0        	callx8	a2
      f4:	002322        	l32i	a2, a3, 0
      f7:	ffcea1        	l32r	a10, 30 (14e5 <export_parameter_array+0x45>)
      fa:	ffceb1        	l32r	a11, 34 (10b0 <sbc_encoder_process>)
      fd:	0002e0        	callx8	a2
     100:	ffce21        	l32r	a2, 38 (14a0 <export_parameter_array>)
     103:	f01d           	retw.n

00000105 <_start+0x31>:
     105:	000000                                        ...

00000108 <get_sbc_frame_pcm_byte_count>:
     108:	004136        	entry	a1, 32
     10b:	822230        	mull	a2, a2, a3
     10e:	822240        	mull	a2, a2, a4
     111:	1122f0        	slli	a2, a2, 1
     114:	f01d           	retw.n

00000116 <get_sbc_frame_pcm_byte_count+0xe>:
	...

00000118 <get_sbc_frame_bitstream_byte_count>:
     118:	004136        	entry	a1, 32
     11b:	260c           	movi.n	a6, 2
     11d:	170c           	movi.n	a7, 1
     11f:	937630        	movnez	a7, a6, a3
     122:	826740        	mull	a6, a7, a4
     125:	fdc382        	addi	a8, a3, -3
     128:	216160        	srai	a6, a6, 1
     12b:	664b           	addi.n	a6, a6, 4
     12d:	0923f6        	bgeui	a3, 2, 13a <get_sbc_frame_bitstream_byte_count+0x22>
     130:	822520        	mull	a2, a5, a2
     133:	822270        	mull	a2, a2, a7
     136:	000286        	j	144 <get_sbc_frame_bitstream_byte_count+0x2c>

00000139 <get_sbc_frame_bitstream_byte_count+0x21>:
	...

0000013a <get_sbc_frame_bitstream_byte_count+0x22>:
     13a:	070c           	movi.n	a7, 0
     13c:	822520        	mull	a2, a5, a2
     13f:	934780        	movnez	a4, a7, a8
     142:	224a           	add.n	a2, a2, a4
     144:	327b           	addi.n	a3, a2, 7
     146:	f2eb           	addi.n	a15, a2, 14
     148:	b3f330        	movgez	a15, a3, a3
     14b:	2123f0        	srai	a2, a15, 3
     14e:	262a           	add.n	a2, a6, a2
     150:	f01d           	retw.n

00000152 <get_sbc_frame_bitstream_byte_count+0x3a>:
	...

00000154 <sbc_analyze_audio>:
     154:	026136        	entry	a1, 0x130
     157:	22f8           	l32i.n	a15, a2, 8
     159:	206122        	s32i	a2, a1, 128
     15c:	202122        	l32i	a2, a1, 128
     15f:	028f26        	beqi	a15, 8, 165 <sbc_analyze_audio+0x11>
     162:	00c886        	j	488 <sbc_analyze_audio+0x334>
     165:	01d142        	addmi	a4, a1, 0x100
     168:	1228           	l32i.n	a2, a2, 4
     16a:	ccc442        	addi	a4, a4, -52
     16d:	01d1b2        	addmi	a11, a1, 0x100
     170:	0212e6        	bgei	a2, 1, 176 <sbc_analyze_audio+0x22>
     173:	00c446        	j	488 <sbc_analyze_audio+0x334>
     176:	306142        	s32i	a4, a1, 192
     179:	d4cb42        	addi	a4, a11, -44
     17c:	01d1c2        	addmi	a12, a1, 0x100
     17f:	2f6142        	s32i	a4, a1, 188
     182:	eccc42        	addi	a4, a12, -20
     185:	01d1d2        	addmi	a13, a1, 0x100
     188:	2e6142        	s32i	a4, a1, 184
     18b:	dccd42        	addi	a4, a13, -36
     18e:	01d1e2        	addmi	a14, a1, 0x100
     191:	2d6142        	s32i	a4, a1, 180
     194:	e4ce42        	addi	a4, a14, -28
     197:	01d1f2        	addmi	a15, a1, 0x100
     19a:	2c6142        	s32i	a4, a1, 176
     19d:	f4cf42        	addi	a4, a15, -12
     1a0:	01d152        	addmi	a5, a1, 0x100
     1a3:	2b6142        	s32i	a4, a1, 172
     1a6:	45cb           	addi.n	a4, a5, 12
     1a8:	01d162        	addmi	a6, a1, 0x100
     1ab:	2021d2        	l32i	a13, a1, 128
     1ae:	2a6142        	s32i	a4, a1, 168
     1b1:	fcc642        	addi	a4, a6, -4
     1b4:	ffa281        	l32r	a8, 3c (1580 <sbc_proto_8_40_fx>)
     1b7:	ffa251        	l32r	a5, 40 (1500 <anamatrix8_up>)
     1ba:	ffa261        	l32r	a6, 44 (1540 <anamatrix8_lo>)
     1bd:	1192f0        	slli	a9, a2, 1
     1c0:	c0e390        	sub	a14, a3, a9
     1c3:	01d172        	addmi	a7, a1, 0x100
     1c6:	0d38           	l32i.n	a3, a13, 0
     1c8:	fcc5b2        	addi	a11, a5, -4
     1cb:	fcc6c2        	addi	a12, a6, -4
     1ce:	296142        	s32i	a4, a1, 164
     1d1:	474b           	addi.n	a4, a7, 4
     1d3:	7cc8a2        	addi	a10, a8, 124
     1d6:	11f2c0        	slli	a15, a2, 4
     1d9:	2661b2        	s32i	a11, a1, 152
     1dc:	2561c2        	s32i	a12, a1, 148
     1df:	2461f2        	s32i	a15, a1, 144
     1e2:	14cdb2        	addi	a11, a13, 20
     1e5:	286142        	s32i	a4, a1, 160
     1e8:	2761a2        	s32i	a10, a1, 156
     1eb:	060c           	movi.n	a6, 0
     1ed:	ec7c           	movi.n	a12, -2
     1ef:	84afd2        	movi	a13, -124
     1f2:	0f2c           	movi.n	a15, 32
     1f4:	452c           	movi.n	a5, 36
     1f6:	000386        	j	208 <sbc_analyze_audio+0xb4>

000001f9 <sbc_analyze_audio+0xa5>:
	...

000001fb <sbc_analyze_audio+0xa7>:
     1fb:	661b           	addi.n	a6, a6, 1
     1fd:	ee2b           	addi.n	a14, a14, 2
     1ff:	20cbb2        	addi	a11, a11, 32
     202:	022627        	blt	a6, a2, 208 <sbc_analyze_audio+0xb4>
     205:	009fc6        	j	488 <sbc_analyze_audio+0x334>
     208:	ef13a6        	blti	a3, 1, 1fb <sbc_analyze_audio+0xa7>
     20b:	202142        	l32i	a4, a1, 128
     20e:	a03660        	addx4	a3, a6, a6
     211:	216162        	s32i	a6, a1, 132
     214:	a02640        	addx4	a2, a6, a4
     217:	06d222        	addmi	a2, a2, 0x600
     21a:	1163b0        	slli	a6, a3, 5
     21d:	336122        	s32i	a2, a1, 204
     220:	246a           	add.n	a2, a4, a6
     222:	2ca572        	movi	a7, 0x52c
     225:	cca582        	movi	a8, 0x5cc
     228:	327a           	add.n	a3, a2, a7
     22a:	802280        	add	a2, a2, a8
     22d:	00a0a2        	movi	a10, 0
     230:	2261b2        	s32i	a11, a1, 136
     233:	326132        	s32i	a3, a1, 200
     236:	2361e2        	s32i	a14, a1, 140
     239:	316122        	s32i	a2, a1, 196
     23c:	332142        	l32i	a4, a1, 204
     23f:	322132        	l32i	a3, a1, 200
     242:	312172        	l32i	a7, a1, 196
     245:	f3f630        	wur.ae_cbegin0	a3
     248:	f3f770        	wur.ae_cend0	a7
     24b:	1b2422        	l32i	a2, a4, 108
     24e:	0e6d           	mov.n	a6, a14
     250:	419694        	ae_lp16f.xu	aep1, a6, a9
     253:	fc24e292cf 	{ ae_sp16f.l.c	aep1, a2, a12; nop }
     258:	419694        	ae_lp16f.xu	aep1, a6, a9
     25b:	fc24e292cf 	{ ae_sp16f.l.c	aep1, a2, a12; nop }
     260:	419694        	ae_lp16f.xu	aep1, a6, a9
     263:	fc24e292cf 	{ ae_sp16f.l.c	aep1, a2, a12; nop }
     268:	419694        	ae_lp16f.xu	aep1, a6, a9
     26b:	fc24e292cf 	{ ae_sp16f.l.c	aep1, a2, a12; nop }
     270:	419694        	ae_lp16f.xu	aep1, a6, a9
     273:	fc24e292cf 	{ ae_sp16f.l.c	aep1, a2, a12; nop }
     278:	419694        	ae_lp16f.xu	aep1, a6, a9
     27b:	fc24e292cf 	{ ae_sp16f.l.c	aep1, a2, a12; nop }
     280:	419694        	ae_lp16f.xu	aep1, a6, a9
     283:	fc24e292cf 	{ ae_sp16f.l.c	aep1, a2, a12; nop }
     288:	419694        	ae_lp16f.xu	aep1, a6, a9
     28b:	272172        	l32i	a7, a1, 156
     28e:	fc24e292cf 	{ ae_sp16f.l.c	aep1, a2, a12; nop }
     293:	1b6422        	s32i	a2, a4, 108
     296:	230c           	movi.n	a3, 2
     298:	fc24d9123f 	{ ae_lp16f.c	aep1, a2, a3; nop }
     29d:	4587d4        	ae_lp16x2f.xu	aep0, a7, a13
     2a0:	fc24da92ff 	{ ae_lp16x2f.c	aep1, a2, a15; nop }
     2a5:	e806dba7ff 	{ ae_lp16x2f.xu	aep2, a7, a15; ae_mulp24s.hh	aeq1, aep1, aep0 }
     2aa:	ea079ab2ff 	{ ae_lp16x2f.c	aep3, a2, a15; ae_mulp24s.ll	aeq0, aep1, aep0 }
     2af:	e44e5bc7ff 	{ ae_lp16x2f.xu	aep4, a7, a15; ae_mulap24s.hh	aeq1, aep3, aep2 }
     2b4:	e64f1ad2ff 	{ ae_lp16x2f.c	aep5, a2, a15; ae_mulap24s.ll	aeq0, aep3, aep2 }
     2b9:	880c           	movi.n	a8, 8
     2bb:	e4965be7ff 	{ ae_lp16x2f.xu	aep6, a7, a15; ae_mulap24s.hh	aeq1, aep5, aep4 }
     2c0:	e6971af2ff 	{ ae_lp16x2f.c	aep7, a2, a15; ae_mulap24s.ll	aeq0, aep5, aep4 }
     2c5:	e4de73016e 	{ l32i	a6, a1, 192; ae_mulap24s.hh	aeq1, aep7, aep6 }
     2ca:	880b           	addi.n	a8, a8, -1
     2cc:	4597f4        	ae_lp16x2f.xu	aep1, a7, a15
     2cf:	e6df1a825f 	{ ae_lp16x2f.c	aep0, a2, a5; ae_mulap24s.ll	aeq0, aep7, aep6 }
     2d4:	0d3d           	mov.n	a3, a13
     2d6:	0f4d           	mov.n	a4, a15
     2d8:	3d8876        	loop	a8, 319 <sbc_analyze_audio+0x1c5>
     2db:	e4225ba73f 	{ ae_lp16x2f.xu	aep2, a7, a3; ae_mulap24s.hh	aeq1, aep0, aep1 }
     2e0:	e6231a924f 	{ ae_lp16x2f.c	aep1, a2, a4; ae_mulap24s.ll	aeq0, aep0, aep1 }
     2e5:	3590f4        	ae_sraiq56	aeq2, aeq1, 3
     2e8:	3540f4        	ae_sraiq56	aeq1, aeq0, 3
     2eb:	626614        	ae_sq32f.iu	aeq2, a6, 4
     2ee:	ea479a824f 	{ ae_lp16x2f.c	aep0, a2, a4; ae_mulp24s.ll	aeq0, aep1, aep2 }
     2f3:	625614        	ae_sq32f.iu	aeq1, a6, 4
     2f6:	e846dba74f 	{ ae_lp16x2f.xu	aep2, a7, a4; ae_mulp24s.hh	aeq1, aep1, aep2 }
     2fb:	e4425b974f 	{ ae_lp16x2f.xu	aep1, a7, a4; ae_mulap24s.hh	aeq1, aep0, aep2 }
     300:	e6431aa24f 	{ ae_lp16x2f.c	aep2, a2, a4; ae_mulap24s.ll	aeq0, aep0, aep2 }
     305:	e42a5b874f 	{ ae_lp16x2f.xu	aep0, a7, a4; ae_mulap24s.hh	aeq1, aep2, aep1 }
     30a:	e62b1aa24f 	{ ae_lp16x2f.c	aep2, a2, a4; ae_mulap24s.ll	aeq0, aep2, aep1 }
     30f:	e40a5b974f 	{ ae_lp16x2f.xu	aep1, a7, a4; ae_mulap24s.hh	aeq1, aep2, aep0 }
     314:	e60b1a825f 	{ ae_lp16x2f.c	aep0, a2, a5; ae_mulap24s.ll	aeq0, aep2, aep0 }

00000319 <sbc_analyze_audio+0x1c5>:
     319:	e42272e18e 	{ l32i	a8, a1, 184; ae_mulap24s.hh	aeq1, aep0, aep1 }
     31e:	e62313f44f 	{ or	a15, a4, a4; ae_mulap24s.ll	aeq0, aep0, aep1 }
     323:	3550f4        	ae_sraiq56	aeq1, aeq1, 3
     326:	3500f4        	ae_sraiq56	aeq0, aeq0, 3
     329:	625614        	ae_sq32f.iu	aeq1, a6, 4
     32c:	624614        	ae_sq32f.iu	aeq0, a6, 4
     32f:	60c804        	ae_lq32f.i	aeq3, a8, 0
     332:	2c2182        	l32i	a8, a1, 176
     335:	2f2162        	l32i	a6, a1, 188
     338:	01d142        	addmi	a4, a1, 0x100
     33b:	608804        	ae_lq32f.i	aeq2, a8, 0
     33e:	2b2182        	l32i	a8, a1, 172
     341:	600604        	ae_lq32f.i	aeq0, a6, 0
     344:	78c172        	addi	a7, a1, 120
     347:	01d162        	addmi	a6, a1, 0x100
     34a:	03dd           	mov.n	a13, a3
     34c:	f0c432        	addi	a3, a4, -16
     34f:	6307e4        	ae_sq56s.i	aeq0, a7, -16
     352:	d8c642        	addi	a4, a6, -40
     355:	78c162        	addi	a6, a1, 120
     358:	2d2172        	l32i	a7, a1, 180
     35b:	6336d4        	ae_sq56s.i	aeq3, a6, -24
     35e:	60c804        	ae_lq32f.i	aeq3, a8, 0
     361:	2a2182        	l32i	a8, a1, 168
     364:	604704        	ae_lq32f.i	aeq1, a7, 0
     367:	6316a4        	ae_sq56s.i	aeq1, a6, -48
     36a:	604804        	ae_lq32f.i	aeq1, a8, 0
     36d:	292182        	l32i	a8, a1, 164
     370:	01d122        	addmi	a2, a1, 0x100
     373:	632694        	ae_sq56s.i	aeq2, a6, -56
     376:	78c172        	addi	a7, a1, 120
     379:	608804        	ae_lq32f.i	aeq2, a8, 0
     37c:	d0c222        	addi	a2, a2, -48
     37f:	01d182        	addmi	a8, a1, 0x100
     382:	633164        	ae_sq56s.i	aeq3, a1, 48
     385:	60c204        	ae_lq32f.i	aeq3, a2, 0
     388:	01d162        	addmi	a6, a1, 0x100
     38b:	631154        	ae_sq56s.i	aeq1, a1, 40
     38e:	604304        	ae_lq32f.i	aeq1, a3, 0
     391:	632124        	ae_sq56s.i	aeq2, a1, 16
     394:	633704        	ae_sq56s.i	aeq3, a7, 0
     397:	608404        	ae_lq32f.i	aeq2, a4, 0
     39a:	60c8a4        	ae_lq32f.i	aeq3, a8, -24
     39d:	6317f4        	ae_sq56s.i	aeq1, a7, -8
     3a0:	6327c4        	ae_sq56s.i	aeq2, a7, -32
     3a3:	6337b4        	ae_sq56s.i	aeq3, a7, -40
     3a6:	282172        	l32i	a7, a1, 160
     3a9:	608824        	ae_lq32f.i	aeq2, a8, 8
     3ac:	60c6e4        	ae_lq32f.i	aeq3, a6, -8
     3af:	252122        	l32i	a2, a1, 148
     3b2:	262142        	l32i	a4, a1, 152
     3b5:	604684        	ae_lq32f.i	aeq1, a6, -32
     3b8:	480c           	movi.n	a8, 4
     3ba:	631174        	ae_sq56s.i	aeq1, a1, 56
     3bd:	632144        	ae_sq56s.i	aeq2, a1, 32
     3c0:	633134        	ae_sq56s.i	aeq3, a1, 24
     3c3:	600704        	ae_lq32f.i	aeq0, a7, 0
     3c6:	203bb0        	or	a3, a11, a11
     3c9:	958876        	loop	a8, 462 <sbc_analyze_audio+0x30e>
     3cc:	449414        	ae_lp16x2f.iu	aep1, a4, 4
     3cf:	78c182        	addi	a8, a1, 120
     3d2:	614804        	ae_lq56.i	aeq1, a8, 0
     3d5:	6188f4        	ae_lq56.i	aeq2, a8, -8
     3d8:	21276d821f 	{ ae_lp16x2f.iu	aep0, a2, 4; ae_mulzaaq32sp16s.hh	aeq3, aeq1, aep1, aeq2, aep1 }
     3dd:	21033da8ef 	{ ae_lq56.i	aeq1, a8, -16; ae_mulzaaq32sp16s.hh	aeq2, aeq1, aep0, aeq2, aep0 }
     3e2:	039954        	ae_mulaq32sp16s.l	aeq3, aeq1, aep1
     3e5:	f5e3bda8df 	{ ae_lq56.i	aeq1, a8, -24; ae_mulaq32sp16s.l	aeq2, aeq1, aep0 }
     3ea:	f5e7ed941f 	{ ae_lp16x2f.iu	aep1, a4, 4; ae_mulaq32sp16s.l	aeq3, aeq1, aep1 }
     3ef:	f5e3bda8cf 	{ ae_lq56.i	aeq1, a8, -32; ae_mulaq32sp16s.l	aeq2, aeq1, aep0 }
     3f4:	f567ed821f 	{ ae_lp16x2f.iu	aep0, a2, 4; ae_mulaq32sp16s.h	aeq3, aeq1, aep1 }
     3f9:	f563bda8bf 	{ ae_lq56.i	aeq1, a8, -40; ae_mulaq32sp16s.h	aeq2, aeq1, aep0 }
     3fe:	039944        	ae_mulaq32sp16s.h	aeq3, aeq1, aep1
     401:	f563bda8af 	{ ae_lq56.i	aeq1, a8, -48; ae_mulaq32sp16s.h	aeq2, aeq1, aep0 }
     406:	039954        	ae_mulaq32sp16s.l	aeq3, aeq1, aep1
     409:	f5e3bda89f 	{ ae_lq56.i	aeq1, a8, -56; ae_mulaq32sp16s.l	aeq2, aeq1, aep0 }
     40e:	f5e7ed941f 	{ ae_lp16x2f.iu	aep1, a4, 4; ae_mulaq32sp16s.l	aeq3, aeq1, aep1 }
     413:	f5e3bda17f 	{ ae_lq56.i	aeq1, a1, 56; ae_mulaq32sp16s.l	aeq2, aeq1, aep0 }
     418:	f567ed821f 	{ ae_lp16x2f.iu	aep0, a2, 4; ae_mulaq32sp16s.h	aeq3, aeq1, aep1 }
     41d:	f563bda16f 	{ ae_lq56.i	aeq1, a1, 48; ae_mulaq32sp16s.h	aeq2, aeq1, aep0 }
     422:	039954        	ae_mulaq32sp16s.l	aeq3, aeq1, aep1
     425:	f5e3bda15f 	{ ae_lq56.i	aeq1, a1, 40; ae_mulaq32sp16s.l	aeq2, aeq1, aep0 }
     42a:	f9e5ed941f 	{ ae_lp16x2f.iu	aep1, a4, 4; ae_mulsq32sp16s.l	aeq3, aeq1, aep1 }
     42f:	f9e1bda13f 	{ ae_lq56.i	aeq1, a1, 24; ae_mulsq32sp16s.l	aeq2, aeq1, aep0 }
     434:	f567ed821f 	{ ae_lp16x2f.iu	aep0, a2, 4; ae_mulaq32sp16s.h	aeq3, aeq1, aep1 }
     439:	f563bda14f 	{ ae_lq56.i	aeq1, a1, 32; ae_mulaq32sp16s.h	aeq2, aeq1, aep0 }
     43e:	039d44        	ae_mulsq32sp16s.h	aeq3, aeq1, aep1
     441:	f961bda12f 	{ ae_lq56.i	aeq1, a1, 16; ae_mulsq32sp16s.h	aeq2, aeq1, aep0 }
     446:	039954        	ae_mulaq32sp16s.l	aeq3, aeq1, aep1
     449:	038154        	ae_mulaq32sp16s.l	aeq2, aeq1, aep0
     44c:	039d14        	ae_mulsq32sp16s.l	aeq3, aeq0, aep1
     44f:	038514        	ae_mulsq32sp16s.l	aeq2, aeq0, aep0
     452:	3570d4        	ae_slliq56	aeq1, aeq3, 3
     455:	fe4c7aa07f 	{ ae_slliq56	aeq1, aeq2, 3; ae_roundsq32sym	aeq2, aeq1 }
     45a:	fd4c79e31f 	{ ae_sq32f.iu	aeq2, a3, 4; ae_roundsq32sym	aeq1, aeq1 }
     45f:	625314        	ae_sq32f.iu	aeq1, a3, 4
     462:	202122        	l32i	a2, a1, 128
     465:	242182        	l32i	a8, a1, 144
     468:	aa1b           	addi.n	a10, a10, 1
     46a:	0238           	l32i.n	a3, a2, 0
     46c:	ee8a           	add.n	a14, a14, a8
     46e:	40cbb2        	addi	a11, a11, 64
     471:	02aa37        	bge	a10, a3, 477 <sbc_analyze_audio+0x323>
     474:	ff7106        	j	23c <sbc_analyze_audio+0xe8>
     477:	202122        	l32i	a2, a1, 128
     47a:	2321e2        	l32i	a14, a1, 140
     47d:	2221b2        	l32i	a11, a1, 136
     480:	1228           	l32i.n	a2, a2, 4
     482:	212162        	l32i	a6, a1, 132
     485:	ff5c86        	j	1fb <sbc_analyze_audio+0xa7>

00000488 <sbc_analyze_audio+0x334>:
     488:	f01d           	retw.n

0000048a <sbc_analyze_audio+0x336>:
	...

0000048c <sbc_pack_frame>:
     48c:	01a136        	entry	a1, 208
     48f:	02e8           	l32i.n	a14, a2, 0
     491:	040c           	movi.n	a4, 0
     493:	12f8           	l32i.n	a15, a2, 4
     495:	3129           	s32i.n	a2, a1, 12
     497:	51f9           	s32i.n	a15, a1, 20
     499:	032644        	wur.ae_bitptr	a4
     49c:	9139           	s32i.n	a3, a1, 36
     49e:	0be307        	bbsi	a3, 0, 4ad <sbc_pack_frame+0x21>
     4a1:	fec342        	addi	a4, a3, -2
     4a4:	9ca022        	movi	a2, 156
     4a7:	118424        	ae_sbi	a4, a2, 8
     4aa:	0001c6        	j	4b5 <sbc_pack_frame+0x29>

000004ad <sbc_pack_frame+0x21>:
     4ad:	9ca022        	movi	a2, 156
     4b0:	430b           	addi.n	a4, a3, -1
     4b2:	004322        	s8i	a2, a3, 0
     4b5:	3138           	l32i.n	a3, a1, 12
     4b7:	51f8           	l32i.n	a15, a1, 20
     4b9:	060c           	movi.n	a6, 0
     4bb:	04d322        	addmi	a2, a3, 0x400
     4be:	6228           	l32i.n	a2, a2, 24
     4c0:	61e9           	s32i.n	a14, a1, 24
     4c2:	118424        	ae_sbi	a4, a2, 8
     4c5:	5328           	l32i.n	a2, a3, 20
     4c7:	13a482        	movi	a8, 0x413
     4ca:	118424        	ae_sbi	a4, a2, 8
     4cd:	118464        	ae_sbi	a4, a6, 8
     4d0:	4149           	s32i.n	a4, a1, 16
     4d2:	721fa6        	blti	a15, 1, 548 <sbc_pack_frame+0xbc>
     4d5:	5198           	l32i.n	a9, a1, 20
     4d7:	3158           	l32i.n	a5, a1, 12
     4d9:	f70c           	movi.n	a7, 15
     4db:	1129b0        	slli	a2, a9, 5
     4de:	b03950        	addx8	a3, a9, a5
     4e1:	225a           	add.n	a2, a2, a5
     4e3:	838a           	add.n	a8, a3, a8
     4e5:	f4c2a2        	addi	a10, a2, -12
     4e8:	000206        	j	4f4 <sbc_pack_frame+0x68>

000004eb <sbc_pack_frame+0x5f>:
     4eb:	e0caa2        	addi	a10, a10, -32
     4ee:	f8c882        	addi	a8, a8, -8
     4f1:	5319a6        	blti	a9, 1, 548 <sbc_pack_frame+0xbc>
     4f4:	3128           	l32i.n	a2, a1, 12
     4f6:	990b           	addi.n	a9, a9, -1
     4f8:	22b8           	l32i.n	a11, a2, 8
     4fa:	ed1ba6        	blti	a11, 1, 4eb <sbc_pack_frame+0x5f>
     4fd:	a0cba0        	addx4	a12, a11, a10
     500:	000286        	j	50e <sbc_pack_frame+0x82>

00000503 <sbc_pack_frame+0x77>:
     503:	020c           	movi.n	a2, 0
     505:	fcccc2        	addi	a12, a12, -4
     508:	004d22        	s8i	a2, a13, 0
     50b:	dc1ba6        	blti	a11, 1, 4eb <sbc_pack_frame+0x5f>
     50e:	d8ba           	add.n	a13, a8, a11
     510:	bb0b           	addi.n	a11, a11, -1
     512:	ed1ea6        	blti	a14, 1, 503 <sbc_pack_frame+0x77>
     515:	0c28           	l32i.n	a2, a12, 0
     517:	ee0b           	addi.n	a14, a14, -1
     519:	050c           	movi.n	a5, 0
     51b:	40cc42        	addi	a4, a12, 64
     51e:	603120        	abs	a3, a2
     521:	0a9e76        	loopnez	a14, 52f <sbc_pack_frame+0xa3>
     524:	0428           	l32i.n	a2, a4, 0
     526:	735530        	maxu	a5, a5, a3
     529:	40c442        	addi	a4, a4, 64
     52c:	603120        	abs	a3, a2

0000052f <sbc_pack_frame+0xa3>:
     52f:	61e8           	l32i.n	a14, a1, 24
     531:	735530        	maxu	a5, a5, a3
     534:	020c           	movi.n	a2, 0
     536:	cb25b6        	bltui	a5, 2, 505 <sbc_pack_frame+0x79>
     539:	250b           	addi.n	a2, a5, -1
     53b:	40f220        	nsau	a2, a2
     53e:	c02720        	sub	a2, a7, a2
     541:	532260        	max	a2, a2, a6
     544:	ffef46        	j	505 <sbc_pack_frame+0x79>

00000547 <sbc_pack_frame+0xbb>:
	...

00000548 <sbc_pack_frame+0xbc>:
     548:	3128           	l32i.n	a2, a1, 12
     54a:	3148           	l32i.n	a4, a1, 12
     54c:	030c           	movi.n	a3, 0
     54e:	3228           	l32i.n	a2, a2, 12
     550:	30c152        	addi	a5, a1, 48
     553:	1aa462        	movi	a6, 0x41a
     556:	023226        	beqi	a2, 3, 55c <sbc_pack_frame+0xd0>
     559:	005bc6        	j	6cc <sbc_pack_frame+0x240>
     55c:	7139           	s32i.n	a3, a1, 28
     55e:	2428           	l32i.n	a2, a4, 8
     560:	3188           	l32i.n	a8, a1, 12
     562:	1b0c           	movi.n	a11, 1
     564:	0222e6        	bgei	a2, 2, 56a <sbc_pack_frame+0xde>
     567:	005606        	j	6c3 <sbc_pack_frame+0x237>
     56a:	9c0c           	movi.n	a12, 9
     56c:	a159           	s32i.n	a5, a1, 40
     56e:	113b20        	slli	a3, a11, 14
     571:	2cc142        	addi	a4, a1, 44
     574:	0d0c           	movi.n	a13, 0
     576:	f86a           	add.n	a15, a8, a6
     578:	a05280        	addx4	a5, a2, a8
     57b:	71d9           	s32i.n	a13, a1, 28
     57d:	8149           	s32i.n	a4, a1, 32
     57f:	b20b           	addi.n	a11, a2, -1
     581:	074c           	movi.n	a7, 64
     583:	290c           	movi.n	a9, 2
     585:	c0cc20        	sub	a12, a12, a2
     588:	300334        	ae_cvtp24a16x2.ll	aep0, a3, a3
     58b:	10c5d2        	addi	a13, a5, 16
     58e:	b1f9           	s32i.n	a15, a1, 44
     590:	000b46        	j	5c1 <sbc_pack_frame+0x135>

00000593 <sbc_pack_frame+0x107>:
     593:	199476        	loopnez	a4, 5b0 <sbc_pack_frame+0x124>
     596:	0348           	l32i.n	a4, a3, 0
     598:	0249           	s32i.n	a4, a2, 0
     59a:	3358           	l32i.n	a5, a3, 12
     59c:	2368           	l32i.n	a6, a3, 8
     59e:	40c242        	addi	a4, a2, 64
     5a1:	8459           	s32i.n	a5, a4, 32
     5a3:	0469           	s32i.n	a6, a4, 0
     5a5:	1358           	l32i.n	a5, a3, 4
     5a7:	086252        	s32i	a5, a2, 32
     5aa:	10c332        	addi	a3, a3, 16
     5ad:	40c422        	addi	a2, a4, 64

000005b0 <sbc_pack_frame+0x124>:
     5b0:	61e8           	l32i.n	a14, a1, 24
     5b2:	ffcbb2        	addi	a11, a11, -1
     5b5:	01ccc2        	addi	a12, a12, 1
     5b8:	fccdd2        	addi	a13, a13, -4
     5bb:	021be6        	bgei	a11, 1, 5c1 <sbc_pack_frame+0x135>
     5be:	004046        	j	6c3 <sbc_pack_frame+0x237>

000005c1 <sbc_pack_frame+0x135>:
     5c1:	050c           	movi.n	a5, 0
     5c3:	060c           	movi.n	a6, 0
     5c5:	581ea6        	blti	a14, 1, 621 <sbc_pack_frame+0x195>
     5c8:	e0cd32        	addi	a3, a13, -32
     5cb:	603374        	ae_lq32f.xu	aeq0, a3, a7
     5ce:	604384        	ae_lq32f.i	aeq1, a3, -32
     5d1:	110130612e 	{ l32i	a2, a1, 24; ae_mulzaafq32sp16s.ll	aeq2, aeq1, aep0, aeq0, aep0 }
     5d6:	8148           	l32i.n	a4, a1, 32
     5d8:	41017f28ef 	{ ae_trunca32q48	a8, aeq2; ae_mulzasfq32sp16s.ll	aeq3, aeq1, aep0, aeq0, aep0 }
     5dd:	e20b           	addi.n	a14, a2, -1
     5df:	060c           	movi.n	a6, 0
     5e1:	050c           	movi.n	a5, 0
     5e3:	072d           	mov.n	a2, a7
     5e5:	219e76        	loopnez	a14, 60a <sbc_pack_frame+0x17e>
     5e8:	603324        	ae_lq32f.xu	aeq0, a3, a2
     5eb:	608180        	abs	a8, a8
     5ee:	604384        	ae_lq32f.i	aeq1, a3, -32
     5f1:	36b704        	ae_trunca32q48	a7, aeq3
     5f4:	626414        	ae_sq32f.iu	aeq2, a4, 4
     5f7:	735580        	maxu	a5, a5, a8
     5fa:	110139f41f 	{ ae_sq32f.iu	aeq3, a4, 4; ae_mulzaafq32sp16s.ll	aeq2, aeq1, aep0, aeq0, aep0 }
     5ff:	607170        	abs	a7, a7
     602:	41017f28ef 	{ ae_trunca32q48	a8, aeq2; ae_mulzasfq32sp16s.ll	aeq3, aeq1, aep0, aeq0, aep0 }
     607:	736670        	maxu	a6, a6, a7

0000060a <sbc_pack_frame+0x17e>:
     60a:	36bf04        	ae_trunca32q48	a15, aeq3
     60d:	626414        	ae_sq32f.iu	aeq2, a4, 4
     610:	027d           	mov.n	a7, a2
     612:	603180        	abs	a3, a8
     615:	6021f0        	abs	a2, a15
     618:	735530        	maxu	a5, a5, a3
     61b:	736620        	maxu	a6, a6, a2
     61e:	627414        	ae_sq32f.iu	aeq3, a4, 4

00000621 <sbc_pack_frame+0x195>:
     621:	3128           	l32i.n	a2, a1, 12
     623:	e31c           	movi.n	a3, 30
     625:	b148           	l32i.n	a4, a1, 44
     627:	5228           	l32i.n	a2, a2, 20
     629:	850b           	addi.n	a8, a5, -1
     62b:	f60b           	addi.n	a15, a6, -1
     62d:	02a327        	bge	a3, a2, 633 <sbc_pack_frame+0x1a7>
     630:	ffdf06        	j	5b0 <sbc_pack_frame+0x124>
     633:	24ba           	add.n	a2, a4, a11
     635:	413150        	srli	a3, a5, 1
     638:	010252        	l8ui	a5, a2, 1
     63b:	40f880        	nsau	a8, a8
     63e:	40fff0        	nsau	a15, a15
     641:	0902a2        	l8ui	a10, a2, 9
     644:	fe0c           	movi.n	a14, 15
     646:	414160        	srli	a4, a6, 1
     649:	c06e80        	sub	a6, a14, a8
     64c:	c08ef0        	sub	a8, a14, a15
     64f:	0f0c           	movi.n	a15, 0
     651:	5366f0        	max	a6, a6, a15
     654:	401500        	ssl	a5
     657:	5388f0        	max	a8, a8, a15
     65a:	933630        	movnez	a3, a6, a3
     65d:	a16900        	sll	a6, a9
     660:	401a00        	ssl	a10
     663:	934840        	movnez	a4, a8, a4
     666:	a18900        	sll	a8, a9
     669:	401300        	ssl	a3
     66c:	a1f900        	sll	a15, a9
     66f:	401400        	ssl	a4
     672:	a1e900        	sll	a14, a9
     675:	f37a16        	beqz	a10, 5b0 <sbc_pack_frame+0x124>
     678:	f34516        	beqz	a5, 5b0 <sbc_pack_frame+0x124>
     67b:	586a           	add.n	a5, a8, a6
     67d:	fefa           	add.n	a15, a14, a15
     67f:	022f57        	blt	a15, a5, 685 <sbc_pack_frame+0x1f9>
     682:	ffca86        	j	5b0 <sbc_pack_frame+0x124>
     685:	71e8           	l32i.n	a14, a1, 28
     687:	401c00        	ssl	a12
     68a:	1a0c           	movi.n	a10, 1
     68c:	61f8           	l32i.n	a15, a1, 24
     68e:	014232        	s8i	a3, a2, 1
     691:	094242        	s8i	a4, a2, 9
     694:	a12a00        	sll	a2, a10
     697:	2032e0        	or	a3, a2, a14
     69a:	7139           	s32i.n	a3, a1, 28
     69c:	021fe6        	bgei	a15, 1, 6a2 <sbc_pack_frame+0x216>
     69f:	ffc346        	j	5b0 <sbc_pack_frame+0x124>
     6a2:	6158           	l32i.n	a5, a1, 24
     6a4:	a138           	l32i.n	a3, a1, 40
     6a6:	0d2d           	mov.n	a2, a13
     6a8:	414150        	srli	a4, a5, 1
     6ab:	0c6507        	bbci	a5, 0, 6bb <sbc_pack_frame+0x22f>
     6ae:	0358           	l32i.n	a5, a3, 0
     6b0:	13f8           	l32i.n	a15, a3, 4
     6b2:	0259           	s32i.n	a5, a2, 0
     6b4:	82f9           	s32i.n	a15, a2, 32
     6b6:	338b           	addi.n	a3, a3, 8
     6b8:	40c222        	addi	a2, a2, 64
     6bb:	ed4456        	bnez	a4, 593 <sbc_pack_frame+0x107>
     6be:	ffbb86        	j	5b0 <sbc_pack_frame+0x124>

000006c1 <sbc_pack_frame+0x235>:
	...

000006c3 <sbc_pack_frame+0x237>:
     6c3:	4128           	l32i.n	a2, a1, 16
     6c5:	7138           	l32i.n	a3, a1, 28
     6c7:	118234        	ae_sbi	a2, a3, 8
     6ca:	4129           	s32i.n	a2, a1, 16
     6cc:	5128           	l32i.n	a2, a1, 20
     6ce:	3138           	l32i.n	a3, a1, 12
     6d0:	5158           	l32i.n	a5, a1, 20
     6d2:	2312a6        	blti	a2, 1, 6f9 <sbc_pack_frame+0x26d>
     6d5:	1ca422        	movi	a2, 0x41c
     6d8:	632a           	add.n	a6, a3, a2
     6da:	3128           	l32i.n	a2, a1, 12
     6dc:	4148           	l32i.n	a4, a1, 16
     6de:	063d           	mov.n	a3, a6
     6e0:	2228           	l32i.n	a2, a2, 8
     6e2:	0c12a6        	blti	a2, 1, 6f2 <sbc_pack_frame+0x266>
     6e5:	078276        	loop	a2, 6f0 <sbc_pack_frame+0x264>
     6e8:	000322        	l8ui	a2, a3, 0
     6eb:	331b           	addi.n	a3, a3, 1
     6ed:	114424        	ae_sbi	a4, a2, 4

000006f0 <sbc_pack_frame+0x264>:
     6f0:	4149           	s32i.n	a4, a1, 16

000006f2 <sbc_pack_frame+0x266>:
     6f2:	550b           	addi.n	a5, a5, -1
     6f4:	668b           	addi.n	a6, a6, 8
     6f6:	fe0556        	bnez	a5, 6da <sbc_pack_frame+0x24e>
     6f9:	3128           	l32i.n	a2, a1, 12
     6fb:	9158           	l32i.n	a5, a1, 36
     6fd:	081c           	movi.n	a8, 16
     6ff:	3238           	l32i.n	a3, a2, 12
     701:	2248           	l32i.n	a4, a2, 8
     703:	1268           	l32i.n	a6, a2, 4
     705:	fdc332        	addi	a3, a3, -3
     708:	2ca472        	movi	a7, 0x42c
     70b:	826460        	mull	a6, a4, a6
     70e:	10c442        	addi	a4, a4, 16
     711:	934830        	movnez	a4, a8, a3
     714:	327a           	add.n	a3, a2, a7
     716:	a0c640        	addx4	a12, a6, a4
     719:	fe4b41        	l32r	a4, 48 (86c <sbc_crc8_modified>)
     71c:	b51b           	addi.n	a11, a5, 1
     71e:	03ad           	mov.n	a10, a3
     720:	81b9           	s32i.n	a11, a1, 32
     722:	0004e0        	callx8	a4
     725:	30c142        	addi	a4, a1, 48
     728:	fe4971        	l32r	a7, 4c (8e8 <sbc_calculate_bits_modified>)
     72b:	0345a2        	s8i	a10, a5, 3
     72e:	02ad           	mov.n	a10, a2
     730:	04bd           	mov.n	a11, a4
     732:	0007e0        	callx8	a7
     735:	6168           	l32i.n	a6, a1, 24
     737:	3128           	l32i.n	a2, a1, 12
     739:	1ca482        	movi	a8, 0x41c
     73c:	7116a6        	blti	a6, 1, 7b1 <sbc_pack_frame+0x325>
     73f:	270c           	movi.n	a7, 2
     741:	360734        	ae_cvtq48a32s	aeq0, a7
     744:	14c272        	addi	a7, a2, 20
     747:	828a           	add.n	a8, a2, a8
     749:	0001c6        	j	754 <sbc_pack_frame+0x2c8>

0000074c <sbc_pack_frame+0x2c0>:
     74c:	660b           	addi.n	a6, a6, -1
     74e:	40c772        	addi	a7, a7, 64
     751:	05c616        	beqz	a6, 7b1 <sbc_pack_frame+0x325>
     754:	5128           	l32i.n	a2, a1, 20
     756:	51a8           	l32i.n	a10, a1, 20
     758:	079d           	mov.n	a9, a7
     75a:	ee12a6        	blti	a2, 1, 74c <sbc_pack_frame+0x2c0>
     75d:	08bd           	mov.n	a11, a8
     75f:	04cd           	mov.n	a12, a4
     761:	000f06        	j	7a1 <sbc_pack_frame+0x315>

00000764 <sbc_pack_frame+0x2d8>:
	...

00000765 <sbc_pack_frame+0x2d9>:
     765:	308e76        	loop	a14, 799 <sbc_pack_frame+0x30d>
     768:	0ce8           	l32i.n	a14, a12, 0
     76a:	605d14        	ae_lq32f.iu	aeq1, a13, 4
     76d:	241ea6        	blti	a14, 1, 795 <sbc_pack_frame+0x309>
     770:	000bf2        	l8ui	a15, a11, 0
     773:	0336e4        	wur.ae_bitsused	a14
     776:	10cf52        	addi	a5, a15, 16
     779:	348594        	ae_sllaq56	aeq2, aeq0, a5
     77c:	f9ea012ffe 	{ addi	a15, a15, 18; ae_addq56	aeq1, aeq1, aeq2 }
     781:	c05ef0        	sub	a5, a14, a15
     784:	fc24fe958f 	{ ae_slaasq56s	aeq2, aeq1, a5; nop }
     789:	345fb4        	ae_sraaq56	aeq1, aeq1, a15
     78c:	016dc4        	ae_subq56	aeq1, aeq2, aeq1
     78f:	369f04        	ae_trunca32q48	a15, aeq1
     792:	1c02f4        	ae_sb	a2, a15

00000795 <sbc_pack_frame+0x309>:
     795:	cc4b           	addi.n	a12, a12, 4
     797:	bb1b           	addi.n	a11, a11, 1

00000799 <sbc_pack_frame+0x30d>:
     799:	20c992        	addi	a9, a9, 32
     79c:	4129           	s32i.n	a2, a1, 16
     79e:	aa1aa6        	blti	a10, 1, 74c <sbc_pack_frame+0x2c0>

000007a1 <sbc_pack_frame+0x315>:
     7a1:	3128           	l32i.n	a2, a1, 12
     7a3:	aa0b           	addi.n	a10, a10, -1
     7a5:	09dd           	mov.n	a13, a9
     7a7:	22e8           	l32i.n	a14, a2, 8
     7a9:	4128           	l32i.n	a2, a1, 16
     7ab:	b61ee6        	bgei	a14, 1, 765 <sbc_pack_frame+0x2d9>
     7ae:	fff9c6        	j	799 <sbc_pack_frame+0x30d>

000007b1 <sbc_pack_frame+0x325>:
     7b1:	4128           	l32i.n	a2, a1, 16
     7b3:	0f1c           	movi.n	a15, 16
     7b5:	81b8           	l32i.n	a11, a1, 32
     7b7:	180234        	ae_sbf	a2
     7ba:	3128           	l32i.n	a2, a1, 12
     7bc:	03ad           	mov.n	a10, a3
     7be:	3278           	l32i.n	a7, a2, 12
     7c0:	2248           	l32i.n	a4, a2, 8
     7c2:	1258           	l32i.n	a5, a2, 4
     7c4:	fdc772        	addi	a7, a7, -3
     7c7:	fe2021        	l32r	a2, 48 (86c <sbc_crc8_modified>)
     7ca:	825450        	mull	a5, a4, a5
     7cd:	10c442        	addi	a4, a4, 16
     7d0:	934f70        	movnez	a4, a15, a7
     7d3:	a0c540        	addx4	a12, a5, a4
     7d6:	0002e0        	callx8	a2
     7d9:	9128           	l32i.n	a2, a1, 36
     7db:	0342a2        	s8i	a10, a2, 3
     7de:	f01d           	retw.n

000007e0 <generate_crc_table>:
     7e0:	004136        	entry	a1, 32
     7e3:	00a182        	movi	a8, 0x100
     7e6:	070c           	movi.n	a7, 0
     7e8:	836c           	movi.n	a3, -24
     7ea:	74a042        	movi	a4, 116
     7ed:	a53c           	movi.n	a5, 58
     7ef:	d61c           	movi.n	a6, 29
     7f1:	728876        	loop	a8, 867 <generate_crc_table+0x87>
     7f4:	238700        	sext	a8, a7, 7
     7f7:	218780        	srai	a8, a8, 7
     7fa:	109830        	and	a9, a8, a3
     7fd:	308940        	xor	a8, a9, a4
     800:	04a670        	extui	a10, a7, 6, 1
     803:	8389a0        	moveqz	a8, a9, a10
     806:	309850        	xor	a9, a8, a5
     809:	04a570        	extui	a10, a7, 5, 1
     80c:	8398a0        	moveqz	a9, a8, a10
     80f:	308960        	xor	a8, a9, a6
     812:	04a470        	extui	a10, a7, 4, 1
     815:	8389a0        	moveqz	a8, a9, a10
     818:	1197c0        	slli	a9, a7, 4
     81b:	30a890        	xor	a10, a8, a9
     81e:	1188f0        	slli	a8, a8, 1
     821:	309860        	xor	a9, a8, a6
     824:	23aa00        	sext	a10, a10, 7
     827:	b398a0        	movgez	a9, a8, a10
     82a:	1189f0        	slli	a8, a9, 1
     82d:	11a7b0        	slli	a10, a7, 5
     830:	30a9a0        	xor	a10, a9, a10
     833:	309860        	xor	a9, a8, a6
     836:	23aa00        	sext	a10, a10, 7
     839:	b398a0        	movgez	a9, a8, a10
     83c:	11a9f0        	slli	a10, a9, 1
     83f:	308a60        	xor	a8, a10, a6
     842:	11b7a0        	slli	a11, a7, 6
     845:	3099b0        	xor	a9, a9, a11
     848:	239900        	sext	a9, a9, 7
     84b:	b38a90        	movgez	a8, a10, a9
     84e:	1198f0        	slli	a9, a8, 1
     851:	11a790        	slli	a10, a7, 7
     854:	30a8a0        	xor	a10, a8, a10
     857:	308960        	xor	a8, a9, a6
     85a:	23aa00        	sext	a10, a10, 7
     85d:	b389a0        	movgez	a8, a9, a10
     860:	927a           	add.n	a9, a2, a7
     862:	004982        	s8i	a8, a9, 0
     865:	771b           	addi.n	a7, a7, 1

00000867 <generate_crc_table+0x87>:
     867:	f01d           	retw.n

00000869 <generate_crc_table+0x89>:
     869:	000000                                        ...

0000086c <sbc_crc8_modified>:
     86c:	004136        	entry	a1, 32
     86f:	000362        	l8ui	a6, a3, 0
     872:	f50c           	movi.n	a5, 15
     874:	010372        	l8ui	a7, a3, 1
     877:	305650        	xor	a5, a6, a5
     87a:	525a           	add.n	a5, a2, a5
     87c:	000552        	l8ui	a5, a5, 0
     87f:	891c           	movi.n	a9, 24
     881:	248040        	extui	a8, a4, 0, 3
     884:	305750        	xor	a5, a7, a5
     887:	525a           	add.n	a5, a2, a5
     889:	000572        	l8ui	a7, a5, 0
     88c:	633b           	addi.n	a6, a3, 3
     88e:	2f2497        	blt	a4, a9, 8c1 <sbc_crc8_modified+0x55>
     891:	050c           	movi.n	a5, 0
     893:	213340        	srai	a3, a4, 3
     896:	f65a           	add.n	a15, a6, a5
     898:	fec342        	addi	a4, a3, -2
     89b:	000f32        	l8ui	a3, a15, 0
     89e:	940b           	addi.n	a9, a4, -1
     8a0:	551b           	addi.n	a5, a5, 1
     8a2:	204770        	or	a4, a7, a7
     8a5:	0e9976        	loopnez	a9, 8b7 <sbc_crc8_modified+0x4b>
     8a8:	765a           	add.n	a7, a6, a5
     8aa:	304340        	xor	a4, a3, a4
     8ad:	000732        	l8ui	a3, a7, 0
     8b0:	424a           	add.n	a4, a2, a4
     8b2:	000442        	l8ui	a4, a4, 0
     8b5:	551b           	addi.n	a5, a5, 1

000008b7 <sbc_crc8_modified+0x4b>:
     8b7:	303340        	xor	a3, a3, a4
     8ba:	223a           	add.n	a2, a2, a3
     8bc:	000272        	l8ui	a7, a2, 0
     8bf:	665a           	add.n	a6, a6, a5

000008c1 <sbc_crc8_modified+0x55>:
     8c1:	c89c           	beqz.n	a8, 8e1 <sbc_crc8_modified+0x75>
     8c3:	000632        	l8ui	a3, a6, 0
     8c6:	d21c           	movi.n	a2, 29
     8c8:	074d           	mov.n	a4, a7
     8ca:	118876        	loop	a8, 8df <sbc_crc8_modified+0x73>
     8cd:	305430        	xor	a5, a4, a3
     8d0:	236500        	sext	a6, a5, 7
     8d3:	1133f0        	slli	a3, a3, 1
     8d6:	1154f0        	slli	a5, a4, 1
     8d9:	304520        	xor	a4, a5, a2
     8dc:	b34560        	movgez	a4, a5, a6

000008df <sbc_crc8_modified+0x73>:
     8df:	047d           	mov.n	a7, a4

000008e1 <sbc_crc8_modified+0x75>:
     8e1:	742070        	extui	a2, a7, 0, 8
     8e4:	f01d           	retw.n

000008e6 <sbc_crc8_modified+0x7a>:
	...

000008e8 <sbc_calculate_bits_modified>:
     8e8:	014136        	entry	a1, 160
     8eb:	04d2f2        	addmi	a15, a2, 0x400
     8ee:	03bd           	mov.n	a11, a3
     8f0:	6f38           	l32i.n	a3, a15, 24
     8f2:	3248           	l32i.n	a4, a2, 12
     8f4:	22c8           	l32i.n	a12, a2, 8
     8f6:	52a8           	l32i.n	a10, a2, 20
     8f8:	4258           	l32i.n	a5, a2, 16
     8fa:	143630        	extui	a3, a3, 6, 2
     8fd:	9159           	s32i.n	a5, a1, 36
     8ff:	61c9           	s32i.n	a12, a1, 24
     901:	41a9           	s32i.n	a10, a1, 16
     903:	0224b6        	bltui	a4, 2, 909 <sbc_calculate_bits_modified+0x21>
     906:	00a386        	j	b98 <sbc_calculate_bits_modified+0x2b0>
     909:	1248           	l32i.n	a4, a2, 4
     90b:	b149           	s32i.n	a4, a1, 44
     90d:	903330        	addx2	a3, a3, a3
     910:	0214e6        	bgei	a4, 1, 916 <sbc_calculate_bits_modified+0x2e>
     913:	01a786        	j	fb5 <sbc_calculate_bits_modified+0x6cd>
     916:	1133e0        	slli	a3, a3, 2
     919:	fdcd61        	l32r	a6, 50 (1620 <sbc_offset_table>)
     91c:	fccc42        	addi	a4, a12, -4
     91f:	934b           	addi.n	a9, a3, 4
     921:	839340        	moveqz	a9, a3, a4
     924:	1ca452        	movi	a5, 0x41c
     927:	070c           	movi.n	a7, 0
     929:	40c182        	addi	a8, a1, 64
     92c:	d69a           	add.n	a13, a6, a9
     92e:	7179           	s32i.n	a7, a1, 28
     930:	5189           	s32i.n	a8, a1, 20
     932:	2f0c           	movi.n	a15, 2
     934:	0e1c           	movi.n	a14, 16
     936:	325a           	add.n	a3, a2, a5
     938:	e70c           	movi.n	a7, 14
     93a:	040c           	movi.n	a4, 0
     93c:	a1d9           	s32i.n	a13, a1, 40
     93e:	000c06        	j	972 <sbc_calculate_bits_modified+0x8a>

00000941 <sbc_calculate_bits_modified+0x59>:
     941:	0b2d           	mov.n	a2, a11
     943:	0f8c76        	loop	a12, 956 <sbc_calculate_bits_modified+0x6e>
     946:	0238           	l32i.n	a3, a2, 0
     948:	7243e0        	salt	a4, a3, a14
     94b:	334a           	add.n	a3, a3, a4
     94d:	dd4a           	add.n	a13, a13, a4
     94f:	0239           	s32i.n	a3, a2, 0
     951:	01ada7        	bge	a13, a10, 956 <sbc_calculate_bits_modified+0x6e>
     954:	224b           	addi.n	a2, a2, 4

00000956 <sbc_calculate_bits_modified+0x6e>:
     956:	e148           	l32i.n	a4, a1, 56
     958:	5128           	l32i.n	a2, a1, 20
     95a:	f138           	l32i.n	a3, a1, 60
     95c:	b1d8           	l32i.n	a13, a1, 44
     95e:	20c222        	addi	a2, a2, 32
     961:	441b           	addi.n	a4, a4, 1
     963:	056122        	s32i	a2, a1, 20
     966:	08c332        	addi	a3, a3, 8
     969:	20cbb2        	addi	a11, a11, 32
     96c:	0294d7        	bne	a4, a13, 972 <sbc_calculate_bits_modified+0x8a>
     96f:	019086        	j	fb5 <sbc_calculate_bits_modified+0x6cd>

00000972 <sbc_calculate_bits_modified+0x8a>:
     972:	9128           	l32i.n	a2, a1, 36
     974:	07dd           	mov.n	a13, a7
     976:	81b9           	s32i.n	a11, a1, 32
     978:	f139           	s32i.n	a3, a1, 60
     97a:	e149           	s32i.n	a4, a1, 56
     97c:	781266        	bnei	a2, 1, 9f8 <sbc_calculate_bits_modified+0x110>
     97f:	021ce6        	bgei	a12, 1, 985 <sbc_calculate_bits_modified+0x9d>
     982:	008346        	j	b93 <sbc_calculate_bits_modified+0x2ab>
     985:	0c2d           	mov.n	a2, a12
     987:	5148           	l32i.n	a4, a1, 20
     989:	2450c0        	extui	a5, a12, 0, 3
     98c:	0c0c           	movi.n	a12, 0
     98e:	412320        	srli	a2, a2, 3
     991:	0b9576        	loopnez	a5, 9a0 <sbc_calculate_bits_modified+0xb8>
     994:	000352        	l8ui	a5, a3, 0
     997:	0459           	s32i.n	a5, a4, 0
     999:	331b           	addi.n	a3, a3, 1
     99b:	444b           	addi.n	a4, a4, 4
     99d:	73cc50        	maxu	a12, a12, a5

000009a0 <sbc_calculate_bits_modified+0xb8>:
     9a0:	094216        	beqz	a2, a38 <sbc_calculate_bits_modified+0x150>
     9a3:	f03d           	nop.n
     9a5:	449276        	loopnez	a2, 9ed <sbc_calculate_bits_modified+0x105>
     9a8:	0003b2        	l8ui	a11, a3, 0
     9ab:	0103a2        	l8ui	a10, a3, 1
     9ae:	020392        	l8ui	a9, a3, 2
     9b1:	030382        	l8ui	a8, a3, 3
     9b4:	040372        	l8ui	a7, a3, 4
     9b7:	050362        	l8ui	a6, a3, 5
     9ba:	060352        	l8ui	a5, a3, 6
     9bd:	070322        	l8ui	a2, a3, 7
     9c0:	338b           	addi.n	a3, a3, 8
     9c2:	04b9           	s32i.n	a11, a4, 0
     9c4:	14a9           	s32i.n	a10, a4, 4
     9c6:	2499           	s32i.n	a9, a4, 8
     9c8:	3489           	s32i.n	a8, a4, 12
     9ca:	4479           	s32i.n	a7, a4, 16
     9cc:	5469           	s32i.n	a6, a4, 20
     9ce:	6459           	s32i.n	a5, a4, 24
     9d0:	7429           	s32i.n	a2, a4, 28
     9d2:	20c442        	addi	a4, a4, 32
     9d5:	73bcb0        	maxu	a11, a12, a11
     9d8:	73aba0        	maxu	a10, a11, a10
     9db:	739a90        	maxu	a9, a10, a9
     9de:	738980        	maxu	a8, a9, a8
     9e1:	737870        	maxu	a7, a8, a7
     9e4:	736760        	maxu	a6, a7, a6
     9e7:	735650        	maxu	a5, a6, a5
     9ea:	73c520        	maxu	a12, a5, a2
     9ed:	81b8           	l32i.n	a11, a1, 32
     9ef:	41a8           	l32i.n	a10, a1, 16
     9f1:	0d7d           	mov.n	a7, a13
     9f3:	001046        	j	a38 <sbc_calculate_bits_modified+0x150>

000009f6 <sbc_calculate_bits_modified+0x10e>:
	...

000009f8 <sbc_calculate_bits_modified+0x110>:
     9f8:	021ce6        	bgei	a12, 1, 9fe <sbc_calculate_bits_modified+0x116>
     9fb:	006506        	j	b93 <sbc_calculate_bits_modified+0x2ab>
     9fe:	a128           	l32i.n	a2, a1, 40
     a00:	5148           	l32i.n	a4, a1, 20
     a02:	0c5d           	mov.n	a5, a12
     a04:	0c0c           	movi.n	a12, 0
     a06:	2e8576        	loop	a5, a38 <sbc_calculate_bits_modified+0x150>
     a09:	000352        	l8ui	a5, a3, 0
     a0c:	7188           	l32i.n	a8, a1, 28
     a0e:	a59c           	beqz.n	a5, a2c <sbc_calculate_bits_modified+0x144>
     a10:	000262        	l8ui	a6, a2, 0
     a13:	236600        	sext	a6, a6, 7
     a16:	565a           	add.n	a5, a6, a5
     a18:	216150        	srai	a6, a5, 1
     a1b:	727850        	salt	a7, a8, a5
     a1e:	538c60        	max	a8, a12, a6
     a21:	935670        	movnez	a5, a6, a7
     a24:	93c870        	movnez	a12, a8, a7
     a27:	0d7d           	mov.n	a7, a13
     a29:	000046        	j	a2e <sbc_calculate_bits_modified+0x146>

00000a2c <sbc_calculate_bits_modified+0x144>:
     a2c:	b57c           	movi.n	a5, -5
     a2e:	0459           	s32i.n	a5, a4, 0
     a30:	444b           	addi.n	a4, a4, 4
     a32:	01c332        	addi	a3, a3, 1
     a35:	01c222        	addi	a2, a2, 1

00000a38 <sbc_calculate_bits_modified+0x150>:
     a38:	6040c0        	neg	a4, a12
     a3b:	61c8           	l32i.n	a12, a1, 24
     a3d:	080c           	movi.n	a8, 0
     a3f:	0d0c           	movi.n	a13, 0

00000a41 <sbc_calculate_bits_modified+0x159>:
     a41:	dd8a           	add.n	a13, a13, a8
     a43:	080c           	movi.n	a8, 0
     a45:	4f1ca6        	blti	a12, 1, a98 <sbc_calculate_bits_modified+0x1b0>
     a48:	5158           	l32i.n	a5, a1, 20
     a4a:	080c           	movi.n	a8, 0
     a4c:	4161c0        	srli	a6, a12, 1
     a4f:	126c07        	bbci	a12, 0, a65 <sbc_calculate_bits_modified+0x17d>
     a52:	0528           	l32i.n	a2, a5, 0
     a54:	554b           	addi.n	a5, a5, 4
     a56:	242a           	add.n	a2, a4, a2
     a58:	fec232        	addi	a3, a2, -2
     a5b:	220b           	addi.n	a2, a2, -1
     a5d:	623370        	saltu	a3, a3, a7
     a60:	833f20        	moveqz	a3, a15, a2
     a63:	838a           	add.n	a8, a3, a8
     a65:	f6ac           	beqz.n	a6, a98 <sbc_calculate_bits_modified+0x1b0>
     a67:	072d           	mov.n	a2, a7
     a69:	0f3d           	mov.n	a3, a15
     a6b:	239676        	loopnez	a6, a92 <sbc_calculate_bits_modified+0x1aa>
     a6e:	0578           	l32i.n	a7, a5, 0
     a70:	1568           	l32i.n	a6, a5, 4
     a72:	558b           	addi.n	a5, a5, 8
     a74:	747a           	add.n	a7, a4, a7
     a76:	a46a           	add.n	a10, a4, a6
     a78:	9a0b           	addi.n	a9, a10, -1
     a7a:	670b           	addi.n	a6, a7, -1
     a7c:	fecaa2        	addi	a10, a10, -2
     a7f:	fec772        	addi	a7, a7, -2
     a82:	627720        	saltu	a7, a7, a2
     a85:	62aa20        	saltu	a10, a10, a2
     a88:	83a390        	moveqz	a10, a3, a9
     a8b:	837360        	moveqz	a7, a3, a6
     a8e:	678a           	add.n	a6, a7, a8
     a90:	8a6a           	add.n	a8, a10, a6

00000a92 <sbc_calculate_bits_modified+0x1aa>:
     a92:	41a8           	l32i.n	a10, a1, 16
     a94:	03fd           	mov.n	a15, a3
     a96:	027d           	mov.n	a7, a2

00000a98 <sbc_calculate_bits_modified+0x1b0>:
     a98:	38da           	add.n	a3, a8, a13
     a9a:	441b           	addi.n	a4, a4, 1
     a9c:	a123a7        	blt	a3, a10, a41 <sbc_calculate_bits_modified+0x159>
     a9f:	021ce6        	bgei	a12, 1, aa5 <sbc_calculate_bits_modified+0x1bd>
     aa2:	ffac06        	j	956 <sbc_calculate_bits_modified+0x6e>
     aa5:	120c           	movi.n	a2, 1
     aa7:	5168           	l32i.n	a6, a1, 20
     aa9:	c083a0        	sub	a8, a3, a10
     aac:	605040        	neg	a5, a4
     aaf:	c02240        	sub	a2, a2, a4
     ab2:	1490c0        	extui	a9, a12, 0, 2
     ab5:	d179           	s32i.n	a7, a1, 52
     ab7:	832580        	moveqz	a2, a5, a8
     aba:	83d380        	moveqz	a13, a3, a8
     abd:	0b7d           	mov.n	a7, a11
     abf:	4182c0        	srli	a8, a12, 2
     ac2:	159976        	loopnez	a9, adb <sbc_calculate_bits_modified+0x1f3>
     ac5:	0638           	l32i.n	a3, a6, 0
     ac7:	7158           	l32i.n	a5, a1, 28
     ac9:	664b           	addi.n	a6, a6, 4
     acb:	c03320        	sub	a3, a3, a2
     ace:	4343e0        	min	a4, a3, a14
     ad1:	7233f0        	salt	a3, a3, a15
     ad4:	934530        	movnez	a4, a5, a3
     ad7:	0749           	s32i.n	a4, a7, 0
     ad9:	774b           	addi.n	a7, a7, 4

00000adb <sbc_calculate_bits_modified+0x1f3>:
     adb:	05e816        	beqz	a8, b3d <sbc_calculate_bits_modified+0x255>
     ade:	7148           	l32i.n	a4, a1, 28
     ae0:	c1d9           	s32i.n	a13, a1, 48
     ae2:	0f3d           	mov.n	a3, a15
     ae4:	0e5d           	mov.n	a5, a14
     ae6:	459876        	loopnez	a8, b2f <sbc_calculate_bits_modified+0x247>
     ae9:	06a8           	l32i.n	a10, a6, 0
     aeb:	1698           	l32i.n	a9, a6, 4
     aed:	2688           	l32i.n	a8, a6, 8
     aef:	36b8           	l32i.n	a11, a6, 12
     af1:	10c662        	addi	a6, a6, 16
     af4:	c0aa20        	sub	a10, a10, a2
     af7:	c09920        	sub	a9, a9, a2
     afa:	c08820        	sub	a8, a8, a2
     afd:	c0fb20        	sub	a15, a11, a2
     b00:	43ba50        	min	a11, a10, a5
     b03:	72ea30        	salt	a14, a10, a3
     b06:	43a950        	min	a10, a9, a5
     b09:	72d930        	salt	a13, a9, a3
     b0c:	439850        	min	a9, a8, a5
     b0f:	72c830        	salt	a12, a8, a3
     b12:	438f50        	min	a8, a15, a5
     b15:	72ff30        	salt	a15, a15, a3
     b18:	93b4e0        	movnez	a11, a4, a14
     b1b:	93a4d0        	movnez	a10, a4, a13
     b1e:	9394c0        	movnez	a9, a4, a12
     b21:	9384f0        	movnez	a8, a4, a15
     b24:	07b9           	s32i.n	a11, a7, 0
     b26:	17a9           	s32i.n	a10, a7, 4
     b28:	2799           	s32i.n	a9, a7, 8
     b2a:	3789           	s32i.n	a8, a7, 12
     b2c:	10c772        	addi	a7, a7, 16
     b2f:	81b8           	l32i.n	a11, a1, 32
     b31:	61c8           	l32i.n	a12, a1, 24
     b33:	41a8           	l32i.n	a10, a1, 16
     b35:	c1d8           	l32i.n	a13, a1, 48
     b37:	05ed           	mov.n	a14, a5
     b39:	03fd           	mov.n	a15, a3
     b3b:	7149           	s32i.n	a4, a1, 28

00000b3d <sbc_calculate_bits_modified+0x255>:
     b3d:	47ada7        	bge	a13, a10, b88 <sbc_calculate_bits_modified+0x2a0>
     b40:	221b           	addi.n	a2, a2, 1
     b42:	00a032        	movi	a3, 0
     b45:	3f8c76        	loop	a12, b88 <sbc_calculate_bits_modified+0x2a0>
     b48:	4b3a           	add.n	a4, a11, a3
     b4a:	0458           	l32i.n	a5, a4, 0
     b4c:	d70c           	movi.n	a7, 13
     b4e:	5188           	l32i.n	a8, a1, 20
     b50:	fec562        	addi	a6, a5, -2
     b53:	063767        	bltu	a7, a6, b5d <sbc_calculate_bits_modified+0x275>
     b56:	651b           	addi.n	a6, a5, 1
     b58:	170c           	movi.n	a7, 1
     b5a:	000806        	j	b7e <sbc_calculate_bits_modified+0x296>

00000b5d <sbc_calculate_bits_modified+0x275>:
     b5d:	c07ad0        	sub	a7, a10, a13
     b60:	190c           	movi.n	a9, 1
     b62:	683a           	add.n	a6, a8, a3
     b64:	0688           	l32i.n	a8, a6, 0
     b66:	727970        	salt	a7, a9, a7
     b69:	260c           	movi.n	a6, 2
     b6b:	c08820        	sub	a8, a8, a2
     b6e:	628890        	saltu	a8, a8, a9
     b71:	108780        	and	a8, a7, a8
     b74:	270c           	movi.n	a7, 2
     b76:	08cc           	bnez.n	a8, b7a <sbc_calculate_bits_modified+0x292>
     b78:	070c           	movi.n	a7, 0
     b7a:	08cc           	bnez.n	a8, b7e <sbc_calculate_bits_modified+0x296>
     b7c:	056d           	mov.n	a6, a5
     b7e:	d7da           	add.n	a13, a7, a13
     b80:	0469           	s32i.n	a6, a4, 0
     b82:	02ada7        	bge	a13, a10, b88 <sbc_calculate_bits_modified+0x2a0>
     b85:	04c332        	addi	a3, a3, 4

00000b88 <sbc_calculate_bits_modified+0x2a0>:
     b88:	d178           	l32i.n	a7, a1, 52
     b8a:	02ada7        	bge	a13, a10, b90 <sbc_calculate_bits_modified+0x2a8>
     b8d:	ff6c06        	j	941 <sbc_calculate_bits_modified+0x59>
     b90:	ff7086        	j	956 <sbc_calculate_bits_modified+0x6e>

00000b93 <sbc_calculate_bits_modified+0x2ab>:
     b93:	0c0c           	movi.n	a12, 0
     b95:	ffa7c6        	j	a38 <sbc_calculate_bits_modified+0x150>

00000b98 <sbc_calculate_bits_modified+0x2b0>:
     b98:	903330        	addx2	a3, a3, a3
     b9b:	1133e0        	slli	a3, a3, 2
     b9e:	fd2c61        	l32r	a6, 50 (1620 <sbc_offset_table>)
     ba1:	fccc42        	addi	a4, a12, -4
     ba4:	734b           	addi.n	a7, a3, 4
     ba6:	837340        	moveqz	a7, a3, a4
     ba9:	1ca452        	movi	a5, 0x41c
     bac:	967a           	add.n	a9, a6, a7
     bae:	7199           	s32i.n	a9, a1, 28
     bb0:	0a0c           	movi.n	a10, 0
     bb2:	40c1f2        	addi	a15, a1, 64
     bb5:	e25a           	add.n	a14, a2, a5
     bb7:	2d0c           	movi.n	a13, 2
     bb9:	090c           	movi.n	a9, 0
     bbb:	81b9           	s32i.n	a11, a1, 32
     bbd:	001546        	j	c16 <sbc_calculate_bits_modified+0x32e>

00000bc0 <sbc_calculate_bits_modified+0x2d8>:
     bc0:	0c0c           	movi.n	a12, 0
     bc2:	002f06        	j	c82 <sbc_calculate_bits_modified+0x39a>

00000bc5 <sbc_calculate_bits_modified+0x2dd>:
     bc5:	5199           	s32i.n	a9, a1, 20
     bc7:	449276        	loopnez	a2, c0f <sbc_calculate_bits_modified+0x327>
     bca:	0003b2        	l8ui	a11, a3, 0
     bcd:	0103a2        	l8ui	a10, a3, 1
     bd0:	020392        	l8ui	a9, a3, 2
     bd3:	030382        	l8ui	a8, a3, 3
     bd6:	040372        	l8ui	a7, a3, 4
     bd9:	050362        	l8ui	a6, a3, 5
     bdc:	060352        	l8ui	a5, a3, 6
     bdf:	070322        	l8ui	a2, a3, 7
     be2:	338b           	addi.n	a3, a3, 8
     be4:	04b9           	s32i.n	a11, a4, 0
     be6:	14a9           	s32i.n	a10, a4, 4
     be8:	2499           	s32i.n	a9, a4, 8
     bea:	3489           	s32i.n	a8, a4, 12
     bec:	4479           	s32i.n	a7, a4, 16
     bee:	5469           	s32i.n	a6, a4, 20
     bf0:	6459           	s32i.n	a5, a4, 24
     bf2:	7429           	s32i.n	a2, a4, 28
     bf4:	20c442        	addi	a4, a4, 32
     bf7:	73bcb0        	maxu	a11, a12, a11
     bfa:	73aba0        	maxu	a10, a11, a10
     bfd:	739a90        	maxu	a9, a10, a9
     c00:	738980        	maxu	a8, a9, a8
     c03:	737870        	maxu	a7, a8, a7
     c06:	736760        	maxu	a6, a7, a6
     c09:	735650        	maxu	a5, a6, a5
     c0c:	73c520        	maxu	a12, a5, a2

00000c0f <sbc_calculate_bits_modified+0x327>:
     c0f:	5198           	l32i.n	a9, a1, 20
     c11:	0a0c           	movi.n	a10, 0
     c13:	001ac6        	j	c82 <sbc_calculate_bits_modified+0x39a>

00000c16 <sbc_calculate_bits_modified+0x32e>:
     c16:	9128           	l32i.n	a2, a1, 36
     c18:	0c5d           	mov.n	a5, a12
     c1a:	0e3d           	mov.n	a3, a14
     c1c:	291266        	bnei	a2, 1, c49 <sbc_calculate_bits_modified+0x361>
     c1f:	9d1ca6        	blti	a12, 1, bc0 <sbc_calculate_bits_modified+0x2d8>
     c22:	0c2d           	mov.n	a2, a12
     c24:	2450c0        	extui	a5, a12, 0, 3
     c27:	0c0c           	movi.n	a12, 0
     c29:	0e3d           	mov.n	a3, a14
     c2b:	204ff0        	or	a4, a15, a15
     c2e:	412320        	srli	a2, a2, 3
     c31:	0b9576        	loopnez	a5, c40 <sbc_calculate_bits_modified+0x358>
     c34:	000352        	l8ui	a5, a3, 0
     c37:	0459           	s32i.n	a5, a4, 0
     c39:	331b           	addi.n	a3, a3, 1
     c3b:	444b           	addi.n	a4, a4, 4
     c3d:	73cc50        	maxu	a12, a12, a5

00000c40 <sbc_calculate_bits_modified+0x358>:
     c40:	f81256        	bnez	a2, bc5 <sbc_calculate_bits_modified+0x2dd>
     c43:	000ec6        	j	c82 <sbc_calculate_bits_modified+0x39a>

00000c46 <sbc_calculate_bits_modified+0x35e>:
     c46:	000000                                        ...

00000c49 <sbc_calculate_bits_modified+0x361>:
     c49:	021ce6        	bgei	a12, 1, c4f <sbc_calculate_bits_modified+0x367>
     c4c:	ffdc06        	j	bc0 <sbc_calculate_bits_modified+0x2d8>
     c4f:	7128           	l32i.n	a2, a1, 28
     c51:	0c0c           	movi.n	a12, 0
     c53:	0f4d           	mov.n	a4, a15
     c55:	298576        	loop	a5, c82 <sbc_calculate_bits_modified+0x39a>
     c58:	000352        	l8ui	a5, a3, 0
     c5b:	959c           	beqz.n	a5, c78 <sbc_calculate_bits_modified+0x390>
     c5d:	000262        	l8ui	a6, a2, 0
     c60:	236600        	sext	a6, a6, 7
     c63:	565a           	add.n	a5, a6, a5
     c65:	216150        	srai	a6, a5, 1
     c68:	727a50        	salt	a7, a10, a5
     c6b:	538c60        	max	a8, a12, a6
     c6e:	935670        	movnez	a5, a6, a7
     c71:	93c870        	movnez	a12, a8, a7
     c74:	000086        	j	c7a <sbc_calculate_bits_modified+0x392>

00000c77 <sbc_calculate_bits_modified+0x38f>:
	...

00000c78 <sbc_calculate_bits_modified+0x390>:
     c78:	b57c           	movi.n	a5, -5
     c7a:	0459           	s32i.n	a5, a4, 0
     c7c:	444b           	addi.n	a4, a4, 4
     c7e:	331b           	addi.n	a3, a3, 1
     c80:	221b           	addi.n	a2, a2, 1

00000c82 <sbc_calculate_bits_modified+0x39a>:
     c82:	5399c0        	max	a9, a9, a12
     c85:	61c8           	l32i.n	a12, a1, 24
     c87:	dd0b           	addi.n	a13, a13, -1
     c89:	20cff2        	addi	a15, a15, 32
     c8c:	ee8b           	addi.n	a14, a14, 8
     c8e:	f84d56        	bnez	a13, c16 <sbc_calculate_bits_modified+0x32e>
     c91:	4128           	l32i.n	a2, a1, 16
     c93:	0d0c           	movi.n	a13, 0
     c95:	0a0c           	movi.n	a10, 0
     c97:	02c2e6        	bgei	a2, 32, c9d <sbc_calculate_bits_modified+0x3b5>
     c9a:	002b46        	j	d4b <sbc_calculate_bits_modified+0x463>
     c9d:	4128           	l32i.n	a2, a1, 16
     c9f:	0a0c           	movi.n	a10, 0
     ca1:	40c132        	addi	a3, a1, 64
     ca4:	412420        	srli	a2, a2, 4
     ca7:	c02920        	sub	a2, a9, a2
     caa:	921b           	addi.n	a9, a2, 1
     cac:	021ce6        	bgei	a12, 1, cb2 <sbc_calculate_bits_modified+0x3ca>
     caf:	002606        	j	d4b <sbc_calculate_bits_modified+0x463>
     cb2:	0a0c           	movi.n	a10, 0
     cb4:	0d0c           	movi.n	a13, 0
     cb6:	4141c0        	srli	a4, a12, 1
     cb9:	106c07        	bbci	a12, 0, ccd <sbc_calculate_bits_modified+0x3e5>
     cbc:	0328           	l32i.n	a2, a3, 0
     cbe:	334b           	addi.n	a3, a3, 4
     cc0:	725920        	salt	a5, a9, a2
     cc3:	c02290        	sub	a2, a2, a9
     cc6:	832550        	moveqz	a2, a5, a5
     cc9:	aa5a           	add.n	a10, a10, a5
     ccb:	d2da           	add.n	a13, a2, a13

00000ccd <sbc_calculate_bits_modified+0x3e5>:
     ccd:	f4ac           	beqz.n	a4, d00 <sbc_calculate_bits_modified+0x418>
     ccf:	0d8d           	mov.n	a8, a13
     cd1:	0a7d           	mov.n	a7, a10
     cd3:	092d           	mov.n	a2, a9
     cd5:	1f9476        	loopnez	a4, cf8 <sbc_calculate_bits_modified+0x410>
     cd8:	0368           	l32i.n	a6, a3, 0
     cda:	1398           	l32i.n	a9, a3, 4
     cdc:	338b           	addi.n	a3, a3, 8
     cde:	c05620        	sub	a5, a6, a2
     ce1:	c04920        	sub	a4, a9, a2
     ce4:	729290        	salt	a9, a2, a9
     ce7:	726260        	salt	a6, a2, a6
     cea:	834990        	moveqz	a4, a9, a9
     ced:	776a           	add.n	a7, a7, a6
     cef:	779a           	add.n	a7, a7, a9
     cf1:	835660        	moveqz	a5, a6, a6
     cf4:	558a           	add.n	a5, a5, a8
     cf6:	845a           	add.n	a8, a4, a5

00000cf8 <sbc_calculate_bits_modified+0x410>:
     cf8:	209220        	or	a9, a2, a2
     cfb:	07ad           	mov.n	a10, a7
     cfd:	20d880        	or	a13, a8, a8

00000d00 <sbc_calculate_bits_modified+0x418>:
     d00:	60c132        	addi	a3, a1, 96
     d03:	4141c0        	srli	a4, a12, 1
     d06:	106c07        	bbci	a12, 0, d1a <sbc_calculate_bits_modified+0x432>
     d09:	0328           	l32i.n	a2, a3, 0
     d0b:	334b           	addi.n	a3, a3, 4
     d0d:	725920        	salt	a5, a9, a2
     d10:	c02290        	sub	a2, a2, a9
     d13:	832550        	moveqz	a2, a5, a5
     d16:	aa5a           	add.n	a10, a10, a5
     d18:	d2da           	add.n	a13, a2, a13
     d1a:	d4ac           	beqz.n	a4, d4b <sbc_calculate_bits_modified+0x463>
     d1c:	0d8d           	mov.n	a8, a13
     d1e:	0a7d           	mov.n	a7, a10
     d20:	092d           	mov.n	a2, a9
     d22:	1f9476        	loopnez	a4, d45 <sbc_calculate_bits_modified+0x45d>
     d25:	0368           	l32i.n	a6, a3, 0
     d27:	1398           	l32i.n	a9, a3, 4
     d29:	338b           	addi.n	a3, a3, 8
     d2b:	c05620        	sub	a5, a6, a2
     d2e:	c04920        	sub	a4, a9, a2
     d31:	729290        	salt	a9, a2, a9
     d34:	726260        	salt	a6, a2, a6
     d37:	834990        	moveqz	a4, a9, a9
     d3a:	776a           	add.n	a7, a7, a6
     d3c:	779a           	add.n	a7, a7, a9
     d3e:	835660        	moveqz	a5, a6, a6
     d41:	558a           	add.n	a5, a5, a8
     d43:	845a           	add.n	a8, a4, a5

00000d45 <sbc_calculate_bits_modified+0x45d>:
     d45:	029d           	mov.n	a9, a2
     d47:	07ad           	mov.n	a10, a7
     d49:	08dd           	mov.n	a13, a8

00000d4b <sbc_calculate_bits_modified+0x463>:
     d4b:	60c1b2        	addi	a11, a1, 96
     d4e:	40c1c2        	addi	a12, a1, 64
     d51:	e30c           	movi.n	a3, 14
     d53:	240c           	movi.n	a4, 2
     d55:	0000c6        	j	d5c <sbc_calculate_bits_modified+0x474>

00000d58 <sbc_calculate_bits_modified+0x470>:
     d58:	002246        	j	de5 <sbc_calculate_bits_modified+0x4fd>

00000d5b <sbc_calculate_bits_modified+0x473>:
	...

00000d5c <sbc_calculate_bits_modified+0x474>:
     d5c:	6178           	l32i.n	a7, a1, 24
     d5e:	092d           	mov.n	a2, a9
     d60:	080c           	movi.n	a8, 0
     d62:	f217a6        	blti	a7, 1, d58 <sbc_calculate_bits_modified+0x470>
     d65:	080c           	movi.n	a8, 0
     d67:	0c5d           	mov.n	a5, a12
     d69:	416170        	srli	a6, a7, 1
     d6c:	106707        	bbci	a7, 0, d80 <sbc_calculate_bits_modified+0x498>
     d6f:	0578           	l32i.n	a7, a5, 0
     d71:	554b           	addi.n	a5, a5, 4
     d73:	c07720        	sub	a7, a7, a2
     d76:	970b           	addi.n	a9, a7, -1
     d78:	629930        	saltu	a9, a9, a3
     d7b:	839470        	moveqz	a9, a4, a7
     d7e:	898a           	add.n	a8, a9, a8
     d80:	16ac           	beqz.n	a6, da5 <sbc_calculate_bits_modified+0x4bd>
     d82:	1f9676        	loopnez	a6, da5 <sbc_calculate_bits_modified+0x4bd>
     d85:	0578           	l32i.n	a7, a5, 0
     d87:	1568           	l32i.n	a6, a5, 4
     d89:	558b           	addi.n	a5, a5, 8
     d8b:	c07720        	sub	a7, a7, a2
     d8e:	c09620        	sub	a9, a6, a2
     d91:	690b           	addi.n	a6, a9, -1
     d93:	626630        	saltu	a6, a6, a3
     d96:	836490        	moveqz	a6, a4, a9
     d99:	970b           	addi.n	a9, a7, -1
     d9b:	629930        	saltu	a9, a9, a3
     d9e:	839470        	moveqz	a9, a4, a7
     da1:	798a           	add.n	a7, a9, a8
     da3:	867a           	add.n	a8, a6, a7

00000da5 <sbc_calculate_bits_modified+0x4bd>:
     da5:	6178           	l32i.n	a7, a1, 24
     da7:	0b5d           	mov.n	a5, a11
     da9:	416170        	srli	a6, a7, 1
     dac:	106707        	bbci	a7, 0, dc0 <sbc_calculate_bits_modified+0x4d8>
     daf:	0578           	l32i.n	a7, a5, 0
     db1:	554b           	addi.n	a5, a5, 4
     db3:	c07720        	sub	a7, a7, a2
     db6:	970b           	addi.n	a9, a7, -1
     db8:	629930        	saltu	a9, a9, a3
     dbb:	839470        	moveqz	a9, a4, a7
     dbe:	898a           	add.n	a8, a9, a8

00000dc0 <sbc_calculate_bits_modified+0x4d8>:
     dc0:	16ac           	beqz.n	a6, de5 <sbc_calculate_bits_modified+0x4fd>
     dc2:	1f9676        	loopnez	a6, de5 <sbc_calculate_bits_modified+0x4fd>
     dc5:	0578           	l32i.n	a7, a5, 0
     dc7:	1568           	l32i.n	a6, a5, 4
     dc9:	558b           	addi.n	a5, a5, 8
     dcb:	c07720        	sub	a7, a7, a2
     dce:	c09620        	sub	a9, a6, a2
     dd1:	690b           	addi.n	a6, a9, -1
     dd3:	626630        	saltu	a6, a6, a3
     dd6:	836490        	moveqz	a6, a4, a9
     dd9:	970b           	addi.n	a9, a7, -1
     ddb:	629930        	saltu	a9, a9, a3
     dde:	839470        	moveqz	a9, a4, a7
     de1:	798a           	add.n	a7, a9, a8
     de3:	867a           	add.n	a8, a6, a7

00000de5 <sbc_calculate_bits_modified+0x4fd>:
     de5:	4158           	l32i.n	a5, a1, 16
     de7:	dada           	add.n	a13, a10, a13
     de9:	e8da           	add.n	a14, a8, a13
     deb:	920b           	addi.n	a9, a2, -1
     ded:	08ad           	mov.n	a10, a8
     def:	02ae57        	bge	a14, a5, df5 <sbc_calculate_bits_modified+0x50d>
     df2:	ffd986        	j	d5c <sbc_calculate_bits_modified+0x474>
     df5:	61c8           	l32i.n	a12, a1, 24
     df7:	81b8           	l32i.n	a11, a1, 32
     df9:	41a8           	l32i.n	a10, a1, 16
     dfb:	021ce6        	bgei	a12, 1, e01 <sbc_calculate_bits_modified+0x519>
     dfe:	006cc6        	j	fb5 <sbc_calculate_bits_modified+0x6cd>
     e01:	c08ea0        	sub	a8, a14, a10
     e04:	fec222        	addi	a2, a2, -2
     e07:	14f0c0        	extui	a15, a12, 0, 2
     e0a:	932980        	movnez	a2, a9, a8
     e0d:	9189           	s32i.n	a8, a1, 36
     e0f:	40c162        	addi	a6, a1, 64
     e12:	031c           	movi.n	a3, 16
     e14:	240c           	movi.n	a4, 2
     e16:	050c           	movi.n	a5, 0
     e18:	0b7d           	mov.n	a7, a11
     e1a:	4182c0        	srli	a8, a12, 2
     e1d:	159f76        	loopnez	a15, e36 <sbc_calculate_bits_modified+0x54e>
     e20:	0698           	l32i.n	a9, a6, 0
     e22:	664b           	addi.n	a6, a6, 4
     e24:	c09920        	sub	a9, a9, a2
     e27:	43a930        	min	a10, a9, a3
     e2a:	729940        	salt	a9, a9, a4
     e2d:	93a590        	movnez	a10, a5, a9
     e30:	07a9           	s32i.n	a10, a7, 0
     e32:	41a8           	l32i.n	a10, a1, 16
     e34:	774b           	addi.n	a7, a7, 4

00000e36 <sbc_calculate_bits_modified+0x54e>:
     e36:	51d9           	s32i.n	a13, a1, 20
     e38:	71e9           	s32i.n	a14, a1, 28
     e3a:	052816        	beqz	a8, e90 <sbc_calculate_bits_modified+0x5a8>
     e3d:	459876        	loopnez	a8, e86 <sbc_calculate_bits_modified+0x59e>
     e40:	06a8           	l32i.n	a10, a6, 0
     e42:	1698           	l32i.n	a9, a6, 4
     e44:	2688           	l32i.n	a8, a6, 8
     e46:	36b8           	l32i.n	a11, a6, 12
     e48:	10c662        	addi	a6, a6, 16
     e4b:	c0aa20        	sub	a10, a10, a2
     e4e:	c09920        	sub	a9, a9, a2
     e51:	c08820        	sub	a8, a8, a2
     e54:	c0fb20        	sub	a15, a11, a2
     e57:	43ba30        	min	a11, a10, a3
     e5a:	72ea40        	salt	a14, a10, a4
     e5d:	43a930        	min	a10, a9, a3
     e60:	72d940        	salt	a13, a9, a4
     e63:	439830        	min	a9, a8, a3
     e66:	72c840        	salt	a12, a8, a4
     e69:	438f30        	min	a8, a15, a3
     e6c:	72ff40        	salt	a15, a15, a4
     e6f:	93b5e0        	movnez	a11, a5, a14
     e72:	93a5d0        	movnez	a10, a5, a13
     e75:	9395c0        	movnez	a9, a5, a12
     e78:	9385f0        	movnez	a8, a5, a15
     e7b:	07b9           	s32i.n	a11, a7, 0
     e7d:	17a9           	s32i.n	a10, a7, 4
     e7f:	2799           	s32i.n	a9, a7, 8
     e81:	3789           	s32i.n	a8, a7, 12
     e83:	10c772        	addi	a7, a7, 16
     e86:	81b8           	l32i.n	a11, a1, 32
     e88:	61c8           	l32i.n	a12, a1, 24
     e8a:	41a8           	l32i.n	a10, a1, 16
     e8c:	51d8           	l32i.n	a13, a1, 20
     e8e:	71e8           	l32i.n	a14, a1, 28

00000e90 <sbc_calculate_bits_modified+0x5a8>:
     e90:	1490c0        	extui	a9, a12, 0, 2
     e93:	20cb72        	addi	a7, a11, 32
     e96:	60c162        	addi	a6, a1, 96
     e99:	031c           	movi.n	a3, 16
     e9b:	240c           	movi.n	a4, 2
     e9d:	050c           	movi.n	a5, 0
     e9f:	4182c0        	srli	a8, a12, 2
     ea2:	159976        	loopnez	a9, ebb <sbc_calculate_bits_modified+0x5d3>
     ea5:	0698           	l32i.n	a9, a6, 0
     ea7:	664b           	addi.n	a6, a6, 4
     ea9:	c09920        	sub	a9, a9, a2
     eac:	43a930        	min	a10, a9, a3
     eaf:	729940        	salt	a9, a9, a4
     eb2:	93a590        	movnez	a10, a5, a9
     eb5:	07a9           	s32i.n	a10, a7, 0
     eb7:	41a8           	l32i.n	a10, a1, 16
     eb9:	774b           	addi.n	a7, a7, 4

00000ebb <sbc_calculate_bits_modified+0x5d3>:
     ebb:	052816        	beqz	a8, f11 <sbc_calculate_bits_modified+0x629>
     ebe:	459876        	loopnez	a8, f07 <sbc_calculate_bits_modified+0x61f>
     ec1:	06a8           	l32i.n	a10, a6, 0
     ec3:	1698           	l32i.n	a9, a6, 4
     ec5:	2688           	l32i.n	a8, a6, 8
     ec7:	36b8           	l32i.n	a11, a6, 12
     ec9:	10c662        	addi	a6, a6, 16
     ecc:	c0aa20        	sub	a10, a10, a2
     ecf:	c09920        	sub	a9, a9, a2
     ed2:	c08820        	sub	a8, a8, a2
     ed5:	c0fb20        	sub	a15, a11, a2
     ed8:	43ba30        	min	a11, a10, a3
     edb:	72ea40        	salt	a14, a10, a4
     ede:	43a930        	min	a10, a9, a3
     ee1:	72d940        	salt	a13, a9, a4
     ee4:	439830        	min	a9, a8, a3
     ee7:	72c840        	salt	a12, a8, a4
     eea:	438f30        	min	a8, a15, a3
     eed:	72ff40        	salt	a15, a15, a4
     ef0:	93b5e0        	movnez	a11, a5, a14
     ef3:	93a5d0        	movnez	a10, a5, a13
     ef6:	9395c0        	movnez	a9, a5, a12
     ef9:	9385f0        	movnez	a8, a5, a15
     efc:	07b9           	s32i.n	a11, a7, 0
     efe:	17a9           	s32i.n	a10, a7, 4
     f00:	2799           	s32i.n	a9, a7, 8
     f02:	3789           	s32i.n	a8, a7, 12
     f04:	10c772        	addi	a7, a7, 16
     f07:	81b8           	l32i.n	a11, a1, 32
     f09:	61c8           	l32i.n	a12, a1, 24
     f0b:	41a8           	l32i.n	a10, a1, 16
     f0d:	51d8           	l32i.n	a13, a1, 20
     f0f:	71e8           	l32i.n	a14, a1, 28

00000f11 <sbc_calculate_bits_modified+0x629>:
     f11:	9138           	l32i.n	a3, a1, 36
     f13:	221b           	addi.n	a2, a2, 1
     f15:	d40c           	movi.n	a4, 13
     f17:	93ed30        	movnez	a14, a13, a3
     f1a:	64aea7        	bge	a14, a10, f82 <sbc_calculate_bits_modified+0x69a>
     f1d:	030c           	movi.n	a3, 0
     f1f:	150c           	movi.n	a5, 1
     f21:	40c162        	addi	a6, a1, 64
     f24:	080c           	movi.n	a8, 0
     f26:	087d           	mov.n	a7, a8
     f28:	538076        	loop	a0, f7f <sbc_calculate_bits_modified+0x697>
     f2b:	11a7b0        	slli	a10, a7, 5
     f2e:	8baa           	add.n	a8, a11, a10
     f30:	a08380        	addx4	a8, a3, a8
     f33:	0898           	l32i.n	a9, a8, 0
     f35:	a6aa           	add.n	a10, a6, a10
     f37:	a0a3a0        	addx4	a10, a3, a10
     f3a:	fec9f2        	addi	a15, a9, -2
     f3d:	0834f7        	bltu	a4, a15, f49 <sbc_calculate_bits_modified+0x661>
     f40:	a91b           	addi.n	a10, a9, 1
     f42:	1b0c           	movi.n	a11, 1
     f44:	000886        	j	f6a <sbc_calculate_bits_modified+0x682>

00000f47 <sbc_calculate_bits_modified+0x65f>:
	...

00000f49 <sbc_calculate_bits_modified+0x661>:
     f49:	0aa8           	l32i.n	a10, a10, 0
     f4b:	41b8           	l32i.n	a11, a1, 16
     f4d:	c0aa20        	sub	a10, a10, a2
     f50:	c0cbe0        	sub	a12, a11, a14
     f53:	72c5c0        	salt	a12, a5, a12
     f56:	62aa50        	saltu	a10, a10, a5
     f59:	10cca0        	and	a12, a12, a10
     f5c:	2b0c           	movi.n	a11, 2
     f5e:	2a0c           	movi.n	a10, 2
     f60:	0ccc           	bnez.n	a12, f64 <sbc_calculate_bits_modified+0x67c>
     f62:	09ad           	mov.n	a10, a9
     f64:	0ccc           	bnez.n	a12, f68 <sbc_calculate_bits_modified+0x680>
     f66:	0b0c           	movi.n	a11, 0
     f68:	61c8           	l32i.n	a12, a1, 24
     f6a:	08a9           	s32i.n	a10, a8, 0
     f6c:	41a8           	l32i.n	a10, a1, 16
     f6e:	ebea           	add.n	a14, a11, a14
     f70:	81b8           	l32i.n	a11, a1, 32
     f72:	0caea7        	bge	a14, a10, f82 <sbc_calculate_bits_modified+0x69a>
     f75:	308750        	xor	a8, a7, a5
     f78:	337a           	add.n	a3, a3, a7
     f7a:	087d           	mov.n	a7, a8
     f7c:	02a3c7        	bge	a3, a12, f82 <sbc_calculate_bits_modified+0x69a>

00000f7f <sbc_calculate_bits_modified+0x697>:
     f7f:	ffe8c6        	j	f26 <sbc_calculate_bits_modified+0x63e>

00000f82 <sbc_calculate_bits_modified+0x69a>:
     f82:	2faea7        	bge	a14, a10, fb5 <sbc_calculate_bits_modified+0x6cd>
     f85:	020c           	movi.n	a2, 0
     f87:	031c           	movi.n	a3, 16
     f89:	140c           	movi.n	a4, 1
     f8b:	060c           	movi.n	a6, 0
     f8d:	065d           	mov.n	a5, a6
     f8f:	1f8076        	loop	a0, fb2 <sbc_calculate_bits_modified+0x6ca>
     f92:	1165b0        	slli	a6, a5, 5
     f95:	6b6a           	add.n	a6, a11, a6
     f97:	a06260        	addx4	a6, a2, a6
     f9a:	0678           	l32i.n	a7, a6, 0
     f9c:	225a           	add.n	a2, a2, a5
     f9e:	728730        	salt	a8, a7, a3
     fa1:	ee8a           	add.n	a14, a14, a8
     fa3:	778a           	add.n	a7, a7, a8
     fa5:	0679           	s32i.n	a7, a6, 0
     fa7:	0aaea7        	bge	a14, a10, fb5 <sbc_calculate_bits_modified+0x6cd>
     faa:	306540        	xor	a6, a5, a4
     fad:	065d           	mov.n	a5, a6
     faf:	02a2c7        	bge	a2, a12, fb5 <sbc_calculate_bits_modified+0x6cd>

00000fb2 <sbc_calculate_bits_modified+0x6ca>:
     fb2:	fff5c6        	j	f8d <sbc_calculate_bits_modified+0x6a5>

00000fb5 <sbc_calculate_bits_modified+0x6cd>:
     fb5:	f01d           	retw.n

00000fb7 <sbc_calculate_bits_modified+0x6cf>:
	...

00000fb8 <xt_memset>:
     fb8:	004136        	entry	a1, 32
     fbb:	1514a6        	blti	a4, 1, fd4 <xt_memset+0x1c>
     fbe:	415140        	srli	a5, a4, 1
     fc1:	046407        	bbci	a4, 0, fc9 <xt_memset+0x11>
     fc4:	623d           	ae_s16i.n	a3, a2, 0
     fc6:	02c222        	addi	a2, a2, 2

00000fc9 <xt_memset+0x11>:
     fc9:	758c           	beqz.n	a5, fd4 <xt_memset+0x1c>
     fcb:	059576        	loopnez	a5, fd4 <xt_memset+0x1c>
     fce:	623d           	ae_s16i.n	a3, a2, 0
     fd0:	723d           	ae_s16i.n	a3, a2, 2
     fd2:	224b           	addi.n	a2, a2, 4

00000fd4 <xt_memset+0x1c>:
     fd4:	f01d           	retw.n

00000fd6 <xt_memset+0x1e>:
	...

00000fd8 <sbc_encoder_get_buffer_size>:
     fd8:	004136        	entry	a1, 32
     fdb:	74a622        	movi	a2, 0x674
     fde:	f01d           	retw.n

00000fe0 <sbc_encoder_init>:
     fe0:	004136        	entry	a1, 32
     fe3:	025d           	mov.n	a5, a2
     fe5:	f27c           	movi.n	a2, -1
     fe7:	0c1516        	beqz	a5, 10ac <sbc_encoder_init+0xcc>
     fea:	036d           	mov.n	a6, a3
     fec:	0bc316        	beqz	a3, 10ac <sbc_encoder_init+0xcc>
     fef:	0b9416        	beqz	a4, 10ac <sbc_encoder_init+0xcc>
     ff2:	3aa372        	movi	a7, 0x33a
     ff5:	417170        	srli	a7, a7, 1
     ff8:	020c           	movi.n	a2, 0
     ffa:	203660        	or	a3, a6, a6
     ffd:	059776        	loopnez	a7, 1006 <sbc_encoder_init+0x26>
    1000:	632d           	ae_s16i.n	a2, a3, 0
    1002:	732d           	ae_s16i.n	a2, a3, 2
    1004:	334b           	addi.n	a3, a3, 4

00001006 <sbc_encoder_init+0x26>:
    1006:	0488           	l32i.n	a8, a4, 0
    1008:	1478           	l32i.n	a7, a4, 4
    100a:	020c           	movi.n	a2, 0
    100c:	1138a0        	slli	a3, a8, 6
    100f:	418280        	srli	a8, a8, 2
    1012:	0529           	s32i.n	a2, a5, 0
    1014:	933280        	movnez	a3, a2, a8
    1017:	e27c           	movi.n	a2, -2
    1019:	832880        	moveqz	a2, a8, a8
    101c:	2a47f6        	bgeui	a7, 4, 104a <sbc_encoder_init+0x6a>
    101f:	4e0c           	movi.n	a14, 4
    1021:	1187c0        	slli	a8, a7, 4
    1024:	a0f7e0        	addx4	a15, a7, a14
    1027:	203380        	or	a3, a3, a8
    102a:	06f9           	s32i.n	a15, a6, 0
    102c:	3478           	l32i.n	a7, a4, 12
    102e:	2047b6        	bltui	a7, 4, 1052 <sbc_encoder_init+0x72>

00001031 <sbc_encoder_init+0x51>:
    1031:	f8c222        	addi	a2, a2, -8
    1034:	4478           	l32i.n	a7, a4, 16
    1036:	2e27b6        	bltui	a7, 2, 1068 <sbc_encoder_init+0x88>
    1039:	e0c222        	addi	a2, a2, -32
    103c:	2448           	l32i.n	a4, a4, 8
    103e:	3324b6        	bltui	a4, 2, 1075 <sbc_encoder_init+0x95>
    1041:	f0c222        	addi	a2, a2, -16
    1044:	f01d           	retw.n

00001046 <sbc_encoder_init+0x66>:
    1046:	00000000                                ....

0000104a <sbc_encoder_init+0x6a>:
    104a:	fcc222        	addi	a2, a2, -4
    104d:	3478           	l32i.n	a7, a4, 12
    104f:	de47f6        	bgeui	a7, 4, 1031 <sbc_encoder_init+0x51>
    1052:	290c           	movi.n	a9, 2
    1054:	1f0c           	movi.n	a15, 1
    1056:	1187e0        	slli	a8, a7, 2
    1059:	93f970        	movnez	a15, a9, a7
    105c:	203830        	or	a3, a8, a3
    105f:	3679           	s32i.n	a7, a6, 12
    1061:	16f9           	s32i.n	a15, a6, 4
    1063:	4478           	l32i.n	a7, a4, 16
    1065:	d027f6        	bgeui	a7, 2, 1039 <sbc_encoder_init+0x59>
    1068:	1187f0        	slli	a8, a7, 1
    106b:	203830        	or	a3, a8, a3
    106e:	4679           	s32i.n	a7, a6, 16
    1070:	2448           	l32i.n	a4, a4, 8
    1072:	cb24f6        	bgeui	a4, 2, 1041 <sbc_encoder_init+0x61>
    1075:	470c           	movi.n	a7, 4
    1077:	a07470        	addx4	a7, a4, a7
    107a:	2679           	s32i.n	a7, a6, 8
    107c:	02c296        	bltz	a2, 10ac <sbc_encoder_init+0xcc>
    107f:	202340        	or	a2, a3, a4
    1082:	04d6e2        	addmi	a14, a6, 0x400
    1085:	742020        	extui	a2, a2, 0, 8
    1088:	6e29           	s32i.n	a2, a14, 24
    108a:	2ca4f2        	movi	a15, 0x42c
    108d:	fbf121        	l32r	a2, 54 (7e0 <generate_crc_table>)
    1090:	a6fa           	add.n	a10, a6, a15
    1092:	0002e0        	callx8	a2
    1095:	3aa522        	movi	a2, 0x53a
    1098:	daa532        	movi	a3, 0x5da
    109b:	262a           	add.n	a2, a6, a2
    109d:	363a           	add.n	a3, a6, a3
    109f:	06d642        	addmi	a4, a6, 0x600
    10a2:	0569           	s32i.n	a6, a5, 0
    10a4:	1b6422        	s32i	a2, a4, 108
    10a7:	020c           	movi.n	a2, 0
    10a9:	1c6432        	s32i	a3, a4, 112
    10ac:	f01d           	retw.n

000010ae <sbc_encoder_init+0xce>:
	...

000010b0 <sbc_encoder_process>:
    10b0:	008136        	entry	a1, 64
    10b3:	028d           	mov.n	a8, a2
    10b5:	f27c           	movi.n	a2, -1
    10b7:	4189           	s32i.n	a8, a1, 16
    10b9:	0c5816        	beqz	a8, 1182 <sbc_encoder_process+0xd2>
    10bc:	0c2316        	beqz	a3, 1182 <sbc_encoder_process+0xd2>
    10bf:	0bf416        	beqz	a4, 1182 <sbc_encoder_process+0xd2>
    10c2:	0bc516        	beqz	a5, 1182 <sbc_encoder_process+0xd2>
    10c5:	0b9616        	beqz	a6, 1182 <sbc_encoder_process+0xd2>
    10c8:	0b6716        	beqz	a7, 1182 <sbc_encoder_process+0xd2>
    10cb:	0798           	l32i.n	a9, a7, 0
    10cd:	f8a0f2        	movi	a15, 248
    10d0:	e27c           	movi.n	a2, -2
    10d2:	fec982        	addi	a8, a9, -2
    10d5:	02bf87        	bgeu	a15, a8, 10db <sbc_encoder_process+0x2b>
    10d8:	002986        	j	1182 <sbc_encoder_process+0xd2>
    10db:	41e8           	l32i.n	a14, a1, 16
    10dd:	fbde81        	l32r	a8, 58 (108 <get_sbc_frame_pcm_byte_count>)
    10e0:	0428           	l32i.n	a2, a4, 0
    10e2:	0ea8           	l32i.n	a10, a14, 0
    10e4:	2ec8           	l32i.n	a12, a14, 8
    10e6:	1eb8           	l32i.n	a11, a14, 4
    10e8:	0678           	l32i.n	a7, a6, 0
    10ea:	3ef8           	l32i.n	a15, a14, 12
    10ec:	5149           	s32i.n	a4, a1, 20
    10ee:	2129           	s32i.n	a2, a1, 8
    10f0:	6169           	s32i.n	a6, a1, 24
    10f2:	31f9           	s32i.n	a15, a1, 12
    10f4:	5e99           	s32i.n	a9, a14, 20
    10f6:	0a2d           	mov.n	a2, a10
    10f8:	0c4d           	mov.n	a4, a12
    10fa:	206990        	or	a6, a9, a9
    10fd:	0008e0        	callx8	a8
    1100:	fbd781        	l32r	a8, 5c (118 <get_sbc_frame_bitstream_byte_count>)
    1103:	31b8           	l32i.n	a11, a1, 12
    1105:	11a9           	s32i.n	a10, a1, 4
    1107:	02ad           	mov.n	a10, a2
    1109:	04cd           	mov.n	a12, a4
    110b:	06dd           	mov.n	a13, a6
    110d:	0008e0        	callx8	a8
    1110:	2198           	l32i.n	a9, a1, 8
    1112:	020c           	movi.n	a2, 0
    1114:	040c           	movi.n	a4, 0
    1116:	080c           	movi.n	a8, 0
    1118:	3179           	s32i.n	a7, a1, 12
    111a:	5c37a7        	bltu	a7, a10, 117a <sbc_encoder_process+0xca>
    111d:	1178           	l32i.n	a7, a1, 4
    111f:	040c           	movi.n	a4, 0
    1121:	080c           	movi.n	a8, 0
    1123:	533977        	bltu	a9, a7, 117a <sbc_encoder_process+0xca>
    1126:	1128           	l32i.n	a2, a1, 4
    1128:	0a6d           	mov.n	a6, a10
    112a:	040c           	movi.n	a4, 0
    112c:	418120        	srli	a8, a2, 1
    112f:	c02920        	sub	a2, a9, a2
    1132:	1178f0        	slli	a7, a8, 1
    1135:	2129           	s32i.n	a2, a1, 8
    1137:	020c           	movi.n	a2, 0
    1139:	076172        	s32i	a7, a1, 28

0000113c <sbc_encoder_process+0x8c>:
    113c:	4178           	l32i.n	a7, a1, 16
    113e:	fbc881        	l32r	a8, 60 (154 <sbc_analyze_audio>)
    1141:	03bd           	mov.n	a11, a3
    1143:	07ad           	mov.n	a10, a7
    1145:	0008e0        	callx8	a8
    1148:	07ad           	mov.n	a10, a7
    114a:	fbc671        	l32r	a7, 64 (48c <sbc_pack_frame>)
    114d:	05bd           	mov.n	a11, a5
    114f:	0007e0        	callx8	a7
    1152:	3178           	l32i.n	a7, a1, 12
    1154:	11f8           	l32i.n	a15, a1, 4
    1156:	c04460        	sub	a4, a4, a6
    1159:	974a           	add.n	a9, a7, a4
    115b:	c082f0        	sub	a8, a2, a15
    115e:	103967        	bltu	a9, a6, 1172 <sbc_encoder_process+0xc2>
    1161:	2178           	l32i.n	a7, a1, 8
    1163:	71e8           	l32i.n	a14, a1, 28
    1165:	11f8           	l32i.n	a15, a1, 4
    1167:	972a           	add.n	a9, a7, a2
    1169:	556a           	add.n	a5, a5, a6
    116b:	33ea           	add.n	a3, a3, a14
    116d:	082d           	mov.n	a2, a8
    116f:	c9b9f7        	bgeu	a9, a15, 113c <sbc_encoder_process+0x8c>
    1172:	608080        	neg	a8, a8
    1175:	604040        	neg	a4, a4
    1178:	020c           	movi.n	a2, 0
    117a:	5138           	l32i.n	a3, a1, 20
    117c:	61f8           	l32i.n	a15, a1, 24
    117e:	0389           	s32i.n	a8, a3, 0
    1180:	0f49           	s32i.n	a4, a15, 0
    1182:	f01d           	retw.n

00001184 <__do_global_ctors_aux>:
    1184:	004136        	entry	a1, 32
    1187:	fbb831        	l32r	a3, 68 (1460 <__CTOR_END__>)
    118a:	fcc322        	addi	a2, a3, -4
    118d:	0228           	l32i.n	a2, a2, 0
    118f:	f8c332        	addi	a3, a3, -8
    1192:	0a0226        	beqi	a2, -1, 11a0 <__do_global_ctors_aux+0x1c>

00001195 <__do_global_ctors_aux+0x11>:
    1195:	0002e0        	callx8	a2
    1198:	0328           	l32i.n	a2, a3, 0
    119a:	fcc332        	addi	a3, a3, -4
    119d:	f40266        	bnei	a2, -1, 1195 <__do_global_ctors_aux+0x11>
    11a0:	f01d           	retw.n

000011a2 <__do_global_ctors_aux+0x1e>:
	...

000011a4 <_fini>:
    11a4:	008136        	entry	a1, 64
    11a7:	fbb181        	l32r	a8, 6c (88 <__do_global_dtors_aux>)
    11aa:	f03d           	nop.n
    11ac:	0008e0        	callx8	a8

000011af <_fini+0xb>:
    11af:	f01d           	retw.n
