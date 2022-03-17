module i2c(clki,sdai,rst,clko,sdao,int,i2c_buf);
input clki, sdai, rst;
input [31:0] i2c_buf;
output clko, sdao, int;

endmodule
