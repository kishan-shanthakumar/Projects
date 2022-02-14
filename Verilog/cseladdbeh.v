module cseladdbeh(a,b,c,sum,carry);
input [3:0] a;
input [3:0] b;
input c;
output reg [3:0] sum;
output reg carry;

reg [3:0] zero;
reg [3:0] one;
reg [3:0] zerocarry;
reg [3:0] onecarry;

reg[2:0] car;

always @(*)
begin
	{zerocarry[0],zero[0]} = a[0]+b[0];
	{zerocarry[1],zero[1]} = a[1]+b[1];
	{zerocarry[2],zero[2]} = a[2]+b[2];
	{zerocarry[3],zero[3]} = a[3]+b[3];

	{onecarry[0],one[0]} = a[0]+b[0]+1;
	{onecarry[1],one[1]} = a[1]+b[1]+1;
	{onecarry[2],one[2]} = a[2]+b[2]+1;
	{onecarry[3],one[3]} = a[3]+b[3]+1;
	
	sum[0] = c?one[0]:zero[0];
	car[0] = c?onecarry[0]:zerocarry[0];
	sum[1] = car[0]?one[1]:zero[1];
	car[1] = car[0]?onecarry[1]:zerocarry[1];
	sum[2] = car[1]?one[2]:zero[2];
	car[2] = car[1]?onecarry[2]:zerocarry[2];
	sum[3] = car[2]?one[3]:zero[3];
	carry = car[2]?onecarry[3]:zerocarry[3];
end
endmodule