Attribute VB_Name = "mdlFormStuff"
Option Explicit
Private lmIRCForm As New frmMain

Public Function ReturnMainFormWidth() As Long
On Local Error Resume Next
ReturnMainFormWidth = lmIRCForm.Width
End Function

Public Function ReturnMainFormHeight() As Long
On Local Error Resume Next
ReturnMainFormHeight = lmIRCForm.Height
End Function

Public Function ReturnMainFormLeft() As Long
On Local Error Resume Next
ReturnMainFormLeft = lmIRCForm.Left
End Function

Public Function ReturnMainFormTop() As Long
On Local Error Resume Next
ReturnMainFormTop = lmIRCForm.Top
End Function

Public Sub InitMainForm()
On Local Error GoTo ErrHandler
Set lmIRCForm = New frmMain
ShowNonModalForm lmIRCForm
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub DestroyMainForm()
On Local Error GoTo ErrHandler
Unload lmIRCForm
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub
