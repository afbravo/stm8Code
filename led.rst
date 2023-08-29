                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.3.0 #14184 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module led
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _PD_CR2
                                     13 	.globl _PD_CR1
                                     14 	.globl _PD_DDR
                                     15 	.globl _PD_IDR
                                     16 	.globl _PB_CR2
                                     17 	.globl _PB_CR1
                                     18 	.globl _PB_DDR
                                     19 	.globl _PB_ODR
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DATA
                                     24 ;--------------------------------------------------------
                                     25 ; ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area INITIALIZED
      000001                         28 _PB_ODR::
      000001                         29 	.ds 2
      000003                         30 _PB_DDR::
      000003                         31 	.ds 2
      000005                         32 _PB_CR1::
      000005                         33 	.ds 2
      000007                         34 _PB_CR2::
      000007                         35 	.ds 2
      000009                         36 _PD_IDR::
      000009                         37 	.ds 2
      00000B                         38 _PD_DDR::
      00000B                         39 	.ds 2
      00000D                         40 _PD_CR1::
      00000D                         41 	.ds 2
      00000F                         42 _PD_CR2::
      00000F                         43 	.ds 2
                                     44 ;--------------------------------------------------------
                                     45 ; Stack segment in internal ram
                                     46 ;--------------------------------------------------------
                                     47 	.area SSEG
      000011                         48 __start__stack:
      000011                         49 	.ds	1
                                     50 
                                     51 ;--------------------------------------------------------
                                     52 ; absolute external ram data
                                     53 ;--------------------------------------------------------
                                     54 	.area DABS (ABS)
                                     55 
                                     56 ; default segment ordering for linker
                                     57 	.area HOME
                                     58 	.area GSINIT
                                     59 	.area GSFINAL
                                     60 	.area CONST
                                     61 	.area INITIALIZER
                                     62 	.area CODE
                                     63 
                                     64 ;--------------------------------------------------------
                                     65 ; interrupt vector
                                     66 ;--------------------------------------------------------
                                     67 	.area HOME
      008000                         68 __interrupt_vect:
      008000 82 00 80 07             69 	int s_GSINIT ; reset
                                     70 ;--------------------------------------------------------
                                     71 ; global & static initialisations
                                     72 ;--------------------------------------------------------
                                     73 	.area HOME
                                     74 	.area GSINIT
                                     75 	.area GSFINAL
                                     76 	.area GSINIT
      008007 CD 80 7B         [ 4]   77 	call	___sdcc_external_startup
      00800A 4D               [ 1]   78 	tnz	a
      00800B 27 03            [ 1]   79 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   80 	jp	__sdcc_program_startup
      008010                         81 __sdcc_init_data:
                                     82 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   83 	ldw x, #l_DATA
      008013 27 07            [ 1]   84 	jreq	00002$
      008015                         85 00001$:
      008015 72 4F 00 00      [ 1]   86 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   87 	decw x
      00801A 26 F9            [ 1]   88 	jrne	00001$
      00801C                         89 00002$:
      00801C AE 00 10         [ 2]   90 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   91 	jreq	00004$
      008021                         92 00003$:
      008021 D6 80 2C         [ 1]   93 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   94 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   95 	decw	x
      008028 26 F7            [ 1]   96 	jrne	00003$
      00802A                         97 00004$:
                                     98 ; stm8_genXINIT() end
                                     99 	.area GSFINAL
      00802A CC 80 04         [ 2]  100 	jp	__sdcc_program_startup
                                    101 ;--------------------------------------------------------
                                    102 ; Home
                                    103 ;--------------------------------------------------------
                                    104 	.area HOME
                                    105 	.area HOME
      008004                        106 __sdcc_program_startup:
      008004 CC 80 3D         [ 2]  107 	jp	_main
                                    108 ;	return from main will return to caller
                                    109 ;--------------------------------------------------------
                                    110 ; code
                                    111 ;--------------------------------------------------------
                                    112 	.area CODE
                                    113 ;	led.c: 20: int main(void)
                                    114 ;	-----------------------------------------
                                    115 ;	 function main
                                    116 ;	-----------------------------------------
      00803D                        117 _main:
      00803D 88               [ 1]  118 	push	a
                                    119 ;	led.c: 24: *PB_DDR |= (1 << LED_PIN);
      00803E CE 00 03         [ 2]  120 	ldw	x, _PB_DDR+0
      008041 F6               [ 1]  121 	ld	a, (x)
      008042 AA 01            [ 1]  122 	or	a, #0x01
      008044 F7               [ 1]  123 	ld	(x), a
                                    124 ;	led.c: 25: *PB_CR1 |= (1 << LED_PIN); // push-pull
      008045 CE 00 05         [ 2]  125 	ldw	x, _PB_CR1+0
      008048 F6               [ 1]  126 	ld	a, (x)
      008049 AA 01            [ 1]  127 	or	a, #0x01
      00804B F7               [ 1]  128 	ld	(x), a
                                    129 ;	led.c: 28: *PD_DDR &= ~(1 << BTN_PIN);
      00804C CE 00 0B         [ 2]  130 	ldw	x, _PD_DDR+0
      00804F F6               [ 1]  131 	ld	a, (x)
      008050 A4 7F            [ 1]  132 	and	a, #0x7f
      008052 F7               [ 1]  133 	ld	(x), a
                                    134 ;	led.c: 29: *PD_CR1 |= (1 << BTN_PIN);  // pull-up
      008053 CE 00 0D         [ 2]  135 	ldw	x, _PD_CR1+0
      008056 F6               [ 1]  136 	ld	a, (x)
      008057 AA 80            [ 1]  137 	or	a, #0x80
      008059 F7               [ 1]  138 	ld	(x), a
                                    139 ;	led.c: 30: *PD_CR2 &= ~(1 << BTN_PIN); // interrupt disabled
      00805A CE 00 0F         [ 2]  140 	ldw	x, _PD_CR2+0
      00805D F6               [ 1]  141 	ld	a, (x)
      00805E A4 7F            [ 1]  142 	and	a, #0x7f
      008060 F7               [ 1]  143 	ld	(x), a
                                    144 ;	led.c: 32: while (1)
      008061                        145 00105$:
                                    146 ;	led.c: 34: if ((*PD_IDR & (1 << BTN_PIN)) == 0)
      008061 CE 00 09         [ 2]  147 	ldw	x, _PD_IDR+0
      008064 F6               [ 1]  148 	ld	a, (x)
      008065 6B 01            [ 1]  149 	ld	(0x01, sp), a
                                    150 ;	led.c: 36: *PB_ODR |= (1 << LED_PIN);
      008067 CE 00 01         [ 2]  151 	ldw	x, _PB_ODR+0
      00806A F6               [ 1]  152 	ld	a, (x)
                                    153 ;	led.c: 34: if ((*PD_IDR & (1 << BTN_PIN)) == 0)
      00806B 0D 01            [ 1]  154 	tnz	(0x01, sp)
      00806D 2B 05            [ 1]  155 	jrmi	00102$
                                    156 ;	led.c: 36: *PB_ODR |= (1 << LED_PIN);
      00806F AA 01            [ 1]  157 	or	a, #0x01
      008071 F7               [ 1]  158 	ld	(x), a
      008072 20 ED            [ 2]  159 	jra	00105$
      008074                        160 00102$:
                                    161 ;	led.c: 40: *PB_ODR &= ~(1 << LED_PIN);
      008074 A4 FE            [ 1]  162 	and	a, #0xfe
      008076 F7               [ 1]  163 	ld	(x), a
      008077 20 E8            [ 2]  164 	jra	00105$
                                    165 ;	led.c: 43: }
      008079 84               [ 1]  166 	pop	a
      00807A 81               [ 4]  167 	ret
                                    168 	.area CODE
                                    169 	.area CONST
                                    170 	.area INITIALIZER
      00802D                        171 __xinit__PB_ODR:
      00802D 50 05                  172 	.dw #0x5005
      00802F                        173 __xinit__PB_DDR:
      00802F 50 07                  174 	.dw #0x5007
      008031                        175 __xinit__PB_CR1:
      008031 50 08                  176 	.dw #0x5008
      008033                        177 __xinit__PB_CR2:
      008033 50 09                  178 	.dw #0x5009
      008035                        179 __xinit__PD_IDR:
      008035 50 10                  180 	.dw #0x5010
      008037                        181 __xinit__PD_DDR:
      008037 50 11                  182 	.dw #0x5011
      008039                        183 __xinit__PD_CR1:
      008039 50 12                  184 	.dw #0x5012
      00803B                        185 __xinit__PD_CR2:
      00803B 50 13                  186 	.dw #0x5013
                                    187 	.area CABS (ABS)
