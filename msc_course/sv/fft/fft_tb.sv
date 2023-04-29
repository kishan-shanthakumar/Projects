module fft_tb;

logic [7:0] inp, out;
logic readyin, clk, rst;

initial begin
clk = 0;
rst = 1;
#1 rst = 0;
#5 rst = 1;
end

initial begin
readyin = 0;
#10 readyin = 1;
#10 readyin = 0;
#10;
inp = 8'b01100000; // w1
readyin = 1;
#10;
readyin = 0;
#20;
inp = 8'b11000000; // w2
readyin = 1;
#10;
readyin = 0;
#20;
inp = 8'b00000010; // a1
readyin = 1;
#10;
readyin = 0;
#20;
inp = 8'b00000011; // a2
readyin = 1;
#10;
readyin = 0;
#20;
inp = 8'b00000101; // b1
readyin = 1;
#10;
readyin = 0;
#20
inp = 8'b00000110; // b2
readyin = 1;
#10;
readyin = 0;
#20;
readyin = 1;
#20;
readyin = 0;
#20;
readyin = 1;
#20;
readyin = 0;
#20;
readyin = 1;
#20;
readyin = 0;
#20;
readyin = 1;
#20;
readyin = 0;
#20;
readyin = 1;
#20;
readyin = 0;
#20;
end

always #5 clk = ~clk;

fft u1(.*);

endmodule