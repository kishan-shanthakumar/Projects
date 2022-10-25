//example of state machine processor

module bit8core(addr,data,clk,rw,rst);
output reg [7:0] addr;
inout reg [7:0] data;
input clk, rst;
output reg rw;

reg [7:0] dat;

reg [7:0] A1;
reg [7:0] B1;
reg [7:0] C1;
reg [7:0] D1;
reg [7:0] E1;
reg [7:0] F1;
reg [7:0] G1;
reg [7:0] H1;
reg [7:0] A2;
reg [7:0] B2;
reg [7:0] C2;
reg [7:0] D2;
reg [7:0] E2;
reg [7:0] F2;
reg [7:0] G2;
reg [7:0] H2;

reg [7:0] aluinp1;
reg [7:0] aluinp2;

reg [7:0] acc;
reg [7:0] acch;

reg [7:0] flag;

reg [7:0] active;

reg addr_req;
reg dir;
reg [7:0] temp_addr;
reg temp_addr_status;

always @ (posedge clk, negedge rst)
begin
	if(!rst)
	begin
		dat = 0;
		A1 = 0;
		B1 = 0;
		C1 = 0;
		D1 = 0;
		E1 = 0;
		F1 = 0;
		G1 = 0;
		H1 = 0;
		A2 = 0;
		B2 = 0;
		C2 = 0;
		D2 = 0;
		E2 = 0;
		F2 = 0;
		G2 = 0;
		H2 = 0;
		aluinp1 = 0;
		aluinp2 = 0;
		acc = 0;
		acch = 0;
		flag = 0;
		active = 0;
		addr_req = 0;
		dir = 0;
		temp_addr = 0;
		temp_addr_status = 0;
	end
	else
	begin
		if(temp_addr_status)
		begin
			if(dir)
			begin
				rw = 1;
				data = active;
			end
			else
			begin
				rw = 0;
				active = data;
			end
			case(dat[3:0])
				4'b0000: A1 = active;
				4'b0001: B1 = active;
				4'b0010: C1 = active;
				4'b0011: D1 = active;
				4'b0100: E1 = active;
				4'b0101: F1 = active;
				4'b0110: G1 = active;
				4'b0111: H1 = active;
				4'b1000: A2 = active;
				4'b1001: B2 = active;
				4'b1010: C2 = active;
				4'b1011: D2 = active;
				4'b1100: E2 = active;
				4'b1101: F2 = active;
				4'b1110: G2 = active;
				4'b1111: H2 = active;
			endcase
			addr = temp_addr + 1;
			temp_addr = 0;
			temp_addr_status = 0;
		end
		else
		begin
			if(addr_req)
			begin
				temp_addr = addr;
				addr = data;
				temp_addr_status = 1;
				addr_req = 0;
			end
			else
			begin
				dat = data;
				if(dat[7])//move
				begin
					case(dat[3:0])
						4'b0000: active = A1;
						4'b0001: active = B1;
						4'b0010: active = C1;
						4'b0011: active = D1;
						4'b0100: active = E1;
						4'b0101: active = F1;
						4'b0110: active = G1;
						4'b0111: active = H1;
						4'b1000: active = A2;
						4'b1001: active = B2;
						4'b1010: active = C2;
						4'b1011: active = D2;
						4'b1100: active = E2;
						4'b1101: active = F2;
						4'b1110: active = G2;
						4'b1111: active = H2;
					endcase
					if(dat[6]) //reg-alu
					begin
						if(dat[5]) //reg-alu_inp
						begin
							if(dat[4])  //reg-alu_inp1
							begin
								aluinp1 = active;
							end
							else  //reg-alu_inp2
							begin
								aluinp2 = active;
							end
						end
						else //acc-reg
						begin 
							if(dat[4])  //acc-reg
							begin
								active = acc;
							end
							else  //acch-reg
							begin
								active = acch;
							end
						end
					end
					else  //reg-mem_addr
					begin
						addr_req = 1;
						if(dat[5]) //output
						begin
							dir = 1;
						end
						else //input
						begin
							dir = 0;
						end
					end
				end
				else
				begin
					if(dat[6]) //alu_enable
					begin
						if(dat[5]) //shifter
						begin
							if(dat[4])
								acc = aluinp1 << aluinp2;
							else
								acc = aluinp1 >> aluinp2;
						end
						else  // other alu operations
						begin
							case(dat[3:0])
								4'b0000: acc = 0;
								4'b0001: acc = 7'b1;
								4'b0010: acc = aluinp1 && aluinp2;
								4'b0011: acc = aluinp1 || aluinp2;
								4'b0100: acc = ~aluinp1;
								4'b0101: acc = ~aluinp2;
								4'b0110: {flag[5],acc} = aluinp1 + aluinp2;
								4'b0111: {flag[4],acc} = aluinp1 - aluinp2;
								4'b1000: {acch,acc} = aluinp1 * aluinp2;
								4'b1001: {acch,acc} = {aluinp1 % aluinp2 , aluinp1 / aluinp2};
								4'b1010: {flag[3],acc} = aluinp1 + 1;
								4'b1011: {flag[3],acc} = aluinp2 + 1;
								4'b1100: {flag[3],acc} = aluinp1 - 1;
								4'b1101: {flag[3],acc} = aluinp2 - 1;
								4'b1110: {flag[2],flag[1],flag[0]} = {(aluinp1 > aluinp2) , (aluinp1 == aluinp2) , (aluinp1 < aluinp2)};
								4'b1111: active = flag;
							endcase
							flag[6] = &acc;
							flag[7] = ~&acc;
						end
					end
					else
					begin
						addr = data - 1;
					end
				end
				case(dat[3:0])
					4'b0000: A1 = active;
					4'b0001: B1 = active;
					4'b0010: C1 = active;
					4'b0011: D1 = active;
					4'b0100: E1 = active;
					4'b0101: F1 = active;
					4'b0110: G1 = active;
					4'b0111: H1 = active;
					4'b1000: A2 = active;
					4'b1001: B2 = active;
					4'b1010: C2 = active;
					4'b1011: D2 = active;
					4'b1100: E2 = active;
					4'b1101: F2 = active;
					4'b1110: G2 = active;
					4'b1111: H2 = active;
				endcase
				addr = addr + 1;
			end
		end
	end
end

endmodule
