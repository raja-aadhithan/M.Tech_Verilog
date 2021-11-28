module tb();
	reg [7:0] a,b;
	wire [7:0] s;
	wire cy;

	adder dut(a,b,s,cy);
	
	initial begin
		repeat(10) begin
			a = $random;
			b = $random;
			#1;
			if ({cy,s} == a+b) $display("SUCCESS");
			else $display("FAILURE");
		end
	end
endmodule 