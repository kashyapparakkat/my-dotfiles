start_time:=a_now	;time accurate to 1sec
fileread,list,list.txt
loop,parse,list,`n`r
{
	splitpath,a_loopfield,name
	urldownloadtofile,%a_loopfield%,%name%
}
end:
end_time:=a_now
diff:=end_time-start_time
if (diff> 15)	;yyyymmddhhmmss
	{
	SoundBeep, 2050, 1000  ; Play
	msgbox,finished	
	}
else if (diff> 5)	;yyyymmddhhmmss
	{
	SoundBeep, 2050, 1500  ; Play
	}
else if (diff> 2)	;yyyymmddhhmmss
	{
	SoundBeep, 2050, 1000  ; Play
	}
	
return