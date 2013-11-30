Attribute VB_Name = "mdlFormStuff"
Option Explicit
Private lSendMailForm As New frmMain

Public Sub SetAddMultiOpen(lValue As Boolean)
On Local Error Resume Next
lSendMailForm.SetAddMultipleOpen lValue
End Sub

Public Function ReturnMainFormWidth() As Long
On Local Error Resume Next
ReturnMainFormWidth = lSendMailForm.Width
End Function

Public Function ReturnMainFormHeight() As Long
On Local Error Resume Next
ReturnMainFormHeight = lSendMailForm.Height
End Function

Public Function ReturnMainFormLeft() As Long
On Local Error Resume Next
ReturnMainFormLeft = lSendMailForm.Left
End Function

Public Function ReturnMainFormTop() As Long
On Local Error Resume Next
ReturnMainFormTop = lSendMailForm.Top
End Function

Public Sub InitMainForm()
On Local Error GoTo ErrHandler
Set lSendMailForm = New frmMain
ShowNonModalForm lSendMailForm
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub AddToFileListView(lFile As String, lPath As String, lSize As String)
On Local Error GoTo ErrHandler
lSendMailForm.AddToFiles lFile, lPath, lSize
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub DestroyMainForm()
On Local Error GoTo ErrHandler
'lSendMailForm.DestroyMe
If lSendMailForm.ReturnAddMultipleFilesOpen = True Then Unload frmAddMultipleFiles
Unload lSendMailForm
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub
