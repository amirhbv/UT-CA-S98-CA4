module MEM_WB(
    input clk, rst,
    input[1:0] control_signal_WB,
    input[31:0] ALU_result, MEM_read_data,
    output[31:0] result_out, read_data_out
); 
    reg[ 1:0] reg_control_signal_WB ;
    reg[31:0] reg_ALU_result , reg_MEM_read_data ;
    
    assign result_out = reg_ALU_result ;
    assign read_data_out = reg_MEM_read_data ;

    always @(posedge clk, rst) begin
        if ( rst ) begin
            reg_control_signal_WB <= 2'b0 ;
            reg_ALU_result <= 32'b0 ;
            reg_MEM_read_data <= 32'b0 ;
        end else begin
            reg_control_signal_WB <= control_signal_WB ;
            reg_ALU_result <= ALU_result ;
            reg_MEM_read_data <= MEM_read_data ;
        end
    end

endmodule 