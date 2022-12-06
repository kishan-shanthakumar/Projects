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

logic [N-1:0] ff11, ff12;
logic [N-1:0] ffa, ffb;
logic [N-1:0] ff21, ff22;
logic [N-1:0] ff3;
logic [exp_len-1:0] shft_amtab;
logic [exp_len-1:0] shft_amtba;
logic [man+1:0] wi;
logic [man+1:0] outab;
logic [man+1:0] outba;
logic [enc_len-1:0] outcalcab;
logic [enc_len-1:0] outcalcba;
logic flag, flag1;
logic pass;
logic passnan;
logic passinf;
logic pass0;
logic temp;

cseladd #(exp_len) u1(a[exp:man+1],~b[exp:man+1],1,shft_amtab);
cseladd #(exp_len) u2(b[exp:man+1],~a[exp:man+1],1,shft_amtba);
cseladd #(man+1) u4({1,ff21[man:0]},{~flag1,~ff22[man:0]},1,outab);
cseladd #(man+1) u5({1,ff22[man:0]},{~flag1,~ff21[man:0]},1,outba);
enc_n #(enc_len) u6(outcalcab,temp,outab[man:0]);
enc_n #(enc_len) u7(outcalcba,temp,outba[man:0]);
cseladd #(man+1) u3(ff21[man:0],ff22[man:0],0,wi);

always_comb
begin
	  pass = 0;
 	  passnan = 0;
  	  passinf = 0;
	  pass0 = 0;
	  if (a[N-2:0] == 0 | b[N-2:0] == 0)
	  begin
			pass = 1;
			pass0 = 1;
	  end
	  else if (a[exp:man+1] == '1 | b[exp:man+1] == '1)
	  begin
			pass = 1;
			if( (a[exp:man+1] == '1 & a[man:0] == '0) | (b[exp:man+1] == '1 & b[man:0] == '0) )
				passinf = 1;
         else
				passnan = 1;
	  end
      else if ($signed(shft_amtab) > man | $signed(shft_amtba) > man)
      begin
            pass = 1;
      end
end

always_comb
begin
    out = ff3;
    ff11[N-1:man+1] <= {a[N-1], b[exp:man+1]};
    ff11[man:0] <= {1'b1,a[man:0]}>>shft_amtba;
    ff12[N-1:man+1] <= {b[N-1], a[exp:man+1]};
    ff12[man:0] <= {1'b1,b[man:0]}>>shft_amtab;
    ffa <= a;
    ffb <= b;
    
    //Stage 2
    if (ffa[exp:man+1] == ffb[exp:man+1])
    begin
        ff21 = ffa;
        ff22 = ffb;
        flag1 = 1;
    end
    else if ($signed(ffa[exp:man+1]-(2**(exp_len-1)-1)) > $signed(ffb[exp:man+1]-(2**(exp_len-1)-1)))
    begin
        ff21 = ffa;
        ff22 = ff12;
        flag = 1;
        flag1 = 0;
    end
    else
    begin
        ff21 = ff11;
        ff22 = ffb;
        flag = 0;
        flag1 = 0;
    end
    
    //Stage 3
    if (pass == 1)
    begin
        if (passnan)
            ff3 = '1;
        else if (passinf)
        begin
            if (a[exp:man+1] == '1 & b[exp:man+1] == '1 & a[N-1] != b[N-1])
                ff3 = '1;
            else
                ff3 = (a[exp:man+1] == '1)? a : b;
        end
        else if (pass0)
        begin
            if (a[exp:man+1] == 0 & b[exp:man+1] == 0)
                ff3 = (a[N-1] == 0)? '0 : ( (a[N-1] == b[N-1]) ? {1'b1, {(N-1){1'b0}}}: '0 );
            else
                ff3 = (a[exp:man+1] == 0)? b : a;
        end
        else
        begin
            if ($signed(a[exp:man+1]-(2**(exp_len-1)-1)) > $signed(b[exp:man+1]-(2**(exp_len-1)-1)))
                ff3 = a;
            else
                ff3 = b;
        end
    end
    else
        if ( ff21[N-2:0] == ff22[N-2:0] )
        begin
            if (ff21[N-1] == ff22[N-1])
            begin
                ff3[N-1] = ff21[N-1];
                ff3[exp:man+1] = ff21[exp:man+1] + 1'b1;
                ff3[man:0] = ff21[man:0];
            end
            else
                ff3 = '0;
        end
        else
        begin
            if (ff21[N-1] == ff22[N-1])
            begin
                ff3[N-1] = ff21[N-1];
                ff3[exp:man+1] = ff21[exp:man+1] + (flag1 | wi[man+1]);
                ff3[man:0] = wi[man:0]>>(wi[man+1]|flag1);
            end
            else
            begin
                if (flag1)
                    if (ff21[man:0]>ff22[man:0])
                    begin
                        ff3[N-1] <= ff21[N-1];
                        ff3[N-2:man+1] <= ff21[N-2:man+1] - (N-outcalcab-(N-man-1));
                        ff3[man:0] <= outab[man:0]<<(N-outcalcab-(N-man-1));
                    end
                    else
                    begin
                        ff3[N-1] <= ff22[N-1];
                        ff3[N-2:man+1] <= ff22[N-2:man+1] - (N-outcalcba-(N-man-1));
                        ff3[man:0] <= outba[man:0]<<(N-outcalcba-(N-man-1));
                    end
                else
                    if (flag)
                    begin
                        ff3[N-1] <= ff21[N-1];
                        ff3[N-2:man+1] <= ff21[N-2:man+1] - (N-outcalcab-(N-man-1));
                        ff3[man:0] <= outab[man:0]<<(N-outcalcab-(N-man-1));
                    end
                    else
                    begin
                        ff3[N-1] <= ff22[N-1];
                        ff3[N-2:man+1] <= ff22[N-2:man+1] - (N-outcalcba-(N-man-1));
                        ff3[man:0] <= outba[man:0]<<(N-outcalcba-(N-man-1));
                    end
            end
        end
end

endmodule
