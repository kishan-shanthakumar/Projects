module sub_word(inp,out);
	input [31:0] inp;
	output [31:0] out;
	
	s_box s1(inp[7:0], out[7:0]);
	s_box s2(inp[15:8], out[15:8]);
	s_box s3(inp[23:16], out[23:16]);
	s_box s4(inp[31:24], out[31:24]);
	
endmodule
