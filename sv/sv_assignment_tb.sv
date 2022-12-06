class packet;

rand bit [7:0] exp_rand;
rand bit [22:0] man_rand;
rand bit sign_rand;

endclass

module sv_assignment_tb;
logic [15:0] sum;
logic ready;
logic [15:0] a, b;
logic clock, nreset;
shortreal reala, realb;
real realsum;
real sum1;
logic [31:0] ra, rb, sum0;
int check;
bfloat16_adder a1 (.*);
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
    packet pkt1;
    for(int i = 0; i < 256; i += 1)
    begin
        @(posedge ready); // wait for ready
        realsum = $bitstoshortreal({sum, {16{1'b0}}});
        sum0 = $shortrealtobits((reala+realb));
        sum0 = {sum0[31:16],16'b0};
        sum1 =$bitstoshortreal(sum0);
        if ((((realsum-sum1)/sum1)*100) <-1.0 | (((realsum-sum1)/sum1)*100)>1.0)
        begin
            $display("a is %f", reala);
            $display("b is %f", realb);
            $display("Recieved sum is %f", realsum);
            $display("Expected sum is %f", sum1);
            $display("Error %f", (((realsum-sum1)/sum1)*100));
        end
        
        #2 @(posedge clock)
        pkt1 = new();
        check = pkt1.randomize();
        ra = {pkt1.sign_rand, pkt1.exp_rand, pkt1.man_rand};
        reala = $bitstoshortreal(ra);
        a = ra[31:16];
        
        #2 @(posedge clock)
        pkt1 = new();
        check = pkt1.randomize();
        rb = {pkt1.sign_rand, pkt1.exp_rand, pkt1.man_rand};
        realb = $bitstoshortreal(rb);
        b = rb[31:16];
    end
end
endmodule

/*module sv_assignment_tb;
logic [15:0] sum;
logic ready;
logic [15:0] a, b;
logic clock, nreset;
shortreal reala, realb, realsum;
logic [31:0] ra, rb;
bfloat16_adder a1 (.*);
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
#2 @(posedge clock)
//Test 2 -- 1.0 + 1.0
reala = 1.1;
ra = $shortrealtobits(reala);
realb = 1.5;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 1.8;
ra = $shortrealtobits(reala);
realb = 2.6;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 1.0;
ra = $shortrealtobits(reala);
realb = 0.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = -1.0;
ra = $shortrealtobits(reala);
realb = 0.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = -1.0;
ra = $shortrealtobits(reala);
realb = 1.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 1.0;
ra = $shortrealtobits(reala);
realb = -1.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 0;
ra = 32'hffffffff;
realb = -1.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 0.0;
ra = $shortrealtobits(reala);
realb = 0.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 1;
ra = 32'hff800000;
realb = -1.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 0.0;
ra = 32'h80000000;
realb = -0.0;
rb = 32'h00000000;
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 0.0;
ra = 32'h00000000;
realb = -0.0;
rb = 32'h80000000;
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 0.0;
ra = 32'h80000000;
realb = -0.0;
rb = 32'h80000000;
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 0.0;
ra = $shortrealtobits(reala);
realb = 0.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 1.0;
ra = $shortrealtobits(reala);
realb = 1.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = -1.0;
ra = $shortrealtobits(reala);
realb = 1.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = -0.4550781;
ra = $shortrealtobits(reala);
realb = 3.921875;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = -0.001876831;
ra = $shortrealtobits(reala);
realb = -1.25;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 1.790181e+17;
ra = $shortrealtobits(reala);
realb = -2.56e+05;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 1.0;
ra = $shortrealtobits(reala);
realb = 0.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 1;
ra = $shortrealtobits(reala);
realb = 0.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 1.0;
ra = $shortrealtobits(reala);
realb = -0.0;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = 2.573042e-31;
ra = $shortrealtobits(reala);
realb = -1.789213e+27;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

reala = -87;
ra = $shortrealtobits(reala);
realb = 1.039062;
rb = $shortrealtobits(realb);
a = ra[31:16];
#2 @(posedge clock)
b = rb[31:16];
@(posedge ready);
#2 @(posedge clock)
realsum = $bitstoshortreal({sum, {16{1'b0}}});
$display("Test 2 %f\n", realsum);

end
endmodule*/