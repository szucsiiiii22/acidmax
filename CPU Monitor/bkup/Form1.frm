VERSION 5.00
Begin VB.Form frmMain 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00FF00FF&
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   270
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6885
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   18
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   459
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   700
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
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long

Private Declare Sub ReleaseCapture Lib "user32" ()

Private Const CCM_FIRST = &H2000
Private Const CCM_SETBKCOLOR = (CCM_FIRST + 1)
Private Const PBM_SETBKCOLOR = CCM_SETBKCOLOR
Private Const WM_USER = &H400
Private Const PBM_SETBARCOLOR = (WM_USER + 9)
Private m_oCPULoad As CPULoad
Private m_lCPUs As Long
Dim vbDGr As Long
Dim vbLGr As Long

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, _
    Y As Single)
    Const WM_NCLBUTTONDOWN = &HA1
    Const HTCAPTION = 2
    If Button = 1 Then
        ReleaseCapture
        SendMessage Me.hWnd, WM_NCLBUTTONDOWN, HTCAPTION, 0&
    End If
End Sub
Sub SetTopmostWindow(ByVal hWnd As Long, Optional topmost As Boolean = True)
    Const HWND_NOTOPMOST = -2
    Const HWND_TOPMOST = -1
    Const SWP_NOMOVE = &H2
    Const SWP_NOSIZE = &H1
    SetWindowPos hWnd, IIf(topmost, HWND_TOPMOST, HWND_NOTOPMOST), 0, 0, 0, 0, _
        SWP_NOMOVE + SWP_NOSIZE
End Sub

Private Sub Form_Click()
    'Unload Me
End Sub
Sub FrmTextOut(FormIn As Form, sIn As String, xPos As Integer, yPos As Integer, lColor As Long)
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

    vbLGr = RGB(100, 200, 130)
    vbDGr = RGB(30, 60, 30)

    FrmTextOut Me, "Physical", 2, 2, vbLGr
    FrmTextOut Me, "Virtual", 160, 2, vbLGr
    FrmTextOut Me, "CPU1", 307, 2, vbLGr
    
    DrawProgressBar Me, 54, 2, 154, 15, 0, vbDGr, vbLGr, 0
    DrawProgressBar Me, 201, 2, 301, 15, 0, vbDGr, vbLGr, 0
    DrawProgressBar Me, 342, 2, 442, 15, 0, vbDGr, vbLGr, 0
    
    SetColorTransparent Form1, RGB(255, 0, 255)
    
    SetTopmostWindow Me.hWnd
    
    Me.Top = 10
    Me.Left = Screen.Width - (Me.Width * 1.1)
    
    InitCPU
    
    Timer1.Enabled = True
End Sub
Sub DrawProgressBar(frmIn As Form, X1 As Long, Y1 As Long, X2 As Long, Y2 As Long, lBgCol As Long, lPbBg As Long, lPbFg As Long, lPerc As Long)
Dim hRPen As Long
Dim Y As Long
Dim lPercEndPos As Long
Dim Point As POINTAPI
    
    frmIn.ForeColor = lBgCol
    'draw background
    hRPen = CreateSolidBrush(lBgCol)
    SelectObject frmIn.hdc, hRPen
    Rectangle frmIn.hdc, X1, Y1, X2, Y2
    DeleteObject hRPen
    
    'blank out corner pixels
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
Function GetMEMORY() As Long()
Dim memsts As MEMORYSTATUS
Dim RetMem(2) As Long


    GlobalMemoryStatus memsts
    RetMem(0) = Int((100 / memsts.dwTotalPhys) * (memsts.dwTotalPhys - memsts.dwAvailPhys))
    RetMem(1) = Int((100 / memsts.dwTotalVirtual) * (memsts.dwTotalVirtual - memsts.dwAvailVirtual))

    GetMEMORY = RetMem
End Function



Private Sub InitCPU()
Dim i As Long
Const lOffset As Long = 30
    
    Set m_oCPULoad = New CPULoad
    m_lCPUs = m_oCPULoad.GetCPUCount
        
End Sub

Private Function ReturnCPUPercent(lCPU As Long) As Single
    m_oCPULoad.CollectCPUData
    ReturnCPUPercent = m_oCPULoad.GetCPUUsage(lCPU)
End Function

Private Sub Form_Unload(Cancel As Integer)
    Set m_oCPULoad = Nothing
    
End Sub

Private Sub Timer1_Timer()
Dim rMEM() As Long
    rMEM = GetMEMORY
    DrawProgressBar Me, 54, 2, 154, 15, 0, vbDGr, vbLGr, rMEM(0)
    DrawProgressBar Me, 201, 2, 301, 15, 0, vbDGr, vbLGr, rMEM(1)
    DrawProgressBar Me, 342, 2, 442, 15, 0, vbDGr, vbLGr, ReturnCPUPercent(1)
End Sub
