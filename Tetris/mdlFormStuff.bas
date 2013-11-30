Attribute VB_Name = "mdlFormStuff"
Option Explicit
Private lForm As New frmMain

Public Function ReturnMainFormWidth() As Long
On Local Error Resume Next
ReturnMainFormWidth = lForm.Width
End Function

Public Function ReturnMainFormHeight() As Long
On Local Error Resume Next
ReturnMainFormHeight = lForm.Height
End Function

Public Function ReturnMainFormLeft() As Long
On Local Error Resume Next
ReturnMainFormLeft = lForm.Left
End Function

Public Function ReturnMainFormTop() As Long
On Local Error Resume Next
ReturnMainFormTop = lForm.Top
End Function

Public Sub InitMainForm()
On Local Error GoTo ErrHandler
Set lForm = New frmMain
ShowNonModalForm lForm
Exit Sub
ErrHandler:
    'MsgBox Err.Description
    Err.Clear
End Sub

Public Sub DestroyMainForm()
On Local Error GoTo ErrHandler
Unload lForm
Exit Sub
ErrHandler:
    'MsgBox Err.Description
    Err.Clear
End Sub

Public Sub SetMainFormVisible(lVisible As Boolean)
On Local Error GoTo ErrHandler
lForm.Visible = lVisible
Exit Sub
ErrHandler:
    'MsgBox Err.Description
    Err.Clear
End Sub
