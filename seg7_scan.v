module seg7_scan(
    input wire clk_scan,        // 1. Scan clock (approx 1.5 kHz)
    input wire rst_n,           // 2. Active-low Reset
    input wire [3:0] units_bcd, // 3. 4-bit Units BCD value (0-9)
    input wire [3:0] tens_bcd,  // 4. 4-bit Tens BCD value (0-9)
    output reg [1:0] AN,        // 5. Active-low Anode enables (AN0 and AN1)
    output reg [6:0] SEG        // 6. Active-low segments (A to G)
);

    reg digit_select;
    reg [3:0] active_bcd;

    always @(posedge clk_scan or negedge rst_n) begin
        if(!rst_n) begin
            digit_select <= 1'b0;
        end else begin
            digit_select <= ~digit_select;
        end
    end

    // Combinational block: Uses blocking assignments (=) instead of nonblocking
    always @(*) begin  // Fixed: "alway" -> "always"
        if(digit_select == 1'b0) begin 
            active_bcd = units_bcd;
            AN = 2'b10;
        end else begin
            active_bcd = tens_bcd;
            AN = 2'b01;
        end
    end 

    // Decoder block: Translates selected BCD value to segments
    always @(*) begin  // Fixed: "alway" -> "always"
        case(active_bcd)
            4'd0: SEG = 7'b1000000; // 0
            4'd1: SEG = 7'b1111001; // 1
            4'd2: SEG = 7'b0100100; // 2
            4'd3: SEG = 7'b0110000; // 3
            4'd4: SEG = 7'b0011001; // 4
            4'd5: SEG = 7'b0010010; // 5
            4'd6: SEG = 7'b0000010; // 6
            4'd7: SEG = 7'b1111000; // 7
            4'd8: SEG = 7'b0000000; // 8 
            4'd9: SEG = 7'b0010000; // 9
            default: SEG = 7'b1111111; // Display Off
        endcase
    end

endmodule
