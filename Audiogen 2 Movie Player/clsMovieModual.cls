VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsMovieModule"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Private Declare Function mciGetErrorString Lib "winmm.dll" Alias "mciGetErrorStringA" (ByVal dwError As Long, ByVal lpstrBuffer As String, ByVal uLength As Long) As Long 'Get the error message of the mcidevice if any
Private Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Long, ByVal hwndCallback As Long) As Long 'Send command strings to the mci device
Private lData As String * 128
Public lErr As Long
Public lFilename As String

Public Function StepFrames(lValue As Long)
'On Local Error Resume Next
lErr = mciSendString("step movie by " & lValue, 0, 0, 0)
End Function

Public Function RestoreSizeDefault()
'On Local Error Resume Next
lErr = mciSendString("put movie window", 0, 0, 0)
End Function

Public Function OpenMovie()
'On Local Error Resume Next
Dim a As Long
lFilename = Chr$(34) & lFilename & Chr$(34)
lErr = mciSendString("close movie", 0, 0, 0)
lErr = mciSendString("open " & lFilename & " type mpegvideo alias movie", 0, 0, 0)
End Function

Public Function OpenMovieWindow(hWnd As Long, WindowStyle As String)
'On Local Error Resume Next
lFilename = Chr$(34) & lFilename & Chr$(34)
lErr = mciSendString("close movie", 0, 0, 0)
lErr = mciSendString("open " & lFilename & " type mpegvideo alias movie parent " & hWnd & " style " & WindowStyle & " ", 0, 0, 0)
End Function

Public Function MinimizeMovie()
'On Local Error Resume Next
lErr = mciSendString("window movie state minimized", 0, 0, 0)
End Function

Public Function PlayMovie()
'On Local Error Resume Next
lErr = mciSendString("play movie", 0, 0, 0)
End Function

Public Function HideMovie()
'On Local Error Resume Next
lErr = mciSendString("window movie state hide", 0, 0, 0)
End Function

Public Function ShowMovie()
'On Local Error Resume Next
lErr = mciSendString("window movie state show", 0, 0, 0)
End Function

Public Function RestoreMovie()
'On Local Error Resume Next
lErr = mciSendString("window movie state restore", 0, 0, 0)
End Function

Public Function StopMovie()
'On Local Error Resume Next
lErr = mciSendString("stop movie", 0, 0, 0)
End Function

Public Function ExtractCurrentMovieSize(lLeft As Long, lTop As Long, lWidth As Long, lHeight As Long)
'On Local Error Resume Next
Dim msg As String, msg2 As String, msg3 As String, msg4 As String, msg5 As String
msg = GetCurrentSize
msg2 = InStr(1, msg, " ")
msg3 = InStr(msg2 + 1, msg, " ")
msg4 = Mid(msg, msg3 + 1)
msg5 = InStr(1, msg4, " ")
lWidth = Val(Left(msg4, msg5))
lHeight = Val(Mid(msg4, msg5))
End Function

Public Function ExtractDefaultMovieSize(lWidth As Long, lHeight As Long)
'On Local Error Resume Next
Dim msg As String, msg2 As String, msg3 As String, msg4 As String, msg5 As String
msg = GetDefaultSize
msg2 = InStr(1, msg, " ")
msg3 = InStr(msg2 + 1, msg, " ")
msg4 = Mid(msg, msg3 + 1)
msg5 = InStr(1, msg4, " ")
lWidth = Val(Left(msg4, msg5))
lHeight = Val(Mid(msg4, msg5))
End Function

Public Function GetBitsPerPixel()
'On Local Error Resume Next
lErr = mciSendString("status movie bitsperpel", lData, 128, 0)
GetBitsPerPixel = Val(lData)
End Function

Public Function GetMovieInput() As String
'On Local Error Resume Next
lErr = mciSendString("status movie monitor input", lData, 128, 0)
GetMovieInput = lData
End Function

Public Function GetMovieOutput() As String
'On Local Error Resume Next
lErr = mciSendString("status movie monitor output", lData, 128, 0)
GetMovieOutput = lData
End Function

Public Sub SetMovieWindow(lHwnd As Long)
'On Local Error Resume Next
If lHwnd <> 0 Then
    lErr = mciSendString("window handle " & Str(lHwnd), lData, 128, 0)
End If
End Sub

Public Function GetAudioStatus() As String
'On Local Error Resume Next
lErr = mciSendString("status movie audio", lData, 128, 0)
GetAudioStatus = lData
End Function

Public Function SizeLocateMovie(lLeft As Long, lTop As Long, lWidth As Long, lHeight As Long)
'On Local Error Resume Next
lErr = mciSendString("put movie window at " & lLeft & " " & lTop & " " & lWidth & " " & lHeight, 0, 0, 0)
End Function

Public Function IsMoviePlaying() As Boolean
'On Local Error Resume Next
Dim isPlaying As String
lErr = mciSendString("status movie mode", lData, 128, 0)
isPlaying = Left(lData, 7)
If isPlaying = "playing" Then
    IsMoviePlaying = True
Else
    IsMoviePlaying = False
End If
End Function

