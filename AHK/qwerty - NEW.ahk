; http://www.cibinmathew.com
; github.com/cibinmathew



close_triggered:=0
is_pre_spc = 0
is_pre_x = 0
withhold_space:=0
ifexist,qwerty.ico
	Menu, Tray, Icon, qwerty.ico
else
	menu, Tray, Icon, Shell32.dll, 28
; times new roman o=0 georgia 10.5
/*

; ^b::
If ( is_in_an_emacs_window() &&  GetKeyState("RCtrl"))
	send key
else ; ie, if left
	trigger paste collector

paste coll
left for ahk func
right for emacs ^b
space forward

*/



keyBoard_mode=1
#InputLevel 1
#SingleInstance force

#include C:\cbn_gits\AHK\LIB\json.ahk
#include C:\cbn_gits\AHK\LIB\emacs_functions.ahk
#include C:\cbn_gits\AHK\LIB\misc functions.ahk
#include C:\cbn_gits\AHK\LIB\explorer.ahk
emacs_single_keys=s,h,u



space & a::
space & b::
space & c::
space & d::
space & e::
space & f::
space & g::
space & h::
space & i::
space & j::
space & k::
space & l::
space & m::
space & n::
space & o::
space & p::
space & q::
space & r::
space & s::
space & t::
space & u::
space & v::
space & w::
space & x::
space & y::
space & z::

space & /::
space & .::
space & ,::

space & `;::
; space & -::
space & =::
space & '::

$!b::
$!d::
$!f::
$!v::
$!w::
$!.::
$!/::
$!,::
!Backspace::
;^b::
s::
h::
u::

	StringReplace, HK, A_ThisHotkey, <, , All
	StringReplace, HK, HK, $, , All
	HK:=encode_key_combo(HK)

	if keyBoard_mode=1
	{

		HK:=space_to_ctrl(HK)
		
		If (is_in_an_emacs_window())
		{	; send it directly
			send_key(HK)
		}
		else if HK in %emacs_single_keys%
		{
			; execute that
			gosub,key_combo_%HK%
		}
		else
		{
			HK := translate_emacsCombo_to_Normal_combo_and_send(HK)
		}
		
		; msgbox,%HK%
		
	}
return

fallbackToDefault() {
	StringReplace, HK, A_ThisHotkey, <, , All
	; msgbox,%HK%
	current:= A_SendLevel 
	Sendlevel, 1
	send, %HK%
	; Sendlevel, %current%
}
 
undo() {
	Send ^z
	global is_pre_spc = 0
	Return
}
~esc::
	quit()
return

quit() 
{
; msgbox, sending esc
	Send {Esc}
	global is_pre_x = 0
	global is_pre_spc = 0
	settimer,removetooltip3,-10
	Return
}
key_combo_A_Dot:
	send,^{End}
	Send {Ctrl Up}
	return
key_combo_A_Comma:
	send,^{Home}
	Send {Ctrl Up}
	return
	

move_word(direction) {
if(direction==1)
	send,^{right}
else 	
	send,^{left}
global is_pre_spc = 0
Send {Ctrl Up}
	Return
}

delete_word(direction) {
if(direction==1)
	send,^+{right}
else 	
	send,^+{left}
Send {Del}
global is_pre_spc = 0
	Return
}
delete_char() {
	Send {Del}
	global is_pre_spc = 0
	Return
}

key_combo_h:
  If ( is_pre_x) 
  {
    send ^a
    is_pre_x = 0
	
    settimer,removetooltip3,10
    settimer,removetooltip,500
  }
  Else
    fallbackToDefault()
 Return

key_combo_C_Forward_slash:
	undo()
	return
	
key_combo_u:
If ( is_pre_x) 
  {
    undo()
    settimer,removetooltip3,-10
    ;tooltip,save
    is_pre_x = 0
  }
  Else
    fallbackToDefault()
 Return

key_combo_s:
 
If ( is_pre_x) 
  {
    send ^s
    settimer,removetooltip3,10
    settimer,removetooltip,500
    tooltip,save
    is_pre_x = 0
  }
  Else
    fallbackToDefault()
 Return

key_combo_A_b:
	move_word(-1)
	Return
	
key_combo_A_f:
	move_word(1)
	Return
	
key_combo_A_Backspace:

	delete_word(-1)
	Return
	
key_combo_A_d:

	delete_word(1)
	Return
	
key_combo_C_d:
	delete_char()
	Return
 
key_combo_C_g:
	; msgbox,%A_ThisHotkey%
	; msgbox,% is_in_an_emacs_window()
	
  ; If (is_in_an_emacs_window())
    ; fallbackToDefault()
  ; Else
	{
		is_pre_spc = 0
		is_pre_x = 0
		SetTimer,removetooltip3,-10
		quit()
	}
Return
  
key_combo_C_s:
  ; If is_in_an_emacs_window()
    ; fallbackToDefault()
  ; Else
   
   If ( is_pre_x) 
  {
	send ^s
    settimer,removetooltip3,10
    settimer,removetooltip,500
    tooltip,save
    is_pre_x = 0
	
  }
  else
	{
		send, ^f
   
		is_pre_x = 0
		
		settimer,removetooltip3,10
		settimer,removetooltip,500
	}
Return 
 
key_combo_C_x:
  ; If is_in_an_emacs_window()
    ; fallbackToDefault()
  ; Else
	{
		is_pre_x = 1	    
		MouseGetPos, xpos, ypos 
		xpos+=5
		ypos+=15 
		tooltip,X= %is_pre_x%,%xpos%,%ypos%,3
	}
Return
  
space_to_ctrl(HK)
{
	StringLeft, root_Hk, HK, 10
	StringLeft, root_Hk3, HK, 8
	StringLeft, root_Hk2, HK, 4
	if (root_Hk = "Spc-Shift-")
	{
		StringReplace, HK, HK, Spc-Shift- , C-S-, All
	}
	else if (root_Hk3 = "Spc-Alt-")
	{
		StringReplace, HK, HK, Spc-Alt- , C-A-, All
	}
	else if (root_Hk2 = "Spc-")
	{
		StringReplace, HK, HK, Spc- , C-, All
	}
	return HK
}

removetooltip3:
	settimer,removetooltip3,off
	tooltip,,,,3
return
removetooltip:
	settimer,removetooltip,off
	tooltip
return

space & 9::
	run, "C:\cbn_gits\AHK\run python.py"
	return
	
Space & 5::
	send,{lbutton}
return

Space & 6::

	send,{Rbutton}
return

Space & 3::	; na
	MouseMove, 0, -9, 0, R
return

Space & 8::	; na
	MouseMove, 0, 9, 0, R
return

Space & 4::	; na
	MouseMove, -9, 0, 0, R
return

Space & 7::	; na
	MouseMove, 9, 0, 0, R
return



Lalt & 3::

if WinExist("ahk_class Chrome_WidgetWin_1")
	WinActivate,ahk_exe chrome.exe
else if WinExist("ahk_class MozillaWindowClass")
	WinActivate,ahk_exe firefox.exe


return
Lalt & q::
; ahk_class ExploreWClass|CabinetWClass
	if WinExist("ahk_class ExploreWClass") or WinExist("ahk_class CabinetWClass") 
		WinActivate,ahk_exe explorer.exe
	return
#ifwinnotactive, ahk_exe emacs.exe
Lalt & e::
#ifwinactive
	WinActivate,ahk_exe emacs.exe ;ahk_class Emacs
	return
	
close_active_window:
	if (no_block_for_closing)
	{
		winclose, A
	}
	else
		tooltip,cancelled
	sleep,200
	tooltip
	no_block_for_closing:=0
	close_triggered:=0
return
	
Ralt & x::

; TODO: instead of alt-x again to cancel, just need x
; https://autohotkey.com/board/topic/42474-is-it-possible-to-make-a-window-flash/
if (close_triggered)
	{
		no_block_for_closing:=0
	; msgbox
		return
	}
if (A_PriorHotKey = A_thisHotKey AND A_TimeSincePriorHotkey < 300)
{
	tooltip,alt x again to cancel
	close_triggered:=1
	settimer,close_active_window,-1000
	no_block_for_closing:=1
	hWnd := WinActive( "A" )
	DllCall( "FlashWindow", UInt,hWnd, Int,True )
	Sleep 500
	DllCall( "FlashWindow", UInt,hWnd, Int,False )
}
; else

return

RALT & i::
  Winmaximize,A
  return
msgbox
RALT & a:: ALTTAB
RALT & s:: SHIFTALTTAB
;!a::
	Send  {ALT DOWN}{TAB}{ALT UP}
	;Send  {ALT DOWN}{TAB}
	;keywait, Alt
	;Send {ALT UP}
return

; solve nd settle this all below


#IfWinNotActive, ahk_class dopus.lister
; space & lctrl::
	send ,^a
return

#IfWinNotActive


rctrl & space::	; na
	send ^{space}
return

; space & lshift::	; na
	send, {home}
return

lshift & space::	; na
	send, {end}
return
 
rshift & space::	; na
	send, +{home}
return

space & rshift::	; na
	send, +{end}
return



/*
; lshift & rshift::	; na
; send, ^{end}
; return

<+space::	; na
return

*/
lshift & rshift::	; na
	hotkey, lshift & space,off
	; hotkey,<+space,off

	; hotkey,*space,off
	withhold_space:=1
	keywait, rshift
	again1:
	GetKeyState, state_lshift,lshift
	if state_lshift=D
	{
		; GetKeyState, state_space,Space
		; tooltip,lshift:%state_lshift% space:%state_space%
		; sleep,100
		if state_space=D
		{
			keywait,space
			sleep,10
			send, ^+{end}
			sleep,10
			hotkey,lshift & space,on
			withhold_space:=0
			tooltip
			state_space=
			return
		}
		sleep,50
		goto,again1
	}
	else
		send, ^{end}
	hotkey,lshift & space,on
	withhold_space:=0
	tooltip
	state_space=
return

rshift & lshift::	; na
	hotkey,rshift & space,off
	; hotkey,<+space,off

	; hotkey,*space,off
	withhold_space:=1
	keywait, lshift
	again2:
	GetKeyState, state_rshift,rshift
	if state_rshift=D
	{
		; GetKeyState, state_space,Space
		; tooltip,rshift:%state_rshift% space:%state_space%
		; sleep,100
		if state_space=D
		{
			keywait,space
			sleep,10
			send, ^+{home}
			sleep,10
			hotkey,rshift & space,on
			withhold_space:=0
			tooltip
			state_space=
			return
		}
		sleep,50
		goto,again2
	}
	else
		send, ^{home}
		hotkey,rshift & space,on
		withhold_space:=0
		tooltip
		state_space=
return

; space::	; na
; msgbox,space
; return

<+space::	; na
	if ( withhold_space)
	{
		state_space=D
		; msgbox, shift space with space hold
		return
	}
	msgbox,L shift space
return

>+space::	; na
if ( withhold_space)
{
	state_space=D
	; msgbox, shift space with space hold
	return
}
msgbox,rshift space
return

space & lwin::	; na
	send, ^s
return
<#space::	; na
	gosub,paste_all_F
	sleep , 20
	keywait, Lwin
	sleep , 20
	send, {enter}
return

lctrl & space::	;	send, {enter}
	send, {enter}
return

; ^space::	; na
	send, {enter}
return
;#InputLevel, 0 
$space::	; na 
SendLevel 0
if !( withhold_space)
	Send {space}

return

; $space::
KeyWait, space, U T1 ; Wait for the space button to be released.
msgbox,%ErrorLevel%
if  (ErrorLevel = 0) {  ; space was not held too long. A long press indicates an aborted shift, not a space, so ignore.
  Send {space}
}
return 


; Space & CapsLock::	; na
	Send, {Enter}
return 

; $space::	; na
; if !( withhold_space)
	; Send {space}
; return

paste_all_F:
	send,^a
	sleep,10
	send ^v
return


nil:
return



encode_key_name(this_key)
{
	stringreplace,newHK,this_key,^,space_
	stringreplace,newHK,newHK,!,alt_
	stringreplace,newHK,newHK,`,,comma_
	stringreplace,newHK,newHK,.,dot_
	stringreplace,newHK,newHK,/,b_slash_
	stringreplace,newHK,newHK,',s_quotes_
	stringreplace,newHK,newHK,`;,colon_
	stringreplace,newHK,newHK,[,sq_bracketL_
	stringreplace,newHK,newHK,],sq_bracketR_
	stringreplace,newHK,newHK,-,minus_
	stringreplace,newHK,newHK,=,equal_
	
	return newHK
}

decode_keys(this_key)
{
	stringreplace,newHK,this_key,space_,^
	stringreplace,newHK,newHK,alt_,!
	stringreplace,newHK,newHK,comma_,`,
	stringreplace,newHK,newHK,dot_,.
	stringreplace,newHK,newHK,b_slash_,/
	stringreplace,newHK,newHK,s_quotes_,'
	stringreplace,newHK,newHK,colon_,`;
	stringreplace,newHK,newHK,sq_bracketL_,[
	stringreplace,newHK,newHK,sq_bracketR_,]
	stringreplace,newHK,newHK,minus_,-
	stringreplace,newHK,newHK,equal_,=
	
	return newHK
}


send_HalfKeyboard:
if (regexmatch(A_ThisHotkey, "^space &(.*)"))
{
	ThisKey := A_ThisHotkey
	; Determine the mirror key, if there is one:
	if ThisKey = space & `;
	   MirrorKey = a
	else if ThisKey = space & ,
	   MirrorKey = c
	else if ThisKey = space & .
	   MirrorKey = x
	else if ThisKey = space & /
	   MirrorKey = z
	else  ; To avoid runtime errors due to invalid var names, do this part last.
	{
	   StringRight, ThisKey, ThisKey, 1
	   StringTrimRight, MirrorKey, mirror_%ThisKey%, 0  ; Retrieve "array" element.
	   if MirrorKey =  ; No mirror, script probably needs adjustment.
		  return
	}
 
	Modifiers =
	GetKeyState, state1, LWin
	GetKeyState, state2, RWin
	state = %state1%%state2%
	if state <> UU  ; At least one Windows key is down.
	   Modifiers = %Modifiers%#sss
	GetKeyState, state1, Control
	if state1 = D
	   Modifiers = %Modifiers%^
	GetKeyState, state1, Alt
	if state1 = D
	   Modifiers = %Modifiers%!
	GetKeyState, state1, Shift
	if state1 = D
	   Modifiers = %Modifiers%+
	Send %Modifiers%{%MirrorKey%}
}
return

