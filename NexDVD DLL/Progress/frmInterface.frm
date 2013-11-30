VERSION 5.00
Object = "{EE128208-4F73-11D3-83BB-C47C02EE3D01}#1.0#0"; "ControlResizer.ocx"
Begin VB.Form frmInterface 
   BorderStyle     =   0  'None
   ClientHeight    =   1710
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   14505
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
   Icon            =   "frmInterface.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   114
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   967
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.Label lblTime 
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "Fixedsys"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   7560
      TabIndex        =   3
      Top             =   960
      Width           =   2415
   End
   Begin VB.Image imgMenu2 
      Height          =   195
      Left            =   5520
      Picture         =   "frmInterface.frx":0CCA
      Top             =   2280
      Width           =   315
   End
   Begin VB.Image imgMenu1 
      Height          =   195
      Left            =   5520
      Picture         =   "frmInterface.frx":1132
      Top             =   1920
      Width           =   315
   End
   Begin VB.Image imgMenu 
      Height          =   225
      Left            =   10980
      MouseIcon       =   "frmInterface.frx":1599
      MousePointer    =   99  'Custom
      Picture         =   "frmInterface.frx":16EB
      Stretch         =   -1  'True
      Top             =   1095
      Width           =   375
   End
   Begin VB.Label lblChapter 
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "Fixedsys"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   7560
      TabIndex        =   2
      Top             =   1200
      Width           =   2415
   End
   Begin VB.Label lblStatus 
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "Fixedsys"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   4800
      TabIndex        =   1
      Top             =   960
      Width           =   2535
   End
   Begin VB.Image imgRewind1 
      Height          =   180
      Left            =   4800
      Picture         =   "frmInterface.frx":1BC5
      Top             =   1920
      Width           =   585
   End
   Begin VB.Image imgRewind2 
      Height          =   180
      Left            =   4800
      Picture         =   "frmInterface.frx":20D5
      Top             =   2280
      Width           =   585
   End
   Begin VB.Image imgEject2 
      Height          =   285
      Left            =   3960
      Picture         =   "frmInterface.frx":25FF
      Top             =   2280
      Width           =   615
   End
   Begin VB.Image imgEject1 
      Height          =   285
      Left            =   3960
      Picture         =   "frmInterface.frx":2C74
      Top             =   1920
      Width           =   615
   End
   Begin VB.Image imgEject 
      Height          =   285
      Left            =   12105
      MouseIcon       =   "frmInterface.frx":32D8
      MousePointer    =   99  'Custom
      Picture         =   "frmInterface.frx":342A
      Stretch         =   -1  'True
      Top             =   330
      Width           =   615
   End
   Begin VB.Image imgPause2 
      Height          =   315
      Left            =   3240
      Picture         =   "frmInterface.frx":3A8E
      Top             =   2280
      Width           =   600
   End
   Begin VB.Image imgPause1 
      Height          =   315
      Left            =   3240
      Picture         =   "frmInterface.frx":4117
      Top             =   1920
      Width           =   600
   End
   Begin VB.Image imgPause 
      Height          =   315
      Left            =   13005
      MouseIcon       =   "frmInterface.frx":47AB
      MousePointer    =   99  'Custom
      Picture         =   "frmInterface.frx":48FD
      Stretch         =   -1  'True
      Top             =   1035
      Width           =   600
   End
   Begin VB.Image imgStop2 
      Height          =   315
      Left            =   2520
      Picture         =   "frmInterface.frx":4F91
      Top             =   2280
      Width           =   600
   End
   Begin VB.Image imgStop1 
      Height          =   315
      Left            =   2520
      Picture         =   "frmInterface.frx":561A
      Top             =   1920
      Width           =   600
   End
   Begin VB.Image imgStop 
      Height          =   315
      Left            =   12135
      MouseIcon       =   "frmInterface.frx":5C97
      MousePointer    =   99  'Custom
      Picture         =   "frmInterface.frx":5DE9
      Stretch         =   -1  'True
      Top             =   1035
      Width           =   600
   End
   Begin VB.Image imgPlay2 
      Height          =   315
      Left            =   1800
      Picture         =   "frmInterface.frx":6466
      Top             =   2280
      Width           =   600
   End
   Begin VB.Image imgPlay1 
      Height          =   315
      Left            =   1800
      Picture         =   "frmInterface.frx":6AFF
      Top             =   1920
      Width           =   600
   End
   Begin VB.Image imgPlay 
      Height          =   315
      Left            =   13620
      MouseIcon       =   "frmInterface.frx":7174
      MousePointer    =   99  'Custom
      Picture         =   "frmInterface.frx":72C6
      Stretch         =   -1  'True
      Top             =   1035
      Width           =   600
   End
   Begin VB.Image imgMute 
      Height          =   225
      Left            =   10410
      MouseIcon       =   "frmInterface.frx":793B
      MousePointer    =   99  'Custom
      Picture         =   "frmInterface.frx":7A8D
      Stretch         =   -1  'True
      Top             =   1095
      Width           =   375
   End
   Begin VB.Image imgMute2 
      Height          =   225
      Left            =   1320
      Picture         =   "frmInterface.frx":7F67
      Top             =   2280
      Width           =   375
   End
   Begin VB.Image imgMute1 
      Height          =   225
      Left            =   1320
      Picture         =   "frmInterface.frx":8446
      Top             =   1920
      Width           =   375
   End
   Begin VB.Image imgFullScreen 
      Height          =   195
      Left            =   10710
      MouseIcon       =   "frmInterface.frx":8920
      MousePointer    =   99  'Custom
      Picture         =   "frmInterface.frx":8A72
      Stretch         =   -1  'True
      Top             =   630
      Width           =   315
   End
   Begin VB.Image imgFullScreen2 
      Height          =   195
      Left            =   840
      Picture         =   "frmInterface.frx":8ED9
      Top             =   2280
      Width           =   315
   End
   Begin VB.Image imgFullScreen1 
      Height          =   195
      Left            =   840
      Picture         =   "frmInterface.frx":9341
      Top             =   1920
      Width           =   315
   End
   Begin VB.Label lblVideo 
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "Fixedsys"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   4800
      TabIndex        =   0
      Top             =   1200
      Width           =   2535
   End
   Begin VB.Image imgPower 
      Height          =   360
      Left            =   400
      MouseIcon       =   "frmInterface.frx":97A8
      MousePointer    =   99  'Custom
      Picture         =   "frmInterface.frx":98FA
      Stretch         =   -1  'True
      Top             =   990
      Width           =   615
   End
   Begin VB.Image imgPower2 
      Height          =   360
      Left            =   120
      Picture         =   "frmInterface.frx":A4DC
      Top             =   2280
      Width           =   615
   End
   Begin VB.Image imgPower1 
      Height          =   360
      Left            =   120
      Picture         =   "frmInterface.frx":B0BE
      Top             =   1920
      Width           =   615
   End
   Begin ControlResizer.AutoResizer AutoResizer1 
      Height          =   375
      Left            =   1320
      Top             =   960
      Visible         =   0   'False
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   661
   End
   Begin VB.Image imgBackground 
      Height          =   1770
      Left            =   0
      Picture         =   "frmInterface.frx":BCA0
      Stretch         =   -1  'True
      Top             =   0
      Width           =   14520
   End
