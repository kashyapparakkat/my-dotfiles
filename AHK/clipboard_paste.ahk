#include C:\cbn_gits\AHK\LIB\HK_Cycle dev2.ahk
SplitPath, A_ScriptDir , , , , , A_Script_Drive
#SingleInstance Force
#include LIB\cbn.ahk
IniRead, last_ext1, %a_scriptname%.ini, settings, last_ext1
if last_ext1=""
	this_ext:="txt"
IniRead, last_location1, %a_scriptname%.ini, settings, last_location1
ifnotexist,%last_location1%
	last_location1=--NA--
#include LIB\misc functions.ahk
ClipbSaveHotkey:=0
ClipbSaveHotkey_count:=0


ifexist,add.ico
	Menu, Tray, Icon,add.ico
notepadpp_installed:=0
sublime_installed:=0
ifexist , C:\Program Files\Sublime Text 3\sublime_text.exe
	; msgbox
	sublime_installed:=1
ifExist, C:\Program Files(x86)\Notepad++\notepad++.exe
	notepadpp_installed:=1
; OnExit, ExitSub



return

removetooltip:
	settimer ,removetooltip,off
	tooltip
return

$^q::	; na
	send ^q

Return


nil:
return

<^+p::	; ClipbSave to file hk cycle 
settimer,cancelClipbSaveHotkey,off	
if !(ClipbSaveHotkey)	;	if hotkey is currently not in cycle mode 
{
	ClipbSaveHotkey_count:=0
	last_clipb:=clipboard
	sleep,100
	send, ^c
	sleep,100
	selText:=Get_Selected_Text()
	clipboard:=last_clipb
}
settimer,cancelClipbSaveHotkey,-3500	

if (ClipbSaveHotkey_count=0)
{	

	ClipbSaveHotkey_count++
	tmp_txt:=truncated_text(clipboard,150)
	msg=save clipB here`n`n%tmp_txt%
	settimer,removetooltip,-3600
	tooltip,%ClipbSaveHotkey_count% %msg%
	ClipbSaveHotkey_action = create_open_clipb
}
else if (ClipbSaveHotkey_count=1)
{	
	ClipbSaveHotkey_count++
	msg=save clipb in last_location`n%last_location1%\###.%last_ext1%
	settimer,removetooltip,-3600
	tooltip,%ClipbSaveHotkey_count% %msg%
	
	ClipbSaveHotkey_action = create_open_clipb_last_location	
}
else if (ClipbSaveHotkey_count=2)
{	

	ClipbSaveHotkey_count++
	msg=saveas_clipb_save_seltext`n%last_location1%\%last_clipb%
	settimer,removetooltip,-3600
	tooltip,%ClipbSaveHotkey_count% %msg%
	
	ClipbSaveHotkey_action = saveas_clipb_save_seltext
}
else if (ClipbSaveHotkey_count=3)
{	

	ClipbSaveHotkey_count++
	msg=step4
	settimer,removetooltip,-3600
	tooltip,%ClipbSaveHotkey_count% %msg%	
	ClipbSaveHotkey_action = nil	
}
else
{	
	ClipbSaveHotkey_count:=0
	msg=cancel
	settimer,removetooltip,-2600
	tooltip,%ClipbSaveHotkey_count% %msg%
	settimer,cancelClipbSaveHotkey,-2500		
}
	
	ClipbSaveHotkey:=1
	hotkey,^q,on
	setTimer,ClipbSaveHotkey,70
	sleep,10



ClipbSaveHotkey:	;	cancel checking status of ctrl key
	GetKeyState,state,CTRL
	If state=u
	{
		gosub,cancelClipbSaveHotkey
		if (ClipbSaveHotkey_count=0)
		{	
			settimer,removetooltip,-1500
			tooltip,%ClipbSaveHotkey_count% cancelled
		}
		else if (ClipbSaveHotkey_count=1)
		{
			gosub,%ClipbSaveHotkey_action%
		}
		else if (ClipbSaveHotkey_count=2)
		{	
			gosub,%ClipbSaveHotkey_action%
		}
		else if (ClipbSaveHotkey_count=3)
		{
			gosub,%ClipbSaveHotkey_action%
		}
	}
return

cancelClipbSaveHotkey:	;	cancel without action
	setTimer,ClipbSaveHotkey,off
	ClipbSaveHotkey:=0
	; tooltip,cancelling
	; settimer,removetooltip,-300
	hotkey,^q,off
	
return

create_open_clipb:
	clip_tmp:= clipboard
	sleep,200
	sourcepath:=get_parent_filepath()
	; msgbox,%sourcepath%
	; clipboard:=clip_tmp
	; this_ext:=txt
	InputBox, this_ext, enter extension, %sourcepath%\clipboard text, , , , , , ,, %this_ext%
	if ErrorLevel
	   return
	n := 0
	file=%sourcepath%\clipboard text%n%.%this_ext%
	again:
	ifExist, %file%
	{
		n++
		file=%sourcepath%\clipboard text%n%.%this_ext%
		tooltip,searching %n%
		sleep,10
		goto, again
	}
	tooltip,%file%`n`n%clip_tmp%
	gosub,save_if_not_exist
	gosub,check_trigger_to_open


return

saveas_clipb_save_seltext:

	tooltip,goto folder and press Lctrl`nLshift to use last=%last_location1%,,,2
	sleep,300
	Input, SingleKey, L1,  {esc}{LControl}{LShift}
	if ( ErrorLevel = "EndKey:esc" OR (ErrorLevel = Timeout ))
	{
		tooltip,,,,2
		tooltip
		return
	}
	else if ( ErrorLevel = "EndKey:LShift")
	{

		sourcepath:=last_location1
	}
	else if ( ErrorLevel = "EndKey:LControl")
	{

		sourcepath:= get_parent_filepath()	
	}
	else
	{
		tooltip,,,,2
		tooltip
		return
	}
		tooltip,,,,2
		clip_tmp:= selText
	; keywait,ctrl,D
		; this_ext:=txt
		; InputBox, this_ext, enter extension, extension, , , , , , ,, %this_ext%
		; if ErrorLevel
		   ; return
		n := 0
		file=%sourcepath%\%last_clipb%

		tooltip,%file%`n`n%clip_tmp%
		gosub,save_if_not_exist
		
		gosub,check_trigger_to_open

return
save_if_not_exist:
	IfExist, %File%
	{	msgbox,4,,file exists`n%File%, overwrite?
		IfMsgBox No
		    return
	    else 
	    filedelete,%file%
	}
	fileappend,%clip_tmp%,%File%
	sleep,700
	last_ext2:=last_ext1
	last_ext1:=this_ext
	last_location2:=last_location1
	last_location1:=sourcepath
return

check_trigger_to_open:
	tooltip,%file%`nLshift to open,,,2
	Input, SingleKey, L1 T4,  {esc}{LControl}{RControl}{LShift}
	if ( ErrorLevel = "EndKey:esc")
	{
		tooltip,,,,2
		tooltip
		return
	}
	else if (ErrorLevel = "EndKey:LShift")
	{
		if (notepadpp_installed)
		{
			Run   "C:\Program Files(x86)\Notepad++\notepad++.exe" "%file%"
			winactivate,ahk_class Notepad++
		}
		else if (sublime_installed)
		{
			Run   "C:\Program Files\Sublime Text 3\sublime_text.exe" "%file%"
			winactivate,ahk_class PX_WINDOW_CLASS
		}
		
	}
	sleep,300
	tooltip
	tooltip,,,,2
return

create_open_clipb_last_location:

	clip_tmp:= clipboard
	sourcepath:=last_location1
	n := 0
	this_ext:=last_ext1
	file=%sourcepath%\clipboard text%n%.%this_ext%
	again3:
	ifExist, %file%
	{
		n++
		file=%sourcepath%\clipboard text%n%.%this_ext%
		tooltip,searching %n%
		sleep,10
		goto, again3
	}
	tooltip,%file%`n`n%clip_tmp%
	gosub,save_if_not_exist
	
	gosub,check_trigger_to_open


return

>^F9::	;	sel text save and open as smart
setTimer,removetooltip,1000
tooltip,smart opening
	seltext:=clipboard
	ifinstring,seltext,singleinstance
	{
		script_type=ahk
		sourcepath=C:\cbn_gits\AHK\opus_scripts\temp
	}
	else ifinstring,seltext,import
	{
		script_type=py
		sourcepath=C:\users\%a_username%\Desktop\python_scripts\temp
	}
	else
		return
		
	n := 0
	file=%sourcepath%\clipboard text%n%.%script_type%
	again2:
	ifExist, %file%
	{
		n++
		file=%sourcepath%\clipboard text%n%.%script_type%
		tooltip,searching %n%
		sleep,10
		goto, again2
	}
	tooltip,%file%`n`n%seltext%

	fileappend,seltext=,%file%
	fileappend,%seltext%,%file%
	gosub,check_trigger_to_open


		

	
return


ONCLIPBOARDCHANGE:
	last_clipboard:= this_clipboard
	this_clipboard := clipboard
return

^+[:: ; save clipb here with last_clipboard as filename
	target_Filename := last_clipboard
	Text_to_save := clipboard
	sourcepath :=get_parent_filepath()
	msg =
	target_file := sourcepath . "\" . target_Filename
	ifexist,%target_file%
	{
		msg =%target_file% exists . "`n"
		tooltip,%msg%
		sleep,1200
		target_file := get_next_filename(target_file,10)
		
		if (!target_File)
		{
			settimer,removetooltip,1500
			msg .= error . "`n"
			tooltip,%msg%
			return
		}
	}
		; msgbox,target_file= %target_file%`nFilename= %target_Filename%`Text_to_save= %Text_to_save%
	fileappend,%Text_to_save%,%target_file%
	logger(A_ScriptName,target_file)
	settimer,removetooltip,1000
	msg .= target_file . "saved`n"
	tooltip,%msg%

return
; a.txt

ExitSub:
	IniWrite, %this_ext%, %a_scriptname%.ini, settings, last_ext1
	IniWrite, %last_location1%, %a_scriptname%.ini, settings, last_location1
	exitapp
	return
