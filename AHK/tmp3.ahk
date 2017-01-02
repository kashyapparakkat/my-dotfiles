#SingleInstance Force
#include C:\cbn_gits\AHK\LIB\misc functions.ahk
#include C:\cbn_gits\AHK\LIB\cbn.ahk
#include C:\cbn_gits\AHK\LIB\contextmenu.ahk
DesiredName := "config"  ; Put here part of the name shown in Add/Remove.
UninstallKey := "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
Loop HKLM, %UninstallKey%, 2
{
    RegRead thisName, HKLM, %UninstallKey%\%A_LoopRegName%, DisplayName
    if InStr(thisName, DesiredName)
    {
	msgbox,%thisName%
        ; RegRead uninst, HKLM, %UninstallKey%\%A_LoopRegName%, UninstallString
        ; RegRead quiet, HKLM, %UninstallKey%\%A_LoopRegName%, QuietUninstallString
        ; if ErrorLevel
            ; quiet := "(none)"
        ; MsgBox,
        ; (LTrim
        ; Key:`t%A_LoopRegName%
        ; Name:`t%thisName%
        ; Uninst:`t%uninst%
        ; Quiet:`t%quiet%
        ; )
    }
}