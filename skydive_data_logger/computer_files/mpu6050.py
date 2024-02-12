class MPU6050:
    def __init__(self, MPU_addr, bus):
        self.MPU_addr = MPU_addr
        self.bus = bus
        self.PWR_MGMT_1   = 0x6B
        self.SMPLRT_DIV   = 0x19
        self.CONFIG       = 0x1A
        self.GYRO_CONFIG  = 0x1B
        self.ACCEL_CONFIG = 0x1C
        self.INT_ENABLE   = 0x38
        self.ACCEL_XOUT_H = 0x3B
        self.ACCEL_YOUT_H = 0x3D
        self.ACCEL_ZOUT_H = 0x3F
        self.GYRO_XOUT_H  = 0x43
        self.GYRO_YOUT_H  = 0x45
        self.GYRO_ZOUT_H  = 0x47

    def MPU_Init(self):
        self.bus.write_byte_data(self.MPU_addr, self.SMPLRT_DIV, 7)
        self.bus.write_byte_data(self.MPU_addr, self.PWR_MGMT_1, 1)
        self.bus.write_byte_data(self.MPU_addr, self.CONFIG, 0)
        self.bus.write_byte_data(self.MPU_addr, self.GYRO_CONFIG, 24)
        self.bus.write_byte_data(self.MPU_addr, self.ACCEL_CONFIG, 3)
        self.bus.write_byte_data(self.MPU_addr, self.INT_ENABLE, 1)

    def read_raw_data(self, addr):
        #Accelero and Gyro value are 16-bit
        high = self.bus.read_byte_data(self.MPU_addr, addr)
        low = self.bus.read_byte_data(self.MPU_addr, addr+1)

        #concatenate higher and lower value
        value = ((high << 8) | low)
        
        #to get signed value from mpu6050
        if(value > 32768):
                value = value - 65536
        return value

    def mpu_read(self):
        #Read Accelerometer raw value
        acc_x = self.read_raw_data(self.ACCEL_XOUT_H)
        acc_y = self.read_raw_data(self.ACCEL_YOUT_H)
        acc_z = self.read_raw_data(self.ACCEL_ZOUT_H)
        
        #Read Gyroscope raw value
        gyro_x = self.read_raw_data(self.GYRO_XOUT_H)
        gyro_y = self.read_raw_data(self.GYRO_YOUT_H)
        gyro_z = self.read_raw_data(self.GYRO_ZOUT_H)
        
        #Full scale range +/- 250 degree/C as per sensitivity scale factor
        Ax = acc_x/16384.0 * 9.8
        Ay = acc_y/16384.0 * 9.8
        Az = acc_z/16384.0 * 9.8
        
        Gx = gyro_x/131.0
        Gy = gyro_y/131.0
        Gz = gyro_z/131.0
        
        return([Ax, Ay, Az, Gx, Gy, Gz])