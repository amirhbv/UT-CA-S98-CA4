`timescale 1ns/1ns

module DataMemory(
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

	initial begin
	  for ( integer i = 0 ; i < 1024 ; i = i + 1) MEM[i] = 32'b0 ;
		MEM[0] =  5;
		MEM[1] = 10;
		MEM[2] = 1;
		MEM[3] = 20;
		MEM[4] = 25;

		MEM[1000] =  5;
		MEM[1001] = 10;
		MEM[1002] = 1;
		MEM[1003] = 20;
		MEM[1004] = 25;
	end
endmodule
