; File "0:/gcodes/SpeedTestStructure_PLA_18m17s.gcode" resume print after print paused at 2023-08-11 17:35
G21
M140 P0 S55.0
G29 S1
G92 X200.908 Y150.393 Z9.518
G60 S1
G10 P0 S215 R220
T0 P0
M98 P"resurrect-prologue.g"
M116
M290 X0.000 Y0.000 Z0.000 R0
T-1 P0
T0 P6
; Workplace coordinates
G10 L2 P1 X0.00 Y0.00 Z0.00
G10 L2 P2 X0.00 Y0.00 Z0.00
G10 L2 P3 X0.00 Y0.00 Z0.00
G10 L2 P4 X0.00 Y0.00 Z0.00
G10 L2 P5 X0.00 Y0.00 Z0.00
G10 L2 P6 X0.00 Y0.00 Z0.00
G10 L2 P7 X0.00 Y0.00 Z0.00
G10 L2 P8 X0.00 Y0.00 Z0.00
G10 L2 P9 X1.00 Y1.00 Z0.00
G54
M106 S1.00
M106 P1 S1.00
M116
G92 E0.00000
M83
M486 S0 A"SpeedTestStructure.step id:0 copy 0"
M486 S0
G17
M23 "0:/gcodes/SpeedTestStructure_PLA_18m17s.gcode"
M26 S370332
G0 F6000 Z11.518
G0 F6000 X200.908 Y150.393
G0 F6000 Z9.518
G1 F5100.0 P1
G21
M24
