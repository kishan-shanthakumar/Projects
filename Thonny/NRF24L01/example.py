from NRF24L01 import NRF24L01

rf = NRF24L01()

rf.available()
a = rf.recv()
rf.send()
rf.waitPacketSent()