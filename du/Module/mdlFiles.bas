Attribute VB_Name = "mdlFiles"
Option Explicit
Private Declare Function sndPlaySound Lib "winmm" Alias "sndPlaySoundA" (ByVal lpszSoundName As String, ByVal uFlags As Long) As Long
Public Enum sndConst
    SND_ASYNC = &H1
    SND_LOOP = &H8
    SND_MEMORY = &H4
    SND_NODEFAULT = &H2
    SND_NOSTOP = &H10
    SND_SYNC = &H0
End Enum
Private Type gFile
    fReloaded As Boolean
    fFileName As String
    fRemotePath As String
    fLocalPath As String
    fAcidmaxPath As String
    fSize As String
    fSizeLow As String
    fNew As Boolean
End Type
Private Type gFiles
    fCount As Integer
    fFile(1500) As gFile
End Type
Private Type gDir
    dRemotePath As String
    dChecked As Boolean
    dPassword As String
End Type
Private Type gDirectories
    dCount As Integer
    dDir(500) As gDir
End Type
Private Type gSettings
    sReloadScripts As Boolean
    sAcidmaxBetaUpdates As Boolean
    sAcidmaxVersion As String
    sAcidmaxDir As String
    sAutoCheck As Boolean
    sAutoUpdate As Boolean
    sShowDialog As Boolean
    sFilesShadowed As Boolean
    sSavePassword As Boolean
End Type
Private lFiles As gFiles, lSettings As gSettings, lFinishedCheckingFiles As Boolean, lDirectories As gDirectories

Public Function ReturnVersionINI() As String
On Local Error Resume Next
ReturnVersionINI = ReturnAcidmaxDir & "du\version.ini"
End Function

Public Function ReturnDUINI() As String
On Local Error Resume Next
ReturnDUINI = ReturnAcidmaxDir & "du\du.ini"
End Function

Public Function ReturnSettingINI() As String
On Local Error Resume Next
ReturnSettingINI = ReturnAcidmaxDir & "data\setting.ini"
End Function

Public Function ReturnShadowed() As Boolean
On Local Error Resume Next
ReturnShadowed = lSettings.sFilesShadowed
End Function

Public Sub SetShadowed(lValue As Boolean)
On Local Error Resume Next
lSettings.sFilesShadowed = lValue
End Sub

Public Function ReturnShowDialog() As Boolean
On Local Error Resume Next
ReturnShowDialog = lSettings.sShowDialog
End Function

Public Function ReturnReloadScripts() As Boolean
On Local Error Resume Next
ReturnReloadScripts = lSettings.sReloadScripts
End Function

Public Sub SetBetaUpdate(lValue As Boolean)
On Local Error Resume Next
lSettings.sAcidmaxBetaUpdates = lValue
SetMainFormBetaUpdate lValue
End Sub

Public Sub SetReloadScripts(lValue As Boolean)
On Local Error Resume Next
lSettings.sReloadScripts = lValue
SetMainFormReloadScripts lValue
End Sub

Public Function ReturnAutoUpdate() As Boolean
ReturnAutoUpdate = lSettings.sAutoUpdate
End Function

Public Sub SetAutoUpdate(lValue As Boolean)
On Local Error Resume Next
lSettings.sAutoUpdate = lValue
SetMainFormAutoUpdate lValue
End Sub

Public Sub SetAutoCheck(lValue As Boolean)
On Local Error Resume Next
lSettings.sAutoCheck = lValue
SetMainFormCheckUpdatesAutomatically lValue
End Sub

Public Sub ClearDirectory(lIndex As Integer)
On Local Error Resume Next
With lDirectories.dDir(lIndex)
    .dChecked = False
    .dRemotePath = ""
End With
End Sub

Public Function ReturnDirectory(lIndex As Integer) As String
On Local Error Resume Next
ReturnDirectory = lDirectories.dDir(lIndex).dRemotePath
End Function

Public Sub SaveSettings()
On Local Error Resume Next
lSettings.sAutoUpdate = ReturnMainFormAutoUpdate
lSettings.sAutoCheck = ReturnMainFormAutoCheck
lSettings.sReloadScripts = ReturnMainFormReloadScripts
WriteINI ReturnDUINI, "Settings", "AutoCheck", lSettings.sAutoCheck
WriteINI ReturnDUINI, "Settings", "AutoUpdate", lSettings.sAutoUpdate
WriteINI ReturnDUINI, "Settings", "ReloadScripts", lSettings.sReloadScripts
If ReturnSaveAdminInfo = True Then
    WriteINI ReturnDUINI, "Settings", "AdminUsername", ReturnAdminUsername
    WriteINI ReturnDUINI, "Settings", "AdminPassword", ReturnAdminPassword
