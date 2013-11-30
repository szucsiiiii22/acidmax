VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Begin VB.Form frmSettings 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "nexDVD - Settings"
   ClientHeight    =   2955
   ClientLeft      =   150
   ClientTop       =   2505
   ClientWidth     =   5415
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2955
   ScaleWidth      =   5415
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   615
      Left            =   0
      ScaleHeight     =   615
      ScaleWidth      =   5535
      TabIndex        =   0
      Top             =   2520
      Width           =   5535
      Begin VB.CommandButton cmdCancel 
         Cancel          =   -1  'True
         Caption         =   "&Cancel"
         Height          =   255
         Left            =   4320
         TabIndex        =   10
         Top             =   120
         Width           =   975
      End
      Begin VB.CheckBox chkThisSessionOnly 
         BackColor       =   &H00FFFFFF&
         Caption         =   "This session only"
         Height          =   255
         Left            =   120
         TabIndex        =   9
         Top             =   120
         Width           =   1815
      End
      Begin VB.CommandButton cmdClose 
         Caption         =   "OK"
         Default         =   -1  'True
         Height          =   255
         Left            =   3240
         TabIndex        =   1
         Top             =   120
         Width           =   975
      End
      Begin VB.Line Line1 
         BorderColor     =   &H00000000&
         BorderWidth     =   4
         X1              =   0
         X2              =   5400
         Y1              =   0
         Y2              =   0
      End
   End
   Begin VB.Frame fraSettings 
      BorderStyle     =   0  'None
      Caption         =   "Player"
      Height          =   2055
      Index           =   2
      Left            =   120
      TabIndex        =   5
      Top             =   360
      Width           =   5175
      Begin VB.CheckBox chkSubtitlesOn 
         Appearance      =   0  'Flat
         Caption         =   "Use subtitles"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   30
         Top             =   1320
         Width           =   2895
      End
      Begin VB.CheckBox chkPlayOnRootMenuFail 
         Appearance      =   0  'Flat
         Caption         =   "Play when root menu is not found"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   29
         Top             =   1080
         Width           =   2895
      End
      Begin VB.CheckBox chkAutoPlayMenu 
         Appearance      =   0  'Flat
         Caption         =   "Auto play menu on auto play"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   27
         Top             =   840
         Width           =   5055
      End
      Begin VB.CheckBox chkAutoPlayOnStart 
         Appearance      =   0  'Flat
         Caption         =   "Auto play on start"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   17
         Top             =   120
         Width           =   2415
      End
      Begin VB.CheckBox chkAutoPlayOnInster 
         Appearance      =   0  'Flat
         Caption         =   "Auto play on insert"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   16
         Top             =   600
         Width           =   2415
      End
      Begin VB.CheckBox chkAutoFullScreenOnPlay 
         Appearance      =   0  'Flat
         Caption         =   "Auto full screen on play"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   18
         Top             =   360
         Width           =   2415
      End
   End
   Begin VB.Frame fraSettings 
      BorderStyle     =   0  'None
      Caption         =   "Links"
      Height          =   2055
      Index           =   3
      Left            =   120
      TabIndex        =   13
      Top             =   360
      Width           =   5175
      Begin VB.Label Label3 
         Caption         =   "The Nexgen Homepage:"
         Height          =   255
         Left            =   120
         TabIndex        =   15
         Top             =   120
         Width           =   2295
      End
      Begin VB.Label label2 
         Caption         =   "http://www.team-nexgen.com"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   2520
         MouseIcon       =   "frmSettings.frx":0000
         MousePointer    =   99  'Custom
         TabIndex        =   14
         Top             =   120
         Width           =   2535
      End
   End
   Begin VB.Frame fraSettings 
      BorderStyle     =   0  'None
      Caption         =   "Display"
      Height          =   2055
      Index           =   1
      Left            =   120
      TabIndex        =   4
      Top             =   360
      Width           =   5175
      Begin VB.CheckBox chkShowIconInSystray 
         Appearance      =   0  'Flat
         Caption         =   "Show icon in systray"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   26
         Top             =   120
         Width           =   2415
      End
      Begin VB.CheckBox chkRememberWindowPositions 
         Appearance      =   0  'Flat
         Caption         =   "Remember window positions"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   25
         Top             =   360
         Width           =   2415
      End
      Begin VB.CheckBox chkUseDVDInterFace 
         Appearance      =   0  'Flat
         Caption         =   "Use DVD Interface"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   24
         Top             =   600
         Width           =   2415
      End
      Begin VB.CheckBox chkShowSplash 
         Appearance      =   0  'Flat
         Caption         =   "Show splash"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   23
         Top             =   840
         Width           =   2415
      End
      Begin VB.CheckBox chkShowStatusBar 
         Appearance      =   0  'Flat
         Caption         =   "Show Status bar"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   22
         Top             =   1080
         Width           =   2535
      End
      Begin VB.CheckBox chkShowDVDTime 
         Appearance      =   0  'Flat
         Caption         =   "Show DVD Time"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   21
         Top             =   1320
         Width           =   2535
      End
      Begin VB.CheckBox chkMenuVisible 
         Appearance      =   0  'Flat
         Caption         =   "Menu visible on main form"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   20
         Top             =   1560
         Width           =   2655
      End
      Begin VB.CheckBox chkUseOnScreenDisplay 
         Appearance      =   0  'Flat
         Caption         =   "Use on screen display"
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   120
         TabIndex        =   19
         Top             =   1800
         Width           =   2535
      End
   End
   Begin VB.Frame fraSettings 
      BorderStyle     =   0  'None
      Caption         =   "General"
      Height          =   2055
      Index           =   0
      Left            =   120
      TabIndex        =   3
      Top             =   360
      Width           =   5175
      Begin VB.CheckBox chkCheckForUpdates 
         Appearance      =   0  'Flat
         Caption         =   "Check For Updates"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   28
         Top             =   1320
         Width           =   2775
      End
      Begin VB.CheckBox chkCaptureMode 
         Appearance      =   0  'Flat
         Caption         =   "Capture Mode"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   12
         Top             =   360
         Width           =   2415
      End
      Begin VB.CheckBox chkShowErrors 
         Appearance      =   0  'Flat
         Caption         =   "Display Errors"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   11
         Top             =   600
         Width           =   2415
      End
      Begin VB.CheckBox chkClickOnceToExitFullScreen 
         Appearance      =   0  'Flat
         Caption         =   "Double click to exit full screen"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   8
         Top             =   840
         Width           =   2655
      End
      Begin VB.CheckBox chkAlwaysOnTop 
         Appearance      =   0  'Flat
         Caption         =   "Always on top"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   7
         Top             =   120
         Width           =   2415
      End
      Begin VB.CheckBox chkStartWithWindows 
         Appearance      =   0  'Flat
         Caption         =   "Start with Windows"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Top             =   1080
         Width           =   2415
      End
   End
   Begin MSComctlLib.TabStrip tabSettings 
      Height          =   2535
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   5415
      _ExtentX        =   9551
      _ExtentY        =   4471
      MultiRow        =   -1  'True
      Separators      =   -1  'True
      TabStyle        =   1
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   4
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "General"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Display"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Player"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab4 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Links"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmSettings"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private lFrameIndex As Integer
Private lFrameCount As Integer

