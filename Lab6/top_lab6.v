module top_lab6(
    input wire CLK100MHZ,
    input wire [8:0] SW,
    input wire BTN0,
    output wire [2:0] AN,
    output wire [6:0] SEG,
    output wire [7:0] LED
);

wire clk_div;
wire [31:0] raw_counter_reg;
wire [3:0] bcd_units;
wire [3:0] bcd_tens;
wire [7:0] ALU_result;
wire [3:0] control_nibble;

clock_divider clk_divider_inst(
    .clk(CLK100MHZ),
    .rst_n(BTN0),
    .sel_speed(SW[4:0]),
    .clk_divider(clk_div),
    .counter_bus(raw_counter_reg)
);

bcd_counter bcd_counter_inst(
    .clk_div(clk_div),
    .rst_n(BTN0),
    .dir_units(SW[7]),
    .dir_tens(SW[8]),
    .bcd_units_output(bcd_units),
    .bcd_tens_output(bcd_tens)
);

ALU alu_inst(
    .A(bcd_units),
    .B(bcd_tens),
    .ctrl(SW[6:5]),
    .output_reg(ALU_result)
);

control_decoder ctrl_decoder_inst(
    .nibble_in(SW[8:5]),
    .ctrl_nibble(control_nibble)
);

seg7_scan seg7_inst(
    .clk(raw_counter_reg[15]),
    .rst_n(BTN0),
    .alu_result(ALU_result),
    .ctrl_nibble(control_nibble),
    .AN(AN),
    .SEG(SEG)

);
assign LED = ALU_result; 
endmodule
