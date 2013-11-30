VERSION 5.00
Begin VB.UserControl ctlAcidmaxPlayer 
   ClientHeight    =   720
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   1020
   ScaleHeight     =   720
   ScaleWidth      =   1020
   Begin VB.Frame P 
      BorderStyle     =   0  'None
      Height          =   495
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   615
   End
   Begin VB.Menu mnuControlMenu 
      Caption         =   "<Control Menu>"
      Begin VB.Menu mnuPlay 
         Caption         =   "Play"
      End
      Begin VB.Menu mnuStop 
         Caption         =   "Stop"
      End
      Begin VB.Menu mnuPause 
         Caption         =   "Pause"
      End
      Begin VB.Menu mnuResume 
         Caption         =   "Resume"
      End
      Begin VB.Menu mnuSep1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuMute 
         Caption         =   "Mute"
      End
      Begin VB.Menu mnuUnmute 
         Caption         =   "Un-Mute"
      End
      Begin VB.Menu mnuSep2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuOpenCDDoor 
         Caption         =   "Open CD Door"
      End
      Begin VB.Menu mnuCloseCDDoor 
         Caption         =   "Close CD Door"
      End
      Begin VB.Menu mnuSep3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuForward 
         Caption         =   "Forward"
      End
      Begin VB.Menu mnuRewind 
         Caption         =   "Rewind"
      End
      Begin VB.Menu mnuPosition 
         Caption         =   "Position"
      End
   End
End
Attribute VB_Name = "ctlAcidmaxPlayer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private MM As New clsMovieModule
Public Event AGClick()
Public Event AGDoubleClick()
Public Event AGRightClick()
Public Event AGMovieOpened(lFilename As String)
Public Event AGMovieClosed()
Public Event AGMovieStopped()
Public Event AGMoviePaused()
Public Event AGMovieResumed()
Public Event AGMoviePlay()
Public Event AGMouseMove(lLeft As Integer, lTop As Integer)
Enum eStatus
    sIdle = 0
    sPlaying = 1
    sOpen = 2
    sPaused = 3
    sStopped = 4
    sError = 5
End Enum
Private lStatus As eStatus
Private lBlackDropSide As Integer
Private lBlackDropSide2 As Integer
Private lBlackDropBottom As Integer
Private lBlackDropTop As Integer

Public Sub SetMovieWindowByhWnd(lHwnd As Long)
'On Local Error GoTo ErrHandler
If lHwnd <> 0 Then MM.SetMovieWindow lHwnd
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function GetStatus() As eStatus
'On Local Error GoTo ErrHandler
GetStatus = lStatus
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Sub Mute(lToggle As Boolean)
'On Local Error GoTo ErrHandler
If lToggle = True Then
    MM.SetAudioOn
Else
    MM.SetAudioOff
End If
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub OpenCDDoor()
'On Local Error GoTo ErrHandler
MM.SetDoorOpen
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Sub CloseDoor()
'On Local Error GoTo ErrHandler
MM.SetDoorClosed
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function GetVolume() As String
'On Local Error GoTo ErrHandler
GetVolume = MM.GetVolume
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Function GetFramesPerSecond() As String
'On Local Error GoTo ErrHandler
GetFramesPerSecond = MM.GetFramePerSecRate
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Function RewindSeconds(lNumSeconds As Long) As String
'On Local Error GoTo ErrHandler
MM.RewindBySeconds lNumSeconds
RewindSeconds = MM.GetStatus
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Function ForwardSeconds(lNumSeconds As Long) As String
'On Local Error Resume Next
MM.ForwardBySeconds lNumSeconds
ForwardSeconds = MM.GetStatus
End Function

Public Function ForwardFrames(lNumFrames As Long) As String
'On Local Error Resume Next
MM.ForwardByFrames lNumFrames
GoForwardFrames = MM.GetStatus
End Function

Public Function RewindFrames(lNumFrames As Long) As String
'On Local Error Resume Next
MM.RewindByFrames lNumFrames
RewindFrames = MM.GetStatus
End Function

Public Sub FullScreen()
'On Local Error Resume Next
MM.PlayFullScreen
End Sub

Public Function SetSize(lLeft As Long, lTop As Long, lWidth As Long, lHeight As Long) As String
'On Local Error Resume Next
MM.SizeLocateMovie lLeft, lTop, lWidth, lHeight
SetSize = MM.CheckError
End Function

Public Function CloseMovie() As String
'On Local Error GoTo ErrHandler
MM.CloseMovie
CloseMovie = MM.GetStatus
lStatus = sIdle
RaiseEvent AGMovieClosed
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Function OpenMovie(lFilename As String) As String
'On Local Error GoTo ErrHandler
If Len(lFilename) <> 0 Then
    MM.lFilename = lFilename
    MM.OpenMovieWindow P.hWnd, "child"
    OpenMovie = MM.GetStatus
    OpenMovie = MM.GetStatus
    RaiseEvent AGMovieOpened(lFilename)
    lStatus = sOpen
End If
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Sub SetBlackDrop(lTopMargin As Integer, lSideMargin As Integer, lSideMargin2 As Integer, lBottomMargin As Integer)
'On Local Error GoTo ErrHandler
lBlackDropBottom = lBottomMargin
lBlackDropTop = lTopMargin
lBlackDropSide = lSideMargin
lBlackDropSide2 = lSideMargin2
UserControl_Resize
Exit Sub
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Sub

Public Function ResumeMovie() As String
'On Local Error GoTo ErrHandler
MM.ResumeMovie
MM.TimeOut 1
ResumeMovie = MM.GetStatus
lStatus = sPlaying
RaiseEvent AGMovieResumed
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Function PauseMovie() As String
'On Local Error GoTo ErrHandler
MM.PauseMovie
MM.TimeOut 1
PauseMovie = MM.GetStatus
RaiseEvent AGMoviePaused
lStatus = sPaused
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Function SetVolume(lVolume As Long) As String
'On Local Error GoTo ErrHandler
MM.SetVolume lVolume
SetVolume = MM.GetStatus
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Function PlayMovie() As String
'On Local Error GoTo ErrHandler
MM.PlayMovie
MM.TimeOut 0.5
PlayMovie = MM.GetStatus
lStatus = sPlaying
RaiseEvent AGMoviePlay
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Function StopMovie() As String
'On Local Error GoTo ErrHandler
MM.StopMovie
StopMovie = MM.GetStatus
RaiseEvent AGMovieStopped
lStatus = sStopped
Exit Function
ErrHandler:
    MsgBox Err.Description
    Err.Clear
End Function

Public Function ChangeMoviePosition(lSecond As Long) As String
'On Local Error Resume Next
MM.SetPositionTo lSecond
ChangeMoviePosition = MM.GetStatus
End Function

Public Function ReturnMovieFrames() As Long
'On Local Error Resume Next
ReturnMovieFrames = MM.GetLengthInFrames
End Function

Public Function ReturnTotalSeconds() As Long
'On Local Error Resume Next
ReturnTotalSeconds = MM.GetLengthInSec
End Function

Public Function ReturnCurrentPosition() As Long
'On Local Error Resume Next
ReturnCurrentPosition = MM.GetPositionInSec
End Function

Public Function ChangePlayRate(lValue As Long)
'On Local Error Resume Next
MM.SetSpeed lValue
ChangePlayRate = MM.GetStatus
End Function

Private Sub mnuCloseCDDoor_Click()
'On Local Error Resume Next
CloseDoor
End Sub

Private Sub mnuForward_Click()
Dim lSec As Long
lSec = InputBox("Forward How Many Seconds?", "Forward")
ForwardSeconds lSec
End Sub

Private Sub mnuMute_Click()
'On Local Error Resume Next
Mute True
End Sub

Private Sub mnuOpenCDDoor_Click()
'On Local Error Resume Next
OpenCDDoor
End Sub

Private Sub mnuPause_Click()
'On Local Error Resume Next
PauseMovie
End Sub

Private Sub mnuPlay_Click()
'On Local Error Resume Next
PlayMovie
End Sub

Private Sub mnuPosition_Click()
Dim lPos As Long
lPos = InputBox("Enter Position in Seconds")
ChangeMoviePosition lPos
End Sub

Private Sub mnuResume_Click()
'On Local Error Resume Next
ResumeMovie
End Sub

Private Sub mnuRewind_Click()
Dim lSec As Long
lSec = InputBox("Enter Number of Seconds to Rewind")
RewindSeconds lSec
End Sub

Private Sub mnuStop_Click()
'On Local Error Resume Next
StopMovie
End Sub

Private Sub mnuUnmute_Click()
'On Local Error Resume Next
Mute False
End Sub

Private Sub P_Click()
'On Local Error Resume Next
RaiseEvent AGClick
End Sub

Private Sub P_DblClick()
'On Local Error Resume Next
RaiseEvent AGDoubleClick
End Sub

Public Sub P_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
If Button = 2 Then RaiseEvent AGRightClick
End Sub

Private Sub P_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
RaiseEvent AGMouseMove(Int(X), Int(Y))
End Sub

Private Sub UserControl_DblClick()
'On Local Error Resume Next
RaiseEvent AGDoubleClick
End Sub

Private Sub UserControl_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'On Local Error Resume Next
If Button = 2 Then RaiseEvent AGRightClick
End Sub

Private Sub UserControl_Resize()
'On Local Error Resume Next
If lBlackDropSide <> 0 Then
    P.Left = lBlackDropSide
    P.Width = UserControl.ScaleWidth - (P.Left + lBlackDropSide2)
    If lBlackDropTop <> 0 Then
        P.Top = lBlackDropTop
        If lBlackDropBottom <> 0 Then
            P.Height = UserControl.ScaleHeight - (lBlackDropTop + lBlackDropBottom)
        Else
            P.Height = UserControl.ScaleHeight - lBlackDropTop
        End If
    End If

Else
    P.Width = UserControl.ScaleWidth
    P.Height = UserControl.ScaleHeight
End If
'SetSize P.left, P.top, P.Width, P.Height
End Sub

Private Sub UserControl_Terminate()
'On Local Error Resume Next
MM.CloseMovie
End Sub
