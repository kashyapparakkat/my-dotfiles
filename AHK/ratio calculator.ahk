#SingleInstance Force
ratio_cycle_active:=0
ratio_cycle_count:=0
#include C:\cbn_gits\AHK\LIB\emacs_functions.ahk
#include LIB\cbn.ahk
menu, Tray, Icon, Shell32.dll, 112 
gui,font,s11
Gui, +AlwaysOnTop  + -caption toolwindow +LastFound  +border ;	+resize
Gui, Add, button,x0 y2 h30 w30 gpaste_base_ratio,->
Gui, Add, button,x0 y+0 h102 w30 ghide,H`nI`nD`nE

Gui, Add, Edit, x30 y3 w70 h25 cred gpreviewReset  vx1 , 1
Gui, Add, UpDown,w20 vupdownx1 Range0-10000, 1
Gui, Add, Edit, x+0 yp w70 h25  cTeal gpreview   vx2 hWndEd1, 1
Gui, Add, UpDown,w20 vupdownx2 Range0-10000, 0
Gui, Add, checkbox,x+3 yp   vmagnify,X
Gui, Add, checkbox,x+0 yp   vdivide,/
Gui, Add, Edit, x+0 yp w70 h25 cTeal gpreview   vx3, 1
Gui, Add, UpDown,w20  Range0-10000,0
Gui, Add, Edit, x+5 yp w70 h25 cTeal gpreview   vx4, 1
Gui, Add, UpDown,w20  Range0-10000,0
Gui, Add, Edit, x+0 yp w70 h25 cTeal gpreview   vx5, 1
Gui, Add, UpDown,w20  Range0-10000, 0

Gui, Add, Edit, x30 y+1 w70 h25 cred gpreviewReset  vy1, 1
Gui, Add, UpDown,w20  Range0-10000, 2
Gui, Add, Edit, x+0 yp w70 h25 cTeal gpreview   vy2, 1
Gui, Add, UpDown,w20  vupdownY2 Range0-10000, 0
Gui, Add, Edit, x+0 yp w35 h25 cTeal gpreview   vmagnifyN, 1
Gui, Add, UpDown,w5  Range0-10000, 2
Gui, Add, Edit, x+26 yp w70 h25 cTeal gpreview   vy3, 1
Gui, Add, UpDown,w20  Range0-10000, 0 
Gui, Add, Edit, x+5 yp w70 h25 cTeal gpreview   vy4, 1
Gui, Add, UpDown,w20  Range0-10000, 0 
Gui, Add, Edit, x+0 yp w70 h25 cTeal gpreview   vy5, 1
Gui, Add, UpDown,w20  Range0-10000, 0

Gui, Add, text,x35 y+5 h20 w100 cgreen  vsimple_ratio_text ,%simple_ratio%
Gui, Add, button,x30 y+2 h25 w65 gcopy_ratio,^c
Gui, Add, button,x+0 yp h25 w65 gpaste_ratio,^v
Gui, Add, button,x+2 yp h25 w70 gmore2,vvvvvvvv
Gui, Add, button,x+0 yp h25 w70 gmore3,>>


Gui, Add, Edit, x30 y+2 w70 h25 cTeal gpreviewReset  vu1 , 1
Gui, Add, UpDown,w20  Range0-10000, 1
Gui, Add, Edit, x+0 yp w70 h25 cTeal gpreview   vu2, 1
Gui, Add, UpDown,w20  Range0-10000, 0
Gui, Add, Edit, x+0 yp w70 h25 cTeal gpreview   vu3, 1
Gui, Add, UpDown,w20  Range0-10000, 0
Gui, Add, Edit, x+5 yp w70 h25 cTeal gpreview   vu4, 1
Gui, Add, UpDown,w20  Range0-10000, 0
Gui, Add, Edit, x+0 yp w70 h25 cTeal gpreview   vu5, 1
Gui, Add, UpDown,w20  Range0-10000, 0
Gui, Add, Edit, x30 y+0 w70 h25 cTeal gpreviewReset  vv1, 1
Gui, Add, UpDown,w20  Range0-10000, 2
Gui, Add, Edit, x+0 yp w70 h25 cTeal gpreview   vv2, 1
Gui, Add, UpDown,w20  Range0-10000, 0
Gui, Add, Edit, x+0 yp w70 h25 cTeal gpreview   vv3, 1
Gui, Add, UpDown,w20  Range0-10000, 0 
Gui, Add, Edit, x+5 yp w70 h25 cTeal gpreview   vv4, 1
Gui, Add, UpDown,w20  Range0-10000, 0 
Gui, Add, Edit, x+0 yp w70 h25 cTeal gpreview   vv5, 1
Gui, Add, UpDown,w20  Range0-10000, 0

x1=0
y1=0

x2=0
x3=0
more2=0
more3=0

; gui,show,h110 w302
; gosub,previewReset
; guicontrol,focus,x2
; SendMessage, ( EM_SETSEL := 0xB1 ), 0, -1, , ahk_id %ED1%	;preselects the text
return

previewReset:
	gui,submit,nohide
	Prev_x1:=x1
	Prev_y1:=y1


	Prev_x2:=x2
	Prev_x3:=x3

	Prev_y2:=0
	Prev_y3:=0
	gosub,simple_ratio
	gosub,preview

return

more2:
if more2
	more2=0
else more2=1
if (more2)
	;WinSet, Region, 0-0 W450 H100 
	gui,show,   H170 
else
	;WinSet, Region, 0-0 W450 H100
	gui,show,  h110
return
more3:
if more3
	more3=0
else more3=1
if (more3)
	;WinSet, Region, 0-0 W450 H100 
	gui,show,   w450 
else
	;WinSet, Region, 0-0 W450 H100
	gui,show,  w302
return

preview:
	gui,submit,nohide
	if ((Prev_x2==x2) AND (Prev_x3==x3)  AND (Prev_y2==y2) AND (Prev_y3==y3) )
	{
		return
	}
	else if !(Prev_x2==x2)
	{
		y2:=y1*x2/x1
		y2:=Round(y2,2)		
		guicontrol,,updownY2 ,%y2%		
		guicontrol,,y2 ,%y2%		
		Prev_x2:=x2
		Prev_y2:=y2	
	}
	else if !(Prev_y2==y2)
	{
		x2:=y2*x1/y1
		x2:=Round(x2,2)
		guicontrol,,updownx2 ,%x2%		
		guicontrol,,x2 ,%x2%		
		Prev_y2:=y2	
		Prev_x2:=x2
	
	}
 if !(Prev_x3==x3)
	{
		if (magnify)
		{
			y3:=y1*magnifyN
			y3:=Round(y3,2)			
			guicontrol,,y3 ,%y3%
		
		}
		else
		{
			y3:=y1*x3/x1
			y3:=Round(y3,2)	
				
			guicontrol,,y3 ,%y3%	
		}
		Prev_x3:=x3		
	 }
	 
	else if !(Prev_y3==y3)
	{
		if (magnify)
		{
		x3:=x1*magnifyN
		x3:=Round(x3,2)			
		guicontrol,,x3 ,%x3%
		
		}
		else
		{
			x3:=y3*x1/y1
			x3:=Round(x3,2)			
			guicontrol,,x3 ,%x3%		
		}
		Prev_y3:=y3
	}	 
return

copy_ratio:
	clipboard=%x2%x%y2%
	sleep,100
	tooltip,%clipboard%
	settimer,removetooltip,-800
return

ratio_calc:	;	show ratio calculator

	gui,show
	guicontrol,focus,x2
	SendMessage, ( EM_SETSEL := 0xB1 ), 0, -1, , ahk_id %ED1%	;preselects the text

return

paste_base_ratio:
	ratio1:=clipboard
	gosub,set_ratio
	
return
ratio_calc_sel: 	;	show ratio calculator on sel text
	; 640,480 12*75 12x 75 197 x 45 25+89
	ratio1:=Get_Selected_Text()
	if ratio1<>
		gosub,set_ratio
	gui,show
	guicontrol,focus,x2
	SendMessage, ( EM_SETSEL := 0xB1 ), 0, -1, , ahk_id %ED1%	;preselects the text
return

set_ratio:

	ratio1:=regexreplace(ratio1,"[^A-Za-z0-9/\-\.\*\+]`,", "")
	ratio1:=regexreplace(ratio1,"[×A-WY-Za-wy-z]", "")

	tmp_1=
	tmp_2=
	ifinstring,ratio1,`,
		delimiter=`,
	else ifinstring,ratio1,*
		delimiter=*
	else ifinstring,ratio1,x
		delimiter=x
	else ifinstring,ratio1,X
		delimiter=X
	else ifinstring,ratio1,+
		delimiter=+
	else ifinstring,ratio1,/
		delimiter=/
	else ifinstring,ratio1,-
		delimiter=-

		loop,parse,ratio1,%delimiter%
			tmp_%a_index%:=a_loopfield
		tmp_x1:=tmp_1
		tmp_y1:=tmp_2
	if tmp_x1<>
		{
		guicontrol,,updownx1 ,%tmp_x1%
		guicontrol,,x1 ,%tmp_x1%
		}
	else
		{
		guicontrol,,updownx1 ,%ratio1%
		guicontrol,,x1 ,%ratio1%
		}
	if tmp_y1<>
		{
		guicontrol,,updowny1 ,%tmp_y1%
		guicontrol,,y1 ,%tmp_y1%
		}
