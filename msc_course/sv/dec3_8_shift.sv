module dec3_8_shift(input logic [2:0] inp,
					output logic [7:0] out);

always_comb
begin
	out = 1 << inp;
end

endmodule