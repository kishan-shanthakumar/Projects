module ep_top (input logic ready, clk, rst,
				input logic [7:0] datin,
				output logic [7:0] datout,
				output logic clock, waiting,
				output logic [20:0] addr_led);

logic [4:0] addr;
logic [13:0] inp;

/*prog_mem u1(
 .address(addr),
	.clock(clock),
	.q(inp));*/
prog_mem u1(.*);
processor u2(.*);
slow_clk u3(.*);
an u4( (  addr%10)     , addr_led[6:0]   );
an u5( (( addr/10)%10) , addr_led[13:7]  );
an u6( (  addr/100)    , addr_led[20:14] );

endmodule

module processor (input logic [13:0] inp,
				input logic ready, clock, rst,
				output logic [4:0] addr,
				input logic [7:0] datin,
				output logic [7:0] datout,
				output logic waiting);

logic [7:0] regfile [0:7];
logic [7:0] y1;
logic await, wait_read, wait_write;
logic [15:0] inp_past;
logic [15:0] mul_res;

assign waiting = await | wait_read | wait_write;

alu u1(regfile[inp[8:6]], regfile[inp[5:3]], inp[1:0], mul_res, y1);

always_ff @(posedge clock, negedge rst)
begin
	if (!rst)
	begin
		regfile[7] <= 0;regfile[6] <= 0;regfile[5] <= 0;regfile[4] <= 0;regfile[3] <= 0;regfile[2] <= 0;regfile[1] <= 0;regfile[0] <= 0;
		datout <= 0;
		addr <= 0;
		await <= 0;
		wait_read <= 0;
		wait_write <= 0;
		inp_past <= 0;
	end
	else if (await == 1)
		await <= 0;
	else if (wait_write == 1)
	begin
		if(ready)
			wait_write <= 0;
	end
	else if (wait_read == 1)
	begin
		if(ready)
		begin
			wait_read <= 0;
			regfile[inp_past[11:9]] <= datin;
		end
	end
	else
	begin
		if(ready == 0)
		begin
			inp_past <= inp;
			addr <= addr + 1;
			case(inp[2:0])
			3'b000: begin // Load mem to reg
				wait_read <= 1;
			end
			3'b001: begin // Load imm to reg
				regfile[inp[11:9]] <= {inp[13:12],inp[8:3]};
			end
			3'b010: begin //Store reg to mem
				datout <= regfile[inp[11:9]];
				wait_write <= 1;
			end
			3'b011: begin //Eq branch
				await <= 1;
				if (regfile[inp[5:3]] == 0)
					addr <= inp[13:4];
			end
			3'b100: begin //Sub
				regfile[inp[11:9]] <= y1;
			end
			3'b101: begin //Aff
				regfile[inp[11:9]] <= mul_res >> 7;
			end
			3'b111: begin //Add
				regfile[inp[11:9]] <= y1;
			end
			endcase
		end
	end
end

endmodule

module alu(input logic [7:0] inp1,inp2,
			input logic [1:0] s,
			output logic [15:0] mul_res,
			output logic [7:0] y1);

always_comb
begin
	mul_res = ($signed(inp1) * $signed(inp2));
	y1 = 0;
	case(s)
	2'b11: y1 = inp1 + inp2;
	2'b00: y1 = inp1 - inp2;
	endcase
end

endmodule