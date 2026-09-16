module prio_enc_tb();

logic [3:0] a;
logic [1:0] b;
logic valid;

initial begin
a = 0;
end

always #10 a += 1;

enc_n #(2) u1(b, valid, a);

endmodule