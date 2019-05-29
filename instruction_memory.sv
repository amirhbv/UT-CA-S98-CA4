`timescale 1ns/1ns

module InstructionMemory(
    input[31:0] addr,
    output[31:0] inst_out
);
    reg[7:0] mem[0:1023] ;

	wire[9:0] address;
	assign address = addr[9:0];

	assign inst_out = {mem[address], mem[address + 1], mem[address + 2], mem[address + 3]};

	initial begin
		{mem[0], mem[0 + 1], mem[0 + 2], mem[0 + 3]} = { 6'b100011, 5'b00001, 5'b00010, 5'b00000, 5'b00000, 6'b000000 } ; // LW  R1, R2, 0
		{mem[4], mem[4 + 1], mem[4 + 2], mem[4 + 3]} = { 6'b000000, 5'b00001, 5'b00010, 5'b00011, 5'b00000, 6'b100000 } ; // ADD R1, R2, R3
	end
endmodule
