ifexist,ralt.ico
	Menu, Tray, Icon,ralt.ico
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
#include LIB\cbn.ahk
#NoEnv
SendMode Input
SetTitleMatchMode 2
showstatus=1
HotkeySTEP:=0	
HotkeySTEP2:=0
HotkeySTEP2_count:=0

hotkey,^q,off

;******************************************************************************
; This is a random selection of utilities. All are activated by holding 
; "Application Key" (left of right Ctrl) and pressing some other key. 
; Some of them have a second function activated by holding Shift at the 
; same time. Hopefully you will find some of the useful. Feel free to 
; modify, reuse or share any of this.
;
; AppsKey plus - Result
;
;        Enter - Inserts a linebreak.
;                For use when pressing enter would submit a form.
;          Tab - Inserts a tab.
;                For use when pressing tab would change the focus.
;   Arrow Keys - Move the mouse with the arrow keys.
;                For use when you need pixel-precise control.
;       Insert - Searches for the slected text with Google. Or if the text
;                is a URL, goes directly there. See BROWSER CONFIG below.
;    Caps Lock - Opens a context menu with commands to change the case of
;                the selected text, reverse it or "fix" Unix style newlines.
;           F1 - Shows the AutoHotkey help file.
;           F4 - Terminates active application after confirmation.
;                This is like using the Ctrl+Alt+Delete menu.
;     SHIFT F4 - As above, but skips confirmation window.
;  Windows Key - Disables the Windows keys. For use with fullscreen games.
;                Press both windows keys at once to re-enable them.
;            A - Makes the active window "Always On Top".
;                This will be indicated on it's title bar with a †.
;      SHIFT A - Makes the active window NOT "Always On Top".
;            C - Eject the CD tray.   |Handy if the computer is on the floor
;      SHIFT C - Retract the CD tray. |or otherwise awkward to reach.
;            B   Turns the monitor off, similar to power saving mode.
;                Moving the mouse or typing will turn it back on.
;            E - Opens this script for editing.
;            H - Hides the active window.
;      SHIFT H - Unhide all windows that were hidden this way.
;            L - Launch (run) a script selected in explorer.
;                For use when .ahk is not associated with AutoHotkey.
;            R - Reloads this script.
;                If the active window is this script, it will be saved first.
;            T - Makes the active window 50% transpartent.
;      SHIFT T - Makes the active window opaque again.
;            V - Pastes clipboard contents as plain text (if possible).
;                If you "copy" files, this will paste their paths.
;            W - Wraps text to a specific width. (Default 70).
;      SHIFT W - Undoes the above.
;            X - Shows a custom shutdown menu. Press a letter to select from:
;                Shutdown, Restart, Log Off, Hibernate or Powersave (suspend) 
;            / - Do a RegEx replace on selected text.
;            [ - Creates matching BBCode tags. (Applied to selected text)
;            , - Creates matching HTML tags. (Ditto)
;            ; - Comments/Uncomments a block of AutoHotkey code.

; BROWSER CONFIG
; This should be the full path to your preferred web browser.
; Example: C:\Program Files\Mozilla Firefox\Firefox.exe
if FileExist("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe") 
	BrowserPath = C:\Program Files (x86)\Google\Chrome\Application\chrome.exe
else if FileExist("C:\Program Files (x86)\Mozilla Firefox\Firefox.exe") 
	BrowserPath = C:\Program Files (x86)\Mozilla Firefox\Firefox.exe
else
	BrowserPath = C:\Program Files (x86)\Google\Chrome\Application\chrome.exe

gosub,advanced_clipbaoard_gui

Gui, 2:Add, Edit, R20 vMyEdit
GroupAdd All
j=0
numberOfElements:=20 

 tipsTmp=nil
 tips2=nil
 tips1=nil
 
previousClip= 
clipIndex:=0 
pom=enabled 
menu, tray, NoStandard 
menu, tray, add, Paste Only mode, pom 
menu, tray, add, Paste/Edit/Save mode,pesm 
menu, tray, add, History features, features 
menu, tray, add, Exit,exitapplication 
Menu,History2,add,Paste,clipPaste 
Menu,History2,add,Edit,clipPaste 
Menu,History2,add,Save,clipPaste 
IfNotExist, data 
   FileCreateDir, data 
IfNotExist, data\saved 
   FileCreateDir, data\saved 

 
gosub,menu
return


menu:
 
menu,smartsel1,add,
Menu, clipmenu, add, &I hide, hide
Menu, clipmenu, add,
Menu, clipmenu, Add, &U PPERCASE, uCase
Menu, clipmenu, Add, &l owercase, lCase
Menu, clipmenu, add, &C count sel, count

Menu, text, add, &D    UPPERCASE., ucase
Menu, text, add, &E    lowercase., lcase
Menu, text, add, &F    Sentence case., scase
Menu, text, add, &G    Title Case., tcase
Menu, text, add, &H    iNVERSE cASE., icase
Menu, text, Add,

Menu, text, Add, &Fix Linebreaks, FixLinebreaks
Menu, text, Add, &R everse, Reverse

 

Menu, remove, Add, &D dupe line,removeDLine

Menu, remove, Add,  d&upe word, removeDword
Menu, remove, Add,
Menu, remove, Add, &N    Remove leading whiteSpaces, leading
Menu, remove, Add, &O    Remove trailing whiteSpaces, trailing
Menu, remove, Add, &P   Remove double blank Lines, doublelines
Menu, remove, Add, &B   Blank line, blanklines
Menu, remove, Add,  
Menu, remove, Add, &T   trim n char from EOL,nil
Menu, remove, Add, -Organization-,nil
Menu, remove, Add, &L    Spaces-->Tabs, StoT
Menu, remove, Add, &M    Tabs-->Spaces, TtoS


Menu,sort,Add,Sort &A-Z,sortaz
Menu,sort,Add,&Z-A,sortza
Menu,sort,Add,Sort &numeric,sortazNumeric
Menu,sort,Add,&reverse,sortzaNumeric

Menu,sort,Add,
Menu,sort,Add, random,sortrandom
Menu,sort,Default, random


Menu, smartsel1, add, &S    Google search, google
Menu, smartsel1, add, &T    Google Image search, googleimage


Menu,number,Add,&N    0-n,number0toN
Menu,number,Add,&N    n-0,numberNto0
Menu,number,Add,&R    advanc2d,numberAdvanced
; Menu,number,Add,a-z,textgenerator
Menu,number,Add,
Menu,number,Add,&P    Prefix,numberprefix
Menu,number,Add,&P    Prefix  Advanced,numberprefixAdvanced



Menu, options, add, &Exit Mango., exitscript


Menu, tools, add, -Tools-, disabled
Menu, tools, add, &A    Revert to previous., prev
Menu, tools, add, &A    view previous., prevAll
Menu, tools, add, -Case-, disabled

Menu, tools, add, -System-, disabled
 
Menu, tools, add, &R    Get window under Mouse., window
Menu, tools, add, -Misc-, disabled

Menu, tools, add, &U   Run Clipboard as AHK code, runcode
Menu, tools, add,   open Clipboard as AHK code, Open_clipb_code
Menu, tools, add,    Open_runcode, Open_runcode
Menu, tools, add,&N	rename txt files from clipB,txt_rename

Menu, plugins, add, -plugins-, disabled
Loop, %A_ScriptDir%\Plugins\*.ahk
		Menu, plugins, add, %A_LoopFileName%, plugins
Menu, plugins2, add, -plugins2-, disabled
Loop, %A_ScriptDir%\Plugins2\*.ahk
		Menu, plugins2, add, %A_LoopFileName%, plugins2

Menu, plugins, Disable,     -plugins-
Menu, plugins2, Disable,     -plugins2-
Menu, Tools, Disable,     -Tools-
Menu, Tools, Disable,     -Case-
Menu, remove, Disable,     -Organization-
Menu, Tools, Disable,     -System-
Menu, Tools, Disable,     -Misc-
;~ Menu, options, UnCheck, Mode: Add to clipboard.
;~ Menu, options, UnCheck, Notify clipboard changes.
;~ Menu, options, Check, save clipboard text to a file.
;~ Menu, options, UnCheck, Load on System startup?
;~ Menu, options, Check, Autosave settings?


Menu, clipmenu, add,

Menu, clipmenu, add, &T ext:, :text
Menu, clipmenu, Add, &R emove, :remove
Menu, clipmenu, add,
Menu, clipmenu, Add, &S smart, :smartsel1
Menu, clipmenu, add,
Menu, clipmenu, Add, &T Sort sel, :sort
Menu, clipmenu, Add, &N number, :number
Menu, clipmenu, add,
Menu, clipmenu, add, &Z tools:, :tools
clipMenu() ;update history
Menu, clipmenu, add, &H history:, :History
Menu, clipmenu, add,
Menu, clipmenu, add, &P plugins:, :plugins
Menu, clipmenu, add, &Q plugins2:, :plugins2
 

 
Menu, MyMenu, add, -SCRIPTS-, disabled
Menu, all, add, -ALL-, disabled

Loop, read, scripts.txt
{    
		Menu, all, add,%A_LoopReadLine%, scripts
		
}
scriptmenu()


Loop, read, scripts_imp.txt
{    
		Menu, MyMenu, add,%A_LoopReadLine%, scripts
}
Menu, MyMenu, add,
Loop, read, scripts_imp2.txt
{    
		Menu, MyMenu, add,%A_LoopReadLine%, scripts
}
Menu, MyMenu, add,
Menu, MyMenu, add, &P plugins:, :all

Menu, MyMenu, add,&space modifier,nil
Menu, MyMenu, add, PS safe,nil
Menu, all, Disable,     -ALL-
Menu, MyMenu, Disable,    -scripts-
Menu, MyMenu, add,R efresh menu,refresh
Menu, MyMenu, add,
Menu, mymenu, add, &O options:, :options
Menu, mymenu, add, &R    restart Mango., restart
menu,smartsel,add,
Return


scriptmenu()
{


DetectHiddenWindows, On	 
Loop, read, scripts.txt
	{
	 ifWinexist, %A_LoopReadLine% ahk_class AutoHotkey
		{
		Menu, all, Check,%A_LoopReadLine%
		}
		else
		{
		Menu, all, UnCheck,%A_LoopReadLine%
		}
	}
	return
}

refresh:
gosub,menu
return


disabled:
hide:
Return

count:

If seltext is space   
   return
   
             
	len:=StrLen(seltext)
	Spaces=
	newline:=0
	chars=
	Tabs=
	Loop, Parse, seltext, `n
			newline++
	Loop, Parse, seltext
		{
			If A_loopField=%A_Space%
					Spaces++
			If A_loopField=%A_Tab%
					tabs++
		}

	If tabs=
			tabs:=0
	If Spaces=
			Spaces:=0

	chars:= len-Spaces-tabs
	tooltip, Length: %len%`nSpaces/words: %spaces%`nTabs: %Tabs%`nCharacters: %chars%`nLines: %newline%
	keywait, Lbutton, D ,t5
	 
	tooltip,

	
		
Return

addmode:
	Menu, options, ToggleCheck, Mode: Add to clipboard.
Return
notifychange:
	Menu, options, ToggleCheck, Notify clipboard changes.
Return
savetofile:
	Menu, options, ToggleCheck, save clipboard text to a file.
Return
startup:
	Menu, options, ToggleCheck, Load on System startup?
Return
savesettings:
	Menu, options, ToggleCheck, Autosave settings?
Return



; TOOLS
; TOOLS
; TOOLS
prevall: 
GuiControl,2:, MyEdit,%previousClip0%`n=`n%previousClip1%`n=`n%previousClip2%`n=`n%previousClip3%
Gui, 2:Show, Center, %version%
return


prev:

clipboard:=previousClip0
		tooltip,%Clipboard%
		keywait, Lbutton, D ,t3
		tooltip,
		
/*=
	prevtemp:=ClipPrev
	ClipPrev:=Clipboard
	Clipboard:=prevtemp
	prevtemp=
	*/
Return 

ucase:
 
	StringUpper, selText, selText
	clipboard:=selText		
	tooltip, %selText%
	keywait, Lbutton, D ,t3
	tooltip
Return

lcase:
 
	StringLower, selText, selText
	clipboard:=selText
	tooltip, %selText%
	keywait, Lbutton, D ,t3
	tooltip
Return
scase:
 
	selText := RegExReplace(selText, "([.?\s!]\s\w)|^(\.\s\b\w)|^(.)", "$U0")
	clipboard:=selText
	tooltip, %selText%
	keywait, Lbutton, D ,t3
	tooltip
Return
tcase:
 
	StringUpper, selText, selText, T 
	clipboard:=selText
	tooltip, %selText%
	keywait, Lbutton, D ,t3
	tooltip
Return
icase:
 
	; Thanks JDN
	Lab_Invert_Char_Out:= ""
	Loop % Strlen(selText) { ;%
			Lab_Invert_Char:= Substr(selText, A_Index, 1)
			If Lab_Invert_Char is Upper
					Lab_Invert_Char_Out:= Lab_Invert_Char_Out Chr(Asc(Lab_Invert_Char) + 32)
			Else If Lab_Invert_Char is Lower
					Lab_Invert_Char_Out:= Lab_Invert_Char_Out Chr(Asc(Lab_Invert_Char) - 32)
			Else
					Lab_Invert_Char_Out:= Lab_Invert_Char_Out Lab_Invert_Char
		}
	text:=Lab_Invert_Char_Out
	clipboard:=text
	tooltip, %text%
	keywait, Lbutton, D ,t3
	tooltip
Return
number0toN:
OutPut=
InputBox, UserInput, autonumber, n=, , 80,150,,,,,10
if ErrorLevel != 2
 {Loop, %UserInput%
		{
		OutPut .= InsertText A_Index  "`n" 
		}