End
Attribute VB_Name = "frmInterface"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
On Local Error Resume Next
If lSettings.sUseDVDInterface = False Then
    Unload Me
    Exit Sub
End If
SetForm True, Me
Me.Top = 0
Me.Left = 0
Me.Width = Screen.Width
imgBackground.Width = Me.ScaleWidth
PauseFunc 0.2
If lSettings.sAlwaysOnTop = True Then AlwaysOnTop Me, True
If Err.Number <> 0 Then SetError "Form_Load", Err.Description
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
FormDrag Me
If Err.Number <> 0 Then SetError "Form_MouseDown", Err.Description
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
SetForm False, Me
AlwaysOnTop Me, False
End Sub

Private Sub imgBackground_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 2 Then
    PopupMenu frmMain.mnuControls
Else
    If frmMain.WindowState = vbMinimized Then
        frmMain.WindowState = vbNormal
    Else
        FormDrag Me
        'frmMain.SetFocus
    End If
End If
If Err.Number <> 0 Then SetError "imgBackGround_MouseDown", Err.Description
End Sub

Private Sub imgEject_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 Then
    imgEject.Picture = imgEject2.Picture
End If
If Err.Number <> 0 Then SetError "imgEject_MouseDown", Err.Description
End Sub

Private Sub imgEject_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 Then
    imgEject.Picture = imgEject1.Picture
    frmMain.ctlDVD.Eject
