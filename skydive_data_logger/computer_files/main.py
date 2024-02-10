# Global package import
import smbus
import _thread
import serial
import time
from math import log
import json
import requests

# Local package import
from mpu6050 import MPU6050
from dps310 import DPS
from gps import GPS
from mcp9808 import MCP
import http_server_read

# Setup
bus = smbus.SMBus(1)
MPU_addr = 0x68   # MPU6050 device address
DPS_addr = 0x77   # DPS310  device address
MCP_addr = 0x18
ser = serial.Serial ("/dev/ttyS0", 9600)    # Open port for GPS

# MPU6050 initialisation
mpu_flag = 1
try:
    mpu = MPU6050(MPU_addr, bus)
    mpu.MPU_Init()
except OSError:
    # print('MPU6050 not found, skipping MPU6050 operations')
    mpu_flag = 0

# DPS310 initialisation
dps_flag = 1
try:
    dps310 = DPS(DPS_addr, bus)
except OSError:
    # print('DPS310 not found, skipping DPS310 operations')
    dps_flag = 0

# MCP9808 initiaslisation
mcp_flag = 1
try:
    mcp = MCP(MCP_addr, bus)
    mcp.MCP_Init()
except OSError:
    # print('MCP9808 not found, skipping MCP9808 operations')
    mcp_flag = 0

# GPS initialisation
gps = GPS(ser)
_thread.start_new_thread(gps.gps_data ,(1, ))

ti = time.time()
di = {}
di['time'] = []

di['mpu6050'] = {}
di['mpu6050']['ax'] = []
di['mpu6050']['ay'] = []
di['mpu6050']['az'] = []
di['mpu6050']['gx'] = []
di['mpu6050']['gy'] = []
di['mpu6050']['gz'] = []

di['dps'] = {}
di['dps']['pr'] = []
di['dps']['te'] = []

di['et'] = []

di['gps'] = {}
di['gps']['time'] = []
di['gps']['lat'] = []
di['gps']['lon'] = []
di['gps']['speed'] = []

# Value reading
try:
    while True:
        ts = time.time() - ti
        di['time'].append(ts)

        if mpu_flag == 1:
            mpu_val = mpu.mpu_read()
            di['mpu6050']['ax'].append(mpu_val[0])
            di['mpu6050']['ay'].append(mpu_val[1])
            di['mpu6050']['az'].append(mpu_val[2])
            di['mpu6050']['gx'].append(mpu_val[3])
            di['mpu6050']['gy'].append(mpu_val[4])
            di['mpu6050']['gz'].append(mpu_val[5])
            # print(mpu_val)

        if dps_flag == 1:
            scaled_p = dps310.calcScaledPressure()
            scaled_t = dps310.calcScaledTemperature()
            p = dps310.calcCompPressure(scaled_p, scaled_t)
            t = dps310.calcCompTemperature(scaled_t)
            # print((10**((log(p/101325)/log(2.718))/5.2558797)-1/(-6.8755856*10**-6) ) , 'ft')
            # print(t,'C')
            di['dps']['pr'].append(p)
            di['dps']['te'].append(t)

        if mcp_flag == 1:
            extern_temp = mcp.mcp_func()
            # print(extern_temp)
            di['et'].append(extern_temp)
        
        gps_val = gps.gps_run()
        if not gps_val == 0:
            # print(gps_val)
            di['gps']['time'].append(gps_val['time'])
            di['gps']['lat'].append(gps_val['lat'])
            di['gps']['lon'].append(gps_val['lon'])
            di['gps']['speed'].append(gps_val['speed'])
        
        time.sleep(0.1)

        if ((time.time() - ti) > 900):
            if (len(di['gps']['time']) == 0):
                del di['gps']
            if mcp_flag == 0:
                del di['et']
            if mpu_flag == 0:
                del di['mpu6050']
            if dps_flag == 0:
                del di['dps']
            ti = time.time()
            with open(str(time.time())+'.json', 'w') as fp:
                json.dump(di, fp)
            di = {}
            di['time'] = []

            di['mpu6050'] = {}
            di['mpu6050']['ax'] = []
            di['mpu6050']['ay'] = []
            di['mpu6050']['az'] = []
            di['mpu6050']['gx'] = []
            di['mpu6050']['gy'] = []
            di['mpu6050']['gz'] = []

            di['dps'] = {}
            di['dps']['pr'] = []
            di['dps']['te'] = []

            di['et'] = []

            di['gps'] = {}
            di['gps']['time'] = []
            di['gps']['lat'] = []
            di['gps']['lon'] = []
            di['gps']['speed'] = []

except KeyboardInterrupt:
    pass