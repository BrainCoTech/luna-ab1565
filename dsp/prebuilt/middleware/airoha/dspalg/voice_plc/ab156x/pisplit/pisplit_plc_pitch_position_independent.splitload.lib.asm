
Build/lib/pisplit_plc_pitch_position_independent.splitload.lib:     file format elf32-xtensa-le


Disassembly of section .text:

00000000 <_init-0x88>:
       0:	000000d4 00001a48 0000202c 00000000     ....H..., ......
      10:	00001ffc 00000000 00002014 000016e4     ......... ......
      20:	00001250 00000174 00002040 00002060     P...t...@ ..` ..
      30:	00002080 00001258 00001aa4 00001a68     . ..X.......h...
      40:	00001750 000019bc 8000ffff 000e0008     P...............
      50:	000f000a 0001000a 00010001 00002090     ............. ..
      60:	00002160 0000210c 00001918 00002125     `!...!......%!..
      70:	00000154 0000213f 000003dc 00002100     T...?!.......!..
      80:	00002004 000000a0                       . ......

00000088 <_init>:
      88:	008136        	entry	a1, 64
      8b:	ffdd81        	l32r	a8, 0 (d4 <frame_dummy>)
      8e:	f03d           	nop.n
      90:	0008e0        	callx8	a8
      93:	ffdc81        	l32r	a8, 4 (1a48 <__do_global_ctors_aux>)
      96:	f03d           	nop.n
      98:	0008e0        	callx8	a8
      9b:	f01d           	retw.n

0000009d <_init+0x15>:
      9d:	000000                                        ...

000000a0 <__do_global_dtors_aux>:
      a0:	004136        	entry	a1, 32
      a3:	ffd921        	l32r	a2, 8 (202c <__do_global_dtors_aux.completed>)
      a6:	000232        	l8ui	a3, a2, 0
      a9:	23ec           	bnez.n	a3, cf <__do_global_dtors_aux+0x2f>

000000ab <__do_global_dtors_aux+0xb>:
      ab:	1248           	l32i.n	a4, a2, 4
      ad:	0438           	l32i.n	a3, a4, 0
      af:	444b           	addi.n	a4, a4, 4
      b1:	738c           	beqz.n	a3, bc <__do_global_dtors_aux+0x1c>
      b3:	1249           	s32i.n	a4, a2, 4
      b5:	0003e0        	callx8	a3
      b8:	fffbc6        	j	ab <__do_global_dtors_aux+0xb>

000000bb <__do_global_dtors_aux+0x1b>:
	...

000000bc <__do_global_dtors_aux+0x1c>:
      bc:	ffd431        	l32r	a3, c (0 <_text_start>)
      bf:	ffd4a1        	l32r	a10, 10 (1ffc <__FRAME_END__>)
      c2:	438c           	beqz.n	a3, ca <__do_global_dtors_aux+0x2a>
      c4:	ffd281        	l32r	a8, c (0 <_text_start>)
      c7:	0008e0        	callx8	a8
      ca:	130c           	movi.n	a3, 1
      cc:	004232        	s8i	a3, a2, 0
      cf:	f01d           	retw.n

000000d1 <__do_global_dtors_aux+0x31>:
      d1:	000000                                        ...

000000d4 <frame_dummy>:
      d4:	004136        	entry	a1, 32
      d7:	ffcf21        	l32r	a2, 14 (0 <_text_start>)
      da:	ffcda1        	l32r	a10, 10 (1ffc <__FRAME_END__>)
      dd:	ffceb1        	l32r	a11, 18 (2014 <frame_dummy.object>)
      e0:	428c           	beqz.n	a2, e8 <frame_dummy+0x14>
      e2:	ffcc81        	l32r	a8, 14 (0 <_text_start>)
      e5:	0008e0        	callx8	a8

000000e8 <frame_dummy+0x14>:
      e8:	f01d           	retw.n

000000ea <frame_dummy+0x16>:
      ea:	00000000                                 ......

000000f0 <memset>:
      f0:	004136        	entry	a1, 32
      f3:	205220        	or	a5, a2, a2
      f6:	04bc           	beqz.n	a4, 12a <memset+0x3a>
      f8:	246040        	extui	a6, a4, 0, 3
      fb:	202550        	or	a2, a5, a5
      fe:	414340        	srli	a4, a4, 3
     101:	049676        	loopnez	a6, 109 <memset+0x19>
     104:	004232        	s8i	a3, a2, 0
     107:	221b           	addi.n	a2, a2, 1

00000109 <memset+0x19>:
     109:	d49c           	beqz.n	a4, 12a <memset+0x3a>
     10b:	f03d           	nop.n
     10d:	199476        	loopnez	a4, 12a <memset+0x3a>
     110:	004232        	s8i	a3, a2, 0
     113:	074232        	s8i	a3, a2, 7
     116:	064232        	s8i	a3, a2, 6
     119:	054232        	s8i	a3, a2, 5
     11c:	014232        	s8i	a3, a2, 1
     11f:	044232        	s8i	a3, a2, 4
     122:	034232        	s8i	a3, a2, 3
     125:	024232        	s8i	a3, a2, 2
     128:	228b           	addi.n	a2, a2, 8

0000012a <memset+0x3a>:
     12a:	052d           	mov.n	a2, a5
     12c:	f01d           	retw.n

0000012e <memset+0x3e>:
	...

00000130 <xt_memset_plc>:
     130:	004136        	entry	a1, 32
     133:	025d           	mov.n	a5, a2
     135:	729c           	beqz.n	a2, 150 <xt_memset_plc+0x20>
     137:	549c           	beqz.n	a4, 150 <xt_memset_plc+0x20>
     139:	052d           	mov.n	a2, a5
     13b:	416140        	srli	a6, a4, 1
     13e:	036407        	bbci	a4, 0, 145 <xt_memset_plc+0x15>
     141:	623d           	ae_s16i.n	a3, a2, 0
     143:	222b           	addi.n	a2, a2, 2

00000145 <xt_memset_plc+0x15>:
     145:	768c           	beqz.n	a6, 150 <xt_memset_plc+0x20>
     147:	059676        	loopnez	a6, 150 <xt_memset_plc+0x20>
     14a:	623d           	ae_s16i.n	a3, a2, 0
     14c:	723d           	ae_s16i.n	a3, a2, 2
     14e:	224b           	addi.n	a2, a2, 4

00000150 <xt_memset_plc+0x20>:
     150:	052d           	mov.n	a2, a5
     152:	f01d           	retw.n

00000154 <SMART_PITCH_PLC_INI>:
     154:	004136        	entry	a1, 32
     157:	ffb141        	l32r	a4, 1c (16e4 <plc_gainctrl_ini>)
     15a:	20a220        	or	a10, a2, a2
     15d:	f03d           	nop.n
     15f:	0004e0        	callx8	a4
     162:	ffaf41        	l32r	a4, 20 (1250 <find_pitch_ini>)
     165:	0004e0        	callx8	a4
     168:	ffaf41        	l32r	a4, 24 (174 <cvsd_a2plc_ini>)
     16b:	03ad           	mov.n	a10, a3
     16d:	02bd           	mov.n	a11, a2
     16f:	0004e0        	callx8	a4
     172:	f01d           	retw.n

00000174 <cvsd_a2plc_ini>:
     174:	004136        	entry	a1, 32
     177:	4b23e2        	l32i	a14, a3, 0x12c
     17a:	03ad           	mov.n	a10, a3
     17c:	3923d2        	l32i	a13, a3, 228
     17f:	3a23f2        	l32i	a15, a3, 232
     182:	02bd           	mov.n	a11, a2
     184:	e3d9           	s32i.n	a13, a3, 56
     186:	f3f9           	s32i.n	a15, a3, 60
     188:	089e16        	beqz	a14, 215 <cvsd_a2plc_ini+0xa1>
     18b:	2f3c           	movi.n	a15, 50
     18d:	c43c           	movi.n	a4, 60
     18f:	1e0c           	movi.n	a14, 1
     191:	5af9           	s32i.n	a15, a10, 20
     193:	08a2f2        	movi	a15, 0x208
     196:	031c           	movi.n	a3, 16
     198:	020c           	movi.n	a2, 0
     19a:	2a49           	s32i.n	a4, a10, 8
     19c:	4ae9           	s32i.n	a14, a10, 16
     19e:	a0a052        	movi	a5, 160
     1a1:	6ea062        	movi	a6, 110
     1a4:	872c           	movi.n	a7, 40
     1a6:	380c           	movi.n	a8, 3
     1a8:	08a292        	movi	a9, 0x208
     1ab:	6c4c           	movi.n	a12, 70
     1ad:	e6a0d2        	movi	a13, 230
     1b0:	30a2e2        	movi	a14, 0x230
     1b3:	4141f0        	srli	a4, a15, 1
     1b6:	1a39           	s32i.n	a3, a10, 4
     1b8:	0a39           	s32i.n	a3, a10, 0
     1ba:	3a39           	s32i.n	a3, a10, 12
     1bc:	3aea           	add.n	a3, a10, a14
     1be:	6a59           	s32i.n	a5, a10, 24
     1c0:	7a69           	s32i.n	a6, a10, 28
     1c2:	8a79           	s32i.n	a7, a10, 32
     1c4:	9a89           	s32i.n	a8, a10, 36
     1c6:	aa99           	s32i.n	a9, a10, 40
     1c8:	bac9           	s32i.n	a12, a10, 44
     1ca:	cad9           	s32i.n	a13, a10, 48
     1cc:	3d6a22        	s32i	a2, a10, 244
     1cf:	059476        	loopnez	a4, 1d8 <cvsd_a2plc_ini+0x64>
     1d2:	632d           	ae_s16i.n	a2, a3, 0
     1d4:	732d           	ae_s16i.n	a2, a3, 2
     1d6:	334b           	addi.n	a3, a3, 4

000001d8 <cvsd_a2plc_ini+0x64>:
     1d8:	842c           	movi.n	a4, 40
     1da:	68a632        	movi	a3, 0x668
     1dd:	414140        	srli	a4, a4, 1
     1e0:	020c           	movi.n	a2, 0
     1e2:	803a30        	add	a3, a10, a3
     1e5:	059476        	loopnez	a4, 1ee <cvsd_a2plc_ini+0x7a>
     1e8:	632d           	ae_s16i.n	a2, a3, 0
     1ea:	732d           	ae_s16i.n	a2, a3, 2
     1ec:	334b           	addi.n	a3, a3, 4
     1ee:	08a242        	movi	a4, 0x208
     1f1:	e0a632        	movi	a3, 0x6e0
     1f4:	414140        	srli	a4, a4, 1
     1f7:	08a2c2        	movi	a12, 0x208
     1fa:	020c           	movi.n	a2, 0
     1fc:	3a3a           	add.n	a3, a10, a3
     1fe:	059476        	loopnez	a4, 207 <cvsd_a2plc_ini+0x93>
     201:	632d           	ae_s16i.n	a2, a3, 0
     203:	732d           	ae_s16i.n	a2, a3, 2
     205:	334b           	addi.n	a3, a3, 4
     207:	2d3c           	movi.n	a13, 50
     209:	0a78           	l32i.n	a7, a10, 0
     20b:	0217a6        	blti	a7, 1, 211 <cvsd_a2plc_ini+0x9d>
     20e:	002086        	j	294 <cvsd_a2plc_ini+0x120>
     211:	003806        	j	2f5 <cvsd_a2plc_ini+0x181>

00000214 <cvsd_a2plc_ini+0xa0>:
	...

00000215 <cvsd_a2plc_ini+0xa1>:
     215:	641c           	movi.n	a4, 22
     217:	86a1f2        	movi	a15, 0x186
     21a:	e20c           	movi.n	a2, 14
     21c:	872c           	movi.n	a7, 40
     21e:	830c           	movi.n	a3, 8
     220:	160c           	movi.n	a6, 1
     222:	2a49           	s32i.n	a4, a10, 8
     224:	78a082        	movi	a8, 120
     227:	095c           	movi.n	a9, 80
     229:	ec1c           	movi.n	a12, 30
     22b:	86a1d2        	movi	a13, 0x186
     22e:	a0a052        	movi	a5, 160
     231:	30a2e2        	movi	a14, 0x230
     234:	4141f0        	srli	a4, a15, 1
     237:	0a39           	s32i.n	a3, a10, 0
     239:	1a29           	s32i.n	a2, a10, 4
     23b:	3a29           	s32i.n	a2, a10, 12
     23d:	4a69           	s32i.n	a6, a10, 16
     23f:	6a89           	s32i.n	a8, a10, 24
     241:	7a99           	s32i.n	a9, a10, 28
     243:	8ac9           	s32i.n	a12, a10, 32
     245:	aad9           	s32i.n	a13, a10, 40
     247:	5a79           	s32i.n	a7, a10, 20
     249:	ba79           	s32i.n	a7, a10, 44
     24b:	020c           	movi.n	a2, 0
     24d:	3aea           	add.n	a3, a10, a14
     24f:	ca59           	s32i.n	a5, a10, 48
     251:	059476        	loopnez	a4, 25a <cvsd_a2plc_ini+0xe6>
     254:	632d           	ae_s16i.n	a2, a3, 0
     256:	732d           	ae_s16i.n	a2, a3, 2
     258:	334b           	addi.n	a3, a3, 4

0000025a <cvsd_a2plc_ini+0xe6>:
     25a:	e41c           	movi.n	a4, 30
     25c:	68a632        	movi	a3, 0x668
     25f:	414140        	srli	a4, a4, 1
     262:	020c           	movi.n	a2, 0
     264:	3a3a           	add.n	a3, a10, a3
     266:	059476        	loopnez	a4, 26f <cvsd_a2plc_ini+0xfb>
     269:	632d           	ae_s16i.n	a2, a3, 0
     26b:	732d           	ae_s16i.n	a2, a3, 2
     26d:	334b           	addi.n	a3, a3, 4
     26f:	86a142        	movi	a4, 0x186
     272:	e0a632        	movi	a3, 0x6e0
     275:	414140        	srli	a4, a4, 1
     278:	020c           	movi.n	a2, 0
     27a:	803a30        	add	a3, a10, a3
     27d:	059476        	loopnez	a4, 286 <cvsd_a2plc_ini+0x112>
     280:	632d           	ae_s16i.n	a2, a3, 0
     282:	732d           	ae_s16i.n	a2, a3, 2
     284:	334b           	addi.n	a3, a3, 4
     286:	320c           	movi.n	a2, 3
     288:	86a1c2        	movi	a12, 0x186
     28b:	8d2c           	movi.n	a13, 40
     28d:	9a29           	s32i.n	a2, a10, 36
     28f:	0a78           	l32i.n	a7, a10, 0
     291:	6017a6        	blti	a7, 1, 2f5 <cvsd_a2plc_ini+0x181>

00000294 <cvsd_a2plc_ini+0x120>:
     294:	f0c742        	addi	a4, a7, -16
     297:	050c           	movi.n	a5, 0
     299:	ff6321        	l32r	a2, 28 (2040 <rc_win_right_16s>)
     29c:	ff6431        	l32r	a3, 2c (2060 <rc_win_left_16s>)
     29f:	624540        	saltu	a4, a5, a4
     2a2:	f0a182        	movi	a8, 0x1f0
     2a5:	401400        	ssl	a4
     2a8:	416170        	srli	a6, a7, 1
     2ab:	4a8a           	add.n	a4, a10, a8
     2ad:	156707        	bbci	a7, 0, 2c6 <cvsd_a2plc_ini+0x152>
     2b0:	a17500        	sll	a7, a5
     2b3:	908720        	addx2	a8, a7, a2
     2b6:	288d           	ae_l16si.n	a8, a8, 0
     2b8:	907730        	addx2	a7, a7, a3
     2bb:	105482        	s16i	a8, a4, 32
     2be:	277d           	ae_l16si.n	a7, a7, 0
     2c0:	647d           	ae_s16i.n	a7, a4, 0
     2c2:	551b           	addi.n	a5, a5, 1
     2c4:	442b           	addi.n	a4, a4, 2
     2c6:	b6ac           	beqz.n	a6, 2f5 <cvsd_a2plc_ini+0x181>
     2c8:	299676        	loopnez	a6, 2f5 <cvsd_a2plc_ini+0x181>
     2cb:	a17500        	sll	a7, a5
     2ce:	906730        	addx2	a6, a7, a3
     2d1:	851b           	addi.n	a8, a5, 1
     2d3:	581b           	addi.n	a5, a8, 1
     2d5:	907720        	addx2	a7, a7, a2
     2d8:	277d           	ae_l16si.n	a7, a7, 0
     2da:	a19800        	sll	a9, a8
     2dd:	908930        	addx2	a8, a9, a3
     2e0:	909920        	addx2	a9, a9, a2
     2e3:	105472        	s16i	a7, a4, 32
     2e6:	266d           	ae_l16si.n	a6, a6, 0
     2e8:	646d           	ae_s16i.n	a6, a4, 0
     2ea:	296d           	ae_l16si.n	a6, a9, 0
     2ec:	115462        	s16i	a6, a4, 34
     2ef:	286d           	ae_l16si.n	a6, a8, 0
     2f1:	746d           	ae_s16i.n	a6, a4, 2
     2f3:	444b           	addi.n	a4, a4, 4

000002f5 <cvsd_a2plc_ini+0x181>:
     2f5:	e41c           	movi.n	a4, 30
     2f7:	824b40        	mull	a4, a11, a4
     2fa:	130c           	movi.n	a3, 1
     2fc:	113310        	slli	a3, a3, 15
     2ff:	1ec442        	addi	a4, a4, 30
     302:	63a1e2        	movi	a14, 0x163
     305:	4f1c           	movi.n	a15, 20
     307:	020c           	movi.n	a2, 0
     309:	106a32        	s32i	a3, a10, 64
     30c:	113ed0        	slli	a3, a14, 3
     30f:	1a6a42        	s32i	a4, a10, 104
     312:	4142f0        	srli	a4, a15, 2
     315:	3a3a           	add.n	a3, a10, a3
     317:	da29           	s32i.n	a2, a10, 52
     319:	0a9476        	loopnez	a4, 327 <cvsd_a2plc_ini+0x1b3>
     31c:	0329           	s32i.n	a2, a3, 0
     31e:	3329           	s32i.n	a2, a3, 12
     320:	2329           	s32i.n	a2, a3, 8
     322:	1329           	s32i.n	a2, a3, 4
     324:	10c332        	addi	a3, a3, 16

00000327 <cvsd_a2plc_ini+0x1b3>:
     327:	ff4231        	l32r	a3, 30 (2080 <zc_diff_size_tab>)
     32a:	ffa042        	movi	a4, 255
     32d:	051c           	movi.n	a5, 16
     32f:	a03b30        	addx4	a3, a11, a3
     332:	020c           	movi.n	a2, 0
     334:	0338           	l32i.n	a3, a3, 0
     336:	7fd442        	addmi	a4, a4, 0x7f00
     339:	70a1e2        	movi	a14, 0x170
     33c:	41f350        	srli	a15, a5, 3
     33f:	146a32        	s32i	a3, a10, 80
     342:	3aea           	add.n	a3, a10, a14
     344:	1b6a42        	s32i	a4, a10, 108
     347:	1c6a42        	s32i	a4, a10, 112
     34a:	1e6a22        	s32i	a2, a10, 120
     34d:	1f6a22        	s32i	a2, a10, 124
     350:	206a22        	s32i	a2, a10, 128
     353:	216a22        	s32i	a2, a10, 132
     356:	196a22        	s32i	a2, a10, 100
     359:	186ac2        	s32i	a12, a10, 96
     35c:	1d6a22        	s32i	a2, a10, 116
     35f:	129f76        	loopnez	a15, 375 <cvsd_a2plc_ini+0x201>
     362:	0329           	s32i.n	a2, a3, 0
     364:	7329           	s32i.n	a2, a3, 28
     366:	6329           	s32i.n	a2, a3, 24
     368:	5329           	s32i.n	a2, a3, 20
     36a:	1329           	s32i.n	a2, a3, 4
     36c:	4329           	s32i.n	a2, a3, 16
     36e:	3329           	s32i.n	a2, a3, 12
     370:	2329           	s32i.n	a2, a3, 8
     372:	20c332        	addi	a3, a3, 32
     375:	041c           	movi.n	a4, 16
     377:	b0a132        	movi	a3, 0x1b0
     37a:	414340        	srli	a4, a4, 3
     37d:	020c           	movi.n	a2, 0
     37f:	3a3a           	add.n	a3, a10, a3
     381:	129476        	loopnez	a4, 397 <cvsd_a2plc_ini+0x223>
     384:	0329           	s32i.n	a2, a3, 0
     386:	7329           	s32i.n	a2, a3, 28
     388:	6329           	s32i.n	a2, a3, 24
     38a:	5329           	s32i.n	a2, a3, 20
     38c:	1329           	s32i.n	a2, a3, 4
     38e:	4329           	s32i.n	a2, a3, 16
     390:	3329           	s32i.n	a2, a3, 12
     392:	2329           	s32i.n	a2, a3, 8
     394:	20c332        	addi	a3, a3, 32
     397:	041c           	movi.n	a4, 16
     399:	b0a132        	movi	a3, 0x1b0
     39c:	414340        	srli	a4, a4, 3
     39f:	020c           	movi.n	a2, 0
     3a1:	3a3a           	add.n	a3, a10, a3
     3a3:	129476        	loopnez	a4, 3b9 <cvsd_a2plc_ini+0x245>
     3a6:	0329           	s32i.n	a2, a3, 0
     3a8:	7329           	s32i.n	a2, a3, 28
     3aa:	6329           	s32i.n	a2, a3, 24
     3ac:	5329           	s32i.n	a2, a3, 20
     3ae:	1329           	s32i.n	a2, a3, 4
     3b0:	4329           	s32i.n	a2, a3, 16
     3b2:	3329           	s32i.n	a2, a3, 12
     3b4:	2329           	s32i.n	a2, a3, 8
     3b6:	20c332        	addi	a3, a3, 32
     3b9:	020c           	movi.n	a2, 0
     3bb:	130c           	movi.n	a3, 1
     3bd:	c04cd0        	sub	a4, a12, a13
     3c0:	250c           	movi.n	a5, 2
     3c2:	226ad2        	s32i	a13, a10, 136
     3c5:	166ad2        	s32i	a13, a10, 88
     3c8:	126a22        	s32i	a2, a10, 72
     3cb:	116a32        	s32i	a3, a10, 68
     3ce:	156a52        	s32i	a5, a10, 84
     3d1:	176a42        	s32i	a4, a10, 92
     3d4:	136a22        	s32i	a2, a10, 76
     3d7:	f01d           	retw.n

000003d9 <cvsd_a2plc_ini+0x265>:
     3d9:	000000                                        ...