clipboard:=output
tooltip,%Clipboard%
	keywait, Lbutton, D ,t3
		tooltip,
}
 Return
numberNto0:
OutPut=
InputBox, UserInput, autonumber, n=, , 80,150,,,,,10
if ErrorLevel != 2
 {Loop, %UserInput%
		{
		n:=UserInput-A_Index
		OutPut .= InsertText n  "`n" 
		}
clipboard:=output
tooltip,%Clipboard%
	keywait, Lbutton, D ,t3
		tooltip,
}
Return
numberAdvanced:
OutPut=
	InputBox, UserInput, autonumber, n=, , 80,150,,,,,10
	if ErrorLevel != 2
	{
	InputBox, UserInput2, autonumber, pattern:`n %UserInput% ) OR %UserInput%., , 80,150,,,,,.%A_space%

	 Loop, %UserInput%
			{
			OutPut .= InsertText A_Index UserInput2 "`n" 
			}
			
	clipboard:=output
	tooltip,%Clipboard%
	keywait, Lbutton, D ,t3
		tooltip,
	}
 Return
numberprefix:
	OutPut=
	 
		  Loop, Parse, selText, `n, `r
				{
				OutPut .= InsertText A_Index A_LoopField "`n" 
				}
		clipboard:=output
		tooltip,%Clipboard%
		keywait, Lbutton, D ,t3
		tooltip,
	 Return
