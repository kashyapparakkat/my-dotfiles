
#NoEnv
;

#SingleInstance Force
SetWorkingDir %A_ScriptDir%
ifexist,note.ico
	menu, Tray, Icon, note.ico


HIST_data_f =fav_data ; save location  
Gui, +AlwaysOnTop   -caption +LastFound     +border +resize  +toolwindow
gui,margin,0,0
gui,font,s22
gui,add,button,x0 y0 w45 h60 vshrinkButton gShrink,O
gui,add,button,x0 y62 ghide h250 w45,H`n`nI`n`nD`n`nE
gui,font,s11
gui,add,button,x0 h35,AOT
gui,add,button,x0 y+0 h35 w45 greadall,refresh all
gui,add,button,x0 y+0 w45 h35 gexit,X

Hotkey, F1, , p1
mainTabNames=QUICK NOTE|---1---|---2---|---3---|APPEND|COLLECTION|line paster|2 do|CLIPB
gui,add,tab2,x46 y1 w330 h270 vTtab gTabSubSwitch hwndTabID TCS_BUTTONS TCS_HOTTRACK,%mainTabNames% 
;;;;tab height
TCM_GETITEMRECT = 0x130A
TCM_SETITEMSIZE = 0x1329
TCS_HOTTRACK 	= 0x40 
    VarSetCapacity(Rect, 16, 0)
    SendMessage, TCM_GETITEMRECT, 0, &Rect,, ahk_id %TabID%
    H := NumGet(Rect, 12) - NumGet(Rect, 4)
Height = 30
SendMessage, TCM_SETITEMSIZE, 0, Height << 16,, ahk_id %TabID%
Gui +LastFound  ; Avoids the need to specify WinTitle below.
SendMessage, TCS_HOTTRACK , 0,0,

gui,font,s12
gui,add,edit,w350 h300 vedit1
gui,add,button ,vbutt11,X
gui,add,button,x+0 vbutt12 gaddTo_safe,add to safe
gui,add,button,x+0 vbutt13 gaddTo_safeLAST,add to last

gui,tab,APPEND
gui,add,edit,w350 h300 vappendedit
; gui,add,button,,X
gui,tab,---1---
gui,add,edit, vedit_1 w350 h300
; gui,add,button,,X
gui,tab,---2---
gui,add,edit, vedit_2 w350 h300
; gui,add,button,,X
gui,tab,---3---
gui,add,edit, vedit_3 w350 h300
; gui,add,button,,X
gui,tab,COLLECTION
gui,add,edit,w350 h300 vcollectionedit
; gui,add,button,,X
gui,tab,line paster
gui,add,edit,w350 h300 vline_paster
; gui,add,button,,X
gui,tab,2 do
gui,add,edit,w350 h300 v2_do
gui,tab,CLIPB
gui,add,edit,w350 h300 vclipb_edit
shown=0
shrink=0


gosub,read_startup
; preselects the first tab
SendMessage, TCM_HIGHLIGHTITEM := 0x1333, 0, 1, , ahk_id %TabID%
return

f1 & f2::	; send f1
send,{f1}
return

~+f1::	; na
~^+f1::	; na
~^f1::	; na
; ~appskey & F1::	; na
return

f1::	;	note.ahk
	if shown=0
	{
		gui,show
		gosub,readall
		guicontrol,focus,edit1
		sleep,100
		send, ^{end}
		shown:=!shown
	}
	else 
	{
		if shrink
		{
			gosub,shrink
			
		}
		else
		{
			gui,hide	
			shown:=!shown
		}
	}
return

Shrink:
shrink:=!shrink
if shrink
	{
	Gui,   +LastFound
	winset,region, 8-8 w30 h30
	guicontrol,move,shrinkButton,w30 h30
	;gosub,hide
	}
else
{
	;if hidden
		;gosub,show
	Gui,   +LastFound
a:=last_GuiWidth+20
b:=last_GuiHeight+20
winset,region, 0-0 w%a% h%b%
	guicontrol,move,shrinkButton,w45 h60
	}
return

 
hide:
	gui,hide
	shown:=!shown
	GoSub,SaveCFG
return


readall:
	FileRead, appendedit, %HIST_data_f%\append.txt
	guicontrol,,appendedit,%appendedit%
	FileRead, collectionedit, data\collection.txt
	guicontrol,,collectionedit,%collectionedit%
	FileRead, line_paster, collector.txt
	guicontrol,,line_paster,%line_paster%
	FileRead, 2_do, 2 do.txt
	guicontrol,,2_do,%2_do%
	guicontrol,,clipb_edit,%clipboard%
return