End If
If Err.Number <> 0 Then SetError "imgEject_MouseUp", Err.Description
End Sub

Private Sub imgFullScreen_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 Then
    imgFullScreen.Picture = imgFullScreen2.Picture
End If
If Err.Number <> 0 Then SetError "imgFullScreen_MouseDown", Err.Description
End Sub

Private Sub imgFullScreen_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 Then
    imgFullScreen.Picture = imgFullScreen1.Picture
    FullScreen True
End If
If Err.Number <> 0 Then SetError "imgFullScreen_MouseUp", Err.Description
End Sub

Private Sub imgMenu_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 Then
    imgMenu.Picture = imgMenu2.Picture
End If
If Err.Number <> 0 Then SetError "imgMenu_MouseDown", Err.Description
End Sub

Private Sub imgMenu_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 Then
    imgMenu.Picture = imgMenu1.Picture
    frmMain.GoRootMenu
End If
If Err.Number <> 0 Then SetError "imgMenu_MouseUp", Err.Description
End Sub

Private Sub imgMute_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 Then
    imgMute.Picture = imgMute2.Picture
End If
If Err.Number <> 0 Then SetError "imgMute_MouseDown", Err.Description
End Sub

Private Sub imgMute_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 Then
    imgMute.Picture = imgMute1.Picture
    If frmMain.mnuMute.Checked = False Then
        Mute True
    Else
        Mute False
    End If
End If
If Err.Number <> 0 Then SetError "imgMute_MouseUp", Err.Description
End Sub

Private Sub imgPause_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 Then
    imgPause.Picture = imgPause2.Picture
End If
If Err.Number <> 0 Then SetError "imgPause_mouseDown", Err.Description
End Sub

Private Sub imgPause_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 Then
    imgPause.Picture = imgPause1.Picture
    PlayerState ePaused
End If
If Err.Number <> 0 Then SetError "imgPause_MouseUp", Err.Description
End Sub

Private Sub imgPlay_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 Then
    imgPlay.Picture = imgPlay2.Picture
End If
If Err.Number <> 0 Then SetError "imgPlay_MouseDown", Err.Description
End Sub

Private Sub imgPlay_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 Then
    imgPlay.Picture = imgPlay1.Picture
    PlayerState ePlay
End If
If Err.Number <> 0 Then SetError "imgPlay_MouseUp", Err.Description
End Sub

Private Sub imgPower_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 Then
    imgPower.Picture = imgPower2.Picture
End If
If Err.Number <> 0 Then SetError "imgPower_MouseDown", Err.Description
End Sub

Private Sub imgPower_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
PictureBoxMouseMove Button, imgPower, imgPower1, imgPower2, X, Y
If Err.Number <> 0 Then SetError "imgPower_MouseMove", Err.Description
End Sub

Private Sub imgPower_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 And imgPower.Picture = imgPower2.Picture Then
    imgPower.Picture = imgPower1.Picture
    UnloadProg
End If
If Err.Number <> 0 Then SetError "imgPower_MouseUp", Err.Description
End Sub

Private Sub imgStop_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 Then
    imgStop.Picture = imgStop2.Picture
End If
If Err.Number <> 0 Then SetError "imgStop_MouseDown", Err.Description
End Sub

Private Sub imgStop_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 1 Then
    imgStop.Picture = imgStop1.Picture
    PlayerState eStopped
End If
If Err.Number <> 0 Then SetError "imgStop_MouseUp", Err.Description
End Sub

Private Sub lblChapter_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 2 Then
    PopupMenu frmMain.mnuControls
Else
    FormDrag Me
End If
If Err.Number <> 0 Then SetError "lblChapter_MouseDown", Err.Description
End Sub

Private Sub lblStatus_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 2 Then
    PopupMenu frmMain.mnuControls
Else
    FormDrag Me
End If
If Err.Number <> 0 Then SetError "lblStatus_MouseDown", Err.Description
End Sub

Private Sub lblTime_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 2 Then
    PopupMenu frmMain.mnuControls
Else
    FormDrag Me
End If
If Err.Number <> 0 Then SetError "lblTime_MouseDown", Err.Description
End Sub

Private Sub lblVideo_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
If Button = 2 Then
    PopupMenu frmMain.mnuControls
Else
    FormDrag Me
End If
If Err.Number <> 0 Then SetError "lblVideo_MouseDown", Err.Description
End Sub