numberprefixAdvanced:
	OutPut=
	 
		InputBox, UserInput2, autonumber, pattern:`n 123 ) OR 123., , 80,150,,,,,.%A_space%
	  Loop, Parse, selText, `n, `r
				{
				OutPut .= InsertText A_Index UserInput2 A_LoopField "`n" 
				}
		clipboard:=output
		tooltip,%Clipboard%
	keywait, Lbutton, D ,t3
		tooltip,
 Return
 
StoT:

	StringReplace, selText, selText, %A_Space%, %A_Tab%, All
	clipboard:=selText
		tooltip,%Clipboard%
		keywait, Lbutton, D ,t3
		tooltip,
Return
TtoS:
	StringReplace, selText, selText, %A_Tab%, %A_Space%, All
	clipboard:=selText
		tooltip,%Clipboard%
		keywait, Lbutton, D ,t3
		tooltip,
Return
leading:
	selText := RegExReplace(selText, "m)(^[ \t]+)", "")
	clipboard:=selText
		tooltip,%Clipboard%
		keywait, Lbutton, D ,t3
		tooltip,
Return
trailing:
	selText := RegExReplace(selText, "m)([ \t]+$)","")
	clipboard:=selText
		tooltip,%Clipboard%
		keywait, Lbutton, D ,t3
		tooltip,
Return
blanklines: 
	StringReplace, selText, selText, `r`n`r, , All
	clipboard:=selText
		tooltip,%Clipboard%
		keywait, Lbutton, D ,t3
		tooltip,
Return
doublelines:
	StringReplace, selText, selText, `r`n`r`n, `r`n, All
	clipboard:=selText
		tooltip,%Clipboard%
		keywait, Lbutton, D ,t3
		tooltip,
Return
removeDword:
OutPut=
Loop, Parse, selText,%a_space%,
		{
		If !(InStr(SearchForSection2,"__bol__" . A_LoopField . "__eol__",CaseSensitive)) ; not found
				 	{
				 	 SearchForSection2 .= "__bol__" A_LoopField "__eol__" ; this makes it unique otherwise it could be a partial match
					 output .= A_LoopField "`n"
				 	}
		

	}
	clipboard:=output
		tooltip,%Clipboard%
		keywait, Lbutton, D ,t3
		tooltip,
	 Return 
removeDLine:
OutPut=
Loop, Parse, selText, `n, `r
		{
		If !(InStr(SearchForSection2,"__bol__" . A_LoopField . "__eol__",CaseSensitive)) ; not found
				 	{
				 	 SearchForSection2 .= "__bol__" A_LoopField "__eol__" ; this makes it unique otherwise it could be a partial match
					 output .= A_LoopField "`n"
				 	}
		

	}
	clipboard:=output
		tooltip,%Clipboard%
		keywait, Lbutton, D ,t3
		tooltip,
	 Return 


window:
	WinGetTitle, Clipboard , ahk_pid %pid%
	tooltip,%Clipboard%
	keywait, Lbutton, D ,t2
Return

google:
	Run, http://www.google.com/search?source=ig&hl=en&rlz=&q=%Clipboard%&btnG=Google+Search&aq=f
Return
googleimage:
	Run, http://images.google.com/images?um=1&hl=en&newwindow=1&safe=off&client=opera&rls=en&q=%Clipboard%&btnG=Search+Images
Return

<^!1::	;	run sel as temp.ahk

selText:=Get_Selected_Text()	
tooltip,temp.ahk`n^!1::		run sel as temp.ahk`n^!2::		run clipB as temp.ahk`n^!3::		run / reload temp.ahk`n^!4::		open temp
	FileDelete %A_ScriptDir%\temp.ahk
	FileAppend , #SingleInstance force`n`n`;===============`n%selText%`n`n`;=============`n`n`n~esc::ExitApp, %A_ScriptDir%\temp.ahk
	Run  %A_ScriptDir%\temp.ahk
	Sleep 2500
	tooltip,
Return
<^!2::	;	run clipB as temp.ahk
runcode:	;	run clipB
tooltip,temp.ahk`n^!1::		run sel as temp.ahk`n^!2::		run clipB as temp.ahk`n^!3::		run / reload temp.ahk`n^!4::		open temp
	FileDelete %A_ScriptDir%\temp.ahk
	FileAppend , #SingleInstance force`n`n`;===============`n%Clipboard%`n`n`;=============`n`n`n~esc::ExitApp, %A_ScriptDir%\temp.ahk
	Run  %A_ScriptDir%\temp.ahk
	Sleep 1500
	tooltip,
Return
<^!5::	;	Open clipb in temp.ahk
Open_clipb_code:
tooltip,temp.ahk`n^!1::		run sel as temp.ahk`n^!2::		run clipB as temp.ahk`n^!3::		run / reload temp.ahk`n^!4::		open temp

	FileDelete %A_ScriptDir%\temp.ahk
	FileAppend , #SingleInstance force`n`n`;===============`n%Clipboard%`n`n`;=============`n`n`n~esc::ExitApp, %A_ScriptDir%\temp.ahk
	Run   "F:\cbn\opus\apps\notepad++_F\unicode\notepad++.exe" "%A_ScriptDir%\temp.ahk"
sleep,1500
tooltip,
Return

<^!3::	;	run / reload temp.ahk
tooltip,reloading
	Run  %A_ScriptDir%\temp.ahk
	Sleep 1500
	tooltip,
Return

<^!4::	;	open temp
tooltip,temp.ahk`n^!1::		run sel as temp.ahk`n^!2::		run clipB as temp.ahk`n^!3::		run / reload temp.ahk`n^!4::		open temp
Open_runcode:
	Run   "F:\cbn\opus\apps\notepad++_F\unicode\notepad++.exe" "%A_ScriptDir%\temp.ahk"
Sleep 1500
tooltip
Return


txt_rename:
files:=clipboard

loop,parse,files,`n,`r 
{
	splitpath,a_loopfield,name,path,OutExtension
	fileread,MyText,%a_loopfield%
	sleep,200
	if(StrLen(MyText)>60)
	{
	StringLeft, MyText, MyText,50
	}
	stringreplace,MyText,MyText,`r`n,%a_space%, all
	stringreplace,MyText,MyText, %A_TAB%,%a_space%, all
	stringreplace,MyText,MyText,:,%a_space%, all
	MyText:=RegExReplace(MyText,  "\\\*?|/", " ")
	if(StrLen(MyText)>50)
	{
		StringLeft, MyText, MyText,50
	}
	; tooltip,%MyText%
	; sleep,500
	; tooltip,
	filemove,%a_loopfield%,%path%\%MyText%.%OutExtension%
}
Return
; PLUGINS
; PLUGINS
; PLUGINS

scripts:

ifWinexist, %A_Thismenuitem% ahk_class AutoHotkey
		{
		 WinClose,  %A_Thismenuitem% ahk_class AutoHotkey
		}
		else
		{
		Run, %A_Thismenuitem%
		 
		}
	 
	Menu, all, ToggleCheck,%A_Thismenuitem%

