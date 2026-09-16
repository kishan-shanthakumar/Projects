// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"
// CREATED		"Wed Jun 16 12:00:29 2021"

module bch(
	ibits,
	clk,
	prn,
	clr,
	sel,
	op
);


input wire	ibits;
input wire	clk;
input wire	prn;
input wire	clr;
input wire	sel;
output reg	op;

wire	SYNTHESIZED_WIRE_9;
reg	DFF_inst10;
reg	DFF_inst8;
reg	DFF_inst11;
reg	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
reg	DFF_inst5;
reg	DFF_inst6;
reg	DFF_inst7;
wire	SYNTHESIZED_WIRE_8;

assign	SYNTHESIZED_WIRE_4 = 0;



assign	SYNTHESIZED_WIRE_7 = SYNTHESIZED_WIRE_9 ^ DFF_inst10;

assign	SYNTHESIZED_WIRE_8 = SYNTHESIZED_WIRE_9 ^ DFF_inst8;


always@(posedge clk or negedge clr or negedge prn)
begin
if (!clr)
	begin
	DFF_inst10 <= 0;
	end
else
if (!prn)
	begin
	DFF_inst10 <= 1;
	end
else
	begin
	DFF_inst10 <= DFF_inst11;
	end
end


always@(posedge clk or negedge clr or negedge prn)
begin
if (!clr)
	begin
	DFF_inst11 <= 0;
	end
else
if (!prn)
	begin
	DFF_inst11 <= 1;
	end
else
	begin
	DFF_inst11 <= SYNTHESIZED_WIRE_9;
	end
end

assign	SYNTHESIZED_WIRE_6 =  ~SYNTHESIZED_WIRE_10;


always@(posedge clk or negedge clr or negedge prn)
begin
if (!clr)
	begin
	op <= 0;
	end
else
if (!prn)
	begin
	op <= 1;
	end
else
	begin
	op <= SYNTHESIZED_WIRE_3;
	end
end


\21mux 	b2v_inst14(
	.S(sel),
	.B(SYNTHESIZED_WIRE_4),
	.A(SYNTHESIZED_WIRE_5),
	.Y(SYNTHESIZED_WIRE_9));


\21mux 	b2v_inst15(
	.S(sel),
	.B(SYNTHESIZED_WIRE_6),
	.A(ibits),
	.Y(SYNTHESIZED_WIRE_3));


assign	SYNTHESIZED_WIRE_5 = ibits ^ SYNTHESIZED_WIRE_10;


always@(posedge clk or negedge clr or negedge prn)
begin
if (!clr)
	begin
	DFF_inst5 <= 0;
	end
else
if (!prn)
	begin
	DFF_inst5 <= 1;
	end
else
	begin
	DFF_inst5 <= SYNTHESIZED_WIRE_7;
	end
end


always@(posedge clk or negedge clr or negedge prn)
begin
if (!clr)
	begin
	DFF_inst6 <= 0;
	end
else
if (!prn)
	begin
	DFF_inst6 <= 1;
	end
else
	begin
	DFF_inst6 <= DFF_inst5;
	end
end


always@(posedge clk or negedge clr or negedge prn)
begin
if (!clr)
	begin
	DFF_inst7 <= 0;
	end
else
if (!prn)
	begin
	DFF_inst7 <= 1;
	end
else
	begin
	DFF_inst7 <= DFF_inst6;
	end
end


always@(posedge clk or negedge clr or negedge prn)
begin
if (!clr)
	begin
	DFF_inst8 <= 0;
	end
else
if (!prn)
	begin
	DFF_inst8 <= 1;
	end
else
	begin
	DFF_inst8 <= DFF_inst7;
	end
end


always@(posedge clk or negedge clr or negedge prn)
begin
if (!clr)
	begin
	SYNTHESIZED_WIRE_10 <= 0;
	end
else
if (!prn)
	begin
	SYNTHESIZED_WIRE_10 <= 1;
	end
else
	begin
	SYNTHESIZED_WIRE_10 <= SYNTHESIZED_WIRE_8;
	end
end


endmodule
