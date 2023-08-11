; Configuration file for Duet 3 (firmware version 3)
; executed by the firmware on start-up
;
; Global variable to run/not run daemon.g - checked in daemon.g and abort if false
;if !exists(global.RunDaemon)
;	global RunDaemon = true  
;else
;	set global.RunDaemon = true 

; Set global IdleCounter               			            ; counts idle time
if !exists(global.IdleCounter)					 			; to avoid running triggers multile times
	global IdleCounter = 0
	
if !exists(global.ExtruderTempActive_Old)                   ; stores extruder temperature for idle check
	global ExtruderTempActive_Old = 0	
	
if !exists(global.BedTempActive_Old)                        ; stores bed temperature for idle check
	global BedTempActive_Old = 0

if !exists(global.OldStateStatus)		    				; stores the status of the printer, processing = 1
	global OldStateStatus = 0
; Log:
;	Description at the WebUi for Hotend and Bed changeable
;	Serial Com Port activated
;	Fan2 deactivated
;	Tool 0 with Part Cooling at Fan1
;	Fan0 Temp Controlled but with 100% power
 
;=====================================================================================
; General preferences
;=====================================================================================
G90															; send absolute coordinates...
M83															; ...but relative extruder moves
M550 P"S235"					         		    		; set printer name
M669 K1														; select CoreXY mode
G4 S1														; Wait for Toolboard 1LC
;=====================================================================================
G4 S2														; Wait a moment for the CAN expansion boards to start

;=====================================================================================
; Com Port
;=====================================================================================
M575 P1 B57600 S1											; Activate Serial Com Port for PanelDUE on IO_0
;=====================================================================================



;=====================================================================================
; Network NOT USED BECAUSE SBC
;=====================================================================================
;M587 S"SensorNet" P"Access2018%%"							; Change to your Wlan settings
;M552 S1 P172.18.0.188										; enable network, define internal ip adress
;M586 P0 S1													; enable HTTP
;M586 P1 S0													; disable FTP
;M586 P2 S0													; disable Telnet
;=====================================================================================

;=====================================================================================
;DUAL Z
;=====================================================================================
;M584 X0 Y1 Z2 U5 E3 										; set dual Axis Driver (Driver 0 for X-Axis 1 for Y-Axis 2&5 for Z-Axis 3 for Extruder)

M404 N1.75 D0.4         			                        ; define filament and nozzle diameters for volumetric extrusion


; =====================================================================================================================
; Drives
; =====================================================================================================================
; The D3 setting enables Stealth Chop (when running e.g. TMC2209 drivers). The V setting configures the speed at which
; the switch between Stealth Chop and Spread Cycle occurs.
;
;     V30  = 250.0 mm/sec
;     V40  = 187.5 mm/sec
;     V60  = 125.0 mm/sec
;     V68  = 110.3 mm/sec
;     V600 =   3.1 mm/sec
;
; This can be checked via M569 P0 (or P1, P2, P3, P4) 
; =====================================================================================================================
; Chopper Timing: The Marlin default chopper timing for 24V is defined as { 4, 2, 1 }. This is represented below as
; T4 Y1:2 parameters.
; =====================================================================================================================
; Drive Mappings
; TMC 5160 S0 TMC 2209 S1
;=====================================================================================
;M569 P0.0 S1 D3 V40 T4 Y1:2 								; physical drive 0 (X)  goes backward
M569 P0.0 S1 D3 V40 T4 Y1:2 								; physical drive 0 (X)  goes backward
M569 P0.1 S1 D3 V40 T4 Y1:2 								; physical drive 1 (Y)  goes backward
M569 P0.2 S1 D3 V40 T4 Y1:2 								; physical drive 2 (Z1) goes forwards
M569 P0.3 S1 D3 V40 T4 Y1:2 								; physical drive 3 (Z2) goes forwards
M569 P121.0 S1 D3 V40 T4 Y1:2 								; physical drive 0 on Toolboad 1LC (Extruder) goes forward	
M584 X0.0 Y0.1 Z0.2:0.3 E121.0						    	; set drive mapping

M350 X16 Y16 Z16 E16 I1										; configure microstepping with interpolation
M92 X160.00 Y160.00 Z1600.00  E932.00						; set steps per mm 415.00 war 397

M566 X900.00 Y900.00 Z12.00 E120.00							; set maximum instantaneous speed changes (mm/min)
M203 X5000.00 Y5000.00 Z1200.00 E1200.00					; set maximum speeds (mm/min)
M201 X600.00 Y600.00 Z10.00  E250.00						; set accelerations (mm/s^2)
M906 X1000 Y1000 Z850 E850 I15								; set motor currents (mA) and motor idle factor in per cent
M84 S60								   		    			; Set idle timeout
M564 H0                                                     ; allow unhomed movement

;=====================================================================================
; Axis Limits
;=====================================================================================
; Axis Limits
M208 X-6:229 Y0:235 Z-5:220                                 ; set axis minima /
M671 X-10:235 Y110:110 S3.0

;=====================================================================================
; Endstops
;=====================================================================================
;M558 P0 X0 Y0 Z0 H2 F60 T6000								; Set Z probe type to switch, 
															; the axes for which it is used and the dive height + speeds
