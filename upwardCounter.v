module upwardCounter #( parameter WIDTH = 1)
                    (
                        input clk, 
                        input reset,
                        input en,
                        input [WIDTH-1 :0] limit,
                        output reg [WIDTH-1 :0] Q
                    );

    always @(posedge clk) begin
    
        if (reset || (en && (Q==limit)) ) Q <= 5'b00000;
        else if (en) Q <= Q+1'b1;

    end

endmodule
