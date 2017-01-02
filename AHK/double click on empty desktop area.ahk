~LButton::
   If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
   {
      WinGetClass, Class, A
      If ( Class = "WorkerW" ) or ( Class = "Progman" )
        if _EmptyDesktopSpot()
          MsgBox, 4160, , You Double Clicked on Desktop
   }
return

_EmptyDesktopSpot()
{
  LVM_GETSELECTEDCOUNT := 0x1000 + 50
  GroupAdd, DeskGroup, ahk_class WorkerW
  GroupAdd, DeskGroup, ahk_class Progman
  handle := WinExist("ahk_group DeskGroup")
  if (! handle)
    return false
  handle := DllCall("GetWindow","Ptr",handle,"Uint",5,"Ptr")
  if (! handle)
    return false
  handle := DllCall("GetWindow","Ptr",handle,"Uint",5,"Ptr")
  if (! handle)
    return false
  SendMessage,%LVM_GETSELECTEDCOUNT%,0,0,,ahk_id %handle%
  if (ErrorLevel = "FAIL")
    return false
  if (! ErrorLevel) ; nothing selected so we clicked on blank spot
    return true
  return false
}