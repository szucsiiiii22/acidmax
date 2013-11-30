Attribute VB_Name = "mdlUUEncode"
Public Function UUEncodeFile(strFilePath As String) As String
On Local Error GoTo ErrHandler
Dim intFile As Integer, intTempFile As Integer, lFileSize As Long, strFileName As String, strFileData As String, lEncodedLines As Long, strTempLine As String, i As Long, j As Integer, strResult       As String
strFileName = Mid$(strFilePath, InStrRev(strFilePath, "\") + 1)
strResult = "begin 664 " + strFileName + vbCrLf
lFileSize = FileLen(strFilePath)
lEncodedLines = lFileSize \ 45 + 1
strFileData = Space(45)
intFile = FreeFile
 Open strFilePath For Binary As intFile
    For i = 1 To lEncodedLines
        If i = lEncodedLines Then
            strFileData = Space(lFileSize Mod 45)
        End If
        Get intFile, , strFileData
        strTempLine = Chr(Len(strFileData) + 32)
        If i = lEncodedLines And (Len(strFileData) Mod 3) Then
            strFileData = strFileData + Space(3 - (Len(strFileData) Mod 3))
        End If
        For j = 1 To Len(strFileData) Step 3
            strTempLine = strTempLine + Chr(Asc(Mid(strFileData, j, 1)) \ 4 + 32)
            strTempLine = strTempLine + Chr((Asc(Mid(strFileData, j, 1)) Mod 4) * 16 + Asc(Mid(strFileData, j + 1, 1)) \ 16 + 32)
            strTempLine = strTempLine + Chr((Asc(Mid(strFileData, j + 1, 1)) Mod 16) * 4 + Asc(Mid(strFileData, j + 2, 1)) \ 64 + 32)
            strTempLine = strTempLine + Chr(Asc(Mid(strFileData, j + 2, 1)) Mod 64 + 32)
        Next j
        strTempLine = Replace(strTempLine, " ", "`")
        strResult = strResult + strTempLine + vbCrLf
        strTempLine = ""
    Next i
Close intFile
strResult = strResult & "`" & vbCrLf + "end" + vbCrLf
UUEncodeFile = strResult
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function
