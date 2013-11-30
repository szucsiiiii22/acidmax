VERSION 5.00
Object = "{38EE5CE1-4B62-11D3-854F-00A0C9C898E7}#1.0#0"; "mswebdvd.dll"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Begin VB.Form frmMain 
   AutoRedraw      =   -1  'True
   Caption         =   "nexDVD"
   ClientHeight    =   5565
   ClientLeft      =   195
   ClientTop       =   1020
   ClientWidth     =   9240
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
   ScaleHeight     =   5565
   ScaleWidth      =   9240
   StartUpPosition =   1  'CenterOwner
   Visible         =   0   'False
   Begin VB.PictureBox picOSD 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   375
      Left            =   120
      ScaleHeight     =   375
      ScaleWidth      =   3615
      TabIndex        =   1
      Top             =   120
      Visible         =   0   'False
      Width           =   3615
      Begin VB.Label lblOSD 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "nexDVD"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   14.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   345
         Left            =   0
         TabIndex        =   2
         Top             =   0
         Width           =   1125
      End
   End
   Begin VB.Timer tmrHideOSD 
      Enabled         =   0   'False
      Interval        =   5000
      Left            =   1200
      Top             =   960
   End
   Begin VB.Timer tmrCurrentTime 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   840
      Top             =   960
   End
   Begin VB.Timer tmrFullScreen 
      Enabled         =   0   'False
      Interval        =   2000
      Left            =   480
      Top             =   960
   End
   Begin VB.Timer tmrObjects 
      Enabled         =   0   'False
      Interval        =   750
      Left            =   120
      Top             =   960
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   300
      Left            =   0
      TabIndex        =   0
      Top             =   5265
      Width           =   9240
      _ExtentX        =   16298
      _ExtentY        =   529
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   6
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   3096
            Text            =   "nexDVD"
            TextSave        =   "nexDVD"
            Object.ToolTipText     =   "DVD Title Playing"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Alignment       =   1
            Object.Width           =   1552
            MinWidth        =   1552
            Object.ToolTipText     =   "Play State"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Alignment       =   1
            Object.Width           =   1676
            MinWidth        =   1676
            Object.ToolTipText     =   "Sound State"
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   3096
            Text            =   "Title:      Chapter:"
            TextSave        =   "Title:      Chapter:"
            Object.ToolTipText     =   "Title and Chapter Number"
         EndProperty
         BeginProperty Panel5 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   3096
            Text            =   "Time:"
            TextSave        =   "Time:"
            Object.ToolTipText     =   "DVD Running Time"
         EndProperty
         BeginProperty Panel6 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   3096
            Text            =   "Length:"
            TextSave        =   "Length:"
            Object.ToolTipText     =   "DVD Total Running Time"
         EndProperty
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSWEBDVDLibCtl.MSWebDVD ctlDVD 
      Height          =   5265
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   9240
      _cx             =   16298
      _cy             =   9287
      DisableAutoMouseProcessing=   0   'False
      BackColor       =   1048592
      EnableResetOnStop=   -1  'True
      ColorKey        =   1048592
      WindowlessActivation=   0   'False
   End
   Begin VB.Menu mnuControls 
      Caption         =   "Controls"
      Begin VB.Menu mnuNexDVD 
         Caption         =   "nexDVD"
         Shortcut        =   {F1}
      End
      Begin VB.Menu mnuSep9379268978632 
         Caption         =   "-"
      End
      Begin VB.Menu mnuPlayer 
         Caption         =   "Player"
         Begin VB.Menu mnuPlay 
            Caption         =   "Play"
            Shortcut        =   ^L
         End
         Begin VB.Menu mnuPause 
            Caption         =   "Pause"
            Shortcut        =   ^U
         End
         Begin VB.Menu mnuStop 
            Caption         =   "Stop"
            Shortcut        =   ^S
         End
         Begin VB.Menu mnuSep8937892793 
            Caption         =   "-"
         End
         Begin VB.Menu mnuEject 
            Caption         =   "Eject"
            Shortcut        =   ^E
         End
         Begin VB.Menu mnuSep397937 
            Caption         =   "-"
         End
         Begin VB.Menu mnuFastForward 
            Caption         =   "Fast Forward"
            Shortcut        =   {F3}
         End
         Begin VB.Menu mnuRewind 
            Caption         =   "Rewind"
            Shortcut        =   {F4}
         End
         Begin VB.Menu mnuSep783626328 
            Caption         =   "-"
         End
         Begin VB.Menu mnuSlowMotion 
            Caption         =   "Slow Motion"
            Shortcut        =   {F5}
         End
         Begin VB.Menu mnuStep 
            Caption         =   "Step"
            Shortcut        =   {F6}
         End
         Begin VB.Menu mnuPlaybackPosition 
            Caption         =   "Playback Position"
            Visible         =   0   'False
         End
         Begin VB.Menu mnuSep897928639263 
            Caption         =   "-"
         End
         Begin VB.Menu mnuLanguage 
            Caption         =   "Subtitles"
            Shortcut        =   {F7}
         End
      End
      Begin VB.Menu mnuChapters 
         Caption         =   "Chapter"
         Begin VB.Menu mnuRestartChapter 
            Caption         =   "Restart"
            Shortcut        =   +{INSERT}
         End
         Begin VB.Menu mnuSep93789678362 
            Caption         =   "-"
         End
         Begin VB.Menu mnuNext 
            Caption         =   "Next"
            Shortcut        =   ^N
         End
         Begin VB.Menu mnuPrevious 
            Caption         =   "Previous"
            Shortcut        =   ^P
         End
         Begin VB.Menu mnusep378989276893268247 
            Caption         =   "-"
         End
         Begin VB.Menu mnuChapterList 
            Caption         =   "List"
            Shortcut        =   {F8}
         End
      End
      Begin VB.Menu mnuMenu 
         Caption         =   "Menu"
         Begin VB.Menu mnuMenuBrowser 
            Caption         =   "Browser"
            Shortcut        =   {F9}
         End
         Begin VB.Menu mnusep38972978468926 
            Caption         =   "-"
         End
         Begin VB.Menu mnuRootMenu 
            Caption         =   "Root"
            Shortcut        =   +{F1}
         End
         Begin VB.Menu mnuChapterMenu 
            Caption         =   "Chapter"
            Shortcut        =   +{F2}
         End
         Begin VB.Menu mnuTitleMenu 
            Caption         =   "Title"
            Shortcut        =   +{F3}
         End
         Begin VB.Menu mnuAudioMenu 
            Caption         =   "Audio"
            Shortcut        =   +{F4}
         End
         Begin VB.Menu mnuAngle 
            Caption         =   "Angle"
            Shortcut        =   +{F5}
         End
         Begin VB.Menu mnuSubpic 
            Caption         =   "Subpicture"
            Shortcut        =   +{F6}
         End
         Begin VB.Menu mnuSep8937896479863 
            Caption         =   "-"
         End
         Begin VB.Menu mnuLeft 
            Caption         =   "Left"
         End
         Begin VB.Menu mnuRight 
            Caption         =   "Right"
         End
         Begin VB.Menu mnuTop 
            Caption         =   "Up"
         End
         Begin VB.Menu mnuBottom 
            Caption         =   "Down"
         End
      End
      Begin VB.Menu mnuBookmark 
         Caption         =   "Bookmark"
         Begin VB.Menu mnuGoToBookmark 
            Caption         =   "Go to bookmark"
            Shortcut        =   ^B
         End
         Begin VB.Menu mnuSep879682497268263 
            Caption         =   "-"
         End
         Begin VB.Menu mnuAddbookmark 
            Caption         =   "Add Bookmark"
            Shortcut        =   ^A
         End
         Begin VB.Menu mnuDeleteBookmark 
            Caption         =   "Delete Bookmark"
            Shortcut        =   ^D
         End
      End
      Begin VB.Menu mnuSep38979237 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCapture 
         Caption         =   "Capture"
         Shortcut        =   ^C
      End
      Begin VB.Menu mnuCaptureSep 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSettingsMenu 
         Caption         =   "Settings"
         Begin VB.Menu mnuSettings 
            Caption         =   "Settings"
            Shortcut        =   {F11}
         End
         Begin VB.Menu mnuSep8368675244 
            Caption         =   "-"
         End
         Begin VB.Menu mnuMute 
            Caption         =   "Mute"
            Shortcut        =   {DEL}
         End
         Begin VB.Menu mnuFullScreen 
            Caption         =   "Full Screen"
            Shortcut        =   ^{INSERT}
         End
      End
      Begin VB.Menu mnuHelp 
         Caption         =   "Help"
         Begin VB.Menu mnuDocumentation 
            Caption         =   "Documentation"
         End
         Begin VB.Menu mnuEmailDeveloper 
            Caption         =   "Support"
         End
         Begin VB.Menu mnuSep86382638 
            Caption         =   "-"
         End
         Begin VB.Menu mnuSep389273892 
            Caption         =   "Team Nexgen"
         End
         Begin VB.Menu mnuDownloads 
            Caption         =   "Downloads"
         End
         Begin VB.Menu mnuMessageBoard 
            Caption         =   "Message Board"
         End
      End
      Begin VB.Menu mnuSep923789678623223 
         Caption         =   "-"
      End
      Begin VB.Menu mnuminimize 
         Caption         =   "Minimize"
         Shortcut        =   ^M
      End
      Begin VB.Menu mnuExit 
         Caption         =   "Exit"
         Shortcut        =   ^X
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim lUpdateINI As String
Option Explicit

