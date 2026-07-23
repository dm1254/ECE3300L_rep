`timescale 1ns / 1ps
module BCD_single_digit (
    input wire clk,       // clk_div
    input wire rst_n,     // BTN0 
    input wire enable,
    input wire dir,       // BTN1 up=1 down=0
    output wire Carry_Out,
    output wire [3:0] bcd_output 
);

reg [3:0] count;          // Fixed missing semicolon

    always @(posedge clk or posedge rst_n) begin
        if(rst_n) begin  // Added missing opening begin for the reset block
            count <= 0;
        end else if(enable) begin // Removed the stray 'end' that was breaking this else
            if(dir) begin
                if(count == 4'b1001) begin
                    count <= 0;
                end else begin
                    count <= count + 1; 
                end
            end else begin
                if(count == 4'b0000) begin 
                    count <= 4'b1001;
                end else begin
                    count <= count - 1;
                end
            end
        end
    end

assign bcd_output = count;
assign Carry_Out = enable && ( (dir && (count == 4'b1001)) || (!dir && (count == 4'b0000)) );

endmodule
