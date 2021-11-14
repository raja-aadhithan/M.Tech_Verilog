RTL Code:

module AddSubMod(C0, X, Y, S, E);
  input C0; // single bit input
  input [4:0] X, Y;// 4-bit input items
  output [4:0] S;
  output E; //(multiple output lines due to size differences)
  wire [4:0] Xa,dd;
  wire [3:0] CY;
  assign dd = C0 ? 5'b00000 : 5'b11111;
  assign Xa = dd^Y;
  FullAdderMod dut1(Xa[0],X[0],C0,S[0],CY[0]);
  FullAdderMod dut2(Xa[1],X[1],CY[0],S[1],CY[1]);
  FullAdderMod dut3(Xa[2],X[2],CY[1],S[2],CY[2]);
  FullAdderMod dut4(Xa[3],X[3],CY[2],S[3],CY[3]);
  FullAdderMod dut5(Xa[4],X[4],CY[3],S[4],E);
endmodule

  
module FullAdderMod(input a,b,c, output s,cy); // single-bit adder 
	assign s = (a^b)^c;
    assign cy = (a&b) | ((a^b)&c);
endmodule


Test bench:

module TestMod;
    parameter PLUS_SIGN = 43;
    parameter MINUS_SIGN = 45;
    parameter STDIN = 32'h8000_0000; // keyboard input channel
    reg [7:0] str [1:3]; // typing in, 3 chars
    reg [4:0] X, Y; // 5-bit X, Y to sum
    reg C0; // set 0/1 to do add/subtract
    wire [4:0] S; // 5-bit Sum to see as result
    wire E; // Error indicator, overflow
integer i,a;
    AddSubMod dut(C0, X, Y, S, E);   
  	initial begin
    $display("Enter X (range 00~15): ");
        str[1] = $fgetc(STDIN);
        str[2] = $fgetc(STDIN);
      	str[1].atoi();
      	i = str[1]-48;
      	a = i*10;
      	str[2].atoi();
      i = str[2]-48;
      	a = a + i;
      	X = a;
        
      $display("Enter Y (range 00~15): ");
        str[1] = $fgetc(STDIN);
        str[2] = $fgetc(STDIN);
      	str[1].atoi();
      i = str[1]-48;
      	a = i*10;
      	str[2].atoi();
      i = str[2]-48;
      	a = a + i;
      	Y = a;
      	
      $display("Enter + or -");
      str[1] = $fgetc(STDIN);
     str[1].atoi();
      i = str[1]-43;
      C0 = i;
      
		 #2; // wait a bit for the add/sub to get done
      $display("X = %b, Y = %b, C0 =%b \n S = %b, E = %b",X,Y,C0,S,E);
end
endmodule