Private Sub SaveSettings()
On Local Error Resume Next
Dim mbox As VbMsgBoxResult, lGoCaptureMode As Boolean, lUnloadCapMode As Boolean
If lSettings.sMenuVisibleOnMainForm = False And chkMenuVisible.Value = 1 Then
    frmMain.mnuControls.Visible = True
ElseIf lSettings.sMenuVisibleOnMainForm = True And chkMenuVisible.Value = 0 Then
    frmMain.mnuControls.Visible = False
End If
If lSettings.sShowStatusBar = False And chkShowStatusBar.Value = 1 Then
    frmMain.StatusBar1.Visible = True
ElseIf lSettings.sShowStatusBar = True And chkShowStatusBar.Value = 0 Then
    frmMain.StatusBar1.Visible = False
End If

If lSettings.sCaptureMode = False And chkCaptureMode.Value = 1 Then
    mbox = MsgBox("Switching to capture mode requires nexDVD to reload. Are you sure you wish to do this?", vbYesNo + vbQuestion)
    If mbox = vbYes Then
        lGoCaptureMode = True
    ElseIf mbox = vbNo Then
        chkCaptureMode.Value = 0
    End If
ElseIf lSettings.sCaptureMode = True And chkCaptureMode.Value = 0 Then
    mbox = MsgBox("Switching capture mode off requires nexDVD to reload. Are you sure you wish to do this?", vbYesNo + vbQuestion)
    If mbox = vbYes Then
        lUnloadCapMode = True
    ElseIf mbox = vbNo Then
        chkCaptureMode.Value = 1
    End If
End If
If lSettings.sShowIconInSystray = True And chkShowIconInSystray.Value = 0 Then
    Call Shell_NotifyIcon(NIM_DELETE, try)
    Unload frmTray
ElseIf lSettings.sShowIconInSystray = False And chkShowIconInSystray.Value = 1 Then
    try.cbSize = Len(try)
    try.hwnd = frmTray.hwnd
    try.uId = vbNull
    try.uFlags = NIF_ICON Or NIF_TIP Or NIF_MESSAGE
    try.uCallBackMessage = WM_MOUSEMOVE
    try.hIcon = frmMain.Icon
    try.szTip = "nexDVD"
    'try.szTip = App.Title
    Call Shell_NotifyIcon(NIM_ADD, try)
    Call Shell_NotifyIcon(NIM_MODIFY, try)
