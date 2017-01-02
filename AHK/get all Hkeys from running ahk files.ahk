; Hotkey Help
; Fanatic Guru
; 2013 06 12
; Verison 2.6
;
; Inspired by Jade Dragon's Infile Hotkey Scanner
; PostMessage Information and Script Status derived from Lexikos
;
; Creates a Help Dialog that Shows Current AHK Hotkeys
;
;------------------------------------------------------
;
; Wings around file names mean
; ===== AHK File with Hotkeys or Hotstrings =====
; ----- AHK File with no Hotkeys or Hotstrings -----
; +++++ AHK or Text File Derived from EXE File Name with Hotkeys or Hotstrings +++++
; +-+-+ AHK or Text File Derived from EXE File Name with no Hotkeys or Hotstrings +-+-+
; ?+?+? EXE File for which no AHK or Text File was Found ?+?+?
;
; May create a txt file with same name as hotkey file to be searched for help information
;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; Ensures that only the last executed instance of script is running
; #NoTrayIcon

; File Names with Out Ext Seperated by |
; Files_Excluded 	:= "Test|Debugging"
Files_Excluded 	:= " "

; Long or Short Hotkey and Hotstring Names (Modifier Order Matters)
; Hot_Excluded 	:= "Win+Ctrl+Alt+Escape|If|IfWinActive|#a|fyi|brb"
Hot_Excluded 	:= " "

; Text File Extension for Text Help Files (Can be changed to something more unique than txt if needed)
Text_Ext := "txt"

; Spacing for Position of Information Column in Help Dialog
Pos_Info = 25

; Parse Delimiter and OmitChar.  Sometimes changing these can give better results.
Parse_Delimiter := "`n"
Parse_OmitChar := "`r" 

; Default Settings if Not Changed by Ini File
Set_ShowBlank	= 1
Set_ShowExe		= 1
Set_ShowHotkey	= 1		; Hotkeys created with the Hotkey Command Tend to be Unusal
Set_VarHotkey	= 1		; Attempt to Resolve a Variable Used in Hotkeys Definition
Set_FlagHotkey	= 1		; Flag Hotkeys created with the Hotkey Command with <HK>
Set_ShowString	= 1
Set_AhkExe		= 1
Set_AhkTxt		= 1
Set_AhkTxtOver	= 1
Set_SortInfo	= 1
Set_IniSet		= 1		; Set to 0 to Use Defaults Settings and Not Use INI File
Set_IniExcluded	= 1		; Set to 0 to Use Default Excluded Information and Not Use INI File

; Get Settings From Ini File
if Set_IniSet
	if FileExist("Hotkey Help.ini")
	{
		IniRead, Set_ShowBlank, Hotkey Help.ini, Settings, Set_ShowBlank, %Set_ShowBlank%
		IniRead, Set_ShowExe, Hotkey Help.ini, Settings, Set_ShowExe, %Set_ShowExe%
		IniRead, Set_ShowHotkey, Hotkey Help.ini, Settings, Set_ShowHotkey, %Set_ShowHotkey%
		IniRead, Set_VarHotkey, Hotkey Help.ini, Settings, Set_ShowHotkey, %Set_VarHotkey%
		IniRead, Set_FlagHotkey, Hotkey Help.ini, Settings, Set_ShowHotkey, %Set_FlagHotkey%
		IniRead, Set_ShowString, Hotkey Help.ini, Settings, Set_ShowString, %Set_ShowString%
		IniRead, Set_AhkExe, Hotkey Help.ini, Settings, Set_AhkExe, %Set_AhkExe%
		IniRead, Set_AhkTxt, Hotkey Help.ini, Settings, Set_AhkTxt, %Set_AhkTxt%
		IniRead, Set_AhkTxtOver, Hotkey Help.ini, Settings, Set_AhkTxtOver, %Set_AhkTxtOver%
		IniRead, Set_SortInfo, Hotkey Help.ini, Settings, Set_SortInfo, %Set_SortInfo%
		IniRead, Set_IniSet, Hotkey Help.ini, Settings, Set_IniSet, %Set_IniSet%
		IniRead, Set_IniExcluded, Hotkey Help.ini, Settings, Set_IniExcluded, %Set_IniExcluded%
	}

; Get Excluded Information From Ini File
if Set_IniExcluded
	if FileExist("Hotkey Help.ini")
	{
		IniRead, Files_Excluded, Hotkey Help.ini, Excluded, Files_Excluded, %Files_Excluded%
		IniRead, Hot_Excluded, Hotkey Help.ini, Excluded, Hot_Excluded, %Hot_Excluded%
	}

