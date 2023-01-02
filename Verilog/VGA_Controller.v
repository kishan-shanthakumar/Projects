module VGA_Controller(clk,outp,hsync,vsync,blank,sync,out_clk,lock,rw,);
input clk,lock;
output reg [23:0] outp;
output reg hsync = 1;
output reg vsync = 1;
output blank, sync;
output out_clk;
output reg rw;

reg clk1;
wire [23:0] dat;

assign blank = 1;
assign sync = 1;
assign out_clk = clk1;

integer i = 0;
integer j = 0;
reg [18:0] addr = 0;
reg lock_state;

mem_hard_long	mem_hard_long_inst (
	.address ( addr ),
	.clock ( clk ),
	.data ( 23'b0 ),
	.wren ( rw ),
	.q ( dat )
	);

always @(posedge lock)
	lock_state <= ~lock_state;

always @(posedge clk)
	clk1 = ~clk1;
	
always @ (posedge clk1)
begin
	addr <= j*640 + i;
	if((i < 639) & (j < 479))
	begin
		if (lock_state == 0)
		begin
			outp <= dat;
		end
		else
		begin
			outp <= 24'h0;
		end
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