End If
If lSettings.sUseDVDInterface = True And chkUseDVDInterFace.Value = 0 Then
    'Unload frmInterface
ElseIf lSettings.sUseDVDInterface = False And chkUseDVDInterFace.Value = 1 Then
    'frmInterface.Show
'    frmInterface.Visible = True
'    frmInterface.Left = 0
'    frmInterface.Top = 0
    'frmMain.Top = frmInterface.Height
    'frmMain.Height = Screen.Height - frmInterface.Height - 450
'    frmMain.Left = 0
    
    'frmMain.Width = Screen.Width
End If
If chkSubtitlesOn.Value = 0 And lSettings.sSubpictureOn = True Then
    ctlDVD.SubpictureOn = False
ElseIf chkSubtitlesOn.Value = 1 And lSettings.sSubpictureOn = False Then
    ctlDVD.SubpictureOn = True
End If
lSettings.sPlayOnRootMenuFail = GetCheckboxValue(chkPlayOnRootMenuFail)
lSettings.sAlwaysOnTop = GetCheckboxValue(chkAlwaysOnTop)
lSettings.sStartWithWindows = GetCheckboxValue(chkStartWithWindows)
lSettings.sAutoPlayOnStart = GetCheckboxValue(chkAutoPlayOnStart)
lSettings.sAutoFullScreenOnPlay = GetCheckboxValue(chkAutoFullScreenOnPlay)
lSettings.sShowIconInSystray = GetCheckboxValue(chkShowIconInSystray)
lSettings.sSingleClickToExitFullScreen = GetCheckboxValue(chkClickOnceToExitFullScreen)
lSettings.sRememberWindowPosition = GetCheckboxValue(chkRememberWindowPositions)
lSettings.sUseDVDInterface = GetCheckboxValue(chkUseDVDInterFace)
lSettings.sShowSplash = GetCheckboxValue(chkShowSplash)
lSettings.sShowErrors = GetCheckboxValue(chkShowErrors)
lSettings.sCaptureMode = GetCheckboxValue(chkCaptureMode)
lSettings.sShowStatusBar = GetCheckboxValue(chkShowStatusBar)
lSettings.sShowDVDTime = GetCheckboxValue(chkShowDVDTime)
lSettings.sAutoPlayOnInsert = GetCheckboxValue(chkAutoPlayOnInster)
lSettings.sUseOnScreenDisplay = GetCheckboxValue(chkUseOnScreenDisplay)
lSettings.sMenuVisibleOnMainForm = GetCheckboxValue(chkMenuVisible)
lSettings.sAutoPlayMenuOnAutoPlay = GetCheckboxValue(chkAutoPlayMenu)
lSettings.sCheckForUpdates = GetCheckboxValue(chkCheckForUpdates)
lSettings.sSubpictureOn = GetCheckboxValue(chkSubtitlesOn)
If lSettings.sAlwaysOnTop = True Then
    AlwaysOnTop frmMain, True
    'If lSettings.sUseDVDInterface = True Then AlwaysOnTop frmInterface, True
Else
    AlwaysOnTop frmMain, False
    'If lSettings.sUseDVDInterface = True Then AlwaysOnTop frmInterface, False
End If
If chkThisSessionOnly.Value = 0 Then
    WriteINI lINIFiles.iSettings, "Settings", "PlayOnRootMenuFail", lSettings.sPlayOnRootMenuFail
    WriteINI lINIFiles.iSettings, "Settings", "AlwaysOnTop", lSettings.sAlwaysOnTop
    WriteINI lINIFiles.iSettings, "Settings", "AutoFullScreenOnPlay", lSettings.sAutoFullScreenOnPlay
    WriteINI lINIFiles.iSettings, "Settings", "AutoPlayOnStart", lSettings.sAutoPlayOnStart
    WriteINI lINIFiles.iSettings, "Settings", "ShowIconInSystray", lSettings.sShowIconInSystray
    WriteINI lINIFiles.iSettings, "Settings", "SingleClickToExitFullScreen", lSettings.sSingleClickToExitFullScreen
    WriteINI lINIFiles.iSettings, "Settings", "StartWithWindows", lSettings.sStartWithWindows
    WriteINI lINIFiles.iSettings, "Settings", "RememberWindowPosition", lSettings.sRememberWindowPosition
    WriteINI lINIFiles.iSettings, "Settings", "UseDVDInterface", lSettings.sUseDVDInterface
    WriteINI lINIFiles.iSettings, "Settings", "ShowSplash", lSettings.sShowSplash
    WriteINI lINIFiles.iSettings, "Settings", "ShowErrors", lSettings.sShowErrors
    WriteINI lINIFiles.iSettings, "Settings", "CaptureMode", lSettings.sCaptureMode
    WriteINI lINIFiles.iSettings, "Settings", "ShowStatusBar", lSettings.sShowStatusBar
    WriteINI lINIFiles.iSettings, "Settings", "ShowDVDTime", lSettings.sShowDVDTime
    WriteINI lINIFiles.iSettings, "Settings", "AutoPlayOnInsert", lSettings.sAutoPlayOnInsert
    WriteINI lINIFiles.iSettings, "Settings", "MenuVisibleOnMainForm", lSettings.sMenuVisibleOnMainForm
    WriteINI lINIFiles.iSettings, "Settings", "UseOnScreenDisplay", lSettings.sUseOnScreenDisplay
    WriteINI lINIFiles.iSettings, "Settings", "AutoPlayMenuOnAutoPlay", lSettings.sAutoPlayMenuOnAutoPlay
    WriteINI lINIFiles.iSettings, "Settings", "CheckForUpdates", lSettings.sCheckForUpdates
    WriteINI lINIFiles.iSettings, "Settings", "CheckForUpdates", lSettings.sSubpictureOn
