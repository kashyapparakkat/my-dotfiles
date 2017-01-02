
SplitPath, A_ScriptDir , , , , , A_Script_Drive
; gui 1: is the normal gui
; if not A_IsAdmin
; {
   ; Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ; ExitApp
; }
#NoEnv
#Persistent,On
#SingleInstance,Force
#WinActivateForce
SetWorkingDir %A_ScriptDir%
#include LIB\cbn.ahk
#include LIB\misc functions.ahk


SetBatchLines,-1
SetWinDelay,0
SetKeyDelay,0
CoordMode,Mouse,Screen
applicationname=linux toolbar
ifexist,autostart_on.ico 
	Menu, Tray, Icon, autostart_on.ico 
Gosub,MENU
tabbed=0 
more=0

 
; setTimer,check_Calender,300000
gosub,check_Calender
settimer,update_calender,600000


Gui,  +AlwaysOnTop +ToolWindow  -caption
Gui, +LastFound
WinSet, Region, 0-0 w200 H5  
; Gui, 2: Color, White
;Gui, Add, Picture, x0 y0 h350 w450, %A_WinDir%\system32\ntimage.gif
Gui, Add, Button, Default x0 y0 w300 h5 ggui2, 
;;;;;
Gui, 2: +AlwaysOnTop +ToolWindow  -caption
gui,2: font,s9, verdana
Gui,2: +LastFound
Gui, 2:Add, Button,   x0 y0 w40 h50 gkeys_UP ,	keys UP
Gui, 2:Add, Button,   x+0 y0 w40 h50 gRELOAD hwndbutton9,	; lcd
ILButton(button9, "shell32.dll:" 238, 32, 32, 5)
Gui, 2:Add, Button,   x+1 y0 w40 h50 gmonitorOff hwndbutton2,	; lcd
; ILButton(button2, "%A_ScriptDir%\%applicationname%\imac_aqua.ico:0" 1 , 32, 32, 0)
ILButton(button2, "imac_aqua.ico:0" , 32, 32, 0)
; ILButton(button2, "%applicationname%\imac_aqua.ico" )
; ILButton(button2, "user32.dll:0|:1|:2|:3|:4|:5", 32, 32, 0, "16,1,-16,1")
Gui, 2:Add, Button, Default x+1 y0 w40 h50 hwndbutton1 ,wifi
ILButton(button1, "shell32.dll:" 131, 32, 32, 5)

Gui, 2:Add, Button, Default x+1 y0 w40 h50 hwndbutton3,silent
Gui, 2:Add, Button, Default x+1 y0 w40 h50 hwndbutton4,bluetooth
Gui, 2:Add, Button, Default x+1 y0 w40 h50 hwndbutton5 ,notifications 
Gui, 2:Add, Button, Default x+1 y0 w40 h50 hwndbutton6  gscreen_saver , screensaver
Gui, 2:Add, Button, Default x+1 y0 w40 h50 hwndbutton7  gpower_Options ,power
Gui, 2:Add, Button, Default x+1 y0 w40 h50 gNext_background, next
Gui,2: Add,text,x+1 y0 w100  cred vnotification1,
gui,2: font,s13, comic sans
Gui, 2:Add, Button, Default x+50 y0 w150 h50 vdate gcalender, %A_DD%  %A_MMM% %A_DDDD%
;Gui, 2:Add, Button, Default x+1 y0 w100 h50, %A_DDDD%

gui,2: font,s16, comic sans
FormatTime, TimeString2,,time
Gui, 2:Add, Button, Default x+1 y0 w120 h50 vtime, %TimeString2%
Gui, 2: +LastFoundExist
GUI_ID2:=WinExist() 
	
X_gui2:=550
X_gui1:=800
Gui,2: Show, hide y25 x%X_gui2%,linux_toolbar

gosub,cpu
gui,2: font,s9, verdana
;Gui,2: Add, DateTime , vMyDateTime, time
;Gui, 2:Add, Button, Default x0 y+0 w300 h30 gmore, f
mainTabNames=---NOTIFY---|---A H K---|---SYSTEM---|---Timer---|---MY TASKS---|---CALENDAR---
Gui,2: Add, Tab2, x0 y55  w750 h450 vMyTab hwndTabID TCS_BUTTONS TCS_HOTTRACK gTabSubSwitch ,%mainTabNames%  
;;;;tab height
TCM_GETITEMRECT = 0x130A
TCM_SETITEMSIZE = 0x1329
TCS_HOTTRACK 	= 0x40 
    VarSetCapacity(Rect, 16, 0)
    SendMessage, TCM_GETITEMRECT, 0, &Rect,, ahk_id %TabID%
    H := NumGet(Rect, 12) - NumGet(Rect, 4)
Height = 35
SendMessage, TCM_SETITEMSIZE, 0, Height << 16,, ahk_id %TabID%
SendMessage, TCM_SETMINTABWIDTH := 0x1331, 0,110,,ahk_id %tabID%

; SendMessage, TCM_SETITEMSIZE, 0, 80, , ahk_id %tabID%
Gui 2: +LastFound  ; Avoids the need to specify WinTitle below.
SendMessage, TCS_HOTTRACK , 0,0,
;PostMessage
;;;;tab height
    ; Retrieve the height.
  
	Gui,2: Tab,---NOTIFY---


	Gui,2: Tab,---A H K---
	yt:=yp
	gosub,readscriptpathS
tab_title_width:=110
 button_width:=145
