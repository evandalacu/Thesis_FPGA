module gen1MHz(
    input clk, // 200 MHz core clock 
    input load, // signal to start the enable signal 
    input en, 
    input [4:0] c1, // counter value from 8 MHz counter
    input en_8MHz,  // 8 MHz enable 

    output en_1MHz,
    output [4:0] c2 // Debugging: counter output 
);
    // Generate enable signal which triggers at 1 MHz frequency
    // Given a 200 MHz core clock, and a 8 MHz enable
    // the module counts from 0 to 7 at 8 MHz frequency 
    // to obtain 1 Mhz enable frequency (toggled when counter reaches 0)
 
    wire [4:0] c2_limit;
    assign c2_limit = 5'b00111;
    assign en_1MHz = en && (((c1==5'b00000) && (c2==5'b00000)) || ((c1==5'b00001) && (c2==5'b00001)));
    
    upwardCounter #(5) Counter8 (.clk(clk), .reset(load), .en(en && en_8MHz), .limit(c2_limit), .Q(c2));
    

endmodule

    
