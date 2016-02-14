Attribute VB_Name = "mdlFormStuff"
Option Explicit
Private lcpanel As New frmMain

Public Function ReturnMainFormWidth() As Long
On Local Error Resume Next
ReturnMainFormWidth = lcpanel.Width
End Function

Public Function ReturnMainFormHeight() As Long
On Local Error Resume Next
ReturnMainFormHeight = lcpanel.Height
End Function

Public Function ReturnMainFormLeft() As Long
On Local Error Resume Next
ReturnMainFormLeft = lcpanel.Left
End Function

Public Function ReturnMainFormTop() As Long
On Local Error Resume Next
ReturnMainFormTop = lcpanel.Top
End Function

Public Sub InitMainForm()
On Local Error GoTo ErrHandler
Set lcpanel = New frmMain
ShowNonModalForm lcpanel
Exit Sub
ErrHandler:
    
    Err.Clear
End Sub

Public Sub DestroyMainForm()
On Local Error GoTo ErrHandler
Unload lcpanel
Exit Sub
ErrHandler:
    
    Err.Clear
End Sub

Public Sub SetMainFormVisible(lVisible As Boolean)
On Local Error GoTo ErrHandler
lcpanel.Visible = lVisible
Exit Sub
ErrHandler:
    
    Err.Clear
End Sub

Public Sub LoadPanel(lFile As String)
lcpanel.LoadItems App.Path & "\" & lFile
End Sub
