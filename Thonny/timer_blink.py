from machine import Pin, Timer
import time
led = Pin(25, Pin.OUT)
timer = Timer()
led.value(0)

def blink(timer):
    led.toggle()
    time.sleep(0.5)
    led.toggle()

timer.init(freq=1, mode=Timer.PERIODIC, callback=blink)