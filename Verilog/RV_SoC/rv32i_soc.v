module rv32i_soc(clk, rst, mem_addr, mem_data, mem_rw, mem_en, uart_tx, uart_rx, i2c_clk, i2c_data, spi_clk, mosi, miso, ss, usb_d0, usb_d1, vga_r_out, vga_b_out, vga_g_out, vga_hsync, vga_vsync);
input clk;
input rst;

output reg [31:0] mem_addr = 32'b0;
inout reg [31:0] mem_data;
output reg mem_rw;
output reg mem_en;

output reg uart_tx = 1'b1;
input uart_rx;

output reg i2c_clk = 1'b1;
inout i2c_data;

output reg spi_clk = 1'b1;
output reg mosi;
input miso;
output reg ss;

inout usb_d0;
inout usb_d1;

output reg [7:0] vga_r_out;
output reg [7:0] vga_b_out;
output reg [7:0] vga_g_out;
output reg hsync;
output reg vsync;

reg [31:0] i_cache [0:3] [0:255];
reg [31:0] d_cache [0:3] [0:1023];

always @(posedge clk)
begin
	
end

endmodule
