VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   0  'None
   Caption         =   "u"
   ClientHeight    =   4920
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   8205
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
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4920
   ScaleWidth      =   8205
   ShowInTaskbar   =   0   'False
   Begin VB.Timer tmrCamImageExists 
      Enabled         =   0   'False
      Interval        =   400
      Left            =   3480
      Top             =   2880
   End
   Begin VB.Timer tmrDisplayCountDown 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   3480
      Top             =   3360
   End
   Begin VB.Timer tmrRefreshCam 
      Enabled         =   0   'False
      Interval        =   10000
      Left            =   3480
      Top             =   3840
   End
   Begin NexCam.InternetFile ctlDownload 
      Left            =   3960
      Top             =   3700
      _ExtentX        =   1005
      _ExtentY        =   1005
   End
   Begin NexCam.XP_ProgressBar XP_ProgressBar1 
      Height          =   255
      Left            =   960
      TabIndex        =   0
      Top             =   4440
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
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
      Color           =   12937777
      Scrolling       =   3
   End
   Begin NexCam.XPButton cmdNavigate 
      Height          =   495
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   1095
      _ExtentX        =   2566
      _ExtentY        =   873
      BTYPE           =   8
      TX              =   "Cams"
      ENAB            =   -1  'True
      BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
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
      MCOL            =   -2147483633
      MPTR            =   0
      MICON           =   "frmMain.frx":0CCA
      PICN            =   "frmMain.frx":0CE6
      UMCOL           =   -1  'True
      SOFT            =   0   'False
      PICPOS          =   0
      NGREY           =   0   'False
      FX              =   0
      HAND            =   0   'False
      CHECK           =   0   'False
      VALUE           =   0   'False
   End
   Begin NexCam.XPButton XPButton1 
      Height          =   495
      Left            =   1200
      TabIndex        =   4
      Top             =   0
      Width           =   1095
      _ExtentX        =   2170
      _ExtentY        =   873
      BTYPE           =   8
      TX              =   "Favs"
      ENAB            =   -1  'True
      BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
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
      MCOL            =   -2147483633
      MPTR            =   0
      MICON           =   "frmMain.frx":10C6
      PICN            =   "frmMain.frx":10E2
      UMCOL           =   -1  'True
      SOFT            =   0   'False
      PICPOS          =   0
      NGREY           =   0   'False
      FX              =   0
      HAND            =   0   'False
      CHECK           =   0   'False
      VALUE           =   0   'False
   End
   Begin VB.Frame fraNavigate 
      BorderStyle     =   0  'None
      Caption         =   "Frame1"
      Height          =   3640
      Index           =   0
      Left            =   120
      TabIndex        =   5
      Top             =   600
      Width           =   8055
      Begin NexCam.ctlListView lvwCams 
         Height          =   3255
         Left            =   0
         TabIndex        =   6
         Top             =   0
         Width           =   3015
         _ExtentX        =   5318
         _ExtentY        =   5741
      End
      Begin NexCam.XPButton cmdStop 
         Height          =   255
         Left            =   960
         TabIndex        =   7
         Top             =   3360
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   450
         BTYPE           =   7
         TX              =   "Stop"
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
         MICON           =   "frmMain.frx":1447
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
      End
      Begin NexCam.XPButton cmdAddCam 
         Height          =   255
         Left            =   0
         TabIndex        =   8
         Top             =   3360
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   450
         BTYPE           =   7
         TX              =   "Add"
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
         MICON           =   "frmMain.frx":1463
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
      End
      Begin VB.Image imgCam 
         Height          =   3630
         Left            =   3120
         Picture         =   "frmMain.frx":147F
         Stretch         =   -1  'True
         Top             =   0
         Width           =   4830
      End
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00E0E0E0&
      BorderWidth     =   2
      X1              =   -120
      X2              =   8160
      Y1              =   510
      Y2              =   510
   End
   Begin VB.Label lblRefreshingIn 
      BackStyle       =   0  'Transparent
      Height          =   255
      Left            =   3240
      TabIndex        =   3
      Top             =   4440
      Width           =   1815
   End
   Begin VB.Image imgNexCamBKUP 
      Height          =   3630
      Left            =   5160
      Picture         =   "frmMain.frx":8416
      Stretch         =   -1  'True
      Top             =   7080
      Visible         =   0   'False
      Width           =   4830
   End
   Begin VB.Label lblPercent 
      BackStyle       =   0  'Transparent
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   4440
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Line Line1 
      BorderColor     =   &H0000C0C0&
      X1              =   0
      X2              =   8280
      Y1              =   4320
      Y2              =   4320
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Type gCam
    cURL As String
    cPort As Long
    cDescription As String
    cRefreshRate As Long