Private Sub ctlDVD_DVDNotify(ByVal lEventCode As Long, ByVal lParam1 As Variant, ByVal lParam2 As Variant)
On Local Error Resume Next
PlayerObjects lEventCode
If Err.Number <> 0 Then SetError "DVDNotify", Err.Description
End Sub

Private Sub StartProgram()
On Local Error Resume Next
If ctlDVD.WindowlessActivation = True Then lCaptureVersion = True
LoadDrives
LoadSettings
DoEvents
If Trim(lSettings.sCmd) = "winstart" And lSettings.sStartWithWindows = False Then
    End
End If
If lSettings.sMenuVisibleOnMainForm = True Then
'    mnuControls.Visible = True
Else
    mnuControls.Visible = False
End If
If lSettings.sCaptureMode = True Then
    If lCaptureVersion = False Then
        LoadCaptureMode
        Exit Sub
    Else
        mnuCapture.Checked = True
    End If
ElseIf lSettings.sCaptureMode = False Then
    If lCaptureVersion = True Then
        UnloadCaptureMode
        Exit Sub
    Else
        mnuCapture.Checked = False
    End If
End If
If lSettings.sSubpictureOn = True Then
    ctlDVD.SubpictureOn = True
Else
    ctlDVD.SubpictureOn = False
