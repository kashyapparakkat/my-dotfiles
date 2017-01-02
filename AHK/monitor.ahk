/*

leftMonitorWidth = 1600
leftMonitorHeight = 900
rightMonitorWidth = 1280
rightMonitorHeight = 1024

^!q::    ;Default hotkey is Ctrl+Alt+Q
activeWindow := WinActive("A")
if activeWindow = 0
{
    return
}
WinGet, minMax, MinMax, ahk_id %activeWindow%
if minMax = 1
{
    WinRestore, ahk_id %activeWindow%
}
WinGetPos, x, y, width, height, ahk_id %activeWindow%
if x < 0
{
    xScale := rightMonitorWidth / leftMonitorWidth
    yScale := rightMonitorHeight / leftMonitorHeight
    x := leftMonitorWidth + x
    newX := x * xScale
    newY := y * yScale
    newWidth := width * xScale
    newHeight := height * yScale
}
else
{
    xScale := leftMonitorWidth / rightMonitorWidth
    yScale := leftMonitorHeight / rightMonitorHeight
    newX := x * xScale
    newY := y * yScale
    newWidth := width * xScale
    newHeight := height * yScale
    newX := newX - leftMonitorWidth
}
WinMove, ahk_id %activeWindow%, , %newX%, %newY%, %newWidth%, %newHeight%
if minMax = 1
{
    WinMaximize, ahk_id %activeWindow%
}
WinActivate ahk_id %activeWindow%   ;Needed - otherwise another window may overlap it
return


*/


















SysGet, Mon1, Monitor, 1
SysGet, Mon2, Monitor, 2

+m::   ;move window under mouse
mousegetpos,,,windowtomove
gosub windowmove
return

+a::	; na
winget,windowtomove,id,A    ;move active window
gosub windowmove
return

windowmove:
if not mon2left
return
wingetpos,x1,y1,w1,h1,ahk_id %windowtomove%
winget,winstate,minmax,ahk_id %windowtomove%
m1:=(x1+w1/2>mon1left) and (x1+w1/2<mon1right) and (y1+h1/2>mon1top) and (y1+h1/2<mon1bottom) ? 1:2   ;works out if centre of window is on monitor 1 (m1=1) or monitor 2 (m1=2)
m2:=m1=1 ? 2:1  ;m2 is the monitor the window will be moved to
ratiox:=abs(mon%m1%right-mon%m1%left)-w1<5 ? 0:abs((x1-mon%m1%left)/(abs(mon%m1%right-mon%m1%left)-w1))  ;where the window fits on x axis
ratioy:=abs(mon%m1%bottom-mon%m1%top)-h1<5 ? 0:abs((y1-mon%m1%top)/(abs(mon%m1%bottom-mon%m1%top)-h1))   ;where the window fits on y axis
x2:=mon%m2%left+ratiox*(abs(mon%m2%right-mon%m2%left)-w1)   ;where the window will fit on x axis in normal situation
y2:=mon%m2%top+ratioy*(abs(mon%m2%bottom-mon%m2%top)-h1)
w2:=w1   
h2:=h1   ;width and height will stay the same when moving unless reason not to lower in script

if abs(mon%m1%right-mon%m1%left)-w1<5 or abs(mon%m2%right-mon%m2%left-w1)<5   ;if x axis takes up whole axis OR won't fit on new screen
   {
   x2:=mon%m2%left   
   w2:=abs(mon%m2%right-mon%m2%left)
   }
if abs(mon%m1%bottom-mon%m1%top)-h1<5 or abs(mon%m2%bottom-mon%m2%top)-h1<5
   {
   y2:=mon%m2%top
   h2:=abs(mon%m2%bottom-mon%m2%top)
   }
if winstate   ;move maximized window
   {
   winrestore,ahk_id %windowtomove%
   winmove,ahk_id %windowtomove%,,mon%m2%left,mon%m2%top
   winmaximize,ahk_id %windowtomove%
   }
else
   {
   if (x1<mon%m1%left)
      x2:=mon%m2%left   ;adjustments for windows that are not fully on the initial monitor (m1)
   if (x1+w1>mon%m1%right)
      x2:=mon%m2%right-w2
   if (y1<mon%m1%top)
      y2:=mon%m2%top
   if (y1+h1>mon%m1%bottom)
      y2:=mon%m2%bottom-h2
   winmove,ahk_id %windowtomove%,,x2,y2,w2,h2   ;move non-maximized window
   }
return