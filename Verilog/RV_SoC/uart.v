// Change counter * baud to be equal as input clock rate

module uart(clk,en,rst,tx,rx,uart_buf,int);
input clk,rst,rx,en;
input[31:0] uart_buf;
output reg tx = 1;
output reg int = 1;

parameter baud = 9600;

reg [31:0] uart_data;

reg set = 0;
reg bit;

integer i;
integer counter;

always @(posedge clk)
begin
	if (rx)
	begin
		if (!rst)
			uart_data = 0;
		else if (en)
		begin
			uart_data = uart_buf;
			set = 1;
			i = 0;
		end
		else if (set)
		begin
			if (i == 32 and int = 0)
				int = 1;
			if (i == 32 and int = 1)
			begin
				set = 0;
				i = 0;
				tx = 1;
			end
			counter = counter + 1;
			if (counter * baud == 10000000)
			begin
				i = i + 1;
				counter = 0;
			end
			bit = uart_data[i];
			tx = bit;
		end
	end
end

endmodule
