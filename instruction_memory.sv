`timescale 1ns/1ns

module InstructionMemory(
    input[31:0] addr,
    output[31:0] inst_out
);
    reg[7:0] mem[0:1023] ;

	wire[9:0] address;
	assign address = addr[9:0];
  	assign inst_out = {mem[address], mem[address + 1], mem[address + 2], mem[address + 3]} ;
	/*
	always @(posedge clk) begin
		inst_out <= {mem[address], mem[address + 1], mem[address + 2], mem[address + 3]} ;
	end*/
	initial begin
	  for ( integer i = 0 ; i < 1024 ; i = i + 1) begin
	    mem[i] = 8'b0 ;
	  end
		{mem[ 0], mem[ 0 + 1], mem[ 0 + 2], mem[ 0 + 3]} = { 6'b100011, 5'b00011, 5'b00001, 5'b00000, 5'b00000, 6'b000000 } ; // LW  R1, R3, 0
		{mem[ 4], mem[ 4 + 1], mem[ 4 + 2], mem[ 4 + 3]} = { 6'b100011, 5'b00010, 5'b00011, 5'b00000, 5'b00000, 6'b000001 } ; // LW  R2, R3, 1
		{mem[ 8], mem[ 8 + 1], mem[ 8 + 2], mem[ 8 + 3]} = { 6'b100011, 5'b00001, 5'b00011, 5'b00000, 5'b00000, 6'b000010 } ; // LW  R1, R3, 0
		{mem[12], mem[12 + 1], mem[12 + 2], mem[12 + 3]} = { 6'b100011, 5'b00001, 5'b00011, 5'b00000, 5'b00000, 6'b000010 } ; // LW  R1, R3, 0
		{mem[16], mem[16 + 1], mem[16 + 2], mem[16 + 3]} = { 6'b100011, 5'b00001, 5'b00011, 5'b00000, 5'b00000, 6'b000010 } ; // LW  R1, R3, 0
		{mem[20], mem[20 + 1], mem[20 + 2], mem[20 + 3]} = { 6'b000000, 5'b00001, 5'b00010, 5'b00011, 5'b00000, 6'b100011 } ; // ADD R3, R1, R2
	end
endmodule
