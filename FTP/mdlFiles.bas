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
    fFileName As String
    fRemotePath As String
    fLocalPath As String
    fAcidmaxPath As String
    fModified As String
    fSize As String
    fSizeLow As String
    fNew As Boolean
End Type
Private Type gDir
    dRemotePath As String
    dChecked As Boolean
End Type
Private Type gDirectories
    dCount As Integer
    dDir(1000) As gDir
End Type
Private Type gFiles
    fCount As Integer
    fFile(1500) As gFile
End Type
Private Type gSettings
'    sAcidmaxBetaUpdates As Boolean
    sAcidmaxVersion As String
    sAcidmaxDir As String
'    sAutoCheck As Boolean
'    sAutoUpdate As Boolean
    sShowDialog As Boolean
'    sCreateRestorePoints As Boolean
'    sEnableSound As Boolean
'    sReloadWindow As Boolean
'    sUseThemeColor As Boolean
End Type
Private Declare Function GetFileVersionInfo Lib "Version.dll" Alias "GetFileVersionInfoA" (ByVal lptstrFilename As String, ByVal dwhandle As Long, ByVal dwlen As Long, lpData As Any) As Long
Private Declare Function GetFileVersionInfoSize Lib "Version.dll" Alias "GetFileVersionInfoSizeA" (ByVal lptstrFilename As String, lpdwHandle As Long) As Long
Private Declare Function VerQueryValue Lib "Version.dll" Alias "VerQueryValueA" (pBlock As Any, ByVal lpSubBlock As String, lplpBuffer As Any, puLen As Long) As Long
Private Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal Path As String, ByVal cbBytes As Long) As Long
Private Declare Sub MoveMemory Lib "kernel32" Alias "RtlMoveMemory" (dest As Any, ByVal Source As Long, ByVal Length As Long)
Private Declare Function lstrcpy Lib "kernel32" Alias "lstrcpyA" (ByVal lpString1 As String, ByVal lpString2 As Long) As Long
Public Type FILEPROPERTIE
    CompanyName As String
    FileDescription As String
    FileVersion As String
    InternalName As String
    LegalCopyright As String
    OrigionalFileName As String
    ProductName As String
    ProductVersion As String
End Type
Private lRecievingSize As Boolean, lConnected As Boolean, lFiles As gFiles, lSettings As gSettings, lFinishedCheckingFiles As Boolean, lDirectories As gDirectories
Private lSilent As Boolean

Public Sub SetSilent(lValue As Boolean)
On Local Error Resume Next
lSilent = lValue
End Sub

Public Function ReturnSilent() As Boolean
On Local Error Resume Next
ReturnSilent = lSilent
End Function

Public Sub ClearDirectory(lIndex As Integer)
On Local Error Resume Next
With lDirectories.dDir(lIndex)
    .dChecked = False
    .dRemotePath = ""
End With
End Sub

Public Function ReturnShowDialog() As Boolean
On Local Error Resume Next
ReturnShowDialog = lSettings.sShowDialog
End Function

Public Sub SetSetting(lIndex As Integer, lValue As Integer)
On Local Error Resume Next
Select Case lIndex
Case 0
'    Select Case lValue
'    Case 1
'        lSettings.sAutoCheck = True
'    Case 0
'        lSettings.sAutoCheck = False
'    End Select
'Case 1
'    Select Case lValue
'    Case 1
'        lSettings.sAutoUpdate = True
'    Case 0
'        lSettings.sAutoUpdate = False
'    End Select
Case 2
    Select Case lValue
    Case 1
        lSettings.sShowDialog = True
    Case 0
        lSettings.sShowDialog = False
    End Select
'Case 3
'    Select Case lValue
'    Case 1
'        lSettings.sCreateRestorePoints = True
'    Case 0
'        lSettings.sCreateRestorePoints = False
'    End Select
'Case 4
'    Select Case lValue
'    Case 1
'        lSettings.sEnableSound = True
'    Case 0
'        lSettings.sEnableSound = False
'    End Select
'Case 5
'    Select Case lValue
'    Case 1
'        lSettings.sReloadWindow = True
'    Case 0
'        lSettings.sReloadWindow = False
'    End Select
'Case 6
'    Select Case lValue
'    Case 1
'        lSettings.sUseThemeColor = True
'    Case 0
'        lSettings.sUseThemeColor = False
'    End Select
End Select
End Sub

Public Function ReturnDirectory(lIndex As Integer) As String
On Local Error Resume Next
ReturnDirectory = lDirectories.dDir(lIndex).dRemotePath
End Function

Public Sub LoadSettings()
On Local Error Resume Next
'lSettings.sAutoCheck = GetSetting(App.Title, "Settings", "AutoCheck", True)
'lSettings.sAutoUpdate = GetSetting(App.Title, "Settings", "AutoUpdate", False)
'lSettings.sCreateRestorePoints = GetSetting(App.Title, "Settings", "CreateRestorePoints", False)
'lSettings.sEnableSound = GetSetting(App.Title, "Settings", "EnableSound", True)
'lSettings.sReloadWindow = GetSetting(App.Title, "Settings", "ReloadWindow", True)
lSettings.sShowDialog = True
'lSettings.sUseThemeColor = False
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
'SetMainFormAcidmaxVersion lVersion
End Sub

Public Sub SetAcidmaxVersion(lVersion As String)
On Local Error Resume Next
lSettings.sAcidmaxVersion = lVersion
'SetMainFormAcidmaxVersion lVersion
End Sub

Public Function SaveFile(lFileName As String, lText As String) As Boolean
On Local Error Resume Next
If Len(lFileName) <> 0 And Len(lText) <> 0 Then
    Open lFileName For Output As #13
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
                Kill lFiles.fFile(i).fLocalPath & lFiles.fFile(i).fFileName
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
lRecievingSize = False
SetConnected False
lSettings.sAcidmaxDir = ""
For i = 0 To lFiles.fCount
    With lFiles.fFile(i)
        .fFileName = ""
        .fLocalPath = ""
        .fModified = ""
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
    .fModified = ""
    .fNew = False
    .fRemotePath = ""
    .fSize = ""
    .fSizeLow = ""
End With
End Sub

