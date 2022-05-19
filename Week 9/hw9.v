module hw9_basic(t, clk, clr, q);

	// Input Port(s)
	input clk;
	input clr;
	input t;

	// Output Port(s)
	output reg q;

	always@(posedge clk)
	begin
		if(!clr)
			q <= 0;
		else
			if(t)
				q <= ~q;
			else
				q <= q;
	end
endmodule

