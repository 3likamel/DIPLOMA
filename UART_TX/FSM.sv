module FSM(
	input wire Data_Valid,
	input wire ser_done,
	input wire PAR_EN,
	input CLK ,RST,
	output reg ser_en,
	output reg [1:0] mux_sel,
	output reg busy
);

typedef enum {
		idle,
		start,
		serial,
		parity,
		stop
} state_;

state_	cu_state , nx_state;

always @(posedge CLK,negedge RST)
begin
	if (~RST)
	begin
		cu_state <= idle;
	end
	else
	begin
		cu_state <= nx_state;
	end
end

always @(*)
begin
	case (cu_state)
		idle:
		begin
			if (Data_Valid)
			begin
				nx_state = start; 
			end
			else 
			begin
				nx_state = cu_state;
			end
		end
		start:
		begin
			nx_state = serial;
		end
		serial:
		begin
			if (ser_done)
			begin
				if (PAR_EN)
				begin
					nx_state = parity;
				end
				else 
				begin
					nx_state = stop;
				end
			end
			else
			begin
				nx_state = cu_state;
			end
		end
		parity:
		begin
			nx_state = stop;
		end
		stop:
		begin
			if (Data_Valid)
				begin
					nx_state = start;
				end
				else
					begin
						nx_state = idle;
					end
		end
		default:
		begin
			nx_state = idle;
		end
	endcase
end

always @(*)
begin
	case (cu_state)
		idle:
		begin
			ser_en  = 1'b0;
			busy 	= 1'b0;
			mux_sel = 2'b01;
		end
		start:
		begin
			ser_en  = 1'b0;
			busy 	= 1'b1;
			mux_sel = 2'b00;
		end
		serial:
		begin
			ser_en  = 1'b1;
			busy 	= 1'b1;
			mux_sel = 2'b10;
		end
		parity:
		begin
			ser_en  = 1'b0;
			busy 	= 1'b1;
			mux_sel = 2'b11;
		end
		stop:
		begin
			ser_en  = 1'b0;
			busy 	= 1'b1;
			mux_sel = 2'b01;
		end
		default:
		begin
			ser_en  = 1'b0;
			busy 	= 1'b0;
			mux_sel = 2'b01;
		end
	endcase

end
endmodule