Gui, 2:Add, Button, x10  y+5 w%button_width% h35 gcontrol_gui,control_gui
	loop,parse,scripts,`n,`r
	{  
		scripts_%A_index%:=A_Loopfield  
		SplitPath, A_Loopfield,scripts_name%A_index% 
		name:=scripts_name%A_index%
		DetectHiddenWindows, On 
		path := A_Loopfield
		ifwinexist, %Path% ahk_class AutoHotkey
			Gui,2: Font, s9 cred,	
		else Gui,2: Font, s8 cblack,  
		if A_index=1
			Gui, 2:Add, Button, x10  y+5 w%button_width% h30 hwndscripts_v_Btn_%A_index% vscripts_v_%A_index% gscripts_%A_index%,%name%	  
			
		else if ((A_index=6) |  (A_index=11) | (A_index=16) | (A_index=21) | (A_index=26) | (A_index=31))
			Gui, 2:Add, Button, x10 y+1 w%button_width% h30 hwndscripts_v_Btn_%A_index% vscripts_v_%A_index% gscripts_%A_index%,%name%	 
		 else	 
		Gui, 2:Add, Button, x+0  w%button_width% h30 hwndscripts_v_Btn_%A_index% vscripts_v_%A_index% gscripts_%A_index%,%name%	  
	ILButton( scripts_v_Btn_%A_index%, "circle green.ico:0" , 32, 32, 0)
	}


Gui,2: Tab,---SYSTEM---
	Gui,2: Add, Button, x15 y105 w60 h30 ,eject i:\ 
	Gui,2: Add, Button, x+0 yp w60 h30 , index i:\
	Gui,2: Add, Button, x+0 yp w60 h30 ,usb prot
	Gui,2: Add, Button, x+0 yp w60 h30 ,take photo
	Gui,2: Add, Button, x+0 yp w60 h30 ,screenshot
	Gui,2: Add, Button, x+0 yp w60 h30 ,spy
	Gui,2: Add, Button, x+0 yp w60 h30 ,
	Gui,2: Add, Button, x+0 yp w60 h30 , 
	Gui,2: Add, Button, x15 y150 w100 h30 hwndbutton11 vprevent_sleep gPrevent_Sleep1,Prevent Sleep 10min
	Gui,2: Add, Button, x+1 y150 w100 h30 hwndbutton12 gPrevent_Sleep2,Prevent Sleep 15min
	Gui,2: Add, Button, x+15 y150 w60 h30 ,power saver 
	Gui,2: Add, Button, x+0 yp w60 h30 , brightness
	Gui,2: Add, Slider, x+0 yp w100 h50  vMySlider, 50
	Gui,2: Add, Button, x+0 yp w60 h30 , vol
	Gui,2: Add, Slider, x+0 yp w100 h50  vMySlider2, 50
	Gui,2: Add, Button, x+0 yp w80 h30 gscreen_saver_start, screen saver run
	Gui,2: Add, Button, x+0 yp w80 h30 gscreen_saver_toggle, screen saver togl
	Gui,2: Add, Slider, x+0 yp w100 h50  vMySlider3, 50
	
	Gui,2: Add, Button, x200 y200 w60 h30 , 2
	Gui,2: Add, edit, x+2 y200 w55 h30 vlimit  , 10 
	Gui,2: Add, UpDown,w30  Range0-1000, 3



Gui, 2: Add,button,x15 y+0 grefreshdrivespace,refresh
Gui, 2: Add,text,x+0 vdrive1_text,aaaa
Gui, 2: Add, Progress, x+0 yp w100 h15 cred BackgroundGreen  vMyProgress
Gui, 2: Add,text,vfree x+0, %a_space%100000MB
Gui,2: Tab,---Timer---
gosub,add_timer_to_gui
Gui,2: Tab,---Timer---
Gui,2: Tab,---MY TASKS---
fileread,to_do_contents,2 do.txt
Gui, 2: Add,edit ,x10 y110 w700 h200 vto_do_Edit,%to_do_contents%

Gui,2: Tab,---MY TASKS---



Gui,2: Tab,---CALENDAR---

; Gui, 2: Add, text, x10 yp w50 h30  vTaskInfo , today
Gui, 2: Add, DateTime, x10 y100 w190 h25 vDateMain gLoad, 'Date: ' dd  /  MM  /  yyyy   ;        'Time: ' hh : mm tt
Gui, 2: Add,text, vday_today x+10 yp+3 cred,wednesday
Gui, 2: Add, button, x350 y100 w80 h30 hwndbutton_calender gadd_cal_task  , add_cal_task
Gui, 2: Add, button, x+0 y100 w80 h30 hwndbutton_calender gbutton_calender vbutton_calender , calender
ILButton( button_calender, "circle green.ico:0" , 32, 32, 0)
Gui, 2: Add, button, x+0 y100 w50 h30   gLoad2  , week
Gui, 2: Add, button, x+0 y100 w50 h30   gLoad3  , month
Gui, 2: Add, button, x+0 y100 w50 h30   gLoad7  , yes
Gui, 2: Add, button, x+0 y100 w50 h30   gLoad8 +AltSubmit , today
Gui, 2: Add, button, x+0 yp w50 h30   gLoad9 +AltSubmit , tomorro
Gui, 2: Add, button, x600 y+0 w50 h30   gLoad4 +AltSubmit , <
Gui, 2: Add, button, x+0 yp w30 h30   gLoad5 +AltSubmit , >
Gui, 2: Add, button, x+0 yp w50 h30   gLoad6 +AltSubmit , >>
; Gui, 2: Add, MonthCal, x400 y+0 w250 h180 vDateMain gLoad +AltSubmit , 
gui,2: font,s8, verdana
Gui, 2: add, ListView,x10 y130   w580 r8   vResultList AltSubmit , msg|time|Example
gui,2: font,s9, verdana
	FormatTime, date_load , ,yyyyMMdd
	gosub,check_Calender
 

