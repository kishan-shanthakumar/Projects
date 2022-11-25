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
reala = 1.1;
ra = $shortrealtobits(reala);
realb = 1.5;
rb = $shortrealtobits(realb);
a = ra[31:16];
b = rb[31:16];
@(posedge ready);
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 1.8;
ra = $shortrealtobits(reala);
realb = 2.6;
rb = $shortrealtobits(realb);
a = ra[31:16];
b = rb[31:16];
@(posedge ready);
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 1.0;
ra = $shortrealtobits(reala);
realb = 0.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
b = rb[31:16];
@(posedge ready);
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = -1.0;
ra = $shortrealtobits(reala);
realb = 0.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
b = rb[31:16];
@(posedge ready);
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = -1.0;
ra = $shortrealtobits(reala);
realb = 1.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
b = rb[31:16];
@(posedge ready);
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 1.0;
ra = $shortrealtobits(reala);
realb = -1.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
b = rb[31:16];
@(posedge ready);
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 0;
ra = 32'hffffffff;
realb = -1.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
b = rb[31:16];
@(posedge ready);
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 0.0;
ra = $shortrealtobits(reala);
realb = 0.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
b = rb[31:16];
@(posedge ready);
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 1;
ra = 32'hff800000;
realb = -1.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
b = rb[31:16];
@(posedge ready);
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 0.0;
ra = 32'h80000000;
realb = -0.0;
rb = 32'h00000000;
a = ra[31:16];
b = rb[31:16];
@(posedge ready);
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 0.0;
ra = 32'h00000000;
realb = -0.0;
rb = 32'h80000000;
a = ra[31:16];
b = rb[31:16];
@(posedge ready);
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 0.0;
ra = 32'h80000000;
realb = -0.0;
rb = 32'h80000000;
a = ra[31:16];
b = rb[31:16];
@(posedge ready);
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

end
endmodule