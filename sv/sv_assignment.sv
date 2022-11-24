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
					input logic [2**N-1:0] inp);

always_comb
begin
	out = 0;
	for (int i = 2**N-1; i >= 0; i--)
		if (inp[i] == 1)
		begin
			out = i;
			break;
		end
end

endmodule

module fadd #(parameter N = 16)
            (input logic [N-1:0] a, b,
            input logic clock, nreset,
            output logic [N-1:0] sum,
            output logic ready);


parameter exp = 14;
parameter man = 6;
parameter exp_len = 8;
parameter enc_len = 3;

logic [2:0] ready_st;

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
logic pass;
logic passnan;
logic passinf;
logic pass0;

cseladd #(exp_len) u1(a[exp:man+1],~b[exp:man+1],1,shft_amtab);
cseladd #(exp_len) u2(b[exp:man+1],~a[exp:man+1],1,shft_amtba);
cseladd #(man+1) u4({1'b1,ff21[man:0]},{flag1,~ff22[man:0]},1,outab);
cseladd #(man+1) u5({1'b1,ff22[man:0]},{flag1,~ff21[man:0]},1,outba);
enc_n #(enc_len) u6(outcalcab,outab[man:0]);
enc_n #(enc_len) u7(outcalcba,outba[man:0]);
cseladd #(man+1) u3(ff21[man:0],ff22[man:0],0,wi);

assign ready = ready_st[2];

always_ff @(posedge clock, negedge nreset)
begin
	ready_st[0] <= 0;
    if (!nreset)
    begin
        ff11 <= 0;
        ff12 <= 0;
        ffa <= 0;
        ffb <= 0;
    end
    else if (ready)
    begin
		// Stage 1
		if (pass == 1)
        begin
			ready_st[2] <= 1;
			if (passnan)
				ff3 <= '1;
			else if (passinf)
			begin
				if (a[exp:man+1] == '1 & b[exp:man+1] == '1)
					ff3 <= '1;
				else
					ff3 <= (a[exp:man+1] == '1)? a : b;
			end
			else if (pass0)
			begin
				if (a[exp:man+1] == 0 & b[exp:man+1] == 0)
					ff3 <= (a[N-1] == 0)? '0 : ( (a[N-1] == b[N-1]) ? {1'b1, {(N-1){1'b0}}}: '0 );
				else
					ff3 <= (a[exp:man+1] == 0)? b : a;
			end
		end
		else
		begin
			ff11[N-1:man+1] <= {a[N-1], b[exp:man+1]};
			ff11[man:0] <= {1'b1,a[man:0]}>>shft_amtba;
			ff12[N-1:man+1] <= {b[N-1], a[exp:man+1]};
			ff12[man:0] <= {1'b1,b[man:0]}>>shft_amtab;
			ffa <= a;
			ffb <= b;
			ready_st[0] <= 1;
		end
    end
end

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
			if( a[man:0] == '0 & b[man:0] == '0)
			begin
				passinf = 1;
			end
				passnan = 1;
	  end
	  else
	  begin
	  flag = 0;
	  flag1 = 0;
	  if (ffa[exp:man+1] == ffb[exp:man+1])
	  begin
			flag1 = 1;
	  end
	  else if ($signed(ffa[exp:man+1]-(2**(exp_len-1)-1)) > $signed(ffb[exp:man+1]-(2**(exp_len-1)-1)))
	  begin
			flag = 1;
			flag1 = 0;
	  end
	  else
	  begin
			flag = 0;
			flag1 = 0;
	  end
	  if (ready_st[2])
		assign sum = ff3;
	  end
end

always_ff @(posedge clock, negedge nreset)
begin
    if (!nreset)
    begin
        ff21 <= 0;
        ff22 <= 0;
        ff3 <= 0;
        ready_st[2] <= '1;
		ready_st[1] <= '0;
    end
    else if ( pass == 0)
    begin
        //Stage 2
        ready_st[1] <= ready_st[0];
        if (ffa[exp:man+1] == ffb[exp:man+1])
        begin
            ff21 <= ffa;
            ff22 <= ffb;
        end
        else if ($signed(ffa[exp:man+1]-(2**(exp_len-1)-1)) > $signed(ffb[exp:man+1]-(2**(exp_len-1)-1)))
        begin
            ff21 <= ffa;
            ff22 <= ff12;
        end
        else
        begin
            ff21 <= ff11;
            ff22 <= ffb;
        end
        
        //Stage 3
        ready_st[2] <= ready_st[1];
        if ( ff21[N-2:0] == ff22[N-2:0] )
        begin
            if (ff21[N-1] == ff22[N-1])
			begin
                ff3[N-1] <= ff21[N-1];
				ff3[exp:man+1] <= ff21[exp:man+1] + 1;
				ff3[man:0] <= ff21[man:0];
            end
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
					begin
                        ff3[N-1] <= ff21[N-1];
						ff3[N-2:man+1] <= ff21[N-2:man+1] - (2**enc_len-outcalcab-1);
						ff3[man:0] <= outab[man:0]<<(2**enc_len-outcalcab-1);
                    end
					else
					begin
                        ff3[N-1] <= ff22[N-1];
						ff3[N-2:man+1] <= ff21[N-2:man+1] - (2**enc_len-outcalcba-1);
						ff3[man:0] <= outba[man:0]<<(2**enc_len-outcalcba-1);
					end
				else
					if (flag)
					begin
						ff3[N-1] <= ff21[N-1];
						ff3[N-2:man+1] <= ff21[N-2:man+1]-1;
						ff3[man:0] <= outab[man:0];
					end
					else
					begin
						ff3[N-1] <= ff22[N-1];
						ff3[N-2:man+1] <= ff21[N-2:man+1]-1;
						ff3[man:0] <= outba[man:0];
					end
            end
        end
    end
end

endmodule