Public Function CheckError() As String
'On Local Error Resume Next
CheckError = Space$(255)
mciGetErrorString Error, CheckError, Len(CheckError)
End Function

Public Function GetDeviceName() As String
'On Local Error Resume Next
lErr = mciSendString("info movie product", lData, 128, 0)
GetDeviceName = lData
End Function

Public Function GetDeviceVersion() As String
'On Local Error Resume Next
lErr = mciSendString("info movie version", lData, 128, 0)
GetDeviceVersion = lData
End Function

Public Function GetNominalFrameRate() As Long
'On Local Error Resume Next
lErr = mciSendString("status movie nominal frame rate wait", lData, 128, 0)
GetNominalFrameRate = Val(lData)
End Function

Public Function GetFramePerSecRate() As Long
'On Local Error Resume Next
lErr = mciSendString("status movie frame rate", lData, 128, 0)
GetFramePerSecRate = Val(lData) \ 1000
End Function

Public Function GetCurrentSize() As String
'On Local Error Resume Next
lErr = mciSendString("where movie destination max", lData, 128, 0)
GetCurrentSize = lData
End Function

Public Function GetDefaultSize() As String
'On Local Error Resume Next
lErr = mciSendString("where movie source", lData, 128, 0)
GetDefaultSize = lData
End Function

Public Function GetLengthInFrames() As Long
'On Local Error Resume Next
lErr = mciSendString("set movie time format frames", 0, 0, 0)
lErr = mciSendString("status movie length", lData, 128, 0)
GetLengthInFrames = Val(lData)
End Function

Public Function GetLengthInMS() As Long
'On Local Error Resume Next
lErr = mciSendString("set movie time format ms", 0, 0, 0)
lErr = mciSendString("status movie length", lData, 128, 0)
GetLengthInMS = Val(lData)
End Function

Public Function PlayFullScreen()
'On Local Error Resume Next
lErr = mciSendString("play movie fullscreen", 0, 0, 0)
End Function

Public Function GetLengthInSec() As Long
'On Local Error Resume Next
GetLengthInSec = GetLengthInMS \ 1000
End Function

Public Function SetVideoOff()
'On Local Error Resume Next
lErr = mciSendString("set all video off", 0, 0, 0)
End Function

Public Function SetVideoOn()
'On Local Error Resume Next
lErr = mciSendString("set all video on", 0, 0, 0)
End Function

Public Function PauseMovie()
'On Local Error Resume Next
lErr = mciSendString("pause movie", 0, 0, 0)
End Function

Public Function ResumeMovie()
'On Local Error Resume Next
lErr = mciSendString("resume movie", 0, 0, 0)
End Function

Public Function GetPositionInMS() As Long
'On Local Error Resume Next
lErr = mciSendString("set movie time format ms", 0, 0, 0)
lErr = mciSendString("status movie position wait", lData, 128, 0)
GetPositionInMS = Val(lData)
End Function

Public Function GetRate() As Long
'On Local Error Resume Next
lErr = mciSendString("status movie speed", lData, 128, 0)
GetRate = Val(lData)
End Function

Public Function GetPositionInFrames() As Long
'On Local Error Resume Next
lErr = mciSendString("set movie time format frames wait", 0, 0, 0)
lErr = mciSendString("status movie position", lData, 128, 0)
GetPositionInFrames = Val(lData)
End Function

Public Function GetStatus() As String
'On Local Error Resume Next
lErr = mciSendString("status movie mode", lData, 128, 0)
GetStatus = StrConv(lData, vbProperCase)
End Function

Public Function CloseMovie()
'On Local Error Resume Next
lErr = mciSendString("close all", 0, 0, 0)
End Function

Public Function GetFormatPosition() As String
'On Local Error Resume Next
GetFormatPosition = GetThisTime(GetPositionInMS)
End Function

Public Function GetFormatLength() As String
'On Local Error Resume Next
GetFormatLength = GetThisTime(GetLengthInMS)
End Function

Private Function GetThisTime(ByVal lTime As Long) As String
On Local Error GoTo ErrHandler
Dim i As Integer, n As Integer, t As Integer, l As Long, msg As String
l = lTime / 1000
i = Int(l / 3600)
l = l Mod 3600
n = Int(l / 60)
l = l Mod 60
t = l
If i > 0 Then
    msg = Trim(Str(i)) & ":"
Else
    msg = ""
End If
If n >= 10 Then
    msg = msg & Trim(Str(n))
ElseIf n > 0 Then
    msg = msg & Trim(Str(n))
Else
    msg = msg & "0"
End If
msg = msg & ":"
If t >= 10 Then
    msg = msg & Trim(Str(t))
ElseIf t > 0 Then
    msg = msg & "0" & Trim(Str(t))
Else
    msg = msg & "00"
End If
GetThisTime = msg
Exit Function
ErrHandler:
    MsgBox Err.Description, vbExclamation
End Function

Public Function GetVolume() As Long
'On Local Error Resume Next
lErr = mciSendString("status movie volume", lData, 128, 0)
GetVolume = Val(lData)
End Function

Public Function GetVideoStatus() As String
'On Local Error Resume Next
lErr = mciSendString("status movie video", lData, 128, 0)
GetVideoStatus = lData
End Function

