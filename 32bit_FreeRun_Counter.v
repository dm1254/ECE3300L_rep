module 32bit_Free_Run_Counter(
    input wire clk,
    input wire rst_n,
    output reg [31:0] count
);
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            count <= 32'd0;
        else 
            count <= count + 1;
    end

endmodule
