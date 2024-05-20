module counter(
    input wire [4:0] IN,
    input wire CLK,
    input wire Load,Up,Down,
    output wire High,Low,
    output reg [4:0] Counter
);
always @(posedge CLK)
begin
    if (Load)
    begin
        Counter <= IN;
    end
else if (Down && !Low )
    begin
        Counter <= Counter - 5'b00001;
    end
else if (Up && !High)
    begin
        Counter <= Counter + 5'b00001;
    end
end
assign Low = (Counter == 5'b00000) ? 1 : 0;
assign High = (Counter == 5'b11111) ? 1 : 0;
endmodule