Public Function GetTimeFormat() As String
'On Local Error Resume Next
lErr = mciSendString("status movie time format", lData, 128, 0)
GetTimeFormat = lData
End Function

Public Function GetLeftVolume() As Long
'On Local Error Resume Next
lErr = mciSendString("status movie left volume", lData, 128, 0)
GetLeftVolume = Val(lData)
End Function

Public Function GetPositionInSec() As Long
'On Local Error Resume Next
GetPositionInSec = GetPositionInMS \ 1000
End Function

Public Function GetRightVolume() As Long
'On Local Error Resume Next
lErr = mciSendString("status movie right volume", lData, 128, 0)
GetRightVolume = lData
End Function

Public Function SetAudioOff()
'On Local Error Resume Next
lErr = mciSendString("set movie audio all off", 0, 0, 0)
End Function

Public Function SetAudioOn()
'On Local Error Resume Next
lErr = mciSendString("set movie audio all on", 0, 0, 0)
End Function

Public Function SetLeftOff()
'On Local Error Resume Next
lErr = mciSendString("set movie audio left off", 0, 0, 0)
End Function

Public Function SetRightOff()
'On Local Error Resume Next
lErr = mciSendString("set movie audio right off", 0, 0, 0)
End Function

Public Function SetLeftOn()
'On Local Error Resume Next
lErr = mciSendString("set movie audio left on", 0, 0, 0)
End Function

Public Function SetRightOn()
'On Local Error Resume Next
lErr = mciSendString("set movie audio right on", 0, 0, 0)
End Function

Public Function SetDoorOpen()
'On Local Error Resume Next
lErr = mciSendString("set cdaudio door open", 0, 0, 0)
End Function

Public Function SetDoorClosed()
'On Local Error Resume Next
lErr = mciSendString("set cdaudio door closed", 0, 0, 0)
End Function

Public Function SetVolume(lValue As Long)
'On Local Error Resume Next
lErr = mciSendString("setaudio movie volume to " & lValue, 0, 0, 0)
End Function

Public Function SetPositionTo(lSecond As Long)
'On Local Error Resume Next
lSecond = lSecond * 1000
If IsMoviePlaying = True Then
    mciSendString "play movie from " & lSecond, 0, 0, 0
Else
    mciSendString "seek movie to " & lSecond, 0, 0, 0
End If
End Function

Public Function RestartMovie()
'On Local Error Resume Next
lErr = mciSendString("seek movie to start", 0, 0, 0)
PlayMovie
End Function

Public Function RewindByMS(lMilleseconds As Long)
'On Local Error Resume Next
lErr = mciSendString("set movie time format ms", 0, 0, 0)
lErr = mciSendString("play movie from " & GetPositionInMS - lMilleseconds, 0, 0, 0)
End Function

Public Function RewindByFrames(lFrames As Long)
'On Local Error Resume Next
lErr = mciSendString("set movie time format frames", 0, 0, 0)
lErr = mciSendString("play movie from " & GetPositionInFrames - lFrames, 0, 0, 0)
End Function

Public Function RewindBySeconds(lSeconds As Long)
'On Local Error Resume Next
lErr = mciSendString("set movie time format ms", 0, 0, 0)
lErr = mciSendString("play movie from " & GetPositionInMS - 1000 * lSeconds, 0, 0, 0)
End Function

Public Function ForwardByFrames(lFrames As Long)
'On Local Error Resume Next
lErr = mciSendString("set movie time format frames", 0, 0, 0)
lErr = mciSendString("play movie from " & GetPositionInFrames + lFrames, 0, 0, 0)
End Function

Public Function ForwardByMS(lMilleseconds As Long)
'On Local Error Resume Next
lErr = mciSendString("set movie time format ms", 0, 0, 0)
lErr = mciSendString("play movie from " & GetPositionInMS + lMilleseconds, 0, 0, 0)
End Function

Public Function ForwardBySeconds(lSeconds As Long)
'On Local Error Resume Next
lErr = mciSendString("set movie time format ms", 0, 0, 0)
lErr = mciSendString("play movie from " & GetPositionInMS + 1000 * lSeconds, 0, 0, 0)
End Function

Public Function CheckDeviceReady() As String
'On Local Error Resume Next
lErr = mciSendString("status movie ready", lData, 128, 0)
CheckDeviceReady = lData
End Function

Public Function SetSpeed(lValue As Long)
'On Local Error Resume Next
lErr = mciSendString("set movie speed " & lValue, 0, 0, 0)
End Function

Public Function SetLeftVolume(lValue As Long)
'On Local Error Resume Next
lErr = mciSendString("setaudio movie left volume to " & lValue, 0, 0, 0)
End Function

Public Function SetRightVolume(lValue As Long)
'On Local Error Resume Next
lErr = mciSendString("setaudio movie right volume to " & lValue, 0, 0, 0)
End Function

Public Sub TimeOut(duration)
'On Local Error Resume Next
Dim l As Long, o As Long
l = Timer
Do While Timer - l < duration
    o = DoEvents()
Loop
Exit Sub
End Sub
