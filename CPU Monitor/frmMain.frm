VERSION 5.00
Begin VB.Form frmMain 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00FF00FF&
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   270
   ClientLeft      =   7500
   ClientTop       =   105
   ClientWidth     =   6885
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   18
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   459
   ShowInTaskbar   =   0   'False
   Begin VB.Timer tmrFocusOnce 
      Enabled         =   0   'False
      Interval        =   200
      Left            =   2400
      Top             =   0
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   400
      Left            =   0
      Top             =   0
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Private Const HWND_NOTOPMOST = -2
Private Const HWND_TOPMOST = -1
Private Const SWP_NOACTIVATE = &H10
Private Const SWP_SHOWWINDOW = &H40
Private Declare Function LineTo Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long) As Long
Private Declare Function MoveToEx Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, lpPoint As POINTAPI) As Long
Private Declare Function SetPixel Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal crColor As Long) As Long
Private Declare Function SetTextColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
Private Declare Function TextOut Lib "gdi32" Alias "TextOutA" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal lpString As String, ByVal nCount As Long) As Long
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Long) As Long
Private Declare Function Rectangle Lib "gdi32" (ByVal hdc As Long, ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Private Declare Sub GlobalMemoryStatus Lib "kernel32" (lpBuffer As MEMORYSTATUS)
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Sub ReleaseCapture Lib "user32" ()
Private Const CCM_FIRST = &H2000
Private Const CCM_SETBKCOLOR = (CCM_FIRST + 1)
Private Const PBM_SETBKCOLOR = CCM_SETBKCOLOR
Private Const WM_USER = &H400
Private Const PBM_SETBARCOLOR = (WM_USER + 9)
Private m_oclsCPUMonitor As clsCPUMonitor
Private m_lCPUs As Long
Private vbDGr As Long
Private vbLGr As Long
Private Type MEMORYSTATUS
    dwLength As Long
    dwMemoryLoad As Long
    dwTotalPhys As Long
    dwAvailPhys As Long
    dwTotalPageFile As Long
    dwAvailPageFile As Long
    dwTotalVirtual As Long
    dwAvailVirtual As Long
End Type
Private Type POINTAPI
    X As Long
    Y As Long
End Type
Private Const SWP_NOMOVE = &H2, SWP_NOSIZE = &H1
'Private Const HWND_TOPMOST = -1, HWND_NOTOPMOST = -2
Private Const SC_CLICKMOVE = &HF012&
Private Const WM_SYSCOMMAND = &H112

Public Sub AlwaysOnTop(myfrm As Form, SetOnTop As Boolean)
On Local Error Resume Next
Dim lFlag As Integer
If SetOnTop Then
    lFlag = HWND_TOPMOST
Else
    lFlag = HWND_NOTOPMOST
End If
SetWindowPos myfrm.hwnd, lFlag, myfrm.Left / Screen.TwipsPerPixelX, myfrm.Top / Screen.TwipsPerPixelY, myfrm.Width / Screen.TwipsPerPixelX, myfrm.Height / Screen.TwipsPerPixelY, SWP_NOACTIVATE Or SWP_SHOWWINDOW
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
'Const WM_NCLBUTTONDOWN = &HA1
'Const HTCAPTION = 2
'If Button = 1 Then
'    ReleaseCapture
'    SendMessage Me.hWnd, WM_NCLBUTTONDOWN, HTCAPTION, 0&
'End If
End Sub

Sub SetTopmostWindow(ByVal hwnd As Long, Optional topmost As Boolean = True)
On Local Error Resume Next
Const HWND_NOTOPMOST = -2
Const HWND_TOPMOST = -1
Const SWP_NOMOVE = &H2
Const SWP_NOSIZE = &H1
SetWindowPos hwnd, IIf(topmost, HWND_TOPMOST, HWND_NOTOPMOST), 0, 0, 0, 0, _
    SWP_NOMOVE + SWP_NOSIZE
End Sub

Private Sub Form_Click()
On Local Error Resume Next
AlwaysOnTop Me, True
SetWindowFocus ReturnChildWindowHwnd
'If MsgBox("End program?", vbYesNo + vbQuestion, App.Title) = vbYes Then Unload Me
End Sub

Sub FrmTextOut(FormIn As Form, sIn As String, xPos As Integer, yPos As Integer, lColor As Long)
On Local Error Resume Next
SetTextColor FormIn.hdc, vbBlack
TextOut FormIn.hdc, xPos + 1, yPos + 1, sIn, Len(sIn)
TextOut FormIn.hdc, xPos - 1, yPos - 1, sIn, Len(sIn)
TextOut FormIn.hdc, xPos - 1, yPos + 1, sIn, Len(sIn)
TextOut FormIn.hdc, xPos + 1, yPos - 1, sIn, Len(sIn)
TextOut FormIn.hdc, xPos - 1, yPos, sIn, Len(sIn)
TextOut FormIn.hdc, xPos + 1, yPos, sIn, Len(sIn)
SetTextColor FormIn.hdc, lColor
TextOut FormIn.hdc, xPos, yPos, sIn, Len(sIn)
End Sub

Private Sub Form_Load()
On Local Error Resume Next
'SetWindowToChild Me.hWnd
SetNewParentHwnd Me.hwnd, FindmIRCHwnd
vbLGr = RGB(255, 255, 255)
vbDGr = RGB(0, 0, 0)
FrmTextOut Me, "Physical", 2, 2, vbLGr
FrmTextOut Me, "Virtual", 160, 2, vbLGr
FrmTextOut Me, "CPU1", 307, 2, vbLGr
DrawProgressBar Me, 54, 2, 154, 15, 0, vbDGr, vbLGr, 0
DrawProgressBar Me, 201, 2, 301, 15, 0, vbDGr, vbLGr, 0
DrawProgressBar Me, 342, 2, 442, 15, 0, vbDGr, vbLGr, 0
SetColorTransparent frmMain, RGB(255, 0, 255)
SetTopmostWindow Me.hwnd
InitCPU
Timer1.Enabled = True
SetWindowFocus ReturnChildWindowHwnd
tmrFocusOnce.Enabled = True
End Sub

Sub DrawProgressBar(frmIn As Form, X1 As Long, Y1 As Long, X2 As Long, Y2 As Long, lBgCol As Long, lPbBg As Long, lPbFg As Long, lPerc As Long)
On Local Error Resume Next
Dim hRPen As Long, Y As Long, lPercEndPos As Long, Point As POINTAPI
frmIn.ForeColor = lBgCol
hRPen = CreateSolidBrush(lBgCol)
SelectObject frmIn.hdc, hRPen
Rectangle frmIn.hdc, X1, Y1, X2, Y2
DeleteObject hRPen
SetPixel frmIn.hdc, X1, Y1, RGB(255, 0, 255)
SetPixel frmIn.hdc, X2 - 1, Y1, RGB(255, 0, 255)
SetPixel frmIn.hdc, X1, Y2 - 1, RGB(255, 0, 255)
SetPixel frmIn.hdc, X2 - 1, Y2 - 1, RGB(255, 0, 255)
If lPerc = 100 Then
    frmIn.ForeColor = &H6050FF
Else
    frmIn.ForeColor = lPbBg
End If
For Y = Y1 + 2 To Y2 - 3 Step 2
    Point.X = X1 + 2: Point.Y = Y
    MoveToEx frmIn.hdc, X1 + 2, Y, Point
    LineTo frmIn.hdc, X2 - 2, Y
Next
If lPerc = 0 Or lPerc = 100 Then GoTo LastBit
lPercEndPos = (((X2 - X1 - 4) / 100) * lPerc) + X1 + 2
If lPerc > 95 Then
    frmIn.ForeColor = &H6050FF
ElseIf lPerc > 85 Then
    frmIn.ForeColor = &HC0FFFF
Else
    frmIn.ForeColor = lPbFg
End If
For Y = Y1 + 2 To Y2 - 3 Step 2
    Point.X = X1 + 2: Point.Y = Y
    MoveToEx frmIn.hdc, X1 + 2, Y, Point
    LineTo frmIn.hdc, lPercEndPos, Y
Next
LastBit:
Me.Refresh
DoEvents
End Sub

Public Function GetMEMORY() As Long()
On Local Error Resume Next
Dim memsts As MEMORYSTATUS, RetMem(2) As Long
GlobalMemoryStatus memsts
RetMem(0) = Int((100 / memsts.dwTotalPhys) * (memsts.dwTotalPhys - memsts.dwAvailPhys))
RetMem(1) = Int((100 / memsts.dwTotalVirtual) * (memsts.dwTotalVirtual - memsts.dwAvailVirtual))
GetMEMORY = RetMem
End Function

Private Sub InitCPU()
On Local Error Resume Next
Dim i As Long
Const lOffset As Long = 30
Set m_oclsCPUMonitor = New clsCPUMonitor
m_lCPUs = m_oclsCPUMonitor.GetCPUCount
End Sub

Public Function ReturnCPUPercent(lCPU As Long) As Single
On Local Error Resume Next
m_oclsCPUMonitor.CollectCPUData
ReturnCPUPercent = m_oclsCPUMonitor.GetCPUUsage(lCPU)
End Function

Private Sub Form_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
Set m_oclsCPUMonitor = Nothing
End Sub

Private Sub Timer1_Timer()
On Local Error Resume Next
Dim rMEM() As Long
rMEM = GetMEMORY
DrawProgressBar Me, 54, 2, 154, 15, 0, vbDGr, vbLGr, rMEM(0)
DrawProgressBar Me, 201, 2, 301, 15, 0, vbDGr, vbLGr, rMEM(1)
DrawProgressBar Me, 342, 2, 442, 15, 0, vbDGr, vbLGr, ReturnCPUPercent(1)
End Sub

Private Sub tmrFocusOnce_Timer()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
tmrFocusOnce.Enabled = False
End Sub
