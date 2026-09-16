module dec3_8_condition(input logic [2:0] inp,
					output logic [7:0] out);

always_comb
begin
	out = '0;
	if( ~inp[0] & ~inp[1] & ~inp[2])
		out[0] = 1;
	else if( inp[0] & ~inp[1] & ~inp[2])
		out[1] = 1;
	else if( ~inp[0] & inp[1] & ~inp[2])
		out[2] = 1;
	else if( inp[0] & inp[1] & ~inp[2])
		out[3] = 1;
	else if( ~inp[0] & ~inp[1] & inp[2])
		out[4] = 1;
	else if( inp[0] & ~inp[1] & inp[2])
		out[5] = 1;
	else if( ~inp[0] & inp[1] & inp[2])
		out[6] = 1;
	else if( inp[0] & inp[1] & inp[2])
		out[7] = 1;
end

endmodule