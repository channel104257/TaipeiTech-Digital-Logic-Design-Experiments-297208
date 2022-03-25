module hw5_extra(A, B, sel [2:0], Y);

	// Input Port(s)
	input A, B;
	input [2:0] sel;
	output reg Y;

	always@(*) begin			
		case(sel)
			3'b000: Y <= A & B;
			3'b001: Y <= A | B;
			3'b010: Y <= ~A;
			3'b011: Y <= A;
			3'b100: Y <= ~(A & B);
			3'b101: Y <= ~(A | B);
			3'b110: Y <= A ^ B;
			3'b111: Y <= ~(A ^ B);
		endcase
	end
endmodule