End If
End Sub

Public Sub ApplySettings()
On Local Error Resume Next
SetMainFormReloadScripts lSettings.sReloadScripts
SetMainFormAutoUpdate lSettings.sAutoUpdate
SetMainFormAutoCheck lSettings.sAutoCheck
SetMainFormSavePassword True
End Sub

Public Sub LoadSettings()
On Local Error Resume Next
lSettings.sReloadScripts = CBool(ReadINI(ReturnDUINI, "Settings", "ReloadScripts", True))
lSettings.sAutoCheck = CBool(ReadINI(ReturnDUINI, "Settings", "AutoCheck", True))
lSettings.sAutoUpdate = CBool(ReadINI(ReturnDUINI, "Settings", "AutoUpdate", False))
lSettings.sShowDialog = True
End Sub

Public Function ReturnDirectoryIndex(lDirectory As String) As Integer
On Local Error Resume Next
Dim i As Integer
For i = 0 To lDirectories.dCount
    If LCase(lDirectories.dDir(i).dRemotePath) = lDirectory Then
        ReturnDirectoryIndex = i
        Exit For
    End If
Next i
End Function

Public Sub SetDirectoryChecked(lIndex As Integer, lValue As Boolean)
On Local Error Resume Next
lDirectories.dDir(lIndex).dChecked = lValue
End Sub

Public Sub SetMircPath(lPath As String)
On Local Error Resume Next
lSettings.sAcidmaxDir = lPath
End Sub

Public Sub SetAcidmaxVersion2(lVersion As String)
On Local Error Resume Next
lSettings.sAcidmaxVersion = lVersion
SetMainFormAcidmaxVersion lVersion
End Sub

Public Sub SetAcidmaxBetaUpdate(lToggle As Boolean)
Select Case lToggle
Case True
    lSettings.sAcidmaxBetaUpdates = True
Case False
    lSettings.sAcidmaxBetaUpdates = False
End Select
End Sub

Public Function ReturnAcidmaxBetaUpdate() As Boolean
On Local Error Resume Next
ReturnAcidmaxBetaUpdate = lSettings.sAcidmaxBetaUpdates
End Function

Public Sub SetAcidmaxVersion(lVersion As String)
On Local Error Resume Next
lSettings.sAcidmaxVersion = lVersion
SetMainFormAcidmaxVersion lVersion
End Sub

Public Sub UpdateFiles()
On Local Error Resume Next
Dim i As Integer, msg As String, f As Integer, msg2 As String, msg3 As String, l As Integer, mbox As VbMsgBoxResult
SetMainFormCheckForUpdatesEnabled False
SetMainFormUpdateAcidmax3ButtonEnabled False
SetMainFormStatusLabel "Updating Acidmax 2"
For i = 0 To ReturnFileCount
    If ReturnFileNew(i) = True Then
        msg3 = Trim(Replace(ReturnFileAcidmaxPath(i), lSettings.sAcidmaxDir, ""))
        If Right(msg3, 1) = "\" Then msg3 = Left(msg3, Len(msg3) - 1)
        If Left(msg3, 1) <> "/" Then msg3 = "/" & msg3
        l = ReturnDirectoryIndex(msg3)
        If l <> 0 And Len(lDirectories.dDir(l).dPassword) <> 0 Then
            msg3 = ""
TryAgain:
            msg3 = InputBox("The directory '" & lDirectories.dDir(l).dRemotePath & "' is password protected. Enter the password to download from this directory. Or, hit 'Cancel' to skip this directory", App.Title, "")
            If EncodeString(msg3, ReturnProbaPassword, True) = lDirectories.dDir(l).dPassword Then
                lDirectories.dDir(l).dPassword = ""
                FTP_DownloadFile ReturnFileName(i): DoEvents
                GoTo NextI
            Else
                mbox = MsgBox("The password you supplied is incorrect. Would you like to try again?", vbYesNo + vbQuestion)
                If mbox = vbYes Then GoTo TryAgain
                GoTo NextI
            End If
        End If
        FTP_DownloadFile ReturnFileName(i): DoEvents
    End If
