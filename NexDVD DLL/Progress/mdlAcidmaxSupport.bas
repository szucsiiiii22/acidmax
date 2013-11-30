Attribute VB_Name = "mdlAcidmaxSupport"
'Attribute VB_Name = "mdlAcidmaxSupport"
Public Declare Function ReleaseCapture Lib "user32" () As Long
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Declare Function SetParent Lib "user32.dll" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Public Declare Function EnumWindows Lib "user32" (ByVal lpEnumFunc As Long, ByVal lParam As Any) As Long
Public Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hwnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long
Public Declare Function GetWindowTextLength Lib "user32" Alias "GetWindowTextLengthA" (ByVal hwnd As Long) As Long
Public Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Global lAcidmaxHwnd As Long

'Public Function WndEnumProc(ByVal hwnd As Long, ByVal lParam As Form) As Long
'On Local Error Resume Next
'Dim WText As String * 512, bRet As Long, WLen As Long, WClass As String * 50
'WLen = GetWindowTextLength(hwnd)
'bRet = GetWindowText(hwnd, WText, WLen + 1)
'GetClassName hwnd, WClass, 50
'If WLen <> 0 Then
'    WText = Trim(WText)
'    MsgBox WText
'    If InStr(1, LCase(WText), "Nexgen Acidmax", vbTextCompare) Then
'        Stop
'        lAcidmaxHwnd = hwnd
'    End If
'End If
'If Len(hwnd) = 0 Then
'    MsgBox "Nexgen Acidmax was not found, " & App.Title & " must terminate", vbOKOnly + vbExclamation
'    End
'End If
'End Function

Public Function WndEnumProc(ByVal hwnd As Long, ByVal lParam As Form) As Long
On Local Error Resume Next
Dim WText As String * 512, bRet As Long, WLen As Long, WClass As String * 50
WLen = GetWindowTextLength(hwnd)
bRet = GetWindowText(hwnd, WText, WLen + 1)
GetClassName hwnd, WClass, 50
If WLen <> 0 Then
    WText = Trim(WText)
    If InStr(1, LCase(WText), "Nexgen Acidmax", vbTextCompare) Then
        lAcidmaxHwnd = hwnd
    End If
End If
WndEnumProc = 1
End Function

Public Sub SetAcidmaxHwnd(lForm As Form)
Dim l As Long
l = EnumWindows(AddressOf WndEnumProc, lForm)
End Sub

Public Sub SetParentAcidmax(lForm As Form)
SetAcidmaxHwnd lForm
If lAcidmaxHwnd <> 0 Then
    SetParent lForm.hwnd, lAcidmaxHwnd
Else
    MsgBox "Nexgen Acidmax is not loaded. Click 'OK' to terminate program", vbExclamation
    End
End If
End Sub

