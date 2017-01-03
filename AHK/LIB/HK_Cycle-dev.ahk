HKC_group_register("<#1", "subkeys list","smart_extract_HK",4,3000, "Lwin", "$#q",config)

HKC_group_register(HK,sub_keys,HKC_group_name,tot_steps,idle_stop_after,release_checking_key,Cancel_key,config)
{
global
	HKC_list .= HKC_name . "," ; global variable with all HK cycle names
	HKC_groups_list .= HKC_group_name . "," 
	%HKC_id%_abort_Cancel_key := Cancel_key
	%HKC_id%_idle_stop_after := idle_stop_after
	%HKC_id%_release_checking_key := release_checking_key
	%HKC_id%_func_ref_each_Cycle := Func("HKC_each_Cycle").bind(HKC_id)
	
	HKC_id := HKC_name 
	%HKC_id%_config := config
	%HKC_id% := 0
	func_ref_abort =
	func_ref_each_Cycle := %HKC_id%_func_ref_each_Cycle
	Hotkey,%HK%,%func_ref_each_Cycle%
	Hotkey,%HK%,on
	%HKC_id%_func_ref_abort2 := Func( "HKC_abort").bind(HKC_id)
		
	%HKC_id%_func_ref_release_check_timer := Func("HKC_release_check_timer").bind(HKC_id,%HKC_id%_release_checking_key)
	%HKC_id%_func_ref_abort_onCancel_key:= Func("HKC_abort_onCancel_key").bind(HKC_id)


}



HKC_register(HK,HKC_name,HKC_group_name,tot_steps,idle_stop_after,release_checking_key,Cancel_key,config)
{
	global
	HKC_list .= HKC_name . "," ; global variable with all HK cycle names
	HKC_id := HKC_name 
	%HKC_id%_config := config
	%HKC_id% := 0
	%HKC_group_id%_%HKC_id%_tot_steps := tot_steps
	%HKC_group_id%_idle_stop_after := idle_stop_after
	%HKC_group_id%_release_checking_key := release_checking_key
	%HKC_group_id%_abort_Cancel_key := Cancel_key
	
	func_ref_abort =
	%HKC_id%_func_ref_each_Cycle := Func("HKC_each_Cycle").bind(HKC_id)
	func_ref_each_Cycle := %HKC_id%_func_ref_each_Cycle
	Hotkey,%HK%,%func_ref_each_Cycle%
	Hotkey,%HK%,on
	%HKC_id%_func_ref_abort2 := Func( "HKC_abort").bind(HKC_id)
		
	%HKC_id%_func_ref_release_check_timer := Func("HKC_release_check_timer").bind(HKC_id,%HKC_id%_release_checking_key)
	%HKC_id%_func_ref_abort_onCancel_key:= Func("HKC_abort_onCancel_key").bind(HKC_id)
}

HKC_each_Cycle(HKC_id_local)
{
global
HKC_id := HKC_id_local	; making it a global variable

	
if (!%HKC_id%)
	{
		HKC_id_count = %HKC_id%_count
		release_checking_key := %HKC_id%_release_checking_key
		idle_stop_after := %HKC_id%_idle_stop_after
		HKC_tot_steps := %HKC_id%_tot_steps
		HKC_initialise_if_not_initialised(HKC_id)
	}
	HKC_next( HKC_id,HKC_tot_steps, HKC_msgs, HKC_actions_onRelease, extra_params, input_param, HKC_id_action, idle_stop_after, HKC_actions_before_msg)
}

