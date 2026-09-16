module falu #(parameter N = 32)
            (input logic [N-1:0] a,b,
            input logic [1:0] s, 
            output logic [N-1:0] out);

logic [N-1:0] faddl;
logic [N-1:0] fsubl;
logic [N-1:0] fmull;
logic [N-1:0] fdivl;

fadd u1(a,b,faddl);
fadd u2(a,{!b[N-1],b[N-2:0]},fsubl);
fmul u3(a,b,fmull);
fdiv u4(a,b,fdivl);

always_comb
begin
    case(s)
        2'b00: out = faddl;
        2'b01: out = fsubl;
        2'b10: out = fmull;
        2'b11: out = fdivl;
    endcase
end

endmodule