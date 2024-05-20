module CMP_UNIT #(parameter IN_WIDTH = 16,parameter OUT_WIDTH = 16)
(
    input wire [IN_WIDTH-1:0] A,B,
    input wire [1:0]      ALU_FUN,
    input wire CLK, RST,
    input wire CMP_Enable,
    output reg [OUT_WIDTH-1:0] CMP_OUT,
    output reg CMP_Flag  
);
always @(posedge CLK,negedge RST)
begin
    if (!RST)
    begin
        CMP_OUT <= 'b0;
        CMP_Flag <= 1'b0;
    end
    else if (CMP_Enable)
        begin
            CMP_Flag = CMP_Enable;
            case (ALU_FUN)
                2'b00:
                begin
                    CMP_OUT <= 'b0;
                end
                2'b01:
                begin
                    if (A == B)
                    begin
                        CMP_OUT <= 'b1;
                    end
                    else
                    begin
                        CMP_OUT <= 'b0;
                    end
                end
                2'b10:
                begin
                    if (A > B)
                    begin
                        CMP_OUT <= 'b10;
                    end
                    else
                    begin
                        CMP_OUT <= 'b0;
                    end
                end
                2'b11:
                begin
                    if (A < B)
                    begin
                        CMP_OUT <= 'b11;
                    end
                    else
                    begin
                        CMP_OUT <= 'b0;
                    end
                end
                default 
                begin
                    CMP_OUT <= 'b0;
                end
            endcase
        end
    else
    begin
        CMP_OUT <= 'b0;
        CMP_Flag <= 1'b0;
    end
                    
end
endmodule