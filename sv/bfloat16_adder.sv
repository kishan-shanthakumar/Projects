/*
32 -> 1, 8, 23
64 -> 1, 11, 52
*/

/*
Steps in addition:
=== Check for special cases and equality ===
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

function [22:0] trunc_24_to_23(input [23:0] val32);
  trunc_24_to_23 = val32[22:0];
endfunction

function [4:0] trunc_32_to_5(input [31:0] val32);
  trunc_32_to_5 = val32[4:0];
endfunction

module enc_n (output logic [4:0] out,
                input logic [22:0] inp);

always_comb
begin
	out = 5'b0;
	for (int i = 22; i >= 0; i--)
		if (inp[i] == 1)
		begin
			out = trunc_32_to_5(i);
			break;
		end
end

endmodule

module cseladd #(parameter N = 32)
		(input logic [N-1:0] a,b,
        input cin,
		output logic [N:0] out);

logic [N-1:0] carry1;
logic [N-1:0] sum1;
logic [N-1:0] carry0;
logic [N-1:0] sum0;
logic [N:1] carry;

always_comb
begin
    
    for(int i = 0; i < N ; i++)
    begin
        sum0[i] = a[i] ^ b[i];
        carry0[i] = a[i] & b[i];
        sum1[i] = a[i] ^ b[i] ^ 1'b1;
        carry1[i] = (a[i] & b[i]) + (a[i] ^ b[i]);
    end

    for(int i = 0; i < N ; i++)
    begin
        if ( i == 0)
        begin
            out[i] = cin ? sum1[i] : sum0[i];
            carry[i+1] = cin ? carry1[i] : carry0[i];
        end
        else
        begin
            out[i] = carry[i] ? sum1[i] : sum0[i];
            carry[i+1] = carry[i] ? carry1[i] : carry0[i];
        end
    end
    out[N] = carry[N];
end

endmodule

module bfloat16_adder(input logic [15:0] a, b,
                    input logic clock, nreset,
                    output logic [15:0] sum,
                    output logic ready);

enum {input1, input2, running} state, next_state;

logic [31:0] inp1, inp2, sum32;
logic start;

always_ff @(posedge clock, negedge nreset)
begin
    if (!nreset)
    begin
        state <= running;
        inp1 <= 0;
        inp2 <= 0;
        start <= 0;
    end
    else
    begin
        state <= next_state;
        if (state == input1)
            inp1 <= {a,16'b0};
        else if(state == input2)
        begin
            inp2 <= {b,16'b0};
            start <= 1;
        end
        else if (state == running)
            start <= 0;
    end
end

always_comb
begin
    next_state = state;
    case (state)
        input1: begin
            next_state = input2;
        end
        input2: begin
            next_state = running;
        end
        running: begin
            if (ready)
            begin
                next_state = input1;
            end
        end
    endcase
end

assign sum = sum32[31:16];

fadd u1(inp1, inp2, clock , nreset, start, sum32, ready);

endmodule

module fadd #(parameter N = 32)
            (input logic [N-1:0] a, b,
            input logic clock, nreset, start,
            output logic [N-1:0] sum,
            output logic ready);

parameter exp = 30;
parameter man = 22;
parameter exp_len = 8;
parameter enc_len = 5;

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
wire temp;

cseladd #(exp_len) u1(a[exp:man+1],~b[exp:man+1],1'b1,{temp,shft_amtab});
cseladd #(exp_len) u2(b[exp:man+1],~a[exp:man+1],1'b1,{temp,shft_amtba});
cseladd #(man+2) u4({1'b1,ff21[man:0]},{flag1,~ff22[man:0]},1'b1,{temp,outab});
cseladd #(man+2) u5({1'b1,ff22[man:0]},{flag1,~ff21[man:0]},1'b1,{temp,outba});
enc_n u6(outcalcab,outab[man:0]);
enc_n u7(outcalcba,outba[man:0]);
cseladd #(man+1) u3(ff21[man:0],ff22[man:0],1'b0,wi);

assign ready = ready_st[2];
assign sum = ff3;

always_ff @(posedge clock, negedge nreset)
begin
    if (!nreset)
    begin
        ff11 <= 0;
        ff12 <= 0;
        ffa <= 0;
        ffb <= 0;
        ready_st[0] <= 0;
    end
    else if (start)
    begin
		ready_st[0] <= 1;
		// Stage 1
		if (pass == 0)
		begin
			ff11[N-1:man+1] <= {a[N-1], b[exp:man+1]};
			ff11[man:0] <= trunc_24_to_23({1'b1,a[man:0]}>>shft_amtba);
			ff12[N-1:man+1] <= {b[N-1], a[exp:man+1]};
			ff12[man:0] <= trunc_24_to_23({1'b1,b[man:0]}>>shft_amtab);
			ffa <= a;
			ffb <= b;
		end
    end
    else
        ready_st[0] <= 0;
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
			if( (a[exp:man+1] == '1 & a[man:0] == '0) | (b[exp:man+1] == '1 & b[man:0] == '0) )
				passinf = 1;
         else
				passnan = 1;
	  end
      else if ($signed(shft_amtab) > 7 | $signed(shft_amtba) > 7)
      begin
            pass = 1;
      end
end

always_ff @(posedge clock, negedge nreset)
begin
    if (!nreset)
    begin
        ff21 <= 0;
        ff22 <= 0;
        ff3 <= 0;
        flag1 <= 0;
	    flag <= 0;
        ready_st[2] <= '0;
		ready_st[1] <= '1;
    end
    else if (pass == 1)
    begin
        ready_st[1] <= ready_st[0];
        ready_st[2] <= ready_st[1];
        if (passnan)
            ff3 <= '1;
        else if (passinf)
        begin
            if (a[exp:man+1] == '1 & b[exp:man+1] == '1 & a[N-1] != b[N-1])
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
        else
        begin
            if ($signed(a[exp:man+1]-(2**(exp_len-1)-1)) > $signed(b[exp:man+1]-(2**(exp_len-1)-1)))
                ff3 <= a;
            else
                ff3 <= b;
        end
    end
    else
    begin
        ready_st[1] <= ready_st[0];
        ready_st[2] <= ready_st[1];
        //Stage 2
        if (ffa[exp:man+1] == ffb[exp:man+1])
        begin
            ff21 <= ffa;
            ff22 <= ffb;
            flag1 <= 1;
			flag <= 0;
        end
        else if ($signed(ffa[exp:man+1]-(2**(exp_len-1)-1)) > $signed(ffb[exp:man+1]-(2**(exp_len-1)-1)))
        begin
            ff21 <= ffa;
            ff22 <= ff12;
            flag <= 1;
			flag1 <= 0;
        end
        else
        begin
            ff21 <= ff11;
            ff22 <= ffb;
            flag <= 0;
			flag1 <= 0;
        end
        
        //Stage 3
        if ( ff21[N-2:0] == ff22[N-2:0] )
        begin
            if (ff21[N-1] == ff22[N-1])
            begin
                ff3[N-1] <= ff21[N-1];
                ff3[exp:man+1] <= ff21[exp:man+1] + 1'b1;
                ff3[man:0] <= ff21[man:0];
            end
            else
                ff3 <= '0;
        end
        else
        begin
            if (ff21[N-1] == ff22[N-1])
            begin
                ff3[N-1] <= ff21[N-1];
                ff3[exp:man+1] <= ff21[exp:man+1] + {7'b0,flag1} | {7'b0,wi[man+1]};
                ff3[man:0] <= wi[man:0]>>(wi[man+1]|flag1);
                //cseladd #(man+1) u3(ff21[man:0],ff22[man:0],0,out[man:0]);
            end
            else
            begin
                if (flag1)
                    if (ff21[man:0]>ff22[man:0])
                    begin
                        ff3[N-1] <= ff21[N-1];
                        ff3[N-2:man+1] <= ff21[N-2:man+1] - {3'b0,outcalcab};
                        ff3[man:0] <= outab[man:0]<<outcalcab;
                    end
                    else
                    begin
                        ff3[N-1] <= ff22[N-1];
                        ff3[N-2:man+1] <= ff21[N-2:man+1] - {3'b0,outcalcba};
                        ff3[man:0] <= outba[man:0]<<outcalcba;
                    end
                else
                    if (flag)
                    begin
                        ff3[N-1] <= ff21[N-1];
                        ff3[N-2:man+1] <= ff21[N-2:man+1]-{7'b0,outab[man+1]};
                        ff3[man:0] <= outab[man:0];
                    end
                    else
                    begin
                        ff3[N-1] <= ff22[N-1];
                        ff3[N-2:man+1] <= ff21[N-2:man+1]-{7'b0,outba[man+1]};
                        ff3[man:0] <= outba[man:0];
                    end
            end
        end
    end
end

endmodule
