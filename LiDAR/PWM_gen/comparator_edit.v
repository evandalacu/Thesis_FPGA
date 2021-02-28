module comparator(
    input counter_clk,
    input [6:0] in_x, in_y,
	 input [6:0] val_is_0_check, //Added as a failsafe for when A/B_val = 0 -E
    input en,
    input reset, //default to zero
    output comp
);

    // reg to store delayed signal (value from last clock cycle)
    reg in_x_d; 
    wire x_stable, y_eq_x;
	 
	 // activate pulse when A/B_val decremented to zero (but not when stable at 0)
    assign x_stable = (in_x_d==in_x) && (val_is_0_check!=7'b0);
    assign y_eq_x   = (in_x==in_y);
    assign comp = (en && (y_eq_x) && !(x_stable));

    always @(posedge counter_clk)begin
        in_x_d <= in_x[0]; // editted to [0] from [6:0] bit -E
    end

endmodule
