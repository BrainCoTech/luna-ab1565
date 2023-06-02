
Build/lib/pisplit_ec120_position_independent.splitload.lib:     file format elf32-xtensa-le


Disassembly of section .text:

00000000 <_init-0x264>:
       0:	000002b0 00005d68 0000669c 00000000     ....h]...f......
      10:	0000666c 00000000 00006684 00005d9c     lf.......f...]..
      20:	00007318 00007310 000002c8 00000488     .s...s..........
      30:	00006910 00006980 00007314 000066ec     .i...i...s...f..
      40:	000011f8 00006704 00001288 0000671b     .....g.......g..
      50:	00001f34 00006732 00001d58 0000674d     4...2g..X...Mg..
      60:	00002f30 00006768 000011f0 0000677b     0/..hg......{g..
      70:	00001204 00006799 00001534 000067b6     .....g..4....g..
      80:	00002f14 000067d3 00002f88 000067f4     ./...g.../...g..
      90:	00002fbc 00006812 00003010 00006834     ./...h...0..4h..
      a0:	00003020 00006849 0000151c 0000685f      0..Ih......_h..
      b0:	00001618 000066b0 00005d88 00155555     .....f...]..UU..
      c0:	000009d4 000009b8 7fff7fff 002aaa00     ..............*.
      d0:	00006880 00005324 0000521c 00000a5c     .h..$S...R..\...
      e0:	00000ac4 00000b5c 00000c00 0150ea64     ....\.......d.P.
      f0:	000012a0 00000310 00001238 000005f8     ........8.......
     100:	00004890 0000313c 00004a90 0000154c     .H..<1...J..L...
     110:	000008d0 00006a90 00006ab0 00006af0     .....j...j...j..
     120:	00006b30 000004e0 00000524 0000497c     0k......$...|I..
     130:	4ec4ec4f 00001bc8 00001f50 00001c74     O..N....P...t...
     140:	00001630 00001990 000017d4 0000166c     0...........l...
     150:	00001860 00000c8c 00000efc 00001a30     `...........0...
     160:	0000345c 000036dc 000039a8 00003824     \4...6...9..$8..
     170:	00003d88 00003ef0 7fff0000 000041c8     .=...>.......A..
     180:	00004310 00001904 00001720 0000181c     .C...... .......
     190:	00003c38 00004aac 0000115c 000011a0     8<...J..\.......
     1a0:	0d330000 0e390000 000ccccc 00393e4b     ..3...9.....K>9.
     1b0:	00175e97 00003060 000033f8 00004c40     .^..`0...3..@L..
     1c0:	c0010000 3fff0000 00006bd0 00006bf0     .......?.k...k..
     1d0:	ffe9ffe9 00004654 00006e10 00005c94     ....TF...n...\..
     1e0:	00004cd0 00004e6c 00004f88 00005100     .L..lN...O...Q..
     1f0:	000003d0 000048b0 00004d18 00004ca8     .....H...M...L..
     200:	00035e51 00006b90 00006bc0 000068f0     Q^...k...k...h..
     210:	000e38e4 00006b70 00124925 00006bb0     .8..pk..%I...k..
     220:	80000001 00005688 00007210 000053e4     .....V...r...S..
     230:	00005348 000056b8 0000590c 00005934     HS...V...Y..4Y..
     240:	00005960 000059b0 00005988 00005a14     `Y...Y...Y...Z..
     250:	000059ec 00005c60 00005bf4 00006674     .Y..`\...[..tf..
     260:	0000027c                                |...

00000264 <_init>:
     264:	008136        	entry	a1, 64
     267:	ff6681        	l32r	a8, 0 (2b0 <frame_dummy>)
     26a:	f03d           	nop.n
     26c:	0008e0        	callx8	a8
     26f:	ff6581        	l32r	a8, 4 (5d68 <__do_global_ctors_aux>)
     272:	f03d           	nop.n
     274:	0008e0        	callx8	a8
     277:	f01d           	retw.n

00000279 <_init+0x15>:
     279:	000000                                        ...

0000027c <__do_global_dtors_aux>:
     27c:	004136        	entry	a1, 32
     27f:	ff6221        	l32r	a2, 8 (669c <__do_global_dtors_aux.completed>)
     282:	000232        	l8ui	a3, a2, 0
     285:	23ec           	bnez.n	a3, 2ab <__do_global_dtors_aux+0x2f>

00000287 <__do_global_dtors_aux+0xb>:
     287:	1248           	l32i.n	a4, a2, 4
     289:	0438           	l32i.n	a3, a4, 0
     28b:	444b           	addi.n	a4, a4, 4
     28d:	738c           	beqz.n	a3, 298 <__do_global_dtors_aux+0x1c>
     28f:	1249           	s32i.n	a4, a2, 4
     291:	0003e0        	callx8	a3
     294:	fffbc6        	j	287 <__do_global_dtors_aux+0xb>

00000297 <__do_global_dtors_aux+0x1b>:
	...

00000298 <__do_global_dtors_aux+0x1c>:
     298:	ff5d31        	l32r	a3, c (0 <_text_start>)
     29b:	ff5da1        	l32r	a10, 10 (666c <__FRAME_END__>)
     29e:	438c           	beqz.n	a3, 2a6 <__do_global_dtors_aux+0x2a>
     2a0:	ff5b81        	l32r	a8, c (0 <_text_start>)
     2a3:	0008e0        	callx8	a8
     2a6:	130c           	movi.n	a3, 1
     2a8:	004232        	s8i	a3, a2, 0
     2ab:	f01d           	retw.n

000002ad <__do_global_dtors_aux+0x31>:
     2ad:	000000                                        ...

000002b0 <frame_dummy>:
     2b0:	004136        	entry	a1, 32
     2b3:	ff5821        	l32r	a2, 14 (0 <_text_start>)
     2b6:	ff56a1        	l32r	a10, 10 (666c <__FRAME_END__>)
     2b9:	ff57b1        	l32r	a11, 18 (6684 <frame_dummy.object>)
     2bc:	428c           	beqz.n	a2, 2c4 <frame_dummy+0x14>
     2be:	ff5581        	l32r	a8, 14 (0 <_text_start>)
     2c1:	0008e0        	callx8	a8

000002c4 <frame_dummy+0x14>:
     2c4:	f01d           	retw.n

000002c6 <frame_dummy+0x16>:
	...

000002c8 <common_ECNR_PARA_init_v2>:
     2c8:	004136        	entry	a1, 32
     2cb:	ff5441        	l32r	a4, 1c (5d9c <xt_memcpy>)
     2ce:	b32b           	addi.n	a11, a3, 2
     2d0:	a28b           	addi.n	a10, a2, 8
     2d2:	79a0c2        	movi	a12, 121
     2d5:	0004e0        	callx8	a4
     2d8:	fca052        	movi	a5, 252
     2db:	f4a062        	movi	a6, 244
     2de:	a25a           	add.n	a10, a2, a5
     2e0:	b36a           	add.n	a11, a3, a6
     2e2:	5c0c           	movi.n	a12, 5
     2e4:	0004e0        	callx8	a4
     2e7:	08a152        	movi	a5, 0x108
     2ea:	fea062        	movi	a6, 254
     2ed:	a25a           	add.n	a10, a2, a5
     2ef:	b36a           	add.n	a11, a3, a6
     2f1:	d7a0c2        	movi	a12, 215
     2f4:	0004e0        	callx8	a4
     2f7:	b8a252        	movi	a5, 0x2b8
     2fa:	aca262        	movi	a6, 0x2ac
     2fd:	a25a           	add.n	a10, a2, a5
     2ff:	b36a           	add.n	a11, a3, a6
     301:	6c3c           	movi.n	a12, 54
     303:	0004e0        	callx8	a4
     306:	ff4631        	l32r	a3, 20 (7318 <p_ecnr_mem>)
     309:	0338           	l32i.n	a3, a3, 0
     30b:	0239           	s32i.n	a3, a2, 0
     30d:	f01d           	retw.n

0000030f <common_ECNR_PARA_init_v2+0x47>:
	...

00000310 <TX_ECNR_PARA_init>:
     310:	004136        	entry	a1, 32
     313:	ff4341        	l32r	a4, 20 (7318 <p_ecnr_mem>)
     316:	ff4351        	l32r	a5, 24 (7310 <aec_nr_para>)
     319:	ff4361        	l32r	a6, 28 (2c8 <common_ECNR_PARA_init_v2>)
     31c:	04a8           	l32i.n	a10, a4, 0
     31e:	03bd           	mov.n	a11, a3
     320:	05a9           	s32i.n	a10, a5, 0
     322:	0006e0        	callx8	a6
     325:	0568           	l32i.n	a6, a5, 0
     327:	0478           	l32i.n	a7, a4, 0
     329:	04a182        	movi	a8, 0x104
     32c:	02a192        	movi	a9, 0x102
     32f:	6d5c           	movi.n	a13, 86
     331:	939820        	movnez	a9, a8, a2
     334:	15dd22        	addmi	a2, a13, 0x1500
     337:	0496b2        	l16si	a11, a6, 8
     33a:	15d7c2        	addmi	a12, a7, 0x1500
     33d:	325cb2        	s16i	a11, a12, 100
     340:	baa1e2        	movi	a14, 0x1ba
     343:	969a           	add.n	a9, a6, a9
     345:	a72a           	add.n	a10, a7, a2
     347:	ff3521        	l32r	a2, 1c (5d9c <xt_memcpy>)
     34a:	29fd           	ae_l16si.n	a15, a9, 0
     34c:	b6ea           	add.n	a11, a6, a14
     34e:	4c0c           	movi.n	a12, 4
     350:	0256f2        	s16i	a15, a6, 4
     353:	0002e0        	callx8	a2
     356:	0558           	l32i.n	a5, a5, 0
     358:	0448           	l32i.n	a4, a4, 0
     35a:	24a362        	movi	a6, 0x324
     35d:	db15e2        	l16ui	a14, a5, 0x1b6
     360:	4ea372        	movi	a7, 0x34e
     363:	78a0f2        	movi	a15, 120
     366:	b37a           	add.n	a11, a3, a7
     368:	a56a           	add.n	a10, a5, a6
     36a:	3c0c           	movi.n	a12, 3
     36c:	35d442        	addmi	a4, a4, 0x3500
     36f:	433ef0        	min	a3, a14, a15
     372:	225432        	s16i	a3, a4, 68
     375:	0002e0        	callx8	a2
     378:	f01d           	retw.n

0000037a <TX_ECNR_PARA_init+0x6a>:
	...

0000037c <RX_ECNR_PARA_init>:
     37c:	004136        	entry	a1, 32
     37f:	ff2861        	l32r	a6, 20 (7318 <p_ecnr_mem>)
     382:	ff2851        	l32r	a5, 24 (7310 <aec_nr_para>)
     385:	03bd           	mov.n	a11, a3
     387:	06a8           	l32i.n	a10, a6, 0
     389:	ff2761        	l32r	a6, 28 (2c8 <common_ECNR_PARA_init_v2>)
     38c:	05a9           	s32i.n	a10, a5, 0
     38e:	0006e0        	callx8	a6
     391:	0538           	l32i.n	a3, a5, 0
     393:	2aa362        	movi	a6, 0x32a
     396:	b42b           	addi.n	a11, a4, 2
     398:	a36a           	add.n	a10, a3, a6
     39a:	02ac           	beqz.n	a2, 3be <RX_ECNR_PARA_init+0x42>
     39c:	ff2021        	l32r	a2, 1c (5d9c <xt_memcpy>)
     39f:	80a0c2        	movi	a12, 128
     3a2:	0002e0        	callx8	a2
     3a5:	0528           	l32i.n	a2, a5, 0
     3a7:	2aa432        	movi	a3, 0x42a
     3aa:	80a042        	movi	a4, 128
     3ad:	1f0c           	movi.n	a15, 1
     3af:	802230        	add	a2, a2, a3
     3b2:	113f40        	slli	a3, a15, 12
     3b5:	038476        	loop	a4, 3bc <RX_ECNR_PARA_init+0x40>
     3b8:	623d           	ae_s16i.n	a3, a2, 0
     3ba:	222b           	addi.n	a2, a2, 2

000003bc <RX_ECNR_PARA_init+0x40>:
     3bc:	f01d           	retw.n

000003be <RX_ECNR_PARA_init+0x42>:
     3be:	ff1721        	l32r	a2, 1c (5d9c <xt_memcpy>)
     3c1:	00a1c2        	movi	a12, 0x100
     3c4:	0002e0        	callx8	a2
     3c7:	f01d           	retw.n

000003c9 <RX_ECNR_PARA_init+0x4d>:
     3c9:	00000000                                 .......

000003d0 <comfort_noise_gen_wb2>:
     3d0:	006136        	entry	a1, 48
     3d3:	fc24b3a2fe 	{ l32i	a15, a2, 232; ae_zeroq56	aeq0 }
     3d8:	402232        	l32i	a3, a2, 0x100
     3db:	1139           	s32i.n	a3, a1, 4
     3dd:	fccf32        	addi	a3, a15, -4
     3e0:	624314        	ae_sq32f.iu	aeq0, a3, 4
     3e3:	2f0262        	l8ui	a6, a2, 47
     3e6:	624314        	ae_sq32f.iu	aeq0, a3, 4
     3e9:	6f9242        	l16si	a4, a2, 222
     3ec:	139292        	l16si	a9, a2, 38
     3ef:	624314        	ae_sq32f.iu	aeq0, a3, 4
     3f2:	624314        	ae_sq32f.iu	aeq0, a3, 4
     3f5:	7e26b6        	bltui	a6, 2, 477 <comfort_noise_gen_wb2+0xa7>
     3f8:	ff0ad1        	l32r	a13, 20 (7318 <p_ecnr_mem>)
     3fb:	240b           	addi.n	a2, a4, -1
     3fd:	11e8           	l32i.n	a14, a1, 4
     3ff:	0df8           	l32i.n	a15, a13, 0
     401:	3129           	s32i.n	a2, a1, 12
     403:	2169           	s32i.n	a6, a1, 8
     405:	15df42        	addmi	a4, a15, 0x1500
     408:	301442        	l16ui	a4, a4, 96
     40b:	760b           	addi.n	a7, a6, -1
     40d:	fcce52        	addi	a5, a14, -4
     410:	f67c           	movi.n	a6, -1

00000412 <comfort_noise_gen_wb2+0x42>:
     412:	11f8           	l32i.n	a15, a1, 4
     414:	058d           	mov.n	a8, a5
     416:	31a8           	l32i.n	a10, a1, 12
     418:	a38f60        	movltz	a8, a15, a6
     41b:	08b8           	l32i.n	a11, a8, 0
     41d:	ff0381        	l32r	a8, 2c (488 <HIFI_sqrt>)
     420:	092d           	mov.n	a2, a9
     422:	0008e0        	callx8	a8
     425:	75a0d2        	movi	a13, 117
     428:	029d           	mov.n	a9, a2
     42a:	bbdd22        	addmi	a2, a13, 0xffffbb00
     42d:	f1a3e2        	movi	a14, 0x3f1
     430:	828420        	mull	a8, a4, a2
     433:	b02ee0        	addx8	a2, a14, a14
     436:	824420        	mull	a4, a4, a2
     439:	300844        	ae_cvtp24a16x2.ll	aep0, a8, a4
     43c:	360b34        	ae_cvtq48a32s	aeq0, a11
     43f:	d4e250fa9f 	{ add	a15, a10, a9; ae_mulfq32sp16s.l	aeq1, aeq0, aep0 }
     444:	d4620ff77e 	{ addi	a7, a7, -1; ae_mulfq32sp16s.h	aeq0, aeq0, aep0 }
     449:	fc24fe9f4f 	{ ae_slaasq56s	aeq1, aeq1, a15; nop }
     44e:	fd4c7e8f0f 	{ ae_slaasq56s	aeq0, aeq0, a15; ae_roundsq32sym	aeq1, aeq1 }
     453:	fc4479d31f 	{ ae_sq32f.iu	aeq1, a3, 4; ae_roundsq32sym	aeq0, aeq0 }
     458:	554b           	addi.n	a5, a5, 4
     45a:	661b           	addi.n	a6, a6, 1
     45c:	624314        	ae_sq32f.iu	aeq0, a3, 4
     45f:	faf756        	bnez	a7, 412 <comfort_noise_gen_wb2+0x42>
     462:	feef21        	l32r	a2, 20 (7318 <p_ecnr_mem>)
     465:	2168           	l32i.n	a6, a1, 8
     467:	fc24807e5f 	{ movi	a5, 126; ae_zeroq56	aeq0 }
     46c:	0228           	l32i.n	a2, a2, 0
     46e:	15d222        	addmi	a2, a2, 0x1500
     471:	305242        	s16i	a4, a2, 96
     474:	0e3567        	bltu	a5, a6, 486 <comfort_noise_gen_wb2+0xb6>
     477:	7fa022        	movi	a2, 127
     47a:	c02260        	sub	a2, a2, a6
     47d:	058276        	loop	a2, 486 <comfort_noise_gen_wb2+0xb6>
     480:	624314        	ae_sq32f.iu	aeq0, a3, 4
     483:	624314        	ae_sq32f.iu	aeq0, a3, 4

00000486 <comfort_noise_gen_wb2+0xb6>:
     486:	f01d           	retw.n

00000488 <HIFI_sqrt>:
     488:	004136        	entry	a1, 32
     48b:	4b13a6        	blti	a3, 1, 4da <HIFI_sqrt+0x52>
     48e:	40e340        	nsa	a4, a3
     491:	c02240        	sub	a2, a2, a4
     494:	401400        	ssl	a4
     497:	044020        	extui	a4, a2, 0, 1
     49a:	a1c300        	sll	a12, a3
     49d:	400400        	ssr	a4
     4a0:	b130c0        	sra	a3, a12
     4a3:	656930        	extui	a6, a3, 25, 7
     4a6:	fee2d1        	l32r	a13, 30 (6910 <TABLE_SQRT>)
     4a9:	050c           	movi.n	a5, 0
     4ab:	f0c662        	addi	a6, a6, -16
     4ae:	535650        	max	a5, a6, a5
     4b1:	9055d0        	addx2	a5, a5, a13
     4b4:	456d           	ae_l16ui.n	a6, a5, 0
     4b6:	355d           	ae_l16si.n	a5, a5, 2
     4b8:	413930        	srli	a3, a3, 9
     4bb:	11f600        	slli	a15, a6, 16
     4be:	c0e560        	sub	a14, a5, a6
     4c1:	300334        	ae_cvtp24a16x2.ll	aep0, a3, a3
     4c4:	113e00        	slli	a3, a14, 16
     4c7:	360f34        	ae_cvtq48a32s	aeq0, a15
     4ca:	364334        	ae_cvtq48a32s	aeq1, a3
     4cd:	d4e110242f 	{ add	a2, a4, a2; ae_mulaq32sp16u.l	aeq0, aeq1, aep0 }
     4d2:	212120        	srai	a2, a2, 1
     4d5:	368304        	ae_trunca32q48	a3, aeq0
     4d8:	f01d           	retw.n

000004da <HIFI_sqrt+0x52>:
     4da:	020c           	movi.n	a2, 0
     4dc:	030c           	movi.n	a3, 0
     4de:	f01d           	retw.n

000004e0 <Log2_norm>:
     4e0:	004136        	entry	a1, 32
     4e3:	024d           	mov.n	a4, a2
     4e5:	ff7c           	movi.n	a15, -1
     4e7:	012f10        	slli	a2, a15, 31
     4ea:	3214a6        	blti	a4, 1, 520 <Log2_norm+0x40>
     4ed:	156c           	movi.n	a5, -31
     4ef:	2d2357        	blt	a3, a5, 520 <Log2_norm+0x40>
     4f2:	022c           	movi.n	a2, 32
     4f4:	06a237        	bge	a2, a3, 4fe <Log2_norm+0x1e>
     4f7:	f27c           	movi.n	a2, -1
     4f9:	412120        	srli	a2, a2, 1
     4fc:	f01d           	retw.n

000004fe <Log2_norm+0x1e>:
     4fe:	fecd51        	l32r	a5, 34 (6980 <TABLE_LOG2_1530>)
     501:	552840        	extui	a2, a4, 24, 6
     504:	1122e0        	slli	a2, a2, 2
     507:	603524        	ae_lq32f.xu	aeq0, a5, a2
     50a:	604514        	ae_lq32f.i	aeq1, a5, 4
     50d:	f92ae2044f 	{ ae_movpa24x2	aep0, a4, a4; ae_subq56	aeq1, aeq1, aeq0 }
     512:	030174        	ae_mulaq32sp16u.l	aeq0, aeq1, aep0
     515:	013360        	slli	a3, a3, 26
     518:	368f04        	ae_trunca32q48	a15, aeq0
     51b:	2125f0        	srai	a2, a15, 5
     51e:	223a           	add.n	a2, a2, a3
     520:	f01d           	retw.n

00000522 <Log2_norm+0x42>:
	...

00000524 <siir_safr>:
     524:	004136        	entry	a1, 32
     527:	05a237        	bge	a2, a3, 530 <siir_safr+0xc>
     52a:	440404        	ae_lp16x2f.i	aep0, a4, 0
     52d:	000086        	j	533 <siir_safr+0xf>

00000530 <siir_safr+0xc>:
     530:	440414        	ae_lp16x2f.i	aep0, a4, 4
     533:	360234        	ae_cvtq48a32s	aeq0, a2
     536:	364334        	ae_cvtq48a32s	aeq1, a3
     539:	c10014        	ae_mulzaafq32sp16s.lh	aeq0, aeq0, aep0, aeq1, aep0
     53c:	060934        	ae_roundsq32asym	aeq0, aeq0
     53f:	368204        	ae_trunca32q48	a2, aeq0
     542:	f01d           	retw.n

00000544 <_start>:
     544:	004136        	entry	a1, 32
     547:	febc31        	l32r	a3, 38 (7314 <printf_ptr>)
     54a:	0228           	l32i.n	a2, a2, 0
     54c:	febca1        	l32r	a10, 3c (66ec <export_parameter_array+0x3c>)
     54f:	febcb1        	l32r	a11, 40 (11f8 <get_ec120_memsize>)
     552:	0329           	s32i.n	a2, a3, 0
     554:	0002e0        	callx8	a2
     557:	0328           	l32i.n	a2, a3, 0
     559:	febaa1        	l32r	a10, 44 (6704 <export_parameter_array+0x54>)
     55c:	febbb1        	l32r	a11, 48 (1288 <Voice_EC120_Init>)
     55f:	0002e0        	callx8	a2
     562:	0328           	l32i.n	a2, a3, 0
     564:	febaa1        	l32r	a10, 4c (671b <export_parameter_array+0x6b>)
     567:	febab1        	l32r	a11, 50 (1f34 <Voice_EC120_Prcs>)
     56a:	0002e0        	callx8	a2
     56d:	0328           	l32i.n	a2, a3, 0
     56f:	feb9a1        	l32r	a10, 54 (6732 <export_parameter_array+0x82>)
     572:	feb9b1        	l32r	a11, 58 (1d58 <Voice_PostEC120_Prcs>)
     575:	0002e0        	callx8	a2
     578:	0328           	l32i.n	a2, a3, 0
     57a:	feb8a1        	l32r	a10, 5c (674d <export_parameter_array+0x9d>)
     57d:	feb8b1        	l32r	a11, 60 (2f30 <EC_REF_GAIN_READBACK>)
     580:	0002e0        	callx8	a2
     583:	0328           	l32i.n	a2, a3, 0
     585:	feb7a1        	l32r	a10, 64 (6768 <export_parameter_array+0xb8>)
     588:	feb8b1        	l32r	a11, 68 (11f0 <get_ECNR_SVN>)
     58b:	0002e0        	callx8	a2
     58e:	0328           	l32i.n	a2, a3, 0
     590:	feb7a1        	l32r	a10, 6c (677b <export_parameter_array+0xcb>)
     593:	feb7b1        	l32r	a11, 70 (1204 <get_ec120_inear_memsize>)
     596:	0002e0        	callx8	a2
     599:	0328           	l32i.n	a2, a3, 0
     59b:	feb6a1        	l32r	a10, 74 (6799 <export_parameter_array+0xe9>)
     59e:	feb6b1        	l32r	a11, 78 (1534 <Voice_EC120_Inear_Init>)
     5a1:	0002e0        	callx8	a2
     5a4:	0328           	l32i.n	a2, a3, 0
     5a6:	feb5a1        	l32r	a10, 7c (67b6 <export_parameter_array+0x106>)
     5a9:	feb5b1        	l32r	a11, 80 (2f14 <Voice_EC120_Inear_Prcs>)
     5ac:	0002e0        	callx8	a2
     5af:	0328           	l32i.n	a2, a3, 0
     5b1:	feb4a1        	l32r	a10, 84 (67d3 <export_parameter_array+0x123>)
     5b4:	feb5b1        	l32r	a11, 88 (2f88 <EC_Inear_REF_GAIN_READBACK>)
     5b7:	0002e0        	callx8	a2
     5ba:	0328           	l32i.n	a2, a3, 0
     5bc:	feb4a1        	l32r	a10, 8c (67f4 <export_parameter_array+0x144>)
     5bf:	feb4b1        	l32r	a11, 90 (2fbc <EC_PreLim_Coef_READBACK>)
     5c2:	0002e0        	callx8	a2
     5c5:	0328           	l32i.n	a2, a3, 0
     5c7:	feb3a1        	l32r	a10, 94 (6812 <export_parameter_array+0x162>)
     5ca:	feb3b1        	l32r	a11, 98 (3010 <DaulMIC_power_Coef_READBACK>)
     5cd:	0002e0        	callx8	a2
     5d0:	0328           	l32i.n	a2, a3, 0
     5d2:	feb2a1        	l32r	a10, 9c (6834 <export_parameter_array+0x184>)
     5d5:	feb2b1        	l32r	a11, a0 (3020 <PostEC120_Info>)
     5d8:	0002e0        	callx8	a2
     5db:	0328           	l32i.n	a2, a3, 0
     5dd:	feb1a1        	l32r	a10, a4 (6849 <export_parameter_array+0x199>)
     5e0:	feb2b1        	l32r	a11, a8 (151c <Voice_EC80_Init>)
     5e3:	0002e0        	callx8	a2
     5e6:	0328           	l32i.n	a2, a3, 0
     5e8:	feb1a1        	l32r	a10, ac (685f <export_parameter_array+0x1af>)
     5eb:	feb1b1        	l32r	a11, b0 (1618 <Voice_EC80_Inear_Init>)
     5ee:	0002e0        	callx8	a2
     5f1:	feb021        	l32r	a2, b4 (66b0 <export_parameter_array>)
     5f4:	f01d           	retw.n

000005f6 <_start+0xb2>:
	...

000005f8 <SBAEC_INIT>:
     5f8:	00a136        	entry	a1, 80
     5fb:	fe8951        	l32r	a5, 20 (7318 <p_ecnr_mem>)
     5fe:	fba442        	movi	a4, 0x4fb
     601:	1144d0        	slli	a4, a4, 3
     604:	0528           	l32i.n	a2, a5, 0
     606:	41a162        	movi	a6, 0x141
     609:	45a172        	movi	a7, 0x145
     60c:	a24a           	add.n	a10, a2, a4
     60e:	feaa41        	l32r	a4, b8 (5d88 <xt_memset>)
     611:	47a132        	movi	a3, 0x147
     614:	0b0c           	movi.n	a11, 0
     616:	30a1c2        	movi	a12, 0x130
     619:	1166b0        	slli	a6, a6, 5
     61c:	1177b0        	slli	a7, a7, 5
     61f:	1133b0        	slli	a3, a3, 5
     622:	71a9           	s32i.n	a10, a1, 28
     624:	0004e0        	callx8	a4
     627:	0588           	l32i.n	a8, a5, 0
     629:	b3a2f2        	movi	a15, 0x2b3
     62c:	115fd0        	slli	a5, a15, 3
     62f:	a85a           	add.n	a10, a8, a5
     631:	0b0c           	movi.n	a11, 0
     633:	a0a2c2        	movi	a12, 0x2a0
     636:	0004e0        	callx8	a4
     639:	fe7ab1        	l32r	a11, 24 (7310 <aec_nr_para>)
     63c:	c90c           	movi.n	a9, 12
     63e:	051c           	movi.n	a5, 16
     640:	0b48           	l32i.n	a4, a11, 0
     642:	041482        	l16ui	a8, a4, 8
     645:	109890        	and	a9, a8, a9
     648:	04a926        	beqi	a9, 12, 650 <SBAEC_INIT+0x58>
     64b:	109850        	and	a9, a8, a5
     64e:	499c           	beqz.n	a9, 666 <SBAEC_INIT+0x6e>

00000650 <SBAEC_INIT+0x58>:
     650:	797c           	movi.n	a9, -9
     652:	1314a2        	l16ui	a10, a4, 38
     655:	f49090        	extui	a9, a9, 0, 16
     658:	109890        	and	a9, a8, a9
     65b:	881c           	movi.n	a8, 24
     65d:	045492        	s16i	a9, a4, 8
     660:	023a87        	bltu	a10, a8, 666 <SBAEC_INIT+0x6e>
     663:	135482        	s16i	a8, a4, 38
     666:	e31482        	l16ui	a8, a4, 0x1c6
     669:	43a1e2        	movi	a14, 0x143
     66c:	a26a           	add.n	a10, a2, a6
     66e:	116eb0        	slli	a6, a14, 5
     671:	926a           	add.n	a9, a2, a6
     673:	27d252        	addmi	a5, a2, 0x2700
     676:	f27a           	add.n	a15, a2, a7
     678:	323a           	add.n	a3, a2, a3
     67a:	0b6d           	mov.n	a6, a11
     67c:	b159           	s32i.n	a5, a1, 44
     67e:	4139           	s32i.n	a3, a1, 16
     680:	31f9           	s32i.n	a15, a1, 12
     682:	8199           	s32i.n	a9, a1, 32
     684:	51a9           	s32i.n	a10, a1, 20
     686:	68bc           	beqz.n	a8, 6c0 <SBAEC_INIT+0xc8>
     688:	347080        	extui	a7, a8, 0, 4
     68b:	349480        	extui	a9, a8, 4, 4
     68e:	131432        	l16ui	a3, a4, 38
     691:	1177e0        	slli	a7, a7, 2
     694:	34a880        	extui	a10, a8, 8, 4
     697:	1199d0        	slli	a9, a9, 3
     69a:	11cae0        	slli	a12, a10, 2
     69d:	a98b           	addi.n	a10, a9, 8
     69f:	774b           	addi.n	a7, a7, 4
     6a1:	41dc80        	srli	a13, a8, 12
     6a4:	4b0c           	movi.n	a11, 4
     6a6:	a08db0        	addx4	a8, a13, a11
     6a9:	9c4b           	addi.n	a9, a12, 4
     6ab:	433370        	min	a3, a3, a7
     6ae:	41e1a0        	srli	a14, a10, 1
     6b1:	4333e0        	min	a3, a3, a14
     6b4:	43f980        	min	a15, a9, a8
     6b7:	4333f0        	min	a3, a3, a15
     6ba:	135432        	s16i	a3, a4, 38
     6bd:	0001c6        	j	6c8 <SBAEC_INIT+0xd0>

000006c0 <SBAEC_INIT+0xc8>:
     6c0:	082c           	movi.n	a8, 32
     6c2:	891c           	movi.n	a9, 24
     6c4:	0a3c           	movi.n	a10, 48
     6c6:	074c           	movi.n	a7, 64
     6c8:	2ad232        	addmi	a3, a2, 0x2a00
     6cb:	daa0f2        	movi	a15, 218
     6ce:	1753a2        	s16i	a10, a3, 46
     6d1:	27dfa2        	addmi	a10, a15, 0x2700
     6d4:	b4eb           	addi.n	a11, a4, 14
     6d6:	fe5141        	l32r	a4, 1c (5d9c <xt_memcpy>)
     6d9:	165372        	s16i	a7, a3, 44
     6dc:	a2aa           	add.n	a10, a2, a10
     6de:	ec0c           	movi.n	a12, 14
     6e0:	185392        	s16i	a9, a3, 48
     6e3:	27d252        	addmi	a5, a2, 0x2700
     6e6:	195382        	s16i	a8, a3, 50
     6e9:	2ad272        	addmi	a7, a2, 0x2a00
     6ec:	0004e0        	callx8	a4
     6ef:	6d9582        	l16si	a8, a5, 218
     6f2:	06a8           	l32i.n	a10, a6, 0
     6f4:	27d2b2        	addmi	a11, a2, 0x2700
     6f7:	1188f0        	slli	a8, a8, 1
     6fa:	6d5582        	s16i	a8, a5, 218
     6fd:	061a82        	l16ui	a8, a10, 12
     700:	fe6f91        	l32r	a9, bc (155555 <_end+0x14e239>)
     703:	064d           	mov.n	a4, a6
     705:	1158c0        	slli	a5, a8, 4
     708:	c69a62        	l16si	a6, a10, 0x18c
     70b:	7b5b62        	s16i	a6, a11, 246
     70e:	fe44c1        	l32r	a12, 20 (7318 <p_ecnr_mem>)
     711:	3a6b92        	s32i	a9, a11, 232
     714:	3f6b52        	s32i	a5, a11, 252
     717:	6c2a52        	l32i	a5, a10, 0x1b0
     71a:	3e6b52        	s32i	a5, a11, 248
     71d:	0ae8           	l32i.n	a14, a10, 0
     71f:	0cd8           	l32i.n	a13, a12, 0
     721:	b3a2f2        	movi	a15, 0x2b3
     724:	5168           	l32i.n	a6, a1, 20
     726:	115fd0        	slli	a5, a15, 3
     729:	a1b9           	s32i.n	a11, a1, 40
     72b:	fd5a           	add.n	a15, a13, a5
     72d:	04de92        	addmi	a9, a14, 0x400
     730:	91e9           	s32i.n	a14, a1, 36
     732:	fe6381        	l32r	a8, c0 (9d4 <Fill_CH_MEM_WB>)
     735:	81b8           	l32i.n	a11, a1, 32
     737:	31c8           	l32i.n	a12, a1, 12
     739:	41d8           	l32i.n	a13, a1, 16
     73b:	71e8           	l32i.n	a14, a1, 28
     73d:	06ad           	mov.n	a10, a6
     73f:	0199           	s32i.n	a9, a1, 0
     741:	0008e0        	callx8	a8
     744:	fe3751        	l32r	a5, 20 (7318 <p_ecnr_mem>)
     747:	0498           	l32i.n	a9, a4, 0
     749:	29d282        	addmi	a8, a2, 0x2900
     74c:	0558           	l32i.n	a5, a5, 0
     74e:	1693b2        	l16si	a11, a3, 44
     751:	1699c2        	l16si	a12, a9, 44
     754:	15d5a2        	addmi	a10, a5, 0x1500
     757:	15d552        	addmi	a5, a5, 0x1500
     75a:	202552        	l32i	a5, a5, 128
     75d:	1c2aa2        	l32i	a10, a10, 112
     760:	6859           	s32i.n	a5, a8, 24
     762:	fe5851        	l32r	a5, c4 (9b8 <Fill_sbco>)
     765:	58a9           	s32i.n	a10, a8, 20
     767:	1d0c           	movi.n	a13, 1
     769:	06ad           	mov.n	a10, a6
     76b:	0005e0        	callx8	a5
     76e:	1793f2        	l16si	a15, a3, 46
     771:	0468           	l32i.n	a6, a4, 0
     773:	81a8           	l32i.n	a10, a1, 32
     775:	8f1b           	addi.n	a8, a15, 1
     777:	b38ff0        	movgez	a8, a15, a15
     77a:	1796c2        	l16si	a12, a6, 46
     77d:	21b180        	srai	a11, a8, 1
     780:	1d0c           	movi.n	a13, 1
     782:	5139           	s32i.n	a3, a1, 20
     784:	053d           	mov.n	a3, a5
     786:	0005e0        	callx8	a5
     789:	0458           	l32i.n	a5, a4, 0
     78b:	1897b2        	l16si	a11, a7, 48
     78e:	31a8           	l32i.n	a10, a1, 12
     790:	1895c2        	l16si	a12, a5, 48
     793:	1d0c           	movi.n	a13, 1
     795:	0003e0        	callx8	a3
     798:	0458           	l32i.n	a5, a4, 0
     79a:	1997b2        	l16si	a11, a7, 50
     79d:	41a8           	l32i.n	a10, a1, 16
     79f:	1995c2        	l16si	a12, a5, 50
     7a2:	1d0c           	movi.n	a13, 1
     7a4:	6179           	s32i.n	a7, a1, 24
     7a6:	0003e0        	callx8	a3
     7a9:	fe1d31        	l32r	a3, 20 (7318 <p_ecnr_mem>)
     7ac:	0458           	l32i.n	a5, a4, 0
     7ae:	a178           	l32i.n	a7, a1, 40
     7b0:	0388           	l32i.n	a8, a3, 0
     7b2:	041592        	l16ui	a9, a5, 8
     7b5:	1595b2        	l16si	a11, a5, 42
     7b8:	15d8c2        	addmi	a12, a8, 0x1500
     7bb:	2a5cb2        	s16i	a11, a12, 84
     7be:	14b190        	extui	a11, a9, 1, 2
     7c1:	fe4161        	l32r	a6, c8 (7fff7fff <_end+0x7fff0ce3>)
     7c4:	2f5cb2        	s16i	a11, a12, 94
     7c7:	406762        	s32i	a6, a7, 0x100
     7ca:	b178           	l32i.n	a7, a1, 44
     7cc:	2ad2a2        	addmi	a10, a2, 0x2a00
     7cf:	ffa0f2        	movi	a15, 255
     7d2:	254af2        	s8i	a15, a10, 37
     7d5:	049090        	extui	a9, a9, 0, 1
     7d8:	0595d2        	l16si	a13, a5, 10
     7db:	0295e2        	l16si	a14, a5, 4
     7de:	1a2cf2        	l32i	a15, a12, 104
     7e1:	dc9552        	l16si	a5, a5, 0x1b8
     7e4:	105a92        	s16i	a9, a10, 32
     7e7:	115ad2        	s16i	a13, a10, 34
     7ea:	6c57e2        	s16i	a14, a7, 216
     7ed:	aaf9           	s32i.n	a15, a10, 40
     7ef:	135a52        	s16i	a5, a10, 38
     7f2:	022b26        	beqi	a11, 2, 7f8 <SBAEC_INIT+0x200>
     7f5:	003546        	j	8ce <SBAEC_INIT+0x2d6>
     7f8:	5178           	l32i.n	a7, a1, 20
     7fa:	61e8           	l32i.n	a14, a1, 24
     7fc:	9148           	l32i.n	a4, a1, 36
     7fe:	169762        	l16si	a6, a7, 44
     801:	189e32        	l16si	a3, a14, 48
     804:	199ee2        	l16si	a14, a14, 50
     807:	1797b2        	l16si	a11, a7, 46
     80a:	49a1f2        	movi	a15, 0x149
     80d:	4da1d2        	movi	a13, 0x14d
     810:	4fa1a2        	movi	a10, 0x14f
     813:	18a5c2        	movi	a12, 0x518
     816:	4ba152        	movi	a5, 0x14b
     819:	94ca           	add.n	a9, a4, a12
     81b:	11ddb0        	slli	a13, a13, 5
     81e:	11ffb0        	slli	a15, a15, 5
     821:	4b6a           	add.n	a4, a11, a6
     823:	11aab0        	slli	a10, a10, 5
     826:	e3ea           	add.n	a14, a3, a14
     828:	c2da           	add.n	a12, a2, a13
     82a:	d2aa           	add.n	a13, a2, a10
     82c:	a4ea           	add.n	a10, a4, a14
     82e:	1155b0        	slli	a5, a5, 5
     831:	62fa           	add.n	a6, a2, a15
     833:	b3a2f2        	movi	a15, 0x2b3
     836:	b25a           	add.n	a11, a2, a5
     838:	a08a80        	addx4	a8, a10, a8
     83b:	115fd0        	slli	a5, a15, 3
     83e:	f85a           	add.n	a15, a8, a5
     840:	71e8           	l32i.n	a14, a1, 28
     842:	fe1f51        	l32r	a5, c0 (9d4 <Fill_CH_MEM_WB>)
     845:	06ad           	mov.n	a10, a6
     847:	31c9           	s32i.n	a12, a1, 12
     849:	41d9           	s32i.n	a13, a1, 16
     84b:	0b4d           	mov.n	a4, a11
     84d:	0199           	s32i.n	a9, a1, 0
     84f:	0005e0        	callx8	a5
     852:	fdf331        	l32r	a3, 20 (7318 <p_ecnr_mem>)
     855:	28d292        	addmi	a9, a2, 0x2800
     858:	162992        	l32i	a9, a9, 88
     85b:	28d2f2        	addmi	a15, a2, 0x2800
     85e:	0388           	l32i.n	a8, a3, 0
     860:	566f92        	s32i	a9, a15, 0x158
     863:	262f92        	l32i	a9, a15, 152
     866:	666f92        	s32i	a9, a15, 0x198
     869:	fdee31        	l32r	a3, 24 (7310 <aec_nr_para>)
     86c:	362fa2        	l32i	a10, a15, 216
     86f:	15d8e2        	addmi	a14, a8, 0x1500
     872:	03d8           	l32i.n	a13, a3, 0
     874:	15d882        	addmi	a8, a8, 0x1500
     877:	766fa2        	s32i	a10, a15, 0x1d8
     87a:	2ad252        	addmi	a5, a2, 0x2a00
     87d:	1e2ea2        	l32i	a10, a14, 120
     880:	2028f2        	l32i	a15, a8, 128
     883:	55a9           	s32i.n	a10, a5, 20
     885:	1a9dc2        	l16si	a12, a13, 52
     888:	65f9           	s32i.n	a15, a5, 24
     88a:	1697b2        	l16si	a11, a7, 44
     88d:	fe0d51        	l32r	a5, c4 (9b8 <Fill_sbco>)
     890:	0d0c           	movi.n	a13, 0
     892:	06ad           	mov.n	a10, a6
     894:	0005e0        	callx8	a5
     897:	179722        	l16si	a2, a7, 46
     89a:	03f8           	l32i.n	a15, a3, 0
     89c:	0d0c           	movi.n	a13, 0
     89e:	621b           	addi.n	a6, a2, 1
     8a0:	b36220        	movgez	a6, a2, a2
     8a3:	1b9fc2        	l16si	a12, a15, 54
     8a6:	21b160        	srai	a11, a6, 1
     8a9:	04ad           	mov.n	a10, a4
     8ab:	0005e0        	callx8	a5
     8ae:	0328           	l32i.n	a2, a3, 0
     8b0:	6148           	l32i.n	a4, a1, 24
     8b2:	31a8           	l32i.n	a10, a1, 12
     8b4:	1c92c2        	l16si	a12, a2, 56
     8b7:	1894b2        	l16si	a11, a4, 48
     8ba:	0d0c           	movi.n	a13, 0
     8bc:	0005e0        	callx8	a5
     8bf:	0328           	l32i.n	a2, a3, 0
     8c1:	1994b2        	l16si	a11, a4, 50
     8c4:	41a8           	l32i.n	a10, a1, 16
     8c6:	1d92c2        	l16si	a12, a2, 58
     8c9:	0d0c           	movi.n	a13, 0
     8cb:	0005e0        	callx8	a5
     8ce:	f01d           	retw.n

000008d0 <SBAEC_INIT_inear>:
     8d0:	008136        	entry	a1, 64
     8d3:	fdd471        	l32r	a7, 24 (7310 <aec_nr_para>)
     8d6:	fba432        	movi	a3, 0x4fb
     8d9:	35d252        	addmi	a5, a2, 0x3500
     8dc:	07c8           	l32i.n	a12, a7, 0
     8de:	1133d0        	slli	a3, a3, 3
     8e1:	2c2572        	l32i	a7, a5, 176
     8e4:	e23a           	add.n	a14, a2, a3
     8e6:	0c38           	l32i.n	a3, a12, 0
     8e8:	38a342        	movi	a4, 0x338
     8eb:	78a362        	movi	a6, 0x378
     8ee:	b8a382        	movi	a8, 0x3b8
     8f1:	f8a392        	movi	a9, 0x3f8
     8f4:	90a0a2        	movi	a10, 144
     8f7:	e0a5b2        	movi	a11, 0x5e0
     8fa:	574a           	add.n	a5, a7, a4
     8fc:	476a           	add.n	a4, a7, a6
     8fe:	fdf061        	l32r	a6, c0 (9d4 <Fill_CH_MEM_WB>)
     901:	33ba           	add.n	a3, a3, a11
     903:	c78a           	add.n	a12, a7, a8
     905:	d79a           	add.n	a13, a7, a9
     907:	f7aa           	add.n	a15, a7, a10
     909:	05ad           	mov.n	a10, a5
     90b:	04bd           	mov.n	a11, a4
     90d:	5149           	s32i.n	a4, a1, 20
     90f:	61c9           	s32i.n	a12, a1, 24
     911:	71d9           	s32i.n	a13, a1, 28
     913:	0139           	s32i.n	a3, a1, 0
     915:	0006e0        	callx8	a6
     918:	fdc341        	l32r	a4, 24 (7310 <aec_nr_para>)
     91b:	15d282        	addmi	a8, a2, 0x1500
     91e:	04d762        	addmi	a6, a7, 0x400
     921:	202882        	l32i	a8, a8, 128
     924:	04d8           	l32i.n	a13, a4, 0
     926:	28d292        	addmi	a9, a2, 0x2800
     929:	c689           	s32i.n	a8, a6, 48
     92b:	05d732        	addmi	a3, a7, 0x500
     92e:	162992        	l32i	a9, a9, 88
     931:	2338           	l32i.n	a3, a3, 8
     933:	28d2f2        	addmi	a15, a2, 0x2800
     936:	dc6792        	s32i	a9, a7, 0x370
     939:	b639           	s32i.n	a3, a6, 44
     93b:	262f32        	l32i	a3, a15, 152
     93e:	02dde2        	addmi	a14, a13, 0x200
     941:	2ad262        	addmi	a6, a2, 0x2a00
     944:	ec6732        	s32i	a3, a7, 0x3b0
     947:	1696b2        	l16si	a11, a6, 44
     94a:	579ec2        	l16si	a12, a14, 174
     94d:	fddd31        	l32r	a3, c4 (9b8 <Fill_sbco>)
     950:	362ff2        	l32i	a15, a15, 216
     953:	4d0c           	movi.n	a13, 4
     955:	05ad           	mov.n	a10, a5
     957:	fc67f2        	s32i	a15, a7, 0x3f0
     95a:	0003e0        	callx8	a3
     95d:	0488           	l32i.n	a8, a4, 0
     95f:	179652        	l16si	a5, a6, 46
     962:	51a8           	l32i.n	a10, a1, 20
     964:	02d882        	addmi	a8, a8, 0x200
     967:	951b           	addi.n	a9, a5, 1
     969:	b39550        	movgez	a9, a5, a5
     96c:	5898c2        	l16si	a12, a8, 176
     96f:	21b190        	srai	a11, a9, 1
     972:	4d0c           	movi.n	a13, 4
     974:	0003e0        	callx8	a3
     977:	04f8           	l32i.n	a15, a4, 0
     979:	2ad222        	addmi	a2, a2, 0x2a00
     97c:	045d           	mov.n	a5, a4
     97e:	02df42        	addmi	a4, a15, 0x200
     981:	1892b2        	l16si	a11, a2, 48
     984:	5994c2        	l16si	a12, a4, 178
     987:	61a8           	l32i.n	a10, a1, 24
     989:	4d0c           	movi.n	a13, 4
     98b:	0003e0        	callx8	a3
     98e:	0548           	l32i.n	a4, a5, 0
     990:	1992b2        	l16si	a11, a2, 50
     993:	71a8           	l32i.n	a10, a1, 28
     995:	02d4f2        	addmi	a15, a4, 0x200
     998:	5a9fc2        	l16si	a12, a15, 180
     99b:	4d0c           	movi.n	a13, 4
     99d:	0003e0        	callx8	a3
     9a0:	0538           	l32i.n	a3, a5, 0
     9a2:	f6a422        	movi	a2, 0x4f6
     9a5:	88a242        	movi	a4, 0x288
     9a8:	a72a           	add.n	a10, a7, a2
     9aa:	fd9c21        	l32r	a2, 1c (5d9c <xt_memcpy>)
     9ad:	b34a           	add.n	a11, a3, a4
     9af:	3c0c           	movi.n	a12, 3
     9b1:	0002e0        	callx8	a2
     9b4:	d679           	s32i.n	a7, a6, 52
     9b6:	f01d           	retw.n

000009b8 <Fill_sbco>:
     9b8:	004136        	entry	a1, 32
     9bb:	ffa062        	movi	a6, 255
     9be:	11f400        	slli	a15, a4, 16
     9c1:	7fd662        	addmi	a6, a6, 0x7f00
     9c4:	115232        	s16i	a3, a2, 34
     9c7:	105262        	s16i	a6, a2, 32
     9ca:	125252        	s16i	a5, a2, 36
     9cd:	52f9           	s32i.n	a15, a2, 20
     9cf:	42f9           	s32i.n	a15, a2, 16
     9d1:	f01d           	retw.n

000009d3 <Fill_sbco+0x1b>:
	...

000009d4 <Fill_CH_MEM_WB>:
     9d4:	004136        	entry	a1, 32
     9d7:	8188           	l32i.n	a8, a1, 32
     9d9:	8ca092        	movi	a9, 140
     9dc:	a0a0a2        	movi	a10, 160
     9df:	50c8f2        	addi	a15, a8, 80
     9e2:	c8a0b2        	movi	a11, 200
     9e5:	f0a0c2        	movi	a12, 240
     9e8:	d389           	s32i.n	a8, a3, 52
     9ea:	28c8d2        	addi	a13, a8, 40
     9ed:	d2f9           	s32i.n	a15, a2, 52
     9ef:	04a1f2        	movi	a15, 0x104
     9f2:	f3d9           	s32i.n	a13, a3, 60
     9f4:	64c8e2        	addi	a14, a8, 100
     9f7:	b8ba           	add.n	a11, a8, a11
     9f9:	989a           	add.n	a9, a8, a9
     9fb:	a8aa           	add.n	a10, a8, a10
     9fd:	c8ca           	add.n	a12, a8, a12
     9ff:	d8fa           	add.n	a13, a8, a15
     a01:	78c882        	addi	a8, a8, 120
     a04:	f289           	s32i.n	a8, a2, 60
     a06:	f499           	s32i.n	a9, a4, 60
     a08:	58c692        	addi	a9, a6, 88
     a0b:	d4e9           	s32i.n	a14, a4, 52
     a0d:	fe99e2        	l16si	a14, a9, 0x1fc
     a10:	f5a9           	s32i.n	a10, a5, 60
     a12:	5cc6a2        	addi	a10, a6, 92
     a15:	ff9982        	l16si	a8, a9, 0x1fe
     a18:	fe9af2        	l16si	a15, a10, 0x1fc
     a1b:	e3b9           	s32i.n	a11, a3, 56
     a1d:	ff9a62        	l16si	a6, a10, 0x1fe
     a20:	90be70        	addx2	a11, a14, a7
     a23:	a279           	s32i.n	a7, a2, 40
     a25:	9078b0        	addx2	a7, a8, a11
     a28:	a3b9           	s32i.n	a11, a3, 40
     a2a:	a479           	s32i.n	a7, a4, 40
     a2c:	907f70        	addx2	a7, a15, a7
     a2f:	906670        	addx2	a6, a6, a7
     a32:	b269           	s32i.n	a6, a2, 44
     a34:	906e60        	addx2	a6, a14, a6
     a37:	a579           	s32i.n	a7, a5, 40
     a39:	b369           	s32i.n	a6, a3, 44
     a3b:	906860        	addx2	a6, a8, a6
     a3e:	e2c9           	s32i.n	a12, a2, 56
     a40:	e4d9           	s32i.n	a13, a4, 56
     a42:	a3c8           	l32i.n	a12, a3, 40
     a44:	a2d8           	l32i.n	a13, a2, 40
     a46:	a4e8           	l32i.n	a14, a4, 40
     a48:	90ff60        	addx2	a15, a15, a6
     a4b:	c3c9           	s32i.n	a12, a3, 48
     a4d:	c2d9           	s32i.n	a13, a2, 48
     a4f:	c4e9           	s32i.n	a14, a4, 48
     a51:	b469           	s32i.n	a6, a4, 44
     a53:	c579           	s32i.n	a7, a5, 48
     a55:	b5f9           	s32i.n	a15, a5, 44
     a57:	f01d           	retw.n

00000a59 <Fill_CH_MEM_WB+0x85>:
     a59:	000000                                        ...

00000a5c <common_x_pow>:
     a5c:	004136        	entry	a1, 32
     a5f:	360334        	ae_cvtq48a32s	aeq0, a3
     a62:	fe00bec47f 	{ ae_cvtq48a32s	aeq1, a4; ae_absq56	aeq2, aeq0 }
     a67:	ff0480005f 	{ movi	a5, 0; ae_absq56	aeq3, aeq1 }
     a6c:	d6d80001ff 	{ movi	a15, 1; ae_ltq56s	b0, aeq2, aeq3 }
     a71:	023d           	mov.n	a3, a2
     a73:	120c           	movi.n	a2, 1
     a75:	d35f00        	movt	a5, a15, b0
     a78:	65ac           	beqz.n	a5, aa2 <common_x_pow+0x46>
     a7a:	f9bac0004f 	{ movi	a4, 0; ae_subq56	aeq1, aeq3, aeq2 }
     a7f:	0122b0        	slli	a2, a2, 21
     a82:	36c234        	ae_cvtq48a32s	aeq3, a2
     a85:	d6cc0001ff 	{ movi	a15, 1; ae_ltq56s	b0, aeq3, aeq1 }
     a8a:	120c           	movi.n	a2, 1
     a8c:	fd9051        	l32r	a5, cc (2aaa00 <_end+0x2a36e4>)
     a8f:	fd04564f0f 	{ movt	a4, a15, b0; ae_movq56	aeq1, aeq0 }
     a94:	c48c           	beqz.n	a4, aa4 <common_x_pow+0x48>
     a96:	398554        	ae_movpa24x2	aep0, a5, a5
     a99:	030a14        	ae_mulfq32sp16s.l	aeq1, aeq0, aep0
     a9c:	065934        	ae_roundsq32asym	aeq1, aeq1
     a9f:	000046        	j	aa4 <common_x_pow+0x48>

00000aa2 <common_x_pow+0x46>:
     aa2:	020c           	movi.n	a2, 0
     aa4:	fd8b41        	l32r	a4, d0 (6880 <immediate_num>)
     aa7:	608324        	ae_lq32f.i	aeq2, a3, 8
     aaa:	60c334        	ae_lq32f.i	aeq3, a3, 12
     aad:	440404        	ae_lp16x2f.i	aep0, a4, 0
     ab0:	c10084        	ae_mulzaafq32sp16s.lh	aeq0, aeq2, aep0, aeq0, aep0
     ab3:	c108d4        	ae_mulzaafq32sp16s.lh	aeq1, aeq3, aep0, aeq1, aep0
     ab6:	060934        	ae_roundsq32asym	aeq0, aeq0
     ab9:	fd2c79832f 	{ ae_sq32f.i	aeq0, a3, 8; ae_roundsq32asym	aeq1, aeq1 }
     abe:	621334        	ae_sq32f.i	aeq1, a3, 12
     ac1:	f01d           	retw.n

00000ac3 <common_x_pow+0x67>:
	...

00000ac4 <ref_gain_adapt>:
     ac4:	004136        	entry	a1, 32
     ac7:	5378           	l32i.n	a7, a3, 20
     ac9:	fd8161        	l32r	a6, d0 (6880 <immediate_num>)
     acc:	360734        	ae_cvtq48a32s	aeq0, a7
     acf:	03b5d6        	bgez	a5, b0e <ref_gain_adapt+0x4a>
     ad2:	059252        	l16si	a5, a2, 10
     ad5:	440614        	ae_lp16x2f.i	aep0, a6, 4
     ad8:	364434        	ae_cvtq48a32s	aeq1, a4
     adb:	11d500        	slli	a13, a5, 16
     ade:	d5637ecdbf 	{ ae_cvtq48a32s	aeq2, a13; ae_mulfq32sp16s.h	aeq3, aeq1, aep0 }
     ae3:	0e0c           	movi.n	a14, 0
     ae5:	d6d80001ff 	{ movi	a15, 1; ae_ltq56s	b0, aeq2, aeq3 }
     aea:	040c           	movi.n	a4, 0
     aec:	150c           	movi.n	a5, 1
     aee:	d3ef00        	movt	a14, a15, b0
     af1:	0edc           	bnez.n	a14, b05 <ref_gain_adapt+0x41>
     af3:	440624        	ae_lp16x2f.i	aep0, a6, 8
     af6:	d56340007f 	{ movi	a7, 0; ae_mulfq32sp16s.h	aeq3, aeq1, aep0 }
     afb:	d6d800018f 	{ movi	a8, 1; ae_ltq56s	b0, aeq2, aeq3 }
     b00:	d34500        	movt	a4, a5, b0
     b03:	24ac           	beqz.n	a4, b29 <ref_gain_adapt+0x65>

00000b05 <ref_gain_adapt+0x41>:
     b05:	a10004        	ae_mulzaafq32sp16s.ll	aeq0, aeq0, aep0, aeq0, aep0
     b08:	060934        	ae_roundsq32asym	aeq0, aeq0
     b0b:	368704        	ae_trunca32q48	a7, aeq0
     b0e:	120c           	movi.n	a2, 1
     b10:	0122b0        	slli	a2, a2, 21
     b13:	532720        	max	a2, a7, a2
     b16:	5329           	s32i.n	a2, a3, 20
     b18:	604344        	ae_lq32f.i	aeq1, a3, 16
     b1b:	440654        	ae_lp16x2f.i	aep0, a6, 20
     b1e:	c10044        	ae_mulzaafq32sp16s.lh	aeq0, aeq1, aep0, aeq0, aep0
     b21:	060934        	ae_roundsq32asym	aeq0, aeq0
     b24:	620344        	ae_sq32f.i	aeq0, a3, 16
     b27:	f01d           	retw.n

00000b29 <ref_gain_adapt+0x65>:
     b29:	440634        	ae_lp16x2f.i	aep0, a6, 12
     b2c:	d76240004f 	{ movi	a4, 0; ae_mulfq32sp16s.h	aeq3, aeq2, aep0 }
     b31:	02d222        	addmi	a2, a2, 0x200
     b34:	d65c00015f 	{ movi	a5, 1; ae_ltq56s	b0, aeq1, aeq3 }
     b39:	038a94        	ae_mulfq32sp16s.l	aeq3, aeq2, aep0
     b3c:	4e0222        	l8ui	a2, a2, 78
     b3f:	d6cc16780f 	{ movt	a7, a8, b0; ae_ltq56s	b0, aeq3, aeq1 }
     b44:	fc0716        	beqz	a7, b08 <ref_gain_adapt+0x44>
     b47:	370c           	movi.n	a7, 3
     b49:	d34500        	movt	a4, a5, b0
     b4c:	14cc           	bnez.n	a4, b51 <ref_gain_adapt+0x8d>
     b4e:	b60727        	bnone	a7, a2, b08 <ref_gain_adapt+0x44>
     b51:	440644        	ae_lp16x2f.i	aep0, a6, 16
     b54:	030214        	ae_mulfq32sp16s.l	aeq0, aeq0, aep0
     b57:	ffeb46        	j	b08 <ref_gain_adapt+0x44>

00000b5a <ref_gain_adapt+0x96>:
	...

00000b5c <aec_post_calc>:
     b5c:	006136        	entry	a1, 48
     b5f:	054466        	bnei	a4, 4, b68 <aec_post_calc+0xc>
     b62:	20c242        	addi	a4, a2, 32
     b65:	000086        	j	b6b <aec_post_calc+0xf>

00000b68 <aec_post_calc+0xc>:
     b68:	1ec242        	addi	a4, a2, 30
     b6b:	150c           	movi.n	a5, 1
     b6d:	0155d0        	slli	a5, a5, 19
     b70:	400404        	ae_lp16f.i	aep0, a4, 0
     b73:	360534        	ae_cvtq48a32s	aeq0, a5
     b76:	1d0c           	movi.n	a13, 1
     b78:	115d00        	slli	a5, a13, 16
     b7b:	d4e2bec5ff 	{ ae_cvtq48a32s	aeq3, a5; ae_mulfq32sp16u.l	aeq0, aeq0, aep0 }
     b80:	23c8           	l32i.n	a12, a3, 8
     b82:	d6e3b9813f 	{ ae_sq32f.i	aeq0, a1, 12; ae_mulfq32sp16u.l	aeq0, aeq3, aep0 }
     b87:	3178           	l32i.n	a7, a1, 12
     b89:	33e8           	l32i.n	a14, a3, 12
     b8b:	620134        	ae_sq32f.i	aeq0, a1, 12
     b8e:	3168           	l32i.n	a6, a1, 12
     b90:	53bc70        	max	a11, a12, a7
     b93:	fd5041        	l32r	a4, d4 (5324 <airoha_divide_limit_1>)
     b96:	53fe60        	max	a15, a14, a6
     b99:	43abf0        	min	a10, a11, a15
     b9c:	0004e0        	callx8	a4
     b9f:	600364        	ae_lq32f.i	aeq0, a3, 24
     ba2:	4c0244        	ae_lp24.i	aep0, a2, 16
     ba5:	379aa4        	ae_truncp24a32x2	aep1, a10, a10
     ba8:	e207a1724e 	{ l16si	a4, a2, 46; ae_mulafp24s.ll	aeq0, aep1, aep0 }
     bad:	f966a0225e 	{ l16si	a5, a2, 4; ae_movp48	aep2, aep1 }
     bb2:	fc2460b27e 	{ l16si	a7, a2, 22; ae_roundsq32asym	aeq0, aeq0 }
     bb7:	620364        	ae_sq32f.i	aeq0, a3, 24
     bba:	18a547        	bge	a5, a4, bd6 <aec_post_calc+0x7a>
     bbd:	0a9242        	l16si	a4, a2, 20
     bc0:	169252        	l16si	a5, a2, 44
     bc3:	060c           	movi.n	a6, 0
     bc5:	742b           	addi.n	a7, a4, 2
     bc7:	725650        	salt	a5, a6, a5
     bca:	837450        	moveqz	a7, a4, a5
     bcd:	031674        	wur.ae_sar	a7
     bd0:	0b10a4        	ae_sllssp24s	aep2, aep1
     bd3:	000506        	j	beb <aec_post_calc+0x8f>

00000bd6 <aec_post_calc+0x7a>:
     bd6:	074d           	mov.n	a4, a7
     bd8:	0f27a6        	blti	a7, 2, beb <aec_post_calc+0x8f>
     bdb:	944d           	ae_zext16	a4, a4
     bdd:	f9668ff44e 	{ addi	a4, a4, -1; ae_movp48	aep2, aep1 }
     be2:	058476        	loop	a4, beb <aec_post_calc+0x8f>
     be5:	012174        	ae_mulfp24s.ll	aeq0, aep2, aep1
     be8:	1b8d24        	ae_roundsp24q48asym	aep2, aeq0

00000beb <aec_post_calc+0x8f>:
     beb:	401274        	ae_lp16f.i	aep1, a2, 14
     bee:	d82a7d037f 	{ ae_lq32f.i	aeq0, a3, 28; ae_maxp24s	aep1, aep2, aep1 }
     bf3:	011034        	ae_mulafp24s.ll	aeq0, aep1, aep0
     bf6:	060934        	ae_roundsq32asym	aeq0, aeq0
     bf9:	620374        	ae_sq32f.i	aeq0, a3, 28
     bfc:	f01d           	retw.n

00000bfe <aec_post_calc+0xa2>:
	...

00000c00 <aec_post_calc_FB>:
     c00:	004136        	entry	a1, 32
     c03:	2358           	l32i.n	a5, a3, 8
     c05:	3378           	l32i.n	a7, a3, 12
     c07:	140c           	movi.n	a4, 1
     c09:	114440        	slli	a4, a4, 12
     c0c:	00a262        	movi	a6, 0x200
     c0f:	53b540        	max	a11, a5, a4
     c12:	53f760        	max	a15, a7, a6
     c15:	fd2f51        	l32r	a5, d4 (5324 <airoha_divide_limit_1>)
     c18:	972242        	l32i	a4, a2, 0x25c
     c1b:	43abf0        	min	a10, a11, a15
     c1e:	0005e0        	callx8	a5
     c21:	04d452        	addmi	a5, a4, 0x400
     c24:	600364        	ae_lq32f.i	aeq0, a3, 24
     c27:	4c0244        	ae_lp24.i	aep0, a2, 16
     c2a:	379aa4        	ae_truncp24a32x2	aep1, a10, a10
     c2d:	e207a0226e 	{ l16si	a6, a2, 4; ae_mulafp24s.ll	aeq0, aep1, aep0 }
     c32:	f966a7e55e 	{ l16si	a5, a5, 252; ae_movp48	aep2, aep1 }
     c37:	fc2460b27e 	{ l16si	a7, a2, 22; ae_roundsq32asym	aeq0, aeq0 }
     c3c:	620364        	ae_sq32f.i	aeq0, a3, 24
     c3f:	1ba657        	bge	a6, a5, c5e <aec_post_calc_FB+0x5e>
     c42:	03d452        	addmi	a5, a4, 0x300
     c45:	0a9222        	l16si	a2, a2, 20
     c48:	ff9552        	l16si	a5, a5, 0x1fe
     c4b:	060c           	movi.n	a6, 0
     c4d:	722b           	addi.n	a7, a2, 2
     c4f:	725650        	salt	a5, a6, a5
     c52:	837250        	moveqz	a7, a2, a5
     c55:	031674        	wur.ae_sar	a7
     c58:	0b10a4        	ae_sllssp24s	aep2, aep1
     c5b:	000506        	j	c73 <aec_post_calc_FB+0x73>

00000c5e <aec_post_calc_FB+0x5e>:
     c5e:	072d           	mov.n	a2, a7
     c60:	0f27a6        	blti	a7, 2, c73 <aec_post_calc_FB+0x73>
     c63:	922d           	ae_zext16	a2, a2
     c65:	f9668ff22e 	{ addi	a2, a2, -1; ae_movp48	aep2, aep1 }
     c6a:	058276        	loop	a2, c73 <aec_post_calc_FB+0x73>
     c6d:	012174        	ae_mulfp24s.ll	aeq0, aep2, aep1
     c70:	1b8d24        	ae_roundsp24q48asym	aep2, aeq0

00000c73 <aec_post_calc_FB+0x73>:
     c73:	f6a422        	movi	a2, 0x4f6
     c76:	411424        	ae_lp16f.x	aep1, a4, a2
     c79:	d82a7d037f 	{ ae_lq32f.i	aeq0, a3, 28; ae_maxp24s	aep1, aep2, aep1 }
     c7e:	011034        	ae_mulafp24s.ll	aeq0, aep1, aep0
     c81:	060934        	ae_roundsq32asym	aeq0, aeq0
     c84:	620374        	ae_sq32f.i	aeq0, a3, 28
     c87:	f01d           	retw.n

00000c89 <aec_post_calc_FB+0x89>:
     c89:	000000                                        ...

00000c8c <subband_aec_block>:
     c8c:	006136        	entry	a1, 48
     c8f:	a378           	l32i.n	a7, a3, 40
     c91:	fd24a1138e 	{ l16si	a8, a3, 34; ae_zeroq56	aeq1 }
     c96:	f41b           	addi.n	a15, a4, 1
     c98:	a3d8           	l32i.n	a13, a3, 40
     c9a:	90e870        	addx2	a14, a8, a7
     c9d:	b3f440        	movgez	a15, a4, a4
     ca0:	21b1f0        	srai	a11, a15, 1
     ca3:	2169           	s32i.n	a6, a1, 8
     ca5:	f3f6d0        	wur.ae_cbegin0	a13
     ca8:	f3f7e0        	wur.ae_cend0	a14
     cab:	2e24a6        	blti	a4, 2, cdd <subband_aec_block+0x51>
     cae:	942262        	l32i	a6, a2, 0x250
     cb1:	e388           	l32i.n	a8, a3, 56
     cb3:	c378           	l32i.n	a7, a3, 48
     cb5:	600344        	ae_lq32f.i	aeq0, a3, 16
     cb8:	490c           	movi.n	a9, 4
     cba:	440804        	ae_lp16x2f.i	aep0, a8, 0
     cbd:	fcc6a2        	addi	a10, a6, -4
     cc0:	198b76        	loop	a11, cdd <subband_aec_block+0x51>
     cc3:	09001aa79f 	{ ae_lp16x2f.c	aep2, a7, a9; ae_mulzaafq32sp16s.hh	aeq2, aeq0, aep0, aeq0, aep0 }
     cc8:	11006d881f 	{ ae_lp16x2f.iu	aep0, a8, 4; ae_mulzaafq32sp16s.ll	aeq3, aeq0, aep0, aeq0, aep0 }
     ccd:	1baf74        	ae_roundsp16q48asym	aep7, aeq2
     cd0:	1bbf14        	ae_roundsp16q48asym	aep1, aeq3
     cd3:	f04a7e715f 	{ ae_selp24.hl	aep1, aep7, aep1; ae_mulssfp24s.hh.ll	aeq1, aep2, aep2 }
     cd8:	e224739a1f 	{ ae_sp16x2f.iu	aep1, a10, 4; ae_mulaafp24s.hh.ll	aeq1, aep1, aep1 }

00000cdd <subband_aec_block+0x51>:
     cdd:	351234        	ae_sraiq56	aeq0, aeq1, 8
     ce0:	618304        	ae_lq56.i	aeq2, a3, 0
     ce3:	f87230926e 	{ l32i	a6, a2, 36; ae_addq56	aeq0, aeq2, aeq0 }
     ce8:	fc00fec6ff 	{ ae_cvtq48a32s	aeq3, a6; ae_satq48s	aeq0, aeq0 }
     ced:	f87b1431bf 	{ s32i.n	a11, a1, 12; ae_maxq56s	aeq0, aeq0, aeq3 }
     cf2:	1129           	s32i.n	a2, a1, 4
     cf4:	630304        	ae_sq56s.i	aeq0, a3, 0
     cf7:	00e5d6        	bgez	a5, d09 <subband_aec_block+0x7d>
     cfa:	109362        	l16si	a6, a3, 32
     cfd:	368b04        	ae_trunca32q48	a11, aeq0
     d00:	11a670        	slli	a10, a6, 9
     d03:	fcf561        	l32r	a6, d8 (521c <airoha_divide>)
     d06:	0006e0        	callx8	a6

00000d09 <subband_aec_block+0x7d>:
     d09:	c388           	l32i.n	a8, a3, 48
     d0b:	7614a6        	blti	a4, 1, d85 <subband_aec_block+0xf9>
     d0e:	1128           	l32i.n	a2, a1, 4
     d10:	b368           	l32i.n	a6, a3, 44
     d12:	f378           	l32i.n	a7, a3, 60
     d14:	d3c8           	l32i.n	a12, a3, 52
     d16:	942222        	l32i	a2, a2, 0x250
     d19:	119392        	l16si	a9, a3, 34
     d1c:	360b34        	ae_cvtq48a32s	aeq0, a11
     d1f:	fec7d2        	addi	a13, a7, -2
     d22:	2b0c           	movi.n	a11, 2
     d24:	fec662        	addi	a6, a6, -2
     d27:	fecce2        	addi	a14, a12, -2
     d2a:	04fd           	mov.n	a15, a4
     d2c:	fec272        	addi	a7, a2, -2
     d2f:	408714        	ae_lp16f.iu	aep0, a7, 2
     d32:	fc24e288bf 	{ ae_sp16f.l.c	aep0, a8, a11; nop }
     d37:	408e14        	ae_lp16f.iu	aep0, a14, 2
     d3a:	fd0c13c66f 	{ or	a12, a6, a6; ae_cvtq48p24s.l	aeq1, aep0 }
     d3f:	0f19a6        	blti	a9, 1, d52 <subband_aec_block+0xc6>
     d42:	408c14        	ae_lp16f.iu	aep0, a12, 2
     d45:	098976        	loop	a9, d52 <subband_aec_block+0xc6>
     d48:	fc24d918bf 	{ ae_lp16f.c	aep1, a8, a11; nop }
     d4d:	ee21ec8c1f 	{ ae_lp16f.iu	aep0, a12, 2; ae_mulsfp24s.ll	aeq1, aep0, aep1 }

00000d52 <subband_aec_block+0xc6>:
     d52:	f86b93c66f 	{ or	a12, a6, a6; ae_roundsp16q48asym	aep0, aeq1 }
     d57:	d4e2728d1f 	{ ae_sp16f.l.iu	aep0, a13, 2; ae_mulfq32sp16s.l	aeq1, aeq0, aep0 }
     d5c:	0205d6        	bgez	a5, d80 <subband_aec_block+0xf4>
     d5f:	fc24fe9a4f 	{ ae_slaasq56s	aeq1, aeq1, a10; nop }
     d64:	1b9d04        	ae_roundsp24q48asym	aep0, aeq1
     d67:	1519a6        	blti	a9, 1, d80 <subband_aec_block+0xf4>
     d6a:	409c14        	ae_lp16f.iu	aep1, a12, 2
     d6d:	0f8976        	loop	a9, d80 <subband_aec_block+0xf4>
     d70:	fd2c1978bf 	{ ae_lp16f.c	aep7, a8, a11; ae_cvtq48p24s.l	aeq1, aep1 }
     d75:	e2e3ec9c1f 	{ ae_lp16f.iu	aep1, a12, 2; ae_mulafp24s.ll	aeq1, aep0, aep7 }
     d7a:	1b9f24        	ae_roundsp16q48asym	aep2, aeq1
     d7d:	422cf4        	ae_sp16f.l.i	aep2, a12, -2
     d80:	ff0b           	addi.n	a15, a15, -1
     d82:	fa9f56        	bnez	a15, d2f <subband_aec_block+0xa3>

00000d85 <subband_aec_block+0xf9>:
     d85:	fe2494c38f 	{ s32i.n	a8, a3, 48; ae_zeroq56	aeq2 }
     d8a:	fc24bf217f 	{ ae_movq56	aeq1, aeq2; ae_zeroq56	aeq0 }
     d8f:	1c24a6        	blti	a4, 2, daf <subband_aec_block+0x123>
     d92:	f378           	l32i.n	a7, a3, 60
     d94:	d328           	l32i.n	a2, a3, 52
     d96:	31f8           	l32i.n	a15, a1, 12
     d98:	fcc772        	addi	a7, a7, -4
     d9b:	fcc262        	addi	a6, a2, -4
     d9e:	0d8f76        	loop	a15, daf <subband_aec_block+0x123>
     da1:	448614        	ae_lp16x2f.iu	aep0, a6, 4
     da4:	e2006d971f 	{ ae_lp16x2f.iu	aep1, a7, 4; ae_mulaafp24s.hh.ll	aeq1, aep0, aep0 }
     da9:	050104        	ae_mulaafp24s.hh.ll	aeq0, aep0, aep1
     dac:	059104        	ae_mulaafp24s.hh.ll	aeq2, aep1, aep1

00000daf <subband_aec_block+0x123>:
     daf:	2128           	l32i.n	a2, a1, 8
     db1:	060c           	movi.n	a6, 0
     db3:	35e134        	ae_sraiq56	aeq3, aeq2, 4
     db6:	0c42a6        	blti	a2, 4, dc6 <subband_aec_block+0x13a>
     db9:	fab6c0006f 	{ movi	a6, 0; ae_subq56	aeq2, aeq2, aeq3 }
     dbe:	d65400012f 	{ movi	a2, 1; ae_ltq56s	b0, aeq1, aeq2 }
     dc3:	d36200        	movt	a6, a2, b0

00000dc6 <subband_aec_block+0x13a>:
     dc6:	355134        	ae_sraiq56	aeq1, aeq1, 4
     dc9:	fd2c7b010f 	{ ae_sraiq56	aeq0, aeq0, 4; ae_roundsq32asym	aeq1, aeq1 }
     dce:	fc247f1bef 	{ ae_trunca32q48	a11, aeq1; ae_roundsq32asym	aeq0, aeq0 }
     dd3:	368c04        	ae_trunca32q48	a12, aeq0
     dd6:	fcc121        	l32r	a2, dc (a5c <common_x_pow>)
     dd9:	03ad           	mov.n	a10, a3
     ddb:	0002e0        	callx8	a2
     dde:	6020a0        	neg	a2, a10
     de1:	0b1627        	beq	a6, a2, df0 <subband_aec_block+0x164>
     de4:	f3a8           	l32i.n	a10, a3, 60
     de6:	d3b8           	l32i.n	a11, a3, 52
     de8:	fc8d21        	l32r	a2, 1c (5d9c <xt_memcpy>)
     deb:	04cd           	mov.n	a12, a4
     ded:	0002e0        	callx8	a2
     df0:	1128           	l32i.n	a2, a1, 4
     df2:	fc24a0d24e 	{ l16si	a4, a2, 26; ae_zeroq56	aeq0 }
     df7:	2324a6        	blti	a4, 2, e1e <subband_aec_block+0x192>
     dfa:	0b2322        	l32i	a2, a3, 44
     dfd:	119362        	l16si	a6, a3, 34
     e00:	01c4e2        	addi	a14, a4, 1
     e03:	b3e440        	movgez	a14, a4, a4
     e06:	902620        	addx2	a2, a6, a2
     e09:	11f4f0        	slli	a15, a4, 1
     e0c:	c022f0        	sub	a2, a2, a15
     e0f:	2161e0        	srai	a6, a14, 1
     e12:	fcc242        	addi	a4, a2, -4
     e15:	058676        	loop	a6, e1e <subband_aec_block+0x192>
     e18:	448414        	ae_lp16x2f.iu	aep0, a4, 4
     e1b:	050004        	ae_mulaafp24s.hh.ll	aeq0, aep0, aep0

00000e1e <subband_aec_block+0x192>:
     e1e:	3328           	l32i.n	a2, a3, 12
     e20:	060c           	movi.n	a6, 0
     e22:	3500b4        	ae_sraiq56	aeq0, aeq0, 2
     e25:	53a260        	max	a10, a2, a6
     e28:	fc247023be 	{ l32i	a11, a3, 8; ae_roundsq32asym	aeq0, aeq0 }
     e2d:	fca921        	l32r	a2, d4 (5324 <airoha_divide_limit_1>)
     e30:	368404        	ae_trunca32q48	a4, aeq0
     e33:	0002e0        	callx8	a2
     e36:	1198           	l32i.n	a9, a1, 4
     e38:	ffa022        	movi	a2, 255
     e3b:	2403f2        	l8ui	a15, a3, 36
     e3e:	049962        	l16si	a6, a9, 8
     e41:	7fd222        	addmi	a2, a2, 0x7f00
     e44:	3170a0        	srai	a7, a10, 16
     e47:	c02270        	sub	a2, a2, a7
     e4a:	536260        	max	a6, a2, a6
     e4d:	05ef17        	bbsi	a15, 1, e56 <subband_aec_block+0x1ca>
     e50:	105362        	s16i	a6, a3, 32
     e53:	000786        	j	e75 <subband_aec_block+0x1e9>

00000e56 <subband_aec_block+0x1ca>:
     e56:	039922        	l16si	a2, a9, 6
     e59:	09ad           	mov.n	a10, a9
     e5b:	03bd           	mov.n	a11, a3
     e5d:	822620        	mull	a2, a6, a2
     e60:	04cd           	mov.n	a12, a4
     e62:	40d222        	addmi	a2, a2, 0x4000
     e65:	412f20        	srli	a2, a2, 15
     e68:	105322        	s16i	a2, a3, 32
     e6b:	fc9d21        	l32r	a2, e0 (ac4 <ref_gain_adapt>)
     e6e:	05dd           	mov.n	a13, a5
     e70:	0002e0        	callx8	a2
     e73:	1198           	l32i.n	a9, a1, 4
     e75:	059922        	l16si	a2, a9, 10
     e78:	069962        	l16si	a6, a9, 12
     e7b:	fc95f1        	l32r	a15, d0 (6880 <immediate_num>)
     e7e:	112200        	slli	a2, a2, 16
     e81:	56a247        	bge	a2, a4, edb <subband_aec_block+0x24f>
     e84:	129322        	l16si	a2, a3, 36
     e87:	250c           	movi.n	a5, 2
     e89:	11e600        	slli	a14, a6, 16
     e8c:	202250        	or	a2, a2, a5
     e8f:	125322        	s16i	a2, a3, 36
     e92:	18cf22        	addi	a2, a15, 24
     e95:	07ae47        	bge	a14, a4, ea0 <subband_aec_block+0x214>
     e98:	400204        	ae_lp16f.i	aep0, a2, 0
     e9b:	000106        	j	ea3 <subband_aec_block+0x217>

00000e9e <subband_aec_block+0x212>:
	...

00000ea0 <subband_aec_block+0x214>:
     ea0:	400214        	ae_lp16f.i	aep0, a2, 2
     ea3:	0d9942        	l16si	a4, a9, 26
     ea6:	3124a6        	blti	a4, 2, edb <subband_aec_block+0x24f>
     ea9:	b328           	l32i.n	a2, a3, 44
     eab:	119352        	l16si	a5, a3, 34
     eae:	e41b           	addi.n	a14, a4, 1
     eb0:	b3e440        	movgez	a14, a4, a4
     eb3:	902520        	addx2	a2, a5, a2
     eb6:	11f4f0        	slli	a15, a4, 1
     eb9:	c042f0        	sub	a4, a2, a15
     ebc:	2161e0        	srai	a6, a14, 1
     ebf:	441404        	ae_lp16x2f.i	aep1, a4, 0
     ec2:	fec452        	addi	a5, a4, -2
     ec5:	128676        	loop	a6, edb <subband_aec_block+0x24f>
     ec8:	011054        	ae_mulfp24s.hl	aeq0, aep1, aep0
     ecb:	ea05ed941f 	{ ae_lp16x2f.iu	aep1, a4, 4; ae_mulfp24s.ll	aeq1, aep1, aep0 }
     ed0:	1b8f24        	ae_roundsp16q48asym	aep2, aeq0
     ed3:	fb6bf2a51f 	{ ae_sp16f.l.iu	aep2, a5, 2; ae_roundsp16q48asym	aep7, aeq1 }
     ed8:	42f514        	ae_sp16f.l.iu	aep7, a5, 2

00000edb <subband_aec_block+0x24f>:
     edb:	129342        	l16si	a4, a3, 36
     ede:	fc8121        	l32r	a2, e4 (b5c <aec_post_calc>)
     ee1:	21c8           	l32i.n	a12, a1, 8
     ee3:	0ce407        	bbsi	a4, 0, ef3 <subband_aec_block+0x267>
     ee6:	106427        	bbci	a4, 2, efa <subband_aec_block+0x26e>
     ee9:	972922        	l32i	a2, a9, 0x25c
     eec:	fc7f41        	l32r	a4, e8 (c00 <aec_post_calc_FB>)
     eef:	728c           	beqz.n	a2, efa <subband_aec_block+0x26e>
     ef1:	042d           	mov.n	a2, a4

00000ef3 <subband_aec_block+0x267>:
     ef3:	09ad           	mov.n	a10, a9
     ef5:	03bd           	mov.n	a11, a3
     ef7:	0002e0        	callx8	a2
     efa:	f01d           	retw.n

00000efc <subband_aec_mid_channel>:
     efc:	006136        	entry	a1, 48
     eff:	a3e8           	l32i.n	a14, a3, 40
     f01:	fd24a1137e 	{ l16si	a7, a3, 34; ae_zeroq56	aeq1 }
     f06:	3159           	s32i.n	a5, a1, 12
     f08:	a398           	l32i.n	a9, a3, 40
     f0a:	e358           	l32i.n	a5, a3, 56
     f0c:	9422f2        	l32i	a15, a2, 0x250
     f0f:	f3f690        	wur.ae_cbegin0	a9
     f12:	c398           	l32i.n	a9, a3, 48
     f14:	a077e0        	addx4	a7, a7, a14
     f17:	a80c           	movi.n	a8, 10
     f19:	f3f770        	wur.ae_cend0	a7
     f1c:	460c           	movi.n	a6, 4
     f1e:	600344        	ae_lq32f.i	aeq0, a3, 16
     f21:	440504        	ae_lp16x2f.i	aep0, a5, 0
     f24:	fccf72        	addi	a7, a15, -4
     f27:	198876        	loop	a8, f44 <subband_aec_mid_channel+0x48>
     f2a:	09001aa96f 	{ ae_lp16x2f.c	aep2, a9, a6; ae_mulzaafq32sp16s.hh	aeq2, aeq0, aep0, aeq0, aep0 }
     f2f:	11006d851f 	{ ae_lp16x2f.iu	aep0, a5, 4; ae_mulzaafq32sp16s.ll	aeq3, aeq0, aep0, aeq0, aep0 }
     f34:	1baf74        	ae_roundsp16q48asym	aep7, aeq2
     f37:	1bbf14        	ae_roundsp16q48asym	aep1, aeq3
     f3a:	f04a7e715f 	{ ae_selp24.hl	aep1, aep7, aep1; ae_mulssfp24s.hh.ll	aeq1, aep2, aep2 }
     f3f:	e22473971f 	{ ae_sp16x2f.iu	aep1, a7, 4; ae_mulaafp24s.hh.ll	aeq1, aep1, aep1 }

00000f44 <subband_aec_mid_channel+0x48>:
     f44:	9258           	l32i.n	a5, a2, 36
     f46:	3511b4        	ae_sraiq56	aeq0, aeq1, 6
     f49:	618304        	ae_lq56.i	aeq2, a3, 0
     f4c:	f87221036e 	{ l16si	a6, a3, 32; ae_addq56	aeq0, aeq2, aeq0 }
     f51:	1155e0        	slli	a5, a5, 2
     f54:	fc00fec5ff 	{ ae_cvtq48a32s	aeq3, a5; ae_satq48s	aeq0, aeq0 }
     f59:	0130c4        	ae_maxq56s	aeq0, aeq0, aeq3
     f5c:	630304        	ae_sq56s.i	aeq0, a3, 0
     f5f:	00b4d6        	bgez	a4, f6e <subband_aec_mid_channel+0x72>
     f62:	368b04        	ae_trunca32q48	a11, aeq0
     f65:	11a650        	slli	a10, a6, 11
     f68:	fc5c51        	l32r	a5, d8 (521c <airoha_divide>)
     f6b:	0005e0        	callx8	a5

00000f6e <subband_aec_mid_channel+0x72>:
     f6e:	d3c8           	l32i.n	a12, a3, 52
     f70:	9422e2        	l32i	a14, a2, 0x250
     f73:	f388           	l32i.n	a8, a3, 60
     f75:	b358           	l32i.n	a5, a3, 44
     f77:	c368           	l32i.n	a6, a3, 48
     f79:	119372        	l16si	a7, a3, 34
     f7c:	026122        	s32i	a2, a1, 8
     f7f:	360b34        	ae_cvtq48a32s	aeq0, a11
     f82:	0aa092        	movi	a9, 10
     f85:	04a0b2        	movi	a11, 4
     f88:	fcccc2        	addi	a12, a12, -4
     f8b:	fec8d2        	addi	a13, a8, -2
     f8e:	fccee2        	addi	a14, a14, -4
     f91:	fec522        	addi	a2, a5, -2
     f94:	448e14        	ae_lp16x2f.iu	aep0, a14, 4
     f97:	fc24e406bf 	{ ae_sp16x2f.c	aep0, a6, a11; nop }
     f9c:	448c14        	ae_lp16x2f.iu	aep0, a12, 4
     f9f:	fe0413855f 	{ or	a8, a5, a5; ae_cvtq48p24s.h	aeq2, aep0 }
     fa4:	0a4084        	ae_cvtq48p24s.l	aeq1, aep0
     fa7:	1217a6        	blti	a7, 1, fbd <subband_aec_mid_channel+0xc1>
     faa:	440504        	ae_lp16x2f.i	aep0, a5, 0
     fad:	0c8776        	loop	a7, fbd <subband_aec_mid_channel+0xc1>
     fb0:	fc24da96bf 	{ ae_lp16x2f.c	aep1, a6, a11; nop }
     fb5:	0581c4        	ae_mulssfp24s.hh.ll	aeq2, aep0, aep1
     fb8:	ee206d881f 	{ ae_lp16x2f.iu	aep0, a8, 4; ae_mulsafp24s.hl.lh	aeq1, aep0, aep1 }

00000fbd <subband_aec_mid_channel+0xc1>:
     fbd:	1baf04        	ae_roundsp16q48asym	aep0, aeq2
     fc0:	f86bf28d1f 	{ ae_sp16f.l.iu	aep0, a13, 2; ae_roundsp16q48asym	aep1, aeq1 }
     fc5:	d4e2729d1f 	{ ae_sp16f.l.iu	aep1, a13, 2; ae_mulfq32sp16s.l	aeq1, aeq0, aep0 }
     fca:	0364d6        	bgez	a4, 1004 <subband_aec_mid_channel+0x108>
     fcd:	d5e63e9a4f 	{ ae_slaasq56s	aeq1, aeq1, a10; ae_mulfq32sp16s.l	aeq2, aeq0, aep1 }
     fd2:	058d           	mov.n	a8, a5
     fd4:	f86fbeaa8f 	{ ae_slaasq56s	aeq2, aeq2, a10; ae_roundsp24q48asym	aep0, aeq1 }
     fd9:	f877d3f22f 	{ or	a15, a2, a2; ae_roundsp24q48asym	aep1, aeq2 }
     fde:	2217a6        	blti	a7, 1, 1004 <subband_aec_mid_channel+0x108>
     fe1:	dc20ad150f 	{ ae_lp16x2f.i	aep1, a5, 0; ae_selp24.hl	aep0, aep0, aep1 }
     fe6:	1a8776        	loop	a7, 1004 <subband_aec_mid_channel+0x108>
     fe9:	fd241aa6bf 	{ ae_lp16x2f.c	aep2, a6, a11; ae_cvtq48p24s.h	aeq1, aep1 }
     fee:	fe2c2d981f 	{ ae_lp16x2f.iu	aep1, a8, 4; ae_cvtq48p24s.l	aeq2, aep1 }
     ff3:	050a04        	ae_mulaafp24s.hh.ll	aeq1, aep0, aep2
     ff6:	058254        	ae_mulasfp24s.hl.lh	aeq2, aep0, aep2
     ff9:	1b9f64        	ae_roundsp16q48asym	aep6, aeq1
     ffc:	fb73f2ef1f 	{ ae_sp16f.l.iu	aep6, a15, 2; ae_roundsp16q48asym	aep7, aeq2 }
    1001:	42ff14        	ae_sp16f.l.iu	aep7, a15, 2
    1004:	990b           	addi.n	a9, a9, -1
    1006:	f8a956        	bnez	a9, f94 <subband_aec_mid_channel+0x98>
    1009:	fd24b0d37e 	{ l32i	a7, a3, 52; ae_zeroq56	aeq1 }
    100e:	f358           	l32i.n	a5, a3, 60
    1010:	c369           	s32i.n	a6, a3, 48
    1012:	a20c           	movi.n	a2, 10
    1014:	fe0c6d070f 	{ ae_lp16x2f.i	aep0, a7, 0; ae_movq56	aeq2, aeq1 }
    1019:	fc0c6d150f 	{ ae_lp16x2f.i	aep1, a5, 0; ae_movq56	aeq0, aeq1 }
    101e:	0c8276        	loop	a2, 102e <subband_aec_mid_channel+0x132>
    1021:	058104        	ae_mulaafp24s.hh.ll	aeq2, aep0, aep1
    1024:	ea202d951f 	{ ae_lp16x2f.iu	aep1, a5, 4; ae_mulasfp24s.hl.lh	aeq0, aep0, aep1 }
    1029:	e2006d871f 	{ ae_lp16x2f.iu	aep0, a7, 4; ae_mulaafp24s.hh.ll	aeq1, aep0, aep0 }

0000102e <subband_aec_mid_channel+0x132>:
    102e:	35a134        	ae_sraiq56	aeq2, aeq2, 4
    1031:	f877bb010f 	{ ae_sraiq56	aeq0, aeq0, 4; ae_roundsp24q48asym	aep0, aeq2 }
    1036:	f867fb114f 	{ ae_sraiq56	aeq1, aeq1, 4; ae_roundsp24q48asym	aep1, aeq0 }
    103b:	fd2c7e011f 	{ ae_selp24.hl	aep0, aep0, aep1; ae_roundsq32asym	aeq1, aeq1 }
    1040:	f1028000af 	{ movi	a10, 0; ae_mulzaafp24s.hh.ll	aeq2, aep0, aep0 }
    1045:	fbf921        	l32r	a2, 2c (488 <HIFI_sqrt>)
    1048:	ff347f16ef 	{ ae_trunca32q48	a6, aeq1; ae_roundsq32asym	aeq3, aeq2 }
    104d:	36bb04        	ae_trunca32q48	a11, aeq3
    1050:	0002e0        	callx8	a2
    1053:	360b34        	ae_cvtq48a32s	aeq0, a11
    1056:	fc24fe8a0f 	{ ae_slaasq56s	aeq0, aeq0, a10; nop }
    105b:	fc2453a33f 	{ or	a10, a3, a3; ae_roundsq32asym	aeq0, aeq0 }
    1060:	368c04        	ae_trunca32q48	a12, aeq0
    1063:	fc1e21        	l32r	a2, dc (a5c <common_x_pow>)
    1066:	06bd           	mov.n	a11, a6
    1068:	0002e0        	callx8	a2
    106b:	aa8c           	beqz.n	a10, 1079 <subband_aec_mid_channel+0x17d>
    106d:	f3a8           	l32i.n	a10, a3, 60
    106f:	d3b8           	l32i.n	a11, a3, 52
    1071:	fbea21        	l32r	a2, 1c (5d9c <xt_memcpy>)
    1074:	4c1c           	movi.n	a12, 20
    1076:	0002e0        	callx8	a2

00001079 <subband_aec_mid_channel+0x17d>:
    1079:	2128           	l32i.n	a2, a1, 8
    107b:	fc24a0d22e 	{ l16si	a2, a2, 26; ae_zeroq56	aeq0 }
    1080:	1612a6        	blti	a2, 1, 109a <subband_aec_mid_channel+0x19e>
    1083:	119352        	l16si	a5, a3, 34
    1086:	b368           	l32i.n	a6, a3, 44
    1088:	c05520        	sub	a5, a5, a2
    108b:	a05560        	addx4	a5, a5, a6
    108e:	fcc552        	addi	a5, a5, -4
    1091:	058276        	loop	a2, 109a <subband_aec_mid_channel+0x19e>
    1094:	448514        	ae_lp16x2f.iu	aep0, a5, 4
    1097:	050004        	ae_mulaafp24s.hh.ll	aeq0, aep0, aep0

0000109a <subband_aec_mid_channel+0x19e>:
    109a:	3500b4        	ae_sraiq56	aeq0, aeq0, 2
    109d:	fc247033ae 	{ l32i	a10, a3, 12; ae_roundsq32asym	aeq0, aeq0 }
    10a2:	23b8           	l32i.n	a11, a3, 8
    10a4:	fc0c21        	l32r	a2, d4 (5324 <airoha_divide_limit_1>)
    10a7:	368604        	ae_trunca32q48	a6, aeq0
    10aa:	0002e0        	callx8	a2
    10ad:	2198           	l32i.n	a9, a1, 8
    10af:	ffa022        	movi	a2, 255
    10b2:	2403f2        	l8ui	a15, a3, 36
    10b5:	049952        	l16si	a5, a9, 8
    10b8:	7fd222        	addmi	a2, a2, 0x7f00
    10bb:	3170a0        	srai	a7, a10, 16
    10be:	c02270        	sub	a2, a2, a7
    10c1:	532250        	max	a2, a2, a5
    10c4:	07ef17        	bbsi	a15, 1, 10cf <subband_aec_mid_channel+0x1d3>
    10c7:	105322        	s16i	a2, a3, 32
    10ca:	000806        	j	10ee <subband_aec_mid_channel+0x1f2>

000010cd <subband_aec_mid_channel+0x1d1>:
	...

000010cf <subband_aec_mid_channel+0x1d3>:
    10cf:	039952        	l16si	a5, a9, 6
    10d2:	09ad           	mov.n	a10, a9
    10d4:	03bd           	mov.n	a11, a3
    10d6:	822250        	mull	a2, a2, a5
    10d9:	06cd           	mov.n	a12, a6
    10db:	40d222        	addmi	a2, a2, 0x4000
    10de:	412f20        	srli	a2, a2, 15
    10e1:	105322        	s16i	a2, a3, 32
    10e4:	fbff21        	l32r	a2, e0 (ac4 <ref_gain_adapt>)
    10e7:	04dd           	mov.n	a13, a4
    10e9:	0002e0        	callx8	a2
    10ec:	2198           	l32i.n	a9, a1, 8
    10ee:	059922        	l16si	a2, a9, 10
    10f1:	069952        	l16si	a5, a9, 12
    10f4:	fbf7f1        	l32r	a15, d0 (6880 <immediate_num>)
    10f7:	112200        	slli	a2, a2, 16
    10fa:	49a267        	bge	a2, a6, 1147 <subband_aec_mid_channel+0x24b>
    10fd:	129322        	l16si	a2, a3, 36
    1100:	240c           	movi.n	a4, 2
    1102:	11e500        	slli	a14, a5, 16
    1105:	202240        	or	a2, a2, a4
    1108:	125322        	s16i	a2, a3, 36
    110b:	18cf22        	addi	a2, a15, 24
    110e:	05ae67        	bge	a14, a6, 1117 <subband_aec_mid_channel+0x21b>
    1111:	400204        	ae_lp16f.i	aep0, a2, 0
    1114:	000086        	j	111a <subband_aec_mid_channel+0x21e>

00001117 <subband_aec_mid_channel+0x21b>:
    1117:	400214        	ae_lp16f.i	aep0, a2, 2
    111a:	0d9952        	l16si	a5, a9, 26
    111d:	2615a6        	blti	a5, 1, 1147 <subband_aec_mid_channel+0x24b>
    1120:	119322        	l16si	a2, a3, 34
    1123:	b348           	l32i.n	a4, a3, 44
    1125:	c02250        	sub	a2, a2, a5
    1128:	a02240        	addx4	a2, a2, a4
    112b:	441204        	ae_lp16x2f.i	aep1, a2, 0
    112e:	fec242        	addi	a4, a2, -2
    1131:	128576        	loop	a5, 1147 <subband_aec_mid_channel+0x24b>
    1134:	011054        	ae_mulfp24s.hl	aeq0, aep1, aep0
    1137:	ea05ed921f 	{ ae_lp16x2f.iu	aep1, a2, 4; ae_mulfp24s.ll	aeq1, aep1, aep0 }
    113c:	1b8f24        	ae_roundsp16q48asym	aep2, aeq0
    113f:	fb6bf2a41f 	{ ae_sp16f.l.iu	aep2, a4, 2; ae_roundsp16q48asym	aep7, aeq1 }
    1144:	42f414        	ae_sp16f.l.iu	aep7, a4, 2

00001147 <subband_aec_mid_channel+0x24b>:
    1147:	240322        	l8ui	a2, a3, 36
    114a:	31c8           	l32i.n	a12, a1, 12
    114c:	09ad           	mov.n	a10, a9
    114e:	076207        	bbci	a2, 0, 1159 <subband_aec_mid_channel+0x25d>
    1151:	fbe421        	l32r	a2, e4 (b5c <aec_post_calc>)
    1154:	03bd           	mov.n	a11, a3
    1156:	0002e0        	callx8	a2

00001159 <subband_aec_mid_channel+0x25d>:
    1159:	f01d           	retw.n

0000115b <subband_aec_mid_channel+0x25f>:
	...

0000115c <dt_detect>:
    115c:	004136        	entry	a1, 32
    115f:	0c9252        	l16si	a5, a2, 24
    1162:	179242        	l16si	a4, a2, 46
    1165:	189262        	l16si	a6, a2, 48
    1168:	115500        	slli	a5, a5, 16
    116b:	19a537        	bge	a5, a3, 1188 <dt_detect+0x2c>
    116e:	154c           	movi.n	a5, 65
    1170:	142657        	blt	a6, a5, 1188 <dt_detect+0x2c>
    1173:	169252        	l16si	a5, a2, 44
    1176:	0e9232        	l16si	a3, a2, 28
    1179:	442b           	addi.n	a4, a4, 2
    117b:	554b           	addi.n	a5, a5, 4
    117d:	435530        	min	a5, a5, a3
    1180:	165252        	s16i	a5, a2, 44
    1183:	855d           	ae_sext16	a5, a5
    1185:	000246        	j	1192 <dt_detect+0x36>

00001188 <dt_detect+0x2c>:
    1188:	0e9232        	l16si	a3, a2, 28
    118b:	050c           	movi.n	a5, 0
    118d:	440b           	addi.n	a4, a4, -1
    118f:	165252        	s16i	a5, a2, 44
    1192:	534450        	max	a4, a4, a5
    1195:	433430        	min	a3, a4, a3
    1198:	175232        	s16i	a3, a2, 46
    119b:	f01d           	retw.n

0000119d <dt_detect+0x41>:
    119d:	000000                                        ...

000011a0 <dt_detect_FB>:
    11a0:	004136        	entry	a1, 32
    11a3:	04d252        	addmi	a5, a2, 0x400
    11a6:	7c9562        	l16si	a6, a5, 248
    11a9:	7e9552        	l16si	a5, a5, 252
    11ac:	04d242        	addmi	a4, a2, 0x400
    11af:	116600        	slli	a6, a6, 16
    11b2:	22a637        	bge	a6, a3, 11d8 <dt_detect_FB+0x38>
    11b5:	04d232        	addmi	a3, a2, 0x400
    11b8:	7a9332        	l16si	a3, a3, 244
    11bb:	164c           	movi.n	a6, 65
    11bd:	03d272        	addmi	a7, a2, 0x300
    11c0:	142367        	blt	a3, a6, 11d8 <dt_detect_FB+0x38>
    11c3:	ff9762        	l16si	a6, a7, 0x1fe
    11c6:	fd9722        	l16si	a2, a7, 0x1fa
    11c9:	552b           	addi.n	a5, a5, 2
    11cb:	664b           	addi.n	a6, a6, 4
    11cd:	436620        	min	a6, a6, a2
    11d0:	ff5762        	s16i	a6, a7, 0x1fe
    11d3:	863d           	ae_sext16	a3, a6
    11d5:	000306        	j	11e5 <dt_detect_FB+0x45>

000011d8 <dt_detect_FB+0x38>:
    11d8:	03d262        	addmi	a6, a2, 0x300
    11db:	fd9622        	l16si	a2, a6, 0x1fa
    11de:	030c           	movi.n	a3, 0
    11e0:	550b           	addi.n	a5, a5, -1
    11e2:	ff5632        	s16i	a3, a6, 0x1fe
    11e5:	533530        	max	a3, a5, a3
    11e8:	432320        	min	a2, a3, a2
    11eb:	7e5422        	s16i	a2, a4, 252
    11ee:	f01d           	retw.n

000011f0 <get_ECNR_SVN>:
    11f0:	004136        	entry	a1, 32
    11f3:	fbbe21        	l32r	a2, ec (150ea64 <_end+0x1507748>)
    11f6:	f01d           	retw.n

000011f8 <get_ec120_memsize>:
    11f8:	004136        	entry	a1, 32
    11fb:	b7a622        	movi	a2, 0x6b7
    11fe:	1122d0        	slli	a2, a2, 3
    1201:	f01d           	retw.n

00001203 <get_ec120_memsize+0xb>:
	...

00001204 <get_ec120_inear_memsize>:
    1204:	004136        	entry	a1, 32
    1207:	ada322        	movi	a2, 0x3ad
    120a:	1122c0        	slli	a2, a2, 4
    120d:	f01d           	retw.n

0000120f <get_ec120_inear_memsize+0xb>:
	...

00001210 <sb_ana_init>:
    1210:	004136        	entry	a1, 32
    1213:	a24b           	addi.n	a10, a2, 4
    1215:	02a9           	s32i.n	a10, a2, 0
    1217:	fba821        	l32r	a2, b8 (5d88 <xt_memset>)
    121a:	0b0c           	movi.n	a11, 0
    121c:	ec1c           	movi.n	a12, 30
    121e:	0002e0        	callx8	a2
    1221:	f01d           	retw.n

00001223 <sb_ana_init+0x13>:
	...

00001224 <sb_syn_init>:
    1224:	004136        	entry	a1, 32
    1227:	a24b           	addi.n	a10, a2, 4
    1229:	02a9           	s32i.n	a10, a2, 0
    122b:	fba321        	l32r	a2, b8 (5d88 <xt_memset>)
    122e:	0b0c           	movi.n	a11, 0
    1230:	cc3c           	movi.n	a12, 60
    1232:	0002e0        	callx8	a2
    1235:	f01d           	retw.n

00001237 <sb_syn_init+0x13>:
	...

00001238 <HP_coef_setup>:
    1238:	004136        	entry	a1, 32
    123b:	fb7841        	l32r	a4, 1c (5d9c <xt_memcpy>)
    123e:	4c0c           	movi.n	a12, 4
    1240:	02ad           	mov.n	a10, a2
    1242:	03bd           	mov.n	a11, a3
    1244:	0004e0        	callx8	a4
    1247:	a2cb           	addi.n	a10, a2, 12
    1249:	b38b           	addi.n	a11, a3, 8
    124b:	ac0c           	movi.n	a12, 10
    124d:	0004e0        	callx8	a4
    1250:	24c2a2        	addi	a10, a2, 36
    1253:	1cc3b2        	addi	a11, a3, 28
    1256:	8c0c           	movi.n	a12, 8
    1258:	0004e0        	callx8	a4
    125b:	1238           	l32i.n	a3, a2, 4
    125d:	72f8           	l32i.n	a15, a2, 28
    125f:	2239           	s32i.n	a3, a2, 8
    1261:	82f9           	s32i.n	a15, a2, 32
    1263:	f01d           	retw.n

00001265 <HP_coef_setup+0x2d>:
    1265:	000000                                        ...

00001268 <tx_ref_vad_init>:
    1268:	004136        	entry	a1, 32
    126b:	fb9341        	l32r	a4, b8 (5d88 <xt_memset>)
    126e:	0b0c           	movi.n	a11, 0
    1270:	ec0c           	movi.n	a12, 14
    1272:	02ad           	mov.n	a10, a2
    1274:	0004e0        	callx8	a4
    1277:	03d3b2        	addmi	a11, a3, 0x300
    127a:	fb6831        	l32r	a3, 1c (5d9c <xt_memcpy>)
    127d:	7c0c           	movi.n	a12, 7
    127f:	02ad           	mov.n	a10, a2
    1281:	0003e0        	callx8	a3
    1284:	f01d           	retw.n

00001286 <tx_ref_vad_init+0x1e>:
	...

00001288 <Voice_EC120_Init>:
    1288:	004136        	entry	a1, 32
    128b:	fb9961        	l32r	a6, f0 (12a0 <Voice_EC_Init_Common>)
    128e:	2e0c           	movi.n	a14, 2
    1290:	02ad           	mov.n	a10, a2
    1292:	03bd           	mov.n	a11, a3
    1294:	04cd           	mov.n	a12, a4
    1296:	05dd           	mov.n	a13, a5
    1298:	0006e0        	callx8	a6
    129b:	f01d           	retw.n

0000129d <Voice_EC120_Init+0x15>:
    129d:	000000                                        ...

000012a0 <Voice_EC_Init_Common>:
    12a0:	006136        	entry	a1, 48
    12a3:	fb5f71        	l32r	a7, 20 (7318 <p_ecnr_mem>)
    12a6:	0c0c           	movi.n	a12, 0
    12a8:	02ad           	mov.n	a10, a2
    12aa:	0739           	s32i.n	a3, a7, 0
    12ac:	fb9231        	l32r	a3, f4 (310 <TX_ECNR_PARA_init>)
    12af:	04bd           	mov.n	a11, a4
    12b1:	3169           	s32i.n	a6, a1, 12
    12b3:	0003e0        	callx8	a3
    12b6:	fb5b31        	l32r	a3, 24 (7310 <aec_nr_para>)
    12b9:	07e8           	l32i.n	a14, a7, 0
    12bb:	08a1f2        	movi	a15, 0x108
    12be:	0328           	l32i.n	a2, a3, 0
    12c0:	10dea2        	addmi	a10, a14, 0x1000
    12c3:	036d           	mov.n	a6, a3
    12c5:	239242        	l16si	a4, a2, 70
    12c8:	b2fa           	add.n	a11, a2, a15
    12ca:	fb8b21        	l32r	a2, f8 (1238 <HP_coef_setup>)
    12cd:	654d           	ae_s16i.n	a4, a5, 0
    12cf:	0002e0        	callx8	a2
    12d2:	0728           	l32i.n	a2, a7, 0
    12d4:	fca032        	movi	a3, 252
    12d7:	2fd332        	addmi	a3, a3, 0x2f00
    12da:	a23a           	add.n	a10, a2, a3
    12dc:	fb7721        	l32r	a2, b8 (5d88 <xt_memset>)
    12df:	0b0c           	movi.n	a11, 0
    12e1:	a4a2c2        	movi	a12, 0x2a4
    12e4:	0002e0        	callx8	a2
    12e7:	07f8           	l32i.n	a15, a7, 0
    12e9:	0da442        	movi	a4, 0x40d
    12ec:	1144e0        	slli	a4, a4, 2
    12ef:	023d           	mov.n	a3, a2
    12f1:	af4a           	add.n	a10, a15, a4
    12f3:	0b0c           	movi.n	a11, 0
    12f5:	ec0c           	movi.n	a12, 14
    12f7:	0002e0        	callx8	a2
    12fa:	0728           	l32i.n	a2, a7, 0
    12fc:	dda442        	movi	a4, 0x4dd
    12ff:	1144e0        	slli	a4, a4, 2
    1302:	a24a           	add.n	a10, a2, a4
    1304:	0b0c           	movi.n	a11, 0
    1306:	f0a0c2        	movi	a12, 240
    1309:	f0a042        	movi	a4, 240
    130c:	0003e0        	callx8	a3
    130f:	0728           	l32i.n	a2, a7, 0
    1311:	47a552        	movi	a5, 0x547
    1314:	1155d0        	slli	a5, a5, 3
    1317:	2ad282        	addmi	a8, a2, 0x2a00
    131a:	225a           	add.n	a2, a2, a5
    131c:	a24b           	addi.n	a10, a2, 4
    131e:	0b0c           	movi.n	a11, 0
    1320:	ec1c           	movi.n	a12, 30
    1322:	e8a9           	s32i.n	a10, a8, 56
    1324:	0003e0        	callx8	a3
    1327:	0728           	l32i.n	a2, a7, 0
    1329:	4fa552        	movi	a5, 0x54f
    132c:	1155d0        	slli	a5, a5, 3
    132f:	2ad282        	addmi	a8, a2, 0x2a00
    1332:	225a           	add.n	a2, a2, a5
    1334:	a24b           	addi.n	a10, a2, 4
    1336:	0b0c           	movi.n	a11, 0
    1338:	ec1c           	movi.n	a12, 30
    133a:	1e68a2        	s32i	a10, a8, 120
    133d:	0003e0        	callx8	a3
    1340:	0728           	l32i.n	a2, a7, 0
    1342:	57a552        	movi	a5, 0x557
    1345:	1155d0        	slli	a5, a5, 3
    1348:	2ad282        	addmi	a8, a2, 0x2a00
    134b:	225a           	add.n	a2, a2, a5
    134d:	a24b           	addi.n	a10, a2, 4
    134f:	0b0c           	movi.n	a11, 0
    1351:	cc3c           	movi.n	a12, 60
    1353:	2e68a2        	s32i	a10, a8, 184
    1356:	0003e0        	callx8	a3
    1359:	0628           	l32i.n	a2, a6, 0
    135b:	0758           	l32i.n	a5, a7, 0
    135d:	c8a082        	movi	a8, 200
    1360:	3392d2        	l16si	a13, a2, 102
    1363:	10d5e2        	addmi	a14, a5, 0x1000
    1366:	285ed2        	s16i	a13, a14, 80
    1369:	3492d2        	l16si	a13, a2, 104
    136c:	0228           	l32i.n	a2, a2, 0
    136e:	18a192        	movi	a9, 0x118
    1371:	40a1a2        	movi	a10, 0x140
    1374:	68a1b2        	movi	a11, 0x168
    1377:	90a1c2        	movi	a12, 0x190
    137a:	295ed2        	s16i	a13, a14, 82
    137d:	b8a1e2        	movi	a14, 0x1b8
    1380:	e0a1f2        	movi	a15, 0x1e0
    1383:	d2ea           	add.n	a13, a2, a14
    1385:	15d552        	addmi	a5, a5, 0x1500
    1388:	828a           	add.n	a8, a2, a8
    138a:	424a           	add.n	a4, a2, a4
    138c:	929a           	add.n	a9, a2, a9
    138e:	a2aa           	add.n	a10, a2, a10
    1390:	b2ba           	add.n	a11, a2, a11
    1392:	c2ca           	add.n	a12, a2, a12
    1394:	e2fa           	add.n	a14, a2, a15
    1396:	78c222        	addi	a2, a2, 120
    1399:	1a6522        	s32i	a2, a5, 104
    139c:	fb5821        	l32r	a2, fc (5f8 <SBAEC_INIT>)
    139f:	1b6582        	s32i	a8, a5, 108
    13a2:	1c6542        	s32i	a4, a5, 112
    13a5:	1d6592        	s32i	a9, a5, 116
    13a8:	1e65a2        	s32i	a10, a5, 120
    13ab:	1f65b2        	s32i	a11, a5, 124
    13ae:	2065c2        	s32i	a12, a5, 128
    13b1:	2165d2        	s32i	a13, a5, 132
    13b4:	2365e2        	s32i	a14, a5, 140
    13b7:	0002e0        	callx8	a2
    13ba:	fb5121        	l32r	a2, 100 (4890 <NOISE_GEN_init>)
    13bd:	0002e0        	callx8	a2
    13c0:	0628           	l32i.n	a2, a6, 0
    13c2:	0758           	l32i.n	a5, a7, 0
    13c4:	8ca082        	movi	a8, 140
    13c7:	7228           	l32i.n	a2, a2, 28
    13c9:	35d882        	addmi	a8, a8, 0x3500
    13cc:	a58a           	add.n	a10, a5, a8
    13ce:	fb3a81        	l32r	a8, b8 (5d88 <xt_memset>)
    13d1:	0b0c           	movi.n	a11, 0
    13d3:	0c1c           	movi.n	a12, 16
    13d5:	35d542        	addmi	a4, a5, 0x3500
    13d8:	f56020        	extui	a6, a2, 16, 16
    13db:	753820        	extui	a3, a2, 24, 8
    13de:	0008e0        	callx8	a8
    13e1:	fb36c1        	l32r	a12, bc (155555 <_end+0x14e239>)
    13e4:	fb10f1        	l32r	a15, 24 (7310 <aec_nr_para>)
    13e7:	991c           	movi.n	a9, 25
    13e9:	c0c2c0        	sub	a12, a2, a12
    13ec:	0fa8           	l32i.n	a10, a15, 0
    13ee:	9396c0        	movnez	a9, a6, a12
    13f1:	746020        	extui	a6, a2, 0, 8
    13f4:	0d1c           	movi.n	a13, 16
    13f6:	d80c           	movi.n	a8, 13
    13f8:	74e820        	extui	a14, a2, 8, 8
    13fb:	836dc0        	moveqz	a6, a13, a12
    13fe:	2d0c           	movi.n	a13, 2
    1400:	9383c0        	movnez	a8, a3, a12
    1403:	93dec0        	movnez	a13, a14, a12
    1406:	209ae2        	l16si	a14, a10, 64
    1409:	4954e2        	s16i	a14, a4, 146
    140c:	1f9ae2        	l16si	a14, a10, 62
    140f:	4854e2        	s16i	a14, a4, 144
    1412:	5ba4e2        	movi	a14, 0x45b
    1415:	11ced0        	slli	a12, a14, 3
    1418:	a84482        	s8i	a8, a4, 168
    141b:	301a82        	l16ui	a8, a10, 96
    141e:	321ae2        	l16ui	a14, a10, 100
    1421:	0728           	l32i.n	a2, a7, 0
    1423:	a94492        	s8i	a9, a4, 169
    1426:	1e1a92        	l16ui	a9, a10, 60
    1429:	c16680        	mul16u	a6, a6, a8
    142c:	c1dde0        	mul16u	a13, a13, a14
    142f:	fb7c           	movi.n	a11, -1
    1431:	41e560        	srli	a14, a6, 5
    1434:	a2ca           	add.n	a10, a2, a12
    1436:	01bb10        	slli	a11, a11, 31
    1439:	0f6d           	mov.n	a6, a15
    143b:	35d552        	addmi	a5, a5, 0x3500
    143e:	41f5d0        	srli	a15, a13, 5
    1441:	130c           	movi.n	a3, 1
    1443:	15d222        	addmi	a2, a2, 0x1500
    1446:	315232        	s16i	a3, a2, 98
    1449:	c9ba           	add.n	a12, a9, a11
    144b:	113900        	slli	a3, a9, 16
    144e:	5355f2        	s16i	a15, a5, 166
    1451:	fb1951        	l32r	a5, b8 (5d88 <xt_memset>)
    1454:	c02c30        	sub	a2, a12, a3
    1457:	0b0c           	movi.n	a11, 0
    1459:	0c5c           	movi.n	a12, 80
    145b:	236422        	s32i	a2, a4, 140
    145e:	5254e2        	s16i	a14, a4, 164
    1461:	0005e0        	callx8	a5
    1464:	0728           	l32i.n	a2, a7, 0
    1466:	6fa432        	movi	a3, 0x46f
    1469:	1133d0        	slli	a3, a3, 3
    146c:	a23a           	add.n	a10, a2, a3
    146e:	0b0c           	movi.n	a11, 0
    1470:	4c2c           	movi.n	a12, 36
    1472:	0005e0        	callx8	a5
    1475:	0728           	l32i.n	a2, a7, 0
    1477:	06a8           	l32i.n	a10, a6, 0
    1479:	2ca642        	movi	a4, 0x62c
    147c:	15d232        	addmi	a3, a2, 0x1500
    147f:	2f1332        	l16ui	a3, a3, 94
    1482:	3d2366        	bnei	a3, 2, 14c3 <Voice_EC_Init_Common+0x223>
    1485:	fb1f21        	l32r	a2, 104 (313c <TWO_MIC_WB_init>)
    1488:	0002e0        	callx8	a2
    148b:	0728           	l32i.n	a2, a7, 0
    148d:	f03440        	subx8	a3, a4, a4
    1490:	0b0c           	movi.n	a11, 0
    1492:	2bd242        	addmi	a4, a2, 0x2b00
    1495:	223a           	add.n	a2, a2, a3
    1497:	a24b           	addi.n	a10, a2, 4
    1499:	ec1c           	movi.n	a12, 30
    149b:	d4a9           	s32i.n	a10, a4, 52
    149d:	0005e0        	callx8	a5
    14a0:	0728           	l32i.n	a2, a7, 0
    14a2:	d4a432        	movi	a3, 0x4d4
    14a5:	b03330        	addx8	a3, a3, a3
    14a8:	2bd242        	addmi	a4, a2, 0x2b00
    14ab:	223a           	add.n	a2, a2, a3
    14ad:	a24b           	addi.n	a10, a2, 4
    14af:	0b0c           	movi.n	a11, 0
    14b1:	cc3c           	movi.n	a12, 60
    14b3:	1d64a2        	s32i	a10, a4, 116
    14b6:	0005e0        	callx8	a5
    14b9:	06a8           	l32i.n	a10, a6, 0
    14bb:	fb1321        	l32r	a2, 108 (4a90 <NC_NOISE_EST_init>)
    14be:	0002e0        	callx8	a2
    14c1:	0728           	l32i.n	a2, a7, 0

000014c3 <Voice_EC_Init_Common+0x223>:
    14c3:	57a332        	movi	a3, 0x357
    14c6:	1133c0        	slli	a3, a3, 4
    14c9:	223a           	add.n	a2, a2, a3
    14cb:	0648           	l32i.n	a4, a6, 0
    14cd:	0b0c           	movi.n	a11, 0
    14cf:	ec0c           	movi.n	a12, 14
    14d1:	02ad           	mov.n	a10, a2
    14d3:	0005e0        	callx8	a5
    14d6:	fad131        	l32r	a3, 1c (5d9c <xt_memcpy>)
    14d9:	03d4b2        	addmi	a11, a4, 0x300
    14dc:	7c0c           	movi.n	a12, 7
    14de:	02ad           	mov.n	a10, a2
    14e0:	0003e0        	callx8	a3
    14e3:	0728           	l32i.n	a2, a7, 0
    14e5:	634c           	movi.n	a3, 70
    14e7:	35d332        	addmi	a3, a3, 0x3500
    14ea:	a23a           	add.n	a10, a2, a3
    14ec:	0b0c           	movi.n	a11, 0
    14ee:	5c1c           	movi.n	a12, 21
    14f0:	0005e0        	callx8	a5
    14f3:	0728           	l32i.n	a2, a7, 0
    14f5:	3148           	l32i.n	a4, a1, 12
    14f7:	15a4e2        	movi	a14, 0x415
    14fa:	35d232        	addmi	a3, a2, 0x3500
    14fd:	464342        	s8i	a4, a3, 70
    1500:	113ee0        	slli	a3, a14, 2
    1503:	1f0c           	movi.n	a15, 1
    1505:	a23a           	add.n	a10, a2, a3
    1507:	114f30        	slli	a4, a15, 13
    150a:	35d222        	addmi	a2, a2, 0x3500
    150d:	0b0c           	movi.n	a11, 0
    150f:	f0a0c2        	movi	a12, 240
    1512:	255242        	s16i	a4, a2, 74
    1515:	0005e0        	callx8	a5
    1518:	f01d           	retw.n

0000151a <Voice_EC_Init_Common+0x27a>:
	...

0000151c <Voice_EC80_Init>:
    151c:	004136        	entry	a1, 32
    151f:	faf461        	l32r	a6, f0 (12a0 <Voice_EC_Init_Common>)
    1522:	3e0c           	movi.n	a14, 3
    1524:	02ad           	mov.n	a10, a2
    1526:	03bd           	mov.n	a11, a3
    1528:	04cd           	mov.n	a12, a4
    152a:	05dd           	mov.n	a13, a5
    152c:	0006e0        	callx8	a6
    152f:	f01d           	retw.n

00001531 <Voice_EC80_Init+0x15>:
    1531:	000000                                        ...

00001534 <Voice_EC120_Inear_Init>:
    1534:	004136        	entry	a1, 32
    1537:	faf561        	l32r	a6, 10c (154c <Voice_EC_Inear_Init_Common>)
    153a:	2e0c           	movi.n	a14, 2
    153c:	02ad           	mov.n	a10, a2
    153e:	03bd           	mov.n	a11, a3
    1540:	04cd           	mov.n	a12, a4
    1542:	05dd           	mov.n	a13, a5
    1544:	0006e0        	callx8	a6
    1547:	f01d           	retw.n

00001549 <Voice_EC120_Inear_Init+0x15>:
    1549:	000000                                        ...

0000154c <Voice_EC_Inear_Init_Common>:
    154c:	004136        	entry	a1, 32
    154f:	fae871        	l32r	a7, f0 (12a0 <Voice_EC_Init_Common>)
    1552:	02ad           	mov.n	a10, a2
    1554:	03bd           	mov.n	a11, a3
    1556:	04cd           	mov.n	a12, a4
    1558:	05dd           	mov.n	a13, a5
    155a:	06ed           	mov.n	a14, a6
    155c:	0007e0        	callx8	a7
    155f:	b7a622        	movi	a2, 0x6b7
    1562:	1122d0        	slli	a2, a2, 3
    1565:	fad451        	l32r	a5, b8 (5d88 <xt_memset>)
    1568:	35d342        	addmi	a4, a3, 0x3500
    156b:	a32a           	add.n	a10, a3, a2
    156d:	0b0c           	movi.n	a11, 0
    156f:	8ca2c2        	movi	a12, 0x28c
    1572:	2c64a2        	s32i	a10, a4, 176
    1575:	0005e0        	callx8	a5
    1578:	faab41        	l32r	a4, 24 (7310 <aec_nr_para>)
    157b:	f4a072        	movi	a7, 244
    157e:	39d772        	addmi	a7, a7, 0x3900
    1581:	0488           	l32i.n	a8, a4, 0
    1583:	39d362        	addmi	a6, a3, 0x3900
    1586:	a37a           	add.n	a10, a3, a7
    1588:	02d8e2        	addmi	a14, a8, 0x200
    158b:	3c66a2        	s32i	a10, a6, 240
    158e:	3ad322        	addmi	a2, a3, 0x3a00
    1591:	4b9e62        	l16si	a6, a14, 150
    1594:	645262        	s16i	a6, a2, 200
    1597:	079e62        	l16si	a6, a14, 14
    159a:	0b0c           	movi.n	a11, 0
    159c:	ec1c           	movi.n	a12, 30
    159e:	655262        	s16i	a6, a2, 202
    15a1:	0005e0        	callx8	a5
    15a4:	463c           	movi.n	a6, 52
    15a6:	3ad662        	addmi	a6, a6, 0x3a00
    15a9:	a36a           	add.n	a10, a3, a6
    15ab:	0b0c           	movi.n	a11, 0
    15ad:	cc3c           	movi.n	a12, 60
    15af:	c2a9           	s32i.n	a10, a2, 48
    15b1:	0005e0        	callx8	a5
    15b4:	15d352        	addmi	a5, a3, 0x1500
    15b7:	232552        	l32i	a5, a5, 140
    15ba:	0448           	l32i.n	a4, a4, 0
    15bc:	28c582        	addi	a8, a5, 40
    15bf:	02d472        	addmi	a7, a4, 0x200
    15c2:	2f6282        	s32i	a8, a2, 188
    15c5:	481782        	l16ui	a8, a7, 144
    15c8:	50c5e2        	addi	a14, a5, 80
    15cb:	78c552        	addi	a5, a5, 120
    15ce:	41ff80        	srli	a15, a8, 15
    15d1:	3062e2        	s32i	a14, a2, 192
    15d4:	cc42f2        	s8i	a15, a2, 204
    15d7:	00a192        	movi	a9, 0x100
    15da:	e4f080        	extui	a15, a8, 0, 15
    15dd:	1e0c           	movi.n	a14, 1
    15df:	316252        	s32i	a5, a2, 196
    15e2:	479772        	l16si	a7, a7, 142
    15e5:	016e90        	slli	a6, a14, 23
    15e8:	532f90        	max	a2, a15, a9
    15eb:	b8a2b2        	movi	a11, 0x2b8
    15ee:	3ad352        	addmi	a5, a3, 0x3a00
    15f1:	c22620        	quou	a2, a6, a2
    15f4:	61a3c2        	movi	a12, 0x361
    15f7:	b4ba           	add.n	a11, a4, a11
    15f9:	114cc0        	slli	a4, a12, 4
    15fc:	5d5522        	s16i	a2, a5, 186
    15ff:	fabe21        	l32r	a2, f8 (1238 <HP_coef_setup>)
    1602:	53d790        	max	a13, a7, a9
    1605:	a34a           	add.n	a10, a3, a4
    1607:	5c55d2        	s16i	a13, a5, 184
    160a:	0002e0        	callx8	a2
    160d:	fac021        	l32r	a2, 110 (8d0 <SBAEC_INIT_inear>)
    1610:	03ad           	mov.n	a10, a3
    1612:	0002e0        	callx8	a2
    1615:	f01d           	retw.n

00001617 <Voice_EC_Inear_Init_Common+0xcb>:
	...

00001618 <Voice_EC80_Inear_Init>:
    1618:	004136        	entry	a1, 32
    161b:	fabc61        	l32r	a6, 10c (154c <Voice_EC_Inear_Init_Common>)
    161e:	3e0c           	movi.n	a14, 3
    1620:	02ad           	mov.n	a10, a2
    1622:	03bd           	mov.n	a11, a3
    1624:	04cd           	mov.n	a12, a4
    1626:	05dd           	mov.n	a13, a5
    1628:	0006e0        	callx8	a6
    162b:	f01d           	retw.n

0000162d <Voice_EC80_Inear_Init+0x15>:
    162d:	000000                                        ...

00001630 <mic_delay>:
    1630:	006136        	entry	a1, 48
    1633:	1196f0        	slli	a9, a6, 1
    1636:	e0a172        	movi	a7, 0x1e0
    1639:	c0f490        	sub	a15, a4, a9
    163c:	3129           	s32i.n	a2, a1, 12
    163e:	f0a082        	movi	a8, 240
    1641:	11a5f0        	slli	a10, a5, 1
    1644:	5f7a           	add.n	a5, a15, a7
    1646:	fa7521        	l32r	a2, 1c (5d9c <xt_memcpy>)
    1649:	c075a0        	sub	a7, a5, a10
    164c:	90b640        	addx2	a11, a6, a4
    164f:	c0c860        	sub	a12, a8, a6
    1652:	04ad           	mov.n	a10, a4
    1654:	0002e0        	callx8	a2
    1657:	05ad           	mov.n	a10, a5
    1659:	03bd           	mov.n	a11, a3
    165b:	06cd           	mov.n	a12, a6
    165d:	0002e0        	callx8	a2
    1660:	31a8           	l32i.n	a10, a1, 12
    1662:	07bd           	mov.n	a11, a7
    1664:	06cd           	mov.n	a12, a6
    1666:	0002e0        	callx8	a2
    1669:	f01d           	retw.n

0000166b <mic_delay+0x3b>:
	...

0000166c <tx_downsample_by2>:
    166c:	004136        	entry	a1, 32
    166f:	faa971        	l32r	a7, 114 (6a90 <wb_r01>)
    1672:	481c           	movi.n	a8, 20
    1674:	fec222        	addi	a2, a2, -2
    1677:	fec332        	addi	a3, a3, -2
    167a:	600604        	ae_lq32f.i	aeq0, a6, 0
    167d:	440404        	ae_lp16x2f.i	aep0, a4, 0
    1680:	948876        	loop	a8, 1718 <tx_downsample_by2+0xac>
    1683:	e2002f150f 	{ ae_lp24x2f.i	aep1, a5, 0; ae_mulaafp24s.hh.ll	aeq0, aep0, aep0 }
    1688:	fd242c340f 	{ ae_lp16f.i	aep3, a4, 0; ae_cvtq48p24s.h	aeq1, aep1 }
    168d:	de2cb1273f 	{ ae_lp24.i	aep2, a7, 12; ae_selp24.hl	aep4, aep3, aep1 }
    1692:	e88874350f 	{ ae_sp24f.l.i	aep3, a5, 0; ae_mulasfp24s.hh.ll	aeq1, aep2, aep4 }
    1697:	ff2c2f251f 	{ ae_lp24x2f.i	aep2, a5, 8; ae_cvtq48p24s.l	aeq3, aep1 }
    169c:	fa6ff1674f 	{ ae_lp24.i	aep6, a7, 16; ae_roundsp24q48asym	aep5, aeq1 }
    16a1:	df55f4551f 	{ ae_sp24f.l.i	aep5, a5, 4; ae_selp24.lh	aep7, aep5, aep2 }
    16a6:	e9f871375f 	{ ae_lp24.i	aep3, a7, 20; ae_mulasfp24s.hh.ll	aeq3, aep6, aep7 }
    16ab:	fe442c441f 	{ ae_lp16f.i	aep4, a4, 2; ae_cvtq48p24s.h	aeq2, aep2 }
    16b0:	f87fed841f 	{ ae_lp16x2f.iu	aep0, a4, 4; ae_roundsp24q48asym	aep1, aeq3 }
    16b5:	dd4634152f 	{ ae_sp24f.l.i	aep1, a5, 8; ae_selp24.ll	aep2, aep1, aep2 }
    16ba:	05b244        	ae_mulasfp24s.hh.ll	aeq2, aep3, aep2
    16bd:	1bad14        	ae_roundsp24q48asym	aep1, aeq2
    16c0:	521534        	ae_sp24f.l.i	aep1, a5, 12
    16c3:	5c6524        	ae_lp24x2f.i	aep6, a5, 16
    16c6:	ffc431770f 	{ ae_lp24.i	aep7, a7, 0; ae_cvtq48p24s.h	aeq3, aep6 }
    16cb:	ded0f4454f 	{ ae_sp24f.l.i	aep4, a5, 16; ae_selp24.hl	aep5, aep4, aep6 }
    16d0:	e9bc6f253f 	{ ae_lp24x2f.i	aep2, a5, 24; ae_mulasfp24s.hh.ll	aeq3, aep7, aep5 }
    16d5:	fecc31671f 	{ ae_lp24.i	aep6, a7, 4; ae_cvtq48p24s.l	aeq2, aep6 }
    16da:	fa7fbf18df 	{ ae_movap24s.l	a8, aep1; ae_roundsp24q48asym	aep4, aeq3 }
    16df:	df51f4455f 	{ ae_sp24f.l.i	aep4, a5, 20; ae_selp24.lh	aep7, aep4, aep2 }
    16e4:	e9f831472f 	{ ae_lp24.i	aep4, a7, 8; ae_mulasfp24s.hh.ll	aeq2, aep6, aep7 }
    16e9:	0aca84        	ae_cvtq48p24s.h	aeq3, aep2
    16ec:	1bad34        	ae_roundsp24q48asym	aep3, aeq2
    16ef:	dd4e34356f 	{ ae_sp24f.l.i	aep3, a5, 24; ae_selp24.ll	aep2, aep3, aep2 }
    16f4:	05ca44        	ae_mulasfp24s.hh.ll	aeq3, aep4, aep2
    16f7:	1bbd54        	ae_roundsp24q48asym	aep5, aeq3
    16fa:	34d904        	ae_movap24s.l	a9, aep5
    16fd:	a98a           	add.n	a10, a9, a8
    16ff:	c08980        	sub	a8, a9, a8
    1702:	41f1a0        	srli	a15, a10, 1
    1705:	418180        	srli	a8, a8, 1
    1708:	39ef84        	ae_movpa24x2	aep6, a15, a8
    170b:	f9fab4557f 	{ ae_sp24f.l.i	aep5, a5, 28; ae_roundsp16asym	aep2, aep6 }
    1710:	df4972a31f 	{ ae_sp16f.l.iu	aep2, a3, 2; ae_selp24.hh	aep7, aep2, aep2 }
    1715:	42f214        	ae_sp16f.l.iu	aep7, a2, 2

00001718 <tx_downsample_by2+0xac>:
    1718:	060934        	ae_roundsq32asym	aeq0, aeq0
    171b:	620604        	ae_sq32f.i	aeq0, a6, 0
    171e:	f01d           	retw.n

00001720 <tx_upsample_by2>:
    1720:	006136        	entry	a1, 48
    1723:	fa7c91        	l32r	a9, 114 (6a90 <wb_r01>)
    1726:	4a1c           	movi.n	a10, 20
    1728:	71eb           	addi.n	a7, a1, 14
    172a:	81cb           	addi.n	a8, a1, 12
    172c:	fcc442        	addi	a4, a4, -4
    172f:	600604        	ae_lq32f.i	aeq0, a6, 0
    1732:	401204        	ae_lp16f.i	aep1, a2, 0
    1735:	402304        	ae_lp16f.i	aep2, a3, 0
    1738:	8f8a76        	loop	a10, 17cb <tx_upsample_by2+0xab>
    173b:	dd46ef050f 	{ ae_lp24x2f.i	aep0, a5, 0; ae_subsp24s	aep3, aep1, aep2 }
    1740:	fd0432381f 	{ ae_sp16f.l.i	aep3, a8, 2; ae_cvtq48p24s.h	aeq1, aep0 }
    1745:	ff0c2c370f 	{ ae_lp16f.i	aep3, a7, 0; ae_cvtq48p24s.l	aeq3, aep0 }
    174a:	de0cf1490f 	{ ae_lp24.i	aep4, a9, 0; ae_selp24.hl	aep5, aep3, aep0 }
    174f:	e8b074350f 	{ ae_sp24f.l.i	aep3, a5, 0; ae_mulasfp24s.hh.ll	aeq1, aep4, aep5 }
    1754:	d8452f351f 	{ ae_lp24x2f.i	aep3, a5, 8; ae_addsp24s	aep0, aep1, aep2 }
    1759:	fa6fb1691f 	{ ae_lp24.i	aep6, a9, 4; ae_roundsp24q48asym	aep4, aeq1 }
    175e:	df71f4451f 	{ ae_sp24f.l.i	aep4, a5, 4; ae_selp24.lh	aep7, aep4, aep3 }
    1763:	e9f871592f 	{ ae_lp24.i	aep5, a9, 8; ae_mulasfp24s.hh.ll	aeq3, aep6, aep7 }
    1768:	fe6432080f 	{ ae_sp16f.l.i	aep0, a8, 0; ae_cvtq48p24s.h	aeq2, aep3 }
    176d:	fa7fac680f 	{ ae_lp16f.i	aep6, a8, 0; ae_roundsp24q48asym	aep4, aeq3 }
    1772:	dd7274452f 	{ ae_sp24f.l.i	aep4, a5, 8; ae_selp24.ll	aep3, aep4, aep3 }
    1777:	05d344        	ae_mulasfp24s.hh.ll	aeq2, aep5, aep3
    177a:	1bad24        	ae_roundsp24q48asym	aep2, aeq2
    177d:	e203b4253f 	{ ae_sp24f.l.i	aep2, a5, 12; ae_mulafp24s.ll	aeq0, aep0, aep0 }
    1782:	5c1524        	ae_lp24x2f.i	aep1, a5, 16
    1785:	ff2431493f 	{ ae_lp24.i	aep4, a9, 12; ae_cvtq48p24s.h	aeq3, aep1 }
    178a:	df38f4654f 	{ ae_sp24f.l.i	aep6, a5, 16; ae_selp24.hl	aep7, aep6, aep1 }
    178f:	e9f06f353f 	{ ae_lp24x2f.i	aep3, a5, 24; ae_mulasfp24s.hh.ll	aeq3, aep4, aep7 }
    1794:	fe2c31694f 	{ ae_lp24.i	aep6, a9, 16; ae_cvtq48p24s.l	aeq2, aep1 }
    1799:	fa7fbf2adf 	{ ae_movap24s.l	a10, aep2; ae_roundsp24q48asym	aep4, aeq3 }
    179e:	df71f4455f 	{ ae_sp24f.l.i	aep4, a5, 20; ae_selp24.lh	aep7, aep4, aep3 }
    17a3:	e9f831795f 	{ ae_lp24.i	aep7, a9, 20; ae_mulasfp24s.hh.ll	aeq2, aep6, aep7 }
    17a8:	ff642c921f 	{ ae_lp16f.iu	aep1, a2, 2; ae_cvtq48p24s.h	aeq3, aep3 }
    17ad:	fb77aca31f 	{ ae_lp16f.iu	aep2, a3, 2; ae_roundsp24q48asym	aep6, aeq2 }
    17b2:	dd7a74656f 	{ ae_sp24f.l.i	aep6, a5, 24; ae_selp24.ll	aep3, aep6, aep3 }
    17b7:	05fb44        	ae_mulasfp24s.hh.ll	aeq3, aep7, aep3
    17ba:	1bbd64        	ae_roundsp24q48asym	aep6, aeq3
    17bd:	34eb04        	ae_movap24s.l	a11, aep6
    17c0:	39fab4        	ae_movpa24x2	aep7, a10, a11
    17c3:	f9fef4657f 	{ ae_sp24f.l.i	aep6, a5, 28; ae_roundsp16asym	aep3, aep7 }
    17c8:	46b414        	ae_sp16x2f.iu	aep3, a4, 4

000017cb <tx_upsample_by2+0xab>:
    17cb:	060934        	ae_roundsq32asym	aeq0, aeq0
    17ce:	620604        	ae_sq32f.i	aeq0, a6, 0
    17d1:	f01d           	retw.n

000017d3 <tx_upsample_by2+0xb3>:
	...

000017d4 <emph_filter_N>:
    17d4:	004136        	entry	a1, 32
    17d7:	440404        	ae_lp16x2f.i	aep0, a4, 0
    17da:	3725a6        	blti	a5, 2, 1815 <emph_filter_N+0x41>
    17dd:	651b           	addi.n	a6, a5, 1
    17df:	b36550        	movgez	a6, a5, a5
    17e2:	215160        	srai	a5, a6, 1
    17e5:	441304        	ae_lp16x2f.i	aep1, a3, 0
    17e8:	fec232        	addi	a3, a2, -2
    17eb:	fcc222        	addi	a2, a2, -4
    17ee:	238576        	loop	a5, 1815 <emph_filter_N+0x41>
    17f1:	44a214        	ae_lp16x2f.iu	aep2, a2, 4
    17f4:	fc443e20cf 	{ ae_selp24.hh	aep3, aep2, aep0; ae_cvtq48p24s.h	aeq0, aep2 }
    17f9:	0a4284        	ae_cvtq48p24s.l	aeq1, aep2
    17fc:	011004        	ae_mulafp24s.hh	aeq0, aep1, aep0
    17ff:	011a04        	ae_mulafp24s.hh	aeq1, aep1, aep2
    1802:	051004        	ae_mulaafp24s.hh.ll	aeq0, aep1, aep0
    1805:	051b04        	ae_mulaafp24s.hh.ll	aeq1, aep1, aep3
    1808:	1b8f04        	ae_roundsp16q48asym	aep0, aeq0
    180b:	f96bf2831f 	{ ae_sp16f.l.iu	aep0, a3, 2; ae_roundsp16q48asym	aep3, aeq1 }
    1810:	dc49b2b31f 	{ ae_sp16f.l.iu	aep3, a3, 2; ae_selp24.lh	aep0, aep2, aep2 }

00001815 <emph_filter_N+0x41>:
    1815:	460404        	ae_sp16x2f.i	aep0, a4, 0
    1818:	f01d           	retw.n

0000181a <emph_filter_N+0x46>:
	...

0000181c <deemph_filter_N>:
    181c:	004136        	entry	a1, 32
    181f:	600404        	ae_lq32f.i	aeq0, a4, 0
    1822:	604414        	ae_lq32f.i	aeq1, a4, 4
    1825:	2e15a6        	blti	a5, 1, 1857 <deemph_filter_N+0x3b>
    1828:	fa2af1        	l32r	a15, d0 (6880 <immediate_num>)
    182b:	ff0c6d030f 	{ ae_lp16x2f.i	aep0, a3, 0; ae_movq56	aeq3, aeq1 }
    1830:	99002c120f 	{ ae_lp16f.i	aep1, a2, 0; ae_mulzssfq32sp16s.hh	aeq2, aeq0, aep0, aeq0, aep0 }
    1835:	30cf32        	addi	a3, a15, 48
    1838:	442304        	ae_lp16x2f.i	aep2, a3, 0
    183b:	f03d           	nop.n
    183d:	168576        	loop	a5, 1857 <deemph_filter_N+0x3b>
    1840:	fb81bf017f 	{ ae_movq56	aeq1, aeq0; ae_mulsfq32sp16s.l	aeq2, aeq3, aep0 }
    1845:	f1462c921f 	{ ae_lp16f.iu	aep1, a2, 2; ae_mulssfp24s.hh.ll	aeq2, aep1, aep2 }
    184a:	fc347f11ff 	{ ae_movq56	aeq3, aeq1; ae_roundsq32asym	aeq0, aeq2 }
    184f:	1b8f34        	ae_roundsp16q48asym	aep3, aeq0
    1852:	99003232ff 	{ ae_sp16f.l.i	aep3, a2, -2; ae_mulzssfq32sp16s.hh	aeq2, aeq0, aep0, aeq0, aep0 }

00001857 <deemph_filter_N+0x3b>:
    1857:	620404        	ae_sq32f.i	aeq0, a4, 0
    185a:	621414        	ae_sq32f.i	aeq1, a4, 4
    185d:	f01d           	retw.n

0000185f <deemph_filter_N+0x43>:
	...

00001860 <analy_3band>:
    1860:	004136        	entry	a1, 32
    1863:	fa2db1        	l32r	a11, 118 (6ab0 <sb_g10>)
    1866:	fa2dc1        	l32r	a12, 11c (6af0 <sb_h2ir>)
    1869:	a34b           	addi.n	a10, a3, 4
    186b:	f3f6a0        	wur.ae_cbegin0	a10
    186e:	03a8           	l32i.n	a10, a3, 0
    1870:	40c3f2        	addi	a15, a3, 64
    1873:	a70c           	movi.n	a7, 10
    1875:	480c           	movi.n	a8, 4
    1877:	790c           	movi.n	a9, 7
    1879:	f3f7f0        	wur.ae_cend0	a15
    187c:	fe248fc44e 	{ addi	a4, a4, -4; ae_zeroq56	aeq2 }
    1881:	fec552        	addi	a5, a5, -2
    1884:	fec662        	addi	a6, a6, -2
    1887:	fccbb2        	addi	a11, a11, -4
    188a:	fcccc2        	addi	a12, a12, -4
    188d:	fcc222        	addi	a2, a2, -4

00001890 <analy_3band+0x30>:
    1890:	448214        	ae_lp16x2f.iu	aep0, a2, 4
    1893:	fc14640a8f 	{ ae_sp16x2f.c	aep0, a10, a8; ae_movq56	aeq0, aeq2 }
    1898:	0bdd           	mov.n	a13, a11
    189a:	20ecc0        	or	a14, a12, a12
    189d:	fc24da8a8f 	{ ae_lp16x2f.c	aep0, a10, a8; nop }
    18a2:	449d14        	ae_lp16x2f.iu	aep1, a13, 4
    18a5:	ea05edfe1f 	{ ae_lp16x2f.iu	aep7, a14, 4; ae_mulfp24s.ll	aeq1, aep1, aep0 }
    18aa:	01f874        	ae_mulfp24s.ll	aeq3, aep7, aep0
    18ad:	278976        	loop	a9, 18d8 <analy_3band+0x78>
    18b0:	fc24da8a8f 	{ ae_lp16x2f.c	aep0, a10, a8; nop }
    18b5:	449d14        	ae_lp16x2f.iu	aep1, a13, 4
    18b8:	e2062dae1f 	{ ae_lp16x2f.iu	aep2, a14, 4; ae_mulafp24s.hh	aeq0, aep1, aep0 }
    18bd:	e207daea8f 	{ ae_lp16x2f.c	aep6, a10, a8; ae_mulafp24s.ll	aeq1, aep1, aep0 }
    18c2:	e30a2dbd1f 	{ ae_lp16x2f.iu	aep3, a13, 4; ae_mulafp24s.hh	aeq2, aep2, aep0 }
    18c7:	e30bedfe1f 	{ ae_lp16x2f.iu	aep7, a14, 4; ae_mulafp24s.ll	aeq3, aep2, aep0 }
    18cc:	013604        	ae_mulafp24s.hh	aeq0, aep3, aep6
    18cf:	013e34        	ae_mulafp24s.ll	aeq1, aep3, aep6
    18d2:	01f604        	ae_mulafp24s.hh	aeq2, aep7, aep6
    18d5:	01fe34        	ae_mulafp24s.ll	aeq3, aep7, aep6

000018d8 <analy_3band+0x78>:
    18d8:	f87bcff77e 	{ addi	a7, a7, -1; ae_roundsp16q48asym	aep1, aeq3 }
    18dd:	fb6a32961f 	{ ae_sp16f.l.iu	aep1, a6, 2; ae_addq56	aeq3, aeq1, aeq0 }
    18e2:	f92afb30df 	{ ae_sraiq56	aeq3, aeq3, 1; ae_subq56	aeq1, aeq1, aeq0 }
    18e7:	f873bb101f 	{ ae_sraiq56	aeq0, aeq1, 1; ae_roundsp16q48asym	aep0, aeq2 }
    18ec:	fb7fb2861f 	{ ae_sp16f.l.iu	aep0, a6, 2; ae_roundsp24q48asym	aep6, aeq3 }
    18f1:	fb63f4e41f 	{ ae_sp24f.l.iu	aep6, a4, 4; ae_roundsp16q48asym	aep7, aeq0 }
    18f6:	fe24b2f51f 	{ ae_sp16f.l.iu	aep7, a5, 2; ae_zeroq56	aeq2 }
    18fb:	f91756        	bnez	a7, 1890 <analy_3band+0x30>
    18fe:	03a9           	s32i.n	a10, a3, 0
    1900:	f01d           	retw.n

00001902 <analy_3band+0xa2>:
	...

00001904 <synth_3band>:
    1904:	004136        	entry	a1, 32
    1907:	c54b           	addi.n	a12, a5, 4
    1909:	f3f6c0        	wur.ae_cbegin0	a12
    190c:	fa0371        	l32r	a7, 118 (6ab0 <sb_g10>)
    190f:	fa0481        	l32r	a8, 120 (6b30 <sb_h2ir_v2>)
    1912:	0025c2        	l32i	a12, a5, 0
    1915:	7cc5f2        	addi	a15, a5, 124
    1918:	0aa092        	movi	a9, 10
    191b:	fd248004af 	{ movi	a10, 4; ae_zeroq56	aeq1 }
    1920:	0fa0b2        	movi	a11, 15
    1923:	f3f7f0        	wur.ae_cend0	a15
    1926:	fc0c4fe22e 	{ addi	a2, a2, -2; ae_movq56	aeq0, aeq1 }
    192b:	fec332        	addi	a3, a3, -2
    192e:	fcc442        	addi	a4, a4, -4
    1931:	fec662        	addi	a6, a6, -2

00001934 <synth_3band+0x30>:
    1934:	408214        	ae_lp16f.iu	aep0, a2, 2
    1937:	409314        	ae_lp16f.iu	aep1, a3, 2
    193a:	d9212df41f 	{ ae_lp16x2f.iu	aep7, a4, 4; ae_addsp24s	aep2, aep0, aep1 }
    193f:	078184        	ae_subsp24s	aep0, aep0, aep1
    1942:	1aa004        	ae_selp24.ll	aep0, aep2, aep0
    1945:	fc24e40caf 	{ ae_sp16x2f.c	aep0, a12, a10; nop }
    194a:	fc24e47caf 	{ ae_sp16x2f.c	aep7, a12, a10; nop }
    194f:	441704        	ae_lp16x2f.i	aep1, a7, 0
    1952:	440804        	ae_lp16x2f.i	aep0, a8, 0
    1955:	168b76        	loop	a11, 196f <synth_3band+0x6b>
    1958:	fc24daacaf 	{ ae_lp16x2f.c	aep2, a12, a10; nop }
    195d:	e247dabcaf 	{ ae_lp16x2f.c	aep3, a12, a10; ae_mulafp24s.ll	aeq1, aep1, aep2 }
    1962:	e2462d971f 	{ ae_lp16x2f.iu	aep1, a7, 4; ae_mulafp24s.hh	aeq0, aep1, aep2 }
    1967:	010b94        	ae_mulsfp24s.hl	aeq1, aep0, aep3
    196a:	e262ad881f 	{ ae_lp16x2f.iu	aep0, a8, 4; ae_mulafp24s.lh	aeq0, aep0, aep3 }

0000196f <synth_3band+0x6b>:
    196f:	f86b8ff99e 	{ addi	a9, a9, -1; ae_roundsp16q48asym	aep0, aeq1 }
    1974:	f863f2861f 	{ ae_sp16f.l.iu	aep0, a6, 2; ae_roundsp16q48asym	aep1, aeq0 }
    1979:	fd248c477e 	{ addi	a7, a7, -60; ae_zeroq56	aeq1 }
    197e:	fc0c4c488e 	{ addi	a8, a8, -60; ae_movq56	aeq0, aeq1 }
    1983:	429614        	ae_sp16f.l.iu	aep1, a6, 2
    1986:	faa956        	bnez	a9, 1934 <synth_3band+0x30>
    1989:	05c9           	s32i.n	a12, a5, 0
    198b:	f01d           	retw.n

0000198d <synth_3band+0x89>:
    198d:	000000                                        ...

00001990 <biquad_2cascade_24bitTx>:
    1990:	00a136        	entry	a1, 80
    1993:	542304        	ae_lp24x2.i	aep2, a3, 0
    1996:	541314        	ae_lp24x2.i	aep1, a3, 8
    1999:	540324        	ae_lp24x2.i	aep0, a3, 16
    199c:	6616a6        	blti	a6, 1, 1a06 <biquad_2cascade_24bitTx+0x76>
    199f:	18c472        	addi	a7, a4, 24
    19a2:	543414        	ae_lp24x2.i	aep3, a4, 8
    19a5:	545404        	ae_lp24x2.i	aep5, a4, 0
    19a8:	546444        	ae_lp24x2.i	aep6, a4, 32
    19ab:	547434        	ae_lp24x2.i	aep7, a4, 24
    19ae:	563154        	ae_sp24x2s.i	aep3, a1, 40
    19b1:	565144        	ae_sp24x2s.i	aep5, a1, 32
    19b4:	545424        	ae_lp24x2.i	aep5, a4, 16
    19b7:	543454        	ae_lp24x2.i	aep3, a4, 40
    19ba:	566134        	ae_sp24x2s.i	aep6, a1, 24
    19bd:	567124        	ae_sp24x2s.i	aep7, a1, 16
    19c0:	fec542        	addi	a4, a5, -2
    19c3:	fcc222        	addi	a2, a2, -4
    19c6:	4c4764        	ae_lp24.i	aep4, a7, 24
    19c9:	398676        	loop	a6, 1a06 <biquad_2cascade_24bitTx+0x76>
    19cc:	547154        	ae_lp24x2.i	aep7, a1, 40
    19cf:	f05eaee21f 	{ ae_lp24f.iu	aep6, a2, 4; ae_mulzaafp24s.hh.ll	aeq0, aep7, aep2 }
    19d4:	dd59b0714f 	{ ae_lp24x2.i	aep7, a1, 32; ae_selp24.lh	aep2, aep6, aep2 }
    19d9:	e25c30713f 	{ ae_lp24x2.i	aep7, a1, 24; ae_mulaafp24s.hh.ll	aeq0, aep7, aep2 }
    19de:	015184        	ae_mulsfp24s.hh	aeq0, aep5, aep1
    19e1:	0551c4        	ae_mulssfp24s.hh.ll	aeq0, aep5, aep1
    19e4:	f13ef0712f 	{ ae_lp24x2.i	aep7, a1, 16; ae_mulzaafp24s.hh.ll	aeq3, aep7, aep1 }
    19e9:	1b8d64        	ae_roundsp24q48asym	aep6, aeq0
    19ec:	1ae194        	ae_selp24.lh	aep1, aep6, aep1
    19ef:	05f904        	ae_mulaafp24s.hh.ll	aeq3, aep7, aep1
    19f2:	01b884        	ae_mulsfp24s.hh	aeq3, aep3, aep0
    19f5:	05b8c4        	ae_mulssfp24s.hh.ll	aeq3, aep3, aep0
    19f8:	1bbd64        	ae_roundsp24q48asym	aep6, aeq3
    19fb:	f0d2be602f 	{ ae_selp24.lh	aep0, aep6, aep0; ae_mulzaafp24s.hh.ll	aeq0, aep4, aep6 }
    1a00:	1b8f74        	ae_roundsp16q48asym	aep7, aeq0
    1a03:	42f414        	ae_sp16f.l.iu	aep7, a4, 2

00001a06 <biquad_2cascade_24bitTx+0x76>:
    1a06:	562304        	ae_sp24x2s.i	aep2, a3, 0
    1a09:	561314        	ae_sp24x2s.i	aep1, a3, 8
    1a0c:	560324        	ae_sp24x2s.i	aep0, a3, 16
    1a0f:	f01d           	retw.n

00001a11 <biquad_2cascade_24bitTx+0x81>:
    1a11:	000000                                        ...

00001a14 <conv_24_to_16>:
    1a14:	004136        	entry	a1, 32
    1a17:	540c           	movi.n	a4, 5
    1a19:	fcc332        	addi	a3, a3, -4
    1a1c:	f8c222        	addi	a2, a2, -8
    1a1f:	088476        	loop	a4, 1a2b <conv_24_to_16+0x17>
    1a22:	5c8214        	ae_lp24x2f.iu	aep0, a2, 8
    1a25:	090184        	ae_roundsp16asym	aep0, aep0
    1a28:	468314        	ae_sp16x2f.iu	aep0, a3, 4

00001a2b <conv_24_to_16+0x17>:
    1a2b:	f01d           	retw.n

00001a2d <conv_24_to_16+0x19>:
    1a2d:	000000                                        ...

00001a30 <gain_after_ec>:
    1a30:	00a136        	entry	a1, 80
    1a33:	f97bc1        	l32r	a12, 20 (7318 <p_ecnr_mem>)
    1a36:	05ed           	mov.n	a14, a5
    1a38:	55a5f2        	movi	a15, 0x555
    1a3b:	0c58           	l32i.n	a5, a12, 0
    1a3d:	04dd           	mov.n	a13, a4
    1a3f:	114fe0        	slli	a4, a15, 2
    1a42:	9169           	s32i.n	a6, a1, 36
    1a44:	443d04        	ae_lp16x2f.i	aep3, a13, 0
    1a47:	444e04        	ae_lp16x2f.i	aep4, a14, 0
    1a4a:	412544        	ae_lp16f.x	aep2, a5, a4
    1a4d:	07bc           	beqz.n	a7, 1a81 <gain_after_ec+0x51>
    1a4f:	1a0c           	movi.n	a10, 1
    1a51:	f9a141        	l32r	a4, d8 (521c <airoha_divide>)
    1a54:	11aa10        	slli	a10, a10, 15
    1a57:	07bd           	mov.n	a11, a7
    1a59:	0e5d           	mov.n	a5, a14
    1a5b:	0d6d           	mov.n	a6, a13
    1a5d:	562114        	ae_sp24x2s.i	aep2, a1, 8
    1a60:	563134        	ae_sp24x2s.i	aep3, a1, 24
    1a63:	564124        	ae_sp24x2s.i	aep4, a1, 16
    1a66:	0004e0        	callx8	a4
    1a69:	360b34        	ae_cvtq48a32s	aeq0, a11
    1a6c:	540114        	ae_lp24x2.i	aep0, a1, 8
    1a6f:	d4e230412f 	{ ae_lp24x2.i	aep4, a1, 16; ae_mulfq32sp16s.l	aeq0, aeq0, aep0 }
    1a74:	543134        	ae_lp24x2.i	aep3, a1, 24
    1a77:	340a94        	ae_sllaq56	aeq0, aeq0, a10
    1a7a:	f96793d66f 	{ or	a13, a6, a6; ae_roundsp24q48asym	aep2, aeq0 }
    1a7f:	05ed           	mov.n	a14, a5

00001a81 <gain_after_ec+0x51>:
    1a81:	fecd92        	addi	a9, a13, -2
    1a84:	fece82        	addi	a8, a14, -2
    1a87:	fec352        	addi	a5, a3, -2
    1a8a:	fec242        	addi	a4, a2, -2
    1a8d:	a60c           	movi.n	a6, 10
    1a8f:	8139           	s32i.n	a3, a1, 32
    1a91:	fec3b2        	addi	a11, a3, -2
    1a94:	fec2c2        	addi	a12, a2, -2
    1a97:	b1d9           	s32i.n	a13, a1, 44
    1a99:	a1e9           	s32i.n	a14, a1, 40
    1a9b:	08fd           	mov.n	a15, a8
    1a9d:	097d           	mov.n	a7, a9
    1a9f:	20a550        	or	a10, a5, a5
    1aa2:	203440        	or	a3, a4, a4
    1aa5:	598676        	loop	a6, 1b02 <gain_after_ec+0xd2>
    1aa8:	eb69ac8c1f 	{ ae_lp16f.iu	aep0, a12, 2; ae_mulfp24s.ll	aeq2, aep2, aep3 }
    1aad:	e868ac9b1f 	{ ae_lp16f.iu	aep1, a11, 2; ae_mulfp24s.hh	aeq0, aep2, aep3 }
    1ab2:	ea89faa18f 	{ ae_slliq56	aeq2, aeq2, 4; ae_mulfp24s.ll	aeq1, aep2, aep4 }
    1ab7:	e988fa810f 	{ ae_slliq56	aeq0, aeq0, 4; ae_mulfp24s.hh	aeq3, aep2, aep4 }
    1abc:	eb09ba213f 	{ ae_sq56s.i	aeq2, a1, 24; ae_mulfp24s.ll	aeq2, aep2, aep0 }
    1ac1:	ea29ba012f 	{ ae_sq56s.i	aeq0, a1, 16; ae_mulfp24s.ll	aeq0, aep2, aep1 }
    1ac6:	355114        	ae_slliq56	aeq1, aeq1, 4
    1ac9:	631114        	ae_sq56s.i	aeq1, a1, 8
    1acc:	356114        	ae_slliq56	aeq1, aeq2, 4
    1acf:	618124        	ae_lq56.i	aeq2, a1, 16
    1ad2:	fbf3bdc13f 	{ ae_lq56.i	aeq2, a1, 24; ae_roundsp16q48sym	aep6, aeq2 }
    1ad7:	fbf3edbd1f 	{ ae_lp16x2f.iu	aep3, a13, 4; ae_roundsp16q48sym	aep7, aeq2 }
    1adc:	fbebb2e71f 	{ ae_sp16f.l.iu	aep6, a7, 2; ae_roundsp16q48sym	aep6, aeq1 }
    1ae1:	35f114        	ae_slliq56	aeq3, aeq3, 4
    1ae4:	f8fbf2f71f 	{ ae_sp16f.l.iu	aep7, a7, 2; ae_roundsp16q48sym	aep1, aeq3 }
    1ae9:	350114        	ae_slliq56	aeq0, aeq0, 4
    1aec:	fbe3fde11f 	{ ae_lq56.i	aeq3, a1, 8; ae_roundsp16q48sym	aep7, aeq0 }
    1af1:	fafbedce1f 	{ ae_lp16x2f.iu	aep4, a14, 4; ae_roundsp16q48sym	aep5, aeq3 }
    1af6:	429f14        	ae_sp16f.l.iu	aep1, a15, 2
    1af9:	42df14        	ae_sp16f.l.iu	aep5, a15, 2
    1afc:	42e414        	ae_sp16f.l.iu	aep6, a4, 2
    1aff:	42fa14        	ae_sp16f.l.iu	aep7, a10, 2

00001b02 <gain_after_ec+0xd2>:
    1b02:	9148           	l32i.n	a4, a1, 36
    1b04:	a178           	l32i.n	a7, a1, 40
    1b06:	b1a8           	l32i.n	a10, a1, 44
    1b08:	021426        	beqi	a4, 1, 1b0e <gain_after_ec+0xde>
    1b0b:	002146        	j	1b94 <gain_after_ec+0x164>
    1b0e:	f94441        	l32r	a4, 20 (7318 <p_ecnr_mem>)
    1b11:	03fd           	mov.n	a15, a3
    1b13:	8138           	l32i.n	a3, a1, 32
    1b15:	0468           	l32i.n	a6, a4, 0
    1b17:	57a5b2        	movi	a11, 0x557
    1b1a:	aba2c2        	movi	a12, 0x2ab
    1b1d:	6d5c           	movi.n	a13, 86
    1b1f:	1ea7e2        	movi	a14, 0x71e
    1b22:	0aa042        	movi	a4, 10
    1b25:	440a04        	ae_lp16x2f.i	aep0, a10, 0
    1b28:	441704        	ae_lp16x2f.i	aep1, a7, 0
    1b2b:	11bbe0        	slli	a11, a11, 2
    1b2e:	11ccd0        	slli	a12, a12, 3
    1b31:	15ddd2        	addmi	a13, a13, 0x1500
    1b34:	90eee0        	addx2	a14, a14, a14
    1b37:	fec332        	addi	a3, a3, -2
    1b3a:	fec222        	addi	a2, a2, -2
    1b3d:	538476        	loop	a4, 1b94 <gain_after_ec+0x164>
    1b40:	4146b4        	ae_lp16f.x	aep4, a6, a11
    1b43:	e81099d6cf 	{ ae_lp16f.x	aep5, a6, a12; ae_mulfp24s.hh	aeq0, aep4, aep0 }
    1b48:	ea11eca21f 	{ ae_lp16f.iu	aep2, a2, 2; ae_mulfp24s.ll	aeq1, aep4, aep0 }
    1b4d:	e934ba802f 	{ ae_slliq56	aeq0, aeq0, 2; ae_mulfp24s.hh	aeq2, aep5, aep1 }
    1b52:	eb35fa906f 	{ ae_slliq56	aeq1, aeq1, 2; ae_mulfp24s.ll	aeq3, aep5, aep1 }
    1b57:	fae3ecb31f 	{ ae_lp16f.iu	aep3, a3, 2; ae_roundsp16q48sym	aep5, aeq0 }
    1b5c:	fbebad8a1f 	{ ae_lp16x2f.iu	aep0, a10, 4; ae_roundsp16q48sym	aep6, aeq1 }
    1b61:	42d914        	ae_sp16f.l.iu	aep5, a9, 2
    1b64:	42e914        	ae_sp16f.l.iu	aep6, a9, 2
    1b67:	35a094        	ae_slliq56	aeq2, aeq2, 2
    1b6a:	fbf3d9c6df 	{ ae_lp16f.x	aep4, a6, a13; ae_roundsp16q48sym	aep7, aeq2 }
    1b6f:	eb5199e6ef 	{ ae_lp16f.x	aep6, a6, a14; ae_mulfp24s.ll	aeq2, aep4, aep2 }
    1b74:	eb79fab02f 	{ ae_slliq56	aeq0, aeq3, 2; ae_mulfp24s.ll	aeq3, aep6, aep3 }
    1b79:	fae3faa06f 	{ ae_slliq56	aeq1, aeq2, 2; ae_roundsp16q48sym	aep5, aeq0 }
    1b7e:	fbebbab0ef 	{ ae_slliq56	aeq3, aeq3, 2; ae_roundsp16q48sym	aep6, aeq1 }
    1b83:	449714        	ae_lp16x2f.iu	aep1, a7, 4
    1b86:	fbfbf2f81f 	{ ae_sp16f.l.iu	aep7, a8, 2; ae_roundsp16q48sym	aep7, aeq3 }
    1b8b:	42d814        	ae_sp16f.l.iu	aep5, a8, 2
    1b8e:	42ef14        	ae_sp16f.l.iu	aep6, a15, 2
    1b91:	42f514        	ae_sp16f.l.iu	aep7, a5, 2

00001b94 <gain_after_ec+0x164>:
    1b94:	f01d           	retw.n

00001b96 <gain_after_ec+0x166>:
	...

00001b98 <adjust_phase>:
    1b98:	004136        	entry	a1, 32
    1b9b:	300334        	ae_cvtp24a16x2.ll	aep0, a3, a3
    1b9e:	360234        	ae_cvtq48a32s	aeq0, a2
    1ba1:	a10004        	ae_mulzaafq32sp16s.ll	aeq0, aeq0, aep0, aeq0, aep0
    1ba4:	1b8f04        	ae_roundsp16q48asym	aep0, aeq0
    1ba7:	0002d4        	ae_cvta32p24.l	a2, aep0
    1baa:	f01d           	retw.n

00001bac <adjust_bib_state>:
    1bac:	004136        	entry	a1, 32
    1baf:	840c           	movi.n	a4, 8
    1bb1:	fcc232        	addi	a3, a2, -4
    1bb4:	600204        	ae_lq32f.i	aeq0, a2, 0
    1bb7:	0a8476        	loop	a4, 1bc5 <adjust_bib_state+0x19>
    1bba:	350074        	ae_sraiq56	aeq0, aeq0, 1
    1bbd:	f867bd121f 	{ ae_lq32f.iu	aeq0, a2, 4; ae_roundsp24q48asym	aep0, aeq0 }
    1bc2:	528314        	ae_sp24f.l.iu	aep0, a3, 4

00001bc5 <adjust_bib_state+0x19>:
    1bc5:	f01d           	retw.n

00001bc7 <adjust_bib_state+0x1b>:
	...

00001bc8 <aec_post_prcs_var>:
    1bc8:	004136        	entry	a1, 32
    1bcb:	8188           	l32i.n	a8, a1, 32
    1bcd:	1a0c           	movi.n	a10, 1
    1bcf:	01aa90        	slli	a10, a10, 23
    1bd2:	d2aa80        	quos	a10, a10, a8
    1bd5:	6618a6        	blti	a8, 1, 1c3f <aec_post_prcs_var+0x77>
    1bd8:	ffa0d2        	movi	a13, 255
    1bdb:	300664        	ae_cvtp24a16x2.ll	aep0, a6, a6
    1bde:	301774        	ae_cvtp24a16x2.ll	aep1, a7, a7
    1be1:	7fdd62        	addmi	a6, a13, 0x7f00
    1be4:	dc06c24aef 	{ movi	a14, 0x24a; ae_subsp24s	aep1, aep1, aep0 }
    1be9:	39aaa4        	ae_movpa24x2	aep2, a10, a10
    1bec:	ea4599f2ef 	{ ae_lp16f.x	aep7, a2, a14; ae_mulfp24s.ll	aeq0, aep1, aep2 }
    1bf1:	303664        	ae_cvtp24a16x2.ll	aep3, a6, a6
    1bf4:	eb7dcfffff 	{ movi	a15, -1; ae_mulfp24s.ll	aeq3, aep7, aep3 }
    1bf9:	f867f0919e 	{ l32i	a9, a1, 36; ae_roundsp24q48asym	aep1, aeq0 }
    1bfe:	4169f0        	srli	a6, a15, 9
    1c01:	f97f8fe42e 	{ addi	a2, a4, -2; ae_roundsp24q48asym	aep2, aeq3 }
    1c06:	404304        	ae_lp16f.i	aep4, a3, 0
    1c09:	fec542        	addi	a4, a5, -2
    1c0c:	39b664        	ae_movpa24x2	aep3, a6, a6

00001c0f <aec_post_prcs_var+0x47>:
    1c0f:	078104        	ae_addsp24s	aep0, aep0, aep1
    1c12:	2419a6        	blti	a9, 1, 1c3a <aec_post_prcs_var+0x72>
    1c15:	07b0d4        	ae_subsp24s	aep5, aep3, aep0
    1c18:	015274        	ae_mulfp24s.ll	aeq0, aep5, aep2
    1c1b:	060934        	ae_roundsq32asym	aeq0, aeq0
    1c1e:	188976        	loop	a9, 1c3a <aec_post_prcs_var+0x72>
    1c21:	ea81ecf41f 	{ ae_lp16f.iu	aep7, a4, 2; ae_mulfp24s.ll	aeq1, aep0, aep4 }
    1c26:	d5fe2cc31f 	{ ae_lp16f.iu	aep4, a3, 2; ae_mulfq32sp16s.l	aeq2, aeq0, aep7 }
    1c2b:	065934        	ae_roundsq32asym	aeq1, aeq1
    1c2e:	35a094        	ae_slliq56	aeq2, aeq2, 2
    1c31:	015ac4        	ae_addq56	aeq1, aeq1, aeq2
    1c34:	1b9f54        	ae_roundsp16q48asym	aep5, aeq1
    1c37:	42d214        	ae_sp16f.l.iu	aep5, a2, 2

00001c3a <aec_post_prcs_var+0x72>:
    1c3a:	880b           	addi.n	a8, a8, -1
    1c3c:	fcf856        	bnez	a8, 1c0f <aec_post_prcs_var+0x47>

00001c3f <aec_post_prcs_var+0x77>:
    1c3f:	f01d           	retw.n

00001c41 <aec_post_prcs_var+0x79>:
    1c41:	000000                                        ...

00001c44 <gain_ref>:
    1c44:	004136        	entry	a1, 32
    1c47:	2514a6        	blti	a4, 1, 1c70 <gain_ref+0x2c>
    1c4a:	fcc222        	addi	a2, a2, -4
    1c4d:	300334        	ae_cvtp24a16x2.ll	aep0, a3, a3
    1c50:	449214        	ae_lp16x2f.iu	aep1, a2, 4
    1c53:	f03d           	nop.n
    1c55:	178476        	loop	a4, 1c70 <gain_ref+0x2c>
    1c58:	011054        	ae_mulfp24s.hl	aeq0, aep1, aep0
    1c5b:	ea05ed921f 	{ ae_lp16x2f.iu	aep1, a2, 4; ae_mulfp24s.ll	aeq1, aep1, aep0 }
    1c60:	350094        	ae_slliq56	aeq0, aeq0, 2
    1c63:	f963ba906f 	{ ae_slliq56	aeq1, aeq1, 2; ae_roundsp16q48asym	aep2, aeq0 }
    1c68:	f96bf222ef 	{ ae_sp16f.l.i	aep2, a2, -4; ae_roundsp16q48asym	aep3, aeq1 }
    1c6d:	4232f4        	ae_sp16f.l.i	aep3, a2, -2

00001c70 <gain_ref+0x2c>:
    1c70:	f01d           	retw.n

00001c72 <gain_ref+0x2e>:
	...

00001c74 <TxRef_VAD>:
    1c74:	006136        	entry	a1, 48
    1c77:	00a072        	movi	a7, 0
    1c7a:	0b15a6        	blti	a5, 1, 1c89 <TxRef_VAD+0x15>
    1c7d:	088576        	loop	a5, 1c89 <TxRef_VAD+0x15>
    1c80:	235d           	ae_l16si.n	a5, a3, 0
    1c82:	332b           	addi.n	a3, a3, 2
    1c84:	605150        	abs	a5, a5
    1c87:	757a           	add.n	a7, a5, a7

00001c89 <TxRef_VAD+0x15>:
    1c89:	0638           	l32i.n	a3, a6, 0
    1c8b:	f57c           	movi.n	a5, -1
    1c8d:	015510        	slli	a5, a5, 31
    1c90:	337a           	add.n	a3, a3, a7
    1c92:	448c           	beqz.n	a4, 1c9a <TxRef_VAD+0x26>
    1c94:	0639           	s32i.n	a3, a6, 0
    1c96:	020c           	movi.n	a2, 0
    1c98:	f01d           	retw.n

00001c9a <TxRef_VAD+0x26>:
    1c9a:	040c           	movi.n	a4, 0
    1c9c:	0649           	s32i.n	a4, a6, 0
    1c9e:	d3ac           	beqz.n	a3, 1ccf <TxRef_VAD+0x5b>
    1ca0:	40e340        	nsa	a4, a3
    1ca3:	401400        	ssl	a4
    1ca6:	761c           	movi.n	a6, 23
    1ca8:	a1a300        	sll	a10, a3
    1cab:	f91e31        	l32r	a3, 124 (4e0 <Log2_norm>)
    1cae:	c0b640        	sub	a11, a6, a4
    1cb1:	0003e0        	callx8	a3
    1cb4:	d1a432        	movi	a3, 0x4d1
    1cb7:	1133c0        	slli	a3, a3, 4
    1cba:	b26a30        	mulsh	a6, a10, a3
    1cbd:	823a30        	mull	a3, a10, a3
    1cc0:	d1a442        	movi	a4, 0x4d1
    1cc3:	1144f0        	slli	a4, a4, 1
    1cc6:	f35a           	add.n	a15, a3, a5
    1cc8:	464a           	add.n	a4, a6, a4
    1cca:	623f30        	saltu	a3, a15, a3
    1ccd:	434a           	add.n	a4, a3, a4
    1ccf:	039262        	l16si	a6, a2, 6
    1cd2:	049272        	l16si	a7, a2, 8
    1cd5:	029232        	l16si	a3, a2, 4
    1cd8:	11e600        	slli	a14, a6, 16
    1cdb:	11f700        	slli	a15, a7, 16
    1cde:	306650        	xor	a6, a6, a5
    1ce1:	307750        	xor	a7, a7, a5
    1ce4:	533430        	max	a3, a4, a3
    1ce7:	c046e0        	sub	a4, a6, a14
    1cea:	c067f0        	sub	a6, a7, a15
    1ced:	2149           	s32i.n	a4, a1, 8
    1cef:	3169           	s32i.n	a6, a1, 12
    1cf1:	418b           	addi.n	a4, a1, 8
    1cf3:	42a8           	l32i.n	a10, a2, 16
    1cf5:	f90c61        	l32r	a6, 128 (524 <siir_safr>)
    1cf8:	03bd           	mov.n	a11, a3
    1cfa:	04cd           	mov.n	a12, a4
    1cfc:	0006e0        	callx8	a6
    1cff:	059272        	l16si	a7, a2, 10
    1d02:	069282        	l16si	a8, a2, 12
    1d05:	42a9           	s32i.n	a10, a2, 16
    1d07:	119700        	slli	a9, a7, 16
    1d0a:	307750        	xor	a7, a7, a5
    1d0d:	30f850        	xor	a15, a8, a5
    1d10:	118800        	slli	a8, a8, 16
    1d13:	52a8           	l32i.n	a10, a2, 20
    1d15:	c07790        	sub	a7, a7, a9
    1d18:	c05f80        	sub	a5, a15, a8
    1d1b:	03bd           	mov.n	a11, a3
    1d1d:	04cd           	mov.n	a12, a4
    1d1f:	2179           	s32i.n	a7, a1, 8
    1d21:	3159           	s32i.n	a5, a1, 12
    1d23:	0006e0        	callx8	a6
    1d26:	4238           	l32i.n	a3, a2, 16
    1d28:	224d           	ae_l16si.n	a4, a2, 0
    1d2a:	52a9           	s32i.n	a10, a2, 20
    1d2c:	0c1272        	l16ui	a7, a2, 24
    1d2f:	334a           	add.n	a3, a3, a4
    1d31:	06a3a7        	bge	a3, a10, 1d3b <TxRef_VAD+0xc7>
    1d34:	130c           	movi.n	a3, 1
    1d36:	6239           	s32i.n	a3, a2, 24
    1d38:	000586        	j	1d52 <TxRef_VAD+0xde>

00001d3b <TxRef_VAD+0xc7>:
    1d3b:	0d9242        	l16si	a4, a2, 26
    1d3e:	073d           	mov.n	a3, a7
    1d40:	091766        	bnei	a7, 1, 1d4d <TxRef_VAD+0xd9>
    1d43:	325d           	ae_l16si.n	a5, a2, 2
    1d45:	04a547        	bge	a5, a4, 1d4d <TxRef_VAD+0xd9>
    1d48:	030c           	movi.n	a3, 0
    1d4a:	fffa06        	j	1d36 <TxRef_VAD+0xc2>

00001d4d <TxRef_VAD+0xd9>:
    1d4d:	441b           	addi.n	a4, a4, 1
    1d4f:	0d5242        	s16i	a4, a2, 26
    1d52:	832d           	ae_sext16	a2, a3
    1d54:	f01d           	retw.n

00001d56 <TxRef_VAD+0xe2>:
	...

00001d58 <Voice_PostEC120_Prcs>:
    1d58:	008136        	entry	a1, 64
    1d5b:	f8b1b1        	l32r	a11, 20 (7318 <p_ecnr_mem>)
    1d5e:	78a092        	movi	a9, 120
    1d61:	055c           	movi.n	a5, 80
    1d63:	0b78           	l32i.n	a7, a11, 0
    1d65:	6139           	s32i.n	a3, a1, 24
    1d67:	5149           	s32i.n	a4, a1, 20
    1d69:	35d782        	addmi	a8, a7, 0x3500
    1d6c:	460862        	l8ui	a6, a8, 70
    1d6f:	470882        	l8ui	a8, a8, 71
    1d72:	15a4c2        	movi	a12, 0x415
    1d75:	fdc6a2        	addi	a10, a6, -3
    1d78:	9359a0        	movnez	a5, a9, a10
    1d7b:	71a9           	s32i.n	a10, a1, 28
    1d7d:	c8ac           	beqz.n	a8, 1dad <Voice_PostEC120_Prcs+0x55>
    1d7f:	480b           	addi.n	a4, a8, -1
    1d81:	d14450        	mul16s	a4, a4, a5
    1d84:	116ce0        	slli	a6, a12, 2
    1d87:	904470        	addx2	a4, a4, a7
    1d8a:	f8a481        	l32r	a8, 1c (5d9c <xt_memcpy>)
    1d8d:	0b3d           	mov.n	a3, a11
    1d8f:	a46a           	add.n	a10, a4, a6
    1d91:	02bd           	mov.n	a11, a2
    1d93:	05cd           	mov.n	a12, a5
    1d95:	024d           	mov.n	a4, a2
    1d97:	0008e0        	callx8	a8
    1d9a:	0398           	l32i.n	a9, a3, 0
    1d9c:	35d922        	addmi	a2, a9, 0x3500
    1d9f:	470282        	l8ui	a8, a2, 71
    1da2:	d12580        	mul16s	a2, a5, a8
    1da5:	902290        	addx2	a2, a2, a9
    1da8:	626a           	add.n	a6, a2, a6
    1daa:	004286        	j	1eb8 <Voice_PostEC120_Prcs+0x160>

00001dad <Voice_PostEC120_Prcs+0x55>:
    1dad:	660b           	addi.n	a6, a6, -1
    1daf:	d18650        	mul16s	a8, a6, a5
    1db2:	15a4f2        	movi	a15, 0x415
    1db5:	116fe0        	slli	a6, a15, 2
    1db8:	908870        	addx2	a8, a8, a7
    1dbb:	a86a           	add.n	a10, a8, a6
    1dbd:	f89781        	l32r	a8, 1c (5d9c <xt_memcpy>)
    1dc0:	0b3d           	mov.n	a3, a11
    1dc2:	02bd           	mov.n	a11, a2
    1dc4:	05cd           	mov.n	a12, a5
    1dc6:	024d           	mov.n	a4, a2
    1dc8:	0008e0        	callx8	a8
    1dcb:	0388           	l32i.n	a8, a3, 0
    1dcd:	a86a           	add.n	a10, a8, a6
    1dcf:	f8d781        	l32r	a8, 12c (497c <NOISE_GEN_Prcs>)
    1dd2:	0abd           	mov.n	a11, a10
    1dd4:	0008e0        	callx8	a8
    1dd7:	0388           	l32i.n	a8, a3, 0
    1dd9:	f8d5a1        	l32r	a10, 130 (4ec4ec4f <_end+0x4ec47933>)
    1ddc:	8ca0f2        	movi	a15, 140
    1ddf:	2cd892        	addmi	a9, a8, 0x2c00
    1de2:	0c1992        	l16ui	a9, a9, 24
    1de5:	35d8b2        	addmi	a11, a8, 0x3500
    1de8:	909990        	addx2	a9, a9, a9
    1deb:	a09990        	addx4	a9, a9, a9
    1dee:	996b           	addi.n	a9, a9, 6
    1df0:	a299a0        	muluh	a9, a9, a10
    1df3:	a90ba2        	l8ui	a10, a11, 169
    1df6:	419290        	srli	a9, a9, 2
    1df9:	89bd           	ae_sext16	a11, a9
    1dfb:	35df92        	addmi	a9, a15, 0x3500
    1dfe:	33aba7        	bge	a11, a10, 1e35 <Voice_PostEC120_Prcs+0xdd>
    1e01:	35d8c2        	addmi	a12, a8, 0x3500
    1e04:	a80cc2        	l8ui	a12, a12, 168
    1e07:	35d822        	addmi	a2, a8, 0x3500
    1e0a:	35d8e2        	addmi	a14, a8, 0x3500
    1e0d:	2dacb7        	bge	a12, a11, 1e3e <Voice_PostEC120_Prcs+0xe6>
    1e10:	539ed2        	l16si	a13, a14, 166
    1e13:	529ee2        	l16si	a14, a14, 164
    1e16:	c0bbc0        	sub	a11, a11, a12
    1e19:	c0aac0        	sub	a10, a10, a12
    1e1c:	c0dde0        	sub	a13, a13, a14
    1e1f:	82bbd0        	mull	a11, a11, a13
    1e22:	80a0f2        	movi	a15, 128
    1e25:	11bb80        	slli	a11, a11, 8
    1e28:	d2aba0        	quos	a10, a11, a10
    1e2b:	aafa           	add.n	a10, a10, a15
    1e2d:	21a8a0        	srai	a10, a10, 8
    1e30:	aaea           	add.n	a10, a10, a14
    1e32:	0002c6        	j	1e41 <Voice_PostEC120_Prcs+0xe9>

00001e35 <Voice_PostEC120_Prcs+0xdd>:
    1e35:	35d8a2        	addmi	a10, a8, 0x3500
    1e38:	539aa2        	l16si	a10, a10, 166
    1e3b:	000086        	j	1e41 <Voice_PostEC120_Prcs+0xe9>

00001e3e <Voice_PostEC120_Prcs+0xe6>:
    1e3e:	5292a2        	l16si	a10, a2, 164
    1e41:	1c0c           	movi.n	a12, 1
    1e43:	ada1b2        	movi	a11, 0x1ad
    1e46:	11cc10        	slli	a12, a12, 15
    1e49:	b3a6d2        	movi	a13, 0x6b3
    1e4c:	11ddd0        	slli	a13, a13, 3
    1e4f:	11bbb0        	slli	a11, a11, 5
    1e52:	c0cca0        	sub	a12, a12, a10
    1e55:	6028b4        	ae_lq32f.x	aeq0, a8, a11
    1e58:	607d84        	ae_lq32f.xu	aeq1, a13, a8
    1e5b:	300ac4        	ae_cvtp24a16x2.ll	aep0, a10, a12
    1e5e:	0c0105f4ef 	{ movi	a14, 0x5f4; ae_mulzaafq32sp16s.lh	aeq0, aeq1, aep0, aeq0, aep0 }
    1e63:	457894        	ae_lp16x2f.x	aep7, a8, a9
    1e66:	b09ee0        	addx8	a9, a14, a14
    1e69:	fc447c498f 	{ ae_lq32f.xu	aeq2, a9, a8; ae_roundsq32sym	aeq0, aeq0 }
    1e6e:	35d822        	addmi	a2, a8, 0x3500
    1e71:	0cfe6482fe 	{ l16si	a15, a2, 144; ae_mulzaafq32sp16s.lh	aeq1, aeq0, aep7, aeq2, aep7 }
    1e76:	686a           	add.n	a6, a8, a6
    1e78:	ff2c798d0f 	{ ae_sq32f.i	aeq0, a13, 0; ae_roundsq32asym	aeq3, aeq1 }
    1e7d:	36ba04        	ae_trunca32q48	a10, aeq3
    1e80:	f89681        	l32r	a8, d8 (521c <airoha_divide>)
    1e83:	11bf00        	slli	a11, a15, 16
    1e86:	09a9           	s32i.n	a10, a9, 0
    1e88:	0008e0        	callx8	a8
    1e8b:	feca92        	addi	a9, a10, -2
    1e8e:	360b34        	ae_cvtq48a32s	aeq0, a11
    1e91:	f863d1        	l32r	a13, 20 (7318 <p_ecnr_mem>)
    1e94:	fc24fe890f 	{ ae_slaasq56s	aeq0, aeq0, a9; nop }
    1e99:	f86380018f 	{ movi	a8, 1; ae_roundsp16q48asym	aep0, aeq0 }
    1e9e:	0d98           	l32i.n	a9, a13, 0
    1ea0:	360c24        	ae_trunca16p24s.l	a12, aep0
    1ea3:	499222        	l16si	a2, a2, 146
    1ea6:	118830        	slli	a8, a8, 13
    1ea9:	538c80        	max	a8, a12, a8
    1eac:	35d9f2        	addmi	a15, a9, 0x3500
    1eaf:	432820        	min	a2, a8, a2
    1eb2:	470f82        	l8ui	a8, a15, 71
    1eb5:	255f22        	s16i	a2, a15, 74
    1eb8:	2ad722        	addmi	a2, a7, 0x2a00
    1ebb:	101222        	l16ui	a2, a2, 32
    1ebe:	35d992        	addmi	a9, a9, 0x3500
    1ec1:	7138           	l32i.n	a3, a1, 28
    1ec3:	043216        	beqz	a2, 1f0a <Voice_PostEC120_Prcs+0x1b2>
    1ec6:	2499e2        	l16si	a14, a9, 72
    1ec9:	850c           	movi.n	a5, 8
    1ecb:	520c           	movi.n	a2, 5
    1ecd:	28d7d2        	addmi	a13, a7, 0x2800
    1ed0:	932530        	movnez	a2, a5, a3
    1ed3:	3d5d           	ae_l16si.n	a5, a13, 2
    1ed5:	d188e0        	mul16s	a8, a8, a14
    1ed8:	ffa0f2        	movi	a15, 255
    1edb:	fb0c           	movi.n	a11, 15
    1edd:	0c1c           	movi.n	a12, 16
    1edf:	585a           	add.n	a5, a8, a5
    1ee1:	93cb30        	movnez	a12, a11, a3
    1ee4:	fba4a2        	movi	a10, 0x4fb
    1ee7:	7fdf92        	addmi	a9, a15, 0x7f00
    1eea:	35ea           	add.n	a3, a5, a14
    1eec:	11aad0        	slli	a10, a10, 3
    1eef:	11c9           	s32i.n	a12, a1, 4
    1ef1:	43f390        	min	a15, a3, a9
    1ef4:	f89031        	l32r	a3, 134 (1bc8 <aec_post_prcs_var>)
    1ef7:	61c8           	l32i.n	a12, a1, 24
    1ef9:	a7aa           	add.n	a10, a7, a10
    1efb:	43e590        	min	a14, a5, a9
    1efe:	04bd           	mov.n	a11, a4
    1f00:	06dd           	mov.n	a13, a6
    1f02:	0129           	s32i.n	a2, a1, 0
    1f04:	0003e0        	callx8	a3
    1f07:	0002c6        	j	1f16 <Voice_PostEC120_Prcs+0x1be>

00001f0a <Voice_PostEC120_Prcs+0x1b2>:
    1f0a:	f84421        	l32r	a2, 1c (5d9c <xt_memcpy>)
    1f0d:	61a8           	l32i.n	a10, a1, 24
    1f0f:	04bd           	mov.n	a11, a4
    1f11:	05cd           	mov.n	a12, a5
    1f13:	0002e0        	callx8	a2
    1f16:	f84221        	l32r	a2, 20 (7318 <p_ecnr_mem>)
    1f19:	5148           	l32i.n	a4, a1, 20
    1f1b:	030c           	movi.n	a3, 0
    1f1d:	0228           	l32i.n	a2, a2, 0
    1f1f:	743d           	ae_s16i.n	a3, a4, 2
    1f21:	27d2f2        	addmi	a15, a2, 0x2700
    1f24:	35d222        	addmi	a2, a2, 0x3500
    1f27:	6c9f32        	l16si	a3, a15, 216
    1f2a:	259222        	l16si	a2, a2, 74
    1f2d:	643d           	ae_s16i.n	a3, a4, 0
    1f2f:	025422        	s16i	a2, a4, 4
    1f32:	f01d           	retw.n

00001f34 <Voice_EC120_Prcs>:
    1f34:	006136        	entry	a1, 48
    1f37:	f88081        	l32r	a8, 138 (1f50 <Voice_EC_Prcs_common>)
    1f3a:	070c           	movi.n	a7, 0
    1f3c:	0c0c           	movi.n	a12, 0
    1f3e:	02ad           	mov.n	a10, a2
    1f40:	03bd           	mov.n	a11, a3
    1f42:	04dd           	mov.n	a13, a4
    1f44:	05ed           	mov.n	a14, a5
    1f46:	06fd           	mov.n	a15, a6
    1f48:	0179           	s32i.n	a7, a1, 0
    1f4a:	0008e0        	callx8	a8
    1f4d:	f01d           	retw.n

00001f4f <Voice_EC120_Prcs+0x1b>:
	...

00001f50 <Voice_EC_Prcs_common>:
    1f50:	034136        	entry	a1, 0x1a0
    1f53:	f833f1        	l32r	a15, 20 (7318 <p_ecnr_mem>)
    1f56:	06ed           	mov.n	a14, a6
    1f58:	136172        	s32i	a7, a1, 76
    1f5b:	0f68           	l32i.n	a6, a15, 0
    1f5d:	02bd           	mov.n	a11, a2
    1f5f:	120c           	movi.n	a2, 1
    1f61:	15d6d2        	addmi	a13, a6, 0x1500
    1f64:	2f1d72        	l16ui	a7, a13, 94
    1f67:	35d6a2        	addmi	a10, a6, 0x3500
    1f6a:	460ac2        	l8ui	a12, a10, 70
    1f6d:	fec772        	addi	a7, a7, -2
    1f70:	622720        	saltu	a2, a7, a2
    1f73:	78a082        	movi	a8, 120
    1f76:	0d5c           	movi.n	a13, 80
    1f78:	fdcc72        	addi	a7, a12, -3
    1f7b:	106142        	s32i	a4, a1, 64
    1f7e:	040c           	movi.n	a4, 0
    1f80:	93d870        	movnez	a13, a8, a7
    1f83:	624430        	saltu	a4, a4, a3
    1f86:	186132        	s32i	a3, a1, 96
    1f89:	470a32        	l8ui	a3, a10, 71
    1f8c:	35d682        	addmi	a8, a6, 0x3500
    1f8f:	102420        	and	a2, a4, a2
    1f92:	431b           	addi.n	a4, a3, 1
    1f94:	74a040        	extui	a10, a4, 0, 8
    1f97:	c03ac0        	sub	a3, a10, a12
    1f9a:	2ad6c2        	addmi	a12, a6, 0x2a00
    1f9d:	933430        	movnez	a3, a4, a3
    1fa0:	101c42        	l16ui	a4, a12, 32
    1fa3:	474832        	s8i	a3, a8, 71
    1fa6:	5ba3a2        	movi	a10, 0x35b
    1fa9:	09a416        	beqz	a4, 2047 <Voice_EC_Prcs_common+0xf7>
    1fac:	2561e2        	s32i	a14, a1, 148
    1faf:	35d682        	addmi	a8, a6, 0x3500
    1fb2:	74c030        	extui	a12, a3, 0, 8
    1fb5:	114ad0        	slli	a4, a10, 3
    1fb8:	57a3e2        	movi	a14, 0x357
    1fbb:	6ca032        	movi	a3, 108
    1fbe:	126172        	s32i	a7, a1, 72
    1fc1:	e199           	s32i.n	a9, a1, 56
    1fc3:	0b7d           	mov.n	a7, a11
    1fc5:	119ec0        	slli	a9, a14, 4
    1fc8:	e64a           	add.n	a14, a6, a4
    1fca:	35d3b2        	addmi	a11, a3, 0x3500
    1fcd:	2c28a2        	l32i	a10, a8, 176
    1fd0:	f85b41        	l32r	a4, 13c (1c74 <TxRef_VAD>)
    1fd3:	c1a9           	s32i.n	a10, a1, 48
    1fd5:	d1e9           	s32i.n	a14, a1, 52
    1fd7:	e6ba           	add.n	a14, a6, a11
    1fd9:	a69a           	add.n	a10, a6, a9
    1fdb:	05bd           	mov.n	a11, a5
    1fdd:	053d           	mov.n	a3, a5
    1fdf:	f1d9           	s32i.n	a13, a1, 60
    1fe1:	0f5d           	mov.n	a5, a15
    1fe3:	0004e0        	callx8	a4
    1fe6:	0588           	l32i.n	a8, a5, 0
    1fe8:	2f6122        	s32i	a2, a1, 188
    1feb:	236172        	s32i	a7, a1, 140
    1fee:	35d842        	addmi	a4, a8, 0x3500
    1ff1:	470492        	l8ui	a9, a4, 71
    1ff4:	15d842        	addmi	a4, a8, 0x1500
    1ff7:	f1e8           	l32i.n	a14, a1, 60
    1ff9:	06b916        	beqz	a9, 2068 <Voice_EC_Prcs_common+0x118>
    1ffc:	319442        	l16si	a4, a4, 98
    1fff:	d128           	l32i.n	a2, a1, 52
    2001:	021926        	beqi	a9, 1, 2007 <Voice_EC_Prcs_common+0xb7>
    2004:	002886        	j	20aa <Voice_EC_Prcs_common+0x15a>
    2007:	eca572        	movi	a7, 0x5ec
    200a:	b07770        	addx8	a7, a7, a7
    200d:	a87a           	add.n	a10, a8, a7
    200f:	050c           	movi.n	a5, 0
    2011:	28d6b2        	addmi	a11, a6, 0x2800
    2014:	f82971        	l32r	a7, b8 (5d88 <xt_memset>)
    2017:	28d692        	addmi	a9, a6, 0x2800
    201a:	1e6b52        	s32i	a5, a11, 120
    201d:	1f6b52        	s32i	a5, a11, 124
    2020:	2e6b52        	s32i	a5, a11, 184
    2023:	2f6b52        	s32i	a5, a11, 188
    2026:	0b0c           	movi.n	a11, 0
    2028:	ec0c           	movi.n	a12, 14
    202a:	e959           	s32i.n	a5, a9, 56
    202c:	3e6952        	s32i	a5, a9, 248
    202f:	f959           	s32i.n	a5, a9, 60
    2031:	3f6952        	s32i	a5, a9, 252
    2034:	0007e0        	callx8	a7
    2037:	f7fa81        	l32r	a8, 20 (7318 <p_ecnr_mem>)
    203a:	f1e8           	l32i.n	a14, a1, 60
    203c:	0888           	l32i.n	a8, a8, 0
    203e:	35d892        	addmi	a9, a8, 0x3500
    2041:	1a6952        	s32i	a5, a9, 104
    2044:	001886        	j	20aa <Voice_EC_Prcs_common+0x15a>

00002047 <Voice_EC_Prcs_common+0xf7>:
    2047:	f7f531        	l32r	a3, 1c (5d9c <xt_memcpy>)
    204a:	0ead           	mov.n	a10, a14
    204c:	0dcd           	mov.n	a12, a13
    204e:	024d           	mov.n	a4, a2
    2050:	0d2d           	mov.n	a2, a13
    2052:	0003e0        	callx8	a3
    2055:	14cc           	bnez.n	a4, 205a <Voice_EC_Prcs_common+0x10a>
    2057:	03a4c6        	j	2eee <Voice_EC_Prcs_common+0xf9e>
    205a:	1321a2        	l32i	a10, a1, 76
    205d:	1821b2        	l32i	a11, a1, 96
    2060:	02cd           	mov.n	a12, a2
    2062:	0003e0        	callx8	a3
    2065:	03a146        	j	2eee <Voice_EC_Prcs_common+0xf9e>

00002068 <Voice_EC_Prcs_common+0x118>:
    2068:	15d892        	addmi	a9, a8, 0x1500
    206b:	319942        	l16si	a4, a9, 98
    206e:	5aac           	beqz.n	a10, 2097 <Voice_EC_Prcs_common+0x147>
    2070:	1a6c           	movi.n	a10, -31
    2072:	0924a7        	blt	a4, a10, 207f <Voice_EC_Prcs_common+0x12f>
    2075:	440b           	addi.n	a4, a4, -1
    2077:	fa7c           	movi.n	a10, -1
    2079:	4344a0        	min	a4, a4, a10
    207c:	315942        	s16i	a4, a9, 98
    207f:	28d692        	addmi	a9, a6, 0x2800
    2082:	0499a2        	l16si	a10, a9, 8
    2085:	f1e8           	l32i.n	a14, a1, 60
    2087:	d128           	l32i.n	a2, a1, 52
    2089:	ffa1b2        	movi	a11, 0x1ff
    208c:	182ba7        	blt	a11, a10, 20a8 <Voice_EC_Prcs_common+0x158>
    208f:	aa1b           	addi.n	a10, a10, 1
    2091:	0459a2        	s16i	a10, a9, 8
    2094:	000406        	j	20a8 <Voice_EC_Prcs_common+0x158>

00002097 <Voice_EC_Prcs_common+0x147>:
    2097:	f1e8           	l32i.n	a14, a1, 60
    2099:	d128           	l32i.n	a2, a1, 52
    209b:	09c4e6        	bgei	a4, 32, 20a8 <Voice_EC_Prcs_common+0x158>
    209e:	441b           	addi.n	a4, a4, 1
    20a0:	1a0c           	movi.n	a10, 1
    20a2:	5344a0        	max	a4, a4, a10
    20a5:	315942        	s16i	a4, a9, 98
    20a8:	844d           	ae_sext16	a4, a4
    20aa:	250c           	movi.n	a5, 2
    20ac:	dda4f2        	movi	a15, 0x4dd
    20af:	196152        	s32i	a5, a1, 100
    20b2:	115fe0        	slli	a5, a15, 2
    20b5:	35d892        	addmi	a9, a8, 0x3500
    20b8:	c85a           	add.n	a12, a8, a5
    20ba:	2219d2        	l16ui	a13, a9, 68
    20bd:	f82051        	l32r	a5, 140 (1630 <mic_delay>)
    20c0:	02ad           	mov.n	a10, a2
    20c2:	03bd           	mov.n	a11, a3
    20c4:	0e2d           	mov.n	a2, a14
    20c6:	0005e0        	callx8	a5
    20c9:	01d1a2        	addmi	a10, a1, 0x100
    20cc:	f7fb51        	l32r	a5, b8 (5d88 <xt_memset>)
    20cf:	60caa2        	addi	a10, a10, 96
    20d2:	0b0c           	movi.n	a11, 0
    20d4:	ec0c           	movi.n	a12, 14
    20d6:	070c           	movi.n	a7, 0
    20d8:	0005e0        	callx8	a5
    20db:	c138           	l32i.n	a3, a1, 48
    20dd:	25d652        	addmi	a5, a6, 0x2500
    20e0:	1b6162        	s32i	a6, a1, 108
    20e3:	05d382        	addmi	a8, a3, 0x500
    20e6:	036d           	mov.n	a6, a3
    20e8:	102132        	l32i	a3, a1, 64
    20eb:	34a592        	movi	a9, 0x534
    20ee:	f09990        	subx8	a9, a9, a9
    20f1:	2d6182        	s32i	a8, a1, 180
    20f4:	245572        	s16i	a7, a5, 72
    20f7:	07b316        	beqz	a3, 2176 <Voice_EC_Prcs_common+0x226>
    20fa:	2d2182        	l32i	a8, a1, 180
    20fd:	070c           	movi.n	a7, 0
    20ff:	04d652        	addmi	a5, a6, 0x400
    2102:	289d           	ae_l16si.n	a9, a8, 0
    2104:	d46672        	s32i	a7, a6, 0x350
    2107:	e46672        	s32i	a7, a6, 0x390
    210a:	f46672        	s32i	a7, a6, 0x3d0
    210d:	d56672        	s32i	a7, a6, 0x354
    2110:	e56672        	s32i	a7, a6, 0x394
    2113:	f56672        	s32i	a7, a6, 0x3d4
    2116:	4579           	s32i.n	a7, a5, 16
    2118:	5579           	s32i.n	a7, a5, 20
    211a:	418120        	srli	a8, a2, 1
    211d:	398994        	ae_movpa24x2	aep0, a9, a9
    2120:	209330        	or	a9, a3, a3
    2123:	441304        	ae_lp16x2f.i	aep1, a3, 0
    2126:	20e220        	or	a14, a2, a2
    2129:	188876        	loop	a8, 2145 <Voice_EC_Prcs_common+0x1f5>
    212c:	011054        	ae_mulfp24s.hl	aeq0, aep1, aep0
    212f:	011874        	ae_mulfp24s.ll	aeq1, aep1, aep0
    2132:	350214        	ae_slliq56	aeq0, aeq0, 8
    2135:	fb63fa924f 	{ ae_slliq56	aeq1, aeq1, 8; ae_roundsp16q48asym	aep7, aeq0 }
    213a:	f96bb2790f 	{ ae_sp16f.l.i	aep7, a9, 0; ae_roundsp16q48asym	aep2, aeq1 }
    213f:	422914        	ae_sp16f.l.i	aep2, a9, 2
    2142:	449914        	ae_lp16x2f.iu	aep1, a9, 4

00002145 <Voice_EC_Prcs_common+0x1f5>:
    2145:	f7b651        	l32r	a5, 20 (7318 <p_ecnr_mem>)
    2148:	1021f2        	l32i	a15, a1, 64
    214b:	05a8           	l32i.n	a10, a5, 0
    214d:	fccf92        	addi	a9, a15, -4
    2150:	f8cab2        	addi	a11, a10, -8
    2153:	f03d           	nop.n
    2155:	058876        	loop	a8, 215e <Voice_EC_Prcs_common+0x20e>
    2158:	448914        	ae_lp16x2f.iu	aep0, a9, 4
    215b:	5e8b14        	ae_sp24x2f.iu	aep0, a11, 8
    215e:	c1b8           	l32i.n	a11, a1, 48
    2160:	1021d2        	l32i	a13, a1, 64
    2163:	f7f851        	l32r	a5, 144 (1990 <biquad_2cascade_24bitTx>)
    2166:	58cbc2        	addi	a12, a11, 88
    2169:	0b6d           	mov.n	a6, a11
    216b:	0e2d           	mov.n	a2, a14
    216d:	0005e0        	callx8	a5
    2170:	34a592        	movi	a9, 0x534
    2173:	f09990        	subx8	a9, a9, a9

00002176 <Voice_EC_Prcs_common+0x226>:
    2176:	e138           	l32i.n	a3, a1, 56
    2178:	1b2152        	l32i	a5, a1, 108
    217b:	fba432        	movi	a3, 0x4fb
    217e:	1133d0        	slli	a3, a3, 3
    2181:	8fa0c2        	movi	a12, 143
    2184:	1921d2        	l32i	a13, a1, 100
    2187:	1221e2        	l32i	a14, a1, 72
    218a:	853a           	add.n	a8, a5, a3
    218c:	113ca0        	slli	a3, a12, 6
    218f:	753a           	add.n	a7, a5, a3
    2191:	316142        	s32i	a4, a1, 196
    2194:	8ca042        	movi	a4, 140
    2197:	6821b2        	l32i	a11, a1, 0x1a0
    219a:	3f0c           	movi.n	a15, 3
    219c:	93dfe0        	movnez	a13, a15, a14
    219f:	359a           	add.n	a3, a5, a9
    21a1:	b8a3a2        	movi	a10, 0x3b8
    21a4:	2261b2        	s32i	a11, a1, 136
    21a7:	78a3b2        	movi	a11, 0x378
    21aa:	1a6182        	s32i	a8, a1, 104
    21ad:	1c6172        	s32i	a7, a1, 112
    21b0:	464a           	add.n	a4, a6, a4
    21b2:	45a172        	movi	a7, 0x145
    21b5:	43a182        	movi	a8, 0x143
    21b8:	38a492        	movi	a9, 0x438
    21bb:	38a3c2        	movi	a12, 0x338
    21be:	78a4e2        	movi	a14, 0x478
    21c1:	30a3f2        	movi	a15, 0x330
    21c4:	1961d2        	s32i	a13, a1, 100
    21c7:	f8a3d2        	movi	a13, 0x3f8
    21ca:	346132        	s32i	a3, a1, 208
    21cd:	1137b0        	slli	a3, a7, 5
    21d0:	1178b0        	slli	a7, a8, 5
    21d3:	516142        	s32i	a4, a1, 0x144
    21d6:	a6aa           	add.n	a10, a6, a10
    21d8:	b6ba           	add.n	a11, a6, a11
    21da:	41a142        	movi	a4, 0x141
    21dd:	969a           	add.n	a9, a6, a9
    21df:	4f61a2        	s32i	a10, a1, 0x13c
    21e2:	4e61b2        	s32i	a11, a1, 0x138
    21e5:	c6ca           	add.n	a12, a6, a12
    21e7:	d6da           	add.n	a13, a6, a13
    21e9:	e6ea           	add.n	a14, a6, a14
    21eb:	f6fa           	add.n	a15, a6, a15
    21ed:	068d           	mov.n	a8, a6
    21ef:	1164b0        	slli	a6, a4, 5
    21f2:	757a           	add.n	a7, a5, a7
    21f4:	47a1a2        	movi	a10, 0x147
    21f7:	4da1b2        	movi	a11, 0x14d
    21fa:	506192        	s32i	a9, a1, 0x140
    21fd:	956a           	add.n	a9, a5, a6
    21ff:	4c61e2        	s32i	a14, a1, 0x130
    2202:	4b61f2        	s32i	a15, a1, 0x12c
    2205:	566172        	s32i	a7, a1, 0x158
    2208:	116ab0        	slli	a6, a10, 5
    220b:	117bb0        	slli	a7, a11, 5
    220e:	4ba1e2        	movi	a14, 0x14b
    2211:	49a1f2        	movi	a15, 0x149
    2214:	4d61c2        	s32i	a12, a1, 0x134
    2217:	c56a           	add.n	a12, a5, a6
    2219:	3d61d2        	s32i	a13, a1, 244
    221c:	d57a           	add.n	a13, a5, a7
    221e:	353a           	add.n	a3, a5, a3
    2220:	116eb0        	slli	a6, a14, 5
    2223:	117fb0        	slli	a7, a15, 5
    2226:	576132        	s32i	a3, a1, 0x15c
    2229:	356a           	add.n	a3, a5, a6
    222b:	657a           	add.n	a6, a5, a7
    222d:	556192        	s32i	a9, a1, 0x154
    2230:	4fa172        	movi	a7, 0x14f
    2233:	c93c           	movi.n	a9, 60
    2235:	5461c2        	s32i	a12, a1, 0x150
    2238:	436162        	s32i	a6, a1, 0x10c
    223b:	1167b0        	slli	a6, a7, 5
    223e:	24d972        	addmi	a7, a9, 0x2400
    2241:	44a7c2        	movi	a12, 0x744
    2244:	a56a           	add.n	a10, a5, a6
    2246:	a06cc0        	addx4	a6, a12, a12
    2249:	b57a           	add.n	a11, a5, a7
    224b:	412120        	srli	a2, a2, 1
    224e:	01d1c2        	addmi	a12, a1, 0x100
    2251:	4561d2        	s32i	a13, a1, 0x114
    2254:	446132        	s32i	a3, a1, 0x110
    2257:	3c61b2        	s32i	a11, a1, 240
    225a:	2ba1d2        	movi	a13, 0x12b
    225d:	326122        	s32i	a2, a1, 200
    2260:	68cc22        	addi	a2, a12, 104
    2263:	eca032        	movi	a3, 236
    2266:	f76eb1        	l32r	a11, 20 (7318 <p_ecnr_mem>)
    2269:	117db0        	slli	a7, a13, 5
    226c:	e56a           	add.n	a14, a5, a6
    226e:	25d362        	addmi	a6, a3, 0x2500
    2271:	536122        	s32i	a2, a1, 0x14c
    2274:	29d522        	addmi	a2, a5, 0x2900
    2277:	cfa442        	movi	a4, 0x4cf
    227a:	01d132        	addmi	a3, a1, 0x100
    227d:	f57a           	add.n	a15, a5, a7
    227f:	956a           	add.n	a9, a5, a6
    2281:	1174d0        	slli	a7, a4, 3
    2284:	6cc342        	addi	a4, a3, 108
    2287:	206122        	s32i	a2, a1, 128
    228a:	23d522        	addmi	a2, a5, 0x2300
    228d:	23d532        	addmi	a3, a5, 0x2300
    2290:	01d162        	addmi	a6, a1, 0x100
    2293:	4261a2        	s32i	a10, a1, 0x108
    2296:	a57a           	add.n	a10, a5, a7
    2298:	0b78           	l32i.n	a7, a11, 0
    229a:	1f6142        	s32i	a4, a1, 124
    229d:	64c642        	addi	a4, a6, 100
    22a0:	29d5b2        	addmi	a11, a5, 0x2900
    22a3:	386122        	s32i	a2, a1, 224
    22a6:	376132        	s32i	a3, a1, 220
    22a9:	24d562        	addmi	a6, a5, 0x2400
    22ac:	01d132        	addmi	a3, a1, 0x100
    22af:	3f61b2        	s32i	a11, a1, 252
    22b2:	156162        	s32i	a6, a1, 84
    22b5:	25d5b2        	addmi	a11, a5, 0x2500
    22b8:	356122        	s32i	a2, a1, 212
    22bb:	70c322        	addi	a2, a3, 112
    22be:	01d162        	addmi	a6, a1, 0x100
    22c1:	3b61e2        	s32i	a14, a1, 236
    22c4:	1d61f2        	s32i	a15, a1, 116
    22c7:	28d5d2        	addmi	a13, a5, 0x2800
    22ca:	28d5e2        	addmi	a14, a5, 0x2800
    22cd:	28d5f2        	addmi	a15, a5, 0x2800
    22d0:	1661b2        	s32i	a11, a1, 88
    22d3:	276122        	s32i	a2, a1, 156
    22d6:	74c622        	addi	a2, a6, 116
    22d9:	01d1b2        	addmi	a11, a1, 0x100
    22dc:	2a6192        	s32i	a9, a1, 168
    22df:	2961a2        	s32i	a10, a1, 164
    22e2:	1261d2        	s32i	a13, a1, 72
    22e5:	2461e2        	s32i	a14, a1, 144
    22e8:	3061f2        	s32i	a15, a1, 192
    22eb:	29d592        	addmi	a9, a5, 0x2900
    22ee:	29d5a2        	addmi	a10, a5, 0x2900
    22f1:	2ad5c2        	addmi	a12, a5, 0x2a00
    22f4:	18c1d2        	addi	a13, a1, 24
    22f7:	20c1e2        	addi	a14, a1, 32
    22fa:	24d5f2        	addmi	a15, a5, 0x2400
    22fd:	496122        	s32i	a2, a1, 0x124
    2300:	78cb22        	addi	a2, a11, 120
    2303:	2e6192        	s32i	a9, a1, 184
    2306:	4061a2        	s32i	a10, a1, 0x100
    2309:	3e61c2        	s32i	a12, a1, 248
    230c:	3a61d2        	s32i	a13, a1, 232
    230f:	3961e2        	s32i	a14, a1, 228
    2312:	2661f2        	s32i	a15, a1, 152
    2315:	24d592        	addmi	a9, a5, 0x2400
    2318:	24d5a2        	addmi	a10, a5, 0x2400
    231b:	25d5c2        	addmi	a12, a5, 0x2500
    231e:	26d5d2        	addmi	a13, a5, 0x2600
    2321:	23d5e2        	addmi	a14, a5, 0x2300
    2324:	27d5f2        	addmi	a15, a5, 0x2700
    2327:	476122        	s32i	a2, a1, 0x11c
    232a:	252132        	l32i	a3, a1, 148
    232d:	d128           	l32i.n	a2, a1, 52
    232f:	232162        	l32i	a6, a1, 140
    2332:	416142        	s32i	a4, a1, 0x104
    2335:	336192        	s32i	a9, a1, 204
    2338:	1461a2        	s32i	a10, a1, 80
    233b:	1761c2        	s32i	a12, a1, 92
    233e:	1161d2        	s32i	a13, a1, 68
    2341:	3661e2        	s32i	a14, a1, 216
    2344:	2861f2        	s32i	a15, a1, 160
    2347:	05d842        	addmi	a4, a8, 0x500
    234a:	18c852        	addi	a5, a8, 24
    234d:	04d892        	addmi	a9, a8, 0x400
    2350:	38c8a2        	addi	a10, a8, 56
    2353:	05d8c2        	addmi	a12, a8, 0x500
    2356:	1321e2        	l32i	a14, a1, 76
    2359:	1021f2        	l32i	a15, a1, 64
    235c:	05a1d2        	movi	a13, 0x105
    235f:	4a6142        	s32i	a4, a1, 0x128
    2362:	114dc0        	slli	a4, a13, 4
    2365:	2b6152        	s32i	a5, a1, 172
    2368:	486192        	s32i	a9, a1, 0x120
    236b:	2c61a2        	s32i	a10, a1, 176
    236e:	4661c2        	s32i	a12, a1, 0x118
    2371:	1e61e2        	s32i	a14, a1, 120
    2374:	2161f2        	s32i	a15, a1, 132
    2377:	003986        	j	2461 <Voice_EC_Prcs_common+0x511>

0000237a <Voice_EC_Prcs_common+0x42a>:
    237a:	d6a8           	l32i.n	a10, a6, 52
    237c:	f74f71        	l32r	a7, b8 (5d88 <xt_memset>)
    237f:	0b0c           	movi.n	a11, 0
    2381:	4c1c           	movi.n	a12, 20
    2383:	0007e0        	callx8	a7
    2386:	02ad           	mov.n	a10, a2
    2388:	4e21b2        	l32i	a11, a1, 0x138
    238b:	f77321        	l32r	a2, 158 (efc <subband_aec_mid_channel>)
    238e:	2d0c           	movi.n	a13, 2
    2390:	04cd           	mov.n	a12, a4
    2392:	0002e0        	callx8	a2
    2395:	c128           	l32i.n	a2, a1, 48
    2397:	2d2142        	l32i	a4, a1, 180
    239a:	d6c8           	l32i.n	a12, a6, 52
    239c:	dd22a2        	l32i	a10, a2, 0x374
    239f:	24fd           	ae_l16si.n	a15, a4, 0
    23a1:	fd22b2        	l32i	a11, a2, 0x3f4
    23a4:	ed22d2        	l32i	a13, a2, 0x3b4
    23a7:	f76d41        	l32r	a4, 15c (1a30 <gain_after_ec>)
    23aa:	0e0c           	movi.n	a14, 0
    23ac:	0004e0        	callx8	a4
    23af:	dd22a2        	l32i	a10, a2, 0x374
    23b2:	fd22b2        	l32i	a11, a2, 0x3f4
    23b5:	ed22c2        	l32i	a12, a2, 0x3b4
    23b8:	33e8           	l32i.n	a14, a3, 12
    23ba:	4c21d2        	l32i	a13, a1, 0x130
    23bd:	f77121        	l32r	a2, 184 (1904 <synth_3band>)
    23c0:	0002e0        	callx8	a2
    23c3:	222122        	l32i	a2, a1, 136
    23c6:	33a8           	l32i.n	a10, a3, 12
    23c8:	d6b8           	l32i.n	a11, a6, 52
    23ca:	2c21d2        	l32i	a13, a1, 176
    23cd:	4721e2        	l32i	a14, a1, 0x11c
    23d0:	f76e41        	l32r	a4, 188 (1720 <tx_upsample_by2>)
    23d3:	02cd           	mov.n	a12, a2
    23d5:	0004e0        	callx8	a4
    23d8:	462142        	l32i	a4, a1, 0x118
    23db:	120382        	l8ui	a8, a3, 18
    23de:	14a0f2        	movi	a15, 20
    23e1:	089472        	l16si	a7, a4, 16
    23e4:	048380        	extui	a8, a8, 3, 1
    23e7:	441204        	ae_lp16x2f.i	aep1, a2, 0
    23ea:	609070        	neg	a9, a7
    23ed:	839780        	moveqz	a9, a7, a8
    23f0:	1189c0        	slli	a8, a9, 4
    23f3:	207220        	or	a7, a2, a2
    23f6:	398884        	ae_movpa24x2	aep0, a8, a8
    23f9:	188f76        	loop	a15, 2415 <Voice_EC_Prcs_common+0x4c5>
    23fc:	011054        	ae_mulfp24s.hl	aeq0, aep1, aep0
    23ff:	011874        	ae_mulfp24s.ll	aeq1, aep1, aep0
    2402:	350214        	ae_slliq56	aeq0, aeq0, 8
    2405:	fb63fa924f 	{ ae_slliq56	aeq1, aeq1, 8; ae_roundsp16q48asym	aep7, aeq0 }
    240a:	f96bb2770f 	{ ae_sp16f.l.i	aep7, a7, 0; ae_roundsp16q48asym	aep2, aeq1 }
    240f:	422714        	ae_sp16f.l.i	aep2, a7, 2
    2412:	449714        	ae_lp16x2f.iu	aep1, a7, 4

00002415 <Voice_EC_Prcs_common+0x4c5>:
    2415:	f70221        	l32r	a2, 20 (7318 <p_ecnr_mem>)
    2418:	222162        	l32i	a6, a1, 136
    241b:	05a142        	movi	a4, 0x105
    241e:	0278           	l32i.n	a7, a2, 0
    2420:	1144c0        	slli	a4, a4, 4
    2423:	4b21c2        	l32i	a12, a1, 0x12c
    2426:	f75921        	l32r	a2, 18c (181c <deemph_filter_N>)
    2429:	b74a           	add.n	a11, a7, a4
    242b:	8d2c           	movi.n	a13, 40
    242d:	06ad           	mov.n	a10, a6
    242f:	0002e0        	callx8	a2
    2432:	212122        	l32i	a2, a1, 132
    2435:	e138           	l32i.n	a3, a1, 56
    2437:	50c662        	addi	a6, a6, 80
    243a:	50c222        	addi	a2, a2, 80
    243d:	216122        	s32i	a2, a1, 132
    2440:	d128           	l32i.n	a2, a1, 52
    2442:	226162        	s32i	a6, a1, 136

00002445 <Voice_EC_Prcs_common+0x4f5>:
    2445:	f6f651        	l32r	a5, 20 (7318 <p_ecnr_mem>)
    2448:	192182        	l32i	a8, a1, 100
    244b:	232162        	l32i	a6, a1, 140
    244e:	0578           	l32i.n	a7, a5, 0
    2450:	880b           	addi.n	a8, a8, -1
    2452:	50c662        	addi	a6, a6, 80
    2455:	50c222        	addi	a2, a2, 80
    2458:	50c332        	addi	a3, a3, 80
    245b:	196182        	s32i	a8, a1, 100
    245e:	784816        	beqz	a8, 2be6 <Voice_EC_Prcs_common+0xc96>
    2461:	0da4f2        	movi	a15, 0x40d
    2464:	e139           	s32i.n	a3, a1, 56
    2466:	113fe0        	slli	a3, a15, 2
    2469:	c73a           	add.n	a12, a7, a3
    246b:	f73731        	l32r	a3, 148 (17d4 <emph_filter_N>)
    246e:	b74a           	add.n	a11, a7, a4
    2470:	8d2c           	movi.n	a13, 40
    2472:	06ad           	mov.n	a10, a6
    2474:	0003e0        	callx8	a3
    2477:	f6ea51        	l32r	a5, 20 (7318 <p_ecnr_mem>)
    247a:	07a2f2        	movi	a15, 0x207
    247d:	8d2c           	movi.n	a13, 40
    247f:	0578           	l32i.n	a7, a5, 0
    2481:	02ad           	mov.n	a10, a2
    2483:	b74a           	add.n	a11, a7, a4
    2485:	114fd0        	slli	a4, a15, 3
    2488:	c74a           	add.n	a12, a7, a4
    248a:	0003e0        	callx8	a3
    248d:	0578           	l32i.n	a7, a5, 0
    248f:	5ba442        	movi	a4, 0x45b
    2492:	01d1e2        	addmi	a14, a1, 0x100
    2495:	15d782        	addmi	a8, a7, 0x1500
    2498:	1144d0        	slli	a4, a4, 3
    249b:	1b28a2        	l32i	a10, a8, 108
    249e:	1c28b2        	l32i	a11, a8, 112
    24a1:	f72a31        	l32r	a3, 14c (166c <tx_downsample_by2>)
    24a4:	60cee2        	addi	a14, a14, 96
    24a7:	d74a           	add.n	a13, a7, a4
    24a9:	06cd           	mov.n	a12, a6
    24ab:	236162        	s32i	a6, a1, 140
    24ae:	5261e2        	s32i	a14, a1, 0x148
    24b1:	0003e0        	callx8	a3
    24b4:	0578           	l32i.n	a7, a5, 0
    24b6:	5fa442        	movi	a4, 0x45f
    24b9:	1144d0        	slli	a4, a4, 3
    24bc:	15d782        	addmi	a8, a7, 0x1500
    24bf:	1f28a2        	l32i	a10, a8, 124
    24c2:	2028b2        	l32i	a11, a8, 128
    24c5:	5321e2        	l32i	a14, a1, 0x14c
    24c8:	d74a           	add.n	a13, a7, a4
    24ca:	02cd           	mov.n	a12, a2
    24cc:	d129           	s32i.n	a2, a1, 52
    24ce:	0003e0        	callx8	a3
    24d1:	0578           	l32i.n	a7, a5, 0
    24d3:	122162        	l32i	a6, a1, 72
    24d6:	242142        	l32i	a4, a1, 144
    24d9:	47a522        	movi	a2, 0x547
    24dc:	15d792        	addmi	a9, a7, 0x1500
    24df:	1122d0        	slli	a2, a2, 3
    24e2:	b72a           	add.n	a11, a7, a2
    24e4:	3526d2        	l32i	a13, a6, 212
    24e7:	2524e2        	l32i	a14, a4, 148
    24ea:	1b29a2        	l32i	a10, a9, 108
    24ed:	1a29c2        	l32i	a12, a9, 104
    24f0:	f71821        	l32r	a2, 150 (1860 <analy_3band>)
    24f3:	053d           	mov.n	a3, a5
    24f5:	0002e0        	callx8	a2
    24f8:	0578           	l32i.n	a7, a5, 0
    24fa:	302152        	l32i	a5, a1, 192
    24fd:	6fa422        	movi	a2, 0x46f
    2500:	15d782        	addmi	a8, a7, 0x1500
    2503:	1122d0        	slli	a2, a2, 3
    2506:	b72a           	add.n	a11, a7, a2
    2508:	1525d2        	l32i	a13, a5, 84
    250b:	1a28a2        	l32i	a10, a8, 104
    250e:	f70d21        	l32r	a2, 144 (1990 <biquad_2cascade_24bitTx>)
    2511:	10d7c2        	addmi	a12, a7, 0x1000
    2514:	ae0c           	movi.n	a14, 10
    2516:	0002e0        	callx8	a2
    2519:	0378           	l32i.n	a7, a3, 0
    251b:	4fa522        	movi	a2, 0x54f
    251e:	1122d0        	slli	a2, a2, 3
    2521:	15d792        	addmi	a9, a7, 0x1500
    2524:	3626d2        	l32i	a13, a6, 216
    2527:	b72a           	add.n	a11, a7, a2
    2529:	2624e2        	l32i	a14, a4, 152
    252c:	1f29a2        	l32i	a10, a9, 124
    252f:	1a29c2        	l32i	a12, a9, 104
    2532:	f70721        	l32r	a2, 150 (1860 <analy_3band>)
    2535:	056d           	mov.n	a6, a5
    2537:	0002e0        	callx8	a2
    253a:	0378           	l32i.n	a7, a3, 0
    253c:	162582        	l32i	a8, a5, 88
    253f:	520c           	movi.n	a2, 5
    2541:	15d772        	addmi	a7, a7, 0x1500
    2544:	1a2792        	l32i	a9, a7, 104
    2547:	fcc872        	addi	a7, a8, -4
    254a:	f8c982        	addi	a8, a9, -8
    254d:	088276        	loop	a2, 2559 <Voice_EC_Prcs_common+0x609>
    2550:	5c8814        	ae_lp24x2f.iu	aep0, a8, 8
    2553:	090184        	ae_roundsp16asym	aep0, aep0
    2556:	468714        	ae_sp16x2f.iu	aep0, a7, 4

00002559 <Voice_EC_Prcs_common+0x609>:
    2559:	1a2122        	l32i	a2, a1, 104
    255c:	312152        	l32i	a5, a1, 196
    255f:	5521b2        	l32i	a11, a1, 0x154
    2562:	f6fc31        	l32r	a3, 154 (c8c <subband_aec_block>)
    2565:	ac0c           	movi.n	a12, 10
    2567:	1e0c           	movi.n	a14, 1
    2569:	02ad           	mov.n	a10, a2
    256b:	05dd           	mov.n	a13, a5
    256d:	0003e0        	callx8	a3
    2570:	5721b2        	l32i	a11, a1, 0x15c
    2573:	ac0c           	movi.n	a12, 10
    2575:	3e0c           	movi.n	a14, 3
    2577:	02ad           	mov.n	a10, a2
    2579:	05dd           	mov.n	a13, a5
    257b:	0003e0        	callx8	a3
    257e:	5421b2        	l32i	a11, a1, 0x150
    2581:	4c1c           	movi.n	a12, 20
    2583:	4e0c           	movi.n	a14, 4
    2585:	02ad           	mov.n	a10, a2
    2587:	05dd           	mov.n	a13, a5
    2589:	0003e0        	callx8	a3
    258c:	5621b2        	l32i	a11, a1, 0x158
    258f:	f6f231        	l32r	a3, 158 (efc <subband_aec_mid_channel>)
    2592:	2d0c           	movi.n	a13, 2
    2594:	02ad           	mov.n	a10, a2
    2596:	05cd           	mov.n	a12, a5
    2598:	0003e0        	callx8	a3
    259b:	122122        	l32i	a2, a1, 72
    259e:	202142        	l32i	a4, a1, 128
    25a1:	1726a2        	l32i	a10, a6, 92
    25a4:	067d           	mov.n	a7, a6
    25a6:	242162        	l32i	a6, a1, 144
    25a9:	3722b2        	l32i	a11, a2, 220
    25ac:	74c8           	l32i.n	a12, a4, 28
    25ae:	2726d2        	l32i	a13, a6, 156
    25b1:	f6ea81        	l32r	a8, 15c (1a30 <gain_after_ec>)
    25b4:	0e0c           	movi.n	a14, 0
    25b6:	0f0c           	movi.n	a15, 0
    25b8:	0008e0        	callx8	a8
    25bb:	2f2182        	l32i	a8, a1, 188
    25be:	57a5f2        	movi	a15, 0x557
    25c1:	3722b2        	l32i	a11, a2, 220
    25c4:	19f816        	beqz	a8, 2767 <Voice_EC_Prcs_common+0x817>
    25c7:	f69661        	l32r	a6, 20 (7318 <p_ecnr_mem>)
    25ca:	05a142        	movi	a4, 0x105
    25cd:	182132        	l32i	a3, a1, 96
    25d0:	0678           	l32i.n	a7, a6, 0
    25d2:	1144c0        	slli	a4, a4, 4
    25d5:	0fa4f2        	movi	a15, 0x40f
    25d8:	b74a           	add.n	a11, a7, a4
    25da:	114fe0        	slli	a4, a15, 2
    25dd:	c74a           	add.n	a12, a7, a4
    25df:	f6da41        	l32r	a4, 148 (17d4 <emph_filter_N>)
    25e2:	8d2c           	movi.n	a13, 40
    25e4:	03ad           	mov.n	a10, a3
    25e6:	0004e0        	callx8	a4
    25e9:	0678           	l32i.n	a7, a6, 0
    25eb:	63a4f2        	movi	a15, 0x463
    25ee:	03cd           	mov.n	a12, a3
    25f0:	15d782        	addmi	a8, a7, 0x1500
    25f3:	1d28a2        	l32i	a10, a8, 116
    25f6:	1e28b2        	l32i	a11, a8, 120
    25f9:	118fd0        	slli	a8, a15, 3
    25fc:	4121e2        	l32i	a14, a1, 0x104
    25ff:	f6d331        	l32r	a3, 14c (166c <tx_downsample_by2>)
    2602:	d78a           	add.n	a13, a7, a8
    2604:	0003e0        	callx8	a3
    2607:	0678           	l32i.n	a7, a6, 0
    2609:	2e2122        	l32i	a2, a1, 184
    260c:	402142        	l32i	a4, a1, 0x100
    260f:	2ca632        	movi	a3, 0x62c
    2612:	15d792        	addmi	a9, a7, 0x1500
    2615:	f03330        	subx8	a3, a3, a3
    2618:	b73a           	add.n	a11, a7, a3
    261a:	3522d2        	l32i	a13, a2, 212
    261d:	2524e2        	l32i	a14, a4, 148
    2620:	1d29a2        	l32i	a10, a9, 116
    2623:	1a29c2        	l32i	a12, a9, 104
    2626:	f6ca31        	l32r	a3, 150 (1860 <analy_3band>)
    2629:	0003e0        	callx8	a3
    262c:	0678           	l32i.n	a7, a6, 0
    262e:	202122        	l32i	a2, a1, 128
    2631:	39a232        	movi	a3, 0x239
    2634:	15d782        	addmi	a8, a7, 0x1500
    2637:	1133c0        	slli	a3, a3, 4
    263a:	b73a           	add.n	a11, a7, a3
    263c:	1522d2        	l32i	a13, a2, 84
    263f:	1a28a2        	l32i	a10, a8, 104
    2642:	f6c031        	l32r	a3, 144 (1990 <biquad_2cascade_24bitTx>)
    2645:	10d7c2        	addmi	a12, a7, 0x1000
    2648:	ae0c           	movi.n	a14, 10
    264a:	0003e0        	callx8	a3
    264d:	1a2122        	l32i	a2, a1, 104
    2650:	4321b2        	l32i	a11, a1, 0x10c
    2653:	f6c031        	l32r	a3, 154 (c8c <subband_aec_block>)
    2656:	ac0c           	movi.n	a12, 10
    2658:	1e0c           	movi.n	a14, 1
    265a:	02ad           	mov.n	a10, a2
    265c:	05dd           	mov.n	a13, a5
    265e:	0003e0        	callx8	a3
    2661:	4521b2        	l32i	a11, a1, 0x114
    2664:	ac0c           	movi.n	a12, 10
    2666:	3e0c           	movi.n	a14, 3
    2668:	02ad           	mov.n	a10, a2
    266a:	05dd           	mov.n	a13, a5
    266c:	0003e0        	callx8	a3
    266f:	4221b2        	l32i	a11, a1, 0x108
    2672:	4c1c           	movi.n	a12, 20
    2674:	4e0c           	movi.n	a14, 4
    2676:	02ad           	mov.n	a10, a2
    2678:	05dd           	mov.n	a13, a5
    267a:	0003e0        	callx8	a3
    267d:	4421b2        	l32i	a11, a1, 0x110
    2680:	f6b631        	l32r	a3, 158 (efc <subband_aec_mid_channel>)
    2683:	02ad           	mov.n	a10, a2
    2685:	042d           	mov.n	a2, a4
    2687:	05cd           	mov.n	a12, a5
    2689:	2d0c           	movi.n	a13, 2
    268b:	2e2142        	l32i	a4, a1, 184
    268e:	065d           	mov.n	a5, a6
    2690:	0003e0        	callx8	a3
    2693:	3f2132        	l32i	a3, a1, 252
    2696:	3e2162        	l32i	a6, a1, 248
    2699:	3724b2        	l32i	a11, a4, 220
    269c:	1723a2        	l32i	a10, a3, 92
    269f:	76c8           	l32i.n	a12, a6, 28
    26a1:	2722d2        	l32i	a13, a2, 156
    26a4:	f6ae71        	l32r	a7, 15c (1a30 <gain_after_ec>)
    26a7:	1e0c           	movi.n	a14, 1
    26a9:	0f0c           	movi.n	a15, 0
    26ab:	0007e0        	callx8	a7
    26ae:	0578           	l32i.n	a7, a5, 0
    26b0:	10c1b2        	addi	a11, a1, 16
    26b3:	c1cb           	addi.n	a12, a1, 12
    26b5:	15d782        	addmi	a8, a7, 0x1500
    26b8:	650882        	l8ui	a8, a8, 101
    26bb:	15d752        	addmi	a5, a7, 0x1500
    26be:	d4a4f2        	movi	a15, 0x4d4
    26c1:	026807        	bbci	a8, 0, 26c7 <Voice_EC_Prcs_common+0x777>
    26c4:	003806        	j	27a8 <Voice_EC_Prcs_common+0x858>
    26c7:	1723a2        	l32i	a10, a3, 92
    26ca:	2722c2        	l32i	a12, a2, 156
    26cd:	b02ff0        	addx8	a2, a15, a15
    26d0:	3724b2        	l32i	a11, a4, 220
    26d3:	2325e2        	l32i	a14, a5, 140
    26d6:	f6ab31        	l32r	a3, 184 (1904 <synth_3band>)
    26d9:	d72a           	add.n	a13, a7, a2
    26db:	0003e0        	callx8	a3
    26de:	f65051        	l32r	a5, 20 (7318 <p_ecnr_mem>)
    26e1:	76b8           	l32i.n	a11, a6, 28
    26e3:	1e2162        	l32i	a6, a1, 120
    26e6:	0578           	l32i.n	a7, a5, 0
    26e8:	6ba422        	movi	a2, 0x46b
    26eb:	1122d0        	slli	a2, a2, 3
    26ee:	15d782        	addmi	a8, a7, 0x1500
    26f1:	2328a2        	l32i	a10, a8, 140
    26f4:	2721e2        	l32i	a14, a1, 156
    26f7:	f6a441        	l32r	a4, 188 (1720 <tx_upsample_by2>)
    26fa:	d72a           	add.n	a13, a7, a2
    26fc:	06cd           	mov.n	a12, a6
    26fe:	0004e0        	callx8	a4
    2701:	0578           	l32i.n	a7, a5, 0
    2703:	05a122        	movi	a2, 0x105
    2706:	1122c0        	slli	a2, a2, 4
    2709:	09a2f2        	movi	a15, 0x209
    270c:	b72a           	add.n	a11, a7, a2
    270e:	112fd0        	slli	a2, a15, 3
    2711:	c72a           	add.n	a12, a7, a2
    2713:	f69e21        	l32r	a2, 18c (181c <deemph_filter_N>)
    2716:	8d2c           	movi.n	a13, 40
    2718:	06ad           	mov.n	a10, a6
    271a:	0002e0        	callx8	a2
    271d:	0578           	l32i.n	a7, a5, 0
    271f:	302122        	l32i	a2, a1, 192
    2722:	1221d2        	l32i	a13, a1, 72
    2725:	2421e2        	l32i	a14, a1, 144
    2728:	15d782        	addmi	a8, a7, 0x1500
    272b:	57a5f2        	movi	a15, 0x557
    272e:	1722a2        	l32i	a10, a2, 92
    2731:	272ec2        	l32i	a12, a14, 156
    2734:	372db2        	l32i	a11, a13, 220
    2737:	112fd0        	slli	a2, a15, 3
    273a:	2128e2        	l32i	a14, a8, 132
    273d:	d72a           	add.n	a13, a7, a2
    273f:	0003e0        	callx8	a3
    2742:	0578           	l32i.n	a7, a5, 0
    2744:	202122        	l32i	a2, a1, 128
    2747:	67a4f2        	movi	a15, 0x467
    274a:	15d782        	addmi	a8, a7, 0x1500
    274d:	72b8           	l32i.n	a11, a2, 28
    274f:	112fd0        	slli	a2, a15, 3
    2752:	2128a2        	l32i	a10, a8, 132
    2755:	e1c8           	l32i.n	a12, a1, 56
    2757:	1f21e2        	l32i	a14, a1, 124
    275a:	d72a           	add.n	a13, a7, a2
    275c:	0004e0        	callx8	a4
    275f:	063d           	mov.n	a3, a6
    2761:	f67c61        	l32r	a6, 154 (c8c <subband_aec_block>)
    2764:	00e846        	j	2b09 <Voice_EC_Prcs_common+0xbb9>

00002767 <Voice_EC_Prcs_common+0x817>:
    2767:	f62e51        	l32r	a5, 20 (7318 <p_ecnr_mem>)
    276a:	112fd0        	slli	a2, a15, 3
    276d:	1727a2        	l32i	a10, a7, 92
    2770:	05d8           	l32i.n	a13, a5, 0
    2772:	2726c2        	l32i	a12, a6, 156
    2775:	15dd82        	addmi	a8, a13, 0x1500
    2778:	dd2a           	add.n	a13, a13, a2
    277a:	2128e2        	l32i	a14, a8, 132
    277d:	f68121        	l32r	a2, 184 (1904 <synth_3band>)
    2780:	0002e0        	callx8	a2
    2783:	0578           	l32i.n	a7, a5, 0
    2785:	67a422        	movi	a2, 0x467
    2788:	e138           	l32i.n	a3, a1, 56
    278a:	15d782        	addmi	a8, a7, 0x1500
    278d:	1122d0        	slli	a2, a2, 3
    2790:	d72a           	add.n	a13, a7, a2
    2792:	74b8           	l32i.n	a11, a4, 28
    2794:	2128a2        	l32i	a10, a8, 132
    2797:	1f21e2        	l32i	a14, a1, 124
    279a:	f67b21        	l32r	a2, 188 (1720 <tx_upsample_by2>)
    279d:	03cd           	mov.n	a12, a3
    279f:	0002e0        	callx8	a2
    27a2:	f66c61        	l32r	a6, 154 (c8c <subband_aec_block>)
    27a5:	00dc46        	j	2b1a <Voice_EC_Prcs_common+0xbca>

000027a8 <Voice_EC_Prcs_common+0x858>:
    27a8:	1c2122        	l32i	a2, a1, 112
    27ab:	f66d31        	l32r	a3, 160 (345c <prelim_filter>)
    27ae:	02ad           	mov.n	a10, a2
    27b0:	0003e0        	callx8	a3
    27b3:	3c21b2        	l32i	a11, a1, 240
    27b6:	3a21d2        	l32i	a13, a1, 232
    27b9:	f66a31        	l32r	a3, 164 (36dc <prelim_filter3>)
    27bc:	3c0c           	movi.n	a12, 3
    27be:	02ad           	mov.n	a10, a2
    27c0:	0003e0        	callx8	a3
    27c3:	3b21b2        	l32i	a11, a1, 236
    27c6:	3921d2        	l32i	a13, a1, 228
    27c9:	4c0c           	movi.n	a12, 4
    27cb:	02ad           	mov.n	a10, a2
    27cd:	0003e0        	callx8	a3
    27d0:	262132        	l32i	a3, a1, 152
    27d3:	4188           	l32i.n	a8, a1, 16
    27d5:	6198           	l32i.n	a9, a1, 24
    27d7:	0a1372        	l16ui	a7, a3, 20
    27da:	8168           	l32i.n	a6, a1, 32
    27dc:	300774        	ae_cvtp24a16x2.ll	aep0, a7, a7
    27df:	382172        	l32i	a7, a1, 224
    27e2:	3721b2        	l32i	a11, a1, 220
    27e5:	360834        	ae_cvtq48a32s	aeq0, a8
    27e8:	10003ec97f 	{ ae_cvtq48a32s	aeq1, a9; ae_mulzaafq32sp16s.ll	aeq0, aeq0, aep0, aeq0, aep0 }
    27ed:	1001fec6bf 	{ ae_cvtq48a32s	aeq2, a6; ae_mulzaafq32sp16s.ll	aeq1, aeq1, aep0, aeq1, aep0 }
    27f2:	13026707ae 	{ l16si	a10, a7, 224; ae_mulzaafq32sp16s.ll	aeq3, aeq2, aep0, aeq2, aep0 }
    27f7:	f863e6abce 	{ l16si	a12, a11, 212; ae_roundsp16q48asym	aep1, aeq0 }
    27fc:	fb6bbf1d5f 	{ ae_cvta32p24.l	a13, aep1; ae_roundsp16q48asym	aep6, aeq1 }
    2801:	fb7bff6e5f 	{ ae_cvta32p24.l	a14, aep6; ae_roundsp16q48asym	aep7, aeq3 }
    2806:	007fd4        	ae_cvta32p24.l	a15, aep7
    2809:	41d9           	s32i.n	a13, a1, 16
    280b:	61e9           	s32i.n	a14, a1, 24
    280d:	81f9           	s32i.n	a15, a1, 32
    280f:	25aac7        	bge	a10, a12, 2838 <Voice_EC_Prcs_common+0x8e8>
    2812:	10c172        	addi	a7, a1, 16
    2815:	3421b2        	l32i	a11, a1, 208
    2818:	f65431        	l32r	a3, 168 (39a8 <cali_power>)
    281b:	02ad           	mov.n	a10, a2
    281d:	07cd           	mov.n	a12, a7
    281f:	0003e0        	callx8	a3
    2822:	f65231        	l32r	a3, 16c (3824 <cali_module_short>)
    2825:	02ad           	mov.n	a10, a2
    2827:	07bd           	mov.n	a11, a7
    2829:	0003e0        	callx8	a3
    282c:	152132        	l32i	a3, a1, 84
    282f:	142142        	l32i	a4, a1, 80
    2832:	471372        	l16ui	a7, a3, 142
    2835:	0006c6        	j	2854 <Voice_EC_Prcs_common+0x904>

00002838 <Voice_EC_Prcs_common+0x8e8>:
    2838:	152132        	l32i	a3, a1, 84
    283b:	3321f2        	l32i	a15, a1, 204
    283e:	142142        	l32i	a4, a1, 80
    2841:	d77c           	movi.n	a7, -3
    2843:	050c           	movi.n	a5, 0
    2845:	f47070        	extui	a7, a7, 0, 16
    2848:	475372        	s16i	a7, a3, 142
    284b:	4b5f52        	s16i	a5, a15, 150
    284e:	495452        	s16i	a5, a4, 146
    2851:	4a5452        	s16i	a5, a4, 148
    2854:	162162        	l32i	a6, a1, 88
    2857:	1d21b2        	l32i	a11, a1, 116
    285a:	f64551        	l32r	a5, 170 (3d88 <beam1_proc>)
    285d:	1826c2        	l32i	a12, a6, 96
    2860:	87dd           	ae_sext16	a13, a7
    2862:	0e0c           	movi.n	a14, 0
    2864:	1f0c           	movi.n	a15, 1
    2866:	02ad           	mov.n	a10, a2
    2868:	0005e0        	callx8	a5
    286b:	172172        	l32i	a7, a1, 92
    286e:	4994d2        	l16si	a13, a4, 146
    2871:	2a21b2        	l32i	a11, a1, 168
    2874:	3d27c2        	l32i	a12, a7, 244
    2877:	0e0c           	movi.n	a14, 0
    2879:	0f0c           	movi.n	a15, 0
    287b:	02ad           	mov.n	a10, a2
    287d:	0005e0        	callx8	a5
    2880:	112132        	l32i	a3, a1, 68
    2883:	292162        	l32i	a6, a1, 164
    2886:	4a94d2        	l16si	a13, a4, 148
    2889:	2023c2        	l32i	a12, a3, 128
    288c:	0e0c           	movi.n	a14, 0
    288e:	0f0c           	movi.n	a15, 0
    2890:	02ad           	mov.n	a10, a2
    2892:	06bd           	mov.n	a11, a6
    2894:	0005e0        	callx8	a5
    2897:	2023c2        	l32i	a12, a3, 128
    289a:	4a94d2        	l16si	a13, a4, 148
    289d:	ae0c           	movi.n	a14, 10
    289f:	0f0c           	movi.n	a15, 0
    28a1:	02ad           	mov.n	a10, a2
    28a3:	06bd           	mov.n	a11, a6
    28a5:	0005e0        	callx8	a5
    28a8:	3c2772        	l32i	a7, a7, 240
    28ab:	362142        	l32i	a4, a1, 216
    28ae:	05a032        	movi	a3, 5
    28b1:	fcc772        	addi	a7, a7, -4
    28b4:	641482        	l16ui	a8, a4, 200
    28b7:	300884        	ae_cvtp24a16x2.ll	aep0, a8, a8
    28ba:	449714        	ae_lp16x2f.iu	aep1, a7, 4
    28bd:	178376        	loop	a3, 28d8 <Voice_EC_Prcs_common+0x988>
    28c0:	011054        	ae_mulfp24s.hl	aeq0, aep1, aep0
    28c3:	ea05ed971f 	{ ae_lp16x2f.iu	aep1, a7, 4; ae_mulfp24s.ll	aeq1, aep1, aep0 }
    28c8:	350094        	ae_slliq56	aeq0, aeq0, 2
    28cb:	f963ba906f 	{ ae_slliq56	aeq1, aeq1, 2; ae_roundsp16q48asym	aep2, aeq0 }
    28d0:	f96bf227ef 	{ ae_sp16f.l.i	aep2, a7, -4; ae_roundsp16q48asym	aep3, aeq1 }
    28d5:	4237f4        	ae_sp16f.l.i	aep3, a7, -2

000028d8 <Voice_EC_Prcs_common+0x988>:
    28d8:	112132        	l32i	a3, a1, 68
    28db:	651482        	l16ui	a8, a4, 202
    28de:	0aa0f2        	movi	a15, 10
    28e1:	1f2372        	l32i	a7, a3, 124
    28e4:	300884        	ae_cvtp24a16x2.ll	aep0, a8, a8
    28e7:	fcc772        	addi	a7, a7, -4
    28ea:	449714        	ae_lp16x2f.iu	aep1, a7, 4
    28ed:	178f76        	loop	a15, 2908 <Voice_EC_Prcs_common+0x9b8>
    28f0:	011054        	ae_mulfp24s.hl	aeq0, aep1, aep0
    28f3:	ea05ed971f 	{ ae_lp16x2f.iu	aep1, a7, 4; ae_mulfp24s.ll	aeq1, aep1, aep0 }
    28f8:	350094        	ae_slliq56	aeq0, aeq0, 2
    28fb:	f963ba906f 	{ ae_slliq56	aeq1, aeq1, 2; ae_roundsp16q48asym	aep2, aeq0 }
    2900:	f96bf227ef 	{ ae_sp16f.l.i	aep2, a7, -4; ae_roundsp16q48asym	aep3, aeq1 }
    2905:	4237f4        	ae_sp16f.l.i	aep3, a7, -2
    2908:	f5c631        	l32r	a3, 20 (7318 <p_ecnr_mem>)
    290b:	050c           	movi.n	a5, 0
    290d:	162142        	l32i	a4, a1, 88
    2910:	0378           	l32i.n	a7, a3, 0
    2912:	f5c261        	l32r	a6, 1c (5d9c <xt_memcpy>)
    2915:	ac0c           	movi.n	a12, 10
    2917:	2ed782        	addmi	a8, a7, 0x2e00
    291a:	111882        	l16ui	a8, a8, 34
    291d:	162192        	l32i	a9, a1, 88
    2920:	1521f2        	l32i	a15, a1, 84
    2923:	085816        	beqz	a8, 29ac <Voice_EC_Prcs_common+0xa5c>
    2926:	262152        	l32i	a5, a1, 152
    2929:	1824b2        	l32i	a11, a4, 96
    292c:	e5a8           	l32i.n	a10, a5, 56
    292e:	0006e0        	callx8	a6
    2931:	f5bb31        	l32r	a3, 20 (7318 <p_ecnr_mem>)
    2934:	152162        	l32i	a6, a1, 84
    2937:	02ad           	mov.n	a10, a2
    2939:	0388           	l32i.n	a8, a3, 0
    293b:	1824c2        	l32i	a12, a4, 96
    293e:	4796d2        	l16si	a13, a6, 142
    2941:	15d882        	addmi	a8, a8, 0x1500
    2944:	0691f2        	l16si	a15, a1, 12
    2947:	0e0c           	movi.n	a14, 0
    2949:	1d21b2        	l32i	a11, a1, 116
    294c:	f60a21        	l32r	a2, 174 (3ef0 <beam2_proc>)
    294f:	319892        	l16si	a9, a8, 98
    2952:	11e9           	s32i.n	a14, a1, 4
    2954:	8e1c           	movi.n	a14, 24
    2956:	0199           	s32i.n	a9, a1, 0
    2958:	0002e0        	callx8	a2
    295b:	2ed782        	addmi	a8, a7, 0x2e00
    295e:	1018a2        	l16ui	a10, a8, 32
    2961:	182492        	l32i	a9, a4, 96
    2964:	f27c           	movi.n	a2, -1
    2966:	8aed           	ae_sext16	a14, a10
    2968:	012210        	slli	a2, a2, 31
    296b:	f603f1        	l32r	a15, 178 (7fff0000 <_end+0x7ffe8ce4>)
    296e:	0e2572        	l32i	a7, a5, 56
    2971:	fec982        	addi	a8, a9, -2
    2974:	309e20        	xor	a9, a14, a2
    2977:	11be00        	slli	a11, a14, 16
    297a:	c099b0        	sub	a9, a9, a11
    297d:	142142        	l32i	a4, a1, 80
    2980:	1c2122        	l32i	a2, a1, 112
    2983:	f5f461        	l32r	a6, 154 (c8c <subband_aec_block>)
    2986:	839fa0        	moveqz	a9, a15, a10
    2989:	0aa032        	movi	a3, 10
    298c:	00a052        	movi	a5, 0
    298f:	409704        	ae_lp16f.iu	aep1, a7, 0
    2992:	308994        	ae_cvtp24a16x2.lh	aep0, a9, a9
    2995:	108376        	loop	a3, 29a9 <Voice_EC_Prcs_common+0xa59>
    2998:	e820acf81f 	{ ae_lp16f.iu	aep7, a8, 2; ae_mulfp24s.hh	aeq0, aep0, aep1 }
    299d:	010734        	ae_mulafp24s.ll	aeq0, aep0, aep7
    29a0:	1b8f14        	ae_roundsp16q48asym	aep1, aeq0
    29a3:	421804        	ae_sp16f.l.i	aep1, a8, 0
    29a6:	409714        	ae_lp16f.iu	aep1, a7, 2
    29a9:	000946        	j	29d2 <Voice_EC_Prcs_common+0xa82>

000029ac <Voice_EC_Prcs_common+0xa5c>:
    29ac:	15d772        	addmi	a7, a7, 0x1500
    29af:	1829c2        	l32i	a12, a9, 96
    29b2:	479fd2        	l16si	a13, a15, 142
    29b5:	0691f2        	l16si	a15, a1, 12
    29b8:	1d21b2        	l32i	a11, a1, 116
    29bb:	f5ee31        	l32r	a3, 174 (3ef0 <beam2_proc>)
    29be:	319772        	l16si	a7, a7, 98
    29c1:	142142        	l32i	a4, a1, 80
    29c4:	8e1c           	movi.n	a14, 24
    29c6:	02ad           	mov.n	a10, a2
    29c8:	1159           	s32i.n	a5, a1, 4
    29ca:	0179           	s32i.n	a7, a1, 0
    29cc:	0003e0        	callx8	a3
    29cf:	f5e161        	l32r	a6, 154 (c8c <subband_aec_block>)
    29d2:	172172        	l32i	a7, a1, 92
    29d5:	031c           	movi.n	a3, 16
    29d7:	ffa0f2        	movi	a15, 255
    29da:	3d27c2        	l32i	a12, a7, 244
    29dd:	4994d2        	l16si	a13, a4, 146
    29e0:	1159           	s32i.n	a5, a1, 4
    29e2:	0139           	s32i.n	a3, a1, 0
    29e4:	2a21b2        	l32i	a11, a1, 168
    29e7:	f5e331        	l32r	a3, 174 (3ef0 <beam2_proc>)
    29ea:	8e1c           	movi.n	a14, 24
    29ec:	02ad           	mov.n	a10, a2
    29ee:	7fdff2        	addmi	a15, a15, 0x7f00
    29f1:	0003e0        	callx8	a3
    29f4:	039d           	mov.n	a9, a3
    29f6:	112132        	l32i	a3, a1, 68
    29f9:	4a94d2        	l16si	a13, a4, 148
    29fc:	047d           	mov.n	a7, a4
    29fe:	292142        	l32i	a4, a1, 164
    2a01:	ffa0f2        	movi	a15, 255
    2a04:	2023c2        	l32i	a12, a3, 128
    2a07:	9e1c           	movi.n	a14, 25
    2a09:	02ad           	mov.n	a10, a2
    2a0b:	04bd           	mov.n	a11, a4
    2a0d:	7fdff2        	addmi	a15, a15, 0x7f00
    2a10:	081c           	movi.n	a8, 16
    2a12:	1159           	s32i.n	a5, a1, 4
    2a14:	0189           	s32i.n	a8, a1, 0
    2a16:	095d           	mov.n	a5, a9
    2a18:	0009e0        	callx8	a9
    2a1b:	ffa0f2        	movi	a15, 255
    2a1e:	2023c2        	l32i	a12, a3, 128
    2a21:	4a97d2        	l16si	a13, a7, 148
    2a24:	a80c           	movi.n	a8, 10
    2a26:	9e1c           	movi.n	a14, 25
    2a28:	02ad           	mov.n	a10, a2
    2a2a:	04bd           	mov.n	a11, a4
    2a2c:	7fdff2        	addmi	a15, a15, 0x7f00
    2a2f:	091c           	movi.n	a9, 16
    2a31:	1189           	s32i.n	a8, a1, 4
    2a33:	0199           	s32i.n	a9, a1, 0
    2a35:	0005e0        	callx8	a5
    2a38:	f5d131        	l32r	a3, 17c (41c8 <beam1_mid_band>)
    2a3b:	02ad           	mov.n	a10, a2
    2a3d:	0003e0        	callx8	a3
    2a40:	282132        	l32i	a3, a1, 160
    2a43:	3521e2        	l32i	a14, a1, 212
    2a46:	af0c           	movi.n	a15, 10
    2a48:	2378           	l32i.n	a7, a3, 8
    2a4a:	631e82        	l16ui	a8, a14, 198
    2a4d:	300884        	ae_cvtp24a16x2.ll	aep0, a8, a8
    2a50:	fcc772        	addi	a7, a7, -4
    2a53:	449714        	ae_lp16x2f.iu	aep1, a7, 4
    2a56:	178f76        	loop	a15, 2a71 <Voice_EC_Prcs_common+0xb21>
    2a59:	011054        	ae_mulfp24s.hl	aeq0, aep1, aep0
    2a5c:	ea05ed971f 	{ ae_lp16x2f.iu	aep1, a7, 4; ae_mulfp24s.ll	aeq1, aep1, aep0 }
    2a61:	350094        	ae_slliq56	aeq0, aeq0, 2
    2a64:	f963ba906f 	{ ae_slliq56	aeq1, aeq1, 2; ae_roundsp16q48asym	aep2, aeq0 }
    2a69:	f96bf227ef 	{ ae_sp16f.l.i	aep2, a7, -4; ae_roundsp16q48asym	aep3, aeq1 }
    2a6e:	4237f4        	ae_sp16f.l.i	aep3, a7, -2

00002a71 <Voice_EC_Prcs_common+0xb21>:
    2a71:	02ad           	mov.n	a10, a2
    2a73:	f5c321        	l32r	a2, 180 (4310 <beam2_mid_band>)
    2a76:	0002e0        	callx8	a2
    2a79:	f56951        	l32r	a5, 20 (7318 <p_ecnr_mem>)
    2a7c:	172122        	l32i	a2, a1, 92
    2a7f:	162142        	l32i	a4, a1, 88
    2a82:	0578           	l32i.n	a7, a5, 0
    2a84:	282132        	l32i	a3, a1, 160
    2a87:	57a5f2        	movi	a15, 0x557
    2a8a:	3b22b2        	l32i	a11, a2, 236
    2a8d:	15d782        	addmi	a8, a7, 0x1500
    2a90:	112fd0        	slli	a2, a15, 3
    2a93:	d72a           	add.n	a13, a7, a2
    2a95:	1824a2        	l32i	a10, a4, 96
    2a98:	13c8           	l32i.n	a12, a3, 4
    2a9a:	2128e2        	l32i	a14, a8, 132
    2a9d:	f5b921        	l32r	a2, 184 (1904 <synth_3band>)
    2aa0:	0002e0        	callx8	a2
    2aa3:	0578           	l32i.n	a7, a5, 0
    2aa5:	112122        	l32i	a2, a1, 68
    2aa8:	67a4f2        	movi	a15, 0x467
    2aab:	15d782        	addmi	a8, a7, 0x1500
    2aae:	1e22b2        	l32i	a11, a2, 120
    2ab1:	112fd0        	slli	a2, a15, 3
    2ab4:	d72a           	add.n	a13, a7, a2
    2ab6:	2128a2        	l32i	a10, a8, 132
    2ab9:	e1c8           	l32i.n	a12, a1, 56
    2abb:	1f21e2        	l32i	a14, a1, 124
    2abe:	f5b221        	l32r	a2, 188 (1720 <tx_upsample_by2>)
    2ac1:	0002e0        	callx8	a2
    2ac4:	0578           	l32i.n	a7, a5, 0
    2ac6:	172122        	l32i	a2, a1, 92
    2ac9:	d4a4f2        	movi	a15, 0x4d4
    2acc:	15d782        	addmi	a8, a7, 0x1500
    2acf:	3d22b2        	l32i	a11, a2, 244
    2ad2:	b02ff0        	addx8	a2, a15, a15
    2ad5:	d72a           	add.n	a13, a7, a2
    2ad7:	1a24a2        	l32i	a10, a4, 104
    2ada:	33c8           	l32i.n	a12, a3, 12
    2adc:	2328e2        	l32i	a14, a8, 140
    2adf:	f5a921        	l32r	a2, 184 (1904 <synth_3band>)
    2ae2:	0002e0        	callx8	a2
    2ae5:	0578           	l32i.n	a7, a5, 0
    2ae7:	112122        	l32i	a2, a1, 68
    2aea:	1e2132        	l32i	a3, a1, 120
    2aed:	6ba4f2        	movi	a15, 0x46b
    2af0:	2022b2        	l32i	a11, a2, 128
    2af3:	15d782        	addmi	a8, a7, 0x1500
    2af6:	112fd0        	slli	a2, a15, 3
    2af9:	d72a           	add.n	a13, a7, a2
    2afb:	2328a2        	l32i	a10, a8, 140
    2afe:	2721e2        	l32i	a14, a1, 156
    2b01:	f5a121        	l32r	a2, 188 (1720 <tx_upsample_by2>)
    2b04:	03cd           	mov.n	a12, a3
    2b06:	0002e0        	callx8	a2

00002b09 <Voice_EC_Prcs_common+0xbb9>:
    2b09:	182122        	l32i	a2, a1, 96
    2b0c:	50c332        	addi	a3, a3, 80
    2b0f:	1e6132        	s32i	a3, a1, 120
    2b12:	e138           	l32i.n	a3, a1, 56
    2b14:	50c222        	addi	a2, a2, 80
    2b17:	186122        	s32i	a2, a1, 96
    2b1a:	f54121        	l32r	a2, 20 (7318 <p_ecnr_mem>)
    2b1d:	1f4c           	movi.n	a15, 65
    2b1f:	05a142        	movi	a4, 0x105
    2b22:	0278           	l32i.n	a7, a2, 0
    2b24:	112fa0        	slli	a2, a15, 6
    2b27:	1144c0        	slli	a4, a4, 4
    2b2a:	c72a           	add.n	a12, a7, a2
    2b2c:	f59821        	l32r	a2, 18c (181c <deemph_filter_N>)
    2b2f:	b74a           	add.n	a11, a7, a4
    2b31:	8d2c           	movi.n	a13, 40
    2b33:	03ad           	mov.n	a10, a3
    2b35:	0002e0        	callx8	a2
    2b38:	102172        	l32i	a7, a1, 64
    2b3b:	d128           	l32i.n	a2, a1, 52
    2b3d:	f53851        	l32r	a5, 20 (7318 <p_ecnr_mem>)
    2b40:	901716        	beqz	a7, 2445 <Voice_EC_Prcs_common+0x4f5>
    2b43:	5121c2        	l32i	a12, a1, 0x144
    2b46:	f58021        	l32r	a2, 148 (17d4 <emph_filter_N>)
    2b49:	0578           	l32i.n	a7, a5, 0
    2b4b:	8d2c           	movi.n	a13, 40
    2b4d:	b74a           	add.n	a11, a7, a4
    2b4f:	212142        	l32i	a4, a1, 132
    2b52:	04ad           	mov.n	a10, a4
    2b54:	0002e0        	callx8	a2
    2b57:	4a2132        	l32i	a3, a1, 0x128
    2b5a:	2b21d2        	l32i	a13, a1, 172
    2b5d:	4921e2        	l32i	a14, a1, 0x124
    2b60:	13a8           	l32i.n	a10, a3, 4
    2b62:	23b8           	l32i.n	a11, a3, 8
    2b64:	f57a21        	l32r	a2, 14c (166c <tx_downsample_by2>)
    2b67:	04cd           	mov.n	a12, a4
    2b69:	0002e0        	callx8	a2
    2b6c:	0578           	l32i.n	a7, a5, 0
    2b6e:	c128           	l32i.n	a2, a1, 48
    2b70:	13a8           	l32i.n	a10, a3, 4
    2b72:	15d772        	addmi	a7, a7, 0x1500
    2b75:	fb22d2        	l32i	a13, a2, 0x3ec
    2b78:	eb22e2        	l32i	a14, a2, 0x3ac
    2b7b:	1a27c2        	l32i	a12, a7, 104
    2b7e:	5021b2        	l32i	a11, a1, 0x140
    2b81:	f57341        	l32r	a4, 150 (1860 <analy_3band>)
    2b84:	0004e0        	callx8	a4
    2b87:	0578           	l32i.n	a7, a5, 0
    2b89:	db2282        	l32i	a8, a2, 0x36c
    2b8c:	5f0c           	movi.n	a15, 5
    2b8e:	15d772        	addmi	a7, a7, 0x1500
    2b91:	1a2792        	l32i	a9, a7, 104
    2b94:	fcc872        	addi	a7, a8, -4
    2b97:	f8c982        	addi	a8, a9, -8
    2b9a:	088f76        	loop	a15, 2ba6 <Voice_EC_Prcs_common+0xc56>
    2b9d:	5c8814        	ae_lp24x2f.iu	aep0, a8, 8
    2ba0:	090184        	ae_roundsp16asym	aep0, aep0
    2ba3:	468714        	ae_sp16x2f.iu	aep0, a7, 4

00002ba6 <Voice_EC_Prcs_common+0xc56>:
    2ba6:	1a2122        	l32i	a2, a1, 104
    2ba9:	312142        	l32i	a4, a1, 196
    2bac:	4d21b2        	l32i	a11, a1, 0x134
    2baf:	ac0c           	movi.n	a12, 10
    2bb1:	1e0c           	movi.n	a14, 1
    2bb3:	02ad           	mov.n	a10, a2
    2bb5:	04dd           	mov.n	a13, a4
    2bb7:	0006e0        	callx8	a6
    2bba:	4f21b2        	l32i	a11, a1, 0x13c
    2bbd:	ac0c           	movi.n	a12, 10
    2bbf:	3e0c           	movi.n	a14, 3
    2bc1:	02ad           	mov.n	a10, a2
    2bc3:	04dd           	mov.n	a13, a4
    2bc5:	0006e0        	callx8	a6
    2bc8:	140372        	l8ui	a7, a3, 20
    2bcb:	069d           	mov.n	a9, a6
    2bcd:	482162        	l32i	a6, a1, 0x120
    2bd0:	17cc           	bnez.n	a7, 2bd5 <Voice_EC_Prcs_common+0xc85>
    2bd2:	fde906        	j	237a <Voice_EC_Prcs_common+0x42a>
    2bd5:	3d21b2        	l32i	a11, a1, 244
    2bd8:	4c1c           	movi.n	a12, 20
    2bda:	4e0c           	movi.n	a14, 4
    2bdc:	02ad           	mov.n	a10, a2
    2bde:	04dd           	mov.n	a13, a4
    2be0:	0009e0        	callx8	a9
    2be3:	fde7c6        	j	2386 <Voice_EC_Prcs_common+0x436>

00002be6 <Voice_EC_Prcs_common+0xc96>:
    2be6:	eca522        	movi	a2, 0x5ec
    2be9:	5221f2        	l32i	a15, a1, 0x148
    2bec:	b02220        	addx8	a2, a2, a2
    2bef:	372a           	add.n	a3, a7, a2
    2bf1:	740c           	movi.n	a4, 7
    2bf3:	fccf22        	addi	a2, a15, -4
    2bf6:	fcc332        	addi	a3, a3, -4
    2bf9:	0e8476        	loop	a4, 2c0b <Voice_EC_Prcs_common+0xcbb>
    2bfc:	601214        	ae_lq32f.iu	aeq0, a2, 4
    2bff:	605314        	ae_lq32f.iu	aeq1, a3, 4
    2c02:	0118c4        	ae_addq56	aeq0, aeq1, aeq0
    2c05:	060934        	ae_roundsq32asym	aeq0, aeq0
    2c08:	620304        	ae_sq32f.i	aeq0, a3, 0

00002c0b <Voice_EC_Prcs_common+0xcbb>:
    2c0b:	35d722        	addmi	a2, a7, 0x3500
    2c0e:	470222        	l8ui	a2, a2, 71
    2c11:	1b2162        	l32i	a6, a1, 108
    2c14:	c188           	l32i.n	a8, a1, 48
    2c16:	f198           	l32i.n	a9, a1, 60
    2c18:	5fa4a2        	movi	a10, 0x45f
    2c1b:	67a4b2        	movi	a11, 0x467
    2c1e:	5ba4c2        	movi	a12, 0x45b
    2c21:	11aad0        	slli	a10, a10, 3
    2c24:	11bbd0        	slli	a11, a11, 3
    2c27:	11ccd0        	slli	a12, a12, 3
    2c2a:	0e8256        	bnez	a2, 2d16 <Voice_EC_Prcs_common+0xdc6>
    2c2d:	35d722        	addmi	a2, a7, 0x3500
    2c30:	132232        	l32i	a3, a2, 76
    2c33:	1f0c           	movi.n	a15, 1
    2c35:	112f20        	slli	a2, a15, 14
    2c38:	1b2237        	blt	a2, a3, 2c57 <Voice_EC_Prcs_common+0xd07>
    2c3b:	d4a032        	movi	a3, 212
    2c3e:	22d332        	addmi	a3, a3, 0x2200
    2c41:	840c           	movi.n	a4, 8
    2c43:	603c74        	ae_lq32f.xu	aeq0, a12, a7
    2c46:	803730        	add	a3, a7, a3
    2c49:	0a8476        	loop	a4, 2c57 <Voice_EC_Prcs_common+0xd07>
    2c4c:	350074        	ae_sraiq56	aeq0, aeq0, 1
    2c4f:	f867bd1c1f 	{ ae_lq32f.iu	aeq0, a12, 4; ae_roundsp24q48asym	aep0, aeq0 }
    2c54:	528314        	ae_sp24f.l.iu	aep0, a3, 4

00002c57 <Voice_EC_Prcs_common+0xd07>:
    2c57:	35d732        	addmi	a3, a7, 0x3500
    2c5a:	162332        	l32i	a3, a3, 88
    2c5d:	443c           	movi.n	a4, 52
    2c5f:	23d452        	addmi	a5, a4, 0x2300
    2c62:	152237        	blt	a2, a3, 2c7b <Voice_EC_Prcs_common+0xd2b>
    2c65:	840c           	movi.n	a4, 8
    2c67:	603b74        	ae_lq32f.xu	aeq0, a11, a7
    2c6a:	803750        	add	a3, a7, a5
    2c6d:	0a8476        	loop	a4, 2c7b <Voice_EC_Prcs_common+0xd2b>
    2c70:	350074        	ae_sraiq56	aeq0, aeq0, 1
    2c73:	f867bd1b1f 	{ ae_lq32f.iu	aeq0, a11, 4; ae_roundsp24q48asym	aep0, aeq0 }
    2c78:	528314        	ae_sp24f.l.iu	aep0, a3, 4
    2c7b:	35d732        	addmi	a3, a7, 0x3500
    2c7e:	152332        	l32i	a3, a3, 84
    2c81:	f4a042        	movi	a4, 244
    2c84:	22d452        	addmi	a5, a4, 0x2200
    2c87:	142237        	blt	a2, a3, 2c9f <Voice_EC_Prcs_common+0xd4f>
    2c8a:	840c           	movi.n	a4, 8
    2c8c:	603a74        	ae_lq32f.xu	aeq0, a10, a7
    2c8f:	375a           	add.n	a3, a7, a5
    2c91:	0a8476        	loop	a4, 2c9f <Voice_EC_Prcs_common+0xd4f>
    2c94:	350074        	ae_sraiq56	aeq0, aeq0, 1
    2c97:	f867bd1a1f 	{ ae_lq32f.iu	aeq0, a10, 4; ae_roundsp24q48asym	aep0, aeq0 }
    2c9c:	528314        	ae_sp24f.l.iu	aep0, a3, 4
    2c9f:	2f2132        	l32i	a3, a1, 188
    2ca2:	35d742        	addmi	a4, a7, 0x3500
    2ca5:	63a452        	movi	a5, 0x463
    2ca8:	06a316        	beqz	a3, 2d16 <Voice_EC_Prcs_common+0xdc6>
    2cab:	142432        	l32i	a3, a4, 80
    2cae:	1185d0        	slli	a8, a5, 3
    2cb1:	04a792        	movi	a9, 0x704
    2cb4:	172237        	blt	a2, a3, 2ccf <Voice_EC_Prcs_common+0xd7f>
    2cb7:	a03990        	addx4	a3, a9, a9
    2cba:	840c           	movi.n	a4, 8
    2cbc:	603874        	ae_lq32f.xu	aeq0, a8, a7
    2cbf:	373a           	add.n	a3, a7, a3
    2cc1:	0a8476        	loop	a4, 2ccf <Voice_EC_Prcs_common+0xd7f>
    2cc4:	350074        	ae_sraiq56	aeq0, aeq0, 1
    2cc7:	f867bd181f 	{ ae_lq32f.iu	aeq0, a8, 4; ae_roundsp24q48asym	aep0, aeq0 }
    2ccc:	528314        	ae_sp24f.l.iu	aep0, a3, 4
    2ccf:	35d732        	addmi	a3, a7, 0x3500
    2cd2:	172332        	l32i	a3, a3, 92
    2cd5:	6ba442        	movi	a4, 0x46b
    2cd8:	1144d0        	slli	a4, a4, 3
    2cdb:	1c2237        	blt	a2, a3, 2cfb <Voice_EC_Prcs_common+0xdab>
    2cde:	0ca522        	movi	a2, 0x50c
    2ce1:	f02220        	subx8	a2, a2, a2
    2ce4:	08a032        	movi	a3, 8
    2ce7:	603474        	ae_lq32f.xu	aeq0, a4, a7
    2cea:	802720        	add	a2, a7, a2
    2ced:	0a8376        	loop	a3, 2cfb <Voice_EC_Prcs_common+0xdab>
    2cf0:	350074        	ae_sraiq56	aeq0, aeq0, 1
    2cf3:	f867bd141f 	{ ae_lq32f.iu	aeq0, a4, 4; ae_roundsp24q48asym	aep0, aeq0 }
    2cf8:	528214        	ae_sp24f.l.iu	aep0, a2, 4
    2cfb:	f52521        	l32r	a2, 190 (3c38 <mag_calibration>)
    2cfe:	1c21a2        	l32i	a10, a1, 112
    2d01:	0002e0        	callx8	a2
    2d04:	f4c741        	l32r	a4, 20 (7318 <p_ecnr_mem>)
    2d07:	c188           	l32i.n	a8, a1, 48
    2d09:	f198           	l32i.n	a9, a1, 60
    2d0b:	0478           	l32i.n	a7, a4, 0
    2d0d:	24d622        	addmi	a2, a6, 0x2400
    2d10:	030c           	movi.n	a3, 0
    2d12:	3239           	s32i.n	a3, a2, 12
    2d14:	4239           	s32i.n	a3, a2, 16

00002d16 <Voice_EC_Prcs_common+0xdc6>:
    2d16:	15d722        	addmi	a2, a7, 0x1500
    2d19:	650222        	l8ui	a2, a2, 101
    2d1c:	35d732        	addmi	a3, a7, 0x3500
    2d1f:	8da452        	movi	a5, 0x48d
    2d22:	02e207        	bbsi	a2, 0, 2d28 <Voice_EC_Prcs_common+0xdd8>
    2d25:	002486        	j	2dbb <Voice_EC_Prcs_common+0xe6b>
    2d28:	470322        	l8ui	a2, a3, 71
    2d2b:	132142        	l32i	a4, a1, 76
    2d2e:	1135e0        	slli	a3, a5, 2
    2d31:	729c           	beqz.n	a2, 2d4c <Voice_EC_Prcs_common+0xdfc>
    2d33:	220b           	addi.n	a2, a2, -1
    2d35:	d12290        	mul16s	a2, a2, a9
    2d38:	04bd           	mov.n	a11, a4
    2d3a:	902270        	addx2	a2, a2, a7
    2d3d:	a23a           	add.n	a10, a2, a3
    2d3f:	f4b721        	l32r	a2, 1c (5d9c <xt_memcpy>)
    2d42:	09cd           	mov.n	a12, a9
    2d44:	097d           	mov.n	a7, a9
    2d46:	0002e0        	callx8	a2
    2d49:	001346        	j	2d9a <Voice_EC_Prcs_common+0xe4a>

00002d4c <Voice_EC_Prcs_common+0xdfc>:
    2d4c:	35d742        	addmi	a4, a7, 0x3500
    2d4f:	460442        	l8ui	a4, a4, 70
    2d52:	97a322        	movi	a2, 0x397
    2d55:	8da432        	movi	a3, 0x48d
    2d58:	1122d0        	slli	a2, a2, 3
    2d5b:	1133e0        	slli	a3, a3, 2
    2d5e:	272a           	add.n	a2, a7, a2
    2d60:	b73a           	add.n	a11, a7, a3
    2d62:	f40b           	addi.n	a15, a4, -1
    2d64:	f4ae31        	l32r	a3, 1c (5d9c <xt_memcpy>)
    2d67:	d1cf90        	mul16s	a12, a15, a9
    2d6a:	02ad           	mov.n	a10, a2
    2d6c:	097d           	mov.n	a7, a9
    2d6e:	0003e0        	callx8	a3
    2d71:	f4ab51        	l32r	a5, 20 (7318 <p_ecnr_mem>)
    2d74:	039d           	mov.n	a9, a3
    2d76:	132142        	l32i	a4, a1, 76
    2d79:	05f8           	l32i.n	a15, a5, 0
    2d7b:	07cd           	mov.n	a12, a7
    2d7d:	04bd           	mov.n	a11, a4
    2d7f:	35df32        	addmi	a3, a15, 0x3500
    2d82:	460332        	l8ui	a3, a3, 70
    2d85:	330b           	addi.n	a3, a3, -1
    2d87:	d13370        	mul16s	a3, a3, a7
    2d8a:	90a320        	addx2	a10, a3, a2
    2d8d:	0009e0        	callx8	a9
    2d90:	05a8           	l32i.n	a10, a5, 0
    2d92:	f50031        	l32r	a3, 194 (4aac <NC_NOISE_EST_Prcs>)
    2d95:	02bd           	mov.n	a11, a2
    2d97:	0003e0        	callx8	a3
    2d9a:	f4a121        	l32r	a2, 20 (7318 <p_ecnr_mem>)
    2d9d:	05a132        	movi	a3, 0x105
    2da0:	1133c0        	slli	a3, a3, 4
    2da3:	0228           	l32i.n	a2, a2, 0
    2da5:	09a2f2        	movi	a15, 0x209
    2da8:	04ad           	mov.n	a10, a4
    2daa:	b23a           	add.n	a11, a2, a3
    2dac:	113fd0        	slli	a3, a15, 3
    2daf:	c23a           	add.n	a12, a2, a3
    2db1:	f4f621        	l32r	a2, 18c (181c <deemph_filter_N>)
    2db4:	07dd           	mov.n	a13, a7
    2db6:	0002e0        	callx8	a2
    2db9:	c188           	l32i.n	a8, a1, 48
    2dbb:	f49921        	l32r	a2, 20 (7318 <p_ecnr_mem>)
    2dbe:	102172        	l32i	a7, a1, 64
    2dc1:	1f0c           	movi.n	a15, 1
    2dc3:	0228           	l32i.n	a2, a2, 0
    2dc5:	2b2192        	l32i	a9, a1, 172
    2dc8:	35d232        	addmi	a3, a2, 0x3500
    2dcb:	470332        	l8ui	a3, a3, 71
    2dce:	050716        	beqz	a7, 2e22 <Voice_EC_Prcs_common+0xed2>
    2dd1:	0df356        	bnez	a3, 2eb4 <Voice_EC_Prcs_common+0xf64>
    2dd4:	35d232        	addmi	a3, a2, 0x3500
    2dd7:	182342        	l32i	a4, a3, 96
    2dda:	113f20        	slli	a3, a15, 14
    2ddd:	08a062        	movi	a6, 8
    2de0:	132347        	blt	a3, a4, 2df7 <Voice_EC_Prcs_common+0xea7>
    2de3:	14c842        	addi	a4, a8, 20
    2de6:	600864        	ae_lq32f.i	aeq0, a8, 24
    2de9:	0a8676        	loop	a6, 2df7 <Voice_EC_Prcs_common+0xea7>
    2dec:	350074        	ae_sraiq56	aeq0, aeq0, 1
    2def:	f867bd191f 	{ ae_lq32f.iu	aeq0, a9, 4; ae_roundsp24q48asym	aep0, aeq0 }
    2df4:	528414        	ae_sp24f.l.iu	aep0, a4, 4

00002df7 <Voice_EC_Prcs_common+0xea7>:
    2df7:	35d222        	addmi	a2, a2, 0x3500
    2dfa:	192222        	l32i	a2, a2, 100
    2dfd:	2c2142        	l32i	a4, a1, 176
    2e00:	38c852        	addi	a5, a8, 56
    2e03:	152327        	blt	a3, a2, 2e1c <Voice_EC_Prcs_common+0xecc>
    2e06:	830c           	movi.n	a3, 8
    2e08:	600504        	ae_lq32f.i	aeq0, a5, 0
    2e0b:	34c822        	addi	a2, a8, 52
    2e0e:	0a8376        	loop	a3, 2e1c <Voice_EC_Prcs_common+0xecc>
    2e11:	350074        	ae_sraiq56	aeq0, aeq0, 1
    2e14:	f867bd141f 	{ ae_lq32f.iu	aeq0, a4, 4; ae_roundsp24q48asym	aep0, aeq0 }
    2e19:	528214        	ae_sp24f.l.iu	aep0, a2, 4
    2e1c:	1b2162        	l32i	a6, a1, 108
    2e1f:	000086        	j	2e25 <Voice_EC_Prcs_common+0xed5>

00002e22 <Voice_EC_Prcs_common+0xed2>:
    2e22:	08e356        	bnez	a3, 2eb4 <Voice_EC_Prcs_common+0xf64>
    2e25:	b6a532        	movi	a3, 0x5b6
    2e28:	1fa522        	movi	a2, 0x51f
    2e2b:	f03330        	subx8	a3, a3, a3
    2e2e:	1122d0        	slli	a2, a2, 3
    2e31:	602624        	ae_lq32f.x	aeq0, a6, a2
    2e34:	418364        	ae_lp16f.xu	aep0, a3, a6
    2e37:	d4e231a1ae 	{ l32i	a10, a1, 104; ae_mulfq32sp16s.l	aeq0, aeq0, aep0 }
    2e3c:	28d6f2        	addmi	a15, a6, 0x2800
    2e3f:	620144        	ae_sq32f.i	aeq0, a1, 16
    2e42:	ef28           	l32i.n	a2, a15, 56
    2e44:	4148           	l32i.n	a4, a1, 16
    2e46:	53b240        	max	a11, a2, a4
    2e49:	f4d321        	l32r	a2, 198 (115c <dt_detect>)
    2e4c:	0002e0        	callx8	a2
    2e4f:	978c           	beqz.n	a7, 2e5c <Voice_EC_Prcs_common+0xf0c>
    2e51:	c1a8           	l32i.n	a10, a1, 48
    2e53:	f4d221        	l32r	a2, 19c (11a0 <dt_detect_FB>)
    2e56:	d42ab2        	l32i	a11, a10, 0x350
    2e59:	0002e0        	callx8	a2
    2e5c:	f47121        	l32r	a2, 20 (7318 <p_ecnr_mem>)
    2e5f:	27d642        	addmi	a4, a6, 0x2700
    2e62:	6d9442        	l16si	a4, a4, 218
    2e65:	0228           	l32i.n	a2, a2, 0
    2e67:	fca072        	movi	a7, 252
    2e6a:	28d782        	addmi	a8, a7, 0x2800
    2e6d:	15d252        	addmi	a5, a2, 0x1500
    2e70:	319552        	l16si	a5, a5, 98
    2e73:	cf3c           	movi.n	a15, 60
    2e75:	f4c091        	l32r	a9, 178 (7fff0000 <_end+0x7ffe8ce4>)
    2e78:	05a457        	bge	a4, a5, 2e81 <Voice_EC_Prcs_common+0xf31>
    2e7b:	360934        	ae_cvtq48a32s	aeq0, a9
    2e7e:	000446        	j	2e93 <Voice_EC_Prcs_common+0xf43>

00002e81 <Voice_EC_Prcs_common+0xf31>:
    2e81:	400304        	ae_lp16f.i	aep0, a3, 0
    2e84:	602684        	ae_lq32f.x	aeq0, a6, a8
    2e87:	030214        	ae_mulfq32sp16s.l	aeq0, aeq0, aep0
    2e8a:	28df32        	addmi	a3, a15, 0x2800
    2e8d:	606634        	ae_lq32f.x	aeq1, a6, a3
    2e90:	0110c4        	ae_maxq56s	aeq0, aeq0, aeq1
    2e93:	28d632        	addmi	a3, a6, 0x2800
    2e96:	f863a0035e 	{ l16si	a5, a3, 0; ae_roundsp16q48asym	aep0, aeq0 }
    2e9b:	420304        	ae_sp16f.l.i	aep0, a3, 0
    2e9e:	735d           	ae_s16i.n	a5, a3, 2
    2ea0:	35d242        	addmi	a4, a2, 0x3500
    2ea3:	233d           	ae_l16si.n	a3, a3, 0
    2ea5:	460442        	l8ui	a4, a4, 70
    2ea8:	35d2f2        	addmi	a15, a2, 0x3500
    2eab:	c03350        	sub	a3, a3, a5
    2eae:	d23340        	quos	a3, a3, a4
    2eb1:	245f32        	s16i	a3, a15, 72
    2eb4:	fc24b2513e 	{ l32i	a3, a1, 148; ae_zeroq56	aeq0 }
    2eb9:	322142        	l32i	a4, a1, 200
    2ebc:	440304        	ae_lp16x2f.i	aep0, a3, 0
    2ebf:	048476        	loop	a4, 2ec7 <Voice_EC_Prcs_common+0xf77>
    2ec2:	e2002d831f 	{ ae_lp16x2f.iu	aep0, a3, 4; ae_mulaafp24s.hh.ll	aeq0, aep0, aep0 }

00002ec7 <Voice_EC_Prcs_common+0xf77>:
    2ec7:	77a032        	movi	a3, 119
    2eca:	52d332        	addmi	a3, a3, 0x5200
    2ecd:	350234        	ae_sraiq56	aeq0, aeq0, 8
    2ed0:	300334        	ae_cvtp24a16x2.ll	aep0, a3, a3
    2ed3:	030214        	ae_mulfq32sp16s.l	aeq0, aeq0, aep0
    2ed6:	35d242        	addmi	a4, a2, 0x3500
    2ed9:	fc2471a4ee 	{ l32i	a14, a4, 104; ae_roundsq32asym	aeq0, aeq0 }
    2ede:	368504        	ae_trunca32q48	a5, aeq0
    2ee1:	470432        	l8ui	a3, a4, 71
    2ee4:	35d262        	addmi	a6, a2, 0x3500
    2ee7:	be5a           	add.n	a11, a14, a5
    2ee9:	1a64b2        	s32i	a11, a4, 104
    2eec:	038c           	beqz.n	a3, 2ef0 <Voice_EC_Prcs_common+0xfa0>

00002eee <Voice_EC_Prcs_common+0xf9e>:
    2eee:	f01d           	retw.n

00002ef0 <Voice_EC_Prcs_common+0xfa0>:
    2ef0:	272652        	l32i	a5, a6, 156
    2ef3:	286652        	s32i	a5, a6, 160
    2ef6:	f44d41        	l32r	a4, 2c (488 <HIFI_sqrt>)
    2ef9:	9ca032        	movi	a3, 156
    2efc:	0a0c           	movi.n	a10, 0
    2efe:	35d332        	addmi	a3, a3, 0x3500
    2f01:	0004e0        	callx8	a4
    2f04:	360b34        	ae_cvtq48a32s	aeq0, a11
    2f07:	fc24fe8a0f 	{ ae_slaasq56s	aeq0, aeq0, a10; nop }
    2f0c:	060934        	ae_roundsq32asym	aeq0, aeq0
    2f0f:	628234        	ae_sq32f.x	aeq0, a2, a3
    2f12:	f01d           	retw.n

00002f14 <Voice_EC120_Inear_Prcs>:
    2f14:	006136        	entry	a1, 48
    2f17:	f48881        	l32r	a8, 138 (1f50 <Voice_EC_Prcs_common>)
    2f1a:	c198           	l32i.n	a9, a1, 48
    2f1c:	02ad           	mov.n	a10, a2
    2f1e:	03bd           	mov.n	a11, a3
    2f20:	04cd           	mov.n	a12, a4
    2f22:	05dd           	mov.n	a13, a5
    2f24:	06ed           	mov.n	a14, a6
    2f26:	07fd           	mov.n	a15, a7
    2f28:	0199           	s32i.n	a9, a1, 0
    2f2a:	0008e0        	callx8	a8
    2f2d:	f01d           	retw.n

00002f2f <Voice_EC120_Inear_Prcs+0x1b>:
	...

00002f30 <EC_REF_GAIN_READBACK>:
    2f30:	004136        	entry	a1, 32
    2f33:	f43b31        	l32r	a3, 20 (7318 <p_ecnr_mem>)
    2f36:	040c           	movi.n	a4, 0
    2f38:	0338           	l32i.n	a3, a3, 0
    2f3a:	28d362        	addmi	a6, a3, 0x2800
    2f3d:	28d382        	addmi	a8, a3, 0x2800
    2f40:	191652        	l16ui	a5, a6, 50
    2f43:	391662        	l16ui	a6, a6, 114
    2f46:	591872        	l16ui	a7, a8, 178
    2f49:	791882        	l16ui	a8, a8, 242
    2f4c:	625d           	ae_s16i.n	a5, a2, 0
    2f4e:	726d           	ae_s16i.n	a6, a2, 2
    2f50:	025272        	s16i	a7, a2, 4
    2f53:	15d3f2        	addmi	a15, a3, 0x1500
    2f56:	035282        	s16i	a8, a2, 6
    2f59:	2f1f82        	l16ui	a8, a15, 94
    2f5c:	050c           	movi.n	a5, 0
    2f5e:	060c           	movi.n	a6, 0
    2f60:	070c           	movi.n	a7, 0
    2f62:	112866        	bnei	a8, 2, 2f77 <EC_REF_GAIN_READBACK+0x47>
    2f65:	29d352        	addmi	a5, a3, 0x2900
    2f68:	29d3f2        	addmi	a15, a3, 0x2900
    2f6b:	191542        	l16ui	a4, a5, 50
    2f6e:	391552        	l16ui	a5, a5, 114
    2f71:	591f62        	l16ui	a6, a15, 178
    2f74:	791f72        	l16ui	a7, a15, 242

00002f77 <EC_REF_GAIN_READBACK+0x47>:
    2f77:	045242        	s16i	a4, a2, 8
    2f7a:	055252        	s16i	a5, a2, 10
    2f7d:	065262        	s16i	a6, a2, 12
    2f80:	075272        	s16i	a7, a2, 14
    2f83:	f01d           	retw.n

00002f85 <EC_REF_GAIN_READBACK+0x55>:
    2f85:	000000                                        ...

00002f88 <EC_Inear_REF_GAIN_READBACK>:
    2f88:	004136        	entry	a1, 32
    2f8b:	f42531        	l32r	a3, 20 (7318 <p_ecnr_mem>)
    2f8e:	0338           	l32i.n	a3, a3, 0
    2f90:	35d332        	addmi	a3, a3, 0x3500
    2f93:	2c2332        	l32i	a3, a3, 176
    2f96:	03d342        	addmi	a4, a3, 0x300
    2f99:	251442        	l16ui	a4, a4, 74
    2f9c:	03d3e2        	addmi	a14, a3, 0x300
    2f9f:	624d           	ae_s16i.n	a4, a2, 0
    2fa1:	451e42        	l16ui	a4, a14, 138
    2fa4:	03d3f2        	addmi	a15, a3, 0x300
    2fa7:	04d332        	addmi	a3, a3, 0x400
    2faa:	724d           	ae_s16i.n	a4, a2, 2
    2fac:	651f42        	l16ui	a4, a15, 202
    2faf:	051332        	l16ui	a3, a3, 10
    2fb2:	025242        	s16i	a4, a2, 4
    2fb5:	035232        	s16i	a3, a2, 6
    2fb8:	f01d           	retw.n

00002fba <EC_Inear_REF_GAIN_READBACK+0x32>:
	...

00002fbc <EC_PreLim_Coef_READBACK>:
    2fbc:	004136        	entry	a1, 32
    2fbf:	f41831        	l32r	a3, 20 (7318 <p_ecnr_mem>)
    2fc2:	e4a052        	movi	a5, 228
    2fc5:	23d552        	addmi	a5, a5, 0x2300
    2fc8:	0338           	l32i.n	a3, a3, 0
    2fca:	360c           	movi.n	a6, 3
    2fcc:	024d           	mov.n	a4, a2
    2fce:	805350        	add	a5, a3, a5
    2fd1:	078676        	loop	a6, 2fdc <EC_PreLim_Coef_READBACK+0x20>
    2fd4:	556d           	ae_l16ui.n	a6, a5, 2
    2fd6:	646d           	ae_s16i.n	a6, a4, 0
    2fd8:	554b           	addi.n	a5, a5, 4
    2fda:	442b           	addi.n	a4, a4, 2

00002fdc <EC_PreLim_Coef_READBACK+0x20>:
    2fdc:	91a052        	movi	a5, 145
    2fdf:	1155a0        	slli	a5, a5, 6
    2fe2:	360c           	movi.n	a6, 3
    2fe4:	426b           	addi.n	a4, a2, 6
    2fe6:	805350        	add	a5, a3, a5
    2fe9:	078676        	loop	a6, 2ff4 <EC_PreLim_Coef_READBACK+0x38>
    2fec:	556d           	ae_l16ui.n	a6, a5, 2
    2fee:	646d           	ae_s16i.n	a6, a4, 0
    2ff0:	554b           	addi.n	a5, a5, 4
    2ff2:	442b           	addi.n	a4, a4, 2
    2ff4:	8ba442        	movi	a4, 0x48b
    2ff7:	1144d0        	slli	a4, a4, 3
    2ffa:	350c           	movi.n	a5, 3
    2ffc:	334a           	add.n	a3, a3, a4
    2ffe:	0cc222        	addi	a2, a2, 12
    3001:	078576        	loop	a5, 300c <EC_PreLim_Coef_READBACK+0x50>
    3004:	534d           	ae_l16ui.n	a4, a3, 2
    3006:	624d           	ae_s16i.n	a4, a2, 0
    3008:	334b           	addi.n	a3, a3, 4
    300a:	222b           	addi.n	a2, a2, 2
    300c:	f01d           	retw.n

0000300e <EC_PreLim_Coef_READBACK+0x52>:
	...

00003010 <DaulMIC_power_Coef_READBACK>:
    3010:	004136        	entry	a1, 32
    3013:	f40321        	l32r	a2, 20 (7318 <p_ecnr_mem>)
    3016:	0228           	l32i.n	a2, a2, 0
    3018:	25d222        	addmi	a2, a2, 0x2500
    301b:	269222        	l16si	a2, a2, 76
    301e:	f01d           	retw.n

00003020 <PostEC120_Info>:
    3020:	004136        	entry	a1, 32
    3023:	f3ff31        	l32r	a3, 20 (7318 <p_ecnr_mem>)
    3026:	040c           	movi.n	a4, 0
    3028:	150c           	movi.n	a5, 1
    302a:	0338           	l32i.n	a3, a3, 0
    302c:	724d           	ae_s16i.n	a4, a2, 2
    302e:	115530        	slli	a5, a5, 13
    3031:	35d3e2        	addmi	a14, a3, 0x3500
    3034:	470e42        	l8ui	a4, a14, 71
    3037:	27d3f2        	addmi	a15, a3, 0x2700
    303a:	025252        	s16i	a5, a2, 4
    303d:	6c9f52        	l16si	a5, a15, 216
    3040:	625d           	ae_s16i.n	a5, a2, 0
    3042:	748c           	beqz.n	a4, 304d <PostEC120_Info+0x2d>
    3044:	2ad322        	addmi	a2, a3, 0x2a00
    3047:	250222        	l8ui	a2, a2, 37
    304a:	000346        	j	305b <PostEC120_Info+0x3b>

0000304d <PostEC120_Info+0x2d>:
    304d:	28d322        	addmi	a2, a3, 0x2800
    3050:	422d           	ae_l16ui.n	a2, a2, 0
    3052:	2ad3f2        	addmi	a15, a3, 0x2a00
    3055:	412720        	srli	a2, a2, 7
    3058:	254f22        	s8i	a2, a15, 37
    305b:	742020        	extui	a2, a2, 0, 8
    305e:	f01d           	retw.n

00003060 <find_phase>:
    3060:	004136        	entry	a1, 32
    3063:	344030        	extui	a4, a3, 0, 4
    3066:	0e34a6        	blti	a4, 3, 3078 <find_phase+0x18>
    3069:	1954e6        	bgei	a4, 5, 3086 <find_phase+0x26>
    306c:	253426        	beqi	a4, 3, 3095 <find_phase+0x35>
    306f:	374466        	bnei	a4, 4, 30aa <find_phase+0x4a>
    3072:	600214        	ae_lq32f.i	aeq0, a2, 4
    3075:	000586        	j	308f <find_phase+0x2f>

00003078 <find_phase+0x18>:
    3078:	f49c           	beqz.n	a4, 309b <find_phase+0x3b>
    307a:	3b1426        	beqi	a4, 1, 30b9 <find_phase+0x59>
    307d:	292466        	bnei	a4, 2, 30aa <find_phase+0x4a>
    3080:	600224        	ae_lq32f.i	aeq0, a2, 8
    3083:	000d46        	j	30bc <find_phase+0x5c>

00003086 <find_phase+0x26>:
    3086:	175426        	beqi	a4, 5, 30a1 <find_phase+0x41>
    3089:	1d6466        	bnei	a4, 6, 30aa <find_phase+0x4a>
    308c:	600224        	ae_lq32f.i	aeq0, a2, 8
    308f:	604204        	ae_lq32f.i	aeq1, a2, 0
    3092:	000746        	j	30b3 <find_phase+0x53>

00003095 <find_phase+0x35>:
    3095:	600214        	ae_lq32f.i	aeq0, a2, 4
    3098:	000206        	j	30a4 <find_phase+0x44>

0000309b <find_phase+0x3b>:
    309b:	600204        	ae_lq32f.i	aeq0, a2, 0
    309e:	000686        	j	30bc <find_phase+0x5c>

000030a1 <find_phase+0x41>:
    30a1:	600224        	ae_lq32f.i	aeq0, a2, 8
    30a4:	604204        	ae_lq32f.i	aeq1, a2, 0
    30a7:	000506        	j	30bf <find_phase+0x5f>

000030aa <find_phase+0x4a>:
    30aa:	600224        	ae_lq32f.i	aeq0, a2, 8
    30ad:	604214        	ae_lq32f.i	aeq1, a2, 4
    30b0:	0b7426        	beqi	a4, 7, 30bf <find_phase+0x5f>
    30b3:	060824        	ae_negq56	aeq0, aeq0
    30b6:	000146        	j	30bf <find_phase+0x5f>

000030b9 <find_phase+0x59>:
    30b9:	600214        	ae_lq32f.i	aeq0, a2, 4
    30bc:	064b34        	ae_movq56	aeq1, aeq0
    30bf:	0118c4        	ae_addq56	aeq0, aeq1, aeq0
    30c2:	350074        	ae_sraiq56	aeq0, aeq0, 1
    30c5:	026347        	bbci	a3, 4, 30cb <find_phase+0x6b>
    30c8:	060824        	ae_negq56	aeq0, aeq0
    30cb:	060934        	ae_roundsq32asym	aeq0, aeq0
    30ce:	368204        	ae_trunca32q48	a2, aeq0
    30d1:	f01d           	retw.n

000030d3 <find_phase+0x73>:
	...

000030d4 <memset_S16>:
    30d4:	004136        	entry	a1, 32
    30d7:	0614a6        	blti	a4, 1, 30e1 <memset_S16+0xd>
    30da:	038476        	loop	a4, 30e1 <memset_S16+0xd>
    30dd:	623d           	ae_s16i.n	a3, a2, 0
    30df:	222b           	addi.n	a2, a2, 2

000030e1 <memset_S16+0xd>:
    30e1:	f01d           	retw.n

000030e3 <memset_S16+0xf>:
	...

000030e4 <beam2_setup>:
    30e4:	004136        	entry	a1, 32
    30e7:	140c           	movi.n	a4, 1
    30e9:	014440        	slli	a4, a4, 28
    30ec:	c50c           	movi.n	a5, 12
    30ee:	1f0c           	movi.n	a15, 1
    30f0:	0c5232        	s16i	a3, a2, 24
    30f3:	2249           	s32i.n	a4, a2, 8
    30f5:	113f40        	slli	a3, a15, 12
    30f8:	20c222        	addi	a2, a2, 32
    30fb:	038576        	loop	a5, 3102 <beam2_setup+0x1e>
    30fe:	623d           	ae_s16i.n	a3, a2, 0
    3100:	222b           	addi.n	a2, a2, 2

00003102 <beam2_setup+0x1e>:
    3102:	f01d           	retw.n

00003104 <cal_vad_thrd_x1>:
    3104:	004136        	entry	a1, 32
    3107:	f3f251        	l32r	a5, d0 (6880 <immediate_num>)
    310a:	440304        	ae_lp16x2f.i	aep0, a3, 0
    310d:	441204        	ae_lp16x2f.i	aep1, a2, 0
    3110:	dd056d257f 	{ ae_lp16x2f.i	aep2, a5, 28; ae_selp24.hh	aep3, aep1, aep0 }
    3115:	f06abe103f 	{ ae_selp24.ll	aep0, aep1, aep0; ae_mulzaafp24s.hh.ll	aeq0, aep2, aep3 }
    311a:	042804        	ae_mulzaafp24s.hh.ll	aeq1, aep2, aep0
    311d:	1b8f64        	ae_roundsp16q48asym	aep6, aeq0
    3120:	fb6bf2640f 	{ ae_sp16f.l.i	aep6, a4, 0; ae_roundsp16q48asym	aep7, aeq1 }
    3125:	427414        	ae_sp16f.l.i	aep7, a4, 2
    3128:	f01d           	retw.n

0000312a <cal_vad_thrd_x1+0x26>:
	...

0000312c <CH13_cb_setup>:
    312c:	004136        	entry	a1, 32
    312f:	14c232        	addi	a3, a2, 20
    3132:	6cc2f2        	addi	a15, a2, 108
    3135:	3239           	s32i.n	a3, a2, 12
    3137:	d2f9           	s32i.n	a15, a2, 52
    3139:	f01d           	retw.n

0000313b <CH13_cb_setup+0xf>:
	...

0000313c <TWO_MIC_WB_init>:
    313c:	004136        	entry	a1, 32
    313f:	f3b831        	l32r	a3, 20 (7318 <p_ecnr_mem>)
    3142:	8fa0f2        	movi	a15, 143
    3145:	f3dc41        	l32r	a4, b8 (5d88 <xt_memset>)
    3148:	0358           	l32i.n	a5, a3, 0
    314a:	113fa0        	slli	a3, a15, 6
    314d:	0b0c           	movi.n	a11, 0
    314f:	353a           	add.n	a3, a5, a3
    3151:	0ca2c2        	movi	a12, 0x20c
    3154:	03ad           	mov.n	a10, a3
    3156:	0004e0        	callx8	a4
    3159:	34a572        	movi	a7, 0x534
    315c:	cea062        	movi	a6, 206
    315f:	b4a042        	movi	a4, 180
    3162:	f07770        	subx8	a7, a7, a7
    3165:	23d662        	addmi	a6, a6, 0x2300
    3168:	b24a           	add.n	a11, a2, a4
    316a:	457a           	add.n	a4, a5, a7
    316c:	f3ac71        	l32r	a7, 1c (5d9c <xt_memcpy>)
    316f:	a56a           	add.n	a10, a5, a6
    3171:	5c0c           	movi.n	a12, 5
    3173:	0007e0        	callx8	a7
    3176:	c0a092        	movi	a9, 192
    3179:	5f9282        	l16si	a8, a2, 190
    317c:	24d562        	addmi	a6, a5, 0x2400
    317f:	b29a           	add.n	a11, a2, a9
    3181:	4c0c           	movi.n	a12, 4
    3183:	04ad           	mov.n	a10, a4
    3185:	525682        	s16i	a8, a6, 164
    3188:	0007e0        	callx8	a7
    318b:	4ca742        	movi	a4, 0x74c
    318e:	a04440        	addx4	a4, a4, a4
    3191:	c8a082        	movi	a8, 200
    3194:	b28a           	add.n	a11, a2, a8
    3196:	a54a           	add.n	a10, a5, a4
    3198:	8c0c           	movi.n	a12, 8
    319a:	0007e0        	callx8	a7
    319d:	6c92a2        	l16si	a10, a2, 216
    31a0:	27d5b2        	addmi	a11, a5, 0x2700
    31a3:	6f92c2        	l16si	a12, a2, 222
    31a6:	a4a1f2        	movi	a15, 0x1a4
    31a9:	6a5ba2        	s16i	a10, a11, 212
    31ac:	4656c2        	s16i	a12, a6, 140
    31af:	6d9282        	l16si	a8, a2, 218
    31b2:	7092d2        	l16si	a13, a2, 224
    31b5:	23d5e2        	addmi	a14, a5, 0x2300
    31b8:	b2fa           	add.n	a11, a2, a15
    31ba:	6c0c           	movi.n	a12, 6
    31bc:	03ad           	mov.n	a10, a3
    31be:	0b5682        	s16i	a8, a6, 22
    31c1:	665ed2        	s16i	a13, a14, 204
    31c4:	0007e0        	callx8	a7
    31c7:	d7a732        	movi	a3, 0x7d7
    31ca:	0133d0        	slli	a3, a3, 19
    31cd:	3c0c           	movi.n	a12, 3
    31cf:	286632        	s32i	a3, a6, 160
    31d2:	013c50        	slli	a3, a12, 27
    31d5:	25d5d2        	addmi	a13, a5, 0x2500
    31d8:	340c           	movi.n	a4, 3
    31da:	fd39           	s32i.n	a3, a13, 60
    31dc:	113430        	slli	a3, a4, 13
    31df:	1a0c           	movi.n	a10, 1
    31e1:	0a5632        	s16i	a3, a6, 20
    31e4:	013a20        	slli	a3, a10, 30
    31e7:	1b0c           	movi.n	a11, 1
    31e9:	f3ede1        	l32r	a14, 1a0 (d330000 <_end+0xd328ce4>)
    31ec:	ede9           	s32i.n	a14, a13, 56
    31ee:	014bb0        	slli	a4, a11, 21
    31f1:	24d582        	addmi	a8, a5, 0x2400
    31f4:	f3ec91        	l32r	a9, 1a4 (e390000 <_end+0xe388ce4>)
    31f7:	3b6632        	s32i	a3, a6, 236
    31fa:	446632        	s32i	a3, a6, 0x110
    31fd:	77a1e2        	movi	a14, 0x177
    3200:	cb4c           	movi.n	a11, 76
    3202:	64a0c2        	movi	a12, 100
    3205:	346632        	s32i	a3, a6, 208
    3208:	bd39           	s32i.n	a3, a13, 44
    320a:	24d5a2        	addmi	a10, a5, 0x2400
    320d:	24db62        	addmi	a6, a11, 0x2400
    3210:	6849           	s32i.n	a4, a8, 24
    3212:	8899           	s32i.n	a9, a8, 32
    3214:	d4a092        	movi	a9, 212
    3217:	113ec0        	slli	a3, a14, 4
    321a:	24dc42        	addmi	a4, a12, 0x2400
    321d:	275d32        	s16i	a3, a13, 78
    3220:	98a9           	s32i.n	a10, a8, 36
    3222:	d56a           	add.n	a13, a5, a6
    3224:	24d992        	addmi	a9, a9, 0x2400
    3227:	e54a           	add.n	a14, a5, a4
    3229:	1f0c           	movi.n	a15, 1
    322b:	ca0c           	movi.n	a10, 12
    322d:	f8d9           	s32i.n	a13, a8, 60
    322f:	1568e2        	s32i	a14, a8, 84
    3232:	113f20        	slli	a3, a15, 14
    3235:	659a           	add.n	a6, a5, a9
    3237:	038a76        	loop	a10, 323e <TWO_MIC_WB_init+0x102>
    323a:	663d           	ae_s16i.n	a3, a6, 0
    323c:	662b           	addi.n	a6, a6, 2

0000323e <TWO_MIC_WB_init+0x102>:
    323e:	25d5d2        	addmi	a13, a5, 0x2500
    3241:	f72d42        	l32i	a4, a13, 0x3dc
    3244:	3d6d42        	s32i	a4, a13, 244
    3247:	0248           	l32i.n	a4, a2, 0
    3249:	6f9232        	l16si	a3, a2, 222
    324c:	729282        	l16si	a8, a2, 228
    324f:	29d5e2        	addmi	a14, a5, 0x2900
    3252:	565d82        	s16i	a8, a13, 172
    3255:	372e92        	l32i	a9, a14, 220
    3258:	3cc4f2        	addi	a15, a4, 60
    325b:	3c6d92        	s32i	a9, a13, 240
    325e:	3b6df2        	s32i	a15, a13, 236
    3261:	d31b           	addi.n	a13, a3, 1
    3263:	b3d330        	movgez	a13, a3, a3
    3266:	7e88           	l32i.n	a8, a14, 28
    3268:	26d5a2        	addmi	a10, a5, 0x2600
    326b:	2ad5b2        	addmi	a11, a5, 0x2a00
    326e:	206a82        	s32i	a8, a10, 128
    3271:	7b88           	l32i.n	a8, a11, 28
    3273:	4131d0        	srli	a3, a13, 1
    3276:	24d562        	addmi	a6, a5, 0x2400
    3279:	1f6a82        	s32i	a8, a10, 124
    327c:	50c4c2        	addi	a12, a4, 80
    327f:	485632        	s16i	a3, a6, 144
    3282:	27d5f2        	addmi	a15, a5, 0x2700
    3285:	a72a32        	l32i	a3, a10, 0x29c
    3288:	1e6ac2        	s32i	a12, a10, 120
    328b:	3f39           	s32i.n	a3, a15, 12
    328d:	e72a32        	l32i	a3, a10, 0x39c
    3290:	1c0c           	movi.n	a12, 1
    3292:	25d5a2        	addmi	a10, a5, 0x2500
    3295:	572f82        	l32i	a8, a15, 0x15c
    3298:	b4a0d2        	movi	a13, 180
    329b:	2f39           	s32i.n	a3, a15, 8
    329d:	1f49           	s32i.n	a4, a15, 4
    329f:	016c40        	slli	a6, a12, 28
    32a2:	1a6a82        	s32i	a8, a10, 104
    32a5:	25dd82        	addmi	a8, a13, 0x2500
    32a8:	972f32        	l32i	a3, a15, 0x25c
    32ab:	28c442        	addi	a4, a4, 40
    32ae:	1e0c           	movi.n	a14, 1
    32b0:	cf0c           	movi.n	a15, 12
    32b2:	196a32        	s32i	a3, a10, 100
    32b5:	113e40        	slli	a3, a14, 12
    32b8:	808580        	add	a8, a5, a8
    32bb:	186a42        	s32i	a4, a10, 96
    32be:	276a62        	s32i	a6, a10, 156
    32c1:	038f76        	loop	a15, 32c8 <TWO_MIC_WB_init+0x18c>
    32c4:	683d           	ae_s16i.n	a3, a8, 0
    32c6:	882b           	addi.n	a8, a8, 2
    32c8:	749242        	l16si	a4, a2, 232
    32cb:	99a0f2        	movi	a15, 153
    32ce:	26d592        	addmi	a9, a5, 0x2600
    32d1:	1c5942        	s16i	a4, a9, 56
    32d4:	114fa0        	slli	a4, a15, 6
    32d7:	ca0c           	movi.n	a10, 12
    32d9:	854a           	add.n	a8, a5, a4
    32db:	a969           	s32i.n	a6, a9, 40
    32dd:	038a76        	loop	a10, 32e4 <TWO_MIC_WB_init+0x1a8>
    32e0:	683d           	ae_s16i.n	a3, a8, 0
    32e2:	882b           	addi.n	a8, a8, 2
    32e4:	759242        	l16si	a4, a2, 234
    32e7:	cca0f2        	movi	a15, 204
    32ea:	26d592        	addmi	a9, a5, 0x2600
    32ed:	625942        	s16i	a4, a9, 196
    32f0:	26df42        	addmi	a4, a15, 0x2600
    32f3:	ca0c           	movi.n	a10, 12
    32f5:	854a           	add.n	a8, a5, a4
    32f7:	2d6962        	s32i	a6, a9, 180
    32fa:	038a76        	loop	a10, 3301 <TWO_MIC_WB_init+0x1c5>
    32fd:	683d           	ae_s16i.n	a3, a8, 0
    32ff:	882b           	addi.n	a8, a8, 2
    3301:	739242        	l16si	a4, a2, 230
    3304:	a4a5e2        	movi	a14, 0x5a4
    3307:	27d592        	addmi	a9, a5, 0x2700
    330a:	335942        	s16i	a4, a9, 102
    330d:	f04ee0        	subx8	a4, a14, a14
    3310:	cf0c           	movi.n	a15, 12
    3312:	1a6962        	s32i	a6, a9, 104
    3315:	654a           	add.n	a6, a5, a4
    3317:	038f76        	loop	a15, 331e <TWO_MIC_WB_init+0x1e2>
    331a:	663d           	ae_s16i.n	a3, a6, 0
    331c:	662b           	addi.n	a6, a6, 2
    331e:	74a042        	movi	a4, 116
    3321:	25d442        	addmi	a4, a4, 0x2500
    3324:	25d532        	addmi	a3, a5, 0x2500
    3327:	454a           	add.n	a4, a5, a4
    3329:	cba4f2        	movi	a15, 0x4cb
    332c:	1b6342        	s32i	a4, a3, 108
    332f:	114fd0        	slli	a4, a15, 3
    3332:	34a5e2        	movi	a14, 0x534
    3335:	c54a           	add.n	a12, a5, a4
    3337:	f04ee0        	subx8	a4, a14, a14
    333a:	26d592        	addmi	a9, a5, 0x2600
    333d:	f364e1        	l32r	a14, d0 (6880 <immediate_num>)
    3340:	4ca7f2        	movi	a15, 0x74c
    3343:	cca062        	movi	a6, 204
    3346:	4863c2        	s32i	a12, a3, 0x120
    3349:	3e6392        	s32i	a9, a3, 248
    334c:	a08ff0        	addx4	a8, a15, a15
    334f:	25d662        	addmi	a6, a6, 0x2500
    3352:	451544        	ae_lp16x2f.x	aep1, a5, a4
    3355:	452584        	ae_lp16x2f.x	aep2, a5, a8
    3358:	dd45408cbf 	{ movi	a11, 140; ae_selp24.hh	aep3, aep1, aep2 }
    335d:	dc466d0e7f 	{ ae_lp16x2f.i	aep0, a14, 28; ae_selp24.ll	aep1, aep1, aep2 }
    3362:	f06290656f 	{ add	a6, a5, a6; ae_mulzaafp24s.hh.ll	aeq0, aep0, aep3 }
    3367:	256362        	s32i	a6, a3, 148
    336a:	26dbb2        	addmi	a11, a11, 0x2600
    336d:	f022c0e46f 	{ movi	a6, 228; ae_mulzaafp24s.hh.ll	aeq1, aep0, aep1 }
    3372:	f963c01cdf 	{ movi	a13, 28; ae_roundsp16q48asym	aep3, aeq0 }
    3377:	26d692        	addmi	a9, a6, 0x2600
    337a:	27dd62        	addmi	a6, a13, 0x2700
    337d:	b5ba           	add.n	a11, a5, a11
    337f:	fa6b8074df 	{ movi	a13, 116; ae_roundsp16q48asym	aep4, aeq1 }
    3384:	94a0c2        	movi	a12, 148
    3387:	6163b2        	s32i	a11, a3, 0x184
    338a:	24ddb2        	addmi	a11, a13, 0x2400
    338d:	27dc82        	addmi	a8, a12, 0x2700
    3390:	959a           	add.n	a9, a5, a9
    3392:	43bb54        	ae_sp16f.l.xu	aep3, a11, a5
    3395:	47a2f2        	movi	a15, 0x247
    3398:	9c4c           	movi.n	a12, 73
    339a:	6b6392        	s32i	a9, a3, 0x1ac
    339d:	11afc0        	slli	a10, a15, 4
    33a0:	119c90        	slli	a9, a12, 7
    33a3:	424b14        	ae_sp16f.l.i	aep4, a11, 2
    33a6:	4555a4        	ae_lp16x2f.x	aep5, a5, a10
    33a9:	452594        	ae_lp16x2f.x	aep2, a5, a9
    33ac:	dc567e5a8f 	{ ae_selp24.hh	aep6, aep5, aep2; ae_selp24.ll	aep1, aep5, aep2 }
    33b1:	f1c2848fcf 	{ movi	a12, 0x48f; ae_mulzaafp24s.hh.ll	aeq2, aep0, aep6 }
    33b6:	f122c255df 	{ movi	a13, 0x255; ae_mulzaafp24s.hh.ll	aeq3, aep0, aep1 }
    33bb:	11ccd0        	slli	a12, a12, 3
    33be:	fb73c194ef 	{ movi	a14, 0x194; ae_roundsp16q48asym	aep7, aeq2 }
    33c3:	11adc0        	slli	a10, a13, 4
    33c6:	f87be3fc5f 	{ ae_sp16f.l.xu	aep7, a12, a5; ae_roundsp16q48asym	aep1, aeq3 }
    33cb:	421c14        	ae_sp16f.l.i	aep1, a12, 2
    33ce:	656a           	add.n	a6, a5, a6
    33d0:	27d542        	addmi	a4, a5, 0x2700
    33d3:	f58a           	add.n	a15, a5, a8
    33d5:	b2ea           	add.n	a11, a2, a14
    33d7:	a5aa           	add.n	a10, a5, a10
    33d9:	8c0c           	movi.n	a12, 8
    33db:	4469           	s32i.n	a6, a4, 16
    33dd:	1764f2        	s32i	a15, a4, 92
    33e0:	0007e0        	callx8	a7
    33e3:	f30f21        	l32r	a2, 20 (7318 <p_ecnr_mem>)
    33e6:	24d532        	addmi	a3, a5, 0x2400
    33e9:	0228           	l32i.n	a2, a2, 0
    33eb:	15d222        	addmi	a2, a2, 0x1500
    33ee:	1a2222        	l32i	a2, a2, 104
    33f1:	e329           	s32i.n	a2, a3, 56
    33f3:	f01d           	retw.n

000033f5 <TWO_MIC_WB_init+0x2b9>:
    33f5:	000000                                        ...

000033f8 <take_max_four>:
    33f8:	004136        	entry	a1, 32
    33fb:	224d           	ae_l16si.n	a4, a2, 0
    33fd:	4e23a6        	blti	a3, 2, 344f <take_max_four+0x57>
    3400:	f57c           	movi.n	a5, -1
    3402:	115510        	slli	a5, a5, 15
    3405:	630b           	addi.n	a6, a3, -1
    3407:	222b           	addi.n	a2, a2, 2
    3409:	048d           	mov.n	a8, a4
    340b:	053d           	mov.n	a3, a5
    340d:	057d           	mov.n	a7, a5
    340f:	318676        	loop	a6, 3444 <take_max_four+0x4c>
    3412:	22ad           	ae_l16si.n	a10, a2, 0
    3414:	086d           	mov.n	a6, a8
    3416:	079d           	mov.n	a9, a7
    3418:	0a4d           	mov.n	a4, a10
    341a:	1c28a7        	blt	a8, a10, 343a <take_max_four+0x42>
    341d:	084d           	mov.n	a4, a8
    341f:	0a6d           	mov.n	a6, a10
    3421:	079d           	mov.n	a9, a7
    3423:	1327a7        	blt	a7, a10, 343a <take_max_four+0x42>
    3426:	084d           	mov.n	a4, a8
    3428:	076d           	mov.n	a6, a7
    342a:	0a9d           	mov.n	a9, a10
    342c:	0a23a7        	blt	a3, a10, 343a <take_max_four+0x42>
    342f:	5355a0        	max	a5, a5, a10
    3432:	039d           	mov.n	a9, a3
    3434:	084d           	mov.n	a4, a8
    3436:	076d           	mov.n	a6, a7
    3438:	053d           	mov.n	a3, a5

0000343a <take_max_four+0x42>:
    343a:	035d           	mov.n	a5, a3
    343c:	222b           	addi.n	a2, a2, 2
    343e:	093d           	mov.n	a3, a9
    3440:	067d           	mov.n	a7, a6
    3442:	048d           	mov.n	a8, a4

00003444 <take_max_four+0x4c>:
    3444:	249a           	add.n	a2, a4, a9
    3446:	365a           	add.n	a3, a6, a5
    3448:	223a           	add.n	a2, a2, a3
    344a:	112220        	slli	a2, a2, 14
    344d:	f01d           	retw.n

0000344f <take_max_four+0x57>:
    344f:	f67c           	movi.n	a6, -1
    3451:	116610        	slli	a6, a6, 15
    3454:	069d           	mov.n	a9, a6
    3456:	065d           	mov.n	a5, a6
    3458:	fffa06        	j	3444 <take_max_four+0x4c>

0000345b <take_max_four+0x63>:
	...

0000345c <prelim_filter>:
    345c:	012136        	entry	a1, 144
    345f:	40c262        	addi	a6, a2, 64
    3462:	46c2c2        	addi	a12, a2, 70
    3465:	f3f7c0        	wur.ae_cend0	a12
    3468:	f3f660        	wur.ae_cbegin0	a6
    346b:	22c2f2        	addi	a15, a2, 34
    346e:	e149           	s32i.n	a4, a1, 56
    3470:	6922d2        	l32i	a13, a2, 0x1a4
    3473:	6a22e2        	l32i	a14, a2, 0x1a8
    3476:	682272        	l32i	a7, a2, 0x1a0
    3479:	192252        	l32i	a5, a2, 100
    347c:	24c242        	addi	a4, a2, 36
    347f:	c129           	s32i.n	a2, a1, 48
    3481:	f30d21        	l32r	a2, b8 (5d88 <xt_memset>)
    3484:	400f04        	ae_lp16f.i	aep0, a15, 0
    3487:	60c1a2        	addi	a10, a1, 96
    348a:	0b0c           	movi.n	a11, 0
    348c:	6c0c           	movi.n	a12, 6
    348e:	d139           	s32i.n	a3, a1, 52
    3490:	21d9           	s32i.n	a13, a1, 8
    3492:	b1e9           	s32i.n	a14, a1, 44
    3494:	41f9           	s32i.n	a15, a1, 16
    3496:	560134        	ae_sp24x2s.i	aep0, a1, 24
    3499:	0002e0        	callx8	a2
    349c:	21e8           	l32i.n	a14, a1, 8
    349e:	b1f8           	l32i.n	a15, a1, 44
    34a0:	f34281        	l32r	a8, 1a8 (ccccc <_end+0xc59b0>)
    34a3:	5cc122        	addi	a2, a1, 92
    34a6:	40c192        	addi	a9, a1, 64
    34a9:	39a884        	ae_movpa24x2	aep2, a8, a8
    34ac:	f129           	s32i.n	a2, a1, 60
    34ae:	541134        	ae_lp24x2.i	aep1, a1, 24
    34b1:	a60c           	movi.n	a6, 10
    34b3:	230c           	movi.n	a3, 2
    34b5:	fd248feeae 	{ addi	a10, a14, -2; ae_zeroq56	aeq1 }
    34ba:	fec772        	addi	a7, a7, -2
    34bd:	fecf22        	addi	a2, a15, -2
    34c0:	3b0c           	movi.n	a11, 3
    34c2:	fec9c2        	addi	a12, a9, -2
    34c5:	562144        	ae_sp24x2s.i	aep2, a1, 32

000034c8 <prelim_filter+0x6c>:
    34c8:	408a14        	ae_lp16f.iu	aep0, a10, 2
    34cb:	b1a9           	s32i.n	a10, a1, 44
    34cd:	608404        	ae_lq32f.i	aeq2, a4, 0
    34d0:	fc0c62853f 	{ ae_sp16f.l.c	aep0, a5, a3; ae_movq56	aeq0, aeq1 }
    34d5:	0c8b76        	loop	a11, 34e5 <prelim_filter+0x89>
    34d8:	fc24d9053f 	{ ae_lp16f.c	aep0, a5, a3; nop }
    34dd:	f682fd541f 	{ ae_lq32f.iu	aeq2, a4, 4; ae_mulafq32sp16s.l	aeq1, aeq2, aep0 }
    34e2:	010034        	ae_mulafp24s.ll	aeq0, aep0, aep0

000034e5 <prelim_filter+0x89>:
    34e5:	ff2c3a909f 	{ ae_slliq56	aeq2, aeq1, 1; ae_cvtq48p24s.l	aeq3, aep1 }
    34ea:	f9763b002f 	{ ae_sraiq56	aeq0, aeq0, 2; ae_addq56	aeq1, aeq2, aeq1 }
    34ef:	fc244001af 	{ movi	a10, 1; ae_roundsq32asym	aeq0, aeq0 }
    34f4:	f93eff08ef 	{ ae_trunca32q48	a8, aeq0; ae_subq56	aeq1, aeq3, aeq1 }
    34f9:	f86bb2971f 	{ ae_sp16f.l.iu	aep1, a7, 2; ae_roundsp16q48asym	aep0, aeq1 }
    34fe:	0009d4        	ae_cvta32p24.l	a9, aep0
    3501:	11aa20        	slli	a10, a10, 14
    3504:	53b8a0        	max	a11, a8, a10
    3507:	f2f481        	l32r	a8, d8 (521c <airoha_divide>)
    350a:	428c14        	ae_sp16f.l.iu	aep0, a12, 2
    350d:	21a690        	srai	a10, a9, 6
    3510:	21c9           	s32i.n	a12, a1, 8
    3512:	0008e0        	callx8	a8
    3515:	360b34        	ae_cvtq48a32s	aeq0, a11
    3518:	f188           	l32i.n	a8, a1, 60
    351a:	fc24fe8a0f 	{ ae_slaasq56s	aeq0, aeq0, a10; nop }
    351f:	3b0c           	movi.n	a11, 3
    3521:	f8678f044e 	{ addi	a4, a4, -16; ae_roundsp24q48asym	aep0, aeq0 }
    3526:	542144        	ae_lp24x2.i	aep2, a1, 32
    3529:	1a8b76        	loop	a11, 3547 <prelim_filter+0xeb>
    352c:	601414        	ae_lq32f.iu	aeq0, a4, 4
    352f:	fc24d9153f 	{ ae_lp16f.c	aep1, a5, a3; nop }
    3534:	e223bd381f 	{ ae_lq32f.iu	aeq1, a8, 4; ae_mulafp24s.ll	aeq0, aep0, aep1 }
    3539:	060934        	ae_roundsq32asym	aeq0, aeq0
    353c:	f4caf9840f 	{ ae_sq32f.i	aeq0, a4, 0; ae_mulafq32sp24s.l	aeq1, aeq0, aep2 }
    3541:	06d934        	ae_roundsq32asym	aeq3, aeq1
    3544:	623804        	ae_sq32f.i	aeq3, a8, 0
    3547:	b1a8           	l32i.n	a10, a1, 44
    3549:	21c8           	l32i.n	a12, a1, 8
    354b:	660b           	addi.n	a6, a6, -1
    354d:	fd248f844e 	{ addi	a4, a4, -8; ae_zeroq56	aeq1 }
    3552:	409214        	ae_lp16f.iu	aep1, a2, 2
    3555:	f6f656        	bnez	a6, 34c8 <prelim_filter+0x6c>
    3558:	fc24b0c16e 	{ l32i	a6, a1, 48; ae_zeroq56	aeq0 }
    355d:	042122        	l32i	a2, a1, 16
    3560:	f31341        	l32r	a4, 1ac (393e4b <_end+0x38cb2f>)
    3563:	fe0444013e 	{ addi	a3, a1, 64; ae_movq56	aeq2, aeq0 }
    3568:	421204        	ae_sp16f.l.i	aep1, a2, 0
    356b:	682622        	l32i	a2, a6, 0x1a0
    356e:	0aa0f2        	movi	a15, 10
    3571:	398444        	ae_movpa24x2	aep0, a4, a4
    3574:	196652        	s32i	a5, a6, 100
    3577:	401304        	ae_lp16f.i	aep1, a3, 0
    357a:	fec242        	addi	a4, a2, -2
    357d:	158f76        	loop	a15, 3596 <prelim_filter+0x13a>
    3580:	ea21ece41f 	{ ae_lp16f.iu	aep6, a4, 2; ae_mulfp24s.ll	aeq1, aep0, aep1 }
    3585:	ebc1ec931f 	{ ae_lp16f.iu	aep1, a3, 2; ae_mulfp24s.ll	aeq3, aep0, aep6 }
    358a:	1b9d24        	ae_roundsp24q48asym	aep2, aeq1
    358d:	1bbd74        	ae_roundsp24q48asym	aep7, aeq3
    3590:	012234        	ae_mulafp24s.ll	aeq0, aep2, aep2
    3593:	01f734        	ae_mulafp24s.ll	aeq2, aep7, aep7
    3596:	fd2440014f 	{ movi	a4, 1; ae_roundsq32asym	aeq1, aeq0 }
    359b:	114400        	slli	a4, a4, 16
    359e:	fc147ec4ff 	{ ae_cvtq48a32s	aeq3, a4; ae_movq56	aeq0, aeq2 }
    35a3:	f2cb31        	l32r	a3, d0 (6880 <immediate_num>)
    35a6:	fe2445c65e 	{ addi	a5, a6, 92; ae_roundsq32asym	aeq2, aeq0 }
    35ab:	f8aafa312f 	{ ae_sq56s.i	aeq3, a1, 16; ae_subq56	aeq0, aeq1, aeq2 }
    35b0:	60c504        	ae_lq32f.i	aeq3, a5, 0
    35b3:	633114        	ae_sq56s.i	aeq3, a1, 8
    35b6:	61c124        	ae_lq56.i	aeq3, a1, 16
    35b9:	d6c42d037f 	{ ae_lp16x2f.i	aep0, a3, 28; ae_ltq56s	b0, aeq3, aeq0 }
    35be:	6005f4        	ae_lq32f.i	aeq0, a5, -4
    35c1:	0e003de11f 	{ ae_lq56.i	aeq3, a1, 8; ae_mulzaafq32sp16s.lh	aeq0, aeq2, aep0, aeq0, aep0 }
    35c6:	0c03c000ef 	{ movi	a14, 0; ae_mulzaafq32sp16s.lh	aeq1, aeq1, aep0, aeq3, aep0 }
    35cb:	fc244001ff 	{ movi	a15, 1; ae_roundsq32asym	aeq0, aeq0 }
    35d0:	fd2c56ef0f 	{ movt	a14, a15, b0; ae_roundsq32asym	aeq1, aeq1 }
    35d5:	621504        	ae_sq32f.i	aeq1, a5, 0
    35d8:	6205f4        	ae_sq32f.i	aeq0, a5, -4
    35db:	5eac           	beqz.n	a14, 3604 <prelim_filter+0x1a8>
    35dd:	40c132        	addi	a3, a1, 64
    35e0:	80a042        	movi	a4, 128
    35e3:	5f0c           	movi.n	a15, 5
    35e5:	398444        	ae_movpa24x2	aep0, a4, a4
    35e8:	fcc222        	addi	a2, a2, -4
    35eb:	441304        	ae_lp16x2f.i	aep1, a3, 0
    35ee:	128f76        	loop	a15, 3604 <prelim_filter+0x1a8>
    35f1:	cc04eda21f 	{ ae_lp16x2f.iu	aep2, a2, 4; ae_sraip24	aep1, aep1, 1 }
    35f6:	0f20a4        	ae_sraip24	aep2, aep2, 1
    35f9:	d9292d931f 	{ ae_lp16x2f.iu	aep1, a3, 4; ae_addsp24s	aep2, aep2, aep1 }
    35fe:	07a024        	ae_addsp24s	aep2, aep2, aep0
    3601:	4623f4        	ae_sp16x2f.i	aep2, a3, -4

00003604 <prelim_filter+0x1a8>:
    3604:	f2ae21        	l32r	a2, bc (155555 <_end+0x14e239>)
    3607:	4cc632        	addi	a3, a6, 76
    360a:	0b9652        	l16si	a5, a6, 22
    360d:	398224        	ae_movpa24x2	aep0, a2, a2
    3610:	600304        	ae_lq32f.i	aeq0, a3, 0
    3613:	f6c2b1664e 	{ l32i	a4, a6, 88; ae_mulafq32sp24s.l	aeq0, aeq2, aep0 }
    3618:	11f520        	slli	a15, a5, 14
    361b:	fc247176ae 	{ l32i	a10, a6, 92; ae_roundsq32asym	aeq0, aeq0 }
    3620:	f2ad21        	l32r	a2, d4 (5324 <airoha_divide_limit_1>)
    3623:	53b4f0        	max	a11, a4, a15
    3626:	620304        	ae_sq32f.i	aeq0, a3, 0
    3629:	0002e0        	callx8	a2
    362c:	f2e141        	l32r	a4, 1b0 (175e97 <_end+0x16eb7b>)
    362f:	379aa4        	ae_truncp24a32x2	aep1, a10, a10
    3632:	f8e6e2044f 	{ ae_movpa24x2	aep0, a4, a4; ae_roundsp16asym	aep1, aep1 }
    3637:	692642        	l32i	a4, a6, 0x1a4
    363a:	20c652        	addi	a5, a6, 32
    363d:	421504        	ae_sp16f.l.i	aep1, a5, 0
    3640:	af0c           	movi.n	a15, 10
    3642:	600314        	ae_lq32f.i	aeq0, a3, 4
    3645:	401404        	ae_lp16f.i	aep1, a4, 0
    3648:	0a8f76        	loop	a15, 3656 <prelim_filter+0x1fa>
    364b:	ea21ec941f 	{ ae_lp16f.iu	aep1, a4, 2; ae_mulfp24s.ll	aeq1, aep0, aep1 }
    3650:	1b9d24        	ae_roundsp24q48asym	aep2, aeq1
    3653:	012234        	ae_mulafp24s.ll	aeq0, aep2, aep2

00003656 <prelim_filter+0x1fa>:
    3656:	fc2462b6be 	{ l16si	a11, a6, 86; ae_roundsq32asym	aeq0, aeq0 }
    365b:	620314        	ae_sq32f.i	aeq0, a3, 4
    365e:	f2d531        	l32r	a3, 1b4 (3060 <find_phase>)
    3661:	60c1a2        	addi	a10, a1, 96
    3664:	0003e0        	callx8	a3
    3667:	1626f2        	l32i	a15, a6, 88
    366a:	ffa042        	movi	a4, 255
    366d:	00a472        	movi	a7, 0x400
    3670:	0a5d           	mov.n	a5, a10
    3672:	068d           	mov.n	a8, a6
    3674:	7fd442        	addmi	a4, a4, 0x7f00
    3677:	030c           	movi.n	a3, 0
    3679:	502f77        	blt	a15, a7, 36cd <prelim_filter+0x271>
    367c:	109832        	l16si	a3, a8, 32
    367f:	089862        	l16si	a6, a8, 16
    3682:	0998b2        	l16si	a11, a8, 18
    3685:	c0a360        	sub	a10, a3, a6
    3688:	130c           	movi.n	a3, 1
    368a:	3f1aa6        	blti	a10, 1, 36cd <prelim_filter+0x271>
    368d:	086d           	mov.n	a6, a8
    368f:	1baab7        	bge	a10, a11, 36ae <prelim_filter+0x252>
    3692:	40c142        	addi	a4, a1, 64
    3695:	0002e0        	callx8	a2
    3698:	a20c           	movi.n	a2, 10
    369a:	378aa4        	ae_truncp24a32x2	aep0, a10, a10
    369d:	401404        	ae_lp16f.i	aep1, a4, 0
    36a0:	0a8276        	loop	a2, 36ae <prelim_filter+0x252>
    36a3:	ea05ac941f 	{ ae_lp16f.iu	aep1, a4, 2; ae_mulfp24s.ll	aeq0, aep1, aep0 }
    36a8:	1b8f24        	ae_roundsp16q48asym	aep2, aeq0
    36ab:	4224f4        	ae_sp16f.l.i	aep2, a4, -2

000036ae <prelim_filter+0x252>:
    36ae:	682642        	l32i	a4, a6, 0x1a0
    36b1:	40c122        	addi	a2, a1, 64
    36b4:	05a0f2        	movi	a15, 5
    36b7:	440204        	ae_lp16x2f.i	aep0, a2, 0
    36ba:	fcc442        	addi	a4, a4, -4
    36bd:	0a8f76        	loop	a15, 36cb <prelim_filter+0x26f>
    36c0:	449414        	ae_lp16x2f.iu	aep1, a4, 4
    36c3:	dc06ed821f 	{ ae_lp16x2f.iu	aep0, a2, 4; ae_subsp24s	aep1, aep1, aep0 }
    36c8:	461404        	ae_sp16x2f.i	aep1, a4, 0

000036cb <prelim_filter+0x26f>:
    36cb:	040c           	movi.n	a4, 0

000036cd <prelim_filter+0x271>:
    36cd:	d128           	l32i.n	a2, a1, 52
    36cf:	e1f8           	l32i.n	a15, a1, 56
    36d1:	0259           	s32i.n	a5, a2, 0
    36d3:	1239           	s32i.n	a3, a2, 4
    36d5:	6f4d           	ae_s16i.n	a4, a15, 0
    36d7:	f01d           	retw.n

000036d9 <prelim_filter+0x27d>:
    36d9:	000000                                        ...

000036dc <prelim_filter3>:
    36dc:	00a136        	entry	a1, 80
    36df:	8159           	s32i.n	a5, a1, 32
    36e1:	2b1252        	l16ui	a5, a2, 86
    36e4:	1c3466        	bnei	a4, 3, 3704 <prelim_filter3+0x28>
    36e7:	170c           	movi.n	a7, 1
    36e9:	854d           	ae_sext16	a4, a5
    36eb:	34a262        	movi	a6, 0x234
    36ee:	117740        	slli	a7, a7, 12
    36f1:	2f0c           	movi.n	a15, 2
    36f3:	30a2e2        	movi	a14, 0x230
    36f6:	626a           	add.n	a6, a2, a6
    36f8:	a90c           	movi.n	a9, 10
    36fa:	3179           	s32i.n	a7, a1, 12
    36fc:	22ea           	add.n	a2, a2, a14
    36fe:	214540        	srai	a4, a4, 5
    3701:	000646        	j	371e <prelim_filter3+0x42>

00003704 <prelim_filter3+0x28>:
    3704:	170c           	movi.n	a7, 1
    3706:	854d           	ae_sext16	a4, a5
    3708:	c0a262        	movi	a6, 0x2c0
    370b:	117720        	slli	a7, a7, 14
    370e:	5f0c           	movi.n	a15, 5
    3710:	bca2e2        	movi	a14, 0x2bc
    3713:	626a           	add.n	a6, a2, a6
    3715:	491c           	movi.n	a9, 20
    3717:	3179           	s32i.n	a7, a1, 12
    3719:	22ea           	add.n	a2, a2, a14
    371b:	214a40        	srai	a4, a4, 10
    371e:	51f9           	s32i.n	a15, a1, 20
    3720:	0288           	l32i.n	a8, a2, 0
    3722:	0668           	l32i.n	a6, a6, 0
    3724:	0358           	l32i.n	a5, a3, 0
    3726:	16c3a2        	addi	a10, a3, 22
    3729:	10c3f2        	addi	a15, a3, 16
    372c:	734b           	addi.n	a7, a3, 4
    372e:	4149           	s32i.n	a4, a1, 16
    3730:	7139           	s32i.n	a3, a1, 28
    3732:	240c           	movi.n	a4, 2
    3734:	3b0c           	movi.n	a11, 3
    3736:	f3f6f0        	wur.ae_cbegin0	a15
    3739:	f3f7a0        	wur.ae_cend0	a10
    373c:	61a9           	s32i.n	a10, a1, 24
    373e:	fc24ac0a0f 	{ ae_lp16f.i	aep0, a10, 0; ae_zeroq56	aeq0 }
    3743:	093d           	mov.n	a3, a9
    3745:	fec622        	addi	a2, a6, -2
    3748:	fec882        	addi	a8, a8, -2
    374b:	9179           	s32i.n	a7, a1, 36
    374d:	a199           	s32i.n	a9, a1, 40
    374f:	409814        	ae_lp16f.iu	aep1, a8, 2
    3752:	0b6182        	s32i	a8, a1, 44
    3755:	608704        	ae_lq32f.i	aeq2, a7, 0
    3758:	fd0462954f 	{ ae_sp16f.l.c	aep1, a5, a4; ae_movq56	aeq1, aeq0 }
    375d:	0c8b76        	loop	a11, 376d <prelim_filter3+0x91>
    3760:	fc24d9154f 	{ ae_lp16f.c	aep1, a5, a4; nop }
    3765:	f686fd571f 	{ ae_lq32f.iu	aeq2, a7, 4; ae_mulafq32sp16s.l	aeq1, aeq2, aep1 }
    376a:	011134        	ae_mulafp24s.ll	aeq0, aep1, aep1

0000376d <prelim_filter3+0x91>:
    376d:	ff0c3a909f 	{ ae_slliq56	aeq2, aeq1, 1; ae_cvtq48p24s.l	aeq3, aep0 }
    3772:	f97630518e 	{ l32i	a8, a1, 20; ae_addq56	aeq1, aeq2, aeq1 }
    3777:	f93efb002f 	{ ae_sraiq56	aeq0, aeq0, 2; ae_subq56	aeq1, aeq3, aeq1 }
    377c:	1b9f74        	ae_roundsp16q48asym	aep7, aeq1
    377f:	fc247f7f5f 	{ ae_cvta32p24.l	a15, aep7; ae_roundsq32asym	aeq0, aeq0 }
    3784:	400800        	ssr	a8
    3787:	368b04        	ae_trunca32q48	a11, aeq0
    378a:	f25281        	l32r	a8, d4 (5324 <airoha_divide_limit_1>)
    378d:	b1a0f0        	sra	a10, a15
    3790:	0008e0        	callx8	a8
    3793:	3b0c           	movi.n	a11, 3
    3795:	f4c782        	addi	a8, a7, -12
    3798:	6007d4        	ae_lq32f.i	aeq0, a7, -12
    379b:	378aa4        	ae_truncp24a32x2	aep0, a10, a10
    379e:	108b76        	loop	a11, 37b2 <prelim_filter3+0xd6>
    37a1:	fc24d9154f 	{ ae_lp16f.c	aep1, a5, a4; nop }
    37a6:	010134        	ae_mulafp24s.ll	aeq0, aep0, aep1
    37a9:	060934        	ae_roundsq32asym	aeq0, aeq0
    37ac:	620804        	ae_sq32f.i	aeq0, a8, 0
    37af:	601814        	ae_lq32f.iu	aeq0, a8, 4
    37b2:	fc248f487e 	{ addi	a7, a8, -12; ae_zeroq56	aeq0 }
    37b7:	a198           	l32i.n	a9, a1, 40
    37b9:	b188           	l32i.n	a8, a1, 44
    37bb:	330b           	addi.n	a3, a3, -1
    37bd:	408214        	ae_lp16f.iu	aep0, a2, 2
    37c0:	f8b356        	bnez	a3, 374f <prelim_filter3+0x73>
    37c3:	7128           	l32i.n	a2, a1, 28
    37c5:	61e8           	l32i.n	a14, a1, 24
    37c7:	41f190        	srli	a15, a9, 1
    37ca:	006252        	s32i	a5, a2, 0
    37cd:	fc24b20e0f 	{ ae_sp16f.l.i	aep0, a14, 0; ae_zeroq56	aeq0 }
    37d2:	440604        	ae_lp16x2f.i	aep0, a6, 0
    37d5:	048f76        	loop	a15, 37dd <prelim_filter3+0x101>
    37d8:	e2002d861f 	{ ae_lp16x2f.iu	aep0, a6, 4; ae_mulaafp24s.hh.ll	aeq0, aep0, aep0 }
    37dd:	fc2470313e 	{ l32i	a3, a1, 12; ae_roundsq32asym	aeq0, aeq0 }
    37e2:	368204        	ae_trunca32q48	a2, aeq0
    37e5:	91a8           	l32i.n	a10, a1, 36
    37e7:	41b8           	l32i.n	a11, a1, 16
    37e9:	722320        	salt	a2, a3, a2
    37ec:	f27231        	l32r	a3, 1b4 (3060 <find_phase>)
    37ef:	0003e0        	callx8	a3
    37f2:	8138           	l32i.n	a3, a1, 32
    37f4:	1329           	s32i.n	a2, a3, 4
    37f6:	03a9           	s32i.n	a10, a3, 0
    37f8:	f01d           	retw.n

000037fa <prelim_filter3+0x11e>:
	...

000037fc <cm_short_vad>:
    37fc:	004136        	entry	a1, 32
    37ff:	235d           	ae_l16si.n	a5, a3, 0
    3801:	024d           	mov.n	a4, a2
    3803:	420c           	movi.n	a2, 4
    3805:	192547        	blt	a5, a4, 3822 <cm_short_vad+0x26>
    3808:	335d           	ae_l16si.n	a5, a3, 2
    380a:	220c           	movi.n	a2, 2
    380c:	029362        	l16si	a6, a3, 4
    380f:	0f2547        	blt	a5, a4, 3822 <cm_short_vad+0x26>
    3812:	020c           	movi.n	a2, 0
    3814:	0a2647        	blt	a6, a4, 3822 <cm_short_vad+0x26>
    3817:	039322        	l16si	a2, a3, 6
    381a:	cf7c           	movi.n	a15, -4
    381c:	722240        	salt	a2, a2, a4
    381f:	9022f0        	addx2	a2, a2, a15

00003822 <cm_short_vad+0x26>:
    3822:	f01d           	retw.n

00003824 <cali_module_short>:
    3824:	004136        	entry	a1, 32
    3827:	f1fe41        	l32r	a4, 20 (7318 <p_ecnr_mem>)
    382a:	050c           	movi.n	a5, 0
    382c:	0448           	l32i.n	a4, a4, 0
    382e:	15d442        	addmi	a4, a4, 0x1500
    3831:	319442        	l16si	a4, a4, 98
    3834:	4b24a6        	blti	a4, 2, 3883 <cali_module_short+0x5f>
    3837:	1348           	l32i.n	a4, a3, 4
    3839:	0378           	l32i.n	a7, a3, 0
    383b:	2b0c           	movi.n	a11, 2
    383d:	5014a6        	blti	a4, 1, 3891 <cali_module_short+0x6d>
    3840:	579282        	l16si	a8, a2, 174
    3843:	689262        	l16si	a6, a2, 208
    3846:	317070        	srai	a7, a7, 16
    3849:	47a877        	bge	a8, a7, 3894 <cali_module_short+0x70>
    384c:	569252        	l16si	a5, a2, 172
    384f:	669292        	l16si	a9, a2, 204
    3852:	6e92a2        	l16si	a10, a2, 220
    3855:	727570        	salt	a7, a5, a7
    3858:	9057b0        	addx2	a5, a7, a11
    385b:	773b           	addi.n	a7, a7, 3
    385d:	676a           	add.n	a6, a7, a6
    385f:	436690        	min	a6, a6, a9
    3862:	6b2ae6        	bgei	a10, 2, 38d1 <cali_module_short+0xad>
    3865:	6d9272        	l16si	a7, a2, 218
    3868:	04d292        	addmi	a9, a2, 0x400
    386b:	0a99a2        	l16si	a10, a9, 20
    386e:	871b           	addi.n	a8, a7, 1
    3870:	887d           	ae_sext16	a7, a8
    3872:	6d5282        	s16i	a8, a2, 218
    3875:	38c7a6        	blti	a7, 32, 38b1 <cali_module_short+0x8d>
    3878:	00a282        	movi	a8, 0x200
    387b:	4d9787        	bne	a7, a8, 38cc <cali_module_short+0xa8>
    387e:	270c           	movi.n	a7, 2
    3880:	001286        	j	38ce <cali_module_short+0xaa>

00003883 <cali_module_short+0x5f>:
    3883:	040c           	movi.n	a4, 0
    3885:	675242        	s16i	a4, a2, 206
    3888:	6b5242        	s16i	a4, a2, 214
    388b:	695242        	s16i	a4, a2, 210
    388e:	003a46        	j	397b <cali_module_short+0x157>

00003891 <cali_module_short+0x6d>:
    3891:	000fc6        	j	38d4 <cali_module_short+0xb0>

00003894 <cali_module_short+0x70>:
    3894:	589282        	l16si	a8, a2, 176
    3897:	050c           	movi.n	a5, 0
    3899:	599292        	l16si	a9, a2, 178
    389c:	312877        	blt	a8, a7, 38d1 <cali_module_short+0xad>
    389f:	f9c652        	addi	a5, a6, -7
    38a2:	1ca977        	bge	a9, a7, 38c2 <cali_module_short+0x9e>
    38a5:	560b           	addi.n	a5, a6, -1
    38a7:	0f0c           	movi.n	a15, 0
    38a9:	5365f0        	max	a6, a5, a15
    38ac:	e57c           	movi.n	a5, -2
    38ae:	0007c6        	j	38d1 <cali_module_short+0xad>

000038b1 <cali_module_short+0x8d>:
    38b1:	162282        	l32i	a8, a2, 88
    38b4:	117a60        	slli	a7, a10, 10
    38b7:	0b0c           	movi.n	a11, 0
    38b9:	14a877        	bge	a8, a7, 38d1 <cali_module_short+0xad>
    38bc:	6d52b2        	s16i	a11, a2, 218
    38bf:	000386        	j	38d1 <cali_module_short+0xad>

000038c2 <cali_module_short+0x9e>:
    38c2:	0f0c           	movi.n	a15, 0
    38c4:	5365f0        	max	a6, a5, a15
    38c7:	c57c           	movi.n	a5, -4
    38c9:	000106        	j	38d1 <cali_module_short+0xad>

000038cc <cali_module_short+0xa8>:
    38cc:	170c           	movi.n	a7, 1
    38ce:	6e5272        	s16i	a7, a2, 220
    38d1:	685262        	s16i	a6, a2, 208
    38d4:	3368           	l32i.n	a6, a3, 12
    38d6:	675252        	s16i	a5, a2, 206
    38d9:	070c           	movi.n	a7, 0
    38db:	6716a6        	blti	a6, 1, 3946 <cali_module_short+0x122>
    38de:	2368           	l32i.n	a6, a3, 8
    38e0:	5e9282        	l16si	a8, a2, 188
    38e3:	450c           	movi.n	a5, 4
    38e5:	317060        	srai	a7, a6, 16
    38e8:	1a2877        	blt	a8, a7, 3906 <cali_module_short+0xe2>
    38eb:	5f9282        	l16si	a8, a2, 190
    38ee:	250c           	movi.n	a5, 2
    38f0:	609292        	l16si	a9, a2, 192
    38f3:	0f2877        	blt	a8, a7, 3906 <cali_module_short+0xe2>
    38f6:	050c           	movi.n	a5, 0
    38f8:	0a2977        	blt	a9, a7, 3906 <cali_module_short+0xe2>
    38fb:	619252        	l16si	a5, a2, 194
    38fe:	cf7c           	movi.n	a15, -4
    3900:	725570        	salt	a5, a5, a7
    3903:	9055f0        	addx2	a5, a5, a15
    3906:	695252        	s16i	a5, a2, 210
    3909:	3c14a6        	blti	a4, 1, 3949 <cali_module_short+0x125>
    390c:	f1f141        	l32r	a4, d0 (6880 <immediate_num>)
    390f:	0358           	l32i.n	a5, a3, 0
    3911:	378564        	ae_truncp24a32x2	aep0, a5, a6
    3914:	441474        	ae_lp16x2f.i	aep1, a4, 28
    3917:	f006a5a2fe 	{ l16si	a15, a2, 180; ae_mulzaafp24s.hh.ll	aeq0, aep1, aep0 }
    391c:	450c           	movi.n	a5, 4
    391e:	f863a5b26e 	{ l16si	a6, a2, 182; ae_roundsp16q48asym	aep0, aeq0 }
    3923:	360424        	ae_trunca16p24s.l	a4, aep0
    3926:	5c9272        	l16si	a7, a2, 184
    3929:	1c2f47        	blt	a15, a4, 3949 <cali_module_short+0x125>
    392c:	844d           	ae_sext16	a4, a4
    392e:	250c           	movi.n	a5, 2
    3930:	152647        	blt	a6, a4, 3949 <cali_module_short+0x125>
    3933:	050c           	movi.n	a5, 0
    3935:	102747        	blt	a7, a4, 3949 <cali_module_short+0x125>
    3938:	5d9252        	l16si	a5, a2, 186
    393b:	cf7c           	movi.n	a15, -4
    393d:	724540        	salt	a4, a5, a4
    3940:	9054f0        	addx2	a5, a4, a15
    3943:	000086        	j	3949 <cali_module_short+0x125>

00003946 <cali_module_short+0x122>:
    3946:	695272        	s16i	a7, a2, 210
    3949:	5368           	l32i.n	a6, a3, 20
    394b:	040c           	movi.n	a4, 0
    394d:	6b5252        	s16i	a5, a2, 214
    3950:	2716a6        	blti	a6, 1, 397b <cali_module_short+0x157>
    3953:	4338           	l32i.n	a3, a3, 16
    3955:	629252        	l16si	a5, a2, 196
    3958:	440c           	movi.n	a4, 4
    395a:	313030        	srai	a3, a3, 16
    395d:	1a2537        	blt	a5, a3, 397b <cali_module_short+0x157>
    3960:	639252        	l16si	a5, a2, 198
    3963:	240c           	movi.n	a4, 2
    3965:	649262        	l16si	a6, a2, 200
    3968:	0f2537        	blt	a5, a3, 397b <cali_module_short+0x157>
    396b:	040c           	movi.n	a4, 0
    396d:	0a2637        	blt	a6, a3, 397b <cali_module_short+0x157>
    3970:	659242        	l16si	a4, a2, 202
    3973:	cf7c           	movi.n	a15, -4
    3975:	723430        	salt	a3, a4, a3
    3978:	9043f0        	addx2	a4, a3, a15
    397b:	6a5242        	s16i	a4, a2, 212
    397e:	f01d           	retw.n

00003980 <LH_34_1_setup>:
    3980:	004136        	entry	a1, 32
    3983:	0348           	l32i.n	a4, a3, 0
    3985:	13d8           	l32i.n	a13, a3, 4
    3987:	02e8           	l32i.n	a14, a2, 0
    3989:	315040        	srai	a5, a4, 16
    398c:	f8d552        	addmi	a5, a5, 0xfffff800
    398f:	a55d           	ae_clamps16	a5, a5
    3991:	82f8           	l32i.n	a15, a2, 32
    3993:	fecd32        	addi	a3, a13, -2
    3996:	115500        	slli	a5, a5, 16
    3999:	835430        	moveqz	a5, a4, a3
    399c:	533e50        	max	a3, a14, a5
    399f:	434f50        	min	a4, a15, a5
    39a2:	0239           	s32i.n	a3, a2, 0
    39a4:	8249           	s32i.n	a4, a2, 32
    39a6:	f01d           	retw.n

000039a8 <cali_power>:
    39a8:	006136        	entry	a1, 48
    39ab:	f19d51        	l32r	a5, 20 (7318 <p_ecnr_mem>)
    39ae:	0a0c           	movi.n	a10, 0
    39b0:	0558           	l32i.n	a5, a5, 0
    39b2:	15d552        	addmi	a5, a5, 0x1500
    39b5:	fd24a3155e 	{ l16si	a5, a5, 98; ae_zeroq56	aeq1 }
    39ba:	0225e6        	bgei	a5, 2, 39c0 <cali_power+0x18>
    39bd:	009b86        	j	3c2f <cali_power+0x287>
    39c0:	1448           	l32i.n	a4, a4, 4
    39c2:	0214e6        	bgei	a4, 1, 39c8 <cali_power+0x20>
    39c5:	009986        	j	3c2f <cali_power+0x287>
    39c8:	1c1342        	l16ui	a4, a3, 56
    39cb:	721352        	l16ui	a5, a3, 228
    39ce:	300454        	ae_cvtp24a16x2.ll	aep0, a4, a5
    39d1:	e800a6c3ee 	{ l16si	a14, a3, 216; ae_mulfp24s.hh	aeq0, aep0, aep0 }
    39d6:	6922f2        	l32i	a15, a2, 0x1a4
    39d9:	d4e236a22e 	{ l32i	a2, a2, 0x1a8; ae_mulfq32sp16s.l	aeq0, aeq0, aep0 }
    39de:	4e1b           	addi.n	a4, a14, 1
    39e0:	644040        	extui	a4, a4, 0, 7
    39e3:	f86380056f 	{ movi	a6, 5; ae_roundsp16q48asym	aep0, aeq0 }
    39e8:	6c5342        	s16i	a4, a3, 216
    39eb:	fc0c77011f 	{ ae_sp24x2s.i	aep0, a1, 8; ae_movq56	aeq0, aeq1 }
    39f0:	fccf42        	addi	a4, a15, -4
    39f3:	440204        	ae_lp16x2f.i	aep0, a2, 0
    39f6:	098676        	loop	a6, 3a03 <cali_power+0x5b>
    39f9:	e2002d941f 	{ ae_lp16x2f.iu	aep1, a4, 4; ae_mulaafp24s.hh.ll	aeq0, aep0, aep0 }
    39fe:	e2246d821f 	{ ae_lp16x2f.iu	aep0, a2, 4; ae_mulaafp24s.hh.ll	aeq1, aep1, aep1 }

00003a03 <cali_power+0x5b>:
    3a03:	739322        	l16si	a2, a3, 230
    3a06:	140c           	movi.n	a4, 1
    3a08:	114410        	slli	a4, a4, 15
    3a0b:	3500b4        	ae_sraiq56	aeq0, aeq0, 2
    3a0e:	fc2440c45f 	{ movi	a5, 196; ae_roundsq32asym	aeq0, aeq0 }
    3a13:	c04420        	sub	a4, a4, a2
    3a16:	3550b4        	ae_sraiq56	aeq1, aeq1, 2
    3a19:	fd2c40c86f 	{ movi	a6, 200; ae_roundsq32asym	aeq1, aeq1 }
    3a1e:	60b534        	ae_lq32f.xu	aeq2, a5, a3
    3a21:	300244        	ae_cvtp24a16x2.ll	aep0, a2, a4
    3a24:	0e003c663f 	{ ae_lq32f.xu	aeq3, a6, a3; ae_mulzaafq32sp16s.lh	aeq0, aeq2, aep0, aeq0, aep0 }
    3a29:	0e01c001ef 	{ movi	a14, 1; ae_mulzaafq32sp16s.lh	aeq1, aeq3, aep0, aeq1, aep0 }
    3a2e:	060934        	ae_roundsq32asym	aeq0, aeq0
    3a31:	fd2c79850f 	{ ae_sq32f.i	aeq0, a5, 0; ae_roundsq32asym	aeq1, aeq1 }
    3a36:	621604        	ae_sq32f.i	aeq1, a6, 0
    3a39:	312352        	l32i	a5, a3, 196
    3a3c:	3223f2        	l32i	a15, a3, 200
    3a3f:	112e40        	slli	a2, a14, 12
    3a42:	21a350        	srai	a10, a5, 3
    3a45:	f1a351        	l32r	a5, d4 (5324 <airoha_divide_limit_1>)
    3a48:	53b2f0        	max	a11, a2, a15
    3a4b:	0005e0        	callx8	a5
    3a4e:	212342        	l32i	a4, a3, 132
    3a51:	292372        	l32i	a7, a3, 164
    3a54:	6c1392        	l16ui	a9, a3, 216
    3a57:	5384a0        	max	a8, a4, a10
    3a5a:	4347a0        	min	a4, a7, a10
    3a5d:	0a2d           	mov.n	a2, a10
    3a5f:	216382        	s32i	a8, a3, 132
    3a62:	296342        	s32i	a4, a3, 164
    3a65:	052956        	bnez	a9, 3abb <cali_power+0x113>
    3a68:	6d9372        	l16si	a7, a3, 218
    3a6b:	378884        	ae_truncp24a32x2	aep0, a8, a8
    3a6e:	f8e2ab944f 	{ ae_truncp24a32x2	aep1, a4, a4; ae_roundsp16asym	aep0, aep0 }
    3a73:	f8e6c088df 	{ movi	a13, 136; ae_roundsp16asym	aep1, aep1 }
    3a78:	a8a0e2        	movi	a14, 168
    3a7b:	f1cf81        	l32r	a8, 1b8 (33f8 <take_max_four>)
    3a7e:	a3da           	add.n	a10, a3, a13
    3a80:	11f7f0        	slli	a15, a7, 1
    3a83:	cb0c           	movi.n	a11, 12
    3a85:	43ea           	add.n	a4, a3, a14
    3a87:	430af4        	ae_sp16f.l.x	aep0, a10, a15
    3a8a:	4314f4        	ae_sp16f.l.x	aep1, a4, a15
    3a8d:	0008e0        	callx8	a8
    3a90:	f1cb81        	l32r	a8, 1bc (4c40 <take_min_four>)
    3a93:	2863a2        	s32i	a10, a3, 160
    3a96:	cb0c           	movi.n	a11, 12
    3a98:	04ad           	mov.n	a10, a4
    3a9a:	0008e0        	callx8	a8
    3a9d:	f1c841        	l32r	a4, 1c0 (c0010000 <_end+0xc0008ce4>)
    3aa0:	ad0c           	movi.n	a13, 10
    3aa2:	216342        	s32i	a4, a3, 132
    3aa5:	724d70        	salt	a4, a13, a7
    3aa8:	e71b           	addi.n	a14, a7, 1
    3aaa:	0f0c           	movi.n	a15, 0
    3aac:	f1c681        	l32r	a8, 1c4 (3fff0000 <_end+0x3ffe8ce4>)
    3aaf:	83fe40        	moveqz	a15, a14, a4
    3ab2:	3063a2        	s32i	a10, a3, 192
    3ab5:	296382        	s32i	a8, a3, 164
    3ab8:	6d53f2        	s16i	a15, a3, 218

00003abb <cali_power+0x113>:
    3abb:	0648           	l32i.n	a4, a6, 0
    3abd:	1f0c           	movi.n	a15, 1
    3abf:	10df62        	addmi	a6, a15, 0x1000
    3ac2:	02a467        	bge	a4, a6, 3ac8 <cali_power+0x120>
    3ac5:	0027c6        	j	3b68 <cali_power+0x1c0>
    3ac8:	36c234        	ae_cvtq48a32s	aeq3, a2
    3acb:	540114        	ae_lp24x2.i	aep0, a1, 8
    3ace:	d6e300c04f 	{ movi	a4, 192; ae_mulfq32sp16s.l	aeq0, aeq3, aep0 }
    3ad3:	606344        	ae_lq32f.x	aeq1, a3, a4
    3ad6:	d6440000ff 	{ movi	a15, 0; ae_ltq56s	b0, aeq1, aeq0 }
    3adb:	160c           	movi.n	a6, 1
    3add:	f17c41        	l32r	a4, d0 (6880 <immediate_num>)
    3ae0:	d3f600        	movt	a15, a6, b0
    3ae3:	8fac           	beqz.n	a15, 3b0f <cali_power+0x167>
    3ae5:	fc2440d06f 	{ movi	a6, 208; ae_roundsq32asym	aeq0, aeq0 }
    3aea:	cca0f2        	movi	a15, 204
    3aed:	38c442        	addi	a4, a4, 56
    3af0:	440404        	ae_lp16x2f.i	aep0, a4, 0
    3af3:	607634        	ae_lq32f.xu	aeq1, a6, a3
    3af6:	0c03ed142f 	{ ae_lp16x2f.i	aep1, a4, 8; ae_mulzaafq32sp16s.lh	aeq1, aeq1, aep0, aeq3, aep0 }
    3afb:	60bf34        	ae_lq32f.xu	aeq2, a15, a3
    3afe:	c11184        	ae_mulzaafq32sp16s.lh	aeq0, aeq2, aep1, aeq0, aep1
    3b01:	065934        	ae_roundsq32asym	aeq1, aeq1
    3b04:	fc2479960f 	{ ae_sq32f.i	aeq1, a6, 0; ae_roundsq32asym	aeq0, aeq0 }
    3b09:	620f04        	ae_sq32f.i	aeq0, a15, 0
    3b0c:	001606        	j	3b68 <cali_power+0x1c0>

00003b0f <cali_power+0x167>:
    3b0f:	a0a042        	movi	a4, 160
    3b12:	602344        	ae_lq32f.x	aeq0, a3, a4
    3b15:	d4e20000ff 	{ movi	a15, 0; ae_mulfq32sp16s.l	aeq0, aeq0, aep0 }
    3b1a:	160c           	movi.n	a6, 1
    3b1c:	d6c430011f 	{ ae_lp24x2.i	aep0, a1, 8; ae_ltq56s	b0, aeq3, aeq0 }
    3b21:	000bd4        	ae_cvta32p24.l	a11, aep0
    3b24:	f16d41        	l32r	a4, d8 (521c <airoha_divide>)
    3b27:	d3f600        	movt	a15, a6, b0
    3b2a:	afbc           	beqz.n	a15, 3b68 <cali_power+0x1c0>
    3b2c:	02ad           	mov.n	a10, a2
    3b2e:	633114        	ae_sq56s.i	aeq3, a1, 8
    3b31:	0004e0        	callx8	a4
    3b34:	f16741        	l32r	a4, d0 (6880 <immediate_num>)
    3b37:	360b34        	ae_cvtq48a32s	aeq0, a11
    3b3a:	d0a062        	movi	a6, 208
    3b3d:	fc24fe8a0f 	{ ae_slaasq56s	aeq0, aeq0, a10; nop }
    3b42:	fc2440cc7f 	{ movi	a7, 204; ae_roundsq32asym	aeq0, aeq0 }
    3b47:	38c442        	addi	a4, a4, 56
    3b4a:	607634        	ae_lq32f.xu	aeq1, a6, a3
    3b4d:	441414        	ae_lp16x2f.i	aep1, a4, 4
    3b50:	0c253c473f 	{ ae_lq32f.xu	aeq2, a7, a3; ae_mulzaafq32sp16s.lh	aeq0, aeq1, aep1, aeq0, aep1 }
    3b55:	440404        	ae_lp16x2f.i	aep0, a4, 0
    3b58:	fc247de11f 	{ ae_lq56.i	aeq3, a1, 8; ae_roundsq32asym	aeq0, aeq0 }
    3b5d:	0f02b9860f 	{ ae_sq32f.i	aeq0, a6, 0; ae_mulzaafq32sp16s.lh	aeq2, aeq2, aep0, aeq3, aep0 }
    3b62:	06e934        	ae_roundsq32asym	aeq3, aeq2
    3b65:	623704        	ae_sq32f.i	aeq3, a7, 0
    3b68:	332342        	l32i	a4, a3, 204
    3b6b:	342362        	l32i	a6, a3, 208
    3b6e:	c02240        	sub	a2, a2, a4
    3b71:	c0b640        	sub	a11, a6, a4
    3b74:	21a120        	srai	a10, a2, 1
    3b77:	0005e0        	callx8	a5
    3b7a:	761322        	l16ui	a2, a3, 236
    3b7d:	f550a0        	extui	a5, a10, 16, 16
    3b80:	7413d2        	l16ui	a13, a3, 232
    3b83:	824d           	ae_sext16	a4, a2
    3b85:	112400        	slli	a2, a4, 16
    3b88:	33aa27        	bge	a10, a2, 3bbf <cali_power+0x217>
    3b8b:	6f9342        	l16si	a4, a3, 222
    3b8e:	852c           	movi.n	a5, 40
    3b90:	7513c2        	l16ui	a12, a3, 234
    3b93:	441b           	addi.n	a4, a4, 1
    3b95:	844d           	ae_sext16	a4, a4
    3b97:	434450        	min	a4, a4, a5
    3b9a:	3004c4        	ae_cvtp24a16x2.ll	aep0, a4, a12
    3b9d:	ea0080d4df 	{ movi	a13, 212; ae_mulfp24s.hl	aeq0, aep0, aep0 }
    3ba2:	6063d4        	ae_lq32f.x	aeq1, a3, a13
    3ba5:	360294        	ae_sllisq56s	aeq0, aeq0, 10
    3ba8:	f82ac000ff 	{ movi	a15, 0; ae_subq56	aeq0, aeq1, aeq0 }
    3bad:	060934        	ae_roundsq32asym	aeq0, aeq0
    3bb0:	368e04        	ae_trunca32q48	a14, aeq0
    3bb3:	6f5342        	s16i	a4, a3, 222
    3bb6:	534ef0        	max	a4, a14, a15
    3bb9:	356342        	s32i	a4, a3, 212
    3bbc:	000a46        	j	3be9 <cali_power+0x241>

00003bbf <cali_power+0x217>:
    3bbf:	c04540        	sub	a4, a5, a4
    3bc2:	3004d4        	ae_cvtp24a16x2.ll	aep0, a4, a13
    3bc5:	e80080d4ef 	{ movi	a14, 212; ae_mulfp24s.hh	aeq0, aep0, aep0 }
    3bca:	d4e20000ff 	{ movi	a15, 0; ae_mulfq32sp16s.l	aeq0, aeq0, aep0 }
    3bcf:	6f53f2        	s16i	a15, a3, 222
    3bd2:	3603d4        	ae_sllisq56s	aeq0, aeq0, 15
    3bd5:	fc247c2e3f 	{ ae_lq32f.xu	aeq1, a14, a3; ae_roundsq32asym	aeq0, aeq0 }
    3bda:	350174        	ae_sraiq56	aeq0, aeq0, 5
    3bdd:	0118c4        	ae_addq56	aeq0, aeq1, aeq0
    3be0:	060934        	ae_roundsq32asym	aeq0, aeq0
    3be3:	620e04        	ae_sq32f.i	aeq0, a14, 0
    3be6:	352342        	l32i	a4, a3, 212
    3be9:	150c           	movi.n	a5, 1
    3beb:	015520        	slli	a5, a5, 30
    3bee:	214140        	srai	a4, a4, 1
    3bf1:	445a           	add.n	a4, a4, a5
    3bf3:	378a44        	ae_truncp24a32x2	aep0, a10, a4
    3bf6:	e801bec27f 	{ ae_cvtq48a32s	aeq1, a2; ae_mulfp24s.lh	aeq0, aep0, aep0 }
    3bfb:	0e0c           	movi.n	a14, 0
    3bfd:	350054        	ae_slliq56	aeq0, aeq0, 1
    3c00:	d5440001ff 	{ movi	a15, 1; ae_leq56s	b0, aeq1, aeq0 }
    3c05:	060c           	movi.n	a6, 0
    3c07:	140c           	movi.n	a4, 1
    3c09:	d3ef00        	movt	a14, a15, b0
    3c0c:	6e8c           	beqz.n	a14, 3c16 <cali_power+0x26e>
    3c0e:	6e9322        	l16si	a2, a3, 220
    3c11:	224b           	addi.n	a2, a2, 4
    3c13:	000546        	j	3c2c <cali_power+0x284>

00003c16 <cali_power+0x26e>:
    3c16:	779322        	l16si	a2, a3, 238
    3c19:	6e9352        	l16si	a5, a3, 220
    3c1c:	112200        	slli	a2, a2, 16
    3c1f:	364234        	ae_cvtq48a32s	aeq1, a2
    3c22:	d6480fc52e 	{ addi	a2, a5, -4; ae_ltq56s	b0, aeq0, aeq1 }
    3c27:	d36400        	movt	a6, a4, b0
    3c2a:	168c           	beqz.n	a6, 3c2f <cali_power+0x287>
    3c2c:	6e5322        	s16i	a2, a3, 220
    3c2f:	3120a0        	srai	a2, a10, 16
    3c32:	705322        	s16i	a2, a3, 224
    3c35:	f01d           	retw.n

00003c37 <cali_power+0x28f>:
	...

00003c38 <mag_calibration>:
    3c38:	004136        	entry	a1, 32
    3c3b:	f12531        	l32r	a3, d0 (6880 <immediate_num>)
    3c3e:	e8a042        	movi	a4, 232
    3c41:	4cc2e2        	addi	a14, a2, 76
    3c44:	28c362        	addi	a6, a3, 40
    3c47:	603424        	ae_lq32f.xu	aeq0, a4, a2
    3c4a:	440604        	ae_lp16x2f.i	aep0, a6, 0
    3c4d:	604e04        	ae_lq32f.i	aeq1, a14, 0
    3c50:	0c0080ecff 	{ movi	a15, 236; ae_mulzaafq32sp16s.lh	aeq0, aeq0, aep0, aeq1, aep0 }
    3c55:	608e14        	ae_lq32f.i	aeq2, a14, 4
    3c58:	fc247c6f2f 	{ ae_lq32f.xu	aeq3, a15, a2; ae_roundsq32asym	aeq0, aeq0 }
    3c5d:	0e0379840f 	{ ae_sq32f.i	aeq0, a4, 0; ae_mulzaafq32sp16s.lh	aeq1, aeq3, aep0, aeq2, aep0 }
    3c62:	3a22b2        	l32i	a11, a2, 232
    3c65:	ff2c40015f 	{ movi	a5, 1; ae_roundsq32asym	aeq3, aeq1 }
    3c6a:	10d552        	addmi	a5, a5, 0x1000
    3c6d:	623f04        	ae_sq32f.i	aeq3, a15, 0
    3c70:	02ab57        	bge	a11, a5, 3c76 <mag_calibration+0x3e>
    3c73:	004386        	j	3d85 <mag_calibration+0x14d>
    3c76:	3b2242        	l32i	a4, a2, 236
    3c79:	8ea152        	movi	a5, 0x18e
    3c7c:	21a240        	srai	a10, a4, 2
    3c7f:	f11541        	l32r	a4, d4 (5324 <airoha_divide_limit_1>)
    3c82:	0004e0        	callx8	a4
    3c85:	6c9242        	l16si	a4, a2, 216
    3c88:	378aa4        	ae_truncp24a32x2	aep0, a10, a10
    3c8b:	f8e2b3c26e 	{ l32i	a6, a2, 240; ae_roundsp16asym	aep0, aep0 }
    3c90:	441b           	addi.n	a4, a4, 1
    3c92:	94fd           	ae_zext16	a15, a4
    3c94:	430254        	ae_sp16f.l.x	aep0, a2, a5
    3c97:	6c5242        	s16i	a4, a2, 216
    3c9a:	02cf26        	beqi	a15, 32, 3ca0 <mag_calibration+0x68>
    3c9d:	0033c6        	j	3d70 <mag_calibration+0x138>
    3ca0:	739262        	l16si	a6, a2, 230
    3ca3:	f4a072        	movi	a7, 244
    3ca6:	a27a           	add.n	a10, a2, a7
    3ca8:	040c           	movi.n	a4, 0
    3caa:	791252        	l16ui	a5, a2, 242
    3cad:	9066a0        	addx2	a6, a6, a10
    3cb0:	6c5242        	s16i	a4, a2, 216
    3cb3:	665d           	ae_s16i.n	a5, a6, 0
    3cb5:	f14051        	l32r	a5, 1b8 (33f8 <take_max_four>)
    3cb8:	cb0c           	movi.n	a11, 12
    3cba:	0005e0        	callx8	a5
    3cbd:	739272        	l16si	a7, a2, 230
    3cc0:	14a182        	movi	a8, 0x114
    3cc3:	4362a2        	s32i	a10, a2, 0x10c
    3cc6:	a28a           	add.n	a10, a2, a8
    3cc8:	891252        	l16ui	a5, a2, 0x112
    3ccb:	9077a0        	addx2	a7, a7, a10
    3cce:	675d           	ae_s16i.n	a5, a7, 0
    3cd0:	f13b51        	l32r	a5, 1bc (4c40 <take_min_four>)
    3cd3:	cb0c           	movi.n	a11, 12
    3cd5:	0ca162        	movi	a6, 0x10c
    3cd8:	0005e0        	callx8	a5
    3cdb:	e4a052        	movi	a5, 228
    3cde:	418524        	ae_lp16f.xu	aep0, a5, a2
    3ce1:	ea01fb926f 	{ ae_lq32f.x	aeq0, a2, a6; ae_mulfp24s.ll	aeq1, aep0, aep0 }
    3ce6:	4b62a2        	s32i	a10, a2, 0x12c
    3ce9:	f86b812cef 	{ movi	a14, 0x12c; ae_roundsp16q48asym	aep0, aeq1 }
    3cee:	d5e23bb2ef 	{ ae_lq32f.x	aeq1, a2, a14; ae_mulfq32sp16s.l	aeq2, aeq0, aep0 }
    3cf3:	0f0c           	movi.n	a15, 0
    3cf5:	d65400017f 	{ movi	a7, 1; ae_ltq56s	b0, aeq1, aeq2 }
    3cfa:	cda062        	movi	a6, 205
    3cfd:	6cd662        	addmi	a6, a6, 0x6c00
    3d00:	d3f700        	movt	a15, a7, b0
    3d03:	6fac           	beqz.n	a15, 3d2d <mag_calibration+0xf5>
    3d05:	fe3458866f 	{ ae_cvtp24a16x2.ll	aep0, a6, a6; ae_roundsq32asym	aeq2, aeq2 }
    3d0a:	d7e20000ff 	{ movi	a15, 0; ae_mulfq32sp16s.l	aeq2, aeq2, aep0 }
    3d0f:	170c           	movi.n	a7, 1
    3d11:	d6c800e06f 	{ movi	a6, 224; ae_ltq56s	b0, aeq2, aeq1 }
    3d16:	2cc332        	addi	a3, a3, 44
    3d19:	d3f700        	movt	a15, a7, b0
    3d1c:	df8c           	beqz.n	a15, 3d2d <mag_calibration+0xf5>
    3d1e:	440304        	ae_lp16x2f.i	aep0, a3, 0
    3d21:	607624        	ae_lq32f.xu	aeq1, a6, a2
    3d24:	c10044        	ae_mulzaafq32sp16s.lh	aeq0, aeq1, aep0, aeq0, aep0
    3d27:	060934        	ae_roundsq32asym	aeq0, aeq0
    3d2a:	620604        	ae_sq32f.i	aeq0, a6, 0

00003d2d <mag_calibration+0xf5>:
    3d2d:	3822b2        	l32i	a11, a2, 224
    3d30:	f0bf31        	l32r	a3, 2c (488 <HIFI_sqrt>)
    3d33:	0a0c           	movi.n	a10, 0
    3d35:	0003e0        	callx8	a3
    3d38:	7392d2        	l16si	a13, a2, 230
    3d3b:	c79232        	l16si	a3, a2, 0x18e
    3d3e:	360b34        	ae_cvtq48a32s	aeq0, a11
    3d41:	fc24fe8a0f 	{ ae_slaasq56s	aeq0, aeq0, a10; nop }
    3d46:	fc246c050f 	{ ae_lp16f.i	aep0, a5, 0; ae_roundsq32asym	aeq0, aeq0 }
    3d4b:	d4e2001d5e 	{ addi	a5, a13, 1; ae_mulfq32sp16s.l	aeq0, aeq0, aep0 }
    3d50:	113300        	slli	a3, a3, 16
    3d53:	85ed           	ae_sext16	a14, a5
    3d55:	b60c           	movi.n	a6, 11
    3d57:	3c6232        	s32i	a3, a2, 240
    3d5a:	446232        	s32i	a3, a2, 0x110
    3d5d:	7236e0        	salt	a3, a6, a14
    3d60:	935430        	movnez	a5, a4, a3
    3d63:	f8638542fe 	{ addi	a15, a2, 84; ae_roundsp16q48asym	aep0, aeq0 }
    3d68:	735252        	s16i	a5, a2, 230
    3d6b:	420f04        	ae_sp16f.l.i	aep0, a15, 0
    3d6e:	f01d           	retw.n

00003d70 <mag_calibration+0x138>:
    3d70:	c79232        	l16si	a3, a2, 0x18e
    3d73:	442252        	l32i	a5, a2, 0x110
    3d76:	113300        	slli	a3, a3, 16
    3d79:	534630        	max	a4, a6, a3
    3d7c:	433530        	min	a3, a5, a3
    3d7f:	3c6242        	s32i	a4, a2, 240
    3d82:	446232        	s32i	a3, a2, 0x110
    3d85:	f01d           	retw.n

00003d87 <mag_calibration+0x14f>:
	...

00003d88 <beam1_proc>:
    3d88:	008136        	entry	a1, 64
    3d8b:	5169           	s32i.n	a6, a1, 20
    3d8d:	fc2491664f 	{ addx2	a6, a6, a4; ae_zeroq56	aeq0 }
    3d92:	3815a6        	blti	a5, 1, 3dce <beam1_proc+0x46>
    3d95:	5f0c           	movi.n	a15, 5
    3d97:	4179           	s32i.n	a7, a1, 16
    3d99:	440604        	ae_lp16x2f.i	aep0, a6, 0
    3d9c:	064d           	mov.n	a4, a6
    3d9e:	048f76        	loop	a15, 3da6 <beam1_proc+0x1e>
    3da1:	e2002d841f 	{ ae_lp16x2f.iu	aep0, a4, 4; ae_mulaafp24s.hh.ll	aeq0, aep0, aep0 }

00003da6 <beam1_proc+0x1e>:
    3da6:	3500b4        	ae_sraiq56	aeq0, aeq0, 2
    3da9:	fc2440014f 	{ movi	a4, 1; ae_roundsq32asym	aeq0, aeq0 }
    3dae:	1a0c           	movi.n	a10, 1
    3db0:	270c           	movi.n	a7, 2
    3db2:	014470        	slli	a4, a4, 25
    3db5:	01aab0        	slli	a10, a10, 21
    3db8:	727750        	salt	a7, a7, a5
    3dbb:	93a470        	movnez	a10, a4, a7
    3dbe:	368b04        	ae_trunca32q48	a11, aeq0
    3dc1:	f0c541        	l32r	a4, d8 (521c <airoha_divide>)
    3dc4:	0004e0        	callx8	a4
    3dc7:	4178           	l32i.n	a7, a1, 16
    3dc9:	71a9           	s32i.n	a10, a1, 28
    3dcb:	ffffc6        	j	3dce <beam1_proc+0x46>

00003dce <beam1_proc+0x46>:
    3dce:	14c342        	addi	a4, a3, 20
    3dd1:	24c3a2        	addi	a10, a3, 36
    3dd4:	fec692        	addi	a9, a6, -2
    3dd7:	10c362        	addi	a6, a3, 16
    3dda:	3388           	l32i.n	a8, a3, 12
    3ddc:	13c8           	l32i.n	a12, a3, 4
    3dde:	4139           	s32i.n	a3, a1, 16
    3de0:	6e9232        	l16si	a3, a2, 220
    3de3:	0d0c           	movi.n	a13, 0
    3de5:	6169           	s32i.n	a6, a1, 24
    3de7:	400604        	ae_lp16f.i	aep0, a6, 0
    3dea:	5168           	l32i.n	a6, a1, 20
    3dec:	627d70        	saltu	a7, a13, a7
    3def:	723d30        	salt	a3, a13, a3
    3df2:	103730        	and	a3, a7, a3
    3df5:	030470        	rsr.br	a7
    3df8:	90c6c0        	addx2	a12, a6, a12
    3dfb:	0a0370        	depbits	a7, a3, 0, 1
    3dfe:	130470        	wsr.br	a7
    3e01:	0e0c           	movi.n	a14, 0
    3e03:	1f0c           	movi.n	a15, 1
    3e05:	fecc62        	addi	a6, a12, -2
    3e08:	360b34        	ae_cvtq48a32s	aeq0, a11
    3e0b:	f3f640        	wur.ae_cbegin0	a4
    3e0e:	fd0c16ef0f 	{ movt	a14, a15, b0; ae_cvtq48p24s.l	aeq1, aep0 }
    3e13:	2b0c           	movi.n	a11, 2
    3e15:	870c           	movi.n	a7, 8
    3e17:	f3f7a0        	wur.ae_cend0	a10
    3e1a:	0a4d           	mov.n	a4, a10
    3e1c:	20f660        	or	a15, a6, a6
    3e1f:	409914        	ae_lp16f.iu	aep1, a9, 2
    3e22:	fc24e298bf 	{ ae_sp16f.l.c	aep1, a8, a11; nop }
    3e27:	400404        	ae_lp16f.i	aep0, a4, 0
    3e2a:	20c440        	or	a12, a4, a4
    3e2d:	098776        	loop	a7, 3e3a <beam1_proc+0xb2>
    3e30:	fc24d918bf 	{ ae_lp16f.c	aep1, a8, a11; nop }
    3e35:	ee21ec8c1f 	{ ae_lp16f.iu	aep0, a12, 2; ae_mulsfp24s.ll	aeq1, aep0, aep1 }

00003e3a <beam1_proc+0xb2>:
    3e3a:	f86bec8f1f 	{ ae_lp16f.iu	aep0, a15, 2; ae_roundsp16q48asym	aep1, aeq1 }
    3e3f:	0914a4        	ae_movp48	aep2, aep1
    3e42:	1eac           	beqz.n	a14, 3e67 <beam1_proc+0xdf>
    3e44:	402204        	ae_lp16f.i	aep2, a2, 0
    3e47:	eb29bd227f 	{ ae_lq32f.i	aeq1, a2, 28; ae_mulfp24s.ll	aeq2, aep2, aep1 }
    3e4c:	407224        	ae_lp16f.i	aep7, a2, 4
    3e4f:	35a094        	ae_slliq56	aeq2, aeq2, 2
    3e52:	f59fbd626f 	{ ae_lq32f.i	aeq3, a2, 24; ae_mulafq32sp16s.l	aeq2, aeq1, aep7 }
    3e57:	403214        	ae_lp16f.i	aep3, a2, 2
    3e5a:	f78fb9b27f 	{ ae_sq32f.i	aeq3, a2, 28; ae_mulafq32sp16s.l	aeq2, aeq3, aep3 }
    3e5f:	06a934        	ae_roundsq32asym	aeq2, aeq2
    3e62:	f973b9a26f 	{ ae_sq32f.i	aeq2, a2, 24; ae_roundsp16q48asym	aep2, aeq2 }

00003e67 <beam1_proc+0xdf>:
    3e67:	d4e672a61f 	{ ae_sp16f.l.iu	aep2, a6, 2; ae_mulfq32sp16s.l	aeq1, aeq0, aep1 }
    3e6c:	f0cc42        	addi	a4, a12, -16
    3e6f:	2815a6        	blti	a5, 1, 3e9b <beam1_proc+0x113>
    3e72:	0430d0        	extui	a3, a13, 0, 1
    3e75:	23ec           	bnez.n	a3, 3e9b <beam1_proc+0x113>
    3e77:	7138           	l32i.n	a3, a1, 28
    3e79:	fc24fe934f 	{ ae_slaasq56s	aeq1, aeq1, a3; nop }
    3e7e:	f86fec2c8f 	{ ae_lp16f.i	aep2, a12, -16; ae_roundsp24q48asym	aep1, aeq1 }
    3e83:	f03d           	nop.n
    3e85:	0f8776        	loop	a7, 3e98 <beam1_proc+0x110>
    3e88:	fd4c1978bf 	{ ae_lp16f.c	aep7, a8, a11; ae_cvtq48p24s.l	aeq1, aep2 }
    3e8d:	e2e7eca41f 	{ ae_lp16f.iu	aep2, a4, 2; ae_mulafp24s.ll	aeq1, aep1, aep7 }
    3e92:	1b9f34        	ae_roundsp16q48asym	aep3, aeq1
    3e95:	4234f4        	ae_sp16f.l.i	aep3, a4, -2

00003e98 <beam1_proc+0x110>:
    3e98:	f0c442        	addi	a4, a4, -16

00003e9b <beam1_proc+0x113>:
    3e9b:	fd0c001dde 	{ addi	a13, a13, 1; ae_cvtq48p24s.l	aeq1, aep0 }
    3ea0:	029d26        	beqi	a13, 10, 3ea6 <beam1_proc+0x11e>
    3ea3:	ffde06        	j	3e1f <beam1_proc+0x97>
    3ea6:	4158           	l32i.n	a5, a1, 16
    3ea8:	6138           	l32i.n	a3, a1, 24
    3eaa:	440c           	movi.n	a4, 4
    3eac:	3589           	s32i.n	a8, a5, 12
    3eae:	fc24b2030f 	{ ae_sp16f.l.i	aep0, a3, 0; ae_zeroq56	aeq0 }
    3eb3:	440a04        	ae_lp16x2f.i	aep0, a10, 0
    3eb6:	0a3d           	mov.n	a3, a10
    3eb8:	048476        	loop	a4, 3ec0 <beam1_proc+0x138>
    3ebb:	e2002d831f 	{ ae_lp16x2f.iu	aep0, a3, 4; ae_mulaafp24s.hh.ll	aeq0, aep0, aep0 }

00003ec0 <beam1_proc+0x138>:
    3ec0:	f863a0622e 	{ l16si	a2, a2, 12; ae_roundsp16q48asym	aep0, aeq0 }
    3ec5:	360324        	ae_trunca16p24s.l	a3, aep0
    3ec8:	095532        	s16i	a3, a5, 18
    3ecb:	faa042        	movi	a4, 250
    3ece:	19a237        	bge	a2, a3, 3eeb <beam1_proc+0x163>
    3ed1:	7ed422        	addmi	a2, a4, 0x7e00
    3ed4:	08a032        	movi	a3, 8
    3ed7:	300224        	ae_cvtp24a16x2.ll	aep0, a2, a2
    3eda:	401a04        	ae_lp16f.i	aep1, a10, 0
    3edd:	0a8376        	loop	a3, 3eeb <beam1_proc+0x163>
    3ee0:	ea21ac9a1f 	{ ae_lp16f.iu	aep1, a10, 2; ae_mulfp24s.ll	aeq0, aep0, aep1 }
    3ee5:	1b8f24        	ae_roundsp16q48asym	aep2, aeq0
    3ee8:	422af4        	ae_sp16f.l.i	aep2, a10, -2

00003eeb <beam1_proc+0x163>:
    3eeb:	f01d           	retw.n

00003eed <beam1_proc+0x165>:
    3eed:	000000                                        ...

00003ef0 <beam2_proc>:
    3ef0:	00e136        	entry	a1, 112
    3ef3:	03cd           	mov.n	a12, a3
    3ef5:	fd24a1d39e 	{ l16si	a9, a3, 58; ae_zeroq56	aeq1 }
    3efa:	f3a8           	l32i.n	a10, a3, 60
    3efc:	078d           	mov.n	a8, a7
    3efe:	117910        	slli	a7, a9, 15
    3f01:	727a70        	salt	a7, a10, a7
    3f04:	6cc3a2        	addi	a10, a3, 108
    3f07:	05fd           	mov.n	a15, a5
    3f09:	352b           	addi.n	a3, a5, 2
    3f0b:	cd7c           	movi.n	a13, -4
    3f0d:	eb7c           	movi.n	a11, -2
    3f0f:	93fd30        	movnez	a15, a13, a3
    3f12:	f3f6a0        	wur.ae_cbegin0	a10
    3f15:	8d7c           	movi.n	a13, -8
    3f17:	aa7c           	movi.n	a10, -6
    3f19:	fec692        	addi	a9, a6, -2
    3f1c:	93ad30        	movnez	a10, a13, a3
    3f1f:	be7c           	movi.n	a14, -5
    3f21:	72b5b0        	salt	a11, a5, a11
    3f24:	839670        	moveqz	a9, a6, a7
    3f27:	83eab0        	moveqz	a14, a10, a11
    3f2a:	1d2132        	l32i	a3, a1, 116
    3f2d:	80d872        	addmi	a7, a8, 0xffff8000
    3f30:	0ca8           	l32i.n	a10, a12, 0
    3f32:	303884        	ae_cvtp24a16x2.ll	aep3, a8, a8
    3f35:	d199           	s32i.n	a9, a1, 52
    3f37:	190c           	movi.n	a9, 1
    3f39:	871b           	addi.n	a8, a7, 1
    3f3b:	f1e9           	s32i.n	a14, a1, 60
    3f3d:	0e0c           	movi.n	a14, 0
    3f3f:	93feb0        	movnez	a15, a14, a11
    3f42:	626870        	saltu	a6, a8, a7
    3f45:	729590        	salt	a9, a5, a9
    3f48:	1cb8           	l32i.n	a11, a12, 4
    3f4a:	10d960        	and	a13, a9, a6
    3f4d:	e1f9           	s32i.n	a15, a1, 56
    3f4f:	3accf2        	addi	a15, a12, 58
    3f52:	9063a0        	addx2	a6, a3, a10
    3f55:	81f9           	s32i.n	a15, a1, 32
    3f57:	404ff4        	ae_lp16f.i	aep4, a15, -2
    3f5a:	fec6f2        	addi	a15, a6, -2
    3f5d:	dc68           	l32i.n	a6, a12, 52
    3f5f:	904340        	addx2	a4, a3, a4
    3f62:	7ccc72        	addi	a7, a12, 124
    3f65:	9033b0        	addx2	a3, a3, a11
    3f68:	1c21e2        	l32i	a14, a1, 112
    3f6b:	40cc82        	addi	a8, a12, 64
    3f6e:	71e9           	s32i.n	a14, a1, 28
    3f70:	fec492        	addi	a9, a4, -2
    3f73:	fec3e2        	addi	a14, a3, -2
    3f76:	9159           	s32i.n	a5, a1, 36
    3f78:	f3f770        	wur.ae_cend0	a7
    3f7b:	230c           	movi.n	a3, 2
    3f7d:	040c           	movi.n	a4, 0
    3f7f:	b189           	s32i.n	a8, a1, 44
    3f81:	a179           	s32i.n	a7, a1, 40
    3f83:	1061c2        	s32i	a12, a1, 64
    3f86:	563114        	ae_sp24x2s.i	aep3, a1, 8
    3f89:	c1d9           	s32i.n	a13, a1, 48
    3f8b:	0004c6        	j	3fa2 <beam2_proc+0xb2>

00003f8e <beam2_proc+0x9e>:
    3f8e:	408914        	ae_lp16f.iu	aep0, a9, 2
    3f91:	fa62b2cf1f 	{ ae_sp16f.l.iu	aep4, a15, 2; ae_movp48	aep4, aep0 }
    3f96:	075d           	mov.n	a5, a7
    3f98:	441b           	addi.n	a4, a4, 1
    3f9a:	057d           	mov.n	a7, a5
    3f9c:	029466        	bnei	a4, 10, 3fa2 <beam2_proc+0xb2>
    3f9f:	0042c6        	j	40ae <beam2_proc+0x1be>
    3fa2:	6e1252        	l16ui	a5, a2, 220
    3fa5:	408e14        	ae_lp16f.iu	aep0, a14, 2
    3fa8:	fc24a2863f 	{ ae_sp16f.l.c	aep0, a6, a3; ae_zeroq56	aeq0 }
    3fad:	fdd516        	beqz	a5, 3f8e <beam2_proc+0x9e>
    3fb0:	850c           	movi.n	a5, 8
    3fb2:	400704        	ae_lp16f.i	aep0, a7, 0
    3fb5:	098576        	loop	a5, 3fc2 <beam2_proc+0xd2>
    3fb8:	fc24d9163f 	{ ae_lp16f.c	aep1, a6, a3; nop }
    3fbd:	e223ac871f 	{ ae_lp16f.iu	aep0, a7, 2; ae_mulafp24s.ll	aeq0, aep0, aep1 }

00003fc2 <beam2_proc+0xd2>:
    3fc2:	f867bf456f 	{ ae_trunca16p24s.l	a5, aep4; ae_roundsp24q48asym	aep0, aeq0 }
    3fc7:	0ac484        	ae_cvtq48p24s.l	aeq3, aep4
    3fca:	058bc4        	ae_mulssfp24s.hh.ll	aeq3, aep0, aep3
    3fcd:	605150        	abs	a5, a5
    3fd0:	1bbf04        	ae_roundsp16q48asym	aep0, aeq3
    3fd3:	360824        	ae_trunca16p24s.l	a8, aep0
    3fd6:	608180        	abs	a8, a8
    3fd9:	02a587        	bge	a5, a8, 3fdf <beam2_proc+0xef>
    3fdc:	094484        	ae_movp48	aep0, aep4

00003fdf <beam2_proc+0xef>:
    3fdf:	40c914        	ae_lp16f.iu	aep4, a9, 2
    3fe2:	f0c752        	addi	a5, a7, -16
    3fe5:	428f14        	ae_sp16f.l.iu	aep0, a15, 2
    3fe8:	facd16        	beqz	a13, 3f98 <beam2_proc+0xa8>
    3feb:	025426        	beqi	a4, 5, 3ff1 <beam2_proc+0x101>
    3fee:	08e456        	bnez	a4, 4080 <beam2_proc+0x190>
    3ff1:	fc2499063f 	{ ae_lp16f.c	aep0, a6, a3; ae_zeroq56	aeq0 }
    3ff6:	fc24d9063f 	{ ae_lp16f.c	aep0, a6, a3; nop }
    3ffb:	fc24d9063f 	{ ae_lp16f.c	aep0, a6, a3; nop }
    4000:	fc24d9063f 	{ ae_lp16f.c	aep0, a6, a3; nop }
    4005:	480c           	movi.n	a8, 4
    4007:	1161f2        	s32i	a15, a1, 68
    400a:	e203b7412f 	{ ae_sp24x2s.i	aep4, a1, 16; ae_mulafp24s.ll	aeq0, aep0, aep0 }
    400f:	1261e2        	s32i	a14, a1, 72
    4012:	136192        	s32i	a9, a1, 76
    4015:	078876        	loop	a8, 4020 <beam2_proc+0x130>
    4018:	fc24d9063f 	{ ae_lp16f.c	aep0, a6, a3; nop }
    401d:	010034        	ae_mulafp24s.ll	aeq0, aep0, aep0

00004020 <beam2_proc+0x130>:
    4020:	b188           	l32i.n	a8, a1, 44
    4022:	3500b4        	ae_sraiq56	aeq0, aeq0, 2
    4025:	190c           	movi.n	a9, 1
    4027:	604804        	ae_lq32f.i	aeq1, a8, 0
    402a:	f96a30f1ae 	{ l32i	a10, a1, 60; ae_addq56	aeq1, aeq1, aeq0 }
    402f:	fc244000df 	{ movi	a13, 0; ae_roundsq32asym	aeq0, aeq0 }
    4034:	fd2c79880f 	{ ae_sq32f.i	aeq0, a8, 0; ae_roundsq32asym	aeq1, aeq1 }
    4039:	689282        	l16si	a8, a2, 208
    403c:	369b04        	ae_trunca32q48	a11, aeq1
    403f:	119940        	slli	a9, a9, 12
    4042:	728d80        	salt	a8, a13, a8
    4045:	e1d8           	l32i.n	a13, a1, 56
    4047:	116cb2        	s32i	a11, a12, 68
    404a:	729b90        	salt	a9, a11, a9
    404d:	cc7c           	movi.n	a12, -4
    404f:	d1e8           	l32i.n	a14, a1, 52
    4051:	93ac90        	movnez	a10, a12, a9
    4054:	83ad80        	moveqz	a10, a13, a8
    4057:	808ea0        	add	a8, a14, a10
    405a:	401800        	ssl	a8
    405d:	01a0f2        	movi	a15, 1
    4060:	f01e81        	l32r	a8, d8 (521c <airoha_divide>)
    4063:	a1af00        	sll	a10, a15
    4066:	0008e0        	callx8	a8
    4069:	fd24b101ce 	{ l32i	a12, a1, 64; ae_zeroq56	aeq1 }
    406e:	0c21d2        	l32i	a13, a1, 48
    4071:	132192        	l32i	a9, a1, 76
    4074:	1221e2        	l32i	a14, a1, 72
    4077:	1121f2        	l32i	a15, a1, 68
    407a:	543114        	ae_lp24x2.i	aep3, a1, 8
    407d:	544124        	ae_lp24x2.i	aep4, a1, 16

00004080 <beam2_proc+0x190>:
    4080:	400f04        	ae_lp16f.i	aep0, a15, 0
    4083:	360b34        	ae_cvtq48a32s	aeq0, a11
    4086:	d4e200088f 	{ movi	a8, 8; ae_mulfq32sp16s.l	aeq0, aeq0, aep0 }
    408b:	fc24fe8a0f 	{ ae_slaasq56s	aeq0, aeq0, a10; nop }
    4090:	f867ac178f 	{ ae_lp16f.i	aep1, a7, -16; ae_roundsp24q48asym	aep0, aeq0 }
    4095:	0f8876        	loop	a8, 40a8 <beam2_proc+0x1b8>
    4098:	fc2c19763f 	{ ae_lp16f.c	aep7, a6, a3; ae_cvtq48p24s.l	aeq0, aep1 }
    409d:	e2e3ac951f 	{ ae_lp16f.iu	aep1, a5, 2; ae_mulafp24s.ll	aeq0, aep0, aep7 }
    40a2:	1b8f24        	ae_roundsp16q48asym	aep2, aeq0
    40a5:	4225f4        	ae_sp16f.l.i	aep2, a5, -2

000040a8 <beam2_proc+0x1b8>:
    40a8:	f0c552        	addi	a5, a5, -16
    40ab:	ffba46        	j	3f98 <beam2_proc+0xa8>

000040ae <beam2_proc+0x1be>:
    40ae:	dc69           	s32i.n	a6, a12, 52
    40b0:	a168           	l32i.n	a6, a1, 40
    40b2:	8158           	l32i.n	a5, a1, 32
    40b4:	430c           	movi.n	a3, 4
    40b6:	440604        	ae_lp16x2f.i	aep0, a6, 0
    40b9:	064d           	mov.n	a4, a6
    40bb:	4245f4        	ae_sp16f.l.i	aep4, a5, -2
    40be:	048376        	loop	a3, 40c6 <beam2_proc+0x1d6>
    40c1:	e2006d841f 	{ ae_lp16x2f.iu	aep0, a4, 4; ae_mulaafp24s.hh.ll	aeq1, aep0, aep0 }

000040c6 <beam2_proc+0x1d6>:
    40c6:	f86bb0914e 	{ l32i	a4, a1, 36; ae_roundsp16q48asym	aep0, aeq1 }
    40cb:	d37c           	movi.n	a3, -3
    40cd:	420504        	ae_sp16f.l.i	aep0, a5, 0
    40d0:	712347        	blt	a3, a4, 4145 <beam2_proc+0x255>
    40d3:	681222        	l16ui	a2, a2, 208
    40d6:	06b256        	bnez	a2, 4145 <beam2_proc+0x255>
    40d9:	279c22        	l16si	a2, a12, 78
    40dc:	1d9c42        	l16si	a4, a12, 58
    40df:	122c52        	l32i	a5, a12, 72
    40e2:	221b           	addi.n	a2, a2, 1
    40e4:	823d           	ae_sext16	a3, a2
    40e6:	275c22        	s16i	a2, a12, 78
    40e9:	53c3a6        	blti	a3, 32, 4140 <beam2_proc+0x250>
    40ec:	122c32        	l32i	a3, a12, 72
    40ef:	289c52        	l16si	a5, a12, 80
    40f2:	54cca2        	addi	a10, a12, 84
    40f5:	10c332        	addi	a3, a3, 16
    40f8:	020c           	movi.n	a2, 0
    40fa:	9055a0        	addx2	a5, a5, a10
    40fd:	413530        	srli	a3, a3, 5
    4100:	1d9c42        	l16si	a4, a12, 58
    4103:	275c22        	s16i	a2, a12, 78
    4106:	653d           	ae_s16i.n	a3, a5, 0
    4108:	289c32        	l16si	a3, a12, 80
    410b:	be0c           	movi.n	a14, 11
    410d:	126c42        	s32i	a4, a12, 72
    4110:	331b           	addi.n	a3, a3, 1
    4112:	83fd           	ae_sext16	a15, a3
    4114:	724ef0        	salt	a4, a14, a15
    4117:	933240        	movnez	a3, a2, a4
    411a:	f02821        	l32r	a2, 1bc (4c40 <take_min_four>)
    411d:	cb0c           	movi.n	a11, 12
    411f:	285c32        	s16i	a3, a12, 80
    4122:	0c4d           	mov.n	a4, a12
    4124:	0002e0        	callx8	a2
    4127:	efea21        	l32r	a2, d0 (6880 <immediate_num>)
    412a:	f438           	l32i.n	a3, a4, 60
    412c:	0abd           	mov.n	a11, a10
    412e:	20c2c2        	addi	a12, a2, 32
    4131:	effd21        	l32r	a2, 128 (524 <siir_safr>)
    4134:	03ad           	mov.n	a10, a3
    4136:	0002e0        	callx8	a2
    4139:	04cd           	mov.n	a12, a4
    413b:	f4a9           	s32i.n	a10, a4, 60
    413d:	000106        	j	4145 <beam2_proc+0x255>

00004140 <beam2_proc+0x250>:
    4140:	254a           	add.n	a2, a5, a4
    4142:	126c22        	s32i	a2, a12, 72
    4145:	112c22        	l32i	a2, a12, 68
    4148:	130c           	movi.n	a3, 1
    414a:	10d332        	addmi	a3, a3, 0x1000
    414d:	722237        	blt	a2, a3, 41c3 <beam2_proc+0x2d3>
    4150:	7128           	l32i.n	a2, a1, 28
    4152:	d33c           	movi.n	a3, 61
    4154:	d7a042        	movi	a4, 215
    4157:	1522e6        	bgei	a2, 2, 4170 <beam2_proc+0x280>
    415a:	66a022        	movi	a2, 102
    415d:	b33c           	movi.n	a3, 59
    415f:	46d222        	addmi	a2, a2, 0x4600
    4162:	113380        	slli	a3, a3, 8
    4165:	ff3c           	movi.n	a15, 63
    4167:	300324        	ae_cvtp24a16x2.ll	aep0, a3, a2
    416a:	112f70        	slli	a2, a15, 9
    416d:	0002c6        	j	417c <beam2_proc+0x28c>

00004170 <beam2_proc+0x280>:
    4170:	269c22        	l16si	a2, a12, 76
    4173:	4ad332        	addmi	a3, a3, 0x4a00
    4176:	43d442        	addmi	a4, a4, 0x4300
    4179:	300434        	ae_cvtp24a16x2.ll	aep0, a4, a3
    417c:	1d9c32        	l16si	a3, a12, 58
    417f:	fc48           	l32i.n	a4, a12, 60
    4181:	364434        	ae_cvtq48a32s	aeq1, a4
    4184:	113310        	slli	a3, a3, 15
    4187:	d5633ec33f 	{ ae_cvtq48a32s	aeq0, a3; ae_mulfq32sp16s.h	aeq2, aeq1, aep0 }
    418c:	d4e34000ef 	{ movi	a14, 0; ae_mulfq32sp16s.l	aeq1, aeq1, aep0 }
    4191:	d6c00001ff 	{ movi	a15, 1; ae_ltq56s	b0, aeq2, aeq0 }
    4196:	d54840003f 	{ movi	a3, 0; ae_leq56s	b1, aeq0, aeq1 }
    419b:	140c           	movi.n	a4, 1
    419d:	d3ef00        	movt	a14, a15, b0
    41a0:	fe9c           	beqz.n	a14, 41c3 <beam2_proc+0x2d3>
    41a2:	d33410        	movt	a3, a4, b1
    41a5:	438c           	beqz.n	a3, 41ad <beam2_proc+0x2bd>
    41a7:	aea022        	movi	a2, 174
    41aa:	7fd222        	addmi	a2, a2, 0x7f00
    41ad:	8f0c           	movi.n	a15, 8
    41af:	300224        	ae_cvtp24a16x2.ll	aep0, a2, a2
    41b2:	401604        	ae_lp16f.i	aep1, a6, 0
    41b5:	0a8f76        	loop	a15, 41c3 <beam2_proc+0x2d3>
    41b8:	ea21ac961f 	{ ae_lp16f.iu	aep1, a6, 2; ae_mulfp24s.ll	aeq0, aep0, aep1 }
    41bd:	1b8f24        	ae_roundsp16q48asym	aep2, aeq0
    41c0:	4226f4        	ae_sp16f.l.i	aep2, a6, -2

000041c3 <beam2_proc+0x2d3>:
    41c3:	f01d           	retw.n

000041c5 <beam2_proc+0x2d5>:
    41c5:	000000                                        ...

000041c8 <beam1_mid_band>:
    41c8:	006136        	entry	a1, 48
    41cb:	fc24a6b23e 	{ l16si	a3, a2, 214; ae_zeroq56	aeq0 }
    41d0:	3a13a6        	blti	a3, 1, 420e <beam1_mid_band+0x46>
    41d3:	d32242        	l32i	a4, a2, 0x34c
    41d6:	a50c           	movi.n	a5, 10
    41d8:	440404        	ae_lp16x2f.i	aep0, a4, 0
    41db:	f03d           	nop.n
    41dd:	048576        	loop	a5, 41e5 <beam1_mid_band+0x1d>
    41e0:	e2002d841f 	{ ae_lp16x2f.iu	aep0, a4, 4; ae_mulaafp24s.hh.ll	aeq0, aep0, aep0 }

000041e5 <beam1_mid_band+0x1d>:
    41e5:	3500b4        	ae_sraiq56	aeq0, aeq0, 2
    41e8:	fc2440014f 	{ movi	a4, 1; ae_roundsq32asym	aeq0, aeq0 }
    41ed:	368704        	ae_trunca32q48	a7, aeq0
    41f0:	150c           	movi.n	a5, 1
    41f2:	1a0c           	movi.n	a10, 1
    41f4:	260c           	movi.n	a6, 2
    41f6:	114450        	slli	a4, a4, 11
    41f9:	53b740        	max	a11, a7, a4
    41fc:	015570        	slli	a5, a5, 25
    41ff:	01aab0        	slli	a10, a10, 21
    4202:	726630        	salt	a6, a6, a3
    4205:	efb441        	l32r	a4, d8 (521c <airoha_divide>)
    4208:	93a560        	movnez	a10, a5, a6
    420b:	0004e0        	callx8	a4

0000420e <beam1_mid_band+0x46>:
    420e:	d32252        	l32i	a5, a2, 0x34c
    4211:	d222e2        	l32i	a14, a2, 0x348
    4214:	54a3d2        	movi	a13, 0x354
    4217:	5ca342        	movi	a4, 0x35c
    421a:	7ca372        	movi	a7, 0x37c
    421d:	d42262        	l32i	a6, a2, 0x350
    4220:	c24a           	add.n	a12, a2, a4
    4222:	427a           	add.n	a4, a2, a7
    4224:	458d24        	ae_lp16x2f.xu	aep0, a13, a2
    4227:	360b34        	ae_cvtq48a32s	aeq0, a11
    422a:	31d9           	s32i.n	a13, a1, 12
    422c:	f3f6c0        	wur.ae_cbegin0	a12
    422f:	fcc5c2        	addi	a12, a5, -4
    4232:	fe040fcede 	{ addi	a13, a14, -4; ae_cvtq48p24s.h	aeq2, aep0 }
    4237:	080c           	movi.n	a8, 0
    4239:	490c           	movi.n	a9, 4
    423b:	8b0c           	movi.n	a11, 8
    423d:	f3f740        	wur.ae_cend0	a4
    4240:	045d           	mov.n	a5, a4
    4242:	fecee2        	addi	a14, a14, -2
    4245:	fd0c2d9c1f 	{ ae_lp16x2f.iu	aep1, a12, 4; ae_cvtq48p24s.l	aeq1, aep0 }
    424a:	fc24e4169f 	{ ae_sp16x2f.c	aep1, a6, a9; nop }
    424f:	440504        	ae_lp16x2f.i	aep0, a5, 0
    4252:	20f550        	or	a15, a5, a5
    4255:	0c8b76        	loop	a11, 4265 <beam1_mid_band+0x9d>
    4258:	fc24da969f 	{ ae_lp16x2f.c	aep1, a6, a9; nop }
    425d:	0581c4        	ae_mulssfp24s.hh.ll	aeq2, aep0, aep1
    4260:	ee206d8f1f 	{ ae_lp16x2f.iu	aep0, a15, 4; ae_mulsafp24s.hl.lh	aeq1, aep0, aep1 }

00004265 <beam1_mid_band+0x9d>:
    4265:	f873ed8d1f 	{ ae_lp16x2f.iu	aep0, a13, 4; ae_roundsp16q48asym	aep1, aeq2 }
    426a:	f96bb29e1f 	{ ae_sp16f.l.iu	aep1, a14, 2; ae_roundsp16q48asym	aep2, aeq1 }
    426f:	d5ea0e0f5e 	{ addi	a5, a15, -32; ae_mulfq32sp16s.l	aeq2, aeq0, aep2 }
    4274:	d4e672ae1f 	{ ae_sp16f.l.iu	aep2, a14, 2; ae_mulfq32sp16s.l	aeq1, aeq0, aep1 }
    4279:	3a13a6        	blti	a3, 1, 42b7 <beam1_mid_band+0xef>
    427c:	047080        	extui	a7, a8, 0, 1
    427f:	47fc           	bnez.n	a7, 42b7 <beam1_mid_band+0xef>
    4281:	442f84        	ae_lp16x2f.i	aep2, a15, -32
    4284:	fc24feaa8f 	{ ae_slaasq56s	aeq2, aeq2, a10; nop }
    4289:	f977fe9a4f 	{ ae_slaasq56s	aeq1, aeq1, a10; ae_roundsp24q48asym	aep3, aeq2 }
    428e:	fb6fcfe5fe 	{ addi	a15, a5, -2; ae_roundsp24q48asym	aep7, aeq1 }
    4293:	1afb14        	ae_selp24.hl	aep1, aep7, aep3
    4296:	1a8b76        	loop	a11, 42b4 <beam1_mid_band+0xec>
    4299:	fd441ae69f 	{ ae_lp16x2f.c	aep6, a6, a9; ae_cvtq48p24s.h	aeq1, aep2 }
    429e:	fe4c2da51f 	{ ae_lp16x2f.iu	aep2, a5, 4; ae_cvtq48p24s.l	aeq2, aep2 }
    42a3:	051e04        	ae_mulaafp24s.hh.ll	aeq1, aep1, aep6
    42a6:	059654        	ae_mulasfp24s.hl.lh	aeq2, aep1, aep6
    42a9:	1b9f34        	ae_roundsp16q48asym	aep3, aeq1
    42ac:	fb73f2bf1f 	{ ae_sp16f.l.iu	aep3, a15, 2; ae_roundsp16q48asym	aep7, aeq2 }
    42b1:	42ff14        	ae_sp16f.l.iu	aep7, a15, 2
    42b4:	e0c552        	addi	a5, a5, -32

000042b7 <beam1_mid_band+0xef>:
    42b7:	fe0400188e 	{ addi	a8, a8, 1; ae_cvtq48p24s.h	aeq2, aep0 }
    42bc:	859866        	bnei	a8, 10, 4245 <beam1_mid_band+0x7d>
    42bf:	31f8           	l32i.n	a15, a1, 12
    42c1:	830c           	movi.n	a3, 8
    42c3:	d46262        	s32i	a6, a2, 0x350
    42c6:	fc24b30f0f 	{ ae_sp16x2f.i	aep0, a15, 0; ae_zeroq56	aeq0 }
    42cb:	440504        	ae_lp16x2f.i	aep0, a5, 0
    42ce:	048376        	loop	a3, 42d6 <beam1_mid_band+0x10e>
    42d1:	e2002d851f 	{ ae_lp16x2f.iu	aep0, a5, 4; ae_mulaafp24s.hh.ll	aeq0, aep0, aep0 }

000042d6 <beam1_mid_band+0x10e>:
    42d6:	3500b4        	ae_sraiq56	aeq0, aeq0, 2
    42d9:	f863a0625e 	{ l16si	a5, a2, 12; ae_roundsp16q48asym	aep0, aeq0 }
    42de:	360624        	ae_trunca16p24s.l	a6, aep0
    42e1:	03d232        	addmi	a3, a2, 0x300
    42e4:	2c5362        	s16i	a6, a3, 88
    42e7:	20a567        	bge	a5, a6, 430b <beam1_mid_band+0x143>
    42ea:	faa032        	movi	a3, 250
    42ed:	7ed332        	addmi	a3, a3, 0x7e00
    42f0:	7ca362        	movi	a6, 0x37c
    42f3:	051c           	movi.n	a5, 16
    42f5:	411264        	ae_lp16f.x	aep1, a2, a6
    42f8:	300334        	ae_cvtp24a16x2.ll	aep0, a3, a3
    42fb:	f03d           	nop.n
    42fd:	0a8576        	loop	a5, 430b <beam1_mid_band+0x143>
    4300:	ea21ac941f 	{ ae_lp16f.iu	aep1, a4, 2; ae_mulfp24s.ll	aeq0, aep0, aep1 }
    4305:	1b8f24        	ae_roundsp16q48asym	aep2, aeq0
    4308:	4224f4        	ae_sp16f.l.i	aep2, a4, -2

0000430b <beam1_mid_band+0x143>:
    430b:	f01d           	retw.n

0000430d <beam1_mid_band+0x145>:
    430d:	000000                                        ...

00004310 <beam2_mid_band>:
    4310:	00c136        	entry	a1, 96
    4313:	03d2f2        	addmi	a15, a2, 0x300
    4316:	02cd           	mov.n	a12, a2
    4318:	529f72        	l16si	a7, a15, 164
    431b:	d4a342        	movi	a4, 0x3d4
    431e:	ea2282        	l32i	a8, a2, 0x3a8
    4321:	6b92b2        	l16si	a11, a2, 214
    4324:	a0a3a2        	movi	a10, 0x3a0
    4327:	424a           	add.n	a4, a2, a4
    4329:	f4a392        	movi	a9, 0x3f4
    432c:	e72262        	l32i	a6, a2, 0x39c
    432f:	d22252        	l32i	a5, a2, 0x348
    4332:	d32232        	l32i	a3, a2, 0x34c
    4335:	d122d2        	l32i	a13, a2, 0x344
    4338:	117710        	slli	a7, a7, 15
    433b:	f3f640        	wur.ae_cbegin0	a4
    433e:	429a           	add.n	a4, a2, a9
    4340:	45ba24        	ae_lp16x2f.xu	aep3, a10, a2
    4343:	51f9           	s32i.n	a15, a1, 20
    4345:	621c           	movi.n	a2, 22
    4347:	8e1c           	movi.n	a14, 24
    4349:	91a9           	s32i.n	a10, a1, 36
    434b:	727870        	salt	a7, a8, a7
    434e:	190c           	movi.n	a9, 1
    4350:	f3f740        	wur.ae_cend0	a4
    4353:	071be6        	bgei	a11, 1, 435e <beam2_mid_band+0x4e>
    4356:	6e1c82        	l16ui	a8, a12, 220
    4359:	190c           	movi.n	a9, 1
    435b:	629890        	saltu	a9, a8, a9

0000435e <beam2_mid_band+0x4e>:
    435e:	fe248fcd8e 	{ addi	a8, a13, -4; ae_zeroq56	aeq2 }
    4363:	93e270        	movnez	a14, a2, a7
    4366:	fcc372        	addi	a7, a3, -4
    4369:	6189           	s32i.n	a8, a1, 24
    436b:	3b2b           	addi.n	a3, a11, 2
    436d:	8a7c           	movi.n	a10, -8
    436f:	a87c           	movi.n	a8, -6
    4371:	938a30        	movnez	a8, a10, a3
    4374:	0b2d           	mov.n	a2, a11
    4376:	ca7c           	movi.n	a10, -4
    4378:	932a30        	movnez	a2, a10, a3
    437b:	ea7c           	movi.n	a10, -2
    437d:	723ba0        	salt	a3, a11, a10
    4380:	bd7c           	movi.n	a13, -5
    4382:	83d830        	moveqz	a13, a8, a3
    4385:	b1d9           	s32i.n	a13, a1, 44
    4387:	0d0c           	movi.n	a13, 0
    4389:	932d30        	movnez	a2, a13, a3
    438c:	61d8           	l32i.n	a13, a1, 24
    438e:	fcc5f2        	addi	a15, a5, -4
    4391:	81b9           	s32i.n	a11, a1, 32
    4393:	f86e94a12f 	{ s32i.n	a2, a1, 40; ae_movp48	aep0, aep3 }
    4398:	450c           	movi.n	a5, 4
    439a:	020c           	movi.n	a2, 0
    439c:	7149           	s32i.n	a4, a1, 28
    439e:	d1c9           	s32i.n	a12, a1, 52
    43a0:	c199           	s32i.n	a9, a1, 48
    43a2:	003ac6        	j	4491 <beam2_mid_band+0x181>

000043a5 <beam2_mid_band+0x95>:
    43a5:	00000000                                ....

000043a9 <beam2_mid_band+0x99>:
    43a9:	080c           	movi.n	a8, 0
    43ab:	f8e28e034e 	{ addi	a4, a3, -32; ae_roundsp16asym	aep0, aep0 }
    43b0:	468d14        	ae_sp16x2f.iu	aep0, a13, 4
    43b3:	0d2956        	bnez	a9, 4489 <beam2_mid_band+0x179>
    43b6:	025226        	beqi	a2, 5, 43bc <beam2_mid_band+0xac>
    43b9:	089256        	bnez	a2, 4446 <beam2_mid_band+0x136>
    43bc:	fc249a865f 	{ ae_lp16x2f.c	aep0, a6, a5; ae_zeroq56	aeq0 }
    43c1:	fc24da865f 	{ ae_lp16x2f.c	aep0, a6, a5; nop }
    43c6:	fc24da865f 	{ ae_lp16x2f.c	aep0, a6, a5; nop }
    43cb:	fc24da865f 	{ ae_lp16x2f.c	aep0, a6, a5; nop }
    43d0:	f1f9           	s32i.n	a15, a1, 60
    43d2:	4f0c           	movi.n	a15, 4
    43d4:	e20037311f 	{ ae_sp24x2s.i	aep3, a1, 8; ae_mulaafp24s.hh.ll	aeq0, aep0, aep0 }
    43d9:	61d9           	s32i.n	a13, a1, 24
    43db:	e179           	s32i.n	a7, a1, 56
    43dd:	078f76        	loop	a15, 43e8 <beam2_mid_band+0xd8>
    43e0:	fc24da865f 	{ ae_lp16x2f.c	aep0, a6, a5; nop }
    43e5:	050004        	ae_mulaafp24s.hh.ll	aeq0, aep0, aep0

000043e8 <beam2_mid_band+0xd8>:
    43e8:	aca372        	movi	a7, 0x3ac
    43eb:	606c74        	ae_lq32f.x	aeq1, a12, a7
    43ee:	3500b4        	ae_sraiq56	aeq0, aeq0, 2
    43f1:	f96a268c9e 	{ l16si	a9, a12, 208; ae_addq56	aeq1, aeq1, aeq0 }
    43f6:	fd2c4000af 	{ movi	a10, 0; ae_roundsq32asym	aeq1, aeq1 }
    43fb:	fc247f1bef 	{ ae_trunca32q48	a11, aeq1; ae_roundsq32asym	aeq0, aeq0 }
    4400:	729a90        	salt	a9, a10, a9
    4403:	628c74        	ae_sq32f.x	aeq0, a12, a7
    4406:	ec6cb2        	s32i	a11, a12, 0x3b0
    4409:	1c0c           	movi.n	a12, 1
    440b:	b1a8           	l32i.n	a10, a1, 44
    440d:	117c50        	slli	a7, a12, 11
    4410:	72db70        	salt	a13, a11, a7
    4413:	cf7c           	movi.n	a15, -4
    4415:	93afd0        	movnez	a10, a15, a13
    4418:	a1d8           	l32i.n	a13, a1, 40
    441a:	1f0c           	movi.n	a15, 1
    441c:	0e7d           	mov.n	a7, a14
    441e:	83ad90        	moveqz	a10, a13, a9
    4421:	9eaa           	add.n	a9, a14, a10
    4423:	fec9a2        	addi	a10, a9, -2
    4426:	83a980        	moveqz	a10, a9, a8
    4429:	401a00        	ssl	a10
    442c:	ef2b81        	l32r	a8, d8 (521c <airoha_divide>)
    442f:	a1af00        	sll	a10, a15
    4432:	0008e0        	callx8	a8
    4435:	07ed           	mov.n	a14, a7
    4437:	d1c8           	l32i.n	a12, a1, 52
    4439:	c198           	l32i.n	a9, a1, 48
    443b:	f1f8           	l32i.n	a15, a1, 60
    443d:	e178           	l32i.n	a7, a1, 56
    443f:	61d8           	l32i.n	a13, a1, 24
    4441:	fe24b0311f 	{ ae_lp24x2.i	aep3, a1, 8; ae_zeroq56	aeq2 }

00004446 <beam2_mid_band+0x136>:
    4446:	440d04        	ae_lp16x2f.i	aep0, a13, 0
    4449:	360b34        	ae_cvtq48a32s	aeq0, a11
    444c:	d46240088f 	{ movi	a8, 8; ae_mulfq32sp16s.h	aeq1, aeq0, aep0 }
    4451:	d4e22d138f 	{ ae_lp16x2f.i	aep1, a3, -32; ae_mulfq32sp16s.l	aeq0, aeq0, aep0 }
    4456:	fc24fe9a4f 	{ ae_slaasq56s	aeq1, aeq1, a10; nop }
    445b:	fb6ffe8a0f 	{ ae_slaasq56s	aeq0, aeq0, a10; ae_roundsp24q48asym	aep7, aeq1 }
    4460:	f9678fe43e 	{ addi	a3, a4, -2; ae_roundsp24q48asym	aep2, aeq0 }
    4465:	1afa04        	ae_selp24.hl	aep0, aep7, aep2
    4468:	1a8876        	loop	a8, 4486 <beam2_mid_band+0x176>
    446b:	fc241ae65f 	{ ae_lp16x2f.c	aep6, a6, a5; ae_cvtq48p24s.h	aeq0, aep1 }
    4470:	fd2c2d941f 	{ ae_lp16x2f.iu	aep1, a4, 4; ae_cvtq48p24s.l	aeq1, aep1 }
    4475:	050604        	ae_mulaafp24s.hh.ll	aeq0, aep0, aep6
    4478:	050e54        	ae_mulasfp24s.hl.lh	aeq1, aep0, aep6
    447b:	1b8f24        	ae_roundsp16q48asym	aep2, aeq0
    447e:	fb6bf2a31f 	{ ae_sp16f.l.iu	aep2, a3, 2; ae_roundsp16q48asym	aep7, aeq1 }
    4483:	42f314        	ae_sp16f.l.iu	aep7, a3, 2

00004486 <beam2_mid_band+0x176>:
    4486:	e0c442        	addi	a4, a4, -32

00004489 <beam2_mid_band+0x179>:
    4489:	f86e80122e 	{ addi	a2, a2, 1; ae_movp48	aep0, aep3 }
    448e:	519226        	beqi	a2, 10, 44e3 <beam2_mid_band+0x1d3>
    4491:	fc24ad9f1f 	{ ae_lp16x2f.iu	aep1, a15, 4; ae_zeroq56	aeq0 }
    4496:	fd0464165f 	{ ae_sp16x2f.c	aep1, a6, a5; ae_movq56	aeq1, aeq0 }
    449b:	880c           	movi.n	a8, 8
    449d:	441404        	ae_lp16x2f.i	aep1, a4, 0
    44a0:	043d           	mov.n	a3, a4
    44a2:	0020f0        	nop
    44a5:	0c8876        	loop	a8, 44b5 <beam2_mid_band+0x1a5>
    44a8:	fc24daa65f 	{ ae_lp16x2f.c	aep2, a6, a5; nop }
    44ad:	051a54        	ae_mulasfp24s.hl.lh	aeq1, aep1, aep2
    44b0:	e2442d931f 	{ ae_lp16x2f.iu	aep1, a3, 4; ae_mulaafp24s.hh.ll	aeq0, aep1, aep2 }

000044b5 <beam2_mid_band+0x1a5>:
    44b5:	f96f80004f 	{ movi	a4, 0; ae_roundsp24q48asym	aep2, aeq1 }
    44ba:	f867c0018f 	{ movi	a8, 1; ae_roundsp24q48asym	aep1, aeq0 }
    44bf:	f002fe12bf 	{ ae_selp24.ll	aep2, aep1, aep2; ae_mulzaafp24s.hh.ll	aeq1, aep0, aep0 }
    44c4:	dc42edb71f 	{ ae_lp16x2f.iu	aep3, a7, 4; ae_subsp24s	aep1, aep0, aep2 }
    44c9:	079284        	ae_subsp24s	aep0, aep1, aep2
    44cc:	090184        	ae_roundsp16asym	aep0, aep0
    44cf:	048804        	ae_mulzaafp24s.hh.ll	aeq3, aep0, aep0
    44d2:	09b104        	ae_ltq56s	b0, aeq1, aeq3
    44d5:	d34800        	movt	a4, a8, b0
    44d8:	ecd416        	beqz	a4, 43a9 <beam2_mid_band+0x99>
    44db:	f86680018f 	{ movi	a8, 1; ae_movp48	aep0, aep1 }
    44e0:	ffb1c6        	j	43ab <beam2_mid_band+0x9b>

000044e3 <beam2_mid_band+0x1d3>:
    44e3:	9128           	l32i.n	a2, a1, 36
    44e5:	7178           	l32i.n	a7, a1, 28
    44e7:	e76c62        	s32i	a6, a12, 0x39c
    44ea:	f4a362        	movi	a6, 0x3f4
    44ed:	830c           	movi.n	a3, 8
    44ef:	463204        	ae_sp16x2f.i	aep3, a2, 0
    44f2:	450c64        	ae_lp16x2f.x	aep0, a12, a6
    44f5:	072d           	mov.n	a2, a7
    44f7:	048376        	loop	a3, 44ff <beam2_mid_band+0x1ef>
    44fa:	e3002d821f 	{ ae_lp16x2f.iu	aep0, a2, 4; ae_mulaafp24s.hh.ll	aeq2, aep0, aep0 }

000044ff <beam2_mid_band+0x1ef>:
    44ff:	81f8           	l32i.n	a15, a1, 32
    4501:	3520b4        	ae_sraiq56	aeq0, aeq2, 2
    4504:	f8638ffd2f 	{ movi	a2, -3; ae_roundsp16q48asym	aep0, aeq0 }
    4509:	a4a332        	movi	a3, 0x3a4
    450c:	430c34        	ae_sp16f.l.x	aep0, a12, a3
    450f:	02a2f7        	bge	a2, a15, 4515 <beam2_mid_band+0x205>
    4512:	002106        	j	459a <beam2_mid_band+0x28a>
    4515:	681c22        	l16ui	a2, a12, 208
    4518:	5158           	l32i.n	a5, a1, 20
    451a:	ed2c82        	l32i	a8, a12, 0x3b4
    451d:	079256        	bnez	a2, 459a <beam2_mid_band+0x28a>
    4520:	03dc22        	addmi	a2, a12, 0x300
    4523:	5c9232        	l16si	a3, a2, 184
    4526:	ed2c92        	l32i	a9, a12, 0x3b4
    4529:	51b8           	l32i.n	a11, a1, 20
    452b:	331b           	addi.n	a3, a3, 1
    452d:	834d           	ae_sext16	a4, a3
    452f:	5c5232        	s16i	a3, a2, 184
    4532:	5cc4a6        	blti	a4, 32, 4592 <beam2_mid_band+0x282>
    4535:	03dc62        	addmi	a6, a12, 0x300
    4538:	5d96d2        	l16si	a13, a6, 186
    453b:	bca372        	movi	a7, 0x3bc
    453e:	10c942        	addi	a4, a9, 16
    4541:	030c           	movi.n	a3, 0
    4543:	ac7a           	add.n	a10, a12, a7
    4545:	5c5232        	s16i	a3, a2, 184
    4548:	414540        	srli	a4, a4, 5
    454b:	902da0        	addx2	a2, a13, a10
    454e:	529b52        	l16si	a5, a11, 164
    4551:	624d           	ae_s16i.n	a4, a2, 0
    4553:	5d9622        	l16si	a2, a6, 186
    4556:	be0c           	movi.n	a14, 11
    4558:	cb0c           	movi.n	a11, 12
    455a:	221b           	addi.n	a2, a2, 1
    455c:	82fd           	ae_sext16	a15, a2
    455e:	724ef0        	salt	a4, a14, a15
    4561:	932340        	movnez	a2, a3, a4
    4564:	5d5622        	s16i	a2, a6, 186
    4567:	ef1521        	l32r	a2, 1bc (4c40 <take_min_four>)
    456a:	ed6c52        	s32i	a5, a12, 0x3b4
    456d:	f4a362        	movi	a6, 0x3f4
    4570:	0c4d           	mov.n	a4, a12
    4572:	0002e0        	callx8	a2
    4575:	eed621        	l32r	a2, d0 (6880 <immediate_num>)
    4578:	ea2432        	l32i	a3, a4, 0x3a8
    457b:	0abd           	mov.n	a11, a10
    457d:	20c2c2        	addi	a12, a2, 32
    4580:	eeea21        	l32r	a2, 128 (524 <siir_safr>)
    4583:	03ad           	mov.n	a10, a3
    4585:	0002e0        	callx8	a2
    4588:	7178           	l32i.n	a7, a1, 28
    458a:	04cd           	mov.n	a12, a4
    458c:	ea64a2        	s32i	a10, a4, 0x3a8
    458f:	0001c6        	j	459a <beam2_mid_band+0x28a>

00004592 <beam2_mid_band+0x282>:
    4592:	529522        	l16si	a2, a5, 164
    4595:	282a           	add.n	a2, a8, a2
    4597:	ed6c22        	s32i	a2, a12, 0x3b4
    459a:	ec2c22        	l32i	a2, a12, 0x3b0
    459d:	130c           	movi.n	a3, 1
    459f:	10d332        	addmi	a3, a3, 0x1000
    45a2:	5f2237        	blt	a2, a3, 4605 <beam2_mid_band+0x2f5>
    45a5:	5148           	l32i.n	a4, a1, 20
    45a7:	d23c           	movi.n	a2, 61
    45a9:	130c           	movi.n	a3, 1
    45ab:	529442        	l16si	a4, a4, 164
    45ae:	ea2c52        	l32i	a5, a12, 0x3a8
    45b1:	4ad222        	addmi	a2, a2, 0x4a00
    45b4:	113320        	slli	a3, a3, 14
    45b7:	364534        	ae_cvtq48a32s	aeq1, a5
    45ba:	300324        	ae_cvtp24a16x2.ll	aep0, a3, a2
    45bd:	11d410        	slli	a13, a4, 15
    45c0:	d5633ecd3f 	{ ae_cvtq48a32s	aeq0, a13; ae_mulfq32sp16s.h	aeq2, aeq1, aep0 }
    45c5:	d4e34000ef 	{ movi	a14, 0; ae_mulfq32sp16s.l	aeq1, aeq1, aep0 }
    45ca:	d6c00001ff 	{ movi	a15, 1; ae_ltq56s	b0, aeq2, aeq0 }
    45cf:	d64440002f 	{ movi	a2, 0; ae_ltq56s	b1, aeq1, aeq0 }
    45d4:	130c           	movi.n	a3, 1
    45d6:	d3ef00        	movt	a14, a15, b0
    45d9:	8eac           	beqz.n	a14, 4605 <beam2_mid_band+0x2f5>
    45db:	d32310        	movt	a2, a3, b1
    45de:	728c           	beqz.n	a2, 45e9 <beam2_mid_band+0x2d9>
    45e0:	03dc22        	addmi	a2, a12, 0x300
    45e3:	531222        	l16ui	a2, a2, 166
    45e6:	000146        	j	45ef <beam2_mid_band+0x2df>

000045e9 <beam2_mid_band+0x2d9>:
    45e9:	aea022        	movi	a2, 174
    45ec:	7fd222        	addmi	a2, a2, 0x7f00
    45ef:	0f1c           	movi.n	a15, 16
    45f1:	300224        	ae_cvtp24a16x2.ll	aep0, a2, a2
    45f4:	411c64        	ae_lp16f.x	aep1, a12, a6
    45f7:	0a8f76        	loop	a15, 4605 <beam2_mid_band+0x2f5>
    45fa:	ea21ac971f 	{ ae_lp16f.iu	aep1, a7, 2; ae_mulfp24s.ll	aeq0, aep0, aep1 }
    45ff:	1b8f24        	ae_roundsp16q48asym	aep2, aeq0
    4602:	4227f4        	ae_sp16f.l.i	aep2, a7, -2

00004605 <beam2_mid_band+0x2f5>:
    4605:	f01d           	retw.n

00004607 <beam2_mid_band+0x2f7>:
	...

00004608 <fill_vad_thrd_Nbands>:
    4608:	004136        	entry	a1, 32
    460b:	1a14a6        	blti	a4, 1, 4629 <fill_vad_thrd_Nbands+0x21>
    460e:	944d           	ae_zext16	a4, a4
    4610:	158476        	loop	a4, 4629 <fill_vad_thrd_Nbands+0x21>
    4613:	234d           	ae_l16si.n	a4, a3, 0
    4615:	332b           	addi.n	a3, a3, 2
    4617:	745840        	extui	a5, a4, 8, 8
    461a:	744040        	extui	a4, a4, 0, 8
    461d:	115590        	slli	a5, a5, 7
    4620:	114490        	slli	a4, a4, 7
    4623:	625d           	ae_s16i.n	a5, a2, 0
    4625:	724d           	ae_s16i.n	a4, a2, 2
    4627:	224b           	addi.n	a2, a2, 4

00004629 <fill_vad_thrd_Nbands+0x21>:
    4629:	f01d           	retw.n

0000462b <fill_vad_thrd_Nbands+0x23>:
	...

0000462c <fill_EQ_gain>:
    462c:	004136        	entry	a1, 32
    462f:	0a14a6        	blti	a4, 1, 463d <fill_EQ_gain+0x11>
    4632:	078476        	loop	a4, 463d <fill_EQ_gain+0x11>
    4635:	234d           	ae_l16si.n	a4, a3, 0
    4637:	624d           	ae_s16i.n	a4, a2, 0
    4639:	332b           	addi.n	a3, a3, 2
    463b:	222b           	addi.n	a2, a2, 2

0000463d <fill_EQ_gain+0x11>:
    463d:	f01d           	retw.n

0000463f <fill_EQ_gain+0x13>:
	...

00004640 <complement_para>:
    4640:	004136        	entry	a1, 32
    4643:	f47c           	movi.n	a4, -1
    4645:	114410        	slli	a4, a4, 15
    4648:	c0f430        	sub	a15, a4, a3
    464b:	623d           	ae_s16i.n	a3, a2, 0
    464d:	72fd           	ae_s16i.n	a15, a2, 2
    464f:	f01d           	retw.n

00004651 <complement_para+0x11>:
    4651:	000000                                        ...

00004654 <WB_NR_init>:
    4654:	004136        	entry	a1, 32
    4657:	ee9871        	l32r	a7, b8 (5d88 <xt_memset>)
    465a:	0b0c           	movi.n	a11, 0
    465c:	8ca0c2        	movi	a12, 140
    465f:	02ad           	mov.n	a10, a2
    4661:	0007e0        	callx8	a7
    4664:	ee6ff1        	l32r	a15, 20 (7318 <p_ecnr_mem>)
    4667:	f57c           	movi.n	a5, -1
    4669:	115510        	slli	a5, a5, 15
    466c:	022366        	bnei	a3, 2, 4672 <WB_NR_init+0x1e>
    466f:	002186        	j	46f9 <WB_NR_init+0xa5>
    4672:	13c356        	bnez	a3, 47b2 <WB_NR_init+0x15e>
    4675:	0f78           	l32i.n	a7, a15, 0
    4677:	2c94d2        	l16si	a13, a4, 88
    467a:	2d9492        	l16si	a9, a4, 90
    467d:	2294b2        	l16si	a11, a4, 68
    4680:	2494c2        	l16si	a12, a4, 72
    4683:	105292        	s16i	a9, a2, 32
    4686:	180c           	movi.n	a8, 1
    4688:	15d7a2        	addmi	a10, a7, 0x1500
    468b:	4e0c           	movi.n	a14, 4
    468d:	c095d0        	sub	a9, a5, a13
    4690:	305a82        	s16i	a8, a10, 96
    4693:	6d5292        	s16i	a9, a2, 218
    4696:	0252b2        	s16i	a11, a2, 4
    4699:	70c482        	addi	a8, a4, 112
    469c:	08c292        	addi	a9, a2, 8
    469f:	0352c2        	s16i	a12, a2, 6
    46a2:	6c52d2        	s16i	a13, a2, 216
    46a5:	158e76        	loop	a14, 46be <WB_NR_init+0x6a>
    46a8:	28ad           	ae_l16si.n	a10, a8, 0
    46aa:	882b           	addi.n	a8, a8, 2
    46ac:	74b8a0        	extui	a11, a10, 8, 8
    46af:	74a0a0        	extui	a10, a10, 0, 8
    46b2:	11bb90        	slli	a11, a11, 7
    46b5:	11aa90        	slli	a10, a10, 7
    46b8:	69bd           	ae_s16i.n	a11, a9, 0
    46ba:	79ad           	ae_s16i.n	a10, a9, 2
    46bc:	994b           	addi.n	a9, a9, 4

000046be <WB_NR_init+0x6a>:
    46be:	7b0c           	movi.n	a11, 7
    46c0:	dca092        	movi	a9, 220
    46c3:	24a7a2        	movi	a10, 0x724
    46c6:	eec081        	l32r	a8, 1c8 (6bd0 <win_ns>)
    46c9:	78dbb2        	addmi	a11, a11, 0x7800
    46cc:	fca0c2        	movi	a12, 252
    46cf:	cd3c           	movi.n	a13, 60
    46d1:	31d992        	addmi	a9, a9, 0x3100
    46d4:	f0aaa0        	subx8	a10, a10, a10
    46d7:	3d6282        	s32i	a8, a2, 244
    46da:	2fdc82        	addmi	a8, a12, 0x2f00
    46dd:	1752b2        	s16i	a11, a2, 46
    46e0:	34ddb2        	addmi	a11, a13, 0x3400
    46e3:	979a           	add.n	a9, a7, a9
    46e5:	a7aa           	add.n	a10, a7, a10
    46e7:	878a           	add.n	a8, a7, a8
    46e9:	e7ba           	add.n	a14, a7, a11
    46eb:	3e6292        	s32i	a9, a2, 248
    46ee:	3f62a2        	s32i	a10, a2, 252
    46f1:	406282        	s32i	a8, a2, 0x100
    46f4:	c2e9           	s32i.n	a14, a2, 48
    46f6:	002e06        	j	47b2 <WB_NR_init+0x15e>

000046f9 <WB_NR_init+0xa5>:
    46f9:	2c94b2        	l16si	a11, a4, 88
    46fc:	501492        	l16ui	a9, a4, 160
    46ff:	ba0c           	movi.n	a10, 11
    4701:	2d9482        	l16si	a8, a4, 90
    4704:	2494c2        	l16si	a12, a4, 72
    4707:	93a990        	movnez	a10, a9, a9
    470a:	c0e5b0        	sub	a14, a5, a11
    470d:	4d0c           	movi.n	a13, 4
    470f:	105282        	s16i	a8, a2, 32
    4712:	0352c2        	s16i	a12, a2, 6
    4715:	70c482        	addi	a8, a4, 112
    4718:	928b           	addi.n	a9, a2, 8
    471a:	0252a2        	s16i	a10, a2, 4
    471d:	6c52b2        	s16i	a11, a2, 216
    4720:	6d52e2        	s16i	a14, a2, 218
    4723:	158d76        	loop	a13, 473c <WB_NR_init+0xe8>
    4726:	28ad           	ae_l16si.n	a10, a8, 0
    4728:	882b           	addi.n	a8, a8, 2
    472a:	74b8a0        	extui	a11, a10, 8, 8
    472d:	74a0a0        	extui	a10, a10, 0, 8
    4730:	11bb90        	slli	a11, a11, 7
    4733:	11aa90        	slli	a10, a10, 7
    4736:	69bd           	ae_s16i.n	a11, a9, 0
    4738:	79ad           	ae_s16i.n	a10, a9, 2
    473a:	994b           	addi.n	a9, a9, 4

0000473c <WB_NR_init+0xe8>:
    473c:	0f98           	l32i.n	a9, a15, 0
    473e:	ca1c           	movi.n	a10, 28
    4740:	eea381        	l32r	a8, 1cc (6bf0 <win_512_v3_nc>)
    4743:	32daa2        	addmi	a10, a10, 0x3200
    4746:	71a1f2        	movi	a15, 0x171
    4749:	3d6282        	s32i	a8, a2, 244
    474c:	b9aa           	add.n	a11, a9, a10
    474e:	118fb0        	slli	a8, a15, 5
    4751:	a98a           	add.n	a10, a9, a8
    4753:	3e62b2        	s32i	a11, a2, 248
    4756:	0b0c           	movi.n	a11, 0
    4758:	eea0c2        	movi	a12, 238
    475b:	4262a2        	s32i	a10, a2, 0x108
    475e:	060c           	movi.n	a6, 0
    4760:	0007e0        	callx8	a7
    4763:	dca672        	movi	a7, 0x6dc
    4766:	ee2e81        	l32r	a8, 20 (7318 <p_ecnr_mem>)
    4769:	f07770        	subx8	a7, a7, a7
    476c:	175272        	s16i	a7, a2, 46
    476f:	422272        	l32i	a7, a2, 0x108
    4772:	0888           	l32i.n	a8, a8, 0
    4774:	e4a092        	movi	a9, 228
    4777:	34d992        	addmi	a9, a9, 0x3400
    477a:	24a3f2        	movi	a15, 0x324
    477d:	676d           	ae_s16i.n	a6, a7, 0
    477f:	ee2761        	l32r	a6, 1c (5d9c <xt_memcpy>)
    4782:	889a           	add.n	a8, a8, a9
    4784:	b4fa           	add.n	a11, a4, a15
    4786:	a72b           	addi.n	a10, a7, 2
    4788:	3c0c           	movi.n	a12, 3
    478a:	c289           	s32i.n	a8, a2, 48
    478c:	0006e0        	callx8	a6
    478f:	986c           	movi.n	a8, -23
    4791:	ee23f1        	l32r	a15, 20 (7318 <p_ecnr_mem>)
    4794:	ee8f61        	l32r	a6, 1d0 (ffe9ffe9 <_end+0xffe98ccd>)
    4797:	f48080        	extui	a8, a8, 0, 16
    479a:	44a1c2        	movi	a12, 0x144
    479d:	6d2c           	movi.n	a13, 38
    479f:	1e0c           	movi.n	a14, 1
    47a1:	085782        	s16i	a8, a7, 16
    47a4:	3769           	s32i.n	a6, a7, 12
    47a6:	77ca           	add.n	a7, a7, a12
    47a8:	018e20        	slli	a8, a14, 30
    47ab:	038d76        	loop	a13, 47b2 <WB_NR_init+0x15e>
    47ae:	0789           	s32i.n	a8, a7, 0
    47b0:	774b           	addi.n	a7, a7, 4

000047b2 <WB_NR_init+0x15e>:
    47b2:	2e0272        	l8ui	a7, a2, 46
    47b5:	c288           	l32i.n	a8, a2, 48
    47b7:	7a7c           	movi.n	a10, -9
    47b9:	57ac           	beqz.n	a7, 47e2 <WB_NR_init+0x18e>
    47bb:	7b1c           	movi.n	a11, 23
    47bd:	a0a062        	movi	a6, 160
    47c0:	090c           	movi.n	a9, 0
    47c2:	01aa50        	slli	a10, a10, 27
    47c5:	11bb50        	slli	a11, a11, 11
    47c8:	cc0c           	movi.n	a12, 12
    47ca:	d26a           	add.n	a13, a2, a6

000047cc <WB_NR_init+0x178>:
    47cc:	08ed           	mov.n	a14, a8
    47ce:	006da2        	s32i	a10, a13, 0
    47d1:	038c76        	loop	a12, 47d8 <WB_NR_init+0x184>
    47d4:	6ebd           	ae_s16i.n	a11, a14, 0
    47d6:	ee2b           	addi.n	a14, a14, 2

000047d8 <WB_NR_init+0x184>:
    47d8:	991b           	addi.n	a9, a9, 1
    47da:	18c882        	addi	a8, a8, 24
    47dd:	dd4b           	addi.n	a13, a13, 4
    47df:	e93977        	bltu	a9, a7, 47cc <WB_NR_init+0x178>

000047e2 <WB_NR_init+0x18e>:
    47e2:	2e9472        	l16si	a7, a4, 92
    47e5:	996c           	movi.n	a9, -23
    47e7:	625272        	s16i	a7, a2, 196
    47ea:	c07570        	sub	a7, a5, a7
    47ed:	0468           	l32i.n	a6, a4, 0
    47ef:	f49090        	extui	a9, a9, 0, 16
    47f2:	ffa7b2        	movi	a11, 0x7ff
    47f5:	635272        	s16i	a7, a2, 198
    47f8:	180c           	movi.n	a8, 1
    47fa:	6f5292        	s16i	a9, a2, 222
    47fd:	119bb0        	slli	a9, a11, 5
    4800:	2f94b2        	l16si	a11, a4, 94
    4803:	f7a1e2        	movi	a14, 0x1f7
    4806:	f7a3a2        	movi	a10, 0x3f7
    4809:	155282        	s16i	a8, a2, 42
    480c:	715292        	s16i	a9, a2, 226
    480f:	119ed0        	slli	a9, a14, 3
    4812:	118ae0        	slli	a8, a10, 2
    4815:	969a           	add.n	a9, a6, a9
    4817:	0269           	s32i.n	a6, a2, 0
    4819:	668a           	add.n	a6, a6, a8
    481b:	3c6262        	s32i	a6, a2, 240
    481e:	c065b0        	sub	a6, a5, a11
    4821:	6452b2        	s16i	a11, a2, 200
    4824:	655262        	s16i	a6, a2, 202
    4827:	309462        	l16si	a6, a4, 96
    482a:	665262        	s16i	a6, a2, 204
    482d:	ee52d1        	l32r	a13, 178 (7fff0000 <_end+0x7ffe8ce4>)
    4830:	c06560        	sub	a6, a5, a6
    4833:	675262        	s16i	a6, a2, 206
    4836:	319462        	l16si	a6, a4, 98
    4839:	685262        	s16i	a6, a2, 208
    483c:	00a1c2        	movi	a12, 0x100
    483f:	c06560        	sub	a6, a5, a6
    4842:	695262        	s16i	a6, a2, 210
    4845:	329462        	l16si	a6, a4, 100
    4848:	4362d2        	s32i	a13, a2, 0x10c
    484b:	4462d2        	s32i	a13, a2, 0x110
    484e:	0fd8           	l32i.n	a13, a15, 0
    4850:	1252c2        	s16i	a12, a2, 36
    4853:	5ba3c2        	movi	a12, 0x35b
    4856:	c0e560        	sub	a14, a5, a6
    4859:	117cd0        	slli	a7, a12, 3
    485c:	6a5262        	s16i	a6, a2, 212
    485f:	6b52e2        	s16i	a14, a2, 214
    4862:	7d7a           	add.n	a7, a13, a7
    4864:	809452        	l16si	a5, a4, 0x100
    4867:	7894f2        	l16si	a15, a4, 240
    486a:	3b6292        	s32i	a9, a2, 236
    486d:	3a6272        	s32i	a7, a2, 232
    4870:	8b5252        	s16i	a5, a2, 0x116
    4873:	8a52f2        	s16i	a15, a2, 0x114
    4876:	132326        	beqi	a3, 2, 488d <WB_NR_init+0x239>
    4879:	2f0242        	l8ui	a4, a2, 47
    487c:	402222        	l32i	a2, a2, 0x100
    487f:	130c           	movi.n	a3, 1
    4881:	848c           	beqz.n	a4, 488d <WB_NR_init+0x239>
    4883:	013320        	slli	a3, a3, 30
    4886:	038476        	loop	a4, 488d <WB_NR_init+0x239>
    4889:	0239           	s32i.n	a3, a2, 0
    488b:	224b           	addi.n	a2, a2, 4

0000488d <WB_NR_init+0x239>:
    488d:	f01d           	retw.n

0000488f <WB_NR_init+0x23b>:
	...

00004890 <NOISE_GEN_init>:
    4890:	004136        	entry	a1, 32
    4893:	ede321        	l32r	a2, 20 (7318 <p_ecnr_mem>)
    4896:	ede331        	l32r	a3, 24 (7310 <aec_nr_para>)
    4899:	bfa242        	movi	a4, 0x2bf
    489c:	0228           	l32i.n	a2, a2, 0
    489e:	1144c0        	slli	a4, a4, 4
    48a1:	03c8           	l32i.n	a12, a3, 0
    48a3:	a24a           	add.n	a10, a2, a4
    48a5:	ee4b21        	l32r	a2, 1d4 (4654 <WB_NR_init>)
    48a8:	0b0c           	movi.n	a11, 0
    48aa:	0002e0        	callx8	a2
    48ad:	f01d           	retw.n

000048af <NOISE_GEN_init+0x1f>:
	...

000048b0 <ns_ifft_wo>:
    48b0:	004136        	entry	a1, 32
    48b3:	250c           	movi.n	a5, 2
    48b5:	030480        	rsr.br	a8
    48b8:	0248           	l32i.n	a4, a2, 0
    48ba:	0a1580        	depbits	a8, a5, 0, 2
    48bd:	ee4671        	l32r	a7, 1d8 (6e10 <fftorder_512_12b>)
    48c0:	3a2252        	l32i	a5, a2, 232
    48c3:	060c           	movi.n	a6, 0
    48c5:	1469           	s32i.n	a6, a4, 4
    48c7:	0469           	s32i.n	a6, a4, 0
    48c9:	80a0f2        	movi	a15, 128
    48cc:	130480        	wsr.br	a8
    48cf:	04c762        	addi	a6, a7, 4
    48d2:	5c0504        	ae_lp24x2f.i	aep0, a5, 0
    48d5:	0e8f76        	loop	a15, 48e7 <ns_ifft_wo+0x37>
    48d8:	fc1860067e 	{ l16si	a7, a6, 0; ae_negsp24s	aep1, aep0 }
    48dd:	e0042f851f 	{ ae_lp24x2f.iu	aep0, a5, 8; ae_movtp24x2	aep1, aep0, b0:b1 }
    48e2:	664b           	addi.n	a6, a6, 4
    48e4:	5f1474        	ae_sp24x2f.x	aep1, a4, a7

000048e7 <ns_ifft_wo+0x37>:
    48e7:	7fa072        	movi	a7, 127
    48ea:	5c85e4        	ae_lp24x2f.iu	aep0, a5, -16
    48ed:	098776        	loop	a7, 48fa <ns_ifft_wo+0x4a>
    48f0:	267d           	ae_l16si.n	a7, a6, 0
    48f2:	664b           	addi.n	a6, a6, 4
    48f4:	5f0474        	ae_sp24x2f.x	aep0, a4, a7
    48f7:	5c85f4        	ae_lp24x2f.iu	aep0, a5, -8
    48fa:	ee3851        	l32r	a5, 1dc (5c94 <sw_fft_32b_2811>)
    48fd:	00a1b2        	movi	a11, 0x100
    4900:	8c0c           	movi.n	a12, 8
    4902:	0d0c           	movi.n	a13, 0
    4904:	1e0c           	movi.n	a14, 1
    4906:	04ad           	mov.n	a10, a4
    4908:	0005e0        	callx8	a5
    490b:	139262        	l16si	a6, a2, 38
    490e:	3f22e2        	l32i	a14, a2, 252
    4911:	3d2272        	l32i	a7, a2, 244
    4914:	c0fa60        	sub	a15, a10, a6
    4917:	fece22        	addi	a2, a14, -2
    491a:	091c           	movi.n	a9, 16
    491c:	fec352        	addi	a5, a3, -2
    491f:	fec762        	addi	a6, a7, -2
    4922:	600404        	ae_lq32f.i	aeq0, a4, 0
    4925:	20c772        	addi	a7, a7, 32
    4928:	f8cf32        	addi	a3, a15, -8
    492b:	028d           	mov.n	a8, a2
    492d:	1c8976        	loop	a9, 494d <ns_ifft_wo+0x9d>
    4930:	fc24fe830f 	{ ae_slaasq56s	aeq0, aeq0, a3; nop }
    4935:	fc446c881f 	{ ae_lp16f.iu	aep0, a8, 2; ae_roundsq32sym	aeq0, aeq0 }
    493a:	4097f4        	ae_lp16f.iu	aep1, a7, -2
    493d:	ea20ecf61f 	{ ae_lp16f.iu	aep7, a6, 2; ae_mulfp24s.hl	aeq1, aep0, aep1 }
    4942:	f49efd142f 	{ ae_lq32f.iu	aeq0, a4, 8; ae_mulafq32sp16s.l	aeq1, aeq0, aep7 }
    4947:	1b9e04        	ae_roundsp16q48sym	aep0, aeq1
    494a:	428514        	ae_sp16f.l.iu	aep0, a5, 2
    494d:	e0a062        	movi	a6, 224
    4950:	0f8676        	loop	a6, 4963 <ns_ifft_wo+0xb3>
    4953:	fc24fe834f 	{ ae_slaasq56s	aeq1, aeq0, a3; nop }
    4958:	fd4c7d142f 	{ ae_lq32f.iu	aeq0, a4, 8; ae_roundsq32sym	aeq1, aeq1 }
    495d:	1b9e04        	ae_roundsp16q48sym	aep0, aeq1
    4960:	428514        	ae_sp16f.l.iu	aep0, a5, 2
    4963:	051c           	movi.n	a5, 16
    4965:	0f8576        	loop	a5, 4978 <ns_ifft_wo+0xc8>
    4968:	fc24fe834f 	{ ae_slaasq56s	aeq1, aeq0, a3; nop }
    496d:	fd4c7d142f 	{ ae_lq32f.iu	aeq0, a4, 8; ae_roundsq32sym	aeq1, aeq1 }
    4972:	1b9e04        	ae_roundsp16q48sym	aep0, aeq1
    4975:	428214        	ae_sp16f.l.iu	aep0, a2, 2
    4978:	f01d           	retw.n

0000497a <ns_ifft_wo+0xca>:
	...

0000497c <NOISE_GEN_Prcs>:
    497c:	004136        	entry	a1, 32
    497f:	eda841        	l32r	a4, 20 (7318 <p_ecnr_mem>)
    4982:	fc2080786f 	{ movi	a6, 120; ae_zerop48	aep0 }
    4987:	441204        	ae_lp16x2f.i	aep1, a2, 0
    498a:	0458           	l32i.n	a5, a4, 0
    498c:	024d           	mov.n	a4, a2
    498e:	048676        	loop	a6, 4996 <NOISE_GEN_Prcs+0x1a>
    4991:	d821ad941f 	{ ae_lp16x2f.iu	aep1, a4, 4; ae_maxabssp24s	aep0, aep0, aep1 }

00004996 <NOISE_GEN_Prcs+0x1a>:
    4996:	dc01c2bf4f 	{ movi	a4, 0x2bf; ae_selp24.lh	aep1, aep0, aep0 }
    499b:	d8220404bf 	{ movi	a11, 0x404; ae_maxp24s	aep0, aep0, aep1 }
    49a0:	2bd562        	addmi	a6, a5, 0x2b00
    49a3:	000cd4        	ae_cvta32p24.l	a12, aep0
    49a6:	8a9672        	l16si	a7, a6, 0x114
    49a9:	7a26d2        	l32i	a13, a6, 0x1e8
    49ac:	40ecc0        	nsa	a12, a12
    49af:	ee0aa1        	l32r	a10, 1d8 (6e10 <fftorder_512_12b>)
    49b2:	437c70        	min	a7, a12, a7
    49b5:	3c26f2        	l32i	a15, a6, 240
    49b8:	792692        	l32i	a9, a6, 0x1e4
    49bb:	8a56c2        	s16i	a12, a6, 0x114
    49be:	031674        	wur.ae_sar	a7
    49c1:	1144c0        	slli	a4, a4, 4
    49c4:	447d04        	ae_lp16x2f.i	aep7, a13, 0
    49c7:	8e0c           	movi.n	a14, 8
    49c9:	00a082        	movi	a8, 0
    49cc:	804540        	add	a4, a5, a4
    49cf:	08caa2        	addi	a10, a10, 8
    49d2:	80bfb0        	add	a11, a15, a11
    49d5:	04dfc2        	addmi	a12, a15, 0x400
    49d8:	f83fad190f 	{ ae_lp16x2f.i	aep1, a9, 0; ae_sllssp24s	aep0, aep7 }
    49dd:	158e76        	loop	a14, 49f6 <NOISE_GEN_Prcs+0x7a>
    49e0:	e820adfd1f 	{ ae_lp16x2f.iu	aep7, a13, 4; ae_mulfp24s.hh	aeq0, aep0, aep1 }
    49e5:	eb21ed991f 	{ ae_lp16x2f.iu	aep1, a9, 4; ae_mulfp24s.ll	aeq3, aep0, aep1 }
    49ea:	f83fb84c8f 	{ ae_sq32f.x	aeq0, a12, a8; ae_sllssp24s	aep0, aep7 }
    49ef:	62bb84        	ae_sq32f.x	aeq3, a11, a8
    49f2:	2a8d           	ae_l16si.n	a8, a10, 0
    49f4:	aa8b           	addi.n	a10, a10, 8
    49f6:	70a0d2        	movi	a13, 112
    49f9:	440204        	ae_lp16x2f.i	aep0, a2, 0
    49fc:	f03d           	nop.n
    49fe:	138d76        	loop	a13, 4a15 <NOISE_GEN_Prcs+0x99>
    4a01:	f823ed821f 	{ ae_lp16x2f.iu	aep0, a2, 4; ae_sllssp24s	aep1, aep0 }
    4a06:	0a0984        	ae_cvtq48p24s.h	aeq0, aep1
    4a09:	fd2c384c8f 	{ ae_sq32f.x	aeq0, a12, a8; ae_cvtq48p24s.l	aeq1, aep1 }
    4a0e:	629b84        	ae_sq32f.x	aeq1, a11, a8
    4a11:	2a8d           	ae_l16si.n	a8, a10, 0
    4a13:	aa8b           	addi.n	a10, a10, 8
    4a15:	3e24d2        	l32i	a13, a4, 248
    4a18:	8e0c           	movi.n	a14, 8
    4a1a:	fccdd2        	addi	a13, a13, -4
    4a1d:	188e76        	loop	a14, 4a39 <NOISE_GEN_Prcs+0xbd>
    4a20:	f823eda9ff 	{ ae_lp16x2f.iu	aep2, a9, -4; ae_sllssp24s	aep1, aep0 }
    4a25:	ea44b38d1f 	{ ae_sp16x2f.iu	aep0, a13, 4; ae_mulfp24s.hl	aeq0, aep1, aep2 }
    4a2a:	e945ed821f 	{ ae_lp16x2f.iu	aep0, a2, 4; ae_mulfp24s.lh	aeq3, aep1, aep2 }
    4a2f:	628c84        	ae_sq32f.x	aeq0, a12, a8
    4a32:	62bb84        	ae_sq32f.x	aeq3, a11, a8
    4a35:	2a8d           	ae_l16si.n	a8, a10, 0
    4a37:	aa8b           	addi.n	a10, a10, 8
    4a39:	3c2622        	l32i	a2, a6, 240
    4a3c:	80a0b2        	movi	a11, 128
    4a3f:	8c0c           	movi.n	a12, 8
    4a41:	04d2a2        	addmi	a10, a2, 0x400
    4a44:	ede621        	l32r	a2, 1dc (5c94 <sw_fft_32b_2811>)
    4a47:	1d0c           	movi.n	a13, 1
    4a49:	0e0c           	movi.n	a14, 0
    4a4b:	0002e0        	callx8	a2
    4a4e:	c0f7a0        	sub	a15, a7, a10
    4a51:	2cd522        	addmi	a2, a5, 0x2c00
    4a54:	0b52f2        	s16i	a15, a2, 22
    4a57:	ede221        	l32r	a2, 1e0 (4cd0 <gen_power>)
    4a5a:	00a1b2        	movi	a11, 0x100
    4a5d:	04ad           	mov.n	a10, a4
    4a5f:	0002e0        	callx8	a2
    4a62:	ede021        	l32r	a2, 1e4 (4e6c <NR_vad1>)
    4a65:	04ad           	mov.n	a10, a4
    4a67:	0002e0        	callx8	a2
    4a6a:	eddf21        	l32r	a2, 1e8 (4f88 <NR_vad2>)
    4a6d:	04ad           	mov.n	a10, a4
    4a6f:	0002e0        	callx8	a2
    4a72:	edde21        	l32r	a2, 1ec (5100 <NR_NoiseEstimate>)
    4a75:	04ad           	mov.n	a10, a4
    4a77:	0002e0        	callx8	a2
    4a7a:	eddd21        	l32r	a2, 1f0 (3d0 <comfort_noise_gen_wb2>)
    4a7d:	04ad           	mov.n	a10, a4
    4a7f:	0002e0        	callx8	a2
    4a82:	eddc21        	l32r	a2, 1f4 (48b0 <ns_ifft_wo>)
    4a85:	04ad           	mov.n	a10, a4
    4a87:	03bd           	mov.n	a11, a3
    4a89:	0002e0        	callx8	a2
    4a8c:	f01d           	retw.n

00004a8e <NOISE_GEN_Prcs+0x112>:
	...

00004a90 <NC_NOISE_EST_init>:
    4a90:	004136        	entry	a1, 32
    4a93:	ed6331        	l32r	a3, 20 (7318 <p_ecnr_mem>)
    4a96:	a1a542        	movi	a4, 0x5a1
    4a99:	1144d0        	slli	a4, a4, 3
    4a9c:	0338           	l32i.n	a3, a3, 0
    4a9e:	2b0c           	movi.n	a11, 2
    4aa0:	02cd           	mov.n	a12, a2
    4aa2:	a34a           	add.n	a10, a3, a4
    4aa4:	edcc31        	l32r	a3, 1d4 (4654 <WB_NR_init>)
    4aa7:	0003e0        	callx8	a3
    4aaa:	f01d           	retw.n

00004aac <NC_NOISE_EST_Prcs>:
    4aac:	006136        	entry	a1, 48
    4aaf:	a1a542        	movi	a4, 0x5a1
    4ab2:	1144d0        	slli	a4, a4, 3
    4ab5:	424a           	add.n	a4, a2, a4
    4ab7:	edd051        	l32r	a5, 1f8 (4d18 <fft_wo>)
    4aba:	04ad           	mov.n	a10, a4
    4abc:	03bd           	mov.n	a11, a3
    4abe:	0005e0        	callx8	a5
    4ac1:	edc831        	l32r	a3, 1e4 (4e6c <NR_vad1>)
    4ac4:	04ad           	mov.n	a10, a4
    4ac6:	0003e0        	callx8	a3
    4ac9:	edc731        	l32r	a3, 1e8 (4f88 <NR_vad2>)
    4acc:	04ad           	mov.n	a10, a4
    4ace:	0003e0        	callx8	a3
    4ad1:	2dd232        	addmi	a3, a2, 0x2d00
    4ad4:	3e2332        	l32i	a3, a3, 248
    4ad7:	2ed242        	addmi	a4, a2, 0x2e00
    4ada:	4458           	l32i.n	a5, a4, 16
    4adc:	0368           	l32i.n	a6, a3, 0
    4ade:	0d0c           	movi.n	a13, 0
    4ae0:	1116e6        	bgei	a6, 1, 4af5 <NC_NOISE_EST_Prcs+0x49>
    4ae3:	1348           	l32i.n	a4, a3, 4
    4ae5:	0c14e6        	bgei	a4, 1, 4af5 <NC_NOISE_EST_Prcs+0x49>
    4ae8:	2348           	l32i.n	a4, a3, 8
    4aea:	0714e6        	bgei	a4, 1, 4af5 <NC_NOISE_EST_Prcs+0x49>
    4aed:	3338           	l32i.n	a3, a3, 12
    4aef:	0213e6        	bgei	a3, 1, 4af5 <NC_NOISE_EST_Prcs+0x49>
    4af2:	0051c6        	j	4c3d <NC_NOISE_EST_Prcs+0x191>

00004af5 <NC_NOISE_EST_Prcs+0x49>:
    4af5:	1d0c           	movi.n	a13, 1
    4af7:	090532        	l8ui	a3, a5, 9
    4afa:	66a672        	movi	a7, 0x666
    4afd:	10f316        	beqz	a3, 4c10 <NC_NOISE_EST_Prcs+0x164>
    4b00:	070c           	movi.n	a7, 0
    4b02:	0895c2        	l16si	a12, a5, 16
    4b05:	061582        	l16ui	a8, a5, 12
    4b08:	aca062        	movi	a6, 172
    4b0b:	44a1e2        	movi	a14, 0x144
    4b0e:	9cad           	ae_zext16	a10, a12
    4b10:	456a           	add.n	a4, a5, a6
    4b12:	35ea           	add.n	a3, a5, a14
    4b14:	1d1a87        	beq	a10, a8, 4b35 <NC_NOISE_EST_Prcs+0x89>
    4b17:	0d6d           	mov.n	a6, a13
    4b19:	88dd           	ae_sext16	a13, a8
    4b1b:	edb881        	l32r	a8, 1fc (4ca8 <equal_power>)
    4b1e:	6e2c           	movi.n	a14, 38
    4b20:	04ad           	mov.n	a10, a4
    4b22:	03bd           	mov.n	a11, a3
    4b24:	0008e0        	callx8	a8
    4b27:	06dd           	mov.n	a13, a6
    4b29:	44a1e2        	movi	a14, 0x144
    4b2c:	aca062        	movi	a6, 172
    4b2f:	0655a2        	s16i	a10, a5, 12
    4b32:	0855a2        	s16i	a10, a5, 16
    4b35:	fc2480019f 	{ movi	a9, 1; ae_zeroq56	aeq0 }
    4b3a:	119910        	slli	a9, a9, 15
    4b3d:	fd0455c97f 	{ sub	a12, a9, a7; ae_movq56	aeq1, aeq0 }
    4b42:	6b2c           	movi.n	a11, 38
    4b44:	40a1f2        	movi	a15, 0x140
    4b47:	60a564        	ae_lq32f.x	aeq2, a5, a6
    4b4a:	2dd282        	addmi	a8, a2, 0x2d00
    4b4d:	3007c4        	ae_cvtp24a16x2.ll	aep0, a7, a12
    4b50:	65fa           	add.n	a6, a5, a15
    4b52:	188b76        	loop	a11, 4b6e <NC_NOISE_EST_Prcs+0xc2>
    4b55:	60d614        	ae_lq32f.iu	aeq3, a6, 4
    4b58:	b78c           	beqz.n	a7, 4b67 <NC_NOISE_EST_Prcs+0xbb>
    4b5a:	0f037d541f 	{ ae_lq32f.iu	aeq2, a4, 4; ae_mulzaafq32sp16s.lh	aeq3, aeq3, aep0, aeq2, aep0 }
    4b5f:	f97f39b60f 	{ ae_sq32f.i	aeq3, a6, 0; ae_maxq56s	aeq1, aeq1, aeq3 }
    4b64:	000106        	j	4b6c <NC_NOISE_EST_Prcs+0xc0>

00004b67 <NC_NOISE_EST_Prcs+0xbb>:
    4b67:	f97f3d541f 	{ ae_lq32f.iu	aeq2, a4, 4; ae_maxq56s	aeq1, aeq1, aeq3 }
    4b6c:	f03d           	nop.n

00004b6e <NC_NOISE_EST_Prcs+0xc2>:
    4b6e:	365404        	ae_nsaq56s	a4, aeq1
    4b71:	960c           	movi.n	a6, 9
    4b73:	44a192        	movi	a9, 0x144
    4b76:	1b2467        	blt	a4, a6, 4b95 <NC_NOISE_EST_Prcs+0xe9>
    4b79:	f8c442        	addi	a4, a4, -8
    4b7c:	c0aa40        	sub	a10, a10, a4
    4b7f:	672c           	movi.n	a7, 38
    4b81:	401400        	ssl	a4
    4b84:	459a           	add.n	a4, a5, a9
    4b86:	0655a2        	s16i	a10, a5, 12
    4b89:	088776        	loop	a7, 4b95 <NC_NOISE_EST_Prcs+0xe9>
    4b8c:	0468           	l32i.n	a6, a4, 0
    4b8e:	a16600        	sll	a6, a6
    4b91:	0469           	s32i.n	a6, a4, 0
    4b93:	444b           	addi.n	a4, a4, 4

00004b95 <NC_NOISE_EST_Prcs+0xe9>:
    4b95:	2868           	l32i.n	a6, a8, 8
    4b97:	672c           	movi.n	a7, 38
    4b99:	054d           	mov.n	a4, a5
    4b9b:	66cb           	addi.n	a6, a6, 12
    4b9d:	0c8776        	loop	a7, 4bad <NC_NOISE_EST_Prcs+0x101>
    4ba0:	5478           	l32i.n	a7, a4, 20
    4ba2:	2b6472        	s32i	a7, a4, 172
    4ba5:	0678           	l32i.n	a7, a6, 0
    4ba7:	5479           	s32i.n	a7, a4, 20
    4ba9:	664b           	addi.n	a6, a6, 4
    4bab:	444b           	addi.n	a4, a4, 4

00004bad <NC_NOISE_EST_Prcs+0x101>:
    4bad:	2dd272        	addmi	a7, a2, 0x2d00
    4bb0:	352d           	ae_l16si.n	a2, a5, 2
    4bb2:	080542        	l8ui	a4, a5, 8
    4bb5:	079562        	l16si	a6, a5, 14
    4bb8:	7297f2        	l16si	a15, a7, 228
    4bbb:	0845d2        	s8i	a13, a5, 8
    4bbe:	085562        	s16i	a6, a5, 16
    4bc1:	094542        	s8i	a4, a5, 9
    4bc4:	0755f2        	s16i	a15, a5, 14
    4bc7:	05d216        	beqz	a2, 4c28 <NC_NOISE_EST_Prcs+0x17c>
    4bca:	8a4d           	ae_sext16	a4, a10
    4bcc:	860c           	movi.n	a6, 8
    4bce:	c04640        	sub	a4, a6, a4
    4bd1:	ff1c           	movi.n	a15, 31
    4bd3:	4344f0        	min	a4, a4, a15
    4bd6:	6065e4        	ae_lq32f.x	aeq1, a5, a14
    4bd9:	662c           	movi.n	a6, 38
    4bdb:	04b496        	bltz	a4, 4c2a <NC_NOISE_EST_Prcs+0x17e>
    4bde:	078676        	loop	a6, 4be9 <NC_NOISE_EST_Prcs+0x13d>
    4be1:	3454b4        	ae_sraaq56	aeq1, aeq1, a4
    4be4:	f8667d331f 	{ ae_lq32f.iu	aeq1, a3, 4; ae_addsq56s	aeq0, aeq0, aeq1 }

00004be9 <NC_NOISE_EST_Prcs+0x13d>:
    4be9:	ed8531        	l32r	a3, 200 (35e51 <_end+0x2eb35>)
    4bec:	398334        	ae_movpa24x2	aep0, a3, a3
    4bef:	f88020053e 	{ l16si	a3, a5, 0; ae_mulfq32sp24s.l	aeq0, aeq0, aep0 }
    4bf4:	039562        	l16si	a6, a5, 6
    4bf7:	fc4460257e 	{ l16si	a7, a5, 4; ae_roundsq32sym	aeq0, aeq0 }
    4bfc:	620134        	ae_sq32f.i	aeq0, a1, 12
    4bff:	3148           	l32i.n	a4, a1, 12
    4c01:	214840        	srai	a4, a4, 8
    4c04:	14a427        	bge	a4, a2, 4c1c <NC_NOISE_EST_Prcs+0x170>
    4c07:	273a           	add.n	a2, a7, a3
    4c09:	000486        	j	4c1f <NC_NOISE_EST_Prcs+0x173>

00004c0c <NC_NOISE_EST_Prcs+0x160>:
    4c0c:	00000000                                ....

00004c10 <NC_NOISE_EST_Prcs+0x164>:
    4c10:	eecd56        	bnez	a13, 4b00 <NC_NOISE_EST_Prcs+0x54>
    4c13:	080532        	l8ui	a3, a5, 8
    4c16:	ee8316        	beqz	a3, 4b02 <NC_NOISE_EST_Prcs+0x56>
    4c19:	ffb8c6        	j	4b00 <NC_NOISE_EST_Prcs+0x54>

00004c1c <NC_NOISE_EST_Prcs+0x170>:
    4c1c:	c02360        	sub	a2, a3, a6
    4c1f:	a22d           	ae_clamps16	a2, a2
    4c21:	030c           	movi.n	a3, 0
    4c23:	532230        	max	a2, a2, a3
    4c26:	652d           	ae_s16i.n	a2, a5, 0
    4c28:	f01d           	retw.n

00004c2a <NC_NOISE_EST_Prcs+0x17e>:
    4c2a:	604040        	neg	a4, a4
    4c2d:	098676        	loop	a6, 4c3a <NC_NOISE_EST_Prcs+0x18e>
    4c30:	fc24fe944f 	{ ae_slaasq56s	aeq1, aeq1, a4; nop }
    4c35:	f8667d331f 	{ ae_lq32f.iu	aeq1, a3, 4; ae_addsq56s	aeq0, aeq0, aeq1 }

00004c3a <NC_NOISE_EST_Prcs+0x18e>:
    4c3a:	ffeac6        	j	4be9 <NC_NOISE_EST_Prcs+0x13d>

00004c3d <NC_NOISE_EST_Prcs+0x191>:
    4c3d:	ffad86        	j	4af7 <NC_NOISE_EST_Prcs+0x4b>

00004c40 <take_min_four>:
    4c40:	004136        	entry	a1, 32
    4c43:	224d           	ae_l16si.n	a4, a2, 0
    4c45:	5023a6        	blti	a3, 2, 4c99 <take_min_four+0x59>
    4c48:	ffa052        	movi	a5, 255
    4c4b:	7fd552        	addmi	a5, a5, 0x7f00
    4c4e:	630b           	addi.n	a6, a3, -1
    4c50:	222b           	addi.n	a2, a2, 2
    4c52:	048d           	mov.n	a8, a4
    4c54:	053d           	mov.n	a3, a5
    4c56:	207550        	or	a7, a5, a5
    4c59:	318676        	loop	a6, 4c8e <take_min_four+0x4e>
    4c5c:	22ad           	ae_l16si.n	a10, a2, 0
    4c5e:	086d           	mov.n	a6, a8
    4c60:	079d           	mov.n	a9, a7
    4c62:	0a4d           	mov.n	a4, a10
    4c64:	1c2a87        	blt	a10, a8, 4c84 <take_min_four+0x44>
    4c67:	084d           	mov.n	a4, a8
    4c69:	0a6d           	mov.n	a6, a10
    4c6b:	079d           	mov.n	a9, a7
    4c6d:	132a77        	blt	a10, a7, 4c84 <take_min_four+0x44>
    4c70:	084d           	mov.n	a4, a8
    4c72:	076d           	mov.n	a6, a7
    4c74:	0a9d           	mov.n	a9, a10
    4c76:	0a2a37        	blt	a10, a3, 4c84 <take_min_four+0x44>
    4c79:	4355a0        	min	a5, a5, a10
    4c7c:	039d           	mov.n	a9, a3
    4c7e:	084d           	mov.n	a4, a8
    4c80:	076d           	mov.n	a6, a7
    4c82:	053d           	mov.n	a3, a5

00004c84 <take_min_four+0x44>:
    4c84:	035d           	mov.n	a5, a3
    4c86:	222b           	addi.n	a2, a2, 2
    4c88:	093d           	mov.n	a3, a9
    4c8a:	067d           	mov.n	a7, a6
    4c8c:	048d           	mov.n	a8, a4

00004c8e <take_min_four+0x4e>:
    4c8e:	249a           	add.n	a2, a4, a9
    4c90:	365a           	add.n	a3, a6, a5
    4c92:	223a           	add.n	a2, a2, a3
    4c94:	112220        	slli	a2, a2, 14
    4c97:	f01d           	retw.n

00004c99 <take_min_four+0x59>:
    4c99:	ffa062        	movi	a6, 255
    4c9c:	7fd662        	addmi	a6, a6, 0x7f00
    4c9f:	069d           	mov.n	a9, a6
    4ca1:	065d           	mov.n	a5, a6
    4ca3:	fff9c6        	j	4c8e <take_min_four+0x4e>

00004ca6 <take_min_four+0x66>:
	...

00004ca8 <equal_power>:
    4ca8:	004136        	entry	a1, 32
    4cab:	c07450        	sub	a7, a4, a5
    4cae:	a34570        	movltz	a4, a5, a7
    4cb1:	1416a6        	blti	a6, 1, 4cc9 <equal_power+0x21>
    4cb4:	a33270        	movltz	a3, a2, a7
    4cb7:	605170        	abs	a5, a7
    4cba:	fcc322        	addi	a2, a3, -4
    4cbd:	088676        	loop	a6, 4cc9 <equal_power+0x21>
    4cc0:	601214        	ae_lq32f.iu	aeq0, a2, 4
    4cc3:	3405a4        	ae_srlaq56	aeq0, aeq0, a5
    4cc6:	620204        	ae_sq32f.i	aeq0, a2, 0

00004cc9 <equal_power+0x21>:
    4cc9:	042d           	mov.n	a2, a4
    4ccb:	f01d           	retw.n

00004ccd <equal_power+0x25>:
    4ccd:	000000                                        ...

00004cd0 <gen_power>:
    4cd0:	004136        	entry	a1, 32
    4cd3:	002252        	l32i	a5, a2, 0
    4cd6:	3a2242        	l32i	a4, a2, 232
    4cd9:	1123a6        	blti	a3, 2, 4cee <gen_power+0x1e>
    4cdc:	217130        	srai	a7, a3, 1
    4cdf:	f8c432        	addi	a3, a4, -8
    4ce2:	206550        	or	a6, a5, a5
    4ce5:	058776        	loop	a7, 4cee <gen_power+0x1e>
    4ce8:	5c8614        	ae_lp24x2f.iu	aep0, a6, 8
    4ceb:	5e8314        	ae_sp24x2f.iu	aep0, a3, 8

00004cee <gen_power+0x1e>:
    4cee:	139232        	l16si	a3, a2, 38
    4cf1:	2f0272        	l8ui	a7, a2, 47
    4cf4:	160c           	movi.n	a6, 1
    4cf6:	1133f0        	slli	a3, a3, 1
    4cf9:	c06630        	sub	a6, a6, a3
    4cfc:	f73b           	addi.n	a15, a7, 3
    4cfe:	fcc532        	addi	a3, a5, -4
    4d01:	5c0404        	ae_lp24x2f.i	aep0, a4, 0
    4d04:	6e5262        	s16i	a6, a2, 220
    4d07:	0a8f76        	loop	a15, 4d15 <gen_power+0x45>
    4d0a:	f003af841f 	{ ae_lp24x2f.iu	aep0, a4, 8; ae_mulzaap24s.hh.ll	aeq0, aep0, aep0 }
    4d0f:	060834        	ae_roundsq32sym	aeq0, aeq0
    4d12:	624314        	ae_sq32f.iu	aeq0, a3, 4

00004d15 <gen_power+0x45>:
    4d15:	f01d           	retw.n

00004d17 <gen_power+0x47>:
	...

00004d18 <fft_wo>:
    4d18:	006136        	entry	a1, 48
    4d1b:	2e0242        	l8ui	a4, a2, 46
    4d1e:	750c           	movi.n	a5, 7
    4d20:	160c           	movi.n	a6, 1
    4d22:	625540        	saltu	a5, a5, a4
    4d25:	fcc442        	addi	a4, a4, -4
    4d28:	624460        	saltu	a4, a4, a6
    4d2b:	205540        	or	a5, a5, a4
    4d2e:	f0a0c2        	movi	a12, 240
    4d31:	15cc           	bnez.n	a5, 4d36 <fft_wo+0x1e>
    4d33:	78a0c2        	movi	a12, 120

00004d36 <fft_wo+0x1e>:
    4d36:	270c           	movi.n	a7, 2
    4d38:	05cc           	bnez.n	a5, 4d3c <fft_wo+0x24>
    4d3a:	470c           	movi.n	a7, 4
    4d3c:	060c           	movi.n	a6, 0
    4d3e:	204330        	or	a4, a3, a3
    4d41:	098c76        	loop	a12, 4d4e <fft_wo+0x36>
    4d44:	248d           	ae_l16si.n	a8, a4, 0
    4d46:	442b           	addi.n	a4, a4, 2
    4d48:	608180        	abs	a8, a8
    4d4b:	206860        	or	a6, a8, a6

00004d4e <fft_wo+0x36>:
    4d4e:	00a2f2        	movi	a15, 0x200
    4d51:	15cc           	bnez.n	a5, 4d56 <fft_wo+0x3e>
    4d53:	00a1f2        	movi	a15, 0x100

00004d56 <fft_wo+0x3e>:
    4d56:	ed2041        	l32r	a4, 1d8 (6e10 <fftorder_512_12b>)
    4d59:	35cc           	bnez.n	a5, 4d60 <fft_wo+0x48>
    4d5b:	548b           	addi.n	a5, a4, 8
    4d5d:	000046        	j	4d62 <fft_wo+0x4a>

00004d60 <fft_wo+0x48>:
    4d60:	544b           	addi.n	a5, a4, 4
    4d62:	40e640        	nsa	a4, a6
    4d65:	1292a2        	l16si	a10, a2, 36
    4d68:	060c           	movi.n	a6, 0
    4d6a:	f0c442        	addi	a4, a4, -16
    4d6d:	3e22e2        	l32i	a14, a2, 248
    4d70:	534460        	max	a4, a4, a6
    4d73:	02b8           	l32i.n	a11, a2, 0
    4d75:	3d2282        	l32i	a8, a2, 244
    4d78:	1149           	s32i.n	a4, a1, 4
    4d7a:	4344a0        	min	a4, a4, a10
    4d7d:	031644        	wur.ae_sar	a4
    4d80:	440e04        	ae_lp16x2f.i	aep0, a14, 0
    4d83:	a0afb0        	addx4	a10, a15, a11
    4d86:	41d2f0        	srli	a13, a15, 2
    4d89:	1197f0        	slli	a9, a7, 1
    4d8c:	2149           	s32i.n	a4, a1, 8
    4d8e:	31f9           	s32i.n	a15, a1, 12
    4d90:	f823ad180f 	{ ae_lp16x2f.i	aep1, a8, 0; ae_sllssp24s	aep0, aep0 }
    4d95:	ba4b           	addi.n	a11, a10, 4
    4d97:	158d76        	loop	a13, 4db0 <fft_wo+0x98>
    4d9a:	e820adfe1f 	{ ae_lp16x2f.iu	aep7, a14, 4; ae_mulfp24s.hh	aeq0, aep0, aep1 }
    4d9f:	eb21ed981f 	{ ae_lp16x2f.iu	aep1, a8, 4; ae_mulfp24s.ll	aeq3, aep0, aep1 }
    4da4:	f83fb84a6f 	{ ae_sq32f.x	aeq0, a10, a6; ae_sllssp24s	aep0, aep7 }
    4da9:	62bb64        	ae_sq32f.x	aeq3, a11, a6
    4dac:	256d           	ae_l16si.n	a6, a5, 0
    4dae:	559a           	add.n	a5, a5, a9

00004db0 <fft_wo+0x98>:
    4db0:	fc24b3e27e 	{ l32i	a7, a2, 248; ae_zeroq56	aeq0 }
    4db5:	41f1c0        	srli	a15, a12, 1
    4db8:	f842154dff 	{ sub	a4, a13, a15; ae_truncp24q48x2	aep0, aeq0, aeq0 }
    4dbd:	fcc7e2        	addi	a14, a7, -4
    4dc0:	0214e6        	bgei	a4, 1, 4dc6 <fft_wo+0xae>
    4dc3:	002706        	j	4e63 <fft_wo+0x14b>
    4dc6:	90cc70        	addx2	a12, a12, a7
    4dc9:	442c04        	ae_lp16x2f.i	aep2, a12, 0
    4dcc:	f03d           	nop.n
    4dce:	098476        	loop	a4, 4ddb <fft_wo+0xc3>
    4dd1:	fc4873ae1f 	{ ae_sp16x2f.iu	aep2, a14, 4; ae_abssp24s	aep1, aep2 }
    4dd6:	dc202dac1f 	{ ae_lp16x2f.iu	aep2, a12, 4; ae_orp48	aep0, aep0, aep1 }
    4ddb:	c04df0        	sub	a4, a13, a15
    4dde:	4498f4        	ae_lp16x2f.iu	aep1, a8, -4
    4de1:	f03d           	nop.n
    4de3:	f03d           	nop.n
    4de5:	1d8476        	loop	a4, 4e06 <fft_wo+0xee>
    4de8:	f92bf3ae1f 	{ ae_sp16x2f.iu	aep2, a14, 4; ae_sllssp24s	aep3, aep2 }
    4ded:	013154        	ae_mulfp24s.hl	aeq0, aep3, aep1
    4df0:	e92ded98ff 	{ ae_lp16x2f.iu	aep1, a8, -4; ae_mulfp24s.lh	aeq3, aep3, aep1 }
    4df5:	fe48384a6f 	{ ae_sq32f.x	aeq0, a10, a6; ae_abssp24s	aep4, aep2 }
    4dfa:	dc80387b6f 	{ ae_sq32f.x	aeq3, a11, a6; ae_orp48	aep0, aep0, aep4 }
    4dff:	256d           	ae_l16si.n	a6, a5, 0
    4e01:	44ac14        	ae_lp16x2f.iu	aep2, a12, 4
    4e04:	559a           	add.n	a5, a5, a9

00004e06 <fft_wo+0xee>:
    4e06:	0084d4        	ae_cvta32p24.h	a4, aep0
    4e09:	0007d4        	ae_cvta32p24.l	a7, aep0
    4e0c:	11d8           	l32i.n	a13, a1, 4
    4e0e:	204470        	or	a4, a4, a7
    4e11:	40e440        	nsa	a4, a4
    4e14:	434d40        	min	a4, a13, a4
    4e17:	125242        	s16i	a4, a2, 36
    4e1a:	440304        	ae_lp16x2f.i	aep0, a3, 0
    4e1d:	188f76        	loop	a15, 4e39 <fft_wo+0x121>
    4e20:	f923b38e1f 	{ ae_sp16x2f.iu	aep0, a14, 4; ae_sllssp24s	aep2, aep0 }
    4e25:	ea28ad831f 	{ ae_lp16x2f.iu	aep0, a3, 4; ae_mulfp24s.hl	aeq0, aep2, aep1 }
    4e2a:	e929ed98ff 	{ ae_lp16x2f.iu	aep1, a8, -4; ae_mulfp24s.lh	aeq3, aep2, aep1 }
    4e2f:	628a64        	ae_sq32f.x	aeq0, a10, a6
    4e32:	62bb64        	ae_sq32f.x	aeq3, a11, a6
    4e35:	256d           	ae_l16si.n	a6, a5, 0
    4e37:	559a           	add.n	a5, a5, a9

00004e39 <fft_wo+0x121>:
    4e39:	3148           	l32i.n	a4, a1, 12
    4e3b:	0238           	l32i.n	a3, a2, 0
    4e3d:	8c0c           	movi.n	a12, 8
    4e3f:	41b140        	srli	a11, a4, 1
    4e42:	a0a430        	addx4	a10, a4, a3
    4e45:	ece531        	l32r	a3, 1dc (5c94 <sw_fft_32b_2811>)
    4e48:	1d0c           	movi.n	a13, 1
    4e4a:	0e0c           	movi.n	a14, 0
    4e4c:	0003e0        	callx8	a3
    4e4f:	2138           	l32i.n	a3, a1, 8
    4e51:	04bd           	mov.n	a11, a4
    4e53:	c033a0        	sub	a3, a3, a10
    4e56:	135232        	s16i	a3, a2, 38
    4e59:	ece131        	l32r	a3, 1e0 (4cd0 <gen_power>)
    4e5c:	02ad           	mov.n	a10, a2
    4e5e:	0003e0        	callx8	a3
    4e61:	f01d           	retw.n

00004e63 <fft_wo+0x14b>:
    4e63:	4498f4        	ae_lp16x2f.iu	aep1, a8, -4
    4e66:	ffe706        	j	4e06 <fft_wo+0xee>

00004e69 <fft_wo+0x151>:
    4e69:	000000                                        ...

00004e6c <NR_vad1>:
    4e6c:	006136        	entry	a1, 48
    4e6f:	2e02b2        	l8ui	a11, a2, 46
    4e72:	0238           	l32i.n	a3, a2, 0
    4e74:	ece481        	l32r	a8, 204 (6b90 <wb_sb_ptn>)
    4e77:	066b16        	beqz	a11, 4ee1 <NR_vad1+0x75>
    4e7a:	ece361        	l32r	a6, 208 (6bc0 <nb_sb_ptn>)
    4e7d:	eca092        	movi	a9, 236
    4e80:	4153b0        	srli	a5, a11, 3
    4e83:	f29a           	add.n	a15, a2, a9
    4e85:	fd24bd033f 	{ ae_lq32f.i	aeq0, a3, 12; ae_zeroq56	aeq1 }
    4e8a:	31b9           	s32i.n	a11, a1, 12
    4e8c:	117be0        	slli	a7, a11, 2
    4e8f:	00a042        	movi	a4, 0
    4e92:	936850        	movnez	a6, a8, a5
    4e95:	0cc332        	addi	a3, a3, 12
    4e98:	0261f2        	s32i	a15, a1, 8

00004e9b <NR_vad1+0x2f>:
    4e9b:	265d           	ae_l16si.n	a5, a6, 0
    4e9d:	368d           	ae_l16si.n	a8, a6, 2
    4e9f:	c05850        	sub	a5, a8, a5
    4ea2:	0715a6        	blti	a5, 1, 4ead <NR_vad1+0x41>
    4ea5:	048576        	loop	a5, 4ead <NR_vad1+0x41>
    4ea8:	f96a3d131f 	{ ae_lq32f.iu	aeq0, a3, 4; ae_addq56	aeq1, aeq1, aeq0 }

00004ead <NR_vad1+0x41>:
    4ead:	365504        	ae_nsaq56s	a5, aeq1
    4eb0:	6e9282        	l16si	a8, a2, 220
    4eb3:	f8c552        	addi	a5, a5, -8
    4eb6:	fc24fe950f 	{ ae_slaasq56s	aeq0, aeq1, a5; nop }
    4ebb:	c0b850        	sub	a11, a8, a5
    4ebe:	368a04        	ae_trunca32q48	a10, aeq0
    4ec1:	ec9851        	l32r	a5, 124 (4e0 <Log2_norm>)
    4ec4:	0005e0        	callx8	a5
    4ec7:	fd24b3b25e 	{ l32i	a5, a2, 236; ae_zeroq56	aeq1 }
    4ecc:	600304        	ae_lq32f.i	aeq0, a3, 0
    4ecf:	662b           	addi.n	a6, a6, 2
    4ed1:	854a           	add.n	a8, a5, a4
    4ed3:	444b           	addi.n	a4, a4, 4
    4ed5:	08a9           	s32i.n	a10, a8, 0
    4ed7:	c09747        	bne	a7, a4, 4e9b <NR_vad1+0x2f>
    4eda:	31b8           	l32i.n	a11, a1, 12
    4edc:	21c8           	l32i.n	a12, a1, 8
    4ede:	0001c6        	j	4ee9 <NR_vad1+0x7d>

00004ee1 <NR_vad1+0x75>:
    4ee1:	3b2252        	l32i	a5, a2, 236
    4ee4:	eca032        	movi	a3, 236
    4ee7:	c23a           	add.n	a12, a2, a3
    4ee9:	ecc861        	l32r	a6, 20c (68f0 <NR_immediate_num>)
    4eec:	06cb16        	beqz	a11, 4f5c <NR_vad1+0xf0>
    4eef:	039272        	l16si	a7, a2, 6
    4ef2:	c4a082        	movi	a8, 196
    4ef5:	c8a092        	movi	a9, 200
    4ef8:	34c232        	addi	a3, a2, 52
    4efb:	117700        	slli	a7, a7, 16
    4efe:	360734        	ae_cvtq48a32s	aeq0, a7
    4f01:	604504        	ae_lq32f.i	aeq1, a5, 0
    4f04:	54c242        	addi	a4, a2, 84
    4f07:	070c           	movi.n	a7, 0
    4f09:	608304        	ae_lq32f.i	aeq2, a3, 0
    4f0c:	828a           	add.n	a8, a2, a8
    4f0e:	929a           	add.n	a9, a2, a9
    4f10:	338b76        	loop	a11, 4f47 <NR_vad1+0xdb>
    4f13:	d6c813a99f 	{ or	a10, a9, a9; ae_ltq56s	b0, aeq2, aeq1 }
    4f18:	09ed           	mov.n	a14, a9
    4f1a:	f76b           	addi.n	a15, a7, 6
    4f1c:	d3a800        	movt	a10, a8, b0
    4f1f:	440a04        	ae_lp16x2f.i	aep0, a10, 0
    4f22:	c18064        	ae_mulzaafq32sp16s.lh	aeq2, aeq1, aep0, aeq2, aep0
    4f25:	622304        	ae_sq32f.i	aeq2, a3, 0
    4f28:	60d414        	ae_lq32f.iu	aeq3, a4, 4
    4f2b:	09b104        	ae_ltq56s	b0, aeq1, aeq3
    4f2e:	d3e800        	movt	a14, a8, b0
    4f31:	447e04        	ae_lp16x2f.i	aep7, a14, 0
    4f34:	c1ff74        	ae_mulzaafq32sp16s.lh	aeq3, aeq1, aep7, aeq3, aep7
    4f37:	fab6f9b40f 	{ ae_sq32f.i	aeq3, a4, 0; ae_subq56	aeq2, aeq2, aeq3 }
    4f3c:	d6503d351f 	{ ae_lq32f.iu	aeq1, a5, 4; ae_ltq56s	b0, aeq0, aeq2 }
    4f41:	609314        	ae_lq32f.iu	aeq2, a3, 4
    4f44:	d37f00        	movt	a7, a15, b0

00004f47 <NR_vad1+0xdb>:
    4f47:	030c           	movi.n	a3, 0
    4f49:	0c58           	l32i.n	a5, a12, 0
    4f4b:	724370        	salt	a4, a3, a7
    4f4e:	f68b           	addi.n	a15, a6, 8
    4f50:	36cb           	addi.n	a3, a6, 12
    4f52:	933f40        	movnez	a3, a15, a4
    4f55:	7bcc           	bnez.n	a11, 4f60 <NR_vad1+0xf4>
    4f57:	000a86        	j	4f85 <NR_vad1+0x119>

00004f5a <NR_vad1+0xee>:
	...

00004f5c <NR_vad1+0xf0>:
    4f5c:	36cb           	addi.n	a3, a6, 12
    4f5e:	3bac           	beqz.n	a11, 4f85 <NR_vad1+0x119>
    4f60:	1092f2        	l16si	a15, a2, 32
    4f63:	440304        	ae_lp16x2f.i	aep0, a3, 0
    4f66:	7cc222        	addi	a2, a2, 124
    4f69:	113f00        	slli	a3, a15, 16
    4f6c:	608504        	ae_lq32f.i	aeq2, a5, 0
    4f6f:	600204        	ae_lq32f.i	aeq0, a2, 0
    4f72:	364334        	ae_cvtq48a32s	aeq1, a3
    4f75:	0c8b76        	loop	a11, 4f85 <NR_vad1+0x119>
    4f78:	0f003d121f 	{ ae_lq32f.iu	aeq0, a2, 4; ae_mulzaafq32sp16s.lh	aeq2, aeq2, aep0, aeq0, aep0 }
    4f7d:	fb773d551f 	{ ae_lq32f.iu	aeq2, a5, 4; ae_maxq56s	aeq3, aeq1, aeq2 }
    4f82:	6232f4        	ae_sq32f.i	aeq3, a2, -4

00004f85 <NR_vad1+0x119>:
    4f85:	f01d           	retw.n

00004f87 <NR_vad1+0x11b>:
	...

00004f88 <NR_vad2>:
    4f88:	008136        	entry	a1, 64
    4f8b:	151232        	l16ui	a3, a2, 42
    4f8e:	021242        	l16ui	a4, a2, 4
    4f91:	2e02a2        	l8ui	a10, a2, 46
    4f94:	109252        	l16si	a5, a2, 32
    4f97:	3e9347        	bne	a3, a4, 4fd9 <NR_vad2+0x51>
    4f9a:	040c           	movi.n	a4, 0
    4f9c:	155242        	s16i	a4, a2, 42
    4f9f:	71a9           	s32i.n	a10, a1, 28
    4fa1:	053d           	mov.n	a3, a5
    4fa3:	074a16        	beqz	a10, 501b <NR_vad2+0x93>
    4fa6:	c288           	l32i.n	a8, a2, 48
    4fa8:	ec8561        	l32r	a6, 1bc (4c40 <take_min_four>)
    4fab:	a0a042        	movi	a4, 160
    4fae:	08d332        	addmi	a3, a3, 0x800
    4fb1:	115300        	slli	a5, a3, 16
    4fb4:	0a7d           	mov.n	a7, a10
    4fb6:	424a           	add.n	a4, a2, a4
    4fb8:	083d           	mov.n	a3, a8
    4fba:	6189           	s32i.n	a8, a1, 24

00004fbc <NR_vad2+0x34>:
    4fbc:	cb0c           	movi.n	a11, 12
    4fbe:	03ad           	mov.n	a10, a3
    4fc0:	0006e0        	callx8	a6
    4fc3:	5385a0        	max	a8, a5, a10
    4fc6:	770b           	addi.n	a7, a7, -1
    4fc8:	0489           	s32i.n	a8, a4, 0
    4fca:	18c332        	addi	a3, a3, 24
    4fcd:	444b           	addi.n	a4, a4, 4
    4fcf:	fe9756        	bnez	a7, 4fbc <NR_vad2+0x34>
    4fd2:	001246        	j	501f <NR_vad2+0x97>

00004fd5 <NR_vad2+0x4d>:
    4fd5:	00000000                                ....

00004fd9 <NR_vad2+0x51>:
    4fd9:	7cc232        	addi	a3, a2, 124
    4fdc:	600304        	ae_lq32f.i	aeq0, a3, 0
    4fdf:	078a16        	beqz	a10, 505b <NR_vad2+0xd3>
    4fe2:	620154        	ae_sq32f.i	aeq0, a1, 20
    4fe5:	c258           	l32i.n	a5, a2, 48
    4fe7:	2d0262        	l8ui	a6, a2, 45
    4fea:	604154        	ae_lq32f.i	aeq1, a1, 20
    4fed:	841c           	movi.n	a4, 24
    4fef:	905650        	addx2	a5, a6, a5
    4ff2:	e8c552        	addi	a5, a5, -24
    4ff5:	0c8a76        	loop	a10, 5005 <NR_vad2+0x7d>
    4ff8:	f8ebda054f 	{ ae_lp16f.xu	aep0, a5, a4; ae_roundsp16q48sym	aep1, aeq1 }
    4ffd:	d822bd331f 	{ ae_lq32f.iu	aeq1, a3, 4; ae_minp24s	aep0, aep0, aep1 }
    5002:	420504        	ae_sp16f.l.i	aep0, a5, 0

00005005 <NR_vad2+0x7d>:
    5005:	159232        	l16si	a3, a2, 42
    5008:	ec8381        	l32r	a8, 214 (6b70 <wb_score_bands>)
    500b:	ec8141        	l32r	a4, 210 (e38e4 <_end+0xdc5c8>)
    500e:	331b           	addi.n	a3, a3, 1
    5010:	155232        	s16i	a3, a2, 42
    5013:	4c8ab6        	bltui	a10, 8, 5063 <NR_vad2+0xdb>
    5016:	043d           	mov.n	a3, a4
    5018:	001346        	j	5069 <NR_vad2+0xe1>

0000501b <NR_vad2+0x93>:
    501b:	c238           	l32i.n	a3, a2, 48
    501d:	6139           	s32i.n	a3, a1, 24
    501f:	2d0232        	l8ui	a3, a2, 45
    5022:	71a8           	l32i.n	a10, a1, 28
    5024:	331b           	addi.n	a3, a3, 1
    5026:	744030        	extui	a4, a3, 0, 8
    5029:	f4c442        	addi	a4, a4, -12
    502c:	934340        	movnez	a4, a3, a4
    502f:	7cc232        	addi	a3, a2, 124
    5032:	600304        	ae_lq32f.i	aeq0, a3, 0
    5035:	2d4242        	s8i	a4, a2, 45
    5038:	fa9c           	beqz.n	a10, 505b <NR_vad2+0xd3>
    503a:	620144        	ae_sq32f.i	aeq0, a1, 16
    503d:	6168           	l32i.n	a6, a1, 24
    503f:	744040        	extui	a4, a4, 0, 8
    5042:	604144        	ae_lq32f.i	aeq1, a1, 16
    5045:	906460        	addx2	a6, a4, a6
    5048:	841c           	movi.n	a4, 24
    504a:	e8c652        	addi	a5, a6, -24
    504d:	078a76        	loop	a10, 5058 <NR_vad2+0xd0>
    5050:	f8ebbd331f 	{ ae_lq32f.iu	aeq1, a3, 4; ae_roundsp16q48sym	aep0, aeq1 }
    5055:	438544        	ae_sp16f.l.xu	aep0, a5, a4

00005058 <NR_vad2+0xd0>:
    5058:	ffea46        	j	5005 <NR_vad2+0x7d>

0000505b <NR_vad2+0xd3>:
    505b:	159232        	l16si	a3, a2, 42
    505e:	331b           	addi.n	a3, a3, 1
    5060:	155232        	s16i	a3, a2, 42
    5063:	ec6e81        	l32r	a8, 21c (6bb0 <nb_score_bands>)
    5066:	ec6c31        	l32r	a3, 218 (124925 <_end+0x11d609>)
    5069:	398334        	ae_movpa24x2	aep0, a3, a3
    506c:	3c2242        	l32i	a4, a2, 240
    506f:	a0a052        	movi	a5, 160
    5072:	fc20fc452f 	{ ae_lq32f.xu	aeq2, a5, a2; ae_zerop48	aep1 }
    5077:	fc24b9813f 	{ ae_sq32f.i	aeq0, a1, 12; ae_zeroq56	aeq0 }
    507c:	604134        	ae_lq32f.i	aeq1, a1, 12
    507f:	326b           	addi.n	a3, a2, 6
    5081:	fbaac7c26e 	{ addi	a6, a2, 124; ae_subq56	aeq3, aeq1, aeq2 }
    5086:	fcc472        	addi	a7, a4, -4
    5089:	1e4a66        	bnei	a10, 4, 50ab <NR_vad2+0x123>
    508c:	420c           	movi.n	a2, 4
    508e:	178276        	loop	a2, 50a9 <NR_vad2+0x121>
    5091:	f8aaec831f 	{ ae_lp16f.iu	aep0, a3, 2; ae_subq56	aeq0, aeq1, aeq2 }
    5096:	ff0c3d361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_cvtq48p24s.l	aeq3, aep0 }
    509b:	f8a6fd551f 	{ ae_lq32f.iu	aeq2, a5, 4; ae_subq56	aeq0, aeq0, aeq3 }
    50a0:	350074        	ae_sraiq56	aeq0, aeq0, 1
    50a3:	098c74        	ae_truncp24q48x2	aep7, aeq0, aeq0
    50a6:	52f714        	ae_sp24f.l.iu	aep7, a7, 4

000050a9 <NR_vad2+0x121>:
    50a9:	f01d           	retw.n

000050ab <NR_vad2+0x123>:
    50ab:	fec882        	addi	a8, a8, -2
    50ae:	caac           	beqz.n	a10, 50de <NR_vad2+0x156>
    50b0:	190c           	movi.n	a9, 1
    50b2:	288a76        	loop	a10, 50de <NR_vad2+0x156>
    50b5:	40a314        	ae_lp16f.iu	aep2, a3, 2
    50b8:	fe4c00004f 	{ movi	a4, 0; ae_cvtq48p24s.l	aeq2, aep2 }
    50bd:	d6d82ca81f 	{ ae_lp16f.iu	aep2, a8, 2; ae_ltq56s	b0, aeq2, aeq3 }
    50c2:	f9bad6490f 	{ movt	a4, a9, b0; ae_subq56	aeq1, aeq3, aeq2 }
    50c7:	148c           	beqz.n	a4, 50cc <NR_vad2+0x144>
    50c9:	079214        	ae_addsp24s	aep1, aep1, aep2
    50cc:	f6c3bb109f 	{ ae_sraiq56	aeq2, aeq1, 1; ae_mulafq32sp24s.l	aeq0, aeq3, aep0 }
    50d1:	f9d23d361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_truncp24q48x2	aep2, aeq2, aeq2 }
    50d6:	609514        	ae_lq32f.iu	aeq2, a5, 4
    50d9:	fbaaf4a71f 	{ ae_sp24f.l.iu	aep2, a7, 4; ae_subq56	aeq3, aeq1, aeq2 }

000050de <NR_vad2+0x156>:
    50de:	408314        	ae_lp16f.iu	aep0, a3, 2
    50e1:	fd0c00003f 	{ movi	a3, 0; ae_cvtq48p24s.l	aeq1, aep0 }
    50e6:	d64400014f 	{ movi	a4, 1; ae_ltq56s	b0, aeq1, aeq0 }
    50eb:	d33400        	movt	a3, a4, b0
    50ee:	438c           	beqz.n	a3, 50f6 <NR_vad2+0x16e>
    50f0:	408814        	ae_lp16f.iu	aep0, a8, 2
    50f3:	079014        	ae_addsp24s	aep1, aep1, aep0

000050f6 <NR_vad2+0x16e>:
    50f6:	28c222        	addi	a2, a2, 40
    50f9:	421204        	ae_sp16f.l.i	aep1, a2, 0
    50fc:	f01d           	retw.n

000050fe <NR_vad2+0x176>:
	...

00005100 <NR_NoiseEstimate>:
    5100:	004136        	entry	a1, 32
    5103:	2f0232        	l8ui	a3, a2, 47
    5106:	0248           	l32i.n	a4, a2, 0
    5108:	0e9272        	l16si	a7, a2, 28
    510b:	039c           	beqz.n	a3, 511f <NR_NoiseEstimate+0x1f>
    510d:	04d452        	addmi	a5, a4, 0x400
    5110:	060c           	movi.n	a6, 0
    5112:	1177c0        	slli	a7, a7, 4
    5115:	068376        	loop	a3, 511f <NR_NoiseEstimate+0x1f>
    5118:	0579           	s32i.n	a7, a5, 0
    511a:	786562        	s32i	a6, a5, 0x1e0
    511d:	554b           	addi.n	a5, a5, 4

0000511f <NR_NoiseEstimate+0x1f>:
    511f:	141262        	l16ui	a6, a2, 40
    5122:	451c           	movi.n	a5, 20
    5124:	2e0272        	l8ui	a7, a2, 46
    5127:	5d3567        	bltu	a5, a6, 5188 <NR_NoiseEstimate+0x88>
    512a:	075d           	mov.n	a5, a7
    512c:	0576f6        	bgeui	a6, 7, 5135 <NR_NoiseEstimate+0x35>
    512f:	cca062        	movi	a6, 204
    5132:	0002c6        	j	5141 <NR_NoiseEstimate+0x41>

00005135 <NR_NoiseEstimate+0x35>:
    5135:	05b6f6        	bgeui	a6, 16, 513e <NR_NoiseEstimate+0x3e>
    5138:	d0a062        	movi	a6, 208
    513b:	000086        	j	5141 <NR_NoiseEstimate+0x41>

0000513e <NR_NoiseEstimate+0x3e>:
    513e:	d4a062        	movi	a6, 212
    5141:	626a           	add.n	a6, a2, a6
    5143:	041516        	beqz	a5, 5188 <NR_NoiseEstimate+0x88>
    5146:	0668           	l32i.n	a6, a6, 0
    5148:	3c2272        	l32i	a7, a2, 240
    514b:	ec2e91        	l32r	a9, 204 (6b90 <wb_sb_ptn>)
    514e:	e0a5a2        	movi	a10, 0x5e0
    5151:	080c           	movi.n	a8, 0
    5153:	a4aa           	add.n	a10, a4, a10
    5155:	0007c6        	j	5178 <NR_NoiseEstimate+0x78>

00005158 <NR_NoiseEstimate+0x58>:
    5158:	881b           	addi.n	a8, a8, 1
    515a:	90c890        	addx2	a12, a8, a9
    515d:	2dbd           	ae_l16si.n	a11, a13, 0
    515f:	2ccd           	ae_l16si.n	a12, a12, 0
    5161:	10abc7        	bge	a11, a12, 5175 <NR_NoiseEstimate+0x75>
    5164:	c0ccb0        	sub	a12, a12, a11
    5167:	a0bba0        	addx4	a11, a11, a10
    516a:	078c76        	loop	a12, 5175 <NR_NoiseEstimate+0x75>
    516d:	0bc8           	l32i.n	a12, a11, 0
    516f:	cc6a           	add.n	a12, a12, a6
    5171:	0bc9           	s32i.n	a12, a11, 0
    5173:	bb4b           	addi.n	a11, a11, 4

00005175 <NR_NoiseEstimate+0x75>:
    5175:	0f1857        	beq	a8, a5, 5188 <NR_NoiseEstimate+0x88>

00005178 <NR_NoiseEstimate+0x78>:
    5178:	a0b870        	addx4	a11, a8, a7
    517b:	0bb8           	l32i.n	a11, a11, 0
    517d:	90d890        	addx2	a13, a8, a9
    5180:	d41ba6        	blti	a11, 1, 5158 <NR_NoiseEstimate+0x58>
    5183:	881b           	addi.n	a8, a8, 1
    5185:	fffb06        	j	5175 <NR_NoiseEstimate+0x75>

00005188 <NR_NoiseEstimate+0x88>:
    5188:	6e9282        	l16si	a8, a2, 220
    518b:	6f9292        	l16si	a9, a2, 222
    518e:	402262        	l32i	a6, a2, 0x100
    5191:	987d           	ae_zext16	a7, a8
    5193:	99ad           	ae_zext16	a10, a9
    5195:	54cb           	addi.n	a5, a4, 12
    5197:	2417a7        	beq	a7, a10, 51bf <NR_NoiseEstimate+0xbf>
    519a:	c09890        	sub	a9, a8, a9
    519d:	a37a90        	movltz	a7, a10, a9
    51a0:	539c           	beqz.n	a3, 51b9 <NR_NoiseEstimate+0xb9>
    51a2:	06ad           	mov.n	a10, a6
    51a4:	a3a590        	movltz	a10, a5, a9
    51a7:	608190        	abs	a8, a9
    51aa:	fcca92        	addi	a9, a10, -4
    51ad:	088376        	loop	a3, 51b9 <NR_NoiseEstimate+0xb9>
    51b0:	601914        	ae_lq32f.iu	aeq0, a9, 4
    51b3:	3408a4        	ae_srlaq56	aeq0, aeq0, a8
    51b6:	620904        	ae_sq32f.i	aeq0, a9, 0

000051b9 <NR_NoiseEstimate+0xb9>:
    51b9:	6f5272        	s16i	a7, a2, 222
    51bc:	6e5272        	s16i	a7, a2, 220

000051bf <NR_NoiseEstimate+0xbf>:
    51bf:	fc2485dc7f 	{ movi	a7, 0x5dc; ae_zeroq56	aeq0 }
    51c4:	83ac           	beqz.n	a3, 51f0 <NR_NoiseEstimate+0xf0>
    51c6:	604434        	ae_lq32f.i	aeq1, a4, 12
    51c9:	fcc662        	addi	a6, a6, -4
    51cc:	447a           	add.n	a4, a4, a7
    51ce:	1e8376        	loop	a3, 51f0 <NR_NoiseEstimate+0xf0>
    51d1:	448414        	ae_lp16x2f.iu	aep0, a4, 4
    51d4:	447d           	ae_l16ui.n	a7, a4, 0
    51d6:	609614        	ae_lq32f.iu	aeq2, a6, 4
    51d9:	c18894        	ae_mulzaafq32sp16s.lh	aeq3, aeq2, aep0, aeq1, aep0
    51dc:	978c           	beqz.n	a7, 51e9 <NR_NoiseEstimate+0xe9>
    51de:	f87b3d351f 	{ ae_lq32f.iu	aeq1, a5, 4; ae_maxq56s	aeq0, aeq0, aeq3 }
    51e3:	623604        	ae_sq32f.i	aeq3, a6, 0
    51e6:	000106        	j	51ee <NR_NoiseEstimate+0xee>

000051e9 <NR_NoiseEstimate+0xe9>:
    51e9:	f8733d351f 	{ ae_lq32f.iu	aeq1, a5, 4; ae_maxq56s	aeq0, aeq0, aeq2 }
    51ee:	f03d           	nop.n

000051f0 <NR_NoiseEstimate+0xf0>:
    51f0:	364404        	ae_nsaq56s	a4, aeq0
    51f3:	09a052        	movi	a5, 9
    51f6:	1f2457        	blt	a4, a5, 5219 <NR_NoiseEstimate+0x119>
    51f9:	6f9262        	l16si	a6, a2, 222
    51fc:	f8c442        	addi	a4, a4, -8
    51ff:	402252        	l32i	a5, a2, 0x100
    5202:	c06640        	sub	a6, a6, a4
    5205:	6f5262        	s16i	a6, a2, 222
    5208:	d38c           	beqz.n	a3, 5219 <NR_NoiseEstimate+0x119>
    520a:	fcc522        	addi	a2, a5, -4
    520d:	088376        	loop	a3, 5219 <NR_NoiseEstimate+0x119>
    5210:	601214        	ae_lq32f.iu	aeq0, a2, 4
    5213:	340494        	ae_sllaq56	aeq0, aeq0, a4
    5216:	620204        	ae_sq32f.i	aeq0, a2, 0
    5219:	f01d           	retw.n

0000521b <NR_NoiseEstimate+0x11b>:
	...

0000521c <airoha_divide>:
    521c:	004136        	entry	a1, 32
    521f:	204320        	or	a4, a3, a2
    5222:	0d8416        	beqz	a4, 52fe <airoha_divide+0xe2>
    5225:	0de216        	beqz	a2, 5307 <airoha_divide+0xeb>
    5228:	0e2316        	beqz	a3, 530e <airoha_divide+0xf2>
    522b:	609120        	abs	a9, a2
    522e:	60b130        	abs	a11, a3
    5231:	055f90        	extui	a5, a9, 31, 1
    5234:	056fb0        	extui	a6, a11, 31, 1
    5237:	400500        	ssr	a5
    523a:	304320        	xor	a4, a3, a2
    523d:	912090        	srl	a2, a9
    5240:	400600        	ssr	a6
    5243:	91c0b0        	srl	a12, a11
    5246:	40e2d0        	nsa	a13, a2
    5249:	40ec30        	nsa	a3, a12
    524c:	e31b           	addi.n	a14, a3, 1
    524e:	401d00        	ssl	a13
    5251:	317fb0        	srai	a7, a11, 31
    5254:	a13200        	sll	a3, a2
    5257:	401e00        	ssl	a14
    525a:	a75a           	add.n	a10, a7, a5
    525c:	a17c00        	sll	a7, a12
    525f:	f55070        	extui	a5, a7, 16, 16
    5262:	c26350        	quou	a6, a3, a5
    5265:	829650        	mull	a9, a6, a5
    5268:	978d           	ae_zext16	a8, a7
    526a:	c09390        	sub	a9, a3, a9
    526d:	828680        	mull	a8, a6, a8
    5270:	c0fed0        	sub	a15, a14, a13
    5273:	119900        	slli	a9, a9, 16
    5276:	2afa           	add.n	a2, a10, a15
    5278:	09b987        	bgeu	a9, a8, 5285 <airoha_divide+0x69>

0000527b <airoha_divide+0x5f>:
    527b:	997a           	add.n	a9, a9, a7
    527d:	660b           	addi.n	a6, a6, -1
    527f:	02b987        	bgeu	a9, a8, 5285 <airoha_divide+0x69>
    5282:	f5b977        	bgeu	a9, a7, 527b <airoha_divide+0x5f>
    5285:	c0e980        	sub	a14, a9, a8
    5288:	c25e50        	quou	a5, a14, a5
    528b:	11a600        	slli	a10, a6, 16
    528e:	623370        	saltu	a3, a3, a7
    5291:	2b0c           	movi.n	a11, 2
    5293:	c09b30        	sub	a9, a11, a3
    5296:	5a5a           	add.n	a5, a10, a5
    5298:	f5f060        	extui	a15, a6, 16, 16
    529b:	6265a0        	saltu	a6, a5, a10
    529e:	d59a           	add.n	a13, a5, a9
    52a0:	fc1c           	movi.n	a12, 31
    52a2:	6f6a           	add.n	a6, a15, a6
    52a4:	625d50        	saltu	a5, a13, a5
    52a7:	565a           	add.n	a5, a6, a5
    52a9:	400900        	ssr	a9
    52ac:	3079c0        	xor	a7, a9, a12
    52af:	9180d0        	srl	a8, a13
    52b2:	401700        	ssl	a7
    52b5:	1165f0        	slli	a6, a5, 1
    52b8:	a16600        	sll	a6, a6
    52bb:	400900        	ssr	a9
    52be:	0f0c           	movi.n	a15, 0
    52c0:	206860        	or	a6, a8, a6
    52c3:	915050        	srl	a5, a5
    52c6:	1e0c           	movi.n	a14, 1
    52c8:	7286f0        	salt	a8, a6, a15
    52cb:	629f50        	saltu	a9, a15, a5
    52ce:	1a0c           	movi.n	a10, 1
    52d0:	3073e0        	xor	a7, a3, a14
    52d3:	839850        	moveqz	a9, a8, a5
    52d6:	015a20        	slli	a5, a10, 30
    52d9:	ebd1b1        	l32r	a11, 220 (80000001 <_end+0x7fff8ce5>)
    52dc:	727a           	add.n	a7, a2, a7
    52de:	fc7c           	movi.n	a12, -1
    52e0:	835690        	moveqz	a5, a6, a9
    52e3:	4131c0        	srli	a3, a12, 1
    52e6:	60e050        	neg	a14, a5
    52e9:	d79a           	add.n	a13, a7, a9
    52eb:	f23c           	movi.n	a2, 63
    52ed:	c0cdf2        	addi	a15, a13, -64
    52f0:	a33b40        	movltz	a3, a11, a4
    52f3:	b3e540        	movgez	a14, a5, a4
    52f6:	932df0        	movnez	a2, a13, a15
    52f9:	933ef0        	movnez	a3, a14, a15
    52fc:	f01d           	retw.n

000052fe <airoha_divide+0xe2>:
    52fe:	f37c           	movi.n	a3, -1
    5300:	020c           	movi.n	a2, 0
    5302:	413130        	srli	a3, a3, 1
    5305:	f01d           	retw.n

00005307 <airoha_divide+0xeb>:
    5307:	030c           	movi.n	a3, 0
    5309:	c1af22        	movi	a2, -63
    530c:	f01d           	retw.n

0000530e <airoha_divide+0xf2>:
    530e:	ebc431        	l32r	a3, 220 (80000001 <_end+0x7fff8ce5>)
    5311:	040c           	movi.n	a4, 0
    5313:	f57c           	movi.n	a5, -1
    5315:	724420        	salt	a4, a4, a2
    5318:	415150        	srli	a5, a5, 1
    531b:	f23c           	movi.n	a2, 63
    531d:	933540        	movnez	a3, a5, a4
    5320:	f01d           	retw.n

00005322 <airoha_divide+0x106>:
	...

00005324 <airoha_divide_limit_1>:
    5324:	006136        	entry	a1, 48
    5327:	eb6c41        	l32r	a4, d8 (521c <airoha_divide>)
    532a:	02ad           	mov.n	a10, a2
    532c:	03bd           	mov.n	a11, a3
    532e:	0004e0        	callx8	a4
    5331:	360b34        	ae_cvtq48a32s	aeq0, a11
    5334:	fc24fe8a0f 	{ ae_slaasq56s	aeq0, aeq0, a10; nop }
    5339:	060934        	ae_roundsq32asym	aeq0, aeq0
    533c:	620134        	ae_sq32f.i	aeq0, a1, 12
    533f:	3128           	l32i.n	a2, a1, 12
    5341:	f01d           	retw.n

00005343 <airoha_divide_limit_1+0x1f>:
    5343:	00000000                                 .....

00005348 <xtensa_fft4_32b>:
    5348:	00c136        	entry	a1, 96
    534b:	600254        	ae_lq32f.i	aeq0, a2, 20
    534e:	604274        	ae_lq32f.i	aeq1, a2, 28
    5351:	fa663d626f 	{ ae_lq32f.i	aeq3, a2, 24; ae_addq56	aeq2, aeq0, aeq1 }
    5356:	f826fa217f 	{ ae_sq56s.i	aeq2, a1, 56; ae_subq56	aeq0, aeq0, aeq1 }
    535b:	630134        	ae_sq56s.i	aeq0, a1, 24
    535e:	600244        	ae_lq32f.i	aeq0, a2, 16
    5361:	fa7a3d220f 	{ ae_lq32f.i	aeq1, a2, 0; ae_addq56	aeq2, aeq3, aeq0 }
    5366:	f83afa211f 	{ ae_sq56s.i	aeq2, a1, 8; ae_subq56	aeq0, aeq3, aeq0 }
    536b:	630164        	ae_sq56s.i	aeq0, a1, 48
    536e:	600224        	ae_lq32f.i	aeq0, a2, 8
    5371:	fb6a3dc11f 	{ ae_lq56.i	aeq2, a1, 8; ae_addq56	aeq3, aeq1, aeq0 }
    5376:	01bac4        	ae_addq56	aeq2, aeq3, aeq2
    5379:	f82afa212f 	{ ae_sq56s.i	aeq2, a1, 16; ae_subq56	aeq0, aeq1, aeq0 }
    537e:	618124        	ae_lq56.i	aeq2, a1, 16
    5381:	622204        	ae_sq32f.i	aeq2, a2, 0
    5384:	618114        	ae_lq56.i	aeq2, a1, 8
    5387:	f9bafd621f 	{ ae_lq32f.i	aeq3, a2, 4; ae_subq56	aeq1, aeq3, aeq2 }
    538c:	631114        	ae_sq56s.i	aeq1, a1, 8
    538f:	614134        	ae_lq56.i	aeq1, a1, 24
    5392:	fb663a315f 	{ ae_sq56s.i	aeq3, a1, 40; ae_addq56	aeq3, aeq0, aeq1 }
    5397:	f826fd423f 	{ ae_lq32f.i	aeq2, a2, 12; ae_subq56	aeq0, aeq0, aeq1 }
    539c:	633124        	ae_sq56s.i	aeq3, a1, 16
    539f:	614114        	ae_lq56.i	aeq1, a1, 8
    53a2:	61c154        	ae_lq56.i	aeq3, a1, 40
    53a5:	630134        	ae_sq56s.i	aeq0, a1, 24
    53a8:	f9fa39924f 	{ ae_sq32f.i	aeq1, a2, 16; ae_addq56	aeq1, aeq3, aeq2 }
    53ad:	632144        	ae_sq56s.i	aeq2, a1, 32
    53b0:	618124        	ae_lq56.i	aeq2, a1, 16
    53b3:	610174        	ae_lq56.i	aeq0, a1, 56
    53b6:	fa6a39a22f 	{ ae_sq32f.i	aeq2, a2, 8; ae_addq56	aeq2, aeq1, aeq0 }
    53bb:	f82afa211f 	{ ae_sq56s.i	aeq2, a1, 8; ae_subq56	aeq0, aeq1, aeq0 }
    53c0:	618134        	ae_lq56.i	aeq2, a1, 24
    53c3:	622264        	ae_sq32f.i	aeq2, a2, 24
    53c6:	618144        	ae_lq56.i	aeq2, a1, 32
    53c9:	f9baf9825f 	{ ae_sq32f.i	aeq0, a2, 20; ae_subq56	aeq1, aeq3, aeq2 }
    53ce:	610164        	ae_lq56.i	aeq0, a1, 48
    53d1:	fb6a3dc11f 	{ ae_lq56.i	aeq2, a1, 8; ae_addq56	aeq3, aeq1, aeq0 }
    53d6:	f92af9a21f 	{ ae_sq32f.i	aeq2, a2, 4; ae_subq56	aeq1, aeq1, aeq0 }
    53db:	623234        	ae_sq32f.i	aeq3, a2, 12
    53de:	621274        	ae_sq32f.i	aeq1, a2, 28
    53e1:	f01d           	retw.n

000053e3 <xtensa_fft4_32b+0x9b>:
	...

000053e4 <xtensa_fft8_32b>:
    53e4:	022136        	entry	a1, 0x110
    53e7:	600254        	ae_lq32f.i	aeq0, a2, 20
    53ea:	604274        	ae_lq32f.i	aeq1, a2, 28
    53ed:	fb663d426f 	{ ae_lq32f.i	aeq2, a2, 24; ae_addq56	aeq3, aeq0, aeq1 }
    53f2:	f826fa315f 	{ ae_sq56s.i	aeq3, a1, 40; ae_subq56	aeq0, aeq0, aeq1 }
    53f7:	630124        	ae_sq56s.i	aeq0, a1, 16
    53fa:	600244        	ae_lq32f.i	aeq0, a2, 16
    53fd:	f9723d620f 	{ ae_lq32f.i	aeq3, a2, 0; ae_addq56	aeq1, aeq2, aeq0 }
    5402:	f832c7816e 	{ addi	a6, a1, 120; ae_subq56	aeq0, aeq2, aeq0 }
    5407:	630134        	ae_sq56s.i	aeq0, a1, 24
    540a:	600224        	ae_lq32f.i	aeq0, a2, 8
    540d:	01b8c4        	ae_addq56	aeq2, aeq3, aeq0
    5410:	fa3afa211f 	{ ae_sq56s.i	aeq2, a1, 8; ae_subq56	aeq2, aeq3, aeq0 }
    5415:	61c114        	ae_lq56.i	aeq3, a1, 8
    5418:	f83efd621f 	{ ae_lq32f.i	aeq3, a2, 4; ae_subq56	aeq0, aeq3, aeq1 }
    541d:	6306c4        	ae_sq56s.i	aeq0, a6, -32
    5420:	610124        	ae_lq56.i	aeq0, a1, 16
    5423:	fb723a314f 	{ ae_sq56s.i	aeq3, a1, 32; ae_addq56	aeq3, aeq2, aeq0 }
    5428:	fa32fd86cf 	{ ae_lq56.i	aeq0, a6, -32; ae_subq56	aeq2, aeq2, aeq0 }
    542d:	6316e4        	ae_sq56s.i	aeq1, a6, -16
    5430:	620244        	ae_sq32f.i	aeq0, a2, 16
    5433:	604234        	ae_lq32f.i	aeq1, a2, 12
    5436:	610144        	ae_lq56.i	aeq0, a1, 32
    5439:	f8663a364f 	{ ae_sq56s.i	aeq3, a6, 32; ae_addq56	aeq0, aeq0, aeq1 }
    543e:	623224        	ae_sq32f.i	aeq3, a2, 8
    5441:	61c154        	ae_lq56.i	aeq3, a1, 40
    5444:	fba6fa06df 	{ ae_sq56s.i	aeq0, a6, -24; ae_subq56	aeq3, aeq0, aeq3 }
    5449:	610144        	ae_lq56.i	aeq0, a1, 32
    544c:	f826fa36ff 	{ ae_sq56s.i	aeq3, a6, -8; ae_subq56	aeq0, aeq0, aeq1 }
    5451:	623254        	ae_sq32f.i	aeq3, a2, 20
    5454:	61c134        	ae_lq56.i	aeq3, a1, 24
    5457:	f9e602023e 	{ addi	a3, a2, 32; ae_addq56	aeq1, aeq0, aeq3 }
    545c:	f8a6fa163f 	{ ae_sq56s.i	aeq1, a6, 24; ae_subq56	aeq0, aeq0, aeq3 }
    5461:	621234        	ae_sq32f.i	aeq1, a2, 12
    5464:	604304        	ae_lq32f.i	aeq1, a3, 0
    5467:	6316b4        	ae_sq56s.i	aeq1, a6, -40
    546a:	632664        	ae_sq56s.i	aeq2, a6, 48
    546d:	622264        	ae_sq32f.i	aeq2, a2, 24
    5470:	608314        	ae_lq32f.i	aeq2, a3, 4
    5473:	630654        	ae_sq56s.i	aeq0, a6, 40
    5476:	620274        	ae_sq32f.i	aeq0, a2, 28
    5479:	600374        	ae_lq32f.i	aeq0, a3, 28
    547c:	01d142        	addmi	a4, a1, 0x100
    547f:	632134        	ae_sq56s.i	aeq2, a1, 24
    5482:	608324        	ae_lq32f.i	aeq2, a3, 8
    5485:	60c334        	ae_lq32f.i	aeq3, a3, 12
    5488:	604354        	ae_lq32f.i	aeq1, a3, 20
    548b:	630164        	ae_sq56s.i	aeq0, a1, 48
    548e:	6106b4        	ae_lq56.i	aeq0, a6, -40
    5491:	f8e23a312f 	{ ae_sq56s.i	aeq3, a1, 16; ae_addq56	aeq0, aeq0, aeq2 }
    5496:	60c344        	ae_lq32f.i	aeq3, a3, 16
    5499:	631144        	ae_sq56s.i	aeq1, a1, 32
    549c:	604364        	ae_lq32f.i	aeq1, a3, 24
    549f:	b0c442        	addi	a4, a4, -80
    54a2:	01d152        	addmi	a5, a1, 0x100
    54a5:	fb7e3a361f 	{ ae_sq56s.i	aeq3, a6, 8; ae_addq56	aeq3, aeq3, aeq1 }
    54aa:	632604        	ae_sq56s.i	aeq2, a6, 0
    54ad:	631624        	ae_sq56s.i	aeq1, a6, 16
    54b0:	620404        	ae_sq32f.i	aeq0, a4, 0
    54b3:	608404        	ae_lq32f.i	aeq2, a4, 0
    54b6:	b4c552        	addi	a5, a5, -76
    54b9:	6326a4        	ae_sq56s.i	aeq2, a6, -48
    54bc:	623504        	ae_sq32f.i	aeq3, a5, 0
    54bf:	01d1a2        	addmi	a10, a1, 0x100
    54c2:	610134        	ae_lq56.i	aeq0, a1, 24
    54c5:	61c124        	ae_lq56.i	aeq3, a1, 16
    54c8:	f8e63d450f 	{ ae_lq32f.i	aeq2, a5, 0; ae_addq56	aeq0, aeq0, aeq3 }
    54cd:	b8ca42        	addi	a4, a10, -72
    54d0:	632694        	ae_sq56s.i	aeq2, a6, -56
    54d3:	620404        	ae_sq32f.i	aeq0, a4, 0
    54d6:	01d1b2        	addmi	a11, a1, 0x100
    54d9:	610144        	ae_lq56.i	aeq0, a1, 32
    54dc:	61c164        	ae_lq56.i	aeq3, a1, 48
    54df:	f8e63d440f 	{ ae_lq32f.i	aeq2, a4, 0; ae_addq56	aeq0, aeq0, aeq3 }
    54e4:	bccb52        	addi	a5, a11, -68
    54e7:	632174        	ae_sq56s.i	aeq2, a1, 56
    54ea:	620504        	ae_sq32f.i	aeq0, a5, 0
    54ed:	01d1c2        	addmi	a12, a1, 0x100
    54f0:	610114        	ae_lq56.i	aeq0, a1, 8
    54f3:	61c6e4        	ae_lq56.i	aeq3, a6, -16
    54f6:	f9e63d450f 	{ ae_lq32f.i	aeq2, a5, 0; ae_addq56	aeq1, aeq0, aeq3 }
    54fb:	c0cc42        	addi	a4, a12, -64
    54fe:	632114        	ae_sq56s.i	aeq2, a1, 8
    5501:	621404        	ae_sq32f.i	aeq1, a4, 0
    5504:	01d1d2        	addmi	a13, a1, 0x100
    5507:	61c154        	ae_lq56.i	aeq3, a1, 40
    550a:	6146d4        	ae_lq56.i	aeq1, a6, -24
    550d:	f9ee0c4d5e 	{ addi	a5, a13, -60; ae_addq56	aeq1, aeq1, aeq3 }
    5512:	60c404        	ae_lq32f.i	aeq3, a4, 0
    5515:	621504        	ae_sq32f.i	aeq1, a5, 0
    5518:	6186a4        	ae_lq56.i	aeq2, a6, -48
    551b:	614694        	ae_lq56.i	aeq1, a6, -56
    551e:	f9763d450f 	{ ae_lq32f.i	aeq2, a5, 0; ae_addq56	aeq1, aeq2, aeq1 }
    5523:	f83ec082bf 	{ movi	a11, 130; ae_subq56	aeq0, aeq3, aeq1 }
    5528:	f97e3a015f 	{ ae_sq56s.i	aeq0, a1, 40; ae_addq56	aeq1, aeq3, aeq1 }
    552d:	610154        	ae_lq56.i	aeq0, a1, 40
    5530:	620304        	ae_sq32f.i	aeq0, a3, 0
    5533:	61c114        	ae_lq56.i	aeq3, a1, 8
    5536:	610174        	ae_lq56.i	aeq0, a1, 56
    5539:	fbe639920f 	{ ae_sq32f.i	aeq1, a2, 0; ae_addq56	aeq3, aeq0, aeq3 }
    553e:	016fc4        	ae_subq56	aeq1, aeq2, aeq3
    5541:	01d1e2        	addmi	a14, a1, 0x100
    5544:	f8f639931f 	{ ae_sq32f.i	aeq1, a3, 4; ae_addq56	aeq0, aeq2, aeq3 }
    5549:	c8ce42        	addi	a4, a14, -56
    554c:	6146c4        	ae_lq56.i	aeq1, a6, -32
    554f:	620214        	ae_sq32f.i	aeq0, a2, 4
    5552:	621404        	ae_sq32f.i	aeq1, a4, 0
    5555:	01d1f2        	addmi	a15, a1, 0x100
    5558:	cccf52        	addi	a5, a15, -52
    555b:	6186f4        	ae_lq56.i	aeq2, a6, -8
    555e:	600404        	ae_lq32f.i	aeq0, a4, 0
    5561:	622504        	ae_sq32f.i	aeq2, a5, 0
    5564:	614114        	ae_lq56.i	aeq1, a1, 8
    5567:	61c174        	ae_lq56.i	aeq3, a1, 56
    556a:	f93efd450f 	{ ae_lq32f.i	aeq2, a5, 0; ae_subq56	aeq1, aeq3, aeq1 }
    556f:	01cdc4        	ae_subq56	aeq3, aeq0, aeq1
    5572:	f86639b34f 	{ ae_sq32f.i	aeq3, a3, 16; ae_addq56	aeq0, aeq0, aeq1 }
    5577:	6146a4        	ae_lq56.i	aeq1, a6, -48
    557a:	61c694        	ae_lq56.i	aeq3, a6, -56
    557d:	f93ef9824f 	{ ae_sq32f.i	aeq0, a2, 16; ae_subq56	aeq1, aeq3, aeq1 }
    5582:	01edc4        	ae_subq56	aeq3, aeq2, aeq1
    5585:	f97639b35f 	{ ae_sq32f.i	aeq3, a3, 20; ae_addq56	aeq1, aeq2, aeq1 }
    558a:	01d172        	addmi	a7, a1, 0x100
    558d:	6186b4        	ae_lq56.i	aeq2, a6, -40
    5590:	61c604        	ae_lq56.i	aeq3, a6, 0
    5593:	f8b6cd074e 	{ addi	a4, a7, -48; ae_subq56	aeq0, aeq2, aeq3 }
    5598:	621254        	ae_sq32f.i	aeq1, a2, 20
    559b:	620404        	ae_sq32f.i	aeq0, a4, 0
    559e:	01d182        	addmi	a8, a1, 0x100
    55a1:	610134        	ae_lq56.i	aeq0, a1, 24
    55a4:	61c124        	ae_lq56.i	aeq3, a1, 16
    55a7:	f9a6fd440f 	{ ae_lq32f.i	aeq2, a4, 0; ae_subq56	aeq1, aeq0, aeq3 }
    55ac:	d4c852        	addi	a5, a8, -44
    55af:	632114        	ae_sq56s.i	aeq2, a1, 8
    55b2:	621504        	ae_sq32f.i	aeq1, a5, 0
    55b5:	01d192        	addmi	a9, a1, 0x100
    55b8:	61c624        	ae_lq56.i	aeq3, a6, 16
    55bb:	614614        	ae_lq56.i	aeq1, a6, 8
    55be:	f9aefd650f 	{ ae_lq32f.i	aeq3, a5, 0; ae_subq56	aeq1, aeq1, aeq3 }
    55c3:	d8c942        	addi	a4, a9, -40
    55c6:	633124        	ae_sq56s.i	aeq3, a1, 16
    55c9:	621404        	ae_sq32f.i	aeq1, a4, 0
    55cc:	610144        	ae_lq56.i	aeq0, a1, 32
    55cf:	618164        	ae_lq56.i	aeq2, a1, 48
    55d2:	faa2fd040f 	{ ae_lq32f.i	aeq0, a4, 0; ae_subq56	aeq2, aeq0, aeq2 }
    55d7:	dcca52        	addi	a5, a10, -36
    55da:	630134        	ae_sq56s.i	aeq0, a1, 24
    55dd:	622504        	ae_sq32f.i	aeq2, a5, 0
    55e0:	78c172        	addi	a7, a1, 120
    55e3:	600504        	ae_lq32f.i	aeq0, a5, 0
    55e6:	614744        	ae_lq56.i	aeq1, a7, 32
    55e9:	630164        	ae_sq56s.i	aeq0, a1, 48
    55ec:	621c84        	ae_sq32f.i	aeq1, a12, -32
    55ef:	618114        	ae_lq56.i	aeq2, a1, 8
    55f2:	61c124        	ae_lq56.i	aeq3, a1, 16
    55f5:	016bc4        	ae_addq56	aeq1, aeq2, aeq3
    55f8:	fabafde13f 	{ ae_lq56.i	aeq3, a1, 24; ae_subq56	aeq2, aeq3, aeq2 }
    55fd:	f93afa115f 	{ ae_sq56s.i	aeq1, a1, 40; ae_subq56	aeq1, aeq3, aeq0 }
    5602:	632114        	ae_sq56s.i	aeq2, a1, 8
    5605:	610734        	ae_lq56.i	aeq0, a7, 24
    5608:	5adb42        	addmi	a4, a11, 0x5a00
    560b:	608c84        	ae_lq32f.i	aeq2, a12, -32
    560e:	631144        	ae_sq56s.i	aeq1, a1, 32
    5611:	620d94        	ae_sq32f.i	aeq0, a13, -28
    5614:	300444        	ae_cvtp24a16x2.ll	aep0, a4, a4
    5617:	610154        	ae_lq56.i	aeq0, a1, 40
    561a:	0c00bda16f 	{ ae_lq56.i	aeq1, a1, 48; ae_mulzaafq32sp16s.lh	aeq0, aeq0, aep0, aeq1, aep0 }
    561f:	015bc4        	ae_addq56	aeq1, aeq1, aeq3
    5622:	fb32fa112f 	{ ae_sq56s.i	aeq1, a1, 16; ae_subq56	aeq3, aeq2, aeq0 }
    5627:	f8723d2d9f 	{ ae_lq32f.i	aeq1, a13, -28; ae_addq56	aeq0, aeq2, aeq0 }
    562c:	633134        	ae_sq56s.i	aeq3, a1, 24
    562f:	61c134        	ae_lq56.i	aeq3, a1, 24
    5632:	623324        	ae_sq32f.i	aeq3, a3, 8
    5635:	61c124        	ae_lq56.i	aeq3, a1, 16
    5638:	618114        	ae_lq56.i	aeq2, a1, 8
    563b:	0f02ba016f 	{ ae_sq56s.i	aeq0, a1, 48; ae_mulzaafq32sp16s.lh	aeq2, aeq2, aep0, aeq3, aep0 }
    5640:	610164        	ae_lq56.i	aeq0, a1, 48
    5643:	f8aaf9822f 	{ ae_sq32f.i	aeq0, a2, 8; ae_subq56	aeq0, aeq1, aeq2 }
    5648:	f9ea3dc76f 	{ ae_lq56.i	aeq2, a7, 48; ae_addq56	aeq1, aeq1, aeq2 }
    564d:	621234        	ae_sq32f.i	aeq1, a2, 12
    5650:	620334        	ae_sq32f.i	aeq0, a3, 12
    5653:	614114        	ae_lq56.i	aeq1, a1, 8
    5656:	3c03b9aeaf 	{ ae_sq32f.i	aeq2, a14, -24; ae_mulzasfq32sp16s.lh	aeq0, aeq1, aep0, aeq3, aep0 }
    565b:	614154        	ae_lq56.i	aeq1, a1, 40
    565e:	61c144        	ae_lq56.i	aeq3, a1, 32
    5661:	3e01fde75f 	{ ae_lq56.i	aeq3, a7, 40; ae_mulzasfq32sp16s.lh	aeq1, aeq3, aep0, aeq1, aep0 }
    5666:	608ea4        	ae_lq32f.i	aeq2, a14, -24
    5669:	fb32f9bfbf 	{ ae_sq32f.i	aeq3, a15, -20; ae_subq56	aeq3, aeq2, aeq0 }
    566e:	f8723d4fbf 	{ ae_lq32f.i	aeq2, a15, -20; ae_addq56	aeq0, aeq2, aeq0 }
    5673:	fb36f9b36f 	{ ae_sq32f.i	aeq3, a3, 24; ae_subq56	aeq3, aeq2, aeq1 }
    5678:	f97639826f 	{ ae_sq32f.i	aeq0, a2, 24; ae_addq56	aeq1, aeq2, aeq1 }
    567d:	623374        	ae_sq32f.i	aeq3, a3, 28
    5680:	621274        	ae_sq32f.i	aeq1, a2, 28
    5683:	f01d           	retw.n

00005685 <xtensa_fft8_32b+0x2a1>:
    5685:	000000                                        ...

00005688 <F_get_oft_32b>:
    5688:	004136        	entry	a1, 32
    568b:	0cc2e6        	bgei	a2, 32, 569b <F_get_oft_32b+0x13>
    568e:	134226        	beqi	a2, 4, 56a5 <F_get_oft_32b+0x1d>
    5691:	148226        	beqi	a2, 8, 56a9 <F_get_oft_32b+0x21>
    5694:	09b266        	bnei	a2, 16, 56a1 <F_get_oft_32b+0x19>
    5697:	021c           	movi.n	a2, 16
    5699:	f01d           	retw.n

0000569b <F_get_oft_32b+0x13>:
    569b:	0ec226        	beqi	a2, 32, 56ad <F_get_oft_32b+0x25>
    569e:	0fd226        	beqi	a2, 64, 56b1 <F_get_oft_32b+0x29>
    56a1:	220c           	movi.n	a2, 2
    56a3:	f01d           	retw.n

000056a5 <F_get_oft_32b+0x1d>:
    56a5:	024c           	movi.n	a2, 64
    56a7:	f01d           	retw.n

000056a9 <F_get_oft_32b+0x21>:
    56a9:	022c           	movi.n	a2, 32
    56ab:	f01d           	retw.n

000056ad <F_get_oft_32b+0x25>:
    56ad:	820c           	movi.n	a2, 8
    56af:	f01d           	retw.n

000056b1 <F_get_oft_32b+0x29>:
    56b1:	420c           	movi.n	a2, 4
    56b3:	f01d           	retw.n

000056b5 <F_get_oft_32b+0x2d>:
    56b5:	000000                                        ...

000056b8 <xtensa_fft_pass_32b>:
    56b8:	00c136        	entry	a1, 96
    56bb:	905330        	addx2	a5, a3, a3
    56be:	1143c0        	slli	a4, a3, 4
    56c1:	b05520        	addx8	a5, a5, a2
    56c4:	602244        	ae_lq32f.x	aeq0, a2, a4
    56c7:	604504        	ae_lq32f.i	aeq1, a5, 0
    56ca:	f8663a014f 	{ ae_sq56s.i	aeq0, a1, 32; ae_addq56	aeq0, aeq0, aeq1 }
    56cf:	608204        	ae_lq32f.i	aeq2, a2, 0
    56d2:	f832fa012f 	{ ae_sq56s.i	aeq0, a1, 16; ae_subq56	aeq0, aeq2, aeq0 }
    56d7:	fc4450724f 	{ add	a7, a2, a4; ae_roundsq32sym	aeq0, aeq0 }
    56dc:	631114        	ae_sq56s.i	aeq1, a1, 8
    56df:	630154        	ae_sq56s.i	aeq0, a1, 40
    56e2:	600514        	ae_lq32f.i	aeq0, a5, 4
    56e5:	604714        	ae_lq32f.i	aeq1, a7, 4
    56e8:	fa6a3a216f 	{ ae_sq56s.i	aeq2, a1, 48; ae_addq56	aeq2, aeq1, aeq0 }
    56ed:	f82acfc74e 	{ addi	a4, a7, -4; ae_subq56	aeq0, aeq1, aeq0 }
    56f2:	60c214        	ae_lq32f.i	aeq3, a2, 4
    56f5:	614154        	ae_lq56.i	aeq1, a1, 40
    56f8:	f9baf9d41f 	{ ae_sq32f.iu	aeq1, a4, 4; ae_subq56	aeq1, aeq3, aeq2 }
    56fd:	fc4c7a013f 	{ ae_sq56s.i	aeq0, a1, 24; ae_roundsq32sym	aeq0, aeq1 }
    5702:	fafa3a015f 	{ ae_sq56s.i	aeq0, a1, 40; ae_addq56	aeq2, aeq3, aeq2 }
    5707:	ff547da12f 	{ ae_lq56.i	aeq1, a1, 16; ae_roundsq32sym	aeq3, aeq2 }
    570c:	610164        	ae_lq56.i	aeq0, a1, 48
    570f:	f9663d815f 	{ ae_lq56.i	aeq0, a1, 40; ae_addq56	aeq1, aeq0, aeq1 }
    5714:	b06320        	addx8	a6, a3, a2
    5717:	fd4c4fc22e 	{ addi	a2, a2, -4; ae_roundsq32sym	aeq1, aeq1 }
    571c:	624414        	ae_sq32f.iu	aeq0, a4, 4
    571f:	625214        	ae_sq32f.iu	aeq1, a2, 4
    5722:	627214        	ae_sq32f.iu	aeq3, a2, 4
    5725:	614114        	ae_lq56.i	aeq1, a1, 8
    5728:	618144        	ae_lq56.i	aeq2, a1, 32
    572b:	f8aafd260f 	{ ae_lq32f.i	aeq1, a6, 0; ae_subq56	aeq0, aeq1, aeq2 }
    5730:	61c134        	ae_lq56.i	aeq3, a1, 24
    5733:	faaecfc55e 	{ addi	a5, a5, -4; ae_subq56	aeq2, aeq1, aeq3 }
    5738:	f9ee3d661f 	{ ae_lq32f.i	aeq3, a6, 4; ae_addq56	aeq1, aeq1, aeq3 }
    573d:	f93afa111f 	{ ae_sq56s.i	aeq1, a1, 8; ae_subq56	aeq1, aeq3, aeq0 }
    5742:	fe544fc66e 	{ addi	a6, a6, -4; ae_roundsq32sym	aeq2, aeq2 }
    5747:	f87a39e51f 	{ ae_sq32f.iu	aeq2, a5, 4; ae_addq56	aeq0, aeq3, aeq0 }
    574c:	fd4c7de11f 	{ ae_lq56.i	aeq3, a1, 8; ae_roundsq32sym	aeq1, aeq1 }
    5751:	fd5c79d51f 	{ ae_sq32f.iu	aeq1, a5, 4; ae_roundsq32sym	aeq1, aeq3 }
    5756:	eab371        	l32r	a7, 224 (5688 <F_get_oft_32b>)
    5759:	83ad           	ae_sext16	a10, a3
    575b:	fc4479d61f 	{ ae_sq32f.iu	aeq1, a6, 4; ae_roundsq32sym	aeq0, aeq0 }
    5760:	624614        	ae_sq32f.iu	aeq0, a6, 4
    5763:	0007e0        	callx8	a7
    5766:	eab071        	l32r	a7, 228 (7210 <ROOTS_512_Q16>)
    5769:	00a082        	movi	a8, 0
    576c:	119af0        	slli	a9, a10, 1
    576f:	907a70        	addx2	a7, a10, a7
    5772:	fcc772        	addi	a7, a7, -4
    5775:	458784        	ae_lp16x2f.xu	aep0, a7, a8
    5778:	218130        	srai	a8, a3, 1
    577b:	0223e6        	bgei	a3, 2, 5781 <xtensa_fft_pass_32b+0xc9>
    577e:	002e86        	j	583c <xtensa_fft_pass_32b+0x184>
    5781:	b78876        	loop	a8, 583c <xtensa_fft_pass_32b+0x184>
    5784:	604414        	ae_lq32f.i	aeq1, a4, 4
    5787:	608424        	ae_lq32f.i	aeq2, a4, 8
    578a:	30033d651f 	{ ae_lq32f.i	aeq3, a5, 4; ae_mulzaaq32sp16u.lh	aeq0, aeq1, aep0, aeq2, aep0 }
    578f:	6300bd252f 	{ ae_lq32f.i	aeq1, a5, 8; ae_mulzasq32sp16u.lh	aeq2, aeq2, aep0, aeq1, aep0 }
    5794:	630114        	ae_sq56s.i	aeq0, a1, 8
    5797:	6301ba214f 	{ ae_sq56s.i	aeq2, a1, 32; ae_mulzasq32sp16u.lh	aeq2, aeq3, aep0, aeq1, aep0 }
    579c:	3103fd811f 	{ ae_lq56.i	aeq0, a1, 8; ae_mulzaaq32sp16u.lh	aeq3, aeq1, aep0, aeq3, aep0 }
    57a1:	f8e23d221f 	{ ae_lq32f.i	aeq1, a2, 4; ae_addq56	aeq0, aeq0, aeq2 }
    57a6:	fa2afa213f 	{ ae_sq56s.i	aeq2, a1, 24; ae_subq56	aeq2, aeq1, aeq0 }
    57ab:	f86a3a212f 	{ ae_sq56s.i	aeq2, a1, 16; ae_addq56	aeq0, aeq1, aeq0 }
    57b0:	618144        	ae_lq56.i	aeq2, a1, 32
    57b3:	f8f63a015f 	{ ae_sq56s.i	aeq0, a1, 40; ae_addq56	aeq0, aeq2, aeq3 }
    57b8:	633164        	ae_sq56s.i	aeq3, a1, 48
    57bb:	61c124        	ae_lq56.i	aeq3, a1, 16
    57be:	ff5c7d222f 	{ ae_lq32f.i	aeq1, a2, 8; ae_roundsq32sym	aeq3, aeq3 }
    57c3:	fb2afa312f 	{ ae_sq56s.i	aeq3, a1, 16; ae_subq56	aeq3, aeq1, aeq0 }
    57c8:	f86a3a317f 	{ ae_sq56s.i	aeq3, a1, 56; ae_addq56	aeq0, aeq1, aeq0 }
    57cd:	fc447de12f 	{ ae_lq56.i	aeq3, a1, 16; ae_roundsq32sym	aeq0, aeq0 }
    57d2:	627414        	ae_sq32f.iu	aeq3, a4, 4
    57d5:	61c174        	ae_lq56.i	aeq3, a1, 56
    57d8:	ff5c5b879f 	{ ae_lp16x2f.xu	aep0, a7, a9; ae_roundsq32sym	aeq3, aeq3 }
    57dd:	627414        	ae_sq32f.iu	aeq3, a4, 4
    57e0:	61c154        	ae_lq56.i	aeq3, a1, 40
    57e3:	fd5c7de11f 	{ ae_lq56.i	aeq3, a1, 8; ae_roundsq32sym	aeq1, aeq3 }
    57e8:	625214        	ae_sq32f.iu	aeq1, a2, 4
    57eb:	624214        	ae_sq32f.iu	aeq0, a2, 4
    57ee:	614164        	ae_lq56.i	aeq1, a1, 48
    57f1:	f836fd261f 	{ ae_lq32f.i	aeq1, a6, 4; ae_subq56	aeq0, aeq2, aeq1 }
    57f6:	0198c4        	ae_addq56	aeq2, aeq1, aeq0
    57f9:	f82afa212f 	{ ae_sq56s.i	aeq2, a1, 16; ae_subq56	aeq0, aeq1, aeq0 }
    57fe:	fc447dc13f 	{ ae_lq56.i	aeq2, a1, 24; ae_roundsq32sym	aeq0, aeq0 }
    5803:	fbb6fdc12f 	{ ae_lq56.i	aeq2, a1, 16; ae_subq56	aeq3, aeq2, aeq3 }
    5808:	fe547a314f 	{ ae_sq56s.i	aeq3, a1, 32; ae_roundsq32sym	aeq2, aeq2 }
    580d:	632114        	ae_sq56s.i	aeq2, a1, 8
    5810:	608624        	ae_lq32f.i	aeq2, a6, 8
    5813:	01ebc4        	ae_addq56	aeq3, aeq2, aeq3
    5816:	633134        	ae_sq56s.i	aeq3, a1, 24
    5819:	61c114        	ae_lq56.i	aeq3, a1, 8
    581c:	627614        	ae_sq32f.iu	aeq3, a6, 4
    581f:	61c134        	ae_lq56.i	aeq3, a1, 24
    5822:	06f834        	ae_roundsq32sym	aeq3, aeq3
    5825:	633114        	ae_sq56s.i	aeq3, a1, 8
    5828:	61c114        	ae_lq56.i	aeq3, a1, 8
    582b:	627614        	ae_sq32f.iu	aeq3, a6, 4
    582e:	61c144        	ae_lq56.i	aeq3, a1, 32
    5831:	f9b6f9c51f 	{ ae_sq32f.iu	aeq0, a5, 4; ae_subq56	aeq1, aeq2, aeq3 }
    5836:	06d834        	ae_roundsq32sym	aeq3, aeq1
    5839:	627514        	ae_sq32f.iu	aeq3, a5, 4

0000583c <xtensa_fft_pass_32b+0x184>:
    583c:	0243e6        	bgei	a3, 4, 5842 <xtensa_fft_pass_32b+0x18a>
    583f:	003146        	j	5908 <xtensa_fft_pass_32b+0x250>
    5842:	603090        	neg	a3, a9
    5845:	1193f0        	slli	a9, a3, 1
    5848:	880b           	addi.n	a8, a8, -1
    584a:	458794        	ae_lp16x2f.xu	aep0, a7, a9
    584d:	b78876        	loop	a8, 5908 <xtensa_fft_pass_32b+0x250>
    5850:	604424        	ae_lq32f.i	aeq1, a4, 8
    5853:	608414        	ae_lq32f.i	aeq2, a4, 4
    5856:	30033d652f 	{ ae_lq32f.i	aeq3, a5, 8; ae_mulzaaq32sp16u.lh	aeq0, aeq1, aep0, aeq2, aep0 }
    585b:	9300bd251f 	{ ae_lq32f.i	aeq1, a5, 4; ae_mulzsaq32sp16u.lh	aeq2, aeq2, aep0, aeq1, aep0 }
    5860:	630114        	ae_sq56s.i	aeq0, a1, 8
    5863:	9301ba214f 	{ ae_sq56s.i	aeq2, a1, 32; ae_mulzsaq32sp16u.lh	aeq2, aeq3, aep0, aeq1, aep0 }
    5868:	3103fd811f 	{ ae_lq56.i	aeq0, a1, 8; ae_mulzaaq32sp16u.lh	aeq3, aeq1, aep0, aeq3, aep0 }
    586d:	f8e23d221f 	{ ae_lq32f.i	aeq1, a2, 4; ae_addq56	aeq0, aeq0, aeq2 }
    5872:	fa2afa213f 	{ ae_sq56s.i	aeq2, a1, 24; ae_subq56	aeq2, aeq1, aeq0 }
    5877:	f86a3a212f 	{ ae_sq56s.i	aeq2, a1, 16; ae_addq56	aeq0, aeq1, aeq0 }
    587c:	618144        	ae_lq56.i	aeq2, a1, 32
    587f:	f8f63a015f 	{ ae_sq56s.i	aeq0, a1, 40; ae_addq56	aeq0, aeq2, aeq3 }
    5884:	633164        	ae_sq56s.i	aeq3, a1, 48
    5887:	61c124        	ae_lq56.i	aeq3, a1, 16
    588a:	ff5c7d222f 	{ ae_lq32f.i	aeq1, a2, 8; ae_roundsq32sym	aeq3, aeq3 }
    588f:	fb2afa312f 	{ ae_sq56s.i	aeq3, a1, 16; ae_subq56	aeq3, aeq1, aeq0 }
    5894:	f86a3a317f 	{ ae_sq56s.i	aeq3, a1, 56; ae_addq56	aeq0, aeq1, aeq0 }
    5899:	fc447de12f 	{ ae_lq56.i	aeq3, a1, 16; ae_roundsq32sym	aeq0, aeq0 }
    589e:	627414        	ae_sq32f.iu	aeq3, a4, 4
    58a1:	61c174        	ae_lq56.i	aeq3, a1, 56
    58a4:	ff5c5b873f 	{ ae_lp16x2f.xu	aep0, a7, a3; ae_roundsq32sym	aeq3, aeq3 }
    58a9:	627414        	ae_sq32f.iu	aeq3, a4, 4
    58ac:	61c154        	ae_lq56.i	aeq3, a1, 40
    58af:	fd5c7de11f 	{ ae_lq56.i	aeq3, a1, 8; ae_roundsq32sym	aeq1, aeq3 }
    58b4:	625214        	ae_sq32f.iu	aeq1, a2, 4
    58b7:	624214        	ae_sq32f.iu	aeq0, a2, 4
    58ba:	614164        	ae_lq56.i	aeq1, a1, 48
    58bd:	f836fd261f 	{ ae_lq32f.i	aeq1, a6, 4; ae_subq56	aeq0, aeq2, aeq1 }
    58c2:	0198c4        	ae_addq56	aeq2, aeq1, aeq0
    58c5:	f82afa212f 	{ ae_sq56s.i	aeq2, a1, 16; ae_subq56	aeq0, aeq1, aeq0 }
    58ca:	fc447dc13f 	{ ae_lq56.i	aeq2, a1, 24; ae_roundsq32sym	aeq0, aeq0 }
    58cf:	fbb6fdc12f 	{ ae_lq56.i	aeq2, a1, 16; ae_subq56	aeq3, aeq2, aeq3 }
    58d4:	fe547a314f 	{ ae_sq56s.i	aeq3, a1, 32; ae_roundsq32sym	aeq2, aeq2 }
    58d9:	632114        	ae_sq56s.i	aeq2, a1, 8
    58dc:	608624        	ae_lq32f.i	aeq2, a6, 8
    58df:	01ebc4        	ae_addq56	aeq3, aeq2, aeq3
    58e2:	633134        	ae_sq56s.i	aeq3, a1, 24
    58e5:	61c114        	ae_lq56.i	aeq3, a1, 8
    58e8:	627614        	ae_sq32f.iu	aeq3, a6, 4
    58eb:	61c134        	ae_lq56.i	aeq3, a1, 24
    58ee:	06f834        	ae_roundsq32sym	aeq3, aeq3
    58f1:	633114        	ae_sq56s.i	aeq3, a1, 8
    58f4:	61c114        	ae_lq56.i	aeq3, a1, 8
    58f7:	627614        	ae_sq32f.iu	aeq3, a6, 4
    58fa:	61c144        	ae_lq56.i	aeq3, a1, 32
    58fd:	f9b6f9c51f 	{ ae_sq32f.iu	aeq0, a5, 4; ae_subq56	aeq1, aeq2, aeq3 }
    5902:	06d834        	ae_roundsq32sym	aeq3, aeq1
    5905:	627514        	ae_sq32f.iu	aeq3, a5, 4
    5908:	f01d           	retw.n

0000590a <xtensa_fft_pass_32b+0x252>:
	...

0000590c <xtensa_fft16_32b>:
    590c:	004136        	entry	a1, 32
    590f:	ea4731        	l32r	a3, 22c (53e4 <xtensa_fft8_32b>)
    5912:	02ad           	mov.n	a10, a2
    5914:	0003e0        	callx8	a3
    5917:	ea4631        	l32r	a3, 230 (5348 <xtensa_fft4_32b>)
    591a:	40c2a2        	addi	a10, a2, 64
    591d:	0003e0        	callx8	a3
    5920:	60c2a2        	addi	a10, a2, 96
    5923:	0003e0        	callx8	a3
    5926:	ea4331        	l32r	a3, 234 (56b8 <xtensa_fft_pass_32b>)
    5929:	4b0c           	movi.n	a11, 4
    592b:	02ad           	mov.n	a10, a2
    592d:	0003e0        	callx8	a3
    5930:	f01d           	retw.n

00005932 <xtensa_fft16_32b+0x26>:
	...

00005934 <xtensa_fft32_32b>:
    5934:	004136        	entry	a1, 32
    5937:	ea4031        	l32r	a3, 238 (590c <xtensa_fft16_32b>)
    593a:	02ad           	mov.n	a10, a2
    593c:	0003e0        	callx8	a3
    593f:	80a032        	movi	a3, 128
    5942:	a23a           	add.n	a10, a2, a3
    5944:	ea3a31        	l32r	a3, 22c (53e4 <xtensa_fft8_32b>)
    5947:	0003e0        	callx8	a3
    594a:	c0a042        	movi	a4, 192
    594d:	a24a           	add.n	a10, a2, a4
    594f:	0003e0        	callx8	a3
    5952:	ea3831        	l32r	a3, 234 (56b8 <xtensa_fft_pass_32b>)
    5955:	8b0c           	movi.n	a11, 8
    5957:	02ad           	mov.n	a10, a2
    5959:	0003e0        	callx8	a3
    595c:	f01d           	retw.n

0000595e <xtensa_fft32_32b+0x2a>:
	...

00005960 <xtensa_fft64_32b>:
    5960:	004136        	entry	a1, 32
    5963:	ea3631        	l32r	a3, 23c (5934 <xtensa_fft32_32b>)
    5966:	02ad           	mov.n	a10, a2
    5968:	0003e0        	callx8	a3
    596b:	ea3331        	l32r	a3, 238 (590c <xtensa_fft16_32b>)
    596e:	01d2a2        	addmi	a10, a2, 0x100
    5971:	0003e0        	callx8	a3
    5974:	80a142        	movi	a4, 0x180
    5977:	a24a           	add.n	a10, a2, a4
    5979:	0003e0        	callx8	a3
    597c:	ea2e31        	l32r	a3, 234 (56b8 <xtensa_fft_pass_32b>)
    597f:	0b1c           	movi.n	a11, 16
    5981:	02ad           	mov.n	a10, a2
    5983:	0003e0        	callx8	a3
    5986:	f01d           	retw.n

00005988 <xtensa_fft128_32b>:
    5988:	004136        	entry	a1, 32
    598b:	ea2d31        	l32r	a3, 240 (5960 <xtensa_fft64_32b>)
    598e:	02ad           	mov.n	a10, a2
    5990:	0003e0        	callx8	a3
    5993:	ea2a31        	l32r	a3, 23c (5934 <xtensa_fft32_32b>)
    5996:	02d2a2        	addmi	a10, a2, 0x200
    5999:	0003e0        	callx8	a3
    599c:	03d2a2        	addmi	a10, a2, 0x300
    599f:	0003e0        	callx8	a3
    59a2:	ea2431        	l32r	a3, 234 (56b8 <xtensa_fft_pass_32b>)
    59a5:	0b2c           	movi.n	a11, 32
    59a7:	02ad           	mov.n	a10, a2
    59a9:	0003e0        	callx8	a3
    59ac:	f01d           	retw.n

000059ae <xtensa_fft128_32b+0x26>:
	...

000059b0 <xtensa_fft256_32b>:
    59b0:	004136        	entry	a1, 32
    59b3:	ea2331        	l32r	a3, 240 (5960 <xtensa_fft64_32b>)
    59b6:	02ad           	mov.n	a10, a2
    59b8:	0003e0        	callx8	a3
    59bb:	ea2041        	l32r	a4, 23c (5934 <xtensa_fft32_32b>)
    59be:	02d2a2        	addmi	a10, a2, 0x200
    59c1:	0004e0        	callx8	a4
    59c4:	03d2a2        	addmi	a10, a2, 0x300
    59c7:	0004e0        	callx8	a4
    59ca:	ea1a41        	l32r	a4, 234 (56b8 <xtensa_fft_pass_32b>)
    59cd:	0b2c           	movi.n	a11, 32
    59cf:	02ad           	mov.n	a10, a2
    59d1:	0004e0        	callx8	a4
    59d4:	04d2a2        	addmi	a10, a2, 0x400
    59d7:	0003e0        	callx8	a3
    59da:	06d2a2        	addmi	a10, a2, 0x600
    59dd:	0003e0        	callx8	a3
    59e0:	0b4c           	movi.n	a11, 64
    59e2:	02ad           	mov.n	a10, a2
    59e4:	0004e0        	callx8	a4
    59e7:	f01d           	retw.n

000059e9 <xtensa_fft256_32b+0x39>:
    59e9:	000000                                        ...

000059ec <xtensa_fft512_32b>:
    59ec:	004136        	entry	a1, 32
    59ef:	ea1531        	l32r	a3, 244 (59b0 <xtensa_fft256_32b>)
    59f2:	02ad           	mov.n	a10, a2
    59f4:	0003e0        	callx8	a3
    59f7:	ea1431        	l32r	a3, 248 (5988 <xtensa_fft128_32b>)
    59fa:	08d2a2        	addmi	a10, a2, 0x800
    59fd:	0003e0        	callx8	a3
    5a00:	0cd2a2        	addmi	a10, a2, 0xc00
    5a03:	0003e0        	callx8	a3
    5a06:	ea0b31        	l32r	a3, 234 (56b8 <xtensa_fft_pass_32b>)
    5a09:	80a0b2        	movi	a11, 128
    5a0c:	02ad           	mov.n	a10, a2
    5a0e:	0003e0        	callx8	a3
    5a11:	f01d           	retw.n

00005a13 <xtensa_fft512_32b+0x27>:
	...

00005a14 <real_split>:
    5a14:	00a136        	entry	a1, 80
    5a17:	216120        	srai	a6, a2, 1
    5a1a:	050c           	movi.n	a5, 0
    5a1c:	1388           	l32i.n	a8, a3, 4
    5a1e:	0378           	l32i.n	a7, a3, 0
    5a20:	c0c260        	sub	a12, a2, a6
    5a23:	1459           	s32i.n	a5, a4, 4
    5a25:	b05c30        	addx8	a5, a12, a3
    5a28:	15e8           	l32i.n	a14, a5, 4
    5a2a:	787a           	add.n	a7, a8, a7
    5a2c:	0479           	s32i.n	a7, a4, 0
    5a2e:	b0d640        	addx8	a13, a6, a4
    5a31:	0558           	l32i.n	a5, a5, 0
    5a33:	11fef0        	slli	a15, a14, 1
    5a36:	0d59           	s32i.n	a5, a13, 0
    5a38:	6050f0        	neg	a5, a15
    5a3b:	215150        	srai	a5, a5, 1
    5a3e:	1d59           	s32i.n	a5, a13, 4
    5a40:	e9f951        	l32r	a5, 224 (5688 <F_get_oft_32b>)
    5a43:	82ad           	ae_sext16	a10, a2
    5a45:	b169           	s32i.n	a6, a1, 44
    5a47:	0005e0        	callx8	a5
    5a4a:	81a072        	movi	a7, 129
    5a4d:	727270        	salt	a7, a2, a7
    5a50:	401700        	ssl	a7
    5a53:	a17a00        	sll	a7, a10
    5a56:	fec782        	addi	a8, a7, -2
    5a59:	e9f351        	l32r	a5, 228 (7210 <ROOTS_512_Q16>)
    5a5c:	11b8f0        	slli	a11, a8, 1
    5a5f:	41b2b0        	srli	a11, a11, 2
    5a62:	7fa092        	movi	a9, 127
    5a65:	a0bb50        	addx4	a11, a11, a5
    5a68:	729970        	salt	a9, a9, a7
    5a6b:	60a070        	neg	a10, a7
    5a6e:	441b04        	ae_lp16x2f.i	aep1, a11, 0
    5a71:	02e7e6        	bgei	a7, 128, 5a77 <real_split+0x63>
    5a74:	1a9194        	ae_selp24.lh	aep1, aep1, aep1

00005a77 <real_split+0x63>:
    5a77:	160c           	movi.n	a6, 1
    5a79:	116610        	slli	a6, a6, 15
    5a7c:	300664        	ae_cvtp24a16x2.ll	aep0, a6, a6
    5a7f:	937a90        	movnez	a7, a10, a9
    5a82:	0242e6        	bgei	a2, 4, 5a88 <real_split+0x74>
    5a85:	002446        	j	5b1a <real_split+0x106>
    5a88:	b168           	l32i.n	a6, a1, 44
    5a8a:	b0b230        	addx8	a11, a2, a3
    5a8d:	14c3e2        	addi	a14, a3, 20
    5a90:	f60b           	addi.n	a15, a6, -1
    5a92:	fccbd2        	addi	a13, a11, -4
    5a95:	c48b           	addi.n	a12, a4, 8
    5a97:	60c334        	ae_lq32f.i	aeq3, a3, 12
    5a9a:	604324        	ae_lq32f.i	aeq1, a3, 8
    5a9d:	9027807daf 	{ movi	a10, 125; ae_mulzsaq32sp16u.lh	aeq0, aeq1, aep1, aeq3, aep1 }
    5aa2:	f8ceb2        	addi	a11, a14, -8
    5aa5:	718f76        	loop	a15, 5b1a <real_split+0x106>
    5aa8:	608df4        	ae_lq32f.i	aeq2, a13, -4
    5aab:	887a           	add.n	a8, a8, a7
    5aad:	c225ba014f 	{ ae_sq56s.i	aeq0, a1, 32; ae_mulzssq32sp16u.lh	aeq0, aeq3, aep1, aeq1, aep1 }
    5ab2:	c30864        	ae_mulzaafq32sp16u.lh	aeq1, aeq1, aep0, aeq2, aep0
    5ab5:	630114        	ae_sq56s.i	aeq0, a1, 8
    5ab8:	600d04        	ae_lq32f.i	aeq0, a13, 0
    5abb:	32247a113f 	{ ae_sq56s.i	aeq1, a1, 24; ae_mulzaaq32sp16u.lh	aeq1, aeq2, aep1, aeq0, aep1 }
    5ac0:	4b014fcdde 	{ addi	a13, a13, -4; ae_mulzasfq32sp16u.lh	aeq3, aeq3, aep0, aeq0, aep0 }
    5ac5:	90263dc11f 	{ ae_lq56.i	aeq2, a1, 8; ae_mulzsaq32sp16u.lh	aeq0, aeq0, aep1, aeq2, aep1 }
    5aca:	fafa3a112f 	{ ae_sq56s.i	aeq1, a1, 16; ae_addq56	aeq2, aeq3, aeq2 }
    5acf:	f8723de14f 	{ ae_lq56.i	aeq3, a1, 32; ae_addq56	aeq0, aeq2, aeq0 }
    5ad4:	614134        	ae_lq56.i	aeq1, a1, 24
    5ad7:	fbee3da12f 	{ ae_lq56.i	aeq1, a1, 16; ae_addq56	aeq3, aeq1, aeq3 }
    5adc:	f97e3b001f 	{ ae_sraiq56	aeq0, aeq0, 1; ae_addq56	aeq1, aeq3, aeq1 }
    5ae1:	1168f0        	slli	a6, a8, 1
    5ae4:	fc447b105f 	{ ae_sraiq56	aeq1, aeq1, 1; ae_roundsq32sym	aeq0, aeq0 }
    5ae9:	416260        	srli	a6, a6, 2
    5aec:	72fa80        	salt	a15, a10, a8
    5aef:	fd4c798c1f 	{ ae_sq32f.i	aeq0, a12, 4; ae_roundsq32sym	aeq1, aeq1 }
    5af4:	a06650        	addx4	a6, a6, a5
    5af7:	3099f0        	xor	a9, a9, a15
    5afa:	621c04        	ae_sq32f.i	aeq1, a12, 0
    5afd:	cc4b           	addi.n	a12, a12, 4
    5aff:	60e070        	neg	a14, a7
    5b02:	441604        	ae_lp16x2f.i	aep1, a6, 0
    5b05:	19cc           	bnez.n	a9, 5b0a <real_split+0xf6>
    5b07:	1a9194        	ae_selp24.lh	aep1, aep1, aep1
    5b0a:	604b14        	ae_lq32f.i	aeq1, a11, 4
    5b0d:	937ef0        	movnez	a7, a14, a15
    5b10:	60db24        	ae_lq32f.iu	aeq3, a11, 8
    5b13:	90278fcdde 	{ addi	a13, a13, -4; ae_mulzsaq32sp16u.lh	aeq0, aeq1, aep1, aeq3, aep1 }
    5b18:	cc4b           	addi.n	a12, a12, 4

00005b1a <real_split+0x106>:
    5b1a:	b168           	l32i.n	a6, a1, 44
    5b1c:	ef7c           	movi.n	a15, -2
    5b1e:	c08f70        	sub	a8, a15, a7
    5b21:	b61b           	addi.n	a11, a6, 1
    5b23:	1168f0        	slli	a6, a8, 1
    5b26:	7da0a2        	movi	a10, 125
    5b29:	416260        	srli	a6, a6, 2
    5b2c:	72ca80        	salt	a12, a10, a8
    5b2f:	a06650        	addx4	a6, a6, a5
    5b32:	3099c0        	xor	a9, a9, a12
    5b35:	441604        	ae_lp16x2f.i	aep1, a6, 0
    5b38:	498c           	beqz.n	a9, 5b40 <real_split+0x12c>
    5b3a:	0b2b27        	blt	a11, a2, 5b49 <real_split+0x135>
    5b3d:	002b86        	j	5bef <real_split+0x1db>

00005b40 <real_split+0x12c>:
    5b40:	1a9194        	ae_selp24.lh	aep1, aep1, aep1
    5b43:	022b27        	blt	a11, a2, 5b49 <real_split+0x135>
    5b46:	002946        	j	5bef <real_split+0x1db>
    5b49:	b1f8           	l32i.n	a15, a1, 44
    5b4b:	60a070        	neg	a10, a7
    5b4e:	93a7c0        	movnez	a10, a7, a12
    5b51:	f77c           	movi.n	a7, -1
    5b53:	b0ef30        	addx8	a14, a15, a3
    5b56:	307f70        	xor	a7, a15, a7
    5b59:	c062b0        	sub	a6, a2, a11
    5b5c:	b0db30        	addx8	a13, a11, a3
    5b5f:	b0c630        	addx8	a12, a6, a3
    5b62:	14cee2        	addi	a14, a14, 20
    5b65:	772a           	add.n	a7, a7, a2
    5b67:	b0bb40        	addx8	a11, a11, a4
    5b6a:	7da042        	movi	a4, 125
    5b6d:	60cd14        	ae_lq32f.i	aeq3, a13, 4
    5b70:	604d04        	ae_lq32f.i	aeq1, a13, 0
    5b73:	3c4b           	addi.n	a3, a12, 4
    5b75:	c0278f8e2e 	{ addi	a2, a14, -8; ae_mulzssq32sp16u.lh	aeq0, aeq1, aep1, aeq3, aep1 }
    5b7a:	718776        	loop	a7, 5bef <real_split+0x1db>
    5b7d:	6083f4        	ae_lq32f.i	aeq2, a3, -4
    5b80:	88aa           	add.n	a8, a8, a10
    5b82:	9225ba014f 	{ ae_sq56s.i	aeq0, a1, 32; ae_mulzsaq32sp16u.lh	aeq0, aeq3, aep1, aeq1, aep1 }
    5b87:	1803404b6e 	{ addi	a6, a11, 4; ae_mulzaafq32sp16u.lh	aeq1, aeq1, aep0, aeq2, aep0 }
    5b8c:	630114        	ae_sq56s.i	aeq0, a1, 8
    5b8f:	600304        	ae_lq32f.i	aeq0, a3, 0
    5b92:	62247a113f 	{ ae_sq56s.i	aeq1, a1, 24; ae_mulzasq32sp16u.lh	aeq1, aeq2, aep1, aeq0, aep1 }
    5b97:	4b014fc33e 	{ addi	a3, a3, -4; ae_mulzasfq32sp16u.lh	aeq3, aeq3, aep0, aeq0, aep0 }
    5b9c:	c0263dc11f 	{ ae_lq56.i	aeq2, a1, 8; ae_mulzssq32sp16u.lh	aeq0, aeq0, aep1, aeq2, aep1 }
    5ba1:	fafa3a112f 	{ ae_sq56s.i	aeq1, a1, 16; ae_addq56	aeq2, aeq3, aeq2 }
    5ba6:	f8723de14f 	{ ae_lq56.i	aeq3, a1, 32; ae_addq56	aeq0, aeq2, aeq0 }
    5bab:	614134        	ae_lq56.i	aeq1, a1, 24
    5bae:	fbee3da12f 	{ ae_lq56.i	aeq1, a1, 16; ae_addq56	aeq3, aeq1, aeq3 }
    5bb3:	f97e3b001f 	{ ae_sraiq56	aeq0, aeq0, 1; ae_addq56	aeq1, aeq3, aeq1 }
    5bb8:	fc447b105f 	{ ae_sraiq56	aeq1, aeq1, 1; ae_roundsq32sym	aeq0, aeq0 }
    5bbd:	11c8f0        	slli	a12, a8, 1
    5bc0:	fd4c798b1f 	{ ae_sq32f.i	aeq0, a11, 4; ae_roundsq32sym	aeq1, aeq1 }
    5bc5:	41c2c0        	srli	a12, a12, 2
    5bc8:	621b04        	ae_sq32f.i	aeq1, a11, 0
    5bcb:	72b480        	salt	a11, a4, a8
    5bce:	a0cc50        	addx4	a12, a12, a5
    5bd1:	3099b0        	xor	a9, a9, a11
    5bd4:	6070a0        	neg	a7, a10
    5bd7:	441c04        	ae_lp16x2f.i	aep1, a12, 0
    5bda:	19cc           	bnez.n	a9, 5bdf <real_split+0x1cb>
    5bdc:	1a9194        	ae_selp24.lh	aep1, aep1, aep1
    5bdf:	93a7b0        	movnez	a10, a7, a11
    5be2:	604214        	ae_lq32f.i	aeq1, a2, 4
    5be5:	60d224        	ae_lq32f.iu	aeq3, a2, 8
    5be8:	c0278fc33e 	{ addi	a3, a3, -4; ae_mulzssq32sp16u.lh	aeq0, aeq1, aep1, aeq3, aep1 }
    5bed:	b64b           	addi.n	a11, a6, 4

00005bef <real_split+0x1db>:
    5bef:	f01d           	retw.n

00005bf1 <real_split+0x1dd>:
    5bf1:	000000                                        ...

00005bf4 <xtensa_real_fft_32b>:
    5bf4:	004136        	entry	a1, 32
    5bf7:	1142d0        	slli	a4, a2, 3
    5bfa:	c04340        	sub	a4, a3, a4
    5bfd:	0be2e6        	bgei	a2, 128, 5c0c <xtensa_real_fft_32b+0x18>
    5c00:	148226        	beqi	a2, 8, 5c18 <xtensa_real_fft_32b+0x24>
    5c03:	1fd266        	bnei	a2, 64, 5c26 <xtensa_real_fft_32b+0x32>
    5c06:	e98e51        	l32r	a5, 240 (5960 <xtensa_fft64_32b>)
    5c09:	000506        	j	5c21 <xtensa_real_fft_32b+0x2d>

00005c0c <xtensa_real_fft_32b+0x18>:
    5c0c:	0ee226        	beqi	a2, 128, 5c1e <xtensa_real_fft_32b+0x2a>
    5c0f:	13f266        	bnei	a2, 0x100, 5c26 <xtensa_real_fft_32b+0x32>
    5c12:	e98c51        	l32r	a5, 244 (59b0 <xtensa_fft256_32b>)
    5c15:	000206        	j	5c21 <xtensa_real_fft_32b+0x2d>

00005c18 <xtensa_real_fft_32b+0x24>:
    5c18:	e98551        	l32r	a5, 22c (53e4 <xtensa_fft8_32b>)
    5c1b:	000086        	j	5c21 <xtensa_real_fft_32b+0x2d>

00005c1e <xtensa_real_fft_32b+0x2a>:
    5c1e:	e98a51        	l32r	a5, 248 (5988 <xtensa_fft128_32b>)
    5c21:	03ad           	mov.n	a10, a3
    5c23:	0005e0        	callx8	a5
    5c26:	e98951        	l32r	a5, 24c (5a14 <real_split>)
    5c29:	02ad           	mov.n	a10, a2
    5c2b:	03bd           	mov.n	a11, a3
    5c2d:	04cd           	mov.n	a12, a4
    5c2f:	0005e0        	callx8	a5
    5c32:	0358           	l32i.n	a5, a3, 0
    5c34:	1368           	l32i.n	a6, a3, 4
    5c36:	070c           	movi.n	a7, 0
    5c38:	1379           	s32i.n	a7, a3, 4
    5c3a:	c05560        	sub	a5, a5, a6
    5c3d:	0359           	s32i.n	a5, a3, 0
    5c3f:	1922a6        	blti	a2, 2, 5c5c <xtensa_real_fft_32b+0x68>
    5c42:	520b           	addi.n	a5, a2, -1
    5c44:	448b           	addi.n	a4, a4, 8
    5c46:	b02530        	addx8	a2, a5, a3
    5c49:	0f8576        	loop	a5, 5c5c <xtensa_real_fft_32b+0x68>
    5c4c:	1438           	l32i.n	a3, a4, 4
    5c4e:	0458           	l32i.n	a5, a4, 0
    5c50:	448b           	addi.n	a4, a4, 8
    5c52:	603030        	neg	a3, a3
    5c55:	0259           	s32i.n	a5, a2, 0
    5c57:	1239           	s32i.n	a3, a2, 4
    5c59:	f8c222        	addi	a2, a2, -8

00005c5c <xtensa_real_fft_32b+0x68>:
    5c5c:	f01d           	retw.n

00005c5e <xtensa_real_fft_32b+0x6a>:
	...

00005c60 <xtensa_comp_fft_32b>:
    5c60:	004136        	entry	a1, 32
    5c63:	0bf2e6        	bgei	a2, 0x100, 5c72 <xtensa_comp_fft_32b+0x12>
    5c66:	17b226        	beqi	a2, 16, 5c81 <xtensa_comp_fft_32b+0x21>
    5c69:	22e266        	bnei	a2, 128, 5c8f <xtensa_comp_fft_32b+0x2f>
    5c6c:	e97721        	l32r	a2, 248 (5988 <xtensa_fft128_32b>)
    5c6f:	0005c6        	j	5c8a <xtensa_comp_fft_32b+0x2a>

00005c72 <xtensa_comp_fft_32b+0x12>:
    5c72:	11f226        	beqi	a2, 0x100, 5c87 <xtensa_comp_fft_32b+0x27>
    5c75:	00a242        	movi	a4, 0x200
    5c78:	139247        	bne	a2, a4, 5c8f <xtensa_comp_fft_32b+0x2f>
    5c7b:	e97521        	l32r	a2, 250 (59ec <xtensa_fft512_32b>)
    5c7e:	000206        	j	5c8a <xtensa_comp_fft_32b+0x2a>

00005c81 <xtensa_comp_fft_32b+0x21>:
    5c81:	e96d21        	l32r	a2, 238 (590c <xtensa_fft16_32b>)
    5c84:	000086        	j	5c8a <xtensa_comp_fft_32b+0x2a>

00005c87 <xtensa_comp_fft_32b+0x27>:
    5c87:	e96f21        	l32r	a2, 244 (59b0 <xtensa_fft256_32b>)
    5c8a:	03ad           	mov.n	a10, a3
    5c8c:	0002e0        	callx8	a2
    5c8f:	f01d           	retw.n

00005c91 <xtensa_comp_fft_32b+0x31>:
    5c91:	000000                                        ...

00005c94 <sw_fft_32b_2811>:
    5c94:	006136        	entry	a1, 48
    5c97:	0d1666        	bnei	a6, 1, 5ca8 <sw_fft_32b_2811+0x14>
    5c9a:	176c           	movi.n	a7, -31
    5c9c:	f47070        	extui	a7, a7, 0, 16
    5c9f:	12f3e6        	bgei	a3, 0x100, 5cb5 <sw_fft_32b_2811+0x21>
    5ca2:	2fb366        	bnei	a3, 16, 5cd5 <sw_fft_32b_2811+0x41>
    5ca5:	000c86        	j	5cdb <sw_fft_32b_2811+0x47>

00005ca8 <sw_fft_32b_2811+0x14>:
    5ca8:	569c           	beqz.n	a6, 5cc1 <sw_fft_32b_2811+0x2d>
    5caa:	1173f0        	slli	a7, a3, 1
    5cad:	039d           	mov.n	a9, a3
    5caf:	2d13e6        	bgei	a3, 1, 5ce0 <sw_fft_32b_2811+0x4c>
    5cb2:	001506        	j	5d0a <sw_fft_32b_2811+0x76>

00005cb5 <sw_fft_32b_2811+0x21>:
    5cb5:	22f326        	beqi	a3, 0x100, 5cdb <sw_fft_32b_2811+0x47>
    5cb8:	00a282        	movi	a8, 0x200
    5cbb:	1c1387        	beq	a3, a8, 5cdb <sw_fft_32b_2811+0x47>
    5cbe:	002846        	j	5d63 <sw_fft_32b_2811+0xcf>

00005cc1 <sw_fft_32b_2811+0x2d>:
    5cc1:	176c           	movi.n	a7, -31
    5cc3:	f47070        	extui	a7, a7, 0, 16
    5cc6:	08e3e6        	bgei	a3, 128, 5cd2 <sw_fft_32b_2811+0x3e>
    5cc9:	0e8326        	beqi	a3, 8, 5cdb <sw_fft_32b_2811+0x47>
    5ccc:	0bd326        	beqi	a3, 64, 5cdb <sw_fft_32b_2811+0x47>
    5ccf:	002406        	j	5d63 <sw_fft_32b_2811+0xcf>

00005cd2 <sw_fft_32b_2811+0x3e>:
    5cd2:	05f326        	beqi	a3, 0x100, 5cdb <sw_fft_32b_2811+0x47>
    5cd5:	02e326        	beqi	a3, 128, 5cdb <sw_fft_32b_2811+0x47>
    5cd8:	0021c6        	j	5d63 <sw_fft_32b_2811+0xcf>
    5cdb:	939d           	ae_zext16	a9, a3
    5cdd:	1179f0        	slli	a7, a9, 1
    5ce0:	600204        	ae_lq32f.i	aeq0, a2, 0
    5ce3:	028d           	mov.n	a8, a2
    5ce5:	088776        	loop	a7, 5cf1 <sw_fft_32b_2811+0x5d>
    5ce8:	3404b4        	ae_sraaq56	aeq0, aeq0, a4
    5ceb:	620804        	ae_sq32f.i	aeq0, a8, 0
    5cee:	601814        	ae_lq32f.iu	aeq0, a8, 4

00005cf1 <sw_fft_32b_2811+0x5d>:
    5cf1:	151666        	bnei	a6, 1, 5d0a <sw_fft_32b_2811+0x76>
    5cf4:	e95861        	l32r	a6, 254 (5c60 <xtensa_comp_fft_32b>)
    5cf7:	03ad           	mov.n	a10, a3
    5cf9:	02bd           	mov.n	a11, a2
    5cfb:	3129           	s32i.n	a2, a1, 12
    5cfd:	0006e0        	callx8	a6
    5d00:	030c           	movi.n	a3, 0
    5d02:	1d1526        	beqi	a5, 1, 5d23 <sw_fft_32b_2811+0x8f>
    5d05:	001606        	j	5d61 <sw_fft_32b_2811+0xcd>

00005d08 <sw_fft_32b_2811+0x74>:
	...

00005d0a <sw_fft_32b_2811+0x76>:
    5d0a:	e95361        	l32r	a6, 258 (5bf4 <xtensa_real_fft_32b>)
    5d0d:	03ad           	mov.n	a10, a3
    5d0f:	02bd           	mov.n	a11, a2
    5d11:	3129           	s32i.n	a2, a1, 12
    5d13:	092d           	mov.n	a2, a9
    5d15:	0006e0        	callx8	a6
    5d18:	11f2e0        	slli	a15, a2, 2
    5d1b:	603070        	neg	a3, a7
    5d1e:	0f7d           	mov.n	a7, a15
    5d20:	3d1566        	bnei	a5, 1, 5d61 <sw_fft_32b_2811+0xcd>
    5d23:	3128           	l32i.n	a2, a1, 12
    5d25:	a02320        	addx4	a2, a3, a2
    5d28:	fd24bd020f 	{ ae_lq32f.i	aeq0, a2, 0; ae_zeroq56	aeq1 }
    5d2d:	0f17a6        	blti	a7, 1, 5d40 <sw_fft_32b_2811+0xac>
    5d30:	fe0453322f 	{ or	a3, a2, a2; ae_movq56	aeq2, aeq0 }
    5d35:	078776        	loop	a7, 5d40 <sw_fft_32b_2811+0xac>
    5d38:	ff80bd531f 	{ ae_lq32f.iu	aeq2, a3, 4; ae_absq56	aeq3, aeq2 }
    5d3d:	0179e4        	ae_orq56	aeq1, aeq1, aeq3

00005d40 <sw_fft_32b_2811+0xac>:
    5d40:	621124        	ae_sq32f.i	aeq1, a1, 8
    5d43:	2158           	l32i.n	a5, a1, 8
    5d45:	030c           	movi.n	a3, 0
    5d47:	40e560        	nsa	a6, a5
    5d4a:	b33650        	movgez	a3, a6, a5
    5d4d:	0d17a6        	blti	a7, 1, 5d5e <sw_fft_32b_2811+0xca>
    5d50:	0a8776        	loop	a7, 5d5e <sw_fft_32b_2811+0xca>
    5d53:	fc24fe830f 	{ ae_slaasq56s	aeq0, aeq0, a3; nop }
    5d58:	620204        	ae_sq32f.i	aeq0, a2, 0
    5d5b:	601214        	ae_lq32f.iu	aeq0, a2, 4
    5d5e:	c04430        	sub	a4, a4, a3

00005d61 <sw_fft_32b_2811+0xcd>:
    5d61:	047d           	mov.n	a7, a4
    5d63:	872d           	ae_sext16	a2, a7
    5d65:	f01d           	retw.n

00005d67 <sw_fft_32b_2811+0xd3>:
	...

00005d68 <__do_global_ctors_aux>:
    5d68:	004136        	entry	a1, 32
    5d6b:	e93c31        	l32r	a3, 25c (6674 <__CTOR_END__>)
    5d6e:	fcc322        	addi	a2, a3, -4
    5d71:	0228           	l32i.n	a2, a2, 0
    5d73:	f8c332        	addi	a3, a3, -8
    5d76:	0a0226        	beqi	a2, -1, 5d84 <__do_global_ctors_aux+0x1c>

00005d79 <__do_global_ctors_aux+0x11>:
    5d79:	0002e0        	callx8	a2
    5d7c:	0328           	l32i.n	a2, a3, 0
    5d7e:	fcc332        	addi	a3, a3, -4
    5d81:	f40266        	bnei	a2, -1, 5d79 <__do_global_ctors_aux+0x11>
    5d84:	f01d           	retw.n

00005d86 <__do_global_ctors_aux+0x1e>:
	...

00005d88 <xt_memset>:
    5d88:	004136        	entry	a1, 32
    5d8b:	928c           	beqz.n	a2, 5d98 <xt_memset+0x10>
    5d8d:	748c           	beqz.n	a4, 5d98 <xt_memset+0x10>
    5d8f:	025d           	mov.n	a5, a2
    5d91:	038476        	loop	a4, 5d98 <xt_memset+0x10>
    5d94:	653d           	ae_s16i.n	a3, a5, 0
    5d96:	552b           	addi.n	a5, a5, 2

00005d98 <xt_memset+0x10>:
    5d98:	f01d           	retw.n

00005d9a <xt_memset+0x12>:
	...

00005d9c <xt_memcpy>:
    5d9c:	004136        	entry	a1, 32
    5d9f:	025d           	mov.n	a5, a2
    5da1:	020c           	movi.n	a2, 0
    5da3:	b5bc           	beqz.n	a5, 5de2 <xt_memcpy+0x46>
    5da5:	93bc           	beqz.n	a3, 5de2 <xt_memcpy+0x46>
    5da7:	24b357        	bgeu	a3, a5, 5dcf <xt_memcpy+0x33>
    5daa:	902430        	addx2	a2, a4, a3
    5dad:	1eb527        	bgeu	a5, a2, 5dcf <xt_memcpy+0x33>
    5db0:	052d           	mov.n	a2, a5
    5db2:	c4ac           	beqz.n	a4, 5de2 <xt_memcpy+0x46>
    5db4:	240b           	addi.n	a2, a4, -1
    5db6:	1122f0        	slli	a2, a2, 1
    5db9:	332a           	add.n	a3, a3, a2
    5dbb:	652a           	add.n	a6, a5, a2
    5dbd:	0b8476        	loop	a4, 5dcc <xt_memcpy+0x30>
    5dc0:	232d           	ae_l16si.n	a2, a3, 0
    5dc2:	662d           	ae_s16i.n	a2, a6, 0
    5dc4:	fec332        	addi	a3, a3, -2
    5dc7:	052d           	mov.n	a2, a5
    5dc9:	fec662        	addi	a6, a6, -2

00005dcc <xt_memcpy+0x30>:
    5dcc:	000486        	j	5de2 <xt_memcpy+0x46>

00005dcf <xt_memcpy+0x33>:
    5dcf:	052d           	mov.n	a2, a5
    5dd1:	d48c           	beqz.n	a4, 5de2 <xt_memcpy+0x46>
    5dd3:	056d           	mov.n	a6, a5
    5dd5:	098476        	loop	a4, 5de2 <xt_memcpy+0x46>
    5dd8:	232d           	ae_l16si.n	a2, a3, 0
    5dda:	662d           	ae_s16i.n	a2, a6, 0
    5ddc:	332b           	addi.n	a3, a3, 2
    5dde:	052d           	mov.n	a2, a5
    5de0:	662b           	addi.n	a6, a6, 2

00005de2 <xt_memcpy+0x46>:
    5de2:	f01d           	retw.n

00005de4 <_fini>:
    5de4:	008136        	entry	a1, 64
    5de7:	e91e81        	l32r	a8, 260 (27c <__do_global_dtors_aux>)
    5dea:	f03d           	nop.n
    5dec:	0008e0        	callx8	a8

00005def <_fini+0xb>:
    5def:	f01d           	retw.n
