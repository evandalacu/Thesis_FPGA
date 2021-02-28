module gen_PWM(
    input en,
    input reset,
    input clkCore,              // 200 MHz core clock
    input clkZ,                 // 1 MHz loading clk
    input clkA,                 // 80 MHz clock A 
    input clkB,                 // 81 MHz clock B
    input [6:0] A_val, B_val,   // Decoded A and B values

    output PWMset, PWMreset,    // set and reset signal for PWM 
    output signal,              // signal and inverted signal (Debugging purpose)  from RS latch
    output [6:0] cA, cB         // Counter values for A and B (Debugging purpose)
	 
	 //output debugA, debugB, debugD, debugE // debugging -E
);
    
    // Instantiate counters, counter loads in A and B from reg at rising clkZ
    downwardCounter #(7) counterA (.clk(clkA),.reset(1'b0),.load(clkZ),.en(en),.limit(A_val),.Q(cA)); 
    downwardCounter #(7) counterB (.clk(clkB),.reset(1'b0),.load(clkZ),.en(en),.limit(B_val),.Q(cB)); 
    // Used edited downward counters to avoid problem with concurent assignment -E
	 
    //Instantiate comparators
    comparator comparatorA (.counter_clk(clkA),.in_x(cA),.in_y(7'b0),.en(en),.reset(1'b0),.comp(PWMreset),.val_is_0_check(A_val));
    comparator comparatorB (.counter_clk(clkB),.in_x(cB),.in_y(7'b0),.en(en),.reset(1'b0),.comp(PWMset),.val_is_0_check(B_val));
 
    // Instantiate RS flip flop, resets when we load new W
    unclockedLatch pwm_gen (.S(PWMset), .R(PWMreset), .C(signal));
	 //rsFF pwm_gen (.reset(reset), .S(PWMset), .R(PWMreset), .out(signal));
	 //rsFF pwm_gen (.load(reset), .S(PWMset), .R(PWMreset), .out(signal), .clk(clkCore), .reset(clkZ));
	 // created new block unlockedLatch to use -E

endmodule
