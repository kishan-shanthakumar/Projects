/*
32 -> 1, 8, 23
64 -> 1, 11, 52
*/

/*
Steps in addition:
=== Check for zeros and equality ===
1. Check for the number with larger exponent
2. Match the exponent, shift the smaller number
3. Check the sign of the number
4. Add/Subtract
*/

module fadd #(parameter N = 32)
            (input logic [N-1:0] a, b,
            output logic [N-1:0] out);

`ifdef N == 32
    int exp = 30;
    int man = 22;
`else
    int exp = 62;
    int man = 51;
`endif

reg [N-1:0] ff11, ff12;
reg [N-1:0] ff21, ff22;
reg [N-1:0] ff31, ff32;
reg [N-1:0] ff41, ff42;
logic [N-1:0] shft_amtab;
logic [N-1:0] shft_amtba;
logic [N-1:0] a1;
logic [N-1:0] b1;

always_ff
begin
    // Stage 1
    for(int i = 0;i < N; i++)
    begin
        a1[i] = !a[i];
        b1[i] = !b[i];
    end
    cseladd #(exp-man) u1(a[exp:man+1],b1[exp:man+1],1,shft_amtab);
    cseladd #(exp-man) u2(b[exp:man+1],a1[exp:man+1],1,shft_amtba);
    ff11 = {a[N-1], b[exp:man+1], a[man:0]>>shft_amtba};
    ff12 = {b[N-1], a[exp:man+1], b[man:0]>>shft_amtab};
end

endmodule
