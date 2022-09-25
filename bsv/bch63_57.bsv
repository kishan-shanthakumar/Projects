function Bit#(63) synd(Bit#(55) inp);
    Bit#(1) synd0;
    Bit#(1) synd1;
    Bit#(1) synd2 = 0;
    Bit#(1) synd3;
    Bit#(1) synd4;
    Bit#(1) synd5;
    Bit#(1) synd6 = 0;
    for(Integer i=0;i<55; i=i+1)
    begin
        Bit#(1) x = inp[i] ^ synd6;
        synd0 = x;
        synd1 = synd0;
        synd2 = synd1 ^ x;
        synd3 = synd2;
        synd4 = synd3;
        synd5 = synd4;
        synd6 = synd5 ^ x;
    end
    return {inp, synd6^1, synd5^1, synd4^1, synd3^1, synd2^1, synd1^1, synd0^1, 1'b0};
endfunction

interface Ifc_bch;
    method Action ma_start ();
    method ActionValue#(Bit#(64)) mav_result();
endinterface: Ifc_bch

module mk_bch#(Bit#(55) inp) (Ifc_bch);

    Reg#(Bit#(2)) rg_bch <- mkReg(0);
    Reg#(Bit#(63)) out <- mkReg(0);

    rule rl_A if (rg_bch == 1);
    out <= synd(inp);
    rg_bch <= 2;
    endrule

    method Action ma_start () if (rg_bch == 0);
    rg_bch <= 1;
    endmethod

    method ActionValue#(Bit#(64)) mav_result () if (rg_bch == 2);
        rg_bch <= 0;
        return {out,1'b0};
    endmethod: mav_result
endmodule: mk_bch
