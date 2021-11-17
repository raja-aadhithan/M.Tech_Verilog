module rca(input [7:0] a, b, input cin, output cy, output [7:0] s);
wire [6:0] co;
fa f1(a[0],b[0],cin,s[0],co[0]);
fa f2(a[1],b[1],co[0],s[1],co[1]);
fa f3(a[2],b[2],co[1],s[2],co[2]);
fa f4(a[3],b[3],co[2],s[3],co[3]);
fa f5(a[4],b[4],co[3],s[4],co[4]);
fa f6(a[5],b[5],co[4],s[5],co[5]);
fa f7(a[6],b[6],co[5],s[6],co[6]);
fa f8(a[7],b[7],co[6],s[7],cy);
endmodule 