/*
Code to flash led

LED PB0
*/

volatile unsigned char *PB_ODR = (unsigned char *)0x5005;
volatile unsigned char *PB_DDR = (unsigned char *)0x5007;
volatile unsigned char *PB_CR1 = (unsigned char *)0x5008;

#define LED_PIN 0 // at port B

int main(void)
{
    *PB_DDR |= (1 << LED_PIN);
    *PB_CR1 |= (1 << LED_PIN);
    *PB_ODR |= (1 << LED_PIN);

    while (1)
    {
    }
}