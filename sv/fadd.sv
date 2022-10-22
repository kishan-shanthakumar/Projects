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

/*
Stage 1: calculating shifted value
Stage 2: Using shifted valued if necessary
Stage 3: Calulating final value
*/

module fadd #(parameter N = 32)
            (input logic [N-1:0] a, b,
            input logic clk, rst,
            output logic [N-1:0] out);

`ifdef N == 64
    parameter exp = 62;
    parameter man = 51;
`else
    parameter exp = 30;
    parameter man = 22;
`endif

reg [N-1:0] ff11, ff12;
reg [N-1:0] ff21, ff22;
reg [N-1:0] ff3;
logic [N-1:0] shft_amtab;
logic [N-1:0] shft_amtba;
logic [N-1:0] a1;
logic [N-1:0] b1;
logic [N:0] wi;
logic [man:0] outab;
logic [man:0] outba;

cseladd #(exp-man) u1(a[exp:man+1],b1[exp:man+1],1,shft_amtab);
cseladd #(exp-man) u2(b[exp:man+1],a1[exp:man+1],1,shft_amtba);
cseladd #(exp-man) u4(a[man:0],b1[man:0],1,outab);
cseladd #(exp-man) u5(b[man:0],a1[man:0],1,outba);
cseladd #(man+1) u3(ff21[man:0],ff22[man:0],0,wi);

always_ff @(posedge clk, negedge rst)
begin
    if (!rst)
    begin
        ff11 <= 0;
        ff12 <= 0;
        ff21 <= 0;
        ff21 <= 0;
    end
    else
    begin
        // Stage 1
        for(int i = 0;i < N; i++)
        begin
            a1[i] = !a[i];
            b1[i] = !b[i];
        end
        //cseladd #(exp-man) u1(a[exp:man+1],b1[exp:man+1],1,shft_amtab);
        //cseladd #(exp-man) u2(b[exp:man+1],a1[exp:man+1],1,shft_amtba);
        ff11 <= {a[N-1], b[exp:man+1], a[man:0]>>shft_amtba};
        ff12 <= {b[N-1], a[exp:man+1], b[man:0]>>shft_amtab};
        
        //Stage 2
        if (a[N-2:0] == b[N-2:0] | a == 0 | b == 0 | a[exp:man+1] == b[exp:man+1])
        begin
            ff21 <= a;
            ff22 <= b;
        end
        else if (a[exp:man+1]-127 > b[exp:man+1]-127)
        begin
            ff21 <= a;
            ff22 <= ff12;
        end
        else
        begin
            ff21 <= ff11;
            ff22 <= b;
        end
        
        //Stage 3
        if ( ff21[N-2:0] == ff22[N-2:0] )
        begin
            if (ff21[N-1] == ff22[N-1])
                ff3 <= {ff21[N-1],(ff21[exp:man+1] + 1),ff21[man:0]};
            else
                ff3 <= '0;
        end
        else
        begin
            if (ff21[N-1] == ff22[N-1])
            begin
                ff3 <= {ff21[N-1],ff21[exp:man+1] + 1, wi[man:0]>>1};
                //cseladd #(man+1) u3(ff21[man:0],ff22[man:0],0,out[man:0]);
            end
            else
            begin
                if (ff21 == a)
                    ff3 <= {ff21[N-1:man+1], outab};
                else
                    ff3 <= {ff22[N-1:man+1], outba};
            end
        end
        out = ff3;
    end
end

endmodule
