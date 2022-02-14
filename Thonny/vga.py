import time
from machine import Pin, PWM, ADC, UART, Timer

timer1 = Timer()
led = Pin(25, Pin.OUT)

def vga(timer1):
    led.toggle()

timer1.init(freq = 5000000, mode = Timer.PERIODIC , callback = vga)