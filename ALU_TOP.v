module ALU_TOP #(parameter IN_WIDTH = 16,parameter OUT_WIDTH_A = 32,OUT_WIDTH = 16)
(
	input wire signed [IN_WIDTH-1:0]  A,B,
	input wire [3:0]   ALU_FUN,
	input wire		   CLK,RST,
	output wire signed [OUT_WIDTH_A-1:0] Arith_OUT, 
	output wire [OUT_WIDTH-1:0] Logic_OUT, CMP_OUT, Shift_OUT,
	output wire  Carry_OUT,
	output wire	Arith_Flag, Logic_Flag, CMP_Flag, Shift_Flag
);
wire Arith_Enable;
wire Logic_Enable;
wire CMP_Enable;
wire Shift_Enable;
DECODER_UNIT D_DUT
(
    .ALU_FUN(ALU_FUN[3:2]),
    .Arith_Enable(Arith_Enable),
    .Logic_Enable(Logic_Enable),
    .CMP_Enable(CMP_Enable),
    .Shift_Enable(Shift_Enable)
);
ARITHMETIC_UNIT #(.IN_WIDTH(IN_WIDTH),.OUT_WIDTH(OUT_WIDTH_A)) A_DUT
(
    .A (A),
    .B (B),
    .ALU_FUN       (ALU_FUN[1:0]),
    .Arith_Enable  (Arith_Enable),
    .Arith_Flag    (Arith_Flag),
    .Arith_OUT     (Arith_OUT),
    .Carry_OUT     (Carry_OUT),
    .CLK  (CLK),
    .RST  (RST)
);
LOGIC_UNIT #(.IN_WIDTH(IN_WIDTH),.OUT_WIDTH(OUT_WIDTH)) L_DUT
(
  .A (A),
  .B (B),
  .ALU_FUN      (ALU_FUN[1:0]),
  .Logic_Enable (Logic_Enable),
  .Logic_Flag   (Logic_Flag),
  .Logic_OUT    (Logic_OUT),
  .CLK (CLK),
  .RST (RST)  
);
CMP_UNIT #(.IN_WIDTH(IN_WIDTH),.OUT_WIDTH(OUT_WIDTH)) CMP_DUT
(
  .A (A),
  .B (B),
  .ALU_FUN    (ALU_FUN[1:0]),
  .CMP_Enable (CMP_Enable),
  .CMP_Flag   (CMP_Flag),
  .CMP_OUT    (CMP_OUT),
  .CLK (CLK),
  .RST (RST)  
);
SHIFT_UNIT #(.IN_WIDTH(IN_WIDTH),.OUT_WIDTH(OUT_WIDTH)) S_DUT
(
    .A (A),
    .B (B),
    .ALU_FUN      (ALU_FUN[1:0]),
    .Shift_Enable (Shift_Enable),
    .Shift_Flag   (Shift_Flag),
    .Shift_OUT    (Shift_OUT),
    .CLK (CLK),
    .RST (RST)
    
);
endmodule