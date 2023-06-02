
Build/lib/pisplit_sbc_dec_position_independent.splitload.lib:     file format elf32-xtensa-le


Disassembly of section .text:

00000000 <_init-0xc4>:
   0:	0000011c 00000e40 00002320 00002304     ....@... #...#..
  10:	00000000 000022ec 00000000 00002324     ....."......$#..
  20:	01424fb9 00000140 0000080c 00002180     .OB.@........!..
  30:	00000370 000001e0 0000022c 0000017c     p.......,...|...
  40:	000005c8 000005f0 000008c0 00000bb8     ................
  50:	00000ce0 00001280 00001260 00000baa     ........`.......
  60:	00000bea 00001320 00000898 000008ac     .... ...........
  70:	00005a00 00001600 000013b0 00001370     .Z..........p...
  80:	00001730 00001530 00001430 00001aa0     0...0...0.......
  90:	0000233c 00002280 00000158 00002290     <#..."..X...."..
  a0:	00000284 000022b0 000003b4 000022c8     ....."......."..
  b0:	00000138 00002310 000020f4 000022f0     8....#... ..."..
  c0:	000000e0                                ....

000000c4 <_init>:
  c4:	008136        	entry	a1, 64
  c7:	ffce81        	l32r	a8, 0 (11c <frame_dummy>)
  ca:	f03d           	nop.n
  cc:	0008e0        	callx8	a8
  cf:	ffcd81        	l32r	a8, 4 (e40 <__do_global_ctors_aux>)
  d2:	f03d           	nop.n
  d4:	0008e0        	callx8	a8
  d7:	f01d           	retw.n

000000d9 <_init+0x15>:
  d9:	00000000 36000000                                .......

000000e0 <__do_global_dtors_aux>:
  e0:	004136        	entry	a1, 32
  e3:	ffc931        	l32r	a3, 8 (2320 <__bss_start>)
  e6:	000382        	l8ui	a8, a3, 0
  e9:	d8ec           	bnez.n	a8, 11a <__do_global_dtors_aux+0x3a>
  eb:	ffc821        	l32r	a2, c (2304 <p$3519_6_1>)
  ee:	02b8           	l32i.n	a11, a2, 0
  f0:	0ba8           	l32i.n	a10, a11, 0
  f2:	ca8c           	beqz.n	a10, 102 <__do_global_dtors_aux+0x22>

000000f4 <__do_global_dtors_aux+0x14>:
  f4:	9b4b           	addi.n	a9, a11, 4
  f6:	0299           	s32i.n	a9, a2, 0
  f8:	000ae0        	callx8	a10
  fb:	02b8           	l32i.n	a11, a2, 0
  fd:	0ba8           	l32i.n	a10, a11, 0
  ff:	ff1a56        	bnez	a10, f4 <__do_global_dtors_aux+0x14>

00000102 <__do_global_dtors_aux+0x22>:
 102:	ffc3a1        	l32r	a10, 10 (0 <_text_start>)
 105:	0b0c           	movi.n	a11, 0
 107:	081ab7        	beq	a10, a11, 113 <__do_global_dtors_aux+0x33>
 10a:	ffc2a1        	l32r	a10, 14 (22ec <__EH_FRAME_BEGIN___44>)
 10d:	ffc081        	l32r	a8, 10 (0 <_text_start>)
 110:	0008e0        	callx8	a8

00000113 <__do_global_dtors_aux+0x33>:
 113:	1c0c           	movi.n	a12, 1
 115:	0043c2        	s8i	a12, a3, 0
 118:	f01d           	retw.n

0000011a <__do_global_dtors_aux+0x3a>:
 11a:	f01d           	retw.n

0000011c <frame_dummy>:
 11c:	004136        	entry	a1, 32
 11f:	ffbe81        	l32r	a8, 18 (0 <_text_start>)
 122:	090c           	movi.n	a9, 0
 124:	0b1897        	beq	a8, a9, 133 <frame_dummy+0x17>
 127:	ffbba1        	l32r	a10, 14 (22ec <__EH_FRAME_BEGIN___44>)
 12a:	ffbcb1        	l32r	a11, 1c (2324 <object$3538_8_1>)
 12d:	ffba81        	l32r	a8, 18 (0 <_text_start>)
 130:	0008e0        	callx8	a8

00000133 <frame_dummy+0x17>:
 133:	f01d           	retw.n

00000135 <frame_dummy+0x19>:
 135:	000000                                        ...

00000138 <get_SBC_version>:
 138:	004136        	entry	a1, 32
 13b:	ffb921        	l32r	a2, 20 (1424fb9 <_end+0x1422c79>)
 13e:	f01d           	retw.n

00000140 <xt_memset>:
 140:	004136        	entry	a1, 32
 143:	026d           	mov.n	a6, a2
 145:	42cc           	bnez.n	a2, 14d <xt_memset+0xd>
 147:	020c           	movi.n	a2, 0
 149:	f01d           	retw.n

0000014b <xt_memset+0xb>:
	...

0000014d <xt_memset+0xd>:
 14d:	029476        	loopnez	a4, 153 <xt_memset+0x13>
 150:	09c634        	ae_s16ip	a3, a6, 2

00000153 <xt_memset+0x13>:
 153:	f01d           	retw.n

00000155 <xt_memset+0x15>:
 155:	000000                                        ...

00000158 <sbc_init>:
 158:	004136        	entry	a1, 32
 15b:	02ad           	mov.n	a10, a2
 15d:	ffb181        	l32r	a8, 24 (140 <xt_memset>)
 160:	0b0c           	movi.n	a11, 0
 162:	ffb1c1        	l32r	a12, 28 (80c <sbc_bit_allocation+0x21c>)
 165:	0008e0        	callx8	a8
 168:	10d2a2        	addmi	a10, a2, 0x1000
 16b:	090c           	movi.n	a9, 0
 16d:	04d2c2        	addmi	a12, a2, 0x400
 170:	00a2b2        	movi	a11, 0x200
 173:	4c5cb2        	s16i	a11, a12, 152
 176:	085a92        	s16i	a9, a10, 16
 179:	f01d           	retw.n

0000017b <sbc_init+0x23>:
	...

0000017c <sbc_crc8>:
 17c:	004136        	entry	a1, 32
 17f:	027d           	mov.n	a7, a2
 181:	249030        	extui	a9, a3, 0, 3
 184:	218330        	srai	a8, a3, 3
 187:	2a18a6        	blti	a8, 1, 1b5 <sbc_crc8+0x39>
 18a:	025d           	mov.n	a5, a2
 18c:	ffa861        	l32r	a6, 2c (2180 <SBC_crc_table>)
 18f:	f20c           	movi.n	a2, 15
 191:	1da876        	loopgtz	a8, 1b2 <sbc_crc8+0x36>
 194:	454d           	ae_l16ui.n	a4, a5, 0
 196:	552b           	addi.n	a5, a5, 2
 198:	302420        	xor	a2, a4, a2
 19b:	044020        	extui	a4, a2, 0, 1
 19e:	412120        	srli	a2, a2, 1
 1a1:	902260        	addx2	a2, a2, a6
 1a4:	422d           	ae_l16ui.n	a2, a2, 0
 1a6:	1144d0        	slli	a4, a4, 3
 1a9:	400400        	ssr	a4
 1ac:	b12020        	sra	a2, a2
 1af:	742020        	extui	a2, a2, 0, 8

000001b2 <sbc_crc8+0x36>:
 1b2:	0000c6        	j	1b9 <sbc_crc8+0x3d>

000001b5 <sbc_crc8+0x39>:
 1b5:	080c           	movi.n	a8, 0
 1b7:	f20c           	movi.n	a2, 15

000001b9 <sbc_crc8+0x3d>:
 1b9:	90a870        	addx2	a10, a8, a7
 1bc:	d61c           	movi.n	a6, 29
 1be:	070c           	movi.n	a7, 0
 1c0:	4a3d           	ae_l16ui.n	a3, a10, 0
 1c2:	16a976        	loopgtz	a9, 1dc <sbc_crc8+0x60>
 1c5:	644020        	extui	a4, a2, 0, 7
 1c8:	305320        	xor	a5, a3, a2
 1cb:	1144f0        	slli	a4, a4, 1
 1ce:	1133f0        	slli	a3, a3, 1
 1d1:	045750        	extui	a5, a5, 7, 1
 1d4:	072d           	mov.n	a2, a7
 1d6:	932650        	movnez	a2, a6, a5
 1d9:	302240        	xor	a2, a2, a4

000001dc <sbc_crc8+0x60>:
 1dc:	f01d           	retw.n

000001de <sbc_crc8+0x62>:
	...

000001e0 <sbc_extract_scale_factors_joint_ch4>:
 1e0:	004136        	entry	a1, 32
 1e3:	38c262        	addi	a6, a2, 56
 1e6:	16c252        	addi	a5, a2, 22
 1e9:	890c           	movi.n	a9, 8
 1eb:	02d242        	addmi	a4, a2, 0x200
 1ee:	1a12b2        	l16ui	a11, a2, 52
 1f1:	70c4a2        	addi	a10, a4, 112
 1f4:	9b2442        	l32i	a4, a4, 0x26c
 1f7:	41b1b0        	srli	a11, a11, 1
 1fa:	1eab76        	loopgtz	a11, 21c <sbc_extract_scale_factors_joint_ch4+0x3c>
 1fd:	03c794        	ae_lb	a12, a9
 200:	1c1494        	ae_db	a4, a9
 203:	3470c0        	extui	a7, a12, 0, 4
 206:	767d           	ae_s16i.n	a7, a6, 2
 208:	34c4c0        	extui	a12, a12, 4, 4
 20b:	66cd           	ae_s16i.n	a12, a6, 0
 20d:	458d           	ae_l16ui.n	a8, a5, 0
 20f:	1177c0        	slli	a7, a7, 4
 212:	664b           	addi.n	a6, a6, 4
 214:	2088c0        	or	a8, a8, a12
 217:	09c584        	ae_s16ip	a8, a5, 2
 21a:	657d           	ae_s16i.n	a7, a5, 0

0000021c <sbc_extract_scale_factors_joint_ch4+0x3c>:
 21c:	7f6a42        	s32i	a4, a10, 0x1fc
 21f:	4e0c           	movi.n	a14, 4
 221:	db2b           	addi.n	a13, a11, 2
 223:	b0dde0        	addx8	a13, a13, a14
 226:	1552d2        	s16i	a13, a2, 42
 229:	f01d           	retw.n

0000022b <sbc_extract_scale_factors_joint_ch4+0x4b>:
	...

0000022c <sbc_extract_scale_factors_joint_ch8_non>:
 22c:	004136        	entry	a1, 32
 22f:	38c272        	addi	a7, a2, 56
 232:	890c           	movi.n	a9, 8
 234:	1a12b2        	l16ui	a11, a2, 52
 237:	906320        	addx2	a6, a3, a2
 23a:	02d252        	addmi	a5, a2, 0x200
 23d:	70c5a2        	addi	a10, a5, 112
 240:	12c662        	addi	a6, a6, 18
 243:	9b2552        	l32i	a5, a5, 0x26c
 246:	41b1b0        	srli	a11, a11, 1
 249:	14ab76        	loopgtz	a11, 261 <sbc_extract_scale_factors_joint_ch8_non+0x35>
 24c:	038794        	ae_lb	a8, a9
 24f:	1c1594        	ae_db	a5, a9
 252:	34d080        	extui	a13, a8, 0, 4
 255:	34c480        	extui	a12, a8, 4, 4
 258:	67cd           	ae_s16i.n	a12, a7, 0
 25a:	77dd           	ae_s16i.n	a13, a7, 2
 25c:	09c684        	ae_s16ip	a8, a6, 2
 25f:	774b           	addi.n	a7, a7, 4

00000261 <sbc_extract_scale_factors_joint_ch8_non+0x35>:
 261:	7f6a52        	s32i	a5, a10, 0x1fc
 264:	e3ba           	add.n	a14, a3, a11
 266:	11eed0        	slli	a14, a14, 3
 269:	1552e2        	s16i	a14, a2, 42
 26c:	f01d           	retw.n

0000026e <sbc_extract_scale_factors_joint_ch8_non+0x42>:
	...

00000270 <sbc_get_frame_length>:
 270:	004136        	entry	a1, 32
 273:	04d222        	addmi	a2, a2, 0x400
 276:	4c1222        	l16ui	a2, a2, 152
 279:	f01d           	retw.n

0000027b <sbc_get_frame_length+0xb>:
	...

0000027c <sbc_get_sample_freq>:
 27c:	004136        	entry	a1, 32
 27f:	021222        	l16ui	a2, a2, 4
 282:	f01d           	retw.n

00000284 <sbc_frame_header_decode>:
 284:	004136        	entry	a1, 32
 287:	9ca072        	movi	a7, 156
 28a:	060c           	movi.n	a6, 0
 28c:	0ad342        	addmi	a4, a3, 0xa00
 28f:	626d           	ae_s16i.n	a6, a2, 0
 291:	832422        	l32i	a2, a4, 0x20c
 294:	10c462        	addi	a6, a4, 16

00000297 <sbc_frame_header_decode+0x13>:
 297:	000282        	l8ui	a8, a2, 0
 29a:	221b           	addi.n	a2, a2, 1
 29c:	7f6622        	s32i	a2, a6, 0x1fc
 29f:	f49877        	bne	a8, a7, 297 <sbc_frame_header_decode+0x13>
 2a2:	140c           	movi.n	a4, 1
 2a4:	480c           	movi.n	a8, 4
 2a6:	0002b2        	l8ui	a11, a2, 0
 2a9:	d21b           	addi.n	a13, a2, 1
 2ab:	7f66d2        	s32i	a13, a6, 0x1fc
 2ae:	1494b0        	extui	a9, a11, 4, 2
 2b1:	14a6b0        	extui	a10, a11, 6, 2
 2b4:	0470b0        	extui	a7, a11, 0, 1
 2b7:	0953b2        	s16i	a11, a3, 18
 2ba:	04c1b0        	extui	a12, a11, 1, 1
 2bd:	0553c2        	s16i	a12, a3, 10
 2c0:	7f2622        	l32i	a2, a6, 0x1fc
 2c3:	a07780        	addx4	a7, a7, a8
 2c6:	0253a2        	s16i	a10, a3, 4
 2c9:	a09980        	addx4	a9, a9, a8
 2cc:	9ca3a2        	movi	a10, 0x39c
 2cf:	035392        	s16i	a9, a3, 6
 2d2:	065372        	s16i	a7, a3, 12
 2d5:	280c           	movi.n	a8, 2
 2d7:	c21b           	addi.n	a12, a2, 1
 2d9:	14b2b0        	extui	a11, a11, 2, 2
 2dc:	0453b2        	s16i	a11, a3, 8
 2df:	8384b0        	moveqz	a8, a4, a11
 2e2:	075382        	s16i	a8, a3, 14
 2e5:	071352        	l16ui	a5, a3, 14
 2e8:	000222        	l8ui	a2, a2, 0
 2eb:	7f66c2        	s32i	a12, a6, 0x1fc
 2ee:	085322        	s16i	a2, a3, 16
 2f1:	0a5322        	s16i	a2, a3, 20
 2f4:	04ab16        	beqz	a11, 342 <sbc_frame_header_decode+0xbe>
 2f7:	471b26        	beqi	a11, 1, 342 <sbc_frame_header_decode+0xbe>
 2fa:	c12290        	mul16u	a2, a2, a9
 2fd:	43aa           	add.n	a4, a3, a10
 2ff:	c1e780        	mul16u	a14, a7, a8
 302:	978d           	ae_zext16	a8, a7
 304:	2171e0        	srai	a7, a14, 1
 307:	012b26        	beqi	a11, 2, 30c <sbc_frame_header_decode+0x88>
 30a:	228a           	add.n	a2, a2, a8

0000030c <sbc_frame_header_decode+0x88>:
 30c:	f27b           	addi.n	a15, a2, 7
 30e:	21f3f0        	srai	a15, a15, 3
 311:	f7fa           	add.n	a15, a7, a15
 313:	ff4b           	addi.n	a15, a15, 4
 315:	7e54f2        	s16i	a15, a4, 252

00000318 <sbc_frame_header_decode+0x94>:
 318:	061382        	l16ui	a8, a3, 12
 31b:	031342        	l16ui	a4, a3, 6
 31e:	7f2622        	l32i	a2, a6, 0x1fc
 321:	c15580        	mul16u	a5, a5, a8
 324:	c18480        	mul16u	a8, a4, a8
 327:	1a5352        	s16i	a5, a3, 52
 32a:	c14450        	mul16u	a4, a4, a5
 32d:	1b5342        	s16i	a4, a3, 54
 330:	185382        	s16i	a8, a3, 48
 333:	421b           	addi.n	a4, a2, 1
 335:	000222        	l8ui	a2, a2, 0
 338:	7f6642        	s32i	a4, a6, 0x1fc
 33b:	165322        	s16i	a2, a3, 44
 33e:	020c           	movi.n	a2, 0
 340:	f01d           	retw.n

00000342 <sbc_frame_header_decode+0xbe>:
 342:	c1b890        	mul16u	a11, a8, a9
 345:	c1c870        	mul16u	a12, a8, a7
 348:	82b2b0        	mull	a11, a2, a11
 34b:	21c1c0        	srai	a12, a12, 1
 34e:	bb7b           	addi.n	a11, a11, 7
 350:	21b3b0        	srai	a11, a11, 3
 353:	bbca           	add.n	a11, a11, a12
 355:	c3aa           	add.n	a12, a3, a10
 357:	bb4b           	addi.n	a11, a11, 4
 359:	7e5cb2        	s16i	a11, a12, 252
 35c:	ffee06        	j	318 <sbc_frame_header_decode+0x94>

0000035f <sbc_frame_header_decode+0xdb>:
	...

00000360 <change_endian16x>:
 360:	004136        	entry	a1, 32
 363:	743820        	extui	a3, a2, 8, 8
 366:	8a7230        	depbits	a3, a2, 8, 8
 369:	832d           	ae_sext16	a2, a3
 36b:	f01d           	retw.n

0000036d <change_endian16x+0xd>:
 36d:	000000                                        ...

00000370 <SBC_decode_preload>:
 370:	004136        	entry	a1, 32
 373:	04d2a2        	addmi	a10, a2, 0x400
 376:	0cd252        	addmi	a5, a2, 0xc00
 379:	3558           	l32i.n	a5, a5, 12
 37b:	d37c           	movi.n	a3, -3
 37d:	f47c           	movi.n	a4, -1
 37f:	304540        	xor	a4, a5, a4
 382:	046050        	extui	a6, a5, 0, 1
 385:	1166d0        	slli	a6, a6, 3
 388:	044040        	extui	a4, a4, 0, 1
 38b:	743b           	addi.n	a7, a4, 3
 38d:	032664        	wur.ae_bitptr	a6
 390:	12a347        	bge	a3, a4, 3a6 <SBC_decode_preload+0x36>
 393:	040c           	movi.n	a4, 0
 395:	0aa776        	loopgtz	a7, 3a3 <SBC_decode_preload+0x33>
 398:	000582        	l8ui	a8, a5, 0
 39b:	114480        	slli	a4, a4, 8
 39e:	551b           	addi.n	a5, a5, 1
 3a0:	0a7840        	depbits	a4, a8, 0, 8

000003a3 <SBC_decode_preload+0x33>:
 3a3:	000046        	j	3a8 <SBC_decode_preload+0x38>

000003a6 <SBC_decode_preload+0x36>:
 3a6:	040c           	movi.n	a4, 0

000003a8 <SBC_decode_preload+0x38>:
 3a8:	f3f140        	wur.ae_bithead	a4
 3ab:	fec592        	addi	a9, a5, -2
 3ae:	1b6a92        	s32i	a9, a10, 108
 3b1:	f01d           	retw.n

000003b3 <SBC_decode_preload+0x43>:
	...

000003b4 <sbc_frame_decode>:
 3b4:	004136        	entry	a1, 32
 3b7:	ff1e81        	l32r	a8, 30 (370 <SBC_decode_preload>)
 3ba:	02ad           	mov.n	a10, a2
 3bc:	0008e0        	callx8	a8
 3bf:	041292        	l16ui	a9, a2, 8
 3c2:	6ca2d2        	movi	a13, 0x26c
 3c5:	0b0c           	movi.n	a11, 0
 3c7:	283966        	bnei	a9, 3, 3f3 <sbc_frame_decode+0x3f>
 3ca:	02d2e2        	addmi	a14, a2, 0x200
 3cd:	0612b2        	l16ui	a11, a2, 12
 3d0:	03a7b4        	ae_lb	a10, a11
 3d3:	9b2ec2        	l32i	a12, a14, 0x26c
 3d6:	1752a2        	s16i	a10, a2, 46
 3d9:	9a9d           	ae_zext16	a9, a10
 3db:	1c1cb4        	ae_db	a12, a11
 3de:	9b6ec2        	s32i	a12, a14, 0x26c
 3e1:	fccbb2        	addi	a11, a11, -4
 3e4:	1a4b56        	bnez	a11, 58c <sbc_frame_decode+0x1d8>
 3e7:	34a0a0        	extui	a10, a10, 0, 4
 3ea:	11aac0        	slli	a10, a10, 4

000003ed <sbc_frame_decode+0x39>:
 3ed:	0b52a2        	s16i	a10, a2, 22
 3f0:	000106        	j	3f8 <sbc_frame_decode+0x44>

000003f3 <sbc_frame_decode+0x3f>:
 3f3:	090c           	movi.n	a9, 0
 3f5:	1752b2        	s16i	a11, a2, 46

000003f8 <sbc_frame_decode+0x44>:
 3f8:	59bc           	beqz.n	a9, 431 <sbc_frame_decode+0x7d>
 3fa:	1a0c           	movi.n	a10, 1
 3fc:	e2da           	add.n	a14, a2, a13
 3fe:	0612c2        	l16ui	a12, a2, 12
 401:	04d2d2        	addmi	a13, a2, 0x400
 404:	58cdd2        	addi	a13, a13, 88
 407:	7f6ed2        	s32i	a13, a14, 0x1fc
 40a:	bc0b           	addi.n	a11, a12, -1
 40c:	401b00        	ssl	a11
 40f:	a1aa00        	sll	a10, a10
 412:	bc9c           	beqz.n	a12, 431 <sbc_frame_decode+0x7d>
 414:	0b0c           	movi.n	a11, 0

00000416 <sbc_frame_decode+0x62>:
 416:	1712f2        	l16ui	a15, a2, 46
 419:	0c0af7        	bnone	a10, a15, 429 <sbc_frame_decode+0x75>
 41c:	7f2e82        	l32i	a8, a14, 0x1fc
 41f:	6dbd           	ae_s16i.n	a11, a13, 0
 421:	0612c2        	l16ui	a12, a2, 12
 424:	d82b           	addi.n	a13, a8, 2
 426:	7f6ed2        	s32i	a13, a14, 0x1fc

00000429 <sbc_frame_decode+0x75>:
 429:	41a1a0        	srli	a10, a10, 1
 42c:	bb1b           	addi.n	a11, a11, 1
 42e:	e42bc7        	blt	a11, a12, 416 <sbc_frame_decode+0x62>
 431:	041292        	l16ui	a9, a2, 8
 434:	0612a2        	l16ui	a10, a2, 12
 437:	103966        	bnei	a9, 3, 44b <sbc_frame_decode+0x97>
 43a:	fccaa2        	addi	a10, a10, -4
 43d:	106a56        	bnez	a10, 547 <sbc_frame_decode+0x193>
 440:	fefd81        	l32r	a8, 34 (1e0 <sbc_extract_scale_factors_joint_ch4>)
 443:	02ad           	mov.n	a10, a2
 445:	0008e0        	callx8	a8
 448:	000246        	j	455 <sbc_frame_decode+0xa1>

0000044b <sbc_frame_decode+0x97>:
 44b:	fefb81        	l32r	a8, 38 (22c <sbc_extract_scale_factors_joint_ch8_non>)
 44e:	02ad           	mov.n	a10, a2
 450:	2b0c           	movi.n	a11, 2
 452:	0008e0        	callx8	a8

00000455 <sbc_frame_decode+0xa1>:
 455:	fef981        	l32r	a8, 3c (17c <sbc_crc8>)
 458:	12c2a2        	addi	a10, a2, 18
 45b:	1512b2        	l16ui	a11, a2, 42
 45e:	0008e0        	callx8	a8
 461:	161292        	l16ui	a9, a2, 44
 464:	0a19a7        	beq	a9, a10, 472 <sbc_frame_decode+0xbe>
 467:	fef681        	l32r	a8, 40 (5c8 <sbc_zero_sb_samples>)
 46a:	02ad           	mov.n	a10, a2
 46c:	0008e0        	callx8	a8
 46f:	0003c6        	j	482 <sbc_frame_decode+0xce>

00000472 <sbc_frame_decode+0xbe>:
 472:	fef481        	l32r	a8, 44 (5f0 <sbc_bit_allocation>)
 475:	02ad           	mov.n	a10, a2
 477:	0008e0        	callx8	a8
 47a:	fef381        	l32r	a8, 48 (8c0 <sbc_reconstruction>)
 47d:	02ad           	mov.n	a10, a2
 47f:	0008e0        	callx8	a8

00000482 <sbc_frame_decode+0xce>:
 482:	0712a2        	l16ui	a10, a2, 14
 485:	1b1292        	l16ui	a9, a2, 54
 488:	041a66        	bnei	a10, 1, 490 <sbc_frame_decode+0xdc>
 48b:	096d           	mov.n	a6, a9
 48d:	000086        	j	493 <sbc_frame_decode+0xdf>

00000490 <sbc_frame_decode+0xdc>:
 490:	416190        	srli	a6, a9, 1

00000493 <sbc_frame_decode+0xdf>:
 493:	0fd292        	addmi	a9, a2, 0xf00
 496:	889992        	l16si	a9, a9, 0x110
 499:	20a772        	movi	a7, 0x720
 49c:	291966        	bnei	a9, 1, 4c9 <sbc_frame_decode+0x115>
 49f:	0612a2        	l16ui	a10, a2, 12
 4a2:	05d292        	addmi	a9, a2, 0x500
 4a5:	0bd252        	addmi	a5, a2, 0xb00
 4a8:	531582        	l16ui	a8, a5, 166
 4ab:	a0c992        	addi	a9, a9, -96
 4ae:	286592        	s32i	a9, a5, 160
 4b1:	525582        	s16i	a8, a5, 164
 4b4:	a8c552        	addi	a5, a5, -88
 4b7:	6c4a66        	bnei	a10, 4, 527 <sbc_frame_decode+0x173>
 4ba:	02cd           	mov.n	a12, a2
 4bc:	fee481        	l32r	a8, 4c (bb8 <SBC_synthesis4_per_channel>)
 4bf:	0a0c           	movi.n	a10, 0
 4c1:	03bd           	mov.n	a11, a3
 4c3:	0008e0        	callx8	a8
 4c6:	001a46        	j	533 <sbc_frame_decode+0x17f>

000004c9 <sbc_frame_decode+0x115>:
 4c9:	2d2966        	bnei	a9, 2, 4fa <sbc_frame_decode+0x146>
 4cc:	07d292        	addmi	a9, a2, 0x700
 4cf:	0bd252        	addmi	a5, a2, 0xb00
 4d2:	541582        	l16ui	a8, a5, 168
 4d5:	20c992        	addi	a9, a9, 32
 4d8:	286592        	s32i	a9, a5, 160
 4db:	061292        	l16ui	a9, a2, 12
 4de:	525582        	s16i	a8, a5, 164
 4e1:	a8c552        	addi	a5, a5, -88
 4e4:	fcc992        	addi	a9, a9, -4
 4e7:	0a6956        	bnez	a9, 591 <sbc_frame_decode+0x1dd>
 4ea:	02cd           	mov.n	a12, a2
 4ec:	fed881        	l32r	a8, 4c (bb8 <SBC_synthesis4_per_channel>)
 4ef:	1a0c           	movi.n	a10, 1
 4f1:	04bd           	mov.n	a11, a4
 4f3:	0008e0        	callx8	a8
 4f6:	0028c6        	j	59d <sbc_frame_decode+0x1e9>

000004f9 <sbc_frame_decode+0x145>:
	...

000004fa <sbc_frame_decode+0x146>:
 4fa:	045956        	bnez	a9, 543 <sbc_frame_decode+0x18f>
 4fd:	05d292        	addmi	a9, a2, 0x500
 500:	0bd252        	addmi	a5, a2, 0xb00
 503:	531582        	l16ui	a8, a5, 166
 506:	a0c992        	addi	a9, a9, -96
 509:	286592        	s32i	a9, a5, 160
 50c:	061292        	l16ui	a9, a2, 12
 50f:	525582        	s16i	a8, a5, 164
 512:	a8c552        	addi	a5, a5, -88
 515:	3b4966        	bnei	a9, 4, 554 <sbc_frame_decode+0x1a0>
 518:	03bd           	mov.n	a11, a3
 51a:	fecc81        	l32r	a8, 4c (bb8 <SBC_synthesis4_per_channel>)
 51d:	0a0c           	movi.n	a10, 0
 51f:	02cd           	mov.n	a12, a2
 521:	0008e0        	callx8	a8
 524:	000e06        	j	560 <sbc_frame_decode+0x1ac>

00000527 <sbc_frame_decode+0x173>:
 527:	02cd           	mov.n	a12, a2
 529:	fec981        	l32r	a8, 50 (ce0 <SBC_synthesis8_per_channel>)
 52c:	0a0c           	movi.n	a10, 0
 52e:	03bd           	mov.n	a11, a3
 530:	0008e0        	callx8	a8

00000533 <sbc_frame_decode+0x17f>:
 533:	7e1592        	l16ui	a9, a5, 252
 536:	7f5592        	s16i	a9, a5, 254
 539:	06a676        	loopgtz	a6, 543 <sbc_frame_decode+0x18f>
 53c:	23ad           	ae_l16si.n	a10, a3, 0
 53e:	09c4a4        	ae_s16ip	a10, a4, 2
 541:	332b           	addi.n	a3, a3, 2

00000543 <sbc_frame_decode+0x18f>:
 543:	020c           	movi.n	a2, 0
 545:	f01d           	retw.n

00000547 <sbc_frame_decode+0x193>:
 547:	febc81        	l32r	a8, 38 (22c <sbc_extract_scale_factors_joint_ch8_non>)
 54a:	02ad           	mov.n	a10, a2
 54c:	3b0c           	movi.n	a11, 3
 54e:	0008e0        	callx8	a8
 551:	ffc006        	j	455 <sbc_frame_decode+0xa1>

00000554 <sbc_frame_decode+0x1a0>:
 554:	03bd           	mov.n	a11, a3
 556:	febe81        	l32r	a8, 50 (ce0 <SBC_synthesis8_per_channel>)
 559:	0a0c           	movi.n	a10, 0
 55b:	02cd           	mov.n	a12, a2
 55d:	0008e0        	callx8	a8

00000560 <sbc_frame_decode+0x1ac>:
 560:	071292        	l16ui	a9, a2, 14
 563:	7e15a2        	l16ui	a10, a5, 252
 566:	7f55a2        	s16i	a10, a5, 254
 569:	d62966        	bnei	a9, 2, 543 <sbc_frame_decode+0x18f>
 56c:	8015c2        	l16ui	a12, a5, 0x100
 56f:	d27a           	add.n	a13, a2, a7
 571:	0612b2        	l16ui	a11, a2, 12
 574:	3e65d2        	s32i	a13, a5, 248
 577:	7e55c2        	s16i	a12, a5, 252
 57a:	324b66        	bnei	a11, 4, 5b0 <sbc_frame_decode+0x1fc>
 57d:	02cd           	mov.n	a12, a2
 57f:	feb381        	l32r	a8, 4c (bb8 <SBC_synthesis4_per_channel>)
 582:	04bd           	mov.n	a11, a4
 584:	1a0c           	movi.n	a10, 1
 586:	0008e0        	callx8	a8
 589:	000bc6        	j	5bc <sbc_frame_decode+0x208>

0000058c <sbc_frame_decode+0x1d8>:
 58c:	09ad           	mov.n	a10, a9
 58e:	ff96c6        	j	3ed <sbc_frame_decode+0x39>

00000591 <sbc_frame_decode+0x1dd>:
 591:	02cd           	mov.n	a12, a2
 593:	feaf81        	l32r	a8, 50 (ce0 <SBC_synthesis8_per_channel>)
 596:	1a0c           	movi.n	a10, 1
 598:	04bd           	mov.n	a11, a4
 59a:	0008e0        	callx8	a8

0000059d <sbc_frame_decode+0x1e9>:
 59d:	7e1592        	l16ui	a9, a5, 252
 5a0:	805592        	s16i	a9, a5, 0x100
 5a3:	06a676        	loopgtz	a6, 5ad <sbc_frame_decode+0x1f9>
 5a6:	24ad           	ae_l16si.n	a10, a4, 0
 5a8:	09c3a4        	ae_s16ip	a10, a3, 2
 5ab:	442b           	addi.n	a4, a4, 2

000005ad <sbc_frame_decode+0x1f9>:
 5ad:	ffe486        	j	543 <sbc_frame_decode+0x18f>

000005b0 <sbc_frame_decode+0x1fc>:
 5b0:	02cd           	mov.n	a12, a2
 5b2:	fea781        	l32r	a8, 50 (ce0 <SBC_synthesis8_per_channel>)
 5b5:	04bd           	mov.n	a11, a4
 5b7:	1a0c           	movi.n	a10, 1
 5b9:	0008e0        	callx8	a8

000005bc <sbc_frame_decode+0x208>:
 5bc:	7e1592        	l16ui	a9, a5, 252
 5bf:	805592        	s16i	a9, a5, 0x100
 5c2:	ffdf46        	j	543 <sbc_frame_decode+0x18f>

000005c5 <sbc_frame_decode+0x211>:
 5c5:	000000                                        ...

000005c8 <sbc_zero_sb_samples>:
 5c8:	004136        	entry	a1, 32
 5cb:	58c222        	addi	a2, a2, 88
 5ce:	040c           	movi.n	a4, 0
 5d0:	00a132        	movi	a3, 0x100
 5d3:	f03d           	nop.n
 5d5:	02a376        	loopgtz	a3, 5db <sbc_zero_sb_samples+0x13>
 5d8:	09e244        	ae_s32ip	a4, a2, 4

000005db <sbc_zero_sb_samples+0x13>:
 5db:	f01d           	retw.n

000005dd <sbc_zero_sb_samples+0x15>:
 5dd:	000000                                        ...

000005e0 <pseudo_stereo>:
 5e0:	004136        	entry	a1, 32
 5e3:	f01d           	retw.n

000005e5 <pseudo_stereo+0x5>:
 5e5:	000000                                        ...

000005e8 <pseudo_stereo_setup>:
 5e8:	004136        	entry	a1, 32
 5eb:	f01d           	retw.n

000005ed <pseudo_stereo_setup+0x5>:
 5ed:	000000                                        ...

000005f0 <sbc_bit_allocation>:
 5f0:	008136        	entry	a1, 64
 5f3:	051232        	l16ui	a3, a2, 10
 5f6:	0612e2        	l16ui	a14, a2, 12
 5f9:	041252        	l16ui	a5, a2, 8
 5fc:	1a1282        	l16ui	a8, a2, 52
 5ff:	0e4d           	mov.n	a4, a14
 601:	049150        	extui	a9, a5, 1, 1
 604:	93e890        	movnez	a14, a8, a9
 607:	351326        	beqi	a3, 1, 640 <sbc_bit_allocation+0x50>
 60a:	fe9291        	l32r	a9, 54 (1280 <SBC_OFFSET8>)
 60d:	021272        	l16ui	a7, a2, 4
 610:	fe9281        	l32r	a8, 58 (1260 <SBC_OFFSET4>)
 613:	fcc4a2        	addi	a10, a4, -4
 616:	c17740        	mul16u	a7, a7, a4
 619:	9389a0        	movnez	a8, a9, a10
 61c:	907780        	addx2	a7, a7, a8
 61f:	1d1ea6        	blti	a14, 1, 640 <sbc_bit_allocation+0x50>
 622:	540b           	addi.n	a5, a4, -1
 624:	00a062        	movi	a6, 0
 627:	04d242        	addmi	a4, a2, 0x400
 62a:	78c442        	addi	a4, a4, 120
 62d:	0c9e76        	loopnez	a14, 63d <sbc_bit_allocation+0x4d>
 630:	108560        	and	a8, a5, a6
 633:	661b           	addi.n	a6, a6, 1
 635:	908870        	addx2	a8, a8, a7
 638:	288d           	ae_l16si.n	a8, a8, 0
 63a:	09c484        	ae_s16ip	a8, a4, 2

0000063d <sbc_bit_allocation+0x4d>:
 63d:	041252        	l16ui	a5, a2, 8
 640:	0f0c           	movi.n	a15, 0
 642:	0b0c           	movi.n	a11, 0
 644:	0a1c           	movi.n	a10, 16
 646:	03d292        	addmi	a9, a2, 0x300
 649:	1d0c           	movi.n	a13, 1
 64b:	31d9           	s32i.n	a13, a1, 12
 64d:	7cc992        	addi	a9, a9, 124
 650:	1199           	s32i.n	a9, a1, 4

00000652 <sbc_bit_allocation+0x62>:
 652:	450b           	addi.n	a4, a5, -1
 654:	260c           	movi.n	a6, 2
 656:	130c           	movi.n	a3, 1
 658:	833640        	moveqz	a3, a6, a4
 65b:	022f37        	blt	a15, a3, 661 <sbc_bit_allocation+0x71>
 65e:	006386        	j	7f0 <sbc_bit_allocation+0x200>
 661:	061282        	l16ui	a8, a2, 12
 664:	fe7e41        	l32r	a4, 5c (baa <sbc_reconstruction+0x2ea>)
 667:	828f80        	mull	a8, a15, a8
 66a:	0512c2        	l16ui	a12, a2, 10
 66d:	908820        	addx2	a8, a8, a2
 670:	38c892        	addi	a9, a8, 56
 673:	0cd852        	addmi	a5, a8, 0xc00
 676:	aac552        	addi	a5, a5, -86
 679:	231c66        	bnei	a12, 1, 6a0 <sbc_bit_allocation+0xb0>
 67c:	021ee6        	bgei	a14, 1, 682 <sbc_bit_allocation+0x92>
 67f:	008286        	j	88d <sbc_bit_allocation+0x29d>
 682:	00a072        	movi	a7, 0
 685:	099e76        	loopnez	a14, 692 <sbc_bit_allocation+0xa2>
 688:	29cd           	ae_l16si.n	a12, a9, 0
 68a:	09c5c4        	ae_s16ip	a12, a5, 2
 68d:	992b           	addi.n	a9, a9, 2
 68f:	537c70        	max	a7, a12, a7

00000692 <sbc_bit_allocation+0xa2>:
 692:	061282        	l16ui	a8, a2, 12
 695:	828f80        	mull	a8, a15, a8
 698:	908820        	addx2	a8, a8, a2
 69b:	584a           	add.n	a5, a8, a4
 69d:	000e86        	j	6db <sbc_bit_allocation+0xeb>

000006a0 <sbc_bit_allocation+0xb0>:
 6a0:	351ea6        	blti	a14, 1, 6d9 <sbc_bit_allocation+0xe9>
 6a3:	098d           	mov.n	a8, a9
 6a5:	070c           	movi.n	a7, 0
 6a7:	1198           	l32i.n	a9, a1, 4
 6a9:	1e9e76        	loopnez	a14, 6cb <sbc_bit_allocation+0xdb>
 6ac:	486d           	ae_l16ui.n	a6, a8, 0
 6ae:	882b           	addi.n	a8, a8, 2
 6b0:	36cc           	bnez.n	a6, 6b7 <sbc_bit_allocation+0xc7>
 6b2:	b67c           	movi.n	a6, -5
 6b4:	0002c6        	j	6c3 <sbc_bit_allocation+0xd3>

000006b7 <sbc_bit_allocation+0xc7>:
 6b7:	7e99c2        	l16si	a12, a9, 252
 6ba:	c066c0        	sub	a6, a6, a12
 6bd:	0216a6        	blti	a6, 1, 6c3 <sbc_bit_allocation+0xd3>
 6c0:	216160        	srai	a6, a6, 1
 6c3:	09c564        	ae_s16ip	a6, a5, 2
 6c6:	537670        	max	a7, a6, a7
 6c9:	992b           	addi.n	a9, a9, 2

000006cb <sbc_bit_allocation+0xdb>:
 6cb:	061282        	l16ui	a8, a2, 12
 6ce:	828f80        	mull	a8, a15, a8
 6d1:	908820        	addx2	a8, a8, a2
 6d4:	584a           	add.n	a5, a8, a4
 6d6:	000046        	j	6db <sbc_bit_allocation+0xeb>

000006d9 <sbc_bit_allocation+0xe9>:
 6d9:	070c           	movi.n	a7, 0

000006db <sbc_bit_allocation+0xeb>:
 6db:	4159           	s32i.n	a5, a1, 16
 6dd:	771b           	addi.n	a7, a7, 1
 6df:	0812d2        	l16ui	a13, a2, 16
 6e2:	060c           	movi.n	a6, 0
 6e4:	0189           	s32i.n	a8, a1, 0

000006e6 <sbc_bit_allocation+0xf6>:
 6e6:	06cd           	mov.n	a12, a6
 6e8:	221ea6        	blti	a14, 1, 70e <sbc_bit_allocation+0x11e>
 6eb:	080c           	movi.n	a8, 0
 6ed:	97fb           	addi.n	a9, a7, 15
 6ef:	4158           	l32i.n	a5, a1, 16
 6f1:	159e76        	loopnez	a14, 70a <sbc_bit_allocation+0x11a>
 6f4:	256d           	ae_l16si.n	a6, a5, 0
 6f6:	552b           	addi.n	a5, a5, 2
 6f8:	07a767        	bge	a7, a6, 703 <sbc_bit_allocation+0x113>
 6fb:	04a697        	bge	a6, a9, 703 <sbc_bit_allocation+0x113>
 6fe:	881b           	addi.n	a8, a8, 1
 700:	000106        	j	708 <sbc_bit_allocation+0x118>

00000703 <sbc_bit_allocation+0x113>:
 703:	019677        	bne	a6, a7, 708 <sbc_bit_allocation+0x118>
 706:	882b           	addi.n	a8, a8, 2
 708:	f03d           	nop.n

0000070a <sbc_bit_allocation+0x11a>:
 70a:	000086        	j	710 <sbc_bit_allocation+0x120>

0000070d <sbc_bit_allocation+0x11d>:
	...

0000070e <sbc_bit_allocation+0x11e>:
 70e:	080c           	movi.n	a8, 0

00000710 <sbc_bit_allocation+0x120>:
 710:	770b           	addi.n	a7, a7, -1
 712:	68ca           	add.n	a6, a8, a12
 714:	ce26d7        	blt	a6, a13, 6e6 <sbc_bit_allocation+0xf6>
 717:	0396d7        	bne	a6, a13, 71e <sbc_bit_allocation+0x12e>
 71a:	06cd           	mov.n	a12, a6
 71c:	770b           	addi.n	a7, a7, -1

0000071e <sbc_bit_allocation+0x12e>:
 71e:	4158           	l32i.n	a5, a1, 16
 720:	0198           	l32i.n	a9, a1, 0
 722:	fe4f81        	l32r	a8, 60 (bea <SBC_synthesis4_per_channel+0x32>)
 725:	d72b           	addi.n	a13, a7, 2
 727:	0cd992        	addmi	a9, a9, 0xc00
 72a:	eac992        	addi	a9, a9, -22
 72d:	15ae76        	loopgtz	a14, 746 <sbc_bit_allocation+0x156>
 730:	256d           	ae_l16si.n	a6, a5, 0
 732:	552b           	addi.n	a5, a5, 2
 734:	04a6d7        	bge	a6, a13, 73c <sbc_bit_allocation+0x14c>
 737:	69bd           	ae_s16i.n	a11, a9, 0
 739:	0001c6        	j	744 <sbc_bit_allocation+0x154>

0000073c <sbc_bit_allocation+0x14c>:
 73c:	c03670        	sub	a3, a6, a7
 73f:	6333a0        	minu	a3, a3, a10
 742:	693d           	ae_s16i.n	a3, a9, 0

00000744 <sbc_bit_allocation+0x154>:
 744:	992b           	addi.n	a9, a9, 2

00000746 <sbc_bit_allocation+0x156>:
 746:	041252        	l16ui	a5, a2, 8
 749:	049150        	extui	a9, a5, 1, 1
 74c:	095956        	bnez	a9, 7e5 <sbc_bit_allocation+0x1f5>
 74f:	061262        	l16ui	a6, a2, 12
 752:	0812d2        	l16ui	a13, a2, 16
 755:	371b           	addi.n	a3, a7, 1
 757:	829f60        	mull	a9, a15, a6
 75a:	2139           	s32i.n	a3, a1, 8
 75c:	909920        	addx2	a9, a9, a2
 75f:	598a           	add.n	a5, a9, a8
 761:	0cd992        	addmi	a9, a9, 0xc00
 764:	aac992        	addi	a9, a9, -86

00000767 <sbc_bit_allocation+0x177>:
 767:	42acd7        	bge	a12, a13, 7ad <sbc_bit_allocation+0x1bd>
 76a:	3148           	l32i.n	a4, a1, 12
 76c:	824460        	mull	a4, a4, a6
 76f:	904420        	addx2	a4, a4, a2
 772:	448a           	add.n	a4, a4, a8
 774:	35b547        	bgeu	a5, a4, 7ad <sbc_bit_allocation+0x1bd>
 777:	454d           	ae_l16ui.n	a4, a5, 0
 779:	1124b6        	bltui	a4, 2, 78e <sbc_bit_allocation+0x19e>
 77c:	0eb4f6        	bgeui	a4, 16, 78e <sbc_bit_allocation+0x19e>
 77f:	cc1b           	addi.n	a12, a12, 1
 781:	841b           	addi.n	a8, a4, 1
 783:	658d           	ae_s16i.n	a8, a5, 0

00000785 <sbc_bit_allocation+0x195>:
 785:	061262        	l16ui	a6, a2, 12
 788:	0812d2        	l16ui	a13, a2, 16
 78b:	0002c6        	j	79a <sbc_bit_allocation+0x1aa>

0000078e <sbc_bit_allocation+0x19e>:
 78e:	2148           	l32i.n	a4, a1, 8
 790:	293d           	ae_l16si.n	a3, a9, 0
 792:	8c1b           	addi.n	a8, a12, 1
 794:	029347        	bne	a3, a4, 79a <sbc_bit_allocation+0x1aa>
 797:	0928d7        	blt	a8, a13, 7a4 <sbc_bit_allocation+0x1b4>
 79a:	fe3181        	l32r	a8, 60 (bea <SBC_synthesis4_per_channel+0x32>)
 79d:	552b           	addi.n	a5, a5, 2
 79f:	992b           	addi.n	a9, a9, 2
 7a1:	fff086        	j	767 <sbc_bit_allocation+0x177>

000007a4 <sbc_bit_allocation+0x1b4>:
 7a4:	cc2b           	addi.n	a12, a12, 2
 7a6:	2d0c           	movi.n	a13, 2
 7a8:	65dd           	ae_s16i.n	a13, a5, 0
 7aa:	fff5c6        	j	785 <sbc_bit_allocation+0x195>

000007ad <sbc_bit_allocation+0x1bd>:
 7ad:	825f60        	mull	a5, a15, a6
 7b0:	fe2c81        	l32r	a8, 60 (bea <SBC_synthesis4_per_channel+0x32>)
 7b3:	905520        	addx2	a5, a5, a2
 7b6:	0cd552        	addmi	a5, a5, 0xc00
 7b9:	eac552        	addi	a5, a5, -22

000007bc <sbc_bit_allocation+0x1cc>:
 7bc:	22acd7        	bge	a12, a13, 7e2 <sbc_bit_allocation+0x1f2>
 7bf:	061232        	l16ui	a3, a2, 12
 7c2:	3198           	l32i.n	a9, a1, 12
 7c4:	829930        	mull	a9, a9, a3
 7c7:	909920        	addx2	a9, a9, a2
 7ca:	998a           	add.n	a9, a9, a8
 7cc:	12b597        	bgeu	a5, a9, 7e2 <sbc_bit_allocation+0x1f2>
 7cf:	454d           	ae_l16ui.n	a4, a5, 0
 7d1:	08b4f6        	bgeui	a4, 16, 7dd <sbc_bit_allocation+0x1ed>
 7d4:	cc1b           	addi.n	a12, a12, 1
 7d6:	941b           	addi.n	a9, a4, 1
 7d8:	659d           	ae_s16i.n	a9, a5, 0
 7da:	0812d2        	l16ui	a13, a2, 16

000007dd <sbc_bit_allocation+0x1ed>:
 7dd:	552b           	addi.n	a5, a5, 2
 7df:	fff646        	j	7bc <sbc_bit_allocation+0x1cc>

000007e2 <sbc_bit_allocation+0x1f2>:
 7e2:	041252        	l16ui	a5, a2, 8

000007e5 <sbc_bit_allocation+0x1f5>:
 7e5:	31d8           	l32i.n	a13, a1, 12
 7e7:	ff1b           	addi.n	a15, a15, 1
 7e9:	dd1b           	addi.n	a13, a13, 1
 7eb:	31d9           	s32i.n	a13, a1, 12
 7ed:	ff9846        	j	652 <sbc_bit_allocation+0x62>

000007f0 <sbc_bit_allocation+0x200>:
 7f0:	04e150        	extui	a14, a5, 1, 1
 7f3:	094e16        	beqz	a14, 88b <sbc_bit_allocation+0x29b>
 7f6:	f71b           	addi.n	a15, a7, 1
 7f8:	0812d2        	l16ui	a13, a2, 16
 7fb:	070c           	movi.n	a7, 0
 7fd:	21f9           	s32i.n	a15, a1, 8
 7ff:	0f0c           	movi.n	a15, 0

00000801 <sbc_bit_allocation+0x211>:
 801:	4eacd7        	bge	a12, a13, 853 <sbc_bit_allocation+0x263>
 804:	061262        	l16ui	a6, a2, 12
 807:	48a767        	bge	a7, a6, 853 <sbc_bit_allocation+0x263>
 80a:	829f60        	mull	a9, a15, a6
 80d:	979a           	add.n	a9, a7, a9
 80f:	909920        	addx2	a9, a9, a2
 812:	0cd952        	addmi	a5, a9, 0xc00
 815:	eac552        	addi	a5, a5, -22
 818:	454d           	ae_l16ui.n	a4, a5, 0
 81a:	0cd992        	addmi	a9, a9, 0xc00
 81d:	aac992        	addi	a9, a9, -86
 820:	1524b6        	bltui	a4, 2, 839 <sbc_bit_allocation+0x249>
 823:	12b4f6        	bgeui	a4, 16, 839 <sbc_bit_allocation+0x249>
 826:	cc1b           	addi.n	a12, a12, 1
 828:	a41b           	addi.n	a10, a4, 1
 82a:	65ad           	ae_s16i.n	a10, a5, 0

0000082c <sbc_bit_allocation+0x23c>:
 82c:	0812d2        	l16ui	a13, a2, 16

0000082f <sbc_bit_allocation+0x23f>:
 82f:	1b1f66        	bnei	a15, 1, 84e <sbc_bit_allocation+0x25e>
 832:	771b           	addi.n	a7, a7, 1
 834:	0f0c           	movi.n	a15, 0
 836:	fff1c6        	j	801 <sbc_bit_allocation+0x211>

00000839 <sbc_bit_allocation+0x249>:
 839:	21e8           	l32i.n	a14, a1, 8
 83b:	29bd           	ae_l16si.n	a11, a9, 0
 83d:	ee9be7        	bne	a11, a14, 82f <sbc_bit_allocation+0x23f>
 840:	3c1b           	addi.n	a3, a12, 1
 842:	e9a3d7        	bge	a3, a13, 82f <sbc_bit_allocation+0x23f>
 845:	cc2b           	addi.n	a12, a12, 2
 847:	280c           	movi.n	a8, 2
 849:	658d           	ae_s16i.n	a8, a5, 0
 84b:	fff746        	j	82c <sbc_bit_allocation+0x23c>

0000084e <sbc_bit_allocation+0x25e>:
 84e:	1f0c           	movi.n	a15, 1
 850:	ffeb46        	j	801 <sbc_bit_allocation+0x211>

00000853 <sbc_bit_allocation+0x263>:
 853:	070c           	movi.n	a7, 0
 855:	0f0c           	movi.n	a15, 0
 857:	0000c6        	j	85e <sbc_bit_allocation+0x26e>

0000085a <sbc_bit_allocation+0x26a>:
 85a:	771b           	addi.n	a7, a7, 1
 85c:	0f0c           	movi.n	a15, 0

0000085e <sbc_bit_allocation+0x26e>:
 85e:	29acd7        	bge	a12, a13, 88b <sbc_bit_allocation+0x29b>
 861:	061262        	l16ui	a6, a2, 12
 864:	23a767        	bge	a7, a6, 88b <sbc_bit_allocation+0x29b>
 867:	825f60        	mull	a5, a15, a6
 86a:	575a           	add.n	a5, a7, a5
 86c:	905520        	addx2	a5, a5, a2
 86f:	0cd552        	addmi	a5, a5, 0xc00
 872:	eac552        	addi	a5, a5, -22
 875:	454d           	ae_l16ui.n	a4, a5, 0
 877:	08b4f6        	bgeui	a4, 16, 883 <sbc_bit_allocation+0x293>
 87a:	cc1b           	addi.n	a12, a12, 1
 87c:	841b           	addi.n	a8, a4, 1
 87e:	658d           	ae_s16i.n	a8, a5, 0
 880:	0812d2        	l16ui	a13, a2, 16

00000883 <sbc_bit_allocation+0x293>:
 883:	d31f26        	beqi	a15, 1, 85a <sbc_bit_allocation+0x26a>
 886:	1f0c           	movi.n	a15, 1
 888:	fff486        	j	85e <sbc_bit_allocation+0x26e>

0000088b <sbc_bit_allocation+0x29b>:
 88b:	f01d           	retw.n

0000088d <sbc_bit_allocation+0x29d>:
 88d:	070c           	movi.n	a7, 0
 88f:	ff9206        	j	6db <sbc_bit_allocation+0xeb>

00000892 <sbc_bit_allocation+0x2a2>:
 892:	00000000 41360000                                ......

00000898 <SAT_ADD>:
 898:	004136        	entry	a1, 32
 89b:	36c334        	ae_cvtq48a32s	aeq3, a3
 89e:	368234        	ae_cvtq48a32s	aeq2, a2
 8a1:	066b04        	ae_addsq56s	aeq1, aeq2, aeq3
 8a4:	061834        	ae_roundsq32sym	aeq0, aeq1
 8a7:	368204        	ae_trunca32q48	a2, aeq0
 8aa:	f01d           	retw.n

000008ac <SAT_SUB>:
 8ac:	004136        	entry	a1, 32
 8af:	36c334        	ae_cvtq48a32s	aeq3, a3
 8b2:	368234        	ae_cvtq48a32s	aeq2, a2
 8b5:	066b14        	ae_subsq56s	aeq1, aeq2, aeq3
 8b8:	061834        	ae_roundsq32sym	aeq0, aeq1
 8bb:	368204        	ae_trunca32q48	a2, aeq0
 8be:	f01d           	retw.n

000008c0 <sbc_reconstruction>:
 8c0:	006136        	entry	a1, 48
 8c3:	1a1282        	l16ui	a8, a2, 52
 8c6:	48c292        	addi	a9, a2, 72
 8c9:	0cd2c2        	addmi	a12, a2, 0xc00
 8cc:	4d0c           	movi.n	a13, 4
 8ce:	303dd4        	ae_cvtp24a16x2.ll	aep3, a13, a13
 8d1:	c8ccb2        	addi	a11, a12, -56
 8d4:	400984        	ae_lp16f.i	aep0, a9, -16
 8d7:	eacca2        	addi	a10, a12, -22
 8da:	38c292        	addi	a9, a2, 56
 8dd:	faccc2        	addi	a12, a12, -6
 8e0:	401c84        	ae_lp16f.i	aep1, a12, -16
 8e3:	f03d           	nop.n
 8e5:	0c9876        	loopnez	a8, 8f5 <sbc_reconstruction+0x35>
 8e8:	de22ac891f 	{ ae_lp16f.iu	aep0, a9, 2; ae_subsp24s	aep4, aep0, aep1 }
 8ed:	d9712c9a1f 	{ ae_lp16f.iu	aep1, a10, 2; ae_addsp24s	aep2, aep4, aep3 }
 8f2:	42ab14        	ae_sp16f.l.iu	aep2, a11, 2

000008f5 <sbc_reconstruction+0x35>:
 8f5:	fddbf1        	l32r	a15, 64 (1320 <S_ARRAY>)
 8f8:	2d0c           	movi.n	a13, 2
 8fa:	1b12e2        	l16ui	a14, a2, 54
 8fd:	1a12a2        	l16ui	a10, a2, 52
 900:	0cd292        	addmi	a9, a2, 0xc00
 903:	02d2c2        	addmi	a12, a2, 0x200
 906:	6ccc32        	addi	a3, a12, 108
 909:	cac992        	addi	a9, a9, -54
 90c:	9b2cc2        	l32i	a12, a12, 0x26c
 90f:	f3f690        	wur.ae_cbegin0	a9
 912:	90aa20        	addx2	a10, a10, a2
 915:	0cdaa2        	addmi	a10, a10, 0xc00
 918:	cacaa2        	addi	a10, a10, -54
 91b:	f3f7a0        	wur.ae_cend0	a10
 91e:	fd248542ae 	{ addi	a10, a2, 84; ae_zeroq56	aeq1 }
 923:	f03d           	nop.n
 925:	2cae76        	loopgtz	a14, 955 <sbc_reconstruction+0x95>
 928:	1019b2        	l16ui	a11, a9, 32
 92b:	fc0c5909df 	{ ae_lp16f.c	aep0, a9, a13; ae_movq56	aeq0, aeq1 }
 930:	0387b4        	ae_lb	a8, a11
 933:	bb9c           	beqz.n	a11, 952 <sbc_reconstruction+0x92>
 935:	1c1cb4        	ae_db	a12, a11
 938:	306884        	ae_cvtp24a16x2.ll	aep6, a8, a8
 93b:	11ebe0        	slli	a14, a11, 2
 93e:	455fe4        	ae_lp16x2f.x	aep5, a15, a14
 941:	0765e4        	ae_subp24	aep6, aep6, aep5
 944:	02d664        	ae_mulp24s.lh	aeq2, aep5, aep6
 947:	360e24        	ae_trunca16p24s.l	a14, aep0
 94a:	fc24feae0f 	{ ae_slaasq56s	aeq0, aeq2, a14; nop }
 94f:	060834        	ae_roundsq32sym	aeq0, aeq0

00000952 <sbc_reconstruction+0x92>:
 952:	624a14        	ae_sq32f.iu	aeq0, a10, 4

00000955 <sbc_reconstruction+0x95>:
 955:	8063c2        	s32i	a12, a3, 0x200
 958:	0fd292        	addmi	a9, a2, 0xf00
 95b:	889992        	l16si	a9, a9, 0x110
 95e:	5aa3b2        	movi	a11, 0x35a
 961:	5ca3c2        	movi	a12, 0x35c
 964:	6b1966        	bnei	a9, 1, 9d3 <sbc_reconstruction+0x113>
 967:	1712a2        	l16ui	a10, a2, 46
 96a:	1aba16        	beqz	a10, b19 <sbc_reconstruction+0x259>
 96d:	1b12a2        	l16ui	a10, a2, 54
 970:	7f23e2        	l32i	a14, a3, 0x1fc
 973:	2f0c           	movi.n	a15, 2
 975:	ffdad2        	addmi	a13, a10, 0xffffff00
 978:	c0ee20        	sub	a14, a14, a2
 97b:	fcdee2        	addmi	a14, a14, 0xfffffc00
 97e:	a8cee2        	addi	a14, a14, -88
 981:	d2eef0        	quos	a14, a14, a15
 984:	11e9           	s32i.n	a14, a1, 4
 986:	191d56        	bnez	a13, b1b <sbc_reconstruction+0x25b>
 989:	0612f2        	l16ui	a15, a2, 12
 98c:	f8cff2        	addi	a15, a15, -8
 98f:	188f56        	bnez	a15, b1b <sbc_reconstruction+0x25b>
 992:	060c           	movi.n	a6, 0
 994:	8e0b           	addi.n	a8, a14, -1
 996:	03d272        	addmi	a7, a2, 0x300
 999:	5ac772        	addi	a7, a7, 90
 99c:	908820        	addx2	a8, a8, a2
 99f:	03d882        	addmi	a8, a8, 0x300
 9a2:	5cc882        	addi	a8, a8, 92
 9a5:	0189           	s32i.n	a8, a1, 0

000009a7 <sbc_reconstruction+0xe7>:
 9a7:	1198           	l32i.n	a9, a1, 4
 9a9:	0138           	l32i.n	a3, a1, 0
 9ab:	1c19a6        	blti	a9, 1, 9cb <sbc_reconstruction+0x10b>

000009ae <sbc_reconstruction+0xee>:
 9ae:	7e1342        	l16ui	a4, a3, 252
 9b1:	fdad81        	l32r	a8, 68 (898 <SAT_ADD>)
 9b4:	464a           	add.n	a4, a6, a4
 9b6:	a04420        	addx4	a4, a4, a2
 9b9:	1624a2        	l32i	a10, a4, 88
 9bc:	1e24b2        	l32i	a11, a4, 120
 9bf:	0008e0        	callx8	a8
 9c2:	1664a2        	s32i	a10, a4, 88
 9c5:	fec332        	addi	a3, a3, -2
 9c8:	e29377        	bne	a3, a7, 9ae <sbc_reconstruction+0xee>

000009cb <sbc_reconstruction+0x10b>:
 9cb:	10c662        	addi	a6, a6, 16
 9ce:	d5f6a6        	blti	a6, 0x100, 9a7 <sbc_reconstruction+0xe7>
 9d1:	f01d           	retw.n

000009d3 <sbc_reconstruction+0x113>:
 9d3:	6b2966        	bnei	a9, 2, a42 <sbc_reconstruction+0x182>
 9d6:	171282        	l16ui	a8, a2, 46
 9d9:	13c816        	beqz	a8, b19 <sbc_reconstruction+0x259>
 9dc:	1b12a2        	l16ui	a10, a2, 54
 9df:	7f23d2        	l32i	a13, a3, 0x1fc
 9e2:	2e0c           	movi.n	a14, 2
 9e4:	ffda92        	addmi	a9, a10, 0xffffff00
 9e7:	c0dd20        	sub	a13, a13, a2
 9ea:	fcddd2        	addmi	a13, a13, 0xfffffc00
 9ed:	a8cdd2        	addi	a13, a13, -88
 9f0:	d2dde0        	quos	a13, a13, a14
 9f3:	11d9           	s32i.n	a13, a1, 4
 9f5:	16e956        	bnez	a9, b67 <sbc_reconstruction+0x2a7>
 9f8:	0612e2        	l16ui	a14, a2, 12
 9fb:	f8cee2        	addi	a14, a14, -8
 9fe:	165e56        	bnez	a14, b67 <sbc_reconstruction+0x2a7>
 a01:	060c           	movi.n	a6, 0
 a03:	fd0b           	addi.n	a15, a13, -1
 a05:	03d272        	addmi	a7, a2, 0x300
 a08:	5ac772        	addi	a7, a7, 90
 a0b:	90ff20        	addx2	a15, a15, a2
 a0e:	03dff2        	addmi	a15, a15, 0x300
 a11:	5ccff2        	addi	a15, a15, 92
 a14:	01f9           	s32i.n	a15, a1, 0

00000a16 <sbc_reconstruction+0x156>:
 a16:	1188           	l32i.n	a8, a1, 4
 a18:	0138           	l32i.n	a3, a1, 0
 a1a:	1c18a6        	blti	a8, 1, a3a <sbc_reconstruction+0x17a>

00000a1d <sbc_reconstruction+0x15d>:
 a1d:	7e1342        	l16ui	a4, a3, 252
 a20:	fd9381        	l32r	a8, 6c (8ac <SAT_SUB>)
 a23:	464a           	add.n	a4, a6, a4
 a25:	a04420        	addx4	a4, a4, a2
 a28:	1624a2        	l32i	a10, a4, 88
 a2b:	1e24b2        	l32i	a11, a4, 120
 a2e:	0008e0        	callx8	a8
 a31:	1e64a2        	s32i	a10, a4, 120
 a34:	fec332        	addi	a3, a3, -2
 a37:	e29377        	bne	a3, a7, a1d <sbc_reconstruction+0x15d>

00000a3a <sbc_reconstruction+0x17a>:
 a3a:	10c662        	addi	a6, a6, 16
 a3d:	d5f6a6        	blti	a6, 0x100, a16 <sbc_reconstruction+0x156>
 a40:	f01d           	retw.n

00000a42 <sbc_reconstruction+0x182>:
 a42:	0d3956        	bnez	a9, b19 <sbc_reconstruction+0x259>
 a45:	171282        	l16ui	a8, a2, 46
 a48:	0cd816        	beqz	a8, b19 <sbc_reconstruction+0x259>
 a4b:	7f2392        	l32i	a9, a3, 0x1fc
 a4e:	1b12a2        	l16ui	a10, a2, 54
 a51:	2d0c           	movi.n	a13, 2
 a53:	c09920        	sub	a9, a9, a2
 a56:	fcd992        	addmi	a9, a9, 0xfffffc00
 a59:	a8c992        	addi	a9, a9, -88
 a5c:	d299d0        	quos	a9, a9, a13
 a5f:	1199           	s32i.n	a9, a1, 4
 a61:	57fa66        	bnei	a10, 0x100, abc <sbc_reconstruction+0x1fc>
 a64:	0612d2        	l16ui	a13, a2, 12
 a67:	518d66        	bnei	a13, 8, abc <sbc_reconstruction+0x1fc>
 a6a:	060c           	movi.n	a6, 0
 a6c:	e90b           	addi.n	a14, a9, -1
 a6e:	03d272        	addmi	a7, a2, 0x300
 a71:	5ac772        	addi	a7, a7, 90
 a74:	90ee20        	addx2	a14, a14, a2
 a77:	03dee2        	addmi	a14, a14, 0x300
 a7a:	5ccee2        	addi	a14, a14, 92
 a7d:	01e9           	s32i.n	a14, a1, 0

00000a7f <sbc_reconstruction+0x1bf>:
 a7f:	11f8           	l32i.n	a15, a1, 4
 a81:	0138           	l32i.n	a3, a1, 0
 a83:	2d1fa6        	blti	a15, 1, ab4 <sbc_reconstruction+0x1f4>

00000a86 <sbc_reconstruction+0x1c6>:
 a86:	7e1342        	l16ui	a4, a3, 252
 a89:	fd7781        	l32r	a8, 68 (898 <SAT_ADD>)
 a8c:	464a           	add.n	a4, a6, a4
 a8e:	a04420        	addx4	a4, a4, a2
 a91:	1624a2        	l32i	a10, a4, 88
 a94:	1e24b2        	l32i	a11, a4, 120
 a97:	0008e0        	callx8	a8
 a9a:	0a5d           	mov.n	a5, a10
 a9c:	fd7481        	l32r	a8, 6c (8ac <SAT_SUB>)
 a9f:	1e24b2        	l32i	a11, a4, 120
 aa2:	1624a2        	l32i	a10, a4, 88
 aa5:	0008e0        	callx8	a8
 aa8:	166452        	s32i	a5, a4, 88
 aab:	1e64a2        	s32i	a10, a4, 120
 aae:	fec332        	addi	a3, a3, -2
 ab1:	d19377        	bne	a3, a7, a86 <sbc_reconstruction+0x1c6>

00000ab4 <sbc_reconstruction+0x1f4>:
 ab4:	10c662        	addi	a6, a6, 16
 ab7:	c4f6a6        	blti	a6, 0x100, a7f <sbc_reconstruction+0x1bf>
 aba:	f01d           	retw.n

00000abc <sbc_reconstruction+0x1fc>:
 abc:	059a16        	beqz	a10, b19 <sbc_reconstruction+0x259>
 abf:	1198           	l32i.n	a9, a1, 4
 ac1:	72ba           	add.n	a7, a2, a11
 ac3:	060c           	movi.n	a6, 0
 ac5:	990b           	addi.n	a9, a9, -1
 ac7:	909920        	addx2	a9, a9, a2
 aca:	99ca           	add.n	a9, a9, a12
 acc:	0199           	s32i.n	a9, a1, 0

00000ace <sbc_reconstruction+0x20e>:
 ace:	11b8           	l32i.n	a11, a1, 4
 ad0:	0138           	l32i.n	a3, a1, 0
 ad2:	3a1ba6        	blti	a11, 1, b10 <sbc_reconstruction+0x250>

00000ad5 <sbc_reconstruction+0x215>:
 ad5:	7e1342        	l16ui	a4, a3, 252
 ad8:	061252        	l16ui	a5, a2, 12
 adb:	fd6381        	l32r	a8, 68 (898 <SAT_ADD>)
 ade:	464a           	add.n	a4, a6, a4
 ae0:	554a           	add.n	a5, a5, a4
 ae2:	a05520        	addx4	a5, a5, a2
 ae5:	a04420        	addx4	a4, a4, a2
 ae8:	1624a2        	l32i	a10, a4, 88
 aeb:	1625b2        	l32i	a11, a5, 88
 aee:	0008e0        	callx8	a8
 af1:	21a9           	s32i.n	a10, a1, 8
 af3:	fd5e81        	l32r	a8, 6c (8ac <SAT_SUB>)
 af6:	1625b2        	l32i	a11, a5, 88
 af9:	1624a2        	l32i	a10, a4, 88
 afc:	0008e0        	callx8	a8
 aff:	fec332        	addi	a3, a3, -2
 b02:	2198           	l32i.n	a9, a1, 8
 b04:	166492        	s32i	a9, a4, 88
 b07:	1665a2        	s32i	a10, a5, 88
 b0a:	c79377        	bne	a3, a7, ad5 <sbc_reconstruction+0x215>
 b0d:	1b12a2        	l16ui	a10, a2, 54

00000b10 <sbc_reconstruction+0x250>:
 b10:	0612b2        	l16ui	a11, a2, 12
 b13:	906b60        	addx2	a6, a11, a6
 b16:	b426a7        	blt	a6, a10, ace <sbc_reconstruction+0x20e>

00000b19 <sbc_reconstruction+0x259>:
 b19:	f01d           	retw.n

00000b1b <sbc_reconstruction+0x25b>:
 b1b:	fa1aa6        	blti	a10, 1, b19 <sbc_reconstruction+0x259>
 b1e:	11d8           	l32i.n	a13, a1, 4
 b20:	72ba           	add.n	a7, a2, a11
 b22:	060c           	movi.n	a6, 0
 b24:	dd0b           	addi.n	a13, a13, -1
 b26:	90dd20        	addx2	a13, a13, a2
 b29:	ddca           	add.n	a13, a13, a12
 b2b:	01d9           	s32i.n	a13, a1, 0

00000b2d <sbc_reconstruction+0x26d>:
 b2d:	11e8           	l32i.n	a14, a1, 4
 b2f:	0138           	l32i.n	a3, a1, 0
 b31:	271ea6        	blti	a14, 1, b5c <sbc_reconstruction+0x29c>

00000b34 <sbc_reconstruction+0x274>:
 b34:	7e1342        	l16ui	a4, a3, 252
 b37:	0612b2        	l16ui	a11, a2, 12
 b3a:	fd4b81        	l32r	a8, 68 (898 <SAT_ADD>)
 b3d:	464a           	add.n	a4, a6, a4
 b3f:	bb4a           	add.n	a11, a11, a4
 b41:	a0bb20        	addx4	a11, a11, a2
 b44:	a04420        	addx4	a4, a4, a2
 b47:	1624a2        	l32i	a10, a4, 88
 b4a:	162bb2        	l32i	a11, a11, 88
 b4d:	0008e0        	callx8	a8
 b50:	1664a2        	s32i	a10, a4, 88
 b53:	fec332        	addi	a3, a3, -2
 b56:	da9377        	bne	a3, a7, b34 <sbc_reconstruction+0x274>
 b59:	1b12a2        	l16ui	a10, a2, 54

00000b5c <sbc_reconstruction+0x29c>:
 b5c:	061282        	l16ui	a8, a2, 12
 b5f:	906860        	addx2	a6, a8, a6
 b62:	c726a7        	blt	a6, a10, b2d <sbc_reconstruction+0x26d>
 b65:	f01d           	retw.n

00000b67 <sbc_reconstruction+0x2a7>:
 b67:	faea16        	beqz	a10, b19 <sbc_reconstruction+0x259>
 b6a:	1198           	l32i.n	a9, a1, 4
 b6c:	72ba           	add.n	a7, a2, a11
 b6e:	060c           	movi.n	a6, 0
 b70:	990b           	addi.n	a9, a9, -1
 b72:	909920        	addx2	a9, a9, a2
 b75:	99ca           	add.n	a9, a9, a12
 b77:	0199           	s32i.n	a9, a1, 0

00000b79 <sbc_reconstruction+0x2b9>:
 b79:	11b8           	l32i.n	a11, a1, 4
 b7b:	0138           	l32i.n	a3, a1, 0
 b7d:	271ba6        	blti	a11, 1, ba8 <sbc_reconstruction+0x2e8>

00000b80 <sbc_reconstruction+0x2c0>:
 b80:	7e13a2        	l16ui	a10, a3, 252
 b83:	061252        	l16ui	a5, a2, 12
 b86:	fd3981        	l32r	a8, 6c (8ac <SAT_SUB>)
 b89:	a6aa           	add.n	a10, a6, a10
 b8b:	55aa           	add.n	a5, a5, a10
 b8d:	a05520        	addx4	a5, a5, a2
 b90:	a0aa20        	addx4	a10, a10, a2
 b93:	162aa2        	l32i	a10, a10, 88
 b96:	1625b2        	l32i	a11, a5, 88
 b99:	0008e0        	callx8	a8
 b9c:	1665a2        	s32i	a10, a5, 88
 b9f:	fec332        	addi	a3, a3, -2
 ba2:	da9377        	bne	a3, a7, b80 <sbc_reconstruction+0x2c0>
 ba5:	1b12a2        	l16ui	a10, a2, 54

00000ba8 <sbc_reconstruction+0x2e8>:
 ba8:	0612b2        	l16ui	a11, a2, 12
 bab:	906b60        	addx2	a6, a11, a6
 bae:	c726a7        	blt	a6, a10, b79 <sbc_reconstruction+0x2b9>
 bb1:	f01d           	retw.n

00000bb3 <sbc_reconstruction+0x2f3>:
 bb3:	00000000 00613600                                .....

00000bb8 <SBC_synthesis4_per_channel>:
 bb8:	006136        	entry	a1, 48
 bbb:	fec372        	addi	a7, a3, -2
 bbe:	031452        	l16ui	a5, a4, 6
 bc1:	4a0c           	movi.n	a10, 4
 bc3:	932a20        	movnez	a2, a10, a2
 bc6:	a09240        	addx4	a9, a2, a4
 bc9:	58c992        	addi	a9, a9, 88
 bcc:	0215e6        	bgei	a5, 1, bd2 <SBC_synthesis4_per_channel+0x1a>
 bcf:	004206        	j	cdb <SBC_synthesis4_per_channel+0x123>
 bd2:	0b0c           	movi.n	a11, 0
 bd4:	fd28c1        	l32r	a12, 74 (1600 <SBC_cos_coef_8+0x1d0>)
 bd7:	030c           	movi.n	a3, 0
 bd9:	880c           	movi.n	a8, 8
 bdb:	fd25e1        	l32r	a14, 70 (5a00 <_end+0x36c0>)
 bde:	fd26f1        	l32r	a15, 78 (13b0 <SBC_cos_coef_4+0x40>)
 be1:	0bd4d2        	addmi	a13, a4, 0xb00
 be4:	a4cdd2        	addi	a13, a13, -92
 be7:	01f9           	s32i.n	a15, a1, 0
 be9:	303ee4        	ae_cvtp24a16x2.ll	aep3, a14, a14
 bec:	fd248001ef 	{ movi	a14, 1; ae_zeroq56	aeq1 }

00000bf1 <SBC_synthesis4_per_channel+0x39>:
 bf1:	f3f690        	wur.ae_cbegin0	a9
 bf4:	3f2da2        	l32i	a10, a13, 252
 bf7:	10c962        	addi	a6, a9, 16
 bfa:	801df2        	l16ui	a15, a13, 0x100
 bfd:	f3f760        	wur.ae_cend0	a6
 c00:	096d           	mov.n	a6, a9
 c02:	f7cf52        	addi	a5, a15, -9
 c05:	2f1b           	addi.n	a2, a15, 1
 c07:	832350        	moveqz	a2, a3, a5
 c0a:	805d22        	s16i	a2, a13, 0x100
 c0d:	850c           	movi.n	a5, 8
 c0f:	a02fa0        	addx4	a2, a15, a10
 c12:	0a6f07        	bbci	a15, 0, c20 <SBC_synthesis4_per_channel+0x68>
 c15:	0138           	l32i.n	a3, a1, 0
 c17:	01daa2        	addmi	a10, a10, 0x100
 c1a:	a0caa2        	addi	a10, a10, -96
 c1d:	000086        	j	c23 <SBC_synthesis4_per_channel+0x6b>

00000c20 <SBC_synthesis4_per_channel+0x68>:
 c20:	fd1731        	l32r	a3, 7c (1370 <SBC_cos_coef_4>)

00000c23 <SBC_synthesis4_per_channel+0x6b>:
 c23:	f8c332        	addi	a3, a3, -8
 c26:	1da576        	loopgtz	a5, c47 <SBC_synthesis4_per_channel+0x8f>
 c29:	fc24ddc68f 	{ ae_lp24x2f.c	aep4, a6, a8; nop }
 c2e:	5cd314        	ae_lp24x2f.iu	aep5, a3, 8
 c31:	fc0c6fa31f 	{ ae_lp24x2f.iu	aep2, a3, 8; ae_movq56	aeq0, aeq1 }
 c36:	e2b01d968f 	{ ae_lp24x2f.c	aep1, a6, a8; ae_mulaafp24s.hh.ll	aeq0, aep4, aep5 }
 c3b:	051204        	ae_mulaafp24s.hh.ll	aeq0, aep1, aep2
 c3e:	1b8c04        	ae_roundsp24q48sym	aep0, aeq0
 c41:	520204        	ae_sp24f.l.i	aep0, a2, 0
 c44:	28c222        	addi	a2, a2, 40

00000c47 <SBC_synthesis4_per_channel+0x8f>:
 c47:	4151f0        	srli	a5, a15, 1
 c4a:	115580        	slli	a5, a5, 8
 c4d:	37e5c4        	ae_truncp24a32x2	aep6, a5, a12
 c50:	ebd88f8a2e 	{ addi	a2, a10, -8; ae_mulfp24s.hl	aeq2, aep6, aep6 }
 c55:	fd0a61        	l32r	a6, 80 (1730 <SBC_proto_coef_4>)
 c58:	35a414        	ae_slliq56	aeq2, aeq2, 16
 c5b:	36a504        	ae_trunca32q48	a5, aeq2
 c5e:	303fe0        	xor	a3, a15, a14
 c61:	043030        	extui	a3, a3, 0, 1
 c64:	a05560        	addx4	a5, a5, a6
 c67:	a03350        	addx4	a3, a3, a5
 c6a:	460c           	movi.n	a6, 4
 c6c:	fcc3a2        	addi	a10, a3, -4
 c6f:	030c           	movi.n	a3, 0
 c71:	55a676        	loopgtz	a6, cca <SBC_synthesis4_per_channel+0x112>
 c74:	50fa14        	ae_lp24f.iu	aep7, a10, 4
 c77:	5ce214        	ae_lp24x2f.iu	aep6, a2, 8
 c7a:	5cc214        	ae_lp24x2f.iu	aep4, a2, 8
 c7d:	509a14        	ae_lp24f.iu	aep1, a10, 4
 c80:	fe0c6eda1f 	{ ae_lp24f.iu	aep5, a10, 4; ae_movq56	aeq2, aeq1 }
 c85:	df3dee8a1f 	{ ae_lp24f.iu	aep0, a10, 4; ae_selp24.lh	aep7, aep7, aep1 }
 c8a:	e3f82e9a1f 	{ ae_lp24f.iu	aep1, a10, 4; ae_mulaafp24s.hh.ll	aeq2, aep6, aep7 }

00000c8f <SBC_synthesis4_per_channel+0xd7>:
 c8f:	de15ef821f 	{ ae_lp24x2f.iu	aep0, a2, 8; ae_selp24.lh	aep5, aep5, aep0 }
 c94:	e3b02fd21f 	{ ae_lp24x2f.iu	aep5, a2, 8; ae_mulaafp24s.hh.ll	aeq2, aep4, aep5 }
 c99:	50aa14        	ae_lp24f.iu	aep2, a10, 4
 c9c:	dc45eeea1f 	{ ae_lp24f.iu	aep6, a10, 4; ae_selp24.lh	aep1, aep1, aep2 }
 ca1:	e3202f921f 	{ ae_lp24x2f.iu	aep1, a2, 8; ae_mulaafp24s.hh.ll	aeq2, aep0, aep1 }
 ca6:	50fa14        	ae_lp24f.iu	aep7, a10, 4
 ca9:	50aa14        	ae_lp24f.iu	aep2, a10, 4
 cac:	dff9aeca1f 	{ ae_lp24f.iu	aep4, a10, 4; ae_selp24.lh	aep6, aep6, aep7 }
 cb1:	e3d43e24af 	{ ae_selp24.lh	aep2, aep2, aep4; ae_mulaafp24s.hh.ll	aeq2, aep5, aep6 }
 cb6:	059204        	ae_mulaafp24s.hh.ll	aeq2, aep1, aep2
 cb9:	062834        	ae_roundsq32sym	aeq0, aeq2
 cbc:	033314        	ae_mulq32sp16s.l	aeq0, aeq0, aep3
 cbf:	36c094        	ae_sllisq56s	aeq3, aeq0, 2
 cc2:	fbfbee8a1f 	{ ae_lp24f.iu	aep0, a10, 4; ae_roundsp16q48sym	aep7, aeq3 }
 cc7:	42f714        	ae_sp16f.l.iu	aep7, a7, 2

00000cca <SBC_synthesis4_per_channel+0x112>:
 cca:	1a14a2        	l16ui	a10, a4, 52
 ccd:	031462        	l16ui	a6, a4, 6
 cd0:	bb1b           	addi.n	a11, a11, 1
 cd2:	a09a90        	addx4	a9, a10, a9
 cd5:	02ab67        	bge	a11, a6, cdb <SBC_synthesis4_per_channel+0x123>
 cd8:	ffc546        	j	bf1 <SBC_synthesis4_per_channel+0x39>

00000cdb <SBC_synthesis4_per_channel+0x123>:
 cdb:	f01d           	retw.n

00000cdd <SBC_synthesis4_per_channel+0x125>:
 cdd:	000000                                        ...

00000ce0 <SBC_synthesis8_per_channel>:
 ce0:	006136        	entry	a1, 48
 ce3:	fec372        	addi	a7, a3, -2
 ce6:	0bd4e2        	addmi	a14, a4, 0xb00
 ce9:	0f0c           	movi.n	a15, 0
 ceb:	890c           	movi.n	a9, 8
 ced:	882c           	movi.n	a8, 40
 cef:	58c4c2        	addi	a12, a4, 88
 cf2:	78c4a2        	addi	a10, a4, 120
 cf5:	fce351        	l32r	a5, 84 (1530 <SBC_cos_coef_8+0x100>)
 cf8:	fcded1        	l32r	a13, 70 (5a00 <_end+0x36c0>)
 cfb:	305dd4        	ae_cvtp24a16x2.ll	aep5, a13, a13
 cfe:	0159           	s32i.n	a5, a1, 0
 d00:	83ac20        	moveqz	a10, a12, a2
 d03:	0314c2        	l16ui	a12, a4, 6
 d06:	0a6d           	mov.n	a6, a10
 d08:	20ca22        	addi	a2, a10, 32

00000d0b <SBC_synthesis8_per_channel+0x2b>:
 d0b:	f3f6a0        	wur.ae_cbegin0	a10
 d0e:	521ed2        	l16ui	a13, a14, 164
 d11:	f3f720        	wur.ae_cend0	a2
 d14:	282eb2        	l32i	a11, a14, 160
 d17:	f7cd52        	addi	a5, a13, -9
 d1a:	dd1b           	addi.n	a13, a13, 1
 d1c:	83df50        	moveqz	a13, a15, a5
 d1f:	525ed2        	s16i	a13, a14, 164
 d22:	051c           	movi.n	a5, 16
 d24:	a02db0        	addx4	a2, a13, a11
 d27:	d8c222        	addi	a2, a2, -40
 d2a:	0a6d07        	bbci	a13, 0, d38 <SBC_synthesis8_per_channel+0x58>
 d2d:	0138           	l32i.n	a3, a1, 0
 d2f:	01dbb2        	addmi	a11, a11, 0x100
 d32:	40cbb2        	addi	a11, a11, 64
 d35:	000086        	j	d3b <SBC_synthesis8_per_channel+0x5b>

00000d38 <SBC_synthesis8_per_channel+0x58>:
 d38:	fcd431        	l32r	a3, 88 (1430 <SBC_cos_coef_8>)

00000d3b <SBC_synthesis8_per_channel+0x5b>:
 d3b:	f8c332        	addi	a3, a3, -8
 d3e:	2ca576        	loopgtz	a5, d6e <SBC_synthesis8_per_channel+0x8e>
 d41:	fc24dd869f 	{ ae_lp24x2f.c	aep0, a6, a9; nop }
 d46:	5c9314        	ae_lp24x2f.iu	aep1, a3, 8
 d49:	5cf314        	ae_lp24x2f.iu	aep7, a3, 8
 d4c:	fc24dde69f 	{ ae_lp24x2f.c	aep6, a6, a9; nop }
 d51:	fc24ddb69f 	{ ae_lp24x2f.c	aep3, a6, a9; nop }
 d56:	f022afc31f 	{ ae_lp24x2f.iu	aep4, a3, 8; ae_mulzaafp24s.hh.ll	aeq0, aep0, aep1 }
 d5b:	e2f82fa31f 	{ ae_lp24x2f.iu	aep2, a3, 8; ae_mulaafp24s.hh.ll	aeq0, aep6, aep7 }
 d60:	e28c1d969f 	{ ae_lp24x2f.c	aep1, a6, a9; ae_mulaafp24s.hh.ll	aeq0, aep3, aep4 }
 d65:	051204        	ae_mulaafp24s.hh.ll	aeq0, aep1, aep2
 d68:	1b8c04        	ae_roundsp24q48sym	aep0, aeq0
 d6b:	538284        	ae_sp24f.l.xu	aep0, a2, a8

00000d6e <SBC_synthesis8_per_channel+0x8e>:
 d6e:	60a132        	movi	a3, 0x160
 d71:	2121d0        	srai	a2, a13, 1
 d74:	160c           	movi.n	a6, 1
 d76:	822230        	mull	a2, a2, a3
 d79:	fcc431        	l32r	a3, 8c (1aa0 <SBC_proto_coef_8>)
 d7c:	305d60        	xor	a5, a13, a6
 d7f:	045050        	extui	a5, a5, 0, 1
 d82:	802320        	add	a2, a3, a2
 d85:	a05520        	addx4	a5, a5, a2
 d88:	f8cb22        	addi	a2, a11, -8
 d8b:	fcc5b2        	addi	a11, a5, -4
 d8e:	08a052        	movi	a5, 8
 d91:	53a576        	loopgtz	a5, de8 <SBC_synthesis8_per_channel+0x108>
 d94:	5ca214        	ae_lp24x2f.iu	aep2, a2, 8
 d97:	50cb14        	ae_lp24f.iu	aep4, a11, 4
 d9a:	50eb14        	ae_lp24f.iu	aep6, a11, 4
 d9d:	5cf214        	ae_lp24x2f.iu	aep7, a2, 8
 da0:	5cb214        	ae_lp24x2f.iu	aep3, a2, 8
 da3:	ded1ae8b1f 	{ ae_lp24f.iu	aep0, a11, 4; ae_selp24.lh	aep4, aep4, aep6 }
 da8:	f18aee9b1f 	{ ae_lp24f.iu	aep1, a11, 4; ae_mulzaafp24s.hh.ll	aeq3, aep2, aep4 }
 dad:	dc21aecb1f 	{ ae_lp24f.iu	aep4, a11, 4; ae_selp24.lh	aep0, aep0, aep1 }

00000db2 <SBC_synthesis8_per_channel+0xd2>:
 db2:	e31c6f821f 	{ ae_lp24x2f.iu	aep0, a2, 8; ae_mulaafp24s.hh.ll	aeq3, aep7, aep0 }
 db7:	50eb14        	ae_lp24f.iu	aep6, a11, 4
 dba:	ded1ae9b1f 	{ ae_lp24f.iu	aep1, a11, 4; ae_selp24.lh	aep4, aep4, aep6 }
 dbf:	e38c6fc21f 	{ ae_lp24x2f.iu	aep4, a2, 8; ae_mulaafp24s.hh.ll	aeq3, aep3, aep4 }
 dc4:	50ab14        	ae_lp24f.iu	aep2, a11, 4
 dc7:	50eb14        	ae_lp24f.iu	aep6, a11, 4
 dca:	dc45eefb1f 	{ ae_lp24f.iu	aep7, a11, 4; ae_selp24.lh	aep1, aep1, aep2 }
 dcf:	e3207e6faf 	{ ae_selp24.lh	aep6, aep6, aep7; ae_mulaafp24s.hh.ll	aeq3, aep0, aep1 }
 dd4:	05ce04        	ae_mulaafp24s.hh.ll	aeq3, aep4, aep6
 dd7:	06b834        	ae_roundsq32sym	aeq2, aeq3
 dda:	03d394        	ae_mulq32sp16s.l	aeq2, aeq2, aep5
 ddd:	366094        	ae_sllisq56s	aeq1, aeq2, 2
 de0:	f9ebaebb1f 	{ ae_lp24f.iu	aep3, a11, 4; ae_roundsp16q48sym	aep2, aeq1 }
 de5:	42a714        	ae_sp16f.l.iu	aep2, a7, 2

00000de8 <SBC_synthesis8_per_channel+0x108>:
 de8:	1a1452        	l16ui	a5, a4, 52
 deb:	cc0b           	addi.n	a12, a12, -1
 ded:	a0a5a0        	addx4	a10, a5, a10
 df0:	0a6d           	mov.n	a6, a10
 df2:	20ca22        	addi	a2, a10, 32
 df5:	021ca6        	blti	a12, 1, dfb <SBC_synthesis8_per_channel+0x11b>
 df8:	ffc3c6        	j	d0b <SBC_synthesis8_per_channel+0x2b>
 dfb:	f01d           	retw.n

00000dfd <SBC_synthesis8_per_channel+0x11d>:
 dfd:	000000                                        ...

00000e00 <_start>:
 e00:	004136        	entry	a1, 32
 e03:	fca4a1        	l32r	a10, 94 (2280 <SBC_crc_table+0x100>)
 e06:	fca231        	l32r	a3, 90 (233c <printf_ptr>)
 e09:	0288           	l32i.n	a8, a2, 0
 e0b:	fca3b1        	l32r	a11, 98 (158 <sbc_init>)
 e0e:	0389           	s32i.n	a8, a3, 0
 e10:	0008e0        	callx8	a8
 e13:	0388           	l32i.n	a8, a3, 0
 e15:	fca1a1        	l32r	a10, 9c (2290 <SBC_crc_table+0x110>)
 e18:	fca2b1        	l32r	a11, a0 (284 <sbc_frame_header_decode>)
 e1b:	0008e0        	callx8	a8
 e1e:	0388           	l32i.n	a8, a3, 0
 e20:	fca1a1        	l32r	a10, a4 (22b0 <SBC_crc_table+0x130>)
 e23:	fca1b1        	l32r	a11, a8 (3b4 <sbc_frame_decode>)
 e26:	0008e0        	callx8	a8
 e29:	0388           	l32i.n	a8, a3, 0
 e2b:	fca0a1        	l32r	a10, ac (22c8 <SBC_crc_table+0x148>)
 e2e:	fca0b1        	l32r	a11, b0 (138 <get_SBC_version>)
 e31:	0008e0        	callx8	a8
 e34:	fca021        	l32r	a2, b4 (2310 <export_parameter_array>)
 e37:	f01d           	retw.n

00000e39 <_start+0x39>:
 e39:	00000000 36000000                                .......

00000e40 <__do_global_ctors_aux>:
 e40:	004136        	entry	a1, 32
 e43:	fc9d81        	l32r	a8, b8 (20f4 <SBC_proto_coef_8+0x654>)
 e46:	7f2882        	l32i	a8, a8, 0x1fc
 e49:	fc9c21        	l32r	a2, bc (22f0 <__CTOR_LIST___47>)
 e4c:	0c0826        	beqi	a8, -1, e5c <__do_global_ctors_aux+0x1c>
 e4f:	02a8           	l32i.n	a10, a2, 0

00000e51 <__do_global_ctors_aux+0x11>:
 e51:	000ae0        	callx8	a10
 e54:	fcc222        	addi	a2, a2, -4
 e57:	02a8           	l32i.n	a10, a2, 0
 e59:	f40a66        	bnei	a10, -1, e51 <__do_global_ctors_aux+0x11>

00000e5c <__do_global_ctors_aux+0x1c>:
 e5c:	f01d           	retw.n

00000e5e <__do_global_ctors_aux+0x1e>:
	...

00000e60 <_fini>:
 e60:	008136        	entry	a1, 64
 e63:	fc9781        	l32r	a8, c0 (e0 <__do_global_dtors_aux>)
 e66:	f03d           	nop.n
 e68:	0008e0        	callx8	a8

00000e6b <_fini+0xb>:
 e6b:	f01d           	retw.n
