Attribute VB_Name = "mdlOld"
Option Explicit

'Public Sub RunningState()
'With frmMain
'    .mnuPlay.Enabled = False
'    .mnuPause.Enabled = True
'    .mnuFastForward.Enabled = True
'    .mnuRewind.Enabled = True
'    .mnuNext.Enabled = True
'    .mnuPrevious.Enabled = True
'    .mnuStop.Enabled = True
'    .mnuEject.Enabled = False
'End With
'If Err.Number <> 0 Then SetError "RunningState", Err.Description
'End Sub

'Public Sub PausedState()
'With frmMain
'    .mnuPlay.Enabled = True
'    .mnuPause.Enabled = False
'    .mnuFastForward.Enabled = False
'    .mnuRewind.Enabled = False
'    .mnuNext.Enabled = False
'    .mnuPrevious.Enabled = False
'    .mnuStop.Enabled = False
'    .mnuEject.Enabled = False
'End With
'If Err.Number <> 0 Then SetError "PausedState", Err.Description
'End Sub

'Public Sub PlayOnly()
'With frmMain
'    .mnuPlay.Enabled = True
'    With .Toolbar1
'        For i = 7 To 10
'            .Buttons(i).Enabled = False
'        Next i
'        .Buttons(11).Enabled = True
'        For i = 12 To 14
'            .Buttons(i).Enabled = False
'        Next i
'        .Buttons(16).Enabled = False
'        For i = 18 To 26
'            .Buttons(i).Enabled = True
'        Next i
'    End With
'End With
'If Err.Number <> 0 Then SetError "PlayOnly", Err.Description
'End Sub

'Public Sub ContPlay()
'Dim i As Integer
'With frmMain.ctlDVD
'    .Play
'    SetCaption frmMain, ePlay
'    With frmMain.Toolbar1
'        For i = 8 To 10
'            .Buttons(i).Enabled = True
'        Next i
'        .Buttons(11).Enabled = False
'        For i = 12 To 15
'            .Buttons(i).Enabled = True
'        Next i
'        .Buttons(16).Enabled = False
'        For i = 17 To 26
'            .Buttons(i).Enabled = True
'        Next i
'    End With
'End With
'If Err.Number <> 0 Then SetError "ContPlay", Err.Description
'End Sub

'Public Sub Pause()
'Dim i As Integer
'frmMain.ctlDVD.Pause
'SetCaption frmMain, ePaused
'With frmMain.Toolbar1
'    For i = 3 To 10
'        .Buttons(i).Enabled = False
'    Next i
'    .Buttons(11).Enabled = True
'    For i = 12 To 14
'        .Buttons(i).Enabled = False
'    Next i
'End With
'If Err.Number <> 0 Then SetError "Pause", Err.Description
'End Sub

'Public Sub Stopped()
'With frmMain
'    If frmMain.ctlDVD.PlayState <> -1 Then .ctlDVD.Stop
    '.ctlDVD.Visible = False
'    SetCaption frmMain, eStopped
'    .mnuPlay.Enabled = True
'    .Toolbar1.Buttons(11).Enabled = True
'    .mnuPause.Enabled = False
'    .Toolbar1.Buttons(12).Enabled = False
'    .mnuFastForward.Enabled = False
''    .Toolbar1.Buttons(13).Enabled = False
'    .mnuRewind.Enabled = False
''    .Toolbar1.Buttons(9).Enabled = False
'    .mnuNext.Enabled = False
''    .Toolbar1.Buttons(14).Enabled = False
'    .mnuPrevious.Enabled = False
''    .Toolbar1.Buttons(8).Enabled = False
'    .mnuStop.Enabled = False
''    .Toolbar1.Buttons(10).Enabled = False
'    .mnuEject.Enabled = True
''    .Toolbar1.Buttons(16).Enabled = True
'End With
'If Err.Number <> 0 Then SetError "Stopped", Err.Description
'End Sub

'Public Sub Play()
'Dim i As Integer
'With frmMain
    '.ctlDVD.Visible = True
