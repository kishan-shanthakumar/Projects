module mux_n #(parameter N = 3)
					(output logic out,
					input logic [N-1:0] s,
					input logic [2**N-1:0] inp);

always_comb
begin
	out = inp[s];
end

endmodule