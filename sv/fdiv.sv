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

logic [exp_len-1:0] exp_calc;
logic [exp_len-1:0] exp_calc1;
logic [man+1:0] div;
logic temp;
logic [man+1:0] temp_man;
logic [enc_len-1:0] shft;

cseladd #(exp_len) u1(a[exp:man+1], (2**(exp_len-1)-1), 0, exp_calc);
cseladd #(exp_len) u2(exp_calc, ~b[exp:man+1], 1, exp_calc1);
n_divider #((man+2)*2) u3({1,a[man:0],{(man+2){1'b0}}},{1,b[man:0]},div,temp_man);
enc_n #(enc_len) u4(shft,temp,div);

always_comb
begin
    out[N-1] = a[N-1] ^ b[N-1];
    if (a[exp:man+1] == '1 | b[exp:man+1] == '1)
        if (a[man:0] > 0 | b[man:0] > 0)
            out[exp:0] = '1;
        else
            out[exp:0] = {{exp{1'b1}},{man{1'b0}}};
    else if (a[exp:0] == 0| b[exp:0] == 0)
        out[exp:0] = (a[exp:0] == 0) ? 0 : {N{1'b1}};
    else if ($signed(a[exp:man+1]-b[exp:man+1]) > $signed((2**(exp_len-1)-1)))
    begin
        out[exp:man+1] = '1;
        out[man:0] = 0;
    end
    else if ($signed(a[exp:man+1]-b[exp:man+1]) < $signed(-(2**(exp_len-1)-2)))
        out[exp:0] = 0;
    else
    begin
        out [exp:man+1] = exp_calc1 - (man + 2 - shft);
        out [man:0] = div[man:0] << (man + 2 - shft);;
    end
end

endmodule
