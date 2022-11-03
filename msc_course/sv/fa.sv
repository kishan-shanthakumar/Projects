//Full adder with two always_comb block

module full_adder(input logic a,b,c0,
				  output logic sum,carry);
always_comb
begin
	sum = a ^ b ^ c0;
end

always_comb
	carry = ((a ^ b) & c0) | (a & b);
begin
	
end
endmodule