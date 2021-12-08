module fir_tb;
	reg [31:0] x;   // 32 bit input to FIR
	reg clk = 0;    // Clock Signal
	wire [31:0] y;  // 32 bit output fron FIR 

	fir ut(x,y,clk); // Istantiating the DUT

	initial forever #5 clk = !clk; // setting clock period as 10ns
		
	initial begin
		x = 1; #100; // x[n-9] to x[9] will have the same input 1
        $display("for x = %0d y is %0d",x,y); 

		x = 2; #100; // x[n-9] to x[9] will have the same input 2
		$display("for x = %0d y is %0d",x,y); 
		
        x = 3; #50; // x[n-9] to x[n-5] will have the input 2, x[n-4] to x[n] will have input 3
		$display("for x = %0d y is %0d",x,y);
		
        x = 4; #50; // x[n-9] to x[n-5] will have the input 3, x[n-4] to x[n] will have input 4
		$display("for x = %0d y is %0d",x,y);
		
		x = 124; #50; // for 1st 5 cycles 
		x = 1116988; #50; // for 2nd 5 cycles
		$display("for x = %0d y is %0d",x,y);
		
		x = 42; #20; // for 2 cycles
		x = 124; #30; // for 3 cycles
		x = 34; #20; // for 2 cycles
		x = 67; #20; // for 2 cycles
		x = 1116988; #10; // for 1 cycle
		$display("for x = %0d y is %0d",x,y);
	end
endmodule