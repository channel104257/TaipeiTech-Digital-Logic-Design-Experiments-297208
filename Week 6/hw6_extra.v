module hw6_extra(a, b, seg7_a, seg7_b, seg7_compare);

	input [3:0] a;
	input [3:0] b;

	// Output Port(s)
	output [6:0] seg7_a;
	output [6:0] seg7_b;
	output [6:0] seg7_compare;
	
	wire cout;
	wire [4:0] s;
	wire [4:0] ex_a;
	wire [4:0] ex_b;
	wire [1:0] compare_sel;
	
	assign ex_a = {1'b0, a};
	assign ex_b = {{1'b0, b} ^ {5{1'b1}}};
	
	seg7 seg7_1(a, seg7_a);
	seg7 seg7_2(b, seg7_b);
	seg7_com compare(compare_sel, seg7_compare);
	
	adder5bit adder5_bit(ex_a, ex_b, 1, s, cout);
	compare_mux (s, cout, compare_sel);
	
endmodule

module adder5bit(a, b, cin, s, cout);

	// Input Port(s)
	input cin;
	input [4:0] a;
	input [4:0] b;

	// Output Port(s)
	output [4:0] s;
	output cout;
	
	wire f1TOf2, f2TOf3, f3TOf4, f4TOf5;
	
	fulladder fa1_LSB	(a[0], b[0], cin, s[0], f1TOf2);
	fulladder fa2		(a[1], b[1], f1TOf2, s[1], f2TOf3);
	fulladder fa3		(a[2], b[2], f2TOf3, s[2], f3TOf4);
	fulladder fa4		(a[3], b[3], f3TOf4, s[3], f4TOf5);
	fulladder fa5_MSB	(a[4], b[4], f4TOf5, s[4], cout);

endmodule

module fulladder(a, b, cin, sum, cout);

	// Input Port(s)
	input a, b, cin;

	// Output Port(s)
	output sum, cout;

	assign {cout, sum} = a + b + cin;
	
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

module seg7_com (input [1:0] in, output reg [6:0] Out);

	always@(in)
	begin // synopsys full_case
	
		case(in)
			2'b00:     	Out <= 7'b100_1110; // 大於
			2'b01:     	Out <= 7'b111_1000; // 小於
			2'b10:     	Out <= 7'b100_1000; // 等於
			default:		Out <= 7'b000_0000;
		endcase
	
	end
endmodule

module compare_mux (input [4:0] s, input cout, output reg [1:0] compare_sel);

	always@(s or cout)
		begin
		
			if(s == 5'b00000)
				compare_sel <= 2'b10; 
			else if(s[4] == 1)
				compare_sel <= 2'b01;
			else
				compare_sel <= 2'b00;	
		end
	
endmodule
