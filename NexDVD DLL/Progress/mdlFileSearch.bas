Attribute VB_Name = "mdlFileSearch"
Option Explicit
Public Type tSearch
    Count As Long
    Path As New Collection
    Size As New Collection
    DateTime As New Collection
    Attr As New Collection
End Type

Public Sub GetDirs(ByVal sDir As String, DirAttr As VbFileAttribute, cCol As tSearch)
On Local Error Resume Next
Dim lTmp1 As Long, sStr1 As String, sStr2 As String, sResult() As String
sStr2 = ""
For lTmp1 = 0 To sSplit(sDir, "", sResult)
    sResult(lTmp1) = Trim$(sResult(lTmp1))
    If Right$(sResult(lTmp1), 1) <> "\" Then
        sResult(lTmp1) = sResult(lTmp1) + "\"
    End If
    If InStr(sStr2, UCase$(sResult(lTmp1)) + ";") < 1 Then
          sStr2 = sStr2 + UCase$(sResult(lTmp1)) + ";"
        sStr1 = Dir$(sResult(lTmp1) + "*.*", DirAttr)
        While sStr1 <> ""
            DoEvents
            If sStr1 <> "." And sStr1 <> ".." Then
                If (GetAttr(sResult(lTmp1) + sStr1) And vbDirectory) = vbDirectory Then
                    cCol.Path.Add sResult(lTmp1) + sStr1
                    cCol.Size.Add 0
                    cCol.DateTime.Add FileDateTime(sResult(lTmp1) + sStr1)
                    cCol.Attr.Add GetAttr(sResult(lTmp1) + sStr1)
                End If
            End If
            sStr1 = Dir
        Wend
    End If
Next
cCol.Count = cCol.Path.Count
If Err.Number <> 0 Then SetError "GetDirs", Err.Description
End Sub

Public Sub GetSubDirs(ByVal sDir As String, DirAttr As VbFileAttribute, cCol As tSearch)
On Local Error Resume Next
Dim lTmp1 As Long, cCol1 As tSearch
GetDirs sDir, DirAttr, cCol1
For lTmp1 = 1 To cCol1.Count
    cCol.Path.Add cCol1.Path(lTmp1)
    cCol.Size.Add 0
    cCol.DateTime.Add cCol1.DateTime(lTmp1)
    cCol.Attr.Add cCol1.Attr(lTmp1)
    GetSubDirs cCol1.Path(lTmp1), DirAttr, cCol
Next
cCol.Count = cCol.Path.Count
If Err.Number <> 0 Then SetError "GetSubDirs", Err.Description
End Sub

Public Sub GetFiles(sDir As String, sFilter As String, FileAttr As VbFileAttribute, cCol As tSearch)
On Local Error Resume Next
Dim lTmp1 As Long, lTmp2 As Long, lTmp3 As Long, sStr1 As String, sStr2 As String, sStr3 As String, sResult1() As String, sResult2() As String
sStr2 = ""
For lTmp1 = 0 To sSplit(sDir, "", sResult1)
    sResult1(lTmp1) = Trim$(sResult1(lTmp1))
    If Right$(sResult1(lTmp1), 1) <> "\" Then
        sResult1(lTmp1) = sResult1(lTmp1) + "\"
    End If
    If InStr(sStr2, UCase$(sResult1(lTmp1)) + ";") < 1 Then
        sStr2 = sStr2 + UCase$(sResult1(lTmp1)) + ";"
        sStr3 = ""
        For lTmp2 = 0 To sSplit(sFilter, "", sResult2)
            sResult2(lTmp2) = Trim$(sResult2(lTmp2))
            If InStr(sStr3, UCase$(sResult2(lTmp2)) + ";") < 1 Then
                sStr3 = sStr3 + UCase$(sResult2(lTmp2)) + ";"
                sStr1 = Dir$(sResult1(lTmp1) + sResult2(lTmp2), FileAttr)
                DoEvents
                While sStr1 <> ""
                    cCol.Path.Add sResult1(lTmp1) + sStr1
                    cCol.Size.Add FileLen(sResult1(lTmp1) + sStr1)
                    cCol.DateTime.Add FileDateTime(sResult1(lTmp1) + sStr1)
                    cCol.Attr.Add GetAttr(sResult1(lTmp1) + sStr1)
                    sStr1 = Dir
                Wend
            End If
        Next
    End If
Next
cCol.Count = cCol.Path.Count
If Err.Number <> 0 Then SetError "GetFiles", Err.Description
End Sub

Public Sub GetSubFiles(sDir As String, sFilter As String, DirAttr As VbFileAttribute, FileAttr As VbFileAttribute, cCol As tSearch)
On Local Error Resume Next
Dim lTmp1 As Long, sStr1 As String, cCol1 As tSearch
GetSubDirs sDir, DirAttr, cCol1
sStr1 = ""
For lTmp1 = 1 To cCol1.Count
    sStr1 = sStr1 + cCol1.Path(lTmp1) + ";"
Next
GetFiles sStr1, sFilter, FileAttr, cCol
cCol.Count = cCol.Path.Count
If Err.Number <> 0 Then SetError "GetSubFiles", Err.Description
End Sub

Private Function sSplit(ByVal sStr1 As String, sDelims As String, sResult() As String) As Long
On Local Error Resume Next
Dim nResult As Long, lTmp1 As Long, lTmp2 As Long
If sDelims = "" Then
    sDelims = ";" + Chr$(0) + Chr$(9) + Chr$(10) + Chr$(13)
End If
If InStr(1, Right$(sStr1, 1), sDelims, vbBinaryCompare) < 1 Then
    sStr1 = sStr1 + Left$(sDelims, 1)
End If
nResult = -1
lTmp1 = 1
For lTmp2 = 1 To Len(sStr1)
    If InStr(1, sDelims, Mid$(sStr1, lTmp2, 1), vbBinaryCompare) > 0 Then
        nResult = nResult + 1
        ReDim Preserve sResult(0 To nResult) As String
        sResult(nResult) = Mid$(sStr1, lTmp1, lTmp2 - lTmp1)
        lTmp1 = lTmp2 + 1
    End If
Next
If lTmp1 < 3 Then
    nResult = -1
End If
sSplit = nResult
If Err.Number <> 0 Then SetError "sSplit", Err.Description
End Function
