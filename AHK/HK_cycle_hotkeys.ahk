; http://www.cibinmathew.com
; github.com/cibinmathew

#SingleInstance Force
#include C:\cbn_gits\AHK\LIB\misc functions.ahk
#include C:\cbn_gits\AHK\LIB\HK_cycle.ahk
#include C:\cbn_gits\AHK\LIB\cbn.ahk
#include C:\cbn_gits\AHK\LIB\contextmenu.ahk
Menu, Tray, Icon, Shell32.dll, 36



; settimer, test,500

iniread,emacs_f_path,running_all_settings.ini,paths,emacs


fileread,folder_list,fav_folder_list.txt
sorted_folder_list :=folder_list

config =
(
copy file as base64,paste here from base64
,
,
FileFullpathname:=get_selected_filepath(),
,
copy_file_as_base64(FileFullpathname),
,paste_base64_asFile
,
)
HK_cycle_register("<#=","Copy_Paste_base64_HK",2,3000,"Lwin", "$#q",config)


config =
(
mon 1+2, mon 2, mon 1,left of 1+2
,,,
,,,
,,,
,,,
"MoveWindow(""0"",""32"",2880,875)","MoveWindow(""1610"",""0"",""1280"",1024)",,"MoveWindow(""0"",""38"",800,1000)",
MoveWindow2,,,
,,,
)
; HK_cycle_register("<#3","multi_monitor_HK",4,3000,"Lwin", "$#q",config)

config =
(
copy full pathnames from current window,parent,names only,open_in_fileManager,copy names only without ext
,,,,
,,,,
,,,,
,,,,
clipboard:=get_current_filepath_from_active_window(),clipboard:=get_parent_filepath(),,,clipboard:=get_parent_filepath()
,,extract_basenames,open_in_fileManager,extract_basenames_noext
,,,
)

HK_cycle_register("<#1","Copy_Path_HK",5,3000,"Lwin", "$#q",config)

config =
(
open in emacs,npp,explorer,dired,pycharm
,,,,
,,,,
,,,,
,,,,
,,,,
get_and_open_in_emacs,get_and_open_in_npp,,,get_and_open_in_pycharm
,,,
)
HK_cycle_register("<#2","Copy_Path_Open_HK",5,3000,"Lwin", "$#q",config)

config =
(
open file1 in emacs,file2,file3
,,,,
,,,,
,,,,
,,,,
,,,,
open_file1_in_emacs,open_file2_in_emacs,open_file1_in_emacs
,,,
)
HK_cycle_register("<^+F11","Emacs_Path_HK",3,3000,"LCtrl", "$#q",config)

config =
(
AOT esc,AOT hold,AOT OFF
,,,,
,,,,
,,,,
,,,,
,,,,
nil,nil,nil,nil,nil
,,,,
)
; HK_cycle_register(">^+t","AOT_tooltip_HK",3,4000,"RCtrl", "$^q",config)


config =
(
power save,power save OFF,bright
,,,,
,,,,
,,,,
,,,,
,,,,
power_save_options,power_save_options
,,,,
)
; HK_cycle_register("<^F12","power_save_HK",3,4000,"LCtrl", "$^q",config)


config =
(
SLEEP,HIBERNATE
,,,,
,,,,
,,,,
,,,,
,,,,
sleep_computer,hibernate_computer,nil,nil
,
)
HK_cycle_register("<^F1","power_options_HK",2,4000,"LCtrl", "$^q",config)


config =
(
sel text in N++,open in quick note
,,,,
,,,,
,,,,
,,,,
,,,,
sel_in_Npp,sel_in_Notepad,nil,nil
,
)
HK_cycle_register("<^F8","open_sel_text_HK",2,4000,"LCtrl", "$^q",config)


config =
(
google search,python search,map search,multi search
,,,,
,,,,
,,,,
,,,,
,,,,
search_google,search_google_python,google_map_search,,multi_search,nil,nil
,
)
HK_cycle_register(">^g","google_search_HK",4,4000,"RCtrl", "$^q",config)


config =
(
ranger,explorer,Dired
,,,,
,,,,
,,,,
,,,,
,"menuEvent_function(""OpenIfFolder_SelectIfFile"",""C:\users\%a_username%\desktop"")","run_emacs_dired(""C:\users\%a_username%\Downloads"")","menuEvent_function(""OpenIfFolder_SelectIfFile"",""C:\users\%a_username%\Downloads"")","menuEvent_function(""OpenIfFolder_SelectIfFile"",""C:\users\%a_username%"")"
open_mycomputer,nil,nil,nil,nil
,,,
)
HK_cycle_register("<#t","open_fav_folders4_HK",3,4000,"Lwin", "$#q",config)

