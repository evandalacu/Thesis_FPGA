module top(
    // Input Vectors
    input clk, en,              // System-wide core clock (200 MHz) and enable
    input reset,                 // System-wide reset 
                                // (start counters for 8 MHz and 1 MHz pulse generation)
    input clkA, clkB,           // Clock A (80 MHz) and clock B (81 MHz)

    input [12:0] W,             // Input pulse width vector
    input load,                 // loading new pulse width W

    // Output Vectors
    output PWMreset, PWMset,    // Signal set and reset signal 
    output signal,    // Output PWM pulse signal
    
    // Useful signals for debugging
    output [6:0] cA, cB,        // counter values for counter A and counter B 
    output en_8MHz, en_1MHz,    // Enable toggle at 8MHz and 1MHz
    output [6:0] A_val, B_val,  // Decoded A value and B value

    // Intermediate vectors to be removed
    output decoderDone,          // signal when decoder is done
    output [4:0] c1,c2         // counter values for enable at 8MHz and 1MHz (to be removed)
	 
	 // added as outputs for debugging -E
	 //output debugA, debugB, debugD, debugE
);

    // Generate enable signals at 8 MHz and 1 MHz
    gen8MHz G8 (.clk(clk),.load(reset), .en(en), .en_8MHz(en_8MHz), .c1(c1)); 
    gen1MHz G1 (.clk(clk),.load(reset), .en(en), .en_8MHz(en_8MHz), .en_1MHz(en_1MHz),  .c1(c1), .c2(c2)); 

    // Decode W to A and B
    decoder D0 (.clk(clk), .reset(load), .W(W), .A(A_val), .B(B_val), .done(decoderDone));
      
    // Generate PWM based on A and B values
    gen_PWM P0 (.en(en & decoderDone),
                .clkZ(en_1MHz), .clkA(clkA), .clkB(clkB), .clkCore(clk),
                .A_val(A_val), .B_val(B_val), .PWMset(PWMset), .PWMreset(PWMreset), .signal(signal),
                .reset(load),
                .cA(cA), .cB(cB)//, .debugA(debugA), .debugB(debugB), .debugD(debugD), .debugE(debugE)
                );
endmodule
