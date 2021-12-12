module FA(input[3:0] a,b,c,output[3:0] sum);
	assign sum = a^b^c;
endmodule

module cla(input [3:0] a,b, output [4:1] c);
	wire [3:0] p,g;
	
	assign p = a^b,
			 g = a&b;
	
	assign c[1] = g[0],
			 c[2] = g[1] | p[1]&g[0],
			 c[3] = g[2] | p[2]&g[1] | p[2]&p[1]&g[0],
			 c[4] = g[3] | p[3]&g[2] | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0];
endmodule

module cla_adv(input [3:0] a,b,input cin, output [4:1] c);
	wire [3:0] p,g;
	
	assign p = a^b,
			 g = a&b;
	
	assign c[1] = g[0] | p[0]&cin,
			 c[2] = g[1] | p[1]&g[0] | p[1]&p[0]&cin,
			 c[3] = g[2] | p[2]&g[1] | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&cin,
			 c[4] = g[3] | p[3]&g[2] | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0] | p[3]&p[2]&p[1]&p[0]&cin;
endmodule

module ETA2_p(input [31:0] A,B, output [31:0] sum);
	wire [32:0] carry;
	genvar i;
	
	assign carry[0] = 1'b0;
	
	generate for(i = 0; i < 20; i=i+4)begin:adder
		cla car_n(A[i+3:i],B[i+3:i],carry[i+4:i+1]);
		FA add_n(A[i+3:i],B[i+3:i],carry[i+3:i],sum[i+3:i]);
	end endgenerate
	generate for(i = 20; i < 32; i=i+4)begin:adv_adder
		cla_adv car_an(A[i+3:i],B[i+3:i],carry[i],carry[i+4:i+1]);
		FA add_an(A[i+3:i],B[i+3:i],carry[i+3:i],sum[i+3:i]);
	end
	endgenerate
endmodule 

module ETA2_n(input [31:0] A,Bb, output [31:0] sum);
	wire [32:0] carry;
	wire [31:0] B;
	genvar i;
	
	assign carry[0] = 1'b1;
	assign B = ~Bb;
	
	generate for(i = 0; i < 20; i=i+4)begin:adder
		cla car_n(A[i+3:i],B[i+3:i],carry[i+4:i+1]);
		FA add_n(A[i+3:i],B[i+3:i],carry[i+3:i],sum[i+3:i]);
	end endgenerate
	cla_adv car_an(A[23:20],B[23:20],1'b1,carry[24:21]);
	FA add_an(A[23:20],B[23:20],{carry[23:21],1'b1},sum[23:20]);
	generate for(i = 24; i < 32; i=i+4)begin:adv_adder
		cla_adv car_an(A[i+3:i],B[i+3:i],carry[i],carry[i+4:i+1]);
		FA add_an(A[i+3:i],B[i+3:i],carry[i+3:i],sum[i+3:i]);
	end
	endgenerate 
endmodule 

module fir(input [31:0]x, output reg [31:0]y, input clk);
	wire [31:0] s1,s2,s3,s4,s5,s6,a1,a2,a3,a4,a5;
	reg [31:0] d[9:0];
	wire [31:0] sum[8:0];
	
        ETA2_n n1(x<<7,x,s1);
        ETA2_n n2(s1,x<<5,s2);
        ETA2_n n3(x<<1,s2,s3);
        ETA2_n n4(s2,x<<4,s4);
        ETA2_n n5(s4,x,s5);
        ETA2_n n6(a1,x,s6);

        ETA2_p p1(s4,x<<1,a1);
        ETA2_p p2(s6,x<<9,a2);
        ETA2_p p3(x<<7,x,a3);
        ETA2_p p4(a2,a3,a4);
        ETA2_p p5(s3,s5,a5);
		
		  ETA2_p p21(d[0],s2,sum[0]);
		  ETA2_p p22(d[1],s3,sum[1]);
		  ETA2_p p23(d[2],a5,sum[2]);
		  ETA2_p p24(d[3],s5,sum[3]);
		  ETA2_p p25(d[4],a1,sum[4]);
		  ETA2_p p26(d[5],s6,sum[5]);
		  ETA2_p p27(d[6],a2,sum[6]);
		  ETA2_p p28(d[7],a4,sum[7]); 
		  ETA2_p p29(d[8],a3,sum[8]);

		
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
		y <= sum[8];
	end
endmodule