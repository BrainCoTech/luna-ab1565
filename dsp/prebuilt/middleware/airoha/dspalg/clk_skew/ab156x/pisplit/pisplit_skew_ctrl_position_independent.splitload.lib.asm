
Build/lib/pisplit_skew_ctrl_position_independent.splitload.lib:     file format elf32-xtensa-le


Disassembly of section .text:

00000000 <_init-0x7c>:
       0:	000000c8 00000ea4 0000141c 00000000     ................
      10:	000013ec 00000000 00001404 000014ac     ................
      20:	00001440 00000120 0000145b 00000128     @... ...[...(...
      30:	00001470 00000150 00001494 000007f0     p...P...........
      40:	00001430 21081301 00000ec8 00000f08     0......!........
      50:	00000e08 00000590 002aaaaa 000ccd00     ..........*.....
      60:	55555555 00000c6c 000003d4 0000066c     UUUUl.......l...
      70:	2aaaaaaa 000013f4 00000094              ...*........

0000007c <_init>:
      7c:	008136        	entry	a1, 64
      7f:	ffe081        	l32r	a8, 0 (c8 <frame_dummy>)
      82:	f03d           	nop.n
      84:	0008e0        	callx8	a8
      87:	ffdf81        	l32r	a8, 4 (ea4 <__do_global_ctors_aux>)
      8a:	f03d           	nop.n
      8c:	0008e0        	callx8	a8
      8f:	f01d           	retw.n

00000091 <_init+0x15>:
      91:	000000                                        ...

00000094 <__do_global_dtors_aux>:
      94:	004136        	entry	a1, 32
      97:	ffdc21        	l32r	a2, 8 (141c <__do_global_dtors_aux.completed>)
      9a:	000232        	l8ui	a3, a2, 0
      9d:	23ec           	bnez.n	a3, c3 <__do_global_dtors_aux+0x2f>

0000009f <__do_global_dtors_aux+0xb>:
      9f:	1248           	l32i.n	a4, a2, 4
      a1:	0438           	l32i.n	a3, a4, 0
      a3:	444b           	addi.n	a4, a4, 4
      a5:	738c           	beqz.n	a3, b0 <__do_global_dtors_aux+0x1c>
      a7:	1249           	s32i.n	a4, a2, 4
      a9:	0003e0        	callx8	a3
      ac:	fffbc6        	j	9f <__do_global_dtors_aux+0xb>

000000af <__do_global_dtors_aux+0x1b>:
	...

000000b0 <__do_global_dtors_aux+0x1c>:
      b0:	ffd731        	l32r	a3, c (0 <_text_start>)
      b3:	ffd7a1        	l32r	a10, 10 (13ec <__FRAME_END__>)
      b6:	438c           	beqz.n	a3, be <__do_global_dtors_aux+0x2a>
      b8:	ffd581        	l32r	a8, c (0 <_text_start>)
      bb:	0008e0        	callx8	a8
      be:	130c           	movi.n	a3, 1
      c0:	004232        	s8i	a3, a2, 0
      c3:	f01d           	retw.n

000000c5 <__do_global_dtors_aux+0x31>:
      c5:	000000                                        ...

000000c8 <frame_dummy>:
      c8:	004136        	entry	a1, 32
      cb:	ffd221        	l32r	a2, 14 (0 <_text_start>)
      ce:	ffd0a1        	l32r	a10, 10 (13ec <__FRAME_END__>)
      d1:	ffd1b1        	l32r	a11, 18 (1404 <frame_dummy.object>)
      d4:	428c           	beqz.n	a2, dc <frame_dummy+0x14>
      d6:	ffcf81        	l32r	a8, 14 (0 <_text_start>)
      d9:	0008e0        	callx8	a8

000000dc <frame_dummy+0x14>:
      dc:	f01d           	retw.n

000000de <frame_dummy+0x16>:
	...

000000e0 <_start>:
      e0:	004136        	entry	a1, 32
      e3:	ffce31        	l32r	a3, 1c (14ac <printf_ptr>)
      e6:	0228           	l32i.n	a2, a2, 0
      e8:	ffcea1        	l32r	a10, 20 (1440 <export_parameter_array+0x10>)
      eb:	ffceb1        	l32r	a11, 24 (120 <get_skewctrl_version>)
      ee:	006322        	s32i	a2, a3, 0
      f1:	0002e0        	callx8	a2
      f4:	002322        	l32i	a2, a3, 0
      f7:	ffcca1        	l32r	a10, 28 (145b <export_parameter_array+0x2b>)
      fa:	ffccb1        	l32r	a11, 2c (128 <skew_ctrl_init>)
      fd:	0002e0        	callx8	a2
     100:	002322        	l32i	a2, a3, 0
     103:	ffcba1        	l32r	a10, 30 (1470 <export_parameter_array+0x40>)
     106:	ffcbb1        	l32r	a11, 34 (150 <skew_ctrl_set_input_framesize>)
     109:	0002e0        	callx8	a2
     10c:	002322        	l32i	a2, a3, 0
     10f:	ffcaa1        	l32r	a10, 38 (1494 <export_parameter_array+0x64>)
     112:	ffcab1        	l32r	a11, 3c (7f0 <skew_ctrl_process>)
     115:	0002e0        	callx8	a2
     118:	ffca21        	l32r	a2, 40 (1430 <export_parameter_array>)
     11b:	f01d           	retw.n

0000011d <_start+0x3d>:
     11d:	000000                                        ...

00000120 <get_skewctrl_version>:
     120:	004136        	entry	a1, 32
     123:	ffc821        	l32r	a2, 44 (21081301 <_end+0x2107fe51>)
     126:	f01d           	retw.n

00000128 <skew_ctrl_init>:
     128:	004136        	entry	a1, 32
     12b:	1f0c           	movi.n	a15, 1
     12d:	060c           	movi.n	a6, 0
     12f:	623d           	ae_s16i.n	a3, a2, 0
     131:	055252        	s16i	a5, a2, 10
     134:	045262        	s16i	a6, a2, 8
     137:	075242        	s16i	a4, a2, 14
     13a:	0652f2        	s16i	a15, a2, 12
     13d:	12f9           	s32i.n	a15, a2, 4
     13f:	40c2a2        	addi	a10, a2, 64
     142:	ffc121        	l32r	a2, 48 (ec8 <memset>)
     145:	0b0c           	movi.n	a11, 0
     147:	6c5c           	movi.n	a12, 86
     149:	0002e0        	callx8	a2
     14c:	f01d           	retw.n

0000014e <skew_ctrl_init+0x26>:
	...

00000150 <skew_ctrl_set_input_framesize>:
     150:	008136        	entry	a1, 64
     153:	524d           	ae_l16ui.n	a4, a2, 2
     155:	425d           	ae_l16ui.n	a5, a2, 0
     157:	160c           	movi.n	a6, 1
     159:	029437        	bne	a4, a3, 15f <skew_ctrl_set_input_framesize+0xf>
     15c:	007c06        	j	350 <skew_ctrl_set_input_framesize+0x200>
     15f:	0212d2        	l16ui	a13, a2, 4
     162:	e0c542        	addi	a4, a5, -32
     165:	624460        	saltu	a4, a4, a6
     168:	400400        	ssr	a4
     16b:	0712e2        	l16ui	a14, a2, 14
     16e:	41f130        	srli	a15, a3, 1
     171:	723d           	ae_s16i.n	a3, a2, 2
     173:	050c           	movi.n	a5, 0
     175:	9130f0        	srl	a3, a15
     178:	4259           	s32i.n	a5, a2, 16
     17a:	c153d0        	mul16u	a5, a3, a13
     17d:	02be26        	beqi	a14, 16, 183 <skew_ctrl_set_input_framesize+0x33>
     180:	003646        	j	25d <skew_ctrl_set_input_framesize+0x10d>
     183:	350b           	addi.n	a3, a5, -1
     185:	ffb161        	l32r	a6, 4c (f08 <__udivdi3>)
     188:	01a320        	slli	a10, a3, 30
     18b:	41b230        	srli	a11, a3, 2
     18e:	0d0c           	movi.n	a13, 0
     190:	05cd           	mov.n	a12, a5
     192:	0006e0        	callx8	a6
     195:	351b           	addi.n	a3, a5, 1
     197:	0a4d           	mov.n	a4, a10
     199:	01a320        	slli	a10, a3, 30
     19c:	41b230        	srli	a11, a3, 2
     19f:	0d0c           	movi.n	a13, 0
     1a1:	05cd           	mov.n	a12, a5
     1a3:	7149           	s32i.n	a4, a1, 28
     1a5:	6249           	s32i.n	a4, a2, 24
     1a7:	0006e0        	callx8	a6
     1aa:	f47c           	movi.n	a4, -1
     1ac:	1135d0        	slli	a3, a5, 3
     1af:	b04540        	addx8	a4, a5, a4
     1b2:	ff7c           	movi.n	a15, -1
     1b4:	61a9           	s32i.n	a10, a1, 24
     1b6:	b2a9           	s32i.n	a10, a2, 44
     1b8:	41b240        	srli	a11, a4, 2
     1bb:	01af20        	slli	a10, a15, 30
     1be:	0d0c           	movi.n	a13, 0
     1c0:	03cd           	mov.n	a12, a3
     1c2:	0006e0        	callx8	a6
     1c5:	170c           	movi.n	a7, 1
     1c7:	017720        	slli	a7, a7, 30
     1ca:	41b230        	srli	a11, a3, 2
     1cd:	51a9           	s32i.n	a10, a1, 20
     1cf:	72a9           	s32i.n	a10, a2, 28
     1d1:	0d0c           	movi.n	a13, 0
     1d3:	20c330        	or	a12, a3, a3
     1d6:	20a770        	or	a10, a7, a7
     1d9:	0006e0        	callx8	a6
     1dc:	1145a0        	slli	a4, a5, 6
     1df:	340b           	addi.n	a3, a4, -1
     1e1:	ff7c           	movi.n	a15, -1
     1e3:	41b230        	srli	a11, a3, 2
     1e6:	013f20        	slli	a3, a15, 30
     1e9:	41a9           	s32i.n	a10, a1, 16
     1eb:	0c62a2        	s32i	a10, a2, 48
     1ee:	00a0d2        	movi	a13, 0
     1f1:	03ad           	mov.n	a10, a3
     1f3:	04cd           	mov.n	a12, a4
     1f5:	0006e0        	callx8	a6
     1f8:	41b240        	srli	a11, a4, 2
     1fb:	31a9           	s32i.n	a10, a1, 12
     1fd:	82a9           	s32i.n	a10, a2, 32
     1ff:	0d0c           	movi.n	a13, 0
     201:	07ad           	mov.n	a10, a7
     203:	04cd           	mov.n	a12, a4
     205:	0006e0        	callx8	a6
     208:	117580        	slli	a7, a5, 8
     20b:	670b           	addi.n	a6, a7, -1
     20d:	0a4d           	mov.n	a4, a10
     20f:	d2a9           	s32i.n	a10, a2, 52
     211:	03ad           	mov.n	a10, a3
     213:	ff8e31        	l32r	a3, 4c (f08 <__udivdi3>)
     216:	41b260        	srli	a11, a6, 2
     219:	0d0c           	movi.n	a13, 0
     21b:	07cd           	mov.n	a12, a7
     21d:	0003e0        	callx8	a3
     220:	1f0c           	movi.n	a15, 1
     222:	ff8a31        	l32r	a3, 4c (f08 <__udivdi3>)
     225:	21a9           	s32i.n	a10, a1, 8
     227:	41b270        	srli	a11, a7, 2
     22a:	0d0c           	movi.n	a13, 0
     22c:	01af20        	slli	a10, a15, 30
     22f:	07cd           	mov.n	a12, a7
     231:	0003e0        	callx8	a3
     234:	116570        	slli	a6, a5, 9
     237:	560b           	addi.n	a5, a6, -1
     239:	ff7c           	movi.n	a15, -1
     23b:	0a7d           	mov.n	a7, a10
     23d:	41b250        	srli	a11, a5, 2
     240:	0d0c           	movi.n	a13, 0
     242:	01af20        	slli	a10, a15, 30
     245:	06cd           	mov.n	a12, a6
     247:	0003e0        	callx8	a3
     24a:	1f0c           	movi.n	a15, 1
     24c:	0a5d           	mov.n	a5, a10
     24e:	41b260        	srli	a11, a6, 2
     251:	0d0c           	movi.n	a13, 0
     253:	01af20        	slli	a10, a15, 30
     256:	06cd           	mov.n	a12, a6
     258:	002f46        	j	319 <skew_ctrl_set_input_framesize+0x1c9>

0000025b <skew_ctrl_set_input_framesize+0x10b>:
	...

0000025d <skew_ctrl_set_input_framesize+0x10d>:
     25d:	013520        	slli	a3, a5, 30
     260:	414250        	srli	a4, a5, 2
     263:	ff7a71        	l32r	a7, 4c (f08 <__udivdi3>)
     266:	c51b           	addi.n	a12, a5, 1
     268:	0d0c           	movi.n	a13, 0
     26a:	03ad           	mov.n	a10, a3
     26c:	04bd           	mov.n	a11, a4
     26e:	0007e0        	callx8	a7
     271:	c50b           	addi.n	a12, a5, -1
     273:	71a9           	s32i.n	a10, a1, 28
     275:	62a9           	s32i.n	a10, a2, 24
     277:	0d0c           	movi.n	a13, 0
     279:	03ad           	mov.n	a10, a3
     27b:	04bd           	mov.n	a11, a4
     27d:	0007e0        	callx8	a7
     280:	1135d0        	slli	a3, a5, 3
     283:	413230        	srli	a3, a3, 2
     286:	b0c560        	addx8	a12, a5, a6
     289:	61a9           	s32i.n	a10, a1, 24
     28b:	b2a9           	s32i.n	a10, a2, 44
     28d:	0a0c           	movi.n	a10, 0
     28f:	0d0c           	movi.n	a13, 0
     291:	03bd           	mov.n	a11, a3
     293:	0007e0        	callx8	a7
     296:	f47c           	movi.n	a4, -1
     298:	b0c540        	addx8	a12, a5, a4
     29b:	51a9           	s32i.n	a10, a1, 20
     29d:	72a9           	s32i.n	a10, a2, 28
     29f:	0a0c           	movi.n	a10, 0
     2a1:	0d0c           	movi.n	a13, 0
     2a3:	20b330        	or	a11, a3, a3
     2a6:	0007e0        	callx8	a7
     2a9:	1165a0        	slli	a6, a5, 6
     2ac:	414260        	srli	a4, a6, 2
     2af:	c61b           	addi.n	a12, a6, 1
     2b1:	41a9           	s32i.n	a10, a1, 16
     2b3:	c2a9           	s32i.n	a10, a2, 48
     2b5:	0a0c           	movi.n	a10, 0
     2b7:	0d0c           	movi.n	a13, 0
     2b9:	04bd           	mov.n	a11, a4
     2bb:	0007e0        	callx8	a7
     2be:	c60b           	addi.n	a12, a6, -1
     2c0:	31a9           	s32i.n	a10, a1, 12
     2c2:	82a9           	s32i.n	a10, a2, 32
     2c4:	0a0c           	movi.n	a10, 0
     2c6:	0d0c           	movi.n	a13, 0
     2c8:	20b440        	or	a11, a4, a4
     2cb:	0007e0        	callx8	a7
     2ce:	073d           	mov.n	a3, a7
     2d0:	117580        	slli	a7, a5, 8
     2d3:	416270        	srli	a6, a7, 2
     2d6:	0a4d           	mov.n	a4, a10
     2d8:	d2a9           	s32i.n	a10, a2, 52
     2da:	c71b           	addi.n	a12, a7, 1
     2dc:	0a0c           	movi.n	a10, 0
     2de:	0d0c           	movi.n	a13, 0
     2e0:	06bd           	mov.n	a11, a6
     2e2:	0003e0        	callx8	a3
     2e5:	21a9           	s32i.n	a10, a1, 8
     2e7:	c70b           	addi.n	a12, a7, -1
     2e9:	00a0a2        	movi	a10, 0
     2ec:	00a0d2        	movi	a13, 0
     2ef:	20b660        	or	a11, a6, a6
     2f2:	0003e0        	callx8	a3
     2f5:	113570        	slli	a3, a5, 9
     2f8:	416230        	srli	a6, a3, 2
     2fb:	ff5451        	l32r	a5, 4c (f08 <__udivdi3>)
     2fe:	0a7d           	mov.n	a7, a10
     300:	c31b           	addi.n	a12, a3, 1
     302:	0a0c           	movi.n	a10, 0
     304:	0d0c           	movi.n	a13, 0
     306:	20b660        	or	a11, a6, a6
     309:	0005e0        	callx8	a5
     30c:	c30b           	addi.n	a12, a3, -1
     30e:	ff4f31        	l32r	a3, 4c (f08 <__udivdi3>)
     311:	0a5d           	mov.n	a5, a10
     313:	0a0c           	movi.n	a10, 0
     315:	0d0c           	movi.n	a13, 0
     317:	06bd           	mov.n	a11, a6
     319:	0003e0        	callx8	a3
     31c:	7138           	l32i.n	a3, a1, 28
     31e:	5168           	l32i.n	a6, a1, 20
     320:	3188           	l32i.n	a8, a1, 12
     322:	2198           	l32i.n	a9, a1, 8
     324:	61b8           	l32i.n	a11, a1, 24
     326:	41c8           	l32i.n	a12, a1, 16
     328:	330b           	addi.n	a3, a3, -1
     32a:	660b           	addi.n	a6, a6, -1
     32c:	880b           	addi.n	a8, a8, -1
     32e:	990b           	addi.n	a9, a9, -1
     330:	550b           	addi.n	a5, a5, -1
     332:	bb0b           	addi.n	a11, a11, -1
     334:	cc0b           	addi.n	a12, a12, -1
     336:	440b           	addi.n	a4, a4, -1
     338:	770b           	addi.n	a7, a7, -1
     33a:	aa0b           	addi.n	a10, a10, -1
     33c:	6239           	s32i.n	a3, a2, 24
     33e:	7269           	s32i.n	a6, a2, 28
     340:	8289           	s32i.n	a8, a2, 32
     342:	9299           	s32i.n	a9, a2, 36
     344:	a259           	s32i.n	a5, a2, 40
     346:	b2b9           	s32i.n	a11, a2, 44
     348:	c2c9           	s32i.n	a12, a2, 48
     34a:	d249           	s32i.n	a4, a2, 52
     34c:	e279           	s32i.n	a7, a2, 56
     34e:	f2a9           	s32i.n	a10, a2, 60
     350:	f01d           	retw.n

00000352 <skew_ctrl_set_input_framesize+0x202>:
	...

00000354 <Get_Src_Len>:
     354:	004136        	entry	a1, 32
     357:	061252        	l16ui	a5, a2, 12
     35a:	49a262        	movi	a6, 0x249
     35d:	1166b0        	slli	a6, a6, 5
     360:	2655a6        	blti	a5, 5, 38a <Get_Src_Len+0x36>
     363:	49b5f6        	bgeui	a5, 16, 3b0 <Get_Src_Len+0x5c>
     366:	1ad657        	bbs	a6, a5, 384 <Get_Src_Len+0x30>
     369:	49a262        	movi	a6, 0x249
     36c:	1166a0        	slli	a6, a6, 6
     36f:	255657        	bbc	a6, a5, 398 <Get_Src_Len+0x44>
     372:	4a9262        	l16si	a6, a2, 148
     375:	620c           	movi.n	a2, 6
     377:	570c           	movi.n	a7, 5
     379:	450c           	movi.n	a5, 4
     37b:	b32760        	movgez	a2, a7, a6
     37e:	b35760        	movgez	a5, a7, a6
     381:	001246        	j	3ce <Get_Src_Len+0x7a>

00000384 <Get_Src_Len+0x30>:
     384:	4a9222        	l16si	a2, a2, 148
     387:	000dc6        	j	3c2 <Get_Src_Len+0x6e>

0000038a <Get_Src_Len+0x36>:
     38a:	122526        	beqi	a5, 2, 3a0 <Get_Src_Len+0x4c>
     38d:	173526        	beqi	a5, 3, 3a8 <Get_Src_Len+0x54>
     390:	860c           	movi.n	a6, 8
     392:	264526        	beqi	a5, 4, 3bc <Get_Src_Len+0x68>
     395:	0005c6        	j	3b0 <Get_Src_Len+0x5c>

00000398 <Get_Src_Len+0x44>:
     398:	147566        	bnei	a5, 7, 3b0 <Get_Src_Len+0x5c>
     39b:	064c           	movi.n	a6, 64
     39d:	0006c6        	j	3bc <Get_Src_Len+0x68>

000003a0 <Get_Src_Len+0x4c>:
     3a0:	520c           	movi.n	a2, 5
     3a2:	550c           	movi.n	a5, 5
     3a4:	000986        	j	3ce <Get_Src_Len+0x7a>

000003a7 <Get_Src_Len+0x53>:
	...

000003a8 <Get_Src_Len+0x54>:
     3a8:	450c           	movi.n	a5, 4
     3aa:	620c           	movi.n	a2, 6
     3ac:	000786        	j	3ce <Get_Src_Len+0x7a>

000003af <Get_Src_Len+0x5b>:
	...

000003b0 <Get_Src_Len+0x5c>:
     3b0:	f6c552        	addi	a5, a5, -10
     3b3:	00a272        	movi	a7, 0x200
     3b6:	00a162        	movi	a6, 0x100
     3b9:	936750        	movnez	a6, a7, a5
     3bc:	4a9222        	l16si	a2, a2, 148
     3bf:	f22260        	rems	a2, a2, a6
     3c2:	050c           	movi.n	a5, 0
     3c4:	725520        	salt	a5, a5, a2
     3c7:	6f0c           	movi.n	a15, 6
     3c9:	c02f50        	sub	a2, a15, a5
     3cc:	554b           	addi.n	a5, a5, 4
     3ce:	632d           	ae_s16i.n	a2, a3, 0
     3d0:	645d           	ae_s16i.n	a5, a4, 0
     3d2:	f01d           	retw.n

000003d4 <skew_ctrl_32b>:
     3d4:	008136        	entry	a1, 64
     3d7:	029d           	mov.n	a9, a2
     3d9:	03f8           	l32i.n	a15, a3, 0
     3db:	037d           	mov.n	a7, a3
     3dd:	1562f2        	s32i	a15, a2, 84
     3e0:	1338           	l32i.n	a3, a3, 4
     3e2:	166232        	s32i	a3, a2, 88
     3e5:	2738           	l32i.n	a3, a7, 8
     3e7:	176232        	s32i	a3, a2, 92
     3ea:	3738           	l32i.n	a3, a7, 12
     3ec:	061222        	l16ui	a2, a2, 12
     3ef:	186932        	s32i	a3, a9, 96
     3f2:	4738           	l32i.n	a3, a7, 16
     3f4:	3169           	s32i.n	a6, a1, 12
     3f6:	6159           	s32i.n	a5, a1, 24
     3f8:	196932        	s32i	a3, a9, 100
     3fb:	2d52a6        	blti	a2, 5, 42c <skew_ctrl_32b+0x58>
     3fe:	52b2f6        	bgeui	a2, 16, 454 <skew_ctrl_32b+0x80>
     401:	49a232        	movi	a3, 0x249
     404:	1133b0        	slli	a3, a3, 5
     407:	1ad327        	bbs	a3, a2, 425 <skew_ctrl_32b+0x51>
     40a:	49a232        	movi	a3, 0x249
     40d:	1133a0        	slli	a3, a3, 6
     410:	285327        	bbc	a3, a2, 43c <skew_ctrl_32b+0x68>
     413:	4a9932        	l16si	a3, a9, 148
     416:	620c           	movi.n	a2, 6
     418:	550c           	movi.n	a5, 5
     41a:	460c           	movi.n	a6, 4
     41c:	b32530        	movgez	a2, a5, a3
     41f:	b36530        	movgez	a6, a5, a3
     422:	001386        	j	474 <skew_ctrl_32b+0xa0>

00000425 <skew_ctrl_32b+0x51>:
     425:	4a9922        	l16si	a2, a9, 148
     428:	000e86        	j	466 <skew_ctrl_32b+0x92>

0000042b <skew_ctrl_32b+0x57>:
	...

0000042c <skew_ctrl_32b+0x58>:
     42c:	142226        	beqi	a2, 2, 444 <skew_ctrl_32b+0x70>
     42f:	193226        	beqi	a2, 3, 44c <skew_ctrl_32b+0x78>
     432:	830c           	movi.n	a3, 8
     434:	284226        	beqi	a2, 4, 460 <skew_ctrl_32b+0x8c>
     437:	000646        	j	454 <skew_ctrl_32b+0x80>

0000043a <skew_ctrl_32b+0x66>:
	...

0000043c <skew_ctrl_32b+0x68>:
     43c:	147266        	bnei	a2, 7, 454 <skew_ctrl_32b+0x80>
     43f:	034c           	movi.n	a3, 64
     441:	0006c6        	j	460 <skew_ctrl_32b+0x8c>

00000444 <skew_ctrl_32b+0x70>:
     444:	520c           	movi.n	a2, 5
     446:	560c           	movi.n	a6, 5
     448:	000a06        	j	474 <skew_ctrl_32b+0xa0>

0000044b <skew_ctrl_32b+0x77>:
	...

0000044c <skew_ctrl_32b+0x78>:
     44c:	460c           	movi.n	a6, 4
     44e:	620c           	movi.n	a2, 6
     450:	000806        	j	474 <skew_ctrl_32b+0xa0>

00000453 <skew_ctrl_32b+0x7f>:
	...

00000454 <skew_ctrl_32b+0x80>:
     454:	f6c222        	addi	a2, a2, -10
     457:	00a252        	movi	a5, 0x200
     45a:	00a132        	movi	a3, 0x100
     45d:	933520        	movnez	a3, a5, a2
     460:	4a9922        	l16si	a2, a9, 148
     463:	f22230        	rems	a2, a2, a3
     466:	030c           	movi.n	a3, 0
     468:	723320        	salt	a3, a3, a2
     46b:	06a0f2        	movi	a15, 6
     46e:	c02f30        	sub	a2, a15, a3
     471:	04c362        	addi	a6, a3, 4
     474:	051932        	l16ui	a3, a9, 10
     477:	a02290        	addx4	a2, a2, a9
     47a:	10c752        	addi	a5, a7, 16
     47d:	40c222        	addi	a2, a2, 64
     480:	5169           	s32i.n	a6, a1, 20
     482:	7179           	s32i.n	a7, a1, 28
     484:	1199           	s32i.n	a9, a1, 4
     486:	2159           	s32i.n	a5, a1, 8
     488:	6d2366        	bnei	a3, 2, 4f9 <skew_ctrl_32b+0x125>
     48b:	59a8           	l32i.n	a10, a9, 20
     48d:	4938           	l32i.n	a3, a9, 16
     48f:	fef1c1        	l32r	a12, 54 (590 <IN_LINE_32b_5ord>)
     492:	ff7c           	movi.n	a15, -1
     494:	050c           	movi.n	a5, 0
     496:	4192f0        	srli	a9, a15, 2
     499:	0461a2        	s32i	a10, a1, 16
     49c:	33aa           	add.n	a3, a3, a10
     49e:	158e30        	extui	a8, a3, 30, 2
     4a1:	a08820        	addx4	a8, a8, a2
     4a4:	103390        	and	a3, a3, a9
     4a7:	932850        	movnez	a2, a8, a5
     4aa:	02ad           	mov.n	a10, a2
     4ac:	03bd           	mov.n	a11, a3
     4ae:	096d           	mov.n	a6, a9
     4b0:	207cc0        	or	a7, a12, a12
     4b3:	000ce0        	callx8	a12
     4b6:	5188           	l32i.n	a8, a1, 20
     4b8:	04a9           	s32i.n	a10, a4, 0
     4ba:	41a8           	l32i.n	a10, a1, 16
     4bc:	551b           	addi.n	a5, a5, 1
     4be:	07cd           	mov.n	a12, a7
     4c0:	069d           	mov.n	a9, a6
     4c2:	444b           	addi.n	a4, a4, 4
     4c4:	d49857        	bne	a8, a5, 49c <skew_ctrl_32b+0xc8>
     4c7:	3128           	l32i.n	a2, a1, 12
     4c9:	2158           	l32i.n	a5, a1, 8
     4cb:	21b827        	bgeu	a8, a2, 4f0 <skew_ctrl_32b+0x11c>
     4ce:	c02280        	sub	a2, a2, a8
     4d1:	33aa           	add.n	a3, a3, a10
     4d3:	158e30        	extui	a8, a3, 30, 2
     4d6:	103390        	and	a3, a3, a9
     4d9:	a05850        	addx4	a5, a8, a5
     4dc:	05ad           	mov.n	a10, a5
     4de:	03bd           	mov.n	a11, a3
     4e0:	0007e0        	callx8	a7
     4e3:	04a9           	s32i.n	a10, a4, 0
     4e5:	41a8           	l32i.n	a10, a1, 16
     4e7:	220b           	addi.n	a2, a2, -1
     4e9:	069d           	mov.n	a9, a6
     4eb:	444b           	addi.n	a4, a4, 4
     4ed:	fe0256        	bnez	a2, 4d1 <skew_ctrl_32b+0xfd>
     4f0:	1198           	l32i.n	a9, a1, 4
     4f2:	4939           	s32i.n	a3, a9, 16
     4f4:	59a9           	s32i.n	a10, a9, 20
     4f6:	001bc6        	j	569 <skew_ctrl_32b+0x195>

000004f9 <skew_ctrl_32b+0x125>:
     4f9:	fed5d1        	l32r	a13, 50 (e08 <intp_filter_32b>)
     4fc:	fa7c           	movi.n	a10, -1
     4fe:	00a062        	movi	a6, 0
     501:	41a2a0        	srli	a10, a10, 2
     504:	5958           	l32i.n	a5, a9, 20
     506:	4988           	l32i.n	a8, a9, 16
     508:	0a3d           	mov.n	a3, a10
     50a:	1c0c           	movi.n	a12, 1
     50c:	585a           	add.n	a5, a8, a5
     50e:	158e50        	extui	a8, a5, 30, 2
     511:	a08820        	addx4	a8, a8, a2
     514:	1055a0        	and	a5, a5, a10
     517:	932860        	movnez	a2, a8, a6
     51a:	11a8           	l32i.n	a10, a1, 4
     51c:	02bd           	mov.n	a11, a2
     51e:	4959           	s32i.n	a5, a9, 16
     520:	0d7d           	mov.n	a7, a13
     522:	000de0        	callx8	a13
     525:	5158           	l32i.n	a5, a1, 20
     527:	1198           	l32i.n	a9, a1, 4
     529:	661b           	addi.n	a6, a6, 1
     52b:	04a9           	s32i.n	a10, a4, 0
     52d:	07dd           	mov.n	a13, a7
     52f:	03ad           	mov.n	a10, a3
     531:	444b           	addi.n	a4, a4, 4
     533:	cd9567        	bne	a5, a6, 504 <skew_ctrl_32b+0x130>
     536:	3128           	l32i.n	a2, a1, 12
     538:	21b8           	l32i.n	a11, a1, 8
     53a:	2bb527        	bgeu	a5, a2, 569 <skew_ctrl_32b+0x195>
     53d:	c02250        	sub	a2, a2, a5
     540:	5958           	l32i.n	a5, a9, 20
     542:	4968           	l32i.n	a6, a9, 16
     544:	1c0c           	movi.n	a12, 1
     546:	565a           	add.n	a5, a6, a5
     548:	156e50        	extui	a6, a5, 30, 2
     54b:	1055a0        	and	a5, a5, a10
     54e:	11a8           	l32i.n	a10, a1, 4
     550:	a0b6b0        	addx4	a11, a6, a11
     553:	4959           	s32i.n	a5, a9, 16
     555:	0b5d           	mov.n	a5, a11
     557:	0007e0        	callx8	a7
     55a:	1198           	l32i.n	a9, a1, 4
     55c:	220b           	addi.n	a2, a2, -1
     55e:	04a9           	s32i.n	a10, a4, 0
     560:	05bd           	mov.n	a11, a5
     562:	03ad           	mov.n	a10, a3
     564:	444b           	addi.n	a4, a4, 4
     566:	fd6256        	bnez	a2, 540 <skew_ctrl_32b+0x16c>
     569:	7128           	l32i.n	a2, a1, 28
     56b:	6138           	l32i.n	a3, a1, 24
     56d:	a02320        	addx4	a2, a3, a2
     570:	ecc222        	addi	a2, a2, -20
     573:	02f8           	l32i.n	a15, a2, 0
     575:	1069f2        	s32i	a15, a9, 64
     578:	1238           	l32i.n	a3, a2, 4
     57a:	116932        	s32i	a3, a9, 68
     57d:	2238           	l32i.n	a3, a2, 8
     57f:	126932        	s32i	a3, a9, 72
     582:	3238           	l32i.n	a3, a2, 12
     584:	136932        	s32i	a3, a9, 76
     587:	4228           	l32i.n	a2, a2, 16
     589:	146922        	s32i	a2, a9, 80
     58c:	f01d           	retw.n

0000058e <skew_ctrl_32b+0x1ba>:
	...

00000590 <IN_LINE_32b_5ord>:
     590:	008136        	entry	a1, 64
     593:	140c           	movi.n	a4, 1
     595:	0144a0        	slli	a4, a4, 22
     598:	feb051        	l32r	a5, 58 (2aaaaa <_end+0x2a95fa>)
     59b:	1b0c           	movi.n	a11, 1
     59d:	399544        	ae_movpa24x2	aep1, a5, a4
     5a0:	014b20        	slli	a4, a11, 30
     5a3:	7139           	s32i.n	a3, a1, 28
     5a5:	500174        	ae_lp24f.i	aep0, a1, 28
     5a8:	c800bec43f 	{ ae_cvtq48a32s	aeq0, a4; ae_sllip24	aep0, aep0, 1 }
     5ad:	e223ba805f 	{ ae_slliq56	aeq1, aeq0, 1; ae_mulafp24s.ll	aeq0, aep0, aep1 }
     5b2:	ec21ff11bf 	{ ae_movq56	aeq2, aeq1; ae_mulsfp24s.lh	aeq1, aep0, aep1 }
     5b7:	feaae1        	l32r	a14, 60 (55555555 <_end+0x555540a5>)
     5ba:	f9effece7f 	{ ae_cvtq48a32s	aeq1, a14; ae_roundsp24q48sym	aep3, aeq1 }
     5bf:	e222c005df 	{ movi	a13, 5; ae_mulafp24s.lh	aeq1, aep0, aep1 }
     5c4:	ff0c0ffcff 	{ movi	a15, -4; ae_cvtq48p24s.l	aeq3, aep0 }
     5c9:	fbb6c0422e 	{ addi	a2, a2, 4; ae_subq56	aeq3, aeq2, aeq3 }
     5ce:	0181b4        	ae_mulsfp24s.ll	aeq2, aep0, aep1
     5d1:	1b8c14        	ae_roundsp24q48sym	aep1, aeq0
     5d4:	1b9c24        	ae_roundsp24q48sym	aep2, aeq1
     5d7:	011274        	ae_mulfp24s.ll	aeq0, aep1, aep2
     5da:	1bac54        	ae_roundsp24q48sym	aep5, aeq2
     5dd:	faffba012f 	{ ae_sq56s.i	aeq0, a1, 16; ae_roundsp24q48sym	aep4, aeq3 }
     5e2:	01bd74        	ae_mulfp24s.ll	aeq3, aep3, aep5
     5e5:	080524        	ae_mulfq32sp24s.l	aeq0, aeq0, aep0
     5e8:	1bbc74        	ae_roundsp24q48sym	aep7, aeq3
     5eb:	1b8c64        	ae_roundsp24q48sym	aep6, aeq0
     5ee:	01fe74        	ae_mulfp24s.ll	aeq3, aep7, aep6
     5f1:	01d474        	ae_mulfp24s.ll	aeq2, aep5, aep4
     5f4:	ea9dfab01f 	{ ae_slliq56	aeq0, aeq3, 1; ae_mulfp24s.ll	aeq1, aep7, aep4 }
     5f9:	01f8c4        	ae_addq56	aeq3, aeq3, aeq0
     5fc:	fe98c1        	l32r	a12, 5c (ccd00 <_end+0xcb850>)
     5ff:	014db0        	slli	a4, a13, 21
     602:	ea8da234cf 	{ ae_movpa24x2	aep3, a4, a12; ae_mulfp24s.ll	aeq0, aep3, aep4 }
     607:	08e5a4        	ae_mulfq32sp24s.l	aeq2, aeq2, aep6
     60a:	1b9c54        	ae_roundsp24q48sym	aep5, aeq1
     60d:	086d24        	ae_mulfq32sp24s.l	aeq1, aeq0, aep6
     610:	08b5a4        	ae_mulfq32sp24s.l	aeq2, aeq2, aep3
     613:	083464        	ae_mulfq32sp24s.h	aeq0, aeq1, aep3
     616:	fbf7fc42ff 	{ ae_lq32f.xu	aeq2, a2, a15; ae_roundsp24q48sym	aep7, aeq2 }
     61b:	fa9c7dc12f 	{ ae_lq56.i	aeq2, a1, 16; ae_mulfq32sp24s.l	aeq1, aeq2, aep7 }
     620:	fbe7bc02ff 	{ ae_lq32f.xu	aeq0, a2, a15; ae_roundsp24q48sym	aep6, aeq0 }
     625:	08d5a4        	ae_mulfq32sp24s.l	aeq2, aeq2, aep5
     628:	f4dafc02ff 	{ ae_lq32f.xu	aeq0, a2, a15; ae_mulafq32sp24s.l	aeq1, aeq0, aep6 }
     62d:	1bbc74        	ae_roundsp24q48sym	aep7, aeq3
     630:	018a74        	ae_mulfp24s.ll	aeq3, aep0, aep2
     633:	f4defaa01f 	{ ae_slliq56	aeq0, aeq2, 1; ae_mulafq32sp24s.l	aeq1, aeq0, aep7 }
     638:	0128c4        	ae_addq56	aeq0, aeq2, aeq0
     63b:	018174        	ae_mulfp24s.ll	aeq2, aep0, aep1
     63e:	08dde4        	ae_mulfq32sp24s.l	aeq3, aeq3, aep5
     641:	08d5a4        	ae_mulfq32sp24s.l	aeq2, aeq2, aep5
     644:	08bce4        	ae_mulfq32sp24s.h	aeq3, aeq3, aep3
     647:	08b5a4        	ae_mulfq32sp24s.l	aeq2, aeq2, aep3
     64a:	fae7fc02ff 	{ ae_lq32f.xu	aeq0, a2, a15; ae_roundsp24q48sym	aep5, aeq0 }
     64f:	f4d6fc02ff 	{ ae_lq32f.xu	aeq0, a2, a15; ae_mulafq32sp24s.l	aeq1, aeq0, aep5 }
     654:	fbffbc62ff 	{ ae_lq32f.xu	aeq3, a2, a15; ae_roundsp24q48sym	aep6, aeq3 }
     659:	086b24        	ae_mulafq32sp24s.l	aeq1, aeq0, aep6
     65c:	1bac74        	ae_roundsp24q48sym	aep7, aeq2
     65f:	087be4        	ae_mulafq32sp24s.l	aeq1, aeq3, aep7
     662:	061834        	ae_roundsq32sym	aeq0, aeq1
     665:	620164        	ae_sq32f.i	aeq0, a1, 24
     668:	6128           	l32i.n	a2, a1, 24
     66a:	f01d           	retw.n

0000066c <skew_ctrl_16b>:
     66c:	008136        	entry	a1, 64
     66f:	23fd           	ae_l16si.n	a15, a3, 0
     671:	2552f2        	s16i	a15, a2, 74
     674:	5169           	s32i.n	a6, a1, 20
     676:	336d           	ae_l16si.n	a6, a3, 2
     678:	265262        	s16i	a6, a2, 76
     67b:	029362        	l16si	a6, a3, 4
     67e:	275262        	s16i	a6, a2, 78
     681:	039362        	l16si	a6, a3, 6
     684:	6159           	s32i.n	a5, a1, 24
     686:	061252        	l16ui	a5, a2, 12
     689:	285262        	s16i	a6, a2, 80
     68c:	049362        	l16si	a6, a3, 8
     68f:	295262        	s16i	a6, a2, 82
     692:	02bd           	mov.n	a11, a2
     694:	40c222        	addi	a2, a2, 64
     697:	2d55a6        	blti	a5, 5, 6c8 <skew_ctrl_16b+0x5c>
     69a:	52b5f6        	bgeui	a5, 16, 6f0 <skew_ctrl_16b+0x84>
     69d:	49a262        	movi	a6, 0x249
     6a0:	1166b0        	slli	a6, a6, 5
     6a3:	1ad657        	bbs	a6, a5, 6c1 <skew_ctrl_16b+0x55>
     6a6:	49a262        	movi	a6, 0x249
     6a9:	1166a0        	slli	a6, a6, 6
     6ac:	285657        	bbc	a6, a5, 6d8 <skew_ctrl_16b+0x6c>
     6af:	4a9b72        	l16si	a7, a11, 148
     6b2:	650c           	movi.n	a5, 6
     6b4:	580c           	movi.n	a8, 5
     6b6:	460c           	movi.n	a6, 4
     6b8:	b35870        	movgez	a5, a8, a7
     6bb:	b36870        	movgez	a6, a8, a7
     6be:	001386        	j	710 <skew_ctrl_16b+0xa4>

000006c1 <skew_ctrl_16b+0x55>:
     6c1:	4a9b52        	l16si	a5, a11, 148
     6c4:	000f06        	j	704 <skew_ctrl_16b+0x98>

000006c7 <skew_ctrl_16b+0x5b>:
	...

000006c8 <skew_ctrl_16b+0x5c>:
     6c8:	142526        	beqi	a5, 2, 6e0 <skew_ctrl_16b+0x74>
     6cb:	193526        	beqi	a5, 3, 6e8 <skew_ctrl_16b+0x7c>
     6ce:	860c           	movi.n	a6, 8
     6d0:	284526        	beqi	a5, 4, 6fc <skew_ctrl_16b+0x90>
     6d3:	000646        	j	6f0 <skew_ctrl_16b+0x84>

000006d6 <skew_ctrl_16b+0x6a>:
	...

000006d8 <skew_ctrl_16b+0x6c>:
     6d8:	147566        	bnei	a5, 7, 6f0 <skew_ctrl_16b+0x84>
     6db:	064c           	movi.n	a6, 64
     6dd:	0006c6        	j	6fc <skew_ctrl_16b+0x90>

000006e0 <skew_ctrl_16b+0x74>:
     6e0:	550c           	movi.n	a5, 5
     6e2:	560c           	movi.n	a6, 5
     6e4:	000a06        	j	710 <skew_ctrl_16b+0xa4>

000006e7 <skew_ctrl_16b+0x7b>:
	...

000006e8 <skew_ctrl_16b+0x7c>:
     6e8:	460c           	movi.n	a6, 4
     6ea:	650c           	movi.n	a5, 6
     6ec:	000806        	j	710 <skew_ctrl_16b+0xa4>

000006ef <skew_ctrl_16b+0x83>:
	...

000006f0 <skew_ctrl_16b+0x84>:
     6f0:	f6c552        	addi	a5, a5, -10
     6f3:	00a272        	movi	a7, 0x200
     6f6:	00a162        	movi	a6, 0x100
     6f9:	936750        	movnez	a6, a7, a5
     6fc:	4a9b52        	l16si	a5, a11, 148
     6ff:	f03d           	nop.n
     701:	f25560        	rems	a5, a5, a6
     704:	060c           	movi.n	a6, 0
     706:	726650        	salt	a6, a6, a5
     709:	6f0c           	movi.n	a15, 6
     70b:	c05f60        	sub	a5, a15, a6
     70e:	664b           	addi.n	a6, a6, 4
     710:	fe55d1        	l32r	a13, 64 (c6c <intp_filter_16b>)
     713:	fa7c           	movi.n	a10, -1
     715:	f38b           	addi.n	a15, a3, 8
     717:	902520        	addx2	a2, a5, a2
     71a:	7139           	s32i.n	a3, a1, 28
     71c:	41f9           	s32i.n	a15, a1, 16
     71e:	00a052        	movi	a5, 0
     721:	41a2a0        	srli	a10, a10, 2
     724:	5b88           	l32i.n	a8, a11, 20
     726:	4b98           	l32i.n	a9, a11, 16
     728:	1c0c           	movi.n	a12, 1
     72a:	0b7d           	mov.n	a7, a11
     72c:	898a           	add.n	a8, a9, a8
     72e:	159e80        	extui	a9, a8, 30, 2
     731:	909920        	addx2	a9, a9, a2
     734:	1088a0        	and	a8, a8, a10
     737:	932950        	movnez	a2, a9, a5
     73a:	4b89           	s32i.n	a8, a11, 16
     73c:	0bad           	mov.n	a10, a11
     73e:	02bd           	mov.n	a11, a2
     740:	203dd0        	or	a3, a13, a13
     743:	000de0        	callx8	a13
     746:	551b           	addi.n	a5, a5, 1
     748:	ff7c           	movi.n	a15, -1
     74a:	64ad           	ae_s16i.n	a10, a4, 0
     74c:	07bd           	mov.n	a11, a7
     74e:	03dd           	mov.n	a13, a3
     750:	41a2f0        	srli	a10, a15, 2
     753:	442b           	addi.n	a4, a4, 2
     755:	cb9657        	bne	a6, a5, 724 <skew_ctrl_16b+0xb8>
     758:	5128           	l32i.n	a2, a1, 20
     75a:	4158           	l32i.n	a5, a1, 16
     75c:	2cb627        	bgeu	a6, a2, 78c <skew_ctrl_16b+0x120>
     75f:	c02260        	sub	a2, a2, a6
     762:	5b88           	l32i.n	a8, a11, 20
     764:	4b68           	l32i.n	a6, a11, 16
     766:	1c0c           	movi.n	a12, 1
     768:	868a           	add.n	a8, a6, a8
     76a:	156e80        	extui	a6, a8, 30, 2
     76d:	1088a0        	and	a8, a8, a10
     770:	905650        	addx2	a5, a6, a5
     773:	4b89           	s32i.n	a8, a11, 16
     775:	0bad           	mov.n	a10, a11
     777:	05bd           	mov.n	a11, a5
     779:	0003e0        	callx8	a3
     77c:	220b           	addi.n	a2, a2, -1
     77e:	ff7c           	movi.n	a15, -1
     780:	64ad           	ae_s16i.n	a10, a4, 0
     782:	07bd           	mov.n	a11, a7
     784:	41a2f0        	srli	a10, a15, 2
     787:	442b           	addi.n	a4, a4, 2
     789:	fd5256        	bnez	a2, 762 <skew_ctrl_16b+0xf6>
     78c:	7128           	l32i.n	a2, a1, 28
     78e:	6148           	l32i.n	a4, a1, 24
     790:	902420        	addx2	a2, a4, a2
     793:	f6c222        	addi	a2, a2, -10
     796:	22fd           	ae_l16si.n	a15, a2, 0
     798:	205bf2        	s16i	a15, a11, 64
     79b:	324d           	ae_l16si.n	a4, a2, 2
     79d:	215b42        	s16i	a4, a11, 66
     7a0:	029242        	l16si	a4, a2, 4
     7a3:	225b42        	s16i	a4, a11, 68
     7a6:	039242        	l16si	a4, a2, 6
     7a9:	235b42        	s16i	a4, a11, 70
     7ac:	049222        	l16si	a2, a2, 8
     7af:	245b22        	s16i	a2, a11, 72
     7b2:	f01d           	retw.n

000007b4 <Check_Phase_Frac>:
     7b4:	004136        	entry	a1, 32
     7b7:	071226        	beqi	a2, 1, 7c2 <Check_Phase_Frac+0xe>
     7ba:	0a2266        	bnei	a2, 2, 7c8 <Check_Phase_Frac+0x14>
     7bd:	044c           	movi.n	a4, 64
     7bf:	000446        	j	7d4 <Check_Phase_Frac+0x20>

000007c2 <Check_Phase_Frac+0xe>:
     7c2:	840c           	movi.n	a4, 8
     7c4:	000306        	j	7d4 <Check_Phase_Frac+0x20>

000007c7 <Check_Phase_Frac+0x13>:
	...

000007c8 <Check_Phase_Frac+0x14>:
     7c8:	fdc222        	addi	a2, a2, -3
     7cb:	00a252        	movi	a5, 0x200
     7ce:	00a142        	movi	a4, 0x100
     7d1:	934520        	movnez	a4, a5, a2
     7d4:	235d           	ae_l16si.n	a5, a3, 0
     7d6:	640b           	addi.n	a6, a4, -1
     7d8:	020c           	movi.n	a2, 0
     7da:	020567        	bnone	a5, a6, 7e0 <Check_Phase_Frac+0x2c>
     7dd:	f01d           	retw.n

000007df <Check_Phase_Frac+0x2b>:
	...

000007e0 <Check_Phase_Frac+0x2c>:
     7e0:	605150        	abs	a5, a5
     7e3:	855d           	ae_sext16	a5, a5
     7e5:	f42547        	blt	a5, a4, 7dd <Check_Phase_Frac+0x29>
     7e8:	020c           	movi.n	a2, 0
     7ea:	632d           	ae_s16i.n	a2, a3, 0
     7ec:	120c           	movi.n	a2, 1
     7ee:	f01d           	retw.n

000007f0 <skew_ctrl_process>:
     7f0:	004136        	entry	a1, 32
     7f3:	02fd           	mov.n	a15, a2
     7f5:	8e0c           	movi.n	a14, 8
     7f7:	03bd           	mov.n	a11, a3
     7f9:	065272        	s16i	a7, a2, 12
     7fc:	142e77        	blt	a14, a7, 814 <skew_ctrl_process+0x24>
     7ff:	2d57a6        	blti	a7, 5, 830 <skew_ctrl_process+0x40>
     802:	4e5726        	beqi	a7, 5, 854 <skew_ctrl_process+0x64>
     805:	536726        	beqi	a7, 6, 85c <skew_ctrl_process+0x6c>
     808:	028726        	beqi	a7, 8, 80e <skew_ctrl_process+0x1e>
     80b:	00d4c6        	j	b62 <skew_ctrl_process+0x372>
     80e:	20cf22        	addi	a2, a15, 32
     811:	001ac6        	j	880 <skew_ctrl_process+0x90>

00000814 <skew_ctrl_process+0x24>:
     814:	29a7a6        	blti	a7, 12, 841 <skew_ctrl_process+0x51>
     817:	4aa726        	beqi	a7, 12, 865 <skew_ctrl_process+0x75>
     81a:	e20c           	movi.n	a2, 14
     81c:	4d1727        	beq	a7, a2, 86d <skew_ctrl_process+0x7d>
     81f:	f20c           	movi.n	a2, 15
     821:	021727        	beq	a7, a2, 827 <skew_ctrl_process+0x37>
     824:	00ce86        	j	b62 <skew_ctrl_process+0x372>
     827:	3ccf22        	addi	a2, a15, 60
     82a:	490c           	movi.n	a9, 4
     82c:	001486        	j	882 <skew_ctrl_process+0x92>

0000082f <skew_ctrl_process+0x3f>:
	...

00000830 <skew_ctrl_process+0x40>:
     830:	412726        	beqi	a7, 2, 875 <skew_ctrl_process+0x85>
     833:	023726        	beqi	a7, 3, 839 <skew_ctrl_process+0x49>
     836:	00ca06        	j	b62 <skew_ctrl_process+0x372>
     839:	2ccf22        	addi	a2, a15, 44
     83c:	090c           	movi.n	a9, 0
     83e:	001006        	j	882 <skew_ctrl_process+0x92>

00000841 <skew_ctrl_process+0x51>:
     841:	920c           	movi.n	a2, 9
     843:	361727        	beq	a7, a2, 87d <skew_ctrl_process+0x8d>
     846:	b20c           	movi.n	a2, 11
     848:	021727        	beq	a7, a2, 84e <skew_ctrl_process+0x5e>
     84b:	00c4c6        	j	b62 <skew_ctrl_process+0x372>
     84e:	24cf22        	addi	a2, a15, 36
     851:	0004c6        	j	868 <skew_ctrl_process+0x78>

00000854 <skew_ctrl_process+0x64>:
     854:	1ccf22        	addi	a2, a15, 28
     857:	190c           	movi.n	a9, 1
     859:	000946        	j	882 <skew_ctrl_process+0x92>

0000085c <skew_ctrl_process+0x6c>:
     85c:	30cf22        	addi	a2, a15, 48
     85f:	190c           	movi.n	a9, 1
     861:	000746        	j	882 <skew_ctrl_process+0x92>

00000864 <skew_ctrl_process+0x74>:
	...

00000865 <skew_ctrl_process+0x75>:
     865:	38cf22        	addi	a2, a15, 56
     868:	390c           	movi.n	a9, 3
     86a:	000506        	j	882 <skew_ctrl_process+0x92>

0000086d <skew_ctrl_process+0x7d>:
     86d:	28cf22        	addi	a2, a15, 40
     870:	490c           	movi.n	a9, 4
     872:	000306        	j	882 <skew_ctrl_process+0x92>

00000875 <skew_ctrl_process+0x85>:
     875:	18cf22        	addi	a2, a15, 24
     878:	090c           	movi.n	a9, 0
     87a:	000106        	j	882 <skew_ctrl_process+0x92>

0000087d <skew_ctrl_process+0x8d>:
     87d:	34cf22        	addi	a2, a15, 52
     880:	290c           	movi.n	a9, 2
     882:	0228           	l32i.n	a2, a2, 0
     884:	056f22        	s32i	a2, a15, 20
     887:	5f2d           	ae_l16ui.n	a2, a15, 2
     889:	485f92        	s16i	a9, a15, 144
     88c:	4f3d           	ae_l16ui.n	a3, a15, 0
     88e:	071fc2        	l16ui	a12, a15, 14
     891:	2a0c           	movi.n	a10, 2
     893:	480c           	movi.n	a8, 4
     895:	e0c332        	addi	a3, a3, -32
     898:	1d1c           	movi.n	a13, 17
     89a:	938a30        	movnez	a8, a10, a3
     89d:	0c9cd7        	bne	a12, a13, 8ad <skew_ctrl_process+0xbd>
     8a0:	022726        	beqi	a7, 2, 8a6 <skew_ctrl_process+0xb6>
     8a3:	007dc6        	j	a9e <skew_ctrl_process+0x2ae>
     8a6:	a82a           	add.n	a10, a8, a2
     8a8:	130c           	movi.n	a3, 1
     8aa:	000386        	j	8bc <skew_ctrl_process+0xcc>

000008ad <skew_ctrl_process+0xbd>:
     8ad:	022726        	beqi	a7, 2, 8b3 <skew_ctrl_process+0xc3>
     8b0:	008a86        	j	ade <skew_ctrl_process+0x2ee>
     8b3:	c07280        	sub	a7, a2, a8
     8b6:	130c           	movi.n	a3, 1
     8b8:	02ad           	mov.n	a10, a2
     8ba:	072d           	mov.n	a2, a7
     8bc:	642d           	ae_s16i.n	a2, a4, 0
     8be:	66ad           	ae_s16i.n	a10, a6, 0
     8c0:	4f7d           	ae_l16ui.n	a7, a15, 0
     8c2:	ed7c           	movi.n	a13, -2
     8c4:	f440d0        	extui	a4, a13, 0, 16
     8c7:	1e0c           	movi.n	a14, 1
     8c9:	e0c792        	addi	a9, a7, -32
     8cc:	108a40        	and	a8, a10, a4
     8cf:	6269e0        	saltu	a6, a9, a14
     8d2:	418180        	srli	a8, a8, 1
     8d5:	400600        	ssr	a6
     8d8:	91e080        	srl	a14, a8
     8db:	639c           	beqz.n	a3, 8f5 <skew_ctrl_process+0x105>
     8dd:	102240        	and	a2, a2, a4
     8e0:	412120        	srli	a2, a2, 1
     8e3:	91d020        	srl	a13, a2
     8e6:	02c726        	beqi	a7, 32, 8ec <skew_ctrl_process+0xfc>
     8e9:	003606        	j	9c5 <skew_ctrl_process+0x1d5>
     8ec:	fddf21        	l32r	a2, 68 (3d4 <skew_ctrl_32b>)
     8ef:	003546        	j	9c8 <skew_ctrl_process+0x1d8>

000008f2 <skew_ctrl_process+0x102>:
     8f2:	000000                                        ...

000008f5 <skew_ctrl_process+0x105>:
     8f5:	051f22        	l16ui	a2, a15, 10
     8f8:	240c           	movi.n	a4, 2
     8fa:	320b           	addi.n	a3, a2, -1
     8fc:	834230        	moveqz	a4, a2, a3
     8ff:	834220        	moveqz	a4, a2, a2
     902:	c06e40        	sub	a6, a14, a4
     905:	02c726        	beqi	a7, 32, 90b <skew_ctrl_process+0x11b>
     908:	0039c6        	j	9f3 <skew_ctrl_process+0x203>
     90b:	044216        	beqz	a2, 953 <skew_ctrl_process+0x163>
     90e:	1124e0        	slli	a2, a4, 2
     911:	c02f20        	sub	a2, a15, a2
     914:	247040        	extui	a7, a4, 0, 3
     917:	413340        	srli	a3, a4, 3
     91a:	54c222        	addi	a2, a2, 84
     91d:	079776        	loopnez	a7, 928 <skew_ctrl_process+0x138>
     920:	0278           	l32i.n	a7, a2, 0
     922:	0579           	s32i.n	a7, a5, 0
     924:	224b           	addi.n	a2, a2, 4
     926:	554b           	addi.n	a5, a5, 4

00000928 <skew_ctrl_process+0x138>:
     928:	73ac           	beqz.n	a3, 953 <skew_ctrl_process+0x163>
     92a:	259376        	loopnez	a3, 953 <skew_ctrl_process+0x163>
     92d:	0238           	l32i.n	a3, a2, 0
     92f:	0539           	s32i.n	a3, a5, 0
     931:	1238           	l32i.n	a3, a2, 4
     933:	1539           	s32i.n	a3, a5, 4
     935:	2238           	l32i.n	a3, a2, 8
     937:	2539           	s32i.n	a3, a5, 8
     939:	3238           	l32i.n	a3, a2, 12
     93b:	3539           	s32i.n	a3, a5, 12
     93d:	4238           	l32i.n	a3, a2, 16
     93f:	4539           	s32i.n	a3, a5, 16
     941:	5238           	l32i.n	a3, a2, 20
     943:	5539           	s32i.n	a3, a5, 20
     945:	6238           	l32i.n	a3, a2, 24
     947:	6539           	s32i.n	a3, a5, 24
     949:	7238           	l32i.n	a3, a2, 28
     94b:	7539           	s32i.n	a3, a5, 28
     94d:	20c222        	addi	a2, a2, 32
     950:	20c552        	addi	a5, a5, 32

00000953 <skew_ctrl_process+0x163>:
     953:	112600        	slli	a2, a6, 16
     956:	4212a6        	blti	a2, 1, 99c <skew_ctrl_process+0x1ac>
     959:	862d           	ae_sext16	a2, a6
     95b:	243020        	extui	a3, a2, 0, 3
     95e:	412320        	srli	a2, a2, 3
     961:	079376        	loopnez	a3, 96c <skew_ctrl_process+0x17c>
     964:	0b38           	l32i.n	a3, a11, 0
     966:	0539           	s32i.n	a3, a5, 0
     968:	bb4b           	addi.n	a11, a11, 4
     96a:	554b           	addi.n	a5, a5, 4

0000096c <skew_ctrl_process+0x17c>:
     96c:	c2ac           	beqz.n	a2, 99c <skew_ctrl_process+0x1ac>
     96e:	203bb0        	or	a3, a11, a11
     971:	259276        	loopnez	a2, 99a <skew_ctrl_process+0x1aa>
     974:	0328           	l32i.n	a2, a3, 0
     976:	0529           	s32i.n	a2, a5, 0
     978:	1328           	l32i.n	a2, a3, 4
     97a:	1529           	s32i.n	a2, a5, 4
     97c:	2328           	l32i.n	a2, a3, 8
     97e:	2529           	s32i.n	a2, a5, 8
     980:	3328           	l32i.n	a2, a3, 12
     982:	3529           	s32i.n	a2, a5, 12
     984:	4328           	l32i.n	a2, a3, 16
     986:	4529           	s32i.n	a2, a5, 16
     988:	5328           	l32i.n	a2, a3, 20
     98a:	5529           	s32i.n	a2, a5, 20
     98c:	6328           	l32i.n	a2, a3, 24
     98e:	6529           	s32i.n	a2, a5, 24
     990:	7328           	l32i.n	a2, a3, 28
     992:	7529           	s32i.n	a2, a5, 28
     994:	20c332        	addi	a3, a3, 32
     997:	20c552        	addi	a5, a5, 32
     99a:	03bd           	mov.n	a11, a3

0000099c <skew_ctrl_process+0x1ac>:
     99c:	a024b0        	addx4	a2, a4, a11
     99f:	ecc222        	addi	a2, a2, -20
     9a2:	0238           	l32i.n	a3, a2, 0
     9a4:	106f32        	s32i	a3, a15, 64
     9a7:	1238           	l32i.n	a3, a2, 4
     9a9:	116f32        	s32i	a3, a15, 68
     9ac:	2238           	l32i.n	a3, a2, 8
     9ae:	126f32        	s32i	a3, a15, 72
     9b1:	3238           	l32i.n	a3, a2, 12
     9b3:	136f32        	s32i	a3, a15, 76
     9b6:	4228           	l32i.n	a2, a2, 16
     9b8:	146f22        	s32i	a2, a15, 80
     9bb:	481f22        	l16ui	a2, a15, 144
     9be:	1a1266        	bnei	a2, 1, 9dc <skew_ctrl_process+0x1ec>
     9c1:	002c46        	j	a76 <skew_ctrl_process+0x286>

000009c4 <skew_ctrl_process+0x1d4>:
	...

000009c5 <skew_ctrl_process+0x1d5>:
     9c5:	fda921        	l32r	a2, 6c (66c <skew_ctrl_16b>)
     9c8:	0fad           	mov.n	a10, a15
     9ca:	05cd           	mov.n	a12, a5
     9cc:	0f3d           	mov.n	a3, a15
     9ce:	0002e0        	callx8	a2
     9d1:	03fd           	mov.n	a15, a3
     9d3:	481322        	l16ui	a2, a3, 144
     9d6:	021266        	bnei	a2, 1, 9dc <skew_ctrl_process+0x1ec>
     9d9:	002646        	j	a76 <skew_ctrl_process+0x286>
     9dc:	042266        	bnei	a2, 2, 9e4 <skew_ctrl_process+0x1f4>
     9df:	024c           	movi.n	a2, 64
     9e1:	0024c6        	j	a78 <skew_ctrl_process+0x288>

000009e4 <skew_ctrl_process+0x1f4>:
     9e4:	fdc232        	addi	a3, a2, -3
     9e7:	00a242        	movi	a4, 0x200
     9ea:	00a122        	movi	a2, 0x100
     9ed:	932430        	movnez	a2, a4, a3
     9f0:	002106        	j	a78 <skew_ctrl_process+0x288>

000009f3 <skew_ctrl_process+0x203>:
     9f3:	92ac           	beqz.n	a2, a20 <skew_ctrl_process+0x230>
     9f5:	40cf22        	addi	a2, a15, 64
     9f8:	1134f0        	slli	a3, a4, 1
     9fb:	c02230        	sub	a2, a2, a3
     9fe:	413140        	srli	a3, a4, 1
     a01:	22ab           	addi.n	a2, a2, 10
     a03:	076407        	bbci	a4, 0, a0e <skew_ctrl_process+0x21e>
     a06:	227d           	ae_l16si.n	a7, a2, 0
     a08:	657d           	ae_s16i.n	a7, a5, 0
     a0a:	222b           	addi.n	a2, a2, 2
     a0c:	552b           	addi.n	a5, a5, 2

00000a0e <skew_ctrl_process+0x21e>:
     a0e:	e38c           	beqz.n	a3, a20 <skew_ctrl_process+0x230>
     a10:	0c9376        	loopnez	a3, a20 <skew_ctrl_process+0x230>
     a13:	223d           	ae_l16si.n	a3, a2, 0
     a15:	653d           	ae_s16i.n	a3, a5, 0
     a17:	323d           	ae_l16si.n	a3, a2, 2
     a19:	753d           	ae_s16i.n	a3, a5, 2
     a1b:	224b           	addi.n	a2, a2, 4
     a1d:	04c552        	addi	a5, a5, 4

00000a20 <skew_ctrl_process+0x230>:
     a20:	112600        	slli	a2, a6, 16
     a23:	2412a6        	blti	a2, 1, a4b <skew_ctrl_process+0x25b>
     a26:	863d           	ae_sext16	a3, a6
     a28:	412130        	srli	a2, a3, 1
     a2b:	076307        	bbci	a3, 0, a36 <skew_ctrl_process+0x246>
     a2e:	2b3d           	ae_l16si.n	a3, a11, 0
     a30:	653d           	ae_s16i.n	a3, a5, 0
     a32:	bb2b           	addi.n	a11, a11, 2
     a34:	552b           	addi.n	a5, a5, 2

00000a36 <skew_ctrl_process+0x246>:
     a36:	129c           	beqz.n	a2, a4b <skew_ctrl_process+0x25b>
     a38:	0b3d           	mov.n	a3, a11
     a3a:	0b9276        	loopnez	a2, a49 <skew_ctrl_process+0x259>
     a3d:	232d           	ae_l16si.n	a2, a3, 0
     a3f:	652d           	ae_s16i.n	a2, a5, 0
     a41:	332d           	ae_l16si.n	a2, a3, 2
     a43:	752d           	ae_s16i.n	a2, a5, 2
     a45:	334b           	addi.n	a3, a3, 4
     a47:	554b           	addi.n	a5, a5, 4

00000a49 <skew_ctrl_process+0x259>:
     a49:	03bd           	mov.n	a11, a3

00000a4b <skew_ctrl_process+0x25b>:
     a4b:	9024b0        	addx2	a2, a4, a11
     a4e:	f6c222        	addi	a2, a2, -10
     a51:	223d           	ae_l16si.n	a3, a2, 0
     a53:	205f32        	s16i	a3, a15, 64
     a56:	323d           	ae_l16si.n	a3, a2, 2
     a58:	215f32        	s16i	a3, a15, 66
     a5b:	029232        	l16si	a3, a2, 4
     a5e:	225f32        	s16i	a3, a15, 68
     a61:	039232        	l16si	a3, a2, 6
     a64:	235f32        	s16i	a3, a15, 70
     a67:	049222        	l16si	a2, a2, 8
     a6a:	245f22        	s16i	a2, a15, 72
     a6d:	481f22        	l16ui	a2, a15, 144
     a70:	021226        	beqi	a2, 1, a76 <skew_ctrl_process+0x286>
     a73:	ffd946        	j	9dc <skew_ctrl_process+0x1ec>
     a76:	820c           	movi.n	a2, 8
     a78:	499f32        	l16si	a3, a15, 146
     a7b:	420b           	addi.n	a4, a2, -1
     a7d:	4a9f52        	l16si	a5, a15, 148
     a80:	070347        	bnone	a3, a4, a8b <skew_ctrl_process+0x29b>
     a83:	604150        	abs	a4, a5
     a86:	053d           	mov.n	a3, a5
     a88:	000206        	j	a94 <skew_ctrl_process+0x2a4>

00000a8b <skew_ctrl_process+0x29b>:
     a8b:	030c           	movi.n	a3, 0
     a8d:	040c           	movi.n	a4, 0
     a8f:	4f39           	s32i.n	a3, a15, 16
     a91:	4a5f32        	s16i	a3, a15, 148
     a94:	844d           	ae_sext16	a4, a4
     a96:	722420        	salt	a2, a4, a2
     a99:	932320        	movnez	a2, a3, a2
     a9c:	f01d           	retw.n

00000a9e <skew_ctrl_process+0x2ae>:
     a9e:	130c           	movi.n	a3, 1
     aa0:	02ad           	mov.n	a10, a2
     aa2:	02b7b6        	bltui	a7, 16, aa8 <skew_ctrl_process+0x2b8>
     aa5:	ff84c6        	j	8bc <skew_ctrl_process+0xcc>
     aa8:	49a2a2        	movi	a10, 0x249
     aab:	11aab0        	slli	a10, a10, 5
     aae:	6eda77        	bbs	a10, a7, b20 <skew_ctrl_process+0x330>
     ab1:	49a2a2        	movi	a10, 0x249
     ab4:	11aaa0        	slli	a10, a10, 6
     ab7:	02da77        	bbs	a10, a7, abd <skew_ctrl_process+0x2cd>
     aba:	002fc6        	j	b7d <skew_ctrl_process+0x38d>
     abd:	491f72        	l16ui	a7, a15, 146
     ac0:	00a2d2        	movi	a13, 0x200
     ac3:	a70b           	addi.n	a10, a7, -1
     ac5:	8acd           	ae_sext16	a12, a10
     ac7:	495fa2        	s16i	a10, a15, 146
     aca:	4a5fa2        	s16i	a10, a15, 148
     acd:	021966        	bnei	a9, 1, ad3 <skew_ctrl_process+0x2e3>
     ad0:	003106        	j	b98 <skew_ctrl_process+0x3a8>
     ad3:	022926        	beqi	a9, 2, ad9 <skew_ctrl_process+0x2e9>
     ad6:	0030c6        	j	b9d <skew_ctrl_process+0x3ad>
     ad9:	094c           	movi.n	a9, 64
     adb:	0031c6        	j	ba6 <skew_ctrl_process+0x3b6>

00000ade <skew_ctrl_process+0x2ee>:
     ade:	130c           	movi.n	a3, 1
     ae0:	02ad           	mov.n	a10, a2
     ae2:	02b7b6        	bltui	a7, 16, ae8 <skew_ctrl_process+0x2f8>
     ae5:	ff74c6        	j	8bc <skew_ctrl_process+0xcc>
     ae8:	49a2a2        	movi	a10, 0x249
     aeb:	11aab0        	slli	a10, a10, 5
     aee:	4fda77        	bbs	a10, a7, b41 <skew_ctrl_process+0x351>
     af1:	49a2a2        	movi	a10, 0x249
     af4:	11aaa0        	slli	a10, a10, 6
     af7:	02da77        	bbs	a10, a7, afd <skew_ctrl_process+0x30d>
     afa:	002346        	j	b8b <skew_ctrl_process+0x39b>
     afd:	491f72        	l16ui	a7, a15, 146
     b00:	00a2d2        	movi	a13, 0x200
     b03:	a70b           	addi.n	a10, a7, -1
     b05:	8acd           	ae_sext16	a12, a10
     b07:	495fa2        	s16i	a10, a15, 146
     b0a:	4a5fa2        	s16i	a10, a15, 148
     b0d:	021966        	bnei	a9, 1, b13 <skew_ctrl_process+0x323>
     b10:	002e46        	j	bcd <skew_ctrl_process+0x3dd>
     b13:	022926        	beqi	a9, 2, b19 <skew_ctrl_process+0x329>
     b16:	002e06        	j	bd2 <skew_ctrl_process+0x3e2>
     b19:	094c           	movi.n	a9, 64
     b1b:	002f06        	j	bdb <skew_ctrl_process+0x3eb>

00000b1e <skew_ctrl_process+0x32e>:
	...

00000b20 <skew_ctrl_process+0x330>:
     b20:	491f72        	l16ui	a7, a15, 146
     b23:	00a2d2        	movi	a13, 0x200
     b26:	a71b           	addi.n	a10, a7, 1
     b28:	8acd           	ae_sext16	a12, a10
     b2a:	495fa2        	s16i	a10, a15, 146
     b2d:	4a5fa2        	s16i	a10, a15, 148
     b30:	021966        	bnei	a9, 1, b36 <skew_ctrl_process+0x346>
     b33:	0031c6        	j	bfe <skew_ctrl_process+0x40e>
     b36:	022926        	beqi	a9, 2, b3c <skew_ctrl_process+0x34c>
     b39:	003186        	j	c03 <skew_ctrl_process+0x413>
     b3c:	094c           	movi.n	a9, 64
     b3e:	003286        	j	c0c <skew_ctrl_process+0x41c>

00000b41 <skew_ctrl_process+0x351>:
     b41:	491f72        	l16ui	a7, a15, 146
     b44:	00a2d2        	movi	a13, 0x200
     b47:	a71b           	addi.n	a10, a7, 1
     b49:	8acd           	ae_sext16	a12, a10
     b4b:	495fa2        	s16i	a10, a15, 146
     b4e:	4a5fa2        	s16i	a10, a15, 148
     b51:	021966        	bnei	a9, 1, b57 <skew_ctrl_process+0x367>
     b54:	003686        	j	c32 <skew_ctrl_process+0x442>
     b57:	022926        	beqi	a9, 2, b5d <skew_ctrl_process+0x36d>
     b5a:	003686        	j	c38 <skew_ctrl_process+0x448>
     b5d:	094c           	movi.n	a9, 64
     b5f:	003786        	j	c41 <skew_ctrl_process+0x451>

00000b62 <skew_ctrl_process+0x372>:
     b62:	5f2d           	ae_l16ui.n	a2, a15, 2
     b64:	180c           	movi.n	a8, 1
     b66:	018820        	slli	a8, a8, 30
     b69:	090c           	movi.n	a9, 0
     b6b:	030c           	movi.n	a3, 0
     b6d:	02ad           	mov.n	a10, a2
     b6f:	485f92        	s16i	a9, a15, 144
     b72:	5f89           	s32i.n	a8, a15, 20
     b74:	0227b6        	bltui	a7, 2, b7a <skew_ctrl_process+0x38a>
     b77:	ff4446        	j	88c <skew_ctrl_process+0x9c>
     b7a:	ff4f86        	j	8bc <skew_ctrl_process+0xcc>

00000b7d <skew_ctrl_process+0x38d>:
     b7d:	02ad           	mov.n	a10, a2
     b7f:	023726        	beqi	a7, 3, b85 <skew_ctrl_process+0x395>
     b82:	ff4d86        	j	8bc <skew_ctrl_process+0xcc>
     b85:	c0a280        	sub	a10, a2, a8
     b88:	ff4c06        	j	8bc <skew_ctrl_process+0xcc>

00000b8b <skew_ctrl_process+0x39b>:
     b8b:	02ad           	mov.n	a10, a2
     b8d:	023726        	beqi	a7, 3, b93 <skew_ctrl_process+0x3a3>
     b90:	ff4a06        	j	8bc <skew_ctrl_process+0xcc>
     b93:	782a           	add.n	a7, a8, a2
     b95:	ff47c6        	j	8b8 <skew_ctrl_process+0xc8>

00000b98 <skew_ctrl_process+0x3a8>:
     b98:	890c           	movi.n	a9, 8
     b9a:	000206        	j	ba6 <skew_ctrl_process+0x3b6>

00000b9d <skew_ctrl_process+0x3ad>:
     b9d:	fdc9a2        	addi	a10, a9, -3
     ba0:	00a192        	movi	a9, 0x100
     ba3:	939da0        	movnez	a9, a13, a10
     ba6:	d90b           	addi.n	a13, a9, -1
     ba8:	02ad           	mov.n	a10, a2
     baa:	020cd7        	bnone	a12, a13, bb0 <skew_ctrl_process+0x3c0>
     bad:	ff42c6        	j	8bc <skew_ctrl_process+0xcc>
     bb0:	130c           	movi.n	a3, 1
     bb2:	c07370        	sub	a7, a3, a7
     bb5:	a3c7c0        	movltz	a12, a7, a12
     bb8:	8c7d           	ae_sext16	a7, a12
     bba:	02ad           	mov.n	a10, a2
     bbc:	02a797        	bge	a7, a9, bc2 <skew_ctrl_process+0x3d2>
     bbf:	ff3e46        	j	8bc <skew_ctrl_process+0xcc>
     bc2:	070c           	movi.n	a7, 0
     bc4:	c0a280        	sub	a10, a2, a8
     bc7:	495f72        	s16i	a7, a15, 146
     bca:	ff3b86        	j	8bc <skew_ctrl_process+0xcc>

00000bcd <skew_ctrl_process+0x3dd>:
     bcd:	890c           	movi.n	a9, 8
     bcf:	000206        	j	bdb <skew_ctrl_process+0x3eb>

00000bd2 <skew_ctrl_process+0x3e2>:
     bd2:	fdc9a2        	addi	a10, a9, -3
     bd5:	00a192        	movi	a9, 0x100
     bd8:	939da0        	movnez	a9, a13, a10
     bdb:	d90b           	addi.n	a13, a9, -1
     bdd:	02ad           	mov.n	a10, a2
     bdf:	020cd7        	bnone	a12, a13, be5 <skew_ctrl_process+0x3f5>
     be2:	ff3586        	j	8bc <skew_ctrl_process+0xcc>
     be5:	130c           	movi.n	a3, 1
     be7:	c07370        	sub	a7, a3, a7
     bea:	a3c7c0        	movltz	a12, a7, a12
     bed:	8c7d           	ae_sext16	a7, a12
     bef:	02ad           	mov.n	a10, a2
     bf1:	02a797        	bge	a7, a9, bf7 <skew_ctrl_process+0x407>
     bf4:	ff3106        	j	8bc <skew_ctrl_process+0xcc>
     bf7:	070c           	movi.n	a7, 0
     bf9:	882a           	add.n	a8, a8, a2
     bfb:	0018c6        	j	c62 <skew_ctrl_process+0x472>

00000bfe <skew_ctrl_process+0x40e>:
     bfe:	890c           	movi.n	a9, 8
     c00:	000206        	j	c0c <skew_ctrl_process+0x41c>

00000c03 <skew_ctrl_process+0x413>:
     c03:	fdc9a2        	addi	a10, a9, -3
     c06:	00a192        	movi	a9, 0x100
     c09:	939da0        	movnez	a9, a13, a10
     c0c:	d90b           	addi.n	a13, a9, -1
     c0e:	02ad           	mov.n	a10, a2
     c10:	020cd7        	bnone	a12, a13, c16 <skew_ctrl_process+0x426>
     c13:	ff2946        	j	8bc <skew_ctrl_process+0xcc>
     c16:	fa7c           	movi.n	a10, -1
     c18:	3077a0        	xor	a7, a7, a10
     c1b:	a3c7c0        	movltz	a12, a7, a12
     c1e:	8c7d           	ae_sext16	a7, a12
     c20:	02ad           	mov.n	a10, a2
     c22:	02a797        	bge	a7, a9, c28 <skew_ctrl_process+0x438>
     c25:	ff24c6        	j	8bc <skew_ctrl_process+0xcc>
     c28:	070c           	movi.n	a7, 0
     c2a:	a82a           	add.n	a10, a8, a2
     c2c:	495f72        	s16i	a7, a15, 146
     c2f:	ff2246        	j	8bc <skew_ctrl_process+0xcc>

00000c32 <skew_ctrl_process+0x442>:
     c32:	890c           	movi.n	a9, 8
     c34:	000246        	j	c41 <skew_ctrl_process+0x451>

00000c37 <skew_ctrl_process+0x447>:
	...

00000c38 <skew_ctrl_process+0x448>:
     c38:	fdc9a2        	addi	a10, a9, -3
     c3b:	00a192        	movi	a9, 0x100
     c3e:	939da0        	movnez	a9, a13, a10
     c41:	d90b           	addi.n	a13, a9, -1
     c43:	02ad           	mov.n	a10, a2
     c45:	020cd7        	bnone	a12, a13, c4b <skew_ctrl_process+0x45b>
     c48:	ff1c06        	j	8bc <skew_ctrl_process+0xcc>
     c4b:	fa7c           	movi.n	a10, -1
     c4d:	3077a0        	xor	a7, a7, a10
     c50:	a3c7c0        	movltz	a12, a7, a12
     c53:	8c7d           	ae_sext16	a7, a12
     c55:	02ad           	mov.n	a10, a2
     c57:	02a797        	bge	a7, a9, c5d <skew_ctrl_process+0x46d>
     c5a:	ff1786        	j	8bc <skew_ctrl_process+0xcc>
     c5d:	070c           	movi.n	a7, 0
     c5f:	c08280        	sub	a8, a2, a8
     c62:	02ad           	mov.n	a10, a2
     c64:	082d           	mov.n	a2, a8
     c66:	495f72        	s16i	a7, a15, 146
     c69:	ff13c6        	j	8bc <skew_ctrl_process+0xcc>

00000c6c <intp_filter_16b>:
     c6c:	008136        	entry	a1, 64
     c6f:	4268           	l32i.n	a6, a2, 16
     c71:	051222        	l16ui	a2, a2, 10
     c74:	180c           	movi.n	a8, 1
     c76:	1166f0        	slli	a6, a6, 1
     c79:	7169           	s32i.n	a6, a1, 28
     c7b:	500174        	ae_lp24f.i	aep0, a1, 28
     c7e:	1c1226        	beqi	a2, 1, c9e <intp_filter_16b+0x32>
     c81:	083256        	bnez	a2, d08 <intp_filter_16b+0x9c>
     c84:	1124e0        	slli	a2, a4, 2
     c87:	01e4f0        	slli	a14, a4, 17
     c8a:	c02320        	sub	a2, a3, a2
     c8d:	31f0e0        	srai	a15, a14, 16
     c90:	4192f4        	ae_lp16f.xu	aep1, a2, a15
     c93:	0a0184        	ae_cvtq48p24s.l	aeq0, aep1
     c96:	ee059a12ff 	{ ae_lp16f.xu	aep1, a2, a15; ae_mulsfp24s.ll	aeq0, aep1, aep0 }
     c9b:	005646        	j	df8 <intp_filter_16b+0x18c>

00000c9e <intp_filter_16b+0x32>:
     c9e:	120c           	movi.n	a2, 1
     ca0:	112230        	slli	a2, a2, 13
     ca3:	301224        	ae_cvtp24a16x2.ll	aep1, a2, a2
     ca6:	ea05c0016f 	{ movi	a6, 1; ae_mulfp24s.ll	aeq1, aep1, aep0 }
     cab:	016620        	slli	a6, a6, 30
     cae:	f8efc0055f 	{ movi	a5, 5; ae_roundsp24q48sym	aep1, aeq1 }
     cb3:	eb05bec63f 	{ ae_cvtq48a32s	aeq0, a6; ae_mulfp24s.ll	aeq2, aep1, aep0 }
     cb8:	350054        	ae_slliq56	aeq0, aeq0, 1
     cbb:	115530        	slli	a5, a5, 13
     cbe:	11e4d0        	slli	a14, a4, 3
     cc1:	01f4f0        	slli	a15, a4, 17
     cc4:	f8a2d8d55f 	{ ae_cvtp24a16x2.ll	aep5, a5, a5; ae_subq56	aeq0, aeq0, aeq2 }
     cc9:	fb36d523ef 	{ sub	a2, a3, a14; ae_subq56	aeq3, aeq2, aeq1 }
     cce:	3140f0        	srai	a4, a15, 16
     cd1:	e2179a624f 	{ ae_lp16f.xu	aep6, a2, a4; ae_mulafp24s.ll	aeq0, aep5, aep0 }
     cd6:	f9ff9a324f 	{ ae_lp16f.xu	aep3, a2, a4; ae_roundsp24q48sym	aep2, aeq3 }
     cdb:	f9aada524f 	{ ae_lp16f.xu	aep5, a2, a4; ae_subq56	aeq1, aeq1, aeq2 }
     ce0:	0a8084        	ae_cvtq48p24s.l	aeq2, aep0
     ce3:	01a9c4        	ae_addq56	aeq2, aeq2, aeq1
     ce6:	01ea74        	ae_mulfp24s.ll	aeq3, aep6, aep2
     ce9:	1b8c44        	ae_roundsp24q48sym	aep4, aeq0
     cec:	064924        	ae_negq56	aeq1, aeq1
     cef:	1bac74        	ae_roundsp24q48sym	aep7, aeq2
     cf2:	01bc34        	ae_mulafp24s.ll	aeq3, aep3, aep4
     cf5:	e3f7da724f 	{ ae_lp16f.xu	aep7, a2, a4; ae_mulafp24s.ll	aeq3, aep5, aep7 }
     cfa:	fbef80c12e 	{ addi	a2, a1, 12; ae_roundsp24q48sym	aep6, aeq1 }
     cff:	01fe34        	ae_mulafp24s.ll	aeq3, aep7, aep6
     d02:	1bbc04        	ae_roundsp24q48sym	aep0, aeq3
     d05:	003dc6        	j	e00 <intp_filter_16b+0x194>

00000d08 <intp_filter_16b+0x9c>:
     d08:	fcda51        	l32r	a5, 70 (2aaaaaaa <_end+0x2aaa95fa>)
     d0b:	018820        	slli	a8, a8, 30
     d0e:	360834        	ae_cvtq48a32s	aeq0, a8
     d11:	6159           	s32i.n	a5, a1, 24
     d13:	358054        	ae_slliq56	aeq2, aeq0, 1
     d16:	fd146e216f 	{ ae_lp24f.i	aep2, a1, 24; ae_movq56	aeq1, aeq2 }
     d1b:	ef4180017f 	{ movi	a7, 1; ae_mulsfp24s.ll	aeq2, aep0, aep2 }
     d20:	117720        	slli	a7, a7, 14
     d23:	fccfd1        	l32r	a13, 60 (55555555 <_end+0x555540a5>)
     d26:	f9f7fecdff 	{ ae_cvtq48a32s	aeq3, a13; ae_roundsp24q48sym	aep3, aeq2 }
     d2b:	fe0458977f 	{ ae_cvtp24a16x2.ll	aep1, a7, a7; ae_movq56	aeq2, aeq0 }
     d30:	e343c0cdcf 	{ movi	a12, 205; ae_mulafp24s.ll	aeq3, aep0, aep2 }
     d35:	e32380052f 	{ movi	a2, 5; ae_mulafp24s.ll	aeq2, aep0, aep1 }
     d3a:	ee2191f43f 	{ addx2	a15, a4, a3; ae_mulsfp24s.ll	aeq0, aep0, aep1 }
     d3f:	0109b4        	ae_mulsfp24s.ll	aeq1, aep0, aep1
     d42:	faf7fa801f 	{ ae_slliq56	aeq0, aeq0, 1; ae_roundsp24q48sym	aep5, aeq2 }
     d47:	1bbc44        	ae_roundsp24q48sym	aep4, aeq3
     d4a:	01d474        	ae_mulfp24s.ll	aeq2, aep5, aep4
     d4d:	1b8c14        	ae_roundsp24q48sym	aep1, aeq0
     d50:	1b9c64        	ae_roundsp24q48sym	aep6, aeq1
     d53:	013974        	ae_mulfp24s.ll	aeq1, aep3, aep1
     d56:	01be74        	ae_mulfp24s.ll	aeq3, aep3, aep6
     d59:	1bac34        	ae_roundsp24q48sym	aep3, aeq2
     d5c:	01e174        	ae_mulfp24s.ll	aeq2, aep6, aep1
     d5f:	010474        	ae_mulfp24s.ll	aeq0, aep0, aep4
     d62:	1bac74        	ae_roundsp24q48sym	aep7, aeq2
     d65:	01b074        	ae_mulfp24s.ll	aeq2, aep3, aep0
     d68:	1b9c44        	ae_roundsp24q48sym	aep4, aeq1
     d6b:	010d74        	ae_mulfp24s.ll	aeq1, aep0, aep5
     d6e:	1bbc04        	ae_roundsp24q48sym	aep0, aeq3
     d71:	018974        	ae_mulfp24s.ll	aeq3, aep0, aep1
     d74:	1bac54        	ae_roundsp24q48sym	aep5, aeq2
     d77:	01f574        	ae_mulfp24s.ll	aeq2, aep7, aep5
     d7a:	1b8c64        	ae_roundsp24q48sym	aep6, aeq0
     d7d:	1b9c74        	ae_roundsp24q48sym	aep7, aeq1
     d80:	014574        	ae_mulfp24s.ll	aeq0, aep4, aep5
     d83:	010d74        	ae_mulfp24s.ll	aeq1, aep0, aep5
     d86:	1bbc14        	ae_roundsp24q48sym	aep1, aeq3
     d89:	0cdc52        	addmi	a5, a12, 0xc00
     d8c:	eb65d8855f 	{ ae_cvtp24a16x2.ll	aep0, a5, a5; ae_mulfp24s.ll	aeq3, aep1, aep3 }
     d91:	1bac34        	ae_roundsp24q48sym	aep3, aeq2
     d94:	019674        	ae_mulfp24s.ll	aeq2, aep1, aep6
     d97:	fae7fa901f 	{ ae_slliq56	aeq0, aeq1, 1; ae_roundsp24q48sym	aep5, aeq0 }
     d9c:	0118c4        	ae_addq56	aeq0, aeq1, aeq0
     d9f:	01e4f0        	slli	a14, a4, 17
     da2:	011f74        	ae_mulfp24s.ll	aeq1, aep1, aep7
     da5:	112230        	slli	a2, a2, 13
     da8:	3160e0        	srai	a6, a14, 16
     dab:	fbf798f22f 	{ ae_cvtp24a16x2.ll	aep7, a2, a2; ae_roundsp24q48sym	aep6, aeq2 }
     db0:	f9e7bab01f 	{ ae_slliq56	aeq0, aeq3, 1; ae_roundsp24q48sym	aep2, aeq0 }
     db5:	01b074        	ae_mulfp24s.ll	aeq2, aep3, aep0
     db8:	606060        	neg	a6, a6
     dbb:	faef9a3f6f 	{ ae_lp16f.xu	aep3, a15, a6; ae_roundsp24q48sym	aep4, aeq1 }
     dc0:	015f74        	ae_mulfp24s.ll	aeq1, aep5, aep7
     dc3:	01f8c4        	ae_addq56	aeq3, aeq3, aeq0
     dc6:	eaf99a6f6f 	{ ae_lp16f.xu	aep6, a15, a6; ae_mulfp24s.ll	aeq0, aep6, aep7 }
     dcb:	1bac54        	ae_roundsp24q48sym	aep5, aeq2
     dce:	eaadba012f 	{ ae_sq56s.i	aeq0, a1, 16; ae_mulfp24s.ll	aeq0, aep3, aep5 }
     dd3:	fbefda3f6f 	{ ae_lp16f.xu	aep3, a15, a6; ae_roundsp24q48sym	aep7, aeq1 }
     dd8:	e2fb9a5f6f 	{ ae_lp16f.xu	aep5, a15, a6; ae_mulafp24s.ll	aeq0, aep6, aep7 }
     ddd:	ea11da6f6f 	{ ae_lp16f.xu	aep6, a15, a6; ae_mulfp24s.ll	aeq1, aep4, aep0 }
     de2:	faffbde12f 	{ ae_lq56.i	aeq3, a1, 16; ae_roundsp24q48sym	aep4, aeq3 }
     de7:	e24f9a1f6f 	{ ae_lp16f.xu	aep1, a15, a6; ae_mulafp24s.ll	aeq0, aep3, aep2 }
     dec:	015434        	ae_mulafp24s.ll	aeq0, aep5, aep4
     def:	1bbc74        	ae_roundsp24q48sym	aep7, aeq3
     df2:	016734        	ae_mulafp24s.ll	aeq0, aep6, aep7
     df5:	1b9c04        	ae_roundsp24q48sym	aep0, aeq1
     df8:	e20780c12e 	{ addi	a2, a1, 12; ae_mulafp24s.ll	aeq0, aep1, aep0 }
     dfd:	1b8c04        	ae_roundsp24q48sym	aep0, aeq0
     e00:	420204        	ae_sp16f.l.i	aep0, a2, 0
     e03:	069122        	l16si	a2, a1, 12
     e06:	f01d           	retw.n

00000e08 <intp_filter_32b>:
     e08:	006136        	entry	a1, 48
     e0b:	4278           	l32i.n	a7, a2, 16
     e0d:	051252        	l16ui	a5, a2, 10
     e10:	1124e0        	slli	a2, a4, 2
     e13:	11f7f0        	slli	a15, a7, 1
     e16:	31f9           	s32i.n	a15, a1, 12
     e18:	500134        	ae_lp24f.i	aep0, a1, 12
     e1b:	1b1526        	beqi	a5, 1, e3a <intp_filter_32b+0x32>
     e1e:	07b556        	bnez	a5, e9d <intp_filter_32b+0x95>
     e21:	1144d0        	slli	a4, a4, 3
     e24:	c03340        	sub	a3, a3, a4
     e27:	603324        	ae_lq32f.xu	aeq0, a3, a2
     e2a:	f8c0bc232f 	{ ae_lq32f.xu	aeq1, a3, a2; ae_mulsfq32sp24s.l	aeq0, aeq0, aep0 }
     e2f:	f4c380812e 	{ addi	a2, a1, 8; ae_mulafq32sp24s.l	aeq0, aeq1, aep0 }
     e34:	060834        	ae_roundsq32sym	aeq0, aeq0
     e37:	0017c6        	j	e9a <intp_filter_32b+0x92>

00000e3a <intp_filter_32b+0x32>:
     e3a:	140c           	movi.n	a4, 1
     e3c:	114430        	slli	a4, a4, 13
     e3f:	301444        	ae_cvtp24a16x2.ll	aep1, a4, a4
     e42:	ea05c0015f 	{ movi	a5, 1; ae_mulfp24s.ll	aeq1, aep1, aep0 }
     e47:	015520        	slli	a5, a5, 30
     e4a:	f8effec53f 	{ ae_cvtq48a32s	aeq0, a5; ae_roundsp24q48sym	aep1, aeq1 }
     e4f:	5e0c           	movi.n	a14, 5
     e51:	eb05ba801f 	{ ae_slliq56	aeq0, aeq0, 1; ae_mulfp24s.ll	aeq2, aep1, aep0 }
     e56:	114e30        	slli	a4, a14, 13
     e59:	11f2e0        	slli	a15, a2, 2
     e5c:	f8a2d8c44f 	{ ae_cvtp24a16x2.ll	aep4, a4, a4; ae_subq56	aeq0, aeq0, aeq2 }
     e61:	fb36d533ff 	{ sub	a3, a3, a15; ae_subq56	aeq3, aeq2, aeq1 }
     e66:	015ec4        	ae_subq56	aeq1, aeq1, aeq2
     e69:	0a8084        	ae_cvtq48p24s.l	aeq2, aep0
     e6c:	014034        	ae_mulafp24s.ll	aeq0, aep4, aep0
     e6f:	01a9c4        	ae_addq56	aeq2, aeq2, aeq1
     e72:	f9ffbc632f 	{ ae_lq32f.xu	aeq3, a3, a2; ae_roundsp24q48sym	aep2, aeq3 }
     e77:	064924        	ae_negq56	aeq1, aeq1
     e7a:	faf7fc432f 	{ ae_lq32f.xu	aeq2, a3, a2; ae_roundsp24q48sym	aep5, aeq2 }
     e7f:	08ade4        	ae_mulfq32sp24s.l	aeq3, aeq3, aep2
     e82:	1b8c74        	ae_roundsp24q48sym	aep7, aeq0
     e85:	fbefbc232f 	{ ae_lq32f.xu	aeq1, a3, a2; ae_roundsp24q48sym	aep6, aeq1 }
     e8a:	f7defc432f 	{ ae_lq32f.xu	aeq2, a3, a2; ae_mulafq32sp24s.l	aeq3, aeq2, aep7 }
     e8f:	f5d7c0812e 	{ addi	a2, a1, 8; ae_mulafq32sp24s.l	aeq3, aeq1, aep5 }
     e94:	08eba4        	ae_mulafq32sp24s.l	aeq3, aeq2, aep6
     e97:	063834        	ae_roundsq32sym	aeq0, aeq3
     e9a:	620204        	ae_sq32f.i	aeq0, a2, 0
     e9d:	2128           	l32i.n	a2, a1, 8
     e9f:	f01d           	retw.n

00000ea1 <intp_filter_32b+0x99>:
     ea1:	000000                                        ...

00000ea4 <__do_global_ctors_aux>:
     ea4:	004136        	entry	a1, 32
     ea7:	fc7331        	l32r	a3, 74 (13f4 <__CTOR_END__>)
     eaa:	fcc322        	addi	a2, a3, -4
     ead:	0228           	l32i.n	a2, a2, 0
     eaf:	f8c332        	addi	a3, a3, -8
     eb2:	0a0226        	beqi	a2, -1, ec0 <__do_global_ctors_aux+0x1c>

00000eb5 <__do_global_ctors_aux+0x11>:
     eb5:	0002e0        	callx8	a2
     eb8:	0328           	l32i.n	a2, a3, 0
     eba:	fcc332        	addi	a3, a3, -4
     ebd:	f40266        	bnei	a2, -1, eb5 <__do_global_ctors_aux+0x11>
     ec0:	f01d           	retw.n

00000ec2 <__do_global_ctors_aux+0x1e>:
     ec2:	00000000                                 ......

00000ec8 <memset>:
     ec8:	004136        	entry	a1, 32
     ecb:	025d           	mov.n	a5, a2
     ecd:	12bc           	beqz.n	a2, f02 <memset+0x3a>
     ecf:	f4ac           	beqz.n	a4, f02 <memset+0x3a>
     ed1:	246040        	extui	a6, a4, 0, 3
     ed4:	052d           	mov.n	a2, a5
     ed6:	414340        	srli	a4, a4, 3
     ed9:	049676        	loopnez	a6, ee1 <memset+0x19>
     edc:	004232        	s8i	a3, a2, 0
     edf:	221b           	addi.n	a2, a2, 1

00000ee1 <memset+0x19>:
     ee1:	d49c           	beqz.n	a4, f02 <memset+0x3a>
     ee3:	f03d           	nop.n
     ee5:	199476        	loopnez	a4, f02 <memset+0x3a>
     ee8:	004232        	s8i	a3, a2, 0
     eeb:	074232        	s8i	a3, a2, 7
     eee:	064232        	s8i	a3, a2, 6
     ef1:	054232        	s8i	a3, a2, 5
     ef4:	014232        	s8i	a3, a2, 1
     ef7:	044232        	s8i	a3, a2, 4
     efa:	034232        	s8i	a3, a2, 3
     efd:	024232        	s8i	a3, a2, 2
     f00:	228b           	addi.n	a2, a2, 8

00000f02 <memset+0x3a>:
     f02:	052d           	mov.n	a2, a5
     f04:	f01d           	retw.n

00000f06 <memset+0x3e>:
	...

00000f08 <__udivdi3>:
     f08:	004136        	entry	a1, 32
     f0b:	036d           	mov.n	a6, a3
     f0d:	027d           	mov.n	a7, a2
     f0f:	0b5516        	beqz	a5, fc8 <__udivdi3+0xc0>
     f12:	030c           	movi.n	a3, 0
     f14:	020c           	movi.n	a2, 0
     f16:	02b657        	bgeu	a6, a5, f1c <__udivdi3+0x14>
     f19:	002a46        	j	fc6 <__udivdi3+0xbe>
     f1c:	40f580        	nsau	a8, a5
     f1f:	1b9816        	beqz	a8, 10dc <__udivdi3+0x1d4>
     f22:	022c           	movi.n	a2, 32
     f24:	401800        	ssl	a8
     f27:	c0b280        	sub	a11, a2, a8
     f2a:	a1e500        	sll	a14, a5
     f2d:	400b00        	ssr	a11
     f30:	91f040        	srl	a15, a4
     f33:	401800        	ssl	a8
     f36:	202fe0        	or	a2, a15, a14
     f39:	a14400        	sll	a4, a4
     f3c:	400b00        	ssr	a11
     f3f:	91d060        	srl	a13, a6
     f42:	401800        	ssl	a8
     f45:	f5a020        	extui	a10, a2, 16, 16
     f48:	a16600        	sll	a6, a6
     f4b:	400b00        	ssr	a11
     f4e:	c2bda0        	quou	a11, a13, a10
     f51:	91c070        	srl	a12, a7
     f54:	82eba0        	mull	a14, a11, a10
     f57:	205c60        	or	a5, a12, a6
     f5a:	929d           	ae_zext16	a9, a2
     f5c:	c0fde0        	sub	a15, a13, a14
     f5f:	f5d050        	extui	a13, a5, 16, 16
     f62:	82cb90        	mull	a12, a11, a9
     f65:	0bffd0        	depbits	a13, a15, 16, 16
     f68:	0b6d           	mov.n	a6, a11
     f6a:	401800        	ssl	a8
     f6d:	10bdc7        	bgeu	a13, a12, f81 <__udivdi3+0x79>
     f70:	dd2a           	add.n	a13, a13, a2
     f72:	ffcb62        	addi	a6, a11, -1
     f75:	083d27        	bltu	a13, a2, f81 <__udivdi3+0x79>
     f78:	05bdc7        	bgeu	a13, a12, f81 <__udivdi3+0x79>
     f7b:	fecb62        	addi	a6, a11, -2
     f7e:	80dd20        	add	a13, a13, a2

00000f81 <__udivdi3+0x79>:
     f81:	c0cdc0        	sub	a12, a13, a12
     f84:	c2bca0        	quou	a11, a12, a10
     f87:	82aba0        	mull	a10, a11, a10
     f8a:	828b90        	mull	a8, a11, a9
     f8d:	c0fca0        	sub	a15, a12, a10
     f90:	0bff50        	depbits	a5, a15, 16, 16
     f93:	0b9d           	mov.n	a9, a11
     f95:	10b587        	bgeu	a5, a8, fa9 <__udivdi3+0xa1>
     f98:	552a           	add.n	a5, a5, a2
     f9a:	ffcb92        	addi	a9, a11, -1
     f9d:	083527        	bltu	a5, a2, fa9 <__udivdi3+0xa1>
     fa0:	05b587        	bgeu	a5, a8, fa9 <__udivdi3+0xa1>
     fa3:	fecb92        	addi	a9, a11, -2
     fa6:	805520        	add	a5, a5, a2
     fa9:	112600        	slli	a2, a6, 16
     fac:	202920        	or	a2, a9, a2
     faf:	a26240        	muluh	a6, a2, a4
     fb2:	c05580        	sub	a5, a5, a8
     fb5:	0b3567        	bltu	a5, a6, fc4 <__udivdi3+0xbc>
     fb8:	824240        	mull	a4, a2, a4
     fbb:	a17700        	sll	a7, a7
     fbe:	04b747        	bgeu	a7, a4, fc6 <__udivdi3+0xbe>
     fc1:	019567        	bne	a5, a6, fc6 <__udivdi3+0xbe>
     fc4:	220b           	addi.n	a2, a2, -1
     fc6:	f01d           	retw.n

00000fc8 <__udivdi3+0xc0>:
     fc8:	40f430        	nsau	a3, a4
     fcb:	7eb647        	bgeu	a6, a4, 104d <__udivdi3+0x145>
     fce:	b39c           	beqz.n	a3, fed <__udivdi3+0xe5>
     fd0:	022c           	movi.n	a2, 32
     fd2:	401300        	ssl	a3
     fd5:	c02230        	sub	a2, a2, a3
     fd8:	a14400        	sll	a4, a4
     fdb:	a15600        	sll	a5, a6
     fde:	400200        	ssr	a2
     fe1:	912070        	srl	a2, a7
     fe4:	401300        	ssl	a3
     fe7:	206250        	or	a6, a2, a5
     fea:	a17700        	sll	a7, a7
     fed:	f55040        	extui	a5, a4, 16, 16
     ff0:	c28650        	quou	a8, a6, a5
     ff3:	822850        	mull	a2, a8, a5
     ff6:	943d           	ae_zext16	a3, a4
     ff8:	c02620        	sub	a2, a6, a2
     ffb:	f59070        	extui	a9, a7, 16, 16
     ffe:	826830        	mull	a6, a8, a3
    1001:	0bf290        	depbits	a9, a2, 16, 16
    1004:	082d           	mov.n	a2, a8
    1006:	0fb967        	bgeu	a9, a6, 1019 <__udivdi3+0x111>
    1009:	994a           	add.n	a9, a9, a4
    100b:	280b           	addi.n	a2, a8, -1
    100d:	083947        	bltu	a9, a4, 1019 <__udivdi3+0x111>
    1010:	05b967        	bgeu	a9, a6, 1019 <__udivdi3+0x111>
    1013:	fec822        	addi	a2, a8, -2
    1016:	809940        	add	a9, a9, a4
    1019:	c08960        	sub	a8, a9, a6
    101c:	c26850        	quou	a6, a8, a5
    101f:	825650        	mull	a5, a6, a5
    1022:	823630        	mull	a3, a6, a3
    1025:	c05850        	sub	a5, a8, a5
    1028:	0bf570        	depbits	a7, a5, 16, 16
    102b:	11b737        	bgeu	a7, a3, 1040 <__udivdi3+0x138>
    102e:	574a           	add.n	a5, a7, a4
    1030:	623530        	saltu	a3, a5, a3
    1033:	ff7c           	movi.n	a15, -1
    1035:	624540        	saltu	a4, a5, a4
    1038:	c03f30        	sub	a3, a15, a3
    103b:	933f40        	movnez	a3, a15, a4
    103e:	636a           	add.n	a6, a3, a6
    1040:	112200        	slli	a2, a2, 16
    1043:	202620        	or	a2, a6, a2
    1046:	030c           	movi.n	a3, 0
    1048:	f01d           	retw.n

0000104a <__udivdi3+0x142>:
    104a:	000000                                        ...

0000104d <__udivdi3+0x145>:
    104d:	09c316        	beqz	a3, 10ed <__udivdi3+0x1e5>
    1050:	022c           	movi.n	a2, 32
    1052:	401300        	ssl	a3
    1055:	c09230        	sub	a9, a2, a3
    1058:	a14400        	sll	a4, a4
    105b:	400900        	ssr	a9
    105e:	91a060        	srl	a10, a6
    1061:	401300        	ssl	a3
    1064:	f52040        	extui	a2, a4, 16, 16
    1067:	e57c           	movi.n	a5, -2
    1069:	a1e600        	sll	a14, a6
    106c:	400900        	ssr	a9
    106f:	c29a20        	quou	a9, a10, a2
    1072:	82b920        	mull	a11, a9, a2
    1075:	f45050        	extui	a5, a5, 0, 16
    1078:	91f070        	srl	a15, a7
    107b:	108450        	and	a8, a4, a5
    107e:	205fe0        	or	a5, a15, a14
    1081:	c0bab0        	sub	a11, a10, a11
    1084:	f5a050        	extui	a10, a5, 16, 16
    1087:	826980        	mull	a6, a9, a8
    108a:	0bfba0        	depbits	a10, a11, 16, 16
    108d:	401300        	ssl	a3
    1090:	093d           	mov.n	a3, a9
    1092:	0eba67        	bgeu	a10, a6, 10a4 <__udivdi3+0x19c>
    1095:	aa4a           	add.n	a10, a10, a4
    1097:	390b           	addi.n	a3, a9, -1
    1099:	073a47        	bltu	a10, a4, 10a4 <__udivdi3+0x19c>
    109c:	04ba67        	bgeu	a10, a6, 10a4 <__udivdi3+0x19c>
    109f:	fec932        	addi	a3, a9, -2
    10a2:	aa4a           	add.n	a10, a10, a4
    10a4:	c0aa60        	sub	a10, a10, a6
    10a7:	c29a20        	quou	a9, a10, a2
    10aa:	82b920        	mull	a11, a9, a2
    10ad:	826980        	mull	a6, a9, a8
    10b0:	c0fab0        	sub	a15, a10, a11
    10b3:	0bff50        	depbits	a5, a15, 16, 16
    10b6:	098d           	mov.n	a8, a9
    10b8:	10b567        	bgeu	a5, a6, 10cc <__udivdi3+0x1c4>
    10bb:	554a           	add.n	a5, a5, a4
    10bd:	ffc982        	addi	a8, a9, -1
    10c0:	083547        	bltu	a5, a4, 10cc <__udivdi3+0x1c4>
    10c3:	05b567        	bgeu	a5, a6, 10cc <__udivdi3+0x1c4>
    10c6:	fec982        	addi	a8, a9, -2
    10c9:	805540        	add	a5, a5, a4
    10cc:	113300        	slli	a3, a3, 16
    10cf:	a17700        	sll	a7, a7
    10d2:	c05560        	sub	a5, a5, a6
    10d5:	203830        	or	a3, a8, a3
    10d8:	000646        	j	10f5 <__udivdi3+0x1ed>

000010db <__udivdi3+0x1d3>:
	...

000010dc <__udivdi3+0x1d4>:
    10dc:	624740        	saltu	a4, a7, a4
    10df:	1f0c           	movi.n	a15, 1
    10e1:	622560        	saltu	a2, a5, a6
    10e4:	3044f0        	xor	a4, a4, a15
    10e7:	202420        	or	a2, a4, a2
    10ea:	f01d           	retw.n

000010ec <__udivdi3+0x1e4>:
	...

000010ed <__udivdi3+0x1e5>:
    10ed:	c05640        	sub	a5, a6, a4
    10f0:	f52040        	extui	a2, a4, 16, 16
    10f3:	130c           	movi.n	a3, 1
    10f5:	c28520        	quou	a8, a5, a2
    10f8:	82a820        	mull	a10, a8, a2
    10fb:	946d           	ae_zext16	a6, a4
    10fd:	c0f5a0        	sub	a15, a5, a10
    1100:	f59070        	extui	a9, a7, 16, 16
    1103:	82a860        	mull	a10, a8, a6
    1106:	0bff90        	depbits	a9, a15, 16, 16
    1109:	085d           	mov.n	a5, a8
    110b:	0eb9a7        	bgeu	a9, a10, 111d <__udivdi3+0x215>
    110e:	994a           	add.n	a9, a9, a4
    1110:	580b           	addi.n	a5, a8, -1
    1112:	073947        	bltu	a9, a4, 111d <__udivdi3+0x215>
    1115:	04b9a7        	bgeu	a9, a10, 111d <__udivdi3+0x215>
    1118:	fec852        	addi	a5, a8, -2
    111b:	994a           	add.n	a9, a9, a4
    111d:	c099a0        	sub	a9, a9, a10
    1120:	c28920        	quou	a8, a9, a2
    1123:	82e820        	mull	a14, a8, a2
    1126:	822860        	mull	a2, a8, a6
    1129:	c0f9e0        	sub	a15, a9, a14
    112c:	0bff70        	depbits	a7, a15, 16, 16
    112f:	11b727        	bgeu	a7, a2, 1144 <__udivdi3+0x23c>
    1132:	674a           	add.n	a6, a7, a4
    1134:	622620        	saltu	a2, a6, a2
    1137:	ff7c           	movi.n	a15, -1
    1139:	624640        	saltu	a4, a6, a4
    113c:	c02f20        	sub	a2, a15, a2
    113f:	932f40        	movnez	a2, a15, a4
    1142:	828a           	add.n	a8, a2, a8
    1144:	112500        	slli	a2, a5, 16
    1147:	202820        	or	a2, a8, a2
    114a:	f01d           	retw.n

0000114c <_fini>:
    114c:	008136        	entry	a1, 64
    114f:	fbca81        	l32r	a8, 78 (94 <__do_global_dtors_aux>)
    1152:	f03d           	nop.n
    1154:	0008e0        	callx8	a8

00001157 <_fini+0xb>:
    1157:	f01d           	retw.n