NextI:
Next i
For i = 0 To ReturnFileCount
    With lFiles.fFile(i)
        If Len(.fFileName) <> 0 And Len(.fLocalPath) <> 0 And .fNew = True Then
            If DoesFileExist(.fLocalPath & .fFileName) = True Then
                If DoesFileExist(.fAcidmaxPath & .fFileName) = True Then
                    'File Exists
                    If Trim(LCase(.fAcidmaxPath)) <> Trim(LCase(App.Path)) & "\" Then
                        'Update Acidmax File
                        f = 2
                        Kill .fAcidmaxPath & .fFileName
                        FileCopy .fLocalPath & .fFileName, .fAcidmaxPath & .fFileName
                        DoEvents
                        If ReturnReloadScripts = True Then
                            If Right(LCase(.fFileName), 4) = ".mrc" Or Right(LCase(.fFileName), 4) = ".ini" And LCase(.fFileName) <> "version.ini" Then
                                .fReloaded = True
                                mIRCStatusSend "/reload -rs " & .fAcidmaxPath & .fFileName
                            End If
                        End If
                    End If
                Else
                    'New File
                    If DoesDirectoryExist(.fAcidmaxPath) = True Then
                        'Directory Exists
                        f = 1
                        FileCopy .fLocalPath & .fFileName, .fAcidmaxPath & .fFileName
                        DoEvents
                        If ReturnReloadScripts = True Then
                            If Right(LCase(.fFileName), 4) = ".mrc" Or Right(LCase(.fFileName), 4) = ".ini" And LCase(.fFileName) <> "version.ini" Then
                                mIRCStatusSend "/reload -rs " & .fAcidmaxPath & .fFileName
                                .fReloaded = True
                            End If
                        Else
                        End If
                    Else
                        'New Directory
                        f = 1
                        CreateMultiDirectory .fAcidmaxPath
                        FileCopy .fLocalPath & .fFileName, .fAcidmaxPath & .fFileName
                        DoEvents
                        If ReturnReloadScripts = True Then
                            If Right(LCase(.fFileName), 4) = ".mrc" Or Right(LCase(.fFileName), 4) = ".ini" And LCase(.fFileName) <> "version.ini" Then
                                mIRCStatusSend "/reload -rs " & .fAcidmaxPath & .fFileName
                                .fReloaded = True
                            End If
                        End If
                    End If
                End If
            Else
                AddToStatus "Error: " & .fFileName & " not found!"
            End If
            msg = Trim(msg)
        End If
    End With
Next i
AddToStatus "Update Complete"
ClearMainFormFileList
SetMainFormStatusLabel "Update Complete, close this window to finish"
If Len(ReturnNewVersion()) <> 0 Then
    MsgBox "Update Complete", vbInformation, "Direct Update"
    WriteINI ReturnSettingINI, "version", "ver", ReturnNewVersion
End If
If Err.Number <> 0 Then Err.Clear
End Sub

Public Function SaveFile(lFilename As String, lText As String) As Boolean
On Local Error Resume Next
If Len(lFilename) <> 0 And Len(lText) <> 0 Then
    Open lFilename For Output As #13
    Print #13, lText
    Close #13
End If
End Function

Public Sub PlayWav(strPath As String, sndVal As sndConst)
On Local Error Resume Next
sndPlaySound strPath, sndVal
End Sub

Public Sub DeleteDownloadedFiles()
On Local Error Resume Next
Dim i As Integer
If i <> 0 Then
    For i = 0 To lFiles.fCount
        If Len(lFiles.fFile(i).fFileName) <> 0 Then
            If Left(LCase(lFiles.fFile(i).fFileName), 2) <> "du" Then
                If Left(LCase(lFiles.fFile(i).fFileName), 3) <> "ole" Then
                    Kill lFiles.fFile(i).fLocalPath & lFiles.fFile(i).fFileName
                End If
            End If
        End If
NextI:
    Next i
End If
DoEvents
End Sub

Public Function ReturnDirectoryCount() As Integer
On Local Error GoTo ErrHandler
ReturnDirectoryCount = lDirectories.dCount
ErrHandler:
    Err.Clear
End Function

