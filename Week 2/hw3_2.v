module hw3_2 (

	input [3:0] a,
	input [1:0] select,
	output reg y);
	
	always@(a or select)
	
		begin
			case(select)
				
				2'b00 : y = a[0];
				2'b01 : y = a[1];
				2'b10 : y = a[2];
				2'b11 : y = a[3];

			endcase
		end
		
endmodule
