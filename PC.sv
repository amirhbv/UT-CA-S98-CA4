module PC(
    input clk, rst,
    input PCsrc, holdPC,
    input[31:0] jVal,
    output[31:0] PCVal
);
    reg[31:0] value ;
    always @(posedge rst , posedge clk) begin
        if ( rst )
            value <= 10'b0 ;
        else if ( holdPC == 0 ) begin
            if (PCsrc)  value <= jVal ;
            else value <= value + 4 ;
        end
    end
endmodule