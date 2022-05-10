module FA(input a,b,c, output s,cy);
    assign s = a^b^c, cy = a&&b||a&&c||b&&c;
endmodule 

module mux(input a,b,s, output x);
    assign x = s ? b:a;
endmodule 

module adder(input [15:0] a,b, input cin, output cout,output [15:0] sum);
    wire [16:0] car_zero,car_one;
    wire [15:0] sum_zero,sum_one;
    genvar i;
    assign car_zero[0] = 1'b0, car_one[0] = 1'b1;
    generate for(i=0;i<16;i=i+1)begin:adder_circ
        FA zero(a[i],b[i],car_zero[i],sum_zero[i],car_zero[i+1]);
        FA one(a[i],b[i],car_one[i],sum_one[i],car_one[i+1]);
        mux opt(sum_zero[i],sum_one[i],cin,sum[i]);
    end endgenerate 
    mux (car_zero[16],car_one[16],cin,cout);
endmodule 

module tb;

    reg [15:0] a,b;
    reg cin;
    wire cout;
    wire [15:0] sum;
    integer fx,fy1,A;

    adder uut (a,b,cin,cout,sum);

    initial begin
        fx = $fopen("C:\\Users\\User\\Documents\\Code-sync\\M.Tech_Verilog\\Labs\\Read_Write\\test_values.txt", "r");
        fy1= $fopen("C:\\Users\\User\\Documents\\Code-sync\\M.Tech_Verilog\\Labs\\Read_Write\\output_values.txt", "w");
        
        while (! $feof(fx)) begin 
         $fscanf(fx,"%d\n",A);
            a = A;
            $fscanf(fx,"%d\n",A);
            b = A;
            $fscanf(fx,"%d\n",A);
            cin = A;
            #1;
            #1;
            if ({cout,sum} == a+b+cin)begin
                $display("success");
                $fdisplay(fy1,"%d",{cout,sum});
            end
            else $display("failure %d, %d",{cout,sum} ,a+b+cin);
            
        end
        $fclose(fx);
        $fclose(fy1);
    end 
      
endmodule
