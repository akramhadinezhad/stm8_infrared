   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  44                     ; 17 @far @interrupt void NonHandledInterrupt (void)
  44                     ; 18 {
  45                     	switch	.text
  46  0000               f_NonHandledInterrupt:
  50                     ; 22 	return;
  53  0000 80            	iret
  85                     ; 27 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler,12){
  86                     	switch	.text
  87  0001               f_TIM1_CAP_COM_IRQHandler:
  89  0001 8a            	push	cc
  90  0002 84            	pop	a
  91  0003 a4bf          	and	a,#191
  92  0005 88            	push	a
  93  0006 86            	pop	cc
  94  0007 3b0002        	push	c_x+2
  95  000a be00          	ldw	x,c_x
  96  000c 89            	pushw	x
  97  000d 3b0002        	push	c_y+2
  98  0010 be00          	ldw	x,c_y
  99  0012 89            	pushw	x
 100  0013 be02          	ldw	x,c_lreg+2
 101  0015 89            	pushw	x
 102  0016 be00          	ldw	x,c_lreg
 103  0018 89            	pushw	x
 106                     ; 28 	currentTime=TIM1_GetCapture3();
 108  0019 cd0000        	call	_TIM1_GetCapture3
 110  001c bf00          	ldw	_currentTime,x
 111                     ; 29 	TIM1_ClearITPendingBit(TIM1_IT_CC3);
 113  001e a608          	ld	a,#8
 114  0020 cd0000        	call	_TIM1_ClearITPendingBit
 116                     ; 30 	Delta=currentTime-previousTime;
 118  0023 be00          	ldw	x,_currentTime
 119  0025 72b00000      	subw	x,_previousTime
 120  0029 bf00          	ldw	_Delta,x
 121                     ; 31 	previousTime=currentTime;
 123  002b be00          	ldw	x,_currentTime
 124  002d bf00          	ldw	_previousTime,x
 125                     ; 32 	if(state==0){
 127  002f 3d00          	tnz	_state
 128  0031 2628          	jrne	L13
 129                     ; 33 		if(12000<=Delta && Delta<=15000){/*1.leader recognization*/
 131  0033 be00          	ldw	x,_Delta
 132  0035 a32ee0        	cpw	x,#12000
 133  0038 2404          	jruge	L01
 134  003a acd200d2      	jpf	L53
 135  003e               L01:
 137  003e be00          	ldw	x,_Delta
 138  0040 a33a99        	cpw	x,#15001
 139  0043 2504          	jrult	L21
 140  0045 acd200d2      	jpf	L53
 141  0049               L21:
 142                     ; 34 			state=1;
 144  0049 35010000      	mov	_state,#1
 145                     ; 35 			bitIndex=0;
 147  004d 3f00          	clr	_bitIndex
 148                     ; 36 			remoteReceived=0;
 150  004f ae0000        	ldw	x,#0
 151  0052 bf02          	ldw	_remoteReceived+2,x
 152  0054 ae0000        	ldw	x,#0
 153  0057 bf00          	ldw	_remoteReceived,x
 154  0059 2077          	jra	L53
 155  005b               L13:
 156                     ; 39 	else if(state==1){
 158  005b b600          	ld	a,_state
 159  005d a101          	cp	a,#1
 160  005f 2671          	jrne	L53
 161                     ; 40 		if(900<=Delta && Delta<=1300){/*bit0*/
 163  0061 be00          	ldw	x,_Delta
 164  0063 a30384        	cpw	x,#900
 165  0066 2513          	jrult	L14
 167  0068 be00          	ldw	x,_Delta
 168  006a a30515        	cpw	x,#1301
 169  006d 240c          	jruge	L14
 170                     ; 41 			remoteReceived=(remoteReceived<<1);
 172  006f 3803          	sll	_remoteReceived+3
 173  0071 3902          	rlc	_remoteReceived+2
 174  0073 3901          	rlc	_remoteReceived+1
 175  0075 3900          	rlc	_remoteReceived
 176                     ; 42 			bitIndex++;
 178  0077 3c00          	inc	_bitIndex
 180  0079 2049          	jra	L34
 181  007b               L14:
 182                     ; 44 		else if(1900<=Delta && Delta<=2500){/*bit1*/
 184  007b be00          	ldw	x,_Delta
 185  007d a3076c        	cpw	x,#1900
 186  0080 2523          	jrult	L54
 188  0082 be00          	ldw	x,_Delta
 189  0084 a309c5        	cpw	x,#2501
 190  0087 241c          	jruge	L54
 191                     ; 45 			remoteReceived=(remoteReceived<<1)|1;
 193  0089 ae0000        	ldw	x,#_remoteReceived
 194  008c cd0000        	call	c_ltor
 196  008f 3803          	sll	c_lreg+3
 197  0091 3902          	rlc	c_lreg+2
 198  0093 3901          	rlc	c_lreg+1
 199  0095 3900          	rlc	c_lreg
 200  0097 72100003      	bset	c_lreg+3,#0
 201  009b ae0000        	ldw	x,#_remoteReceived
 202  009e cd0000        	call	c_rtol
 204                     ; 46 			bitIndex++;		
 206  00a1 3c00          	inc	_bitIndex
 208  00a3 201f          	jra	L34
 209  00a5               L54:
 210                     ; 48 		else if(10000<=Delta && Delta<=12500){/*repeated code*/
 212  00a5 be00          	ldw	x,_Delta
 213  00a7 a32710        	cpw	x,#10000
 214  00aa 250d          	jrult	L15
 216  00ac be00          	ldw	x,_Delta
 217  00ae a330d5        	cpw	x,#12501
 218  00b1 2406          	jruge	L15
 219                     ; 49 			state=0;
 221  00b3 3f00          	clr	_state
 222                     ; 50 			bitIndex=0;
 224  00b5 3f00          	clr	_bitIndex
 226  00b7 200b          	jra	L34
 227  00b9               L15:
 228                     ; 52 		else if(Delta>15000){/*very big wrong delta like 39000*/
 230  00b9 be00          	ldw	x,_Delta
 231  00bb a33a99        	cpw	x,#15001
 232  00be 2504          	jrult	L34
 233                     ; 53 			state=0;
 235  00c0 3f00          	clr	_state
 236                     ; 54 			bitIndex=0;		
 238  00c2 3f00          	clr	_bitIndex
 239  00c4               L34:
 240                     ; 56 		if(bitIndex>=32){
 242  00c4 b600          	ld	a,_bitIndex
 243  00c6 a120          	cp	a,#32
 244  00c8 2508          	jrult	L53
 245                     ; 57 			frameReady=1;
 247  00ca 35010000      	mov	_frameReady,#1
 248                     ; 58 			state=0;
 250  00ce 3f00          	clr	_state
 251                     ; 59 			bitIndex=0;
 253  00d0 3f00          	clr	_bitIndex
 254  00d2               L53:
 255                     ; 62 }/*end of interrupt function*/
 258  00d2 85            	popw	x
 259  00d3 bf00          	ldw	c_lreg,x
 260  00d5 85            	popw	x
 261  00d6 bf02          	ldw	c_lreg+2,x
 262  00d8 85            	popw	x
 263  00d9 bf00          	ldw	c_y,x
 264  00db 320002        	pop	c_y+2
 265  00de 85            	popw	x
 266  00df bf00          	ldw	c_x,x
 267  00e1 320002        	pop	c_x+2
 268  00e4 80            	iret
 270                     .const:	section	.text
 271  0000               __vectab:
 272  0000 82            	dc.b	130
 274  0001 00            	dc.b	page(__stext)
 275  0002 0000          	dc.w	__stext
 276  0004 82            	dc.b	130
 278  0005 00            	dc.b	page(f_NonHandledInterrupt)
 279  0006 0000          	dc.w	f_NonHandledInterrupt
 280  0008 82            	dc.b	130
 282  0009 00            	dc.b	page(f_NonHandledInterrupt)
 283  000a 0000          	dc.w	f_NonHandledInterrupt
 284  000c 82            	dc.b	130
 286  000d 00            	dc.b	page(f_NonHandledInterrupt)
 287  000e 0000          	dc.w	f_NonHandledInterrupt
 288  0010 82            	dc.b	130
 290  0011 00            	dc.b	page(f_NonHandledInterrupt)
 291  0012 0000          	dc.w	f_NonHandledInterrupt
 292  0014 82            	dc.b	130
 294  0015 00            	dc.b	page(f_NonHandledInterrupt)
 295  0016 0000          	dc.w	f_NonHandledInterrupt
 296  0018 82            	dc.b	130
 298  0019 00            	dc.b	page(f_NonHandledInterrupt)
 299  001a 0000          	dc.w	f_NonHandledInterrupt
 300  001c 82            	dc.b	130
 302  001d 00            	dc.b	page(f_NonHandledInterrupt)
 303  001e 0000          	dc.w	f_NonHandledInterrupt
 304  0020 82            	dc.b	130
 306  0021 00            	dc.b	page(f_NonHandledInterrupt)
 307  0022 0000          	dc.w	f_NonHandledInterrupt
 308  0024 82            	dc.b	130
 310  0025 00            	dc.b	page(f_NonHandledInterrupt)
 311  0026 0000          	dc.w	f_NonHandledInterrupt
 312  0028 82            	dc.b	130
 314  0029 00            	dc.b	page(f_NonHandledInterrupt)
 315  002a 0000          	dc.w	f_NonHandledInterrupt
 316  002c 82            	dc.b	130
 318  002d 00            	dc.b	page(f_NonHandledInterrupt)
 319  002e 0000          	dc.w	f_NonHandledInterrupt
 320  0030 82            	dc.b	130
 322  0031 00            	dc.b	page(f_NonHandledInterrupt)
 323  0032 0000          	dc.w	f_NonHandledInterrupt
 324  0034 82            	dc.b	130
 326  0035 00            	dc.b	page(f_NonHandledInterrupt)
 327  0036 0000          	dc.w	f_NonHandledInterrupt
 328  0038 82            	dc.b	130
 330  0039 01            	dc.b	page(f_TIM1_CAP_COM_IRQHandler)
 331  003a 0001          	dc.w	f_TIM1_CAP_COM_IRQHandler
 332  003c 82            	dc.b	130
 334  003d 00            	dc.b	page(f_NonHandledInterrupt)
 335  003e 0000          	dc.w	f_NonHandledInterrupt
 336  0040 82            	dc.b	130
 338  0041 00            	dc.b	page(f_NonHandledInterrupt)
 339  0042 0000          	dc.w	f_NonHandledInterrupt
 340  0044 82            	dc.b	130
 342  0045 00            	dc.b	page(f_NonHandledInterrupt)
 343  0046 0000          	dc.w	f_NonHandledInterrupt
 344  0048 82            	dc.b	130
 346  0049 00            	dc.b	page(f_NonHandledInterrupt)
 347  004a 0000          	dc.w	f_NonHandledInterrupt
 348  004c 82            	dc.b	130
 350  004d 00            	dc.b	page(f_NonHandledInterrupt)
 351  004e 0000          	dc.w	f_NonHandledInterrupt
 352  0050 82            	dc.b	130
 354  0051 00            	dc.b	page(f_NonHandledInterrupt)
 355  0052 0000          	dc.w	f_NonHandledInterrupt
 356  0054 82            	dc.b	130
 358  0055 00            	dc.b	page(f_NonHandledInterrupt)
 359  0056 0000          	dc.w	f_NonHandledInterrupt
 360  0058 82            	dc.b	130
 362  0059 00            	dc.b	page(f_NonHandledInterrupt)
 363  005a 0000          	dc.w	f_NonHandledInterrupt
 364  005c 82            	dc.b	130
 366  005d 00            	dc.b	page(f_NonHandledInterrupt)
 367  005e 0000          	dc.w	f_NonHandledInterrupt
 368  0060 82            	dc.b	130
 370  0061 00            	dc.b	page(f_NonHandledInterrupt)
 371  0062 0000          	dc.w	f_NonHandledInterrupt
 372  0064 82            	dc.b	130
 374  0065 00            	dc.b	page(f_NonHandledInterrupt)
 375  0066 0000          	dc.w	f_NonHandledInterrupt
 376  0068 82            	dc.b	130
 378  0069 00            	dc.b	page(f_NonHandledInterrupt)
 379  006a 0000          	dc.w	f_NonHandledInterrupt
 380  006c 82            	dc.b	130
 382  006d 00            	dc.b	page(f_NonHandledInterrupt)
 383  006e 0000          	dc.w	f_NonHandledInterrupt
 384  0070 82            	dc.b	130
 386  0071 00            	dc.b	page(f_NonHandledInterrupt)
 387  0072 0000          	dc.w	f_NonHandledInterrupt
 388  0074 82            	dc.b	130
 390  0075 00            	dc.b	page(f_NonHandledInterrupt)
 391  0076 0000          	dc.w	f_NonHandledInterrupt
 392  0078 82            	dc.b	130
 394  0079 00            	dc.b	page(f_NonHandledInterrupt)
 395  007a 0000          	dc.w	f_NonHandledInterrupt
 396  007c 82            	dc.b	130
 398  007d 00            	dc.b	page(f_NonHandledInterrupt)
 399  007e 0000          	dc.w	f_NonHandledInterrupt
 450                     	xdef	__vectab
 451                     	xref	__stext
 452                     	xdef	f_NonHandledInterrupt
 453                     	xdef	f_TIM1_CAP_COM_IRQHandler
 454                     	xref.b	_frameReady
 455                     	xref.b	_bitIndex
 456                     	xref.b	_state
 457                     	xref.b	_Delta
 458                     	xref.b	_previousTime
 459                     	xref.b	_currentTime
 460                     	xref.b	_remoteReceived
 461                     	xref	_TIM1_ClearITPendingBit
 462                     	xref	_TIM1_GetCapture3
 463                     	xref.b	c_lreg
 464                     	xref.b	c_x
 465                     	xref.b	c_y
 484                     	xref	c_rtol
 485                     	xref	c_ltor
 486                     	end
