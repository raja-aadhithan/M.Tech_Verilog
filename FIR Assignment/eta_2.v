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

module ETA2_p(input [31:0] A,B, output [31:0] sum,output cy);
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
	assign cy = carry[32];	
endmodule 

module ETA2_n(input [31:0] A,Bb, output [31:0] sum,output cy);
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
	assign cy = 1'b0;
endmodule 