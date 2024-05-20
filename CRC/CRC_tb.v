`timescale 1ns/1ps

module CRC_tb ();

parameter Serial_width_tb = 8;
parameter test_cases_num = 10;
parameter clock_period = 100;

reg DATA_tb;
reg Active_tb;
reg CLK_tb;
reg RST_tb;
wire CRC_tb;
wire Valid_tb;

reg [Serial_width_tb-1 : 0] test_cases [test_cases_num -1 : 0];
reg [Serial_width_tb-1 : 0] expected_outs [test_cases_num -1 : 0];
 
integer operation;

////////////////// initial block /////////////////////// 

initial
begin
    $dumpfile("CRC.vsc");
    $dumpvars;
    
    $readmemh("DATA_h.txt",test_cases);
    $readmemh("Expec_Out_h.txt",expected_outs);
    
    initialize();
    
    for (operation = 0; operation < test_cases_num ; operation = operation + 1)
        begin
            do_operation(test_cases[operation]);
            check_out(expected_outs[operation],operation);
        end
    #100
    $finish;
end

/////////////// Signals Initialization //////////////////

task initialize;
    begin
        DATA_tb     = 'b0 ;
        Active_tb   = 'b0 ;
        CLK_tb      = 'b0 ;
        RST_tb      = 'b0 ;
    end
endtask
 
///////////////////////// RESET /////////////////////////

task reset;
    begin
        RST_tb = 1'b1;
        # (clock_period)
        RST_tb = 1'b0;
        # (clock_period)
        RST_tb = 1'b1;
    end
endtask

////////////////// Do CRC Operation  ////////////////////
 
task do_operation;
    input [Serial_width_tb - 1 : 0] in_seed;
    reg    [Serial_width_tb-1:0]     gener_out ;
    
    integer oper;
    
    begin
        reset();
        #(clock_period)
        Active_tb = 1'b1;
        for (oper = 0; oper < Serial_width_tb; oper = oper + 1)
        begin
            DATA_tb = in_seed[oper];
            #(clock_period);
        end
        Active_tb = 1'b0;

    end
endtask

////////////////// Check Out Response  ////////////////////

task check_out ;
 input  reg     [Serial_width_tb-1:0]     expec_out ;
 input  integer                           Oper_Num ; 

 integer x ;
 
 reg    [Serial_width_tb-1:0]     gener_out ;

 begin
  @(posedge Valid_tb)
        begin
         for(x=0; x<8; x=x+1)
         begin
            #(clock_period) gener_out[x] = CRC_tb ;
         end
         if(gener_out == expec_out) 
         begin
            $display("Test Case %d is succeeded",Oper_Num);
         end
         else
         begin
            $display("Test Case %d is failed", Oper_Num);
         end
        end
 end
endtask

////////////////// Clock Genneration  ////////////////////
// 
always #(clock_period/2) CLK_tb <= ~CLK_tb;

////////////////// DUT Instantation  ////////////////////

CRC DUT
(
    .DATA   (DATA_tb),
    .Active (Active_tb),
    .CLK    (CLK_tb),
    .RST    (RST_tb),
    .CRC    (CRC_tb),
    .Valid  (Valid_tb)
);
endmodule
