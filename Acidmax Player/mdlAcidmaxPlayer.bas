Attribute VB_Name = "mdlAcidmaxPlayer"
Option Explicit
Private lParentHwnd As Long
Private lMainForm As New frmMain
Private lConnectToFServe As New frmConnectToServer
Private Declare Function ShowWindow Lib "user32" (ByVal hWnd As Long, ByVal nCmdShow As Long) As Long
Private Declare Function SetFocus Lib "user32" (ByVal hWnd As Long) As Long
Private Type gFServe
    fDescription As String
    fIP As String
    fPort As Long
End Type
Private Type gFServes
    fCount As Integer
    fFserve(255) As gFServe
End Type
Private lFServes As gFServes
Private lFServeINI As String
Private lAcidmaxEXE As String
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Function SendMessageLong& Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long)
Private Declare Function SendMessageByString Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As String) As Long
Private Const WM_SETTEXT = &HC
Private Const WM_CHAR = &H102
Private Declare Sub ReleaseCapture Lib "user32" ()
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Integer, ByVal lParam As Long) As Long

Private lPlaylistINI As String
Private lPlaylistCount As Integer

Public Function ReadFile(lFile As String) As String
On Local Error GoTo ErrHandler
Dim n As Integer, msg As String
n = FreeFile
If Len(lFile) <> 0 Then
    Open lFile For Input As #n
        msg = StrConv(InputB(LOF(n), n), vbUnicode)
        If Len(msg) <> 0 Then
            ReadFile = Left(msg, Len(msg) - 2)
        End If
    Close #n
End If
Exit Function
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
    lMainForm.lvwPlaylist.Clear
    For i = 1 To lPlaylistCount
        msg = ReadINI(lPlaylistINI, "Playlist", Trim(Str(i)), "")
        If Len(msg) <> 0 Then
            msg2 = GetFileTitle(msg)
            With lMainForm.lvwPlaylist
                .ItemAdd i, msg2, 0, 0
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
                            .SubItemSet l, 2, Right(UCase(msg), 3) & " Media", 0
                        End Select
                        .SubItemSet l, 3, Format(FileLen(msg), "###,###,###"), 0
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

Public Sub SavePlaylist()
On Local Error GoTo ErrHandler
Dim i As Integer, c As Integer
For i = 0 To lMainForm.lvwPlaylist.Count
    If Len(lMainForm.lvwPlaylist.ItemText(i)) <> 0 Then
        c = c + 1
        WriteINI lPlaylistINI, "Playlist", Trim(Str(c)), Trim(lMainForm.lvwPlaylist.SubItemText(i, 1) & lMainForm.lvwPlaylist.ItemText(i))
    End If
Next i
WriteINI lPlaylistINI, "Settings", "Count", Trim(Str(c))
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function DoesPlaylistItemExist(lFilename As String) As Boolean
On Local Error GoTo ErrHandler
Dim i As Integer
i = ReturnPlaylistIndex(lFilename)
If i <> 0 Then
    DoesPlaylistItemExist = True
Else
    If Len(lFilename) <> 0 And LCase(Trim(lFilename)) = LCase(Trim(lMainForm.lvwPlaylist.ItemText(0))) Then DoesPlaylistItemExist = True
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Function ReturnPlaylistIndex(lFilename As String) As Integer
On Local Error GoTo ErrHandler
Dim i As Integer
For i = 0 To lMainForm.lvwPlaylist.Count
    If LCase(Trim(lMainForm.lvwPlaylist.ItemText(i))) = LCase(Trim(lFilename)) Then
        ReturnPlaylistIndex = i
        Exit Function
    End If
Next i
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Sub AddToPlaylist(lFile As String, lPath As String, lType As String, lSize As String)
On Local Error GoTo ErrHandler
Dim i As Integer
If DoesPlaylistItemExist(lFile) = False Then
    lMainForm.lvwPlaylist.ItemAdd 0, lFile, 0, 0
    For i = 0 To lMainForm.lvwPlaylist.Count
        lMainForm.lvwPlaylist.SubItemSet 0, 1, lPath, 0
        lMainForm.lvwPlaylist.SubItemSet 0, 2, lType, 0
        lMainForm.lvwPlaylist.SubItemSet 0, 3, lSize, 0
    Next i
    DoEvents
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

'Public Sub MainFormAddToPlaylist(lFile As String)
'On Local Error GoTo ErrHandler
'lMainForm.AddToPlaylist lFile,
'Exit Sub
'ErrHandler:
'    MsgBox Err.Description
'    Err.Clear
'End Sub

Public Sub FormDrag(lForm As Form)
On Local Error GoTo ErrHandler
ReleaseCapture
Call SendMessage(lForm.hWnd, &HA1, 2, 0&)
DoEvents
SetWindowFocus ReturnParentHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub mIRCStatusSend(lData As String)
On Local Error GoTo ErrHandler
Dim lmIRC As Long, lMdiClient As Long, lmIRCStatus As Long, lEditBox As Long
lmIRC = FindWindow("mIRC", vbNullString)
lMdiClient = FindWindowEx(lmIRC, 0&, "MdiClient", vbNullString)
lmIRCStatus = FindWindowEx(lMdiClient, 0&, "mIRC_Status", vbNullString)
lEditBox = FindWindowEx(lmIRCStatus, 0&, "RichEdit20A", vbNullString)
Call SendMessageByString(lEditBox, WM_SETTEXT, 0&, lData)
If lEditBox = 0 Then Exit Sub
Do
    DoEvents
    lmIRC = FindWindow("mIRC", vbNullString)
    lMdiClient = FindWindowEx(lmIRC, 0&, "MdiClient", vbNullString)
    lmIRCStatus = FindWindowEx(lMdiClient, 0&, "mIRC_Status", vbNullString)
    lEditBox = FindWindowEx(lmIRCStatus, 0&, "RichEdit20A", vbNullString)
    Call SendMessageLong(lEditBox, WM_CHAR, 13, 0&)
