#Persistent
#SingleInstance Force
#include C:\cbn_gits\AHK\LIB\cbn.ahk
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
FileEncoding,UTF-8
#MaxMem 200

; Menu, Tray, Icon,Yellow.ico

SetBatchLines -1

appname=Fast_SEARCH
#include C:\cbn_gits\AHK\LIB\cbn.ahk

setupMenu("context1")
#include C:\cbn_gits\AHK\LIB\contextmenu.ahk
name=simple search 


Gui, 1:  +AlwaysOnTop  +border +LastFound 	 +toolwindow   -caption 	;	+resize 
Gui, 1: add,Edit,x0  y0 vvisibleSchStr r1 h39 w150 hWndEd1  +0x100,search	; -WantReturn
Gui, 1: add,Button,x+0  w40 gopen2 ,n++
Gui, 1: add,Button,x+0  w40 gopen3 ,open F
Gui, 1: add,Button,x+0  w40 gadd_entry ,add
Gui, Add, ListView, x0 y+0 w300 r10 h200 vResultList  c008000 gListEvent  hwndhList      AltSubmit,Name


;====================
; LVM_GETHEADER
DetectHiddenWindows, on
Gui, +lastfound
Process, Exist
WinGet, hw_gui, ID, ahk_class AutoHotkeyGUI ahk_pid %ErrorLevel%

;====================



fileread,files,C:\cbn_gits\AHK\search_paths\foldercontent.txt
return

tIncrementalSearch:


	Gui, Submit, NoHide
	CurFilename = %visibleSchStr%
	If NewKeyPhrase <> %CurFilename%	
	{	
		SetTimer,search,-1
		NewKeyPhrase = %CurFilename%
		;Sleep, 100 ; DON'T HOG THE CPU!
	}
	Else
	{
		; QUERY STRING HAS STOPPED CHANGING
		;Break
	}
Return

