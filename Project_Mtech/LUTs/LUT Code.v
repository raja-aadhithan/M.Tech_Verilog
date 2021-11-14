//LUT OF NAND GATE

module lut(input a,b, output y);
  
    LUT2 #(.INIT(4'h7)) LUT6_inst (.O(y), .I0(a), .I1(b));
  
endmodule 

module lut_tb();

    reg a,b;
    wire y;

    lut dut(a,b,y);

    initial begin
	    $monitor("@time %3d : a is %b, b is %b output is %b", $time,a,b,y);
	        {a,b} = 0; #5;
	        {a,b} = 1; #5;
	        {a,b} = 2; #5;
	        {a,b} = 3; #5;
	    $finish;
	end
	
endmodule	

