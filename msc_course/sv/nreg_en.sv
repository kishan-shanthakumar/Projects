module nreg_en #(parameter N=8)
	(input logic [N-1:0] d,
	input logic clk, rst, enable,
	output logic [N-1:0] q);

always_ff @(posedge clk, negedge rst)
	if (!rst)
		q <= 0;
	else if (enable)
		q <= d;

endmodule