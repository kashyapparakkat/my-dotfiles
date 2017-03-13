#SingleInstance Force
#include C:\cbn_gits\AHK\LIB\misc functions.ahk
#include C:\cbn_gits\AHK\LIB\cbn.ahk
#include C:\cbn_gits\AHK\LIB\HK_cycle.ahk
#include C:\cbn_gits\AHK\LIB\contextmenu.ahk
Menu, Tray, Icon, Shell32.dll, 34
onexit,onexit

; hotkey,^q,off	;	start disabled

folder_list = C:\users\%a_username%\configadvisordata`nC:\users\%a_username%\ca_cabling`nC:\users\%a_username%\ca_cabling\corduroy\visualizer`nC:\users\%a_username%\configadvisordata\recent_results
sorted_folder_list := folder_list
stringsplit, sorted_folder_list, sorted_folder_list,`n,`r


fileread,cmd_list,cmd_list.txt
last_cmd := RegExReplace(cmd_list, "^([^|]+)\|.*", "$1" )
if (cmd_list="")
	cmd_list=cmd|%comspec% /k ipconfig /all,C:\cbn|
run_command_all :=cmd_list
Gui 1: +LastFound +AlwaysOnTop -Caption +ToolWindow
gui,1: font,s12
Gui,1:Add, ComboBox, w700 vrun_command, %cmd_list%
gui,1: add,button,x+0  h25 gRun ,run
suspend_if_VMwareHorizonClient()
; msgbox,aa
; run_

config =
(
"Thanks{enter}Cibin","Regards{enter}Cibin","Thanks{enter}Cibin Mathew",
,
,
,
send_signature,send_signature,send_signature
,
,,
,
)

HK_cycle_register("<^!c","auto_text_HK",4,4000,"LCtrl", "$^q",config) 


config =
(
here,on sel path,last location,clipb,run sel file in cmd
,
,
sourcepath:=get_parent_filepath(),
,
run_cmd_prompt(sourcepath),,,run_cmd_prompt(clipboard),
,run_cmd_prompt,
,
)

HK_cycle_register("<#6","run_cmd_HK",5,4000,"Lwin", "$#q",config) 


config =
(
last,cmd gui,clipboard in gui
,
show_cmd,
,
run_last_cmd,show_cmd_gui,show_cmd_gui
,
,
,
)

HK_cycle_register("<#5","run_cmdGui_HK",3,4000,"Lwin", "$#q",config) 


return


show_cmd_gui: ; run command (mix with smart search or make standalone)
	run_command = 
	gui,1: submit,nohide	
	gui,1: show,,run_cmd
return
; #h::run, %comspec% /k ipconfig /all,C:\cbn
show_cmd:
	HK_custom_disp_msg=last`n%last_cmd%
; msgbox,%HKC_custom_disp_msg%
return

run_last_cmd:
	run_cmd(last_cmd)
return

#ifwinactive, run_cmd
esc::
	gui, 1: hide
return

enter::
#ifwinactive
Run:
	gui,1: submit
	run_command2:=regexreplace(run_command,"^\s*run\s*")
	run_command_all := add_if_not_existing(run_command_all,run_command,"|")
	guicontrol,1:,run_command,|%run_command_all%
	run_cmd(run_command)
	gosub, update_cmd_list
return

run_cmd(run_command)
{
	global last_cmd
	loop,parse,run_command,`,
	{
		param%a_index% := a_loopfield
		tot_params := a_index
	}
	run,%param1%,%param2%,%param3%
	last_cmd := run_command
return
}

run_cmd_prompt: ; run_cmd_prompt
	sourcepath:=get_parent_filepath()
	run_cmd_prompt(sourcepath)
return

update_cmd_list:
	filedelete,%a_scriptdir%\cmd_list.txt
	fileappend, %run_command_all%,%a_scriptdir%\cmd_list.txt
	Return

#IfWinNotActive, ahk_exe eclipse.exe
>^+F9:: ; pip
#IfWinNotActive
; C:\Werkzeug-0.9\setup.py
; C:\Werkzeug-0.9.egg
; pip install requests
; pip install "abc.whl"
; abc.whl
; requests

line := Clipboard
line := RegExReplace(line, "^\s*(.*)\s*$", "$1")
line := RegExReplace(line, "^""(.*)""$", "$1")
if RegExMatch(line, ".*\\setup\.py")
{
	SplitPath, line, , OutDir, 
	cmd=|C:\WINDOWS\system32\cmd.exe /k python setup.py install ,%Outdir%|||%run_command_all% 
}
else if RegExMatch(line, "^.*\\[\w-\.]+\.egg$")
{
	; msgbox
	SplitPath, line, , OutDir, OutFilename 
	; line := RegExReplace(line, "^easy_install install (.*)\s*$", "$1")
	cmd=|C:\WINDOWS\system32\cmd.exe /k easy_install  "%OutFilename%",%Outdir%|||%run_command_all%
}
else
{
	line := RegExReplace(line, "^pip install (.*)\s*$", "$1")
	cmd=|C:\WINDOWS\system32\cmd.exe /k pip install %line%,C:\python27\scripts|||%run_command_all%
}
tooltip, pip install "%line%"
SetTimer,removetooltip, 1500
guicontrol,1: ,run_command,|
guicontrol,1:,run_command,%cmd%


return


send_signature:
	; clipboard:=msg
	; sleep,30
	; send, ^v

	sendinput %msg%
return

removetooltip:
	settimer ,removetooltip,off
	tooltip
return

; Resize current window to standard sizes
; -----------------------------------------------------------------------------
MoveWindow(x,y,width, height)
{
	WinMove, A, , x, y, width, height

	ToolTip, %width%x%height%
	Sleep, 500
	ToolTip,
	Return
}
; that's not "standard", just my whole screen

; <#1::	; na
	suspend
	; WinMaximize, A
	WinMove,A,,0,38,A_ScreenHeight,A_Screenwidth-18
	return
	
<#2:: 
	; cycle through recently used file
	return
	
<#3::	; na
suspend
	; MoveWindow(2870, 900)
	WinMove,A,,0,38,2880, 862
	return
		

; Reduce mouse sensitivity temporarily, http://www.autohotkey.com/community/viewtopic.php?t=14795
; -----------------------------------------------------------------------------
; ^RShift::DllCall("SystemParametersInfo", Int,113, Int,0, UInt,1, Int,2)
; ^RShift Up::DllCall("SystemParametersInfo", Int,113, Int,0, UInt,10, Int,2)





nil:
	return

onexit:
exitapp


^+i::	; delete all recent acitivities
filedelete,%appdata%\microsoft\windows\recent\automaticdestinations\*
Return
