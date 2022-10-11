module nor2(input [1:0] a,
			output y);
nor u1(y,a[1],a[0]);
endmodule