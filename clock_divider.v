module clock_divider (
    input wire clk,
    input wire rst_n,
    input wire [4:0] sel_speed,
    output wire clk_divider,
    output wire [31:0] counter_bus // Added so the top wrapper can access the scan clock
);

    wire [31:0] counter_reg;
    assign counter_bus = counter_reg;

    // 32-to-1 Multiplexer tree
    mux32x1 mux32x1_inst (
        .in(counter_reg),
        .sel(sel_speed),
        .y(clk_divider)
    );

    // 32-bit free running counter
    free_run_counter_32bit counter_inst (
        .clk(clk), // Driven directly by the fast onboard 100MHz clock
        .rst_n(rst_n),
        .count(counter_reg)
    );

endmodule

// Helper Module: Free running counter (re-numbered name to avoid compiler errors)
module free_run_counter_32bit (
    input wire clk,
    input wire rst_n,
    output reg [31:0] count
);
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            count <= 32'd0;
        else 
            count <= count + 1'b1;
    end
endmodule
