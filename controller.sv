`timescale 1ns/1ns

module Controller(
    input[31:0] inst,
    output[1:0] WB_control_signals,
    output[3:0] M_control_signals,
    output[6:0] EX_control_signals,
    output reg jOnlyPCsrc,
    output reg[31:0] jNextPC
);

    //EX signals
    reg[4:0] ALUop ;
    reg ALUsrc ;
    reg RegDst ;

    assign EX_control_signals = {RegDst , ALUsrc , ALUop} ;

    //WB signals
    reg MemToReg ;
    reg RegWrite ;
    assign WB_control_signals = {RegWrite , MemToReg} ;

    //M  signals
    reg MemWrite ;
    reg MemRead ;
    reg PCsrcForBEQ ;
    reg PCsrcForBNE ;
    assign M_control_signals = {PCsrcForBNE ,  PCsrcForBEQ ,MemRead , MemWrite} ;


    always@(*) begin
        //opcode
        begin
            MemToReg = 0 ;
            RegWrite = 0 ;
            ALUsrc = 0 ;
            ALUop = 5'b11111 ;
            RegDst = 0 ;
            MemWrite = 0 ;
            MemRead = 0 ;
        end

        case (inst[31:26])
            //Rtype
            6'b000000 : begin
                RegDst = 1 ;
                RegWrite = 1 ;
                case(inst[5:0]) begin
                    //ADD
                    6'b100000 : ALUop <= 5'b00001 ;
                    //SUB
                    6'b100010 : ALUop <= 5'b00010 ;
                    //AND
                    6'b100100 : ALUop <= 5'b00100 ;
                    //SLT
                    6'b101010 : ALUop <= 5'b01000 ;
                    //OR
                    6'b100101 : ALUop <= 5'b10000 ;
                end

            end

            //LW
            6'b100011 : begin
                ALUsrc = 1 ;
                ALUop = 5'b00001 ; //add
                MemWrite = 1 ;
            end

            //SW
            6'b101011 : begin
                ALUsrc = 1 ;
                ALUop = 5'b00001 ; //add
                MemRead = 1 ;
                MemToReg = 1 ;
            end

            //J - changes PC
            6'b000010 : begin
                jOnlyPCsrc = 1 ;
                jNextPC = { 4'b0000 , inst[25:0] , 2'b00 } ;
            end

            //BEQ - if there was no data dependency we should change the PC immdtly
            6'b000100 : begin
                PCsrcForBEQ = 1 ;
            end

            //BNE - DEPENDENCY
            6'b000101 : begin
                PCsrcForBNE = 1 ;
            end

        endcase
    end
endmodule
