module LOGIC_UNIT #(parameter IN_WIDTH = 16,parameter OUT_WIDTH = 16)
(
    input wire [IN_WIDTH-1:0] A,B,
    input wire [1:0]      ALU_FUN,
    input wire CLK, RST,
    input wire Logic_Enable,
    output reg [OUT_WIDTH-1:0] Logic_OUT,
    output reg Logic_Flag
);

always @(posedge CLK,negedge RST)
begin
    if (!RST)
    begin
        Logic_OUT <= 'b0;
        Logic_Flag <= 1'b0;
    end
    else if (Logic_Enable)
        begin
            Logic_Flag = Logic_Enable;
            case (ALU_FUN)
                2'b00:
                begin
                    Logic_OUT <= A & B;
                end
                2'b01:
                begin
                    Logic_OUT <= A | B;
                end
                2'b10:
                begin
                    Logic_OUT <= ~(A & B);
                end
                2'b11:
                begin
                    Logic_OUT <= ~(A | B);
                end
                default 
                begin
                    Logic_OUT <= 'b0;
                end
            endcase
        end   
    else
    begin
        Logic_OUT <= 'b0;
        Logic_Flag <= 1'b0;
    end  
end
endmodule
