`timescale 1ns / 1ps

module fa(a,b,c,sum,carry);
input a,b,c;
output sum,carry;
assign sum = a^b^c;
assign carry = a&b + b&c + a&c;
endmodule

module bit32_rca(a,b,c,sum,carry);
input [31:0] a,b;
input c;
output [31:0] sum;
output carry;

wire [30:0] ca;

fa uut0(a[0],b[0],c,sum[0],ca[0]);
fa uut1(a[1],b[1],ca[0],sum[1],ca[1]);

endmodule
