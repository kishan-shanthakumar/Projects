module nmul #(parameter N = 32)
            (input logic [N-1:0] a,b,
            output logic [N*2-1:0] mul);

logic [N*2-1:0] temp;

always_comb
begin
    temp = 0;
    for(int i = 0; i < N; i++)
    begin
        temp += b[i]? a<<i : 0;
    end
    mul = temp;
end

endmodule
