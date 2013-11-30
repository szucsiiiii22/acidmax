Attribute VB_Name = "mdlFormStuff"
Option Explicit
Private lNexCam As New frmMain

'Public Sub SetAddMultiOpen(lValue As Boolean)
'On Local Error Resume Next
'lNexCam.SetAddMultipleOpen lValue
'End Sub

Public Function ReturnMainFormWidth() As Long
On Local Error Resume Next
ReturnMainFormWidth = lNexCam.Width
End Function

Public Function ReturnMainFormHeight() As Long
On Local Error Resume Next
ReturnMainFormHeight = lNexCam.Height
End Function

Public Function ReturnMainFormLeft() As Long
On Local Error Resume Next
ReturnMainFormLeft = lNexCam.Left
End Function

Sub Main()

End Sub

Public Function ReturnMainFormTop() As Long
On Local Error Resume Next
ReturnMainFormTop = lNexCam.Top
End Function

Public Sub InitMainForm()
On Local Error GoTo ErrHandler
Set lNexCam = New frmMain
ShowNonModalForm lNexCam
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub DestroyMainForm()
On Local Error GoTo ErrHandler
Unload lNexCam
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub
