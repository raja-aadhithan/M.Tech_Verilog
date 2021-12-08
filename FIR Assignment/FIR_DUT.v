module fir(input [31:0]x, output [31:0]y, input clk); // 32 bit input,output
	reg [31:0] s1,s2,s3,s4,s5,s6,a1,a2,a3,a4,a5; // for inter connect transfers
	reg [31:0] d[9:0]; //used for delay [1/z]
	reg [31:0] sum[8:0]; // add previous time slot output to current slot
	
    // combinational logics: happens at x(n)
	always@(*)begin 
		s1 = (x << 7) - x;  //subracting x from x^128
		s2 = s1 - (x << 5); //subtracting x^32 from s1
		s3 = (x << 1) - s2; //subtracting s2 from x^2
		s4 = s2 - (x << 4); //subtracting x^16 from s2
		s5 = s4 - x;        //subtracting x from s4
		a1 = s4 + (x << 1); //adding x^128 and x
		s6 = a1 - x;        //subtracting x from a1
		a2 = s6 + (x << 9); //adding x^512 and s6
		a3 = (x << 7) + x;  //adding x^128 and x
		a4 = a2 + a3;       //adding a2 and a3
		a5 = s3 + s5;       //adding s3 and s5
	end
	
    // adds x(n-1) output to x(n)
	always@(*)begin
		sum[0] = d[0] + s2;
		sum[1] = d[1] + s3;
		sum[2] = d[2] + a5;
		sum[3] = d[3] + s5;
		sum[4] = d[4] + a1;
		sum[5] = d[5] + s6;
		sum[6] = d[6] + a2;
		sum[7] = d[7] + a4;
		sum[8] = d[8] + a3;
	end

    //synchronizes the output with respect to the clock as well as add delay	
	always@(posedge clk)begin
		d[0] <= s1;
		d[1] <= sum[0];
		d[2] <= sum[1];
		d[3] <= sum[2];
		d[4] <= sum[3];
		d[5] <= sum[4];
		d[6] <= sum[5];
		d[7] <= sum[6];
		d[8] <= sum[7];
		d[9] <= sum[8];
	end
	
	assign y = d[9]; // final output is transferred to the block output
	
endmodule