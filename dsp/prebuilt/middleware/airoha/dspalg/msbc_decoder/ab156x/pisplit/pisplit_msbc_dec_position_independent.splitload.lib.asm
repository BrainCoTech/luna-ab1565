
Build/lib/pisplit_msbc_dec_position_independent.splitload.lib:     file format elf32-xtensa-le


Disassembly of section .text:

00000000 <_init-0x88>:
       0:	000000d4 0000168c 000019cc 00000000     ................
      10:	00001990 00000000 000019b4 01503205     .............2P.
      20:	000028a0 000008a8 00000c60 00001040     .(......`...@...
      30:	00001280 000029c0 000029a0 00001a40     .....)...)..@...
      40:	00001a90 00001e50 00001b50 000021c0     ....P...P....!..
      50:	00002a7c 00002a08 00001634 00002a1c     |*...*..4....*..
      60:	00001460 00002a00 000003bc 00010008     `....*..........
      70:	00780008 00000254 00000150 0000086c     ..x.T...P...l...
      80:	00001998 000000a0                       ........

00000088 <_init>:
      88:	008136        	entry	a1, 64
      8b:	ffdd81        	l32r	a8, 0 (d4 <frame_dummy>)
      8e:	f03d           	nop.n
      90:	0008e0        	callx8	a8
      93:	ffdc81        	l32r	a8, 4 (168c <__do_global_ctors_aux>)
      96:	f03d           	nop.n
      98:	0008e0        	callx8	a8
      9b:	f01d           	retw.n

0000009d <_init+0x15>:
      9d:	000000                                        ...

000000a0 <__do_global_dtors_aux>:
      a0:	004136        	entry	a1, 32
      a3:	ffd921        	l32r	a2, 8 (19cc <__do_global_dtors_aux.completed>)
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
      bf:	ffd4a1        	l32r	a10, 10 (1990 <__FRAME_END__>)
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
      da:	ffcda1        	l32r	a10, 10 (1990 <__FRAME_END__>)
      dd:	ffceb1        	l32r	a11, 18 (19b4 <frame_dummy.object>)
      e0:	428c           	beqz.n	a2, e8 <frame_dummy+0x14>
      e2:	ffcc81        	l32r	a8, 14 (0 <_text_start>)
      e5:	0008e0        	callx8	a8

000000e8 <frame_dummy+0x14>:
      e8:	f01d           	retw.n

000000ea <frame_dummy+0x16>:
      ea:	00000000                                 ......

000000f0 <get_SBC_version>:
      f0:	004136        	entry	a1, 32
      f3:	ffca21        	l32r	a2, 1c (1503205 <_end+0x1500785>)
      f6:	f01d           	retw.n

000000f8 <memset>:
      f8:	004136        	entry	a1, 32
      fb:	025d           	mov.n	a5, a2
      fd:	729c           	beqz.n	a2, 118 <memset+0x20>
      ff:	549c           	beqz.n	a4, 118 <memset+0x20>
     101:	052d           	mov.n	a2, a5
     103:	416140        	srli	a6, a4, 1
     106:	036407        	bbci	a4, 0, 10d <memset+0x15>
     109:	623d           	ae_s16i.n	a3, a2, 0
     10b:	222b           	addi.n	a2, a2, 2

0000010d <memset+0x15>:
     10d:	768c           	beqz.n	a6, 118 <memset+0x20>
     10f:	059676        	loopnez	a6, 118 <memset+0x20>
     112:	623d           	ae_s16i.n	a3, a2, 0
     114:	723d           	ae_s16i.n	a3, a2, 2
     116:	224b           	addi.n	a2, a2, 4

00000118 <memset+0x20>:
     118:	052d           	mov.n	a2, a5
     11a:	f01d           	retw.n

0000011c <sbc_init>:
     11c:	004136        	entry	a1, 32
     11f:	024d           	mov.n	a4, a2
     121:	529c           	beqz.n	a2, 13a <sbc_init+0x1e>
     123:	03a252        	movi	a5, 0x203
     126:	1155e0        	slli	a5, a5, 2
     129:	415150        	srli	a5, a5, 1
     12c:	020c           	movi.n	a2, 0
     12e:	203440        	or	a3, a4, a4
     131:	059576        	loopnez	a5, 13a <sbc_init+0x1e>
     134:	632d           	ae_s16i.n	a2, a3, 0
     136:	732d           	ae_s16i.n	a2, a3, 2
     138:	334b           	addi.n	a3, a3, 4

0000013a <sbc_init+0x1e>:
     13a:	04d422        	addmi	a2, a4, 0x400
     13d:	00a232        	movi	a3, 0x200
     140:	10d4e2        	addmi	a14, a4, 0x1000
     143:	0f0c           	movi.n	a15, 0
     145:	4c5232        	s16i	a3, a2, 152
     148:	085ef2        	s16i	a15, a14, 16
     14b:	f01d           	retw.n

0000014d <sbc_init+0x31>:
     14d:	000000                                        ...

00000150 <sbc_crc8>:
     150:	004136        	entry	a1, 32
     153:	426d           	ae_l16ui.n	a6, a2, 0
     155:	024d           	mov.n	a4, a2
     157:	037d           	mov.n	a7, a3
     159:	f20c           	movi.n	a2, 15
     15b:	2e83a6        	blti	a3, 8, 18d <sbc_crc8+0x3d>
     15e:	ffb031        	l32r	a3, 20 (28a0 <SBC_crc_table>)
     161:	218370        	srai	a8, a7, 3
     164:	542b           	addi.n	a5, a4, 2
     166:	f20c           	movi.n	a2, 15
     168:	064d           	mov.n	a4, a6
     16a:	1d8876        	loop	a8, 18b <sbc_crc8+0x3b>
     16d:	306420        	xor	a6, a4, a2
     170:	454d           	ae_l16ui.n	a4, a5, 0
     172:	552b           	addi.n	a5, a5, 2
     174:	042060        	extui	a2, a6, 0, 1
     177:	416160        	srli	a6, a6, 1
     17a:	906630        	addx2	a6, a6, a3
     17d:	466d           	ae_l16ui.n	a6, a6, 0
     17f:	1122d0        	slli	a2, a2, 3
     182:	400200        	ssr	a2
     185:	912060        	srl	a2, a6
     188:	742020        	extui	a2, a2, 0, 8

0000018b <sbc_crc8+0x3b>:
     18b:	046d           	mov.n	a6, a4

0000018d <sbc_crc8+0x3d>:
     18d:	730c           	movi.n	a3, 7
     18f:	210377        	bnone	a3, a7, 1b4 <sbc_crc8+0x64>
     192:	245070        	extui	a5, a7, 0, 3
     195:	d31c           	movi.n	a3, 29
     197:	064d           	mov.n	a4, a6
     199:	178576        	loop	a5, 1b4 <sbc_crc8+0x64>
     19c:	305240        	xor	a5, a2, a4
     19f:	015580        	slli	a5, a5, 24
     1a2:	1144f0        	slli	a4, a4, 1
     1a5:	642020        	extui	a2, a2, 0, 7
     1a8:	1122f0        	slli	a2, a2, 1
     1ab:	315f50        	srai	a5, a5, 31
     1ae:	105530        	and	a5, a5, a3
     1b1:	302520        	xor	a2, a5, a2
     1b4:	f01d           	retw.n

000001b6 <sbc_crc8+0x66>:
	...

000001b8 <sbc_extract_scale_factors_joint_ch4>:
     1b8:	004136        	entry	a1, 32
     1bb:	02cd           	mov.n	a12, a2
     1bd:	1a12f2        	l16ui	a15, a2, 52
     1c0:	70c2e2        	addi	a14, a2, 112
     1c3:	ff2e62        	l32i	a6, a14, 0x3fc
     1c6:	41d1f0        	srli	a13, a15, 1
     1c9:	077d16        	beqz	a13, 244 <sbc_extract_scale_factors_joint_ch4+0x8c>
     1cc:	38cc52        	addi	a5, a12, 56
     1cf:	18cc42        	addi	a4, a12, 24
     1d2:	830c           	movi.n	a3, 8
     1d4:	4121d0        	srli	a2, a13, 1
     1d7:	226d07        	bbci	a13, 0, 1fd <sbc_extract_scale_factors_joint_ch4+0x45>
     1da:	037734        	ae_lb	a7, a3
     1dd:	fec482        	addi	a8, a4, -2
     1e0:	1c1634        	ae_db	a6, a3
     1e3:	349470        	extui	a9, a7, 4, 4
     1e6:	347070        	extui	a7, a7, 0, 4
     1e9:	659d           	ae_s16i.n	a9, a5, 0
     1eb:	757d           	ae_s16i.n	a7, a5, 2
     1ed:	28ad           	ae_l16si.n	a10, a8, 0
     1ef:	1177c0        	slli	a7, a7, 4
     1f2:	554b           	addi.n	a5, a5, 4
     1f4:	209a90        	or	a9, a10, a9
     1f7:	689d           	ae_s16i.n	a9, a8, 0
     1f9:	647d           	ae_s16i.n	a7, a4, 0
     1fb:	442b           	addi.n	a4, a4, 2

000001fd <sbc_extract_scale_factors_joint_ch4+0x45>:
     1fd:	043216        	beqz	a2, 244 <sbc_extract_scale_factors_joint_ch4+0x8c>
     200:	409276        	loopnez	a2, 244 <sbc_extract_scale_factors_joint_ch4+0x8c>
     203:	038734        	ae_lb	a8, a3
     206:	fec422        	addi	a2, a4, -2
     209:	754b           	addi.n	a7, a5, 4
     20b:	1c1634        	ae_db	a6, a3
     20e:	349080        	extui	a9, a8, 0, 4
     211:	759d           	ae_s16i.n	a9, a5, 2
     213:	348480        	extui	a8, a8, 4, 4
     216:	658d           	ae_s16i.n	a8, a5, 0
     218:	22ad           	ae_l16si.n	a10, a2, 0
     21a:	03b734        	ae_lb	a11, a3
     21d:	574b           	addi.n	a5, a7, 4
     21f:	208a80        	or	a8, a10, a8
     222:	34a0b0        	extui	a10, a11, 0, 4
     225:	1199c0        	slli	a9, a9, 4
     228:	649d           	ae_s16i.n	a9, a4, 0
     22a:	3494b0        	extui	a9, a11, 4, 4
     22d:	11bac0        	slli	a11, a10, 4
     230:	628d           	ae_s16i.n	a8, a2, 0
     232:	1c1634        	ae_db	a6, a3
     235:	77ad           	ae_s16i.n	a10, a7, 2
     237:	679d           	ae_s16i.n	a9, a7, 0
     239:	327d           	ae_l16si.n	a7, a2, 2
     23b:	74bd           	ae_s16i.n	a11, a4, 2
     23d:	444b           	addi.n	a4, a4, 4
     23f:	207790        	or	a7, a7, a9
     242:	727d           	ae_s16i.n	a7, a2, 2

00000244 <sbc_extract_scale_factors_joint_ch4+0x8c>:
     244:	421c           	movi.n	a2, 20
     246:	b02d20        	addx8	a2, a13, a2
     249:	ff6e62        	s32i	a6, a14, 0x3fc
     24c:	155c22        	s16i	a2, a12, 42
     24f:	f01d           	retw.n

00000251 <sbc_extract_scale_factors_joint_ch4+0x99>:
     251:	000000                                        ...

00000254 <sbc_extract_scale_factors_joint_ch8_non>:
     254:	004136        	entry	a1, 32
     257:	02ad           	mov.n	a10, a2
     259:	1a12f2        	l16ui	a15, a2, 52
     25c:	70c2c2        	addi	a12, a2, 112
     25f:	ff2c52        	l32i	a5, a12, 0x3fc
     262:	41d1f0        	srli	a13, a15, 1
     265:	03bd           	mov.n	a11, a3
     267:	057d16        	beqz	a13, 2c2 <sbc_extract_scale_factors_joint_ch8_non+0x6e>
     26a:	903ba0        	addx2	a3, a11, a10
     26d:	38ca42        	addi	a4, a10, 56
     270:	820c           	movi.n	a2, 8
     272:	4161d0        	srli	a6, a13, 1
     275:	12c332        	addi	a3, a3, 18
     278:	176d07        	bbci	a13, 0, 293 <sbc_extract_scale_factors_joint_ch8_non+0x3f>
     27b:	037724        	ae_lb	a7, a2
     27e:	1c1524        	ae_db	a5, a2
     281:	348470        	extui	a8, a7, 4, 4
     284:	349070        	extui	a9, a7, 0, 4
     287:	648d           	ae_s16i.n	a8, a4, 0
     289:	749d           	ae_s16i.n	a9, a4, 2
     28b:	637d           	ae_s16i.n	a7, a3, 0
     28d:	02c332        	addi	a3, a3, 2
     290:	04c442        	addi	a4, a4, 4

00000293 <sbc_extract_scale_factors_joint_ch8_non+0x3f>:
     293:	b6ac           	beqz.n	a6, 2c2 <sbc_extract_scale_factors_joint_ch8_non+0x6e>
     295:	299676        	loopnez	a6, 2c2 <sbc_extract_scale_factors_joint_ch8_non+0x6e>
     298:	039724        	ae_lb	a9, a2
     29b:	644b           	addi.n	a6, a4, 4
     29d:	1c1524        	ae_db	a5, a2
     2a0:	347090        	extui	a7, a9, 0, 4
     2a3:	348490        	extui	a8, a9, 4, 4
     2a6:	648d           	ae_s16i.n	a8, a4, 0
     2a8:	747d           	ae_s16i.n	a7, a4, 2
     2aa:	464b           	addi.n	a4, a6, 4
     2ac:	037724        	ae_lb	a7, a2
     2af:	639d           	ae_s16i.n	a9, a3, 0
     2b1:	1c1524        	ae_db	a5, a2
     2b4:	348070        	extui	a8, a7, 0, 4
     2b7:	768d           	ae_s16i.n	a8, a6, 2
     2b9:	348470        	extui	a8, a7, 4, 4
     2bc:	668d           	ae_s16i.n	a8, a6, 0
     2be:	737d           	ae_s16i.n	a7, a3, 2
     2c0:	334b           	addi.n	a3, a3, 4

000002c2 <sbc_extract_scale_factors_joint_ch8_non+0x6e>:
     2c2:	2dba           	add.n	a2, a13, a11
     2c4:	1122d0        	slli	a2, a2, 3
     2c7:	ff6c52        	s32i	a5, a12, 0x3fc
     2ca:	155a22        	s16i	a2, a10, 42
     2cd:	f01d           	retw.n

000002cf <sbc_extract_scale_factors_joint_ch8_non+0x7b>:
	...

000002d0 <sbc_get_frame_length>:
     2d0:	004136        	entry	a1, 32
     2d3:	04d222        	addmi	a2, a2, 0x400
     2d6:	4c1222        	l16ui	a2, a2, 152
     2d9:	f01d           	retw.n

000002db <sbc_get_frame_length+0xb>:
	...

000002dc <sbc_get_sample_freq>:
     2dc:	004136        	entry	a1, 32
     2df:	021222        	l16ui	a2, a2, 4
     2e2:	f01d           	retw.n

000002e4 <sbc_frame_header_decode>:
     2e4:	004136        	entry	a1, 32
     2e7:	0cd342        	addmi	a4, a3, 0xc00
     2ea:	3478           	l32i.n	a7, a4, 12
     2ec:	050c           	movi.n	a5, 0
     2ee:	625d           	ae_s16i.n	a5, a2, 0
     2f0:	9ca062        	movi	a6, 156
     2f3:	271b           	addi.n	a2, a7, 1
     2f5:	0d8076        	loop	a0, 306 <sbc_frame_header_decode+0x22>
     2f8:	025d           	mov.n	a5, a2
     2fa:	f20b           	addi.n	a15, a2, -1
     2fc:	3429           	s32i.n	a2, a4, 12
     2fe:	000f72        	l8ui	a7, a15, 0
     301:	221b           	addi.n	a2, a2, 1
     303:	021767        	beq	a7, a6, 309 <sbc_frame_header_decode+0x25>

00000306 <sbc_frame_header_decode+0x22>:
     306:	fffac6        	j	2f5 <sbc_frame_header_decode+0x11>

00000309 <sbc_frame_header_decode+0x25>:
     309:	3429           	s32i.n	a2, a4, 12
     30b:	720b           	addi.n	a7, a2, -1
     30d:	000772        	l8ui	a7, a7, 0
     310:	c80c           	movi.n	a8, 12
     312:	290c           	movi.n	a9, 2
     314:	04d070        	extui	a13, a7, 0, 1
     317:	41b270        	srli	a11, a7, 2
     31a:	41f670        	srli	a15, a7, 6
     31d:	04c170        	extui	a12, a7, 1, 1
     320:	095372        	s16i	a7, a3, 18
     323:	017740        	slli	a7, a7, 28
     326:	108b80        	and	a8, a11, a8
     329:	14b0b0        	extui	a11, a11, 0, 2
     32c:	160c           	movi.n	a6, 1
     32e:	11dde0        	slli	a13, a13, 2
     331:	a21b           	addi.n	a10, a2, 1
     333:	31ee70        	srai	a14, a7, 30
     336:	784b           	addi.n	a7, a8, 4
     338:	9369b0        	movnez	a6, a9, a11
     33b:	8d4b           	addi.n	a8, a13, 4
     33d:	34a9           	s32i.n	a10, a4, 12
     33f:	0253f2        	s16i	a15, a3, 4
     342:	d1a680        	mul16s	a10, a6, a8
     345:	0553c2        	s16i	a12, a3, 10
     348:	0453b2        	s16i	a11, a3, 8
     34b:	035372        	s16i	a7, a3, 6
     34e:	075362        	s16i	a6, a3, 14
     351:	065382        	s16i	a8, a3, 12
     354:	0105c2        	l8ui	a12, a5, 1
     357:	41f1a0        	srli	a15, a10, 1
     35a:	9f4b           	addi.n	a9, a15, 4
     35c:	0853c2        	s16i	a12, a3, 16
     35f:	0a53c2        	s16i	a12, a3, 20
     362:	00ae96        	bltz	a14, 370 <sbc_frame_header_decode+0x8c>
     365:	d16670        	mul16s	a6, a6, a7
     368:	d166c0        	mul16s	a6, a6, a12
     36b:	000246        	j	378 <sbc_frame_header_decode+0x94>

0000036e <sbc_frame_header_decode+0x8a>:
	...

00000370 <sbc_frame_header_decode+0x8c>:
     370:	d16c70        	mul16s	a6, a12, a7
     373:	012b26        	beqi	a11, 2, 378 <sbc_frame_header_decode+0x94>
     376:	686a           	add.n	a6, a8, a6
     378:	667b           	addi.n	a6, a6, 7
     37a:	416360        	srli	a6, a6, 3
     37d:	b22b           	addi.n	a11, a2, 2
     37f:	d1da70        	mul16s	a13, a10, a7
     382:	d1e870        	mul16s	a14, a8, a7
     385:	04d3f2        	addmi	a15, a3, 0x400
     388:	669a           	add.n	a6, a6, a9
     38a:	1a53a2        	s16i	a10, a3, 52
     38d:	1b53d2        	s16i	a13, a3, 54
     390:	1853e2        	s16i	a14, a3, 48
     393:	34b9           	s32i.n	a11, a4, 12
     395:	4c5f62        	s16i	a6, a15, 152
     398:	020542        	l8ui	a4, a5, 2
     39b:	020c           	movi.n	a2, 0
     39d:	165342        	s16i	a4, a3, 44
     3a0:	f01d           	retw.n

000003a2 <sbc_frame_header_decode+0xbe>:
	...

000003a4 <change_endian16x>:
     3a4:	004136        	entry	a1, 32
     3a7:	ffa032        	movi	a3, 255
     3aa:	113300        	slli	a3, a3, 16
     3ad:	114280        	slli	a4, a2, 8
     3b0:	103430        	and	a3, a4, a3
     3b3:	8b7230        	depbits	a3, a2, 24, 8
     3b6:	312030        	srai	a2, a3, 16
     3b9:	f01d           	retw.n

000003bb <change_endian16x+0x17>:
	...

000003bc <SBC_decode_preload>:
     3bc:	004136        	entry	a1, 32
     3bf:	0cd2f2        	addmi	a15, a2, 0xc00
     3c2:	3f98           	l32i.n	a9, a15, 12
     3c4:	028d           	mov.n	a8, a2
     3c6:	430c           	movi.n	a3, 4
     3c8:	042090        	extui	a2, a9, 0, 1
     3cb:	c0b320        	sub	a11, a3, a2
     3ce:	11a2d0        	slli	a10, a2, 3
     3d1:	04bb16        	beqz	a11, 420 <SBC_decode_preload+0x64>
     3d4:	fcc222        	addi	a2, a2, -4
     3d7:	602020        	neg	a2, a2
     3da:	144020        	extui	a4, a2, 0, 2
     3dd:	070c           	movi.n	a7, 0
     3df:	203990        	or	a3, a9, a9
     3e2:	412220        	srli	a2, a2, 2
     3e5:	099476        	loopnez	a4, 3f2 <SBC_decode_preload+0x36>
     3e8:	000342        	l8ui	a4, a3, 0
     3eb:	115780        	slli	a5, a7, 8
     3ee:	331b           	addi.n	a3, a3, 1
     3f0:	754a           	add.n	a7, a5, a4

000003f2 <SBC_decode_preload+0x36>:
     3f2:	52ac           	beqz.n	a2, 41b <SBC_decode_preload+0x5f>
     3f4:	f03d           	nop.n
     3f6:	219276        	loopnez	a2, 41b <SBC_decode_preload+0x5f>
     3f9:	000362        	l8ui	a6, a3, 0
     3fc:	030322        	l8ui	a2, a3, 3
     3ff:	020342        	l8ui	a4, a3, 2
     402:	010352        	l8ui	a5, a3, 1
     405:	334b           	addi.n	a3, a3, 4
     407:	117780        	slli	a7, a7, 8
     40a:	676a           	add.n	a6, a7, a6
     40c:	116680        	slli	a6, a6, 8
     40f:	565a           	add.n	a5, a6, a5
     411:	115580        	slli	a5, a5, 8
     414:	454a           	add.n	a4, a5, a4
     416:	114480        	slli	a4, a4, 8
     419:	742a           	add.n	a7, a4, a2

0000041b <SBC_decode_preload+0x5f>:
     41b:	99ba           	add.n	a9, a9, a11
     41d:	000046        	j	422 <SBC_decode_preload+0x66>

00000420 <SBC_decode_preload+0x64>:
     420:	070c           	movi.n	a7, 0
     422:	fec922        	addi	a2, a9, -2
     425:	70c832        	addi	a3, a8, 112
     428:	0326a4        	wur.ae_bitptr	a10
     42b:	f3f170        	wur.ae_bithead	a7
     42e:	ff6322        	s32i	a2, a3, 0x3fc
     431:	f01d           	retw.n

00000433 <SBC_decode_preload+0x77>:
	...

00000434 <sbc_frame_decode>:
     434:	006136        	entry	a1, 48
     437:	0cd2f2        	addmi	a15, a2, 0xc00
     43a:	3f88           	l32i.n	a8, a15, 12
     43c:	02ed           	mov.n	a14, a2
     43e:	4c0c           	movi.n	a12, 4
     440:	042080        	extui	a2, a8, 0, 1
     443:	c0ac20        	sub	a10, a12, a2
     446:	3149           	s32i.n	a4, a1, 12
     448:	03dd           	mov.n	a13, a3
     44a:	1192d0        	slli	a9, a2, 3
     44d:	049a16        	beqz	a10, 49a <sbc_frame_decode+0x66>
     450:	fcc222        	addi	a2, a2, -4
     453:	602020        	neg	a2, a2
     456:	144020        	extui	a4, a2, 0, 2
     459:	070c           	movi.n	a7, 0
     45b:	203880        	or	a3, a8, a8
     45e:	412220        	srli	a2, a2, 2
     461:	099476        	loopnez	a4, 46e <sbc_frame_decode+0x3a>
     464:	000342        	l8ui	a4, a3, 0
     467:	115780        	slli	a5, a7, 8
     46a:	331b           	addi.n	a3, a3, 1
     46c:	754a           	add.n	a7, a5, a4

0000046e <sbc_frame_decode+0x3a>:
     46e:	32ac           	beqz.n	a2, 495 <sbc_frame_decode+0x61>
     470:	219276        	loopnez	a2, 495 <sbc_frame_decode+0x61>
     473:	000362        	l8ui	a6, a3, 0
     476:	030322        	l8ui	a2, a3, 3
     479:	020342        	l8ui	a4, a3, 2
     47c:	010352        	l8ui	a5, a3, 1
     47f:	334b           	addi.n	a3, a3, 4
     481:	117780        	slli	a7, a7, 8
     484:	676a           	add.n	a6, a7, a6
     486:	116680        	slli	a6, a6, 8
     489:	565a           	add.n	a5, a6, a5
     48b:	115580        	slli	a5, a5, 8
     48e:	454a           	add.n	a4, a5, a4
     490:	114480        	slli	a4, a4, 8
     493:	742a           	add.n	a7, a4, a2

00000495 <sbc_frame_decode+0x61>:
     495:	88aa           	add.n	a8, a8, a10
     497:	000046        	j	49c <sbc_frame_decode+0x68>

0000049a <sbc_frame_decode+0x66>:
     49a:	070c           	movi.n	a7, 0
     49c:	041e22        	l16ui	a2, a14, 8
     49f:	fec852        	addi	a5, a8, -2
     4a2:	70cea2        	addi	a10, a14, 112
     4a5:	032694        	wur.ae_bitptr	a9
     4a8:	f3f170        	wur.ae_bithead	a7
     4ab:	ff6a52        	s32i	a5, a10, 0x3fc
     4ae:	713266        	bnei	a2, 3, 523 <sbc_frame_decode+0xef>
     4b1:	061e22        	l16ui	a2, a14, 12
     4b4:	032724        	ae_lb	a2, a2
     4b7:	175e22        	s16i	a2, a14, 46
     4ba:	171e42        	l16ui	a4, a14, 46
     4bd:	061e62        	l16ui	a6, a14, 12
     4c0:	ff2a52        	l32i	a5, a10, 0x3fc
     4c3:	061e32        	l16ui	a3, a14, 12
     4c6:	34f040        	extui	a15, a4, 0, 4
     4c9:	fcc6c2        	addi	a12, a6, -4
     4cc:	1c1534        	ae_db	a5, a3
     4cf:	113fc0        	slli	a3, a15, 4
     4d2:	9334c0        	movnez	a3, a4, a12
     4d5:	ff6a52        	s32i	a5, a10, 0x3fc
     4d8:	0b5e32        	s16i	a3, a14, 22
     4db:	049416        	beqz	a4, 528 <sbc_frame_decode+0xf4>
     4de:	061e72        	l16ui	a7, a14, 12
     4e1:	58a432        	movi	a3, 0x458
     4e4:	6cce22        	addi	a2, a14, 108
     4e7:	3e3a           	add.n	a3, a14, a3
     4e9:	ff6232        	s32i	a3, a2, 0x3fc
     4ec:	87bc           	beqz.n	a7, 528 <sbc_frame_decode+0xf4>
     4ee:	970b           	addi.n	a9, a7, -1
     4f0:	f87c           	movi.n	a8, -1
     4f2:	160c           	movi.n	a6, 1
     4f4:	401900        	ssl	a9
     4f7:	f48080        	extui	a8, a8, 0, 16
     4fa:	a19600        	sll	a9, a6
     4fd:	1e8076        	loop	a0, 51f <sbc_frame_decode+0xeb>
     500:	104490        	and	a4, a4, a9
     503:	0d0847        	bnone	a8, a4, 514 <sbc_frame_decode+0xe0>
     506:	460b           	addi.n	a4, a6, -1
     508:	634d           	ae_s16i.n	a4, a3, 0
     50a:	061e72        	l16ui	a7, a14, 12
     50d:	b32b           	addi.n	a11, a3, 2
     50f:	0b3d           	mov.n	a3, a11
     511:	ff62b2        	s32i	a11, a2, 0x3fc
     514:	10b677        	bgeu	a6, a7, 528 <sbc_frame_decode+0xf4>
     517:	171e42        	l16ui	a4, a14, 46
     51a:	419190        	srli	a9, a9, 1
     51d:	661b           	addi.n	a6, a6, 1

0000051f <sbc_frame_decode+0xeb>:
     51f:	fff686        	j	4fd <sbc_frame_decode+0xc9>

00000522 <sbc_frame_decode+0xee>:
	...

00000523 <sbc_frame_decode+0xef>:
     523:	020c           	movi.n	a2, 0
     525:	175e22        	s16i	a2, a14, 46
     528:	041e22        	l16ui	a2, a14, 8
     52b:	1a1e32        	l16ui	a3, a14, 52
     52e:	0c1c           	movi.n	a12, 16
     530:	653266        	bnei	a2, 3, 599 <sbc_frame_decode+0x165>
     533:	1a1e32        	l16ui	a3, a14, 52
     536:	061e22        	l16ui	a2, a14, 12
     539:	8c1c           	movi.n	a12, 24
     53b:	41b130        	srli	a11, a3, 1
     53e:	024226        	beqi	a2, 4, 544 <sbc_frame_decode+0x110>
     541:	006b86        	j	6f3 <sbc_frame_decode+0x2bf>
     544:	4c1c           	movi.n	a12, 20
     546:	0a8b16        	beqz	a11, 5f2 <sbc_frame_decode+0x1be>
     549:	820c           	movi.n	a2, 8
     54b:	036724        	ae_lb	a6, a2
     54e:	38ce42        	addi	a4, a14, 56
     551:	16ce32        	addi	a3, a14, 22
     554:	347460        	extui	a7, a6, 4, 4
     557:	346060        	extui	a6, a6, 0, 4
     55a:	1c1524        	ae_db	a5, a2
     55d:	647d           	ae_s16i.n	a7, a4, 0
     55f:	746d           	ae_s16i.n	a6, a4, 2
     561:	238d           	ae_l16si.n	a8, a3, 0
     563:	fb0b           	addi.n	a15, a11, -1
     565:	1166c0        	slli	a6, a6, 4
     568:	207870        	or	a7, a8, a7
     56b:	444b           	addi.n	a4, a4, 4
     56d:	637d           	ae_s16i.n	a7, a3, 0
     56f:	736d           	ae_s16i.n	a6, a3, 2
     571:	1f9f76        	loopnez	a15, 594 <sbc_frame_decode+0x160>
     574:	036724        	ae_lb	a6, a2
     577:	332b           	addi.n	a3, a3, 2
     579:	1c1524        	ae_db	a5, a2
     57c:	347060        	extui	a7, a6, 0, 4
     57f:	348460        	extui	a8, a6, 4, 4
     582:	1167c0        	slli	a6, a7, 4
     585:	648d           	ae_s16i.n	a8, a4, 0
     587:	747d           	ae_s16i.n	a7, a4, 2
     589:	237d           	ae_l16si.n	a7, a3, 0
     58b:	444b           	addi.n	a4, a4, 4
     58d:	736d           	ae_s16i.n	a6, a3, 2
     58f:	206780        	or	a6, a7, a8
     592:	636d           	ae_s16i.n	a6, a3, 0

00000594 <sbc_frame_decode+0x160>:
     594:	001686        	j	5f2 <sbc_frame_decode+0x1be>

00000597 <sbc_frame_decode+0x163>:
	...

00000599 <sbc_frame_decode+0x165>:
     599:	41b130        	srli	a11, a3, 1
     59c:	052b16        	beqz	a11, 5f2 <sbc_frame_decode+0x1be>
     59f:	16ce32        	addi	a3, a14, 22
     5a2:	38ce42        	addi	a4, a14, 56
     5a5:	820c           	movi.n	a2, 8
     5a7:	4161b0        	srli	a6, a11, 1
     5aa:	156b07        	bbci	a11, 0, 5c3 <sbc_frame_decode+0x18f>
     5ad:	037724        	ae_lb	a7, a2
     5b0:	1c1524        	ae_db	a5, a2
     5b3:	348470        	extui	a8, a7, 4, 4
     5b6:	349070        	extui	a9, a7, 0, 4
     5b9:	648d           	ae_s16i.n	a8, a4, 0
     5bb:	749d           	ae_s16i.n	a9, a4, 2
     5bd:	637d           	ae_s16i.n	a7, a3, 0
     5bf:	332b           	addi.n	a3, a3, 2
     5c1:	444b           	addi.n	a4, a4, 4
     5c3:	b6ac           	beqz.n	a6, 5f2 <sbc_frame_decode+0x1be>
     5c5:	299676        	loopnez	a6, 5f2 <sbc_frame_decode+0x1be>
     5c8:	039724        	ae_lb	a9, a2
     5cb:	644b           	addi.n	a6, a4, 4
     5cd:	1c1524        	ae_db	a5, a2
     5d0:	347090        	extui	a7, a9, 0, 4
     5d3:	348490        	extui	a8, a9, 4, 4
     5d6:	648d           	ae_s16i.n	a8, a4, 0
     5d8:	747d           	ae_s16i.n	a7, a4, 2
     5da:	464b           	addi.n	a4, a6, 4
     5dc:	037724        	ae_lb	a7, a2
     5df:	639d           	ae_s16i.n	a9, a3, 0
     5e1:	1c1524        	ae_db	a5, a2
     5e4:	348070        	extui	a8, a7, 0, 4
     5e7:	768d           	ae_s16i.n	a8, a6, 2
     5e9:	348470        	extui	a8, a7, 4, 4
     5ec:	668d           	ae_s16i.n	a8, a6, 0
     5ee:	737d           	ae_s16i.n	a7, a3, 2
     5f0:	334b           	addi.n	a3, a3, 4

000005f2 <sbc_frame_decode+0x1be>:
     5f2:	b02bc0        	addx8	a2, a11, a12
     5f5:	091e32        	l16ui	a3, a14, 18
     5f8:	927d           	ae_zext16	a7, a2
     5fa:	f40c           	movi.n	a4, 15
     5fc:	ff6a52        	s32i	a5, a10, 0x3fc
     5ff:	155e22        	s16i	a2, a14, 42
     602:	2c87b6        	bltui	a7, 8, 632 <sbc_frame_decode+0x1fe>
     605:	fe8621        	l32r	a2, 20 (28a0 <SBC_crc_table>)
     608:	416370        	srli	a6, a7, 3
     60b:	14ce52        	addi	a5, a14, 20
     60e:	0fa042        	movi	a4, 15
     611:	1d8676        	loop	a6, 632 <sbc_frame_decode+0x1fe>
     614:	306430        	xor	a6, a4, a3
     617:	453d           	ae_l16ui.n	a3, a5, 0
     619:	552b           	addi.n	a5, a5, 2
     61b:	044060        	extui	a4, a6, 0, 1
     61e:	416160        	srli	a6, a6, 1
     621:	906620        	addx2	a6, a6, a2
     624:	466d           	ae_l16ui.n	a6, a6, 0
     626:	1144d0        	slli	a4, a4, 3
     629:	400400        	ssr	a4
     62c:	914060        	srl	a4, a6
     62f:	744040        	extui	a4, a4, 0, 8

00000632 <sbc_frame_decode+0x1fe>:
     632:	24e727        	bbsi	a7, 2, 65a <sbc_frame_decode+0x226>
     635:	161e22        	l16ui	a2, a14, 44
     638:	469427        	bne	a4, a2, 682 <sbc_frame_decode+0x24e>
     63b:	fe7a21        	l32r	a2, 24 (8a8 <sbc_bit_allocation>)
     63e:	0ead           	mov.n	a10, a14
     640:	0d3d           	mov.n	a3, a13
     642:	204ee0        	or	a4, a14, a14
     645:	0002e0        	callx8	a2
     648:	fe7821        	l32r	a2, 28 (c60 <sbc_reconstruction>)
     64b:	04ad           	mov.n	a10, a4
     64d:	0002e0        	callx8	a2
     650:	04ed           	mov.n	a14, a4
     652:	03dd           	mov.n	a13, a3
     654:	0012c6        	j	6a3 <sbc_frame_decode+0x26f>

00000657 <sbc_frame_decode+0x223>:
     657:	000000                                        ...

0000065a <sbc_frame_decode+0x226>:
     65a:	420c           	movi.n	a2, 4
     65c:	105720        	and	a5, a7, a2
     65f:	d21c           	movi.n	a2, 29
     661:	178576        	loop	a5, 67c <sbc_frame_decode+0x248>
     664:	305340        	xor	a5, a3, a4
     667:	015580        	slli	a5, a5, 24
     66a:	1133f0        	slli	a3, a3, 1
     66d:	644040        	extui	a4, a4, 0, 7
     670:	1144f0        	slli	a4, a4, 1
     673:	315f50        	srai	a5, a5, 31
     676:	105520        	and	a5, a5, a2
     679:	304540        	xor	a4, a5, a4

0000067c <sbc_frame_decode+0x248>:
     67c:	161e22        	l16ui	a2, a14, 44
     67f:	b81427        	beq	a4, a2, 63b <sbc_frame_decode+0x207>

00000682 <sbc_frame_decode+0x24e>:
     682:	00a142        	movi	a4, 0x100
     685:	414340        	srli	a4, a4, 3
     688:	58ce32        	addi	a3, a14, 88
     68b:	020c           	movi.n	a2, 0
     68d:	129476        	loopnez	a4, 6a3 <sbc_frame_decode+0x26f>
     690:	0329           	s32i.n	a2, a3, 0
     692:	7329           	s32i.n	a2, a3, 28
     694:	6329           	s32i.n	a2, a3, 24
     696:	5329           	s32i.n	a2, a3, 20
     698:	1329           	s32i.n	a2, a3, 4
     69a:	4329           	s32i.n	a2, a3, 16
     69c:	3329           	s32i.n	a2, a3, 12
     69e:	2329           	s32i.n	a2, a3, 8
     6a0:	20c332        	addi	a3, a3, 32
     6a3:	071e22        	l16ui	a2, a14, 14
     6a6:	030c           	movi.n	a3, 0
     6a8:	10def2        	addmi	a15, a14, 0x1000
     6ab:	220b           	addi.n	a2, a2, -1
     6ad:	622320        	saltu	a2, a3, a2
     6b0:	1b1e42        	l16ui	a4, a14, 54
     6b3:	081f32        	l16ui	a3, a15, 16
     6b6:	400200        	ssr	a2
     6b9:	912040        	srl	a2, a4
     6bc:	08d316        	beqz	a3, 74d <sbc_frame_decode+0x319>
     6bf:	022366        	bnei	a3, 2, 6c5 <sbc_frame_decode+0x291>
     6c2:	002a86        	j	770 <sbc_frame_decode+0x33c>
     6c5:	021326        	beqi	a3, 1, 6cb <sbc_frame_decode+0x297>
     6c8:	006686        	j	866 <sbc_frame_decode+0x432>
     6cb:	a0a442        	movi	a4, 0x4a0
     6ce:	061e62        	l16ui	a6, a14, 12
     6d1:	0bde32        	addmi	a3, a14, 0xb00
     6d4:	4e4a           	add.n	a4, a14, a4
     6d6:	286342        	s32i	a4, a3, 160
     6d9:	5393f2        	l16si	a15, a3, 166
     6dc:	5253f2        	s16i	a15, a3, 164
     6df:	0bde42        	addmi	a4, a14, 0xb00
     6e2:	024626        	beqi	a6, 4, 6e8 <sbc_frame_decode+0x2b4>
     6e5:	002b06        	j	795 <sbc_frame_decode+0x361>
     6e8:	fe5151        	l32r	a5, 2c (1040 <SBC_synthesis4_per_channel>)
     6eb:	002a46        	j	798 <sbc_frame_decode+0x364>

000006ee <sbc_frame_decode+0x2ba>:
     6ee:	00000000                                 .....

000006f3 <sbc_frame_decode+0x2bf>:
     6f3:	efbb16        	beqz	a11, 5f2 <sbc_frame_decode+0x1be>
     6f6:	18ce32        	addi	a3, a14, 24
     6f9:	38ce42        	addi	a4, a14, 56
     6fc:	820c           	movi.n	a2, 8
     6fe:	4161b0        	srli	a6, a11, 1
     701:	156b07        	bbci	a11, 0, 71a <sbc_frame_decode+0x2e6>
     704:	037724        	ae_lb	a7, a2
     707:	1c1524        	ae_db	a5, a2
     70a:	348470        	extui	a8, a7, 4, 4
     70d:	349070        	extui	a9, a7, 0, 4
     710:	648d           	ae_s16i.n	a8, a4, 0
     712:	749d           	ae_s16i.n	a9, a4, 2
     714:	637d           	ae_s16i.n	a7, a3, 0
     716:	332b           	addi.n	a3, a3, 2
     718:	444b           	addi.n	a4, a4, 4
     71a:	ed4616        	beqz	a6, 5f2 <sbc_frame_decode+0x1be>
     71d:	299676        	loopnez	a6, 74a <sbc_frame_decode+0x316>
     720:	039724        	ae_lb	a9, a2
     723:	644b           	addi.n	a6, a4, 4
     725:	1c1524        	ae_db	a5, a2
     728:	347090        	extui	a7, a9, 0, 4
     72b:	348490        	extui	a8, a9, 4, 4
     72e:	648d           	ae_s16i.n	a8, a4, 0
     730:	747d           	ae_s16i.n	a7, a4, 2
     732:	464b           	addi.n	a4, a6, 4
     734:	037724        	ae_lb	a7, a2
     737:	639d           	ae_s16i.n	a9, a3, 0
     739:	1c1524        	ae_db	a5, a2
     73c:	348070        	extui	a8, a7, 0, 4
     73f:	768d           	ae_s16i.n	a8, a6, 2
     741:	348470        	extui	a8, a7, 4, 4
     744:	668d           	ae_s16i.n	a8, a6, 0
     746:	737d           	ae_s16i.n	a7, a3, 2
     748:	334b           	addi.n	a3, a3, 4

0000074a <sbc_frame_decode+0x316>:
     74a:	ffa906        	j	5f2 <sbc_frame_decode+0x1be>

0000074d <sbc_frame_decode+0x319>:
     74d:	061e62        	l16ui	a6, a14, 12
     750:	a0a452        	movi	a5, 0x4a0
     753:	0bde42        	addmi	a4, a14, 0xb00
     756:	5e5a           	add.n	a5, a14, a5
     758:	5394f2        	l16si	a15, a4, 166
     75b:	286452        	s32i	a5, a4, 160
     75e:	0bde32        	addmi	a3, a14, 0xb00
     761:	5254f2        	s16i	a15, a4, 164
     764:	0bde22        	addmi	a2, a14, 0xb00
     767:	6f4666        	bnei	a6, 4, 7da <sbc_frame_decode+0x3a6>
     76a:	fe3051        	l32r	a5, 2c (1040 <SBC_synthesis4_per_channel>)
     76d:	001b06        	j	7dd <sbc_frame_decode+0x3a9>

00000770 <sbc_frame_decode+0x33c>:
     770:	20a742        	movi	a4, 0x720
     773:	061e62        	l16ui	a6, a14, 12
     776:	0bde32        	addmi	a3, a14, 0xb00
     779:	4e4a           	add.n	a4, a14, a4
     77b:	286342        	s32i	a4, a3, 160
     77e:	5493f2        	l16si	a15, a3, 168
     781:	0d7d           	mov.n	a7, a13
     783:	5253f2        	s16i	a15, a3, 164
     786:	0bde42        	addmi	a4, a14, 0xb00
     789:	024626        	beqi	a6, 4, 78f <sbc_frame_decode+0x35b>
     78c:	0020c6        	j	813 <sbc_frame_decode+0x3df>
     78f:	fe2751        	l32r	a5, 2c (1040 <SBC_synthesis4_per_channel>)
     792:	002006        	j	816 <sbc_frame_decode+0x3e2>

00000795 <sbc_frame_decode+0x361>:
     795:	fe2651        	l32r	a5, 30 (1280 <SBC_synthesis8_per_channel>)
     798:	0a0c           	movi.n	a10, 0
     79a:	0dbd           	mov.n	a11, a13
     79c:	0ecd           	mov.n	a12, a14
     79e:	0d6d           	mov.n	a6, a13
     7a0:	0005e0        	callx8	a5
     7a3:	529442        	l16si	a4, a4, 164
     7a6:	535342        	s16i	a4, a3, 166
     7a9:	0b9216        	beqz	a2, 866 <sbc_frame_decode+0x432>
     7ac:	064d           	mov.n	a4, a6
     7ae:	415120        	srli	a5, a2, 1
     7b1:	0b6207        	bbci	a2, 0, 7c0 <sbc_frame_decode+0x38c>
     7b4:	3138           	l32i.n	a3, a1, 12
     7b6:	242d           	ae_l16si.n	a2, a4, 0
     7b8:	442b           	addi.n	a4, a4, 2
     7ba:	632d           	ae_s16i.n	a2, a3, 0
     7bc:	332b           	addi.n	a3, a3, 2
     7be:	3139           	s32i.n	a3, a1, 12
     7c0:	0a2516        	beqz	a5, 866 <sbc_frame_decode+0x432>
     7c3:	043d           	mov.n	a3, a4
     7c5:	3148           	l32i.n	a4, a1, 12
     7c7:	0b9576        	loopnez	a5, 7d6 <sbc_frame_decode+0x3a2>
     7ca:	232d           	ae_l16si.n	a2, a3, 0
     7cc:	642d           	ae_s16i.n	a2, a4, 0
     7ce:	332d           	ae_l16si.n	a2, a3, 2
     7d0:	742d           	ae_s16i.n	a2, a4, 2
     7d2:	444b           	addi.n	a4, a4, 4
     7d4:	334b           	addi.n	a3, a3, 4

000007d6 <sbc_frame_decode+0x3a2>:
     7d6:	020c           	movi.n	a2, 0
     7d8:	f01d           	retw.n

000007da <sbc_frame_decode+0x3a6>:
     7da:	fe1551        	l32r	a5, 30 (1280 <SBC_synthesis8_per_channel>)
     7dd:	0a0c           	movi.n	a10, 0
     7df:	0dbd           	mov.n	a11, a13
     7e1:	0ecd           	mov.n	a12, a14
     7e3:	0e7d           	mov.n	a7, a14
     7e5:	0005e0        	callx8	a5
     7e8:	071762        	l16ui	a6, a7, 14
     7eb:	529252        	l16si	a5, a2, 164
     7ee:	535452        	s16i	a5, a4, 166
     7f1:	712666        	bnei	a6, 2, 866 <sbc_frame_decode+0x432>
     7f4:	20a742        	movi	a4, 0x720
     7f7:	474a           	add.n	a4, a7, a4
     7f9:	061752        	l16ui	a5, a7, 12
     7fc:	286342        	s32i	a4, a3, 160
     7ff:	0bd732        	addmi	a3, a7, 0xb00
     802:	5493f2        	l16si	a15, a3, 168
     805:	07cd           	mov.n	a12, a7
     807:	5252f2        	s16i	a15, a2, 164
     80a:	474566        	bnei	a5, 4, 855 <sbc_frame_decode+0x421>
     80d:	fe0741        	l32r	a4, 2c (1040 <SBC_synthesis4_per_channel>)
     810:	001106        	j	858 <sbc_frame_decode+0x424>

00000813 <sbc_frame_decode+0x3df>:
     813:	fe0751        	l32r	a5, 30 (1280 <SBC_synthesis8_per_channel>)
     816:	31b8           	l32i.n	a11, a1, 12
     818:	01a0a2        	movi	a10, 1
     81b:	20cee0        	or	a12, a14, a14
     81e:	0005e0        	callx8	a5
     821:	529442        	l16si	a4, a4, 164
     824:	545342        	s16i	a4, a3, 168
     827:	b2bc           	beqz.n	a2, 866 <sbc_frame_decode+0x432>
     829:	415120        	srli	a5, a2, 1
     82c:	0b6207        	bbci	a2, 0, 83b <sbc_frame_decode+0x407>
     82f:	3138           	l32i.n	a3, a1, 12
     831:	232d           	ae_l16si.n	a2, a3, 0
     833:	332b           	addi.n	a3, a3, 2
     835:	672d           	ae_s16i.n	a2, a7, 0
     837:	772b           	addi.n	a7, a7, 2
     839:	3139           	s32i.n	a3, a1, 12
     83b:	75ac           	beqz.n	a5, 866 <sbc_frame_decode+0x432>
     83d:	3148           	l32i.n	a4, a1, 12
     83f:	073d           	mov.n	a3, a7
     841:	0b9576        	loopnez	a5, 850 <sbc_frame_decode+0x41c>
     844:	242d           	ae_l16si.n	a2, a4, 0
     846:	632d           	ae_s16i.n	a2, a3, 0
     848:	342d           	ae_l16si.n	a2, a4, 2
     84a:	732d           	ae_s16i.n	a2, a3, 2
     84c:	334b           	addi.n	a3, a3, 4
     84e:	444b           	addi.n	a4, a4, 4

00000850 <sbc_frame_decode+0x41c>:
     850:	020c           	movi.n	a2, 0
     852:	f01d           	retw.n

00000854 <sbc_frame_decode+0x420>:
	...

00000855 <sbc_frame_decode+0x421>:
     855:	fdf641        	l32r	a4, 30 (1280 <SBC_synthesis8_per_channel>)
     858:	31b8           	l32i.n	a11, a1, 12
     85a:	01a0a2        	movi	a10, 1
     85d:	0004e0        	callx8	a4
     860:	529222        	l16si	a2, a2, 164
     863:	545322        	s16i	a2, a3, 168
     866:	020c           	movi.n	a2, 0
     868:	f01d           	retw.n

0000086a <sbc_frame_decode+0x436>:
	...

0000086c <sbc_zero_sb_samples>:
     86c:	004136        	entry	a1, 32
     86f:	00a152        	movi	a5, 0x100
     872:	030c           	movi.n	a3, 0
     874:	58c242        	addi	a4, a2, 88
     877:	415350        	srli	a5, a5, 3
     87a:	032d           	mov.n	a2, a3
     87c:	043d           	mov.n	a3, a4
     87e:	129576        	loopnez	a5, 894 <sbc_zero_sb_samples+0x28>
     881:	0329           	s32i.n	a2, a3, 0
     883:	7329           	s32i.n	a2, a3, 28
     885:	6329           	s32i.n	a2, a3, 24
     887:	5329           	s32i.n	a2, a3, 20
     889:	1329           	s32i.n	a2, a3, 4
     88b:	4329           	s32i.n	a2, a3, 16
     88d:	3329           	s32i.n	a2, a3, 12
     88f:	2329           	s32i.n	a2, a3, 8
     891:	20c332        	addi	a3, a3, 32

00000894 <sbc_zero_sb_samples+0x28>:
     894:	f01d           	retw.n

00000896 <sbc_zero_sb_samples+0x2a>:
	...

00000898 <pseudo_stereo>:
     898:	004136        	entry	a1, 32
     89b:	f01d           	retw.n

0000089d <pseudo_stereo+0x5>:
     89d:	000000                                        ...

000008a0 <pseudo_stereo_setup>:
     8a0:	004136        	entry	a1, 32
     8a3:	f01d           	retw.n

000008a5 <pseudo_stereo_setup+0x5>:
     8a5:	000000                                        ...

000008a8 <sbc_bit_allocation>:
     8a8:	00c136        	entry	a1, 96
     8ab:	02cd           	mov.n	a12, a2
     8ad:	0412a2        	l16ui	a10, a2, 8
     8b0:	4f3c           	movi.n	a15, 52
     8b2:	c30c           	movi.n	a3, 12
     8b4:	0441a0        	extui	a4, a10, 1, 1
     8b7:	933f40        	movnez	a3, a15, a4
     8ba:	223a           	add.n	a2, a2, a3
     8bc:	051c92        	l16ui	a9, a12, 10
     8bf:	42fd           	ae_l16ui.n	a15, a2, 0
     8c1:	061c32        	l16ui	a3, a12, 12
     8c4:	541926        	beqi	a9, 1, 91c <sbc_bit_allocation+0x74>
     8c7:	051f16        	beqz	a15, 91c <sbc_bit_allocation+0x74>
     8ca:	021c52        	l16ui	a5, a12, 4
     8cd:	fdd921        	l32r	a2, 34 (29c0 <SBC_OFFSET8>)
     8d0:	fdda41        	l32r	a4, 38 (29a0 <SBC_OFFSET4>)
     8d3:	fcc382        	addi	a8, a3, -4
     8d6:	c15530        	mul16u	a5, a5, a3
     8d9:	934280        	movnez	a4, a2, a8
     8dc:	78a462        	movi	a6, 0x478
     8df:	902540        	addx2	a2, a5, a4
     8e2:	070c           	movi.n	a7, 0
     8e4:	4151f0        	srli	a5, a15, 1
     8e7:	4c6a           	add.n	a4, a12, a6
     8e9:	330b           	addi.n	a3, a3, -1
     8eb:	0e6f07        	bbci	a15, 0, 8fd <sbc_bit_allocation+0x55>
     8ee:	106730        	and	a6, a7, a3
     8f1:	906620        	addx2	a6, a6, a2
     8f4:	266d           	ae_l16si.n	a6, a6, 0
     8f6:	646d           	ae_s16i.n	a6, a4, 0
     8f8:	771b           	addi.n	a7, a7, 1
     8fa:	02c442        	addi	a4, a4, 2

000008fd <sbc_bit_allocation+0x55>:
     8fd:	b59c           	beqz.n	a5, 91c <sbc_bit_allocation+0x74>
     8ff:	199576        	loopnez	a5, 91c <sbc_bit_allocation+0x74>
     902:	571b           	addi.n	a5, a7, 1
     904:	108530        	and	a8, a5, a3
     907:	106730        	and	a6, a7, a3
     90a:	906620        	addx2	a6, a6, a2
     90d:	751b           	addi.n	a7, a5, 1
     90f:	265d           	ae_l16si.n	a5, a6, 0
     911:	645d           	ae_s16i.n	a5, a4, 0
     913:	905820        	addx2	a5, a8, a2
     916:	255d           	ae_l16si.n	a5, a5, 0
     918:	745d           	ae_s16i.n	a5, a4, 2
     91a:	444b           	addi.n	a4, a4, 4

0000091c <sbc_bit_allocation+0x74>:
     91c:	d5a522        	movi	a2, 0x5d5
     91f:	1122f0        	slli	a2, a2, 1
     922:	38cc32        	addi	a3, a12, 56
     925:	78a4e2        	movi	a14, 0x478
     928:	6139           	s32i.n	a3, a1, 24
     92a:	041c           	movi.n	a4, 16
     92c:	050c           	movi.n	a5, 0
     92e:	3cea           	add.n	a3, a12, a14
     930:	2c2a           	add.n	a2, a12, a2
     932:	7149           	s32i.n	a4, a1, 28
     934:	080c           	movi.n	a8, 0
     936:	040c           	movi.n	a4, 0
     938:	3159           	s32i.n	a5, a1, 12
     93a:	8139           	s32i.n	a3, a1, 32
     93c:	4129           	s32i.n	a2, a1, 16
     93e:	91c9           	s32i.n	a12, a1, 36

00000940 <sbc_bit_allocation+0x98>:
     940:	061cd2        	l16ui	a13, a12, 12
     943:	d149           	s32i.n	a4, a1, 52
     945:	4128           	l32i.n	a2, a1, 16
     947:	82e4d0        	mull	a14, a4, a13
     94a:	3a1966        	bnei	a9, 1, 988 <sbc_bit_allocation+0xe0>
     94d:	22cf16        	beqz	a15, b7d <sbc_bit_allocation+0x2d5>
     950:	4128           	l32i.n	a2, a1, 16
     952:	61b8           	l32i.n	a11, a1, 24
     954:	060c           	movi.n	a6, 0
     956:	42ea           	add.n	a4, a2, a14
     958:	3bea           	add.n	a3, a11, a14
     95a:	4121f0        	srli	a2, a15, 1
     95d:	0a6f07        	bbci	a15, 0, 96b <sbc_bit_allocation+0xc3>
     960:	235d           	ae_l16si.n	a5, a3, 0
     962:	645d           	ae_s16i.n	a5, a4, 0
     964:	332b           	addi.n	a3, a3, 2
     966:	442b           	addi.n	a4, a4, 2
     968:	536650        	max	a6, a6, a5
     96b:	04c216        	beqz	a2, 9bb <sbc_bit_allocation+0x113>
     96e:	119276        	loopnez	a2, 983 <sbc_bit_allocation+0xdb>
     971:	235d           	ae_l16si.n	a5, a3, 0
     973:	645d           	ae_s16i.n	a5, a4, 0
     975:	332d           	ae_l16si.n	a2, a3, 2
     977:	535650        	max	a5, a6, a5
     97a:	334b           	addi.n	a3, a3, 4
     97c:	742d           	ae_s16i.n	a2, a4, 2
     97e:	444b           	addi.n	a4, a4, 4
     980:	536520        	max	a6, a5, a2

00000983 <sbc_bit_allocation+0xdb>:
     983:	000d06        	j	9bb <sbc_bit_allocation+0x113>

00000986 <sbc_bit_allocation+0xde>:
	...

00000988 <sbc_bit_allocation+0xe0>:
     988:	1f1f16        	beqz	a15, b7d <sbc_bit_allocation+0x2d5>
     98b:	6138           	l32i.n	a3, a1, 24
     98d:	8148           	l32i.n	a4, a1, 32
     98f:	22ea           	add.n	a2, a2, a14
     991:	33ea           	add.n	a3, a3, a14
     993:	060c           	movi.n	a6, 0
     995:	228f76        	loop	a15, 9bb <sbc_bit_allocation+0x113>
     998:	435d           	ae_l16ui.n	a5, a3, 0
     99a:	059c           	beqz.n	a5, 9ae <sbc_bit_allocation+0x106>
     99c:	247d           	ae_l16si.n	a7, a4, 0
     99e:	c05570        	sub	a5, a5, a7
     9a1:	727850        	salt	a7, a8, a5
     9a4:	400700        	ssr	a7
     9a7:	b15050        	sra	a5, a5
     9aa:	000086        	j	9b0 <sbc_bit_allocation+0x108>

000009ad <sbc_bit_allocation+0x105>:
	...

000009ae <sbc_bit_allocation+0x106>:
     9ae:	b57c           	movi.n	a5, -5
     9b0:	625d           	ae_s16i.n	a5, a2, 0
     9b2:	536560        	max	a6, a5, a6
     9b5:	222b           	addi.n	a2, a2, 2
     9b7:	332b           	addi.n	a3, a3, 2
     9b9:	442b           	addi.n	a4, a4, 2

000009bb <sbc_bit_allocation+0x113>:
     9bb:	3128           	l32i.n	a2, a1, 12
     9bd:	b1d9           	s32i.n	a13, a1, 44
     9bf:	081cc2        	l16ui	a12, a12, 16
     9c2:	8222d0        	mull	a2, a2, a13
     9c5:	41d8           	l32i.n	a13, a1, 16
     9c7:	a129           	s32i.n	a2, a1, 40
     9c9:	5189           	s32i.n	a8, a1, 20
     9cb:	2dea           	add.n	a2, a13, a14
     9cd:	c1e9           	s32i.n	a14, a1, 48
     9cf:	e1a9           	s32i.n	a10, a1, 56
     9d1:	361b           	addi.n	a3, a6, 1
     9d3:	21c9           	s32i.n	a12, a1, 8
     9d5:	f129           	s32i.n	a2, a1, 60
     9d7:	0e0c           	movi.n	a14, 0
     9d9:	070c           	movi.n	a7, 0
     9db:	000fc6        	j	a1e <sbc_bit_allocation+0x176>

000009de <sbc_bit_allocation+0x136>:
     9de:	057d           	mov.n	a7, a5
     9e0:	319476        	loopnez	a4, a15 <sbc_bit_allocation+0x16d>
     9e3:	26cd           	ae_l16si.n	a12, a6, 0
     9e5:	36dd           	ae_l16si.n	a13, a6, 2
     9e7:	664b           	addi.n	a6, a6, 4
     9e9:	b72b           	addi.n	a11, a7, 2
     9eb:	871b           	addi.n	a8, a7, 1
     9ed:	7292c0        	salt	a9, a2, a12
     9f0:	72ac30        	salt	a10, a12, a3
     9f3:	7252d0        	salt	a5, a2, a13
     9f6:	724d30        	salt	a4, a13, a3
     9f9:	c0d2d0        	sub	a13, a2, a13
     9fc:	c0c2c0        	sub	a12, a2, a12
     9ff:	93b7c0        	movnez	a11, a7, a12
     a02:	838ba0        	moveqz	a8, a11, a10
     a05:	838b90        	moveqz	a8, a11, a9
     a08:	781b           	addi.n	a7, a8, 1
     a0a:	982b           	addi.n	a9, a8, 2
     a0c:	9398d0        	movnez	a9, a8, a13
     a0f:	837940        	moveqz	a7, a9, a4
     a12:	837950        	moveqz	a7, a9, a5

00000a15 <sbc_bit_allocation+0x16d>:
     a15:	2148           	l32i.n	a4, a1, 8
     a17:	97ea           	add.n	a9, a7, a14
     a19:	320b           	addi.n	a3, a2, -1
     a1b:	37a947        	bge	a9, a4, a56 <sbc_bit_allocation+0x1ae>

00000a1e <sbc_bit_allocation+0x176>:
     a1e:	e7ea           	add.n	a14, a7, a14
     a20:	032d           	mov.n	a2, a3
     a22:	070c           	movi.n	a7, 0
     a24:	fedf16        	beqz	a15, a15 <sbc_bit_allocation+0x16d>
     a27:	f168           	l32i.n	a6, a1, 60
     a29:	32fb           	addi.n	a3, a2, 15
     a2b:	050c           	movi.n	a5, 0
     a2d:	4141f0        	srli	a4, a15, 1
     a30:	1c6f07        	bbci	a15, 0, a50 <sbc_bit_allocation+0x1a8>
     a33:	268d           	ae_l16si.n	a8, a6, 0
     a35:	952b           	addi.n	a9, a5, 2
     a37:	751b           	addi.n	a7, a5, 1
     a39:	c0a280        	sub	a10, a2, a8
     a3c:	72d830        	salt	a13, a8, a3
     a3f:	9395a0        	movnez	a9, a5, a10
     a42:	728280        	salt	a8, a2, a8
     a45:	8379d0        	moveqz	a7, a9, a13
     a48:	837980        	moveqz	a7, a9, a8
     a4b:	662b           	addi.n	a6, a6, 2
     a4d:	205770        	or	a5, a7, a7
     a50:	f8a456        	bnez	a4, 9de <sbc_bit_allocation+0x136>
     a53:	ffef86        	j	a15 <sbc_bit_allocation+0x16d>

00000a56 <sbc_bit_allocation+0x1ae>:
     a56:	2148           	l32i.n	a4, a1, 8
     a58:	fec222        	addi	a2, a2, -2
     a5b:	4158           	l32i.n	a5, a1, 16
     a5d:	c0a940        	sub	a10, a9, a4
     a60:	9323a0        	movnez	a2, a3, a10
     a63:	9fbc           	beqz.n	a15, aa0 <sbc_bit_allocation+0x1f8>
     a65:	c148           	l32i.n	a4, a1, 48
     a67:	71c8           	l32i.n	a12, a1, 28
     a69:	51d8           	l32i.n	a13, a1, 20
     a6b:	654a           	add.n	a6, a5, a4
     a6d:	264d           	ae_l16si.n	a4, a6, 0
     a6f:	322b           	addi.n	a3, a2, 2
     a71:	8f0b           	addi.n	a8, a15, -1
     a73:	c05420        	sub	a5, a4, a2
     a76:	6375c0        	minu	a7, a5, a12
     a79:	724430        	salt	a4, a4, a3
     a7c:	937d40        	movnez	a7, a13, a4
     a7f:	0d4d           	mov.n	a4, a13
     a81:	0c5d           	mov.n	a5, a12
     a83:	129876        	loopnez	a8, a99 <sbc_bit_allocation+0x1f1>
     a86:	368d           	ae_l16si.n	a8, a6, 2
     a88:	205672        	s16i	a7, a6, 64
     a8b:	662b           	addi.n	a6, a6, 2
     a8d:	c07820        	sub	a7, a8, a2
     a90:	728830        	salt	a8, a8, a3
     a93:	637750        	minu	a7, a7, a5
     a96:	937480        	movnez	a7, a4, a8

00000a99 <sbc_bit_allocation+0x1f1>:
     a99:	7159           	s32i.n	a5, a1, 28
     a9b:	5149           	s32i.n	a4, a1, 20
     a9d:	205672        	s16i	a7, a6, 64

00000aa0 <sbc_bit_allocation+0x1f8>:
     aa0:	3138           	l32i.n	a3, a1, 12
     aa2:	e148           	l32i.n	a4, a1, 56
     aa4:	91c8           	l32i.n	a12, a1, 36
     aa6:	f5a5d2        	movi	a13, 0x5f5
     aa9:	939ea0        	movnez	a9, a14, a10
     aac:	331b           	addi.n	a3, a3, 1
     aae:	11ddf0        	slli	a13, a13, 1
     ab1:	de0c           	movi.n	a14, 13
     ab3:	026417        	bbci	a4, 1, ab9 <sbc_bit_allocation+0x211>
     ab6:	002986        	j	b60 <sbc_bit_allocation+0x2b8>
     ab9:	2148           	l32i.n	a4, a1, 8
     abb:	3178           	l32i.n	a7, a1, 12
     abd:	b158           	l32i.n	a5, a1, 44
     abf:	58a947        	bge	a9, a4, b1b <sbc_bit_allocation+0x273>
     ac2:	a168           	l32i.n	a6, a1, 40
     ac4:	471b           	addi.n	a4, a7, 1
     ac6:	825450        	mull	a5, a4, a5
     ac9:	9076c0        	addx2	a7, a6, a12
     acc:	4bb657        	bgeu	a6, a5, b1b <sbc_bit_allocation+0x273>
     acf:	521b           	addi.n	a5, a2, 1
     ad1:	67da           	add.n	a6, a7, a13
     ad3:	418076        	loop	a0, b18 <sbc_bit_allocation+0x270>
     ad6:	467d           	ae_l16ui.n	a7, a6, 0
     ad8:	21a8           	l32i.n	a10, a1, 8
     ada:	b91b           	addi.n	a11, a9, 1
     adc:	fec782        	addi	a8, a7, -2
     adf:	988d           	ae_zext16	a8, a8
     ae1:	083e87        	bltu	a14, a8, aed <sbc_bit_allocation+0x245>
     ae4:	771b           	addi.n	a7, a7, 1
     ae6:	180c           	movi.n	a8, 1
     ae8:	000406        	j	afc <sbc_bit_allocation+0x254>

00000aeb <sbc_bit_allocation+0x243>:
	...

00000aed <sbc_bit_allocation+0x245>:
     aed:	0faba7        	bge	a11, a10, b00 <sbc_bit_allocation+0x258>
     af0:	c0c672        	addi	a7, a6, -64
     af3:	27ad           	ae_l16si.n	a10, a7, 0
     af5:	270c           	movi.n	a7, 2
     af7:	280c           	movi.n	a8, 2
     af9:	0395a7        	bne	a5, a10, b00 <sbc_bit_allocation+0x258>
     afc:	998a           	add.n	a9, a9, a8
     afe:	667d           	ae_s16i.n	a7, a6, 0
     b00:	081c72        	l16ui	a7, a12, 16
     b03:	2179           	s32i.n	a7, a1, 8
     b05:	061c82        	l16ui	a8, a12, 12
     b08:	0fa977        	bge	a9, a7, b1b <sbc_bit_allocation+0x273>
     b0b:	662b           	addi.n	a6, a6, 2
     b0d:	827480        	mull	a7, a4, a8
     b10:	9077c0        	addx2	a7, a7, a12
     b13:	77da           	add.n	a7, a7, a13
     b15:	02b677        	bgeu	a6, a7, b1b <sbc_bit_allocation+0x273>

00000b18 <sbc_bit_allocation+0x270>:
     b18:	ffedc6        	j	ad3 <sbc_bit_allocation+0x22b>

00000b1b <sbc_bit_allocation+0x273>:
     b1b:	2148           	l32i.n	a4, a1, 8
     b1d:	3158           	l32i.n	a5, a1, 12
     b1f:	3da947        	bge	a9, a4, b60 <sbc_bit_allocation+0x2b8>
     b22:	061c62        	l16ui	a6, a12, 12
     b25:	451b           	addi.n	a4, a5, 1
     b27:	825560        	mull	a5, a5, a6
     b2a:	826460        	mull	a6, a4, a6
     b2d:	9075c0        	addx2	a7, a5, a12
     b30:	2cb567        	bgeu	a5, a6, b60 <sbc_bit_allocation+0x2b8>
     b33:	57da           	add.n	a5, a7, a13
     b35:	248076        	loop	a0, b5d <sbc_bit_allocation+0x2b5>
     b38:	456d           	ae_l16ui.n	a6, a5, 0
     b3a:	0ab6f6        	bgeui	a6, 16, b48 <sbc_bit_allocation+0x2a0>
     b3d:	661b           	addi.n	a6, a6, 1
     b3f:	656d           	ae_s16i.n	a6, a5, 0
     b41:	081c62        	l16ui	a6, a12, 16
     b44:	991b           	addi.n	a9, a9, 1
     b46:	2169           	s32i.n	a6, a1, 8
     b48:	2168           	l32i.n	a6, a1, 8
     b4a:	552b           	addi.n	a5, a5, 2
     b4c:	10a967        	bge	a9, a6, b60 <sbc_bit_allocation+0x2b8>
     b4f:	061c62        	l16ui	a6, a12, 12
     b52:	826460        	mull	a6, a4, a6
     b55:	9066c0        	addx2	a6, a6, a12
     b58:	66da           	add.n	a6, a6, a13
     b5a:	02b567        	bgeu	a5, a6, b60 <sbc_bit_allocation+0x2b8>

00000b5d <sbc_bit_allocation+0x2b5>:
     b5d:	fff506        	j	b35 <sbc_bit_allocation+0x28d>

00000b60 <sbc_bit_allocation+0x2b8>:
     b60:	041ca2        	l16ui	a10, a12, 8
     b63:	240c           	movi.n	a4, 2
     b65:	160c           	movi.n	a6, 1
     b67:	5a0b           	addi.n	a5, a10, -1
     b69:	934650        	movnez	a4, a6, a5
     b6c:	12b347        	bgeu	a3, a4, b82 <sbc_bit_allocation+0x2da>
     b6f:	d148           	l32i.n	a4, a1, 52
     b71:	051c92        	l16ui	a9, a12, 10
     b74:	5188           	l32i.n	a8, a1, 20
     b76:	442b           	addi.n	a4, a4, 2
     b78:	3139           	s32i.n	a3, a1, 12
     b7a:	ff7086        	j	940 <sbc_bit_allocation+0x98>

00000b7d <sbc_bit_allocation+0x2d5>:
     b7d:	060c           	movi.n	a6, 0
     b7f:	ff8e06        	j	9bb <sbc_bit_allocation+0x113>

00000b82 <sbc_bit_allocation+0x2da>:
     b82:	02ea17        	bbsi	a10, 1, b88 <sbc_bit_allocation+0x2e0>
     b85:	002a86        	j	c33 <sbc_bit_allocation+0x38b>
     b88:	2138           	l32i.n	a3, a1, 8
     b8a:	061c72        	l16ui	a7, a12, 12
     b8d:	221b           	addi.n	a2, a2, 1
     b8f:	5fa937        	bge	a9, a3, bf2 <sbc_bit_allocation+0x34a>
     b92:	05c716        	beqz	a7, bf2 <sbc_bit_allocation+0x34a>
     b95:	030c           	movi.n	a3, 0
     b97:	d40c           	movi.n	a4, 13
     b99:	150c           	movi.n	a5, 1
     b9b:	060c           	movi.n	a6, 0
     b9d:	4c8076        	loop	a0, bed <sbc_bit_allocation+0x345>
     ba0:	827370        	mull	a7, a3, a7
     ba3:	21d8           	l32i.n	a13, a1, 8
     ba5:	9077c0        	addx2	a7, a7, a12
     ba8:	908670        	addx2	a8, a6, a7
     bab:	0bd872        	addmi	a7, a8, 0xb00
     bae:	7517a2        	l16ui	a10, a7, 234
     bb1:	e91b           	addi.n	a14, a9, 1
     bb3:	0bd882        	addmi	a8, a8, 0xb00
     bb6:	fecab2        	addi	a11, a10, -2
     bb9:	9bbd           	ae_zext16	a11, a11
     bbb:	0634b7        	bltu	a4, a11, bc5 <sbc_bit_allocation+0x31d>
     bbe:	8a1b           	addi.n	a8, a10, 1
     bc0:	1a0c           	movi.n	a10, 1
     bc2:	000346        	j	bd3 <sbc_bit_allocation+0x32b>

00000bc5 <sbc_bit_allocation+0x31d>:
     bc5:	0faed7        	bge	a14, a13, bd8 <sbc_bit_allocation+0x330>
     bc8:	5598b2        	l16si	a11, a8, 170
     bcb:	280c           	movi.n	a8, 2
     bcd:	02a0a2        	movi	a10, 2
     bd0:	0492b7        	bne	a2, a11, bd8 <sbc_bit_allocation+0x330>
     bd3:	99aa           	add.n	a9, a9, a10
     bd5:	755782        	s16i	a8, a7, 234
     bd8:	081c72        	l16ui	a7, a12, 16
     bdb:	2179           	s32i.n	a7, a1, 8
     bdd:	061c82        	l16ui	a8, a12, 12
     be0:	0ea977        	bge	a9, a7, bf2 <sbc_bit_allocation+0x34a>
     be3:	663a           	add.n	a6, a6, a3
     be5:	303350        	xor	a3, a3, a5
     be8:	087d           	mov.n	a7, a8
     bea:	04b687        	bgeu	a6, a8, bf2 <sbc_bit_allocation+0x34a>

00000bed <sbc_bit_allocation+0x345>:
     bed:	ffeb06        	j	b9d <sbc_bit_allocation+0x2f5>

00000bf0 <sbc_bit_allocation+0x348>:
	...

00000bf2 <sbc_bit_allocation+0x34a>:
     bf2:	2128           	l32i.n	a2, a1, 8
     bf4:	130c           	movi.n	a3, 1
     bf6:	050c           	movi.n	a5, 0
     bf8:	37a927        	bge	a9, a2, c33 <sbc_bit_allocation+0x38b>
     bfb:	020c           	movi.n	a2, 0
     bfd:	2f8076        	loop	a0, c30 <sbc_bit_allocation+0x388>
     c00:	061c62        	l16ui	a6, a12, 12
     c03:	054d           	mov.n	a4, a5
     c05:	2ab267        	bgeu	a2, a6, c33 <sbc_bit_allocation+0x38b>
     c08:	82f560        	mull	a15, a5, a6
     c0b:	905fc0        	addx2	a5, a15, a12
     c0e:	905250        	addx2	a5, a2, a5
     c11:	0bd552        	addmi	a5, a5, 0xb00
     c14:	751562        	l16ui	a6, a5, 234
     c17:	0bb6f6        	bgeui	a6, 16, c26 <sbc_bit_allocation+0x37e>
     c1a:	661b           	addi.n	a6, a6, 1
     c1c:	755562        	s16i	a6, a5, 234
     c1f:	081c52        	l16ui	a5, a12, 16
     c22:	991b           	addi.n	a9, a9, 1
     c24:	2159           	s32i.n	a5, a1, 8
     c26:	21f8           	l32i.n	a15, a1, 8
     c28:	305430        	xor	a5, a4, a3
     c2b:	224a           	add.n	a2, a2, a4
     c2d:	02a9f7        	bge	a9, a15, c33 <sbc_bit_allocation+0x38b>

00000c30 <sbc_bit_allocation+0x388>:
     c30:	fff246        	j	bfd <sbc_bit_allocation+0x355>

00000c33 <sbc_bit_allocation+0x38b>:
     c33:	f01d           	retw.n

00000c35 <sbc_bit_allocation+0x38d>:
     c35:	000000                                        ...

00000c38 <SAT_ADD>:
     c38:	004136        	entry	a1, 32
     c3b:	360334        	ae_cvtq48a32s	aeq0, a3
     c3e:	364234        	ae_cvtq48a32s	aeq1, a2
     c41:	061804        	ae_addsq56s	aeq0, aeq1, aeq0
     c44:	060834        	ae_roundsq32sym	aeq0, aeq0
     c47:	368204        	ae_trunca32q48	a2, aeq0
     c4a:	f01d           	retw.n

00000c4c <SAT_SUB>:
     c4c:	004136        	entry	a1, 32
     c4f:	360334        	ae_cvtq48a32s	aeq0, a3
     c52:	364234        	ae_cvtq48a32s	aeq1, a2
     c55:	061814        	ae_subsq56s	aeq0, aeq1, aeq0
     c58:	060834        	ae_roundsq32sym	aeq0, aeq0
     c5b:	368204        	ae_trunca32q48	a2, aeq0
     c5e:	f01d           	retw.n

00000c60 <sbc_reconstruction>:
     c60:	006136        	entry	a1, 48
     c63:	1a1282        	l16ui	a8, a2, 52
     c66:	e5a572        	movi	a7, 0x5e5
     c69:	1177f0        	slli	a7, a7, 1
     c6c:	025d           	mov.n	a5, a2
     c6e:	627a           	add.n	a6, a2, a7
     c70:	c8ac           	beqz.n	a8, ca0 <sbc_reconstruction+0x40>
     c72:	f5a532        	movi	a3, 0x5f5
     c75:	04a042        	movi	a4, 4
     c78:	79a1f2        	movi	a15, 0x179
     c7b:	1133f0        	slli	a3, a3, 1
     c7e:	300444        	ae_cvtp24a16x2.ll	aep0, a4, a4
     c81:	114fd0        	slli	a4, a15, 3
     c84:	38c522        	addi	a2, a5, 56
     c87:	402204        	ae_lp16f.i	aep2, a2, 0
     c8a:	419354        	ae_lp16f.xu	aep1, a3, a5
     c8d:	804540        	add	a4, a5, a4
     c90:	0c8876        	loop	a8, ca0 <sbc_reconstruction+0x40>
     c93:	dd2aac931f 	{ ae_lp16f.iu	aep1, a3, 2; ae_subsp24s	aep2, aep2, aep1 }
     c98:	d9096ca21f 	{ ae_lp16f.iu	aep2, a2, 2; ae_addsp24s	aep3, aep2, aep0 }
     c9d:	42b414        	ae_sp16f.l.iu	aep3, a4, 2

00000ca0 <sbc_reconstruction+0x40>:
     ca0:	1a1522        	l16ui	a2, a5, 52
     ca3:	1b1592        	l16ui	a9, a5, 54
     ca6:	f3f660        	wur.ae_cbegin0	a6
     ca9:	902250        	addx2	a2, a2, a5
     cac:	803270        	add	a3, a2, a7
     caf:	70c522        	addi	a2, a5, 112
     cb2:	f3f730        	wur.ae_cend0	a3
     cb5:	fc24bff23e 	{ l32i	a3, a2, 0x3fc; ae_zeroq56	aeq0 }
     cba:	89bc           	beqz.n	a9, cf6 <sbc_reconstruction+0x96>
     cbc:	fce081        	l32r	a8, 3c (1a40 <S_ARRAY>)
     cbf:	54c542        	addi	a4, a5, 84
     cc2:	02a072        	movi	a7, 2
     cc5:	2d8976        	loop	a9, cf6 <sbc_reconstruction+0x96>
     cc8:	101692        	l16ui	a9, a6, 32
     ccb:	fc24d9067f 	{ ae_lp16f.c	aep0, a6, a7; nop }
     cd0:	03a794        	ae_lb	a10, a9
     cd3:	a99c           	beqz.n	a9, cf1 <sbc_reconstruction+0x91>
     cd5:	11b9e0        	slli	a11, a9, 2
     cd8:	4518b4        	ae_lp16x2f.x	aep1, a8, a11
     cdb:	302aa4        	ae_cvtp24a16x2.ll	aep2, a10, a10
     cde:	dd2b3f0f6f 	{ ae_trunca16p24s.l	a15, aep0; ae_subp24	aep2, aep2, aep1 }
     ce3:	021264        	ae_mulp24s.lh	aeq0, aep1, aep2
     ce6:	1c1394        	ae_db	a3, a9
     ce9:	fc24fe8f0f 	{ ae_slaasq56s	aeq0, aeq0, a15; nop }
     cee:	060834        	ae_roundsq32sym	aeq0, aeq0
     cf1:	fc24b9c41f 	{ ae_sq32f.iu	aeq0, a4, 4; ae_zeroq56	aeq0 }

00000cf6 <sbc_reconstruction+0x96>:
     cf6:	10d542        	addmi	a4, a5, 0x1000
     cf9:	081442        	l16ui	a4, a4, 16
     cfc:	ff6232        	s32i	a3, a2, 0x3fc
     cff:	6cc532        	addi	a3, a5, 108
     d02:	09a416        	beqz	a4, da0 <sbc_reconstruction+0x140>
     d05:	022466        	bnei	a4, 2, d0b <sbc_reconstruction+0xab>
     d08:	005186        	j	e52 <sbc_reconstruction+0x1f2>
     d0b:	021426        	beqi	a4, 1, d11 <sbc_reconstruction+0xb1>
     d0e:	00c986        	j	1038 <sbc_reconstruction+0x3d8>
     d11:	171522        	l16ui	a2, a5, 46
     d14:	1b15c2        	l16ui	a12, a5, 54
     d17:	061542        	l16ui	a4, a5, 12
     d1a:	31a216        	beqz	a2, 1038 <sbc_reconstruction+0x3d8>
     d1d:	ff2322        	l32i	a2, a3, 0x3fc
     d20:	a8ab32        	movi	a3, 0xfffffba8
     d23:	c02250        	sub	a2, a2, a5
     d26:	a23a           	add.n	a10, a2, a3
     d28:	21b1a0        	srai	a11, a10, 1
     d2b:	02fc26        	beqi	a12, 0x100, d31 <sbc_reconstruction+0xd1>
     d2e:	00a6c6        	j	fcd <sbc_reconstruction+0x36d>
     d31:	00a1c2        	movi	a12, 0x100
     d34:	028426        	beqi	a4, 8, d3a <sbc_reconstruction+0xda>
     d37:	00a546        	j	fd0 <sbc_reconstruction+0x370>
     d3a:	902b50        	addx2	a2, a11, a5
     d3d:	56a432        	movi	a3, 0x456
     d40:	923a           	add.n	a9, a2, a3
     d42:	040c           	movi.n	a4, 0

00000d44 <sbc_reconstruction+0xe4>:
     d44:	4d1aa6        	blti	a10, 1, d95 <sbc_reconstruction+0x135>
     d47:	492d           	ae_l16ui.n	a2, a9, 0
     d49:	cb0b           	addi.n	a12, a11, -1
     d4b:	fec982        	addi	a8, a9, -2
     d4e:	242a           	add.n	a2, a4, a2
     d50:	a03250        	addx4	a3, a2, a5
     d53:	162372        	l32i	a7, a3, 88
     d56:	1e2362        	l32i	a6, a3, 120
     d59:	052d           	mov.n	a2, a5
     d5b:	085d           	mov.n	a5, a8
     d5d:	209c76        	loopnez	a12, d81 <sbc_reconstruction+0x121>
     d60:	458d           	ae_l16ui.n	a8, a5, 0
     d62:	364734        	ae_cvtq48a32s	aeq1, a7
     d65:	360634        	ae_cvtq48a32s	aeq0, a6
     d68:	f86a50648f 	{ add	a6, a4, a8; ae_addsq56s	aeq0, aeq1, aeq0 }
     d6d:	fc444fe55e 	{ addi	a5, a5, -2; ae_roundsq32sym	aeq0, aeq0 }
     d72:	368704        	ae_trunca32q48	a7, aeq0
     d75:	166372        	s32i	a7, a3, 88
     d78:	a03620        	addx4	a3, a6, a2
     d7b:	162372        	l32i	a7, a3, 88
     d7e:	1e2362        	l32i	a6, a3, 120

00000d81 <sbc_reconstruction+0x121>:
     d81:	360734        	ae_cvtq48a32s	aeq0, a7
     d84:	364634        	ae_cvtq48a32s	aeq1, a6
     d87:	f86653522f 	{ or	a5, a2, a2; ae_addsq56s	aeq0, aeq0, aeq1 }
     d8c:	060834        	ae_roundsq32sym	aeq0, aeq0
     d8f:	368f04        	ae_trunca32q48	a15, aeq0
     d92:	1663f2        	s32i	a15, a3, 88

00000d95 <sbc_reconstruction+0x135>:
     d95:	10c442        	addi	a4, a4, 16
     d98:	a8f4b6        	bltui	a4, 0x100, d44 <sbc_reconstruction+0xe4>
     d9b:	00a646        	j	1038 <sbc_reconstruction+0x3d8>

00000d9e <sbc_reconstruction+0x13e>:
	...

00000da0 <sbc_reconstruction+0x140>:
     da0:	171522        	l16ui	a2, a5, 46
     da3:	6cc532        	addi	a3, a5, 108
     da6:	ff2342        	l32i	a4, a3, 0x3fc
     da9:	28b216        	beqz	a2, 1038 <sbc_reconstruction+0x3d8>
     dac:	1b15e2        	l16ui	a14, a5, 54
     daf:	a8ab32        	movi	a3, 0xfffffba8
     db2:	c02450        	sub	a2, a4, a5
     db5:	223a           	add.n	a2, a2, a3
     db7:	3129           	s32i.n	a2, a1, 12
     db9:	212120        	srai	a2, a2, 1
     dbc:	2129           	s32i.n	a2, a1, 8
     dbe:	02fe26        	beqi	a14, 0x100, dc4 <sbc_reconstruction+0x164>
     dc1:	004746        	j	ee2 <sbc_reconstruction+0x282>
     dc4:	061522        	l16ui	a2, a5, 12
     dc7:	00a1e2        	movi	a14, 0x100
     dca:	2168           	l32i.n	a6, a1, 8
     dcc:	028226        	beqi	a2, 8, dd2 <sbc_reconstruction+0x172>
     dcf:	004486        	j	ee5 <sbc_reconstruction+0x285>
     dd2:	56a432        	movi	a3, 0x456
     dd5:	040c           	movi.n	a4, 0
     dd7:	902650        	addx2	a2, a6, a5
     dda:	923a           	add.n	a9, a2, a3
     ddc:	3128           	l32i.n	a2, a1, 12
     dde:	2138           	l32i.n	a3, a1, 8
     de0:	fec972        	addi	a7, a9, -2
     de3:	6012a6        	blti	a2, 1, e47 <sbc_reconstruction+0x1e7>
     de6:	492d           	ae_l16ui.n	a2, a9, 0
     de8:	830b           	addi.n	a8, a3, -1
     dea:	242a           	add.n	a2, a4, a2
     dec:	a03250        	addx4	a3, a2, a5
     def:	1e2362        	l32i	a6, a3, 120
     df2:	052d           	mov.n	a2, a5
     df4:	075d           	mov.n	a5, a7
     df6:	2b9876        	loopnez	a8, e25 <sbc_reconstruction+0x1c5>
     df9:	458d           	ae_l16ui.n	a8, a5, 0
     dfb:	162372        	l32i	a7, a3, 88
     dfe:	364634        	ae_cvtq48a32s	aeq1, a6
     e01:	368734        	ae_cvtq48a32s	aeq2, a7
     e04:	f85690648f 	{ add	a6, a4, a8; ae_subsq56s	aeq0, aeq2, aeq1 }
     e09:	f9764fe55e 	{ addi	a5, a5, -2; ae_addsq56s	aeq1, aeq2, aeq1 }
     e0e:	060834        	ae_roundsq32sym	aeq0, aeq0
     e11:	fc4c7f08ef 	{ ae_trunca32q48	a8, aeq0; ae_roundsq32sym	aeq0, aeq1 }
     e16:	368704        	ae_trunca32q48	a7, aeq0
     e19:	166372        	s32i	a7, a3, 88
     e1c:	1e6382        	s32i	a8, a3, 120
     e1f:	a03620        	addx4	a3, a6, a2
     e22:	1e2362        	l32i	a6, a3, 120

00000e25 <sbc_reconstruction+0x1c5>:
     e25:	1623d2        	l32i	a13, a3, 88
     e28:	360634        	ae_cvtq48a32s	aeq0, a6
     e2b:	364d34        	ae_cvtq48a32s	aeq1, a13
     e2e:	fa4a93522f 	{ or	a5, a2, a2; ae_subsq56s	aeq2, aeq1, aeq0 }
     e33:	061804        	ae_addsq56s	aeq0, aeq1, aeq0
     e36:	06e834        	ae_roundsq32sym	aeq3, aeq2
     e39:	fc447f3eef 	{ ae_trunca32q48	a14, aeq3; ae_roundsq32sym	aeq0, aeq0 }
     e3e:	368f04        	ae_trunca32q48	a15, aeq0
     e41:	1663f2        	s32i	a15, a3, 88
     e44:	1e63e2        	s32i	a14, a3, 120

00000e47 <sbc_reconstruction+0x1e7>:
     e47:	10c442        	addi	a4, a4, 16
     e4a:	8ef4b6        	bltui	a4, 0x100, ddc <sbc_reconstruction+0x17c>
     e4d:	0079c6        	j	1038 <sbc_reconstruction+0x3d8>

00000e50 <sbc_reconstruction+0x1f0>:
	...

00000e52 <sbc_reconstruction+0x1f2>:
     e52:	171522        	l16ui	a2, a5, 46
     e55:	6cc532        	addi	a3, a5, 108
     e58:	ff2342        	l32i	a4, a3, 0x3fc
     e5b:	1d9216        	beqz	a2, 1038 <sbc_reconstruction+0x3d8>
     e5e:	1b15c2        	l16ui	a12, a5, 54
     e61:	a8ab32        	movi	a3, 0xfffffba8
     e64:	c02450        	sub	a2, a4, a5
     e67:	a23a           	add.n	a10, a2, a3
     e69:	21b1a0        	srai	a11, a10, 1
     e6c:	02fc26        	beqi	a12, 0x100, e72 <sbc_reconstruction+0x212>
     e6f:	003c86        	j	f65 <sbc_reconstruction+0x305>
     e72:	061522        	l16ui	a2, a5, 12
     e75:	00a1c2        	movi	a12, 0x100
     e78:	904b50        	addx2	a4, a11, a5
     e7b:	028226        	beqi	a2, 8, e81 <sbc_reconstruction+0x221>
     e7e:	003986        	j	f68 <sbc_reconstruction+0x308>
     e81:	56a432        	movi	a3, 0x456
     e84:	943a           	add.n	a9, a4, a3
     e86:	040c           	movi.n	a4, 0
     e88:	4d1aa6        	blti	a10, 1, ed9 <sbc_reconstruction+0x279>
     e8b:	492d           	ae_l16ui.n	a2, a9, 0
     e8d:	cb0b           	addi.n	a12, a11, -1
     e8f:	fec982        	addi	a8, a9, -2
     e92:	242a           	add.n	a2, a4, a2
     e94:	a03250        	addx4	a3, a2, a5
     e97:	162372        	l32i	a7, a3, 88
     e9a:	1e2362        	l32i	a6, a3, 120
     e9d:	052d           	mov.n	a2, a5
     e9f:	085d           	mov.n	a5, a8
     ea1:	209c76        	loopnez	a12, ec5 <sbc_reconstruction+0x265>
     ea4:	458d           	ae_l16ui.n	a8, a5, 0
     ea6:	364734        	ae_cvtq48a32s	aeq1, a7
     ea9:	360634        	ae_cvtq48a32s	aeq0, a6
     eac:	f84a90648f 	{ add	a6, a4, a8; ae_subsq56s	aeq0, aeq1, aeq0 }
     eb1:	fc444fe55e 	{ addi	a5, a5, -2; ae_roundsq32sym	aeq0, aeq0 }
     eb6:	368704        	ae_trunca32q48	a7, aeq0
     eb9:	1e6372        	s32i	a7, a3, 120
     ebc:	a03620        	addx4	a3, a6, a2
     ebf:	162372        	l32i	a7, a3, 88
     ec2:	1e2362        	l32i	a6, a3, 120

00000ec5 <sbc_reconstruction+0x265>:
     ec5:	360734        	ae_cvtq48a32s	aeq0, a7
     ec8:	364634        	ae_cvtq48a32s	aeq1, a6
     ecb:	f84693522f 	{ or	a5, a2, a2; ae_subsq56s	aeq0, aeq0, aeq1 }
     ed0:	060834        	ae_roundsq32sym	aeq0, aeq0
     ed3:	368f04        	ae_trunca32q48	a15, aeq0
     ed6:	1e63f2        	s32i	a15, a3, 120

00000ed9 <sbc_reconstruction+0x279>:
     ed9:	10c442        	addi	a4, a4, 16
     edc:	a8f4b6        	bltui	a4, 0x100, e88 <sbc_reconstruction+0x228>
     edf:	005546        	j	1038 <sbc_reconstruction+0x3d8>

00000ee2 <sbc_reconstruction+0x282>:
     ee2:	152e16        	beqz	a14, 1038 <sbc_reconstruction+0x3d8>
     ee5:	2128           	l32i.n	a2, a1, 8
     ee7:	0615f2        	l16ui	a15, a5, 12
     eea:	56a432        	movi	a3, 0x456
     eed:	902250        	addx2	a2, a2, a5
     ef0:	070c           	movi.n	a7, 0
     ef2:	58c542        	addi	a4, a5, 88
     ef5:	d23a           	add.n	a13, a2, a3
     ef7:	11cff0        	slli	a12, a15, 1
     efa:	3128           	l32i.n	a2, a1, 12
     efc:	2158           	l32i.n	a5, a1, 8
     efe:	fecd82        	addi	a8, a13, -2
     f01:	5612a6        	blti	a2, 1, f5b <sbc_reconstruction+0x2fb>
     f04:	4d3d           	ae_l16ui.n	a3, a13, 0
     f06:	2f7a           	add.n	a2, a15, a7
     f08:	950b           	addi.n	a9, a5, -1
     f0a:	b73a           	add.n	a11, a7, a3
     f0c:	323a           	add.n	a3, a2, a3
     f0e:	a05b40        	addx4	a5, a11, a4
     f11:	a06340        	addx4	a6, a3, a4
     f14:	608504        	ae_lq32f.i	aeq2, a5, 0
     f17:	289976        	loopnez	a9, f43 <sbc_reconstruction+0x2e3>
     f1a:	489d           	ae_l16ui.n	a9, a8, 0
     f1c:	604604        	ae_lq32f.i	aeq1, a6, 0
     f1f:	f8764fe88e 	{ addi	a8, a8, -2; ae_addsq56s	aeq0, aeq2, aeq1 }
     f24:	f95690329f 	{ add	a3, a2, a9; ae_subsq56s	aeq1, aeq2, aeq1 }
     f29:	fc4450b79f 	{ add	a11, a7, a9; ae_roundsq32sym	aeq0, aeq0 }
     f2e:	fc4c7f0aef 	{ ae_trunca32q48	a10, aeq0; ae_roundsq32sym	aeq0, aeq1 }
     f33:	368904        	ae_trunca32q48	a9, aeq0
     f36:	05a9           	s32i.n	a10, a5, 0
     f38:	a05b40        	addx4	a5, a11, a4
     f3b:	0699           	s32i.n	a9, a6, 0
     f3d:	a06340        	addx4	a6, a3, a4
     f40:	608504        	ae_lq32f.i	aeq2, a5, 0

00000f43 <sbc_reconstruction+0x2e3>:
     f43:	600604        	ae_lq32f.i	aeq0, a6, 0
     f46:	066804        	ae_addsq56s	aeq1, aeq2, aeq0
     f49:	062814        	ae_subsq56s	aeq0, aeq2, aeq0
     f4c:	065834        	ae_roundsq32sym	aeq1, aeq1
     f4f:	fc447f12ef 	{ ae_trunca32q48	a2, aeq1; ae_roundsq32sym	aeq0, aeq0 }
     f54:	368304        	ae_trunca32q48	a3, aeq0
     f57:	0529           	s32i.n	a2, a5, 0
     f59:	0639           	s32i.n	a3, a6, 0

00000f5b <sbc_reconstruction+0x2fb>:
     f5b:	77ca           	add.n	a7, a7, a12
     f5d:	9937e7        	bltu	a7, a14, efa <sbc_reconstruction+0x29a>
     f60:	003506        	j	1038 <sbc_reconstruction+0x3d8>

00000f63 <sbc_reconstruction+0x303>:
	...

00000f65 <sbc_reconstruction+0x305>:
     f65:	0cfc16        	beqz	a12, 1038 <sbc_reconstruction+0x3d8>
     f68:	0615d2        	l16ui	a13, a5, 12
     f6b:	902b50        	addx2	a2, a11, a5
     f6e:	56a462        	movi	a6, 0x456
     f71:	040c           	movi.n	a4, 0
     f73:	58c532        	addi	a3, a5, 88
     f76:	80e260        	add	a14, a2, a6
     f79:	11fdf0        	slli	a15, a13, 1
     f7c:	451aa6        	blti	a10, 1, fc5 <sbc_reconstruction+0x365>
     f7f:	4e6d           	ae_l16ui.n	a6, a14, 0
     f81:	2d4a           	add.n	a2, a13, a4
     f83:	8b0b           	addi.n	a8, a11, -1
     f85:	746a           	add.n	a7, a4, a6
     f87:	a07730        	addx4	a7, a7, a3
     f8a:	626a           	add.n	a6, a2, a6
     f8c:	604704        	ae_lq32f.i	aeq1, a7, 0
     f8f:	fece52        	addi	a5, a14, -2
     f92:	a07630        	addx4	a7, a6, a3
     f95:	1e9876        	loopnez	a8, fb7 <sbc_reconstruction+0x357>
     f98:	459d           	ae_l16ui.n	a9, a5, 0
     f9a:	600704        	ae_lq32f.i	aeq0, a7, 0
     f9d:	f84a8fe55e 	{ addi	a5, a5, -2; ae_subsq56s	aeq0, aeq1, aeq0 }
     fa2:	fc4450849f 	{ add	a8, a4, a9; ae_roundsq32sym	aeq0, aeq0 }
     fa7:	368604        	ae_trunca32q48	a6, aeq0
     faa:	a08830        	addx4	a8, a8, a3
     fad:	0769           	s32i.n	a6, a7, 0
     faf:	604804        	ae_lq32f.i	aeq1, a8, 0
     fb2:	629a           	add.n	a6, a2, a9
     fb4:	a07630        	addx4	a7, a6, a3

00000fb7 <sbc_reconstruction+0x357>:
     fb7:	600704        	ae_lq32f.i	aeq0, a7, 0
     fba:	061814        	ae_subsq56s	aeq0, aeq1, aeq0
     fbd:	060834        	ae_roundsq32sym	aeq0, aeq0
     fc0:	368204        	ae_trunca32q48	a2, aeq0
     fc3:	0729           	s32i.n	a2, a7, 0

00000fc5 <sbc_reconstruction+0x365>:
     fc5:	44fa           	add.n	a4, a4, a15
     fc7:	b134c7        	bltu	a4, a12, f7c <sbc_reconstruction+0x31c>
     fca:	001a86        	j	1038 <sbc_reconstruction+0x3d8>

00000fcd <sbc_reconstruction+0x36d>:
     fcd:	067c16        	beqz	a12, 1038 <sbc_reconstruction+0x3d8>
     fd0:	0615d2        	l16ui	a13, a5, 12
     fd3:	902b50        	addx2	a2, a11, a5
     fd6:	56a442        	movi	a4, 0x456
     fd9:	060c           	movi.n	a6, 0
     fdb:	58c532        	addi	a3, a5, 88
     fde:	80e240        	add	a14, a2, a4
     fe1:	11fdf0        	slli	a15, a13, 1
     fe4:	4b1aa6        	blti	a10, 1, 1033 <sbc_reconstruction+0x3d3>
     fe7:	4e4d           	ae_l16ui.n	a4, a14, 0
     fe9:	2d6a           	add.n	a2, a13, a6
     feb:	8b0b           	addi.n	a8, a11, -1
     fed:	524a           	add.n	a5, a2, a4
     fef:	464a           	add.n	a4, a6, a4
     ff1:	a05530        	addx4	a5, a5, a3
     ff4:	fece72        	addi	a7, a14, -2
     ff7:	600504        	ae_lq32f.i	aeq0, a5, 0
     ffa:	065d           	mov.n	a5, a6
     ffc:	a04430        	addx4	a4, a4, a3
     fff:	076d           	mov.n	a6, a7
    1001:	1e9876        	loopnez	a8, 1023 <sbc_reconstruction+0x3c3>
    1004:	468d           	ae_l16ui.n	a8, a6, 0
    1006:	604404        	ae_lq32f.i	aeq1, a4, 0
    1009:	f86a4fe66e 	{ addi	a6, a6, -2; ae_addsq56s	aeq0, aeq1, aeq0 }
    100e:	fc4450958f 	{ add	a9, a5, a8; ae_roundsq32sym	aeq0, aeq0 }
    1013:	368704        	ae_trunca32q48	a7, aeq0
    1016:	828a           	add.n	a8, a2, a8
    1018:	0479           	s32i.n	a7, a4, 0
    101a:	a04930        	addx4	a4, a9, a3
    101d:	a07830        	addx4	a7, a8, a3
    1020:	600704        	ae_lq32f.i	aeq0, a7, 0

00001023 <sbc_reconstruction+0x3c3>:
    1023:	604404        	ae_lq32f.i	aeq1, a4, 0
    1026:	f86a53655f 	{ or	a6, a5, a5; ae_addsq56s	aeq0, aeq1, aeq0 }
    102b:	060834        	ae_roundsq32sym	aeq0, aeq0
    102e:	368204        	ae_trunca32q48	a2, aeq0
    1031:	0429           	s32i.n	a2, a4, 0

00001033 <sbc_reconstruction+0x3d3>:
    1033:	66fa           	add.n	a6, a6, a15
    1035:	ab36c7        	bltu	a6, a12, fe4 <sbc_reconstruction+0x384>
    1038:	f01d           	retw.n

0000103a <sbc_reconstruction+0x3da>:
    103a:	00000000                                 ......

00001040 <SBC_synthesis4_per_channel>:
    1040:	006136        	entry	a1, 48
    1043:	0314f2        	l16ui	a15, a4, 6
    1046:	045d           	mov.n	a5, a4
    1048:	060c           	movi.n	a6, 0
    104a:	230f16        	beqz	a15, 127e <SBC_synthesis4_per_channel+0x23e>
    104d:	fbfc71        	l32r	a7, 40 (1a90 <SBC_cos_coef_4>)
    1050:	622620        	saltu	a2, a6, a2
    1053:	1122c0        	slli	a2, a2, 4
    1056:	0bd542        	addmi	a4, a5, 0xb00
    1059:	de2c           	movi.n	a14, 45
    105b:	3149           	s32i.n	a4, a1, 12
    105d:	114e70        	slli	a4, a14, 9
    1060:	40c7f2        	addi	a15, a7, 64
    1063:	252a           	add.n	a2, a5, a2
    1065:	fc248fe33e 	{ addi	a3, a3, -2; ae_zeroq56	aeq0 }
    106a:	0bd582        	addmi	a8, a5, 0xb00
    106d:	8b0c           	movi.n	a11, 8
    106f:	ff0458844f 	{ ae_cvtp24a16x2.ll	aep0, a4, a4; ae_movq56	aeq3, aeq0 }
    1074:	fd044582ce 	{ addi	a12, a2, 88; ae_movq56	aeq1, aeq0 }
    1079:	0261f2        	s32i	a15, a1, 8

0000107c <SBC_synthesis4_per_channel+0x3c>:
    107c:	5218e2        	l16ui	a14, a8, 164
    107f:	10cc22        	addi	a2, a12, 16
    1082:	fbefa1        	l32r	a10, 40 (1a90 <SBC_cos_coef_4>)
    1085:	2178           	l32i.n	a7, a1, 8
    1087:	f3f720        	wur.ae_cend0	a2
    108a:	3148           	l32i.n	a4, a1, 12
    108c:	f3f6c0        	wur.ae_cbegin0	a12
    108f:	0420e0        	extui	a2, a14, 0, 1
    1092:	93a720        	movnez	a10, a7, a2
    1095:	fe047284fe 	{ l32i	a15, a4, 160; ae_movq56	aeq2, aeq0 }
    109a:	0c4d           	mov.n	a4, a12
    109c:	f8cad2        	addi	a13, a10, -8
    109f:	fc24dd94bf 	{ ae_lp24x2f.c	aep1, a4, a11; nop }
    10a4:	5cad14        	ae_lp24x2f.iu	aep2, a13, 8
    10a7:	e2442fcd1f 	{ ae_lp24x2f.iu	aep4, a13, 8; ae_mulaafp24s.hh.ll	aeq0, aep1, aep2 }
    10ac:	fc24ddb4bf 	{ ae_lp24x2f.c	aep3, a4, a11; nop }
    10b1:	e28c2fdd1f 	{ ae_lp24x2f.iu	aep5, a13, 8; ae_mulaafp24s.hh.ll	aeq0, aep3, aep4 }
    10b6:	a07ef0        	addx4	a7, a14, a15
    10b9:	fbe7affd1f 	{ ae_lp24x2f.iu	aep7, a13, 8; ae_roundsp24q48sym	aep6, aeq0 }
    10be:	526704        	ae_sp24f.l.i	aep6, a7, 0
    10c1:	fc0c5da4bf 	{ ae_lp24x2f.c	aep2, a4, a11; ae_movq56	aeq0, aeq1 }
    10c6:	e3a85dc4bf 	{ ae_lp24x2f.c	aep4, a4, a11; ae_mulaafp24s.hh.ll	aeq3, aep2, aep5 }
    10cb:	e3f04287ae 	{ addi	a10, a7, 40; ae_mulaafp24s.hh.ll	aeq3, aep4, aep7 }
    10d0:	5cdd14        	ae_lp24x2f.iu	aep5, a13, 8
    10d3:	fbffaffd1f 	{ ae_lp24x2f.iu	aep7, a13, 8; ae_roundsp24q48sym	aep6, aeq3 }
    10d8:	526a04        	ae_sp24f.l.i	aep6, a10, 0
    10db:	ff0c5da4bf 	{ ae_lp24x2f.c	aep2, a4, a11; ae_movq56	aeq3, aeq1 }
    10e0:	e2a85da4bf 	{ ae_lp24x2f.c	aep2, a4, a11; ae_mulaafp24s.hh.ll	aeq1, aep2, aep5 }
    10e5:	e2e8428aae 	{ addi	a10, a10, 40; ae_mulaafp24s.hh.ll	aeq1, aep2, aep7 }
    10ea:	b90c           	movi.n	a9, 11
    10ec:	1b9c14        	ae_roundsp24q48sym	aep1, aeq1
    10ef:	521a04        	ae_sp24f.l.i	aep1, a10, 0
    10f2:	5c9d14        	ae_lp24x2f.iu	aep1, a13, 8
    10f5:	fd045db4bf 	{ ae_lp24x2f.c	aep3, a4, a11; ae_movq56	aeq1, aeq0 }
    10fa:	e32c1dc4bf 	{ ae_lp24x2f.c	aep4, a4, a11; ae_mulaafp24s.hh.ll	aeq2, aep3, aep1 }
    10ff:	5cdd14        	ae_lp24x2f.iu	aep5, a13, 8
    1102:	05c504        	ae_mulaafp24s.hh.ll	aeq2, aep4, aep5
    1105:	117e90        	slli	a7, a14, 7
    1108:	119970        	slli	a9, a9, 9
    110b:	fbf7ab979f 	{ ae_truncp24a32x2	aep1, a7, a9; ae_roundsp24q48sym	aep6, aeq2 }
    1110:	28ca72        	addi	a7, a10, 40
    1113:	526704        	ae_sp24f.l.i	aep6, a7, 0
    1116:	5cad14        	ae_lp24x2f.iu	aep2, a13, 8
    1119:	fe045df4bf 	{ ae_lp24x2f.c	aep7, a4, a11; ae_movq56	aeq2, aeq0 }
    111e:	e35c5dc4bf 	{ ae_lp24x2f.c	aep4, a4, a11; ae_mulaafp24s.hh.ll	aeq3, aep7, aep2 }
    1123:	5cdd14        	ae_lp24x2f.iu	aep5, a13, 8
    1126:	e3b042877e 	{ addi	a7, a7, 40; ae_mulaafp24s.hh.ll	aeq3, aep4, aep5 }
    112b:	a0a092        	movi	a9, 160
    112e:	f9ff90af9f 	{ add	a10, a15, a9; ae_roundsp24q48sym	aep2, aeq3 }
    1133:	522704        	ae_sp24f.l.i	aep2, a7, 0
    1136:	5cad14        	ae_lp24x2f.iu	aep2, a13, 8
    1139:	ff045de4bf 	{ ae_lp24x2f.c	aep6, a4, a11; ae_movq56	aeq3, aeq0 }
    113e:	e2585df4bf 	{ ae_lp24x2f.c	aep7, a4, a11; ae_mulaafp24s.hh.ll	aeq1, aep6, aep2 }
    1143:	5cdd14        	ae_lp24x2f.iu	aep5, a13, 8
    1146:	e2bc42877e 	{ addi	a7, a7, 40; ae_mulaafp24s.hh.ll	aeq1, aep7, aep5 }
    114b:	ee1b           	addi.n	a14, a14, 1
    114d:	f9ef8f6e9e 	{ addi	a9, a14, -10; ae_roundsp24q48sym	aep2, aeq1 }
    1152:	522704        	ae_sp24f.l.i	aep2, a7, 0
    1155:	5cad14        	ae_lp24x2f.iu	aep2, a13, 8
    1158:	ea24dde4bf 	{ ae_lp24x2f.c	aep6, a4, a11; ae_mulfp24s.hl	aeq1, aep1, aep1 }
    115d:	e3581df4bf 	{ ae_lp24x2f.c	aep7, a4, a11; ae_mulaafp24s.hh.ll	aeq2, aep6, aep2 }
    1162:	5ccd14        	ae_lp24x2f.iu	aep4, a13, 8
    1165:	e39c02877e 	{ addi	a7, a7, 40; ae_mulaafp24s.hh.ll	aeq2, aep7, aep4 }
    116a:	f8f7fa944f 	{ ae_slliq56	aeq1, aeq1, 16; ae_roundsp24q48sym	aep1, aeq2 }
    116f:	521704        	ae_sp24f.l.i	aep1, a7, 0
    1172:	fc24ddd4bf 	{ ae_lp24x2f.c	aep5, a4, a11; nop }
    1177:	fc24dde4bf 	{ ae_lp24x2f.c	aep6, a4, a11; nop }
    117c:	5c9d14        	ae_lp24x2f.iu	aep1, a13, 8
    117f:	83af20        	moveqz	a10, a15, a2
    1182:	e3347f14ef 	{ ae_trunca32q48	a4, aeq1; ae_mulaafp24s.hh.ll	aeq3, aep5, aep1 }
    1187:	fbaff1        	l32r	a15, 44 (1e50 <SBC_proto_coef_4>)
    118a:	5cfd14        	ae_lp24x2f.iu	aep7, a13, 8
    118d:	939e90        	movnez	a9, a14, a9
    1190:	e3f84001ef 	{ movi	a14, 1; ae_mulaafp24s.hh.ll	aeq3, aep6, aep7 }
    1195:	3022e0        	xor	a2, a2, a14
    1198:	a044f0        	addx4	a4, a4, a15
    119b:	a02240        	addx4	a2, a2, a4
    119e:	525892        	s16i	a9, a8, 164
    11a1:	f9ff82879e 	{ addi	a9, a7, 40; ae_roundsp24q48sym	aep2, aeq3 }
    11a6:	fcc2f2        	addi	a15, a2, -4
    11a9:	522904        	ae_sp24f.l.i	aep2, a9, 0
    11ac:	509f14        	ae_lp24f.iu	aep1, a15, 4
    11af:	50bf14        	ae_lp24f.iu	aep3, a15, 4
    11b2:	dc65cf8a4e 	{ addi	a4, a10, -8; ae_selp24.lh	aep1, aep1, aep3 }
    11b7:	50df14        	ae_lp24f.iu	aep5, a15, 4
    11ba:	5cc414        	ae_lp24x2f.iu	aep4, a4, 8
    11bd:	e2302eef1f 	{ ae_lp24f.iu	aep6, a15, 4; ae_mulaafp24s.hh.ll	aeq0, aep4, aep1 }
    11c2:	dcd5eecf1f 	{ ae_lp24f.iu	aep4, a15, 4; ae_selp24.lh	aep1, aep5, aep6 }
    11c7:	5cf414        	ae_lp24x2f.iu	aep7, a4, 8
    11ca:	e23c2edf1f 	{ ae_lp24f.iu	aep5, a15, 4; ae_mulaafp24s.hh.ll	aeq0, aep7, aep1 }
    11cf:	dcb1eeff1f 	{ ae_lp24f.iu	aep7, a15, 4; ae_selp24.lh	aep1, aep4, aep5 }
    11d4:	50bf14        	ae_lp24f.iu	aep3, a15, 4
    11d7:	5ce414        	ae_lp24x2f.iu	aep6, a4, 8
    11da:	e2382edf1f 	{ ae_lp24f.iu	aep5, a15, 4; ae_mulaafp24s.hh.ll	aeq0, aep6, aep1 }
    11df:	04a0d2        	movi	a13, 4
    11e2:	dc7deeef1f 	{ ae_lp24f.iu	aep6, a15, 4; ae_selp24.lh	aep1, aep7, aep3 }
    11e7:	ddd5afc41f 	{ ae_lp24x2f.iu	aep4, a4, 8; ae_selp24.lh	aep2, aep5, aep6 }
    11ec:	ffcde2        	addi	a14, a13, -1
    11ef:	e2302eff1f 	{ ae_lp24f.iu	aep7, a15, 4; ae_mulaafp24s.hh.ll	aeq0, aep4, aep1 }
    11f4:	202330        	or	a2, a3, a3
    11f7:	5c9414        	ae_lp24x2f.iu	aep1, a4, 8
    11fa:	203ff0        	or	a3, a15, a15
    11fd:	518e76        	loop	a14, 1252 <SBC_synthesis4_per_channel+0x212>
    1200:	e2442e931f 	{ ae_lp24f.iu	aep1, a3, 4; ae_mulaafp24s.hh.ll	aeq0, aep1, aep2 }
    1205:	50a314        	ae_lp24f.iu	aep2, a3, 4
    1208:	fc446fe41f 	{ ae_lp24x2f.iu	aep6, a4, 8; ae_roundsq32sym	aeq0, aeq0 }
    120d:	f8a02fc41f 	{ ae_lp24x2f.iu	aep4, a4, 8; ae_mulq32sp16s.l	aeq0, aeq0, aep0 }
    1212:	de45efa41f 	{ ae_lp24x2f.iu	aep2, a4, 8; ae_selp24.lh	aep5, aep1, aep2 }
    1217:	fc24bac06f 	{ ae_sllisq56s	aeq1, aeq0, 2; ae_zeroq56	aeq0 }
    121c:	f8ebeeb31f 	{ ae_lp24f.iu	aep3, a3, 4; ae_roundsp16q48sym	aep1, aeq1 }
    1221:	e2b832921f 	{ ae_sp16f.l.iu	aep1, a2, 2; ae_mulaafp24s.hh.ll	aeq0, aep6, aep5 }
    1226:	509314        	ae_lp24f.iu	aep1, a3, 4
    1229:	dd2dee931f 	{ ae_lp24f.iu	aep1, a3, 4; ae_selp24.lh	aep3, aep3, aep1 }
    122e:	e2702eb31f 	{ ae_lp24f.iu	aep3, a3, 4; ae_mulaafp24s.hh.ll	aeq0, aep4, aep3 }
    1233:	dc65efb41f 	{ ae_lp24x2f.iu	aep3, a4, 8; ae_selp24.lh	aep1, aep1, aep3 }
    1238:	e2282f941f 	{ ae_lp24x2f.iu	aep1, a4, 8; ae_mulaafp24s.hh.ll	aeq0, aep2, aep1 }
    123d:	50a314        	ae_lp24f.iu	aep2, a3, 4
    1240:	50c314        	ae_lp24f.iu	aep4, a3, 4
    1243:	de89aea31f 	{ ae_lp24f.iu	aep2, a3, 4; ae_selp24.lh	aep4, aep2, aep4 }
    1248:	e28c2eb31f 	{ ae_lp24f.iu	aep3, a3, 4; ae_mulaafp24s.hh.ll	aeq0, aep3, aep4 }
    124d:	dd69aeb31f 	{ ae_lp24f.iu	aep3, a3, 4; ae_selp24.lh	aep2, aep2, aep3 }

00001252 <SBC_synthesis4_per_channel+0x212>:
    1252:	e24400166e 	{ addi	a6, a6, 1; ae_mulaafp24s.hh.ll	aeq0, aep1, aep2 }
    1257:	023d           	mov.n	a3, a2
    1259:	060834        	ae_roundsq32sym	aeq0, aeq0
    125c:	030314        	ae_mulq32sp16s.l	aeq0, aeq0, aep0
    125f:	0a5084        	ae_zeroq56	aeq1
    1262:	ff24bac02f 	{ ae_sllisq56s	aeq0, aeq0, 2; ae_zeroq56	aeq3 }
    1267:	1b8e74        	ae_roundsp16q48sym	aep7, aeq0
    126a:	fc24b2f31f 	{ ae_sp16f.l.iu	aep7, a3, 2; ae_zeroq56	aeq0 }
    126f:	1a15f2        	l16ui	a15, a5, 52
    1272:	031542        	l16ui	a4, a5, 6
    1275:	a0cfc0        	addx4	a12, a15, a12
    1278:	02b647        	bgeu	a6, a4, 127e <SBC_synthesis4_per_channel+0x23e>
    127b:	ff7f46        	j	107c <SBC_synthesis4_per_channel+0x3c>

0000127e <SBC_synthesis4_per_channel+0x23e>:
    127e:	f01d           	retw.n

00001280 <SBC_synthesis8_per_channel>:
    1280:	008136        	entry	a1, 64
    1283:	fb7161        	l32r	a6, 48 (1b50 <SBC_cos_coef_8>)
    1286:	d52c           	movi.n	a5, 45
    1288:	031482        	l16ui	a8, a4, 6
    128b:	115570        	slli	a5, a5, 9
    128e:	0bd4c2        	addmi	a12, a4, 0xb00
    1291:	0bd4d2        	addmi	a13, a4, 0xb00
    1294:	01d6e2        	addmi	a14, a6, 0x100
    1297:	78c4a2        	addi	a10, a4, 120
    129a:	58c4f2        	addi	a15, a4, 88
    129d:	870c           	movi.n	a7, 8
    129f:	8b2c           	movi.n	a11, 40
    12a1:	fec392        	addi	a9, a3, -2
    12a4:	304554        	ae_cvtp24a16x2.ll	aep4, a5, a5
    12a7:	93fa20        	movnez	a15, a10, a2
    12aa:	51c9           	s32i.n	a12, a1, 20
    12ac:	6149           	s32i.n	a4, a1, 24
    12ae:	41d9           	s32i.n	a13, a1, 16
    12b0:	31e9           	s32i.n	a14, a1, 12

000012b2 <SBC_synthesis8_per_channel+0x32>:
    12b2:	4168           	l32i.n	a6, a1, 16
    12b4:	5128           	l32i.n	a2, a1, 20
    12b6:	7199           	s32i.n	a9, a1, 28
    12b8:	5216a2        	l16ui	a10, a6, 164
    12bb:	2822e2        	l32i	a14, a2, 160
    12be:	20cf32        	addi	a3, a15, 32
    12c1:	2a1b           	addi.n	a2, a10, 1
    12c3:	f6c292        	addi	a9, a2, -10
    12c6:	939290        	movnez	a9, a2, a9
    12c9:	525692        	s16i	a9, a6, 164
    12cc:	fb5f21        	l32r	a2, 48 (1b50 <SBC_cos_coef_8>)
    12cf:	3168           	l32i.n	a6, a1, 12
    12d1:	f3f730        	wur.ae_cend0	a3
    12d4:	f3f6f0        	wur.ae_cbegin0	a15
    12d7:	04a090        	extui	a10, a9, 0, 1
    12da:	041c           	movi.n	a4, 16
    12dc:	40a152        	movi	a5, 0x140
    12df:	9326a0        	movnez	a2, a6, a10
    12e2:	d40b           	addi.n	a13, a4, -1
    12e4:	f8c242        	addi	a4, a2, -8
    12e7:	ce5a           	add.n	a12, a14, a5
    12e9:	0f5d           	mov.n	a5, a15
    12eb:	fc24dd857f 	{ ae_lp24x2f.c	aep0, a5, a7; nop }
    12f0:	5ca414        	ae_lp24x2f.iu	aep2, a4, 8
    12f3:	f0429d957f 	{ ae_lp24x2f.c	aep1, a5, a7; ae_mulzaafp24s.hh.ll	aeq0, aep0, aep2 }
    12f8:	5cd414        	ae_lp24x2f.iu	aep5, a4, 8
    12fb:	e2a41de57f 	{ ae_lp24x2f.c	aep6, a5, a7; ae_mulaafp24s.hh.ll	aeq0, aep1, aep5 }
    1300:	5cf414        	ae_lp24x2f.iu	aep7, a4, 8
    1303:	a039e0        	addx4	a3, a9, a14
    1306:	d8c362        	addi	a6, a3, -40
    1309:	e2f81d857f 	{ ae_lp24x2f.c	aep0, a5, a7; ae_mulaafp24s.hh.ll	aeq0, aep6, aep7 }
    130e:	5c9414        	ae_lp24x2f.iu	aep1, a4, 8
    1311:	072d           	mov.n	a2, a7
    1313:	0b3d           	mov.n	a3, a11
    1315:	288d76        	loop	a13, 1341 <SBC_synthesis8_per_channel+0xc1>
    1318:	e2202fa41f 	{ ae_lp24x2f.iu	aep2, a4, 8; ae_mulaafp24s.hh.ll	aeq0, aep0, aep1 }
    131d:	5c9414        	ae_lp24x2f.iu	aep1, a4, 8
    1320:	f9e7ef841f 	{ ae_lp24x2f.iu	aep0, a4, 8; ae_roundsp24q48sym	aep3, aeq0 }
    1325:	53b634        	ae_sp24f.l.xu	aep3, a6, a3
    1328:	fc24ddb52f 	{ ae_lp24x2f.c	aep3, a5, a2; nop }
    132d:	f04e9da52f 	{ ae_lp24x2f.c	aep2, a5, a2; ae_mulzaafp24s.hh.ll	aeq0, aep3, aep2 }
    1332:	e2282f941f 	{ ae_lp24x2f.iu	aep1, a4, 8; ae_mulaafp24s.hh.ll	aeq0, aep2, aep1 }
    1337:	fc24dda52f 	{ ae_lp24x2f.c	aep2, a5, a2; nop }
    133c:	e2081d852f 	{ ae_lp24x2f.c	aep0, a5, a2; ae_mulaafp24s.hh.ll	aeq0, aep2, aep0 }

00001341 <SBC_synthesis8_per_channel+0xc1>:
    1341:	e2200160df 	{ movi	a13, 0x160; ae_mulaafp24s.hh.ll	aeq0, aep0, aep1 }
    1346:	419190        	srli	a9, a9, 1
    1349:	f8e793722f 	{ or	a7, a2, a2; ae_roundsp24q48sym	aep0, aeq0 }
    134e:	538634        	ae_sp24f.l.xu	aep0, a6, a3
    1351:	fb3e61        	l32r	a6, 4c (21c0 <SBC_proto_coef_8>)
    1354:	c129d0        	mul16u	a2, a9, a13
    1357:	93eca0        	movnez	a14, a12, a10
    135a:	1c0c           	movi.n	a12, 1
    135c:	03bd           	mov.n	a11, a3
    135e:	303ac0        	xor	a3, a10, a12
    1361:	262a           	add.n	a2, a6, a2
    1363:	a02320        	addx4	a2, a3, a2
    1366:	fcc232        	addi	a3, a2, -4
    1369:	508314        	ae_lp24f.iu	aep0, a3, 4
    136c:	50b314        	ae_lp24f.iu	aep3, a3, 4
    136f:	dc61aed31f 	{ ae_lp24f.iu	aep5, a3, 4; ae_selp24.lh	aep0, aep0, aep3 }
    1374:	840c           	movi.n	a4, 8
    1376:	50e314        	ae_lp24f.iu	aep6, a3, 4
    1379:	540b           	addi.n	a5, a4, -1
    137b:	f8ce42        	addi	a4, a14, -8
    137e:	5ca414        	ae_lp24x2f.iu	aep2, a4, 8
    1381:	f00aaeb31f 	{ ae_lp24f.iu	aep3, a3, 4; ae_mulzaafp24s.hh.ll	aeq0, aep2, aep0 }
    1386:	dcd5aff41f 	{ ae_lp24x2f.iu	aep7, a4, 8; ae_selp24.lh	aep0, aep5, aep6 }
    138b:	e21c2ed31f 	{ ae_lp24f.iu	aep5, a3, 4; ae_mulaafp24s.hh.ll	aeq0, aep7, aep0 }
    1390:	dcadaef31f 	{ ae_lp24f.iu	aep7, a3, 4; ae_selp24.lh	aep0, aep3, aep5 }
    1395:	5ce414        	ae_lp24x2f.iu	aep6, a4, 8
    1398:	e2182eb31f 	{ ae_lp24f.iu	aep3, a3, 4; ae_mulaafp24s.hh.ll	aeq0, aep6, aep0 }
    139d:	dc7dafd41f 	{ ae_lp24x2f.iu	aep5, a4, 8; ae_selp24.lh	aep0, aep7, aep3 }
    13a2:	e2142eb31f 	{ ae_lp24f.iu	aep3, a3, 4; ae_mulaafp24s.hh.ll	aeq0, aep5, aep0 }
    13a7:	7128           	l32i.n	a2, a1, 28
    13a9:	f872aee31f 	{ ae_lp24f.iu	aep6, a3, 4; ae_movp48	aep0, aep4 }
    13ae:	ddcdaf941f 	{ ae_lp24x2f.iu	aep1, a4, 8; ae_selp24.lh	aep2, aep3, aep6 }
    13b3:	50f314        	ae_lp24f.iu	aep7, a3, 4
    13b6:	4f8576        	loop	a5, 1409 <SBC_synthesis8_per_channel+0x189>
    13b9:	e2442e931f 	{ ae_lp24f.iu	aep1, a3, 4; ae_mulaafp24s.hh.ll	aeq0, aep1, aep2 }
    13be:	50b314        	ae_lp24f.iu	aep3, a3, 4
    13c1:	fc446fa41f 	{ ae_lp24x2f.iu	aep2, a4, 8; ae_roundsq32sym	aeq0, aeq0 }
    13c6:	f8a02fc41f 	{ ae_lp24x2f.iu	aep4, a4, 8; ae_mulq32sp16s.l	aeq0, aeq0, aep0 }
    13cb:	dd65ef941f 	{ ae_lp24x2f.iu	aep1, a4, 8; ae_selp24.lh	aep3, aep1, aep3 }
    13d0:	f06abac06f 	{ ae_sllisq56s	aeq1, aeq0, 2; ae_mulzaafp24s.hh.ll	aeq0, aep2, aep3 }
    13d5:	f9ebaeb31f 	{ ae_lp24f.iu	aep3, a3, 4; ae_roundsp16q48sym	aep2, aeq1 }
    13da:	42a214        	ae_sp16f.l.iu	aep2, a2, 2
    13dd:	50a314        	ae_lp24f.iu	aep2, a3, 4
    13e0:	dd4deea31f 	{ ae_lp24f.iu	aep2, a3, 4; ae_selp24.lh	aep3, aep3, aep2 }
    13e5:	e2702eb31f 	{ ae_lp24f.iu	aep3, a3, 4; ae_mulaafp24s.hh.ll	aeq0, aep4, aep3 }
    13ea:	dd69efa41f 	{ ae_lp24x2f.iu	aep2, a4, 8; ae_selp24.lh	aep3, aep2, aep3 }
    13ef:	e2642f941f 	{ ae_lp24x2f.iu	aep1, a4, 8; ae_mulaafp24s.hh.ll	aeq0, aep1, aep3 }
    13f4:	50b314        	ae_lp24f.iu	aep3, a3, 4
    13f7:	50c314        	ae_lp24f.iu	aep4, a3, 4
    13fa:	de8daeb31f 	{ ae_lp24f.iu	aep3, a3, 4; ae_selp24.lh	aep4, aep3, aep4 }
    13ff:	e2882ea31f 	{ ae_lp24f.iu	aep2, a3, 4; ae_mulaafp24s.hh.ll	aeq0, aep2, aep4 }
    1404:	dd4daeb31f 	{ ae_lp24f.iu	aep3, a3, 4; ae_selp24.lh	aep2, aep3, aep2 }
    1409:	e2443061ee 	{ l32i	a14, a1, 24; ae_mulaafp24s.hh.ll	aeq0, aep1, aep2 }
    140e:	029d           	mov.n	a9, a2
    1410:	fc444ff88e 	{ addi	a8, a8, -1; ae_roundsq32sym	aeq0, aeq0 }
    1415:	f8a03f083f 	{ ae_movp48	aep4, aep0; ae_mulq32sp16s.l	aeq0, aeq0, aep0 }
    141a:	360094        	ae_sllisq56s	aeq0, aeq0, 2
    141d:	1b8e74        	ae_roundsp16q48sym	aep7, aeq0
    1420:	42f914        	ae_sp16f.l.iu	aep7, a9, 2
    1423:	1a1e22        	l16ui	a2, a14, 52
    1426:	a0f2f0        	addx4	a15, a2, a15
    1429:	0218a6        	blti	a8, 1, 142f <SBC_synthesis8_per_channel+0x1af>
    142c:	ffa086        	j	12b2 <SBC_synthesis8_per_channel+0x32>
    142f:	f01d           	retw.n

00001431 <SBC_synthesis8_per_channel+0x1b1>:
    1431:	000000                                        ...

00001434 <_start>:
    1434:	004136        	entry	a1, 32
    1437:	fb0631        	l32r	a3, 50 (2a7c <printf_ptr>)
    143a:	002222        	l32i	a2, a2, 0
    143d:	fb05a1        	l32r	a10, 54 (2a08 <export_parameter_array+0x8>)
    1440:	fb06b1        	l32r	a11, 58 (1634 <msbc_dec_init>)
    1443:	006322        	s32i	a2, a3, 0
    1446:	0002e0        	callx8	a2
    1449:	0328           	l32i.n	a2, a3, 0
    144b:	fb04a1        	l32r	a10, 5c (2a1c <export_parameter_array+0x1c>)
    144e:	fb04b1        	l32r	a11, 60 (1460 <msbc_dec_process>)
    1451:	0002e0        	callx8	a2
    1454:	fb0421        	l32r	a2, 64 (2a00 <export_parameter_array>)
    1457:	f01d           	retw.n

00001459 <_start+0x25>:
    1459:	00000000                                 .......

00001460 <msbc_dec_process>:
    1460:	004136        	entry	a1, 32
    1463:	026d           	mov.n	a6, a2
    1465:	0cd2f2        	addmi	a15, a2, 0xc00
    1468:	fb0021        	l32r	a2, 68 (3bc <SBC_decode_preload>)
    146b:	20a660        	or	a10, a6, a6
    146e:	036f32        	s32i	a3, a15, 12
    1471:	0002e0        	callx8	a2
    1474:	38c372        	addi	a7, a3, 56
    1477:	04d622        	addmi	a2, a6, 0x400
    147a:	837350        	moveqz	a7, a3, a5
    147d:	276272        	s32i	a7, a2, 156
    1480:	759c           	beqz.n	a5, 149b <msbc_dec_process+0x3b>
    1482:	883c           	movi.n	a8, 56
    1484:	935850        	movnez	a5, a8, a5
    1487:	335a           	add.n	a3, a3, a5
    1489:	235d           	ae_l16si.n	a5, a3, 0
    148b:	772b           	addi.n	a7, a7, 2
    148d:	830c           	movi.n	a3, 8
    148f:	11f580        	slli	a15, a5, 8
    1492:	276272        	s32i	a7, a2, 156
    1495:	66fd           	ae_s16i.n	a15, a6, 0
    1497:	000086        	j	149d <msbc_dec_process+0x3d>

0000149a <msbc_dec_process+0x3a>:
	...

0000149b <msbc_dec_process+0x3b>:
    149b:	030c           	movi.n	a3, 0
    149d:	273c           	movi.n	a7, 50
    149f:	763d           	ae_s16i.n	a3, a6, 2
    14a1:	70c652        	addi	a5, a6, 112
    14a4:	820c           	movi.n	a2, 8
    14a6:	ada032        	movi	a3, 173
    14a9:	108776        	loop	a7, 14bd <msbc_dec_process+0x5d>
    14ac:	037724        	ae_lb	a7, a2
    14af:	ff2582        	l32i	a8, a5, 0x3fc
    14b2:	977d           	ae_zext16	a7, a7
    14b4:	1c1824        	ae_db	a8, a2
    14b7:	ff6582        	s32i	a8, a5, 0x3fc
    14ba:	081737        	beq	a7, a3, 14c6 <msbc_dec_process+0x66>

000014bd <msbc_dec_process+0x5d>:
    14bd:	ada022        	movi	a2, 173
    14c0:	021727        	beq	a7, a2, 14c6 <msbc_dec_process+0x66>
    14c3:	002446        	j	1558 <msbc_dec_process+0xf8>

000014c6 <msbc_dec_process+0x66>:
    14c6:	ff2532        	l32i	a3, a5, 0x3fc
    14c9:	820c           	movi.n	a2, 8
    14cb:	039724        	ae_lb	a9, a2
    14ce:	1c1324        	ae_db	a3, a2
    14d1:	ff6532        	s32i	a3, a5, 0x3fc
    14d4:	ff2532        	l32i	a3, a5, 0x3fc
    14d7:	095692        	s16i	a9, a6, 18
    14da:	03f724        	ae_lb	a15, a2
    14dd:	1c1324        	ae_db	a3, a2
    14e0:	ff6532        	s32i	a3, a5, 0x3fc
    14e3:	ff25a2        	l32i	a10, a5, 0x3fc
    14e6:	0a56f2        	s16i	a15, a6, 20
    14e9:	03b724        	ae_lb	a11, a2
    14ec:	1c1a24        	ae_db	a10, a2
    14ef:	fc0c           	movi.n	a12, 15
    14f1:	ff65a2        	s32i	a10, a5, 0x3fc
    14f4:	112c00        	slli	a2, a12, 16
    14f7:	fadf51        	l32r	a5, 74 (254 <sbc_extract_scale_factors_joint_ch8_non>)
    14fa:	1656b2        	s16i	a11, a6, 44
    14fd:	fadbd1        	l32r	a13, 6c (10008 <_end+0xd588>)
    1500:	1629           	s32i.n	a2, a6, 4
    1502:	020c           	movi.n	a2, 0
    1504:	ae1c           	movi.n	a14, 26
    1506:	fadaf1        	l32r	a15, 70 (780008 <_end+0x77d588>)
    1509:	04d672        	addmi	a7, a6, 0x400
    150c:	983c           	movi.n	a8, 57
    150e:	2b0c           	movi.n	a11, 2
    1510:	06ad           	mov.n	a10, a6
    1512:	4c5782        	s16i	a8, a7, 152
    1515:	12c632        	addi	a3, a6, 18
    1518:	36d9           	s32i.n	a13, a6, 12
    151a:	0856e2        	s16i	a14, a6, 16
    151d:	2629           	s32i.n	a2, a6, 8
    151f:	0d66f2        	s32i	a15, a6, 52
    1522:	0005e0        	callx8	a5
    1525:	1516b2        	l16ui	a11, a6, 42
    1528:	fad451        	l32r	a5, 78 (150 <sbc_crc8>)
    152b:	03ad           	mov.n	a10, a3
    152d:	f03d           	nop.n
    152f:	0005e0        	callx8	a5
    1532:	161632        	l16ui	a3, a6, 44
    1535:	129a37        	bne	a10, a3, 154b <msbc_dec_process+0xeb>
    1538:	fabb31        	l32r	a3, 24 (8a8 <sbc_bit_allocation>)
    153b:	06ad           	mov.n	a10, a6
    153d:	0003e0        	callx8	a3
    1540:	faba31        	l32r	a3, 28 (c60 <sbc_reconstruction>)
    1543:	06ad           	mov.n	a10, a6
    1545:	0003e0        	callx8	a3
    1548:	000e06        	j	1584 <msbc_dec_process+0x124>

0000154b <msbc_dec_process+0xeb>:
    154b:	facc21        	l32r	a2, 7c (86c <sbc_zero_sb_samples>)
    154e:	06ad           	mov.n	a10, a6
    1550:	0002e0        	callx8	a2
    1553:	120c           	movi.n	a2, 1
    1555:	000ac6        	j	1584 <msbc_dec_process+0x124>

00001558 <msbc_dec_process+0xf8>:
    1558:	fac921        	l32r	a2, 7c (86c <sbc_zero_sb_samples>)
    155b:	06ad           	mov.n	a10, a6
    155d:	0002e0        	callx8	a2
    1560:	04d622        	addmi	a2, a6, 0x400
    1563:	933c           	movi.n	a3, 57
    1565:	fc0c           	movi.n	a12, 15
    1567:	4c5232        	s16i	a3, a2, 152
    156a:	112c00        	slli	a2, a12, 16
    156d:	0d0c           	movi.n	a13, 0
    156f:	ae1c           	movi.n	a14, 26
    1571:	fabef1        	l32r	a15, 6c (10008 <_end+0xd588>)
    1574:	fabf51        	l32r	a5, 70 (780008 <_end+0x77d588>)
    1577:	1629           	s32i.n	a2, a6, 4
    1579:	120c           	movi.n	a2, 1
    157b:	26d9           	s32i.n	a13, a6, 8
    157d:	0856e2        	s16i	a14, a6, 16
    1580:	36f9           	s32i.n	a15, a6, 12
    1582:	d659           	s32i.n	a5, a6, 52
    1584:	a0a432        	movi	a3, 0x4a0
    1587:	0bd652        	addmi	a5, a6, 0xb00
    158a:	363a           	add.n	a3, a6, a3
    158c:	286532        	s32i	a3, a5, 160
    158f:	0bd672        	addmi	a7, a6, 0xb00
    1592:	faa751        	l32r	a5, 30 (1280 <SBC_synthesis8_per_channel>)
    1595:	5397f2        	l16si	a15, a7, 166
    1598:	0a0c           	movi.n	a10, 0
    159a:	04bd           	mov.n	a11, a4
    159c:	06cd           	mov.n	a12, a6
    159e:	5257f2        	s16i	a15, a7, 164
    15a1:	0005e0        	callx8	a5
    15a4:	529732        	l16si	a3, a7, 164
    15a7:	535732        	s16i	a3, a7, 166
    15aa:	f01d           	retw.n

000015ac <msbc_get_byte>:
    15ac:	004136        	entry	a1, 32
    15af:	70c252        	addi	a5, a2, 112
    15b2:	830c           	movi.n	a3, 8
    15b4:	ff2562        	l32i	a6, a5, 0x3fc
    15b7:	034734        	ae_lb	a4, a3
    15ba:	1c1634        	ae_db	a6, a3
    15bd:	942d           	ae_zext16	a2, a4
    15bf:	ff6562        	s32i	a6, a5, 0x3fc
    15c2:	f01d           	retw.n

000015c4 <msbc_change_endian16>:
    15c4:	004136        	entry	a1, 32
    15c7:	ffa032        	movi	a3, 255
    15ca:	113300        	slli	a3, a3, 16
    15cd:	114280        	slli	a4, a2, 8
    15d0:	103430        	and	a3, a4, a3
    15d3:	8b7230        	depbits	a3, a2, 24, 8
    15d6:	312030        	srai	a2, a3, 16
    15d9:	f01d           	retw.n

000015db <msbc_change_endian16+0x17>:
	...

000015dc <mSBC_memory_clear>:
    15dc:	004136        	entry	a1, 32
    15df:	00a152        	movi	a5, 0x100
    15e2:	024d           	mov.n	a4, a2
    15e4:	415350        	srli	a5, a5, 3
    15e7:	00a022        	movi	a2, 0
    15ea:	58c432        	addi	a3, a4, 88
    15ed:	129576        	loopnez	a5, 1603 <mSBC_memory_clear+0x27>
    15f0:	0329           	s32i.n	a2, a3, 0
    15f2:	7329           	s32i.n	a2, a3, 28
    15f4:	6329           	s32i.n	a2, a3, 24
    15f6:	5329           	s32i.n	a2, a3, 20
    15f8:	1329           	s32i.n	a2, a3, 4
    15fa:	4329           	s32i.n	a2, a3, 16
    15fc:	3329           	s32i.n	a2, a3, 12
    15fe:	2329           	s32i.n	a2, a3, 8
    1600:	20c332        	addi	a3, a3, 32

00001603 <mSBC_memory_clear+0x27>:
    1603:	a0a052        	movi	a5, 160
    1606:	a0a432        	movi	a3, 0x4a0
    1609:	415350        	srli	a5, a5, 3
    160c:	020c           	movi.n	a2, 0
    160e:	803430        	add	a3, a4, a3
    1611:	129576        	loopnez	a5, 1627 <mSBC_memory_clear+0x4b>
    1614:	0329           	s32i.n	a2, a3, 0
    1616:	7329           	s32i.n	a2, a3, 28
    1618:	6329           	s32i.n	a2, a3, 24
    161a:	5329           	s32i.n	a2, a3, 20
    161c:	1329           	s32i.n	a2, a3, 4
    161e:	4329           	s32i.n	a2, a3, 16
    1620:	3329           	s32i.n	a2, a3, 12
    1622:	2329           	s32i.n	a2, a3, 8
    1624:	20c332        	addi	a3, a3, 32
    1627:	0bd422        	addmi	a2, a4, 0xb00
    162a:	030c           	movi.n	a3, 0
    162c:	535232        	s16i	a3, a2, 166
    162f:	f01d           	retw.n

00001631 <mSBC_memory_clear+0x55>:
    1631:	000000                                        ...

00001634 <msbc_dec_init>:
    1634:	004136        	entry	a1, 32
    1637:	00a152        	movi	a5, 0x100
    163a:	024d           	mov.n	a4, a2
    163c:	415350        	srli	a5, a5, 3
    163f:	00a022        	movi	a2, 0
    1642:	58c432        	addi	a3, a4, 88
    1645:	129576        	loopnez	a5, 165b <msbc_dec_init+0x27>
    1648:	0329           	s32i.n	a2, a3, 0
    164a:	7329           	s32i.n	a2, a3, 28
    164c:	6329           	s32i.n	a2, a3, 24
    164e:	5329           	s32i.n	a2, a3, 20
    1650:	1329           	s32i.n	a2, a3, 4
    1652:	4329           	s32i.n	a2, a3, 16
    1654:	3329           	s32i.n	a2, a3, 12
    1656:	2329           	s32i.n	a2, a3, 8
    1658:	20c332        	addi	a3, a3, 32

0000165b <msbc_dec_init+0x27>:
    165b:	a0a052        	movi	a5, 160
    165e:	a0a432        	movi	a3, 0x4a0
    1661:	415350        	srli	a5, a5, 3
    1664:	020c           	movi.n	a2, 0
    1666:	803430        	add	a3, a4, a3
    1669:	129576        	loopnez	a5, 167f <msbc_dec_init+0x4b>
    166c:	0329           	s32i.n	a2, a3, 0
    166e:	7329           	s32i.n	a2, a3, 28
    1670:	6329           	s32i.n	a2, a3, 24
    1672:	5329           	s32i.n	a2, a3, 20
    1674:	1329           	s32i.n	a2, a3, 4
    1676:	4329           	s32i.n	a2, a3, 16
    1678:	3329           	s32i.n	a2, a3, 12
    167a:	2329           	s32i.n	a2, a3, 8
    167c:	20c332        	addi	a3, a3, 32
    167f:	0bd422        	addmi	a2, a4, 0xb00
    1682:	030c           	movi.n	a3, 0
    1684:	535232        	s16i	a3, a2, 166
    1687:	f01d           	retw.n

00001689 <msbc_dec_init+0x55>:
    1689:	000000                                        ...

0000168c <__do_global_ctors_aux>:
    168c:	004136        	entry	a1, 32
    168f:	fa7c31        	l32r	a3, 80 (1998 <__CTOR_END__>)
    1692:	fcc322        	addi	a2, a3, -4
    1695:	0228           	l32i.n	a2, a2, 0
    1697:	f8c332        	addi	a3, a3, -8
    169a:	0a0226        	beqi	a2, -1, 16a8 <__do_global_ctors_aux+0x1c>

0000169d <__do_global_ctors_aux+0x11>:
    169d:	0002e0        	callx8	a2
    16a0:	0328           	l32i.n	a2, a3, 0
    16a2:	fcc332        	addi	a3, a3, -4
    16a5:	f40266        	bnei	a2, -1, 169d <__do_global_ctors_aux+0x11>
    16a8:	f01d           	retw.n

000016aa <__do_global_ctors_aux+0x1e>:
	...

000016ac <_fini>:
    16ac:	008136        	entry	a1, 64
    16af:	fa7581        	l32r	a8, 84 (a0 <__do_global_dtors_aux>)
    16b2:	f03d           	nop.n
    16b4:	0008e0        	callx8	a8

000016b7 <_fini+0xb>:
    16b7:	f01d           	retw.n
