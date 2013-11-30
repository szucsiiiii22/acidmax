Attribute VB_Name = "mdlWindowStuff"
Option Explicit
Private Const GWL_STYLE = -16
Private Const WS_CHILD = &H40000000
Private Const GWL_WNDPROC = (-4)
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long) As Long
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function SetWindowText Lib "user32" Alias "SetWindowTextA" (ByVal hWnd As Long, ByVal lpString As String) As Long
Private Declare Function ShowWindow Lib "user32" (ByVal hWnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Function SetParent Lib "user32.dll" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Private lParenthWnd As String

Public Sub SetWindowToChild(lWindowHwnd As Long)
On Local Error GoTo ErrHandler
'Dim lStyle As Long
'lStyle = WS_CHILD Or WS_POPUP
SetWindowLong lWindowHwnd, GWL_STYLE, WS_CHILD
SetParent CLng(Trim(lWindowHwnd)), lParenthWnd
SetWindowText CLng(Trim(lParenthWnd)), "Acidmax - NexCam v" & App.Major & "." & App.Revision
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub SetParentHwnd(lhWnd As Long)
On Local Error Resume Next
lParenthWnd = Str(lhWnd)
End Sub

Public Function ShowNonModalForm(lForm As Form) As Boolean
On Local Error GoTo ErrHandler
ShowWindow lForm.hWnd, 1
Exit Function
ErrHandler:
    Err.Clear
End Function

