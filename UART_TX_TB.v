`timescale 1us/1ns 

module UART_TX_TB #(parameter Data_WD_tb = 8) ();

parameter clock_period = 8.68;

reg	[Data_WD_tb-1 : 0]		P_DATA_tb;
reg							Data_Valid_tb;
reg							PAR_EN_tb;
reg							PAR_TYP_tb;
reg							start_bit_tb;
reg							stop_bit_tb;
reg							CLK_tb;
reg							RST_tb;
wire						TX_OUT_tb;
wire						busy_tb;


////////////////// Clock Genneration  ////////////////////
always #(clock_period/2.0)		CLK_tb <= ~CLK_tb;

////////////////// DUT Instantation  ////////////////////
UART_TX #(.Data_WD(Data_WD_tb)) DUT (
	.P_DATA    (P_DATA_tb),
	.Data_Valid(Data_Valid_tb),
	.PAR_EN    (PAR_EN_tb),
	.PAR_TYP   (PAR_TYP_tb),
	.start_bit (start_bit_tb),
	.stop_bit  (stop_bit_tb),
	.TX_OUT    (TX_OUT_tb),
	.busy      (busy_tb),
	.CLK       (CLK_tb),
	.RST       (RST_tb)
);

///////////////////////// RESET /////////////////////////
task reset;
	begin
		RST_tb = 1'b1;
		#(clock_period)
		RST_tb = 1'b0;
		#(clock_period)
		RST_tb = 1'b1;
	end
endtask 

/////////////// Signals Initialization //////////////////
task intialize;
	begin
		P_DATA_tb     = 'b0;
		Data_Valid_tb = 1'b0;
		PAR_EN_tb     = 1'b0;
		PAR_TYP_tb	  = 1'b0;
		start_bit_tb  = 1'b0;
		stop_bit_tb	  = 1'b0;
		CLK_tb		  = 1'b0;
	end
endtask

/////////// Transmitting Data with Parity Disabled //////////
task Transmitting_without_parity;
	input [Data_WD_tb - 1 : 0] Data;
	input [Data_WD_tb + 1 : 0] expec_out;
	input [2:0] test_num;

	integer i;
	reg	[Data_WD_tb + 1 : 0] gener_out;

	begin
		Data_Valid_tb = 1'b1;
		P_DATA_tb     = Data;
		PAR_EN_tb 	  = 1'b0;
		#(clock_period)
		Data_Valid_tb = 1'b0;

		for (i = 0; i < Data_WD_tb + 2; i = i + 1) 
		begin
			 #(clock_period) gener_out [i] = TX_OUT_tb; 
		end

		$display( "  *****Test %d Transmitting Data with Parity Disabled*****  ", test_num);
		if ((gener_out == expec_out) && (busy_tb))
			begin
				$display("	test %d succeed \n", test_num);
			end
		else
			begin
				$display("	test %d failed \n", test_num);
			end


	end
endtask

/////////// Transmitting Data with Even Parity Ednabled //////////
task Transmitting_with_even_parity;
	input [Data_WD_tb - 1 : 0] Data;
	input [Data_WD_tb + 2 : 0] expec_out;
	input [2:0] test_num;
	
	integer i;
	reg	[Data_WD_tb + 2 : 0] gener_out;

	begin
		Data_Valid_tb = 1'b1;
		P_DATA_tb     = Data;
		PAR_EN_tb 	  = 1'b1;
		PAR_TYP_tb	  = 1'b0;
		#(clock_period)
		Data_Valid_tb = 1'b1;

		for (i = 0; i < Data_WD_tb + 3; i = i + 1) 
		begin
			 #(clock_period) gener_out [i] = TX_OUT_tb; 
		end

		$display( "  *****Test %d Transmitting Data with Even Parity Ednabled*****  ", test_num);
		if ((gener_out == expec_out) && (busy_tb))
			begin
				$display("	test %d succeed \n", test_num);
			end
		else
			begin
				$display("	test %d failed \n", test_num);
			end
	end
endtask

/////////// Transmitting Data with Odd Parity Ednabled //////////
task Transmitting_with_odd_parity;
	input [Data_WD_tb - 1 : 0] Data;
	input [Data_WD_tb + 2 : 0] expec_out;
	input [2:0] test_num;

	integer i;
	reg	[Data_WD_tb + 2 : 0] gener_out;

	begin
		Data_Valid_tb = 1'b1;
		P_DATA_tb     = Data;
		PAR_EN_tb 	  = 1'b1;
		PAR_TYP_tb	  = 1'b1;
		#(clock_period)
		Data_Valid_tb = 1'b1;

		for (i = 0; i < Data_WD_tb + 3; i = i + 1) 
		begin
			 #(clock_period) gener_out [i] = TX_OUT_tb; 
		end

		$display( "  *****Test %d Transmitting Data with Odd Parity Ednabled*****  ", test_num);
		if ((gener_out == expec_out) && (busy_tb))
			begin
				$display("	test %d succeed \n", test_num);
			end
		else
			begin
				$display("	test %d failed \n", test_num);
			end
	end
endtask



initial
begin
	$dumpfile("UART_TX_TB.vsc");
	$dumpvars;

	intialize();

	reset();

	/////////// Transmitting Data with Parity Disabled //////////
	Transmitting_without_parity   (8'b10101010,10'b0101010100,1);
	Transmitting_without_parity   (8'b10111010,10'b0101110100,2);
	Transmitting_without_parity   (8'b10100010,10'b0101000100,3);

	/////////// Transmitting Data with Even Parity Ednabled /////
	Transmitting_with_even_parity (8'b10101010,11'b00101010100,1);   // even  input data
	Transmitting_with_even_parity (8'b10111010,11'b01101110100,2);	 // odd   input data
	Transmitting_with_even_parity (8'b10100010,11'b01101000100,3);   // odd   input data

	/////////// Transmitting Data with Odd Parity Ednabled //////
	Transmitting_with_odd_parity  (8'b10101010,11'b01101010100,1);	 // even  input data
	Transmitting_with_odd_parity  (8'b10111010,11'b00101110100,2);	 // odd   input data
	Transmitting_with_odd_parity  (8'b10100110,11'b01101001100,3);   // even  input data

	#100;
	$finish;
end

endmodule