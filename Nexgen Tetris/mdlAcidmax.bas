Attribute VB_Name = "mdlAcidmax"
Private Declare Function SetParent Lib "user32.dll" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Private Declare Function EnumWindows Lib "user32" (ByVal lpEnumFunc As Long, ByVal lParam As Any) As Long
Private Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hwnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long
Private Declare Function GetWindowTextLength Lib "user32" Alias "GetWindowTextLengthA" (ByVal hwnd As Long) As Long
Private Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Private lAcidmaxHwnd As Long
Private lSearchString As String

Private Function WndEnumProc(ByVal hwnd As Long, ByVal lParam As Form) As Long
On Local Error Resume Next
Dim WText As String * 512, bRet As Long, WLen As Long, WClass As String * 50
WLen = GetWindowTextLength(hwnd)
bRet = GetWindowText(hwnd, WText, WLen + 1)
GetClassName hwnd, WClass, 50
If WLen <> 0 Then
    WText = Trim(WText)
    If InStr(1, LCase(WText), lSearchString, vbTextCompare) Then
        lAcidmaxHwnd = hwnd
    End If
End If
WndEnumProc = 1
End Function

Private Sub SetAcidmaxHwnd(lForm As Form)
On Local Error Resume Next
Dim l As Long
l = EnumWindows(AddressOf WndEnumProc, lForm)
End Sub

Public Sub SetParentAcidmax(lForm As Form)
On Local Error Resume Next
Dim mbox As VbMsgBoxResult
lSearchString = "Nexgen Acidmax"
SetAcidmaxHwnd lForm
If lAcidmaxHwnd <> 0 Then
    SetParent lForm.hwnd, lAcidmaxHwnd
Else
    mbox = MsgBox("System Stats could not locate Nexgen Acidmax. Would you like to specify another parent window?", vbYesNo + vbQuestion)
    If mbox = vbYes Then
        lSearchString = InputBox("Enter Window Caption", "System Stats", "mIRC")
        If Len(lSearchString) <> 0 Then
            SetAcidmaxHwnd lForm
            If lAcidmaxHwnd <> 0 Then
                SetParent lForm.hwnd, lAcidmaxHwnd
            Else
                Exit Sub
            End If
        End If
    Else
        End
    End If
End If
End Sub
