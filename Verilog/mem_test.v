module mem_test(clk,reset,result,fin);
input clk;
input reset;
output reg result;
output reg fin;

reg [7:0] addr;
reg [7:0] odata;
reg wren;
wire [7:0] idata;

reg [2:0] step;
reg [1:0] step1;

reg order;

initial begin
result = 1;
wren = 1;
odata = 8'h55;
end

ram_1port ram(addr,clk,odata,wren,idata);

always @(negedge clk)
begin
	if(!reset)
	begin
		addr = 0;
		odata = 8'h55;
		wren = 1;
		fin = 0;
		result = 1;
		step = 3'b0;
		step1 = 2'b0;
		order = 0;
		result = 1;
	end
	else
	begin
		if( (addr == 8'b11111111 & order == 0) | (addr == 8'b0 & order == 1) )
		begin
			step = step + 1;
		end
		if( step == 000 )
		begin
			addr = addr + 1;
		end
		if( step == 001 )
		begin
			if(step1 == 00)
			begin
				wren = 0;
				odata = 8'hAA;
			end
			if(step1 == 01)
			begin
				if(idata == 8'h55)
				begin
					result = 0;
				end
				wren = 1;
				odata = 8'hAA;
			end
			if(step1 == 10)
			begin
				wren = 0;
			end
			if(step1 == 11)
			begin
				if(idata == 8'hAA)
				begin
					result = 0;
				end
				wren = 1;
				addr  = addr + 1;
			end
			step1 = step1 + 1;
		end
		if( step == 010 )
		begin
			if(step1 == 00)
			begin
				wren = 0;
				odata = 8'h55;
			end
			if(step1 == 01)
			begin
				if(idata == 8'hAA)
				begin
					result = 0;
				end
				wren = 1;
				odata = 8'h55;
			end
			if(step1 == 10)
			begin
				wren = 0;
			end
			if(step1 == 11)
			begin
				if(idata == 8'h55)
				begin
					result = 0;
				end
				wren = 1;
				addr  = addr + 1;
				if( addr == 8'b11111111 )
				begin
					order = !order;
				end
			end
			step1 = step1 + 1;
		end
		if( step == 011 )
		begin
			if(step1 == 00)
			begin
				wren = 0;
				odata = 8'hAA;
			end
			if(step1 == 01)
			begin
				if(idata == 8'h55)
				begin
					result = 0;
				end
				wren = 1;
				odata = 8'hAA;
			end
			if(step1 == 10)
			begin
				wren = 0;
			end
			if(step1 == 11)
			begin
				if(idata == 8'hAA)
				begin
					result = 0;
				end
				wren = 1;
				addr  = addr - 1;
			end
			step1 = step1 + 1;
		end
		if( step == 100 )
		begin
			if(step1 == 00)
			begin
				wren = 0;
				odata = 8'h55;
			end
			if(step1 == 01)
			begin
				if(idata == 8'hAA)
				begin
					result = 0;
				end
				wren = 1;
				odata = 8'h55;
			end
			if(step1 == 10)
			begin
				wren = 0;
			end
			if(step1 == 11)
			begin
				if(idata == 8'h55)
				begin
					result = 0;
				end
				wren = 1;
				addr = addr - 1;
			end
			step1 = step1 + 1;
		end
		if( step == 101 )
		begin
			addr = addr - 1;
		end
		if( step == 110 )
		begin
			fin = 1;
		end
	end
end

endmodule