;
; AssemblerApplication2.asm
;
; Created: 16/1/2019 8:20:13 μμ
; Author : lazyb
;


; Replace with your application code

init:
		LDI r18, 0xFF				

		LDI r17, 0xFF				; portb as output
		OUT DDRB, r17

		LDI r17, 0x00
		STS TCCR1A, r17				; compare mode off // PWM mode off

		LDI r17, 0x05
		STS TCCR1B, r17				; prescaler 256 -- > 0x05

		LDI r19, 0x57				; 0x5762 <-- Innitialize TCNT register so we get exactly 1 second counter
		LDI r21, 0x62
		LDI r20, 0x01
clockset:
		STS TCNT1H, r19		 
		STS TCNT1L, r21
		OUT TIFR1, r20				; clear overflow flag
loop:
		IN R17, TIFR1
		SBRS R17, TOV1				; if flag is set add + 1
		RJMP loop
		dec r18						; complementary logic
		OUT PORTB, r18
		RJMP clockset