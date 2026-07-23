module control_decoder(
    input wire [3:0] nibble_in,
    output reg [3:0] ctrl_nibble
);

always @(*) begin
    ctrl_nibble = 4bit_nibble;
end 
endmodule