End If
If lGoCaptureMode = True Then
    LoadCaptureMode
    lUnloadCapMode = False
ElseIf lUnloadCapMode = True Then
    UnloadCaptureMode
End If
If Err.Number <> 0 Then SetError "SaveSettings", Err.Description
End Sub

Private Sub ResetFrame(lIndex As Integer)
On Local Error Resume Next
Dim i As Integer
lFrameCount = fraSettings.Count - 1
If lIndex = lFrameIndex Then
    Exit Sub
Else
    For i = 0 To lFrameCount
        fraSettings(i).Visible = False
    Next i
    DoEvents
    fraSettings(lIndex).Visible = True
    lFrameIndex = lIndex
End If
If Err.Number <> 0 Then SetError "ResetFrame", Err.Description
End Sub

Private Sub cmdCancel_Click()
On Local Error Resume Next
Unload Me
End Sub

Private Sub cmdClose_Click()
On Local Error Resume Next
SaveSettings
Unload Me
End Sub

Private Sub Form_Load()
On Local Error Resume Next
If lSettings.sAlwaysOnTop = True Then chkAlwaysOnTop.Value = 1
If lSettings.sAutoFullScreenOnPlay = True Then chkAutoFullScreenOnPlay.Value = 1
If lSettings.sAutoPlayOnStart = True Then chkAutoPlayOnStart.Value = 1
If lSettings.sShowIconInSystray = True Then chkShowIconInSystray.Value = 1
If lSettings.sSingleClickToExitFullScreen = True Then chkClickOnceToExitFullScreen.Value = 1
If lSettings.sStartWithWindows = True Then chkStartWithWindows.Value = 1
If lSettings.sRememberWindowPosition = True Then chkRememberWindowPositions.Value = 1
If lSettings.sUseDVDInterface = True Then chkUseDVDInterFace.Value = 1
If lSettings.sShowSplash = True Then chkShowSplash.Value = 1
If lSettings.sShowErrors = True Then chkShowErrors.Value = 1
If lSettings.sCaptureMode = True Then chkCaptureMode.Value = 1
If lSettings.sShowStatusBar = True Then chkShowStatusBar.Value = 1
If lSettings.sShowDVDTime = True Then chkShowDVDTime.Value = 1
If lSettings.sAutoPlayOnInsert = True Then chkAutoPlayOnInster.Value = 1
If lSettings.sMenuVisibleOnMainForm = True Then chkMenuVisible.Value = 1
If lSettings.sUseOnScreenDisplay = True Then chkUseOnScreenDisplay.Value = 1
If lSettings.sAutoPlayMenuOnAutoPlay = True Then chkAutoPlayMenu.Value = 1
If lSettings.sCheckForUpdates = True Then chkCheckForUpdates.Value = 1
If lSettings.sPlayOnRootMenuFail = True Then chkPlayOnRootMenuFail.Value = 1
If lSettings.sSubpictureOn = True Then chkSubtitlesOn.Value = 1
lFrameIndex = 1
ResetFrame 0
AlwaysOnTop Me, True
'SetForm  True, Me
If Err.Number <> 0 Then SetError "Form_Load", Err.Description
End Sub

Private Sub Form_Unload(Cancel As Integer)
On Local Error Resume Next
'SetForm False, Me
AlwaysOnTop Me, False
If Err.Number <> 0 Then SetError "Form_Load", Err.Description
End Sub

Private Sub Label2_Click()
Surf "http://www.tnexgen.com"
End Sub

Private Sub tabSettings_Click()
On Local Error Resume Next
Dim i As Integer
i = tabSettings.SelectedItem.Index - 1
ResetFrame i
If Err.Number <> 0 Then SetError "tabSettings_Click", Err.Description
End Sub
