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

module fadd #(parameter N = 32)
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
logic [exp_len-1:0] shft_amtab;
logic [exp_len-1:0] shft_amtba;
logic [man+1:0] wi;
logic [man+1:0] outab;
logic [man+1:0] outba;
logic [enc_len-1:0] outcalcab;
logic [enc_len-1:0] outcalcba;
logic flag, flag1;
logic temp;

cseladd #(exp_len) u1(a[exp:man+1],~b[exp:man+1],1,shft_amtab);
cseladd #(exp_len) u2(b[exp:man+1],~a[exp:man+1],1,shft_amtba);
cseladd #(man+1) u4({1,ff21[man:0]},{flag1,~ff22[man:0]},1,outab);
cseladd #(man+1) u5({1,ff22[man:0]},{flag1,~ff21[man:0]},1,outba);
enc_n #(enc_len) u6(outcalcab,temp,outab[man:0]);
enc_n #(enc_len) u7(outcalcba,temp,outba[man:0]);
cseladd #(man+1) u3(ff21[man:0],ff22[man:0],0,wi);

always_ff @(posedge clk, negedge rst)
begin
    out = ff3;
    if (!rst)
    begin
        ff11 <= 0;
        ff12 <= 0;
        ff21 <= 0;
        ff22 <= 0;
        ff3 <= 0;
        ffa <= 0;
        ffb <= 0;
        flag = 0;
    end
    else
    begin
        // Stage 1
        //cseladd #(exp_len) u1(a[exp:man+1],b1[exp:man+1],1,shft_amtab);
        //cseladd #(exp_len) u2(b[exp:man+1],a1[exp:man+1],1,shft_amtba);
        ff11[man:0] <= {1,a[man:0]}>>shft_amtba;
        ff12[man:0] <= {1,b[man:0]}>>shft_amtab;
        ff11[N-1:man+1] <= {a[N-1], b[exp:man+1]};
        ff12[N-1:man+1] <= {b[N-1], a[exp:man+1]};
        ffa <= a;
        ffb <= b;
        
        //Stage 2
        if (ffa[exp:man+1] == ffb[exp:man+1])
        begin
            ff21 <= ffa;
            ff22 <= ffb;
            flag1 = 1;
        end
        else if ($signed(ffa[exp:man+1]-(2**(exp_len-1)-1)) > $signed(ffb[exp:man+1]-(2**(exp_len-1)-1)))
        begin
            ff21 <= ffa;
            ff22 <= ff12;
            flag = 1;
            flag1 = 0;
        end
        else
        begin
            ff21 <= ff11;
            ff22 <= ffb;
            flag = 0;
            flag1 = 0;
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
                ff3 <= {ff21[N-1],ff21[exp:man+1] + flag1|wi[man+1], wi[man:0]>>1};
                //cseladd #(man+1) u3(ff21[man:0],ff22[man:0],0,out[man:0]);
            end
            else
            begin
                if (flag1)
                    if (ff21[man:0]>ff22[man:0])
                        ff3 <= {ff21[N-1],ff21[N-2:man+1] - (2**enc_len-outcalcab-9), outab[man:0]<<(2**enc_len-outcalcab-9)};
                    else
                        ff3 <= {ff22[N-1],ff21[N-2:man+1] - (2**enc_len-outcalcba-9), outba[man:0]<<(2**enc_len-outcalcba-9)};
                else
                    if (flag)
                        ff3 <= {ff21[N-1],ff21[N-2:man+1]-1, outab[man:0]};
                    else
                        ff3 <= {ff22[N-1],ff21[N-2:man+1]-1, outba[man:0]};
            end
        end
    end
end

endmodule
