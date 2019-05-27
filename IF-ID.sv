
module IF_ID(
    input clk, rst,
    input[31:0] instruction,
    input[9:0]PC,
    input flush,
    output reg[9:0] PC_out, 
    output reg [31:0] inst_out,
    output[31:0] instr15_0
);
    reg[31:0] reg_inst_out ;
    reg[ 9:0] reg_PC_out ;

    assign instr15_0 = {16'b0 , instruction[15:0]} ;
    always @(posedge clk , posedge rst) begin
        if ( rst ) begin
            reg_PC_out <= 10'b0 ;
            reg_inst_out <= 32'b0 ;
        end else begin
            reg_inst_out <= instruction ;
            reg_PC_out <= PC ;
            if ( flush == 0 ) begin
                inst_out <= instruction ;
                PC_out <= PC ;
            end else begin 
                inst_out <= 32'b0 ;
                // PC_out   <= 10'b0 ; todo: check if PC is beeded here
            end
        end
    end
endmodule 