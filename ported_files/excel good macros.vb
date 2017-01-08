C-S l filter on/off
C-A-l again apply
M-a c - clear all filter
C-` = toggle formulas
M-A SA sort asc SD sort descend
==
Dim Report1 As Worksheet
Set Report1 = Application.ActiveWorkbook.Worksheets("Report")
==
Range("A" & ActiveCell.Row & ":J" & ActiveCell.Row)

Application.ActiveWorkbook.ActiveSheet.Range ("A2"), Scroll:=True
Application.Goto ActiveSheet.Range("A3"), Scroll:=True

===
Sub Insert_diff_column_for_select_cols()
'Inserting a Column at Column B
Col = Chr(ActiveCell.Column + 64)
Range("C1").EntireColumn.Insert
Range("C1").Formula = "=B1-A1"
LastRow = Range("B" & Rows.Count).End(xlUp).Row
Range("C1").AutoFill Destination:=Range("C1:C" & LastRow)
'Inserting 2 Columns from C
'Range("C:D").EntireColumn.Insert
End Sub
=======


Sub Macro1()
'
' Macro1 Macro
'

'
    Selection.AutoFilter
    ActiveSheet.Range(ActiveCell.Column & ":" & ActiveCell.Column).AutoFilter Field:=1, Criteria1:=">=0", _
        Operator:=xlAnd
End Sub


Sub GoToMax()
' can find in selection/column/entire sheet
'   Activates the cell with the largest value
    Dim WorkRange As Range

'   Exit if a range is not selected
    If TypeName(Selection) <> "Range" Then Exit Sub

'   If one cell is selected, search entire worksheet;
'   Otherwise, search the selected range
    If Selection.Count = 1 Then
        ActiveSheet.Columns(ActiveCell.Column).EntireColumn.Select
        'Set WorkRange = Selection
        ' Range(ActiveCell.Column & ":" & ActiveCell.Column)
    'Else
        'ActiveSheet.Columns(ActiveCell.Column).EntireColumn.Select
    End If
    Set WorkRange = Selection
'   Determine the maximum value
    Val_to_search = Application.Max(WorkRange)
    
'   Find it and select it
    On Error Resume Next
    WorkRange.Find(What:=Val_to_search, _
        After:=WorkRange.Range("A1"), _
        LookIn:=xlValues, _
        LookAt:=xlPart, _
        SearchOrder:=xlByRows, _
        SearchDirection:=xlNext, MatchCase:=False _
        ).Select
    If Err <> 0 Then MsgBox "Max value was not found: " & Val_to_search
End Sub
Sub GoToMin()
' can find in selection/column/entire sheet
'   Activates the cell with the largest value
    Dim WorkRange As Range

'   Exit if a range is not selected
    If TypeName(Selection) <> "Range" Then Exit Sub

'   If one cell is selected, search entire worksheet;
'   Otherwise, search the selected range
    If Selection.Count = 1 Then
        ActiveSheet.Columns(ActiveCell.Column).EntireColumn.Select
        'Set WorkRange = Selection
        ' Range(ActiveCell.Column & ":" & ActiveCell.Column)
    'Else
        'ActiveSheet.Columns(ActiveCell.Column).EntireColumn.Select
    End If
    Set WorkRange = Selection
'   Determine the maximum value
    Val_to_search = Application.Min(WorkRange)
    
'   Find it and select it
    On Error Resume Next
    WorkRange.Find(What:=Val_to_search, _
        After:=WorkRange.Range("A1"), _
        LookIn:=xlValues, _
        LookAt:=xlPart, _
        SearchOrder:=xlByRows, _
        SearchDirection:=xlNext, MatchCase:=False _
        ).Select
    If Err <> 0 Then MsgBox "Max value was not found: " & Val_to_search
End Sub

Sub setMyShortcut()

With Application

.OnKey Key:="^+{F5}", procedure:="filter_ActiveCell"
.OnKey Key:="^+{F6}", procedure:="UniqueCount"
.OnKey Key:="^+{F7}", procedure:="GoToMax"
.OnKey Key:="^+{F8}", procedure:="GoToMin"

End With

End Sub

 

Sub InsertTableRow()

Selection.EntireRow.Insert

End Sub

 

Sub resetMyShortcut()

With Application

.OnKey Key:="{insert}"

'.OnKey Key:="{left}"

End With

End Sub





Sub filter_ActiveCell()
     
    Dim Col, val, ctr As Long
    Dim FiltRng As Range
    Dim Errm As String
     
    Col = ActiveCell.Column
    val = ActiveCell.Value
     
    ctr = WorksheetFunction.CountBlank(Columns(Col))
     
    If ctr = Rows.Count Then
        Errm = MsgBox("Column with Range you trying to Filter is empty.", _
        vbCritical + vbOKOnly, "No data in selected column")
        Exit Sub
    End If
     
     
     
    Set FiltRng = ActiveSheet.Range(Cells(1, Col), _
    Cells(Cells(Rows.Count, Col).End(xlUp).Row, Col))
     
    If ActiveSheet.AutoFilterMode = True Then
        ActiveSheet.AutoFilterMode = False
    End If
     
    FiltRng.AutoFilter Field:=1, Criteria1:=(val), Operator:=xlAnd
     
End Sub



' Option Explicit
 
 
Sub UniqueCount()
    Dim N As Long
    Dim dupes As Long
    Dim UniqueVal As New Collection
    Dim LastRow As Long
    Dim i As Long
    Dim val As String
  Dim vMin, vMax
    LastRow = Cells(Rows.Count, "A").End(xlUp).Row
 
    On Error Resume Next
    For i = 2 To LastRow
        val = Cells(i, "A") & "#" & Cells(i, "B") & "#" & Cells(i, "C")
        UniqueVal.Add val, val
    Next i
    On Error GoTo 0
 
    vMin = Application.WorksheetFunction.Min(Range(ActiveCell.Column & ":" & ActiveCell.Column))
    vMax = Application.WorksheetFunction.Max(Columns("O"))
    dupes = CountDuplicates()
    zero = Application.CountIf(Range(ActiveCell.Column & ":" & ActiveCell.Column), "=0")
    nonzero = Application.CountIf(Range(ActiveCell.Column & ":" & ActiveCell.Column), "<>0")
    positives = Application.CountIf(Range(ActiveCell.Column & ":" & ActiveCell.Column), "<>0")
    N = Cells(Rows.Count, 1).End(xlUp).Row
    MsgBox "N = " & N & vbNewLine & "Dupes : " & dupes & vbNewLine & "Unique Count: " & vbTab & Format(UniqueVal.Count, "#,##0") & vbNewLine & "Minimum = " & vMin & ", " & "Maximum = " & vMax & vbNewLine & "TODO : Zeros " & zero & "  +ves: " & positives & "NonZeros: " & nonzero, vbInformation, "Get Min/Max Values"
 
 End Sub
' check this
' http://ccm.net/faq/19270-excel-a-macro-for-counting-duplicates-in-row


Function CountDuplicates() As Long

    Dim N As Long, cl As Collection
    Dim dCount As Long, V As Variant
    N = Cells(Rows.Count, 1).End(xlUp).Row
    Set cl = New Collection
    dCount = 0
    For i = 1 To N
        V = Cells(i, 1).Value
        On Error Resume Next
        If V <> "" Then
            cl.Add V, CStr(V)
            If Err.Number = 0 Then
            Else
                Err.Number = 0
                dCount = dCount + 1
            End If
        End If
    Next i
    
    CountDuplicates = dCount
End Function
