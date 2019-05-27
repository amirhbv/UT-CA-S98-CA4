`timescale 1ns/1ns

module ForwardingUnit(
    input[4:0]  Rt_ID_EX,
                Rs_ID_EX,
                Rd_EX_MEM,
                Rd_MEM_WB,
    input       Reg_Write_MEM_WB ,
                Reg_Write_EX_MEM ,
    output reg [2:0] fwdA ,
                fwdB
);
    always @(*) begin
        fwdA = 3'b001 ;
        fwdB = 3'b001 ;
        if (Reg_Write_EX_MEM) begin
            if ( Rd_EX_MEM == Rs_ID_EX )
                fwdA = 3'b010 ;
            if ( Rd_EX_MEM == Rt_ID_EX )
                fwdB = 3'b010 ;
        end

        if (Reg_Write_MEM_WB) begin
            if ( Rd_MEM_WB == Rs_ID_EX )
                fwdA = 3'b100 ;

            if ( Rd_MEM_WB == Rt_ID_EX )
                fwdB = 3'b100 ;
        end
    end
endmodule
