module parallel_bubble_sort #(parameter N = 8;)
                            (input [63:0] no_of_elements, start_address,
                            input clk, nreset, start);

enum {idle, read, sort, write} present_state, next_state;

logic [63:0] temp [0:63];
logic [63:0] addr, addr_s, noe;
integer i;

always_ff @(posedge clk, negedge nreset)
begin
    if (!nreset)
    begin
        for(i = 0; i < 64: i = i + 1)
        begin
            temp[i] <= 0;
        end
        present_state <= idle;
    end
    else
    begin
        present_state <= next_state;
        case (present_state)
        idle: begin
            if (start)
            begin
                addr <= start_address;
                addr_s <= start_address;
                noe <= no_of_elements;
            end
        end
        read: begin

        end
        endcase
    end
end

always_comb
begin
    next_state = present_state;
    case (present_state)
    idle: if (start)
            next_state = read;
    read: if (addr == (addr_s + noe))
            next_state = sort;
    sort:begin
    end
    write: begin
    end
    endcase
end
endmodule