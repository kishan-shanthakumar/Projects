import Vector :: * ;
`define w 'd64

function Bit#(2) fa(Bit#(1) a, Bit#(1) b, Bit#(1) c_in);
    Bit#(1) s = (a ^ b)^ c_in;
    Bit#(1) c_out = (a & b) | (c_in & (a ^ b));
    return {c_out, s};
endfunction

function Bit#(TAdd#(w,1)) addN(Bit#(w) a, Bit#(w) b, Bit#(1) c0);
    Bit#(w) s;
    Bit#(TAdd#(w,1))c = zeroExtend(c0);
    for(Integer i=0;i<valueOf(w); i=i+1)
    begin
        let cs = fa(a[i],b[i],c[i]);
        s[i] = cs[0]; c[i+1]=cs[1];
    end
    return {c[valueOf(w)],s};
endfunction

function Bit#(TAdd#(w,w)) mulN(Bit#(w) a, Bit#(w) b);
    Bit#(TAdd#(w,w)) temp;
    Bit#(TAdd#(w,w)) product;
    product = 0;
    function Bit#(TAdd#(TAdd#(w,1),w)) add(Bit#(TAdd#(w,w)) x, Bit#(TAdd#(w,w)) y, Bit#(1) c0) = addN(x,y,c0);
    for(Integer i=0;i<valueOf(w); i=i+1)
    begin
        if (b[i] == 1'b1)
        begin
            temp = zeroExtend(a << i);
            product = truncate(add(product,temp, 1'b0));
        end
    end
    return product;
endfunction

function Bit#(TAdd#(w,w)) macN(Bit#(w) a, Bit#(w) b, Bit#(w) c);
    function Bit#(TAdd#(w,w)) mul(Bit#(w) x, Bit#(w) y) = mulN(x,y);
    function Bit#(TAdd#(TAdd#(w,1),w)) add(Bit#(TAdd#(w,w)) x, Bit#(TAdd#(w,w)) y, Bit#(1) c0) = addN(x,y,c0);
    let temp = mul(a,b);
    let mac_ans  = truncate(add(temp, zeroExtend(c), 1'b0));
    return mac_ans;
endfunction

function Bit#(TAdd#(`w,`w)) mac(Bit#(`w) x, Bit#(`w) y, Bit#(`w) z) = macN(x,y,z);

interface Ifc_MAC;
    method Action ma_start ();
    method ActionValue#(Bit#(TAdd#(`w,`w))) mav_result();
endinterface: Ifc_MAC

typedef enum {IDLE, A, END} MAC_State deriving (Bits, Eq);

module mk_MAC#(Bit#(`w) a, Bit#(`w) b, Bit#(`w) c) (Ifc_MAC);

    Reg#(MAC_State) rg_MAC <- mkReg(IDLE);
    Reg#(Bit#(TAdd#(`w,`w))) ans <- mkReg(0);

    rule rl_A if (rg_MAC == A);
    ans <= mac(a,b,c);
    rg_MAC <= END;

    endrule

    method Action ma_start () if (rg_MAC == IDLE);
    rg_MAC <= A;
    endmethod

    method ActionValue#(Bit#(TAdd#(`w,`w))) mav_result () if (rg_MAC == END);
        rg_MAC <= IDLE;
        return ans;
    endmethod: mav_result
endmodule: mk_MAC