Gui, Margin,0,0
Gui,2: Margin,0,0

gosub,check_Prevent_Sleep


Gui, Show,x%X_gui1% y0 NoActivate
Gui, 2: Show,hide h95 ,linux_toolbar
Loop
{
  MouseGetPos,mx,my
  If (my=0) & (mx>800)& (mx<1000) 
  {   
	  If tabbed=0
			{
				sleep,350
				MouseGetPos,mx,my
				If (my=0) & (mx>800)& (mx<1000) 
				{
					Gui, hide
					gosub,refresh
					; Gui,2: Show,y25 x%X_gui2% NoActivate  h95
					DllCall("AnimateWindow","UInt",GUI_ID2,"Int",300,"UInt",0xC0004)

					settimer,guimoreON,70
					
				}
				else 
					continue
			tabbed=1
		  }
  }
  Else
  {
		If tabbed=1 
		{
			If (my>10) & (my<120) & (mx>500)& (mx<1360) 
			 	continue
			else ;	check again after a delay
			{
			sleep,500
			If (my>10) & (my<120) & (mx>500)& (mx<1360) 
			 	continue
			}
				
			 If  (my<350) & (mx>500)& (mx<1360)  & more=1
			 	continue
			tabbed=0
			; Gui,2: hide
				settimer,guimoreON,OFF
			 DllCall("AnimateWindow","UInt",  GUI_ID2  ,"Int", 300,"UInt", 0xD0008) 
			more=0
			Gui, Show,y0 x%X_gui1% NoActivate
	
			}
	}
  Sleep,150
}      
TAB:
sleep,500
Send,{Alt Down}{Tab}
Return




TabSubSwitch:
 
Gui, Submit, Nohide
; A_GuiControl holds which sub-tab was clicked,
; now detect, which of its names was clicked
GuiControlGet, whichSubTabName,, %A_GuiControl%
TabMain:=whichSubTabName
loop,parse,mainTabNames,|
{
	if (a_loopfield=whichSubTabName)
		SendMessage, TCM_HIGHLIGHTITEM := 0x1333, % A_index-1, 1, , ahk_id %TabID%
	else
		SendMessage, TCM_HIGHLIGHTITEM := 0x1333, % A_index-1, 0, , ahk_id %TabID%
}
if (whichSubTabName="---A H K---")
	{
		gosub,refresh_run
		tooltip,refresh_run
		sleep,500
		tooltip
	}

; Winset, Redraw, , %Name%
; tooltip,%whichSubTabName%
; sleep,300
; tooltip,

	Gui, 2: Show,x%X_gui2% y25 NoActivate h330
	more=1
return



MENU:
Menu,Tray,DeleteAll
Menu,Tray,Tip,%applicationname%
Return
EXIT:
ExitApp

moreBUTTON: 
more:=!more
if more
 h=200
 else h=100
gosub, refresh_run
Gui, 2: Show,x%X_gui2% y25 NoActivate h%h%
return


monitorOff:

