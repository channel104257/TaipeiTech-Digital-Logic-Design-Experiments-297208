module FILO(clk, CS, rst, Push_Pop, Data_In, Data_Out, Full, Empty);

	parameter AddressDepth = 4; 							// 儲存深度 2^4 = 16
	parameter DataWide = 8; 								// 位元寬度 8 bits

	input clk;													// 輸入時脈
	input CS;													// 晶片致能
	input rst;													// 重置
	input	Push_Pop;											// 推入推出控制線 Push = '1' Pop = '0'
	input [DataWide - 1:0] Data_In;						// 資料輸入線

	output reg Full;											// 滿佇列
	output reg Empty;											// 空佇列
	output reg [DataWide - 1:0] Data_Out;				// 資料輸出線
		
	reg [DataWide - 1:0] RAM_Data[15:0];				// RAM占存陣列
	reg [AddressDepth - 1:0] TopPtr = 4'b0000;		// 前指標
	
	always@(posedge clk) begin
	
		case({rst, CS, Push_Pop})
		3'b0xx: // 若 rst 為 '0'
			begin 
				TopPtr <= 4'b0000;
				Full <= 1'b0;
				Empty <= 1'b1;
				Data_Out <= 8'bz;
			end
		3'b10x: // 若 CS 為 '0'
			begin 
				Data_Out <= 8'bz;
			end
		3'b110: // Pop Mode
			begin 	
				if(TopPtr == 4'b0) begin 
					Full <= 1'b0;
					Empty <= 1'b1;
					Data_Out <= 8'bz;
				end
				else begin
					Full <= 1'b0;
					Empty <= 1'b0;
					Data_Out <= RAM_Data[TopPtr];
					TopPtr = TopPtr - 1;
				end
			end
		3'b111: // Push Mode
			begin 	
				if(TopPtr == 4'b1) begin 
					Full <= 1'b1;
					Empty <= 1'b0;
				end
				else begin
					Full <= 1'b0;
					Empty <= 1'b0;
					RAM_Data[TopPtr] <= Data_In;
					TopPtr = TopPtr + 1;
				end
			end
		default: 
			begin 
				Data_Out <= 8'bz;
			end
		endcase
	end
endmodule
