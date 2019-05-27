`timescale 1ns/1ns

module Datapath(
	input clk, rst
);
	wire[31:0] PC_out, inst_out, PC_offset;
	wire[31:0] PC_out_IF_ID, inst_out_IF_ID, offset_out_IF_ID, offset_out_ID_EX;
	wire flush, holdPC, isBranch, PC_src_controller;
	wire[1:0] WB_control_signals_controller, WB_control_signals_ID_EX;
	wire[3:0] M_control_signals_controller, M_control_signals_ID_EX;
	wire[6:0] EX_control_signals_controller, EX_control_signals_ID_EX;
	wire[5:0] Rt_out_ID_EX, Rs_out_ID_EX, Rd_out_ID_EX;

	PC pc(
		.clk(clk),
		.rst(rst),
		input PCsrc, // from ex/mem reg
		.holdPC(holdPC),
		.isBranch(isBranch),
		.PCoffset(PC_offset),
		input[31:0] jVal,
		.PCVal(PC_out)
	);

	InstructionMemory instructionMemory(
		.addr(PC_out),
		.inst_out(inst_out)
	);

	IF_ID reg_IF_ID(
		.clk(clk),
		.rst(rst),
		.instruction(inst_out),
		.PC_in(PC_out), // todo: check if pc is needed in IF/ID
		.flush(flush),
		.PC_out(PC_out_IF_ID),
		.inst_out(inst_out_IF_ID),
		.instr15_0(offset_out_IF_ID)
	);

	HazardDetection hazardDetection(
		.Rt_IF_ID(inst_out_IF_ID[16:20]), // todo: check if it works
		.Rs_IF_ID(inst_out_IF_ID[21:25]),
		.Rt_ID_EX(Rt_out_ID_EX),
		.signals_M_ID_EX(M_control_signals_ID_EX),
		.signals_M_Controller(M_control_signals_controller),
		.offset_ID_EX(offset_out_ID_EX),
		input zero_ALU,
		.holdPC(holdPC),
		.IF_ID_Flush(flush),
		.isBranch(isBranch),
		.PC_offset(PC_offset)
	);

	Controller controller(
		.inst(inst_out_IF_ID),
		.WB_control_signals(WB_control_signals_controller),
		.M_control_signals(M_control_signals_controller),
		.EX_control_signals(EX_control_signals_controller),
		.jOnlyPCsrc(PC_src_controller),
		output reg[31:0] jNextPC // bug ?!
	);

	ID_EX reg_ID_EX(
		.clk(clk),
		.rst(rst),
		input[31:0] read_data1,
					read_data2,
		output[31:0] r1,
					r2,
		.offset(offset_IF_ID),
		.Rt(inst_out_IF_ID[16:20]),
		.Rs(inst_out_IF_ID[21:25]),
		.Rd(inst_out_IF_ID[11:15]),
		.control_signals_WB(WB_control_signals_controller),
		.control_signals_M (M_control_signals_controller),
		.control_signals_EX(EX_control_signals_controller),
		.out_control_signals_WB(WB_control_signals_ID_EX),
		.out_control_signals_M(M_control_signals_ID_EX),
		.out_control_signals_EX(EX_control_signals_ID_EX)
		.Rt_out(Rt_out_ID_EX),
        .Rs_out(Rs_out_ID_EX),
        .Rd_out(Rd_out_ID_EX),
		.offset_out(offset_out_ID_EX)
	);

endmodule
