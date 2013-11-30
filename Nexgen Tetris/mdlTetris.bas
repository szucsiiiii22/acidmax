Attribute VB_Name = "mdlTetris"
Option Explicit
Private Declare Function sndPlaySound Lib "winmm.dll" Alias "sndPlaySoundA" (ByVal lpszSoundName As String, ByVal uFlags As Long) As Long
Private Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Integer, ByVal hwndCallback As Integer) As Long
Private Declare Sub keybd_event Lib "user32" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As Long)
Private Const VK_SNAPSHOT = &H2C
Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Private Declare Function BMPToJPG Lib "2jpeg.dll" (ByVal InputFilename As String, ByVal OutputFilename As String, ByVal Quality As Long) As Integer
Private Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Private Const HWND_NOTOPMOST = -2
Private Const HWND_TOPMOST = -1
Private Const SWP_NOACTIVATE = &H10
Private Const SWP_SHOWWINDOW = &H40
Global fNickname As String
Global fClientOponentNickname As String
Global fServerOponentNickname As String
Global fSnapShotNumber As Long
Global fServer As Boolean
Global fClient As Boolean
Global fConnectedToUploadManager As Boolean
Global fUploadNumber As Long

Public Sub AlwaysOnTop(myfrm As Form, SetOnTop As Boolean)
On Local Error Resume Next
Dim lFlag As Integer
If SetOnTop Then
    lFlag = HWND_TOPMOST
Else
    lFlag = HWND_NOTOPMOST
End If
SetWindowPos myfrm.hwnd, lFlag, myfrm.Left / Screen.TwipsPerPixelX, myfrm.Top / Screen.TwipsPerPixelY, myfrm.Width / Screen.TwipsPerPixelX, myfrm.Height / Screen.TwipsPerPixelY, SWP_NOACTIVATE Or SWP_SHOWWINDOW
End Sub

Public Function CropFunc(lSrcPictureBox As PictureBox, lDestPictureBox As PictureBox, lLeft As Long, lTop As Long, lWidth As Long, lHeight As Long)
Dim l As Long
Const PIXEL = 3
lSrcPictureBox.ScaleMode = PIXEL
lDestPictureBox.ScaleMode = PIXEL
l = BitBlt(lDestPictureBox.hDC, lLeft, lTop, lWidth, lHeight, lSrcPictureBox.hDC, 0, 0, &HCC0020)
End Function

Public Function FindListBoxIndex(lText As String, lListBox As ListBox) As Integer
On Local Error Resume Next
Dim i As Integer
For i = 0 To lListBox.ListCount
    If LCase(lText) = LCase(lListBox.List(i)) Then
        FindListBoxIndex = i
        Exit Function
    End If
Next i
End Function

Public Sub ToJpeg(lFilename As String)
On Local Error Resume Next
ChDir App.Path
BMPToJPG lFilename, Left(lFilename, Len(lFilename) - 4) & ".jpg", 0: DoEvents
'FileCopy Left(lFilename, Len(lFilename) - 4) & ".jpg", Left(lFilename, Len(lFilename) - 4) & ".gif"
End Sub


Public Function GetRnd(Num As Long) As Long
On Local Error Resume Next
Randomize Timer
GetRnd = Int((Num * Rnd) + 1)
End Function

Public Sub LoadCapture(lFilename As String)
On Local Error Resume Next
frmMain.picOponent.Picture = LoadPicture(lFilename): DoEvents
End Sub

Public Function CaptureActiveForm() As StdPicture
On Local Error Resume Next
Clipboard.Clear
Call keybd_event(VK_SNAPSHOT, 1, 0, 0): DoEvents
Set CaptureActiveForm = Clipboard.GetData(): DoEvents
Clipboard.Clear
End Function

Public Sub CropImage(lLeft As Long, lTop As Long, lWidth As Long, lHeight As Long, lSource As PictureBox, lDestination As PictureBox)
On Local Error Resume Next
BitBlt lDestination.hDC, 0, 0, lDestination.Width, lDestination.Height, lSource.hDC, lWidth, lHeight, vbSrcCopy
End Sub

Public Sub PlayMid(sFileName As String)
On Local Error Resume Next
Dim returnstring As String * 128, i%, CommandString, a&
returnstring = Space(128)
For i% = 1 To 3
    Select Case i%
    Case 1
        CommandString = "close mymid"
    Case 2
        CommandString = "open " & sFileName & " type sequencer alias mymid"
    Case 3
        'CommandString = "play mymid from 1"
    End Select
    a& = mciSendString(CommandString, returnstring, Len(returnstring), 0)
Next i%
End Sub

