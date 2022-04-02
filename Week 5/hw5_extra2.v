module hw5_extra2(a, b, OutA, OutB, OutS, cout);

	// Input Port(s)
	input [3:0] a;
	input [3:0] b;

	// Output Port(s)
	output [6:0] OutA;
	output [6:0] OutB;
	output [6:0] OutS;
	output cout;
	
	wire f1TOf2, f2TOf3, f3TOf4;
	wire [3:0] s;
	
	fulladder fa1_LSB	(a[0], b[0], 0, s[0], f1TOf2);
	fulladder fa2		(a[1], b[1], f1TOf2, s[1], f2TOf3);
	fulladder fa3		(a[2], b[2], f2TOf3, s[2], f3TOf4);
	fulladder fa4_MSB	(a[3], b[3], f3TOf4, s[3], cout);
	
	mydecoder decoderA(a, OutA);
	mydecoder decoderB(b, OutB);
	mydecoder decoderS(s, OutS);

endmodule

module fulladder(a, b, cin, sum, cout);

	// Input Port(s)
	input a, b, cin;

	// Output Port(s)
	output sum, cout;

	assign {cout, sum} = a + b + cin;
	
endmodule

module mydecoder (input [3:0] in, output reg [6:0] Out);

	always@(in)
	begin
	
		case(in)
			4'b0000:     Out <= 7'b000_0001; // 0
			4'b0001:     Out <= 7'b100_1111; // 1
			4'b0010:     Out <= 7'b001_0010; // 2
			4'b0011:     Out <= 7'b000_0110; // 3
			4'b0100:     Out <= 7'b100_1100; // 4
			4'b0101:     Out <= 7'b010_0100; // 5
			4'b0110:     Out <= 7'b110_0000; // 6
			4'b0111:     Out <= 7'b000_1111; // 7
			4'b1000:     Out <= 7'b000_0000; // 8
			4'b1001:     Out <= 7'b000_1100; // 9
			4'b1010:     Out <= 7'b000_1000; // A
			4'b1011:     Out <= 7'b110_0000; // b
			4'b1100:     Out <= 7'b011_0001; // C
			4'b1101:     Out <= 7'b100_0010; // d
			4'b1110:     Out <= 7'b011_0000; // E
			4'b1111:     Out <= 7'b011_1000; // F
		endcase
	
	end
endmodule
