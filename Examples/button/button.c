/*
Code to flash led

LED PB0
*/

volatile unsigned char *PB_ODR = (unsigned char *)0x5005;
volatile unsigned char *PB_DDR = (unsigned char *)0x5007;
volatile unsigned char *PB_CR1 = (unsigned char *)0x5008;
volatile unsigned char *PB_CR2 = (unsigned char *)0x5009;

volatile unsigned char *PD_IDR = (unsigned char *)0x5010;
volatile unsigned char *PD_DDR = (unsigned char *)0x5011;
volatile unsigned char *PD_CR1 = (unsigned char *)0x5012;
volatile unsigned char *PD_CR2 = (unsigned char *)0x5013;

#define LED_PIN 0 // at port B
#define BTN_PIN 7 // at port D

int main(void)
{

    // setup LED pin
    *PB_DDR |= (1 << LED_PIN);
    *PB_CR1 |= (1 << LED_PIN); // push-pull

    // setup BTN pin
    *PD_DDR &= ~(1 << BTN_PIN);
    *PD_CR1 |= (1 << BTN_PIN);  // pull-up
    *PD_CR2 &= ~(1 << BTN_PIN); // interrupt disabled

    while (1)
    {
        if ((*PD_IDR & (1 << BTN_PIN)) == 0)
        {
            *PB_ODR |= (1 << LED_PIN);
        }
        else
        {
            *PB_ODR &= ~(1 << LED_PIN);
        }
    }
}