End If
frmTray.Show
SetForm True, Me
If lSettings.sShowStatusBar = True Then
    StatusBar1.Visible = True
Else
    StatusBar1.Visible = False
End If
'If lSettings.sShowSplash = True And Trim(LCase(lSettings.sCmd)) <> "winstart" Then frmSplash.Show vbNormal, frmMain
lPlayer.pChapter = "Chapter: 0"
lPlayer.pTime = "Time: 00:00:00"
lPlayer.pLength = "Length: 00:00:00"
With StatusBar1.Panels
    .Item(1) = Mid$(lPlayer.pTitle, 18, Len(lPlayer.pTitle))
    .Item(4) = lPlayer.pTitle & Space$(5) & lPlayer.pChapter
    .Item(5) = lPlayer.pTime
    '.Item(5) = strRunningTime
    .Item(6) = lPlayer.pLength
    '.Item(6) = iTotalTime
End With
If lSettings.sAlwaysOnTop = True Then AlwaysOnTop Me, True
If lSettings.sUseDVDInterface = True Then
'    frmInterface.Show
Else
    mnuControls.Visible = True
End If
PlayerMenu eStopped
DoEvents
If Trim(LCase(lSettings.sCmd)) = "winstart" Then
    PlayerVisible False
End If
If lSettings.sShowSplash = False Then AutoPlay
If Err.Number <> 0 Then SetError "StartProgram", Err.Description
End Sub

