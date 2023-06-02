
Build/lib/pisplit_post_ec_position_independent.splitload.lib:     file format elf32-xtensa-le


Disassembly of section .text:

00000000 <_init-0xec>:
       0:	00000138 00001bf0 000020bc 00000000     8........ ......
      10:	00002080 00000000 000020a4 000001fc     . ....... ......
      20:	000021c0 00002230 00002d50 000020dc     .!..0"..P-... ..
      30:	000018cc 000020f6 000018d8 0000210d     ..... .......!..
      40:	00001bac 000020d0 00002830 0000168c     ..... ..0(......
      50:	00000378 000024c0 000024f0 00000254     x....$...$..T...
      60:	000021a0 000002e8 000e38e4 000024a0     .!.......8...$..
      70:	00124925 000024e0 00001080 00002c30     %I...$......0,..
      80:	00000ddc 00000d40 000010b0 00001304     ....@...........
      90:	0000132c 00001358 000013a8 00001380     ,...X...........
      a0:	0000140c 000013e4 00001658 000015ec     ........X.......
      b0:	00002d30 7fff0000 00001c10 00001c24     0-..........$...
      c0:	00001798 000017f4 00000514 00000630     ............0...
      d0:	000007a8 00000150 000019dc 00001aac     ....P...........
      e0:	00001974 00002088 00000104              t.... ......

000000ec <_init>:
      ec:	008136        	entry	a1, 64
      ef:	ffc481        	l32r	a8, 0 (138 <frame_dummy>)
      f2:	f03d           	nop.n
      f4:	0008e0        	callx8	a8
      f7:	ffc381        	l32r	a8, 4 (1bf0 <__do_global_ctors_aux>)
      fa:	f03d           	nop.n
      fc:	0008e0        	callx8	a8
      ff:	f01d           	retw.n

00000101 <_init+0x15>:
     101:	000000                                        ...

00000104 <__do_global_dtors_aux>:
     104:	004136        	entry	a1, 32
     107:	ffc021        	l32r	a2, 8 (20bc <__do_global_dtors_aux.completed>)
     10a:	000232        	l8ui	a3, a2, 0
     10d:	23ec           	bnez.n	a3, 133 <__do_global_dtors_aux+0x2f>

0000010f <__do_global_dtors_aux+0xb>:
     10f:	1248           	l32i.n	a4, a2, 4
     111:	0438           	l32i.n	a3, a4, 0
     113:	444b           	addi.n	a4, a4, 4
     115:	738c           	beqz.n	a3, 120 <__do_global_dtors_aux+0x1c>
     117:	1249           	s32i.n	a4, a2, 4
     119:	0003e0        	callx8	a3
     11c:	fffbc6        	j	10f <__do_global_dtors_aux+0xb>

0000011f <__do_global_dtors_aux+0x1b>:
	...

00000120 <__do_global_dtors_aux+0x1c>:
     120:	ffbb31        	l32r	a3, c (0 <_text_start>)
     123:	ffbba1        	l32r	a10, 10 (2080 <__FRAME_END__>)
     126:	438c           	beqz.n	a3, 12e <__do_global_dtors_aux+0x2a>
     128:	ffb981        	l32r	a8, c (0 <_text_start>)
     12b:	0008e0        	callx8	a8
     12e:	130c           	movi.n	a3, 1
     130:	004232        	s8i	a3, a2, 0
     133:	f01d           	retw.n

00000135 <__do_global_dtors_aux+0x31>:
     135:	000000                                        ...

00000138 <frame_dummy>:
     138:	004136        	entry	a1, 32
     13b:	ffb621        	l32r	a2, 14 (0 <_text_start>)
     13e:	ffb4a1        	l32r	a10, 10 (2080 <__FRAME_END__>)
     141:	ffb5b1        	l32r	a11, 18 (20a4 <frame_dummy.object>)
     144:	428c           	beqz.n	a2, 14c <frame_dummy+0x14>
     146:	ffb381        	l32r	a8, 14 (0 <_text_start>)
     149:	0008e0        	callx8	a8

0000014c <frame_dummy+0x14>:
     14c:	f01d           	retw.n

0000014e <frame_dummy+0x16>:
	...

00000150 <comfort_noise_gen_wb2>:
     150:	008136        	entry	a1, 64
     153:	fc24b3a2fe 	{ l32i	a15, a2, 232; ae_zeroq56	aeq0 }
     158:	2f0262        	l8ui	a6, a2, 47
     15b:	6f9252        	l16si	a5, a2, 222
     15e:	fccf42        	addi	a4, a15, -4
     161:	624414        	ae_sq32f.iu	aeq0, a4, 4
     164:	624414        	ae_sq32f.iu	aeq0, a4, 4
     167:	139292        	l16si	a9, a2, 38
     16a:	624414        	ae_sq32f.iu	aeq0, a4, 4
     16d:	402232        	l32i	a3, a2, 0x100
     170:	624414        	ae_sq32f.iu	aeq0, a4, 4
     173:	4139           	s32i.n	a3, a1, 16
     175:	7226b6        	bltui	a6, 2, 1eb <comfort_noise_gen_wb2+0x9b>
     178:	41f8           	l32i.n	a15, a1, 16
     17a:	8c1272        	l16ui	a7, a2, 0x118
     17d:	350b           	addi.n	a3, a5, -1
     17f:	6129           	s32i.n	a2, a1, 24
     181:	7139           	s32i.n	a3, a1, 28
     183:	5169           	s32i.n	a6, a1, 20
     185:	560b           	addi.n	a5, a6, -1
     187:	fccf22        	addi	a2, a15, -4
     18a:	f67c           	movi.n	a6, -1

0000018c <comfort_noise_gen_wb2+0x3c>:
     18c:	41f8           	l32i.n	a15, a1, 16
     18e:	028d           	mov.n	a8, a2
     190:	71a8           	l32i.n	a10, a1, 28
     192:	a38f60        	movltz	a8, a15, a6
     195:	08b8           	l32i.n	a11, a8, 0
     197:	ffa181        	l32r	a8, 1c (1fc <HIFI_sqrt>)
     19a:	093d           	mov.n	a3, a9
     19c:	0008e0        	callx8	a8
     19f:	75a0d2        	movi	a13, 117
     1a2:	039d           	mov.n	a9, a3
     1a4:	bbdd32        	addmi	a3, a13, 0xffffbb00
     1a7:	f1a3e2        	movi	a14, 0x3f1
     1aa:	828730        	mull	a8, a7, a3
     1ad:	b03ee0        	addx8	a3, a14, a14
     1b0:	827730        	mull	a7, a7, a3
     1b3:	300874        	ae_cvtp24a16x2.ll	aep0, a8, a7
     1b6:	360b34        	ae_cvtq48a32s	aeq0, a11
     1b9:	d4e250fa9f 	{ add	a15, a10, a9; ae_mulfq32sp16s.l	aeq1, aeq0, aep0 }
     1be:	d4620ff55e 	{ addi	a5, a5, -1; ae_mulfq32sp16s.h	aeq0, aeq0, aep0 }
     1c3:	fc24fe9f4f 	{ ae_slaasq56s	aeq1, aeq1, a15; nop }
     1c8:	fd4c7e8f0f 	{ ae_slaasq56s	aeq0, aeq0, a15; ae_roundsq32sym	aeq1, aeq1 }
     1cd:	fc4479d41f 	{ ae_sq32f.iu	aeq1, a4, 4; ae_roundsq32sym	aeq0, aeq0 }
     1d2:	224b           	addi.n	a2, a2, 4
     1d4:	661b           	addi.n	a6, a6, 1
     1d6:	624414        	ae_sq32f.iu	aeq0, a4, 4
     1d9:	faf556        	bnez	a5, 18c <comfort_noise_gen_wb2+0x3c>
     1dc:	6138           	l32i.n	a3, a1, 24
     1de:	5168           	l32i.n	a6, a1, 20
     1e0:	fc24807e2f 	{ movi	a2, 126; ae_zeroq56	aeq0 }
     1e5:	8c5372        	s16i	a7, a3, 0x118
     1e8:	0e3267        	bltu	a2, a6, 1fa <comfort_noise_gen_wb2+0xaa>
     1eb:	7fa022        	movi	a2, 127
     1ee:	c02260        	sub	a2, a2, a6
     1f1:	058276        	loop	a2, 1fa <comfort_noise_gen_wb2+0xaa>
     1f4:	624414        	ae_sq32f.iu	aeq0, a4, 4
     1f7:	624414        	ae_sq32f.iu	aeq0, a4, 4

000001fa <comfort_noise_gen_wb2+0xaa>:
     1fa:	f01d           	retw.n

000001fc <HIFI_sqrt>:
     1fc:	004136        	entry	a1, 32
     1ff:	4b13a6        	blti	a3, 1, 24e <HIFI_sqrt+0x52>
     202:	40e340        	nsa	a4, a3
     205:	c02240        	sub	a2, a2, a4
     208:	401400        	ssl	a4
     20b:	044020        	extui	a4, a2, 0, 1
     20e:	a1c300        	sll	a12, a3
     211:	400400        	ssr	a4
     214:	b130c0        	sra	a3, a12
     217:	656930        	extui	a6, a3, 25, 7
     21a:	ff81d1        	l32r	a13, 20 (21c0 <TABLE_SQRT>)
     21d:	050c           	movi.n	a5, 0
     21f:	f0c662        	addi	a6, a6, -16
     222:	535650        	max	a5, a6, a5
     225:	9055d0        	addx2	a5, a5, a13
     228:	456d           	ae_l16ui.n	a6, a5, 0
     22a:	355d           	ae_l16si.n	a5, a5, 2
     22c:	413930        	srli	a3, a3, 9
     22f:	11f600        	slli	a15, a6, 16
     232:	c0e560        	sub	a14, a5, a6
     235:	300334        	ae_cvtp24a16x2.ll	aep0, a3, a3
     238:	113e00        	slli	a3, a14, 16
     23b:	360f34        	ae_cvtq48a32s	aeq0, a15
     23e:	364334        	ae_cvtq48a32s	aeq1, a3
     241:	d4e110242f 	{ add	a2, a4, a2; ae_mulaq32sp16u.l	aeq0, aeq1, aep0 }
     246:	212120        	srai	a2, a2, 1
     249:	368304        	ae_trunca32q48	a3, aeq0
     24c:	f01d           	retw.n

0000024e <HIFI_sqrt+0x52>:
     24e:	020c           	movi.n	a2, 0
     250:	030c           	movi.n	a3, 0
     252:	f01d           	retw.n

00000254 <Log2_norm>:
     254:	004136        	entry	a1, 32
     257:	024d           	mov.n	a4, a2
     259:	ff7c           	movi.n	a15, -1
     25b:	012f10        	slli	a2, a15, 31
     25e:	3214a6        	blti	a4, 1, 294 <Log2_norm+0x40>
     261:	156c           	movi.n	a5, -31
     263:	2d2357        	blt	a3, a5, 294 <Log2_norm+0x40>
     266:	022c           	movi.n	a2, 32
     268:	06a237        	bge	a2, a3, 272 <Log2_norm+0x1e>
     26b:	f27c           	movi.n	a2, -1
     26d:	412120        	srli	a2, a2, 1
     270:	f01d           	retw.n

00000272 <Log2_norm+0x1e>:
     272:	ff6c51        	l32r	a5, 24 (2230 <TABLE_LOG2_1530>)
     275:	552840        	extui	a2, a4, 24, 6
     278:	1122e0        	slli	a2, a2, 2
     27b:	603524        	ae_lq32f.xu	aeq0, a5, a2
     27e:	604514        	ae_lq32f.i	aeq1, a5, 4
     281:	f92ae2044f 	{ ae_movpa24x2	aep0, a4, a4; ae_subq56	aeq1, aeq1, aeq0 }
     286:	030174        	ae_mulaq32sp16u.l	aeq0, aeq1, aep0
     289:	013360        	slli	a3, a3, 26
     28c:	368f04        	ae_trunca32q48	a15, aeq0
     28f:	2125f0        	srai	a2, a15, 5
     292:	223a           	add.n	a2, a2, a3
     294:	f01d           	retw.n

00000296 <Log2_norm+0x42>:
	...

00000298 <siir_safr>:
     298:	004136        	entry	a1, 32
     29b:	05a237        	bge	a2, a3, 2a4 <siir_safr+0xc>
     29e:	440404        	ae_lp16x2f.i	aep0, a4, 0
     2a1:	000086        	j	2a7 <siir_safr+0xf>

000002a4 <siir_safr+0xc>:
     2a4:	440414        	ae_lp16x2f.i	aep0, a4, 4
     2a7:	360234        	ae_cvtq48a32s	aeq0, a2
     2aa:	364334        	ae_cvtq48a32s	aeq1, a3
     2ad:	c10014        	ae_mulzaafq32sp16s.lh	aeq0, aeq0, aep0, aeq1, aep0
     2b0:	060934        	ae_roundsq32asym	aeq0, aeq0
     2b3:	368204        	ae_trunca32q48	a2, aeq0
     2b6:	f01d           	retw.n

000002b8 <_start>:
     2b8:	004136        	entry	a1, 32
     2bb:	ff5b31        	l32r	a3, 28 (2d50 <printf_ptr>)
     2be:	0228           	l32i.n	a2, a2, 0
     2c0:	ff5ba1        	l32r	a10, 2c (20dc <export_parameter_array+0xc>)
     2c3:	ff5bb1        	l32r	a11, 30 (18cc <get_post_ec_memsize>)
     2c6:	0329           	s32i.n	a2, a3, 0
     2c8:	0002e0        	callx8	a2
     2cb:	0328           	l32i.n	a2, a3, 0
     2cd:	ff59a1        	l32r	a10, 34 (20f6 <export_parameter_array+0x26>)
     2d0:	ff5ab1        	l32r	a11, 38 (18d8 <EXT_POST_EC_Init>)
     2d3:	0002e0        	callx8	a2
     2d6:	0328           	l32i.n	a2, a3, 0
     2d8:	ff59a1        	l32r	a10, 3c (210d <export_parameter_array+0x3d>)
     2db:	ff59b1        	l32r	a11, 40 (1bac <EXT_POST_EC_PRCS>)
     2de:	0002e0        	callx8	a2
     2e1:	ff5821        	l32r	a2, 44 (20d0 <export_parameter_array>)
     2e4:	f01d           	retw.n

000002e6 <_start+0x2e>:
	...

000002e8 <take_min_four>:
     2e8:	004136        	entry	a1, 32
     2eb:	224d           	ae_l16si.n	a4, a2, 0
     2ed:	5023a6        	blti	a3, 2, 341 <take_min_four+0x59>
     2f0:	ffa052        	movi	a5, 255
     2f3:	7fd552        	addmi	a5, a5, 0x7f00
     2f6:	630b           	addi.n	a6, a3, -1
     2f8:	222b           	addi.n	a2, a2, 2
     2fa:	048d           	mov.n	a8, a4
     2fc:	053d           	mov.n	a3, a5
     2fe:	207550        	or	a7, a5, a5
     301:	318676        	loop	a6, 336 <take_min_four+0x4e>
     304:	22ad           	ae_l16si.n	a10, a2, 0
     306:	086d           	mov.n	a6, a8
     308:	079d           	mov.n	a9, a7
     30a:	0a4d           	mov.n	a4, a10
     30c:	1c2a87        	blt	a10, a8, 32c <take_min_four+0x44>
     30f:	084d           	mov.n	a4, a8
     311:	0a6d           	mov.n	a6, a10
     313:	079d           	mov.n	a9, a7
     315:	132a77        	blt	a10, a7, 32c <take_min_four+0x44>
     318:	084d           	mov.n	a4, a8
     31a:	076d           	mov.n	a6, a7
     31c:	0a9d           	mov.n	a9, a10
     31e:	0a2a37        	blt	a10, a3, 32c <take_min_four+0x44>
     321:	4355a0        	min	a5, a5, a10
     324:	039d           	mov.n	a9, a3
     326:	084d           	mov.n	a4, a8
     328:	076d           	mov.n	a6, a7
     32a:	053d           	mov.n	a3, a5

0000032c <take_min_four+0x44>:
     32c:	035d           	mov.n	a5, a3
     32e:	222b           	addi.n	a2, a2, 2
     330:	093d           	mov.n	a3, a9
     332:	067d           	mov.n	a7, a6
     334:	048d           	mov.n	a8, a4

00000336 <take_min_four+0x4e>:
     336:	249a           	add.n	a2, a4, a9
     338:	365a           	add.n	a3, a6, a5
     33a:	223a           	add.n	a2, a2, a3
     33c:	112220        	slli	a2, a2, 14
     33f:	f01d           	retw.n

00000341 <take_min_four+0x59>:
     341:	ffa062        	movi	a6, 255
     344:	7fd662        	addmi	a6, a6, 0x7f00
     347:	069d           	mov.n	a9, a6
     349:	065d           	mov.n	a5, a6
     34b:	fff9c6        	j	336 <take_min_four+0x4e>

0000034e <take_min_four+0x66>:
	...

00000350 <equal_power>:
     350:	004136        	entry	a1, 32
     353:	c07450        	sub	a7, a4, a5
     356:	a34570        	movltz	a4, a5, a7
     359:	1416a6        	blti	a6, 1, 371 <equal_power+0x21>
     35c:	a33270        	movltz	a3, a2, a7
     35f:	605170        	abs	a5, a7
     362:	fcc322        	addi	a2, a3, -4
     365:	088676        	loop	a6, 371 <equal_power+0x21>
     368:	601214        	ae_lq32f.iu	aeq0, a2, 4
     36b:	3405a4        	ae_srlaq56	aeq0, aeq0, a5
     36e:	620204        	ae_sq32f.i	aeq0, a2, 0

00000371 <equal_power+0x21>:
     371:	042d           	mov.n	a2, a4
     373:	f01d           	retw.n

00000375 <equal_power+0x25>:
     375:	000000                                        ...

00000378 <gen_power>:
     378:	004136        	entry	a1, 32
     37b:	002252        	l32i	a5, a2, 0
     37e:	3a2242        	l32i	a4, a2, 232
     381:	1123a6        	blti	a3, 2, 396 <gen_power+0x1e>
     384:	217130        	srai	a7, a3, 1
     387:	f8c432        	addi	a3, a4, -8
     38a:	206550        	or	a6, a5, a5
     38d:	058776        	loop	a7, 396 <gen_power+0x1e>
     390:	5c8614        	ae_lp24x2f.iu	aep0, a6, 8
     393:	5e8314        	ae_sp24x2f.iu	aep0, a3, 8

00000396 <gen_power+0x1e>:
     396:	139232        	l16si	a3, a2, 38
     399:	2f0272        	l8ui	a7, a2, 47
     39c:	160c           	movi.n	a6, 1
     39e:	1133f0        	slli	a3, a3, 1
     3a1:	c06630        	sub	a6, a6, a3
     3a4:	f73b           	addi.n	a15, a7, 3
     3a6:	fcc532        	addi	a3, a5, -4
     3a9:	5c0404        	ae_lp24x2f.i	aep0, a4, 0
     3ac:	6e5262        	s16i	a6, a2, 220
     3af:	0a8f76        	loop	a15, 3bd <gen_power+0x45>
     3b2:	f003af841f 	{ ae_lp24x2f.iu	aep0, a4, 8; ae_mulzaap24s.hh.ll	aeq0, aep0, aep0 }
     3b7:	060834        	ae_roundsq32sym	aeq0, aeq0
     3ba:	624314        	ae_sq32f.iu	aeq0, a3, 4

000003bd <gen_power+0x45>:
     3bd:	f01d           	retw.n

000003bf <gen_power+0x47>:
	...

000003c0 <fft_wo>:
     3c0:	006136        	entry	a1, 48
     3c3:	2e0242        	l8ui	a4, a2, 46
     3c6:	750c           	movi.n	a5, 7
     3c8:	160c           	movi.n	a6, 1
     3ca:	625540        	saltu	a5, a5, a4
     3cd:	fcc442        	addi	a4, a4, -4
     3d0:	624460        	saltu	a4, a4, a6
     3d3:	205540        	or	a5, a5, a4
     3d6:	f0a0c2        	movi	a12, 240
     3d9:	15cc           	bnez.n	a5, 3de <fft_wo+0x1e>
     3db:	78a0c2        	movi	a12, 120

000003de <fft_wo+0x1e>:
     3de:	270c           	movi.n	a7, 2
     3e0:	05cc           	bnez.n	a5, 3e4 <fft_wo+0x24>
     3e2:	470c           	movi.n	a7, 4
     3e4:	060c           	movi.n	a6, 0
     3e6:	204330        	or	a4, a3, a3
     3e9:	098c76        	loop	a12, 3f6 <fft_wo+0x36>
     3ec:	248d           	ae_l16si.n	a8, a4, 0
     3ee:	442b           	addi.n	a4, a4, 2
     3f0:	608180        	abs	a8, a8
     3f3:	206860        	or	a6, a8, a6

000003f6 <fft_wo+0x36>:
     3f6:	00a2f2        	movi	a15, 0x200
     3f9:	15cc           	bnez.n	a5, 3fe <fft_wo+0x3e>
     3fb:	00a1f2        	movi	a15, 0x100

000003fe <fft_wo+0x3e>:
     3fe:	ff1241        	l32r	a4, 48 (2830 <fftorder_512_12b>)
     401:	35cc           	bnez.n	a5, 408 <fft_wo+0x48>
     403:	548b           	addi.n	a5, a4, 8
     405:	000046        	j	40a <fft_wo+0x4a>

00000408 <fft_wo+0x48>:
     408:	544b           	addi.n	a5, a4, 4
     40a:	40e640        	nsa	a4, a6
     40d:	1292a2        	l16si	a10, a2, 36
     410:	060c           	movi.n	a6, 0
     412:	f0c442        	addi	a4, a4, -16
     415:	3e22e2        	l32i	a14, a2, 248
     418:	534460        	max	a4, a4, a6
     41b:	02b8           	l32i.n	a11, a2, 0
     41d:	3d2282        	l32i	a8, a2, 244
     420:	1149           	s32i.n	a4, a1, 4
     422:	4344a0        	min	a4, a4, a10
     425:	031644        	wur.ae_sar	a4
     428:	440e04        	ae_lp16x2f.i	aep0, a14, 0
     42b:	a0afb0        	addx4	a10, a15, a11
     42e:	41d2f0        	srli	a13, a15, 2
     431:	1197f0        	slli	a9, a7, 1
     434:	2149           	s32i.n	a4, a1, 8
     436:	31f9           	s32i.n	a15, a1, 12
     438:	f823ad180f 	{ ae_lp16x2f.i	aep1, a8, 0; ae_sllssp24s	aep0, aep0 }
     43d:	ba4b           	addi.n	a11, a10, 4
     43f:	158d76        	loop	a13, 458 <fft_wo+0x98>
     442:	e820adfe1f 	{ ae_lp16x2f.iu	aep7, a14, 4; ae_mulfp24s.hh	aeq0, aep0, aep1 }
     447:	eb21ed981f 	{ ae_lp16x2f.iu	aep1, a8, 4; ae_mulfp24s.ll	aeq3, aep0, aep1 }
     44c:	f83fb84a6f 	{ ae_sq32f.x	aeq0, a10, a6; ae_sllssp24s	aep0, aep7 }
     451:	62bb64        	ae_sq32f.x	aeq3, a11, a6
     454:	256d           	ae_l16si.n	a6, a5, 0
     456:	559a           	add.n	a5, a5, a9

00000458 <fft_wo+0x98>:
     458:	fc24b3e27e 	{ l32i	a7, a2, 248; ae_zeroq56	aeq0 }
     45d:	41f1c0        	srli	a15, a12, 1
     460:	f842154dff 	{ sub	a4, a13, a15; ae_truncp24q48x2	aep0, aeq0, aeq0 }
     465:	fcc7e2        	addi	a14, a7, -4
     468:	0214e6        	bgei	a4, 1, 46e <fft_wo+0xae>
     46b:	002706        	j	50b <fft_wo+0x14b>
     46e:	90cc70        	addx2	a12, a12, a7
     471:	442c04        	ae_lp16x2f.i	aep2, a12, 0
     474:	f03d           	nop.n
     476:	098476        	loop	a4, 483 <fft_wo+0xc3>
     479:	fc4873ae1f 	{ ae_sp16x2f.iu	aep2, a14, 4; ae_abssp24s	aep1, aep2 }
     47e:	dc202dac1f 	{ ae_lp16x2f.iu	aep2, a12, 4; ae_orp48	aep0, aep0, aep1 }
     483:	c04df0        	sub	a4, a13, a15
     486:	4498f4        	ae_lp16x2f.iu	aep1, a8, -4
     489:	f03d           	nop.n
     48b:	f03d           	nop.n
     48d:	1d8476        	loop	a4, 4ae <fft_wo+0xee>
     490:	f92bf3ae1f 	{ ae_sp16x2f.iu	aep2, a14, 4; ae_sllssp24s	aep3, aep2 }
     495:	013154        	ae_mulfp24s.hl	aeq0, aep3, aep1
     498:	e92ded98ff 	{ ae_lp16x2f.iu	aep1, a8, -4; ae_mulfp24s.lh	aeq3, aep3, aep1 }
     49d:	fe48384a6f 	{ ae_sq32f.x	aeq0, a10, a6; ae_abssp24s	aep4, aep2 }
     4a2:	dc80387b6f 	{ ae_sq32f.x	aeq3, a11, a6; ae_orp48	aep0, aep0, aep4 }
     4a7:	256d           	ae_l16si.n	a6, a5, 0
     4a9:	44ac14        	ae_lp16x2f.iu	aep2, a12, 4
     4ac:	559a           	add.n	a5, a5, a9

000004ae <fft_wo+0xee>:
     4ae:	0084d4        	ae_cvta32p24.h	a4, aep0
     4b1:	0007d4        	ae_cvta32p24.l	a7, aep0
     4b4:	11d8           	l32i.n	a13, a1, 4
     4b6:	204470        	or	a4, a4, a7
     4b9:	40e440        	nsa	a4, a4
     4bc:	434d40        	min	a4, a13, a4
     4bf:	125242        	s16i	a4, a2, 36
     4c2:	440304        	ae_lp16x2f.i	aep0, a3, 0
     4c5:	188f76        	loop	a15, 4e1 <fft_wo+0x121>
     4c8:	f923b38e1f 	{ ae_sp16x2f.iu	aep0, a14, 4; ae_sllssp24s	aep2, aep0 }
     4cd:	ea28ad831f 	{ ae_lp16x2f.iu	aep0, a3, 4; ae_mulfp24s.hl	aeq0, aep2, aep1 }
     4d2:	e929ed98ff 	{ ae_lp16x2f.iu	aep1, a8, -4; ae_mulfp24s.lh	aeq3, aep2, aep1 }
     4d7:	628a64        	ae_sq32f.x	aeq0, a10, a6
     4da:	62bb64        	ae_sq32f.x	aeq3, a11, a6
     4dd:	256d           	ae_l16si.n	a6, a5, 0
     4df:	559a           	add.n	a5, a5, a9

000004e1 <fft_wo+0x121>:
     4e1:	3148           	l32i.n	a4, a1, 12
     4e3:	0238           	l32i.n	a3, a2, 0
     4e5:	8c0c           	movi.n	a12, 8
     4e7:	41b140        	srli	a11, a4, 1
     4ea:	a0a430        	addx4	a10, a4, a3
     4ed:	fed731        	l32r	a3, 4c (168c <sw_fft_32b_2811>)
     4f0:	1d0c           	movi.n	a13, 1
     4f2:	0e0c           	movi.n	a14, 0
     4f4:	0003e0        	callx8	a3
     4f7:	2138           	l32i.n	a3, a1, 8
     4f9:	04bd           	mov.n	a11, a4
     4fb:	c033a0        	sub	a3, a3, a10
     4fe:	135232        	s16i	a3, a2, 38
     501:	fed331        	l32r	a3, 50 (378 <gen_power>)
     504:	02ad           	mov.n	a10, a2
     506:	0003e0        	callx8	a3
     509:	f01d           	retw.n

0000050b <fft_wo+0x14b>:
     50b:	4498f4        	ae_lp16x2f.iu	aep1, a8, -4
     50e:	ffe706        	j	4ae <fft_wo+0xee>

00000511 <fft_wo+0x151>:
     511:	000000                                        ...

00000514 <NR_vad1>:
     514:	006136        	entry	a1, 48
     517:	2e02b2        	l8ui	a11, a2, 46
     51a:	0238           	l32i.n	a3, a2, 0
     51c:	fece81        	l32r	a8, 54 (24c0 <wb_sb_ptn>)
     51f:	066b16        	beqz	a11, 589 <NR_vad1+0x75>
     522:	fecd61        	l32r	a6, 58 (24f0 <nb_sb_ptn>)
     525:	eca092        	movi	a9, 236
     528:	4153b0        	srli	a5, a11, 3
     52b:	f29a           	add.n	a15, a2, a9
     52d:	fd24bd033f 	{ ae_lq32f.i	aeq0, a3, 12; ae_zeroq56	aeq1 }
     532:	31b9           	s32i.n	a11, a1, 12
     534:	117be0        	slli	a7, a11, 2
     537:	00a042        	movi	a4, 0
     53a:	936850        	movnez	a6, a8, a5
     53d:	0cc332        	addi	a3, a3, 12
     540:	0261f2        	s32i	a15, a1, 8

00000543 <NR_vad1+0x2f>:
     543:	265d           	ae_l16si.n	a5, a6, 0
     545:	368d           	ae_l16si.n	a8, a6, 2
     547:	c05850        	sub	a5, a8, a5
     54a:	0715a6        	blti	a5, 1, 555 <NR_vad1+0x41>
     54d:	048576        	loop	a5, 555 <NR_vad1+0x41>
     550:	f96a3d131f 	{ ae_lq32f.iu	aeq0, a3, 4; ae_addq56	aeq1, aeq1, aeq0 }

00000555 <NR_vad1+0x41>:
     555:	365504        	ae_nsaq56s	a5, aeq1
     558:	6e9282        	l16si	a8, a2, 220
     55b:	f8c552        	addi	a5, a5, -8
     55e:	fc24fe950f 	{ ae_slaasq56s	aeq0, aeq1, a5; nop }
     563:	c0b850        	sub	a11, a8, a5
     566:	368a04        	ae_trunca32q48	a10, aeq0
     569:	febc51        	l32r	a5, 5c (254 <Log2_norm>)
     56c:	0005e0        	callx8	a5
     56f:	fd24b3b25e 	{ l32i	a5, a2, 236; ae_zeroq56	aeq1 }
     574:	600304        	ae_lq32f.i	aeq0, a3, 0
     577:	662b           	addi.n	a6, a6, 2
     579:	854a           	add.n	a8, a5, a4
     57b:	444b           	addi.n	a4, a4, 4
     57d:	08a9           	s32i.n	a10, a8, 0
     57f:	c09747        	bne	a7, a4, 543 <NR_vad1+0x2f>
     582:	31b8           	l32i.n	a11, a1, 12
     584:	21c8           	l32i.n	a12, a1, 8
     586:	0001c6        	j	591 <NR_vad1+0x7d>

00000589 <NR_vad1+0x75>:
     589:	3b2252        	l32i	a5, a2, 236
     58c:	eca032        	movi	a3, 236
     58f:	c23a           	add.n	a12, a2, a3
     591:	feb361        	l32r	a6, 60 (21a0 <NR_immediate_num>)
     594:	06cb16        	beqz	a11, 604 <NR_vad1+0xf0>
     597:	039272        	l16si	a7, a2, 6
     59a:	c4a082        	movi	a8, 196
     59d:	c8a092        	movi	a9, 200
     5a0:	34c232        	addi	a3, a2, 52
     5a3:	117700        	slli	a7, a7, 16
     5a6:	360734        	ae_cvtq48a32s	aeq0, a7
     5a9:	604504        	ae_lq32f.i	aeq1, a5, 0
     5ac:	54c242        	addi	a4, a2, 84
     5af:	070c           	movi.n	a7, 0
     5b1:	608304        	ae_lq32f.i	aeq2, a3, 0
     5b4:	828a           	add.n	a8, a2, a8
     5b6:	929a           	add.n	a9, a2, a9
     5b8:	338b76        	loop	a11, 5ef <NR_vad1+0xdb>
     5bb:	d6c813a99f 	{ or	a10, a9, a9; ae_ltq56s	b0, aeq2, aeq1 }
     5c0:	09ed           	mov.n	a14, a9
     5c2:	f76b           	addi.n	a15, a7, 6
     5c4:	d3a800        	movt	a10, a8, b0
     5c7:	440a04        	ae_lp16x2f.i	aep0, a10, 0
     5ca:	c18064        	ae_mulzaafq32sp16s.lh	aeq2, aeq1, aep0, aeq2, aep0
     5cd:	622304        	ae_sq32f.i	aeq2, a3, 0
     5d0:	60d414        	ae_lq32f.iu	aeq3, a4, 4
     5d3:	09b104        	ae_ltq56s	b0, aeq1, aeq3
     5d6:	d3e800        	movt	a14, a8, b0
     5d9:	447e04        	ae_lp16x2f.i	aep7, a14, 0
     5dc:	c1ff74        	ae_mulzaafq32sp16s.lh	aeq3, aeq1, aep7, aeq3, aep7
     5df:	fab6f9b40f 	{ ae_sq32f.i	aeq3, a4, 0; ae_subq56	aeq2, aeq2, aeq3 }
     5e4:	d6503d351f 	{ ae_lq32f.iu	aeq1, a5, 4; ae_ltq56s	b0, aeq0, aeq2 }
     5e9:	609314        	ae_lq32f.iu	aeq2, a3, 4
     5ec:	d37f00        	movt	a7, a15, b0

000005ef <NR_vad1+0xdb>:
     5ef:	030c           	movi.n	a3, 0
     5f1:	0c58           	l32i.n	a5, a12, 0
     5f3:	724370        	salt	a4, a3, a7
     5f6:	f68b           	addi.n	a15, a6, 8
     5f8:	36cb           	addi.n	a3, a6, 12
     5fa:	933f40        	movnez	a3, a15, a4
     5fd:	7bcc           	bnez.n	a11, 608 <NR_vad1+0xf4>
     5ff:	000a86        	j	62d <NR_vad1+0x119>

00000602 <NR_vad1+0xee>:
	...

00000604 <NR_vad1+0xf0>:
     604:	36cb           	addi.n	a3, a6, 12
     606:	3bac           	beqz.n	a11, 62d <NR_vad1+0x119>
     608:	1092f2        	l16si	a15, a2, 32
     60b:	440304        	ae_lp16x2f.i	aep0, a3, 0
     60e:	7cc222        	addi	a2, a2, 124
     611:	113f00        	slli	a3, a15, 16
     614:	608504        	ae_lq32f.i	aeq2, a5, 0
     617:	600204        	ae_lq32f.i	aeq0, a2, 0
     61a:	364334        	ae_cvtq48a32s	aeq1, a3
     61d:	0c8b76        	loop	a11, 62d <NR_vad1+0x119>
     620:	0f003d121f 	{ ae_lq32f.iu	aeq0, a2, 4; ae_mulzaafq32sp16s.lh	aeq2, aeq2, aep0, aeq0, aep0 }
     625:	fb773d551f 	{ ae_lq32f.iu	aeq2, a5, 4; ae_maxq56s	aeq3, aeq1, aeq2 }
     62a:	6232f4        	ae_sq32f.i	aeq3, a2, -4

0000062d <NR_vad1+0x119>:
     62d:	f01d           	retw.n

0000062f <NR_vad1+0x11b>:
	...

00000630 <NR_vad2>:
     630:	008136        	entry	a1, 64
     633:	151232        	l16ui	a3, a2, 42
     636:	021242        	l16ui	a4, a2, 4
     639:	2e02a2        	l8ui	a10, a2, 46
     63c:	109252        	l16si	a5, a2, 32
     63f:	3e9347        	bne	a3, a4, 681 <NR_vad2+0x51>
     642:	040c           	movi.n	a4, 0
     644:	155242        	s16i	a4, a2, 42
     647:	71a9           	s32i.n	a10, a1, 28
     649:	053d           	mov.n	a3, a5
     64b:	074a16        	beqz	a10, 6c3 <NR_vad2+0x93>
     64e:	c288           	l32i.n	a8, a2, 48
     650:	fe8561        	l32r	a6, 64 (2e8 <take_min_four>)
     653:	a0a042        	movi	a4, 160
     656:	08d332        	addmi	a3, a3, 0x800
     659:	115300        	slli	a5, a3, 16
     65c:	0a7d           	mov.n	a7, a10
     65e:	424a           	add.n	a4, a2, a4
     660:	083d           	mov.n	a3, a8
     662:	6189           	s32i.n	a8, a1, 24

00000664 <NR_vad2+0x34>:
     664:	cb0c           	movi.n	a11, 12
     666:	03ad           	mov.n	a10, a3
     668:	0006e0        	callx8	a6
     66b:	5385a0        	max	a8, a5, a10
     66e:	770b           	addi.n	a7, a7, -1
     670:	0489           	s32i.n	a8, a4, 0
     672:	18c332        	addi	a3, a3, 24
     675:	444b           	addi.n	a4, a4, 4
     677:	fe9756        	bnez	a7, 664 <NR_vad2+0x34>
     67a:	001246        	j	6c7 <NR_vad2+0x97>

0000067d <NR_vad2+0x4d>:
     67d:	00000000                                ....

00000681 <NR_vad2+0x51>:
     681:	7cc232        	addi	a3, a2, 124
     684:	600304        	ae_lq32f.i	aeq0, a3, 0
     687:	078a16        	beqz	a10, 703 <NR_vad2+0xd3>
     68a:	620154        	ae_sq32f.i	aeq0, a1, 20
     68d:	c258           	l32i.n	a5, a2, 48
     68f:	2d0262        	l8ui	a6, a2, 45
     692:	604154        	ae_lq32f.i	aeq1, a1, 20
     695:	841c           	movi.n	a4, 24
     697:	905650        	addx2	a5, a6, a5
     69a:	e8c552        	addi	a5, a5, -24
     69d:	0c8a76        	loop	a10, 6ad <NR_vad2+0x7d>
     6a0:	f8ebda054f 	{ ae_lp16f.xu	aep0, a5, a4; ae_roundsp16q48sym	aep1, aeq1 }
     6a5:	d822bd331f 	{ ae_lq32f.iu	aeq1, a3, 4; ae_minp24s	aep0, aep0, aep1 }
     6aa:	420504        	ae_sp16f.l.i	aep0, a5, 0

000006ad <NR_vad2+0x7d>:
     6ad:	159232        	l16si	a3, a2, 42
     6b0:	fe6f81        	l32r	a8, 6c (24a0 <wb_score_bands>)
     6b3:	fe6d41        	l32r	a4, 68 (e38e4 <_end+0xe0b90>)
     6b6:	331b           	addi.n	a3, a3, 1
     6b8:	155232        	s16i	a3, a2, 42
     6bb:	4c8ab6        	bltui	a10, 8, 70b <NR_vad2+0xdb>
     6be:	043d           	mov.n	a3, a4
     6c0:	001346        	j	711 <NR_vad2+0xe1>

000006c3 <NR_vad2+0x93>:
     6c3:	c238           	l32i.n	a3, a2, 48
     6c5:	6139           	s32i.n	a3, a1, 24
     6c7:	2d0232        	l8ui	a3, a2, 45
     6ca:	71a8           	l32i.n	a10, a1, 28
     6cc:	331b           	addi.n	a3, a3, 1
     6ce:	744030        	extui	a4, a3, 0, 8
     6d1:	f4c442        	addi	a4, a4, -12
     6d4:	934340        	movnez	a4, a3, a4
     6d7:	7cc232        	addi	a3, a2, 124
     6da:	600304        	ae_lq32f.i	aeq0, a3, 0
     6dd:	2d4242        	s8i	a4, a2, 45
     6e0:	fa9c           	beqz.n	a10, 703 <NR_vad2+0xd3>
     6e2:	620144        	ae_sq32f.i	aeq0, a1, 16
     6e5:	6168           	l32i.n	a6, a1, 24
     6e7:	744040        	extui	a4, a4, 0, 8
     6ea:	604144        	ae_lq32f.i	aeq1, a1, 16
     6ed:	906460        	addx2	a6, a4, a6
     6f0:	841c           	movi.n	a4, 24
     6f2:	e8c652        	addi	a5, a6, -24
     6f5:	078a76        	loop	a10, 700 <NR_vad2+0xd0>
     6f8:	f8ebbd331f 	{ ae_lq32f.iu	aeq1, a3, 4; ae_roundsp16q48sym	aep0, aeq1 }
     6fd:	438544        	ae_sp16f.l.xu	aep0, a5, a4

00000700 <NR_vad2+0xd0>:
     700:	ffea46        	j	6ad <NR_vad2+0x7d>

00000703 <NR_vad2+0xd3>:
     703:	159232        	l16si	a3, a2, 42
     706:	331b           	addi.n	a3, a3, 1
     708:	155232        	s16i	a3, a2, 42
     70b:	fe5a81        	l32r	a8, 74 (24e0 <nb_score_bands>)
     70e:	fe5831        	l32r	a3, 70 (124925 <_end+0x121bd1>)
     711:	398334        	ae_movpa24x2	aep0, a3, a3
     714:	3c2242        	l32i	a4, a2, 240
     717:	a0a052        	movi	a5, 160
     71a:	fc20fc452f 	{ ae_lq32f.xu	aeq2, a5, a2; ae_zerop48	aep1 }
     71f:	fc24b9813f 	{ ae_sq32f.i	aeq0, a1, 12; ae_zeroq56	aeq0 }
     724:	604134        	ae_lq32f.i	aeq1, a1, 12
     727:	326b           	addi.n	a3, a2, 6
     729:	fbaac7c26e 	{ addi	a6, a2, 124; ae_subq56	aeq3, aeq1, aeq2 }
     72e:	fcc472        	addi	a7, a4, -4
     731:	1e4a66        	bnei	a10, 4, 753 <NR_vad2+0x123>
     734:	420c           	movi.n	a2, 4
     736:	178276        	loop	a2, 751 <NR_vad2+0x121>
     739:	f8aaec831f 	{ ae_lp16f.iu	aep0, a3, 2; ae_subq56	aeq0, aeq1, aeq2 }
     73e:	ff0c3d361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_cvtq48p24s.l	aeq3, aep0 }
     743:	f8a6fd551f 	{ ae_lq32f.iu	aeq2, a5, 4; ae_subq56	aeq0, aeq0, aeq3 }
     748:	350074        	ae_sraiq56	aeq0, aeq0, 1
     74b:	098c74        	ae_truncp24q48x2	aep7, aeq0, aeq0
     74e:	52f714        	ae_sp24f.l.iu	aep7, a7, 4