'    .ctlDVD.Play
'    DoEvents
'    If Err.Number <> 0 Then
'        SetError "Play", Err.Description
'        Exit Sub
'    End If
'    .tmrObjects.Enabled = True
'    SetCaption frmMain, ePlay
'    With .Toolbar1
'        For i = 1 To 10
'            .Buttons(i).Enabled = True
'        Next i
'        .Buttons(11).Enabled = False
'        For i = 12 To 26
'            .Buttons(i).Enabled = True
'        Next i
'    End With
'End With
'If Err.Number <> 0 Then SetError "Play", Err.Description
'End Sub

'Public sPref As String, f%, Cfg$, my$, up$
'Public i As Integer, bMuteValue As Boolean
'Public TitleID(2) As String, TitleName(2) As String, TitleCaption As String
'Public strTempSpeed As String, strTempFS As String, strTempHM As String
'Public strTempHS As String, strTempHT As String, strFile As String
'Public iTitleMenu As Integer, iRootMenu As Integer, intSpeed As Integer
'Type Preferences
'    intSpeed As Integer
'    bFullScreen As Boolean
'    bHideMenu As Boolean
'    bHideStatus As Boolean
'    bHideTool As Boolean
'End Type
'Type MI
'    SumTitle As String
'    Summary As String
'    Producer As String
'    Actors() As String
'End Type
'Global UserPref As Preferences
'Global MovieInfo As MI

'Public Sub GetTxt()
'This sub gets the DVD ID and DVD Title Name from a text file.
'The DVD ID is a property - DVDUniqueID - that identifies every
'DVD title.  With this you can individualize any DVD title complete
'with individualized graphics and movie info.
'Dim strPath As String, temp As String

'f% = FreeFile
'strPath = App.Path & "\"
'strFile = "id.txt"

'Open strPath & strFile For Input As #f%
'Line Input #f%, TitleID(0)
'Line Input #f%, TitleName(0)
'Close #f%
'End Sub

'Public Sub GetPref()
'Cfg$ = App.Path & "\config.ini"
'up$ = "User Preferences"

'Read in Pref data
'strTempSpeed = GetFromIni(up$, "Playback Speed", Cfg$)
'strTempFS = GetFromIni(up$, "Full Screen", Cfg$)
'strTempHM = GetFromIni(up$, "Hide Menu", Cfg$)
'strTempHS = GetFromIni(up$, "Hide Status", Cfg$)
'strTempHT = GetFromIni(up$, "Hide Toolbar", Cfg$)

'Convert the Pref data
'With UserPref
'    .intSpeed = CInt(strTempSpeed)
'    .bFullScreen = CBool(strTempFS)
'    .bHideMenu = CBool(strTempHM)
'    .bHideStatus = CBool(strTempHS)
'    .bHideTool = CBool(strTempHT)
'End With

'Set the preferences
'If UserPref.bHideMenu = True Then
'    With frmMain
'        .mnuControls.Visible = False
'    End With
'ElseIf UserPref.bHideMenu = False Then
'    With frmMain
'        .mnuControls.Visible = True
'    End With
'End If

'If UserPref.bHideStatus = True Then
'    frmMain.StatusBar1.Visible = False
'ElseIf UserPref.bHideStatus = False Then
'    frmMain.StatusBar1.Visible = True
'End If'

'If UserPref.bHideTool = True Then
'    frmMain.Toolbar1.Visible = False
'ElseIf UserPref.bHideTool = False Then
'    frmMain.Toolbar1.Visible = True
'End If

'End Sub

'Public Sub GetDVDInfo()
'Dim msg As String, Style As String, Title As String, Response As String, MyString As String

'GetTxt
'If frmMain.ctlDVD.DVDUniqueID = TitleID(0) Then
'    TitleCaption = "nexDVD - " & TitleName(0)
'Else
'    TitleCaption = "nexDVD"
'    Title = "nexDVD"
'End If
'End Sub

