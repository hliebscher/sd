; =====================================================================================================================
; Bed Leveling Helper (called by bed.g)
; Thanks to @jay_s_uk for sharing.
;
; Assuming a Y size of ~210mm, 105mm should center the build plate between the
; Z motors.
;
; X0 & X230 should move the motors to the leftmost and rightmost positions that
; a BLtouch can reach. Needs to be adapter for PINDA probe.
; =====================================================================================================================
;G30 P0 X0 Y105 Z-99999                                                         ; Probe near left leadscrew
;G30 P1 X190 Y105 Z-99999 S2                                                    ; Probe near right leadscrew
G30 P0 X0 Y{move.axes[1].max / 2  + sensors.probes[0].offsets[1]} Z-99999       ; Probe near left leadscrew
G30 P1 X190 Y{move.axes[1].max / 2  + sensors.probes[0].offsets[1]} Z-99999 S2  ; Probe near right leadscrew