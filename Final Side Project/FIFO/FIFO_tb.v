module FIFO_tb;

	parameter AddressDepth = 4; 						// 儲存深度 2^4 = 16
	parameter DataWide = 8; 							// 位元寬度 8 bits

	reg clk = 1'b0;										// 輸入時脈
	reg CS;													// 晶片致能
	reg rst;													// 重置
	reg Insert_Delete;									// 插入刪除控制線 Insert = '1' Delete = '0'
	reg [DataWide - 1:0] Data_In;						// 資料輸入線

	wire Full;												// 滿佇列
	wire Empty;												// 空佇列
	wire [DataWide - 1:0] Data_Out;					// 資料輸出線
	
	FIFO Stack(clk, CS, rst, Insert_Delete, Data_In, Data_Out, Full, Empty);
	
	integer i;
	
	always #5 clk = ~clk;
	
	initial begin
	
	$monitor("time = %0t, rst = %b, CS = %b, Insert_Delete = %b", $time, rst, CS, Insert_Delete);
	
	/*------ rst = '0' ------*/
	$display("- rst = 0 \n");
	{rst, CS, Insert_Delete} = 3'b0xx;
	$display("Full = %b, Empty = %b", Full, Empty);
	$display("Data_In = %h, Data_Out = %h", Data_In, Data_Out);
	#20;
	$display("\n");
	
	/*------ CS = '0' ------*/
	$display("- CS = 0 \n");
	{rst, CS, Insert_Delete} = 3'b10x; 
	$display("Data_In = %h, Data_Out = %h", Data_In, Data_Out);
	#20;
	$display("\n");
	
	/*----- Delete - Empty Queue -----*/
	$display("- Delete - Empty Queue \n");
	{rst, CS, Insert_Delete} = 3'b110; 
	$display("Data_Out = %h", Data_Out);
	#10;
	$display("\n");
	
	/*----- Insert - Empty Queue to Full -----*/
	$display("- Insert - Empty Queue to Full \n");
	{rst, CS, Insert_Delete} = 3'b111;
	for(i = 0; i < 15; i = i + 1) 
		begin 
			Data_In = i;
			$display("Data_In = %h, Data_Out = %h", Data_In, Data_Out);
			#10;
		end
		
	$display("\n");
	
	/*----- Insert - Full Queue -----*/
	$display("- Insert - Full Queue \n");
	{rst, CS, Insert_Delete} = 3'b111; 
	Data_In = i + 1;
	$display("Data_In = %h, Data_Out = %h", Data_In, Data_Out);
	#10;
	
	$display("\n");
	
	/*----- Delete - Full Queue to Empty -----*/
	$display("- Delete - Full Queue to Empty \n");
	{rst, CS, Insert_Delete} = 3'b110;
	for(i = 0; i < 15; i = i + 1) 
		begin 
			$display("Data_In = %h, Data_Out = %h", Data_In, Data_Out);
			#10;
		end
		
	$finish;
	end
endmodule