000003dc <SMART_PITCH_PLC_PROCESS>:
     3dc:	012136        	entry	a1, 144
     3df:	2521f2        	l32i	a15, a1, 148
     3e2:	03ad           	mov.n	a10, a3
     3e4:	2421e2        	l32i	a14, a1, 144
     3e7:	0f88           	l32i.n	a8, a15, 0
     3e9:	af68           	l32i.n	a6, a15, 40
     3eb:	192f32        	l32i	a3, a15, 100
     3ee:	02bd           	mov.n	a11, a2
     3f0:	11ea16        	beqz	a10, 512 <SMART_PITCH_PLC_PROCESS+0x136>
     3f3:	6169           	s32i.n	a6, a1, 24
     3f5:	6db316        	beqz	a3, ad4 <SMART_PITCH_PLC_PROCESS+0x6f8>
     3f8:	2f78           	l32i.n	a7, a15, 8
     3fa:	78a022        	movi	a2, 120
     3fd:	71e9           	s32i.n	a14, a1, 28
     3ff:	81a9           	s32i.n	a10, a1, 32
     401:	021e27        	beq	a14, a2, 407 <SMART_PITCH_PLC_PROCESS+0x2b>
     404:	005086        	j	54a <SMART_PITCH_PLC_PROCESS+0x16e>
     407:	4b2f22        	l32i	a2, a15, 0x12c
     40a:	30a232        	movi	a3, 0x230
     40d:	0b6d           	mov.n	a6, a11
     40f:	137216        	beqz	a2, 54a <SMART_PITCH_PLC_PROCESS+0x16e>
     412:	2f3a           	add.n	a2, a15, a3
     414:	162fb2        	l32i	a11, a15, 88
     417:	172fc2        	l32i	a12, a15, 92
     41a:	ff0841        	l32r	a4, 3c (1a68 <getfespeech>)
     41d:	78a0d2        	movi	a13, 120
     420:	02ad           	mov.n	a10, a2
     422:	02ed           	mov.n	a14, a2
     424:	0f5d           	mov.n	a5, a15
     426:	0004e0        	callx8	a4
     429:	1c2542        	l32i	a4, a5, 112
     42c:	fea0e2        	movi	a14, 254
     42f:	05fd           	mov.n	a15, a5
     431:	7fde52        	addmi	a5, a14, 0x7f00
     434:	06bd           	mov.n	a11, a6
     436:	252547        	blt	a5, a4, 45f <SMART_PITCH_PLC_PROCESS+0x83>
     439:	412f34        	ae_lp16f.x	aep2, a15, a3
     43c:	300444        	ae_cvtp24a16x2.ll	aep0, a4, a4
     43f:	ea098078ef 	{ movi	a14, 120; ae_mulfp24s.ll	aeq0, aep2, aep0 }
     444:	40a214        	ae_lp16f.iu	aep2, a2, 2
     447:	f8e3cffe3e 	{ addi	a3, a14, -1; ae_roundsp16q48sym	aep1, aeq0 }
     44c:	02ad           	mov.n	a10, a2
     44e:	0a8376        	loop	a3, 45c <SMART_PITCH_PLC_PROCESS+0x80>
     451:	012074        	ae_mulfp24s.ll	aeq0, aep2, aep0
     454:	421af4        	ae_sp16f.l.i	aep1, a10, -2
     457:	f8e3ecaa1f 	{ ae_lp16f.iu	aep2, a10, 2; ae_roundsp16q48sym	aep1, aeq0 }

0000045c <SMART_PITCH_PLC_PROCESS+0x80>:
     45c:	421af4        	ae_sp16f.l.i	aep1, a10, -2

0000045f <SMART_PITCH_PLC_PROCESS+0x83>:
     45f:	71e8           	l32i.n	a14, a1, 28
     461:	81a8           	l32i.n	a10, a1, 32
     463:	2517a6        	blti	a7, 1, 48c <SMART_PITCH_PLC_PROCESS+0xb0>
     466:	30a222        	movi	a2, 0x230
     469:	414170        	srli	a4, a7, 1
     46c:	0b3d           	mov.n	a3, a11
     46e:	2f2a           	add.n	a2, a15, a2
     470:	076707        	bbci	a7, 0, 47b <SMART_PITCH_PLC_PROCESS+0x9f>
     473:	225d           	ae_l16si.n	a5, a2, 0
     475:	635d           	ae_s16i.n	a5, a3, 0
     477:	222b           	addi.n	a2, a2, 2
     479:	332b           	addi.n	a3, a3, 2
     47b:	d48c           	beqz.n	a4, 48c <SMART_PITCH_PLC_PROCESS+0xb0>
     47d:	0b9476        	loopnez	a4, 48c <SMART_PITCH_PLC_PROCESS+0xb0>
     480:	224d           	ae_l16si.n	a4, a2, 0
     482:	634d           	ae_s16i.n	a4, a3, 0
     484:	324d           	ae_l16si.n	a4, a2, 2
     486:	734d           	ae_s16i.n	a4, a3, 2
     488:	334b           	addi.n	a3, a3, 4
     48a:	224b           	addi.n	a2, a2, 4

0000048c <SMART_PITCH_PLC_PROCESS+0xb0>:
     48c:	78a022        	movi	a2, 120
     48f:	140c           	movi.n	a4, 1
     491:	014490        	slli	a4, a4, 23
     494:	c02270        	sub	a2, a2, a7
     497:	77a032        	movi	a3, 119
     49a:	d22420        	quos	a2, a4, a2
     49d:	02a377        	bge	a3, a7, 4a3 <SMART_PITCH_PLC_PROCESS+0xc7>
     4a0:	018c06        	j	ad4 <SMART_PITCH_PLC_PROCESS+0x6f8>
     4a3:	9037b0        	addx2	a3, a7, a11
     4a6:	88c7c2        	addi	a12, a7, -120
     4a9:	9057f0        	addx2	a5, a7, a15
     4ac:	30a262        	movi	a6, 0x230
     4af:	608020        	neg	a8, a2
     4b2:	c09420        	sub	a9, a4, a2
     4b5:	411564        	ae_lp16f.x	aep1, a5, a6
     4b8:	402304        	ae_lp16f.i	aep2, a3, 0
     4bb:	60d0c0        	neg	a13, a12
     4be:	456a           	add.n	a4, a5, a6
     4c0:	dd4622082f 	{ ae_movpa24x2	aep0, a8, a2; ae_selp24.ll	aep2, aep1, aep2 }
     4c5:	fec362        	addi	a6, a3, -2
     4c8:	399924        	ae_movpa24x2	aep1, a9, a2
     4cb:	4151d0        	srli	a5, a13, 1
     4ce:	116d07        	bbci	a13, 0, 4e3 <SMART_PITCH_PLC_PROCESS+0x107>
     4d1:	f046acf41f 	{ ae_lp16f.iu	aep7, a4, 2; ae_mulzaafp24s.hh.ll	aeq0, aep1, aep2 }
     4d6:	d8056cb31f 	{ ae_lp16f.iu	aep3, a3, 2; ae_addsp24s	aep1, aep1, aep0 }
     4db:	fae3be73bf 	{ ae_selp24.ll	aep2, aep7, aep3; ae_roundsp16q48sym	aep4, aeq0 }
     4e0:	42c614        	ae_sp16f.l.iu	aep4, a6, 2

000004e3 <SMART_PITCH_PLC_PROCESS+0x107>:
     4e3:	5ed516        	beqz	a5, ad4 <SMART_PITCH_PLC_PROCESS+0x6f8>
     4e6:	062d           	mov.n	a2, a6
     4e8:	229576        	loopnez	a5, 50e <SMART_PITCH_PLC_PROCESS+0x132>
     4eb:	f046aca41f 	{ ae_lp16f.iu	aep2, a4, 2; ae_mulzaafp24s.hh.ll	aeq0, aep1, aep2 }
     4f0:	d8056cb31f 	{ ae_lp16f.iu	aep3, a3, 2; ae_addsp24s	aep1, aep1, aep0 }
     4f5:	f9e3be23ff 	{ ae_selp24.ll	aep3, aep2, aep3; ae_roundsp16q48sym	aep2, aeq0 }
     4fa:	f066b2a21f 	{ ae_sp16f.l.iu	aep2, a2, 2; ae_mulzaafp24s.hh.ll	aeq0, aep1, aep3 }
     4ff:	d8056cc41f 	{ ae_lp16f.iu	aep4, a4, 2; ae_addsp24s	aep1, aep1, aep0 }
     504:	f9e3acb31f 	{ ae_lp16f.iu	aep3, a3, 2; ae_roundsp16q48sym	aep2, aeq0 }
     509:	dd7232a21f 	{ ae_sp16f.l.iu	aep2, a2, 2; ae_selp24.ll	aep2, aep4, aep3 }

0000050e <SMART_PITCH_PLC_PROCESS+0x132>:
     50e:	017086        	j	ad4 <SMART_PITCH_PLC_PROCESS+0x6f8>

00000511 <SMART_PITCH_PLC_PROCESS+0x135>:
	...

00000512 <SMART_PITCH_PLC_PROCESS+0x136>:
     512:	91b9           	s32i.n	a11, a1, 36
     514:	5189           	s32i.n	a8, a1, 20
     516:	293316        	beqz	a3, 7ad <SMART_PITCH_PLC_PROCESS+0x3d1>
     519:	4f28           	l32i.n	a2, a15, 16
     51b:	112f42        	l32i	a4, a15, 68
     51e:	021226        	beqi	a2, 1, 524 <SMART_PITCH_PLC_PROCESS+0x148>
     521:	008186        	j	72b <SMART_PITCH_PLC_PROCESS+0x34f>
     524:	081347        	beq	a3, a4, 530 <SMART_PITCH_PLC_PROCESS+0x154>
     527:	152f22        	l32i	a2, a15, 84
     52a:	021327        	beq	a3, a2, 530 <SMART_PITCH_PLC_PROCESS+0x154>
     52d:	007e86        	j	72b <SMART_PITCH_PLC_PROCESS+0x34f>
     530:	ef28           	l32i.n	a2, a15, 56
     532:	084d           	mov.n	a4, a8
     534:	71e9           	s32i.n	a14, a1, 28
     536:	021226        	beqi	a2, 1, 53c <SMART_PITCH_PLC_PROCESS+0x160>
     539:	018b86        	j	b6b <SMART_PITCH_PLC_PROCESS+0x78f>
     53c:	ff28           	l32i.n	a2, a15, 60
     53e:	1c2f32        	l32i	a3, a15, 112
     541:	822320        	mull	a2, a3, a2
     544:	212f20        	srai	a2, a2, 15
     547:	018986        	j	b71 <SMART_PITCH_PLC_PROCESS+0x795>

0000054a <SMART_PITCH_PLC_PROCESS+0x16e>:
     54a:	30a222        	movi	a2, 0x230
     54d:	af2a           	add.n	a10, a15, a2
     54f:	0b4d           	mov.n	a4, a11
     551:	162fb2        	l32i	a11, a15, 88
     554:	172fc2        	l32i	a12, a15, 92
     557:	feb921        	l32r	a2, 3c (1a68 <getfespeech>)
     55a:	d78a           	add.n	a13, a7, a8
     55c:	0aed           	mov.n	a14, a10
     55e:	5189           	s32i.n	a8, a1, 20
     560:	0f3d           	mov.n	a3, a15
     562:	0002e0        	callx8	a2
     565:	5188           	l32i.n	a8, a1, 20
     567:	04bd           	mov.n	a11, a4
     569:	03fd           	mov.n	a15, a3
     56b:	0218e6        	bgei	a8, 1, 571 <SMART_PITCH_PLC_PROCESS+0x195>
     56e:	002d86        	j	628 <SMART_PITCH_PLC_PROCESS+0x24c>
     571:	f0a122        	movi	a2, 0x1f0
     574:	9037b0        	addx2	a3, a7, a11
     577:	2f2a           	add.n	a2, a15, a2
     579:	fec332        	addi	a3, a3, -2
     57c:	fec252        	addi	a5, a2, -2
     57f:	408314        	ae_lp16f.iu	aep0, a3, 2
     582:	409514        	ae_lp16f.iu	aep1, a5, 2
     585:	ea0781b0cf 	{ movi	a12, 0x1b0; ae_mulp24s.ll	aeq0, aep1, aep0 }
     58a:	4fca           	add.n	a4, a15, a12
     58c:	368d04        	ae_trunca32q48	a13, aeq0
     58f:	ffc8e2        	addi	a14, a8, -1
     592:	0064d2        	s32i	a13, a4, 0
     595:	0f9e76        	loopnez	a14, 5a8 <SMART_PITCH_PLC_PROCESS+0x1cc>
     598:	408514        	ae_lp16f.iu	aep0, a5, 2
     59b:	409314        	ae_lp16f.iu	aep1, a3, 2
     59e:	020174        	ae_mulp24s.ll	aeq0, aep0, aep1
     5a1:	444b           	addi.n	a4, a4, 4
     5a3:	368204        	ae_trunca32q48	a2, aeq0
     5a6:	0429           	s32i.n	a2, a4, 0

000005a8 <SMART_PITCH_PLC_PROCESS+0x1cc>:
     5a8:	30a242        	movi	a4, 0x230
     5ab:	70a162        	movi	a6, 0x170
     5ae:	5f4a           	add.n	a5, a15, a4
     5b0:	1127f0        	slli	a2, a7, 1
     5b3:	413180        	srli	a3, a8, 1
     5b6:	4f6a           	add.n	a4, a15, a6
     5b8:	166807        	bbci	a8, 0, 5d2 <SMART_PITCH_PLC_PROCESS+0x1f6>
     5bb:	e0c562        	addi	a6, a5, -32
     5be:	411524        	ae_lp16f.x	aep1, a5, a2
     5c1:	400604        	ae_lp16f.i	aep0, a6, 0
     5c4:	ea2380255e 	{ addi	a5, a5, 2; ae_mulp24s.ll	aeq0, aep0, aep1 }
     5c9:	368e04        	ae_trunca32q48	a14, aeq0
     5cc:	0064e2        	s32i	a14, a4, 0
     5cf:	04c442        	addi	a4, a4, 4

000005d2 <SMART_PITCH_PLC_PROCESS+0x1f6>:
     5d2:	052316        	beqz	a3, 628 <SMART_PITCH_PLC_PROCESS+0x24c>
     5d5:	e0c562        	addi	a6, a5, -32
     5d8:	410524        	ae_lp16f.x	aep0, a5, a2
     5db:	401604        	ae_lp16f.i	aep1, a6, 0
     5de:	ea078025ee 	{ addi	a14, a5, 2; ae_mulp24s.ll	aeq0, aep1, aep0 }
     5e3:	330b           	addi.n	a3, a3, -1
     5e5:	368804        	ae_trunca32q48	a8, aeq0
     5e8:	0489           	s32i.n	a8, a4, 0
     5ea:	406614        	ae_lp16f.i	aep6, a6, 2
     5ed:	417e24        	ae_lp16f.x	aep7, a14, a2
     5f0:	eafb802e5e 	{ addi	a5, a14, 2; ae_mulp24s.ll	aeq0, aep6, aep7 }
     5f5:	249376        	loopnez	a3, 61d <SMART_PITCH_PLC_PROCESS+0x241>
     5f8:	e0c532        	addi	a3, a5, -32
     5fb:	368604        	ae_trunca32q48	a6, aeq0
     5fe:	1469           	s32i.n	a6, a4, 4
     600:	400304        	ae_lp16f.i	aep0, a3, 0
     603:	411524        	ae_lp16f.x	aep1, a5, a2
     606:	ea2380844e 	{ addi	a4, a4, 8; ae_mulp24s.ll	aeq0, aep0, aep1 }
     60b:	652b           	addi.n	a6, a5, 2
     60d:	368504        	ae_trunca32q48	a5, aeq0
     610:	0459           	s32i.n	a5, a4, 0
     612:	410624        	ae_lp16f.x	aep0, a6, a2
     615:	401314        	ae_lp16f.i	aep1, a3, 2
     618:	ea0780265e 	{ addi	a5, a6, 2; ae_mulp24s.ll	aeq0, aep1, aep0 }

0000061d <SMART_PITCH_PLC_PROCESS+0x241>:
     61d:	5188           	l32i.n	a8, a1, 20
     61f:	368604        	ae_trunca32q48	a6, aeq0
     622:	016462        	s32i	a6, a4, 4
     625:	08c4e2        	addi	a14, a4, 8

00000628 <SMART_PITCH_PLC_PROCESS+0x24c>:
     628:	1d2f22        	l32i	a2, a15, 116
     62b:	71e8           	l32i.n	a14, a1, 28
     62d:	81a8           	l32i.n	a10, a1, 32
     62f:	021226        	beqi	a2, 1, 635 <SMART_PITCH_PLC_PROCESS+0x259>
     632:	011146        	j	a7b <SMART_PITCH_PLC_PROCESS+0x69f>
     635:	71e8           	l32i.n	a14, a1, 28
     637:	81a8           	l32i.n	a10, a1, 32
     639:	2b17a6        	blti	a7, 1, 668 <SMART_PITCH_PLC_PROCESS+0x28c>
     63c:	30a232        	movi	a3, 0x230
     63f:	3f3a           	add.n	a3, a15, a3
     641:	234d           	ae_l16si.n	a4, a3, 0
     643:	1c2f22        	l32i	a2, a15, 112
     646:	ffc7d2        	addi	a13, a7, -1
     649:	02c332        	addi	a3, a3, 2
     64c:	824240        	mull	a4, a2, a4
     64f:	415f40        	srli	a5, a4, 15
     652:	204bb0        	or	a4, a11, a11
     655:	6b5d           	ae_s16i.n	a5, a11, 0
     657:	0d9d76        	loopnez	a13, 668 <SMART_PITCH_PLC_PROCESS+0x28c>
     65a:	235d           	ae_l16si.n	a5, a3, 0
     65c:	442b           	addi.n	a4, a4, 2
     65e:	825250        	mull	a5, a2, a5
     661:	332b           	addi.n	a3, a3, 2
     663:	415f50        	srli	a5, a5, 15
     666:	645d           	ae_s16i.n	a5, a4, 0
     668:	0218e6        	bgei	a8, 1, 66e <SMART_PITCH_PLC_PROCESS+0x292>
     66b:	011946        	j	ad4 <SMART_PITCH_PLC_PROCESS+0x6f8>
     66e:	70a152        	movi	a5, 0x170
     671:	70cf22        	addi	a2, a15, 112
     674:	9047b0        	addx2	a4, a7, a11
     677:	10c132        	addi	a3, a1, 16
     67a:	416180        	srli	a6, a8, 1
     67d:	5f5a           	add.n	a5, a15, a5
     67f:	206807        	bbci	a8, 0, 6a3 <SMART_PITCH_PLC_PROCESS+0x2c7>
     682:	0578           	l32i.n	a7, a5, 0
     684:	401204        	ae_lp16f.i	aep1, a2, 0
     687:	102582        	l32i	a8, a5, 64
     68a:	217f70        	srai	a7, a7, 15
     68d:	4179           	s32i.n	a7, a1, 16
     68f:	400304        	ae_lp16f.i	aep0, a3, 0
     692:	ea2380455e 	{ addi	a5, a5, 4; ae_mulp24s.ll	aeq0, aep0, aep1 }
     697:	368d04        	ae_trunca32q48	a13, aeq0
     69a:	7d8a           	add.n	a7, a13, a8
     69c:	417f70        	srli	a7, a7, 15
     69f:	647d           	ae_s16i.n	a7, a4, 0
     6a1:	442b           	addi.n	a4, a4, 2
     6a3:	42d616        	beqz	a6, ad4 <SMART_PITCH_PLC_PROCESS+0x6f8>
     6a6:	0588           	l32i.n	a8, a5, 0
     6a8:	400204        	ae_lp16f.i	aep0, a2, 0
     6ab:	1578           	l32i.n	a7, a5, 4
     6ad:	218f80        	srai	a8, a8, 15
     6b0:	4189           	s32i.n	a8, a1, 16
     6b2:	401304        	ae_lp16f.i	aep1, a3, 0
     6b5:	ea07b105de 	{ l32i	a13, a5, 64; ae_mulp24s.ll	aeq0, aep1, aep0 }
     6ba:	217f70        	srai	a7, a7, 15
     6bd:	368904        	ae_trunca32q48	a9, aeq0
     6c0:	4179           	s32i.n	a7, a1, 16
     6c2:	406304        	ae_lp16f.i	aep6, a3, 0
     6c5:	c9da           	add.n	a12, a9, a13
     6c7:	417fc0        	srli	a7, a12, 15
     6ca:	1125d2        	l32i	a13, a5, 68
     6cd:	647d           	ae_s16i.n	a7, a4, 0
     6cf:	407204        	ae_lp16f.i	aep7, a2, 0
     6d2:	eafb8ff66e 	{ addi	a6, a6, -1; ae_mulp24s.ll	aeq0, aep6, aep7 }
     6d7:	558b           	addi.n	a5, a5, 8
     6d9:	0d7d           	mov.n	a7, a13
     6db:	3d9676        	loopnez	a6, 71c <SMART_PITCH_PLC_PROCESS+0x340>
     6de:	0568           	l32i.n	a6, a5, 0
     6e0:	1598           	l32i.n	a9, a5, 4
     6e2:	368804        	ae_trunca32q48	a8, aeq0
     6e5:	216f60        	srai	a6, a6, 15
     6e8:	4169           	s32i.n	a6, a1, 16
     6ea:	687a           	add.n	a6, a8, a7
     6ec:	416f60        	srli	a6, a6, 15
     6ef:	746d           	ae_s16i.n	a6, a4, 2
     6f1:	401204        	ae_lp16f.i	aep1, a2, 0
     6f4:	400304        	ae_lp16f.i	aep0, a3, 0
     6f7:	ea2380444e 	{ addi	a4, a4, 4; ae_mulp24s.ll	aeq0, aep0, aep1 }
     6fc:	216f90        	srai	a6, a9, 15
     6ff:	368804        	ae_trunca32q48	a8, aeq0
     702:	102592        	l32i	a9, a5, 64
     705:	112572        	l32i	a7, a5, 68
     708:	4169           	s32i.n	a6, a1, 16
     70a:	689a           	add.n	a6, a8, a9
     70c:	416f60        	srli	a6, a6, 15
     70f:	401304        	ae_lp16f.i	aep1, a3, 0
     712:	646d           	ae_s16i.n	a6, a4, 0
     714:	400204        	ae_lp16f.i	aep0, a2, 0
     717:	ea0780855e 	{ addi	a5, a5, 8; ae_mulp24s.ll	aeq0, aep1, aep0 }

0000071c <SMART_PITCH_PLC_PROCESS+0x340>:
     71c:	368c04        	ae_trunca32q48	a12, aeq0
     71f:	d44b           	addi.n	a13, a4, 4
     721:	7c7a           	add.n	a7, a12, a7
     723:	417f70        	srli	a7, a7, 15
     726:	747d           	ae_s16i.n	a7, a4, 2
     728:	00ea06        	j	ad4 <SMART_PITCH_PLC_PROCESS+0x6f8>

0000072b <SMART_PITCH_PLC_PROCESS+0x34f>:
     72b:	1d2f22        	l32i	a2, a15, 116
     72e:	0e5d           	mov.n	a5, a14
     730:	ef48           	l32i.n	a4, a15, 56
     732:	021226        	beqi	a2, 1, 738 <SMART_PITCH_PLC_PROCESS+0x35c>
     735:	241466        	bnei	a4, 1, 75d <SMART_PITCH_PLC_PROCESS+0x381>
     738:	112f22        	l32i	a2, a15, 68
     73b:	30a242        	movi	a4, 0x230
     73e:	af4a           	add.n	a10, a15, a4
     740:	19a237        	bge	a2, a3, 75d <SMART_PITCH_PLC_PROCESS+0x381>
     743:	162fb2        	l32i	a11, a15, 88
     746:	172fc2        	l32i	a12, a15, 92
     749:	fe3c31        	l32r	a3, 3c (1a68 <getfespeech>)
     74c:	51d8           	l32i.n	a13, a1, 20
     74e:	122f22        	l32i	a2, a15, 72
     751:	0aed           	mov.n	a14, a10
     753:	0f4d           	mov.n	a4, a15
     755:	0003e0        	callx8	a3
     758:	04fd           	mov.n	a15, a4
     75a:	126422        	s32i	a2, a4, 72
     75d:	30a222        	movi	a2, 0x230
     760:	e0a632        	movi	a3, 0x6e0
     763:	af2a           	add.n	a10, a15, a2
     765:	162fb2        	l32i	a11, a15, 88
     768:	172fc2        	l32i	a12, a15, 92
     76b:	fe3421        	l32r	a2, 3c (1a68 <getfespeech>)
     76e:	ef3a           	add.n	a14, a15, a3
     770:	05dd           	mov.n	a13, a5
     772:	203ff0        	or	a3, a15, a15
     775:	0002e0        	callx8	a2
     778:	1d2322        	l32i	a2, a3, 116
     77b:	03dd           	mov.n	a13, a3
     77d:	ed38           	l32i.n	a3, a13, 56
     77f:	051226        	beqi	a2, 1, 788 <SMART_PITCH_PLC_PROCESS+0x3ac>
     782:	021326        	beqi	a3, 1, 788 <SMART_PITCH_PLC_PROCESS+0x3ac>
     785:	00edc6        	j	b40 <SMART_PITCH_PLC_PROCESS+0x764>
     788:	192d22        	l32i	a2, a13, 100
     78b:	112d32        	l32i	a3, a13, 68
     78e:	ed48           	l32i.n	a4, a13, 56
     790:	ffa0e2        	movi	a14, 255
     793:	022327        	blt	a3, a2, 799 <SMART_PITCH_PLC_PROCESS+0x3bd>
     796:	00e986        	j	b40 <SMART_PITCH_PLC_PROCESS+0x764>
     799:	021426        	beqi	a4, 1, 79f <SMART_PITCH_PLC_PROCESS+0x3c3>
     79c:	01dc06        	j	f10 <SMART_PITCH_PLC_PROCESS+0xb34>
     79f:	fd28           	l32i.n	a2, a13, 60
     7a1:	1c2d32        	l32i	a3, a13, 112
     7a4:	822320        	mull	a2, a3, a2
     7a7:	21ef20        	srai	a14, a2, 15
     7aa:	01d946        	j	f13 <SMART_PITCH_PLC_PROCESS+0xb37>

000007ad <SMART_PITCH_PLC_PROCESS+0x3d1>:
     7ad:	3f78           	l32i.n	a7, a15, 12
     7af:	6fd8           	l32i.n	a13, a15, 24
     7b1:	bfc8           	l32i.n	a12, a15, 44
     7b3:	c04670        	sub	a4, a6, a7
     7b6:	1197f0        	slli	a9, a7, 1
     7b9:	1314a6        	blti	a4, 1, 7d0 <SMART_PITCH_PLC_PROCESS+0x3f4>
     7bc:	e0a622        	movi	a2, 0x6e0
     7bf:	3f2a           	add.n	a3, a15, a2
     7c1:	092d           	mov.n	a2, a9
     7c3:	078476        	loop	a4, 7ce <SMART_PITCH_PLC_PROCESS+0x3f2>
     7c6:	432a           	add.n	a4, a3, a2
     7c8:	244d           	ae_l16si.n	a4, a4, 0
     7ca:	634d           	ae_s16i.n	a4, a3, 0
     7cc:	332b           	addi.n	a3, a3, 2

000007ce <SMART_PITCH_PLC_PROCESS+0x3f2>:
     7ce:	029d           	mov.n	a9, a2

000007d0 <SMART_PITCH_PLC_PROCESS+0x3f4>:
     7d0:	2a17a6        	blti	a7, 1, 7fe <SMART_PITCH_PLC_PROCESS+0x422>
     7d3:	d02690        	subx2	a2, a6, a9
     7d6:	e0a632        	movi	a3, 0x6e0
     7d9:	22fa           	add.n	a2, a2, a15
     7db:	223a           	add.n	a2, a2, a3
     7dd:	0b3d           	mov.n	a3, a11
     7df:	414170        	srli	a4, a7, 1
     7e2:	076707        	bbci	a7, 0, 7ed <SMART_PITCH_PLC_PROCESS+0x411>
     7e5:	235d           	ae_l16si.n	a5, a3, 0
     7e7:	625d           	ae_s16i.n	a5, a2, 0
     7e9:	332b           	addi.n	a3, a3, 2
     7eb:	222b           	addi.n	a2, a2, 2
     7ed:	d48c           	beqz.n	a4, 7fe <SMART_PITCH_PLC_PROCESS+0x422>
     7ef:	0b9476        	loopnez	a4, 7fe <SMART_PITCH_PLC_PROCESS+0x422>
     7f2:	234d           	ae_l16si.n	a4, a3, 0
     7f4:	624d           	ae_s16i.n	a4, a2, 0
     7f6:	334d           	ae_l16si.n	a4, a3, 2
     7f8:	724d           	ae_s16i.n	a4, a2, 2
     7fa:	334b           	addi.n	a3, a3, 4
     7fc:	224b           	addi.n	a2, a2, 4

000007fe <SMART_PITCH_PLC_PROCESS+0x422>:
     7fe:	30a222        	movi	a2, 0x230
     801:	af2a           	add.n	a10, a15, a2
     803:	71e9           	s32i.n	a14, a1, 28
     805:	1526a6        	blti	a6, 2, 81e <SMART_PITCH_PLC_PROCESS+0x442>
     808:	2ca222        	movi	a2, 0x22c
     80b:	214160        	srai	a4, a6, 1
     80e:	dca652        	movi	a5, 0x6dc
     811:	3f2a           	add.n	a3, a15, a2
     813:	2f5a           	add.n	a2, a15, a5
     815:	058476        	loop	a4, 81e <SMART_PITCH_PLC_PROCESS+0x442>
     818:	448214        	ae_lp16x2f.iu	aep0, a2, 4
     81b:	468314        	ae_sp16x2f.iu	aep0, a3, 4

0000081e <SMART_PITCH_PLC_PROCESS+0x442>:
     81e:	61f9           	s32i.n	a15, a1, 24
     820:	6128           	l32i.n	a2, a1, 24
     822:	cfb8           	l32i.n	a11, a15, 48
     824:	7fe8           	l32i.n	a14, a15, 28
     826:	1822f2        	l32i	a15, a2, 96
     829:	fe0221        	l32r	a2, 34 (1258 <find_pitch>)
     82c:	a179           	s32i.n	a7, a1, 40
     82e:	8199           	s32i.n	a9, a1, 32
     830:	b1a9           	s32i.n	a10, a1, 44
     832:	0002e0        	callx8	a2
     835:	6128           	l32i.n	a2, a1, 24
     837:	71c8           	l32i.n	a12, a1, 28
     839:	6148           	l32i.n	a4, a1, 24
     83b:	9228           	l32i.n	a2, a2, 36
     83d:	2131c0        	srai	a3, a12, 1
     840:	0a7d           	mov.n	a7, a10
     842:	8222a0        	mull	a2, a2, a10
     845:	2264a2        	s32i	a10, a4, 136
     848:	a23a           	add.n	a10, a2, a3
     84a:	fdfb21        	l32r	a2, 38 (1aa4 <__divdi3>)
     84d:	31dfc0        	srai	a13, a12, 31
     850:	31bfa0        	srai	a11, a10, 31
     853:	0002e0        	callx8	a2
     856:	220c           	movi.n	a2, 2
     858:	6198           	l32i.n	a9, a1, 24
     85a:	5188           	l32i.n	a8, a1, 20
     85c:	130c           	movi.n	a3, 1
     85e:	725a20        	salt	a5, a10, a2
     861:	114af0        	slli	a4, a10, 1
     864:	833a50        	moveqz	a3, a10, a5
     867:	934250        	movnez	a4, a2, a5
     86a:	116932        	s32i	a3, a9, 68
     86d:	156942        	s32i	a4, a9, 84
     870:	3018a6        	blti	a8, 1, 8a4 <SMART_PITCH_PLC_PROCESS+0x4c8>
     873:	1128f0        	slli	a2, a8, 1
     876:	d02620        	subx2	a2, a6, a2
     879:	30a232        	movi	a3, 0x230
     87c:	229a           	add.n	a2, a2, a9
     87e:	68a652        	movi	a5, 0x668
     881:	323a           	add.n	a3, a2, a3
     883:	414180        	srli	a4, a8, 1
     886:	295a           	add.n	a2, a9, a5
     888:	076807        	bbci	a8, 0, 893 <SMART_PITCH_PLC_PROCESS+0x4b7>
     88b:	235d           	ae_l16si.n	a5, a3, 0
     88d:	625d           	ae_s16i.n	a5, a2, 0
     88f:	332b           	addi.n	a3, a3, 2
     891:	222b           	addi.n	a2, a2, 2
     893:	d48c           	beqz.n	a4, 8a4 <SMART_PITCH_PLC_PROCESS+0x4c8>
     895:	0b9476        	loopnez	a4, 8a4 <SMART_PITCH_PLC_PROCESS+0x4c8>
     898:	234d           	ae_l16si.n	a4, a3, 0
     89a:	624d           	ae_s16i.n	a4, a2, 0
     89c:	334d           	ae_l16si.n	a4, a3, 2
     89e:	724d           	ae_s16i.n	a4, a2, 2
     8a0:	334b           	addi.n	a3, a3, 4
     8a2:	224b           	addi.n	a2, a2, 4

000008a4 <SMART_PITCH_PLC_PROCESS+0x4c8>:
     8a4:	182932        	l32i	a3, a9, 96
     8a7:	07bd           	mov.n	a11, a7
     8a9:	166972        	s32i	a7, a9, 88
     8ac:	c0c370        	sub	a12, a3, a7
     8af:	71a8           	l32i.n	a10, a1, 28
     8b1:	91e8           	l32i.n	a14, a1, 36
     8b3:	a178           	l32i.n	a7, a1, 40
     8b5:	020c           	movi.n	a2, 0
     8b7:	06dd           	mov.n	a13, a6
     8b9:	126922        	s32i	a2, a9, 72
     8bc:	1769c2        	s32i	a12, a9, 92
     8bf:	6928a6        	blti	a8, 2, 92c <SMART_PITCH_PLC_PROCESS+0x550>
     8c2:	581b           	addi.n	a5, a8, 1
     8c4:	b35880        	movgez	a5, a8, a8
     8c7:	21f150        	srai	a15, a5, 1
     8ca:	64a632        	movi	a3, 0x664
     8cd:	0ca262        	movi	a6, 0x20c
     8d0:	493a           	add.n	a4, a9, a3
     8d2:	30c122        	addi	a2, a1, 48
     8d5:	396a           	add.n	a3, a9, a6
     8d7:	4151f0        	srli	a5, a15, 1
     8da:	1b6f07        	bbci	a15, 0, 8f9 <SMART_PITCH_PLC_PROCESS+0x51d>
     8dd:	448314        	ae_lp16x2f.iu	aep0, a3, 4
     8e0:	449414        	ae_lp16x2f.iu	aep1, a4, 4
     8e3:	020144        	ae_mulp24s.hh	aeq0, aep0, aep1
     8e6:	020974        	ae_mulp24s.ll	aeq1, aep0, aep1
     8e9:	368604        	ae_trunca32q48	a6, aeq0
     8ec:	369804        	ae_trunca32q48	a8, aeq1
     8ef:	006262        	s32i	a6, a2, 0
     8f2:	1289           	s32i.n	a8, a2, 4
     8f4:	052182        	l32i	a8, a1, 20
     8f7:	228b           	addi.n	a2, a2, 8

000008f9 <SMART_PITCH_PLC_PROCESS+0x51d>:
     8f9:	f5ac           	beqz.n	a5, 92c <SMART_PITCH_PLC_PROCESS+0x550>
     8fb:	f03d           	nop.n
     8fd:	2b9576        	loopnez	a5, 92c <SMART_PITCH_PLC_PROCESS+0x550>
     900:	44a314        	ae_lp16x2f.iu	aep2, a3, 4
     903:	449414        	ae_lp16x2f.iu	aep1, a4, 4
     906:	ea2bed841f 	{ ae_lp16x2f.iu	aep0, a4, 4; ae_mulp24s.ll	aeq1, aep2, aep1 }
     90b:	e82aad931f 	{ ae_lp16x2f.iu	aep1, a3, 4; ae_mulp24s.hh	aeq0, aep2, aep1 }
     910:	ea07ff15ef 	{ ae_trunca32q48	a5, aeq1; ae_mulp24s.ll	aeq1, aep1, aep0 }
     915:	e90694125f 	{ s32i.n	a5, a2, 4; ae_mulp24s.hh	aeq2, aep1, aep0 }
     91a:	368504        	ae_trunca32q48	a5, aeq0
     91d:	0259           	s32i.n	a5, a2, 0
     91f:	369504        	ae_trunca32q48	a5, aeq1
     922:	3259           	s32i.n	a5, a2, 12
     924:	36a504        	ae_trunca32q48	a5, aeq2
     927:	2259           	s32i.n	a5, a2, 8
     929:	10c222        	addi	a2, a2, 16

0000092c <SMART_PITCH_PLC_PROCESS+0x550>:
     92c:	0218e6        	bgei	a8, 1, 932 <SMART_PITCH_PLC_PROCESS+0x556>
     92f:	002346        	j	9c0 <SMART_PITCH_PLC_PROCESS+0x5e4>
     932:	c02c80        	sub	a2, a12, a8
     935:	f0a142        	movi	a4, 0x1f0
     938:	30a232        	movi	a3, 0x230
     93b:	902290        	addx2	a2, a2, a9
     93e:	30c152        	addi	a5, a1, 48
     941:	223a           	add.n	a2, a2, a3
     943:	f94a           	add.n	a15, a9, a4
     945:	fecf32        	addi	a3, a15, -2
     948:	fcc552        	addi	a5, a5, -4
     94b:	fec242        	addi	a4, a2, -2
     94e:	680b           	addi.n	a6, a8, -1
     950:	408314        	ae_lp16f.iu	aep0, a3, 2
     953:	601514        	ae_lq32f.iu	aeq0, a5, 4
     956:	409414        	ae_lp16f.iu	aep1, a4, 2
     959:	f03d           	nop.n
     95b:	f03d           	nop.n
     95d:	0f9676        	loopnez	a6, 970 <SMART_PITCH_PLC_PROCESS+0x594>
     960:	e6232c831f 	{ ae_lp16f.iu	aep0, a3, 2; ae_mulap24s.ll	aeq0, aep0, aep1 }
     965:	409414        	ae_lp16f.iu	aep1, a4, 2
     968:	368204        	ae_trunca32q48	a2, aeq0
     96b:	0529           	s32i.n	a2, a5, 0
     96d:	601514        	ae_lq32f.iu	aeq0, a5, 4

00000970 <SMART_PITCH_PLC_PROCESS+0x594>:
     970:	e62306e03f 	{ movi	a3, 0x6e0; ae_mulap24s.ll	aeq0, aep0, aep1 }
     975:	1168f0        	slli	a6, a8, 1
     978:	368204        	ae_trunca32q48	a2, aeq0
     97b:	0529           	s32i.n	a2, a5, 0
     97d:	d02d60        	subx2	a2, a13, a6
     980:	229a           	add.n	a2, a2, a9
     982:	30a2f2        	movi	a15, 0x230
     985:	623a           	add.n	a6, a2, a3
     987:	30c142        	addi	a4, a1, 48
     98a:	22fa           	add.n	a2, a2, a15
     98c:	415180        	srli	a5, a8, 1
     98f:	0e6807        	bbci	a8, 0, 9a1 <SMART_PITCH_PLC_PROCESS+0x5c5>
     992:	0438           	l32i.n	a3, a4, 0
     994:	444b           	addi.n	a4, a4, 4
     996:	413f30        	srli	a3, a3, 15
     999:	623d           	ae_s16i.n	a3, a2, 0
     99b:	663d           	ae_s16i.n	a3, a6, 0
     99d:	222b           	addi.n	a2, a2, 2
     99f:	662b           	addi.n	a6, a6, 2

000009a1 <SMART_PITCH_PLC_PROCESS+0x5c5>:
     9a1:	b59c           	beqz.n	a5, 9c0 <SMART_PITCH_PLC_PROCESS+0x5e4>
     9a3:	063d           	mov.n	a3, a6
     9a5:	179576        	loopnez	a5, 9c0 <SMART_PITCH_PLC_PROCESS+0x5e4>
     9a8:	0458           	l32i.n	a5, a4, 0
     9aa:	1468           	l32i.n	a6, a4, 4
     9ac:	448b           	addi.n	a4, a4, 8
     9ae:	415f50        	srli	a5, a5, 15
     9b1:	416f60        	srli	a6, a6, 15
     9b4:	625d           	ae_s16i.n	a5, a2, 0
     9b6:	635d           	ae_s16i.n	a5, a3, 0
     9b8:	726d           	ae_s16i.n	a6, a2, 2
     9ba:	224b           	addi.n	a2, a2, 4
     9bc:	736d           	ae_s16i.n	a6, a3, 2
     9be:	334b           	addi.n	a3, a3, 4
     9c0:	2d17a6        	blti	a7, 1, 9f1 <SMART_PITCH_PLC_PROCESS+0x615>
     9c3:	8128           	l32i.n	a2, a1, 32
     9c5:	e0a632        	movi	a3, 0x6e0
     9c8:	414170        	srli	a4, a7, 1
     9cb:	d02d20        	subx2	a2, a13, a2
     9ce:	229a           	add.n	a2, a2, a9
     9d0:	223a           	add.n	a2, a2, a3
     9d2:	0e3d           	mov.n	a3, a14
     9d4:	086707        	bbci	a7, 0, 9e0 <SMART_PITCH_PLC_PROCESS+0x604>
     9d7:	225d           	ae_l16si.n	a5, a2, 0
     9d9:	635d           	ae_s16i.n	a5, a3, 0
     9db:	222b           	addi.n	a2, a2, 2
     9dd:	02c332        	addi	a3, a3, 2
     9e0:	d48c           	beqz.n	a4, 9f1 <SMART_PITCH_PLC_PROCESS+0x615>
     9e2:	0b9476        	loopnez	a4, 9f1 <SMART_PITCH_PLC_PROCESS+0x615>
     9e5:	224d           	ae_l16si.n	a4, a2, 0
     9e7:	634d           	ae_s16i.n	a4, a3, 0
     9e9:	324d           	ae_l16si.n	a4, a2, 2
     9eb:	734d           	ae_s16i.n	a4, a3, 2
     9ed:	334b           	addi.n	a3, a3, 4
     9ef:	224b           	addi.n	a2, a2, 4

000009f1 <SMART_PITCH_PLC_PROCESS+0x615>:
     9f1:	c05a70        	sub	a5, a10, a7
     9f4:	c02d50        	sub	a2, a13, a5
     9f7:	67da           	add.n	a6, a7, a13
     9f9:	1712a6        	blti	a2, 1, a14 <SMART_PITCH_PLC_PROCESS+0x638>
     9fc:	8128           	l32i.n	a2, a1, 32
     9fe:	e0a632        	movi	a3, 0x6e0
     a01:	c046a0        	sub	a4, a6, a10
     a04:	d02a20        	subx2	a2, a10, a2
     a07:	393a           	add.n	a3, a9, a3
     a09:	078476        	loop	a4, a14 <SMART_PITCH_PLC_PROCESS+0x638>
     a0c:	432a           	add.n	a4, a3, a2
     a0e:	244d           	ae_l16si.n	a4, a4, 0
     a10:	634d           	ae_s16i.n	a4, a3, 0
     a12:	332b           	addi.n	a3, a3, 2

00000a14 <SMART_PITCH_PLC_PROCESS+0x638>:
     a14:	6da122        	movi	a2, 0x16d
     a17:	1122d0        	slli	a2, a2, 3
     a1a:	492a           	add.n	a4, a9, a2
     a1c:	fd8821        	l32r	a2, 3c (1a68 <getfespeech>)
     a1f:	b1a8           	l32i.n	a10, a1, 44
     a21:	61f8           	l32i.n	a15, a1, 24
     a23:	05dd           	mov.n	a13, a5
     a25:	04ed           	mov.n	a14, a4
     a27:	0002e0        	callx8	a2
     a2a:	71c8           	l32i.n	a12, a1, 28
     a2c:	61d8           	l32i.n	a13, a1, 24
     a2e:	91b8           	l32i.n	a11, a1, 36
     a30:	0215e6        	bgei	a5, 1, a36 <SMART_PITCH_PLC_PROCESS+0x65a>
     a33:	01c406        	j	1147 <SMART_PITCH_PLC_PROCESS+0xd6b>
     a36:	c026c0        	sub	a2, a6, a12
     a39:	e0a6f2        	movi	a15, 0x6e0
     a3c:	9022d0        	addx2	a2, a2, a13
     a3f:	9037b0        	addx2	a3, a7, a11
     a42:	22fa           	add.n	a2, a2, a15
     a44:	416150        	srli	a6, a5, 1
     a47:	0d6507        	bbci	a5, 0, a58 <SMART_PITCH_PLC_PROCESS+0x67c>
     a4a:	245d           	ae_l16si.n	a5, a4, 0
     a4c:	635d           	ae_s16i.n	a5, a3, 0
     a4e:	245d           	ae_l16si.n	a5, a4, 0
     a50:	625d           	ae_s16i.n	a5, a2, 0
     a52:	332b           	addi.n	a3, a3, 2
     a54:	442b           	addi.n	a4, a4, 2
     a56:	222b           	addi.n	a2, a2, 2
     a58:	6eb616        	beqz	a6, 1147 <SMART_PITCH_PLC_PROCESS+0xd6b>
     a5b:	04ed           	mov.n	a14, a4
     a5d:	159676        	loopnez	a6, a76 <SMART_PITCH_PLC_PROCESS+0x69a>
     a60:	2e4d           	ae_l16si.n	a4, a14, 0
     a62:	634d           	ae_s16i.n	a4, a3, 0
     a64:	2e4d           	ae_l16si.n	a4, a14, 0
     a66:	624d           	ae_s16i.n	a4, a2, 0
     a68:	3e4d           	ae_l16si.n	a4, a14, 2
     a6a:	734d           	ae_s16i.n	a4, a3, 2
     a6c:	334b           	addi.n	a3, a3, 4
     a6e:	3e4d           	ae_l16si.n	a4, a14, 2
     a70:	ee4b           	addi.n	a14, a14, 4
     a72:	724d           	ae_s16i.n	a4, a2, 2
     a74:	224b           	addi.n	a2, a2, 4

00000a76 <SMART_PITCH_PLC_PROCESS+0x69a>:
     a76:	71c8           	l32i.n	a12, a1, 28
     a78:	01b2c6        	j	1147 <SMART_PITCH_PLC_PROCESS+0xd6b>

00000a7b <SMART_PITCH_PLC_PROCESS+0x69f>:
     a7b:	1327a6        	blti	a7, 2, a92 <SMART_PITCH_PLC_PROCESS+0x6b6>
     a7e:	2ca222        	movi	a2, 0x22c
     a81:	214170        	srai	a4, a7, 1
     a84:	fccb32        	addi	a3, a11, -4
     a87:	2f2a           	add.n	a2, a15, a2
     a89:	058476        	loop	a4, a92 <SMART_PITCH_PLC_PROCESS+0x6b6>
     a8c:	448214        	ae_lp16x2f.iu	aep0, a2, 4
     a8f:	468314        	ae_sp16x2f.iu	aep0, a3, 4
     a92:	3e18a6        	blti	a8, 1, ad4 <SMART_PITCH_PLC_PROCESS+0x6f8>
     a95:	70a132        	movi	a3, 0x170
     a98:	9027b0        	addx2	a2, a7, a11
     a9b:	414180        	srli	a4, a8, 1
     a9e:	3f3a           	add.n	a3, a15, a3
     aa0:	0f6807        	bbci	a8, 0, ab3 <SMART_PITCH_PLC_PROCESS+0x6d7>
     aa3:	102352        	l32i	a5, a3, 64
     aa6:	0368           	l32i.n	a6, a3, 0
     aa8:	334b           	addi.n	a3, a3, 4
     aaa:	565a           	add.n	a5, a6, a5
     aac:	415f50        	srli	a5, a5, 15
     aaf:	625d           	ae_s16i.n	a5, a2, 0
     ab1:	222b           	addi.n	a2, a2, 2
     ab3:	d49c           	beqz.n	a4, ad4 <SMART_PITCH_PLC_PROCESS+0x6f8>
     ab5:	1b9476        	loopnez	a4, ad4 <SMART_PITCH_PLC_PROCESS+0x6f8>
     ab8:	102352        	l32i	a5, a3, 64
     abb:	0348           	l32i.n	a4, a3, 0
     abd:	1368           	l32i.n	a6, a3, 4
     abf:	112372        	l32i	a7, a3, 68
     ac2:	445a           	add.n	a4, a4, a5
     ac4:	338b           	addi.n	a3, a3, 8
     ac6:	414f40        	srli	a4, a4, 15
     ac9:	624d           	ae_s16i.n	a4, a2, 0
     acb:	467a           	add.n	a4, a6, a7
     acd:	414f40        	srli	a4, a4, 15
     ad0:	724d           	ae_s16i.n	a4, a2, 2
     ad2:	224b           	addi.n	a2, a2, 4

