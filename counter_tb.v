`timescale 1ns/1ps
module counter_tb();
    reg [4:0] IN_tb;
    reg CLK_tb;
    reg Load_tb, Up_tb, Down_tb;
    wire High_tb, Low_tb;
    wire [4:0] Counter_tb;
    counter DUT (
      .IN(IN_tb),
      .CLK(CLK_tb),
      .Load(Load_tb),
      .Down(Down_tb),
      .Up(Up_tb),
      .High(High_tb),
      .Low(Low_tb),
      .Counter(Counter_tb)
    );
    always #5 CLK_tb = ~CLK_tb;
    initial
    begin
        $dumpfile("Counter.VCS");
        $dumpvars;
        CLK_tb = 0;
        IN_tb = 5'b00111;
        Load_tb = 0;
        Up_tb = 0;
        Down_tb = 0;
        #10 $display("test 1, Load and priority test");
        Load_tb = 1;
        Down_tb = 1;
        #10 
        if (Counter_tb == IN_tb)
            begin
                $display("test 1 passed, Counter = %b", Counter_tb);
            end
        else
            begin
                $display("test 1 failed, Counter = %b", Counter_tb);
            end
        $display("test 2, decreament and priority test");
        Load_tb = 0; 
        Up_tb = 1;
        #10 
        if (Counter_tb == 5'b00110)
            begin
                $display("test 2 passed, Counter = %b", Counter_tb);
            end
        else
            begin
                $display("test 2 failed, Counter = %b", Counter_tb);
            end
        $display("test 3, Up test");
        Down_tb=0;
        #10 
        if (Counter_tb == 5'b00111)
            begin
                $display("test 3 passed, Counter = %b", Counter_tb);
            end
        else
            begin
                $display("test 3 failed, Counter = %b", Counter_tb);
            end
        $display("test 3, Up to max (high) test");
        #260 
        if (Counter_tb == 5'b11111 && High_tb == 1'b1)
            begin
                $display("test 4 passed, Counter = %b, High = %b", Counter_tb,High_tb);
            end
        else
            begin
                $display("test 4 failed, Counter = %b, High = %b", Counter_tb,High_tb);
            end
        $display("test 5, decreament to zero (Low) test");
        Down_tb=1;
        #370 
        if (Counter_tb == 5'b00000 && Low_tb == 1'b1)
            begin
                $display("test 5 passed, Counter = %b, Low = %b", Counter_tb,Low_tb);
            end
        else
            begin
                $display("test 5 failed, Counter = %b, Low = %b", Counter_tb,Low_tb);
            end
        $display("test finished.");
        $stop;
    end
endmodule

