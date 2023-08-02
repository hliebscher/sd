T0                                                                     ; ensure the tool is selected
;
M572 D0 S0.0                                                           ; clear pressure advance.
M220 S100                                                              ; set speed factor back to 100% in case it was changed
M221 S100                                                              ; set extrusion factor back to 100% in case it was changed
M290 R0 S0                                                             ; clear any baby-stepping
M106 S0                                                                ; turn part cooling blower off if it is on
M703                                                                   ; execute loaded filament's config.g
M501
G32                                                                    ; execute bed.g (level gantry)
G29 S1                                                                 ; load bed mesh for the system's set filament type
M400                                                                   ; finish all moves, clear the buffer
G90                                                                    ; absolute Positioning
M83           