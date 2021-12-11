module fir_tb;
	reg [31:0] x;
	reg clk = 1'b0;
	wire [31:0] y;
	integer fx,fy1,A;

	fir ut(x,y,clk);

	initial forever #5 clk = !clk;
	
	initial begin	
		fx = $fopen("C:\\Users\\User\\Documents\\Code-sync\\M.Tech_Verilog\\FIR Assignment\\Data\\xdata.txt", "r");
		fy1= $fopen("C:\\Users\\User\\Documents\\Code-sync\\M.Tech_Verilog\\FIR Assignment\\Data\\y1_data.txt", "w");
		
		while (! $feof(fx)) begin 
         $fscanf(fx,"%d\n",A);
			x = A;
			#1;
			$fdisplay(fy1,"%d",y);
			#9;
		end
		$fclose(fx);
		$fclose(fy1);
	end
endmodule 