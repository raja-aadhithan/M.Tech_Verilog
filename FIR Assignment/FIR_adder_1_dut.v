module xor_logic(input a,b,c,output s);
	assign s = c||(a^b); 
endmodule 

module csgc1(input a,b,ctl,output ctlo);
	assign ctlo = ctl || (a&&b);
endmodule 

module csgc2(input a,b,ctl,ctlp,output ctlo);
	assign ctlo = ctl || ctlp || (a&&b);
endmodule 

module fa(input a,b,c,output s,cy);
	assign s = a^b^c;
	assign cy = (a&&b)||(b&&c)||(a&&c);
endmodule

module top_p(input [31:0] a,b, output [31:0] sum);
	genvar i,x,f;
	wire [32:0] ctl;
	
	generate for(i = 0; i < 20; i = i + 1) begin
		if(i == 3 || i == 7 || i == 11 || i == 15) csgc2 log_p(a[i],b[i],ctl[i+1],ctl[i+4],ctl[i]);
		else if(i == 19) csgc1 log_p(a[i],b[i],1'b0,ctl[i]);
		else csgc1 log_p(a[i],b[i],ctl[i+1],ctl[i]);
	end 
	endgenerate
	
	generate for(x = 0; x < 20; x = x + 1) begin
		xor_logic gate_p(a[x],b[x],ctl[x],sum[x]); 
	end 
	endgenerate
	
	assign ctl[20] = 1'b0;
	generate for(f = 20; f < 32; f = f + 1)begin
		if(f == 20) fa adder_p(a[f],b[f],ctl[f],sum[f],ctl[f+1]);
		else fa adder_p(a[f],b[f],ctl[f],sum[f],ctl[f+1]);
	end
	endgenerate 
	
endmodule 

module top_n(input [31:0] a,bb, output [31:0] sum);
	genvar i,x,f;
	wire [32:0] ctl;
	wire [31:0] b;
	
   assign b = ~bb;

	generate for(i = 0; i < 20; i = i + 1) begin
		if(i == 3 || i == 7 || i == 11 || i == 15) csgc2 log_n(a[i],b[i],ctl[i+1],ctl[i+4],ctl[i]);
		else if(i == 19) csgc1 log_n(a[i],b[i],1'b0,ctl[i]);
		else csgc1 log_n(a[i],b[i],ctl[i+1],ctl[i]);
	end 
	endgenerate
	
	generate for(x = 0; x < 20; x = x + 1) begin
		xor_logic gate_n(a[x],b[x],ctl[x],sum[x]); 
	end 
	endgenerate
	
	assign ctl[20] = 1'b1;
	generate for(f = 20; f < 32; f = f + 1)begin
		if(f == 20) fa adder_n(a[f],b[f],ctl[f],sum[f],ctl[f+1]);
		else fa adder_n(a[f],b[f],ctl[f],sum[f],ctl[f+1]);
	end
	endgenerate 
	
endmodule 

module fir(input [31:0]x, output reg [31:0]y, input clk);
	wire [31:0] s1,s2,s3,s4,s5,s6,a1,a2,a3,a4,a5;
	reg [31:0] d[9:0];
	wire [31:0] sum[8:0];
	
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
		
		  top_p p21(d[0],s2,sum[0]);
		  top_p p22(d[1],s3,sum[1]);
		  top_p p23(d[2],a5,sum[2]);
		  top_p p24(d[3],s5,sum[3]);
		  top_p p25(d[4],a1,sum[4]);
		  top_p p26(d[5],s6,sum[5]);
		  top_p p27(d[6],a2,sum[6]);
		  top_p p28(d[7],a4,sum[7]); 
		  top_p p29(d[8],a3,sum[8]);

		
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