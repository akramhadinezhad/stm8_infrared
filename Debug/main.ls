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
 116                     ; 22 void main(void)
 116                     ; 23 {
 118                     	switch	.text
 119  0000               _main:
 121  0000 5205          	subw	sp,#5
 122       00000005      OFST:	set	5
 125                     ; 26 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);/* Clock divider to HSI/1 */
 127  0002 4f            	clr	a
 128  0003 cd0000        	call	_CLK_HSIPrescalerConfig
 130                     ; 27 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1,ENABLE); /*timer1 clock enable*/
 132  0006 ae0701        	ldw	x,#1793
 133  0009 cd0000        	call	_CLK_PeripheralClockConfig
 135                     ; 28 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI,ENABLE); /*SPI clock enable*/
 137  000c ae0101        	ldw	x,#257
 138  000f cd0000        	call	_CLK_PeripheralClockConfig
 140                     ; 30 	GPIO_DeInit(GPIOC);
 142  0012 ae500a        	ldw	x,#20490
 143  0015 cd0000        	call	_GPIO_DeInit
 145                     ; 31 	GPIO_Init(GPIOC,GPIO_PIN_3,GPIO_MODE_IN_PU_NO_IT); /*TIMER1 pin*/
 147  0018 4b40          	push	#64
 148  001a 4b08          	push	#8
 149  001c ae500a        	ldw	x,#20490
 150  001f cd0000        	call	_GPIO_Init
 152  0022 85            	popw	x
 153                     ; 32 	GPIO_Init(GPIOC,GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_FAST); /*SPI clock pin*/
 155  0023 4be0          	push	#224
 156  0025 4b20          	push	#32
 157  0027 ae500a        	ldw	x,#20490
 158  002a cd0000        	call	_GPIO_Init
 160  002d 85            	popw	x
 161                     ; 33 	GPIO_Init(GPIOC,GPIO_PIN_6,GPIO_MODE_OUT_PP_HIGH_FAST); /*SPI mosi pin*/
 163  002e 4bf0          	push	#240
 164  0030 4b40          	push	#64
 165  0032 ae500a        	ldw	x,#20490
 166  0035 cd0000        	call	_GPIO_Init
 168  0038 85            	popw	x
 169                     ; 35 	TIM1_TimeBaseInit(15,TIM1_COUNTERMODE_UP,65535,0);
 171  0039 4b00          	push	#0
 172  003b aeffff        	ldw	x,#65535
 173  003e 89            	pushw	x
 174  003f 4b00          	push	#0
 175  0041 ae000f        	ldw	x,#15
 176  0044 cd0000        	call	_TIM1_TimeBaseInit
 178  0047 5b04          	addw	sp,#4
 179                     ; 36 	TIM1_ICInit(TIM1_CHANNEL_3,
 179                     ; 37 							TIM1_ICPOLARITY_FALLING,
 179                     ; 38 							TIM1_ICSELECTION_DIRECTTI,
 179                     ; 39 							TIM1_ICPSC_DIV1,
 179                     ; 40 							0x00);	/* TIMER1 configuration */
 181  0049 4b00          	push	#0
 182  004b 4b00          	push	#0
 183  004d 4b01          	push	#1
 184  004f ae0201        	ldw	x,#513
 185  0052 cd0000        	call	_TIM1_ICInit
 187  0055 5b03          	addw	sp,#3
 188                     ; 41 	TIM1_ITConfig(TIM1_IT_CC3,ENABLE);/* Enable interrupt */
 190  0057 ae0801        	ldw	x,#2049
 191  005a cd0000        	call	_TIM1_ITConfig
 193                     ; 42 	TIM1_Cmd(ENABLE); /* Enable TIM1 */
 195  005d a601          	ld	a,#1
 196  005f cd0000        	call	_TIM1_Cmd
 198                     ; 43 	TIM1_CCxCmd(TIM1_CHANNEL_3,ENABLE);/* Enable TIM1 CHANNEL3 */
 200  0062 ae0201        	ldw	x,#513
 201  0065 cd0000        	call	_TIM1_CCxCmd
 203                     ; 45 	SPI_DeInit();
 205  0068 cd0000        	call	_SPI_DeInit
 207                     ; 46 	SPI_Init(SPI_FIRSTBIT_MSB,
 207                     ; 47 					SPI_BAUDRATEPRESCALER_2,
 207                     ; 48 					SPI_MODE_MASTER,
 207                     ; 49 					SPI_CLOCKPOLARITY_LOW,
 207                     ; 50 					SPI_CLOCKPHASE_1EDGE,
 207                     ; 51 					SPI_DATADIRECTION_1LINE_TX,
 207                     ; 52 					SPI_NSS_SOFT,
 207                     ; 53 					0x00); /* SPI configuration */	
 209  006b 4b00          	push	#0
 210  006d 4b02          	push	#2
 211  006f 4bc0          	push	#192
 212  0071 4b00          	push	#0
 213  0073 4b00          	push	#0
 214  0075 4b04          	push	#4
 215  0077 5f            	clrw	x
 216  0078 cd0000        	call	_SPI_Init
 218  007b 5b06          	addw	sp,#6
 219                     ; 54 	SPI_Cmd(ENABLE);	/* Enable SPI */			
 221  007d a601          	ld	a,#1
 222  007f cd0000        	call	_SPI_Cmd
 224                     ; 55 	enableInterrupts(); /* Enable global interrupt */
 227  0082 9a            rim
 229  0083               L33:
 230                     ; 57 	if(frameReady==1){
 232  0083 b60c          	ld	a,_frameReady
 233  0085 a101          	cp	a,#1
 234  0087 26fa          	jrne	L33
 235                     ; 58 		frameReady=0;
 237  0089 3f0c          	clr	_frameReady
 238                     ; 59 		temp=remoteReceived;
 240  008b be02          	ldw	x,_remoteReceived+2
 241  008d 1f04          	ldw	(OFST-1,sp),x
 242  008f be00          	ldw	x,_remoteReceived
 243  0091 1f02          	ldw	(OFST-3,sp),x
 245                     ; 60 		trueAddress=0;
 247  0093 3f11          	clr	_trueAddress
 248                     ; 61 		trueCommand=0;
 250  0095 3f12          	clr	_trueCommand
 251                     ; 63 		addr=(temp>>24)&0xFF;
 253  0097 7b02          	ld	a,(OFST-3,sp)
 254  0099 b70d          	ld	_addr,a
 255                     ; 64 		addrInv=(temp>>16)&0xFF;
 257  009b 7b03          	ld	a,(OFST-2,sp)
 258  009d a4ff          	and	a,#255
 259  009f b70e          	ld	_addrInv,a
 260                     ; 65 		cmd=(temp>>8)&0xFF;
 262  00a1 7b04          	ld	a,(OFST-1,sp)
 263  00a3 a4ff          	and	a,#255
 264  00a5 b70f          	ld	_cmd,a
 265                     ; 66 		cmdInv=(temp)&0xFF;
 267  00a7 7b05          	ld	a,(OFST+0,sp)
 268  00a9 a4ff          	and	a,#255
 269  00ab b710          	ld	_cmdInv,a
 270                     ; 68 		if((addr^addrInv)==0xFF)trueAddress=1;
 272  00ad b60d          	ld	a,_addr
 273  00af b80e          	xor	a,_addrInv
 274  00b1 a1ff          	cp	a,#255
 275  00b3 2604          	jrne	L14
 278  00b5 35010011      	mov	_trueAddress,#1
 279  00b9               L14:
 280                     ; 69 		if((cmd^cmdInv)==0xFF)trueCommand=1;
 282  00b9 b60f          	ld	a,_cmd
 283  00bb b810          	xor	a,_cmdInv
 284  00bd a1ff          	cp	a,#255
 285  00bf 2604          	jrne	L34
 288  00c1 35010012      	mov	_trueCommand,#1
 289  00c5               L34:
 290                     ; 70 		if(trueAddress && trueCommand){
 292  00c5 3d11          	tnz	_trueAddress
 293  00c7 27ba          	jreq	L33
 295  00c9 3d12          	tnz	_trueCommand
 296  00cb 27b6          	jreq	L33
 297                     ; 71 			if(cmd==0x68){//off
 299  00cd b60f          	ld	a,_cmd
 300  00cf a168          	cp	a,#104
 301  00d1 260e          	jrne	L74
 302                     ; 72 				currentColor=0x00000000;
 304  00d3 ae0000        	ldw	x,#0
 305  00d6 bf02          	ldw	_currentColor+2,x
 306  00d8 ae0000        	ldw	x,#0
 307  00db bf00          	ldw	_currentColor,x
 309  00dd acbf01bf      	jpf	L15
 310  00e1               L74:
 311                     ; 74 			else if(cmd==0xE0){//decrease
 313  00e1 b60f          	ld	a,_cmd
 314  00e3 a1e0          	cp	a,#224
 315  00e5 2618          	jrne	L35
 316                     ; 75 				if(percent>10) percent-=10;
 318  00e7 b613          	ld	a,_percent
 319  00e9 a10b          	cp	a,#11
 320  00eb 250a          	jrult	L55
 323  00ed b613          	ld	a,_percent
 324  00ef a00a          	sub	a,#10
 325  00f1 b713          	ld	_percent,a
 327  00f3 acbf01bf      	jpf	L15
 328  00f7               L55:
 329                     ; 76 				else percent=5;
 331  00f7 35050013      	mov	_percent,#5
 332  00fb acbf01bf      	jpf	L15
 333  00ff               L35:
 334                     ; 78 			else if(cmd==0xA8){//increase
 336  00ff b60f          	ld	a,_cmd
 337  0101 a1a8          	cp	a,#168
 338  0103 2618          	jrne	L36
 339                     ; 79 				if(percent<=90) percent+=10;
 341  0105 b613          	ld	a,_percent
 342  0107 a15b          	cp	a,#91
 343  0109 240a          	jruge	L56
 346  010b b613          	ld	a,_percent
 347  010d ab0a          	add	a,#10
 348  010f b713          	ld	_percent,a
 350  0111 acbf01bf      	jpf	L15
 351  0115               L56:
 352                     ; 80 				else percent=100;
 354  0115 35640013      	mov	_percent,#100
 355  0119 acbf01bf      	jpf	L15
 356  011d               L36:
 357                     ; 82 			else if(cmd==0x30){//red color
 359  011d b60f          	ld	a,_cmd
 360  011f a130          	cp	a,#48
 361  0121 260e          	jrne	L37
 362                     ; 83 				currentColor=0x00FF0000;
 364  0123 ae0000        	ldw	x,#0
 365  0126 bf02          	ldw	_currentColor+2,x
 366  0128 ae00ff        	ldw	x,#255
 367  012b bf00          	ldw	_currentColor,x
 369  012d acbf01bf      	jpf	L15
 370  0131               L37:
 371                     ; 85 			else if(cmd==0x18){//green color
 373  0131 b60f          	ld	a,_cmd
 374  0133 a118          	cp	a,#24
 375  0135 260c          	jrne	L77
 376                     ; 86 				currentColor=0x0000FF00;
 378  0137 aeff00        	ldw	x,#65280
 379  013a bf02          	ldw	_currentColor+2,x
 380  013c ae0000        	ldw	x,#0
 381  013f bf00          	ldw	_currentColor,x
 383  0141 207c          	jra	L15
 384  0143               L77:
 385                     ; 88 			else if(cmd==0x7A){//blue color
 387  0143 b60f          	ld	a,_cmd
 388  0145 a17a          	cp	a,#122
 389  0147 260c          	jrne	L301
 390                     ; 89 				currentColor=0x000000FF;
 392  0149 ae00ff        	ldw	x,#255
 393  014c bf02          	ldw	_currentColor+2,x
 394  014e ae0000        	ldw	x,#0
 395  0151 bf00          	ldw	_currentColor,x
 397  0153 206a          	jra	L15
 398  0155               L301:
 399                     ; 91 			else if(cmd==0x10){//white color
 401  0155 b60f          	ld	a,_cmd
 402  0157 a110          	cp	a,#16
 403  0159 260c          	jrne	L701
 404                     ; 92 				currentColor=0x00FFFFFF;
 406  015b aeffff        	ldw	x,#65535
 407  015e bf02          	ldw	_currentColor+2,x
 408  0160 ae00ff        	ldw	x,#255
 409  0163 bf00          	ldw	_currentColor,x
 411  0165 2058          	jra	L15
 412  0167               L701:
 413                     ; 94 			else if(cmd==0x38){//yellow color
 415  0167 b60f          	ld	a,_cmd
 416  0169 a138          	cp	a,#56
 417  016b 260c          	jrne	L311
 418                     ; 95 				currentColor=0x00FFFF00;
 420  016d aeff00        	ldw	x,#65280
 421  0170 bf02          	ldw	_currentColor+2,x
 422  0172 ae00ff        	ldw	x,#255
 423  0175 bf00          	ldw	_currentColor,x
 425  0177 2046          	jra	L15
 426  0179               L311:
 427                     ; 97 			else if(cmd==0x5A){//purple color
 429  0179 b60f          	ld	a,_cmd
 430  017b a15a          	cp	a,#90
 431  017d 260c          	jrne	L711
 432                     ; 98 				currentColor=0x008000FF;
 434  017f ae00ff        	ldw	x,#255
 435  0182 bf02          	ldw	_currentColor+2,x
 436  0184 ae0080        	ldw	x,#128
 437  0187 bf00          	ldw	_currentColor,x
 439  0189 2034          	jra	L15
 440  018b               L711:
 441                     ; 100 			else if(cmd==0x42){//cyan color
 443  018b b60f          	ld	a,_cmd
 444  018d a142          	cp	a,#66
 445  018f 260c          	jrne	L321
 446                     ; 101 				currentColor=0x0000FFFF;
 448  0191 aeffff        	ldw	x,#65535
 449  0194 bf02          	ldw	_currentColor+2,x
 450  0196 ae0000        	ldw	x,#0
 451  0199 bf00          	ldw	_currentColor,x
 453  019b 2022          	jra	L15
 454  019d               L321:
 455                     ; 103 			else if(cmd==0x4A){//orange color
 457  019d b60f          	ld	a,_cmd
 458  019f a14a          	cp	a,#74
 459  01a1 260c          	jrne	L721
 460                     ; 104 				currentColor=0x00F96E2A;
 462  01a3 ae6e2a        	ldw	x,#28202
 463  01a6 bf02          	ldw	_currentColor+2,x
 464  01a8 ae00f9        	ldw	x,#249
 465  01ab bf00          	ldw	_currentColor,x
 467  01ad 2010          	jra	L15
 468  01af               L721:
 469                     ; 106 			else if(cmd==0x52){//pink color
 471  01af b60f          	ld	a,_cmd
 472  01b1 a152          	cp	a,#82
 473  01b3 260a          	jrne	L15
 474                     ; 107 				currentColor=0x00FF1493;
 476  01b5 ae1493        	ldw	x,#5267
 477  01b8 bf02          	ldw	_currentColor+2,x
 478  01ba ae00ff        	ldw	x,#255
 479  01bd bf00          	ldw	_currentColor,x
 480  01bf               L15:
 481                     ; 109 			if(cmd==0x30||cmd==0x18||cmd==0x7A||//1:red,2:green ,3:blue
 481                     ; 110 					cmd==0x10||cmd==0x38||cmd==0x5A||//4:white,5:yellow ,6:purple
 481                     ; 111 					cmd==0x42||cmd==0x4A||cmd==0x52||//7:greenblue,8:lemon ,9:pink
 481                     ; 112 					cmd==0xE0||cmd==0xA8||cmd==0x68){//-:decrease,+:increase,0:off
 483  01bf b60f          	ld	a,_cmd
 484  01c1 a130          	cp	a,#48
 485  01c3 2745          	jreq	L731
 487  01c5 b60f          	ld	a,_cmd
 488  01c7 a118          	cp	a,#24
 489  01c9 273f          	jreq	L731
 491  01cb b60f          	ld	a,_cmd
 492  01cd a17a          	cp	a,#122
 493  01cf 2739          	jreq	L731
 495  01d1 b60f          	ld	a,_cmd
 496  01d3 a110          	cp	a,#16
 497  01d5 2733          	jreq	L731
 499  01d7 b60f          	ld	a,_cmd
 500  01d9 a138          	cp	a,#56
 501  01db 272d          	jreq	L731
 503  01dd b60f          	ld	a,_cmd
 504  01df a15a          	cp	a,#90
 505  01e1 2727          	jreq	L731
 507  01e3 b60f          	ld	a,_cmd
 508  01e5 a142          	cp	a,#66
 509  01e7 2721          	jreq	L731
 511  01e9 b60f          	ld	a,_cmd
 512  01eb a14a          	cp	a,#74
 513  01ed 271b          	jreq	L731
 515  01ef b60f          	ld	a,_cmd
 516  01f1 a152          	cp	a,#82
 517  01f3 2715          	jreq	L731
 519  01f5 b60f          	ld	a,_cmd
 520  01f7 a1e0          	cp	a,#224
 521  01f9 270f          	jreq	L731
 523  01fb b60f          	ld	a,_cmd
 524  01fd a1a8          	cp	a,#168
 525  01ff 2709          	jreq	L731
 527  0201 b60f          	ld	a,_cmd
 528  0203 a168          	cp	a,#104
 529  0205 2703          	jreq	L6
 530  0207 cc0083        	jp	L33
 531  020a               L6:
 532  020a               L731:
 533                     ; 113 			  for(i=0;i<ledNumber;i++){
 535  020a 0f01          	clr	(OFST-4,sp)
 537  020c               L561:
 538                     ; 114 					ws2812SendOneLed(currentColor,percent);
 540  020c 3b0013        	push	_percent
 541  020f be02          	ldw	x,_currentColor+2
 542  0211 89            	pushw	x
 543  0212 be00          	ldw	x,_currentColor
 544  0214 89            	pushw	x
 545  0215 ad3d          	call	_ws2812SendOneLed
 547  0217 5b05          	addw	sp,#5
 548                     ; 113 			  for(i=0;i<ledNumber;i++){
 550  0219 0c01          	inc	(OFST-4,sp)
 554  021b 7b01          	ld	a,(OFST-4,sp)
 555  021d a108          	cp	a,#8
 556  021f 25eb          	jrult	L561
 557                     ; 116 				ws2812SendReset(RES);
 559  0221 a637          	ld	a,#55
 560  0223 cd02a7        	call	_ws2812SendReset
 562  0226 ac830083      	jpf	L33
 607                     ; 123 void ws2812SendByte(uint8_t data){
 608                     	switch	.text
 609  022a               _ws2812SendByte:
 611  022a 88            	push	a
 612  022b 88            	push	a
 613       00000001      OFST:	set	1
 616                     ; 125 	for(j=0;j<8;j++){
 618  022c 0f01          	clr	(OFST+0,sp)
 620  022e               L522:
 621                     ; 126 		while(SPI_GetFlagStatus(SPI_FLAG_TXE)==RESET);
 623  022e a602          	ld	a,#2
 624  0230 cd0000        	call	_SPI_GetFlagStatus
 626  0233 4d            	tnz	a
 627  0234 27f8          	jreq	L522
 628                     ; 127 		if(data & 0x80){
 630  0236 7b02          	ld	a,(OFST+1,sp)
 631  0238 a580          	bcp	a,#128
 632  023a 2707          	jreq	L132
 633                     ; 128 			SPI_SendData(0x7C);
 635  023c a67c          	ld	a,#124
 636  023e cd0000        	call	_SPI_SendData
 639  0241 2005          	jra	L332
 640  0243               L132:
 641                     ; 131 			SPI_SendData(0x70);		
 643  0243 a670          	ld	a,#112
 644  0245 cd0000        	call	_SPI_SendData
 646  0248               L332:
 647                     ; 133 		data<<=1;
 649  0248 0802          	sll	(OFST+1,sp)
 650                     ; 125 	for(j=0;j<8;j++){
 652  024a 0c01          	inc	(OFST+0,sp)
 656  024c 7b01          	ld	a,(OFST+0,sp)
 657  024e a108          	cp	a,#8
 658  0250 25dc          	jrult	L522
 659                     ; 135 }
 662  0252 85            	popw	x
 663  0253 81            	ret
 734                     ; 137 void ws2812SendOneLed(uint32_t color,uint8_t per){
 735                     	switch	.text
 736  0254               _ws2812SendOneLed:
 738  0254 5203          	subw	sp,#3
 739       00000003      OFST:	set	3
 742                     ; 139 	r=(color>>16)&0xff;
 744  0256 7b07          	ld	a,(OFST+4,sp)
 745  0258 a4ff          	and	a,#255
 746  025a 6b01          	ld	(OFST-2,sp),a
 748                     ; 140 	g=(color>>8)&0xff;
 750  025c 7b08          	ld	a,(OFST+5,sp)
 751  025e a4ff          	and	a,#255
 752  0260 6b02          	ld	(OFST-1,sp),a
 754                     ; 141 	b=color&0xff;
 756  0262 7b09          	ld	a,(OFST+6,sp)
 757  0264 a4ff          	and	a,#255
 758  0266 6b03          	ld	(OFST+0,sp),a
 760                     ; 143 	r=((uint16_t)r*per)/100;
 762  0268 7b01          	ld	a,(OFST-2,sp)
 763  026a 5f            	clrw	x
 764  026b 97            	ld	xl,a
 765  026c 7b0a          	ld	a,(OFST+7,sp)
 766  026e cd0000        	call	c_bmulx
 768  0271 a664          	ld	a,#100
 769  0273 62            	div	x,a
 770  0274 01            	rrwa	x,a
 771  0275 6b01          	ld	(OFST-2,sp),a
 772  0277 02            	rlwa	x,a
 774                     ; 144 	g=((uint16_t)g*per)/100;
 776  0278 7b02          	ld	a,(OFST-1,sp)
 777  027a 5f            	clrw	x
 778  027b 97            	ld	xl,a
 779  027c 7b0a          	ld	a,(OFST+7,sp)
 780  027e cd0000        	call	c_bmulx
 782  0281 a664          	ld	a,#100
 783  0283 62            	div	x,a
 784  0284 01            	rrwa	x,a
 785  0285 6b02          	ld	(OFST-1,sp),a
 786  0287 02            	rlwa	x,a
 788                     ; 145 	b=((uint16_t)b*per)/100;
 790  0288 7b03          	ld	a,(OFST+0,sp)
 791  028a 5f            	clrw	x
 792  028b 97            	ld	xl,a
 793  028c 7b0a          	ld	a,(OFST+7,sp)
 794  028e cd0000        	call	c_bmulx
 796  0291 a664          	ld	a,#100
 797  0293 62            	div	x,a
 798  0294 01            	rrwa	x,a
 799  0295 6b03          	ld	(OFST+0,sp),a
 800  0297 02            	rlwa	x,a
 802                     ; 147 	ws2812SendByte(g);
 804  0298 7b02          	ld	a,(OFST-1,sp)
 805  029a ad8e          	call	_ws2812SendByte
 807                     ; 148 	ws2812SendByte(r);
 809  029c 7b01          	ld	a,(OFST-2,sp)
 810  029e ad8a          	call	_ws2812SendByte
 812                     ; 149 	ws2812SendByte(b);
 814  02a0 7b03          	ld	a,(OFST+0,sp)
 815  02a2 ad86          	call	_ws2812SendByte
 817                     ; 150 }
 820  02a4 5b03          	addw	sp,#3
 821  02a6 81            	ret
 866                     ; 152 void ws2812SendReset(uint8_t reset){
 867                     	switch	.text
 868  02a7               _ws2812SendReset:
 870  02a7 88            	push	a
 871  02a8 88            	push	a
 872       00000001      OFST:	set	1
 875                     ; 154 	for(j=0;j<reset;j++){
 877  02a9 0f01          	clr	(OFST+0,sp)
 880  02ab 200e          	jra	L123
 881  02ad               L723:
 882                     ; 155 			while(SPI_GetFlagStatus(SPI_FLAG_TXE)==RESET);
 884  02ad a602          	ld	a,#2
 885  02af cd0000        	call	_SPI_GetFlagStatus
 887  02b2 4d            	tnz	a
 888  02b3 27f8          	jreq	L723
 889                     ; 156 			SPI_SendData(0x00);		
 891  02b5 4f            	clr	a
 892  02b6 cd0000        	call	_SPI_SendData
 894                     ; 154 	for(j=0;j<reset;j++){
 896  02b9 0c01          	inc	(OFST+0,sp)
 898  02bb               L123:
 901  02bb 7b01          	ld	a,(OFST+0,sp)
 902  02bd 1102          	cp	a,(OFST+1,sp)
 903  02bf 25ec          	jrult	L723
 905  02c1               L533:
 906                     ; 158 	while(SPI_GetFlagStatus(SPI_FLAG_BSY)==SET);
 908  02c1 a680          	ld	a,#128
 909  02c3 cd0000        	call	_SPI_GetFlagStatus
 911  02c6 a101          	cp	a,#1
 912  02c8 27f7          	jreq	L533
 913                     ; 159 }
 916  02ca 85            	popw	x
 917  02cb 81            	ret
1067                     	xdef	_main
1068                     	xdef	_ws2812SendReset
1069                     	xdef	_ws2812SendOneLed
1070                     	xdef	_ws2812SendByte
1071                     	switch	.ubsct
1072  0000               _currentColor:
1073  0000 00000000      	ds.b	4
1074                     	xdef	_currentColor
1075                     	xdef	_percent
1076                     	xdef	_trueCommand
1077                     	xdef	_trueAddress
1078                     	xdef	_cmdInv
1079                     	xdef	_cmd
1080                     	xdef	_addrInv
1081                     	xdef	_addr
1082                     	xdef	_frameReady
1083                     	xdef	_bitIndex
1084                     	xdef	_state
1085                     	xdef	_Delta
1086                     	xdef	_previousTime
1087                     	xdef	_currentTime
1088                     	xdef	_remoteReceived
1089                     	xref	_TIM1_CCxCmd
1090                     	xref	_TIM1_ITConfig
1091                     	xref	_TIM1_Cmd
1092                     	xref	_TIM1_ICInit
1093                     	xref	_TIM1_TimeBaseInit
1094                     	xref	_SPI_GetFlagStatus
1095                     	xref	_SPI_SendData
1096                     	xref	_SPI_Cmd
1097                     	xref	_SPI_Init
1098                     	xref	_SPI_DeInit
1099                     	xref	_GPIO_Init
1100                     	xref	_GPIO_DeInit
1101                     	xref	_CLK_HSIPrescalerConfig
1102                     	xref	_CLK_PeripheralClockConfig
1103                     	xref.b	c_x
1123                     	xref	c_bmulx
1124                     	end
