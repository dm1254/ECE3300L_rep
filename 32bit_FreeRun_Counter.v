`timescale 1ns / 1ps
module FreeRun_Counter_32bit(
    input wire clk,
    input wire rst_n,
    output reg [31:0] count
);
    always @(posedge clk or posedge rst_n) begin
        if(rst_n) 
            count <= 32'd0;
        else 
            count <= count + 1;
    end

endmodule
