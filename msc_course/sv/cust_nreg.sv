module cust_nreg #(parameter N=4)
	(output logic [N-1:0] q,
	input logic [N-1:0] a,
	input logic clk, rst, s, enable);

logic [N-1:0] temp;

always_ff @(posedge clk, negedge rst)
	if (!rst)
		q <= 0;
	else
		begin
			if (enable)
				temp <= a;
			case (s)
				0: q <= ( q << 1 ) + temp[0];
				1: begin
					q <= {temp[N-1], {(N-2){1'b0}}};
					temp = temp << 1;
				   end
				default:;
			endcase
		end
endmodule