module s_box(b,s);
	input [7:0] b;
	output [7:0] s;
	
	assign s[0] = b[0] ^ b[4] ^ b[5] ^ b[6] ^ b[7] ^ 1'b1;
	assign s[1] = b[0] ^ b[1] ^ b[5] ^ b[6] ^ b[7] ^ 1'b1;
	assign s[2] = b[0] ^ b[1] ^ b[2] ^ b[6] ^ b[7] ^ 1'b0;
	assign s[3] = b[0] ^ b[1] ^ b[2] ^ b[3] ^ b[7] ^ 1'b0;
	assign s[4] = b[0] ^ b[1] ^ b[2] ^ b[3] ^ b[4] ^ 1'b0;
	assign s[5] = b[1] ^ b[2] ^ b[3] ^ b[4] ^ b[5] ^ 1'b1;
	assign s[6] = b[2] ^ b[3] ^ b[4] ^ b[5] ^ b[6] ^ 1'b1;
	assign s[7] = b[3] ^ b[4] ^ b[5] ^ b[6] ^ b[7] ^ 1'b0;
	
endmodule
