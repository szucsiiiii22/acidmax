VERSION 5.00
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "shdocvw.dll"
Begin VB.Form frmMain 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   ClientHeight    =   4905
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   8310
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
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MouseIcon       =   "frmMain.frx":000C
   Picture         =   "frmMain.frx":015E
   ScaleHeight     =   327
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   554
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.Timer tmrResize 
      Interval        =   100
      Left            =   0
      Top             =   0
   End
   Begin VB.PictureBox picBottom 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   330
      Left            =   0
      ScaleHeight     =   330
      ScaleWidth      =   8295
      TabIndex        =   4
      Top             =   4560
      Width           =   8295
      Begin AB.XP_ProgressBar ctlProg 
         Height          =   255
         Left            =   5760
         TabIndex        =   5
         Top             =   30
         Width           =   2415
         _ExtentX        =   3413
         _ExtentY        =   450
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BrushStyle      =   0
         Color           =   4194304
         Scrolling       =   9
         Value           =   55
      End
      Begin VB.Line Line1 
         BorderColor     =   &H00C0C0C0&
         X1              =   0
         X2              =   5040
         Y1              =   0
         Y2              =   0
      End
      Begin VB.Label lblStatus 
         BackStyle       =   0  'Transparent
         Caption         =   "Idle"
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Top             =   50
         Width           =   5655
      End
   End
   Begin SHDocVwCtl.WebBrowser ctlBrowser 
      Height          =   3840
      Left            =   0
      TabIndex        =   1
      Top             =   720
      Width           =   5655
      ExtentX         =   9975
      ExtentY         =   6773
      ViewMode        =   0
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   0
      RegisterAsDropTarget=   1
      AutoArrange     =   0   'False
      NoClientEdge    =   0   'False
      AlignLeft       =   0   'False
      NoWebView       =   0   'False
      HideFileNames   =   0   'False
      SingleClick     =   0   'False
      SingleSelection =   0   'False
      NoFolders       =   0   'False
      Transparent     =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   "http:///"
   End
   Begin VB.PictureBox picTop 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   0
      ScaleHeight     =   735
      ScaleWidth      =   8295
      TabIndex        =   0
      Top             =   0
      Width           =   8295
      Begin AB.XPButton cmdGO 
         Default         =   -1  'True
         Height          =   300
         Left            =   7560
         TabIndex        =   3
         Top             =   255
         Width           =   615
         _ExtentX        =   1085
         _ExtentY        =   529
         BTYPE           =   14
         TX              =   "GO"
         ENAB            =   -1  'True
         BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         COLTYPE         =   1
         FOCUSR          =   -1  'True
         BCOL            =   16777215
         BCOLO           =   16777215
         FCOL            =   0
         FCOLO           =   16711680
         MCOL            =   12632256
         MPTR            =   0
         MICON           =   "frmMain.frx":1064
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
      End
      Begin VB.ComboBox cboURL 
         Height          =   315
         Left            =   3840
         TabIndex        =   2
         Text            =   "http://www.tnexgen.com"
         Top             =   240
         Width           =   3615
      End
      Begin VB.Image imgMail 
         Height          =   525
         Left            =   3120
         MouseIcon       =   "frmMain.frx":1080
         MousePointer    =   99  'Custom
         Picture         =   "frmMain.frx":11D2
         Top             =   120
         Width           =   510
      End
      Begin VB.Image imgSearch 
         Height          =   510
         Left            =   2520
         MouseIcon       =   "frmMain.frx":204C
         MousePointer    =   99  'Custom
         Picture         =   "frmMain.frx":219E
         Top             =   120
         Width           =   525
      End
      Begin VB.Image imgStop 
         Height          =   525
         Left            =   1920
         MouseIcon       =   "frmMain.frx":3038
         MousePointer    =   99  'Custom
         Picture         =   "frmMain.frx":318A
         Top             =   120
         Width           =   525
      End
      Begin VB.Image imgRefresh 
         Height          =   525
         Left            =   1320
         MouseIcon       =   "frmMain.frx":4090
         MousePointer    =   99  'Custom
         Picture         =   "frmMain.frx":41E2
         Top             =   120
         Width           =   525
      End
      Begin VB.Image imgForward 
         Height          =   525
         Left            =   720
         MouseIcon       =   "frmMain.frx":50E8
         MousePointer    =   99  'Custom
         Picture         =   "frmMain.frx":523A
         Top             =   120
         Width           =   525
      End
      Begin VB.Image imgBackward 
         Height          =   525
         Left            =   120
         MouseIcon       =   "frmMain.frx":6140
         MousePointer    =   99  'Custom
         Picture         =   "frmMain.frx":6292
         Top             =   120
         Width           =   525
      End
   End
   Begin VB.Image imgMailDisabled 
      Height          =   525
      Left            =   7680
      Picture         =   "frmMain.frx":7198
      Top             =   3960
      Width           =   510
   End
   Begin VB.Image imgMailDown 
      Height          =   525
      Left            =   5880
      Picture         =   "frmMain.frx":8012
      Top             =   3960
      Width           =   510
   End
   Begin VB.Image imgMailOver 
      Height          =   525
      Left            =   6480
      Picture         =   "frmMain.frx":8E8C
      Top             =   3960
      Width           =   510
   End
   Begin VB.Image imgMailNormal 
      Height          =   525
      Left            =   7080
      Picture         =   "frmMain.frx":9D06
      Top             =   3960
      Width           =   510
   End
   Begin VB.Image imgBackwardDisabled 
      Height          =   525
      Left            =   7680
      Picture         =   "frmMain.frx":AB80
      Top             =   2760
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgBackwardDown 
      Height          =   525
      Left            =   5880
      Picture         =   "frmMain.frx":BA86
      Top             =   2760
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgBackwardOver 
      Height          =   525
      Left            =   6480
      Picture         =   "frmMain.frx":C98C
      Top             =   2760
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgForwardDown 
      Height          =   525
      Left            =   5880
      Picture         =   "frmMain.frx":D892
      Top             =   2160
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgForwardOver 
      Height          =   525
      Left            =   6480
      Picture         =   "frmMain.frx":E798
      Top             =   2160
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgExitNormal 
      Height          =   210
      Left            =   5640
      Picture         =   "frmMain.frx":F69E
      Top             =   1200
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Image imgExitDown 
      Height          =   210
      Left            =   5640
      Picture         =   "frmMain.frx":F980
      Top             =   960
      Visible         =   0   'False
      Width           =   240
   End
   Begin VB.Image imgRefreshOver 
      Height          =   525
      Left            =   6480
      Picture         =   "frmMain.frx":FC62
      Top             =   3360
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgRefreshDown 
      Height          =   525
      Left            =   5880
      Picture         =   "frmMain.frx":10B68
      Top             =   3360
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgRefreshNormal 
      Height          =   525
      Left            =   7080
      Picture         =   "frmMain.frx":11A6E
      Top             =   3360
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgStopOver 
      Height          =   525
      Left            =   6480
      Picture         =   "frmMain.frx":12974
      Top             =   1560
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgStopDown 
      Height          =   525
      Left            =   5880
      Picture         =   "frmMain.frx":1387A
      Top             =   1560
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgSearchDown 
      Height          =   510
      Left            =   5880
      Picture         =   "frmMain.frx":14780
      Top             =   960
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgSearchOver 
      Height          =   510
      Left            =   6480
      Picture         =   "frmMain.frx":1561A
      Top             =   960
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgSearchNormal 
      Height          =   510
      Left            =   7080
      Picture         =   "frmMain.frx":164B4
      Top             =   960
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgSearchDisabled 
      Height          =   510
      Left            =   7680
      Picture         =   "frmMain.frx":1734E
      Top             =   960
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgRefreshDisabled 
      Height          =   525
      Left            =   7680
      Picture         =   "frmMain.frx":181E8
      Top             =   3360
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgStopDisabled 
      Height          =   525
      Left            =   7680
      Picture         =   "frmMain.frx":190EE
      Top             =   1560
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgStopNormal 
      Height          =   525
      Left            =   7080
      Picture         =   "frmMain.frx":19FF4
      Top             =   1560
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgForwardDisabled 
      Height          =   525
      Left            =   7680
      Picture         =   "frmMain.frx":1AEFA
      Top             =   2160
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgForwardNormal 
      Height          =   525
      Left            =   7080
      Picture         =   "frmMain.frx":1BE00
      Top             =   2160
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Image imgBackwardNormal 
      Height          =   525
      Left            =   7080
      Picture         =   "frmMain.frx":1CD06
      Top             =   2760
      Visible         =   0   'False
      Width           =   525
   End