00000751 <NR_vad2+0x121>:
     751:	f01d           	retw.n

00000753 <NR_vad2+0x123>:
     753:	fec882        	addi	a8, a8, -2
     756:	caac           	beqz.n	a10, 786 <NR_vad2+0x156>
     758:	190c           	movi.n	a9, 1
     75a:	288a76        	loop	a10, 786 <NR_vad2+0x156>
     75d:	40a314        	ae_lp16f.iu	aep2, a3, 2
     760:	fe4c00004f 	{ movi	a4, 0; ae_cvtq48p24s.l	aeq2, aep2 }
     765:	d6d82ca81f 	{ ae_lp16f.iu	aep2, a8, 2; ae_ltq56s	b0, aeq2, aeq3 }
     76a:	f9bad6490f 	{ movt	a4, a9, b0; ae_subq56	aeq1, aeq3, aeq2 }
     76f:	148c           	beqz.n	a4, 774 <NR_vad2+0x144>
     771:	079214        	ae_addsp24s	aep1, aep1, aep2
     774:	f6c3bb109f 	{ ae_sraiq56	aeq2, aeq1, 1; ae_mulafq32sp24s.l	aeq0, aeq3, aep0 }
     779:	f9d23d361f 	{ ae_lq32f.iu	aeq1, a6, 4; ae_truncp24q48x2	aep2, aeq2, aeq2 }
     77e:	609514        	ae_lq32f.iu	aeq2, a5, 4
     781:	fbaaf4a71f 	{ ae_sp24f.l.iu	aep2, a7, 4; ae_subq56	aeq3, aeq1, aeq2 }

00000786 <NR_vad2+0x156>:
     786:	408314        	ae_lp16f.iu	aep0, a3, 2
     789:	fd0c00003f 	{ movi	a3, 0; ae_cvtq48p24s.l	aeq1, aep0 }
     78e:	d64400014f 	{ movi	a4, 1; ae_ltq56s	b0, aeq1, aeq0 }
     793:	d33400        	movt	a3, a4, b0
     796:	438c           	beqz.n	a3, 79e <NR_vad2+0x16e>
     798:	408814        	ae_lp16f.iu	aep0, a8, 2
     79b:	079014        	ae_addsp24s	aep1, aep1, aep0

0000079e <NR_vad2+0x16e>:
     79e:	28c222        	addi	a2, a2, 40
     7a1:	421204        	ae_sp16f.l.i	aep1, a2, 0
     7a4:	f01d           	retw.n

000007a6 <NR_vad2+0x176>:
	...

000007a8 <NR_NoiseEstimate>:
     7a8:	004136        	entry	a1, 32
     7ab:	2f0232        	l8ui	a3, a2, 47
     7ae:	0248           	l32i.n	a4, a2, 0
     7b0:	0e9272        	l16si	a7, a2, 28
     7b3:	039c           	beqz.n	a3, 7c7 <NR_NoiseEstimate+0x1f>
     7b5:	08d452        	addmi	a5, a4, 0x800
     7b8:	060c           	movi.n	a6, 0
     7ba:	1177c0        	slli	a7, a7, 4
     7bd:	068376        	loop	a3, 7c7 <NR_NoiseEstimate+0x1f>
     7c0:	0579           	s32i.n	a7, a5, 0
     7c2:	ee6562        	s32i	a6, a5, 0x3b8
     7c5:	554b           	addi.n	a5, a5, 4

000007c7 <NR_NoiseEstimate+0x1f>:
     7c7:	141262        	l16ui	a6, a2, 40
     7ca:	451c           	movi.n	a5, 20
     7cc:	2e0272        	l8ui	a7, a2, 46
     7cf:	613567        	bltu	a5, a6, 834 <NR_NoiseEstimate+0x8c>
     7d2:	075d           	mov.n	a5, a7
     7d4:	0576f6        	bgeui	a6, 7, 7dd <NR_NoiseEstimate+0x35>
     7d7:	cca062        	movi	a6, 204
     7da:	0002c6        	j	7e9 <NR_NoiseEstimate+0x41>

