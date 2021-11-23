module hamming(input [3:0] i, output [6:0] y);
  assign y[0] = i[0]^i[1]^i[3];
  assign y[1] = i[0]^i[2]^i[3];
  assign y[2] = i[0];
  assign y[3] = i[1]^i[2]^i[3];
  assign y[4] = i[1];
  assign y[5] = i[2];
  assign y[6] = i[3];
endmodule