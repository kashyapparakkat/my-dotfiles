Log_folder = C:\cbn_gits\AHK\! logs


ILButton(hBtn, images, cx=16, cy=16, align=4, margin="1,1,1,1") {
	;#########		ILButton	##################
	; examples
	; ILButton(hBtn, "normal.ico:0|default.ico:0|pressed.ico:0|disabled.ico:0|defaulted.ico:0|stylushot.ico:0" , 16, 16, 0)

   static
   static i = 0
   local himl, v0, v1, v2, v3, ext, hbmp, hicon
   i ++

   himl := DllCall("ImageList_Create", "Int",cx, "Int",cy, "UInt",0x20, "Int",1, "Int",5, "UPtr")
   Loop, Parse, images, |
      {
      StringSplit, v, A_LoopField, :
      if not v1
         v1 := v3
      v3 := v1
      SplitPath, v1, , , ext
      if (ext = "bmp") {
         hbmp := DllCall("LoadImage", "UInt",0, "Str",v1, "UInt",0, "UInt",cx, "UInt",cy, "UInt",0x10, "UPtr")
         DllCall("ImageList_Add", "Ptr",himl, "Ptr",hbmp, "Ptr",0)
         DllCall("DeleteObject", "Ptr", hbmp)
         }
      else {
         DllCall("PrivateExtractIcons", "Str",v1, "Int",v2, "Int",cx, "Int",cy, "PtrP",hicon, "UInt",0, "UInt",1, "UInt",0)
         DllCall("ImageList_AddIcon", "Ptr",himl, "Ptr",hicon)
         DllCall("DestroyIcon", "Ptr", hicon)
         }
      }
   ; Create a BUTTON_IMAGELIST structure
   VarSetCapacity(struct%i%, A_PtrSize + (5 * 4) + (A_PtrSize - 4), 0)
   NumPut(himl, struct%i%, 0, "Ptr")
   Loop, Parse, margin, `,
      NumPut(A_LoopField, struct%i%, A_PtrSize + ((A_Index - 1) * 4), "Int")
   NumPut(align, struct%i%, A_PtrSize + (4 * 4), "UInt")
   ; BCM_FIRST := 0x1600, BCM_SETIMAGELIST := BCM_FIRST + 0x2
   PostMessage, 0x1602, 0, &struct%i%, , ahk_id %hBtn%
   Sleep 1 ; workaround for a redrawing problem on WinXP
   }
;##################################################
GetFormatedTime(_seconds)
{
	local h, m, s, t
	h := _seconds // 3600	
	_seconds -= h * 3600
	m := _seconds // 60
	s := _seconds - m * 60
	If (h > 1)
	{
		t := h . " hrs"	
	}
	Else IF (h = 1)
		t := "1 hr"
	If (t != "" and m + s > 0)
		t := t . " "
	If (m > 1)
		t := t . m . " min"	;minutes
	Else If (m = 1)
		t := t . "1 min"	; 1 minute
/* 	If (t != "" and s > 0)
		t := t . " "
	If (s > 1)
		t := t . s . " seconds"
	Else If (s = 1)
		t := t . "1 second"
	Else If (t = "")
		t := "0 seconds" 
		*/
	Return t
}

GetFormatedTime_Full(_seconds)
{
	local h, m, s, t
	h := _seconds // 3600
	_seconds -= h * 3600
	m := _seconds // 60
	s := _seconds - m * 60
	If (h > 1)
		t := h . " hours"
	Else IF (h = 1)
		t := "1 hour"
	If (t != "" and m + s > 0)
		t := t . " "
	If (m > 1)
		t := t . m . " minutes"
	Else If (m = 1)
		t := t . "1 minute"
	If (t != "" and s > 0)
		t := t . " "
	If (s > 1)
		t := t . s . " seconds"
	Else If (s = 1)
		t := t . "1 second"
	Else If (t = "")
		t := "0 seconds"
	Return t
}
GetFormatedDate_Full(filetime)
{
	StringLeft, filetime, filetime, 14
	; FormatTime, cur_time,,yyyyMMddhhmmss
	FormatTime, cur_time,,yyyyMMddHHmmss
	t:=cur_time-filetime
	
	; msgbox,%cur_time%-`n%filetime% `n=%t%
	if  (t<-100)
	{
		FormatTime, FileTime,%FileTime%,dddd MMM dd, yyyy hh:mm	tt	
		FileTime=Future time %FileTime%
	}
	else if (t<1000000)
	{
		FormatTime, FileTime,%FileTime%,hh:mm tt MMM dd, yyyy 
		FileTime=TODAY %FileTime%
	}
	else if (t<2000000)
	{
		FormatTime, FileTime,%FileTime%,MMM dd, yyyy hh:mm tt
		FileTime=YESTERDAY %FileTime%
	}
	else if (t<7000000)
		FormatTime, FileTime,%FileTime%,dddd MMM dd, yyyy hh:mm tt
	
	else
		FormatTime, FileTime,%FileTime%,MMM dd, yyyy hh:mm tt
		
	Return FileTime

}



; http://www.autohotkey.com/board/topic/93009-treeview-browser-browse-folders-files-and-export-for-offline-view/
GetIcon(FileName)		;http://www.autohotkey.com/board/topic/93009-treeview-browser-browse-folders-files-and-export-for-offline-view/
{

;========include in main=========================================
/*
ImageListID1 := IL_Create(10)
ImageListID2 := IL_Create(10, 10, true)  ; A list of large icons to go with the small ones.

; Attach the ImageLists to the ListView so that it can later display the icons:
LV_SetImageList(ImageListID1)
LV_SetImageList(ImageListID2)

*/
;========include in main=========================================


	global ImageListID1, ImageListID2
	VarSetCapacity(FileName, 260)
	sfi_size := A_PtrSize + 8 + (A_IsUnicode ? 680 : 340)
	VarSetCapacity(sfi, sfi_size)
	SplitPath, FileName,,, FileExt
	  if FileExt in EXE,ICO,ANI,CUR
	{
		ExtID := FileExt  ; Special ID as a placeholder.
		IconNumber = 0  ; Flag it as not found so that these types can each have a unique icon.
	}
	else  ; Some other extension/file-type, so calculate its unique ID.
	{
		ExtID = 0  ; Initialize to handle extensions that are shorter than others.
		Loop 7     ; Limit the extension to 7 characters so that it fits in a 64-bit value.
		{
			StringMid, ExtChar, FileExt, A_Index, 1
			if not ExtChar  ; No more characters.
				break
			; Derive a Unique ID by assigning a different bit position to each character:
			ExtID := ExtID | (Asc(ExtChar) << (8 * (A_Index - 1)))
		}
		; Check if this file extension already has an icon in the ImageLists. If it does,
		; several calls can be avoided and loading performance is greatly improved,
		; especially for a folder containing hundreds of files:
		IconNumber := IconArray%ExtID%
	}
	if not IconNumber  ; There is not yet any icon for this extension, so load it.
	{
		; Get the high-quality small-icon associated with this file extension:
		if not DllCall("Shell32\SHGetFileInfo" . (A_IsUnicode ? "W":"A"), "str", FileName, "uint", 0, "str", sfi, "uint", sfi_size, "uint", 0x101)  ; 0x101 is SHGFI_ICON+SHGFI_SMALLICON
			IconNumber = 9999999  ; Set it out of bounds to display a blank icon.
		else ; Icon successfully loaded.
		{
			; Extract the hIcon member from the structure:
			hIcon := NumGet(sfi, 0)
			; Add the HICON directly to the small-icon and large-icon lists.
			; Below uses +1 to convert the returned index from zero-based to one-based:
			IconNumber := DllCall("ImageList_ReplaceIcon", "ptr", ImageListID1, "int", -1, "ptr", hIcon) + 1
			DllCall("ImageList_ReplaceIcon", "ptr", ImageListID2, "int", -1, "ptr", hIcon)
			; Now that it's been copied into the ImageLists, the original should be destroyed:
			DllCall("DestroyIcon", "ptr", hIcon)
			; Cache the icon to save memory and improve loading performance:
			IconArray%ExtID% := IconNumber
		}
	}
	return IconNumber
}

;	====================================================================


get_suggestions_wikipedia(ibc_input,ibc_max_completions_from_one_source = 5)
{

		ibc_matches =
		ibc_completion_file := A_Temp . "\ibc_completions1"
  
		  ; fixme: encode query
		  URLDownloadToFile http://en.wikipedia.org/w/api.php?action=opensearch&search=%ibc_input%, %ibc_completion_file%

		  if (ErrorLevel == 0)
		  {
			fileread ibc_completions, %ibc_completion_file%
			
			; thanks to SKAN for this simple approach of parsing the results
			ibc_completions := Deref_Umlauts(RegExReplace(ibc_completions, "\[|\]"))
			ibc_completions_num = 0
			Loop, Parse, ibc_completions, CSV 
			{
			  if (A_Index == 1)
				ibc_user_input := A_Loopfield
			  else
			  {
				ibc_matches := ibc_matches . "`n" . A_Loopfield
				ibc_completions_num +=1
				if (ibc_completions_num == ibc_max_completions_from_one_source)
				  break
			  }
			}
			
			; if only an emtpy entry is returned then there are no matches
			if (ibc_matches == "`n")
			  ibc_matches := ""
			}
  Return ibc_matches
}

