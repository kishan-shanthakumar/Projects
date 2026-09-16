module key_exp(key,exp_key);
	input [255:0] key;
	output reg [1919:0] exp_key;
	
	integer temp0;
	wire [31:0] temp1;
	wire [31:0] temp2;
	wire [31:0] temp3;
	integer temp4;
	integer temp5;
	
	rot_word r1(temp0, temp1);
	sub_word s1(temp5, temp2);
	rcon r2(temp4,temp3);
	
	
	integer i;
	always @(*)
	begin
		for(i = 0; i < 60; i = i + 1)
		begin
			if ( i < 8 )
				exp_key[1919-(i*32)-:32] = key[255-(i*32)-:32];
			else if ( (i >= 8) && (i % 8 == 0) )
			begin
				temp0 = exp_key[1919-((i-1)*32)-:32];
				temp4 = i / 8;
				temp5 = temp1;
				exp_key[1919-(i*32)-:32] = exp_key[1919-((i-8)*32)-:32] ^ temp2 ^ temp3;
			end
			else if ( (i >= 8) && (i % 8 == 4) )
			begin
				temp5 = exp_key[1919-((i-1)*32)-:32];
				exp_key[1919-(i*32)-:32] = exp_key[1919-((i-8)*32)-:32] ^ temp2;
			end
			else
				exp_key[1919-(i*32)-:32] = exp_key[1919-((i-1)*32)-:32] ^ exp_key[1919-((i-8)*32)-:32];
		end
	end
	
endmodule
