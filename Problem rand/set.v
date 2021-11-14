case ({s2,s1,s0}) begin
    3'd0 : A<= A, B<= B; // A and b are unchanged
    3'd1 : A<= A, B<= A + B; // B gets updated to A + B;
    3'd2 : A<= A, B<= B>>1; // B is right shifted one bit
    3'd3 : A<= A, B<= A - Data; // B is loaded differance of A from data
    3'd4 : A<= B, B<= B; // value of B is loaded to A
    3'd5 : A<= A + B, B<= B; // A gets updated to A + B;
    3'd6 : A<= B>>1, B<= B; //A is updated to right shifted B 
    3'd7 : A<= A - Data, B<= B; //A is loaded differance of A from data
end
endcase

Y = A'B'C'D' + A'BCD' + AB'C'D' + ABCD' 
Y = A'D'(B'C'+BC) + AD'(B'C'+BC)
Y = D'(B'C' + BC)
Y = D'(B^C)'

W0 = W & (S1 + S0')
W1 = W & (S1 + S0)

case ({s2,s1,s0}) begin
    3'd0 : A<= A, B<= A; // Both A and B gets value  A
    3'd1 : A<= A, B<= Data; // B is updated to A 
    3'd2 : A<= A, B<= B; // no change
    3'd3 : A<= A, B<= Data; // B is updated to Data 
    3'd4 : A<= A, B<= B; // no change
    3'd5 : A<= Data, B<= B; // A is updated to Data 
    3'd6 : A<= B, B<= B; // Both A and B gets value  B
    3'd7 : A<= Data, B<= A; // A is updated to Data 
end
endcase
