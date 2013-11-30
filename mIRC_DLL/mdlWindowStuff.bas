Attribute VB_Name = "mdlWindowStuff"
Option Explicit
Private Const GWL_STYLE = -16
Private Const WS_CHILD = &H40000000
Private Const WM_SETTEXT = &HC
Private Const WM_GETTEXTLENGTH = &HE
Private Const WM_GETTEXT = &HD
Private Const HWND_NOTOPMOST = -2
Private Const HWND_TOPMOST = -1
Private Const SWP_NOACTIVATE = &H10
Private Const SWP_SHOWWINDOW = &H40
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function SetWindowText Lib "user32" Alias "SetWindowTextA" (ByVal hWnd As Long, ByVal lpString As String) As Long
Private Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Private Declare Function ShowWindow Lib "user32" (ByVal hWnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Function EnumChildWindows Lib "user32" (ByVal hWndParent As Long, ByVal lpEnumFunc As Long, ByVal lParam As Long) As Long
Private Declare Function EnumWindows Lib "user32" (ByVal lpEnumFunc As Long, ByVal lParam As Any) As Long
Private Declare Function SetParent Lib "user32.dll" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Private Declare Function GetWindowTextLength Lib "user32" Alias "GetWindowTextLengthA" (ByVal hWnd As Long) As Long
Private Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hWnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Private Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hWnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long
Private Declare Function SetFocus Lib "user32" (ByVal hWnd As Long) As Long
Private Declare Function SendMessageByString Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As String) As Long
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Function SendMessageLong& Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long)
Private Declare Function PtInRect Lib "user32" (lpRect As RECT, ByVal lLeft As Long, ByVal lTop As Long) As Long
Private lLong As Long
Private lParentText As String
Private lParenthWnd As String
Private lChildText As String
Private lChildHnwd As String
Private Const WM_CHAR = &H102
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type

Public Sub AlwaysOnTop(lForm As Form, lOnTop As Boolean)
On Local Error GoTo ErrHandler
Dim i As Integer
If lOnTop Then
    i = HWND_TOPMOST
Else
    i = HWND_NOTOPMOST
End If
SetWindowPos lForm.hWnd, i, lForm.Left / Screen.TwipsPerPixelX, lForm.Top / Screen.TwipsPerPixelY, lForm.Width / Screen.TwipsPerPixelX, lForm.Height / Screen.TwipsPerPixelY, SWP_NOACTIVATE Or SWP_SHOWWINDOW
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function GetCheckboxValue(lCheckbox As CheckBox) As Boolean
On Local Error GoTo ErrHandler
If lCheckbox.Value = 1 Then
    GetCheckboxValue = True
Else
    GetCheckboxValue = False
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Sub mIRCStatusSend(lData As String)
On Local Error GoTo ErrHandler
Dim l As Long, o As Long, n As Long, g As Long
l = FindWindow("mIRC", vbNullString)
o = FindWindowEx(l, 0&, "MdiClient", vbNullString)
n = FindWindowEx(o, 0&, "mIRC_Status", vbNullString)
g = FindWindowEx(n, 0&, "RichEdit20A", vbNullString)
Call SendMessageByString(g, WM_SETTEXT, 0&, lData)
If g = 0 Then Exit Sub
Do
    DoEvents
    l = FindWindow("mIRC", vbNullString)
    o = FindWindowEx(l, 0&, "MdiClient", vbNullString)
    n = FindWindowEx(o, 0&, "mIRC_Status", vbNullString)
    g = FindWindowEx(n, 0&, "RichEdit20A", vbNullString)
    Call SendMessageLong(g, WM_CHAR, 13, 0&)
Loop Until g <> 0
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub Pause(lInt)
On Local Error GoTo ErrHandler
Dim msg
msg = Timer
Do While Timer - msg < Val(lInt)
    DoEvents
Loop
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub SetChildWindowText(lText As String)
On Local Error GoTo ErrHandler
SetWindowText CLng(Trim(lChildHnwd)), lText
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub PutIn(lForm As Form)
On Local Error GoTo ErrHandler
Dim r As RECT
With r
    .Left = .Left - 4
    .Top = .Top - 4
    .Right = .Right + 4
    .Bottom = .Bottom + 4
End With
PtInRect r, lForm.Left, lForm.Top
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub SetWindowToChild(lWindowHwnd As Long, Optional lCaption As String)
On Local Error GoTo ErrHandler
SetWindowLong lWindowHwnd, GWL_STYLE, WS_CHILD
SetParent CLng(Trim(lWindowHwnd)), lParenthWnd
If Len(lCaption) = 0 Then
    SetWindowText CLng(Trim(lParenthWnd)), App.Title & " - v" & App.Major & "." & App.Revision
