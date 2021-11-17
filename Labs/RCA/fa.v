module fa(input a,b,cin, output s,cout);
	assign s = a^b^cin;
	assign cout = a&&b || b&&cin || a&&cin;
endmodule 