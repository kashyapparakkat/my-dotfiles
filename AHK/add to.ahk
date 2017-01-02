ifexist, iMac.ico
	Menu, Tray, Icon,iMac.ico
#Persistent
#SingleInstance Force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


gosub,read_all
gosub,build_menu

return	

BUILD_MENU:

Loop, %total_addto_file%
{
	tmp:=addto_file%a_index%
	menu,addmenu,add,%tmp%,addTo
}
	
menu,addmenu,add,
menu,addmenu,add,add target file,add_target_file
return

WRITE_BACK:
	; re write sorted menu back
	tmp=
	Loop, %total_addto_file%
	{
		t:=addto_file%a_index%
		tmp=%tmp%`n%t%
	}
	tmp:=regexreplace(tmp,"^\n","")
	filedelete,addto.txt
	fileappend,%tmp%,addto.txt
return

add_target_file:
	target_file_changed:=1
	run,addto.txt
return


^+f7::	;	addTo file
^f7::	;	addTo
	GetKeyState, state_s, Shift
	keywait,lshift
	selText:=Get_Selected_Text()
	If state_s = D
	{ 
		InputBox, selText, Name of the clip, Select the name for the clip,,300,100,,,,,%selText%
		; SendMessage, 0xB1, cursorPos, cursorPos,, ahk_id %Ed1%

	}
	if ErrorLevel
			return
	; refresh again to know extenal changes to addto.txt
	if (target_file_changed)
	{
		gosub,read_all
		; menu,addmenu,delete
		gosub,build_menu
	}

	menu,addmenu,show


return

addTo:

	item_no:=A_ThisMenuItempos
	item:=A_ThisMenuItem

	loop,%item_no%
	{
		n:=item_no-a_index+1
		; tooltip,%n%
		n2:=n-1
		addto_file%n%:=addto_file%n2%
	}
	; msgbox,%A_ThisMenuItem%
	addto_file1:=A_ThisMenuItem
	menu,addmenu,delete
	gosub,build_menu
	gosub,WRITE_BACK

	; /*
	FileAppend,
			(
			`n`n===`n%selText%

			),%item%
	if ErrorLevel=0
		tooltip,added to %item%`n`n%text2%
	 sleep,500
	 tooltip
 ; */
return

nil:

return


Get_Selected_Text()  
{
 
   change :=1
   WinGetActiveTitle, OutputVar 
   If OutputVar is space   
   {
      Sterm =
      Goto , End
   }

   ClipSaved := ClipboardAll   ; Save clipboard content for later restore
   sleep , 100      ; Delays required else it can be unreliable
   change :=1
   Clipboard =      ; Flush clipboard   
   Sleep, 100
   change :=1
   SendEvent, ^c   ; Save highlighted text to clipboard.
   sleep , 100
   STerm := Clipboard
   Sleep, 100
   change :=1
   Clipboard := ClipSaved   ; Restore Clipboard content  
   ClipSaved =            ; and free the memory
    
   End:
    
   Return , STerm      ; Search term now stored and ready
}
Return 

READ_ALL:
Loop, read, addTo.txt
	{
	if A_LoopReadLine =
		continue
	addto_file%a_index%=%A_LoopReadLine%
	total_addto_file:=a_index
	}
target_file_changed:=0
; msgbox,
Return 	
	