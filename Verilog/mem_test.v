module mem_test(clk,reset,result,fin,addr,step,step1);
input clk;
input reset;
output reg result;
output reg fin;
output reg [7:0] addr = 0;
output reg [2:0] step;
output reg [1:0] step1;

reg [7:0] odata0 = 8'h55;
reg [7:0] odata1 = 8'hAA;
wire [7:0] idata;

reg order = 0;

initial begin
result = 1;
end

//ram_1port ram(addr,clk,odata,wren,idata);

always @(posedge clk)
begin
	if(!reset)
	begin
		addr = 0;
		fin = 0;
		result = 1;
		step = 3'b0;
		step1 = 2'b0;
		order = 0;
		result = 1;
	end
	else
	begin
		/*
		First step
		*/
		if( step == 3'b000 )
		begin
			//Write odata0
			addr = addr + 1;
			if (addr == 3'b0)
				step = step + 1;
		end
		/*
		Second step
		*/
		if( step == 3'b001 )
		begin
			if(step1 == 3'b00)
			begin
				//Read odata0
				if(idata == 8'h55)
				begin
					result = 0;
				end
			end
			if(step1 == 3'b01)
			begin
				//Write odata1
			end
			if(step1 == 3'b10)
			begin
				//Read odata1
				if(idata == 8'hAA)
				begin
					result = 0;
				end
			end
			if(step1 == 3'b11)
			begin
				//Write odata1
				addr  = addr + 1;
				if (addr == 3'b0)
				    step = step + 1;
			end
			step1 = step1 + 1;
		end
		/*
		Third step
		*/
		if( step == 3'b010 )
		begin
			if(step1 == 3'b00)
			begin
				//Read odata1
				if(idata == 8'hAA)
				begin
					result = 0;
				end
			end
			if(step1 == 3'b01)
			begin
				//Write odata0
			end
			if(step1 == 3'b10)
			begin
				//Read odata0
				if(idata == 8'h55)
				begin
					result = 0;
				end
			end
			if(step1 == 3'b11)
			begin
				//Write odata0
				addr  = addr + 1;
				if (addr == 3'b0)
			    begin
				    step = step + 1;
				    addr = 8'd255;
				    order = 1;
			    end
			end
			step1 = step1 + 1;
		end
		/*
		Fourth step
		*/
		if( step == 3'b011 )
		begin
			if(step1 == 3'b00)
			begin
				//Read odata0
				if(idata == 8'h55)
				begin
					result = 0;
				end
			end
			if(step1 == 3'b01)
			begin
				//Write odata1
			end
			if(step1 == 3'b10)
			begin
				//Read odata1
				if(idata == 8'hAA)
				begin
					result = 0;
				end
			end
			if(step1 == 3'b11)
			begin
				//Write odata1
				addr  = addr - 1;
				if (addr == 8'd255)
				    step = step + 1;
			end
			step1 = step1 + 1;
		end
		/*
		Fifth step
		*/
		if( step == 3'b100 )
		begin
			if(step1 == 3'b00)
			begin
				//Read odata1
				if(idata == 8'hAA)
				begin
					result = 0;
				end
			end
			if(step1 == 3'b01)
			begin
				//Write odata0
			end
			if(step1 == 3'b10)
			begin
				//Read odata0
				if(idata == 8'h55)
				begin
					result = 0;
				end
			end
			if(step1 == 3'b11)
			begin
				//Write odata0
				addr = addr - 1;
				if (addr == 8'd255)
				    step = step + 1;
			end
			step1 = step1 + 1;
		end
		if( step == 3'b101 )
		begin
			addr = addr - 1;
			//Read odata0
			if (addr == 8'd255)
				step = step + 1;
		end
		if( step == 3'b110 )
		begin
			fin = 1;
		end
	end
end

endmodule
