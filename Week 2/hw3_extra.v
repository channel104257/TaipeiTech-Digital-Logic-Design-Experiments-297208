module hw3_extra (

	input [2:0] a,
	input [1:0] select,
	output reg y);

	wire OA;
	
	assign OA = ~(a[0] ^ a[1] ^ a[2]);
	
	always@(a or select)
		begin
		
			case(select)
				
				2'b00 : y = a[0];
				2'b01 : y = a[1];
				2'b10 : y = a[2];
				2'b11 : y = OA;
				
			endcase
		end
		
endmodule
