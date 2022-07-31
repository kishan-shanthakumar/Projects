import Vector :: * ;

function Bit#(256) message_block(Bit#(16) data, Bit#(32) addr_start, Bit#(32) addr_end);
    
endfunction

interface Ifc_SHA;
    method Action ma_start (Bit#(64) blocks);
    method ActionValue#(Bit#(64)) ma_inter();
    method ActionValue#(Bit#(256)) mav_result();
endinterface: Ifc_SHA

typedef enum {IDLE, CALC, MESS_SCHED, END} SHA_State deriving (Bits, Eq);

module mk_SHA#(Bit#(8) data) (Ifc_SHA);

    Reg#(SHA_State) rg_SHA <- mkReg(IDLE);
    Reg#(Bit#(256)) ans <- mkReg(0);
    Reg#(Bit#(64)) no_blocks <- mkReg(0);
    
    rule rl_CALC if (rg_SHA == CALC);
    message
    rg_SHA <= MESS_SCHED;
    endrule

    method Action ma_start (Bit#(64) blocks) if (rg_SHA == IDLE);
    rg_SHA <= CALC;
    Vector#(blocks,Bit#(8)) message;
    endmethod

    method ActionValue#(Bit#(TAdd#(`w,`w))) mav_result () if (rg_SHA == END);
        rg_SHA <= IDLE;
        return ans;
    endmethod: mav_result
endmodule: mk_SHA
