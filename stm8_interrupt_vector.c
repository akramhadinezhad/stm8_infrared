/*	BASIC INTERRUPT VECTOR TABLE FOR STM8 devices
 *	Copyright (c) 2007 STMicroelectronics
 */
#include "stm8s.h"
extern volatile uint32_t remoteReceived;
extern volatile uint16_t currentTime,previousTime,Delta;
extern volatile uint8_t state,bitIndex,frameReady;

INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler,12);
typedef void @far (*interrupt_handler_t)(void);

struct interrupt_vector {
	unsigned char interrupt_instruction;
	interrupt_handler_t interrupt_handler;
};

@far @interrupt void NonHandledInterrupt (void)
{
	/* in order to detect unexpected events during development, 
	   it is recommended to set a breakpoint on the following instruction
	*/
	return;
}


extern void _stext();     /* startup routine */
INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler,12){
	currentTime=TIM1_GetCapture3();
	TIM1_ClearITPendingBit(TIM1_IT_CC3);
	Delta=currentTime-previousTime;
	previousTime=currentTime;
	if(state==0){
		if(12000<=Delta && Delta<=15000){/*1.leader recognization*/
			state=1;
			bitIndex=0;
			remoteReceived=0;
		}
	}/*end of state=0*/
	else if(state==1){
		if(900<=Delta && Delta<=1300){/*bit0*/
			remoteReceived=(remoteReceived<<1);
			bitIndex++;
		}
		else if(1900<=Delta && Delta<=2500){/*bit1*/
			remoteReceived=(remoteReceived<<1)|1;
			bitIndex++;		
		}
		else if(10000<=Delta && Delta<=12500){/*repeated code*/
			state=0;
			bitIndex=0;
		}
		else if(Delta>15000){/*very big wrong delta like 39000*/
			state=0;
			bitIndex=0;		
		}
		if(bitIndex>=32){
			frameReady=1;
			state=0;
			bitIndex=0;
		}
	}/*end of state=1*/
}/*end of interrupt function*/
struct interrupt_vector const _vectab[] = {
	{0x82, (interrupt_handler_t)_stext}, /* reset */
	{0x82, NonHandledInterrupt}, /* trap  */
	{0x82, NonHandledInterrupt}, /* irq0  */
	{0x82, NonHandledInterrupt}, /* irq1  */
	{0x82, NonHandledInterrupt}, /* irq2  */
	{0x82, NonHandledInterrupt}, /* irq3  */
	{0x82, NonHandledInterrupt}, /* irq4  */
	{0x82, NonHandledInterrupt}, /* irq5  */
	{0x82, NonHandledInterrupt}, /* irq6  */
	{0x82, NonHandledInterrupt}, /* irq7  */
	{0x82, NonHandledInterrupt}, /* irq8  */
	{0x82, NonHandledInterrupt}, /* irq9  */
	{0x82, NonHandledInterrupt}, /* irq10 */
	{0x82, NonHandledInterrupt}, /* irq11 */
	{0x82, TIM1_CAP_COM_IRQHandler}, /* irq12 */
	{0x82, NonHandledInterrupt}, /* irq13 */
	{0x82, NonHandledInterrupt}, /* irq14 */
	{0x82, NonHandledInterrupt}, /* irq15 */
	{0x82, NonHandledInterrupt}, /* irq16 */
	{0x82, NonHandledInterrupt}, /* irq17 */
	{0x82, NonHandledInterrupt}, /* irq18 */
	{0x82, NonHandledInterrupt}, /* irq19 */
	{0x82, NonHandledInterrupt}, /* irq20 */
	{0x82, NonHandledInterrupt}, /* irq21 */
	{0x82, NonHandledInterrupt}, /* irq22 */
	{0x82, NonHandledInterrupt}, /* irq23 */
	{0x82, NonHandledInterrupt}, /* irq24 */
	{0x82, NonHandledInterrupt}, /* irq25 */
	{0x82, NonHandledInterrupt}, /* irq26 */
	{0x82, NonHandledInterrupt}, /* irq27 */
	{0x82, NonHandledInterrupt}, /* irq28 */
	{0x82, NonHandledInterrupt}, /* irq29 */
};
