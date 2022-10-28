/*
32 -> 1, 8, 23
64 -> 1, 11, 52
*/

/*
Steps in multiplication:
=== Check for zeros and equality ===
1. Add the exponents and subtract 127
2. Multiply the mantissa
3. Check the sign of the number
4. Adjust shifting of mantissa
*/


module enc_n #(parameter N = 5)
					(output logic [N-1:0] out,
					output logic valid,
					input logic [2**N-1:0] inp);

always_comb
begin
	valid = 0;
	for (int i = 2**N-1; i >= 0; i--)
		if (inp[i] == 1)
		begin
			out = i;
			valid = 1;
			break;
		end
end

endmodule

module fmul #(parameter N = 32)
            (input logic [N-1:0] a, b,
            input logic clk, rst,
            output logic [N-1:0] out);

`ifdef N == 64
    parameter exp = 62;
    parameter man = 51;
    parameter exp_len = 11;
    parameter enc_len = 6;
`else
    parameter exp = 30;
    parameter man = 22;
    parameter exp_len = 8;
    parameter enc_len = 5;
`endif

reg [N-1:0] ff11, ff12;
reg [N-1:0] ffa, ffb;
reg [N-1:0] ff21, ff22;
reg [N-1:0] ff3;

endmodule
