module spi(clki,rst,miso,mosi,ss,clko,spi_buf,int);
input clki, rst, miso;
input [31:0] spi_buf;
output mosi,ss,clko,int;

endmodule
