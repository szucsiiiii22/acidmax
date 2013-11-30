Attribute VB_Name = "mdlFiles"
Option Explicit
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
Private Type gFiles
    fCount As Integer
    fFile(1500) As gFile
End Type
Private lFiles As gFiles
Private lmIRCPath As String
Private lNewFiles As Boolean

Public Function GetFileTitle(lFilename As String) As String
On Local Error Resume Next
Dim msg() As String
If Len(lFilename) <> 0 Then
    msg = Split(lFilename, "\", -1, vbTextCompare)
    GetFileTitle = msg(UBound(msg))
End If
End Function

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

Public Function ReturnAcidmaxPath() As String
On Local Error Resume Next
ReturnAcidmaxPath = lmIRCPath
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

Public Function ReturnNewFiles() As Boolean
On Local Error Resume Next
If lNewFiles = True Then ReturnNewFiles = True
End Function

Public Function ReturnFileCount() As Integer
On Local Error Resume Next
ReturnFileCount = lFiles.fCount
End Function

Public Function ReturnFileName(lIndex As Integer)
On Local Error Resume Next
ReturnFileName = lFiles.fFile(lIndex).fFileName
End Function

Public Function ReturnFileAcidmaxPath(lIndex As Integer)
On Local Error Resume Next
ReturnFileAcidmaxPath = lFiles.fFile(lIndex).fAcidmaxPath
End Function

Public Function ReturnFileNew(lIndex As Integer) As Boolean
On Local Error Resume Next
ReturnFileNew = lFiles.fFile(lIndex).fNew
End Function

Public Sub SetMircPath(lPath As String)
On Local Error Resume Next
lmIRCPath = lPath
End Sub

Public Function ReturnFileSize(lIndex As Integer) As String
On Local Error GoTo ErrHandler
ReturnFileSize = lFiles.fFile(lIndex).fSize
Exit Function
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

Public Function ReturnFileLocalPath(lIndex As Integer) As String
On Local Error GoTo ErrHandler
ReturnFileLocalPath = Trim(lFiles.fFile(lIndex).fLocalPath)
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function DoesDirectoryExist(lDirectory) As Boolean
On Local Error Resume Next
Dim msg As String
msg = Dir(lDirectory)
If Len(msg) <> 0 Then DoesDirectoryExist = True
End Function

Public Function AddFile(lFile As String, lModified As String, lSize As String, lRemotePath As String) As Boolean
On Local Error Resume Next
If lFile <> ".ftpquota" Then
    lFiles.fCount = lFiles.fCount + 1
    With lFiles.fFile(lFiles.fCount)
        .fFileName = lFile
        .fModified = lModified
        .fSize = lSize
        .fRemotePath = lRemotePath
        .fLocalPath = App.Path & "\"
        .fAcidmaxPath = lmIRCPath & "\" & .fRemotePath
        .fAcidmaxPath = Replace(.fAcidmaxPath, "*.*", "")
        .fAcidmaxPath = Replace(.fAcidmaxPath, "*.**.*", "")
        .fAcidmaxPath = Replace(.fAcidmaxPath, "/", "\")
        .fAcidmaxPath = Replace(.fAcidmaxPath, "\\\", "\")
        .fAcidmaxPath = Replace(.fAcidmaxPath, "\\", "\")
        If Right(.fAcidmaxPath, 1) <> "\" Then .fAcidmaxPath = .fAcidmaxPath & "\"
        If LCase(.fFileName) <> "version.ini" Then
            If DoesFileExist(.fAcidmaxPath & .fFileName) = True Then
                If .fSize <> FileLen(.fAcidmaxPath & .fFileName) Then
                    lNewFiles = True
                    .fNew = True
                Else
                End If
            Else
                lNewFiles = True
                .fNew = True
            End If
        End If
    End With
End If
End Function
