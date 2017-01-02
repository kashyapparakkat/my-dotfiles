
SplitPath, A_ScriptDir , , , , , A_Script_Drive
#SingleInstance force
#persistent
#include LIB\misc functions.ahk
#include LIB\para.ahk
#include search suggestions\google desc.ahk
SetTimer, checkMouse, 1000
 
appname=GOOGLER
appname2=GOOGLER2

;SetTimer, RUNNING_CHECK, 60000
hold:=0
flag:=0
iniread, fav, sites1.ini, settings, fav
iniread, autosearch, sites1.ini, settings, autosearch
if (autosearch)
	{
		autosearch_img=play.ico
	}
	else
	{
		autosearch_img=google1.png
	}
	
Menu,Tray,tip,googler
menu, Tray, Icon, Shell32.dll, 46

WinGetPos,,,Xmax,Ymax,ahk_class Progman ; get desktop size

Xcenter := Xmax/2        ; Calculate center of screen
Ycenter := Ymax/2

T = 3   ; adjust tolerance value if desired

Xmax := Xmax - T   ; allow tolerance to mouse corner activation position
Ymax := Ymax - T

#include lib\ini.ahk

x1 :=275
; Gui, Add, Picture, x%x1% y%y1% w32 h32  gadd,  add.ico
y1 :=5
ini_load(ini_1, "sites.ini")
sectionList := ini_getAllSectionNames(ini_1) 

Loop, Parse, sectionList, `,
{
	%a_index%_section := a_loopfield
	%a_index%_name := ini_getValue(ini_1, a_loopfield, "name")
	%a_index%_path1 :=ini_getValue(ini_1, a_loopfield,  "path1")  
	%a_index%_path2 :=ini_getValue(ini_1, a_loopfield,  "path2")  
	%a_index%_icon :=ini_getValue(ini_1, a_loopfield,  "icon")  
	%a_index%_url :=ini_getValue(ini_1, a_loopfield,  "url")  
	icon := %a_index%_icon
	gui, Add, Picture, x%x1% y%y1%  w32 h32  g%a_index%_but, %icon%
	
	x1:=x1+40
}

ini_load(ini_2, "sites2.ini")
siteList := ini_getAllSectionNames(ini_2) 
x1:=430
x2:=x1+20
x3:=x2+75
y1:=y1+5
Loop, Parse, siteList, `,
{ 
	%a_index%2_text :=ini_getValue(ini_2, a_loopfield,  "text")  
	%a_index%2_url :=ini_getValue(ini_2, a_loopfield,  "url")  
	%a_index%2_iconpath :=ini_getValue(ini_2, a_loopfield,  "iconpath")  
	icon := %a_index%2_iconpath
	gui, Add, Picture, x%x1% y%y1%  w16 h16  g%a_index%_site_but, %icon%
	text:=%a_index%2_text
	y:=y1
	gui, Add, text, x%x2% y%y%   v%a_index%_site_but, %text%
	gui, Add, Picture, x%x3% y%y1%  w16 h16  g%a_index%_site_remove_but,remove.ico
	y1:=y1+40
}

Gui, Add, Picture, x%x1%  y%y1%  w32 h32  gsite_add,  add.ico

if y1<260	
	y1:=260
; Gui, Add, Picture, x50 y0  gmovegui,search.png
 
; Gui, Add, Picture, x10 y5 w32 h32 ghold vAOT,   autostart_on.ico 


FileRead, seltext0, data\seltext0.txt

hold =0
Menu, Tray, Add, Exit, exit
Menu, Tray, Icon, Exit, close.ico,, 32

Gui, +AlwaysOnTop   -caption +LastFound  -SysMenu +Owner +border
Gui, +LastFoundExist
GUI_ID:=WinExist() 
Gui, Add, Picture, x350 y10 w32 h32  gdef,  default.ico
Gui, Add, Picture, x+0 y10 w32 h32  vautosearch_toggle gautosearch_toggle,  %autosearch_img%

