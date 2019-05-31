`timescale 1ns/1ns

module IF_ID(
    input clk, rst,
    input[31:0] instruction,
    input flush,
    output reg [31:0] inst_out,
    output [31:0] instr15_0
);
	assign instr15_0 = (inst_out[15] == 1) ? {16'b1111111111111111, inst_out[15:0]} : {16'b0000000000000000, inst_out[15:0]};

    always @(posedge clk , posedge rst) begin
        if ( rst )
            inst_out <= 32'b0 ;
        else
            inst_out <= instruction ;
    end
    
    always @(posedge flush) begin
      inst_out <= 32'b0 ;
    end
    
endmodule