;G31 P600 X0 Y0 Z0											; Set Z probe trigger value, offset and trigger height
;M574 X1 S1 P"io6.in"										; configure for GL-8H and mechanical, delete '!' for optical
;M574 Y2 S1 P"!io1.in"										; configure for GL-8H and mechanical, delete '!' for optical
;M574 Z1 S1 P"!io2.in+!io5.in"								; configure for GL-8H and mechanical, delete '!' for optical
;M574 U1 S1 P"!io5.in"										; configure for GL-8H and mechanical, delete '!' for optical
;M574 X1 S3                  	                            ; configure sensorless endstop for low end on x
M574 X1 S1 P"!121.io2.in"
;M574 Y1 S3              	                                ; configure sensorless endstop for low end on y
M574 Y2 S1 P"!io3.in" 
M574 Z1 S2          	                                    ; configure z-probe endstop for low end on z
;M574 Z2 S1 P"!io4.in+!io5.in"								; configure z-probe endstop for high end on z
;M915 X Y R0 F0												; enable sensorless Homing

;=====================================================================================
M915 X Y R0 F0
;=====================================================================================
; Z-Probe
; BL-Touch Left 
;=====================================================================================
M950 S0 C"121.io0.out"                                   	; sensor for BL-Touch
;M558 P8 C"121.io0.in" H1.5 F1000 T12000 A3                  ; set Z probe to PINDA2
;M558 P8 C"121.io0.in" H1.5 F400 T6000 A3        
M558 P8 C"121.io0.in" H5 F1000:120 T7000 A6 				; set Z probe to PINDA2
;M558 P9 C"^121.io0.in" H5 F400 T6000 A1 ;S0.03        	    ; for BL-Touch
G31 P500 X0.0 Y26.0 Z0
M557 X15:200 Y10:180 S30:30									; define mesh grid
;M98 P"0:/sys/setDefaultProbePoints.g"                      ; define default mesh grid

;Calculate bed centre
if !exists(global.Bed_Center_X)
	global Bed_Center_X = floor(move.axes[0].max / 2)
if !exists(global.Bed_Center_Y)
	global Bed_Center_Y = floor(move.axes[1].max  / 2)

;M558 P0 H5 F120 T6000										; disable Z probe but set dive height, probe speed and travel speed

;=====================================================================================
; Heaters & Sensors
;=====================================================================================
M308 S0 P"temp0" Y"thermistor" T100000 B3950 A"Bed"    		; configure sensor 0 as thermistor on pin temp0
M950 H0 C"out0" T0 Q10                             			; create bed heater output on out0 and map it to sensor 0
M307 H0 B0 S1.00                                 			; disable bang-bang mode for the bed heater and set PWM limit
M140 H0                                          			; map heated bed to heater 0
M143 H0 S130 A0 C0                                          ; set temperature limit for heater 0 to 130C - fault if too high

;M308 S1 P"121.temp0" Y"thermistor" T100000 B4138 A"Nozzle"	; configure sensor 1 as thermistor on pin e0temp
M308 S1 P"121.temp0" Y"thermistor" T100000 B4138 C7.06e-8 A"Nozzle"
M950 H1 C"121.out0" T1										; create nozzle heater output on e0heat and map it to sensor 1
M307 H1 R1.822 K0.830:0.000 D6.71 E1.35 S1.00 B0 V24.1		; disable bang-bang mode for heater  and set PWM limit
M143 H1 S285 A0 C0											; set temperature limit for heater 1 to 260C

;M308 S2 P"temp2" Y"thermistor" T100000 B4138 A"Umbenutzt"	; Test sensor
;M950 H2 C"out3" T2											;

M308 S3 Y"drivers" A"Treiber"								;
M308 S4 Y"mcu-temp" A"CPU"									;


;=====================================================================================
; Fans
;=====================================================================================
M950 F0 C"121.out1" Q100									; Hotend Fan - create fan 0 on pin fan0 and set its frequency
M106 P0 H1 T45 C"Hotend"									; set fan 0 value, Set fan speed to 100% if used ,Thermostatic control on
M950 F1 C"121.out2"  Q1250									; Part Cooling Fan - create fan 1 on pin fan1 and set its frequency
M106 P1 S0 H-1 B0.3 C"Druckteil"							; set fan 1 value. Thermostatic control is turned on
;M950 F2 C"out6" ;Q500										; Free Fan Port - create fan 2 on pin fan2 and set its frequency
;M106 P2 S0 H-1												; set fan 2 value. Thermostatic control is turned on


;=====================================================================================
; Tools
;=====================================================================================
M563 P0 S"Extruder" D0 H1 F1								; define tool 0
G10 P0 X0 Y0 Z0												; set tool 1 axis offsets
G10 P0 R0 S0												; set initial tool 0 active and standby temperatures to 0C


;=====================================================================================
; Custom settings
;=====================================================================================
; M912 P0 S-7												; CPU Temp calibration for WebUi, check M912 procedure


;=====================================================================================
; Miscellaneous
;=====================================================================================
M955 P121.0 I54 											; specify orientation of accelerometer on Toolboard 1LC with CAN address 121

M501														; Config overwrite

T0															; select first tool, setzt Hotend 0 auf aktiv 
;M564 S0 H0													; unlock homing 
	