prevsearchsite := searchsite
Gui, Add, picture, x5 y2  w60 h45 ggoogle ,google.png
Gui, Add, Picture, x70 yp    gfav, play.ico
Gui, Add, Button, x130 yp w50 h45 gs_search vsite_search ceeee22, G site 
Gui, Add, edit, x+5 y10 w80  vSearchSite,  Autohotkey


Gui, font, s16	; bold
Gui, Add, Edit, x10 y50 w245 r1 vvisibleSchStr hWndEd1  +0x100 , %text%
Gui, font, s10	; bold
Gui, Add, Button, x295 yp h37  gpaste, paste
Gui, Add, picture, x260 yp w32 h32 gclear, close.ico
Gui, Add, Button, x345 yp w40 h18 gprev, prev
; Gui, Add, Button, xp yp+18 w40 h18 gsel, sel
Gui, Add, Button, x+0 yp w50 h18 vhide, hide
Gui, Add, Button, xp yp+20 w50 h18 vexit cWhite, exit
;Gui, Add, Button, x5 y158 w110 h40, google 


; gosub,show_gui
Gui  +LastFound
Gui  Color, 66CCFF

Gui, 4: font, s14 
Gui 4: +LastFound +AlwaysOnTop   -caption +LastFound  -SysMenu +Owner
Gui, 4: Add, Listbox, x5 y0  w400 h250 gListEvent AltSubmit  vResultList hwndhList  ;	,match|source

Gui 4: Color, 66CCFF
; WinSet, TransColor, EEAA99
Gui, 4: +LastFoundExist
GUI_ID2:=WinExist() 

;;;;;

Gui, 2: +AlwaysOnTop 
Gui, 2:Add, Text, x10 y18, url:
Gui, 2:Add, edit, x50 y18 w250 vSiteAdd_url,  
Gui, 2:Add, Text, x10 y50, display name
Gui, 2:Add, edit, x50 y50 w250 vSiteAdd_text,  
Gui, 2:Add, Picture, x10 y80 w32 h32  gadd_2 vSiteAdd_icon,  add.ico
Gui, 2:Add, edit, x50 y80 w250 vSiteAdd_iconpath, icon file path 
Gui, 2:Add, Button, x10 y120 w32 h32  gadd_save,  save

Gui, 3: +AlwaysOnTop 
Gui, 3:Add, Text, x10 y18, url:
Gui, 3:Add, edit, x50 y18 w250 vSiteAdd_url,  
Gui, 3:Add, Text, x10 y50, display name
Gui, 3:Add, edit, x50 y50 w250 vSiteAdd_text,  
Gui, 3:Add, Picture, x10 y80 w32 h32  gsite_add_2 vSiteAdd_icon,  add.ico
Gui, 3:Add, edit, x50 y80 w250 vSiteAdd_iconpath, icon file path 
Gui, 3:Add, Button, x10 y120 w32 h32  gsite_add_save,  save

gui, Show,x300 y300 hide 
gui, 4: Show,x300 y395 hide 
return 

show_gui:

SetTimer, tIncrementalSearch, 100
	
MouseGetPos,  posx,  posy
posx:=posx-150
posy:=posy-190
if posx<0
	posx :=0
else if posx>400
	posx :=400
	
if posy<50
	posy :=0
else if posy>300
	posy :=300
; gui, Show
; gui, Show, x%posx% y%posy% , %appname%
DllCall("AnimateWindow","UInt",GUI_ID,"Int",500,"UInt",0xA0004)	
winactivate,ahk_class AutoHotkeyGUI
;MouseMove, -20, 60, ,  R
if seltext0 is space
	text := clipboard	
	else text := seltext0
prevtext := text

SetTimer, focus_lost, 700
tooltip,autosearch
settimer,removetooltip,-1000
; gosub, autosearch 

GuiControl, Focus, visibleSchStr
guicontrol,,visibleSchStr, %text%
SendMessage, ( EM_SETSEL := 0xB1 ), 0, -1, , ahk_id %ED1%	

return 

;			;			;			;			;				;

