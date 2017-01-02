#SingleInstance Force
#include C:\cbn_gits\AHK\LIB\misc functions.ahk
#include C:\cbn_gits\AHK\LIB\cbn.ahk
#include C:\cbn_gits\AHK\LIB\contextmenu.ahk
#include C:\cbn_gits\AHK\LIB\HK_Cycle dev2.ahk


source_text=
(
a:=b
a,b,c,d,e,f
"a","b","c"
a==b&c==d
a=b&c=d
result:=sum(a,b)
sum(a,b)
a=b
C:\cbn_gits\AHK\LIB\misc functions.ahk
hello:=welcome
)

first_valid_line := get_first_non_empty_line( source_text )
type=
	type := smart_match( first_valid_line,type )

	msgbox,%type%
	type := smart_match( first_valid_line,type )

	msgbox,%type%
	type := smart_match( first_valid_line,type )

	msgbox,%type%