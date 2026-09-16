module mix_column(inp,out);
	input [127:0] inp;
	output reg [127:0] out;
	
	integer i;
	
	always @(*)
	begin
		for(i = 0; i < 4; i = i + 1)
		begin
			out[127-(i*8)-:8] = inp[127-(i*8)-:8]<<1 ^  (inp[95-(i*8)-:8]<<1 ^ inp[95-(i*8)-:8]) ^ inp[63-(i*8)-:8] ^ inp[31-(i*8)-:8];
			out[95-(i*8)-:8] = inp[127-(i*8)-:8] ^  inp[95-(i*8)-:8]<<1 ^ (inp[63-(i*8)-:8]<<1 ^ inp[63-(i*8)-:8]) ^ inp[31-(i*8)-:8];
			out[63-(i*8)-:8] = inp[127-(i*8)-:8] ^  inp[95-(i*8)-:8] ^ inp[63-(i*8)-:8]<<1 ^ (inp[31-(i*8)-:8]<<1 ^ inp[31-(i*8)-:8]);
			out[31-(i*8)-:8] = (inp[127-(i*8)-:8]<<1 ^ inp[127-(i*8)-:8]) ^  inp[95-(i*8)-:8] ^ inp[63-(i*8)-:8] ^ inp[31-(i*8)-:8]<<1;
		end
	end
	
endmodule