sleep,300
SendMessage,0x112,0xF170,2,,Program Manager
return 

 
guimoreON:	;control gui more
t:=X_gui2+tab_title_width
t1:=t+tab_title_width
t2:=t1+tab_title_width
t3:=t2+tab_title_width
t4:=t3+tab_title_width
t5:=t4+tab_title_width
; tooltip,%t1%	
MouseGetPos,nx,ny

  If (ny>52) &(ny<90)  & (nx>X_gui2) & (nx<1215) 
  {   
		If more=0	 
			{ 
				sleep,50
				MouseGetPos,nx,ny
				If (ny>70) &(ny<120)  & (nx>X_gui2) & (nx<1225) 
				{ 
				GuiControlGet, tabActive,,mytab 
				; msgbox,%tabActive%
				

					if (nx<t)	;over first tab
						{
							guicontrol,2:,mytab,|---NOTIFY---||---A H K---|---SYSTEM---|---Timer---|---MY TASKS---|---CALENDAR---
							SendMessage, TCM_HIGHLIGHTITEM := 0x1333,  0, 1, , ahk_id %TabID%
						}
						else if (nx<t1)	;over   tab
						{
							gosub, refresh_run
							guicontrol,2:,mytab,|---NOTIFY---|---A H K---||---SYSTEM---|---Timer---|---MY TASKS---|---CALENDAR---
							SendMessage, TCM_HIGHLIGHTITEM := 0x1333,  1, 1, , ahk_id %TabID%
						}
							
						else if (nx<t2)	;over   tab
						{
						; gosub, refresh_run
							guicontrol,2:,mytab,|---NOTIFY---|---A H K---|---SYSTEM---||---Timer---|---MY TASKS---|---CALENDAR---
							SendMessage, TCM_HIGHLIGHTITEM := 0x1333,  2, 1, , ahk_id %TabID%
						}
						else if (nx<t3)	;over   tab
						{
						; gosub, refresh_run
							guicontrol,2:,mytab,|---NOTIFY---|---A H K---|---SYSTEM---|---Timer---||---MY TASKS---|---CALENDAR---
							SendMessage, TCM_HIGHLIGHTITEM := 0x1333,  3, 1, , ahk_id %TabID%
							
							fileread,to_do_contents,2 do.txt
							guicontrol,2:,to_do_Edit,%to_do_contents%
							
						}
						else if (nx<t4)	;over   tab
						{
						; gosub, refresh_run
							guicontrol,2:,mytab,|---NOTIFY---|---A H K---|---SYSTEM---|---Timer---|---MY TASKS---||---CALENDAR---|
							SendMessage, TCM_HIGHLIGHTITEM := 0x1333,  4, 1, , ahk_id %TabID%
						}
						else if (nx<t5)	;over   tab
						{
						; gosub, refresh_run
							guicontrol,2:,mytab,|---NOTIFY---|---A H K---|---SYSTEM---|---Timer---|---MY TASKS---|---CALENDAR---||
							SendMessage, TCM_HIGHLIGHTITEM := 0x1333,  5, 1, , ahk_id %TabID%
						}
							; else if nx<900
							; guicontrol,2:,mytab,---NOTIFY---|---A H K---||---SYSTEM---|---Timer---|---MY TASKS---|---CALENDAR---
							; else if nx<1000
							; guicontrol,2:,mytab,---NOTIFY---|---A H K---|---SYSTEM---||---Timer---|---MY TASKS---|---CALENDAR---
					DllCall("AnimateWindow","UInt",GUI_ID2,"Int",300,"UInt",0xC0004)
				 	Gui, 2: Show,x%X_gui2% y25 NoActivate h330
					
				 more=1	
				}
			}
	}
	Else
		{
				If more=1
				{
					If (ny>60) & (ny<350) & (nx>500)& (nx<1350)
						return				
					sleep,100 
					MouseGetPos,nx,ny					
					If !((ny>70) &(ny<120)  & (nx>%X_gui2%) & (nx<1350))	;if gone up of more section
						{ 
						;Gui,2: hide
						more=0
						Gui, 2: Show,x%X_gui2% y25 NoActivate h100
						}
				}
		}
						
	
return 
calender:
SplashImage, F:\cbn\opus\calender\5.jpg,w1100 h750, b  zh600 zx0 zy0   ZW-1 fs18,  ; This is our company logo.
keywait,lbutton,d,t8
SplashImage, Off
return 

scripts_1:
scripts_2:
scripts_3:
scripts_4:
scripts_5:
scripts_6:
scripts_7:
scripts_8:
scripts_9:
scripts_10:
scripts_11:
scripts_12:
scripts_13:
scripts_14:
scripts_15:
scripts_16:
scripts_17:
scripts_18:
scripts_19:
scripts_20:
scripts_21:
scripts_22:
scripts_23:
scripts_24:
scripts_25:
scripts_26:
scripts_27:
scripts_28:
scripts_29:
Stringtrimleft, Button , A_Thislabel, 8
DetectHiddenWindows, On 
	path := scripts_%Button%
	text :=scripts_name%Button%	
	 
  ifwinexist, %Path% ahk_class AutoHotkey
	{ 	WinClose,  %Path% ahk_class AutoHotkey
		Gui,2: Font, s8 cblack,		veradana
		 
		
		GuiControl,2: Font  ,  scripts_v_%Button%
	GuiControl,2: , scripts_v_%Button%,%text%
		ILButton( scripts_v_Btn_%Button%, "" , 32, 32, 0)
	}
	else
	{
		run, "%path%"		 
	Gui,2: Font,  s9 cred ,Comic Sans MS  ; underline
	GuiControl,2: Font  ,  scripts_v_%Button%
	GuiControl,2: , scripts_v_%Button%,%text%

	ILButton( scripts_v_Btn_%Button%, "circle green.ico:0" , 32, 32, 0)
	}
	    	
return 

readscriptpathS:

	fileread,scripts, %A_Script_Drive%\cbn\ahk\Toolbar scripts.txt
	scripts2=
	scripts:=sortfilepathsonFilename(scripts)
	
	
	return
	
refresh_run:
	gosub,readscriptpathS


loop,parse,scripts,`n,`r
{  
	scripts_%A_index%:=A_Loopfield  
	SplitPath, A_Loopfield,scripts_name%A_index% 
	name:=scripts_name%A_index%
	DetectHiddenWindows, On 
	path := A_Loopfield
	ifwinexist, %Path% ahk_class AutoHotkey
	 	{
		Gui,2: Font, s9 cred ,Comic Sans MS 	; underline  	 
		Guicontrol,2: ,scripts_v_%A_index%,%name%
		;msgbox,
		ILButton( scripts_v_Btn_%A_index%, "circle green.ico:0" , 32, 32, 0)
		}		
	else
		{
		Gui,2: Font,norm s8 cblack,  verdana
		Guicontrol, 2:,scripts_v_%A_index% ,%name%	 
		ILButton( scripts_v_Btn_%A_index%, "" , 32, 32, 0)
		}
	GuiControl,2: Font  ,  scripts_v_%A_index%,
				
}
return 
refresh:
Guicontrol, 2:,date,%A_DD%  %A_MMM% %A_DDDD%

FormatTime, TimeString2,,time
Guicontrol, 2:,time,%TimeString2%
return


cpu:

X_Pos = 1300 ; x co-ordinate on taskbar
Y_Pos = 800 ; y co-ordinate on taskbar

