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
		if(i == 3 || i == 7 || i == 11 || i == 15) csgc2 log(a[i],b[i],ctl[i+1],ctl[i+4],ctl[i]);
		else if(i == 19) csgc1 log(a[i],b[i],1'b0,ctl[i]);
		else csgc1 log(a[i],b[i],ctl[i+1],ctl[i]);
	end 
	endgenerate
	
	generate for(x = 0; x < 20; x = x + 1) begin
		xor_logic gate(a[x],b[x],ctl[x],sum[x]); 
	end 
	endgenerate
	
	generate for(f = 20; f < 32; f = f + 1)begin
		if(f == 20) fa adder(a[f],b[f],1'b0,sum[f],ctl[f+1]);
		else fa adder(a[f],b[f],ctl[f],sum[f],ctl[f+1]);
	end
	endgenerate 
	
endmodule 

module top_n(input [31:0] a,bb, output [31:0] sum);
	genvar i,x,f;
	wire [32:0] ctl;
	
    assign b = ~bb;

	generate for(i = 0; i < 20; i = i + 1) begin
		if(i == 3 || i == 7 || i == 11 || i == 15) csgc2 log(a[i],b[i],ctl[i+1],ctl[i+4],ctl[i]);
		else if(i == 19) csgc1 log(a[i],b[i],1'b0,ctl[i]);
		else csgc1 log(a[i],b[i],ctl[i+1],ctl[i]);
	end 
	endgenerate
	
	generate for(x = 0; x < 20; x = x + 1) begin
		xor_logic gate(a[x],b[x],ctl[x],sum[x]); 
	end 
	endgenerate
	
	generate for(f = 20; f < 32; f = f + 1)begin
		if(f == 20) fa adder(a[f],b[f],1'b1,sum[f],ctl[f+1]);
		else fa adder(a[f],b[f],ctl[f],sum[f],ctl[f+1]);
	end
	endgenerate 
	
endmodule 