module SHIFT_UNIT #(parameter IN_WIDTH = 16,parameter OUT_WIDTH = 16)
(
    input wire [IN_WIDTH-1:0] A,B,
    input wire [1:0]      ALU_FUN,
    input wire CLK, RST,
    input wire Shift_Enable,
    output reg [OUT_WIDTH-1:0] Shift_OUT,
    output reg Shift_Flag  
);
always @(posedge CLK,negedge RST)
begin
    if (!RST)
    begin
        Shift_OUT <= 'b0;
        Shift_Flag <= 1'b0;
    end
    else if (Shift_Enable)
    begin
        Shift_Flag = Shift_Enable;
        case(ALU_FUN)
            2'b00:
            begin
                Shift_OUT <= A >> 1;
            end
            2'b01:
            begin
                Shift_OUT <= A << 1;
            end
            2'b10:
            begin
                Shift_OUT <= B >> 1;
            end
            2'b11:
            begin
                Shift_OUT <= B << 1;
            end
            default
            begin
                Shift_OUT <= 'b0;
            end
        endcase
    end
    else
    begin
        Shift_OUT <= 'b0;
        Shift_Flag <= 1'b0;
    end
end
endmodule