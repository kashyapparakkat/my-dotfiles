#NoEnv
#SingleInstance , Force
SetWorkingDir %A_ScriptDir%
ifexist , join.ico
	menu, Tray, Icon,join.ico
#include LIB\cbn.ahk

#include C:\cbn_gits\AHK\LIB\emacs_functions.ahk
HotkeySTEP_join:=0
; hotkey,^l,off
last_used_padding=
append_side:=1

<^k::	;	smart joiner l:: ulta  J:: add to
if !(HotkeySTEP_join)	
{
	selText := Get_Selected_Text_fast()
	HotkeySTEP_join_count   :=0
	HotkeySTEP_join_2_count :=0
	HotkeySTEP_join_3_count :=0
	HotkeySTEP_join := 1
	newlines1:=0
	newlines2:=0
		text2:=clipboard
		Loop, Parse, text2, `n,`r
		newlines1++

		Loop, Parse, selText, `n,`r
			newlines2++
		if ( newlines1>newlines2)
			total_items:=newlines1
		else
			total_items:=newlines2
		
		if (newlines2=1)
		{
			text_tmp=
			loop,%total_items%
			{
				text_tmp .= selText . "`n"
			}
			stringtrimright,text_tmp,text_tmp,1
			selText:= text_tmp
			tooltip,Lines Duplicated
			sleep,400
		}
		else if (newlines1=1)
		{
			text_tmp=
			loop,%total_items%
			{
				text_tmp .= text2 . "`n"
			}
			stringtrimright,text_tmp,text_tmp,1
			text2:= text_tmp
			tooltip,Lines Duplicated
			sleep,400
		}
		; msgbox,%text2%
		
}
if (HotkeySTEP_join)	;	if hotkey is currently running
{
	
	if (HotkeySTEP_join_count=0)
	{
		padding_text := last_used_padding
		append_side:=1
		gosub,join_text
		if ( last_used_padding="`,")	; skip similar step 
			HotkeySTEP_join_count:=HotkeySTEP_join_count+3
		else if ( last_used_padding="")	; skip similar step 
			HotkeySTEP_join_count:=HotkeySTEP_join_count+2
		else
			HotkeySTEP_join_count++
		msg=%HotkeySTEP_join_count%. line by line joining Separator: %last_used_padding% (last_used) ^l:rotate`nclipB:%newlines1% lines   sel:%newlines2% lines
		text:=truncated_text(output,420)
		tooltip,%msg%`n`n%text%
		settimer,removetooltip,-2500
	}
	else if (HotkeySTEP_join_count=1)
	{
		padding_text =
		append_side:=1
		gosub,join_text
		HotkeySTEP_join_count++
		msg=%HotkeySTEP_join_count% Separator: NULL
		text := truncated_text(output,420)
		tooltip , %msg%`n`n%text%
		settimer , removetooltip , -2500
	}
	else if (HotkeySTEP_join_count=2)
	{
		padding_text =`,
		append_side:=1
		gosub,join_text
		HotkeySTEP_join_count++
		msg=%HotkeySTEP_join_count% Separator: `,
		text := truncated_text(output,420)
		tooltip , %msg%`n`n%text%
		settimer , removetooltip , -2500
	}
	else if (HotkeySTEP_join_count=3)
	{
		padding_text = %a_space%-%a_space%
		append_side:=1
		gosub,join_text
		HotkeySTEP_join_count++
		msg=%HotkeySTEP_join_count% Separator: `,
		text := truncated_text(output,420)
		tooltip , %msg%`n`n%text%
		settimer , removetooltip , -2500
	}
	else if (HotkeySTEP_join_count=4)
	{

		padding_text = %a_space%****%a_space%
		append_side:=1
		gosub,join_text
		HotkeySTEP_join_count++
		msg=%HotkeySTEP_join_count% advanced
		text := truncated_text(output,420)
		tooltip , %msg%`n`n%text%
		settimer , removetooltip , -2500
		
	}
	else if (HotkeySTEP_join_count=5)
	{
		padding_text = %a_space%****%a_space%
		append_side:=1
		gosub,join_text
		HotkeySTEP_join_count++
		msg=%HotkeySTEP_join_count% advanced A X B
		text := truncated_text(output,420)
		tooltip , %msg%`n`n%text%
		settimer , removetooltip , -2500
	}
	else
	{
		HotkeySTEP_join_count:=0
		msg=cancel		
		tooltip,%msg%
		settimer , removetooltip , -2500
	}
	HotkeySTEP_join_2_count:=0
	hotkey,^q,on
	hotkey,^l,on
	hotkey,^j,on

	setTimer,HotkeySTEP_join,70	
}
return

