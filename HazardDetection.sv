module HazardDetection(
    input[4:0]  Rt_IF_ID,
                Rs_IF_ID,
                Rt_ID_EX,
    input[3:0]  signals_M_ID_EX,
    input[31:0] offset_ID_EX,
    input       zero_ALU,

    output      holdPC,
                IF_ID_Flush,
                mux_selector // todo: fix name
);
    if ( signals_M_ID_EX[1] == 1) begin
        if (Rt_ID_EX == Rs_IF_ID || Rt_ID_EX == Rt_IF_ID)
            holdPC = 1;
            IF_ID_Flush = 1;
    end
endmodule