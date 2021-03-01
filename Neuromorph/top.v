module top (

	input clk,
	input en,
	input reset,
	
	input [7:0] ADC_code,
	
	output [7:0] DAC_code_fast [3:0],
	
	output [7:0] DAC_code [9:0]

	)
	
	
	sys_control SC1 (	.clk(clk), .set(done_process), .load_weights(load_weights), .load_data(load_data), 
							.load_read_data(load_read_data));
							
	
	memory M1 (	.clk(clk), .load_weights(load_weights), .load_data(load_data), .load_read_data(load_read_data), 
					.data_read(PCIe_data_in), .data_write(PCIe_data_out), .weights_out(PIN_weights), .data_out(PN_data), 
					.ADC_in(ADC_data));
					
	
	DAC_control  #(.NUM_DACS(10), .DATA_WIDTH(80)) DAC1 (.clk(clk), .data_in(PIN_weights), .data_out(DAC_code));
	DAC_control  #(.NUM_DACS(4), .DATA_WIDTH(32)) DAC2 (.clk(clk), .data_in(PN_data), .data_out(DAC_code_fast));

	
	ADC control ADC1 (.clk(clk), .data_in(ADC_code), .data_out(ADC_data));
	
	
endmodule	