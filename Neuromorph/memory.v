module memory (

	input clk,
	input en,
	input load_weights, load_data, load_ADC_data,
	input [111:0] data_read,
	input [7:0] ADC_in,
	
	output reg [31:0] data_out, 
	output reg [79:0] weights_out,
	output reg [7:0] data_write
	
	)
	
	reg [79:0] stored_weights;
	reg [31:0] stored_data;
	reg [7:0] stored_output;
	
	// Load new data into memory
	always @ (posedge clk) begin
		if (en) begin
			stored_weights <= data_read[111:32];
			stored_data <= data_read[31:0];
		
			stored_output <= ADC_in;
		end
	end
	
	// Load data to the PCIe or DAC controller
	always @ (posedge load_weights) begin
		weights_out <= stored_weights;
	end
	
	
	always @ (posedge load_data) begin
		data_out <= stored_data;
	end
	
	always @ (posedge load_ADC_data) begin
		data_write <= stored_output;
	end

endmodule
	
