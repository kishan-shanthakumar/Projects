module dec3_8_bool(input logic [2:0] inp,
					output logic [7:0] out);

always_comb
begin
	out[0] = ~inp[0] & ~inp[1] & ~inp[2];
	out[1] = inp[0] & ~inp[1] & ~inp[2];
	out[2] = ~inp[0] & inp[1] & ~inp[2];
	out[3] = inp[0] & inp[1] & ~inp[2];
	out[4] = ~inp[0] & ~inp[1] & inp[2];
	out[5] = inp[0] & ~inp[1] & inp[2];
	out[6] = ~inp[0] & inp[1] & inp[2];
	out[7] = inp[0] & inp[1] & inp[2];
end

endmodule