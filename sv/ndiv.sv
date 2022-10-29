module nmul #(parameter N = 32)
            (input logic [N-1:0] a,b,
            output logic [N*2-1:0] div);

logic [N*2-1:0] x;
logic [N*2-1:0] dx;
logic [N*2-1:0] dx2;
logic [N*2-1:0] x2dx;
logic [N*2-1:0] temp;

nmul #(N) u1(x[N*2-1-:N],b,dx);
nmul #(N) u2(dx2[N*2-1-:N],x[N*2-1-:N],x2dx);
nmul #(N) u3(a,x[N*2-1-:N],temp);

always_comb
begin
    x = 0;
    for(int i = 0; i < 10; i++)
    begin
        dx2 = 2-dx[N*2-1-:N];
        x = x2dx;
    end
    div = temp;
end

endmodule
