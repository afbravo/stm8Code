;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.0 #14184 (Linux)
;--------------------------------------------------------
	.module main
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
G$PB_ODR$0_0$0==.
_PB_ODR::
	.ds 2
G$PB_DDR$0_0$0==.
_PB_DDR::
	.ds 2
G$PB_CR1$0_0$0==.
_PB_CR1::
	.ds 2
G$PB_CR2$0_0$0==.
_PB_CR2::
	.ds 2
G$PD_IDR$0_0$0==.
_PD_IDR::
	.ds 2
G$PD_DDR$0_0$0==.
_PD_DDR::
	.ds 2
G$PD_CR1$0_0$0==.
_PD_CR1::
	.ds 2
G$PD_CR2$0_0$0==.
_PD_CR2::
	.ds 2
G$CLK_PCKENR1$0_0$0==.
_CLK_PCKENR1::
	.ds 2
G$TIM4_CR1$0_0$0==.
_TIM4_CR1::
	.ds 2
G$TIM4_SR1$0_0$0==.
_TIM4_SR1::
	.ds 2
G$TIM4_CTR$0_0$0==.
_TIM4_CTR::
	.ds 2
G$TIM4_PSCR$0_0$0==.
_TIM4_PSCR::
	.ds 2
G$TIM4_ARR$0_0$0==.
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
	Smain$main$0 ==.
;	main.c: 35: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	Smain$main$1 ==.
	sub	sp, #4
	Smain$main$2 ==.
	Smain$main$3 ==.
;	main.c: 39: *CLK_PCKENR1 |= (1 << PCKENR1_2_TIM4);
	ldw	x, _CLK_PCKENR1+0
	ld	a, (x)
	or	a, #0x04
	ld	(x), a
	Smain$main$4 ==.
;	main.c: 43: *TIM4_PSCR = (0x0D);
	ldw	x, _TIM4_PSCR+0
	ld	a, #0x0d
	ld	(x), a
	Smain$main$5 ==.
	Smain$main$6 ==.
;	main.c: 48: volatile uint32_t arr_top = (244 * delay_ms) / 1000;
	ldw	x, #0x0018
	ldw	(0x03, sp), x
	clrw	x
	ldw	(0x01, sp), x
	Smain$main$7 ==.
;	main.c: 49: *TIM4_ARR = (uint8_t)arr_top;
	ldw	x, _TIM4_ARR+0
	ld	a, (0x04, sp)
	ld	(x), a
	Smain$main$8 ==.
	Smain$main$9 ==.
;	main.c: 52: *TIM4_CR1 |= 0x01;
	ldw	x, _TIM4_CR1+0
	ld	a, (x)
	or	a, #0x01
	ld	(x), a
	Smain$main$10 ==.
;	main.c: 55: *PB_DDR |= (1 << LED_PIN); // set LED pin as output
	ldw	x, _PB_DDR+0
	ld	a, (x)
	or	a, #0x01
	ld	(x), a
	Smain$main$11 ==.
;	main.c: 56: *PB_CR1 |= (1 << LED_PIN); // set LED pin as push-pull
	ldw	x, _PB_CR1+0
	ld	a, (x)
	or	a, #0x01
	ld	(x), a
	Smain$main$12 ==.
;	main.c: 59: *PB_ODR &= ~(1 << LED_PIN);
	ldw	x, _PB_ODR+0
	ld	a, (x)
	and	a, #0xfe
	ld	(x), a
	Smain$main$13 ==.
;	main.c: 61: while (1)
00104$:
	Smain$main$14 ==.
;	main.c: 64: if (*TIM4_SR1 & 0x01)
	ldw	x, _TIM4_SR1+0
	Smain$main$15 ==.
	ld	a, (x)
	srl	a
	jrnc	00104$
	Smain$main$16 ==.
	Smain$main$17 ==.
;	main.c: 67: *TIM4_SR1 &= ~(0x01);
	ld	a, (x)
	and	a, #0xfe
	ld	(x), a
	Smain$main$18 ==.
;	main.c: 69: *TIM4_CTR = 0x00;
	ldw	x, _TIM4_CTR+0
	clr	(x)
	Smain$main$19 ==.
	Smain$main$20 ==.
;	main.c: 59: *PB_ODR &= ~(1 << LED_PIN);
	ldw	x, _PB_ODR+0
	Smain$main$21 ==.
;	main.c: 71: *PB_ODR ^= (1 << LED_PIN);
	ld	a, (x)
	xor	a, #0x01
	ld	(x), a
	jra	00104$
	Smain$main$22 ==.
;	main.c: 74: }
	addw	sp, #4
	Smain$main$23 ==.
	Smain$main$24 ==.
	XG$main$0$0 ==.
	ret
	Smain$main$25 ==.
	.area CODE
	.area CONST
	.area INITIALIZER
