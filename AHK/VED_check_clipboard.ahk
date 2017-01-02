#persistent
; settimer,check_clipboard,300


check_clipboard:
; check if clipboard has changed

return
OnClipboardChange:
    tooltip,checking
    sleep,800
    stringleft,txt,clipboard,5
    tooltip,%txt%
    if (txt=="24950")
    {  
        sleep,1000
        tooltip,running %txt%
        stringtrimleft,txt,clipboard,5
        run,%txt%
    }
return