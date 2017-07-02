; multiple example for capslock use cases http://vim.wikia.com/wiki/Map_caps_lock_to_escape_in_Windows



menu, Tray, Icon, Shell32.dll, 90
#SingleInstance Force
#InstallKeybdHook
#UseHook On
<+capslock::	;	send, {del}
	send, {del}
return
>+capslock::
SetCapsLockState, % GetKeyState("CapsLock", "T")? "Off":"On"
	GetKeyState, CapState, CapsLock, T
	
	settimer,removetooltip,400
	If CapState=U
	{
		tooltip,caps off
		SetCapsLockState, off
	}
	Else if CapState=D
	{
		tooltip,CAPS ON
		SetCapsLockState, on
	}
return

; CapsLock::	; na
	;GetKeyState, state, CapsLock, P
	;if (state="D")
Capslock::Esc

;CapsLock up::	; na
	state := GetKeyState("Space" , "P")

	if !state
	{
			Send, {BackSpace}
			settimer,removetooltip,-400
			tooltip,cap &hjkl `,.
	}
return

removetooltip:
	settimer,removetooltip,off
	tooltip
return



CapsLock & k::send +{up}
CapsLock & j::send +{down}
CapsLock & l::send ^+{right}
CapsLock & h::send ^+{left}
CapsLock & ,::send +{Home}
CapsLock & .::send +{end}

CapsLock & g::send {Esc}

; make safe for i,semi colon to prevent accidental key press
CapsLock & `;:: return
CapsLock & ':: return
CapsLock & i:: return

