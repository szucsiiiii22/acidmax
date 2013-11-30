Attribute VB_Name = "mdlPlaylist"
Option Explicit
Private lPlaylistINI As String
Private lPlaylistCount As Integer

Public Function ReturnPlaylistINI() As String
On Local Error GoTo ErrHandler
ReturnPlaylistINI = lPlaylistINI
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Sub LoadPlaylist()
On Local Error GoTo ErrHandler
Dim i As Integer, msg As String, msg2 As String, l As Integer
lPlaylistINI = ReturnAcidmaxPath & "ap\playlist.ini"
lPlaylistCount = Int(ReadINI(lPlaylistINI, "Settings", "Count", 0))
If lPlaylistCount <> 0 Then
    For i = 0 To lPlaylistCount
        msg = ReadINI(lPlaylistINI, "Playlist", Trim(Str(i)), "")
        If Len(msg) <> 0 Then
            msg2 = GetFileTitle(msg)
            With frmMain.lvwPlaylist
                .Clear
                .ItemAdd 0, msg2, 0, 0
                For l = 0 To .Count
                    If LCase(Trim(.ItemText(l))) = Trim(LCase(msg2)) Then
                        .SubItemSet l, 1, Left(msg, Len(msg) - Len(msg2)), 0
                        Select Case Right(LCase(msg), 4)
                        Case ".mp3"
                            .SubItemSet l, 2, "Mpeg Layer 3", 0
                        Case ".wav"
                            .SubItemSet l, 2, "Raw Audio", 0
                        Case ".ogg"
                            .SubItemSet l, 2, "Ogg Audio", 0
                        Case ".mpg"
                            .SubItemSet l, 2, "Mpeg Video", 0
                        Case "mpeg"
                            .SubItemSet l, 2, "Mpeg Video", 0
                        Case ".avi"
                            .SubItemSet l, 2, "Avi Video", 0
                        Case ".wma"
                            .SubItemSet l, 2, "Windows Media Audio", 0
                        Case ".wmv"
                            .SubItemSet l, 2, "Windows Media Video", 0
                        Case ".wmx"
                            .SubItemSet l, 2, "Windows Media Audio/Video", 0
                        Case ".mid"
                            .SubItemSet l, 2, "Midi Audio", 0
                        Case "divx"
                            .SubItemSet l, 2, "DivX Video", 0
                        Case Else
                            .SubItemSet l, 2, Right(UCase(msg), 3) & " Media"
                        End Select
                        .SubItemSet l, 3, FileLen(msg)
                    End If
                Next l
            End With
        End If
    Next i
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

'Private Sub InitPlaylist()
'On Local Error GoTo ErrHandler
'Dim c As Integer, i As Integer, msg As String, msg2 As String, l As Integer
'c = Int(Trim(GetSetting(App.Title, "Playlist", "Count", 0)))
'If c <> 0 Then
'    For i = 1 To c
'        msg = GetSetting(App.Title, "Playlist", Trim(Str(i)), "")
'        msg2 = GetFileTitle(msg)
'        lvwPlaylist.ItemAdd 0, msg2, 0, 0
'        For l = 0 To lvwPlaylist.Count
'            If LCase(Trim(lvwPlaylist.ItemText(l))) = Trim(LCase(msg2)) Then
'                lvwPlaylist.SubItemSet l, 1, Left(msg, Len(msg) - Len(msg2)), 0
'                lvwPlaylist.SubItemSet l, 2, "Media", 0
'            End If
'        Next l
'        'If Len(msg) <> 0 Then lstPlaylist.AddItem msg
'    Next i
'End If
'Exit Sub
'ErrHandler:
'    MsgBox Err.Description
'    Err.Clear
'End Sub

Public Sub SavePlaylist()
On Local Error GoTo ErrHandler
Dim i As Integer, c As Integer
For i = 0 To lMainForm.lvwPlaylist.Count
    If Len(lMainForm.lvwPlaylist.ItemText(i)) <> 0 Then
        c = c + 1
        'SaveSetting App.Title, "Playlist", Trim(Str(c)), lMainForm.lvwPlaylist.ItemText(i)
        WriteINI ReturnPlaylistINI, "Playlist", Trim(Str(c)), lMainForm.lvwPlaylist.ItemText(i)
    End If
Next i
SaveSetting App.Title, "Playlist", "Count", Trim(Str(c))
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub
