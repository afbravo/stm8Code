;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.0 #14184 (Linux)
;--------------------------------------------------------
	.module led
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _PD_CR2
	.globl _PD_CR1
	.globl _PD_DDR
	.globl _PD_IDR
	.globl _PB_CR2
	.globl _PB_CR1
	.globl _PB_DDR
	.globl _PB_ODR
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_PB_ODR::
	.ds 2
_PB_DDR::
	.ds 2
_PB_CR1::
	.ds 2
_PB_CR2::
	.ds 2
_PD_IDR::
	.ds 2
_PD_DDR::
	.ds 2
_PD_CR1::
	.ds 2
_PD_CR2::
	.ds 2
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
	call	___sdcc_external_startup
	tnz	a
	jreq	__sdcc_init_data
	jp	__sdcc_program_startup
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	led.c: 20: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	push	a
;	led.c: 24: *PB_DDR |= (1 << LED_PIN);
	ldw	x, _PB_DDR+0
	ld	a, (x)
	or	a, #0x01
	ld	(x), a
;	led.c: 25: *PB_CR1 |= (1 << LED_PIN); // push-pull
	ldw	x, _PB_CR1+0
	ld	a, (x)
	or	a, #0x01
	ld	(x), a
;	led.c: 28: *PD_DDR &= ~(1 << BTN_PIN);
	ldw	x, _PD_DDR+0
	ld	a, (x)
	and	a, #0x7f
	ld	(x), a
;	led.c: 29: *PD_CR1 |= (1 << BTN_PIN);  // pull-up
	ldw	x, _PD_CR1+0
	ld	a, (x)
	or	a, #0x80
	ld	(x), a
;	led.c: 30: *PD_CR2 &= ~(1 << BTN_PIN); // interrupt disabled
	ldw	x, _PD_CR2+0
	ld	a, (x)
	and	a, #0x7f
	ld	(x), a
;	led.c: 32: while (1)
00105$:
;	led.c: 34: if ((*PD_IDR & (1 << BTN_PIN)) == 0)
	ldw	x, _PD_IDR+0
	ld	a, (x)
	ld	(0x01, sp), a
;	led.c: 36: *PB_ODR |= (1 << LED_PIN);
	ldw	x, _PB_ODR+0
	ld	a, (x)
;	led.c: 34: if ((*PD_IDR & (1 << BTN_PIN)) == 0)
	tnz	(0x01, sp)
	jrmi	00102$
;	led.c: 36: *PB_ODR |= (1 << LED_PIN);
	or	a, #0x01
	ld	(x), a
	jra	00105$
00102$:
;	led.c: 40: *PB_ODR &= ~(1 << LED_PIN);
	and	a, #0xfe
	ld	(x), a
	jra	00105$
;	led.c: 43: }
	pop	a
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__PB_ODR:
	.dw #0x5005
__xinit__PB_DDR:
	.dw #0x5007
__xinit__PB_CR1:
	.dw #0x5008
__xinit__PB_CR2:
	.dw #0x5009
__xinit__PD_IDR:
	.dw #0x5010
__xinit__PD_DDR:
	.dw #0x5011
__xinit__PD_CR1:
	.dw #0x5012
__xinit__PD_CR2:
	.dw #0x5013
	.area CABS (ABS)
