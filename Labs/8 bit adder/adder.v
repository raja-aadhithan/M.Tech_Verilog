module fa(input a,b,c, output s,cy);
	assign s = a^b^c;
	assign cy = a&b | b&c | a&c;
endmodule

module adder(input [7:0] a,b, output [7:0] s, output cy);
    wire [8:0] x;
    genvar i;

    assign x[0] = 1'b0;
    generate for(i = 0; i < 8; i = i+1) begin:add
        fa dut(a[i],b[i],x[i],s[i],x[i+1]);
    end
	 endgenerate 
    assign cy = x[8];
endmodule 