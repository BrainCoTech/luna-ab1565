
Build/lib/pisplit_fir_eq_position_independent.splitload.lib:     file format elf32-xtensa-le


Disassembly of section .text:

00000000 <_init-0x4c>:
   0:	00000098 00000188 0000041c 00000000     ................
  10:	000003ec 00000000 00000404 000000dc     ................
  20:	000004a4 00000440 000000b0 0000045b     ....@.......[...
  30:	000000b8 00000471 00000138 00000487     ....q...8.......
  40:	00000430 000003f4 00000064              0.......d...

0000004c <_init>:
  4c:	008136        	entry	a1, 64
  4f:	ffec81        	l32r	a8, 0 (98 <frame_dummy>)
  52:	f03d           	nop.n
  54:	0008e0        	callx8	a8
  57:	ffeb81        	l32r	a8, 4 (188 <__do_global_ctors_aux>)
  5a:	f03d           	nop.n
  5c:	0008e0        	callx8	a8
  5f:	f01d           	retw.n

00000061 <_init+0x15>:
  61:	000000                                        ...

00000064 <__do_global_dtors_aux>:
  64:	004136        	entry	a1, 32
  67:	ffe821        	l32r	a2, 8 (41c <__do_global_dtors_aux.completed>)
  6a:	000232        	l8ui	a3, a2, 0
  6d:	23ec           	bnez.n	a3, 93 <__do_global_dtors_aux+0x2f>

0000006f <__do_global_dtors_aux+0xb>:
  6f:	1248           	l32i.n	a4, a2, 4
  71:	0438           	l32i.n	a3, a4, 0
  73:	444b           	addi.n	a4, a4, 4
  75:	738c           	beqz.n	a3, 80 <__do_global_dtors_aux+0x1c>
  77:	1249           	s32i.n	a4, a2, 4
  79:	0003e0        	callx8	a3
  7c:	fffbc6        	j	6f <__do_global_dtors_aux+0xb>

0000007f <__do_global_dtors_aux+0x1b>:
	...

00000080 <__do_global_dtors_aux+0x1c>:
  80:	ffe331        	l32r	a3, c (0 <_text_start>)
  83:	ffe3a1        	l32r	a10, 10 (3ec <__FRAME_END__>)
  86:	438c           	beqz.n	a3, 8e <__do_global_dtors_aux+0x2a>
  88:	ffe181        	l32r	a8, c (0 <_text_start>)
  8b:	0008e0        	callx8	a8
  8e:	130c           	movi.n	a3, 1
  90:	004232        	s8i	a3, a2, 0
  93:	f01d           	retw.n

00000095 <__do_global_dtors_aux+0x31>:
  95:	000000                                        ...

00000098 <frame_dummy>:
  98:	004136        	entry	a1, 32
  9b:	ffde21        	l32r	a2, 14 (0 <_text_start>)
  9e:	ffdca1        	l32r	a10, 10 (3ec <__FRAME_END__>)
  a1:	ffddb1        	l32r	a11, 18 (404 <frame_dummy.object>)
  a4:	428c           	beqz.n	a2, ac <frame_dummy+0x14>
  a6:	ffdb81        	l32r	a8, 14 (0 <_text_start>)
  a9:	0008e0        	callx8	a8

000000ac <frame_dummy+0x14>:
  ac:	f01d           	retw.n

000000ae <frame_dummy+0x16>:
	...

000000b0 <get_fir_wbeq_memsize>:
  b0:	004136        	entry	a1, 32
  b3:	70a122        	movi	a2, 0x170
  b6:	f01d           	retw.n

000000b8 <Voice_TxEQ_init>:
  b8:	004136        	entry	a1, 32
  bb:	baa062        	movi	a6, 186
  be:	b75c           	movi.n	a7, 91
  c0:	532b           	addi.n	a5, a3, 2
  c2:	326a           	add.n	a3, a2, a6
  c4:	040c           	movi.n	a4, 0
  c6:	206220        	or	a6, a2, a2
  c9:	0b8776        	loop	a7, d8 <Voice_TxEQ_init+0x20>
  cc:	257d           	ae_l16si.n	a7, a5, 0
  ce:	5d5642        	s16i	a4, a6, 186
  d1:	025672        	s16i	a7, a6, 4
  d4:	552b           	addi.n	a5, a5, 2
  d6:	662b           	addi.n	a6, a6, 2

000000d8 <Voice_TxEQ_init+0x20>:
  d8:	0239           	s32i.n	a3, a2, 0
  da:	f01d           	retw.n

000000dc <Voice_TxEQ_Prcs_Length>:
  dc:	004136        	entry	a1, 32
  df:	baa072        	movi	a7, 186
  e2:	737a           	add.n	a7, a3, a7
  e4:	70a182        	movi	a8, 0x170
  e7:	f3f670        	wur.ae_cbegin0	a7
  ea:	0378           	l32i.n	a7, a3, 0
  ec:	838a           	add.n	a8, a3, a8
  ee:	f3f780        	wur.ae_cend0	a8
  f1:	250c           	movi.n	a5, 2
  f3:	d62c           	movi.n	a6, 45
  f5:	fc248fe22e 	{ addi	a2, a2, -2; ae_zeroq56	aeq0 }
  fa:	834b           	addi.n	a8, a3, 4

000000fc <Voice_TxEQ_Prcs_Length+0x20>:
  fc:	409214        	ae_lp16f.iu	aep1, a2, 2
  ff:	fc24e2975f 	{ ae_sp16f.l.c	aep1, a7, a5; nop }
 104:	440314        	ae_lp16x2f.i	aep0, a3, 4
 107:	089d           	mov.n	a9, a8
 109:	fc24d9175f 	{ ae_lp16f.c	aep1, a7, a5; nop }
 10e:	0e8676        	loop	a6, 120 <Voice_TxEQ_Prcs_Length+0x44>
 111:	e22319275f 	{ ae_lp16f.c	aep2, a7, a5; ae_mulafp24s.hl	aeq0, aep0, aep1 }
 116:	e243ad891f 	{ ae_lp16x2f.iu	aep0, a9, 4; ae_mulafp24s.ll	aeq0, aep0, aep2 }
 11b:	fc24d9175f 	{ ae_lp16f.c	aep1, a7, a5; nop }

00000120 <Voice_TxEQ_Prcs_Length+0x44>:
 120:	e2230ff44e 	{ addi	a4, a4, -1; ae_mulafp24s.hl	aeq0, aep0, aep1 }
 125:	3600d4        	ae_sllisq56s	aeq0, aeq0, 3
 128:	1b8e74        	ae_roundsp16q48sym	aep7, aeq0
 12b:	fc24b2720f 	{ ae_sp16f.l.i	aep7, a2, 0; ae_zeroq56	aeq0 }
 130:	c814e6        	bgei	a4, 1, fc <Voice_TxEQ_Prcs_Length+0x20>
 133:	0379           	s32i.n	a7, a3, 0
 135:	f01d           	retw.n

00000137 <Voice_TxEQ_Prcs_Length+0x5b>:
	...

00000138 <Voice_TxEQ_Prcs>:
 138:	004136        	entry	a1, 32
 13b:	ffb841        	l32r	a4, 1c (dc <Voice_TxEQ_Prcs_Length>)
 13e:	f0a0c2        	movi	a12, 240
 141:	02ad           	mov.n	a10, a2
 143:	03bd           	mov.n	a11, a3
 145:	0004e0        	callx8	a4
 148:	f01d           	retw.n

0000014a <Voice_TxEQ_Prcs+0x12>:
	...

0000014c <_start>:
 14c:	004136        	entry	a1, 32
 14f:	ffb431        	l32r	a3, 20 (4a4 <printf_ptr>)
 152:	0228           	l32i.n	a2, a2, 0
 154:	ffb4a1        	l32r	a10, 24 (440 <export_parameter_array+0x10>)
 157:	ffb4b1        	l32r	a11, 28 (b0 <get_fir_wbeq_memsize>)
 15a:	0329           	s32i.n	a2, a3, 0
 15c:	0002e0        	callx8	a2
 15f:	0328           	l32i.n	a2, a3, 0
 161:	ffb2a1        	l32r	a10, 2c (45b <export_parameter_array+0x2b>)
 164:	ffb3b1        	l32r	a11, 30 (b8 <Voice_TxEQ_init>)
 167:	0002e0        	callx8	a2
 16a:	0328           	l32i.n	a2, a3, 0
 16c:	ffb2a1        	l32r	a10, 34 (471 <export_parameter_array+0x41>)
 16f:	ffb2b1        	l32r	a11, 38 (138 <Voice_TxEQ_Prcs>)
 172:	0002e0        	callx8	a2
 175:	0328           	l32i.n	a2, a3, 0
 177:	ffb1a1        	l32r	a10, 3c (487 <export_parameter_array+0x57>)
 17a:	ffa8b1        	l32r	a11, 1c (dc <Voice_TxEQ_Prcs_Length>)
 17d:	0002e0        	callx8	a2
 180:	ffb021        	l32r	a2, 40 (430 <export_parameter_array>)
 183:	f01d           	retw.n

00000185 <_start+0x39>:
 185:	000000                                        ...

00000188 <__do_global_ctors_aux>:
 188:	004136        	entry	a1, 32
 18b:	ffae31        	l32r	a3, 44 (3f4 <__CTOR_END__>)
 18e:	fcc322        	addi	a2, a3, -4
 191:	0228           	l32i.n	a2, a2, 0
 193:	f8c332        	addi	a3, a3, -8
 196:	0a0226        	beqi	a2, -1, 1a4 <__do_global_ctors_aux+0x1c>

00000199 <__do_global_ctors_aux+0x11>:
 199:	0002e0        	callx8	a2
 19c:	0328           	l32i.n	a2, a3, 0
 19e:	fcc332        	addi	a3, a3, -4
 1a1:	f40266        	bnei	a2, -1, 199 <__do_global_ctors_aux+0x11>
 1a4:	f01d           	retw.n

000001a6 <__do_global_ctors_aux+0x1e>:
	...

000001a8 <_fini>:
 1a8:	008136        	entry	a1, 64
 1ab:	ffa781        	l32r	a8, 48 (64 <__do_global_dtors_aux>)
 1ae:	f03d           	nop.n
 1b0:	0008e0        	callx8	a8

000001b3 <_fini+0xb>:
 1b3:	f01d           	retw.n
