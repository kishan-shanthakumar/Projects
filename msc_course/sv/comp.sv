module compn #(parameter N = 64)
                (input logic [N-1:0] a, b,
                output logic eq);

logic [N-1:0] eqi = 0;

always_comb
begin
    for (int i = 0; i < N; i++)
    begin
        if (i == 0)
            eqi[i] = ~(a[i] ^ b[i]);
        else
            eqi[i] = ~(a[i] ^ b[i]) & eqi[i-1];
    end
    eq = eqi[N-1];
end

endmodule
