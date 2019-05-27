module instruction_memory
    input[9:0] address,
    output[31:0] inst_out
);
    reg[31:0] mem[0:1023] ;
    assign inst_out = mem[address] ;
endmodule 