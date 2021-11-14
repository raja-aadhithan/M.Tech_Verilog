Testbench:

module tb();
reg [7:0] a,b; wire [15:0] q;
integer av_per,count,percent,eff;
reg [15:0]s,p;

debam uut(a,b,q);

initial begin
	count = 0; percent = 0; av_per = 0; eff = 0;
	repeat(100) begin
		{a,b} = $random;
		#1;
		s = a*b;
		p = q;
		if(p == s) av_per = 100;
		else if (s == 0) av_per = 0;
		else av_per = p*100/s;
	
		count = count + 1;
		percent = percent + av_per;
		#9;
		
	end
	
	eff = percent/count;
	$display("effective percentage is %d",eff);

end
endmodule 