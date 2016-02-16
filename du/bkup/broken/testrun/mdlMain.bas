Attribute VB_Name = "mdlMain"
Option Explicit

Sub Main()
On Local Error GoTo ErrHandler
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Public Sub ProcessError(lSub As String, lError As String)
MsgBox ("ERROR! " & lSub & " - " & lError)
End Sub
