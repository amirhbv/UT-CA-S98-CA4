`timescale 1ns/1ns

module IF_ID(
    input clk, rst,
    input[31:0] instruction,
    input[31:0]PC_in,
    input flush,
    output reg[31:0] PC_out,
    output reg [31:0] inst_out,
    output[31:0] instr15_0
);
    reg[31:0] reg_inst_out ;
    reg[ 31:0] reg_PC_out ;

	assign instr15_0 = (instruction[15] == 1) ? {16'b1111111111111111, instruction} : {16'b0000000000000000, instruction};

    always @(posedge clk , posedge rst) begin
        if ( rst ) begin
            reg_PC_out <= 10'b0 ;
            reg_inst_out <= 32'b0 ;
        end else begin
            reg_inst_out <= instruction ;
            reg_PC_out <= PC_in ;
            if ( flush == 0 ) begin
                inst_out <= instruction ;
                PC_out <= PC_in ;
            end else begin
                inst_out <= 32'b0 ;
                // PC_out   <= 10'b0 ; todo: check if PC is beeded here
            end
        end
    end
endmodule
