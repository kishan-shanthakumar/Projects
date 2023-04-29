module fft(input logic [7:0] inp,
            input logic clk, rst, readyin,
            output logic [7:0] out);

logic [7:0] sum, diff, pro;
logic [7:0] add_a, add_b, sub_a, sub_b, mul_a, mul_b;
logic [3:0] counter;
logic [7:0] w1, w2, a1, a2, b1, b2, s1, ad1, p1, p2, p3, p4, y1, y2, z1, z2;
logic readys, ready;

always_ff @(posedge clk, negedge rst)
begin
    if (!rst)
    begin
        readys <= 0;
    end
    else
    begin
        readys <= readyin;
    end
end

assign ready = (readys ^ readyin) & readyin;

add u1(.*);
mul u2(.*);
sub u3(.*);

enum {start, iw1, iw2, ia1, ia2, ib1, ib2, running, oy1, oy2, oz1, oz2} state, next_state;

always_ff @(posedge clk, negedge rst)
begin
    if (!rst)
    begin
        state <= start;
        counter <= 0;
        w1 <= 0; w2 <= 0; a1 <= 0; a2 <= 0; b1 <= 0; b2 <= 0;
        s1 <= 0; ad1 <= 0; p1 <= 0; p2 <= 0; p3 <= 0; p4 <= 0;
        y1 <= 0; y2 <= 0; z1 <= 0; z2 <= 0;
    end
    else
    begin
        state <= next_state;
        if(state == running)
            counter <= counter + 1;
        else
            counter <= 0;
        
        case (state)
        iw1: begin
            if(ready)
                w1 <= inp;
        end
        iw2: begin
            if(ready)
                w2 <= inp;
        end
        ia1: begin
            if(ready)
                a1 <= inp;
        end
        ia2: begin
            if(ready)
                a2 <= inp;
        end
        ib1: begin
            if(ready)
                b1 <= inp;
        end
        ib2: begin
            if(ready)
                b2 <= inp;
        end
        endcase

        if ( counter == 1 )
        begin
            p1 <= pro;
        end
        if ( counter == 2 )
        begin
            p2 <= pro;
        end
        if ( counter == 3 )
        begin
            s1 <= diff;
            p3 <= pro;
        end
        if ( counter == 4 )
        begin
            y1 <= sum;
            z1 <= diff;
            p4 <= pro;
        end
        if ( counter == 5 )
        begin
            ad1 <= sum;
        end
        if ( counter == 6 )
        begin
            y2 <= sum;
            z2 <= diff;
        end
    end
end

always_comb
begin
    add_a = 0;
    add_b = 0;
    sub_a = 0;
    sub_b = 0;
    mul_a = 0;
    mul_b = 0;
    if ( counter == 1 )
    begin
        mul_a = b1;
        mul_b = w1;
    end
    if ( counter == 2 )
    begin
        mul_a = b2;
        mul_b = w2;
    end
    if ( counter == 3 )
    begin
        sub_a = p1;
        sub_b = p2;
        mul_a = b1;
        mul_b = w2;
    end
    if ( counter == 4 )
    begin
        add_a = a1;
        add_b = s1;
        sub_a = a1;
        sub_b = s1;
        mul_a = b2;
        mul_b = w1;
    end
    if ( counter == 5 )
    begin
        add_a = p3;
        add_b = p4;
    end
    if ( counter == 6 )
    begin
        add_a = a2;
        add_b = ad1;
        sub_a = a2;
        sub_b = ad1;
    end

    next_state = state;
    out = 0;
    case(state)
    start: begin
        if(ready)
            next_state = iw1;
    end
    iw1: begin
        if(ready)
            next_state = iw2;
    end
    iw2: begin
        if(ready)
            next_state = ia1;
    end
    ia1: begin
        if(ready)
            next_state = ia2;
    end
    ia2: begin
        if(ready)
            next_state = ib1;
    end
    ib1: begin
        if(ready)
            next_state = ib2;
    end
    ib2: begin
        if(ready)
            next_state = running;
    end
    running: begin
        if (counter == 7)
            next_state = oy1;
    end
    oy1: begin
        out = y1;
        if(ready)
            next_state = oy2;
    end
    oy2: begin
        out = y2;
        if(ready)
            next_state = oz1;
    end
    oz1: begin
        out = z1;
        if(ready)
            next_state = oz2;
    end
    oz2: begin
        out = z2;
        if(ready)
            next_state = ia1;
    end
    endcase
end

endmodule