search:

	Gui, Submit, NoHide
	SchStr:=visibleSchStr

	StopSearch=0

	search_in_progress := 1
	if (SchStr = "")							;if empty query
	{
		; msgbox,empty
		GuiControl, Show, ResultList
		LV_Delete()
		Goto,StopSearch
	
	return
	}
	GuiControl, Show, ResultList
	LV_Delete()
	FilesMatch=0
	SchStr=i)%SchStr%
	matchlist=
	Loop, Parse, files,`n`r
		{
		SplitPath, A_LoopField, OutFileName
		if RegExMatch(OutFileName,SchStr)
			{
			matchlist=%matchlist%`n%A_LoopField%
			}
		}	
	
StopSearch: 
	Oldschstr:=schstr
	matchlist:=regexreplace(matchlist,"m)^\n","")	

	Loop, Parse, matchlist,`n`r
	{
		LV_Add("",A_LoopField)
	}
 
	LV_ModifyCol() 
	LV_ModifyCol(1,"AutoHdr")

	GuiControl, Show, ResultList

items:=LV_GetCount()
	gosub,listview_height	
	; GuiControl,, ResultList,r8
	LV_Modify(1, "Select")

return

ListEvent:
        ;---------------------------------------------------------------------------
        ; Retrieve file name for selected row
        ;---------------------------------------------------------------------------
	LV_GetText(SelectedFile, LV_GetNext(0))
	
	if (A_GuiEvent = "DoubleClick")
	{
				tooltip,DoubleClick
		settimer,removetooltip,-300
		menuEvent_function("open",SelectedFile)
	}
	if (A_GuiEvent = "normal")
	{
		; GuiControl, focus, ResultList
		; Coordmode, Mouse, Screen 
		; MouseGetPos,nx,ny
		; Coordmode, Mouse, relative		
		; x:=nx+10
		; y:=ny+8
		; gui,3:show,x%x%  y%y%   ;noactivate
		; gosub,checkselected
		; settimer,gui3off,300
		; hold=1
		 
	}
	else If (A_GuiEvent = "K")
	{
	
		tooltip,k
		settimer,removetooltip,-300
	 
		/*
		If GetKeyState("Del", "P")
		{
			if (LV_GetCount() = LV_GetNext())
				sLine := lineNum-1
			else
				sLine := lineNum
			LV_Delete(LV_GetNext())
			LV_Modify(sLine,"Select")
		}
		*/
	}
Return





+F2::	;	fast search
Gui,1: Show,w300 h225,%appname%
GuiControl,Focus,visibleSchStr
SendMessage, ( EM_SETSEL := 0xB1 ), 0, -1, , ahk_id %ED1%	;preselects the text
SetTimer, tIncrementalSearch, 300

Return


GuiContextMenu:
	If (A_GuiControl = "ResultList" && A_GuiControlEvent = "RightClick")    ; Only show menu when listview is right clicked.
	{
	LV_GetText(FileFullpath,LV_GetNext(),1)
	 Menu Context1, Show, %A_GuiX%, %A_GuiY%
	 }
	return 

MenuEvent:
	If ( !ThisMenuItem )
	   ThisMenuItem = %A_ThisMenuItem%
	
	;msgbox,%ThisMenuItem%	
	
	menuEvent_function(ThisMenuItem,FileFullpath)
	ThisMenuItem=
return	

removetooltip:
tooltip,
settimer,removetooltip,off
return

#IfWinActive,Fast_SEARCH
~^Enter::
Gui, Submit

LV_GetText(SelectedFile, 1)


If InStr( FileExist(File), "D" )
	 {
	 ;folder
		file1=%path%\%selectedFile%
		;splitpath,file1,,Folder
		Folderx="%file1%"
		run, "C:\Program Files\GPSoftware\Directory Opus\dopusrt.exe" /CMD Go PATH %Folderx% 
	}
	else
	{
	;file
	file=%path%\%selectedFile%
	;splitpath,file,,Folder	
	run, "C:\Program Files\GPSoftware\Directory Opus\dopusrt.exe" /CMD Go PATH "%file%" 
	}
 
return

~Enter::
Gui, Submit
gosub,open2
Gui,1: hide
return


up::
guicontrol,focus,ResultList

selected:=LV_GetNext()
selected-=1
LV_Modify(0, "-Select")
LV_Modify(selected, "Select")  
return	
down::
guicontrol,focus,ResultList

selected:=LV_GetNext()
selected+=1
LV_Modify(0, "-Select")
LV_Modify(selected, "Select")  
return	

#IfWinActive

~Esc::
Gui,1: hide
SetTimer, tIncrementalSearch, off
return





open2:
LV_GetText(SelectedFile, LV_GetNext(0))
	Run   "F:\cbn\opus\apps\notepad++_F\unicode\notepad++.exe" "%SelectedFile%"
	Gui,1: hide
return

open3:
LV_GetText(SelectedFile, LV_GetNext(0))
menuEvent_function("open folder",SelectedFile)
Gui,1: hide
return

add_entry:
tooltip,adding
Gui, Submit, NoHide
SchStr:=visibleSchStr
fileappend,`n%SchStr%,%A_ScriptDir%\db.txt
sleep,400

fileread,files,%A_ScriptDir%\db.txt
tooltip
return

listview_height:

; LVM_GETHEADER
SendMessage, 0x1000+31, 0, 0, SysListView321, ahk_id %hw_gui%
WinGetPos,,,, lv_header_h, ahk_id %ErrorLevel%

VarSetCapacity( rect, 16, 0 )

; LVM_GETITEMRECT
;	LVIR_BOUNDS
SendMessage, 0x1000+14, 0, &rect, SysListView321, ahk_id %hw_gui%

y1 := DecodeInteger( "int4", &rect, 4 )
y2 := DecodeInteger( "int4", &rect, 12 )

lv_row_h := y2-y1

lv_h := 2+lv_header_h+( lv_row_h*items )+2	+20

GuiControl, Move, SysListView321, h%lv_h%

gui_h := lv_h+25

gui,show, h%gui_h%
return

;DecodeInteger( )func to find listview height
DecodeInteger( p_type, p_address, p_offset, p_hex=true )
{
	old_FormatInteger := A_FormatInteger

	if ( p_hex )
		SetFormat, Integer, hex
	else
		SetFormat, Integer, dec
		
	sign := InStr( p_type, "u", false )^1
	
	StringRight, size, p_type, 1
	
	loop, %size%
		value += ( *( ( p_address+p_offset )+( A_Index-1 ) ) << ( 8*( A_Index-1 ) ) )
		
	if ( sign and size <= 4 and *( p_address+p_offset+( size-1 ) ) & 0x80 )
		value := -( ( ~value+1 ) & ( ( 2**( 8*size ) )-1 ) )
	    
	SetFormat, Integer, %old_FormatInteger%

	return, value
}

