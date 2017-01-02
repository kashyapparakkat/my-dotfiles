
~LButton & g::	; na
tooltip,a
TimeLastChange := A_TickCount
sleep,1000
GetKeyState, state1, lButton
GetKeyState, state2,g
if (state1 ="D") && (state2 ="D" )
	msgbox,
Return