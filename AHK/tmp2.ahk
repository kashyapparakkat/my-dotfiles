#SingleInstance Force
#include C:\cbn_gits\AHK\LIB\misc functions.ahk
#include C:\cbn_gits\AHK\LIB\cbn.ahk
#include C:\cbn_gits\AHK\LIB\contextmenu.ahk

source_text=
(
cibin,mathew=kerala
albin,mathew,sing
)

; source_text = a=b&c=d
delim=
return
; cibin%mathew:=r
^p::

delim := get_next_delimiter(source_text,delim,0)

tooltip, %delim%
return