$^l:: ;	na

if ( HotkeySTEP_join )
{
	if (HotkeySTEP_join_count=1)
	{

		if (HotkeySTEP_join_2_count=0)
		{
			HotkeySTEP_join_2_count++
			padding_text := last_used_padding
			append_side:=0
			gosub,join_text

			msg=line by line joining
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}
		else 
		{
			HotkeySTEP_join_2_count:=0

			padding_text := last_used_padding
			append_side:=1
			gosub,join_text

			msg=line by line joining
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
			
		}


	}
	else if (HotkeySTEP_join_count=2)
	{

		if (HotkeySTEP_join_2_count=0)
		{
			HotkeySTEP_join_2_count++
			; padding_text := last_used_padding
			append_side:=0
			gosub,join_text

			msg=line by line joining
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}
		else
		{
			HotkeySTEP_join_2_count:=0
			; padding_text := last_used_padding
			append_side:=1
			gosub,join_text

			msg=line by line joining ULTA
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}

	}
	else if (HotkeySTEP_join_count=3 OR HotkeySTEP_join_count=4)
	{

		if (HotkeySTEP_join_2_count=0)
		{
			HotkeySTEP_join_2_count++
			; padding_text := last_used_padding
			append_side:=0
			gosub,join_text

			msg=line by line joining
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}
		else
		{
			HotkeySTEP_join_2_count:=0
			; padding_text := last_used_padding
			append_side:=1
			gosub,join_text

			msg=line by line joining ULTA
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}

	}
	else if (HotkeySTEP_join_count=5)
	{
		if (HotkeySTEP_join_2_count=0)
		{
			HotkeySTEP_join_2_count++
			append_side:=0
			gosub,join_text

			msg=ADVANCED
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}
		else
		{
			HotkeySTEP_join_2_count:=0
			append_side:=1
			gosub,join_text

			msg=ADVANCED Ulta
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}
	}
	else if (HotkeySTEP_join_count=6)
	{
		if (HotkeySTEP_join_2_count=0)
		{
			HotkeySTEP_join_2_count++
			append_side:=0
			gosub,join_text
			msg=AxB ADVANCED
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}
		else
		{
			HotkeySTEP_join_2_count:=0
			append_side:=1
			gosub,join_text
			msg=AxB ADVANCED Ulta
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
			
		}
	}
	else
	{

	}
}
else
	send ^l
return


$^j:: ;	na

if ( HotkeySTEP_join )
{
	if (HotkeySTEP_join_count=1)
	{
		if (HotkeySTEP_join_3_count=0)
		{
			HotkeySTEP_join_3_count++
			padding_text := last_used_padding
			append_side:=0
			gosub,join_text
			msg=add to
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}
		else 
		{
			HotkeySTEP_join_3_count:=0
			padding_text := last_used_padding
			append_side:=1
			gosub,join_text
			msg=line by line joining
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}
	}
	else if (HotkeySTEP_join_count=2)
	{

		if (HotkeySTEP_join_3_count=0)
		{
			HotkeySTEP_join_3_count++
			; padding_text := last_used_padding
			append_side:=0
			gosub,join_text

			msg=Add To BIN as fresh
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}
		else
		{
			HotkeySTEP_join_3_count:=0
			; padding_text := last_used_padding
			append_side:=1
			gosub,join_text

			msg=line by line joining ULTA
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}

	}
	else if (HotkeySTEP_join_count=3 OR HotkeySTEP_join_count=4)
	{

		if (HotkeySTEP_join_3_count=0)
		{
			HotkeySTEP_join_3_count++
			; padding_text := last_used_padding
			append_side:=0
			gosub,join_text

			msg=line by line joining
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}
		else
		{
			HotkeySTEP_join_3_count:=0
			; padding_text := last_used_padding
			append_side:=1
			gosub,join_text

			msg=line by line joining ULTA
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}

	}
	else if (HotkeySTEP_join_count=5)
	{
		if (HotkeySTEP_join_3_count=0)
		{
			HotkeySTEP_join_3_count++
			append_side:=0
			gosub,join_text

			msg=ADVANCED
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}
		else
		{
			HotkeySTEP_join_3_count:=0
			append_side:=1
			gosub,join_text

			msg=ADVANCED Ulta
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
			
		}
	}
	else if (HotkeySTEP_join_count=6)
	{
		if (HotkeySTEP_join_3_count=0)
		{
			HotkeySTEP_join_3_count++
			append_side:=0
			gosub,join_text

			msg=AxB ADVANCED
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
		}
		else
		{
			HotkeySTEP_join_3_count:=0
			append_side:=1
			gosub,join_text

			msg=AxB ADVANCED Ulta
			text:=truncated_text(output,420)
			tooltip,%msg%`n`n%text%
			settimer,removetooltip,-2500
			
		}
	}
	else
	{

	}
}
else
	send ^j
