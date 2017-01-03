
vas(obj,ByRef txt){
	for k,v in obj
		if (v=txt)
			return 0
	return 1
}

GetPatternName(id){
	global uia
	DllCall(vt(uia,50),"ptr",uia,"uint",id,"ptr*",name)
	return StrGet(name)
}
GetPropertyName(id){
	global uia
	DllCall(vt(uia,49),"ptr",uia,"uint",id,"ptr*",name)
	return StrGet(name)
}
GetElementItem(x,y){
	global uia
	item:={}
	DllCall(vt(uia,7),"ptr",uia,"int64",x|y<<32,"ptr*",element) ;IUIAutomation::ElementFromPoint
        if !element
            return
	DllCall(vt(element,23),"ptr",element,"ptr*",name) ;IUIAutomationElement::CurrentName
	DllCall(vt(element,10),"ptr",element,"uint",30045,"ptr",variant(val)) ;IUIAutomationElement::GetCurrentPropertyValue::value
	DllCall(vt(element,10),"ptr",element,"uint",30092,"ptr",variant(lname)) ;IUIAutomationElement::GetCurrentPropertyValue::lname
	DllCall(vt(element,10),"ptr",element,"uint",30093,"ptr",variant(lval)) ;IUIAutomationElement::GetCurrentPropertyValue::lvalue
	a:=StrGet(name,"utf-16"),b:=StrGet(NumGet(val,8,"ptr"),"utf-16"),c:=StrGet(NumGet(lname,8,"ptr"),"utf-16"),d:=StrGet(NumGet(lval,8,"ptr"),"utf-16")
	a?item.Insert(a):0
	b&&vas(item,b)?item.Insert(b):0
	c&&vas(item,c)?item.Insert(c):0
	d&&vas(item,d)?item.Insert(d):0
	DllCall(vt(element,21),"ptr",element,"uint*",type) ;IUIAutomationElement::CurrentControlType
	if (type=50004)
		e:=GetElementWhole(element),e&&vas(item,e)?item.Insert(e):0
	ObjRelease(element)
	return item
}
GetElementWhole(element){
	global uia
	static init:=1,trueCondition,walker
	if init
		init:=DllCall(vt(uia,21),"ptr",uia,"ptr*",trueCondition) ;IUIAutomation::CreateTrueCondition
		,init+=DllCall(vt(uia,14),"ptr",uia,"ptr*",walker) ;IUIAutomation::ControlViewWalker
	DllCall(vt(uia,5),"ptr",uia,"ptr*",root) ;IUIAutomation::GetRootElement
	DllCall(vt(uia,3),"ptr",uia,"ptr",element,"ptr",root,"int*",same) ;IUIAutomation::CompareElements
	ObjRelease(root)
	if same {
		return
	}
	hr:=DllCall(vt(walker,3),"ptr",walker,"ptr",element,"ptr*",parent) ;IUIAutomationTreeWalker::GetParentElement
	if parent {
		e:=""
		DllCall(vt(parent,6),"ptr",parent,"uint",2,"ptr",trueCondition,"ptr*",array) ;IUIAutomationElement::FindAll
		DllCall(vt(array,3),"ptr",array,"int*",length) ;IUIAutomationElementArray::Length
		loop % length {
			DllCall(vt(array,4),"ptr",array,"int",A_Index-1,"ptr*",newElement) ;IUIAutomationElementArray::GetElement
			DllCall(vt(newElement,23),"ptr",newElement,"ptr*",name) ;IUIAutomationElement::CurrentName
			e.=StrGet(name,"utf-16")
			ObjRelease(newElement)
		}
                ObjRelease(array)
		ObjRelease(parent)
		return e
	}
}
variant(ByRef var,type=0,val=0){
	return (VarSetCapacity(var,8+2*A_PtrSize)+NumPut(type,var,0,"short")+NumPut(val,var,8,"ptr"))*0+&var
}
vt(p,n){
	return NumGet(NumGet(p+0,"ptr")+n*A_PtrSize,"ptr")
}