read_startup:

	FileRead ,edit1 , %A_ScriptDir%\Safe\quick note.txt
	FileRead ,edit_1 , %A_ScriptDir%\Safe\quick note1.txt
	FileRead ,edit_2 , %A_ScriptDir%\Safe\quick note2.txt
	FileRead ,edit_3 , %A_ScriptDir%\Safe\quick note3.txt
	edit1_old:=edit1
	edit_1_old:=edit_1
	edit_1_old:=edit_1
	edit_3_old:=edit_3

	guicontrol,,edit1,%edit1%
	guicontrol,,edit_1,%edit_1%
	guicontrol,,edit_2,%edit_2%
	guicontrol,,edit_3,%edit_3%

	
	
return

addTo_safe:
	gui,submit,nohide

	FormatTime, TimeString2, , dd MMM  yyyy ( ddd ) hh-mm ss tt
	fileappend,%edit1% , %A_ScriptDir%\Safe\%TimeString2%.txt
	lastFile=%TimeString2%.txt
	tooltip,added to %lastFile%
	settimer,removetooltip,-1300

return

addTo_safeLAST:

	gui,submit,nohide

	FormatTime, TimeString2, , dd MMM  yyyy ( ddd ) hh-mm ss tt

	filedelete, %A_ScriptDir%\Safe\%lastFile%
	fileappend,%edit1% , %A_ScriptDir%\Safe\%lastFile%
	lastFile=%TimeString2%.txt
	tooltip,added to %lastFile%
	settimer,removetooltip,-1300


return

GuiEscape:
GuiClose:
exit:
	Gui, Submit, Nohide
	GoSub,SaveCFG
	reload
	; ExitApp
return

SaveCFG:
	Gui, Submit
	if (edit1_old!=edit1)
	{
		filedelete, %A_ScriptDir%\Safe\quick note.txt
		fileappend,%edit1% , %A_ScriptDir%\Safe\quick note.txt
		edit1_old:=edit1
	}
	if (edit_1_old!=edit_1)
	{
		filedelete, %A_ScriptDir%\Safe\quick note1.txt
		fileappend,%edit_1% , %A_ScriptDir%\Safe\quick note1.txt
		edit_1_old:=edit_1
	}
	if (edit_2_old!=edit_2)
	{
		filedelete, %A_ScriptDir%\Safe\quick note2.txt
		fileappend,%edit_2% , %A_ScriptDir%\Safe\quick note2.txt
		edit_2_old:=edit_2
	}
	if (edit_3_old!=edit_3)
	{
		filedelete, %A_ScriptDir%\Safe\quick note3.txt
		fileappend,%edit_3% , %A_ScriptDir%\Safe\quick note3.txt
		edit_3_old:=edit_3
	}

return


TabSubSwitch:
	 
	Gui, Submit, Nohide
	; A_GuiControl holds which sub-tab was clicked,
	; now detect, which of its names was clicked
	GuiControlGet, whichSubTabName,, %A_GuiControl%

	loop,parse,mainTabNames,|
	{
		if (a_loopfield=whichSubTabName)
			SendMessage, TCM_HIGHLIGHTITEM := 0x1333, % A_index-1, 1, , ahk_id %TabID%
		else
			SendMessage, TCM_HIGHLIGHTITEM := 0x1333, % A_index-1, 0, , ahk_id %TabID%
	}

return


removetooltip:
	tooltip,
	settimer,removetooltip,off
return


GuiSize:
	last_GuiWidth:=A_GuiWidth
	last_GuiHeight:=A_GuiHeight
	w:=A_GuiWidth
	h:=A_GuiHeight

	height2:=85
	width2:=60

	tab_edits_list=edit1,appendedit,edit_1,edit_2,edit_3,line_paster,collectionedit,2_do
	loop,parse,tab_edits_list,`,
	{
	; msgbox,%a_loopfield%
		GuiControlSet(a_loopfield,"","","w" . w-width2,1)
		GuiControlSet(a_loopfield,"","","h" . h-height2,1)
	}
		
		GuiControlSet("butt11","","","y" . h-30,1)
		GuiControlSet("butt12","","","y" . h-30,1)
		GuiControlSet("butt13","","","y" . h-30,1)
		
		GuiControlSet(Ttab,"","","h" . h-height2,1)	
	a:=last_GuiWidth+20
	b:=last_GuiHeight+20
	winset,region, 0-0 w%a% h%b%

return
;a guicontrol func
GuiControlSet(Control_Name,Value="",Options="",Pos="",Gui="")	{	;if few control, separate them with |
	if (Gui = "")
		if A_Gui
			Gui := A_Gui
		else
			Gui := 1
	Loop, Parse, Control_Name, |, %A_Tab%%A_Space%
	{
		if (Value != "")
			GuiControl,%GUI%:,%A_Loopfield%,%Value%
		if Options
		{
			GuiControl,% GUI ": " Options, %A_Loopfield%
			GuiControl,% GUI ": MoveDraw", %A_Loopfield%
		}
		if Pos
			GuiControl,% GUI ": MoveDraw", %A_Loopfield%,% Pos		
	}
	return
}

	