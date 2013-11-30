Attribute VB_Name = "mdlRestorePoints"
Option Explicit
Private Type gRestorePoint
    rVersion As String
    rDirectory As String
End Type
Private Type gRestorePoints
    rCount As Integer
    rRestorePoint(2000) As gRestorePoint
End Type
Private lRestorePoints As gRestorePoints

Public Sub LoadRestorePoints()
On Local Error Resume Next
Dim msg As String, i As Integer
msg = App.Path & "\du.ini"
If DoesFileExist(msg) = True Then
    lRestorePoints.rCount = ReadINI(msg, "Settings", "RestorePointCount", 0)
    If i <> 0 Then
        For i = 0 To lRestorePoints.rCount
            With lRestorePoints.rRestorePoint(i)
                .rDirectory = ReadINI(msg, "Restore Point " & Trim(Str(i)), "Directory", "")
                .rVersion = ReadINI(msg, "Restore Point " & Trim(Str(i)), "Version", "")
            End With
        Next i
    End If
End If
End Sub

Public Sub SaveRestorePoints()
On Local Error Resume Next
Dim msg As String, i As Integer
msg = App.Path & "\du.ini"
If DoesFileExist(msg) = True Then
    If lRestorePoints.rCount <> 0 Then
        For i = 0 To lRestorePoints.rCount
            With lRestorePoints.rRestorePoint(i)
                WriteINI msg, "Restore Point " & Trim(Str(i)), "Directory", .rDirectory
                WriteINI msg, "Restore Point " & Trim(Str(i)), "Version", .rVersion
            End With
        Next i
    End If
End If
End Sub

Public Function AddRestorePoint(lDirectory As String, lVersion As String) As Integer
On Local Error Resume Next
lRestorePoints.rCount = lRestorePoints.rCount + 1
With lRestorePoints.rRestorePoint(lRestorePoints.rCount)
    .rDirectory = lDirectory
    .rVersion = lVersion
    AddRestorePoint = lRestorePoints.rCount
End With
End Function

Public Sub CreateRestorePoint(lIndex As Integer)
On Local Error Resume Next
Dim i As Integer, c As Integer
c = ReturnFileCount
For i = 0 To c
    If DoesFileExist(ReturnFileAcidmaxPath(i) & ReturnFileName(i)) = True Then
        FileCopy ReturnFileAcidmaxPath(i) & ReturnFileName(i), lRestorePoints.rRestorePoint(lIndex).rDirectory & ReturnFileName(i)
    Else
        MsgBox "File doesn't exist"
    End If
Next i
End Sub