; Create Setting Gui
Gui, Set:Font, s10
Gui, Set:Add, Text, x120 y10 w200 h20 , Hotkey Help - Pick Settings
Gui, Set:Add, Text, x30 y40 w390 h2 0x7
Gui, Set:Add, CheckBox, x60 y50 w380 h30 vSet_ShowBlank, Show Files With No Hotkeys
Gui, Set:Add, CheckBox, x60 y90 w380 h30 vSet_ShowExe, Show EXE Files (Help Comments Do Not Exist in EXE)
Gui, Set:Add, CheckBox, x60 y130 w380 h30 vSet_AhkExe, Scan AHK File with Same Name as Running EXE
Gui, Set:Add, CheckBox, x60 y170 w380 h30 vSet_AhkTxt, Scan Text File with Same Name as Running Script
Gui, Set:Add, CheckBox, x60 y210 w380 h30 vSet_AhkTxtOver, Text File Help will Overwrite Duplicate Help
Gui, Set:Add, CheckBox, x60 y250 w380 h30 vSet_ShowHotkey, Show Created with Hotkey Command
Gui, Set:Add, CheckBox, x60 y290 w380 h30 vSet_VarHotkey, Attempt to Resolve Variables in Dynamic Hotkeys
Gui, Set:Add, CheckBox, x60 y330 w380 h30 vSet_FlagHotkey, Flag Hotkeys created with the Hotkey Command with <HK>
Gui, Set:Add, CheckBox, x60 y370 w380 h30 vSet_SortInfo, Sort by Hotkey Description (Otherwise by Hotkey Name)
Gui, Set:Add, CheckBox, x60 y410 w380 h30 vSet_ShowString, Show Hotstrings
Gui, Set:Add, CheckBox, x60 y450 w380 h30 vSet_IniSet, Use INI File to Save Settings
Gui, Set:Add, CheckBox, x60 y490 w380 h30 vSet_IniExcluded, Use INI File to Save Excluded Files and Hotkeys
Gui, Set:Add, Button, Default x60 y550 w330 h30, Finished
GuiControl, Set:, Set_ShowBlank, %Set_ShowBlank%
GuiControl, Set:, Set_ShowExe, %Set_ShowExe%
GuiControl, Set:, Set_ShowHotkey, %Set_ShowHotkey%
GuiControl, Set:, Set_VarHotkey, %Set_VarHotkey%
GuiControl, Set:, Set_FlagHotkey, %Set_FlagHotkey%
GuiControl, Set:, Set_ShowString, %Set_ShowString%
GuiControl, Set:, Set_AhkExe, %Set_AhkExe%
GuiControl, Set:, Set_AhkTxt, %Set_AhkTxt%
GuiControl, Set:, Set_AhkTxtOver, %Set_AhkTxtOver%
GuiControl, Set:, Set_SortInfo, %Set_SortInfo%
GuiControl, Set:, Set_IniSet, %Set_IniSet%
GuiControl, Set:, Set_IniExcluded, %Set_IniExcluded%

