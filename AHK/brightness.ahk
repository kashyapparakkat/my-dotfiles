Menu, Tray, tip,brightness`nincrease >^!`,::`ndecrease >^!.::
ifexist,brightness.ico
	Menu, Tray, Icon, brightness.ico
menu ,tray,add,increase,brightness_incre
menu ,tray,add,decrease,brightness_decre
;#NoTrayIcon    don't display the script icon in the tray 
#MaxHotkeysPerInterval 200 
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases. 
#SingleInstance force 
SetBatchLines -1 
br := 128
Brght_Step = 8 


!+MBUTTON:: ; Set Brightness back to 50 % F2 
  br := 118 ; brightness, in the range of 0 - 255, where 128 is normal 

>!>+,:: ; reduce the brightness
brightness_decre: ; reduce the brightness
!+wheeldown:: ; reduce the brightness 
  brightness_change :=-Brght_Step 
  gosub,change_brightness
return


>!>+.:: ; increase the brightness
brightness_incre:
!+wheelup:: ; increase the brightness
  brightness_change:=Brght_Step 
  gosub,change_brightness
return

change_brightness:
  ; ------------------- 
  ; START CONFIGURATION 
  ; ------------------- 
  ; The percentage by which to raise or lower the volume each time 
  ; How long to display the volume level bar graphs (in milliseconds) 
  vol_DisplayTime = 1500 
  ; Transparency of window (0-255) 
  vol_TransValue = 180 
  ; Bar's background colour  
  vol_CW = EEEEEE    
  vol_Width = 300  ; width of bar 
  vol_Thick = 20   ; thickness of bar 
  ; Bar's screen position 
  vol_PosX := A_ScreenWidth/2 - vol_Width/2 
  vol_PosY := A_ScreenHeight/1.08 - vol_Thick/2 

  ; -------------------- 
  ; END OF CONFIGURATION 
  ; -------------------- 
  vol_BarOptionsMaster = 1:B1 ZH%vol_Thick% ZX8 ZY4 W%vol_Width% X%vol_PosX% Y%vol_PosY% CW%vol_CW% 


  br += brightness_change
  If ( br > 256 ) 
     br := 256  
  If ( br < 0) 
     br := 0    
  VarSetCapacity(gr, 512*3) 
  Loop, 256 
  { 
     If  (nValue:=(br+128)*(A_Index-1))>65535 
          nValue:=65535 
     NumPut(nValue, gr,      2*(A_Index-1), "Ushort") 
     NumPut(nValue, gr,  512+2*(A_Index-1), "Ushort") 
     NumPut(nValue, gr, 1024+2*(A_Index-1), "Ushort") 
  } 
  hDC := DllCall("GetDC", "Uint", 0) ;NULL for entire screen 
  DllCall("SetDeviceGammaRamp", "Uint", hDC, "Uint", &gr) 
  DllCall("ReleaseDC", "Uint", 0, "Uint", hDC) 




vol_ShowBars: 
; Get volumes in case the user or an external program changed them: 
vol_Master := (br/2.5) 
vbr := (br*100)//256  
if vol_Master = 128 
{ 
  vol_Colour = Green 
  vol_Text = Brightness %vbr%`% 
} 

if vol_Master > 128 
{ 
  vol_Colour = Red    
  vol_Text = Brightness %vbr%`% 
} 
if vol_Master < 128 
{ 
  vol_Colour = Blue 

  vol_Text = Brightness %vbr%`% 
} 

; To prevent the "flashing" effect, only create the bar window if it doesn't already exist: 
IfWinNotExist, BrightnessOSDxyz 
{ 
    ;Progress, %vol_BarOptionsMaster% CB%vol_Colour% CT%vol_Colour%, , %vol_Text%, BrightnessOSDxyz 
	Progress, %vol_BarOptionsMaster% CBgreen , , %vol_Text%, BrightnessOSDxyz 
    WinSet, Transparent, %vol_TransValue%, BrightnessOSDxyz 
} 


Progress, 1:%vol_Master% ,, %vol_Text% 
SetTimer, vol_BarOff, %vol_DisplayTime% 
return 


vol_BarOff: 
SetTimer, vol_BarOff, off 
Progress, 1:Off 
return
nil:
 return
 