gosub,simple_ratio
return

hide:
	gui,hide
return


removetooltip:
	tooltip,
	settimer,removetooltip,off
return	

paste_ratio:
	clipboard=%x2%x%y2%
	sleep,40
	tooltip,%clipboard%
	gosub,hide
	sleep,450
	tooltip
	; send ^v
	send_key_emacs_or_after_translatingTo_normal_ifNot_emacseditor("C-y")
return

#IfWinActive, ratio calculator.ahk


~numpadEnter::	; na
~Enter::	; na
	ControlGetFocus, OutputVar 
	; tooltip,%OutputVar%
	; sleep,200
	; tooltip

	gosub,hide
	if (OutputVar="edit2")
		clipboard=%y2%
	else if (OutputVar="edit7")
		clipboard=%x2%
	sleep,40
	tooltip,%clipboard%
	gosub,hide
	sleep,300
	tooltip
	; send ^v
	send_key_emacs_or_after_translatingTo_normal_ifNot_emacseditor("C-y")

return


#IfWinActive

simple_ratio:
a:=gcd(x1,y1)
; msgbox,%a%
b:=x1/a
c:=y1/a
b:=round(b,0)
c:=round(c,0)
simple_ratio=%b%/%c%
guicontrol,,simple_ratio_text,%b% / %c%
return