Fmain$__xinit_PB_ODR$0_0$0 == .
__xinit__PB_ODR:
	.dw #0x5005
Fmain$__xinit_PB_DDR$0_0$0 == .
__xinit__PB_DDR:
	.dw #0x5007
Fmain$__xinit_PB_CR1$0_0$0 == .
__xinit__PB_CR1:
	.dw #0x5008
Fmain$__xinit_PB_CR2$0_0$0 == .
__xinit__PB_CR2:
	.dw #0x5009
Fmain$__xinit_PD_IDR$0_0$0 == .
__xinit__PD_IDR:
	.dw #0x5010
Fmain$__xinit_PD_DDR$0_0$0 == .
__xinit__PD_DDR:
	.dw #0x5011
Fmain$__xinit_PD_CR1$0_0$0 == .
__xinit__PD_CR1:
	.dw #0x5012
Fmain$__xinit_PD_CR2$0_0$0 == .
__xinit__PD_CR2:
	.dw #0x5013
Fmain$__xinit_CLK_PCKENR1$0_0$0 == .
__xinit__CLK_PCKENR1:
	.dw #0x50c3
Fmain$__xinit_TIM4_CR1$0_0$0 == .
__xinit__TIM4_CR1:
	.dw #0x52e0
Fmain$__xinit_TIM4_SR1$0_0$0 == .
__xinit__TIM4_SR1:
	.dw #0x52e5
Fmain$__xinit_TIM4_CTR$0_0$0 == .
__xinit__TIM4_CTR:
	.dw #0x52e7
Fmain$__xinit_TIM4_PSCR$0_0$0 == .
__xinit__TIM4_PSCR:
	.dw #0x52e8
Fmain$__xinit_TIM4_ARR$0_0$0 == .
__xinit__TIM4_ARR:
	.dw #0x52e9
	.area CABS (ABS)

	.area .debug_line (NOLOAD)
	.dw	0,Ldebug_line_end-Ldebug_line_start
Ldebug_line_start:
	.dw	2
	.dw	0,Ldebug_line_stmt-6-Ldebug_line_start
	.db	1
	.db	1
	.db	-5
	.db	15
	.db	10
	.db	0
	.db	1
	.db	1
	.db	1
	.db	1
	.db	0
	.db	0
	.db	0
	.db	1
	.ascii "/usr/bin/../share/sdcc/include/stm8"
	.db	0
	.ascii "/usr/share/sdcc/include/stm8"
	.db	0
	.ascii "/usr/bin/../share/sdcc/include"
	.db	0
	.ascii "/usr/share/sdcc/include"
	.db	0
	.db	0
	.ascii "main.c"
	.db	0
	.uleb128	0
	.uleb128	0
	.uleb128	0
	.db	0
Ldebug_line_stmt:
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$0)
	.db	3
	.sleb128	34
	.db	1
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$3)
	.db	3
	.sleb128	4
	.db	1
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$4)
	.db	3
	.sleb128	4
	.db	1
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$6)
	.db	3
	.sleb128	5
	.db	1
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$7)
	.db	3
	.sleb128	1
	.db	1
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$9)
	.db	3
	.sleb128	3
	.db	1
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$10)
	.db	3
	.sleb128	3
	.db	1
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$11)
	.db	3
	.sleb128	1
	.db	1
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$12)
	.db	3
	.sleb128	3
	.db	1
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$13)
	.db	3
	.sleb128	2
	.db	1
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$14)
	.db	3
	.sleb128	3
	.db	1
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$17)
	.db	3
	.sleb128	3
	.db	1
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$18)
	.db	3
	.sleb128	2
	.db	1
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$20)
	.db	3
	.sleb128	-10
	.db	1
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$21)
	.db	3
	.sleb128	12
	.db	1
	.db	0
	.uleb128	5
	.db	2
	.dw	0,(Smain$main$22)
	.db	3
	.sleb128	3
	.db	1
	.db	9
	.dw	1+Smain$main$24-Smain$main$22
	.db	0
	.uleb128	1
	.db	1
Ldebug_line_end:

	.area .debug_loc (NOLOAD)
Ldebug_loc_start:
	.dw	0,(Smain$main$23)
	.dw	0,(Smain$main$25)
	.dw	2
	.db	120
	.sleb128	1
	.dw	0,(Smain$main$2)
	.dw	0,(Smain$main$23)
	.dw	2
	.db	120
	.sleb128	5
	.dw	0,(Smain$main$1)
	.dw	0,(Smain$main$2)
	.dw	2
	.db	120
	.sleb128	1
	.dw	0,0
	.dw	0,0

	.area .debug_abbrev (NOLOAD)
