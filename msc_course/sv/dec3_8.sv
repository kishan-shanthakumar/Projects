module dec3_8(input logic [2:0] inp,
			  output logic [7:0] out);
always_comb
	case(inp)
		0 : out = 1;
		1 : out = 2;
		2 : out = 4;
		3 : out = 8;
		4 : out = 16;
		5 : out = 32;
		6 : out = 64;
		7 : out = 128;
	default : out = 'x;
	endcase
endmodule