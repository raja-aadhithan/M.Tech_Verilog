HDL Synthesis Report

Macro Statistics
# Registers                                            : 1
 8-bit register                                        : 1
# Multiplexers                                         : 8
 1-bit 2-to-1 multiplexer                              : 8
# Xors                                                 : 3
 1-bit xor2                                            : 3

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

Timing Summary:
---------------
Speed Grade: -3

   Minimum period: 1.438ns (Maximum Frequency: 695.628MHz)
   Minimum input arrival time before clock: 2.560ns
   Maximum output required time after clock: 4.523ns
   Maximum combinational path delay: 5.645ns
   Timing constraint: Default period analysis for Clock 'clk'
  Clock period: 1.438ns (frequency: 695.628MHz)
  Total number of paths / destination ports: 11 / 8

  Total REAL time to Xst completion: 9.00 secs
Total CPU time to Xst completion: 8.68 secs
 
--> 

Total memory usage is 4493940 kilobytes

Number of errors   :    0 (   0 filtered)
Number of warnings :    0 (   0 filtered)
Number of infos    :    0 (   0 filtered)