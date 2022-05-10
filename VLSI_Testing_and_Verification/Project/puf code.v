//DUT

module core(input dinit, din, sel, output dout); // dinit is the challenge provided
	assign dout = sel ? dinit : !din; // Core is a multiplexer with 2 inputs
endmodule

module exxor(input a,b, output y); // exor is implemented as module for 
	assign y = a^b;                // code compactability 
endmodule 

module puf1(input [6:0] dinit, input select,clk, output [7:0] dout);
	 
	reg [7:0] dtransfer; // sequential output from flipflops
	wire [7:0] dinput;   // Combinational outputs from cores
	wire [2:0] eor;
	
	exxor e1(dtransfer[1],dtransfer[7],eor[2]);
	exxor e2(dtransfer[2],dtransfer[7],eor[1]);
	exxor e3(dtransfer[3],dtransfer[7],eor[0]);
	
	core core_1(dinit[0],dtransfer[7],select,dinput[0]); 
	core core_2(dinit[1],dtransfer[0],select,dinput[1]);
	core core_3(dinit[2],eor[2],select,dinput[2]);
	core core_4(dinit[3],eor[1],select,dinput[3]);
	core core_5(dinit[4],eor[0],select,dinput[4]);
	core core_6(dinit[5],dtransfer[4],select,dinput[5]);
	core core_7(dinit[6],dtransfer[5],select,dinput[6]);
	core core_8(dinit[6],dtransfer[6],select,dinput[7]);
	
	always@(posedge clk) dtransfer <= dinput;
	assign dout = dinput; // Dout is seen as the puf output
endmodule 


//TB

module tb;
	reg [6:0] dinit;// Inputs
	reg sel;
	reg clk = 0;
	wire [7:0] dout;// Outputs

	puf1 uut (dinit,sel,clk,dout);// Instantiate the Unit Under Test (UUT)
	
	initial forever #5 clk = !clk;
	initial begin
		$monitor("value of dout at time %0d is %d = %b",$time,dout,dout);
		repeat(13)begin // test is repeated for 13 times
			dinit = $random;
			$display("Value of dinit is %d",dinit);
			sel = 0;// Initialize Inputs
			@(negedge clk); // lets the lfsr produce the output
			sel = 1; // loads the challenge
			@(negedge clk); // This makes dout constant as dinit
			@(negedge clk); // .. for 2 cycles, just for clear visibility from waveform
		end
		$finish;
	end 
endmodule

// Simulation output in waveform

ISim P.20131013 (signature 0x7708f090)
This is a Full version of ISim.
Time resolution is 1 ps
Simulator is doing circuit initialization process.
Value of dinit is  36
Finished circuit initialization process.
value of dout at time 0 is   x = xxxxxxxx
value of dout at time 10 is  36 = 00100100
Value of dinit is   1
value of dout at time 30 is 183 = 10110111
value of dout at time 35 is 140 = 10001100
value of dout at time 40 is   1 = 00000001
Value of dinit is   9
value of dout at time 60 is 253 = 11111101
value of dout at time 65 is  24 = 00011000
value of dout at time 70 is   9 = 00001001
Value of dinit is  99
value of dout at time 90 is 237 = 11101101
value of dout at time 95 is  56 = 00111000
value of dout at time 100 is 227 = 11100011
Value of dinit is  13
value of dout at time 120 is  36 = 00100100
value of dout at time 125 is 183 = 10110111
value of dout at time 130 is  13 = 00001101
Value of dinit is  13
value of dout at time 150 is 229 = 11100101
value of dout at time 155 is  40 = 00101000
value of dout at time 160 is  13 = 00001101
Value of dinit is 101
value of dout at time 180 is 229 = 11100101
value of dout at time 185 is  40 = 00101000
value of dout at time 190 is 229 = 11100101
Value of dinit is  18
value of dout at time 210 is  40 = 00101000
value of dout at time 215 is 175 = 10101111
value of dout at time 220 is  18 = 00010010
Value of dinit is   1
value of dout at time 240 is 219 = 11011011
value of dout at time 245 is  84 = 01010100
value of dout at time 250 is   1 = 00000001
Value of dinit is  13
value of dout at time 270 is 253 = 11111101
value of dout at time 275 is  24 = 00011000
value of dout at time 280 is  13 = 00001101
Value of dinit is 118
value of dout at time 300 is 229 = 11100101
value of dout at time 305 is  40 = 00101000
value of dout at time 310 is 246 = 11110110
Value of dinit is  61
value of dout at time 330 is  14 = 00001110
value of dout at time 335 is 227 = 11100011
value of dout at time 340 is  61 = 00111101
Value of dinit is 109
value of dout at time 360 is 133 = 10000101
value of dout at time 365 is 232 = 11101000
value of dout at time 370 is 237 = 11101101


