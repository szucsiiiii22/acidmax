Attribute VB_Name = "mdlSubs"
Option Explicit
Public Declare Sub ReleaseCapture Lib "user32" ()
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Integer, ByVal lParam As Long) As Long
Public Enum MenuTypes
    mRoot = 3
    mTitles = 4
End Enum

Public Function GoMenu(lMenu As Integer)
On Local Error Resume Next
frmMain.ctlDVD.ShowMenu lMenu
If Err.Number <> 0 Then
    Err.Number = 0
    OnScreenDisplay "Menu not found"
End If
If Err.Number <> 0 Then SetError "GoMenu", Err.Description
End Function

Public Function DoesDirExist(lDirectory As String) As Boolean
On Local Error Resume Next
Dim msg As String
msg = Dir(lDirectory, vbDirectory)
If Len(msg) <> 0 Then
    DoesDirExist = True
Else
    DoesDirExist = False
End If
If Err.Number <> 0 Then SetError "DoesDirExist", Err.Description
End Function

Public Sub MakeDir(lDirectory As String)
On Local Error Resume Next
If Len(lDirectory) <> 0 Then
    If Right(lDirectory, 1) <> "\" Then lDirectory = lDirectory & "\"
    MkDir lDirectory
End If
If Err.Number <> 0 Then SetError "MakeDir", Err.Description
End Sub

Public Function CheckFileConstants(lDirectory As String, lFilename As String) As Boolean
On Local Error Resume Next
Dim msg As String
If DoesDirExist(lDirectory) = False Then MakeDir lDirectory
If DoesFileExist(lFilename) = True Then
    msg = MsgBox("File already exists, delete existing wav file and continue?", vbYesNoCancel + vbExclamation, "Overwrite?")
    If msg = vbYes Then
        Kill lFilename
        If DoesFileExist(lFilename) Then
            MsgBox "File is in use, aborting!", vbExclamation
            Err = 0
            Exit Function
        End If
        If Err.Number = 70 Then
            Err = 0
            Exit Function
        End If
    ElseIf msg = vbNo Then
        Exit Function
    ElseIf msg = vbCancel Then
        Exit Function
    End If
    CheckFileConstants = True
Else
    CheckFileConstants = True
End If
CheckFileConstants = True
If Err.Number <> 0 Then SetError "CheckFileConstants", Err.Description
End Function