gcd(a, b) {
	if b
		return gcd(b, mod(a, b))
	return a
}

>^':: ; show ratio calc

settimer,cancelratio_cycle,off	
if !(ratio_cycle_active)	;	if hotkey is currently not in cycle mode 
{
	ratio_cycle_count:=0
}
settimer,cancelratio_cycle,-2500	

if (ratio_cycle_count=0)
{	
	ratio_cycle_count++
	msg=ratio calc
	settimer,removetooltip,-2600
	tooltip,%ratio_cycle_count% %msg%
	ratio_cycle_action = ratio_calc
}
else if (ratio_cycle_count=1)
{	
	ratio_cycle_count++
	msg=ratio_calc_sel
	settimer,removetooltip,-2600
	tooltip,%ratio_cycle_count% %msg%
	
	ratio_cycle_action = ratio_calc_sel
}
else
{	

	ratio_cycle_count:=0
	msg=cancel
	settimer,removetooltip,-1600
	tooltip,%ratio_cycle_count% %msg%
	settimer,cancelratio_cycle,-1600		
}
	
	ratio_cycle_active:=1
	hotkey,^q,on
	setTimer,ratio_cycle,70
	sleep,10



ratio_cycle:	;	cancel checking status of ctrl key
	GetKeyState,state,CTRL
	If state=u
	{
		gosub,cancelratio_cycle
		if (ratio_cycle_count=0)
		{	
			settimer,removetooltip,-1500
			tooltip,%ratio_cycle_count% cancelled
			
		}
		else if (ratio_cycle_count=1)
		{
		
			gosub,%ratio_cycle_action%
			
		}
		else if (ratio_cycle_count=2)
		{	

			gosub,%ratio_cycle_action%

		}
		else if (ratio_cycle_count=3)
		{
			gosub,%ratio_cycle_action%
		}

	}
return

cancelratio_cycle:	;	cancel without action
	setTimer,ratio_cycle,off
	ratio_cycle_active:=0
	tooltip,cancelling
	settimer,removetooltip,-300
	hotkey,^q,off
	
return


$^q::	; na
send ^q

Return

