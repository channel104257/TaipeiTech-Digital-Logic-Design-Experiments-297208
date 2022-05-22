module FIFO(clk, CS, rst, Insert_Delete, Data_In, Data_Out, Full, Empty);

	parameter AddressDepth = 4; 							// 儲存深度 2^4 = 16
	parameter DataWide = 8; 								// 位元寬度 8 bits

	input clk;													// 輸入時脈
	input CS;													// 晶片致能
	input rst;													// 重置
	input	Insert_Delete;										// 插入刪除控制線 Insert = '1' Delete = '0'
	input [DataWide - 1:0] Data_In;						// 資料輸入線

	output reg Full;											// 滿佇列
	output reg Empty;											// 空佇列
	output reg [DataWide - 1:0] Data_Out;				// 資料輸出線
		
	reg [DataWide - 1:0] RAM_Data[15:0];				// RAM占存陣列
	reg [AddressDepth - 1:0] headPtr = 4'b0000;		// 前指標
	reg [AddressDepth - 1:0] tailPtr = 4'b0000;		// 後指標(資料寫入指標)
	
	always@(posedge clk) begin
	
		case({rst, CS, Insert_Delete})
		3'b0xx: // 若 rst 為 '0'
			begin 
				headPtr <= 4'b0;
				tailPtr <= 4'b0;
				Full <= 1'b0;
				Empty <= 1'b1;
				Data_Out <= 8'bz;
			end
		3'b10x: // 若 CS 為 '0'
			begin 
				Data_Out <= 8'bz;
			end
		3'b110: // Delete Mode
			begin 	
				if(headPtr == tailPtr) begin 
					Full <= 1'b0;
					Empty <= 1'b1;
					Data_Out <= 8'bz;
				end
				else begin
					Full <= 1'b0;
					Empty <= 1'b0;
					Data_Out <= RAM_Data[headPtr % 16];
					headPtr = (headPtr + 1) % 16;
				end
			end
		3'b111: // Insert Mode
			begin 	
				if((tailPtr + 1) % 16 == headPtr) begin 
					Full <= 1'b1;
					Empty <= 1'b0;
				end
				else begin
					Full <= 1'b0;
					Empty <= 1'b0;
					RAM_Data[tailPtr % 16] <= Data_In;
					tailPtr = (tailPtr + 1) % 16;
				end
			end
		default: 
			begin 
				Data_Out <= 8'bz;
			end
		endcase
	end
endmodule
