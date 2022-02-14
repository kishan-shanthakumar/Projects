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
// CREATED		"Fri Jun 18 23:12:36 2021"

module bch(
	ibits,
	prn,
	clrn,
	clk,
	out
);


input wire	ibits;
input wire	prn;
input wire	clrn;
input wire	clk;
output wire	out;

reg	SYNTHESIZED_WIRE_3;
reg	DFF_inst4;
reg	DFF_inst8;
wire	SYNTHESIZED_WIRE_0;
reg	DFF_inst3;
wire	SYNTHESIZED_WIRE_1;
reg	DFF_inst5;
reg	DFF_inst6;
reg	DFF_inst7;
wire	SYNTHESIZED_WIRE_2;




assign	out =  ~SYNTHESIZED_WIRE_3;

assign	SYNTHESIZED_WIRE_1 = SYNTHESIZED_WIRE_3 ^ DFF_inst4;

assign	SYNTHESIZED_WIRE_0 = SYNTHESIZED_WIRE_3 ^ ibits;

assign	SYNTHESIZED_WIRE_2 = SYNTHESIZED_WIRE_3 ^ DFF_inst8;


always@(posedge clk or negedge clrn or negedge prn)
begin
if (!clrn)
	begin
	DFF_inst3 <= 0;
	end
else
if (!prn)
	begin
	DFF_inst3 <= 1;
	end
else
	begin
	DFF_inst3 <= SYNTHESIZED_WIRE_0;
	end
end


always@(posedge clk or negedge clrn or negedge prn)
begin
if (!clrn)
	begin
	DFF_inst4 <= 0;
	end
else
if (!prn)
	begin
	DFF_inst4 <= 1;
	end
else
	begin
	DFF_inst4 <= DFF_inst3;
	end
end


always@(posedge clk or negedge clrn or negedge prn)
begin
if (!clrn)
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
	DFF_inst5 <= SYNTHESIZED_WIRE_1;
	end
end


always@(posedge clk or negedge clrn or negedge prn)
begin
if (!clrn)
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


always@(posedge clk or negedge clrn or negedge prn)
begin
if (!clrn)
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


always@(posedge clk or negedge clrn or negedge prn)
begin
if (!clrn)
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


always@(posedge clk or negedge clrn or negedge prn)
begin
if (!clrn)
	begin
	SYNTHESIZED_WIRE_3 <= 0;
	end
else
if (!prn)
	begin
	SYNTHESIZED_WIRE_3 <= 1;
	end
else
	begin
	SYNTHESIZED_WIRE_3 <= SYNTHESIZED_WIRE_2;
	end
end


endmodule
