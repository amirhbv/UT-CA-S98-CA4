`timescale 1ns/1ns

module ID_EX(
    input clk, rst,
    input[31:0] read_data1,
                read_data2,
    output reg[31:0] r1,
                 r2,
    input[31:0] offset,
    input[4:0]  Rt,
                Rs,
                Rd,
    input[6:0] control_signals_EX,
    input[3:0] control_signals_M ,
    input[1:0] control_signals_WB,
    output reg[3:0] out_control_signals_M,
    output reg[6:0] out_control_signals_EX,
    output reg[1:0] out_control_signals_WB,
	  output reg[4:0] Rt_out,
                Rs_out,
                Rd_out,
	  output reg[31:0] offset_out
);
    always @(posedge clk , posedge rst) begin
        if ( rst )  begin
            Rt_out <= 4'b0 ;
            Rs_out <= 4'b0 ;
            Rd_out <= 4'b0 ;

            r1 <= 32'b0 ;
            r2 <= 32'b0 ;
            
            offset_out <= 32'b0 ;
            out_control_signals_EX <= control_signals_EX ;
            out_control_signals_M <= 4'b0 ;
            out_control_signals_WB <= 2'b0 ;
        end
        else begin
            r1 <= read_data1 ;
            r2 <= read_data2 ;

            Rt_out <= Rt ;
            Rs_out <= Rs ;
            Rd_out <= Rd ;

            offset_out <= offset ;
            out_control_signals_EX <= control_signals_EX ;
            out_control_signals_M <=  control_signals_M ;
            out_control_signals_WB <= control_signals_WB ;
        end
    end
endmodule
