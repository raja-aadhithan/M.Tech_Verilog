module sequence(input i,clk,rst,output y);
	parameter idle=2'b00,s1=2'b01,s11=2'b10,s110=2'b11;
	reg [1:0] state,next_state;
	
	always@(*)begin
		case(state)
			idle: next_state = i ? s1   : idle;
			s1  : next_state = i ? s11  : idle;
			s11 : next_state = i ? s11  : s110;
			s110: next_state = i ? s1   : idle;
			default: next_state = idle;
		endcase
	end
	
	always@(posedge clk)begin
		if(rst) state <= idle;
		else state <= next_state;
	end
	
	assign y = (state==s110)&&i;
	
endmodule 