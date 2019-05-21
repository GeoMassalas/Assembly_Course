;
; sinewave.asm
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
zinit:
		LDI ZH, HIGH(sine << 1)
		LDI ZL, LOW(sine << 1)
loop:
		LPM R20, Z+
		OUT PORTB, R20
		CPI R20, 116
		BREQ zinit
		rjmp loop

		.ORG 0x100
sine:	.DB 128,140,152,165,176,188,198,208,218,226,234,240,245,250,253,254,255,254,253,250,245,240,234,226,218,208,198,188,176,165,152,140,128,115,103,90,79,67,57,47,37,29,21,15,10,5,2,1,0,1,2,5,10,15,21,29,37,47,57,67,79,90,103,116

