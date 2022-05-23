module FILO_tb;

	parameter AddressDepth = 4; 						// 儲存深度 2^4 = 16
	parameter DataWide = 8; 							// 位元寬度 8 bits

	reg clk = 1'b0;										// 輸入時脈
	reg CS;													// 晶片致能
	reg rst;													// 重置
	reg Push_Pop;											// 插入刪除控制線 Push = '1' Pop = '0'
	reg [DataWide - 1:0] Data_In;						// 資料輸入線

	wire Full;												// 滿佇列
	wire Empty;												// 空佇列
	wire [DataWide - 1:0] Data_Out;					// 資料輸出線
	
	FILO Stack(clk, CS, rst, Push_Pop, Data_In, Data_Out, Full, Empty);
	
	integer i;
	
	always #5 clk = ~clk;
	
	initial begin
	
	$monitor("time = %0t, rst = %b, CS = %b, Push_Pop = %b", $time, rst, CS, Push_Pop);
	
	/*------ rst = '0' ------*/
	$display("- rst = 0 \n");
	{rst, CS, Push_Pop} = 3'b0xx;
	$display("Full = %b, Empty = %b", Full, Empty);
	$display("Data_In = %h, Data_Out = %h", Data_In, Data_Out);
	#20;
	$display("\n");
	
	/*------ CS = '0' ------*/
	$display("- CS = 0 \n");
	{rst, CS, Push_Pop} = 3'b10x; 
	$display("Data_In = %h, Data_Out = %h", Data_In, Data_Out);
	#20;
	$display("\n");
	
	/*----- Pop - Empty Stack -----*/
	$display("- Pop - Empty Stack \n");
	{rst, CS, Push_Pop} = 3'b110; 
	$display("Data_Out = %h", Data_Out);
	#10;
	$display("\n");
	
	/*----- Push - Empty Stack to Full -----*/
	$display("- Push - Empty Stack to Full \n");
	{rst, CS, Push_Pop} = 3'b111;
	for(i = 0; i < 15; i = i + 1) 
		begin 
			Data_In = i;
			$display("Data_In = %h, Data_Out = %h", Data_In, Data_Out);
			#10;
		end
		
	$display("\n");
	
	/*----- Push - Full Stack -----*/
	$display("- Push - Full Stack \n");
	{rst, CS, Push_Pop} = 3'b111; 
	Data_In = i + 1;
	$display("Data_In = %h, Data_Out = %h", Data_In, Data_Out);
	#10;
	
	$display("\n");
	
	/*----- Pop - Full Stack to Empty -----*/
	$display("- Pop - Full Stack to Empty \n");
	{rst, CS, Push_Pop} = 3'b110;
	for(i = 0; i < 15; i = i + 1) 
		begin 
			$display("Data_In = %h, Data_Out = %h", Data_In, Data_Out);
			#10;
		end
		
	$finish;
	end
endmodule