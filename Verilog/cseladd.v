module cseladd(a,b,c,sum,carry);
input [3:0] a;
input [3:0] b;
input c;
output [3:0] sum;
output carry;

wire [3:0] zero;
wire [3:0] one;
wire [3:0] zerocarry;
wire [3:0] onecarry;

wire [2:0] car;

xor x1(zero[0], a[0], b[0]);
and a1(zerocarry[0], a[0], b[0]);

xor x2(zero[1], a[1], b[1]);
and a2(zerocarry[1], a[1], b[1]);

xor x3(zero[2], a[2], b[2]);
and a3(zerocarry[2], a[2], b[2]);

xor x4(zero[3], a[3], b[3]);
and a4(zerocarry[3], a[3], b[3]);

xor x5(one[0], ~a[0], b[0]);
or a5(onecarry[0], (a[0]^b[0]), a[0]&b[0]);

xor x6(one[1], ~a[1], b[1]);
or a6(onecarry[1], (a[1]^b[1]), a[1]&b[1]);

xor x7(one[2], ~a[2], b[2]);
or a7(onecarry[2], (a[2]^b[2]), a[2]&b[2]);

xor x8(one[3], ~a[3], b[3]);
or a8(onecarry[3], (a[3]^b[3]), a[3]&b[3]);

//LSB
bufif1 b1(sum[0], one[0], c);
bufif1 b2(car[0], onecarry[0], c);

bufif1 b3(sum[0], zero[0], ~c);
bufif1 b4(car[0], zerocarry[0], ~c);

//B3
bufif1 b5(sum[1], one[1], car[0]);
bufif1 b6(car[1], onecarry[1], car[0]);

bufif1 b7(sum[1], zero[1], ~car[0]);
bufif1 b8(car[1], zerocarry[1], ~car[0]);

//B2
bufif1 b9(sum[2], one[2], car[1]);
bufif1 b10(car[2], onecarry[2], car[1]);

bufif1 b11(sum[2], zero[2], ~car[1]);
bufif1 b12(car[2], zerocarry[2], ~car[1]);

//MSB
bufif1 b13(sum[3], one[3], car[2]);
bufif1 b14(carry, onecarry[3], car[2]);

bufif1 b15(sum[3], zero[3], ~car[2]);
bufif1 b16(carry, zerocarry[3], ~car[2]);
endmodule