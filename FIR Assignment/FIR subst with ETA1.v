module fir(input [31:0]x, output [31:0]y, input clk);
	reg [31:0] s1,s2,s3,s4,s5,s6,a1,a2,a3,a4,a5;
	reg [31:0] d[9:0];
	reg [31:0] sum[8:0];
	
	always@(*)begin
        top_n n1(x<<7,x,s1);
        top_n n2(s1,x<<5,s2);
        top_n n3(x<<1,s2,s3);
        top_n n4(s2,x<<4,s4);
        top_n n5(s4,x,s5);
        top_n n6(a1,x,s6);

        top_p p1(s4,x<<1,a1);
        top_p p2(s6,x<<9,a2);
        top_p p3(x<<7,x,a3);
        top_p p4(a2,a3,a4);
        top_p p5(s3,s5,a5);
		
	end
	
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
	
	assign y = d[9];
	
endmodule
	