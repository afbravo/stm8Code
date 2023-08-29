/*
Code to flash led

LED PB0
*/

#include <stdint.h>

volatile unsigned char *PB_ODR = (unsigned char *)0x5005;
volatile unsigned char *PB_DDR = (unsigned char *)0x5007;
volatile unsigned char *PB_CR1 = (unsigned char *)0x5008;
volatile unsigned char *PB_CR2 = (unsigned char *)0x5009;

volatile unsigned char *PD_IDR = (unsigned char *)0x5010;
volatile unsigned char *PD_DDR = (unsigned char *)0x5011;
volatile unsigned char *PD_CR1 = (unsigned char *)0x5012;
volatile unsigned char *PD_CR2 = (unsigned char *)0x5013;

volatile unsigned char *CLK_PCKENR1 = (unsigned char *)0x50C3; // peripheral clock gating register 1 to enable clock to timer (sysclock 2MHz)

volatile unsigned char *TIM4_CR1 = (unsigned char *)0x52E0;  // control register 1
volatile unsigned char *TIM4_SR1 = (unsigned char *)0x52E5;  // status register 1
volatile unsigned char *TIM4_CTR = (unsigned char *)0x52E7;  // counter register
volatile unsigned char *TIM4_PSCR = (unsigned char *)0x52E8; // prescaler register
volatile unsigned char *TIM4_ARR = (unsigned char *)0x52E9;  // auto reload register

#define LED_PIN 0        // at port B
#define BTN_PIN 7        // at port D
#define PCKENR1_2_TIM4 2 // bit 2 of PCKENR1 to enable clock to timer 4

// void setupLED(void);
// void setupButton(void);
// void setupTimer(void);

int main(void)
{

    // enable clock to timer
    *CLK_PCKENR1 |= (1 << PCKENR1_2_TIM4);

    // setup timer 4
    // set prescaler to 0x0d (13)
    *TIM4_PSCR = (0x0D);

    // set auto reload to 244 (1s at 2MHz)
    uint8_t top_1sec = 244;
    uint32_t delay_ms = 100;
    volatile uint32_t arr_top = (244 * delay_ms) / 1000;
    *TIM4_ARR = (uint8_t)arr_top;

    // enable timer 4
    *TIM4_CR1 |= 0x01;

    // setup LED
    *PB_DDR |= (1 << LED_PIN); // set LED pin as output
    *PB_CR1 |= (1 << LED_PIN); // set LED pin as push-pull

    // turn off LED
    *PB_ODR &= ~(1 << LED_PIN);

    while (1)
    {
        // check if timer has overflowed
        if (*TIM4_SR1 & 0x01)
        {
            // clear overflow flag
            *TIM4_SR1 &= ~(0x01);
            // reset counter
            *TIM4_CTR = 0x00;
            // toggle LED
            *PB_ODR ^= (1 << LED_PIN);
        }
    }
}