`timescale 1ns/1ns

module Datapath(
	input clk, rst
);
	wire[31:0] PC_out, inst_out, PC_offset;
	wire[31:0] inst_out_IF_ID, offset_out_IF_ID, offset_out_ID_EX;
	wire flush, holdPC, isBranch, PC_src_controller, isJump, comparatorForBranch, hold_IF_ID ;
	wire[1:0] WB_control_signals_controller, WB_control_signals_ID_EX, WB_control_signals_EX_MEM, WB_control_signals_MEM_WB;
	wire[3:0] M_control_signals_controller, M_control_signals_ID_EX, M_control_signals_EX_MEM;
	wire[6:0] EX_control_signals_controller, EX_control_signals_ID_EX;
	wire[31:0] PC_j_out_controller;
	wire[4:0] Rt_out_ID_EX, Rs_out_ID_EX, Rd_out_ID_EX;
	wire[31:0] R1_out_reg_file, R2_out_reg_file;
	wire[31:0] R1_out_ID_EX, R2_out_ID_EX;
	wire[2:0] forwardA, forwardB;
	wire[31:0] ALU_out_result, op2_out_EX_stage, write_data_out_EX_MEM;
	wire[4:0] reg_dest_out_EX_stage, reg_dest_out_EX_MEM, reg_dest_out_MEM_WB;
	wire[31:0] data_memory_read_data_out;
	wire[31:0] result_out_MEM_WB;
	wire[31:0] read_data_out_MEM_WB;
	wire[31:0] write_out_data_WB_out, ALU_result_out_EX_MEM;


	PC pc(
		.clk(clk),
		.rst(rst),
		.PCsrc(PC_src_controller),
		.holdPC(holdPC),
		.isBranch(isBranch),
		.PCoffset(PC_offset),
		.jVal(PC_j_out_controller),
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
		.flush(flush),
		.inst_out(inst_out_IF_ID),
		.instr15_0(offset_out_IF_ID),
		.hold_IF_ID(hold_IF_ID)
	);

	wire[4:0] Rt_out_IF_ID, Rs_out_IF_ID, Rd_out_IF_ID;
	assign Rs_out_IF_ID = inst_out_IF_ID[25:21];
	assign Rt_out_IF_ID = inst_out_IF_ID[20:16];
	assign Rd_out_IF_ID = inst_out_IF_ID[15:11];
	wire[31:0] offset_IF_ID ;
  assign offset_IF_ID = {14'b0 , inst_out_IF_ID[15:0] , 2'b00} ;
	HazardDetection hazardDetection(
		.clk(clk),
		.Rt_IF_ID(Rt_out_IF_ID),
		.Rs_IF_ID(Rs_out_IF_ID),
		.Rt_ID_EX(Rt_out_ID_EX),
		.signals_M_ID_EX(M_control_signals_ID_EX),
		.signals_M_Controller(M_control_signals_controller),
		.offset_IF_ID(offset_IF_ID),
		.holdPC(holdPC),
		.completeInst(inst_out_IF_ID),
		.PC_offset(PC_offset),
		.isJump(isJump),
		.comparatorForBranch(comparatorForBranch),
		.hold_IF_ID(hold_IF_ID)
		
	);

	Controller controller(
		.inst(inst_out_IF_ID),
		.WB_control_signals(WB_control_signals_controller),
		.M_control_signals(M_control_signals_controller),
		.EX_control_signals(EX_control_signals_controller),
		.jOnlyPCsrc(PC_src_controller),
		.jNextPC(PC_j_out_controller),
		.isJump(isJump),
		.comparator(comparatorForBranch),
		.isBranch(isBranch),
		.FLUSH(flush)
	);

	RegisterFile registerFile(
		.clk(clk),
		.rst(rst),
		.read_reg1(Rs_out_IF_ID),
		.read_reg2(Rt_out_IF_ID),
		.write_reg(reg_dest_out_MEM_WB),
		.write_value(write_out_data_WB_out),
		.regWrite(WB_control_signals_MEM_WB[1]),
		.read_data1(R1_out_reg_file),
		.read_data2(R2_out_reg_file),
		.comparatorForBranch(comparatorForBranch)
	);

	// in case of flush make input controll signalls zero
	wire[1:0] to_ID_EX_WB_control_signals_controller = hold_IF_ID ? 0 : WB_control_signals_controller;
	wire[3:0] to_ID_EX_M_control_signals_controller  = hold_IF_ID ? 0 : M_control_signals_controller;
	wire[6:0] to_ID_EX_EX_control_signals_controller = hold_IF_ID ? 0 : EX_control_signals_controller;
	ID_EX reg_ID_EX(
		.clk(clk),
		.rst(rst),
		.read_data1(R1_out_reg_file),
		.read_data2(R2_out_reg_file),
		.r1(R1_out_ID_EX),
		.r2(R2_out_ID_EX),
		.offset(offset_out_IF_ID),
		.Rt(Rt_out_IF_ID),
		.Rs(Rs_out_IF_ID),
		.Rd(Rd_out_IF_ID),
		.control_signals_WB(to_ID_EX_WB_control_signals_controller),
		.control_signals_M (to_ID_EX_M_control_signals_controller),
		.control_signals_EX(to_ID_EX_EX_control_signals_controller),
		.out_control_signals_WB(WB_control_signals_ID_EX),
		.out_control_signals_M(M_control_signals_ID_EX),
		.out_control_signals_EX(EX_control_signals_ID_EX),
		.Rt_out(Rt_out_ID_EX),
        .Rs_out(Rs_out_ID_EX),
        .Rd_out(Rd_out_ID_EX),
		.offset_out(offset_out_ID_EX)
	);

	EX_Stage eX_Stage(
		.fwdA(forwardA),
		.fwdB(forwardB),
		.offset_in(offset_out_ID_EX),
		.ID_EX_op1(R1_out_ID_EX),
		.ID_EX_op2(R2_out_ID_EX),
		.EX_MEM_op1(ALU_result_out_EX_MEM),
		.EX_MEM_op2(ALU_result_out_EX_MEM),
		.MEM_WB_op1(write_out_data_WB_out),
		.MEM_WB_op2(write_out_data_WB_out),
		.signals(EX_control_signals_ID_EX),
		.result(ALU_out_result),

		.Rt(Rt_out_ID_EX),
		.Rs(Rs_out_ID_EX),
		.Rd(Rd_out_ID_EX),
		.reg_dest(reg_dest_out_EX_stage),
		.op2_out(op2_out_EX_stage)
	);

	ForwardingUnit forwardingUnit(
		.Rt_ID_EX(Rt_out_ID_EX),
		.Rs_ID_EX(Rs_out_ID_EX),
		.Rd_EX_MEM(reg_dest_out_EX_MEM),
		.Rd_MEM_WB(reg_dest_out_MEM_WB),
		.Reg_Write_MEM_WB(WB_control_signals_MEM_WB[1]),
		.Reg_Write_EX_MEM(WB_control_signals_EX_MEM[1]),
		.fwdA(forwardA),
		.fwdB(forwardB)
	);

	EX_MEM reg_EX_MEM(
		.clk(clk),
		.rst(rst),
		.result(ALU_out_result),
		.write_data(op2_out_EX_stage),
		.RegDest(reg_dest_out_EX_stage),
		.control_signals_WB(WB_control_signals_ID_EX),
		.control_signals_M(M_control_signals_ID_EX),

		.RegDestOut(reg_dest_out_EX_MEM),
		.control_signals_M_out(M_control_signals_EX_MEM),
		.control_signals_WB_out(WB_control_signals_EX_MEM),
		.result_out(ALU_result_out_EX_MEM),
		.write_data_out(write_data_out_EX_MEM)
	);

	DataMemory dataMemory(
		.clk(clk),
		.addr(ALU_result_out_EX_MEM),
		.write_enable(M_control_signals_EX_MEM[0]),
		.mem_read(M_control_signals_EX_MEM[1]),
		.write_data(write_data_out_EX_MEM),
		.read_data(data_memory_read_data_out)
	);

	MEM_WB reg_MEM_WB(
		.clk(clk),
		.rst(rst),
		.control_signal_WB(WB_control_signals_EX_MEM),
		.ALU_result(ALU_result_out_EX_MEM),
		.MEM_read_data(data_memory_read_data_out),
		.result_out(result_out_MEM_WB),
		.read_data_out(read_data_out_MEM_WB),
		.reg_dst_EX_MEM(reg_dest_out_EX_MEM),
		.control_signal_WB_out(WB_control_signals_MEM_WB),
		.reg_dst_out(reg_dest_out_MEM_WB)
	);

	WB_stage wB_stage(
		.read_data(read_data_out_MEM_WB),
		.ALU_result(result_out_MEM_WB),
		.MemToReg(WB_control_signals_MEM_WB[0]),
		.write_out_data(write_out_data_WB_out)
	);

endmodule