00000ad4 <SMART_PITCH_PLC_PROCESS+0x6f8>:
     ad4:	6158           	l32i.n	a5, a1, 24
     ad6:	112ef0        	slli	a2, a14, 1
     ad9:	e0a632        	movi	a3, 0x6e0
     adc:	c045e0        	sub	a4, a5, a14
     adf:	0d14a6        	blti	a4, 1, af0 <SMART_PITCH_PLC_PROCESS+0x714>
     ae2:	803f30        	add	a3, a15, a3
     ae5:	078476        	loop	a4, af0 <SMART_PITCH_PLC_PROCESS+0x714>
     ae8:	432a           	add.n	a4, a3, a2
     aea:	244d           	ae_l16si.n	a4, a4, 0
     aec:	634d           	ae_s16i.n	a4, a3, 0
     aee:	332b           	addi.n	a3, a3, 2

00000af0 <SMART_PITCH_PLC_PROCESS+0x714>:
     af0:	2a1ea6        	blti	a14, 1, b1e <SMART_PITCH_PLC_PROCESS+0x742>
     af3:	d02520        	subx2	a2, a5, a2
     af6:	e0a632        	movi	a3, 0x6e0
     af9:	22fa           	add.n	a2, a2, a15
     afb:	223a           	add.n	a2, a2, a3
     afd:	0b3d           	mov.n	a3, a11
     aff:	4141e0        	srli	a4, a14, 1
     b02:	076e07        	bbci	a14, 0, b0d <SMART_PITCH_PLC_PROCESS+0x731>
     b05:	235d           	ae_l16si.n	a5, a3, 0
     b07:	625d           	ae_s16i.n	a5, a2, 0
     b09:	332b           	addi.n	a3, a3, 2
     b0b:	222b           	addi.n	a2, a2, 2
     b0d:	d48c           	beqz.n	a4, b1e <SMART_PITCH_PLC_PROCESS+0x742>
     b0f:	0b9476        	loopnez	a4, b1e <SMART_PITCH_PLC_PROCESS+0x742>
     b12:	234d           	ae_l16si.n	a4, a3, 0
     b14:	624d           	ae_s16i.n	a4, a2, 0
     b16:	334d           	ae_l16si.n	a4, a3, 2
     b18:	724d           	ae_s16i.n	a4, a2, 2
     b1a:	334b           	addi.n	a3, a3, 4
     b1c:	224b           	addi.n	a2, a2, 4

00000b1e <SMART_PITCH_PLC_PROCESS+0x742>:
     b1e:	020c           	movi.n	a2, 0
     b20:	ffa032        	movi	a3, 255
     b23:	196f22        	s32i	a2, a15, 100
     b26:	1d6f22        	s32i	a2, a15, 116
     b29:	fd4521        	l32r	a2, 40 (1750 <plc_gainctrl>)
     b2c:	7fd332        	addmi	a3, a3, 0x7f00
     b2f:	0ecd           	mov.n	a12, a14
     b31:	0fdd           	mov.n	a13, a15
     b33:	1c6f32        	s32i	a3, a15, 112
     b36:	1b6f32        	s32i	a3, a15, 108
     b39:	0002e0        	callx8	a2
     b3c:	f01d           	retw.n

00000b3e <SMART_PITCH_PLC_PROCESS+0x762>:
	...

00000b40 <SMART_PITCH_PLC_PROCESS+0x764>:
     b40:	ffa022        	movi	a2, 255
     b43:	91b8           	l32i.n	a11, a1, 36
     b45:	7fd222        	addmi	a2, a2, 0x7f00
     b48:	05cd           	mov.n	a12, a5
     b4a:	1b6d22        	s32i	a2, a13, 108
     b4d:	0225e6        	bgei	a5, 2, b53 <SMART_PITCH_PLC_PROCESS+0x777>
     b50:	016886        	j	10f6 <SMART_PITCH_PLC_PROCESS+0xd1a>
     b53:	dca622        	movi	a2, 0x6dc
     b56:	2141c0        	srai	a4, a12, 1
     b59:	fccb32        	addi	a3, a11, -4
     b5c:	2d2a           	add.n	a2, a13, a2
     b5e:	058476        	loop	a4, b67 <SMART_PITCH_PLC_PROCESS+0x78b>
     b61:	448214        	ae_lp16x2f.iu	aep0, a2, 4
     b64:	468314        	ae_sp16x2f.iu	aep0, a3, 4

00000b67 <SMART_PITCH_PLC_PROCESS+0x78b>:
     b67:	0162c6        	j	10f6 <SMART_PITCH_PLC_PROCESS+0xd1a>

00000b6a <SMART_PITCH_PLC_PROCESS+0x78e>:
	...

00000b6b <SMART_PITCH_PLC_PROCESS+0x78f>:
     b6b:	ffa022        	movi	a2, 255
     b6e:	7fd222        	addmi	a2, a2, 0x7f00
     b71:	30a232        	movi	a3, 0x230
     b74:	af3a           	add.n	a10, a15, a3
     b76:	162fb2        	l32i	a11, a15, 88
     b79:	172fc2        	l32i	a12, a15, 92
     b7c:	fd3051        	l32r	a5, 3c (1a68 <getfespeech>)
     b7f:	1b6f22        	s32i	a2, a15, 108
     b82:	122f22        	l32i	a2, a15, 72
     b85:	04dd           	mov.n	a13, a4
     b87:	0aed           	mov.n	a14, a10
     b89:	81a9           	s32i.n	a10, a1, 32
     b8b:	0f7d           	mov.n	a7, a15
     b8d:	0005e0        	callx8	a5
     b90:	222732        	l32i	a3, a7, 136
     b93:	1627e2        	l32i	a14, a7, 88
     b96:	182752        	l32i	a5, a7, 96
     b99:	0ca2f2        	movi	a15, 0x20c
     b9c:	be3a           	add.n	a11, a14, a3
     b9e:	048d           	mov.n	a8, a4
     ba0:	232a           	add.n	a2, a3, a2
     ba2:	c0c5b0        	sub	a12, a5, a11
     ba5:	079d           	mov.n	a9, a7
     ba7:	126722        	s32i	a2, a7, 72
     baa:	21e140        	srai	a14, a4, 1
     bad:	f7fa           	add.n	a15, a7, a15
     baf:	1667b2        	s32i	a11, a7, 88
     bb2:	1767c2        	s32i	a12, a7, 92
     bb5:	6024a6        	blti	a4, 2, c19 <SMART_PITCH_PLC_PROCESS+0x83d>
     bb8:	64a642        	movi	a4, 0x664
     bbb:	30c122        	addi	a2, a1, 48
     bbe:	4151e0        	srli	a5, a14, 1
     bc1:	0f3d           	mov.n	a3, a15
     bc3:	494a           	add.n	a4, a9, a4
     bc5:	1f6e07        	bbci	a14, 0, be8 <SMART_PITCH_PLC_PROCESS+0x80c>
     bc8:	448314        	ae_lp16x2f.iu	aep0, a3, 4
     bcb:	449414        	ae_lp16x2f.iu	aep1, a4, 4
     bce:	e82293a66f 	{ or	a10, a6, a6; ae_mulp24s.hh	aeq0, aep0, aep1 }
     bd3:	ea23d3d88f 	{ or	a13, a8, a8; ae_mulp24s.ll	aeq1, aep0, aep1 }
     bd8:	368604        	ae_trunca32q48	a6, aeq0
     bdb:	369804        	ae_trunca32q48	a8, aeq1
     bde:	0269           	s32i.n	a6, a2, 0
     be0:	1289           	s32i.n	a8, a2, 4
     be2:	0a6d           	mov.n	a6, a10
     be4:	0d8d           	mov.n	a8, a13
     be6:	228b           	addi.n	a2, a2, 8
     be8:	d5ac           	beqz.n	a5, c19 <SMART_PITCH_PLC_PROCESS+0x83d>
     bea:	2b9576        	loopnez	a5, c19 <SMART_PITCH_PLC_PROCESS+0x83d>
     bed:	44a314        	ae_lp16x2f.iu	aep2, a3, 4
     bf0:	449414        	ae_lp16x2f.iu	aep1, a4, 4
     bf3:	ea2bed841f 	{ ae_lp16x2f.iu	aep0, a4, 4; ae_mulp24s.ll	aeq1, aep2, aep1 }
     bf8:	e82aad931f 	{ ae_lp16x2f.iu	aep1, a3, 4; ae_mulp24s.hh	aeq0, aep2, aep1 }
     bfd:	ea07ff15ef 	{ ae_trunca32q48	a5, aeq1; ae_mulp24s.ll	aeq1, aep1, aep0 }
     c02:	e90694125f 	{ s32i.n	a5, a2, 4; ae_mulp24s.hh	aeq2, aep1, aep0 }
     c07:	368504        	ae_trunca32q48	a5, aeq0
     c0a:	0259           	s32i.n	a5, a2, 0
     c0c:	369504        	ae_trunca32q48	a5, aeq1
     c0f:	3259           	s32i.n	a5, a2, 12
     c11:	36a504        	ae_trunca32q48	a5, aeq2
     c14:	2259           	s32i.n	a5, a2, 8
     c16:	10c222        	addi	a2, a2, 16

00000c19 <SMART_PITCH_PLC_PROCESS+0x83d>:
     c19:	eca152        	movi	a5, 0x1ec
     c1c:	3818a6        	blti	a8, 1, c58 <SMART_PITCH_PLC_PROCESS+0x87c>
     c1f:	08dd           	mov.n	a13, a8
     c21:	c02c80        	sub	a2, a12, a8
     c24:	30a232        	movi	a3, 0x230
     c27:	902290        	addx2	a2, a2, a9
     c2a:	30a1a2        	movi	a10, 0x130
     c2d:	323a           	add.n	a3, a2, a3
     c2f:	29aa           	add.n	a2, a9, a10
     c31:	068d           	mov.n	a8, a6
     c33:	4141d0        	srli	a4, a13, 1
     c36:	0dad           	mov.n	a10, a13
     c38:	076d07        	bbci	a13, 0, c43 <SMART_PITCH_PLC_PROCESS+0x867>
     c3b:	236d           	ae_l16si.n	a6, a3, 0
     c3d:	626d           	ae_s16i.n	a6, a2, 0
     c3f:	332b           	addi.n	a3, a3, 2
     c41:	222b           	addi.n	a2, a2, 2

00000c43 <SMART_PITCH_PLC_PROCESS+0x867>:
     c43:	086d           	mov.n	a6, a8
     c45:	0a8d           	mov.n	a8, a10
     c47:	d48c           	beqz.n	a4, c58 <SMART_PITCH_PLC_PROCESS+0x87c>
     c49:	0b9476        	loopnez	a4, c58 <SMART_PITCH_PLC_PROCESS+0x87c>
     c4c:	234d           	ae_l16si.n	a4, a3, 0
     c4e:	624d           	ae_s16i.n	a4, a2, 0
     c50:	334d           	ae_l16si.n	a4, a3, 2
     c52:	724d           	ae_s16i.n	a4, a2, 2
     c54:	334b           	addi.n	a3, a3, 4
     c56:	224b           	addi.n	a2, a2, 4

00000c58 <SMART_PITCH_PLC_PROCESS+0x87c>:
     c58:	a95a           	add.n	a10, a9, a5
     c5a:	4628a6        	blti	a8, 2, ca4 <SMART_PITCH_PLC_PROCESS+0x8c8>
     c5d:	2ca142        	movi	a4, 0x12c
     c60:	2cc122        	addi	a2, a1, 44
     c63:	0a3d           	mov.n	a3, a10
     c65:	494a           	add.n	a4, a9, a4
     c67:	448314        	ae_lp16x2f.iu	aep0, a3, 4
     c6a:	449414        	ae_lp16x2f.iu	aep1, a4, 4
     c6d:	601214        	ae_lq32f.iu	aeq0, a2, 4
     c70:	e4220ffede 	{ addi	a13, a14, -1; ae_mulap24s.hh	aeq0, aep0, aep1 }
     c75:	368504        	ae_trunca32q48	a5, aeq0
     c78:	0259           	s32i.n	a5, a2, 0
     c7a:	601214        	ae_lq32f.iu	aeq0, a2, 4
     c7d:	1a9d76        	loopnez	a13, c9b <SMART_PITCH_PLC_PROCESS+0x8bf>
     c80:	e6232d831f 	{ ae_lp16x2f.iu	aep0, a3, 4; ae_mulap24s.ll	aeq0, aep0, aep1 }
     c85:	449414        	ae_lp16x2f.iu	aep1, a4, 4
     c88:	368504        	ae_trunca32q48	a5, aeq0
     c8b:	0259           	s32i.n	a5, a2, 0
     c8d:	601214        	ae_lq32f.iu	aeq0, a2, 4
     c90:	020104        	ae_mulap24s.hh	aeq0, aep0, aep1
     c93:	368504        	ae_trunca32q48	a5, aeq0
     c96:	0259           	s32i.n	a5, a2, 0
     c98:	601214        	ae_lq32f.iu	aeq0, a2, 4

00000c9b <SMART_PITCH_PLC_PROCESS+0x8bf>:
     c9b:	020134        	ae_mulap24s.ll	aeq0, aep0, aep1
     c9e:	368304        	ae_trunca32q48	a3, aeq0
     ca1:	006232        	s32i	a3, a2, 0

00000ca4 <SMART_PITCH_PLC_PROCESS+0x8c8>:
     ca4:	a1f9           	s32i.n	a15, a1, 40
     ca6:	b1e9           	s32i.n	a14, a1, 44
     ca8:	6169           	s32i.n	a6, a1, 24
     caa:	4f18a6        	blti	a8, 1, cfd <SMART_PITCH_PLC_PROCESS+0x921>
     cad:	6158           	l32i.n	a5, a1, 24
     caf:	1138f0        	slli	a3, a8, 1
     cb2:	30a242        	movi	a4, 0x230
     cb5:	d03530        	subx2	a3, a5, a3
     cb8:	339a           	add.n	a3, a3, a9
     cba:	146080        	extui	a6, a8, 0, 2
     cbd:	534a           	add.n	a5, a3, a4
     cbf:	30c122        	addi	a2, a1, 48
     cc2:	414280        	srli	a4, a8, 2
     cc5:	0a9676        	loopnez	a6, cd3 <SMART_PITCH_PLC_PROCESS+0x8f7>
     cc8:	0238           	l32i.n	a3, a2, 0
     cca:	224b           	addi.n	a2, a2, 4
     ccc:	413f30        	srli	a3, a3, 15
     ccf:	653d           	ae_s16i.n	a3, a5, 0
     cd1:	552b           	addi.n	a5, a5, 2

00000cd3 <SMART_PITCH_PLC_PROCESS+0x8f7>:
     cd3:	64ac           	beqz.n	a4, cfd <SMART_PITCH_PLC_PROCESS+0x921>
     cd5:	053d           	mov.n	a3, a5
     cd7:	229476        	loopnez	a4, cfd <SMART_PITCH_PLC_PROCESS+0x921>
     cda:	0258           	l32i.n	a5, a2, 0
     cdc:	434b           	addi.n	a4, a3, 4
     cde:	3268           	l32i.n	a6, a2, 12
     ce0:	415f50        	srli	a5, a5, 15
     ce3:	635d           	ae_s16i.n	a5, a3, 0
     ce5:	2258           	l32i.n	a5, a2, 8
     ce7:	416f60        	srli	a6, a6, 15
     cea:	746d           	ae_s16i.n	a6, a4, 2
     cec:	416f50        	srli	a6, a5, 15
     cef:	1258           	l32i.n	a5, a2, 4
     cf1:	646d           	ae_s16i.n	a6, a4, 0
     cf3:	10c222        	addi	a2, a2, 16
     cf6:	415f50        	srli	a5, a5, 15
     cf9:	735d           	ae_s16i.n	a5, a3, 2
     cfb:	344b           	addi.n	a3, a4, 4

00000cfd <SMART_PITCH_PLC_PROCESS+0x921>:
     cfd:	e0a622        	movi	a2, 0x6e0
     d00:	0a6d           	mov.n	a6, a10
     d02:	e92a           	add.n	a14, a9, a2
     d04:	81a8           	l32i.n	a10, a1, 32
     d06:	0721d2        	l32i	a13, a1, 28
     d09:	fccc21        	l32r	a2, 3c (1a68 <getfespeech>)
     d0c:	20f770        	or	a15, a7, a7
     d0f:	0002e0        	callx8	a2
     d12:	5188           	l32i.n	a8, a1, 20
     d14:	91b8           	l32i.n	a11, a1, 36
     d16:	07dd           	mov.n	a13, a7
     d18:	0228e6        	bgei	a8, 2, d1e <SMART_PITCH_PLC_PROCESS+0x942>
     d1b:	002046        	j	da0 <SMART_PITCH_PLC_PROCESS+0x9c4>
     d1e:	a178           	l32i.n	a7, a1, 40
     d20:	2ca222        	movi	a2, 0x22c
     d23:	4d2a           	add.n	a4, a13, a2
     d25:	b198           	l32i.n	a9, a1, 44
     d27:	448714        	ae_lp16x2f.iu	aep0, a7, 4
     d2a:	449414        	ae_lp16x2f.iu	aep1, a4, 4
     d2d:	e8228170ef 	{ movi	a14, 0x170; ae_mulp24s.hh	aeq0, aep0, aep1 }
     d32:	eb23d02def 	{ add	a2, a13, a14; ae_mulp24s.ll	aeq3, aep0, aep1 }
     d37:	368304        	ae_trunca32q48	a3, aeq0
     d3a:	36b504        	ae_trunca32q48	a5, aeq3
     d3d:	f90b           	addi.n	a15, a9, -1
     d3f:	0239           	s32i.n	a3, a2, 0
     d41:	073d           	mov.n	a3, a7
     d43:	1259           	s32i.n	a5, a2, 4
     d45:	179f76        	loopnez	a15, d60 <SMART_PITCH_PLC_PROCESS+0x984>
     d48:	448314        	ae_lp16x2f.iu	aep0, a3, 4
     d4b:	449414        	ae_lp16x2f.iu	aep1, a4, 4
     d4e:	020974        	ae_mulp24s.ll	aeq1, aep0, aep1
     d51:	e82280822e 	{ addi	a2, a2, 8; ae_mulp24s.hh	aeq0, aep0, aep1 }
     d56:	369504        	ae_trunca32q48	a5, aeq1
     d59:	1259           	s32i.n	a5, a2, 4
     d5b:	368504        	ae_trunca32q48	a5, aeq0
     d5e:	0259           	s32i.n	a5, a2, 0

00000d60 <SMART_PITCH_PLC_PROCESS+0x984>:
     d60:	dca622        	movi	a2, 0x6dc
     d63:	4d2a           	add.n	a4, a13, a2
     d65:	448614        	ae_lp16x2f.iu	aep0, a6, 4
     d68:	449414        	ae_lp16x2f.iu	aep1, a4, 4
     d6b:	e82281b0ef 	{ movi	a14, 0x1b0; ae_mulp24s.hh	aeq0, aep0, aep1 }
     d70:	eb23d02def 	{ add	a2, a13, a14; ae_mulp24s.ll	aeq3, aep0, aep1 }
     d75:	368304        	ae_trunca32q48	a3, aeq0
     d78:	36bf04        	ae_trunca32q48	a15, aeq3
     d7b:	590b           	addi.n	a5, a9, -1
     d7d:	0239           	s32i.n	a3, a2, 0
     d7f:	203660        	or	a3, a6, a6
     d82:	0162f2        	s32i	a15, a2, 4
     d85:	179576        	loopnez	a5, da0 <SMART_PITCH_PLC_PROCESS+0x9c4>
     d88:	448314        	ae_lp16x2f.iu	aep0, a3, 4
     d8b:	449414        	ae_lp16x2f.iu	aep1, a4, 4
     d8e:	020974        	ae_mulp24s.ll	aeq1, aep0, aep1
     d91:	e82280822e 	{ addi	a2, a2, 8; ae_mulp24s.hh	aeq0, aep0, aep1 }
     d96:	369504        	ae_trunca32q48	a5, aeq1
     d99:	1259           	s32i.n	a5, a2, 4
     d9b:	368504        	ae_trunca32q48	a5, aeq0
     d9e:	0259           	s32i.n	a5, a2, 0

00000da0 <SMART_PITCH_PLC_PROCESS+0x9c4>:
     da0:	1d2d22        	l32i	a2, a13, 116
     da3:	ed38           	l32i.n	a3, a13, 56
     da5:	71c8           	l32i.n	a12, a1, 28
     da7:	051226        	beqi	a2, 1, db0 <SMART_PITCH_PLC_PROCESS+0x9d4>
     daa:	021326        	beqi	a3, 1, db0 <SMART_PITCH_PLC_PROCESS+0x9d4>
     dad:	00ebc6        	j	1160 <SMART_PITCH_PLC_PROCESS+0xd84>
     db0:	71c8           	l32i.n	a12, a1, 28
     db2:	0218e6        	bgei	a8, 1, db8 <SMART_PITCH_PLC_PROCESS+0x9dc>
     db5:	004546        	j	ece <SMART_PITCH_PLC_PROCESS+0xaf2>
     db8:	70a142        	movi	a4, 0x170
     dbb:	6ccd22        	addi	a2, a13, 108
     dbe:	10c132        	addi	a3, a1, 16
     dc1:	416180        	srli	a6, a8, 1
     dc4:	0b5d           	mov.n	a5, a11
     dc6:	4d4a           	add.n	a4, a13, a4
     dc8:	316807        	bbci	a8, 0, dfd <SMART_PITCH_PLC_PROCESS+0xa21>
     dcb:	0478           	l32i.n	a7, a4, 0
     dcd:	102482        	l32i	a8, a4, 64
     dd0:	400224        	ae_lp16f.i	aep0, a2, 4
     dd3:	219f70        	srai	a9, a7, 15
     dd6:	21af80        	srai	a10, a8, 15
     dd9:	4199           	s32i.n	a9, a1, 16
     ddb:	402304        	ae_lp16f.i	aep2, a3, 0
     dde:	41a9           	s32i.n	a10, a1, 16
     de0:	ea0bac120f 	{ ae_lp16f.i	aep1, a2, 0; ae_mulp24s.ll	aeq0, aep2, aep0 }
     de5:	403304        	ae_lp16f.i	aep3, a3, 0
     de8:	ea2fff0eef 	{ ae_trunca32q48	a14, aeq0; ae_mulp24s.ll	aeq1, aep3, aep1 }
     ded:	5188           	l32i.n	a8, a1, 20
     def:	369f04        	ae_trunca32q48	a15, aeq1
     df2:	444b           	addi.n	a4, a4, 4
     df4:	7fea           	add.n	a7, a15, a14
     df6:	417f70        	srli	a7, a7, 15
     df9:	657d           	ae_s16i.n	a7, a5, 0
     dfb:	552b           	addi.n	a5, a5, 2
     dfd:	0cd616        	beqz	a6, ece <SMART_PITCH_PLC_PROCESS+0xaf2>
     e00:	0478           	l32i.n	a7, a4, 0
     e02:	102482        	l32i	a8, a4, 64
     e05:	0bed           	mov.n	a14, a11
     e07:	217f70        	srai	a7, a7, 15
     e0a:	4179           	s32i.n	a7, a1, 16
     e0c:	218f80        	srai	a8, a8, 15
     e0f:	401304        	ae_lp16f.i	aep1, a3, 0
     e12:	4189           	s32i.n	a8, a1, 16
     e14:	400224        	ae_lp16f.i	aep0, a2, 4
     e17:	14b8           	l32i.n	a11, a4, 4
     e19:	ea07b114fe 	{ l32i	a15, a4, 68; ae_mulp24s.ll	aeq0, aep1, aep0 }
     e1e:	402204        	ae_lp16f.i	aep2, a2, 0
     e21:	407304        	ae_lp16f.i	aep7, a3, 0
     e24:	eb5fcff66e 	{ addi	a6, a6, -1; ae_mulp24s.ll	aeq3, aep7, aep2 }
     e29:	219fb0        	srai	a9, a11, 15
     e2c:	21aff0        	srai	a10, a15, 15
     e2f:	368b04        	ae_trunca32q48	a11, aeq0
     e32:	36bf04        	ae_trunca32q48	a15, aeq3
     e35:	4199           	s32i.n	a9, a1, 16
     e37:	402304        	ae_lp16f.i	aep2, a3, 0
     e3a:	7fba           	add.n	a7, a15, a11
     e3c:	417f70        	srli	a7, a7, 15
     e3f:	0461a2        	s32i	a10, a1, 16
     e42:	657d           	ae_s16i.n	a7, a5, 0
     e44:	08c442        	addi	a4, a4, 8
     e47:	400304        	ae_lp16f.i	aep0, a3, 0
     e4a:	401224        	ae_lp16f.i	aep1, a2, 4
     e4d:	5c9676        	loopnez	a6, ead <SMART_PITCH_PLC_PROCESS+0xad1>
     e50:	ea2bf0047e 	{ l32i	a7, a4, 0; ae_mulp24s.ll	aeq1, aep2, aep1 }
     e55:	401204        	ae_lp16f.i	aep1, a2, 0
     e58:	ea23b1046e 	{ l32i	a6, a4, 64; ae_mulp24s.ll	aeq0, aep0, aep1 }
     e5d:	369a04        	ae_trunca32q48	a10, aeq1
     e60:	14b8           	l32i.n	a11, a4, 4
     e62:	368804        	ae_trunca32q48	a8, aeq0
     e65:	217f70        	srai	a7, a7, 15
     e68:	112492        	l32i	a9, a4, 68
     e6b:	21bfb0        	srai	a11, a11, 15
     e6e:	88aa           	add.n	a8, a8, a10
     e70:	4179           	s32i.n	a7, a1, 16
     e72:	417f80        	srli	a7, a8, 15
     e75:	400304        	ae_lp16f.i	aep0, a3, 0
     e78:	757d           	ae_s16i.n	a7, a5, 2
     e7a:	554b           	addi.n	a5, a5, 4
     e7c:	217f60        	srai	a7, a6, 15
     e7f:	216f90        	srai	a6, a9, 15
     e82:	4179           	s32i.n	a7, a1, 16
     e84:	401224        	ae_lp16f.i	aep1, a2, 4
     e87:	ea23ac030f 	{ ae_lp16f.i	aep0, a3, 0; ae_mulp24s.ll	aeq0, aep0, aep1 }
     e8c:	401204        	ae_lp16f.i	aep1, a2, 0
     e8f:	41b9           	s32i.n	a11, a1, 16
     e91:	ea23bf07ef 	{ ae_trunca32q48	a7, aeq0; ae_mulp24s.ll	aeq0, aep0, aep1 }
     e96:	402304        	ae_lp16f.i	aep2, a3, 0
     e99:	368804        	ae_trunca32q48	a8, aeq0
     e9c:	448b           	addi.n	a4, a4, 8
     e9e:	4169           	s32i.n	a6, a1, 16
     ea0:	400304        	ae_lp16f.i	aep0, a3, 0
     ea3:	687a           	add.n	a6, a8, a7
     ea5:	416f60        	srli	a6, a6, 15
     ea8:	656d           	ae_s16i.n	a6, a5, 0
     eaa:	401224        	ae_lp16f.i	aep1, a2, 4

