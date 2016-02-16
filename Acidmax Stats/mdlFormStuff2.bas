Attribute VB_Name = "mdlFormStuff"
Option Explicit
Private lMainForm As New frmMain

Sub Main()

End Sub

Public Function ReturnMainFormWidth() As Long
On Local Error Resume Next
ReturnMainFormWidth = lMainForm.Width
End Function

Public Function ReturnMainFormHeight() As Long
On Local Error Resume Next
ReturnMainFormHeight = lMainForm.Height
End Function

Public Function ReturnMainFormLeft() As Long
On Local Error Resume Next
ReturnMainFormLeft = lMainForm.Left
End Function

Public Function ReturnMainFormTop() As Long
On Local Error Resume Next
ReturnMainFormTop = lMainForm.Top
End Function

Public Sub InitMainForm()
On Local Error GoTo ErrHandler
Set lMainForm = New frmMain
ShowNonModalForm lMainForm
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub DestroyMainForm()
On Local Error GoTo ErrHandler
WriteINI App.Path & "\ass.ini", "Settings", "Channel", lMainForm.txtChannel.Text
Unload lMainForm
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub
