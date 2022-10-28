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
*/

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

logic [N-1:0] exp_calc;
logic [N-1:0] exp_calc1;
cseladd #(exp_len) u1(a[exp:man+1], b[exp:man+1], 0, exp_calc);
cseladd #(exp_len) u1(exp_calc, ~(2**(exp_len-1)-1), 1, exp_calc1);

always_comb @(posedge clk, negedge rst)
begin
    out[N-1] = a[N-1] ^ b[N-1];
    
end

endmodule
