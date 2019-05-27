`timescale 1ns/1ns

module MEM_Stage(
    input clk, rst,
    input[31:0] result,
    input[31:0] write_data,
    input[1:0] control_signals,
    output[31:0] read_data
);
	// todo: assign only 2 bits of control signals M

    //write_enable   --- mem_read
    DATA_MEMORY mem(clk , result , control_signals[0] , control_signals[1] , write_data , read_data) ;
endmodule
