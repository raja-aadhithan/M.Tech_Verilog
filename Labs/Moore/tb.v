module tb();
	reg i,clk,rst;
	wire y;
	
	moore dut(i,clk,rst,y);
	
	initial begin
		clk = 1'b1;
		forever #5 clk = !clk;
	end
	
	initial begin
		rst = 1'b1;
		#10;
		@(negedge clk) 
		rst = 1'b0;
		i = 1;
		@(negedge clk) i = 0;
		@(negedge clk) i = 1;
		@(negedge clk) i = 1;
		@(negedge clk) i = 1;
		@(negedge clk) i = 0;
		@(negedge clk) i = 1;
		@(negedge clk) i = 0;
	end
endmodule 