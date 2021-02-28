module decoder(
    input clk,          // 200 MHz core clock
    input reset,        // reset triggers the decode process using divider to get A and B from W
    input [12:0] W,     // Input pulse width (W)
    output [6:0] A, B,  // Output A and B value specified by the decoder table
    output done         // Signals when both A and B is fully decoded
	 );
    // Module: 
    //      1) Reset (manually passed in) signals a change in W. 
    //      2) If reset is high, the dividers start calculating A and B.
    //      3) Outputs signal when decoding operation is complete.

    wire [12:0] qA, qB;     // wires for storing quotient from division (result not used)
    wire [6:0] modA, modB;  // specify divisor for A and B.
    assign modA [6:0] = 7'd80;
    assign modB [6:0] = 7'd81;
    wire doneA, doneB;      // Individual done signal for A and B.


    // done is 1 when both the division operation is done for A and B
    // done is connected to the enable port for gen_PWM 
    // the counting down will only start when the division is done
    assign done = doneA && doneB;

    // Dividing operations to get A and B.
    general_divider #(.WIDTH_A(13), .WIDTH_B(7)) dA (.clk(clk), .reset(reset), .A(W),.B(modA),.Q(qA), .R(A), .done(doneA)); 
    general_divider #(.WIDTH_A(13), .WIDTH_B(7)) dB (.clk(clk), .reset(reset), .A(W),.B(modB),.Q(qB), .R(B), .done(doneB)); 

endmodule 
