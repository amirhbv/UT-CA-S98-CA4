`timescale 1ns/1ns

module RegisterFile(
    input clk, rst,
    input[4:0]  read_reg1,
                read_reg2,
                write_reg,
    input       regWrite,
    input[31:0] write_value,
    output [31:0] read_data1,
                read_data2,
    output comparatorForBranch
);
    reg[31:0] mem[0:31] ;
    assign read_data1 = mem[read_reg1] ;
    assign read_data2 = mem[read_reg2] ;
    assign comparatorForBranch = (read_data1 == read_data2) ;
    always @(posedge clk , posedge rst ) begin
        if ( rst )
            for (integer i = 0 ; i < 32 ; i = i + 1)
                mem[i] <= 32'b0 ;
    end

    always @(negedge clk) begin
        if ( write_reg != 0 && regWrite )
            mem[write_reg] <= write_value ;
    end
endmodule
