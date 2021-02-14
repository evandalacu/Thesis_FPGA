// General divider with two parameters: width of dividend (A) and width of divisor (B)
// The inputs are clock, A, and B. The output is Q (quotient), and R (remainder) and done (signals when divide operation is done).

module general_divider #(
                        parameter WIDTH_A=4,
                        parameter WIDTH_B=4
                    ) (
                        input clk,reset, 
                        input [(WIDTH_A-1):0] A,
                        input [(WIDTH_B-1):0] B,
                        output [(WIDTH_A-1):0] Q, 
                        output [(WIDTH_B-1):0] R,
                        output reg done							 
    );

  // ============== Algorithm  ==================== //
  // for a n-bit dividend A
  // for i=0:n-1 (at each clk cycle) do
  //     leftshift R||A; //left shift MSB of A into R
  //     if (R>=B) then
  //         Q[i-1] = 1;
  //         R = R - B;
  //     else Q[i] = 0;
  //     endif
  // endfor
  // ============================================== //
  

    // Declare Parameters
    localparam n = 2*WIDTH_A;
    // Declare storing reg for R-A concat
    reg [(n-1):0] ra;
    // declare counter
    reg [(WIDTH_A-1):0] c;
        
	 // Does not work -E
    //initial begin
    //    ra = {{WIDTH_A{1'b0}}, A};
    //    c=0;
    //    done = 0;
    //    end
        
        
    assign Q = ra[0+:WIDTH_A];
    assign R = ra[WIDTH_A+:WIDTH_B];
        
    always @ (posedge clk) begin
            if (reset) begin
                c <= 0;
                done <= 0;
                ra <= {{WIDTH_A{1'b0}}, A};
            end

            else
                if (!done) begin      
            // if (c<WIDTH_A) begin
                c<=c+1'b1;
              // if (R>=B after shifting), then R = R-b, and store Q into the lower end of ra;
                if ( ra[ (WIDTH_A-1) +:WIDTH_A] >= B )  ra <= ( (ra<<1) - { B, {WIDTH_A{1'b0}} } ) | ( { {(n-1){1'b0}}, 1'b1} );
                else ra <= (ra<<1) | ({n{1'b0}}); // the or operation is redundant, just in case
            // end
            
                if (c== (WIDTH_A-1) ) done <= 1;
            end

    end
 
    endmodule



