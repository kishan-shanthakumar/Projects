`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2022 01:39:38 AM
// Design Name: 
// Module Name: fdiv_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fdiv_tb();

reg [31:0] a,b;
wire [31:0] out;

initial begin
a = 32'b01000001001010000000000000000000;
b = 32'b01000000101000000000000000000000;
#10;
end

fdiv u1(a,b,out);

endmodule
