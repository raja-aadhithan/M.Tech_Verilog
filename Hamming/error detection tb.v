module tb();
  reg [7:1] ip;
  wire [7:1] op;
  wire err;
  wire [2:0] posi;
  reg x;
  
  error_detection dut(ip,op,err,posi);
  
  initial begin
    $monitor("%h,%h,%b,%b,%b",ip,op,err,posi,x);
    //repeat(10) begin
	  ip = 7'h4d;
      #1;
      x = (op[1]^op[3]^op[5]^op[7])||(op[2]^op[3]^op[6]^op[7])||(op[4]^op[5]^op[6]^op[7]);
      #1;
    //end
    $finish;
  end
endmodule