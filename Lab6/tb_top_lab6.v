`timescale 1ns / 1ps

module tb_top_lab6;

    // Inputs to top_lab6
    reg        CLK100MHZ;
    reg  [8:0] SW;
    reg        BTN0; // Active-Low Reset

    // Outputs from top_lab6
    wire [2:0] AN;
    wire [6:0] SEG;
    wire [7:0] LED;

    // Instantiate the Unit Under Test (UUT)
    top_lab6 uut (
        .CLK100MHZ (CLK100MHZ),
        .SW        (SW),
        .BTN0      (BTN0),
        .AN        (AN),
        .SEG       (SEG),
        .LED       (LED)
    );

    // -------------------------------------------------------------
    // Clock Generation: 100 MHz (Period = 10ns -> Toggle every 5ns)
    // -------------------------------------------------------------
    always #5 CLK100MHZ = ~CLK100MHZ;

    // -------------------------------------------------------------
    // Stimulus Process
    // -------------------------------------------------------------
    initial begin
        // --- 1. Set Up EPWave Waveform Dump ---
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_top_lab6);

        // --- 2. Initialize Inputs ---
        CLK100MHZ = 1'b0;
        BTN0      = 1'b0; // Assert Active-Low Reset
        SW        = 9'b0;

        #50;
        BTN0      = 1'b1; // Release Reset
        #50;

        // --- 3. Test Case 1: Fast Clock Divider & Up-Counting ---
        // SW[4:0] = 5'b11111 (fast clock selection for simulation)
        // SW[7]   = 1'b1    (Units Dir: UP)
        // SW[8]   = 1'b1    (Tens Dir: UP / ALU Mode Select)
        $display("TC1: Testing Fast Clock & UP Counting...");
        SW = 9'b1_1000_1111; 
        #2000;

        // --- 4. Test Case 2: Change Control Decoder Inputs ---
        // Change SW[8:5] to test control decoder output
        $display("TC2: Changing Control Decoder Inputs...");
        SW[8:5] = 4'b1010;
        #1000;

        // --- 5. Test Case 3: Down-Counting Mode ---
        // Set SW[7] = 0 and SW[8] = 0 (Units & Tens Dir: DOWN)
        $display("TC3: Testing DOWN Counting...");
        SW[7] = 1'b0;
        SW[8] = 1'b0;
        #2000;

        // --- 6. Test Case 4: Re-apply Reset ---
        $display("TC4: Testing Reset Assertion...");
        BTN0 = 1'b0;
        #100;
        BTN0 = 1'b1;
        #500;

        $display("Simulation Finished Successfully!");
        $finish;
    end

endmodule
