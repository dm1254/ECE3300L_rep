module bcd_counter(
    input wire clk_div,
    input wire rst_n,
    input wire dir_units,
    input wire dir_tens,
    output [3:0] bcd_units_output,
    output [3:0] bcd_tens_output
);

wire CO;

BCD_single_digit BCD_units(
    .clk(clk_div),
    .rst_n(rst_n), 
    .enable(1'b1),
    .Carry_Out(CO),
    .dir(dir_units),
    .bcd_output(bcd_units_output)
);


BCD_single_digit BCD_units(
    .clk(clk_div),
    .rst_n(rst_n), 
    .dir(dir_tens),
    .enable(CO),
    .Carry_Out();
    .bcd_output(bcd_tens_output)
);