Space & down::
	send ^{down}
return

Space & up::
	send ^{up}
return
Space & enter::
	send ^{enter}
return
#IfWinActive, ahk_class CabinetWClass
*::
ControlGet renamestatus,Visible,,Edit1,A
ControlGetFocus focussed, A
if(renamestatus!=1 && (focussed=”DirectUIHWND3″||focussed=SysTreeView321))
{

}
else
{
sleep,222
; hwnd := hwnd ? hwnd : WinExist("A")
filepath:=Explorer_GetSelection()
	sel_msg =
for item in filepath
	sel_msg .= item.path "`n"
; filepath := get_current_filepath_from_active_window()
msgbox, %sel_msg%
parent_filepath:=get_parent_filepath()
Runwait, %comspec% /c ""C:/Users/cibin/Downloads/7z1604-extra/7za.exe" e "%sel_msg%"","%parent_filepath%",

}
return

#IfWinActive
; http://www.howtogeek.com/howto/8955/make-backspace-in-windows-7-or-vista-explorer-go-up-like-xp-did/
#IfWinActive, ahk_class CabinetWClass
Backspace::
ControlGet renamestatus,Visible,,Edit1,A
ControlGetFocus focussed, A
if(renamestatus!=1 && (focussed=”DirectUIHWND3″||focussed=SysTreeView321))
{
SendInput {Alt Down}{Up}{Alt Up}
}else{
Send {Backspace}
}
#IfWinActive