module nmul #(parameter N = 32)
            (input logic [N-1:0] a,b,
            output logic [N*2-1:0] mul);

always_comb
begin
    mul = 0;
    for(int i = 0; i < N; i++)
    begin
        mul += b[i]? a<<i : '0;
    end
end

endmodule