000007dd <NR_NoiseEstimate+0x35>:
     7dd:	05b6f6        	bgeui	a6, 16, 7e6 <NR_NoiseEstimate+0x3e>
     7e0:	d0a062        	movi	a6, 208
     7e3:	000086        	j	7e9 <NR_NoiseEstimate+0x41>

000007e6 <NR_NoiseEstimate+0x3e>:
     7e6:	d4a062        	movi	a6, 212
     7e9:	626a           	add.n	a6, a2, a6
     7eb:	045516        	beqz	a5, 834 <NR_NoiseEstimate+0x8c>
     7ee:	77a1a2        	movi	a10, 0x177
     7f1:	0668           	l32i.n	a6, a6, 0
     7f3:	3c2272        	l32i	a7, a2, 240
     7f6:	fe1791        	l32r	a9, 54 (24c0 <wb_sb_ptn>)
     7f9:	11aad0        	slli	a10, a10, 3
     7fc:	080c           	movi.n	a8, 0
     7fe:	a4aa           	add.n	a10, a4, a10
     800:	0007c6        	j	823 <NR_NoiseEstimate+0x7b>

00000803 <NR_NoiseEstimate+0x5b>:
     803:	881b           	addi.n	a8, a8, 1
     805:	90c890        	addx2	a12, a8, a9
     808:	2dbd           	ae_l16si.n	a11, a13, 0
     80a:	2ccd           	ae_l16si.n	a12, a12, 0
     80c:	10abc7        	bge	a11, a12, 820 <NR_NoiseEstimate+0x78>
     80f:	c0ccb0        	sub	a12, a12, a11
     812:	a0bba0        	addx4	a11, a11, a10
     815:	078c76        	loop	a12, 820 <NR_NoiseEstimate+0x78>
     818:	0bc8           	l32i.n	a12, a11, 0
     81a:	cc6a           	add.n	a12, a12, a6
     81c:	0bc9           	s32i.n	a12, a11, 0
     81e:	bb4b           	addi.n	a11, a11, 4

00000820 <NR_NoiseEstimate+0x78>:
     820:	101857        	beq	a8, a5, 834 <NR_NoiseEstimate+0x8c>

00000823 <NR_NoiseEstimate+0x7b>:
     823:	a0b870        	addx4	a11, a8, a7
     826:	0bb8           	l32i.n	a11, a11, 0
     828:	90d890        	addx2	a13, a8, a9
     82b:	d41ba6        	blti	a11, 1, 803 <NR_NoiseEstimate+0x5b>
     82e:	881b           	addi.n	a8, a8, 1
     830:	fffb06        	j	820 <NR_NoiseEstimate+0x78>

00000833 <NR_NoiseEstimate+0x8b>:
	...

00000834 <NR_NoiseEstimate+0x8c>:
     834:	6e9282        	l16si	a8, a2, 220
     837:	6f9292        	l16si	a9, a2, 222
     83a:	402262        	l32i	a6, a2, 0x100
     83d:	987d           	ae_zext16	a7, a8
     83f:	99ad           	ae_zext16	a10, a9
     841:	54cb           	addi.n	a5, a4, 12
     843:	2417a7        	beq	a7, a10, 86b <NR_NoiseEstimate+0xc3>
     846:	c09890        	sub	a9, a8, a9
     849:	a37a90        	movltz	a7, a10, a9
     84c:	539c           	beqz.n	a3, 865 <NR_NoiseEstimate+0xbd>
     84e:	06ad           	mov.n	a10, a6
     850:	a3a590        	movltz	a10, a5, a9
     853:	608190        	abs	a8, a9
     856:	fcca92        	addi	a9, a10, -4
     859:	088376        	loop	a3, 865 <NR_NoiseEstimate+0xbd>
     85c:	601914        	ae_lq32f.iu	aeq0, a9, 4
     85f:	3408a4        	ae_srlaq56	aeq0, aeq0, a8
     862:	620904        	ae_sq32f.i	aeq0, a9, 0

00000865 <NR_NoiseEstimate+0xbd>:
     865:	6f5272        	s16i	a7, a2, 222
     868:	6e5272        	s16i	a7, a2, 220

0000086b <NR_NoiseEstimate+0xc3>:
     86b:	fc2482ed7f 	{ movi	a7, 0x2ed; ae_zeroq56	aeq0 }
     870:	b3ac           	beqz.n	a3, 89f <NR_NoiseEstimate+0xf7>
     872:	1177e0        	slli	a7, a7, 2
     875:	604434        	ae_lq32f.i	aeq1, a4, 12
     878:	fcc662        	addi	a6, a6, -4
     87b:	447a           	add.n	a4, a4, a7
     87d:	1e8376        	loop	a3, 89f <NR_NoiseEstimate+0xf7>
     880:	448414        	ae_lp16x2f.iu	aep0, a4, 4
     883:	447d           	ae_l16ui.n	a7, a4, 0
     885:	609614        	ae_lq32f.iu	aeq2, a6, 4
     888:	c18894        	ae_mulzaafq32sp16s.lh	aeq3, aeq2, aep0, aeq1, aep0
     88b:	978c           	beqz.n	a7, 898 <NR_NoiseEstimate+0xf0>
     88d:	f87b3d351f 	{ ae_lq32f.iu	aeq1, a5, 4; ae_maxq56s	aeq0, aeq0, aeq3 }
     892:	623604        	ae_sq32f.i	aeq3, a6, 0
     895:	000106        	j	89d <NR_NoiseEstimate+0xf5>

00000898 <NR_NoiseEstimate+0xf0>:
     898:	f8733d351f 	{ ae_lq32f.iu	aeq1, a5, 4; ae_maxq56s	aeq0, aeq0, aeq2 }
     89d:	f03d           	nop.n

0000089f <NR_NoiseEstimate+0xf7>:
     89f:	364404        	ae_nsaq56s	a4, aeq0
     8a2:	950c           	movi.n	a5, 9
     8a4:	212457        	blt	a4, a5, 8c9 <NR_NoiseEstimate+0x121>
     8a7:	6f9262        	l16si	a6, a2, 222
     8aa:	f8c442        	addi	a4, a4, -8
     8ad:	402252        	l32i	a5, a2, 0x100
     8b0:	c06640        	sub	a6, a6, a4
     8b3:	6f5262        	s16i	a6, a2, 222
     8b6:	f38c           	beqz.n	a3, 8c9 <NR_NoiseEstimate+0x121>
     8b8:	fcc522        	addi	a2, a5, -4
     8bb:	f03d           	nop.n
     8bd:	088376        	loop	a3, 8c9 <NR_NoiseEstimate+0x121>
     8c0:	601214        	ae_lq32f.iu	aeq0, a2, 4
     8c3:	340494        	ae_sllaq56	aeq0, aeq0, a4
     8c6:	620204        	ae_sq32f.i	aeq0, a2, 0
     8c9:	f01d           	retw.n

000008cb <NR_NoiseEstimate+0x123>:
	...

000008cc <NR_NoiseWithGain>:
     8cc:	004136        	entry	a1, 32
     8cf:	141262        	l16ui	a6, a2, 40
     8d2:	0238           	l32i.n	a3, a2, 0
     8d4:	2e0242        	l8ui	a4, a2, 46
     8d7:	5c76b6        	bltui	a6, 7, 937 <NR_NoiseWithGain+0x6b>
     8da:	0f9272        	l16si	a7, a2, 30
     8dd:	056416        	beqz	a4, 937 <NR_NoiseWithGain+0x6b>
     8e0:	581c           	movi.n	a8, 21
     8e2:	626680        	saltu	a6, a6, a8
     8e5:	f71b           	addi.n	a15, a7, 1
     8e7:	4181f0        	srli	a8, a15, 1
     8ea:	40d882        	addmi	a8, a8, 0x4000
     8ed:	838760        	moveqz	a8, a7, a6
     8f0:	300884        	ae_cvtp24a16x2.ll	aep0, a8, a8
     8f3:	3c2252        	l32i	a5, a2, 240
     8f6:	fdd781        	l32r	a8, 54 (24c0 <wb_sb_ptn>)
     8f9:	08d362        	addmi	a6, a3, 0x800
     8fc:	070c           	movi.n	a7, 0

000008fe <NR_NoiseWithGain+0x32>:
     8fe:	a09750        	addx4	a9, a7, a5
     901:	0998           	l32i.n	a9, a9, 0
     903:	90b780        	addx2	a11, a7, a8
     906:	2819a6        	blti	a9, 1, 932 <NR_NoiseWithGain+0x66>
     909:	771b           	addi.n	a7, a7, 1
     90b:	90a780        	addx2	a10, a7, a8
     90e:	2b9d           	ae_l16si.n	a9, a11, 0
     910:	2aad           	ae_l16si.n	a10, a10, 0
     912:	a0b960        	addx4	a11, a9, a6
     915:	13a9a7        	bge	a9, a10, 92c <NR_NoiseWithGain+0x60>
     918:	c0aa90        	sub	a10, a10, a9
     91b:	fccb92        	addi	a9, a11, -4
     91e:	0a8a76        	loop	a10, 92c <NR_NoiseWithGain+0x60>
     921:	601914        	ae_lq32f.iu	aeq0, a9, 4
     924:	030214        	ae_mulfq32sp16s.l	aeq0, aeq0, aep0
     927:	368a04        	ae_trunca32q48	a10, aeq0
     92a:	09a9           	s32i.n	a10, a9, 0

0000092c <NR_NoiseWithGain+0x60>:
     92c:	ce9747        	bne	a7, a4, 8fe <NR_NoiseWithGain+0x32>
     92f:	000106        	j	937 <NR_NoiseWithGain+0x6b>

00000932 <NR_NoiseWithGain+0x66>:
     932:	771b           	addi.n	a7, a7, 1
     934:	fffd06        	j	92c <NR_NoiseWithGain+0x60>

00000937 <NR_NoiseWithGain+0x6b>:
     937:	6f9242        	l16si	a4, a2, 222
     93a:	2f0252        	l8ui	a5, a2, 47
     93d:	402272        	l32i	a7, a2, 0x100
     940:	446b           	addi.n	a4, a4, 6
     942:	705242        	s16i	a4, a2, 224
     945:	c59c           	beqz.n	a5, 965 <NR_NoiseWithGain+0x99>
     947:	08d342        	addmi	a4, a3, 0x800
     94a:	fca762        	movi	a6, 0x7fc
     94d:	4c0404        	ae_lp24.i	aep0, a4, 0
     950:	336a           	add.n	a3, a3, a6
     952:	600704        	ae_lq32f.i	aeq0, a7, 0
     955:	072d           	mov.n	a2, a7
     957:	0a8576        	loop	a5, 965 <NR_NoiseWithGain+0x99>
     95a:	f8e071841f 	{ ae_lp24.iu	aep0, a4, 4; ae_mulrfq32sp24s.l	aeq1, aeq0, aep0 }
     95f:	601214        	ae_lq32f.iu	aeq0, a2, 4
     962:	625314        	ae_sq32f.iu	aeq1, a3, 4

00000965 <NR_NoiseWithGain+0x99>:
     965:	f01d           	retw.n

00000967 <NR_NoiseWithGain+0x9b>:
	...

00000968 <common_gain_limiter>:
     968:	004136        	entry	a1, 32
     96b:	025d           	mov.n	a5, a2
     96d:	032d           	mov.n	a2, a3
     96f:	1015a6        	blti	a5, 1, 983 <common_gain_limiter+0x1b>
     972:	378444        	ae_truncp24a32x2	aep0, a4, a4
     975:	401204        	ae_lp16f.i	aep1, a2, 0
     978:	078576        	loop	a5, 983 <common_gain_limiter+0x1b>
     97b:	d9222c922f 	{ ae_lp16f.iu	aep1, a2, 4; ae_maxp24s	aep2, aep0, aep1 }
     980:	5222f4        	ae_sp24f.l.i	aep2, a2, -4

00000983 <common_gain_limiter+0x1b>:
     983:	f01d           	retw.n

00000985 <common_gain_limiter+0x1d>:
     985:	000000                                        ...

00000988 <NR_WienerFilter>:
     988:	004136        	entry	a1, 32
     98b:	0268           	l32i.n	a6, a2, 0
     98d:	6e92a2        	l16si	a10, a2, 220
     990:	7192b2        	l16si	a11, a2, 226
     993:	2f0232        	l8ui	a3, a2, 47
     996:	96cb           	addi.n	a9, a6, 12
     998:	040c           	movi.n	a4, 0
     99a:	08d672        	addmi	a7, a6, 0x800
     99d:	0a5d           	mov.n	a5, a10
     99f:	098d           	mov.n	a8, a9
     9a1:	07aab7        	bge	a10, a11, 9ac <NR_WienerFilter+0x24>
     9a4:	412282        	l32i	a8, a2, 0x104
     9a7:	140c           	movi.n	a4, 1
     9a9:	205bb0        	or	a5, a11, a11

000009ac <NR_WienerFilter+0x24>:
     9ac:	7092c2        	l16si	a12, a2, 224
     9af:	72d5c0        	salt	a13, a5, a12
     9b2:	5355c0        	max	a5, a5, a12
     9b5:	9387d0        	movnez	a8, a7, a13
     9b8:	1c15a7        	beq	a5, a10, 9d8 <NR_WienerFilter+0x50>
     9bb:	939c           	beqz.n	a3, 9d8 <NR_WienerFilter+0x50>
     9bd:	c0b5a0        	sub	a11, a5, a10
     9c0:	a398b0        	movltz	a9, a8, a11
     9c3:	60a1b0        	abs	a10, a11
     9c6:	fcc992        	addi	a9, a9, -4
     9c9:	088376        	loop	a3, 9d5 <NR_WienerFilter+0x4d>
     9cc:	601914        	ae_lq32f.iu	aeq0, a9, 4
     9cf:	340aa4        	ae_srlaq56	aeq0, aeq0, a10
     9d2:	620904        	ae_sq32f.i	aeq0, a9, 0

000009d5 <NR_WienerFilter+0x4d>:
     9d5:	7112b2        	l16ui	a11, a2, 226

000009d8 <NR_WienerFilter+0x50>:
     9d8:	8b9d           	ae_sext16	a9, a11
     9da:	1c1597        	beq	a5, a9, 9fa <NR_WienerFilter+0x72>
     9dd:	939c           	beqz.n	a3, 9fa <NR_WienerFilter+0x72>
     9df:	4122b2        	l32i	a11, a2, 0x104
     9e2:	c0a590        	sub	a10, a5, a9
     9e5:	6091a0        	abs	a9, a10
     9e8:	a3b8a0        	movltz	a11, a8, a10
     9eb:	fccba2        	addi	a10, a11, -4
     9ee:	088376        	loop	a3, 9fa <NR_WienerFilter+0x72>
     9f1:	601a14        	ae_lq32f.iu	aeq0, a10, 4
     9f4:	3409a4        	ae_srlaq56	aeq0, aeq0, a9
     9f7:	620a04        	ae_sq32f.i	aeq0, a10, 0

000009fa <NR_WienerFilter+0x72>:
     9fa:	709292        	l16si	a9, a2, 224
     9fd:	191597        	beq	a5, a9, a1a <NR_WienerFilter+0x92>
     a00:	639c           	beqz.n	a3, a1a <NR_WienerFilter+0x92>
     a02:	c0a590        	sub	a10, a5, a9
     a05:	b387a0        	movgez	a8, a7, a10
     a08:	6091a0        	abs	a9, a10
     a0b:	fcc882        	addi	a8, a8, -4
     a0e:	088376        	loop	a3, a1a <NR_WienerFilter+0x92>
     a11:	601814        	ae_lq32f.iu	aeq0, a8, 4
     a14:	3409a4        	ae_srlaq56	aeq0, aeq0, a9
     a17:	620804        	ae_sq32f.i	aeq0, a8, 0
     a1a:	6e5252        	s16i	a5, a2, 220
     a1d:	705252        	s16i	a5, a2, 224
     a20:	715252        	s16i	a5, a2, 226
     a23:	412252        	l32i	a5, a2, 0x104
     a26:	668b           	addi.n	a6, a6, 8
     a28:	109316        	beqz	a3, b35 <NR_WienerFilter+0x1ad>
     a2b:	180c           	movi.n	a8, 1
     a2d:	ffa092        	movi	a9, 255
     a30:	d8a0b2        	movi	a11, 216
     a33:	4502b4        	ae_lp16x2f.x	aep0, a2, a11
     a36:	600704        	ae_lq32f.i	aeq0, a7, 0
     a39:	604504        	ae_lq32f.i	aeq1, a5, 0
     a3c:	118810        	slli	a8, a8, 15
     a3f:	7fd992        	addmi	a9, a9, 0x7f00
     a42:	f96a13a66f 	{ or	a10, a6, a6; ae_addq56	aeq1, aeq1, aeq0 }
     a47:	05bd           	mov.n	a11, a5
     a49:	3a8376        	loop	a3, a87 <NR_WienerFilter+0xff>
     a4c:	609a14        	ae_lq32f.iu	aeq2, a10, 4
     a4f:	0e00ff0caf 	{ ae_nsaq56s	a12, aeq0; ae_mulzaafq32sp16s.lh	aeq1, aeq2, aep0, aeq1, aep0 }
     a54:	08ed           	mov.n	a14, a8
     a56:	365d04        	ae_nsaq56s	a13, aeq1
     a59:	43ccd0        	min	a12, a12, a13
     a5c:	e9ccd2        	addi	a13, a12, -23
     a5f:	fc24fe9d4f 	{ ae_slaasq56s	aeq1, aeq1, a13; nop }
     a64:	369d04        	ae_trunca32q48	a13, aeq1
     a67:	38ccc2        	addi	a12, a12, 56
     a6a:	340c94        	ae_sllaq56	aeq0, aeq0, a12
     a6d:	4d8c           	beqz.n	a13, a75 <NR_WienerFilter+0xed>
     a6f:	368c04        	ae_trunca32q48	a12, aeq0
     a72:	d2ecd0        	quos	a14, a12, a13

00000a75 <NR_WienerFilter+0xed>:
     a75:	0bdd           	mov.n	a13, a11
     a77:	c0c9e0        	sub	a12, a9, a14
     a7a:	605d14        	ae_lq32f.iu	aeq1, a13, 4
     a7d:	601714        	ae_lq32f.iu	aeq0, a7, 4
     a80:	f96a140bcf 	{ s32i.n	a12, a11, 0; ae_addq56	aeq1, aeq1, aeq0 }
     a85:	0dbd           	mov.n	a11, a13

00000a87 <NR_WienerFilter+0xff>:
     a87:	79a082        	movi	a8, 121
     a8a:	22c272        	addi	a7, a2, 34
     a8d:	02b387        	bgeu	a3, a8, a93 <NR_WienerFilter+0x10b>
     a90:	002b46        	j	b41 <NR_WienerFilter+0x1b9>
     a93:	8a9282        	l16si	a8, a2, 0x114
     a96:	059d           	mov.n	a9, a5
     a98:	10a1a2        	movi	a10, 0x110
     a9b:	2418a6        	blti	a8, 1, ac3 <NR_WienerFilter+0x13b>
     a9e:	6022a4        	ae_lq32f.x	aeq0, a2, a10
     aa1:	400704        	ae_lp16f.i	aep0, a7, 0
     aa4:	d4e22c150f 	{ ae_lp16f.i	aep1, a5, 0; ae_mulfq32sp16s.l	aeq0, aeq0, aep0 }
     aa9:	059d           	mov.n	a9, a5
     aab:	368f04        	ae_trunca32q48	a15, aeq0
     aae:	378ff4        	ae_truncp24a32x2	aep0, a15, a15
     ab1:	f03d           	nop.n
     ab3:	f03d           	nop.n
     ab5:	078876        	loop	a8, ac0 <NR_WienerFilter+0x138>
     ab8:	d9222c992f 	{ ae_lp16f.iu	aep1, a9, 4; ae_maxp24s	aep2, aep0, aep1 }
     abd:	5229f4        	ae_sp24f.l.i	aep2, a9, -4
     ac0:	8a9282        	l16si	a8, a2, 0x114

00000ac3 <NR_WienerFilter+0x13b>:
     ac3:	1192a2        	l16si	a10, a2, 34
     ac6:	8b92b2        	l16si	a11, a2, 0x116
     ac9:	11aa00        	slli	a10, a10, 16
     acc:	c08b80        	sub	a8, a11, a8
     acf:	378aa4        	ae_truncp24a32x2	aep0, a10, a10
     ad2:	1018a6        	blti	a8, 1, ae6 <NR_WienerFilter+0x15e>
     ad5:	401904        	ae_lp16f.i	aep1, a9, 0
     ad8:	078876        	loop	a8, ae3 <NR_WienerFilter+0x15b>
     adb:	d9222c992f 	{ ae_lp16f.iu	aep1, a9, 4; ae_maxp24s	aep2, aep0, aep1 }
     ae0:	5229f4        	ae_sp24f.l.i	aep2, a9, -4

00000ae3 <NR_WienerFilter+0x15b>:
     ae3:	8b92b2        	l16si	a11, a2, 0x116

00000ae6 <NR_WienerFilter+0x15e>:
     ae6:	fd5ba1        	l32r	a10, 54 (24c0 <wb_sb_ptn>)
     ae9:	0ca182        	movi	a8, 0x10c
     aec:	603824        	ae_lq32f.xu	aeq0, a8, a2
     aef:	d4e2208ace 	{ l16si	a12, a10, 16; ae_mulfq32sp16s.l	aeq0, aeq0, aep0 }
     af4:	368d04        	ae_trunca32q48	a13, aeq0
     af7:	c0bcb0        	sub	a11, a12, a11
     afa:	378dd4        	ae_truncp24a32x2	aep0, a13, a13
     afd:	121ba6        	blti	a11, 1, b13 <NR_WienerFilter+0x18b>
     b00:	401904        	ae_lp16f.i	aep1, a9, 0
     b03:	f03d           	nop.n
     b05:	078b76        	loop	a11, b10 <NR_WienerFilter+0x188>
     b08:	d9222c992f 	{ ae_lp16f.iu	aep1, a9, 4; ae_maxp24s	aep2, aep0, aep1 }
     b0d:	5229f4        	ae_sp24f.l.i	aep2, a9, -4

00000b10 <NR_WienerFilter+0x188>:
     b10:	089ac2        	l16si	a12, a10, 16

00000b13 <NR_WienerFilter+0x18b>:
     b13:	501804        	ae_lp24f.i	aep1, a8, 0
     b16:	ea2195a3cf 	{ sub	a10, a3, a12; ae_mulfp24s.ll	aeq0, aep0, aep1 }
     b1b:	368804        	ae_trunca32q48	a8, aeq0
     b1e:	371aa6        	blti	a10, 1, b59 <NR_WienerFilter+0x1d1>
     b21:	378884        	ae_truncp24a32x2	aep0, a8, a8
     b24:	401904        	ae_lp16f.i	aep1, a9, 0
     b27:	078a76        	loop	a10, b32 <NR_WienerFilter+0x1aa>
     b2a:	d9222c992f 	{ ae_lp16f.iu	aep1, a9, 4; ae_maxp24s	aep2, aep0, aep1 }
     b2f:	5229f4        	ae_sp24f.l.i	aep2, a9, -4

00000b32 <NR_WienerFilter+0x1aa>:
     b32:	0008c6        	j	b59 <NR_WienerFilter+0x1d1>

00000b35 <NR_WienerFilter+0x1ad>:
     b35:	119282        	l16si	a8, a2, 34
     b38:	22c272        	addi	a7, a2, 34
     b3b:	118800        	slli	a8, a8, 16
     b3e:	0005c6        	j	b59 <NR_WienerFilter+0x1d1>

