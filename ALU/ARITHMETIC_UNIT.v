module ARITHMETIC_UNIT #(parameter IN_WIDTH = 16,parameter OUT_WIDTH = 32)
(
    input wire signed [IN_WIDTH-1:0] A,B,
    input wire [1:0]      ALU_FUN,
    input wire CLK, RST,
    input wire Arith_Enable,
    output reg signed [OUT_WIDTH-1:0] Arith_OUT,
    output reg  Carry_OUT,
    output reg Arith_Flag
);
always @(posedge CLK ,negedge RST)
begin
    Arith_OUT <= 'b0;
    Carry_OUT <= 1'b0;
    if (!RST)
    begin
        Arith_OUT <= 'b0;
        Carry_OUT <= 1'b0;
        Arith_Flag <= 1'b0;
    end
    else if (Arith_Enable)
    begin
        Arith_Flag = Arith_Enable;
        case (ALU_FUN)
            2'b00:
            begin
                {Carry_OUT,Arith_OUT} <= A + B;
            end
            2'b01:
            begin
                {Carry_OUT,Arith_OUT} <= A - B;
            end
            2'b10:
            begin
                {Carry_OUT,Arith_OUT} <= A * B;
            end
            2'b11:
            begin
                {Carry_OUT,Arith_OUT} <= A / B;
            end
            default 
            begin
                 Arith_OUT <= 'b0;
                 Carry_OUT <= 1'b0;
            end
        endcase
    end
    else
    begin
        Arith_OUT <= 'b0;
        Carry_OUT <= 1'b0;
        Arith_Flag <= 1'b0;
    end
end
endmodule
