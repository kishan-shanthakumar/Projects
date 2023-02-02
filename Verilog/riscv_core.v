module riscv_core(addr, mem_addr, ddatin, ddatout, rw, en, din, clk, rst, trap);
output reg [31:0] addr;
output reg [31:0] mem_addr;
input [31:0] ddatin;
output reg [31:0] ddatout;
output reg rw;
output reg en;
input [31:0] din;
input clk;
input rst;
output reg trap;

wire [6:0] opcode;
reg [31:0] r[0:31];
reg [31:0] temp;
reg [20:0] adcalc;
reg [13:0] badcalc;
reg [1:0] wait1;

assign opcode = din[6:0];

always @(posedge clk, negedge rst )
begin
    if(!rst)
    begin
        addr <= 32'h1f;
        mem_addr <= 32'b0;
        ddatout <= 32'b0;
        rw <= 0;
        en <= 0;
        trap <= 0;
        r[31] <= 32'b0;r[30] <= 32'b0;r[29] <= 32'b0;r[28] <= 32'b0;r[27] <= 32'b0;r[26] <= 32'b0;r[25] <= 32'b0;r[24] <= 32'b0;
        r[23] <= 32'b0;r[22] <= 32'b0;r[21] <= 32'b0;r[20] <= 32'b0;r[19] <= 32'b0;r[18] <= 32'b0;r[17] <= 32'b0;r[16] <= 32'b0;
        r[15] <= 32'b0;r[14] <= 32'b0;r[13] <= 32'b0;r[12] <= 32'b0;r[11] <= 32'b0;r[10] <= 32'b0;r[9] <= 32'b0;r[8] <= 32'b0;
        r[7] <= 32'b0;r[6] <= 32'b0;r[5] <= 32'b0;r[4] <= 32'b0;r[3] <= 32'b0;r[2] <= 32'b0;r[1] <= 32'b0;r[0] <= 32'b0;
        temp <= 32'b0;
        wait1 <= 0;
    end
    else if (wait1 > 0)
        wait1 <= wait1 - 1;
    else
    begin
    trap <=0;
    rw <= 0;
    en <= 0;
    if (opcode == 7'b0010011) begin
        addr <= addr + 1'b1;
        case (din[14:12])
            3'b000: begin
                    if (din[31]) begin
                r[din[11:7]] <= r[din[19:15]] - 32'h00001000 + {20'b0, din[31:20]};
            end
            else
                r[din[11:7]] <= r[din[19:15]] + {20'b0, din[31:20]};
            end
            3'b010: begin
                    r[din[11:7]] <= r[din[19:15]] < $signed({20'hFFFFF, din[31:20]}) ? 1:0;
                    end
            3'b011: begin
                    r[din[11:7]] <= r[din[19:15]] < ({20'hFFFFF, din[31:20]}) ? 1:0;
                    end
            3'b100: begin
                    r[din[11:7]] <= r[din[19:15]] ^ {20'b0, din[31:20]};
                    end
            3'b110: begin
                    r[din[11:7]] <= r[din[19:15]] | {20'b0, din[31:20]};
                    end
            3'b111: begin
                    r[din[11:7]] <= r[din[19:15]] & {20'b0, din[31:20]};
                    end
            3'b001: begin
                    case (din[31:25])
                    7'b0000000: r[din[11:7]] <= r[din[19:15]] << din[31:20];
                    default: trap <=1;
                endcase
            end
            3'b101: begin
                    case (din[31:25])
                    7'b0000000: r[din[11:7]] <= r[din[19:15]] >> din[31:20];
                    7'b0100000: r[din[11:7]] <= r[din[19:15]] >>> din[31:20];
                    default: trap <=1;
                endcase
            end
        endcase
    end
    else if (opcode == 7'b0110011) begin
        addr <= addr + 1;
        case ({din[14:12],din[31:25]})
            10'b0000000000: begin
                            r[din[11:7]] <= r[din[19:15]] + r[{din[24:20]}];
                            end
            10'b0000100000: begin
                            r[din[11:7]] <= r[din[19:15]] - r[din[24:20]];
                            end
            10'b0010000000: begin
                            r[din[11:7]] <= r[din[19:15]] << r[din[24:20]];
                            end
            10'b0100000000: begin
                            r[din[11:7]] <= r[din[19:15]] < (r[din[24:20]]) ?1:0;
                            end
            10'b0110000000: begin
                            r[din[11:7]] <= r[din[19:15]] < $signed(r[din[24:20]]) ?1:0;
                            end
            10'b1000000000: begin
                            r[din[11:7]] <= r[din[19:15]] ^ r[din[24:20]];
                            end
            10'b1010000000: begin
                            r[din[11:7]] <= r[din[19:15]] >> r[din[24:20]];
                            end
            10'b1010100000: begin
                            r[din[11:7]] <= r[din[19:15]] >>> r[din[24:20]];
                            end
            10'b1100000000: begin
                            r[din[11:7]] <= r[din[19:15]] | r[din[24:20]];
                            end
            10'b1110000000: begin
                            r[din[11:7]] <= r[din[19:15]] & r[din[24:20]];
                            end
            default: trap <=1;
        endcase
    end
    else if (opcode == 7'b0000011) begin
        wait1 <= 2;
        addr <= addr + 1;
        case (din[14:12])
            3'b000: begin
                        mem_addr <= r[din[19:15]] + {20'b0, din[31:20]};
                        rw <= 0;
                        en <= 1;
                        r[din[11:7]] <= (mem_addr[1:0] == 2'b00)?{{24{ddatin[7]}},{ddatin[7:0]}}:
                        (mem_addr[1:0] == 2'b01)?{{24{ddatin[15]}},{ddatin[15:8]}}:
                        (mem_addr[1:0] == 2'b10)?{{24{ddatin[23]}},{ddatin[23:16]}}:
                        {{24{ddatin[31]}},{ddatin[31:24]}};
                    end
            3'b001: begin
                        mem_addr <= r[din[19:15]] + {20'b0, din[31:20]};
                        if (mem_addr[0] == 1'b0) begin
                            rw <= 0;
                            en <= 1;
                            r[din[11:7]] <= (mem_addr[1] == 1'b0)?{{16{ddatin[15]}},{ddatin[15:0]}}:{{16{ddatin[31]}},{ddatin[31:16]}};
                        end
                        else
                            trap <=1;
                    end
            3'b010: begin
                        mem_addr <= r[din[19:15]] + {20'b0, din[31:20]};
                        if (mem_addr[1:0] == 2'b00) begin
                            rw <= 0;
                            en <= 1;
                            r[din[11:7]] <= ddatin;
                        end
                        else
                            trap <=1;
                    end
            3'b100: begin
                        mem_addr <= r[din[19:15]] + {20'b0, din[31:20]};
                        rw <= 0;
                        en <= 1;
                        r[din[11:7]] <= (mem_addr[1:0] == 2'b00)?{24'b0,ddatin[7:0]}:
                        (mem_addr[1:0] == 2'b01)?{24'b0,ddatin[15:8]}:
                        (mem_addr[1:0] == 2'b10)?{24'b0,ddatin[23:16]}:
                        {24'b0,ddatin[31:24]};
                    end
            3'b101: begin
                        mem_addr <= r[din[19:15]] + {20'b0, din[31:20]};
                        if (mem_addr[1:0] == 1'b0) begin
                            rw <= 0;
                            en <= 1;
                            r[din[11:7]] <= (mem_addr[1] == 1'b0)?{16'b0,ddatin[15:0]}:{16'b0,ddatin[31:16]};
                        end
                        else
                            trap <=1;
                    end
            default: trap <=1;
        endcase
    end
    else if (opcode == 7'b0100011) begin
        wait1 <= 1;
        case (din[14:12])
            3'b000: begin
                    mem_addr <= r[din[19:15]] + {20'b0, din[31:25], din[11:7]};
                    rw <= 1;
                    en <= 1;
                    ddatout <= (mem_addr[1:0] == 2'b00)?{ddatin[31:8], r[din[24:20]][7:0]}:
                    (mem_addr[1:0] == 2'b01)?{ddatin[31:16], r[din[24:20]][7:0], ddatin[7:0]}:
                    (mem_addr[1:0] == 2'b10)?{ddatin[31:24], r[din[24:20]][7:0], ddatin[15:0]}:
                    {r[din[24:20]][7:0], ddatin[23:0]};
                    end
            3'b001: begin
                        mem_addr <= r[din[19:15]] + {20'b0, din[31:25], din[11:7]};
                        if (mem_addr[0] == 1'b0) begin
                            rw <= 1;
                            en <= 1;
                            ddatout <= (mem_addr[1] == 1'b0)?{ddatin[31:16], r[din[24:20]][15:0]}:{r[din[24:20]][15:0], ddatin[31:16]};
                        end
                        else
                            trap <=1;
                    end
            3'b010: begin
                        mem_addr <= r[din[19:15]] + {20'b0, din[31:25], din[11:7]};
                        if (mem_addr[1:0] == 2'b00) begin
                            rw <= 1;
                            en <= 1;
                            ddatout <= r[din[24:20]];
                        end
                        else
                            trap <=1;
                    end
            default: trap <=1;
        endcase
        addr <= addr + 1;
    end
    else if (opcode == 7'b0110111) begin
        r[din[11:7]][31:12] <= din[31:12];
        addr <= addr + 1;
    end
    else if (opcode == 7'b0010111) begin
        r[din[11:7]] <= addr + {din[31:12],12'b0};
        addr <= addr + 1;
    end
    else if (opcode == 7'b1100011) begin
        wait1 <= 1;
        badcalc =  {din[31], din[7], din[30:25], din[11:8], 1'b0};
        if (din[31]) begin
            badcalc =  badcalc - 1;
            badcalc =  ~badcalc;
        end
        case (din[14:12])
            3'b000: begin
                        if ( $signed(r[din[19:15]]) == $signed(r[din[24:20]])) begin
                            case(din[31])
                            1'b0: addr <= addr + (badcalc)/4;
                            1'b1: addr <= addr - (badcalc)/4;
                            endcase
                        end
                    end
            3'b001: begin
                        if ( $signed(r[din[19:15]]) != $signed(r[din[24:20]])) begin
                            case(din[31])
                            1'b0: addr <= addr + (badcalc)/4;
                            1'b1: addr <= addr - (badcalc)/4;
                            endcase
                        end
                    end
            3'b100: begin
                        if ( $signed(r[din[19:15]]) < $signed(r[din[24:20]])) begin
                            case(din[31])
                            1'b0: addr <= addr + (badcalc)/4;
                            1'b1: addr <= addr - (badcalc)/4;
                            endcase
                        end
                    end
            3'b101: begin
                        if ( $signed(r[din[19:15]]) >= $signed(r[din[24:20]])) begin
                            case(din[31])
                            1'b0: addr <= addr + (badcalc)/4;
                            1'b1: addr <= addr - (badcalc)/4;
                            endcase
                        end
                    end
            3'b110: begin
                        if ( r[din[19:15]] < r[din[24:20]]) begin
                            case(din[31])
                            1'b0: addr <= addr + (badcalc)/4;
                            1'b1: addr <= addr - (badcalc)/4;
                            endcase
                        end
                    end
            3'b111: begin
                        if ( r[din[19:15]] >= r[din[24:20]])
                        begin
                            case(din[31])
                            1'b0: addr <= addr + (badcalc)/4;
                            1'b1: addr <= addr - (badcalc)/4;
                            endcase
                        end
                    end
            default: trap <=1;
        endcase
    end
    else if (opcode == 7'b1101111) begin
        wait1 <= 1;
        r[din[11:7]] <= addr + 1;
        adcalc =  {din[31], din[19:12], din[20], din[30:21], 1'b0};
        case (din[31])
        1'b0: addr <= addr + adcalc/4;
        1'b1: begin
              adcalc =  adcalc - 1;
              adcalc =  ~adcalc;
              addr <= addr - adcalc/4;
              end
        endcase
    end
    else if (opcode == 7'b1100111) begin
        wait1 <= 1;
        r[din[11:7]] <= addr + 1;
        adcalc =  {din[31], din[19:12], din[20], din[30:21], 1'b0};
        case (din[31])
        1'b0: addr <= r[din[19:15]]>>2 + adcalc>>2;
        1'b1: begin
              adcalc =  adcalc - 1;
              adcalc =  ~adcalc;
              addr <= r[din[19:15]]>>2 - adcalc>>2;
              end
        endcase
    end
    else
        trap <=1;
    end
end

endmodule
