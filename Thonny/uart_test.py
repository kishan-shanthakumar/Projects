import time
from machine import Pin, PWM, ADC

led = Pin(0, Pin.OUT, Pin.PULL_UP)
adc = ADC(Pin(26))

while(True):
    duty = adc.read_u16()
    print(duty)
    time.sleep(15)
