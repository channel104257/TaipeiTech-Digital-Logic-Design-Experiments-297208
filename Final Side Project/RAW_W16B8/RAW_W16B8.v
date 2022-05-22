module RAM_W16B8(clk, RW, CS, Address, Data_In, Data_Out);
	
	parameter AddressDepth = 4; 				// 儲存深度 2^4 = 16
	parameter DataWide = 8; 					// 位元寬度 8 bits

	input clk; 										// 輸入時脈
	input RW; 										// 讀寫
	input [3:0] CS;								// 晶片選擇致能
	input [AddressDepth - 1:0] Address;		// 位址深度
	input [DataWide - 1:0] Data_In;			// 資料輸入線

	output reg [DataWide - 1:0] Data_Out;	// 資料輸出線
	
	wire cs_en;										// 晶片選擇致能線 (低態致能)

	reg [DataWide - 1:0] RAM_Data[15:0];	// RAM占存陣列

	// 晶片選擇致能線全為'1'時才代表該晶片被選取
	assign cs_en = CS[0] & CS[1] & CS[2] & CS[3];
	
	// 當clk為posedge
	always@(posedge clk) begin
	
		// RW == 1'b0 為讀取
		if(!RW && cs_en) 
			// 將RAM內的資料輸出
			Data_Out <= RAM_Data[Address[3:0]];	
		else 
			// RW == 1'b1 為寫入
			if(RW && cs_en) 
				// 將資料寫入RAM內
				RAM_Data[Address[3:0]] <= Data_In;	
			else
				// 將輸出作為高阻抗
				Data_Out <= 8'bz;		
	end
endmodule
