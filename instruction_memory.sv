`timescale 1ns/1ns

module InstructionMemory(
    input[31:0] addr,
    output[31:0] inst_out
);
    reg[7:0] mem[0:1023] ;

	wire address;
	assign address = addr[9:0];

	assign inst_out = {instMem[address], instMem[address + 1], instMem[address + 2], instMem[address + 3]};
endmodule
