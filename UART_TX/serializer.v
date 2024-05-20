module serializer  #(parameter Data_WD = 8)
(
	input  wire [Data_WD -1 : 0] 	P_DATA,
	input  wire 					Data_Valid,
	input  wire 					ser_en,
	input  wire						CLK,RST,
	output reg						ser_data,
	output wire						ser_done
);


reg [3:0] count;
reg [Data_WD-1:0] s_data;
wire count_max;

always @(posedge CLK or negedge RST) begin 
	if(~RST) begin
		s_data   <= 0;
	end
	else if (Data_Valid) begin
		s_data   <= P_DATA;
	end
end

always @(posedge CLK)
begin
	if (count_max)
		begin
			ser_data = 0;
		end
		else
			begin
				ser_data = s_data [count];
			end
end

always@(posedge CLK or negedge RST)
       begin
          if(!RST)
            count <= 4'b1000;
          else if (~ser_en)
            begin
            	count    <= 4'b0 ;
            end			
          else if (!count_max)
            begin
            	count 	 <= count + 4'b1 ;
            end
       end
   

   assign count_max = ( count == 4'b1000 );
   assign ser_done  = count_max;
endmodule
