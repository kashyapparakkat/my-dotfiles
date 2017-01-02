#SingleInstance force
#Persistent
#NoEnv

; F3::	; na

^wheeldown::	; na
; ^lbutton::	; na
	gosub, select_word2
	; sleep,1000
	send, ^k
return

^+wheelup::	; na
MouseGetPos ah_MouseX, ah_MouseY  ; Save current mouse position
  MouseMove %A_CaretX%, %A_CaretY%, 0  ; Move mouse cursor to current caret
  send {Control Down}
  Click 1  ; Perform doubleclick
  send {Control up}
  MouseMove ah_MouseX, ah_MouseY, 0  ; Restore previous mouse positionretun
return
  
  
^wheelup::	; na
; ^lbutton::	; na
	gosub,select_word2
	; sleep,1000
	send, ^+k
return

select_word2:
; #IfWinActive ahk_class OpusApp
^W::	; na
SendInput ^{left}+^{right}
#IfWinActive
return


select_word:
ControlGetFocus ah_Editor, A  ; Retrieve the name of the focused editor control
ControlGet ah_SelectedText, Selected, , %ah_Editor%, A  ; Read selected text if it supports this function
tooltip,%ah_Editor% sel=%ah_SelectedText%
; sleep,3200
tooltip
if ah_SelectedText =
{
  tooltip,selecting
  ; sleep,1200
  tooltip
  ; There is no selection, try to find the word under the caret
  MouseGetPos ah_MouseX, ah_MouseY  ; Save current mouse position
  MouseMove %A_CaretX%, %A_CaretY%, 0  ; Move mouse cursor to current caret
  Click 2  ; Perform doubleclick
  MouseMove ah_MouseX, ah_MouseY, 0  ; Restore previous mouse position
}

return

/*
CopyCurrentWordAndSearchHelp:  ; CoordMode for Mouse and Caret has to be the same
ah_ClipSaved := ClipboardAll   ; Save the entire clipboard
Clipboard =  ; Clear clipboard
ControlGetFocus ah_Editor, A  ; Retrieve the name of the focused editor control
ControlGet ah_SelectedText, Selected, , %ah_Editor%, A  ; Read selected text if it supports this function
if ah_SelectedText =
{  ; There is no selection, try to find the word under the caret
  MouseGetPos ah_MouseX, ah_MouseY  ; Save current mouse position
  MouseMove %A_CaretX%, %A_CaretY%, 0  ; Move mouse cursor to current caret
  Click 2  ; Perform doubleclick
  MouseMove ah_MouseX, ah_MouseY, 0  ; Restore previous mouse position
}
Send ^c  ; Copy selected text
ClipWait 0.5, 1  ; Wait for clipboard



if not ErrorLevel 
  GoSub SearchClipboardInHelpfile  ; We can now search using the clipboard
Clipboard := ah_ClipSaved  ; Restore the original clipboard
ah_ClipSaved =  ; Free the memory
Return


*/
