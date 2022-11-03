module dffns (input logic d, clk, set,
			 output q);

always_ff @(negedge clk, posedge set)
	if (set)
		q <= 1;
	else
		q <= d;
endmodule