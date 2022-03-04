module riscv_core(addr, mem_addr, dout, din, clk);
output reg [31:0] addr;
output reg [31:0] mem_addr;
output [31:0] dout;
input [31:0] din;
input clk;

reg [6:0] opcode;
reg [4:0] r [31:0];
reg [31:0] trap;
reg [31:0] temp;

always @(posedge clk )
begin
    trap = 32'b0;
    opcode = din[6:0];
    if (opcode == 7'b0010011) begin
        addr = addr + 1'b1;
        case (din[14:12])
            3'b000: if (din[31]) begin
                r[din[11:7]] = r[din[19:15]] - 32'h00001000 + {20'b0, din[31:20]};
            end
            else
                r[din[11:7]] = r[din[19:15]] + {20'b0, din[31:20]};
            3'b010: r[din[11:7]] = r[din[19:15]] < $signed({20'hFFFFF, din[31:20]}) ? 1:0;
            3'b011: r[din[11:7]] = r[din[19:15]] < ({20'hFFFFF, din[31:20]}) ? 1:0;
            3'b100: r[din[11:7]] = r[din[19:15]] ^ {20'b0, din[31:20]};
            3'b110: r[din[11:7]] = r[din[19:15]] | {20'b0, din[31:20]};
            3'b111: r[din[11:7]] = r[din[19:15]] & {20'b0, din[31:20]};
            3'b001: case (din[31:25])
                7'b0000000: r[din[11:7]] = r[din[19:15]] << din[31:20];
                default: trap = 32'b1;
            endcase
            3'b101: case (din[31:25])
                7'b0000000: r[din[11:7]] = r[din[19:15]] >> din[31:20];
                7'b0100000: r[din[11:7]] = r[din[19:15]] >>> din[31:20];
                default: trap = 32'b1;
            endcase
        endcase
    end
    else if (opcode == 7'b0110011) begin
        addr = addr + 1;
        case ({din[14:12],din[31:25]})
            10'b0000000000: begin
                            r[din[11:7]] = r[din[19:15]] + r[din[24:20]];
                            end
            10'b0000100000: begin
                            r[din[11:7]] = r[din[19:15]] - r[din[24:20]];
                            end
            10'b0010000000: begin
                            r[din[11:7]] = r[din[19:15]] << r[din[24:20]];
                            end
            10'b0100000000: begin
                            r[din[11:7]] = r[din[19:15]] < (r[din[24:20]]) ?1:0;
                            end
            10'b0110000000: begin
                            r[din[11:7]] = r[din[19:15]] < $signed(r[din[24:20]]) ?1:0;
                            end
            10'b1000000000: begin
                            r[din[11:7]] = r[din[19:15]] ^ r[din[24:20]];
                            end
            10'b1010000000: begin
                            r[din[11:7]] = r[din[19:15]] >> r[din[24:20]];
                            end
            10'b1010100000: begin
                            r[din[11:7]] = r[din[19:15]] >>> r[din[24:20]];
                            end
            10'b1100000000: begin
                            r[din[11:7]] = r[din[19:15]] | r[din[24:20]];
                            end
            10'b1110000000: begin
                            r[din[11:7]] = r[din[19:15]] & r[din[24:20]];
                            end
            default: trap = 32'b1;
        endcase
    end
    else if (opcode == 7'b0000011) begin
        addr = addr + 1;
        case (din[14:12])
            3'b000: begin
                        mem_addr = r[din[19:15]] + {20'b0, din[31:20]};
                        //read(mem_addr,temp);
                        r[din[11:7]] = {24{temp[7:0]}};
                    end
            3'b001: begin
                        mem_addr = r[din[19:15]] + {20'b0, din[31:20]};
                        if (mem_addr[1:0] == 2'b00) begin
                            //read(mem_addr,temp);
                            r[din[11:7]] = {16{temp[15:0]}};
                        end
                        else
                            trap = 32'b1;
                    end
            3'b010: begin
                        mem_addr = r[din[19:15]] + {20'b0, din[31:20]};
                        if (mem_addr[3:0] == 4'b0000) begin
                            //read(mem_addr,temp);
                            r[din[11:7]] = temp;
                        end
                        else
                            trap = 32'b1;
                    end
            3'b100: begin
                        mem_addr = r[din[19:15]] + {20'b0, din[31:20]};
                        //read(mem_addr,temp);
                        r[din[11:7]] = {24'b0,temp[7:0]};
                    end
            3'b101: begin
                        mem_addr = r[din[19:15]] + {20'b0, din[31:20]};
                        if (mem_addr[1:0] == 2'b00) begin
                            //read(mem_addr,temp);
                            r[din[11:7]] = {16'b0,temp[15:0]};
                        end
                        else
                            trap = 32'b1;
                    end
            default: trap = 32'b1;
        endcase
    end
    else if (opcode == 7'b0100011) begin
        case (din[14:12])
            3'b000: mem_addr = r[din[19:15]] + {20'b0, din[31:25], din[11:7]};
                    //write(mem_addr, r[din[24:20]][7:0]);
            3'b001: begin
                        mem_addr = r[din[19:15]] + {20'b0, din[31:25], din[11:7]};
                        if (mem_addr[1:0] == 2'b00) begin
                            //write(mem_addr, r[din[24:20]][15:0]);
                        end
                        else
                            trap = 32'b1;
                    end
            3'b010: begin
                        mem_addr = r[din[19:15]] + {20'b0, din[31:25], din[11:7]};
                        if (mem_addr[3:0] == 4'b0000) begin
                            //write(mem_addr, r[din[24:20]]);
                        end
                        else
                            trap = 32'b1;
                    end
            default: trap = 32'b1;
        endcase
        addr = addr + 1;
    end
    else if (opcode == 7'b0110111) begin
        r[din[11:7]][31:12] = din[31:12];
        addr = addr + 1;
    end
    else if (opcode == 7'b0010111) begin
        r[din[11:7]] = addr + {din[31:12],12'b0};
        addr = addr + 1;
    end
    else if (opcode == 7'b1100011) begin
        case (din[14:12])
            3'b000: begin
                        if ( $signed(r[din[19:15]]) == $signed(r[din[24:20]])) begin
                            addr = addr + $signed({din[31], din[7], din[30:25], din[11:8], 4'b0});
                        end
                    end
            3'b001: begin
                        if ( $signed(r[din[19:15]]) != $signed(r[din[24:20]])) begin
                            addr = addr + $signed({din[31], din[7], din[30:25], din[11:8], 4'b0});
                        end
                    end
            3'b100: begin
                        if ( $signed(r[din[19:15]]) < $signed(r[din[24:20]])) begin
                            addr = addr + $signed({din[31], din[7], din[30:25], din[11:8], 4'b0});
                        end
                    end
            3'b101: begin
                        if ( $signed(r[din[19:15]]) >= $signed(r[din[24:20]])) begin
                            addr = addr + $signed({din[31], din[7], din[30:25], din[11:8], 4'b0});
                        end
                    end
            3'b110: begin
                        if ( r[din[19:15]] < r[din[24:20]]) begin
                            addr = addr + $signed({din[31], din[7], din[30:25], din[11:8], 4'b0});
                        end
                    end
            3'b111: begin
                        if ( r[din[19:15]] >= r[din[24:20]])
                        begin
                            addr = addr + $signed({din[31], din[7], din[30:25], din[11:8], 4'b0});
                        end
                    end
            default: trap = 32'b1;
        endcase
    end
    else if (opcode == 7'b1101111) begin
        r[din[11:7]] = addr + 4;
        addr = addr + $signed({din[31], din[19:12], din[20], din[30:21], 1'b0});
    end
    else if (opcode == 7'b1100111) begin
        r[din[11:7]] = addr + 4;
        addr = r[din[19:15]] + $signed({din[31], din[19:12], din[20], din[30:21], 1'b0});
    end
    else
        trap = 32'b1;
end

endmodule
