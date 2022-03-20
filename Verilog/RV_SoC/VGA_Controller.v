module VGA_Controller(clk,inp_addr,inp,outp,hsync,vsync);
input clk;
input [31:0] inp;
output reg [12:0] inp_addr = 0;
output reg [23:0] outp;
output reg hsync = 1;
output reg vsync = 1;

integer i = 0;
integer j = 0;

always @ (posedge clk)
begin
	if((i < 640) & (j < 480))
	begin
		outp = inp;
		inp_addr = inp_addr + 1;
	end
	else
	begin
		outp = 0;
		if(i>=656 & i<752)
			hsync = 0;
		if(j>=490 & j<492)
			vsync = 0;
		if(i>=752)
			hsync = 1;
		if(j>=492)
			vsync = 1;
	end
	if(i==800)
	begin
		i = 0;
		j = j + 1;
	end
	else
		i = i + 1;
	if(j==525)
		j = 0;
end

endmodule
