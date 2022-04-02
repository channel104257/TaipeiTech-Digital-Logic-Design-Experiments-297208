module hw3_extra (

	input [2:0] a,
	input [1:0] select,
	output y);

	wire OA;
	
	odd_parity_generator OPG(a, OA);
	mux4to1 mux({OA, a}, select, y);
		
endmodule

module odd_parity_generator(
	input [3:0] a,
	output [4:0] OA
);

	assign OA [4:1] = a [3:0];
	assign OA [0] = ~(a[0] ^ a[1] ^ a[2] ^ a[3]);

endmodule

module mux4to1 (

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