Return

plugins:
	Run, %A_Scriptdir%\Plugins\%A_Thismenuitem%
Return
plugins2:
	Run, %A_Scriptdir%\Plugins2\%A_Thismenuitem%
Return

!c::	; na
   if(A_EventInfo=1) 
      { 
         currentClip=%clipboard% 
         currentClip_b=%clipboardall% 
         IfEqual,currentClip, %previousClip% 
            return 
         else 
            previousClip=%clipboard% 
      } 
   saveClip() 


	j+=1

	If j=1
		{
			ClipPrev:=Clipboard
			Clipboard:=ClipboardAll
		}

	If j>2
			j=1

   Return

savepopupclick:
	run, %name%
Return

restart:
	reload
return
exitscript:
	ExitApp
Return



;-----------------------
;----------TOASTER POPUP
;-----------------------
Toast(goto="", text="", title="", pos=1, align="Left", color="Default", size=11, font="Arial", life=5000, time=10)
	{
		;popup UI
		Gui, 99: Destroy
		Gui, 99: +Owner -SysMenu
		Gui, 99: font, s%size% w600 c%Color%, %font%
		Gui, 99: Add, text, x2  +%align% w222 g%Goto% , %text%
		Gui, 99: Show,x%A_ScreenWidth% y%A_ScreenHeight%, %title%
		Gosub, popup
		Return

popup:
	WinGetPos, , , Width, Height, %title%
	hy:=A_ScreenHeight-22


	If (pos=0)
			wx=0
	If (pos=1)
			wx=% A_ScreenWidth-Width

	SetTimer, life, %life%

	Loop, %time%
		{
			hy-=Height/time
			WinMove, %title%,, %wx%, %hy%
		}
Return

life:
	Gui, 99: Destroy
Return
}
 
;                                                                                                                     ;                  
;           author:Salvatore Agostino Romeo - romeo84@gmail.com                      
;                                                                                                                    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
/*                                                                                                                      
          kiu-clipSave - It keeps trace of last 20(or customize it) 
          text (or files) items copied on clipboard and                      
          shows them in a menu to quickly paste, edit                
          or save something later. Now you can choose 
          if to work in paste only mode, or paste/edit/save mode. 
          CTRL+WIN+C lets you switch between modes 
          
               New in version 0.8: 
               In Paste only mode: 
               -if you hold down CTRL while clicking on an item, you will edit that item 
               -if you hold down SHIFT key while clicking on an item you'll be able to save it. 
               -if you hold down LWIN key while clicking on an item you'll be able to preview it 
                on a tooltip(press LButton to unshow the tooltip) 
                                                                   
          Version: 0.8                                                                              
          License:GPL                                                                                  
          Note: sub-project of kiu-radialM                                                
*/                                                                                                                      
^#c::	; na
   if(toggleMode()) 
      pom=enabled 
   else 
      pom=disabled 
return 

pom: 
   pom=enabled 
return 

pesm: 
   pom=disabled 
return 

clipMenu() 
   { 
      global 
      startIndex:=clipIndex 
      Menu,History,add 
      Menu,History,DeleteAll 
      Loop,%numberOfElements% 
         { 
            zero= 
            puntini= 
            if(StrLen(startIndex)=1) 
               zero=0 
            FileReadLine, filec, data\%zero%%startIndex%.txt, 1 
            FileReadLine, filec, data\%zero%%startIndex%.txt, 1 
            if(StrLen(filec)>35) 
               { 
                        toCut:=StrLen(filec)-18 
                        StringMid, itemTemp1, filec, 1, 12 
                  StringTrimLeft, itemTemp2, filec, %toCut% 
                  itemTemp=%itemTemp1%...%itemTemp2% 
                     } 
            else 
               itemTemp=%filec% 
            if(A_Index<10)    
               Menu,History,add,%A_Space%%A_Space%%A_Index%. %itemTemp%,clipSelect 
            else 
               Menu,History,add,%A_Index%. %itemTemp%,clipSelect 
            startIndex-- 
            if(startIndex=0) 
               startIndex:=numberOfElements 
         } 
      Menu,History,add 
      Menu,HistorySaved,add 
         Menu,HistorySaved,deleteAll 
         Loop,data\saved\*.txt                
               { 
                  if(StrLen(A_Index)=1) 
               zero=0 
                  Menu,HistorySaved,add,%zero%%A_Index%. %A_LoopFileName%,clipSaved 
               } 

         Menu,History,add,Saved Clips, :HistorySaved 
      return 
   } 
saveClip() 
   { 
      global 
         currentIndex() 
      FileDelete, data\%clipIndex%.txt 
      FileAppend, %currentClip%, data\%clipIndex%.txt 
      FileDelete, data\%clipIndex%_b.txt 
      FileAppend, %currentClip_b%, data\%clipIndex%_b.txt 
      return 
   } 
;index of the clip.This is done to implement a sort of queue structure 
currentIndex() 
   { 
      global 
      clipIndex++ 
      If(clipIndex=21) 
         clipIndex=1 
      if(StrLen(clipIndex)=1) 
         clipIndex=0%clipIndex% 
      return 
   } 

Cancel: 
return    

clipSaved: 
   StringTrimLeft, OutputVar, A_ThisMenuItem, 4 
   Run,data\saved\%OutputVar% 
return 
clipSelect: 
   if(pom="enabled") 
      { 
         clipSelectedItemPos:= A_ThisMenuItemPos 
         goto,clipPaste 
      } 
   else 
      { 
         MouseGetPos, x, y 
         clipSelectedItemPos:= A_ThisMenuItemPos 
         inX:=x-25 
         inY:=y-10 
         Menu,History2,show, %inX%, %inY% 
      } 
return 
;when pressing an item of a menu 
clipPaste: 
   fileNum := clipIndex - clipSelectedItemPos + 1 
   if(fileNum < 0) 
      fileNum := numberOfElements + fileNum 
  if(StrLen(fileNum)=1) 
         fileNum=0%fileNum% 
   selection=%A_ThisMenuItemPos% 
   if(pom="enabled") 
   { 
         if(GetKeyState("CTRL" , "P")) 
           { 
              Run,data\%fileNum%.txt 
              return 
           } 
         if(GetKeyState("Shift" , "P")) 
           { 
              InputBox, name, Name of the clip, Select the name for the clip 
              FileCopy,data\%fileNum%.txt,data\saved\%name%.txt 
              return 
           } 
         if(GetKeyState("LWIN" , "P")) 
           { 
              FileRead, content, data\%fileNum%.txt 
              tooltip, %content% 
              KeyWait, LButton, D 
              tooltip, 
              return 
           } 
    } 
    else 
      {    
         if(selection=2) 
            { 
               Run,data\%fileNum%.txt 
               return 
            } 
         if(selection=3) 
            { 
               InputBox, name, Name of the clip, Select the name for the clip 
               FileCopy,data\%fileNum%.txt,data\saved\%name%.txt 
               return 
            } 
      } 
  FileRead, clip, data\%fileNum%.txt 
  clipboard= 
  clipboard=%clip% 
  Send,^v 
  SetTitleMatchMode, 2   
  IfWinExist, xplore 
         IfWinActive, xplore 
            { 
               FileRead,clip_b, *c data\%fileNum%_b.txt 
               clipboard=%clip_b% 
               Send,^v 
            } 
   IfWinExist, ahk_class ExploreWClass 
         IfWinActive, ahk_class ExploreWClass 
            { 
               FileRead,clip_b, *c data\%fileNum%_b.txt 
               clipboard=%clip_b% 
               Send,^v 
            } 