Public Sub GoRootMenu()
On Local Error Resume Next
PlayerState eNavigatingMenu
If Err.Number <> 0 Then SetError "GoRootMenu", Err.Description
End Sub

Private Sub Form_Load()
On Local Error Resume Next
lSettings.sCmd = Command$
SetParentAcidmax Me
StartProgram
If Err.Number <> 0 Then SetError "Form_Load", Err.Description
End Sub

Private Sub Form_Resize()
'On Local Error Resume Next
ctlDVD.Height = Me.ScaleHeight - StatusBar1.Height
ctlDVD.Width = Me.ScaleWidth
'imgMid.Width = ctlDVD.Width
'imgRight.Left = Me.Width - imgRight.Width
If Me.WindowState = vbMinimized Then
    Me.Visible = False
    If mnuNexDVD.Checked = True Then mnuNexDVD.Checked = False
Else
    If mnuNexDVD.Checked = False Then mnuNexDVD.Checked = True
End If
Refresh
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
UnloadProg
If Err.Number <> 0 Then SetError "Form_Unload", Err.Description
End Sub

Private Sub mnuAbout_Click()
On Local Error Resume Next
frmAboutMe.Show
If Err.Number <> 0 Then SetError "Form_Unload", Err.Description
End Sub

Private Sub imgMid_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
FormDrag Me
End Sub

Private Sub mnuAddbookmark_Click()
On Local Error Resume Next
ctlDVD.SaveBookmark
If Err.Number <> 0 Then SetError "mnuAddBookmark_Click", Err.Description
End Sub

Private Sub mnuAngle_Click()
On Local Error Resume Next
ctlDVD.ShowMenu 6
If Err.Number <> 0 Then
    Err.Number = 0
    OnScreenDisplay "Menu not found"
End If
If Err.Number <> 0 Then SetError "mnuTitleMenu_Click", Err.Description
End Sub

Private Sub mnuAudioMenu_Click()
On Local Error Resume Next
ctlDVD.ShowMenu 5
If Err.Number <> 0 Then
    Err.Number = 0
    OnScreenDisplay "Menu not found"
End If
If Err.Number <> 0 Then SetError "mnuAudioMenu_Click", Err.Description
End Sub

Private Sub mnuBottom_Click()
On Local Error Resume Next
ctlDVD.SelectLowerButton
If Err.Number <> 0 Then SetError "mnuBottom_Click", Err.Description
End Sub

Private Sub mnuCapture_Click()
On Local Error Resume Next
Dim mbox As VbMsgBoxResult
If lSettings.sCaptureMode = True Then
    ctlDVD.Capture
Else
    mbox = MsgBox("nexDVD is not in capture mode. Would you like to switch to capture mode now? (This will require nexDVD to end and load again)", vbInformation + vbYesNo, "Capture mode")
    If mbox = vbYes Then
        lSettings.sCaptureMode = True
        WriteINI lINIFiles.iSettings, "Settings", "CaptureMode", lSettings.sCaptureMode
        LoadCaptureMode
        Exit Sub
    End If
End If
If Err.Number <> 0 Then SetError "mnuCapture_Click", Err.Description
End Sub

Private Sub mnuChapterList_Click()
On Local Error Resume Next
frmChapters.Show
If Err.Number <> 0 Then SetError "mnuChapterList_Click", Err.Description
End Sub

Private Sub mnuChapterMenu_Click()
On Local Error Resume Next
ctlDVD.ShowMenu 7
If Err.Number <> 0 Then
    Err.Number = 0
    OnScreenDisplay "Menu not found"
End If
If Err.Number <> 0 Then SetError "mnuChapterMenu_Click", Err.Description
End Sub

Private Sub mnuDeleteBookmark_Click()
On Local Error Resume Next
ctlDVD.DeleteBookmark
If Err.Number <> 0 Then SetError "mnuDeleteBookmark_Click", Err.Description
End Sub

Private Sub mnuDocumentation_Click()
On Local Error Resume Next
Shell "notepad.exe " & App.Path & "\doc\readme.txt", vbNormalFocus
If Err.Number <> 0 Then SetError "mnuDocumentation_Click()", Err.Description
End Sub

Private Sub mnuDownloads_Click()
On Local Error Resume Next
Surf "http://www.tnexgen.com/software.shtml"
If Err.Number <> 0 Then SetError "mnuDownloads_Click", Err.Description
End Sub

Private Sub mnuEject_Click()
On Local Error Resume Next
Me.ctlDVD.Eject
If Err.Number <> 0 Then SetError "mnuEject_Click", Err.Description
End Sub

Private Sub mnuEmailDeveloper_Click()
On Local Error Resume Next
Surf "mailto:brendlefly3000@hotmail.com"
If Err.Number <> 0 Then SetError "mnuEmailDeveloper_Click", Err.Description
End Sub

Private Sub mnuExit_Click()
On Local Error Resume Next
UnloadProg
If Err.Number <> 0 Then SetError "mnuExit_Click", Err.Description
End Sub

Private Sub mnuFastForward_Click()
On Local Error Resume Next
frmRewindFastFoward.cboType.ListIndex = 1
If Err.Number <> 0 Then SetError "mnuFastForward_Click", Err.Description
End Sub

Private Sub mnuFullScreen_Click()
On Local Error Resume Next
FullScreen True
If Err.Number <> 0 Then SetError "mnuFullScreen_Click", Err.Description
End Sub

Private Sub mnuGoToBookmark_Click()
On Local Error Resume Next
ctlDVD.RestoreBookmark
If Err.Number <> 0 Then SetError "mnuGoToBookmark_Click()", Err.Description
End Sub

Private Sub mnuLanguage_Click()
frmLanguage.Show
End Sub

Private Sub mnuLeft_Click()
On Local Error Resume Next
ctlDVD.SelectLeftButton
If Err.Number <> 0 Then SetError "mnuLeft_Click()", Err.Description
End Sub

Private Sub mnuMenuBrowser_Click()
On Local Error Resume Next
frmMenuBrowser.Show
If Err.Number <> 0 Then SetError "mnuMenuBrowser_Click", Err.Description
End Sub

Private Sub mnuMessageBoard_Click()
On Local Error Resume Next
Surf "http://www.tnexgen.com/forum/"
If Err.Number <> 0 Then SetError "mnuMessageBoard_Click", Err.Description
End Sub

Private Sub mnuminimize_Click()
On Local Error Resume Next
PlayerVisible False
If Err.Number <> 0 Then SetError "mnuMinimize_Click", Err.Description
End Sub

Private Sub mnuMute_Click()
On Local Error Resume Next
If mnuMute.Checked = False Then
    Mute True
Else
    Mute False
End If
If Err.Number <> 0 Then SetError "mnuMute_Click", Err.Description
End Sub

Private Sub mnuNexDVD_Click()
On Local Error Resume Next
If Me.WindowState = vbMinimized Then
    PlayerVisible True
Else
    frmAboutMe.Show
End If
If Err.Number <> 0 Then SetError "mnuNexDVD", Err.Description
End Sub

Private Sub mnuNext_Click()
On Local Error Resume Next
Me.ctlDVD.PlayNextChapter
If Err.Number <> 0 Then SetError "mnuNext_Click", Err.Description
End Sub

Private Sub mnuPause_Click()
On Local Error Resume Next
PlayerState ePaused
If Err.Number <> 0 Then SetError "mnuPause_Click", Err.Description
End Sub

Private Sub mnuPlay_Click()
On Local Error Resume Next
PlayerState ePlay
If Err.Number <> 0 Then SetError "mnuPlay_Click", Err.Description
End Sub

Private Sub mnuPlaybackPosition_Click()
On Local Error Resume Next
frmPlaybackPosition.Show
If Err.Number <> 0 Then SetError "mnuPlaybackPosition_Click()", Err.Description
End Sub

Private Sub mnuPrevious_Click()
On Local Error Resume Next
Me.ctlDVD.PlayPrevChapter
If Err.Number <> 0 Then SetError "mnuPrevious_Click", Err.Description
End Sub

Private Sub mnuRestartChapter_Click()
On Local Error Resume Next
ctlDVD.PlayChapter ctlDVD.CurrentChapter
If Err.Number <> 0 Then SetError "mnuRestartChapter_Click", Err.Description
End Sub

Private Sub mnuRewind_Click()
On Local Error Resume Next
frmRewindFastFoward.cboType.ListIndex = 0
If Err.Number <> 0 Then SetError "mnuRewind_Click", Err.Description
End Sub

Private Sub mnuRight_Click()
On Local Error Resume Next
ctlDVD.SelectRightButton
If Err.Number <> 0 Then SetError "mnuRight_Click", Err.Description
End Sub

Private Sub mnuRipper_Click()
On Local Error Resume Next
If frmMain.ctlDVD.PlayState = dvdState_Running Then
'If lPlayer.pStatus <> sIdle Then
    Dim mbox As VbMsgBoxResult
    mbox = MsgBox("To show the ripper, you must first stop playback of your dvd. Are you sure you wish to do this?", vbYesNo + vbQuestion)
    If mbox = vbYes Then
        PlayerState eStopped
'        frmRipper.Show
    Else
        Exit Sub
    End If
Else
'    frmRipper.Show
End If
If Err.Number <> 0 Then SetError "mnuRipper_Click", Err.Description
End Sub

Private Sub mnuRootMenu_Click()
On Local Error Resume Next
ctlDVD.ShowMenu 3
If Err.Number <> 0 Then
    Err.Number = 0
    If lSettings.sPlayOnRootMenuFail = True Then
        PlayerState ePlay
        Exit Sub
    Else
        OnScreenDisplay "Menu not found"
    End If
End If
If Err.Number <> 0 Then SetError "mnuRootMenu_Click", Err.Description
End Sub

Private Sub mnuSep389273892_Click()
On Local Error Resume Next
Surf "http://www.tnexgen.com"
If Err.Number <> 0 Then SetError "mnuSep389273892_Click", Err.Description
End Sub

Private Sub mnuSettings_Click()
On Local Error Resume Next
frmSettings.Show
If Err.Number <> 0 Then SetError "mnuSettings_Click", Err.Description
End Sub

Private Sub mnuSlowMotion_Click()
On Local Error Resume Next
frmSlowMotion.Show
If Err.Number <> 0 Then SetError "mnuSlowMotion_Click()", Err.Description
End Sub

Private Sub mnuStep_Click()
On Local Error Resume Next
frmStep.Show
If Err.Number <> 0 Then SetError "mnuStep_Click()", Err.Description
End Sub

Private Sub mnuStop_Click()
On Local Error Resume Next
PlayerState eStopped
If Err.Number <> 0 Then SetError "mnuStop_Click", Err.Description
End Sub

Private Sub mnuSubpic_Click()
On Local Error Resume Next
ctlDVD.ShowMenu 4
If Err.Number <> 0 Then
    Err.Number = 0
    OnScreenDisplay "Menu not found"
End If
If Err.Number <> 0 Then SetError "mnuTitleMenu_Click", Err.Description
End Sub

Private Sub mnuTitleMenu_Click()
On Local Error Resume Next
ctlDVD.ShowMenu 2
If Err.Number <> 0 Then
    Err.Number = 0
    OnScreenDisplay "Menu not found"
End If
If Err.Number <> 0 Then SetError "mnuTitleMenu_Click", Err.Description
End Sub

Private Sub mnuTop_Click()
On Local Error Resume Next
ctlDVD.SelectUpperButton
If Err.Number <> 0 Then SetError "mnuTop_Click()", Err.Description
End Sub

Private Sub mnuVolume_Click()
On Local Error Resume Next
'frmVolume.Show
If Err.Number <> 0 Then SetError "mnuVolume_Click", Err.Description
End Sub

Private Sub Picture1_Click()

End Sub

Private Sub Picture1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
FormDrag Me
End Sub

Private Sub picTop_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
If Button = 1 Then FormDrag Me
End Sub

Private Sub tmrCurrentTime_Timer()
On Local Error Resume Next
If lSettings.sShowDVDTime = False Then
    tmrCurrentTime.Enabled = False
    Exit Sub
