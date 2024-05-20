`timescale 1ns/1ns 
module RegFile_tb();
    reg [15:0]    WrData_tb;
    reg [2:0]   Address_tb;
    reg     WrEn_tb , RdEn_tb;
    reg     CLK_tb  ,  RST_tb;
    wire [15:0]  RdData_tb;
RegFile DUT_tb
(
  .Address (Address_tb),
  .CLK     (CLK_tb),
  .RdData  (RdData_tb),
  .RdEn    (RdEn_tb),
  .RST     (RST_tb),
  .WrData  (WrData_tb),
  .WrEn    (WrEn_tb)
);
always#5 CLK_tb <= ~CLK_tb;
initial 
begin
    Address_tb = 3'b010;
    WrData_tb  = 'b11100011;
    WrEn_tb    = 1'b0;
    RdEn_tb    = 1'b0;
    CLK_tb     = 1'b0;
    RST_tb     = 1'b1;
    #10 $display("test 1 write operatiion WrEn = 1, WrData = %b and Adress = %b", WrData_tb, Address_tb);
    WrEn_tb = 1'b1;
    // to make sure that the write operation is done we need to read from the same place
    #10 
    WrEn_tb    = 1'b0;
    RdEn_tb    = 1'b1;
    #10 $display("test 2 read operation RdEn = 1 and Address = %b", Address_tb);
    if (RdData_tb == WrData_tb)
    begin
        $display("test 1 and 2 passed successfully ,RdData = %b", RdData_tb);
    end
    else
    begin
        $display("test 1 and 2 failed,RdData = %b", RdData_tb);
    end
    #10
    WrEn_tb    = 1'b1;
    RdEn_tb    = 1'b0;
    Address_tb = 3'b110;
    WrData_tb  = 'b10101011;
    $display("test 3 write operatiion WrEn = 1, WrData = %b and Adress = %b", WrData_tb, Address_tb);
    #10
    WrEn_tb    = 1'b0;
    RdEn_tb    = 1'b1;
    #10 $display("test 4 read operation RdEn = 1 and Address = %b", Address_tb);
    if (RdData_tb == WrData_tb)
    begin
        $display("test 3 and 4 passed successfully ,RdData = %b", RdData_tb);
    end
    else
    begin
        $display("test 3 and 4 failed,RdData = %b", RdData_tb);
    end
    $finish;
end
endmodule