return 

toggleMode() 
{ 
 static m 
 m := !m 
 Return, m 
} 


features: 
msgbox, 
( 
Clipboardmenu's features: 
The hotkey to show the menu is WIN+SPACE . 
To paste an item simple click that item in the menu. If you hold down CTRL while clicking 
on an item, you will edit that item. If you hold down SHIFT key while clicking on an item 
you'll be able to save it. 

ClipboardMenu support another working mode called Paste/Edit/Save mode. 
This will let you paste/edit/save your clips using mouse only. 
The hotkey to switch between modes is CTRL+WIN+C . 

To work with paste/edit/save mode(PES mode) select this mode 
from tray menu or use the hotkey. Then, when selecting an item 
from clipboard menu, another menu will let you past, edit or 
save that item. To quickly paste an item in PES mode, just 
double click that item. 

If you copy a file: in explorer you will paste the file, 
in an editor you will paste the file path 
) 
return 

exitapplication: 
exitapp 
return


nil:
return


sortaz: ;line by line alpha sort
 

;if not ErrorLevel  ; Successfully loaded.
;{
;    Sort, Contents
;    msgbox, %contents%
;    Contents =  ; Free the memory.
;}
;
	Sort, selText
	clipboard:=selText
	Contents =  ; Free the memory.
		tooltip,%Clipboard%
	keywait, Lbutton, D ,t3
		tooltip,
return
sortazNumeric: ;line by line alpha sort

 
    Sort, selText,n
    clipboard:=selText
    Contents =  ; Free the memory.

		tooltip,%Clipboard%
	keywait, Lbutton, D ,t3
		tooltip,
return

sortza:
  
    Sort, selText,r 
    clipboard:=selText
    Contents =  ; Free the memory.

		tooltip,%Clipboard%
	keywait, Lbutton, D ,t3
		tooltip,
return
sortzaNumeric: ;line by line alpha sort
 
    Sort, selText,N R
    clipboard:=selText
    Contents =  ; Free the memory.

		tooltip,%Clipboard%
	keywait, Lbutton, D ,t3
		tooltip,
return

sortrandom:
 
    Sort, selText,random
    clipboard:=selText
    Contents =  ; Free the memory.

		tooltip,%Clipboard%
	keywait, Lbutton, D ,t3
		tooltip,
return

;	;	;	;	;	;	;	;	;

;
;

;	;	;	;	;	;	;	;	;	;	;	;	;	;	;	;


RAlt::	; na
selText:=Get_Selected_Text()
If seltext is space   
   {
   }
   else
   {
	previousClip3:=previousClip2
	previousClip2:=previousClip1
	previousClip1:=previousClip0
	previousClip0:=selText
	}
clipMenu() 
smartsel1()
	winget, pid, PID, A
		Menu, clipmenu, Show
return

>!AppsKey::	; na
smartsel()
Menu,smartsel,show

return

; AppsKey::	; na
tooltip,apps
sleep,1000
tooltip,
;send {appskey}
return

#AppsKey::	; na
	;hotkey1=%A_ThisHotkey% 
	hotkey1=appskey
	counter1:=1000
	Loop,10
	{
		
		Sleep,100
		counter1-=100	
		If (showstatus=1) AND (a_index>0)
			{
			If (counter1>600)
				{
					; ToolTip,%hotkey1% in %counter1% ms =	
					ToolTip, %counter1%  all	
				}
				else if (counter1>0)
				{
					; ToolTip,%hotkey1% in %counter1% ms	 
					ToolTip, %counter1%  second
				}	
			}	
			GetKeyState,state1,%hotkey1%,P		
			If state1=U
				Break
	}
	
	If showstatus=1
	  ToolTip,
	If counter1=0
	  {
		msgbox, last
	  }
	else  
	If counter1<600
	{
	   msgbox, ssecond last
	}
	else  
	{		 
		; gosub,run_selected_text
	}	 
Return

#/::	; rwin menu
hotkey1=rwin

	counter1:=1000
	Loop,10
	{	
		Sleep,60
		counter1-=100	
		If (showstatus=1) AND (a_index>0)
			{
				If (counter1>600)
						{
						; ToolTip,%hotkey1% in %counter1% ms =	
						ToolTip, %counter1%  all	
						}
					else if (counter1>0)
						{
						; ToolTip,%hotkey1% in %counter1% ms	 
						ToolTip, %counter1%  second
						}	
			}	
			GetKeyState,state1,%hotkey1%,P		
			If state1=U
				Break
	}
	
	If showstatus=1
	  ToolTip,
	If counter1=0
	  {
		msgbox, last
	  }
	else  
	If counter1<600
	{
	   msgbox, ssecond last
	}
	else  
	{		 
		Menu,MyMenu,Show
	}	 
Return

>#o::	; na
hotkey1=rwin

	counter1:=1000
	Loop,10
	{	
		Sleep,100
		counter1-=100	
		If (showstatus=1) AND (a_index>1)
			{
				If (counter1>600)
					{
					; ToolTip,%hotkey1% in %counter1% ms =	
					ToolTip, %counter1%  all	
					}
					else if (counter1>0)
					{
					; ToolTip,%hotkey1% in %counter1% ms	 
					ToolTip, %counter1%  second
					}	
			}	
			GetKeyState,state1,%hotkey1%,P		
			If state1=U
				Break
	}
	
	If showstatus=1
	  ToolTip,
	If counter1=0
	  {
		msgbox, third
	  }
	else  
	If counter1<600
	{
	   msgbox, second 
	}
	else  
	{		 
		msgbox, first
	}	 
Return


 


AppsKey & enter::	; na
PutText("`r`n")
Return

AppsKey & tab::	; na
PutText("`t")
Return

AppsKey & Left::	; na
MouseMove, -1, 0, 0, R
If GetKeyState("ctrl")
{
send, {lbutton}
}
return

AppsKey & Right::	; na
MouseMove, 1, 0, 0, R
If GetKeyState("ctrl")
{
	send, {lbutton}
}
return

AppsKey & Up::	; na
	; GetKeyState, state_c, ctrl
		; if state_c = D 
		{
		; MouseClickDrag , L, , ,-1,-1,, R
		MouseClickDrag, Left, , , 0, -10, , R 
		tooltip ,sss
		sleep,100
		tooltip , 
		}
	; else
		; MouseMove, 0, -1, 0, R
return

AppsKey & Down::MouseMove, 0, 1, 0, R

AppsKey & Insert::	; na
TempText := GetText()
TempText := RegExReplace(TempText, "^\s+|\s+$") ;trim whitespace
If RegExMatch(TempText, "\w\.[a-zA-Z]+(/|$)") ;contains .com etc
{
   If SubStr(TempText, 1, 4) != "http"
      TempText := "http://" . TempText
}
Else
{
   If InStr(TempText, " ")
   {
      StringReplace TempText, TempText, %A_Space%, +
      TempText := "%22" . TempText . "%22"
   }
   TempText := "http://www.google.com/search?&q=" . TempText
}
Run %BrowserPath% %TempText%
Return


AppsKey & CapsLock::	; na
GetText(TempText)
If NOT ERRORLEVEL
   Menu Case, Show
Return



AppsKey & F1::	; na
IfWinExist AutoHotkey_L Help
   WinActivate AutoHotkey_L Help
