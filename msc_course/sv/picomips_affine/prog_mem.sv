module prog_mem (input logic [4:0] addr,
					input logic clock, rst,
					output logic [13:0] inp);

logic [15:0] mem_rom [0:16385];

always_comb
begin
	inp = mem_rom[addr];
end

always @(negedge rst)
begin
	if(!rst)
	begin
		mem_rom[0] <= 14'b01001100000001; 
		mem_rom[1] <= 14'b01010000000001; 
		mem_rom[2] <= 14'b00011010100001; 
		mem_rom[3] <= 14'b00100000000000; 
		mem_rom[4] <= 14'b00101000000000; 
		mem_rom[5] <= 14'b00110100001101; 
		mem_rom[6] <= 14'b00111101010101; 
		mem_rom[7] <= 14'b00111111110111; 
		mem_rom[8] <= 14'b00111111011111; 
		mem_rom[9] <= 14'b11001100000001; 
		mem_rom[10] <= 14'b01010100000001; 
		mem_rom[11] <= 14'b11011101100001; 
		mem_rom[12] <= 14'b00001100001101; 
		mem_rom[13] <= 14'b00010101010101; 
		mem_rom[14] <= 14'b00110010001111; 
		mem_rom[15] <= 14'b00110011110111;
		mem_rom[16] <= 14'b00111000000010;
		mem_rom[17] <= 14'b00110000000010;
		mem_rom[18] <= 14'b00000000000011;
	end
end

endmodule