Public Function ReturnFinishedCheckingFiles() As Boolean
On Local Error GoTo ErrHandler
ReturnFinishedCheckingFiles = lFinishedCheckingFiles
ErrHandler:
    Err.Clear
End Function

Public Function ReturnFilesRemotePath(lIndex As Integer) As String
On Local Error GoTo ErrHandler
ReturnFilesRemotePath = lFiles.fFile(lIndex).fRemotePath
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ReturnFileNew(lIndex As Integer) As Boolean
On Local Error GoTo ErrHandler
ReturnFileNew = lFiles.fFile(lIndex).fNew
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ReturnFileAcidmaxPath(lIndex As Integer) As String
On Local Error GoTo ErrHandler
ReturnFileAcidmaxPath = Trim(lFiles.fFile(lIndex).fAcidmaxPath)
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ReturnFileLocalPath(lIndex As Integer) As String
On Local Error GoTo ErrHandler
ReturnFileLocalPath = Trim(lFiles.fFile(lIndex).fLocalPath)
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ReturnFileName(lIndex As Integer) As String
On Local Error GoTo ErrHandler
ReturnFileName = lFiles.fFile(lIndex).fFileName
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ReturnFileSize(lIndex As Integer) As String
On Local Error GoTo ErrHandler
ReturnFileSize = lFiles.fFile(lIndex).fSize
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ReturnFileCount() As Integer
On Local Error GoTo ErrHandler
ReturnFileCount = lFiles.fCount
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Sub ClearAllFiles()
On Local Error Resume Next
Dim i As Integer
lFiles.fCount = 0
lFinishedCheckingFiles = False
FTP_SetConnected False
lSettings.sAcidmaxDir = ""
For i = 0 To lFiles.fCount
    With lFiles.fFile(i)
        .fFileName = ""
        .fLocalPath = ""
        .fNew = False
        .fRemotePath = ""
        .fSize = ""
    End With
Next i
For i = 0 To lDirectories.dCount = 0
    With lDirectories.dDir(i)
        .dChecked = False
        .dRemotePath = ""
    End With
Next i
End Sub

Public Sub ClearFileIndex(lIndex As Integer)
On Local Error Resume Next
With lFiles.fFile(lIndex)
    .fAcidmaxPath = ""
    .fFileName = ""
    .fLocalPath = ""
    .fNew = False
    .fRemotePath = ""
    .fSize = ""
    .fSizeLow = ""
End With
End Sub

