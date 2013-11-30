VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsAcidmaxPlayer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Private Declare Function CoFreeUnusedLibraries Lib "ole32" () As Long

Private Sub Class_Initialize()
'On Local Error GoTo ErrHandler

Exit Sub
ErrHandler:
    Err.Clear
End Sub

Public Sub ActivateFServe(lData As String)
'On Local Error GoTo ErrHandler
Dim msg() As String, i As Integer
msg() = Split(lData, " ")
For i = 0 To UBound(msg)
    MsgBox msg(i)
Next i
Exit Sub
ErrHandler:
    Err.Clear
End Sub

Public Sub StartAcidmaxPlayer(lData As String)
On Local Error GoTo ErrHandler
Dim msg() As String, msg2 As String, i As Integer, lMainHwnd As Long, lEXE As String
msg = Split(lData, " :")
For i = 0 To UBound(msg)
    If Len(msg(i)) <> 0 Then
        msg2 = Trim(msg(i))
        Select Case i
        Case 0
            lMainHwnd = Trim(CLng(msg2))
        Case 1
            lEXE = Trim(msg2)
        End Select
    End If
Next i
SetAcidmaxEXE lEXE
'SetParentHwnd CLng(Trim(lMainHwnd))
InitMainForm
Exit Sub
ErrHandler:
    Err.Clear
End Sub

'Public Sub TriggerResize(lData As String)
'On Local Error GoTo ErrHandler
'Exit Sub
'ErrHandler:
'    Err.Clear
'End Sub

'Public Sub PromptPlayback(lData As String)
'On Local Error GoTo ErrHandler
'frmMain.PromptPlay
'Exit Sub
'ErrHandler:
'    Err.Clear
'End Sub

'Public Sub StopPlayback(lData As String)
'On Local Error GoTo ErrHandler
'frmMain.ctlMovie.StopMovie
'Exit Sub
'ErrHandler:
'    Err.Clear
'End Sub

'Public Sub PausePlayback(lData As String)
'On Local Error GoTo ErrHandler
'frmMain.ctlMovie.PauseMovie
'Exit Sub
'ErrHandler:
'    Err.Clear
'End Sub

Private Sub Class_Terminate()
On Local Error GoTo ErrHandler
CoFreeUnusedLibraries
Exit Sub
ErrHandler:
    Err.Clear
End Sub