config =
(
My computer,desktop,Downloads in Dired,Downloads,Home directory
,,,,
,,,,
,,,,
,,,,
,"menuEvent_function(""OpenIfFolder_SelectIfFile"",""C:\users\%a_username%\desktop"")","run_emacs_dired(""C:\users\%a_username%\Downloads"")","menuEvent_function(""OpenIfFolder_SelectIfFile"",""C:\users\%a_username%\Downloads"")","menuEvent_function(""OpenIfFolder_SelectIfFile"",""C:\users\%a_username%"")"
open_mycomputer,nil,nil,nil,nil
,,,
)
HK_cycle_register("<#e","open_fav_folders3_HK",4,4000,"Lwin", "$#q",config)


config =
(
download youtube url,download clipb url in IDM,
,,,,
,,,,
,,,,
,,,,
,,,,
nil,nil,nil,nil
,,,,
)
HK_cycle_register("<^f6","download_HK",2,4000,"LCtrl", "$^q",config)

iniread,fav_file1,running_all_settings.ini,paths,fav_file1
iniread,fav_file2,running_all_settings.ini,paths,fav_file2
iniread,fav_file3,running_all_settings.ini,paths,fav_file2
iniread,fav_file4,running_all_settings.ini,paths,fav_file2

config =
(
%fav_file1%,%fav_file2%,%fav_file3%,%fav_file4%
,,,,
,,,,
,,,,
,,,,
"menuEvent_function(""N++"",""%fav_file1%"")","menuEvent_function(""N++"",""%fav_file2%"")","menuEvent_function(""N++"",""%fav_file3%"")","menuEvent_function(""N++"",""%fav_file4%"")",
nil,nil,nil,nil
,
)
HK_cycle_register("<#4","open_fav_files_HK",4,4000,"Lwin", "$#q",config)

config =
(
f1,f2,f3,add clipb path to list and open
get_fav_folder_list,get_fav_folder_list,get_fav_folder_list
,
,
open_folder,open_folder,open_folder,add_to_list_open_folder
,,,,
,,,,
,,,,
)
HK_cycle_register("<#7","tmp_fav_folders_HK",4,4000,"Lwin", "$#q",config) 


iniread,fav_folders1,running_all_settings.ini,paths,fav_folders1
iniread,fav_folders2,running_all_settings.ini,paths,fav_folders2
iniread,fav_folders3,running_all_settings.ini,paths,fav_folders3
config =
(
%fav_folders1%,%fav_folders2%,%fav_folders3%,
,,,,
,,,,
,,,,
,,,,
"menuEvent_function(""OpenIfFolder_SelectIfFile"",""%fav_folders1%"")","menuEvent_function(""OpenIfFolder_SelectIfFile"",""%fav_folders2%"")","menuEvent_function(""OpenIfFolder_SelectIfFile"",""%fav_folders3%"")"
nil,nil,nil,nil
,
)
; msgbox,%config%

HK_cycle_register("<#8","open_fav_folders2_HK",3,4000,"Lwin", "$#q",config) 

; runs cmd console
config =
(
bash here,emacs here,cmd here,on sel path
,
,
sourcepath:=get_current_sourcepath_from_active_window(),sourcepath:=get_parent_filepath(),sourcepath:=get_parent_filepath(),
,
"run_bash_prompt(sourcepath)","run_emacs_shell(sourcepath)","run_cmd_prompt(sourcepath)",
,
,
)
HK_cycle_register("<#3","run_cmd_HK",4,4000,"Lwin", "$#q",config)


config =
(
convert_path_to_windows(),convert_path_to_linux(),double_slash_linux,double_slash_windows
,,,,
,,,,
,,,,
,,,,
convert_path_to_windows(),convert_path_to_linux(),double_slash_linux(),double_slash_windows()
,,,
)

HK_cycle_register("<^!F6","Convert_paths",4,3000,"LCtrl", "$^q",config)


convert_path_to_windows(){
stringreplace,clipboard,clipboard,/,\,all
}
convert_path_to_linux(){
stringreplace,clipboard,clipboard,\,/,all
}

