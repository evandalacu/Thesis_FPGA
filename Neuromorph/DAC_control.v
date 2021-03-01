module DAC_control #(	
	
	parameter NUM_DACS,
	parameter DATA_WIDTH
	
	)(
	
	input clk,
	input [DATA_WIDTH-1:0] data_in,
	
	output [7:0] data_out [NUM_DACS-1:0]
	
	)
	
	
	
endmodule
