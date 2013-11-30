VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   0  'None
   Caption         =   "Acidmax FTP"
   ClientHeight    =   4920
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   7815
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
   ScaleHeight     =   328
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   521
   ShowInTaskbar   =   0   'False
   Begin AF.XPButton cmdDisconnect 
      Height          =   735
      Left            =   855
      TabIndex        =   3
      ToolTipText     =   "Disconnect"
      Top             =   15
      Width           =   855
      _ExtentX        =   1508
      _ExtentY        =   1296
      BTYPE           =   8
      TX              =   ""
      ENAB            =   -1  'True
      BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Verdana"
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
      MCOL            =   12632256
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
   Begin VB.Frame fraFTP 
      BorderStyle     =   0  'None
      Caption         =   "User Mods"
      ForeColor       =   &H00FFFFFF&
      Height          =   4185
      Left            =   0
      TabIndex        =   0
      Top             =   750
      Width           =   7815
      Begin VB.ListBox lstLocalFiles 
         Height          =   1620
         IntegralHeight  =   0   'False
         Left            =   120
         TabIndex        =   20
         Top             =   2180
         Width           =   3375
      End
      Begin VB.DirListBox dirLocalDirectories 
         Height          =   990
         Left            =   120
         TabIndex        =   19
         Top             =   1200
         Width           =   3375
      End
      Begin VB.ListBox lstMessages 
         Height          =   645
         Left            =   120
         TabIndex        =   16
         Top             =   520
         Width           =   7575
      End
      Begin VB.ListBox lstDirectories 
         Height          =   990
         IntegralHeight  =   0   'False
         ItemData        =   "frmMain.frx":16BA
         Left            =   3480
         List            =   "frmMain.frx":16BC
         TabIndex        =   12
         Top             =   1200
         Width           =   4215
      End
      Begin VB.ListBox lstFTPFiles 
         Height          =   1620
         IntegralHeight  =   0   'False
         ItemData        =   "frmMain.frx":16BE
         Left            =   3480
         List            =   "frmMain.frx":16C0
         TabIndex        =   11
         Top             =   2180
         Width           =   4215
      End
      Begin VB.ComboBox cboServer 
         Height          =   315
         Left            =   840
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   90
         Width           =   2895
      End
      Begin AF.XPButton cmdLogin 
         Height          =   315
         Left            =   6480
         TabIndex        =   1
         Top             =   90
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
         BTYPE           =   3
         TX              =   "Connect"
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
         BCOL            =   14215660
         BCOLO           =   14215660
         FCOL            =   0
         FCOLO           =   0
         MCOL            =   12632256
         MPTR            =   0
         MICON           =   "frmMain.frx":16C2
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
      End
      Begin AF.XPButton cmdDelete 
         Height          =   255
         Left            =   4320
         TabIndex        =   8
         Top             =   3840
         Width           =   735
         _ExtentX        =   1296
         _ExtentY        =   450
         BTYPE           =   3
         TX              =   "Delete"
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
         BCOL            =   14215660
         BCOLO           =   14215660
         FCOL            =   0
         FCOLO           =   0
         MCOL            =   12632256
         MPTR            =   0
         MICON           =   "frmMain.frx":16DE
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
      End
      Begin AF.XPButton cmdRMDir 
         Height          =   255
         Left            =   960
         TabIndex        =   9
         Top             =   3840
         Width           =   735
         _ExtentX        =   1296
         _ExtentY        =   450
         BTYPE           =   3
         TX              =   "Del Dir"
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
         BCOL            =   14215660
         BCOLO           =   14215660
         FCOL            =   0
         FCOLO           =   0
         MCOL            =   12632256
         MPTR            =   0
         MICON           =   "frmMain.frx":16FA
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
      End
      Begin AF.XPButton cmdAdd 
         Height          =   255
         Left            =   3480
         TabIndex        =   10
         Top             =   3840
         Width           =   735
         _ExtentX        =   1296
         _ExtentY        =   450
         BTYPE           =   3
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
         BCOL            =   14215660
         BCOLO           =   14215660
         FCOL            =   0
         FCOLO           =   0
         MCOL            =   12632256
         MPTR            =   0
         MICON           =   "frmMain.frx":1716
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
      End
      Begin AF.XPButton cmdMakeFolder 
         Height          =   255
         Left            =   120
         TabIndex        =   13
         Top             =   3840
         Width           =   735
         _ExtentX        =   1296
         _ExtentY        =   450
         BTYPE           =   3
         TX              =   "New Dir"
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
         BCOL            =   14215660
         BCOLO           =   14215660
         FCOL            =   0
         FCOLO           =   0
         MCOL            =   12632256
         MPTR            =   0
         MICON           =   "frmMain.frx":1732
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
      End
      Begin AF.XPButton cmdAddServer 
         Height          =   315
         Left            =   3840
         TabIndex        =   17
         Top             =   90
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
         BTYPE           =   3
         TX              =   "Add Server"
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
         BCOL            =   14215660
         BCOLO           =   14215660
         FCOL            =   0
         FCOLO           =   0
         MCOL            =   12632256
         MPTR            =   0
         MICON           =   "frmMain.frx":174E
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
      End
      Begin AF.XPButton cmdEditServer 
         Height          =   315
         Left            =   5160
         TabIndex        =   18
         Top             =   90
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
         BTYPE           =   3
         TX              =   "Edit Server"
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
         BCOL            =   14215660
         BCOLO           =   14215660
         FCOL            =   0
         FCOLO           =   0
         MCOL            =   12632256
         MPTR            =   0
         MICON           =   "frmMain.frx":176A
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
      End
      Begin AF.XPButton cmdUpload 
         Height          =   255
         Left            =   1800
         TabIndex        =   21
         Top             =   3840
         Width           =   735
         _ExtentX        =   1296
         _ExtentY        =   450
         BTYPE           =   3
         TX              =   "Upload"
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
         BCOL            =   14215660
         BCOLO           =   14215660
         FCOL            =   0
         FCOLO           =   0
         MCOL            =   12632256
         MPTR            =   0
         MICON           =   "frmMain.frx":1786
         UMCOL           =   -1  'True
         SOFT            =   0   'False
         PICPOS          =   0
         NGREY           =   0   'False
         FX              =   0
         HAND            =   0   'False
         CHECK           =   0   'False
         VALUE           =   0   'False
      End
      Begin VB.Shape shpPercent 
         BackColor       =   &H00FF0000&
         BackStyle       =   1  'Opaque
         Height          =   255
         Left            =   5280
         Top             =   3840
         Visible         =   0   'False
         Width           =   15
      End
      Begin VB.Shape shpBackground 
         BackColor       =   &H8000000F&
         BackStyle       =   1  'Opaque
         BorderColor     =   &H00C0C0C0&
         BorderWidth     =   2
         Height          =   255
         Left            =   5280
         Top             =   3840
         Visible         =   0   'False
         Width           =   1800
      End
      Begin VB.Label lblProgress 
         BackStyle       =   0  'Transparent
         Caption         =   "Progress:"
         ForeColor       =   &H00000000&
         Height          =   255
         Left            =   1200
         TabIndex        =   7
         Top             =   4200
         Visible         =   0   'False
         Width           =   1815
      End
      Begin VB.Label lblInsideProgress 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "0%"
         ForeColor       =   &H00000000&
         Height          =   255
         Left            =   7080
         TabIndex        =   6
         Top             =   3840
         Visible         =   0   'False
         Width           =   615
      End
      Begin VB.Label lblServer 
         BackStyle       =   0  'Transparent
         Caption         =   "Server:"
         ForeColor       =   &H00000000&
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   90
         Width           =   2295
      End
      Begin VB.Line Line11 
         BorderColor     =   &H00808080&
         X1              =   7800
         X2              =   7800
         Y1              =   5400
         Y2              =   0
      End
      Begin VB.Line Line10 
         BorderColor     =   &H00808080&
         X1              =   0
         X2              =   7800
         Y1              =   5640
         Y2              =   5640
      End
      Begin VB.Line Line9 
         BorderColor     =   &H00FFFFFF&
         X1              =   0
         X2              =   0
         Y1              =   0
         Y2              =   5400
      End
      Begin VB.Line Line5 
         BorderColor     =   &H00FFFFFF&
         Visible         =   0   'False
         X1              =   0
         X2              =   7800
         Y1              =   0
         Y2              =   0
      End
      Begin VB.Line Line4 
         BorderColor     =   &H00FFFFFF&
         Visible         =   0   'False
         X1              =   840
         X2              =   1680
         Y1              =   0
         Y2              =   0
      End
      Begin VB.Image imgCool 
         Height          =   495
         Index           =   1
         Left            =   0
         Picture         =   "frmMain.frx":17A2
         Stretch         =   -1  'True
         Top             =   0
         Width           =   7740
      End
   End
   Begin AF.XPButton cmdConnect 
      Height          =   735
      Left            =   0
      TabIndex        =   2
      ToolTipText     =   "Connect"
      Top             =   15
      Width           =   855
      _ExtentX        =   1508
      _ExtentY        =   1296
      BTYPE           =   8
      TX              =   ""
      ENAB            =   -1  'True
      BeginProperty FONT {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Verdana"
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
      MCOL            =   12632256
      MPTR            =   0
      MICON           =   "frmMain.frx":8D14
      PICN            =   "frmMain.frx":8D30
      UMCOL           =   -1  'True
      SOFT            =   0   'False
      PICPOS          =   0
      NGREY           =   0   'False
      FX              =   0
      HAND            =   0   'False
      CHECK           =   0   'False
      VALUE           =   0   'False
   End
   Begin VB.Timer tmrLoginToFTPDelay 
      Enabled         =   0   'False
      Interval        =   200
      Left            =   7320
      Top             =   120
   End
   Begin VB.Timer tmrSetFocusOnce 
      Enabled         =   0   'False
      Interval        =   50
      Left            =   6960
      Top             =   120
   End
   Begin VB.Frame fraAdmin 
      BorderStyle     =   0  'None
      ForeColor       =   &H00000000&
      Height          =   3375
      Left            =   -120
      TabIndex        =   14
      Top             =   1320
      Visible         =   0   'False
      Width           =   7575
      Begin VB.Label lblFTPFileSize 
         Alignment       =   1  'Right Justify
         Height          =   255
         Left            =   4560
         TabIndex        =   15
         Top             =   1440
         Width           =   1215
      End
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Visible         =   0   'False
      X1              =   -16
      X2              =   776
      Y1              =   0
      Y2              =   0
   End
   Begin VB.Menu mnuFileMenu 
      Caption         =   "File Menu"
      Visible         =   0   'False
      Begin VB.Menu mnuRemove 
         Caption         =   "Remove"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private lClickedFile As String

Public Sub SetClickedFile(lFileName As String)
On Local Error Resume Next
lClickedFile = lFileName
End Sub

Private Sub cmdAdd_Click()
On Local Error Resume Next
Dim msg As String, msg2 As String, msg3 As String
If Len(lstDirectories.Text) <> 0 Then
    msg = OpenDialog(ReturnMainForm, "mIRC Scripts (*.mrc)|*.mrc|All Files (*.*)|*.*|", App.Title, CurDir)
    SetWindowFocus ReturnChildWindowHwnd
    SetMainFormStatusLabel "Please wait, uploading ..."
    msg2 = GetFileTitle(msg)
    msg3 = ReturnMainFormDirectoryListBoxText
    If Len(msg3) <> 1 Then msg3 = msg3 & "/"
    UploadFile Left(msg, Len(msg) - Len(msg2)), msg2, msg3
    SetMainFormStatusLabel "Upload Complete"
    AddFile msg2, FileDateTime(msg), FileLen(msg), msg3
    lstFTPFiles.AddItem msg2
Else
    Beep
End If
End Sub

Private Sub cmdAddServer_Click()
On Local Error Resume Next
frmAddServer.Show 1
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub cmdConnect_Click()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub cmdDelete_Click()
On Local Error Resume Next
Dim b As Boolean
SetWindowFocus ReturnChildWindowHwnd
If Len(lstDirectories.Text) = 1 Then
    b = DeleteFile(lstFTPFiles.Text, lstDirectories.Text)
Else
    b = DeleteFile(lstFTPFiles.Text, lstDirectories.Text & "/")
End If
ClearFileIndex FindFileIndex(lstFTPFiles.Text)
lstFTPFiles.RemoveItem lstFTPFiles.ListIndex
End Sub

Private Sub cmdDisconnect_Click()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub cmdLogin_Click()
On Local Error Resume Next
LoginToFTP
'LoginToAdmin txtUsername.Text, txtPassword.Text: DoEvents
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub cmdLogin_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub cmdLogin_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub cmdMakeFolder_Click()
On Local Error Resume Next
Dim msg As String
SetWindowFocus ReturnChildWindowHwnd
msg = InputBox("Enter Directory:", App.Title, "/sys/files/")
If Len(msg) <> 0 Then
    If Right(msg, 1) <> "/" Then msg = msg & "/"
    If CreateDirectory(msg) = True Then
        AddDirectory msg
        lstDirectories.AddItem Left(msg, Len(msg) - 1)
    End If
End If
End Sub

Private Sub cmdRMDir_Click()
On Local Error Resume Next
Dim msg As String
msg = lstDirectories.Text
If Len(msg) = 1 Then
    Exit Sub
Else
    If RemoveDirectory(msg & "/") = True Then
        lstDirectories.RemoveItem lstDirectories.ListIndex
        ClearDirectory ReturnDirectoryIndex(msg)
    End If
End If
End Sub

Private Sub dirLocalDirectories_GotFocus()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub Form_DblClick()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub Form_Load()
On Local Error Resume Next
Dim i As Integer
SetMainFormProgressVisible False
SetWindowToChild Me.hWnd
shpPercent.Visible = True
shpBackground.Visible = True
lblInsideProgress.Visible = True
lblProgress.Visible = True
tmrSetFocusOnce.Enabled = True
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
CloseConnection
tmrLoginToFTPDelay.Enabled = False
tmrSetFocusOnce.Enabled = False
End Sub

Private Sub fraAdmin_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

'Private Sub fraFrames_DblClick(Index As Integer)
'On Local Error Resume Next
'SetWindowFocus ReturnChildWindowHwnd
'End Sub

'Private Sub fraFrames_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
'SetWindowFocus ReturnChildWindowHwnd
'End Sub

Private Sub Label11_DblClick()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub Label11_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub Label10_DblClick()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub Label10_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub Label9_DblClick()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub Label9_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblInsideProgress_DblClick()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblInsideProgress_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblProgress_DblClick()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblProgress_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblUsername_DblClick()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lblUsername_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub List1_Click()

End Sub

Private Sub lstDirectories_Click()
On Local Error Resume Next
Dim i As Integer, l As Integer, msg As String
lblFTPFileSize.Caption = ""
lstFTPFiles.Clear
ListFTPDirectory
'For i = 0 To ReturnFileCount
'    If Len(ReturnFileName(i)) <> 0 Then
'        If LCase(ReturnFileName(i)) <> "version.ini" Then
'            msg = Replace(ReturnFilesRemotePath(i), "*.*", "")
'            Select Case Len(lstDirectories.Text)
'            Case 1
'                If msg = "/" And lstDirectories.Text = "/" Then lstFTPFiles.AddItem ReturnFileName(i)
'                'EnterFTPDirectory "/"
'            Case Else
'                If LCase(msg) = LCase(lstDirectories.Text) & "/" Then lstFTPFiles.AddItem ReturnFileName(i)
'                'EnterFTPDirectory lstDirectories.Text
'            End Select
'        End If
'    End If
'Next i
End Sub

Private Sub lstDirectories_DblClick()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lstDirectories_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lstDirectories_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lstDirectories_Scroll()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lstFTPFiles_DblClick()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lstFTPFiles_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
If FindFileIndex(lstFTPFiles.Text) <> 0 Then lblFTPFileSize.Caption = "Size: " & ReturnFileSize(FindFileIndex(lstFTPFiles.Text))
End Sub

Private Sub lstFTPFiles_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lstFTPFiles_Scroll()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lstLocalFiles_DblClick()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lstLocalFiles_GotFocus()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lstMessages_DblClick()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub lstMessages_GotFocus()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
End Sub

Private Sub tmrLoginToFTPDelay_Timer()
On Local Error Resume Next
LoginToFTP
tmrLoginToFTPDelay.Enabled = False
End Sub

Private Sub tmrSetFocusOnce_Timer()
On Local Error Resume Next
SetWindowFocus ReturnChildWindowHwnd
tmrSetFocusOnce.Enabled = False
End Sub