Else
    SetWindowText CLng(Trim(lParenthWnd)), lCaption
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub SetParentHwnd(lhWnd As Long)
On Local Error GoTo ErrHandler
lParenthWnd = Str(lhWnd)
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub SetChildHWND(lhWnd As Long)
On Local Error Resume Next
lChildHnwd = Str(lhWnd)
End Sub

Public Sub ClearWindowStuff()
On Local Error GoTo ErrHandler
lLong = 0
lParenthWnd = ""
lParentText = ""
lChildHnwd = ""
lChildText = ""
ErrHandler:
    Err.Clear
End Sub

Public Function SetWindowFocus(lhWnd As Long)
On Local Error GoTo ErrHandler
SetFocus lhWnd
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ShowNonModalForm(lForm As Form) As Boolean
On Local Error GoTo ErrHandler
ShowWindow lForm.hWnd, 1
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function GetParentVersion() As String
On Local Error GoTo ErrHandler
Dim c As Long, l As Long, msg As String
l = GetWindowTextLength(lParenthWnd)
msg = Space$(l + 1)
l = GetWindowText(lParenthWnd, msg, l + 1)
msg = Left$(msg, Len(msg) - 1)
GetParentVersion = Right(msg, Len(msg) - 25)
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ReturnChildWindowHwnd() As Long
On Local Error GoTo ErrHandler
ReturnChildWindowHwnd = lChildHnwd
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ReturnParentWindowHwnd() As Long
On Local Error GoTo ErrHandler
ReturnParentWindowHwnd = lParenthWnd
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function SetParentWindowFunction(lSetAsParent As Boolean, lParentCaption As String, lChildCaption As String, lForm As Form) As Boolean
On Local Error Resume Next
Dim l As Long, o As Long
If Len(lParentCaption) <> 0 Then
    If lSetAsParent = True Then
        lParentText = lParentCaption
        l = EnumWindows(AddressOf CheckWindows, lForm)
        lChildText = lChildCaption
        o = EnumChildWindows(lParenthWnd, AddressOf CheckChildWindow, l)
        SetParent lForm.hWnd, lChildHnwd
        SetWindowPosition CLng(lChildHnwd), 0, 0, ReturnMainFormWidth / Screen.TwipsPerPixelX, ReturnMainFormHeight / Screen.TwipsPerPixelY + 27
    ElseIf lSetAsParent = False Then
        SetParent lChildHnwd, 0
    End If
End If
End Function

Public Function SetWindowPosition(lhWnd As Long, lLeft As Long, lTop As Long, lWidth As Long, lHeight As Long) As Boolean
On Local Error GoTo ErrHandler
SetWindowPos lhWnd, 0, lLeft, lTop, lWidth, lHeight, 0
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function IsParentChildOpen() As Boolean
On Local Error GoTo ErrHandler
lChildHnwd = 0
lLong = EnumChildWindows(lParenthWnd, AddressOf CheckChildWindow, 0)
If lChildHnwd = 0 Then
    IsParentChildOpen = False
Else
    IsParentChildOpen = True
End If
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ReturnParentHwnd() As Long
On Local Error GoTo ErrHandler
ReturnParentHwnd = lParenthWnd
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Private Function CheckWindows(ByVal lhWnd As Long, ByVal lForm As Form) As Long
On Local Error Resume Next
Dim msg As String * 512, lRet As Long, lLen As Long, lClass As String * 50
lLen = GetWindowTextLength(lhWnd)
lRet = GetWindowText(lhWnd, msg, lLen + 1)
GetClassName lhWnd, lClass, 50
If lLen <> 0 Then
    msg = Trim(msg)
    If InStr(1, LCase(msg), lParentText, vbTextCompare) Then lParenthWnd = lhWnd
End If
CheckWindows = 1
End Function

Private Function CheckChildWindow(ByVal lhWnd As Long) As Long
On Local Error Resume Next
Dim lRet As Long, msg As String * 50
lRet = GetClassName(lhWnd, msg, 50)
If Trim(LCase(lChildText)) = Trim(LCase(GetText(lhWnd))) Then lChildHnwd = lhWnd
CheckChildWindow = 1
If Err.Number <> 0 Then Err.Clear
End Function

Private Function GetText(lhWnd As Long) As String
On Local Error Resume Next
Dim lLen As Long, lText As String
lLen = SendMessage(lhWnd, WM_GETTEXTLENGTH, 0, 0)
If lLen = 0 Then
    GetText = "Nothing"
    Exit Function
End If
lLen = lLen + 1
lText = Space(lLen)
lLen = SendMessage(lhWnd, WM_GETTEXT, lLen, ByVal lText)
GetText = Left(lText, lLen)
If Err.Number <> 0 Then
    Err.Clear
End If
End Function
