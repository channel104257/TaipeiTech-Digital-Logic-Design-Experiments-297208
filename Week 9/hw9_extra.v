module hw9(a, b, c, d, e, f[1:0], clk);

	input clk;
	input a, b, d;
	output reg c, e; 
	output reg [1:0] f;

	always@(posedge clk)
	begin
		c = a | b;
		e = c & d;
		f = c + e;
	end

endmodule

