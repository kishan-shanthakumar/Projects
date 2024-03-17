import time
import serial

class GPS:
    def __init__(self):
        self.ser = serial.Serial ("/dev/serial0", 9600)    # Open port for GPS
        self.received_data = ''
        self.all_data = ""

    def gps_data(self, unused):
        temp_all_data = []
        while True:
            try:
                ser_data = str(self.ser.readline())[3:-1]
                if 'GNGGA' in ser_data:
                    self.all_data = ''.join(temp_all_data)
                    temp_all_data = []
                    temp_all_data.append(ser_data)
                else:
                    temp_all_data.append(ser_data)
                if ser_data.split(',')[0] == 'GNGGA' and int(ser_data.split(',')[6]) > 0:
                    self.received_data = ser_data
            except:
                self.ser = serial.Serial ("/dev/serial0", 9600)    # Open port for GPS

    def verb_data(self):
        return self.all_data

    def gps_run(self):
        data = self.received_data.split(',')
        if len(data) > 2:
            di = {}
            di['time'] = data[1]
            di['lat'] = data[2] + data[3]
            di['lon'] = data[4] + data[5]
            di['alt'] = data[9]
            return(di)
        else:
            return 0