Clock_Width   = 58             ; width of the clock and progress bars (fit to taskbar)
ProgressBar_H = 30              ; height of the progress bars
ProgressBar_W := 15


CPU_Usage_Bar_Color = green
Mem_Usage_Bar_Color = Red

Clock_Color      = White          ; Background
Clock_Font_Color = Black          ; Font
Clock_Font       = Arial
Clock_Pts        = 10
Clock_Font_Style = bold
Clock_Pattern    = h:mm:ss
Clock_H          = 14             ; height of the clock




;----- code starts here -----
EnvGet, ProcessorCount, NUMBER_OF_PROCESSORS       ;-- added new

;VarSetCapacity( IdleTicks,    2*4 )
VarSetCapacity( IdleTicks,8,0)
VarSetCapacity( memorystatus, 100 )



Gui, 2: Add, Progress,vertical  BackgroundFFFF33 vProcLoad x533 y5 w%ProgressBar_W% h%ProgressBar_H% c%CPU_Usage_Bar_Color%,dsg,s
Gui, 2: Add, Progress ,vertical BackgroundFFFF33  vMemLoad  x+2 yp w%ProgressBar_W% h%ProgressBar_H% c%Mem_Usage_Bar_Color%
gui,2: font,s9, verdana
Gui, 2: Add,text, x533 y+2 vloadPC,10
Gui, 2: Add,text, x+15 yp vmemPC,10


Bar_H := ProgressBar_H - 4 ; 2*2 border pixels
Bar_H_plus_Clock_H := Y_Pos+Bar_H + Clock_H

y:=Y_Pos+Bar_H
;Gui, 7: Show, x%X_Pos% y%y% w%Clock_Width% h%Clock_H%, Clock
;Gui, 8: Show, x%X_Pos% y%Y_Pos% w%Clock_Width% h%Bar_H%, Processor Load
;Gui, 9: Show, x%X_Pos% y%Bar_H_plus_Clock_H% w%Clock_Width% h%Bar_H%, Memory Load


SetTimer cpuUpdate, 750 ; Update bars, redraw clock, tooltip
Return
;----------


cpuUpdate:
  FormatTime time,,%Clock_Pattern%
  GuiControl 2:,DT,%time%                 ;-- Update date/time in preset format



  IdleTime0 = %IdleTime%                   ;-- Save previous values
  Tick0 = %Tick%
  DllCall("kernel32.dll\GetSystemTimes", "uint",&IdleTicks, "uint",0, "uint",0)
  IdleTime := *(&IdleTicks)
  Loop 7                                   ;-- Ticks when Windows was idle
    IdleTime += *( &IdleTicks + A_Index ) << ( 8 * A_Index )
  Tick := A_TickCount                      ;-- Ticks all together
  load := 100 - 0.01*(IdleTime - IdleTime0)/(Tick - Tick0) / ProcessorCount    ; -- modified /processorcount
  GuiControl 2: , ProcLoad, %load%         ;-- Update progress bar
  GuiControl 2: , loadPC, %load%         ;-- Update progress bar




  DllCall("kernel32.dll\GlobalMemoryStatus", "uint",&memorystatus)
  mem := *( &memorystatus + 4 ) ; last byte is enough, mem = 0..100
  GuiControl 2: , MemLoad, %mem%           ;-- Update progress bar
  GuiControl 2: , memPC, %mem%         ;-- Update progress bar
Return
;----------------------------------------------------









refreshdrivespace:
 drive1=f
DrivespaceFree, free, %drive1%:\
DriveGet, cap, capacity, %drive1%:\
percent:=100-100*free/cap
GuiControl,2:, MyProgress, %percent%
tmp2:=free*1024*1024
tmp:=autoByteFormat(tmp2, 2)

GuiControl,2:, free, %a_space%%tmp%

Return

gui2:
	Gui, hide
	gosub,refresh
	Gui,2: Show,y25 x%X_gui2% NoActivate  h95
	settimer,guimoreON,70
	tabbed=1
return

screen_saver_start:
tooltip,starting screen saver
sleep,1000
tooltip
; Start the user's chosen screen saver:
SendMessage, 0x112, 0xF140, 0,, Program Manager  ; 0x112 is WM_SYSCOMMAND, and 0xF140 is SC_SCREENSAVE.
return

screen_saver_toggle:
sleep,500
; Start the user's chosen screen saver:
SendMessage, 0x112, 0xF140, 0,, Program Manager  ; 0x112 is WM_SYSCOMMAND, and 0xF140 is SC_SCREENSAVE.
return

screen_saver:
RegRead, OutputVar,   HKEY_CURRENT_USER, control panel\desktop, ScreenSaveActive
if (OutputVar)
	{	RegWrite, REG_SZ, HKEY_CURRENT_USER, control panel\desktop, "ScreenSaveActive",0
		tooltip,disabled
		SetTimer, RemoveToolTip,-500	
	}
	else
	{	RegWrite, REG_SZ, HKEY_CURRENT_USER, control panel\desktop, "ScreenSaveActive",1
		tooltip,enabled
		SetTimer, RemoveToolTip,-500	
	}
	; "HKEY_CURRENT_USER\control panel\desktop" "ScreenSaveActive" 0
return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

power_Options:

run,%A_Script_Drive%\cbn\ahk\power options.ahk
return