00000b41 <NR_WienerFilter+0x1b9>:
     b41:	278d           	ae_l16si.n	a8, a7, 0
     b43:	400504        	ae_lp16f.i	aep0, a5, 0
     b46:	059d           	mov.n	a9, a5
     b48:	118800        	slli	a8, a8, 16
     b4b:	379884        	ae_truncp24a32x2	aep1, a8, a8
     b4e:	078376        	loop	a3, b59 <NR_WienerFilter+0x1d1>
     b51:	d9062c892f 	{ ae_lp16f.iu	aep0, a9, 4; ae_maxp24s	aep2, aep1, aep0 }
     b56:	5229f4        	ae_sp24f.l.i	aep2, a9, -4

00000b59 <NR_WienerFilter+0x1d1>:
     b59:	4422e2        	l32i	a14, a2, 0x110
     b5c:	400704        	ae_lp16f.i	aep0, a7, 0
     b5f:	360e34        	ae_cvtq48a32s	aeq0, a14
     b62:	d4e23002fe 	{ l32i	a15, a2, 0; ae_mulfq32sp16s.l	aeq0, aeq0, aep0 }
     b67:	f8e780009f 	{ movi	a9, 0; ae_roundsp24q48sym	aep0, aeq0 }
     b6c:	fccf72        	addi	a7, a15, -4
     b6f:	528714        	ae_sp24f.l.iu	aep0, a7, 4
     b72:	528714        	ae_sp24f.l.iu	aep0, a7, 4
     b75:	528714        	ae_sp24f.l.iu	aep0, a7, 4
     b78:	092316        	beqz	a3, c0e <NR_WienerFilter+0x286>
     b7b:	4122a2        	l32i	a10, a2, 0x104
     b7e:	500a04        	ae_lp24f.i	aep0, a10, 0
     b81:	178376        	loop	a3, b9c <NR_WienerFilter+0x214>
     b84:	601614        	ae_lq32f.iu	aeq0, a6, 4
     b87:	080524        	ae_mulfq32sp24s.l	aeq0, aeq0, aep0
     b8a:	080514        	ae_mulrfq32sp24s.l	aeq0, aeq0, aep0
     b8d:	368b04        	ae_trunca32q48	a11, aeq0
     b90:	620a04        	ae_sq32f.i	aeq0, a10, 0
     b93:	528714        	ae_sp24f.l.iu	aep0, a7, 4
     b96:	508a14        	ae_lp24f.iu	aep0, a10, 4
     b99:	5399b0        	max	a9, a9, a11
     b9c:	b49c           	beqz.n	a4, bbb <NR_WienerFilter+0x233>
     b9e:	719262        	l16si	a6, a2, 226
     ba1:	40e940        	nsa	a4, a9
     ba4:	c06640        	sub	a6, a6, a4
     ba7:	715262        	s16i	a6, a2, 226
     baa:	d38c           	beqz.n	a3, bbb <NR_WienerFilter+0x233>
     bac:	401400        	ssl	a4
     baf:	088376        	loop	a3, bbb <NR_WienerFilter+0x233>
     bb2:	0538           	l32i.n	a3, a5, 0
     bb4:	a13300        	sll	a3, a3
     bb7:	0539           	s32i.n	a3, a5, 0
     bb9:	554b           	addi.n	a5, a5, 4
     bbb:	2e0232        	l8ui	a3, a2, 46
     bbe:	0fa042        	movi	a4, 15
     bc1:	05a052        	movi	a5, 5
     bc4:	413330        	srli	a3, a3, 3
     bc7:	935430        	movnez	a5, a4, a3
     bca:	378884        	ae_truncp24a32x2	aep0, a8, a8
     bcd:	028576        	loop	a5, bd3 <NR_WienerFilter+0x24b>
     bd0:	528714        	ae_sp24f.l.iu	aep0, a7, 4

00000bd3 <NR_WienerFilter+0x24b>:
     bd3:	00a142        	movi	a4, 0x100
     bd6:	80a052        	movi	a5, 128
     bd9:	0022f2        	l32i	a15, a2, 0
     bdc:	935430        	movnez	a5, a4, a3
     bdf:	3a2232        	l32i	a3, a2, 232
     be2:	392222        	l32i	a2, a2, 228
     be5:	fccf42        	addi	a4, a15, -4
     be8:	5c1304        	ae_lp24x2f.i	aep1, a3, 0
     beb:	402204        	ae_lp16f.i	aep2, a2, 0
     bee:	508414        	ae_lp24f.iu	aep0, a4, 4
     bf1:	178576        	loop	a5, c0c <NR_WienerFilter+0x284>
     bf4:	011254        	ae_mulfp24s.hl	aeq0, aep1, aep2
     bf7:	ea45ef931f 	{ ae_lp24x2f.iu	aep1, a3, 8; ae_mulfp24s.ll	aeq1, aep1, aep2 }
     bfc:	f8e02ca21f 	{ ae_lp16f.iu	aep2, a2, 2; ae_mulrfq32sp24s.l	aeq0, aeq0, aep0 }
     c01:	f8e16e841f 	{ ae_lp24f.iu	aep0, a4, 4; ae_mulrfq32sp24s.l	aeq1, aeq1, aep0 }
     c06:	6203e4        	ae_sq32f.i	aeq0, a3, -8
     c09:	6213f4        	ae_sq32f.i	aeq1, a3, -4
     c0c:	f01d           	retw.n

00000c0e <NR_WienerFilter+0x286>:
     c0e:	090c           	movi.n	a9, 0
     c10:	ffe206        	j	b9c <NR_WienerFilter+0x214>

00000c13 <NR_WienerFilter+0x28b>:
	...

00000c14 <ifft_wo_single>:
     c14:	004136        	entry	a1, 32
     c17:	fd1291        	l32r	a9, 60 (21a0 <NR_immediate_num>)
     c1a:	fd0b71        	l32r	a7, 48 (2830 <fftorder_512_12b>)
     c1d:	2e02c2        	l8ui	a12, a2, 46
     c20:	fc20c200af 	{ movi	a10, 0x200; ae_zerop48	aep1 }
     c25:	00a142        	movi	a4, 0x100
     c28:	0258           	l32i.n	a5, a2, 0
     c2a:	440904        	ae_lp16x2f.i	aep0, a9, 0
     c2d:	442914        	ae_lp16x2f.i	aep2, a9, 4
     c30:	f72b           	addi.n	a15, a7, 2
     c32:	974b           	addi.n	a9, a7, 4
     c34:	4173c0        	srli	a7, a12, 3
     c37:	934a70        	movnez	a4, a10, a7
     c3a:	3a22a2        	l32i	a10, a2, 232
     c3d:	060c           	movi.n	a6, 0
     c3f:	2b0c           	movi.n	a11, 2
     c41:	480c           	movi.n	a8, 4
     c43:	938b70        	movnez	a8, a11, a7
     c46:	016562        	s32i	a6, a5, 4
     c49:	006562        	s32i	a6, a5, 0
     c4c:	41b140        	srli	a11, a4, 1
     c4f:	939f70        	movnez	a9, a15, a7
     c52:	5c3a04        	ae_lp24x2f.i	aep3, a10, 0
     c55:	168b76        	loop	a11, c6f <ifft_wo_single+0x5b>
     c58:	df2dfe391f 	{ ae_selp24.hl	aep4, aep3, aep1; ae_selp24.lh	aep7, aep3, aep1 }
     c5d:	f012a0096e 	{ l16si	a6, a9, 0; ae_mulzaafp24s.hh.ll	aeq0, aep4, aep0 }
     c62:	f05eefba1f 	{ ae_lp24x2f.iu	aep3, a10, 8; ae_mulzaafp24s.hh.ll	aeq1, aep7, aep2 }
     c67:	998a           	add.n	a9, a9, a8
     c69:	098d44        	ae_truncp24q48x2	aep4, aeq0, aeq1
     c6c:	5f4564        	ae_sp24x2f.x	aep4, a5, a6

00000c6f <ifft_wo_single+0x5b>:
     c6f:	fd5800f0cf 	{ movi	a12, 240; ae_negsp24s	aep2, aep2 }
     c74:	78a062        	movi	a6, 120
     c77:	bb0b           	addi.n	a11, a11, -1
     c79:	5cbae4        	ae_lp24x2f.iu	aep3, a10, -16
     c7c:	936c70        	movnez	a6, a12, a7
     c7f:	168b76        	loop	a11, c99 <ifft_wo_single+0x85>
     c82:	df2dfe391f 	{ ae_selp24.hl	aep4, aep3, aep1; ae_selp24.lh	aep7, aep3, aep1 }
     c87:	f052a009be 	{ l16si	a11, a9, 0; ae_mulzaafp24s.hh.ll	aeq0, aep4, aep2 }
     c8c:	f01eefbaff 	{ ae_lp24x2f.iu	aep3, a10, -8; ae_mulzaafp24s.hh.ll	aeq1, aep7, aep0 }
     c91:	998a           	add.n	a9, a9, a8
     c93:	098d44        	ae_truncp24q48x2	aep4, aeq0, aeq1
     c96:	5f45b4        	ae_sp24x2f.x	aep4, a5, a11
     c99:	fcec81        	l32r	a8, 4c (168c <sw_fft_32b_2811>)
     c9c:	8c0c           	movi.n	a12, 8
     c9e:	0d0c           	movi.n	a13, 0
     ca0:	1e0c           	movi.n	a14, 1
     ca2:	05ad           	mov.n	a10, a5
     ca4:	04bd           	mov.n	a11, a4
     ca6:	0008e0        	callx8	a8
     ca9:	3f22b2        	l32i	a11, a2, 252
     cac:	139292        	l16si	a9, a2, 38
     caf:	b87c           	movi.n	a8, -5
     cb1:	cd7c           	movi.n	a13, -4
     cb3:	3d22e2        	l32i	a14, a2, 244
     cb6:	93d870        	movnez	a13, a8, a7
     cb9:	10a1c2        	movi	a12, 0x110
     cbc:	88a082        	movi	a8, 136
     cbf:	938c70        	movnez	a8, a12, a7
     cc2:	fdaa           	add.n	a15, a13, a10
     cc4:	fecb72        	addi	a7, a11, -2
     cc7:	c02f90        	sub	a2, a15, a9
     cca:	fec3c2        	addi	a12, a3, -2
     ccd:	600504        	ae_lq32f.i	aeq0, a5, 0
     cd0:	fecea2        	addi	a10, a14, -2
     cd3:	9098e0        	addx2	a9, a8, a14
     cd6:	07dd           	mov.n	a13, a7
     cd8:	1c8676        	loop	a6, cf8 <ifft_wo_single+0xe4>
     cdb:	fc24fe820f 	{ ae_slaasq56s	aeq0, aeq0, a2; nop }
     ce0:	fc446c8d1f 	{ ae_lp16f.iu	aep0, a13, 2; ae_roundsq32sym	aeq0, aeq0 }
     ce5:	4099f4        	ae_lp16f.iu	aep1, a9, -2
     ce8:	ea20ecfa1f 	{ ae_lp16f.iu	aep7, a10, 2; ae_mulfp24s.hl	aeq1, aep0, aep1 }
     ced:	f49efd152f 	{ ae_lq32f.iu	aeq0, a5, 8; ae_mulafq32sp16s.l	aeq1, aeq0, aep7 }
     cf2:	1b9e04        	ae_roundsp16q48sym	aep0, aeq1
     cf5:	428c14        	ae_sp16f.l.iu	aep0, a12, 2
     cf8:	11a6f0        	slli	a10, a6, 1
     cfb:	c0a4a0        	sub	a10, a4, a10
     cfe:	291aa6        	blti	a10, 1, d2b <ifft_wo_single+0x117>
     d01:	9046b0        	addx2	a4, a6, a11
     d04:	90f8b0        	addx2	a15, a8, a11
     d07:	400304        	ae_lp16f.i	aep0, a3, 0
     d0a:	fec442        	addi	a4, a4, -2
     d0d:	fecf62        	addi	a6, a15, -2
     d10:	178a76        	loop	a10, d2b <ifft_wo_single+0x117>
     d13:	fc0c2c99ff 	{ ae_lp16f.iu	aep1, a9, -2; ae_cvtq48p24s.l	aeq0, aep0 }
     d18:	40e614        	ae_lp16f.iu	aep6, a6, 2
     d1b:	e23b2cf41f 	{ ae_lp16f.iu	aep7, a4, 2; ae_mulafp24s.hl	aeq0, aep6, aep1 }
     d20:	408314        	ae_lp16f.iu	aep0, a3, 2
     d23:	f9e3b2760f 	{ ae_sp16f.l.i	aep7, a6, 0; ae_roundsp16q48sym	aep2, aeq0 }
     d28:	4223f4        	ae_sp16f.l.i	aep2, a3, -2

00000d2b <ifft_wo_single+0x117>:
     d2b:	600504        	ae_lq32f.i	aeq0, a5, 0
     d2e:	0c8876        	loop	a8, d3e <ifft_wo_single+0x12a>
     d31:	fc24fe824f 	{ ae_slaasq56s	aeq1, aeq0, a2; nop }
     d36:	f8ebbd152f 	{ ae_lq32f.iu	aeq0, a5, 8; ae_roundsp16q48sym	aep0, aeq1 }
     d3b:	428714        	ae_sp16f.l.iu	aep0, a7, 2

00000d3e <ifft_wo_single+0x12a>:
     d3e:	f01d           	retw.n

00000d40 <xtensa_fft4_32b>:
     d40:	00c136        	entry	a1, 96
     d43:	600254        	ae_lq32f.i	aeq0, a2, 20
     d46:	604274        	ae_lq32f.i	aeq1, a2, 28
     d49:	fa663d626f 	{ ae_lq32f.i	aeq3, a2, 24; ae_addq56	aeq2, aeq0, aeq1 }
     d4e:	f826fa217f 	{ ae_sq56s.i	aeq2, a1, 56; ae_subq56	aeq0, aeq0, aeq1 }
     d53:	630134        	ae_sq56s.i	aeq0, a1, 24
     d56:	600244        	ae_lq32f.i	aeq0, a2, 16
     d59:	fa7a3d220f 	{ ae_lq32f.i	aeq1, a2, 0; ae_addq56	aeq2, aeq3, aeq0 }
     d5e:	f83afa211f 	{ ae_sq56s.i	aeq2, a1, 8; ae_subq56	aeq0, aeq3, aeq0 }
     d63:	630164        	ae_sq56s.i	aeq0, a1, 48
     d66:	600224        	ae_lq32f.i	aeq0, a2, 8
     d69:	fb6a3dc11f 	{ ae_lq56.i	aeq2, a1, 8; ae_addq56	aeq3, aeq1, aeq0 }
     d6e:	01bac4        	ae_addq56	aeq2, aeq3, aeq2
     d71:	f82afa212f 	{ ae_sq56s.i	aeq2, a1, 16; ae_subq56	aeq0, aeq1, aeq0 }
     d76:	618124        	ae_lq56.i	aeq2, a1, 16
     d79:	622204        	ae_sq32f.i	aeq2, a2, 0
     d7c:	618114        	ae_lq56.i	aeq2, a1, 8
     d7f:	f9bafd621f 	{ ae_lq32f.i	aeq3, a2, 4; ae_subq56	aeq1, aeq3, aeq2 }
     d84:	631114        	ae_sq56s.i	aeq1, a1, 8
     d87:	614134        	ae_lq56.i	aeq1, a1, 24
     d8a:	fb663a315f 	{ ae_sq56s.i	aeq3, a1, 40; ae_addq56	aeq3, aeq0, aeq1 }
     d8f:	f826fd423f 	{ ae_lq32f.i	aeq2, a2, 12; ae_subq56	aeq0, aeq0, aeq1 }
     d94:	633124        	ae_sq56s.i	aeq3, a1, 16
     d97:	614114        	ae_lq56.i	aeq1, a1, 8
     d9a:	61c154        	ae_lq56.i	aeq3, a1, 40
     d9d:	630134        	ae_sq56s.i	aeq0, a1, 24
     da0:	f9fa39924f 	{ ae_sq32f.i	aeq1, a2, 16; ae_addq56	aeq1, aeq3, aeq2 }
     da5:	632144        	ae_sq56s.i	aeq2, a1, 32
     da8:	618124        	ae_lq56.i	aeq2, a1, 16
     dab:	610174        	ae_lq56.i	aeq0, a1, 56
     dae:	fa6a39a22f 	{ ae_sq32f.i	aeq2, a2, 8; ae_addq56	aeq2, aeq1, aeq0 }
     db3:	f82afa211f 	{ ae_sq56s.i	aeq2, a1, 8; ae_subq56	aeq0, aeq1, aeq0 }
     db8:	618134        	ae_lq56.i	aeq2, a1, 24
     dbb:	622264        	ae_sq32f.i	aeq2, a2, 24
     dbe:	618144        	ae_lq56.i	aeq2, a1, 32
     dc1:	f9baf9825f 	{ ae_sq32f.i	aeq0, a2, 20; ae_subq56	aeq1, aeq3, aeq2 }
     dc6:	610164        	ae_lq56.i	aeq0, a1, 48
     dc9:	fb6a3dc11f 	{ ae_lq56.i	aeq2, a1, 8; ae_addq56	aeq3, aeq1, aeq0 }
     dce:	f92af9a21f 	{ ae_sq32f.i	aeq2, a2, 4; ae_subq56	aeq1, aeq1, aeq0 }
     dd3:	623234        	ae_sq32f.i	aeq3, a2, 12
     dd6:	621274        	ae_sq32f.i	aeq1, a2, 28
     dd9:	f01d           	retw.n

00000ddb <xtensa_fft4_32b+0x9b>:
	...

