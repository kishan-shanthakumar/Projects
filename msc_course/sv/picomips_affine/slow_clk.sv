module slow_clk #(parameter n = 24) //clock divides by 2^n, adjust n if necessary
  (input clk, output clock);
  
logic [n-1:0] count;

always_ff @(posedge clk)
    count <= count + 1;

assign clock = count[n-1]; // slow clock

endmodule