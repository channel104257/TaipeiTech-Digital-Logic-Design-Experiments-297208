module hw3_1(

	input [3:0] a,
	output [4:0] OA

);

	assign OA [4:1] = a [3:0];
	assign OA [0] = ~(a[0] ^ a[1] ^ a[2] ^ a[3]);

endmodule
