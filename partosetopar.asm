;
; serialtoparallel.asm
;
; Created: 14/2/2019 8:36:40 μμ
; Author : lazyb
;


; Replace with your application code
init:
		LDI r18, 0xFF				

		LDI r17, 0xFF				; portb as output
		OUT DDRB, r17

		LDI r20, 0xFF				; porta as output
		OUT DDRA, r20

		LDI r22, 0xF1				; variable in order to achive 8 clocks
		LDI r23, 0x01				; compare variable for xor

		LDI r17, 0x00
		STS TCCR1A, r17				; compare mode off // PWM mode off

		LDI r17, 0x04
		STS TCCR1B, r17				; prescaler 128 -- > 0x05

		LDI r19, 0x57				; 0x1762 <-- Initialize  TCNT register 
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
		LDI r20, 0x02				; initialization for the transfer part
		OUT PORTA, r20
		LDI r20, 0x03
		OUT PORTA, r20
transfer:
		EOR r20,r23					; creating a clock at pin0 with pin 1 staying the same (using XOR gate) for 8 clocks total
		OUT PORTA, r20
		INC r22
		BREQ endtr
		rjmp transfer
endtr:
		LDI r20, 0x00				; reinitialization and going back to start
		OUT PORTA, r20
		LDI r22, 0xF1
		LDI r20, 0x01
		rjmp clockset