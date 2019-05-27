`timescale 1ns/1ns

module WB_stage(
    input[31:0] read_data,
    input[31:0] ALU_result,
    input MemToReg,
    output[31:0] write_out_data
);
    assign write_out_data = MemToReg ? read_data , ALU_result ;
endmodule
