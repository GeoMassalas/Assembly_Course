;
; Triangularwave.asm
;
; Created: 19/5/2019 3:56:43 μμ
; Author : lazyb
;


; Replace with your application code
	.org 0x00
start:
		LDI R17, HIGH(RAMEND)
		OUT SPH, R17
		LDI R17, LOW(RAMEND)
		OUT SPL, R17

		LDI R17, 0xFF
		OUT DDRB, R17

fall:
		OUT PORTB, R17
		DEC R17
		BRNE fall
rise:
		OUT PORTB, R17
		INC R17
		CPI R17, 0xFF
		BRNE rise
		OUT PORTB, R17
		RJMP fall

