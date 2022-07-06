import Vector :: * ;
`define w 'd64

function Bit#(2) fa(Bit#(1) a, Bit#(1) b, Bit#(1) c_in);
    Bit#(1) s = (a ^ b)^ c_in;
    Bit#(1) c_out = (a & b) | (c_in & (a ^ b));
    return {c_out, s};
endfunction

function Bit#(TAdd#(`w,1)) addN(Bit#(`w) a, Bit#(`w) b, Bit#(1) c0);
    Bit#(`w) s;
    Bit#(TAdd#(`w,1))c = {?,c0};
    for(Integer i=0;i<valueOf(`w); i=i+1)
    begin
        let cs = fa(a[i],b[i],c[i]);
        s[i] = cs[0]; c[i+1]=cs[1];
    end
    return {c[valueOf(`w)],s};
endfunction

function Bit#(TAdd#(`w,`w)) mulN(Bit#(`w) a, Bit#(`w) b);
    Vector#(`w,Bit#(TAdd#(`w,`w))) temp;
    Bit#(TAdd#(`w,`w)) product;
    function Bit#(TAdd#(TAdd#(`w,1),`w)) add(Bit#(TAdd#(`w,`w)) x, Bit#(TAdd#(`w,`w)) y, Bit#(1) c0) = addN(x,y,c0);
    for(Integer i=0;i<valueOf(`w); i=i+1)
    begin
        for(Integer j=0;i<valueOf(`w); j=j+1)
        begin
            temp[i][j] = (a[j] & b[i])<<i;
        end
        product = add(product,temp[i], 1'b0)[127:0];
    end
    return product;
endfunction

function Bit#(TAdd#(`w,`w)) macN(Bit#(`w) a, Bit#(`w) b, Bit#(`w) c);
    function Bit#(TAdd#(`w,`w)) mul(Bit#(`w) x, Bit#(`w) y) = mulN(x,y);
    function Bit#(TAdd#(TAdd#(`w,1),`w)) add(Bit#(TAdd#(`w,`w)) x, Bit#(TAdd#(`w,`w)) y, Bit#(1) c0) = addN(x,y,c0);
    let temp = mul(a,b);
    let mac_ans  = add(temp, {64'b0, c}, 1'b0)[127:0];
    return mac_ans;
endfunction

function Bit#(TAdd#(`w,`w)) mac(Bit#(`w) x, Bit#(`w) y, Bit#(`w) z) = macN(x,y,z);