Next_background:		;Next desktop background
WinActivate, ahk_class Progman   ; activate the Desktop
MouseGetPos, xpos, ypos          ; get current mouse position
Click 0,0                        ; click in the corner of the desktop, to unselect any selected icon
Send +{F10}                      ; send Shift+F10, the shortcut for right-click
Send n                           ; send "n", the key for "next desktop background"
Click %xpos%, %ypos%, 0          ; put the mouse back at its previous position
return         

return

check_Calender:
Gui, 2:Default

GuiControlGet,DateMain,,DateMain
DateMain := SubStr(DateMain,1,8)
FormatTime, day_today ,%date_load%,dddd
; msgbox,%day_today%
guicontrol, 2:,day_today,%day_today%

GuiControl,2: ,TaskInfo,%  SubStr(date_load,7) "/" SubStr(date_load,5,2) "/" SubStr(date_load,1,4) 
GUi,2: ListView,ResultList
lv_delete()
calenders=%A_Script_Drive%\cbn\ahk\calendar\my calender.ini`n%A_Script_Drive%\cbn\ahk\calendar\indian calendar.txt`n%A_Script_Drive%\cbn\ahk\calendar\bday EEEa.txt`n%A_Script_Drive%\cbn\ahk\calendar\bday.txt

loop,parse,calenders,`n,`r
{
	filepath:=a_loopfield
	fileread,all,%filepath%

	; msgbox,%date_load%
	date2=

		; reg1=i).*%date_load%.*
		; msgbox,%reg1%
	loop,parse,all,`n,`r
	{
		

			
; if  (  RegExMatch(a_loopfield, reg1) )
ifinstring,a_loopfield,% date_load	;	%
		{
		; reg1=i).*20130616.*
			; msgbox,%time%
			loop,parse,a_loopfield,=
				 {
					tmp_%A_index%:=a_loopfield
				 }
				; reminder_time_%A_index%:=tmp_1
				; reminder_msg_%A_index%:=tmp_2
			FormatTime, time , %tmp_1% 
			FormatTime, time,  %tmp_1% , h:mmtt, d MMMM yyyy 
			; GetFormatedDate_Full(time)
			splitpath,filepath,f_name
			LV_Add("",tmp_2,time,f_name)	;,filepath)
		}
		
	}

}
matchcount:=LV_GetCount()
LV_ModifyCol(1, "Auto")
LV_ModifyCol(2,  "Auto")
LV_ModifyCol(3, "Auto")
; GuiControl,2: Show, ResultList
; GuiControl, +Redraw, ResultList
GUi,ListView,ResultList
Gui, 1:Default
return

Load:
Gui, 2:Default
LV_Delete()
GuiControlGet,DateMain,,DateMain
DateMain := SubStr(DateMain,1,8)
date_load:=DateMain
	; msgbox,%DateMain%
gosub,check_Calender
Gui, 1:Default
return

Load2:
Gui, 2:Default



Gui, 1:Default
return

Load3:
Gui, 2:Default
LV_Delete()
GuiControlGet,DateMain,,DateMain
DateMain := SubStr(DateMain,1,6)
date_load:=DateMain
	; msgbox,%DateMain%
gosub,check_Calender
Gui, 1:Default
return

Load4:
Gui, 2:Default
LV_Delete()
GuiControlGet,DateMain,,DateMain
DateMain := SubStr(DateMain,1,8)
date_load+=-1, days
date_load := SubStr(date_load,1,8)
gosub,check_Calender
GuiControl, 2:,DateMain, %date_load%000000

Gui, 1:Default
return

Load5:
Gui, 2:Default
LV_Delete()
GuiControlGet,DateMain,,DateMain

DateMain := SubStr(DateMain,1,8)
date_load+= 1, days
date_load := SubStr(date_load,1,8)
gosub,check_Calender
GuiControl, 2:,DateMain, %date_load%000000

Gui, 1:Default
return

Load6:	;	skip this day if no reminders
Gui, 2:Default
LV_Delete()
GuiControlGet,DateMain,,DateMain
DateMain := SubStr(DateMain,1,8)

	matchcount=0
while (!matchcount)
{
	date_load+= 1, days
	date_load := SubStr(date_load,1,8)
		
	gosub,check_Calender
	; matchcount:=LV_GetCount()
	; msgbox,%matchcount%
}
GuiControl, 2:,DateMain, %date_load%000000


Gui, 1:Default
	
return


Load7:
Gui, 2:Default
LV_Delete()
GuiControlGet,DateMain,,DateMain
DateMain := SubStr(DateMain,1,8)
FormatTime, date_load , ,yyyyMMdd
date_load--
gosub,check_Calender
GuiControl, 2:,DateMain, %date_load%000000

Gui, 1:Default
return

update_calender:
GuiControlGet,DateMain,,DateMain
DateMain := SubStr(DateMain,1,8)

Date_today := SubStr(A_Now,1,8)
if (date_alerted <> Date_today)
	gosub,Load8
	return
	
	
Load8:
Gui, 2:Default
LV_Delete()
GuiControlGet,DateMain,,DateMain
DateMain := SubStr(DateMain,1,8)
; date_load++
	FormatTime, date_load , ,yyyyMMdd
	; msgbox,%DateMain%
gosub,check_Calender
GuiControl, 2:,DateMain, %date_load%000000

Gui, 1:Default
return

Load9:
Gui, 2:Default
LV_Delete()
GuiControlGet,DateMain,,DateMain
DateMain := SubStr(DateMain,1,8)
FormatTime, date_load , ,yyyyMMdd
date_load++
gosub,check_Calender
GuiControl, 2:,DateMain, %date_load%000000

Gui, 1:Default
return




add_cal_task:
	TargetScriptTitle = my calendar.ahk ahk_class AutoHotkey
	GuiControlGet,DateMain,,DateMain
	DateMain := SubStr(DateMain,1,8)
	StringToSend=-add_cal_task-task_date%DateMain%
	gosub,send_message
return	
button_calender:
	; run,%A_Script_Drive%\cbn\ahk\calender\my calendar.ahk
	TargetScriptTitle = my calendar.ahk ahk_class AutoHotkey
	GuiControlGet,DateMain,,DateMain
	DateMain := SubStr(DateMain,1,8)
	StringToSend=-d%DateMain%
	gosub,send_message
	
	tabbed=0
	settimer,guimoreON,OFF
	DllCall("AnimateWindow","UInt",  GUI_ID2  ,"Int", 300,"UInt", 0xD0008) 
	more=0
	Gui, 1:  Show,y0 x%X_gui1% NoActivate
			
return
	
send_message:
	result := Send_WM_COPYDATA(StringToSend, TargetScriptTitle)
	if result = FAIL
		MsgBox SendMessage failed. Does the following WinTitle exist?:`n%TargetScriptTitle%
	else if result = 0
		MsgBox Message sent but the target window responded with 0, which may mean it ignored it.
