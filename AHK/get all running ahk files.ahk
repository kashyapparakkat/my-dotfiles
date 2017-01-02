#SingleInstance , Force
ifexist,running.ico
	menu, Tray, Icon, running.ico
get_all()
{
global
	DetectHiddenWindows, On
	WinGet,AHK,LIST,ahk_class AutoHotkey

	Loop % AHK 
	{
		WinGetTitle,Title,% "ahk_id " AHK%A_Index%
		output.=(output ? "`n" : "") RegExReplace(Title,"\s-\sAutoHotkey\s.*")
		
	}
	sort,output
}

<^+!esc:: ; get all running ahk files
get_all()


	menu, main, add,
	menu, main, DeleteAll

	loop,parse,output,`n
	{	 
		path%a_index% :=a_loopfield 
		menu, main, add,%a_loopfield%, close 
	}
	menu, main, add,close all,close_all
	menu, main, add,copy all,copy_all
	menu,main,show

return

close:
DetectHiddenWindows, On
	ItemPos:= A_ThisMenuItemPos 
	path :=path%ItemPos%
	if path!=%A_ScriptFullPath%
	{
		WinClose,%Path% ahk_class AutoHotkey
		tooltip,killed  %Path%
		sleep,1500
		tooltip
	}
return

close_all:
	loop,parse,output,`n
	{
		 path :=a_loopfield 
		 if path!=%A_ScriptFullPath%
			WinClose,%Path% ahk_class AutoHotkey
	}
return

copy_all:
Loop,Parse,output,`n

	Loop % A_LoopField
		out.=(out ? "`n" : "") A_LoopFileName "`t(" A_LoopFileSize " byte)"
; enable to print memory bytes
; MsgBox % out

clipboard:=output
tooltip,filelist copied to clipboard
sleep,500
tooltip,%clipboard%
sleep,1000
tooltip
return

nil:
return
