# Global package import
import smbus
import _thread
import serial
import time
from math import log
import os

# Local package import
from mpu6050 import mpu6050
from dps310 import DPS
from gps import GPS
from mcp9808 import MCP

class Sensors:
    def __init__(self):
        bus = smbus.SMBus(1)
        self.MPU_addr = 0x68   # MPU6050 device address
        self.DPS_addr = 0x77   # DPS310  device address
        self.MCP_addr = 0x18
        self.ser = serial.Serial ("/dev/ttyS0", 9600)    # Open port for GPS

        # MPU6050 initialisation
        self.mpu_flag = 1
        try:
            self.mpu = mpu6050(self.MPU_addr, bus)
            print('Calibrating MPU6050')
            mpu_cal = []
            tis = time.time()
            while time.time() - tis < 1:
                mpu_cal.append(self.mpu.get_all_data())
            self.mpu_cal_ax = sum([x[0] for x in mpu_cal])/len(mpu_cal)
            self.mpu_cal_ay = sum([x[1] for x in mpu_cal])/len(mpu_cal)
            self.mpu_cal_az = sum([x[2] for x in mpu_cal])/len(mpu_cal) - 9.801
            self.mpu_cal_gx = sum([x[3] for x in mpu_cal])/len(mpu_cal)
            self.mpu_cal_gy = sum([x[4] for x in mpu_cal])/len(mpu_cal)
            self.mpu_cal_gz = sum([x[5] for x in mpu_cal])/len(mpu_cal)
        except OSError:
            print('MPU6050 not found, skipping MPU6050 operations')
            self.mpu_flag = 0

        # DPS310 initialisation
        self.dps_flag = 1
        try:
            self.dps310 = DPS(self.DPS_addr, bus)
        except OSError:
            print('DPS310 not found, skipping DPS310 operations')
            self.dps_flag = 0

        # MCP9808 initiaslisation
        self.mcp_flag = 1
        try:
            self.mcp = MCP(self.MCP_addr, bus)
            self.mcp.MCP_Init()
        except OSError:
            print('MCP9808 not found, skipping MCP9808 operations')
            self.mcp_flag = 0

        # GPS initialisation
        self.gps = GPS(self.ser)
        _thread.start_new_thread(self.gps.gps_data ,(1, ))

        self.ti = time.time()
        self.di = dict()

        self.log = 0
        self.log_li = []

        os.makedirs('../logs', exist_ok=True)

    # Value reading
    def sensor_read(self, unused):
        di_temp = {}
        di_temp['mpu6050'] = {}
        di_temp['dps'] = {}
        di_temp['gps'] = {}
        di_temp['calc'] = {'ax': 0, 'ay': 0, 'az': 0, 'ox': 0, 'oy': 0, 'oz': 0}
        ti = 0
        ts = 0
        while True:
            di_temp = {}
            di_temp['mpu6050'] = {}
            di_temp['dps'] = {}
            di_temp['gps'] = {}
            di_temp['time'] = (ts)

            cal_ax = 0
            cal_ay = 0
            cal_az = 0

            if self.mpu_flag == 1:
                mpu_val = self.mpu.get_all_data()
                di_temp['mpu6050']['ax'] = (mpu_val[0]) - self.mpu_cal_ax
                di_temp['mpu6050']['ay'] = (mpu_val[1]) - self.mpu_cal_ay
                di_temp['mpu6050']['az'] = (mpu_val[2]) - self.mpu_cal_az
                di_temp['mpu6050']['gx'] = (mpu_val[3]) - self.mpu_cal_gx
                di_temp['mpu6050']['gy'] = (mpu_val[4]) - self.mpu_cal_gy
                di_temp['mpu6050']['gz'] = (mpu_val[5]) - self.mpu_cal_gz
                di_temp['calc']['vx'] = di_temp['calc']['vx'] + (mpu_val[0] - cal_ax) * (ts - ti)
                di_temp['calc']['vy'] = di_temp['calc']['vy'] + (mpu_val[0] - cal_ax) * (ts - ti)
                di_temp['calc']['vz'] = di_temp['calc']['vz'] + (mpu_val[0] - cal_ax) * (ts - ti)
                di_temp['calc']['ox'] = di_temp['calc']['ox'] + (mpu_val[0] - cal_ax) * (ts - ti)
                di_temp['calc']['oy'] = di_temp['calc']['oy'] + (mpu_val[0] - cal_ax) * (ts - ti)
                di_temp['calc']['oz'] = di_temp['calc']['oz'] + (mpu_val[0] - cal_ax) * (ts - ti)
                # print(mpu_val)

            if self.dps_flag == 1:
                scaled_p = self.dps310.calcScaledPressure()
                scaled_t = self.dps310.calcScaledTemperature()
                p = self.dps310.calcCompPressure(scaled_p, scaled_t)
                t = self.dps310.calcCompTemperature(scaled_t)
                # print((10**((log(p/101325)/log(2.718))/5.2558797)-1/(-6.8755856*10**-6) ) , 'ft')
                # print(t,'C')
                di_temp['dps']['pr'] = (p)
                di_temp['dps']['te'] = (t)

            if self.mcp_flag == 1:
                extern_temp = self.mcp.mcp_func()
                # print(extern_temp)
                di_temp['et'] = (extern_temp)
            
            gps_val = self.gps.gps_run()
            if not gps_val == 0:
                # print(gps_val)
                di_temp['gps']['time'] = (gps_val['time'])
                di_temp['gps']['lat'] = (gps_val['lat'])
                di_temp['gps']['lon'] = (gps_val['lon'])
                di_temp['gps']['alt'] = (gps_val['alt'])
            
            ts = time.time() - self.ti
            ti = ts
            self.di = di_temp
            if self.log == 1:
                li_time = str(self.di['time'])
                li_gps = [str(k)+' '+str(v)+', ' for k,v in self.di['gps'].items()]
                li_mpu = [str(k)+' '+str(v)+', ' for k,v in self.di['mpu6050'].items()]
                li_cal = [str(k)+' '+str(v)+', ' for k,v in self.di['calc'].items()]
                li_dps = [str(k)+' '+str(v)+', ' for k,v in self.di['dps'].items()]
                li_et = 'et'+' '+str(self.di['et'])+'\n'
                self.log_li.append(li_time+','+''.join(li_gps)+''.join(li_mpu)+''.join(li_cal)+''.join(li_dps)+li_et)
    
    def values(self):
        return self.di
    
    def start_log(self):
        self.log_li = []
        self.log = 1
        self.filename = '../logs/'+str(time.time())+'.txt'
        self.fp = open(self.filename,'w')
    
    def stop_log(self):
        self.log = 0
        self.fp.write(''.join(self.log_li))
        self.log_li = []
        self.fp.close()
        return self.filename[3:]