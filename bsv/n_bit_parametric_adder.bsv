function Bit#(2) fa(Bit#(1) a, Bit#(1) b, Bit#(1) c_in);
    Bit#(1) s = (a ^ b)^ c_in;
    Bit#(1) c_out = (a & b) | (c_in & (a ^ b));
    return {c_out, s};
endfunction

function Bit#(TAdd#(w,1)) addN(Bit#(w) a, Bit#(w) b, Bit#(1) c0);
    Bit#(w) s;
    Bit#(TAdd#(w,1))c = {?,c0};
    for(Integer i=0;i<valueOf(w); i=i+1)
    begin
        let cs = fa(a[i],b[i],c[i]);
        s[i] = cs[0]; c[i+1]=cs[1];
    end
    return {c[valueOf(w)],s};
endfunction

function Bit#(33) add32(Bit#(32) x, Bit#(32) y, Bit#(1) c0) = addN(x,y,c0);
