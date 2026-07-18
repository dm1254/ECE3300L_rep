module bcd_up_down_counter(
    input wire clk,
    input wire dir,
    input wire rst_n,
    input wire enable,
    output [3:0] output_units_reg,
    output [3:0] output_tens_reg
);

    wire CO;

    // Instance 1: Units digit is driven by the global enable
    BCD_single_digit BCD_units (
        .clk(clk), 
        .rst_n(rst_n), 
        .enable(enable), 
        .Carry_Out(CO), 
        .dir(dir), 
        .bcd_output(output_units_reg)
    );

    // Instance 2: Tens digit is enabled ONLY when the units digit emits a Carry-Out
    BCD_single_digit BCD_tens (
        .clk(clk), 
        .rst_n(rst_n), 
        .enable(CO), // <-- FIXED CASCADE CONNECTION
        .Carry_Out(), 
        .dir(dir), 
        .bcd_output(output_tens_reg)
    );

endmodule

