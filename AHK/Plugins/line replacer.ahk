SplitPath, A_ScriptDir , , , , , A_Script_Drive
#maxmem 128
#NoEnv
#SingleInstance Force
; Hotkey, *rshift ,, p1
ifexist,replacer.ico
	menu, Tray, Icon, replacer.ico
else
	menu, Tray, Icon, Shell32.dll, 33
RemoveIcon := "shell32.dll:" 131
;default script

Script1=
(
`; reg=im)^[\w\.]+@[a-zA-Z_0-9\.-]+?\.[a-zA-Z]{2,3}$
reg=im)^(.*)$
replace=$1
output=
output2=
`; regexmatch(a_loopfield,reg)
loop,parse,text,``n,``r
{
	this:=a_loopfield
	this:=regexreplace(a_loopfield,reg,replace)
	output .= this "``n"
	
	`; if (regexmatch(a_loopfield,reg))
	`;	output .= this "``n"
	`; else
	`;	output2 .= this "``n"
}

text := output
)

Script2=
(
output=
Loop, parse,text,``n,``r
{
    
    Loop, parse, A_LoopField, CSV
    {
      if a_Index=1
       output .= "field1= " . A_LoopField  . "``n" 
      else if a_Index=2
       output .= "field2= " . A_LoopField  . "``n" 
      else
       output .= "field" . a_index . " = " . A_LoopField  . "``n" 
          

    }
    output .=  "``n``n"
    
}

text := output
)

Script3=
(
`; reg=im)^[\w\.]+@[a-zA-Z_0-9\.-]+?\.[a-zA-Z]{2,3}$
reg=im)^(.*)$
replace=$1
output=
output2=
`; regexmatch(a_loopfield,reg)
loop,parse,text,``n,``r
{
  this:=a_loopfield
  this:=regexreplace(a_loopfield,reg,replace)
  output .= this "``n"
  
  `; if (regexmatch(a_loopfield,reg))
  `;  output .= this "``n"
  `; else
  `;  output2 .= this "``n"
}
text := output
)
menu,script_menu,add,default,script_menu_select
menu,script_menu,add,csv,script_menu_select
menu,script_menu,add,parsing,script_menu_select
menu,script_menu,add,csv,script_menu_select

#include C:\cbn_gits\AHK\LIB\misc functions.ahk
#include C:\cbn_gits\AHK\LIB\para.ahk
#include C:\cbn_gits\AHK\LIB\cbn.ahk
#include C:\cbn_gits\AHK\LIB\tf.ahk
gosub,initialSetup
Gui, +AlwaysOnTop   -caption +LastFound    +border +resize
Gui, Margin,0,0
Gui, font,  s10 comic sans
gui_ON:=0
shrink:=0
disabled=0
menu,menu1,add,
menu,menu1,add,d,nil
menu,menu1,add,D,nil
menu,menu1,add,w,nil
menu,menu1,add,W,nil

menu,menu2,add,
menu,menu2,add,d,nil
menu,menu2,add,D,nil
menu,menu2,add,w,nil
menu,menu2,add,W,nil

edit_fontSize:=10
Gui, Font, s10 ,comic sans

gui,add,button,x0 y0 w40 h250 vshrinkbutton gShrink,O

Gui, Add, Button, x420 y6 w70 h30 gguiMax, max
Gui, Add, Button, x+2 y6 w60 h30   gclipPath,clipPath
Gui, Font, s14 cblack, 
Gui, Add, Edit, x117 y100 w180 h100 vedit1 t12 gpreview, 
Gui, Add, Edit, x306 y100 w170 h100 vedit2  t12 gpreview, 
Gui, Font, s10 cblack, 

Gui, Add, Button, x117 y75 w40 h25 gmenu1,x
Gui, Add, Button, x+5 y75 w40 h25 gpaste1,^v
Gui, Add, Button, x+5 y75 w40 h25 gmenu1, F
Gui, Add, Button, x310 y75 w40 h25 gmenu2,x
Gui, Add, Button, x+5 y75 w40 h25 gpaste2,^v
Gui, Add, Button, x+5 y75 w40 h25 gmenu2, R
Gui, Font, s13 cblack, 
; Gui, Add, CheckBox, cTeal x500 y45 w100 h20  gpreview vmultiline , multi line
Gui, Add, CheckBox, cblue x500 y45 w67 h25 vmatching gpreview, match
Gui, Add, CheckBox, cred x+4 yp   h25 gpreview vNONmatching, X
Gui, Add, CheckBox, cblue x500 y+1 w67 h25 gpreview vmatchingLines,..Line
Gui, Add, CheckBox,cred  x+4 yp   h25 gpreview vNONmatchingLines, X

Gui, Font, s9 cblack, 

Gui, Add,button,x500 y+2 w30 h35 vdisable gdisable,enabled
Gui, Add,button,x+4 yp w30 h35 hwndbutton5  gclearall,	;clear all
Gui, Add,button,x+4 yp w30 h35 gremove_dupes,dupe ;clear all
ILButton(button5, RemoveIcon, 32, 32, 5)	

;Gui, Add, Button, x500 y+5 w40 h25 gregexhelp,?
Gui, Add, Button, x500 y+5 w30 h25 gtrailing_leading, <>
Gui, Add, Button, x+0 yp w30 h25 gblanklines, blank
Gui, Add, Button, x+0 yp w30 h25 gblanklines2, dbl

Gui, Add, Button, x500 y+5 w34 h30 gclean,clean
Gui, Add, Button, x+0 yp w34 h30 gcleanALL,All
Gui, Add, Button, x+0 yp w34 h30 gcleancompact ,cmpc
Gui, Font, s%edit_fontSize% cblack, 
Gui, Add, Edit, x305 y260 w300 h240 -Wrap   +hscroll +wanttab vedit4  t12 gpreview, preview
Gui, Add, Edit, x2 y260 w300 h240 -Wrap +hscroll  +wanttab vedit3  t12 gpreview, haystack
Gui, Font, s10 cblack, 

Gui, Add, Button, x40 y0 w70 h40 gregexButton hwndmode_hwnd_4  vmode4, regex
Gui, Add, Button, x40 y+2 w70 h40 gREVvariantReplaceButton hwndmode_hwnd_6 vmode6,all to one
Gui, Add, Button, x40 y+2 w70 h40 glineReplaceButton hwndmode_hwnd_1 vmode1, Nth to Nth
Gui, Add, Button, x40 y+2 w70 h40 gvariantReplaceButton hwndmode_hwnd_2 vmode2, 1 to many
; Gui, Add, Button, x40 y+2 w70 h40 gincrementReplaceButton vmode3, * to count  
Gui, Add, Button, x40 y+2 w70 h40 gNseparateButton hwndmode_hwnd_5 vmode5, * to Nth	;generate n times the same text with separate replacement


Gui, Add, Button, x115 y0 w60 h25 vRegEx gregextoggle  hwndregextoggle_hwnd , regex off ;gRegEx,regexOFF
Gui, Add, Button, x+2 yp w60 h25 vMatchCase gcasetoggle, case off ;gMatchCase,MatchCaseOFF
Gui, Add, CheckBox, cTeal checked x+5 yp+5 w80 h20  gpreview vmultiline , multi line
Gui, Add, CheckBox, cTeal  x+0 yp w85 h20  gpreview vifANYCRLF , ANYCRLF

Gui, Add, Button, x250 y75 w50 h25 hwndclearbutton2 gclearFind, clear 
ILButton(clearbutton2, "shell32.dll:" 131, 20, 20, 5)

Gui, Add, StatusBar, x12 y660 w670 h20 vstatus2, search string

Gui, Font, s9 cblack, 
Gui, Add, text, x5 y500 w300 h20   vstats1, Chars: `t Lines:
Gui, Add, text, x5 y+0 w300 h20    vstats, Chars: `t Lines:
Gui, Add, text, x5 y+0 w300 h20   cred  vstats3, Chars: `t Lines:

Gui, Font, s22 cgreen, 
Gui, Add, text, x5 y+10 w35 cgreen  vstats4, aa
Gui, Font, s10 cblack, 

Gui, Add, Button, x115 y210 w60 h40 hwndundo gUnDo,undo
ILButton(undo, "shell32.dll:" 146, 32, 32, 5)
Gui, Add, Button, x+2 y210 w60 h40 gclearEdit3,X
Gui, Add, Button, x+2 y210 w80 h40 hwndclearbutton gcc_swap_Clear,<---> & CLEAR
ILButton(clearbutton, "shell32.dll:" 132, 32, 32, 5)
Gui, Add, Button, x+2 y210 w80 h40 gcc_swap,<--->
Gui, Add, Button,  x+2 yp w40 h40 gpreview,Pre view
Gui, Add, Button, x+2 yp w40 h40 gtooltip, see
Gui, Add, Button, x+2 yp w30 h40 gfont_decr,<
Gui, Add, Button, x+0 yp w30 h40 gfont_incr,>
;Gui, Add, Edit, x852 y330 w250 h290 -Wrap +hscroll +wanttab voutput, Preview
Gui, Add, Button, x41 y540   w130 h40 hwndbutton4 vbutton4 ghide, H I D E
ILButton(button4, RemoveIcon, 32, 32, 5)	;
Gui, Add, Button, x+2 yp  w130 h40 vbutton1 gcc_PasteClose, PASTE n close
Gui, Add, Button, x+2 yp w130 h40 vbutton2 gcc_copy, Copy
Gui, Add, Button, x+2 yp  w130 h40 vbutton3 gcc_copyClose, Copy n close

mainTabNames=ADVANCED|ADD/REM|FORMAT|CLIPBOARD|SCRIPT|MORE
Gui, Font,
Gui, Font, s10 , 
;	remove font formats to display tab
Gui, 1:  Add, Tab2,x600 y0 w760 h258 vMyTab gTabSubSwitch hwndTabID TCS_BUTTONS TCS_HOTTRACK left  0x200 ,%mainTabNames% 

;;;;tab height
TCM_GETITEMRECT = 0x130A
TCM_SETITEMSIZE = 0x1329
TCS_HOTTRACK 	= 0x40 
    VarSetCapacity(Rect, 16, 0)
    SendMessage, TCM_GETITEMRECT, 0, &Rect,, ahk_id %TabID%
    H := NumGet(Rect, 12) - NumGet(Rect, 4)
Height = 28
SendMessage, TCM_SETITEMSIZE, 0, Height << 16,, ahk_id %TabID%
Gui +LastFound  ; Avoids the need to specify WinTitle below.
SendMessage, TCS_HOTTRACK , 0,0,

Gui, Tab,ADVANCED
Gui, Add, Button, x694 y+2 w60 h30 gXtoNx , refresh

Gui, Add, Button, x+4 yp gcommon,1minus 2
Gui, Add, Button, x+4 yp gcommonHide,show different
Gui, Add, CheckBox, x694 y+2   h20 cGreen gpreview vextract_fileNames ,extract_fileNames
Gui, Add, CheckBox, x+4 yp   h20 cGreen gpreview vextract_fileNames2  ,fileNames with ext
Gui, Add, CheckBox, x+4 yp   h20 cGreen gpreview vextract_fileNames6  ,fileNames with sel ext

Gui, Add, CheckBox, x+4 yp   h20 cGreen gpreview vextract_fileNames3  ,Parent_path
Gui, Add, CheckBox, x694 y+4   h20 cGreen gpreview vextract_fileNames4  ,Parent name only
Gui, Add, CheckBox, x+4 yp   h20 cGreen gpreview vextract_fileNames5  ,name only
Gui, Add, CheckBox, x+4 yp h20 cGreen gpreview vextract_fileNames7  ,date
Gui, Add, CheckBox, x+4 yp h20 cGreen gpreview vextract_fileNames8  ,email

Gui, Add, button, x694 y+10 h35  gtext_statistics   ,text statistics
Gui, Add, CheckBox, x694 y+5   h20 cGreen   vc2c1,convert2csv
Gui, Add, Edit,x+5 yp   h25 w50 cPurple vc2cedit1 ,5

Gui, Add, CheckBox, x694 y+5   h20 cGreen   vcbn_text,cbn_text
Gui, Add, CheckBox, x+4 yp   h20 cGreen   vcbn_text_rev,rev cbn_text

Gui, Tab,ADD/REM

Gui, Font, s11, Verdana

Gui, Add, CheckBox, x694 y+10 w60 h20 cTeal gpreview vtrim, Trim
Gui, Add, Text, x+3 yp w50 h20 cTeal +disabled gpreview vltrimtext, Left
Gui, Add, Text, xp+50 yp w50 h20 cTeal +disabled gpreview vrtrimtext, Right
Gui, Add, CheckBox, x+10 yp w120 h20 cTeal +disabled gpreview  vtrimGreater, Trim all >

Gui, Add, Edit, x694 y+2 w50 h20 cTeal +disabled +Number gpreview vltrim, 1
Gui, Add, UpDown,w30  Range0-100, 0
Gui, Add, Edit, x+3 yp w50 h20 cTeal +disabled +Number gpreview vrtrim, 1
Gui, Add, UpDown,w30  Range0-100, 0
Gui, Add, Edit, x+3 yp w70 h20 cTeal   +Number gpreview vtrimGreaterN,300
Gui, Add, UpDown,w30  Range0-1000, 100




Gui, Add, CheckBox, x694 y+5 w90 h20 cPurple gpreview vremove, remove    
Gui, Add, CheckBox,  x+2  yp w90 h20 cPurple gpreview vremoveSHOW, show
Gui, Add, Edit, x+2 yp wanttab h20 w50 cPurple  gpreview vremoveFrom, 1
Gui, Add, UpDown,w30  Range0-1000, 1
Gui, Add, Text,x+2 yp cPurple,to
Gui, Add, Edit, x+2 yp wanttab h20 w50 cPurple  gpreview vremoveTO, 5
Gui, Add, UpDown,w30  Range0-1000, 5
Gui, Add, Text,x+2 yp cPurple,chars 
Gui, Add, CheckBox, x+4 yp w150 h20 cPurple gpreview vremoveSIDE, from end
Gui, Add, CheckBox, x694 y+5 w90 h20 cPurple gpreview vremoveREPLACE, replace  
Gui, Add, Edit, x+2 yp wanttab h25 w125 cPurple  gpreview vremoveREPLACEwith, rep with


Gui, Add, CheckBox, x694 y+10 w90 h20 cRed gpreview vpadding, Padding
Gui, Add, Text, x+20 yp w50 h20 cRed +disabled gpreview , Left
Gui, Add, Text, x+2 yp w50 h20 cRed +disabled gpreview , offset
Gui, Add, Text, x+10 yp w50 h20 cRed +disabled gpreview , Right
Gui, Add, Text, x+3 yp w50 h20 cRed +disabled gpreview ,Offset
Gui, Add, Text, x+10 yp w50 h20 cRed +disabled gpreview , offset

Gui, Add, Edit, x694 y+2 wanttab h20 w50 cRed +disabled gpreview vlpadding, .%A_Space%
Gui, Add, Edit, x+2 yp wanttab h20 w50 cRed +disabled gpreview vcstart1, 1
Gui, Add, UpDown,w30  Range0-100, 1

Gui, Add, Edit, x+10 yp wanttab h20 w50 cRed +disabled gpreview vrpadding, 
Gui, Add, Edit, x+2 yp wanttab h20 w50 cRed +disabled gpreview vcstart2, 1
Gui, Add, UpDown,w30  Range0-100, 1

Gui, Add, Edit, x+20 yp wanttab h20 w50 cRed +disabled gpreview vcstart, 1
Gui, Add, UpDown,w30  Range0-100, 1

Gui, Add, CheckBox, x694 y+5 w890 h20 cgreen gpreview vcounter, line no


Gui, Add, CheckBox, x694 y+5  h20 cteal gpreview vcounterAPPEND, append Counter
Gui, Add, CheckBox, x+2 yp w90 h20 cteal gpreview vcounterAPPENDat, end


Gui, Font, s10, Verdana
Gui, Tab,FORMAT


Gui, Add, CheckBox, x694 y+2 w100 h20 cred gpreview vrem_dupes, rem Dupes
Gui, Add, CheckBox, x+4 yp w110 h20 cred gpreview vget_dupes, get Duplicate
Gui, Add, CheckBox, x+4 yp w60 h20 cblue gpreview vsort, Sort?
Gui, Add, CheckBox, x+3 yp w80 h20 cblue +disabled gpreview vsortrand,Random

Gui, Add, CheckBox, x+4 yp w60 h20 cblue +disabled gpreview vsortza,  Z-A
Gui, Add, CheckBox, x+3 yp w80 h20 cblue +disabled gpreview vremdbls,Rem Dbles
Gui, Add, CheckBox, x+3 yp w80 h20 cblue +disabled gpreview vsortnums, Use No
Gui, Add, CheckBox, x694 y+2 w100 h20 cblue gpreview vflip, Flip<-->pilF
Gui, Add, CheckBox, x+3 yp w110 h20 cblue gpreview vflipwordwithin, word within
Gui, Add, CheckBox, x+4 yp w140 h20 cblue gpreview vflipLine, rev line by line
Gui, Add, CheckBox, x694 y+2 w110 h20 cGreen gpreview vrlw, No leading
Gui, Add, CheckBox, x+3 yp w120 h20 cGreen gpreview vrtw, No trailing

Gui, Add, CheckBox, x694 y+2 w80 h20 gpreview vremblanks,Blank
Gui, Add, CheckBox, x+3 yp w80 h20 cblue gpreview vcustdelim, Delim
;Gui, Add, Edit, xp y+2 w120 h20 r1 +disabled gpreview vuserdelim,`n
Gui, Add, ComboBox,x+3 yp w80 h120  +disabled  gpreview vuserdelim , \n\n|\n\|`n`r|`n|`,|`:

Gui, Add, CheckBox,cPurple  x+4 yp w60 h20 gpreview vDBLblank, \n\n
Gui, Add, CheckBox,cPurple  x+4 yp w70 h20 gpreview vclean, clean
Gui, Add, CheckBox,cPurple  x+4 yp w70 h20 gpreview vcleanAll, All
Gui, Add, CheckBox,cPurple  x+4 yp w70 h20 gpreview vclean2,2

Gui, Add, CheckBox,cPurple  x694 y+5 w60 h20 gpreview vline, line
Gui, Add, CheckBox, x+3 yp w80 h20 cPurple gpreview vcustdelim2,Delim
Gui, Add, ComboBox,x+3 yp w60 h20 cPurple +disabled  gpreview vuserdelim2 , %A_Space%||`n`r|`n|`,|`:

Gui, Add, CheckBox,cPurple  x694 y+2  h20 gpreview vAltlines,every nth line
Gui, Add, Edit,x+2 yp w50 h20 gpreview  vALTlineN Number Limit3 , 80
Gui, Add, UpDown,w30  Range1-1000, 2
Gui, Add, CheckBox,cPurple  x+4 yp  h20 +disabled gpreview vAltlinesHIDE,Remove

Gui, Add, CheckBox, x694 y+2 w60 h20 cred gpreview vuppcase, UP
Gui, Add, CheckBox, x+3 yp w60 h20 cred gpreview vlowcase, low
Gui, Add, CheckBox, x+3 yp w60 h20 cred gpreview vtitcase, Title
Gui, Add, CheckBox, x+3 yp w60 h20 cred gpreview vsencase, Sen
Gui, Add, CheckBox, x694 y+2 w60 h20 cGreen gpreview vtohex,Hex
Gui, Add, CheckBox, x+3 yp w60 h20 cGreen gpreview vtodec,Ascii
Gui, Add, CheckBox, x+3 yp w120 h20 cGreen gpreview vCleanHTML, Clean HTML


Gui, Add, CheckBox, x694 y+2 w120 h20 cGreen gpreview vstot, Sp-->Tab
Gui, Add, CheckBox, x+3 yp w120 h20 cGreen gpreview vttos, Tab-->Sp
Gui, Add, CheckBox, x+3 yp w120 h20 cGreen gpreview vttosN, Tab-->n Sp
Gui, Add, CheckBox, x694 y+2 w80 h20 cTeal  gpreview  vsetwidth,width
Gui, Add, Edit,x+3 yp w50 gpreview  vo_line_width Number Limit3 , 80
Gui, Add, UpDown,w30  Range0-1000, 80
Gui, Add, Text, x+3 yp , Align:
Gui, Add, DropDownList, x+3 yp w60 gpreview  vo_align  , left||indent|right|center
Gui, Add, Checkbox,x694 y+2 gpreview  vo_paragraphs Checked 	 , Detect Para
Gui, Add, Checkbox,x+3 yp gpreview  vo_reformPunct Checked	 , Reformat Punct'


Gui, Font, s12, Verdana


Gui, Tab,CLIPBOARD