End
Attribute VB_Name = "frmMain"
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
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type
Private Declare Function GetWindowRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT) As Long
Private lVarRect As RECT, lVarLong As Long

Public Sub FormDrag(lForm As Form)
On Local Error GoTo ErrHandler
ReleaseCapture
Call SendMessage(lForm.hWnd, &HA1, 2, 0&)
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub cboURL_KeyPress(KeyAscii As Integer)
On Local Error GoTo ErrHandler
If KeyAscii = 13 Then
    If Len(cboURL.Text) <> 0 Then
        GoURL1 cboURL.Text
    End If
    KeyAscii = 0
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub cmdGO_Click()
On Local Error GoTo ErrHandler
If Len(cboURL.Text) <> 0 Then
    GoURL1 cboURL.Text
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub ctlBrowser_NavigateComplete2(ByVal pDisp As Object, URL As Variant)
On Local Error GoTo ErrHandler
Dim i As Integer, B As Boolean
For i = 0 To cboURL.ListCount
    If Trim(LCase(URL)) = Trim(LCase(cboURL.List(i))) Then
        B = True
    End If
Next i
ctlProg.Value = 0
If B = False Then cboURL.AddItem URL
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub ctlBrowser_ProgressChange(ByVal Progress As Long, ByVal ProgressMax As Long)
If ctlProg.Max <> ProgressMax Then ctlProg.Max = ProgressMax
If ctlProg.Value <> Progress Then ctlProg.Value = Progress
If ctlProg.Value = 100 Then ctlProg.Value = 0
End Sub

Private Sub ctlBrowser_StatusTextChange(ByVal Text As String)
lblStatus.Caption = Text
End Sub

Private Sub ctlBrowser_TitleChange(ByVal Text As String)
On Local Error GoTo ErrHandler
'lblTop.Caption = "Acidmax Browser - " & Text
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub Form_Load()
On Local Error GoTo ErrHandler
Dim i As Integer, msg As String
imgStop.Picture = imgStopDisabled.Picture
SetWindowToChild Me.hWnd
msg = ReturnStartURL
If Len(msg) <> 0 Then
    ctlBrowser.Navigate msg
Else
    ctlBrowser.Navigate "http://www.tnexgen.com"
End If
imgStop.Picture = imgStopNormal.Picture
Me.Width = CLng(ReadINI(App.Path & "\ab.ini", "Settings", "Width", 8000))
Me.Height = CLng(ReadINI(App.Path & "\ab.ini", "Settings", "Height", 4000))
Me.Visible = True
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub Form_Resize()
On Local Error Resume Next
picTop.Width = Me.ScaleWidth
If ctlBrowser.Top <> picTop.Height Then ctlBrowser.Top = picTop.Height

ctlBrowser.Height = Me.ScaleHeight - ((picTop.Height + picBottom.Height) + 22)
ctlBrowser.Width = Me.ScaleWidth

picBottom.Top = Me.ScaleHeight - (picBottom.Height + 22)
picBottom.Width = Me.ScaleWidth

Line1.x2 = Me.ScaleWidth
cboURL.Width = picTop.ScaleWidth - 4650
cmdGO.Left = (cboURL.Left + cboURL.Width) + 70
ctlProg.Left = Me.Width - (ctlProg.Width + 300)
If Err.Number <> 0 Then Err.Clear
End Sub

