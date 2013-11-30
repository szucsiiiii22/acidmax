Attribute VB_Name = "mdlMain"
Option Explicit

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