;	=========================================
get_suggestions_google(ibc_input,ibc_max_completions_from_one_source = 5)
{
		ibc_matches =
		ibc_completion_file := A_Temp . "\ibc_completions2"

		  ; fixme: encode query
		  URLDownloadToFile http://google.com/complete/search?output=toolbar&q=%ibc_input%, %ibc_completion_file%

		  if (ErrorLevel == 0)
		  {
			fileread ibc_completions, %ibc_completion_file%

			ibc_completions_num = 0
			pos = 0
			while (pos := RegExMatch(ibc_completions, "<suggestion data=""(.+?)""/>", match, pos + 1))
			{

			  ibc_matches := ibc_matches . "`n" . match1
			  ibc_completions_num +=1
			  if (ibc_completions_num == ibc_max_completions_from_one_source)
				break
			}
		  }

  
  Return ibc_matches
}
  

; code by SKAN  simple approach of parsing the results 
Deref_Umlauts( w, n=1 )
{ 
  stringreplace, w, w, \u0171, % chr("0xfc")
  stringreplace, w, w, \u0151, % chr("0xf6")
  While n := instr( w, "\u",1,n ) 
    StringReplace, w, w, % ww := substr( w,n,6 ), % chr( "0x" substr( ww,3 ) ), all 
  Return w 
}

