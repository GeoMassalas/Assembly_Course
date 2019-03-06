; AssemblerApplication2.asm
;
; Created: 16/1/2019 8:20:13 ??
; Author : gmassalas
;
; Replace with your application code
jmp init
.org 0x001E jmp TIMER1_OVF
TIMER1_OVF:
		in r22, SREG
		cli
		dec r18
		OUT PORTB, r18
		STS TCNT1H, r19		 
		STS TCNT1L, r21
		OUT SREG, r22
		reti

init:
		LDI r18, HIGH(RAMEND)
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
main:
		nop
		RJMP main

