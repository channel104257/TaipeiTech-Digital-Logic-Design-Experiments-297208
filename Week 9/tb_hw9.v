module tb_hw9_basic;

	wire q;
	reg clk;
	reg clr;
	reg t;
	
	integer i;
	reg [4:0] dly;
	
	hw9_basic tff(t, clk, clr, q);
	
	always #5 clk = ~clk;
	
	initial begin
		{clr, clk, t} <= 0;
	
		$monitor("T=%0t, clr=%0b, t=%0d, q=%0d", $time, clr, t, q);
		repeat(2)@(posedge clk);
		clr <= 1;
	
		for(i = 0; i < 20 ; i = i + 1) begin
			dly = $random;
			#(dly) t <= $random;
		end
		
		#20 $finish;
	end
endmodule
