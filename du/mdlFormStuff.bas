Attribute VB_Name = "mdlFormStuff"
Option Explicit
Private ldu As New frmMain

Public Function ReturnMainFormWidth() As Long
On Local Error Resume Next
ReturnMainFormWidth = ldu.Width
End Function

Public Function ReturnMainFormHeight() As Long
On Local Error Resume Next
ReturnMainFormHeight = ldu.Height
End Function

Public Function ReturnMainFormLeft() As Long
On Local Error Resume Next
ReturnMainFormLeft = ldu.Left
End Function

Public Function ReturnMainFormTop() As Long
On Local Error Resume Next
ReturnMainFormTop = ldu.Top
End Function

Public Sub InitMainForm()
On Local Error GoTo ErrHandler
Set ldu = New frmMain
ShowNonModalForm ldu
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Public Sub DestroyMainForm()
On Local Error GoTo ErrHandler
Unload ldu
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Public Sub SetMainFormVisible(lVisible As Boolean)
On Local Error GoTo ErrHandler
ldu.Visible = lVisible
Exit Sub
ErrHandler:
    Err.Clear
End Sub
