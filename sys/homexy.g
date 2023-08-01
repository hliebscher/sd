; homeyx.g
; called to home x and y axes
;
; Warning: do not home individual axes by calling G28 X or G28 Y. It will cause errors. 
; Instead run the macro file directly. IE M98 P"0:/sys/homex.g"
;
M98 P"/sys/homex.g"
M98 P"/sys/homey.g" 