1_site_but:
2_site_but:
3_site_but:
4_site_but:
5_site_but:
6_site_but:
7_site_but:
8_site_but:
9_site_but:
10_site_but:
Stringleft, index , A_Thislabel, 1
path :=%index%2_url
run, http://%path%

 return
 
 
MoveGui:
flag :=1
PostMessage, 0xA1, 2,,, A
Return

def:
flag :=1
	Gui, Submit, NoHide
	iniwrite, %SearchSite%, sites1.ini, settings, fav
	tooltip,fav
	settimer,removetooltip,-800
	return
	
	
1_but:
2_but:
3_but:
4_but:
5_but:
6_but:
7_but:
8_but:
flag :=1
	Stringleft, index , A_Thislabel, 1
	Gui, Submit, NoHide
	SearchSite :=%index%_url
	
	GuiControl,, searchsite, %SearchSite%
	GuiControl,, site_search, %SearchSite% G search
	GuiControl, Focus, visibleSchStr
return

hold: 
	if (hold)
	{
	hold:=0
	GuiControl,, aot ,  autostart_on.ico 
	}
	else
	{
	hold :=1
	GuiControl,, aot ,Orange.ico
	}
Return    


paste:
 Gui, Submit, NoHide
 GuiControl,, visibleSchStr, %clipboard%
 return

s_search:

	Gui, Submit, NoHide


	if (SearchSite)
	Run, http://www.google.com/search?q=%visibleSchStr%+site:%SearchSite%.com
	else
	Run, http://www.google.com/search?q=%visibleSchStr%
	return
	
autosearch_toggle:  
 
	if (autosearch)
	{
	autosearch:=0
	GuiControl,, autosearch_toggle , google1.png
	tooltip,google
	}
	else
	{
	autosearch :=1
	GuiControl,, autosearch_toggle , play.ico
	tooltip,fav
	
	}
	settimer,removetooltip,-800
	iniwrite, %autosearch%, sites1.ini, settings,autosearch
Return
fav:
iniread, fav, sites1.ini, settings, fav
	Gui, Submit, NoHide

	gosub, save_searchterm

	Run, http://www.google.com/search?q=%visibleSchStr%+site:%fav%.com

	return

google:
	Gui, Submit, NoHide
	gosub, save_searchterm
	Run, http://www.google.com/search?q=%visibleSchStr%
	return

buttonexit: 
	exitapp
	return

prev:
	Gui, Submit, NoHide
	FileRead, prev_searchterm, prevgoogle.txt
	GuiControl,, visibleSchStr, %prev_searchterm%
	return
sel:
	 Gui, Submit, NoHide
	 GuiControl, ,  visibleSchStr, %seltext0%
	 return

add:

	Gui, Submit, NoHide
	posx:=posx+200
	Gui, 2: Show, x%posx% y%posy% , add
 
	GuiControl,2:,  SiteAdd_url, %SearchSite%
	GuiControl,2:,  SiteAdd_text, %SearchSite%
	;iniwrite, %searchsite%, sites.ini,site_llist, site1
	return

add_2:
  
  FileSelectFile, SelectedFile, 3, , Open a file, icon (*.ico;*.png)
  
  GuiControl,3:, SiteAdd_iconpath, %SelectedFile%
  GuiControl,3:, SiteAdd_icon, %SelectedFile%

   return
 add_save:
	Gui, Submit, 
	iniwrite, %SiteAdd_url%, sites.ini, %SiteAdd_text%, url
	iniwrite, %SiteAdd_text%, sites.ini, %SiteAdd_text%, text
	iniwrite, %SelectedFile%, sites.ini, %SiteAdd_text%, icon
	return
	
site_add:

	Gui, Submit, NoHide
	posx:=posx+200
	Gui, 3: Show, x%posx% y%posy% , add
 
	GuiControl,3:,  SiteAdd_url, www.%SearchSite%.com
	GuiControl,3:,  SiteAdd_text, %SearchSite%
	;iniwrite, %searchsite%, sites.ini,site_llist, site1
	return