; Get Information to Display in Excluded Gui
Gui_Excluded := String_Wings(" EXCLUDED SCRIPTS AND FILES ",40) "`n" Files_Excluded "`n`n`n" String_Wings(" EXCLUDED HOTKEYS & HOTSTRINGS ",40) "`n" Hot_Excluded
StringReplace, Gui_Excluded, Gui_Excluded, |, `n, All

; Create Excluded Gui
Gui, Excluded:+MinSize400x600 +Resize
Gui, Excluded:Color, FFFFFF
Gui, Excluded:Font, s10, Courier New
Gui, Excluded:Add, Text, x10, Enter Information Below the Appropriate Headings
Gui, Excluded:Add, Text, x60, Do Not Modify Heading Lines
Gui, Excluded:Add, Button, Default x20 y60 w350 h30, Confirm Edit
Gui, Excluded:Add, Edit, x20 y100 vGui_Excluded -E0x200, %Gui_Excluded%




tooltip,#f1 to open all hot keys
sleep,1000

#f1::	; <-- Show Hotkey Help
	Refresh:
	global Scripts := {}
	Help := {}		; Main Array for Storing Information
	Include_Scripts := {}
	Setting_AutoTrim := A_AutoTrim
	AutoTrim, On
	Setting_WorkingDir := A_WorkingDir
	Scripts_List := AHK_Paths("Scripts")	; Get Path of all AHK Scripts
	Recursive:
	Found_Include := false
	for index, element in Scripts.Path	; Loop Through All AHK Script Files
	{
		Txt_Ahk := false
		SetWorkingDir, %Setting_WorkingDir%
		File_Path := element
		SplitPath, File_Path, File_Name, File_Dir, File_Ext, File_Title
		Help[File_Title,"ID"] := Scripts["ID",A_Index]
		if RegExMatch(Files_Excluded,"i)(^|\|)" File_Title "($|\|)")
			continue
		Help[File_Title,"Type"] := "AHK"
		Exe_Ahk := false
		if (File_Ext = "exe")
		{
			Help[File_Title,"Type"] := "EXE_UNKNOWN"
			if Set_AhkExe
			{
				if FileExist(File_Dir "\" File_Title ".ahk")
				{
					Exe_Ahk := true
					Help[File_Title,"Type"] := "EXE2AHK"
					File_Path := File_Dir "\" File_Title ".ahk"
				}
				else if FileExist(A_ScriptDir "\" File_Title ".ahk")
				{
					Help[File_Title,"Type"] := "EXE2AHK"
					Exe_Ahk := true
					File_Path := A_ScriptDir "\" File_Title ".ahk"
				}
				else if FileExist(A_WorkingDir "\" File_Title ".ahk")
				{
					Help[File_Title,"Type"] := "EXE2AHK"
					Exe_Ahk := true
					File_Path := A_WorkingDir "\" File_Title ".ahk"
				}
			}
		}
		Txt_Ahk := false
		if Set_AhkTxt
		{
			if FileExist(File_Dir "\" File_Title "." Text_Ext)
			{
				Txt_Ahk := true
				File_Path_Txt := File_Dir "\" File_Title "." Text_Ext
			}
			else if FileExist(A_ScriptDir "\" File_Title "." Text_Ext)
			{
				Txt_Ahk := true
				File_Path_Txt := A_ScriptDir "\" File_Title "." Text_Ext
			}
			else if FileExist(A_WorkingDir "\" File_Title "." Text_Ext)
			{
				Txt_Ahk := true
				File_Path_Txt := A_WorkingDir "\" File_Title "." Text_Ext
			}
		}
		If (Help[File_Title,"Type"] = "EXE_UNKNOWN" and Txt_Ahk)
			Help[File_Title,"Type"] := "EXE2TEXT"
		if (!Txt_Ahk and !Exe_Ahk and !(File_Ext = "ahk"))	; No File Found to Scan
			continue
		if !RegExMatch(Files_Excluded,"i)(^|\|)" File_Title ".ahk($|\|)")
			FileRead, Script_File, %File_Path%	;  Read AHK Script File into String
		else
			Script_File := ""
		if Txt_Ahk
		{
			FileRead, Script_File_Txt, %File_Path_Txt%	;  Read Text File with Same Name as AHK Script File into String
			Script_File .= Parse_Delimiter "§ Hotkey Help Text File §" Parse_Delimiter Script_File_Txt	;  Append Txt File onto AHK File
		}
		if !Script_File
			continue
		Script_File := RegExReplace(Script_File, "ms`a)^\s*/\*.*?^\s*\*/\s*|^\s*\(.*?^\s*\)\s*")	; Removes /* ... */ and ( ... ) Blocks
		Txt_Ahk_Started := false
		Loop, Parse, Script_File, %Parse_Delimiter%, %Parse_OmitChar%	; Parse Each Line of Script File
		{
			File_Line := A_LoopField
			if (File_Line = "§ Hotkey Help Text File §")
			{
				Txt_Ahk_Started := true
				continue
			}
			; RegEx to Identify Hotkey Command Lines
			if (RegExMatch(File_Line, "i)^\s*hotkey,(.*?),(.*)", Match) and Set_ShowHotkey)	; Check if Line Contains Hotkey Command
			{
				if Set_VarHotkey
					if RegExMatch(Match1,"%.*%")
						Match1 := HotkeyVariable(element,Match1)
				File_Line := Match1 ":: " Match2
				Hotkey_Command := true
			}
			else
				Hotkey_Command := false
			if RegExMatch(File_Line,"::")	; Simple check for Possible Hotkey or Hotstring (for speed)
			{
				if RegExMatch(File_Line,"^\s*:[0-9\*\?BbCcKkOoPpRrSsIiEeZz]*?:(.*?)::(.*)",Match)				; Complex Check if Line Contains Hotstring
				{
					if (Set_ShowString and !(RegExMatch(Hot_Excluded,"i)(^|\|)\Q" Match1 "\E($|\|)")))	; Check for Excluded Hotstring
						{
							Line_Hot := "<HS>  " Match1
							Line_Help := "= " Match2
							if Txt_Ahk_Started
								Help[File_Title,"Hot_Text",Line_Hot] := Line_Help
							else
								Help[File_Title,"Hot",Line_Hot] := Line_Help
						}
						else
							continue
				}
				else if RegExMatch(File_Line, "Umi)^\s*[\Q#!^+<>*~$\E]*((LButton|RButton|MButton|XButton1|XButton2|WheelDown|WheelUp|WheelLeft|WheelRight|CapsLock|Space|Tab|Enter|Return|Escape|Esc|Backspace|BS|ScrollLock|Delete|Del|Insert|Ins|Home|End|PgUp|PgDn|Up|Down|Left|Right|Numpad0|Numpad1|Numpad2|Numpad3|Numpad4|Numpad5|Numpad6|Numpad7|Numpad8|Numpad9|Numpad0|NumpadDot|NumpadDiv|NumpadMul|NumpadAdd|NumpadSub|NumpadEnter|F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12|F13|F14|F15|F16|F17|F18|F19|F20|F21|F22|F23|F24|LWin|RWin|Control|Ctrl|Alt|Shift|LControl|LCtrl|RControl|RCtrl|LShift|RShift|LAlt|RAlt|Browser_Back|Browser_Forward|Browser_Refresh|Browser_Stop|Broswer_Search|Broswer_Favorites|Broswer_Home|Volume_Mute|Volume_Down|Volume_Up|Media_Next|Media_Prev|Media_Stop|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2|AppsKey|PrintScreen|CtrlBreak|Pause|Break|Help|Sleep|\S)(?<!;)|```;)?(\s*&\s*((LButton|RButton|MButton|XButton1|XButton2|WheelDown|WheelUp|WheelLeft|WheelRight|CapsLock|Space|Tab|Enter|Return|Escape|Esc|Backspace|BS|ScrollLock|Delete|Del|Insert|Ins|Home|End|PgUp|PgDn|Up|Down|Left|Right|Numpad0|Numpad1|Numpad2|Numpad3|Numpad4|Numpad5|Numpad6|Numpad7|Numpad8|Numpad9|Numpad0|NumpadDot|NumpadDiv|NumpadMul|NumpadAdd|NumpadSub|NumpadEnter|F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12|F13|F14|F15|F16|F17|F18|F19|F20|F21|F22|F23|F24|LWin|RWin|Control|Ctrl|Alt|Shift|LControl|LCtrl|RControl|RCtrl|LShift|RShift|LAlt|RAlt|Browser_Back|Browser_Forward|Browser_Refresh|Browser_Stop|Broswer_Search|Broswer_Favorites|Broswer_Home|Volume_Mute|Volume_Down|Volume_Up|Media_Next|Media_Prev|Media_Stop|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2|AppsKey|PrintScreen|CtrlBreak|Pause|Break|Help|Sleep|\S)(?<!;)|```;))?( Up)?::") ; Complex Check if Line Contains Hotkey
				{
					Pos_Hotkey := RegExMatch(File_Line,"(.*?[:]?)::",Match)
					Match1 := Trim(Match1)
					if RegExMatch(Hot_Excluded,"i)(^|\|)\Q" Match1 "\E($|\|)")	; Check for Excluded Short Hotkey Name
						continue
					if !RegExMatch(Match1,"(Shift|Alt|Ctrl|Win)")
					{
						StringReplace, Match1, Match1, +, Shift+
						StringReplace, Match1, Match1, !, Alt+
						StringReplace, Match1, Match1, ^, Ctrl+ 
						StringReplace, Match1, Match1, #, Win+
					}
					StringReplace, Match1, Match1, ```;, `;
					if RegExMatch(Hot_Excluded,"i)(^|\|)\Q" Match1 "\E($|\|)")	; Check for Excluded Long Hotkey Name
						continue
					Line_Hot := Match1
					Pos := RegExMatch(File_Line,"::.*?;(.*)",Match)
					Line_Help := Trim(Match1)
					if Hotkey_Command
						if Set_FlagHotkey
							Line_Hot := "<HK>  " Line_Hot
					if Txt_Ahk_Started
						Help[File_Title,"Hot_Text",Line_Hot] := Line_Help
					else
						Help[File_Title,"Hot",Line_Hot] := Line_Help
				}
			}
			if RegExMatch(File_Line, "mi`a)^\s*#include(?:again)?(?:\s+|\s*,\s*)(?:\*i[ `t]?)?(.+)", Match)	; Check for #Include
			{
				StringReplace, Match1, Match1, `%A_ScriptDir`%, %File_Dir%
				StringReplace, Match1, Match1, `%A_AppData`%, %A_AppData%
				StringReplace, Match1, Match1, `%A_AppDataCommon`%, %A_AppDataCommon%
				StringReplace, Match1, Match1,```;,;, All
				if InStr(FileExist(Match1), "D")
				{
					SetWorkingDir, %Match1%
					continue
				}
				if Match1
				{
					Match1 := Get_Full_Path(Match1)
					Include_Scripts["Path"].Insert(Match1)
					Found_Include := true
				}
			}
				
		}
	}
	; Do Recursive for Found #Include 
	if Found_Include
	{
		Scripts := Include_Scripts
		goto Recursive
	}
	; Get Count of Hot in Each File
	for File, element in Help
	{
		count = 0
		for Hot, Info in Help[File,"Hot"]
			count += 1
		for Hot_Text, Info_Text in Help[File,"Hot_Text"]
			count += 1
		Help[File,"Count"] := count
	}
	; Remove Duplicate Help Created by Text Help if Text File Overwrite Set
	if (Set_AhkTxtOver)
		for File, element in Help
			for Hot_Text, Info_Text in Help[File,"Hot_Text"]
				for Hot, Info in Help[File,"Hot"]
					if (Hot = Hot_Text or Hot = "<HK>  " Hot_Text)
					{
								Removed := Help[File,"Hot"].Remove(Hot)
								Help[File,"Count"] -= 1
					}

	; Build Display String from Help Array
	Display := ""
	for File, element in Help
	{
		if (Help[File,"Count"] > 0 and Help[File,"Type"] = "AHK")
		{
			Display .= "`n" String_Wings(" " File " ") "`n"
			Display_Section := ""
			for Hot, Info in Help[File,"Hot"]
				Display_Section .= Format_Line(Hot,Info,Pos_Info) "`n"
			for Hot_Text, Info_Text in Help[File,"Hot_Text"]
				Display_Section .= Format_Line(Hot_Text,Info_Text,Pos_Info) "`n"
			if Set_SortInfo
				Sort, Display_Section, P%Pos_Info%
			else
				Sort, Display_Section
			Display .= Display_Section
		}
	}
	for File, element in Help
	{
		if (Help[File,"Count"] > 0 and (Help[File,"Type"] = "EXE2AHK" or Help[File,"Type"] = "EXE2TEXT"))
		{
			Display .= "`n" String_Wings(" " File " ",,"+") "`n"
			Display_Section := ""
			for Hot, Info in Help[File,"Hot"]
				Display_Section .= Format_Line(Hot,Info,Pos_Info) "`n"
			for Hot_Text, Info_Text in Help[File,"Hot_Text"]
				Display_Section .= Format_Line(Hot_Text,Info_Text,Pos_Info) "`n"
			if Set_SortInfo
				Sort, Display_Section, P%Pos_Info%
			else
				Sort, Display_Section
			Display .= Display_Section
		}
	}
	if Set_ShowBlank
	{
			for File, element in Help
			{
				if (Help[File,"Count"] = 0 and Help[File,"Type"] = "EXE2AHK" and Set_ShowExe)
					Display .= "`n" String_Wings(" " File " ",,"+-")
			}

			for File, element in Help
			{
				if (Help[File,"Type"] = "EXE_UNKNOWN"  and Set_ShowExe)
					Display .= "`n" String_Wings(" " File " ",,"+?") 
			}

			for File, element in Help
			{
				if (Help[File,"Count"] = 0 and Help[File,"Type"] = "AHK")
					Display .= "`n" String_Wings(" " File " ",,"-") 
			}
	}
	Display := RegExReplace(Display,"^\s*(.*)\s*$", "$1")
	; Create Main Gui first time then only display unless contents change then recreate to get automatic sizing of Edit
	if Gui_Created
	{		
		if !(Display = Previous_Display)
		{
			gosub MenuBuild
			Gui, Destroy
			Gui, +Resize
			Gui, Color, FFFFFF
			Gui, Font, s10, Courier New
			Gui, Menu, MenuMain
			Gui, Add, Edit, vGui_Display ReadOnly -E0x200, %Display%
			Gui, Show, AutoSize, Hotkey Help
			Send ^{Home}
		}
		else
		{
			Gui, Show, AutoSize, Hotkey Help
			Send ^{Home}
		}
	}	
	else
	{
		gosub MenuBuild
		Gui, +Resize
		Gui, Color, FFFFFF
		Gui, Font, s10, Courier New
		Gui, Menu, MenuMain
		Gui, Add, Edit, vGui_Display ReadOnly -E0x200, %Display%
		Gui, Show, AutoSize, Hotkey Help
		Send ^{Home}
		Gui_Created := true
	}
	Previous_Display := Display
	AutoTrim, %Setting_AutoTrim%

