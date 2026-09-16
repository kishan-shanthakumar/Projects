import time
from machine import Pin, PWM, ADC, UART, Timer

uart = UART(1, 115200, parity=None, stop=1, bits=8, rx=Pin(5), tx=Pin(4))
led = Pin(25, Pin.OUT)
adc = ADC(Pin(26))
timer1 = Timer()
timer2 = Timer()

def uart_transfer(timer1):
    duty = adc.read_u16()
    duty = str(duty)
    uart.write(duty)
    led.value(1)
    time.sleep(2)
    led.value(0)

def serial_monitor(timer2):
    led.toggle()

timer1.init(freq=0.05, mode=Timer.PERIODIC, callback=uart_transfer)
timer2.init(freq=1, mode=Timer.PERIODIC, callback=serial_monitor)

