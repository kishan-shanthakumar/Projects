from ssd1306 import SSD1306_I2C
from machine import I2C, Pin, ADC, Timer
import time
import network
import socket

addr = socket.getaddrinfo('0.0.0.0', 80)[0][-1]
s = socket.socket()
s.bind(addr)
s.listen(1)
s.timeout(0.1)

print('listening on', addr)

i2c = I2C(scl=Pin(5), sda=Pin(4))
display = SSD1306_I2C(128, 64, i2c)
bpm = 0

wlan = network.WLAN(network.STA_IF)
wlan.active(True)
if not wlan.isconnected():
    display.fill(0)
    display.text('connecting to network...', 0, 0)
    display.show()
    print('connecting to network...')
    wlan.connect('wlan_ssid', 'wlan_pass')
    while not wlan.isconnected():
        pass
display.fill(0)
display.text('Connected to network', 0, 0)
display.show()
time.sleep(1)
display.fill(0)
print('network config:', wlan.ifconfig())

def func(data):
    global bpm
    bat_charge = 0
    charge_status = 0
    bat_vol = ADC(Pin(1)).read_u16()
    cha_sta = ADC(Pin(1)).read_u16()
    charge_status = 1 if cha_sta > 32768 else 0
    bat_charge = ((bat_vol-46811)/(65535-46811))*1.2+3
    display.fill(0)
    display.text(str(wlan.ifconfig()[0]), 0, 40)
    display.text("Port: "+str(80), 0, 50)
    display.text("Heartrate: "+str(bpm)+" bpm", 0, 0)
    display.text("Bat: "+str(bat_charge), 0, 10)
    if charge_status == 1:
        display.text("Charging", 0, 20)
    display.show()
    try:
        conn, addr = s.accept()
        print('Got a connection from %s' % str(addr))
        request = conn.recv(1024)
        response = str([bpm,bat_charge,charge_status])
        conn.send('HTTP/1.1 200 OK\n')
        conn.send('Content-Type: text/html\n')
        conn.send('Connection: close\n\n')
        conn.sendall(response)
        conn.close()
    except OSError:
        pass

timer1 = Timer()
timer1.init(freq=1, mode=Timer.PERIODIC, callback=func)

while True:
    temp_bpm = 0
    start_time = time.time()
    adc = ADC(Pin(7))
    while(time.time() - start_time < 15):
        val = adc.read_u16()
        if (val > 32768):
            temp_bpm += 1
    bpm = temp_bpm * 4