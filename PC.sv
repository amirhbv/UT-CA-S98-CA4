`timescale 1ns/1ns

module PC(
    input clk, rst,
    input PCsrc, holdPC, isBranch,
    input [31:0] PCoffset,
    input[31:0] jVal,
    output reg[31:0] PCVal
);
    always @(posedge rst , posedge clk) begin
        if ( rst )
            PCVal <= 10'b0 ;
        else if ( holdPC == 0 ) begin
            if (isBranch) PCVal <= PCVal + PCoffset;
            else if (PCsrc)  PCVal <= jVal ;
            else PCVal <= PCVal + 4 ;
        end
    end
endmodule
