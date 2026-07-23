module clock_divider (
    input wire clk,
    input wire rst_n,
    input wire [4:0] sel_speed,
    output wire clk_divider,
    output wire [31:0] counter_bus // Added so the top wrapper can access the scan clock
);



    // 32-to-1 Multiplexer tree
    mux32x1 mux32x1_inst (
        .in(counter_bus),
        .sel(sel_speed),
        .y(clk_divider)
    );

    // 32-bit free running counter
    FreeRun_Counter_32bit counter_inst (
        .clk(clk), // Driven directly by the fast onboard 100MHz clock
        .rst_n(rst_n),
        .count(counter_bus)
    );
endmodule