Public Function GetFileTitle(lFilename As String) As String
On Local Error Resume Next
If Len(lFilename) <> 0 Then
Again:
    If InStr(lFilename, "\") Then
        lFilename = Right(lFilename, Len(lFilename) - InStr(lFilename, "\"))
        If InStr(lFilename, "\") Then
            GoTo Again
        Else
            GetFileTitle = lFilename
        End If
    Else
        GetFileTitle = lFilename
    End If
Else
    Exit Function
End If
If Err.Number <> 0 Then SetError "GetFileTitle()", Err.Description
End Function

Public Sub AutoPlay()
On Local Error Resume Next
If lSettings.sAutoPlayOnStart = True Then
    If lSettings.sAutoPlayMenuOnAutoPlay = True Then
        PlayerState eNavigatingMenu
    Else
        PlayerState ePlay
    End If
End If
If Err.Number <> 0 Then SetError "AutoPlay", Err.Description
End Sub

Public Function FindComoboxIndex(lCombo As ComboBox, lText As String) As Integer
On Local Error Resume Next
Dim i As Integer
If Len(lText) <> 0 Then
    For i = 0 To lCombo.ListCount
        If LCase(lCombo.List(i)) = LCase(lText) Then
            FindComoboxIndex = i
            Exit For
            Exit Function
        End If
    Next i
End If
If Err.Number <> 0 Then SetError "FindComboIndex", Err.Description
End Function

Public Sub Mute(lMuted As Boolean)
On Local Error Resume Next
If lMuted = True Then
    OnScreenDisplay "Muted"
    frmMain.ctlDVD.Mute = True
    frmMain.mnuMute.Checked = True
Else
    OnScreenDisplay "Sound On"
    frmMain.ctlDVD.Mute = False
    frmMain.mnuMute.Checked = False
End If
If Err.Number <> 0 Then SetError "Mute()", Err.Description
End Sub

Public Sub PlayerVisible(lEnabled As Boolean)
On Local Error Resume Next
If lEnabled = True Then
    lPlayerVisToggle = False
    frmMain.WindowState = vbNormal
    frmMain.Visible = True
    If lSettings.sUseDVDInterface = True Then
'        frmInterface.WindowState = vbNormal
'        frmInterface.Visible = True
    End If
Else
    lPlayerVisToggle = True
    frmMain.WindowState = vbMinimized
    frmMain.Visible = False
    If lSettings.sUseDVDInterface = True Then
'        frmInterface.WindowState = vbMinimized
'        frmInterface.Visible = False
    End If
End If
If Err.Number <> 0 Then SetError "PlayerVisible()", Err.Description
End Sub

Public Sub PlayerMenu(lStatus As EventTypes)
On Local Error Resume Next

With frmMain
    Select Case lStatus
    Case eNavigatingMenu
        .mnuCapture.Enabled = True
        .mnuBookmark.Enabled = True
'        .mnuRipper.Enabled = False
        .mnuSlowMotion.Enabled = True
        .mnuLanguage.Enabled = True
        .mnuPlay.Enabled = False
        .mnuPause.Enabled = True
        .mnuStop.Enabled = True
        .mnuStep.Enabled = True
        .mnuFastForward.Enabled = True
        .mnuRewind.Enabled = True
        .mnuChapters.Enabled = True
        .mnuFullScreen.Enabled = True
        .mnuMenu.Enabled = True
    Case eDiscEjected
        .mnuCapture.Enabled = False
        .mnuBookmark.Enabled = False
'        .mnuRipper.Enabled = False
        .mnuSlowMotion.Enabled = False
        .mnuLanguage.Enabled = False
        .mnuPlay.Enabled = False
        .mnuPause.Enabled = False
        .mnuStop.Enabled = False
        .mnuStep.Enabled = False
        .mnuFastForward.Enabled = False
        .mnuRewind.Enabled = False
        .mnuChapters.Enabled = False
        .mnuFullScreen.Enabled = False
        .mnuMenu.Enabled = False
    Case eFastForward
        .mnuBookmark.Enabled = False
        .mnuCapture.Enabled = False
'        .mnuRipper.Enabled = False
        .mnuSlowMotion.Enabled = False
        .mnuLanguage.Enabled = False
        .mnuPlay.Enabled = True
        .mnuPause.Enabled = False
        .mnuStop.Enabled = False
        .mnuStep.Enabled = False
        .mnuFastForward.Enabled = True
        .mnuRewind.Enabled = False
        .mnuChapters.Enabled = False
        .mnuFullScreen.Enabled = False
        .mnuMenu.Enabled = False
    Case eNewDisc
        .mnuBookmark.Enabled = False
        .mnuCapture.Enabled = False
'        .mnuRipper.Enabled = True
        .mnuSlowMotion.Enabled = False
        .mnuLanguage.Enabled = False
        .mnuPlay.Enabled = True
        .mnuPause.Enabled = False
        .mnuStop.Enabled = False
        .mnuStep.Enabled = False
        .mnuFastForward.Enabled = False
        .mnuRewind.Enabled = False
        .mnuChapters.Enabled = False
        .mnuFullScreen.Enabled = False
        .mnuMenu.Enabled = True
    Case eNoDisc
        .mnuBookmark.Enabled = False
        .mnuCapture.Enabled = False
'        .mnuRipper.Enabled = False
        .mnuSlowMotion.Enabled = False
        .mnuLanguage.Enabled = False
        .mnuPlay.Enabled = False
        .mnuPause.Enabled = False
        .mnuStop.Enabled = False
        .mnuStep.Enabled = False
        .mnuFastForward.Enabled = False
        .mnuRewind.Enabled = False
        .mnuChapters.Enabled = False
        .mnuFullScreen.Enabled = False
        .mnuMenu.Enabled = False
    Case eNoDrive
        .mnuBookmark.Enabled = False
        .mnuCapture.Enabled = False
        '.mnuRipper.Enabled = False
        .mnuSlowMotion.Enabled = False
        .mnuLanguage.Enabled = False
        .mnuPlay.Enabled = False
        .mnuPause.Enabled = False
        .mnuStop.Enabled = False
        .mnuStep.Enabled = False
        .mnuFastForward.Enabled = False
        .mnuRewind.Enabled = False
        .mnuChapters.Enabled = False
        .mnuFullScreen.Enabled = False
        .mnuMenu.Enabled = False
    Case ePaused
        .mnuBookmark.Enabled = False
        .mnuCapture.Enabled = True
        '.mnuRipper.Enabled = False
        .mnuSlowMotion.Enabled = False
        .mnuLanguage.Enabled = False
        .mnuPlay.Enabled = True
        .mnuPause.Enabled = False
        .mnuStop.Enabled = False
        .mnuStep.Enabled = False
        .mnuFastForward.Enabled = False
        .mnuRewind.Enabled = False
        .mnuChapters.Enabled = False
        .mnuFullScreen.Enabled = False
        .mnuMenu.Enabled = False
    Case ePlay
        .mnuBookmark.Enabled = True
        .mnuCapture.Enabled = True
        '.mnuRipper.Enabled = False
        .mnuSlowMotion.Enabled = True
        .mnuLanguage.Enabled = True
        .mnuPlay.Enabled = False
        .mnuPause.Enabled = True
        .mnuStop.Enabled = True
        .mnuStep.Enabled = True
        .mnuFastForward.Enabled = True
        .mnuRewind.Enabled = True
        .mnuChapters.Enabled = True
        .mnuFullScreen.Enabled = True
        .mnuMenu.Enabled = True
    Case eRewind
        .mnuBookmark.Enabled = False
        .mnuCapture.Enabled = False
        '.mnuRipper.Enabled = False
        .mnuPlay.Enabled = True
        .mnuPause.Enabled = False
        .mnuStop.Enabled = False
        .mnuStep.Enabled = False
        .mnuFastForward.Enabled = False
        .mnuRewind.Enabled = False
        .mnuChapters.Enabled = False
        .mnuFullScreen.Enabled = False
        .mnuMenu.Enabled = True
    Case eStopped
        .mnuSlowMotion.Enabled = False
        .mnuCapture.Enabled = False
        .mnuLanguage.Enabled = False
        .mnuBookmark.Enabled = False
        '.mnuRipper.Enabled = True
        .mnuPlay.Enabled = True
        .mnuPause.Enabled = False
        .mnuStop.Enabled = False
        .mnuStep.Enabled = False
        .mnuFastForward.Enabled = False
        .mnuRewind.Enabled = False
        .mnuChapters.Enabled = False
        .mnuFullScreen.Enabled = False
        .mnuMenu.Enabled = False
    End Select
End With
If Err.Number <> 0 Then SetError "PlayerMenu", Err.Description
End Sub

Public Function ShowMenu(lMenu As MenuTypes)
On Local Error Resume Next
PlayerState eStopped
lPlayer.pStatus = sPlaying
With frmMain
    .ctlDVD.ShowMenu lMenu
End With
If Err.Number <> 0 Then SetError "ShowMenu()", Err.Description
End Function

Public Function GetCheckboxValue(lCheckbox As CheckBox) As Boolean
On Local Error Resume Next
If lCheckbox.Value = 1 Then
    GetCheckboxValue = True
Else
    GetCheckboxValue = False
End If
If Err.Number <> 0 Then SetError "GetCheckboxValue()", Err.Description
End Function

Public Sub PlayerObjects(lType As Long)
On Local Error Resume Next
'264 = playing intro
'265 = playing menu
'257 = stopped
'282 = playing
'260 = playing
'280 = ejected
'281 = new disc
'511 = paused
'13 = idle
Select Case lType
Case 280 ' disc ejected
    lPlayer.pTitle = ""
    PlayerMenu eDiscEjected
    SetCaption frmMain, eDiscEjected
    lPlayer.pStatus = sIdle
    lPlayer.pFastForwarding = False
    lPlayer.pRewinding = False
    frmMain.tmrCurrentTime.Enabled = False
    frmMain.StatusBar1.Panels.Item(2).Bevel = sbrRaised
    frmMain.StatusBar1.Panels.Item(2).Enabled = False
    'If lSettings.sUseDVDInterface = True And frmInterface.lblChapter.Caption <> "-" Then
    '    frmInterface.lblChapter.Caption = "-"
    '    frmInterface.lblVideo.Caption = "-"
    '    frmInterface.lblChapter.Caption = "-"
    '    frmInterface.lblTime.Caption = "-"
    'End If
    frmMain.ctlDVD.Visible = False
Case 13 ' no disc
    SetCaption frmMain, eNoDisc
    PlayerMenu eNoDisc
    lPlayer.pStatus = sIdle
    lPlayer.pFastForwarding = False
    lPlayer.pRewinding = False
    frmMain.tmrCurrentTime.Enabled = False
    frmMain.StatusBar1.Panels.Item(2).Bevel = sbrRaised
    frmMain.StatusBar1.Panels.Item(2).Enabled = False
    'If lSettings.sUseDVDInterface = True And frmInterface.lblChapter.Caption <> "-" Then frmInterface.lblChapter = "-"
    frmMain.ctlDVD.Visible = False
Case 264 ' navigate menu
    If Not Right(LCase(frmMain.Caption), 7) = "playing" Then
        SetCaption frmMain, eNavigatingMenu
        PlayerMenu eNavigatingMenu
    End If
    lPlayer.pStatus = sIdle
    '    If lSettings.sUseDVDInterface = True And frmInterface.lblChapter.Caption <> "-" Then frmInterface.lblChapter = "-"
    frmMain.tmrCurrentTime.Enabled = False
    frmMain.ctlDVD.Visible = True
Case 265 ' navigate menu
    If Not Right(LCase(frmMain.Caption), 7) = "playing" Then
        SetCaption frmMain, eNavigatingMenu
        PlayerMenu eNavigatingMenu
    End If
    lPlayer.pStatus = sIdle
    'If lSettings.sUseDVDInterface = True And frmInterface.lblChapter.Caption <> "-" Then frmInterface.lblChapter = "-"
    frmMain.tmrCurrentTime.Enabled = False
    frmMain.ctlDVD.Visible = True
Case 257 ' stopped
    SetCaption frmMain, eStopped
    PlayerMenu eStopped
    frmMain.tmrCurrentTime.Enabled = False
    frmMain.ctlDVD.Visible = False
Case 36 ' step / slow motion
Case 260 ' play
    If lPlayer.pStatus <> sPaused Then
        If Not Right(LCase(frmMain.Caption), 7) = "playing" Then
        'If Not InStr(LCase(frmMain.Caption), "play") Then
            SetCaption frmMain, ePlay
            PlayerMenu ePlay
        End If
        lPlayer.pTime = "Time: " & Mid$(frmMain.ctlDVD.CurrentTime, 1, 8)
        lPlayer.pChapter = "Chapter: " & frmMain.ctlDVD.CurrentChapter
        lPlayer.pLength = "Length: " & Left$(frmMain.ctlDVD.TotalTitleTime, 8)
        frmMain.StatusBar1.Panels.Item(2).Bevel = sbrInset
        frmMain.StatusBar1.Panels.Item(2).Enabled = True
        frmMain.tmrCurrentTime.Enabled = True
        frmMain.ctlDVD.Visible = True
    End If
Case 282 ' play
    If lPlayer.pStatus <> sPaused Then
        If Not Right(LCase(frmMain.Caption), 7) = "playing" Then
        'If InStr(LCase(frmMain.Caption), "play") Then
            SetCaption frmMain, ePlay
            PlayerMenu ePlay
        End If
        If frmMain.mnuChapters.Enabled = False Then
            SetCaption frmMain, ePlay
            PlayerMenu ePlay
        End If
        If frmMain.ctlDVD.PlayState = dvdState_Running Then
            lPlayer.pTime = "Time: " & Mid$(frmMain.ctlDVD.CurrentTime, 1, 8)
            lPlayer.pChapter = "Chapter: " & frmMain.ctlDVD.CurrentChapter
            lPlayer.pLength = "Length: " & Left$(frmMain.ctlDVD.TotalTitleTime, 8)
            frmMain.StatusBar1.Panels.Item(2).Bevel = sbrInset
            frmMain.StatusBar1.Panels.Item(2).Enabled = True
            frmMain.tmrCurrentTime.Enabled = True
            frmMain.ctlDVD.Visible = True
        End If
    End If
Case 281 ' new disc
    PlayerMenu eNewDisc
    SetCaption frmMain, eNewDisc
    frmMain.tmrCurrentTime.Enabled = False
    frmMain.ctlDVD.Visible = False
    If lSettings.sAutoPlayOnInsert = True Then frmMain.GoRootMenu
Case 511 ' paused
    PlayerMenu ePaused
    SetCaption frmMain, ePaused
    frmMain.StatusBar1.Panels.Item(2).Bevel = sbrRaised
    frmMain.tmrCurrentTime.Enabled = False
    frmMain.ctlDVD.Visible = True
End Select
If Err.Number <> 0 Then SetError "PlayerObjects()", Err.Description
End Sub

Public Sub PlayerState(lEventType As EventTypes)
On Local Error Resume Next
Dim i As Integer
Select Case lEventType
Case eNavigatingMenu
    With frmMain
        If lSettings.sUseDVDInterface = True Then
'            frmInterface.lblChapter.Caption = "-"
'            frmInterface.lblTime.Caption = "-"
        End If
        .ctlDVD.ShowMenu 3
        If Err.Number <> 0 Then
            Err.Number = 0
            If lSettings.sPlayOnRootMenuFail = True Then
                .ctlDVD.Play
                .ctlDVD.Visible = True
                .tmrObjects.Enabled = True
                lPlayer.pStatus = sPlaying
                SetDVDTitle
                OnScreenDisplay "Playing " & lPlayer.pTitle
                SetCaption frmMain, eNavigatingMenu
                If lSettings.sAutoFullScreenOnPlay = True Then frmMain.tmrFullScreen.Enabled = True
                Exit Sub
            End If
        End If
        PlayerMenu ePlay
        .ctlDVD.Visible = True
        .tmrObjects.Enabled = True
        lPlayer.pStatus = sPlaying
        SetDVDTitle
        OnScreenDisplay "Playing " & lPlayer.pTitle
        SetCaption frmMain, eNavigatingMenu
        If lSettings.sAutoFullScreenOnPlay = True Then frmMain.tmrFullScreen.Enabled = True
    End With
Case ePlay
    With frmMain
        .ctlDVD.Play
        DoEvents
        If Err.Number <> 0 Then
            SetError "Play", Err.Description
            Exit Sub
        End If
        PlayerMenu ePlay
        .ctlDVD.Visible = True
        .tmrObjects.Enabled = True
        lPlayer.pStatus = sPlaying
        SetDVDTitle
        OnScreenDisplay "Playing " & lPlayer.pTitle
        SetCaption frmMain, ePlay
        If lSettings.sAutoFullScreenOnPlay = True Then frmMain.tmrFullScreen.Enabled = True
    End With
Case eStopped
    OnScreenDisplay "DVD Stopped"
    With frmMain
        .ctlDVD.Stop
        If Err.Number <> 0 Then Err.Number = 0
        .ctlDVD.Visible = False
        SetCaption frmMain, eStopped
        PlayerMenu eStopped
    End With
Case ePaused
    OnScreenDisplay "DVD Paused"
    With frmMain
        If lPlayer.pStatus = sPaused Then
            frmMain.ctlDVD.Play
            lPlayer.pStatus = sPlaying
            SetCaption frmMain, ePlay
            PlayerMenu ePlay
        Else
            frmMain.ctlDVD.Pause
            lPlayer.pStatus = sPaused
            SetCaption frmMain, ePaused
            PlayerMenu ePaused
       End If
    End With
Case eRewind
    OnScreenDisplay "Rewind"
    With frmMain
        If lPlayer.pRewinding = True Then
            lPlayer.pRewinding = False
            lPlayer.pStatus = sPlaying
            SetCaption frmMain, ePlay
            .ctlDVD.Play
            PlayerMenu ePlay
        Else
            lPlayer.pRewinding = True
            lPlayer.pStatus = sRewinding
            SetCaption frmMain, eRewind
            .ctlDVD.PlayBackwards (lPlayer.pRewindSpeed)
            PlayerMenu eRewind
        End If
    End With
Case eFastForward
    OnScreenDisplay "Fast Forward"
    With frmMain
        If lPlayer.pFastForwarding = True Then
            lPlayer.pRewinding = False
            lPlayer.pStatus = sPlaying
            SetCaption frmMain, ePlay
            .ctlDVD.Play
            PlayerMenu ePlay
        Else
            lPlayer.pFastForwarding = True
            lPlayer.pStatus = sFastForward
            SetCaption frmMain, eFastForward
            .ctlDVD.PlayForwards (lPlayer.pFastforwardSpeed)
            PlayerMenu eFastForward
        End If
    End With
Case eNewDisc
    OnScreenDisplay "Disc Inserted"
    PlayerMenu eNewDisc
    SetCaption frmMain, eNewDisc
Case eDiscEjected
    OnScreenDisplay "Disc Ejected"
    PlayerMenu eDiscEjected
    SetCaption frmMain, eDiscEjected
Case eNoDisc
    OnScreenDisplay "No Disc"
    PlayerMenu eNoDisc
    SetCaption frmMain, eNoDisc
Case eNoDrive
    OnScreenDisplay "No Drive"
    PlayerMenu eNoDrive
    SetCaption frmMain, eNoDrive
End Select
If Err.Number <> 0 Then SetError "Play", Err.Description
End Sub

Public Sub Surf(lUrl As String)
On Local Error Resume Next
If Len(lUrl) <> 0 Then ShellExecute frmMain.hwnd, "open", lUrl, vbNullString, vbNullString, conSwNormal
If Err.Number <> 0 Then SetError "Surf", Err.Description
End Sub

Public Sub FullScreen(lValue As Boolean)
On Local Error Resume Next
Dim mbox As VbMsgBoxResult
If lCaptureVersion = True Then
    mbox = MsgBox("nexDVD is unable to go into full screen mode while in capture mode. Would you like to turn off capture mode now? (Requires restart of nexDVD)", vbYesNo + vbInformation, "Capture Mode")
    If mbox = vbYes Then UnloadCaptureMode
    Exit Sub
End If
If lValue = True Then
    lPlayer.pFullscreen = True
    frmMain.ctlDVD.FullScreenMode = True
    HookStatus True
    OnScreenDisplay "Full screen mode"
Else
    lPlayer.pFullscreen = False
    frmMain.ctlDVD.FullScreenMode = False
    HookStatus False
    OnScreenDisplay "Duplex mode"
End If
If Err.Number <> 0 Then SetError "FullScreen", Err.Description
End Sub

Public Sub SetError(lSub As String, lDescription As String)
On Local Error Resume Next
Dim i As Integer
i = ReadINI(lINIFiles.iErrors, "Settings", "Count", 0)
i = i + 1
WriteINI lINIFiles.iErrors, "Settings", "Count", Str(i)
WriteINI lINIFiles.iErrors, Str(i), "Sub", lSub
WriteINI lINIFiles.iErrors, Str(i), "Description", lDescription
WriteINI lINIFiles.iErrors, Str(i), "Date", Str(Date$)
WriteINI lINIFiles.iErrors, Str(i), "Time", Str(Time$)
Err.Number = 0
If Len(lDescription) <> 0 Then
    If lSettings.sShowErrors = True Then
        If lSettings.sUseOnScreenDisplay = True Then
            OnScreenDisplay "Error: " & lDescription & " Sub: " & lSub
        Else
            MsgBox "An internal programming error occured." & vbCrLf & "This program will continue functioning." & vbCrLf & vbCrLf & "Description: " & lDescription & vbCrLf & "Sub: " & lSub, vbExclamation
        End If
    End If
End If
End Sub

Public Sub SetForm(lLoading As Boolean, lForm As Form)
On Local Error Resume Next
Dim msg As String, i As Integer
If lSettings.sRememberWindowPosition = False Then Exit Sub
msg = lForm.Name
If lLoading = True Then
    If Len(msg) <> 0 Then
        PauseFunc 0.2
        i = ReadINI(lINIFiles.iWindowpos, msg, "Left", -1)
        If i <> -1 Then lForm.Left = i
        i = ReadINI(lINIFiles.iWindowpos, msg, "Top", -1)
        If i <> -1 Then lForm.Top = i
        i = ReadINI(lINIFiles.iWindowpos, msg, "Width", -1)
        If i <> -1 Then lForm.Width = i
        i = ReadINI(lINIFiles.iWindowpos, msg, "Height", -1)
        If i <> -1 Then lForm.Height = i
        lForm.Visible = True
        WriteINI lINIFiles.iVisibleWindows, msg, "Visible", "True"
    End If
Else
    If Len(msg) <> 0 Then
        i = lForm.Left
        If i <> -1 Then WriteINI lINIFiles.iWindowpos, msg, "Left", Str(i)
        i = lForm.Top
        If i <> -1 Then WriteINI lINIFiles.iWindowpos, msg, "Top", Str(i)
        i = lForm.Height
        If i <> -1 Then WriteINI lINIFiles.iWindowpos, msg, "Height", Str(i)
        i = lForm.Width
        If i <> -1 Then WriteINI lINIFiles.iWindowpos, msg, "Width", Str(i)
        WriteINI lINIFiles.iVisibleWindows, msg, "Visible", "False"
    End If
End If
If Err.Number <> 0 Then SetError "LoadForm", Err.Description
End Sub

Public Sub UnloadCaptureMode()
On Local Error Resume Next
WriteINI lINIFiles.iSettings, "Settings", "CaptureMode", "False"
Shell App.Path & "\nexDVD.exe", vbNormalFocus
UnloadProg
End Sub

Public Sub LoadCaptureMode()
On Local Error Resume Next
WriteINI lINIFiles.iSettings, "Settings", "CaptureMode", "True"
Shell App.Path & "\nexDVDc.exe", vbNormalFocus
UnloadProg
End Sub

Public Function DoesFileExist(lFilename As String) As Boolean
On Local Error Resume Next
Dim msg As String
msg = Dir(lFilename)
If msg <> "" Then
    DoesFileExist = True
Else
    DoesFileExist = False
End If
If Err.Number <> 0 Then SetError "DoesFileExist()", Err.Description
End Function

Public Sub LoadSettings()
On Local Error Resume Next
Dim msg As Boolean
lINIFiles.iSettings = App.Path & "\cfg\settings.ini"
lINIFiles.iWindowpos = App.Path & "\cfg\windowpos.ini"
lINIFiles.iErrors = App.Path & "\cfg\errors.ini"
lINIFiles.iVisibleWindows = App.Path & "\cfg\vwind.ini"
lINIFiles.iUpdate = App.Path & "\cfg\update.ini"
lSettings.sAlwaysOnTop = ReadINI(lINIFiles.iSettings, "Settings", "AlwaysOnTop", False)
lSettings.sAutoFullScreenOnPlay = ReadINI(lINIFiles.iSettings, "Settings", "AutoFullScreenOnPlay", False)
lSettings.sAutoPlayOnStart = ReadINI(lINIFiles.iSettings, "Settings", "AutoPlayOnStart", True)
lSettings.sShowIconInSystray = ReadINI(lINIFiles.iSettings, "Settings", "ShowIconInSystray", True)
lSettings.sSingleClickToExitFullScreen = ReadINI(lINIFiles.iSettings, "Settings", "SingleClickToExitFullScreen", True)
lSettings.sStartWithWindows = ReadINI(lINIFiles.iSettings, "Settings", "StartWithWindows", False)
lSettings.sRememberWindowPosition = ReadINI(lINIFiles.iSettings, "Settings", "RememberWindowPosition", True)
lSettings.sUseDVDInterface = ReadINI(lINIFiles.iSettings, "Settings", "UseDVDInterface", True)
lSettings.sShowSplash = ReadINI(lINIFiles.iSettings, "Settings", "ShowSplash", True)
lSettings.sShowErrors = ReadINI(lINIFiles.iSettings, "Settings", "ShowErrors", False)
lSettings.sCaptureMode = ReadINI(lINIFiles.iSettings, "Settings", "CaptureMode", False)
lSettings.sShowStatusBar = ReadINI(lINIFiles.iSettings, "Settings", "ShowStatusBar", True)
lSettings.sShowDVDTime = ReadINI(lINIFiles.iSettings, "Settings", "ShowDVDTime", True)
lSettings.sAutoPlayOnInsert = ReadINI(lINIFiles.iSettings, "Settings", "AutoPlayOnInsert", True)
lSettings.sMenuVisibleOnMainForm = ReadINI(lINIFiles.iSettings, "Settings", "MenuVisibleOnMainForm", True)
lSettings.sUseOnScreenDisplay = ReadINI(lINIFiles.iSettings, "Settings", "UseOnScreenDisplay", True)
lSettings.sAutoPlayMenuOnAutoPlay = ReadINI(lINIFiles.iSettings, "Settings", "AutoPlayMenuOnAutoPlay", True)
lSettings.sCheckForUpdates = ReadINI(lINIFiles.iSettings, "Settings", "CheckForUpdates", True)
lSettings.sPlayOnRootMenuFail = ReadINI(lINIFiles.iSettings, "Settings", "PlayOnRootMenuFail", True)
lSettings.sSubpictureOn = ReadINI(lINIFiles.iSettings, "Settings", "SubpictureOn", False)
If ReadINI(lINIFiles.iVisibleWindows, "frmSettings", "Visible", False) = True Then frmSettings.Show
If ReadINI(lINIFiles.iVisibleWindows, "frmReWindFastForward", "Visible", False) = True Then frmRewindFastFoward.Show
If ReadINI(lINIFiles.iVisibleWindows, "frmAboutMe", "Visible", False) = True Then frmAboutMe.Show
If ReadINI(lINIFiles.iVisibleWindows, "frmPlaybackPosition", "Visible", False) = True Then frmPlaybackPosition.Show
''If ReadINI(lINIFiles.iVisibleWindows, "frmVolume", "Visible", False) = True Then frmVolume.Show
If ReadINI(lINIFiles.iVisibleWindows, "frmStep", "Visible", False) = True Then frmStep.Show
If ReadINI(lINIFiles.iVisibleWindows, "frmSlowMotion", "Visible", False) = True Then frmSlowMotion.Show
If ReadINI(lINIFiles.iVisibleWindows, "frmLanguage", "Visible", False) = True Then frmLanguage.Show
If ReadINI(lINIFiles.iVisibleWindows, "frmChapters", "Visible", False) = True Then frmChapters.Show
If Err.Number <> 0 Then SetError "LoadSettings", Err.Description
End Sub

Public Sub PictureBoxMouseMove(lButton As Integer, lPictureBox As Image, lPic1 As Image, lPic2 As Image, lX As Single, lY As Single)
On Local Error Resume Next
If lSettings.sUseDVDInterface = False Then Exit Sub
If lButton = 0 Then

ElseIf lButton = 1 Then
    'lX = frmInterface.ScaleX(lX) * 1.8
    'lY = frmInterface.ScaleY(lY) * 1.8
    If lPictureBox.Picture = lPic2.Picture Then
        If lX > lPictureBox.Width Or lX < -1 Or lY > lPictureBox.Height Or lY < -1 Then lPictureBox.Picture = lPic1.Picture
    ElseIf lPictureBox.Picture = lPic1.Picture Then
        If lX < lPictureBox.Width And lX > -1 And lY < lPictureBox.Height And lY > -1 Then lPictureBox.Picture = lPic2.Picture
    End If
End If
If Err.Number <> 0 Then SetError "PictureBoxMouseMove", Err.Description
End Sub

Public Sub AlwaysOnTop(myfrm As Form, SetOnTop As Boolean)
On Local Error Resume Next
Dim lFlag As Integer
If SetOnTop Then
    lFlag = HWND_TOPMOST
Else
    lFlag = HWND_NOTOPMOST
End If
SetWindowPos myfrm.hwnd, lFlag, myfrm.Left / Screen.TwipsPerPixelX, myfrm.Top / Screen.TwipsPerPixelY, myfrm.Width / Screen.TwipsPerPixelX, myfrm.Height / Screen.TwipsPerPixelY, SWP_NOACTIVATE Or SWP_SHOWWINDOW
If Err.Number <> 0 Then SetError "AlwaysOnTop", Err.Description
End Sub

Public Sub PauseFunc(interval)
On Local Error Resume Next
Dim Current
Current = Timer
Do While Timer - Current < Val(interval)
DoEvents
Loop
If Err.Number <> 0 Then SetError "PauseFunc", Err.Description
End Sub

Public Sub OnScreenDisplay(lText As String)
On Local Error Resume Next
If lSettings.sUseOnScreenDisplay = False Then Exit Sub
If Len(lText) <> 0 Then
    frmMain.tmrHideOSD.Enabled = False
    'frmMain.lblOSD.Caption = lText
    frmMain.picOSD.Width = frmMain.lblOSD.Width
    frmMain.picOSD.Visible = True
    frmMain.tmrHideOSD.Enabled = True
End If
End Sub

Public Sub FormDrag(lFormname As Form)
On Local Error Resume Next
ReleaseCapture
Call SendMessage(lFormname.hwnd, &HA1, 2, 0&)
If Err.Number <> 0 Then SetError "FormDrag", Err.Description
End Sub

Public Sub SetCaption(lForm As Form, lType As EventTypes)
On Local Error Resume Next
Dim msg As String, i As Integer
If lType = eDiscEjected Then
    msg = "Ejected"
ElseIf lType = eNewDisc Then
    msg = "Inserted"
    frmMain.ctlDVD.Visible = True
ElseIf lType = ePaused Then
    msg = "Paused"
ElseIf lType = ePlay Then
    If frmMain.ctlDVD.Visible = False Then frmMain.ctlDVD.Visible = True
    msg = "Playing"
ElseIf lType = eStopped Then
    msg = "Stopped"
ElseIf lType = eNoDisc Then
    msg = "Insert DVD media"
ElseIf lType = eNoDrive Then
    msg = "No DVD Drive Detected"
ElseIf lType = eFastForward Then
    msg = "Fast Forward"
ElseIf lType = eNavigatingMenu Then
    msg = "Playing"
ElseIf lType = eRewind Then
    msg = "Rewind"
End If
'If lSettings.sUseDVDInterface = True Then frmInterface.lblStatus.Caption = UCase(msg)
With lForm
    If Len(lPlayer.pTitle) <> 0 Then
        'lForm.Caption = "nexDVD " & App.Major & "." & App.Minor & " - " & lPlayer.pTitle & " - " & msg
    Else
        'lForm.Caption = "nexDVD " & App.Major & "." & App.Minor & " - " & msg
    End If
End With
If Err.Number <> 0 Then SetError "SetCaption", Err.Description
End Sub

Public Sub SetDVDTitle()
On Local Error Resume Next
If lPlayer.pStatus = sPlaying Then
    If Len(lPlayer.pTitle) = 0 Then lPlayer.pTitle = frmMain.ctlDVD.GetDVDTextString(0, 1): DoEvents
    If Err.Number <> 0 Then Err.Number = 0
    'If lSettings.sUseDVDInterface = True Then frmInterface.lblVideo.Caption = UCase(lPlayer.pTitle)
End If
If Err.Number <> 0 Then SetError "SetDVDTitle", Err.Description
End Sub
