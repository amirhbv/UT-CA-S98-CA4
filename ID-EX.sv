module ID_EX(
    input clk, rst,
    input[31:0] read_data1,
                read_data2,
    output[31:0] r1,
                 r2,
    input[31:0] offset,
    input[4:0] Rt,
                Rs,
                Rd,
    input[6:0] control_signals_EX,
    input[3:0] control_signals_M ,
    input[1:0] control_signals_WB,
    output[3:0] out_control_signals_M,
    output[6:0] out_control_signals_EX,
    output[1:0] out_control_signals_WB
);

    reg [4:0] reg_Rt ;
    reg [4:0] reg_Rs ;
    reg [4:0] reg_Rd ;

    reg [31:0] reg_offset ;
    reg[6:0] reg_control_signals_EX ;
    reg[3:0] reg_control_signals_M  ;
    reg[1:0] reg_control_signals_WB ;
    
    assign out_control_signals_EX = reg_control_signals_EX ;
    assign out_control_signals_M  = reg_control_signals_M  ;
    assign out_control_signals_WB = reg_control_signals_WB ;

    reg [31:0] reg_r1 , reg_r2  ;
    assign r1 = reg_r1 ;
    assign r2 = reg_r2 ;

    always (@posedge clk , posedge rst) begin
        if ( rst )  begin
            reg_Rt <= 4'b0 ;
            reg_Rs <= 4'b0 ;
            reg_Rd <= 4'b0 ;

            reg_r1 <= 32'b0 ;
            reg_r2 <= 32'b0 ;
            
            reg_control_signals_EX <= control_signals_EX ;
            reg_control_signals_M <= 4'b0 ;
            reg_control_signals_WB <= 2'b0 ;
        end
        else begin
            reg_r1 <= read_data1 ;
            reg_r2 <= read_data2 ;

            reg_Rt <= Rt ;
            reg_Rs <= Rs ;
            reg_Rd <= Rd ;

            reg_offset <= offset ;
        end
    end
endmodule 