HKC_initialise_if_not_initialised(HKC_id_local)
{
	global
	HKC_id := HKC_id_local	; making it a global variable
	variable_list=HKC_msgs,HK_funcs_before_msg,HKC_actions_before_msg,HKC_id_release_Pre_func,HKC_id_release_Pre_action,HK_funcs_onRelease,HKC_actions_onRelease,HKC_id_release_Post_func,HKC_id_release_Post_action,input_param
	stringsplit, variable_list,variable_list,`, 
	config :=%HKC_id%_config
	loop,parse,config,`n,`r
	{
		var := variable_list%a_index%
		%var% := a_loopfield
	}	
	; loop,parse,parameter_containers,CSV
	loop,parse,variable_list,CSV
		; stringsplit,%a_loopfield%,%a_loopfield%,CSV
	{
		root := a_loopfield
		a:= %a_loopfield%
		loop,parse,%a_loopfield%,CSV
			%root%%a_index% := a_loopfield
	}
	%HKC_id_count% :=0	
	func_ref_release_check_timer:= %HKC_id%_func_ref_release_check_timer

	SetTimer, %func_ref_release_check_timer%, 100
	; tooltip,func_ref_release_check_timer running,100,,3
	local hk = %HKC_id%_abort_Cancel_key

	func_ref_abort_onCancel_key:= %HKC_id%_func_ref_abort_onCancel_key
	Hotkey,%hk%,%func_ref_abort_onCancel_key%
	Hotkey,%hk%,on
}

HKC_next(HKC_id_local,HKC_tot_steps,HKC_msgs,HKC_actions_onRelease,extra_params,input_param,ByRef HKC_id_action, idle_stop_after=7000,custom_disp_message_prepare="")
{
	global
	HKC_id := HKC_id_local	; making it a global variable
	; limitations: No simultaneous HK cycle threads because of Byref
	
	this_hotkey := a_thishotkey
	if (idle_stop_after)
	{
		func_ref_abort2 := %HKC_id%_func_ref_abort2
		SetTimer, %func_ref_abort2%, -%idle_stop_after%
		; tooltip,-abort running,100,,2
	}
	if !(%HKC_id%)
	{
		%HKC_id% := 1
		HKC_id_count := 1
	}
	else
		HKC_id_count++
	if (%HKC_id%)	
	{
		if (HKC_id_count<= HKC_tot_steps)
		{	
			
			if (HKC_actions_before_msg%HKC_id_count%="")
				msg := HKC_msgs%HKC_id_count%
			else
			{
				goto_label := HKC_actions_before_msg%HKC_id_count%
				gosub,%goto_label%
				msg := HKC_custom_disp_msg
			}
			tooltip_delay:=idle_stop_after
		}	
		else
		{
			HKC_id_count:=0
			msg = cancel
			tooltip_delay:=1000	
		}
		HKC_id_action :=HKC_actions_onRelease%HKC_id_count%
		tooltip,%HKC_id_count%/%HKC_tot_steps% %msg%
		settimer,removetooltip,-%tooltip_delay%
	}
return
}

HKC_abort(HKC_id_local) ; ByRef HKC_id)
{
	global
	HKC_id := HKC_id_local	; making it a global variable
	func_ref_release_check_timer := %HKC_id%_func_ref_release_check_timer	
	setTimer,%func_ref_release_check_timer%,off
	func_ref_abort2 := %HKC_id%_func_ref_abort2
	name := func_ref_abort.name

	setTimer,%func_ref_abort2%,off
	; tooltip,func_ref_abort2 turned off,,250,6
	%HKC_id% := 0
	; tooltip,cancelleddd %idle_stop_after%s %HKC_id% ,800,,9
	tooltip,%HKC_id_count%/%HKC_tot_steps% %msg% cancelled
	settimer,removetooltip,300
	; tooltip,,,,2
	; tooltip,,,,3
	; tooltip,,,,4
}


HKC_release_check_timer(HKC_id_local,release_checking_key)
{
	global
	HKC_id := HKC_id_local	; making it a global variable
	GetKeyState,state,%release_checking_key%
	; tooltip,%state%state,,400,4
	If state=u
	{
		HKC_abort(HKC_id) 
		HKC_release_execute(HKC_id)
	}
	a := %HKC_id%
}

HKC_release_execute(HKC_id_local)
{
	global
	HKC_id := HKC_id_local	; making it a global variable
	if (HKC_id_count)
	{		
		count := HKC_id_count
		function_string :=HKC_id_release_Pre_func%count%
		if (function_string!="")
			call_func_from_string(function_string)
		local label_name := HKC_id_release_Pre_action%count%
		if ( label_name!="" )
			gosub, %label_name%		
		function_string :=HK_funcs_onRelease%count%
		if (function_string!="")
			call_func_from_string(function_string)
		local label_name := HKC_actions_onRelease%count%
		if ( label_name!="" )
			gosub, %label_name%			
			
		function_string :=HKC_id_release_Post_func%count%
		if (function_string!="")
			call_func_from_string(function_string)
		local label_name := HKC_id_release_Post_action%count%
		if ( label_name!="" )
			gosub, %label_name%
			
	}
	%HKC_id_count% := 0
	local hk = %HKC_id%_abort_Cancel_key
	Hotkey,%hk%,off
}

HKC_abort_onCancel_key(HKC_id_local)
{
	global
	HKC_id := HKC_id_local	; making it a global variable

	local cancelled := 0
	{
		if  (%HKC_id%) 
		{
			HKC_abort(HKC_id) 
			local hk := %HKC_id%_abort_Cancel_key
			hotkey,%hk%,off
			cancelled :=1
		}
	}
	if (!cancelled)
	{
		send {%a_thishotkey%}
	}
}