double_slash_windows(){
stringreplace,clipboard,clipboard,/,\,all
stringreplace,clipboard,clipboard,\\,\,all
stringreplace,clipboard,clipboard,\,\\,all
}

double_slash_linux(){
stringreplace,clipboard,clipboard,\,/,all
stringreplace,clipboard,clipboard,//,/,all
stringreplace,clipboard,clipboard,/,//,all
}

 ; C:\cbn_gits\AHK\HK_cycle_hotkeys.ahkC:\cbn_gits\AHK\HK_cycle_hotkeys.ahk
return

test:
tooltip,HK_cycle_id=%HK_cycle_id%`nCopy_Path_HK=%Copy_Path_HK%  HK_cycle_id_action=%HK_cycle_id_action% HK_cycle_id_count=%HK_cycle_id_count%`ncopy_paste_base64_HK=%copy_paste_base64_HK%  HK_cycle_id_action=%HK_cycle_id_action% HK_cycle_id_count=%HK_cycle_id_count%,800,700,8
return


; $^k::
	; HK_cycle_abort_onCancel_key(a_thishotkey)
; Return

/*

^i::
	HK_cycle_id = OpenFavFolder_HK
	if (!%HK_cycle_id%)
	{
		HK_msgs =C:\cbn,C:\cbn_gits\AHK\LIB
		HK_actions_onRelease=open_folder,open_folder
		HK_actions_before_msg= ; empty if not reqd. it modifies the global variable 'HK_custom_disp_msg' for truncated message preview and 'HK_cycled_output'
		extra_params= ,,,
		input_param= ; like selected text or sourcepath or clipb
		HK_cycle_tot_steps= 2 ; excluding cancel
		release_checking_key :="ctrl"
		idle_stop_after = 7000
		%HK_cycle_id%_release_Pre_action=path
		HK_cycle_id_count = %HK_cycle_id%_count
		HK_cycle_before_cycling()
	}
	HK_cycle_next( %HK_cycle_id%, %HK_cycle_id_count%, HK_cycle_tot_steps, HK_msgs, HK_actions_onRelease, extra_params, input_param, HK_cycle_id_action, idle_stop_after, HK_actions_before_msg)
	; keywait,i
return

path:
	; msgbox,%HK_cycle_id_count%
	c:= %HK_cycle_id_count%
	FileFullpath := HK_msgs%c%
return

copy:
	; clipboard := HK_cycled_output
	enterToSend_EscToCancel_ElseCopy(HK_cycled_output)
return

*/

open_folder(FileFullpath)
{
global
	msgbox,opening =%FileFullpath%=
	menuEvent_function("OpenIfFolder_SelectIfFile", FileFullpath)
}
return


/*
		HK_msgs =copy as base64,paste here from clipb
		HK_actions_onRelease=copy_file_as_base64,paste_base64_asFile
		HK_actions_before_msg= ;
		extra_params= ,,,
		input_param= 
		HK_cycle_tot_steps= 2  
		release_checking_key ="Lwin"
		idle_stop_after = 7000
		%HK_cycle_id%_release_Pre_action=
*/		



copy_file_as_base64: ; copy as base64
	FileFullpathname := get_selected_filepath()
	copy_file_as_base64(FileFullpathname)
Return     
          
paste_base64_asFile:	; paste base64 data here

	sourcepath := get_parent_filepath()	
	paste_base64_asFile(sourcepath)
Return

