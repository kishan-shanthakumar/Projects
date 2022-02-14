module byte_sub(inp, out);
	input[127:0] inp;
	output[127:0] out;
	
	s_box s1(inp[7:0],out[7:0]);
	s_box s2(inp[15:8],out[15:8]);
	s_box s3(inp[23:16],out[23:16]);
	s_box s4(inp[31:24],out[31:24]);
	s_box s5(inp[39:32],out[39:32]);
	s_box s6(inp[47:40],out[47:40]);
	s_box s7(inp[55:48],out[55:48]);
	s_box s8(inp[63:56],out[63:56]);
	s_box s9(inp[71:64],out[71:64]);
	s_box s10(inp[79:72],out[79:72]);
	s_box s11(inp[87:80],out[87:80]);
	s_box s12(inp[95:88],out[95:88]);
	s_box s13(inp[103:96],out[103:96]);
	s_box s14(inp[111:104],out[111:104]);
	s_box s15(inp[119:112],out[119:112]);
	s_box s16(inp[127:120],out[127:120]);
	
endmodule