00000ddc <xtensa_fft8_32b>:
     ddc:	022136        	entry	a1, 0x110
     ddf:	600254        	ae_lq32f.i	aeq0, a2, 20
     de2:	604274        	ae_lq32f.i	aeq1, a2, 28
     de5:	fb663d426f 	{ ae_lq32f.i	aeq2, a2, 24; ae_addq56	aeq3, aeq0, aeq1 }
     dea:	f826fa315f 	{ ae_sq56s.i	aeq3, a1, 40; ae_subq56	aeq0, aeq0, aeq1 }
     def:	630124        	ae_sq56s.i	aeq0, a1, 16
     df2:	600244        	ae_lq32f.i	aeq0, a2, 16
     df5:	f9723d620f 	{ ae_lq32f.i	aeq3, a2, 0; ae_addq56	aeq1, aeq2, aeq0 }
     dfa:	f832c7816e 	{ addi	a6, a1, 120; ae_subq56	aeq0, aeq2, aeq0 }
     dff:	630134        	ae_sq56s.i	aeq0, a1, 24
     e02:	600224        	ae_lq32f.i	aeq0, a2, 8
     e05:	01b8c4        	ae_addq56	aeq2, aeq3, aeq0
     e08:	fa3afa211f 	{ ae_sq56s.i	aeq2, a1, 8; ae_subq56	aeq2, aeq3, aeq0 }
     e0d:	61c114        	ae_lq56.i	aeq3, a1, 8
     e10:	f83efd621f 	{ ae_lq32f.i	aeq3, a2, 4; ae_subq56	aeq0, aeq3, aeq1 }
     e15:	6306c4        	ae_sq56s.i	aeq0, a6, -32
     e18:	610124        	ae_lq56.i	aeq0, a1, 16
     e1b:	fb723a314f 	{ ae_sq56s.i	aeq3, a1, 32; ae_addq56	aeq3, aeq2, aeq0 }
     e20:	fa32fd86cf 	{ ae_lq56.i	aeq0, a6, -32; ae_subq56	aeq2, aeq2, aeq0 }
     e25:	6316e4        	ae_sq56s.i	aeq1, a6, -16
     e28:	620244        	ae_sq32f.i	aeq0, a2, 16
     e2b:	604234        	ae_lq32f.i	aeq1, a2, 12
     e2e:	610144        	ae_lq56.i	aeq0, a1, 32
     e31:	f8663a364f 	{ ae_sq56s.i	aeq3, a6, 32; ae_addq56	aeq0, aeq0, aeq1 }
     e36:	623224        	ae_sq32f.i	aeq3, a2, 8
     e39:	61c154        	ae_lq56.i	aeq3, a1, 40
     e3c:	fba6fa06df 	{ ae_sq56s.i	aeq0, a6, -24; ae_subq56	aeq3, aeq0, aeq3 }
     e41:	610144        	ae_lq56.i	aeq0, a1, 32
     e44:	f826fa36ff 	{ ae_sq56s.i	aeq3, a6, -8; ae_subq56	aeq0, aeq0, aeq1 }
     e49:	623254        	ae_sq32f.i	aeq3, a2, 20
     e4c:	61c134        	ae_lq56.i	aeq3, a1, 24
     e4f:	f9e602023e 	{ addi	a3, a2, 32; ae_addq56	aeq1, aeq0, aeq3 }
     e54:	f8a6fa163f 	{ ae_sq56s.i	aeq1, a6, 24; ae_subq56	aeq0, aeq0, aeq3 }
     e59:	621234        	ae_sq32f.i	aeq1, a2, 12
     e5c:	604304        	ae_lq32f.i	aeq1, a3, 0
     e5f:	6316b4        	ae_sq56s.i	aeq1, a6, -40
     e62:	632664        	ae_sq56s.i	aeq2, a6, 48
     e65:	622264        	ae_sq32f.i	aeq2, a2, 24
     e68:	608314        	ae_lq32f.i	aeq2, a3, 4
     e6b:	630654        	ae_sq56s.i	aeq0, a6, 40
     e6e:	620274        	ae_sq32f.i	aeq0, a2, 28
     e71:	600374        	ae_lq32f.i	aeq0, a3, 28
     e74:	01d142        	addmi	a4, a1, 0x100
     e77:	632134        	ae_sq56s.i	aeq2, a1, 24
     e7a:	608324        	ae_lq32f.i	aeq2, a3, 8
     e7d:	60c334        	ae_lq32f.i	aeq3, a3, 12
     e80:	604354        	ae_lq32f.i	aeq1, a3, 20
     e83:	630164        	ae_sq56s.i	aeq0, a1, 48
     e86:	6106b4        	ae_lq56.i	aeq0, a6, -40
     e89:	f8e23a312f 	{ ae_sq56s.i	aeq3, a1, 16; ae_addq56	aeq0, aeq0, aeq2 }
     e8e:	60c344        	ae_lq32f.i	aeq3, a3, 16
     e91:	631144        	ae_sq56s.i	aeq1, a1, 32
     e94:	604364        	ae_lq32f.i	aeq1, a3, 24
     e97:	b0c442        	addi	a4, a4, -80
     e9a:	01d152        	addmi	a5, a1, 0x100
     e9d:	fb7e3a361f 	{ ae_sq56s.i	aeq3, a6, 8; ae_addq56	aeq3, aeq3, aeq1 }
     ea2:	632604        	ae_sq56s.i	aeq2, a6, 0
     ea5:	631624        	ae_sq56s.i	aeq1, a6, 16
     ea8:	620404        	ae_sq32f.i	aeq0, a4, 0
     eab:	608404        	ae_lq32f.i	aeq2, a4, 0
     eae:	b4c552        	addi	a5, a5, -76
     eb1:	6326a4        	ae_sq56s.i	aeq2, a6, -48
     eb4:	623504        	ae_sq32f.i	aeq3, a5, 0
     eb7:	01d1a2        	addmi	a10, a1, 0x100
     eba:	610134        	ae_lq56.i	aeq0, a1, 24
     ebd:	61c124        	ae_lq56.i	aeq3, a1, 16
     ec0:	f8e63d450f 	{ ae_lq32f.i	aeq2, a5, 0; ae_addq56	aeq0, aeq0, aeq3 }
     ec5:	b8ca42        	addi	a4, a10, -72
     ec8:	632694        	ae_sq56s.i	aeq2, a6, -56
     ecb:	620404        	ae_sq32f.i	aeq0, a4, 0
     ece:	01d1b2        	addmi	a11, a1, 0x100
     ed1:	610144        	ae_lq56.i	aeq0, a1, 32
     ed4:	61c164        	ae_lq56.i	aeq3, a1, 48
     ed7:	f8e63d440f 	{ ae_lq32f.i	aeq2, a4, 0; ae_addq56	aeq0, aeq0, aeq3 }
     edc:	bccb52        	addi	a5, a11, -68
     edf:	632174        	ae_sq56s.i	aeq2, a1, 56
     ee2:	620504        	ae_sq32f.i	aeq0, a5, 0
     ee5:	01d1c2        	addmi	a12, a1, 0x100
     ee8:	610114        	ae_lq56.i	aeq0, a1, 8
     eeb:	61c6e4        	ae_lq56.i	aeq3, a6, -16
     eee:	f9e63d450f 	{ ae_lq32f.i	aeq2, a5, 0; ae_addq56	aeq1, aeq0, aeq3 }
     ef3:	c0cc42        	addi	a4, a12, -64
     ef6:	632114        	ae_sq56s.i	aeq2, a1, 8
     ef9:	621404        	ae_sq32f.i	aeq1, a4, 0
     efc:	01d1d2        	addmi	a13, a1, 0x100
     eff:	61c154        	ae_lq56.i	aeq3, a1, 40
     f02:	6146d4        	ae_lq56.i	aeq1, a6, -24
     f05:	f9ee0c4d5e 	{ addi	a5, a13, -60; ae_addq56	aeq1, aeq1, aeq3 }
     f0a:	60c404        	ae_lq32f.i	aeq3, a4, 0
     f0d:	621504        	ae_sq32f.i	aeq1, a5, 0
     f10:	6186a4        	ae_lq56.i	aeq2, a6, -48
     f13:	614694        	ae_lq56.i	aeq1, a6, -56
     f16:	f9763d450f 	{ ae_lq32f.i	aeq2, a5, 0; ae_addq56	aeq1, aeq2, aeq1 }
     f1b:	f83ec082bf 	{ movi	a11, 130; ae_subq56	aeq0, aeq3, aeq1 }
     f20:	f97e3a015f 	{ ae_sq56s.i	aeq0, a1, 40; ae_addq56	aeq1, aeq3, aeq1 }
     f25:	610154        	ae_lq56.i	aeq0, a1, 40
     f28:	620304        	ae_sq32f.i	aeq0, a3, 0
     f2b:	61c114        	ae_lq56.i	aeq3, a1, 8
     f2e:	610174        	ae_lq56.i	aeq0, a1, 56
     f31:	fbe639920f 	{ ae_sq32f.i	aeq1, a2, 0; ae_addq56	aeq3, aeq0, aeq3 }
     f36:	016fc4        	ae_subq56	aeq1, aeq2, aeq3
     f39:	01d1e2        	addmi	a14, a1, 0x100
     f3c:	f8f639931f 	{ ae_sq32f.i	aeq1, a3, 4; ae_addq56	aeq0, aeq2, aeq3 }
     f41:	c8ce42        	addi	a4, a14, -56
     f44:	6146c4        	ae_lq56.i	aeq1, a6, -32
     f47:	620214        	ae_sq32f.i	aeq0, a2, 4
     f4a:	621404        	ae_sq32f.i	aeq1, a4, 0
     f4d:	01d1f2        	addmi	a15, a1, 0x100
     f50:	cccf52        	addi	a5, a15, -52
     f53:	6186f4        	ae_lq56.i	aeq2, a6, -8
     f56:	600404        	ae_lq32f.i	aeq0, a4, 0
     f59:	622504        	ae_sq32f.i	aeq2, a5, 0
     f5c:	614114        	ae_lq56.i	aeq1, a1, 8
     f5f:	61c174        	ae_lq56.i	aeq3, a1, 56
     f62:	f93efd450f 	{ ae_lq32f.i	aeq2, a5, 0; ae_subq56	aeq1, aeq3, aeq1 }
     f67:	01cdc4        	ae_subq56	aeq3, aeq0, aeq1
     f6a:	f86639b34f 	{ ae_sq32f.i	aeq3, a3, 16; ae_addq56	aeq0, aeq0, aeq1 }
     f6f:	6146a4        	ae_lq56.i	aeq1, a6, -48
     f72:	61c694        	ae_lq56.i	aeq3, a6, -56
     f75:	f93ef9824f 	{ ae_sq32f.i	aeq0, a2, 16; ae_subq56	aeq1, aeq3, aeq1 }
     f7a:	01edc4        	ae_subq56	aeq3, aeq2, aeq1
     f7d:	f97639b35f 	{ ae_sq32f.i	aeq3, a3, 20; ae_addq56	aeq1, aeq2, aeq1 }
     f82:	01d172        	addmi	a7, a1, 0x100
     f85:	6186b4        	ae_lq56.i	aeq2, a6, -40
     f88:	61c604        	ae_lq56.i	aeq3, a6, 0
     f8b:	f8b6cd074e 	{ addi	a4, a7, -48; ae_subq56	aeq0, aeq2, aeq3 }
     f90:	621254        	ae_sq32f.i	aeq1, a2, 20
     f93:	620404        	ae_sq32f.i	aeq0, a4, 0
     f96:	01d182        	addmi	a8, a1, 0x100
     f99:	610134        	ae_lq56.i	aeq0, a1, 24
     f9c:	61c124        	ae_lq56.i	aeq3, a1, 16
     f9f:	f9a6fd440f 	{ ae_lq32f.i	aeq2, a4, 0; ae_subq56	aeq1, aeq0, aeq3 }
     fa4:	d4c852        	addi	a5, a8, -44
     fa7:	632114        	ae_sq56s.i	aeq2, a1, 8
     faa:	621504        	ae_sq32f.i	aeq1, a5, 0
     fad:	01d192        	addmi	a9, a1, 0x100
     fb0:	61c624        	ae_lq56.i	aeq3, a6, 16
     fb3:	614614        	ae_lq56.i	aeq1, a6, 8
     fb6:	f9aefd650f 	{ ae_lq32f.i	aeq3, a5, 0; ae_subq56	aeq1, aeq1, aeq3 }
     fbb:	d8c942        	addi	a4, a9, -40
     fbe:	633124        	ae_sq56s.i	aeq3, a1, 16
     fc1:	621404        	ae_sq32f.i	aeq1, a4, 0
     fc4:	610144        	ae_lq56.i	aeq0, a1, 32
     fc7:	618164        	ae_lq56.i	aeq2, a1, 48
     fca:	faa2fd040f 	{ ae_lq32f.i	aeq0, a4, 0; ae_subq56	aeq2, aeq0, aeq2 }
     fcf:	dcca52        	addi	a5, a10, -36
     fd2:	630134        	ae_sq56s.i	aeq0, a1, 24
     fd5:	622504        	ae_sq32f.i	aeq2, a5, 0
     fd8:	78c172        	addi	a7, a1, 120
     fdb:	600504        	ae_lq32f.i	aeq0, a5, 0
     fde:	614744        	ae_lq56.i	aeq1, a7, 32
     fe1:	630164        	ae_sq56s.i	aeq0, a1, 48
     fe4:	621c84        	ae_sq32f.i	aeq1, a12, -32
     fe7:	618114        	ae_lq56.i	aeq2, a1, 8
     fea:	61c124        	ae_lq56.i	aeq3, a1, 16
     fed:	016bc4        	ae_addq56	aeq1, aeq2, aeq3
     ff0:	fabafde13f 	{ ae_lq56.i	aeq3, a1, 24; ae_subq56	aeq2, aeq3, aeq2 }
     ff5:	f93afa115f 	{ ae_sq56s.i	aeq1, a1, 40; ae_subq56	aeq1, aeq3, aeq0 }
     ffa:	632114        	ae_sq56s.i	aeq2, a1, 8
     ffd:	610734        	ae_lq56.i	aeq0, a7, 24
    1000:	5adb42        	addmi	a4, a11, 0x5a00
    1003:	608c84        	ae_lq32f.i	aeq2, a12, -32
    1006:	631144        	ae_sq56s.i	aeq1, a1, 32
    1009:	620d94        	ae_sq32f.i	aeq0, a13, -28
    100c:	300444        	ae_cvtp24a16x2.ll	aep0, a4, a4
    100f:	610154        	ae_lq56.i	aeq0, a1, 40
    1012:	0c00bda16f 	{ ae_lq56.i	aeq1, a1, 48; ae_mulzaafq32sp16s.lh	aeq0, aeq0, aep0, aeq1, aep0 }
    1017:	015bc4        	ae_addq56	aeq1, aeq1, aeq3
    101a:	fb32fa112f 	{ ae_sq56s.i	aeq1, a1, 16; ae_subq56	aeq3, aeq2, aeq0 }
    101f:	f8723d2d9f 	{ ae_lq32f.i	aeq1, a13, -28; ae_addq56	aeq0, aeq2, aeq0 }
    1024:	633134        	ae_sq56s.i	aeq3, a1, 24
    1027:	61c134        	ae_lq56.i	aeq3, a1, 24
    102a:	623324        	ae_sq32f.i	aeq3, a3, 8
    102d:	61c124        	ae_lq56.i	aeq3, a1, 16
    1030:	618114        	ae_lq56.i	aeq2, a1, 8
    1033:	0f02ba016f 	{ ae_sq56s.i	aeq0, a1, 48; ae_mulzaafq32sp16s.lh	aeq2, aeq2, aep0, aeq3, aep0 }
    1038:	610164        	ae_lq56.i	aeq0, a1, 48
    103b:	f8aaf9822f 	{ ae_sq32f.i	aeq0, a2, 8; ae_subq56	aeq0, aeq1, aeq2 }
    1040:	f9ea3dc76f 	{ ae_lq56.i	aeq2, a7, 48; ae_addq56	aeq1, aeq1, aeq2 }
    1045:	621234        	ae_sq32f.i	aeq1, a2, 12
    1048:	620334        	ae_sq32f.i	aeq0, a3, 12
    104b:	614114        	ae_lq56.i	aeq1, a1, 8
    104e:	3c03b9aeaf 	{ ae_sq32f.i	aeq2, a14, -24; ae_mulzasfq32sp16s.lh	aeq0, aeq1, aep0, aeq3, aep0 }
    1053:	614154        	ae_lq56.i	aeq1, a1, 40
    1056:	61c144        	ae_lq56.i	aeq3, a1, 32
    1059:	3e01fde75f 	{ ae_lq56.i	aeq3, a7, 40; ae_mulzasfq32sp16s.lh	aeq1, aeq3, aep0, aeq1, aep0 }
    105e:	608ea4        	ae_lq32f.i	aeq2, a14, -24
    1061:	fb32f9bfbf 	{ ae_sq32f.i	aeq3, a15, -20; ae_subq56	aeq3, aeq2, aeq0 }
    1066:	f8723d4fbf 	{ ae_lq32f.i	aeq2, a15, -20; ae_addq56	aeq0, aeq2, aeq0 }
    106b:	fb36f9b36f 	{ ae_sq32f.i	aeq3, a3, 24; ae_subq56	aeq3, aeq2, aeq1 }
    1070:	f97639826f 	{ ae_sq32f.i	aeq0, a2, 24; ae_addq56	aeq1, aeq2, aeq1 }
    1075:	623374        	ae_sq32f.i	aeq3, a3, 28
    1078:	621274        	ae_sq32f.i	aeq1, a2, 28
    107b:	f01d           	retw.n

0000107d <xtensa_fft8_32b+0x2a1>:
    107d:	000000                                        ...

00001080 <F_get_oft_32b>:
    1080:	004136        	entry	a1, 32
    1083:	0cc2e6        	bgei	a2, 32, 1093 <F_get_oft_32b+0x13>
    1086:	134226        	beqi	a2, 4, 109d <F_get_oft_32b+0x1d>
    1089:	148226        	beqi	a2, 8, 10a1 <F_get_oft_32b+0x21>
    108c:	09b266        	bnei	a2, 16, 1099 <F_get_oft_32b+0x19>
    108f:	021c           	movi.n	a2, 16
    1091:	f01d           	retw.n

00001093 <F_get_oft_32b+0x13>:
    1093:	0ec226        	beqi	a2, 32, 10a5 <F_get_oft_32b+0x25>
    1096:	0fd226        	beqi	a2, 64, 10a9 <F_get_oft_32b+0x29>
    1099:	220c           	movi.n	a2, 2
    109b:	f01d           	retw.n

0000109d <F_get_oft_32b+0x1d>:
    109d:	024c           	movi.n	a2, 64
    109f:	f01d           	retw.n

000010a1 <F_get_oft_32b+0x21>:
    10a1:	022c           	movi.n	a2, 32
    10a3:	f01d           	retw.n

000010a5 <F_get_oft_32b+0x25>:
    10a5:	820c           	movi.n	a2, 8
    10a7:	f01d           	retw.n

000010a9 <F_get_oft_32b+0x29>:
    10a9:	420c           	movi.n	a2, 4
    10ab:	f01d           	retw.n

000010ad <F_get_oft_32b+0x2d>:
    10ad:	000000                                        ...

000010b0 <xtensa_fft_pass_32b>:
    10b0:	00c136        	entry	a1, 96
    10b3:	905330        	addx2	a5, a3, a3
    10b6:	1143c0        	slli	a4, a3, 4
    10b9:	b05520        	addx8	a5, a5, a2
    10bc:	602244        	ae_lq32f.x	aeq0, a2, a4
    10bf:	604504        	ae_lq32f.i	aeq1, a5, 0
    10c2:	f8663a014f 	{ ae_sq56s.i	aeq0, a1, 32; ae_addq56	aeq0, aeq0, aeq1 }
    10c7:	608204        	ae_lq32f.i	aeq2, a2, 0
    10ca:	f832fa012f 	{ ae_sq56s.i	aeq0, a1, 16; ae_subq56	aeq0, aeq2, aeq0 }
    10cf:	fc4450724f 	{ add	a7, a2, a4; ae_roundsq32sym	aeq0, aeq0 }
    10d4:	631114        	ae_sq56s.i	aeq1, a1, 8
    10d7:	630154        	ae_sq56s.i	aeq0, a1, 40
    10da:	600514        	ae_lq32f.i	aeq0, a5, 4
    10dd:	604714        	ae_lq32f.i	aeq1, a7, 4
    10e0:	fa6a3a216f 	{ ae_sq56s.i	aeq2, a1, 48; ae_addq56	aeq2, aeq1, aeq0 }
    10e5:	f82acfc74e 	{ addi	a4, a7, -4; ae_subq56	aeq0, aeq1, aeq0 }
    10ea:	60c214        	ae_lq32f.i	aeq3, a2, 4
    10ed:	614154        	ae_lq56.i	aeq1, a1, 40
    10f0:	f9baf9d41f 	{ ae_sq32f.iu	aeq1, a4, 4; ae_subq56	aeq1, aeq3, aeq2 }
    10f5:	fc4c7a013f 	{ ae_sq56s.i	aeq0, a1, 24; ae_roundsq32sym	aeq0, aeq1 }
    10fa:	fafa3a015f 	{ ae_sq56s.i	aeq0, a1, 40; ae_addq56	aeq2, aeq3, aeq2 }
    10ff:	ff547da12f 	{ ae_lq56.i	aeq1, a1, 16; ae_roundsq32sym	aeq3, aeq2 }
    1104:	610164        	ae_lq56.i	aeq0, a1, 48
    1107:	f9663d815f 	{ ae_lq56.i	aeq0, a1, 40; ae_addq56	aeq1, aeq0, aeq1 }
    110c:	b06320        	addx8	a6, a3, a2
    110f:	fd4c4fc22e 	{ addi	a2, a2, -4; ae_roundsq32sym	aeq1, aeq1 }
    1114:	624414        	ae_sq32f.iu	aeq0, a4, 4
    1117:	625214        	ae_sq32f.iu	aeq1, a2, 4
    111a:	627214        	ae_sq32f.iu	aeq3, a2, 4
    111d:	614114        	ae_lq56.i	aeq1, a1, 8
    1120:	618144        	ae_lq56.i	aeq2, a1, 32
    1123:	f8aafd260f 	{ ae_lq32f.i	aeq1, a6, 0; ae_subq56	aeq0, aeq1, aeq2 }
    1128:	61c134        	ae_lq56.i	aeq3, a1, 24
    112b:	faaecfc55e 	{ addi	a5, a5, -4; ae_subq56	aeq2, aeq1, aeq3 }
    1130:	f9ee3d661f 	{ ae_lq32f.i	aeq3, a6, 4; ae_addq56	aeq1, aeq1, aeq3 }
    1135:	f93afa111f 	{ ae_sq56s.i	aeq1, a1, 8; ae_subq56	aeq1, aeq3, aeq0 }
    113a:	fe544fc66e 	{ addi	a6, a6, -4; ae_roundsq32sym	aeq2, aeq2 }
    113f:	f87a39e51f 	{ ae_sq32f.iu	aeq2, a5, 4; ae_addq56	aeq0, aeq3, aeq0 }
    1144:	fd4c7de11f 	{ ae_lq56.i	aeq3, a1, 8; ae_roundsq32sym	aeq1, aeq1 }
    1149:	fd5c79d51f 	{ ae_sq32f.iu	aeq1, a5, 4; ae_roundsq32sym	aeq1, aeq3 }
    114e:	fbca71        	l32r	a7, 78 (1080 <F_get_oft_32b>)
    1151:	83ad           	ae_sext16	a10, a3
    1153:	fc4479d61f 	{ ae_sq32f.iu	aeq1, a6, 4; ae_roundsq32sym	aeq0, aeq0 }
    1158:	624614        	ae_sq32f.iu	aeq0, a6, 4
    115b:	0007e0        	callx8	a7
    115e:	fbc771        	l32r	a7, 7c (2c30 <ROOTS_512_Q16>)
    1161:	00a082        	movi	a8, 0
    1164:	119af0        	slli	a9, a10, 1
    1167:	907a70        	addx2	a7, a10, a7
    116a:	fcc772        	addi	a7, a7, -4
    116d:	458784        	ae_lp16x2f.xu	aep0, a7, a8
    1170:	218130        	srai	a8, a3, 1
    1173:	0223e6        	bgei	a3, 2, 1179 <xtensa_fft_pass_32b+0xc9>
    1176:	002e86        	j	1234 <xtensa_fft_pass_32b+0x184>
    1179:	b78876        	loop	a8, 1234 <xtensa_fft_pass_32b+0x184>
    117c:	604414        	ae_lq32f.i	aeq1, a4, 4
    117f:	608424        	ae_lq32f.i	aeq2, a4, 8
    1182:	30033d651f 	{ ae_lq32f.i	aeq3, a5, 4; ae_mulzaaq32sp16u.lh	aeq0, aeq1, aep0, aeq2, aep0 }
    1187:	6300bd252f 	{ ae_lq32f.i	aeq1, a5, 8; ae_mulzasq32sp16u.lh	aeq2, aeq2, aep0, aeq1, aep0 }
    118c:	630114        	ae_sq56s.i	aeq0, a1, 8
    118f:	6301ba214f 	{ ae_sq56s.i	aeq2, a1, 32; ae_mulzasq32sp16u.lh	aeq2, aeq3, aep0, aeq1, aep0 }
    1194:	3103fd811f 	{ ae_lq56.i	aeq0, a1, 8; ae_mulzaaq32sp16u.lh	aeq3, aeq1, aep0, aeq3, aep0 }
    1199:	f8e23d221f 	{ ae_lq32f.i	aeq1, a2, 4; ae_addq56	aeq0, aeq0, aeq2 }
    119e:	fa2afa213f 	{ ae_sq56s.i	aeq2, a1, 24; ae_subq56	aeq2, aeq1, aeq0 }
    11a3:	f86a3a212f 	{ ae_sq56s.i	aeq2, a1, 16; ae_addq56	aeq0, aeq1, aeq0 }
    11a8:	618144        	ae_lq56.i	aeq2, a1, 32
    11ab:	f8f63a015f 	{ ae_sq56s.i	aeq0, a1, 40; ae_addq56	aeq0, aeq2, aeq3 }
    11b0:	633164        	ae_sq56s.i	aeq3, a1, 48
    11b3:	61c124        	ae_lq56.i	aeq3, a1, 16
    11b6:	ff5c7d222f 	{ ae_lq32f.i	aeq1, a2, 8; ae_roundsq32sym	aeq3, aeq3 }
    11bb:	fb2afa312f 	{ ae_sq56s.i	aeq3, a1, 16; ae_subq56	aeq3, aeq1, aeq0 }
    11c0:	f86a3a317f 	{ ae_sq56s.i	aeq3, a1, 56; ae_addq56	aeq0, aeq1, aeq0 }
    11c5:	fc447de12f 	{ ae_lq56.i	aeq3, a1, 16; ae_roundsq32sym	aeq0, aeq0 }
    11ca:	627414        	ae_sq32f.iu	aeq3, a4, 4
    11cd:	61c174        	ae_lq56.i	aeq3, a1, 56
    11d0:	ff5c5b879f 	{ ae_lp16x2f.xu	aep0, a7, a9; ae_roundsq32sym	aeq3, aeq3 }
    11d5:	627414        	ae_sq32f.iu	aeq3, a4, 4
    11d8:	61c154        	ae_lq56.i	aeq3, a1, 40
    11db:	fd5c7de11f 	{ ae_lq56.i	aeq3, a1, 8; ae_roundsq32sym	aeq1, aeq3 }
    11e0:	625214        	ae_sq32f.iu	aeq1, a2, 4
    11e3:	624214        	ae_sq32f.iu	aeq0, a2, 4
    11e6:	614164        	ae_lq56.i	aeq1, a1, 48
    11e9:	f836fd261f 	{ ae_lq32f.i	aeq1, a6, 4; ae_subq56	aeq0, aeq2, aeq1 }
    11ee:	0198c4        	ae_addq56	aeq2, aeq1, aeq0
    11f1:	f82afa212f 	{ ae_sq56s.i	aeq2, a1, 16; ae_subq56	aeq0, aeq1, aeq0 }
    11f6:	fc447dc13f 	{ ae_lq56.i	aeq2, a1, 24; ae_roundsq32sym	aeq0, aeq0 }
    11fb:	fbb6fdc12f 	{ ae_lq56.i	aeq2, a1, 16; ae_subq56	aeq3, aeq2, aeq3 }
    1200:	fe547a314f 	{ ae_sq56s.i	aeq3, a1, 32; ae_roundsq32sym	aeq2, aeq2 }
    1205:	632114        	ae_sq56s.i	aeq2, a1, 8
    1208:	608624        	ae_lq32f.i	aeq2, a6, 8
    120b:	01ebc4        	ae_addq56	aeq3, aeq2, aeq3
    120e:	633134        	ae_sq56s.i	aeq3, a1, 24
    1211:	61c114        	ae_lq56.i	aeq3, a1, 8
    1214:	627614        	ae_sq32f.iu	aeq3, a6, 4
    1217:	61c134        	ae_lq56.i	aeq3, a1, 24
    121a:	06f834        	ae_roundsq32sym	aeq3, aeq3
    121d:	633114        	ae_sq56s.i	aeq3, a1, 8
    1220:	61c114        	ae_lq56.i	aeq3, a1, 8
    1223:	627614        	ae_sq32f.iu	aeq3, a6, 4
    1226:	61c144        	ae_lq56.i	aeq3, a1, 32
    1229:	f9b6f9c51f 	{ ae_sq32f.iu	aeq0, a5, 4; ae_subq56	aeq1, aeq2, aeq3 }
    122e:	06d834        	ae_roundsq32sym	aeq3, aeq1
    1231:	627514        	ae_sq32f.iu	aeq3, a5, 4

