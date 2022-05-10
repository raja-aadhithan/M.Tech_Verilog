module mux(input [3:0]i, [1:0]s, output y);
	assign y = s[1]?(s[0]?i[3]:i[2]):(s[0]?i[1]:i[0]);
endmodule 

module tb;
	reg [3:0] i;// Inputs
	reg [1:0] s;
	wire y;
	integer A,C,fx ;
	reg [3:0] vector;
	
	mux uut (i, s, y); // Instantiate the Unit Under Test (UUT)

	initial begin
	vector = 3;
		fx = $fopen("C:\\Users\\User\\Documents\\input_test.txt","r");
      while (! $feof(fx)) begin 
         $fscanf(fx,"%b\t",A);
            i = A;
				$fscanf(fx,"%b\t",A);
            s = A;
				$fscanf(fx,"%b\t",A);
            C = A;
            #2;
            if (C == y)begin
                $display("success");
					 $display("value of i = %b, value of s = %b, output is %b",i,s,y);
             end 
        end
        $fclose(fx);
        
    end 
      

endmodule 