End Type
Private Type gCams
    cIndex As Integer
    cCount As Integer
    cCam(100) As gCam
End Type
Private lCams As gCams
Private lINIFile As String
Private lListViewIndex As Integer
Private lCurrentCamLocalFile As String
Private lCurrentCamRemoteFile As String
Private lCurrentCountDown As Long
Private WithEvents lInternetFile As InternetFile
Attribute lInternetFile.VB_VarHelpID = -1

Private Sub cmdNavigate_Click()
fraNavigate(0).Visible = True
'fraNavigate(1).Visible = False
End Sub

Private Sub lInternetFile_DownloadProgress(lBytesRead As Long)
On Local Error GoTo ErrHandler
If XP_ProgressBar1.Visible = False Then XP_ProgressBar1.Visible = True
If lblPercent.Visible = False Then lblPercent.Visible = True
If XP_ProgressBar1.Max <> ctlDownload.FileSize Then XP_ProgressBar1.Max = ctlDownload.FileSize
XP_ProgressBar1.Value = lBytesRead
lblPercent.Caption = CStr(CLng(lBytesRead * 100 / ctlDownload.FileSize))
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lInternetFile_DownloadComplete()
lblPercent.Caption = ""
lblPercent.Visible = False
XP_ProgressBar1.Value = 0
XP_ProgressBar1.Max = 100
XP_ProgressBar1.Visible = False
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

Public Sub AddCam(lDescription As String, lURL As String, lPort As Long, lRefreshRate As Long)
On Local Error GoTo ErrHandler
lCams.cCount = lCams.cCount + 1
With lCams.cCam(lCams.cCount)
    .cDescription = lDescription
    .cURL = lURL
    .cRefreshRate = lRefreshRate
    .cPort = lPort
End With
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub LoadCams()
On Local Error GoTo ErrHandler
Dim i As Integer
lvwCams.Clear
lCams.cCount = Int(ReadINI(lINIFile, "Settings", "Count", 0))
If lCams.cCount <> 0 Then
    For i = 0 To lCams.cCount
        With lCams.cCam(i)
            .cDescription = ReadINI(lINIFile, Trim(Str(i)), "Description", "")
            If Len(.cDescription) <> 0 Then
                .cURL = ReadINI(lINIFile, Trim(Str(i)), "URL", "")
                .cPort = CLng(ReadINI(lINIFile, Trim(Str(i)), "Port", 0))
                .cRefreshRate = CLng(ReadINI(lINIFile, Trim(Str(i)), "RefreshRate", 0))
                lvwCams.ItemAdd 0, .cDescription, 0, 0
            End If
        End With
    Next i
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub SaveCamList()
On Local Error GoTo ErrHandler
Dim i As Integer
WriteINI lINIFile, "Settings", "Count", lCams.cCount
For i = 0 To lCams.cCount
    If Len(lCams.cCam(i).cDescription) <> 0 Then
        WriteINI lINIFile, Trim(Str(i)), "URL", lCams.cCam(i).cURL
        WriteINI lINIFile, Trim(Str(i)), "Port", lCams.cCam(i).cPort
        WriteINI lINIFile, Trim(Str(i)), "RefreshRate", lCams.cCam(i).cRefreshRate
        WriteINI lINIFile, Trim(Str(i)), "Description", lCams.cCam(i).cDescription
    End If
Next i
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

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

Public Sub DownloadCamImage(lLocalFile As String, lRemoteFile As String)
On Local Error GoTo ErrHandler
If Len(lLocalFile) <> 0 And Len(lRemoteFile) <> 0 Then
    lCurrentCamLocalFile = lLocalFile
    lCurrentCamRemoteFile = lRemoteFile
    tmrRefreshCam.Interval = 10000
    lCurrentCountDown = 10
    tmrRefreshCam.Enabled = True
    If DoesFileExist(lLocalFile) = True Then Kill lLocalFile
    ctlDownload.Url = lRemoteFile
    ctlDownload.Port = 80
    ctlDownload.ConnectType = Preconfig
    ctlDownload.LocalFile = lLocalFile
    ctlDownload.StartDownload
    tmrCamImageExists.Enabled = True
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub cmdAddCam_Click()
Dim msg As String, msg2 As String, msg3 As String, msg4 As String
msg = InputBox("Description:", App.Title, "")
If Len(msg) <> 0 Then
    msg2 = InputBox("Port:", App.Title, "80")
    msg3 = InputBox("URL:", App.Title, "")
    msg4 = InputBox("RefreshRate:", App.Title, "")
    AddCam msg, msg3, CLng(Trim(msg2)), CLng(Trim(msg4))
    lvwCams.ItemAdd 0, msg, 0, 0
