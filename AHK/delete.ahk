		line=see later
delimiter_all:=", "
loop,parse,delimiter_all
{
	
		msgbox,=%a_loopfield%=
		sleep,1000
		ifinstring,line,%a_loopfield%
		{
		delimiter:=a_loopfield
; ifinstring,line,%A_space%
	msgbox,de =%a_loopfield%=
		loop,parse,line,%delimiter%
	{
	msgbox,%a_loopfield% 
	}
	}
}