Loop Until lEditBox <> 0
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function GetFileTitle(lFilename As String) As String
On Local Error GoTo ErrHandler
Dim msg() As String
If Len(lFilename) <> 0 Then
    msg = Split(lFilename, "\", -1, vbTextCompare)
    GetFileTitle = msg(UBound(msg))
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Sub SetAcidmaxEXE(lData As String)
On Local Error GoTo ErrHandler
lAcidmaxEXE = lData
SetFServeINI
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function ReturnAcidmaxPath() As String
On Local Error GoTo ErrHandler
ReturnAcidmaxPath = Replace(lAcidmaxEXE, "mirc.exe", "")
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Sub SetFServeINI()
On Local Error GoTo ErrHandler
lFServeINI = Replace(lAcidmaxEXE, "mirc.exe", "") & "ap\fserve.ini"
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function ReturnFServeIp(lDescription As String) As String
On Local Error GoTo ErrHandler
Dim i As Integer
For i = 1 To lFServes.fCount
    If LCase(Trim(lFServes.fFserve(i).fDescription)) = LCase(Trim(lDescription)) Then
        ReturnFServeIp = lFServes.fFserve(i).fIP
        Exit For
    End If
Next i
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Function ReturnFServePort(lDescription As String) As Long
On Local Error GoTo ErrHandler
Dim i As Integer
For i = 1 To lFServes.fCount
    If LCase(Trim(lFServes.fFserve(i).fDescription)) = LCase(Trim(lDescription)) Then
        ReturnFServePort = i
        Exit For
    End If
Next i
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Sub ConnectToFServe(lIp As String, lPort As Long)
On Local Error GoTo ErrHandler
Dim mbox As VbMsgBoxResult
'Select Case lMainForm.sckClient.State
'Case sckConnected
'    mbox = MsgBox("Break current connection and connect to " & lIp & "?", vbYesNo + vbQuestion)
'    If mbox = vbNo Then Exit Sub
'End Select
'lMainForm.sckClient.CloseSck
'lMainForm.sckClient.Connect
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function ReturnFServeDescription(lIndex As Integer) As String
On Local Error GoTo ErrHandler
ReturnFServeDescription = lFServes.fFserve(lIndex).fDescription
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ReturnFServeCount() As Integer
On Local Error GoTo ErrHandler
ReturnFServeCount = lFServes.fCount
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Sub AddFServe(lDescription As String, lIp As String, lPort As Long)
On Local Error GoTo ErrHandler
If Len(lDescription) <> 0 And Len(lIp) <> 0 And lPort <> 0 Then
    lFServes.fCount = lFServes.fCount + 1
    With lFServes.fFserve(lFServes.fCount)
        .fDescription = lDescription
        .fIP = lIp
        .fPort = lPort
    End With
End If
DoEvents
SaveFServes
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Public Sub LoadFServes()
On Local Error GoTo ErrHandler
Dim i As Integer
lFServes.fCount = Int(Trim(ReadINI(lFServeINI, "Settings", "Count", 0)))
MsgBox lFServes.fCount
For i = 0 To lFServes.fCount
    lFServes.fFserve(i).fDescription = ReadINI(lFServeINI, Trim(Str(i)), "Description", "")
    lFServes.fFserve(i).fIP = ReadINI(lFServeINI, Trim(Str(i)), "Ip", "")
    lFServes.fFserve(i).fPort = CLng(Trim(ReadINI(lFServeINI, Trim(Str(i)), "Port", "")))
Next i
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Public Sub SaveFServes()
On Local Error GoTo ErrHandler
Dim i As Integer
MsgBox lFServes.fCount
If lFServes.fCount <> 0 Then
    WriteINI lFServeINI, "Settings", "Count", lFServes.fCount
    For i = 1 To lFServes.fCount
        WriteINI lFServeINI, Trim(Str(i)), "Description", lFServes.fFserve(i).fDescription
        WriteINI lFServeINI, Trim(Str(i)), "Ip", lFServes.fFserve(i).fIP
        WriteINI lFServeINI, Trim(Str(i)), "Port", Trim(Str(lFServes.fFserve(i).fPort))
    Next i
End If
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Public Function SetWindowFocus(lhWnd As Long)
On Local Error GoTo ErrHandler
Exit Function
SetFocus lhWnd
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Function ShowNonModalForm(lForm As Form) As Boolean
On Local Error GoTo ErrHandler
ShowWindow lForm.hWnd, 1
Exit Function
ErrHandler:
    Err.Clear
End Function

Public Sub SetParentHwnd(lhWnd As Long)
On Local Error GoTo ErrHandler
lParentHwnd = lhWnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function ReturnParentHwnd() As Long
On Local Error GoTo ErrHandler
ReturnParentHwnd = lParentHwnd
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Sub InitConnectToFServeForm()
On Local Error GoTo ErrHandler
Set lConnectToFServe = New frmConnectToServer
ShowNonModalForm lConnectToFServe
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub InitMainForm()
On Local Error GoTo ErrHandler
Set lMainForm = New frmMain
ShowNonModalForm lMainForm
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub
