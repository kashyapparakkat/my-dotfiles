
SplitPath, A_ScriptDir , , , , , A_Script_Drive
SetTimer, REL_ScriptReload, 1000
SetTimer, RUNNING_CHECK, 60000

menu, Tray, Icon, Shell32.dll, 45


Gui, Font,s10,comic sans bold 
gui, +AlwaysOnTop +ToolWindow -caption +LastFound  -SysMenu +Owner -border
Gui, Add, Tab2,  -Wrap , One|Two

 


Gui, Add, button,  w120 h30 cBlue gdrag_copy_on,   drag copy ON
Gui, Add, button,  w120 h30 cBlue gdrag_copy_off,   drag copy OFF
; Gui, Add,text, separator
Gui, Tab, 2

;Gui, Add,text, separator
Gui, Add, button, w120 h30 cBlue gvolOn, vol on
Gui, Add, button,  w120 h30 cBlue gvolOff, vol off 
; Gui, Add,text, separator
Gui, Add, Button,  w120 h30  gbkOn, caps: bk
Gui, Add, Button,  w120 h30 gtabmenuon, caps: tabmenu
; Gui, Add,text, separator
;Gui, Add, GroupBox,  w115 h90 +Left, King Virus
Gui, Add, button,  w120 h30 cBlue gtrial2, trial 2
Gui, Add, button, w120 h30 cBlue gtrial1, trial 1
; Gui, Add,text, separator
;Gui, Add, GroupBox,  w115 h90 +Left, King Virus
;Gui, Add, DateTime, vMyDateTime, LongDate 
 Gui, Add, StatusBar,, Bar's starting text (omit to start off empty).
SB_SetText("There are " . RowCount . " rows selected.")

Gui, Font, norm







SetTimer, CheckMouse, 750
 





#SingleInstance force

WinGetPos,,,Xmax,Ymax,ahk_class Progman  ; get desktop size

Xcenter := Xmax/2        ; Calculate center of screen
Ycenter := Ymax/2

T = 2   ; adjust tolerance value if desired

Xmax := Xmax - T   ; allow tolerance to mouse corner activation position
Ymax := Ymax - T



loop
{
suspend, PERMIT

IniRead, flag_suspend, %A_Script_Drive%\cbn\ahk\myfile.ini, gui_launcher, flag
IniRead, flag_self, %A_Script_Drive%\cbn\ahk\myfile.ini, gui_launcher, flag_self
	If (flag_self=0)
	{
		If ( !A_IsSuspended )
			{
				suspend,on
			}
	}
	if ((flag_suspend=0) and (flag_self=1))
		{
			If ( !A_IsSuspended )
		{
			suspend,on
		}
		}
	else
	{
		If (flag_self=1)
		{
			 
		If ( A_IsSuspended )
		{
			suspend,off
		}
		}
	}
sleep 3000
}
return 



CheckMouse:                   ; check mouse position
CoordMode, Mouse, Screen
MouseGetPos, MouseX, MouseY

GetKeyState, SState, Shift
GetKeyState, AState, Alt
GetKeyState, CState, Control

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Commands for top left corner
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

if (MouseY < T and MouseX < T and CState = "U" and AState = "U" and SState = "U")
{
	Gui, Show, x100 y60 ;noactivate
	sleep 500
	loop
   {
	IfWinNotActive,ahk_class AutoHotkeyGUI
	{
	Gui, hide
	return
	}
 }
return
}	

return








;
;
drag_copy_on:

IniWrite, 1, %A_Script_Drive%\cbn\ahk\myfile.ini, drag_copy, flag_self
return
drag_copy_off:
IniWrite, 0, %A_Script_Drive%\cbn\ahk\myfile.ini, drag_copy, flag_self
return
voloff:
IniWrite, 0, %A_Script_Drive%\cbn\ahk\myfile.ini, vol, flag_self
return
volon:
IniWrite, 1, %A_Script_Drive%\cbn\ahk\myfile.ini, vol, flag_self
return


bkon:
IniWrite, backspace_f , %A_Script_Drive%\cbn\ahk\keys.ini, section1, capslock_A
return
tabmenuon:
IniWrite, tabmenu_f , %A_Script_Drive%\cbn\ahk\keys.ini, section1, capslock_A
return

calc:
run calc
return


trial1:

 Run,%A_Script_Drive%\cbn\ahk\trial1.ahk
return
trial2:

 Run,%A_Script_Drive%\cbn\ahk\trial2.ahk
return



REL_ScriptReload:
	FileGetAttrib, REL_Attribs, %A_ScriptFullPath%
	IfInString, REL_Attribs, A
	{
		FileSetAttrib, -A, %A_ScriptFullPath%
		If ( REL_InitDone )
		{ 		 
			MsgBox, 4145, Update Handler - %SYS_ScriptInfo%, The following script has changed:`n`n%A_ScriptFullPath%`n`nReload and activate this script?
		 	IfMsgBox, OK
				Reload
		}
	}
	REL_InitDone = 1
Return
 RUNNING_CHECK:
 Iniwrite, 1,  myfile.ini, googler , running