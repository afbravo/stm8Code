                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.3.0 #14184 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module blinky
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _TIM4_ARR
                                     13 	.globl _TIM4_PSCR
                                     14 	.globl _TIM4_CTR
                                     15 	.globl _TIM4_SR1
                                     16 	.globl _TIM4_CR1
                                     17 	.globl _CLK_PCKENR1
                                     18 	.globl _PD_CR2
                                     19 	.globl _PD_CR1
                                     20 	.globl _PD_DDR
                                     21 	.globl _PD_IDR
                                     22 	.globl _PB_CR2
                                     23 	.globl _PB_CR1
                                     24 	.globl _PB_DDR
                                     25 	.globl _PB_ODR
                                     26 ;--------------------------------------------------------
                                     27 ; ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area DATA
                                     30 ;--------------------------------------------------------
                                     31 ; ram data
                                     32 ;--------------------------------------------------------
                                     33 	.area INITIALIZED
      000001                         34 _PB_ODR::
      000001                         35 	.ds 2
      000003                         36 _PB_DDR::
      000003                         37 	.ds 2
      000005                         38 _PB_CR1::
      000005                         39 	.ds 2
      000007                         40 _PB_CR2::
      000007                         41 	.ds 2
      000009                         42 _PD_IDR::
      000009                         43 	.ds 2
      00000B                         44 _PD_DDR::
      00000B                         45 	.ds 2
      00000D                         46 _PD_CR1::
      00000D                         47 	.ds 2
      00000F                         48 _PD_CR2::
      00000F                         49 	.ds 2
      000011                         50 _CLK_PCKENR1::
      000011                         51 	.ds 2
      000013                         52 _TIM4_CR1::
      000013                         53 	.ds 2
      000015                         54 _TIM4_SR1::
      000015                         55 	.ds 2
      000017                         56 _TIM4_CTR::
      000017                         57 	.ds 2
      000019                         58 _TIM4_PSCR::
      000019                         59 	.ds 2
      00001B                         60 _TIM4_ARR::
      00001B                         61 	.ds 2
                                     62 ;--------------------------------------------------------
                                     63 ; Stack segment in internal ram
                                     64 ;--------------------------------------------------------
                                     65 	.area SSEG
      00001D                         66 __start__stack:
      00001D                         67 	.ds	1
                                     68 
                                     69 ;--------------------------------------------------------
                                     70 ; absolute external ram data
                                     71 ;--------------------------------------------------------
                                     72 	.area DABS (ABS)
                                     73 
                                     74 ; default segment ordering for linker
                                     75 	.area HOME
                                     76 	.area GSINIT
                                     77 	.area GSFINAL
                                     78 	.area CONST
                                     79 	.area INITIALIZER
                                     80 	.area CODE
                                     81 
                                     82 ;--------------------------------------------------------
                                     83 ; interrupt vector
                                     84 ;--------------------------------------------------------
                                     85 	.area HOME
      008000                         86 __interrupt_vect:
      008000 82 00 80 07             87 	int s_GSINIT ; reset
                                     88 ;--------------------------------------------------------
                                     89 ; global & static initialisations
                                     90 ;--------------------------------------------------------
                                     91 	.area HOME
                                     92 	.area GSINIT
                                     93 	.area GSFINAL
                                     94 	.area GSINIT
      008007 CD 80 9D         [ 4]   95 	call	___sdcc_external_startup
      00800A 4D               [ 1]   96 	tnz	a
      00800B 27 03            [ 1]   97 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   98 	jp	__sdcc_program_startup
      008010                         99 __sdcc_init_data:
                                    100 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]  101 	ldw x, #l_DATA
      008013 27 07            [ 1]  102 	jreq	00002$
      008015                        103 00001$:
      008015 72 4F 00 00      [ 1]  104 	clr (s_DATA - 1, x)
      008019 5A               [ 2]  105 	decw x
      00801A 26 F9            [ 1]  106 	jrne	00001$
      00801C                        107 00002$:
      00801C AE 00 1C         [ 2]  108 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]  109 	jreq	00004$
      008021                        110 00003$:
      008021 D6 80 2C         [ 1]  111 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]  112 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]  113 	decw	x
      008028 26 F7            [ 1]  114 	jrne	00003$
      00802A                        115 00004$:
                                    116 ; stm8_genXINIT() end
                                    117 	.area GSFINAL
      00802A CC 80 04         [ 2]  118 	jp	__sdcc_program_startup
                                    119 ;--------------------------------------------------------
                                    120 ; Home
                                    121 ;--------------------------------------------------------
                                    122 	.area HOME
                                    123 	.area HOME
      008004                        124 __sdcc_program_startup:
      008004 CC 80 49         [ 2]  125 	jp	_main
                                    126 ;	return from main will return to caller
                                    127 ;--------------------------------------------------------
                                    128 ; code
                                    129 ;--------------------------------------------------------
                                    130 	.area CODE
                                    131 ;	blinky.c: 35: int main(void)
                                    132 ;	-----------------------------------------
                                    133 ;	 function main
                                    134 ;	-----------------------------------------
      008049                        135 _main:
      008049 52 04            [ 2]  136 	sub	sp, #4
                                    137 ;	blinky.c: 39: *CLK_PCKENR1 |= (1 << PCKENR1_2_TIM4);
      00804B CE 00 11         [ 2]  138 	ldw	x, _CLK_PCKENR1+0
      00804E F6               [ 1]  139 	ld	a, (x)
      00804F AA 04            [ 1]  140 	or	a, #0x04
      008051 F7               [ 1]  141 	ld	(x), a
                                    142 ;	blinky.c: 43: *TIM4_PSCR = (0x0D);
      008052 CE 00 19         [ 2]  143 	ldw	x, _TIM4_PSCR+0
      008055 A6 0D            [ 1]  144 	ld	a, #0x0d
      008057 F7               [ 1]  145 	ld	(x), a
                                    146 ;	blinky.c: 48: volatile uint32_t arr_top = (244 * delay_ms) / 1000;
      008058 AE 00 18         [ 2]  147 	ldw	x, #0x0018
      00805B 1F 03            [ 2]  148 	ldw	(0x03, sp), x
      00805D 5F               [ 1]  149 	clrw	x
      00805E 1F 01            [ 2]  150 	ldw	(0x01, sp), x
                                    151 ;	blinky.c: 49: *TIM4_ARR = (uint8_t)arr_top;
      008060 CE 00 1B         [ 2]  152 	ldw	x, _TIM4_ARR+0
      008063 7B 04            [ 1]  153 	ld	a, (0x04, sp)
      008065 F7               [ 1]  154 	ld	(x), a
                                    155 ;	blinky.c: 52: *TIM4_CR1 |= 0x01;
      008066 CE 00 13         [ 2]  156 	ldw	x, _TIM4_CR1+0
      008069 F6               [ 1]  157 	ld	a, (x)
      00806A AA 01            [ 1]  158 	or	a, #0x01
      00806C F7               [ 1]  159 	ld	(x), a
                                    160 ;	blinky.c: 55: *PB_DDR |= (1 << LED_PIN); // set LED pin as output
      00806D CE 00 03         [ 2]  161 	ldw	x, _PB_DDR+0
      008070 F6               [ 1]  162 	ld	a, (x)
      008071 AA 01            [ 1]  163 	or	a, #0x01
      008073 F7               [ 1]  164 	ld	(x), a
                                    165 ;	blinky.c: 56: *PB_CR1 |= (1 << LED_PIN); // set LED pin as push-pull
      008074 CE 00 05         [ 2]  166 	ldw	x, _PB_CR1+0
      008077 F6               [ 1]  167 	ld	a, (x)
      008078 AA 01            [ 1]  168 	or	a, #0x01
      00807A F7               [ 1]  169 	ld	(x), a
                                    170 ;	blinky.c: 59: *PB_ODR &= ~(1 << LED_PIN);
      00807B CE 00 01         [ 2]  171 	ldw	x, _PB_ODR+0
      00807E F6               [ 1]  172 	ld	a, (x)
      00807F A4 FE            [ 1]  173 	and	a, #0xfe
      008081 F7               [ 1]  174 	ld	(x), a
                                    175 ;	blinky.c: 61: while (1)
      008082                        176 00104$:
                                    177 ;	blinky.c: 64: if (*TIM4_SR1 & 0x01)
      008082 CE 00 15         [ 2]  178 	ldw	x, _TIM4_SR1+0
      008085 F6               [ 1]  179 	ld	a, (x)
      008086 44               [ 1]  180 	srl	a
      008087 24 F9            [ 1]  181 	jrnc	00104$
                                    182 ;	blinky.c: 67: *TIM4_SR1 &= ~(0x01);
      008089 F6               [ 1]  183 	ld	a, (x)
      00808A A4 FE            [ 1]  184 	and	a, #0xfe
      00808C F7               [ 1]  185 	ld	(x), a
                                    186 ;	blinky.c: 69: *TIM4_CTR = 0x00;
      00808D CE 00 17         [ 2]  187 	ldw	x, _TIM4_CTR+0
      008090 7F               [ 1]  188 	clr	(x)
                                    189 ;	blinky.c: 59: *PB_ODR &= ~(1 << LED_PIN);
      008091 CE 00 01         [ 2]  190 	ldw	x, _PB_ODR+0
                                    191 ;	blinky.c: 71: *PB_ODR ^= (1 << LED_PIN);
      008094 F6               [ 1]  192 	ld	a, (x)
      008095 A8 01            [ 1]  193 	xor	a, #0x01
      008097 F7               [ 1]  194 	ld	(x), a
      008098 20 E8            [ 2]  195 	jra	00104$
                                    196 ;	blinky.c: 74: }
      00809A 5B 04            [ 2]  197 	addw	sp, #4
      00809C 81               [ 4]  198 	ret
                                    199 	.area CODE
                                    200 	.area CONST
                                    201 	.area INITIALIZER
      00802D                        202 __xinit__PB_ODR:
      00802D 50 05                  203 	.dw #0x5005
      00802F                        204 __xinit__PB_DDR:
      00802F 50 07                  205 	.dw #0x5007
      008031                        206 __xinit__PB_CR1:
      008031 50 08                  207 	.dw #0x5008
      008033                        208 __xinit__PB_CR2:
      008033 50 09                  209 	.dw #0x5009
      008035                        210 __xinit__PD_IDR:
      008035 50 10                  211 	.dw #0x5010
      008037                        212 __xinit__PD_DDR:
      008037 50 11                  213 	.dw #0x5011
      008039                        214 __xinit__PD_CR1:
      008039 50 12                  215 	.dw #0x5012
      00803B                        216 __xinit__PD_CR2:
      00803B 50 13                  217 	.dw #0x5013
      00803D                        218 __xinit__CLK_PCKENR1:
      00803D 50 C3                  219 	.dw #0x50c3
      00803F                        220 __xinit__TIM4_CR1:
      00803F 52 E0                  221 	.dw #0x52e0
      008041                        222 __xinit__TIM4_SR1:
      008041 52 E5                  223 	.dw #0x52e5
      008043                        224 __xinit__TIM4_CTR:
      008043 52 E7                  225 	.dw #0x52e7
      008045                        226 __xinit__TIM4_PSCR:
      008045 52 E8                  227 	.dw #0x52e8
      008047                        228 __xinit__TIM4_ARR:
      008047 52 E9                  229 	.dw #0x52e9
                                    230 	.area CABS (ABS)