Else
{
   SplitPath A_AhkPath, , TempText
   Run %TempText%\AutoHotkey.chm
}
Return

AppsKey & F4::	; na
MyWin := WinExist("A")
WinGetTitle TempText, ahk_id %MyWin%
If NOT TempText ;Prevents terminated the taskbar, or the like.
   Return
If NOT GetKeyState("shift")
{
   WinGetTitle TempText, ahk_id %MyWin%
   MsgBox 49, Terminate!, Terminate "%TempText%"?`nUnsaved data will be lost.
   IfMsgBox Cancel
      Return
}
WinGet MyPID, PID, ahk_id %MyWin%
Process, Close, %MyPID%
Return

AppsKey & RWin::	; na
AppsKey & LWin::	; na
Hotkey RWin, DoNothing, On
Hotkey LWin, DoNothing, On
Return
;;;;;;;;;;;
Lwin & RWin::	; na
Rwin & LWin::	; na
Hotkey RWin, DoNothing, Off
Hotkey LWin, DoNothing, Off
Return
DoNothing:
Return

AppsKey & a::	; na
If NOT IsWindow(WinExist("A"))
   Return
WinGetTitle, TempText, A
If GetKeyState("shift")
{
   WinSet AlwaysOnTop, Off, A
   If (SubStr(TempText, 1, 2) = "† ")
      TempText := SubStr(TempText, 3)
}
else
{
   WinSet AlwaysOnTop, On, A
   If (SubStr(TempText, 1, 2) != "† ")
      TempText := "† " . TempText ;chr(134)
}
WinSetTitle, A, , %TempText%
Return

AppsKey & b::	; na
	SendMessage, 0x112, 0xF170, 1,, Program Manager
	Sleep 1000
	SendMessage, 0x112, 0xF170, 1,, Program Manager
Return


AppsKey & p::	; na
	Drive Eject,, % GetKeyState("shift")
Return
;%%%%%%%%%%%%%%%


; AppsKey & h::	;	Hides the active window.
If GetKeyState("shift")
{
   Loop Parse, HiddenWins, |
      WinShow ahk_id %A_LoopField%
   HiddenWins =
}
else
{
   MyWin := WinExist("A")
   if IsWindow(MyWin) 
   {
      HiddenWins .= (HiddenWins ? "|" : "") . MyWin
      WinHide ahk_id %MyWin%
      GroupActivate All
   }
}
Return

AppsKey & l::	; na
TempText := GetText()
If FileExist(TempText)
   Run %A_AhkPath% "%TempText%"
Else
   MsgBox Before using this command, select the .ahk file you wish to run in windows explorer.
Return

AppsKey & r::	;	Reloads this script.
KeyWait AppsKey
IfWinActive %A_ScriptName%
   Send ^s ;Save
Reload 
Return

AppsKey & t::	;	 50% transpartent.
If NOT IsWindow(WinExist("A"))
   Return
If GetKeyState("shift")
   Winset, Transparent, OFF, A
else
   Winset, Transparent, 128, A
Return

AppsKey & v::	; na
TempText := ClipBoard
If (TempText != "")
   PutText(ClipBoard)
Return

AppsKey & w::	;	Wraps text
GetText(TempText)
If NOT WrapWidth
   WrapWidth := "70"
If GetKeyState("shift")
   StringReplace TempText, TempText, %A_Space%`r`n, %A_Space%, All
else
{
   Temp2 := SafeInput("Enter Width", "Width:", WrapWidth)
   If ErrorLevel
      Return
   WrapWidth := Temp2
   Temp2 := "(?=.{" . WrapWidth + 1 . ",})(.{1," . WrapWidth - 1 . "}[^ ]) +"
   TempText := RegExReplace(TempText, Temp2, "$1 `r`n")
}
PutText(TempText)
Return

; AppsKey & x::	;	Shutdown
SplashImage, , MC01, (S) Shutdown`n(R) Restart`n(L) Log Off`n(H) Hibernate`n(P) Power Saving Mode`n`nPress ESC to cancel., Press A Key:, Shutdown?, Courier New
Input TempText, L1
SplashImage, Off
If (TempText = "S")
   ShutDown 8
Else If (TempText = "R")
   ShutDown 2
Else If (TempText = "L")
   ShutDown 0
Else If (TempText = "H")
   DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)
Else If (TempText = "P")
   DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
Return

AppsKey & /::	; RegEx Replace
TempText := SafeInput("Enter Pattern", "RegEx Pattern:", REPatern)
If ErrorLevel
   Return
Temp2 := SafeInput("Enter Replacement", "Replacement:", REReplacement)
If ErrorLevel
   Return
REPatern := TempText
REReplacement := Temp2
GetText(TempText)
TempText := RegExReplace(TempText, REPatern, REReplacement)
PutText(TempText)
Return

AppsKey & ,::	; na
TempText := SafeInput("Enter Tag", "Example: a href=""http://www.autohotkey.com/""", HTFormat)
If ErrorLevel
   Return
If SubStr(TempText, 1, 4) = "http"
   TempText = a href="%TempText%"
HTFormat := TempText
GetText(Temp2)
Temp2 := "<" . TempText . ">" . Temp2
TempText := RegExReplace(TempText, " .*")
Temp2 := Temp2 . "</" . TempText . ">"
PutText(Temp2)
Return

AppsKey & [::	;	html color
TempText := SafeInput("Enter Tag", "Example: color=red", BBFormat)
If ErrorLevel
   Return
If SubStr(TempText, 1, 4) = "http"
   TempText = url=%TempText%
BBFormat := TempText
GetText(Temp2)
If SubStr(TempText, 1, 4) = "list" AND NOT InStr(Temp2, "[*]")
   Temp2 := RegExReplace(Temp2, "m`a)^(\*\s*)?", "[*]")
Temp2 := "[" . TempText . "]" . Temp2
TempText := RegExReplace(TempText, "=.*")
Temp2 := Temp2 . "[/" . TempText . "]"
PutText(Temp2)
Return

AppsKey & `;::	;	Comment or uncomment AutoHotkey code
GetText(TempText)
If (SubStr(TempText, 1, 1) = ";")
   TempText := RegExReplace(TempText, "`am)^;")
Else
   TempText := RegExReplace(TempText, "`am)^", ";")
PutText(TempText)
Return


FixLinebreaks:
{
GetText(TempText)
  TempText := RegExReplace(TempText, "\R", "`r`n")
  PutText(TempText)
}
Return

Reverse:
{
GetText(TempText)
   Temp2 =
   StringReplace, TempText, TempText, `r`n, % Chr(29), All
   Loop Parse, TempText
      Temp2 := A_LoopField . Temp2
   StringReplace, TempText, Temp2, % Chr(29), `r`n, All
}
PutText(TempText)
Return
*/
;******************************************************************************

; Handy function.
; Copies the selected text to a variable while preserving the clipboard.
GetText(ByRef MyText = "")
{
   SavedClip := ClipboardAll
   Clipboard =
   Send ^c
   ClipWait 0.5
   If ERRORLEVEL
   {
      Clipboard := SavedClip
      MyText =
      Return
   }
   MyText := Clipboard
   Clipboard := SavedClip
   Return MyText
}

; Pastes text from a variable while preserving the clipboard.
PutText(MyText)
{
   SavedClip := ClipboardAll 
   Clipboard =              ; For better compatability
   Sleep 20                 ; with Clipboard History
   Clipboard := MyText
   Send ^v
   Sleep 100
   Clipboard := SavedClip
   Return
}

