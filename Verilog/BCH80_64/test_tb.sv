`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2021 19:49:01
// Design Name: 
// Module Name: test_tb
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

class packet;

rand bit [79:0] rand1;
rand bit [63:0] rand2;

constraint kkk{
    rand1 >= 0 && rand1 < 40;
}

endclass

module test_tb();

bit [63:0] inpdata;
bit [79:0] code;
bit [63:0] data;
bit [15:0] synd;
bit [5:0] random_wire1;
bit [5:0] random_wire2;
bit ec;
bit conf;

initial begin

packet pkt1;
pkt1 = new();
pkt1.randomize();
random_wire1 = pkt1.rand1;

inpdata = pkt1.rand2;

code[random_wire1 + 40] = !code[random_wire1 + 40];
code[random_wire2] = !code[random_wire2];

end

always @(*)
begin
if (inpdata == data)
begin
    conf = 1;
end
end

ham80_64e uut1(inpdata, code);
synd_ecc uut2(code,data,synd,ec);

endmodule