End If
If lSettings.sUseDVDInterface = True Then
    If lPlayer.pStatus = sPlaying Then
        'If frmInterface.lblTime.Caption <> lPlayer.pTime Then frmInterface.lblTime.Caption = UCase(lPlayer.pTime)
        'If frmInterface.lblTime.Visible = False Then frmInterface.lblTime.Visible = True
    End If
End If
If Err.Number <> 0 Then Err.Number = 0
'If Err.Number <> 0 Then SetError "tmrCurrentTime_Timer()", Err.Description
End Sub

Private Sub tmrFullScreen_Timer()
On Local Error Resume Next
FullScreen True
tmrFullScreen.Enabled = False
If Err.Number <> 0 Then SetError "tmrFullscreen_Timer()", Err.Description
End Sub

Private Sub tmrHideOSD_Timer()
On Local Error Resume Next
picOSD.Visible = False
lblOSD.Caption = ""
tmrHideOSD.Enabled = False
If Err.Number <> 0 Then SetError "tmrFullscreen_Timer()", Err.Description
End Sub

Private Sub tmrObjects_Timer()
On Local Error Resume Next
Dim msg As String
If Me.ctlDVD.PlayState = dvdState_Running Then
    msg = "Playing"
ElseIf Me.ctlDVD.PlayState = dvdState_Paused Then
    msg = "Paused"
ElseIf Me.ctlDVD.PlayState = dvdState_Stopped Then
    msg = "Stopped"
End If
If mnuMute.Checked = True Then
    StatusBar1.Panels.Item(3).Bevel = sbrRaised
ElseIf Me.mnuMute.Checked = False Then
    StatusBar1.Panels.Item(3).Bevel = sbrInset
End If
With StatusBar1.Panels
    .Item(1) = "nexDVD " & App.Major & "." & App.Minor
    .Item(2) = msg
    If StatusBar1.Panels.Item(3).Bevel = sbrRaised Then
        .Item(3) = "Muted"
    Else
        .Item(3) = "Sound On"
    End If
    .Item(4) = lPlayer.pTitle & Space$(5) & lPlayer.pChapter
    .Item(5) = lPlayer.pTime
    .Item(6) = lPlayer.pLength
End With
If lSettings.sUseDVDInterface = True Then
    If LCase(Trim(lPlayer.pChapter)) = "chapter: 0" Then
        'If frmInterface.lblChapter.Caption <> "MENU" Then frmInterface.lblChapter.Caption = "MENU"
    Else
        'If frmInterface.lblChapter.Caption <> UCase(lPlayer.pChapter) Then frmInterface.lblChapter.Caption = UCase(lPlayer.pChapter)
    End If
End If
If Err.Number <> 0 Then SetError "tmrObjects_Timer", Err.Description
End Sub

'Private Sub wskUpdate_Close()
'On Local Error Resume Next
'Dim msg As String, msg2 As String
'If Len(lUpdateINI) <> 0 Then
'    wskUpdate.Close: wskUpdate.Tag = "CLOSED"
'    If DoesFileExist(lINIFiles.iUpdate) = True Then Kill lINIFiles.iUpdate: DoEvents
'    SaveFile lINIFiles.iUpdate, lUpdateINI: DoEvents
'    msg2 = ReadINI(lINIFiles.iUpdate, "Settings", "Version", "")
'    If Len(msg2) <> 0 Then
        'If msg2 <> App.Major & "." & App.Minor Then frmLatestVersionCheck.Show
'    End If
'Else
'    wskUpdate.Close: wskUpdate.Tag = "CLOSED"
'End If
'If Err.Number <> 0 Then SetError "wskUpdate_Close()", Err.Description
'End Sub

Public Function SaveFile(lFilename As String, lText As String) As Boolean
On Local Error Resume Next
If Len(lFilename) <> 0 And Len(lText) <> 0 Then
    If InStr(lFilename, "\\") Then
        SetError "SaveFile", "Double \\'s were used"
        Exit Function
    End If
    Open lFilename For Output As #10
    If Err.Number <> 0 Then
        Close #10
        SetError "SaveFile", Err.Description
        Exit Function
    End If
    Print #10, lText
    Close #10
End If
If Err.Number <> 0 Then SetError "SaveFile()", Err.Description
End Function
