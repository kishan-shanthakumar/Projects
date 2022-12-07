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
logic [man+1:0] man_mul;
logic flag;
logic temp;
logic [man:0] temp_man;
logic [enc_len:0] shft;

cseladd #(exp_len) u1(a[exp:man+1], (2**(exp_len-1)-1), 0, exp_calc);
cseladd #(exp_len) u2(exp_calc, ~b[exp:man+1], 1, exp_calc1);
n_divider #(man/2+1) u3({1,a[man:man/2+1]},{1,b[man:man/2+1]},man_mul);
enc_n #(5) u4(shft,temp,temp_man);

always_comb
begin
    out[N-1] = a[N-1] ^ b[N-1];
    if (a[exp:man+1] == '1 | b[exp:man+1] == '1)
        if (a[man:0] > 0 | b[man:0] > 0)
            out[exp:0] = '1;
        else
            out[exp:0] = {{exp{1'b1}},{man{1'b0}}};
    else if (a[exp:0] == 0| b[exp:0] == 0)
        out[exp:0] = (a[exp:0] == 0) ? b[exp:0] : a[exp:0];
    else if ($signed($signed(a[exp:man+1]-(2**(exp_len-1)-1)) - $signed(b[exp:man+1]-(2**(exp_len-1)-1))) > 127)
    begin
        out[exp:man+1] = '1;
        out[man:0] = 0;
    end
    else if ($signed($signed(a[exp:man+1]-(2**(exp_len-1)-1)) - $signed(b[exp:man+1]-(2**(exp_len-1)-1))) < -126)
        out[exp:0] = 0;
    else if( {man_mul[(man+2)*2-1],man_mul[(man+2)*2-2]} < 2'b10 )
    begin
        temp_man[man:0] = man_mul[man+1:1];
        out[man:0] = temp_man[man:0]<<(2**enc_len-shft-9);
        out[exp:man+1] = exp_calc1;
    end
    else
    begin
        out[man:1] = man_mul[man+1:2];
        out[0] = {man_mul[1], man_mul[0]} > 2'b01 ? 1 : 0;
        if( a[exp:man+1]-(2**(exp_len-1)-1) == b[exp:man+1]-(2**(exp_len-1)-1) & a[exp:man+1]-(2**(exp_len-1)-1) == 0)
            out[exp:man+1] = 2**(exp_len-1) - 1;
        else if( a[exp:man+1]-(2**(exp_len-1)-1) == 0 | b[exp:man+1]-(2**(exp_len-1)-1) == 0 )
            out[exp:man+1] = |(b[exp:man+1]-(2**(exp_len-1)-1)) == 0 ? a[exp:man+1] : exp_calc1;
        else
            out[exp:man+1] = exp_calc1;
    end
end

endmodule
