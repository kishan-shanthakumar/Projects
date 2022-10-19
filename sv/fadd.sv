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

cseladd #(exp-man) u1(a[exp:man+1],b1[exp:man+1],1,shft_amtab);
cseladd #(exp-man) u2(b[exp:man+1],a1[exp:man+1],1,shft_amtba);
cseladd #(man+1) u3(ff21[man:0],ff22[man:0],0,out[man:0]);

always_ff
begin
    // Stage 1
    for(int i = 0;i < N; i++)
    begin
        a1[i] = !a[i];
        b1[i] = !b[i];
    end
    //cseladd #(exp-man) u1(a[exp:man+1],b1[exp:man+1],1,shft_amtab);
    //cseladd #(exp-man) u2(b[exp:man+1],a1[exp:man+1],1,shft_amtba);
    ff11 = {a[N-1], b[exp:man+1], a[man:0]>>shft_amtba};
    ff12 = {b[N-1], a[exp:man+1], b[man:0]>>shft_amtab};
    
    if (a[N-2:0] == b[N-2:0] | a == 0 | b == 0)
    begin
        ff21 = a;
        ff22 = b;
    end
    else if (a > b)
    begin
        ff21 = a;
        ff22 = ff12;
    end
    else
    begin
        ff21 = ff11;
        ff22 = b;
    end
    if ( ff21[N-2:0] == ff22[N-2:0] )
    begin
        if (ff21[N-1] == ff22[N-1])
            out = {ff21[N-1],{ff21[exp:man+1] + 1},{ff21[man:0] << 1}}
        else
            out = '0;
    end
    else
    begin
        if (ff21[N-1] == ff22[N-1])
            out = {ff21[N-1], ff21[exp:man+1], '0};
            //cseladd #(man+1) u3(ff21[man:0],ff22[man:0],0,out[man:0]);
    end
end

endmodule
