module hw7(a, b, seg7_a, seg7_b, seg7_s_7to4, seg7_s_3to0);

	input [3:0] a;
	input [3:0] b;

	output [6:0] seg7_a;
	output [6:0] seg7_b;
	output [6:0] seg7_s_7to4;
	output [6:0] seg7_s_3to0;

	wire [7:0] s;

	assign s = a * b;
	
	seg7 a_out(a, seg7_a);
	seg7 b_out(b, seg7_b);
	seg7 s_7to4_out(s[7:4], seg7_s_7to4);
	seg7 s_3to0_out(s[3:0], seg7_s_3to0);
	
endmodule

module seg7 (input [3:0] in, output reg [6:0] Out);

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
