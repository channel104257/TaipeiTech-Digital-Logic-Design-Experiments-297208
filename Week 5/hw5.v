module hw5(a, b, cin, sum, cout);

	// Input Port(s)
	input a, b, cin;

	// Output Port(s)
	output sum, cout;
	
	wire summary, carry, carryTocout;
	
	assign cout = carry | carryTocout;
	
	halfadder ha1(a, b, summary, carry);
	halfadder ha2(summary, cin, sum, carryTocout);
	

endmodule

module halfadder(a, b, sum, cout);

	// Input Port(s)
	input a, b;

	// Output Port(s)
	output sum, cout;

	assign {cout, sum} = a + b; 

endmodule
