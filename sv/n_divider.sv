module n_divider #(parameter N = 32)
            (input logic [N-1:0] a,b,
            output logic [N-1:0] quo,rem);

logic [N-1:0] Q;
logic [N-1:0] A;
int n;
logic [N-1:0] M;

always_comb
begin
    M = b;
    n = N;
    A = 0;
    Q = a;
    while (n > 0)
    begin
        if (A[N-1] == 0)
        begin
            {A,Q} = {A,Q}<<1;
            A = A - M;
        end
        else
        begin
            {A,Q} = {A,Q}<<1;
            A = A + M;
        end
        if (A[N-1] == 0)
        begin
            Q[0] = 1;
        end
        else
        begin
            Q[0] = 0;
        end
        n = n - 1;
    end
    if (A[N-1] == 1)
    begin
        A = A + M;
    end
    quo = Q;
    rem = A;
end

endmodule
