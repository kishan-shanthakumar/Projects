module nor2(input logic [1:0] a,
			output logic y);
nor u1(y,a[1],a[0]);
endmodule