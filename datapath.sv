`timescale 1ns/1ns

module Datapath(
	input clk, rst,

);

	wire[31:0] PC_out, inst_out;
	wire[31:0] PC_out_IF_ID, inst_out_IF_ID, sgn_ext_inst_out;


	PC pc(
		.clk(clk),
		.rst(rst),
		input PCsrc, holdPC, isBranch,
		input [31:0] PCoffset,
		input[31:0] jVal,
		.PCVal(PC_out)
	);

	InstructionMemory instructionMemory(
		.addr(PC_out),
		.inst_out(inst_out)
	);

	module IF_ID(
		.clk(clk),
		.rst(rst),
		.instruction(inst_out),
		.PC_in(PC_out), // todo: check if pc is needed in IF/ID
		input flush,
		.PC_out(PC_out_IF_ID),
		.inst_out(inst_out_IF_ID),
		.instr15_0(sgn_ext_inst_out)
	);



endmodule
