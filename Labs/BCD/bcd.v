module bcd(input [3:0]i, output [3:0]y);

/* Behavioural 
	always@(i)begin
	y<=i+3;
	end
	*/
	
//Dataflow
assign y(0)=~i(0);
assign y(1)=~(i(0)^i(1));
assign y(2)=((~i(2))&&(i(0)||i(1)))||(i(2)&&(~i(1))&&(~(i(0))));
assign y(3)=((~i(3))&&i(2)&&(i(1)||i(0)))||((i(3)&&(~i(2))||(~(i(1)))&&(~(i(0))));
endmodule	