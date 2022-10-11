module full_adder(input a,b,c0,
				  output sum,carry);
always_comb
begin
	sum = a ^ b ^ c0;
end

always_comb
	carry = ((a ^ b) & c0) | (a & b);
begin
	
end
endmodule