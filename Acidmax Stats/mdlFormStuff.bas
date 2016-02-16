Attribute VB_Name = "mdlFormStuff"
Option Explicit
Private lSystemStats As New frmMain

'Public Sub SetAddMultiOpen(lValue As Boolean)
'On Local Error Resume Next
'lSystemStats.SetAddMultipleOpen lValue
'End Sub

Public Function ReturnMainFormWidth() As Long
On Local Error Resume Next
ReturnMainFormWidth = lSystemStats.Width
End Function

Public Function ReturnMainFormHeight() As Long
On Local Error Resume Next
ReturnMainFormHeight = lSystemStats.Height
End Function

Public Function ReturnMainFormLeft() As Long
On Local Error Resume Next
ReturnMainFormLeft = lSystemStats.Left
End Function

Public Function ReturnMainFormTop() As Long
On Local Error Resume Next
ReturnMainFormTop = lSystemStats.Top
End Function

Public Sub InitMainForm()
On Local Error GoTo ErrHandler
Set lSystemStats = New frmMain
ShowNonModalForm lSystemStats
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub DestroyMainForm()
On Local Error GoTo ErrHandler
Unload lSystemStats
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub


