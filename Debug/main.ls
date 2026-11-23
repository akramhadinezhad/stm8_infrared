   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  14                     	bsct
  15  0000               _remoteReceived:
  16  0000 00000000      	dc.l	0
  17  0004               _currentTime:
  18  0004 0000          	dc.w	0
  19  0006               _previousTime:
  20  0006 0000          	dc.w	0
  21  0008               _Delta:
  22  0008 0000          	dc.w	0
  23  000a               _state:
  24  000a 00            	dc.b	0
  25  000b               _bitIndex:
  26  000b 00            	dc.b	0
  27  000c               _frameReady:
  28  000c 00            	dc.b	0
  29  000d               _addr:
  30  000d 00            	dc.b	0
  31  000e               _addrInv:
  32  000e 00            	dc.b	0
  33  000f               _cmd:
  34  000f 00            	dc.b	0
  35  0010               _cmdInv:
  36  0010 00            	dc.b	0
  37  0011               _trueAddress:
  38  0011 00            	dc.b	0
  39  0012               _trueCommand:
  40  0012 00            	dc.b	0
  41  0013               _percent:
  42  0013 32            	dc.b	50
 125                     ; 22 void main(void)
 125                     ; 23 {
 127                     	switch	.text
 128  0000               _main:
 130  0000 5207          	subw	sp,#7
 131       00000007      OFST:	set	7
 134                     ; 27 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);/* Clock divider to HSI/1 */
 136  0002 4f            	clr	a
 137  0003 cd0000        	call	_CLK_HSIPrescalerConfig
 139                     ; 28 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1,ENABLE); /*timer1 clock enable*/
 141  0006 ae0701        	ldw	x,#1793
 142  0009 cd0000        	call	_CLK_PeripheralClockConfig
 144                     ; 29 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI,ENABLE); /*SPI clock enable*/
 146  000c ae0101        	ldw	x,#257
 147  000f cd0000        	call	_CLK_PeripheralClockConfig
 149                     ; 31 	GPIO_DeInit(GPIOC);
 151  0012 ae500a        	ldw	x,#20490
 152  0015 cd0000        	call	_GPIO_DeInit
 154                     ; 32 	GPIO_Init(GPIOC,GPIO_PIN_3,GPIO_MODE_IN_PU_NO_IT); /*TIMER1 pin*/
 156  0018 4b40          	push	#64
 157  001a 4b08          	push	#8
 158  001c ae500a        	ldw	x,#20490
 159  001f cd0000        	call	_GPIO_Init
 161  0022 85            	popw	x
 162                     ; 33 	GPIO_Init(GPIOC,GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_FAST); /*SPI clock pin*/
 164  0023 4be0          	push	#224
 165  0025 4b20          	push	#32
 166  0027 ae500a        	ldw	x,#20490
 167  002a cd0000        	call	_GPIO_Init
 169  002d 85            	popw	x
 170                     ; 34 	GPIO_Init(GPIOC,GPIO_PIN_6,GPIO_MODE_OUT_PP_HIGH_FAST); /*SPI mosi pin*/
 172  002e 4bf0          	push	#240
 173  0030 4b40          	push	#64
 174  0032 ae500a        	ldw	x,#20490
 175  0035 cd0000        	call	_GPIO_Init
 177  0038 85            	popw	x
 178                     ; 36 	TIM1_TimeBaseInit(15,TIM1_COUNTERMODE_UP,65535,0);
 180  0039 4b00          	push	#0
 181  003b aeffff        	ldw	x,#65535
 182  003e 89            	pushw	x
 183  003f 4b00          	push	#0
 184  0041 ae000f        	ldw	x,#15
 185  0044 cd0000        	call	_TIM1_TimeBaseInit
 187  0047 5b04          	addw	sp,#4
 188                     ; 37 	TIM1_ICInit(TIM1_CHANNEL_3,
 188                     ; 38 							TIM1_ICPOLARITY_FALLING,
 188                     ; 39 							TIM1_ICSELECTION_DIRECTTI,
 188                     ; 40 							TIM1_ICPSC_DIV1,
 188                     ; 41 							0x00);	/* TIMER1 configuration */
 190  0049 4b00          	push	#0
 191  004b 4b00          	push	#0
 192  004d 4b01          	push	#1
 193  004f ae0201        	ldw	x,#513
 194  0052 cd0000        	call	_TIM1_ICInit
 196  0055 5b03          	addw	sp,#3
 197                     ; 42 	TIM1_ITConfig(TIM1_IT_CC3,ENABLE);/* Enable interrupt */
 199  0057 ae0801        	ldw	x,#2049
 200  005a cd0000        	call	_TIM1_ITConfig
 202                     ; 43 	TIM1_Cmd(ENABLE); /* Enable TIM1 */
 204  005d a601          	ld	a,#1
 205  005f cd0000        	call	_TIM1_Cmd
 207                     ; 44 	TIM1_CCxCmd(TIM1_CHANNEL_3,ENABLE);/* Enable TIM1 CHANNEL3 */
 209  0062 ae0201        	ldw	x,#513
 210  0065 cd0000        	call	_TIM1_CCxCmd
 212                     ; 46 	SPI_DeInit();
 214  0068 cd0000        	call	_SPI_DeInit
 216                     ; 47 	SPI_Init(SPI_FIRSTBIT_MSB,
 216                     ; 48 					SPI_BAUDRATEPRESCALER_2,
 216                     ; 49 					SPI_MODE_MASTER,
 216                     ; 50 					SPI_CLOCKPOLARITY_LOW,
 216                     ; 51 					SPI_CLOCKPHASE_1EDGE,
 216                     ; 52 					SPI_DATADIRECTION_1LINE_TX,
 216                     ; 53 					SPI_NSS_SOFT,
 216                     ; 54 					0x00); /* SPI configuration */	
 218  006b 4b00          	push	#0
 219  006d 4b02          	push	#2
 220  006f 4bc0          	push	#192
 221  0071 4b00          	push	#0
 222  0073 4b00          	push	#0
 223  0075 4b04          	push	#4
 224  0077 5f            	clrw	x
 225  0078 cd0000        	call	_SPI_Init
 227  007b 5b06          	addw	sp,#6
 228                     ; 55 	SPI_Cmd(ENABLE);	/* Enable SPI */			
 230  007d a601          	ld	a,#1
 231  007f cd0000        	call	_SPI_Cmd
 233                     ; 56 	enableInterrupts(); /* Enable global interrupt */
 236  0082 9a            rim
 238  0083               L73:
 239                     ; 58 	if(frameReady==1){
 241  0083 b60c          	ld	a,_frameReady
 242  0085 a101          	cp	a,#1
 243  0087 26fa          	jrne	L73
 244                     ; 59 		frameReady=0;
 246  0089 3f0c          	clr	_frameReady
 247                     ; 60 		temp=remoteReceived;
 249  008b be02          	ldw	x,_remoteReceived+2
 250  008d 1f06          	ldw	(OFST-1,sp),x
 251  008f be00          	ldw	x,_remoteReceived
 252  0091 1f04          	ldw	(OFST-3,sp),x
 254                     ; 61 		trueAddress=0;
 256  0093 3f11          	clr	_trueAddress
 257                     ; 62 		trueCommand=0;
 259  0095 3f12          	clr	_trueCommand
 260                     ; 64 		addr=(temp>>24)&0xFF;
 262  0097 7b04          	ld	a,(OFST-3,sp)
 263  0099 b70d          	ld	_addr,a
 264                     ; 65 		addrInv=(temp>>16)&0xFF;
 266  009b 7b05          	ld	a,(OFST-2,sp)
 267  009d a4ff          	and	a,#255
 268  009f b70e          	ld	_addrInv,a
 269                     ; 66 		cmd=(temp>>8)&0xFF;
 271  00a1 7b06          	ld	a,(OFST-1,sp)
 272  00a3 a4ff          	and	a,#255
 273  00a5 b70f          	ld	_cmd,a
 274                     ; 67 		cmdInv=(temp)&0xFF;
 276  00a7 7b07          	ld	a,(OFST+0,sp)
 277  00a9 a4ff          	and	a,#255
 278  00ab b710          	ld	_cmdInv,a
 279                     ; 69 		if((addr^addrInv)==0xFF)trueAddress=1;
 281  00ad b60d          	ld	a,_addr
 282  00af b80e          	xor	a,_addrInv
 283  00b1 a1ff          	cp	a,#255
 284  00b3 2604          	jrne	L54
 287  00b5 35010011      	mov	_trueAddress,#1
 288  00b9               L54:
 289                     ; 70 		if((cmd^cmdInv)==0xFF)trueCommand=1;
 291  00b9 b60f          	ld	a,_cmd
 292  00bb b810          	xor	a,_cmdInv
 293  00bd a1ff          	cp	a,#255
 294  00bf 2604          	jrne	L74
 297  00c1 35010012      	mov	_trueCommand,#1
 298  00c5               L74:
 299                     ; 71 		if(trueAddress && trueCommand){
 301  00c5 3d11          	tnz	_trueAddress
 302  00c7 27ba          	jreq	L73
 304  00c9 3d12          	tnz	_trueCommand
 305  00cb 27b6          	jreq	L73
 306                     ; 72 			if(cmd==0x68){//off
 308  00cd b60f          	ld	a,_cmd
 309  00cf a168          	cp	a,#104
 310  00d1 260e          	jrne	L35
 311                     ; 73 				currentColor=0x00000000;
 313  00d3 ae0000        	ldw	x,#0
 314  00d6 bf02          	ldw	_currentColor+2,x
 315  00d8 ae0000        	ldw	x,#0
 316  00db bf00          	ldw	_currentColor,x
 318  00dd acbf01bf      	jpf	L55
 319  00e1               L35:
 320                     ; 75 			else if(cmd==0xE0){//decrease
 322  00e1 b60f          	ld	a,_cmd
 323  00e3 a1e0          	cp	a,#224
 324  00e5 2618          	jrne	L75
 325                     ; 76 				if(percent>10) percent-=10;
 327  00e7 b613          	ld	a,_percent
 328  00e9 a10b          	cp	a,#11
 329  00eb 250a          	jrult	L16
 332  00ed b613          	ld	a,_percent
 333  00ef a00a          	sub	a,#10
 334  00f1 b713          	ld	_percent,a
 336  00f3 acbf01bf      	jpf	L55
 337  00f7               L16:
 338                     ; 77 				else percent=5;
 340  00f7 35050013      	mov	_percent,#5
 341  00fb acbf01bf      	jpf	L55
 342  00ff               L75:
 343                     ; 79 			else if(cmd==0xA8){//increase
 345  00ff b60f          	ld	a,_cmd
 346  0101 a1a8          	cp	a,#168
 347  0103 2618          	jrne	L76
 348                     ; 80 				if(percent<=90) percent+=10;
 350  0105 b613          	ld	a,_percent
 351  0107 a15b          	cp	a,#91
 352  0109 240a          	jruge	L17
 355  010b b613          	ld	a,_percent
 356  010d ab0a          	add	a,#10
 357  010f b713          	ld	_percent,a
 359  0111 acbf01bf      	jpf	L55
 360  0115               L17:
 361                     ; 81 				else percent=100;
 363  0115 35640013      	mov	_percent,#100
 364  0119 acbf01bf      	jpf	L55
 365  011d               L76:
 366                     ; 83 			else if(cmd==0x30){//red color
 368  011d b60f          	ld	a,_cmd
 369  011f a130          	cp	a,#48
 370  0121 260e          	jrne	L77
 371                     ; 84 				currentColor=0x00FF0000;
 373  0123 ae0000        	ldw	x,#0
 374  0126 bf02          	ldw	_currentColor+2,x
 375  0128 ae00ff        	ldw	x,#255
 376  012b bf00          	ldw	_currentColor,x
 378  012d acbf01bf      	jpf	L55
 379  0131               L77:
 380                     ; 86 			else if(cmd==0x18){//green color
 382  0131 b60f          	ld	a,_cmd
 383  0133 a118          	cp	a,#24
 384  0135 260c          	jrne	L301
 385                     ; 87 				currentColor=0x0000FF00;
 387  0137 aeff00        	ldw	x,#65280
 388  013a bf02          	ldw	_currentColor+2,x
 389  013c ae0000        	ldw	x,#0
 390  013f bf00          	ldw	_currentColor,x
 392  0141 207c          	jra	L55
 393  0143               L301:
 394                     ; 89 			else if(cmd==0x7A){//blue color
 396  0143 b60f          	ld	a,_cmd
 397  0145 a17a          	cp	a,#122
 398  0147 260c          	jrne	L701
 399                     ; 90 				currentColor=0x000000FF;
 401  0149 ae00ff        	ldw	x,#255
 402  014c bf02          	ldw	_currentColor+2,x
 403  014e ae0000        	ldw	x,#0
 404  0151 bf00          	ldw	_currentColor,x
 406  0153 206a          	jra	L55
 407  0155               L701:
 408                     ; 92 			else if(cmd==0x10){//white color
 410  0155 b60f          	ld	a,_cmd
 411  0157 a110          	cp	a,#16
 412  0159 260c          	jrne	L311
 413                     ; 93 				currentColor=0x00FFFFFF;
 415  015b aeffff        	ldw	x,#65535
 416  015e bf02          	ldw	_currentColor+2,x
 417  0160 ae00ff        	ldw	x,#255
 418  0163 bf00          	ldw	_currentColor,x
 420  0165 2058          	jra	L55
 421  0167               L311:
 422                     ; 95 			else if(cmd==0x38){//yellow color
 424  0167 b60f          	ld	a,_cmd
 425  0169 a138          	cp	a,#56
 426  016b 260c          	jrne	L711
 427                     ; 96 				currentColor=0x00FFFF00;
 429  016d aeff00        	ldw	x,#65280
 430  0170 bf02          	ldw	_currentColor+2,x
 431  0172 ae00ff        	ldw	x,#255
 432  0175 bf00          	ldw	_currentColor,x
 434  0177 2046          	jra	L55
 435  0179               L711:
 436                     ; 98 			else if(cmd==0x5A){//purple color
 438  0179 b60f          	ld	a,_cmd
 439  017b a15a          	cp	a,#90
 440  017d 260c          	jrne	L321
 441                     ; 99 				currentColor=0x008000FF;
 443  017f ae00ff        	ldw	x,#255
 444  0182 bf02          	ldw	_currentColor+2,x
 445  0184 ae0080        	ldw	x,#128
 446  0187 bf00          	ldw	_currentColor,x
 448  0189 2034          	jra	L55
 449  018b               L321:
 450                     ; 101 			else if(cmd==0x42){//cyan color
 452  018b b60f          	ld	a,_cmd
 453  018d a142          	cp	a,#66
 454  018f 260c          	jrne	L721
 455                     ; 102 				currentColor=0x0000FFFF;
 457  0191 aeffff        	ldw	x,#65535
 458  0194 bf02          	ldw	_currentColor+2,x
 459  0196 ae0000        	ldw	x,#0
 460  0199 bf00          	ldw	_currentColor,x
 462  019b 2022          	jra	L55
 463  019d               L721:
 464                     ; 104 			else if(cmd==0x4A){//orange color
 466  019d b60f          	ld	a,_cmd
 467  019f a14a          	cp	a,#74
 468  01a1 260c          	jrne	L331
 469                     ; 105 				currentColor=0x00FF2000;
 471  01a3 ae2000        	ldw	x,#8192
 472  01a6 bf02          	ldw	_currentColor+2,x
 473  01a8 ae00ff        	ldw	x,#255
 474  01ab bf00          	ldw	_currentColor,x
 476  01ad 2010          	jra	L55
 477  01af               L331:
 478                     ; 107 			else if(cmd==0x52){//pink color
 480  01af b60f          	ld	a,_cmd
 481  01b1 a152          	cp	a,#82
 482  01b3 260a          	jrne	L55
 483                     ; 108 				currentColor=0x00FF1493;
 485  01b5 ae1493        	ldw	x,#5267
 486  01b8 bf02          	ldw	_currentColor+2,x
 487  01ba ae00ff        	ldw	x,#255
 488  01bd bf00          	ldw	_currentColor,x
 489  01bf               L55:
 490                     ; 110 			if(cmd==0x30||cmd==0x18||cmd==0x7A||//1:red,2:green ,3:blue
 490                     ; 111 					cmd==0x10||cmd==0x38||cmd==0x5A||//4:white,5:yellow ,6:purple
 490                     ; 112 					cmd==0x42||cmd==0x4A||cmd==0x52||//7:greenblue,8:lemon ,9:pink
 490                     ; 113 					cmd==0xE0||cmd==0xA8||cmd==0x68){//-:decrease,+:increase,0:off
 492  01bf b60f          	ld	a,_cmd
 493  01c1 a130          	cp	a,#48
 494  01c3 2745          	jreq	L341
 496  01c5 b60f          	ld	a,_cmd
 497  01c7 a118          	cp	a,#24
 498  01c9 273f          	jreq	L341
 500  01cb b60f          	ld	a,_cmd
 501  01cd a17a          	cp	a,#122
 502  01cf 2739          	jreq	L341
 504  01d1 b60f          	ld	a,_cmd
 505  01d3 a110          	cp	a,#16
 506  01d5 2733          	jreq	L341
 508  01d7 b60f          	ld	a,_cmd
 509  01d9 a138          	cp	a,#56
 510  01db 272d          	jreq	L341
 512  01dd b60f          	ld	a,_cmd
 513  01df a15a          	cp	a,#90
 514  01e1 2727          	jreq	L341
 516  01e3 b60f          	ld	a,_cmd
 517  01e5 a142          	cp	a,#66
 518  01e7 2721          	jreq	L341
 520  01e9 b60f          	ld	a,_cmd
 521  01eb a14a          	cp	a,#74
 522  01ed 271b          	jreq	L341
 524  01ef b60f          	ld	a,_cmd
 525  01f1 a152          	cp	a,#82
 526  01f3 2715          	jreq	L341
 528  01f5 b60f          	ld	a,_cmd
 529  01f7 a1e0          	cp	a,#224
 530  01f9 270f          	jreq	L341
 532  01fb b60f          	ld	a,_cmd
 533  01fd a1a8          	cp	a,#168
 534  01ff 2709          	jreq	L341
 536  0201 b60f          	ld	a,_cmd
 537  0203 a168          	cp	a,#104
 538  0205 2703          	jreq	L6
 539  0207 cc0083        	jp	L73
 540  020a               L6:
 541  020a               L341:
 542                     ; 114 			  for(i=0;i<ledNumber;i++){
 544  020a 0f01          	clr	(OFST-6,sp)
 546  020c               L171:
 547                     ; 115 					ws2812SendOneLed(currentColor,percent);
 549  020c 3b0013        	push	_percent
 550  020f be02          	ldw	x,_currentColor+2
 551  0211 89            	pushw	x
 552  0212 be00          	ldw	x,_currentColor
 553  0214 89            	pushw	x
 554  0215 ad50          	call	_ws2812SendOneLed
 556  0217 5b05          	addw	sp,#5
 557                     ; 114 			  for(i=0;i<ledNumber;i++){
 559  0219 0c01          	inc	(OFST-6,sp)
 563  021b 7b01          	ld	a,(OFST-6,sp)
 564  021d a10c          	cp	a,#12
 565  021f 25eb          	jrult	L171
 566                     ; 117 				ws2812SendReset(RES);
 568  0221 a637          	ld	a,#55
 569  0223 cd02ba        	call	_ws2812SendReset
 571                     ; 118 				for(d=0;d<10000;d++);
 573  0226 5f            	clrw	x
 574  0227 1f02          	ldw	(OFST-5,sp),x
 577  0229 2007          	jra	L302
 578  022b               L771:
 582  022b 1e02          	ldw	x,(OFST-5,sp)
 583  022d 1c0001        	addw	x,#1
 584  0230 1f02          	ldw	(OFST-5,sp),x
 586  0232               L302:
 589  0232 1e02          	ldw	x,(OFST-5,sp)
 590  0234 a32710        	cpw	x,#10000
 591  0237 25f2          	jrult	L771
 592  0239 ac830083      	jpf	L73
 637                     ; 125 void ws2812SendByte(uint8_t data){
 638                     	switch	.text
 639  023d               _ws2812SendByte:
 641  023d 88            	push	a
 642  023e 88            	push	a
 643       00000001      OFST:	set	1
 646                     ; 127 	for(j=0;j<8;j++){
 648  023f 0f01          	clr	(OFST+0,sp)
 650  0241               L142:
 651                     ; 128 		while(SPI_GetFlagStatus(SPI_FLAG_TXE)==RESET);
 653  0241 a602          	ld	a,#2
 654  0243 cd0000        	call	_SPI_GetFlagStatus
 656  0246 4d            	tnz	a
 657  0247 27f8          	jreq	L142
 658                     ; 129 		if(data & 0x80){
 660  0249 7b02          	ld	a,(OFST+1,sp)
 661  024b a580          	bcp	a,#128
 662  024d 2707          	jreq	L542
 663                     ; 130 			SPI_SendData(0x7C);
 665  024f a67c          	ld	a,#124
 666  0251 cd0000        	call	_SPI_SendData
 669  0254 2005          	jra	L742
 670  0256               L542:
 671                     ; 133 			SPI_SendData(0x70);		
 673  0256 a670          	ld	a,#112
 674  0258 cd0000        	call	_SPI_SendData
 676  025b               L742:
 677                     ; 135 		data<<=1;
 679  025b 0802          	sll	(OFST+1,sp)
 680                     ; 127 	for(j=0;j<8;j++){
 682  025d 0c01          	inc	(OFST+0,sp)
 686  025f 7b01          	ld	a,(OFST+0,sp)
 687  0261 a108          	cp	a,#8
 688  0263 25dc          	jrult	L142
 689                     ; 137 }
 692  0265 85            	popw	x
 693  0266 81            	ret
 764                     ; 139 void ws2812SendOneLed(uint32_t color,uint8_t per){
 765                     	switch	.text
 766  0267               _ws2812SendOneLed:
 768  0267 5203          	subw	sp,#3
 769       00000003      OFST:	set	3
 772                     ; 141 	r=(color>>16)&0xff;
 774  0269 7b07          	ld	a,(OFST+4,sp)
 775  026b a4ff          	and	a,#255
 776  026d 6b01          	ld	(OFST-2,sp),a
 778                     ; 142 	g=(color>>8)&0xff;
 780  026f 7b08          	ld	a,(OFST+5,sp)
 781  0271 a4ff          	and	a,#255
 782  0273 6b02          	ld	(OFST-1,sp),a
 784                     ; 143 	b=color&0xff;
 786  0275 7b09          	ld	a,(OFST+6,sp)
 787  0277 a4ff          	and	a,#255
 788  0279 6b03          	ld	(OFST+0,sp),a
 790                     ; 145 	r=((uint16_t)r*per)/100;
 792  027b 7b01          	ld	a,(OFST-2,sp)
 793  027d 5f            	clrw	x
 794  027e 97            	ld	xl,a
 795  027f 7b0a          	ld	a,(OFST+7,sp)
 796  0281 cd0000        	call	c_bmulx
 798  0284 a664          	ld	a,#100
 799  0286 62            	div	x,a
 800  0287 01            	rrwa	x,a
 801  0288 6b01          	ld	(OFST-2,sp),a
 802  028a 02            	rlwa	x,a
 804                     ; 146 	g=((uint16_t)g*per)/100;
 806  028b 7b02          	ld	a,(OFST-1,sp)
 807  028d 5f            	clrw	x
 808  028e 97            	ld	xl,a
 809  028f 7b0a          	ld	a,(OFST+7,sp)
 810  0291 cd0000        	call	c_bmulx
 812  0294 a664          	ld	a,#100
 813  0296 62            	div	x,a
 814  0297 01            	rrwa	x,a
 815  0298 6b02          	ld	(OFST-1,sp),a
 816  029a 02            	rlwa	x,a
 818                     ; 147 	b=((uint16_t)b*per)/100;
 820  029b 7b03          	ld	a,(OFST+0,sp)
 821  029d 5f            	clrw	x
 822  029e 97            	ld	xl,a
 823  029f 7b0a          	ld	a,(OFST+7,sp)
 824  02a1 cd0000        	call	c_bmulx
 826  02a4 a664          	ld	a,#100
 827  02a6 62            	div	x,a
 828  02a7 01            	rrwa	x,a
 829  02a8 6b03          	ld	(OFST+0,sp),a
 830  02aa 02            	rlwa	x,a
 832                     ; 149 	ws2812SendByte(g);
 834  02ab 7b02          	ld	a,(OFST-1,sp)
 835  02ad ad8e          	call	_ws2812SendByte
 837                     ; 150 	ws2812SendByte(r);
 839  02af 7b01          	ld	a,(OFST-2,sp)
 840  02b1 ad8a          	call	_ws2812SendByte
 842                     ; 151 	ws2812SendByte(b);
 844  02b3 7b03          	ld	a,(OFST+0,sp)
 845  02b5 ad86          	call	_ws2812SendByte
 847                     ; 152 }
 850  02b7 5b03          	addw	sp,#3
 851  02b9 81            	ret
 896                     ; 154 void ws2812SendReset(uint8_t reset){
 897                     	switch	.text
 898  02ba               _ws2812SendReset:
 900  02ba 88            	push	a
 901  02bb 88            	push	a
 902       00000001      OFST:	set	1
 905                     ; 156 	for(j=0;j<reset;j++){
 907  02bc 0f01          	clr	(OFST+0,sp)
 910  02be 200e          	jra	L533
 911  02c0               L343:
 912                     ; 157 			while(SPI_GetFlagStatus(SPI_FLAG_TXE)==RESET);
 914  02c0 a602          	ld	a,#2
 915  02c2 cd0000        	call	_SPI_GetFlagStatus
 917  02c5 4d            	tnz	a
 918  02c6 27f8          	jreq	L343
 919                     ; 158 			SPI_SendData(0x00);		
 921  02c8 4f            	clr	a
 922  02c9 cd0000        	call	_SPI_SendData
 924                     ; 156 	for(j=0;j<reset;j++){
 926  02cc 0c01          	inc	(OFST+0,sp)
 928  02ce               L533:
 931  02ce 7b01          	ld	a,(OFST+0,sp)
 932  02d0 1102          	cp	a,(OFST+1,sp)
 933  02d2 25ec          	jrult	L343
 935  02d4               L153:
 936                     ; 160 	while(SPI_GetFlagStatus(SPI_FLAG_BSY)==SET);
 938  02d4 a680          	ld	a,#128
 939  02d6 cd0000        	call	_SPI_GetFlagStatus
 941  02d9 a101          	cp	a,#1
 942  02db 27f7          	jreq	L153
 943                     ; 161 }
 946  02dd 85            	popw	x
 947  02de 81            	ret
1097                     	xdef	_main
1098                     	xdef	_ws2812SendReset
1099                     	xdef	_ws2812SendOneLed
1100                     	xdef	_ws2812SendByte
1101                     	switch	.ubsct
1102  0000               _currentColor:
1103  0000 00000000      	ds.b	4
1104                     	xdef	_currentColor
1105                     	xdef	_percent
1106                     	xdef	_trueCommand
1107                     	xdef	_trueAddress
1108                     	xdef	_cmdInv
1109                     	xdef	_cmd
1110                     	xdef	_addrInv
1111                     	xdef	_addr
1112                     	xdef	_frameReady
1113                     	xdef	_bitIndex
1114                     	xdef	_state
1115                     	xdef	_Delta
1116                     	xdef	_previousTime
1117                     	xdef	_currentTime
1118                     	xdef	_remoteReceived
1119                     	xref	_TIM1_CCxCmd
1120                     	xref	_TIM1_ITConfig
1121                     	xref	_TIM1_Cmd
1122                     	xref	_TIM1_ICInit
1123                     	xref	_TIM1_TimeBaseInit
1124                     	xref	_SPI_GetFlagStatus
1125                     	xref	_SPI_SendData
1126                     	xref	_SPI_Cmd
1127                     	xref	_SPI_Init
1128                     	xref	_SPI_DeInit
1129                     	xref	_GPIO_Init
1130                     	xref	_GPIO_DeInit
1131                     	xref	_CLK_HSIPrescalerConfig
1132                     	xref	_CLK_PeripheralClockConfig
1133                     	xref.b	c_x
1153                     	xref	c_bmulx
1154                     	end