;This makes sure sure the same window stays active after showing the InputBox.
;Otherwise you might get the text pasted into another window unexpectedly.
SafeInput(Title, Prompt, Default = "")
{
   ActiveWin := WinExist("A")
   InputBox OutPut, %Title%, %Prompt%,,, 120,,,,, %Default%
   WinActivate ahk_id %ActiveWin%
   Return OutPut
}

;This checks if a window is, in fact a window.
;As opposed to the desktop or a menu, etc.
IsWindow(hwnd) 
{
   WinGet, s, Style, ahk_id %hwnd% 
   return s & 0xC00000 ? (s & 0x80000000 ? 0 : 1) : 0
   ;WS_CAPTION AND !WS_POPUP(for tooltips etc) 
}


 
return
;	==========================================================================
;	==========================================================================
appskey & d::	;	add to 2 do.txt
	GetKeyState, state_s, Shift
	; Send {Shift up}
	UserInput:=Get_Selected_Text()
	TaskMessage2:=UserInput
	if state_s = D ; 
	{
		gui,AddGui: destroy
		Gui, AddGui: +alwaysontop
		Gui, AddGui: Font, S10 CDefault, 
		Gui, AddGui: Add, Edit, x12 y14 w400 r1 vTaskMessage,title
		Gui, AddGui: Add, Edit, x12 y+5 w400 r8 vTaskMessage2,%TaskMessage2%
		Gui, AddGui: Add, Button, x82 y+20 w100 h30 vDoneGoonB gadd_to_do , Done && Go on
		Gui, AddGui: Add, Button, x+25 yp w100 h30 gadd_to_do_run , open
		gui,AddGui: show,,add task
		guicontrol,AddGui: focus,TaskMessage2
			
			; InputBox, UserInput, add entry 2 do, enter the task, , 640, 140,,,,,%UserInput%
			; if ErrorLevel
		return
	}
	else
	gosub,add_to_do
return

add_to_do_run:
	run,2 do.txt
return

add_to_do:
	gui,submit
	; gui,AddGui: hide
	If TaskMessage2 is space 	
		return
	FileAppend, `n`n%TaskMessage2%,  2 do.txt 
	if ErrorLevel=0
		tooltip,to do:`n%TaskMessage2%
	sleep,1100 
	tooltip,

return 
<^+y::	; to do GUI
fileread,todo_text,2 do.txt
gui,AddGui: destroy
		Gui, AddGui: +alwaysontop
		Gui, AddGui: Font, S10 CDefault, 
		Gui, AddGui: Add, Edit, x12 y14 w400 r1 vTaskMessage,
		Gui, AddGui: Add, Edit, x12 y+5 w400 r15 vTaskMessage2,%todo_text%
		; Gui, AddGui: Add, Button, x82 y+20 w100 h30 vDoneGoonB gadd_to_do , Done && Go on
		; Gui, AddGui: Add, Button, x+25 yp w100 h30 gadd_to_do_run , open
		gui,AddGui: show,,add task
		sleep,100
		guiControl,AddGui: Focus, TaskMessage2                    ;assuming your edit control is edit1 and your window is test
		sleep,200
send, ^{end}
			
			
return
;	==========================================================================
;	==========================================================================

appskey & F8::	;	add to collection
GetKeyState, state_s, Shift
	text2:=Get_Selected_Text()
 If text2 is space 	
 return
if state_s = D ; 
	{
	InputBox, UserInput, add to collection.txt,enter details, , 640, 140,,,,,%text2%
	
	if ErrorLevel
		return
	}	
	FileAppend, `n`n%text2%,data\collection.txt 
if ErrorLevel=0
 tooltip,to coll:`n`n%text2%
sleep,800 
tooltip,
return 

/*
Get_Selected_Text()  
{
   WinGetActiveTitle, OutputVar 
   If OutputVar is space   
   {
      seltext =
      Goto , End
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
   End:
   
   Return , seltext      ; Search term now stored and ready
}
return
*/
AppsKey & e::	;	run,notepad
	run,notepad
	return




AppsKey & c::	;	run,calc
	IfWinExist ahk_class CalcFrame
	   WinActivate ahk_class CalcFrame
	Else
	{   
	 Run ,calc
	}
Return

<^!0::	;run in  notepad++
id=
	WinGetTitle, id , ahk_pid %pid%
	IfInString,id, - Notepad++
		StringTrimright,id,id,12
	IfInString,id,*
		StringTrimleft,id,id,1
	tooltip, Run`n%id%
	sleep,1000
	run %id%
	tooltip
Return


smartsel1()
{

menu,smartsel1,deleteall
Menu, smartsel1, add, &S    Google search, google
Menu, smartsel1, add, &T    Google Image search, googleimage

menu,smartsel1,add,site:,nil
menu,smartsel1,add,go to,nil

}
Return
smartsel()
{

menu,smartsel,delete
menu,smartsel,add,sum,nil
menu,smartsel,add,diff ,nil
menu,smartsel,add,product,nil
menu,smartsel,add,a/b= b/a= ,nil
menu,smartsel,add,
menu,smartsel,add,$=rs ,nil

}
Return


/*
; <^!a::	;	sort,clipboard,
sort,clipboard,D%A_space%
tooltip,%clipboard%
settimer,removetooltip,-700
return

; <^!z::	;	sort,clipboard,
sort,clipboard,R D%A_space%
tooltip,%clipboard%
settimer,removetooltip,-700
return


; <^+a::	;	sort,clipboard,
sort,clipboard,
tooltip,ascending`n`n%clipboard%
settimer,removetooltip,-700
return


; <^+z::	;	sort,clipboard,
sort,clipboard,R
tooltip,%clipboard%
settimer,removetooltip,-700
return
*/