Ldebug_abbrev:
	.uleb128	1
	.uleb128	17
	.db	1
	.uleb128	3
	.uleb128	8
	.uleb128	16
	.uleb128	6
	.uleb128	19
	.uleb128	11
	.uleb128	37
	.uleb128	8
	.uleb128	0
	.uleb128	0
	.uleb128	2
	.uleb128	36
	.db	0
	.uleb128	3
	.uleb128	8
	.uleb128	11
	.uleb128	11
	.uleb128	62
	.uleb128	11
	.uleb128	0
	.uleb128	0
	.uleb128	3
	.uleb128	46
	.db	1
	.uleb128	1
	.uleb128	19
	.uleb128	3
	.uleb128	8
	.uleb128	17
	.uleb128	1
	.uleb128	18
	.uleb128	1
	.uleb128	63
	.uleb128	12
	.uleb128	64
	.uleb128	6
	.uleb128	73
	.uleb128	19
	.uleb128	0
	.uleb128	0
	.uleb128	4
	.uleb128	11
	.db	1
	.uleb128	17
	.uleb128	1
	.uleb128	18
	.uleb128	1
	.uleb128	0
	.uleb128	0
	.uleb128	5
	.uleb128	11
	.db	1
	.uleb128	1
	.uleb128	19
	.uleb128	17
	.uleb128	1
	.uleb128	0
	.uleb128	0
	.uleb128	6
	.uleb128	11
	.db	0
	.uleb128	17
	.uleb128	1
	.uleb128	18
	.uleb128	1
	.uleb128	0
	.uleb128	0
	.uleb128	7
	.uleb128	52
	.db	0
	.uleb128	2
	.uleb128	10
	.uleb128	3
	.uleb128	8
	.uleb128	73
	.uleb128	19
	.uleb128	0
	.uleb128	0
	.uleb128	8
	.uleb128	53
	.db	0
	.uleb128	73
	.uleb128	19
	.uleb128	0
	.uleb128	0
	.uleb128	9
	.uleb128	15
	.db	0
	.uleb128	11
	.uleb128	11
	.uleb128	73
	.uleb128	19
	.uleb128	0
	.uleb128	0
	.uleb128	10
	.uleb128	52
	.db	0
	.uleb128	2
	.uleb128	10
	.uleb128	3
	.uleb128	8
	.uleb128	63
	.uleb128	12
	.uleb128	73
	.uleb128	19
	.uleb128	0
	.uleb128	0
	.uleb128	0

	.area .debug_info (NOLOAD)
	.dw	0,Ldebug_info_end-Ldebug_info_start
Ldebug_info_start:
	.dw	2
	.dw	0,(Ldebug_abbrev)
	.db	4
	.uleb128	1
	.ascii "main.c"
	.db	0
	.dw	0,(Ldebug_line_start+-4)
	.db	1
	.ascii "SDCC version 4.3.0 #14184"
	.db	0
	.uleb128	2
	.ascii "int"
	.db	0
	.db	2
	.db	5
	.uleb128	3
	.dw	0,169
	.ascii "main"
	.db	0
	.dw	0,(_main)
	.dw	0,(XG$main$0$0+1)
	.db	1
	.dw	0,(Ldebug_loc_start)
	.dw	0,50
	.uleb128	4
	.dw	0,(Smain$main$5)
	.dw	0,(Smain$main$8)
	.uleb128	5
	.dw	0,112
	.dw	0,(Smain$main$15)
	.uleb128	6
	.dw	0,(Smain$main$16)
	.dw	0,(Smain$main$19)
	.uleb128	0
	.uleb128	7
	.db	2
	.db	145
	.sleb128	0
	.ascii "top_1sec"
	.db	0
	.dw	0,169
	.uleb128	7
	.db	2
	.db	145
	.sleb128	0
	.ascii "delay_ms"
	.db	0
	.dw	0,186
	.uleb128	8
	.dw	0,186
	.uleb128	7
	.db	2
	.db	145
	.sleb128	-4
	.ascii "arr_top"
	.db	0
	.dw	0,146
	.uleb128	0
	.uleb128	0
	.uleb128	2
	.ascii "unsigned char"
	.db	0
	.db	1
	.db	8
	.uleb128	2
	.ascii "unsigned long"
	.db	0
	.db	4
	.db	7
	.uleb128	8
	.dw	0,169
	.uleb128	9
	.db	2
	.dw	0,203
	.uleb128	10
	.db	5
	.db	3
	.dw	0,(_PB_ODR)
	.ascii "PB_ODR"
	.db	0
	.db	1
	.dw	0,208
	.uleb128	10
	.db	5
	.db	3
	.dw	0,(_PB_DDR)
	.ascii "PB_DDR"
	.db	0
	.db	1
	.dw	0,208
	.uleb128	10
	.db	5
	.db	3
	.dw	0,(_PB_CR1)
	.ascii "PB_CR1"
	.db	0
	.db	1
	.dw	0,208
	.uleb128	10
	.db	5
	.db	3
	.dw	0,(_PB_CR2)
	.ascii "PB_CR2"
	.db	0
	.db	1
	.dw	0,208
	.uleb128	10
	.db	5
	.db	3
	.dw	0,(_PD_IDR)
	.ascii "PD_IDR"
	.db	0
	.db	1
	.dw	0,208
	.uleb128	10
	.db	5
	.db	3
	.dw	0,(_PD_DDR)
	.ascii "PD_DDR"
	.db	0
	.db	1
	.dw	0,208
	.uleb128	10
	.db	5
	.db	3
	.dw	0,(_PD_CR1)
	.ascii "PD_CR1"
	.db	0
	.db	1
	.dw	0,208
	.uleb128	10
	.db	5
	.db	3
	.dw	0,(_PD_CR2)
	.ascii "PD_CR2"
	.db	0
	.db	1
	.dw	0,208
	.uleb128	10
	.db	5
	.db	3
	.dw	0,(_CLK_PCKENR1)
	.ascii "CLK_PCKENR1"
	.db	0
	.db	1
	.dw	0,208
	.uleb128	10
	.db	5
	.db	3
	.dw	0,(_TIM4_CR1)
	.ascii "TIM4_CR1"
	.db	0
	.db	1
	.dw	0,208
	.uleb128	10
	.db	5
	.db	3
	.dw	0,(_TIM4_SR1)
	.ascii "TIM4_SR1"
	.db	0
	.db	1
	.dw	0,208
	.uleb128	10
	.db	5
	.db	3
	.dw	0,(_TIM4_CTR)
	.ascii "TIM4_CTR"
	.db	0
	.db	1
	.dw	0,208
	.uleb128	10
	.db	5
	.db	3
	.dw	0,(_TIM4_PSCR)
	.ascii "TIM4_PSCR"
	.db	0
	.db	1
	.dw	0,208
	.uleb128	10
	.db	5
	.db	3
	.dw	0,(_TIM4_ARR)
	.ascii "TIM4_ARR"
	.db	0
	.db	1
	.dw	0,208
	.uleb128	0
Ldebug_info_end:

	.area .debug_pubnames (NOLOAD)
	.dw	0,Ldebug_pubnames_end-Ldebug_pubnames_start
Ldebug_pubnames_start:
	.dw	2
	.dw	0,(Ldebug_info_start-4)
	.dw	0,4+Ldebug_info_end-Ldebug_info_start
	.dw	0,57
	.ascii "main"
	.db	0
	.dw	0,214
	.ascii "PB_ODR"
	.db	0
	.dw	0,233
	.ascii "PB_DDR"
	.db	0
	.dw	0,252
	.ascii "PB_CR1"
	.db	0
	.dw	0,271
	.ascii "PB_CR2"
	.db	0
	.dw	0,290
	.ascii "PD_IDR"
	.db	0
	.dw	0,309
	.ascii "PD_DDR"
	.db	0
	.dw	0,328
	.ascii "PD_CR1"
	.db	0
	.dw	0,347
	.ascii "PD_CR2"
	.db	0
	.dw	0,366
	.ascii "CLK_PCKENR1"
	.db	0
	.dw	0,390
	.ascii "TIM4_CR1"
	.db	0
	.dw	0,411
	.ascii "TIM4_SR1"
	.db	0
	.dw	0,432
	.ascii "TIM4_CTR"
	.db	0
	.dw	0,453
	.ascii "TIM4_PSCR"
	.db	0
	.dw	0,475
	.ascii "TIM4_ARR"
	.db	0
	.dw	0,0
Ldebug_pubnames_end:

	.area .debug_frame (NOLOAD)
	.dw	0
	.dw	Ldebug_CIE0_end-Ldebug_CIE0_start
Ldebug_CIE0_start:
	.dw	0xffff
	.dw	0xffff
	.db	1
	.db	0
	.uleb128	1
	.sleb128	-1
	.db	9
	.db	12
	.uleb128	8
	.uleb128	2
	.db	137
	.uleb128	1
	.db	0
	.db	0
Ldebug_CIE0_end:
	.dw	0,36
	.dw	0,(Ldebug_CIE0_start-4)
	.dw	0,(Smain$main$1)	;initial loc
	.dw	0,Smain$main$25-Smain$main$1
	.db	1
	.dw	0,(Smain$main$1)
	.db	14
	.uleb128	2
	.db	1
	.dw	0,(Smain$main$2)
	.db	14
	.uleb128	6
	.db	1
	.dw	0,(Smain$main$23)
	.db	14
	.uleb128	2
	.db	0
	.db	0
	.db	0
