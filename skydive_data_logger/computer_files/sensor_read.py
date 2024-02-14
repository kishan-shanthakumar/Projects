# Global package import
import smbus
import _thread
import serial
import time
from math import log
import os

# Local package import
from mpu6050 import MPU6050
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
        os.makedirs('/home/kishan/logs',exist_ok=True)

        # MPU6050 initialisation
        self.mpu_flag = 1
        try:
            self.mpu = MPU6050(self.MPU_addr, bus)
            self.mpu.MPU_Init()
        except OSError:
            # print('MPU6050 not found, skipping MPU6050 operations')
            self.mpu_flag = 0

        # DPS310 initialisation
        self.dps_flag = 1
        try:
            self.dps310 = DPS(self.DPS_addr, bus)
        except OSError:
            # print('DPS310 not found, skipping DPS310 operations')
            self.dps_flag = 0

        # MCP9808 initiaslisation
        self.mcp_flag = 1
        try:
            self.mcp = MCP(self.MCP_addr, bus)
            self.mcp.MCP_Init()
        except OSError:
            # print('MCP9808 not found, skipping MCP9808 operations')
            self.mcp_flag = 0

        # GPS initialisation
        self.gps = GPS(self.ser)
        _thread.start_new_thread(self.gps.gps_data ,(1, ))

        self.ti = time.time()
        self.di = {}

    # Value reading
    def sensor_read(self, unused):
        while True:
            ts = time.time() - self.ti
            self.di['mpu6050'] = {}
            self.di['dps'] = {}
            self.di['gps'] = {}
            self.di['time'] = (ts)

            if self.mpu_flag == 1:
                mpu_val = self.mpu.mpu_read()
                self.di['mpu6050']['ax'] = (mpu_val[0])
                self.di['mpu6050']['ay'] = (mpu_val[1])
                self.di['mpu6050']['az'] = (mpu_val[2])
                self.di['mpu6050']['gx'] = (mpu_val[3])
                self.di['mpu6050']['gy'] = (mpu_val[4])
                self.di['mpu6050']['gz'] = (mpu_val[5])
                # print(mpu_val)

            if self.dps_flag == 1:
                scaled_p = self.dps310.calcScaledPressure()
                scaled_t = self.dps310.calcScaledTemperature()
                p = self.dps310.calcCompPressure(scaled_p, scaled_t)
                t = self.dps310.calcCompTemperature(scaled_t)
                # print((10**((log(p/101325)/log(2.718))/5.2558797)-1/(-6.8755856*10**-6) ) , 'ft')
                # print(t,'C')
                self.di['dps']['pr'] = (p)
                self.di['dps']['te'] = (t)

            if self.mcp_flag == 1:
                extern_temp = self.mcp.mcp_func()
                # print(extern_temp)
                self.di['et'] = (extern_temp)
            
            gps_val = self.gps.gps_run()
            if not gps_val == 0:
                # print(gps_val)
                self.di['gps']['time'] = (gps_val['time'])
                self.di['gps']['lat'] = (gps_val['lat'])
                self.di['gps']['lon'] = (gps_val['lon'])
                self.di['gps']['alt'] = (gps_val['alt'])
            print(self.di)
    
    def values(self):
        return self.di