#SingleInstance Force
#include C:\cbn_gits\AHK\LIB\misc functions.ahk
	menu, Tray, Icon, Shell32.dll, 39
Copy_Path_cycle_active:=0
return


; <#9::	; copy folder paths
	; settimer,cancelCopy_Path_cycle,off	
	if !(Copy_Path_cycle_active)	;	if hotkey is currently not in cycle mode 
	{
		Copy_Path_cycle_count:=0
	}
	settimer,cancelCopy_Path_cycle,-1500	
	Copy_Path_cycle_count++
	settimer,removetooltip,-1600

	if (Copy_Path_cycle_count=1)
	{	
		msg=parent
		Copy_Path_cycle_action = nil	
	}
	else if (Copy_Path_cycle_count=2)
	{	
		msg=full pathnames
		Copy_Path_cycle_action = nil	
	}
	else if (Copy_Path_cycle_count=3)
	{	
		msg=names only
		Copy_Path_cycle_action = nil	
	}
	else if (Copy_Path_cycle_count=4)
	{	
		msg=names only without ext
		Copy_Path_cycle_action = nil	
	}
	else
	{
		Copy_Path_cycle_count:=0
		msg=cancel
		settimer,cancelCopy_Path_cycle,-1500		
	}
	tooltip,%Copy_Path_cycle_count% %msg%
	
	Copy_Path_cycle_active:=1
	hotkey, ^q, on
	setTimer, Copy_Path_cycle, 70
	sleep,10

; NetApp NB Windows 7 VED C02P02
; ahk_class #32770
; ahk_exe vmware-view.exe

Copy_Path_cycle:	;	cancel checking status of ctrl key
	GetKeyState,state,LWin
	If state=u
	{
		gosub,cancelCopy_Path_cycle
		settimer,removetooltip,-1500
		if (Copy_Path_cycle_count=1)
		{
			clipboard:=get_parent_filepath()			
		}
		else if (Copy_Path_cycle_count=2)
		{
			clipboard:=get_selected_filepath()			
		}
		else if (Copy_Path_cycle_count=3)
		{
			gosub,extract_basenames
			clipboard:=output
		}
		else if (Copy_Path_cycle_count=4)
		{
			gosub,extract_basenames_noext
			clipboard:=output
		}
		else
		{
			tooltip,cancelled
		}

	}
return

cancelCopy_Path_cycle:	;	cancel without action
	setTimer,Copy_Path_cycle,off
	Copy_Path_cycle_active:=0
	; tooltip,cancelling
	settimer,removetooltip,-300
	hotkey,^q,off
	
return

removetooltip:
	settimer ,removetooltip,off
	tooltip
return

$^q::	; na
	send ^q
Return

extract_basenames:
	all := get_selected_filepath()
	output:= regexreplace(all,"im)(*ANYCRLF)^(.*)\\([^\\]*)$","$2")
return

extract_basenames_noext:

	all := get_selected_filepath()
	; all :=clipboard
	output:= regexreplace(all,"im)(*ANYCRLF)^(.*)\\([^\\]*?)\.?([^\.]*)$","$2")
	; msgbox,%output%
return