VERSION 5.00
Begin VB.Form frmMain2 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "control panel"
   ClientHeight    =   5565
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   7665
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmMain2.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   MouseIcon       =   "frmMain2.frx":000C
   ScaleHeight     =   371
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   511
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
End
Attribute VB_Name = "frmMain2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Const WM_SETTEXT = &HC
Private Const WM_CHAR = &H102
Private Const WM_GETTEXTLENGTH = &HE
Private Const WM_GETTEXT = &HD
Private Declare Function SendMessageLong& Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long)
Private Declare Function SendMessageByString Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As String) As Long
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Sub ReleaseCapture Lib "user32" ()
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Integer, ByVal lParam As Long) As Long
Private Declare Function SetParent Lib "user32.dll" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Private Enum eWindowThemes
    wWindowClassic = 1
    wWindowXP = 2
End Enum
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type
Private Declare Function GetWindowRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT) As Long
Private lVarRect As RECT, lVarLong As Long
Private lTitleBarHeight As Long

Sub GetWindowSize(ByVal hWnd As Long, Width As Long, Height As Long)
'On Local Error Resume Next
Dim rc As RECT
GetWindowRect hWnd, rc
Width = rc.Right - rc.Left
Height = rc.Bottom - rc.Top
End Sub

Public Function DoesFileExist(lFileName As String) As Boolean
'On Local Error Resume Next
Dim msg As String
msg = Dir(lFileName)
If msg <> "" Then
    DoesFileExist = True
Else
    DoesFileExist = False
End If
End Function

Public Function ReadFile(lFile As String) As String
'On Local Error Resume Next
Dim n As Integer, msg As String
n = FreeFile
If DoesFileExist(lFile) = True Then
    Open lFile For Input As #n
        msg = StrConv(InputB(LOF(n), n), vbUnicode)
        If Len(msg) <> 0 Then
            ReadFile = Left(msg, Len(msg) - 2)
        End If
    Close #n
End If
End Function

Public Function GetFileTitle(lFileName As String) As String
'On Local Error Resume Next
Dim msg() As String
If Len(lFileName) <> 0 Then
    msg = Split(lFileName, "\", -1, vbTextCompare)
    GetFileTitle = msg(UBound(msg))
End If
End Function

Public Sub FormDrag(lForm As Form)
'On Local Error GoTo ErrHandler
ReleaseCapture
Call SendMessage(lForm.hWnd, &HA1, 2, 0&)
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub Form_Load()
'On Local Error Resume Next
lTitleBarHeight = ReturnWindowTitleBarHeight(ReturnParentWindow)
SetWindowToChild Me.hWnd
'If Err.Number <> 0 Then Err.Clear
End Sub

Private Sub Form_Unload(Cancel As Integer)
'On Local Error GoTo ErrHandler
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Sub mIRCStatusSend(lData As String)
'On Local Error Resume Next
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
