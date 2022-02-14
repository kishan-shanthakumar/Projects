from machine import Pin
import time
led = Pin(25, Pin.OUT)

def blink():
    led.toggle()

while(True):
    blink();
    time.sleep(1);