module an(inp,op);
input [3:0] inp;
output reg [6:0] op;

always @(*)
begin
	case (inp)
	4'b0000 : op = 7'b0111111 ^ 7'b1111111;
	4'b0001 : op = 7'b0000110 ^ 7'b1111111;
	4'b0010 : op = 7'b1011011 ^ 7'b1111111;
	4'b0011 : op = 7'b1001111 ^ 7'b1111111;
	4'b0100 : op = 7'b1100110 ^ 7'b1111111;
	4'b0101 : op = 7'b1101101 ^ 7'b1111111;
	4'b0110 : op = 7'b1111101 ^ 7'b1111111;
	4'b0111 : op = 7'b0000111 ^ 7'b1111111;
	4'b1000 : op = 7'b1111111 ^ 7'b1111111;
	4'b1001 : op = 7'b1101111 ^ 7'b1111111;
	default: op = 7'b1111111;
	endcase
end

endmodule