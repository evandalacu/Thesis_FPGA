module downwardCounter #( parameter WIDTH = 1)
                    (
                        input clk,
                        input load,
                        input reset, // pass in 0
                        input en,
                        input [WIDTH-1 :0] limit,
                        output reg [WIDTH-1 :0] Q 
                    );
						  
	localparam max = 7'b1111111;
	
	// decrement counter
	always @(posedge clk) begin
		// load in max initial value at 1MHz freq
		if (load) Q <= limit;
		else if (Q == 7'b0) Q <= max;
		else Q <= Q - 1'b1;

	end


endmodule
