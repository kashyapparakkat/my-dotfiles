#SingleInstance Force
#include C:\cbn_gits\AHK\LIB\misc functions.ahk
#include C:\cbn_gits\AHK\LIB\cbn.ahk
#include C:\cbn_gits\AHK\LIB\contextmenu.ahk
#include C:\cbn_gits\AHK\LIB\HK_Cycle dev2.ahk

	menu, Tray, Icon, Shell32.dll, 46
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
source_text=
(
"a","bd","c",sgs
"aa","bbbb","cccc",sgs sgs sgs
)
asd=
(
result:=sum(a,b,c,d,e,f)
result:=sum(a,b,c,d,e,f)
a:=b
a:=b
a=b&c=d
sum(a,b,c,d)
username=hi&password=pass&rememberme=1
hello:=welcome
a,b,c,d,e
a==b&c==d
a=b
C:\cbn_gits\AHK\LIB\misc functions.ahk
)


; HKC_Key_register("F3","smart_extract",config,"same_category")
; HKC_Key_register("F1","smart_extract","","category_changer")


HKC_action_after_off=exit_smart_extract
HKC_func_before_first_trigger=source_text:=Get_Selected_Text()
HKC_Group_register("F3", "smart_extract",3000,"", "$esc")
config =
(
try next delim F3;F1;,try next delim2,try next delim,try next delim
next_smart_match,next_smart_match,next_smart_match,next_smart_match
)
HKC_Key_register("F3","smart_extract",config,"aux")
config =
(
next field,next field,next field,next field,next field,next field,next field,next field,next field,next field,next field,next field,
next_field,next_field,next_field,next_field,next_field,next_field,next_field,next_field,next_field,
)
HKC_Key_register("F1","smart_extract",config,"aux")
type=
Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HKC_Group_register("<^k", "joiner_HK",3000,"LCtrl", "$^q")
config =
(
Null join,comma,colon,equal
,
,
,
,
)

HKC_Key_register("<^k","joiner_HK",config,"aux")


config =
(
left,right
,
,
,
,
,
)

HKC_Key_register("<^j","joiner_HK",config,"aux")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HKC_func_before_first_trigger=selText:=Get_Selected_Text()
HKC_funcs_onRelease=
(
"enterToSend_EscToCancel_ElseCopy(HKC_custom_disp_msg,3)","enterToSend_EscToCancel_ElseCopy(HKC_custom_disp_msg,3)","enterToSend_EscToCancel_ElseCopy(HKC_custom_disp_msg,3)"
"enterToSend_EscToCancel_ElseCopy(HKC_custom_disp_msg,3)","enterToSend_EscToCancel_ElseCopy(HKC_custom_disp_msg,3)","enterToSend_EscToCancel_ElseCopy(HKC_custom_disp_msg,3)","enterToSend_EscToCancel_ElseCopy(HKC_custom_disp_msg,3)"
"enterToSend_EscToCancel_ElseCopy(HKC_custom_disp_msg,3)","enterToSend_EscToCancel_ElseCopy(HKC_custom_disp_msg,3)","enterToSend_EscToCancel_ElseCopy(HKC_custom_disp_msg,3)","enterToSend_EscToCancel_ElseCopy(HKC_custom_disp_msg,3)"
"enterToSend_EscToCancel_ElseCopy(HKC_custom_disp_msg,3)","enterToSend_EscToCancel_ElseCopy(HKC_custom_disp_msg,3)"
"enterToSend_EscToCancel_ElseCopy(HKC_custom_disp_msg,3)","enterToSend_EscToCancel_ElseCopy(HKC_custom_disp_msg,3)"
)
HKC_actions_before_msg=
(
fav_compact,apply_regex,apply_regex
apply_regex,apply_regex,apply_regex,apply_regex
apply_regex_lines,apply_regex_lines,apply_regex_lines,apply_regex_lines
apply_regex,apply_regex
fav_hard_compact,apply_regex
)
HKC_params1=
(
"na","m)^(?:[\t ]*(?:\r?\n|\r))+","m`a)(^[ \t]+|[ \t]+$)"
"m`a)[`%\\\.\*?+[{|()^$""]","m`a)\s","m`a)[\s""]","[`%\\\.\*?+[{}|()^$""]"
m)\R,m)\R,m)\R,m)\R
"[^()]*+(\((?:[^()]++|(?1))*\))[^()]*+","\([^)]*\)"
,
)
; loop,parse,HKC_params1,`n
; loop,parse,A_LoopField,CSV
; 	msgbox,%a_loopfield%

HKC_params2=
(
sss,,
,,,
,,,:
$1,
,
)
HKC_msgs =
(
compact,remove blanks,lead/trail
clean xtras,white spaces,quotes and spaces,special symbols
lines to spaces,to null,to comma,colon
specials remove not in brackets,remove in brackets,csv escapes
Favs 1, fav2,Fav3
)


config2 =
(
usa,canada,japan,aus,england
)
HKC_Group_register("F6","KSEB",2000,"", "$esc")
HKC_Key_register("F3","KSEB",config,"same_category")
HKC_Key_register("F1","KSEB","","category_changer")
HKC_Key_register("F6","KSEB",config2,"aux")


; HKC_register("F2","KSEB","power_kill_HK",3,3000,"", "$esc",config,"aux")

config =
(
albin,bibin
,
,
,
,
,
action,action,action
,
)
; HKC_register("F6","KSEB","power_save2_HK",2,3000,"", "$esc",config,"aux")

; HKC_register("^F3","power_save2_HK",4,1000,"LCtrl", "$^q",config,"main")

;;;;;;;;;;;;;;;;;;;;;;

return 

apply_regex:

	a:=get_entry("HKC_params1",HKC_groupId,HKC_keyId,HKC_category,HKC_keyId_count)
	b:=get_entry("HKC_params2",HKC_groupId,HKC_keyId,HKC_category,HKC_keyId_count)
HKC_custom_disp_msg := RegExReplace(selText, a,b )

return


apply_regex_lines:
a:=get_entry("HKC_params1",HKC_groupId,HKC_keyId,HKC_category,HKC_keyId_count)
	b:=get_entry("HKC_params2",HKC_groupId,HKC_keyId,HKC_category,HKC_keyId_count)
	
	HKC_custom_disp_msg := RegExReplace(selText, a,b )
	
return

fav_compact:	
	HKC_custom_disp_msg := RegExReplace(selText, "m`n)(^[ \t]+|[ \t]+$)" )
	HKC_custom_disp_msg := RegExReplace(HKC_custom_disp_msg, "m)^(?:[\t ]*(?:\r?\n|\r))+" ) ; blank
