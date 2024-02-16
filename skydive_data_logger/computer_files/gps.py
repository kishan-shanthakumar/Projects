import time
import serial

class GPS:
    def __init__(self):
        self.ser = serial.Serial ("/dev/serial0", 9600)    # Open port for GPS
        self.received_data = ''

    def gps_data(self, unused):
        while True:
            try:
                ser_data = str(self.ser.readline())[3:-1]
                if ser_data.split(',')[0] == 'GNGGA' and int(ser_data.split(',')[6]) > 0:
                    self.received_data = ser_data
            except:
                self.ser = serial.Serial ("/dev/serial0", 9600)    # Open port for GPS

    def gps_run(self):
        data = self.received_data.split()
        if len(data) > 2:
            di = {}
            di['time'] = data[1]
            di['lat'] = data[2] + data[3]
            di['lon'] = data[4] + data[5]
            di['alt'] = data[9]
            return(di)
        else:
            return 0