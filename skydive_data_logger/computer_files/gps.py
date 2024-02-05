import _thread

class GPS:
    def __init__(self, ser):
        self.ser = ser
        self.received_data = ''

    def gps_data(self, unused):
        while True:
            ser_data = self.ser.readline()
            if ser_data.split(',')[2] == "A":
                self.received_data = ser_data

    def gps_run(self):
        data = self.received_data.split()
        di = {}
        di['time'] = data[1] + data[8]
        di['lat'] = data[3] + data[4]
        di['lon'] = data[5] + data[6]
        di['speed'] = data[7]
        return(di)