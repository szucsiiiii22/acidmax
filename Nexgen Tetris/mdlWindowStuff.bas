Attribute VB_Name = "mdlWindowStuff"
Option Explicit
Private Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Private Declare Function GetWindowTextLength Lib "user32" Alias "GetWindowTextLengthA" (ByVal hwnd As Long) As Long
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Function EnumWindows Lib "user32" (ByVal lpEnumFunc As Long, ByVal lParam As Any) As Long
Private Declare Function EnumChildWindows Lib "user32" (ByVal hwndParent As Long, ByVal lpEnumFunc As Long, ByVal lParam As Any) As Long
Private Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hwnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long
Private Const WM_GETTEXT = &HD
Private Const WM_SETTEXT = &HC
Private lCaption As String
Private lRetrievedHwnd As Long
Private Const WM_GETTEXTLENGTH = &HE

Public Function GetText(lHwnd As Long) As String
On Local Error Resume Next
Dim l As Long, lText As String
l = SendMessage(lHwnd, WM_GETTEXTLENGTH, 0, 0)
If l = 0 Then
    GetText = ""
    Exit Function
End If
l = l + 1
lText = Space(l)
l = SendMessage(lHwnd, WM_GETTEXT, l, ByVal lText)
GetText = Left(lText, l)
End Function

Public Function SetProgramsText(lHwnd As Long, lText As String)
On Local Error Resume Next
If Len(lText) <> 0 Then SendMessage lHwnd, WM_SETTEXT, 0, ByVal lText
End Function

Private Function WndEnumProc(ByVal lHwnd As Long, ByVal lParam As Form) As Long
On Local Error Resume Next
Dim lText As String * 512, lRet As Long, l As Long, lClass As String * 50
l = GetWindowTextLength(lHwnd)
lRet = GetWindowText(lHwnd, lText, l + 1)
GetClassName lHwnd, lClass, 50
If l <> 0 Then
    lText = Trim(lText)
    If InStr(1, LCase(lText), lCaption, vbTextCompare) Then lRetrievedHwnd = lHwnd
End If
WndEnumProc = 1
End Function

Public Function ReturnWindowHwnd(lText As String, lListBox As ListBox) As Long
On Local Error Resume Next
Dim l As Long
lCaption = lText
l = EnumWindows(AddressOf WndEnumProc, frmMain)
ReturnWindowHwnd = lRetrievedHwnd
End Function
