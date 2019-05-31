`timescale 1ns/1ns

module ALU(
    input [4:0] ALUop,
    input[31:0] A, B,
    output reg[31:0] out
);
    //WATCH OUT FOR A < B OR A > B
    always @(*) begin
        case (ALUop)
            5'b00001 : out <= A + B ;
            5'b00010 : out <= A - B ;
            5'b00100 : out <= A & B ;
            5'b01000 : out <=(A < B);
            5'b10000 : out <= A | B ;
        endcase
    end
endmodule
