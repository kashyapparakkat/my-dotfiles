part=1
block_size=2000
action=receive
target_file=%A_ScriptDir%\target_file.txt
source_file=%A_ScriptDir%\source_text.txt
source_file=C:\users\%A_UserName%\downloads\text\miscnotes.txt
File := FileOpen(source_file, "r")
;pz1 = piece 1 expctd

if (action=="send")
	clipboard=copypz1
;gosub,xport
 return

onclipboardchange:
tooltip,checking
sleep,200
	gosub,xport
return

^6::
exitapp
return

get_part_number()
{
	if (regexmatch(clipboard,"^copypz\d+"))
	{
		part := regexreplace(clipboard,"^copypz(\d+)","$1" )
	}
	else if (regexmatch(clipboard,"^copiedpz\d+"))
	{
		part := regexreplace(clipboard,"^copiedpz(\d+)","$1" )
	}
	
return part
}

xport:
; sender
if (action=="send")
{
	if (regexmatch(clipboard,"^copypz\d+"))
	{
		part := get_part_number()
	
	; Fileread form part*size to part+1
		File.Position := (part-1)*block_size
		string:=File.read(block_size)
		msgbox, copied %part% %string%=
		clipboard=copiedpz%part% %string%
		
	}
}
else if (action="receive")
{
  if regexmatch(clipboard,"^copiedpz\d+")
   {  ; if nextpart_expected==part
		part := get_part_number()
     Fileappend,%clipboard%,%target_file%
	 msgbox, pasted %part%
	part++
	clipboard=copypz%part%
	}
}

return
; copy django path