00000ead <SMART_PITCH_PLC_PROCESS+0xad1>:
     ead:	f962ec720f 	{ ae_lp16f.i	aep7, a2, 0; ae_movp48	aep3, aep0 }
     eb2:	ea2bbf18bf 	{ ae_movp48	aep6, aep1; ae_mulp24s.ll	aeq0, aep2, aep1 }
     eb7:	eaefc045fe 	{ addi	a15, a5, 4; ae_mulp24s.ll	aeq1, aep3, aep7 }
     ebc:	368704        	ae_trunca32q48	a7, aeq0
     ebf:	369804        	ae_trunca32q48	a8, aeq1
     ec2:	0ebd           	mov.n	a11, a14
     ec4:	787a           	add.n	a7, a8, a7
     ec6:	052182        	l32i	a8, a1, 20
     ec9:	417f70        	srli	a7, a7, 15
     ecc:	757d           	ae_s16i.n	a7, a5, 2

00000ece <SMART_PITCH_PLC_PROCESS+0xaf2>:
     ece:	6168           	l32i.n	a6, a1, 24
     ed0:	c02c80        	sub	a2, a12, a8
     ed3:	0212e6        	bgei	a2, 1, ed9 <SMART_PITCH_PLC_PROCESS+0xafd>
     ed6:	00be86        	j	11d4 <SMART_PITCH_PLC_PROCESS+0xdf8>
     ed9:	9048d0        	addx2	a4, a8, a13
     edc:	e0a652        	movi	a5, 0x6e0
     edf:	445a           	add.n	a4, a4, a5
     ee1:	246d           	ae_l16si.n	a6, a4, 0
     ee3:	1b2d32        	l32i	a3, a13, 108
     ee6:	720b           	addi.n	a7, a2, -1
     ee8:	90e8b0        	addx2	a14, a8, a11
     eeb:	826360        	mull	a6, a3, a6
     eee:	032d           	mov.n	a2, a3
     ef0:	41ff60        	srli	a15, a6, 15
     ef3:	442b           	addi.n	a4, a4, 2
     ef5:	0e3d           	mov.n	a3, a14
     ef7:	6efd           	ae_s16i.n	a15, a14, 0
     ef9:	0d9776        	loopnez	a7, f0a <SMART_PITCH_PLC_PROCESS+0xb2e>
     efc:	245d           	ae_l16si.n	a5, a4, 0
     efe:	442b           	addi.n	a4, a4, 2
     f00:	825250        	mull	a5, a2, a5
     f03:	332b           	addi.n	a3, a3, 2
     f05:	415f50        	srli	a5, a5, 15
     f08:	635d           	ae_s16i.n	a5, a3, 0

00000f0a <SMART_PITCH_PLC_PROCESS+0xb2e>:
     f0a:	6168           	l32i.n	a6, a1, 24
     f0c:	00b106        	j	11d4 <SMART_PITCH_PLC_PROCESS+0xdf8>

00000f0f <SMART_PITCH_PLC_PROCESS+0xb33>:
	...

00000f10 <SMART_PITCH_PLC_PROCESS+0xb34>:
     f10:	7fdee2        	addmi	a14, a14, 0x7f00
     f13:	5188           	l32i.n	a8, a1, 20
     f15:	91b8           	l32i.n	a11, a1, 36
     f17:	05cd           	mov.n	a12, a5
     f19:	06fd           	mov.n	a15, a6
     f1b:	1b6de2        	s32i	a14, a13, 108
     f1e:	0228e6        	bgei	a8, 2, f24 <SMART_PITCH_PLC_PROCESS+0xb48>
     f21:	002106        	j	fa9 <SMART_PITCH_PLC_PROCESS+0xbcd>
     f24:	0ca232        	movi	a3, 0x20c
     f27:	2ca222        	movi	a2, 0x22c
     f2a:	4d2a           	add.n	a4, a13, a2
     f2c:	3d3a           	add.n	a3, a13, a3
     f2e:	448314        	ae_lp16x2f.iu	aep0, a3, 4
     f31:	449414        	ae_lp16x2f.iu	aep1, a4, 4
     f34:	e82281707f 	{ movi	a7, 0x170; ae_mulp24s.hh	aeq0, aep0, aep1 }
     f39:	eb23d02d7f 	{ add	a2, a13, a7; ae_mulp24s.ll	aeq3, aep0, aep1 }
     f3e:	216180        	srai	a6, a8, 1
     f41:	368504        	ae_trunca32q48	a5, aeq0
     f44:	36b904        	ae_trunca32q48	a9, aeq3
     f47:	a60b           	addi.n	a10, a6, -1
     f49:	0259           	s32i.n	a5, a2, 0
     f4b:	1299           	s32i.n	a9, a2, 4
     f4d:	179a76        	loopnez	a10, f68 <SMART_PITCH_PLC_PROCESS+0xb8c>
     f50:	448314        	ae_lp16x2f.iu	aep0, a3, 4
     f53:	449414        	ae_lp16x2f.iu	aep1, a4, 4
     f56:	020974        	ae_mulp24s.ll	aeq1, aep0, aep1
     f59:	e82280822e 	{ addi	a2, a2, 8; ae_mulp24s.hh	aeq0, aep0, aep1 }
     f5e:	369504        	ae_trunca32q48	a5, aeq1
     f61:	1259           	s32i.n	a5, a2, 4
     f63:	368504        	ae_trunca32q48	a5, aeq0
     f66:	0259           	s32i.n	a5, a2, 0

00000f68 <SMART_PITCH_PLC_PROCESS+0xb8c>:
     f68:	eca132        	movi	a3, 0x1ec
     f6b:	dca622        	movi	a2, 0x6dc
     f6e:	4d2a           	add.n	a4, a13, a2
     f70:	3d3a           	add.n	a3, a13, a3
     f72:	448314        	ae_lp16x2f.iu	aep0, a3, 4
     f75:	449414        	ae_lp16x2f.iu	aep1, a4, 4
     f78:	e82281b09f 	{ movi	a9, 0x1b0; ae_mulp24s.hh	aeq0, aep0, aep1 }
     f7d:	eb23d02d9f 	{ add	a2, a13, a9; ae_mulp24s.ll	aeq3, aep0, aep1 }
     f82:	368504        	ae_trunca32q48	a5, aeq0
     f85:	36ba04        	ae_trunca32q48	a10, aeq3
     f88:	660b           	addi.n	a6, a6, -1
     f8a:	0259           	s32i.n	a5, a2, 0
     f8c:	12a9           	s32i.n	a10, a2, 4
     f8e:	179676        	loopnez	a6, fa9 <SMART_PITCH_PLC_PROCESS+0xbcd>
     f91:	448314        	ae_lp16x2f.iu	aep0, a3, 4
     f94:	449414        	ae_lp16x2f.iu	aep1, a4, 4
     f97:	020974        	ae_mulp24s.ll	aeq1, aep0, aep1
     f9a:	e82280822e 	{ addi	a2, a2, 8; ae_mulp24s.hh	aeq0, aep0, aep1 }
     f9f:	369504        	ae_trunca32q48	a5, aeq1
     fa2:	1259           	s32i.n	a5, a2, 4
     fa4:	368504        	ae_trunca32q48	a5, aeq0
     fa7:	0259           	s32i.n	a5, a2, 0

00000fa9 <SMART_PITCH_PLC_PROCESS+0xbcd>:
     fa9:	0218e6        	bgei	a8, 1, faf <SMART_PITCH_PLC_PROCESS+0xbd3>
     fac:	004406        	j	10c0 <SMART_PITCH_PLC_PROCESS+0xce4>
     faf:	70a142        	movi	a4, 0x170
     fb2:	6ccd22        	addi	a2, a13, 108
     fb5:	10c132        	addi	a3, a1, 16
     fb8:	416180        	srli	a6, a8, 1
     fbb:	0b5d           	mov.n	a5, a11
     fbd:	4d4a           	add.n	a4, a13, a4
     fbf:	316807        	bbci	a8, 0, ff4 <SMART_PITCH_PLC_PROCESS+0xc18>
     fc2:	0478           	l32i.n	a7, a4, 0
     fc4:	102482        	l32i	a8, a4, 64
     fc7:	400224        	ae_lp16f.i	aep0, a2, 4
     fca:	219f70        	srai	a9, a7, 15
     fcd:	4199           	s32i.n	a9, a1, 16
     fcf:	218f80        	srai	a8, a8, 15
     fd2:	402304        	ae_lp16f.i	aep2, a3, 0
     fd5:	4189           	s32i.n	a8, a1, 16
     fd7:	ea0bac120f 	{ ae_lp16f.i	aep1, a2, 0; ae_mulp24s.ll	aeq0, aep2, aep0 }
     fdc:	403304        	ae_lp16f.i	aep3, a3, 0
     fdf:	ea2fff09ef 	{ ae_trunca32q48	a9, aeq0; ae_mulp24s.ll	aeq1, aep3, aep1 }
     fe4:	5188           	l32i.n	a8, a1, 20
     fe6:	369a04        	ae_trunca32q48	a10, aeq1
     fe9:	444b           	addi.n	a4, a4, 4
     feb:	7a9a           	add.n	a7, a10, a9
     fed:	417f70        	srli	a7, a7, 15
     ff0:	657d           	ae_s16i.n	a7, a5, 0
     ff2:	552b           	addi.n	a5, a5, 2
     ff4:	0c8616        	beqz	a6, 10c0 <SMART_PITCH_PLC_PROCESS+0xce4>
     ff7:	0478           	l32i.n	a7, a4, 0
     ff9:	102482        	l32i	a8, a4, 64
     ffc:	14a8           	l32i.n	a10, a4, 4
     ffe:	217f70        	srai	a7, a7, 15
    1001:	4179           	s32i.n	a7, a1, 16
    1003:	218f80        	srai	a8, a8, 15
    1006:	401304        	ae_lp16f.i	aep1, a3, 0
    1009:	4189           	s32i.n	a8, a1, 16
    100b:	1124b2        	l32i	a11, a4, 68
    100e:	400224        	ae_lp16f.i	aep0, a2, 4
    1011:	ea07ac220f 	{ ae_lp16f.i	aep2, a2, 0; ae_mulp24s.ll	aeq0, aep1, aep0 }
    1016:	407304        	ae_lp16f.i	aep7, a3, 0
    1019:	eb5fcff66e 	{ addi	a6, a6, -1; ae_mulp24s.ll	aeq3, aep7, aep2 }
    101e:	219fa0        	srai	a9, a10, 15
    1021:	218fb0        	srai	a8, a11, 15
    1024:	368a04        	ae_trunca32q48	a10, aeq0
    1027:	36bb04        	ae_trunca32q48	a11, aeq3
    102a:	4199           	s32i.n	a9, a1, 16
    102c:	402304        	ae_lp16f.i	aep2, a3, 0
    102f:	7baa           	add.n	a7, a11, a10
    1031:	417f70        	srli	a7, a7, 15
    1034:	4189           	s32i.n	a8, a1, 16
    1036:	657d           	ae_s16i.n	a7, a5, 0
    1038:	448b           	addi.n	a4, a4, 8
    103a:	400304        	ae_lp16f.i	aep0, a3, 0
    103d:	401224        	ae_lp16f.i	aep1, a2, 4
    1040:	5c9676        	loopnez	a6, 10a0 <SMART_PITCH_PLC_PROCESS+0xcc4>
    1043:	ea2bf0047e 	{ l32i	a7, a4, 0; ae_mulp24s.ll	aeq1, aep2, aep1 }
    1048:	401204        	ae_lp16f.i	aep1, a2, 0
    104b:	ea23b1046e 	{ l32i	a6, a4, 64; ae_mulp24s.ll	aeq0, aep0, aep1 }
    1050:	369a04        	ae_trunca32q48	a10, aeq1
    1053:	14b8           	l32i.n	a11, a4, 4
    1055:	368804        	ae_trunca32q48	a8, aeq0
    1058:	217f70        	srai	a7, a7, 15
    105b:	112492        	l32i	a9, a4, 68
    105e:	21bfb0        	srai	a11, a11, 15
    1061:	88aa           	add.n	a8, a8, a10
    1063:	4179           	s32i.n	a7, a1, 16
    1065:	417f80        	srli	a7, a8, 15
    1068:	400304        	ae_lp16f.i	aep0, a3, 0
    106b:	757d           	ae_s16i.n	a7, a5, 2
    106d:	554b           	addi.n	a5, a5, 4
    106f:	217f60        	srai	a7, a6, 15
    1072:	216f90        	srai	a6, a9, 15
    1075:	4179           	s32i.n	a7, a1, 16
    1077:	401224        	ae_lp16f.i	aep1, a2, 4
    107a:	ea23ac030f 	{ ae_lp16f.i	aep0, a3, 0; ae_mulp24s.ll	aeq0, aep0, aep1 }
    107f:	401204        	ae_lp16f.i	aep1, a2, 0
    1082:	41b9           	s32i.n	a11, a1, 16
    1084:	ea23bf07ef 	{ ae_trunca32q48	a7, aeq0; ae_mulp24s.ll	aeq0, aep0, aep1 }
    1089:	402304        	ae_lp16f.i	aep2, a3, 0
    108c:	368804        	ae_trunca32q48	a8, aeq0
    108f:	448b           	addi.n	a4, a4, 8
    1091:	4169           	s32i.n	a6, a1, 16
    1093:	400304        	ae_lp16f.i	aep0, a3, 0
    1096:	687a           	add.n	a6, a8, a7
    1098:	416f60        	srli	a6, a6, 15
    109b:	656d           	ae_s16i.n	a6, a5, 0
    109d:	401224        	ae_lp16f.i	aep1, a2, 4

000010a0 <SMART_PITCH_PLC_PROCESS+0xcc4>:
    10a0:	f962ec720f 	{ ae_lp16f.i	aep7, a2, 0; ae_movp48	aep3, aep0 }
    10a5:	ea2bb091be 	{ l32i	a11, a1, 36; ae_mulp24s.ll	aeq0, aep2, aep1 }
    10aa:	eaefff18bf 	{ ae_movp48	aep6, aep1; ae_mulp24s.ll	aeq1, aep3, aep7 }
    10af:	368704        	ae_trunca32q48	a7, aeq0
    10b2:	369804        	ae_trunca32q48	a8, aeq1
    10b5:	807870        	add	a7, a8, a7
    10b8:	052182        	l32i	a8, a1, 20
    10bb:	417f70        	srli	a7, a7, 15
    10be:	757d           	ae_s16i.n	a7, a5, 2

000010c0 <SMART_PITCH_PLC_PROCESS+0xce4>:
    10c0:	c02c80        	sub	a2, a12, a8
    10c3:	0f6d           	mov.n	a6, a15
    10c5:	2d12a6        	blti	a2, 1, 10f6 <SMART_PITCH_PLC_PROCESS+0xd1a>
    10c8:	9038d0        	addx2	a3, a8, a13
    10cb:	e0a642        	movi	a4, 0x6e0
    10ce:	434a           	add.n	a4, a3, a4
    10d0:	245d           	ae_l16si.n	a5, a4, 0
    10d2:	620b           	addi.n	a6, a2, -1
    10d4:	9038b0        	addx2	a3, a8, a11
    10d7:	825e50        	mull	a5, a14, a5
    10da:	442b           	addi.n	a4, a4, 2
    10dc:	41af50        	srli	a10, a5, 15
    10df:	0e2d           	mov.n	a2, a14
    10e1:	63ad           	ae_s16i.n	a10, a3, 0
    10e3:	0d9676        	loopnez	a6, 10f4 <SMART_PITCH_PLC_PROCESS+0xd18>
    10e6:	245d           	ae_l16si.n	a5, a4, 0
    10e8:	442b           	addi.n	a4, a4, 2
    10ea:	825250        	mull	a5, a2, a5
    10ed:	332b           	addi.n	a3, a3, 2
    10ef:	415f50        	srli	a5, a5, 15
    10f2:	635d           	ae_s16i.n	a5, a3, 0

000010f4 <SMART_PITCH_PLC_PROCESS+0xd18>:
    10f4:	0f6d           	mov.n	a6, a15

000010f6 <SMART_PITCH_PLC_PROCESS+0xd1a>:
    10f6:	c046c0        	sub	a4, a6, a12
    10f9:	1314a6        	blti	a4, 1, 1110 <SMART_PITCH_PLC_PROCESS+0xd34>
    10fc:	e0a632        	movi	a3, 0x6e0
    10ff:	112cf0        	slli	a2, a12, 1
    1102:	803d30        	add	a3, a13, a3
    1105:	078476        	loop	a4, 1110 <SMART_PITCH_PLC_PROCESS+0xd34>
    1108:	432a           	add.n	a4, a3, a2
    110a:	244d           	ae_l16si.n	a4, a4, 0
    110c:	634d           	ae_s16i.n	a4, a3, 0
    110e:	332b           	addi.n	a3, a3, 2
    1110:	2d1ca6        	blti	a12, 1, 1141 <SMART_PITCH_PLC_PROCESS+0xd65>
    1113:	112cf0        	slli	a2, a12, 1
    1116:	d02620        	subx2	a2, a6, a2
    1119:	e0a632        	movi	a3, 0x6e0
    111c:	22da           	add.n	a2, a2, a13
    111e:	223a           	add.n	a2, a2, a3
    1120:	0b3d           	mov.n	a3, a11
    1122:	4141c0        	srli	a4, a12, 1
    1125:	076c07        	bbci	a12, 0, 1130 <SMART_PITCH_PLC_PROCESS+0xd54>
    1128:	235d           	ae_l16si.n	a5, a3, 0
    112a:	625d           	ae_s16i.n	a5, a2, 0
    112c:	332b           	addi.n	a3, a3, 2
    112e:	222b           	addi.n	a2, a2, 2
    1130:	d48c           	beqz.n	a4, 1141 <SMART_PITCH_PLC_PROCESS+0xd65>
    1132:	0b9476        	loopnez	a4, 1141 <SMART_PITCH_PLC_PROCESS+0xd65>
    1135:	234d           	ae_l16si.n	a4, a3, 0
    1137:	624d           	ae_s16i.n	a4, a2, 0
    1139:	334d           	ae_l16si.n	a4, a3, 2
    113b:	724d           	ae_s16i.n	a4, a2, 2
    113d:	334b           	addi.n	a3, a3, 4
    113f:	224b           	addi.n	a2, a2, 4

00001141 <SMART_PITCH_PLC_PROCESS+0xd65>:
    1141:	1b2d22        	l32i	a2, a13, 108
    1144:	1c6d22        	s32i	a2, a13, 112

00001147 <SMART_PITCH_PLC_PROCESS+0xd6b>:
    1147:	192d22        	l32i	a2, a13, 100
    114a:	ed38           	l32i.n	a3, a13, 56
    114c:	0a0c           	movi.n	a10, 0
    114e:	221b           	addi.n	a2, a2, 1
    1150:	196d22        	s32i	a2, a13, 100
    1153:	fbbb21        	l32r	a2, 40 (1750 <plc_gainctrl>)
    1156:	1d6d32        	s32i	a3, a13, 116
    1159:	0002e0        	callx8	a2
    115c:	f01d           	retw.n

0000115e <SMART_PITCH_PLC_PROCESS+0xd82>:
	...

00001160 <SMART_PITCH_PLC_PROCESS+0xd84>:
    1160:	3d18a6        	blti	a8, 1, 11a1 <SMART_PITCH_PLC_PROCESS+0xdc5>
    1163:	70a122        	movi	a2, 0x170
    1166:	414180        	srli	a4, a8, 1
    1169:	0b3d           	mov.n	a3, a11
    116b:	2d2a           	add.n	a2, a13, a2
    116d:	0f6807        	bbci	a8, 0, 1180 <SMART_PITCH_PLC_PROCESS+0xda4>
    1170:	0258           	l32i.n	a5, a2, 0
    1172:	102262        	l32i	a6, a2, 64
    1175:	224b           	addi.n	a2, a2, 4
    1177:	565a           	add.n	a5, a6, a5
    1179:	415f50        	srli	a5, a5, 15
    117c:	635d           	ae_s16i.n	a5, a3, 0
    117e:	332b           	addi.n	a3, a3, 2
    1180:	d49c           	beqz.n	a4, 11a1 <SMART_PITCH_PLC_PROCESS+0xdc5>
    1182:	1b9476        	loopnez	a4, 11a1 <SMART_PITCH_PLC_PROCESS+0xdc5>
    1185:	0258           	l32i.n	a5, a2, 0
    1187:	102242        	l32i	a4, a2, 64
    118a:	112262        	l32i	a6, a2, 68
    118d:	1278           	l32i.n	a7, a2, 4
    118f:	445a           	add.n	a4, a4, a5
    1191:	228b           	addi.n	a2, a2, 8
    1193:	414f40        	srli	a4, a4, 15
    1196:	634d           	ae_s16i.n	a4, a3, 0
    1198:	467a           	add.n	a4, a6, a7
    119a:	414f40        	srli	a4, a4, 15
    119d:	734d           	ae_s16i.n	a4, a3, 2
    119f:	334b           	addi.n	a3, a3, 4

