module CRC
(
    input   wire       DATA,
    input   wire       Active,
    input   wire       CLK,
    input   wire       RST,
    output  reg        CRC,
    output  reg        Valid
);

parameter [7 : 0] TAP  = 'b01000100; // TAP defines the sequence
parameter [7 : 0] seed = 'hD8;       // The initial value 

integer i;

reg [7 : 0] LFSR;
reg feedback;
reg [3:0] counter;
reg counter_flag;        // represnt the end of shifting the output.

always @(posedge CLK,negedge RST)
begin
    if (~RST)
    begin
        counter <= 'b0;
        counter_flag <= 1'b0;
    end
    else if (~Active && ~(counter[3]) )
    begin
        counter <= counter + 1;
        counter_flag <= 1'b1; 
    end
    else
    begin
        counter <= 'b0;
        counter_flag <= 1'b0;
    end
end


always @(posedge CLK, negedge RST)
begin
    
    if (~RST)
    begin
        
        CRC     <= 1'b0 ;
        Valid   <= 1'b0 ;
        LFSR    <= seed;
    end
    else if (Active)
    begin
        feedback = LFSR[0] ^ DATA;
        LFSR [7] <= feedback;
        for (i = 6; i >= 0 ; i = i - 1 )
        begin
            if (TAP[i])
            begin
                LFSR[i] <= LFSR [i+1] ^ feedback;
            end
            else
            begin
                LFSR[i] <= LFSR [i+1];
            end
        end
    end
    else if(counter_flag && ~Active)
    begin
        {LFSR[6 : 0],CRC} <= LFSR;
        Valid <= 1'b1;
    end
end
endmodule