return

#!f1::	; <-- Change Hotkey Help Settings
	Gui, Set:Show,, Hotkey Help - Settings
return

#^f1::	; <-- Display Files, Hotkeys, and Hotstrings Excluded
	Gui, Excluded:Show, AutoSize, Hotkey Help - Excluded
	Send ^{Home}
return

#!^f1::	; <-- Raw List of Hotkeys
	Scripts_List := AHK_Paths("Scripts")	; Get Path of all AHK Scripts
	Raw_Hotkeys := {}
	for index, element in Scripts.Path	; Loop Through All AHK Script Files
	{
		File_Path := element
		SplitPath, File_Path, File_Name, File_Dir, File_Ext, File_Title
		Raw_Hotkeys[File_Title] := ScriptHotkeys(element)
	}
	Raw_Display := ""
	for Script, element in Raw_Hotkeys
	{
		Raw_Display .= "`n" String_Wings(" " Script " ",30) "`n"
		for index, Hotkey_Short in Raw_Hotkeys[Script]
		{
			Hotkey_Keys := Hotkey_Short
			StringReplace, Hotkey_Keys, Hotkey_Keys, +, Shift+
			StringReplace, Hotkey_Keys, Hotkey_Keys, !, Alt+
			StringReplace, Hotkey_Keys, Hotkey_Keys, ^, Ctrl+ 
			StringReplace, Hotkey_Keys, Hotkey_Keys, #, Win+
			Raw_Display .= Hotkey_Keys "`n"
		}
	}
	Raw_Display := Trim(Raw_Display," `n")
	if Gui_Raw_Created
	{		
		if !(Raw_Display = Previous_Raw_Display)
		{
			Gui, Raw:Destroy
			Gui, Raw:+Resize
			Gui, Raw:Color, FFFFFF
			Gui, Raw:Font, s10, Courier New
			Gui, Raw:Add, Edit, vGui_Raw_Display ReadOnly -E0x200, %Raw_Display%
			Gui, Raw:Show, AutoSize, Hotkey Help
			Send ^{Home}
		}
		else
		{
			Gui, Raw:Show, AutoSize, Hotkey Help - Raw Hotkeys
			Send ^{Home}
		}
	}	
	else
	{
		Gui, Raw:+Resize
		Gui, Raw:Color, FFFFFF
		Gui, Raw:Font, s10, Courier New
		Gui, Raw:Add, Edit, vGui_Raw_Display ReadOnly -E0x200, %Raw_Display%
		Gui, Raw:Show, AutoSize, Hotkey Help - Raw Hotkeys
		Send ^{Home}
		Gui_Raw_Created := true
	}
	Previous_Raw_Display := Raw_Display 
