module dec3_8_tb();

logic [2:0] i;
logic [7:0] o;

initial begin
i = 0;
end

always #1 i = i + 1;

dec3_8 uut(i,o);

endmodule