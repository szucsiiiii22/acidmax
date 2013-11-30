Attribute VB_Name = "mdlFormStuff"
Option Explicit
Private lTranslator As New frmMain

'Public Sub SetAddMultiOpen(lValue As Boolean)
'On Local Error Resume Next
'lTranslator.SetAddMultipleOpen lValue
'End Sub

Public Function ReturnMainFormWidth() As Long
On Local Error Resume Next
ReturnMainFormWidth = lTranslator.Width
End Function

Public Function ReturnMainFormHeight() As Long
On Local Error Resume Next
ReturnMainFormHeight = lTranslator.Height
End Function

Public Function ReturnMainFormLeft() As Long
On Local Error Resume Next
ReturnMainFormLeft = lTranslator.Left
End Function

Public Function ReturnMainFormTop() As Long
On Local Error Resume Next
ReturnMainFormTop = lTranslator.Top
End Function

Public Sub InitMainForm()
On Local Error GoTo ErrHandler
Set lTranslator = New frmMain
ShowNonModalForm lTranslator
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub DestroyMainForm()
On Local Error GoTo ErrHandler
Unload lTranslator
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

