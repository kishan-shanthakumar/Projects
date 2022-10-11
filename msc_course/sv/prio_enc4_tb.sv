module prio_enc_tb();

logic [3:0] a;
logic [1:0] b;

initial begin
a = 8;
#10 a = 4'hc;
#10 a = 4'he;
#10 a = 4'hf;
#10 a = 7;
#10 a = 3;
#10 a = 1;
#10 ;
end

//prio_enc u1(a,b);

endmodule