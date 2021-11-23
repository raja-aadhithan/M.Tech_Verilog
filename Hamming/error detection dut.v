module error_detection(input [7:1] ip, output reg [7:1] op,output err,output [2:0]posi);
  reg x;
  reg [2:0] pos;
  
  always@(ip) begin
  	pos[0] = (ip[1]^ip[3]^ip[5]^ip[7]);
  	pos[1] = (ip[2]^ip[3]^ip[6]^ip[7]);
  	pos[2] = (ip[4]^ip[5]^ip[6]^ip[7]);
   	x = |pos;
    op = ip;
  	if (x==1) op[pos] <= !op[pos];
  end
  
  assign err = x;
  assign posi = pos;
  
endmodule