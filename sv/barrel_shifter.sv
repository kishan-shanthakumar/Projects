module bar_shift #(parameter N = 5)
                    (input logic [(2**N-1):0] inp,
                    input logic [N-1:0] shftamt,
                    input dir,
                    output logic [(2**N-1):0] outp);

logic [N-1:0] temp; 

always_comb begin : shift
    temp = inp;
    for(int i = shft-1; i >= 0; i = i - 1)
    begin
        temp = (shftamt == 0) ? temp : ( (dir == 0) ? {temp[2**N-2**i-1:0],{(2**i){1'b0}}} : {{(2**i){1'b0}},temp[2**N-1:-2**i]} );
    end
end

endmodule