module EX_MEM(
    input clk, rst,
    input zero,
    input[31:0] result,
    input[31:0] write_data,
    input[4:0] RegDest,
    input[1:0] control_signals_WB,
    input[3:0] control_signals_M,
    //op2 in EX-stage is write_data
    output[4:0] RegDestOut,
    input[31:0] write_data,
    output[3:0] control_signals_M_out,
    output[1:0] control_signals_WB_out,
    output[31:0] result_out,
    output[31:0] write_data_out
);
    reg reg_zero ;
    reg[31:0] reg_result ;
    reg[ 1:0] reg_control_signals_WB ;
    reg[ 3:0] reg_control_signals_M ;
    reg[31:0] reg_write_data ;
    reg[ 4:0] reg_RegDest ;

    assign RegDestOut = reg_RegDest ;
    assign result_out = reg_result ;
    assign control_signals_WB_out = reg_control_signals_WB ;
    assign write_data_out = reg_write_data ;

    always @(posedge clk , posedge rst) begin
        if ( rst ) begin
            reg_result <= 32'b0 ;
            reg_control_signals_WB <= 2'b0 ;
            reg_control_signals_M  <= 4'b0 ;
            reg_zero <= 0 ;
            reg_write_data <= 32'b0 ;
            reg_RegDest <= 5'b0 ;
        end else begin
            reg_control_signals_M <= control_signals_M ;
            reg_control_signals_WB <= control_signals_WB ;
            reg_zero <= zero ;
            reg_result <= result ;
            reg_write_data <= write_data ;
            reg_RegDest <= RegDest ;
        end
    end
endmodule 