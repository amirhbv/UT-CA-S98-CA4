`timescale 1ns/1ns

module EX_Stage(
    input[ 2:0] fwdA,
                fwdB,
    input[31:0] ID_EX_op1,
                ID_EX_op2,
                EX_MEM_op1,
                EX_MEM_op2,
                MEM_WB_op1,
                MEM_WB_op2,
    input[6:0] signals,
    output Zero,
    output[31:0] result,

    input [4:0] Rt,
                Rs,
                Rd,
    output reg[4:0] reg_dest
    output [31:0] op2
);

    wire[4:0] ALUop = signals[4:0] ;
    wire ALUsrc = signals[5] ;
    wire RegDst = signals[6] ;

    reg[31:0] op1 , op2 ;

    ALU alu (ALUop , op1 , op2 , result , zero) ;

    always @(*) begin
        if ( fwdA == 3'b001 ) op1 <= ID_EX_op1 ;
        if ( fwdA == 3'b010 ) op1 <= EX_MEM_op1 ;
        if ( fwdA == 3'b100 ) op1 <= MEM_WB_op1 ;

        if ( fwdB == 3'b001 ) op2 <= ID_EX_op2 ;
        if ( fwdB == 3'b010 ) op2 <= EX_MEM_op2 ;
        if ( fwdB == 3'b100 ) op2 <= MEM_WB_op2 ;

        if ( RegDst )
            reg_dest <= Rd ;
        else
            reg_dest <= Rt ;

    end


endmodule
