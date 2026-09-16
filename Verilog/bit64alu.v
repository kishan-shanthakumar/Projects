`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2020 19:49:57
// Design Name: 
// Module Name: bit64alu
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


module bit64alu(s,en,inp1,inp2,out,mulh,flag);
input [3:0] s;
input en;
input [63:0] inp1,inp2;
output reg [63:0] out;
output reg [63:0] mulh;
output reg [7:0] flag;
reg [127:0] temp;
reg [63:0] temp1;
reg [63:0] temp3;
reg [6:0] temp2;
always @ (en)
begin
    if(!s[0] & !s[1] & !s[2] & !s[3])
    begin
        out = 0;
    end
    if(!s[0] & !s[1] & !s[2] & s[3])
    begin
        out = 64'b1;
    end
    if(!s[0] & !s[1] & s[2] & !s[3])
    begin
        out = inp1 & inp2;
    end
    if(!s[0] & !s[1] & s[2] & s[3])
    begin
        out = inp1 | inp2;
    end
    if(!s[0] & s[1] & !s[2] & !s[3])
    begin
        out = !inp1;
    end
    if(!s[0] & s[1] & !s[2] & s[3])
    begin
        temp = inp1 + 1;
        out = temp[63:0];        
        flag[0] = temp[64];
    end
    if(!s[0] & s[1] & s[2] & !s[3])
    begin
        out = inp1 << inp2;
    end
    if(!s[0] & s[1] & s[2] & s[3])
    begin
        temp = inp1 - 1;
        out = temp[63:0];        
        flag[1] = temp[64];
    end
    if(s[0] & !s[1] & !s[2] & !s[3])
    begin
        out = inp1 >> inp2;
    end
    if(s[0] & !s[1] & !s[2] & s[3])
    begin
        temp = inp1 + inp2;
        out = temp[63:0];        
        flag[2] = temp[64];
    end
    if(s[0] & !s[1] & s[2] & !s[3])
    begin
        temp = inp1 - inp2;
        out = temp[63:0];        
        flag[3] = temp[64];
    end
    if(s[0] & !s[1] & s[2] & s[3])
    begin
        temp1 = {inp1[62:0],inp1[63]};
        out = temp1;
    end
    if(s[0] & s[1] & !s[2] & !s[3])
    begin
        temp1 ={inp1[0],inp1[63:1]};
        out = temp1;
    end
    if(s[0] & s[1] & !s[2] & s[3])
    begin
        temp1 = inp1;
    end
    if(s[0] & s[1] & s[2] & !s[3])
    begin
        temp = inp1 * inp2;
        out = temp[63:0];
        mulh = temp[127:0];
    end
    if(s[0] & s[1] & s[2] & s[3])
    begin
        out = {61'b0,(inp1<inp2),(inp1>inp2),(inp1==inp2)};
    end
    flag[6] = ~|out;
    flag[7] = ~^out;
    flag[4] = ~|inp1;
    flag[5] = ~|inp2;
end
endmodule
