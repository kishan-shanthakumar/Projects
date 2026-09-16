import time
ti=time.strptime("9 7 00 6:0:0", "%d %m %y %H:%M:%S")
print(time.time()-time.mktime(ti))
