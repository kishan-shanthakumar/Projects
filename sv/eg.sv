module bfloat16_adder(input logic [15:0] a, b,
                    input logic clock, nreset,
                    output logic [15:0] sum,
                    output logic ready);

enum {state1, state2, state3} present_state, next_state;
logic [15:0] inp1, inp2;
logic flag;

always_ff @(posedge clock, negedge nreset)
begin
	if (!nreset)
	begin
		present_state <= state3;
		inp1 <= 0;
		inp2 <= 0;
	end
	else
	begin
		present_state <= next_state;
		if (present_state == state1)
			inp1 <= a;
		else if (present_state == state2)
			inp2 <= b;			
	end
end

always_comb
begin
	ready = 0;
	next_state = present_state;
	case (present_state)
        state1: begin
            next_state = state2;
        end
        state2: begin
			next_state = state3;
        end
        state3: begin
			ready = 1;
			next_state = state1;
        end
    endcase
end

always_comb
begin
    sum = 0;
    if (inp1[14:8] == 8'b11111111 | inp2[14:8] == 8'b11111111) //Special case nan/inf
    begin
        sum[15] = 0;
        sum[14:8] = 8'hff;
        sum[7:0] = 0;
    end
    else if (inp1[14:0] == 15'b0 | inp2[14:0] == 15'b0) //Special case 0
    begin 
        if (inp1[14:0] == 15'b0) //a  is 0
        begin
            sum[15] = inp2[15];
            sum[14:8] = inp2[14:8];
            sum[7:0] = inp2[7:0];
        end
        else // b is 0
        begin
            sum[15] = inp1[15];
            sum[14:8] = inp1[14:8];
            sum[7:0] = inp1[7:0];
        end
    end
    else if ($signed(inp1[14:8] - inp2[14:8]) > 8 | $signed(inp2[14:8] - inp1[14:8]) > 8) //Special case large exp diff
    begin 
        if ($signed(inp1[14:8] - inp2[14:8]) > 8)
            sum = inp1;
        else
            sum = inp2;
    end
    else if (inp1[14:0] == inp2[14:0]) //Special case same num diff sign
    begin 
        if (inp1[15] == inp2[15])
        begin
            sum = inp1;
            sum[14:8] += 1;
        end
        else
        begin
            sum = 0;
        end
    end
    else //Normal cases
        if (inp1[14:8] == inp2[14:8]) //Case same exponents
            if (inp1[15] == inp2[15]) //Same sign
            begin
                sum[15] = inp1[15];
                {flag, sum[7:0]} = inp1[7:0] + inp2[7:0];
                sum[7:0] = sum[7:0] >> flag;
                sum[14:8] = inp1[14:8]+flag;
            end
            else // Different sign
            begin
                sum[15] = (inp1[7:0] > inp2[7:0]) ? inp1[15] : inp2[15];
                {flag, sum[7:0]} = (inp1[7:0] > inp2[7:0]) ? (inp1[7:0] - inp2[7:0]) : (inp2[7:0] - inp1[7:0]);
                sum[7:0] = sum[7:0] << flag;
                sum[14:8] = inp1[14:8]-flag;
            end
        else //Different exponents
        begin
            if ($signed(inp1[14:8]) > $signed(inp2[14:8])) //exp(a) > exp(b)
            begin
                if (inp1[15] == inp2[15]) //same sign
                begin
                    sum[15] = inp1[15];
                    {flag, sum[7:0]} = inp1[7:0] + (inp2[7:0] >> (inp1[15:8] - inp2[15:8]));
                    sum[7:0] = sum[7:0] >> flag;
                    sum[14:8] = inp1[14:8]+flag;
                end
                else // different sign
                begin
                    sum[15] = inp1[15];
                    {flag, sum[7:0]} = inp1[7:0] - (inp2[7:0] >> (inp1[15:8] - inp2[15:8]));
                    sum[7:0] = sum[7:0] << flag;
                    sum[14:8] = inp1[14:8]-flag;
                end
            end
            else if ($signed(inp1[14:8]) < $signed(inp2[14:8])) //exp(b) > exp(a)
            begin
                if (inp1[15] == inp2[15]) //same sign
                begin
                    sum[15] = inp1[15];
                    {flag, sum[7:0]} = inp1[7:0] + (inp2[7:0] >> (inp2[15:8] - inp1[15:8]));
                    sum[7:0] = sum[7:0] >> flag;
                    sum[14:8] = inp2[14:8]+flag;
                end
                else // different sign
                begin
                    sum[15] = inp2[15];
                    {flag, sum[7:0]} = inp2[7:0] - (inp1[7:0] >> (inp2[15:8] - inp1[15:8]));
                    sum[7:0] = sum[7:0] << flag;
                    sum[14:8] = inp2[14:8]-flag;
                end
            end
        end
end

endmodule