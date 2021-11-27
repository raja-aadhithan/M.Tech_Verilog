module tb();
	reg i,clk,rst;
	wire y;
	
	sequence dut(i,clk,rst,y);
	
	initial begin
		clk = 1'b0;
		forever #5 clk = !clk;
	end
	
	initial begin
		$monitor("the state is %d input is %b next state is %d and the output is %b",dut.state,i,dut.next_state,y);
		rst = 1'b1;
		#5;	
		rst = 1'b0;
		@(negedge clk); i = 0;
		@(negedge clk); i = 1;
		@(negedge clk); i = 1;
		@(negedge clk); i = 0;
		@(negedge clk); i = 1;
		@(negedge clk); i = 1;
		@(negedge clk); i = 0;
		@(negedge clk); i = 0;
		@(negedge clk); i = 1;
		$finish;
	end
endmodule 