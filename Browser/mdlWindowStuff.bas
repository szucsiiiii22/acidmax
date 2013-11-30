Attribute VB_Name = "mdlWindowStuff"
Option Explicit
Private Const GWL_WNDPROC = (-4)
Private Const GWL_STYLE = -16
Private Const WS_CHILD = &H40000000
Private Const WS_POPUP = &H80000000
Private Const WS_DLGFRAME = &H400000
Private Const WS_SIZEBOX = &H40000
Private Const WS_CHILDWINDOW = (WS_CHILD)
Private Const WS_BORDER = &H800000
Private Const WS_OVERLAPPED = &H0&
Private Const WS_CAPTION = &HC00000
Private Const WS_SYSMENU = &H80000
Private Const WS_EX_CLIENTEDGE = &H200&
Private Const WS_THICKFRAME = &H40000
Private Const WS_MINIMIZEBOX = &H20000
Private Const WS_MAXIMIZEBOX = &H10000
Private Const WS_OVERLAPPEDWINDOW = (WS_OVERLAPPED Or WS_CAPTION Or WS_SYSMENU Or WS_THICKFRAME Or WS_MINIMIZEBOX Or WS_MAXIMIZEBOX)
Private Const WS_MIRCCHILD = (WS_CHILD Or WS_CAPTION Or WS_SYSMENU Or WS_DLGFRAME Or WS_MINIMIZEBOX Or WS_MAXIMIZEBOX)

Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long) As Long
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function SetWindowText Lib "user32" Alias "SetWindowTextA" (ByVal hWnd As Long, ByVal lpString As String) As Long
Private Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal Cx As Long, ByVal Cy As Long, ByVal wFlags As Long) As Long
Private Declare Function ShowWindow Lib "user32" (ByVal hWnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Function EnumChildWindows Lib "user32" (ByVal hWndParent As Long, ByVal lpEnumFunc As Long, ByVal lParam As Long) As Long
Private Declare Function EnumWindows Lib "user32" (ByVal lpEnumFunc As Long, ByVal lParam As Any) As Long
Private Declare Function SetParent Lib "user32.dll" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Private Declare Function GetWindowTextLength Lib "user32" Alias "GetWindowTextLengthA" (ByVal hWnd As Long) As Long
Private Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hWnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Private Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hWnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long
Private Declare Function SetFocus Lib "user32" (ByVal hWnd As Long) As Long
Private Declare Function MakeModal& Lib "dsmodal" (ByVal AppHwnd&, ByVal hwndDest&, Optional ByVal Beep& = 0)

Private Const WM_SETTEXT = &HC
Private Const WM_GETTEXTLENGTH = &HE
Private Const WM_GETTEXT = &HD
Private lLong As Long
Private lParentText As String
Private lParenthWnd As String
Private lChildText As String
Private lChildHnwd As String
Private Declare Function SendMessageByString Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As String) As Long
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Const WM_CHAR = &H102
Private Declare Function SendMessageLong& Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long)

Public Function GetCheckboxValue(lCheckbox As CheckBox) As Boolean
On Local Error Resume Next
If lCheckbox.Value = 1 Then
    GetCheckboxValue = True
Else
    GetCheckboxValue = False
End If
End Function

Public Sub mIRCSend(lCommand As String)
On Local Error GoTo ErrHandler
Dim mirc As Long, mdiclient As Long, mircchannel As Long, editx As Long
mirc = FindWindow("mirc", vbNullString)
mdiclient = FindWindowEx(mirc, 0&, "mdiclient", vbNullString)
mircchannel = FindWindowEx(mdiclient, 0&, "mirc_status", vbNullString)
editx = FindWindowEx(mircchannel, 0&, "edit", vbNullString)
Call SendMessageByString(editx, WM_SETTEXT, 0&, lCommand)
If editx = 0 Then Exit Sub
Do
    DoEvents
    mirc = FindWindow("mirc", vbNullString)
    mdiclient = FindWindowEx(mirc, 0&, "mdiclient", vbNullString)
    mircchannel = FindWindowEx(mdiclient, 0&, "mirc_status", vbNullString)
    editx = FindWindowEx(mircchannel, 0&, "edit", vbNullString)
    Call SendMessageLong(editx, WM_CHAR, 13, 0&)
Loop Until editx <> 0
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Public Sub SetChildWindowText(lText As String)
On Local Error Resume Next
SetWindowText CLng(Trim(lChildHnwd)), lText
End Sub

Public Function ReturnParentWindow() As Long
On Local Error Resume Next
ReturnParentWindow = lParenthWnd
End Function

Public Sub SetWindowToChild(lWindowHwnd As Long)
On Local Error Resume Next
Dim l As Long
SetWindowLong lWindowHwnd, GWL_STYLE, WS_CHILD
SetParent CLng(Trim(lWindowHwnd)), lParenthWnd
SetWindowText CLng(Trim(lParenthWnd)), "acidmax browser"
If Err.Number <> 0 Then Err.Clear
End Sub

Public Sub SetParentHwnd(lHwnd As Long)
On Local Error Resume Next
lParenthWnd = Str(lHwnd)
If Err.Number <> 0 Then Err.Clear
End Sub

Public Sub SetChildHWND(lHwnd As Long)
On Local Error Resume Next
lChildHnwd = Str(lHwnd)
End Sub

Public Sub ClearWindowStuff()
On Local Error Resume Next
lLong = 0
lParenthWnd = ""
lParentText = ""
lChildHnwd = ""
lChildText = ""
If Err.Number <> 0 Then Err.Clear
End Sub

Public Function SetWindowFocus(lHwnd As Long)
On Local Error GoTo ErrHandler
SetFocus lHwnd
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

Public Function SetWindowPosition(lHwnd As Long, lLeft As Long, lTop As Long, lWidth As Long, lHeight As Long) As Boolean
On Local Error GoTo ErrHandler
SetWindowPos lHwnd, 0, lLeft, lTop, lWidth, lHeight, 0
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

Private Function CheckWindows(ByVal lHwnd As Long, ByVal lForm As Form) As Long
On Local Error Resume Next
Dim msg As String * 512, lRet As Long, lLen As Long, lClass As String * 50
lLen = GetWindowTextLength(lHwnd)
lRet = GetWindowText(lHwnd, msg, lLen + 1)
GetClassName lHwnd, lClass, 50
If lLen <> 0 Then
    msg = Trim(msg)
    If InStr(1, LCase(msg), lParentText, vbTextCompare) Then lParenthWnd = lHwnd
End If
CheckWindows = 1
End Function

Private Function CheckChildWindow(ByVal lHwnd As Long) As Long
On Local Error Resume Next
Dim lRet As Long, msg As String * 50
lRet = GetClassName(lHwnd, msg, 50)
If Trim(LCase(lChildText)) = Trim(LCase(GetText(lHwnd))) Then lChildHnwd = lHwnd
CheckChildWindow = 1
If Err.Number <> 0 Then Err.Clear
End Function

Private Function GetText(lHwnd As Long) As String
On Local Error Resume Next
Dim lLen As Long, lText As String
lLen = SendMessage(lHwnd, WM_GETTEXTLENGTH, 0, 0)
If lLen = 0 Then
    GetText = "Nothing"
    Exit Function
End If
lLen = lLen + 1
lText = Space(lLen)
lLen = SendMessage(lHwnd, WM_GETTEXT, lLen, ByVal lText)
GetText = Left(lText, lLen)
If Err.Number <> 0 Then
    Err.Clear
End If
End Function
