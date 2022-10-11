module prio_enc_tb();

logic [3:0] a;
logic [1:0] b;

initial begin
#10 a = 8;
always_comb #10
	if( a < 15 )
		a += 1;
#10 a = 4;
always_comb #10
	if( a < 7 )
		a += 1;
#10 a = 2;
#10 a = 3;
#10 a = 1;
end

//prio_enc u1(a,b);

endmodule