module unclockedLatch(
		 input S, R,
		 output C
		 );
		 
	reg A, B;
	wire D, E;
	
	// digital logic operations on FF output
	assign C = A ^ B;
	assign D = ~(C ^ A);
	assign E = C ^ B;
	
	// Set FF
	always @(posedge S) begin
		A = D;
	end
	
	// Reset FF
	always @(posedge R) begin
		B = E;
	end

endmodule
