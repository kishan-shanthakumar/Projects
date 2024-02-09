# Global package import
import smbus
import _thread
import serial
from time import sleep
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
    print('MPU6050 not found, skipping MPU6050 operations')
    mpu_flag = 0

# DPS310 initialisation
dps_flag = 1
try:
    dps310 = DPS(DPS_addr, bus)
except OSError:
    print('DPS310 not found, skipping DPS310 operations')
    dps_flag = 0

# MCP9808 initiaslisation
mcp_flag = 1
try:
    mcp = MCP(MCP_addr, bus)
    mcp.MCP_Init()
except OSError:
    print('MCP9808 not found, skipping MCP9808 operations')
    mcp_flag = 0

# GPS initialisation
gps = GPS(ser)
_thread.start_new_thread(gps.gps_data ,(1, ))

# Value reading
if mpu_flag == 1:
    mpu_val = mpu.mpu_read()

if dps_flag == 1:
    scaled_p = dps310.calcScaledPressure()
    scaled_t = dps310.calcScaledTemperature()
    p = dps310.calcCompPressure(scaled_p, scaled_t)
    t = dps310.calcCompTemperature(scaled_t)

if mcp_flag == 1:
    extern_temp = mcp.mcp_func()

gps_val = gps.gps_run()