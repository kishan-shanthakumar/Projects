from machine import Pin, UART

l = list()

for i in range(10):
    for j in range(12):
        l.append([255,255,255])

l = str(l)
print(l)