n:=7000
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
loop,100
{
	tooltip,%n%
	; urldownloadtofile ,http://malayalamsongslyrics.com/lyrics_new/lyrics.php?id=%n%, %n%.html
	whr.Open("GET", "http://malayalamsongslyrics.com/lyrics_new/lyrics.php?id=%n%")
	whr.Send()
	version := whr.ResponseText
		n++
	ifinstring,version,unknown
		continue
	else
		fileappend,version,a %n%.html
}