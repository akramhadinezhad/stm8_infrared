/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stm8s.h"

#define ledNumber 12
#define RES 55

volatile uint32_t remoteReceived=0;
volatile uint16_t currentTime=0,previousTime=0,Delta=0;
volatile uint8_t state=0,bitIndex=0,frameReady=0;
volatile uint8_t addr=0,addrInv=0,cmd=0,cmdInv=0,trueAddress=0,trueCommand=0;

uint8_t percent=50;
uint32_t currentColor;

void ws2812SendByte(uint8_t data);
void ws2812SendOneLed(uint32_t color,uint8_t per);
void ws2812SendReset(uint8_t reset);

void main(void)
{
	uint8_t i;
	volatile uint16_t d;
	uint32_t temp;
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);/* Clock divider to HSI/1 */
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1,ENABLE); /*timer1 clock enable*/
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI,ENABLE); /*SPI clock enable*/
	
	GPIO_DeInit(GPIOC);
	GPIO_Init(GPIOC,GPIO_PIN_3,GPIO_MODE_IN_PU_NO_IT); /*TIMER1 pin*/
	GPIO_Init(GPIOC,GPIO_PIN_5,GPIO_MODE_OUT_PP_LOW_FAST); /*SPI clock pin*/
	GPIO_Init(GPIOC,GPIO_PIN_6,GPIO_MODE_OUT_PP_HIGH_FAST); /*SPI mosi pin*/
	
	TIM1_TimeBaseInit(15,TIM1_COUNTERMODE_UP,65535,0);
	TIM1_ICInit(TIM1_CHANNEL_3,
							TIM1_ICPOLARITY_FALLING,
							TIM1_ICSELECTION_DIRECTTI,
							TIM1_ICPSC_DIV1,
							0x00);	/* TIMER1 configuration */
	TIM1_ITConfig(TIM1_IT_CC3,ENABLE);/* Enable interrupt */
	TIM1_Cmd(ENABLE); /* Enable TIM1 */
	TIM1_CCxCmd(TIM1_CHANNEL_3,ENABLE);/* Enable TIM1 CHANNEL3 */
	
	SPI_DeInit();
	SPI_Init(SPI_FIRSTBIT_MSB,
					SPI_BAUDRATEPRESCALER_2,
					SPI_MODE_MASTER,
					SPI_CLOCKPOLARITY_LOW,
					SPI_CLOCKPHASE_1EDGE,
					SPI_DATADIRECTION_1LINE_TX,
					SPI_NSS_SOFT,
					0x00); /* SPI configuration */	
	SPI_Cmd(ENABLE);	/* Enable SPI */			
	enableInterrupts(); /* Enable global interrupt */
while (1){
	if(frameReady==1){
		frameReady=0;
		temp=remoteReceived;
		trueAddress=0;
		trueCommand=0;
		
		addr=(temp>>24)&0xFF;
		addrInv=(temp>>16)&0xFF;
		cmd=(temp>>8)&0xFF;
		cmdInv=(temp)&0xFF;
		
		if((addr^addrInv)==0xFF)trueAddress=1;
		if((cmd^cmdInv)==0xFF)trueCommand=1;
		if(trueAddress && trueCommand){
			if(cmd==0x68){//off
				currentColor=0x00000000;
			}	
			else if(cmd==0xE0){//decrease
				if(percent>10) percent-=10;
				else percent=5;
			}
			else if(cmd==0xA8){//increase
				if(percent<=90) percent+=10;
				else percent=100;
			}
			else if(cmd==0x30){//red color
				currentColor=0x00FF0000;
			}
			else if(cmd==0x18){//green color
				currentColor=0x0000FF00;
			}
			else if(cmd==0x7A){//blue color
				currentColor=0x000000FF;
			}
			else if(cmd==0x10){//white color
				currentColor=0x00FFFFFF;
			}
			else if(cmd==0x38){//yellow color
				currentColor=0x00FFFF00;
			}
			else if(cmd==0x5A){//purple color
				currentColor=0x008000FF;
			}
			else if(cmd==0x42){//cyan color
				currentColor=0x0000FFFF;
			}
			else if(cmd==0x4A){//orange color
				currentColor=0x00FF2000;
			}
			else if(cmd==0x52){//pink color
				currentColor=0x00FF1493;
			}
			if(cmd==0x30||cmd==0x18||cmd==0x7A||//1:red,2:green ,3:blue
					cmd==0x10||cmd==0x38||cmd==0x5A||//4:white,5:yellow ,6:purple
					cmd==0x42||cmd==0x4A||cmd==0x52||//7:greenblue,8:lemon ,9:pink
					cmd==0xE0||cmd==0xA8||cmd==0x68){//-:decrease,+:increase,0:off
			  for(i=0;i<ledNumber;i++){
					ws2812SendOneLed(currentColor,percent);
				}
				ws2812SendReset(RES);
				for(d=0;d<10000;d++);
			}//end of last if
		}//end of TrueAddress and TrueCommand
	}//end of frame_ready
}//end of while(1)
}//end of main

void ws2812SendByte(uint8_t data){
	uint8_t j;
	for(j=0;j<8;j++){
		while(SPI_GetFlagStatus(SPI_FLAG_TXE)==RESET);
		if(data & 0x80){
			SPI_SendData(0x7C);
		}
		else{
			SPI_SendData(0x70);		
		}
		data<<=1;
	}
}

void ws2812SendOneLed(uint32_t color,uint8_t per){
	uint8_t r,g,b;
	r=(color>>16)&0xff;
	g=(color>>8)&0xff;
	b=color&0xff;
	
	r=((uint16_t)r*per)/100;
	g=((uint16_t)g*per)/100;
	b=((uint16_t)b*per)/100;
	
	ws2812SendByte(g);
	ws2812SendByte(r);
	ws2812SendByte(b);
}

void ws2812SendReset(uint8_t reset){
uint8_t j;
	for(j=0;j<reset;j++){
			while(SPI_GetFlagStatus(SPI_FLAG_TXE)==RESET);
			SPI_SendData(0x00);		
	}
	while(SPI_GetFlagStatus(SPI_FLAG_BSY)==SET);
}


