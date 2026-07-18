// 2-to-1 Multiplexer Module
module mux2x1 (
    input wire d0,  // Maps to "a" in your mind
    input wire d1,  // Maps to "b" in your mind
    input wire sel,
    output wire y   // Maps to "out" in your mind
);
    assign y = sel ? d1 : d0; // In standard muxing, sel=1 selects d1, sel=0 selects d0
endmodule

// 32-to-1 Multiplexer Tree Module
module mux32x1 (
    input wire [31:0] in,
    input wire [4:0] sel,
    output wire y
);

    // Declaring correct wire widths for each intermediate stage
    wire [15:0] stage1Out;
    wire [7:0]  stage2Out;
    wire [3:0]  stage3Out;
    wire [1:0]  stage4Out; // 2 wires needed to connect to the final 5th stage

    // ================= STAGE 1 (16 Muxes) =================
    mux2x1 mux1_1  (.d0(in[0]),  .d1(in[1]),  .sel(sel[0]), .y(stage1Out[0]));
    mux2x1 mux1_2  (.d0(in[2]),  .d1(in[3]),  .sel(sel[0]), .y(stage1Out[1]));
    mux2x1 mux1_3  (.d0(in[4]),  .d1(in[5]),  .sel(sel[0]), .y(stage1Out[2]));
    mux2x1 mux1_4  (.d0(in[6]),  .d1(in[7]),  .sel(sel[0]), .y(stage1Out[3]));
    mux2x1 mux1_5  (.d0(in[8]),  .d1(in[9]),  .sel(sel[0]), .y(stage1Out[4]));
    mux2x1 mux1_6  (.d0(in[10]), .d1(in[11]), .sel(sel[0]), .y(stage1Out[5]));
    mux2x1 mux1_7  (.d0(in[12]), .d1(in[13]), .sel(sel[0]), .y(stage1Out[6]));
    mux2x1 mux1_8  (.d0(in[14]), .d1(in[15]), .sel(sel[0]), .y(stage1Out[7]));
    mux2x1 mux1_9  (.d0(in[16]), .d1(in[17]), .sel(sel[0]), .y(stage1Out[8]));
    mux2x1 mux1_10 (.d0(in[18]), .d1(in[19]), .sel(sel[0]), .y(stage1Out[9]));
    mux2x1 mux1_11 (.d0(in[20]), .d1(in[21]), .sel(sel[0]), .y(stage1Out[10]));
    mux2x1 mux1_12 (.d0(in[22]), .d1(in[23]), .sel(sel[0]), .y(stage1Out[11]));
    mux2x1 mux1_13 (.d0(in[24]), .d1(in[25]), .sel(sel[0]), .y(stage1Out[12]));
    mux2x1 mux1_14 (.d0(in[26]), .d1(in[27]), .sel(sel[0]), .y(stage1Out[13]));
    mux2x1 mux1_15 (.d0(in[28]), .d1(in[29]), .sel(sel[0]), .y(stage1Out[14]));
    mux2x1 mux1_16 (.d0(in[30]), .d1(in[31]), .sel(sel[0]), .y(stage1Out[15]));
    
    // ================= STAGE 2 (8 Muxes) =================
    mux2x1 mux2_1 (.d0(stage1Out[0]),  .d1(stage1Out[1]),  .sel(sel[1]), .y(stage2Out[0]));
    mux2x1 mux2_2 (.d0(stage1Out[2]),  .d1(stage1Out[3]),  .sel(sel[1]), .y(stage2Out[1]));
    mux2x1 mux2_3 (.d0(stage1Out[4]),  .d1(stage1Out[5]),  .sel(sel[1]), .y(stage2Out[2]));
    mux2x1 mux2_4 (.d0(stage1Out[6]),  .d1(stage1Out[7]),  .sel(sel[1]), .y(stage2Out[3]));
    mux2x1 mux2_5 (.d0(stage1Out[8]),  .d1(stage1Out[9]),  .sel(sel[1]), .y(stage2Out[4]));
    mux2x1 mux2_6 (.d0(stage1Out[10]), .d1(stage1Out[11]), .sel(sel[1]), .y(stage2Out[5]));
    mux2x1 mux2_7 (.d0(stage1Out[12]), .d1(stage1Out[13]), .sel(sel[1]), .y(stage2Out[6]));
    mux2x1 mux2_8 (.d0(stage1Out[14]), .d1(stage1Out[15]), .sel(sel[1]), .y(stage2Out[7]));

    // ================= STAGE 3 (4 Muxes) =================
    mux2x1 mux3_1 (.d0(stage2Out[0]),  .d1(stage2Out[1]),  .sel(sel[2]), .y(stage3Out[0]));
    mux2x1 mux3_2 (.d0(stage2Out[2]),  .d1(stage2Out[3]),  .sel(sel[2]), .y(stage3Out[1]));
    mux2x1 mux3_3 (.d0(stage2Out[4]),  .d1(stage2Out[5]),  .sel(sel[2]), .y(stage3Out[2]));
    mux2x1 mux3_4 (.d0(stage2Out[6]),  .d1(stage2Out[7]),  .sel(sel[2]), .y(stage3Out[3])); // Fixed duplicate name mux2_4 -> mux3_4

    // ================= STAGE 4 (2 Muxes) =================
    mux2x1 mux4_1 (.d0(stage3Out[0]),  .d1(stage3Out[1]),  .sel(sel[3]), .y(stage4Out[0]));
    mux2x1 mux4_2 (.d0(stage3Out[2]),  .d1(stage3Out[3]),  .sel(sel[3]), .y(stage4Out[1]));

    // ================= STAGE 5 (1 Mux) =================
    mux2x1 mux5_1 (.d0(stage4Out[0]),  .d1(stage4Out[1]),  .sel(sel[4]), .y(y)); // Connects stage4 outputs to select final output "y"

endmodule
