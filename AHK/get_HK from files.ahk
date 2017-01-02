fileread,all_files,imp_ahk_files.txt

reg=(.*?[:]?)::
reg=^[^`;:]*::.*$
output=
loop,parse,all_files,`n,`r
{
	fileread,text,%a_loopfield%
	loop,parse,text,`n,`r
	{
		if (regexmatch(a_loopfield,reg))
			output .= a_loopfield . "`n"
	}
}
text := output
output=
reg=^.*::\s*`;\s*na\s*$
loop,parse,text,`n,`r
{
	if !( regexmatch(a_loopfield,reg) )
		output .= a_loopfield . "`n"

}
text := output
output=
reg=^[^:]*::\s*$
loop,parse,text,`n,`r
{
	if !(regexmatch(a_loopfield,reg))
		output .= a_loopfield . "`n"
}
; /*
text := output
output =
reg=^[^:]+,[^:]+::.*$
loop,parse,text,`n,`r
{
	if !(regexmatch(a_loopfield,reg))
		output .= a_loopfield . "`n"
}
; */
msgbox,%output%
filedelete,tmp11.txt
fileappend,%output%,tmp11.txt