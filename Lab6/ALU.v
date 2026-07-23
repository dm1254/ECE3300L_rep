module ALU(
    input wire [3:0] A,
    input wire [3:0] B,
    input wire [1:0] ctrl,
    output reg [7:0] output_reg 
)
always @(*) begin
    case(ctrl) 
        2'b00: begin
            output_reg = A+B;
        end
        2'b01: begin
            output_reg = A-B; 
        end

        default: begin
            output_reg = 8'd0
        end
    endcase
end
endmodule