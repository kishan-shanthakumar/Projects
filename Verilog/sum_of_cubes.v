`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2020 02:06:21
// Design Name: 
// Module Name: sum_of_cubes
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

module factorize(clk,inp,outp,flag,fin);
input [255:0] inp;
output [63:0] outp;
output reg flag;
output reg fin = 0;
input clk;
reg flag_local;

reg [63:0] i;
reg [255:0] j;
reg [255:0] k;
reg [255:0] z;

always @ (posedge clk)
begin
    if (flag_local == 0)
    begin
        i <= i + 1 ;
        if( i < inp )
        begin
            flag <= 1;
        end
        else
            flag <= 0;
	 end
	 if ( inp % i == 0 )
    begin
        flag_local <= 1;
    end
    if (flag_local)
    begin
        j <= inp / i;
        k <= i;
        z <= 1;
    end
	 if (flag_local)
    begin
        if( (z*z - z*(k-z) + (k-z)*(k-z) ) == j)
        begin
            fin <= 1;
            flag <= 0;
        end
        z <= z + 1 ;
    end
end
endmodule

module sumcube(clk,inp,Q,out,flago,fino);
input [63:0] Q;
input [7:0] inp;
output [63:0] out;
output fino,flago;
input clk;

wire [255:0] cubeop = ( {192'b0,Q} * {192'b0,Q} ) * {192'b0,Q};
wire [255:0] out1 = {248'b0,inp} + cubeop;
wire [255:0] out2 = {248'b0,inp} - cubeop;
wire [255:0] out3 = cubeop - {248'b0,inp};

wire [63:0] wire0,wire1,wire2;
wire [2:0] flag;
wire [2:0] fin;

factorize f0(clk,out1,wire0,flag[0],fin[0]);
factorize f1(clk,out2,wire1,flag[1],fin[1]);
factorize f2(clk,out3,wire2,flag[2],fin[2]);

assign flago = |flag;
assign fino = |fin;

assign out = (fino)? (fin[0])? wire0 : (fin[1])? wire1 : wire2 : 0;

endmodule

module Sum_of_Cubes(inp,clk,reset,out,fino);
input [7:0] inp;
input clk;
input reset;
output reg [63:0] out;
output fino;

integer i;
integer j;

reg [9:0] [63:0]Q;

wire [9:0] flag,fin;
wire [9:0] [63:0]wires;

sumcube s[9:0](clk,inp,Q,wires,flag,fin);

always @ ( posedge clk, negedge reset )
begin
    if (!reset)
        for( i = 0 ; i < 10 ; i <= i + 1 )
        begin
            Q[i] <= i;
        end
    else
    begin
    for( i = 0 ; i < 10 ; i <= i + 1 )
    begin
        if(fin[i])
        begin
            out <= wires[i];
        end
    end
    if (!reset)
    begin
        for( i = 0 ; i < 10 ; i <= i + 1 )
        begin
            Q[i] <= 0;
        end
    end
    else
    begin
        if(|flag)
        begin
            for( i = 0 ; i < 10 ; i <= i + 1 )
            begin
                Q[i] <= 0;
            end
        end
        else
        begin
            for( i = 0 ; i < 10 ; i <= i + 1 )
            begin
                Q[i] <= Q[i] + 10;
            end
        end
    end
    end
end

assign fino <= |fin;

endmodule