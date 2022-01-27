module fa(input a,b,c, output s,cy);
	assign s = a^b^c;
	assign cy = a&b | b&c | a&c;
endmodule

module tb();
	reg a,b,c;
	wire s,cy;
    integer x=0;
	fa dut(a,b,c,s,cy);
	
	initial begin
		repeat(100) begin
			{a,b,c} = $random;
			#1;
			if ({cy,s} != a+b+c) x = x+1;
		end
      if(!x) $display("SUCCESS");
		else $display("FAILURE");
	end
endmodule 