return


HotkeySTEP_join:
GetKeyState , state , CTRL

If ( state = "U" )
{
	gosub , cancelHotkeySTEP_join
	if (HotkeySTEP_join_count=0)
	{
		tooltip , cancelledd
		settimer,removetooltip,-600
	}
	else if (HotkeySTEP_join_count=5)
	{
		inputbox,padding_text,padding text,selText + clipboard,,,,,,,,%last_used_padding%
		gosub,join_text
		text:=truncated_text(output,520)
		tooltip,%msg%`nENTER To Send`n%text%`ncopied
		settimer,removetooltip,-3000
		clipboard:=output
		last_used_padding:= padding_text
		Input, UserInput, T3 L1 C, {enter}.{esc}{tab}
		tooltip,
		If InStr(ErrorLevel, "EndKey:enter")
		{	
		send, ^v
		}
	}
	else if (HotkeySTEP_join_count=6)
	{
		inputbox,padding_text,padding text,selText + clipboard,,,,,,,,%last_used_padding%
		gosub,join_text
		text:=truncated_text(output,520)
		tooltip,%msg%`nENTER To Send`n%text%`ncopied
		settimer,removetooltip,-3000
		clipboard:=output
		last_used_padding:= padding_text
		Input, UserInput, T3 L1 C, {enter}.{esc}{tab}
		tooltip,
		If InStr(ErrorLevel, "EndKey:enter")
		{	
			send, ^v
		}
	}
	else
	{
		text:=truncated_text(output,520)
		tooltip,%msg%`nENTER To Send`n%text%`ncopied
		settimer,removetooltip,-3000
		clipboard:=output
		last_used_padding:= padding_text
		Input, UserInput, T3 L1 C, {enter}.{esc}{tab}
		tooltip,
		If InStr(ErrorLevel, "EndKey:enter")
		{	
			send, ^v
		}		
	}
}
return
 
cancelHotkeySTEP_join:	;	cancel without action
	
	setTimer,HotkeySTEP_join,off
	HotkeySTEP_join:=0
	; HotkeySTEP_join_count:=0
	; HotkeySTEP_join_2_count :=0
	; HotkeySTEP_join_3_count :=0

	state=
	hotkey,^q,off
	hotkey,^l,off
return


removetooltip:
	settimer ,removetooltip,off
	tooltip
return


$^q::	; na
send ^q

Return

join_text:

output=
if (HotkeySTEP_join_count=6)
{
	loop, parse, selText,`n,`r
		tmp_text_%a_index%:=a_loopfield

	if ( append_side=1 )
		{	
			loop,parse,text2,`n,`r
				{
					a:=a_loopfield
					loop, parse, selText,`n,`r
						output .= a . padding_text . a_loopfield . "`n"
				}
		}
		else
		{	
			loop,parse,text2,`n,`r
				{
					a:=a_loopfield
					loop, parse, selText,`n,`r
						output .= a_loopfield . padding_text . a . "`n"
				}
		}
		; msgbox,%output%
}
else
{	; if ( newlines1>1 )
		{
			loop, parse, selText,`n,`r
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
}
stringtrimright,output,output,1
; msgbox,=%output%=
return
		