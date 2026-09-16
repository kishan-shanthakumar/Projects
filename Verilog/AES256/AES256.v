/*module AES256(inp_addr,inp_dat,key_addr,key,start,clko,outp_addr,outp);
	output reg [3:0] inp_addr; // 16 bytes
	input [7:0] inp_dat;
	output reg [4:0] key_addr; // 32 bytes
	input [7:0] key_dat;
	input start;
	output reg clko;
	output reg [3:0] outp_addr; //16 bytes
	output reg [7:0] outp_dat;
	
	reg [127:0] inp;
	wire [127:0] inpw = inp;
	reg [255:0] key;
	reg [127:0] out_str;
	reg [1919:0] exp_key;
	wire [1919:0] keyw = exp_key;*/

module AES256(inp,key,out_str);
	input [127:0] inp;
	input [255:0] key;
	output [127:0] out_str;
	wire [1919:0] exp_key;
	
	key_exp u01(key,exp_key);
	
	wire [127:0] temp1;
	add_round_key u11(inp, exp_key[1919-:128], temp1);
	
	wire [127:0] temp2;
	byte_sub u21(temp1, temp2);
	wire [127:0] temp3;
	shift_row u22(temp2, temp3);
	wire [127:0] temp4;
	mix_column u23(temp3, temp4);
	wire [127:0] temp5;
	add_round_key u24(temp4, exp_key[1791-:128], temp5);
	
	wire [127:0] temp6;
	byte_sub u31(temp5, temp6);
	wire [127:0] temp7;
	shift_row u32(temp6, temp7);
	wire [127:0] temp8;
	mix_column u33(temp7, temp8);
	wire [127:0] temp9;
	add_round_key u34(temp8, exp_key[1663-:128], temp9);
	
	wire [127:0] temp10;
	byte_sub u41(temp9, temp10);
	wire [127:0] temp11;
	shift_row u42(temp10, temp11);
	wire [127:0] temp12;
	mix_column u43(temp11, temp12);
	wire [127:0] temp13;
	add_round_key u44(temp12, exp_key[1535-:128], temp13);

	wire [127:0] temp14;
	byte_sub u51(temp13, temp14);
	wire [127:0] temp15;
	shift_row u52(temp14, temp15);
	wire [127:0] temp16;
	mix_column u53(temp15, temp16);
	wire [127:0] temp17;
	add_round_key u54(temp16, exp_key[1407-:128], temp17);

	wire [127:0] temp18;
	byte_sub u61(temp17, temp18);
	wire [127:0] temp19;
	shift_row u62(temp18, temp19);
	wire [127:0] temp20;
	mix_column u63(temp19, temp20);
	wire [127:0] temp21;
	add_round_key u64(temp20, exp_key[1279-:128], temp21);

	wire [127:0] temp22;
	byte_sub u71(temp21, temp22);
	wire [127:0] temp23;
	shift_row u72(temp22, temp23);
	wire [127:0] temp24;
	mix_column u73(temp23, temp24);
	wire [127:0] temp25;
	add_round_key u74(temp24, exp_key[1151-:128], temp25);

	wire [127:0] temp26;
	byte_sub u81(temp25, temp26);
	wire [127:0] temp27;
	shift_row u82(temp26, temp27);
	wire [127:0] temp28;
	mix_column u83(temp27, temp28);
	wire [127:0] temp29;
	add_round_key u84(temp28, exp_key[1023-:128], temp29);

	wire [127:0] temp30;
	byte_sub u91(temp29, temp30);
	wire [127:0] temp31;
	shift_row u92(temp30, temp31);
	wire [127:0] temp32;
	mix_column u93(temp31, temp32);
	wire [127:0] temp33;
	add_round_key u94(temp32, exp_key[895-:128], temp33);

	wire [127:0] temp34;
	byte_sub u101(temp33, temp34);
	wire [127:0] temp35;
	shift_row u102(temp34, temp35);
	wire [127:0] temp36;
	mix_column u103(temp35, temp36);
	wire [127:0] temp37;
	add_round_key u104(temp36, exp_key[767-:128], temp37);

	wire [127:0] temp38;
	byte_sub u111(temp37, temp38);
	wire [127:0] temp39;
	shift_row u112(temp38, temp39);
	wire [127:0] temp40;
	mix_column u113(temp39, temp40);
	wire [127:0] temp41;
	add_round_key u114(temp40, exp_key[639-:128], temp41);

	wire [127:0] temp42;
	byte_sub u121(temp41, temp42);
	wire [127:0] temp43;
	shift_row u122(temp42, temp43);
	wire [127:0] temp44;
	mix_column u123(temp43, temp44);
	wire [127:0] temp45;
	add_round_key u124(temp44, exp_key[511-:128], temp45);

	wire [127:0] temp46;
	byte_sub u131(temp45, temp46);
	wire [127:0] temp47;
	shift_row u132(temp46, temp47);
	wire [127:0] temp48;
	mix_column u133(temp47, temp48);
	wire [127:0] temp49;
	add_round_key u134(temp48, exp_key[383-:128], temp49);

	wire [127:0] temp50;
	byte_sub u141(temp49, temp50);
	wire [127:0] temp51;
	shift_row u142(temp50, temp51);
	wire [127:0] temp52;
	mix_column u143(temp51, temp52);
	wire [127:0] temp53;
	add_round_key u144(temp52, exp_key[255-:128], temp53);
	
	wire [127:0] temp54;
	shift_row u152(temp53, temp54);
	wire [127:0] temp55;
	mix_column u153(temp54, temp55);
	wire [127:0] temp56;
	add_round_key u154(temp55, exp_key[127-:128], out_str);
	
	

endmodule
