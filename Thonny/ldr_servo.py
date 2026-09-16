from machine import Pin, PWM, ADC
import time

pwm = PWM(Pin(15))
adc = ADC(Pin(26))

pwm.freq(50)

dutyh = 32767
dutyf = 56000
dutyi = 0

while True:
    a = adc.read_u16()
    
    if(a<25000):
        dutyfin = int(dutyf/20);
        dutyfin += 3251
        pwm.duty_u16(dutyfin)

        time .sleep(0.3)

        dutyfin = int(dutyh/20);
        dutyfin += 3251
        pwm.duty_u16(dutyfin)
        
        time.sleep(0.25)