=========================================================================
HDL Synthesis Report

Macro Statistics
# Registers                                            : 1
 8-bit register                                        : 1
# Multiplexers                                         : 8
 1-bit 2-to-1 multiplexer                              : 8
# Xors                                                 : 3
 1-bit xor2                                            : 3

=========================================================================

=========================================================================
*                       Advanced HDL Synthesis                          *
=========================================================================


=========================================================================
Advanced HDL Synthesis Report

Macro Statistics
# Registers                                            : 8
 Flip-Flops                                            : 8
# Xors                                                 : 3
 1-bit xor2                                            : 3

 =========================================================================
*                            Design Summary                             *
=========================================================================

Top Level Output File Name         : puf1.ngc

Primitive and Black Box Usage:
------------------------------
# BELS                             : 8
#      LUT3                        : 5
#      LUT4                        : 3
# FlipFlops/Latches                : 8
#      FD                          : 8
# Clock Buffers                    : 1
#      BUFGP                       : 1
# IO Buffers                       : 16
#      IBUF                        : 8
#      OBUF                        : 8

Device utilization summary:
---------------------------

Selected Device : 6slx45csg324-3 


Slice Logic Utilization: 
 Number of Slice Registers:               8  out of  54576     0%  
 Number of Slice LUTs:                    8  out of  27288     0%  
    Number used as Logic:                 8  out of  27288     0%  

Slice Logic Distribution: 
 Number of LUT Flip Flop pairs used:     16
   Number with an unused Flip Flop:       8  out of     16    50%  
   Number with an unused LUT:             8  out of     16    50%  
   Number of fully used LUT-FF pairs:     0  out of     16     0%  
   Number of unique control sets:         1

IO Utilization: 
 Number of IOs:                          17
 Number of bonded IOBs:                  17  out of    218     7%  

Specific Feature Utilization:
 Number of BUFG/BUFGCTRLs:                1  out of     16     6%  

Timing Report

NOTE: THESE TIMING NUMBERS ARE ONLY A SYNTHESIS ESTIMATE.
      FOR ACCURATE TIMING INFORMATION PLEASE REFER TO THE TRACE REPORT
      GENERATED AFTER PLACE-and-ROUTE.

Clock Information:
------------------
-----------------------------------+------------------------+-------+
Clock Signal                       | Clock buffer(FF name)  | Load  |
-----------------------------------+------------------------+-------+
clk                                | BUFGP                  | 8     |
-----------------------------------+------------------------+-------+

Asynchronous Control Signals Information:
----------------------------------------
No asynchronous control signals found in this design

Timing Summary:
---------------
Speed Grade: -3

   Minimum period: 1.438ns (Maximum Frequency: 695.628MHz)
   Minimum input arrival time before clock: 2.560ns
   Maximum output required time after clock: 4.523ns
   Maximum combinational path delay: 5.645ns

Timing Details:
---------------
All values displayed in nanoseconds (ns)

=========================================================================
Timing constraint: Default period analysis for Clock 'clk'
  Clock period: 1.438ns (frequency: 695.628MHz)
  Total number of paths / destination ports: 11 / 8