return
fav_hard_compact:	
	HKC_custom_disp_msg := RegExReplace(selText, "m`n)(^[ \t]+|[ \t]+$)" )
	HKC_custom_disp_msg := RegExReplace(HKC_custom_disp_msg, "m`n)(^[ \t]+|[ \t]+$)" ) ; lead/trail
	HKC_custom_disp_msg := RegExReplace(HKC_custom_disp_msg, "m`n)[`%\\\.\*?+[{}|()^$""]" ) ; symbols
	HKC_custom_disp_msg := RegExReplace(HKC_custom_disp_msg, "m)^(?:[\t ]*(?:\r?\n|\r))+" ) ; blank
	return


next_smart_match:
	first_valid_line := get_first_non_empty_line( source_text )

; msgbox,%type%
	type := smart_match( first_valid_line,type )
	HKC_custom_disp_msg = %type%

count :=1
gosub, next_field
return


next_field:

pattern_list:= get_smart_pattern_list("pattern_list")
pattern_list_groups:= get_smart_pattern_list("pattern_list_groups")
; msgbox,%pattern_list_groups%
/*
pattern_list_parse=
(
,
,
,

^((\w+)=(\w+)&)*(\w+)=(\w+)$
^((\w+)==(\w+)&)*(\w+)==(\w+)$
^(\w+)\(((.*),)*(.*)\)$
^(\w+):=(\w+)\(((.*),)*(.*)\)$
)
*/

stringsplit,pattern_list_groups, pattern_list_groups,`n, `r
; stringsplit,pattern_list_parse, pattern_list_parse,`n, `r
present_match_pos := get_present_match_pos(pattern_list,"`n", type)
; msgbox,type=%type% pos=%present_match_pos%
loop,%first_valid_line0%
	first_valid_line%a_index%=
if (present_match_pos=1 OR present_match_pos=2 OR present_match_pos=3)
{
	loop, parse, source_text,`n,`r
		loop, parse, A_LoopField,CSV
		{
			first_valid_line%a_index% .= a_loopfield . "`n"
			; msgbox,%first_valid_line1%
			first_valid_line0 := A_Index
		}
	count_max := first_valid_line0

}
else if (present_match_pos=7 OR present_match_pos=8 )
{
	loop, parse, source_text,`n,`r
	loop,parse,A_LoopField,&
	{
		first_valid_line%a_index% .= a_loopfield . "`n"
		first_valid_line0 := A_Index
	}
	count_max := first_valid_line0
}
Else
{
	count_max := pattern_list_groups%present_match_pos%
	; MsgBox, %present_match_pos% %count_max%
	; count_max := pattern_list_groups
	replacement := "$" . count
	first_valid_line%count%:= regexreplace(source_text,type,replacement)
}
	HKC_custom_disp_msg:= "count=" . count . " type=" . type . "`n" . first_valid_line%count%
	count++
	count := reset_counter_if_out_of_bound(count,,count_max)
	; a:=pattern_list_parse%count%
	; msgbox,%a% %count%
	; msgbox, %first_valid_line4%
	smart_extract_F1_max := count_max
Return

next_group(source_text, pattern )
{


}
exit_smart_extract:
; msgbox,
; tooltip,type=,,,5
type=
return  

^+v:: ; paste next field
	SetTimer,removetooltip, 200
	ToolTip, %count%
	Clipboard := first_valid_line%count%
	count++
	count := reset_counter_if_out_of_bound(count,,count_max)
return


