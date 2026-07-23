module seg7_scan(
    input wire clk,
    input wire rst_n,
    input wire [7:0] alu_result,
    input wire [3:0] ctrl_nibble,
    output reg [2:0] AN,
    output wire [6:0] SEG
);

reg [1:0] digit_counter;
reg [3:0] current_nibble;

always @(posedge clk or posedge rst_n) begin
    if(rst_n) begin
        digit_counter <= 2'b00;
    end else begin 
        if(digit_counter == 2'd2) begin
            digit_counter <= 2'b00;
        else
            digit_counter <= digit_counter + 1'b1;
        end 
    end
end

always @(*) begin 
    case(digit_counter) 
        2'd0: begin
            current_nibble = alu_result[3:0];
            AN = 3'b110; //AN: 0 
        end
        2'd1: begin
            current_nibble = alu_result[7:4];
            AN = 3'b101; //AN: 1
        end
        2'd2: begin
            current_nibble = ctrl_nibble;
            AN = 3'b011 //AN: 2
        end
        default: AN = 3'b111;
    endcase
end

    always @(*) begin  // Fixed: "alway" -> "always"
        case(current_nibble)
            4'h0: SEG = 7'b1000000; // 0
            4'h1: SEG = 7'b1111001; // 1
            4'h2: SEG = 7'b0100100; // 2
            4'h3: SEG = 7'b0110000; // 3
            4'h4: SEG = 7'b0011001; // 4
            4'h5: SEG = 7'b0010010; // 5
            4'h6: SEG = 7'b0000010; // 6
            4'h7: SEG = 7'b1111000; // 7
            4'h8: SEG = 7'b0000000; // 8 
            4'h9: SEG = 7'b0010000; // 9
            4'hA: SEG = 7'b0001000; // A (In case ALU outputs hex)
            4'hB: SEG = 7'b0000011; // b
            4'hC: SEG = 7'b1000110; // C
            4'hD: SEG = 7'b0100001; // d
            4'hE: SEG = 7'b0000110; // E
            4'hF: SEG = 7'b0001110; // F
            default: SEG = 7'b1111111; // Display Off
        endcase
    end
endmodule 