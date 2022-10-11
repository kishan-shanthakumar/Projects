module mux4_tb();

logic [1:0] s;
logic [3:0] i;
logic o;

initial begin
s = 0;
i = 0;
end

always #1 i = i + 1;
always #16 s = s + 1;

//mux4 u1(s,i,o);

endmodule