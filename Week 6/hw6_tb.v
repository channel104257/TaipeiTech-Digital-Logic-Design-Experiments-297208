`timescale 1ns/1ps

module hw6_tb;

	reg cin;
	reg [3:0] a;
	reg [3:0] b;

	wire cout;
	wire [3:0] s;
	
	hw6 addsub4Bits(cin, a, b, s, cout);
	
	integer i;
	
	initial
		begin
		
		$display("Testing cin = 0, the adder mode.");
	
		cin = 1'b0;
	
		for(i = 0; i < 256; i = i + 1)
		begin
	
			{b, a} = i;
			#10;
			
			$display($time, "\t %b + %b = %b", a, b, s);
	
		end
		
		$display("Testing cin = 1, the subtractor mode.");
	
		cin = 1'b1;
	
		for(i = 0; i < 256; i = i + 1)
		begin
	
			{b, a} = i;
			#10;
			
			$display($time, "\t %b - %b = %b", a, b, s);
	
		end
	
	end	
endmodule