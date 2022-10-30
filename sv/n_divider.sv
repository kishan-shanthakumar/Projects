module n_divider #(parameter N = 32)
            (input logic [N-1:0] a,b,
            output logic [N*2-1:0] div);

logic [N*2-1:0] x;

always_comb
begin
    x = 1;
    for(int i = 0; i < 10; i++)
    begin
        x = x*(2-b*x);
    end
    div = x * a;
end

endmodule
