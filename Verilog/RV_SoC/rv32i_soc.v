module rv32i_soc(clk, mem_addr, mem_data, mem_rw, mem_en, uart_tx, uart_rx, i2c_clk, i2c_data, spi_clk, mosi, miso, ss, usb_d0, usb_d1);
input clk;

output reg [31:0] mem_addr;
inout reg [31:0] mem_data;
output reg mem_rw;
output reg mem_en;

output reg uart_tx;
input uart_rx;

output reg i2c_clk;
inout i2c_data;

output reg spi_clk;
output reg mosi;
input miso;
output reg ss;

inout usb_d0;
inout usb_d1;

reg [31:0] i_cache [0:3] [0:255];
reg [31:0] d_cache [0:3] [0:1023];

endmodule
