module DATA_MEMORY(
    input clk,
    input[31:0] addr,
    input write_enable,
    input mem_read,
    input[31:0] write_data,
    output[31:0] read_data
);
    reg[31:0] MEM [0:1023];

    assign read_data = MEM[ addr[9:0] ] ;
    always @(negedge clk)   begin
        if ( write_enable )
            MEM[ addr[9:0] ] <= write_data ;
    end
endmodule 