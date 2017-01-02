#SingleInstance force
ifexist,fast typing.ico
	Menu, Tray, Icon, fast typing.ico
SplitPath, A_ScriptDir , , , , , A_Script_Drive

; #include lib\ini.ahk
; #include lib\notify.ahk
; #include lib\AddGraphicButton.ahk
#include C:\cbn_gits\AHK\LIB\misc functions.ahk
suspend_if_VMwareHorizonClient()
change :=1
img :="circle green.ico"
; AddGraphicButton("Notifications" . GB_Number, img, "x0 y0 w15 h10 gChange")
gui, +AlwaysOnTop +ToolWindow -caption +LastFound  -SysMenu +Owner ;-border
Gui, Margin,0,0  
; Gui, Show, x1350 y726 NoActivate  
Gui, Show, x1340 y0 NoActivate  
SetBatchLines,-1

mod__=
f_j = left 
f_k = down
f_l = right
f_i = up

/*
f_h = home
d_h = home
mod_d_h = ^

j_d = backspace
j_f = del 

;space & key = ctrl + %key%
space_a=a
space_s=s
space_d=d
space_f=f
space_z=z
space_j=v
space_k=c
space_l=x
return
*/
;	TRIGGERS
f & l::	; na
f & j::	; na
f & k::	; na
f & i::	; na
/*
d & h::	; na
; f & h:: 	; home



j & d::	; na
j & f::	; na
a & s::	; na
a & d::	; na
a & f::	; na
a & g::	; na
 */

	Stringleft, leftKey, A_ThisHotkey, 1
	StringRight, rightKey, A_ThisHotkey, 1

	;StringTrimRight, MirrorKey, %ThisKey%_%ThisKey%, 0  ; Retrieve "array" element.
	 Mirror := %leftKey%_%rightKey%
	 Mirrorkey = %mirror%
	  modifier1 := mod_%leftKey%_%rightKey%
	if MirrorKey !=  ; No mirror, script probably needs adjustment.
 /*
Modifiers =
;modifier analysis
GetKeyState, state1, LWin
GetKeyState, state2, RWin
state = %state1%%state2%
if state <> UU  ; At least one Windows key is down.
   Modifiers = %Modifiers%#
GetKeyState, state1, Control
if state1 = D
   Modifiers = %Modifiers%^
GetKeyState, state1, Alt
if state1 = D
   Modifiers = %Modifiers%!
GetKeyState, state1, Shift
if state1 = D
   Modifiers = %Modifiers%+   
  */    
; msgbox, %Modifier1%{%MirrorKey%}
Send %Modifier1%{%MirrorKey%}

return 

;individual keys

f & `;::	; na
	send {end}
return

d & `;::	; na
	send ^{end}
return

f & h::	; na
	send {home}
return

d & h::	; na
	send ^{home}
return

/*
a & `;::	; na
send {tab} 


`; & a::	; na
send {esc}		
return

`;::	; na
send {enter}
return

d & `;::	; na
send ^{enter}
return

s & `;::	; na
send +{enter}
return



d & i::	; na
send, {up 4}
return
d & k::	; na
send, {down 4}
return


a & u::	; na
send, ^{left}
send, +^{right}

return
a & i::	; na
send, {home}
send, +{end}
return

j & s::	; na
send, {home}
send, +{end}
send, ^c
send, {end}
send, {enter}
send, ^v
return

j & a::	; na
send, {home}
send, +{end} 
send, {del}
send, {del}
return

*/

$a::	; na
$s::	; na
$d::	; na
$f::	; na
$j::	; na
$v::	; na
StringRight, thisKey, A_ThisHotkey, 1
send %thiskey%
return


$^+d::	; na
$^a::	; na
$^s::	; na
$^d::	; na
$^f::	; na
$^h::	; na
$^j::	; na
$^k::	; na
$^l::	; na
$+a::	; na
$+s::	; na
$+d::	; na
$+f::	; na
$+g::	; na
$+h::	; na
$+j::	; na
$+k::	; na
$+l::	; na
$!a::	; na
$!s::	; na
$!d::	; na
$!f::	; na
$!g::	; na
$!h::	; na
$!j::	; na
$!k::	; na
$!l::	; na
$#!a::	; na
$#!s::	; na
$#!d::	; na
$#!f::	; na
$#!g::	; na
$#!h::	; na
$#!j::	; na
$#!k::	; na
$#!l::	; na
Stringtrimleft, thisKey, A_ThisHotkey, 1

send %thiskey%

; send, %a_thishotkey%
return


/*
;
<+`;::	; na
send, `;
return



>+`;::	; na
send, :
return
*/

/*
space & a::	; na
space & s::	; na
space & d::	; na
space & f::	; na
space & z::	; na
space & j::	; na
space & k::	; na
space & l::	; na
StringRight, rightKey, A_ThisHotkey, 1
key :=space_%rightKey%
send, ^{%Key%}
return

*/
nil:
	return
		
RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip
	return		

change:	; display and toggle status

	if (change)
	{
		change:=0
		img :="Orange.ico"
		suspend, on
		tooltip,fast typing suspended

	}
	else
	{
		change :=1
		img :="circle green.ico"
		suspend, off
		tooltip,fast typing ACTIVATED
	}

	; AddGraphicButton("Notifications" . GB_Number, img, "x0 y0 w10 h10 gChange")
	sleep,1000
	tooltip,
return