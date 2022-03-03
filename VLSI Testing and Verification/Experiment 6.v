module dff(input d,clk,set,output q);
	reg t;
	always@(posedge clk) begin
		if(set)	t<=1'b1;
		else t <= d;
	end	
	assign q = t;
endmodule 	

module lfsr(input clk,set,output [3:0]op);
	wire di;
	wire [3:0]q;
	assign di = q[3]^q[2];
	dff f1(di,clk,set,q[0]);
	dff f2(q[0],clk,set,q[1]);
	dff f3(q[1],clk,set,q[2]);
	dff f4(q[2],clk,set,q[3]);
	assign op = q;
endmodule

module tb;
	reg clk=0;
	reg set;
	reg [3:0]exp;
	wire [3:0]op;
	lfsr uut (clk,set,op);

	initial forever #5 clk = !clk;
	
	initial begin
		set = 1;
		#20 set = 0;
		repeat(30)begin
			@(negedge clk);
			if(uut.q == exp) $display("success");
			else $display("failure");
			exp = uut.q;
			exp = {exp[2:0],exp[3]^exp[2]};
		end
	end
endmodule 