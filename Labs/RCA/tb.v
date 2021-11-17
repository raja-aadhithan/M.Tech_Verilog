module tb;
	reg [7:0] a, b;
	reg cin;
	wire cy;
	wire [7:0] s;
	integer i;
	integer x;
	
	rca uut (a,b,cin,cy,s);
	
	initial begin
		repeat(10) begin
			x =0;
			a = $random;
			b = $random;
			cin = $random;
			i = a+b+cin;
			#1;
			if ({cy,s}!=i) x = x+1;
			else $display("input is %d,%d,%d , output is %d",a,b,cin,{cy,s});
			#10;
		end
	end
      
endmodule