return

Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle)  ; ByRef saves a little memory in this case.
; This function sends the specified string to the specified window and returns the reply.
; The reply is 1 if the target window processed the message, or 0 if it ignored it.
{
    VarSetCapacity(CopyDataStruct, 3*A_PtrSize, 0)  ; Set up the structure's memory area.
    ; First set the structure's cbData member to the size of the string, including its zero terminator:
    SizeInBytes := (StrLen(StringToSend) + 1) * (A_IsUnicode ? 2 : 1)
    NumPut(SizeInBytes, CopyDataStruct, A_PtrSize)  ; OS requires that this be done.
    NumPut(&StringToSend, CopyDataStruct, 2*A_PtrSize)  ; Set lpData to point to the string itself.
    Prev_DetectHiddenWindows := A_DetectHiddenWindows
    Prev_TitleMatchMode := A_TitleMatchMode
    DetectHiddenWindows On
    SetTitleMatchMode 2
    SendMessage, 0x4a, 0, &CopyDataStruct,, %TargetScriptTitle%  ; 0x4a is WM_COPYDATA. Must use Send not Post.
    DetectHiddenWindows %Prev_DetectHiddenWindows%  ; Restore original setting for the caller.
    SetTitleMatchMode %Prev_TitleMatchMode%         ; Same.
    return ErrorLevel  ; Return SendMessage's reply back to our caller.
}


return

reload:
reload
return
#IfWinActive,linux_toolbar

~Enter::	; na
~numpadEnter::	; na
ControlGetFocus, OutputVar 
if (OutputVar="edit2")
	gosub,Timer_Start	;	timer
return
#IfWinActive,

;======================================================================
add_timer_to_gui:
;======================================================================
ScriptName = System Timer

;------( Gui )----------------------------------------------------------------

	Gui, 2: Add, GroupBox, x5 y100 w130 h140, Time (Mins)
	Gui, 2: Font, S15 CBlack
	Gui,2: Add, Edit, x20 y120 w100 h30 gTimer_Preview vgui_timer_minutes, 5
	Gui,2: Add, updown, x+0 y120   gTimer_Preview , 5
	Gui,2: Font, S9
	Gui,2:  Add, DropdownList,y+0 w100 vTimer_Action,beep||Sleep|Hibernate|Reboot|Shutdown|
	Gui,2:  Font, S15 Lucida Console
	Gui,2:  Add, Text, x10 y+10 w110 Center +BackGroundTrans vTimer_Update, 0:05:00
	Gui,2:  Font, S8 W400
	Gui,2:  Add, Button, x10 y+0 w40 Center gTimer_Start, Start
	Gui,2:  Add, Button, x+0 yp w40 Center gTimer_Pause, Pause
	Gui,2:  Add, Button, x+0 yp w40 Center gTimer_Stop, Stop
	; Gui,2:  Add, Button, x+0 yp w40 Center gTimer_Exit, Exit
	Gui,2:  -SysMenu
	; Gui,2:  Show, , % ScriptName
	ShutdownGui=1
Return

;------( Convert input into HH:MM:SS for prevew

Timer_Preview:

	Gui,2:  Submit, Nohide
	If !! Timer
	{
		SetTimer, Timer_Start, Off
		MsgBox, ,% ScriptName, Shutdown Timer Stopped. Restart timer with new time
		Timer=
	}
	Timer_Update:="", Timer_UpdateLast:=""
	; TimeSet:=""
	Flash:="", PauseTime:=""
	SetFormat , Float, 0.0
	; TimeSet:= A_TickCount
	Time_display:= FormatSeconds(((gui_Timer_Minutes*60))) ;  - (A_TickCount - TimeSet))/1000)
	If TimeSet = :00:00
		GuiControl,2:  Text, Timer_Update, 0:00:00
	Else
		GuiControl,2:  Text, Timer_Update , % Time_display
Return