00001234 <xtensa_fft_pass_32b+0x184>:
    1234:	0243e6        	bgei	a3, 4, 123a <xtensa_fft_pass_32b+0x18a>
    1237:	003146        	j	1300 <xtensa_fft_pass_32b+0x250>
    123a:	603090        	neg	a3, a9
    123d:	1193f0        	slli	a9, a3, 1
    1240:	880b           	addi.n	a8, a8, -1
    1242:	458794        	ae_lp16x2f.xu	aep0, a7, a9
    1245:	b78876        	loop	a8, 1300 <xtensa_fft_pass_32b+0x250>
    1248:	604424        	ae_lq32f.i	aeq1, a4, 8
    124b:	608414        	ae_lq32f.i	aeq2, a4, 4
    124e:	30033d652f 	{ ae_lq32f.i	aeq3, a5, 8; ae_mulzaaq32sp16u.lh	aeq0, aeq1, aep0, aeq2, aep0 }
    1253:	9300bd251f 	{ ae_lq32f.i	aeq1, a5, 4; ae_mulzsaq32sp16u.lh	aeq2, aeq2, aep0, aeq1, aep0 }
    1258:	630114        	ae_sq56s.i	aeq0, a1, 8
    125b:	9301ba214f 	{ ae_sq56s.i	aeq2, a1, 32; ae_mulzsaq32sp16u.lh	aeq2, aeq3, aep0, aeq1, aep0 }
    1260:	3103fd811f 	{ ae_lq56.i	aeq0, a1, 8; ae_mulzaaq32sp16u.lh	aeq3, aeq1, aep0, aeq3, aep0 }
    1265:	f8e23d221f 	{ ae_lq32f.i	aeq1, a2, 4; ae_addq56	aeq0, aeq0, aeq2 }
    126a:	fa2afa213f 	{ ae_sq56s.i	aeq2, a1, 24; ae_subq56	aeq2, aeq1, aeq0 }
    126f:	f86a3a212f 	{ ae_sq56s.i	aeq2, a1, 16; ae_addq56	aeq0, aeq1, aeq0 }
    1274:	618144        	ae_lq56.i	aeq2, a1, 32
    1277:	f8f63a015f 	{ ae_sq56s.i	aeq0, a1, 40; ae_addq56	aeq0, aeq2, aeq3 }
    127c:	633164        	ae_sq56s.i	aeq3, a1, 48
    127f:	61c124        	ae_lq56.i	aeq3, a1, 16
    1282:	ff5c7d222f 	{ ae_lq32f.i	aeq1, a2, 8; ae_roundsq32sym	aeq3, aeq3 }
    1287:	fb2afa312f 	{ ae_sq56s.i	aeq3, a1, 16; ae_subq56	aeq3, aeq1, aeq0 }
    128c:	f86a3a317f 	{ ae_sq56s.i	aeq3, a1, 56; ae_addq56	aeq0, aeq1, aeq0 }
    1291:	fc447de12f 	{ ae_lq56.i	aeq3, a1, 16; ae_roundsq32sym	aeq0, aeq0 }
    1296:	627414        	ae_sq32f.iu	aeq3, a4, 4
    1299:	61c174        	ae_lq56.i	aeq3, a1, 56
    129c:	ff5c5b873f 	{ ae_lp16x2f.xu	aep0, a7, a3; ae_roundsq32sym	aeq3, aeq3 }
    12a1:	627414        	ae_sq32f.iu	aeq3, a4, 4
    12a4:	61c154        	ae_lq56.i	aeq3, a1, 40
    12a7:	fd5c7de11f 	{ ae_lq56.i	aeq3, a1, 8; ae_roundsq32sym	aeq1, aeq3 }
    12ac:	625214        	ae_sq32f.iu	aeq1, a2, 4
    12af:	624214        	ae_sq32f.iu	aeq0, a2, 4
    12b2:	614164        	ae_lq56.i	aeq1, a1, 48
    12b5:	f836fd261f 	{ ae_lq32f.i	aeq1, a6, 4; ae_subq56	aeq0, aeq2, aeq1 }
    12ba:	0198c4        	ae_addq56	aeq2, aeq1, aeq0
    12bd:	f82afa212f 	{ ae_sq56s.i	aeq2, a1, 16; ae_subq56	aeq0, aeq1, aeq0 }
    12c2:	fc447dc13f 	{ ae_lq56.i	aeq2, a1, 24; ae_roundsq32sym	aeq0, aeq0 }
    12c7:	fbb6fdc12f 	{ ae_lq56.i	aeq2, a1, 16; ae_subq56	aeq3, aeq2, aeq3 }
    12cc:	fe547a314f 	{ ae_sq56s.i	aeq3, a1, 32; ae_roundsq32sym	aeq2, aeq2 }
    12d1:	632114        	ae_sq56s.i	aeq2, a1, 8
    12d4:	608624        	ae_lq32f.i	aeq2, a6, 8
    12d7:	01ebc4        	ae_addq56	aeq3, aeq2, aeq3
    12da:	633134        	ae_sq56s.i	aeq3, a1, 24
    12dd:	61c114        	ae_lq56.i	aeq3, a1, 8
    12e0:	627614        	ae_sq32f.iu	aeq3, a6, 4
    12e3:	61c134        	ae_lq56.i	aeq3, a1, 24
    12e6:	06f834        	ae_roundsq32sym	aeq3, aeq3
    12e9:	633114        	ae_sq56s.i	aeq3, a1, 8
    12ec:	61c114        	ae_lq56.i	aeq3, a1, 8
    12ef:	627614        	ae_sq32f.iu	aeq3, a6, 4
    12f2:	61c144        	ae_lq56.i	aeq3, a1, 32
    12f5:	f9b6f9c51f 	{ ae_sq32f.iu	aeq0, a5, 4; ae_subq56	aeq1, aeq2, aeq3 }
    12fa:	06d834        	ae_roundsq32sym	aeq3, aeq1
    12fd:	627514        	ae_sq32f.iu	aeq3, a5, 4
    1300:	f01d           	retw.n

00001302 <xtensa_fft_pass_32b+0x252>:
	...

00001304 <xtensa_fft16_32b>:
    1304:	004136        	entry	a1, 32
    1307:	fb5e31        	l32r	a3, 80 (ddc <xtensa_fft8_32b>)
    130a:	02ad           	mov.n	a10, a2
    130c:	0003e0        	callx8	a3
    130f:	fb5d31        	l32r	a3, 84 (d40 <xtensa_fft4_32b>)
    1312:	40c2a2        	addi	a10, a2, 64
    1315:	0003e0        	callx8	a3
    1318:	60c2a2        	addi	a10, a2, 96
    131b:	0003e0        	callx8	a3
    131e:	fb5a31        	l32r	a3, 88 (10b0 <xtensa_fft_pass_32b>)
    1321:	4b0c           	movi.n	a11, 4
    1323:	02ad           	mov.n	a10, a2
    1325:	0003e0        	callx8	a3
    1328:	f01d           	retw.n

0000132a <xtensa_fft16_32b+0x26>:
	...

0000132c <xtensa_fft32_32b>:
    132c:	004136        	entry	a1, 32
    132f:	fb5731        	l32r	a3, 8c (1304 <xtensa_fft16_32b>)
    1332:	02ad           	mov.n	a10, a2
    1334:	0003e0        	callx8	a3
    1337:	80a032        	movi	a3, 128
    133a:	a23a           	add.n	a10, a2, a3
    133c:	fb5131        	l32r	a3, 80 (ddc <xtensa_fft8_32b>)
    133f:	0003e0        	callx8	a3
    1342:	c0a042        	movi	a4, 192
    1345:	a24a           	add.n	a10, a2, a4
    1347:	0003e0        	callx8	a3
    134a:	fb4f31        	l32r	a3, 88 (10b0 <xtensa_fft_pass_32b>)
    134d:	8b0c           	movi.n	a11, 8
    134f:	02ad           	mov.n	a10, a2
    1351:	0003e0        	callx8	a3
    1354:	f01d           	retw.n

00001356 <xtensa_fft32_32b+0x2a>:
	...

00001358 <xtensa_fft64_32b>:
    1358:	004136        	entry	a1, 32
    135b:	fb4d31        	l32r	a3, 90 (132c <xtensa_fft32_32b>)
    135e:	02ad           	mov.n	a10, a2
    1360:	0003e0        	callx8	a3
    1363:	fb4a31        	l32r	a3, 8c (1304 <xtensa_fft16_32b>)
    1366:	01d2a2        	addmi	a10, a2, 0x100
    1369:	0003e0        	callx8	a3
    136c:	80a142        	movi	a4, 0x180
    136f:	a24a           	add.n	a10, a2, a4
    1371:	0003e0        	callx8	a3
    1374:	fb4531        	l32r	a3, 88 (10b0 <xtensa_fft_pass_32b>)
    1377:	0b1c           	movi.n	a11, 16
    1379:	02ad           	mov.n	a10, a2
    137b:	0003e0        	callx8	a3
    137e:	f01d           	retw.n

00001380 <xtensa_fft128_32b>:
    1380:	004136        	entry	a1, 32
    1383:	fb4431        	l32r	a3, 94 (1358 <xtensa_fft64_32b>)
    1386:	02ad           	mov.n	a10, a2
    1388:	0003e0        	callx8	a3
    138b:	fb4131        	l32r	a3, 90 (132c <xtensa_fft32_32b>)
    138e:	02d2a2        	addmi	a10, a2, 0x200
    1391:	0003e0        	callx8	a3
    1394:	03d2a2        	addmi	a10, a2, 0x300
    1397:	0003e0        	callx8	a3
    139a:	fb3b31        	l32r	a3, 88 (10b0 <xtensa_fft_pass_32b>)
    139d:	0b2c           	movi.n	a11, 32
    139f:	02ad           	mov.n	a10, a2
    13a1:	0003e0        	callx8	a3
    13a4:	f01d           	retw.n

000013a6 <xtensa_fft128_32b+0x26>:
	...

000013a8 <xtensa_fft256_32b>:
    13a8:	004136        	entry	a1, 32
    13ab:	fb3a31        	l32r	a3, 94 (1358 <xtensa_fft64_32b>)
    13ae:	02ad           	mov.n	a10, a2
    13b0:	0003e0        	callx8	a3
    13b3:	fb3741        	l32r	a4, 90 (132c <xtensa_fft32_32b>)
    13b6:	02d2a2        	addmi	a10, a2, 0x200
    13b9:	0004e0        	callx8	a4
    13bc:	03d2a2        	addmi	a10, a2, 0x300
    13bf:	0004e0        	callx8	a4
    13c2:	fb3141        	l32r	a4, 88 (10b0 <xtensa_fft_pass_32b>)
    13c5:	0b2c           	movi.n	a11, 32
    13c7:	02ad           	mov.n	a10, a2
    13c9:	0004e0        	callx8	a4
    13cc:	04d2a2        	addmi	a10, a2, 0x400
    13cf:	0003e0        	callx8	a3
    13d2:	06d2a2        	addmi	a10, a2, 0x600
    13d5:	0003e0        	callx8	a3
    13d8:	0b4c           	movi.n	a11, 64
    13da:	02ad           	mov.n	a10, a2
    13dc:	0004e0        	callx8	a4
    13df:	f01d           	retw.n

000013e1 <xtensa_fft256_32b+0x39>:
    13e1:	000000                                        ...

000013e4 <xtensa_fft512_32b>:
    13e4:	004136        	entry	a1, 32
    13e7:	fb2c31        	l32r	a3, 98 (13a8 <xtensa_fft256_32b>)
    13ea:	02ad           	mov.n	a10, a2
    13ec:	0003e0        	callx8	a3
    13ef:	fb2b31        	l32r	a3, 9c (1380 <xtensa_fft128_32b>)
    13f2:	08d2a2        	addmi	a10, a2, 0x800
    13f5:	0003e0        	callx8	a3
    13f8:	0cd2a2        	addmi	a10, a2, 0xc00
    13fb:	0003e0        	callx8	a3
    13fe:	fb2231        	l32r	a3, 88 (10b0 <xtensa_fft_pass_32b>)
    1401:	80a0b2        	movi	a11, 128
    1404:	02ad           	mov.n	a10, a2
    1406:	0003e0        	callx8	a3
    1409:	f01d           	retw.n

0000140b <xtensa_fft512_32b+0x27>:
	...

0000140c <real_split>:
    140c:	00a136        	entry	a1, 80
    140f:	216120        	srai	a6, a2, 1
    1412:	050c           	movi.n	a5, 0
    1414:	1388           	l32i.n	a8, a3, 4
    1416:	0378           	l32i.n	a7, a3, 0
    1418:	c0c260        	sub	a12, a2, a6
    141b:	1459           	s32i.n	a5, a4, 4
    141d:	b05c30        	addx8	a5, a12, a3
    1420:	15e8           	l32i.n	a14, a5, 4
    1422:	787a           	add.n	a7, a8, a7
    1424:	0479           	s32i.n	a7, a4, 0
    1426:	b0d640        	addx8	a13, a6, a4
    1429:	0558           	l32i.n	a5, a5, 0
    142b:	11fef0        	slli	a15, a14, 1
    142e:	0d59           	s32i.n	a5, a13, 0
    1430:	6050f0        	neg	a5, a15
    1433:	215150        	srai	a5, a5, 1
    1436:	1d59           	s32i.n	a5, a13, 4
    1438:	fb1051        	l32r	a5, 78 (1080 <F_get_oft_32b>)
    143b:	82ad           	ae_sext16	a10, a2
    143d:	b169           	s32i.n	a6, a1, 44
    143f:	0005e0        	callx8	a5
    1442:	81a072        	movi	a7, 129
    1445:	727270        	salt	a7, a2, a7
    1448:	401700        	ssl	a7
    144b:	a17a00        	sll	a7, a10
    144e:	fec782        	addi	a8, a7, -2
    1451:	fb0a51        	l32r	a5, 7c (2c30 <ROOTS_512_Q16>)
    1454:	11b8f0        	slli	a11, a8, 1
    1457:	41b2b0        	srli	a11, a11, 2
    145a:	7fa092        	movi	a9, 127
    145d:	a0bb50        	addx4	a11, a11, a5
    1460:	729970        	salt	a9, a9, a7
    1463:	60a070        	neg	a10, a7
    1466:	441b04        	ae_lp16x2f.i	aep1, a11, 0
    1469:	02e7e6        	bgei	a7, 128, 146f <real_split+0x63>
    146c:	1a9194        	ae_selp24.lh	aep1, aep1, aep1

0000146f <real_split+0x63>:
    146f:	160c           	movi.n	a6, 1
    1471:	116610        	slli	a6, a6, 15
    1474:	300664        	ae_cvtp24a16x2.ll	aep0, a6, a6
    1477:	937a90        	movnez	a7, a10, a9
    147a:	0242e6        	bgei	a2, 4, 1480 <real_split+0x74>
    147d:	002446        	j	1512 <real_split+0x106>
    1480:	b168           	l32i.n	a6, a1, 44
    1482:	b0b230        	addx8	a11, a2, a3
    1485:	14c3e2        	addi	a14, a3, 20
    1488:	f60b           	addi.n	a15, a6, -1
    148a:	fccbd2        	addi	a13, a11, -4
    148d:	c48b           	addi.n	a12, a4, 8
    148f:	60c334        	ae_lq32f.i	aeq3, a3, 12
    1492:	604324        	ae_lq32f.i	aeq1, a3, 8
    1495:	9027807daf 	{ movi	a10, 125; ae_mulzsaq32sp16u.lh	aeq0, aeq1, aep1, aeq3, aep1 }
    149a:	f8ceb2        	addi	a11, a14, -8
    149d:	718f76        	loop	a15, 1512 <real_split+0x106>
    14a0:	608df4        	ae_lq32f.i	aeq2, a13, -4
    14a3:	887a           	add.n	a8, a8, a7
    14a5:	c225ba014f 	{ ae_sq56s.i	aeq0, a1, 32; ae_mulzssq32sp16u.lh	aeq0, aeq3, aep1, aeq1, aep1 }
    14aa:	c30864        	ae_mulzaafq32sp16u.lh	aeq1, aeq1, aep0, aeq2, aep0
    14ad:	630114        	ae_sq56s.i	aeq0, a1, 8
    14b0:	600d04        	ae_lq32f.i	aeq0, a13, 0
    14b3:	32247a113f 	{ ae_sq56s.i	aeq1, a1, 24; ae_mulzaaq32sp16u.lh	aeq1, aeq2, aep1, aeq0, aep1 }
    14b8:	4b014fcdde 	{ addi	a13, a13, -4; ae_mulzasfq32sp16u.lh	aeq3, aeq3, aep0, aeq0, aep0 }
    14bd:	90263dc11f 	{ ae_lq56.i	aeq2, a1, 8; ae_mulzsaq32sp16u.lh	aeq0, aeq0, aep1, aeq2, aep1 }
    14c2:	fafa3a112f 	{ ae_sq56s.i	aeq1, a1, 16; ae_addq56	aeq2, aeq3, aeq2 }
    14c7:	f8723de14f 	{ ae_lq56.i	aeq3, a1, 32; ae_addq56	aeq0, aeq2, aeq0 }
    14cc:	614134        	ae_lq56.i	aeq1, a1, 24
    14cf:	fbee3da12f 	{ ae_lq56.i	aeq1, a1, 16; ae_addq56	aeq3, aeq1, aeq3 }
    14d4:	f97e3b001f 	{ ae_sraiq56	aeq0, aeq0, 1; ae_addq56	aeq1, aeq3, aeq1 }
    14d9:	1168f0        	slli	a6, a8, 1
    14dc:	fc447b105f 	{ ae_sraiq56	aeq1, aeq1, 1; ae_roundsq32sym	aeq0, aeq0 }
    14e1:	416260        	srli	a6, a6, 2
    14e4:	72fa80        	salt	a15, a10, a8
    14e7:	fd4c798c1f 	{ ae_sq32f.i	aeq0, a12, 4; ae_roundsq32sym	aeq1, aeq1 }
    14ec:	a06650        	addx4	a6, a6, a5
    14ef:	3099f0        	xor	a9, a9, a15
    14f2:	621c04        	ae_sq32f.i	aeq1, a12, 0
    14f5:	cc4b           	addi.n	a12, a12, 4
    14f7:	60e070        	neg	a14, a7
    14fa:	441604        	ae_lp16x2f.i	aep1, a6, 0
    14fd:	19cc           	bnez.n	a9, 1502 <real_split+0xf6>
    14ff:	1a9194        	ae_selp24.lh	aep1, aep1, aep1
    1502:	604b14        	ae_lq32f.i	aeq1, a11, 4
    1505:	937ef0        	movnez	a7, a14, a15
    1508:	60db24        	ae_lq32f.iu	aeq3, a11, 8
    150b:	90278fcdde 	{ addi	a13, a13, -4; ae_mulzsaq32sp16u.lh	aeq0, aeq1, aep1, aeq3, aep1 }
    1510:	cc4b           	addi.n	a12, a12, 4

00001512 <real_split+0x106>:
    1512:	b168           	l32i.n	a6, a1, 44
    1514:	ef7c           	movi.n	a15, -2
    1516:	c08f70        	sub	a8, a15, a7
    1519:	b61b           	addi.n	a11, a6, 1
    151b:	1168f0        	slli	a6, a8, 1
    151e:	7da0a2        	movi	a10, 125
    1521:	416260        	srli	a6, a6, 2
    1524:	72ca80        	salt	a12, a10, a8
    1527:	a06650        	addx4	a6, a6, a5
    152a:	3099c0        	xor	a9, a9, a12
    152d:	441604        	ae_lp16x2f.i	aep1, a6, 0
    1530:	498c           	beqz.n	a9, 1538 <real_split+0x12c>
    1532:	0b2b27        	blt	a11, a2, 1541 <real_split+0x135>
    1535:	002b86        	j	15e7 <real_split+0x1db>

00001538 <real_split+0x12c>:
    1538:	1a9194        	ae_selp24.lh	aep1, aep1, aep1
    153b:	022b27        	blt	a11, a2, 1541 <real_split+0x135>
    153e:	002946        	j	15e7 <real_split+0x1db>
    1541:	b1f8           	l32i.n	a15, a1, 44
    1543:	60a070        	neg	a10, a7
    1546:	93a7c0        	movnez	a10, a7, a12
    1549:	f77c           	movi.n	a7, -1
    154b:	b0ef30        	addx8	a14, a15, a3
    154e:	307f70        	xor	a7, a15, a7
    1551:	c062b0        	sub	a6, a2, a11
    1554:	b0db30        	addx8	a13, a11, a3
    1557:	b0c630        	addx8	a12, a6, a3
    155a:	14cee2        	addi	a14, a14, 20
    155d:	772a           	add.n	a7, a7, a2
    155f:	b0bb40        	addx8	a11, a11, a4
    1562:	7da042        	movi	a4, 125
    1565:	60cd14        	ae_lq32f.i	aeq3, a13, 4
    1568:	604d04        	ae_lq32f.i	aeq1, a13, 0
    156b:	3c4b           	addi.n	a3, a12, 4
    156d:	c0278f8e2e 	{ addi	a2, a14, -8; ae_mulzssq32sp16u.lh	aeq0, aeq1, aep1, aeq3, aep1 }
    1572:	718776        	loop	a7, 15e7 <real_split+0x1db>
    1575:	6083f4        	ae_lq32f.i	aeq2, a3, -4
    1578:	88aa           	add.n	a8, a8, a10
    157a:	9225ba014f 	{ ae_sq56s.i	aeq0, a1, 32; ae_mulzsaq32sp16u.lh	aeq0, aeq3, aep1, aeq1, aep1 }
    157f:	1803404b6e 	{ addi	a6, a11, 4; ae_mulzaafq32sp16u.lh	aeq1, aeq1, aep0, aeq2, aep0 }
    1584:	630114        	ae_sq56s.i	aeq0, a1, 8
    1587:	600304        	ae_lq32f.i	aeq0, a3, 0
    158a:	62247a113f 	{ ae_sq56s.i	aeq1, a1, 24; ae_mulzasq32sp16u.lh	aeq1, aeq2, aep1, aeq0, aep1 }
    158f:	4b014fc33e 	{ addi	a3, a3, -4; ae_mulzasfq32sp16u.lh	aeq3, aeq3, aep0, aeq0, aep0 }
    1594:	c0263dc11f 	{ ae_lq56.i	aeq2, a1, 8; ae_mulzssq32sp16u.lh	aeq0, aeq0, aep1, aeq2, aep1 }
    1599:	fafa3a112f 	{ ae_sq56s.i	aeq1, a1, 16; ae_addq56	aeq2, aeq3, aeq2 }
    159e:	f8723de14f 	{ ae_lq56.i	aeq3, a1, 32; ae_addq56	aeq0, aeq2, aeq0 }
    15a3:	614134        	ae_lq56.i	aeq1, a1, 24
    15a6:	fbee3da12f 	{ ae_lq56.i	aeq1, a1, 16; ae_addq56	aeq3, aeq1, aeq3 }
    15ab:	f97e3b001f 	{ ae_sraiq56	aeq0, aeq0, 1; ae_addq56	aeq1, aeq3, aeq1 }
    15b0:	fc447b105f 	{ ae_sraiq56	aeq1, aeq1, 1; ae_roundsq32sym	aeq0, aeq0 }
    15b5:	11c8f0        	slli	a12, a8, 1
    15b8:	fd4c798b1f 	{ ae_sq32f.i	aeq0, a11, 4; ae_roundsq32sym	aeq1, aeq1 }
    15bd:	41c2c0        	srli	a12, a12, 2
    15c0:	621b04        	ae_sq32f.i	aeq1, a11, 0
    15c3:	72b480        	salt	a11, a4, a8
    15c6:	a0cc50        	addx4	a12, a12, a5
    15c9:	3099b0        	xor	a9, a9, a11
    15cc:	6070a0        	neg	a7, a10
    15cf:	441c04        	ae_lp16x2f.i	aep1, a12, 0
    15d2:	19cc           	bnez.n	a9, 15d7 <real_split+0x1cb>
    15d4:	1a9194        	ae_selp24.lh	aep1, aep1, aep1
    15d7:	93a7b0        	movnez	a10, a7, a11
    15da:	604214        	ae_lq32f.i	aeq1, a2, 4
    15dd:	60d224        	ae_lq32f.iu	aeq3, a2, 8
    15e0:	c0278fc33e 	{ addi	a3, a3, -4; ae_mulzssq32sp16u.lh	aeq0, aeq1, aep1, aeq3, aep1 }
    15e5:	b64b           	addi.n	a11, a6, 4

