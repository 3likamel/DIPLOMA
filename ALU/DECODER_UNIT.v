module DECODER_UNIT(
    input wire [1:0] ALU_FUN,
    output reg Arith_Enable, Logic_Enable, CMP_Enable, Shift_Enable
);
always @(*)
begin
    Arith_Enable = 1'b0;
    Logic_Enable = 1'b0;
    CMP_Enable   = 1'b0;
    Shift_Enable = 1'b0;
    case (ALU_FUN)

        2'b00:
        begin
            Arith_Enable = 1'b1;
        end
        2'b01:
        begin
            Logic_Enable = 1'b1;
        end
        2'b10:
        begin
            CMP_Enable   = 1'b1;
        end
        2'b11:
        begin
            Shift_Enable = 1'b1;
        end
        default
        begin
            Arith_Enable = 1'b0;
            Logic_Enable = 1'b0;
            CMP_Enable   = 1'b0;
            Shift_Enable = 1'b0;
        end    
    endcase
end
endmodule
