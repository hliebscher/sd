; =========================================================================================================
; bed.g
; called to perform automatic bed compensation via G32
; =========================================================================================================
M561                                                                   ; clear any existing bed transform
G29 S2
M290 S0 R0                                      ; clear baby steps 
; =========================================================================================================
;
if !move.axes[0].homed || !move.axes[1].homed                                  ; If the printer hasn't been homed, home it
	M98 P"0:/sys/homexy.g"                                                     ; home y and x
M401
M558 H8 F600:300                                             ; 
G1 X{move.axes[0].max / 2 - sensors.probes[0].offsets[0]} Y{move.axes[1].max / 2  - sensors.probes[0].offsets[1]} F2800
M400
G30
M400
;
M98 P"bed_twoscrews.g"                                               ; perform bed tramming
M558 H5 F300:150                                                     ; 
echo "Bed Traming Cycle: 1 - Differenz ist " ^ move.calibration.initial.deviation ^ "mm"
while move.calibration.initial.deviation >= 0.01                     ; perform additional tramming if previous deviation was over 0.01mm
  if iterations = 5
    abort "Zu viele Versuche"
  if iterations = 0
  M558 H5 F300:150  
  if iterations = 1
  M558 H5 F150:60  
  M98 P"bed_twoscrews.g"                                                ; perform bed tramming
  echo "Bed Traming Cycle: " ^ iterations + 2 ^ " - Differenz ist " ^ move.calibration.initial.deviation ^ "mm"
  continue
M558 H2 F150:60                                                 ; 
G1 X{move.axes[0].max / 2 - sensors.probes[0].offsets[0]} Y{move.axes[1].max / 2  - sensors.probes[0].offsets[1]} F2800
M400
G30
M400
M558 H4 F600:300  
M402