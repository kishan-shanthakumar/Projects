module VGA_Controller(clk,outp,hsync,vsync,blank,sync,out_clk,lock);
input clk;
input lock;
output reg [23:0] outp;
output reg hsync = 1;
output reg vsync = 1;
output blank, sync;
output out_clk;

reg clk1;
reg [23:0] dat;
reg lock_state;

assign blank = 1;
assign sync = 1;
assign out_clk = clk;

integer i = 0;
integer j = 0;

always @(posedge lock)
	lock_state <= ~lock_state;

always @(posedge clk)
	if (j%480 == 0)
		dat <= dat + 1;

always @(posedge clk)
	clk1 = ~clk1;
	
always @ (posedge clk1)
begin;
	if((i < 639) & (j < 479))
	begin
		if(lock_state==0)
			outp <= dat;
		else
			outp <= 0;
	end
	else
	begin
		outp <= 0;
		if(i>656 & i<=752)
			hsync <= 0;
		if(j>490 & j<=492)
			vsync <= 0;
		if(i>752)
			hsync <= 1;
		if(j>492)
			vsync <= 1;
	end
	if(i==799)
	begin
		i <= 0;
		j <= j + 1;
	end
	else
		i <= i + 1;
	if(j==524)
		j <= 0;
end

endmodule
