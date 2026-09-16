module rot_word(a,b);
	input [31:0] a;
	output [31:0] b;
	
	assign b = {a[23:0], a[31:24]};
	
endmodule
