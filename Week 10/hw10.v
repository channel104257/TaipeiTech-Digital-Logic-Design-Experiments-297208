module hw10(tin, clk, rst_n, q);

	localparam s0   = 1'b0;
	localparam s1   = 1'b1;

	// Input Port(s)
	input tin;
	input clk;
	input rst_n;

	// Output Port(s)
	output reg q;
	
	reg cur_state, next_state;

	always @(posedge clk or posedge rst_n) begin
		if(rst_n)
			cur_state <= s0;
		else
			cur_state <= next_state;
	end
	
	always @(cur_state or tin) begin
	
		case(cur_state)
		
			s0: begin			
				next_state = s1;		
			end
			
			s1: begin			
				if(tin) next_state = s1;
				else next_state = s0;
			end
		endcase
	end
	
	always@(cur_state)begin
	
		if(rst_n) 
			q <= 1'b0;		
		else begin
			case(cur_state)
				s0:    q <= 1'b0;
				s1:    q <= 1'b1;
			endcase
		end
	end
endmodule
