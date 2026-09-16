class MCP:
    def __init__(self, addr, bus):
        self.addr = addr
        self.bus = bus
        self.config = [0x00, 0x00]
        self.config_reg = 0x01
        self.res_reg = 0x08
        self.res = 0x03
        self.temp_reg = 0x05

    def MCP_Init(self):
        self.bus.write_i2c_block_data(self.addr, self.config_reg, self.config)
        self.bus.write_byte_data(self.addr, self.res_reg, self.res)
    
    def mcp_func(self):
        data = self.bus.read_i2c_block_data(self.addr, self.temp_reg, 2)

        ctemp = ((data[0] & 0x1F) * 256) + data[1]
        if ctemp > 4095 :
            ctemp -= 8192
        ctemp = ctemp * 0.0625

        return ctemp