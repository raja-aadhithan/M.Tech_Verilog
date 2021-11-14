Design Code:

module debam(input [7:0] a,b, output reg [15:0] q);
reg [7:0]temp[4:0];
reg [15:0] add[4:0];

	always@(*) begin
	 temp[0] <= a[1] ? (a[0] ? ((b << 1'b1)|b) : (b << 1'b1)) : (a[0] ? b : 8'd0);
	 temp[1] <= a[3] ? (a[2] ? ((b << 1'b1)|b) : (b << 1'b1)) : (a[2] ? b : 8'd0);
	 temp[2] <= a[5] ? (a[4] ? ((b << 1'b1)|b) : (b << 1'b1)) : (a[4] ? b : 8'd0);
	 temp[3] <= a[6] ? b : 0;
	 temp[4] <= a[7] ? b : 0;
	 
	 add[0] <= temp[0];
	 add[1] <= {temp[1],2'd0};
	 add[2] <= {temp[2],4'd0};
	 add[3] <= {temp[3],6'd0};
	 add[4] <= {temp[4],7'd0};
	 
	 q <= add[0] + add[1] + add[2] + add[3] + add[4];
	end
endmodule





