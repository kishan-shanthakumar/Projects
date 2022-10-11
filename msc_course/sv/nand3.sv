module nand3(input [2:0] a,
			output b);
logic [2:0] in;
not u1(in[0], a[0]);
not u2(in[1], a[1]);
not u3(in[2], a[2]);

always_comb
	b = in[0] | in[1] | in[2];

endmodule