;	====================================================================

get_first_non_empty_line(text)
{
	text := RegExReplace(text, "^\s+|\s+$","")		;last and first whites
	loop,parse,text,`n,`r
	{	
		if ( a_loopfield !="" )
			{
				line:=a_loopfield
				break
			}
	}
return line
}


getSelectedFile() {   ; GetSelectedText or FilePath in Windows Explorer  by Learning one 

	IsClipEmpty := (Clipboard = "") ? 1 : 0

	if !IsClipEmpty {

		ClipboardBackup := ClipboardAll

		While !(Clipboard = "") {

			Clipboard =

			Sleep, 10

		}

	}

	Send, ^c

	ClipWait, 0.1

	ToReturn := Clipboard, Clipboard := ClipboardBackup

	if !IsClipEmpty

	ClipWait, 0.5, 1

	Return ToReturn

}
GetFolder()
{
	WinGetClass,var,A
	If var in CabinetWClass,ExplorerWClass,Progman
	{
		IfEqual,var,Progman
			v := A_Desktop
		else
		{
			winGetText,Fullpath,A
			loop,parse,Fullpath,`r`n
			{
				IfInString,A_LoopField,:\
				{
					StringGetPos,pos,A_Loopfield,:\,L
					Stringtrimleft,v,A_loopfield,(pos - 1)
					break
				}
			}
		}
	return v
	}
}

get_parent_filepath()
{

	selText=
	if (WinActive("ahk_class ExploreWClass") or WinActive("ahk_class CabinetWClass"))
	{
		selText:=GetFolder()	
	}
	else if (WinActive("ahk_class dopus.lister"))
	{
		tooltip,opus
		return
	}
	else if (WinActive("ahk_class ThunderRT6FormDC"))
	{
		clip:=clipboard
			Send ^+!p
		sleep,50
		selText:=clipboard
		sleep,50
		clipboard:=clip			return
		; msgbox,%selText%
	}
return selText
}

get_selected_filepath()	; if selected_file=0 find path of parent
{

	selText=
	if (WinActive("ahk_class ExploreWClass") or WinActive("ahk_class CabinetWClass"))
	{
	
		selText:=getSelectedFile()
	
	/*
		clip:=clipboard
		if (selected_file)
			Send !d^c
		else
			Send !d^c
		sleep,50
		selText:=clipboard
		sleep,50
		clipboard:=clip
*/		
	}
	else if (WinActive("ahk_class dopus.lister"))
	{
		tooltip,opus
		return
	}
	else if (WinActive("ahk_class ThunderRT6FormDC"))
	{
		clip:=clipboard
		if (selected_file)
			Send ^p
		else
			Send ^p
		sleep,50
		selText:=clipboard
		sleep,50
		clipboard:=clip			return
		; msgbox,%selText%
	}
return selText
}


