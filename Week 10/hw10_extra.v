module hw10_extra(clk, rst, In_Data, Out_Data);

	// Input Port(s)
	input clk, rst;
	input In_Data;

	// Output Port(s)
	output reg Out_Data;
	
	reg [3:0] cur_state, next_state;

	// Parameter Declaration(s)
	localparam s0 = 3'd0;
	localparam s1 = 3'd1;
	localparam s2 = 3'd2;
	localparam s3 = 3'd3;
	localparam s4 = 3'd4;

	// 設定rst為低態觸發
	always @(posedge clk or negedge rst) begin
	
		// rst輸入為0
		if(!rst)
			// 將當前狀態設定為s0
			cur_state <= s0;
		else
			// 將當前狀態設定為讀入的次態
			cur_state <= next_state;
	end
	
	always @(*) begin
		// 讀取當前狀態
		case(cur_state)
		
			// 當前狀態為s0
			s0: begin			
				if(In_Data) next_state = s1;
				else next_state = s0;
			end
			
			// 當前狀態為s1
			s1: begin			
				if(In_Data) next_state = s3;
				else next_state = s2;
			end
			
			// 當前狀態為s2
			s2: begin			
				if(In_Data) next_state = s3;
				else next_state = s0;
			end
			
			// 當前狀態為s3
			s3: begin			
				if(In_Data) next_state = s3;
				else next_state = s4;
			end
			
			// 當前狀態為s4
			s4: begin			
				if(In_Data) next_state = s3;
				else next_state = s0;
			end
		endcase
	end
	
	always@(cur_state) begin
	
		if(!rst) 
			Out_Data <= 1'b0;		
		else begin
			case(cur_state)
			
				s0: begin			
					Out_Data <= 1'b0;
				end
				
				s1: begin			
					Out_Data <= 1'b0;
				end
				
				s2: begin			
					Out_Data <= 1'b0;
				end
				
				s3: begin			
					if(In_Data) Out_Data <= 1'b1;
					else Out_Data <= 1'b0;
				end
				
				s4: begin			
					if(In_Data) Out_Data <= 1'b1;
					else Out_Data <= 1'b0;
				end
				
			endcase
		end
	end

endmodule
