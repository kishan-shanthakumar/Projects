module bit32alu(a,b,s,acc,mulh,flag);

parameter width = 32,
				w = width - 1;

input [w:0] a;
input [w:0] b;
input [3:0] s;
output reg [w:0] acc;
output reg [w:0] mulh;
output reg [7:0] flag;

always @(*)
begin
	case (s)
	4'b0000 : acc = {(width){1'b0}};
	4'b0001 : acc = {(width){1'b1}};
	4'b0010 : acc = a & b;
	4'b0011 : acc = a | b;
	4'b0100 : acc = ~a;
	4'b0101 : {flag[0] , acc} = a + 1;
	4'b0110 : acc = a << 1;
	4'b0111 : {flag[2] , acc} = a - 1;
	4'b1000 : acc = acc >> 1;
	4'b1001 : {flag[4] , acc} = a + b;
	4'b1010 : {flag[5] , acc} = a - b;
	4'b1011 : acc = a;
	4'b1100 : acc = {a[(w-1):0] , a[w]};
	4'b1101 : acc = {a[0] , a[w:1]};
	4'b1110 : {mulh , acc} = a * b;
	4'b1111 : acc = (a>b)?{{(w-2){1'b0}},1'b0,1'b1,1'b0}:((a<b):{{(w-2){1'b0}},1'b1,1'b0,1'b0}:{{(w-2){1'b0}},1'b0,1'b0,1'b1});
	endcase
	flag[1] = a[w];
	flag[3] = a[0];
	flag[6] = ~| acc;
	flag[7] = ~^ acc;
end

endmodule