copy_file_as_base64(FileFullpathname)
{
	FileGetSize, Size, %FileFullpathname%
	FileRead, Bin, *c %FileFullpathname%
	Base64enc( PNGDATA, Bin, Size )
	; 1234567890 is a token to communicate
	Clipboard := "1234567890" . FileFullpathname . "`n" . PNGDATA
	len := strlen(clipboard)
	stringleft,a,clipboard,400
	settimer,removetooltip,1500
	tooltip,length=%len%`n%a%
}
	
	
paste_base64_asFile(sourcepath)
	{
		; clipboard content first line is fullpathname of copied file
		FullDATA:=clipboard
		DATA =
		loop,parse,FullDATA,`n,`r
		{
			if a_index =1
				File := a_loopfield
			else
				DATA .= a_loopfield			
		}
		if ( Substr(File,1,10) != "1234567890" )
		{
			settimer,removetooltip,1500
			tooltip, not filedata
			return
		}
		stringtrimleft,File,File,10
		splitpath,File,Filename
		target_file := sourcepath . "\" . Filename
		target_file := get_next_filename(target_file,10)
		if (!target_File)
		{
			settimer,removetooltip,1500
			tooltip,error
			return
		}	
		Bytes := Base64Dec( BIN, DATA )
		VarZ_Save( BIN, Bytes, target_file )
		VarSetcapacity( DATA, 0 )
		settimer,removetooltip,1500
		tooltip,%target_file%
	}
MoveWindow2:

	WinMove,A,,0,38,A_Screenwidth-18, A_ScreenHeight-38
return
	MoveWindow(x,y,width, height)
{
	WinMove, A, , x, y, width, height
	ToolTip, %width%x%height%
	Sleep, 500
	ToolTip,
	Return
}

; WinMove,A,,0,38,2880, 862
extract_basenames:
all:=get_current_filepath_from_active_window()
	; all := get_selected_filepath()
	output:= regexreplace(all,"im)^(.*?)[\\/]([^\\/]*)$","$2")
	clipboard := output
return

extract_basenames_noext:
	all := get_current_filepath_from_active_window()
	; all := get_selected_filepath()

	output:= regexreplace(all,"im)(*ANYCRLF)^(.*)[\\/]([^\\/]*?)\.?([^\.]*)$","$2")
	clipboard := output
return

get_fav_folder_list:

	msgbox,a%sorted_folder_list%
	stringsplit,sorted_folder_list, sorted_folder_list,`n,`r
	FileFullpathname := sorted_folder_list%HK_cycle_id_count%
	msgbox,c%sorted_folder_list1%
	; tooltip,%HK_cycle_id_count% %FileFullpathname%
	; sleep,500
	HK_custom_disp_msg := FileFullpathname
return

open_folder:
	msgbox,q%FileFullpathname%
	FileFullpathname:= 
	menuEvent_function("OpenIfFolder_SelectIfFile",FileFullpathname)
return

add_to_list_open_folder:
	Filedelete,C:\cbn_gits\AHK\fav_folder_list.txt
	sorted_folder_list:= clipboard . "`n"
	loop,3
	{
		sorted_folder_list .= sorted_folder_list%a_index% . "`n"
	}
	Fileappend,%sorted_folder_list%,C:\cbn_gits\AHK\fav_folder_list.txt
return

open_mycomputer:
	Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d}
return

google_map_search: 
	SearchTerms:=Get_Selected_Text()
	if ( SearchTerms !="" )
		Run,http://maps.google.com/?q=%SearchTerms%

return

search_google: ; google SEARCH
	SearchTerms:=Get_Selected_Text()
	if ( SearchTerms !="" )
		Run, http://www.google.com/search?q=%SearchTerms%

return

search_google_python: ; google SEARCH
	SearchTerms:=Get_Selected_Text()
	if ( SearchTerms !="" )
		Run, http://www.google.com/search?q=python`%20%SearchTerms%

return

sel_in_Notepad:
	file=%A_ScriptDir%\tmp_sel-text-45.txt
	ifexist,%file%
		filedelete,%file%
	fileappend,%selText%,%file%
	run ,notepad.exe "%file%"
return


sel_in_Npp:
	file=%A_ScriptDir%\tmp_sel-text-45.txt
	if selText <>
	{
		ifexist,%file%
		{
			filedelete,%file%
			sleep,50
		}
		fileappend,%selText%,%file%
		sleep,50
	}
	else
	{
		tooltip,opening previous	
	}
	menuEvent_function("N++",file)
	sleep,600
	tooltip
return


sleep_computer:
	alertcmd=%A_Script_Drive%\cbn\ahk\batterydeley\source\audio\beep2.wav
	Progress, b    w280  fs24 zh0 CT222222 CW00FF00, SLEEP........, , , Calibri

	SoundPlay,%alertcmd%
	Sleep, 400
	Progress, off

	Sleep, 200
	Progress, b    w280  fs24 zh0 CT222222 CW00FF00, SLEEP........, , , Calibri
	Sleep, 400
	Progress, off

	Sleep, 200
	; SoundPlay,%alertcmd%
	Progress, b  w280  fs24 zh0 CT222222 CW00FF00, SLEEP........, , , Calibri
	Sleep, 200
	DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0) ; DLL call to sleep
	sleep, 400
	Progress, off

return