return

~#^!Escape::ExitApp

HotkeyVariable(Script,Variable)
{
	static
	Var := Trim(Variable," %")
	If !Script_List
		Script_List := {}
	if !Script_List[Script]
	{
		Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
		DetectHiddenWindows, On
		SetTitleMatchMode 2
		WinMove, %Script%,,A_ScreenWidth, A_ScreenHeight
		PostMessage, 0x111, 65407, , , %Script%
		ControlGetText, Text, Edit1, %Script%
		WinHide, %Script%
		Script_List[Script] := Text
	}
	Pos := RegExMatch(Script_List[Script], Var ".*\:(.*)",Match)
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
	if (Pos and Match1)
		return Match1
	else
   		return Variable
}

ScriptHotkeys(Script)
{
	Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
    DetectHiddenWindows, On
    SetTitleMatchMode 2
	WinMove, %Script%,,A_ScreenWidth, A_ScreenHeight
	if (Script = A_ScriptFullPath)
		ListHotkeys
	else
		PostMessage, 0x111, 65408, , , %Script%
	ControlGetText, Text, Edit1, %Script%
	WinHide, %Script%
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
    Result := {}
    Loop, Parse, Text, `n
    {
        Pos := RegExMatch(A_LoopField,"^[(reg|k|m|2|joy)].*\t(.*)$",Match)
        if Pos
            Result.Insert(Match1)
    }
    return Result
}

GuiSize:
	NewWidth := A_GuiWidth - 20
	NewHeight := A_GuiHeight - 20
	GuiControl, Move, Gui_Display, W%NewWidth% H%NewHeight%
return

GuiEscape:
	Gui, Show, Hide
return

ExcludedGuiSize:
	NewWidth := A_GuiWidth - 20
	NewHeight := A_GuiHeight - 20
	GuiControl, Move, Gui_Excluded, W%NewWidth% H%NewHeight%
return

RawGuiSize:
	NewWidth := A_GuiWidth - 20
	NewHeight := A_GuiHeight - 20
	GuiControl, Move, Gui_Raw_Display, W%NewWidth% H%NewHeight%
return

ExcludedButtonConfirmEdit:
	Gui, Excluded:Submit
	Files_Excluded := ""
	Hot_Excluded := ""
	Loop, Parse, Gui_Excluded, `n, `r
	{
		if !A_LoopField
			continue
		if (A_LoopField = String_Wings(" EXCLUDED SCRIPTS AND FILES ",40))
		{
			Next_Section := false
			continue
		}
		if (A_LoopField = String_Wings(" EXCLUDED HOTKEYS & HOTSTRINGS ",40))
			Next_Section := true
		else
			if !Next_Section
				Files_Excluded .= "|" Trim(A_LoopField)
			else
				Hot_Excluded .= "|" Trim(A_LoopField)
	}
	Files_Excluded := SubStr(Files_Excluded, 2)
	Hot_Excluded := SubStr(Hot_Excluded, 2)
	if Set_IniExcluded
	{
		IniWrite, %Files_Excluded%, Hotkey Help.ini, Excluded, Files_Excluded
		IniWrite, %Hot_Excluded%, Hotkey Help.ini, Excluded, Hot_Excluded
	}
return

ExcludedGuiEscape:
	Gui, Excluded:Show, Hide
return

RawGuiEscape:
	Gui, Raw:Show, Hide
return

SetButtonFinished:
SetGuiEscape:
	Gui, Set:Submit
	if Set_IniSet
	{
		IniWrite, %Set_ShowBlank%, Hotkey Help.ini, Settings, Set_ShowBlank
		IniWrite, %Set_ShowExe%, Hotkey Help.ini, Settings, Set_ShowExe
		IniWrite, %Set_ShowHotkey%, Hotkey Help.ini, Settings, Set_ShowHotkey
		IniWrite, %Set_VarHotkey%, Hotkey Help.ini, Settings, Set_VarHotkey
		IniWrite, %Set_FlagHotkey%, Hotkey Help.ini, Settings, Set_FlagHotkey
		IniWrite, %Set_ShowString%, Hotkey Help.ini, Settings, Set_ShowString
		IniWrite, %Set_AhkExe%, Hotkey Help.ini, Settings, Set_AhkExe
		IniWrite, %Set_AhkTxt%, Hotkey Help.ini, Settings, Set_AhkTxt
		IniWrite, %Set_AhkTxtOver%, Hotkey Help.ini, Settings, Set_AhkTxtOver
		IniWrite, %Set_SortInfo%, Hotkey Help.ini, Settings, Set_SortInfo
		IniWrite, %Set_IniSet%, Hotkey Help.ini, Settings, Set_IniSet
		IniWrite, %Set_IniExcluded%, Hotkey Help.ini, Settings, Set_IniExcluded
	}
return

ScriptStop:
	Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
    DetectHiddenWindows, On
	WinID := Help[A_ThisMenuItem,"ID"]
	WinKill, ahk_id %WinID%
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
	Menu, MenuStop, Delete, %A_ThisMenuItem%
	Menu, MenuPause, Delete, %A_ThisMenuItem%
	Menu, MenuSuspend, Delete, %A_ThisMenuItem%
	goto Refresh
return
ScriptPause:
	Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
    DetectHiddenWindows, On
	WinID := Help[A_ThisMenuItem,"ID"]
	PostMessage, 0x111, 65403,,, ahk_id %WinID%
	sleep 100
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
	gosub MenuBuild
return
ScriptSuspend:
	Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
    DetectHiddenWindows, On
	WinID := Help[A_ThisMenuItem,"ID"]
	PostMessage, 0x111, 65404,,, ahk_id %WinID%
	sleep 100
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
	gosub MenuBuild
return

MenuBuild:
	Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
	DetectHiddenWindows, On
	Menu, MenuMain, UseErrorLevel	
	Menu, MenuMain, Delete
	for File, element in Help
	{
		script_id := Help[File,"ID"]
		; Force the script to update its Pause/Suspend checkmarks.
		SendMessage, 0x211,,,, ahk_id %script_id%  ; WM_ENTERMENULOOP
		SendMessage, 0x212,,,, ahk_id %script_id%  ; WM_EXITMENULOOP

		; Get script status from its main menu.
		mainMenu := DllCall("GetMenu", "uint", script_id)
		fileMenu := DllCall("GetSubMenu", "uint", mainMenu, "int", 0)
		isPaused := DllCall("GetMenuState", "uint", fileMenu, "uint", 4, "uint", 0x400) >> 3 & 1
		isSuspended := DllCall("GetMenuState", "uint", fileMenu, "uint", 5, "uint", 0x400) >> 3 & 1
		DllCall("CloseHandle", "uint", fileMenu)
		DllCall("CloseHandle", "uint", mainMenu)
		
		Menu, MenuStop, Add, %File%, ScriptStop
		Menu, MenuPause, Add, %File%, ScriptPause
		if isPaused
			Menu, MenuPause, Check, %File%
		else
			Menu, MenuPause, UnCheck, %File%
		Menu, MenuSuspend, Add, %File%, ScriptSuspend
		if isSuspended
			Menu, MenuSuspend, Check, %File%
		else
			Menu, MenuSuspend, UnCheck, %File%
	}
	Menu, MenuMain, Add, Stop Script, :MenuStop
	Menu, MenuMain, Add, Pause Script, :MenuPause
	Menu, MenuMain, Add, Suspend Script, :MenuSuspend
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
return

Get_Full_Path(path) 
{
	Loop, %path%, 1
		return A_LoopFileLongPath
    return path
}

String_Wings(String,Length:=75,Char:="=",Case:="U")
{
	if (Case = "U")
		StringUpper, String, String
	else if (Case = "T")
		StringUpper, String, String, T
	else if (Case = "L")
		StringLower, String, String
	WingX1 := Round(((Length-StrLen(String))/2)/StrLen(Char))
	WingX2 := Round((Length-StrLen(String)-(WingX1*StrLen(Char)))/StrLen(Char))
	loop %WingX1%
		Wing_1 .= Char
	loop %WingX2%
		Wing_2 .= Char
	return SubStr(Wing_1 String Wing_2,1,Length)
}

Format_Line(Hot,Info,Pos_Info)
{
	Spaces := ""
	Length := Pos_Info - StrLen(Hot) - 1
	Loop %Length%
		Spaces .= " "
	return Hot Spaces Info
}

; Function - AHK Paths
; Fanatic Guru
; 2013 06 07
;
; Function that will find the path and file name of all AHK scripts running.
; Will also find ID of each script.
;
; This information will be returned as a string with a single file on each line.
; And as an array with the name passed to the function.  The array name must be
; declared as a global variable before calling the function.
; 
;  Array Format to Retrieve Information
;
; {Array}.Path
; {Array}.ID
;
;---------------------------------------------------------------------------------
;
; Example Code:
/*
	global AHK_List 
	MsgBox % AHK_Paths("AHK_List")
	for index, element in AHK_List.Path
		MsgBox % index " - " element
	return
*/

AHK_Paths(Array)
{
	Setting_A_DetectHiddenWindows := A_DetectHiddenWindows
	DetectHiddenWindows, On
	WinGet, AHK_Windows, List, ahk_class AutoHotkey
	%Array% := {}
	list := ""
	Loop %AHK_Windows%
	{
		hWin := AHK_Windows%A_Index%
		WinGetTitle, Win_Name, ahk_id %hWin%
		%array%["Path",A_Index] := RegExReplace(Win_Name, "(^.*\....) - AutoHotkey .*$", "$1")
        %array%["ID",A_Index] := hWin
		list .= Trim(%array%["Path",A_Index]) "`n"
		
	}
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
	return list
}