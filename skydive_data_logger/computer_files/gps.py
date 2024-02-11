import _thread

class GPS:
    def __init__(self, ser):
        self.ser = ser
        self.received_data = ''

    def gps_data(self, unused):
        while True:
            ser_data = self.ser.readline()
            if ser_data.split(',')[0] == '$GPGGA' and int(ser_data.split(',')[6]) > 0:
                self.received_data = ser_data

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