000015e7 <real_split+0x1db>:
    15e7:	f01d           	retw.n

000015e9 <real_split+0x1dd>:
    15e9:	000000                                        ...

000015ec <xtensa_real_fft_32b>:
    15ec:	004136        	entry	a1, 32
    15ef:	1142d0        	slli	a4, a2, 3
    15f2:	c04340        	sub	a4, a3, a4
    15f5:	0be2e6        	bgei	a2, 128, 1604 <xtensa_real_fft_32b+0x18>
    15f8:	148226        	beqi	a2, 8, 1610 <xtensa_real_fft_32b+0x24>
    15fb:	1fd266        	bnei	a2, 64, 161e <xtensa_real_fft_32b+0x32>
    15fe:	faa551        	l32r	a5, 94 (1358 <xtensa_fft64_32b>)
    1601:	000506        	j	1619 <xtensa_real_fft_32b+0x2d>

00001604 <xtensa_real_fft_32b+0x18>:
    1604:	0ee226        	beqi	a2, 128, 1616 <xtensa_real_fft_32b+0x2a>
    1607:	13f266        	bnei	a2, 0x100, 161e <xtensa_real_fft_32b+0x32>
    160a:	faa351        	l32r	a5, 98 (13a8 <xtensa_fft256_32b>)
    160d:	000206        	j	1619 <xtensa_real_fft_32b+0x2d>

00001610 <xtensa_real_fft_32b+0x24>:
    1610:	fa9c51        	l32r	a5, 80 (ddc <xtensa_fft8_32b>)
    1613:	000086        	j	1619 <xtensa_real_fft_32b+0x2d>

00001616 <xtensa_real_fft_32b+0x2a>:
    1616:	faa151        	l32r	a5, 9c (1380 <xtensa_fft128_32b>)
    1619:	03ad           	mov.n	a10, a3
    161b:	0005e0        	callx8	a5
    161e:	faa051        	l32r	a5, a0 (140c <real_split>)
    1621:	02ad           	mov.n	a10, a2
    1623:	03bd           	mov.n	a11, a3
    1625:	04cd           	mov.n	a12, a4
    1627:	0005e0        	callx8	a5
    162a:	0358           	l32i.n	a5, a3, 0
    162c:	1368           	l32i.n	a6, a3, 4
    162e:	070c           	movi.n	a7, 0
    1630:	1379           	s32i.n	a7, a3, 4
    1632:	c05560        	sub	a5, a5, a6
    1635:	0359           	s32i.n	a5, a3, 0
    1637:	1922a6        	blti	a2, 2, 1654 <xtensa_real_fft_32b+0x68>
    163a:	520b           	addi.n	a5, a2, -1
    163c:	448b           	addi.n	a4, a4, 8
    163e:	b02530        	addx8	a2, a5, a3
    1641:	0f8576        	loop	a5, 1654 <xtensa_real_fft_32b+0x68>
    1644:	1438           	l32i.n	a3, a4, 4
    1646:	0458           	l32i.n	a5, a4, 0
    1648:	448b           	addi.n	a4, a4, 8
    164a:	603030        	neg	a3, a3
    164d:	0259           	s32i.n	a5, a2, 0
    164f:	1239           	s32i.n	a3, a2, 4
    1651:	f8c222        	addi	a2, a2, -8

00001654 <xtensa_real_fft_32b+0x68>:
    1654:	f01d           	retw.n

00001656 <xtensa_real_fft_32b+0x6a>:
	...

00001658 <xtensa_comp_fft_32b>:
    1658:	004136        	entry	a1, 32
    165b:	0bf2e6        	bgei	a2, 0x100, 166a <xtensa_comp_fft_32b+0x12>
    165e:	17b226        	beqi	a2, 16, 1679 <xtensa_comp_fft_32b+0x21>
    1661:	22e266        	bnei	a2, 128, 1687 <xtensa_comp_fft_32b+0x2f>
    1664:	fa8e21        	l32r	a2, 9c (1380 <xtensa_fft128_32b>)
    1667:	0005c6        	j	1682 <xtensa_comp_fft_32b+0x2a>

0000166a <xtensa_comp_fft_32b+0x12>:
    166a:	11f226        	beqi	a2, 0x100, 167f <xtensa_comp_fft_32b+0x27>
    166d:	00a242        	movi	a4, 0x200
    1670:	139247        	bne	a2, a4, 1687 <xtensa_comp_fft_32b+0x2f>
    1673:	fa8c21        	l32r	a2, a4 (13e4 <xtensa_fft512_32b>)
    1676:	000206        	j	1682 <xtensa_comp_fft_32b+0x2a>

00001679 <xtensa_comp_fft_32b+0x21>:
    1679:	fa8421        	l32r	a2, 8c (1304 <xtensa_fft16_32b>)
    167c:	000086        	j	1682 <xtensa_comp_fft_32b+0x2a>

0000167f <xtensa_comp_fft_32b+0x27>:
    167f:	fa8621        	l32r	a2, 98 (13a8 <xtensa_fft256_32b>)
    1682:	03ad           	mov.n	a10, a3
    1684:	0002e0        	callx8	a2
    1687:	f01d           	retw.n

00001689 <xtensa_comp_fft_32b+0x31>:
    1689:	000000                                        ...

0000168c <sw_fft_32b_2811>:
    168c:	006136        	entry	a1, 48
    168f:	0d1666        	bnei	a6, 1, 16a0 <sw_fft_32b_2811+0x14>
    1692:	176c           	movi.n	a7, -31
    1694:	f47070        	extui	a7, a7, 0, 16
    1697:	12f3e6        	bgei	a3, 0x100, 16ad <sw_fft_32b_2811+0x21>
    169a:	2fb366        	bnei	a3, 16, 16cd <sw_fft_32b_2811+0x41>
    169d:	000c86        	j	16d3 <sw_fft_32b_2811+0x47>

000016a0 <sw_fft_32b_2811+0x14>:
    16a0:	569c           	beqz.n	a6, 16b9 <sw_fft_32b_2811+0x2d>
    16a2:	1173f0        	slli	a7, a3, 1
    16a5:	039d           	mov.n	a9, a3
    16a7:	2d13e6        	bgei	a3, 1, 16d8 <sw_fft_32b_2811+0x4c>
    16aa:	001506        	j	1702 <sw_fft_32b_2811+0x76>

000016ad <sw_fft_32b_2811+0x21>:
    16ad:	22f326        	beqi	a3, 0x100, 16d3 <sw_fft_32b_2811+0x47>
    16b0:	00a282        	movi	a8, 0x200
    16b3:	1c1387        	beq	a3, a8, 16d3 <sw_fft_32b_2811+0x47>
    16b6:	002846        	j	175b <sw_fft_32b_2811+0xcf>

000016b9 <sw_fft_32b_2811+0x2d>:
    16b9:	176c           	movi.n	a7, -31
    16bb:	f47070        	extui	a7, a7, 0, 16
    16be:	08e3e6        	bgei	a3, 128, 16ca <sw_fft_32b_2811+0x3e>
    16c1:	0e8326        	beqi	a3, 8, 16d3 <sw_fft_32b_2811+0x47>
    16c4:	0bd326        	beqi	a3, 64, 16d3 <sw_fft_32b_2811+0x47>
    16c7:	002406        	j	175b <sw_fft_32b_2811+0xcf>

000016ca <sw_fft_32b_2811+0x3e>:
    16ca:	05f326        	beqi	a3, 0x100, 16d3 <sw_fft_32b_2811+0x47>
    16cd:	02e326        	beqi	a3, 128, 16d3 <sw_fft_32b_2811+0x47>
    16d0:	0021c6        	j	175b <sw_fft_32b_2811+0xcf>
    16d3:	939d           	ae_zext16	a9, a3
    16d5:	1179f0        	slli	a7, a9, 1
    16d8:	600204        	ae_lq32f.i	aeq0, a2, 0
    16db:	028d           	mov.n	a8, a2
    16dd:	088776        	loop	a7, 16e9 <sw_fft_32b_2811+0x5d>
    16e0:	3404b4        	ae_sraaq56	aeq0, aeq0, a4
    16e3:	620804        	ae_sq32f.i	aeq0, a8, 0
    16e6:	601814        	ae_lq32f.iu	aeq0, a8, 4

000016e9 <sw_fft_32b_2811+0x5d>:
    16e9:	151666        	bnei	a6, 1, 1702 <sw_fft_32b_2811+0x76>
    16ec:	fa6f61        	l32r	a6, a8 (1658 <xtensa_comp_fft_32b>)
    16ef:	03ad           	mov.n	a10, a3
    16f1:	02bd           	mov.n	a11, a2
    16f3:	3129           	s32i.n	a2, a1, 12
    16f5:	0006e0        	callx8	a6
    16f8:	030c           	movi.n	a3, 0
    16fa:	1d1526        	beqi	a5, 1, 171b <sw_fft_32b_2811+0x8f>
    16fd:	001606        	j	1759 <sw_fft_32b_2811+0xcd>

00001700 <sw_fft_32b_2811+0x74>:
	...

00001702 <sw_fft_32b_2811+0x76>:
    1702:	fa6a61        	l32r	a6, ac (15ec <xtensa_real_fft_32b>)
    1705:	03ad           	mov.n	a10, a3
    1707:	02bd           	mov.n	a11, a2
    1709:	3129           	s32i.n	a2, a1, 12
    170b:	092d           	mov.n	a2, a9
    170d:	0006e0        	callx8	a6
    1710:	11f2e0        	slli	a15, a2, 2
    1713:	603070        	neg	a3, a7
    1716:	0f7d           	mov.n	a7, a15
    1718:	3d1566        	bnei	a5, 1, 1759 <sw_fft_32b_2811+0xcd>
    171b:	3128           	l32i.n	a2, a1, 12
    171d:	a02320        	addx4	a2, a3, a2
    1720:	fd24bd020f 	{ ae_lq32f.i	aeq0, a2, 0; ae_zeroq56	aeq1 }
    1725:	0f17a6        	blti	a7, 1, 1738 <sw_fft_32b_2811+0xac>
    1728:	fe0453322f 	{ or	a3, a2, a2; ae_movq56	aeq2, aeq0 }
    172d:	078776        	loop	a7, 1738 <sw_fft_32b_2811+0xac>
    1730:	ff80bd531f 	{ ae_lq32f.iu	aeq2, a3, 4; ae_absq56	aeq3, aeq2 }
    1735:	0179e4        	ae_orq56	aeq1, aeq1, aeq3

00001738 <sw_fft_32b_2811+0xac>:
    1738:	621124        	ae_sq32f.i	aeq1, a1, 8
    173b:	2158           	l32i.n	a5, a1, 8
    173d:	030c           	movi.n	a3, 0
    173f:	40e560        	nsa	a6, a5
    1742:	b33650        	movgez	a3, a6, a5
    1745:	0d17a6        	blti	a7, 1, 1756 <sw_fft_32b_2811+0xca>
    1748:	0a8776        	loop	a7, 1756 <sw_fft_32b_2811+0xca>
    174b:	fc24fe830f 	{ ae_slaasq56s	aeq0, aeq0, a3; nop }
    1750:	620204        	ae_sq32f.i	aeq0, a2, 0
    1753:	601214        	ae_lq32f.iu	aeq0, a2, 4
    1756:	c04430        	sub	a4, a4, a3

00001759 <sw_fft_32b_2811+0xcd>:
    1759:	047d           	mov.n	a7, a4
    175b:	872d           	ae_sext16	a2, a7
    175d:	f01d           	retw.n

0000175f <sw_fft_32b_2811+0xd3>:
	...

00001760 <fill_vad_thrd_Nbands>:
    1760:	004136        	entry	a1, 32
    1763:	1a14a6        	blti	a4, 1, 1781 <fill_vad_thrd_Nbands+0x21>
    1766:	944d           	ae_zext16	a4, a4
    1768:	158476        	loop	a4, 1781 <fill_vad_thrd_Nbands+0x21>
    176b:	234d           	ae_l16si.n	a4, a3, 0
    176d:	332b           	addi.n	a3, a3, 2
    176f:	745840        	extui	a5, a4, 8, 8
    1772:	744040        	extui	a4, a4, 0, 8
    1775:	115590        	slli	a5, a5, 7
    1778:	114490        	slli	a4, a4, 7
    177b:	625d           	ae_s16i.n	a5, a2, 0
    177d:	724d           	ae_s16i.n	a4, a2, 2
    177f:	224b           	addi.n	a2, a2, 4

00001781 <fill_vad_thrd_Nbands+0x21>:
    1781:	f01d           	retw.n

00001783 <fill_vad_thrd_Nbands+0x23>:
	...

00001784 <complement_para>:
    1784:	004136        	entry	a1, 32
    1787:	f47c           	movi.n	a4, -1
    1789:	114410        	slli	a4, a4, 15
    178c:	c0f430        	sub	a15, a4, a3
    178f:	623d           	ae_s16i.n	a3, a2, 0
    1791:	72fd           	ae_s16i.n	a15, a2, 2
    1793:	f01d           	retw.n

00001795 <complement_para+0x11>:
    1795:	000000                                        ...

00001798 <common_noise_gen_init>:
    1798:	004136        	entry	a1, 32
    179b:	2c93d2        	l16si	a13, a3, 88
    179e:	2d9352        	l16si	a5, a3, 90
    17a1:	fe7c           	movi.n	a14, -1
    17a3:	140c           	movi.n	a4, 1
    17a5:	105252        	s16i	a5, a2, 32
    17a8:	115e10        	slli	a5, a14, 15
    17ab:	8c5242        	s16i	a4, a2, 0x118
    17ae:	2293b2        	l16si	a11, a3, 68
    17b1:	2493c2        	l16si	a12, a3, 72
    17b4:	c045d0        	sub	a4, a5, a13
    17b7:	4f0c           	movi.n	a15, 4
    17b9:	6d5242        	s16i	a4, a2, 218
    17bc:	0252b2        	s16i	a11, a2, 4
    17bf:	0352c2        	s16i	a12, a2, 6
    17c2:	6c52d2        	s16i	a13, a2, 216
    17c5:	70c332        	addi	a3, a3, 112
    17c8:	428b           	addi.n	a4, a2, 8
    17ca:	158f76        	loop	a15, 17e3 <common_noise_gen_init+0x4b>
    17cd:	235d           	ae_l16si.n	a5, a3, 0
    17cf:	332b           	addi.n	a3, a3, 2
    17d1:	746850        	extui	a6, a5, 8, 8
    17d4:	745050        	extui	a5, a5, 0, 8
    17d7:	116690        	slli	a6, a6, 7
    17da:	115590        	slli	a5, a5, 7
    17dd:	646d           	ae_s16i.n	a6, a4, 0
    17df:	745d           	ae_s16i.n	a5, a4, 2
    17e1:	444b           	addi.n	a4, a4, 4

000017e3 <common_noise_gen_init+0x4b>:
    17e3:	740c           	movi.n	a4, 7
    17e5:	fa3231        	l32r	a3, b0 (2d30 <win_ns>)
    17e8:	78d442        	addmi	a4, a4, 0x7800
    17eb:	3d6232        	s32i	a3, a2, 244
    17ee:	175242        	s16i	a4, a2, 46
    17f1:	f01d           	retw.n

000017f3 <common_noise_gen_init+0x5b>:
	...

000017f4 <common_NR_init>:
    17f4:	004136        	entry	a1, 32
    17f7:	2e0252        	l8ui	a5, a2, 46
    17fa:	c268           	l32i.n	a6, a2, 48
    17fc:	a0a0b2        	movi	a11, 160
    17ff:	35ac           	beqz.n	a5, 1826 <common_NR_init+0x32>
    1801:	787c           	movi.n	a8, -9
    1803:	791c           	movi.n	a9, 23
    1805:	070c           	movi.n	a7, 0
    1807:	018850        	slli	a8, a8, 27
    180a:	119950        	slli	a9, a9, 11
    180d:	ca0c           	movi.n	a10, 12
    180f:	b2ba           	add.n	a11, a2, a11

00001811 <common_NR_init+0x1d>:
    1811:	06cd           	mov.n	a12, a6
    1813:	0b89           	s32i.n	a8, a11, 0
    1815:	038a76        	loop	a10, 181c <common_NR_init+0x28>
    1818:	6c9d           	ae_s16i.n	a9, a12, 0
    181a:	cc2b           	addi.n	a12, a12, 2

0000181c <common_NR_init+0x28>:
    181c:	771b           	addi.n	a7, a7, 1
    181e:	18c662        	addi	a6, a6, 24
    1821:	bb4b           	addi.n	a11, a11, 4
    1823:	ea3757        	bltu	a7, a5, 1811 <common_NR_init+0x1d>

00001826 <common_NR_init+0x32>:
    1826:	2e9362        	l16si	a6, a3, 92
    1829:	f57c           	movi.n	a5, -1
    182b:	115510        	slli	a5, a5, 15
    182e:	625262        	s16i	a6, a2, 196
    1831:	c06560        	sub	a6, a5, a6
    1834:	635262        	s16i	a6, a2, 198
    1837:	2f9362        	l16si	a6, a3, 94
    183a:	645262        	s16i	a6, a2, 200
    183d:	ffa792        	movi	a9, 0x7ff
    1840:	c06560        	sub	a6, a5, a6
    1843:	655262        	s16i	a6, a2, 202
    1846:	309362        	l16si	a6, a3, 96
    1849:	665262        	s16i	a6, a2, 204
    184c:	0378           	l32i.n	a7, a3, 0
    184e:	c06560        	sub	a6, a5, a6
    1851:	675262        	s16i	a6, a2, 206
    1854:	319362        	l16si	a6, a3, 98
    1857:	685262        	s16i	a6, a2, 208
    185a:	180c           	movi.n	a8, 1
    185c:	c06560        	sub	a6, a5, a6
    185f:	695262        	s16i	a6, a2, 210
    1862:	329362        	l16si	a6, a3, 100
    1865:	9b6c           	movi.n	a11, -23
    1867:	1199b0        	slli	a9, a9, 5
    186a:	155282        	s16i	a8, a2, 42
    186d:	f480b0        	extui	a8, a11, 0, 16
    1870:	c05560        	sub	a5, a5, a6
    1873:	f7a1d2        	movi	a13, 0x1f7
    1876:	f7a3e2        	movi	a14, 0x3f7
    1879:	00a1f2        	movi	a15, 0x100
    187c:	715292        	s16i	a9, a2, 226
    187f:	6f5282        	s16i	a8, a2, 222
    1882:	118dd0        	slli	a8, a13, 3
    1885:	119ee0        	slli	a9, a14, 2
    1888:	6a5262        	s16i	a6, a2, 212
    188b:	6b5252        	s16i	a5, a2, 214
    188e:	fa09c1        	l32r	a12, b4 (7fff0000 <_end+0x7ffed2ac>)
    1891:	1252f2        	s16i	a15, a2, 36
    1894:	6da0a2        	movi	a10, 109
    1897:	878a           	add.n	a8, a7, a8
    1899:	0279           	s32i.n	a7, a2, 0
    189b:	779a           	add.n	a7, a7, a9
    189d:	7893f2        	l16si	a15, a3, 240
    18a0:	8b52a2        	s16i	a10, a2, 0x116
    18a3:	4362c2        	s32i	a12, a2, 0x10c
    18a6:	4462c2        	s32i	a12, a2, 0x110
    18a9:	3b6282        	s32i	a8, a2, 236
    18ac:	3c6272        	s32i	a7, a2, 240
    18af:	8a52f2        	s16i	a15, a2, 0x114
    18b2:	132426        	beqi	a4, 2, 18c9 <common_NR_init+0xd5>
    18b5:	2f0242        	l8ui	a4, a2, 47
    18b8:	402222        	l32i	a2, a2, 0x100
    18bb:	130c           	movi.n	a3, 1
    18bd:	848c           	beqz.n	a4, 18c9 <common_NR_init+0xd5>
    18bf:	013320        	slli	a3, a3, 30
    18c2:	038476        	loop	a4, 18c9 <common_NR_init+0xd5>
    18c5:	0239           	s32i.n	a3, a2, 0
    18c7:	224b           	addi.n	a2, a2, 4

000018c9 <common_NR_init+0xd5>:
    18c9:	f01d           	retw.n

000018cb <common_NR_init+0xd7>:
	...

000018cc <get_post_ec_memsize>:
    18cc:	004136        	entry	a1, 32
    18cf:	bfa122        	movi	a2, 0x1bf
    18d2:	1122c0        	slli	a2, a2, 4
    18d5:	f01d           	retw.n

000018d7 <get_post_ec_memsize+0xb>:
	...

