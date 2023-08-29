;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.0 #14184 (Linux)
;--------------------------------------------------------
	.module blinky
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _TIM4_ARR
	.globl _TIM4_PSCR
	.globl _TIM4_CTR
	.globl _TIM4_SR1
	.globl _TIM4_CR1
	.globl _CLK_PCKENR1
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
_CLK_PCKENR1::
	.ds 2
_TIM4_CR1::
	.ds 2
_TIM4_SR1::
	.ds 2
_TIM4_CTR::
	.ds 2
_TIM4_PSCR::
	.ds 2
_TIM4_ARR::
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
;	blinky.c: 35: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #4
;	blinky.c: 39: *CLK_PCKENR1 |= (1 << PCKENR1_2_TIM4);
	ldw	x, _CLK_PCKENR1+0
	ld	a, (x)
	or	a, #0x04
	ld	(x), a
;	blinky.c: 43: *TIM4_PSCR = (0x0D);
	ldw	x, _TIM4_PSCR+0
	ld	a, #0x0d
	ld	(x), a
;	blinky.c: 48: volatile uint32_t arr_top = (244 * delay_ms) / 1000;
	ldw	x, #0x0018
	ldw	(0x03, sp), x
	clrw	x
	ldw	(0x01, sp), x
;	blinky.c: 49: *TIM4_ARR = (uint8_t)arr_top;
	ldw	x, _TIM4_ARR+0
	ld	a, (0x04, sp)
	ld	(x), a
;	blinky.c: 52: *TIM4_CR1 |= 0x01;
	ldw	x, _TIM4_CR1+0
	ld	a, (x)
	or	a, #0x01
	ld	(x), a
;	blinky.c: 55: *PB_DDR |= (1 << LED_PIN); // set LED pin as output
	ldw	x, _PB_DDR+0
	ld	a, (x)
	or	a, #0x01
	ld	(x), a
;	blinky.c: 56: *PB_CR1 |= (1 << LED_PIN); // set LED pin as push-pull
	ldw	x, _PB_CR1+0
	ld	a, (x)
	or	a, #0x01
	ld	(x), a
;	blinky.c: 59: *PB_ODR &= ~(1 << LED_PIN);
	ldw	x, _PB_ODR+0
	ld	a, (x)
	and	a, #0xfe
	ld	(x), a
;	blinky.c: 61: while (1)
00104$:
;	blinky.c: 64: if (*TIM4_SR1 & 0x01)
	ldw	x, _TIM4_SR1+0
	ld	a, (x)
	srl	a
	jrnc	00104$
;	blinky.c: 67: *TIM4_SR1 &= ~(0x01);
	ld	a, (x)
	and	a, #0xfe
	ld	(x), a
;	blinky.c: 69: *TIM4_CTR = 0x00;
	ldw	x, _TIM4_CTR+0
	clr	(x)
;	blinky.c: 59: *PB_ODR &= ~(1 << LED_PIN);
	ldw	x, _PB_ODR+0
;	blinky.c: 71: *PB_ODR ^= (1 << LED_PIN);
	ld	a, (x)
	xor	a, #0x01
	ld	(x), a
	jra	00104$
;	blinky.c: 74: }
	addw	sp, #4
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
__xinit__CLK_PCKENR1:
	.dw #0x50c3
__xinit__TIM4_CR1:
	.dw #0x52e0
__xinit__TIM4_SR1:
	.dw #0x52e5
__xinit__TIM4_CTR:
	.dw #0x52e7
__xinit__TIM4_PSCR:
	.dw #0x52e8
__xinit__TIM4_ARR:
	.dw #0x52e9
	.area CABS (ABS)
