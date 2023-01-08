module an(inp,op);
input [3:0] inp;
output reg [6:0] op;

always @(*)
begin
	case (inp)
	4'b0000 : op = 7'b0111111;
	4'b0001 : op = 7'b0000110;
	4'b0010 : op = 7'b1011011;
	4'b0011 : op = 7'b1001111;
	4'b0100 : op = 7'b1100110;
	4'b0101 : op = 7'b1101101;
	4'b0110 : op = 7'b1111101;
	4'b0111 : op = 7'b0000111;
	4'b1000 : op = 7'b1111111;
	4'b1001 : op = 7'b1101111;
	endcase
	op = op ^ 7'b1111111;
end

endmodule

module esc_driver(clk,en,inp,pwm,clk1,ang);
input [7:0] inp;
input clk;
input en;
output reg pwm;
output clk1;
output [20:0] ang;

reg [7:0] prescaler;

reg clk1;

reg [9:0] counter;

integer i;
integer j <= 0;
integer angle;

always @ ( posedge clk )
begin
	prescaler <= prescaler + 8'b1;
	if ( prescaler == 8'h63 )
	begin
		clk1 <= ~clk1;
		prescaler <= 0;
	end
end

always @ (posedge clk1)
begin
	if(en)
	begin
		counter <= counter + 1;
		j <= j + 1;
		i <= inp * 100/255 + 25;
		angle <= inp*180/255;
		if ( counter == 10'h3E7 )
		begin
			counter <= 0;
			j=0;
		end
		if ( j == 0 )
			pwm <= 1;
		else if ( j >= i )
			pwm <= 0;
	end
	else
		pwm <= 0;
end
an u1( (  angle%10)     , ang[6:0]   );
an u2( (( angle/10)%10) , ang[13:7]  );
an u3( (  angle/100)    , ang[20:14] );

endmodule