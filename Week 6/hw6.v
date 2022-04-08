module hw6(sub, a, b, s, cout);

	input sub;
	input [3:0] a;
	input [3:0] b;

	// Output Port(s)
	output cout;
	output [3:0] s;

	wire [3:0] bTO4bits;
	
	assign bTO4bits = b xor {4{sub}};
	
	adder4bit adder4_bit(a, bTO4bits, sub, s, cout);
	
endmodule

module adder4bit(a, b, cin, s, cout);

	// Input Port(s)
	input cin;
	input [3:0] a;
	input [3:0] b;

	// Output Port(s)
	output [3:0] s;
	output cout;
	
	wire f1TOf2, f2TOf3, f3TOf4;
	
	fulladder fa1_LSB	(a[0], b[0], cin, s[0], f1TOf2);
	fulladder fa2		(a[1], b[1], f1TOf2, s[1], f2TOf3);
	fulladder fa3		(a[2], b[2], f2TOf3, s[2], f3TOf4);
	fulladder fa4_MSB	(a[3], b[3], f3TOf4, s[3], cout);

endmodule

module fulladder(a, b, cin, sum, cout);

	// Input Port(s)
	input a, b, cin;

	// Output Port(s)
	output sum, cout;

	assign {cout, sum} = a + b + cin;
	
endmodule