hibernate_computer:

	alertcmd=%A_ScriptDir%\audio\2beep1.wav
	Progress, b    w380 h250  fs24 zh0 CTFFFFFF CWFF0000, HIBERNATING........, , , Calibri

	SoundPlay,%alertcmd%
	Sleep, 600
	Progress, off

	Sleep, 200
	Progress, b w380 h250 fs24 zh0 CTFFFFFF CWFF0000, HIBERNATING........, , , Calibri
	Sleep, 400
	Progress, off

	Sleep, 200
	; SoundPlay,%alertcmd%
	Progress, b  w380 h250 fs24 zh0 CTFFFFFF CWFF0000, HIBERNATING........, , , Calibri
	Sleep, 200
	DllCall("PowrProf\SetSuspendState", "int", 1, "int", 1, "int", 1)
	sleep, 400
	Progress, off

return



multi_search:
	tooltip, launching multi search
	settimer,removetooltip,-500
	SearchTerms:=Get_Selected_Text()
	Run, http://www.google.com/search?q=%SearchTerms%
	Run, http://www.google.com/search?q=%SearchTerms%&tbm=isch
	; Run, http://en.wikipedia.org/wiki/%SearchTerms%
	; Run, http://en.wikipedia.org/wiki/Special:Search/%SearchTerms%
	Run, http://www.bing.com/search?q=%SearchTerms%

return


power_save_options:
	power_save:=!power_save
	; battery low mode
	;brightness 
	
		If ( power_save ) 
			{
				br := 45 
				msg=power save mode
			}		  
		else
		   {
		   br := 90  
		   msg=power save mode OFF
		   }
		   
			VarSetCapacity(gr, 512*3) 
			Loop, 256 
			{ 
			   If  (nValue:=(br+128)*(A_Index-1))>65535 
					nValue:=65535 
			   NumPut(nValue, gr,      2*(A_Index-1), "Ushort") 
			   NumPut(nValue, gr,  512+2*(A_Index-1), "Ushort") 
			   NumPut(nValue, gr, 1024+2*(A_Index-1), "Ushort") 
			} 
			hDC := DllCall("GetDC", "Uint", 0) ;NULL for entire screen 
			DllCall("SetDeviceGammaRamp", "Uint", hDC, "Uint", &gr) 
			DllCall("ReleaseDC", "Uint", 0, "Uint", hDC) 
			
			tooltip,%msg%
			settimer,removetooltip,-400	
return

open_in_fileManager:
	file_path:=get_current_filepath_from_active_window()
	; RegExMatch(file_path, "\*?\K(.*)\\[^\\]+(?= [-*] )", file_path)
	
	if FileExist(file_path)
		Run explorer.exe /select`,"%file_path%"
	

return

open_file1_in_emacs:
	iniread,emacs_default_startup_file,running_all_settings.ini,paths,emacs_default_startup_file
	file:=emacs_default_startup_file
gosub,open_in_emacs
return

open_file2_in_emacs:
	iniread,emacs_default_startup_file,running_all_settings.ini,paths,emacs_default_startup_file2
	file:=emacs_default_startup_file
gosub,open_in_emacs
return

open_in_emacs:
	tooltip, "%emacs_f_path%" "%file%" -n -a ""

	settimer,removetooltip,800
	gosub,open_with_emacs
return

get_and_open_in_npp:
	file:=get_current_filepath_from_active_window()
	menuEvent_function("N++",file)
return

get_and_open_in_pycharm:
	file:=get_current_filepath_from_active_window()
	run, "%emacs_f_path%" "%file%" -n
return

get_and_open_in_emacs:
	file:=get_current_filepath_from_active_window()
	gosub,open_with_emacs
return

open_with_emacs:
	run, "%emacs_f_path%" "%file%" -n -a "",,Hide
	; The *-a ""* tells emacs to run itself as a server (daemon) if it isn't already running.

return
nil:
return

; help tips

; !/::
^+/::
; ^/::
#/::
	stringtrimright,key,a_thishotkey,1
	stringreplace,key,key,^+,ctrlshift
	stringreplace,key,key,^,ctrl
	stringreplace,key,key,#,win
	win_tip=#1 copy #2 open in #3 open shells #4 notes #7 folders #8 folderes #= base 64
	ctrl_tip=ctrlll
	ctrlshift_tip=ctrlll shift
	alt_tip=alltt
	tip:=%key%_tip
	settimer,removetooltip,2500
	tooltip,%tip% 
return