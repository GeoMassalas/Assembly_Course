;
; AssemblerApplication1.asm
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
		cli	
		LPM R25, Z+
		OUT PORTB, R25
		CPI R25, 116
		BREQ zinit		
cinit:
		STS TCNT1H, r19				;reinitialize counter
		STS TCNT1L, r21
		reti
zinit:
		LDI ZH, HIGH(sine << 1)
		LDI ZL, LOW(sine << 1)
		STS TCNT1H, r19				;reinitialize counter
		STS TCNT1L, r21
		reti

init:
		LDI r18, HIGH(RAMEND)		;initialize stack pointer
		OUT SPH, r18
		LDI r18, LOW(RAMEND)
		OUT SPL, r18		
		Ldi r18, 0xfF

		LDI ZH, HIGH(sine << 1)		;initialize z pointer
		LDI ZL, LOW(sine << 1)

		LDI r17, 0xFF			; portb as output
		OUT DDRB, r17
		LDI R17, 0x00
		OUT DDRA, R17			; porta input declaration 

		LDI R17, 0xE0			; ADMUX register setup: analog channel A0 / VREF >> internal 2,64V / 8bit resolution
		STS ADMUX, R17

		LDI R17, 0x80			; ADCSRA register setup: 1/2 prescaler / interrupts-autotrigger off
		STS ADCSRA, R17

		LDI r17, 0x00
		STS TCCR1A, r17				; compare mode off // PWM mode off


		LDI r17, 0x01
		STS TCCR1B, r17				; prescaler 1 -- > 0x01

		LDI r19, 0xAA				; 0x5762 <-- Innitialize TCNT register so we get exactly 1 second counter
		LDI r21, 0x00
		LDI r20, ( 1 << TOIE1)
		STS TCNT1H, r19		 
		STS TCNT1L, r21
		STS TIMSK1, r20
		SEI

AdscSet:
		LDS R17, ADCSRA
		SBR R17, 0x40			; setting ADSC << 1
		STS ADCSRA, R17
main:
		LDS R17, ADCSRA
		SBRS R17, ADIF			; wait until ADIF gets to 1
		RJMP main
		LDS R19, ADCH			; ADCH(digital output with 8bit resolution) output on port b
		RJMP AdscSet

		.ORG 0x100
sine:	.DB 128,140,152,165,176,188,198,208,218,226,234,240,245,250,253,254,255,254,253,250,245,240,234,226,218,208,198,188,176,165,152,140,128,115,103,90,79,67,57,47,37,29,21,15,10,5,2,1,0,1,2,5,10,15,21,29,37,47,57,67,79,90,103,116

