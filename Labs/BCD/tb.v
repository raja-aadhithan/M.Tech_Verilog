module tb();
reg [3:0]i;
wire [3:0]y;
integer x;

bcd dut(i,y);
initial begin
	$monitor("@time %3d : when input is %b output is %b",$time,i,y);
	for (x=0; x <16; x=x+1) begin
	i=x;
	#5;
	end
	$finish;
	end
	endmodule
	