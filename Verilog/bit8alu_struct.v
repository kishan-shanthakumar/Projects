module fa(
input a,b,c,
output s,cout
);
wire w1,w2,w3;
xor(s,a,b,c);
and(w1,a,b);
xor(w2,a,b);
and(w3,w2,c);
or(cout,w3,w1);
endmodule

module fabit4(a,b,cin,sum,cout);
input[3:0] a,b;
input cin;
output [3:0] sum;
output cout;
wire p0,p1,p2,p3,g0,g1,g2,g3,c1,c2,c3,c4;
assign p0=(a[0]^b[0]),
p1=(a[1]^b[1]),
p2=(a[2]^b[2]),
p3=(a[3]^b[3]);
assign g0=(a[0]&b[0]),
g1=(a[1]&b[1]),
g2=(a[2]&b[2]),
g3=(a[3]&b[3]);
assign c0=cin,
c1=g0|(p0&cin),
c2=g1|(p1&g0)|(p1&p0&cin),
c3=g2|(p2&g1)|(p2&p1&g0)|(p1&p1&p0&cin),
c4=g3|(p3&g2)|(p3&p2&g1)|(p3&p2&p1&g0)|(p3&p2&p1&p0&cin);
assign sum[0]=p0^c0,
sum[1]=p1^c1,
sum[2]=p2^c2,
sum[3]=p3^c3;
assign cout=c4;
endmodule

module bit4(
input [3:0] inp1,
input [3:0] inp2,
output [7:0] outp
);
wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15;
wire d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18;
and a1(outp[0],inp1[0],inp2[0]);
and a2(w15,inp1[1],inp2[0]);
and(w14,inp1[2],inp2[0]);
and(w13,inp1[3],inp2[0]);
and(w12,inp1[0],inp2[1]);
and(w11,inp1[1],inp2[1]);
and(w10,inp1[2],inp2[1]);
and(w9,inp1[3],inp2[1]);
and(w8,inp1[0],inp2[2]);
and(w7,inp1[1],inp2[2]);
and(w6,inp1[2],inp2[2]);
and(w5,inp1[3],inp2[2]);
and(w4,inp1[0],inp2[3]);
and(w3,inp1[1],inp2[3]);
and(w2,inp1[2],inp2[3]);
and(w1,inp1[3],inp2[3]);
fa fa1(w15,w12,0,outp[1],d1);
fa fa2(w14,w11,d1,d2,d3);
fa fa3(d2,w8,0,outp[2],d4);
fa fa4(d3,d4,0,d5,d6);
fa fa5(d5,w13,w10,d7,d8);
fa fa6(d7,w7,w4,outp[3],d9);
fa fa7(d6,d8,d9,d10,d11);
fa fa8(w9,w6,w3,d12,d13);
fa fa9(d10,d12,0,outp[4],d15);
fa fa10(d15,d13,d11,d16,d17);
fa fa11(d16,w5,w2,outp[5],d18);
fa fa12(d17,d18,w1,outp[6],outp[7]);
endmodule

module fabit8(
input [7:0] inp1,
input [7:0] inp2,
input cin,
output [7:0] outp,
output cout
);
wire w1;
fabit4 fa1(inp1[3:0],inp2[3:0],cin,outp[3:0],w1);
fabit4 fa2(inp1[7:4],inp2[7:4],w1,outp[7:4],cout);
endmodule

module bit8(
input [7:0] inp1,
input [7:0] inp2,
output [15:0] outp
);
wire [7:0] w1;
wire [7:0] w2;
wire [7:0] w3;
wire [7:0] w4;
wire [7:0] w5;
wire [7:0] w6;
wire [7:0] w7;
wire w8,w9,w10,w11,w12;
bit4 mul1(inp1[3:0],inp2[3:0],w1);
bit4 mul2(inp1[3:0],inp2[7:4],w2);
bit4 mul3(inp1[7:4],inp2[3:0],w3);
bit4 mul4(inp1[7:4],inp2[7:4],w4);
assign outp[3:0] = w1[3:0];
fabit8 fa1(w3[7:0],w2[7:0],0,w5[7:0],w8);
fabit8 fa2(w5[7:0],{w4[3:0],w1[7:4]},0,outp[11:4],w9);
fa fa3(w8,w9,0,w10,w11);
wire [3:0] w13 = {2'b0,w11,w10};
fabit4 fa4(w4[7:4],w13,0,outp[15:12],w12);
endmodule

module mux8(s,a,b,c,d,e,f,g,h,out);
input [2:0] s;
input [7:0] a,b,c,d,e,f,g,h;
output [7:0] out;
bufif1 b1(out, a, ((~s[0]) & (~s[1]) & (~s[2]) ));
bufif1 b2(out, b, ((s[0]) & (~s[1]) & (~s[2]) ));
bufif1 b3(out, c, ((~s[0]) & (s[1]) & (~s[2]) ));
bufif1 b4(out, d, ((s[0]) & (s[1]) & (~s[2]) ));
bufif1 b5(out, e, ((~s[0]) & (~s[1]) & (s[2]) ));
bufif1 b6(out, f, ((s[0]) & (~s[1]) & (s[2]) ));
bufif1 b7(out, g, ((~s[0]) & (s[1]) & (s[2]) ));
bufif1 b8(out, h, ((s[0]) & (s[1]) & (s[2]) ));
endmodule

module bit8alu(
input [7:0] a,
input [7:0] b,
input [2:0] s,
output [7:0] acc,
output [7:0] mulh,
output [7:0] flag);

wire [7:0] ands;
wire [7:0] orrs;
wire [7:0] nots;
wire [7:0] lsl;
wire [7:0] lsr;
wire [7:0] add;
wire [7:0] sub;
wire [7:0] mul;
wire [7:0] mulhw;

wire [7:0] temp;

and u1(ands, a, b);
or  u2(orrs, a, b);
not u3(nots, a);
assign lsl = {a[7:1],1'b0};
assign lsr = {1'b0,a[6:0]};
fabit8 u4(a,b,0,add,flag[4]);
not u5(temp,b);
fabit8 u6(a,temp,1,sub,flag[5]);
bit8 u7(a,b,{mulh,mul});

mux8 u8(s,ands,orrs,nots,lsl,lsr,add,sub,mul,acc);

assign flag[0] = ~| a;
assign flag[1] = ~^ a;
assign flag[2] = a[7];
assign flag[3] = a[0];
assign flag[6] = ~| acc;
assign flag[7] = ~^ acc;

endmodule
