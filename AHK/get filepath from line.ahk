
SplitPath, A_ScriptDir , , , , , A_Script_Drive
#include LIB\cbn.ahk
reg=
edit3=title %A_Script_Drive%\cbn\ahk\NEW\spy.ahk sasi
matchlist:=Find(edit3,"","",reg,0,3)
msgbox,%matchlist%