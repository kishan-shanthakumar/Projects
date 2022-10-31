/*
32 -> 1, 8, 23
64 -> 1, 11, 52
*/

/*
Steps in multiplication:
=== Check for zeros and equality ===
1. Subtract the exponents and add 127
2. Divide the mantissa
3. Check the sign of the number
*/

module fdiv #(parameter N = 32)
            (input logic [N-1:0] a, b,
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
logic [(man+2)*2-1:0] man_mul;
logic flag;
cseladd #(exp_len) u1(a[exp:man+1], (2**(exp_len-1)-1), 1, exp_calc);
cseladd #(exp_len) u2(exp_calc, !(b[exp:man+1]), 0, exp_calc1);
n_divider #(man+2) u3({1,a[man:0]},{1,b[man:0]},man_mul);

always_comb
begin
    out[N-1] = a[N-1] ^ b[N-1];
    if( {man_mul[(man+2)*2-1],man_mul[(man+2)*2-2]} < 2'b10 )
    begin
        out[man:1] = man_mul[((man+2)*2-3)-:22];
        out[0] = {man_mul[(man+2)*2-25], man_mul[(man+2)*2-26], man_mul[(man+2)*2-27]} >= 2'b011 ? 1 : 0;
        out[exp:man+1] = exp_calc1-1;
    end
    else
    begin
        out[man:1] = man_mul[((man+2)*2-2)-:22];
        out[0] = {man_mul[(man+2)*2-24], man_mul[(man+2)*2-25], man_mul[(man+2)*2-26]} >= 2'b011 ? 1 : 0;
        if( a[exp:man+1]-(2**(exp_len-1)-1) == b[exp:man+1]-(2**(exp_len-1)-1) & a[exp:man+1]-(2**(exp_len-1)-1) == 0)
            out[exp:man+1] = 2**(exp_len-1) - 1;
        else if( a[exp:man+1]-(2**(exp_len-1)-1) == 0 | b[exp:man+1]-(2**(exp_len-1)-1) == 0 )
            out[exp:man+1] = |(b[exp:man+1]-(2**(exp_len-1)-1)) == 0 ? a[exp:man+1] : exp_calc1;
        else
            out[exp:man+1] = exp_calc1;
    end
end

endmodule
