module uart(clk,rst,tx,rx,uart_buf,int);
input clk,rst,rx;
input[31:0] uart_buf;
output tx,int;

endmodule