Gui, Tab,SCRIPT
Gui, Add, button, x694 y45   h25 cGreen gscript_menu ,load
Gui, Add, CheckBox, x+4 y45   h20 cGreen gpreview vScript_edit,Script_edit
Gui, Add, text, x+5 y45   h20 cred ,text, text
Gui, Font, s9 cred, 
Gui, Add, Edit,x694 y70  t10 wanttab h180 w500 cPurple  gpreview vScript_edit1 +disabled, %Script_edit1%
Gui, Tab,MORE
Gui, Add, edit, x120 y135 w50 r1 vlimit gpreview, 10 
Gui, Add, UpDown, x120    vlimit_updown Range0-1000, 5
Gui, Add, CheckBox, x+5 yp h25 vinstance_csv cGreen gpreview ,use csv edit1
Gui, Add, CheckBox, xp y+0 h25 vinstance_count2 cGreen gpreview ,instance count
Gui, Add, edit, x120 y+0 w50 r1  gpreview, line 
Gui, Add, CheckBox, x+5 yp h25 vinstance_separator cGreen gpreview checked ,line separated
Gui, Add, text, x694 y45    cred ,#
Gui, Add, Edit, x674 y+5  w30  cred vpadding_text,`,
Gui, Add, button, x674 y+0 w35 h25  ,`,
Gui, Add, button, x674 y+0  w35 h25 ,sp
Gui, Add, button, x674 y+0  w35 h25 ,|
Gui, Add, button, x674 y+5  w35 h25 gjoin_text_beg,beg
Gui, Add, button, x674 y+0  w35 h25 gjoin_text_end ,end
Gui, Add, Edit, x+5 y45  w180 h200 vedit5 gpreview,
Gui, Add, text, x+0 yp     cred ,`%	;	%
Gui, Add, Edit, x+0 yp w120 h200 vedit6 gpreview,
Gui, Add, text, x+0 yp     cred ,@
Gui, Add, Edit, x+0 yp w80 h200 vedit7 gpreview,
Gui, Add, text, x+0 yp     cred ,&&
Gui, Add, Edit, x+0 yp w60 h200 vedit8 gpreview,
Gui, Add, Edit, x+0 yp w50 h200 vedit9 gpreview,
Gui, Add, Edit, x+0 yp w50 h200 vedit10 gpreview,
Gui, Add, Edit, x+0 yp w50 h200 vedit11 gpreview,

Gui, Tab,

regex=0
MatchCase=0

SB_SetParts(300)

;Gui, Show, x267 y72  , FindSample
;WinGet ControlID, ID, FindSample
count=0
amount:=-1
mode:=4
gosub,change_active_mode

Gui, Font, s14 cred, 
guicontrol,font,mode%mode%,
Gui, Font, s10 cblack, 

gosub,gui11Build
Gui, 1: +LastFound
hwnd := WinExist()
Gui,1:  +LastFound
GUI_ID:=WinExist() 
gui, 1: show, hide x600 w800

; preselects the first tab
; Gui, 1: +LastFound
SendMessage, TCM_HIGHLIGHTITEM := 0x1333, 1, 1, , ahk_id %TabID%
Return


~*Rctrl::	; na
if (A_PriorHotKey = "~*Rctrl" AND A_TimeSincePriorHotkey < 400)
{
		selText:=Get_Selected_Text()
		if selText<>
		{
			guicontrol,,edit3,%selText%
			Prev_Edit1:=
			Prev_Edit2:=
			Prev_Edit3:=
			Prev_Edit4:=
			gosub,clearall
			gosub,regexbutton
			settimer,preview,-100
		}
		if (shrink)
		{
			shrink:=0
			guicontrol,move,shrinkbutton ,h250
			gui +LastFound
			winset,region, 0-0 w1300 h900
		}
		if (!gui_ON)
		{
			; Gui, Show ,x600	w600 ;h650
			DllCall("AnimateWindow","UInt",GUI_ID,"Int",300,"UInt",0xA0004)	
			winactivate,ahk_class AutoHotkeyGUI
			gui_ON:=1
		}

}
Sleep 0
KeyWait  Rctrl
return


/*
~*Rshift::	; na
if (A_PriorHotKey = "~*Rshift" AND A_TimeSincePriorHotkey < 400)
{
	GetKeyState, state_c, ctrl
	if (state_c ="D" )
	{
		selText:=Get_Selected_Text()
		if selText<>
		{
			guicontrol,,edit3,%selText%
			Prev_Edit1:=
			Prev_Edit2:=
			Prev_Edit3:=
			Prev_Edit4:=
			gosub,clearall
			gosub,regexbutton
			settimer,preview,-100
		}
		if (shrink)
		{
			shrink:=0
			guicontrol,move,shrinkbutton ,h250
			gui +LastFound
			winset,region, 0-0 w1300 h900
		}
		if (!gui_ON)
		{
			; Gui, Show ,x600	w600 ;h650
			DllCall("AnimateWindow","UInt",GUI_ID,"Int",300,"UInt",0xA0004)	
			winactivate,ahk_class AutoHotkeyGUI
			gui_ON:=1
		}
	}
}
Sleep 0
tooltip,waiting inside line replacer
KeyWait  Rshift
tooltip,waiting done
return
*/
preview:

	gui,submit,nohide

	StringReplace, Edit1, Edit1, `r`n, `n , All
	StringReplace, Edit1, Edit1, `n`r, `n , All
	StringReplace, Edit1, Edit1, `r, `n , All

	if !((Prev_Edit1==Edit1) AND (Prev_Edit2==Edit2)  AND (Prev_Edit3==Edit3)  AND (Prev_limit==limit) AND (Prev_Edit4==Edit4))
	{	
			Prev_Edit1:=Edit1
			Prev_Edit2:=Edit2
			Prev_Edit3:=Edit3
			;Prev_Edit4:=Edit4
			Prev_limit:=limit  
			
		if mode=1
				gosub,lineReplace
			else if mode=2
				gosub,variantReplace
			else if mode=3
				gosub,incrementReplace
			else if mode=4
				gosub,regex
			else if mode=5
				gosub,Nseparate			
			gosub,cc_preview
		return
	}
	else 
	{	 
		Prev_Edit1:=Edit1
		Prev_Edit2:=Edit2
		Prev_Edit3:=Edit3
		;Prev_Edit4:=Edit4
		Prev_limit:=limit
		return
	}
Return

regexButton:
	guicontrol,move,edit2,h70
	guicontrol,move,edit1,h70
	guicontrol,enable,edit1
	guicontrol,enable,edit2
GuiControl,, MyTab, |ADVANCED||ADD/REM|FORMAT|CLIPBOARD|SCRIPT|MORE|
  SendMessage, TCM_HIGHLIGHTITEM := 0x1333, 2, 1, , ahk_id %TabID%

	mode=4
	gosub,change_active_mode

regex:
	Gui, Submit, NoHide
	Gosub, setup
	if !(matching OR matchinglines OR nonmatching OR nonmatchinglines)
		{
			guicontrol,enable,edit2
			gosub,replace
			return
		}		
	;msgbox, 
	guicontrol,disable,edit2
	matchlist=
/*	
	matchlist:=FilterVariable(replacedOutput,edit1,1,1)
		tooltip,%matchlist%	
		keywait,lbutton,d
*/	
	
/*		 
	output=
	if match
	{
		Loop,parse,source,%SourceDelimiter%
			{
			searchin:=A_LoopField
			loop,parse,searchStr,%SearchStrDelimiter%
				{	
					
						if ( RegExMatch(searchin, searchStr) )
						output=%output%%Sourcedelimiter%%A_LoopField%							
				}
			}
	}	 
*/		 
		;reg=O)%edit1% ;combine Case and edit1 into one so i can Insert the combination into the Regex without any Errors.
		count=0
		matchlist=
		pos = 1
		match=
		 		
	Gosub, setup
	
	if (matching)
		{
		; msgbox,%reg%
		reg=%case%)%edit1%
			matchlist:=Find(edit3,"","",reg,0,3)
						
		}
	else if (matchinglines)
		{	
			; ifinstring,reg,.*
			reg=%case%)%edit1%	
			tmp=%case%)^.*%edit1%.*$ 	; )
			matchlist:=Find(edit3,"","",tmp,0,3)
		} 
	else if (NONmatching)
		{
		reg=%case%)%edit1%
			tmp=%reg%
			matchlist:=RegExReplace(edit3, tmp )
			;matchlist:=Find(edit3,"","",tmp,0,3)
			; matchlist:=CBN_TF_Find(edit3, 1, 0, reg,0,1,0)
			;matchlist=coming soon
		}
	else if (NONmatchinglines)
		{
			;tmp=m)^.*%reg%.*$
		reg=%case%)%edit1%	
			matchlist:=CBN_TF_Find(edit3, 1, 0, reg,0,1,0)
			;tmp=^.*%reg%.*$
			;tmp=^((?!%reg%).)*$
			;matchlist:=RegExReplace(edit3,tmp)
			;matchlist:=Find(edit3,"","",tmp,0,3)
		}
		/*
 */
		edit4:=matchlist
		guicontrol,,edit4, %matchlist%	 

		replacedOutput:=matchlist
		
		/*
		guicontrol,,edit4,%output%	
		replacedOutput:=output		;f & r output before formatting
		edit4:=replacedOutput

	*/

return
replace:
	if edit3 = " "
	{
		output:=edit4
		guicontrol,,edit4,%output%	
		guicontrol,,status2,%reg%	
		replacedOutput:=output		;f & r output before formatting
		edit4:=replacedOutput
		return
	}
	
	repwith:=edit2
	count=0
	reg1=%case%%regexmultiline%

	if reg1 =
		reg=%regexANYCRLF%	; combine Case and edit1 into one so i can Insert the combination into the Regex without any Errors.
	else
		reg=%case%%regexmultiline%)%regexANYCRLF%
	reg .= edit1 

	output=
	if (counterAPPEND)	;add a counter with the replacement
	{
		if (counterAPPENDat)
			repwith=%repwith%††
		else
			repwith=††%repwith%
	}
	output:=RegExReplace(edit3, reg, repwith, count, amount)
	if (counterAPPEND)
		{
			cnt=0
			Loop, %count%		 
			 StringReplace, output, output,  ††,%a_index%
		}
		
	guicontrol ,, edit4,%output%	
	guicontrol ,, status2,%reg%	
	replacedOutput := output		;f & r output before formatting
	edit4 := replacedOutput
Return

setup:
	Gui, Submit, NoHide
	gui,  default
	If MatchCase=1 ;case sensitive
		case=
	Else
		case=i	;)
	if (multiline)	
		regexmultiline=m
		else
		regexmultiline=
	
	if (ifANYCRLF)	
		regexANYCRLF=(*ANYCRLF)
		else
		regexANYCRLF=
	
	
	If regex=0 ;convert to regex mode
	{
		edit1:= RegExReplace(edit1,  "[\\\.\*?+[{|()^$]", "\$0")
		; stringreplace, edit1, edit1, %a_space%, \s, all
		; stringreplace, edit1, edit1, %a_tab%, \t, all
		ANYCRLF=
	}
	Else
	{
		ANYCRLF=(*ANYCRLF)
		edit1:=edit1
	}
	;this >>MUST<< be after Regex Mode.
	;If wwo=1 ;whole words only
;		edit1=\b%edit1%\b
	;Else
	;	edit1:=edit1

;	If ra=1 ;replace all
;		amount=-1
;	Else
;		amount=1
Return


Return

change_active_mode:
	Gui, Font, s10 cred ,
	loop,6 {
	ILButton( mode_hwnd_%a_index%, "" , 0,0 , 0)
	guicontrol,font, mode%a_index%, 
	}

	Gui, Font, s11 cred , 
	guicontrol,font,mode%mode%
	ILButton( mode_hwnd_%mode%, "circle green.ico:0" , 16, 16, 0)

Return


variantReplaceButton:
	tooltip,replace first match with 1st replace`,next with 2nd
	settimer,removetooltip,-1000
	guicontrol,enable,edit1
	guicontrol,enable,edit2
	guicontrol,move,edit1,h40
	guicontrol,move,edit2,h100
	mode=2
	gosub,change_active_mode
	/*
	Gui, Font, s10 cred , 
	guicontrol,font,mode1,
	guicontrol,font,mode3,
	guicontrol,font,mode4,
	guicontrol,font,mode5,
	guicontrol,font,mode6,
	Gui, Font, s13 cred , 
	guicontrol,font,mode2,

	Gui, Font, s10 cblack,
	*/

variantReplace:

	source:=edit3
	StringSplit,  edit1Lines,edit1, `n`r
	StringSplit, edit2Lines, edit2, `n`r

	find:=edit1
	count=0
	Loop, %edit2Lines0%
	{
	count++
		repwith:=edit2Lines%a_index%
			;Loop,parse,source,`n`r
				StringReplace,source,source, %find%,%repwith% 
				; if ErrorLevel = 0  ; No more replacements needed.
		   ; break

				;NewStr := RegExReplace(a_loopfield, pattern, repwith, count, amount)
	}
	guicontrol,,edit4,%source%
	replacedOutput:=source
	edit4:=replacedOutput	
return

REVvariantReplaceButton:
	tooltip,replace all find texts with single replacement text
	settimer,removetooltip,-1000
	guicontrol,enable,edit1
	guicontrol,enable,edit2
	guicontrol,move,edit1,h100
	guicontrol,move,edit2,h40
	mode=6
	gosub,change_active_mode

REVvariantReplace:

	source:=edit3
	StringSplit,  edit1Lines,edit1, `n`r
	StringSplit, edit2Lines, edit2, `n`r

	find:=edit1
	count=0
	Loop, %edit2Lines0%
	{
		count++
		repwith:=edit2Lines%a_index%
			;Loop,parse,source,`n`r
				StringReplace,source,source, %find%,%repwith% 
				; if ErrorLevel = 0  ; No more replacements needed.
		   ; break

				;NewStr := RegExReplace(a_loopfield, pattern, repwith, count, amount)
	}
	guicontrol,,edit4,%source%
	replacedOutput:=source
	edit4:=replacedOutput		
return

XtoNx:
	x=0
	Loop, %edit2Lines0%
	{
		x++
	}
	guicontrol,,limit,%x%
return

NSEPARATEBUTTON:
	tooltip,* to nth
	settimer,removetooltip,-1000
	GuiControl,, MyTab, |ADVANCED|ADD/REM|FORMAT|CLIPBOARD|SCRIPT|MORE||
	SendMessage, TCM_HIGHLIGHTITEM := 0x1333, 7, 1, , ahk_id %TabID%

	guicontrol,,edit1,* # `% @ & $		;	%
	guicontrol,move,edit2,h100
	guicontrol,move,edit1,h30

	guicontrol,move,limit,x120 y150
	guicontrol,move,limit_updown ,x152 y150
	guicontrol,move,instance_count ,x175 y155
	guicontrol,disable,edit1
	guicontrol,enable,edit2

	mode=5
	gosub,change_active_mode

Nseparate:
	if (instance_count)
	{
		guicontrol,disable,edit2
		gosub,incrementReplace
	}
	else
	{
		guicontrol,enable,edit2
		gosub,Nseparate_2
	}
	return

