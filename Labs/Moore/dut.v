module moore(input i,clk,rst, output reg y);
	reg [2:0] state,next_state;
	parameter idle=3'b000, s1=3'b001, s10=3'b010, s101=3'b011, s1011=3'b100;
	
	always@(*)begin
		case(state)
			idle	: next_state = i ? s1	: idle;
			s1		: next_state = i ? s1	: s10;
			s10	: next_state = i ? s101	: idle;
			s101	: next_state = i ? s1011: s10;
			s1011	: next_state = i ? s1	: idle;
		endcase
	end		
	
	always@(posedge clk) begin
		if (rst == 1) begin
			state = idle;
			y <= 1'b0;
		end
		else begin
			state = next_state;
			y <= (state==s1011);
		end
	end
endmodule 