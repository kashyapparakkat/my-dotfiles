/*
other approaches:
	(Sean) http://www.autohotkey.com/forum/viewtopic.php?t=20701

*/
f2::
	hwnd := hwnd ? hwnd : WinExist("A")
	WinGetClass class, ahk_id %hwnd%
	
	if (class="CabinetWClass" or class="ExploreWClass" or class="Progman")
		for window in ComObjCreate("Shell.Application").Windows
			MsgBox % window.LocationURL

RETURN


F4::
	reload
return
F3::
	path := Explorer_GetPath()
	all := Explorer_GetItems()
	sel := Explorer_GetSelection()


	all_msg := "name for every item:`n"
	for item in all
		all_msg .= item.name "`n"

	sel_msg := "path for selected items:`n"
	for item in sel
		sel_msg .= item.path "`n"

	msg := "path=" path "`n`n" all_msg "`n`n" sel_msg

	MsgBox,, Active Explorer Window Info, %msg%
	;c := Container("COM",Explorer_GetSelection(),"Path")
	;dout_o(c,"container")
return




Explorer_GetWindow(hwnd="")
{
	hwnd := hwnd ? hwnd : WinExist("A")
	WinGetClass class, ahk_id %hwnd%
	
	if (class="CabinetWClass" or class="ExploreWClass" or class="Progman")
		for window in ComObjCreate("Shell.Application").Windows
			if (window.hwnd==hwnd)
				return window
}
Explorer_GetShellFolderView(hwnd="")
{
	return Explorer_GetWindow(hwnd).Document
}


Explorer_GetPath(hwnd="")
{
	return Explorer_GetWindow(hwnd).LocationURL
}
Explorer_GetItems(hwnd="")
{
	return Explorer_GetShellFolderView(hwnd).Folder.Items
}
Explorer_GetSelection(hwnd="")
{
	return Explorer_GetShellFolderView(hwnd).SelectedItems
}
