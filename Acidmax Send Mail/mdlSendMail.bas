Attribute VB_Name = "mdlSendMail"
Option Explicit
Private Declare Function ShowWindow Lib "user32" (ByVal hWnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function SetFocus Lib "user32" (ByVal hWnd As Long) As Long
Private lAcidmaxEXE As String
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Function SendMessageLong& Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long)
Private Declare Function SendMessageByString Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As String) As Long
Private Const WM_SETTEXT = &HC
Private Const WM_CHAR = &H102
Private Declare Sub ReleaseCapture Lib "user32" ()
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Integer, ByVal lParam As Long) As Long

Public Function ReadFile(lFile As String) As String
On Local Error GoTo ErrHandler
Dim n As Integer, msg As String
n = FreeFile
If Len(lFile) <> 0 Then
    Open lFile For Input As #n
        msg = StrConv(InputB(LOF(n), n), vbUnicode)
        If Len(msg) <> 0 Then
            ReadFile = Left(msg, Len(msg) - 2)
        End If
    Close #n
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Sub FormDrag(lForm As Form)
On Local Error GoTo ErrHandler
ReleaseCapture
Call SendMessage(lForm.hWnd, &HA1, 2, 0&)
DoEvents
'SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function DoesFileExist(lFilename As String) As Boolean
On Local Error GoTo ErrHandler
Dim msg As String
msg = Dir(lFilename)
If msg <> "" Then
    DoesFileExist = True
Else
    DoesFileExist = False
End If
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function GetFileTitle(lFilename As String) As String
On Local Error GoTo ErrHandler
Dim msg() As String
If Len(lFilename) <> 0 Then
    msg = Split(lFilename, "\", -1, vbTextCompare)
    GetFileTitle = msg(UBound(msg))
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Function ReturnAcidmaxPath() As String
On Local Error GoTo ErrHandler
ReturnAcidmaxPath = Replace(lAcidmaxEXE, "mirc.exe", "")
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function
