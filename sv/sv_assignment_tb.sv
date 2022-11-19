module sv_assignment_tb;
logic [15:0] sum;
logic ready;
logic [15:0] a, b;
logic clock, nreset;
shortreal reala, realb, realsum;
logic [31:0] ra, rb;
fadd a1 (.*);
initial
begin
nreset = '1;
clock = '0;
#5ns nreset = '1;
#5ns nreset = '0;
#5ns nreset = '1;
forever #5ns clock = ~clock;
end
initial
begin
//Test 1 -- reset
@(posedge ready); // wait for ready
//Test 2 -- 1.0 + 1.0
reala = 1.0;
ra = $shortrealtobits(reala);
realb = 1.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
b = rb[31:16];
@(posedge ready);
@(posedge clock);
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

end
endmodule