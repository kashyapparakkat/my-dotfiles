location=left
; location=right
gui_width:=5
if (location="left")
{
	guiX:=0
	guiX2:=guiX+gui_width
}
else
{
	guiX:=a_screenwidth-5
	guiX2:=guiX+5
}
guiY:=150

gui_height:=200
guiY2:=guiY+gui_height

Process, Priority, ,High
#NoEnv
#Persistent, On
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%

; #include lib\notify.ahk
gui,3: +AlwaysOnTop +ToolWindow -caption +LastFound  -SysMenu +Owner ;-border
; Gui,3:Add, Picture, x0 y3 w10 h10 vpic1,  %img%
Gui,3: Margin,0,0  


; hotkey,lshift,off
hotkey,lctrl & lshift,off
lshift_alt_tab:=0

#WinActivateForce
SetBatchLines,-1
SetWinDelay,0
SetKeyDelay,0
CoordMode,Mouse,Screen
applicationname=Altedge
ifexist,autostart_on.ico
	Menu,Tray,Icon, autostart_on.ico 
else
	menu, Tray, Icon, Shell32.dll,35
Gosub,MENU
tabbed=0 
Gui,1:  +AlwaysOnTop +ToolWindow  -caption +LastFound
WinSet, Region, 0-0 w3 H%gui_height%  
Gui, 1: Color, red
;Gui, Add, Picture, x0 y0 h350 w450, %A_WinDir%\system32\ntimage.gif
Gui,1: Add, Button, Default x0 y0 w7 h%gui_height% vbutton1,
guicontrol,1: hide,button1
Gui,1: Show,x%guiX% y%guiY% NoActivate
GUI_ID:=WinExist() 
; SetTimer, timCheckLastWin, 500
WinGet, ignore_list1, ID, ahk_class Shell_TrayWnd	; taskbar_ID
WinGet, ignore_list2, ID, ahk_class TaskListThumbnailWnd ; thumbnail preview

Loop
{
  MouseGetPos,mx,my
  If (mx>=guiX) & (mx<guiX2)& (my>guiY)& (my<guiY2) 
  {   
	  If tabbed=0
		{
			sleep,120
			MouseGetPos,mx,my
			If (mx>=guiX) & (mx<guiX2) & (my>guiY)& (my<guiY2) 
			{
				Gui,1: Show,x%guiX% y%guiY% NoActivate
				
				; Send ,{Alt Down}{TAB}
				sleep,100
				settimer,alt_tab1,-10
				sleep,100
				settimer,alt_tab1,500
				WindowLast:=1
				; tooltip,hwndLast%WindowLast%
				; WinActivate, ahk_id %hwndLast1%
				; SetTimer,alt_tab2,500
			}
			else
				continue
			tabbed=1
	  }
  }
  Else
  {
    If tabbed=1
    {
	  Gui,1: Show,x%guiX% y%guiY%  NoActivate
      SetTimer,alt_tab1,Off
      ; Send,{Alt Up}
	  ; mousemove,7,300
		tooltip,
      tabbed:=0
    }
  }
  Sleep,50
}  

alt_tab2:
	; sleep,500
	; Send,{Alt Down}{Tab}
	soundbeep,800,50
	WindowLast++
	if ( WindowLast>4 )
		WindowLast:=1
	window:=hwndLast%WindowLast%
	; WinActivate, ahk_id %window%
	gosub,alt_tab1
	; tooltip,hwndLast%WindowLast%

Return

MENU:
	Menu,Tray,DeleteAll
	Menu,Tray,Tip,%applicationname%
Return

EXIT:
ExitApp

alt_tab1:
	Send !{ESC}
	soundbeep,800,50
return


; alt_tab1:
	WinGet, AllWinsHwnd, List
	all=
	/*
	Loop, % AllWinsHwnd  
	{
		all.= "`n" . AllWinsHwnd%A_Index%
	}
	*/
	Loop, % AllWinsHwnd  
	{
		WinGet, exStyle, exStyle, % "ahk_id" AllWinsHwnd%A_Index%
		If !(exStyle & 0x100)
		Continue
		WinGetTitle, CurrentWinTitle, % "ahk_id " AllWinsHwnd%A_Index%
		WinGetTitle, active_title, A
		all .= "`n" . CurrentWinTitle
		; tooltip,act=%active_title% cur=%CurrentWinTitle%
		If ( (CurrentWinTitle = active_title) OR  (CurrentWinTitle = "Task Manager") )
			continue
			; msgbox,act=%active_title% cur=%CurrentWinTitle%
			/*
		ifWinExist, %CurrentWinTitle%
		{
			WinActivate
			; WinActivate, %CurrentWinTitle%
			; tooltip, %CurrentWinTitle%
			; sleep,1000
			break
		}
		*/
		; GoSub, MouseCenterInWindow
	}
	; msgbox, %all%
	soundbeep,800,40
	; sleep,200
return


MouseCenterInWindow:
	Sleep, 100
	CoordMode, Mouse, Relative
	WinGetPos,,,Xmax,Ymax,A ; get active window size
	Xcenter := Xmax/2        ; Calculate center of active window
	Ycenter := Ymax/2
	MouseMove, Xcenter, Ycenter
	; WinGetTitle, active_title, A
	; ToolTip, %active_title%
	; Sleep, 500
	; ToolTip
Return


; ~lshift::	; na
	;400 is the maximum allowed delay (in milliseconds) between presses.
	if (A_PriorHotKey = "~lshift" AND A_TimeSincePriorHotkey < 300)
	{
	setTimer,shift_trigger,off
	if (lshift_alt_tab) 
	{

		hotkey,lctrl & lshift,off
		flag=0
		Progress, b    w140  fs16 zh0  CTFFFFFF CWFF0000, ALT TAB OFF, , , Calibri
		Sleep, 500
		Progress, off
		img :="Orange.ico"
		gui,3:hide
	}
	else
	  {
		 
			hotkey,lctrl & lshift,on
			Progress, b   w150 fs16 zh0  CT000000 CW00FF00, Ctrl Shift ON, , , Calibri
			SoundBeep, 1200, 50  ; Play a higher pitch for half a second.
			SoundBeep, 1200, 100  ; Play a higher pitch for half a second.
			Sleep, 200
			Progress, off
			gosub,alt_tab1
			img :="circle green.ico"
			Gui, 3:Show, x1120 y0 NoActivate 
			guicontrol,3:,pic1,%img%
	  }

		lshift_alt_tab:=!lshift_alt_tab
		Sleep 0
		KeyWait lshift
		return
	}
	Sleep 0
	KeyWait lshift
	; if (lshift_alt_tab) 
		; settimer,shift_trigger,400
return

; RButton & Lbutton:: ; alt tab
<^CapsLock:: ; alt tab
	gosub,alt_tab1
return

lctrl & lshift:: ; alt tab
shift_trigger:
	gosub,alt_tab1
	settimer,shift_trigger,off
return


/*	
$LButton::	; na
$^LButton::	; na
	GetKeyState, MIW_RButtonState, RButton, P

	If ( (MIW_RButtonState = "D") )
	{
		gosub,alt_tab1
	}
	Else
	{
		; this feature should be implemented by using a timer because 
		; AutoHotkeys threading blocks the first thread if another 
		; one is started (until the 2nd is stopped)
		
		Thread, priority, 1
		MouseClick, LEFT, , , , , D
		KeyWait, LButton
		MouseClick, LEFT, , , , , U
	}
Return

 
*/