Public Function GetFileTitle(lFileName As String) As String
On Local Error Resume Next
Dim msg() As String
If Len(lFileName) <> 0 Then
    msg = Split(lFileName, "\", -1, vbTextCompare)
    GetFileTitle = msg(UBound(msg))
End If
End Function

Public Function DoesDirectoryExist(lDirectory) As Boolean
On Local Error Resume Next
Dim msg As String
msg = Dir(lDirectory)
If Len(msg) <> 0 Then DoesDirectoryExist = True
End Function

Public Sub ListFiles()
On Local Error Resume Next
Dim i As Integer, b As Boolean, msg As String, msg2 As String, msg3 As String
For i = 0 To 1500
    With lFiles.fFile(i)
        If Len(.fAcidmaxPath) <> 0 And Len(.fLocalPath) <> 0 And Len(.fFileName) <> 0 Then
            If LCase(.fFileName) <> "version.ini" Then
                If DoesFileExist(.fAcidmaxPath & .fFileName) = True Then
                    If CLng(.fSize) <> FileLen(.fAcidmaxPath & .fFileName) Then
                        b = True
                        .fNew = True
                        'AddToFileList .fFileName
                    Else
                        .fNew = False
                    End If
                Else
                    b = True
                    .fNew = True
                    'AddToFileList .fFileName
                    If DoesDirectoryExist(.fAcidmaxPath) = False Then CreateMultiDirectory .fAcidmaxPath
                End If
            End If
        End If
    End With
Next i
lFinishedCheckingFiles = True
SetFTPBusy False
RefreshFTPDirectoryListBox
End Sub

Public Function FileInfo(Optional ByVal PathWithFilename As String) As FILEPROPERTIE
On Local Error Resume Next
Dim lngDummy As Long, lngRc As Long, lngVerPointer As Long, lngHexNumber As Long, bytBuffer() As Byte, bytBuff(255) As Byte, strBuffer As String, strLangCharset As String, strVersionInfo(7) As String, strTemp As String, intTemp As Integer, lngBufferLen As Long
Static BACKUP As FILEPROPERTIE
If Len(PathWithFilename) = 0 Then
    FileInfo = BACKUP
    Exit Function
End If
lngBufferLen = GetFileVersionInfoSize(PathWithFilename, lngDummy)
If lngBufferLen > 0 Then
   ReDim bytBuffer(lngBufferLen)
   lngRc = GetFileVersionInfo(PathWithFilename, 0&, lngBufferLen, bytBuffer(0))
   If lngRc <> 0 Then
      lngRc = VerQueryValue(bytBuffer(0), "\VarFileInfo\Translation", _
               lngVerPointer, lngBufferLen)
      If lngRc <> 0 Then
         MoveMemory bytBuff(0), lngVerPointer, lngBufferLen
         lngHexNumber = bytBuff(2) + bytBuff(3) * &H100 + _
                bytBuff(0) * &H10000 + bytBuff(1) * &H1000000
         strLangCharset = Hex(lngHexNumber)
         Do While Len(strLangCharset) < 8
             strLangCharset = "0" & strLangCharset
         Loop
         strVersionInfo(0) = "CompanyName"
         strVersionInfo(1) = "FileDescription"
         strVersionInfo(2) = "FileVersion"
         strVersionInfo(3) = "InternalName"
         strVersionInfo(4) = "LegalCopyright"
         strVersionInfo(5) = "OriginalFileName"
         strVersionInfo(6) = "ProductName"
         strVersionInfo(7) = "ProductVersion"
         For intTemp = 0 To 7
            strBuffer = String$(255, 0)
            strTemp = "\StringFileInfo\" & strLangCharset _
               & "\" & strVersionInfo(intTemp)
            lngRc = VerQueryValue(bytBuffer(0), strTemp, _
                  lngVerPointer, lngBufferLen)
            If lngRc <> 0 Then
               lstrcpy strBuffer, lngVerPointer
               strBuffer = Mid$(strBuffer, 1, InStr(strBuffer, Chr(0)) - 1)
               strVersionInfo(intTemp) = strBuffer
             Else
               strVersionInfo(intTemp) = "?"
            End If
         Next intTemp
      End If
   End If
End If
FileInfo.CompanyName = strVersionInfo(0)
FileInfo.FileDescription = strVersionInfo(1)
FileInfo.FileVersion = strVersionInfo(2)
FileInfo.InternalName = strVersionInfo(3)
FileInfo.LegalCopyright = strVersionInfo(4)
FileInfo.OrigionalFileName = strVersionInfo(5)
FileInfo.ProductName = strVersionInfo(6)
FileInfo.ProductVersion = strVersionInfo(7)
BACKUP = FileInfo
End Function

Public Function DoesFileExist(lFileName As String) As Boolean
On Local Error GoTo ErrHandler
Dim msg As String
msg = Dir(lFileName)
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

Public Function AddFile(lFile As String, lModified As String, lSize As String, lRemotePath As String) As Boolean
On Local Error Resume Next
If Len(lFile) <> 0 Then
    If InStr(lFile, "\") Then
        AddDirectory lFile
        AddFile = False
        Exit Function
    Else
        If lFile <> ".ftpquota" Then
            lFiles.fCount = lFiles.fCount + 1
            With lFiles.fFile(lFiles.fCount)
                AddFile = True
                .fFileName = lFile
                .fModified = lModified
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
                'If LCase(.fFileName) = "version.ini" Then
                '    If DownloadFile("version.ini") = True Then
                        'SetMainFormNewVersion ReadINI(App.Path & "\version.ini", "Settings", "Version", ""): DoEvents
                '        If Trim(ReturnNewVersion) = Trim(lSettings.sAcidmaxVersion) Then
                '            If ReturnSilent = True Then mIRCStatusSend "//echo Your currently installed version of Acidmax is already up to date"
                '        Else
                '            If ReturnSilent = True Then mIRCStatusSend "//echo Nexgen Acidmax: " & ReturnNewVersion & " is now available. Type /frmDU.Show to Update"
                '        End If
                '    End If
                'End If
            End With
        End If
    End If
End If
End Function

Public Function DoesFileExistInType(lFileName As String) As Boolean
On Local Error GoTo ErrHandler
Dim i As Integer
For i = 0 To lFiles.fCount
    If LCase(lFileName) = LCase(lFiles.fFile(i).fFileName) Then
        DoesFileExistInType = True
        Exit For
    End If
Next i
Exit Function
ErrHandler:
    Err.Clear
    DoesFileExistInType = False
End Function

Public Function FindFileIndex(lFileName As String) As Integer
On Local Error GoTo ErrHandler
Dim i As Integer
For i = 0 To lFiles.fCount
    If LCase(lFileName) = LCase(lFiles.fFile(i).fFileName) Then
        FindFileIndex = i
        Exit For
    End If
Next i
Exit Function
ErrHandler:
    Err.Clear
    FindFileIndex = 0
End Function

Public Sub SetFileName(lIndex As Integer, lFileName As String)
On Local Error Resume Next
lFiles.fFile(lIndex).fFileName = lFileName
End Sub

Public Function AddDirectory(lDirectory As String) As Boolean
On Local Error GoTo ErrHandler
If lDirectory = "/" Or Right(lDirectory, 2) = ".." Or Right(lDirectory, 1) = "." Then Exit Function
If Len(lDirectory) <> 0 Then
    If ReturnDirectoryIndex(lDirectory) <> 0 Then
        AddDirectory = False
        Exit Function
    End If
    lDirectories.dCount = lDirectories.dCount + 1
    lDirectories.dDir(lDirectories.dCount).dRemotePath = lDirectory
    AddDirectory = True
End If
Exit Function
ErrHandler:
    AddDirectory = False
End Function

Public Function ReturnAcidmaxDir() As String
ReturnAcidmaxDir = lSettings.sAcidmaxDir
End Function
