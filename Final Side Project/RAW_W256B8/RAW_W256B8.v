`include "RAM_W16B8.v"

module RAM_W256B8(clk, RW, EN, Address, Data_In, Data_Out);

	parameter AddressDepth = 8; 				// 儲存深度 2^8 = 256
	parameter DataWide = 8; 					// 位元寬度 8 bits

	input clk; 										// 輸入時脈
	input RW; 										// 讀寫
	input EN;										// 致能
	input [AddressDepth - 1:0] Address;		// 位址深度
	input [DataWide - 1:0] Data_In;			// 資料輸入線

	output reg [DataWide - 1:0] Data_Out;	// 資料輸出線
	
	// 各晶片連接輸出線
	wire [DataWide - 1:0] Data_Out_00;
	wire [DataWide - 1:0] Data_Out_01;
	wire [DataWide - 1:0] Data_Out_02;
	wire [DataWide - 1:0] Data_Out_03;
	wire [DataWide - 1:0] Data_Out_04;
	wire [DataWide - 1:0] Data_Out_05;
	wire [DataWide - 1:0] Data_Out_06;
	wire [DataWide - 1:0] Data_Out_07;
	wire [DataWide - 1:0] Data_Out_08;
	wire [DataWide - 1:0] Data_Out_09;
	wire [DataWide - 1:0] Data_Out_10;
	wire [DataWide - 1:0] Data_Out_11;
	wire [DataWide - 1:0] Data_Out_12;
	wire [DataWide - 1:0] Data_Out_13;
	wire [DataWide - 1:0] Data_Out_14;
	wire [DataWide - 1:0] Data_Out_15;
	
	// 狀態變數宣告
	localparam CS00 = 4'b0000;
	localparam CS01 = 4'b0001;
	localparam CS02 = 4'b0010;
	localparam CS03 = 4'b0011;
	localparam CS04 = 4'b0100;
	localparam CS05 = 4'b0101;
	localparam CS06 = 4'b0110;
	localparam CS07 = 4'b0111;
	localparam CS08 = 4'b1000;
	localparam CS09 = 4'b1001;
	localparam CS10 = 4'b1010;
	localparam CS11 = 4'b1011;
	localparam CS12 = 4'b1100;
	localparam CS13 = 4'b1101;
	localparam CS14 = 4'b1110;	
	localparam CS15 = 4'b1111;	
	
	// 16組RAM連接
	RAM_W16B8 RAM_W16B8_00(clk, RW, {!Address[7], !Address[6], !Address[5], !Address[4]}, Address, Data_In, Data_Out_00);
	RAM_W16B8 RAM_W16B8_01(clk, RW, {!Address[7], !Address[6], !Address[5],  Address[4]}, Address, Data_In, Data_Out_01);
	RAM_W16B8 RAM_W16B8_02(clk, RW, {!Address[7], !Address[6],  Address[5], !Address[4]}, Address, Data_In, Data_Out_02);
	RAM_W16B8 RAM_W16B8_03(clk, RW, {!Address[7], !Address[6],  Address[5],  Address[4]}, Address, Data_In, Data_Out_03);
	RAM_W16B8 RAM_W16B8_04(clk, RW, {!Address[7],  Address[6], !Address[5], !Address[4]}, Address, Data_In, Data_Out_04);
	RAM_W16B8 RAM_W16B8_05(clk, RW, {!Address[7],  Address[6], !Address[5],  Address[4]}, Address, Data_In, Data_Out_05);
	RAM_W16B8 RAM_W16B8_06(clk, RW, {!Address[7],  Address[6],  Address[5], !Address[4]}, Address, Data_In, Data_Out_06);
	RAM_W16B8 RAM_W16B8_07(clk, RW, {!Address[7],  Address[6],  Address[5],  Address[4]}, Address, Data_In, Data_Out_07);
	RAM_W16B8 RAM_W16B8_08(clk, RW, { Address[7], !Address[6], !Address[5], !Address[4]}, Address, Data_In, Data_Out_08);
	RAM_W16B8 RAM_W16B8_09(clk, RW, { Address[7], !Address[6], !Address[5],  Address[4]}, Address, Data_In, Data_Out_09);
	RAM_W16B8 RAM_W16B8_10(clk, RW, { Address[7], !Address[6],  Address[5], !Address[4]}, Address, Data_In, Data_Out_10);
	RAM_W16B8 RAM_W16B8_11(clk, RW, { Address[7], !Address[6],  Address[5],  Address[4]}, Address, Data_In, Data_Out_11);
	RAM_W16B8 RAM_W16B8_12(clk, RW, { Address[7],  Address[6], !Address[5], !Address[4]}, Address, Data_In, Data_Out_12);
	RAM_W16B8 RAM_W16B8_13(clk, RW, { Address[7],  Address[6], !Address[5],  Address[4]}, Address, Data_In, Data_Out_13);
	RAM_W16B8 RAM_W16B8_14(clk, RW, { Address[7],  Address[6],  Address[5], !Address[4]}, Address, Data_In, Data_Out_14);
	RAM_W16B8 RAM_W16B8_15(clk, RW, { Address[7],  Address[6],  Address[5],  Address[4]}, Address, Data_In, Data_Out_15);
	
	always@(Address[7:4]) begin

		if(!EN) begin 
			Data_Out <= 8'bz;
		end
		else begin 
			case(Address[7:4])
				CS00: Data_Out <= Data_Out_00;
				CS01: Data_Out <= Data_Out_01;
				CS02: Data_Out <= Data_Out_02;
				CS03: Data_Out <= Data_Out_03;
				CS04: Data_Out <= Data_Out_04;
				CS05: Data_Out <= Data_Out_05;
				CS06: Data_Out <= Data_Out_06;
				CS07: Data_Out <= Data_Out_07;
				CS08: Data_Out <= Data_Out_08;
				CS09: Data_Out <= Data_Out_09;
				CS10: Data_Out <= Data_Out_10;
				CS11: Data_Out <= Data_Out_11;
				CS12: Data_Out <= Data_Out_12;
				CS13: Data_Out <= Data_Out_13;
				CS14: Data_Out <= Data_Out_14;
				CS15: Data_Out <= Data_Out_15;
				default: Data_Out <= 8'bz; 
			endcase
		end
	end
endmodule