site_add_2:
Gui, Submit, nohide
  urldownloadtofile, http://www.google.com/s2/favicons?domain=%SearchSite%.com, %SiteAdd_text%.ico
  
 ;FileSelectFile, SelectedFile, 3, , Open a file, icon (*.ico;*.png)
  icon =%SiteAdd_text%.ico
  ;GuiControl,3:, SiteAdd_iconpath, %SelectedFile%
  GuiControl,3:, SiteAdd_icon, %icon%

return

site_add_save:
	Gui, Submit, 
	iniwrite, %SiteAdd_url%, sites2.ini, %SiteAdd_text%, url
	iniwrite, %SiteAdd_text%, sites2.ini, %SiteAdd_text%, text
	iniwrite, %SiteAdd_text%.ico, sites2.ini, %SiteAdd_text%, iconpath
	return
1_site_remove_but:
2_site_remove_but:
3_site_remove_but:
4_site_remove_but:
5_site_remove_but:
6_site_remove_but:
7_site_remove_but:
8_site_remove_but:
9_site_remove_but:
	Stringleft, index , A_Thislabel, 1
	section:=%index%2_text
	IniDelete, sites2.ini, %Section%

 return
buttonhide:
	gosub,hide
	return
   

GuiClose:
	ExitApP

clear:
 
GuiControl,, visibleSchStr, 

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
    GuiControl,, visibleSchStr, %clipboard%
	flag:=0
	hold:=0
	gosub,show_gui
	sleep 500
	loop
	{
		IfWinNotActive,ahk_class AutoHotkeyGUI
		{
			goto, focus_lost
		}
	}
	return
}	

return

focus_lost:

	if (hold)
		return
	IfWinNotActive, ahk_class AutoHotkeyGUI
		{ 
			sleep,200
			IfWinNotActive, ahk_class AutoHotkeyGUI
			{
				gosub,hide
				settimer,focus_lost,off
				return
			}
		}
return	
	
exit:
	exitapp
return

save_searchterm:
	FileDelete, prevgoogle.txt
	FileAppend,
	(
	%visibleSchStr%
	), prevgoogle.txt
	return

autosearch:

flag:=0
	;SetTimer, autosearch, off
	keywait, Lbutton, D ,t1.5
	
	  if  (errorlevel =1)
			{ 
			
			}
			else
			{			 
			flag:=1 
			; msgbox,	
				return
			}
;sleep, 1500
;input, singlekey, v t2, {Lbutton}
	 
gui, submit,nohide	
	if (prevtext = visibleSchStr)
		{			 
			
		}
		else
		{
			flag:=1
			return	 
		}			
	 /*if (prevSearchSite = SearchSite)
		{
			if (flag)
				return
		}
		else
		{
			flag:=1
		}	   
  */
	if (!flag)
		{	
	
		gui, submit
		; msgbox
		
			if (autosearch)
				{
				gosub, fav 
				}
			else
				{			
				gosub,  google
				}
		}		
return




appskey & pause::	;	google
   WinGetActiveTitle, OutputVar 
   If OutputVar is space   
   {
      seltext =
      Goto , End2
   }
   ClipSaved := ClipboardAll   ; Save clipboard content for later restore
   sleep , 100      ; Delays required else it can be unreliable
   Clipboard =      ; Flush clipboard
   Sleep, 100
   SendEvent, ^c   ; Save highlighted text to clipboard. 
   sleep , 100
   seltext := Clipboard
   Sleep, 100
   Clipboard := ClipSaved   ; Restore Clipboard content  
   ClipSaved =            ; and free the memory
   
   End2:
    

	Run, http://www.google.com/search?q=%seltext%+site:%fav%.com
return
	
	
	
	
	

~lshift::	; na
;400 is the maximum allowed delay (in milliseconds) between presses.
if (A_PriorHotKey = "~lshift" AND A_TimeSincePriorHotkey < 400)
{
flag:=0
hold:=0
	gosub,show_gui

	 
}
Sleep 0
KeyWait lshift
return


tIncrementalSearch:

; REPEAT SEARCHING UNTIL USER HAS STOPPED CHANGING THE QUERY STRING

	Gui, Submit, NoHide
	CurFilename = %visibleSchStr%
	If NewKeyPhrase <> %CurFilename%	
	{	

		SetTimer,SearchSub,-1
		NewKeyPhrase = %CurFilename%
		;Sleep, 100 ; DON'T HOG THE CPU!
	}
	Else
	{
		; QUERY STRING HAS STOPPED CHANGING
		;Break
	}

Return

SearchSub:
if visibleSchStr=
	{
		; gui, 4: hide
		DllCall("AnimateWindow","UInt",GUI_ID2,"Int",300,"UInt","0x90000")
		goto , stopsearch
	}
Gui, Submit, NoHide
tooltip,qerying..
; LV_Delete()
	if % ConnectedToInternet()		;	%
	{
		results=

		results:=get_suggestions_google(visibleSchStr,10)
		tmp=		
		; tmp:=get_suggestions_wikipedia(visibleSchStr)
		results:=results . "`n[W]`n" . tmp
		desc:=get_description_google(visibleSchStr,7)
		
		desc:=para(desc, 45 )
		tooltip,
		tooltip,%desc%,500,100,3
	}
	else
	{
		tooltip,instant off,700,100,3
	}
	GuiControl,Focus,visibleSchStr
	settimer,removetooltip3,300

	results2= 
	loop,parse,results,`n,`r
	results2:= results2 . A_LoopField . "|" 
		; LV_Add(A_LoopField)
		y:=posy+200
; gui,4: show, x%posx% y%y%
DllCall("AnimateWindow","UInt",  GUI_ID2  ,"Int", 200,"UInt", 0x40004)
GuiControl, 4:,ResultList, %results2%

STOPSEARCH: 
; Oldschstr:=schstr
; LV_ModifyCol(1,"AutoHdr")
; LV_ModifyCol()

; matchcount:=LV_GetCount()
; guicontrol,,match_count,%matchcount%
; guicontrol,,source,%Search_text_type%
; gosub,preselection

GuiControl,4: Show, ResultList
GuiControl,Focus,visibleSchStr	
		
return
	
	
	
	
removetooltip:
	tooltip,
	settimer,removetooltip,off
return
removetooltip2:
	tooltip,,,,2
	settimer,removetooltip2,off
return

removetooltip3:
	tooltip,,,,2
	settimer,removetooltip3,off
return



ConnectedToInternet(flag=0x40) {
    return DllCall("Wininet.dll\InternetGetConnectedState", "Str", flag, "Int", 0)
}




~esc::	; na
hide:
tooltip,,,,3
tooltip,,,,2
tooltip,
; gui,hide
; gui,4: hide
 DllCall("AnimateWindow","UInt",  GUI_ID2  ,"Int", 100,"UInt", 0x90004) 
 DllCall("AnimateWindow","UInt",  GUI_ID  ,"Int", 200,"UInt", 0x90004) 

return

ListEvent:
GuiControlGet, text,4:,ResultList
loop,parse,results2,`|
{
	if (a_index=text+1)
	{
		Temp1=%a_loopfield%
		break
	}
}
guicontrol,1: ,visibleSchStr,%Temp1%
return


#IfWinActive,googler.ahk
; #IfWinActive, GOOGLER2

down::	; na
GuiControlGet, current_completion, 4:, ResultList
	if (current_completion == "")
		current_completion = 0
	current_completion := current_completion + 1
	GuiControl, 4:Choose ,ResultList, %current_completion%
; msgbox,%current_completion%

return
  
up::

GuiControlGet ,current_completion,4: , ResultList
if (current_completion > 0)
{
	current_completion := current_completion - 1
	if (current_completion == 0)
	{
	  PostMessage, 0x186, -1, 0,, ahk_id %hList%

	}
	else
	{
	  GuiControl, 4:Choose , ResultList, %current_completion%
	  ; Gosub ibc_copy_completion_to_input
	}
}
return
select:
enter::	; na
GuiControlGet, text,4:,ResultList
loop,parse,results2,`|
{
	if (a_index=text+1)
	{
		Temp1=%a_loopfield%
		break
	}
}
guicontrol,1: ,visibleSchStr,%Temp1%

return


#IfWinActive