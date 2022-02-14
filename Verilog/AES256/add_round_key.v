module add_round_key(inp,key,out);
	input [127:0] inp;
	input [127:0] key;
	output [127:0] out;
	
	assign out = inp ^ key;
	
endmodule
