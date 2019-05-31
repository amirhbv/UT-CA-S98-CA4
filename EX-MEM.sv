`timescale 1ns/1ns

module EX_MEM(
    input clk, rst,
    input[31:0] result,
    //op2 in EX-stage is write_data
    input[31:0] write_data,
    input[4:0] RegDest,
    input[1:0] control_signals_WB,
    input[3:0] control_signals_M,

    output reg[4:0] RegDestOut,
    output reg[3:0] control_signals_M_out,
    output reg[1:0] control_signals_WB_out,
    output reg[31:0] result_out,
    output reg[31:0] write_data_out
);
    always @(posedge clk , posedge rst) begin
        if ( rst ) begin
            result_out <= 32'b0 ;
            control_signals_WB_out <= 2'b0 ;
            control_signals_M_out <= 4'b0 ;
            write_data_out <= 32'b0 ;
            RegDestOut <= 5'b0 ;
        end else begin
            control_signals_M_out <= control_signals_M ;
            control_signals_WB_out <= control_signals_WB ;
            result_out <= result ;
            write_data_out <= write_data ;
            RegDestOut <= RegDest ;
        end
    end
endmodule
