interface Ifc_kishan;
    method Action ma_start (Bit#(32) opcode);
    method ActionValue#(Bit#(32)) mav_result();
endinterface: Ifc_kishan

typedef enum {IDLE, A, END} KishanState deriving (Bits, Eq);

module mk_kishan#(Bit#(32) opcode1, Bit#(32) opcode_in) (Ifc_kishan);

    Reg#(KishanState) rg_kishan <- mkReg(IDLE);
    Reg#(Bit#(32)) ans <- mkReg(0);
    Reg#(Bit#(32)) opcode_in <- mkReg(0);

    rule rl_A if (rg_kishan == A);
    ans <= opcode_in ^ opcode1;
    rg_kishan <= END;

    endrule

    method Action ma_start (Bit#(32) opcode) if (rg_kishan == IDLE);
    opcode_in <= opcode;
    rg_kishan <= A;
    endmethod

    method ActionValue#(Bit#(32)) mav_result () if (rg_kishan == END);
        rg_kishan <= IDLE;
        return ans;
    endmethod: mav_result
endmodule: mk_kishan
