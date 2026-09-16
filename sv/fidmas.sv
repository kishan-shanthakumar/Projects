module fidmas #(parameter N = 32)
                (input logic [N-1:0] a,b,
                input logic [1:0] s,
                input logic float,
                output logic car,
                output logic [N-1:0] outh,
                output logic [N-1:0] out);

logic [N-1:0] faddl;
logic [N-1:0] fsubl;
logic [N-1:0] fmull;
logic [N-1:0] fdivl;
logic [N:0] naddl;
logic [N:0] nsubl;
logic [N-1:0] nmull;
logic [N-1:0] nmullh;
logic [N-1:0] ndivl;
logic [N-1:0] ndivlh;

fadd u1(a,b,faddl);
fadd u2(a,{!b[N-1],b[N-2:0]},fsubl);
fmul u3(a,b,fmull);
fdiv u4(a,b,fdivl);
cseladd u5(a,b,0,naddl);
cseladd u6(a,!b,1,nsubl);
nmul u7(a,b,{nmullh,nmull});
n_divider u8(a,b,{ndivlh,ndivl});

always_comb
begin
    car = 0;
    outh = 0;
    out = 0;
    case(float)
        0:begin
            case(s)
                2'b00: {car,out} = naddl;
                2'b01: {car,out} = nsubl;
                2'b10: {outh,out} = {nmullh,nmull};
                2'b11: {outh,out} = {ndivlh, ndivl};
            endcase
        end
        1:begin
            case(s)
                2'b00: out = faddl;
                2'b01: out = fsubl;
                2'b10: out = fmull;
                2'b11: out = fdivl;
            endcase
        end
    endcase
end

endmodule
