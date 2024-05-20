module RegFile(
    input wire [15:0]    WrData,
    input wire [2:0]  Address,
    input wire WrEn , RdEn,
    input wire CLK ,  RST,
    output reg [15:0]  RdData
);
reg [15:0] Reg_File [7:0] ;
always @(posedge CLK, negedge RST)
begin
    // to avoid latch
        Reg_File [0]  <= 'b0;
        Reg_File [1]  <= 'b0;
        Reg_File [2]  <= 'b0;
        Reg_File [3]  <= 'b0;
        Reg_File [4]  <= 'b0;
        Reg_File [5]  <= 'b0;
        Reg_File [6]  <= 'b0;
        Reg_File [7]  <= 'b0;
    if (!RST)
    begin
        Reg_File [0]  <= 'b0;
        Reg_File [1]  <= 'b0;
        Reg_File [2]  <= 'b0;
        Reg_File [3]  <= 'b0;
        Reg_File [4]  <= 'b0;
        Reg_File [5]  <= 'b0;
        Reg_File [6]  <= 'b0;
        Reg_File [7]  <= 'b0;
    end
    else if (WrEn)
    begin
        Reg_File [Address] <= WrData;
    end
    else if (RdEn)
    begin
        RdData <= Reg_File[Address];
    end    
end
endmodule