End If
End Sub

Private Sub cmdStop_Click()
tmrDisplayCountDown.Enabled = False
tmrRefreshCam.Enabled = False
lblRefreshingIn.Caption = ""
lCurrentCamLocalFile = ""
lCurrentCamRemoteFile = ""
lCurrentCountDown = 0
XP_ProgressBar1.Visible = False
XP_ProgressBar1.Value = 0
imgCam.Picture = imgNexCamBKUP.Picture
End Sub

Private Sub Command1_Click()
'DownloadCamImage App.Path & "\cam.gif", "http://www.tnexgen.com/images/nirc.gif"
DownloadCamImage App.Path & "\cam.gif", "http://212.93.144.152/photo.jpg?Tue%20Jan%2002%202007%2000:32:19%20GMT-0800%20(Pacific%20Standard%20Time)"
End Sub

'Private Sub ctlDownload_DownloadComplete()
'lblPercent.Caption = ""
'lblPercent.Visible = False
'XP_ProgressBar1.Value = 0
'XP_ProgressBar1.Max = 100
'XP_ProgressBar1.Visible = False
'End Sub

'Private Sub ctlDownload_DownloadProgress(lBytesRead As Long)
'On Local Error GoTo ErrHandler
'If XP_ProgressBar1.Visible = False Then XP_ProgressBar1.Visible = True
'If lblPercent.Visible = False Then lblPercent.Visible = True
'If XP_ProgressBar1.Max <> ctlDownload.FileSize Then XP_ProgressBar1.Max = ctlDownload.FileSize
'XP_ProgressBar1.Value = lBytesRead
'lblPercent.Caption = CStr(CLng(lBytesRead * 100 / ctlDownload.FileSize))
'Exit Sub
'ErrHandler:
'    MsgBox Err.Description
'    Err.Clear
'End Sub

Private Sub Form_Load()
SetWindowToChild Trim(CLng(Me.hWnd))
lINIFile = App.Path & "\nexcam.ini"
InitListView
LoadCams
End Sub

Public Sub InitListView()
lvwCams.Initialize
lvwCams.BorderStyle = bsThin
lvwCams.LabelEdit = False
lvwCams.OneClickActivate = True
lvwCams.ViewMode = vmList
lvwCams.ItemAdd 0, "Testing", 0, 0
End Sub

Public Function FindCamIndex(lDescription As String)
Dim i As Integer
For i = 0 To lCams.cCount
    If LCase(lDescription) = LCase(lCams.cCam(i).cDescription) Then
        FindCamIndex = i
        Exit For
    End If
Next i
End Function

Private Sub Form_Unload(Cancel As Integer)
SaveCamList
tmrDisplayCountDown.Enabled = False
tmrRefreshCam.Enabled = False
End Sub

Private Sub lvwCams_DblClick()
On Local Error GoTo ErrHandler
Dim i As Integer, msg As String
imgCam.Picture = imgNexCamBKUP.Picture
msg = lvwCams.ItemText(lListViewIndex)
i = FindCamIndex(msg)
DownloadCamImage App.Path & "\nexcam.gif", lCams.cCam(i).cURL
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub lvwCams_ItemClick(Item As Integer)
On Local Error GoTo ErrHandler
lListViewIndex = Item
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub tmrCamImageExists_Timer()
On Local Error GoTo ErrHandler
If DoesFileExist(lCurrentCamLocalFile) = True Then
    imgCam.Picture = LoadPicture(lCurrentCamLocalFile)
    imgCam.Stretch = True
    imgCam.Width = 4830
    imgCam.Height = 3630
    tmrCamImageExists = False
    tmrDisplayCountDown.Enabled = True
    DoEvents
    If DoesFileExist(lCurrentCamLocalFile) Then Kill lCurrentCamLocalFile
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub tmrDisplayCountDown_Timer()
On Local Error GoTo ErrHandler
lCurrentCountDown = (lCurrentCountDown - 1)
lblRefreshingIn.Caption = "Refreshing in " & Trim(CStr(lCurrentCountDown))
If lCurrentCountDown = 0 Then tmrDisplayCountDown.Enabled = False
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Private Sub tmrRefreshCam_Timer()
On Local Error GoTo ErrHandler
imgCam.Picture = imgNexCamBKUP.Picture
DownloadCamImage lCurrentCamLocalFile, lCurrentCamRemoteFile
'tmrRefreshCam.Enabled = False
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub
