import machine
import time
 
led_red = machine.Pin(10, machine.Pin.OUT)
led_green = machine.Pin(11, machine.Pin.OUT)
 
led_red.value(0)
 
button_red = machine.Pin(15, machine.Pin.IN, machine.Pin.PULL_DOWN)
 
def int_handler(pin):
    button_red.irq(handler=None)
    print("Interrupt Detected!")
    led_red.toggle()
    time.sleep(1)
    button_red.irq(handler=int_handler)
 
button_red.irq(trigger=machine.Pin.IRQ_RISING, handler=int_handler)