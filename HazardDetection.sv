`timescale 1ns/1ns

module HazardDetection(
    input[4:0]  Rt_IF_ID,
                Rs_IF_ID,
                Rt_ID_EX,
    input[3:0]  signals_M_ID_EX,
    input[3:0]  signals_M_Controller,
    input[31:0] offset_ID_EX,
    input       comparatorForBranch,
    input       isJump,
    
    output reg  holdPC,
                IF_ID_Flush,
                isBranch,
    output reg[31:0] PC_offset
);
    reg[1:0] cnt;
    always @(*) begin
        { holdPC, IF_ID_Flush } = 0;
        if ( signals_M_ID_EX[1] == 1) begin
            if (Rt_ID_EX == Rs_IF_ID || Rt_ID_EX == Rt_IF_ID)
                holdPC = 1;
                IF_ID_Flush = 1;
        end
        
        if ( isJump ) begin
          IF_ID_Flush = 1 ;
        end
        
        /*
        // beq, bne case
        if ( signals_M_Controller[2] == 1 || signals_M_Controller[3] == 1) begin
            holdPC = 1;
            IF_ID_Flush = 1;
        end
        */
        
        if (
            (signals_M_ID_EX[2] == 1 && comparatorForBranch) ||
            (signals_M_ID_EX[3] == 1 && ~comparatorForBranch)
        ) begin
            isBranch = 1;
            PC_offset = offset_ID_EX;
            IF_ID_Flush = 1 ;
        end
    end
endmodule
