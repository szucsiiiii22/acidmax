Attribute VB_Name = "mdlTetrisUpload"
Option Explicit
Dim lNumber As Integer

Public Sub CloseExistingUploadManager()
On Local Error Resume Next
Dim l As Long
l = ReturnWindowHwnd("Inet Tetris Upload " & Trim(Str(fUploadNumber)), frmMain.lstWindows)
'MsgBox "Inet Tetris Upload " & Trim(Str(fUploadNumber))
SetProgramsText l, "999"
fConnectedToUploadManager = False
End Sub

Public Sub SendCleanupMessage()
On Local Error Resume Next
Dim l As Long
If fConnectedToUploadManager = True Then
    l = ReturnWindowHwnd("Inet Tetris Upload " & Trim(Str(fUploadNumber)), frmMain.lstWindows)
    SetProgramsText l, "421" & fNickname & ".jpg*1*" & Trim(Str(fSnapShotNumber))
End If
End Sub

Public Sub ShowUploadManager()
On Local Error Resume Next
fConnectedToUploadManager = True
fUploadNumber = fUploadNumber + 1
ChDir App.Path
If DoesFileExist(App.Path & "\Tetris Upload.exe") = True Then
    Shell App.Path & "\Tetris Upload.exe " & Trim(Str(fUploadNumber)), vbNormalFocus
    DoEvents
Else
    MsgBox "Upload Manager Not Found!", vbExclamation
End If
If Err.Number <> 0 Then MsgBox Err.Description
End Sub

Public Sub LoginToUploadManagerAndUpdateGraphic(lServer As Boolean)
On Local Error Resume Next
Dim l As Long, msg As String, i As Integer, p As StdPicture
ShowUploadManager
frmMain.picDestination.ScaleMode = 3
frmMain.picOponent.ScaleMode = 3
fSnapShotNumber = fSnapShotNumber + 1
msg = App.Path & "\" & fNickname & Trim(Str(fSnapShotNumber)) & ".bmp"
If DoesFileExist(msg) = True Then Kill msg
Set frmMain.picOponent.Picture = CaptureActiveForm
Do Until frmMain.picOponent.Picture <> 0
    DoEvents
Loop
frmMain.picSnapshot.PaintPicture frmMain.picOponent.Picture, -207, -60, 800, 446: DoEvents
SavePicture frmMain.picSnapshot.Image, msg: DoEvents
ToJpeg msg: DoEvents
'MsgBox fUploadNumber
l = ReturnWindowHwnd("Inet Tetris Upload " & Trim(Str(fUploadNumber)), frmMain.lstWindows)
SetProgramsText l, "420www.00freehost.com*nexgen-tetris.00freehost.com*dietpepsi*" & fNickname & Trim(Str(fSnapShotNumber)) & ".jpg*" & App.Path & "\" & fNickname & Trim(Str(fSnapShotNumber)) & ".jpg*" & fNickname
frmMain.lstGFXCleanup.AddItem fNickname & Trim(Str(fSnapShotNumber)) & ".jpg"
fConnectedToUploadManager = True
End Sub
