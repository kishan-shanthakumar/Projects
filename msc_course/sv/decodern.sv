// Parametrized decoder for n input decoder

module decodern
	#(parameter N = 3)
	(input logic [N-1:0] a,
	 output logic [(2**N)-1:0] y);

always_comb
	y = 1'b1 << a;

endmodule