-------------------------------------------------------------------------
Delay:               1.438ns (Levels of Logic = 1)
  Source:            dtransfer_7 (FF)
  Destination:       dtransfer_0 (FF)
  Source Clock:      clk rising
  Destination Clock: clk rising

  Data Path: dtransfer_7 to dtransfer_0
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FD:C->Q               4   0.447   0.684  dtransfer_7 (dtransfer_7)
     LUT3:I2->O            2   0.205   0.000  core_1/Mmux_dout11 (dout_0_OBUF)
     FD:D                      0.102          dtransfer_0
    ----------------------------------------
    Total                      1.438ns (0.754ns logic, 0.684ns route)
                                       (52.5% logic, 47.5% route)

=========================================================================
Timing constraint: Default OFFSET IN BEFORE for Clock 'clk'
  Total number of paths / destination ports: 16 / 8
-------------------------------------------------------------------------
Offset:              2.560ns (Levels of Logic = 2)
  Source:            select (PAD)
  Destination:       dtransfer_2 (FF)
  Destination Clock: clk rising

  Data Path: select to dtransfer_2
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     IBUF:I->O             8   1.222   1.031  select_IBUF (select_IBUF)
     LUT4:I1->O            2   0.205   0.000  core_5/Mmux_dout11 (dout_4_OBUF)
     FD:D                      0.102          dtransfer_4
    ----------------------------------------
    Total                      2.560ns (1.529ns logic, 1.031ns route)
                                       (59.7% logic, 40.3% route)

=========================================================================
Timing constraint: Default OFFSET OUT AFTER for Clock 'clk'
  Total number of paths / destination ports: 11 / 8
-------------------------------------------------------------------------
Offset:              4.523ns (Levels of Logic = 2)
  Source:            dtransfer_7 (FF)
  Destination:       dout<4> (PAD)
  Source Clock:      clk rising

  Data Path: dtransfer_7 to dout<4>
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     FD:C->Q               4   0.447   0.684  dtransfer_7 (dtransfer_7)
     LUT3:I2->O            2   0.205   0.616  core_1/Mmux_dout11 (dout_0_OBUF)
     OBUF:I->O                 2.571          dout_0_OBUF (dout<0>)
    ----------------------------------------
    Total                      4.523ns (3.223ns logic, 1.300ns route)
                                       (71.3% logic, 28.7% route)

=========================================================================
Timing constraint: Default path analysis
  Total number of paths / destination ports: 16 / 8
-------------------------------------------------------------------------
Delay:               5.645ns (Levels of Logic = 3)
  Source:            select (PAD)
  Destination:       dout<4> (PAD)

  Data Path: select to dout<4>
                                Gate     Net
    Cell:in->out      fanout   Delay   Delay  Logical Name (Net Name)
    ----------------------------------------  ------------
     IBUF:I->O             8   1.222   1.031  select_IBUF (select_IBUF)
     LUT4:I1->O            2   0.205   0.616  core_5/Mmux_dout11 (dout_4_OBUF)
     OBUF:I->O                 2.571          dout_4_OBUF (dout<4>)
    ----------------------------------------
    Total                      5.645ns (3.998ns logic, 1.647ns route)
                                       (70.8% logic, 29.2% route)

=========================================================================

Cross Clock Domains Report:
--------------------------

Clock to Setup on destination clock clk
---------------+---------+---------+---------+---------+
               | Src:Rise| Src:Fall| Src:Rise| Src:Fall|
Source Clock   |Dest:Rise|Dest:Rise|Dest:Fall|Dest:Fall|
---------------+---------+---------+---------+---------+
clk            |    1.438|         |         |         |
---------------+---------+---------+---------+---------+

=========================================================================


Total REAL time to Xst completion: 9.00 secs
Total CPU time to Xst completion: 8.68 secs
 
--> 

Total memory usage is 4493940 kilobytes

Number of errors   :    0 (   0 filtered)
Number of warnings :    0 (   0 filtered)
Number of infos    :    0 (   0 filtered)