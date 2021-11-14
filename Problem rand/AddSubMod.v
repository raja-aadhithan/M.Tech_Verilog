
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

