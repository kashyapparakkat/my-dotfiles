#SingleInstance Force
#include C:\cbn_gits\AHK\LIB\misc functions.ahk
#include C:\cbn_gits\AHK\LIB\cbn.ahk
#include C:\cbn_gits\AHK\LIB\contextmenu.ahk
#include C:\cbn_gits\AHK\LIB\HK_Cycle dev2.ahk

Menu, Tray, Icon, Shell32.dll, 31



suspend_if_VMwareHorizonClient()
fileread,cmd_list,cmd_list.txt
last_cmd := RegExReplace(cmd_list, "^([^|]+)\|.*", "$1" )
if (cmd_list="")
	cmd_list=cmd|%comspec% /k ipconfig /all,C:\cbn|
run_command_all :=cmd_list
Gui 1: +LastFound +AlwaysOnTop -Caption +ToolWindow
gui,1: font, s12
Gui,1:Add, ComboBox, w700 vrun_command, %cmd_list%
gui,1: add,button,x+0  h25 gRun ,run



config =
(
last,cmd gui,clipboard in gui
show_cmd,
,
run_last_cmd,show_cmd_gui,show_cmd_gui
,
)

; cmd gui
HKC_Group_register("<#5", "run_cmdGui_HK",3000,"Lwin", "$#q")
HKC_Key_register("<#5","run_cmdGui_HK",config,"aux","sticky","show_all_options")

; Runs cmd from history
config =
(
last2,last3,last4
show_cmd_list,show_cmd_list,show_cmd_list
,
run_last_cmd_list,run_last_cmd_list,run_last_cmd_list
2,3,4,5
)

HKC_Key_register("<#6","run_cmdGui_HK",config,"aux")

Return


show_cmd_gui: ; run command (mix with smart search or make standalone)
	run_command = 
	gui,1: submit,nohide	
	gui,1: show,,run_cmd
return
; #h::run, %comspec% /k ipconfig /all,C:\cbn

show_cmd_list:
	HKC_custom_disp_msg=last%HKC_keyId_count%
return
show_cmd:
	HKC_custom_disp_msg=%last_cmd%
return
run_last_cmd_list:
msgbox,last%HKC_keyId_count%
Return

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
	run,cmd,%sourcepath%
return

update_cmd_list:
	filedelete,%a_scriptdir%\cmd_list.txt
	fileappend, %run_command_all%,%a_scriptdir%\cmd_list.txt
	Return