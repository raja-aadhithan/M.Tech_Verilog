module tb;
  reg [3:0] i;
  wire [6:0] y;
  reg x;
  
  hamming dut(i,y);
  
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    repeat(10) begin
      i = $random;
      #1;
      x = (y[0]^y[2]^y[4]^y[6])||(y[1]^y[2]^y[5]^y[6])||(y[3]^y[4]^y[5]^y[6]);
    end
    $display(x);
  end
endmodule