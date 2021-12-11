module fir_tb;
	reg [31:0] x;
	reg [15:0] add;
	reg clk =0;
	wire [31:0] y;
	integer fx,fy;

	fir ut(x,y,clk);

	initial forever #5 clk = !clk;

	initial begin
		fx = $fopen("C:\\Users\\User\\Documents\\Code-sync\\M.Tech_Verilog\\FIR Assignment\\Data\\xdata.txt", "w");
		fy= $fopen("C:\\Users\\User\\Documents\\Code-sync\\M.Tech_Verilog\\FIR Assignment\\Data\\yorig_data.txt", "w");
		repeat(100)begin
			x = $random%100000;
			add = $random;
			x = x*1000000 + add;
			#1;
			$fdisplay(fx,"%d",x);
			$fdisplay(fy,"%d",y);
			#9;
		end 
		$fclose(fx);
		$fclose(fy);	
		end
endmodule 