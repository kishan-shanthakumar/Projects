module mul(input [7:0] mul_a,mul_b,
			output [7:0] pro);

logic [15:0] mulans;
assign mulans = ($signed(mul_a) * $signed(mul_b));
assign pro = mulans >> 7;

endmodule