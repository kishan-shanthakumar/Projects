class packet;

rand bit [7:0] exp_rand;
rand bit [22:0] man_rand;
rand bit [1:0] s_rand;
rand bit sign_rand;

endclass

module falu_tb;
logic [15:0] out;
logic [15:0] a, b;
logic [1:0] s;
shortreal reala, realb;
shortreal realans;
real realout;
logic [31:0] ra, rb;
int check;
falu a1 (.*);
initial
begin
    packet pkt1;
    for(int i = 0; i < 256; i += 1)
    begin
        #5
        pkt1 = new();
        check = pkt1.randomize();
        ra = {pkt1.sign_rand, pkt1.exp_rand, pkt1.man_rand};
        reala = $bitstoshortreal(ra);
        $display("a is %f", reala);
        a = ra;
        
        pkt1 = new();
        check = pkt1.randomize();
        rb = {pkt1.sign_rand, pkt1.exp_rand, pkt1.man_rand};
        realb = $bitstoshortreal(rb);
        $display("b is %f", realb);
        b = rb;

        #5
        realout = $bitstoshortreal({out, {16{1'b0}}});
        realans = (s == 2'b00) ? reala+realb : ( (s == 2'b01) ? reala-realb : ( (s == 2'b10) ? reala*realb : reala/realb) );
        $display("Error %f", (((realout-realans)/realans)*100));
    end
end
endmodule