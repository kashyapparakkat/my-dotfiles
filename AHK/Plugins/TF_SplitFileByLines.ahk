#SingleInstance Force
;#include C:\cbn_gits\AHK\LIB\tf.ahk
file= %1%  ;passed args
fileread,contents,%file%
TF_SplitFileByLines(contents, "10", "sfile_", "txt", "1") ; split file every 3 lines
;msgbox, %1%%a%






;TF_SplitFileByLines
;example:
;TF_SplitFileByLines("TestFile.txt", "4", "sfile_", "txt", "1") ; split file every 3 lines
; InFile = 0 skip line e.g. do not include the actual line in any of the output files
; InFile = 1 include line IN current file
; InFile = 2 include line IN next file

TF_SplitFileByLines(Text, SplitAt, Prefix = "file", Extension = "txt", InFile = 1)
	{
	 LineCounter=1
	 FileCounter=1
	 Where:=SplitAt
	 Method=1 
	 ; 1 = default, splitat every X lines, 
	 ; 2 = splitat: - rotating if applicable 
	 ; 3 = splitat: specific lines comma separated
	; TF_GetData(OW, Text, FileName)
	 
	 IfInString, SplitAt, `- ; method 2
		{
		 StringSplit, Split, SplitAt, `-
		 Part=1
		 Where:=Split%Part%
		 Method=2
		} 
	 IfInString, SplitAt, `, ; method 3
		{
		 StringSplit, Split, SplitAt, `,
		 Part=1
		 Where:=Split%Part%
		 Method=3
		} 
	 Loop, Parse, Text, `n, `r
		{
			OutPut .= A_LoopField "`n"
			 If (LineCounter = Where)
			{
				 
				 If (InFile = 1)
				{
					 StringReplace, CheckOutput, Output, `n, , All
					 StringReplace, CheckOutput, CheckOutput, `r, , All
					 If (CheckOutput <> "") and (OW <> 2) ; skip empty files
							msgbox,%output%	; TF_ReturnOutPut(1, Output, Prefix FileCounter "." Extension, 0, 1) 
					 If (CheckOutput <> "") and (OW = 2) ; skip empty files
						msgbox,%output%	 ; TF_SetGlobal(Prefix FileCounter,Output)
					 Output:=
				}
					
				If (Method <> 3)			
					LineCounter=0 ; reset
				 FileCounter++ ; next file
				 Part++
				 If (Method = 2) ; 2 = splitat: - rotating if applicable 
				{
						 If (Part > Split0)
							{
							 Part=1
							}
						 Where:=Split%Part%
				}
				 If (Method = 3) ; 3 = splitat: specific lines comma separated
				{
						 If (Part > Split0)
							Where:=Split%Split0%
						 Else
							Where:=Split%Part%
				}
		}
			 LineCounter++
			 PreviousOutput:=Output
			 PreviousLine:=A_LoopField
		}
	 StringReplace, CheckOutput, Output, `n, , All
	 StringReplace, CheckOutput, CheckOutput, `r, , All
	 If (CheckOutPut <> "") and (OW <> 2) ; skip empty files
       ;	 TF_ReturnOutPut(1, Output, Prefix FileCounter "." Extension, 0, 1) 
	 If (CheckOutput <> "") and (OW = 2) ; skip empty files
		{
		 ; TF_SetGlobal(Prefix FileCounter,Output)
		 ; TF_SetGlobal(Prefix . "0" , FileCounter)
		} 
	}

	






/*
loop,parse,files,`n,`r 
{
	splitpath,a_loopfield,name,path,OutExtension
	fileread,MyText,%a_loopfield%
	sleep,200
	if(StrLen(MyText)>60)
	{
	StringLeft, MyText, MyText,50
	}
	stringreplace,MyText,MyText,`r`n,%a_space%, all
	stringreplace,MyText,MyText, %A_TAB%,%a_space%, all
	stringreplace,MyText,MyText,:,%a_space%, all
	MyText:=RegExReplace(MyText,  "\\\*?|/", " ")
	if(StrLen(MyText)>50)
	{
		StringLeft, MyText, MyText,50
	}
	; tooltip,%MyText%
	; sleep,500
	; tooltip,
	filemove,%a_loopfield%,%path%\%MyText%.%OutExtension%
}
*/
Return






