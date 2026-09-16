from header import *
from time import sleep
from machine import SPI

class NRF24L01(SPI):
    def __init__(self, SCK, MOSI, MISO, CS):
        SPI.__init__(self,
                     mode = SPI.PERIPHERAL,
                     baudrate = 10000000,
                     polarity = 1,
                     phase = 1,
                     bits = 8,
                     firstbit = SPI=MSB,
                     sck = machine.Pin(SCK),
                     mosi = machine.Pin(MOSI),
                     miso = machine.Pin(MISO)
                     )
        self.cs = CS
    
    def usleep(x):
        sleep(x/1000000)
    
    def beginTransaction():
        pass
    
    def endTransaction():
        cs.value(1)
        
    
    def available():
        pass
    
    def send(data,addr):
        cs.value(0)
        cs.value(1)
    
    def recv(addr):
        cs.value(0)
        cs.value(1)
    
    def waitPacketSent():
        pass