Public Function GetFileTitle(lFilename As String) As String
On Local Error Resume Next
Dim msg() As String
If Len(lFilename) <> 0 Then
    msg = Split(lFilename, "\", -1, vbTextCompare)
    GetFileTitle = msg(UBound(msg))
End If
End Function

Public Function DoesDirectoryExist(lDirectory) As Boolean
On Local Error Resume Next
Dim msg As String
msg = Dir(lDirectory)
If Len(msg) <> 0 Then DoesDirectoryExist = True
End Function

Public Function BrowseNextDirectory() As Boolean
On Local Error Resume Next
Dim i As Integer
Pause 0.2
If ReturnShadowed = True Then GoTo Fec
If ReturnNewVersion <> lSettings.sAcidmaxVersion Then
    For i = 0 To lDirectories.dCount
        If ReturnShadowed = True Then Exit For
        If Len(lDirectories.dDir(i).dRemotePath) <> 0 Then
            If lDirectories.dDir(i).dChecked = False Then
                EnableCheckDirectory False
                lDirectories.dDir(i).dChecked = True
                FTP_EnterFTPDirectory lDirectories.dDir(i).dRemotePath & "/"
                BrowseNextDirectory = True
                Exit Function
            End If
        End If
    Next i
    BrowseNextDirectory = False
    EnableCheckDirectory False
End If
Fec:
EnableCheckDirectory False
If DeterminAcidmaxOld = True Then
    ListFiles
Else
    EnableCheckDirectory False
    SetMainFormCheckForUpdatesEnabled True
    SetUpdateBusy False
    SetMainFormStatusLabel "Your version of Acidmax is up to date"
    AddToStatus "Up to date"
    ClearAllFiles
End If
End Function

Public Sub ListFiles()
On Local Error Resume Next
Dim i As Integer, b As Boolean, msg As String, msg2 As String, msg3 As String
For i = 0 To 1500
    With lFiles.fFile(i)
        If Len(.fAcidmaxPath) <> 0 And Len(.fLocalPath) <> 0 And Len(.fFileName) <> 0 Then
            If LCase(.fFileName) <> "version.ini" And LCase(.fFileName) <> "index.html" Then
                If DoesFileExist(.fAcidmaxPath & .fFileName) = True Then
                    If CLng(.fSize) <> FileLen(.fAcidmaxPath & .fFileName) Then
                        b = True
                        .fNew = True
                        AddToFileList .fFileName, .fSize
                    Else
                        .fNew = False
                    End If
                Else
                    b = True
                    .fNew = True
                    AddToFileList .fFileName, .fSize
                    If DoesDirectoryExist(.fAcidmaxPath) = False Then CreateMultiDirectory .fAcidmaxPath
                End If
            End If
        End If
    End With
Next i
lFinishedCheckingFiles = True
If b = True Then
    PlayWav ReturnAcidmaxDir & "nexsnd\default\update.wav", SND_ASYNC
    AddToStatus "Update Available"
    SetMainFormStatusLabel "Update Available"
    SetMainFormUpdateAcidmax3ButtonEnabled True
    SetMainFormCheckForUpdatesEnabled False
    If lSettings.sAutoUpdate = True Then
        UpdateFiles
    Else
        EnableChooseFilesButton True
    End If
Else
    If ReturnNewVersion <> lSettings.sAcidmaxVersion Then WriteINI ReturnAcidmaxDir & "data\setting.ini", "version", "ver", ReturnNewVersion
    AddToStatus "No Updates Available"
    SetMainFormStatusLabel "No Updates Available"
    SetMainFormCheckForUpdatesEnabled True
    SetMainFormUpdateAcidmax3ButtonEnabled False
    EnableChooseFilesButton False
End If
SetUpdateBusy False
RefreshFTPDirectoryListBox
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

Public Sub CreateMultiDirectory(lDir As String)
On Local Error Resume Next
Dim NewLen As Integer, DirLen As Integer, MaxLen As Integer
NewLen = 4
MaxLen = Len(lDir)
If Right$(lDir, 1) <> "\" Then
    lDir = lDir + "\"
    MaxLen = MaxLen + 1
End If
On Error GoTo DirError
MakeNext:
DirLen = InStr(NewLen, lDir, "\")
MkDir Left$(lDir, DirLen - 1)
NewLen = DirLen + 1
If NewLen >= MaxLen Then Exit Sub
GoTo MakeNext
DirError:
Resume Next
If Err.Number <> 0 Then Err.Clear
End Sub

Public Function ReturnAutoCheck() As Boolean
On Local Error Resume Next
ReturnAutoCheck = lSettings.sAutoCheck
End Function

Public Function AddFile(lFile As String, lModified As String, lSize As String, lRemotePath As String) As Boolean
On Local Error Resume Next
If Len(lFile) <> 0 Then
    If InStr(lFile, "\") Then
        AddDirectory lFile, ""
        AddFile = False
        Exit Function
    Else
        If lFile <> ".ftpquota" Then
            lFiles.fCount = lFiles.fCount + 1
            With lFiles.fFile(lFiles.fCount)
                AddFile = True
                .fFileName = lFile
                .fSize = lSize
                .fRemotePath = lRemotePath
                .fLocalPath = App.Path & "\"
                .fAcidmaxPath = lSettings.sAcidmaxDir & "\" & .fRemotePath
                .fAcidmaxPath = Replace(.fAcidmaxPath, "*.*", "")
                .fAcidmaxPath = Replace(.fAcidmaxPath, "*.**.*", "")
                .fAcidmaxPath = Replace(.fAcidmaxPath, "/", "\")
                .fAcidmaxPath = Replace(.fAcidmaxPath, "\\\", "\")
                .fAcidmaxPath = Replace(.fAcidmaxPath, "\\", "\")
                If Right(.fAcidmaxPath, 1) <> "\" Then .fAcidmaxPath = .fAcidmaxPath & "\"
                If LCase(.fFileName) = "version.ini" Then
                    If FTP_DownloadFile("version.ini") = True Then
                        Dim i As Integer, msg As String, msg2 As String, c As Integer, msg3 As String, msg4 As String
                        If Trim(ReadINI(App.Path & "\version.ini", "Settings", "DU", "")) <> Trim(Str(App.Major & "." & App.Minor)) Then
                            Dim mbox As VbMsgBoxResult
                            mbox = MsgBox("Direct Update appears to be out of date. Would you like to close Direct Update and run the updater?", vbYesNo + vbQuestion, App.Title)
                            If mbox = vbYes Then
                                HideMainForm
                                mIRCStatusSend "//frmDuPreUpdate.Load"
                                mIRCStatusSend "//frmDU.Unload"
                                Exit Function
                            End If
                        End If
                        SetMainFormNewVersion ReadINI(App.Path & "\version.ini", "Settings", "Version", ""): DoEvents
                        c = Int(ReadINI(App.Path & "\version.ini", "Settings", "Files", 0))
                        For i = 1 To c
                            If c <> 0 Then
                                msg = ReadINI(App.Path & "\version.ini", "File" & Trim(Str(i)), "Url", "")
                                msg2 = ReadINI(App.Path & "\version.ini", "File" & Trim(Str(i)), "Size", "")
                                If Len(msg) <> 0 And Len(msg2) <> 0 Then
                                    msg3 = Replace(msg, "/", "\")
                                    'msg3 = GetFileTitle(msg3)
                                    AddFile GetFileTitle(msg3), "0", Trim(Replace(msg2, ",", "")), Replace(Left(msg3, Len(msg3) - Len(GetFileTitle(msg3))), "\", "/") & "*.*"
                                    SetShadowed True
                                End If
                            End If
                        Next i
                        c = 0
                        c = Int(ReadINI(App.Path & "\version.ini", "Settings", "Dirs", 0))
                        If c <> 0 Then
                            For i = 0 To c
                                msg = ReadINI(App.Path & "\version.ini", Trim(Str(i)), "Path", "")
                                msg2 = ReadINI(App.Path & "\version.ini", Trim(Str(i)), "Password", "")
                                If Len(msg) <> 0 And Len(msg2) <> 0 Then
                                    AddDirectory msg, msg2
                                End If
                            Next i
                        End If
                    End If
                End If
            End With
        End If
    End If
End If
DoEvents
End Function

Public Function DoesFileExistInType(lFilename As String) As Boolean
On Local Error GoTo ErrHandler
Dim i As Integer
For i = 0 To lFiles.fCount
    If LCase(lFilename) = LCase(lFiles.fFile(i).fFileName) Then
        DoesFileExistInType = True
        Exit For
    End If
Next i
Exit Function
ErrHandler:
    Err.Clear
    DoesFileExistInType = False
End Function

Public Function FindFileIndex(lFilename As String) As Integer
On Local Error GoTo ErrHandler
Dim i As Integer
For i = 0 To lFiles.fCount
    If LCase(lFilename) = LCase(lFiles.fFile(i).fFileName) Then
        FindFileIndex = i
        Exit For
    End If
Next i
Exit Function
ErrHandler:
    Err.Clear
    FindFileIndex = 0
End Function

Public Sub SetFileName(lIndex As Integer, lFilename As String)
On Local Error Resume Next
lFiles.fFile(lIndex).fFileName = lFilename
End Sub

Public Function AddDirectory(lDirectory As String, lPassword As String) As Boolean
On Local Error GoTo ErrHandler
If lDirectory = "/" Or Right(lDirectory, 2) = ".." Or Right(lDirectory, 1) = "." Then Exit Function
If Len(lDirectory) <> 0 Then
    Dim i As Integer
    i = ReturnDirectoryIndex(lDirectory)
    If i <> 0 Then
        If Len(lPassword) <> 0 And lDirectories.dDir(i).dPassword <> lPassword Then lDirectories.dDir(i).dPassword = lPassword
        AddDirectory = True
        Exit Function
    End If
    lDirectories.dCount = lDirectories.dCount + 1
    lDirectories.dDir(lDirectories.dCount).dPassword = lPassword
    lDirectories.dDir(lDirectories.dCount).dRemotePath = lDirectory
    AddDirectory = True
End If
Exit Function
ErrHandler:
    AddDirectory = False
End Function

Public Function ReturnAcidmaxDir() As String
On Local Error Resume Next
ReturnAcidmaxDir = lSettings.sAcidmaxDir
End Function

Public Sub SetFileNew(lFileIndex As Integer, lNew As Boolean)
On Local Error GoTo ErrHandler
lFiles.fFile(lFileIndex).fNew = lNew
Exit Sub
ErrHandler:
    Err.Clear
End Sub