<^+s::	;	sort,clipboard

	; count++
	; tooltip,%count%`nprev= %A_PriorHotKey% fired

	; if (A_PriorHotKey = "^!a")	;	 AND A_TimeSincePriorHotkey < 4000)
	if (HotkeySTEP)	;	if hotkey is currntly running
	{
		if options= 
			{
				options=R
				msg=Z -> A
			}
		else if (options="R")
			{
				options=N
				msg=numeric
			}
		else if (options="N")
			{
				options=U
				msg=A -> Z removed duplicates
			}
		else if (options="U")
			{
				options=Random
				msg=Random
			}
		else
			{
				options=
				msg=A -> Z
			}
	}
	else
	{
		options=
		msg=A -> Z
	}	
	HotkeySTEP:=1
	hotkey,^q,on
	setTimer,HotkeySTEP,70	

	seltext:=clipboard
	seltext:=regexreplace(seltext,"^(\s)*\n","") ;remove first lines with white spaces only (include blank lines in beginning)
	seltext:=regexreplace(seltext,"(*ANYCRLF)\n*(\s)*$", "")	;remove last blank lines
	newline:=0

	Loop, Parse, seltext, `n,`r
		newline++
	if (newline<2)
	{
		ifinstring,seltext,`,
			{
			sort,seltext,%options% D`,
			delimiter=comma
			}
		else ifinstring , seltext,%A_Space% 
			{
			sort,seltext,%options% D%A_space%
			delimiter=space
			}
	}
	else
	{
		sort,seltext,%options% 
		delimiter=line
	}

	Sleep 0
	tooltip,%msg% (%delimiter%)`n%seltext%
	settimer,removetooltip,-4500
	sleep,10
return

HotkeySTEP:
	GetKeyState,state,CTRL
	If state=u
	{
		setTimer,HotkeySTEP,off
		HotkeySTEP:=0
		hotkey,^q,off
		tooltip,%msg%`n%seltext%`ncopied
		settimer,removetooltip,-600
		clipboard:=seltext
	}
return



textAZ:
	sort,clipboard,
	tooltip,Z A`n`n%clipboard%
	settimer,removetooltip,-700
	guicontrol 3:,clipboardEDIT, %clipboard%
return

textAZ_space:
	sort,clipboard, D%A_space%
	tooltip,%clipboard%
	settimer,removetooltip,-700
	guicontrol 3:,clipboardEDIT, %clipboard%
return

textZA:
	sort,clipboard,R
	tooltip,%clipboard%
	settimer,removetooltip,-700
	guicontrol 3:,clipboardEDIT, %clipboard%
return


textZA_space:
	sort,clipboard,R D%A_space%
	tooltip,%clipboard%
	settimer,removetooltip,-700
	guicontrol 3:,clipboardEDIT, %clipboard%
return


randomText_space:
	sort,clipboard,Random D%A_space%

	guicontrol 3:,clipboardEDIT, %clipboard%

return

randomText:
	sort,clipboard,Random 

	guicontrol 3:,clipboardEDIT, %clipboard%

return

$^q::	;	cancel
	if ( (HotkeySTEP)	or  (HotkeySTEP2)  )
	{
		setTimer,HotkeySTEP,off
		HotkeySTEP:=0
		
		setTimer,HotkeySTEP2,off
		HotkeySTEP2:=0
		
		
		tooltip,cancel
		settimer,removetooltip,-600
		
		hotkey,^q,off
}
else
{
	send ^q
}
return


<^+u::	;ucase
; selText:=clipboard
; gosub,ucase
	seltext:=clipboard
	if (HotkeySTEP2)	;	 AND A_TimeSincePriorHotkey < 4000)
	{
		if HotkeySTEP2_count=0
			{
				HotkeySTEP2_count=1
				action213=lcase
				msg=lower case
				Stringlower, selText, selText
			}
		else if HotkeySTEP2_count=1
			{
				HotkeySTEP2_count=2
				action213=tcase
				msg=t case
				StringUpper, selText, selText, T 
			}
		else if HotkeySTEP2_count=2
			{
				HotkeySTEP2_count=3
				action213=scase
				msg=sentence case XXXX
				selText := RegExReplace(selText, "([.?\s!]\s\w)|^(\.\s\b\w)|^(.)", "$U0")
			}
		else if HotkeySTEP2_count=3
			{
				HotkeySTEP2_count=0
				action213=ucase
				msg=ucase
				StringUpper, selText, selText
			}
			
	}
	else
	{
		StringLower, string2, seltext
		; if all are lower directly convert to upper
		if (regexmatch(seltext,string2))
		{
			HotkeySTEP2_count=0
			action213=ucase
			msg=ucase
			StringUpper, selText, selText
		}
		else
		{
			HotkeySTEP2_count=1
			action213=lcase
			msg=lcase
			StringLower, selText, selText
		}

	}
	sleep,20
	HotkeySTEP2:=1
	hotkey,^q,on
	setTimer,HotkeySTEP2,70		
	tooltip,%msg%`n%selText%
	settimer,removetooltip,-4500
	sleep,10
return

HotkeySTEP2:
	GetKeyState,state,CTRL
	If state=u
	{
		setTimer,HotkeySTEP2,off
		HotkeySTEP2:=0
		hotkey,^q,off
		text:=truncated_text(seltext,220)
		tooltip,%msg%`ncopied  ENTER To SEND`n%text%
		settimer,removetooltip,-3000
		clipboard:=seltext
		Input, UserInput, T3 L1 C, {enter}.{esc}{tab}, a,b
		tooltip,
		If InStr(ErrorLevel, "EndKey:enter")
		{	
			send, ^v
		}
	}
return



return

; <^+l::	; na
selText:=clipboard
gosub,lcase
 
return

; ^+n::	;sort,clipboard,numeric
sort,clipboard,N
tooltip,%clipboard%
settimer,removetooltip,-700
return

; ^+t::	;	title case
selText:=clipboard
gosub,tcase
 
return

; ^+s::	;	sentence case
selText:=clipboard
gosub,scase
 
return

; ^+b::	; na
Text:=clipboard
text:=regexreplace(text,"\R", " ")
clipboard:=text
tooltip,%clipboard%
settimer,removetooltip,-1000
return


; ^!b::	;space to line
Text:=clipboard
; text:=regexreplace(text," ","`r`n")
StringReplace, text, text, %A_Space%, `r`n, All
clipboard:=text
tooltip,%clipboard%
settimer,removetooltip,-1000
return


; ^+c::	;clean clipboard whitespaces



	Text:=clipboard
	text := RegExReplace(text, "m`n)^[ \t]+", "")	;lesding 
	text := RegExReplace(text, "m`n)[ \t]+$","")		;trailing

	; DBLblankLIMITER=\R\R
	; text:=regexreplace(text, "(" DBLblankLIMITER ")+", "$1")

	DBLblankLIMITER=\s\s
	text:=regexreplace(text, "(" DBLblankLIMITER ")+", "$1")

	StringReplace, text, text, %A_Tab%,%A_Space%,  All
	clipboard:=text
	tooltip,%clipboard%`n`n^+c::	clean clipboard whitespaces`n^+'::	 hard clean sel text `n^!c::	clipboardEDIT Gui
	settimer,removetooltip,-2500
return


<^+'::	; hard clean sel text 
	Contents:=Get_Selected_Text()
	Contents:=regexreplace(Contents,"^\n"," ")
	Contents:=regexreplace(Contents,"[`,-]", " ")
	Contents:= RegExReplace(Contents,  "[%\\\.\*?+[{|()^$]", " ")
	Contents:= RegExReplace(Contents,  "\s{2,}", " ") ;space
	clipboard:=contents
	tooltip,%clipboard%`n`n^+c::	clean clipboard whitespaces`n^+'::	 hard clean sel text `n^!c::	clipboardEDIT Gui
	settimer,removetooltip,-2500
return


; ^!c::	;	clipboardEDIT Gui
Gui, 3: Show, x347 y125 h400 w811,  
guicontrol 3:,clipboardEDIT, %clipboard%
return

removetooltip:
tooltip,
return

; advanced clipboard

advanced_clipbaoard_gui:
Gui, 3: -toolwindow +AlwaysOnTop  -caption  +border   +LastFound 

Gui, 3: Add, Button, x182 y30 w100 h30 grandomText, random
Gui, 3: Add, Button, x292 y30 w100 h30 grandomText_space , random sp
Gui, 3: Add, Button, x+0 y30 w100 h30 gtextAZ, a z
Gui, 3: Add, Button, x+0 y30 w100 h30 gtextAZ_space, a z space
Gui, 3: Add, Button, x+0 y30 w100 h30 gtextZA, z a
Gui, 3: Add, Button, x+0 y30 w100 h30 gtextZA_space, z a space
Gui, 3: Add, Edit, x52 y80 w700 h280 vclipboardEDIT , %clipboard%
Gui, 3: Add, Button, xp y+3 w100 h30 ghide3, hide
 

return
hide3:

gui, 3: hide
return