suspend_if_VMwareHorizonClient()
{
	settimer, SuspendHandler, 1500
		; msgbox, suspend handler
	return

	SuspendHandler:
		; tooltip, suspend check
		if ( winactive("ahk_class VMware Horizon Client App Window") OR (  WinActive("ahk_class #32770") AND WinActive("NetApp NB Windows 7 VED C02P02") ) ) 
		{
			If ( !A_IsSuspended )
			{
				; tooltip,suspended
				; sleep,1000
				suspend,on
				; msgbox
			}
		}
		else If ( A_IsSuspended )
			suspend,off
	return

}

Base64enc( ByRef OutData, ByRef InData, InDataLen ) {
 DllCall( "Crypt32.dll\CryptBinaryToString" ( A_IsUnicode ? "W" : "A" )
        , UInt,&InData, UInt,InDataLen, UInt,1, UInt,0, UIntP,TChars, "CDECL Int" )
 VarSetCapacity( OutData, Req := TChars * ( A_IsUnicode ? 2 : 1 ) )
 DllCall( "Crypt32.dll\CryptBinaryToString" ( A_IsUnicode ? "W" : "A" )
        , UInt,&InData, UInt,InDataLen, UInt,1, Str,OutData, UIntP,Req, "CDECL Int" )
Return TChars
}

Base64dec( ByRef OutData, ByRef InData ) {
	DllCall( "Crypt32.dll\CryptStringToBinary" ( A_IsUnicode ? "W" : "A" ), UInt,&InData
	, UInt,StrLen(InData), UInt,1, UInt,0, UIntP,Bytes, Int,0, Int,0, "CDECL Int" )
	VarSetCapacity( OutData, Req := Bytes * ( A_IsUnicode ? 2 : 1 ) )
	DllCall( "Crypt32.dll\CryptStringToBinary" ( A_IsUnicode ? "W" : "A" ), UInt,&InData
	, UInt,StrLen(InData), UInt,1, Str,OutData, UIntP,Req, Int,0, Int,0, "CDECL Int" )
Return Bytes
}
; for base64dec
VarZ_Save( ByRef Data, DataSize, TrgFile ) { ; By SKAN
	; [color=#008040]; http://www.autohotkey.com/community/viewtopic.php?t=45559[/color]
	hFile :=  DllCall( "_lcreat", ( A_IsUnicode ? "AStr" : "Str" ),TrgFile, UInt,0 )
	IfLess, hFile, 1, Return "", ErrorLevel := 1
	nBytes := DllCall( "_lwrite", UInt,hFile, UInt,&Data, UInt,DataSize, UInt )
	DllCall( "_lclose", UInt,hFile )
	Return nBytes
}


logger(owner_filename,message)
{
; takes no commma and "
	global Log_folder
	FormatTime, TimeString
	splitpath,owner_filename,filename
	log_file =%Log_folder%\%filename%.log
	fileappend,"%TimeString%"`,"%message%"`n,%log_file%
	; msgbox,%log_file%
}

; if specified fileexist, get the next non existing file to avoid overwriting
get_next_filename(target_file,max_check=2,format=1)
{
; format 1: filename_copy_(1).ext
; format 2: copy_of_filename.ext
	splitpath,target_file,source_Filename,sourcepath, OutExtension, OutNameNoExt
	n :=1
	ifexist,%target_file%
	{
		target_Filename = %OutNameNoExt%_copy_(%n%).%OutExtension%
		target_file := sourcepath . "\" . target_Filename
	}		
	while(true)
	{		
		ifexist,%target_file%
		{
			if (n>max_check)
			{
				return 0
			}
			else
				n++
			; splitpath,target_file,target_Filename
			; splitpath,target_file, target_Filename, , OutExtension, OutNameNoExt
			target_Filename = %OutNameNoExt%_copy_(%n%).%OutExtension%
			target_file := sourcepath . "\" . target_Filename
		}
		else
			break
	}
	return target_file
}

; for communication between scripts
Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle)  ; ByRef saves a little memory in this case.
; This function sends the specified string to the specified window and returns the reply.
; The reply is 1 if the target window processed the message, or 0 if it ignored it.
{
    VarSetCapacity(CopyDataStruct, 3*A_PtrSize, 0)  ; Set up the structure's memory area.
    ; First set the structure's cbData member to the size of the string, including its zero terminator:
    SizeInBytes := (StrLen(StringToSend) + 1) * (A_IsUnicode ? 2 : 1)
    NumPut(SizeInBytes, CopyDataStruct, A_PtrSize)  ; OS requires that this be done.
    NumPut(&StringToSend, CopyDataStruct, 2*A_PtrSize)  ; Set lpData to point to the string itself.
    Prev_DetectHiddenWindows := A_DetectHiddenWindows
    Prev_TitleMatchMode := A_TitleMatchMode
    DetectHiddenWindows On
    SetTitleMatchMode 2
    SendMessage, 0x4a, 0, &CopyDataStruct,, %TargetScriptTitle%  ; 0x4a is WM_COPYDATA. Must use Send not Post.
    DetectHiddenWindows %Prev_DetectHiddenWindows%  ; Restore original setting for the caller.
    SetTitleMatchMode %Prev_TitleMatchMode%         ; Same.
    return ErrorLevel  ; Return SendMessage's reply back to our caller.
}