Nseparate_2:

	gui,submit,nohide	
	source:=edit3
	loop, 8
	{
		field%a_index%=
	}
	output=
	edit2 :=clipboard
	{
		field1:=regexreplace(edit2,"\n*$","") ; remove  
		field2:=regexreplace(edit5,"\n*$","") ; remove  
		field3:=regexreplace(edit6,"\n*$","") ; remove  
		field4:=regexreplace(edit7,"\n*$","") ; remove  
		field5:=regexreplace(edit8,"\n*$","") ; remove 
		field6:=regexreplace(edit9,"\n*$","") ; remove 
		field7:=regexreplace(edit10,"\n*$","") ; remove 
		field8:=regexreplace(edit11,"\n*$","") ; remove
	}	
	if ( !(InStr( source, "*")) )	;no replacements %
	{
		replacedOutput:=edit3
		edit4:=replacedOutput
		
		tooltip, no markers ( * # `% @ & $)
		settimer,removetooltip,-1400
		guicontrol,,edit4,%edit3%
		
	  return
	}

loop,parse,	edit2,`n,`r
{
	limit:=a_index
}
loop,parse,	edit5,`n,`r
{
	limit2:=a_index
}
if (limit2>limit)
	limit:=limit2
	guicontrol,,limit,%limit%
	loop, 8
	{
		find%a_index%=`*%a_index%
		n:=a_index
		Loop, %limit%
		{
			field%n%Lines%a_index%=
		}
		StringSplit, field%a_index%Lines, field%a_index%,`n,`r
	}

if (field1Lines0!=field2Lines0)
	tooltip, not equal
		settimer,removetooltip,-400
count=0
output=
Loop, %limit%
{
	text:=source
	count++
	n:=a_index
	loop, 8
	{
		repwith%a_index%:=field%a_index%Lines%n%
		a:=find%a_index%
		b:=repwith%a_index%
		StringReplace,text,text, %a%,%b%,all
	}		
			output .= text . "`n"		
}

replacedOutput:=output
guicontrol,,edit4,%output%
edit4:=output


return
; Nseparate_2:
	gui,submit,nohide	
	source:=edit3
	edit2:=regexreplace(edit2,"\n*$","") ; remove  
	edit5:=regexreplace(edit5,"\n*$","") ; remove  
	edit6:=regexreplace(edit6,"\n*$","") ; remove  
	edit7:=regexreplace(edit7,"\n*$","") ; remove  
	edit8:=regexreplace(edit8,"\n*$","") ; remove 
	edit9:=regexreplace(edit9,"\n*$","") ; remove 
	edit10:=regexreplace(edit10,"\n*$","") ; remove 
	edit11:=regexreplace(edit11,"\n*$","") ; remove
	
	; if ( !(InStr( source, "*")) && !( InStr( source, "#") )  && !( InStr( source, "%") )  && !( InStr( source, "@") ) && !( InStr( source, "&") ) && !( InStr( source, "$") )  )	;no replacements %
	if ( !(InStr( source, "*")) )	;no replacements %
	{
		replacedOutput:=edit3
		edit4:=replacedOutput
		
		tooltip, no markers ( * # `% @ & $)
		settimer,removetooltip,-1400
		guicontrol,,edit4,%edit3%
		
	  return
	}
	

	
	
	
	; cnt=0
; Loop, Parse,source
	; {
	   ; If  A_LoopField = * ;OR (A_LoopField = #))
	   ; Cnt++
	; }	
loop,parse,	edit2,`n,`r
{
	limit:=a_index
}
loop,parse,	edit5,`n,`r
{
	limit2:=a_index
}
if (limit2>limit)
	limit:=limit2
	
	guicontrol,,limit,%limit%
	/*
	n:=limit-1
	loop, %n%
	{
		source=%source%`n`r%edit3%
	}
	*/
; find1:=edit1
find2=`*1

find5=`*2

find6=`*3	;	%
find7=`*4
find8=`*5
find9=`*6
find10=`*7
find11=`*8

/*
find5=`#

find6=`%	;	%
find7=`@
find8=`&
find9=`$
*/
/*
;	===
find_delim=`*`#
loop,parse,find_delim
{
delim_count:=a_index
}
StringSplit, edit2Lines, edit2, `n`r
StringSplit, edit5Lines, edit5,`n`r

;	===

*/
Loop, %limit%
{
	edit2Lines%a_index%=
	edit5Lines%a_index%=
	edit6Lines%a_index%=
	edit7Lines%a_index%=
	edit8Lines%a_index%=
	edit9Lines%a_index%=
	edit10Lines%a_index%=
	edit11Lines%a_index%=
	
}
StringSplit, edit2Lines, edit2,`n,`r
StringSplit, edit5Lines, edit5,`n,`r
StringSplit, edit6Lines, edit6,`n,`r
StringSplit, edit7Lines, edit7,`n,`r
StringSplit, edit8Lines, edit8,`n,`r
StringSplit, edit9Lines, edit9,`n,`r
StringSplit, edit10Lines, edit10,`n,`r
StringSplit, edit11Lines, edit11,`n,`r

if (edit2Lines0!=edit5Lines0)
	tooltip, not equal
		settimer,removetooltip,-400
if (edit2Lines0>edit5Lines0)
	samples1:=edit2Lines0
	else
	samples1:=edit5Lines0
	
if (edit6Lines0>edit7Lines0)
	samples2:=edit6Lines0
	else
	samples2:=edit7Lines0
	
if samples1>samples2
	samples:=samples1
	else
	samples:=samples2
count=0
;StringSplit,  edit1Lines,edit1, `n`r

output=

Loop, %limit%
{
text:=source
count++

	repwith2:=edit2Lines%a_index%
	repwith5:=edit5Lines%a_index%
	repwith6:=edit6Lines%a_index%
	repwith7:=edit7Lines%a_index%
	repwith8:=edit8Lines%a_index%
	repwith9:=edit9Lines%a_index%
	repwith10:=edit10Lines%a_index%
	repwith11:=edit11Lines%a_index%
	;Loop,parse,source,`n`r
	; loop,%cnt%
	{
		; StringReplace,source,source, %find1%,%repwith1% 
		StringReplace,text,source,%find2%,%repwith2%,all
		StringReplace,text,text, %find5%,%repwith5%,all
		StringReplace,text,text, %find6%,%repwith6%,all
		StringReplace,text,text, %find7%,%repwith7%,all
		StringReplace,text,text, %find8%,%repwith8%,all
		StringReplace,text,text, %find9%,%repwith9%,all
		StringReplace,text,text, %find10%,%repwith10%,all
		StringReplace,text,text, %find11%,%repwith11%,all
		
	}
	; if ErrorLevel = 0  ; No more replacements needed.
	; break

	;NewStr := RegExReplace(a_loopfield, pattern, repwith1, count, amount)
	output .= text . "`n"
			
}

;msgbox,%source%
	/*
	NewStr=
	output=
	IfnotinString, source, *	;no replacements
	{
	guicontrol,,edit4,%edit3%
	return
	}
	StringReplace, output, source, *,1, All
	limit--
	loop,%limit%
	{
		n:=a_index+1
		StringReplace, NewStr, source, *, %n%, All
		output=%output%`n`n%NewStr%
	}
	*/
replacedOutput:=output
guicontrol,,edit4,%output%
edit4:=output


		
return
/*
incrementReplaceButton: 
tooltip,* to count
settimer,removetooltip,-1000
guicontrol,move,edit1,h100
guicontrol,move,edit2,h100
guicontrol,disable,edit1
guicontrol,move,edit1,h30
guicontrol,disable,edit2
GuiControl,, MyTab, |ADVANCED|ADD/REM|FORMAT|CLIPBOARD|SCRIPT|MORE
mode=2
gosub,change_active_mode
*/
incrementReplace:


	gui,submit,nohide
	source:=edit3

	NewStr=
	output=
	IfnotinString, source, *	;no replacements
	{

		tooltip, no markers ( * )
		settimer,removetooltip,-500		
		; guicontrol,,edit4,%edit3%
	
	}
	StringReplace, output, source, *,1, All
	limit--
	if (instance_separator)
		delimiter=`n`n
		else
		delimiter=`n
	loop,%limit%
	{
		n:=a_index+1
		StringReplace, NewStr, source, *, %n%, All
		output=%output%%delimiter%%NewStr%
	}
replacedOutput:=output
	guicontrol,,edit4    ,%output%
edit4:=replacedOutput
Return

lineReplaceButton:
tooltip,replace nth line with nth text 
settimer,removetooltip,-1000
guicontrol,move,edit1,h100
guicontrol,move,edit2,h100
guicontrol,enable,edit1
guicontrol,enable,edit2

mode=1

gosub,change_active_mode

lineReplace:

gui,submit,nohide

source:=edit3
StringSplit,  edit1Lines,edit1, `n`r
StringSplit, edit2Lines, edit2, `n`r

Loop, %edit1Lines0%
{
	find:=edit1Lines%a_index%
	repwith:=edit2Lines%a_index%


		;Loop,parse,source,`n`r
			StringReplace,source,source, %find%,%repwith% ,UseErrorLevel 
			;NewStr := RegExReplace(a_loopfield, pattern, repwith, count, amount)
}

	guicontrol,,edit4,%source%
	replacedOutput:=source
	edit4:=replacedOutput
		
return 


nil:

Return

tooltip:
	Gui, Submit, Nohide
	StringLeft, MyText, Edit4,2000
	tooltip,%MyText%
	keywait, Lbutton, D ,t8
	tooltip,
return

menu1:
	menu,menu1,show

return
menu2:
menu,menu2,show
return




LVEvents:
	GUi,ListView,list
	if (A_GuiEvent = "DoubleClick")
	{
		tooltip,d
		sleep,400
		tooltip
		gui, 11:hide
	}
	if (A_GuiEvent = "normal")
	{
		tooltip,s
		sleep,400
		tooltip
		gui, 11:hide	
	}
	else If (A_GuiEvent = "K")
	{
		tooltip,k
		sleep,400
		tooltip

			If GetKeyState("Del", "P")
			{
			 
					 
			}
	}
	gui, 11:hide
	return
	

hide:
gui_ON:=0
settimer,preview,off
; gui,hide
 DllCall("AnimateWindow","UInt",  GUI_ID  ,"Int", 300,"UInt", 0x90004) 
return
 

reload:

reload
return
regextoggle:
if regex=0

		{
			regex:=1
			GuiControl,,RegEx,regex
			ILButton( regextoggle_hwnd, "circle green.ico:0" , 16, 16, 0)
		}
	else 
		{
			regex:=0		
			GuiControl,,RegEx,regex off
			ILButton( regextoggle_hwnd, "" , 0,0 , 0)
		}
		gosub,preview
	return
	
casetoggle:
	if MatchCase=0
		{
			MatchCase:=1
			GuiControl,,MatchCase,MatchCase
		}
	else 
		{
			MatchCase:=0		
			GuiControl,,MatchCase,Case off
		}
		gosub,preview
	return

reinsert:
edit3:=edit4
guicontrol,,edit3,%edit4%
		gosub,preview
	return
	
	
	
	
	
cc_PasteClose:
	gui,submit,nohide
	oldclip:=Clipboard
	Clipboard:=edit4
	gui,hide
	gui_ON:=0
	sleep,300
	; send,^v
	send_key_emacs_or_after_translatingTo_normal_ifNot_emacseditor("C-y")
	Clipboard:=oldclip
return		
	
cc_copyClose:
	gui,submit,nohide
	Clipboard:=edit4
	text:=truncated_text(edit4,600)
	settimer,removetooltip,-1000
	tooltip,%text%

	gosub,hide
	gui_ON:=0
return	
cc_copy:
	gui,submit,nohide
	Clipboard:=edit4
	text:=truncated_text(edit4,600)
	settimer,removetooltip,-1000
	tooltip,%text%
return

cc_revert:
	Gui, submit, nohide
	ccOLD:=edit3
	GuiControl, , edit3, %ccOLD%
	settimer,preview,-100
return
cc_swap:
	Gui, submit, nohide
	
	edit3_hist_1:=edit3
	loop,9{
			n:=10-A_Index
			n2:=n+1
			edit3_hist_%n2%:=edit3_hist_%n%	
	}	
		
	ccOLD:=edit3
	edit3=
	
	GuiControl, , edit3, %edit4%
	settimer,preview,-100
return


cc_swap_Clear:
	Gui, submit, nohide
	
	edit3_hist_1:=edit3
	loop,9{
			n:=10-A_Index
			n2:=n+1
			edit3_hist_%n2%:=edit3_hist_%n%	
	}	
		
	ccOLD:=edit3
	edit3=
	
	GuiControl, , edit3, %edit4%
	settimer,preview,-100
	gosub,clearall
return




	
cc_preview:
if (disabled)
	return
	
 
text:=replacedOutput


if (rlw==1)
	text := RegExReplace(text, "m`n)^[ \t]+", "")
if (rtw==1)
	text := RegExReplace(text, "m`n)[ \t]+$","")

if (CleanHTML==1)
{
  text:=ConvertEntities(text)
  text:=unhtm(text)
}


if (titcase==1)
  StringLower, text, text, T
if (sencase==1)
{
  StringLower text, text
  text:=RegExReplace(text, "([.?\s!]\s\w)|^(\.\s\b\w)|\bi\b|^(.)", "$U0")
}
	
if (uppcase==1)
  StringUpper, text, text
if (lowcase==1)
  StringLower, text, text
if (Flip==1)
  text:=Flip(text)
	
if (flipwordwithin==1)
  text:=flipwordwithin(text)

if (FlipLine==1)
  text:=FlipLine(text)
	
   
if (StoT==1)
	StringReplace, text, text, %A_Space%, %A_Tab%, All
if (TtoS==1)
	StringReplace, text, text, %A_Tab%, %A_Space%, All
if (TtoSN==1)
	StringReplace, text, text, %A_Tab%, %A_Space%%A_Space%%A_Space%%A_Space%%A_Space%, All

if (tohex==1)
  text:=_Hex(text)
if (todec==1)
  text:=_Asc(text)

trimmed:=
 
if (trim==1)
{
	guicontrol, enable, ltrim
	guicontrol, enable, ltrimtext
	guicontrol, enable, rtrim
	guicontrol, enable, rtrimtext
	guicontrol, enable, spos
	guicontrol, enable, spostext
	guicontrol, enable, trimGreater
		
	
	if (trimGreater==1)
	{	out=	
		guicontrol, enable, trimGreaterN
		guicontrol, disable, rtrim
		guicontrol, disable, rtrimtext
		StringReplace, text, text, %A_SPACE%, ¢, All	;for preserving spaces

		loop, parse, text, `n`r
			{
				loop,parse,A_LoopField,,
				{
					if a_index<=%trimGreaterN%
						out=%out%%A_LoopField%
					}
				out=%out%`n%temp%
			}
			StringReplace, out, out,¢, %A_SPACE%, All
			text:=out
	}
	Else
	{  	
		guicontrol, disable, trimGreaterN
		guicontrol, enable, rtrim
		guicontrol, enable, rtrimtext
	}

	if (ltrim!="" && rtrim!="")
	{
		loop, parse, text, %userdelimpadding%
		{
				stuff:=SubStr(A_LoopField, ltrim+1, StrLen(A_LoopField)-(ltrim+rtrim))
				trimmed.=(A_Index!=max) ?  stuff userdelimpadding : stuff
		}
			text:=trimmed
	}
}
Else
{
	guicontrol, disable, ltrim
	guicontrol, disable, ltrimtext
	guicontrol, disable, rtrim
	guicontrol, disable, rtrimtext
	guicontrol, disable, spos
	guicontrol, disable, spostext
	guicontrol, disable, trimGreater
	guicontrol, disable, trimGreaterN
	
}

if (setwidth==1)
{ 
		out=	
		guicontrol, enable, o_paragraphs
		guicontrol, enable, o_reformPunct
		guicontrol, enable, o_align
		guicontrol, enable, o_line_width
		
		out:=para(text, o_line_width, o_align, o_paragraphs, o_reformPunct)
		text:=out
	}
	Else
{  	
		guicontrol, disable, o_paragraphs
		guicontrol, disable, o_reformPunct
		guicontrol, disable, o_align
		guicontrol, disable, o_line_width
		
}
if (rem_dupes)
{
	guicontrol, disable, get_dupes
	guicontrol, enable, rem_dupes
	Output_tmp =`n

	loop, parse, text,`n,`r
	{
	   If Output_tmp not contains `n%A_Loopfield%`n
		  Output_tmp .= A_Loopfield . "`n"
	}
	stringtrimleft,Output_tmp,Output_tmp,1
	text:=Output_tmp
}
else if (get_dupes)
{
	guicontrol, disable, rem_dupes
	guicontrol, enable, get_dupes
	Output_tmp =`n
	Output_tmp2 = 

	loop, parse, text,`n,`r
	{
	   If Output_tmp not contains `n%A_Loopfield%`n
		  Output_tmp .= A_Loopfield . "`n"
		else If Output_tmp2 not contains `n%A_Loopfield%`n
		  Output_tmp2 .= A_Loopfield . "`n" . A_Loopfield . "`n"
		else
		  Output_tmp2 .= A_Loopfield . "`n"
		
	}
	text:=Output_tmp2
}
else
{
guicontrol, enable, rem_dupes
guicontrol, enable, get_dupes
}
if (sort==1)
{
  guicontrol, enable, remdbls
  guicontrol, enable, sortrand
  guicontrol, enable, sortza
  guicontrol, enable, sortnum
  guicontrol, enable, casesensitive
  guicontrol, enable, sortnums
  if (remdbls==1)
    opt.="U "
  if (sortrand==1)
    opt.="Random "
  if (sortza==1)
    opt.="R "
  if (sortnums==1)
    opt.="N "
  if (casesensitive==1)
    opt.="C "
  Else
    opt.="CL "

sort, text, %opt%
dupes:=ErrorLevel
}
Else
{
  guicontrol, disable, remdbls
  guicontrol, disable, sortrand
  guicontrol, disable, sortza
  guicontrol, disable, sortnum
  guicontrol, disable, casesensitive
  guicontrol, disable, sortnums
}


padded:=
if (padding==1)
{
  guicontrol, enable, lpadding
  ;guicontrol, enable, lpaddingtext
  guicontrol, enable, rpadding
  guicontrol, enable, cstart
}
Else
{
  guicontrol, disable, lpadding
  ;guicontrol, disable, lpaddingtext
  guicontrol, disable, rpadding
  guicontrol, disable, cstart
}

if (counter==1 || padding==1)
{

	if (padding!=1)
	{
		lpadding:=
		rpadding:=
	}
	loop, parse, text, %userdelimpadding%
	{
		if (A_Index>=cstart)
		{
			count:=(counter==1) ? A_Index-(cstart-1) : ""
			
			stuff:=count lpadding A_LoopField rpadding
			padded.=(A_Index!=max) ?  stuff userdelimpadding : stuff
		}
		Else
			padded.=(A_Index!=max) ?  A_LoopField userdelimpadding : A_LoopField
	}
		text:=padded
}
if (remove ==1)
{
	Out=
	Out2=
	Loop, Parse, Text,`n, `r
		{	
		temp=0
			Loop, Parse,A_LoopField, 
			{
				If ((A_Index >= removeFrom) AND  (A_Index <= removeTO))
				{
					if (removeREPLACE ==1)
					{
						if (temp==0)
							Out=%out%%removeREPLACEwith%
							temp=1
					}
					Out2=%out2%%A_LoopField%
					
				}
				else
						Out=%out%%A_LoopField%
					
			} 
			
			Out=%out%`n
			Out2=%out2%`n
		}
	if (removeSHOW==1)
		text:=out2
		else
		text:=Out	
}

if (remblanks==1)
	{
	guicontrol,,userdelim,\n\n|\n||`n`r|`n|`,|`:
	userdelim=\n
		text:=regexreplace(text, "(" userdelim ")+", "$1")
		 
	}

loop, parse, text, %userdelimpadding%
		max:=A_Index

opt:=
if (custdelim==1)
{
  guicontrol, Enable, userdelim
  opt.="D" userdelim " "
  userdelimpadding:=userdelim
}

else
{
  guicontrol, disable, userdelim
  userdelim:="\n"
  userdelimpadding:="`n"
}

if (line==1)	;experimental
{
	text:=regexreplace(text,"\n", " ")
	/*
	guicontrol, enable, custdelim2
	if !(custdelim2==1)
		{
		guicontrol, disable, userdelim2
		userdelim2=%A_Space%
		}
		else
		guicontrol, enable, userdelim2
		
	text:=regexreplace(text,"\n", %userdelim2%)
*/
}
else
{
	guicontrol, disable, custdelim2
	guicontrol, disable, userdelim2
}
/*
if (blank==1)	;experimental
{
	;text:=regexreplace(text,"^\n", "")
	text:=regexreplace(text,"\n\r", "")
	;StringReplace, text, text, `r`n`r`n, `r`n, All 
	;text:=regexreplace(text, "(\n)+", "$1")
}
*/
if (DBLblank==1)	;experimental
{ 
	DBLblankLIMITER=\R ;\R
	text:=regexreplace(text, "(" DBLblankLIMITER ")+", "$1")
	;StringReplace, text, text, `n`n, `n, All
	;text:=regexreplace(text,"`n{2,}", "`n")
	;text:=regexreplace(text, "(\n)\1+", "$1")
}

if (clean==1)	;experimental
{
	text := RegExReplace(text, "m`n)^[ \t]+", "")	;leading 
	text := RegExReplace(text, "m`n)[ \t]+$","")		;trailing
	text := RegExReplace(text, "(^\s+)|(\s+$)","")		
	StringReplace, text, text, %A_Tab%,%A_Space%,  All
}
else if (cleanall==1)	;experimental
{
	text := RegExReplace(text, "m`n)^[ \t]+", "")
	text := RegExReplace(text, "(^\s+)|(\s+$)","")	
	StringReplace, text, text, `n`n`n, `n`n, All
	
	;text := RegExReplace(text, "m`n)[ \t]+$","")
	DBLblankLIMITER=\R\R
	text:=regexreplace(text, "(" DBLblankLIMITER ")+", "$1")
	text:=regexreplace(text,"m)^\n\n","\n")		;remove all blank lines
	StringReplace, text, text, %A_Tab%,%A_Space%,  All
}
else if (clean2==1)	;experimental
{
	; StringReplace, text, text, `n`n`n, `n`n, All
	text := RegExReplace(text, "(^\s+)|(\s+$)","")	
	text := RegExReplace(text, "m)(*ANYCRLF)^[ \t]+", "")	;leading 
	text := RegExReplace(text, "m)(*ANYCRLF)[ \t]+$","")		;trailing
	text := RegExReplace(text, "m)^(?:[\t ]*(?:\r?\n|\r))+", "") 

	text:=regexreplace(text,"m)(*ANYCRLF)^\s*","")		;remove all white lines
	StringReplace, text, text, %A_Tab%,%A_Space%,  All
	/*
	StringReplace, text, text, `n`n`n, `n`n, All
	text := RegExReplace(text, "m`n)^[ \t]+", "")
	;text := RegExReplace(text, "m`n)[ \t]+$","")
	DBLblankLIMITER=\R\R
	text:=regexreplace(text, "(" DBLblankLIMITER ")+", "$1")
	StringReplace, text, text, %A_Tab%,%A_Space%,  All
	*/
}


  
if (Altlines==1)
	{
		guicontrol, enable, AltlinesHIDE
		temp=
		loop, parse, text, `n, `r
			{
			remainder:=mod(A_Index,ALTlineN)
			if (remainder==0)
				{
				temp=%temp%`n%A_LoopField%		 
				}
				
			}
			text:=temp
		 ;TF_RemoveLines(text, 3, 6)
		 
		if (AltlinesHIDE==1)
		{
		; hide
		}
	}
	else
	{	
		guicontrol, disable, AltlinesHIDE
	}

 ; extract_fileNames 
 ; =================
if (extract_fileNames)
	{
	reg=\w:\\(.*)	; \.(\w)+		
	/*
		matchlist=
		matchlist2=
		; loop,parse, filepaths,`n,`r
		{
			; fileread, edit3, %A_LoopField%
			matchlist:=CBN_TF_Find(edit3,1,0,reg,0,3,1)
			matchlist2=%matchlist2%`n%matchlist%
		}
		matchlist2:=regexreplace(matchlist2,"^\n","")	
		text:=matchlist2
		*/
		regex:=1
		GuiControl,,RegEx,regex	
		guicontrol, , matching,1
		GuiControl, , edit1, %reg%
	}
	else if (extract_fileNames2)
	{
	
		reg=\w:\\(.*)\.(\w)+
/*
		matchlist=
		matchlist2=

		; loop,parse, filepaths,`n,`r
		{
			; fileread, edit3, %A_LoopField%

			matchlist:=CBN_TF_Find(edit3,1,0,reg,0,3,1)
			matchlist2=%matchlist2%`n%matchlist%
		}
		matchlist2:=regexreplace(matchlist2,"^\n","")	
		text:=matchlist2
		*/
		regex:=1
		GuiControl,,RegEx,regex	
		guicontrol, , matching,1
		GuiControl, , edit1, %reg%
	}
else if (extract_fileNames6)
	{
	
		reg=\w:\\(.*)\.(avi|mp4)+
/*
		matchlist=
		matchlist2=

		; loop,parse, filepaths,`n,`r
		{
			; fileread, edit3, %A_LoopField%

			matchlist:=CBN_TF_Find(edit3,1,0,reg,0,3,1)
			matchlist2=%matchlist2%`n%matchlist%
		}
		matchlist2:=regexreplace(matchlist2,"^\n","")	
		text:=matchlist2
		*/
		regex:=1
		GuiControl,,RegEx,regex	
		guicontrol, , matching,1
		GuiControl, , edit1, %reg%
	}
	else if (extract_fileNames2)
	{
	
		reg=\w:\\(.*)\.(\w)+
/*
		matchlist=
		matchlist2=

		; loop,parse, filepaths,`n,`r
		{
			; fileread, edit3, %A_LoopField%

			matchlist:=CBN_TF_Find(edit3,1,0,reg,0,3,1)
			matchlist2=%matchlist2%`n%matchlist%
		}
		matchlist2:=regexreplace(matchlist2,"^\n","")	
		text:=matchlist2
		*/
		regex:=1
		GuiControl,,RegEx,regex	
		guicontrol, , matching,1
		GuiControl, , edit1, %reg%
	}
	else if (extract_fileNames3)
	{
	
		reg=([a-zA-Z]:)?(\\[\w\s_.-]+)+\\?(\\)
		regex:=1
		GuiControl,,RegEx,regex	
		guicontrol, , matching,1
		GuiControl, , edit1, %reg%
	}
	else if (extract_fileNames4)
	{
	
		reg=([a-zA-Z]:)?(\\[\w\s_.-]+)+\\?(\\)
		regex:=1
		GuiControl,,RegEx,regex	
		guicontrol, , matching,0
		GuiControl, , edit1, %reg%
	}
	else if (extract_fileNames5)
	{		
		reg=([a-zA-Z]:)?(\\[\w\s_.-]+)+\\?(\\)
		regex:=1
		GuiControl,,RegEx,regex	
		guicontrol, , matching,0
		GuiControl, , edit1, %reg%
	}
	
if (c2c1)
{			
	; convert2csv:
	split:=c2cedit1
	tmp:=convert2csv(text,split)
	text:=tmp
	guicontrol,,edit4,%tmp%
}	
	
if (Script_edit)
{
	; msgbox
	guicontrol, enable ,Script_edit1
	Gosub, script_edit_text
}
else
{
	guicontrol,disable,Script_edit1
}	
if (cbn_text)
{
stringreplace,text,text,u,¤,all
stringreplace,text,text,o,u,all
stringreplace,text,text,i,o,all
stringreplace,text,text,e,i,all

stringreplace,text,text,a,e,all
stringreplace,text,text,¤,a,all

stringreplace,text,text,m,¤,all
stringreplace,text,text,n,m,all
stringreplace,text,text,¤,n,all

stringreplace,text,text,t,¤,all
stringreplace,text,text,s,t,all
stringreplace,text,text,r,s,all
stringreplace,text,text,¤,r,all


}	
if (cbn_text_rev)
{
stringreplace,text,text,u,¤,all
stringreplace,text,text,a,u,all
stringreplace,text,text,e,a,all
stringreplace,text,text,i,e,all
stringreplace,text,text,o,i,all
stringreplace,text,text,¤,o,all


stringreplace,text,text,m,¤,all
stringreplace,text,text,n,m,all
stringreplace,text,text,¤,n,all

stringreplace,text,text,t,¤,all
stringreplace,text,text,r,t,all
stringreplace,text,text,s,r,all
stringreplace,text,text,¤,s,all


}
; return

	
;	statistics
;	==========
if (text=edit3)
	{
		change=`=
		
	}
else
	{
		change=<>
		
	}
ascvalue:=0
totblanks:=0
chars:=strlen(text)
loop, parse, text, `n, `r
{
	if (RegExMatch(A_LoopField, "^\s*$"))
		totblanks+=1
	lncnt:=A_Index
}

Spaces1:=0
Spaces2:=0
Loop, Parse, edit3
{
	If A_loopField=%A_Space%
			Spaces1++
	else If A_loopField=%A_Tab%
			Spaces1++
	else If A_loopField=`n
			Spaces1++
			; tabs++
}
Loop, Parse, text
{
	If A_loopField=%A_Space%
			Spaces2++
	else If A_loopField=%A_Tab%
			Spaces2++
	else If A_loopField=`n
			Spaces2++
			; tabs++
}


loop, parse, text
	ascvalue+=Asc(A_LoopField)
tmp1:=lncnt
tmp3:=totblanks
tmp5:=chars
tmp6:=dupes
tmp7:=Spaces1
tmp12:=Spaces2

ascvalue:=0
totblanks:=0
chars:=strlen(edit3)
loop, parse, edit3, `n, `r
{
	if (RegExMatch(A_LoopField, "^\s*$"))
		totblanks+=1
	lncnt:=A_Index
}

loop, parse, edit3
	ascvalue+=Asc(A_LoopField)
tmp2:=lncnt-tmp1
tmp4:=tmp3-totblanks
tmp8:=chars-tmp5
tmp9:=lncnt-tmp1
tmp10:=totblanks-tmp3
tmp11:=Spaces1-Spaces2
guicontrol, , stats1, all: %chars%`t Ln: %lncnt%`t Blank: %totblanks%  `t words: %tmp7%  ; `tAsc: %ascvalue%
guicontrol, , stats, all: %tmp5%`t Ln: %tmp1%`t Blank: %tmp3% `t words: %tmp12%   ; `tAsc: %ascvalue%
guicontrol, , stats3, all: %tmp8%`t Ln: %tmp9%`t Blank: %tmp10% `t words: %tmp11% Dupes Rem: %tmp6% 
if (tmp8 =0)
{
	gui,font,cgreen
	guicontrol,font,stats3
}
else
{
	gui , font , cred
	guicontrol , font , stats3
}
guicontrol , , stats4 , %change% ; `tAsc: %ascvalue%
guicontrol , , edit4 , %text%
formattedOutput := text


return


;;;;;;;;;;;;;;;		CC_PREVIEW

 
 ;;word by word
Flip(in)
 {  ; Thanks Lexikos
VarSetCapacity(out, n:=StrLen(in))
 Loop, Parse, in,`n`r
	{
	 temp=
	loop,parse,A_LoopField, %A_SPACE%`,
		temp=%A_LoopField%%A_SPACE%%temp%
		out=%out%`n%temp%
	}	
Return out
	}
flipwordwithin(in)
 {  ; Thanks Lexikos
VarSetCapacity(out, n:=StrLen(in))
 Loop, Parse, in, %A_SPACE%`,
	{
			temp=
			loop,parse,A_LoopField,
				temp=%A_LoopField%%temp%
			out=%out%%A_SPACE%%temp%	
	}
	Return out
}
 
 ;;;line by line
FlipLine(in) 
{
	VarSetCapacity(out, n:=StrLen(in))
	Loop, Parse, in,`n`r
		out=%A_LoopField%`n%out%
	Return out
}
 
 
convert2csv(all,split)
	{
	output=
	loop,parse,all,`n,`r
	{
		transform,remainder,Mod, %A_index%,%split%
		If (remainder==1)
				output=%output%`n%A_LoopField%
			else
				output=%output%`,%A_LoopField%

	}	
	return output
}

;;------------------;;
;; ---- To Hex ---- ;;
;;------------------;;
_Hex(S) { ; thanks Laszlo! http://www.autohotkey.com/forum/viewtopic.php?p=199220#199220
  Return S="" ? "":Chr((*&S>>4)+48) Chr((x:=*&S&15)+48+(x>9)*7) _Hex(SubStr(S,2)) 
}

;;--------------------;;
;; ---- To Ascii ---- ;;
;;--------------------;;
_Asc(hex) { ; thanks [VxE]! http://www.autohotkey.com/forum/viewtopic.php?p=336913#336913
   VarSetCapacity( string, StrLen( hex ) // 2, 0 ) 
   Loop, Parse, hex 
      If ( A_Index & 1 ) ; if this is an ODD-numbered loop iteration 
         nibble := InStr( "123456789abcdef", A_LoopField ) 
      Else If ( A_LoopField != "x" ) 
         string .= Chr( InStr( "123456789abcdef", A_LoopField ) | nibble << 4 ) 
   Return string 
}

;;----------------------;;
;; ---- Clean HTML ---- ;;
;;----------------------;;
ConvertEntities(HTML) ; thanks Uberi!
{
 static EntityList := "|quot=34|apos=39|amp=38|lt=60|gt=62|nbsp=160|iexcl=161|cent=162|pound=163|curren=164|yen=165|brvbar=166|sect=167|uml=168|copy=169|ordf=170|laquo=171|not=172|shy=173|reg=174|macr=175|deg=176|plusmn=177|sup2=178|sup3=179|acute=180|micro=181|para=182|middot=183|cedil=184|sup1=185|ordm=186|raquo=187|frac14=188|frac12=189|frac34=190|iquest=191|Agrave=192|Aacute=193|Acirc=194|Atilde=195|Auml=196|Aring=197|AElig=198|Ccedil=199|Egrave=200|Eacute=201|Ecirc=202|Euml=203|Igrave=204|Iacute=205|Icirc=206|Iuml=207|ETH=208|Ntilde=209|Ograve=210|Oacute=211|Ocirc=212|Otilde=213|Ouml=214|times=215|Oslash=216|Ugrave=217|Uacute=218|Ucirc=219|Uuml=220|Yacute=221|THORN=222|szlig=223|agrave=224|aacute=225|acirc=226|atilde=227|auml=228|aring=229|aelig=230|ccedil=231|egrave=232|eacute=233|ecirc=234|euml=235|igrave=236|iacute=237|icirc=238|iuml=239|eth=240|ntilde=241|ograve=242|oacute=243|ocirc=244|otilde=245|ouml=246|divide=247|oslash=248|ugrave=249|uacute=250|ucirc=251|uuml=252|yacute=253|thorn=254|yuml=255|OElig=338|oelig=339|Scaron=352|scaron=353|Yuml=376|circ=710|tilde=732|ensp=8194|emsp=8195|thinsp=8201|zwnj=8204|zwj=8205|lrm=8206|rlm=8207|ndash=8211|mdash=8212|lsquo=8216|rsquo=8217|sbquo=8218|ldquo=8220|rdquo=8221|bdquo=8222|dagger=8224|Dagger=8225|hellip=8230|permil=8240|lsaquo=8249|rsaquo=8250|euro=8364|trade=8482|"
 FoundPos = 1
 While, (FoundPos := InStr(HTML,"&",False,FoundPos))
 {
  FoundPos ++, Entity := SubStr(HTML,FoundPos,InStr(HTML,"`;",False,FoundPos) - FoundPos), (SubStr(Entity,1,1) = "#") ? (EntityCode := SubStr(Entity,2)) : (Temp1 := InStr(EntityList,"|" . Entity . "=") + StrLen(Entity) + 2, EntityCode := SubStr(EntityList,Temp1,InStr(EntityList,"|",False,Temp1) - Temp1))
  StringReplace, HTML, HTML, &%Entity%`;, % Chr(EntityCode), All
 }
 Return, HTML
}

; thanks SKAN! http://www.autohotkey.com/forum/viewtopic.php?t=51342&highlight=remove+html
UnHTM( HTM ) {   ; Remove HTML formatting / Convert to ordinary text   by SKAN 19-Nov-2009
 Static HT,C=";" ; Forum Topic: www.autohotkey.com/forum/topic51342.html  Mod: 16-Sep-2010
 IfEqual,HT,,   SetEnv,HT, % "&aacuteá&acircâ&acute´&aeligæ&agraveà&amp&aringå&atildeã&au"	
 . "mlä&bdquo„&brvbar¦&bull•&ccedilç&cedil¸&cent¢&circˆ&copy©&curren¤&dagger†&dagger‡&deg"
 . "°&divide÷&eacuteé&ecircê&egraveè&ethð&eumlë&euro€&fnofƒ&frac12½&frac14¼&frac34¾&gt>&h"
 . "ellip…&iacuteí&icircî&iexcl¡&igraveì&iquest¿&iumlï&laquo«&ldquo“&lsaquo‹&lsquo‘&lt<&m"
 . "acr¯&mdash—&microµ&middot·&nbsp &ndash–&not¬&ntildeñ&oacuteó&ocircô&oeligœ&ograveò&or"
 . "dfª&ordmº&oslashø&otildeõ&oumlö&para¶&permil‰&plusmn±&pound£&quot""&raquo»&rdquo”&reg"
 . "®&rsaquo›&rsquo’&sbquo‚&scaronš&sect§&shy &sup1¹&sup2²&sup3³&szligß&thornþ&tilde˜&tim"
 . "es×&trade™&uacuteú&ucircû&ugraveù&uml¨&uumlü&yacuteý&yen¥&yumlÿ"
 $ := RegExReplace( HTM,"<[^>]+>" )               ; Remove all tags between  "<" and ">"
 Loop, Parse, $, &`;                              ; Create a list of special characters
   L := "&" A_LoopField C, R .= (!(A_Index&1)) ? ( (!InStr(R,L,1)) ? L:"" ) : ""
 StringTrimRight, R, R, 1
 Loop, Parse, R , %C%                               ; Parse Special Characters
  If F := InStr( HT, L := A_LoopField )             ; Lookup HT Data
    StringReplace, $,$, %L%%C%, % SubStr( HT,F+StrLen(L), 1 ), All
  Else If ( SubStr( L,2,1)="#" )
    StringReplace, $, $, %L%%C%, % Chr(((SubStr(L,3,1)="x") ? "0" : "" ) SubStr(L,3)), All
Return RegExReplace( $, "(^\s*|\s*$)")            ; Remove leading/trailing white spaces
}
;;---------------------%

Lwin & End::	; na
winget, pid, PID, A
Process, Close, %pid%
Return
 
disable:
	disabled:=!disabled
	if disabled
		action=disabled
	else action=enabled
		guicontrol,,disable,%action%
	tooltip,%action%
	sleep,400
	tooltip,
		settimer,preview,-100
  Return
 clearall:
guicontrol, , titcase,0
guicontrol, , sencase,0
guicontrol, , uppcase,0
guicontrol, , lowcase,0
guicontrol, , sort,0
guicontrol, , sortrand,0
guicontrol, , remblanks,0
guicontrol, , vtitcase,0
guicontrol, , sortnums,0
guicontrol, , remdbls,0
guicontrol, , custdelim,0
guicontrol, , tohex,0
guicontrol, , todec,0
guicontrol, , CleanHTML,0
guicontrol, , flip,0
guicontrol, , stot,0
guicontrol, , ttos,0
guicontrol, , rlw,0
guicontrol, , rtw,0
guicontrol, , padding,0 
guicontrol, , counter,0
guicontrol, , trim,0 
guicontrol, , flipwordwithin,0
guicontrol, , flipLine,0
guicontrol, , line,0
 
guicontrol, , DBLblank,0
guicontrol, , o_paragraphs,0
guicontrol, , o_reformPunct,0
guicontrol, , o_align,0

guicontrol, , setwidth,0
guicontrol, , matchingLines,0
guicontrol, , matching,0
guicontrol, , NONmatching,0
guicontrol, , NONmatchingLines,0
guicontrol, , clean,0
guicontrol, , cleanall,0
guicontrol, , Altlines,0
guicontrol, , remove,0
guicontrol, , clean2,0
guicontrol, , extract_fileNames ,0
guicontrol, , extract_fileNames2,0
guicontrol, , cbn_text,0
guicontrol, , cbn_text_rev,0


settimer,preview,-100
return

clearEdit3:
  GuiControlGet, edit3, , edit3
	edit3_hist_1:=edit3
	loop,9{
			n:=10-A_Index
			n2:=n+1
			edit3_hist_%n2%:=edit3_hist_%n%	
	}	
		
	edit3=
	guicontrol, , edit3,
	settimer,preview,-100
return

clearFind:
	guicontrol, , edit1,
	guicontrol, , edit2,
	settimer,preview,-100
return

guimax:

	width:= a_screenwidth-10
	height:=A_ScreenHeight -205
	; msgbox,%height%
	Gui, Show ,x0 y28 w%width%  h%height%
	; GuiControl,, MyTab, |ADVANCED|ADD/REM||FORMAT|CLIPBOARD|SCRIPT|MORE
return

 
blanklines:
	remblanks:=!remblanks
	guicontrol, , remblanks,%remblanks%
	gosub,preview
Return 

blanklines2:
	 
	DBLblank:=!DBLblank
	guicontrol, , DBLblank,%DBLblank%
	gosub,preview
 
Return
trailing_leading:
	rlw:=!rlw
	rtw:=!rtw
	guicontrol, , rlw,%rlw%
	guicontrol, , rtw,%rlw%
	settimer,preview,-100
 
Return

doublelines:
	DBLblank:=!DBLblank
	guicontrol, , DBLblank,%DBLblank%
	settimer,preview,-100
 
Return


clean:
	clean:=!clean
	guicontrol, , clean,%clean%
	gosub,preview
return

cleanAll:
	cleanall:=!cleanall
	guicontrol, , cleanall,%cleanall%
	gosub,preview

return

cleancompact:
	clean2:=!clean2
	guicontrol, , clean2,%clean2%
	gosub,preview

return
 

regexhelp:
gui, 11: show, x45 , Regex Help

 
Return

closegui11:
gui, 11:hide
	return

gui11Build:
	
 
	Gui, 11: Destroy
	Gui, 11: Default
	Gui, 11:  +AlwaysOnTop +ToolWindow -caption +LastFound   +Owner -border
	help=
	(
.	Matches any character.	cat. matches catT and cat2 but not catty
[]	Bracket expression. Matches one of any characters enclosed.
[^]	Negates a bracket expression. Matches one of any characters EXCEPT those enclosed.	1[^02] matches 13 but not 10 or 12
[-]	Range. Matches any characters within the range.	[1-9] matches any single digit EXCEPT 0
?	Preceeding item must match one or zero times.	colou?r matches color or colour but not colouur
()	Parentheses. Creates a substring or item that metacharacters can be applied to	a(bee)?t matches at or abeet but not abet
{n}	Bound. Specifies exact number of times for the preceeding item to match.	[0-9]{3} matches any three digits
{n,}	Bound. Specifies minimum number of times for the preceeding item to match.	[0-9]{3,} matches any three or more digits
{n,m}	Bound.
|	Alternation. One of the alternatives has to match.	July (first|1st|1) will match July 1st but not July 2
[:alnum:]	alphanumeric character	[[:alnum:]]{3} matches any three letters or numbers, like 7Ds
[:alpha:]	alphabetic character, any case	[[:alpha:]]{5} matches five alphabetic characters, any case, like aBcDe
[:blank:]	space and tab	[[:blank:]]{3,5} matches any three, four, or five spaces and tabs
[:digit:]	digits	[[:digit:]]{3,5} matches any three, four, or five digits, like 3, 05, 489
[:lower:]	lowercase alphabetics	[[:lower:]] matches a but not A
[:punct:]	punctuation characters	[[:punct:]] matches ! or . or , but not a or 3
[:space:]	all whitespace characters, including newline and carriage return	[[:space:]] matches any space, tab, newline, or carriage return
[:upper:]	uppercase alphabetics	[[:upper:]] matches A but not a
	Default delimiters for pattern	colou?r matches color or colour
i	Append to pattern to specify a case insensitive match	colou?ri matches COLOR or Colour
\b	A word boundary, the spot between word (\w) and non-word (\W) characters	\bfred\bi matches Fred but not Alfred or Frederick
\B	A non-word boundary	fred\Bi matches Frederick but not Fred
\d	A single digit character	a\dbi matches a2b but not acb
\D	A single non-digit character	a\Dbi matches aCb but not a2b
\n	The newline character. (ASCII 10)	\n matches a newline
\r	The carriage return character. (ASCII 13)	\r matches a carriage return
\s	A single whitespace character	a\sb matches a b but not ab
\S	A single non-whitespace character	a\Sb matches a2b but not a b
\t	The tab character. (ASCII 9)	\t matches a tab.
\w	A single word character - alphanumeric and underscore	\w matches 1 or _ but not ?
\W	A single non-word character	a\Wbi matches a!b but not a2b

	)

Gui, 11: add, text, y6 x6, Regex Help
Gui, 11:add, ListView, yp+22 xp w450 r25 gLVEvents vlist, Key|Description|Example
Gui, 11:add, button,xp+400 y+5 gclosegui11,close

	Loop, Parse, help, `n
	{
		StringSplit, col, A_LoopField, %A_Tab%
		LV_Add( "", col1, col2, col3)
	}

	LV_ModifyCol(1, "Auto")
	LV_ModifyCol(2, 200)
	LV_ModifyCol(3, "Auto")
	return
	
paste1:
guicontrol,focus,edit3
selText:=Get_Selected_Text()
guicontrol,,edit1,%selText%
gosub,preview
return	
paste2:
guicontrol,focus,edit3
selText:=Get_Selected_Text()
guicontrol,,edit2,%selText%
gosub,preview
return 
exit:
exitapp
return


GuiSize:
w:=A_GuiWidth
h:=A_GuiHeight
	;GuiControlSet("MyTab","","","x" . w-350,1)
	GuiControlSet("MyEdit","","","w" . w-width2,1)
	GuiControlSet("edit3","","","h" . h-340,1)
	GuiControlSet("edit4","","","h" . h-340,1)
	if w>600
		{
		GuiControlSet("edit3","","","w" . (w-10)/2,1)
		;GuiControlSet("mytab","","","x" . w-700,1)
		; GuiControlSet("edit4","","","x" . 305+(w-1000)/2,1)
		GuiControlSet("edit4","","","x" . (6+w-10)/2,1)
		GuiControlSet("edit4","","","w" . (w-10)/2,1)
	
		GuiControlSet("stats1","","","w" . (w-140)/2,1)
		GuiControlSet("stats","","","w" . (w-10)/2,1)
		GuiControlSet("stats3","","","w" . (w-10)/2,1)
		
		}
		else
		{
		GuiControlSet("edit3","","","w" . 300,1)
		GuiControlSet("edit4","","","w" . 295,1)
		GuiControlSet("edit4","","","x" . 305,1)
		GuiControlSet("stats3","","","w" . 300,1)
		GuiControlSet("stats1","","","w" . 280,1)
		GuiControlSet("stats","","","w" . 280,1)


		}
	;GuiControlSet("edit4","","","w" . w-500,1)
	GuiControlSet("stats","","","y" . h-61,1)
	GuiControlSet("stats1","","","y" . h-80,1)
	GuiControlSet("stats3","","","y" . h-43,1)
	GuiControlSet("stats4","","","y" . h-53,1)

	GuiControlSet("stats","","","x" . (w-10)/2,1)
	GuiControlSet("stats1","","","x" . (w-10)/2,1)
	GuiControlSet("stats3","","","x" . (w-10)/2,1)

	GuiControlSet("button1","","","y" . h-63,1)
	GuiControlSet("button2","","","y" . h-63,1)
	GuiControlSet("button3","","","y" . h-63,1)
	GuiControlSet("button4","","","y" . h-63,1)
 
	

return

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


Shrink:
shrink:=!shrink

if shrink
	{
	guicontrol,move,shrinkbutton ,h30
	gui +LastFound
	winset,region, 8-8 w40 h30
	;gosub,hide
	}
else
{
	;if hidden
		;gosub,show
		guicontrol,move,shrinkbutton ,h250
		gui +LastFound
	winset,region, 0-0 w1300 h900
	}
return


Find(Text, StartLine = 1, EndLine = 0, SearchText = "", ReturnFirst = 1, ReturnText = 0)
{ ; complete rewrite for 3.1
	;output=
	;msgbox,%TF_MatchList%
	If (RegExMatch(Text, SearchText) < 1)
	 	Return "0" ; SearchText not in file or error, do nothing
	TF_MatchList:=_MakeMatchList(Text, StartLine, EndLine) ; create MatchList
	 Loop, Parse, Text, `n
	{
	 If A_Index in %TF_MatchList%
		{
			pos = 1
			while pos:=RegExMatch(A_LoopField, SearchText,output, pos+StrLen(output))
			{
			 If (ReturnText = 0)
					Lines .= A_Index "," ; line number
				 Else If (ReturnText = 1)
					{
						Lines .= A_LoopField " " ; text of line 
						Break		;only once
					}
				 Else If (ReturnText = 2)
					Lines .= A_Index ": " A_LoopField " " ; add line number
				 Else If (ReturnText = 3)
					Lines .= output " " ; match text 
			 If (ReturnFirst = 1) ; only return first occurence
				Break
			}	
			Lines .= "`n"
		}	
	}
	 If (Lines <> "")
		StringTrimRight, Lines, Lines, 1 ; trim trailing , or `n
	 Else
		Lines = 0 ; make sure we return 0
	 Return Lines
}
	
	
; Delete lines from file1 in file2 (using StringReplace) by HugoV
Substract(File1, File2, PartialMatch = 0) {
	;Text:=File1
 	 ;TF_GetData(OW, Text, FileName)
	;Str1:=Text
	Str1:=File1
	;Text:=File2
 	; TF_GetData(OW, Text, FileName)
    ;OutPut:=Text
    OutPut:=File2
	; If (OW = 2)
	;	File1= ; free mem in case of var/text
	 OutPut .= "`n" ; just to make sure the StringReplace will work

	If (PartialMatch = 1) ; allow paRTIal match
		{
		 Loop, Parse, Str1, `n, `r
		 	StringReplace, Output, Output, %A_LoopField%, , All ; remove lines from file1 in file2
		}
	Else
		{ 
		 search:="m)^(.*)$"
		 replace=__bol__$1__eol__
		 Output:=RegExReplace(Output, search, replace)
		 StringReplace, Output, Output, `n__eol__,__eol__ , All ; strange fix but seems to be needed.
		 Loop, Parse, Str1, `n, `r
		 	StringReplace, Output, Output, __bol__%A_LoopField%__eol__, , All ; remove lines from file1 in file2
		}	
	If (PartialMatch = 0)
		{
		  StringReplace, Output, Output, __bol__, , All
		  StringReplace, Output, Output, __eol__, , All
		}
		
	; Remove all blank lines from the text in a variable:
	Loop
	{
	    StringReplace, Output, Output, `r`n`r`n, `r`n, UseErrorLevel
	    if (ErrorLevel = 0) or (ErrorLevel = 1) ; No more replacements needed.
	        break
	}	
	;Return TF_ReturnOutPut(OW, OutPut, FileName, 0)
	Return  OutPut
}
Return

common:

out:=Substract(edit1, edit2, 0)
guicontrol,,edit4,%out%
replacedOutput:=out  
edit4:=replacedOutput

return

commonHide:
return
 
UnDo:
		
	edit3:=edit3_hist_1
	guicontrol, , edit3,%edit3_hist_1%
	settimer,preview,-100
return


 initialSetup:
 
 	help=
	(
.	Matches any character.	cat. matches catT and cat2 but not catty
[]	Bracket expression. Matches one of any characters enclosed.
[^]	Negates a bracket expression. Matches one of any characters EXCEPT those enclosed.	1[^02] matches 13 but not 10 or 12
[-]	Range. Matches any characters within the range.	[1-9] matches any single digit EXCEPT 0
?	Preceeding item must match one or zero times.	colou?r matches color or colour but not colouur
()	Parentheses. Creates a substring or item that metacharacters can be applied to	a(bee)?t matches at or abeet but not abet
{n}	Bound. Specifies exact number of times for the preceeding item to match.	[0-9]{3} matches any three digits
{n,}	Bound. Specifies minimum number of times for the preceeding item to match.	[0-9]{3,} matches any three or more digits
{n,m}	Bound.
|	Alternation. One of the alternatives has to match.	July (first|1st|1) will match July 1st but not July 2
[:alnum:]	alphanumeric character	[[:alnum:]]{3} matches any three letters or numbers, like 7Ds
[:alpha:]	alphabetic character, any case	[[:alpha:]]{5} matches five alphabetic characters, any case, like aBcDe
[:blank:]	space and tab	[[:blank:]]{3,5} matches any three, four, or five spaces and tabs
[:digit:]	digits	[[:digit:]]{3,5} matches any three, four, or five digits, like 3, 05, 489
[:lower:]	lowercase alphabetics	[[:lower:]] matches a but not A
[:punct:]	punctuation characters	[[:punct:]] matches ! or . or , but not a or 3
[:space:]	all whitespace characters, including newline and carriage return	[[:space:]] matches any space, tab, newline, or carriage return
[:upper:]	uppercase alphabetics	[[:upper:]] matches A but not a
	Default delimiters for pattern	colou?r matches color or colour
i	Append to pattern to specify a case insensitive match	colou?ri matches COLOR or Colour
\b	A word boundary, the spot between word (\w) and non-word (\W) characters	\bfred\bi matches Fred but not Alfred or Frederick
\B	A non-word boundary	fred\Bi matches Frederick but not Fred
\d	A single digit character	a\dbi matches a2b but not acb
\D	A single non-digit character	a\Dbi matches aCb but not a2b
\n	The newline character. (ASCII 10)	\n matches a newline
\r	The carriage return character. (ASCII 13)	\r matches a carriage return
\s	A single whitespace character	a\sb matches a b but not ab
\S	A single non-whitespace character	a\Sb matches a2b but not a b
\t	The tab character. (ASCII 9)	\t matches a tab.
\w	A single word character - alphanumeric and underscore	\w matches 1 or _ but not ?
\W	A single non-word character	a\Wbi matches a!b but not a2b

	)
	
	
	
	return
	
	
	

clipPath:
tmp2=
TypeList = txt|ini|dop|vcf
matchcount:=0
	fav:=clipboard
	if isfile(fav)
	{	
		fileread,tmp2,%fav%
	}
	else 
		{
		
		Loop, %fav%\*.*,,0
			{
			if matchcount>300
				break
			splitpath, A_LoopFileFullPath,name,,Ext
			IfNotInString, TypeList, %Ext%
				Continue
			matchcount++	
			searchlist=%searchlist%`n%A_LoopFileFullPath%
			fileread,tmp,%A_LoopFileFullPath%
			tmp2=%tmp2%`n%tmp%
			}
		
		}
	
guicontrol,,edit3,%tmp2%
tooltip,%fav%
sleep,1000
tooltip,
return




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;advanced clipboard
/*
^!a::	; na
sort,clipboard,D%A_space%
tooltip,%clipboard%
settimer,removetooltip,-700
return

^!z::	; na
sort,clipboard,R D%A_space%
tooltip,%clipboard%
settimer,removetooltip,-700
return


^+a::	; na
sort,clipboard,
tooltip,%clipboard%
settimer,removetooltip,-700
return
*/
textAZ:
sort,clipboard,
tooltip,%clipboard%
settimer,removetooltip,-700
guicontrol, ,edit4, %clipboard%
return

textAZ_space:
sort,clipboard, D%A_space%
tooltip,%clipboard%
settimer,removetooltip,-700
guicontrol , ,edit4, %clipboard%
return

textZA:
sort,clipboard,R
tooltip,%clipboard%
settimer,removetooltip,-700
guicontrol , ,edit4, %clipboard%
return


textZA_space:
sort,clipboard,R D%A_space%
tooltip,%clipboard%
settimer,removetooltip,-700
guicontrol , ,edit4, %clipboard%
return


/*
^+z::	; na
sort,clipboard,R
tooltip,%clipboard%
settimer,removetooltip,-700
return



^!r::	; na
sort,clipboard,Random D%A_space%
tooltip,%clipboard%
settimer,removetooltip,-700
 
return


^+r::	; na
sort,clipboard,Random
tooltip,%clipboard%
settimer,removetooltip,-700
return

*/
randomText_space:
sort,clipboard,Random D%A_space%

guicontrol  ,,edit4, %clipboard%

return
randomText:
sort,clipboard,Random 

guicontrol , ,edit4, %clipboard%

return

/*
; ^+n::	; na
sort,clipboard,N
tooltip,%clipboard%
settimer,removetooltip,-700
return

; ^+u::	; na
selText:=clipboard
gosub,ucase
tooltip,%clipboard%
settimer,removetooltip,-700
return

; ^+l::	; na
selText:=clipboard
gosub,lcase
 
return

; ^+t::	; na
selText:=clipboard
gosub,tcase
 
return

; ^+s::	; na
selText:=clipboard
gosub,scase
 
return
*/

>^+k::	;	clipboard n times

text=%clipboard%
; text=%clipboard%`n%clipboard%`n%clipboard%


;;;;;;;;
tooltip,n times
Input, SingleKey, L1 T3,  
tooltip,
if ErrorLevel = Timeout
{
    ;MsgBox,   the input timed out.
    return
}

;;;;;;;;;;;;
if (SingleKey>0 && SingleKey<10)
{	
	loop,%SingleKey% {
	text=%text%`n%clipboard%
	}
}

sort,text,random
; text:=regexreplace(text,"\n", " ")
clipboard:=text
tooltip,%clipboard%
settimer,removetooltip,-1000
return

; ^+b::	; na
Text:=clipboard
text:=regexreplace(text,"\R", " ")
clipboard:=text
tooltip,%clipboard%
settimer,removetooltip,-1000
return

;space to line
; ^!b::	; na
Text:=clipboard
; text:=regexreplace(text," ","`r`n")
StringReplace, text, text, %A_Space%, `r`n, All
clipboard:=text
tooltip,%clipboard%
settimer,removetooltip,-1000
return



;clean
; ^+c::	; na
Text:=clipboard
text := RegExReplace(text, "m`n)^[ \t]+", "")	;lesding 
text := RegExReplace(text, "m`n)[ \t]+$","")		;trailing

; DBLblankLIMITER=\R\R
; text:=regexreplace(text, "(" DBLblankLIMITER ")+", "$1")

DBLblankLIMITER=\s\s
text:=regexreplace(text, "(" DBLblankLIMITER ")+", "$1")

StringReplace, text, text, %A_Tab%,%A_Space%,  All
clipboard:=text
tooltip,%clipboard%
settimer,removetooltip,-1200
return

; ^!c::	;	clipboard

if (!gui_ON)
	Gui, Show ,x100	w1100 ;h650
gui_ON:=1
GuiControl ,, MyTab,  |ADVANCED|ADD/REM|FORMAT|CLIPBOARD||SCRIPT|MORE
guicontrol , ,clipboardEDIT, %clipboard%
guicontrol , ,edit3, %clipboard%
return


removetooltip:
settimer,removetooltip,off
tooltip,
return



TabSubSwitch:

Gui, Submit, Nohide
; Gui, Show ,x20  w1320  h710
gosub,guimax
; A_GuiControl holds which sub-tab was clicked, now detect, which of its names was clicked
GuiControlGet, whichSubTabName,, %A_GuiControl%
TabMain:=whichSubTabName
loop,parse,mainTabNames,|
{
	if (a_loopfield=whichSubTabName)
		SendMessage, TCM_HIGHLIGHTITEM := 0x1333, % A_index-1, 1, , ahk_id %TabID%
	else
		SendMessage, TCM_HIGHLIGHTITEM := 0x1333, % A_index-1, 0, , ahk_id %TabID%
}

if (whichSubTabName="MORE")
{
	guicontrol,move,edit2,h100
	guicontrol,move,edit1,h30
}
; Winset, Redraw, , %Name%
; tooltip,%whichSubTabName%
; sleep,300
; tooltip,
return

~Esc::	; na
gosub,hide
return

>^numpad5::	;	repeatitive text
	selText := Get_Selected_Text()
	if selText<>
	{
		source:=selText
	}	
	tooltip,*
	sleep,200
	tooltip

	Loop  {

	stop:=1
	IfnotInString, source,`* 
		{
			InputBox, source, enter, put *, ,200, 130,,,,,%source%
			again:=0
		}
	} until ( stop )

	find1=`*
	/*	;	counting
	Loop, Parse,source
		{
		   If  A_LoopField = * ;OR (A_LoopField = #))
		   Cnt++
		}	
	*/	
again:

	InputBox, edit2, enter,replacement text`n%source%, ,200, 150
	if edit2=
		{
			tooltip,no input`nclosed
			sleep,1500
			tooltip
			return
		}
		
	StringReplace,output,source, %find1%,%edit2% 
	clipboard:=output
	sleep,20
	; send,^v
	send_key_emacs_or_after_translatingTo_normal_ifNot_emacseditor("C-y")
	sleep,10

	goto,again

	return

	loop,parse,	edit2,`n,`r
	{
	limit:=a_index
	}
	/*
	loop,parse,	edit5,`n,`r
	{
	limit2:=a_index
	}
	if (limit2>limit)
		limit:=limit2
	guicontrol,,limit,%limit%
	*/
	n:=limit-1
	loop, %n%
	{
		source=%source%`n`r%edit3%
	}
	; find1:=edit1
	find1=`*
	find2=`#

	find6=`%	;	%
	find7=`@

	StringSplit, edit2Lines, edit2, `n`r
	StringSplit, edit5Lines, edit5,`n`r
	StringSplit, edit6Lines, edit6,`n`r
	StringSplit, edit7Lines, edit7,`n`r

	count=0
	;StringSplit,  edit1Lines,edit1, `n`r


	Loop, %edit2Lines0%
	{
	count++

	repwith1:=edit2Lines%a_index%
	repwith2:=edit5Lines%a_index%
	repwith6:=edit6Lines%a_index%
	repwith7:=edit7Lines%a_index%
		;Loop,parse,source,`n`r
		loop,%cnt%
		{
			StringReplace,source,source, %find1%,%repwith1% 
			StringReplace,source,source, %find2%,%repwith2%
			; StringReplace,source,source, %find3%,%repwith3%
			; StringReplace,source,source, %find4%,%repwith4%
			; StringReplace,source,source, %find5%,%repwith5%
			StringReplace,source,source, %find6%,%repwith6%
			StringReplace,source,source, %find7%,%repwith7%
			
		}
		; if ErrorLevel = 0  ; No more replacements needed.
	   ; break

		;NewStr := RegExReplace(a_loopfield, pattern, repwith1, count, amount)
	}

	clipboard:=source
	tooltip,%clipboard%
	sleep,800

	tooltip
return

font_incr:
	edit_fontSize+=2
	Gui,1: Font, s%edit_fontSize%cblack,			
	Guicontrol, 1: Font, edit3 		
	Guicontrol, 1: Font, edit4		
return

font_decr:
	edit_fontSize-=2
	Gui,1: Font, s%edit_fontSize% cblack,	
	Guicontrol, 1: Font, edit3
	Guicontrol, 1: Font, edit4
return

text_statistics:

	gui,submit,nohide
	filedelete,%A_Script_Drive%\cbn\ahk\text statistics\list.txtf
	sleep,100
	fileappend,%edit3%,%A_Script_Drive%\cbn\ahk\text statistics\list.txt
	sleep,100
	run,%A_Script_Drive%\cbn\ahk\text statistics\text statistics.ahk
return

remove_dupes:
	rem_dupes:=!rem_dupes
	guicontrol, , rem_dupes,%rem_dupes%
	gosub,preview
return 

script_menu:
  menu,script_menu,show
return

script_menu_select:
	item:=A_ThisMenuItemPos
	t:=script%item%
	guicontrol, , Script_edit1,%t%
	guicontrol, enable,Script_edit1
	guicontrol, , Script_edit,1
return

join_text_beg:
	append_side=0
	gosub,join_text
return

join_text_end:
	append_side=1
	gosub,join_text
return

join_text:
	gui, submit,nohide
	output=
	text2:=edit5	
	
	; if ( newlines1>1 )
	{
		loop, parse, edit3,`n,`r
			tmp_text_%a_index%:=a_loopfield
	}
	/*else
	{
		loop,%total_items%
			tmp_text_%a_index%:=selText
	}
	*/
	if ( append_side=1 )
	{	
		loop,parse,text2,`n,`r
		output .= tmp_text_%a_index% . padding_text . a_loopfield . "`n"
	}
	else
	{	
		loop,parse,text2,`n,`r
		output .= a_loopfield . padding_text . tmp_text_%a_index% . "`n"
	}
	GuiControl, , edit4,%output%
	GuiControl, , edit8,%output%
return

script_edit_text:

file_script = %A_temp%\$temp13$.ahk   
	file_result = %A_temp%\$temp24$.ahk   
	
	temp_text=text=`n(`n%text%`n)`n`nfile_result = %A_temp%\$temp24$.ahk   

	
 
	FileDelete %file_script%             ; delete old temporary file -> write new
	FileDelete %file_result%             ; delete old temporary file -> write new
	
	FileAppend , #ErrorStdOut`n#SingleInstance Force`n#NoTrayIcon`n , %file_script%
	FileAppend , `n`n%temp_text% , %file_script%
	FileAppend ,  `n%Script_edit1% , %file_script%
	FileAppend ,  `n`nfileappend`,`%text`%`,%file_result% , %file_script%
	; msgbox,
	
	; FileAppend , #SingleInstance Force`n#NoTrayIcon`nFileDelete %tmpfile%`nFileAppend `% %Script_edit1%`, %tmpfile%, %tmpfile%
	RunWait %A_AhkPath% %file_script%    ; run AHK to execute temp script, evaluate expression %
	FileRead , Result, %file_result%       ; get result
	
	; FileDelete , %file_script%
	; FileDelete , %file_result%             ; delete old temporary file -> write new

	text:=Result	
	
Return

^+9:: ; run last script in line replacer
text:=Get_Selected_Text()
Gosub, script_edit_text
clipboard:= text

Return