;------( Start

Timer_Start:

	; tooltip,running %A_TickCount% - %TimeSet% > %Timer_Milli_sec%
	If Pause
	{
		
		GoSub, Timer_Pause
		Return
	}
	If ! TimerRunning ; Whether the Timer is ON
	{
		Gui,2:  Submit, Nohide
		Timer_Minutes:=gui_timer_minutes
		If ( !Timer_Minutes )
		{
			SetTimer, Timer_Start, Off
			MsgBox, ,% ScriptName, No time or action input.
		}
		Else
		{
			Gui , 2: Font , S15  cred 
			GuiControl , 2: Font , Timer_Update
			SoundBeep, 2050, 300
			TimeSet := A_TickCount
			Timer_Milli_sec := ( Timer_Minutes * 60 ) * 1000
			SetTimer, Timer_Start, 1000
			TimerRunning := 1
		}
	}
	Else
	{
	
		SetFormat, Float, 0.0
		; msgbox,%Timer_Minutes%*60*1000 - (%A_TickCount% - %TimeSet%))/1000)
		Timer_Update:=FormatSeconds((Timer_Minutes*60*1000 - (A_TickCount - TimeSet)) / 1000)

		If (Timer_Update="" || Timer_Update <> Timer_UpdateLast)
		{
			GuiControl,2: Text, Timer_Update, % Timer_Update
			Timer_UpdateLast:=Timer_Update
		}
		If % (A_TickCount - TimeSet) > Timer_Milli_sec	; %
		{
			SetTimer, Timer_Start, Off
			; msgbox, %A_TickCount% - %TimeSet% > %Timer_Minutes%
			If Timer_Action=Sleep
				DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 1)
			If Timer_Action=Hibernate
				DllCall("PowrProf\SetSuspendState", "int", 1, "int", 1, "int", 1)
			If Timer_Action=Reboot
				Shutdown, 6
			If Timer_Action=Shutdown
				Shutdown, 5
			if (Timer_Action= "beep")
			{
					SoundBeep, 2050, 300  ; Play 
					sleep,10
					SoundBeep, 2050, 300  ; Play 				
					sleep,10
					SoundBeep, 2050, 300  ; Play 
					msgbox,timer`n`ntime up
					gosub,Timer_Stop	;	timer reset
				}
		}
/*
		; Flash gui Window
		If (Timer_Minutes - (A_TickCount - TimeSet))/1000 < 60
		{
			If ! Flash
				WinSet, Alwaysontop, On, % ScriptName
			If (Flash="" || (A_TickCount-Flash) > 400)
			{
				Gui,2:  Flash
				Flash:=A_TickCount
			}
		}
*/
	}
Return

;------( Pause

Timer_Pause:
	SoundBeep, 2050, 70
	If % Pause:= (Pause = "") ? "1" : ""	;	%
	{
		Gui,2: Font, S15  cgreen
		GuiControl, 2: Font  , Timer_Update
		SetTimer, Timer_Start, Off
		PauseTime := A_TickCount
	}
	Else
	{
		Gui,2: Font, S15  cred
		GuiControl, 2: Font  , Timer_Update
		TimeSet:=TimeSet+(A_TickCount-PauseTime), PauseTime:=""
		SetTimer, Timer_Start, 1000
	}
Return

Timer_Stop:
	Gui,2: Font, S15  cblack
	GuiControl, 2: Font  , Timer_Update
	SoundBeep, 2050, 70  
	TimerRunning := 0
		SetTimer, Timer_Start, Off
	gosub, Timer_Preview
	; Reload
Return

;------( Exit

Timer_Exit:
	ExitApp
Return

;------( Functions )----------------------------------------------------------

FormatSeconds(NumberOfSeconds) {
	Time = 19990101
	Time += %NumberOfSeconds%, seconds
	FormatTime, mmss, %time%, mm:ss
	Return NumberOfSeconds//3600 ":" mmss
}


;======================================================================


check_Prevent_Sleep:
path =%A_Script_Drive%\cbn\ahk\14-Nov-2013\Prevent Sleep by Making Noise.ahk	 
DetectHiddenWindows, On 
	ifwinexist, %Path% ahk_class AutoHotkey
		{
			Prevent_Sleep_run:=1
			ILButton(button11, "shell32.dll:" 278, 32, 32, 5)
			guicontrol,2: ,notification1,prevent sleep
		}
	else
		{
			; msgbox
			Prevent_Sleep_run:=0
			ILButton(button11, "" , 32, 32, 0)
			guicontrol,2: ,notification1,
		}
Return	

Prevent_Sleep2:
run_duration:=15
gosub,check_Prevent_Sleep
gosub,Prevent_Sleep

return

Prevent_Sleep1:
run_duration:=10

gosub,check_Prevent_Sleep	; update button
gosub,Prevent_Sleep
return
Prevent_Sleep:
DetectHiddenWindows, On 
path =%A_Script_Drive%\cbn\ahk\14-Nov-2013\Prevent Sleep by Making Noise.ahk
	if(Prevent_Sleep_run)
		WinClose,  %Path% ahk_class AutoHotkey
	else
		{
		run, "%path%" %run_duration%
		sleep,1000	;	wait till it runs		
		}
gosub,check_Prevent_Sleep
Return

keys_UP:
Send {LAlt up}
Send {Lctrl up}
Send {Lwin up}
Send {Lshift up}
Send {RAlt up}
Send {Rctrl up}
Send {Rwin up}
Send {Rshift up}
Send {space up}
tooltip,all keys up
sleep,800
tooltip
return

control_gui:
	send ^{capslock}
	return