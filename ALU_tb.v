`timescale 1us/1ns
module Alu_tb #(parameter IN_WIDTH_tb = 16,parameter OUT_WIDTH_tb_A = 32,parameter OUT_WIDTH_tb = 16)();
    reg signed [IN_WIDTH_tb-1:0]  A_tb,B_tb;
    reg [3:0]   ALU_FUN_tb;
    reg CLK_tb,RST_tb;
    wire signed [OUT_WIDTH_tb_A-1:0] Arith_OUT_tb;
    wire  Carry_OUT_tb;
    wire [OUT_WIDTH_tb-1:0] Logic_OUT_tb, CMP_OUT_tb, Shift_OUT_tb;
    wire    Arith_Flag_tb, Logic_Flag_tb, CMP_Flag_tb, Shift_Flag_tb;
ALU_TOP #(.IN_WIDTH(IN_WIDTH_tb),.OUT_WIDTH(OUT_WIDTH_tb)) ALU_tb
(
  .A (A_tb),
  .B (B_tb),
  .ALU_FUN    (ALU_FUN_tb),
  .Arith_Flag (Arith_Flag_tb),  
  .Logic_Flag (Logic_Flag_tb),
  .CMP_Flag   (CMP_Flag_tb),
  .Shift_Flag (Shift_Flag_tb),
  .Arith_OUT  (Arith_OUT_tb),
  .Carry_OUT  (Carry_OUT_tb),
  .Logic_OUT  (Logic_OUT_tb),
  .CMP_OUT    (CMP_OUT_tb),
  .Shift_OUT  (Shift_OUT_tb),
  .CLK (CLK_tb),
  .RST (RST_tb)
);

always
begin
    #4 CLK_tb  <= 1'b1;
    #6 CLK_tb  <= 1'b0;
end
initial
begin
    CLK_tb  = 1'b0;
    ALU_FUN_tb = 4'b0000;
    A_tb    = 'b0;
    B_tb    = 'b0;
    RST_tb  = 1'b1;
    $display ("# *** TEST CASE 1 -- Addition -- NEG + NEG ***");
    A_tb = -'d4;
    B_tb = -'d10;
    #10 
    if ((Arith_OUT_tb == A_tb + B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Addition %d + %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Addition %d + %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    $display ("# *** TEST CASE 2 -- Addition -- POS + NEG ***");
    A_tb = 'd4;
    B_tb = -'d10;
    #10 
    if ((Arith_OUT_tb == A_tb + B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Addition %d + %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Addition %d + %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    $display ("# *** TEST CASE 3 -- Addition -- NEG + POS ***");
    A_tb = -'d4;
    B_tb = 'd10;
    #10 
    if ((Arith_OUT_tb == A_tb + B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Addition %d + %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Addition %d + %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    $display ("# *** TEST CASE 4 -- Addition -- POS + POS ***");
    A_tb = 'd4;
    B_tb = 'd10;
    #10 
    if ((Arith_OUT_tb == A_tb + B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Addition %d + %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Addition %d + %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    $display ("# *** TEST CASE 5 -- Subtraction -- NEG - NEG ***");
    A_tb = -'d4;
    B_tb = -'d10;
    ALU_FUN_tb = 4'b0001;
    #10 
    if ((Arith_OUT_tb == A_tb - B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Subtraction %d - %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Subtraction %d - %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    $display ("# *** TEST CASE 6 -- Subtraction -- POS - NEG ***");
    A_tb = 'd4;
    B_tb = -'d10;
    #10 
    if ((Arith_OUT_tb == A_tb - B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Subtraction %d - %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Subtraction %d - %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
     $display ("# *** TEST CASE 7 -- Subtraction -- NEG - POS ***");
    A_tb = -'d4;
    B_tb = 'd10;
    #10 
    if ((Arith_OUT_tb == A_tb - B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Subtraction %d - %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Subtraction %d - %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
     $display ("# *** TEST CASE 8 -- Subtraction -- POS - POS ***");
    A_tb = 'd4;
    B_tb = 'd10;
    #10 
    if ((Arith_OUT_tb == A_tb - B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Subtraction %d - %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Subtraction %d - %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
     $display ("# *** TEST CASE 9 -- Multiplication: -- NEG * NEG ***");
    A_tb = -'d4;
    B_tb = -'d10;
    ALU_FUN_tb = 4'b0010;
    #10 
    if ((Arith_OUT_tb == A_tb * B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Multiplication: %d * %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Multiplication: %d * %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
     $display ("# *** TEST CASE 10 -- Multiplication: -- POS * NEG ***");
    A_tb = 'd4;
    B_tb = -'d10;
    #10 
    if ((Arith_OUT_tb == A_tb * B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Multiplication: %d * %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Multiplication: %d * %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
     $display ("# *** TEST CASE 11 -- Multiplication: -- NEG * POS ***");
    A_tb = -'d4;
    B_tb = 'd10;
    #10 
    if ((Arith_OUT_tb == A_tb * B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Multiplication: %d * %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Multiplication: %d * %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
     $display ("# *** TEST CASE 12 -- Multiplication: -- POS * POS ***");
    A_tb = 'd4;
    B_tb = 'd10;
    #10
    if ((Arith_OUT_tb == A_tb * B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Multiplication: %d * %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Multiplication: %d * %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
     $display ("# *** TEST CASE 13 -- Division -- NEG / NEG ***");
    A_tb = -'d4;
    B_tb = -'d10;
    ALU_FUN_tb = 4'b0011;
    #10
    if ((Arith_OUT_tb == A_tb / B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Division: %d / %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Division: %d / %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
     $display ("# *** TEST CASE 14 -- Division -- POS / NEG ***");
    A_tb = 'd4;
    B_tb = -'d10;
    #10
    if ((Arith_OUT_tb == A_tb / B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Division: %d / %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Division: %d / %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
     $display ("# *** TEST CASE 15 -- Division -- NEG / POS ***");
    A_tb = -'d4;
    B_tb = 'd10;
    #10
    if ((Arith_OUT_tb == A_tb / B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Division: %d4 / %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Division: %d / %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
     $display ("# *** TEST CASE 16 -- Division -- POS / POS ***");
    A_tb = 'd4;
    B_tb = 'd10;
    #10
    if ((Arith_OUT_tb == A_tb / B_tb ) && Arith_Flag_tb)
    begin
        $display ("# Division: %d / %d is passed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
    else
    begin
        $display ("# Division: %d / %d is failed = %d",A_tb,B_tb,Arith_OUT_tb);
    end
     $display ("# *** TEST CASE 17 -- Logical Operations  -- ***");
    A_tb = 'b100;
    B_tb = 'b1010;
    ALU_FUN_tb = 4'b0100;
    #10
    if ((Logic_OUT_tb == (A_tb & B_tb)) && (Logic_Flag_tb))
    begin
        $display ("# Logical Operations  %b & %b is passed = %b",A_tb,B_tb,Logic_OUT_tb);
    end
    else
    begin
        $display ("# Logical Operations  %b & %b is failed = %b",A_tb,B_tb,Logic_OUT_tb);
    end
     $display ("# *** TEST CASE 18 -- Logical Operations  -- ***");
    A_tb = 'b100;
    B_tb = 'b1010;
    ALU_FUN_tb = 4'b0110;
    #10
    if ((Logic_OUT_tb == ~(A_tb & B_tb) ) && Logic_Flag_tb)
    begin
        $display ("# Logical Operations  ~(%b & %b) is passed = %b",A_tb,B_tb,Logic_OUT_tb);
    end
    else
    begin
        $display ("# Logical Operations  ~(%b & %b) is failed = %b",A_tb,B_tb,Logic_OUT_tb);
    end
     $display ("# *** TEST CASE 19 -- Logical Operations  -- ***");
    A_tb = 'b100;
    B_tb = 'b1010;
    ALU_FUN_tb = 4'b0101;
    #10
    if ((Logic_OUT_tb == (A_tb | B_tb )) && Logic_Flag_tb)
    begin
        $display ("# Logical Operations  %b | %b is passed = %b",A_tb,B_tb,Logic_OUT_tb);
    end
    else
    begin
        $display ("# Logical Operations  %b | %b is failed = %b",A_tb,B_tb,Logic_OUT_tb);
    end
     $display ("# *** TEST CASE 20 -- Logical Operations  -- ***");
    A_tb = 'b100;
    B_tb = 'b1010;
    ALU_FUN_tb = 4'b0111;
    #10
    if ((Logic_OUT_tb == ~(A_tb | B_tb) ) && Logic_Flag_tb)
    begin
        $display ("# Logical Operations  ~(%b | %b) is passed = %b",A_tb,B_tb,Logic_OUT_tb);
    end
    else
    begin
        $display ("# Logical Operations  ~(%b | %b) is failed = %b",A_tb,B_tb,Logic_OUT_tb);
    end
     $display ("# *** TEST CASE 21 -- Compare Operations  -- ***");
    A_tb = 'b100;
    B_tb = 'b1010;
    ALU_FUN_tb = 4'b1001;
    #10 
    if ( A_tb ==  B_tb )
    begin
        if ((CMP_OUT_tb == 'b1) && CMP_Flag_tb)
        begin
            $display ("# Compare Operations is %b == %b  is passed = %b",A_tb,B_tb,CMP_OUT_tb);
        end
        else
        begin
            $display ("# Compare Operations  is %b == %b is failed = %b",A_tb,B_tb,CMP_OUT_tb);
        end
    end
    else 
    begin
        if ((CMP_OUT_tb == 'b0) && CMP_Flag_tb)
        begin
            $display ("# Compare Operations is %b == %b  is passed = %b",A_tb,B_tb,CMP_OUT_tb);
        end
        else
        begin
            $display ("# Compare Operations  is %b == %b is failed = %b",A_tb,B_tb,CMP_OUT_tb);
        end
    end
     $display ("# *** TEST CASE 22 -- Compare Operations  -- ***");
    A_tb = 'b100;
    B_tb = 'b1010;
    ALU_FUN_tb = 4'b1010;
    #10
    if ( A_tb >  B_tb )
    begin
        if ((CMP_OUT_tb == 'b10) && CMP_Flag_tb)
        begin
            $display ("# Compare Operations is %b > %b  is passed = %b",A_tb,B_tb,CMP_OUT_tb);
        end
        else
        begin
            $display ("# Compare Operations  is %b > %b is failed = %b",A_tb,B_tb,CMP_OUT_tb);
        end
    end
    else 
    begin
        if ((CMP_OUT_tb == 'b0) && CMP_Flag_tb)
        begin
            $display ("# Compare Operations is %b > %b  is passed = %b",A_tb,B_tb,CMP_OUT_tb);
        end
        else
        begin
            $display ("# Compare Operations  is %b > %b is failed = %b",A_tb,B_tb,CMP_OUT_tb);
        end
    end
     $display ("# *** TEST CASE 23 -- Compare Operations  -- ***");
    A_tb = 'b100;
    B_tb = 'b1010;
    ALU_FUN_tb = 4'b1011;
    #10
    if ( A_tb <  B_tb )
    begin
        if ((CMP_OUT_tb == 'b11) && CMP_Flag_tb)
        begin
            $display ("# Compare Operations is %b < %b  is passed = %b",A_tb,B_tb,CMP_OUT_tb);
        end
        else
        begin
            $display ("# Compare Operations  is %b < %b is failed = %b",A_tb,B_tb,CMP_OUT_tb);
        end
    end
    else 
    begin
        if ((CMP_OUT_tb == 'b0) && CMP_Flag_tb)
        begin
            $display ("# Compare Operations is %b < %b  is passed = %b",A_tb,B_tb,CMP_OUT_tb);
        end
        else
        begin
            $display ("# Compare Operations  is %b < %b is failed = %b",A_tb,B_tb,CMP_OUT_tb);
        end
    end
     $display ("# *** TEST CASE 24 -- Shift Operations  -- ***");
    A_tb = 'b100;
    B_tb = 'b1010;
    ALU_FUN_tb = 4'b1100;
    #10 
    if ((Shift_OUT_tb == A_tb >> 1 ) && Shift_Flag_tb)
    begin
        $display ("# Shift Operations  %b >> 1 is passed = %b",A_tb,Shift_OUT_tb);
    end
    else
    begin
        $display ("# Shift Operations  %b >> 1 is failed = %b",A_tb,Shift_OUT_tb);
    end
     $display ("# *** TEST CASE 25 -- Shift Operations  -- ***");
    A_tb = 'b100;
    B_tb = 'b1010;
    ALU_FUN_tb = 4'b1101;
    #10 
    if ((Shift_OUT_tb == A_tb << 1 ) && Shift_Flag_tb)
    begin
        $display ("# Shift Operations  %b << 1 is passed = %b",A_tb,Shift_OUT_tb);
    end
    else
    begin
        $display ("# Shift Operations  %b << 1 is failed = %b",A_tb,Shift_OUT_tb);
    end
     $display ("# *** TEST CASE 26 -- Shift Operations  -- ***");
    A_tb = 'b100;
    B_tb = 'b1010;
    ALU_FUN_tb = 4'b1110;
    #10
    if ((Shift_OUT_tb == B_tb >> 1 ) && Shift_Flag_tb)
    begin
        $display ("# Shift Operations  %b >> 1 is passed = %b",B_tb,Shift_OUT_tb);
    end
    else
    begin
        $display ("# Shift Operations  %b >> 1 is failed = %b",B_tb,Shift_OUT_tb);
    end
    $display ("# *** TEST CASE 27 -- Shift Operations  -- ***");
    A_tb = 'b100;
    B_tb = 'b1010;
    ALU_FUN_tb = 4'b1111;
    #10 
    if ((Shift_OUT_tb == B_tb << 1 ) && Shift_Flag_tb)
    begin
        $display ("# Shift Operations  %b << 1 is passed = %b",B_tb,Shift_OUT_tb);
    end
    else
    begin
        $display ("# Shift Operations  %b << 1 is failed = %b",B_tb,Shift_OUT_tb);
    end
    $display ("# *** TEST CASE 28 -- NO Operations  -- ***");
    A_tb = 'b100;
    B_tb = 'b1010;
    ALU_FUN_tb = 4'b1000;
    #10 
    if ((CMP_OUT_tb == 'b0 ) && (CMP_Flag_tb))
    begin
        $display ("# NO Operations  NOP is passed = %b",CMP_OUT_tb);
    end
    else
    begin
        $display ("# NO Operations  NOP is failed = %b",CMP_OUT_tb);
    end
    $finish;
end
endmodule