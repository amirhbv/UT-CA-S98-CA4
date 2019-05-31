`timescale 1ns/1ns

module HazardDetection(
	  input clk,
    input[4:0]  Rt_IF_ID,
                Rs_IF_ID,
                Rt_ID_EX,
    input[3:0]  signals_M_ID_EX,
    input[3:0]  signals_M_Controller,
    input[31:0] offset_IF_ID,
    input[31:0] completeInst,
    input       comparatorForBranch,
    input       isJump,

    output reg  holdPC,
                hold_IF_ID,
    output[31:0] PC_offset
);
    assign PC_offset = offset_IF_ID ;
    always @(signals_M_ID_EX ,signals_M_Controller,Rt_IF_ID,Rs_IF_ID,Rt_ID_EX ) begin
        { holdPC , hold_IF_ID } <= 0;
        //LW - RTYPE ke data dependemcy daran
        if ( signals_M_ID_EX[1] == 1) begin
            if (Rt_ID_EX == Rs_IF_ID || Rt_ID_EX == Rt_IF_ID) begin
                holdPC <= 1;
                hold_IF_ID <= 1;
            end
        end
        /*
        // beq, bne case
        if ( signals_M_Controller[2] == 1 || signals_M_Controller[3] == 1) begin
            holdPC = 1;
            IF_ID_Flush = 1;
        end
        */
        /*
        if (
            (signals_M_Controller[2] == 1 &&  comparatorForBranch) ||
            (signals_M_Controller[3] == 1 && ~comparatorForBranch)
        ) begin
            PC_offset <= offset_IF_ID;
        end*/
    end
endmodule
