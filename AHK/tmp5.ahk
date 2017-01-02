a ="menuEvent_function(""OpenIfFolder_SelectIfFile"",""C:\cbn"")","menuEvent_function(""OpenIfFolder_SelectIfFile"",""C:\cbn_gits\AHK\LIB"")"

loop,parse,a,CSV
	msgbox, %a_loopfield%