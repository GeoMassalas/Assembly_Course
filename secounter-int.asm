; AssemblerApplication2.asm
;
; Created: 05/03/2019
; Author : gmassalas
;
; Replace with your application code
			jmp init
			nop
			reti			;INT0				; 
			nop
			reti			;INT1	
			nop
			reti			;INT2	
			nop
			reti			;PCINT0
			nop
			reti			;PCINT1
			nop
			reti			;PCINT2
			nop
			reti			;PCINT3
			nop
			reti			;WDT
			nop
			reti			;TIMER2_COMPA
			nop
			reti			;TIMER2_COMPB
			nop
			reti			;TIMER2_OVF
			nop
			reti			;TIMER1_CAPT
			nop
			reti			;TIMER1COMPA
			nop
			reti			;TIMER1COMPB
			nop
			jmp TIMER1_OVF	;TIMER1_OVF
			nop
			reti			;TIMER0_COMPA
			nop
			reti			;TIMER0_COMPB
			nop
			reti			;TIMER0_OVF
			nop
			reti			;SPISTC
			nop
			reti			;USART0_RX
			nop
			reti			;USART0_UDRE
			nop
			reti			;USART0_TX
			nop
			reti			;ANALOG_COMP
			nop
			reti			;ADC
			nop
			reti			;EE_READY
			nop
			reti			;TWI
			nop
			reti			;SPM_READY
			nop
			reti			;USART1_RX
			nop
			reti			;USART1_UDRE
			nop
			reti			;USART1_TX
			nop
			reti			;TIMER3_CAPT
			nop
			reti			;TIMER3_COMPA
			nop
			reti			;TIMER3_COMPB
			nop
			reti			;TIMER3_OVF
			nop

TIMER1_OVF:							; interrupt routine
		in r22, SREG				; keep current SREG
		cli
		dec r18						; increase counter (complemetary logic)
		OUT PORTB, r18		
		STS TCNT1H, r19				;reinitialize counter
		STS TCNT1L, r21
		OUT SREG, r22
		reti

init:
		LDI r18, HIGH(RAMEND)		;initialize stack pointer
		OUT SPH, r18
		LDI r18, LOW(RAMEND)
		OUT SPH, r18		
		Ldi r18, 0xfF
		LDI r17, 0xFF				; portb as output
		OUT DDRB, r17

		LDI r17, 0x00
		STS TCCR1A, r17				; compare mode off // PWM mode off

		LDI r17, 0x04
		STS TCCR1B, r17				; prescaler 256 -- > 0x04

		LDI r19, 0x57				; 0x5762 <-- Innitialize TCNT register so we get exactly 1 second counter
		LDI r21, 0x62
		LDI r20, ( 1 << TOIE1)
		STS TCNT1H, r19		 
		STS TCNT1L, r21
		STS TIMSK1, r20
		SEI
main:								; main loop
		nop
		RJMP main

