;
; AssemblerApplication1.asm
;
; Created: 9/1/2019 4:23:36 μμ
; Author : gmassalas
; Description : Analog input sample program 
; Inputs(Analog) : A0
; Outputs(Digital) : PORTB

; Replace with your application code
		.ORG 0x00
init:	
		LDI R17, 0xFF
		OUT DDRB, R17			; portb output declaration 
		LDI R17, 0x00
		OUT DDRA, R17			; porta input declaration 

		LDI R17, 0xE0			; ADMUX register setup: analog channel A0 / VREF >> internal 2,64V / 8bit resolution
		STS ADMUX, R17

		LDI R17, 0x80			; ADCSRA register setup: 1/2 prescaler / interrupts-autotrigger off
		STS ADCSRA, R17
		

AdscSet:
		LDS R17, ADCSRA
		SBR R17, 0x40			; setting ADSC << 1
		STS ADCSRA, R17
loop:
		LDS R17, ADCSRA
		SBRS R17, ADIF			; wait until ADIF gets to 1
		RJMP loop
		LDS R17, ADCH			; ADCH(digital output with 8bit resolution) output on port b
		COM R17
		OUT PORTB, R17
		RJMP AdscSet

