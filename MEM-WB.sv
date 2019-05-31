`timescale 1ns/1ns

module MEM_WB(
    input clk, rst,
    input[1:0] control_signal_WB,
	input[4:0] reg_dst_EX_MEM,
    input[31:0] ALU_result,
				MEM_read_data,
    output reg[31:0] result_out,
				read_data_out,
	output reg[1:0] control_signal_WB_out,
	output  reg[4:0] reg_dst_out
);
    always @(posedge clk, posedge rst) begin
        if ( rst ) begin
            control_signal_WB_out <= 2'b0;
            result_out <= 32'b0;
            read_data_out <= 32'b0;
			reg_dst_out <= 5'b0;
        end else begin
            control_signal_WB_out <= control_signal_WB;
            result_out <= ALU_result;
            read_data_out <= MEM_read_data;
			reg_dst_out <= reg_dst_EX_MEM;
        end
    end

endmodule
