; =========================================================================================================
;
; home xyz axes
;
; for Caribou220 Duet3Mini5+ WiFi/Ethernet LGX Mosquito - E3d or SE Thermistor - SuperPINDA
;
; =========================================================================================================
if !move.axes[0].homed || !move.axes[1].homed 	 		    ; If the printer hasn't been homed, home it
	M98 P"homexy.g"
;
G91                                                                    ; relative positioning
G4 P200                                                                ; wait 200ms
G1 H2 Z10 F6000                                                        ; lift z relative to current position
M280 P0 S160                                                           ; reset BL-Touch
M400                                                                   ; wait for current moves to finish
;
; =========================================================================================================
G90                                                                    ; absolute positioning
; =========================================================================================================
; Home Z Axis
; =========================================================================================================
M401
G90              	; absolute positioning
;G1 X135 Y115 F5000 	; move probe to bed center
G1 X{move.axes[0].max / 2 - sensors.probes[0].offsets[0]} Y{move.axes[1].max / 2  + sensors.probes[0].offsets[1]} F2800
;G1 X{move.axes[0].machinePosition - sensors.probes[0].offsets[0]} Y{move.axes[1].machinePosition - sensors.probes[0].offsets[1]} F1800

M558 F400			; set probe feed rate at 600mm/m
G30              	; probe Z (at high speed)
M558 F120			; reset probe feed rate to 120mm/m
G30					; probe Z (low speed)
M400                                                                   ; wait for current moves to finish
; =========================================================================================================
M402
; =========================================================================================================
G90                                                                    ; absolute positioning
; =========================================================================================================