000018d8 <EXT_POST_EC_Init>:
    18d8:	004136        	entry	a1, 32
    18db:	bfa1c2        	movi	a12, 0x1bf
    18de:	f9f641        	l32r	a4, b8 (1c10 <xt_memset>)
    18e1:	11ccd0        	slli	a12, a12, 3
    18e4:	0b0c           	movi.n	a11, 0
    18e6:	02ad           	mov.n	a10, a2
    18e8:	0004e0        	callx8	a4
    18eb:	f9f441        	l32r	a4, bc (1c24 <xt_memcpy>)
    18ee:	a28b           	addi.n	a10, a2, 8
    18f0:	b32b           	addi.n	a11, a3, 2
    18f2:	79a0c2        	movi	a12, 121
    18f5:	0004e0        	callx8	a4
    18f8:	fca052        	movi	a5, 252
    18fb:	f4a062        	movi	a6, 244
    18fe:	a25a           	add.n	a10, a2, a5
    1900:	b36a           	add.n	a11, a3, a6
    1902:	5c0c           	movi.n	a12, 5
    1904:	0004e0        	callx8	a4
    1907:	18d232        	addmi	a3, a2, 0x1800
    190a:	f9ed41        	l32r	a4, c0 (1798 <common_noise_gen_init>)
    190d:	03ad           	mov.n	a10, a3
    190f:	02bd           	mov.n	a11, a2
    1911:	0229           	s32i.n	a2, a2, 0
    1913:	0004e0        	callx8	a4
    1916:	bfa642        	movi	a4, 0x6bf
    1919:	1144e0        	slli	a4, a4, 2
    191c:	424a           	add.n	a4, a2, a4
    191e:	47a6d2        	movi	a13, 0x647
    1921:	3e6342        	s32i	a4, a3, 248
    1924:	114de0        	slli	a4, a13, 2
    1927:	424a           	add.n	a4, a2, a4
    1929:	cfa6e2        	movi	a14, 0x6cf
    192c:	406342        	s32i	a4, a3, 0x100
    192f:	114ee0        	slli	a4, a14, 2
    1932:	c7a662        	movi	a6, 0x6c7
    1935:	424a           	add.n	a4, a2, a4
    1937:	1166e0        	slli	a6, a6, 2
    193a:	c349           	s32i.n	a4, a3, 48
    193c:	f9e241        	l32r	a4, c4 (17f4 <common_NR_init>)
    193f:	626a           	add.n	a6, a2, a6
    1941:	0c0c           	movi.n	a12, 0
    1943:	03ad           	mov.n	a10, a3
    1945:	02bd           	mov.n	a11, a2
    1947:	3f6362        	s32i	a6, a3, 252
    194a:	0004e0        	callx8	a4
    194d:	10d232        	addmi	a3, a2, 0x1000
    1950:	18d242        	addmi	a4, a2, 0x1800
    1953:	ffa0d2        	movi	a13, 255
    1956:	3a6432        	s32i	a3, a4, 232
    1959:	059252        	l16si	a5, a2, 10
    195c:	1bd2c2        	addmi	a12, a2, 0x1b00
    195f:	7fdd42        	addmi	a4, a13, 0x7f00
    1962:	8192f2        	l16si	a15, a2, 0x102
    1965:	735c52        	s16i	a5, a12, 230
    1968:	755cf2        	s16i	a15, a12, 234
    196b:	725c42        	s16i	a4, a12, 228
    196e:	745c42        	s16i	a4, a12, 232
    1971:	f01d           	retw.n

00001973 <EXT_POST_EC_Init+0x9b>:
	...

00001974 <aec_post_prcs>:
    1974:	004136        	entry	a1, 32
    1977:	ffa0f2        	movi	a15, 255
    197a:	427d           	ae_l16ui.n	a7, a2, 0
    197c:	626d           	ae_s16i.n	a6, a2, 0
    197e:	303664        	ae_cvtp24a16x2.ll	aep3, a6, a6
    1981:	7fdf62        	addmi	a6, a15, 0x7f00
    1984:	401214        	ae_lp16f.i	aep1, a2, 2
    1987:	302664        	ae_cvtp24a16x2.ll	aep2, a6, a6
    198a:	ea458fff8f 	{ movi	a8, -1; ae_mulfp24s.ll	aeq0, aep1, aep2 }
    198f:	302774        	ae_cvtp24a16x2.ll	aep2, a7, a7
    1992:	dd4ec0102f 	{ movi	a2, 16; ae_subsp24s	aep3, aep3, aep2 }
    1997:	418980        	srli	a8, a8, 9
    199a:	f867e2088f 	{ ae_movpa24x2	aep0, a8, a8; ae_roundsp24q48asym	aep1, aeq0 }
    199f:	f60c           	movi.n	a6, 15
    19a1:	cd2c4fe55e 	{ addi	a5, a5, -2; ae_sraip24	aep3, aep3, 4 }
    19a6:	fec442        	addi	a4, a4, -2
    19a9:	404304        	ae_lp16f.i	aep4, a3, 0

000019ac <aec_post_prcs+0x38>:
    19ac:	07a324        	ae_addsp24s	aep2, aep2, aep3
    19af:	0782d4        	ae_subsp24s	aep5, aep0, aep2
    19b2:	015174        	ae_mulfp24s.ll	aeq0, aep5, aep1
    19b5:	060934        	ae_roundsq32asym	aeq0, aeq0
    19b8:	188676        	loop	a6, 19d4 <aec_post_prcs+0x60>
    19bb:	ea89ecf51f 	{ ae_lp16f.iu	aep7, a5, 2; ae_mulfp24s.ll	aeq1, aep2, aep4 }
    19c0:	d5fe2cc31f 	{ ae_lp16f.iu	aep4, a3, 2; ae_mulfq32sp16s.l	aeq2, aeq0, aep7 }
    19c5:	065934        	ae_roundsq32asym	aeq1, aeq1
    19c8:	35a094        	ae_slliq56	aeq2, aeq2, 2
    19cb:	015ac4        	ae_addq56	aeq1, aeq1, aeq2
    19ce:	1b9f54        	ae_roundsp16q48asym	aep5, aeq1
    19d1:	42d414        	ae_sp16f.l.iu	aep5, a4, 2

000019d4 <aec_post_prcs+0x60>:
    19d4:	220b           	addi.n	a2, a2, -1
    19d6:	fd2256        	bnez	a2, 19ac <aec_post_prcs+0x38>
    19d9:	f01d           	retw.n

000019db <aec_post_prcs+0x67>:
	...

000019dc <ns_ifft_wo>:
    19dc:	004136        	entry	a1, 32
    19df:	250c           	movi.n	a5, 2
    19e1:	030480        	rsr.br	a8
    19e4:	0248           	l32i.n	a4, a2, 0
    19e6:	0a1580        	depbits	a8, a5, 0, 2
    19e9:	f99771        	l32r	a7, 48 (2830 <fftorder_512_12b>)
    19ec:	3a2252        	l32i	a5, a2, 232
    19ef:	060c           	movi.n	a6, 0
    19f1:	1469           	s32i.n	a6, a4, 4
    19f3:	0469           	s32i.n	a6, a4, 0
    19f5:	80a0f2        	movi	a15, 128
    19f8:	130480        	wsr.br	a8
    19fb:	674b           	addi.n	a6, a7, 4
    19fd:	5c0504        	ae_lp24x2f.i	aep0, a5, 0
    1a00:	0e8f76        	loop	a15, 1a12 <ns_ifft_wo+0x36>
    1a03:	fc1860067e 	{ l16si	a7, a6, 0; ae_negsp24s	aep1, aep0 }
    1a08:	e0042f851f 	{ ae_lp24x2f.iu	aep0, a5, 8; ae_movtp24x2	aep1, aep0, b0:b1 }
    1a0d:	664b           	addi.n	a6, a6, 4
    1a0f:	5f1474        	ae_sp24x2f.x	aep1, a4, a7

00001a12 <ns_ifft_wo+0x36>:
    1a12:	7fa072        	movi	a7, 127
    1a15:	5c85e4        	ae_lp24x2f.iu	aep0, a5, -16
    1a18:	098776        	loop	a7, 1a25 <ns_ifft_wo+0x49>
    1a1b:	267d           	ae_l16si.n	a7, a6, 0
    1a1d:	664b           	addi.n	a6, a6, 4
    1a1f:	5f0474        	ae_sp24x2f.x	aep0, a4, a7
    1a22:	5c85f4        	ae_lp24x2f.iu	aep0, a5, -8
    1a25:	f98951        	l32r	a5, 4c (168c <sw_fft_32b_2811>)
    1a28:	00a1b2        	movi	a11, 0x100
    1a2b:	8c0c           	movi.n	a12, 8
    1a2d:	0d0c           	movi.n	a13, 0
    1a2f:	1e0c           	movi.n	a14, 1
    1a31:	04ad           	mov.n	a10, a4
    1a33:	0005e0        	callx8	a5
    1a36:	139262        	l16si	a6, a2, 38
    1a39:	3f22e2        	l32i	a14, a2, 252
    1a3c:	3d2272        	l32i	a7, a2, 244
    1a3f:	c0fa60        	sub	a15, a10, a6
    1a42:	fece22        	addi	a2, a14, -2
    1a45:	091c           	movi.n	a9, 16
    1a47:	fec352        	addi	a5, a3, -2
    1a4a:	fec762        	addi	a6, a7, -2
    1a4d:	600404        	ae_lq32f.i	aeq0, a4, 0
    1a50:	20c772        	addi	a7, a7, 32
    1a53:	f8cf32        	addi	a3, a15, -8
    1a56:	028d           	mov.n	a8, a2
    1a58:	1c8976        	loop	a9, 1a78 <ns_ifft_wo+0x9c>
    1a5b:	fc24fe830f 	{ ae_slaasq56s	aeq0, aeq0, a3; nop }
    1a60:	fc446c881f 	{ ae_lp16f.iu	aep0, a8, 2; ae_roundsq32sym	aeq0, aeq0 }
    1a65:	4097f4        	ae_lp16f.iu	aep1, a7, -2
    1a68:	ea20ecf61f 	{ ae_lp16f.iu	aep7, a6, 2; ae_mulfp24s.hl	aeq1, aep0, aep1 }
    1a6d:	f49efd142f 	{ ae_lq32f.iu	aeq0, a4, 8; ae_mulafq32sp16s.l	aeq1, aeq0, aep7 }
    1a72:	1b9e04        	ae_roundsp16q48sym	aep0, aeq1
    1a75:	428514        	ae_sp16f.l.iu	aep0, a5, 2
    1a78:	e0a062        	movi	a6, 224
    1a7b:	f03d           	nop.n
    1a7d:	0f8676        	loop	a6, 1a90 <ns_ifft_wo+0xb4>
    1a80:	fc24fe834f 	{ ae_slaasq56s	aeq1, aeq0, a3; nop }
    1a85:	fd4c7d142f 	{ ae_lq32f.iu	aeq0, a4, 8; ae_roundsq32sym	aeq1, aeq1 }
    1a8a:	1b9e04        	ae_roundsp16q48sym	aep0, aeq1
    1a8d:	428514        	ae_sp16f.l.iu	aep0, a5, 2
    1a90:	051c           	movi.n	a5, 16
    1a92:	0020f0        	nop
    1a95:	0f8576        	loop	a5, 1aa8 <ns_ifft_wo+0xcc>
    1a98:	fc24fe834f 	{ ae_slaasq56s	aeq1, aeq0, a3; nop }
    1a9d:	fd4c7d142f 	{ ae_lq32f.iu	aeq0, a4, 8; ae_roundsq32sym	aeq1, aeq1 }
    1aa2:	1b9e04        	ae_roundsp16q48sym	aep0, aeq1
    1aa5:	428214        	ae_sp16f.l.iu	aep0, a2, 2
    1aa8:	f01d           	retw.n

00001aaa <ns_ifft_wo+0xce>:
	...

00001aac <NOISE_GEN_Prcs>:
    1aac:	004136        	entry	a1, 32
    1aaf:	fc2080786f 	{ movi	a6, 120; ae_zerop48	aep0 }
    1ab4:	441304        	ae_lp16x2f.i	aep1, a3, 0
    1ab7:	035d           	mov.n	a5, a3
    1ab9:	f03d           	nop.n
    1abb:	f03d           	nop.n
    1abd:	048676        	loop	a6, 1ac5 <NOISE_GEN_Prcs+0x19>
    1ac0:	d821ad951f 	{ ae_lp16x2f.iu	aep1, a5, 4; ae_maxabssp24s	aep0, aep0, aep1 }

00001ac5 <NOISE_GEN_Prcs+0x19>:
    1ac5:	dc01e1225e 	{ l16si	a5, a2, 36; ae_selp24.lh	aep1, aep0, aep0 }
    1aca:	d82233e2be 	{ l32i	a11, a2, 248; ae_maxp24s	aep0, aep0, aep1 }
    1acf:	0008d4        	ae_cvta32p24.l	a8, aep0
    1ad2:	3d2262        	l32i	a6, a2, 244
    1ad5:	02a8           	l32i.n	a10, a2, 0
    1ad7:	40e880        	nsa	a8, a8
    1ada:	435850        	min	a5, a8, a5
    1add:	f95ac1        	l32r	a12, 48 (2830 <fftorder_512_12b>)
    1ae0:	125282        	s16i	a8, a2, 36
    1ae3:	031654        	wur.ae_sar	a5
    1ae6:	04a492        	movi	a9, 0x404
    1ae9:	447b04        	ae_lp16x2f.i	aep7, a11, 0
    1aec:	8d0c           	movi.n	a13, 8
    1aee:	9a9a           	add.n	a9, a10, a9
    1af0:	070c           	movi.n	a7, 0
    1af2:	08cc82        	addi	a8, a12, 8
    1af5:	04daa2        	addmi	a10, a10, 0x400
    1af8:	f83fad160f 	{ ae_lp16x2f.i	aep1, a6, 0; ae_sllssp24s	aep0, aep7 }
    1afd:	158d76        	loop	a13, 1b16 <NOISE_GEN_Prcs+0x6a>
    1b00:	e820adfb1f 	{ ae_lp16x2f.iu	aep7, a11, 4; ae_mulfp24s.hh	aeq0, aep0, aep1 }
    1b05:	eb21ed961f 	{ ae_lp16x2f.iu	aep1, a6, 4; ae_mulfp24s.ll	aeq3, aep0, aep1 }
    1b0a:	f83fb84a7f 	{ ae_sq32f.x	aeq0, a10, a7; ae_sllssp24s	aep0, aep7 }
    1b0f:	62b974        	ae_sq32f.x	aeq3, a9, a7
    1b12:	287d           	ae_l16si.n	a7, a8, 0
    1b14:	888b           	addi.n	a8, a8, 8
    1b16:	70a0b2        	movi	a11, 112
    1b19:	440304        	ae_lp16x2f.i	aep0, a3, 0
    1b1c:	f03d           	nop.n
    1b1e:	138b76        	loop	a11, 1b35 <NOISE_GEN_Prcs+0x89>
    1b21:	f823ed831f 	{ ae_lp16x2f.iu	aep0, a3, 4; ae_sllssp24s	aep1, aep0 }
    1b26:	0a0984        	ae_cvtq48p24s.h	aeq0, aep1
    1b29:	fd2c384a7f 	{ ae_sq32f.x	aeq0, a10, a7; ae_cvtq48p24s.l	aeq1, aep1 }
    1b2e:	629974        	ae_sq32f.x	aeq1, a9, a7
    1b31:	287d           	ae_l16si.n	a7, a8, 0
    1b33:	888b           	addi.n	a8, a8, 8
    1b35:	3e22b2        	l32i	a11, a2, 248
    1b38:	8c0c           	movi.n	a12, 8
    1b3a:	fccbb2        	addi	a11, a11, -4
    1b3d:	188c76        	loop	a12, 1b59 <NOISE_GEN_Prcs+0xad>
    1b40:	f823eda6ff 	{ ae_lp16x2f.iu	aep2, a6, -4; ae_sllssp24s	aep1, aep0 }
    1b45:	ea44b38b1f 	{ ae_sp16x2f.iu	aep0, a11, 4; ae_mulfp24s.hl	aeq0, aep1, aep2 }
    1b4a:	e945ed831f 	{ ae_lp16x2f.iu	aep0, a3, 4; ae_mulfp24s.lh	aeq3, aep1, aep2 }
    1b4f:	628a74        	ae_sq32f.x	aeq0, a10, a7
    1b52:	62b974        	ae_sq32f.x	aeq3, a9, a7
    1b55:	287d           	ae_l16si.n	a7, a8, 0
    1b57:	888b           	addi.n	a8, a8, 8
    1b59:	0238           	l32i.n	a3, a2, 0
    1b5b:	80a0b2        	movi	a11, 128
    1b5e:	8c0c           	movi.n	a12, 8
    1b60:	04d3a2        	addmi	a10, a3, 0x400
    1b63:	f93a31        	l32r	a3, 4c (168c <sw_fft_32b_2811>)
    1b66:	1d0c           	movi.n	a13, 1
    1b68:	0e0c           	movi.n	a14, 0
    1b6a:	0003e0        	callx8	a3
    1b6d:	c035a0        	sub	a3, a5, a10
    1b70:	135232        	s16i	a3, a2, 38
    1b73:	f93731        	l32r	a3, 50 (378 <gen_power>)
    1b76:	00a1b2        	movi	a11, 0x100
    1b79:	02ad           	mov.n	a10, a2
    1b7b:	0003e0        	callx8	a3
    1b7e:	f95231        	l32r	a3, c8 (514 <NR_vad1>)
    1b81:	02ad           	mov.n	a10, a2
    1b83:	0003e0        	callx8	a3
    1b86:	f95131        	l32r	a3, cc (630 <NR_vad2>)
    1b89:	02ad           	mov.n	a10, a2
    1b8b:	0003e0        	callx8	a3
    1b8e:	f95031        	l32r	a3, d0 (7a8 <NR_NoiseEstimate>)
    1b91:	02ad           	mov.n	a10, a2
    1b93:	0003e0        	callx8	a3
    1b96:	f94f31        	l32r	a3, d4 (150 <comfort_noise_gen_wb2>)
    1b99:	02ad           	mov.n	a10, a2
    1b9b:	0003e0        	callx8	a3
    1b9e:	f94e31        	l32r	a3, d8 (19dc <ns_ifft_wo>)
    1ba1:	02ad           	mov.n	a10, a2
    1ba3:	04bd           	mov.n	a11, a4
    1ba5:	0003e0        	callx8	a3
    1ba8:	f01d           	retw.n

00001baa <NOISE_GEN_Prcs+0xfe>:
	...

00001bac <EXT_POST_EC_PRCS>:
    1bac:	004136        	entry	a1, 32
    1baf:	f94b71        	l32r	a7, dc (1aac <NOISE_GEN_Prcs>)
    1bb2:	18d2a2        	addmi	a10, a2, 0x1800
    1bb5:	03bd           	mov.n	a11, a3
    1bb7:	02cd           	mov.n	a12, a2
    1bb9:	0007e0        	callx8	a7
    1bbc:	f9a682        	movi	a8, 0x6f9
    1bbf:	115590        	slli	a5, a5, 7
    1bc2:	1188e0        	slli	a8, a8, 2
    1bc5:	7fc5e2        	addi	a14, a5, 127
    1bc8:	f94651        	l32r	a5, e0 (1974 <aec_post_prcs>)
    1bcb:	1bd272        	addmi	a7, a2, 0x1b00
    1bce:	a28a           	add.n	a10, a2, a8
    1bd0:	03bd           	mov.n	a11, a3
    1bd2:	04cd           	mov.n	a12, a4
    1bd4:	02dd           	mov.n	a13, a2
    1bd6:	7457e2        	s16i	a14, a7, 232
    1bd9:	0005e0        	callx8	a5
    1bdc:	759722        	l16si	a2, a7, 234
    1bdf:	1f0c           	movi.n	a15, 1
    1be1:	030c           	movi.n	a3, 0
    1be3:	662d           	ae_s16i.n	a2, a6, 0
    1be5:	112f30        	slli	a2, a15, 13
    1be8:	763d           	ae_s16i.n	a3, a6, 2
    1bea:	025622        	s16i	a2, a6, 4
    1bed:	f01d           	retw.n

00001bef <EXT_POST_EC_PRCS+0x43>:
	...

00001bf0 <__do_global_ctors_aux>:
    1bf0:	004136        	entry	a1, 32
    1bf3:	f93c31        	l32r	a3, e4 (2088 <__CTOR_END__>)
    1bf6:	fcc322        	addi	a2, a3, -4
    1bf9:	0228           	l32i.n	a2, a2, 0
    1bfb:	f8c332        	addi	a3, a3, -8
    1bfe:	0a0226        	beqi	a2, -1, 1c0c <__do_global_ctors_aux+0x1c>

00001c01 <__do_global_ctors_aux+0x11>:
    1c01:	0002e0        	callx8	a2
    1c04:	0328           	l32i.n	a2, a3, 0
    1c06:	fcc332        	addi	a3, a3, -4
    1c09:	f40266        	bnei	a2, -1, 1c01 <__do_global_ctors_aux+0x11>
    1c0c:	f01d           	retw.n

00001c0e <__do_global_ctors_aux+0x1e>:
	...

00001c10 <xt_memset>:
    1c10:	004136        	entry	a1, 32
    1c13:	928c           	beqz.n	a2, 1c20 <xt_memset+0x10>
    1c15:	748c           	beqz.n	a4, 1c20 <xt_memset+0x10>
    1c17:	025d           	mov.n	a5, a2
    1c19:	038476        	loop	a4, 1c20 <xt_memset+0x10>
    1c1c:	653d           	ae_s16i.n	a3, a5, 0
    1c1e:	552b           	addi.n	a5, a5, 2

00001c20 <xt_memset+0x10>:
    1c20:	f01d           	retw.n

00001c22 <xt_memset+0x12>:
	...

00001c24 <xt_memcpy>:
    1c24:	004136        	entry	a1, 32
    1c27:	025d           	mov.n	a5, a2
    1c29:	020c           	movi.n	a2, 0
    1c2b:	b5bc           	beqz.n	a5, 1c6a <xt_memcpy+0x46>
    1c2d:	93bc           	beqz.n	a3, 1c6a <xt_memcpy+0x46>
    1c2f:	24b357        	bgeu	a3, a5, 1c57 <xt_memcpy+0x33>
    1c32:	902430        	addx2	a2, a4, a3
    1c35:	1eb527        	bgeu	a5, a2, 1c57 <xt_memcpy+0x33>
    1c38:	052d           	mov.n	a2, a5
    1c3a:	c4ac           	beqz.n	a4, 1c6a <xt_memcpy+0x46>
    1c3c:	240b           	addi.n	a2, a4, -1
    1c3e:	1122f0        	slli	a2, a2, 1
    1c41:	332a           	add.n	a3, a3, a2
    1c43:	652a           	add.n	a6, a5, a2
    1c45:	0b8476        	loop	a4, 1c54 <xt_memcpy+0x30>
    1c48:	232d           	ae_l16si.n	a2, a3, 0
    1c4a:	662d           	ae_s16i.n	a2, a6, 0
    1c4c:	fec332        	addi	a3, a3, -2
    1c4f:	052d           	mov.n	a2, a5
    1c51:	fec662        	addi	a6, a6, -2

00001c54 <xt_memcpy+0x30>:
    1c54:	000486        	j	1c6a <xt_memcpy+0x46>

00001c57 <xt_memcpy+0x33>:
    1c57:	052d           	mov.n	a2, a5
    1c59:	d48c           	beqz.n	a4, 1c6a <xt_memcpy+0x46>
    1c5b:	056d           	mov.n	a6, a5
    1c5d:	098476        	loop	a4, 1c6a <xt_memcpy+0x46>
    1c60:	232d           	ae_l16si.n	a2, a3, 0
    1c62:	662d           	ae_s16i.n	a2, a6, 0
    1c64:	332b           	addi.n	a3, a3, 2
    1c66:	052d           	mov.n	a2, a5
    1c68:	662b           	addi.n	a6, a6, 2

00001c6a <xt_memcpy+0x46>:
    1c6a:	f01d           	retw.n

00001c6c <_fini>:
    1c6c:	008136        	entry	a1, 64
    1c6f:	f91e81        	l32r	a8, e8 (104 <__do_global_dtors_aux>)
    1c72:	f03d           	nop.n
    1c74:	0008e0        	callx8	a8

00001c77 <_fini+0xb>:
    1c77:	f01d           	retw.n
