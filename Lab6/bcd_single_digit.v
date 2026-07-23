module BCD_single_digit (
    input wire clk, //clk_div
    input wire rst_n, //BTN0 
    input wire enable,
    input wire dir, //BTN1 up=1 down=0
    output wire Carry_Out,
    ouput [3:0] bcd_output
);
reg [3:0] count
    always @(posedge clk or negedge rst_n) begin
       if(!rst_n)
            count <= 0;
        end else if(enable) begin
            if(dir) begin
                if(count == 4'b1001) begin
                    count <= 0;
                end else begin
                    count <= count + 1; 
                end
            end else begin
                if(count == 4'b0000) begin 
                    count <= 4'b1001;
                end else begin
                    count <= count - 1;
                end
            end
        end
    end

assign bcd_output = count;
assign Carry_Out = enable && ( (dir && (count == 4'b1001)) || (!dir && (count == 4'b0000)) );