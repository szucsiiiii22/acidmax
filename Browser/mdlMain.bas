Attribute VB_Name = "mdlMain"
Option Explicit

Sub Main()
On Local Error GoTo ErrHandler

Exit Sub
ErrHandler:
    If Err.Number <> 0 Then Err.Clear
End Sub
