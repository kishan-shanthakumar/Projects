`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2022 18:49:25
// Design Name: 
// Module Name: fadd_tb
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

rand bit [7:0] exp_rand;
rand bit [22:0] man_rand;
rand bit [1:0] s_rand;
rand bit sign_rand;

endclass

module falu_tb;
logic [31:0] out;
logic [31:0] a, b;
logic [1:0] s;
shortreal reala, realb;
shortreal realans;
shortreal realout;
logic [31:0] ra, rb;
int check;
logic result;
falu #(32) a1 (.*);
initial
begin
    packet pkt1;
    $display("Start");
    result = 0;
    for(int i = 0; i < 2048; i += 1)
    begin
        pkt1 = new();
        check = pkt1.randomize();
        s = pkt1.s_rand;
        ra = {pkt1.sign_rand, pkt1.exp_rand, pkt1.man_rand};
        reala = $bitstoshortreal(ra);
        a = ra;
        
        pkt1 = new();
        check = pkt1.randomize();
        rb = {pkt1.sign_rand, pkt1.exp_rand, pkt1.man_rand};
        realb = $bitstoshortreal(rb);
        b = rb;

        #1;
        result = 0;
        realout = $bitstoshortreal(out);
        realans = (s == 2'b00) ? reala+realb : ( (s == 2'b01) ? reala-realb : ( (s == 2'b10) ? reala*realb : reala/realb) );
        if ((((realout-realans)/realans)*100) > 0.5 | (((realout-realans)/realans)*100) < -0.5)
        begin
            result = 1;
            $display("a is %f", reala);
            $display("%h",a);
            $display("b is %f", realb);
            $display("%h",b);
            $display("Exp out is %f", realans);
            $display("Rec out is %f", realout);
            $display("%h",out);
            $display("Error %f", (((realout-realans)/realans)*100));
        end
        
        #5;
    end
    $display("End");
end
endmodule