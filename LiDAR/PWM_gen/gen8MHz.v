module gen8MHz(
    input clk,      // 200 MHz core clock
    input load,     // Load signal to start the 8 MHz signal generation 
    input en,       // Enable pin
    output en_8MHz, // Output 8 MHz enable signal 
    output [4:0] c1 // Debugging signal to output counter value
);
    
    // Generate enable signal which triggers at 8 MHz frequency
    // Given a 200 MHz core clock, the module uses a 0-24 counter 
    // to obtain 8 Mhz enable frequency (toggled when counter reaches 0)
    
    // wire [4:0] c1;
    wire [4:0] c1_limit;
    assign c1_limit = 5'b11000; 
    assign en_8MHz = (c1==0);

    // counters cannot be reset as the clocks will go out of sync  
    upwardCounter #(5) Counter25 (.clk(clk), .reset(load), .en(en), .limit(c1_limit), .Q(c1));

endmodule

    
