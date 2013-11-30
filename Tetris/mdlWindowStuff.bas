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
Private Declare Function SendMessageByString Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As String) As Long
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Const WM_CHAR = &H102
Private Declare Function SendMessageLong& Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long)
Private Const WM_SETTEXT = &HC
Private Const WM_GETTEXTLENGTH = &HE
Private Const WM_GETTEXT = &HD
'Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long) As Long
'Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type

Private Declare Function GetClientRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT) As Long
Private Declare Function GetWindowRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT) As Long

Public Function ReturnWindowTitleBarHeight(lHandle As Long) As Integer
On Local Error Resume Next
Dim lWindowPos As RECT, lClientPos As RECT, lBorderWidth As Long, lTopOffset As Long, i As Long
i = GetWindowRect(lHandle, lWindowPos)
i = GetClientRect(lHandle, lClientPos)
ReturnWindowTitleBarHeight = lWindowPos.Bottom - lWindowPos.Top - lClientPos.Bottom - lBorderWidth
End Function

Public Function ReturnWindowBorder(lHandle As Long) As Integer
On Local Error Resume Next
Dim lWindowPos As RECT, lClientPos As RECT, lBorderWidth As Long, lTopOffset As Long, i As Long
i = GetWindowRect(lHandle, lWindowPos)
i = GetClientRect(lHandle, lClientPos)
ReturnWindowBorder = lWindowPos.Right - lWindowPos.Left - lClientPos.Right - 2
End Function

Public Sub mIRCStatusSend(lData As String)
On Local Error Resume Next
Dim lmIRC As Long, lMdiClient As Long, lmIRCStatus As Long, lEditBox As Long
lmIRC = FindWindow("mIRC", vbNullString)
lMdiClient = FindWindowEx(lmIRC, 0&, "MdiClient", vbNullString)
lmIRCStatus = FindWindowEx(lMdiClient, 0&, "mIRC_Status", vbNullString)
lEditBox = FindWindowEx(lmIRCStatus, 0&, "RichEdit20A", vbNullString)
Call SendMessageByString(lEditBox, WM_SETTEXT, 0&, lData)
If lEditBox = 0 Then Exit Sub
Do
    DoEvents
    lmIRC = FindWindow("mIRC", vbNullString)
    lMdiClient = FindWindowEx(lmIRC, 0&, "MdiClient", vbNullString)
    lmIRCStatus = FindWindowEx(lMdiClient, 0&, "mIRC_Status", vbNullString)
    lEditBox = FindWindowEx(lmIRCStatus, 0&, "RichEdit20A", vbNullString)
    Call SendMessageLong(lEditBox, WM_CHAR, 13, 0&)
Loop Until lEditBox <> 0
End Sub

Public Function ReturnParentWindow() As Long
ReturnParentWindow = lParenthWnd
End Function

Public Sub SetWindowToChild(lWindowHwnd As Long)
On Local Error GoTo ErrHandler
Dim l As Long
SetWindowLong lWindowHwnd, GWL_STYLE, WS_CHILD
SetParent CLng(Trim(lWindowHwnd)), lParenthWnd
'SetWindowText CLng(Trim(lParenthWnd)), "cpanel v" & App.Major & "." & App.Minor
SetWindowText CLng(Trim(lParenthWnd)), "Nexgen Tetris"
Exit Sub
ErrHandler:
    'MsgBox Err.Description
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