000011a1 <SMART_PITCH_PLC_PROCESS+0xdc5>:
    11a1:	6168           	l32i.n	a6, a1, 24
    11a3:	c05c80        	sub	a5, a12, a8
    11a6:	2a15a6        	blti	a5, 1, 11d4 <SMART_PITCH_PLC_PROCESS+0xdf8>
    11a9:	9038d0        	addx2	a3, a8, a13
    11ac:	e0a642        	movi	a4, 0x6e0
    11af:	334a           	add.n	a3, a3, a4
    11b1:	9028b0        	addx2	a2, a8, a11
    11b4:	414150        	srli	a4, a5, 1
    11b7:	086507        	bbci	a5, 0, 11c3 <SMART_PITCH_PLC_PROCESS+0xde7>
    11ba:	235d           	ae_l16si.n	a5, a3, 0
    11bc:	625d           	ae_s16i.n	a5, a2, 0
    11be:	332b           	addi.n	a3, a3, 2
    11c0:	02c222        	addi	a2, a2, 2

000011c3 <SMART_PITCH_PLC_PROCESS+0xde7>:
    11c3:	d48c           	beqz.n	a4, 11d4 <SMART_PITCH_PLC_PROCESS+0xdf8>
    11c5:	0b9476        	loopnez	a4, 11d4 <SMART_PITCH_PLC_PROCESS+0xdf8>
    11c8:	234d           	ae_l16si.n	a4, a3, 0
    11ca:	624d           	ae_s16i.n	a4, a2, 0
    11cc:	334d           	ae_l16si.n	a4, a3, 2
    11ce:	724d           	ae_s16i.n	a4, a2, 2
    11d0:	334b           	addi.n	a3, a3, 4
    11d2:	224b           	addi.n	a2, a2, 4

000011d4 <SMART_PITCH_PLC_PROCESS+0xdf8>:
    11d4:	c046c0        	sub	a4, a6, a12
    11d7:	1214a6        	blti	a4, 1, 11ed <SMART_PITCH_PLC_PROCESS+0xe11>
    11da:	e0a632        	movi	a3, 0x6e0
    11dd:	112cf0        	slli	a2, a12, 1
    11e0:	3d3a           	add.n	a3, a13, a3
    11e2:	078476        	loop	a4, 11ed <SMART_PITCH_PLC_PROCESS+0xe11>
    11e5:	432a           	add.n	a4, a3, a2
    11e7:	244d           	ae_l16si.n	a4, a4, 0
    11e9:	634d           	ae_s16i.n	a4, a3, 0
    11eb:	332b           	addi.n	a3, a3, 2

000011ed <SMART_PITCH_PLC_PROCESS+0xe11>:
    11ed:	021ce6        	bgei	a12, 1, 11f3 <SMART_PITCH_PLC_PROCESS+0xe17>
    11f0:	ffd346        	j	1141 <SMART_PITCH_PLC_PROCESS+0xd65>
    11f3:	112cf0        	slli	a2, a12, 1
    11f6:	d02620        	subx2	a2, a6, a2
    11f9:	e0a632        	movi	a3, 0x6e0
    11fc:	22da           	add.n	a2, a2, a13
    11fe:	223a           	add.n	a2, a2, a3
    1200:	0b3d           	mov.n	a3, a11
    1202:	4141c0        	srli	a4, a12, 1
    1205:	076c07        	bbci	a12, 0, 1210 <SMART_PITCH_PLC_PROCESS+0xe34>
    1208:	235d           	ae_l16si.n	a5, a3, 0
    120a:	625d           	ae_s16i.n	a5, a2, 0
    120c:	332b           	addi.n	a3, a3, 2
    120e:	222b           	addi.n	a2, a2, 2
    1210:	f2d416        	beqz	a4, 1141 <SMART_PITCH_PLC_PROCESS+0xd65>
    1213:	0b9476        	loopnez	a4, 1222 <SMART_PITCH_PLC_PROCESS+0xe46>
    1216:	234d           	ae_l16si.n	a4, a3, 0
    1218:	624d           	ae_s16i.n	a4, a2, 0
    121a:	334d           	ae_l16si.n	a4, a3, 2
    121c:	724d           	ae_s16i.n	a4, a2, 2
    121e:	334b           	addi.n	a3, a3, 4
    1220:	224b           	addi.n	a2, a2, 4

00001222 <SMART_PITCH_PLC_PROCESS+0xe46>:
    1222:	ffc6c6        	j	1141 <SMART_PITCH_PLC_PROCESS+0xd65>

00001225 <SMART_PITCH_PLC_PROCESS+0xe49>:
    1225:	000000                                        ...

00001228 <sqrt_q26>:
    1228:	004136        	entry	a1, 32
    122b:	fb8631        	l32r	a3, 44 (19bc <HIFI_plc_sqrt>)
    122e:	02bd           	mov.n	a11, a2
    1230:	5a0c           	movi.n	a10, 5
    1232:	05a022        	movi	a2, 5
    1235:	0003e0        	callx8	a3
    1238:	c022a0        	sub	a2, a2, a10
    123b:	630c           	movi.n	a3, 6
    123d:	400200        	ssr	a2
    1240:	ff7c           	movi.n	a15, -1
    1242:	723a30        	salt	a3, a10, a3
    1245:	4121f0        	srli	a2, a15, 1
    1248:	b140b0        	sra	a4, a11
    124b:	932430        	movnez	a2, a4, a3
    124e:	f01d           	retw.n

00001250 <find_pitch_ini>:
    1250:	004136        	entry	a1, 32
    1253:	f01d           	retw.n

00001255 <find_pitch_ini+0x5>:
    1255:	000000                                        ...

00001258 <find_pitch>:
    1258:	00e136        	entry	a1, 112
    125b:	04cd           	mov.n	a12, a4
    125d:	a0f440        	addx4	a15, a4, a4
    1260:	6169           	s32i.n	a6, a1, 24
    1262:	a06ff0        	addx4	a6, a15, a15
    1265:	216460        	srai	a6, a6, 4
    1268:	126152        	s32i	a5, a1, 72
    126b:	a139           	s32i.n	a3, a1, 40
    126d:	b129           	s32i.n	a2, a1, 44
    126f:	07dd           	mov.n	a13, a7
    1271:	518b           	addi.n	a5, a1, 8
    1273:	41cb           	addi.n	a4, a1, 12
    1275:	090c           	movi.n	a9, 0
    1277:	020c           	movi.n	a2, 0
    1279:	030c           	movi.n	a3, 0
    127b:	d169           	s32i.n	a6, a1, 52
    127d:	621ca6        	blti	a12, 1, 12e3 <find_pitch+0x8b>
    1280:	a188           	l32i.n	a8, a1, 40
    1282:	b1f8           	l32i.n	a15, a1, 44
    1284:	2d0b           	addi.n	a2, a13, -1
    1286:	c072c0        	sub	a7, a2, a12
    1289:	c02280        	sub	a2, a2, a8
    128c:	3c1b           	addi.n	a3, a12, 1
    128e:	419130        	srli	a9, a3, 1
    1291:	9082f0        	addx2	a8, a2, a15
    1294:	0a0c           	movi.n	a10, 0
    1296:	9077f0        	addx2	a7, a7, a15
    1299:	052d           	mov.n	a2, a5
    129b:	043d           	mov.n	a3, a4
    129d:	075d           	mov.n	a5, a7
    129f:	060c           	movi.n	a6, 0
    12a1:	084d           	mov.n	a4, a8
    12a3:	0a7d           	mov.n	a7, a10
    12a5:	268976        	loop	a9, 12cf <find_pitch+0x77>
    12a8:	248d           	ae_l16si.n	a8, a4, 0
    12aa:	2189           	s32i.n	a8, a1, 8
    12ac:	444b           	addi.n	a4, a4, 4
    12ae:	400204        	ae_lp16f.i	aep0, a2, 0
    12b1:	ea03a0058e 	{ l16si	a8, a5, 0; ae_mulp24s.ll	aeq0, aep0, aep0 }
    12b6:	3189           	s32i.n	a8, a1, 12
    12b8:	401304        	ae_lp16f.i	aep1, a3, 0
    12bb:	ea23bf09ef 	{ ae_trunca32q48	a9, aeq0; ae_mulp24s.ll	aeq0, aep0, aep1 }
    12c0:	554b           	addi.n	a5, a5, 4
    12c2:	368804        	ae_trunca32q48	a8, aeq0
    12c5:	219490        	srai	a9, a9, 4
    12c8:	797a           	add.n	a7, a9, a7
    12ca:	218480        	srai	a8, a8, 4
    12cd:	686a           	add.n	a6, a8, a6

000012cf <find_pitch+0x77>:
    12cf:	079d           	mov.n	a9, a7
    12d1:	31ff60        	srai	a15, a6, 31
    12d4:	034d           	mov.n	a4, a3
    12d6:	417f60        	srli	a7, a6, 15
    12d9:	013ff0        	slli	a3, a15, 17
    12dc:	025d           	mov.n	a5, a2
    12de:	0126f0        	slli	a2, a6, 17
    12e1:	337a           	add.n	a3, a3, a7

000012e3 <find_pitch+0x8b>:
    12e3:	d168           	l32i.n	a6, a1, 52
    12e5:	5a0c           	movi.n	a10, 5
    12e7:	4149           	s32i.n	a4, a1, 16
    12e9:	53b960        	max	a11, a9, a6
    12ec:	fb5661        	l32r	a6, 44 (19bc <HIFI_plc_sqrt>)
    12ef:	5159           	s32i.n	a5, a1, 20
    12f1:	094d           	mov.n	a4, a9
    12f3:	570c           	movi.n	a7, 5
    12f5:	91c9           	s32i.n	a12, a1, 36
    12f7:	1161d2        	s32i	a13, a1, 68
    12fa:	0006e0        	callx8	a6
    12fd:	112192        	l32i	a9, a1, 68
    1300:	91c8           	l32i.n	a12, a1, 36
    1302:	180c           	movi.n	a8, 1
    1304:	050c           	movi.n	a5, 0
    1306:	c069c0        	sub	a6, a9, a12
    1309:	e169           	s32i.n	a6, a1, 56
    130b:	6168           	l32i.n	a6, a1, 24
    130d:	c0d7a0        	sub	a13, a7, a10
    1310:	6e0c           	movi.n	a14, 6
    1312:	0226e6        	bgei	a6, 2, 1318 <find_pitch+0xc0>
    1315:	005346        	j	1466 <find_pitch+0x20e>
    1318:	400d00        	ssr	a13
    131b:	ff7c           	movi.n	a15, -1
    131d:	72eae0        	salt	a14, a10, a14
    1320:	b1c0b0        	sra	a12, a11
    1323:	4171f0        	srli	a7, a15, 1
    1326:	83c7e0        	moveqz	a12, a7, a14
    1329:	02ad           	mov.n	a10, a2
    132b:	fb4321        	l32r	a2, 38 (1aa4 <__divdi3>)
    132e:	31dfc0        	srai	a13, a12, 31
    1331:	03bd           	mov.n	a11, a3
    1333:	096d           	mov.n	a6, a9
    1335:	0002e0        	callx8	a2
    1338:	91c8           	l32i.n	a12, a1, 36
    133a:	a188           	l32i.n	a8, a1, 40
    133c:	b178           	l32i.n	a7, a1, 44
    133e:	e128           	l32i.n	a2, a1, 56
    1340:	0a9d           	mov.n	a9, a10
    1342:	a6ca           	add.n	a10, a6, a12
    1344:	902270        	addx2	a2, a2, a7
    1347:	c03680        	sub	a3, a6, a8
    134a:	c0ea80        	sub	a14, a10, a8
    134d:	90d370        	addx2	a13, a3, a7
    1350:	fec222        	addi	a2, a2, -2
    1353:	90fe70        	addx2	a15, a14, a7
    1356:	2b0c           	movi.n	a11, 2
    1358:	050c           	movi.n	a5, 0
    135a:	136122        	s32i	a2, a1, 76
    135d:	dd2b           	addi.n	a13, a13, 2
    135f:	fecf32        	addi	a3, a15, -2
    1362:	fccda2        	addi	a10, a13, -4
    1365:	1061b2        	s32i	a11, a1, 64
    1368:	8159           	s32i.n	a5, a1, 32
    136a:	2abd           	ae_l16si.n	a11, a10, 0
    136c:	5158           	l32i.n	a5, a1, 20
    136e:	232d           	ae_l16si.n	a2, a3, 0
    1370:	31b9           	s32i.n	a11, a1, 12
    1372:	41b8           	l32i.n	a11, a1, 16
    1374:	2129           	s32i.n	a2, a1, 8
    1376:	400504        	ae_lp16f.i	aep0, a5, 0
    1379:	ea03ac7b0f 	{ ae_lp16f.i	aep7, a11, 0; ae_mulp24s.ll	aeq0, aep0, aep0 }
    137e:	ebffd4f13f 	{ s32i.n	a3, a1, 60; ae_mulp24s.ll	aeq3, aep7, aep7 }
    1383:	368e04        	ae_trunca32q48	a14, aeq0
    1386:	36bf04        	ae_trunca32q48	a15, aeq3
    1389:	7199           	s32i.n	a9, a1, 28
    138b:	2124e0        	srai	a2, a14, 4
    138e:	224a           	add.n	a2, a2, a4
    1390:	2134f0        	srai	a3, a15, 4
    1393:	c0a230        	sub	a10, a2, a3
    1396:	070c           	movi.n	a7, 0
    1398:	521ca6        	blti	a12, 1, 13ee <find_pitch+0x196>
    139b:	132162        	l32i	a6, a1, 76
    139e:	2c1b           	addi.n	a2, a12, 1
    13a0:	412120        	srli	a2, a2, 1
    13a3:	263d           	ae_l16si.n	a3, a6, 0
    13a5:	2dfd           	ae_l16si.n	a15, a13, 0
    13a7:	2139           	s32i.n	a3, a1, 8
    13a9:	31f9           	s32i.n	a15, a1, 12
    13ab:	920b           	addi.n	a9, a2, -1
    13ad:	8d4b           	addi.n	a8, a13, 4
    13af:	070c           	movi.n	a7, 0
    13b1:	664b           	addi.n	a6, a6, 4
    13b3:	400504        	ae_lp16f.i	aep0, a5, 0
    13b6:	052d           	mov.n	a2, a5
    13b8:	401b04        	ae_lp16f.i	aep1, a11, 0
    13bb:	0b3d           	mov.n	a3, a11
    13bd:	085d           	mov.n	a5, a8
    13bf:	1c9976        	loopnez	a9, 13df <find_pitch+0x187>
    13c2:	ea23a0069e 	{ l16si	a9, a6, 0; ae_mulp24s.ll	aeq0, aep0, aep1 }
    13c7:	254d           	ae_l16si.n	a4, a5, 0
    13c9:	368804        	ae_trunca32q48	a8, aeq0
    13cc:	2199           	s32i.n	a9, a1, 8
    13ce:	400204        	ae_lp16f.i	aep0, a2, 0
    13d1:	218480        	srai	a8, a8, 4
    13d4:	554b           	addi.n	a5, a5, 4
    13d6:	787a           	add.n	a7, a8, a7
    13d8:	664b           	addi.n	a6, a6, 4
    13da:	3149           	s32i.n	a4, a1, 12
    13dc:	401304        	ae_lp16f.i	aep1, a3, 0

000013df <find_pitch+0x187>:
    13df:	ea2393b33f 	{ or	a11, a3, a3; ae_mulp24s.ll	aeq0, aep0, aep1 }
    13e4:	025d           	mov.n	a5, a2
    13e6:	368f04        	ae_trunca32q48	a15, aeq0
    13e9:	2124f0        	srai	a2, a15, 4
    13ec:	727a           	add.n	a7, a2, a7

000013ee <find_pitch+0x196>:
    13ee:	d128           	l32i.n	a2, a1, 52
    13f0:	41b9           	s32i.n	a11, a1, 16
    13f2:	c1a9           	s32i.n	a10, a1, 48
    13f4:	53ba20        	max	a11, a10, a2
    13f7:	fb1321        	l32r	a2, 44 (19bc <HIFI_plc_sqrt>)
    13fa:	5a0c           	movi.n	a10, 5
    13fc:	5159           	s32i.n	a5, a1, 20
    13fe:	0d4d           	mov.n	a4, a13
    1400:	0002e0        	callx8	a2
    1403:	550c           	movi.n	a5, 5
    1405:	313f70        	srai	a3, a7, 31
    1408:	c0c5a0        	sub	a12, a5, a10
    140b:	400c00        	ssr	a12
    140e:	6d0c           	movi.n	a13, 6
    1410:	416f70        	srli	a6, a7, 15
    1413:	0133f0        	slli	a3, a3, 17
    1416:	ff7c           	movi.n	a15, -1
    1418:	336a           	add.n	a3, a3, a6
    141a:	b1c0b0        	sra	a12, a11
    141d:	0127f0        	slli	a2, a7, 17
    1420:	72ead0        	salt	a14, a10, a13
    1423:	4161f0        	srli	a6, a15, 1
    1426:	83c6e0        	moveqz	a12, a6, a14
    1429:	02ad           	mov.n	a10, a2
    142b:	fb0321        	l32r	a2, 38 (1aa4 <__divdi3>)
    142e:	31dfc0        	srai	a13, a12, 31
    1431:	03bd           	mov.n	a11, a3
    1433:	0002e0        	callx8	a2
    1436:	7198           	l32i.n	a9, a1, 28
    1438:	8158           	l32i.n	a5, a1, 32
    143a:	1021b2        	l32i	a11, a1, 64
    143d:	f138           	l32i.n	a3, a1, 60
    143f:	61f8           	l32i.n	a15, a1, 24
    1441:	04dd           	mov.n	a13, a4
    1443:	722a90        	salt	a2, a10, a9
    1446:	c148           	l32i.n	a4, a1, 48
    1448:	91c8           	l32i.n	a12, a1, 36
    144a:	835b20        	moveqz	a5, a11, a2
    144d:	bb2b           	addi.n	a11, a11, 2
    144f:	dd4b           	addi.n	a13, a13, 4
    1451:	334b           	addi.n	a3, a3, 4
    1453:	5399a0        	max	a9, a9, a10
    1456:	022fb7        	blt	a15, a11, 145c <find_pitch+0x204>
    1459:	ffc146        	j	1362 <find_pitch+0x10a>
    145c:	112192        	l32i	a9, a1, 68
    145f:	6168           	l32i.n	a6, a1, 24
    1461:	120c           	movi.n	a2, 1
    1463:	538520        	max	a8, a5, a2
    1466:	351b           	addi.n	a3, a5, 1
    1468:	722560        	salt	a2, a5, a6
    146b:	4158           	l32i.n	a5, a1, 16
    146d:	489a           	add.n	a4, a8, a9
    146f:	833620        	moveqz	a3, a6, a2
    1472:	780b           	addi.n	a7, a8, -1
    1474:	8189           	s32i.n	a8, a1, 32
    1476:	c139           	s32i.n	a3, a1, 48
    1478:	7149           	s32i.n	a4, a1, 28
    147a:	021ce6        	bgei	a12, 1, 1480 <find_pitch+0x228>
    147d:	002fc6        	j	1540 <find_pitch+0x2e8>
    1480:	a138           	l32i.n	a3, a1, 40
    1482:	b198           	l32i.n	a9, a1, 44
    1484:	e128           	l32i.n	a2, a1, 56
    1486:	c03430        	sub	a3, a4, a3
    1489:	90f390        	addx2	a15, a3, a9
    148c:	5138           	l32i.n	a3, a1, 20
    148e:	902290        	addx2	a2, a2, a9
    1491:	07bd           	mov.n	a11, a7
    1493:	080c           	movi.n	a8, 0
    1495:	0a0c           	movi.n	a10, 0
    1497:	4161c0        	srli	a6, a12, 1
    149a:	fec272        	addi	a7, a2, -2
    149d:	fccf92        	addi	a9, a15, -4
    14a0:	266c07        	bbci	a12, 0, 14ca <find_pitch+0x272>
    14a3:	292d           	ae_l16si.n	a2, a9, 0
    14a5:	27dd           	ae_l16si.n	a13, a7, 0
    14a7:	2129           	s32i.n	a2, a1, 8
    14a9:	400304        	ae_lp16f.i	aep0, a3, 0
    14ac:	ea039431df 	{ s32i.n	a13, a1, 12; ae_mulp24s.ll	aeq0, aep0, aep0 }
    14b1:	401504        	ae_lp16f.i	aep1, a5, 0
    14b4:	eb23ff0eef 	{ ae_trunca32q48	a14, aeq0; ae_mulp24s.ll	aeq3, aep0, aep1 }
    14b9:	992b           	addi.n	a9, a9, 2
    14bb:	36bf04        	ae_trunca32q48	a15, aeq3
    14be:	2124e0        	srai	a2, a14, 4
    14c1:	a2aa           	add.n	a10, a2, a10
    14c3:	2124f0        	srai	a2, a15, 4
    14c6:	772b           	addi.n	a7, a7, 2
    14c8:	828a           	add.n	a8, a2, a8
    14ca:	05c616        	beqz	a6, 152a <find_pitch+0x2d2>
    14cd:	032d           	mov.n	a2, a3
    14cf:	053d           	mov.n	a3, a5
    14d1:	075d           	mov.n	a5, a7
    14d3:	094d           	mov.n	a4, a9
    14d5:	0a7d           	mov.n	a7, a10
    14d7:	499676        	loopnez	a6, 1524 <find_pitch+0x2cc>
    14da:	246d           	ae_l16si.n	a6, a4, 0
    14dc:	2169           	s32i.n	a6, a1, 8
    14de:	35ad           	ae_l16si.n	a10, a5, 2
    14e0:	346d           	ae_l16si.n	a6, a4, 2
    14e2:	444b           	addi.n	a4, a4, 4
    14e4:	402204        	ae_lp16f.i	aep2, a2, 0
    14e7:	2169           	s32i.n	a6, a1, 8
    14e9:	ea4bac020f 	{ ae_lp16f.i	aep0, a2, 0; ae_mulp24s.ll	aeq0, aep2, aep2 }
    14ee:	ea03e0056e 	{ l16si	a6, a5, 0; ae_mulp24s.ll	aeq1, aep0, aep0 }
    14f3:	3169           	s32i.n	a6, a1, 12
    14f5:	368604        	ae_trunca32q48	a6, aeq0
    14f8:	369904        	ae_trunca32q48	a9, aeq1
    14fb:	554b           	addi.n	a5, a5, 4
    14fd:	216460        	srai	a6, a6, 4
    1500:	219490        	srai	a9, a9, 4
    1503:	401304        	ae_lp16f.i	aep1, a3, 0
    1506:	ea2b90667f 	{ add	a6, a6, a7; ae_mulp24s.ll	aeq0, aep2, aep1 }
    150b:	31a9           	s32i.n	a10, a1, 12
    150d:	401304        	ae_lp16f.i	aep1, a3, 0
    1510:	ea23bf0aef 	{ ae_trunca32q48	a10, aeq0; ae_mulp24s.ll	aeq0, aep0, aep1 }
    1515:	796a           	add.n	a7, a9, a6
    1517:	368604        	ae_trunca32q48	a6, aeq0
    151a:	2194a0        	srai	a9, a10, 4
    151d:	898a           	add.n	a8, a9, a8
    151f:	216460        	srai	a6, a6, 4
    1522:	868a           	add.n	a8, a6, a8

00001524 <find_pitch+0x2cc>:
    1524:	07ad           	mov.n	a10, a7
    1526:	035d           	mov.n	a5, a3
    1528:	023d           	mov.n	a3, a2

0000152a <find_pitch+0x2d2>:
    152a:	31ff80        	srai	a15, a8, 31
    152d:	5139           	s32i.n	a3, a1, 20
    152f:	416f80        	srli	a6, a8, 15
    1532:	013ff0        	slli	a3, a15, 17
    1535:	0128f0        	slli	a2, a8, 17
    1538:	336a           	add.n	a3, a3, a6
    153a:	0b7d           	mov.n	a7, a11
    153c:	000186        	j	1546 <find_pitch+0x2ee>

0000153f <find_pitch+0x2e7>:
	...

00001540 <find_pitch+0x2e8>:
    1540:	0a0c           	movi.n	a10, 0
    1542:	020c           	movi.n	a2, 0
    1544:	030c           	movi.n	a3, 0
    1546:	d168           	l32i.n	a6, a1, 52
    1548:	0a4d           	mov.n	a4, a10
    154a:	53ba60        	max	a11, a10, a6
    154d:	fabd61        	l32r	a6, 44 (19bc <HIFI_plc_sqrt>)
    1550:	5a0c           	movi.n	a10, 5
    1552:	0006e0        	callx8	a6
    1555:	c168           	l32i.n	a6, a1, 48
    1557:	580c           	movi.n	a8, 5
    1559:	c098a0        	sub	a9, a8, a10
    155c:	022767        	blt	a7, a6, 1562 <find_pitch+0x30a>
    155f:	005746        	j	16c0 <find_pitch+0x468>
    1562:	680c           	movi.n	a8, 6
    1564:	400900        	ssr	a9
    1567:	ff7c           	movi.n	a15, -1
    1569:	72ea80        	salt	a14, a10, a8
    156c:	b1c0b0        	sra	a12, a11
    156f:	4179           	s32i.n	a7, a1, 16
    1571:	4171f0        	srli	a7, a15, 1
    1574:	83c7e0        	moveqz	a12, a7, a14
    1577:	02ad           	mov.n	a10, a2
    1579:	faaf21        	l32r	a2, 38 (1aa4 <__divdi3>)
    157c:	31dfc0        	srai	a13, a12, 31
    157f:	03bd           	mov.n	a11, a3
    1581:	0002e0        	callx8	a2
    1584:	71c8           	l32i.n	a12, a1, 28
    1586:	9168           	l32i.n	a6, a1, 36
    1588:	a188           	l32i.n	a8, a1, 40
    158a:	b178           	l32i.n	a7, a1, 44
    158c:	e128           	l32i.n	a2, a1, 56
    158e:	6c6a           	add.n	a6, a12, a6
    1590:	c0e680        	sub	a14, a6, a8
    1593:	c03c80        	sub	a3, a12, a8
    1596:	902270        	addx2	a2, a2, a7
    1599:	90d370        	addx2	a13, a3, a7
    159c:	90fe70        	addx2	a15, a14, a7
    159f:	8168           	l32i.n	a6, a1, 32
    15a1:	4178           	l32i.n	a7, a1, 16
    15a3:	fec222        	addi	a2, a2, -2
    15a6:	0a9d           	mov.n	a9, a10
    15a8:	6129           	s32i.n	a2, a1, 24
    15aa:	fecd82        	addi	a8, a13, -2
    15ad:	fccfc2        	addi	a12, a15, -4
    15b0:	51b8           	l32i.n	a11, a1, 20
    15b2:	2c2d           	ae_l16si.n	a2, a12, 0
    15b4:	fec832        	addi	a3, a8, -2
    15b7:	2129           	s32i.n	a2, a1, 8
    15b9:	23dd           	ae_l16si.n	a13, a3, 0
    15bb:	400b04        	ae_lp16f.i	aep0, a11, 0
    15be:	ea039421df 	{ s32i.n	a13, a1, 8; ae_mulp24s.ll	aeq0, aep0, aep0 }
    15c3:	407b04        	ae_lp16f.i	aep7, a11, 0
    15c6:	ebffff0eef 	{ ae_trunca32q48	a14, aeq0; ae_mulp24s.ll	aeq3, aep7, aep7 }
    15cb:	f169           	s32i.n	a6, a1, 60
    15cd:	36bf04        	ae_trunca32q48	a15, aeq3
    15d0:	2124e0        	srai	a2, a14, 4
    15d3:	224a           	add.n	a2, a2, a4
    15d5:	2134f0        	srai	a3, a15, 4
    15d8:	c0a230        	sub	a10, a2, a3
    15db:	9128           	l32i.n	a2, a1, 36
    15dd:	060c           	movi.n	a6, 0
    15df:	4179           	s32i.n	a7, a1, 16
    15e1:	8199           	s32i.n	a9, a1, 32
    15e3:	7189           	s32i.n	a8, a1, 28
    15e5:	1061c2        	s32i	a12, a1, 64
    15e8:	6a12a6        	blti	a2, 1, 1656 <find_pitch+0x3fe>
    15eb:	6198           	l32i.n	a9, a1, 24
    15ed:	417120        	srli	a7, a2, 1
    15f0:	1c6207        	bbci	a2, 0, 1610 <find_pitch+0x3b8>
    15f3:	292d           	ae_l16si.n	a2, a9, 0
    15f5:	28ed           	ae_l16si.n	a14, a8, 0
    15f7:	2129           	s32i.n	a2, a1, 8
    15f9:	31e9           	s32i.n	a14, a1, 12
    15fb:	400b04        	ae_lp16f.i	aep0, a11, 0
    15fe:	401504        	ae_lp16f.i	aep1, a5, 0
    1601:	ea2380288e 	{ addi	a8, a8, 2; ae_mulp24s.ll	aeq0, aep0, aep1 }
    1606:	992b           	addi.n	a9, a9, 2
    1608:	368f04        	ae_trunca32q48	a15, aeq0
    160b:	2124f0        	srai	a2, a15, 4
    160e:	626a           	add.n	a6, a2, a6
    1610:	042716        	beqz	a7, 1656 <find_pitch+0x3fe>
    1613:	053d           	mov.n	a3, a5
    1615:	0b2d           	mov.n	a2, a11
    1617:	084d           	mov.n	a4, a8
    1619:	095d           	mov.n	a5, a9
    161b:	339776        	loopnez	a7, 1652 <find_pitch+0x3fa>
    161e:	257d           	ae_l16si.n	a7, a5, 0
    1620:	2179           	s32i.n	a7, a1, 8
    1622:	347d           	ae_l16si.n	a7, a4, 2
    1624:	358d           	ae_l16si.n	a8, a5, 2
    1626:	554b           	addi.n	a5, a5, 4
    1628:	400204        	ae_lp16f.i	aep0, a2, 0
    162b:	2189           	s32i.n	a8, a1, 8
    162d:	248d           	ae_l16si.n	a8, a4, 0
    162f:	3189           	s32i.n	a8, a1, 12
    1631:	401304        	ae_lp16f.i	aep1, a3, 0
    1634:	ea23ac120f 	{ ae_lp16f.i	aep1, a2, 0; ae_mulp24s.ll	aeq0, aep0, aep1 }
    1639:	3179           	s32i.n	a7, a1, 12
    163b:	400304        	ae_lp16f.i	aep0, a3, 0
    163e:	ea07bf08ef 	{ ae_trunca32q48	a8, aeq0; ae_mulp24s.ll	aeq0, aep1, aep0 }
    1643:	444b           	addi.n	a4, a4, 4
    1645:	368704        	ae_trunca32q48	a7, aeq0
    1648:	218480        	srai	a8, a8, 4
    164b:	686a           	add.n	a6, a8, a6
    164d:	217470        	srai	a7, a7, 4
    1650:	676a           	add.n	a6, a7, a6

00001652 <find_pitch+0x3fa>:
    1652:	035d           	mov.n	a5, a3
    1654:	02bd           	mov.n	a11, a2

00001656 <find_pitch+0x3fe>:
    1656:	d128           	l32i.n	a2, a1, 52
    1658:	0561b2        	s32i	a11, a1, 20
    165b:	204aa0        	or	a4, a10, a10
    165e:	53ba20        	max	a11, a10, a2
    1661:	fa7821        	l32r	a2, 44 (19bc <HIFI_plc_sqrt>)
    1664:	5a0c           	movi.n	a10, 5
    1666:	0002e0        	callx8	a2
    1669:	5d0c           	movi.n	a13, 5
    166b:	313f60        	srai	a3, a6, 31
    166e:	417f60        	srli	a7, a6, 15
    1671:	0126f0        	slli	a2, a6, 17
    1674:	c06da0        	sub	a6, a13, a10
    1677:	0133f0        	slli	a3, a3, 17
    167a:	400600        	ssr	a6
    167d:	ff7c           	movi.n	a15, -1
    167f:	6e0c           	movi.n	a14, 6
    1681:	337a           	add.n	a3, a3, a7
    1683:	727ae0        	salt	a7, a10, a14
    1686:	b1c0b0        	sra	a12, a11
    1689:	4161f0        	srli	a6, a15, 1
    168c:	83c670        	moveqz	a12, a6, a7
    168f:	20a220        	or	a10, a2, a2
    1692:	fa6921        	l32r	a2, 38 (1aa4 <__divdi3>)
    1695:	31dfc0        	srai	a13, a12, 31
    1698:	20b330        	or	a11, a3, a3
    169b:	0002e0        	callx8	a2
    169e:	8198           	l32i.n	a9, a1, 32
    16a0:	7188           	l32i.n	a8, a1, 28
    16a2:	1021c2        	l32i	a12, a1, 64
    16a5:	f138           	l32i.n	a3, a1, 60
    16a7:	4178           	l32i.n	a7, a1, 16
    16a9:	c1f8           	l32i.n	a15, a1, 48
    16ab:	722a90        	salt	a2, a10, a9
    16ae:	631b           	addi.n	a6, a3, 1
    16b0:	5399a0        	max	a9, a9, a10
    16b3:	882b           	addi.n	a8, a8, 2
    16b5:	cc2b           	addi.n	a12, a12, 2
    16b7:	837320        	moveqz	a7, a3, a2
    16ba:	02a3f7        	bge	a3, a15, 16c0 <find_pitch+0x468>
    16bd:	ffbbc6        	j	15b0 <find_pitch+0x358>
    16c0:	122122        	l32i	a2, a1, 72
    16c3:	c02270        	sub	a2, a2, a7
    16c6:	f01d           	retw.n

000016c8 <Q_ubitlength>:
    16c8:	004136        	entry	a1, 32
    16cb:	f37c           	movi.n	a3, -1
    16cd:	f43030        	extui	a3, a3, 0, 16
    16d0:	f47c           	movi.n	a4, -1
    16d2:	323a           	add.n	a3, a2, a3
    16d4:	114400        	slli	a4, a4, 16
    16d7:	b33220        	movgez	a3, a2, a2
    16da:	103340        	and	a3, a3, a4
    16dd:	c02230        	sub	a2, a2, a3
    16e0:	f01d           	retw.n

000016e2 <Q_ubitlength+0x1a>:
	...

000016e4 <plc_gainctrl_ini>:
    16e4:	004136        	entry	a1, 32
    16e7:	3222e2        	l32i	a14, a2, 200
    16ea:	332282        	l32i	a8, a2, 204
    16ed:	031c           	movi.n	a3, 16
    16ef:	f47c           	movi.n	a4, -1
    16f1:	fa5551        	l32r	a5, 48 (8000ffff <_end+0x8000de9b>)
    16f4:	401e00        	ssl	a14
    16f7:	236232        	s32i	a3, a2, 140
    16fa:	a13400        	sll	a3, a4
    16fd:	401800        	ssl	a8
    1700:	f67c           	movi.n	a6, -1
    1702:	a14400        	sll	a4, a4
    1705:	f46060        	extui	a6, a6, 0, 16
    1708:	303350        	xor	a3, a3, a5
    170b:	304450        	xor	a4, a4, a5
    170e:	f77c           	movi.n	a7, -1
    1710:	d36a           	add.n	a13, a3, a6
    1712:	546a           	add.n	a5, a4, a6
    1714:	117700        	slli	a7, a7, 16
    1717:	b35440        	movgez	a5, a4, a4
    171a:	b3d330        	movgez	a13, a3, a3
    171d:	3522f2        	l32i	a15, a2, 212
    1720:	10ed70        	and	a14, a13, a7
    1723:	105570        	and	a5, a5, a7
    1726:	342292        	l32i	a9, a2, 208
    1729:	2762f2        	s32i	a15, a2, 156
    172c:	3622a2        	l32i	a10, a2, 216
    172f:	3722b2        	l32i	a11, a2, 220
    1732:	3822c2        	l32i	a12, a2, 224
    1735:	c033e0        	sub	a3, a3, a14
    1738:	c0f450        	sub	a15, a4, a5
    173b:	266292        	s32i	a9, a2, 152
    173e:	2862a2        	s32i	a10, a2, 160
    1741:	2962b2        	s32i	a11, a2, 164
    1744:	2a62c2        	s32i	a12, a2, 168
    1747:	246232        	s32i	a3, a2, 144
    174a:	2562f2        	s32i	a15, a2, 148
    174d:	f01d           	retw.n

0000174f <plc_gainctrl_ini+0x6b>:
	...

00001750 <plc_gainctrl>:
    1750:	004136        	entry	a1, 32
    1753:	d568           	l32i.n	a6, a5, 52
    1755:	180c           	movi.n	a8, 1
    1757:	118800        	slli	a8, a8, 16
    175a:	d02620        	subx2	a2, a6, a2
    175d:	f77c           	movi.n	a7, -1
    175f:	628a           	add.n	a6, a2, a8
    1761:	221b           	addi.n	a2, a2, 1
    1763:	117700        	slli	a7, a7, 16
    1766:	b36220        	movgez	a6, a2, a2
    1769:	2525f2        	l32i	a15, a5, 148
    176c:	106670        	and	a6, a6, a7
    176f:	c08260        	sub	a8, a2, a6
    1772:	d589           	s32i.n	a8, a5, 52
    1774:	028f87        	bany	a15, a8, 177a <plc_gainctrl+0x2a>
    1777:	003806        	j	185b <plc_gainctrl+0x10b>
    177a:	2325b2        	l32i	a11, a5, 140
    177d:	020c           	movi.n	a2, 0
    177f:	060c           	movi.n	a6, 0
    1781:	021be6        	bgei	a11, 1, 1787 <plc_gainctrl+0x37>
    1784:	003686        	j	1862 <plc_gainctrl+0x112>
    1787:	242592        	l32i	a9, a5, 144
    178a:	fa7c           	movi.n	a10, -1
    178c:	060c           	movi.n	a6, 0
    178e:	f4a0a0        	extui	a10, a10, 0, 16
    1791:	020c           	movi.n	a2, 0
    1793:	298b76        	loop	a11, 17c0 <plc_gainctrl+0x70>
    1796:	998c           	beqz.n	a9, 17a3 <plc_gainctrl+0x53>
    1798:	0ec897        	bnall	a8, a9, 17aa <plc_gainctrl+0x5a>
    179b:	fdc222        	addi	a2, a2, -3
    179e:	061c           	movi.n	a6, 16
    17a0:	000386        	j	17b2 <plc_gainctrl+0x62>

000017a3 <plc_gainctrl+0x53>:
    17a3:	04b080        	extui	a11, a8, 0, 1
    17a6:	000186        	j	17b0 <plc_gainctrl+0x60>

000017a9 <plc_gainctrl+0x59>:
	...

000017aa <plc_gainctrl+0x5a>:
    17aa:	10b980        	and	a11, a9, a8
    17ad:	04b0b0        	extui	a11, a11, 0, 1
    17b0:	6b6a           	add.n	a6, a11, a6
    17b2:	218180        	srai	a8, a8, 1
    17b5:	b8aa           	add.n	a11, a8, a10
    17b7:	b3b880        	movgez	a11, a8, a8
    17ba:	10bb70        	and	a11, a11, a7
    17bd:	c088b0        	sub	a8, a8, a11

000017c0 <plc_gainctrl+0x70>:
    17c0:	262572        	l32i	a7, a5, 152
    17c3:	272592        	l32i	a9, a5, 156
    17c6:	2825b2        	l32i	a11, a5, 160
    17c9:	727670        	salt	a7, a6, a7
    17cc:	118710        	slli	a8, a7, 15
    17cf:	10a967        	bge	a9, a6, 17e3 <plc_gainctrl+0x93>
    17d2:	090c           	movi.n	a9, 0
    17d4:	72a6b0        	salt	a10, a6, a11
    17d7:	839ba0        	moveqz	a9, a11, a10
    17da:	c06690        	sub	a6, a6, a9
    17dd:	400600        	ssr	a6
    17e0:	918080        	srl	a8, a8

000017e3 <plc_gainctrl+0x93>:
    17e3:	7214a6        	blti	a4, 1, 1859 <plc_gainctrl+0x109>
    17e6:	102592        	l32i	a9, a5, 64
    17e9:	1a0c           	movi.n	a10, 1
    17eb:	2c0c           	movi.n	a12, 2
    17ed:	c0e890        	sub	a14, a8, a9
    17f0:	a4a0b2        	movi	a11, 164
    17f3:	72dea0        	salt	a13, a14, a10
    17f6:	7266c0        	salt	a6, a6, a12
    17f9:	a0cdb0        	addx4	a12, a13, a11
    17fc:	c5ca           	add.n	a12, a5, a12
    17fe:	0cc8           	l32i.n	a12, a12, 0
    1800:	fdc272        	addi	a7, a2, -3
    1803:	837260        	moveqz	a7, a2, a6
    1806:	2c7a           	add.n	a2, a12, a7
    1808:	0d0c           	movi.n	a13, 0
    180a:	5322d0        	max	a2, a2, a13
    180d:	23cd           	ae_l16si.n	a12, a3, 0
    180f:	400200        	ssr	a2
    1812:	b120e0        	sra	a2, a14
    1815:	f40b           	addi.n	a15, a4, -1
    1817:	929a           	add.n	a9, a2, a9
    1819:	072d           	mov.n	a2, a7
    181b:	0a4d           	mov.n	a4, a10
    181d:	0b6d           	mov.n	a6, a11
    181f:	207dd0        	or	a7, a13, a13
    1822:	20acc0        	or	a10, a12, a12
    1825:	259f76        	loopnez	a15, 184e <plc_gainctrl+0xfe>
    1828:	c0c890        	sub	a12, a8, a9
    182b:	82b9a0        	mull	a11, a9, a10
    182e:	72ac40        	salt	a10, a12, a4
    1831:	a0aa60        	addx4	a10, a10, a6
    1834:	41bfb0        	srli	a11, a11, 15
    1837:	63bd           	ae_s16i.n	a11, a3, 0
    1839:	a5aa           	add.n	a10, a5, a10
    183b:	0ab8           	l32i.n	a11, a10, 0
    183d:	332b           	addi.n	a3, a3, 2
    183f:	23ad           	ae_l16si.n	a10, a3, 0
    1841:	bb2a           	add.n	a11, a11, a2
    1843:	53bb70        	max	a11, a11, a7
    1846:	400b00        	ssr	a11
    1849:	b1b0c0        	sra	a11, a12
    184c:	9b9a           	add.n	a9, a11, a9

0000184e <plc_gainctrl+0xfe>:
    184e:	82e9a0        	mull	a14, a9, a10
    1851:	106592        	s32i	a9, a5, 64
    1854:	412fe0        	srli	a2, a14, 15
    1857:	632d           	ae_s16i.n	a2, a3, 0

00001859 <plc_gainctrl+0x109>:
    1859:	f01d           	retw.n

0000185b <plc_gainctrl+0x10b>:
    185b:	060c           	movi.n	a6, 0
    185d:	d27c           	movi.n	a2, -3
    185f:	ffd746        	j	17c0 <plc_gainctrl+0x70>

00001862 <plc_gainctrl+0x112>:
    1862:	ffd686        	j	17c0 <plc_gainctrl+0x70>

00001865 <plc_gainctrl+0x115>:
    1865:	000000                                        ...

00001868 <plcpitch_sim_init>:
    1868:	004136        	entry	a1, 32
    186b:	e50c           	movi.n	a5, 14
    186d:	f80c           	movi.n	a8, 15
    186f:	190c           	movi.n	a9, 1
    1871:	336252        	s32i	a5, a2, 204
    1874:	115920        	slli	a5, a9, 14
    1877:	356282        	s32i	a8, a2, 212
    187a:	cca2b2        	movi	a11, 0x2cc
    187d:	6c1c           	movi.n	a12, 22
    187f:	f9f331        	l32r	a3, 4c (e0008 <_end+0xddea4>)
    1882:	0fd282        	addmi	a8, a2, 0xf00
    1885:	590c           	movi.n	a9, 5
    1887:	a70c           	movi.n	a7, 10
    1889:	840c           	movi.n	a4, 8
    188b:	0a2c           	movi.n	a10, 32
    188d:	4462b2        	s32i	a11, a2, 0x110
    1890:	4d4c           	movi.n	a13, 68
    1892:	4562c2        	s32i	a12, a2, 0x114
    1895:	f9eef1        	l32r	a15, 50 (f000a <_end+0xedea6>)
    1898:	2b6832        	s32i	a3, a8, 172
    189b:	0139f0        	slli	a3, a9, 17
    189e:	99a0e2        	movi	a14, 153
    18a1:	5b0c           	movi.n	a11, 5
    18a3:	1c0c           	movi.n	a12, 1
    18a5:	1ea562        	movi	a6, 0x51e
    18a8:	326242        	s32i	a4, a2, 200
    18ab:	19de42        	addmi	a4, a14, 0x1900
    18ae:	1e0c           	movi.n	a14, 1
    18b0:	3a6252        	s32i	a5, a2, 232
    18b3:	4362a2        	s32i	a10, a2, 0x10c
    18b6:	4662d2        	s32i	a13, a2, 0x118
    18b9:	f9e7d1        	l32r	a13, 58 (10001 <_end+0xde9d>)
    18bc:	2c68f2        	s32i	a15, a8, 176
    18bf:	f9e5a1        	l32r	a10, 54 (1000a <_end+0xdea6>)
    18c2:	2d6832        	s32i	a3, a8, 180
    18c5:	113b20        	slli	a3, a11, 14
    18c8:	115c00        	slli	a5, a12, 16
    18cb:	346272        	s32i	a7, a2, 208
    18ce:	376272        	s32i	a7, a2, 220
    18d1:	386272        	s32i	a7, a2, 224
    18d4:	070c           	movi.n	a7, 0
    18d6:	486242        	s32i	a4, a2, 0x120
    18d9:	496262        	s32i	a6, a2, 0x124
    18dc:	4a6262        	s32i	a6, a2, 0x128
    18df:	366272        	s32i	a7, a2, 216
    18e2:	3c6272        	s32i	a7, a2, 240
    18e5:	4b6272        	s32i	a7, a2, 0x12c
    18e8:	2e68a2        	s32i	a10, a8, 184
    18eb:	2f6832        	s32i	a3, a8, 188
    18ee:	306852        	s32i	a5, a8, 192
    18f1:	3962e2        	s32i	a14, a2, 228
    18f4:	3b62e2        	s32i	a14, a2, 236
    18f7:	3d62e2        	s32i	a14, a2, 244
    18fa:	3e62e2        	s32i	a14, a2, 248
    18fd:	3f62e2        	s32i	a14, a2, 252
    1900:	4062e2        	s32i	a14, a2, 0x100
    1903:	4162e2        	s32i	a14, a2, 0x104
    1906:	4262e2        	s32i	a14, a2, 0x108
    1909:	4762e2        	s32i	a14, a2, 0x11c
    190c:	3168d2        	s32i	a13, a8, 196
    190f:	3268d2        	s32i	a13, a8, 200
    1912:	6658e2        	s16i	a14, a8, 204
    1915:	f01d           	retw.n

00001917 <plcpitch_sim_init+0xaf>:
	...

00001918 <plcpitch_para_init>:
    1918:	004136        	entry	a1, 32
    191b:	032c           	movi.n	a3, 32
    191d:	cca242        	movi	a4, 0x2cc
    1920:	0fd2a2        	addmi	a10, a2, 0xf00
    1923:	99a072        	movi	a7, 153
    1926:	436232        	s32i	a3, a2, 0x10c
    1929:	446242        	s32i	a4, a2, 0x110
    192c:	19d742        	addmi	a4, a7, 0x1900
    192f:	454c           	movi.n	a5, 68
    1931:	579a32        	l16si	a3, a10, 174
    1934:	6f1c           	movi.n	a15, 22
    1936:	466252        	s32i	a5, a2, 0x118
    1939:	486242        	s32i	a4, a2, 0x120
    193c:	090c           	movi.n	a9, 0
    193e:	569ab2        	l16si	a11, a10, 172
    1941:	336232        	s32i	a3, a2, 204
    1944:	599a42        	l16si	a4, a10, 178
    1947:	5b9a32        	l16si	a3, a10, 182
    194a:	4562f2        	s32i	a15, a2, 0x114
    194d:	4b6292        	s32i	a9, a2, 0x12c
    1950:	3262b2        	s32i	a11, a2, 200
    1953:	589ad2        	l16si	a13, a10, 176
    1956:	356242        	s32i	a4, a2, 212
    1959:	5a9af2        	l16si	a15, a10, 180
    195c:	376232        	s32i	a3, a2, 220
    195f:	5d9a42        	l16si	a4, a10, 186
    1962:	5f9a32        	l16si	a3, a10, 190
    1965:	0fd272        	addmi	a7, a2, 0xf00
    1968:	1ea582        	movi	a8, 0x51e
    196b:	160c           	movi.n	a6, 1
    196d:	3462d2        	s32i	a13, a2, 208
    1970:	3662f2        	s32i	a15, a2, 216
    1973:	396242        	s32i	a4, a2, 228
    1976:	3b6232        	s32i	a3, a2, 236
    1979:	619a42        	l16si	a4, a10, 194
    197c:	639a32        	l16si	a3, a10, 198
    197f:	476262        	s32i	a6, a2, 0x11c
    1982:	5c9a62        	l16si	a6, a10, 184
    1985:	609aa2        	l16si	a10, a10, 192
    1988:	3d6242        	s32i	a4, a2, 244
    198b:	6297c2        	l16si	a12, a7, 196
    198e:	3f6232        	s32i	a3, a2, 252
    1991:	6497e2        	l16si	a14, a7, 200
    1994:	659742        	l16si	a4, a7, 202
    1997:	669732        	l16si	a3, a7, 204
    199a:	496282        	s32i	a8, a2, 0x124
    199d:	4a6282        	s32i	a8, a2, 0x128
    19a0:	5e9782        	l16si	a8, a7, 188
    19a3:	386262        	s32i	a6, a2, 224
    19a6:	3a6282        	s32i	a8, a2, 232
    19a9:	3c62a2        	s32i	a10, a2, 240
    19ac:	3e62c2        	s32i	a12, a2, 248
    19af:	4062e2        	s32i	a14, a2, 0x100
    19b2:	416242        	s32i	a4, a2, 0x104
    19b5:	426232        	s32i	a3, a2, 0x108
    19b8:	f01d           	retw.n

000019ba <plcpitch_para_init+0xa2>:
	...

000019bc <HIFI_plc_sqrt>:
    19bc:	004136        	entry	a1, 32
    19bf:	4b13a6        	blti	a3, 1, 1a0e <HIFI_plc_sqrt+0x52>
    19c2:	40e340        	nsa	a4, a3
    19c5:	c02240        	sub	a2, a2, a4
    19c8:	401400        	ssl	a4
    19cb:	044020        	extui	a4, a2, 0, 1
    19ce:	a1c300        	sll	a12, a3
    19d1:	400400        	ssr	a4
    19d4:	b130c0        	sra	a3, a12
    19d7:	656930        	extui	a6, a3, 25, 7
    19da:	f9a0d1        	l32r	a13, 5c (2090 <TABLE_PLC_SQRT>)
    19dd:	050c           	movi.n	a5, 0
    19df:	f0c662        	addi	a6, a6, -16
    19e2:	535650        	max	a5, a6, a5
    19e5:	9055d0        	addx2	a5, a5, a13
    19e8:	456d           	ae_l16ui.n	a6, a5, 0
    19ea:	355d           	ae_l16si.n	a5, a5, 2
    19ec:	413930        	srli	a3, a3, 9
    19ef:	11f600        	slli	a15, a6, 16
    19f2:	c0e560        	sub	a14, a5, a6
    19f5:	300334        	ae_cvtp24a16x2.ll	aep0, a3, a3
    19f8:	113e00        	slli	a3, a14, 16
    19fb:	360f34        	ae_cvtq48a32s	aeq0, a15
    19fe:	364334        	ae_cvtq48a32s	aeq1, a3
    1a01:	d4e110242f 	{ add	a2, a4, a2; ae_mulaq32sp16u.l	aeq0, aeq1, aep0 }
    1a06:	212120        	srai	a2, a2, 1
    1a09:	368304        	ae_trunca32q48	a3, aeq0
    1a0c:	f01d           	retw.n

00001a0e <HIFI_plc_sqrt+0x52>:
    1a0e:	020c           	movi.n	a2, 0
    1a10:	030c           	movi.n	a3, 0
    1a12:	f01d           	retw.n

00001a14 <_start>:
    1a14:	004136        	entry	a1, 32
    1a17:	f99231        	l32r	a3, 60 (2160 <printf_ptr>)
    1a1a:	0228           	l32i.n	a2, a2, 0
    1a1c:	f992a1        	l32r	a10, 64 (210c <export_parameter_array+0xc>)
    1a1f:	f992b1        	l32r	a11, 68 (1918 <plcpitch_para_init>)
    1a22:	006322        	s32i	a2, a3, 0
    1a25:	0002e0        	callx8	a2
    1a28:	002322        	l32i	a2, a3, 0
    1a2b:	f990a1        	l32r	a10, 6c (2125 <export_parameter_array+0x25>)
    1a2e:	f990b1        	l32r	a11, 70 (154 <SMART_PITCH_PLC_INI>)
    1a31:	0002e0        	callx8	a2
    1a34:	002322        	l32i	a2, a3, 0
    1a37:	f98fa1        	l32r	a10, 74 (213f <export_parameter_array+0x3f>)
    1a3a:	f98fb1        	l32r	a11, 78 (3dc <SMART_PITCH_PLC_PROCESS>)
    1a3d:	0002e0        	callx8	a2
    1a40:	f98f21        	l32r	a2, 7c (2100 <export_parameter_array>)
    1a43:	f01d           	retw.n

00001a45 <_start+0x31>:
    1a45:	000000                                        ...

00001a48 <__do_global_ctors_aux>:
    1a48:	004136        	entry	a1, 32
    1a4b:	f98d31        	l32r	a3, 80 (2004 <__CTOR_END__>)
    1a4e:	fcc322        	addi	a2, a3, -4
    1a51:	0228           	l32i.n	a2, a2, 0
    1a53:	f8c332        	addi	a3, a3, -8
    1a56:	0a0226        	beqi	a2, -1, 1a64 <__do_global_ctors_aux+0x1c>

00001a59 <__do_global_ctors_aux+0x11>:
    1a59:	0002e0        	callx8	a2
    1a5c:	0328           	l32i.n	a2, a3, 0
    1a5e:	fcc332        	addi	a3, a3, -4
    1a61:	f40266        	bnei	a2, -1, 1a59 <__do_global_ctors_aux+0x11>
    1a64:	f01d           	retw.n

00001a66 <__do_global_ctors_aux+0x1e>:
	...

00001a68 <getfespeech>:
    1a68:	004136        	entry	a1, 32
    1a6b:	07ad           	mov.n	a10, a7
    1a6d:	122782        	l32i	a8, a7, 72
    1a70:	207550        	or	a7, a5, a5
    1a73:	052837        	blt	a8, a3, 1a7c <getfespeech+0x14>
    1a76:	c08830        	sub	a8, a8, a3
    1a79:	126a82        	s32i	a8, a10, 72

00001a7c <getfespeech+0x14>:
    1a7c:	1f17a6        	blti	a7, 1, 1a9f <getfespeech+0x37>
    1a7f:	050c           	movi.n	a5, 0
    1a81:	178776        	loop	a7, 1a9c <getfespeech+0x34>
    1a84:	784a           	add.n	a7, a8, a4
    1a86:	909720        	addx2	a9, a7, a2
    1a89:	037d           	mov.n	a7, a3
    1a8b:	299d           	ae_l16si.n	a9, a9, 0
    1a8d:	669d           	ae_s16i.n	a9, a6, 0
    1a8f:	662b           	addi.n	a6, a6, 2
    1a91:	881b           	addi.n	a8, a8, 1
    1a93:	729830        	salt	a9, a8, a3
    1a96:	937590        	movnez	a7, a5, a9
    1a99:	c08870        	sub	a8, a8, a7

00001a9c <getfespeech+0x34>:
    1a9c:	126a82        	s32i	a8, a10, 72

00001a9f <getfespeech+0x37>:
    1a9f:	f01d           	retw.n

00001aa1 <getfespeech+0x39>:
    1aa1:	000000                                        ...

00001aa4 <__divdi3>:
    1aa4:	004136        	entry	a1, 32
    1aa7:	090c           	movi.n	a9, 0
    1aa9:	628920        	saltu	a8, a9, a2
    1aac:	838a           	add.n	a8, a3, a8
    1aae:	607020        	neg	a7, a2
    1ab1:	316f30        	srai	a6, a3, 31
    1ab4:	608080        	neg	a8, a8
    1ab7:	0115d6        	bgez	a5, 1acc <__divdi3+0x28>
    1aba:	629940        	saltu	a9, a9, a4
    1abd:	805590        	add	a5, a5, a9
    1ac0:	ffafa2        	movi	a10, -1
    1ac3:	604040        	neg	a4, a4
    1ac6:	3066a0        	xor	a6, a6, a10
    1ac9:	605050        	neg	a5, a5

00001acc <__divdi3+0x28>:
    1acc:	b38330        	movgez	a8, a3, a3
    1acf:	a32730        	movltz	a2, a7, a3
    1ad2:	0be516        	beqz	a5, 1b94 <__divdi3+0xf0>
    1ad5:	070c           	movi.n	a7, 0
    1ad7:	090c           	movi.n	a9, 0
    1ad9:	02b857        	bgeu	a8, a5, 1adf <__divdi3+0x3b>
    1adc:	008d86        	j	1d16 <__divdi3+0x272>
    1adf:	40f590        	nsau	a9, a5
    1ae2:	1c2916        	beqz	a9, 1ca8 <__divdi3+0x204>
    1ae5:	032c           	movi.n	a3, 32
    1ae7:	401900        	ssl	a9
    1aea:	c0c390        	sub	a12, a3, a9
    1aed:	a1e500        	sll	a14, a5
    1af0:	400c00        	ssr	a12
    1af3:	91f040        	srl	a15, a4
    1af6:	401900        	ssl	a9
    1af9:	205fe0        	or	a5, a15, a14
    1afc:	a13400        	sll	a3, a4
    1aff:	400c00        	ssr	a12
    1b02:	91e080        	srl	a14, a8
    1b05:	401900        	ssl	a9
    1b08:	f5b050        	extui	a11, a5, 16, 16
    1b0b:	a18800        	sll	a8, a8
    1b0e:	400c00        	ssr	a12
    1b11:	c2ceb0        	quou	a12, a14, a11
    1b14:	91d020        	srl	a13, a2
    1b17:	82fcb0        	mull	a15, a12, a11
    1b1a:	204d80        	or	a4, a13, a8
    1b1d:	95ad           	ae_zext16	a10, a5
    1b1f:	c0fef0        	sub	a15, a14, a15
    1b22:	f5e040        	extui	a14, a4, 16, 16
    1b25:	82dca0        	mull	a13, a12, a10
    1b28:	0bffe0        	depbits	a14, a15, 16, 16
    1b2b:	0c8d           	mov.n	a8, a12
    1b2d:	401900        	ssl	a9
    1b30:	11bed7        	bgeu	a14, a13, 1b45 <__divdi3+0xa1>
    1b33:	80ee50        	add	a14, a14, a5
    1b36:	ffcc82        	addi	a8, a12, -1
    1b39:	083e57        	bltu	a14, a5, 1b45 <__divdi3+0xa1>
    1b3c:	05bed7        	bgeu	a14, a13, 1b45 <__divdi3+0xa1>
    1b3f:	fecc82        	addi	a8, a12, -2
    1b42:	80ee50        	add	a14, a14, a5
    1b45:	c0ced0        	sub	a12, a14, a13
    1b48:	c29cb0        	quou	a9, a12, a11
    1b4b:	82b9b0        	mull	a11, a9, a11
    1b4e:	82a9a0        	mull	a10, a9, a10
    1b51:	c0bcb0        	sub	a11, a12, a11
    1b54:	0bfb40        	depbits	a4, a11, 16, 16
    1b57:	09bd           	mov.n	a11, a9
    1b59:	0fb4a7        	bgeu	a4, a10, 1b6c <__divdi3+0xc8>
    1b5c:	445a           	add.n	a4, a4, a5
    1b5e:	b90b           	addi.n	a11, a9, -1
    1b60:	083457        	bltu	a4, a5, 1b6c <__divdi3+0xc8>
    1b63:	05b4a7        	bgeu	a4, a10, 1b6c <__divdi3+0xc8>
    1b66:	fec9b2        	addi	a11, a9, -2
    1b69:	804450        	add	a4, a4, a5
    1b6c:	115800        	slli	a5, a8, 16
    1b6f:	209b50        	or	a9, a11, a5
    1b72:	a25930        	muluh	a5, a9, a3
    1b75:	c044a0        	sub	a4, a4, a10
    1b78:	113457        	bltu	a4, a5, 1b8d <__divdi3+0xe9>
    1b7b:	823930        	mull	a3, a9, a3
    1b7e:	a12200        	sll	a2, a2
    1b81:	023237        	bltu	a2, a3, 1b87 <__divdi3+0xe3>
    1b84:	006386        	j	1d16 <__divdi3+0x272>
    1b87:	021457        	beq	a4, a5, 1b8d <__divdi3+0xe9>
    1b8a:	006206        	j	1d16 <__divdi3+0x272>
    1b8d:	990b           	addi.n	a9, a9, -1
    1b8f:	0060c6        	j	1d16 <__divdi3+0x272>

00001b92 <__divdi3+0xee>:
	...

00001b94 <__divdi3+0xf0>:
    1b94:	40f450        	nsau	a5, a4
    1b97:	7eb847        	bgeu	a8, a4, 1c19 <__divdi3+0x175>
    1b9a:	b59c           	beqz.n	a5, 1bb9 <__divdi3+0x115>
    1b9c:	032c           	movi.n	a3, 32
    1b9e:	401500        	ssl	a5
    1ba1:	c03350        	sub	a3, a3, a5
    1ba4:	a14400        	sll	a4, a4
    1ba7:	a17800        	sll	a7, a8
    1baa:	400300        	ssr	a3
    1bad:	913020        	srl	a3, a2
    1bb0:	401500        	ssl	a5
    1bb3:	208370        	or	a8, a3, a7
    1bb6:	a12200        	sll	a2, a2
    1bb9:	f57040        	extui	a7, a4, 16, 16
    1bbc:	c29870        	quou	a9, a8, a7
    1bbf:	823970        	mull	a3, a9, a7
    1bc2:	945d           	ae_zext16	a5, a4
    1bc4:	c03830        	sub	a3, a8, a3
    1bc7:	f5a020        	extui	a10, a2, 16, 16
    1bca:	828950        	mull	a8, a9, a5
    1bcd:	0bf3a0        	depbits	a10, a3, 16, 16
    1bd0:	093d           	mov.n	a3, a9
    1bd2:	0fba87        	bgeu	a10, a8, 1be5 <__divdi3+0x141>
    1bd5:	aa4a           	add.n	a10, a10, a4
    1bd7:	390b           	addi.n	a3, a9, -1
    1bd9:	083a47        	bltu	a10, a4, 1be5 <__divdi3+0x141>
    1bdc:	05ba87        	bgeu	a10, a8, 1be5 <__divdi3+0x141>
    1bdf:	fec932        	addi	a3, a9, -2
    1be2:	80aa40        	add	a10, a10, a4
    1be5:	c09a80        	sub	a9, a10, a8
    1be8:	c28970        	quou	a8, a9, a7
    1beb:	827870        	mull	a7, a8, a7
    1bee:	825850        	mull	a5, a8, a5
    1bf1:	c07970        	sub	a7, a9, a7
    1bf4:	0bf720        	depbits	a2, a7, 16, 16
    1bf7:	11b257        	bgeu	a2, a5, 1c0c <__divdi3+0x168>
    1bfa:	224a           	add.n	a2, a2, a4
    1bfc:	624240        	saltu	a4, a2, a4
    1bff:	622250        	saltu	a2, a2, a5
    1c02:	ff7c           	movi.n	a15, -1
    1c04:	c02f20        	sub	a2, a15, a2
    1c07:	932f40        	movnez	a2, a15, a4
    1c0a:	828a           	add.n	a8, a2, a8
    1c0c:	112300        	slli	a2, a3, 16
    1c0f:	209820        	or	a9, a8, a2
    1c12:	070c           	movi.n	a7, 0
    1c14:	003f86        	j	1d16 <__divdi3+0x272>

00001c17 <__divdi3+0x173>:
	...

00001c19 <__divdi3+0x175>:
    1c19:	09c516        	beqz	a5, 1cb9 <__divdi3+0x215>
    1c1c:	032c           	movi.n	a3, 32
    1c1e:	401500        	ssl	a5
    1c21:	c0a350        	sub	a10, a3, a5
    1c24:	a14400        	sll	a4, a4
    1c27:	400a00        	ssr	a10
    1c2a:	91b080        	srl	a11, a8
    1c2d:	401500        	ssl	a5
    1c30:	f53040        	extui	a3, a4, 16, 16
    1c33:	e77c           	movi.n	a7, -2
    1c35:	a1e800        	sll	a14, a8
    1c38:	400a00        	ssr	a10
    1c3b:	c2ab30        	quou	a10, a11, a3
    1c3e:	82ca30        	mull	a12, a10, a3
    1c41:	f47070        	extui	a7, a7, 0, 16
    1c44:	91f020        	srl	a15, a2
    1c47:	109470        	and	a9, a4, a7
    1c4a:	207fe0        	or	a7, a15, a14
    1c4d:	c0cbc0        	sub	a12, a11, a12
    1c50:	f5b070        	extui	a11, a7, 16, 16
    1c53:	828a90        	mull	a8, a10, a9
    1c56:	0bfcb0        	depbits	a11, a12, 16, 16
    1c59:	401500        	ssl	a5
    1c5c:	0a5d           	mov.n	a5, a10
    1c5e:	0ebb87        	bgeu	a11, a8, 1c70 <__divdi3+0x1cc>
    1c61:	bb4a           	add.n	a11, a11, a4
    1c63:	5a0b           	addi.n	a5, a10, -1
    1c65:	073b47        	bltu	a11, a4, 1c70 <__divdi3+0x1cc>
    1c68:	04bb87        	bgeu	a11, a8, 1c70 <__divdi3+0x1cc>
    1c6b:	feca52        	addi	a5, a10, -2
    1c6e:	bb4a           	add.n	a11, a11, a4
    1c70:	c0bb80        	sub	a11, a11, a8
    1c73:	c2ab30        	quou	a10, a11, a3
    1c76:	82ca30        	mull	a12, a10, a3
    1c79:	828a90        	mull	a8, a10, a9
    1c7c:	c0fbc0        	sub	a15, a11, a12
    1c7f:	0bff70        	depbits	a7, a15, 16, 16
    1c82:	0a9d           	mov.n	a9, a10
    1c84:	10b787        	bgeu	a7, a8, 1c98 <__divdi3+0x1f4>
    1c87:	774a           	add.n	a7, a7, a4
    1c89:	ffca92        	addi	a9, a10, -1
    1c8c:	083747        	bltu	a7, a4, 1c98 <__divdi3+0x1f4>
    1c8f:	05b787        	bgeu	a7, a8, 1c98 <__divdi3+0x1f4>
    1c92:	feca92        	addi	a9, a10, -2
    1c95:	807740        	add	a7, a7, a4
    1c98:	115500        	slli	a5, a5, 16
    1c9b:	c0b780        	sub	a11, a7, a8
    1c9e:	a12200        	sll	a2, a2
    1ca1:	207950        	or	a7, a9, a5
    1ca4:	000646        	j	1cc1 <__divdi3+0x21d>

00001ca7 <__divdi3+0x203>:
	...

00001ca8 <__divdi3+0x204>:
    1ca8:	622240        	saltu	a2, a2, a4
    1cab:	1f0c           	movi.n	a15, 1
    1cad:	623580        	saltu	a3, a5, a8
    1cb0:	3022f0        	xor	a2, a2, a15
    1cb3:	209320        	or	a9, a3, a2
    1cb6:	001706        	j	1d16 <__divdi3+0x272>

00001cb9 <__divdi3+0x215>:
    1cb9:	c0b840        	sub	a11, a8, a4
    1cbc:	f53040        	extui	a3, a4, 16, 16
    1cbf:	170c           	movi.n	a7, 1
    1cc1:	c29b30        	quou	a9, a11, a3
    1cc4:	825930        	mull	a5, a9, a3
    1cc7:	948d           	ae_zext16	a8, a4
    1cc9:	c05b50        	sub	a5, a11, a5
    1ccc:	f5a020        	extui	a10, a2, 16, 16
    1ccf:	82b980        	mull	a11, a9, a8
    1cd2:	0bf5a0        	depbits	a10, a5, 16, 16
    1cd5:	095d           	mov.n	a5, a9
    1cd7:	0ebab7        	bgeu	a10, a11, 1ce9 <__divdi3+0x245>
    1cda:	aa4a           	add.n	a10, a10, a4
    1cdc:	590b           	addi.n	a5, a9, -1
    1cde:	073a47        	bltu	a10, a4, 1ce9 <__divdi3+0x245>
    1ce1:	04bab7        	bgeu	a10, a11, 1ce9 <__divdi3+0x245>
    1ce4:	fec952        	addi	a5, a9, -2
    1ce7:	aa4a           	add.n	a10, a10, a4
    1ce9:	c0aab0        	sub	a10, a10, a11
    1cec:	c29a30        	quou	a9, a10, a3
    1cef:	82e930        	mull	a14, a9, a3
    1cf2:	823980        	mull	a3, a9, a8
    1cf5:	c0fae0        	sub	a15, a10, a14
    1cf8:	0bff20        	depbits	a2, a15, 16, 16
    1cfb:	11b237        	bgeu	a2, a3, 1d10 <__divdi3+0x26c>
    1cfe:	224a           	add.n	a2, a2, a4
    1d00:	624240        	saltu	a4, a2, a4
    1d03:	622230        	saltu	a2, a2, a3
    1d06:	ff7c           	movi.n	a15, -1
    1d08:	c02f20        	sub	a2, a15, a2
    1d0b:	932f40        	movnez	a2, a15, a4
    1d0e:	929a           	add.n	a9, a2, a9
    1d10:	112500        	slli	a2, a5, 16
    1d13:	209920        	or	a9, a9, a2
    1d16:	030c           	movi.n	a3, 0
    1d18:	623390        	saltu	a3, a3, a9
    1d1b:	373a           	add.n	a3, a7, a3
    1d1d:	602090        	neg	a2, a9
    1d20:	603030        	neg	a3, a3
    1d23:	832960        	moveqz	a2, a9, a6
    1d26:	833760        	moveqz	a3, a7, a6
    1d29:	f01d           	retw.n

00001d2b <__divdi3+0x287>:
	...

00001d2c <_fini>:
    1d2c:	008136        	entry	a1, 64
    1d2f:	f8d581        	l32r	a8, 84 (a0 <__do_global_dtors_aux>)
    1d32:	f03d           	nop.n
    1d34:	0008e0        	callx8	a8

00001d37 <_fini+0xb>:
    1d37:	f01d           	retw.n