Public Function DoesFileExist(lFilename As String) As Boolean
On Local Error Resume Next
Dim msg As String
msg = Dir(lFilename)
If msg <> "" Then
    DoesFileExist = True
Else
    DoesFileExist = False
End If
End Function

Public Sub CheckRequiredFiles()
On Local Error Resume Next
If DoesFileExist(App.Path & "\died.wav") = False Then DownloadFile "http://www.team-nexgen.com/downloads/addons/died.wav", App.Path & "\died.wav": DoEvents
If DoesFileExist(App.Path & "\drop.wav") = False Then DownloadFile "http://www.team-nexgen.com/downloads/addons/drop.wav", App.Path & "\drop.wav": DoEvents
If DoesFileExist(App.Path & "\erase.wav") = False Then DownloadFile "http://www.team-nexgen.com/downloads/addons/erase.wav", App.Path & "\erase.wav": DoEvents
If DoesFileExist(App.Path & "\levelUp.WAV") = False Then DownloadFile "http://www.team-nexgen.com/downloads/addons/levelUp.WAV", App.Path & "\levelUp.WAV": DoEvents
If DoesFileExist(App.Path & "\rotate.WAV") = False Then DownloadFile "http://www.team-nexgen.com/downloads/addons/rotate.WAV", App.Path & "\rotate.WAV": DoEvents
If DoesFileExist(App.Path & "\SCRATCH.WAV") = False Then DownloadFile "http://www.team-nexgen.com/downloads/addons/SCRATCH.WAV", App.Path & "\SCRATCH.WAV": DoEvents
If DoesFileExist(App.Path & "\smash.wav") = False Then DownloadFile "http://www.team-nexgen.com/downloads/addons/smash.wav", App.Path & "\smash.wav": DoEvents
If DoesFileExist(App.Path & "\splat.wav") = False Then DownloadFile "http://www.team-nexgen.com/downloads/addons/splat.wav", App.Path & "\splat.wav": DoEvents
If DoesFileExist(App.Path & "\2jpeg.dll") = False Then DownloadFile "http://www.team-nexgen.com/downloads/addons/2jpeg.dll", App.Path & "\2jpeg.dll": DoEvents
If DoesFileExist(App.Path & "\ltu.exe") = False Then DownloadFile "http://www.team-nexgen.com/downloads/addons/ltu.exe", App.Path & "\ltu.exe": DoEvents
If DoesFileExist(App.Path & "\Tetris Upload.exe") = False Then DownloadFile "http://www.team-nexgen.com/downloads/addons/Tetris Upload.exe", App.Path & "\Tetris Upload.exe": DoEvents
End Sub

Public Sub DownloadFile(lUrl As String, lFile As String)
On Local Error Resume Next
Dim f As New frmDownloadFile
Set f = New frmDownloadFile
'f.Show
f.ClickDownloadButton lUrl, lFile
End Sub

Sub PlayAgain()
On Local Error Resume Next
Dim returnstring As String * 128, CommandString, a&
returnstring = Space(128)
CommandString = "play mymid from 1"
a& = mciSendString(CommandString, returnstring, Len(returnstring), 0)
End Sub

Public Sub StopMid()
On Local Error Resume Next
Dim returnstring As String * 128, CommandString, a&
returnstring = Space(128)
CommandString = "close mymid"
a& = mciSendString(CommandString, returnstring, Len(returnstring), 0)
CommandString = "close mymid1"
a& = mciSendString(CommandString, returnstring, Len(returnstring), 0)
End Sub

Public Sub PlayWav(sFileName As String)
On Local Error Resume Next
Dim x&
x& = sndPlaySound(sFileName, 1)
End Sub

Public Sub Delay(secs As Single)
On Local Error Resume Next
Dim kkk, ttt
kkk = Timer
Do While Int((ttt - kkk) * 1000) < (secs * 1000)
    ttt = Timer
    DoEvents
Loop
End Sub

Public Sub PlayMid1(sFileName As String)
On Local Error Resume Next
Dim returnstring As String * 128, i%, CommandString, a&
returnstring = Space(128)
For i% = 1 To 3
    Select Case i%
    Case 1
        CommandString = "close mymid1"
    Case 2
        CommandString = "open " & sFileName & " type sequencer alias mymid1"
    Case 3
    End Select
    a& = mciSendString(CommandString, returnstring, Len(returnstring), 0)
Next i%
End Sub

Sub PlayAgain1()
On Local Error Resume Next
Dim returnstring As String * 128, CommandString, a&
returnstring = Space(128)
CommandString = "play mymid1 from 1"
a& = mciSendString(CommandString, returnstring, Len(returnstring), 0)
End Sub
