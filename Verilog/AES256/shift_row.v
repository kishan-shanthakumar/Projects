module shift_row(inp, out);
	input [127:0] inp;
	output [127:0] out; 
	
	assign out[127:96] = inp[127:96];
	assign out[95:64] = {inp[87:64],inp[95:88]};
	assign out[63:32] = {inp[47:32],inp[63:48]};
	assign out[31:0] = {inp[7:0],inp[31:8]};
	
endmodule
