
Build/lib/pisplit_ld_nr_1565_position_independent.splitload.lib:     file format elf32-xtensa-le


Disassembly of section .text:

00000000 <_init-0x1c8>:
       0:	0000021c 00002dd0 00006cc4 00003ed4     .....-...l...>..
      10:	00000000 00003eb8 00000000 00006cc8     .....>.......l..
      20:	00006ce0 000033c0 00000b60 000033d8     .l...3..`....3..
      30:	00001cd4 000033f0 00001ec8 00003408     .....3.......4..
      40:	00001dac 00003420 00000b58 00003ee0     .... 4..X....>..
      50:	7fffffff 80000000 000002c0 00003f00     .............?..
      60:	00007fff 00002df0 ffff7fff ffff8000     .....-..........
      70:	00003f70 00010000 00008000 0007ffff     p?..............
      80:	00001922 ffff54e0 000054e0 00000b1f     "....T...T......
      90:	00006488 00004001 0000c001 ffffc000     .d...@..........
      a0:	ffff4000 ffffb49b 00004000 0000ffff     .@.......@......
      b0:	ffff0000 00003440 00002e08 00268800     ....@4........&.
      c0:	40000000 00003f9e 00002c5d 00029973     ...@.?..],..s...
      d0:	00003fb0 22101401 00003788 00002370     .?.....".7..p#..
      e0:	00002388 6a4d3c26 000009e4 0000b4fa     .#..&<Mj........
      f0:	ffffb4fa ffffcb05 c0000000 00002258     ............X"..
     100:	000008b8 00006c60 ffffc400 00006c70     ....`l......pl..
     110:	00006a4d 00000e39 00006cb0 00006c90     Mj..9....l...l..
     120:	00000974 00800000 7fffff00 00000334     t...........4...
     130:	000047f0 00005370 000043fc 00001bc4     .G..pS...C......
     140:	00000fc8 00001580 00000b68 00004430     ........h...0D..
     150:	00001c2c 0000103c 000015b4 00000f70     ,...<.......p...
     160:	00001c54 00000b88 007d70a4 00003fd0     T........p}..?..
     170:	00002cd8 000034b0 000038b0 00005a82     .,...4...8...Z..
     180:	00003cac 00002634 00003cb0 000024a8     .<..4&...<...$..
     190:	00002430 00002654 00002858 00002884     0$..T&..X(...(..
     1a0:	000028b4 00002910 000028e4 00002958     .(...)...(..X)..
     1b0:	00002984 00002b98 00002c68 00003cc0     .)...+..h,...<..
     1c0:	00003ebc 000001e0                       .>......

000001c8 <_init>:
     1c8:	008136        	entry	a1, 64
     1cb:	ff8d81        	l32r	a8, 0 (21c <frame_dummy>)
     1ce:	f03d           	nop.n
     1d0:	0008e0        	callx8	a8
     1d3:	ff8c81        	l32r	a8, 4 (2dd0 <__do_global_ctors_aux>)
     1d6:	f03d           	nop.n
     1d8:	0008e0        	callx8	a8
     1db:	f01d           	retw.n

000001dd <_init+0x15>:
     1dd:	000000                                        ...

000001e0 <__do_global_dtors_aux>:
     1e0:	004136        	entry	a1, 32
     1e3:	ff8931        	l32r	a3, 8 (6cc4 <__bss_start>)
     1e6:	000382        	l8ui	a8, a3, 0
     1e9:	d8ec           	bnez.n	a8, 21a <__do_global_dtors_aux+0x3a>
     1eb:	ff8821        	l32r	a2, c (3ed4 <p$3519_6_1>)
     1ee:	02b8           	l32i.n	a11, a2, 0
     1f0:	0ba8           	l32i.n	a10, a11, 0
     1f2:	ca8c           	beqz.n	a10, 202 <__do_global_dtors_aux+0x22>

000001f4 <__do_global_dtors_aux+0x14>:
     1f4:	9b4b           	addi.n	a9, a11, 4
     1f6:	0299           	s32i.n	a9, a2, 0
     1f8:	000ae0        	callx8	a10
     1fb:	02b8           	l32i.n	a11, a2, 0
     1fd:	0ba8           	l32i.n	a10, a11, 0
     1ff:	ff1a56        	bnez	a10, 1f4 <__do_global_dtors_aux+0x14>

00000202 <__do_global_dtors_aux+0x22>:
     202:	ff83a1        	l32r	a10, 10 (0 <_text_start>)
     205:	0b0c           	movi.n	a11, 0
     207:	081ab7        	beq	a10, a11, 213 <__do_global_dtors_aux+0x33>
     20a:	ff82a1        	l32r	a10, 14 (3eb8 <__EH_FRAME_BEGIN___44>)
     20d:	ff8081        	l32r	a8, 10 (0 <_text_start>)
     210:	0008e0        	callx8	a8

00000213 <__do_global_dtors_aux+0x33>:
     213:	1c0c           	movi.n	a12, 1
     215:	0043c2        	s8i	a12, a3, 0
     218:	f01d           	retw.n

0000021a <__do_global_dtors_aux+0x3a>:
     21a:	f01d           	retw.n

0000021c <frame_dummy>:
     21c:	004136        	entry	a1, 32
     21f:	ff7e81        	l32r	a8, 18 (0 <_text_start>)
     222:	090c           	movi.n	a9, 0
     224:	0b1897        	beq	a8, a9, 233 <frame_dummy+0x17>
     227:	ff7ba1        	l32r	a10, 14 (3eb8 <__EH_FRAME_BEGIN___44>)
     22a:	ff7cb1        	l32r	a11, 1c (6cc8 <object$3538_8_1>)
     22d:	ff7a81        	l32r	a8, 18 (0 <_text_start>)
     230:	0008e0        	callx8	a8

00000233 <frame_dummy+0x17>:
     233:	f01d           	retw.n

00000235 <frame_dummy+0x19>:
     235:	000000                                        ...

00000238 <_start>:
     238:	004136        	entry	a1, 32
     23b:	ff7aa1        	l32r	a10, 24 (33c0 <_DYNAMIC+0x584>)
     23e:	ff7831        	l32r	a3, 20 (6ce0 <printf_ptr>)
     241:	0288           	l32i.n	a8, a2, 0
     243:	ff79b1        	l32r	a11, 28 (b60 <LD_NR_get_memsize>)
     246:	0389           	s32i.n	a8, a3, 0
     248:	0008e0        	callx8	a8
     24b:	0388           	l32i.n	a8, a3, 0
     24d:	ff77a1        	l32r	a10, 2c (33d8 <_DYNAMIC+0x59c>)
     250:	ff78b1        	l32r	a11, 30 (1cd4 <LD_NR_fir_init>)
     253:	0008e0        	callx8	a8
     256:	002382        	l32i	a8, a3, 0
     259:	ff76a1        	l32r	a10, 34 (33f0 <_DYNAMIC+0x5b4>)
     25c:	ff77b1        	l32r	a11, 38 (1ec8 <LD_NR_fir_proc1>)
     25f:	0008e0        	callx8	a8
     262:	0388           	l32i.n	a8, a3, 0
     264:	ff76a1        	l32r	a10, 3c (3408 <_DYNAMIC+0x5cc>)
     267:	ff76b1        	l32r	a11, 40 (1dac <LD_NR_fir_proc2>)
     26a:	0008e0        	callx8	a8
     26d:	0388           	l32i.n	a8, a3, 0
     26f:	ff75a1        	l32r	a10, 44 (3420 <_DYNAMIC+0x5e4>)
     272:	ff75b1        	l32r	a11, 48 (b58 <LD_NR_SVN_version>)
     275:	0008e0        	callx8	a8
     278:	ff7521        	l32r	a2, 4c (3ee0 <export_parameter_array>)
     27b:	f01d           	retw.n

0000027d <_start+0x45>:
     27d:	000000                                        ...

00000280 <_saturate32>:
     280:	004136        	entry	a1, 32
     283:	ff7371        	l32r	a7, 50 (7fffffff <_end+0x7fff931b>)
     286:	00a062        	movi	a6, 0
     289:	003396        	bltz	a3, 290 <_saturate32+0x10>
     28c:	a39c           	beqz.n	a3, 2aa <_saturate32+0x2a>

0000028e <_saturate32+0xe>:
     28e:	160c           	movi.n	a6, 1

00000290 <_saturate32+0x10>:
     290:	468c           	beqz.n	a6, 298 <_saturate32+0x18>
     292:	ff6f21        	l32r	a2, 50 (7fffffff <_end+0x7fff931b>)
     295:	f01d           	retw.n

00000297 <_saturate32+0x17>:
	...

00000298 <_saturate32+0x18>:
     298:	ff6e71        	l32r	a7, 50 (7fffffff <_end+0x7fff931b>)
     29b:	060c           	movi.n	a6, 0
     29d:	00f396        	bltz	a3, 2b0 <_saturate32+0x30>

000002a0 <_saturate32+0x20>:
     2a0:	ff6d31        	l32r	a3, 54 (80000000 <_end+0x7fff931c>)
     2a3:	833260        	moveqz	a3, a2, a6
     2a6:	032d           	mov.n	a2, a3
     2a8:	f01d           	retw.n

000002aa <_saturate32+0x2a>:
     2aa:	e2b727        	bgeu	a7, a2, 290 <_saturate32+0x10>
     2ad:	fff746        	j	28e <_saturate32+0xe>

000002b0 <_saturate32+0x30>:
     2b0:	040326        	beqi	a3, -1, 2b8 <_saturate32+0x38>

000002b3 <_saturate32+0x33>:
     2b3:	ff6821        	l32r	a2, 54 (80000000 <_end+0x7fff931c>)
     2b6:	f01d           	retw.n

000002b8 <_saturate32+0x38>:
     2b8:	e43727        	bltu	a7, a2, 2a0 <_saturate32+0x20>
     2bb:	fffd06        	j	2b3 <_saturate32+0x33>

000002be <_saturate32+0x3e>:
	...

000002c0 <derive_exp>:
     2c0:	004136        	entry	a1, 32
     2c3:	00a042        	movi	a4, 0
     2c6:	20a032        	movi	a3, 32
     2c9:	09a376        	loopgtz	a3, 2d6 <derive_exp+0x16>
     2cc:	06f2e7        	bbsi	a2, 30, 2d6 <derive_exp+0x16>
     2cf:	1122f0        	slli	a2, a2, 1
     2d2:	441b           	addi.n	a4, a4, 1
     2d4:	844d           	ae_sext16	a4, a4

000002d6 <derive_exp+0x16>:
     2d6:	042d           	mov.n	a2, a4
     2d8:	f01d           	retw.n

000002da <derive_exp+0x1a>:
	...

000002dc <HIFI_sqrt_ie>:
     2dc:	006136        	entry	a1, 48
     2df:	040c           	movi.n	a4, 0
     2e1:	0513e6        	bgei	a3, 1, 2ea <HIFI_sqrt_ie+0xe>
     2e4:	043d           	mov.n	a3, a4
     2e6:	042d           	mov.n	a2, a4
     2e8:	f01d           	retw.n

000002ea <HIFI_sqrt_ie+0xe>:
     2ea:	ff5b81        	l32r	a8, 58 (2c0 <derive_exp>)
     2ed:	03ad           	mov.n	a10, a3
     2ef:	0008e0        	callx8	a8
     2f2:	ff5ab1        	l32r	a11, 5c (3f00 <TABLE_IE>)
     2f5:	c022a0        	sub	a2, a2, a10
     2f8:	401a00        	ssl	a10
     2fb:	a19300        	sll	a9, a3
     2fe:	04a020        	extui	a10, a2, 0, 1
     301:	400a00        	ssr	a10
     304:	22aa           	add.n	a2, a2, a10
     306:	b19090        	sra	a9, a9
     309:	418990        	srli	a8, a9, 9
     30c:	318080        	srai	a8, a8, 16
     30f:	f0c882        	addi	a8, a8, -16
     312:	538480        	max	a8, a4, a8
     315:	9088b0        	addx2	a8, a8, a11
     318:	283d           	ae_l16si.n	a3, a8, 0
     31a:	388d           	ae_l16si.n	a8, a8, 2
     31c:	212120        	srai	a2, a2, 1
     31f:	f49990        	extui	a9, a9, 9, 16
     322:	c08830        	sub	a8, a8, a3
     325:	888d           	ae_sext16	a8, a8
     327:	828890        	mull	a8, a8, a9
     32a:	113300        	slli	a3, a3, 16
     32d:	338a           	add.n	a3, a3, a8
     32f:	f01d           	retw.n

00000331 <HIFI_sqrt_ie+0x55>:
     331:	000000                                        ...

00000334 <fxdiv32>:
     334:	004136        	entry	a1, 32
     337:	086316        	beqz	a3, 3c1 <fxdiv32+0x8d>
     33a:	042237        	blt	a2, a3, 342 <fxdiv32+0xe>
     33d:	ff4821        	l32r	a2, 60 (7fff <_end+0x131b>)
     340:	f01d           	retw.n

00000342 <fxdiv32+0xe>:
     342:	ff4581        	l32r	a8, 58 (2c0 <derive_exp>)
     345:	03ad           	mov.n	a10, a3
     347:	0008e0        	callx8	a8
     34a:	0a4d           	mov.n	a4, a10
     34c:	060c           	movi.n	a6, 0
     34e:	f77c           	movi.n	a7, -1
     350:	ff4051        	l32r	a5, 50 (7fffffff <_end+0x7fff931b>)
     353:	1f1aa6        	blti	a10, 1, 376 <fxdiv32+0x42>
     356:	0acd           	mov.n	a12, a10
     358:	ff4381        	l32r	a8, 64 (2df0 <__ashldi3>)
     35b:	31bf20        	srai	a11, a2, 31
     35e:	02ad           	mov.n	a10, a2
     360:	0008e0        	callx8	a8
     363:	0c0c           	movi.n	a12, 0
     365:	072b67        	blt	a11, a6, 370 <fxdiv32+0x3c>
     368:	c09b60        	sub	a9, a11, a6
     36b:	07d916        	beqz	a9, 3ec <fxdiv32+0xb8>

0000036e <fxdiv32+0x3a>:
     36e:	1c0c           	movi.n	a12, 1

00000370 <fxdiv32+0x3c>:
     370:	052c16        	beqz	a12, 3c6 <fxdiv32+0x92>
     373:	ff3721        	l32r	a2, 50 (7fffffff <_end+0x7fff931b>)

00000376 <fxdiv32+0x42>:
     376:	f1c4c2        	addi	a12, a4, -15
     379:	8ccd           	ae_sext16	a12, a12
     37b:	1d1ca6        	blti	a12, 1, 39c <fxdiv32+0x68>
     37e:	ff3981        	l32r	a8, 64 (2df0 <__ashldi3>)
     381:	03ad           	mov.n	a10, a3
     383:	31bf30        	srai	a11, a3, 31
     386:	0008e0        	callx8	a8
     389:	0c0c           	movi.n	a12, 0
     38b:	042b67        	blt	a11, a6, 393 <fxdiv32+0x5f>
     38e:	601b67        	beq	a11, a6, 3f2 <fxdiv32+0xbe>

00000391 <fxdiv32+0x5d>:
     391:	1c0c           	movi.n	a12, 1

00000393 <fxdiv32+0x5f>:
     393:	042c16        	beqz	a12, 3d9 <fxdiv32+0xa5>
     396:	ff2e31        	l32r	a3, 50 (7fffffff <_end+0x7fff931b>)
     399:	000206        	j	3a5 <fxdiv32+0x71>

0000039c <fxdiv32+0x68>:
     39c:	6091c0        	abs	a9, a12
     39f:	400900        	ssr	a9
     3a2:	b13030        	sra	a3, a3

000003a5 <fxdiv32+0x71>:
     3a5:	ff2eb1        	l32r	a11, 60 (7fff <_end+0x131b>)
     3a8:	d2a230        	quos	a10, a2, a3
     3ab:	03aba7        	bge	a11, a10, 3b2 <fxdiv32+0x7e>
     3ae:	0b2d           	mov.n	a2, a11
     3b0:	f01d           	retw.n

000003b2 <fxdiv32+0x7e>:
     3b2:	ff2db1        	l32r	a11, 68 (ffff7fff <_end+0xffff131b>)
     3b5:	ff2d21        	l32r	a2, 6c (ffff8000 <_end+0xffff131c>)
     3b8:	012ba7        	blt	a11, a10, 3bd <fxdiv32+0x89>
     3bb:	f01d           	retw.n

000003bd <fxdiv32+0x89>:
     3bd:	8a2d           	ae_sext16	a2, a10
     3bf:	f01d           	retw.n

000003c1 <fxdiv32+0x8d>:
     3c1:	020c           	movi.n	a2, 0
     3c3:	f01d           	retw.n

000003c5 <fxdiv32+0x91>:
	...

000003c6 <fxdiv32+0x92>:
     3c6:	0c0c           	movi.n	a12, 0
     3c8:	0427b7        	blt	a7, a11, 3d0 <fxdiv32+0x9c>
     3cb:	291b77        	beq	a11, a7, 3f8 <fxdiv32+0xc4>

000003ce <fxdiv32+0x9a>:
     3ce:	1c0c           	movi.n	a12, 1

000003d0 <fxdiv32+0x9c>:
     3d0:	ff2121        	l32r	a2, 54 (80000000 <_end+0x7fff931c>)
     3d3:	832ac0        	moveqz	a2, a10, a12
     3d6:	ffe706        	j	376 <fxdiv32+0x42>

000003d9 <fxdiv32+0xa5>:
     3d9:	0c0c           	movi.n	a12, 0
     3db:	0427b7        	blt	a7, a11, 3e3 <fxdiv32+0xaf>
     3de:	1e1b77        	beq	a11, a7, 400 <fxdiv32+0xcc>

000003e1 <fxdiv32+0xad>:
     3e1:	1c0c           	movi.n	a12, 1

000003e3 <fxdiv32+0xaf>:
     3e3:	ff1c31        	l32r	a3, 54 (80000000 <_end+0x7fff931c>)
     3e6:	833ac0        	moveqz	a3, a10, a12
     3e9:	ffee06        	j	3a5 <fxdiv32+0x71>

000003ec <fxdiv32+0xb8>:
     3ec:	80b5a7        	bgeu	a5, a10, 370 <fxdiv32+0x3c>
     3ef:	ffdec6        	j	36e <fxdiv32+0x3a>

000003f2 <fxdiv32+0xbe>:
     3f2:	9db5a7        	bgeu	a5, a10, 393 <fxdiv32+0x5f>
     3f5:	ffe606        	j	391 <fxdiv32+0x5d>

000003f8 <fxdiv32+0xc4>:
     3f8:	d435a7        	bltu	a5, a10, 3d0 <fxdiv32+0x9c>
     3fb:	fff3c6        	j	3ce <fxdiv32+0x9a>

000003fe <fxdiv32+0xca>:
	...

00000400 <fxdiv32+0xcc>:
     400:	df35a7        	bltu	a5, a10, 3e3 <fxdiv32+0xaf>
     403:	fff686        	j	3e1 <fxdiv32+0xad>

00000406 <fxdiv32+0xd2>:
	...

00000408 <fxexp>:
     408:	004136        	entry	a1, 32
     40b:	ff1941        	l32r	a4, 70 (3f70 <K_VAL>)
     40e:	04c8           	l32i.n	a12, a4, 0
     410:	313f20        	srai	a3, a2, 31
     413:	ac2a           	add.n	a10, a12, a2
     415:	62bac0        	saltu	a11, a10, a12
     418:	31cfc0        	srai	a12, a12, 31
     41b:	cc3a           	add.n	a12, a12, a3
     41d:	80bbc0        	add	a11, a11, a12
     420:	ffe5e5        	call8	280 <_saturate32>
     423:	021ae6        	bgei	a10, 1, 429 <fxexp+0x21>
     426:	0056c6        	j	585 <fxexp+0x17d>
     429:	ff0951        	l32r	a5, 50 (7fffffff <_end+0x7fff931b>)

0000042c <fxexp+0x24>:
     42c:	14c8           	l32i.n	a12, a4, 4
     42e:	a2ca           	add.n	a10, a2, a12
     430:	62ba20        	saltu	a11, a10, a2
     433:	31cfc0        	srai	a12, a12, 31
     436:	c3ca           	add.n	a12, a3, a12
     438:	bbca           	add.n	a11, a11, a12
     43a:	ffe465        	call8	280 <_saturate32>
     43d:	021ae6        	bgei	a10, 1, 443 <fxexp+0x3b>
     440:	005306        	j	590 <fxexp+0x188>

00000443 <fxexp+0x3b>:
     443:	24c8           	l32i.n	a12, a4, 8
     445:	a2ca           	add.n	a10, a2, a12
     447:	62ba20        	saltu	a11, a10, a2
     44a:	31cfc0        	srai	a12, a12, 31
     44d:	c3ca           	add.n	a12, a3, a12
     44f:	bbca           	add.n	a11, a11, a12
     451:	ffe2e5        	call8	280 <_saturate32>
     454:	021ae6        	bgei	a10, 1, 45a <fxexp+0x52>
     457:	005006        	j	59b <fxexp+0x193>

0000045a <fxexp+0x52>:
     45a:	34c8           	l32i.n	a12, a4, 12
     45c:	a2ca           	add.n	a10, a2, a12
     45e:	62ba20        	saltu	a11, a10, a2
     461:	31cfc0        	srai	a12, a12, 31
     464:	c3ca           	add.n	a12, a3, a12
     466:	bbca           	add.n	a11, a11, a12
     468:	ffe165        	call8	280 <_saturate32>
     46b:	021ae6        	bgei	a10, 1, 471 <fxexp+0x69>
     46e:	004d86        	j	5a8 <fxexp+0x1a0>

00000471 <fxexp+0x69>:
     471:	44c8           	l32i.n	a12, a4, 16
     473:	a2ca           	add.n	a10, a2, a12
     475:	62ba20        	saltu	a11, a10, a2
     478:	31cfc0        	srai	a12, a12, 31
     47b:	c3ca           	add.n	a12, a3, a12
     47d:	bbca           	add.n	a11, a11, a12
     47f:	ffe025        	call8	280 <_saturate32>
     482:	021ae6        	bgei	a10, 1, 488 <fxexp+0x80>
     485:	004a86        	j	5b3 <fxexp+0x1ab>

00000488 <fxexp+0x80>:
     488:	54c8           	l32i.n	a12, a4, 20
     48a:	a2ca           	add.n	a10, a2, a12
     48c:	62ba20        	saltu	a11, a10, a2
     48f:	31cfc0        	srai	a12, a12, 31
     492:	c3ca           	add.n	a12, a3, a12
     494:	bbca           	add.n	a11, a11, a12
     496:	ffdea5        	call8	280 <_saturate32>
     499:	0a6d           	mov.n	a6, a10
     49b:	021ae6        	bgei	a10, 1, 4a1 <fxexp+0x99>
     49e:	004786        	j	5c0 <fxexp+0x1b8>

000004a1 <fxexp+0x99>:
     4a1:	64c8           	l32i.n	a12, a4, 24
     4a3:	a2ca           	add.n	a10, a2, a12
     4a5:	62ba20        	saltu	a11, a10, a2
     4a8:	31cfc0        	srai	a12, a12, 31
     4ab:	c3ca           	add.n	a12, a3, a12
     4ad:	bbca           	add.n	a11, a11, a12
     4af:	ffdd25        	call8	280 <_saturate32>
     4b2:	0a6d           	mov.n	a6, a10
     4b4:	021ae6        	bgei	a10, 1, 4ba <fxexp+0xb2>
     4b7:	0049c6        	j	5e2 <fxexp+0x1da>

000004ba <fxexp+0xb2>:
     4ba:	74c8           	l32i.n	a12, a4, 28
     4bc:	a2ca           	add.n	a10, a2, a12
     4be:	62ba20        	saltu	a11, a10, a2
     4c1:	31cfc0        	srai	a12, a12, 31
     4c4:	c3ca           	add.n	a12, a3, a12
     4c6:	bbca           	add.n	a11, a11, a12
     4c8:	ffdb65        	call8	280 <_saturate32>
     4cb:	0a6d           	mov.n	a6, a10
     4cd:	021ae6        	bgei	a10, 1, 4d3 <fxexp+0xcb>
     4d0:	004c06        	j	604 <fxexp+0x1fc>

000004d3 <fxexp+0xcb>:
     4d3:	84c8           	l32i.n	a12, a4, 32
     4d5:	a2ca           	add.n	a10, a2, a12
     4d7:	62ba20        	saltu	a11, a10, a2
     4da:	31cfc0        	srai	a12, a12, 31
     4dd:	c3ca           	add.n	a12, a3, a12
     4df:	bbca           	add.n	a11, a11, a12
     4e1:	ffd9e5        	call8	280 <_saturate32>
     4e4:	0a6d           	mov.n	a6, a10
     4e6:	021ae6        	bgei	a10, 1, 4ec <fxexp+0xe4>
     4e9:	004ec6        	j	628 <fxexp+0x220>

000004ec <fxexp+0xe4>:
     4ec:	94c8           	l32i.n	a12, a4, 36
     4ee:	a2ca           	add.n	a10, a2, a12
     4f0:	62ba20        	saltu	a11, a10, a2
     4f3:	31cfc0        	srai	a12, a12, 31
     4f6:	c3ca           	add.n	a12, a3, a12
     4f8:	bbca           	add.n	a11, a11, a12
     4fa:	ffd865        	call8	280 <_saturate32>
     4fd:	0a6d           	mov.n	a6, a10
     4ff:	021ae6        	bgei	a10, 1, 505 <fxexp+0xfd>
     502:	005106        	j	64a <fxexp+0x242>

00000505 <fxexp+0xfd>:
     505:	a4c8           	l32i.n	a12, a4, 40
     507:	a2ca           	add.n	a10, a2, a12
     509:	62ba20        	saltu	a11, a10, a2
     50c:	31cfc0        	srai	a12, a12, 31
     50f:	c3ca           	add.n	a12, a3, a12
     511:	bbca           	add.n	a11, a11, a12
     513:	ffd6e5        	call8	280 <_saturate32>
     516:	0a6d           	mov.n	a6, a10
     518:	021ae6        	bgei	a10, 1, 51e <fxexp+0x116>
     51b:	005346        	j	66c <fxexp+0x264>

0000051e <fxexp+0x116>:
     51e:	b4c8           	l32i.n	a12, a4, 44
     520:	a2ca           	add.n	a10, a2, a12
     522:	62ba20        	saltu	a11, a10, a2
     525:	31cfc0        	srai	a12, a12, 31
     528:	c3ca           	add.n	a12, a3, a12
     52a:	80bbc0        	add	a11, a11, a12
     52d:	ffd525        	call8	280 <_saturate32>
     530:	0a4d           	mov.n	a4, a10
     532:	021ae6        	bgei	a10, 1, 538 <fxexp+0x130>
     535:	0055c6        	j	690 <fxexp+0x288>

00000538 <fxexp+0x130>:
     538:	fecfa1        	l32r	a10, 74 (10000 <_end+0x931c>)
     53b:	a2aa           	add.n	a10, a2, a10
     53d:	62ba20        	saltu	a11, a10, a2
     540:	bb3a           	add.n	a11, a11, a3
     542:	ffd3e5        	call8	280 <_saturate32>
     545:	0abd           	mov.n	a11, a10
     547:	11aa20        	slli	a10, a10, 14
     54a:	31b2b0        	srai	a11, a11, 18
     54d:	ffd325        	call8	280 <_saturate32>
     550:	21c8a0        	srai	a12, a10, 8
     553:	404700        	ssai	7
     556:	82b5c0        	mull	a11, a5, a12
     559:	b2c5c0        	mulsh	a12, a5, a12
     55c:	fec7a1        	l32r	a10, 78 (8000 <_end+0x131c>)
     55f:	81bcb0        	src	a11, a12, a11
     562:	404010        	ssai	16
     565:	abaa           	add.n	a10, a11, a10
     567:	21c7c0        	srai	a12, a12, 7
     56a:	62bab0        	saltu	a11, a10, a11
     56d:	bbca           	add.n	a11, a11, a12
     56f:	81aba0        	src	a10, a11, a10
     572:	31b0b0        	srai	a11, a11, 16
     575:	ffd0a5        	call8	280 <_saturate32>
     578:	31bfa0        	srai	a11, a10, 31
     57b:	11aaf0        	slli	a10, a10, 1
     57e:	ffd025        	call8	280 <_saturate32>
     581:	0a2d           	mov.n	a2, a10
     583:	f01d           	retw.n

00000585 <fxexp+0x17d>:
     585:	0a2d           	mov.n	a2, a10
     587:	313fa0        	srai	a3, a10, 31
     58a:	febc51        	l32r	a5, 7c (7ffff <_end+0x7931b>)
     58d:	ffa6c6        	j	42c <fxexp+0x24>

00000590 <fxexp+0x188>:
     590:	215850        	srai	a5, a5, 8
     593:	0a2d           	mov.n	a2, a10
     595:	313fa0        	srai	a3, a10, 31
     598:	ffa9c6        	j	443 <fxexp+0x3b>

0000059b <fxexp+0x193>:
     59b:	215450        	srai	a5, a5, 4
     59e:	0a2d           	mov.n	a2, a10
     5a0:	313fa0        	srai	a3, a10, 31
     5a3:	ffacc6        	j	45a <fxexp+0x52>

000005a6 <fxexp+0x19e>:
	...

000005a8 <fxexp+0x1a0>:
     5a8:	215250        	srai	a5, a5, 2
     5ab:	0a2d           	mov.n	a2, a10
     5ad:	313fa0        	srai	a3, a10, 31
     5b0:	ffaf46        	j	471 <fxexp+0x69>

000005b3 <fxexp+0x1ab>:
     5b3:	215150        	srai	a5, a5, 1
     5b6:	0a2d           	mov.n	a2, a10
     5b8:	313fa0        	srai	a3, a10, 31
     5bb:	ffb246        	j	488 <fxexp+0x80>

000005be <fxexp+0x1b6>:
	...

000005c0 <fxexp+0x1b8>:
     5c0:	31bf50        	srai	a11, a5, 31
     5c3:	21d250        	srai	a13, a5, 2
     5c6:	c0a5d0        	sub	a10, a5, a13
     5c9:	62c5a0        	saltu	a12, a5, a10
     5cc:	31dfd0        	srai	a13, a13, 31
     5cf:	c0bbd0        	sub	a11, a11, a13
     5d2:	c0bbc0        	sub	a11, a11, a12
     5d5:	ffcaa5        	call8	280 <_saturate32>
     5d8:	0a5d           	mov.n	a5, a10
     5da:	062d           	mov.n	a2, a6
     5dc:	313f60        	srai	a3, a6, 31
     5df:	ffaf86        	j	4a1 <fxexp+0x99>

000005e2 <fxexp+0x1da>:
     5e2:	31bf50        	srai	a11, a5, 31
     5e5:	21d350        	srai	a13, a5, 3
     5e8:	c0a5d0        	sub	a10, a5, a13
     5eb:	62c5a0        	saltu	a12, a5, a10
     5ee:	31dfd0        	srai	a13, a13, 31
     5f1:	c0bbd0        	sub	a11, a11, a13
     5f4:	c0bbc0        	sub	a11, a11, a12
     5f7:	ffc8a5        	call8	280 <_saturate32>
     5fa:	0a5d           	mov.n	a5, a10
     5fc:	062d           	mov.n	a2, a6
     5fe:	313f60        	srai	a3, a6, 31
     601:	ffad46        	j	4ba <fxexp+0xb2>

00000604 <fxexp+0x1fc>:
     604:	31bf50        	srai	a11, a5, 31
     607:	21d450        	srai	a13, a5, 4
     60a:	c0a5d0        	sub	a10, a5, a13
     60d:	62c5a0        	saltu	a12, a5, a10
     610:	31dfd0        	srai	a13, a13, 31
     613:	c0bbd0        	sub	a11, a11, a13
     616:	c0bbc0        	sub	a11, a11, a12
     619:	ffc665        	call8	280 <_saturate32>
     61c:	0a5d           	mov.n	a5, a10
     61e:	062d           	mov.n	a2, a6
     620:	313f60        	srai	a3, a6, 31
     623:	ffab06        	j	4d3 <fxexp+0xcb>

00000626 <fxexp+0x21e>:
	...

00000628 <fxexp+0x220>:
     628:	31bf50        	srai	a11, a5, 31
     62b:	21d550        	srai	a13, a5, 5
     62e:	c0a5d0        	sub	a10, a5, a13
     631:	62c5a0        	saltu	a12, a5, a10
     634:	31dfd0        	srai	a13, a13, 31
     637:	c0bbd0        	sub	a11, a11, a13
     63a:	c0bbc0        	sub	a11, a11, a12
     63d:	ffc425        	call8	280 <_saturate32>
     640:	0a5d           	mov.n	a5, a10
     642:	062d           	mov.n	a2, a6
     644:	313f60        	srai	a3, a6, 31
     647:	ffa846        	j	4ec <fxexp+0xe4>

0000064a <fxexp+0x242>:
     64a:	31bf50        	srai	a11, a5, 31
     64d:	21d650        	srai	a13, a5, 6
     650:	c0a5d0        	sub	a10, a5, a13
     653:	62c5a0        	saltu	a12, a5, a10
     656:	31dfd0        	srai	a13, a13, 31
     659:	c0bbd0        	sub	a11, a11, a13
     65c:	c0bbc0        	sub	a11, a11, a12
     65f:	ffc225        	call8	280 <_saturate32>
     662:	0a5d           	mov.n	a5, a10
     664:	062d           	mov.n	a2, a6
     666:	313f60        	srai	a3, a6, 31
     669:	ffa606        	j	505 <fxexp+0xfd>

0000066c <fxexp+0x264>:
     66c:	31bf50        	srai	a11, a5, 31
     66f:	21d750        	srai	a13, a5, 7
     672:	c0a5d0        	sub	a10, a5, a13
     675:	62c5a0        	saltu	a12, a5, a10
     678:	31dfd0        	srai	a13, a13, 31
     67b:	c0bbd0        	sub	a11, a11, a13
     67e:	c0bbc0        	sub	a11, a11, a12
     681:	ffbfe5        	call8	280 <_saturate32>
     684:	0a5d           	mov.n	a5, a10
     686:	062d           	mov.n	a2, a6
     688:	313f60        	srai	a3, a6, 31
     68b:	ffa3c6        	j	51e <fxexp+0x116>

0000068e <fxexp+0x286>:
	...

00000690 <fxexp+0x288>:
     690:	31bf50        	srai	a11, a5, 31
     693:	21d850        	srai	a13, a5, 8
     696:	c0a5d0        	sub	a10, a5, a13
     699:	62c5a0        	saltu	a12, a5, a10
     69c:	31dfd0        	srai	a13, a13, 31
     69f:	c0bbd0        	sub	a11, a11, a13
     6a2:	c0bbc0        	sub	a11, a11, a12
     6a5:	ffbda5        	call8	280 <_saturate32>
     6a8:	0a5d           	mov.n	a5, a10
     6aa:	042d           	mov.n	a2, a4
     6ac:	313f40        	srai	a3, a4, 31
     6af:	ffa146        	j	538 <fxexp+0x130>

000006b2 <fxexp+0x2aa>:
	...

000006b4 <fxarctan2>:
     6b4:	004136        	entry	a1, 32
     6b7:	0a9237        	bne	a2, a3, 6c5 <fxarctan2+0x11>
     6ba:	0212e6        	bgei	a2, 1, 6c0 <fxarctan2+0xc>
     6bd:	003846        	j	7a2 <fxarctan2+0xee>
     6c0:	fe7021        	l32r	a2, 80 (1922 <fn_calc_sup_gain+0x36e>)
     6c3:	f01d           	retw.n

000006c5 <fxarctan2+0x11>:
     6c5:	fe7071        	l32r	a7, 88 (54e0 <idct64+0xcf0>)
     6c8:	fe6c61        	l32r	a6, 78 (8000 <_end+0x131c>)
     6cb:	fe6e91        	l32r	a9, 84 (ffff54e0 <_end+0xfffee7fc>)
     6ce:	605120        	abs	a5, a2
     6d1:	604130        	abs	a4, a3
     6d4:	604040        	neg	a4, a4
     6d7:	605050        	neg	a5, a5
     6da:	855d           	ae_sext16	a5, a5
     6dc:	844d           	ae_sext16	a4, a4
     6de:	4ea457        	bge	a4, a5, 730 <fxarctan2+0x7c>
     6e1:	fe6ac1        	l32r	a12, 8c (b1f <_saturate32+0x3>)
     6e4:	118210        	slli	a8, a2, 15
     6e7:	d28830        	quos	a8, a8, a3
     6ea:	888d           	ae_sext16	a8, a8
     6ec:	60b180        	abs	a11, a8
     6ef:	60b0b0        	neg	a11, a11
     6f2:	d1bbc0        	mul16s	a11, a11, a12
     6f5:	fe5a51        	l32r	a5, 60 (7fff <_end+0x131b>)
     6f8:	11bbf0        	slli	a11, a11, 1
     6fb:	bb6a           	add.n	a11, a11, a6
     6fd:	31b0b0        	srai	a11, a11, 16
     700:	0227b7        	blt	a7, a11, 706 <fxarctan2+0x52>
     703:	002a46        	j	7b0 <fxarctan2+0xfc>

00000706 <fxarctan2+0x52>:
     706:	d18580        	mul16s	a8, a5, a8
     709:	908860        	addx2	a8, a8, a6
     70c:	318080        	srai	a8, a8, 16
     70f:	087d           	mov.n	a7, a8
     711:	07f3d6        	bgez	a3, 794 <fxarctan2+0xe0>
     714:	135296        	bltz	a2, 84d <fxarctan2+0x199>
     717:	fe5e41        	l32r	a4, 90 (6488 <idct64+0x1c98>)
     71a:	0218e6        	bgei	a8, 1, 720 <fxarctan2+0x6c>
     71d:	005706        	j	87d <fxarctan2+0x1c9>
     720:	fe5021        	l32r	a2, 60 (7fff <_end+0x131b>)

00000723 <fxarctan2+0x6f>:
     723:	d12240        	mul16s	a2, a2, a4
     726:	902260        	addx2	a2, a2, a6
     729:	312020        	srai	a2, a2, 16
     72c:	f01d           	retw.n

0000072e <fxarctan2+0x7a>:
	...

00000730 <fxarctan2+0x7c>:
     730:	fe59c1        	l32r	a12, 94 (4001 <LD_NR_fftorder_512+0x31>)
     733:	fe56d1        	l32r	a13, 8c (b1f <_saturate32+0x3>)
     736:	11b310        	slli	a11, a3, 15
     739:	d2bb20        	quos	a11, a11, a2
     73c:	8b3d           	ae_sext16	a3, a11
     73e:	60a130        	abs	a10, a3
     741:	60a0a0        	neg	a10, a10
     744:	d1aad0        	mul16s	a10, a10, a13
     747:	fe54d1        	l32r	a13, 98 (c001 <_end+0x531d>)
     74a:	11aaf0        	slli	a10, a10, 1
     74d:	aa6a           	add.n	a10, a10, a6
     74f:	31a0a0        	srai	a10, a10, 16
     752:	63a7a7        	bge	a7, a10, 7b9 <fxarctan2+0x105>
     755:	117310        	slli	a7, a3, 15
     758:	c07730        	sub	a7, a7, a3
     75b:	1177f0        	slli	a7, a7, 1
     75e:	776a           	add.n	a7, a7, a6
     760:	317070        	srai	a7, a7, 16
     763:	0c9296        	bltz	a2, 830 <fxarctan2+0x17c>
     766:	fe4d81        	l32r	a8, 9c (ffffc000 <_end+0xffff531c>)
     769:	022877        	blt	a8, a7, 76f <fxarctan2+0xbb>
     76c:	0020c6        	j	7f3 <fxarctan2+0x13f>
     76f:	02a7d7        	bge	a7, a13, 775 <fxarctan2+0xc1>
     772:	002686        	j	810 <fxarctan2+0x15c>

00000775 <fxarctan2+0xc1>:
     775:	fe4641        	l32r	a4, 90 (6488 <idct64+0x1c98>)
     778:	fe3d21        	l32r	a2, 6c (ffff8000 <_end+0xffff131c>)
     77b:	d12240        	mul16s	a2, a2, a4
     77e:	902260        	addx2	a2, a2, a6
     781:	312020        	srai	a2, a2, 16
     784:	f01d           	retw.n

00000786 <fxarctan2+0xd2>:
	...

00000788 <fxarctan2+0xd4>:
     788:	fe4691        	l32r	a9, a0 (ffff4000 <_end+0xfffed31c>)
     78b:	02a937        	bge	a9, a3, 791 <fxarctan2+0xdd>
     78e:	004786        	j	8b0 <fxarctan2+0x1fc>

00000791 <fxarctan2+0xdd>:
     791:	fe3371        	l32r	a7, 60 (7fff <_end+0x131b>)

00000794 <fxarctan2+0xe0>:
     794:	fe3f21        	l32r	a2, 90 (6488 <idct64+0x1c98>)
     797:	d12720        	mul16s	a2, a7, a2
     79a:	902260        	addx2	a2, a2, a6
     79d:	312020        	srai	a2, a2, 16
     7a0:	f01d           	retw.n

000007a2 <fxarctan2+0xee>:
     7a2:	fe4031        	l32r	a3, a4 (ffffb49b <_end+0xffff47b7>)
     7a5:	040c           	movi.n	a4, 0
     7a7:	b33420        	movgez	a3, a4, a2
     7aa:	032d           	mov.n	a2, a3
     7ac:	f01d           	retw.n

000007ae <fxarctan2+0xfa>:
	...

000007b0 <fxarctan2+0xfc>:
     7b0:	5029b7        	blt	a9, a11, 804 <fxarctan2+0x150>
     7b3:	fe2e51        	l32r	a5, 6c (ffff8000 <_end+0xffff131c>)
     7b6:	ffd306        	j	706 <fxarctan2+0x52>

000007b9 <fxarctan2+0x105>:
     7b9:	1c29a7        	blt	a9, a10, 7d9 <fxarctan2+0x125>
     7bc:	113310        	slli	a3, a3, 15
     7bf:	603030        	neg	a3, a3
     7c2:	1133f0        	slli	a3, a3, 1
     7c5:	336a           	add.n	a3, a3, a6
     7c7:	313030        	srai	a3, a3, 16
     7ca:	0bb296        	bltz	a2, 889 <fxarctan2+0x1d5>
     7cd:	fe3341        	l32r	a4, 9c (ffffc000 <_end+0xffff531c>)
     7d0:	1fa437        	bge	a4, a3, 7f3 <fxarctan2+0x13f>
     7d3:	9ea3d7        	bge	a3, a13, 775 <fxarctan2+0xc1>
     7d6:	000e06        	j	812 <fxarctan2+0x15e>

000007d9 <fxarctan2+0x125>:
     7d9:	2bda32        	addmi	a3, a10, 0x2b00
     7dc:	1fc332        	addi	a3, a3, 31
     7df:	d133b0        	mul16s	a3, a3, a11
     7e2:	1133f0        	slli	a3, a3, 1
     7e5:	336a           	add.n	a3, a3, a6
     7e7:	313030        	srai	a3, a3, 16
     7ea:	f9a296        	bltz	a2, 788 <fxarctan2+0xd4>
     7ed:	fe2b41        	l32r	a4, 9c (ffffc000 <_end+0xffff531c>)
     7f0:	342437        	blt	a4, a3, 828 <fxarctan2+0x174>

000007f3 <fxarctan2+0x13f>:
     7f3:	fe2741        	l32r	a4, 90 (6488 <idct64+0x1c98>)
     7f6:	fe1a21        	l32r	a2, 60 (7fff <_end+0x131b>)
     7f9:	d12240        	mul16s	a2, a2, a4
     7fc:	902260        	addx2	a2, a2, a6
     7ff:	312020        	srai	a2, a2, 16
     802:	f01d           	retw.n

00000804 <fxarctan2+0x150>:
     804:	2bdb52        	addmi	a5, a11, 0x2b00
     807:	1fc552        	addi	a5, a5, 31
     80a:	855d           	ae_sext16	a5, a5
     80c:	ffbd86        	j	706 <fxarctan2+0x52>

0000080f <fxarctan2+0x15b>:
	...

00000810 <fxarctan2+0x15c>:
     810:	073d           	mov.n	a3, a7

00000812 <fxarctan2+0x15e>:
     812:	fe2521        	l32r	a2, a8 (4000 <LD_NR_fftorder_512+0x30>)
     815:	fe1e41        	l32r	a4, 90 (6488 <idct64+0x1c98>)
     818:	c02230        	sub	a2, a2, a3
     81b:	822d           	ae_sext16	a2, a2
     81d:	d12240        	mul16s	a2, a2, a4
     820:	902260        	addx2	a2, a2, a6
     823:	312020        	srai	a2, a2, 16
     826:	f01d           	retw.n

00000828 <fxarctan2+0x174>:
     828:	e623d7        	blt	a3, a13, 812 <fxarctan2+0x15e>
     82b:	ffd186        	j	775 <fxarctan2+0xc1>

0000082e <fxarctan2+0x17a>:
	...

00000830 <fxarctan2+0x17c>:
     830:	fe1c41        	l32r	a4, a0 (ffff4000 <_end+0xfffed31c>)
     833:	022477        	blt	a4, a7, 839 <fxarctan2+0x185>
     836:	ffd5c6        	j	791 <fxarctan2+0xdd>
     839:	5b27c7        	blt	a7, a12, 898 <fxarctan2+0x1e4>

0000083c <fxarctan2+0x188>:
     83c:	fe1521        	l32r	a2, 90 (6488 <idct64+0x1c98>)
     83f:	fe0b71        	l32r	a7, 6c (ffff8000 <_end+0xffff131c>)
     842:	d12720        	mul16s	a2, a7, a2
     845:	902260        	addx2	a2, a2, a6
     848:	312020        	srai	a2, a2, 16
     84b:	f01d           	retw.n

0000084d <fxarctan2+0x199>:
     84d:	fe1751        	l32r	a5, ac (ffff <_end+0x931b>)
     850:	10a587        	bge	a5, a8, 864 <fxarctan2+0x1b0>
     853:	fe0f41        	l32r	a4, 90 (6488 <idct64+0x1c98>)
     856:	fe0221        	l32r	a2, 60 (7fff <_end+0x131b>)
     859:	d12240        	mul16s	a2, a2, a4
     85c:	902260        	addx2	a2, a2, a6
     85f:	312020        	srai	a2, a2, 16
     862:	f01d           	retw.n

00000864 <fxarctan2+0x1b0>:
     864:	fe0b41        	l32r	a4, 90 (6488 <idct64+0x1c98>)
     867:	fe0121        	l32r	a2, 6c (ffff8000 <_end+0xffff131c>)
     86a:	80d892        	addmi	a9, a8, 0xffff8000
     86d:	899d           	ae_sext16	a9, a9
     86f:	b32980        	movgez	a2, a9, a8
     872:	d12240        	mul16s	a2, a2, a4
     875:	902260        	addx2	a2, a2, a6
     878:	312020        	srai	a2, a2, 16
     87b:	f01d           	retw.n

0000087d <fxarctan2+0x1c9>:
     87d:	fe0c51        	l32r	a5, b0 (ffff0000 <_end+0xfffe931c>)
     880:	212587        	blt	a5, a8, 8a5 <fxarctan2+0x1f1>
     883:	fdfa21        	l32r	a2, 6c (ffff8000 <_end+0xffff131c>)
     886:	ffa646        	j	723 <fxarctan2+0x6f>

00000889 <fxarctan2+0x1d5>:
     889:	fe0581        	l32r	a8, a0 (ffff4000 <_end+0xfffed31c>)
     88c:	022837        	blt	a8, a3, 892 <fxarctan2+0x1de>
     88f:	ffbf86        	j	791 <fxarctan2+0xdd>
     892:	a6a3c7        	bge	a3, a12, 83c <fxarctan2+0x188>
     895:	000046        	j	89a <fxarctan2+0x1e6>

00000898 <fxarctan2+0x1e4>:
     898:	073d           	mov.n	a3, a7

0000089a <fxarctan2+0x1e6>:
     89a:	fe0071        	l32r	a7, 9c (ffffc000 <_end+0xffff531c>)
     89d:	c07730        	sub	a7, a7, a3
     8a0:	877d           	ae_sext16	a7, a7
     8a2:	ffbb86        	j	794 <fxarctan2+0xe0>

000008a5 <fxarctan2+0x1f1>:
     8a5:	fdee21        	l32r	a2, 60 (7fff <_end+0x131b>)
     8a8:	282a           	add.n	a2, a8, a2
     8aa:	822d           	ae_sext16	a2, a2
     8ac:	ff9cc6        	j	723 <fxarctan2+0x6f>

000008af <fxarctan2+0x1fb>:
	...

000008b0 <fxarctan2+0x1fc>:
     8b0:	e623c7        	blt	a3, a12, 89a <fxarctan2+0x1e6>
     8b3:	ffe146        	j	83c <fxarctan2+0x188>

000008b6 <fxarctan2+0x202>:
	...

000008b8 <LD_NR_fxsqrt>:
     8b8:	004136        	entry	a1, 32
     8bb:	0ae216        	beqz	a2, 96d <LD_NR_fxsqrt+0xb5>
     8be:	0a0c           	movi.n	a10, 0
     8c0:	029d           	mov.n	a9, a2
     8c2:	0d0c           	movi.n	a13, 0
     8c4:	082c           	movi.n	a8, 32
     8c6:	09a876        	loopgtz	a8, 8d3 <LD_NR_fxsqrt+0x1b>
     8c9:	06f9e7        	bbsi	a9, 30, 8d3 <LD_NR_fxsqrt+0x1b>
     8cc:	1199f0        	slli	a9, a9, 1
     8cf:	aa1b           	addi.n	a10, a10, 1
     8d1:	8aad           	ae_sext16	a10, a10

000008d3 <LD_NR_fxsqrt+0x1b>:
     8d3:	fc0c           	movi.n	a12, 15
     8d5:	401a00        	ssl	a10
     8d8:	a1e200        	sll	a14, a2
     8db:	c0cca0        	sub	a12, a12, a10
     8de:	04c0c0        	extui	a12, a12, 0, 1
     8e1:	400c00        	ssr	a12
     8e4:	91e0e0        	srl	a14, a14
     8e7:	c0cca0        	sub	a12, a12, a10
     8ea:	ccfb           	addi.n	a12, a12, 15
     8ec:	65f9e0        	extui	a15, a14, 25, 7
     8ef:	f4a9e0        	extui	a10, a14, 9, 16
     8f2:	f0cff2        	addi	a15, a15, -16
     8f5:	8ccd           	ae_sext16	a12, a12
     8f7:	8ffd           	ae_sext16	a15, a15
     8f9:	53ddf0        	max	a13, a13, a15
     8fc:	fdeef1        	l32r	a15, b4 (3440 <TABLE_SQRT_ld>)
     8ff:	21c1c0        	srai	a12, a12, 1
     902:	8ddd           	ae_sext16	a13, a13
     904:	90ddf0        	addx2	a13, a13, a15
     907:	2dbd           	ae_l16si.n	a11, a13, 0
     909:	3ddd           	ae_l16si.n	a13, a13, 2
     90b:	f9ccc2        	addi	a12, a12, -7
     90e:	8ccd           	ae_sext16	a12, a12
     910:	c0ddb0        	sub	a13, a13, a11
     913:	8ddd           	ae_sext16	a13, a13
     915:	31ffd0        	srai	a15, a13, 31
     918:	a2ead0        	muluh	a14, a10, a13
     91b:	82faf0        	mull	a15, a10, a15
     91e:	82aad0        	mull	a10, a10, a13
     921:	31d0b0        	srai	a13, a11, 16
     924:	eefa           	add.n	a14, a14, a15
     926:	11bb00        	slli	a11, a11, 16
     929:	ddea           	add.n	a13, a13, a14
     92b:	abaa           	add.n	a10, a11, a10
     92d:	62bab0        	saltu	a11, a10, a11
     930:	bbda           	add.n	a11, a11, a13
     932:	1a1ca6        	blti	a12, 1, 950 <LD_NR_fxsqrt+0x98>
     935:	fdcb81        	l32r	a8, 64 (2df0 <__ashldi3>)
     938:	0008e0        	callx8	a8
     93b:	fdcf81        	l32r	a8, 78 (8000 <_end+0x131c>)
     93e:	404010        	ssai	16
     941:	8a8a           	add.n	a8, a10, a8
     943:	6228a0        	saltu	a2, a8, a10
     946:	22ba           	add.n	a2, a2, a11
     948:	812280        	src	a2, a2, a8
     94b:	822d           	ae_sext16	a2, a2
     94d:	f01d           	retw.n

0000094f <LD_NR_fxsqrt+0x97>:
	...

00000950 <LD_NR_fxsqrt+0x98>:
     950:	fdda81        	l32r	a8, b8 (2e08 <__ashrdi3>)
     953:	60c0c0        	neg	a12, a12
     956:	0008e0        	callx8	a8
     959:	fdc781        	l32r	a8, 78 (8000 <_end+0x131c>)
     95c:	404010        	ssai	16
     95f:	8a8a           	add.n	a8, a10, a8
     961:	6228a0        	saltu	a2, a8, a10
     964:	22ba           	add.n	a2, a2, a11
     966:	812280        	src	a2, a2, a8
     969:	822d           	ae_sext16	a2, a2
     96b:	f01d           	retw.n

0000096d <LD_NR_fxsqrt+0xb5>:
     96d:	020c           	movi.n	a2, 0
     96f:	f01d           	retw.n

00000971 <LD_NR_fxsqrt+0xb9>:
     971:	000000                                        ...

00000974 <fxsqrt_ld>:
     974:	004136        	entry	a1, 32
     977:	063216        	beqz	a2, 9de <fxsqrt_ld+0x6a>
     97a:	fdbf31        	l32r	a3, 78 (8000 <_end+0x131c>)
     97d:	fdcd61        	l32r	a6, b4 (3440 <TABLE_SQRT_ld>)
     980:	090c           	movi.n	a9, 0
     982:	f40c           	movi.n	a4, 15
     984:	40e280        	nsa	a8, a2
     987:	401800        	ssl	a8
     98a:	c04480        	sub	a4, a4, a8
     98d:	a17200        	sll	a7, a2
     990:	044040        	extui	a4, a4, 0, 1
     993:	400400        	ssr	a4
     996:	c04480        	sub	a4, a4, a8
     999:	b17070        	sra	a7, a7
     99c:	417970        	srli	a7, a7, 9
     99f:	44fb           	addi.n	a4, a4, 15
     9a1:	315070        	srai	a5, a7, 16
     9a4:	f0c552        	addi	a5, a5, -16
     9a7:	535590        	max	a5, a5, a9
     9aa:	905560        	addx2	a5, a5, a6
     9ad:	256d           	ae_l16si.n	a6, a5, 0
     9af:	355d           	ae_l16si.n	a5, a5, 2
     9b1:	214140        	srai	a4, a4, 1
     9b4:	300774        	ae_cvtp24a16x2.ll	aep0, a7, a7
     9b7:	c05560        	sub	a5, a5, a6
     9ba:	116600        	slli	a6, a6, 16
     9bd:	115500        	slli	a5, a5, 16
     9c0:	36c534        	ae_cvtq48a32s	aeq3, a5
     9c3:	368634        	ae_cvtq48a32s	aeq2, a6
     9c6:	d7e13ec37f 	{ ae_cvtq48a32s	aeq1, a3; ae_mulaq32sp16u.l	aeq2, aeq3, aep0 }
     9cb:	f9c442        	addi	a4, a4, -7
     9ce:	fc24fea40f 	{ ae_slaasq56s	aeq0, aeq2, a4; nop }
     9d3:	0109c4        	ae_addq56	aeq0, aeq0, aeq1
     9d6:	368204        	ae_trunca32q48	a2, aeq0
     9d9:	312020        	srai	a2, a2, 16
     9dc:	f01d           	retw.n

000009de <fxsqrt_ld+0x6a>:
     9de:	020c           	movi.n	a2, 0
     9e0:	f01d           	retw.n

000009e2 <fxsqrt_ld+0x6e>:
	...

000009e4 <fxlog10>:
     9e4:	008136        	entry	a1, 64
     9e7:	4129           	s32i.n	a2, a1, 16
     9e9:	094216        	beqz	a2, a81 <fxlog10+0x9d>
     9ec:	037c           	movi.n	a3, -16
     9ee:	1a0c           	movi.n	a10, 1
     9f0:	600144        	ae_lq32f.i	aeq0, a1, 16
     9f3:	fdb241        	l32r	a4, bc (268800 <_end+0x261b1c>)
     9f6:	fdb2b1        	l32r	a11, c0 (40000000 <_end+0x3fff931c>)
     9f9:	36cb34        	ae_cvtq48a32s	aeq3, a11
     9fc:	065296        	bltz	a2, a65 <fxlog10+0x81>
     9ff:	364804        	ae_nsaq56s	a8, aeq0
     a02:	398444        	ae_movpa24x2	aep0, a4, a4
     a05:	691c           	movi.n	a9, 22
     a07:	c09980        	sub	a9, a9, a8
     a0a:	f9c882        	addi	a8, a8, -7
     a0d:	119980        	slli	a9, a9, 8
     a10:	399994        	ae_movpa24x2	aep1, a9, a9
     a13:	e922be880f 	{ ae_slaasq56s	aeq0, aeq0, a8; ae_mulp24s.hh	aeq2, aep0, aep1 }

00000a18 <fxlog10+0x34>:
     a18:	051c           	movi.n	a5, 16
     a1a:	fdaa21        	l32r	a2, c4 (3f9e <K_VAL+0x2e>)
     a1d:	fc24feba4f 	{ ae_slaasq56s	aeq1, aeq3, a10; nop }
     a22:	f926cff14f 	{ movi	a4, -15; ae_subq56	aeq1, aeq0, aeq1 }
     a27:	f84e4ffdcf 	{ movi	a12, -3; ae_truncp24q48x2	aep1, aeq1, aeq1 }
     a2c:	f8c7c0056f 	{ movi	a6, 5; ae_truncp16	aep1, aep1 }
     a31:	f966ac821f 	{ ae_lp16f.iu	aep0, a2, 2; ae_movp48	aep2, aep1 }
     a36:	1f8676        	loop	a6, a59 <fxlog10+0x75>
     a39:	e822ac821f 	{ ae_lp16f.iu	aep0, a2, 2; ae_mulp24s.hh	aeq0, aep0, aep1 }
     a3e:	021a44        	ae_mulp24s.hh	aeq1, aep1, aep2
     a41:	fc24fe830f 	{ ae_slaasq56s	aeq0, aeq0, a3; nop }
     a46:	fa723e940f 	{ ae_slaasq56s	aeq0, aeq1, a4; ae_addq56	aeq2, aeq2, aeq0 }
     a4b:	060934        	ae_roundsq32asym	aeq0, aeq0
     a4e:	fc24fe850f 	{ ae_slaasq56s	aeq0, aeq0, a5; nop }
     a53:	098c14        	ae_truncp24q48x2	aep1, aeq0, aeq0
     a56:	091294        	ae_truncp16	aep1, aep1

00000a59 <fxlog10+0x75>:
     a59:	fc24feac0f 	{ ae_slaasq56s	aeq0, aeq2, a12; nop }
     a5e:	620104        	ae_sq32f.i	aeq0, a1, 0
     a61:	212d           	ae_l16si.n	a2, a1, 0
     a63:	f01d           	retw.n

00000a65 <fxlog10+0x81>:
     a65:	364d04        	ae_nsaq56s	a13, aeq0
     a68:	7e1c           	movi.n	a14, 23
     a6a:	39a444        	ae_movpa24x2	aep2, a4, a4
     a6d:	c0eed0        	sub	a14, a14, a13
     a70:	f8cdd2        	addi	a13, a13, -8
     a73:	11ee80        	slli	a14, a14, 8
     a76:	39bee4        	ae_movpa24x2	aep3, a14, a14
     a79:	e96abe8d0f 	{ ae_slaasq56s	aeq0, aeq0, a13; ae_mulp24s.hh	aeq2, aep2, aep3 }
     a7e:	ffe586        	j	a18 <fxlog10+0x34>

00000a81 <fxlog10+0x9d>:
     a81:	fd7a21        	l32r	a2, 6c (ffff8000 <_end+0xffff131c>)
     a84:	f01d           	retw.n

00000a86 <fxlog10+0xa2>:
	...

00000a88 <fxln>:
     a88:	004136        	entry	a1, 32
     a8b:	066216        	beqz	a2, af5 <fxln+0x6d>
     a8e:	040c           	movi.n	a4, 0
     a90:	fd9091        	l32r	a9, d0 (3fb0 <ln_coef>)
     a93:	fd8d81        	l32r	a8, c8 (2c5d <LDNR_xtensa_real_fft_32b+0xc5>)
     a96:	fd6f51        	l32r	a5, 54 (80000000 <_end+0x7fff931c>)
     a99:	fd8c71        	l32r	a7, cc (29973 <_end+0x22c8f>)
     a9c:	032c           	movi.n	a3, 32
     a9e:	09a376        	loopgtz	a3, aab <fxln+0x23>
     aa1:	006296        	bltz	a2, aab <fxln+0x23>
     aa4:	1122f0        	slli	a2, a2, 1
     aa7:	441b           	addi.n	a4, a4, 1
     aa9:	844d           	ae_sext16	a4, a4

00000aab <fxln+0x23>:
     aab:	d18480        	mul16s	a8, a4, a8
     aae:	530c           	movi.n	a3, 5
     ab0:	425a           	add.n	a4, a2, a5
     ab2:	020c           	movi.n	a2, 0
     ab4:	f54040        	extui	a4, a4, 16, 16
     ab7:	c07780        	sub	a7, a7, a8
     aba:	115700        	slli	a5, a7, 16
     abd:	844d           	ae_sext16	a4, a4
     abf:	317070        	srai	a7, a7, 16
     ac2:	208440        	or	a8, a4, a4
     ac5:	228376        	loop	a3, aeb <fxln+0x63>
     ac8:	903290        	addx2	a3, a2, a9
     acb:	d16480        	mul16s	a6, a4, a8
     ace:	221b           	addi.n	a2, a2, 1
     ad0:	233d           	ae_l16si.n	a3, a3, 0
     ad2:	822d           	ae_sext16	a2, a2
     ad4:	40d662        	addmi	a6, a6, 0x4000
     ad7:	d13340        	mul16s	a3, a3, a4
     ada:	214f60        	srai	a4, a6, 15
     add:	553a           	add.n	a5, a5, a3
     adf:	316f30        	srai	a6, a3, 31
     ae2:	844d           	ae_sext16	a4, a4
     ae4:	767a           	add.n	a7, a6, a7
     ae6:	626530        	saltu	a6, a5, a3
     ae9:	767a           	add.n	a7, a6, a7
     aeb:	404310        	ssai	19
     aee:	812750        	src	a2, a7, a5
     af1:	822d           	ae_sext16	a2, a2
     af3:	f01d           	retw.n

00000af5 <fxln+0x6d>:
     af5:	fd5d21        	l32r	a2, 6c (ffff8000 <_end+0xffff131c>)
     af8:	f01d           	retw.n

00000afa <fxln+0x72>:
     afa:	00000000 41360000                                ......

00000b00 <_saturate16>:
     b00:	004136        	entry	a1, 32
     b03:	fd5781        	l32r	a8, 60 (7fff <_end+0x131b>)
     b06:	fd5831        	l32r	a3, 68 (ffff7fff <_end+0xffff131b>)
     b09:	0b2827        	blt	a8, a2, b18 <_saturate16+0x18>
     b0c:	042327        	blt	a3, a2, b14 <_saturate16+0x14>
     b0f:	fd5721        	l32r	a2, 6c (ffff8000 <_end+0xffff131c>)
     b12:	f01d           	retw.n

00000b14 <_saturate16+0x14>:
     b14:	822d           	ae_sext16	a2, a2
     b16:	f01d           	retw.n

00000b18 <_saturate16+0x18>:
     b18:	082d           	mov.n	a2, a8
     b1a:	f01d           	retw.n

00000b1c <_saturate32>:
     b1c:	004136        	entry	a1, 32
     b1f:	fd4c71        	l32r	a7, 50 (7fffffff <_end+0x7fff931b>)
     b22:	060c           	movi.n	a6, 0
     b24:	003396        	bltz	a3, b2b <_saturate32+0xf>
     b27:	939c           	beqz.n	a3, b44 <_saturate32+0x28>

00000b29 <_saturate32+0xd>:
     b29:	160c           	movi.n	a6, 1

00000b2b <_saturate32+0xf>:
     b2b:	368c           	beqz.n	a6, b32 <_saturate32+0x16>
     b2d:	fd4821        	l32r	a2, 50 (7fffffff <_end+0x7fff931b>)
     b30:	f01d           	retw.n

00000b32 <_saturate32+0x16>:
     b32:	fd4771        	l32r	a7, 50 (7fffffff <_end+0x7fff931b>)
     b35:	060c           	movi.n	a6, 0
     b37:	00f396        	bltz	a3, b4a <_saturate32+0x2e>

00000b3a <_saturate32+0x1e>:
     b3a:	fd4631        	l32r	a3, 54 (80000000 <_end+0x7fff931c>)
     b3d:	833260        	moveqz	a3, a2, a6
     b40:	032d           	mov.n	a2, a3
     b42:	f01d           	retw.n

00000b44 <_saturate32+0x28>:
     b44:	e3b727        	bgeu	a7, a2, b2b <_saturate32+0xf>
     b47:	fff786        	j	b29 <_saturate32+0xd>

00000b4a <_saturate32+0x2e>:
     b4a:	040326        	beqi	a3, -1, b52 <_saturate32+0x36>

00000b4d <_saturate32+0x31>:
     b4d:	fd4121        	l32r	a2, 54 (80000000 <_end+0x7fff931c>)
     b50:	f01d           	retw.n

00000b52 <_saturate32+0x36>:
     b52:	e43727        	bltu	a7, a2, b3a <_saturate32+0x1e>
     b55:	fffd06        	j	b4d <_saturate32+0x31>

00000b58 <LD_NR_SVN_version>:
     b58:	004136        	entry	a1, 32
     b5b:	fd5e21        	l32r	a2, d4 (22101401 <_end+0x220fa71d>)
     b5e:	f01d           	retw.n

00000b60 <LD_NR_get_memsize>:
     b60:	004136        	entry	a1, 32
     b63:	fd5d21        	l32r	a2, d8 (3788 <LD_NR_A_RI+0x2d8>)
     b66:	f01d           	retw.n

00000b68 <fn_ini_pitch_detection>:
     b68:	004136        	entry	a1, 32
     b6b:	02ad           	mov.n	a10, a2
     b6d:	fd5b81        	l32r	a8, dc (2370 <LDNR_xt_memset>)
     b70:	0b0c           	movi.n	a11, 0
     b72:	0ea0c2        	movi	a12, 14
     b75:	0008e0        	callx8	a8
     b78:	03bd           	mov.n	a11, a3
     b7a:	fd5981        	l32r	a8, e0 (2388 <LDNR_xt_memcpy>)
     b7d:	02ad           	mov.n	a10, a2
     b7f:	ac0c           	movi.n	a12, 10
     b81:	0008e0        	callx8	a8
     b84:	6249           	s32i.n	a4, a2, 24
     b86:	f01d           	retw.n

00000b88 <fn_pitch_detection>:
     b88:	008136        	entry	a1, 64
     b8b:	fd3171        	l32r	a7, 50 (7fffffff <_end+0x7fff931b>)
     b8e:	6298           	l32i.n	a9, a2, 24
     b90:	079282        	l16si	a8, a2, 14
     b93:	6199           	s32i.n	a9, a1, 24
     b95:	08d992        	addmi	a9, a9, 0x800
     b98:	3199           	s32i.n	a9, a1, 12
     b9a:	0218e6        	bgei	a8, 1, ba0 <fn_pitch_detection+0x18>
     b9d:	00a8c6        	j	e44 <fn_pitch_detection+0x2bc>
     ba0:	fd3651        	l32r	a5, 78 (8000 <_end+0x131c>)
     ba3:	fd50a1        	l32r	a10, e4 (6a4d3c26 <_end+0x6a4ccf42>)
     ba6:	fd4fc1        	l32r	a12, e4 (6a4d3c26 <_end+0x6a4ccf42>)
     ba9:	fd30b1        	l32r	a11, 6c (ffff8000 <_end+0xffff131c>)
     bac:	fd2d91        	l32r	a9, 60 (7fff <_end+0x131b>)
     baf:	404f10        	ssai	31
     bb2:	828bc0        	mull	a8, a11, a12
     bb5:	8249a0        	mull	a4, a9, a10
     bb8:	b2bbc0        	mulsh	a11, a11, a12
     bbb:	b299a0        	mulsh	a9, a9, a10
     bbe:	81bb80        	src	a11, a11, a8
     bc1:	404010        	ssai	16
     bc4:	1188f0        	slli	a8, a8, 1
     bc7:	a85a           	add.n	a10, a8, a5
     bc9:	628a80        	saltu	a8, a10, a8
     bcc:	88ba           	add.n	a8, a8, a11
     bce:	81a8a0        	src	a10, a8, a10
     bd1:	21a9           	s32i.n	a10, a1, 8
     bd3:	318080        	srai	a8, a8, 16
     bd6:	404f10        	ssai	31
     bd9:	819940        	src	a9, a9, a4
     bdc:	1189           	s32i.n	a8, a1, 4
     bde:	404010        	ssai	16
     be1:	1144f0        	slli	a4, a4, 1
     be4:	545a           	add.n	a5, a4, a5
     be6:	624540        	saltu	a4, a5, a4
     be9:	449a           	add.n	a4, a4, a9
     beb:	815450        	src	a5, a4, a5
     bee:	5159           	s32i.n	a5, a1, 20
     bf0:	314040        	srai	a4, a4, 16
     bf3:	4149           	s32i.n	a4, a1, 16
     bf5:	6158           	l32i.n	a5, a1, 24
     bf7:	040c           	movi.n	a4, 0
     bf9:	000506        	j	c11 <fn_pitch_detection+0x89>

00000bfc <fn_pitch_detection+0x74>:
     bfc:	4bbc           	beqz.n	a11, c34 <fn_pitch_detection+0xac>

00000bfe <fn_pitch_detection+0x76>:
     bfe:	180c           	movi.n	a8, 1

00000c00 <fn_pitch_detection+0x78>:
     c00:	88bc           	beqz.n	a8, c3c <fn_pitch_detection+0xb4>

00000c02 <fn_pitch_detection+0x7a>:
     c02:	fd1381        	l32r	a8, 50 (7fffffff <_end+0x7fff931b>)

00000c05 <fn_pitch_detection+0x7d>:
     c05:	0792e2        	l16si	a14, a2, 14
     c08:	09e584        	ae_s32ip	a8, a5, 4
     c0b:	0224e7        	blt	a4, a14, c11 <fn_pitch_detection+0x89>
     c0e:	003cc6        	j	d05 <fn_pitch_detection+0x17d>

00000c11 <fn_pitch_detection+0x89>:
     c11:	03a8           	l32i.n	a10, a3, 0
     c13:	fd3581        	l32r	a8, e8 (9e4 <fxlog10>)
     c16:	aa1b           	addi.n	a10, a10, 1
     c18:	0008e0        	callx8	a8
     c1b:	fd3481        	l32r	a8, ec (b4fa <_end+0x4816>)
     c1e:	334b           	addi.n	a3, a3, 4
     c20:	441b           	addi.n	a4, a4, 1
     c22:	3ca8a7        	bge	a8, a10, c62 <fn_pitch_detection+0xda>
     c25:	080c           	movi.n	a8, 0
     c27:	41b8           	l32i.n	a11, a1, 16
     c29:	fd0d61        	l32r	a6, 60 (7fff <_end+0x131b>)
     c2c:	51f8           	l32i.n	a15, a1, 20
     c2e:	fcabd6        	bgez	a11, bfc <fn_pitch_detection+0x74>
     c31:	fff2c6        	j	c00 <fn_pitch_detection+0x78>

00000c34 <fn_pitch_detection+0xac>:
     c34:	c8b7f7        	bgeu	a7, a15, c00 <fn_pitch_detection+0x78>
     c37:	fff0c6        	j	bfe <fn_pitch_detection+0x76>

00000c3a <fn_pitch_detection+0xb2>:
	...

00000c3c <fn_pitch_detection+0xb4>:
     c3c:	fd05a1        	l32r	a10, 50 (7fffffff <_end+0x7fff931b>)
     c3f:	41d8           	l32i.n	a13, a1, 16
     c41:	51c8           	l32i.n	a12, a1, 20
     c43:	080c           	movi.n	a8, 0
     c45:	004dd6        	bgez	a13, c4d <fn_pitch_detection+0xc5>
     c48:	0c0d26        	beqi	a13, -1, c58 <fn_pitch_detection+0xd0>

00000c4b <fn_pitch_detection+0xc3>:
     c4b:	180c           	movi.n	a8, 1

00000c4d <fn_pitch_detection+0xc5>:
     c4d:	0ad816        	beqz	a8, cfe <fn_pitch_detection+0x176>

00000c50 <fn_pitch_detection+0xc8>:
     c50:	fd0181        	l32r	a8, 54 (80000000 <_end+0x7fff931c>)
     c53:	ffeb86        	j	c05 <fn_pitch_detection+0x7d>

00000c56 <fn_pitch_detection+0xce>:
	...

00000c58 <fn_pitch_detection+0xd0>:
     c58:	f13ac7        	bltu	a10, a12, c4d <fn_pitch_detection+0xc5>
     c5b:	fffb06        	j	c4b <fn_pitch_detection+0xc3>

00000c5e <fn_pitch_detection+0xd6>:
     c5e:	00000000                                ....

00000c62 <fn_pitch_detection+0xda>:
     c62:	fd23e1        	l32r	a14, f0 (ffffb4fa <_end+0xffff4816>)
     c65:	2198           	l32i.n	a9, a1, 8
     c67:	11f8           	l32i.n	a15, a1, 4
     c69:	352ea7        	blt	a14, a10, ca2 <fn_pitch_detection+0x11a>
     c6c:	080c           	movi.n	a8, 0
     c6e:	fcff61        	l32r	a6, 6c (ffff8000 <_end+0xffff131c>)
     c71:	003f96        	bltz	a15, c78 <fn_pitch_detection+0xf0>
     c74:	cf9c           	beqz.n	a15, c94 <fn_pitch_detection+0x10c>

00000c76 <fn_pitch_detection+0xee>:
     c76:	180c           	movi.n	a8, 1

00000c78 <fn_pitch_detection+0xf0>:
     c78:	f86856        	bnez	a8, c02 <fn_pitch_detection+0x7a>
     c7b:	fcf5c1        	l32r	a12, 50 (7fffffff <_end+0x7fff931b>)
     c7e:	11e8           	l32i.n	a14, a1, 4
     c80:	2198           	l32i.n	a9, a1, 8
     c82:	080c           	movi.n	a8, 0
     c84:	004ed6        	bgez	a14, c8c <fn_pitch_detection+0x104>
     c87:	0f0e26        	beqi	a14, -1, c9a <fn_pitch_detection+0x112>

00000c8a <fn_pitch_detection+0x102>:
     c8a:	180c           	movi.n	a8, 1

00000c8c <fn_pitch_detection+0x104>:
     c8c:	fc0856        	bnez	a8, c50 <fn_pitch_detection+0xc8>
     c8f:	2188           	l32i.n	a8, a1, 8
     c91:	ffdc06        	j	c05 <fn_pitch_detection+0x7d>

00000c94 <fn_pitch_detection+0x10c>:
     c94:	e0b797        	bgeu	a7, a9, c78 <fn_pitch_detection+0xf0>
     c97:	fff6c6        	j	c76 <fn_pitch_detection+0xee>

00000c9a <fn_pitch_detection+0x112>:
     c9a:	ee3c97        	bltu	a12, a9, c8c <fn_pitch_detection+0x104>
     c9d:	fffa46        	j	c8a <fn_pitch_detection+0x102>

00000ca0 <fn_pitch_detection+0x118>:
	...

00000ca2 <fn_pitch_detection+0x11a>:
     ca2:	0f0c           	movi.n	a15, 0
     ca4:	fcf591        	l32r	a9, 78 (8000 <_end+0x131c>)
     ca7:	fd1361        	l32r	a6, f4 (ffffcb05 <_end+0xffff5e21>)
     caa:	404f10        	ssai	31
     cad:	fd0db1        	l32r	a11, e4 (6a4d3c26 <_end+0x6a4ccf42>)
     cb0:	6a6a           	add.n	a6, a10, a6
     cb2:	866d           	ae_sext16	a6, a6
     cb4:	8286b0        	mull	a8, a6, a11
     cb7:	b2b6b0        	mulsh	a11, a6, a11
     cba:	11a8f0        	slli	a10, a8, 1
     cbd:	81bb80        	src	a11, a11, a8
     cc0:	404010        	ssai	16
     cc3:	908890        	addx2	a8, a8, a9
     cc6:	62a8a0        	saltu	a10, a8, a10
     cc9:	aaba           	add.n	a10, a10, a11
     ccb:	818a80        	src	a8, a10, a8
     cce:	31a0a0        	srai	a10, a10, 16
     cd1:	003a96        	bltz	a10, cd8 <fn_pitch_detection+0x150>
     cd4:	8a9c           	beqz.n	a10, cf0 <fn_pitch_detection+0x168>

00000cd6 <fn_pitch_detection+0x14e>:
     cd6:	1f0c           	movi.n	a15, 1

00000cd8 <fn_pitch_detection+0x150>:
     cd8:	f26f56        	bnez	a15, c02 <fn_pitch_detection+0x7a>
     cdb:	090c           	movi.n	a9, 0
     cdd:	fcdcc1        	l32r	a12, 50 (7fffffff <_end+0x7fff931b>)
     ce0:	004ad6        	bgez	a10, ce8 <fn_pitch_detection+0x160>
     ce3:	110a26        	beqi	a10, -1, cf8 <fn_pitch_detection+0x170>

00000ce6 <fn_pitch_detection+0x15e>:
     ce6:	190c           	movi.n	a9, 1

00000ce8 <fn_pitch_detection+0x160>:
     ce8:	f64956        	bnez	a9, c50 <fn_pitch_detection+0xc8>
     ceb:	ffc586        	j	c05 <fn_pitch_detection+0x7d>

00000cee <fn_pitch_detection+0x166>:
	...

00000cf0 <fn_pitch_detection+0x168>:
     cf0:	e4b787        	bgeu	a7, a8, cd8 <fn_pitch_detection+0x150>
     cf3:	fff7c6        	j	cd6 <fn_pitch_detection+0x14e>

00000cf6 <fn_pitch_detection+0x16e>:
	...

00000cf8 <fn_pitch_detection+0x170>:
     cf8:	ec3c87        	bltu	a12, a8, ce8 <fn_pitch_detection+0x160>
     cfb:	fff9c6        	j	ce6 <fn_pitch_detection+0x15e>

00000cfe <fn_pitch_detection+0x176>:
     cfe:	5188           	l32i.n	a8, a1, 20
     d00:	ffc046        	j	c05 <fn_pitch_detection+0x7d>

00000d03 <fn_pitch_detection+0x17b>:
	...

00000d05 <fn_pitch_detection+0x17d>:
     d05:	616d           	ae_s16i.n	a6, a1, 0
     d07:	00a1c2        	movi	a12, 0x100
     d0a:	02ac47        	bge	a12, a4, d10 <fn_pitch_detection+0x188>
     d0d:	0049c6        	j	e38 <fn_pitch_detection+0x2b0>

00000d10 <fn_pitch_detection+0x188>:
     d10:	fcfa91        	l32r	a9, f8 (c0000000 <_end+0xbfff931c>)
     d13:	6188           	l32i.n	a8, a1, 24
     d15:	01a1a2        	movi	a10, 0x101
     d18:	c0aa40        	sub	a10, a10, a4
     d1b:	a08480        	addx4	a8, a4, a8
     d1e:	02aa76        	loopgtz	a10, d24 <fn_pitch_detection+0x19c>
     d21:	09e894        	ae_s32ip	a9, a8, 4

00000d24 <fn_pitch_detection+0x19c>:
     d24:	01a142        	movi	a4, 0x101

00000d27 <fn_pitch_detection+0x19f>:
     d27:	1194e0        	slli	a9, a4, 2
     d2a:	6188           	l32i.n	a8, a1, 24
     d2c:	00a2e2        	movi	a14, 0x200
     d2f:	c0ee40        	sub	a14, a14, a4
     d32:	a05480        	addx4	a5, a4, a8
     d35:	c08890        	sub	a8, a8, a9
     d38:	06d882        	addmi	a8, a8, 0x600
     d3b:	2490e0        	extui	a9, a14, 0, 3
     d3e:	08a976        	loopgtz	a9, d4a <fn_pitch_detection+0x1c2>
     d41:	fcc882        	addi	a8, a8, -4
     d44:	8128f2        	l32i	a15, a8, 0x204
     d47:	09e5f4        	ae_s32ip	a15, a5, 4

00000d4a <fn_pitch_detection+0x1c2>:
     d4a:	2193e0        	srai	a9, a14, 3
     d4d:	32a976        	loopgtz	a9, d83 <fn_pitch_detection+0x1fb>
     d50:	802892        	l32i	a9, a8, 0x200
     d53:	e0c882        	addi	a8, a8, -32
     d56:	09e594        	ae_s32ip	a9, a5, 4
     d59:	872892        	l32i	a9, a8, 0x21c
     d5c:	09e594        	ae_s32ip	a9, a5, 4
     d5f:	862892        	l32i	a9, a8, 0x218
     d62:	09e594        	ae_s32ip	a9, a5, 4
     d65:	852892        	l32i	a9, a8, 0x214
     d68:	09e594        	ae_s32ip	a9, a5, 4
     d6b:	842892        	l32i	a9, a8, 0x210
     d6e:	09e594        	ae_s32ip	a9, a5, 4
     d71:	832892        	l32i	a9, a8, 0x20c
     d74:	09e594        	ae_s32ip	a9, a5, 4
     d77:	822892        	l32i	a9, a8, 0x208
     d7a:	09e594        	ae_s32ip	a9, a5, 4
     d7d:	812892        	l32i	a9, a8, 0x204
     d80:	09e594        	ae_s32ip	a9, a5, 4

00000d83 <fn_pitch_detection+0x1fb>:
     d83:	fcde81        	l32r	a8, fc (2258 <real_512_fft_0>)
     d86:	61a8           	l32i.n	a10, a1, 24
     d88:	0321b2        	l32i	a11, a1, 12
     d8b:	0008e0        	callx8	a8
     d8e:	3188           	l32i.n	a8, a1, 12
     d90:	049242        	l16si	a4, a2, 8
     d93:	0a3d           	mov.n	a3, a10
     d95:	6198           	l32i.n	a9, a1, 24
     d97:	0592a2        	l16si	a10, a2, 10
     d9a:	b08480        	addx8	a8, a4, a8
     d9d:	a09490        	addx4	a9, a4, a9
     da0:	fcc992        	addi	a9, a9, -4
     da3:	5c8804        	ae_lp24x2f.iu	aep0, a8, 0
     da6:	0224a7        	blt	a4, a10, dac <fn_pitch_detection+0x224>
     da9:	002146        	j	e32 <fn_pitch_detection+0x2aa>
     dac:	216d           	ae_l16si.n	a6, a1, 0
     dae:	19aca2        	movi	a10, 0xfffffc19
     db1:	238076        	loop	a0, dd8 <fn_pitch_detection+0x250>
     db4:	010844        	ae_mulfp24s.hh	aeq1, aep0, aep0
     db7:	010834        	ae_mulafp24s.ll	aeq1, aep0, aep0
     dba:	355074        	ae_sraiq56	aeq1, aeq1, 1
     dbd:	061934        	ae_roundsq32asym	aeq0, aeq1
     dc0:	368b04        	ae_trunca32q48	a11, aeq0
     dc3:	624914        	ae_sq32f.iu	aeq0, a9, 4
     dc6:	5c8814        	ae_lp24x2f.iu	aep0, a8, 8
     dc9:	03aab7        	bge	a10, a11, dd0 <fn_pitch_detection+0x248>
     dcc:	0bad           	mov.n	a10, a11
     dce:	046d           	mov.n	a6, a4

00000dd0 <fn_pitch_detection+0x248>:
     dd0:	0592b2        	l16si	a11, a2, 10
     dd3:	441b           	addi.n	a4, a4, 1
     dd5:	02a4b7        	bge	a4, a11, ddb <fn_pitch_detection+0x253>

00000dd8 <fn_pitch_detection+0x250>:
     dd8:	fff546        	j	db1 <fn_pitch_detection+0x229>

00000ddb <fn_pitch_detection+0x253>:
     ddb:	616d           	ae_s16i.n	a6, a1, 0

00000ddd <fn_pitch_detection+0x255>:
     ddd:	fcc881        	l32r	a8, 100 (8b8 <LD_NR_fxsqrt>)
     de0:	f03d           	nop.n
     de2:	0008e0        	callx8	a8
     de5:	31bfa0        	srai	a11, a10, 31
     de8:	335b           	addi.n	a3, a3, 5
     dea:	fc9e81        	l32r	a8, 64 (2df0 <__ashldi3>)
     ded:	833d           	ae_sext16	a3, a3
     def:	03cd           	mov.n	a12, a3
     df1:	0008e0        	callx8	a8
     df4:	080c           	movi.n	a8, 0
     df6:	004b96        	bltz	a11, dfe <fn_pitch_detection+0x276>
     df9:	0ebb16        	beqz	a11, ee8 <fn_pitch_detection+0x360>

00000dfc <fn_pitch_detection+0x274>:
     dfc:	180c           	movi.n	a8, 1

00000dfe <fn_pitch_detection+0x276>:
     dfe:	78ec           	bnez.n	a8, e29 <fn_pitch_detection+0x2a1>
     e00:	fc9451        	l32r	a5, 50 (7fffffff <_end+0x7fff931b>)
     e03:	0248           	l32i.n	a4, a2, 0
     e05:	00a082        	movi	a8, 0
     e08:	007bd6        	bgez	a11, e13 <fn_pitch_detection+0x28b>
     e0b:	01cbd2        	addi	a13, a11, 1
     e0e:	0dfd16        	beqz	a13, ef1 <fn_pitch_detection+0x369>

00000e11 <fn_pitch_detection+0x289>:
     e11:	180c           	movi.n	a8, 1

00000e13 <fn_pitch_detection+0x28b>:
     e13:	38bc           	beqz.n	a8, e4a <fn_pitch_detection+0x2c2>
     e15:	fc8f81        	l32r	a8, 54 (80000000 <_end+0x7fff931c>)
     e18:	0da847        	bge	a8, a4, e29 <fn_pitch_detection+0x2a1>
     e1b:	12e8           	l32i.n	a14, a2, 4
     e1d:	31a8e7        	bge	a8, a14, e52 <fn_pitch_detection+0x2ca>

00000e20 <fn_pitch_detection+0x298>:
     e20:	080c           	movi.n	a8, 0
     e22:	0a5282        	s16i	a8, a2, 20
     e25:	082d           	mov.n	a2, a8
     e27:	f01d           	retw.n

00000e29 <fn_pitch_detection+0x2a1>:
     e29:	218d           	ae_l16si.n	a8, a1, 0
     e2b:	0a5282        	s16i	a8, a2, 20
     e2e:	082d           	mov.n	a2, a8
     e30:	f01d           	retw.n

00000e32 <fn_pitch_detection+0x2aa>:
     e32:	19aca2        	movi	a10, 0xfffffc19
     e35:	ffe906        	j	ddd <fn_pitch_detection+0x255>

00000e38 <fn_pitch_detection+0x2b0>:
     e38:	ffa1f2        	movi	a15, 0x1ff
     e3b:	022f47        	blt	a15, a4, e41 <fn_pitch_detection+0x2b9>
     e3e:	ffb946        	j	d27 <fn_pitch_detection+0x19f>
     e41:	ffcf86        	j	d83 <fn_pitch_detection+0x1fb>

00000e44 <fn_pitch_detection+0x2bc>:
     e44:	040c           	movi.n	a4, 0
     e46:	ffb186        	j	d10 <fn_pitch_detection+0x188>

00000e49 <fn_pitch_detection+0x2c1>:
	...

00000e4a <fn_pitch_detection+0x2c2>:
     e4a:	dbaa47        	bge	a10, a4, e29 <fn_pitch_detection+0x2a1>
     e4d:	1288           	l32i.n	a8, a2, 4
     e4f:	cd2a87        	blt	a10, a8, e20 <fn_pitch_detection+0x298>
     e52:	0a9282        	l16si	a8, a2, 20
     e55:	fc7816        	beqz	a8, e20 <fn_pitch_detection+0x298>
     e58:	216d           	ae_l16si.n	a6, a1, 0
     e5a:	069292        	l16si	a9, a2, 12
     e5d:	c0a860        	sub	a10, a8, a6
     e60:	60a1a0        	abs	a10, a10
     e63:	0229a7        	blt	a9, a10, e69 <fn_pitch_detection+0x2e1>
     e66:	003c06        	j	f5a <fn_pitch_detection+0x3d2>
     e69:	6188           	l32i.n	a8, a1, 24
     e6b:	050c           	movi.n	a5, 0
     e6d:	4a1c           	movi.n	a10, 20
     e6f:	a08680        	addx4	a8, a6, a8
     e72:	d8c882        	addi	a8, a8, -40
     e75:	028a76        	loop	a10, e7b <fn_pitch_detection+0x2f3>
     e78:	09e854        	ae_s32ip	a5, a8, 4

00000e7b <fn_pitch_detection+0x2f3>:
     e7b:	059292        	l16si	a9, a2, 10
     e7e:	049242        	l16si	a4, a2, 8
     e81:	75a497        	bge	a4, a9, efa <fn_pitch_detection+0x372>
     e84:	19aca2        	movi	a10, 0xfffffc19
     e87:	6188           	l32i.n	a8, a1, 24
     e89:	01a0c2        	movi	a12, 1
     e8c:	c0b940        	sub	a11, a9, a4
     e8f:	53bbc0        	max	a11, a11, a12
     e92:	a08480        	addx4	a8, a4, a8
     e95:	0cab76        	loopgtz	a11, ea5 <fn_pitch_detection+0x31d>
     e98:	0898           	l32i.n	a9, a8, 0
     e9a:	884b           	addi.n	a8, a8, 4
     e9c:	03aa97        	bge	a10, a9, ea3 <fn_pitch_detection+0x31b>
     e9f:	09ad           	mov.n	a10, a9
     ea1:	846d           	ae_sext16	a6, a4

00000ea3 <fn_pitch_detection+0x31b>:
     ea3:	441b           	addi.n	a4, a4, 1

00000ea5 <fn_pitch_detection+0x31d>:
     ea5:	fc9681        	l32r	a8, 100 (8b8 <LD_NR_fxsqrt>)
     ea8:	0008e0        	callx8	a8
     eab:	fc6e81        	l32r	a8, 64 (2df0 <__ashldi3>)
     eae:	03cd           	mov.n	a12, a3
     eb0:	31bfa0        	srai	a11, a10, 31
     eb3:	0008e0        	callx8	a8
     eb6:	080c           	movi.n	a8, 0
     eb8:	004b96        	bltz	a11, ec0 <fn_pitch_detection+0x338>
     ebb:	0a2b16        	beqz	a11, f61 <fn_pitch_detection+0x3d9>

00000ebe <fn_pitch_detection+0x336>:
     ebe:	180c           	movi.n	a8, 1

00000ec0 <fn_pitch_detection+0x338>:
     ec0:	c8bc           	beqz.n	a8, f00 <fn_pitch_detection+0x378>
     ec2:	069282        	l16si	a8, a2, 12
     ec5:	0a9292        	l16si	a9, a2, 20
     ec8:	12f8           	l32i.n	a15, a2, 4
     eca:	fc61e1        	l32r	a14, 50 (7fffffff <_end+0x7fff931b>)
     ecd:	c09960        	sub	a9, a9, a6
     ed0:	609190        	abs	a9, a9
     ed3:	72eef0        	salt	a14, a14, a15
     ed6:	728890        	salt	a8, a8, a9
     ed9:	936580        	movnez	a6, a5, a8
     edc:	868d           	ae_sext16	a8, a6
     ede:	9385e0        	movnez	a8, a5, a14
     ee1:	0a5282        	s16i	a8, a2, 20
     ee4:	082d           	mov.n	a2, a8
     ee6:	f01d           	retw.n

00000ee8 <fn_pitch_detection+0x360>:
     ee8:	0237a7        	bltu	a7, a10, eee <fn_pitch_detection+0x366>
     eeb:	ffc3c6        	j	dfe <fn_pitch_detection+0x276>
     eee:	ffc286        	j	dfc <fn_pitch_detection+0x274>

00000ef1 <fn_pitch_detection+0x369>:
     ef1:	02b5a7        	bgeu	a5, a10, ef7 <fn_pitch_detection+0x36f>
     ef4:	ffc6c6        	j	e13 <fn_pitch_detection+0x28b>
     ef7:	ffc586        	j	e11 <fn_pitch_detection+0x289>

00000efa <fn_pitch_detection+0x372>:
     efa:	19aca2        	movi	a10, 0xfffffc19
     efd:	ffe906        	j	ea5 <fn_pitch_detection+0x31d>

00000f00 <fn_pitch_detection+0x378>:
     f00:	fc5471        	l32r	a7, 50 (7fffffff <_end+0x7fff931b>)
     f03:	080c           	movi.n	a8, 0
     f05:	028bd6        	bgez	a11, f31 <fn_pitch_detection+0x3a9>
     f08:	5e0b26        	beqi	a11, -1, f6a <fn_pitch_detection+0x3e2>

00000f0b <fn_pitch_detection+0x383>:
     f0b:	0692f2        	l16si	a15, a2, 12
     f0e:	0a9292        	l16si	a9, a2, 20
     f11:	12e8           	l32i.n	a14, a2, 4
     f13:	fc50d1        	l32r	a13, 54 (80000000 <_end+0x7fff931c>)
     f16:	c08960        	sub	a8, a9, a6
     f19:	608180        	abs	a8, a8
     f1c:	72dde0        	salt	a13, a13, a14
     f1f:	72ff80        	salt	a15, a15, a8
     f22:	9365f0        	movnez	a6, a5, a15
     f25:	868d           	ae_sext16	a8, a6
     f27:	9385d0        	movnez	a8, a5, a13
     f2a:	0a5282        	s16i	a8, a2, 20
     f2d:	082d           	mov.n	a2, a8
     f2f:	f01d           	retw.n

00000f31 <fn_pitch_detection+0x3a9>:
     f31:	0692f2        	l16si	a15, a2, 12
     f34:	fc48d1        	l32r	a13, 54 (80000000 <_end+0x7fff931c>)
     f37:	0a9292        	l16si	a9, a2, 20
     f3a:	12e8           	l32i.n	a14, a2, 4
     f3c:	83da80        	moveqz	a13, a10, a8
     f3f:	c08960        	sub	a8, a9, a6
     f42:	72dde0        	salt	a13, a13, a14
     f45:	608180        	abs	a8, a8
     f48:	72ff80        	salt	a15, a15, a8
     f4b:	9365f0        	movnez	a6, a5, a15
     f4e:	868d           	ae_sext16	a8, a6
     f50:	9385d0        	movnez	a8, a5, a13
     f53:	0a5282        	s16i	a8, a2, 20
     f56:	082d           	mov.n	a2, a8
     f58:	f01d           	retw.n

00000f5a <fn_pitch_detection+0x3d2>:
     f5a:	0a5262        	s16i	a6, a2, 20
     f5d:	062d           	mov.n	a2, a6
     f5f:	f01d           	retw.n

00000f61 <fn_pitch_detection+0x3d9>:
     f61:	0237a7        	bltu	a7, a10, f67 <fn_pitch_detection+0x3df>
     f64:	ffd606        	j	ec0 <fn_pitch_detection+0x338>
     f67:	ffd4c6        	j	ebe <fn_pitch_detection+0x336>

00000f6a <fn_pitch_detection+0x3e2>:
     f6a:	c337a7        	bltu	a7, a10, f31 <fn_pitch_detection+0x3a9>
     f6d:	ffe686        	j	f0b <fn_pitch_detection+0x383>

00000f70 <mel_filter16>:
     f70:	004136        	entry	a1, 32
     f73:	fec3b2        	addi	a11, a3, -2
     f76:	fc63c1        	l32r	a12, 104 (6c60 <all_amt_tab>)
     f79:	02dd           	mov.n	a13, a2
     f7b:	11e4c0        	slli	a14, a4, 4
     f7e:	ccea           	add.n	a12, a12, a14
     f80:	2c98           	l32i.n	a9, a12, 8
     f82:	2c2d           	ae_l16si.n	a2, a12, 0
     f84:	3c88           	l32i.n	a8, a12, 12
     f86:	1cc8           	l32i.n	a12, a12, 4
     f88:	3712a6        	blti	a2, 1, fc3 <mel_filter16+0x53>
     f8b:	90e290        	addx2	a14, a2, a9
     f8e:	fe2480007f 	{ movi	a7, 0; ae_zeroq56	aeq2 }
     f93:	fc145137cf 	{ addx2	a3, a7, a12; ae_movq56	aeq0, aeq2 }

00000f98 <mel_filter16+0x28>:
     f98:	282d           	ae_l16si.n	a2, a8, 0
     f9a:	409304        	ae_lp16f.iu	aep1, a3, 0
     f9d:	29ad           	ae_l16si.n	a10, a9, 0
     f9f:	9022d0        	addx2	a2, a2, a13
     fa2:	408204        	ae_lp16f.iu	aep0, a2, 0
     fa5:	07aa76        	loopgtz	a10, fb0 <mel_filter16+0x40>
     fa8:	e223ac821f 	{ ae_lp16f.iu	aep0, a2, 2; ae_mulafp24s.ll	aeq0, aep0, aep1 }
     fad:	409314        	ae_lp16f.iu	aep1, a3, 2

00000fb0 <mel_filter16+0x40>:
     fb0:	882b           	addi.n	a8, a8, 2
     fb2:	992b           	addi.n	a9, a9, 2
     fb4:	77aa           	add.n	a7, a7, a10
     fb6:	f8e39137cf 	{ addx2	a3, a7, a12; ae_roundsp16q48sym	aep0, aeq0 }
     fbb:	fc14728b1f 	{ ae_sp16f.l.iu	aep0, a11, 2; ae_movq56	aeq0, aeq2 }
     fc0:	d499e7        	bne	a9, a14, f98 <mel_filter16+0x28>

00000fc3 <mel_filter16+0x53>:
     fc3:	f01d           	retw.n

00000fc5 <mel_filter16+0x55>:
     fc5:	000000                                        ...

00000fc8 <fn_ini_st_noise_est>:
     fc8:	004136        	entry	a1, 32
     fcb:	02ad           	mov.n	a10, a2
     fcd:	fc4381        	l32r	a8, dc (2370 <LDNR_xt_memset>)
     fd0:	0b0c           	movi.n	a11, 0
     fd2:	60a3c2        	movi	a12, 0x360
     fd5:	0008e0        	callx8	a8
     fd8:	090c           	movi.n	a9, 0
     fda:	9ca4e2        	movi	a14, 0x49c
     fdd:	fc4ad1        	l32r	a13, 108 (ffffc400 <_end+0xffff571c>)
     fe0:	fc26c1        	l32r	a12, 78 (8000 <_end+0x131c>)
     fe3:	9b0c           	movi.n	a11, 9
     fe5:	06d2a2        	addmi	a10, a2, 0x600
     fe8:	70caa2        	addi	a10, a10, 112
     feb:	2eab76        	loopgtz	a11, 101d <fn_ini_st_noise_est+0x55>
     fee:	b92a           	add.n	a11, a9, a2
     ff0:	0ad9           	s32i.n	a13, a10, 0
     ff2:	30c992        	addi	a9, a9, 48
     ff5:	aa4b           	addi.n	a10, a10, 4
     ff7:	bbea           	add.n	a11, a11, a14
     ff9:	09ebc4        	ae_s32ip	a12, a11, 4
     ffc:	09ebc4        	ae_s32ip	a12, a11, 4
     fff:	09ebc4        	ae_s32ip	a12, a11, 4
    1002:	09ebc4        	ae_s32ip	a12, a11, 4
    1005:	09ebc4        	ae_s32ip	a12, a11, 4
    1008:	09ebc4        	ae_s32ip	a12, a11, 4
    100b:	09ebc4        	ae_s32ip	a12, a11, 4
    100e:	09ebc4        	ae_s32ip	a12, a11, 4
    1011:	09ebc4        	ae_s32ip	a12, a11, 4
    1014:	09ebc4        	ae_s32ip	a12, a11, 4
    1017:	09ebc4        	ae_s32ip	a12, a11, 4
    101a:	09ebc4        	ae_s32ip	a12, a11, 4

0000101d <fn_ini_st_noise_est+0x55>:
    101d:	03bd           	mov.n	a11, a3
    101f:	fc3081        	l32r	a8, e0 (2388 <LDNR_xt_memcpy>)
    1022:	02ad           	mov.n	a10, a2
    1024:	6c1c           	movi.n	a12, 22
    1026:	0008e0        	callx8	a8
    1029:	02ad           	mov.n	a10, a2
    102b:	2cc292        	addi	a9, a2, 44
    102e:	eda082        	movi	a8, 237
    1031:	048876        	loop	a8, 1039 <fn_ini_st_noise_est+0x71>
    1034:	aa88           	l32i.n	a8, a10, 40
    1036:	09e984        	ae_s32ip	a8, a9, 4
    1039:	f01d           	retw.n

0000103b <fn_ini_st_noise_est+0x73>:
	...

0000103c <fn_st_noise_est>:
    103c:	00c136        	entry	a1, 96
    103f:	f129           	s32i.n	a2, a1, 60
    1041:	0b0c           	movi.n	a11, 0
    1043:	070c           	movi.n	a7, 0
    1045:	a149           	s32i.n	a4, a1, 40
    1047:	8159           	s32i.n	a5, a1, 32
    1049:	c139           	s32i.n	a3, a1, 48
    104b:	05d282        	addmi	a8, a2, 0x500
    104e:	e189           	s32i.n	a8, a1, 56
    1050:	fc0a31        	l32r	a3, 78 (8000 <_end+0x131c>)
    1053:	fc2e51        	l32r	a5, 10c (6c70 <sb_ptn>)
    1056:	03d242        	addmi	a4, a2, 0x300
    1059:	df5872        	s16i	a7, a8, 0x1be
    105c:	b149           	s32i.n	a4, a1, 44
    105e:	047d           	mov.n	a7, a4
    1060:	fd2082444e 	{ addi	a4, a4, 36; ae_zerop48	aep2 }

00001065 <fn_st_noise_est+0x29>:
    1065:	25ad           	ae_l16si.n	a10, a5, 0
    1067:	359d           	ae_l16si.n	a9, a5, 2
    1069:	c188           	l32i.n	a8, a1, 48
    106b:	0061b2        	s32i	a11, a1, 0
    106e:	c099a0        	sub	a9, a9, a10
    1071:	a08a80        	addx4	a8, a10, a8
    1074:	508804        	ae_lp24f.iu	aep0, a8, 0
    1077:	04a0a2        	movi	a10, 4
    107a:	39baa4        	ae_movpa24x2	aep3, a10, a10
    107d:	0aa976        	loopgtz	a9, 108b <fn_st_noise_est+0x4f>
    1080:	d8616e881f 	{ ae_lp24f.iu	aep0, a8, 4; ae_addsp24s	aep1, aep0, aep3 }
    1085:	0f1194        	ae_sraip24	aep1, aep1, 3
    1088:	07a124        	ae_addsp24s	aep2, aep2, aep1

0000108b <fn_st_noise_est+0x4f>:
    108b:	522104        	ae_sp24f.l.i	aep2, a1, 0
    108e:	01a8           	l32i.n	a10, a1, 0
    1090:	fc1681        	l32r	a8, e8 (9e4 <fxlog10>)
    1093:	f03d           	nop.n
    1095:	21a8a0        	srai	a10, a10, 8
    1098:	0008e0        	callx8	a8
    109b:	fc1dc1        	l32r	a12, 110 (6a4d <mel_tab64+0x25d>)
    109e:	5e2792        	l32i	a9, a7, 0x178
    10a1:	d1cac0        	mul16s	a12, a10, a12
    10a4:	f128           	l32i.n	a2, a1, 60
    10a6:	90cc30        	addx2	a12, a12, a3
    10a9:	31c0c0        	srai	a12, a12, 16
    10ac:	4c67c2        	s32i	a12, a7, 0x130
    10af:	11ac00        	slli	a10, a12, 16
    10b2:	228d           	ae_l16si.n	a8, a2, 0
    10b4:	322d           	ae_l16si.n	a2, a2, 2
    10b6:	31b0c0        	srai	a11, a12, 16
    10b9:	7299c0        	salt	a9, a9, a12
    10bc:	932890        	movnez	a2, a8, a9
    10bf:	822d           	ae_sext16	a2, a2
    10c1:	ffa5a5        	call8	b1c <_saturate32>
    10c4:	4c27e2        	l32i	a14, a7, 0x130
    10c7:	5e27d2        	l32i	a13, a7, 0x178
    10ca:	0a6d           	mov.n	a6, a10
    10cc:	c0ade0        	sub	a10, a13, a14
    10cf:	ffa325        	call8	b00 <_saturate16>
    10d2:	d1d2a0        	mul16s	a13, a2, a10
    10d5:	31cf60        	srai	a12, a6, 31
    10d8:	90ad60        	addx2	a10, a13, a6
    10db:	62ba60        	saltu	a11, a10, a6
    10de:	11ddf0        	slli	a13, a13, 1
    10e1:	31dfd0        	srai	a13, a13, 31
    10e4:	ccda           	add.n	a12, a12, a13
    10e6:	bbca           	add.n	a11, a11, a12
    10e8:	ffa325        	call8	b1c <_saturate32>
    10eb:	5527c2        	l32i	a12, a7, 0x154
    10ee:	4c2792        	l32i	a9, a7, 0x130
    10f1:	f128           	l32i.n	a2, a1, 60
    10f3:	8a3a           	add.n	a8, a10, a3
    10f5:	318080        	srai	a8, a8, 16
    10f8:	5e6782        	s32i	a8, a7, 0x178
    10fb:	029282        	l16si	a8, a2, 4
    10fe:	31b090        	srai	a11, a9, 16
    1101:	039222        	l16si	a2, a2, 6
    1104:	11a900        	slli	a10, a9, 16
    1107:	7299c0        	salt	a9, a9, a12
    110a:	932890        	movnez	a2, a8, a9
    110d:	822d           	ae_sext16	a2, a2
    110f:	ffa0e5        	call8	b1c <_saturate32>
    1112:	4c27b2        	l32i	a11, a7, 0x130
    1115:	552792        	l32i	a9, a7, 0x154
    1118:	0a6d           	mov.n	a6, a10
    111a:	c0a9b0        	sub	a10, a9, a11
    111d:	ff9e25        	call8	b00 <_saturate16>
    1120:	d1d2a0        	mul16s	a13, a2, a10
    1123:	31cf60        	srai	a12, a6, 31
    1126:	90ad60        	addx2	a10, a13, a6
    1129:	62ba60        	saltu	a11, a10, a6
    112c:	11ddf0        	slli	a13, a13, 1
    112f:	31dfd0        	srai	a13, a13, 31
    1132:	ccda           	add.n	a12, a12, a13
    1134:	bbca           	add.n	a11, a11, a12
    1136:	ff9e65        	call8	b1c <_saturate32>
    1139:	ba3a           	add.n	a11, a10, a3
    113b:	5e27a2        	l32i	a10, a7, 0x178
    113e:	31b0b0        	srai	a11, a11, 16
    1141:	5567b2        	s32i	a11, a7, 0x154
    1144:	c0aab0        	sub	a10, a10, a11
    1147:	ff9ba5        	call8	b00 <_saturate16>
    114a:	f1c8           	l32i.n	a12, a1, 60
    114c:	049cc2        	l16si	a12, a12, 8
    114f:	13aca7        	bge	a12, a10, 1166 <fn_st_noise_est+0x12a>
    1152:	e1b8           	l32i.n	a11, a1, 56
    1154:	f1a8           	l32i.n	a10, a1, 60
    1156:	df9bb2        	l16si	a11, a11, 0x1be
    1159:	059aa2        	l16si	a10, a10, 10
    115c:	aaba           	add.n	a10, a10, a11
    115e:	ff9a25        	call8	b00 <_saturate16>
    1161:	e1c8           	l32i.n	a12, a1, 56
    1163:	df5ca2        	s16i	a10, a12, 0x1be

00001166 <fn_st_noise_est+0x12a>:
    1166:	552b           	addi.n	a5, a5, 2
    1168:	0b0c           	movi.n	a11, 0
    116a:	774b           	addi.n	a7, a7, 4
    116c:	fd2095d74f 	{ sub	a13, a7, a4; ae_zerop48	aep2 }
    1171:	ef0d56        	bnez	a13, 1065 <fn_st_noise_est+0x29>
    1174:	f128           	l32i.n	a2, a1, 60
    1176:	e188           	l32i.n	a8, a1, 56
    1178:	069252        	l16si	a5, a2, 12
    117b:	df9882        	l16si	a8, a8, 0x1be
    117e:	079222        	l16si	a2, a2, 14
    1181:	070c           	movi.n	a7, 0
    1183:	727780        	salt	a7, a7, a8
    1186:	932570        	movnez	a2, a5, a7
    1189:	822d           	ae_sext16	a2, a2
    118b:	b178           	l32i.n	a7, a1, 44
    118d:	950c           	movi.n	a5, 9
    118f:	000346        	j	11a0 <fn_st_noise_est+0x164>

00001192 <fn_st_noise_est+0x156>:
    1192:	fbddb1        	l32r	a11, 108 (ffffc400 <_end+0xffff571c>)

00001195 <fn_st_noise_est+0x159>:
    1195:	d367b2        	s32i	a11, a7, 0x34c
    1198:	550b           	addi.n	a5, a5, -1
    119a:	04c772        	addi	a7, a7, 4
    119d:	077516        	beqz	a5, 1218 <fn_st_noise_est+0x1dc>

000011a0 <fn_st_noise_est+0x164>:
    11a0:	4c27a2        	l32i	a10, a7, 0x130
    11a3:	404010        	ssai	16
    11a6:	31bfa0        	srai	a11, a10, 31
    11a9:	81bba0        	src	a11, a11, a10
    11ac:	11aa00        	slli	a10, a10, 16
    11af:	ff96e5        	call8	b1c <_saturate32>
    11b2:	4c27d2        	l32i	a13, a7, 0x130
    11b5:	d327c2        	l32i	a12, a7, 0x34c
    11b8:	0a6d           	mov.n	a6, a10
    11ba:	c0acd0        	sub	a10, a12, a13
    11bd:	ff9425        	call8	b00 <_saturate16>
    11c0:	4169           	s32i.n	a6, a1, 16
    11c2:	d1a2a0        	mul16s	a10, a2, a10
    11c5:	31cf60        	srai	a12, a6, 31
    11c8:	d1c9           	s32i.n	a12, a1, 52
    11ca:	11daf0        	slli	a13, a10, 1
    11cd:	90aa60        	addx2	a10, a10, a6
    11d0:	31dfd0        	srai	a13, a13, 31
    11d3:	ccda           	add.n	a12, a12, a13
    11d5:	62ba60        	saltu	a11, a10, a6
    11d8:	bbca           	add.n	a11, a11, a12
    11da:	ff9425        	call8	b1c <_saturate32>
    11dd:	fbca81        	l32r	a8, 108 (ffffc400 <_end+0xffff571c>)
    11e0:	80ba30        	add	a11, a10, a3
    11e3:	31b0b0        	srai	a11, a11, 16
    11e6:	a82b87        	blt	a11, a8, 1192 <fn_st_noise_est+0x156>
    11e9:	4c27b2        	l32i	a11, a7, 0x130
    11ec:	d327a2        	l32i	a10, a7, 0x34c
    11ef:	042162        	l32i	a6, a1, 16
    11f2:	c0aab0        	sub	a10, a10, a11
    11f5:	ff90a5        	call8	b00 <_saturate16>
    11f8:	d1d2a0        	mul16s	a13, a2, a10
    11fb:	d1c8           	l32i.n	a12, a1, 52
    11fd:	90ad60        	addx2	a10, a13, a6
    1200:	62ba60        	saltu	a11, a10, a6
    1203:	11ddf0        	slli	a13, a13, 1
    1206:	31dfd0        	srai	a13, a13, 31
    1209:	ccda           	add.n	a12, a12, a13
    120b:	bbca           	add.n	a11, a11, a12
    120d:	ff90e5        	call8	b1c <_saturate32>
    1210:	ba3a           	add.n	a11, a10, a3
    1212:	31b0b0        	srai	a11, a11, 16
    1215:	ffdf06        	j	1195 <fn_st_noise_est+0x159>

00001218 <fn_st_noise_est+0x1dc>:
    1218:	81c8           	l32i.n	a12, a1, 32
    121a:	157c16        	beqz	a12, 1375 <fn_st_noise_est+0x339>

0000121d <fn_st_noise_est+0x1e1>:
    121d:	b178           	l32i.n	a7, a1, 44
    121f:	020c           	movi.n	a2, 0

00001221 <fn_st_noise_est+0x1e5>:
    1221:	dc27b2        	l32i	a11, a7, 0x370
    1224:	d327a2        	l32i	a10, a7, 0x34c
    1227:	c0aab0        	sub	a10, a10, a11
    122a:	ff8d65        	call8	b00 <_saturate16>
    122d:	fbb9b1        	l32r	a11, 114 (e39 <fn_pitch_detection+0x2b1>)
    1230:	d1aab0        	mul16s	a10, a10, a11
    1233:	90aa30        	addx2	a10, a10, a3
    1236:	31a0a0        	srai	a10, a10, 16
    1239:	a2aa           	add.n	a10, a2, a10
    123b:	ff8c65        	call8	b00 <_saturate16>
    123e:	0a2d           	mov.n	a2, a10
    1240:	774b           	addi.n	a7, a7, 4
    1242:	db9747        	bne	a7, a4, 1221 <fn_st_noise_est+0x1e5>
    1245:	b178           	l32i.n	a7, a1, 44
    1247:	fbb531        	l32r	a3, 11c (6c90 <score_bands>)
    124a:	fbb351        	l32r	a5, 118 (6cb0 <vad_thrd_bands>)
    124d:	e1d8           	l32i.n	a13, a1, 56
    124f:	0c0c           	movi.n	a12, 0
    1251:	099582        	l16si	a8, a5, 18
    1254:	0f0c           	movi.n	a15, 0
    1256:	fb82e1        	l32r	a14, 60 (7fff <_end+0x131b>)
    1259:	c08a80        	sub	a8, a10, a8
    125c:	72ff80        	salt	a15, a15, a8
    125f:	93cef0        	movnez	a12, a14, a15
    1262:	de5dc2        	s16i	a12, a13, 0x1bc

00001265 <fn_st_noise_est+0x229>:
    1265:	dc27b2        	l32i	a11, a7, 0x370
    1268:	d327a2        	l32i	a10, a7, 0x34c
    126b:	c0aab0        	sub	a10, a10, a11
    126e:	ff8925        	call8	b00 <_saturate16>
    1271:	25cd           	ae_l16si.n	a12, a5, 0
    1273:	c0aac0        	sub	a10, a10, a12
    1276:	ff88a5        	call8	b00 <_saturate16>
    1279:	e567a2        	s32i	a10, a7, 0x394
    127c:	101aa6        	blti	a10, 1, 1290 <fn_st_noise_est+0x254>
    127f:	e1b8           	l32i.n	a11, a1, 56
    1281:	23ad           	ae_l16si.n	a10, a3, 0
    1283:	de9bb2        	l16si	a11, a11, 0x1bc
    1286:	aaba           	add.n	a10, a10, a11
    1288:	ff8765        	call8	b00 <_saturate16>
    128b:	e1c8           	l32i.n	a12, a1, 56
    128d:	de5ca2        	s16i	a10, a12, 0x1bc

00001290 <fn_st_noise_est+0x254>:
    1290:	332b           	addi.n	a3, a3, 2
    1292:	552b           	addi.n	a5, a5, 2
    1294:	774b           	addi.n	a7, a7, 4
    1296:	cb9747        	bne	a7, a4, 1265 <fn_st_noise_est+0x229>
    1299:	f1d8           	l32i.n	a13, a1, 60
    129b:	e188           	l32i.n	a8, a1, 56
    129d:	089dd2        	l16si	a13, a13, 16
    12a0:	de9882        	l16si	a8, a8, 0x1bc
    12a3:	0228d7        	blt	a8, a13, 12a9 <fn_st_noise_est+0x26d>
    12a6:	002306        	j	1336 <fn_st_noise_est+0x2fa>
    12a9:	f198           	l32i.n	a9, a1, 60
    12ab:	0a9992        	l16si	a9, a9, 20
    12ae:	072987        	blt	a9, a8, 12b9 <fn_st_noise_est+0x27d>
    12b1:	f1b8           	l32i.n	a11, a1, 60
    12b3:	6bb8           	l32i.n	a11, a11, 24
    12b5:	0003c6        	j	12c8 <fn_st_noise_est+0x28c>

000012b8 <fn_st_noise_est+0x27c>:
	...

000012b9 <fn_st_noise_est+0x27d>:
    12b9:	f1b8           	l32i.n	a11, a1, 60
    12bb:	7bc8           	l32i.n	a12, a11, 28
    12bd:	099bd2        	l16si	a13, a11, 18
    12c0:	8bb8           	l32i.n	a11, a11, 32
    12c2:	c0dd80        	sub	a13, a13, a8
    12c5:	b3bcd0        	movgez	a11, a12, a13

000012c8 <fn_st_noise_est+0x28c>:
    12c8:	b178           	l32i.n	a7, a1, 44
    12ca:	fb9051        	l32r	a5, 10c (6c70 <sb_ptn>)
    12cd:	2138b0        	srai	a3, a11, 8
    12d0:	00afd2        	movi	a13, 0xffffff00

000012d3 <fn_st_noise_est+0x297>:
    12d3:	e527c2        	l32i	a12, a7, 0x394
    12d6:	774b           	addi.n	a7, a7, 4
    12d8:	551ce6        	bgei	a12, 1, 1331 <fn_st_noise_est+0x2f5>
    12db:	c198           	l32i.n	a9, a1, 48
    12dd:	25fd           	ae_l16si.n	a15, a5, 0
    12df:	f1a8           	l32i.n	a10, a1, 60
    12e1:	35ed           	ae_l16si.n	a14, a5, 2
    12e3:	a09f90        	addx4	a9, a15, a9
    12e6:	a0afa0        	addx4	a10, a15, a10
    12e9:	28ca82        	addi	a8, a10, 40
    12ec:	605904        	ae_lq32f.iu	aeq1, a9, 0
    12ef:	2ccaa2        	addi	a10, a10, 44
    12f2:	601a04        	ae_lq32f.iu	aeq0, a10, 0
    12f5:	38afe7        	bge	a15, a14, 1331 <fn_st_noise_est+0x2f5>
    12f8:	36cd34        	ae_cvtq48a32s	aeq3, a13
    12fb:	01b1e4        	ae_andq56	aeq2, aeq1, aeq3
    12fe:	010ec4        	ae_subq56	aeq0, aeq0, aeq2
    1301:	f94262133f 	{ ae_movpa24x2	aep1, a3, a3; ae_truncp24q48x2	aep3, aeq0, aeq0 }
    1306:	013934        	ae_mulafp24s.ll	aeq1, aep3, aep1
    1309:	c0bef0        	sub	a11, a14, a15
    130c:	f96f8ffbbe 	{ addi	a11, a11, -1; ae_roundsp24q48asym	aep2, aeq1 }
    1311:	52a814        	ae_sp24f.l.iu	aep2, a8, 4
    1314:	601914        	ae_lq32f.iu	aeq0, a9, 4
    1317:	16ab76        	loopgtz	a11, 1331 <fn_st_noise_est+0x2f5>
    131a:	f95b3d5a1f 	{ ae_lq32f.iu	aeq2, a10, 4; ae_andq56	aeq1, aeq0, aeq3 }
    131f:	016dc4        	ae_subq56	aeq1, aeq2, aeq1
    1322:	099d04        	ae_truncp24q48x2	aep0, aeq1, aeq1
    1325:	010134        	ae_mulafp24s.ll	aeq0, aep0, aep1
    1328:	1b8d04        	ae_roundsp24q48asym	aep0, aeq0
    132b:	528814        	ae_sp24f.l.iu	aep0, a8, 4
    132e:	601914        	ae_lq32f.iu	aeq0, a9, 4
    1331:	552b           	addi.n	a5, a5, 2
    1333:	9c9747        	bne	a7, a4, 12d3 <fn_st_noise_est+0x297>

00001336 <fn_st_noise_est+0x2fa>:
    1336:	a188           	l32i.n	a8, a1, 40
    1338:	f198           	l32i.n	a9, a1, 60
    133a:	fcc882        	addi	a8, a8, -4
    133d:	99a8           	l32i.n	a10, a9, 36
    133f:	2cc992        	addi	a9, a9, 44
    1342:	508904        	ae_lp24f.iu	aep0, a9, 0
    1345:	21a8a0        	srai	a10, a10, 8
    1348:	39aaa4        	ae_movpa24x2	aep2, a10, a10
    134b:	eda0a2        	movi	a10, 237
    134e:	0e8a76        	loop	a10, 1360 <fn_st_noise_est+0x324>
    1351:	010274        	ae_mulfp24s.ll	aeq0, aep0, aep2
    1354:	1b8d14        	ae_roundsp24q48asym	aep1, aeq0
    1357:	079014        	ae_addsp24s	aep1, aep1, aep0
    135a:	529814        	ae_sp24f.l.iu	aep1, a8, 4
    135d:	508914        	ae_lp24f.iu	aep0, a9, 4

00001360 <fn_st_noise_est+0x324>:
    1360:	a188           	l32i.n	a8, a1, 40
    1362:	090c           	movi.n	a9, 0
    1364:	14a0a2        	movi	a10, 20
    1367:	04d882        	addmi	a8, a8, 0x400
    136a:	b4c882        	addi	a8, a8, -76
    136d:	028a76        	loop	a10, 1373 <fn_st_noise_est+0x337>
    1370:	09e894        	ae_s32ip	a9, a8, 4
    1373:	f01d           	retw.n

00001375 <fn_st_noise_est+0x339>:
    1375:	e1b8           	l32i.n	a11, a1, 56
    1377:	f1a8           	l32i.n	a10, a1, 60
    1379:	dc9b92        	l16si	a9, a11, 0x1b8
    137c:	0b9aa2        	l16si	a10, a10, 22
    137f:	991b           	addi.n	a9, a9, 1
    1381:	899d           	ae_sext16	a9, a9
    1383:	dc5b92        	s16i	a9, a11, 0x1b8
    1386:	02a9a7        	bge	a9, a10, 138c <fn_st_noise_est+0x350>
    1389:	007046        	j	154e <fn_st_noise_est+0x512>
    138c:	fb3591        	l32r	a9, 60 (7fff <_end+0x131b>)
    138f:	b178           	l32i.n	a7, a1, 44
    1391:	9d0c           	movi.n	a13, 9
    1393:	080c           	movi.n	a8, 0
    1395:	0e0c           	movi.n	a14, 0
    1397:	f1ab           	addi.n	a15, a1, 10
    1399:	91f9           	s32i.n	a15, a1, 36
    139b:	71e9           	s32i.n	a14, a1, 28
    139d:	dc5b82        	s16i	a8, a11, 0x1b8
    13a0:	61d9           	s32i.n	a13, a1, 24
    13a2:	080c           	movi.n	a8, 0
    13a4:	28cb           	addi.n	a2, a8, 12
    13a6:	03d772        	addmi	a7, a7, 0x300
    13a9:	70c772        	addi	a7, a7, 112
    13ac:	001e86        	j	142a <fn_st_noise_est+0x3ee>

000013af <fn_st_noise_est+0x373>:
    13af:	00000000 b9b00000                                ......

000013b5 <fn_st_noise_est+0x379>:
    13b5:	c0b9b0        	sub	a11, a9, a11
    13b8:	11cb16        	beqz	a11, 14d8 <fn_st_noise_est+0x49c>

000013bb <fn_st_noise_est+0x37f>:
    13bb:	c0ccd0        	sub	a12, a12, a13
    13be:	11fc16        	beqz	a12, 14e1 <fn_st_noise_est+0x4a5>

000013c1 <fn_st_noise_est+0x385>:
    13c1:	31df90        	srai	a13, a9, 31
    13c4:	31cf80        	srai	a12, a8, 31
    13c7:	a89a           	add.n	a10, a8, a9
    13c9:	62ba80        	saltu	a11, a10, a8
    13cc:	ccda           	add.n	a12, a12, a13
    13ce:	bbca           	add.n	a11, a11, a12
    13d0:	ff74a5        	call8	b1c <_saturate32>
    13d3:	0691b2        	l16si	a11, a1, 12
    13d6:	31dfa0        	srai	a13, a10, 31
    13d9:	31cfb0        	srai	a12, a11, 31
    13dc:	ccda           	add.n	a12, a12, a13
    13de:	abaa           	add.n	a10, a11, a10
    13e0:	62bab0        	saltu	a11, a10, a11
    13e3:	bbca           	add.n	a11, a11, a12
    13e5:	ff7365        	call8	b1c <_saturate32>
    13e8:	0791b2        	l16si	a11, a1, 14
    13eb:	31dfa0        	srai	a13, a10, 31
    13ee:	31cfb0        	srai	a12, a11, 31
    13f1:	ccda           	add.n	a12, a12, a13
    13f3:	abaa           	add.n	a10, a11, a10
    13f5:	62bab0        	saltu	a11, a10, a11
    13f8:	bbca           	add.n	a11, a11, a12
    13fa:	ff7225        	call8	b1c <_saturate32>
    13fd:	404200        	ssai	2
    1400:	31cfa0        	srai	a12, a10, 31
    1403:	ba2b           	addi.n	a11, a10, 2
    1405:	62aba0        	saltu	a10, a11, a10
    1408:	aaca           	add.n	a10, a10, a12
    140a:	81aab0        	src	a10, a10, a11
    140d:	ff6f25        	call8	b00 <_saturate16>
    1410:	09e7a4        	ae_s32ip	a10, a7, 4
    1413:	fb1391        	l32r	a9, 60 (7fff <_end+0x131b>)
    1416:	5188           	l32i.n	a8, a1, 20
    1418:	61d8           	l32i.n	a13, a1, 24
    141a:	71e8           	l32i.n	a14, a1, 28
    141c:	28cb           	addi.n	a2, a8, 12
    141e:	dd0b           	addi.n	a13, a13, -1
    1420:	30cee2        	addi	a14, a14, 48
    1423:	71e9           	s32i.n	a14, a1, 28
    1425:	61d9           	s32i.n	a13, a1, 24
    1427:	0bfd16        	beqz	a13, 14ea <fn_st_noise_est+0x4ae>

0000142a <fn_st_noise_est+0x3ee>:
    142a:	5129           	s32i.n	a2, a1, 20
    142c:	f1a8           	l32i.n	a10, a1, 60
    142e:	7158           	l32i.n	a5, a1, 28
    1430:	065192        	s16i	a9, a1, 12
    1433:	e1f8           	l32i.n	a15, a1, 56
    1435:	055192        	s16i	a9, a1, 10
    1438:	045192        	s16i	a9, a1, 8
    143b:	dd9ff2        	l16si	a15, a15, 0x1ba
    143e:	55aa           	add.n	a5, a5, a10
    1440:	a022a0        	addx4	a2, a2, a10
    1443:	03d222        	addmi	a2, a2, 0x300
    1446:	03d552        	addmi	a5, a5, 0x300
    1449:	a0c552        	addi	a5, a5, -96
    144c:	a0c222        	addi	a2, a2, -96
    144f:	ff8a           	add.n	a15, a15, a8
    1451:	a0ffa0        	addx4	a15, a15, a10
    1454:	03dff2        	addmi	a15, a15, 0x300
    1457:	a0cff2        	addi	a15, a15, -96
    145a:	7f2ff2        	l32i	a15, a15, 0x1fc
    145d:	0751f2        	s16i	a15, a1, 14

00001460 <fn_st_noise_est+0x424>:
    1460:	0791a2        	l16si	a10, a1, 14
    1463:	7f2582        	l32i	a8, a5, 0x1fc
    1466:	0691b2        	l16si	a11, a1, 12
    1469:	1428a7        	blt	a8, a10, 1481 <fn_st_noise_est+0x445>
    146c:	2628b7        	blt	a8, a11, 1496 <fn_st_noise_est+0x45a>
    146f:	059192        	l16si	a9, a1, 10
    1472:	0491a2        	l16si	a10, a1, 8
    1475:	32a897        	bge	a8, a9, 14ab <fn_st_noise_est+0x46f>
    1478:	045192        	s16i	a9, a1, 8
    147b:	055182        	s16i	a8, a1, 10
    147e:	000bc6        	j	14b1 <fn_st_noise_est+0x475>

00001481 <fn_st_noise_est+0x445>:
    1481:	a18b           	addi.n	a10, a1, 8
    1483:	fb1781        	l32r	a8, e0 (2388 <LDNR_xt_memcpy>)
    1486:	91b8           	l32i.n	a11, a1, 36
    1488:	3c0c           	movi.n	a12, 3
    148a:	0008e0        	callx8	a8
    148d:	7f2592        	l32i	a9, a5, 0x1fc
    1490:	075192        	s16i	a9, a1, 14
    1493:	000686        	j	14b1 <fn_st_noise_est+0x475>

00001496 <fn_st_noise_est+0x45a>:
    1496:	a18b           	addi.n	a10, a1, 8
    1498:	fb1281        	l32r	a8, e0 (2388 <LDNR_xt_memcpy>)
    149b:	91b8           	l32i.n	a11, a1, 36
    149d:	2c0c           	movi.n	a12, 2
    149f:	0008e0        	callx8	a8
    14a2:	7f2592        	l32i	a9, a5, 0x1fc
    14a5:	065192        	s16i	a9, a1, 12
    14a8:	000146        	j	14b1 <fn_st_noise_est+0x475>

000014ab <fn_st_noise_est+0x46f>:
    14ab:	43a8a0        	min	a10, a8, a10
    14ae:	0451a2        	s16i	a10, a1, 8
    14b1:	554b           	addi.n	a5, a5, 4
    14b3:	a99527        	bne	a5, a2, 1460 <fn_st_noise_est+0x424>
    14b6:	faead1        	l32r	a13, 60 (7fff <_end+0x131b>)
    14b9:	0691c2        	l16si	a12, a1, 12
    14bc:	fae9a1        	l32r	a10, 60 (7fff <_end+0x131b>)
    14bf:	049182        	l16si	a8, a1, 8
    14c2:	fae7b1        	l32r	a11, 60 (7fff <_end+0x131b>)
    14c5:	059192        	l16si	a9, a1, 10
    14c8:	c0a8a0        	sub	a10, a8, a10
    14cb:	ee6a56        	bnez	a10, 13b5 <fn_st_noise_est+0x379>
    14ce:	079182        	l16si	a8, a1, 14
    14d1:	045182        	s16i	a8, a1, 8
    14d4:	ffb746        	j	13b5 <fn_st_noise_est+0x379>

000014d7 <fn_st_noise_est+0x49b>:
	...

000014d8 <fn_st_noise_est+0x49c>:
    14d8:	079192        	l16si	a9, a1, 14
    14db:	055192        	s16i	a9, a1, 10
    14de:	ffb646        	j	13bb <fn_st_noise_est+0x37f>

000014e1 <fn_st_noise_est+0x4a5>:
    14e1:	0791b2        	l16si	a11, a1, 14
    14e4:	0651b2        	s16i	a11, a1, 12
    14e7:	ffb586        	j	13c1 <fn_st_noise_est+0x385>

000014ea <fn_st_noise_est+0x4ae>:
    14ea:	e1d8           	l32i.n	a13, a1, 56
    14ec:	dd9dc2        	l16si	a12, a13, 0x1ba
    14ef:	cc1b           	addi.n	a12, a12, 1
    14f1:	8ccd           	ae_sext16	a12, a12
    14f3:	dd5dc2        	s16i	a12, a13, 0x1ba
    14f6:	06aca6        	blti	a12, 12, 1500 <fn_st_noise_est+0x4c4>
    14f9:	e1e8           	l32i.n	a14, a1, 56
    14fb:	0d0c           	movi.n	a13, 0
    14fd:	dd5ed2        	s16i	a13, a14, 0x1ba

00001500 <fn_st_noise_est+0x4c4>:
    1500:	a0a2f2        	movi	a15, 0x2a0
    1503:	c90c           	movi.n	a9, 12
    1505:	480c           	movi.n	a8, 4
    1507:	e1e8           	l32i.n	a14, a1, 56
    1509:	b1a8           	l32i.n	a10, a1, 44
    150b:	f1d8           	l32i.n	a13, a1, 60
    150d:	dd9ec2        	l16si	a12, a14, 0x1ba
    1510:	d32ab2        	l32i	a11, a10, 0x34c
    1513:	aa4b           	addi.n	a10, a10, 4
    1515:	a0ccd0        	addx4	a12, a12, a13
    1518:	03dcc2        	addmi	a12, a12, 0x300
    151b:	a0ccc2        	addi	a12, a12, -96
    151e:	7f6cb2        	s32i	a11, a12, 0x1fc
    1521:	268876        	loop	a8, 154b <fn_st_noise_est+0x50f>
    1524:	dd9e82        	l16si	a8, a14, 0x1ba
    1527:	d32ab2        	l32i	a11, a10, 0x34c
    152a:	c9cb           	addi.n	a12, a9, 12
    152c:	aa8b           	addi.n	a10, a10, 8
    152e:	889a           	add.n	a8, a8, a9
    1530:	a088d0        	addx4	a8, a8, a13
    1533:	88fa           	add.n	a8, a8, a15
    1535:	7f68b2        	s32i	a11, a8, 0x1fc
    1538:	dd9e82        	l16si	a8, a14, 0x1ba
    153b:	18c992        	addi	a9, a9, 24
    153e:	d22ab2        	l32i	a11, a10, 0x348
    1541:	88ca           	add.n	a8, a8, a12
    1543:	a088d0        	addx4	a8, a8, a13
    1546:	88fa           	add.n	a8, a8, a15
    1548:	7f68b2        	s32i	a11, a8, 0x1fc

0000154b <fn_st_noise_est+0x50f>:
    154b:	ff3386        	j	121d <fn_st_noise_est+0x1e1>

0000154e <fn_st_noise_est+0x512>:
    154e:	090c           	movi.n	a9, 0
    1550:	f1d8           	l32i.n	a13, a1, 60
    1552:	0bed           	mov.n	a14, a11
    1554:	a0a2f2        	movi	a15, 0x2a0
    1557:	0b21a2        	l32i	a10, a1, 44
    155a:	09a082        	movi	a8, 9
    155d:	198876        	loop	a8, 157a <fn_st_noise_est+0x53e>
    1560:	dd9e82        	l16si	a8, a14, 0x1ba
    1563:	d32ab2        	l32i	a11, a10, 0x34c
    1566:	aa4b           	addi.n	a10, a10, 4
    1568:	889a           	add.n	a8, a8, a9
    156a:	a088d0        	addx4	a8, a8, a13
    156d:	88fa           	add.n	a8, a8, a15
    156f:	7f28c2        	l32i	a12, a8, 0x1fc
    1572:	99cb           	addi.n	a9, a9, 12
    1574:	43bcb0        	min	a11, a12, a11
    1577:	7f68b2        	s32i	a11, a8, 0x1fc

0000157a <fn_st_noise_est+0x53e>:
    157a:	ff27c6        	j	121d <fn_st_noise_est+0x1e1>

0000157d <fn_st_noise_est+0x541>:
    157d:	000000                                        ...

00001580 <fn_ini_calc_sup_gain>:
    1580:	004136        	entry	a1, 32
    1583:	02ad           	mov.n	a10, a2
    1585:	fad581        	l32r	a8, dc (2370 <LDNR_xt_memset>)
    1588:	00a0b2        	movi	a11, 0
    158b:	08a2c2        	movi	a12, 0x208
    158e:	0008e0        	callx8	a8
    1591:	03bd           	mov.n	a11, a3
    1593:	fad381        	l32r	a8, e0 (2388 <LDNR_xt_memcpy>)
    1596:	02ad           	mov.n	a10, a2
    1598:	4c0c           	movi.n	a12, 4
    159a:	0008e0        	callx8	a8
    159d:	828b           	addi.n	a8, a2, 8
    159f:	00a192        	movi	a9, 0x100
    15a2:	01a1a2        	movi	a10, 0x101
    15a5:	028a76        	loop	a10, 15ab <fn_ini_calc_sup_gain+0x2b>
    15a8:	09e894        	ae_s32ip	a9, a8, 4

000015ab <fn_ini_calc_sup_gain+0x2b>:
    15ab:	04d292        	addmi	a9, a2, 0x400
    15ae:	3949           	s32i.n	a4, a9, 12
    15b0:	f01d           	retw.n

000015b2 <fn_ini_calc_sup_gain+0x32>:
	...

000015b4 <fn_calc_sup_gain>:
    15b4:	018136        	entry	a1, 192
    15b7:	229d           	ae_l16si.n	a9, a2, 0
    15b9:	860b           	addi.n	a8, a6, -1
    15bb:	229816        	beqz	a8, 17e8 <fn_calc_sup_gain+0x234>
    15be:	fec6b2        	addi	a11, a6, -2
    15c1:	53eb16        	beqz	a11, 1b03 <fn_calc_sup_gain+0x54f>
    15c4:	fdc6c2        	addi	a12, a6, -3
    15c7:	54ac16        	beqz	a12, 1b15 <fn_calc_sup_gain+0x561>
    15ca:	fcc6d2        	addi	a13, a6, -4
    15cd:	557d16        	beqz	a13, 1b28 <fn_calc_sup_gain+0x574>
    15d0:	567916        	beqz	a9, 1b3b <fn_calc_sup_gain+0x587>
    15d3:	ffc9e2        	addi	a14, a9, -1
    15d6:	21fe16        	beqz	a14, 17f9 <fn_calc_sup_gain+0x245>
    15d9:	0a0c           	movi.n	a10, 0
    15db:	01a1f2        	movi	a15, 0x101
    15de:	0761f2        	s32i	a15, a1, 28

000015e1 <fn_calc_sup_gain+0x2d>:
    15e1:	a06a30        	addx4	a6, a10, a3
    15e4:	78c182        	addi	a8, a1, 120
    15e7:	0292b2        	l16si	a11, a2, 4
    15ea:	329d           	ae_l16si.n	a9, a2, 2
    15ec:	a07a20        	addx4	a7, a10, a2
    15ef:	a04a40        	addx4	a4, a10, a4
    15f2:	509404        	ae_lp24f.iu	aep1, a4, 0
    15f5:	778b           	addi.n	a7, a7, 8
    15f7:	3009b4        	ae_cvtp24a16x2.ll	aep0, a9, a11
    15fa:	5608b4        	ae_sp24x2s.i	aep0, a8, -40
    15fd:	7188           	l32i.n	a8, a1, 28
    15ff:	50a704        	ae_lp24f.iu	aep2, a7, 0
    1602:	fc24ae860f 	{ ae_lp24f.iu	aep0, a6, 0; ae_zeroq56	aeq0 }
    1607:	022a87        	blt	a10, a8, 160d <fn_calc_sup_gain+0x59>
    160a:	013cc6        	j	1b01 <fn_calc_sup_gain+0x54d>
    160d:	0a4184        	ae_cvtq48p24s.l	aeq1, aep1
    1610:	fe0c113a5f 	{ addx2	a3, a10, a5; ae_cvtq48p24s.l	aeq2, aep0 }
    1615:	fa36d1585f 	{ addx2	a5, a8, a5; ae_subq56	aeq2, aeq2, aeq1 }

0000161a <fn_calc_sup_gain+0x66>:
    161a:	06ca44        	ae_satq48s	aeq3, aeq2
    161d:	098304        	ae_ltq56s	b0, aeq3, aeq0
    1620:	0304e0        	rsr.br	a14
    1623:	d4447f01bf 	{ ae_movq56	aeq2, aeq0; ae_eqq56	b1, aeq1, aeq0 }
    1628:	04e0e0        	extui	a14, a14, 0, 1
    162b:	1ecc           	bnez.n	a14, 1630 <fn_calc_sup_gain+0x7c>
    162d:	06bb34        	ae_movq56	aeq2, aeq3

00001630 <fn_calc_sup_gain+0x7c>:
    1630:	78c182        	addi	a8, a1, 120
    1633:	021176        	bt	b1, 1639 <fn_calc_sup_gain+0x85>
    1636:	0024c6        	j	16cd <fn_calc_sup_gain+0x119>
    1639:	090c           	movi.n	a9, 0
    163b:	0a0c           	movi.n	a10, 0

0000163d <fn_calc_sup_gain+0x89>:
    163d:	11e980        	slli	a14, a9, 8
    1640:	5438b4        	ae_lp24x2.i	aep3, a8, -40
    1643:	304aa4        	ae_cvtp24a16x2.ll	aep4, a10, a10
    1646:	e97098a99f 	{ ae_cvtp24a16x2.ll	aep2, a9, a9; ae_mulfp24s.hh	aeq2, aep4, aep3 }
    164b:	01a334        	ae_mulafp24s.ll	aeq2, aep2, aep3
    164e:	fa8af1        	l32r	a15, 78 (8000 <_end+0x131c>)
    1651:	1bad14        	ae_roundsp24q48asym	aep1, aeq2
    1654:	e824fecfff 	{ ae_cvtq48a32s	aeq3, a15; ae_mulfp24s.hh	aeq1, aep1, aep1 }
    1659:	fc2c3ecebf 	{ ae_cvtq48a32s	aeq2, a14; ae_cvtq48p24s.l	aeq0, aep1 }
    165e:	faf63b020f 	{ ae_sraiq56	aeq0, aeq0, 8; ae_addq56	aeq2, aeq2, aeq3 }
    1663:	01cbc4        	ae_addq56	aeq3, aeq0, aeq3
    1666:	065934        	ae_roundsq32asym	aeq1, aeq1
    1669:	f8663a08df 	{ ae_sq56s.i	aeq0, a8, -24; ae_addq56	aeq0, aeq0, aeq1 }
    166e:	ff00fa38ef 	{ ae_sq56s.i	aeq3, a8, -16; ae_satq48s	aeq3, aeq0 }
    1673:	fc248000af 	{ movi	a10, 0; ae_zeroq56	aeq0 }
    1678:	d4c23b32cf 	{ ae_sraiq56	aeq3, aeq3, 8; ae_eqq56	b8, aeq2, aeq0 }
    167d:	ff3c7d88ef 	{ ae_lq56.i	aeq0, a8, -16; ae_roundsq32asym	aeq3, aeq3 }
    1682:	d5db3a08ef 	{ ae_sq56s.i	aeq0, a8, -16; ae_leq56s	b12, aeq2, aeq3 }
    1687:	021876        	bt	b8, 168d <fn_calc_sup_gain+0xd9>
    168a:	002ac6        	j	1739 <fn_calc_sup_gain+0x185>
    168d:	5608f4        	ae_sp24x2s.i	aep0, a8, -8

00001690 <fn_calc_sup_gain+0xdc>:
    1690:	faa481        	l32r	a8, 120 (974 <fxsqrt_ld>)
    1693:	3550f4        	ae_sraiq56	aeq1, aeq1, 3
    1696:	360a34        	ae_cvtq48a32s	aeq0, a10
    1699:	ff2c7a811f 	{ ae_slliq56	aeq0, aeq0, 5; ae_roundsq32asym	aeq3, aeq1 }
    169e:	01f8c4        	ae_addq56	aeq3, aeq3, aeq0
    16a1:	36ba04        	ae_trunca32q48	a10, aeq3
    16a4:	0008e0        	callx8	a8
    16a7:	78c1b2        	addi	a11, a1, 120
    16aa:	614be4        	ae_lq56.i	aeq1, a11, -16
    16ad:	fc24ba905f 	{ ae_slliq56	aeq1, aeq1, 1; ae_zeroq56	aeq0 }
    16b2:	064944        	ae_satq48s	aeq1, aeq1
    16b5:	d4464000cf 	{ movi	a12, 0; ae_eqq56	b9, aeq1, aeq0 }
    16ba:	540bf4        	ae_lp24x2.i	aep0, a11, -8
    16bd:	618bd4        	ae_lq56.i	aeq2, a11, -24
    16c0:	021976        	bt	b9, 16c6 <fn_calc_sup_gain+0x112>
    16c3:	002a46        	j	1770 <fn_calc_sup_gain+0x1bc>
    16c6:	0a0c           	movi.n	a10, 0
    16c8:	63cd           	ae_s16i.n	a12, a3, 0
    16ca:	003946        	j	17b3 <fn_calc_sup_gain+0x1ff>

000016cd <fn_calc_sup_gain+0x119>:
    16cd:	35a234        	ae_sraiq56	aeq2, aeq2, 8
    16d0:	09a5a4        	ae_leq56s	b10, aeq1, aeq2
    16d3:	365b04        	ae_nsaq56s	a11, aeq1
    16d6:	fa6291        	l32r	a9, 60 (7fff <_end+0x131b>)
    16d9:	030a76        	bf	b10, 16e0 <fn_calc_sup_gain+0x12c>
    16dc:	000846        	j	1701 <fn_calc_sup_gain+0x14d>

000016df <fn_calc_sup_gain+0x12b>:
	...

000016e0 <fn_calc_sup_gain+0x12c>:
    16e0:	f8cbb2        	addi	a11, a11, -8
    16e3:	8bbd           	ae_sext16	a11, a11
    16e5:	fc24feabcf 	{ ae_slaasq56s	aeq3, aeq2, a11; nop }
    16ea:	fe84cf1bbe 	{ addi	a11, a11, -15; ae_satq48s	aeq2, aeq3 }
    16ef:	fc24fe9bcf 	{ ae_slaasq56s	aeq3, aeq1, a11; nop }
    16f4:	fe84ff29ef 	{ ae_trunca32q48	a9, aeq2; ae_satq48s	aeq2, aeq3 }
    16f9:	36aa04        	ae_trunca32q48	a10, aeq2
    16fc:	d299a0        	quos	a9, a9, a10
    16ff:	a99d           	ae_clamps16	a9, a9

00001701 <fn_calc_sup_gain+0x14d>:
    1701:	fe4c3f1caf 	{ ae_nsaq56s	a12, aeq1; ae_cvtq48p24s.l	aeq2, aep2 }
    1706:	35a234        	ae_sraiq56	aeq2, aeq2, 8
    1709:	09a5b4        	ae_leq56s	b11, aeq1, aeq2
    170c:	fa55a1        	l32r	a10, 60 (7fff <_end+0x131b>)
    170f:	f8ccc2        	addi	a12, a12, -8
    1712:	020b76        	bf	b11, 1718 <fn_calc_sup_gain+0x164>
    1715:	ffc906        	j	163d <fn_calc_sup_gain+0x89>

00001718 <fn_calc_sup_gain+0x164>:
    1718:	8ccd           	ae_sext16	a12, a12
    171a:	fc24feaccf 	{ ae_slaasq56s	aeq3, aeq2, a12; nop }
    171f:	fe84cf1cce 	{ addi	a12, a12, -15; ae_satq48s	aeq2, aeq3 }
    1724:	fc24fe9ccf 	{ ae_slaasq56s	aeq3, aeq1, a12; nop }
    1729:	fe84ff2aef 	{ ae_trunca32q48	a10, aeq2; ae_satq48s	aeq2, aeq3 }
    172e:	36ab04        	ae_trunca32q48	a11, aeq2
    1731:	d2aab0        	quos	a10, a10, a11
    1734:	aaad           	ae_clamps16	a10, a10
    1736:	ffc0c6        	j	163d <fn_calc_sup_gain+0x89>

00001739 <fn_calc_sup_gain+0x185>:
    1739:	080c76        	bf	b12, 1745 <fn_calc_sup_gain+0x191>
    173c:	fa49a1        	l32r	a10, 60 (7fff <_end+0x131b>)
    173f:	5608f4        	ae_sp24x2s.i	aep0, a8, -8
    1742:	ffd286        	j	1690 <fn_calc_sup_gain+0xdc>

00001745 <fn_calc_sup_gain+0x191>:
    1745:	366c04        	ae_nsaq56s	a12, aeq2
    1748:	f8ccc2        	addi	a12, a12, -8
    174b:	8ccd           	ae_sext16	a12, a12
    174d:	fc24febccf 	{ ae_slaasq56s	aeq3, aeq3, a12; nop }
    1752:	ff84cf1cce 	{ addi	a12, a12, -15; ae_satq48s	aeq3, aeq3 }
    1757:	36ba04        	ae_trunca32q48	a10, aeq3
    175a:	fc24feaccf 	{ ae_slaasq56s	aeq3, aeq2, a12; nop }
    175f:	06cb44        	ae_satq48s	aeq3, aeq3
    1762:	36bb04        	ae_trunca32q48	a11, aeq3
    1765:	5608f4        	ae_sp24x2s.i	aep0, a8, -8
    1768:	d2aab0        	quos	a10, a10, a11
    176b:	aaad           	ae_clamps16	a10, a10
    176d:	ffc7c6        	j	1690 <fn_calc_sup_gain+0xdc>

00001770 <fn_calc_sup_gain+0x1bc>:
    1770:	11ea70        	slli	a14, a10, 9
    1773:	36ce34        	ae_cvtq48a32s	aeq3, a14
    1776:	01abc4        	ae_addq56	aeq2, aeq2, aeq3
    1779:	068a44        	ae_satq48s	aeq2, aeq2
    177c:	09a5d4        	ae_leq56s	b13, aeq1, aeq2
    177f:	fa38f1        	l32r	a15, 60 (7fff <_end+0x131b>)
    1782:	fa37a1        	l32r	a10, 60 (7fff <_end+0x131b>)
    1785:	040d76        	bf	b13, 178d <fn_calc_sup_gain+0x1d9>
    1788:	63fd           	ae_s16i.n	a15, a3, 0
    178a:	000946        	j	17b3 <fn_calc_sup_gain+0x1ff>

0000178d <fn_calc_sup_gain+0x1d9>:
    178d:	365c04        	ae_nsaq56s	a12, aeq1
    1790:	f8ccc2        	addi	a12, a12, -8
    1793:	8ccd           	ae_sext16	a12, a12
    1795:	fc24feaccf 	{ ae_slaasq56s	aeq3, aeq2, a12; nop }
    179a:	fe84cf1cce 	{ addi	a12, a12, -15; ae_satq48s	aeq2, aeq3 }
    179f:	fc24fe9ccf 	{ ae_slaasq56s	aeq3, aeq1, a12; nop }
    17a4:	fe84ff2aef 	{ ae_trunca32q48	a10, aeq2; ae_satq48s	aeq2, aeq3 }
    17a9:	36ab04        	ae_trunca32q48	a11, aeq2
    17ac:	d2aab0        	quos	a10, a10, a11
    17af:	aaad           	ae_clamps16	a10, a10
    17b1:	63ad           	ae_s16i.n	a10, a3, 0
    17b3:	0392b2        	l16si	a11, a2, 6
    17b6:	03aab7        	bge	a10, a11, 17bd <fn_calc_sup_gain+0x209>
    17b9:	63bd           	ae_s16i.n	a11, a3, 0
    17bb:	0bad           	mov.n	a10, a11

000017bd <fn_calc_sup_gain+0x209>:
    17bd:	307aa4        	ae_cvtp24a16x2.ll	aep7, a10, a10
    17c0:	01f774        	ae_mulfp24s.ll	aeq2, aep7, aep7
    17c3:	1bad64        	ae_roundsp24q48asym	aep6, aeq2
    17c6:	016874        	ae_mulfp24s.ll	aeq1, aep6, aep0
    17c9:	fa6fc0233e 	{ addi	a3, a3, 2; ae_roundsp24q48asym	aep5, aeq1 }
    17ce:	52d704        	ae_sp24f.l.iu	aep5, a7, 0
    17d1:	509414        	ae_lp24f.iu	aep1, a4, 4
    17d4:	fd2c2e861f 	{ ae_lp24f.iu	aep0, a6, 4; ae_cvtq48p24s.l	aeq1, aep1 }
    17d9:	fe0c15d35f 	{ sub	a13, a3, a5; ae_cvtq48p24s.l	aeq2, aep0 }
    17de:	fa36eea71f 	{ ae_lp24f.iu	aep2, a7, 4; ae_subq56	aeq2, aeq2, aeq1 }
    17e3:	e33d56        	bnez	a13, 161a <fn_calc_sup_gain+0x66>
    17e6:	f01d           	retw.n

000017e8 <fn_calc_sup_gain+0x234>:
    17e8:	3e8916        	beqz	a9, 1bd4 <fn_calc_sup_gain+0x620>
    17eb:	e90b           	addi.n	a14, a9, -1
    17ed:	3f7e16        	beqz	a14, 1be8 <fn_calc_sup_gain+0x634>
    17f0:	0a0c           	movi.n	a10, 0
    17f2:	0f4c           	movi.n	a15, 64
    17f4:	71f9           	s32i.n	a15, a1, 28
    17f6:	ff79c6        	j	15e1 <fn_calc_sup_gain+0x2d>

000017f9 <fn_calc_sup_gain+0x245>:
    17f9:	0a0c           	movi.n	a10, 0
    17fb:	01a182        	movi	a8, 0x101
    17fe:	7189           	s32i.n	a8, a1, 28

00001800 <fn_calc_sup_gain+0x24c>:
    1800:	a04a40        	addx4	a4, a10, a4
    1803:	fa1d71        	l32r	a7, 78 (8000 <_end+0x131c>)
    1806:	7168           	l32i.n	a6, a1, 28
    1808:	a0fa20        	addx4	a15, a10, a2
    180b:	ff8b           	addi.n	a15, a15, 8
    180d:	1061f2        	s32i	a15, a1, 64
    1810:	a06630        	addx4	a6, a6, a3
    1813:	6169           	s32i.n	a6, a1, 24
    1815:	a03a30        	addx4	a3, a10, a3
    1818:	5139           	s32i.n	a3, a1, 20
    181a:	fa4261        	l32r	a6, 124 (800000 <_end+0x7f931c>)
    181d:	903a50        	addx2	a3, a10, a5
    1820:	fa4251        	l32r	a5, 128 (7fffff00 <_end+0x7fff921c>)

00001823 <fn_calc_sup_gain+0x26f>:
    1823:	51b8           	l32i.n	a11, a1, 20
    1825:	04a8           	l32i.n	a10, a4, 0
    1827:	0bb8           	l32i.n	a11, a11, 0
    1829:	31dfa0        	srai	a13, a10, 31
    182c:	c0aba0        	sub	a10, a11, a10
    182f:	62cba0        	saltu	a12, a11, a10
    1832:	31bfb0        	srai	a11, a11, 31
    1835:	c0bbd0        	sub	a11, a11, a13
    1838:	c0bbc0        	sub	a11, a11, a12
    183b:	ff2e25        	call8	b1c <_saturate32>
    183e:	0abd           	mov.n	a11, a10
    1840:	fa3b81        	l32r	a8, 12c (334 <fxdiv32>)
    1843:	0a0c           	movi.n	a10, 0
    1845:	53aab0        	max	a10, a10, a11
    1848:	21a8a0        	srai	a10, a10, 8
    184b:	04b8           	l32i.n	a11, a4, 0
    184d:	0008e0        	callx8	a8
    1850:	102192        	l32i	a9, a1, 64
    1853:	81a9           	s32i.n	a10, a1, 32
    1855:	0998           	l32i.n	a9, a9, 0
    1857:	fa3581        	l32r	a8, 12c (334 <fxdiv32>)
    185a:	04b8           	l32i.n	a11, a4, 0
    185c:	21a890        	srai	a10, a9, 8
    185f:	0008e0        	callx8	a8
    1862:	404f10        	ssai	31
    1865:	32dd           	ae_l16si.n	a13, a2, 2
    1867:	11ea00        	slli	a14, a10, 16
    186a:	81f8           	l32i.n	a15, a1, 32
    186c:	91f9           	s32i.n	a15, a1, 36
    186e:	0a0c           	movi.n	a10, 0
    1870:	21e8e0        	srai	a14, a14, 8
    1873:	11dd00        	slli	a13, a13, 16
    1876:	21d8d0        	srai	a13, a13, 8
    1879:	82cde0        	mull	a12, a13, a14
    187c:	b2dde0        	mulsh	a13, a13, a14
    187f:	0292e2        	l16si	a14, a2, 4
    1882:	118f00        	slli	a8, a15, 16
    1885:	218880        	srai	a8, a8, 8
    1888:	11ee00        	slli	a14, a14, 16
    188b:	21e8e0        	srai	a14, a14, 8
    188e:	82be80        	mull	a11, a14, a8
    1891:	b2ee80        	mulsh	a14, a14, a8
    1894:	81ddc0        	src	a13, a13, a12
    1897:	81eeb0        	src	a14, a14, a11
    189a:	404810        	ssai	24
    189d:	11bbf0        	slli	a11, a11, 1
    18a0:	90bcb0        	addx2	a11, a12, a11
    18a3:	ddea           	add.n	a13, a13, a14
    18a5:	11ccf0        	slli	a12, a12, 1
    18a8:	62cbc0        	saltu	a12, a11, a12
    18ab:	ccda           	add.n	a12, a12, a13
    18ad:	db6a           	add.n	a13, a11, a6
    18af:	62bdb0        	saltu	a11, a13, a11
    18b2:	bbca           	add.n	a11, a11, a12
    18b4:	81dbd0        	src	a13, a11, a13
    18b7:	31b8b0        	srai	a11, a11, 24
    18ba:	81bbd0        	src	a11, a11, a13
    18bd:	11dd80        	slli	a13, a13, 8
    18c0:	006b96        	bltz	a11, 18ca <fn_calc_sup_gain+0x316>
    18c3:	1bcc           	bnez.n	a11, 18c8 <fn_calc_sup_gain+0x314>
    18c5:	01b5d7        	bgeu	a5, a13, 18ca <fn_calc_sup_gain+0x316>

000018c8 <fn_calc_sup_gain+0x314>:
    18c8:	1a0c           	movi.n	a10, 1

000018ca <fn_calc_sup_gain+0x316>:
    18ca:	4a8c           	beqz.n	a10, 18d2 <fn_calc_sup_gain+0x31e>
    18cc:	fa17a1        	l32r	a10, 128 (7fffff00 <_end+0x7fff921c>)
    18cf:	0005c6        	j	18ea <fn_calc_sup_gain+0x336>

000018d2 <fn_calc_sup_gain+0x31e>:
    18d2:	0c0c           	movi.n	a12, 0
    18d4:	f9df91        	l32r	a9, 50 (7fffffff <_end+0x7fff931b>)
    18d7:	009bd6        	bgez	a11, 18e4 <fn_calc_sup_gain+0x330>
    18da:	040b66        	bnei	a11, -1, 18e2 <fn_calc_sup_gain+0x32e>
    18dd:	09ad           	mov.n	a10, a9
    18df:	013ad7        	bltu	a10, a13, 18e4 <fn_calc_sup_gain+0x330>

000018e2 <fn_calc_sup_gain+0x32e>:
    18e2:	1c0c           	movi.n	a12, 1

000018e4 <fn_calc_sup_gain+0x330>:
    18e4:	f9dca1        	l32r	a10, 54 (80000000 <_end+0x7fff931c>)
    18e7:	83adc0        	moveqz	a10, a13, a12

000018ea <fn_calc_sup_gain+0x336>:
    18ea:	404700        	ssai	7
    18ed:	21c8a0        	srai	a12, a10, 8
    18f0:	82bac0        	mull	a11, a10, a12
    18f3:	b2dac0        	mulsh	a13, a10, a12
    18f6:	1261c2        	s32i	a12, a1, 72
    18f9:	81bdb0        	src	a11, a13, a11
    18fc:	31cfc0        	srai	a12, a12, 31
    18ff:	1161c2        	s32i	a12, a1, 68
    1902:	404010        	ssai	16
    1905:	ab7a           	add.n	a10, a11, a7
    1907:	21d7d0        	srai	a13, a13, 7
    190a:	62bab0        	saltu	a11, a10, a11
    190d:	bbda           	add.n	a11, a11, a13
    190f:	81aba0        	src	a10, a11, a10
    1912:	31b0b0        	srai	a11, a11, 16
    1915:	ff2065        	call8	b1c <_saturate32>
    1918:	1221b2        	l32i	a11, a1, 72
    191b:	1121d2        	l32i	a13, a1, 68
    191e:	a1a9           	s32i.n	a10, a1, 40
    1920:	cb7a           	add.n	a12, a11, a7
    1922:	0cad           	mov.n	a10, a12
    1924:	62bcb0        	saltu	a11, a12, a11
    1927:	bbda           	add.n	a11, a11, a13
    1929:	ff1f25        	call8	b1c <_saturate32>
    192c:	91b8           	l32i.n	a11, a1, 36
    192e:	b1a9           	s32i.n	a10, a1, 44
    1930:	11cb80        	slli	a12, a11, 8
    1933:	31b8b0        	srai	a11, a11, 24
    1936:	0cad           	mov.n	a10, a12
    1938:	ff1e25        	call8	b1c <_saturate32>
    193b:	0acd           	mov.n	a12, a10
    193d:	aa7a           	add.n	a10, a10, a7
    193f:	62bac0        	saltu	a11, a10, a12
    1942:	31cfc0        	srai	a12, a12, 31
    1945:	bbca           	add.n	a11, a11, a12
    1947:	ff1d65        	call8	b1c <_saturate32>
    194a:	1121e2        	l32i	a14, a1, 68
    194d:	1221d2        	l32i	a13, a1, 72
    1950:	a1c8           	l32i.n	a12, a1, 40
    1952:	c1a9           	s32i.n	a10, a1, 48
    1954:	e1c9           	s32i.n	a12, a1, 56
    1956:	dcda           	add.n	a13, a12, a13
    1958:	62bdc0        	saltu	a11, a13, a12
    195b:	0dad           	mov.n	a10, a13
    195d:	31cfc0        	srai	a12, a12, 31
    1960:	d1c9           	s32i.n	a12, a1, 52
    1962:	ccea           	add.n	a12, a12, a14
    1964:	bbca           	add.n	a11, a11, a12
    1966:	ff1b65        	call8	b1c <_saturate32>
    1969:	0abd           	mov.n	a11, a10
    196b:	31cfa0        	srai	a12, a10, 31
    196e:	ccca           	add.n	a12, a12, a12
    1970:	aaaa           	add.n	a10, a10, a10
    1972:	62bab0        	saltu	a11, a10, a11
    1975:	bbca           	add.n	a11, a11, a12
    1977:	ff1a65        	call8	b1c <_saturate32>
    197a:	f9ec81        	l32r	a8, 12c (334 <fxdiv32>)
    197d:	404800        	ssai	8
    1980:	01dab2        	addmi	a11, a10, 0x100
    1983:	31cfa0        	srai	a12, a10, 31
    1986:	80cbb2        	addi	a11, a11, -128
    1989:	62aba0        	saltu	a10, a11, a10
    198c:	aaca           	add.n	a10, a10, a12
    198e:	81aab0        	src	a10, a10, a11
    1991:	c1b8           	l32i.n	a11, a1, 48
    1993:	0008e0        	callx8	a8
    1996:	0abd           	mov.n	a11, a10
    1998:	11aab0        	slli	a10, a10, 5
    199b:	31bbb0        	srai	a11, a11, 27
    199e:	ff17e5        	call8	b1c <_saturate32>
    19a1:	404300        	ssai	3
    19a4:	d188           	l32i.n	a8, a1, 52
    19a6:	e1e8           	l32i.n	a14, a1, 56
    19a8:	0abd           	mov.n	a11, a10
    19aa:	31cfb0        	srai	a12, a11, 31
    19ad:	fe4b           	addi.n	a15, a14, 4
    19af:	62efe0        	saltu	a14, a15, a14
    19b2:	ee8a           	add.n	a14, a14, a8
    19b4:	81eef0        	src	a14, a14, a15
    19b7:	80aae0        	add	a10, a10, a14
    19ba:	31dfe0        	srai	a13, a14, 31
    19bd:	ccda           	add.n	a12, a12, a13
    19bf:	62bab0        	saltu	a11, a10, a11
    19c2:	80bbc0        	add	a11, a11, a12
    19c5:	ff1565        	call8	b1c <_saturate32>
    19c8:	f9ce81        	l32r	a8, 100 (8b8 <LD_NR_fxsqrt>)
    19cb:	0008e0        	callx8	a8
    19ce:	0abd           	mov.n	a11, a10
    19d0:	11aa70        	slli	a10, a10, 9
    19d3:	31b7b0        	srai	a11, a11, 23
    19d6:	ff1465        	call8	b1c <_saturate32>
    19d9:	0abd           	mov.n	a11, a10
    19db:	1121d2        	l32i	a13, a1, 68
    19de:	1221a2        	l32i	a10, a1, 72
    19e1:	31cfb0        	srai	a12, a11, 31
    19e4:	ccda           	add.n	a12, a12, a13
    19e6:	abaa           	add.n	a10, a11, a10
    19e8:	62bab0        	saltu	a11, a10, a11
    19eb:	bbca           	add.n	a11, a11, a12
    19ed:	ff12e5        	call8	b1c <_saturate32>
    19f0:	b1b8           	l32i.n	a11, a1, 44
    19f2:	f1a9           	s32i.n	a10, a1, 60
    19f4:	31dfb0        	srai	a13, a11, 31
    19f7:	cbba           	add.n	a12, a11, a11
    19f9:	0cad           	mov.n	a10, a12
    19fb:	ddda           	add.n	a13, a13, a13
    19fd:	62bcb0        	saltu	a11, a12, a11
    1a00:	bbda           	add.n	a11, a11, a13
    1a02:	ff11a5        	call8	b1c <_saturate32>
    1a05:	f9c981        	l32r	a8, 12c (334 <fxdiv32>)
    1a08:	0abd           	mov.n	a11, a10
    1a0a:	0f21a2        	l32i	a10, a1, 60
    1a0d:	0008e0        	callx8	a8
    1a10:	51b8           	l32i.n	a11, a1, 20
    1a12:	0c0c           	movi.n	a12, 0
    1a14:	63ad           	ae_s16i.n	a10, a3, 0
    1a16:	0392e2        	l16si	a14, a2, 6
    1a19:	0d0c           	movi.n	a13, 0
    1a1b:	404f10        	ssai	31
    1a1e:	03aae7        	bge	a10, a14, 1a25 <fn_calc_sup_gain+0x471>
    1a21:	63ed           	ae_s16i.n	a14, a3, 0
    1a23:	0ead           	mov.n	a10, a14

00001a25 <fn_calc_sup_gain+0x471>:
    1a25:	118a00        	slli	a8, a10, 16
    1a28:	0a0c           	movi.n	a10, 0
    1a2a:	218880        	srai	a8, a8, 8
    1a2d:	82f880        	mull	a15, a8, a8
    1a30:	b28880        	mulsh	a8, a8, a8
    1a33:	11eff0        	slli	a14, a15, 1
    1a36:	8188f0        	src	a8, a8, a15
    1a39:	404810        	ssai	24
    1a3c:	90ff60        	addx2	a15, a15, a6
    1a3f:	88da           	add.n	a8, a8, a13
    1a41:	62efe0        	saltu	a14, a15, a14
    1a44:	ee8a           	add.n	a14, a14, a8
    1a46:	81fef0        	src	a15, a14, a15
    1a49:	31e8e0        	srai	a14, a14, 24
    1a4c:	81eef0        	src	a14, a14, a15
    1a4f:	11ff80        	slli	a15, a15, 8
    1a52:	072ec7        	blt	a14, a12, 1a5d <fn_calc_sup_gain+0x4a9>
    1a55:	029ec7        	bne	a14, a12, 1a5b <fn_calc_sup_gain+0x4a7>
    1a58:	01b5f7        	bgeu	a5, a15, 1a5d <fn_calc_sup_gain+0x4a9>

00001a5b <fn_calc_sup_gain+0x4a7>:
    1a5b:	1a0c           	movi.n	a10, 1

00001a5d <fn_calc_sup_gain+0x4a9>:
    1a5d:	404f10        	ssai	31
    1a60:	4a8c           	beqz.n	a10, 1a68 <fn_calc_sup_gain+0x4b4>
    1a62:	f9b1e1        	l32r	a14, 128 (7fffff00 <_end+0x7fff921c>)
    1a65:	000746        	j	1a86 <fn_calc_sup_gain+0x4d2>

00001a68 <fn_calc_sup_gain+0x4b4>:
    1a68:	f97aa1        	l32r	a10, 50 (7fffffff <_end+0x7fff931b>)
    1a6b:	090c           	movi.n	a9, 0
    1a6d:	3199           	s32i.n	a9, a1, 12
    1a6f:	00bed6        	bgez	a14, 1a7e <fn_calc_sup_gain+0x4ca>
    1a72:	040e66        	bnei	a14, -1, 1a7a <fn_calc_sup_gain+0x4c6>
    1a75:	0aed           	mov.n	a14, a10
    1a77:	033ef7        	bltu	a14, a15, 1a7e <fn_calc_sup_gain+0x4ca>

00001a7a <fn_calc_sup_gain+0x4c6>:
    1a7a:	180c           	movi.n	a8, 1
    1a7c:	3189           	s32i.n	a8, a1, 12

00001a7e <fn_calc_sup_gain+0x4ca>:
    1a7e:	3198           	l32i.n	a9, a1, 12
    1a80:	f975e1        	l32r	a14, 54 (80000000 <_end+0x7fff931c>)
    1a83:	83ef90        	moveqz	a14, a15, a9

00001a86 <fn_calc_sup_gain+0x4d2>:
    1a86:	0b98           	l32i.n	a9, a11, 0
    1a88:	2188e0        	srai	a8, a14, 8
    1a8b:	0a0c           	movi.n	a10, 0
    1a8d:	21e890        	srai	a14, a9, 8
    1a90:	82fe80        	mull	a15, a14, a8
    1a93:	b2ee80        	mulsh	a14, a14, a8
    1a96:	118ff0        	slli	a8, a15, 1
    1a99:	909f60        	addx2	a9, a15, a6
    1a9c:	81eef0        	src	a14, a14, a15
    1a9f:	eeda           	add.n	a14, a14, a13
    1aa1:	628980        	saltu	a8, a9, a8
    1aa4:	404810        	ssai	24
    1aa7:	88ea           	add.n	a8, a8, a14
    1aa9:	31e880        	srai	a14, a8, 24
    1aac:	818890        	src	a8, a8, a9
    1aaf:	11f880        	slli	a15, a8, 8
    1ab2:	81ee80        	src	a14, a14, a8
    1ab5:	072ec7        	blt	a14, a12, 1ac0 <fn_calc_sup_gain+0x50c>
    1ab8:	029ec7        	bne	a14, a12, 1abe <fn_calc_sup_gain+0x50a>
    1abb:	01b5f7        	bgeu	a5, a15, 1ac0 <fn_calc_sup_gain+0x50c>

00001abe <fn_calc_sup_gain+0x50a>:
    1abe:	1a0c           	movi.n	a10, 1

00001ac0 <fn_calc_sup_gain+0x50c>:
    1ac0:	332b           	addi.n	a3, a3, 2
    1ac2:	444b           	addi.n	a4, a4, 4
    1ac4:	bb4b           	addi.n	a11, a11, 4
    1ac6:	6a8c           	beqz.n	a10, 1ad0 <fn_calc_sup_gain+0x51c>
    1ac8:	f99891        	l32r	a9, 128 (7fffff00 <_end+0x7fff921c>)
    1acb:	0007c6        	j	1aee <fn_calc_sup_gain+0x53a>

00001ace <fn_calc_sup_gain+0x51a>:
	...

00001ad0 <fn_calc_sup_gain+0x51c>:
    1ad0:	f960a1        	l32r	a10, 50 (7fffffff <_end+0x7fff931b>)
    1ad3:	f87c           	movi.n	a8, -1
    1ad5:	090c           	movi.n	a9, 0
    1ad7:	4199           	s32i.n	a9, a1, 16
    1ad9:	009ed6        	bgez	a14, 1ae6 <fn_calc_sup_gain+0x532>
    1adc:	020e66        	bnei	a14, -1, 1ae2 <fn_calc_sup_gain+0x52e>
    1adf:	033af7        	bltu	a10, a15, 1ae6 <fn_calc_sup_gain+0x532>

00001ae2 <fn_calc_sup_gain+0x52e>:
    1ae2:	190c           	movi.n	a9, 1
    1ae4:	4199           	s32i.n	a9, a1, 16

00001ae6 <fn_calc_sup_gain+0x532>:
    1ae6:	41a8           	l32i.n	a10, a1, 16
    1ae8:	f95b91        	l32r	a9, 54 (80000000 <_end+0x7fff931c>)
    1aeb:	839fa0        	moveqz	a9, a15, a10

00001aee <fn_calc_sup_gain+0x53a>:
    1aee:	61e8           	l32i.n	a14, a1, 24
    1af0:	1021f2        	l32i	a15, a1, 64
    1af3:	51b9           	s32i.n	a11, a1, 20
    1af5:	c0ebe0        	sub	a14, a11, a14
    1af8:	09ef94        	ae_s32ip	a9, a15, 4
    1afb:	1061f2        	s32i	a15, a1, 64
    1afe:	d21e56        	bnez	a14, 1823 <fn_calc_sup_gain+0x26f>

00001b01 <fn_calc_sup_gain+0x54d>:
    1b01:	f01d           	retw.n

00001b03 <fn_calc_sup_gain+0x54f>:
    1b03:	0d6916        	beqz	a9, 1bdd <fn_calc_sup_gain+0x629>
    1b06:	890b           	addi.n	a8, a9, -1
    1b08:	0f0816        	beqz	a8, 1bfc <fn_calc_sup_gain+0x648>
    1b0b:	0a4c           	movi.n	a10, 64
    1b0d:	80a092        	movi	a9, 128
    1b10:	7199           	s32i.n	a9, a1, 28
    1b12:	feb2c6        	j	15e1 <fn_calc_sup_gain+0x2d>

00001b15 <fn_calc_sup_gain+0x561>:
    1b15:	0d8916        	beqz	a9, 1bf1 <fn_calc_sup_gain+0x63d>
    1b18:	a90b           	addi.n	a10, a9, -1
    1b1a:	0f5a16        	beqz	a10, 1c13 <fn_calc_sup_gain+0x65f>
    1b1d:	80a0a2        	movi	a10, 128
    1b20:	c0a0b2        	movi	a11, 192
    1b23:	71b9           	s32i.n	a11, a1, 28
    1b25:	feae06        	j	15e1 <fn_calc_sup_gain+0x2d>

00001b28 <fn_calc_sup_gain+0x574>:
    1b28:	0dc916        	beqz	a9, 1c08 <fn_calc_sup_gain+0x654>
    1b2b:	c90b           	addi.n	a12, a9, -1
    1b2d:	0efc16        	beqz	a12, 1c20 <fn_calc_sup_gain+0x66c>
    1b30:	c0a0a2        	movi	a10, 192
    1b33:	01a1d2        	movi	a13, 0x101
    1b36:	71d9           	s32i.n	a13, a1, 28
    1b38:	fea946        	j	15e1 <fn_calc_sup_gain+0x2d>

00001b3b <fn_calc_sup_gain+0x587>:
    1b3b:	0a0c           	movi.n	a10, 0
    1b3d:	01a1e2        	movi	a14, 0x101
    1b40:	71e9           	s32i.n	a14, a1, 28

00001b42 <fn_calc_sup_gain+0x58e>:
    1b42:	71f8           	l32i.n	a15, a1, 28
    1b44:	78c182        	addi	a8, a1, 120
    1b47:	0292b2        	l16si	a11, a2, 4
    1b4a:	329d           	ae_l16si.n	a9, a2, 2
    1b4c:	a06a20        	addx4	a6, a10, a2
    1b4f:	907a50        	addx2	a7, a10, a5
    1b52:	a04a40        	addx4	a4, a10, a4
    1b55:	601404        	ae_lq32f.iu	aeq0, a4, 0
    1b58:	a05a30        	addx4	a5, a10, a3
    1b5b:	668b           	addi.n	a6, a6, 8
    1b5d:	0a3d           	mov.n	a3, a10
    1b5f:	605604        	ae_lq32f.iu	aeq1, a6, 0
    1b62:	60d504        	ae_lq32f.iu	aeq3, a5, 0
    1b65:	3009b4        	ae_cvtp24a16x2.ll	aep0, a9, a11
    1b68:	5608b4        	ae_sp24x2s.i	aep0, a8, -40
    1b6b:	6338c4        	ae_sq56s.i	aeq3, a8, -32
    1b6e:	8faaf7        	bge	a10, a15, 1b01 <fn_calc_sup_gain+0x54d>

00001b71 <fn_calc_sup_gain+0x5bd>:
    1b71:	fa6a0781ae 	{ addi	a10, a1, 120; ae_addq56	aeq2, aeq1, aeq0 }
    1b76:	fd80f02abf 	{ ae_lp24x2.i	aep2, a10, -40; ae_satq48s	aeq1, aeq2 }
    1b7b:	d46b7dcacf 	{ ae_lq56.i	aeq2, a10, -32; ae_mulfq32sp16s.h	aeq1, aeq1, aep2 }
    1b80:	032894        	ae_mulafq32sp16s.l	aeq1, aeq2, aep2
    1b83:	f96a81        	l32r	a8, 12c (334 <fxdiv32>)
    1b86:	f86fff0aef 	{ ae_trunca32q48	a10, aeq0; ae_roundsp24q48asym	aep1, aeq1 }
    1b8b:	009bd4        	ae_cvta32p24.h	a11, aep1
    1b8e:	0008e0        	callx8	a8
    1b91:	f933e1        	l32r	a14, 60 (7fff <_end+0x131b>)
    1b94:	0392d2        	l16si	a13, a2, 6
    1b97:	c0eea0        	sub	a14, a14, a10
    1b9a:	8eed           	ae_sext16	a14, a14
    1b9c:	53dde0        	max	a13, a13, a14
    1b9f:	78c1e2        	addi	a14, a1, 120
    1ba2:	306dd4        	ae_cvtp24a16x2.ll	aep6, a13, a13
    1ba5:	e9d8bdeecf 	{ ae_lq56.i	aeq3, a14, -32; ae_mulfp24s.hh	aeq2, aep6, aep6 }
    1baa:	09bf54        	ae_truncp24q48x2	aep5, aeq3, aeq3
    1bad:	1bad44        	ae_roundsp24q48asym	aep4, aeq2
    1bb0:	014d44        	ae_mulfp24s.hh	aeq1, aep4, aep5
    1bb3:	09c7d4        	ae_s16ip	a13, a7, 2
    1bb6:	f96ff071be 	{ l32i	a11, a1, 28; ae_roundsp24q48asym	aep3, aeq1 }
    1bbb:	fc6c00133e 	{ addi	a3, a3, 1; ae_cvtq48p24s.l	aeq0, aep3 }
    1bc0:	624604        	ae_sq32f.iu	aeq0, a6, 0
    1bc3:	605614        	ae_lq32f.iu	aeq1, a6, 4
    1bc6:	601414        	ae_lq32f.iu	aeq0, a4, 4
    1bc9:	60d514        	ae_lq32f.iu	aeq3, a5, 4
    1bcc:	633ec4        	ae_sq56s.i	aeq3, a14, -32
    1bcf:	9e93b7        	bne	a3, a11, 1b71 <fn_calc_sup_gain+0x5bd>
    1bd2:	f01d           	retw.n

00001bd4 <fn_calc_sup_gain+0x620>:
    1bd4:	0a0c           	movi.n	a10, 0
    1bd6:	0f4c           	movi.n	a15, 64
    1bd8:	71f9           	s32i.n	a15, a1, 28
    1bda:	ffd906        	j	1b42 <fn_calc_sup_gain+0x58e>

00001bdd <fn_calc_sup_gain+0x629>:
    1bdd:	0a4c           	movi.n	a10, 64
    1bdf:	80a082        	movi	a8, 128
    1be2:	7189           	s32i.n	a8, a1, 28
    1be4:	ffd686        	j	1b42 <fn_calc_sup_gain+0x58e>

00001be7 <fn_calc_sup_gain+0x633>:
	...

00001be8 <fn_calc_sup_gain+0x634>:
    1be8:	0a0c           	movi.n	a10, 0
    1bea:	094c           	movi.n	a9, 64
    1bec:	7199           	s32i.n	a9, a1, 28
    1bee:	ff0386        	j	1800 <fn_calc_sup_gain+0x24c>

00001bf1 <fn_calc_sup_gain+0x63d>:
    1bf1:	c0a0a2        	movi	a10, 192
    1bf4:	71a9           	s32i.n	a10, a1, 28
    1bf6:	80a0a2        	movi	a10, 128
    1bf9:	ffd146        	j	1b42 <fn_calc_sup_gain+0x58e>

00001bfc <fn_calc_sup_gain+0x648>:
    1bfc:	0a4c           	movi.n	a10, 64
    1bfe:	80a0b2        	movi	a11, 128
    1c01:	71b9           	s32i.n	a11, a1, 28
    1c03:	fefe46        	j	1800 <fn_calc_sup_gain+0x24c>

00001c06 <fn_calc_sup_gain+0x652>:
	...

00001c08 <fn_calc_sup_gain+0x654>:
    1c08:	c0a0a2        	movi	a10, 192
    1c0b:	01a1c2        	movi	a12, 0x101
    1c0e:	71c9           	s32i.n	a12, a1, 28
    1c10:	ffcb86        	j	1b42 <fn_calc_sup_gain+0x58e>

00001c13 <fn_calc_sup_gain+0x65f>:
    1c13:	80a0a2        	movi	a10, 128
    1c16:	c0a0d2        	movi	a13, 192
    1c19:	71d9           	s32i.n	a13, a1, 28
    1c1b:	fef846        	j	1800 <fn_calc_sup_gain+0x24c>

00001c1e <fn_calc_sup_gain+0x66a>:
	...

00001c20 <fn_calc_sup_gain+0x66c>:
    1c20:	c0a0a2        	movi	a10, 192
    1c23:	01a1e2        	movi	a14, 0x101
    1c26:	71e9           	s32i.n	a14, a1, 28
    1c28:	fef506        	j	1800 <fn_calc_sup_gain+0x24c>

00001c2b <fn_calc_sup_gain+0x677>:
	...

00001c2c <fn_calc_pow>:
    1c2c:	004136        	entry	a1, 32
    1c2f:	fcc362        	addi	a6, a3, -4
    1c32:	5c8204        	ae_lp24x2f.iu	aep0, a2, 0
    1c35:	c04540        	sub	a4, a5, a4
    1c38:	023d           	mov.n	a3, a2
    1c3a:	202660        	or	a2, a6, a6
    1c3d:	11a476        	loopgtz	a4, 1c52 <fn_calc_pow+0x26>
    1c40:	040004        	ae_mulzaafp24s.hh.ll	aeq0, aep0, aep0
    1c43:	360114        	ae_sllisq56s	aeq0, aeq0, 4
    1c46:	060844        	ae_satq48s	aeq0, aeq0
    1c49:	060934        	ae_roundsq32asym	aeq0, aeq0
    1c4c:	624214        	ae_sq32f.iu	aeq0, a2, 4
    1c4f:	5c8314        	ae_lp24x2f.iu	aep0, a3, 8

00001c52 <fn_calc_pow+0x26>:
    1c52:	f01d           	retw.n

00001c54 <gen_filter_coef>:
    1c54:	00a136        	entry	a1, 80
    1c57:	fec172        	addi	a7, a1, -2
    1c5a:	f93561        	l32r	a6, 130 (47f0 <idct64>)
    1c5d:	f93581        	l32r	a8, 134 (5370 <idct64+0xb80>)
    1c60:	80a0a2        	movi	a10, 128
    1c63:	20a042        	movi	a4, 32
    1c66:	20b330        	or	a11, a3, a3
    1c69:	fe2493922f 	{ or	a9, a2, a2; ae_zeroq56	aeq2 }
    1c6e:	fc1453399f 	{ or	a3, a9, a9; ae_movq56	aeq0, aeq2 }

00001c73 <gen_filter_coef+0x1f>:
    1c73:	449304        	ae_lp16x2f.iu	aep1, a3, 0
    1c76:	062d           	mov.n	a2, a6
    1c78:	448204        	ae_lp16x2f.iu	aep0, a2, 0
    1c7b:	66aa           	add.n	a6, a6, a10
    1c7d:	078476        	loop	a4, 1c88 <gen_filter_coef+0x34>
    1c80:	e2202d821f 	{ ae_lp16x2f.iu	aep0, a2, 4; ae_mulaafp24s.hh.ll	aeq0, aep0, aep1 }
    1c85:	449314        	ae_lp16x2f.iu	aep1, a3, 4

00001c88 <gen_filter_coef+0x34>:
    1c88:	042c           	movi.n	a4, 32
    1c8a:	f86393399f 	{ or	a3, a9, a9; ae_roundsp16q48asym	aep0, aeq0 }
    1c8f:	fc1472871f 	{ ae_sp16f.l.iu	aep0, a7, 2; ae_movq56	aeq0, aeq2 }
    1c94:	db9687        	bne	a6, a8, 1c73 <gen_filter_coef+0x1f>
    1c97:	2ecb42        	addi	a4, a11, 46
    1c9a:	661c           	movi.n	a6, 22
    1c9c:	f92721        	l32r	a2, 138 (43fc <win_wf+0x2c>)
    1c9f:	015d           	mov.n	a5, a1
    1ca1:	409504        	ae_lp16f.iu	aep1, a5, 0
    1ca4:	40a204        	ae_lp16f.iu	aep2, a2, 0
    1ca7:	e84482ab3e 	{ addi	a3, a11, 42; ae_mulfp24s.hh	aeq0, aep1, aep2 }
    1cac:	408514        	ae_lp16f.iu	aep0, a5, 2
    1caf:	f963ac921f 	{ ae_lp16f.iu	aep1, a2, 2; ae_roundsp16q48asym	aep2, aeq0 }
    1cb4:	42a314        	ae_sp16f.l.iu	aep2, a3, 2
    1cb7:	0f8676        	loop	a6, 1cca <gen_filter_coef+0x76>

00001cba <gen_filter_coef+0x66>:
    1cba:	e820ac851f 	{ ae_lp16f.iu	aep0, a5, 2; ae_mulfp24s.hh	aeq0, aep0, aep1 }
    1cbf:	42a4f4        	ae_sp16f.l.iu	aep2, a4, -2
    1cc2:	f963ac921f 	{ ae_lp16f.iu	aep1, a2, 2; ae_roundsp16q48asym	aep2, aeq0 }
    1cc7:	42a314        	ae_sp16f.l.iu	aep2, a3, 2

00001cca <gen_filter_coef+0x76>:
    1cca:	045d           	mov.n	a5, a4
    1ccc:	42a5f4        	ae_sp16f.l.iu	aep2, a5, -2
    1ccf:	f01d           	retw.n

00001cd1 <gen_filter_coef+0x7d>:
    1cd1:	000000                                        ...

00001cd4 <LD_NR_fir_init>:
    1cd4:	00e136        	entry	a1, 112
    1cd7:	02ad           	mov.n	a10, a2
    1cd9:	f90081        	l32r	a8, dc (2370 <LDNR_xt_memset>)
    1cdc:	0b0c           	movi.n	a11, 0
    1cde:	f917c1        	l32r	a12, 13c (1bc4 <fn_calc_sup_gain+0x610>)
    1ce1:	0008e0        	callx8	a8
    1ce4:	01ad           	mov.n	a10, a1
    1ce6:	f8fe81        	l32r	a8, e0 (2388 <LDNR_xt_memcpy>)
    1ce9:	b34b           	addi.n	a11, a3, 4
    1ceb:	4c0c           	movi.n	a12, 4
    1ced:	0008e0        	callx8	a8
    1cf0:	a18b           	addi.n	a10, a1, 8
    1cf2:	f8fb81        	l32r	a8, e0 (2388 <LDNR_xt_memcpy>)
    1cf5:	b3cb           	addi.n	a11, a3, 12
    1cf7:	6c1c           	movi.n	a12, 22
    1cf9:	0008e0        	callx8	a8
    1cfc:	38c3b2        	addi	a11, a3, 56
    1cff:	f8f881        	l32r	a8, e0 (2388 <LDNR_xt_memcpy>)
    1d02:	34c1a2        	addi	a10, a1, 52
    1d05:	ac0c           	movi.n	a12, 10
    1d07:	0008e0        	callx8	a8
    1d0a:	00a4c2        	movi	a12, 0x400
    1d0d:	f8f381        	l32r	a8, dc (2370 <LDNR_xt_memset>)
    1d10:	2291a2        	l16si	a10, a1, 68
    1d13:	040c           	movi.n	a4, 0
    1d15:	1fd2b2        	addmi	a11, a2, 0x1f00
    1d18:	13d292        	addmi	a9, a2, 0x1300
    1d1b:	fcc932        	addi	a3, a9, -4
    1d1e:	78cbb2        	addi	a11, a11, 120
    1d21:	02b9           	s32i.n	a11, a2, 0
    1d23:	685942        	s16i	a4, a9, 208
    1d26:	6a59a2        	s16i	a10, a9, 212
    1d29:	04bd           	mov.n	a11, a4
    1d2b:	04d2a2        	addmi	a10, a2, 0x400
    1d2e:	c4caa2        	addi	a10, a10, -60
    1d31:	0008e0        	callx8	a8
    1d34:	336342        	s32i	a4, a3, 204
    1d37:	346342        	s32i	a4, a3, 208
    1d3a:	645342        	s16i	a4, a3, 200
    1d3d:	0b0c           	movi.n	a11, 0
    1d3f:	00a4c2        	movi	a12, 0x400
    1d42:	f8e681        	l32r	a8, dc (2370 <LDNR_xt_memset>)
    1d45:	0cd2a2        	addmi	a10, a2, 0xc00
    1d48:	c4caa2        	addi	a10, a10, -60
    1d4b:	0008e0        	callx8	a8
    1d4e:	049d           	mov.n	a9, a4
    1d50:	ca2c           	movi.n	a10, 44
    1d52:	14d2b2        	addmi	a11, a2, 0x1400
    1d55:	f8c2d1        	l32r	a13, 60 (7fff <_end+0x131b>)
    1d58:	6e53d2        	s16i	a13, a3, 220
    1d5b:	dacbb2        	addi	a11, a11, -38
    1d5e:	208bb0        	or	a8, a11, a11
    1d61:	028a76        	loop	a10, 1d67 <LD_NR_fir_init+0x93>
    1d64:	09c844        	ae_s16ip	a4, a8, 2

00001d67 <LD_NR_fir_init+0x93>:
    1d67:	9b53d2        	s16i	a13, a3, 0x136
    1d6a:	5acb82        	addi	a8, a11, 90
    1d6d:	ca2c           	movi.n	a10, 44
    1d6f:	028a76        	loop	a10, 1d75 <LD_NR_fir_init+0xa1>
    1d72:	09c894        	ae_s16ip	a9, a8, 2
    1d75:	08c1b2        	addi	a11, a1, 8
    1d78:	f8f281        	l32r	a8, 140 (fc8 <fn_ini_st_noise_est>)
    1d7b:	19d2a2        	addmi	a10, a2, 0x1900
    1d7e:	9ccaa2        	addi	a10, a10, -100
    1d81:	0008e0        	callx8	a8
    1d84:	01bd           	mov.n	a11, a1
    1d86:	0c0c           	movi.n	a12, 0
    1d88:	f8ef81        	l32r	a8, 144 (1580 <fn_ini_calc_sup_gain>)
    1d8b:	15d2a2        	addmi	a10, a2, 0x1500
    1d8e:	8ccaa2        	addi	a10, a10, -116
    1d91:	0008e0        	callx8	a8
    1d94:	34c1b2        	addi	a11, a1, 52
    1d97:	02c8           	l32i.n	a12, a2, 0
    1d99:	1fd2a2        	addmi	a10, a2, 0x1f00
    1d9c:	f8eb81        	l32r	a8, 148 (b68 <fn_ini_pitch_detection>)
    1d9f:	5ccaa2        	addi	a10, a10, 92
    1da2:	08dcc2        	addmi	a12, a12, 0x800
    1da5:	0008e0        	callx8	a8
    1da8:	f01d           	retw.n

00001daa <LD_NR_fir_init+0xd6>:
	...

00001dac <LD_NR_fir_proc2>:
    1dac:	004136        	entry	a1, 32
    1daf:	13d252        	addmi	a5, a2, 0x1300
    1db2:	629582        	l16si	a8, a5, 196
    1db5:	0238           	l32i.n	a3, a2, 0
    1db7:	d0c552        	addi	a5, a5, -48
    1dba:	031826        	beqi	a8, 1, 1dc1 <LD_NR_fir_proc2+0x15>
    1dbd:	020c           	movi.n	a2, 0
    1dbf:	f01d           	retw.n

00001dc1 <LD_NR_fir_proc2+0x15>:
    1dc1:	fcc3a2        	addi	a10, a3, -4
    1dc4:	f8e281        	l32r	a8, 14c (4430 <window>)
    1dc7:	0cd292        	addmi	a9, a2, 0xc00
    1dca:	c4c992        	addi	a9, a9, -60
    1dcd:	601904        	ae_lq32f.iu	aeq0, a9, 0
    1dd0:	408804        	ae_lp16f.iu	aep0, a8, 0
    1dd3:	d4e201dfbf 	{ movi	a11, 0x1df; ae_mulfq32sp16s.l	aeq0, aeq0, aep0 }
    1dd8:	408814        	ae_lp16f.iu	aep0, a8, 2
    1ddb:	fd247d191f 	{ ae_lq32f.iu	aeq0, a9, 4; ae_roundsq32asym	aeq1, aeq0 }
    1de0:	0c8b76        	loop	a11, 1df0 <LD_NR_fir_proc2+0x44>
    1de3:	d4e239da1f 	{ ae_sq32f.iu	aeq1, a10, 4; ae_mulfq32sp16s.l	aeq0, aeq0, aep0 }
    1de8:	408814        	ae_lp16f.iu	aep0, a8, 2
    1deb:	fd247d191f 	{ ae_lq32f.iu	aeq0, a9, 4; ae_roundsq32asym	aeq1, aeq0 }

00001df0 <LD_NR_fir_proc2+0x44>:
    1df0:	092c           	movi.n	a9, 32
    1df2:	0a8d           	mov.n	a8, a10
    1df4:	fc24b9d81f 	{ ae_sq32f.iu	aeq1, a8, 4; ae_zeroq56	aeq0 }
    1df9:	028976        	loop	a9, 1dff <LD_NR_fir_proc2+0x53>
    1dfc:	624814        	ae_sq32f.iu	aeq0, a8, 4
    1dff:	03ad           	mov.n	a10, a3
    1e01:	f8be81        	l32r	a8, fc (2258 <real_512_fft_0>)
    1e04:	08d342        	addmi	a4, a3, 0x800
    1e07:	04bd           	mov.n	a11, a4
    1e09:	0008e0        	callx8	a8
    1e0c:	01a1c2        	movi	a12, 0x101
    1e0f:	fccab2        	addi	a11, a10, -4
    1e12:	049d           	mov.n	a9, a4
    1e14:	08d382        	addmi	a8, a3, 0x800
    1e17:	f8c882        	addi	a8, a8, -8
    1e1a:	5c8904        	ae_lp24x2f.iu	aep0, a9, 0
    1e1d:	8bbd           	ae_sext16	a11, a11
    1e1f:	781ba6        	blti	a11, 1, 1e9b <LD_NR_fir_proc2+0xef>
    1e22:	0316b4        	wur.ae_sar	a11
    1e25:	088c76        	loop	a12, 1e31 <LD_NR_fir_proc2+0x85>
    1e28:	0b0084        	ae_sllssp24s	aep0, aep0
    1e2b:	5e8814        	ae_sp24x2f.iu	aep0, a8, 8
    1e2e:	5c8914        	ae_lp24x2f.iu	aep0, a9, 8

00001e31 <LD_NR_fir_proc2+0x85>:
    1e31:	04ad           	mov.n	a10, a4
    1e33:	03bd           	mov.n	a11, a3
    1e35:	f8c681        	l32r	a8, 150 (1c2c <fn_calc_pow>)
    1e38:	00a0c2        	movi	a12, 0
    1e3b:	01a1d2        	movi	a13, 0x101
    1e3e:	0008e0        	callx8	a8
    1e41:	829582        	l16si	a8, a5, 0x104
    1e44:	190c           	movi.n	a9, 1
    1e46:	0d0c           	movi.n	a13, 0
    1e48:	641826        	beqi	a8, 1, 1eb0 <LD_NR_fir_proc2+0x104>
    1e4b:	fec8a2        	addi	a10, a8, -2
    1e4e:	83d9a0        	moveqz	a13, a9, a10
    1e51:	8355d2        	s16i	a13, a5, 0x106

00001e54 <LD_NR_fir_proc2+0xa8>:
    1e54:	03bd           	mov.n	a11, a3
    1e56:	04cd           	mov.n	a12, a4
    1e58:	f8bf81        	l32r	a8, 154 (103c <fn_st_noise_est>)
    1e5b:	19d2a2        	addmi	a10, a2, 0x1900
    1e5e:	9ccaa2        	addi	a10, a10, -100
    1e61:	0008e0        	callx8	a8
    1e64:	03bd           	mov.n	a11, a3
    1e66:	04cd           	mov.n	a12, a4
    1e68:	03dd           	mov.n	a13, a3
    1e6a:	0e0c           	movi.n	a14, 0
    1e6c:	f8bb81        	l32r	a8, 158 (15b4 <fn_calc_sup_gain>)
    1e6f:	15d2a2        	addmi	a10, a2, 0x1500
    1e72:	8ccaa2        	addi	a10, a10, -116
    1e75:	0008e0        	callx8	a8
    1e78:	03ad           	mov.n	a10, a3
    1e7a:	f8b881        	l32r	a8, 15c (f70 <mel_filter16>)
    1e7d:	04bd           	mov.n	a11, a4
    1e7f:	0c0c           	movi.n	a12, 0
    1e81:	0008e0        	callx8	a8
    1e84:	04ad           	mov.n	a10, a4
    1e86:	f8b681        	l32r	a8, 160 (1c54 <gen_filter_coef>)
    1e89:	14d2b2        	addmi	a11, a2, 0x1400
    1e8c:	d8cbb2        	addi	a11, a11, -40
    1e8f:	0008e0        	callx8	a8
    1e92:	020c           	movi.n	a2, 0
    1e94:	7a5522        	s16i	a2, a5, 244
    1e97:	f01d           	retw.n

00001e99 <LD_NR_fir_proc2+0xed>:
	...

00001e9b <LD_NR_fir_proc2+0xef>:
    1e9b:	60a0b0        	neg	a10, a11
    1e9e:	0316a4        	wur.ae_sar	a10
    1ea1:	088c76        	loop	a12, 1ead <LD_NR_fir_proc2+0x101>
    1ea4:	0b0384        	ae_srasp24	aep0, aep0
    1ea7:	5e8814        	ae_sp24x2f.iu	aep0, a8, 8
    1eaa:	5c8914        	ae_lp24x2f.iu	aep0, a9, 8

00001ead <LD_NR_fir_proc2+0x101>:
    1ead:	ffe006        	j	1e31 <LD_NR_fir_proc2+0x85>

00001eb0 <LD_NR_fir_proc2+0x104>:
    1eb0:	03bd           	mov.n	a11, a3
    1eb2:	f8ac81        	l32r	a8, 164 (b88 <fn_pitch_detection>)
    1eb5:	1fd2a2        	addmi	a10, a2, 0x1f00
    1eb8:	5ccaa2        	addi	a10, a10, 92
    1ebb:	0008e0        	callx8	a8
    1ebe:	0add           	mov.n	a13, a10
    1ec0:	8355a2        	s16i	a10, a5, 0x106
    1ec3:	ffe346        	j	1e54 <LD_NR_fir_proc2+0xa8>

00001ec6 <LD_NR_fir_proc2+0x11a>:
	...

00001ec8 <LD_NR_fir_proc1>:
    1ec8:	006136        	entry	a1, 48
    1ecb:	2149           	s32i.n	a4, a1, 8
    1ecd:	f860f1        	l32r	a15, 50 (7fffffff <_end+0x7fff931b>)
    1ed0:	404010        	ssai	16
    1ed3:	f8a5b1        	l32r	a11, 168 (7d70a4 <_end+0x7d03c0>)
    1ed6:	039d           	mov.n	a9, a3
    1ed8:	03d8           	l32i.n	a13, a3, 0
    1eda:	13d2c2        	addmi	a12, a2, 0x1300
    1edd:	332c82        	l32i	a8, a12, 204
    1ee0:	f37c           	movi.n	a3, -1
    1ee2:	ccccc2        	addi	a12, a12, -52
    1ee5:	31c9           	s32i.n	a12, a1, 12
    1ee7:	82a8b0        	mull	a10, a8, a11
    1eea:	08d2c2        	addmi	a12, a2, 0x800
    1eed:	b288b0        	mulsh	a8, a8, a11
    1ef0:	cc4b           	addi.n	a12, a12, 4
    1ef2:	31bfd0        	srai	a11, a13, 31
    1ef5:	81bbd0        	src	a11, a11, a13
    1ef8:	21e780        	srai	a14, a8, 7
    1efb:	11dd00        	slli	a13, a13, 16
    1efe:	404700        	ssai	7
    1f01:	8188a0        	src	a8, a8, a10
    1f04:	c0bbe0        	sub	a11, a11, a14
    1f07:	404010        	ssai	16
    1f0a:	c08d80        	sub	a8, a13, a8
    1f0d:	f85aa1        	l32r	a10, 78 (8000 <_end+0x131c>)
    1f10:	62dd80        	saltu	a13, a13, a8
    1f13:	c0bbd0        	sub	a11, a11, a13
    1f16:	0d0c           	movi.n	a13, 0
    1f18:	e8aa           	add.n	a14, a8, a10
    1f1a:	628e80        	saltu	a8, a14, a8
    1f1d:	0d7d           	mov.n	a7, a13
    1f1f:	8088b0        	add	a8, a8, a11
    1f22:	f84bb1        	l32r	a11, 50 (7fffffff <_end+0x7fff931b>)
    1f25:	81e8e0        	src	a14, a8, a14
    1f28:	318080        	srai	a8, a8, 16
    1f2b:	004896        	bltz	a8, 1f33 <LD_NR_fir_proc1+0x6b>
    1f2e:	1d8816        	beqz	a8, 210a <LD_NR_fir_proc1+0x242>

00001f31 <LD_NR_fir_proc1+0x69>:
    1f31:	170c           	movi.n	a7, 1

00001f33 <LD_NR_fir_proc1+0x6b>:
    1f33:	172716        	beqz	a7, 20a9 <LD_NR_fir_proc1+0x1e1>
    1f36:	f84661        	l32r	a6, 50 (7fffffff <_end+0x7fff931b>)

00001f39 <LD_NR_fir_proc1+0x71>:
    1f39:	1199           	s32i.n	a9, a1, 4
    1f3b:	0c69           	s32i.n	a6, a12, 0
    1f3d:	8c4b           	addi.n	a8, a12, 4
    1f3f:	0129           	s32i.n	a2, a1, 0
    1f41:	efa0e2        	movi	a14, 239
    1f44:	04ae72        	movi	a7, 0xfffffe04
    1f47:	797a           	add.n	a7, a9, a7
    1f49:	55ae76        	loopgtz	a14, 1fa2 <LD_NR_fir_proc1+0xda>
    1f4c:	f887e1        	l32r	a14, 168 (7d70a4 <_end+0x7d03c0>)
    1f4f:	7f2792        	l32i	a9, a7, 0x1fc
    1f52:	404010        	ssai	16
    1f55:	802722        	l32i	a2, a7, 0x200
    1f58:	82c9e0        	mull	a12, a9, a14
    1f5b:	b299e0        	mulsh	a9, a9, a14
    1f5e:	31ef20        	srai	a14, a2, 31
    1f61:	81ee20        	src	a14, a14, a2
    1f64:	215790        	srai	a5, a9, 7
    1f67:	112200        	slli	a2, a2, 16
    1f6a:	404700        	ssai	7
    1f6d:	8199c0        	src	a9, a9, a12
    1f70:	c0ee50        	sub	a14, a14, a5
    1f73:	404010        	ssai	16
    1f76:	c09290        	sub	a9, a2, a9
    1f79:	c9aa           	add.n	a12, a9, a10
    1f7b:	622290        	saltu	a2, a2, a9
    1f7e:	c0ee20        	sub	a14, a14, a2
    1f81:	eeda           	add.n	a14, a14, a13
    1f83:	629c90        	saltu	a9, a12, a9
    1f86:	99ea           	add.n	a9, a9, a14
    1f88:	0e0c           	movi.n	a14, 0
    1f8a:	81c9c0        	src	a12, a9, a12
    1f8d:	319090        	srai	a9, a9, 16
    1f90:	0429d7        	blt	a9, a13, 1f98 <LD_NR_fir_proc1+0xd0>
    1f93:	3119d7        	beq	a9, a13, 1fc8 <LD_NR_fir_proc1+0x100>

00001f96 <LD_NR_fir_proc1+0xce>:
    1f96:	1e0c           	movi.n	a14, 1

00001f98 <LD_NR_fir_proc1+0xd0>:
    1f98:	774b           	addi.n	a7, a7, 4
    1f9a:	0ebc           	beqz.n	a14, 1fce <LD_NR_fir_proc1+0x106>
    1f9c:	f82d61        	l32r	a6, 50 (7fffffff <_end+0x7fff931b>)

00001f9f <LD_NR_fir_proc1+0xd7>:
    1f9f:	09e864        	ae_s32ip	a6, a8, 4

00001fa2 <LD_NR_fir_proc1+0xda>:
    1fa2:	1158           	l32i.n	a5, a1, 4
    1fa4:	3138           	l32i.n	a3, a1, 12
    1fa6:	01b8           	l32i.n	a11, a1, 0
    1fa8:	ef2552        	l32i	a5, a5, 0x3bc
    1fab:	406352        	s32i	a5, a3, 0x100
    1fae:	829332        	l16si	a3, a3, 0x104
    1fb1:	04dbb2        	addmi	a11, a11, 0x400
    1fb4:	c0cbb2        	addi	a11, a11, -64
    1fb7:	f3ec           	bnez.n	a3, 1fea <LD_NR_fir_proc1+0x122>
    1fb9:	31e8           	l32i.n	a14, a1, 12
    1fbb:	7c9ee2        	l16si	a14, a14, 248
    1fbe:	021e26        	beqi	a14, 1, 1fc4 <LD_NR_fir_proc1+0xfc>
    1fc1:	003e06        	j	20bd <LD_NR_fir_proc1+0x1f5>
    1fc4:	005586        	j	211e <LD_NR_fir_proc1+0x256>

00001fc7 <LD_NR_fir_proc1+0xff>:
	...

00001fc8 <LD_NR_fir_proc1+0x100>:
    1fc8:	ccbbc7        	bgeu	a11, a12, 1f98 <LD_NR_fir_proc1+0xd0>
    1fcb:	fff1c6        	j	1f96 <LD_NR_fir_proc1+0xce>

00001fce <LD_NR_fir_proc1+0x106>:
    1fce:	0e0c           	movi.n	a14, 0
    1fd0:	042397        	blt	a3, a9, 1fd8 <LD_NR_fir_proc1+0x110>
    1fd3:	0a1937        	beq	a9, a3, 1fe1 <LD_NR_fir_proc1+0x119>

00001fd6 <LD_NR_fir_proc1+0x10e>:
    1fd6:	1e0c           	movi.n	a14, 1

00001fd8 <LD_NR_fir_proc1+0x110>:
    1fd8:	f81f61        	l32r	a6, 54 (80000000 <_end+0x7fff931c>)
    1fdb:	836ce0        	moveqz	a6, a12, a14
    1fde:	ffef46        	j	1f9f <LD_NR_fir_proc1+0xd7>

00001fe1 <LD_NR_fir_proc1+0x119>:
    1fe1:	f33fc7        	bltu	a15, a12, 1fd8 <LD_NR_fir_proc1+0x110>
    1fe4:	fffb86        	j	1fd6 <LD_NR_fir_proc1+0x10e>

00001fe7 <LD_NR_fir_proc1+0x11f>:
    1fe7:	000000                                        ...

00001fea <LD_NR_fir_proc1+0x122>:
    1fea:	0c0c           	movi.n	a12, 0

00001fec <LD_NR_fir_proc1+0x124>:
    1fec:	830b           	addi.n	a8, a3, -1
    1fee:	d32c           	movi.n	a3, 45
    1ff0:	0f1816        	beqz	a8, 20e5 <LD_NR_fir_proc1+0x21d>

00001ff3 <LD_NR_fir_proc1+0x12b>:
    1ff3:	d42c           	movi.n	a4, 45
    1ff5:	0188           	l32i.n	a8, a1, 0
    1ff7:	07dba2        	addmi	a10, a11, 0x700
    1ffa:	54caa2        	addi	a10, a10, 84
    1ffd:	14d892        	addmi	a9, a8, 0x1400
    2000:	07d872        	addmi	a7, a8, 0x700
    2003:	54c772        	addi	a7, a7, 84
    2006:	fe2483299e 	{ addi	a9, a9, 50; ae_zeroq56	aeq2 }
    200b:	fc1453399f 	{ or	a3, a9, a9; ae_movq56	aeq0, aeq2 }

00002010 <LD_NR_fir_proc1+0x148>:
    2010:	408304        	ae_lp16f.iu	aep0, a3, 0
    2013:	072d           	mov.n	a2, a7
    2015:	605204        	ae_lq32f.iu	aeq1, a2, 0
    2018:	774b           	addi.n	a7, a7, 4
    201a:	0020f0        	nop
    201d:	078476        	loop	a4, 2028 <LD_NR_fir_proc1+0x160>
    2020:	f483bd321f 	{ ae_lq32f.iu	aeq1, a2, 4; ae_mulafq32sp16s.l	aeq0, aeq1, aep0 }
    2025:	408314        	ae_lp16f.iu	aep0, a3, 2

00002028 <LD_NR_fir_proc1+0x160>:
    2028:	d42c           	movi.n	a4, 45
    202a:	fc2453399f 	{ or	a3, a9, a9; ae_roundsq32asym	aeq0, aeq0 }

0000202f <LD_NR_fir_proc1+0x167>:
    202f:	fc1479c81f 	{ ae_sq32f.iu	aeq0, a8, 4; ae_movq56	aeq0, aeq2 }
    2034:	d897a7        	bne	a7, a10, 2010 <LD_NR_fir_proc1+0x148>
    2037:	0138           	l32i.n	a3, a1, 0
    2039:	10a142        	movi	a4, 0x110
    203c:	08d332        	addmi	a3, a3, 0x800
    203f:	84c332        	addi	a3, a3, -124
    2042:	601304        	ae_lq32f.iu	aeq0, a3, 0
    2045:	058476        	loop	a4, 204e <LD_NR_fir_proc1+0x186>
    2048:	624b14        	ae_sq32f.iu	aeq0, a11, 4
    204b:	601314        	ae_lq32f.iu	aeq0, a3, 4

0000204e <LD_NR_fir_proc1+0x186>:
    204e:	2128           	l32i.n	a2, a1, 8
    2050:	3148           	l32i.n	a4, a1, 12
    2052:	0138           	l32i.n	a3, a1, 0
    2054:	f84551        	l32r	a5, 168 (7d70a4 <_end+0x7d03c0>)
    2057:	398554        	ae_movpa24x2	aep0, a5, a5
    205a:	334b           	addi.n	a3, a3, 4
    205c:	3f2442        	l32i	a4, a4, 252
    205f:	368434        	ae_cvtq48a32s	aeq2, a4
    2062:	605304        	ae_lq32f.iu	aeq1, a3, 0
    2065:	080b94        	ae_mularfq32sp24s.l	aeq1, aeq2, aep0
    2068:	efa042        	movi	a4, 239
    206b:	625204        	ae_sq32f.iu	aeq1, a2, 0
    206e:	601314        	ae_lq32f.iu	aeq0, a3, 4
    2071:	0a8476        	loop	a4, 207f <LD_NR_fir_proc1+0x1b7>
    2074:	080354        	ae_mularfq32sp24s.l	aeq0, aeq1, aep0
    2077:	fd0479c21f 	{ ae_sq32f.iu	aeq0, a2, 4; ae_movq56	aeq1, aeq0 }
    207c:	601314        	ae_lq32f.iu	aeq0, a3, 4
    207f:	3188           	l32i.n	a8, a1, 12
    2081:	2198           	l32i.n	a9, a1, 8
    2083:	829852        	l16si	a5, a8, 0x104
    2086:	02d992        	addmi	a9, a9, 0x200
    2089:	c0c992        	addi	a9, a9, -64
    208c:	7f2992        	l32i	a9, a9, 0x1fc
    208f:	3f6892        	s32i	a9, a8, 252
    2092:	551b           	addi.n	a5, a5, 1
    2094:	855d           	ae_sext16	a5, a5
    2096:	825852        	s16i	a5, a8, 0x104
    2099:	0325e6        	bgei	a5, 2, 20a0 <LD_NR_fir_proc1+0x1d8>
    209c:	0c2d           	mov.n	a2, a12
    209e:	f01d           	retw.n

000020a0 <LD_NR_fir_proc1+0x1d8>:
    20a0:	0c2d           	mov.n	a2, a12
    20a2:	0b0c           	movi.n	a11, 0
    20a4:	8258b2        	s16i	a11, a8, 0x104
    20a7:	f01d           	retw.n

000020a9 <LD_NR_fir_proc1+0x1e1>:
    20a9:	070c           	movi.n	a7, 0
    20ab:	042387        	blt	a3, a8, 20b3 <LD_NR_fir_proc1+0x1eb>
    20ae:	661837        	beq	a8, a3, 2118 <LD_NR_fir_proc1+0x250>

000020b1 <LD_NR_fir_proc1+0x1e9>:
    20b1:	170c           	movi.n	a7, 1

000020b3 <LD_NR_fir_proc1+0x1eb>:
    20b3:	f7e861        	l32r	a6, 54 (80000000 <_end+0x7fff931c>)
    20b6:	836e70        	moveqz	a6, a14, a7
    20b9:	ff9f06        	j	1f39 <LD_NR_fir_proc1+0x71>

000020bc <LD_NR_fir_proc1+0x1f4>:
	...

000020bd <LD_NR_fir_proc1+0x1f5>:
    20bd:	00a242        	movi	a4, 0x200
    20c0:	0128           	l32i.n	a2, a1, 0
    20c2:	0b3d           	mov.n	a3, a11
    20c4:	601314        	ae_lq32f.iu	aeq0, a3, 4
    20c7:	0cd222        	addmi	a2, a2, 0xc00
    20ca:	c0c222        	addi	a2, a2, -64
    20cd:	058476        	loop	a4, 20d6 <LD_NR_fir_proc1+0x20e>
    20d0:	624214        	ae_sq32f.iu	aeq0, a2, 4
    20d3:	601314        	ae_lq32f.iu	aeq0, a3, 4

000020d6 <LD_NR_fir_proc1+0x20e>:
    20d6:	3138           	l32i.n	a3, a1, 12
    20d8:	0c0c           	movi.n	a12, 0
    20da:	150c           	movi.n	a5, 1
    20dc:	7c5352        	s16i	a5, a3, 248
    20df:	829332        	l16si	a3, a3, 0x104
    20e2:	ffc186        	j	1fec <LD_NR_fir_proc1+0x124>

000020e5 <LD_NR_fir_proc1+0x21d>:
    20e5:	3188           	l32i.n	a8, a1, 12
    20e7:	7c9882        	l16si	a8, a8, 248
    20ea:	58ec           	bnez.n	a8, 2113 <LD_NR_fir_proc1+0x24b>
    20ec:	0198           	l32i.n	a9, a1, 0
    20ee:	034d           	mov.n	a4, a3
    20f0:	14d992        	addmi	a9, a9, 0x1400
    20f3:	30c922        	addi	a2, a9, 48
    20f6:	d6c992        	addi	a9, a9, -42
    20f9:	408914        	ae_lp16f.iu	aep0, a9, 2
    20fc:	093d           	mov.n	a3, a9
    20fe:	058476        	loop	a4, 2107 <LD_NR_fir_proc1+0x23f>
    2101:	428214        	ae_sp16f.l.iu	aep0, a2, 2
    2104:	408314        	ae_lp16f.iu	aep0, a3, 2

00002107 <LD_NR_fir_proc1+0x23f>:
    2107:	ffba06        	j	1ff3 <LD_NR_fir_proc1+0x12b>

0000210a <LD_NR_fir_proc1+0x242>:
    210a:	023be7        	bltu	a11, a14, 2110 <LD_NR_fir_proc1+0x248>
    210d:	ff8886        	j	1f33 <LD_NR_fir_proc1+0x6b>
    2110:	ff8746        	j	1f31 <LD_NR_fir_proc1+0x69>

00002113 <LD_NR_fir_proc1+0x24b>:
    2113:	1c0c           	movi.n	a12, 1
    2115:	ffb686        	j	1ff3 <LD_NR_fir_proc1+0x12b>

00002118 <LD_NR_fir_proc1+0x250>:
    2118:	973fe7        	bltu	a15, a14, 20b3 <LD_NR_fir_proc1+0x1eb>
    211b:	ffe486        	j	20b1 <LD_NR_fir_proc1+0x1e9>

0000211e <LD_NR_fir_proc1+0x256>:
    211e:	2c0c           	movi.n	a12, 2
    2120:	ffb206        	j	1fec <LD_NR_fir_proc1+0x124>

00002123 <LD_NR_fir_proc1+0x25b>:
    2123:	00000000 00413600                                .....

00002128 <real_512_fft_1>:
    2128:	004136        	entry	a1, 32
    212b:	026d           	mov.n	a6, a2
    212d:	fcc352        	addi	a5, a3, -4
    2130:	f80f21        	l32r	a2, 16c (3fd0 <LD_NR_fftorder_512>)
    2133:	00a132        	movi	a3, 0x100
    2136:	1e8376        	loop	a3, 2158 <real_512_fft_1+0x30>
    2139:	223d           	ae_l16si.n	a3, a2, 0
    213b:	222b           	addi.n	a2, a2, 2
    213d:	431b           	addi.n	a4, a3, 1
    213f:	b34330        	movgez	a4, a3, a3
    2142:	213140        	srai	a3, a4, 1
    2145:	833d           	ae_sext16	a3, a3
    2147:	1133d0        	slli	a3, a3, 3
    214a:	602634        	ae_lq32f.x	aeq0, a6, a3
    214d:	334b           	addi.n	a3, a3, 4
    214f:	620514        	ae_sq32f.i	aeq0, a5, 4
    2152:	602634        	ae_lq32f.x	aeq0, a6, a3
    2155:	624524        	ae_sq32f.iu	aeq0, a5, 8

00002158 <real_512_fft_1+0x30>:
    2158:	020c           	movi.n	a2, 0
    215a:	f01d           	retw.n

0000215c <real_512_fft_2>:
    215c:	004136        	entry	a1, 32
    215f:	03ad           	mov.n	a10, a3
    2161:	00a1b2        	movi	a11, 0x100
    2164:	8c0c           	movi.n	a12, 8
    2166:	f80281        	l32r	a8, 170 (2cd8 <LDNR_sw_fft_32b_2811>)
    2169:	1d0c           	movi.n	a13, 1
    216b:	1e0c           	movi.n	a14, 1
    216d:	0008e0        	callx8	a8
    2170:	2a2b           	addi.n	a2, a10, 2
    2172:	822d           	ae_sext16	a2, a2
    2174:	f01d           	retw.n

00002176 <real_512_fft_2+0x1a>:
	...

00002178 <real_512_fft_3>:
    2178:	004136        	entry	a1, 32
    217b:	f7ff81        	l32r	a8, 178 (38b0 <LD_NR_B_RI>)
    217e:	00a242        	movi	a4, 0x200
    2181:	f7fc51        	l32r	a5, 174 (34b0 <LD_NR_A_RI>)
    2184:	029d           	mov.n	a9, a2
    2186:	206330        	or	a6, a3, a3
    2189:	fcc222        	addi	a2, a2, -4
    218c:	601304        	ae_lq32f.iu	aeq0, a3, 0
    218f:	06d6b2        	addmi	a11, a6, 0x600
    2192:	44b504        	ae_lp16x2f.iu	aep3, a5, 0
    2195:	0b8476        	loop	a4, 21a4 <real_512_fft_3+0x2c>
    2198:	3500b4        	ae_sraiq56	aeq0, aeq0, 2
    219b:	060934        	ae_roundsq32asym	aeq0, aeq0
    219e:	624214        	ae_sq32f.iu	aeq0, a2, 4
    21a1:	601314        	ae_lq32f.iu	aeq0, a3, 4

000021a4 <real_512_fft_3+0x2c>:
    21a4:	08d932        	addmi	a3, a9, 0x800
    21a7:	092d           	mov.n	a2, a9
    21a9:	601204        	ae_lq32f.iu	aeq0, a2, 0
    21ac:	d56e3d721f 	{ ae_lq32f.iu	aeq3, a2, 4; ae_mulfq32sp16s.h	aeq2, aeq0, aep3 }
    21b1:	033ac4        	ae_mulfq32sp16s.h	aeq1, aeq3, aep3
    21b4:	fb8dada80f 	{ ae_lp16x2f.iu	aep2, a8, 0; ae_mulsfq32sp16s.l	aeq2, aeq3, aep3 }
    21b9:	03a004        	ae_mulafq32sp16s.h	aeq2, aeq0, aep2
    21bc:	033814        	ae_mulafq32sp16s.l	aeq1, aeq0, aep3
    21bf:	032814        	ae_mulafq32sp16s.l	aeq1, aeq0, aep2
    21c2:	f78b8000af 	{ movi	a10, 0; ae_mulafq32sp16s.l	aeq2, aeq3, aep2 }
    21c7:	fa09cfc64e 	{ addi	a4, a6, -4; ae_mulsfq32sp16s.h	aeq1, aeq3, aep2 }
    21cc:	f8a6f9e41f 	{ ae_sq32f.iu	aeq2, a4, 4; ae_subq56	aeq0, aeq0, aeq3 }
    21d1:	ff00f9d41f 	{ ae_sq32f.iu	aeq1, a4, 4; ae_satq48s	aeq3, aeq0 }
    21d6:	816ba2        	s32i	a10, a11, 0x204
    21d9:	36bc04        	ae_trunca32q48	a12, aeq3
    21dc:	806bc2        	s32i	a12, a11, 0x200
    21df:	449514        	ae_lp16x2f.iu	aep1, a5, 4
    21e2:	601214        	ae_lq32f.iu	aeq0, a2, 4
    21e5:	608214        	ae_lq32f.i	aeq2, a2, 4
    21e8:	031a84        	ae_mulfq32sp16s.h	aeq1, aeq2, aep1
    21eb:	039a04        	ae_mulfq32sp16s.h	aeq3, aeq0, aep1

000021ee <real_512_fft_3+0x76>:
    21ee:	fb84fd53ef 	{ ae_lq32f.iu	aeq2, a3, -8; ae_mulsfq32sp16s.l	aeq3, aeq2, aep1 }
    21f3:	f486ed881f 	{ ae_lp16x2f.iu	aep0, a8, 4; ae_mulafq32sp16s.l	aeq1, aeq0, aep1 }
    21f8:	030894        	ae_mulafq32sp16s.l	aeq1, aeq2, aep0
    21fb:	f702fd031f 	{ ae_lq32f.i	aeq0, a3, 4; ae_mulafq32sp16s.h	aeq3, aeq2, aep0 }
    2200:	f582c0fe7f 	{ movi	a7, 254; ae_mulafq32sp16s.l	aeq3, aeq0, aep0 }
    2205:	f800d3688f 	{ or	a6, a8, a8; ae_mulsfq32sp16s.h	aeq1, aeq0, aep0 }
    220a:	fe3c53d33f 	{ or	a13, a3, a3; ae_roundsq32asym	aeq2, aeq3 }
    220f:	fc2c79a41f 	{ ae_sq32f.i	aeq2, a4, 4; ae_roundsq32asym	aeq0, aeq1 }
    2214:	624424        	ae_sq32f.iu	aeq0, a4, 8
    2217:	448514        	ae_lp16x2f.iu	aep0, a5, 4
    221a:	605224        	ae_lq32f.iu	aeq1, a2, 8
    221d:	308776        	loop	a7, 2251 <real_512_fft_3+0xd9>
    2220:	d5633d021f 	{ ae_lq32f.i	aeq0, a2, 4; ae_mulfq32sp16s.h	aeq2, aeq1, aep0 }
    2225:	f980bd6dff 	{ ae_lq32f.i	aeq3, a13, -4; ae_mulsfq32sp16s.l	aeq2, aeq0, aep0 }
    222a:	d4622d961f 	{ ae_lp16x2f.iu	aep1, a6, 4; ae_mulfq32sp16s.h	aeq0, aeq0, aep0 }
    222f:	f483bd3def 	{ ae_lq32f.iu	aeq1, a13, -8; ae_mulafq32sp16s.l	aeq0, aeq1, aep0 }
    2234:	039044        	ae_mulafq32sp16s.h	aeq2, aeq1, aep1
    2237:	031054        	ae_mulafq32sp16s.l	aeq0, aeq1, aep1
    223a:	0390d4        	ae_mulafq32sp16s.l	aeq2, aeq3, aep1
    223d:	0314c4        	ae_mulsfq32sp16s.h	aeq0, aeq3, aep1
    2240:	06e934        	ae_roundsq32asym	aeq3, aeq2
    2243:	fc2479b41f 	{ ae_sq32f.i	aeq3, a4, 4; ae_roundsq32asym	aeq0, aeq0 }
    2248:	624424        	ae_sq32f.iu	aeq0, a4, 8
    224b:	605224        	ae_lq32f.iu	aeq1, a2, 8
    224e:	448514        	ae_lp16x2f.iu	aep0, a5, 4

00002251 <real_512_fft_3+0xd9>:
    2251:	020c           	movi.n	a2, 0
    2253:	f01d           	retw.n

00002255 <real_512_fft_3+0xdd>:
    2255:	000000                                        ...

00002258 <real_512_fft_0>:
    2258:	004136        	entry	a1, 32
    225b:	fcc252        	addi	a5, a2, -4
    225e:	f7c381        	l32r	a8, 16c (3fd0 <LD_NR_fftorder_512>)
    2261:	00a192        	movi	a9, 0x100
    2264:	fcc342        	addi	a4, a3, -4
    2267:	04bd           	mov.n	a11, a4
    2269:	1e8976        	loop	a9, 228b <real_512_fft_0+0x33>
    226c:	289d           	ae_l16si.n	a9, a8, 0
    226e:	882b           	addi.n	a8, a8, 2
    2270:	a91b           	addi.n	a10, a9, 1
    2272:	b3a990        	movgez	a10, a9, a9
    2275:	2191a0        	srai	a9, a10, 1
    2278:	899d           	ae_sext16	a9, a9
    227a:	1199d0        	slli	a9, a9, 3
    227d:	602294        	ae_lq32f.x	aeq0, a2, a9
    2280:	994b           	addi.n	a9, a9, 4
    2282:	620b14        	ae_sq32f.i	aeq0, a11, 4
    2285:	602294        	ae_lq32f.x	aeq0, a2, a9
    2288:	624b24        	ae_sq32f.iu	aeq0, a11, 8

0000228b <real_512_fft_0+0x33>:
    228b:	03ad           	mov.n	a10, a3
    228d:	00a1b2        	movi	a11, 0x100
    2290:	8c0c           	movi.n	a12, 8
    2292:	f7b781        	l32r	a8, 170 (2cd8 <LDNR_sw_fft_32b_2811>)
    2295:	1d0c           	movi.n	a13, 1
    2297:	1e0c           	movi.n	a14, 1
    2299:	0008e0        	callx8	a8
    229c:	028d           	mov.n	a8, a2
    229e:	f7b6c1        	l32r	a12, 178 (38b0 <LD_NR_B_RI>)
    22a1:	f7b4b1        	l32r	a11, 174 (34b0 <LD_NR_A_RI>)
    22a4:	0afd           	mov.n	a15, a10
    22a6:	039d           	mov.n	a9, a3
    22a8:	601904        	ae_lq32f.iu	aeq0, a9, 0
    22ab:	00a2a2        	movi	a10, 0x200
    22ae:	44bb04        	ae_lp16x2f.iu	aep3, a11, 0
    22b1:	0b8a76        	loop	a10, 22c0 <real_512_fft_0+0x68>
    22b4:	3500b4        	ae_sraiq56	aeq0, aeq0, 2
    22b7:	060934        	ae_roundsq32asym	aeq0, aeq0
    22ba:	624514        	ae_sq32f.iu	aeq0, a5, 4
    22bd:	601914        	ae_lq32f.iu	aeq0, a9, 4
    22c0:	06d3a2        	addmi	a10, a3, 0x600
    22c3:	601804        	ae_lq32f.iu	aeq0, a8, 0
    22c6:	d56e3d781f 	{ ae_lq32f.iu	aeq3, a8, 4; ae_mulfq32sp16s.h	aeq2, aeq0, aep3 }
    22cb:	033ac4        	ae_mulfq32sp16s.h	aeq1, aeq3, aep3
    22ce:	fb8dadac0f 	{ ae_lp16x2f.iu	aep2, a12, 0; ae_mulsfq32sp16s.l	aeq2, aeq3, aep3 }
    22d3:	03a004        	ae_mulafq32sp16s.h	aeq2, aeq0, aep2
    22d6:	033814        	ae_mulafq32sp16s.l	aeq1, aeq0, aep3
    22d9:	032814        	ae_mulafq32sp16s.l	aeq1, aeq0, aep2
    22dc:	03a0d4        	ae_mulafq32sp16s.l	aeq2, aeq3, aep2
    22df:	fa09c0009f 	{ movi	a9, 0; ae_mulsfq32sp16s.h	aeq1, aeq3, aep2 }
    22e4:	f8a6f9e41f 	{ ae_sq32f.iu	aeq2, a4, 4; ae_subq56	aeq0, aeq0, aeq3 }
    22e9:	ff00f9d41f 	{ ae_sq32f.iu	aeq1, a4, 4; ae_satq48s	aeq3, aeq0 }
    22ee:	816a92        	s32i	a9, a10, 0x204
    22f1:	36bd04        	ae_trunca32q48	a13, aeq3
    22f4:	08d292        	addmi	a9, a2, 0x800
    22f7:	806ad2        	s32i	a13, a10, 0x200
    22fa:	449b14        	ae_lp16x2f.iu	aep1, a11, 4
    22fd:	601814        	ae_lq32f.iu	aeq0, a8, 4
    2300:	608814        	ae_lq32f.i	aeq2, a8, 4
    2303:	031a84        	ae_mulfq32sp16s.h	aeq1, aeq2, aep1
    2306:	039a04        	ae_mulfq32sp16s.h	aeq3, aeq0, aep1
    2309:	fb84ed8c1f 	{ ae_lp16x2f.iu	aep0, a12, 4; ae_mulsfq32sp16s.l	aeq3, aeq2, aep1 }
    230e:	f486fd59ef 	{ ae_lq32f.iu	aeq2, a9, -8; ae_mulafq32sp16s.l	aeq1, aeq0, aep1 }
    2313:	030894        	ae_mulafq32sp16s.l	aeq1, aeq2, aep0
    2316:	f702fd091f 	{ ae_lq32f.i	aeq0, a9, 4; ae_mulafq32sp16s.h	aeq3, aeq2, aep0 }
    231b:	038814        	ae_mulafq32sp16s.l	aeq3, aeq0, aep0
    231e:	f800c02f2e 	{ addi	a2, a15, 2; ae_mulsfq32sp16s.h	aeq1, aeq0, aep0 }
    2323:	fe3c40fedf 	{ movi	a13, 254; ae_roundsq32asym	aeq2, aeq3 }
    2328:	fc2c79a41f 	{ ae_sq32f.i	aeq2, a4, 4; ae_roundsq32asym	aeq0, aeq1 }
    232d:	624424        	ae_sq32f.iu	aeq0, a4, 8
    2330:	04ad           	mov.n	a10, a4
    2332:	448b14        	ae_lp16x2f.iu	aep0, a11, 4
    2335:	605824        	ae_lq32f.iu	aeq1, a8, 8
    2338:	308d76        	loop	a13, 236c <real_512_fft_0+0x114>
    233b:	d5633d081f 	{ ae_lq32f.i	aeq0, a8, 4; ae_mulfq32sp16s.h	aeq2, aeq1, aep0 }
    2340:	f980bd69ff 	{ ae_lq32f.i	aeq3, a9, -4; ae_mulsfq32sp16s.l	aeq2, aeq0, aep0 }
    2345:	d4622d9c1f 	{ ae_lp16x2f.iu	aep1, a12, 4; ae_mulfq32sp16s.h	aeq0, aeq0, aep0 }

0000234a <real_512_fft_0+0xf2>:
    234a:	f483bd39ef 	{ ae_lq32f.iu	aeq1, a9, -8; ae_mulafq32sp16s.l	aeq0, aeq1, aep0 }
    234f:	039044        	ae_mulafq32sp16s.h	aeq2, aeq1, aep1
    2352:	031054        	ae_mulafq32sp16s.l	aeq0, aeq1, aep1
    2355:	0390d4        	ae_mulafq32sp16s.l	aeq2, aeq3, aep1
    2358:	0314c4        	ae_mulsfq32sp16s.h	aeq0, aeq3, aep1
    235b:	06e934        	ae_roundsq32asym	aeq3, aeq2
    235e:	fc2479ba1f 	{ ae_sq32f.i	aeq3, a10, 4; ae_roundsq32asym	aeq0, aeq0 }
    2363:	624a24        	ae_sq32f.iu	aeq0, a10, 8
    2366:	605824        	ae_lq32f.iu	aeq1, a8, 8
    2369:	448b14        	ae_lp16x2f.iu	aep0, a11, 4

0000236c <real_512_fft_0+0x114>:
    236c:	822d           	ae_sext16	a2, a2
    236e:	f01d           	retw.n

00002370 <LDNR_xt_memset>:
    2370:	004136        	entry	a1, 32
    2373:	026d           	mov.n	a6, a2
    2375:	828c           	beqz.n	a2, 2381 <LDNR_xt_memset+0x11>
    2377:	029476        	loopnez	a4, 237d <LDNR_xt_memset+0xd>
    237a:	09c234        	ae_s16ip	a3, a2, 2

0000237d <LDNR_xt_memset+0xd>:
    237d:	062d           	mov.n	a2, a6
    237f:	f01d           	retw.n

00002381 <LDNR_xt_memset+0x11>:
    2381:	020c           	movi.n	a2, 0
    2383:	f01d           	retw.n

00002385 <LDNR_xt_memset+0x15>:
    2385:	000000                                        ...

00002388 <LDNR_xt_memcpy>:
    2388:	004136        	entry	a1, 32
    238b:	027d           	mov.n	a7, a2
    238d:	032d           	mov.n	a2, a3
    238f:	043d           	mov.n	a3, a4
    2391:	07c716        	beqz	a7, 2411 <LDNR_xt_memcpy+0x89>
    2394:	079216        	beqz	a2, 2411 <LDNR_xt_memcpy+0x89>
    2397:	25b277        	bgeu	a2, a7, 23c0 <LDNR_xt_memcpy+0x38>
    239a:	904420        	addx2	a4, a4, a2
    239d:	1fb747        	bgeu	a7, a4, 23c0 <LDNR_xt_memcpy+0x38>
    23a0:	fec422        	addi	a2, a4, -2
    23a3:	530b           	addi.n	a5, a3, -1
    23a5:	904370        	addx2	a4, a3, a7
    23a8:	fec442        	addi	a4, a4, -2
    23ab:	5e0526        	beqi	a5, -1, 240d <LDNR_xt_memcpy+0x85>
    23ae:	099376        	loopnez	a3, 23bb <LDNR_xt_memcpy+0x33>
    23b1:	223d           	ae_l16si.n	a3, a2, 0
    23b3:	fec222        	addi	a2, a2, -2
    23b6:	fec442        	addi	a4, a4, -2
    23b9:	743d           	ae_s16i.n	a3, a4, 2

000023bb <LDNR_xt_memcpy+0x33>:
    23bb:	072d           	mov.n	a2, a7
    23bd:	f01d           	retw.n

000023bf <LDNR_xt_memcpy+0x37>:
	...

000023c0 <LDNR_xt_memcpy+0x38>:
    23c0:	074d           	mov.n	a4, a7
    23c2:	530b           	addi.n	a5, a3, -1
    23c4:	450526        	beqi	a5, -1, 240d <LDNR_xt_memcpy+0x85>
    23c7:	248030        	extui	a8, a3, 0, 3
    23ca:	036d           	mov.n	a6, a3
    23cc:	413360        	srli	a3, a6, 3
    23cf:	069876        	loopnez	a8, 23d9 <LDNR_xt_memcpy+0x51>
    23d2:	229d           	ae_l16si.n	a9, a2, 0
    23d4:	09c494        	ae_s16ip	a9, a4, 2
    23d7:	222b           	addi.n	a2, a2, 2
    23d9:	309376        	loopnez	a3, 240d <LDNR_xt_memcpy+0x85>
    23dc:	223d           	ae_l16si.n	a3, a2, 0
    23de:	09c434        	ae_s16ip	a3, a4, 2
    23e1:	323d           	ae_l16si.n	a3, a2, 2
    23e3:	09c434        	ae_s16ip	a3, a4, 2
    23e6:	029232        	l16si	a3, a2, 4
    23e9:	09c434        	ae_s16ip	a3, a4, 2
    23ec:	039232        	l16si	a3, a2, 6
    23ef:	09c434        	ae_s16ip	a3, a4, 2
    23f2:	049232        	l16si	a3, a2, 8
    23f5:	09c434        	ae_s16ip	a3, a4, 2
    23f8:	059232        	l16si	a3, a2, 10
    23fb:	09c434        	ae_s16ip	a3, a4, 2
    23fe:	069232        	l16si	a3, a2, 12
    2401:	09c434        	ae_s16ip	a3, a4, 2
    2404:	079232        	l16si	a3, a2, 14
    2407:	09c434        	ae_s16ip	a3, a4, 2
    240a:	10c222        	addi	a2, a2, 16
    240d:	072d           	mov.n	a2, a7
    240f:	f01d           	retw.n

00002411 <LDNR_xt_memcpy+0x89>:
    2411:	020c           	movi.n	a2, 0
    2413:	f01d           	retw.n

00002415 <LDNR_xt_memcpy+0x8d>:
    2415:	000000                                        ...

00002418 <xt_memcpy_s>:
    2418:	004136        	entry	a1, 32
    241b:	04cd           	mov.n	a12, a4
    241d:	f73081        	l32r	a8, e0 (2388 <LDNR_xt_memcpy>)
    2420:	03bd           	mov.n	a11, a3
    2422:	20a220        	or	a10, a2, a2
    2425:	0008e0        	callx8	a8
    2428:	f01d           	retw.n

0000242a <xt_memcpy_s+0x12>:
    242a:	00000000 61360000                                ......

00002430 <LDNR_xtensa_fft4_32b>:
    2430:	006136        	entry	a1, 48
    2433:	60c274        	ae_lq32f.i	aeq3, a2, 28
    2436:	608234        	ae_lq32f.i	aeq2, a2, 12
    2439:	600214        	ae_lq32f.i	aeq0, a2, 4
    243c:	f8e23d225f 	{ ae_lq32f.i	aeq1, a2, 20; ae_addq56	aeq0, aeq0, aeq2 }
    2441:	f9ee3d621f 	{ ae_lq32f.i	aeq3, a2, 4; ae_addq56	aeq1, aeq1, aeq3 }
    2446:	fa663a310f 	{ ae_sq56s.i	aeq3, a1, 0; ae_addq56	aeq2, aeq0, aeq1 }
    244b:	f826fd226f 	{ ae_lq32f.i	aeq1, a2, 24; ae_subq56	aeq0, aeq0, aeq1 }
    2450:	622214        	ae_sq32f.i	aeq2, a2, 4
    2453:	60c254        	ae_lq32f.i	aeq3, a2, 20
    2456:	620254        	ae_sq32f.i	aeq0, a2, 20
    2459:	608244        	ae_lq32f.i	aeq2, a2, 16
    245c:	600224        	ae_lq32f.i	aeq0, a2, 8
    245f:	f9ea3d420f 	{ ae_lq32f.i	aeq2, a2, 0; ae_addq56	aeq1, aeq1, aeq2 }
    2464:	01a8c4        	ae_addq56	aeq2, aeq2, aeq0
    2467:	0129c4        	ae_addq56	aeq0, aeq2, aeq1
    246a:	fa36fd220f 	{ ae_lq32f.i	aeq1, a2, 0; ae_subq56	aeq2, aeq2, aeq1 }
    246f:	620204        	ae_sq32f.i	aeq0, a2, 0
    2472:	600274        	ae_lq32f.i	aeq0, a2, 28
    2475:	fb3afd022f 	{ ae_lq32f.i	aeq0, a2, 8; ae_subq56	aeq3, aeq3, aeq0 }
    247a:	f92afd024f 	{ ae_lq32f.i	aeq0, a2, 16; ae_subq56	aeq1, aeq1, aeq0 }
    247f:	faaef9a24f 	{ ae_sq32f.i	aeq2, a2, 16; ae_subq56	aeq2, aeq1, aeq3 }
    2484:	f9ee3d626f 	{ ae_lq32f.i	aeq3, a2, 24; ae_addq56	aeq1, aeq1, aeq3 }
    2489:	fb3afd023f 	{ ae_lq32f.i	aeq0, a2, 12; ae_subq56	aeq3, aeq3, aeq0 }
    248e:	621224        	ae_sq32f.i	aeq1, a2, 8
    2491:	614104        	ae_lq56.i	aeq1, a1, 0
    2494:	015cc4        	ae_subq56	aeq1, aeq1, aeq0
    2497:	f8ee39a26f 	{ ae_sq32f.i	aeq2, a2, 24; ae_addq56	aeq0, aeq1, aeq3 }
    249c:	f9aef9823f 	{ ae_sq32f.i	aeq0, a2, 12; ae_subq56	aeq1, aeq1, aeq3 }
    24a1:	621274        	ae_sq32f.i	aeq1, a2, 28
    24a4:	f01d           	retw.n

000024a6 <LDNR_xtensa_fft4_32b+0x76>:
	...

000024a8 <LDNR_xtensa_fft8_32b>:
    24a8:	010136        	entry	a1, 128
    24ab:	604244        	ae_lq32f.i	aeq1, a2, 16
    24ae:	600264        	ae_lq32f.i	aeq0, a2, 24
    24b1:	f732f1        	l32r	a15, 17c (5a82 <idct64+0x1292>)
    24b4:	fa26c781ce 	{ addi	a12, a1, 120; ae_subq56	aeq2, aeq0, aeq1 }
    24b9:	632154        	ae_sq56s.i	aeq2, a1, 40
    24bc:	f8663d220f 	{ ae_lq32f.i	aeq1, a2, 0; ae_addq56	aeq0, aeq0, aeq1 }
    24c1:	608224        	ae_lq32f.i	aeq2, a2, 8
    24c4:	fbaafa0ccf 	{ ae_sq56s.i	aeq0, a12, -32; ae_subq56	aeq3, aeq1, aeq2 }
    24c9:	f9ea3d425f 	{ ae_lq32f.i	aeq2, a2, 20; ae_addq56	aeq1, aeq1, aeq2 }
    24ce:	633164        	ae_sq56s.i	aeq3, a1, 48
    24d1:	631c94        	ae_sq56s.i	aeq1, a12, -56
    24d4:	60c274        	ae_lq32f.i	aeq3, a2, 28
    24d7:	f8b6fd221f 	{ ae_lq32f.i	aeq1, a2, 4; ae_subq56	aeq0, aeq2, aeq3 }
    24dc:	faf63d623f 	{ ae_lq32f.i	aeq3, a2, 12; ae_addq56	aeq2, aeq2, aeq3 }
    24e1:	f8aefa017f 	{ ae_sq56s.i	aeq0, a1, 56; ae_subq56	aeq0, aeq1, aeq3 }
    24e6:	f9ee0202de 	{ addi	a13, a2, 32; ae_addq56	aeq1, aeq1, aeq3 }
    24eb:	fbaafa0caf 	{ ae_sq56s.i	aeq0, a12, -48; ae_subq56	aeq3, aeq1, aeq2 }
    24f0:	623254        	ae_sq32f.i	aeq3, a2, 20
    24f3:	f9ea3dcc9f 	{ ae_lq56.i	aeq2, a12, -56; ae_addq56	aeq1, aeq1, aeq2 }
    24f8:	61ccc4        	ae_lq56.i	aeq3, a12, -32
    24fb:	f8f639921f 	{ ae_sq32f.i	aeq1, a2, 4; ae_addq56	aeq0, aeq2, aeq3 }
    2500:	620204        	ae_sq32f.i	aeq0, a2, 0
    2503:	fab6fde16f 	{ ae_lq56.i	aeq3, a1, 48; ae_subq56	aeq2, aeq2, aeq3 }
    2508:	610174        	ae_lq56.i	aeq0, a1, 56
    250b:	f93af9a24f 	{ ae_sq32f.i	aeq2, a2, 16; ae_subq56	aeq1, aeq3, aeq0 }
    2510:	fb7a3d8caf 	{ ae_lq56.i	aeq0, a12, -48; ae_addq56	aeq3, aeq3, aeq0 }
    2515:	621264        	ae_sq32f.i	aeq1, a2, 24
    2518:	614154        	ae_lq56.i	aeq1, a1, 40
    251b:	fa6639b22f 	{ ae_sq32f.i	aeq3, a2, 8; ae_addq56	aeq2, aeq0, aeq1 }
    2520:	f826f9a23f 	{ ae_sq32f.i	aeq2, a2, 12; ae_subq56	aeq0, aeq0, aeq1 }
    2525:	620274        	ae_sq32f.i	aeq0, a2, 28
    2528:	60cd74        	ae_lq32f.i	aeq3, a13, 28
    252b:	604d54        	ae_lq32f.i	aeq1, a13, 20
    252e:	faee3d0d3f 	{ ae_lq32f.i	aeq0, a13, 12; ae_addq56	aeq2, aeq1, aeq3 }
    2533:	622d54        	ae_sq32f.i	aeq2, a13, 20
    2536:	f9aefd4d1f 	{ ae_lq32f.i	aeq2, a13, 4; ae_subq56	aeq1, aeq1, aeq3 }
    253b:	fb72399d7f 	{ ae_sq32f.i	aeq1, a13, 28; ae_addq56	aeq3, aeq2, aeq0 }
    2540:	623d14        	ae_sq32f.i	aeq3, a13, 4
    2543:	fa32fd0d2f 	{ ae_lq32f.i	aeq0, a13, 8; ae_subq56	aeq2, aeq2, aeq0 }
    2548:	60cd04        	ae_lq32f.i	aeq3, a13, 0
    254b:	622d34        	ae_sq32f.i	aeq2, a13, 12
    254e:	f93afd4d4f 	{ ae_lq32f.i	aeq2, a13, 16; ae_subq56	aeq1, aeq3, aeq0 }
    2553:	621d24        	ae_sq32f.i	aeq1, a13, 8
    2556:	fb7a3d0d6f 	{ ae_lq32f.i	aeq0, a13, 24; ae_addq56	aeq3, aeq3, aeq0 }
    255b:	f932f9bd0f 	{ ae_sq32f.i	aeq3, a13, 0; ae_subq56	aeq1, aeq2, aeq0 }
    2560:	621d64        	ae_sq32f.i	aeq1, a13, 24
    2563:	fa723d2d0f 	{ ae_lq32f.i	aeq1, a13, 0; ae_addq56	aeq2, aeq2, aeq0 }
    2568:	622d44        	ae_sq32f.i	aeq2, a13, 16
    256b:	60cd44        	ae_lq32f.i	aeq3, a13, 16
    256e:	011bc4        	ae_addq56	aeq0, aeq1, aeq3
    2571:	fb3efd420f 	{ ae_lq32f.i	aeq2, a2, 0; ae_subq56	aeq3, aeq3, aeq1 }
    2576:	633134        	ae_sq56s.i	aeq3, a1, 24
    2579:	f932fd621f 	{ ae_lq32f.i	aeq3, a2, 4; ae_subq56	aeq1, aeq2, aeq0 }
    257e:	fa72399d0f 	{ ae_sq32f.i	aeq1, a13, 0; ae_addq56	aeq2, aeq2, aeq0 }
    2583:	632144        	ae_sq56s.i	aeq2, a1, 32
    2586:	604d54        	ae_lq32f.i	aeq1, a13, 20
    2589:	608d14        	ae_lq32f.i	aeq2, a13, 4
    258c:	0129c4        	ae_addq56	aeq0, aeq2, aeq1
    258f:	01adc4        	ae_subq56	aeq2, aeq2, aeq1
    2592:	017cc4        	ae_subq56	aeq1, aeq3, aeq0
    2595:	fb7a3d814f 	{ ae_lq56.i	aeq0, a1, 32; ae_addq56	aeq3, aeq3, aeq0 }
    259a:	621d14        	ae_sq32f.i	aeq1, a13, 4
    259d:	623214        	ae_sq32f.i	aeq3, a2, 4
    25a0:	604244        	ae_lq32f.i	aeq1, a2, 16
    25a3:	f8ea39820f 	{ ae_sq32f.i	aeq0, a2, 0; ae_addq56	aeq0, aeq1, aeq2 }
    25a8:	f9aafd625f 	{ ae_lq32f.i	aeq3, a2, 20; ae_subq56	aeq1, aeq1, aeq2 }
    25ad:	621d44        	ae_sq32f.i	aeq1, a13, 16
    25b0:	614134        	ae_lq56.i	aeq1, a1, 24
    25b3:	01bdc4        	ae_subq56	aeq2, aeq3, aeq1
    25b6:	fb7e39ad5f 	{ ae_sq32f.i	aeq2, a13, 20; ae_addq56	aeq3, aeq3, aeq1 }
    25bb:	623254        	ae_sq32f.i	aeq3, a2, 20
    25be:	620244        	ae_sq32f.i	aeq0, a2, 16
    25c1:	600d64        	ae_lq32f.i	aeq0, a13, 24
    25c4:	604d74        	ae_lq32f.i	aeq1, a13, 28
    25c7:	0198c4        	ae_addq56	aeq2, aeq1, aeq0
    25ca:	632cb4        	ae_sq56s.i	aeq2, a12, -40
    25cd:	f826fd2d2f 	{ ae_lq32f.i	aeq1, a13, 8; ae_subq56	aeq0, aeq0, aeq1 }
    25d2:	608d34        	ae_lq32f.i	aeq2, a13, 12
    25d5:	01edc4        	ae_subq56	aeq3, aeq2, aeq1
    25d8:	f9ea18afff 	{ ae_cvtp24a16x2.ll	aep2, a15, a15; ae_addq56	aeq1, aeq1, aeq2 }
    25dd:	c1a244        	ae_mulzaafq32sp16s.lh	aeq2, aeq1, aep2, aeq0, aep2
    25e0:	3c48ba312f 	{ ae_sq56s.i	aeq3, a1, 16; ae_mulzasfq32sp16s.lh	aeq0, aeq0, aep2, aeq1, aep2 }
    25e5:	604224        	ae_lq32f.i	aeq1, a2, 8
    25e8:	fbea3a010f 	{ ae_sq56s.i	aeq0, a1, 0; ae_addq56	aeq3, aeq1, aeq2 }
    25ed:	f9aafd423f 	{ ae_lq32f.i	aeq2, a2, 12; ae_subq56	aeq1, aeq1, aeq2 }
    25f2:	621d24        	ae_sq32f.i	aeq1, a13, 8
    25f5:	610cb4        	ae_lq56.i	aeq0, a12, -40
    25f8:	614124        	ae_lq56.i	aeq1, a1, 16
    25fb:	0d497a311f 	{ ae_sq56s.i	aeq3, a1, 8; ae_mulzaafq32sp16s.lh	aeq3, aeq1, aep2, aeq0, aep2 }
    2600:	c52a44        	ae_mulzasfq32sp16s.lh	aeq1, aeq1, aep2, aeq0, aep2
    2603:	012fc4        	ae_subq56	aeq0, aeq2, aeq3
    2606:	faf63de11f 	{ ae_lq56.i	aeq3, a1, 8; ae_addq56	aeq2, aeq2, aeq3 }
    260b:	620d34        	ae_sq32f.i	aeq0, a13, 12
    260e:	622234        	ae_sq32f.i	aeq2, a2, 12
    2611:	600264        	ae_lq32f.i	aeq0, a2, 24
    2614:	fb6639b22f 	{ ae_sq32f.i	aeq3, a2, 8; ae_addq56	aeq3, aeq0, aeq1 }
    2619:	f826fd427f 	{ ae_lq32f.i	aeq2, a2, 28; ae_subq56	aeq0, aeq0, aeq1 }
    261e:	620d64        	ae_sq32f.i	aeq0, a13, 24
    2621:	610104        	ae_lq56.i	aeq0, a1, 0
    2624:	016cc4        	ae_subq56	aeq1, aeq2, aeq0
    2627:	621d74        	ae_sq32f.i	aeq1, a13, 28
    262a:	fa7239b26f 	{ ae_sq32f.i	aeq3, a2, 24; ae_addq56	aeq2, aeq2, aeq0 }
    262f:	622274        	ae_sq32f.i	aeq2, a2, 28
    2632:	f01d           	retw.n

00002634 <LDNR_F_get_oft_32b>:
    2634:	004136        	entry	a1, 32
    2637:	fcc242        	addi	a4, a2, -4
    263a:	7ca032        	movi	a3, 124
    263d:	0c3347        	bltu	a3, a4, 264d <LDNR_F_get_oft_32b+0x19>
    2640:	f6d031        	l32r	a3, 180 (3cac <LD_NR_B_RI+0x3fc>)
    2643:	1122f0        	slli	a2, a2, 1
    2646:	223a           	add.n	a2, a2, a3
    2648:	7e9222        	l16si	a2, a2, 252
    264b:	f01d           	retw.n

0000264d <LDNR_F_get_oft_32b+0x19>:
    264d:	220c           	movi.n	a2, 2
    264f:	f01d           	retw.n

00002651 <LDNR_F_get_oft_32b+0x1d>:
    2651:	000000                                        ...

00002654 <LDNR_xtensa_fft_pass_32b>:
    2654:	00a136        	entry	a1, 80
    2657:	83ad           	ae_sext16	a10, a3
    2659:	b09320        	addx8	a9, a3, a2
    265c:	600204        	ae_lq32f.i	aeq0, a2, 0
    265f:	904330        	addx2	a4, a3, a3
    2662:	1153c0        	slli	a5, a3, 4
    2665:	606254        	ae_lq32f.x	aeq1, a2, a5
    2668:	b04420        	addx8	a4, a4, a2
    266b:	608404        	ae_lq32f.i	aeq2, a4, 0
    266e:	f9ea10825f 	{ add	a8, a2, a5; ae_addq56	aeq1, aeq1, aeq2 }
    2673:	fa663d681f 	{ ae_lq32f.i	aeq3, a8, 4; ae_addq56	aeq2, aeq0, aeq1 }
    2678:	f826fa211f 	{ ae_sq56s.i	aeq2, a1, 8; ae_subq56	aeq0, aeq0, aeq1 }
    267d:	630144        	ae_sq56s.i	aeq0, a1, 32
    2680:	600414        	ae_lq32f.i	aeq0, a4, 4
    2683:	fb7a3d421f 	{ ae_lq32f.i	aeq2, a2, 4; ae_addq56	aeq3, aeq3, aeq0 }
    2688:	f9f60fc86e 	{ addi	a6, a8, -4; ae_addq56	aeq1, aeq2, aeq3 }
    268d:	fab6fd681f 	{ ae_lq32f.i	aeq3, a8, 4; ae_subq56	aeq2, aeq2, aeq3 }
    2692:	631124        	ae_sq56s.i	aeq1, a1, 16
    2695:	f6bb81        	l32r	a8, 184 (2634 <LDNR_F_get_oft_32b>)
    2698:	fb3afb925f 	{ ae_lq32f.x	aeq0, a2, a5; ae_subq56	aeq3, aeq3, aeq0 }
    269d:	614144        	ae_lq56.i	aeq1, a1, 32
    26a0:	fcc252        	addi	a5, a2, -4
    26a3:	633134        	ae_sq56s.i	aeq3, a1, 24
    26a6:	ff4c7d240f 	{ ae_lq32f.i	aeq1, a4, 0; ae_roundsq32sym	aeq3, aeq1 }
    26ab:	f92af9f61f 	{ ae_sq32f.iu	aeq3, a6, 4; ae_subq56	aeq1, aeq1, aeq0 }
    26b0:	fc547de11f 	{ ae_lq56.i	aeq3, a1, 8; ae_roundsq32sym	aeq0, aeq2 }
    26b5:	624614        	ae_sq32f.iu	aeq0, a6, 4
    26b8:	fe5c7d812f 	{ ae_lq56.i	aeq0, a1, 16; ae_roundsq32sym	aeq2, aeq3 }
    26bd:	ff4479e51f 	{ ae_sq32f.iu	aeq2, a5, 4; ae_roundsq32sym	aeq3, aeq0 }
    26c2:	627514        	ae_sq32f.iu	aeq3, a5, 4
    26c5:	600914        	ae_lq32f.i	aeq0, a9, 4
    26c8:	0189c4        	ae_addq56	aeq2, aeq0, aeq1
    26cb:	632104        	ae_sq56s.i	aeq2, a1, 0
    26ce:	f826fda13f 	{ ae_lq56.i	aeq1, a1, 24; ae_subq56	aeq0, aeq0, aeq1 }
    26d3:	608904        	ae_lq32f.i	aeq2, a9, 0
    26d6:	01edc4        	ae_subq56	aeq3, aeq2, aeq1
    26d9:	fa760fc92e 	{ addi	a2, a9, -4; ae_addq56	aeq2, aeq2, aeq1 }
    26de:	fd5c4fc44e 	{ addi	a4, a4, -4; ae_roundsq32sym	aeq1, aeq3 }
    26e3:	ff447d810f 	{ ae_lq56.i	aeq0, a1, 0; ae_roundsq32sym	aeq3, aeq0 }
    26e8:	625414        	ae_sq32f.iu	aeq1, a4, 4
    26eb:	fd5479f41f 	{ ae_sq32f.iu	aeq3, a4, 4; ae_roundsq32sym	aeq1, aeq2 }
    26f0:	ff4479d21f 	{ ae_sq32f.iu	aeq1, a2, 4; ae_roundsq32sym	aeq3, aeq0 }
    26f5:	627214        	ae_sq32f.iu	aeq3, a2, 4
    26f8:	0008e0        	callx8	a8
    26fb:	21b130        	srai	a11, a3, 1
    26fe:	080c           	movi.n	a8, 0
    2700:	f6a2c1        	l32r	a12, 188 (3cb0 <LDNR_ROOTS_512_Q16>)
    2703:	feca92        	addi	a9, a10, -2
    2706:	899d           	ae_sext16	a9, a9
    2708:	9099c0        	addx2	a9, a9, a12
    270b:	458984        	ae_lp16x2f.xu	aep0, a9, a8
    270e:	8bcd           	ae_sext16	a12, a11
    2710:	021ce6        	bgei	a12, 1, 2716 <LDNR_xtensa_fft_pass_32b+0xc2>
    2713:	004e46        	j	2850 <LDNR_xtensa_fft_pass_32b+0x1fc>
    2716:	11aaf0        	slli	a10, a10, 1
    2719:	8aad           	ae_sext16	a10, a10
    271b:	f03d           	nop.n
    271d:	88ac76        	loopgtz	a12, 27a9 <LDNR_xtensa_fft_pass_32b+0x155>
    2720:	60c424        	ae_lq32f.i	aeq3, a4, 8
    2723:	600414        	ae_lq32f.i	aeq0, a4, 4
    2726:	6002fd462f 	{ ae_lq32f.i	aeq2, a6, 8; ae_mulzasq32sp16u.lh	aeq1, aeq0, aep0, aeq3, aep0 }
    272b:	33017d061f 	{ ae_lq32f.i	aeq0, a6, 4; ae_mulzaaq32sp16u.lh	aeq3, aeq3, aep0, aeq0, aep0 }
    2730:	62007a110f 	{ ae_sq56s.i	aeq1, a1, 0; ae_mulzasq32sp16u.lh	aeq1, aeq2, aep0, aeq0, aep0 }
    2735:	c20024        	ae_mulzaaq32sp16u.lh	aeq0, aeq0, aep0, aeq2, aep0
    2738:	019bc4        	ae_addq56	aeq2, aeq1, aeq3
    273b:	015fc4        	ae_subq56	aeq1, aeq1, aeq3
    273e:	631134        	ae_sq56s.i	aeq1, a1, 24
    2741:	604524        	ae_lq32f.i	aeq1, a5, 8
    2744:	01dac4        	ae_addq56	aeq3, aeq1, aeq2
    2747:	633124        	ae_sq56s.i	aeq3, a1, 16
    274a:	f9aafde10f 	{ ae_lq56.i	aeq3, a1, 0; ae_subq56	aeq1, aeq1, aeq2 }
    274f:	018bc4        	ae_addq56	aeq2, aeq0, aeq3
    2752:	fb3afd051f 	{ ae_lq32f.i	aeq0, a5, 4; ae_subq56	aeq3, aeq3, aeq0 }
    2757:	fbe23a311f 	{ ae_sq56s.i	aeq3, a1, 8; ae_addq56	aeq3, aeq0, aeq2 }
    275c:	010ec4        	ae_subq56	aeq0, aeq0, aeq2
    275f:	fe445b89af 	{ ae_lp16x2f.xu	aep0, a9, a10; ae_roundsq32sym	aeq2, aeq0 }
    2764:	fc4c7da12f 	{ ae_lq56.i	aeq1, a1, 16; ae_roundsq32sym	aeq0, aeq1 }
    2769:	626614        	ae_sq32f.iu	aeq2, a6, 4
    276c:	fe5c79c61f 	{ ae_sq32f.iu	aeq0, a6, 4; ae_roundsq32sym	aeq2, aeq3 }
    2771:	626514        	ae_sq32f.iu	aeq2, a5, 4
    2774:	fc4c7dc11f 	{ ae_lq56.i	aeq2, a1, 8; ae_roundsq32sym	aeq0, aeq1 }
    2779:	624514        	ae_sq32f.iu	aeq0, a5, 4
    277c:	604224        	ae_lq32f.i	aeq1, a2, 8
    277f:	fbaafd021f 	{ ae_lq32f.i	aeq0, a2, 4; ae_subq56	aeq3, aeq1, aeq2 }
    2784:	f9ea3dc13f 	{ ae_lq56.i	aeq2, a1, 24; ae_addq56	aeq1, aeq1, aeq2 }
    2789:	fba2fa314f 	{ ae_sq56s.i	aeq3, a1, 32; ae_subq56	aeq3, aeq0, aeq2 }
    278e:	010ac4        	ae_addq56	aeq0, aeq0, aeq2
    2791:	068834        	ae_roundsq32sym	aeq2, aeq0
    2794:	fc4c7da14f 	{ ae_lq56.i	aeq1, a1, 32; ae_roundsq32sym	aeq0, aeq1 }
    2799:	626214        	ae_sq32f.iu	aeq2, a2, 4
    279c:	fe5c79c21f 	{ ae_sq32f.iu	aeq0, a2, 4; ae_roundsq32sym	aeq2, aeq3 }
    27a1:	fc4c79e41f 	{ ae_sq32f.iu	aeq2, a4, 4; ae_roundsq32sym	aeq0, aeq1 }
    27a6:	624414        	ae_sq32f.iu	aeq0, a4, 4

000027a9 <LDNR_xtensa_fft_pass_32b+0x155>:
    27a9:	11daf0        	slli	a13, a10, 1
    27ac:	fecbc2        	addi	a12, a11, -2
    27af:	8cbd           	ae_sext16	a11, a12
    27b1:	60d0d0        	neg	a13, a13
    27b4:	4589d4        	ae_lp16x2f.xu	aep0, a9, a13
    27b7:	026cf7        	bbci	a12, 15, 27bd <LDNR_xtensa_fft_pass_32b+0x169>
    27ba:	002406        	j	284e <LDNR_xtensa_fft_pass_32b+0x1fa>
    27bd:	60a0a0        	neg	a10, a10
    27c0:	eb1b           	addi.n	a14, a11, 1
    27c2:	88ae76        	loopgtz	a14, 284e <LDNR_xtensa_fft_pass_32b+0x1fa>
    27c5:	608414        	ae_lq32f.i	aeq2, a4, 4
    27c8:	60c424        	ae_lq32f.i	aeq3, a4, 8
    27cb:	92033d261f 	{ ae_lq32f.i	aeq1, a6, 4; ae_mulzsaq32sp16u.lh	aeq0, aeq3, aep0, aeq2, aep0 }
    27d0:	3302bd662f 	{ ae_lq32f.i	aeq3, a6, 8; ae_mulzaaq32sp16u.lh	aeq2, aeq2, aep0, aeq3, aep0 }
    27d5:	9003ba014f 	{ ae_sq56s.i	aeq0, a1, 32; ae_mulzsaq32sp16u.lh	aeq0, aeq1, aep0, aeq3, aep0 }
    27da:	c288d4        	ae_mulzaaq32sp16u.lh	aeq3, aeq3, aep0, aeq1, aep0
    27dd:	014ac4        	ae_addq56	aeq1, aeq0, aeq2
    27e0:	010ec4        	ae_subq56	aeq0, aeq0, aeq2
    27e3:	630114        	ae_sq56s.i	aeq0, a1, 8
    27e6:	600524        	ae_lq32f.i	aeq0, a5, 8
    27e9:	0189c4        	ae_addq56	aeq2, aeq0, aeq1
    27ec:	632124        	ae_sq56s.i	aeq2, a1, 16
    27ef:	f826fdc14f 	{ ae_lq56.i	aeq2, a1, 32; ae_subq56	aeq0, aeq0, aeq1 }
    27f4:	017ac4        	ae_addq56	aeq1, aeq3, aeq2
    27f7:	fab6fd651f 	{ ae_lq32f.i	aeq3, a5, 4; ae_subq56	aeq2, aeq2, aeq3 }
    27fc:	fa7e3a213f 	{ ae_sq56s.i	aeq2, a1, 24; ae_addq56	aeq2, aeq3, aeq1 }
    2801:	01fdc4        	ae_subq56	aeq3, aeq3, aeq1
    2804:	fd5c5b89af 	{ ae_lp16x2f.xu	aep0, a9, a10; ae_roundsq32sym	aeq1, aeq3 }
    2809:	ff447d812f 	{ ae_lq56.i	aeq0, a1, 16; ae_roundsq32sym	aeq3, aeq0 }
    280e:	625614        	ae_sq32f.iu	aeq1, a6, 4
    2811:	fd5479f61f 	{ ae_sq32f.iu	aeq3, a6, 4; ae_roundsq32sym	aeq1, aeq2 }
    2816:	625514        	ae_sq32f.iu	aeq1, a5, 4
    2819:	ff447da13f 	{ ae_lq56.i	aeq1, a1, 24; ae_roundsq32sym	aeq3, aeq0 }
    281e:	627514        	ae_sq32f.iu	aeq3, a5, 4
    2821:	600224        	ae_lq32f.i	aeq0, a2, 8
    2824:	fa26fd621f 	{ ae_lq32f.i	aeq3, a2, 4; ae_subq56	aeq2, aeq0, aeq1 }
    2829:	f8663da11f 	{ ae_lq56.i	aeq1, a1, 8; ae_addq56	aeq0, aeq0, aeq1 }
    282e:	fa3efa210f 	{ ae_sq56s.i	aeq2, a1, 0; ae_subq56	aeq2, aeq3, aeq1 }
    2833:	01f9c4        	ae_addq56	aeq3, aeq3, aeq1
    2836:	067834        	ae_roundsq32sym	aeq1, aeq3
    2839:	ff447d810f 	{ ae_lq56.i	aeq0, a1, 0; ae_roundsq32sym	aeq3, aeq0 }
    283e:	625214        	ae_sq32f.iu	aeq1, a2, 4
    2841:	fd5479f21f 	{ ae_sq32f.iu	aeq3, a2, 4; ae_roundsq32sym	aeq1, aeq2 }
    2846:	ff4479d41f 	{ ae_sq32f.iu	aeq1, a4, 4; ae_roundsq32sym	aeq3, aeq0 }
    284b:	627414        	ae_sq32f.iu	aeq3, a4, 4

0000284e <LDNR_xtensa_fft_pass_32b+0x1fa>:
    284e:	f01d           	retw.n

00002850 <LDNR_xtensa_fft_pass_32b+0x1fc>:
    2850:	11aaf0        	slli	a10, a10, 1
    2853:	8aad           	ae_sext16	a10, a10
    2855:	ffd406        	j	27a9 <LDNR_xtensa_fft_pass_32b+0x155>

00002858 <LDNR_xtensa_fft16_32b>:
    2858:	004136        	entry	a1, 32
    285b:	f64c81        	l32r	a8, 18c (24a8 <LDNR_xtensa_fft8_32b>)
    285e:	02ad           	mov.n	a10, a2
    2860:	0008e0        	callx8	a8
    2863:	f64b81        	l32r	a8, 190 (2430 <LDNR_xtensa_fft4_32b>)
    2866:	40c2a2        	addi	a10, a2, 64
    2869:	0008e0        	callx8	a8
    286c:	f64981        	l32r	a8, 190 (2430 <LDNR_xtensa_fft4_32b>)
    286f:	60c2a2        	addi	a10, a2, 96
    2872:	0008e0        	callx8	a8
    2875:	f64781        	l32r	a8, 194 (2654 <LDNR_xtensa_fft_pass_32b>)
    2878:	02ad           	mov.n	a10, a2
    287a:	04a0b2        	movi	a11, 4
    287d:	0008e0        	callx8	a8
    2880:	f01d           	retw.n

00002882 <LDNR_xtensa_fft16_32b+0x2a>:
	...

00002884 <LDNR_xtensa_fft32_32b>:
    2884:	004136        	entry	a1, 32
    2887:	f64481        	l32r	a8, 198 (2858 <LDNR_xtensa_fft16_32b>)
    288a:	20a220        	or	a10, a2, a2
    288d:	0008e0        	callx8	a8
    2890:	f63f81        	l32r	a8, 18c (24a8 <LDNR_xtensa_fft8_32b>)
    2893:	01d2a2        	addmi	a10, a2, 0x100
    2896:	80caa2        	addi	a10, a10, -128
    2899:	0008e0        	callx8	a8
    289c:	f63c81        	l32r	a8, 18c (24a8 <LDNR_xtensa_fft8_32b>)
    289f:	01d2a2        	addmi	a10, a2, 0x100
    28a2:	c0caa2        	addi	a10, a10, -64
    28a5:	0008e0        	callx8	a8
    28a8:	f63b81        	l32r	a8, 194 (2654 <LDNR_xtensa_fft_pass_32b>)
    28ab:	02ad           	mov.n	a10, a2
    28ad:	8b0c           	movi.n	a11, 8
    28af:	0008e0        	callx8	a8
    28b2:	f01d           	retw.n

000028b4 <LDNR_xtensa_fft64_32b>:
    28b4:	004136        	entry	a1, 32
    28b7:	f63981        	l32r	a8, 19c (2884 <LDNR_xtensa_fft32_32b>)
    28ba:	20a220        	or	a10, a2, a2
    28bd:	0008e0        	callx8	a8
    28c0:	f63681        	l32r	a8, 198 (2858 <LDNR_xtensa_fft16_32b>)
    28c3:	01d2a2        	addmi	a10, a2, 0x100
    28c6:	0008e0        	callx8	a8
    28c9:	f63381        	l32r	a8, 198 (2858 <LDNR_xtensa_fft16_32b>)
    28cc:	02d2a2        	addmi	a10, a2, 0x200
    28cf:	80caa2        	addi	a10, a10, -128
    28d2:	0008e0        	callx8	a8
    28d5:	f62f81        	l32r	a8, 194 (2654 <LDNR_xtensa_fft_pass_32b>)
    28d8:	02ad           	mov.n	a10, a2
    28da:	10a0b2        	movi	a11, 16
    28dd:	0008e0        	callx8	a8
    28e0:	f01d           	retw.n

000028e2 <LDNR_xtensa_fft64_32b+0x2e>:
	...

000028e4 <LDNR_xtensa_fft128_32b>:
    28e4:	004136        	entry	a1, 32
    28e7:	f62e81        	l32r	a8, 1a0 (28b4 <LDNR_xtensa_fft64_32b>)
    28ea:	20a220        	or	a10, a2, a2
    28ed:	0008e0        	callx8	a8
    28f0:	f62b81        	l32r	a8, 19c (2884 <LDNR_xtensa_fft32_32b>)
    28f3:	02d2a2        	addmi	a10, a2, 0x200
    28f6:	0008e0        	callx8	a8
    28f9:	f62881        	l32r	a8, 19c (2884 <LDNR_xtensa_fft32_32b>)
    28fc:	03d2a2        	addmi	a10, a2, 0x300
    28ff:	0008e0        	callx8	a8
    2902:	f62481        	l32r	a8, 194 (2654 <LDNR_xtensa_fft_pass_32b>)
    2905:	02ad           	mov.n	a10, a2
    2907:	0b2c           	movi.n	a11, 32
    2909:	0008e0        	callx8	a8
    290c:	f01d           	retw.n

0000290e <LDNR_xtensa_fft128_32b+0x2a>:
	...

00002910 <LDNR_xtensa_fft256_32b>:
    2910:	004136        	entry	a1, 32
    2913:	f62381        	l32r	a8, 1a0 (28b4 <LDNR_xtensa_fft64_32b>)
    2916:	02ad           	mov.n	a10, a2
    2918:	0008e0        	callx8	a8
    291b:	f62081        	l32r	a8, 19c (2884 <LDNR_xtensa_fft32_32b>)
    291e:	02d2a2        	addmi	a10, a2, 0x200
    2921:	0008e0        	callx8	a8
    2924:	f61e81        	l32r	a8, 19c (2884 <LDNR_xtensa_fft32_32b>)
    2927:	03d2a2        	addmi	a10, a2, 0x300
    292a:	0008e0        	callx8	a8
    292d:	f61981        	l32r	a8, 194 (2654 <LDNR_xtensa_fft_pass_32b>)
    2930:	02ad           	mov.n	a10, a2
    2932:	20a0b2        	movi	a11, 32
    2935:	0008e0        	callx8	a8
    2938:	f61a81        	l32r	a8, 1a0 (28b4 <LDNR_xtensa_fft64_32b>)
    293b:	04d2a2        	addmi	a10, a2, 0x400
    293e:	0008e0        	callx8	a8
    2941:	f61781        	l32r	a8, 1a0 (28b4 <LDNR_xtensa_fft64_32b>)
    2944:	06d2a2        	addmi	a10, a2, 0x600
    2947:	0008e0        	callx8	a8
    294a:	f61281        	l32r	a8, 194 (2654 <LDNR_xtensa_fft_pass_32b>)
    294d:	02ad           	mov.n	a10, a2
    294f:	0b4c           	movi.n	a11, 64
    2951:	0008e0        	callx8	a8
    2954:	f01d           	retw.n

00002956 <LDNR_xtensa_fft256_32b+0x46>:
	...

00002958 <LDNR_xtensa_fft512_32b>:
    2958:	004136        	entry	a1, 32
    295b:	f61281        	l32r	a8, 1a4 (2910 <LDNR_xtensa_fft256_32b>)
    295e:	02ad           	mov.n	a10, a2
    2960:	0008e0        	callx8	a8
    2963:	f61181        	l32r	a8, 1a8 (28e4 <LDNR_xtensa_fft128_32b>)
    2966:	08d2a2        	addmi	a10, a2, 0x800
    2969:	0008e0        	callx8	a8
    296c:	f60f81        	l32r	a8, 1a8 (28e4 <LDNR_xtensa_fft128_32b>)
    296f:	0cd2a2        	addmi	a10, a2, 0xc00
    2972:	0008e0        	callx8	a8
    2975:	f60781        	l32r	a8, 194 (2654 <LDNR_xtensa_fft_pass_32b>)
    2978:	02ad           	mov.n	a10, a2
    297a:	80a0b2        	movi	a11, 128
    297d:	0008e0        	callx8	a8
    2980:	f01d           	retw.n

00002982 <LDNR_xtensa_fft512_32b+0x2a>:
	...

00002984 <LDNR_real_split>:
    2984:	00c136        	entry	a1, 96
    2987:	036d           	mov.n	a6, a3
    2989:	f5fe81        	l32r	a8, 184 (2634 <LDNR_F_get_oft_32b>)
    298c:	03a8           	l32i.n	a10, a3, 0
    298e:	13c8           	l32i.n	a12, a3, 4
    2990:	025d           	mov.n	a5, a2
    2992:	0d0c           	movi.n	a13, 0
    2994:	042d           	mov.n	a2, a4
    2996:	14d9           	s32i.n	a13, a4, 4
    2998:	214150        	srai	a4, a5, 1
    299b:	847d           	ae_sext16	a7, a4
    299d:	aaca           	add.n	a10, a10, a12
    299f:	02a9           	s32i.n	a10, a2, 0
    29a1:	c0b570        	sub	a11, a5, a7
    29a4:	b0bb30        	addx8	a11, a11, a3
    29a7:	1b98           	l32i.n	a9, a11, 4
    29a9:	b0a720        	addx8	a10, a7, a2
    29ac:	0bb8           	l32i.n	a11, a11, 0
    29ae:	0ab9           	s32i.n	a11, a10, 0
    29b0:	999a           	add.n	a9, a9, a9
    29b2:	609090        	neg	a9, a9
    29b5:	219190        	srai	a9, a9, 1
    29b8:	016a92        	s32i	a9, a10, 4
    29bb:	85ad           	ae_sext16	a10, a5
    29bd:	0008e0        	callx8	a8
    29c0:	11faf0        	slli	a15, a10, 1
    29c3:	0aed           	mov.n	a14, a10
    29c5:	4129           	s32i.n	a2, a1, 16
    29c7:	c28b           	addi.n	a12, a2, 8
    29c9:	b68b           	addi.n	a11, a6, 8
    29cb:	5139           	s32i.n	a3, a1, 20
    29cd:	6149           	s32i.n	a4, a1, 24
    29cf:	b0d560        	addx8	a13, a5, a6
    29d2:	fccdd2        	addi	a13, a13, -4
    29d5:	140c           	movi.n	a4, 1
    29d7:	81a032        	movi	a3, 129
    29da:	060c           	movi.n	a6, 0
    29dc:	f5eb21        	l32r	a2, 188 (3cb0 <LDNR_ROOTS_512_Q16>)
    29df:	723530        	salt	a3, a5, a3
    29e2:	93ef30        	movnez	a14, a15, a3
    29e5:	fecea2        	addi	a10, a14, -2
    29e8:	8aad           	ae_sext16	a10, a10
    29ea:	21f1a0        	srai	a15, a10, 1
    29ed:	a0ff20        	addx4	a15, a15, a2
    29f0:	441f04        	ae_lp16x2f.i	aep1, a15, 0
    29f3:	dc25807d3f 	{ movi	a3, 125; ae_selp24.lh	aep0, aep1, aep1 }
    29f8:	0aa3a7        	bge	a3, a10, 2a06 <LDNR_real_split+0x82>
    29fb:	079d           	mov.n	a9, a7
    29fd:	60e0e0        	neg	a14, a14
    2a00:	170c           	movi.n	a7, 1
    2a02:	000106        	j	2a0a <LDNR_real_split+0x86>

00002a05 <LDNR_real_split+0x81>:
	...

00002a06 <LDNR_real_split+0x82>:
    2a06:	079d           	mov.n	a9, a7
    2a08:	070c           	movi.n	a7, 0

00002a0a <LDNR_real_split+0x86>:
    2a0a:	8159           	s32i.n	a5, a1, 32
    2a0c:	836470        	moveqz	a6, a4, a7
    2a0f:	604b04        	ae_lq32f.i	aeq1, a11, 0
    2a12:	600b14        	ae_lq32f.i	aeq0, a11, 4
    2a15:	8b4b           	addi.n	a8, a11, 4
    2a17:	0189           	s32i.n	a8, a1, 0
    2a19:	bb8b           	addi.n	a11, a11, 8
    2a1b:	16cc           	bnez.n	a6, 2a20 <LDNR_real_split+0x9c>
    2a1d:	091484        	ae_movp48	aep0, aep1

00002a20 <LDNR_real_split+0x9c>:
    2a20:	0229e6        	bgei	a9, 2, 2a26 <LDNR_real_split+0xa2>
    2a23:	0022c6        	j	2ab2 <LDNR_real_split+0x12e>
    2a26:	f8cbb2        	addi	a11, a11, -8
    2a29:	f8ccc2        	addi	a12, a12, -8
    2a2c:	890b           	addi.n	a8, a9, -1
    2a2e:	fccdf2        	addi	a15, a13, -4
    2a31:	f59151        	l32r	a5, 78 (8000 <_end+0x131c>)
    2a34:	dd8b           	addi.n	a13, a13, 8
    2a36:	301554        	ae_cvtp24a16x2.ll	aep1, a5, a5
    2a39:	ff8b           	addi.n	a15, a15, 8
    2a3b:	0158           	l32i.n	a5, a1, 0
    2a3d:	66a876        	loopgtz	a8, 2aa7 <LDNR_real_split+0x123>
    2a40:	91013d7fef 	{ ae_lq32f.iu	aeq3, a15, -8; ae_mulzsaq32sp16u.lh	aeq2, aeq1, aep0, aeq0, aep0 }
    2a45:	1827ba016f 	{ ae_sq56s.i	aeq0, a1, 48; ae_mulzaafq32sp16u.lh	aeq0, aeq1, aep1, aeq3, aep1 }
    2a4a:	f8e23d5def 	{ ae_lq32f.iu	aeq2, a13, -8; ae_addq56	aeq0, aeq0, aeq2 }
    2a4f:	32037a115f 	{ ae_sq56s.i	aeq1, a1, 40; ae_mulzaaq32sp16u.lh	aeq1, aeq3, aep0, aeq2, aep0 }
    2a54:	f86600018f 	{ movi	a8, 1; ae_addq56	aeq0, aeq0, aeq1 }
    2a59:	630174        	ae_sq56s.i	aeq0, a1, 56
    2a5c:	9302fd816f 	{ ae_lq56.i	aeq0, a1, 48; ae_mulzsaq32sp16u.lh	aeq3, aeq2, aep0, aeq3, aep0 }
    2a61:	49263da15f 	{ ae_lq56.i	aeq1, a1, 40; ae_mulzasfq32sp16u.lh	aeq2, aeq0, aep1, aeq2, aep1 }
    2a66:	c00090aeaf 	{ add	a10, a14, a10; ae_mulzssq32sp16u.lh	aeq0, aeq0, aep0, aeq1, aep0 }
    2a6b:	8aad           	ae_sext16	a10, a10
    2a6d:	fa723d817f 	{ ae_lq56.i	aeq0, a1, 56; ae_addq56	aeq2, aeq2, aeq0 }
    2a72:	faf63b001f 	{ ae_sraiq56	aeq0, aeq0, 1; ae_addq56	aeq2, aeq2, aeq3 }
    2a77:	ff447b209f 	{ ae_sraiq56	aeq2, aeq2, 1; ae_roundsq32sym	aeq3, aeq0 }
    2a7c:	fd5479fc2f 	{ ae_sq32f.iu	aeq3, a12, 8; ae_roundsq32sym	aeq1, aeq2 }
    2a81:	621c14        	ae_sq32f.i	aeq1, a12, 4
    2a84:	0ca3a7        	bge	a3, a10, 2a94 <LDNR_real_split+0x110>
    2a87:	60e0e0        	neg	a14, a14
    2a8a:	060c           	movi.n	a6, 0
    2a8c:	307740        	xor	a7, a7, a4
    2a8f:	877d           	ae_sext16	a7, a7
    2a91:	836870        	moveqz	a6, a8, a7

00002a94 <LDNR_real_split+0x110>:
    2a94:	2181a0        	srai	a8, a10, 1
    2a97:	a08820        	addx4	a8, a8, a2
    2a9a:	442804        	ae_lp16x2f.i	aep2, a8, 0
    2a9d:	dc49bd3b2f 	{ ae_lq32f.iu	aeq1, a11, 8; ae_selp24.lh	aep0, aep2, aep2 }
    2aa2:	668c           	beqz.n	a6, 2aac <LDNR_real_split+0x128>

00002aa4 <LDNR_real_split+0x120>:
    2aa4:	601524        	ae_lq32f.iu	aeq0, a5, 8

00002aa7 <LDNR_real_split+0x123>:
    2aa7:	8158           	l32i.n	a5, a1, 32
    2aa9:	000146        	j	2ab2 <LDNR_real_split+0x12e>

00002aac <LDNR_real_split+0x128>:
    2aac:	092484        	ae_movp48	aep0, aep2
    2aaf:	fffc46        	j	2aa4 <LDNR_real_split+0x120>

00002ab2 <LDNR_real_split+0x12e>:
    2ab2:	5188           	l32i.n	a8, a1, 20
    2ab4:	41c8           	l32i.n	a12, a1, 16
    2ab6:	61f8           	l32i.n	a15, a1, 24
    2ab8:	60e0e0        	neg	a14, a14
    2abb:	fecea2        	addi	a10, a14, -2
    2abe:	8aad           	ae_sext16	a10, a10
    2ac0:	ff1b           	addi.n	a15, a15, 1
    2ac2:	8ffd           	ae_sext16	a15, a15
    2ac4:	b0cfc0        	addx8	a12, a15, a12
    2ac7:	c0d5f0        	sub	a13, a5, a15
    2aca:	11d9           	s32i.n	a13, a1, 4
    2acc:	b0bf80        	addx8	a11, a15, a8
    2acf:	b0dd80        	addx8	a13, a13, a8
    2ad2:	21d9           	s32i.n	a13, a1, 8
    2ad4:	dd4b           	addi.n	a13, a13, 4
    2ad6:	0ea3a7        	bge	a3, a10, 2ae8 <LDNR_real_split+0x164>
    2ad9:	60e0e0        	neg	a14, a14
    2adc:	180c           	movi.n	a8, 1
    2ade:	060c           	movi.n	a6, 0
    2ae0:	307740        	xor	a7, a7, a4
    2ae3:	877d           	ae_sext16	a7, a7
    2ae5:	836870        	moveqz	a6, a8, a7

00002ae8 <LDNR_real_split+0x164>:
    2ae8:	604b04        	ae_lq32f.i	aeq1, a11, 0
    2aeb:	9b4b           	addi.n	a9, a11, 4
    2aed:	600b14        	ae_lq32f.i	aeq0, a11, 4
    2af0:	2181a0        	srai	a8, a10, 1
    2af3:	a08820        	addx4	a8, a8, a2
    2af6:	441804        	ae_lp16x2f.i	aep1, a8, 0
    2af9:	dc25808bbe 	{ addi	a11, a11, 8; ae_selp24.lh	aep0, aep1, aep1 }
    2afe:	08e616        	beqz	a6, 2b90 <LDNR_real_split+0x20c>

00002b01 <LDNR_real_split+0x17d>:
    2b01:	022f57        	blt	a15, a5, 2b07 <LDNR_real_split+0x183>
    2b04:	002386        	j	2b96 <LDNR_real_split+0x212>
    2b07:	f8cbb2        	addi	a11, a11, -8
    2b0a:	f8ccc2        	addi	a12, a12, -8
    2b0d:	dd8b           	addi.n	a13, a13, 8
    2b0f:	1188           	l32i.n	a8, a1, 4
    2b11:	f55951        	l32r	a5, 78 (8000 <_end+0x131c>)
    2b14:	21f8           	l32i.n	a15, a1, 8
    2b16:	301554        	ae_cvtp24a16x2.ll	aep1, a5, a5
    2b19:	095d           	mov.n	a5, a9
    2b1b:	ff8b           	addi.n	a15, a15, 8
    2b1d:	66a876        	loopgtz	a8, 2b87 <LDNR_real_split+0x203>
    2b20:	c1013d7fef 	{ ae_lq32f.iu	aeq3, a15, -8; ae_mulzssq32sp16u.lh	aeq2, aeq1, aep0, aeq0, aep0 }
    2b25:	1827ba016f 	{ ae_sq56s.i	aeq0, a1, 48; ae_mulzaafq32sp16u.lh	aeq0, aeq1, aep1, aeq3, aep1 }
    2b2a:	f8e23d5def 	{ ae_lq32f.iu	aeq2, a13, -8; ae_addq56	aeq0, aeq0, aeq2 }
    2b2f:	62037a115f 	{ ae_sq56s.i	aeq1, a1, 40; ae_mulzasq32sp16u.lh	aeq1, aeq3, aep0, aeq2, aep0 }
    2b34:	f86600018f 	{ movi	a8, 1; ae_addq56	aeq0, aeq0, aeq1 }
    2b39:	630174        	ae_sq56s.i	aeq0, a1, 56
    2b3c:	c302fd816f 	{ ae_lq56.i	aeq0, a1, 48; ae_mulzssq32sp16u.lh	aeq3, aeq2, aep0, aeq3, aep0 }
    2b41:	49263da15f 	{ ae_lq56.i	aeq1, a1, 40; ae_mulzasfq32sp16u.lh	aeq2, aeq0, aep1, aeq2, aep1 }
    2b46:	900090aeaf 	{ add	a10, a14, a10; ae_mulzsaq32sp16u.lh	aeq0, aeq0, aep0, aeq1, aep0 }
    2b4b:	8aad           	ae_sext16	a10, a10
    2b4d:	fa723d817f 	{ ae_lq56.i	aeq0, a1, 56; ae_addq56	aeq2, aeq2, aeq0 }
    2b52:	faf63b001f 	{ ae_sraiq56	aeq0, aeq0, 1; ae_addq56	aeq2, aeq2, aeq3 }
    2b57:	ff447b209f 	{ ae_sraiq56	aeq2, aeq2, 1; ae_roundsq32sym	aeq3, aeq0 }
    2b5c:	fd5479fc2f 	{ ae_sq32f.iu	aeq3, a12, 8; ae_roundsq32sym	aeq1, aeq2 }
    2b61:	621c14        	ae_sq32f.i	aeq1, a12, 4
    2b64:	0ca3a7        	bge	a3, a10, 2b74 <LDNR_real_split+0x1f0>
    2b67:	60e0e0        	neg	a14, a14
    2b6a:	060c           	movi.n	a6, 0
    2b6c:	307740        	xor	a7, a7, a4
    2b6f:	877d           	ae_sext16	a7, a7
    2b71:	836870        	moveqz	a6, a8, a7

00002b74 <LDNR_real_split+0x1f0>:
    2b74:	2181a0        	srai	a8, a10, 1
    2b77:	a08820        	addx4	a8, a8, a2
    2b7a:	442804        	ae_lp16x2f.i	aep2, a8, 0
    2b7d:	dc49bd3b2f 	{ ae_lq32f.iu	aeq1, a11, 8; ae_selp24.lh	aep0, aep2, aep2 }
    2b82:	368c           	beqz.n	a6, 2b89 <LDNR_real_split+0x205>

00002b84 <LDNR_real_split+0x200>:
    2b84:	601524        	ae_lq32f.iu	aeq0, a5, 8

00002b87 <LDNR_real_split+0x203>:
    2b87:	f01d           	retw.n

00002b89 <LDNR_real_split+0x205>:
    2b89:	092484        	ae_movp48	aep0, aep2
    2b8c:	fffd06        	j	2b84 <LDNR_real_split+0x200>

00002b8f <LDNR_real_split+0x20b>:
	...

00002b90 <LDNR_real_split+0x20c>:
    2b90:	091484        	ae_movp48	aep0, aep1
    2b93:	ffda86        	j	2b01 <LDNR_real_split+0x17d>

00002b96 <LDNR_real_split+0x212>:
    2b96:	f01d           	retw.n

00002b98 <LDNR_xtensa_real_fft_32b>:
    2b98:	004136        	entry	a1, 32
    2b9b:	0b8266        	bnei	a2, 8, 2baa <LDNR_xtensa_real_fft_32b+0x12>
    2b9e:	f57b81        	l32r	a8, 18c (24a8 <LDNR_xtensa_fft8_32b>)
    2ba1:	20a330        	or	a10, a3, a3
    2ba4:	0020f0        	nop
    2ba7:	0008e0        	callx8	a8

00002baa <LDNR_xtensa_real_fft_32b+0x12>:
    2baa:	07b266        	bnei	a2, 16, 2bb5 <LDNR_xtensa_real_fft_32b+0x1d>
    2bad:	f57a81        	l32r	a8, 198 (2858 <LDNR_xtensa_fft16_32b>)
    2bb0:	03ad           	mov.n	a10, a3
    2bb2:	0008e0        	callx8	a8

00002bb5 <LDNR_xtensa_real_fft_32b+0x1d>:
    2bb5:	09c266        	bnei	a2, 32, 2bc2 <LDNR_xtensa_real_fft_32b+0x2a>
    2bb8:	f57981        	l32r	a8, 19c (2884 <LDNR_xtensa_fft32_32b>)
    2bbb:	03ad           	mov.n	a10, a3
    2bbd:	f03d           	nop.n
    2bbf:	0008e0        	callx8	a8

00002bc2 <LDNR_xtensa_real_fft_32b+0x2a>:
    2bc2:	07d266        	bnei	a2, 64, 2bcd <LDNR_xtensa_real_fft_32b+0x35>
    2bc5:	f57681        	l32r	a8, 1a0 (28b4 <LDNR_xtensa_fft64_32b>)
    2bc8:	03ad           	mov.n	a10, a3
    2bca:	0008e0        	callx8	a8

00002bcd <LDNR_xtensa_real_fft_32b+0x35>:
    2bcd:	07e266        	bnei	a2, 128, 2bd8 <LDNR_xtensa_real_fft_32b+0x40>
    2bd0:	f57681        	l32r	a8, 1a8 (28e4 <LDNR_xtensa_fft128_32b>)
    2bd3:	03ad           	mov.n	a10, a3
    2bd5:	0008e0        	callx8	a8

00002bd8 <LDNR_xtensa_real_fft_32b+0x40>:
    2bd8:	07f266        	bnei	a2, 0x100, 2be3 <LDNR_xtensa_real_fft_32b+0x4b>
    2bdb:	f57281        	l32r	a8, 1a4 (2910 <LDNR_xtensa_fft256_32b>)
    2bde:	03ad           	mov.n	a10, a3
    2be0:	0008e0        	callx8	a8

00002be3 <LDNR_xtensa_real_fft_32b+0x4b>:
    2be3:	00a292        	movi	a9, 0x200
    2be6:	079297        	bne	a2, a9, 2bf1 <LDNR_xtensa_real_fft_32b+0x59>
    2be9:	f57081        	l32r	a8, 1ac (2958 <LDNR_xtensa_fft512_32b>)
    2bec:	03ad           	mov.n	a10, a3
    2bee:	0008e0        	callx8	a8

00002bf1 <LDNR_xtensa_real_fft_32b+0x59>:
    2bf1:	02ad           	mov.n	a10, a2
    2bf3:	03bd           	mov.n	a11, a3
    2bf5:	1142d0        	slli	a4, a2, 3
    2bf8:	f56e81        	l32r	a8, 1b0 (2984 <LDNR_real_split>)
    2bfb:	c04340        	sub	a4, a3, a4
    2bfe:	04cd           	mov.n	a12, a4
    2c00:	0008e0        	callx8	a8
    2c03:	848b           	addi.n	a8, a4, 8
    2c05:	0398           	l32i.n	a9, a3, 0
    2c07:	13a8           	l32i.n	a10, a3, 4
    2c09:	0b0c           	movi.n	a11, 0
    2c0b:	11c2c0        	slli	a12, a2, 4
    2c0e:	c4ca           	add.n	a12, a4, a12
    2c10:	13b9           	s32i.n	a11, a3, 4
    2c12:	fcccb2        	addi	a11, a12, -4
    2c15:	c099a0        	sub	a9, a9, a10
    2c18:	0399           	s32i.n	a9, a3, 0
    2c1a:	4622a6        	blti	a2, 2, 2c64 <LDNR_xtensa_real_fft_32b+0xcc>
    2c1d:	a20b           	addi.n	a10, a2, -1
    2c1f:	2191a0        	srai	a9, a10, 1
    2c22:	146a07        	bbci	a10, 0, 2c3a <LDNR_xtensa_real_fft_32b+0xa2>
    2c25:	10c482        	addi	a8, a4, 16
    2c28:	34f8           	l32i.n	a15, a4, 12
    2c2a:	ffdbe2        	addmi	a14, a11, 0xffffff00
    2c2d:	24d8           	l32i.n	a13, a4, 8
    2c2f:	60f0f0        	neg	a15, a15
    2c32:	0bf9           	s32i.n	a15, a11, 0
    2c34:	3f6ed2        	s32i	a13, a14, 252
    2c37:	f4ccb2        	addi	a11, a12, -12
    2c3a:	26a976        	loopgtz	a9, 2c64 <LDNR_xtensa_real_fft_32b+0xcc>
    2c3d:	1898           	l32i.n	a9, a8, 4
    2c3f:	08a8           	l32i.n	a10, a8, 0
    2c41:	ffdbc2        	addmi	a12, a11, 0xffffff00
    2c44:	f8cbd2        	addi	a13, a11, -8
    2c47:	609090        	neg	a9, a9
    2c4a:	ffdde2        	addmi	a14, a13, 0xffffff00
    2c4d:	0b99           	s32i.n	a9, a11, 0
    2c4f:	3f6ca2        	s32i	a10, a12, 252
    2c52:	3898           	l32i.n	a9, a8, 12
    2c54:	f0cbb2        	addi	a11, a11, -16
    2c57:	28a8           	l32i.n	a10, a8, 8
    2c59:	609090        	neg	a9, a9
    2c5c:	10c882        	addi	a8, a8, 16
    2c5f:	0d99           	s32i.n	a9, a13, 0
    2c61:	3f6ea2        	s32i	a10, a14, 252

00002c64 <LDNR_xtensa_real_fft_32b+0xcc>:
    2c64:	f01d           	retw.n

00002c66 <LDNR_xtensa_real_fft_32b+0xce>:
	...

00002c68 <LDNR_xtensa_comp_fft_32b>:
    2c68:	004136        	entry	a1, 32
    2c6b:	168226        	beqi	a2, 8, 2c85 <LDNR_xtensa_comp_fft_32b+0x1d>
    2c6e:	1eb226        	beqi	a2, 16, 2c90 <LDNR_xtensa_comp_fft_32b+0x28>

00002c71 <LDNR_xtensa_comp_fft_32b+0x9>:
    2c71:	28c226        	beqi	a2, 32, 2c9d <LDNR_xtensa_comp_fft_32b+0x35>

00002c74 <LDNR_xtensa_comp_fft_32b+0xc>:
    2c74:	30d226        	beqi	a2, 64, 2ca8 <LDNR_xtensa_comp_fft_32b+0x40>

00002c77 <LDNR_xtensa_comp_fft_32b+0xf>:
    2c77:	3ae226        	beqi	a2, 128, 2cb5 <LDNR_xtensa_comp_fft_32b+0x4d>

00002c7a <LDNR_xtensa_comp_fft_32b+0x12>:
    2c7a:	42f226        	beqi	a2, 0x100, 2cc0 <LDNR_xtensa_comp_fft_32b+0x58>

00002c7d <LDNR_xtensa_comp_fft_32b+0x15>:
    2c7d:	00a282        	movi	a8, 0x200
    2c80:	471287        	beq	a2, a8, 2ccb <LDNR_xtensa_comp_fft_32b+0x63>
    2c83:	f01d           	retw.n

00002c85 <LDNR_xtensa_comp_fft_32b+0x1d>:
    2c85:	f54181        	l32r	a8, 18c (24a8 <LDNR_xtensa_fft8_32b>)
    2c88:	03ad           	mov.n	a10, a3
    2c8a:	0008e0        	callx8	a8
    2c8d:	e0b266        	bnei	a2, 16, 2c71 <LDNR_xtensa_comp_fft_32b+0x9>

00002c90 <LDNR_xtensa_comp_fft_32b+0x28>:
    2c90:	f54281        	l32r	a8, 198 (2858 <LDNR_xtensa_fft16_32b>)
    2c93:	03ad           	mov.n	a10, a3
    2c95:	f03d           	nop.n
    2c97:	0008e0        	callx8	a8
    2c9a:	d6c266        	bnei	a2, 32, 2c74 <LDNR_xtensa_comp_fft_32b+0xc>

00002c9d <LDNR_xtensa_comp_fft_32b+0x35>:
    2c9d:	f53f81        	l32r	a8, 19c (2884 <LDNR_xtensa_fft32_32b>)
    2ca0:	03ad           	mov.n	a10, a3
    2ca2:	0008e0        	callx8	a8
    2ca5:	ced266        	bnei	a2, 64, 2c77 <LDNR_xtensa_comp_fft_32b+0xf>

00002ca8 <LDNR_xtensa_comp_fft_32b+0x40>:
    2ca8:	f53e81        	l32r	a8, 1a0 (28b4 <LDNR_xtensa_fft64_32b>)
    2cab:	03ad           	mov.n	a10, a3
    2cad:	f03d           	nop.n
    2caf:	0008e0        	callx8	a8
    2cb2:	c4e266        	bnei	a2, 128, 2c7a <LDNR_xtensa_comp_fft_32b+0x12>

00002cb5 <LDNR_xtensa_comp_fft_32b+0x4d>:
    2cb5:	f53c81        	l32r	a8, 1a8 (28e4 <LDNR_xtensa_fft128_32b>)
    2cb8:	03ad           	mov.n	a10, a3
    2cba:	0008e0        	callx8	a8
    2cbd:	bcf266        	bnei	a2, 0x100, 2c7d <LDNR_xtensa_comp_fft_32b+0x15>

00002cc0 <LDNR_xtensa_comp_fft_32b+0x58>:
    2cc0:	f53981        	l32r	a8, 1a4 (2910 <LDNR_xtensa_fft256_32b>)
    2cc3:	03ad           	mov.n	a10, a3
    2cc5:	0008e0        	callx8	a8
    2cc8:	ffec46        	j	2c7d <LDNR_xtensa_comp_fft_32b+0x15>

00002ccb <LDNR_xtensa_comp_fft_32b+0x63>:
    2ccb:	f53881        	l32r	a8, 1ac (2958 <LDNR_xtensa_fft512_32b>)
    2cce:	03ad           	mov.n	a10, a3
    2cd0:	0008e0        	callx8	a8
    2cd3:	f01d           	retw.n

00002cd5 <LDNR_xtensa_comp_fft_32b+0x6d>:
    2cd5:	000000                                        ...

00002cd8 <LDNR_sw_fft_32b_2811>:
    2cd8:	006136        	entry	a1, 48
    2cdb:	00a282        	movi	a8, 0x200
    2cde:	960b           	addi.n	a9, a6, -1
    2ce0:	07c916        	beqz	a9, 2d60 <LDNR_sw_fft_32b_2811+0x88>

00002ce3 <LDNR_sw_fft_32b_2811+0xb>:
    2ce3:	0a9616        	beqz	a6, 2d90 <LDNR_sw_fft_32b_2811+0xb8>

00002ce6 <LDNR_sw_fft_32b_2811+0xe>:
    2ce6:	600204        	ae_lq32f.i	aeq0, a2, 0
    2ce9:	208220        	or	a8, a2, a2
    2cec:	1173f0        	slli	a7, a3, 1
    2cef:	87ad           	ae_sext16	a10, a7
    2cf1:	08aa76        	loopgtz	a10, 2cfd <LDNR_sw_fft_32b_2811+0x25>
    2cf4:	3404b4        	ae_sraaq56	aeq0, aeq0, a4
    2cf7:	620804        	ae_sq32f.i	aeq0, a8, 0
    2cfa:	601814        	ae_lq32f.iu	aeq0, a8, 4

00002cfd <LDNR_sw_fft_32b_2811+0x25>:
    2cfd:	a60b           	addi.n	a10, a6, -1
    2cff:	0b7a16        	beqz	a10, 2dba <LDNR_sw_fft_32b_2811+0xe2>
    2d02:	f52c81        	l32r	a8, 1b4 (2b98 <LDNR_xtensa_real_fft_32b>)
    2d05:	03ad           	mov.n	a10, a3
    2d07:	20b220        	or	a11, a2, a2
    2d0a:	0008e0        	callx8	a8
    2d0d:	878d           	ae_sext16	a8, a7
    2d0f:	11a3e0        	slli	a10, a3, 2
    2d12:	8aad           	ae_sext16	a10, a10

00002d14 <LDNR_sw_fft_32b_2811+0x3c>:
    2d14:	421566        	bnei	a5, 1, 2d5a <LDNR_sw_fft_32b_2811+0x82>
    2d17:	11b8e0        	slli	a11, a8, 2
    2d1a:	c0b2b0        	sub	a11, a2, a11
    2d1d:	600b04        	ae_lq32f.i	aeq0, a11, 0
    2d20:	fe24938bbf 	{ or	a8, a11, a11; ae_zeroq56	aeq2 }
    2d25:	07aa76        	loopgtz	a10, 2d30 <LDNR_sw_fft_32b_2811+0x58>
    2d28:	fd00bd181f 	{ ae_lq32f.iu	aeq0, a8, 4; ae_absq56	aeq1, aeq0 }
    2d2d:	019ae4        	ae_orq56	aeq2, aeq2, aeq1

00002d30 <LDNR_sw_fft_32b_2811+0x58>:
    2d30:	622104        	ae_sq32f.i	aeq2, a1, 0
    2d33:	01e8           	l32i.n	a14, a1, 0
    2d35:	600b04        	ae_lq32f.i	aeq0, a11, 0
    2d38:	090c           	movi.n	a9, 0
    2d3a:	40eed0        	nsa	a13, a14
    2d3d:	8ddd           	ae_sext16	a13, a13
    2d3f:	b39de0        	movgez	a9, a13, a14
    2d42:	0020f0        	nop
    2d45:	0aaa76        	loopgtz	a10, 2d53 <LDNR_sw_fft_32b_2811+0x7b>
    2d48:	fc24fe890f 	{ ae_slaasq56s	aeq0, aeq0, a9; nop }
    2d4d:	620b04        	ae_sq32f.i	aeq0, a11, 0
    2d50:	601b14        	ae_lq32f.iu	aeq0, a11, 4
    2d53:	c02490        	sub	a2, a4, a9
    2d56:	822d           	ae_sext16	a2, a2
    2d58:	f01d           	retw.n

00002d5a <LDNR_sw_fft_32b_2811+0x82>:
    2d5a:	042d           	mov.n	a2, a4
    2d5c:	f01d           	retw.n

00002d5e <LDNR_sw_fft_32b_2811+0x86>:
	...

00002d60 <LDNR_sw_fft_32b_2811+0x88>:
    2d60:	f8c392        	addi	a9, a3, -8
    2d63:	f7c916        	beqz	a9, 2ce3 <LDNR_sw_fft_32b_2811+0xb>
    2d66:	f0c3a2        	addi	a10, a3, -16
    2d69:	f76a16        	beqz	a10, 2ce3 <LDNR_sw_fft_32b_2811+0xb>
    2d6c:	e0c3b2        	addi	a11, a3, -32
    2d6f:	f70b16        	beqz	a11, 2ce3 <LDNR_sw_fft_32b_2811+0xb>
    2d72:	c0c3c2        	addi	a12, a3, -64
    2d75:	f6ac16        	beqz	a12, 2ce3 <LDNR_sw_fft_32b_2811+0xb>
    2d78:	80c3d2        	addi	a13, a3, -128
    2d7b:	f64d16        	beqz	a13, 2ce3 <LDNR_sw_fft_32b_2811+0xb>
    2d7e:	ffd3e2        	addmi	a14, a3, 0xffffff00
    2d81:	f5ee16        	beqz	a14, 2ce3 <LDNR_sw_fft_32b_2811+0xb>
    2d84:	fed3f2        	addmi	a15, a3, 0xfffffe00
    2d87:	f58f16        	beqz	a15, 2ce3 <LDNR_sw_fft_32b_2811+0xb>

00002d8a <LDNR_sw_fft_32b_2811+0xb2>:
    2d8a:	126c           	movi.n	a2, -31
    2d8c:	f01d           	retw.n

00002d8e <LDNR_sw_fft_32b_2811+0xb6>:
	...

00002d90 <LDNR_sw_fft_32b_2811+0xb8>:
    2d90:	f8c392        	addi	a9, a3, -8
    2d93:	f4f916        	beqz	a9, 2ce6 <LDNR_sw_fft_32b_2811+0xe>
    2d96:	f0c3a2        	addi	a10, a3, -16
    2d99:	f49a16        	beqz	a10, 2ce6 <LDNR_sw_fft_32b_2811+0xe>
    2d9c:	e0c3b2        	addi	a11, a3, -32
    2d9f:	f43b16        	beqz	a11, 2ce6 <LDNR_sw_fft_32b_2811+0xe>
    2da2:	c0c3c2        	addi	a12, a3, -64
    2da5:	f3dc16        	beqz	a12, 2ce6 <LDNR_sw_fft_32b_2811+0xe>
    2da8:	80c3d2        	addi	a13, a3, -128
    2dab:	f37d16        	beqz	a13, 2ce6 <LDNR_sw_fft_32b_2811+0xe>
    2dae:	ffd3e2        	addmi	a14, a3, 0xffffff00
    2db1:	f31e16        	beqz	a14, 2ce6 <LDNR_sw_fft_32b_2811+0xe>
    2db4:	d29387        	bne	a3, a8, 2d8a <LDNR_sw_fft_32b_2811+0xb2>
    2db7:	ffcac6        	j	2ce6 <LDNR_sw_fft_32b_2811+0xe>

00002dba <LDNR_sw_fft_32b_2811+0xe2>:
    2dba:	f4ff81        	l32r	a8, 1b8 (2c68 <LDNR_xtensa_comp_fft_32b>)
    2dbd:	03ad           	mov.n	a10, a3
    2dbf:	02bd           	mov.n	a11, a2
    2dc1:	0008e0        	callx8	a8
    2dc4:	87ad           	ae_sext16	a10, a7
    2dc6:	080c           	movi.n	a8, 0
    2dc8:	ffd206        	j	2d14 <LDNR_sw_fft_32b_2811+0x3c>

00002dcb <LDNR_sw_fft_32b_2811+0xf3>:
    2dcb:	00000000 00413600                                .....

00002dd0 <__do_global_ctors_aux>:
    2dd0:	004136        	entry	a1, 32
    2dd3:	f4fa81        	l32r	a8, 1bc (3cc0 <LDNR_ROOTS_512_Q16+0x10>)
    2dd6:	7f2882        	l32i	a8, a8, 0x1fc
    2dd9:	f4f921        	l32r	a2, 1c0 (3ebc <__CTOR_LIST___47>)
    2ddc:	0c0826        	beqi	a8, -1, 2dec <__do_global_ctors_aux+0x1c>
    2ddf:	02a8           	l32i.n	a10, a2, 0

00002de1 <__do_global_ctors_aux+0x11>:
    2de1:	000ae0        	callx8	a10
    2de4:	fcc222        	addi	a2, a2, -4
    2de7:	02a8           	l32i.n	a10, a2, 0
    2de9:	f40a66        	bnei	a10, -1, 2de1 <__do_global_ctors_aux+0x11>

00002dec <__do_global_ctors_aux+0x1c>:
    2dec:	f01d           	retw.n

00002dee <__do_global_ctors_aux+0x1e>:
	...

00002df0 <__ashldi3>:
    2df0:	002136        	entry	a1, 16
    2df3:	401400        	ssl	a4
    2df6:	07c4e6        	bgei	a4, 32, 2e01 <__ashldi3+0x11>
    2df9:	813320        	src	a3, a3, a2
    2dfc:	a12200        	sll	a2, a2
    2dff:	f01d           	retw.n

00002e01 <__ashldi3+0x11>:
    2e01:	a13200        	sll	a3, a2
    2e04:	020c           	movi.n	a2, 0
    2e06:	f01d           	retw.n

00002e08 <__ashrdi3>:
    2e08:	002136        	entry	a1, 16
    2e0b:	400400        	ssr	a4
    2e0e:	07c4e6        	bgei	a4, 32, 2e19 <__ashrdi3+0x11>
    2e11:	812320        	src	a2, a3, a2
    2e14:	b13030        	sra	a3, a3
    2e17:	f01d           	retw.n

00002e19 <__ashrdi3+0x11>:
    2e19:	b12030        	sra	a2, a3
    2e1c:	313f30        	srai	a3, a3, 31
    2e1f:	f01d           	retw.n

00002e21 <__ashrdi3+0x19>:
    2e21:	000000                                        ...

00002e24 <_fini>:
    2e24:	008136        	entry	a1, 64
    2e27:	f4e781        	l32r	a8, 1c4 (1e0 <__do_global_dtors_aux>)
    2e2a:	f03d           	nop.n
    2e2c:	0008e0        	callx8	a8

00002e2f <_fini+0xb>:
    2e2f:	f01d           	retw.n