all_start_menus_folder_contents()
{
	all_files = 
	loop,Files,%A_StartMenuCommon%\*.lnk,R
		all_files .= A_LoopFileFullPath . "`n"
	return all_files
}

HK_cycle_next(ByRef HK_cycle_id,ByRef HK_cycle_id_count,HK_cycle_tot_steps,disp_messages,actions_label,extra_params,ByRef HK_cycle_id_action, idle_stop_after=10000)
{
	; limitations: No simultaneous HK cycle threads because of Byref
	global func_ref, func_ref_abort
	this_hotkey := a_thishotkey
	if !(HK_cycle_id)
	{
		HK_cycle_id:=1
		HK_cycle_id_count:=1
		; hotkey,^q,on
	}
	else
		HK_cycle_id_count++
	if (HK_cycle_id)	
	{
		if (HK_cycle_id_count<= HK_cycle_tot_steps)
		{			
			msg := disp_messages%HK_cycle_id_count%
		}	
		else
		{
			HK_cycle_id_count:=0
			msg = cancel
		}
		HK_cycle_id_action :=actions_label%HK_cycle_id_count%
		tooltip,%HK_cycle_id_count% %msg%
		settimer,removetooltip,-%idle_stop_after%
	}
	if (idle_stop_after)
	{
		func_ref_abort := Func("HK_cycle_abort").bind(HK_cycle_id)
		SetTimer, %func_ref_abort%, -%idle_stop_after%
	}
return
}

HK_cycle_timer_sleep_stop()
{

}
HK_cycle_abort( ByRef HK_cycle_id)
{
	; msgbox,%func_ref% %func_ref_abort%
	global
	tooltip,cancelled,400,,4
	sleep,500
	setTimer,%func_ref%,off
	setTimer,%func_ref_abort%,off
	HK_cycle_id:=0
	; hotkey,^q,off
	; tooltip,,,,2
	tooltip,cancelled,400,,4
}

HK_cycle_timer(func_ref,release_checking_key)
{
	global HK_cycle_id_action, HK_cycle_id, HK_cycle_id_count, func_ref_abort
	; action_required :=0
	tooltip,timer,400,,3
	GetKeyState,state,%release_checking_key%
	If state=u
	{
		HK_cycle_abort(HK_cycle_id)
		; action_required := 1
		HK_cycle_release_execute()
	}
	tooltip,timer,400,,3
}
HK_cycle_initialise()
{
	global
	parameter_containers=disp_messages,actions_label,extra_params
	loop,parse,parameter_containers,CSV
		; stringsplit,%a_loopfield%,%a_loopfield%,CSV
	{
		root := a_loopfield
		loop,parse,%a_loopfield%,CSV
			%root%%a_index% := a_loopfield			
	}
	%HK_cycle_id%_count:=0
	func_ref := Func("HK_cycle_timer").bind(func_ref,release_checking_key)
	SetTimer, %func_ref%, 100
}

HK_cycle_release_execute()
{
	global
	if (HK_cycle_id_count)
	{
		label_name = %HK_cycle_id%_release_Pre_action
		if isLabel(label_name)	; pre action is optional
			gosub, %HK_cycle_id%_release_Pre_action
		gosub, %HK_cycle_id_action%
	}
}