Private Sub imgBackward_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 1 And imgBackward.Picture <> imgBackwardDisabled.Picture Then imgBackward.Picture = imgBackwardDown.Picture
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgBackward_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 0 And imgBackward.Picture <> imgBackwardDisabled.Picture Then
    imgBackward.Picture = imgBackwardOver.Picture
    ResetIcons True, imgBackward
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgBackward_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 1 And imgBackward.Picture <> imgBackwardDisabled.Picture Then
    ctlBrowser.GoBack
    imgBackward.Picture = imgBackwardNormal.Picture
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgForward_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 1 And imgForward.Picture <> imgForwardDisabled.Picture Then imgForward.Picture = imgForwardDown.Picture
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgForward_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 0 And imgForward.Picture <> imgForwardDisabled.Picture Then
    imgForward.Picture = imgForwardOver.Picture
    ResetIcons True, imgForward
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgForward_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 1 And imgForward.Picture <> imgForwardDisabled.Picture Then
    imgForward.Picture = imgForwardNormal.Picture
    ctlBrowser.GoForward
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgMail_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 1 Then imgMail.Picture = imgMailDown.Picture
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgMail_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 0 Then
    imgMail.Picture = imgMailOver.Picture
    ResetIcons True, imgMail
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgMail_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 1 Then
    mIRCStatusSend "//frmASM.Load"
    imgMail.Picture = imgMailNormal.Picture
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgRefresh_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 1 Then imgRefresh.Picture = imgRefreshDown.Picture
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgRefresh_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 0 Then
    imgRefresh.Picture = imgRefreshOver.Picture
    ResetIcons True, imgRefresh
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgRefresh_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 1 Then
    ctlBrowser.Refresh
    imgRefresh.Picture = imgRefreshNormal.Picture
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgSearch_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 1 Then imgSearch.Picture = imgSearchDown.Picture
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgSearch_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 0 Then
    imgSearch.Picture = imgSearchOver.Picture
    ResetIcons True, imgSearch
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgSearch_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 1 Then
    imgSearch.Picture = imgSearchNormal.Picture
    ctlBrowser.Navigate "http://www.metacrawler.com"
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgStop_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 1 Then
    If imgStop.Picture <> imgStopDisabled.Picture Then
        imgStop.Picture = imgStopDown.Picture
    End If
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgStop_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If imgStop.Picture <> imgStopDisabled.Picture Then
    imgStop.Picture = imgStopOver.Picture
    ResetIcons True, imgStop
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub imgStop_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
If Button = 1 Then
    If imgStop.Picture <> imgStopDisabled.Picture Then
        imgStop.Picture = imgStopNormal.Picture
        ctlBrowser.Stop
    End If
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Public Sub ResetIcons(Optional lOverImage As Boolean, Optional lImageOver As Image)
On Local Error GoTo ErrHandler
If lOverImage = False Then
    If imgSearch.Picture <> imgSearchNormal.Picture Then imgSearch.Picture = imgSearchNormal.Picture
    If imgStop.Picture <> imgStopNormal.Picture Then imgStop.Picture = imgStopNormal.Picture
    If imgRefresh.Picture <> imgRefreshNormal.Picture Then imgRefresh.Picture = imgRefreshNormal.Picture
    If imgBackward.Picture <> imgBackwardNormal.Picture Then imgBackward.Picture = imgBackwardNormal.Picture
    If imgForward.Picture <> imgForwardNormal.Picture Then imgForward.Picture = imgForwardNormal.Picture
    If imgMail.Picture <> imgMailNormal.Picture Then imgMail.Picture = imgMailNormal.Picture
Else
    If lImageOver.Picture <> imgSearch.Picture And imgSearch.Picture <> imgSearchNormal.Picture Then imgSearch.Picture = imgSearchNormal.Picture
    If lImageOver.Picture <> imgStop.Picture And imgStop.Picture <> imgStopNormal.Picture Then imgStop.Picture = imgStopNormal.Picture
    If lImageOver.Picture <> imgRefresh.Picture And imgRefresh.Picture <> imgRefreshNormal.Picture Then imgRefresh.Picture = imgRefreshNormal.Picture
    If lImageOver.Picture <> imgBackward.Picture And imgBackward.Picture <> imgBackwardNormal.Picture Then imgBackward.Picture = imgBackwardNormal.Picture
    If lImageOver.Picture <> imgForward.Picture And imgForward.Picture <> imgForwardNormal.Picture Then imgForward.Picture = imgForwardNormal.Picture
    If lImageOver.Picture <> imgMail.Picture And imgMail.Picture <> imgMailNormal.Picture Then imgMail.Picture = imgMailNormal.Picture
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Private Sub picTop_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
On Local Error GoTo ErrHandler
ResetIcons
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Sub mIRCStatusSend(lData As String)
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

Private Sub tmrResize_Timer()
lVarLong = GetWindowRect(ReturnParentWindow, lVarRect)
If Me.Left <> 0 Then Me.Left = 0
If Me.Top <> 0 Then Me.Top = 0
lVarLong = 0
lVarLong = ((lVarRect.Right - lVarRect.Left) * Screen.TwipsPerPixelX) - 120
If Me.Width <> lVarLong Then Me.Width = lVarLong
lVarLong = 0
lVarLong = ((lVarRect.Bottom - lVarRect.Top) * Screen.TwipsPerPixelY) - 100
If Me.Height <> lVarLong Then Me.Height = lVarLong
End Sub
