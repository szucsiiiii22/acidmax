Attribute VB_Name = "mdlTetris"
Option Explicit
Private Declare Function sndPlaySound Lib "winmm.dll" Alias "sndPlaySoundA" (ByVal lpszSoundName As String, ByVal uFlags As Long) As Long
Private Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uReturnLength As Integer, ByVal hwndCallback As Integer) As Long

Public Sub PlayMid(sFilename As String)
Dim returnstring As String * 128, i%, CommandString, a&
returnstring = Space(128)
For i% = 1 To 3
 Select Case i%
  Case 1
   CommandString = "close mymid"
  Case 2
   CommandString = "open " & sFilename & _
   " type sequencer alias mymid"
  Case 3
   'CommandString = "play mymid from 1"
 End Select
 a& = mciSendString _
 (CommandString, returnstring, Len(returnstring), 0)
Next i%
End Sub

Sub PlayAgain()
Dim returnstring As String * 128, CommandString, a&
returnstring = Space(128)
CommandString = "play mymid from 1"
 a& = mciSendString _
 (CommandString, returnstring, Len(returnstring), 0)

End Sub
Public Sub StopMid()

Dim returnstring As String * 128, CommandString, a&
returnstring = Space(128)

CommandString = "close mymid"

a& = mciSendString _
(CommandString, returnstring, Len(returnstring), 0)

CommandString = "close mymid1"

a& = mciSendString _
(CommandString, returnstring, Len(returnstring), 0)


End Sub
Public Sub PlayWav(sFilename As String)
Dim X&
X& = sndPlaySound(sFilename, 1)

End Sub


Public Sub Delay(secs As Single)
Dim kkk, ttt
kkk = Timer
Do While Int((ttt - kkk) * 1000) < (secs * 1000)
ttt = Timer
DoEvents
Loop
End Sub
Public Sub PlayMid1(sFilename As String)
Dim returnstring As String * 128, i%, CommandString, a&
returnstring = Space(128)
For i% = 1 To 3
 Select Case i%
  Case 1
   CommandString = "close mymid1"
  Case 2
   CommandString = "open " & sFilename & _
   " type sequencer alias mymid1"
  Case 3
   'CommandString = "play mymid1 from 1"
 End Select
 a& = mciSendString _
 (CommandString, returnstring, Len(returnstring), 0)
Next i%
End Sub

Sub PlayAgain1()
Dim returnstring As String * 128, CommandString, a&
returnstring = Space(128)
CommandString = "play mymid1 from 1"
 a& = mciSendString _
 (CommandString, returnstring, Len(returnstring), 0)
End Sub
