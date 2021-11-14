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

//APPROXIMATE ADDER 1

module lut(input a,b, output y);
  
  LUT2 #(.INIT(4'hE)) LUT6_inst (.O(y), .I0(a), .I1(b));
  
endmodule 

module lut_tb();

	reg a,b,z;
	wire y;
	integer i,c,d,err;

	lut dut(a,b,y);

	initial begin
		$monitor("@time %3d : a is %b, b is %b output is %b", $time,a,b,y);
			c =0; d =0; err =0;
			for (i=0; i<4; i=i+1) begin
				{a,b} = i;
				#1;
				z = a^b;
				if(y != z) begin
					$display("the values don't match when a:%b, b:%b : actual output:%b, expected output:%b",a,b,y,z);
					c = c +1;
				end 
				d = d +1;
				#4;
			end
			
			err = ((d-c)*100)/d;
			$display("the values matches for %3d percentage of times",err);
		$finish;
	end
	
endmodule	


//APPROXIMATE ADDER 2

module lut(input a,b,cin, output s,cy);
  
  LUT3 #(.INIT(8'h8E)) LUT6_inst (.O(s), .I0(cin), .I1(b), .I2(a));
  assign cy = a;
  
endmodule 

module lut_tb();

	reg a,b,cin;
	reg [1:0]z;
	wire s,cy;
	integer i,c,d,err;

	lut dut(a,b,cin,s,cy);

	initial begin
		$monitor("@time %3d : a is %b, b is %b, cin is %b output is %b %b", $time,a,b,cin,cy,s);
			c =0; d =0; err =0;
			for (i=0; i<8; i=i+1) begin
				{a,b,cin} = i;
				#1;
				z[0] = a^b^cin;
				z[1] = a&b || b&cin || a&cin;
				if({cy,s} != z) begin
					$display("the values don't match when a:%b, b:%b, cin:%b : actual output:%2b, expected output:%2b",a,b,cin,{cy,s},z);
					c = c +1;
				end 
				d = d +1;
				#4;
			end
			
			err = ((d-c)*100)/d;
			$display("the values matches for %3d percentage of times",err);
		$finish;
	end
	
endmodule	